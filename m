Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281B279DAA7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 23:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbjILVZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 17:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbjILVZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 17:25:05 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6290B10CC;
        Tue, 12 Sep 2023 14:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1694553899;
        bh=troU+PLlpwci323/gDB4WCiWvfP0ri6UwPZrciYRTEw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=iThkq4cZawFuSxlPgoouuVennh3f97hIHInNKMBu6XYDe3UlW1FikkCUe78qF2ZYC
         cdyWAOnmijSQx7DBPSP2s/jiY4J9LwpVJDPsCoeNIj90b/d0aeA6D91LBu+vYqJP+b
         uqRWIlsIeSTdakfpghyVSwduCagA9WphDjW/Hc+U=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Tue, 12 Sep 2023 23:24:43 +0200
Subject: [PATCH 4/5] bcachefs: Add printf function attributes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230912-bcachefs-cleanup-v1-4-c1f717424e6a@weissschuh.net>
References: <20230912-bcachefs-cleanup-v1-0-c1f717424e6a@weissschuh.net>
In-Reply-To: <20230912-bcachefs-cleanup-v1-0-c1f717424e6a@weissschuh.net>
To:     Kent Overstreet <kent.overstreet@linux.dev>,
        Brian Foster <bfoster@redhat.com>
Cc:     linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694553898; l=2069;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=troU+PLlpwci323/gDB4WCiWvfP0ri6UwPZrciYRTEw=;
 b=UK0IJW37miCSEW8yO3EoCxvTRteZPjU10AFlPnPVJvMYtlcq72U7XIE/0JVsNjtbVPc3H+vEW
 XgvSvjFN426BbdhG0LXoxQDwbwc6c5+m6R8OoVWKAL+8bWKY/JFtPXK
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These help the compiler detect incorrect use of format strings and their
arguments.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 fs/bcachefs/btree_io.c     | 1 +
 fs/bcachefs/btree_update.c | 2 ++
 fs/bcachefs/btree_update.h | 3 +++
 3 files changed, 6 insertions(+)

diff --git a/fs/bcachefs/btree_io.c b/fs/bcachefs/btree_io.c
index 8655a07456e6..bfaaa6b612ad 100644
--- a/fs/bcachefs/btree_io.c
+++ b/fs/bcachefs/btree_io.c
@@ -542,6 +542,7 @@ static void btree_err_msg(struct printbuf *out, struct bch_fs *c,
 	prt_str(out, ": ");
 }
 
+__printf(8, 9)
 static int __btree_err(int ret,
 		       struct bch_fs *c,
 		       struct bch_dev *ca,
diff --git a/fs/bcachefs/btree_update.c b/fs/bcachefs/btree_update.c
index 3dcb05b51e2d..cf0415e93feb 100644
--- a/fs/bcachefs/btree_update.c
+++ b/fs/bcachefs/btree_update.c
@@ -818,6 +818,7 @@ int bch2_btree_bit_mod(struct btree_trans *trans, enum btree_id btree,
 	return bch2_trans_update_buffered(trans, btree, k);
 }
 
+__printf(2, 0)
 static int __bch2_trans_log_msg(darray_u64 *entries, const char *fmt, va_list args)
 {
 	struct printbuf buf = PRINTBUF;
@@ -854,6 +855,7 @@ static int __bch2_trans_log_msg(darray_u64 *entries, const char *fmt, va_list ar
 	return ret;
 }
 
+__printf(3, 0)
 static int
 __bch2_fs_log_msg(struct bch_fs *c, unsigned commit_flags, const char *fmt,
 		  va_list args)
diff --git a/fs/bcachefs/btree_update.h b/fs/bcachefs/btree_update.h
index c6ab11c76cc3..13a47aac9b81 100644
--- a/fs/bcachefs/btree_update.h
+++ b/fs/bcachefs/btree_update.h
@@ -2,6 +2,8 @@
 #ifndef _BCACHEFS_BTREE_UPDATE_H
 #define _BCACHEFS_BTREE_UPDATE_H
 
+#include <linux/compiler.h>
+
 #include "btree_iter.h"
 #include "journal.h"
 #include "journal.h"
@@ -114,6 +116,7 @@ void bch2_trans_commit_hook(struct btree_trans *,
 			    struct btree_trans_commit_hook *);
 int __bch2_trans_commit(struct btree_trans *, unsigned);
 
+__printf(2, 3)
 int bch2_journal_log_msg(struct bch_fs *, const char *, ...);
 
 /**

-- 
2.42.0

