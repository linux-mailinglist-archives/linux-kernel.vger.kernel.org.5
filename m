Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424A379D96D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 21:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237692AbjILTQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 15:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237149AbjILTQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 15:16:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477F7C1;
        Tue, 12 Sep 2023 12:16:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B85C43391;
        Tue, 12 Sep 2023 19:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694546163;
        bh=612YPLrIsD0uPeWmH83BxpgrCG+y5OEbKK0LLl/otRk=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=jB90vDIE3JllSIP4mciLxqPf/+VpXkHCy8bhQmQNqBcjCqELqLg3bBwvuPsZ/k+gn
         qmXVTLbTO+2iXjS3t/GWUTlM5wB15QpbR/P4wisMPUUolx7olBbyYqVdjhiA4bvFWZ
         FTLpYzBieZLUKS7xRnjDZtgmyUNtUzdULSgOUKTvOieENUGDKKYQXVbg8CwhVDmoSb
         ELiNSzHsymZ1dQ6DNAMHeLTmACp5DEPlsv/R3XhGMZeI3O+8QEpBCNF603NtLksFAG
         4qWLLvdRhGlmUZ8TD+sQgCeM54mLyx2yAMT35G7xgU/pwDuQbNsXOFmc8F8Os18eUC
         Qghv6dSl0oIjQ==
From:   Nathan Chancellor <nathan@kernel.org>
Date:   Tue, 12 Sep 2023 12:15:42 -0700
Subject: [PATCH 5/7] bcachefs: Fix
 -Wincompatible-function-pointer-types-strict from key_invalid callbacks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230912-bcachefs-warning-fixes-v1-5-a1cc83a38836@kernel.org>
References: <20230912-bcachefs-warning-fixes-v1-0-a1cc83a38836@kernel.org>
In-Reply-To: <20230912-bcachefs-warning-fixes-v1-0-a1cc83a38836@kernel.org>
To:     kent.overstreet@linux.dev
Cc:     bfoster@redhat.com, linux-bcachefs@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4766; i=nathan@kernel.org;
 h=from:subject:message-id; bh=612YPLrIsD0uPeWmH83BxpgrCG+y5OEbKK0LLl/otRk=;
 b=owGbwMvMwCEmm602sfCA1DTG02pJDKkMOz407FwvfundSvbIjBceZlF3TllurBTS2XLEbOa5J
 2qnVh5n6yhlYRDjYJAVU2Spfqx63NBwzlnGG6cmwcxhZQIZwsDFKQATmbidkWHlgukr9ynkdVh8
 mTTt86T2Rx7fdwSdyy+oNq1+7iCwdd1koAreTL7Vf+UDJtU+mtjgvTek5aZEsUi4svxG1a97d5m
 WsQMA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building bcachefs with -Wincompatible-function-pointer-types-strict,
a clang warning designed to catch issues with mismatched function
pointer types, which will be fatal at runtime due to kernel Control Flow
Integrity (kCFI), there are several instances along the lines of:

  fs/bcachefs/bkey_methods.c:118:2: error: incompatible function pointer types initializing 'int (*)(const struct bch_fs *, struct bkey_s_c, enum bkey_invalid_flags, struct printbuf *)' with an expression of type 'int (const struct bch_fs *, struct bkey_s_c, unsigned int, struct printbuf *)' [-Werror,-Wincompatible-function-pointer-types-strict]
    118 |         BCH_BKEY_TYPES()
        |         ^~~~~~~~~~~~~~~~
  fs/bcachefs/bcachefs_format.h:342:2: note: expanded from macro 'BCH_BKEY_TYPES'
    342 |         x(deleted,              0)                      \
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
  fs/bcachefs/bkey_methods.c:117:41: note: expanded from macro 'x'
    117 | #define x(name, nr) [KEY_TYPE_##name]   = bch2_bkey_ops_##name,
        |                                           ^~~~~~~~~~~~~~~~~~~~
  <scratch space>:206:1: note: expanded from here
    206 | bch2_bkey_ops_deleted
        | ^~~~~~~~~~~~~~~~~~~~~
  fs/bcachefs/bkey_methods.c:34:17: note: expanded from macro 'bch2_bkey_ops_deleted'
     34 |         .key_invalid = deleted_key_invalid,             \
        |                        ^~~~~~~~~~~~~~~~~~~

