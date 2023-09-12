Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC7D79D96C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 21:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237690AbjILTQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 15:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjILTQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 15:16:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DE71B2;
        Tue, 12 Sep 2023 12:16:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACFB3C433CD;
        Tue, 12 Sep 2023 19:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694546165;
        bh=mr+NsehKtc1BM6Zeb//Yv+u2js+H8NOBbn0lM+STLiQ=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=AH/84kA77EldxqpYgZUOTgWE/L6f+l0bWErarIiliOr5C9rkQ/l4NAu9RJUy4djrF
         /8qxmyozJjvcZan2n1MtDOF0w/5F6dW5iDf2slA3LbFK4y7ZDYe97+I54ynPK3tks4
         EU1Ksvzv0GBR+sYTwq3LhgcI2DsCtdDBsJo1LDfRsjopqcs8up1trLemS3kcwYhnNr
         KHaYos6HAw0aR5qhYOqiY1LiKUpLvlXNf/3Y/dZPUI8K0EXBuFG4iZampU/LzfP/Bi
         Hj/aR8J/WDAX+PaN1o7eZ6MUKlLtdxMmwVARuiRIfKdlBMf/dFeR+feVpSMfGm+82I
         N8wdIvCvKNaHw==
From:   Nathan Chancellor <nathan@kernel.org>
Date:   Tue, 12 Sep 2023 12:15:44 -0700
Subject: [PATCH 7/7] bcachefs: Fix -Wcompare-distinct-pointer-types in
 bch2_copygc_get_buckets()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230912-bcachefs-warning-fixes-v1-7-a1cc83a38836@kernel.org>
References: <20230912-bcachefs-warning-fixes-v1-0-a1cc83a38836@kernel.org>
In-Reply-To: <20230912-bcachefs-warning-fixes-v1-0-a1cc83a38836@kernel.org>
To:     kent.overstreet@linux.dev
Cc:     bfoster@redhat.com, linux-bcachefs@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2289; i=nathan@kernel.org;
 h=from:subject:message-id; bh=mr+NsehKtc1BM6Zeb//Yv+u2js+H8NOBbn0lM+STLiQ=;
 b=owGbwMvMwCEmm602sfCA1DTG02pJDKkMOz4s5HJeOSmEcY/TU4mXthwf5hqbWnN/dO6+vUjMa
 Wae1tF3HaUsDGIcDLJiiizVj1WPGxrOOct449QkmDmsTCBDGLg4BWAiqzYw/E+Jeldxm7dK02Kq
 +tId+4pkGN+x+6StDN31tcMjUp3jph4jw+45IsYvDMJmb9qafOn8k36LexPVS/8sm9ZX+P5Q4hr
 zVdwA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building bcachefs for 32-bit ARM, there is a warning when using
max() to compare an expression involving 'size_t' with an 'unsigned
long' literal:

  fs/bcachefs/movinggc.c:159:21: error: comparison of distinct pointer types ('typeof (16UL) *' (aka 'unsigned long *') and 'typeof (buckets_in_flight->nr / 4) *' (aka 'unsigned int *')) [-Werror,-Wcompare-distinct-pointer-types]
    159 |         size_t nr_to_get = max(16UL, buckets_in_flight->nr / 4);
        |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  include/linux/minmax.h:76:19: note: expanded from macro 'max'
     76 | #define max(x, y)       __careful_cmp(x, y, >)
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
warning when comparing these two expressions. Use max_t(size_t, ...) for
this situation, eliminating the warning.

Fixes: dd49018737d4 ("bcachefs: Rhashtable based buckets_in_flight for copygc")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 fs/bcachefs/movinggc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/bcachefs/movinggc.c b/fs/bcachefs/movinggc.c
index 256431a6dc0c..1cb441d90b34 100644
--- a/fs/bcachefs/movinggc.c
+++ b/fs/bcachefs/movinggc.c
@@ -156,7 +156,7 @@ static int bch2_copygc_get_buckets(struct btree_trans *trans,
 	struct bch_fs *c = trans->c;
 	struct btree_iter iter;
 	struct bkey_s_c k;
-	size_t nr_to_get = max(16UL, buckets_in_flight->nr / 4);
+	size_t nr_to_get = max_t(size_t, 16U, buckets_in_flight->nr / 4);
 	size_t saw = 0, in_flight = 0, not_movable = 0, sectors = 0;
 	int ret;
 

-- 
2.42.0

