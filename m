Return-Path: <linux-kernel+bounces-79936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 851578628D9
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 03:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6698B214C1
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 02:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439CA14A9D;
	Sun, 25 Feb 2024 02:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t7fnIL2w"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF82C6110
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 02:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708828724; cv=none; b=f33UeqjZtwse7s3J1oG0Ff5VEHRNH+O/OhdgbAcPcbGMMyBb4p7AimDjSqY1MB3Yrpr0grdCdWNx6GjZ24sGOCX14BZjdO2zYlc69MtXTuG4lKLMszHm6LhL4vVqdT0JzOfZqStd/M916bxcPnI4S5IoZ0pbNW7pVQn2DRnjZ8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708828724; c=relaxed/simple;
	bh=Uiispgyd16fXObybQtFcG61HaR8E3O/9zhg2YHGpe6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W9eT8vDFfiNkS0Y5J3k9eOMqOadO9gxpBRVH7QqvNnlEwBDSq5XZdL5yLS4GVYOMQyzYWGsKgnqOv27BmvzO04cFWCcJIj7QytKXxj4GzEkTbyLq1FOK+AWe9tzD0TlIPCbNHxajp4xzfj8M/bCK3e6GYi4zlETaXEYQLy8BISQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t7fnIL2w; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708828718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Tn76/W0CbcMhsnTJQ9k3lY0axZy5xliCVw9DtTqxy8=;
	b=t7fnIL2wcLeCy/VOq8jcCQf5gADKop8vRerdJn6/OLbp0bN6Bu+GF8RVrqLEey2W/ad3Sw
	B6Sdo2r/2qdSHPWsDgDJq1VRRjbEv2yWwk1ri6Wxh4Q2tiSGvnT662Lemw2MAX/52gPLK1
	M1UgpiPx3yVEpu6obP8RunSyd/tK5kA=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	djwong@kernel.org,
	bfoster@redhat.com
Subject: [PATCH 04/21] bcachefs: Disk space accounting rewrite
Date: Sat, 24 Feb 2024 21:38:06 -0500
Message-ID: <20240225023826.2413565-5-kent.overstreet@linux.dev>
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

Main part of the disk accounting rewrite.

This is a wholesale rewrite of the existing disk space accounting, which
relies on percepu counters that are sharded by journal buffer, and
rolled up and added to each journal write.

With the new scheme, every set of counters is a distinct key in the
accounting btree; this fixes scaling limitations of the old scheme,
where counters took up space in each journal entry and required multiple
percpu counters.

Now, in memory accounting requires a single set of percpu counters - not
multiple for each in flight journal buffer - and in the future we'll
probably also have counters that don't use in memory percpu counters,
they're not strictly required.

An accounting update is now a normal btree update, using the btree write
buffer path. At transaction commit time, we apply accounting updates to
the in memory counters, which are percpu counters indexed in an
eytzinger tree by the accounting key.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/bcachefs/alloc_background.c      |  68 +++++-
 fs/bcachefs/bcachefs.h              |   6 +-
 fs/bcachefs/bcachefs_format.h       |   1 -
 fs/bcachefs/bcachefs_ioctl.h        |   7 +-
 fs/bcachefs/btree_gc.c              |   3 +-
 fs/bcachefs/btree_iter.c            |   9 -
 fs/bcachefs/btree_trans_commit.c    |  62 ++++--
 fs/bcachefs/btree_types.h           |   1 -
 fs/bcachefs/btree_update.h          |   8 -
 fs/bcachefs/buckets.c               | 289 +++++---------------------
 fs/bcachefs/buckets.h               |  33 +--
 fs/bcachefs/disk_accounting.c       | 308 ++++++++++++++++++++++++++++
 fs/bcachefs/disk_accounting.h       | 126 ++++++++++++
 fs/bcachefs/disk_accounting_types.h |  20 ++
 fs/bcachefs/ec.c                    |  24 ++-
 fs/bcachefs/inode.c                 |   9 +-
 fs/bcachefs/recovery.c              |  12 +-
 fs/bcachefs/recovery_types.h        |   1 +
 fs/bcachefs/replicas.c              |  42 ++--
 fs/bcachefs/replicas.h              |  11 +-
 fs/bcachefs/replicas_types.h        |  16 --
 fs/bcachefs/sb-errors_types.h       |   3 +-
 fs/bcachefs/super.c                 |  49 +++--
 23 files changed, 704 insertions(+), 404 deletions(-)
 create mode 100644 fs/bcachefs/disk_accounting_types.h

diff --git a/fs/bcachefs/alloc_background.c b/fs/bcachefs/alloc_background.c
index ccd6cbfd470e..d8ad5bb28a7f 100644
--- a/fs/bcachefs/alloc_background.c
+++ b/fs/bcachefs/alloc_background.c
@@ -14,6 +14,7 @@
 #include "buckets_waiting_for_journal.h"
 #include "clock.h"
 #include "debug.h"
+#include "disk_accounting.h"
 #include "ec.h"
 #include "error.h"
 #include "lru.h"
@@ -813,8 +814,60 @@ int bch2_trigger_alloc(struct btree_trans *trans,
 
 		if ((flags & BTREE_TRIGGER_BUCKET_INVALIDATE) &&
 		    old_a->cached_sectors) {
-			ret = bch2_update_cached_sectors_list(trans, new.k->p.inode,
-							      -((s64) old_a->cached_sectors));
+			ret = bch2_mod_dev_cached_sectors(trans, new.k->p.inode,
+							  -((s64) old_a->cached_sectors));
+			if (ret)
+				return ret;
+		}
+
+
+		if (old_a->data_type != new_a->data_type ||
+		    old_a->dirty_sectors != new_a->dirty_sectors) {
+			struct disk_accounting_key acc = {
+				.type = BCH_DISK_ACCOUNTING_dev_data_type,
+				.dev_data_type.dev = new.k->p.inode,
+				.dev_data_type.data_type = new_a->data_type,
+			};
+			s64 d[3];
+
+			if (old_a->data_type == new_a->data_type) {
+				d[0] = 0;
+				d[1] = (s64) new_a->dirty_sectors - (s64) old_a->dirty_sectors;
+				d[2] =  bucket_sectors_fragmented(ca, *new_a) -
+					bucket_sectors_fragmented(ca, *old_a);
+
+				ret = bch2_disk_accounting_mod(trans, &acc, d, 3);
+				if (ret)
+					return ret;
+			} else {
+				d[0] = 1;
+				d[1] = new_a->dirty_sectors;
+				d[2] = bucket_sectors_fragmented(ca, *new_a);
+
+				ret = bch2_disk_accounting_mod(trans, &acc, d, 3);
+				if (ret)
+					return ret;
+
+				acc.dev_data_type.data_type = old_a->data_type;
+				d[0] = -1;
+				d[1] = -(s64) old_a->dirty_sectors;
+				d[2] = -bucket_sectors_fragmented(ca, *old_a);
+
+				ret = bch2_disk_accounting_mod(trans, &acc, d, 3);
+				if (ret)
+					return ret;
+			}
+		}
+
+		if (!!old_a->stripe != !!new_a->stripe) {
+			struct disk_accounting_key acc = {
+				.type = BCH_DISK_ACCOUNTING_dev_stripe_buckets,
+				.dev_stripe_buckets.dev = new.k->p.inode,
+			};
+			u64 d[1];
+
+			d[0] = (s64) !!new_a->stripe - (s64) !!old_a->stripe;
+			ret = bch2_disk_accounting_mod(trans, &acc, d, 1);
 			if (ret)
 				return ret;
 		}
@@ -857,12 +910,11 @@ int bch2_trigger_alloc(struct btree_trans *trans,
 			}
 		}
 
-		percpu_down_read(&c->mark_lock);
-		if (new_a->gen != old_a->gen)
+		if (new_a->gen != old_a->gen) {
+			percpu_down_read(&c->mark_lock);
 			*bucket_gen(ca, new.k->p.offset) = new_a->gen;
-
-		bch2_dev_usage_update(c, ca, old_a, new_a, journal_seq, false);
-		percpu_up_read(&c->mark_lock);
+			percpu_up_read(&c->mark_lock);
+		}
 
 #define eval_state(_a, expr)		({ const struct bch_alloc_v4 *a = _a; expr; })
 #define statechange(expr)		!eval_state(old_a, expr) && eval_state(new_a, expr)
@@ -906,6 +958,8 @@ int bch2_trigger_alloc(struct btree_trans *trans,
 
 		bucket_unlock(g);
 		percpu_up_read(&c->mark_lock);
+
+		bch2_dev_usage_update(c, ca, old_a, new_a);
 	}
 
 	return 0;
diff --git a/fs/bcachefs/bcachefs.h b/fs/bcachefs/bcachefs.h
index 9a24989c9a6a..18c00051a8f6 100644
--- a/fs/bcachefs/bcachefs.h
+++ b/fs/bcachefs/bcachefs.h
@@ -207,6 +207,7 @@
 #include <linux/zstd.h>
 
 #include "bcachefs_format.h"
+#include "disk_accounting_types.h"
 #include "errcode.h"
 #include "fifo.h"
 #include "nocow_locking_types.h"
@@ -695,8 +696,6 @@ struct btree_trans_buf {
 	struct btree_trans	*trans;
 };
 
-#define REPLICAS_DELTA_LIST_MAX	(1U << 16)
-
 #define BCACHEFS_ROOT_SUBVOL_INUM					\
 	((subvol_inum) { BCACHEFS_ROOT_SUBVOL,	BCACHEFS_ROOT_INO })
 
