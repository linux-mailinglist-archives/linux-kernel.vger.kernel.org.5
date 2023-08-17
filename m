Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14F477FC63
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 18:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245243AbjHQQzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 12:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353771AbjHQQzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 12:55:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7AD2D7E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 09:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692291301; x=1723827301;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lM+eCG4oKhGdnhkZCnYZscEzceLlhb1YwBucmrl2U6E=;
  b=B3tJ2SQqECpjQ3SWzZe9vBTGKemByDjQiG+NfXT44sht6pjp5LBf86KE
   Aeb2T9GzXjvkpQH3Jm9wzeYrDMyXOsovXIB0gzLXj25EJ23B794T/pPYM
   iEbAZDqHPZaXkgccwB2zCwMM0OLhs1k7GEvWUNuLlMxl2gMDVSB32NFx6
   jcdp54NfmGy0rxcVH4Nx7eSj1Mh2MDKTCZq48l6P+tCd+euzVrCopjcp8
   TQ5iRTpHLKg1Itw3I7EMpRXVt00CrVBJWuAe55QTkWQ1BuQI/7kmgUbOh
   ek0QRtuX1u4ignWEk9hjuKc1pA+0rKDP7Yn7XxfR2KKynwdm6riRMu2JJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="371772543"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="371772543"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 09:54:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="858294510"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="858294510"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 17 Aug 2023 09:54:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 53CBBE2E; Thu, 17 Aug 2023 19:54:56 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v1 2/2] bitmap: Optimize memset() calls
Date:   Thu, 17 Aug 2023 19:54:53 +0300
Message-Id: <20230817165453.713353-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230817165453.713353-1-andriy.shevchenko@linux.intel.com>
References: <20230817165453.713353-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intead of byte memset() calls use 32- or 64-bit version depending
on the compile-time BITS_PER_LONG value.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/bitmap.h | 16 ++++++++++++----
 lib/bitmap.c           |  4 ++--
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 2d5042d1b501..6eec4d4fd623 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -234,22 +234,30 @@ extern int bitmap_print_list_to_buf(char *buf, const unsigned long *maskp,
 
 static inline void bitmap_zero(unsigned long *dst, unsigned int nbits)
 {
-	unsigned int len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
+	unsigned int len = BITS_TO_LONGS(nbits);
 
 	if (small_const_nbits(nbits))
 		*dst = 0;
 	else
-		memset(dst, 0, len);
+#if BITS_PER_LONG == 64
+		memset64((uint64_t *)dst, 0, len);
+#else
+		memset32((uint32_t *)dst, 0, len);
+#endif
 }
 
 static inline void bitmap_fill(unsigned long *dst, unsigned int nbits)
 {
-	unsigned int len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
+	unsigned int len = BITS_TO_LONGS(nbits);
 
 	if (small_const_nbits(nbits))
 		*dst = ~0UL;
 	else
-		memset(dst, 0xff, len);
+#if BITS_PER_LONG == 64
+		memset64((uint64_t *)dst, GENMASK(63, 0), len);
+#else
+		memset32((uint32_t *)dst, GENMASK(31, 0), len);
+#endif
 }
 
 static inline void bitmap_copy(unsigned long *dst, const unsigned long *src,
diff --git a/lib/bitmap.c b/lib/bitmap.c
index 935e0f96e785..df0fb37a5732 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -128,7 +128,7 @@ void __bitmap_shift_right(unsigned long *dst, const unsigned long *src,
 		dst[k] = lower | upper;
 	}
 	if (off)
-		memset(&dst[lim - off], 0, off*sizeof(unsigned long));
+		bitmap_zero(&dst[lim - off], off);
 }
 EXPORT_SYMBOL(__bitmap_shift_right);
 
@@ -166,7 +166,7 @@ void __bitmap_shift_left(unsigned long *dst, const unsigned long *src,
 		dst[k + off] = lower | upper;
 	}
 	if (off)
-		memset(dst, 0, off*sizeof(unsigned long));
+		bitmap_zero(dst, off);
 }
 EXPORT_SYMBOL(__bitmap_shift_left);
 
-- 
2.40.0.1.gaa8946217a0b