The flags parameter should be of type 'enum bkey_invalid_flags', not
'unsigned int'. Adjust the type everywhere so that there is no more
warning.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 fs/bcachefs/bkey_methods.c | 10 +++++-----
 fs/bcachefs/subvolume.c    |  2 +-
 fs/bcachefs/subvolume.h    |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/bcachefs/bkey_methods.c b/fs/bcachefs/bkey_methods.c
index 6547142db428..2a284c954c7a 100644
--- a/fs/bcachefs/bkey_methods.c
+++ b/fs/bcachefs/bkey_methods.c
@@ -25,7 +25,7 @@ const char * const bch2_bkey_types[] = {
 };
 
 static int deleted_key_invalid(const struct bch_fs *c, struct bkey_s_c k,
-			       unsigned flags, struct printbuf *err)
+			       enum bkey_invalid_flags flags, struct printbuf *err)
 {
 	return 0;
 }
@@ -39,7 +39,7 @@ static int deleted_key_invalid(const struct bch_fs *c, struct bkey_s_c k,
 })
 
 static int empty_val_key_invalid(const struct bch_fs *c, struct bkey_s_c k,
-				 unsigned flags, struct printbuf *err)
+				 enum bkey_invalid_flags flags, struct printbuf *err)
 {
 	if (bkey_val_bytes(k.k)) {
 		prt_printf(err, "incorrect value size (%zu != 0)",
@@ -55,7 +55,7 @@ static int empty_val_key_invalid(const struct bch_fs *c, struct bkey_s_c k,
 })
 
 static int key_type_cookie_invalid(const struct bch_fs *c, struct bkey_s_c k,
-				   unsigned flags, struct printbuf *err)
+				   enum bkey_invalid_flags flags, struct printbuf *err)
 {
 	return 0;
 }
@@ -70,7 +70,7 @@ static int key_type_cookie_invalid(const struct bch_fs *c, struct bkey_s_c k,
 })
 
 static int key_type_inline_data_invalid(const struct bch_fs *c, struct bkey_s_c k,
-					unsigned flags, struct printbuf *err)
+					enum bkey_invalid_flags flags, struct printbuf *err)
 {
 	return 0;
 }
@@ -91,7 +91,7 @@ static void key_type_inline_data_to_text(struct printbuf *out, struct bch_fs *c,
 })
 
 static int key_type_set_invalid(const struct bch_fs *c, struct bkey_s_c k,
-				unsigned flags, struct printbuf *err)
+				enum bkey_invalid_flags flags, struct printbuf *err)
 {
 	if (bkey_val_bytes(k.k)) {
 		prt_printf(err, "incorrect value size (%zu != %zu)",
diff --git a/fs/bcachefs/subvolume.c b/fs/bcachefs/subvolume.c
index 0214a98deb4f..b371a5c4e06e 100644
--- a/fs/bcachefs/subvolume.c
+++ b/fs/bcachefs/subvolume.c
@@ -99,7 +99,7 @@ int bch2_check_subvols(struct bch_fs *c)
 /* Subvolumes: */
 
 int bch2_subvolume_invalid(const struct bch_fs *c, struct bkey_s_c k,
-			   unsigned flags, struct printbuf *err)
+			   enum bkey_invalid_flags flags, struct printbuf *err)
 {
 	if (bkey_lt(k.k->p, SUBVOL_POS_MIN) ||
 	    bkey_gt(k.k->p, SUBVOL_POS_MAX)) {
diff --git a/fs/bcachefs/subvolume.h b/fs/bcachefs/subvolume.h
index 8d4c50f4cd05..bb14f92e8687 100644
--- a/fs/bcachefs/subvolume.h
+++ b/fs/bcachefs/subvolume.h
@@ -10,7 +10,7 @@ enum bkey_invalid_flags;
 int bch2_check_subvols(struct bch_fs *);
 
 int bch2_subvolume_invalid(const struct bch_fs *, struct bkey_s_c,
-			   unsigned, struct printbuf *);
+			   enum bkey_invalid_flags, struct printbuf *);
 void bch2_subvolume_to_text(struct printbuf *, struct bch_fs *, struct bkey_s_c);
 
 #define bch2_bkey_ops_subvolume ((struct bkey_ops) {		\

-- 
2.42.0

