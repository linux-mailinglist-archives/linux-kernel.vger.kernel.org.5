Return-Path: <linux-kernel+bounces-79945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA338628E2
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 03:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D0F51F21992
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 02:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BBE1B80C;
	Sun, 25 Feb 2024 02:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bn14oTRh"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E562168DA
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 02:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708828733; cv=none; b=JB4sUai3dlJ8cyi+hObd9DEuZUhGQzx3/9b7Yuxb/N9ONwSHy+SogVWOWEyF4dhFjVXC6qlxl2umN9LmIPkP16qLIfdgyHVICnzCReEDvi3dyrCDsFk269+jjayLXtRHMDrZhQMiUt+s/JSi5GT5YXR9e/f8RoSjphP45rc7CBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708828733; c=relaxed/simple;
	bh=Na222wNarH0rNKP8Cur5R0WSBSTXS7OOq3fMMHi1W9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ifJw76oPuyh5dLBf7rkUZsBqVW7qZ7v2lah4JfOVMMcMOZxpHHipWu70b4rmsh0E6yPgfaVCcAne0bL4xD37pYB8HgNBFs9OoVLKABQe1Lwvd+gxtOsjyXW7/zIr714ZHcTRA6IXamh+zXNCqj7vJqFnGBxymet30nshVL981qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bn14oTRh; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708828727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EbUhq312t/ujD/5UG8QAGFllKHwHozY0sW6mmTZ6ZAg=;
	b=bn14oTRhbAz1DzfQxtsQ0EIOmJJero91RqdDt5e6rIIKFno/DqERwr1CqAB+v7uzC3iGvp
	3Tp4f2RIv9O1RxQko0h+Bif6mNgLnuVpCa2iY+j0sv9Ymk155LDxpur7zMYjx4NZiaH4FI
	wc25Q6Dayxmicj4npQRYDzT7dIQShqw=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	djwong@kernel.org,
	bfoster@redhat.com
Subject: [PATCH 14/21] bcachefs: Convert gc to new accounting
Date: Sat, 24 Feb 2024 21:38:16 -0500
Message-ID: <20240225023826.2413565-15-kent.overstreet@linux.dev>
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

Rewrite fsck/gc for the new accounting scheme.

This adds a second set of in-memory accounting counters for gc to use;
like with other parts of gc we run all trigger in TRIGGER_GC mode, then
compare what we calculated to existing in-memory accounting at the end.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/bcachefs/alloc_background.c   | 181 +++++++++++-----------
 fs/bcachefs/alloc_background.h   |   2 +
 fs/bcachefs/bcachefs.h           |   4 +-
 fs/bcachefs/btree_gc.c           | 257 ++++++++++---------------------
 fs/bcachefs/btree_trans_commit.c |   4 +-
 fs/bcachefs/buckets.c            | 182 ++++------------------
 fs/bcachefs/buckets.h            |  20 +--
 fs/bcachefs/buckets_types.h      |   7 -
 fs/bcachefs/disk_accounting.c    | 171 +++++++++++++++++---
 fs/bcachefs/disk_accounting.h    |  81 ++++++----
 fs/bcachefs/ec.c                 | 148 +++++++++---------
 fs/bcachefs/inode.c              |  43 ++----
 fs/bcachefs/recovery.c           |   3 +-
 fs/bcachefs/replicas.c           |  86 +----------
 fs/bcachefs/replicas.h           |   1 -
 fs/bcachefs/super.c              |   9 +-
 16 files changed, 508 insertions(+), 691 deletions(-)

diff --git a/fs/bcachefs/alloc_background.c b/fs/bcachefs/alloc_background.c
index d8ad5bb28a7f..54cb345b104c 100644
--- a/fs/bcachefs/alloc_background.c
+++ b/fs/bcachefs/alloc_background.c
@@ -731,6 +731,96 @@ static noinline int bch2_bucket_gen_update(struct btree_trans *trans,
 	return ret;
 }
 
