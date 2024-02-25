Return-Path: <linux-kernel+bounces-79939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D30E68628DA
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 03:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8928A28163C
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 02:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A831640B;
	Sun, 25 Feb 2024 02:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="A3/4XoC1"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DCFFC12
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 02:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708828727; cv=none; b=tsZI5o4MT4aHmR8lkeNNb+6yEmATpiefMnFKRgM5wuaTbkx4vjK0kTMAplGs3Qi4fNNYm7DNs5Nt7GKqPuDnoN5Ad2noZoVOR2cwitQQKQN+PFS3Mv7tBTjSPe5lCYnXmcwBqqRY9sb7JtYwMBlLyOxYSGBJlkpjYaTBqc5vRcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708828727; c=relaxed/simple;
	bh=4ofseTkI0NYTSy2SqN8qmDFsYCyfnkox/iwtJ5pAAVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZutdYWYH7tqlUoJKEGttJCZnElpq16clbPPfgkiCQyXMUnEArDgvjHRgBzPNmtf+2yMvMX3e5JTS5AhH1yRIOBGraZGGFhIfsloeT6C9uUb18YQWYIRNhCqoeuy3iHDk95S998tj7a8zTIKRWJwsgRtDLgd0cdzsUPFFgPyjqfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=A3/4XoC1; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708828723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=feltRpT2GfQrxVlgaHX2FneBv3ceqjBYGcQemtXMFOY=;
	b=A3/4XoC1dWRBf8ZzMlzDrBAEbZBt1AXPOutmDEPLieM+m75bBVp0nfoXVGtjp/bKQZRPpK
	1CM8EAimSlVXFd7fO+2g2cg1EF2iHD7bbfpacZ0GjORDwdXORqRvt4iXXPLyrWv0Q+AZGo
	xSg8KXEbYVzTw1FmzAaSexVFA59CH5A=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	djwong@kernel.org,
	bfoster@redhat.com
Subject: [PATCH 10/21] bcachefs: Delete journal-buf-sharded old style accounting
Date: Sat, 24 Feb 2024 21:38:12 -0500
Message-ID: <20240225023826.2413565-11-kent.overstreet@linux.dev>
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

More deletion of dead code.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/bcachefs/bcachefs.h        |  3 +-
 fs/bcachefs/btree_gc.c        |  9 ++---
 fs/bcachefs/buckets.c         | 61 ++++-----------------------------
 fs/bcachefs/buckets.h         |  4 ---
 fs/bcachefs/disk_accounting.c |  2 +-
 fs/bcachefs/recovery.c        | 20 +----------
 fs/bcachefs/replicas.c        | 63 +++--------------------------------
 fs/bcachefs/replicas.h        |  4 ---
 fs/bcachefs/super.c           |  2 ++
 9 files changed, 21 insertions(+), 147 deletions(-)

