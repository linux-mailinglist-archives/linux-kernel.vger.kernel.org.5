Return-Path: <linux-kernel+bounces-57568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F17D584DAD6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADC7D287AE7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F866A00A;
	Thu,  8 Feb 2024 07:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DOXG+Ul7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E4569970
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 07:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707378320; cv=none; b=vESXGf0OPm0Fg7g8STevorSKXntp2uacDRpnugn3FjzS0XiaHrIh2sTuyG7FlcbwUBjdkY7m8rbbT9ApjvyHNQiDBVQtqxJpbP9eTdmgHjc7STUv+o8DcnQPjE2IAGaxHHYhTKOc/fi/zZ/jc+SPFue1bA6OT3NS8N1u4ybYv34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707378320; c=relaxed/simple;
	bh=l4UY2L4RJrFs6qSEBykdb5P7iOGl7l18XZf5QdzVkjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BS78gZGioPLEbryPqegwBTZagN0xsO/DvG3hxtEuF7IEVykgjFBinxUzEBQ3x1XvYLXTDLbTO/CwNk65IRYbM0MkF7lcRhkzksjH3CoWMhZTGRycA15DSLm1Zyh6FMj5M5kuumuOeHbp3XsqF4DgqnCKKEicoPn+zMffHqCDeYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DOXG+Ul7; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707378318; x=1738914318;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l4UY2L4RJrFs6qSEBykdb5P7iOGl7l18XZf5QdzVkjg=;
  b=DOXG+Ul7caOJfG1bn08wNRiVNZ0BmKy8siQayh8vL7aeed4QuFWIT06Z
   Vkd+h083Tn1i+leDuQ0T42oWZZgnEUK1qeYiEUQO+VuoUwCE2hcNdxCju
   5SmtjfWryCOryBlAL2rq2S4n1bJT1bVf2CjanGynH3kfPNMDGHAY2yTgc
   o3DvIG+VxrvNtfKRpNY0+I1rnzMqnRBbhgP25OKxwskzdXnd4Ux/Ly9qp
   AgaxtBSgkyxSWEopE1TTAQbx1r+1lYOoueFgcwnsrkGajKocqJmy14eNu
   FHgtwZnkxmPS33MigpZBQRlVrESontfdt6+LvFE7lrezrqXK6Yr/EGA/D
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="12242635"
X-IronPort-AV: E=Sophos;i="6.05,252,1701158400"; 
   d="scan'208";a="12242635"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 23:45:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,252,1701158400"; 
   d="scan'208";a="6195648"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 23:45:16 -0800
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	intel-xe@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH v3 1/3] bits: introduce fixed-type genmasks
Date: Wed,  7 Feb 2024 23:45:19 -0800
Message-ID: <20240208074521.577076-2-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240208074521.577076-1-lucas.demarchi@intel.com>
References: <20240208074521.577076-1-lucas.demarchi@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yury Norov <yury.norov@gmail.com>

Generalize __GENMASK() to support different types, and implement
fixed-types versions of GENMASK() based on it. The fixed-type version
allows more strict checks to the min/max values accepted, which is
useful for defining registers like implemented by i915 and xe drivers
with their REG_GENMASK*() macros.

The strict checks rely on shift-count-overflow compiler check to
fail the build if a number outside of the range allowed is passed.
Example:

	#define FOO_MASK GENMASK_U32(33, 4)

will generate a warning like:

	../include/linux/bits.h:41:31: error: left shift count >= width of type [-Werror=shift-count-overflow]
	   41 |          (((t)~0ULL - ((t)(1) << (l)) + 1) & \
	      |                               ^~

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
---
 include/linux/bitops.h |  1 -
 include/linux/bits.h   | 32 ++++++++++++++++++++++----------
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 2ba557e067fe..1db50c69cfdb 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -15,7 +15,6 @@
 #  define aligned_byte_mask(n) (~0xffUL << (BITS_PER_LONG - 8 - 8*(n)))
 #endif
 
-#define BITS_PER_TYPE(type)	(sizeof(type) * BITS_PER_BYTE)
 #define BITS_TO_LONGS(nr)	__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(long))
 #define BITS_TO_U64(nr)		__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(u64))
 #define BITS_TO_U32(nr)		__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(u32))
diff --git a/include/linux/bits.h b/include/linux/bits.h
index 7c0cf5031abe..bd56f32de44e 100644
--- a/include/linux/bits.h
+++ b/include/linux/bits.h
@@ -6,6 +6,8 @@
 #include <vdso/bits.h>
 #include <asm/bitsperlong.h>
 
+#define BITS_PER_TYPE(type)	(sizeof(type) * BITS_PER_BYTE)
+
 #define BIT_MASK(nr)		(UL(1) << ((nr) % BITS_PER_LONG))
 #define BIT_WORD(nr)		((nr) / BITS_PER_LONG)
 #define BIT_ULL_MASK(nr)	(ULL(1) << ((nr) % BITS_PER_LONG_LONG))
@@ -30,16 +32,26 @@
 #define GENMASK_INPUT_CHECK(h, l) 0
 #endif
 
-#define __GENMASK(h, l) \
-	(((~UL(0)) - (UL(1) << (l)) + 1) & \
-	 (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
-#define GENMASK(h, l) \
-	(GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
+/*
+ * Generate a mask for the specified type @t. Additional checks are made to
+ * guarantee the value returned fits in that type, relying on
+ * shift-count-overflow compiler check to detect incompatible arguments.
+ * For example, all these create build errors or warnings:
+ *
+ * - GENMASK(15, 20): wrong argument order
+ * - GENMASK(72, 15): doesn't fit unsigned long
+ * - GENMASK_U32(33, 15): doesn't fit in a u32
+ */
+#define __GENMASK(t, h, l) \
+	(GENMASK_INPUT_CHECK(h, l) + \
+	 (((t)~0ULL - ((t)(1) << (l)) + 1) & \
+	 ((t)~0ULL >> (BITS_PER_TYPE(t) - 1 - (h)))))
 
-#define __GENMASK_ULL(h, l) \
-	(((~ULL(0)) - (ULL(1) << (l)) + 1) & \
-	 (~ULL(0) >> (BITS_PER_LONG_LONG - 1 - (h))))
-#define GENMASK_ULL(h, l) \
-	(GENMASK_INPUT_CHECK(h, l) + __GENMASK_ULL(h, l))
+#define GENMASK(h, l)		__GENMASK(unsigned long,  h, l)
+#define GENMASK_ULL(h, l)	__GENMASK(unsigned long long, h, l)
+#define GENMASK_U8(h, l)	__GENMASK(u8,  h, l)
+#define GENMASK_U16(h, l)	__GENMASK(u16, h, l)
+#define GENMASK_U32(h, l)	__GENMASK(u32, h, l)
+#define GENMASK_U64(h, l)	__GENMASK(u64, h, l)
 
 #endif	/* __LINUX_BITS_H */
-- 
2.43.0


