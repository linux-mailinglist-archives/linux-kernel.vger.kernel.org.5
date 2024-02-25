Return-Path: <linux-kernel+bounces-79933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4ED8628D3
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 03:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B68E1C20CD3
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 02:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DB1DDD5;
	Sun, 25 Feb 2024 02:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dGAOx/GL"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FAE8C07
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 02:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708828722; cv=none; b=j/KEA38oBQjiVCt+OIXqGbkVroaKfFTo3ahmTKgrq3BNRtuw+qBJY0+41rfDUfwf5IAP0ygL5JmYaN9fR6PHzEhyHResE6+HDVXF9Jajvz89HfTz1FL2naecJ+eby2FnmM4beeJL6yBX+8lvQ0DTt1gJ23uGJfSm1vdgZrOhsGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708828722; c=relaxed/simple;
	bh=WhdKHqtzSdKzXSywa8/Kdpjd1qyDu5Tei06epJX7qUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SbvhgwpQyS/hhx0M/Nyss3j5HswQZoi64SxpRsXwvx2YB9LHMBy/Jb3s+381NkMJJW7kz3Pmk+tFjDYweQjl1U5yaC7jl65TTH3rUnHcC11bDPRgxKFk9hAoRaV++ce+YMD/jLx3V17WYm2OnzGBKJEJorqwntjGpdGmLxZAugc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dGAOx/GL; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708828718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DrOHx5wMYDRZo/YqdsvPnCBIdET0WVtHDJeAbRuqJI0=;
	b=dGAOx/GLUxtEdliB0UdEMTiotkvOejJNPfJ61o3fMSJjoewuwiT3emDwd6XodW30MavCZb
	jB3slYjO1Uy9H72d5KMb9yXufezoiKDtmz1+I1cAzdDELRlh7FrPEa/l37qal7/ruDAtS/
	9hYMIPbSuygjbJL+DJPEvhfCmIdEQ1o=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	djwong@kernel.org,
	bfoster@redhat.com
Subject: [PATCH 05/21] bcachefs: dev_usage updated by new accounting
Date: Sat, 24 Feb 2024 21:38:07 -0500
Message-ID: <20240225023826.2413565-6-kent.overstreet@linux.dev>
In-Reply-To: <20240225023826.2413565-1-kent.overstreet@linux.dev>
References: <20240225023826.2413565-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Reading disk accounting now requires an eytzinger lookup (see:
bch2_accounting_mem_read()), but the per-device counters are used
frequently enough that we'd like to still be able to read them with just
a percpu sum, as in the old code.

This patch special cases the device counters; when we update in-memory
accounting we also update the old style percpu counters if it's a deice
counter update.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/bcachefs/bcachefs.h        |  3 +--
 fs/bcachefs/btree_gc.c        |  2 +-
 fs/bcachefs/buckets.c         | 36 +++++------------------------------
 fs/bcachefs/buckets_types.h   |  2 +-
 fs/bcachefs/disk_accounting.c | 14 ++++++++++++++
 fs/bcachefs/disk_accounting.h | 11 ++++++++++-
 fs/bcachefs/recovery.c        | 14 --------------
 fs/bcachefs/sb-clean.c        | 17 -----------------
 8 files changed, 32 insertions(+), 67 deletions(-)