diff --git a/fs/bcachefs/bcachefs.h b/fs/bcachefs/bcachefs.h
index 5824cf57defd..2e7c4d10c951 100644
--- a/fs/bcachefs/bcachefs.h
+++ b/fs/bcachefs/bcachefs.h
@@ -907,8 +907,7 @@ struct bch_fs {
 	struct percpu_rw_semaphore	mark_lock;
 
 	seqcount_t			usage_lock;
-	struct bch_fs_usage		*usage_base;
-	struct bch_fs_usage __percpu	*usage[JOURNAL_BUF_NR];
+	struct bch_fs_usage_base __percpu *usage;
 	struct bch_fs_usage __percpu	*usage_gc;
 	u64 __percpu		*online_reserved;
 
diff --git a/fs/bcachefs/btree_gc.c b/fs/bcachefs/btree_gc.c
index 93826749356e..15a8796197f3 100644
--- a/fs/bcachefs/btree_gc.c
+++ b/fs/bcachefs/btree_gc.c
@@ -1229,10 +1229,8 @@ static int bch2_gc_done(struct bch_fs *c,
 #define copy_fs_field(_err, _f, _msg, ...)				\
 	copy_field(_err, _f, "fs has wrong " _msg, ##__VA_ARGS__)
 
-	for (i = 0; i < ARRAY_SIZE(c->usage); i++)
-		bch2_fs_usage_acc_to_base(c, i);
-
 	__for_each_member_device(c, ca) {
+		/* XXX */
 		struct bch_dev_usage *dst = this_cpu_ptr(ca->usage);
 		struct bch_dev_usage *src = (void *)
 			bch2_acc_percpu_u64s((u64 __percpu *) ca->usage_gc,
@@ -1249,8 +1247,10 @@ static int bch2_gc_done(struct bch_fs *c,
 	}
 
 	{
+#if 0
 		unsigned nr = fs_usage_u64s(c);
-		struct bch_fs_usage *dst = c->usage_base;
+		/* XX: */
+		struct bch_fs_usage *dst = this_cpu_ptr(c->usage);
 		struct bch_fs_usage *src = (void *)
 			bch2_acc_percpu_u64s((u64 __percpu *) c->usage_gc, nr);
 
@@ -1290,6 +1290,7 @@ static int bch2_gc_done(struct bch_fs *c,
 			copy_fs_field(fs_usage_replicas_wrong,
 				      replicas[i], "%s", buf.buf);
 		}
+#endif
 	}
 
 #undef copy_fs_field
diff --git a/fs/bcachefs/buckets.c b/fs/bcachefs/buckets.c
index 24b53f449313..8476bd5cb3af 100644
--- a/fs/bcachefs/buckets.c
+++ b/fs/bcachefs/buckets.c
@@ -26,61 +26,12 @@
 
 #include <linux/preempt.h>
 
-static inline struct bch_fs_usage *fs_usage_ptr(struct bch_fs *c,
-						unsigned journal_seq,
-						bool gc)
-{
-	percpu_rwsem_assert_held(&c->mark_lock);
-	BUG_ON(!gc && !journal_seq);
-
-	return this_cpu_ptr(gc
-			    ? c->usage_gc
-			    : c->usage[journal_seq & JOURNAL_BUF_MASK]);
-}
-
 void bch2_dev_usage_read_fast(struct bch_dev *ca, struct bch_dev_usage *usage)
 {
 	memset(usage, 0, sizeof(*usage));
 	acc_u64s_percpu((u64 *) usage, (u64 __percpu *) ca->usage, dev_usage_u64s());
 }
 
-u64 bch2_fs_usage_read_one(struct bch_fs *c, u64 *v)
-{
-	ssize_t offset = v - (u64 *) c->usage_base;
-	unsigned i, seq;
-	u64 ret;
-
-	BUG_ON(offset < 0 || offset >= fs_usage_u64s(c));
-	percpu_rwsem_assert_held(&c->mark_lock);
-
-	do {
-		seq = read_seqcount_begin(&c->usage_lock);
-		ret = *v;
-
-		for (i = 0; i < ARRAY_SIZE(c->usage); i++)
-			ret += percpu_u64_get((u64 __percpu *) c->usage[i] + offset);
-	} while (read_seqcount_retry(&c->usage_lock, seq));
-
-	return ret;
-}
-
-void bch2_fs_usage_acc_to_base(struct bch_fs *c, unsigned idx)
-{
-	unsigned u64s = fs_usage_u64s(c);
-
-	BUG_ON(idx >= ARRAY_SIZE(c->usage));
-
-	preempt_disable();
-	write_seqcount_begin(&c->usage_lock);
-
-	acc_u64s_percpu((u64 *) c->usage_base,
-			(u64 __percpu *) c->usage[idx], u64s);
-	percpu_memset(c->usage[idx], 0, u64s * sizeof(u64));
-
-	write_seqcount_end(&c->usage_lock);
-	preempt_enable();
-}
-
 void bch2_fs_usage_to_text(struct printbuf *out,
 			   struct bch_fs *c,
 			   struct bch_fs_usage_online *fs_usage)
@@ -142,17 +93,17 @@ __bch2_fs_usage_read_short(struct bch_fs *c)
 	u64 data, reserved;
 
 	ret.capacity = c->capacity -
-		bch2_fs_usage_read_one(c, &c->usage_base->b.hidden);
+		percpu_u64_get(&c->usage->hidden);
 
-	data		= bch2_fs_usage_read_one(c, &c->usage_base->b.data) +
-		bch2_fs_usage_read_one(c, &c->usage_base->b.btree);
-	reserved	= bch2_fs_usage_read_one(c, &c->usage_base->b.reserved) +
+	data		= percpu_u64_get(&c->usage->data) +
+		percpu_u64_get(&c->usage->btree);
+	reserved	= percpu_u64_get(&c->usage->reserved) +
 		percpu_u64_get(c->online_reserved);
 
 	ret.used	= min(ret.capacity, data + reserve_factor(reserved));
 	ret.free	= ret.capacity - ret.used;
 
-	ret.nr_inodes	= bch2_fs_usage_read_one(c, &c->usage_base->b.nr_inodes);
+	ret.nr_inodes	= percpu_u64_get(&c->usage->nr_inodes);
 
 	return ret;
 }
@@ -461,7 +412,7 @@ void bch2_trans_account_disk_usage_change(struct btree_trans *trans)
 
 	percpu_down_read(&c->mark_lock);
 	preempt_disable();
-	struct bch_fs_usage_base *dst = &fs_usage_ptr(c, trans->journal_res.seq, false)->b;
+	struct bch_fs_usage_base *dst = this_cpu_ptr(c->usage);
 	struct bch_fs_usage_base *src = &trans->fs_usage_delta;
 
 	s64 added = src->btree + src->data + src->reserved;
diff --git a/fs/bcachefs/buckets.h b/fs/bcachefs/buckets.h
index 356f725a4fad..dfdf1b3ee817 100644
--- a/fs/bcachefs/buckets.h
+++ b/fs/bcachefs/buckets.h
@@ -294,10 +294,6 @@ static inline unsigned dev_usage_u64s(void)
 	return sizeof(struct bch_dev_usage) / sizeof(u64);
 }
 
-u64 bch2_fs_usage_read_one(struct bch_fs *, u64 *);
-
-void bch2_fs_usage_acc_to_base(struct bch_fs *, unsigned);
-
 void bch2_fs_usage_to_text(struct printbuf *,
 			   struct bch_fs *, struct bch_fs_usage_online *);
 
diff --git a/fs/bcachefs/disk_accounting.c b/fs/bcachefs/disk_accounting.c
index e0114d8eb5a8..f898323f72c7 100644
--- a/fs/bcachefs/disk_accounting.c
+++ b/fs/bcachefs/disk_accounting.c
@@ -314,7 +314,7 @@ int bch2_accounting_read(struct bch_fs *c)
 
 	percpu_down_read(&c->mark_lock);
 	preempt_disable();
-	struct bch_fs_usage_base *usage = &c->usage_base->b;
+	struct bch_fs_usage_base *usage = this_cpu_ptr(c->usage);
 
 	for (unsigned i = 0; i < acc->k.nr; i++) {
 		struct disk_accounting_key k;
diff --git a/fs/bcachefs/recovery.c b/fs/bcachefs/recovery.c
index 4936b18e5a58..18fd71960d2e 100644
--- a/fs/bcachefs/recovery.c
+++ b/fs/bcachefs/recovery.c
@@ -344,28 +344,10 @@ static int journal_replay_entry_early(struct bch_fs *c,
 			container_of(entry, struct jset_entry_usage, entry);
 
 		switch (entry->btree_id) {
-		case BCH_FS_USAGE_reserved:
-			if (entry->level < BCH_REPLICAS_MAX)
-				c->usage_base->persistent_reserved[entry->level] =
-					le64_to_cpu(u->v);
-			break;
-		case BCH_FS_USAGE_inodes:
-			c->usage_base->b.nr_inodes = le64_to_cpu(u->v);
-			break;
 		case BCH_FS_USAGE_key_version:
-			atomic64_set(&c->key_version,
-				     le64_to_cpu(u->v));
+			atomic64_set(&c->key_version, le64_to_cpu(u->v));
 			break;
 		}
-
-		break;
-	}
-	case BCH_JSET_ENTRY_data_usage: {
-		struct jset_entry_data_usage *u =
-			container_of(entry, struct jset_entry_data_usage, entry);
-
-		ret = bch2_replicas_set_usage(c, &u->r,
-					      le64_to_cpu(u->v));
 		break;
 	}
 	case BCH_JSET_ENTRY_blacklist: {
diff --git a/fs/bcachefs/replicas.c b/fs/bcachefs/replicas.c
index d02eb03d2ebd..6dca705eaf1f 100644
--- a/fs/bcachefs/replicas.c
+++ b/fs/bcachefs/replicas.c
@@ -318,46 +318,23 @@ static void __replicas_table_update_pcpu(struct bch_fs_usage __percpu *dst_p,
 static int replicas_table_update(struct bch_fs *c,
 				 struct bch_replicas_cpu *new_r)
 {
-	struct bch_fs_usage __percpu *new_usage[JOURNAL_BUF_NR];
 	struct bch_fs_usage __percpu *new_gc = NULL;
-	struct bch_fs_usage *new_base = NULL;
-	unsigned i, bytes = sizeof(struct bch_fs_usage) +
+	unsigned bytes = sizeof(struct bch_fs_usage) +
 		sizeof(u64) * new_r->nr;
 	int ret = 0;
 
-	memset(new_usage, 0, sizeof(new_usage));
-
-	for (i = 0; i < ARRAY_SIZE(new_usage); i++)
-		if (!(new_usage[i] = __alloc_percpu_gfp(bytes,
-					sizeof(u64), GFP_KERNEL)))
-			goto err;
-
-	if (!(new_base = kzalloc(bytes, GFP_KERNEL)) ||
-	    (c->usage_gc &&
+	if ((c->usage_gc &&
 	     !(new_gc = __alloc_percpu_gfp(bytes, sizeof(u64), GFP_KERNEL))))
 		goto err;
 
-	for (i = 0; i < ARRAY_SIZE(new_usage); i++)
-		if (c->usage[i])
-			__replicas_table_update_pcpu(new_usage[i], new_r,
-						     c->usage[i], &c->replicas);
-	if (c->usage_base)
-		__replicas_table_update(new_base,		new_r,
-					c->usage_base,		&c->replicas);
 	if (c->usage_gc)
 		__replicas_table_update_pcpu(new_gc,		new_r,
 					     c->usage_gc,	&c->replicas);
 
-	for (i = 0; i < ARRAY_SIZE(new_usage); i++)
-		swap(c->usage[i],	new_usage[i]);
-	swap(c->usage_base,	new_base);
 	swap(c->usage_gc,	new_gc);
 	swap(c->replicas,	*new_r);
 out:
 	free_percpu(new_gc);
-	for (i = 0; i < ARRAY_SIZE(new_usage); i++)
-		free_percpu(new_usage[i]);
-	kfree(new_base);
 	return ret;
 err:
 	bch_err(c, "error updating replicas table: memory allocation failure");
@@ -544,6 +521,8 @@ int bch2_replicas_gc_start(struct bch_fs *c, unsigned typemask)
  */
 int bch2_replicas_gc2(struct bch_fs *c)
 {
+	return 0;
+#if 0
 	struct bch_replicas_cpu new = { 0 };
 	unsigned i, nr;
 	int ret = 0;
@@ -598,34 +577,7 @@ int bch2_replicas_gc2(struct bch_fs *c)
 	mutex_unlock(&c->sb_lock);
 
 	return ret;
-}
-
-int bch2_replicas_set_usage(struct bch_fs *c,
-			    struct bch_replicas_entry_v1 *r,
-			    u64 sectors)
-{
-	int ret, idx = bch2_replicas_entry_idx(c, r);
-
-	if (idx < 0) {
-		struct bch_replicas_cpu n;
-
-		n = cpu_replicas_add_entry(c, &c->replicas, r);
-		if (!n.entries)
-			return -BCH_ERR_ENOMEM_cpu_replicas;
-
-		ret = replicas_table_update(c, &n);
-		if (ret)
-			return ret;
-
-		kfree(n.entries);
-
-		idx = bch2_replicas_entry_idx(c, r);
-		BUG_ON(ret < 0);
-	}
-
-	c->usage_base->replicas[idx] = sectors;
-
-	return 0;
+#endif
 }
 
 /* Replicas tracking - superblock: */
@@ -1016,11 +968,6 @@ unsigned bch2_dev_has_data(struct bch_fs *c, struct bch_dev *ca)
 
 void bch2_fs_replicas_exit(struct bch_fs *c)
 {
-	unsigned i;
-
-	for (i = 0; i < ARRAY_SIZE(c->usage); i++)
-		free_percpu(c->usage[i]);
-	kfree(c->usage_base);
 	kfree(c->replicas.entries);
 	kfree(c->replicas_gc.entries);
 }
diff --git a/fs/bcachefs/replicas.h b/fs/bcachefs/replicas.h
index f00c586f8cd9..eac2dff20423 100644
--- a/fs/bcachefs/replicas.h
+++ b/fs/bcachefs/replicas.h
@@ -54,10 +54,6 @@ int bch2_replicas_gc_end(struct bch_fs *, int);
 int bch2_replicas_gc_start(struct bch_fs *, unsigned);
 int bch2_replicas_gc2(struct bch_fs *);
 
-int bch2_replicas_set_usage(struct bch_fs *,
-			    struct bch_replicas_entry_v1 *,
-			    u64);
-
 #define for_each_cpu_replicas_entry(_r, _i)				\
 	for (_i = (_r)->entries;					\
 	     (void *) (_i) < (void *) (_r)->entries + (_r)->nr * (_r)->entry_size;\
diff --git a/fs/bcachefs/super.c b/fs/bcachefs/super.c
index a26472f4620a..30b41c8de309 100644
--- a/fs/bcachefs/super.c
+++ b/fs/bcachefs/super.c
@@ -567,6 +567,7 @@ static void __bch2_fs_free(struct bch_fs *c)
 
 	darray_exit(&c->btree_roots_extra);
 	free_percpu(c->pcpu);
+	free_percpu(c->usage);
 	mempool_exit(&c->large_bkey_pool);
 	mempool_exit(&c->btree_bounce_pool);
 	bioset_exit(&c->btree_bio);
@@ -893,6 +894,7 @@ static struct bch_fs *bch2_fs_alloc(struct bch_sb *sb, struct bch_opts opts)
 			    offsetof(struct btree_write_bio, wbio.bio)),
 			BIOSET_NEED_BVECS) ||
 	    !(c->pcpu = alloc_percpu(struct bch_fs_pcpu)) ||
+	    !(c->usage = alloc_percpu(struct bch_fs_usage_base)) ||
 	    !(c->online_reserved = alloc_percpu(u64)) ||
 	    mempool_init_kvmalloc_pool(&c->btree_bounce_pool, 1,
 				       c->opts.btree_node_size) ||
-- 
2.43.0


