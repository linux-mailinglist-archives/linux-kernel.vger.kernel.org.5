Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C5779DAAB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 23:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236639AbjILVZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 17:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbjILVZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 17:25:06 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C3410CC;
        Tue, 12 Sep 2023 14:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1694553899;
        bh=/kse3qKov8RaUQQ0dAV0eIE8jxAbgGkkA/VnQUeR3Hc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=YPsHr9Qw4/eBThgV4IkuBIwtLsZbxUFHMYXOogkW4kvBlYhidVlPnDeS/8VnmSRjt
         2toiwSl/Z9+7vXh/Xlsen9bHFX1RirrWSkKbXRaN7LWl0vccDoVxLrb1wUaXY8xzym
         Eq620Ztg/cYP6ZW9/EwhQ7Gj4XWuy5ZZhkxoAp7o=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Tue, 12 Sep 2023 23:24:42 +0200
Subject: [PATCH 3/5] bcachefs: Delete set but not used variables
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230912-bcachefs-cleanup-v1-3-c1f717424e6a@weissschuh.net>
References: <20230912-bcachefs-cleanup-v1-0-c1f717424e6a@weissschuh.net>
In-Reply-To: <20230912-bcachefs-cleanup-v1-0-c1f717424e6a@weissschuh.net>
To:     Kent Overstreet <kent.overstreet@linux.dev>,
        Brian Foster <bfoster@redhat.com>
Cc:     linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694553898; l=4953;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=/kse3qKov8RaUQQ0dAV0eIE8jxAbgGkkA/VnQUeR3Hc=;
 b=Bpqe2tcv8t9Ver8916JkL9fOO3wbJpy1YoLo6UiWo4Z3/s2FXfrch5keooOAwlWNqH4OMthwM
 2qRV05NhXpaAoIeCMEXVZ3qZ7PXGqWPgVTK80xjV68LZImNtcRxBi56
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the variables are never read back they can be removed.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 fs/bcachefs/alloc_foreground.c   | 3 ---
 fs/bcachefs/backpointers.c       | 3 ---
 fs/bcachefs/btree_io.c           | 3 +--
 fs/bcachefs/btree_trans_commit.c | 4 ----
 fs/bcachefs/compress.c           | 4 ----
 fs/bcachefs/data_update.c        | 4 ----
 6 files changed, 1 insertion(+), 20 deletions(-)

