Return-Path: <linux-kernel+bounces-79938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 423048628D7
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 03:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3E4B281CDD
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 02:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C21E14A81;
	Sun, 25 Feb 2024 02:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="meWmYrgS"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742E9DDC4
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 02:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708828727; cv=none; b=ntpLDOOePepweODPFlWVv21t9aBxIFRKKKlS0De53hHJ5DU8vnjW/mfeJz8nCKSV/CT9FXB97IVuVVNHube2zDiteJxBkqEZRS4Ac5xb94SipWAODveIZNvwmaC9sEnBYrWRnEq4+ZSUicijmZ+x+3A2xRMmTwrj12GWtu7PThw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708828727; c=relaxed/simple;
	bh=11AZzASOqgnR9hZpIfthFRQECtC3R7F7mXZu7eJ2AyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mE5UrUnhjFZMx0doW7T8nLs9AkBmdIqYIvvr4AjlPoOByLoSG49PB8QyM7naLzSfp2GYfphUYGbKVblFuSZ9PgTqbcUCDZmdJBZoj9/jClQgHtOcocV/JtkhHWKtCWt0sbJRm4nvCOKM1Umu6jqxpZpry4vhML7Orm76n7rnqrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=meWmYrgS; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708828721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Qqw98+K10fXhVd6VHbNJh2AoZpuXWUlc5V3sQ9k6Jk=;
	b=meWmYrgSRX7MdEz5MWTgRZSo+xAxpbBg6J3OUwA3jREQgddOHCPVIsX/otgbLgqfn95uUo
	jqYPtMcBepMrDoWz1yKqjc+kxvFRRz9npzVPvCsdjU8SXxnDWkCX9bO+tC+c3HFhnKcFAl
	UkJ3UDpXsIZsaHCp0REIjBFJIy2VL+c=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	djwong@kernel.org,
	bfoster@redhat.com
Subject: [PATCH 08/21] bcachefs: kill bch2_fs_usage_read()
Date: Sat, 24 Feb 2024 21:38:10 -0500
Message-ID: <20240225023826.2413565-9-kent.overstreet@linux.dev>
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

With bch2_ioctl_fs_usage(), this is now dead code.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/bcachefs/bcachefs.h |  4 ----
 fs/bcachefs/buckets.c  | 34 ----------------------------------
 fs/bcachefs/buckets.h  |  2 --
 fs/bcachefs/chardev.c  | 25 ++++++++++++-------------
 fs/bcachefs/replicas.c |  7 -------
 fs/bcachefs/super.c    |  2 --
 6 files changed, 12 insertions(+), 62 deletions(-)

diff --git a/fs/bcachefs/bcachefs.h b/fs/bcachefs/bcachefs.h
index 91c40fde1925..5824cf57defd 100644
--- a/fs/bcachefs/bcachefs.h
+++ b/fs/bcachefs/bcachefs.h
@@ -912,10 +912,6 @@ struct bch_fs {
 	struct bch_fs_usage __percpu	*usage_gc;
 	u64 __percpu		*online_reserved;
 
-	/* single element mempool: */
-	struct mutex		usage_scratch_lock;
-	struct bch_fs_usage_online *usage_scratch;
-
 	struct io_clock		io_clock[2];
 
 	/* JOURNAL SEQ BLACKLIST */
diff --git a/fs/bcachefs/buckets.c b/fs/bcachefs/buckets.c
index 054c4c8d9c1b..24b53f449313 100644
--- a/fs/bcachefs/buckets.c
+++ b/fs/bcachefs/buckets.c
@@ -64,40 +64,6 @@ u64 bch2_fs_usage_read_one(struct bch_fs *c, u64 *v)
 	return ret;
 }
 
