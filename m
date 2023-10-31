Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9D27DD836
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 23:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346593AbjJaWZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 18:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344904AbjJaWZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 18:25:04 -0400
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5115FF1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 15:25:01 -0700 (PDT)
Date:   Tue, 31 Oct 2023 18:24:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698791099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JYZZE+NNtN99ccP0GWk+NGka3Ucrk80KMAOaJ8JHtuk=;
        b=o57N6J30fJ8hu4aXTcnv90wq/NFwBQFfRUdmJ0wqqSQMw65mz/Ot3TFwax2qwPuBq3V/Di
        vTLZqlbbcj3uYPdkEbv+Zw+tiHHgLmA4/LUp5mNULO9RgpNpM+7vo/DgcF1jYAnzfxdQVu
        kRRdl+VkllTVgf0UT2eAnQuuj0Rnwlk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
Cc:     linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        regressions@lists.linux.dev
Subject: Re: mainline build failure due to 5cfd69775eb5 ("bcachefs: Array
 bounds fixes")
Message-ID: <20231031222455.mbhbhxiykq7dnuvl@moria.home.lan>
References: <ZUF8bYTl5SBlbBBJ@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUF8bYTl5SBlbBBJ@debian>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 10:15:09PM +0000, Sudip Mukherjee (Codethink) wrote:
> Hi All,
> 
> The latest mainline kernel branch fails to build arm64 allmodconfig
> with a native build on an arm64 host with the error:
> 
> In file included from fs/bcachefs/btree_io.c:11:
> fs/bcachefs/btree_update_interior.h: In function 'want_new_bset':
> fs/bcachefs/btree_update_interior.h:274:36: error: array subscript 0 is outside the bounds of an interior zero-length array 'struct bkey_packed[0]' [-Werror=zero-length-bounds]
>   274 |   __bch_btree_u64s_remaining(c, b, &bne->keys.start[0]);
>       |                                    ^~~~~~~~~~~~~~~~~~~
> In file included from fs/bcachefs/bcachefs.h:206,
>                  from fs/bcachefs/btree_io.c:3:
> fs/bcachefs/bcachefs_format.h:2344:21: note: while referencing 'start'
>  2344 |  struct bkey_packed start[0];
>       |                     ^~~~~
> 
> git bisect pointed to 5cfd69775eb5 ("bcachefs: Array bounds fixes").
> 
> I will be happy to test any patch or provide any extra log if needed.

Following patch should resolve everything:

-- >8 --
From ad77f25f730ec9a0eb04be5adc591628654b85ae Mon Sep 17 00:00:00 2001
From: Kent Overstreet <kent.overstreet@linux.dev>
Date: Tue, 31 Oct 2023 18:05:22 -0400
Subject: [PATCH] bcachefs: Fix build errors with gcc 10

gcc 10 seems to complain about array bounds in situations where gcc 11
does not - curious.

This unfortunately requires adding some casts for now; we may
investigate getting rid of our __u64 _data[] VLA in a future patch so
that our start[0] members can be VLAs.

Reported-by: John Stoffel <john@stoffel.org>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>

diff --git a/fs/bcachefs/bcachefs_format.h b/fs/bcachefs/bcachefs_format.h
index 29b000c6b7e1..5b44598b9df9 100644
--- a/fs/bcachefs/bcachefs_format.h
+++ b/fs/bcachefs/bcachefs_format.h
@@ -1617,9 +1617,7 @@ struct journal_seq_blacklist_entry {
 
 struct bch_sb_field_journal_seq_blacklist {
 	struct bch_sb_field	field;
-
-	struct journal_seq_blacklist_entry start[0];
-	__u64			_data[];
+	struct journal_seq_blacklist_entry start[];
 };
 
 struct bch_sb_field_errors {
diff --git a/fs/bcachefs/btree_trans_commit.c b/fs/bcachefs/btree_trans_commit.c
index 8140b6e6e9a6..32693f7c6221 100644
--- a/fs/bcachefs/btree_trans_commit.c
+++ b/fs/bcachefs/btree_trans_commit.c
@@ -681,7 +681,7 @@ bch2_trans_commit_write_locked(struct btree_trans *trans, unsigned flags,
 						       BCH_JSET_ENTRY_overwrite,
 						       i->btree_id, i->level,
 						       i->old_k.u64s);
-				bkey_reassemble(&entry->start[0],
+				bkey_reassemble((struct bkey_i *) entry->start,
 						(struct bkey_s_c) { &i->old_k, i->old_v });
 			}
 
@@ -689,7 +689,7 @@ bch2_trans_commit_write_locked(struct btree_trans *trans, unsigned flags,
 					       BCH_JSET_ENTRY_btree_keys,
 					       i->btree_id, i->level,
 					       i->k->k.u64s);
-			bkey_copy(&entry->start[0], i->k);
+			bkey_copy((struct bkey_i *) entry->start, i->k);
 		}
 
 		trans_for_each_wb_update(trans, wb) {
@@ -697,7 +697,7 @@ bch2_trans_commit_write_locked(struct btree_trans *trans, unsigned flags,
 					       BCH_JSET_ENTRY_btree_keys,
 					       wb->btree, 0,
 					       wb->k.k.u64s);
-			bkey_copy(&entry->start[0], &wb->k);
+			bkey_copy((struct bkey_i *) entry->start, &wb->k);
 		}
 
 		if (trans->journal_seq)
diff --git a/fs/bcachefs/btree_update_interior.c b/fs/bcachefs/btree_update_interior.c
index d029e0348c91..89ada89eafe7 100644
--- a/fs/bcachefs/btree_update_interior.c
+++ b/fs/bcachefs/btree_update_interior.c
@@ -2411,7 +2411,7 @@ void bch2_journal_entry_to_btree_root(struct bch_fs *c, struct jset_entry *entry
 
 	r->level = entry->level;
 	r->alive = true;
-	bkey_copy(&r->key, &entry->start[0]);
+	bkey_copy(&r->key, (struct bkey_i *) entry->start);
 
 	mutex_unlock(&c->btree_root_lock);
 }
diff --git a/fs/bcachefs/btree_update_interior.h b/fs/bcachefs/btree_update_interior.h
index 5e0a467fe905..d92b3cf5f5e0 100644
--- a/fs/bcachefs/btree_update_interior.h
+++ b/fs/bcachefs/btree_update_interior.h
@@ -271,7 +271,7 @@ static inline struct btree_node_entry *want_new_bset(struct bch_fs *c,
 	struct btree_node_entry *bne = max(write_block(b),
 			(void *) btree_bkey_last(b, bset_tree_last(b)));
 	ssize_t remaining_space =
-		__bch_btree_u64s_remaining(c, b, &bne->keys.start[0]);
+		__bch_btree_u64s_remaining(c, b, bne->keys.start);
 
 	if (unlikely(bset_written(b, bset(b, t)))) {
 		if (remaining_space > (ssize_t) (block_bytes(c) >> 3))
diff --git a/fs/bcachefs/recovery.c b/fs/bcachefs/recovery.c
index f73338f37bf1..9600b8083175 100644
--- a/fs/bcachefs/recovery.c
+++ b/fs/bcachefs/recovery.c
@@ -226,7 +226,7 @@ static int journal_replay_entry_early(struct bch_fs *c,
 
 		if (entry->u64s) {
 			r->level = entry->level;
-			bkey_copy(&r->key, &entry->start[0]);
+			bkey_copy(&r->key, (struct bkey_i *) entry->start);
 			r->error = 0;
 		} else {
 			r->error = -EIO;
