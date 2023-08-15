Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA3E77CF63
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 17:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238181AbjHOPld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 11:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238171AbjHOPlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 11:41:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8DA10C6;
        Tue, 15 Aug 2023 08:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692114078; x=1723650078;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OSkP7yV/jMpi04y1q72goA7aGm2Y7raBAgrycU/6C2c=;
  b=kpcQJcoE1YWzsHw5x2kPghVb4GebgpeydFCmH2VMWhx1S2szDfThD8OS
   kTgvafuKnv2rYHGcD6MPslFOuLipnN2Tx2YpIm/1M2bxQZezMWP0KnzVi
   v2bMi6yPGIvH1AVQuL7dsvXN1e1EVySKeAntLWoHcm8Nf+nXba021CGpn
   I7XeTLpGa4xhDuQmjUzRKIvrFkEqVFR2tKC5ylhn9MNntZ5eD66nISSzO
   d9Kl3/JZQAaYDEWkxuFzOx0ueXPvXk020YMG4BoLFiMjyFDVNxx+6YxcO
   d3GjpVvzOvbdPhpKu4qSgouwvgcEMEs4ioG9TtfVmqsY5mqoBleYFvdd5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="351896983"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="351896983"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 08:41:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="736950079"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="736950079"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 15 Aug 2023 08:41:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5DE19C53; Tue, 15 Aug 2023 18:41:12 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Philipp Jungkamp <p.jungkamp@gmx.net>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 1/3] types: Complement the aligned types with signed 64-bit one
Date:   Tue, 15 Aug 2023 18:40:25 +0300
Message-Id: <20230815154027.12468-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some user may want to use aligned signed 64-bit type.
Provide it for them.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/types.h      | 3 ++-
 include/uapi/linux/types.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/types.h b/include/linux/types.h
index 253168bb3fe1..78d87c751ff5 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -115,8 +115,9 @@ typedef u64			u_int64_t;
 typedef s64			int64_t;
 #endif
 
-/* this is a special 64bit data type that is 8-byte aligned */
+/* These are the special 64-bit data types that are 8-byte aligned */
 #define aligned_u64		__aligned_u64
+#define aligned_s64		__aligned_s64
 #define aligned_be64		__aligned_be64
 #define aligned_le64		__aligned_le64
 
diff --git a/include/uapi/linux/types.h b/include/uapi/linux/types.h
index 6375a0684052..48b933938877 100644
--- a/include/uapi/linux/types.h
+++ b/include/uapi/linux/types.h
@@ -53,6 +53,7 @@ typedef __u32 __bitwise __wsum;
  * No conversions are necessary between 32-bit user-space and a 64-bit kernel.
  */
 #define __aligned_u64 __u64 __attribute__((aligned(8)))
+#define __aligned_s64 __s64 __attribute__((aligned(8)))
 #define __aligned_be64 __be64 __attribute__((aligned(8)))
 #define __aligned_le64 __le64 __attribute__((aligned(8)))
 
-- 
2.40.0.1.gaa8946217a0b