+static int bch2_alloc_key_to_dev_counters(struct btree_trans *trans, struct bch_dev *ca,
+					  const struct bch_alloc_v4 *old_a,
+					  const struct bch_alloc_v4 *new_a,
+					  unsigned flags)
+{
+	bool gc = flags & BTREE_TRIGGER_GC;
+
+	if ((flags & BTREE_TRIGGER_BUCKET_INVALIDATE) &&
+	    old_a->cached_sectors) {
+		int ret = bch2_mod_dev_cached_sectors(trans, ca->dev_idx,
+				 -((s64) old_a->cached_sectors), gc);
+		if (ret)
+			return ret;
+	}
+
+	if (old_a->data_type != new_a->data_type ||
+	    old_a->dirty_sectors != new_a->dirty_sectors) {
+		struct disk_accounting_key acc = {
+			.type = BCH_DISK_ACCOUNTING_dev_data_type,
+			.dev_data_type.dev = ca->dev_idx,
+			.dev_data_type.data_type = new_a->data_type,
+		};
+		s64 d[3];
+
+		if (old_a->data_type == new_a->data_type) {
+			d[0] = 0;
+			d[1] = (s64) new_a->dirty_sectors - (s64) old_a->dirty_sectors;
+			d[2] =  bucket_sectors_fragmented(ca, *new_a) -
+				bucket_sectors_fragmented(ca, *old_a);
+
+			int ret = bch2_disk_accounting_mod(trans, &acc, d, 3, gc);
+			if (ret)
+				return ret;
+		} else {
+			d[0] = 1;
+			d[1] = new_a->dirty_sectors;
+			d[2] = bucket_sectors_fragmented(ca, *new_a);
+
+			int ret = bch2_disk_accounting_mod(trans, &acc, d, 3, gc);
+			if (ret)
+				return ret;
+
+			acc.dev_data_type.data_type = old_a->data_type;
+			d[0] = -1;
+			d[1] = -(s64) old_a->dirty_sectors;
+			d[2] = -bucket_sectors_fragmented(ca, *old_a);
+
+			ret = bch2_disk_accounting_mod(trans, &acc, d, 3, gc);
+			if (ret)
+				return ret;
+		}
+	}
+
+	if (!!old_a->stripe != !!new_a->stripe) {
+		struct disk_accounting_key acc = {
+			.type = BCH_DISK_ACCOUNTING_dev_stripe_buckets,
+			.dev_stripe_buckets.dev = ca->dev_idx,
+		};
+		u64 d[1];
+
+		d[0] = (s64) !!new_a->stripe - (s64) !!old_a->stripe;
+		int ret = bch2_disk_accounting_mod(trans, &acc, d, 1, gc);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static inline struct bch_alloc_v4 bucket_m_to_alloc(struct bucket b)
+{
+	return (struct bch_alloc_v4) {
+		.gen		= b.gen,
+		.data_type	= b.data_type,
+		.dirty_sectors	= b.dirty_sectors,
+		.cached_sectors	= b.cached_sectors,
+		.stripe		= b.stripe,
+	};
+}
+
+int bch2_bucket_to_dev_counters(struct btree_trans *trans, struct bch_dev *ca,
+				struct bucket *old, struct bucket *new,
+				unsigned flags)
+{
+	struct bch_alloc_v4 old_a = bucket_m_to_alloc(*old);
+	struct bch_alloc_v4 new_a = bucket_m_to_alloc(*new);
+
+	return bch2_alloc_key_to_dev_counters(trans, ca, &old_a, &new_a, flags);
+}
+
 int bch2_trigger_alloc(struct btree_trans *trans,
 		       enum btree_id btree, unsigned level,
 		       struct bkey_s_c old, struct bkey_s new,
@@ -807,70 +897,9 @@ int bch2_trigger_alloc(struct btree_trans *trans,
 				return ret;
 		}
 
-		/*
-		 * need to know if we're getting called from the invalidate path or
-		 * not:
-		 */
-
-		if ((flags & BTREE_TRIGGER_BUCKET_INVALIDATE) &&
-		    old_a->cached_sectors) {
-			ret = bch2_mod_dev_cached_sectors(trans, new.k->p.inode,
-							  -((s64) old_a->cached_sectors));
-			if (ret)
-				return ret;
-		}
-
-
-		if (old_a->data_type != new_a->data_type ||
-		    old_a->dirty_sectors != new_a->dirty_sectors) {
-			struct disk_accounting_key acc = {
-				.type = BCH_DISK_ACCOUNTING_dev_data_type,
-				.dev_data_type.dev = new.k->p.inode,
-				.dev_data_type.data_type = new_a->data_type,
-			};
-			s64 d[3];
-
-			if (old_a->data_type == new_a->data_type) {
-				d[0] = 0;
-				d[1] = (s64) new_a->dirty_sectors - (s64) old_a->dirty_sectors;
-				d[2] =  bucket_sectors_fragmented(ca, *new_a) -
-					bucket_sectors_fragmented(ca, *old_a);
-
-				ret = bch2_disk_accounting_mod(trans, &acc, d, 3);
-				if (ret)
-					return ret;
-			} else {
-				d[0] = 1;
-				d[1] = new_a->dirty_sectors;
-				d[2] = bucket_sectors_fragmented(ca, *new_a);
-
-				ret = bch2_disk_accounting_mod(trans, &acc, d, 3);
-				if (ret)
-					return ret;
-
-				acc.dev_data_type.data_type = old_a->data_type;
-				d[0] = -1;
-				d[1] = -(s64) old_a->dirty_sectors;
-				d[2] = -bucket_sectors_fragmented(ca, *old_a);
-
-				ret = bch2_disk_accounting_mod(trans, &acc, d, 3);
-				if (ret)
-					return ret;
-			}
-		}
-
-		if (!!old_a->stripe != !!new_a->stripe) {
-			struct disk_accounting_key acc = {
-				.type = BCH_DISK_ACCOUNTING_dev_stripe_buckets,
-				.dev_stripe_buckets.dev = new.k->p.inode,
-			};
-			u64 d[1];
-
-			d[0] = (s64) !!new_a->stripe - (s64) !!old_a->stripe;
-			ret = bch2_disk_accounting_mod(trans, &acc, d, 1);
-			if (ret)
-				return ret;
-		}
+		ret = bch2_alloc_key_to_dev_counters(trans, ca, old_a, new_a, flags);
+		if (ret)
+			return ret;
 	}
 
 	if ((flags & BTREE_TRIGGER_ATOMIC) && (flags & BTREE_TRIGGER_INSERT)) {
@@ -938,30 +967,6 @@ int bch2_trigger_alloc(struct btree_trans *trans,
 			bch2_do_gc_gens(c);
 	}
 
-	if ((flags & BTREE_TRIGGER_GC) &&
-	    (flags & BTREE_TRIGGER_BUCKET_INVALIDATE)) {
-		struct bch_alloc_v4 new_a_convert;
-		const struct bch_alloc_v4 *new_a = bch2_alloc_to_v4(new.s_c, &new_a_convert);
-
-		percpu_down_read(&c->mark_lock);
-		struct bucket *g = gc_bucket(ca, new.k->p.offset);
-
-		bucket_lock(g);
-
-		g->gen_valid		= 1;
-		g->gen			= new_a->gen;
-		g->data_type		= new_a->data_type;
-		g->stripe		= new_a->stripe;
-		g->stripe_redundancy	= new_a->stripe_redundancy;
-		g->dirty_sectors	= new_a->dirty_sectors;
-		g->cached_sectors	= new_a->cached_sectors;
-
-		bucket_unlock(g);
-		percpu_up_read(&c->mark_lock);
-
-		bch2_dev_usage_update(c, ca, old_a, new_a);
-	}
-
 	return 0;
 }
 
diff --git a/fs/bcachefs/alloc_background.h b/fs/bcachefs/alloc_background.h
index 052b2fac25d6..6f273a456a6d 100644
--- a/fs/bcachefs/alloc_background.h
+++ b/fs/bcachefs/alloc_background.h
@@ -228,6 +228,8 @@ static inline bool bkey_is_alloc(const struct bkey *k)
 
 int bch2_alloc_read(struct bch_fs *);
 
+int bch2_bucket_to_dev_counters(struct btree_trans *, struct bch_dev *,
+				struct bucket *, struct bucket *, unsigned);
 int bch2_trigger_alloc(struct btree_trans *, enum btree_id, unsigned,
 		       struct bkey_s_c, struct bkey_s, unsigned);
 int bch2_check_alloc_info(struct bch_fs *);
diff --git a/fs/bcachefs/bcachefs.h b/fs/bcachefs/bcachefs.h
index 22dc455cb436..41c436c608cf 100644
--- a/fs/bcachefs/bcachefs.h
+++ b/fs/bcachefs/bcachefs.h
@@ -577,7 +577,6 @@ struct bch_dev {
 	struct rw_semaphore	bucket_lock;
 
 	struct bch_dev_usage __percpu	*usage;
-	struct bch_dev_usage __percpu	*usage_gc;
 
 	/* Allocator: */
 	u64			new_fs_bucket_idx;
@@ -761,7 +760,7 @@ struct bch_fs {
 
 	struct bch_dev __rcu	*devs[BCH_SB_MEMBERS_MAX];
 
-	struct bch_accounting_mem accounting;
+	struct bch_accounting_mem accounting[2];
 
 	struct bch_replicas_cpu replicas;
 	struct bch_replicas_cpu replicas_gc;
@@ -906,7 +905,6 @@ struct bch_fs {
 
 	seqcount_t			usage_lock;
 	struct bch_fs_usage_base __percpu *usage;
-	struct bch_fs_usage __percpu	*usage_gc;
 	u64 __percpu		*online_reserved;
 
 	struct io_clock		io_clock[2];
diff --git a/fs/bcachefs/btree_gc.c b/fs/bcachefs/btree_gc.c
index 15a8796197f3..54a90e88f5b8 100644
--- a/fs/bcachefs/btree_gc.c
+++ b/fs/bcachefs/btree_gc.c
@@ -18,6 +18,7 @@
 #include "buckets.h"
 #include "clock.h"
 #include "debug.h"
+#include "disk_accounting.h"
 #include "ec.h"
 #include "error.h"
 #include "extents.h"
@@ -1115,10 +1116,10 @@ static int bch2_gc_btrees(struct bch_fs *c, bool initial, bool metadata_only)
 	return ret;
 }
 
-static void mark_metadata_sectors(struct bch_fs *c, struct bch_dev *ca,
-				  u64 start, u64 end,
-				  enum bch_data_type type,
-				  unsigned flags)
+static int mark_metadata_sectors(struct btree_trans *trans, struct bch_dev *ca,
+				 u64 start, u64 end,
+				 enum bch_data_type type,
+				 unsigned flags)
 {
 	u64 b = sector_to_bucket(ca, start);
 
@@ -1126,48 +1127,68 @@ static void mark_metadata_sectors(struct bch_fs *c, struct bch_dev *ca,
 		unsigned sectors =
 			min_t(u64, bucket_to_sector(ca, b + 1), end) - start;
 
-		bch2_mark_metadata_bucket(c, ca, b, type, sectors,
-					  gc_phase(GC_PHASE_SB), flags);
+		int ret = bch2_mark_metadata_bucket(trans, ca, b, type, sectors,
+						    gc_phase(GC_PHASE_SB), flags);
+		if (ret)
+			return ret;
+
 		b++;
 		start += sectors;
 	} while (start < end);
+
+	return 0;
 }
 
-static void bch2_mark_dev_superblock(struct bch_fs *c, struct bch_dev *ca,
-				     unsigned flags)
+static int bch2_mark_dev_superblock(struct btree_trans *trans, struct bch_dev *ca,
+				    unsigned flags)
 {
 	struct bch_sb_layout *layout = &ca->disk_sb.sb->layout;
-	unsigned i;
-	u64 b;
 
-	for (i = 0; i < layout->nr_superblocks; i++) {
+	for (unsigned i = 0; i < layout->nr_superblocks; i++) {
 		u64 offset = le64_to_cpu(layout->sb_offset[i]);
 
-		if (offset == BCH_SB_SECTOR)
-			mark_metadata_sectors(c, ca, 0, BCH_SB_SECTOR,
-					      BCH_DATA_sb, flags);
+		if (offset == BCH_SB_SECTOR) {
+			int ret = mark_metadata_sectors(trans, ca, 0, BCH_SB_SECTOR,
+							BCH_DATA_sb, flags);
+			if (ret)
+				return ret;
+		}
 
-		mark_metadata_sectors(c, ca, offset,
+		int ret = mark_metadata_sectors(trans, ca, offset,
 				      offset + (1 << layout->sb_max_size_bits),
 				      BCH_DATA_sb, flags);
+			if (ret)
+				return ret;
 	}
 
-	for (i = 0; i < ca->journal.nr; i++) {
-		b = ca->journal.buckets[i];
-		bch2_mark_metadata_bucket(c, ca, b, BCH_DATA_journal,
-					  ca->mi.bucket_size,
+	for (unsigned i = 0; i < ca->journal.nr; i++) {
+		int ret = bch2_mark_metadata_bucket(trans, ca, ca->journal.buckets[i],
+					  BCH_DATA_journal, ca->mi.bucket_size,
 					  gc_phase(GC_PHASE_SB), flags);
+		if (ret)
+			return ret;
 	}
+
+	return 0;
 }
 
-static void bch2_mark_superblocks(struct bch_fs *c)
+static int bch2_mark_superblocks(struct btree_trans *trans)
 {
+	struct bch_fs *c = trans->c;
+
 	mutex_lock(&c->sb_lock);
 	gc_pos_set(c, gc_phase(GC_PHASE_SB));
 
-	for_each_online_member(c, ca)
-		bch2_mark_dev_superblock(c, ca, BTREE_TRIGGER_GC);
+	for_each_online_member(c, ca) {
+		int ret = bch2_mark_dev_superblock(trans, ca, BTREE_TRIGGER_GC);
+		if (ret) {
+			percpu_ref_put(&ca->io_ref);
+			return ret;
+		}
+	}
 	mutex_unlock(&c->sb_lock);
+
+	return 0;
 }
 
 #if 0
@@ -1190,146 +1211,25 @@ static void bch2_mark_pending_btree_node_frees(struct bch_fs *c)
 
 static void bch2_gc_free(struct bch_fs *c)
 {
+	bch2_accounting_free(&c->accounting[1]);
+
 	genradix_free(&c->reflink_gc_table);
 	genradix_free(&c->gc_stripes);
 
 	for_each_member_device(c, ca) {
 		kvfree(rcu_dereference_protected(ca->buckets_gc, 1));
 		ca->buckets_gc = NULL;
-
-		free_percpu(ca->usage_gc);
-		ca->usage_gc = NULL;
-	}
-
-	free_percpu(c->usage_gc);
-	c->usage_gc = NULL;
-}
-
-static int bch2_gc_done(struct bch_fs *c,
-			bool initial, bool metadata_only)
-{
-	struct bch_dev *ca = NULL;
-	struct printbuf buf = PRINTBUF;
-	bool verify = !metadata_only &&
-		!c->opts.reconstruct_alloc &&
-		(!initial || (c->sb.compat & (1ULL << BCH_COMPAT_alloc_info)));
-	unsigned i;
-	int ret = 0;
-
-	percpu_down_write(&c->mark_lock);
-
-#define copy_field(_err, _f, _msg, ...)					\
-	if (dst->_f != src->_f &&					\
-	    (!verify ||							\
-	     fsck_err(c, _err, _msg ": got %llu, should be %llu"	\
-		      , ##__VA_ARGS__, dst->_f, src->_f)))		\
-		dst->_f = src->_f
-#define copy_dev_field(_err, _f, _msg, ...)				\
-	copy_field(_err, _f, "dev %u has wrong " _msg, ca->dev_idx, ##__VA_ARGS__)
-#define copy_fs_field(_err, _f, _msg, ...)				\
-	copy_field(_err, _f, "fs has wrong " _msg, ##__VA_ARGS__)
-
-	__for_each_member_device(c, ca) {
-		/* XXX */
-		struct bch_dev_usage *dst = this_cpu_ptr(ca->usage);
-		struct bch_dev_usage *src = (void *)
-			bch2_acc_percpu_u64s((u64 __percpu *) ca->usage_gc,
-					     dev_usage_u64s());
-
-		for (i = 0; i < BCH_DATA_NR; i++) {
-			copy_dev_field(dev_usage_buckets_wrong,
-				       d[i].buckets,	"%s buckets", bch2_data_type_str(i));
-			copy_dev_field(dev_usage_sectors_wrong,
-				       d[i].sectors,	"%s sectors", bch2_data_type_str(i));
-			copy_dev_field(dev_usage_fragmented_wrong,
-				       d[i].fragmented,	"%s fragmented", bch2_data_type_str(i));
-		}
-	}
-
-	{
-#if 0
-		unsigned nr = fs_usage_u64s(c);
-		/* XX: */
-		struct bch_fs_usage *dst = this_cpu_ptr(c->usage);
-		struct bch_fs_usage *src = (void *)
-			bch2_acc_percpu_u64s((u64 __percpu *) c->usage_gc, nr);
-
-		copy_fs_field(fs_usage_hidden_wrong,
-			      b.hidden,		"hidden");
-		copy_fs_field(fs_usage_btree_wrong,
-			      b.btree,		"btree");
-
-		if (!metadata_only) {
-			copy_fs_field(fs_usage_data_wrong,
-				      b.data,	"data");
-			copy_fs_field(fs_usage_cached_wrong,
-				      b.cached,	"cached");
-			copy_fs_field(fs_usage_reserved_wrong,
-				      b.reserved,	"reserved");
-			copy_fs_field(fs_usage_nr_inodes_wrong,
-				      b.nr_inodes,"nr_inodes");
-
-			for (i = 0; i < BCH_REPLICAS_MAX; i++)
-				copy_fs_field(fs_usage_persistent_reserved_wrong,
-					      persistent_reserved[i],
-					      "persistent_reserved[%i]", i);
-		}
-
-		for (i = 0; i < c->replicas.nr; i++) {
-			struct bch_replicas_entry_v1 *e =
-				cpu_replicas_entry(&c->replicas, i);
-
-			if (metadata_only &&
-			    (e->data_type == BCH_DATA_user ||
-			     e->data_type == BCH_DATA_cached))
-				continue;
-
-			printbuf_reset(&buf);
-			bch2_replicas_entry_to_text(&buf, e);
-
-			copy_fs_field(fs_usage_replicas_wrong,
-				      replicas[i], "%s", buf.buf);
-		}
-#endif
 	}
-
-#undef copy_fs_field
-#undef copy_dev_field
-#undef copy_stripe_field
-#undef copy_field
-fsck_err:
-	if (ca)
-		percpu_ref_put(&ca->ref);
-	bch_err_fn(c, ret);
-
-	percpu_up_write(&c->mark_lock);
-	printbuf_exit(&buf);
-	return ret;
 }
 
 static int bch2_gc_start(struct bch_fs *c)
 {
-	BUG_ON(c->usage_gc);
-
-	c->usage_gc = __alloc_percpu_gfp(fs_usage_u64s(c) * sizeof(u64),
-					 sizeof(u64), GFP_KERNEL);
-	if (!c->usage_gc) {
-		bch_err(c, "error allocating c->usage_gc");
-		return -BCH_ERR_ENOMEM_gc_start;
-	}
-
 	for_each_member_device(c, ca) {
-		BUG_ON(ca->usage_gc);
-
-		ca->usage_gc = alloc_percpu(struct bch_dev_usage);
-		if (!ca->usage_gc) {
-			bch_err(c, "error allocating ca->usage_gc");
+		int ret = bch2_dev_usage_init(ca, true);
+		if (ret) {
 			percpu_ref_put(&ca->ref);
-			return -BCH_ERR_ENOMEM_gc_start;
+			return ret;
 		}
-
-		this_cpu_write(ca->usage_gc->d[BCH_DATA_free].buckets,
-			       ca->mi.nbuckets - ca->mi.first_bucket);
 	}
 
 	return 0;
@@ -1337,13 +1237,7 @@ static int bch2_gc_start(struct bch_fs *c)
 
 static int bch2_gc_reset(struct bch_fs *c)
 {
-	for_each_member_device(c, ca) {
-		free_percpu(ca->usage_gc);
-		ca->usage_gc = NULL;
-	}
-
-	free_percpu(c->usage_gc);
-	c->usage_gc = NULL;
+	bch2_accounting_free(&c->accounting[1]);
 
 	return bch2_gc_start(c);
 }
@@ -1368,7 +1262,7 @@ static int bch2_alloc_write_key(struct btree_trans *trans,
 {
 	struct bch_fs *c = trans->c;
 	struct bch_dev *ca = bch_dev_bkey_exists(c, iter->pos.inode);
-	struct bucket gc, *b;
+	struct bucket gc;
 	struct bkey_i_alloc_v4 *a;
 	struct bch_alloc_v4 old_convert, new;
 	const struct bch_alloc_v4 *old;
@@ -1379,30 +1273,39 @@ static int bch2_alloc_write_key(struct btree_trans *trans,
 	new = *old;
 
 	percpu_down_read(&c->mark_lock);
-	b = gc_bucket(ca, iter->pos.offset);
+	gc = *gc_bucket(ca, iter->pos.offset);
+	percpu_up_read(&c->mark_lock);
 
 	/*
 	 * b->data_type doesn't yet include need_discard & need_gc_gen states -
 	 * fix that here:
 	 */
-	type = __alloc_data_type(b->dirty_sectors,
-				 b->cached_sectors,
-				 b->stripe,
+	type = __alloc_data_type(gc.dirty_sectors,
+				 gc.cached_sectors,
+				 gc.stripe,
 				 *old,
-				 b->data_type);
-	if (b->data_type != type) {
-		struct bch_dev_usage *u;
-
-		preempt_disable();
-		u = this_cpu_ptr(ca->usage_gc);
-		u->d[b->data_type].buckets--;
-		b->data_type = type;
-		u->d[b->data_type].buckets++;
-		preempt_enable();
-	}
+				 gc.data_type);
 
-	gc = *b;
-	percpu_up_read(&c->mark_lock);
+	if (gc.data_type != type) {
+		struct disk_accounting_key acc = {
+			.type = BCH_DISK_ACCOUNTING_dev_data_type,
+			.dev_data_type.dev = ca->dev_idx,
+			.dev_data_type.data_type = type,
+		};
+		u64 d[3] = { 1, 0, 0 };
+
+		ret = bch2_disk_accounting_mod(trans, &acc, d, 3, true);
+		if (ret)
+			return ret;
+
+		acc.dev_data_type.data_type = gc.data_type;
+		d[0] = -1;
+		ret = bch2_disk_accounting_mod(trans, &acc, d, 3, true);
+		if (ret)
+			return ret;
+
+		gc.data_type = type;
+	}
 
 	if (metadata_only &&
 	    gc.data_type != BCH_DATA_sb &&
@@ -1778,10 +1681,12 @@ int bch2_gc(struct bch_fs *c, bool initial, bool metadata_only)
 again:
 	gc_pos_set(c, gc_phase(GC_PHASE_START));
 
-	bch2_mark_superblocks(c);
+	ret = bch2_trans_run(c, bch2_mark_superblocks(trans));
+	bch_err_msg(c, ret, "marking superblocks");
+	if (ret)
+		goto out;
 
 	ret = bch2_gc_btrees(c, initial, metadata_only);
-
 	if (ret)
 		goto out;
 
@@ -1823,7 +1728,7 @@ int bch2_gc(struct bch_fs *c, bool initial, bool metadata_only)
 		ret   = bch2_gc_stripes_done(c, metadata_only) ?:
 			bch2_gc_reflink_done(c, metadata_only) ?:
 			bch2_gc_alloc_done(c, metadata_only) ?:
-			bch2_gc_done(c, initial, metadata_only);
+			bch2_accounting_gc_done(c);
 
 		bch2_journal_unblock(&c->journal);
 	}
diff --git a/fs/bcachefs/btree_trans_commit.c b/fs/bcachefs/btree_trans_commit.c
index b005e20039bb..eac9d45bcc8c 100644
--- a/fs/bcachefs/btree_trans_commit.c
+++ b/fs/bcachefs/btree_trans_commit.c
@@ -697,7 +697,7 @@ bch2_trans_commit_write_locked(struct btree_trans *trans, unsigned flags,
 			a->k.version = journal_pos_to_bversion(&trans->journal_res,
 							(u64 *) entry - (u64 *) trans->journal_entries);
 			BUG_ON(bversion_zero(a->k.version));
-			ret = bch2_accounting_mem_add(trans, accounting_i_to_s_c(a));
+			ret = bch2_accounting_mem_add_locked(trans, accounting_i_to_s_c(a), false);
 			if (ret)
 				goto revert_fs_usage;
 		}
@@ -784,7 +784,7 @@ bch2_trans_commit_write_locked(struct btree_trans *trans, unsigned flags,
 			struct bkey_s_accounting a = bkey_i_to_s_accounting(entry2->start);
 
 			bch2_accounting_neg(a);
-			bch2_accounting_mem_add(trans, a.c);
+			bch2_accounting_mem_add_locked(trans, a.c, false);
 			bch2_accounting_neg(a);
 		}
 	percpu_up_read(&c->mark_lock);
diff --git a/fs/bcachefs/buckets.c b/fs/bcachefs/buckets.c
index 5e2b9aa93241..506bb580bff4 100644
--- a/fs/bcachefs/buckets.c
+++ b/fs/bcachefs/buckets.c
@@ -95,113 +95,12 @@ void bch2_dev_usage_to_text(struct printbuf *out, struct bch_dev_usage *usage)
 	}
 }
 
-void bch2_dev_usage_update(struct bch_fs *c, struct bch_dev *ca,
-			   const struct bch_alloc_v4 *old,
-			   const struct bch_alloc_v4 *new)
-{
-	struct bch_fs_usage *fs_usage;
-	struct bch_dev_usage *u;
-
-	preempt_disable();
-	fs_usage = this_cpu_ptr(c->usage_gc);
-
-	if (data_type_is_hidden(old->data_type))
-		fs_usage->b.hidden -= ca->mi.bucket_size;
-	if (data_type_is_hidden(new->data_type))
-		fs_usage->b.hidden += ca->mi.bucket_size;
-
-	u = this_cpu_ptr(ca->usage_gc);
-
-	u->d[old->data_type].buckets--;
-	u->d[new->data_type].buckets++;
-
-	u->d[old->data_type].sectors -= bch2_bucket_sectors_dirty(*old);
-	u->d[new->data_type].sectors += bch2_bucket_sectors_dirty(*new);
-
-	u->d[BCH_DATA_cached].sectors += new->cached_sectors;
-	u->d[BCH_DATA_cached].sectors -= old->cached_sectors;
-
-	u->d[old->data_type].fragmented -= bch2_bucket_sectors_fragmented(ca, *old);
-	u->d[new->data_type].fragmented += bch2_bucket_sectors_fragmented(ca, *new);
-
-	preempt_enable();
-}
-
-static inline struct bch_alloc_v4 bucket_m_to_alloc(struct bucket b)
-{
-	return (struct bch_alloc_v4) {
-		.gen		= b.gen,
-		.data_type	= b.data_type,
-		.dirty_sectors	= b.dirty_sectors,
-		.cached_sectors	= b.cached_sectors,
-		.stripe		= b.stripe,
-	};
-}
-
-void bch2_dev_usage_update_m(struct bch_fs *c, struct bch_dev *ca,
-			     struct bucket *old, struct bucket *new)
-{
-	struct bch_alloc_v4 old_a = bucket_m_to_alloc(*old);
-	struct bch_alloc_v4 new_a = bucket_m_to_alloc(*new);
-
-	bch2_dev_usage_update(c, ca, &old_a, &new_a);
-}
-
-int bch2_update_replicas(struct bch_fs *c, struct bkey_s_c k,
-			 struct bch_replicas_entry_v1 *r, s64 sectors)
-{
-	struct bch_fs_usage *fs_usage;
-	int idx, ret = 0;
-	struct printbuf buf = PRINTBUF;
-
-	percpu_down_read(&c->mark_lock);
-
-	idx = bch2_replicas_entry_idx(c, r);
-	if (idx < 0 &&
-	    fsck_err(c, ptr_to_missing_replicas_entry,
-		     "no replicas entry\n  while marking %s",
-		     (bch2_bkey_val_to_text(&buf, c, k), buf.buf))) {
-		percpu_up_read(&c->mark_lock);
-		ret = bch2_mark_replicas(c, r);
-		percpu_down_read(&c->mark_lock);
-
-		if (ret)
-			goto err;
-		idx = bch2_replicas_entry_idx(c, r);
-	}
-	if (idx < 0) {
-		ret = -1;
-		goto err;
-	}
-
-	preempt_disable();
-	fs_usage = this_cpu_ptr(c->usage_gc);
-	fs_usage_data_type_to_base(&fs_usage->b, r->data_type, sectors);
-	fs_usage->replicas[idx]		+= sectors;
-	preempt_enable();
-err:
-fsck_err:
-	percpu_up_read(&c->mark_lock);
-	printbuf_exit(&buf);
-	return ret;
-}
-
-static inline int update_cached_sectors(struct bch_fs *c,
-			struct bkey_s_c k,
-			unsigned dev, s64 sectors)
-{
-	struct bch_replicas_padded r;
-
-	bch2_replicas_entry_cached(&r.e, dev);
-
-	return bch2_update_replicas(c, k, &r.e, sectors);
-}
-
-int bch2_mark_metadata_bucket(struct bch_fs *c, struct bch_dev *ca,
+int bch2_mark_metadata_bucket(struct btree_trans *trans, struct bch_dev *ca,
 			      size_t b, enum bch_data_type data_type,
 			      unsigned sectors, struct gc_pos pos,
 			      unsigned flags)
 {
+	struct bch_fs *c = trans->c;
 	struct bucket old, new, *g;
 	int ret = 0;
 
@@ -242,12 +141,15 @@ int bch2_mark_metadata_bucket(struct bch_fs *c, struct bch_dev *ca,
 	g->data_type = data_type;
 	g->dirty_sectors += sectors;
 	new = *g;
-err:
 	bucket_unlock(g);
-	if (!ret)
-		bch2_dev_usage_update_m(c, ca, &old, &new);
 	percpu_up_read(&c->mark_lock);
+	ret = bch2_bucket_to_dev_counters(trans, ca, &old, &new, flags);
+out:
 	return ret;
+err:
+	bucket_unlock(g);
+	percpu_up_read(&c->mark_lock);
+	goto out;
 }
 
 int bch2_check_bucket_ref(struct btree_trans *trans,
@@ -496,8 +398,11 @@ static int bch2_trigger_pointer(struct btree_trans *trans,
 		g->data_type = bucket_data_type;
 		struct bucket new = *g;
 		bucket_unlock(g);
-		bch2_dev_usage_update_m(c, ca, &old, &new);
 		percpu_up_read(&c->mark_lock);
+
+		ret = bch2_bucket_to_dev_counters(trans, ca, &old, &new, flags);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
@@ -539,7 +444,7 @@ static int bch2_trigger_stripe_ptr(struct btree_trans *trans,
 		};
 		bch2_bkey_to_replicas(&acc.replicas, bkey_i_to_s_c(&s->k_i));
 		acc.replicas.data_type = data_type;
-		ret = bch2_disk_accounting_mod(trans, &acc, &sectors, 1);
+		ret = bch2_disk_accounting_mod(trans, &acc, &sectors, 1, false);
 err:
 		bch2_trans_iter_exit(trans, &iter);
 		return ret;
@@ -548,8 +453,6 @@ static int bch2_trigger_stripe_ptr(struct btree_trans *trans,
 	if (flags & BTREE_TRIGGER_GC) {
 		struct bch_fs *c = trans->c;
 
-		BUG_ON(!(flags & BTREE_TRIGGER_GC));
-
 		struct gc_stripe *m = genradix_ptr_alloc(&c->gc_stripes, p.ec.idx, GFP_KERNEL);
 		if (!m) {
 			bch_err(c, "error allocating memory for gc_stripes, idx %llu",
@@ -572,11 +475,16 @@ static int bch2_trigger_stripe_ptr(struct btree_trans *trans,
 
 		m->block_sectors[p.ec.block] += sectors;
 
-		struct bch_replicas_padded r = m->r;
+		struct disk_accounting_key acc = {
+			.type = BCH_DISK_ACCOUNTING_replicas,
+		};
+		memcpy(&acc.replicas, &m->r.e, replicas_entry_bytes(&m->r.e));
 		mutex_unlock(&c->ec_stripes_heap_lock);
 
-		r.e.data_type = data_type;
-		bch2_update_replicas(c, k, &r.e, sectors);
+		acc.replicas.data_type = data_type;
+		int ret = bch2_disk_accounting_mod(trans, &acc, &sectors, 1, true);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
@@ -587,7 +495,6 @@ static int __trigger_extent(struct btree_trans *trans,
 			    struct bkey_s_c k, unsigned flags)
 {
 	bool gc = flags & BTREE_TRIGGER_GC;
-	struct bch_fs *c = trans->c;
 	struct bkey_ptrs_c ptrs = bch2_bkey_ptrs_c(k);
 	const union bch_extent_entry *entry;
 	struct extent_ptr_decoded p;
@@ -614,11 +521,7 @@ static int __trigger_extent(struct btree_trans *trans,
 
 		if (p.ptr.cached) {
 			if (!stale) {
-				ret = !gc
-					? bch2_mod_dev_cached_sectors(trans, p.ptr.dev, disk_sectors)
-					: update_cached_sectors(c, k, p.ptr.dev, disk_sectors);
-				bch2_fs_fatal_err_on(ret && gc, c, "%s(): no replicas entry while updating cached sectors",
-						     __func__);
+				ret = bch2_mod_dev_cached_sectors(trans, p.ptr.dev, disk_sectors, gc);
 				if (ret)
 					return ret;
 			}
@@ -640,16 +543,7 @@ static int __trigger_extent(struct btree_trans *trans,
 	}
 
 	if (acc.replicas.nr_devs) {
-		ret = !gc
-			? bch2_disk_accounting_mod(trans, &acc, &dirty_sectors, 1)
-			: bch2_update_replicas(c, k, &acc.replicas, dirty_sectors);
-		if (unlikely(ret && gc)) {
-			struct printbuf buf = PRINTBUF;
-
-			bch2_bkey_val_to_text(&buf, c, k);
-			bch2_fs_fatal_error(c, "%s(): no replicas entry for %s", __func__, buf.buf);
-			printbuf_exit(&buf);
-		}
+		ret = bch2_disk_accounting_mod(trans, &acc, &dirty_sectors, 1, gc);
 		if (ret)
 			return ret;
 	}
@@ -699,36 +593,18 @@ static int __trigger_reservation(struct btree_trans *trans,
 				 enum btree_id btree_id, unsigned level,
 				 struct bkey_s_c k, unsigned flags)
 {
-	struct bch_fs *c = trans->c;
-	unsigned replicas = bkey_s_c_to_reservation(k).v->nr_replicas;
-	s64 sectors = (s64) k.k->size;
+	if (flags & (BTREE_TRIGGER_TRANSACTIONAL|BTREE_TRIGGER_GC)) {
+		s64 sectors = k.k->size;
 
-	if (flags & BTREE_TRIGGER_OVERWRITE)
-		sectors = -sectors;
+		if (flags & BTREE_TRIGGER_OVERWRITE)
+			sectors = -sectors;
 
-	if (flags & BTREE_TRIGGER_TRANSACTIONAL) {
 		struct disk_accounting_key acc = {
 			.type = BCH_DISK_ACCOUNTING_persistent_reserved,
-			.persistent_reserved.nr_replicas = replicas,
+			.persistent_reserved.nr_replicas = bkey_s_c_to_reservation(k).v->nr_replicas,
 		};
 
-		return bch2_disk_accounting_mod(trans, &acc, &sectors, 1);
-	}
-
-	if (flags & BTREE_TRIGGER_GC) {
-		sectors *= replicas;
-
-		percpu_down_read(&c->mark_lock);
-		preempt_disable();
-
-		struct bch_fs_usage *fs_usage = this_cpu_ptr(c->usage_gc);
-
-		replicas = min(replicas, ARRAY_SIZE(fs_usage->persistent_reserved));
-		fs_usage->b.reserved				+= sectors;
-		fs_usage->persistent_reserved[replicas - 1]	+= sectors;
-
-		preempt_enable();
-		percpu_up_read(&c->mark_lock);
+		return bch2_disk_accounting_mod(trans, &acc, &sectors, 1, flags & BTREE_TRIGGER_GC);
 	}
 
 	return 0;
diff --git a/fs/bcachefs/buckets.h b/fs/bcachefs/buckets.h
index f9d8d7b9fbd1..7b8b10f74be0 100644
--- a/fs/bcachefs/buckets.h
+++ b/fs/bcachefs/buckets.h
@@ -269,16 +269,6 @@ static inline s64 bucket_sectors_fragmented(struct bch_dev *ca, struct bch_alloc
 
 /* Filesystem usage: */
 
-static inline unsigned __fs_usage_u64s(unsigned nr_replicas)
-{
-	return sizeof(struct bch_fs_usage) / sizeof(u64) + nr_replicas;
-}
-
-static inline unsigned fs_usage_u64s(struct bch_fs *c)
-{
-	return __fs_usage_u64s(READ_ONCE(c->replicas.nr));
-}
-
 static inline unsigned dev_usage_u64s(void)
 {
 	return sizeof(struct bch_dev_usage) / sizeof(u64);
@@ -287,19 +277,11 @@ static inline unsigned dev_usage_u64s(void)
 struct bch_fs_usage_short
 bch2_fs_usage_read_short(struct bch_fs *);
 
-void bch2_dev_usage_update(struct bch_fs *, struct bch_dev *,
-			   const struct bch_alloc_v4 *,
-			   const struct bch_alloc_v4 *);
-void bch2_dev_usage_update_m(struct bch_fs *, struct bch_dev *,
-			     struct bucket *, struct bucket *);
-int bch2_update_replicas(struct bch_fs *, struct bkey_s_c,
-			 struct bch_replicas_entry_v1 *, s64);
-
 int bch2_check_bucket_ref(struct btree_trans *, struct bkey_s_c,
 			  const struct bch_extent_ptr *,
 			  s64, enum bch_data_type, u8, u8, u32);
 
-int bch2_mark_metadata_bucket(struct bch_fs *, struct bch_dev *,
+int bch2_mark_metadata_bucket(struct btree_trans *, struct bch_dev *,
 			      size_t, enum bch_data_type, unsigned,
 			      struct gc_pos, unsigned);
 
diff --git a/fs/bcachefs/buckets_types.h b/fs/bcachefs/buckets_types.h
index 570acdf455bb..7bd1a117afe4 100644
--- a/fs/bcachefs/buckets_types.h
+++ b/fs/bcachefs/buckets_types.h
@@ -54,13 +54,6 @@ struct bch_fs_usage_base {
 	u64			nr_inodes;
 };
 
-struct bch_fs_usage {
-	/* all fields are in units of 512 byte sectors: */
-	struct bch_fs_usage_base b;
-	u64			persistent_reserved[BCH_REPLICAS_MAX];
-	u64			replicas[];
-};
-
 struct bch_fs_usage_short {
 	u64			capacity;
 	u64			used;
diff --git a/fs/bcachefs/disk_accounting.c b/fs/bcachefs/disk_accounting.c
index f898323f72c7..2884615adc1e 100644
--- a/fs/bcachefs/disk_accounting.c
+++ b/fs/bcachefs/disk_accounting.c
@@ -19,7 +19,7 @@ static const char * const disk_accounting_type_strs[] = {
 
 int bch2_disk_accounting_mod(struct btree_trans *trans,
 			     struct disk_accounting_key *k,
-			     s64 *d, unsigned nr)
+			     s64 *d, unsigned nr, bool gc)
 {
 	/* Normalize: */
 	switch (k->type) {
@@ -40,11 +40,14 @@ int bch2_disk_accounting_mod(struct btree_trans *trans,
 
 	memcpy_u64s_small(acc->v.d, d, nr);
 
-	return bch2_trans_update_buffered(trans, BTREE_ID_accounting, &acc->k_i);
+	return likely(!gc)
+		? bch2_trans_update_buffered(trans, BTREE_ID_accounting, &acc->k_i)
+		: bch2_accounting_mem_add(trans, accounting_i_to_s_c(acc), true);
 }
 
 int bch2_mod_dev_cached_sectors(struct btree_trans *trans,
-				unsigned dev, s64 sectors)
+				unsigned dev, s64 sectors,
+				bool gc)
 {
 	struct disk_accounting_key acc = {
 		.type = BCH_DISK_ACCOUNTING_replicas,
@@ -52,7 +55,7 @@ int bch2_mod_dev_cached_sectors(struct btree_trans *trans,
 
 	bch2_replicas_entry_cached(&acc.replicas, dev);
 
-	return bch2_disk_accounting_mod(trans, &acc, &sectors, 1);
+	return bch2_disk_accounting_mod(trans, &acc, &sectors, 1, gc);
 }
 
 int bch2_accounting_invalid(struct bch_fs *c, struct bkey_s_c k,
@@ -147,7 +150,7 @@ int bch2_accounting_update_sb(struct btree_trans *trans)
 	return 0;
 }
 
-static int __bch2_accounting_mem_add_slowpath(struct bch_fs *c, struct bkey_s_c_accounting a)
+static int __bch2_accounting_mem_add_slowpath(struct bch_fs *c, struct bkey_s_c_accounting a, bool gc)
 {
 	struct bch_replicas_padded r;
 
@@ -155,7 +158,7 @@ static int __bch2_accounting_mem_add_slowpath(struct bch_fs *c, struct bkey_s_c_
 	    !bch2_replicas_marked_locked(c, &r.e))
 		return -BCH_ERR_btree_insert_need_mark_replicas;
 
-	struct bch_accounting_mem *acc = &c->accounting;
+	struct bch_accounting_mem *acc = &c->accounting[gc];
 	unsigned new_nr_counters = acc->nr_counters + bch2_accounting_counters(a.k);
 
 	u64 __percpu *new_counters = __alloc_percpu_gfp(new_nr_counters * sizeof(u64),
@@ -191,19 +194,64 @@ static int __bch2_accounting_mem_add_slowpath(struct bch_fs *c, struct bkey_s_c_
 	return 0;
 }
 
-int bch2_accounting_mem_add_slowpath(struct bch_fs *c, struct bkey_s_c_accounting a)
+int bch2_accounting_mem_add_slowpath(struct bch_fs *c, struct bkey_s_c_accounting a, bool gc)
 {
 	percpu_up_read(&c->mark_lock);
 	percpu_down_write(&c->mark_lock);
-	int ret = __bch2_accounting_mem_add_slowpath(c, a);
+	int ret = __bch2_accounting_mem_add_slowpath(c, a, gc);
 	percpu_up_write(&c->mark_lock);
 	percpu_down_read(&c->mark_lock);
 	return ret;
 }
 
+/* Ensures all counters in @src exist in @dst: */
+static int copy_counters(struct bch_accounting_mem *dst,
+			 struct bch_accounting_mem *src)
+{
+	unsigned orig_dst_k_nr = dst->k.nr;
+	unsigned dst_counters = dst->nr_counters;
+
+	darray_for_each(src->k, i)
+		if (eytzinger0_find(dst->k.data, orig_dst_k_nr, sizeof(dst->k.data[0]),
+				    accounting_pos_cmp, &i->pos) >= orig_dst_k_nr) {
+			if (darray_push(&dst->k, ((struct accounting_pos_offset) {
+					.pos		= i->pos,
+					.offset		= dst_counters,
+					.nr_counters	= i->nr_counters })))
+				goto err;
+
+			dst_counters += i->nr_counters;
+		}
+
+	if (dst->k.nr == orig_dst_k_nr)
+		return 0;
+
+	u64 __percpu *new_counters = __alloc_percpu_gfp(dst_counters * sizeof(u64),
+							sizeof(u64), GFP_KERNEL);
+	if (!new_counters)
+		goto err;
+
+	preempt_disable();
+	memcpy(this_cpu_ptr(new_counters),
+	       bch2_acc_percpu_u64s(dst->v, dst->nr_counters),
+	       dst->nr_counters * sizeof(u64));
+	preempt_enable();
+
+	free_percpu(dst->v);
+	dst->v = new_counters;
+	dst->nr_counters = dst_counters;
+
+	eytzinger0_sort(dst->k.data, dst->k.nr, sizeof(dst->k.data[0]), accounting_pos_cmp, NULL);
+
+	return 0;
+err:
+	dst->k.nr = orig_dst_k_nr;
+	return -BCH_ERR_ENOMEM_disk_accounting;
+}
+
 int bch2_fs_replicas_usage_read(struct bch_fs *c, darray_char *usage)
 {
-	struct bch_accounting_mem *acc = &c->accounting;
+	struct bch_accounting_mem *acc = &c->accounting[0];
 	int ret = 0;
 
 	darray_init(usage);
@@ -234,6 +282,85 @@ int bch2_fs_replicas_usage_read(struct bch_fs *c, darray_char *usage)
 	return ret;
 }
 
+static int accounting_write_key(struct btree_trans *trans, struct bpos pos, u64 *v, unsigned nr_counters)
+{
+	struct bkey_i_accounting *a = bch2_trans_kmalloc(trans, sizeof(*a) + sizeof(*v) * nr_counters);
+	int ret = PTR_ERR_OR_ZERO(a);
+	if (ret)
+		return ret;
+
+	bkey_accounting_init(&a->k_i);
+	a->k.p = pos;
+	set_bkey_val_bytes(&a->k, sizeof(a->v) + sizeof(*v) * nr_counters);
+	memcpy(a->v.d, v, sizeof(*v) * nr_counters);
+
+	return bch2_btree_insert_trans(trans, BTREE_ID_accounting, &a->k_i, 0);
+}
+
+int bch2_accounting_gc_done(struct bch_fs *c)
+{
+	struct bch_accounting_mem *dst = &c->accounting[0];
+	struct bch_accounting_mem *src = &c->accounting[1];
+	struct btree_trans *trans = bch2_trans_get(c);
+	struct printbuf buf = PRINTBUF;
+	int ret = 0;
+
+	percpu_down_write(&c->mark_lock);
+
+	ret   = copy_counters(dst, src) ?:
+		copy_counters(src, dst);
+	if (ret)
+		goto err;
+
+	BUG_ON(dst->k.nr != src->k.nr);
+
+	for (unsigned i = 0; i < src->k.nr; i++) {
+		BUG_ON(src->k.data[i].nr_counters != dst->k.data[i].nr_counters);
+		BUG_ON(!bpos_eq(dst->k.data[i].pos, src->k.data[i].pos));
+
+		struct disk_accounting_key acc_k;
+		bpos_to_disk_accounting_key(&acc_k, src->k.data[i].pos);
+
+		unsigned nr = src->k.data[i].nr_counters;
+		u64 src_v[BCH_ACCOUNTING_MAX_COUNTERS];
+		u64 dst_v[BCH_ACCOUNTING_MAX_COUNTERS];
+
+		bch2_accounting_mem_read_counters(c, i, dst_v, nr, false);
+		bch2_accounting_mem_read_counters(c, i, src_v, nr, true);
+
+		if (memcmp(dst_v, src_v, nr * sizeof(u64))) {
+			printbuf_reset(&buf);
+			prt_str(&buf, "accounting mismatch for ");
+			bch2_accounting_key_to_text(&buf, &acc_k);
+
+			prt_str(&buf, ": got");
+			for (unsigned j = 0; j < nr; j++)
+				prt_printf(&buf, " %llu", dst_v[j]);
+
+			prt_str(&buf, " should be");
+			for (unsigned j = 0; j < nr; j++)
+				prt_printf(&buf, " %llu", src_v[j]);
+
+			if (fsck_err(c, accounting_mismatch, "%s", buf.buf)) {
+				for (unsigned j = 0; j < dst->k.data[i].nr_counters; j++)
+					percpu_u64_set(dst->v + dst->k.data[i].offset + j, src_v[j]);
+
+				ret = commit_do(trans, NULL, NULL, 0,
+						accounting_write_key(trans, src->k.data[i].pos, src_v, nr));
+				if (ret)
+					goto err;
+			}
+		}
+	}
+err:
+fsck_err:
+	percpu_up_write(&c->mark_lock);
+	printbuf_exit(&buf);
+	bch2_trans_put(trans);
+	bch_err_fn(c, ret);
+	return ret;
+}
+
 static bool accounting_key_is_zero(struct bkey_s_c_accounting a)
 {
 
@@ -251,7 +378,7 @@ static int accounting_read_key(struct bch_fs *c, struct bkey_s_c k)
 		return 0;
 
 	percpu_down_read(&c->mark_lock);
-	int ret = __bch2_accounting_mem_add(c, bkey_s_c_to_accounting(k));
+	int ret = __bch2_accounting_mem_add(c, bkey_s_c_to_accounting(k), false);
 	percpu_up_read(&c->mark_lock);
 
 	if (accounting_key_is_zero(bkey_s_c_to_accounting(k)) &&
@@ -274,7 +401,7 @@ static int accounting_read_key(struct bch_fs *c, struct bkey_s_c k)
 
 int bch2_accounting_read(struct bch_fs *c)
 {
-	struct bch_accounting_mem *acc = &c->accounting;
+	struct bch_accounting_mem *acc = &c->accounting[0];
 
 	int ret = bch2_trans_run(c,
 		for_each_btree_key(trans, iter,
@@ -321,7 +448,7 @@ int bch2_accounting_read(struct bch_fs *c)
 		bpos_to_disk_accounting_key(&k, acc->k.data[i].pos);
 
 		u64 v[BCH_ACCOUNTING_MAX_COUNTERS];
-		bch2_accounting_mem_read_counters(c, i, v, ARRAY_SIZE(v));
+		bch2_accounting_mem_read_counters(c, i, v, ARRAY_SIZE(v), false);
 
 		switch (k.type) {
 		case BCH_DISK_ACCOUNTING_persistent_reserved:
@@ -370,8 +497,9 @@ int bch2_dev_usage_remove(struct bch_fs *c, unsigned dev)
 		bch2_btree_write_buffer_flush_sync(trans));
 }
 
-int bch2_dev_usage_init(struct bch_dev *ca)
+int bch2_dev_usage_init(struct bch_dev *ca, bool gc)
 {
+	struct bch_fs *c = ca->fs;
 	struct disk_accounting_key acc = {
 		.type = BCH_DISK_ACCOUNTING_dev_data_type,
 		.dev_data_type.dev = ca->dev_idx,
@@ -379,14 +507,21 @@ int bch2_dev_usage_init(struct bch_dev *ca)
 	};
 	u64 v[3] = { ca->mi.nbuckets - ca->mi.first_bucket, 0, 0 };
 
-	return bch2_trans_do(ca->fs, NULL, NULL, 0,
-			     bch2_disk_accounting_mod(trans, &acc, v, ARRAY_SIZE(v)));
+	int ret = bch2_trans_do(c, NULL, NULL, 0,
+			bch2_disk_accounting_mod(trans, &acc, v, ARRAY_SIZE(v), gc));
+	bch_err_fn(c, ret);
+	return ret;
 }
 
-void bch2_fs_accounting_exit(struct bch_fs *c)
+void bch2_accounting_free(struct bch_accounting_mem *acc)
 {
-	struct bch_accounting_mem *acc = &c->accounting;
-
 	darray_exit(&acc->k);
 	free_percpu(acc->v);
+	acc->v = NULL;
+	acc->nr_counters = 0;
+}
+
+void bch2_fs_accounting_exit(struct bch_fs *c)
+{
+	bch2_accounting_free(&c->accounting[0]);
 }
diff --git a/fs/bcachefs/disk_accounting.h b/fs/bcachefs/disk_accounting.h
index a8526bf43207..70ac67f4a3cb 100644
--- a/fs/bcachefs/disk_accounting.h
+++ b/fs/bcachefs/disk_accounting.h
@@ -78,11 +78,9 @@ static inline struct bpos disk_accounting_key_to_bpos(struct disk_accounting_key
 	return ret;
 }
 
-int bch2_disk_accounting_mod(struct btree_trans *,
-			     struct disk_accounting_key *,
-			     s64 *, unsigned);
-int bch2_mod_dev_cached_sectors(struct btree_trans *trans,
-				unsigned dev, s64 sectors);
+int bch2_disk_accounting_mod(struct btree_trans *, struct disk_accounting_key *,
+			     s64 *, unsigned, bool);
+int bch2_mod_dev_cached_sectors(struct btree_trans *, unsigned, s64, bool);
 
 int bch2_accounting_invalid(struct bch_fs *, struct bkey_s_c,
 			    enum bkey_invalid_flags, struct printbuf *);
@@ -106,15 +104,15 @@ static inline int accounting_pos_cmp(const void *_l, const void *_r)
 	return bpos_cmp(*l, *r);
 }
 
-int bch2_accounting_mem_add_slowpath(struct bch_fs *, struct bkey_s_c_accounting);
+int bch2_accounting_mem_add_slowpath(struct bch_fs *, struct bkey_s_c_accounting, bool);
 
-static inline int __bch2_accounting_mem_add(struct bch_fs *c, struct bkey_s_c_accounting a)
+static inline int __bch2_accounting_mem_add(struct bch_fs *c, struct bkey_s_c_accounting a, bool gc)
 {
-	struct bch_accounting_mem *acc = &c->accounting;
+	struct bch_accounting_mem *acc = &c->accounting[gc];
 	unsigned idx = eytzinger0_find(acc->k.data, acc->k.nr, sizeof(acc->k.data[0]),
 				       accounting_pos_cmp, &a.k->p);
 	if (unlikely(idx >= acc->k.nr))
-		return bch2_accounting_mem_add_slowpath(c, a);
+		return bch2_accounting_mem_add_slowpath(c, a, gc);
 
 	unsigned offset = acc->k.data[idx].offset;
 
@@ -125,37 +123,48 @@ static inline int __bch2_accounting_mem_add(struct bch_fs *c, struct bkey_s_c_ac
 	return 0;
 }
 
-static inline int bch2_accounting_mem_add(struct btree_trans *trans, struct bkey_s_c_accounting a)
+static inline int bch2_accounting_mem_add_locked(struct btree_trans *trans, struct bkey_s_c_accounting a, bool gc)
 {
 	struct bch_fs *c = trans->c;
-	struct disk_accounting_key acc_k;
-	bpos_to_disk_accounting_key(&acc_k, a.k->p);
 
-	switch (acc_k.type) {
-	case BCH_DISK_ACCOUNTING_persistent_reserved:
-		trans->fs_usage_delta.reserved += acc_k.persistent_reserved.nr_replicas * a.v->d[0];
-		break;
-	case BCH_DISK_ACCOUNTING_replicas:
-		fs_usage_data_type_to_base(&trans->fs_usage_delta, acc_k.replicas.data_type, a.v->d[0]);
-		break;
-	case BCH_DISK_ACCOUNTING_dev_data_type: {
-		struct bch_dev *ca = bch_dev_bkey_exists(c, acc_k.dev_data_type.dev);
-
-		this_cpu_add(ca->usage->d[acc_k.dev_data_type.data_type].buckets, a.v->d[0]);
-		this_cpu_add(ca->usage->d[acc_k.dev_data_type.data_type].sectors, a.v->d[1]);
-		this_cpu_add(ca->usage->d[acc_k.dev_data_type.data_type].fragmented, a.v->d[2]);
+	if (!gc) {
+		struct disk_accounting_key acc_k;
+		bpos_to_disk_accounting_key(&acc_k, a.k->p);
+
+		switch (acc_k.type) {
+		case BCH_DISK_ACCOUNTING_persistent_reserved:
+			trans->fs_usage_delta.reserved += acc_k.persistent_reserved.nr_replicas * a.v->d[0];
+			break;
+		case BCH_DISK_ACCOUNTING_replicas:
+			fs_usage_data_type_to_base(&trans->fs_usage_delta, acc_k.replicas.data_type, a.v->d[0]);
+			break;
+		case BCH_DISK_ACCOUNTING_dev_data_type: {
+			struct bch_dev *ca = bch_dev_bkey_exists(c, acc_k.dev_data_type.dev);
+
+			this_cpu_add(ca->usage->d[acc_k.dev_data_type.data_type].buckets, a.v->d[0]);
+			this_cpu_add(ca->usage->d[acc_k.dev_data_type.data_type].sectors, a.v->d[1]);
+			this_cpu_add(ca->usage->d[acc_k.dev_data_type.data_type].fragmented, a.v->d[2]);
+		}
+		}
 	}
-	}
-	return __bch2_accounting_mem_add(c, a);
+
+	return __bch2_accounting_mem_add(c, a, gc);
 }
 
-static inline void bch2_accounting_mem_read_counters(struct bch_fs *c,
-						     unsigned idx,
-						     u64 *v, unsigned nr)
+static inline int bch2_accounting_mem_add(struct btree_trans *trans, struct bkey_s_c_accounting a, bool gc)
+{
+	percpu_down_read(&trans->c->mark_lock);
+	int ret = bch2_accounting_mem_add_locked(trans, a, gc);
+	percpu_up_read(&trans->c->mark_lock);
+	return ret;
+}
+
+static inline void bch2_accounting_mem_read_counters(struct bch_fs *c, unsigned idx,
+						     u64 *v, unsigned nr, bool gc)
 {
 	memset(v, 0, sizeof(*v) * nr);
 
-	struct bch_accounting_mem *acc = &c->accounting;
+	struct bch_accounting_mem *acc = &c->accounting[0];
 	if (unlikely(idx >= acc->k.nr))
 		return;
 
@@ -169,19 +178,23 @@ static inline void bch2_accounting_mem_read_counters(struct bch_fs *c,
 static inline void bch2_accounting_mem_read(struct bch_fs *c, struct bpos p,
 					    u64 *v, unsigned nr)
 {
-	struct bch_accounting_mem *acc = &c->accounting;
+	struct bch_accounting_mem *acc = &c->accounting[0];
 	unsigned idx = eytzinger0_find(acc->k.data, acc->k.nr, sizeof(acc->k.data[0]),
 				       accounting_pos_cmp, &p);
 
-	bch2_accounting_mem_read_counters(c, idx, v, nr);
+	bch2_accounting_mem_read_counters(c, idx, v, nr, false);
 }
 
 int bch2_fs_replicas_usage_read(struct bch_fs *, darray_char *);
 
+int bch2_accounting_gc_done(struct bch_fs *);
+
 int bch2_accounting_read(struct bch_fs *);
 
 int bch2_dev_usage_remove(struct bch_fs *, unsigned);
-int bch2_dev_usage_init(struct bch_dev *);
+int bch2_dev_usage_init(struct bch_dev *, bool);
+
+void bch2_accounting_free(struct bch_accounting_mem *);
 void bch2_fs_accounting_exit(struct bch_fs *);
 
 #endif /* _BCACHEFS_DISK_ACCOUNTING_H */
diff --git a/fs/bcachefs/ec.c b/fs/bcachefs/ec.c
index 38e5e882f4a4..bd435d385559 100644
--- a/fs/bcachefs/ec.c
+++ b/fs/bcachefs/ec.c
@@ -238,10 +238,8 @@ static int bch2_trans_mark_stripe_bucket(struct btree_trans *trans,
 	return ret;
 }
 
-static int mark_stripe_bucket(struct btree_trans *trans,
-			      struct bkey_s_c k,
-			      unsigned ptr_idx,
-			      unsigned flags)
+static int mark_stripe_bucket(struct btree_trans *trans, struct bkey_s_c k,
+			      unsigned ptr_idx, unsigned flags)
 {
 	struct bch_fs *c = trans->c;
 	const struct bch_stripe *s = bkey_s_c_to_stripe(k).v;
@@ -287,13 +285,16 @@ static int mark_stripe_bucket(struct btree_trans *trans,
 	g->stripe		= k.k->p.offset;
 	g->stripe_redundancy	= s->nr_redundant;
 	new = *g;
-err:
 	bucket_unlock(g);
-	if (!ret)
-		bch2_dev_usage_update_m(c, ca, &old, &new);
 	percpu_up_read(&c->mark_lock);
+	ret = bch2_bucket_to_dev_counters(trans, ca, &old, &new, flags);
+out:
 	printbuf_exit(&buf);
 	return ret;
+err:
+	bucket_unlock(g);
+	percpu_up_read(&c->mark_lock);
+	goto out;
 }
 
 int bch2_trigger_stripe(struct btree_trans *trans,
@@ -309,7 +310,12 @@ int bch2_trigger_stripe(struct btree_trans *trans,
 	const struct bch_stripe *new_s = new.k->type == KEY_TYPE_stripe
 		? bkey_s_c_to_stripe(new).v : NULL;
 
-	if (flags & BTREE_TRIGGER_TRANSACTIONAL) {
+	BUG_ON(new_s && old_s &&
+	       (new_s->nr_blocks	!= old_s->nr_blocks ||
+		new_s->nr_redundant	!= old_s->nr_redundant));
+
+
+	if (flags & (BTREE_TRIGGER_TRANSACTIONAL|BTREE_TRIGGER_GC)) {
 		/*
 		 * If the pointers aren't changing, we don't need to do anything:
 		 */
@@ -320,9 +326,34 @@ int bch2_trigger_stripe(struct btree_trans *trans,
 			    new_s->nr_blocks * sizeof(struct bch_extent_ptr)))
 			return 0;
 
-		BUG_ON(new_s && old_s &&
-		       (new_s->nr_blocks	!= old_s->nr_blocks ||
-			new_s->nr_redundant	!= old_s->nr_redundant));
+		struct gc_stripe *gc = NULL;
+		if (flags & BTREE_TRIGGER_GC) {
+			gc = genradix_ptr_alloc(&c->gc_stripes, idx, GFP_KERNEL);
+			if (!gc) {
+				bch_err(c, "error allocating memory for gc_stripes, idx %llu", idx);
+				return -BCH_ERR_ENOMEM_mark_stripe;
+			}
+
+			/*
+			 * This will be wrong when we bring back runtime gc: we should
+			 * be unmarking the old key and then marking the new key
+			 *
+			 * Also: when we bring back runtime gc, locking
+			 */
+			gc->alive	= true;
+			gc->sectors	= le16_to_cpu(new_s->sectors);
+			gc->nr_blocks	= new_s->nr_blocks;
+			gc->nr_redundant	= new_s->nr_redundant;
+
+			for (unsigned i = 0; i < new_s->nr_blocks; i++)
+				gc->ptrs[i] = new_s->ptrs[i];
+
+			/*
+			 * gc recalculates this field from stripe ptr
+			 * references:
+			 */
+			memset(gc->block_sectors, 0, sizeof(gc->block_sectors));
+		}
 
 		if (new_s) {
 			s64 sectors = (u64) le16_to_cpu(new_s->sectors) * new_s->nr_redundant;
@@ -331,9 +362,12 @@ int bch2_trigger_stripe(struct btree_trans *trans,
 				.type = BCH_DISK_ACCOUNTING_replicas,
 			};
 			bch2_bkey_to_replicas(&acc.replicas, new);
-			int ret = bch2_disk_accounting_mod(trans, &acc, &sectors, 1);
+			int ret = bch2_disk_accounting_mod(trans, &acc, &sectors, 1, gc);
 			if (ret)
 				return ret;
+
+			if (gc)
+				memcpy(&gc->r.e, &acc.replicas, replicas_entry_bytes(&acc.replicas));
 		}
 
 		if (old_s) {
@@ -343,29 +377,42 @@ int bch2_trigger_stripe(struct btree_trans *trans,
 				.type = BCH_DISK_ACCOUNTING_replicas,
 			};
 			bch2_bkey_to_replicas(&acc.replicas, old);
-			int ret = bch2_disk_accounting_mod(trans, &acc, &sectors, 1);
+			int ret = bch2_disk_accounting_mod(trans, &acc, &sectors, 1, gc);
 			if (ret)
 				return ret;
 		}
 
 		unsigned nr_blocks = new_s ? new_s->nr_blocks : old_s->nr_blocks;
-		for (unsigned i = 0; i < nr_blocks; i++) {
-			if (new_s && old_s &&
-			    !memcmp(&new_s->ptrs[i],
-				    &old_s->ptrs[i],
-				    sizeof(new_s->ptrs[i])))
-				continue;
 
-			if (new_s) {
-				int ret = bch2_trans_mark_stripe_bucket(trans,
-						bkey_s_c_to_stripe(new), i, false);
-				if (ret)
-					return ret;
+		if (flags & BTREE_TRIGGER_TRANSACTIONAL) {
+			for (unsigned i = 0; i < nr_blocks; i++) {
+				if (new_s && old_s &&
+				    !memcmp(&new_s->ptrs[i],
+					    &old_s->ptrs[i],
+					    sizeof(new_s->ptrs[i])))
+					continue;
+
+				if (new_s) {
+					int ret = bch2_trans_mark_stripe_bucket(trans,
+							bkey_s_c_to_stripe(new), i, false);
+					if (ret)
+						return ret;
+				}
+
+				if (old_s) {
+					int ret = bch2_trans_mark_stripe_bucket(trans,
+							bkey_s_c_to_stripe(old), i, true);
+					if (ret)
+						return ret;
+				}
 			}
+		}
 
-			if (old_s) {
-				int ret = bch2_trans_mark_stripe_bucket(trans,
-						bkey_s_c_to_stripe(old), i, true);
+		if (flags & BTREE_TRIGGER_GC) {
+			BUG_ON(old_s);
+
+			for (unsigned i = 0; i < nr_blocks; i++) {
+				int ret = mark_stripe_bucket(trans, new, i, flags);
 				if (ret)
 					return ret;
 			}
@@ -411,53 +458,6 @@ int bch2_trigger_stripe(struct btree_trans *trans,
 		}
 	}
 
-	if (flags & BTREE_TRIGGER_GC) {
-		struct gc_stripe *m =
-			genradix_ptr_alloc(&c->gc_stripes, idx, GFP_KERNEL);
-
-		if (!m) {
-			bch_err(c, "error allocating memory for gc_stripes, idx %llu",
-				idx);
-			return -BCH_ERR_ENOMEM_mark_stripe;
-		}
-		/*
-		 * This will be wrong when we bring back runtime gc: we should
-		 * be unmarking the old key and then marking the new key
-		 */
-		m->alive	= true;
-		m->sectors	= le16_to_cpu(new_s->sectors);
-		m->nr_blocks	= new_s->nr_blocks;
-		m->nr_redundant	= new_s->nr_redundant;
-
-		for (unsigned i = 0; i < new_s->nr_blocks; i++)
-			m->ptrs[i] = new_s->ptrs[i];
-
-		bch2_bkey_to_replicas(&m->r.e, new);
-
-		/*
-		 * gc recalculates this field from stripe ptr
-		 * references:
-		 */
-		memset(m->block_sectors, 0, sizeof(m->block_sectors));
-
-		for (unsigned i = 0; i < new_s->nr_blocks; i++) {
-			int ret = mark_stripe_bucket(trans, new, i, flags);
-			if (ret)
-				return ret;
-		}
-
-		int ret = bch2_update_replicas(c, new, &m->r.e,
-				      ((s64) m->sectors * m->nr_redundant));
-		if (ret) {
-			struct printbuf buf = PRINTBUF;
-
-			bch2_bkey_val_to_text(&buf, c, new);
-			bch2_fs_fatal_error(c, "no replicas entry for %s", buf.buf);
-			printbuf_exit(&buf);
-			return ret;
-		}
-	}
-
 	return 0;
 }
 
diff --git a/fs/bcachefs/inode.c b/fs/bcachefs/inode.c
index 3dfa9f77c739..e8f128d6b703 100644
--- a/fs/bcachefs/inode.c
+++ b/fs/bcachefs/inode.c
@@ -607,41 +607,26 @@ int bch2_trigger_inode(struct btree_trans *trans,
 		       struct bkey_s new,
 		       unsigned flags)
 {
-	s64 nr = bkey_is_inode(new.k) - bkey_is_inode(old.k);
-
-	if (flags & BTREE_TRIGGER_TRANSACTIONAL) {
-		if (nr) {
-			struct disk_accounting_key acc = {
-				.type = BCH_DISK_ACCOUNTING_nr_inodes
-			};
-
-			int ret = bch2_disk_accounting_mod(trans, &acc, &nr, 1);
-			if (ret)
-				return ret;
-		}
-
-		bool old_deleted = bkey_is_deleted_inode(old);
-		bool new_deleted = bkey_is_deleted_inode(new.s_c);
-		if (old_deleted != new_deleted) {
-			int ret = bch2_btree_bit_mod_buffered(trans, BTREE_ID_deleted_inodes,
-							      new.k->p, new_deleted);
-			if (ret)
-				return ret;
-		}
-	}
-
 	if ((flags & BTREE_TRIGGER_ATOMIC) && (flags & BTREE_TRIGGER_INSERT)) {
 		BUG_ON(!trans->journal_res.seq);
-
 		bkey_s_to_inode_v3(new).v->bi_journal_seq = cpu_to_le64(trans->journal_res.seq);
 	}
 
-	if (flags & BTREE_TRIGGER_GC) {
-		struct bch_fs *c = trans->c;
+	s64 nr = bkey_is_inode(new.k) - bkey_is_inode(old.k);
+	if ((flags & (BTREE_TRIGGER_TRANSACTIONAL|BTREE_TRIGGER_GC)) && nr) {
+		struct disk_accounting_key acc = { .type = BCH_DISK_ACCOUNTING_nr_inodes };
+		int ret = bch2_disk_accounting_mod(trans, &acc, &nr, 1, flags & BTREE_TRIGGER_GC);
+		if (ret)
+			return ret;
+	}
 
-		percpu_down_read(&c->mark_lock);
-		this_cpu_add(c->usage_gc->b.nr_inodes, nr);
-		percpu_up_read(&c->mark_lock);
+	int deleted_delta =	(int) bkey_is_deleted_inode(new.s_c) -
+				(int) bkey_is_deleted_inode(old);
+	if ((flags & BTREE_TRIGGER_TRANSACTIONAL) && deleted_delta) {
+		int ret = bch2_btree_bit_mod_buffered(trans, BTREE_ID_deleted_inodes,
+						      new.k->p, deleted_delta > 0);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
diff --git a/fs/bcachefs/recovery.c b/fs/bcachefs/recovery.c
index 18fd71960d2e..6a8b2c753688 100644
--- a/fs/bcachefs/recovery.c
+++ b/fs/bcachefs/recovery.c
@@ -1177,8 +1177,7 @@ int bch2_fs_initialize(struct bch_fs *c)
 		goto err;
 
 	for_each_member_device(c, ca) {
-		ret = bch2_dev_usage_init(ca);
-		bch_err_msg(c, ret, "initializing device usage");
+		ret = bch2_dev_usage_init(ca, false);
 		if (ret) {
 			percpu_ref_put(&ca->ref);
 			goto err;
diff --git a/fs/bcachefs/replicas.c b/fs/bcachefs/replicas.c
index 427dc6711427..cba5ba44cfd8 100644
--- a/fs/bcachefs/replicas.c
+++ b/fs/bcachefs/replicas.c
@@ -275,73 +275,6 @@ bool bch2_replicas_marked(struct bch_fs *c,
 	return ret;
 }
 
-static void __replicas_table_update(struct bch_fs_usage *dst,
-				    struct bch_replicas_cpu *dst_r,
-				    struct bch_fs_usage *src,
-				    struct bch_replicas_cpu *src_r)
-{
-	int src_idx, dst_idx;
-
-	*dst = *src;
-
-	for (src_idx = 0; src_idx < src_r->nr; src_idx++) {
-		if (!src->replicas[src_idx])
-			continue;
-
-		dst_idx = __replicas_entry_idx(dst_r,
-				cpu_replicas_entry(src_r, src_idx));
-		BUG_ON(dst_idx < 0);
-
-		dst->replicas[dst_idx] = src->replicas[src_idx];
-	}
-}
-
-static void __replicas_table_update_pcpu(struct bch_fs_usage __percpu *dst_p,
-				    struct bch_replicas_cpu *dst_r,
-				    struct bch_fs_usage __percpu *src_p,
-				    struct bch_replicas_cpu *src_r)
-{
-	unsigned src_nr = sizeof(struct bch_fs_usage) / sizeof(u64) + src_r->nr;
-	struct bch_fs_usage *dst, *src = (void *)
-		bch2_acc_percpu_u64s((u64 __percpu *) src_p, src_nr);
-
-	preempt_disable();
-	dst = this_cpu_ptr(dst_p);
-	preempt_enable();
-
-	__replicas_table_update(dst, dst_r, src, src_r);
-}
-
-/*
- * Resize filesystem accounting:
- */
-static int replicas_table_update(struct bch_fs *c,
-				 struct bch_replicas_cpu *new_r)
-{
-	struct bch_fs_usage __percpu *new_gc = NULL;
-	unsigned bytes = sizeof(struct bch_fs_usage) +
-		sizeof(u64) * new_r->nr;
-	int ret = 0;
-
-	if ((c->usage_gc &&
-	     !(new_gc = __alloc_percpu_gfp(bytes, sizeof(u64), GFP_KERNEL))))
-		goto err;
-
-	if (c->usage_gc)
-		__replicas_table_update_pcpu(new_gc,		new_r,
-					     c->usage_gc,	&c->replicas);
-
-	swap(c->usage_gc,	new_gc);
-	swap(c->replicas,	*new_r);
-out:
-	free_percpu(new_gc);
-	return ret;
-err:
-	bch_err(c, "error updating replicas table: memory allocation failure");
-	ret = -BCH_ERR_ENOMEM_replicas_table;
-	goto out;
-}
-
 noinline
 static int bch2_mark_replicas_slowpath(struct bch_fs *c,
 				struct bch_replicas_entry_v1 *new_entry)
@@ -389,7 +322,7 @@ static int bch2_mark_replicas_slowpath(struct bch_fs *c,
 	/* don't update in memory replicas until changes are persistent */
 	percpu_down_write(&c->mark_lock);
 	if (new_r.entries)
-		ret = replicas_table_update(c, &new_r);
+		swap(c->replicas, new_r);
 	if (new_gc.entries)
 		swap(new_gc, c->replicas_gc);
 	percpu_up_write(&c->mark_lock);
@@ -424,8 +357,9 @@ int bch2_replicas_gc_end(struct bch_fs *c, int ret)
 	percpu_down_write(&c->mark_lock);
 
 	ret =   ret ?:
-		bch2_cpu_replicas_to_sb_replicas(c, &c->replicas_gc) ?:
-		replicas_table_update(c, &c->replicas_gc);
+		bch2_cpu_replicas_to_sb_replicas(c, &c->replicas_gc);
+	if (!ret)
+		swap(c->replicas, c->replicas_gc);
 
 	kfree(c->replicas_gc.entries);
 	c->replicas_gc.entries = NULL;
@@ -635,8 +569,7 @@ int bch2_sb_replicas_to_cpu_replicas(struct bch_fs *c)
 	bch2_cpu_replicas_sort(&new_r);
 
 	percpu_down_write(&c->mark_lock);
-
-	ret = replicas_table_update(c, &new_r);
+	swap(c->replicas, new_r);
 	percpu_up_write(&c->mark_lock);
 
 	kfree(new_r.entries);
@@ -927,10 +860,8 @@ unsigned bch2_sb_dev_has_data(struct bch_sb *sb, unsigned dev)
 
 unsigned bch2_dev_has_data(struct bch_fs *c, struct bch_dev *ca)
 {
-	unsigned ret;
-
 	mutex_lock(&c->sb_lock);
-	ret = bch2_sb_dev_has_data(c->disk_sb.sb, ca->dev_idx);
+	unsigned ret = bch2_sb_dev_has_data(c->disk_sb.sb, ca->dev_idx);
 	mutex_unlock(&c->sb_lock);
 
 	return ret;
@@ -941,8 +872,3 @@ void bch2_fs_replicas_exit(struct bch_fs *c)
 	kfree(c->replicas.entries);
 	kfree(c->replicas_gc.entries);
 }
-
-int bch2_fs_replicas_init(struct bch_fs *c)
-{
-	return replicas_table_update(c, &c->replicas);
-}
diff --git a/fs/bcachefs/replicas.h b/fs/bcachefs/replicas.h
index eac2dff20423..ab2d00e4865c 100644
--- a/fs/bcachefs/replicas.h
+++ b/fs/bcachefs/replicas.h
@@ -80,6 +80,5 @@ extern const struct bch_sb_field_ops bch_sb_field_ops_replicas;
 extern const struct bch_sb_field_ops bch_sb_field_ops_replicas_v0;
 
 void bch2_fs_replicas_exit(struct bch_fs *);
-int bch2_fs_replicas_init(struct bch_fs *);
 
 #endif /* _BCACHEFS_REPLICAS_H */
diff --git a/fs/bcachefs/super.c b/fs/bcachefs/super.c
index 89c481831608..6617c8912e51 100644
--- a/fs/bcachefs/super.c
+++ b/fs/bcachefs/super.c
@@ -894,7 +894,6 @@ static struct bch_fs *bch2_fs_alloc(struct bch_sb *sb, struct bch_opts opts)
 	    bch2_io_clock_init(&c->io_clock[READ]) ?:
 	    bch2_io_clock_init(&c->io_clock[WRITE]) ?:
 	    bch2_fs_journal_init(&c->journal) ?:
-	    bch2_fs_replicas_init(c) ?:
 	    bch2_fs_btree_cache_init(c) ?:
 	    bch2_fs_btree_key_cache_init(&c->btree_key_cache) ?:
 	    bch2_fs_btree_iter_init(c) ?:
@@ -1772,7 +1771,7 @@ int bch2_dev_add(struct bch_fs *c, const char *path)
 	bch2_write_super(c);
 	mutex_unlock(&c->sb_lock);
 
-	ret = bch2_dev_usage_init(ca);
+	ret = bch2_dev_usage_init(ca, false);
 	if (ret)
 		goto err_late;
 
@@ -1946,9 +1945,9 @@ int bch2_dev_resize(struct bch_fs *c, struct bch_dev *ca, u64 nbuckets)
 		};
 		u64 v[3] = { nbuckets - old_nbuckets, 0, 0 };
 
-		ret   = bch2_dev_freespace_init(c, ca, old_nbuckets, nbuckets) ?:
-			bch2_trans_do(ca->fs, NULL, NULL, 0,
-				bch2_disk_accounting_mod(trans, &acc, v, ARRAY_SIZE(v)));
+		ret   = bch2_trans_do(ca->fs, NULL, NULL, 0,
+				bch2_disk_accounting_mod(trans, &acc, v, ARRAY_SIZE(v), false)) ?:
+			bch2_dev_freespace_init(c, ca, old_nbuckets, nbuckets);
 		if (ret)
 			goto err;
 	}
-- 
2.43.0