diff --git a/fs/bcachefs/bcachefs.h b/fs/bcachefs/bcachefs.h
index 18c00051a8f6..91c40fde1925 100644
--- a/fs/bcachefs/bcachefs.h
+++ b/fs/bcachefs/bcachefs.h
@@ -576,8 +576,7 @@ struct bch_dev {
 	unsigned long		*buckets_nouse;
 	struct rw_semaphore	bucket_lock;
 
-	struct bch_dev_usage		*usage_base;
-	struct bch_dev_usage __percpu	*usage[JOURNAL_BUF_NR];
+	struct bch_dev_usage __percpu	*usage;
 	struct bch_dev_usage __percpu	*usage_gc;
 
 	/* Allocator: */
diff --git a/fs/bcachefs/btree_gc.c b/fs/bcachefs/btree_gc.c
index 2dfa7ca95fc0..93826749356e 100644
--- a/fs/bcachefs/btree_gc.c
+++ b/fs/bcachefs/btree_gc.c
@@ -1233,7 +1233,7 @@ static int bch2_gc_done(struct bch_fs *c,
 		bch2_fs_usage_acc_to_base(c, i);
 
 	__for_each_member_device(c, ca) {
-		struct bch_dev_usage *dst = ca->usage_base;
+		struct bch_dev_usage *dst = this_cpu_ptr(ca->usage);
 		struct bch_dev_usage *src = (void *)
 			bch2_acc_percpu_u64s((u64 __percpu *) ca->usage_gc,
 					     dev_usage_u64s());
diff --git a/fs/bcachefs/buckets.c b/fs/bcachefs/buckets.c
index fb915c1b7844..7540486ae266 100644
--- a/fs/bcachefs/buckets.c
+++ b/fs/bcachefs/buckets.c
@@ -69,15 +69,8 @@ void bch2_fs_usage_initialize(struct bch_fs *c)
 
 void bch2_dev_usage_read_fast(struct bch_dev *ca, struct bch_dev_usage *usage)
 {
-	struct bch_fs *c = ca->fs;
-	unsigned seq, i, u64s = dev_usage_u64s();
-
-	do {
-		seq = read_seqcount_begin(&c->usage_lock);
-		memcpy(usage, ca->usage_base, u64s * sizeof(u64));
-		for (i = 0; i < ARRAY_SIZE(ca->usage); i++)
-			acc_u64s_percpu((u64 *) usage, (u64 __percpu *) ca->usage[i], u64s);
-	} while (read_seqcount_retry(&c->usage_lock, seq));
+	memset(usage, 0, sizeof(*usage));
+	acc_u64s_percpu((u64 *) usage, (u64 __percpu *) ca->usage, dev_usage_u64s());
 }
 
 u64 bch2_fs_usage_read_one(struct bch_fs *c, u64 *v)
@@ -147,16 +140,6 @@ void bch2_fs_usage_acc_to_base(struct bch_fs *c, unsigned idx)
 			(u64 __percpu *) c->usage[idx], u64s);
 	percpu_memset(c->usage[idx], 0, u64s * sizeof(u64));
 
-	rcu_read_lock();
-	for_each_member_device_rcu(c, ca, NULL) {
-		u64s = dev_usage_u64s();
-
-		acc_u64s_percpu((u64 *) ca->usage_base,
-				(u64 __percpu *) ca->usage[idx], u64s);
-		percpu_memset(ca->usage[idx], 0, u64s * sizeof(u64));
-	}
-	rcu_read_unlock();
-
 	write_seqcount_end(&c->usage_lock);
 	preempt_enable();
 }
@@ -1214,23 +1197,14 @@ void bch2_dev_buckets_free(struct bch_dev *ca)
 {
 	kvfree(ca->buckets_nouse);
 	kvfree(rcu_dereference_protected(ca->bucket_gens, 1));
-
-	for (unsigned i = 0; i < ARRAY_SIZE(ca->usage); i++)
-		free_percpu(ca->usage[i]);
-	kfree(ca->usage_base);
+	free_percpu(ca->usage);
 }
 
 int bch2_dev_buckets_alloc(struct bch_fs *c, struct bch_dev *ca)
 {
-	ca->usage_base = kzalloc(sizeof(struct bch_dev_usage), GFP_KERNEL);
-	if (!ca->usage_base)
+	ca->usage = alloc_percpu(struct bch_dev_usage);
+	if (!ca->usage)
 		return -BCH_ERR_ENOMEM_usage_init;
 
-	for (unsigned i = 0; i < ARRAY_SIZE(ca->usage); i++) {
-		ca->usage[i] = alloc_percpu(struct bch_dev_usage);
-		if (!ca->usage[i])
-			return -BCH_ERR_ENOMEM_usage_init;
-	}
-
 	return bch2_dev_buckets_resize(c, ca, ca->mi.nbuckets);
 }
diff --git a/fs/bcachefs/buckets_types.h b/fs/bcachefs/buckets_types.h
index 6a31740222a7..baa7e0924390 100644
--- a/fs/bcachefs/buckets_types.h
+++ b/fs/bcachefs/buckets_types.h
@@ -33,7 +33,7 @@ struct bucket_gens {
 };
 
 struct bch_dev_usage {
-	struct {
+	struct bch_dev_usage_type {
 		u64		buckets;
 		u64		sectors; /* _compressed_ sectors: */
 		/*
diff --git a/fs/bcachefs/disk_accounting.c b/fs/bcachefs/disk_accounting.c
index 327c586ac661..e0114d8eb5a8 100644
--- a/fs/bcachefs/disk_accounting.c
+++ b/fs/bcachefs/disk_accounting.c
@@ -330,6 +330,20 @@ int bch2_accounting_read(struct bch_fs *c)
 		case BCH_DISK_ACCOUNTING_replicas:
 			fs_usage_data_type_to_base(usage, k.replicas.data_type, v[0]);
 			break;
+		case BCH_DISK_ACCOUNTING_dev_data_type:
+			if (bch2_dev_exists2(c, k.dev_data_type.dev)) {
+				struct bch_dev *ca = bch_dev_bkey_exists(c, k.dev_data_type.dev);
+				struct bch_dev_usage_type __percpu *d = &ca->usage->d[k.dev_data_type.data_type];
+
+				percpu_u64_set(&d->buckets,	v[0]);
+				percpu_u64_set(&d->sectors,	v[1]);
+				percpu_u64_set(&d->fragmented,	v[2]);
+
+				if (k.dev_data_type.data_type == BCH_DATA_sb ||
+				    k.dev_data_type.data_type == BCH_DATA_journal)
+					usage->hidden += v[0] * ca->mi.bucket_size;
+			}
+			break;
 		}
 	}
 	preempt_enable();
diff --git a/fs/bcachefs/disk_accounting.h b/fs/bcachefs/disk_accounting.h
index 5fd053a819df..a8526bf43207 100644
--- a/fs/bcachefs/disk_accounting.h
+++ b/fs/bcachefs/disk_accounting.h
@@ -3,6 +3,7 @@
 #define _BCACHEFS_DISK_ACCOUNTING_H
 
 #include <linux/eytzinger.h>
+#include "sb-members.h"
 
 static inline void bch2_u64s_neg(u64 *v, unsigned nr)
 {
@@ -126,6 +127,7 @@ static inline int __bch2_accounting_mem_add(struct bch_fs *c, struct bkey_s_c_ac
 
 static inline int bch2_accounting_mem_add(struct btree_trans *trans, struct bkey_s_c_accounting a)
 {
+	struct bch_fs *c = trans->c;
 	struct disk_accounting_key acc_k;
 	bpos_to_disk_accounting_key(&acc_k, a.k->p);
 
@@ -136,8 +138,15 @@ static inline int bch2_accounting_mem_add(struct btree_trans *trans, struct bkey
 	case BCH_DISK_ACCOUNTING_replicas:
 		fs_usage_data_type_to_base(&trans->fs_usage_delta, acc_k.replicas.data_type, a.v->d[0]);
 		break;
+	case BCH_DISK_ACCOUNTING_dev_data_type: {
+		struct bch_dev *ca = bch_dev_bkey_exists(c, acc_k.dev_data_type.dev);
+
+		this_cpu_add(ca->usage->d[acc_k.dev_data_type.data_type].buckets, a.v->d[0]);
+		this_cpu_add(ca->usage->d[acc_k.dev_data_type.data_type].sectors, a.v->d[1]);
+		this_cpu_add(ca->usage->d[acc_k.dev_data_type.data_type].fragmented, a.v->d[2]);
+	}
 	}
-	return __bch2_accounting_mem_add(trans->c, a);
+	return __bch2_accounting_mem_add(c, a);
 }
 
 static inline void bch2_accounting_mem_read_counters(struct bch_fs *c,
diff --git a/fs/bcachefs/recovery.c b/fs/bcachefs/recovery.c
index 140393256f32..5a0ab3920382 100644
--- a/fs/bcachefs/recovery.c
+++ b/fs/bcachefs/recovery.c
@@ -368,20 +368,6 @@ static int journal_replay_entry_early(struct bch_fs *c,
 					      le64_to_cpu(u->v));
 		break;
 	}
-	case BCH_JSET_ENTRY_dev_usage: {
-		struct jset_entry_dev_usage *u =
-			container_of(entry, struct jset_entry_dev_usage, entry);
-		struct bch_dev *ca = bch_dev_bkey_exists(c, le32_to_cpu(u->dev));
-		unsigned i, nr_types = jset_entry_dev_usage_nr_types(u);
-
-		for (i = 0; i < min_t(unsigned, nr_types, BCH_DATA_NR); i++) {
-			ca->usage_base->d[i].buckets	= le64_to_cpu(u->d[i].buckets);
-			ca->usage_base->d[i].sectors	= le64_to_cpu(u->d[i].sectors);
-			ca->usage_base->d[i].fragmented	= le64_to_cpu(u->d[i].fragmented);
-		}
-
-		break;
-	}
 	case BCH_JSET_ENTRY_blacklist: {
 		struct jset_entry_blacklist *bl_entry =
 			container_of(entry, struct jset_entry_blacklist, entry);
diff --git a/fs/bcachefs/sb-clean.c b/fs/bcachefs/sb-clean.c
index 5980ba2563fe..a7f2cc774492 100644
--- a/fs/bcachefs/sb-clean.c
+++ b/fs/bcachefs/sb-clean.c
@@ -228,23 +228,6 @@ void bch2_journal_super_entries_add_common(struct bch_fs *c,
 			      "embedded variable length struct");
 	}
 
-	for_each_member_device(c, ca) {
-		unsigned b = sizeof(struct jset_entry_dev_usage) +
-			sizeof(struct jset_entry_dev_usage_type) * BCH_DATA_NR;
-		struct jset_entry_dev_usage *u =
-			container_of(jset_entry_init(end, b),
-				     struct jset_entry_dev_usage, entry);
-
-		u->entry.type = BCH_JSET_ENTRY_dev_usage;
-		u->dev = cpu_to_le32(ca->dev_idx);
-
-		for (unsigned i = 0; i < BCH_DATA_NR; i++) {
-			u->d[i].buckets = cpu_to_le64(ca->usage_base->d[i].buckets);
-			u->d[i].sectors	= cpu_to_le64(ca->usage_base->d[i].sectors);
-			u->d[i].fragmented = cpu_to_le64(ca->usage_base->d[i].fragmented);
-		}
-	}
-
 	percpu_up_read(&c->mark_lock);
 
 	for (unsigned i = 0; i < 2; i++) {
-- 
2.43.0


