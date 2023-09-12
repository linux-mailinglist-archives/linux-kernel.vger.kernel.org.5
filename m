Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16F479D96F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 21:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237604AbjILTQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 15:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234198AbjILTQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 15:16:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B001C1;
        Tue, 12 Sep 2023 12:16:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D22EC433D9;
        Tue, 12 Sep 2023 19:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694546162;
        bh=rBOGsl43c5tN1pj3NNiddVWSvdW/4IOQgYcW7rQhIrU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Jm+8j0/YIdpuss00E39s2eFHN8HGqzZYdflVjJQvjsRBl55wiEPisKBktxpPGi3pq
         UvSpnYrUj59evqJsF8x7rC6+PJuwOY9aOYHGKvsXRDRDqqEbDxuVnGR5fvNi6it82n
         rLfOzGHrVrvgMNOJRAuTkNFe7RDw+nZsOW82UgQO7cwTT+Xjvx3j0vUggT0cjJcGbQ
         x45SERy16N+jRTafaSZR82BLcjYYgBW4yesrNfmasKXrvqnuX3b2MGlaWThZlgaQcd
         dsm9Prx1vXweDZdRjWdx4y76riXlCkrJqfzPc7gQNogjRPw2A4w3OA/nW78Fv3D3y+
         53tEwuVQWbczA==
From:   Nathan Chancellor <nathan@kernel.org>
Date:   Tue, 12 Sep 2023 12:15:40 -0700
Subject: [PATCH 3/7] bcachefs: Fix -Wformat in bch2_alloc_v4_invalid()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230912-bcachefs-warning-fixes-v1-3-a1cc83a38836@kernel.org>
References: <20230912-bcachefs-warning-fixes-v1-0-a1cc83a38836@kernel.org>
In-Reply-To: <20230912-bcachefs-warning-fixes-v1-0-a1cc83a38836@kernel.org>
To:     kent.overstreet@linux.dev
Cc:     bfoster@redhat.com, linux-bcachefs@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2142; i=nathan@kernel.org;
 h=from:subject:message-id; bh=rBOGsl43c5tN1pj3NNiddVWSvdW/4IOQgYcW7rQhIrU=;
 b=owGbwMvMwCEmm602sfCA1DTG02pJDKkMO973G3aonJ618tICI+252UxMyXWmmzLn6t/8OnPFf
 b2icLbfHaUsDGIcDLJiiizVj1WPGxrOOct449QkmDmsTCBDGLg4BWAiAiGMDC/ffFsfm/G5vDU1
 1f3ye39ZrnvJz85czd1obdUfeeiSWTnD/6S+g919wWkME3ZyB3qkps8S3NrMcmzB87vxFVkFIs8
 XMwMA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building bcachefs for 32-bit ARM, there is a compiler warning in
bch2_alloc_v4_invalid() due to use of an incorrect format specifier:

  fs/bcachefs/alloc_background.c:246:30: error: format specifies type 'unsigned long' but the argument has type 'unsigned int' [-Werror,-Wformat]
    245 |                 prt_printf(err, "bad val size (%u > %lu)",
        |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        |                                                     %u
    246 |                        alloc_v4_u64s(a.v), bkey_val_u64s(k.k));
        |                        ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
  fs/bcachefs/bkey.h:58:27: note: expanded from macro 'bkey_val_u64s'
     58 | #define bkey_val_u64s(_k)       ((_k)->u64s - BKEY_U64s)
        |                                 ^
  fs/bcachefs/util.h:223:54: note: expanded from macro 'prt_printf'
    223 | #define prt_printf(_out, ...)           bch2_prt_printf(_out, __VA_ARGS__)
        |                                                               ^~~~~~~~~~~

This expression is of type 'size_t'. On 64-bit architectures, size_t is
'unsigned long', so there is no warning when using %lu but on 32-bit
architectures, size_t is 'unsigned int'. Use '%zu', the format specifier
for 'size_t' to eliminate the warning.

Fixes: 11be8e8db283 ("bcachefs: New on disk format: Backpointers")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 fs/bcachefs/alloc_background.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/bcachefs/alloc_background.c b/fs/bcachefs/alloc_background.c
index 540d94c0cceb..67e73864823c 100644
--- a/fs/bcachefs/alloc_background.c
+++ b/fs/bcachefs/alloc_background.c
@@ -242,7 +242,7 @@ int bch2_alloc_v4_invalid(const struct bch_fs *c, struct bkey_s_c k,
 	struct bkey_s_c_alloc_v4 a = bkey_s_c_to_alloc_v4(k);
 
 	if (alloc_v4_u64s(a.v) > bkey_val_u64s(k.k)) {
-		prt_printf(err, "bad val size (%u > %lu)",
+		prt_printf(err, "bad val size (%u > %zu)",
 		       alloc_v4_u64s(a.v), bkey_val_u64s(k.k));
 		return -BCH_ERR_invalid_bkey;
 	}

-- 
2.42.0

