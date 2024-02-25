Return-Path: <linux-kernel+bounces-79931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A44C68628D1
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 03:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BD5A1F21792
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 02:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD6ABE5E;
	Sun, 25 Feb 2024 02:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vpUILZjD"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC73F3D60
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 02:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708828720; cv=none; b=phAsi4EBUO/ENV9TH7IqGJzzqkl5AnRxaOqoIof9yhb0i/CNvmikR23vOvewDFhFWbUUg6CcLe9nVEm+cEqfRwzZPZdJPGkiY9STehq5SgXEYr61POuIuLY7B6/CODTwif530ZMtEYrnB0mK/iSGmnbu8+f3dShFh+h8D4g9giY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708828720; c=relaxed/simple;
	bh=TY8NtdnU3pWFnKYN+4BU1L207QW6+D+/TUTduTofl4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GAVUmU1vKRYDd5DoOhNQJoWe3r6Yx9T92B5blMfhEq9w8HLVFmPnmiQ4dSL7q0R448T8eRadURq87KtsuOOMIphv6iJJ0xkmnwePwKRY9eDZhwPy3a3tVrGOaAbKK2FPZqw/Dwk79w23zYXDwgOOUKYXic7fJtfMhN8f6isI268=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vpUILZjD; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708828716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oAccuhu6Iwsb4yqWKJItHSJ6C2cFFxtNuJ2qW8cn31Q=;
	b=vpUILZjD67dT5GvnEE+MYqYBvAl2MpVeSAy1+47qjpPmcvPYX9jCSoJkXGK3TostWq241J
	lZzXyTNOx7Ty/LUv45lJwV4zGe84EdqX0is+ApkUjprA3SK3gWcqXRJZ3JlG/dMUL/qXcv
	dRKZaO1GOJq/v6T8Sg5/85O++xxJWTM=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	djwong@kernel.org,
	bfoster@redhat.com
Subject: [PATCH 02/21] bcachefs: Accumulate accounting keys in journal replay
Date: Sat, 24 Feb 2024 21:38:04 -0500
Message-ID: <20240225023826.2413565-3-kent.overstreet@linux.dev>
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

Until accounting keys hit the btree, they are deltas, not new versions
of the existing key; this means we have to teach journal replay to
accumulate them.

Additionally, the journal doesn't track precisely which entries have
been flushed to the btree; it only tracks a range of entries that may
possibly still need to be flushed.

That means we need to compare accounting keys against the version in the
btree and only flush updates that are newer.

There's another wrinkle with the write buffer: if the write buffer
starts flushing accounting keys before journal replay has finished
flushing accounting keys, journal replay will see the version number
from the new updates and updates from the journal will be lost.

To avoid this, journal replay has to flush accounting keys first, and
we'll be adding a flag so that write buffer flush knows to hold
accounting keys until then.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/bcachefs/btree_journal_iter.c | 23 +++-------
 fs/bcachefs/btree_journal_iter.h | 15 +++++++
 fs/bcachefs/btree_trans_commit.c |  9 +++-
 fs/bcachefs/btree_update.h       | 14 +++++-
 fs/bcachefs/recovery.c           | 76 +++++++++++++++++++++++++++++++-
 5 files changed, 117 insertions(+), 20 deletions(-)

diff --git a/fs/bcachefs/btree_journal_iter.c b/fs/bcachefs/btree_journal_iter.c
index 207dd32e2ecc..164a316d8995 100644
--- a/fs/bcachefs/btree_journal_iter.c
+++ b/fs/bcachefs/btree_journal_iter.c
@@ -16,21 +16,6 @@
  * operations for the regular btree iter code to use:
  */
 