@@ -763,10 +762,11 @@ struct bch_fs {
 
 	struct bch_dev __rcu	*devs[BCH_SB_MEMBERS_MAX];
 
+	struct bch_accounting_mem accounting;
+
 	struct bch_replicas_cpu replicas;
 	struct bch_replicas_cpu replicas_gc;
 	struct mutex		replicas_gc_lock;
-	mempool_t		replicas_delta_pool;
 
 	struct journal_entry_res btree_root_journal_res;
 	struct journal_entry_res replicas_journal_res;
diff --git a/fs/bcachefs/bcachefs_format.h b/fs/bcachefs/bcachefs_format.h
index 313ca7dc370d..6edd3fd63bfa 100644
--- a/fs/bcachefs/bcachefs_format.h
+++ b/fs/bcachefs/bcachefs_format.h
@@ -1271,7 +1271,6 @@ static inline bool jset_entry_is_key(struct jset_entry *e)
 	switch (e->type) {
 	case BCH_JSET_ENTRY_btree_keys:
 	case BCH_JSET_ENTRY_btree_root:
-	case BCH_JSET_ENTRY_overwrite:
 	case BCH_JSET_ENTRY_write_buffer_keys:
 		return true;
 	}
diff --git a/fs/bcachefs/bcachefs_ioctl.h b/fs/bcachefs/bcachefs_ioctl.h
index 4b8fba754b1c..0b82a4dd099f 100644
--- a/fs/bcachefs/bcachefs_ioctl.h
+++ b/fs/bcachefs/bcachefs_ioctl.h
@@ -251,10 +251,15 @@ struct bch_replicas_usage {
 	struct bch_replicas_entry_v1 r;
 } __packed;
 
+static inline unsigned replicas_usage_bytes(struct bch_replicas_usage *u)
+{
+	return offsetof(struct bch_replicas_usage, r) + replicas_entry_bytes(&u->r);
+}
+
 static inline struct bch_replicas_usage *
 replicas_usage_next(struct bch_replicas_usage *u)
 {
-	return (void *) u + replicas_entry_bytes(&u->r) + 8;
+	return (void *) u + replicas_usage_bytes(u);
 }
 
 /*
diff --git a/fs/bcachefs/btree_gc.c b/fs/bcachefs/btree_gc.c
index 6c52f116098f..2dfa7ca95fc0 100644
--- a/fs/bcachefs/btree_gc.c
+++ b/fs/bcachefs/btree_gc.c
@@ -827,7 +827,8 @@ static int bch2_gc_mark_key(struct btree_trans *trans, enum btree_id btree_id,
 		if (ret)
 			goto err;
 
-		if (fsck_err_on(k->k->version.lo > atomic64_read(&c->key_version), c,
+		if (fsck_err_on(btree_id != BTREE_ID_accounting &&
+				k->k->version.lo > atomic64_read(&c->key_version), c,
 				bkey_version_in_future,
 				"key version number higher than recorded: %llu > %llu",
 				k->k->version.lo,
diff --git a/fs/bcachefs/btree_iter.c b/fs/bcachefs/btree_iter.c
index 2357af3e6757..ef7cb7174c8b 100644
--- a/fs/bcachefs/btree_iter.c
+++ b/fs/bcachefs/btree_iter.c
@@ -3072,15 +3072,6 @@ void bch2_trans_put(struct btree_trans *trans)
 		srcu_read_unlock(&c->btree_trans_barrier, trans->srcu_idx);
 	}
 
-	if (trans->fs_usage_deltas) {
-		if (trans->fs_usage_deltas->size + sizeof(trans->fs_usage_deltas) ==
-		    REPLICAS_DELTA_LIST_MAX)
-			mempool_free(trans->fs_usage_deltas,
-				     &c->replicas_delta_pool);
-		else
-			kfree(trans->fs_usage_deltas);
-	}
-
 	if (unlikely(trans->journal_replay_not_finished))
 		bch2_journal_keys_put(c);
 
diff --git a/fs/bcachefs/btree_trans_commit.c b/fs/bcachefs/btree_trans_commit.c
index 60f6255367b9..b005e20039bb 100644
--- a/fs/bcachefs/btree_trans_commit.c
+++ b/fs/bcachefs/btree_trans_commit.c
@@ -9,6 +9,7 @@
 #include "btree_update_interior.h"
 #include "btree_write_buffer.h"
 #include "buckets.h"
+#include "disk_accounting.h"
 #include "errcode.h"
 #include "error.h"
 #include "journal.h"
@@ -598,6 +599,14 @@ static noinline int bch2_trans_commit_run_gc_triggers(struct btree_trans *trans)
 	return 0;
 }
 
+static struct bversion journal_pos_to_bversion(struct journal_res *res, unsigned offset)
+{
+	return (struct bversion) {
+		.hi = res->seq >> 32,
+		.lo = (res->seq << 32) | (res->offset + offset),
+	};
+}
+
 static inline int
 bch2_trans_commit_write_locked(struct btree_trans *trans, unsigned flags,
 			       struct btree_insert_entry **stopped_at,
@@ -606,7 +615,7 @@ bch2_trans_commit_write_locked(struct btree_trans *trans, unsigned flags,
 	struct bch_fs *c = trans->c;
 	struct btree_trans_commit_hook *h;
 	unsigned u64s = 0;
-	int ret;
+	int ret = 0;
 
 	if (race_fault()) {
 		trace_and_count(c, trans_restart_fault_inject, trans, trace_ip);
@@ -668,21 +677,35 @@ bch2_trans_commit_write_locked(struct btree_trans *trans, unsigned flags,
 				i->k->k.version = MAX_VERSION;
 	}
 
-	if (trans->fs_usage_deltas &&
-	    bch2_trans_fs_usage_apply(trans, trans->fs_usage_deltas))
-		return -BCH_ERR_btree_insert_need_mark_replicas;
-
-	/* XXX: we only want to run this if deltas are nonzero */
-	bch2_trans_account_disk_usage_change(trans);
-
 	h = trans->hooks;
 	while (h) {
 		ret = h->fn(trans, h);
 		if (ret)
-			goto revert_fs_usage;
+			return ret;
 		h = h->next;
 	}
 
+	percpu_down_read(&c->mark_lock);
+	struct jset_entry *entry = trans->journal_entries;
+
+	for (entry = trans->journal_entries;
+	     entry != (void *) ((u64 *) trans->journal_entries + trans->journal_entries_u64s);
+	     entry = vstruct_next(entry))
+		if (jset_entry_is_key(entry) && entry->start->k.type == KEY_TYPE_accounting) {
+			struct bkey_i_accounting *a = bkey_i_to_accounting(entry->start);
+
+			a->k.version = journal_pos_to_bversion(&trans->journal_res,
+							(u64 *) entry - (u64 *) trans->journal_entries);
+			BUG_ON(bversion_zero(a->k.version));
+			ret = bch2_accounting_mem_add(trans, accounting_i_to_s_c(a));
+			if (ret)
+				goto revert_fs_usage;
+		}
+	percpu_up_read(&c->mark_lock);
+
+	/* XXX: we only want to run this if deltas are nonzero */
+	bch2_trans_account_disk_usage_change(trans);
+
 	trans_for_each_update(trans, i)
 		if (BTREE_NODE_TYPE_HAS_ATOMIC_TRIGGERS & (1U << i->bkey_type)) {
 			ret = run_one_mem_trigger(trans, i, BTREE_TRIGGER_ATOMIC|i->flags);
@@ -751,10 +774,20 @@ bch2_trans_commit_write_locked(struct btree_trans *trans, unsigned flags,
 
 	return 0;
 fatal_err:
-	bch2_fatal_error(c);
+	bch2_fs_fatal_error(c, "fatal error in transaction commit: %s", bch2_err_str(ret));
+	percpu_down_read(&c->mark_lock);
 revert_fs_usage:
-	if (trans->fs_usage_deltas)
-		bch2_trans_fs_usage_revert(trans, trans->fs_usage_deltas);
+	for (struct jset_entry *entry2 = trans->journal_entries;
+	     entry2 != entry;
+	     entry2 = vstruct_next(entry2))
+		if (jset_entry_is_key(entry2) && entry2->start->k.type == KEY_TYPE_accounting) {
+			struct bkey_s_accounting a = bkey_i_to_s_accounting(entry2->start);
+
+			bch2_accounting_neg(a);
+			bch2_accounting_mem_add(trans, a.c);
+			bch2_accounting_neg(a);
+		}
+	percpu_up_read(&c->mark_lock);
 	return ret;
 }
 
@@ -904,7 +937,7 @@ int bch2_trans_commit_error(struct btree_trans *trans, unsigned flags,
 		break;
 	case -BCH_ERR_btree_insert_need_mark_replicas:
 		ret = drop_locks_do(trans,
-			bch2_replicas_delta_list_mark(c, trans->fs_usage_deltas));
+			bch2_accounting_update_sb(trans));
 		break;
 	case -BCH_ERR_journal_res_get_blocked:
 		/*
@@ -996,8 +1029,6 @@ int __bch2_trans_commit(struct btree_trans *trans, unsigned flags)
 	    !trans->journal_entries_u64s)
 		goto out_reset;
 
-	memset(&trans->fs_usage_delta, 0, sizeof(trans->fs_usage_delta));
-
 	ret = bch2_trans_commit_run_triggers(trans);
 	if (ret)
 		goto out_reset;
@@ -1093,6 +1124,7 @@ int __bch2_trans_commit(struct btree_trans *trans, unsigned flags)
 	bch2_trans_verify_not_in_restart(trans);
 	if (likely(!(flags & BCH_TRANS_COMMIT_no_journal_res)))
 		memset(&trans->journal_res, 0, sizeof(trans->journal_res));
+	memset(&trans->fs_usage_delta, 0, sizeof(trans->fs_usage_delta));
 
 	ret = do_bch2_trans_commit(trans, flags, &errored_at, _RET_IP_);
 
diff --git a/fs/bcachefs/btree_types.h b/fs/bcachefs/btree_types.h
index b2ebf143c3b7..2acca37eb831 100644
--- a/fs/bcachefs/btree_types.h
+++ b/fs/bcachefs/btree_types.h
@@ -441,7 +441,6 @@ struct btree_trans {
 
 	unsigned		journal_u64s;
 	unsigned		extra_disk_res; /* XXX kill */
-	struct replicas_delta_list *fs_usage_deltas;
 
 	/* Entries before this are zeroed out on every bch2_trans_get() call */
 
diff --git a/fs/bcachefs/btree_update.h b/fs/bcachefs/btree_update.h
index 21f887fe857c..6f8812f21444 100644
--- a/fs/bcachefs/btree_update.h
+++ b/fs/bcachefs/btree_update.h
@@ -213,14 +213,6 @@ static inline void bch2_trans_reset_updates(struct btree_trans *trans)
 	trans->journal_entries_u64s	= 0;
 	trans->hooks			= NULL;
 	trans->extra_disk_res		= 0;
-
-	if (trans->fs_usage_deltas) {
-		trans->fs_usage_deltas->used = 0;
-		memset((void *) trans->fs_usage_deltas +
-		       offsetof(struct replicas_delta_list, memset_start), 0,
-		       (void *) &trans->fs_usage_deltas->memset_end -
-		       (void *) &trans->fs_usage_deltas->memset_start);
-	}
 }
 
 static inline struct bkey_i *__bch2_bkey_make_mut_noupdate(struct btree_trans *trans, struct bkey_s_c k,
diff --git a/fs/bcachefs/buckets.c b/fs/bcachefs/buckets.c
index c2f46b267b3a..fb915c1b7844 100644
--- a/fs/bcachefs/buckets.c
+++ b/fs/bcachefs/buckets.c
@@ -13,6 +13,7 @@
 #include "btree_update.h"
 #include "buckets.h"
 #include "buckets_waiting_for_journal.h"
+#include "disk_accounting.h"
 #include "ec.h"
 #include "error.h"
 #include "inode.h"
@@ -25,24 +26,16 @@
 
 #include <linux/preempt.h>
 
-static inline void fs_usage_data_type_to_base(struct bch_fs_usage_base *fs_usage,
-					      enum bch_data_type data_type,
-					      s64 sectors)
+static inline struct bch_fs_usage *fs_usage_ptr(struct bch_fs *c,
+						unsigned journal_seq,
+						bool gc)
 {
-	switch (data_type) {
-	case BCH_DATA_btree:
-		fs_usage->btree		+= sectors;
-		break;
-	case BCH_DATA_user:
-	case BCH_DATA_parity:
-		fs_usage->data		+= sectors;
-		break;
-	case BCH_DATA_cached:
-		fs_usage->cached	+= sectors;
-		break;
-	default:
-		break;
-	}
+	percpu_rwsem_assert_held(&c->mark_lock);
+	BUG_ON(!gc && !journal_seq);
+
+	return this_cpu_ptr(gc
+			    ? c->usage_gc
+			    : c->usage[journal_seq & JOURNAL_BUF_MASK]);
 }
 
 void bch2_fs_usage_initialize(struct bch_fs *c)
@@ -67,24 +60,13 @@ void bch2_fs_usage_initialize(struct bch_fs *c)
 		struct bch_dev_usage dev = bch2_dev_usage_read(ca);
 
 		usage->b.hidden += (dev.d[BCH_DATA_sb].buckets +
-				    dev.d[BCH_DATA_journal].buckets) *
+				  dev.d[BCH_DATA_journal].buckets) *
 			ca->mi.bucket_size;
 	}
 
 	percpu_up_write(&c->mark_lock);
 }
 
