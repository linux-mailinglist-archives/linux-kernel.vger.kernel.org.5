Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75DD779DAA8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 23:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbjILVZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 17:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjILVZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 17:25:05 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4409E10CA;
        Tue, 12 Sep 2023 14:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1694553899;
        bh=NKLXqb0OTt/gDVyckuS9hnUIcdyDYJz4twSlaN6jocE=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=m/fnUywLcsP6wGMnWNl9RMjm0WoTwQUOLqDKFMmas5l9D4SXmRYKaqf2KkQASzQA+
         7XhQse8OReVidA2BtVl/+2+dR5TbVqmzsxqh+NFnI+YXryMz2vcsf84v8LDSCdO1jD
         GKmI+LINZOWmnWBCTc0uivYpF5icc7yKGlJEhPLE=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Tue, 12 Sep 2023 23:24:40 +0200
Subject: [PATCH 1/5] bcachefs: Delete dead code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230912-bcachefs-cleanup-v1-1-c1f717424e6a@weissschuh.net>
References: <20230912-bcachefs-cleanup-v1-0-c1f717424e6a@weissschuh.net>
In-Reply-To: <20230912-bcachefs-cleanup-v1-0-c1f717424e6a@weissschuh.net>
To:     Kent Overstreet <kent.overstreet@linux.dev>,
        Brian Foster <bfoster@redhat.com>
Cc:     linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694553898; l=2720;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=NKLXqb0OTt/gDVyckuS9hnUIcdyDYJz4twSlaN6jocE=;
 b=bkf/0H8Z0N0BPxYCBVfnCv2iymBVc+pJaHcnRTyFKOZGKX2Fikzq32KyRqIZ1P+rz7GSSwV5j
 ygPTVXj1SXrCUqPMKwFeM8FZZe8Pwq8YpGFuo0DMlOtEyNNwI/rBt8/
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is not used, might as well delete it.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 fs/bcachefs/btree_update.c    | 11 -----------
 fs/bcachefs/btree_update.h    |  1 -
 fs/bcachefs/fs-io-pagecache.c |  7 -------
 fs/bcachefs/reflink.c         |  8 --------
 4 files changed, 27 deletions(-)

diff --git a/fs/bcachefs/btree_update.c b/fs/bcachefs/btree_update.c
index 880ce7431894..3dcb05b51e2d 100644
--- a/fs/bcachefs/btree_update.c
+++ b/fs/bcachefs/btree_update.c
@@ -871,17 +871,6 @@ __bch2_fs_log_msg(struct bch_fs *c, unsigned commit_flags, const char *fmt,
 	return ret;
 }
 
-int bch2_fs_log_msg(struct bch_fs *c, const char *fmt, ...)
-{
-	va_list args;
-	int ret;
-
-	va_start(args, fmt);
-	ret = __bch2_fs_log_msg(c, 0, fmt, args);
-	va_end(args);
-	return ret;
-}
-
 /*
  * Use for logging messages during recovery to enable reserved space and avoid
  * blocking.
diff --git a/fs/bcachefs/btree_update.h b/fs/bcachefs/btree_update.h
index 901c42b57c35..c6ab11c76cc3 100644
--- a/fs/bcachefs/btree_update.h
+++ b/fs/bcachefs/btree_update.h
@@ -114,7 +114,6 @@ void bch2_trans_commit_hook(struct btree_trans *,
 			    struct btree_trans_commit_hook *);
 int __bch2_trans_commit(struct btree_trans *, unsigned);
 
-int bch2_fs_log_msg(struct bch_fs *, const char *, ...);
 int bch2_journal_log_msg(struct bch_fs *, const char *, ...);
 
 /**
diff --git a/fs/bcachefs/fs-io-pagecache.c b/fs/bcachefs/fs-io-pagecache.c
index 1e60eead2981..c38f002215cd 100644
--- a/fs/bcachefs/fs-io-pagecache.c
+++ b/fs/bcachefs/fs-io-pagecache.c
@@ -73,13 +73,6 @@ int bch2_write_invalidate_inode_pages_range(struct address_space *mapping,
 	return ret;
 }
 
-static const char * const bch2_folio_sector_states[] = {
-#define x(n)	#n,
-	BCH_FOLIO_SECTOR_STATE()
-#undef x
-	NULL
-};
-
 static inline enum bch_folio_sector_state
 folio_sector_dirty(enum bch_folio_sector_state state)
 {
diff --git a/fs/bcachefs/reflink.c b/fs/bcachefs/reflink.c
index 39f711d5069e..7b20e1267fa8 100644
--- a/fs/bcachefs/reflink.c
+++ b/fs/bcachefs/reflink.c
@@ -89,14 +89,6 @@ void bch2_reflink_v_to_text(struct printbuf *out, struct bch_fs *c,
 	bch2_bkey_ptrs_to_text(out, c, k);
 }
 
-bool bch2_reflink_v_merge(struct bch_fs *c, struct bkey_s _l, struct bkey_s_c _r)
-{
-	struct bkey_s_reflink_v   l = bkey_s_to_reflink_v(_l);
-	struct bkey_s_c_reflink_v r = bkey_s_c_to_reflink_v(_r);
-
-	return l.v->refcount == r.v->refcount && bch2_extent_merge(c, _l, _r);
-}
-
 int bch2_trans_mark_reflink_v(struct btree_trans *trans,
 			      enum btree_id btree_id, unsigned level,
 			      struct bkey_s_c old, struct bkey_i *new,

-- 
2.42.0