-static int __journal_key_cmp(enum btree_id	l_btree_id,
-			     unsigned		l_level,
-			     struct bpos	l_pos,
-			     const struct journal_key *r)
-{
-	return (cmp_int(l_btree_id,	r->btree_id) ?:
-		cmp_int(l_level,	r->level) ?:
-		bpos_cmp(l_pos,	r->k->k.p));
-}
-
-static int journal_key_cmp(const struct journal_key *l, const struct journal_key *r)
-{
-	return __journal_key_cmp(l->btree_id, l->level, l->k->k.p, r);
-}
-
 static inline size_t idx_to_pos(struct journal_keys *keys, size_t idx)
 {
 	size_t gap_size = keys->size - keys->nr;
@@ -492,7 +477,13 @@ static void __journal_keys_sort(struct journal_keys *keys)
 	struct journal_key *dst = keys->data;
 
 	darray_for_each(*keys, src) {
-		if (src + 1 < &darray_top(*keys) &&
+		/*
+		 * We don't accumulate accounting keys here because we have to
+		 * compare each individual accounting key against the version in
+		 * the btree during replay:
+		 */
+		if (src->k->k.type != KEY_TYPE_accounting &&
+		    src + 1 < &darray_top(*keys) &&
 		    !journal_key_cmp(src, src + 1))
 			continue;
 
diff --git a/fs/bcachefs/btree_journal_iter.h b/fs/bcachefs/btree_journal_iter.h
index c9d19da3ea04..8f3d9a3f1969 100644
--- a/fs/bcachefs/btree_journal_iter.h
+++ b/fs/bcachefs/btree_journal_iter.h
@@ -26,6 +26,21 @@ struct btree_and_journal_iter {
 	bool			prefetch;
 };
 
+static inline int __journal_key_cmp(enum btree_id	l_btree_id,
+				    unsigned		l_level,
+				    struct bpos	l_pos,
+				    const struct journal_key *r)
+{
+	return (cmp_int(l_btree_id,	r->btree_id) ?:
+		cmp_int(l_level,	r->level) ?:
+		bpos_cmp(l_pos,	r->k->k.p));
+}
+
+static inline int journal_key_cmp(const struct journal_key *l, const struct journal_key *r)
+{
+	return __journal_key_cmp(l->btree_id, l->level, l->k->k.p, r);
+}
+
 struct bkey_i *bch2_journal_keys_peek_upto(struct bch_fs *, enum btree_id,
 				unsigned, struct bpos, struct bpos, size_t *);
 struct bkey_i *bch2_journal_keys_peek_slot(struct bch_fs *, enum btree_id,
diff --git a/fs/bcachefs/btree_trans_commit.c b/fs/bcachefs/btree_trans_commit.c
index 30d69a6d133e..60f6255367b9 100644
--- a/fs/bcachefs/btree_trans_commit.c
+++ b/fs/bcachefs/btree_trans_commit.c
@@ -760,8 +760,15 @@ bch2_trans_commit_write_locked(struct btree_trans *trans, unsigned flags,
 
 static noinline void bch2_drop_overwrites_from_journal(struct btree_trans *trans)
 {
+	/*
+	 * Accounting keys aren't deduped in the journal: we have to compare
+	 * each individual update against what's in the btree to see if it has
+	 * been applied yet, and accounting updates also don't overwrite,
+	 * they're deltas that accumulate.
+	 */
 	trans_for_each_update(trans, i)
-		bch2_journal_key_overwritten(trans->c, i->btree_id, i->level, i->k->k.p);
+		if (i->k->k.type != KEY_TYPE_accounting)
+			bch2_journal_key_overwritten(trans->c, i->btree_id, i->level, i->k->k.p);
 }
 
 static noinline int bch2_trans_commit_bkey_invalid(struct btree_trans *trans,
diff --git a/fs/bcachefs/btree_update.h b/fs/bcachefs/btree_update.h
index cc7c53e83f89..21f887fe857c 100644
--- a/fs/bcachefs/btree_update.h
+++ b/fs/bcachefs/btree_update.h
@@ -128,7 +128,19 @@ static inline int __must_check bch2_trans_update_buffered(struct btree_trans *tr
 					    enum btree_id btree,
 					    struct bkey_i *k)
 {
-	if (unlikely(trans->journal_replay_not_finished))
+	/*
+	 * Most updates skip the btree write buffer until journal replay is
+	 * finished because synchronization with journal replay relies on having
+	 * a btree node locked - if we're overwriting a key in the journal that
+	 * journal replay hasn't yet replayed, we have to mark it as
+	 * overwritten.
+	 *
+	 * But accounting updates don't overwrite, they're deltas, and they have
+	 * to be flushed to the btree strictly in order for journal replay to be
+	 * able to tell which updates need to be applied:
+	 */
+	if (k->k.type != KEY_TYPE_accounting &&
+	    unlikely(trans->journal_replay_not_finished))
 		return bch2_btree_insert_clone_trans(trans, btree, k);
 
 	struct jset_entry *e = bch2_trans_jset_entry_alloc(trans, jset_u64s(k->k.u64s));
diff --git a/fs/bcachefs/recovery.c b/fs/bcachefs/recovery.c
index 96e7a1ec7091..6829d80bd181 100644
--- a/fs/bcachefs/recovery.c
+++ b/fs/bcachefs/recovery.c
@@ -11,6 +11,7 @@
 #include "btree_io.h"
 #include "buckets.h"
 #include "dirent.h"
+#include "disk_accounting.h"
 #include "ec.h"
 #include "errcode.h"
 #include "error.h"
@@ -87,6 +88,56 @@ static void replay_now_at(struct journal *j, u64 seq)
 		bch2_journal_pin_put(j, j->replay_journal_seq++);
 }
 
+static int bch2_journal_replay_accounting_key(struct btree_trans *trans,
+					      struct journal_key *k)
+{
+	struct journal_keys *keys = &trans->c->journal_keys;
+
+	struct btree_iter iter;
+	bch2_trans_node_iter_init(trans, &iter, k->btree_id, k->k->k.p,
+				  BTREE_MAX_DEPTH, k->level,
+				  BTREE_ITER_INTENT);
+	int ret = bch2_btree_iter_traverse(&iter);
+	if (ret)
+		goto out;
+
+	struct bkey u;
+	struct bkey_s_c old = bch2_btree_path_peek_slot(btree_iter_path(trans, &iter), &u);
+
+	if (bversion_cmp(old.k->version, k->k->k.version) >= 0) {
+		ret = 0;
+		goto out;
+	}
+
+	if (k + 1 < &darray_top(*keys) &&
+	    !journal_key_cmp(k, k + 1)) {
+		BUG_ON(bversion_cmp(k[0].k->k.version, k[1].k->k.version) > 0);
+
+		bch2_accounting_accumulate(bkey_i_to_accounting(k[1].k),
+					   bkey_i_to_s_c_accounting(k[0].k));
+		ret = 0;
+		goto out;
+	}
+
+	struct bkey_i *new = k->k;
+	if (old.k->type == KEY_TYPE_accounting) {
+		new = bch2_bkey_make_mut_noupdate(trans, bkey_i_to_s_c(k->k));
+		ret = PTR_ERR_OR_ZERO(new);
+		if (ret)
+			goto out;
+
+		bch2_accounting_accumulate(bkey_i_to_accounting(new),
+					   bkey_s_c_to_accounting(old));
+	}
+
+	trans->journal_res.seq = k->journal_seq;
+
+	ret = bch2_trans_update(trans, &iter, new, BTREE_TRIGGER_NORUN);
+out:
+	bch2_trans_iter_exit(trans, &iter);
+	return ret;
+}
+
 static int bch2_journal_replay_key(struct btree_trans *trans,
 				   struct journal_key *k)
 {
@@ -159,12 +210,33 @@ static int bch2_journal_replay(struct bch_fs *c)
 
 	BUG_ON(!atomic_read(&keys->ref));
 
+	/*
+	 * Replay accounting keys first: we can't allow the write buffer to
+	 * flush accounting keys until we're done
+	 */
+	darray_for_each(*keys, k) {
+		if (!(k->k->k.type == KEY_TYPE_accounting && !k->allocated))
+			continue;
+
+		cond_resched();
+
+		ret = commit_do(trans, NULL, NULL,
+				BCH_TRANS_COMMIT_no_enospc|
+				BCH_TRANS_COMMIT_no_journal_res,
+			     bch2_journal_replay_accounting_key(trans, k));
+		if (bch2_fs_fatal_err_on(ret, c, "error replaying accounting; %s", bch2_err_str(ret)))
+			goto err;
+	}
+
 	/*
 	 * First, attempt to replay keys in sorted order. This is more
 	 * efficient - better locality of btree access -  but some might fail if
 	 * that would cause a journal deadlock.
 	 */
 	darray_for_each(*keys, k) {
+		if (k->k->k.type == KEY_TYPE_accounting && !k->allocated)
+			continue;
+
 		cond_resched();
 
 		/* Skip fastpath if we're low on space in the journal */
@@ -174,7 +246,7 @@ static int bch2_journal_replay(struct bch_fs *c)
 				  BCH_TRANS_COMMIT_journal_reclaim|
 				  (!k->allocated ? BCH_TRANS_COMMIT_no_journal_res : 0),
 			     bch2_journal_replay_key(trans, k));
-		BUG_ON(!ret && !k->overwritten);
+		BUG_ON(!ret && !k->overwritten && k->k->k.type != KEY_TYPE_accounting);
 		if (ret) {
 			ret = darray_push(&keys_sorted, k);
 			if (ret)
@@ -208,7 +280,7 @@ static int bch2_journal_replay(struct bch_fs *c)
 		if (ret)
 			goto err;
 
-		BUG_ON(!k->overwritten);
+		BUG_ON(k->btree_id != BTREE_ID_accounting && !k->overwritten);
 	}
 
 	/*
-- 
2.43.0