diff --git a/fs/bcachefs/alloc_foreground.c b/fs/bcachefs/alloc_foreground.c
index e02749ddc362..c1c0f92da52e 100644
--- a/fs/bcachefs/alloc_foreground.c
+++ b/fs/bcachefs/alloc_foreground.c
@@ -775,7 +775,6 @@ static int bucket_alloc_from_stripe(struct btree_trans *trans,
 	struct dev_alloc_list devs_sorted;
 	struct ec_stripe_head *h;
 	struct open_bucket *ob;
-	struct bch_dev *ca;
 	unsigned i, ec_idx;
 	int ret = 0;
 
@@ -805,8 +804,6 @@ static int bucket_alloc_from_stripe(struct btree_trans *trans,
 		}
 	goto out_put_head;
 got_bucket:
-	ca = bch_dev_bkey_exists(c, ob->dev);
-
 	ob->ec_idx	= ec_idx;
 	ob->ec		= h->s;
 	ec_stripe_new_get(h->s, STRIPE_REF_io);
diff --git a/fs/bcachefs/backpointers.c b/fs/bcachefs/backpointers.c
index 8747c5e19f99..a0457b75feb5 100644
--- a/fs/bcachefs/backpointers.c
+++ b/fs/bcachefs/backpointers.c
@@ -351,7 +351,6 @@ static int bch2_check_btree_backpointer(struct btree_trans *trans, struct btree_
 {
 	struct bch_fs *c = trans->c;
 	struct btree_iter alloc_iter = { NULL };
-	struct bch_dev *ca;
 	struct bkey_s_c alloc_k;
 	struct printbuf buf = PRINTBUF;
 	int ret = 0;
@@ -363,8 +362,6 @@ static int bch2_check_btree_backpointer(struct btree_trans *trans, struct btree_
 		goto out;
 	}
 
-	ca = bch_dev_bkey_exists(c, k.k->p.inode);
-
 	alloc_k = bch2_bkey_get_iter(trans, &alloc_iter, BTREE_ID_alloc,
 				     bp_pos_to_bucket(c, k.k->p), 0);
 	ret = bkey_err(alloc_k);
diff --git a/fs/bcachefs/btree_io.c b/fs/bcachefs/btree_io.c
index 0edbb73a5ec8..8655a07456e6 100644
--- a/fs/bcachefs/btree_io.c
+++ b/fs/bcachefs/btree_io.c
@@ -908,7 +908,7 @@ int bch2_btree_node_read_done(struct bch_fs *c, struct bch_dev *ca,
 	bool updated_range = b->key.k.type == KEY_TYPE_btree_ptr_v2 &&
 		BTREE_PTR_RANGE_UPDATED(&bkey_i_to_btree_ptr_v2(&b->key)->v);
 	unsigned u64s;
-	unsigned blacklisted_written, nonblacklisted_written = 0;
+	unsigned nonblacklisted_written = 0;
 	unsigned ptr_written = btree_ptr_sectors_written(&b->key);
 	struct printbuf buf = PRINTBUF;
 	int ret = 0, retry_read = 0, write = READ;
@@ -1071,7 +1071,6 @@ int bch2_btree_node_read_done(struct bch_fs *c, struct bch_dev *ca,
 		 * important that we start writing new bsets after the most recent _non_
 		 * blacklisted bset:
 		 */
-		blacklisted_written = b->written;
 		b->written = nonblacklisted_written;
 	}
 
diff --git a/fs/bcachefs/btree_trans_commit.c b/fs/bcachefs/btree_trans_commit.c
index eafb0388ef82..b19a9400d477 100644
--- a/fs/bcachefs/btree_trans_commit.c
+++ b/fs/bcachefs/btree_trans_commit.c
@@ -555,7 +555,6 @@ bch2_trans_commit_write_locked(struct btree_trans *trans, unsigned flags,
 	struct btree_write_buffered_key *wb;
 	struct btree_trans_commit_hook *h;
 	unsigned u64s = 0;
-	bool marking = false;
 	int ret;
 
 	if (race_fault()) {
@@ -584,9 +583,6 @@ bch2_trans_commit_write_locked(struct btree_trans *trans, unsigned flags,
 			*stopped_at = i;
 			return ret;
 		}
-
-		if (btree_node_type_needs_gc(i->bkey_type))
-			marking = true;
 	}
 
 	if (trans->nr_wb_updates &&
diff --git a/fs/bcachefs/compress.c b/fs/bcachefs/compress.c
index 6b17f7cc5860..4342995b0900 100644
--- a/fs/bcachefs/compress.c
+++ b/fs/bcachefs/compress.c
@@ -571,7 +571,6 @@ void bch2_fs_compress_exit(struct bch_fs *c)
 static int __bch2_fs_compress_init(struct bch_fs *c, u64 features)
 {
 	size_t decompress_workspace_size = 0;
-	bool decompress_workspace_needed;
 	ZSTD_parameters params = zstd_get_params(zstd_max_clevel(),
 						 c->opts.encoded_extent_max);
 	struct {
@@ -620,9 +619,6 @@ static int __bch2_fs_compress_init(struct bch_fs *c, u64 features)
 		if (!(features & (1 << i->feature)))
 			continue;
 
-		if (i->decompress_workspace)
-			decompress_workspace_needed = true;
-
 		if (mempool_initialized(&c->compress_workspace[i->type]))
 			continue;
 
diff --git a/fs/bcachefs/data_update.c b/fs/bcachefs/data_update.c
index 81518f20d37d..09c757fdc448 100644
--- a/fs/bcachefs/data_update.c
+++ b/fs/bcachefs/data_update.c
@@ -49,10 +49,6 @@ static void trace_move_extent_fail2(struct data_update *m,
 	if (insert) {
 		i = 0;
 		bkey_for_each_ptr_decode(old.k, bch2_bkey_ptrs_c(old), p, entry) {
-			struct bkey_s new_s;
-			new_s.k = (void *) new.k;
-			new_s.v = (void *) new.v;
-
 			if (((1U << i) & m->data_opts.rewrite_ptrs) &&
 			    (ptr = bch2_extent_has_ptr(old, p, bkey_i_to_s(insert))) &&
 			    !ptr->cached)

-- 
2.42.0

