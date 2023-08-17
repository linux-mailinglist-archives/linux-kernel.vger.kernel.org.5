Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683B577FC62
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 18:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353227AbjHQQzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 12:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353769AbjHQQzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 12:55:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500882D77
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 09:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692291301; x=1723827301;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xvArrxaGRN2ebRffrgKTECVmDHXVftRrB25CaScT3Zo=;
  b=P3BLo8hFWTqGNOIF2SV5XekDxpQKQ7Vnvh+wiJ4y+sLmamuzSlIrRrpq
   N2QHseuL1kDz9yA6pnNLd1UFq8PSlufIoT7wDJ0qJ356o0adYVnqwQw7V
   zrZgIXo/lRJ/l6+CB8lr/aiG5W9J9YNAogUENI/LDzfYvWqv6kxxtEMOi
   tUbZUGZlj1D4h5GerqYxsQ+qe6ROze+RMg/MYAv4g0IPPg8veHRtcOFHZ
   qhVAAo+IgTyhzM3eRpSwDKId887frBvjsym+r/Oo17NKK37hp57X/xa8k
   oLELcH3hCP78EOqwWgzA2Buqql6t9cTpd5qBZwMYM3DYIDmYHA/y7hLqF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="375651650"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="375651650"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 09:55:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="737788825"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="737788825"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 17 Aug 2023 09:54:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 497C4D87; Thu, 17 Aug 2023 19:54:56 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v1 1/2] bitmap: Use constants and macros from bits.h
Date:   Thu, 17 Aug 2023 19:54:52 +0300
Message-Id: <20230817165453.713353-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230817165453.713353-1-andriy.shevchenko@linux.intel.com>
References: <20230817165453.713353-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use BITS_PER_LONG and BITS_PER_BYTE for BITMAP_MEM_ALIGNMENT.
Calculate bytes from bits for memcmp() and memset() with BITS_TO_BYTES().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/bitmap.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 1516ff979315..2d5042d1b501 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -354,9 +354,9 @@ static inline void bitmap_complement(unsigned long *dst, const unsigned long *sr
 }
 
 #ifdef __LITTLE_ENDIAN
-#define BITMAP_MEM_ALIGNMENT 8
+#define BITMAP_MEM_ALIGNMENT	BITS_PER_BYTE
 #else
-#define BITMAP_MEM_ALIGNMENT (8 * sizeof(unsigned long))
+#define BITMAP_MEM_ALIGNMENT	BITS_PER_LONG
 #endif
 #define BITMAP_MEM_MASK (BITMAP_MEM_ALIGNMENT - 1)
 
@@ -367,7 +367,7 @@ static inline bool bitmap_equal(const unsigned long *src1,
 		return !((*src1 ^ *src2) & BITMAP_LAST_WORD_MASK(nbits));
 	if (__builtin_constant_p(nbits & BITMAP_MEM_MASK) &&
 	    IS_ALIGNED(nbits, BITMAP_MEM_ALIGNMENT))
-		return !memcmp(src1, src2, nbits / 8);
+		return !memcmp(src1, src2, BITS_TO_BYTES(nbits));
 	return __bitmap_equal(src1, src2, nbits);
 }
 
@@ -454,7 +454,7 @@ static __always_inline void bitmap_set(unsigned long *map, unsigned int start,
 		 IS_ALIGNED(start, BITMAP_MEM_ALIGNMENT) &&
 		 __builtin_constant_p(nbits & BITMAP_MEM_MASK) &&
 		 IS_ALIGNED(nbits, BITMAP_MEM_ALIGNMENT))
-		memset((char *)map + start / 8, 0xff, nbits / 8);
+		memset((char *)map + BITS_TO_BYTES(start), 0xff, BITS_TO_BYTES(nbits));
 	else
 		__bitmap_set(map, start, nbits);
 }
@@ -470,7 +470,7 @@ static __always_inline void bitmap_clear(unsigned long *map, unsigned int start,
 		 IS_ALIGNED(start, BITMAP_MEM_ALIGNMENT) &&
 		 __builtin_constant_p(nbits & BITMAP_MEM_MASK) &&
 		 IS_ALIGNED(nbits, BITMAP_MEM_ALIGNMENT))
-		memset((char *)map + start / 8, 0, nbits / 8);
+		memset((char *)map + BITS_TO_BYTES(start), 0x00, BITS_TO_BYTES(nbits));
 	else
 		__bitmap_clear(map, start, nbits);
 }
-- 
2.40.0.1.gaa8946217a0b

