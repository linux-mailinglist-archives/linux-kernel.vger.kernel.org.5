Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05AC77FBEB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 18:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353618AbjHQQV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 12:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353607AbjHQQVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 12:21:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC25273F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 09:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692289291; x=1723825291;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=J1J63DHqTzn22L6A60Qvjsq+8XgPE038ySHo3KQZ2pE=;
  b=j/IX5TxCN5U4awWENXy2kstIuYpMEJ6XLaNKYJre5eOnbR7xTi0n+0PI
   45wjb44BSjbx8e4OjfZRWez+SCrmtNZtauATN97LkzIMYHzaLlwvkF88w
   h/bs59pc0lsamf/vaJLkc1MaBHHoNhFHrU/FXUY17TJ52CAC3WemVocR+
   P8+u79BIfuPS98ttgcLM1KslnTe/stB7FLJvqRkooV257V5CGkDNgjLjm
   5zLVjh05TpwUijuvUZKATc/Fsp1DlrnfPY4GEpaQSv21+byuRr4V+OqE9
   xJQIiWAOobsIFHGpyh56cRR0wpTP/Zt0ZmVqWeZ00P69NNQ9gyHPk2L9f
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="371761505"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="371761505"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 09:20:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="858284458"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="858284458"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 17 Aug 2023 09:20:58 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E74A9DE4; Thu, 17 Aug 2023 19:20:56 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v1 1/1] bitmap: Remove dead code, i.e. bitmap_copy_le()
Date:   Thu, 17 Aug 2023 19:20:54 +0300
Message-Id: <20230817162054.567617-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
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

Besides the fact it's not used anywhere it should be implemented
differently, i.e. via helpers from linux/byteorder/generic.h.
Yet the helpers themselves need to be introduced first.

Also note, the function lacks of the test cases, they must be provided.

Hence, drop the current dead code for good.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/bitmap.h |  5 -----
 lib/bitmap.c           | 23 -----------------------
 2 files changed, 28 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 03644237e1ef..1516ff979315 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -220,11 +220,6 @@ int bitmap_find_free_region(unsigned long *bitmap, unsigned int bits, int order)
 void bitmap_release_region(unsigned long *bitmap, unsigned int pos, int order);
 int bitmap_allocate_region(unsigned long *bitmap, unsigned int pos, int order);
 
-#ifdef __BIG_ENDIAN
-void bitmap_copy_le(unsigned long *dst, const unsigned long *src, unsigned int nbits);
-#else
-#define bitmap_copy_le bitmap_copy
-#endif
 int bitmap_print_to_pagebuf(bool list, char *buf,
 				   const unsigned long *maskp, int nmaskbits);
 
diff --git a/lib/bitmap.c b/lib/bitmap.c
index 24284caadbcc..935e0f96e785 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -1360,29 +1360,6 @@ int bitmap_allocate_region(unsigned long *bitmap, unsigned int pos, int order)
 }
 EXPORT_SYMBOL(bitmap_allocate_region);
 
-/**
- * bitmap_copy_le - copy a bitmap, putting the bits into little-endian order.
- * @dst:   destination buffer
- * @src:   bitmap to copy
- * @nbits: number of bits in the bitmap
- *
- * Require nbits % BITS_PER_LONG == 0.
- */
-#ifdef __BIG_ENDIAN
-void bitmap_copy_le(unsigned long *dst, const unsigned long *src, unsigned int nbits)
-{
-	unsigned int i;
-
-	for (i = 0; i < nbits/BITS_PER_LONG; i++) {
-		if (BITS_PER_LONG == 64)
-			dst[i] = cpu_to_le64(src[i]);
-		else
-			dst[i] = cpu_to_le32(src[i]);
-	}
-}
-EXPORT_SYMBOL(bitmap_copy_le);
-#endif
-
 unsigned long *bitmap_alloc(unsigned int nbits, gfp_t flags)
 {
 	return kmalloc_array(BITS_TO_LONGS(nbits), sizeof(unsigned long),
-- 
2.40.0.1.gaa8946217a0b