-struct bch_fs_usage_online *bch2_fs_usage_read(struct bch_fs *c)
-{
-	struct bch_fs_usage_online *ret;
-	unsigned nr_replicas = READ_ONCE(c->replicas.nr);
-	unsigned seq, i;
-retry:
-	ret = kmalloc(__fs_usage_online_u64s(nr_replicas) * sizeof(u64), GFP_KERNEL);
-	if (unlikely(!ret))
-		return NULL;
-
-	percpu_down_read(&c->mark_lock);
-
-	if (nr_replicas != c->replicas.nr) {
-		nr_replicas = c->replicas.nr;
-		percpu_up_read(&c->mark_lock);
-		kfree(ret);
-		goto retry;
-	}
-
-	ret->online_reserved = percpu_u64_get(c->online_reserved);
-
-	do {
-		seq = read_seqcount_begin(&c->usage_lock);
-		unsafe_memcpy(&ret->u, c->usage_base,
-			      __fs_usage_u64s(nr_replicas) * sizeof(u64),
-			      "embedded variable length struct");
-		for (i = 0; i < ARRAY_SIZE(c->usage); i++)
-			acc_u64s_percpu((u64 *) &ret->u, (u64 __percpu *) c->usage[i],
-					__fs_usage_u64s(nr_replicas));
-	} while (read_seqcount_retry(&c->usage_lock, seq));
-
-	return ret;
-}
-
 void bch2_fs_usage_acc_to_base(struct bch_fs *c, unsigned idx)
 {
 	unsigned u64s = fs_usage_u64s(c);
diff --git a/fs/bcachefs/buckets.h b/fs/bcachefs/buckets.h
index 4e14615c770e..356f725a4fad 100644
--- a/fs/bcachefs/buckets.h
+++ b/fs/bcachefs/buckets.h
@@ -296,8 +296,6 @@ static inline unsigned dev_usage_u64s(void)
 
 u64 bch2_fs_usage_read_one(struct bch_fs *, u64 *);
 
-struct bch_fs_usage_online *bch2_fs_usage_read(struct bch_fs *);
-
 void bch2_fs_usage_acc_to_base(struct bch_fs *, unsigned);
 
 void bch2_fs_usage_to_text(struct printbuf *,
diff --git a/fs/bcachefs/chardev.c b/fs/bcachefs/chardev.c
index 13ea852be153..03a1339e8f3b 100644
--- a/fs/bcachefs/chardev.c
+++ b/fs/bcachefs/chardev.c
@@ -502,9 +502,7 @@ static long bch2_ioctl_fs_usage(struct bch_fs *c,
 				struct bch_ioctl_fs_usage __user *user_arg)
 {
 	struct bch_ioctl_fs_usage arg;
-	struct bch_fs_usage_online *src = NULL;
 	darray_char replicas = {};
-	unsigned i;
 	u32 replica_entries_bytes;
 	int ret = 0;
 
@@ -520,25 +518,26 @@ static long bch2_ioctl_fs_usage(struct bch_fs *c,
 	if (ret)
 		goto err;
 
+	struct bch_fs_usage_short u = bch2_fs_usage_read_short(c);
 	arg.capacity		= c->capacity;
-	arg.used		= bch2_fs_sectors_used(c, src);
-	arg.online_reserved	= src->online_reserved;
+	arg.used		= u.used;
+	arg.online_reserved	= percpu_u64_get(c->online_reserved);
 	arg.replica_entries_bytes = replicas.nr;
 
-	src = bch2_fs_usage_read(c);
-	if (!src) {
-		ret = -ENOMEM;
-		goto err;
-	}
+	for (unsigned i = 0; i < BCH_REPLICAS_MAX; i++) {
+		struct disk_accounting_key k = {
+			.type = BCH_DISK_ACCOUNTING_persistent_reserved,
+			.persistent_reserved.nr_replicas = i,
+		};
 
-	for (i = 0; i < BCH_REPLICAS_MAX; i++)
-		arg.persistent_reserved[i] = src->u.persistent_reserved[i];
-	percpu_up_read(&c->mark_lock);
+		bch2_accounting_mem_read(c,
+					 disk_accounting_key_to_bpos(&k),
+					 &arg.persistent_reserved[i], 1);
+	}
 
 	ret = copy_to_user_errcode(user_arg, &arg, sizeof(arg));
 err:
 	darray_exit(&replicas);
-	kfree(src);
 	return ret;
 }
 
diff --git a/fs/bcachefs/replicas.c b/fs/bcachefs/replicas.c
index dde581a49e28..d02eb03d2ebd 100644
--- a/fs/bcachefs/replicas.c
+++ b/fs/bcachefs/replicas.c
@@ -319,13 +319,10 @@ static int replicas_table_update(struct bch_fs *c,
 				 struct bch_replicas_cpu *new_r)
 {
 	struct bch_fs_usage __percpu *new_usage[JOURNAL_BUF_NR];
-	struct bch_fs_usage_online *new_scratch = NULL;
 	struct bch_fs_usage __percpu *new_gc = NULL;
 	struct bch_fs_usage *new_base = NULL;
 	unsigned i, bytes = sizeof(struct bch_fs_usage) +
 		sizeof(u64) * new_r->nr;
-	unsigned scratch_bytes = sizeof(struct bch_fs_usage_online) +
-		sizeof(u64) * new_r->nr;
 	int ret = 0;
 
 	memset(new_usage, 0, sizeof(new_usage));
@@ -336,7 +333,6 @@ static int replicas_table_update(struct bch_fs *c,
 			goto err;
 
 	if (!(new_base = kzalloc(bytes, GFP_KERNEL)) ||
-	    !(new_scratch  = kmalloc(scratch_bytes, GFP_KERNEL)) ||
 	    (c->usage_gc &&
 	     !(new_gc = __alloc_percpu_gfp(bytes, sizeof(u64), GFP_KERNEL))))
 		goto err;
@@ -355,12 +351,10 @@ static int replicas_table_update(struct bch_fs *c,
 	for (i = 0; i < ARRAY_SIZE(new_usage); i++)
 		swap(c->usage[i],	new_usage[i]);
 	swap(c->usage_base,	new_base);
-	swap(c->usage_scratch,	new_scratch);
 	swap(c->usage_gc,	new_gc);
 	swap(c->replicas,	*new_r);
 out:
 	free_percpu(new_gc);
-	kfree(new_scratch);
 	for (i = 0; i < ARRAY_SIZE(new_usage); i++)
 		free_percpu(new_usage[i]);
 	kfree(new_base);
@@ -1024,7 +1018,6 @@ void bch2_fs_replicas_exit(struct bch_fs *c)
 {
 	unsigned i;
 
-	kfree(c->usage_scratch);
 	for (i = 0; i < ARRAY_SIZE(c->usage); i++)
 		free_percpu(c->usage[i]);
 	kfree(c->usage_base);
diff --git a/fs/bcachefs/super.c b/fs/bcachefs/super.c
index 685d54d0ddbb..a26472f4620a 100644
--- a/fs/bcachefs/super.c
+++ b/fs/bcachefs/super.c
@@ -783,8 +783,6 @@ static struct bch_fs *bch2_fs_alloc(struct bch_sb *sb, struct bch_opts opts)
 
 	INIT_LIST_HEAD(&c->list);
 
-	mutex_init(&c->usage_scratch_lock);
-
 	mutex_init(&c->bio_bounce_pages_lock);
 	mutex_init(&c->snapshot_table_lock);
 	init_rwsem(&c->snapshot_create_lock);
-- 
2.43.0


