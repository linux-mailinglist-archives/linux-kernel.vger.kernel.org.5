Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7AFE7EA230
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 18:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbjKMRit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 12:38:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbjKMRiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 12:38:23 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31501211D;
        Mon, 13 Nov 2023 09:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699897083; x=1731433083;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZeCLSCpKtslPzs24xkgYnsE5Qt2ndE4iPRvYGoOuhBI=;
  b=JF7lsWMJGnB7YgCfMe8+7vewabLdMH76Ei5QajXVKcNcvO21OoZG2a3R
   EPzALrnXej2SVrURFuVhIc7E1CzAz8fKUCYeLvPfnjrz16sQWdKc/75ZY
   kfYPb9Rxkr9M+HDwv5ELxOfdIDQ4EFrGN1gsEBKdhLwLbdHKc6vp4iiTj
   aGV6HkEPtkrR1FZGM9FV8R1XrT45VZp0xvN7HVlgGbFI1NdRlE+kUALCX
   W/CvdnGy2OIn4OK2bhyXqToxgpoI+k3jUJz6y870QufLqz++sZ2tmwWaz
   8h+ZT7MPjDeY2OFOeB991ZPSwNxYFXw+ZpA/O4gC9Szry6nwktgP/bChi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="370671677"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="370671677"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 09:37:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="1095812752"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="1095812752"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmsmga005.fm.intel.com with ESMTP; 13 Nov 2023 09:37:55 -0800
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexander Potapenko <glider@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        netdev@vger.kernel.org, linux-btrfs@vger.kernel.org,
        dm-devel@redhat.com, ntfs3@lists.linux.dev,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/11] lib/bitmap: add compile-time test for __assign_bit() optimization
Date:   Mon, 13 Nov 2023 18:37:17 +0100
Message-ID: <20231113173717.927056-12-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231113173717.927056-1-aleksander.lobakin@intel.com>
References: <20231113173717.927056-1-aleksander.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit dc34d5036692 ("lib: test_bitmap: add compile-time
optimization/evaluations assertions") initially missed __assign_bit(),
which led to that quite a time passed before I realized it doesn't get
optimized at compilation time. Now that it does, add test for that just
to make sure nothing will break one day.
To make things more interesting, use bitmap_complement() and
bitmap_full(), thus checking their compile-time evaluation as well. And
remove the misleading comment mentioning the workaround removed recently
in favor of adding the whole file to GCov exceptions.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 lib/test_bitmap.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index a6e92cf5266a..4ee1f8ceb51d 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -1204,14 +1204,7 @@ static void __init test_bitmap_const_eval(void)
 	 * in runtime.
 	 */
 
-	/*
-	 * Equals to `unsigned long bitmap[1] = { GENMASK(6, 5), }`.
-	 * Clang on s390 optimizes bitops at compile-time as intended, but at
-	 * the same time stops treating @bitmap and @bitopvar as compile-time
-	 * constants after regular test_bit() is executed, thus triggering the
-	 * build bugs below. So, call const_test_bit() there directly until
-	 * the compiler is fixed.
-	 */
+	/* Equals to `unsigned long bitmap[1] = { GENMASK(6, 5), }` */
 	bitmap_clear(bitmap, 0, BITS_PER_LONG);
 	if (!test_bit(7, bitmap))
 		bitmap_set(bitmap, 5, 2);
@@ -1243,6 +1236,15 @@ static void __init test_bitmap_const_eval(void)
 	/* ~BIT(25) */
 	BUILD_BUG_ON(!__builtin_constant_p(~var));
 	BUILD_BUG_ON(~var != ~BIT(25));
+
+	/* ~BIT(25) | BIT(25) == ~0UL */
+	bitmap_complement(&var, &var, BITS_PER_LONG);
+	__assign_bit(25, &var, true);
+
+	/* !(~(~0UL)) == 1 */
+	res = bitmap_full(&var, BITS_PER_LONG);
+	BUILD_BUG_ON(!__builtin_constant_p(res));
+	BUILD_BUG_ON(!res);
 }
 
 /*
-- 
2.41.0

