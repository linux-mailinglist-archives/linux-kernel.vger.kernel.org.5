Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9702679D96E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 21:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237620AbjILTQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 15:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237503AbjILTQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 15:16:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D818B18D;
        Tue, 12 Sep 2023 12:16:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E270C433CB;
        Tue, 12 Sep 2023 19:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694546164;
        bh=xmhffJpO2Wv5M/2jxEPEDOccPQ4tnS9LgJrquKpoZyY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=GkJ9c/Vlsh8XhxqWkdW7+0FErPD5NGBuMz7eKHhE/hS8AhI/YEk2erJooJZe2rbgC
         +311QSqBAKh7GSd75Jyp5oD6PSwHyx2CKwEOZlm4xg5GDmiPgX6wNUPbjWrMKV/XBp
         +IzOgKQFcQkj4zcTM02B89PNLDsAG/O6LKPIxj5I/wv5TZA7f06aL+etI3SvSETVgf
         3yrQGCtKunKD6bZjZ1/7Xpa0nZbKWQw4678dkYgmP9VtohwckBg49t8Ur9xYf7xsWN
         fimgCa+e1z0eZDEteOH5UbFtUT2D2F+OVjDJhLj+WcuE3TlsE+zvJhWqL9Igo30Nzm
         XAP0TlA9hVEGQ==
From:   Nathan Chancellor <nathan@kernel.org>
Date:   Tue, 12 Sep 2023 12:15:43 -0700
Subject: [PATCH 6/7] bcachefs: Fix -Wcompare-distinct-pointer-types in
 do_encrypt()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230912-bcachefs-warning-fixes-v1-6-a1cc83a38836@kernel.org>
References: <20230912-bcachefs-warning-fixes-v1-0-a1cc83a38836@kernel.org>
In-Reply-To: <20230912-bcachefs-warning-fixes-v1-0-a1cc83a38836@kernel.org>
To:     kent.overstreet@linux.dev
Cc:     bfoster@redhat.com, linux-bcachefs@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2296; i=nathan@kernel.org;
 h=from:subject:message-id; bh=xmhffJpO2Wv5M/2jxEPEDOccPQ4tnS9LgJrquKpoZyY=;
 b=owGbwMvMwCEmm602sfCA1DTG02pJDKkMOz6UGJd/PLjlRKj4zn2CfLPCVubKG0Qu1b575VHBs
 1seqvdZOkpZGMQ4GGTFFFmqH6seNzScc5bxxqlJMHNYmUCGMHBxCsBEXqQy/GI+bPOCy77xt1uy
 3WO9TX71W4yn5YQGcfDX/fNja45/upnhN6uYVGmpbsbbz9MO+7PfFV+8O2jrJjmNO9HreMI+z3m
 szQAA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building bcachefs for 32-bit ARM, there is a warning when using
min() to compare a variable of type 'size_t' with an expression of type
'unsigned long':

  fs/bcachefs/checksum.c:142:22: error: comparison of distinct pointer types ('typeof (len) *' (aka 'unsigned int *') and 'typeof (((1UL) << 12) - offset) *' (aka 'unsigned long *')) [-Werror,-Wcompare-distinct-pointer-types]
    142 |                         unsigned pg_len = min(len, PAGE_SIZE - offset);
        |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
  include/linux/minmax.h:69:19: note: expanded from macro 'min'
     69 | #define min(x, y)       __careful_cmp(x, y, <)
        |                         ^~~~~~~~~~~~~~~~~~~~~~
  include/linux/minmax.h:38:24: note: expanded from macro '__careful_cmp'
     38 |         __builtin_choose_expr(__safe_cmp(x, y), \
        |                               ^~~~~~~~~~~~~~~~
  include/linux/minmax.h:28:4: note: expanded from macro '__safe_cmp'
     28 |                 (__typecheck(x, y) && __no_side_effects(x, y))
        |                  ^~~~~~~~~~~~~~~~~
  include/linux/minmax.h:22:28: note: expanded from macro '__typecheck'
     22 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
        |                    ~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~
  1 error generated.

On 64-bit architectures, size_t is 'unsigned long', so there is no
warning when comparing these two expressions. Use min_t(size_t, ...) for
this situation, eliminating the warning.

Fixes: 1fb50457684f ("bcachefs: Fix memory corruption in encryption path")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 fs/bcachefs/checksum.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/bcachefs/checksum.c b/fs/bcachefs/checksum.c
index 36939020f67d..ff0c3cd39ee2 100644
--- a/fs/bcachefs/checksum.c
+++ b/fs/bcachefs/checksum.c
@@ -139,7 +139,7 @@ static inline int do_encrypt(struct crypto_sync_skcipher *tfm,
 
 		for (i = 0; i < pages; i++) {
 			unsigned offset = offset_in_page(buf);
-			unsigned pg_len = min(len, PAGE_SIZE - offset);
+			unsigned pg_len = min_t(size_t, len, PAGE_SIZE - offset);
 
 			sg_set_page(sg + i, vmalloc_to_page(buf), pg_len, offset);
 			buf += pg_len;

-- 
2.42.0