-static inline struct bch_dev_usage *dev_usage_ptr(struct bch_dev *ca,
-						  unsigned journal_seq,
-						  bool gc)
-{
-	BUG_ON(!gc && !journal_seq);
-
-	return this_cpu_ptr(gc
-			    ? ca->usage_gc
-			    : ca->usage[journal_seq & JOURNAL_BUF_MASK]);
-}
-
 void bch2_dev_usage_read_fast(struct bch_dev *ca, struct bch_dev_usage *usage)
 {
 	struct bch_fs *c = ca->fs;
@@ -267,11 +249,6 @@ bch2_fs_usage_read_short(struct bch_fs *c)
 	return ret;
 }
 
-void bch2_dev_usage_init(struct bch_dev *ca)
-{
-	ca->usage_base->d[BCH_DATA_free].buckets = ca->mi.nbuckets - ca->mi.first_bucket;
-}
-
 void bch2_dev_usage_to_text(struct printbuf *out, struct bch_dev_usage *usage)
 {
 	prt_tab(out);
@@ -298,21 +275,20 @@ void bch2_dev_usage_to_text(struct printbuf *out, struct bch_dev_usage *usage)
 
 void bch2_dev_usage_update(struct bch_fs *c, struct bch_dev *ca,
 			   const struct bch_alloc_v4 *old,
-			   const struct bch_alloc_v4 *new,
-			   u64 journal_seq, bool gc)
+			   const struct bch_alloc_v4 *new)
 {
 	struct bch_fs_usage *fs_usage;
 	struct bch_dev_usage *u;
 
 	preempt_disable();
-	fs_usage = fs_usage_ptr(c, journal_seq, gc);
+	fs_usage = this_cpu_ptr(c->usage_gc);
 
 	if (data_type_is_hidden(old->data_type))
 		fs_usage->b.hidden -= ca->mi.bucket_size;
 	if (data_type_is_hidden(new->data_type))
 		fs_usage->b.hidden += ca->mi.bucket_size;
 
-	u = dev_usage_ptr(ca, journal_seq, gc);
+	u = this_cpu_ptr(ca->usage_gc);
 
 	u->d[old->data_type].buckets--;
 	u->d[new->data_type].buckets++;
@@ -346,27 +322,11 @@ void bch2_dev_usage_update_m(struct bch_fs *c, struct bch_dev *ca,
 	struct bch_alloc_v4 old_a = bucket_m_to_alloc(*old);
 	struct bch_alloc_v4 new_a = bucket_m_to_alloc(*new);
 
-	bch2_dev_usage_update(c, ca, &old_a, &new_a, 0, true);
-}
-
-static inline int __update_replicas(struct bch_fs *c,
-				    struct bch_fs_usage *fs_usage,
-				    struct bch_replicas_entry_v1 *r,
-				    s64 sectors)
-{
-	int idx = bch2_replicas_entry_idx(c, r);
-
-	if (idx < 0)
-		return -1;
-
-	fs_usage_data_type_to_base(&fs_usage->b, r->data_type, sectors);
-	fs_usage->replicas[idx]		+= sectors;
-	return 0;
+	bch2_dev_usage_update(c, ca, &old_a, &new_a);
 }
 
 int bch2_update_replicas(struct bch_fs *c, struct bkey_s_c k,
-			 struct bch_replicas_entry_v1 *r, s64 sectors,
-			 unsigned journal_seq, bool gc)
+			 struct bch_replicas_entry_v1 *r, s64 sectors)
 {
 	struct bch_fs_usage *fs_usage;
 	int idx, ret = 0;
@@ -393,7 +353,7 @@ int bch2_update_replicas(struct bch_fs *c, struct bkey_s_c k,
 	}
 
 	preempt_disable();
-	fs_usage = fs_usage_ptr(c, journal_seq, gc);
+	fs_usage = this_cpu_ptr(c->usage_gc);
 	fs_usage_data_type_to_base(&fs_usage->b, r->data_type, sectors);
 	fs_usage->replicas[idx]		+= sectors;
 	preempt_enable();
@@ -406,94 +366,13 @@ int bch2_update_replicas(struct bch_fs *c, struct bkey_s_c k,
 
 static inline int update_cached_sectors(struct bch_fs *c,
 			struct bkey_s_c k,
-			unsigned dev, s64 sectors,
-			unsigned journal_seq, bool gc)
+			unsigned dev, s64 sectors)
 {
 	struct bch_replicas_padded r;
 
 	bch2_replicas_entry_cached(&r.e, dev);
 
-	return bch2_update_replicas(c, k, &r.e, sectors, journal_seq, gc);
-}
-
-static int __replicas_deltas_realloc(struct btree_trans *trans, unsigned more,
-				     gfp_t gfp)
-{
-	struct replicas_delta_list *d = trans->fs_usage_deltas;
-	unsigned new_size = d ? (d->size + more) * 2 : 128;
-	unsigned alloc_size = sizeof(*d) + new_size;
-
-	WARN_ON_ONCE(alloc_size > REPLICAS_DELTA_LIST_MAX);
-
-	if (!d || d->used + more > d->size) {
-		d = krealloc(d, alloc_size, gfp|__GFP_ZERO);
-
-		if (unlikely(!d)) {
-			if (alloc_size > REPLICAS_DELTA_LIST_MAX)
-				return -ENOMEM;
-
-			d = mempool_alloc(&trans->c->replicas_delta_pool, gfp);
-			if (!d)
-				return -ENOMEM;
-
-			memset(d, 0, REPLICAS_DELTA_LIST_MAX);
-
-			if (trans->fs_usage_deltas)
-				memcpy(d, trans->fs_usage_deltas,
-				       trans->fs_usage_deltas->size + sizeof(*d));
-
-			new_size = REPLICAS_DELTA_LIST_MAX - sizeof(*d);
-			kfree(trans->fs_usage_deltas);
-		}
-
-		d->size = new_size;
-		trans->fs_usage_deltas = d;
-	}
-
-	return 0;
-}
-
-int bch2_replicas_deltas_realloc(struct btree_trans *trans, unsigned more)
-{
-	return allocate_dropping_locks_errcode(trans,
-				__replicas_deltas_realloc(trans, more, _gfp));
-}
-
-int bch2_update_replicas_list(struct btree_trans *trans,
-			 struct bch_replicas_entry_v1 *r,
-			 s64 sectors)
-{
-	struct replicas_delta_list *d;
-	struct replicas_delta *n;
-	unsigned b;
-	int ret;
-
-	if (!sectors)
-		return 0;
-
-	b = replicas_entry_bytes(r) + 8;
-	ret = bch2_replicas_deltas_realloc(trans, b);
-	if (ret)
-		return ret;
-
-	d = trans->fs_usage_deltas;
-	n = (void *) d->d + d->used;
-	n->delta = sectors;
-	unsafe_memcpy((void *) n + offsetof(struct replicas_delta, r),
-		      r, replicas_entry_bytes(r),
-		      "flexible array member embedded in strcuct with padding");
-	bch2_replicas_entry_sort(&n->r);
-	d->used += b;
-	return 0;
-}
-
-int bch2_update_cached_sectors_list(struct btree_trans *trans, unsigned dev, s64 sectors)
-{
-	struct bch_replicas_padded r;
-
-	bch2_replicas_entry_cached(&r.e, dev);
-
-	return bch2_update_replicas_list(trans, &r.e, sectors);
+	return bch2_update_replicas(c, k, &r.e, sectors);
 }
 
 int bch2_mark_metadata_bucket(struct bch_fs *c, struct bch_dev *ca,
@@ -653,47 +532,6 @@ int bch2_check_bucket_ref(struct btree_trans *trans,
 	goto out;
 }
 
-void bch2_trans_fs_usage_revert(struct btree_trans *trans,
-				struct replicas_delta_list *deltas)
-{
-	struct bch_fs *c = trans->c;
-	struct bch_fs_usage *dst;
-	struct replicas_delta *d, *top = (void *) deltas->d + deltas->used;
-	s64 added = 0;
-	unsigned i;
-
-	percpu_down_read(&c->mark_lock);
-	preempt_disable();
-	dst = fs_usage_ptr(c, trans->journal_res.seq, false);
-
-	/* revert changes: */
-	for (d = deltas->d; d != top; d = replicas_delta_next(d)) {
-		switch (d->r.data_type) {
-		case BCH_DATA_btree:
-		case BCH_DATA_user:
-		case BCH_DATA_parity:
-			added += d->delta;
-		}
-		BUG_ON(__update_replicas(c, dst, &d->r, -d->delta));
-	}
-
-	dst->b.nr_inodes -= deltas->nr_inodes;
-
-	for (i = 0; i < BCH_REPLICAS_MAX; i++) {
-		added				-= deltas->persistent_reserved[i];
-		dst->b.reserved			-= deltas->persistent_reserved[i];
-		dst->persistent_reserved[i]	-= deltas->persistent_reserved[i];
-	}
-
-	if (added > 0) {
-		trans->disk_res->sectors += added;
-		this_cpu_add(*c->online_reserved, added);
-	}
-
-	preempt_enable();
-	percpu_up_read(&c->mark_lock);
-}
-
 void bch2_trans_account_disk_usage_change(struct btree_trans *trans)
 {
 	struct bch_fs *c = trans->c;
@@ -747,43 +585,6 @@ void bch2_trans_account_disk_usage_change(struct btree_trans *trans)
 					should_not_have_added, disk_res_sectors);
 }
 
-int bch2_trans_fs_usage_apply(struct btree_trans *trans,
-			      struct replicas_delta_list *deltas)
-{
-	struct bch_fs *c = trans->c;
-	struct replicas_delta *d, *d2;
-	struct replicas_delta *top = (void *) deltas->d + deltas->used;
-	struct bch_fs_usage *dst;
-	unsigned i;
-
-	percpu_down_read(&c->mark_lock);
-	preempt_disable();
-	dst = fs_usage_ptr(c, trans->journal_res.seq, false);
-
-	for (d = deltas->d; d != top; d = replicas_delta_next(d))
-		if (__update_replicas(c, dst, &d->r, d->delta))
-			goto need_mark;
-
-	dst->b.nr_inodes += deltas->nr_inodes;
-
-	for (i = 0; i < BCH_REPLICAS_MAX; i++) {
-		dst->b.reserved			+= deltas->persistent_reserved[i];
-		dst->persistent_reserved[i]	+= deltas->persistent_reserved[i];
-	}
-
-	preempt_enable();
-	percpu_up_read(&c->mark_lock);
-	return 0;
-need_mark:
-	/* revert changes: */
-	for (d2 = deltas->d; d2 != d; d2 = replicas_delta_next(d2))
-		BUG_ON(__update_replicas(c, dst, &d2->r, -d2->delta));
-
-	preempt_enable();
-	percpu_up_read(&c->mark_lock);
-	return -1;
-}
-
 /* KEY_TYPE_extent: */
 
 static int __mark_pointer(struct btree_trans *trans,
@@ -911,10 +712,12 @@ static int bch2_trigger_stripe_ptr(struct btree_trans *trans,
 			stripe_blockcount_get(&s->v, p.ec.block) +
 			sectors);
 
-		struct bch_replicas_padded r;
-		bch2_bkey_to_replicas(&r.e, bkey_i_to_s_c(&s->k_i));
-		r.e.data_type = data_type;
-		ret = bch2_update_replicas_list(trans, &r.e, sectors);
+		struct disk_accounting_key acc = {
+			.type = BCH_DISK_ACCOUNTING_replicas,
+		};
+		bch2_bkey_to_replicas(&acc.replicas, bkey_i_to_s_c(&s->k_i));
+		acc.replicas.data_type = data_type;
+		ret = bch2_disk_accounting_mod(trans, &acc, &sectors, 1);
 err:
 		bch2_trans_iter_exit(trans, &iter);
 		return ret;
@@ -951,7 +754,7 @@ static int bch2_trigger_stripe_ptr(struct btree_trans *trans,
 		mutex_unlock(&c->ec_stripes_heap_lock);
 
 		r.e.data_type = data_type;
-		bch2_update_replicas(c, k, &r.e, sectors, trans->journal_res.seq, true);
+		bch2_update_replicas(c, k, &r.e, sectors);
 	}
 
 	return 0;
@@ -966,16 +769,18 @@ static int __trigger_extent(struct btree_trans *trans,
 	struct bkey_ptrs_c ptrs = bch2_bkey_ptrs_c(k);
 	const union bch_extent_entry *entry;
 	struct extent_ptr_decoded p;
-	struct bch_replicas_padded r;
 	enum bch_data_type data_type = bkey_is_btree_ptr(k.k)
 		? BCH_DATA_btree
 		: BCH_DATA_user;
 	s64 dirty_sectors = 0;
 	int ret = 0;
 
-	r.e.data_type	= data_type;
-	r.e.nr_devs	= 0;
-	r.e.nr_required	= 1;
+	struct disk_accounting_key acc = {
+		.type			= BCH_DISK_ACCOUNTING_replicas,
+		.replicas.data_type	= data_type,
+		.replicas.nr_devs	= 0,
+		.replicas.nr_required	= 1,
+	};
 
 	bkey_for_each_ptr_decode(k.k, ptrs, p, entry) {
 		s64 disk_sectors;
@@ -988,8 +793,8 @@ static int __trigger_extent(struct btree_trans *trans,
 		if (p.ptr.cached) {
 			if (!stale) {
 				ret = !gc
-					? bch2_update_cached_sectors_list(trans, p.ptr.dev, disk_sectors)
-					: update_cached_sectors(c, k, p.ptr.dev, disk_sectors, 0, true);
+					? bch2_mod_dev_cached_sectors(trans, p.ptr.dev, disk_sectors)
+					: update_cached_sectors(c, k, p.ptr.dev, disk_sectors);
 				bch2_fs_fatal_err_on(ret && gc, c, "%s(): no replicas entry while updating cached sectors",
 						     __func__);
 				if (ret)
@@ -997,7 +802,7 @@ static int __trigger_extent(struct btree_trans *trans,
 			}
 		} else if (!p.has_ec) {
 			dirty_sectors	       += disk_sectors;
-			r.e.devs[r.e.nr_devs++]	= p.ptr.dev;
+			acc.replicas.devs[acc.replicas.nr_devs++] = p.ptr.dev;
 		} else {
 			ret = bch2_trigger_stripe_ptr(trans, k, p, data_type, disk_sectors, flags);
 			if (ret)
@@ -1008,14 +813,14 @@ static int __trigger_extent(struct btree_trans *trans,
 			 * if so they're not required for mounting if we have an
 			 * erasure coded pointer in this extent:
 			 */
-			r.e.nr_required = 0;
+			acc.replicas.nr_required = 0;
 		}
 	}
 
-	if (r.e.nr_devs) {
+	if (acc.replicas.nr_devs) {
 		ret = !gc
-			? bch2_update_replicas_list(trans, &r.e, dirty_sectors)
-			: bch2_update_replicas(c, k, &r.e, dirty_sectors, 0, true);
+			? bch2_disk_accounting_mod(trans, &acc, &dirty_sectors, 1)
+			: bch2_update_replicas(c, k, &acc.replicas, dirty_sectors);
 		if (unlikely(ret && gc)) {
 			struct printbuf buf = PRINTBUF;
 
@@ -1074,23 +879,23 @@ static int __trigger_reservation(struct btree_trans *trans,
 {
 	struct bch_fs *c = trans->c;
 	unsigned replicas = bkey_s_c_to_reservation(k).v->nr_replicas;
-	s64 sectors = (s64) k.k->size * replicas;
+	s64 sectors = (s64) k.k->size;
 
 	if (flags & BTREE_TRIGGER_OVERWRITE)
 		sectors = -sectors;
 
 	if (flags & BTREE_TRIGGER_TRANSACTIONAL) {
-		int ret = bch2_replicas_deltas_realloc(trans, 0);
-		if (ret)
-			return ret;
-
-		struct replicas_delta_list *d = trans->fs_usage_deltas;
-		replicas = min(replicas, ARRAY_SIZE(d->persistent_reserved));
+		struct disk_accounting_key acc = {
+			.type = BCH_DISK_ACCOUNTING_persistent_reserved,
+			.persistent_reserved.nr_replicas = replicas,
+		};
 
-		d->persistent_reserved[replicas - 1] += sectors;
+		return bch2_disk_accounting_mod(trans, &acc, &sectors, 1);
 	}
 
 	if (flags & BTREE_TRIGGER_GC) {
+		sectors *= replicas;
+
 		percpu_down_read(&c->mark_lock);
 		preempt_disable();
 
diff --git a/fs/bcachefs/buckets.h b/fs/bcachefs/buckets.h
index 6387e039f789..f9a1d24c997b 100644
--- a/fs/bcachefs/buckets.h
+++ b/fs/bcachefs/buckets.h
@@ -202,7 +202,6 @@ static inline struct bch_dev_usage bch2_dev_usage_read(struct bch_dev *ca)
 	return ret;
 }
 
-void bch2_dev_usage_init(struct bch_dev *);
 void bch2_dev_usage_to_text(struct printbuf *, struct bch_dev_usage *);
 
 static inline u64 bch2_dev_buckets_reserved(struct bch_dev *ca, enum bch_watermark watermark)
@@ -261,6 +260,13 @@ static inline u64 dev_buckets_available(struct bch_dev *ca,
 	return __dev_buckets_available(ca, bch2_dev_usage_read(ca), watermark);
 }
 
+static inline s64 bucket_sectors_fragmented(struct bch_dev *ca, struct bch_alloc_v4 a)
+{
+	return a.dirty_sectors
+		? max(0, (int) ca->mi.bucket_size - (int) a.dirty_sectors)
+		: 0;
+}
+
 /* Filesystem usage: */
 
 static inline unsigned __fs_usage_u64s(unsigned nr_replicas)
@@ -304,31 +310,11 @@ bch2_fs_usage_read_short(struct bch_fs *);
 
 void bch2_dev_usage_update(struct bch_fs *, struct bch_dev *,
 			   const struct bch_alloc_v4 *,
-			   const struct bch_alloc_v4 *, u64, bool);
+			   const struct bch_alloc_v4 *);
 void bch2_dev_usage_update_m(struct bch_fs *, struct bch_dev *,
 			     struct bucket *, struct bucket *);
-
-/* key/bucket marking: */
-
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
 int bch2_update_replicas(struct bch_fs *, struct bkey_s_c,
-			 struct bch_replicas_entry_v1 *, s64,
-			 unsigned, bool);
-int bch2_update_replicas_list(struct btree_trans *,
 			 struct bch_replicas_entry_v1 *, s64);
-int bch2_update_cached_sectors_list(struct btree_trans *, unsigned, s64);
-int bch2_replicas_deltas_realloc(struct btree_trans *, unsigned);
 
 void bch2_fs_usage_initialize(struct bch_fs *);
 
@@ -358,9 +344,6 @@ int bch2_trigger_reservation(struct btree_trans *, enum btree_id, unsigned,
 
 void bch2_trans_account_disk_usage_change(struct btree_trans *);
 
-void bch2_trans_fs_usage_revert(struct btree_trans *, struct replicas_delta_list *);
-int bch2_trans_fs_usage_apply(struct btree_trans *, struct replicas_delta_list *);
-
 int bch2_trans_mark_metadata_bucket(struct btree_trans *, struct bch_dev *,
 				    size_t, enum bch_data_type, unsigned);
 int bch2_trans_mark_dev_sb(struct bch_fs *, struct bch_dev *);
diff --git a/fs/bcachefs/disk_accounting.c b/fs/bcachefs/disk_accounting.c
index 209f59e87b34..327c586ac661 100644
--- a/fs/bcachefs/disk_accounting.c
+++ b/fs/bcachefs/disk_accounting.c
@@ -1,9 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include "bcachefs.h"
+#include "bcachefs_ioctl.h"
 #include "btree_update.h"
+#include "btree_write_buffer.h"
 #include "buckets.h"
 #include "disk_accounting.h"
+#include "error.h"
+#include "journal_io.h"
 #include "replicas.h"
 
 static const char * const disk_accounting_type_strs[] = {
@@ -13,6 +17,44 @@ static const char * const disk_accounting_type_strs[] = {
 	NULL
 };
 
+int bch2_disk_accounting_mod(struct btree_trans *trans,
+			     struct disk_accounting_key *k,
+			     s64 *d, unsigned nr)
+{
+	/* Normalize: */
+	switch (k->type) {
+	case BCH_DISK_ACCOUNTING_replicas:
+		bubble_sort(k->replicas.devs, k->replicas.nr_devs, u8_cmp);
+		break;
+	}
+
+	BUG_ON(nr > BCH_ACCOUNTING_MAX_COUNTERS);
+
+	struct {
+		__BKEY_PADDED(k, BCH_ACCOUNTING_MAX_COUNTERS);
+	} k_i;
+	struct bkey_i_accounting *acc = bkey_accounting_init(&k_i.k);
+
+	acc->k.p = disk_accounting_key_to_bpos(k);
+	set_bkey_val_u64s(&acc->k, sizeof(struct bch_accounting) / sizeof(u64) + nr);
+
+	memcpy_u64s_small(acc->v.d, d, nr);
+
+	return bch2_trans_update_buffered(trans, BTREE_ID_accounting, &acc->k_i);
+}
+
+int bch2_mod_dev_cached_sectors(struct btree_trans *trans,
+				unsigned dev, s64 sectors)
+{
+	struct disk_accounting_key acc = {
+		.type = BCH_DISK_ACCOUNTING_replicas,
+	};
+
+	bch2_replicas_entry_cached(&acc.replicas, dev);
+
+	return bch2_disk_accounting_mod(trans, &acc, &sectors, 1);
+}
+
 int bch2_accounting_invalid(struct bch_fs *c, struct bkey_s_c k,
 			    enum bkey_invalid_flags flags,
 			    struct printbuf *err)
@@ -68,3 +110,269 @@ void bch2_accounting_swab(struct bkey_s k)
 	     p++)
 		*p = swab64(*p);
 }
+
+static inline bool accounting_to_replicas(struct bch_replicas_entry_v1 *r, struct bpos p)
+{
+	struct disk_accounting_key acc_k;
+	bpos_to_disk_accounting_key(&acc_k, p);
+
+	switch (acc_k.type) {
+	case BCH_DISK_ACCOUNTING_replicas:
+		memcpy(r, &acc_k.replicas, replicas_entry_bytes(&acc_k.replicas));
+		return true;
+	default:
+		return false;
+	}
+}
+
+static int bch2_accounting_update_sb_one(struct bch_fs *c, struct bpos p)
+{
+	struct bch_replicas_padded r;
+	return accounting_to_replicas(&r.e, p)
+		? bch2_mark_replicas(c, &r.e)
+		: 0;
+}
+
+int bch2_accounting_update_sb(struct btree_trans *trans)
+{
+	for (struct jset_entry *i = trans->journal_entries;
+	     i != (void *) ((u64 *) trans->journal_entries + trans->journal_entries_u64s);
+	     i = vstruct_next(i))
+		if (jset_entry_is_key(i) && i->start->k.type == KEY_TYPE_accounting) {
+			int ret = bch2_accounting_update_sb_one(trans->c, i->start->k.p);
+			if (ret)
+				return ret;
+		}
+
+	return 0;
+}
+
+static int __bch2_accounting_mem_add_slowpath(struct bch_fs *c, struct bkey_s_c_accounting a)
+{
+	struct bch_replicas_padded r;
+
+	if (accounting_to_replicas(&r.e, a.k->p) &&
+	    !bch2_replicas_marked_locked(c, &r.e))
+		return -BCH_ERR_btree_insert_need_mark_replicas;
+
+	struct bch_accounting_mem *acc = &c->accounting;
+	unsigned new_nr_counters = acc->nr_counters + bch2_accounting_counters(a.k);
+
+	u64 __percpu *new_counters = __alloc_percpu_gfp(new_nr_counters * sizeof(u64),
+							sizeof(u64), GFP_KERNEL);
+	if (!new_counters)
+		return -BCH_ERR_ENOMEM_disk_accounting;
+
+	preempt_disable();
+	memcpy(this_cpu_ptr(new_counters),
+	       bch2_acc_percpu_u64s(acc->v, acc->nr_counters),
+	       acc->nr_counters * sizeof(u64));
+	preempt_enable();
+
+	struct accounting_pos_offset n = {
+		.pos		= a.k->p,
+		.version	= a.k->version,
+		.offset		= acc->nr_counters,
+		.nr_counters	= bch2_accounting_counters(a.k),
+	};
+	if (darray_push(&acc->k, n)) {
+		free_percpu(new_counters);
+		return -BCH_ERR_ENOMEM_disk_accounting;
+	}
+
+	eytzinger0_sort(acc->k.data, acc->k.nr, sizeof(acc->k.data[0]), accounting_pos_cmp, NULL);
+
+	free_percpu(acc->v);
+	acc->v = new_counters;
+	acc->nr_counters = new_nr_counters;
+
+	for (unsigned i = 0; i < n.nr_counters; i++)
+		this_cpu_add(acc->v[n.offset + i], a.v->d[i]);
+	return 0;
+}
+
+int bch2_accounting_mem_add_slowpath(struct bch_fs *c, struct bkey_s_c_accounting a)
+{
+	percpu_up_read(&c->mark_lock);
+	percpu_down_write(&c->mark_lock);
+	int ret = __bch2_accounting_mem_add_slowpath(c, a);
+	percpu_up_write(&c->mark_lock);
+	percpu_down_read(&c->mark_lock);
+	return ret;
+}
+
+int bch2_fs_replicas_usage_read(struct bch_fs *c, darray_char *usage)
+{
+	struct bch_accounting_mem *acc = &c->accounting;
+	int ret = 0;
+
+	darray_init(usage);
+
+	percpu_down_read(&c->mark_lock);
+	darray_for_each(acc->k, i) {
+		struct {
+			struct bch_replicas_usage r;
+			u8 pad[BCH_BKEY_PTRS_MAX];
+		} u;
+
+		if (!accounting_to_replicas(&u.r.r, i->pos))
+			continue;
+
+		bch2_accounting_mem_read(c, i->pos, &u.r.sectors, 1);
+
+		ret = darray_make_room(usage, replicas_usage_bytes(&u.r));
+		if (ret)
+			break;
+
+		memcpy(&darray_top(*usage), &u.r, replicas_usage_bytes(&u.r));
+		usage->nr += replicas_usage_bytes(&u.r);
+	}
+	percpu_up_read(&c->mark_lock);
+
+	if (ret)
+		darray_exit(usage);
+	return ret;
+}
+
+static bool accounting_key_is_zero(struct bkey_s_c_accounting a)
+{
+
+	for (unsigned i = 0; i < bch2_accounting_counters(a.k); i++)
+		if (a.v->d[i])
+			return false;
+	return true;
+}
+
+static int accounting_read_key(struct bch_fs *c, struct bkey_s_c k)
+{
+	struct printbuf buf = PRINTBUF;
+
+	if (k.k->type != KEY_TYPE_accounting)
+		return 0;
+
+	percpu_down_read(&c->mark_lock);
+	int ret = __bch2_accounting_mem_add(c, bkey_s_c_to_accounting(k));
+	percpu_up_read(&c->mark_lock);
+
+	if (accounting_key_is_zero(bkey_s_c_to_accounting(k)) &&
+	    ret == -BCH_ERR_btree_insert_need_mark_replicas)
+		ret = 0;
+
+	struct disk_accounting_key acc;
+	bpos_to_disk_accounting_key(&acc, k.k->p);
+
+	if (fsck_err_on(ret == -BCH_ERR_btree_insert_need_mark_replicas,
+			c, accounting_replicas_not_marked,
+			"accounting not marked in superblock replicas\n  %s",
+			(bch2_accounting_key_to_text(&buf, &acc),
+			 buf.buf)))
+		ret = bch2_accounting_update_sb_one(c, k.k->p);
+fsck_err:
+	printbuf_exit(&buf);
+	return ret;
+}
+
+int bch2_accounting_read(struct bch_fs *c)
+{
+	struct bch_accounting_mem *acc = &c->accounting;
+
+	int ret = bch2_trans_run(c,
+		for_each_btree_key(trans, iter,
+				BTREE_ID_accounting, POS_MIN,
+				BTREE_ITER_PREFETCH|BTREE_ITER_ALL_SNAPSHOTS, k, ({
+			struct bkey u;
+			struct bkey_s_c k = bch2_btree_path_peek_slot_exact(btree_iter_path(trans, &iter), &u);
+			accounting_read_key(c, k);
+		})));
+	if (ret)
+		goto err;
+
+	struct genradix_iter iter;
+	struct journal_replay *i, **_i;
+
+	genradix_for_each(&c->journal_entries, iter, _i) {
+		i = *_i;
+
+		if (!i || i->ignore)
+			continue;
+
+		for_each_jset_key(k, entry, &i->j)
+			if (k->k.type == KEY_TYPE_accounting) {
+				struct bkey_s_c_accounting a = bkey_i_to_s_c_accounting(k);
+				unsigned idx = eytzinger0_find(acc->k.data, acc->k.nr,
+							sizeof(acc->k.data[0]),
+							accounting_pos_cmp, &a.k->p);
+				if (idx < acc->k.nr &&
+				    bversion_cmp(acc->k.data[idx].version, a.k->version) >= 0)
+					continue;
+
+				ret = accounting_read_key(c, bkey_i_to_s_c(k));
+				if (ret)
+					goto err;
+			}
+	}
+
+	percpu_down_read(&c->mark_lock);
+	preempt_disable();
+	struct bch_fs_usage_base *usage = &c->usage_base->b;
+
+	for (unsigned i = 0; i < acc->k.nr; i++) {
+		struct disk_accounting_key k;
+		bpos_to_disk_accounting_key(&k, acc->k.data[i].pos);
+
+		u64 v[BCH_ACCOUNTING_MAX_COUNTERS];
+		bch2_accounting_mem_read_counters(c, i, v, ARRAY_SIZE(v));
+
+		switch (k.type) {
+		case BCH_DISK_ACCOUNTING_persistent_reserved:
+			usage->reserved += v[0] * k.persistent_reserved.nr_replicas;
+			break;
+		case BCH_DISK_ACCOUNTING_replicas:
+			fs_usage_data_type_to_base(usage, k.replicas.data_type, v[0]);
+			break;
+		}
+	}
+	preempt_enable();
+	percpu_up_read(&c->mark_lock);
+err:
+	bch_err_fn(c, ret);
+	return ret;
+}
+
+int bch2_dev_usage_remove(struct bch_fs *c, unsigned dev)
+{
+	return bch2_trans_run(c,
+		bch2_btree_write_buffer_flush_sync(trans) ?:
+		for_each_btree_key_commit(trans, iter, BTREE_ID_accounting, POS_MIN,
+				BTREE_ITER_ALL_SNAPSHOTS, k, NULL, NULL, 0, ({
+			struct disk_accounting_key acc;
+			bpos_to_disk_accounting_key(&acc, k.k->p);
+
+			acc.type == BCH_DISK_ACCOUNTING_dev_data_type &&
+			acc.dev_data_type.dev == dev
+				? bch2_btree_bit_mod_buffered(trans, BTREE_ID_accounting, k.k->p, 0)
+				: 0;
+		})) ?:
+		bch2_btree_write_buffer_flush_sync(trans));
+}
+
+int bch2_dev_usage_init(struct bch_dev *ca)
+{
+	struct disk_accounting_key acc = {
+		.type = BCH_DISK_ACCOUNTING_dev_data_type,
+		.dev_data_type.dev = ca->dev_idx,
+		.dev_data_type.data_type = BCH_DATA_free,
+	};
+	u64 v[3] = { ca->mi.nbuckets - ca->mi.first_bucket, 0, 0 };
+
+	return bch2_trans_do(ca->fs, NULL, NULL, 0,
+			     bch2_disk_accounting_mod(trans, &acc, v, ARRAY_SIZE(v)));
+}
+
+void bch2_fs_accounting_exit(struct bch_fs *c)
+{
+	struct bch_accounting_mem *acc = &c->accounting;
+
+	darray_exit(&acc->k);
+	free_percpu(acc->v);
+}
diff --git a/fs/bcachefs/disk_accounting.h b/fs/bcachefs/disk_accounting.h
index e15299665859..5fd053a819df 100644
--- a/fs/bcachefs/disk_accounting.h
+++ b/fs/bcachefs/disk_accounting.h
@@ -2,11 +2,32 @@
 #ifndef _BCACHEFS_DISK_ACCOUNTING_H
 #define _BCACHEFS_DISK_ACCOUNTING_H
 
+#include <linux/eytzinger.h>
+
+static inline void bch2_u64s_neg(u64 *v, unsigned nr)
+{
+	for (unsigned i = 0; i < nr; i++)
+		v[i] = -v[i];
+}
+
 static inline unsigned bch2_accounting_counters(const struct bkey *k)
 {
 	return bkey_val_u64s(k) - offsetof(struct bch_accounting, d) / sizeof(u64);
 }
 
+static inline void bch2_accounting_neg(struct bkey_s_accounting a)
+{
+	bch2_u64s_neg(a.v->d, bch2_accounting_counters(a.k));
+}
+
+static inline bool bch2_accounting_key_is_zero(struct bkey_s_c_accounting a)
+{
+	for (unsigned i = 0;  i < bch2_accounting_counters(a.k); i++)
+		if (a.v->d[i])
+			return false;
+	return true;
+}
+
 static inline void bch2_accounting_accumulate(struct bkey_i_accounting *dst,
 					      struct bkey_s_c_accounting src)
 {
@@ -18,6 +39,26 @@ static inline void bch2_accounting_accumulate(struct bkey_i_accounting *dst,
 		dst->k.version = src.k->version;
 }
 
+static inline void fs_usage_data_type_to_base(struct bch_fs_usage_base *fs_usage,
+					      enum bch_data_type data_type,
+					      s64 sectors)
+{
+	switch (data_type) {
+	case BCH_DATA_btree:
+		fs_usage->btree		+= sectors;
+		break;
+	case BCH_DATA_user:
+	case BCH_DATA_parity:
+		fs_usage->data		+= sectors;
+		break;
+	case BCH_DATA_cached:
+		fs_usage->cached	+= sectors;
+		break;
+	default:
+		break;
+	}
+}
+
 static inline void bpos_to_disk_accounting_key(struct disk_accounting_key *acc, struct bpos p)
 {
 	acc->_pad = p;
@@ -36,6 +77,12 @@ static inline struct bpos disk_accounting_key_to_bpos(struct disk_accounting_key
 	return ret;
 }
 
+int bch2_disk_accounting_mod(struct btree_trans *,
+			     struct disk_accounting_key *,
+			     s64 *, unsigned);
+int bch2_mod_dev_cached_sectors(struct btree_trans *trans,
+				unsigned dev, s64 sectors);
+
 int bch2_accounting_invalid(struct bch_fs *, struct bkey_s_c,
 			    enum bkey_invalid_flags, struct printbuf *);
 void bch2_accounting_key_to_text(struct printbuf *, struct disk_accounting_key *);
@@ -49,4 +96,83 @@ void bch2_accounting_swab(struct bkey_s);
 	.min_val_size	= 8,				\
 })
 
+int bch2_accounting_update_sb(struct btree_trans *);
+
+static inline int accounting_pos_cmp(const void *_l, const void *_r)
+{
+	const struct bpos *l = _l, *r = _r;
+
+	return bpos_cmp(*l, *r);
+}
+
+int bch2_accounting_mem_add_slowpath(struct bch_fs *, struct bkey_s_c_accounting);
+
+static inline int __bch2_accounting_mem_add(struct bch_fs *c, struct bkey_s_c_accounting a)
+{
+	struct bch_accounting_mem *acc = &c->accounting;
+	unsigned idx = eytzinger0_find(acc->k.data, acc->k.nr, sizeof(acc->k.data[0]),
+				       accounting_pos_cmp, &a.k->p);
+	if (unlikely(idx >= acc->k.nr))
+		return bch2_accounting_mem_add_slowpath(c, a);
+
+	unsigned offset = acc->k.data[idx].offset;
+
+	EBUG_ON(bch2_accounting_counters(a.k) != acc->k.data[idx].nr_counters);
+
+	for (unsigned i = 0; i < bch2_accounting_counters(a.k); i++)
+		this_cpu_add(acc->v[offset + i], a.v->d[i]);
+	return 0;
+}
+
+static inline int bch2_accounting_mem_add(struct btree_trans *trans, struct bkey_s_c_accounting a)
+{
+	struct disk_accounting_key acc_k;
+	bpos_to_disk_accounting_key(&acc_k, a.k->p);
+
+	switch (acc_k.type) {
+	case BCH_DISK_ACCOUNTING_persistent_reserved:
+		trans->fs_usage_delta.reserved += acc_k.persistent_reserved.nr_replicas * a.v->d[0];
+		break;
+	case BCH_DISK_ACCOUNTING_replicas:
+		fs_usage_data_type_to_base(&trans->fs_usage_delta, acc_k.replicas.data_type, a.v->d[0]);
+		break;
+	}
+	return __bch2_accounting_mem_add(trans->c, a);
+}
+
+static inline void bch2_accounting_mem_read_counters(struct bch_fs *c,
+						     unsigned idx,
+						     u64 *v, unsigned nr)
+{
+	memset(v, 0, sizeof(*v) * nr);
+
+	struct bch_accounting_mem *acc = &c->accounting;
+	if (unlikely(idx >= acc->k.nr))
+		return;
+
+	unsigned offset = acc->k.data[idx].offset;
+	nr = min_t(unsigned, nr, acc->k.data[idx].nr_counters);
+
+	for (unsigned i = 0; i < nr; i++)
+		v[i] = percpu_u64_get(acc->v + offset + i);
+}
+
+static inline void bch2_accounting_mem_read(struct bch_fs *c, struct bpos p,
+					    u64 *v, unsigned nr)
+{
+	struct bch_accounting_mem *acc = &c->accounting;
+	unsigned idx = eytzinger0_find(acc->k.data, acc->k.nr, sizeof(acc->k.data[0]),
+				       accounting_pos_cmp, &p);
+
+	bch2_accounting_mem_read_counters(c, idx, v, nr);
+}
+
+int bch2_fs_replicas_usage_read(struct bch_fs *, darray_char *);
+
+int bch2_accounting_read(struct bch_fs *);
+
+int bch2_dev_usage_remove(struct bch_fs *, unsigned);
+int bch2_dev_usage_init(struct bch_dev *);
+void bch2_fs_accounting_exit(struct bch_fs *);
+
 #endif /* _BCACHEFS_DISK_ACCOUNTING_H */
diff --git a/fs/bcachefs/disk_accounting_types.h b/fs/bcachefs/disk_accounting_types.h
new file mode 100644
index 000000000000..8da5ac182b33
--- /dev/null
+++ b/fs/bcachefs/disk_accounting_types.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _BCACHEFS_DISK_ACCOUNTING_TYPES_H
+#define _BCACHEFS_DISK_ACCOUNTING_TYPES_H
+
+#include <linux/darray.h>
+
+struct accounting_pos_offset {
+	struct bpos				pos;
+	struct bversion				version;
+	u32					offset:24,
+						nr_counters:8;
+};
+
+struct bch_accounting_mem {
+	DARRAY(struct accounting_pos_offset)	k;
+	u64 __percpu				*v;
+	unsigned				nr_counters;
+};
+
+#endif /* _BCACHEFS_DISK_ACCOUNTING_TYPES_H */
diff --git a/fs/bcachefs/ec.c b/fs/bcachefs/ec.c
index b98e2c2b8bf0..38e5e882f4a4 100644
--- a/fs/bcachefs/ec.c
+++ b/fs/bcachefs/ec.c
@@ -13,6 +13,7 @@
 #include "btree_write_buffer.h"
 #include "buckets.h"
 #include "checksum.h"
+#include "disk_accounting.h"
 #include "disk_groups.h"
 #include "ec.h"
 #include "error.h"
@@ -324,21 +325,25 @@ int bch2_trigger_stripe(struct btree_trans *trans,
 			new_s->nr_redundant	!= old_s->nr_redundant));
 
 		if (new_s) {
-			s64 sectors = le16_to_cpu(new_s->sectors);
+			s64 sectors = (u64) le16_to_cpu(new_s->sectors) * new_s->nr_redundant;
 
-			struct bch_replicas_padded r;
-			bch2_bkey_to_replicas(&r.e, new);
-			int ret = bch2_update_replicas_list(trans, &r.e, sectors * new_s->nr_redundant);
+			struct disk_accounting_key acc = {
+				.type = BCH_DISK_ACCOUNTING_replicas,
+			};
+			bch2_bkey_to_replicas(&acc.replicas, new);
+			int ret = bch2_disk_accounting_mod(trans, &acc, &sectors, 1);
 			if (ret)
 				return ret;
 		}
 
 		if (old_s) {
-			s64 sectors = -((s64) le16_to_cpu(old_s->sectors));
+			s64 sectors = -((s64) le16_to_cpu(old_s->sectors)) * old_s->nr_redundant;
 
-			struct bch_replicas_padded r;
-			bch2_bkey_to_replicas(&r.e, old);
-			int ret = bch2_update_replicas_list(trans, &r.e, sectors * old_s->nr_redundant);
+			struct disk_accounting_key acc = {
+				.type = BCH_DISK_ACCOUNTING_replicas,
+			};
+			bch2_bkey_to_replicas(&acc.replicas, old);
+			int ret = bch2_disk_accounting_mod(trans, &acc, &sectors, 1);
 			if (ret)
 				return ret;
 		}
@@ -442,8 +447,7 @@ int bch2_trigger_stripe(struct btree_trans *trans,
 		}
 
 		int ret = bch2_update_replicas(c, new, &m->r.e,
-				      ((s64) m->sectors * m->nr_redundant),
-				      0, true);
+				      ((s64) m->sectors * m->nr_redundant));
 		if (ret) {
 			struct printbuf buf = PRINTBUF;
 
diff --git a/fs/bcachefs/inode.c b/fs/bcachefs/inode.c
index a3139bb66f77..3dfa9f77c739 100644
--- a/fs/bcachefs/inode.c
+++ b/fs/bcachefs/inode.c
@@ -8,6 +8,7 @@
 #include "buckets.h"
 #include "compress.h"
 #include "dirent.h"
+#include "disk_accounting.h"
 #include "error.h"
 #include "extents.h"
 #include "extent_update.h"
@@ -610,11 +611,13 @@ int bch2_trigger_inode(struct btree_trans *trans,
 
 	if (flags & BTREE_TRIGGER_TRANSACTIONAL) {
 		if (nr) {
-			int ret = bch2_replicas_deltas_realloc(trans, 0);
+			struct disk_accounting_key acc = {
+				.type = BCH_DISK_ACCOUNTING_nr_inodes
+			};
+
+			int ret = bch2_disk_accounting_mod(trans, &acc, &nr, 1);
 			if (ret)
 				return ret;
-
-			trans->fs_usage_deltas->nr_inodes += nr;
 		}
 
 		bool old_deleted = bkey_is_deleted_inode(old);
diff --git a/fs/bcachefs/recovery.c b/fs/bcachefs/recovery.c
index b8289af66c8e..140393256f32 100644
--- a/fs/bcachefs/recovery.c
+++ b/fs/bcachefs/recovery.c
@@ -1194,9 +1194,6 @@ int bch2_fs_initialize(struct bch_fs *c)
 	for (unsigned i = 0; i < BTREE_ID_NR; i++)
 		bch2_btree_root_alloc(c, i);
 
-	for_each_member_device(c, ca)
-		bch2_dev_usage_init(ca);
-
 	ret = bch2_fs_journal_alloc(c);
 	if (ret)
 		goto err;
@@ -1213,6 +1210,15 @@ int bch2_fs_initialize(struct bch_fs *c)
 	if (ret)
 		goto err;
 
+	for_each_member_device(c, ca) {
+		ret = bch2_dev_usage_init(ca);
+		bch_err_msg(c, ret, "initializing device usage");
+		if (ret) {
+			percpu_ref_put(&ca->ref);
+			goto err;
+		}
+	}
+
 	/*
 	 * Write out the superblock and journal buckets, now that we can do
 	 * btree updates
diff --git a/fs/bcachefs/recovery_types.h b/fs/bcachefs/recovery_types.h
index 1361e34d4e64..18582e2128ed 100644
--- a/fs/bcachefs/recovery_types.h
+++ b/fs/bcachefs/recovery_types.h
@@ -13,6 +13,7 @@
  * must never change:
  */
 #define BCH_RECOVERY_PASSES()							\
+	x(accounting_read,			37, PASS_ALWAYS)		\
 	x(alloc_read,				 0, PASS_ALWAYS)		\
 	x(stripes_read,				 1, PASS_ALWAYS)		\
 	x(initialize_subvolumes,		 2, 0)				\
diff --git a/fs/bcachefs/replicas.c b/fs/bcachefs/replicas.c
index 678b9c20e251..dde581a49e28 100644
--- a/fs/bcachefs/replicas.c
+++ b/fs/bcachefs/replicas.c
@@ -254,23 +254,25 @@ static bool __replicas_has_entry(struct bch_replicas_cpu *r,
 	return __replicas_entry_idx(r, search) >= 0;
 }
 
-bool bch2_replicas_marked(struct bch_fs *c,
+bool bch2_replicas_marked_locked(struct bch_fs *c,
 			  struct bch_replicas_entry_v1 *search)
 {
-	bool marked;
-
-	if (!search->nr_devs)
-		return true;
-
 	verify_replicas_entry(search);
 
+	return !search->nr_devs ||
+		(__replicas_has_entry(&c->replicas, search) &&
+		 (likely((!c->replicas_gc.entries)) ||
+		  __replicas_has_entry(&c->replicas_gc, search)));
+}
+
+bool bch2_replicas_marked(struct bch_fs *c,
+			  struct bch_replicas_entry_v1 *search)
+{
 	percpu_down_read(&c->mark_lock);
-	marked = __replicas_has_entry(&c->replicas, search) &&
-		(likely((!c->replicas_gc.entries)) ||
-		 __replicas_has_entry(&c->replicas_gc, search));
+	bool ret = bch2_replicas_marked_locked(c, search);
 	percpu_up_read(&c->mark_lock);
 
-	return marked;
+	return ret;
 }
 
 static void __replicas_table_update(struct bch_fs_usage *dst,
@@ -468,20 +470,6 @@ int bch2_mark_replicas(struct bch_fs *c, struct bch_replicas_entry_v1 *r)
 		? 0 : bch2_mark_replicas_slowpath(c, r);
 }
 
-/* replicas delta list: */
-
-int bch2_replicas_delta_list_mark(struct bch_fs *c,
-				  struct replicas_delta_list *r)
-{
-	struct replicas_delta *d = r->d;
-	struct replicas_delta *top = (void *) r->d + r->used;
-	int ret = 0;
-
-	for (d = r->d; !ret && d != top; d = replicas_delta_next(d))
-		ret = bch2_mark_replicas(c, &d->r);
-	return ret;
-}
-
 /*
  * Old replicas_gc mechanism: only used for journal replicas entries now, should
  * die at some point:
@@ -1042,8 +1030,6 @@ void bch2_fs_replicas_exit(struct bch_fs *c)
 	kfree(c->usage_base);
 	kfree(c->replicas.entries);
 	kfree(c->replicas_gc.entries);
-
-	mempool_exit(&c->replicas_delta_pool);
 }
 
 int bch2_fs_replicas_init(struct bch_fs *c)
@@ -1052,7 +1038,5 @@ int bch2_fs_replicas_init(struct bch_fs *c)
 			&c->replicas_journal_res,
 			reserve_journal_replicas(c, &c->replicas));
 
-	return mempool_init_kmalloc_pool(&c->replicas_delta_pool, 1,
-					 REPLICAS_DELTA_LIST_MAX) ?:
-		replicas_table_update(c, &c->replicas);
+	return replicas_table_update(c, &c->replicas);
 }
diff --git a/fs/bcachefs/replicas.h b/fs/bcachefs/replicas.h
index 983cce782ac2..f00c586f8cd9 100644
--- a/fs/bcachefs/replicas.h
+++ b/fs/bcachefs/replicas.h
@@ -26,18 +26,13 @@ int bch2_replicas_entry_idx(struct bch_fs *,
 void bch2_devlist_to_replicas(struct bch_replicas_entry_v1 *,
 			      enum bch_data_type,
 			      struct bch_devs_list);
+
+bool bch2_replicas_marked_locked(struct bch_fs *,
+			  struct bch_replicas_entry_v1 *);
 bool bch2_replicas_marked(struct bch_fs *, struct bch_replicas_entry_v1 *);
 int bch2_mark_replicas(struct bch_fs *,
 		       struct bch_replicas_entry_v1 *);
 
-static inline struct replicas_delta *
-replicas_delta_next(struct replicas_delta *d)
-{
-	return (void *) d + replicas_entry_bytes(&d->r) + 8;
-}
-
-int bch2_replicas_delta_list_mark(struct bch_fs *, struct replicas_delta_list *);
-
 void bch2_bkey_to_replicas(struct bch_replicas_entry_v1 *, struct bkey_s_c);
 
 static inline void bch2_replicas_entry_cached(struct bch_replicas_entry_v1 *e,
diff --git a/fs/bcachefs/replicas_types.h b/fs/bcachefs/replicas_types.h
index ac90d142c4e8..fed71c861fe7 100644
--- a/fs/bcachefs/replicas_types.h
+++ b/fs/bcachefs/replicas_types.h
@@ -8,20 +8,4 @@ struct bch_replicas_cpu {
 	struct bch_replicas_entry_v1 *entries;
 };
 
-struct replicas_delta {
-	s64			delta;
-	struct bch_replicas_entry_v1 r;
-} __packed;
-
-struct replicas_delta_list {
-	unsigned		size;
-	unsigned		used;
-
-	struct			{} memset_start;
-	u64			nr_inodes;
-	u64			persistent_reserved[BCH_REPLICAS_MAX];
-	struct			{} memset_end;
-	struct replicas_delta	d[];
-};
-
 #endif /* _BCACHEFS_REPLICAS_TYPES_H */
diff --git a/fs/bcachefs/sb-errors_types.h b/fs/bcachefs/sb-errors_types.h
index 383e13711001..777a1adc38cf 100644
--- a/fs/bcachefs/sb-errors_types.h
+++ b/fs/bcachefs/sb-errors_types.h
@@ -265,7 +265,8 @@
 	x(subvol_children_bad,					257)	\
 	x(subvol_loop,						258)	\
 	x(subvol_unreachable,					259)	\
-	x(accounting_mismatch,					260)
+	x(accounting_mismatch,					260)	\
+	x(accounting_replicas_not_marked,			261)
 
 enum bch_sb_error_id {
 #define x(t, n) BCH_FSCK_ERR_##t = n,
diff --git a/fs/bcachefs/super.c b/fs/bcachefs/super.c
index a7f9de220d90..685d54d0ddbb 100644
--- a/fs/bcachefs/super.c
+++ b/fs/bcachefs/super.c
@@ -24,6 +24,7 @@
 #include "clock.h"
 #include "compress.h"
 #include "debug.h"
+#include "disk_accounting.h"
 #include "disk_groups.h"
 #include "ec.h"
 #include "errcode.h"
@@ -535,6 +536,7 @@ static void __bch2_fs_free(struct bch_fs *c)
 		time_stats_exit(&c->times[i]);
 
 	bch2_free_pending_node_rewrites(c);
+	bch2_fs_accounting_exit(c);
 	bch2_fs_sb_errors_exit(c);
 	bch2_fs_counters_exit(c);
 	bch2_fs_snapshots_exit(c);
@@ -1581,7 +1583,8 @@ static int bch2_dev_remove_alloc(struct bch_fs *c, struct bch_dev *ca)
 		bch2_btree_delete_range(c, BTREE_ID_alloc, start, end,
 					BTREE_TRIGGER_NORUN, NULL) ?:
 		bch2_btree_delete_range(c, BTREE_ID_bucket_gens, start, end,
-					BTREE_TRIGGER_NORUN, NULL);
+					BTREE_TRIGGER_NORUN, NULL) ?:
+		bch2_dev_usage_remove(c, ca->dev_idx);
 	bch_err_msg(c, ret, "removing dev alloc info");
 	return ret;
 }
@@ -1618,6 +1621,16 @@ int bch2_dev_remove(struct bch_fs *c, struct bch_dev *ca, int flags)
 	if (ret)
 		goto err;
 
+	/*
+	 * We need to flush the entire journal to get rid of keys that reference
+	 * the device being removed before removing the superblock entry
+	 */
+	bch2_journal_flush_all_pins(&c->journal);
+
+	/*
+	 * this is really just needed for the bch2_replicas_gc_(start|end)
+	 * calls, and could be cleaned up:
+	 */
 	ret = bch2_journal_flush_device_pins(&c->journal, ca->dev_idx);
 	bch_err_msg(ca, ret, "bch2_journal_flush_device_pins()");
 	if (ret)
@@ -1655,17 +1668,6 @@ int bch2_dev_remove(struct bch_fs *c, struct bch_dev *ca, int flags)
 
 	bch2_dev_free(ca);
 
-	/*
-	 * At this point the device object has been removed in-core, but the
-	 * on-disk journal might still refer to the device index via sb device
-	 * usage entries. Recovery fails if it sees usage information for an
-	 * invalid device. Flush journal pins to push the back of the journal
-	 * past now invalid device index references before we update the
-	 * superblock, but after the device object has been removed so any
-	 * further journal writes elide usage info for the device.
-	 */
-	bch2_journal_flush_all_pins(&c->journal);
-
 	/*
 	 * Free this device's slot in the bch_member array - all pointers to
 	 * this device must be gone:
@@ -1727,8 +1729,6 @@ int bch2_dev_add(struct bch_fs *c, const char *path)
 		goto err;
 	}
 
-	bch2_dev_usage_init(ca);
-
 	ret = __bch2_dev_attach_bdev(ca, &sb);
 	if (ret)
 		goto err;
@@ -1793,6 +1793,10 @@ int bch2_dev_add(struct bch_fs *c, const char *path)
 
 	bch2_dev_usage_journal_reserve(c);
 
+	ret = bch2_dev_usage_init(ca);
+	if (ret)
+		goto err_late;
+
 	ret = bch2_trans_mark_dev_sb(c, ca);
 	bch_err_msg(ca, ret, "marking new superblock");
 	if (ret)
@@ -1956,15 +1960,18 @@ int bch2_dev_resize(struct bch_fs *c, struct bch_dev *ca, u64 nbuckets)
 	mutex_unlock(&c->sb_lock);
 
 	if (ca->mi.freespace_initialized) {
-		ret = bch2_dev_freespace_init(c, ca, old_nbuckets, nbuckets);
+		struct disk_accounting_key acc = {
+			.type = BCH_DISK_ACCOUNTING_dev_data_type,
+			.dev_data_type.dev = ca->dev_idx,
+			.dev_data_type.data_type = BCH_DATA_free,
+		};
+		u64 v[3] = { nbuckets - old_nbuckets, 0, 0 };
+
+		ret   = bch2_dev_freespace_init(c, ca, old_nbuckets, nbuckets) ?:
+			bch2_trans_do(ca->fs, NULL, NULL, 0,
+				bch2_disk_accounting_mod(trans, &acc, v, ARRAY_SIZE(v)));
 		if (ret)
 			goto err;
-
-		/*
-		 * XXX: this is all wrong transactionally - we'll be able to do
-		 * this correctly after the disk space accounting rewrite
-		 */
-		ca->usage_base->d[BCH_DATA_free].buckets += nbuckets - old_nbuckets;
 	}
 
 	bch2_recalc_capacity(c);
-- 
2.43.0


