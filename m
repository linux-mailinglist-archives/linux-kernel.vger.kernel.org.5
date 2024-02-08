Return-Path: <linux-kernel+bounces-57570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7182484DAD8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FFA71C24380
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A6B6A331;
	Thu,  8 Feb 2024 07:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mPo6Y5O1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39A66997A
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 07:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707378322; cv=none; b=tq/rnMqFBe8iRJJZ8K2f//1h6Lmti7ufyh6YzvYs+gAyqOmpjfAA0KI2ZTdNlLRaeH/qL8k9ZQCMiW6OzU/CLgo5mK/veVLKKX9tZVDP4VlnbUDhuFe69SgrwZ632N8R5ENVdXc20BwEv03lLCTfhG4rFZ2MY7S6YuG6W20j0tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707378322; c=relaxed/simple;
	bh=P15aik6EeWQ68wbdtouiUXL4nbhhcZPj2FNurlsAsHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ry/slDOLNPkZQntCEOoCO+1JDPuZjpjLmiDiOmj0ES/Zl4EHGXHQ7NoeEjBPIQ5eC29rlkDdSh+g2l01gnoVOFNlXzqNcAafEk2J3Bho4nvMq41q7hIIxJ6Z9bvB39iYGqT5iSX7K/xynHrJE4hCearvDER/gFVA9fOtioNwQJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mPo6Y5O1; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707378321; x=1738914321;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P15aik6EeWQ68wbdtouiUXL4nbhhcZPj2FNurlsAsHc=;
  b=mPo6Y5O1+TXbUVjKE0UKHRVDLBmyN+MDoc6tSiT7Qiy4sTV1lZ3sGCTG
   3++lOak95s8WhqZSIqd/G8762VJ8oNEv/1YAhhp4cfmkga5EREw8k0kLp
   63Q0sU9m/yunwSYc3P48+/bKOZQGS9h0LeoTqHQ2/JcO/RloeCivvh4Iw
   nx6Rovj/WOit/OW1mlDSfMASKJJheflExeKwFnjyUS0pDAA1JsEYVeY6d
   S2C4Zq93IBAG+GehKweMyLFtKfC0/aNuu1Z8Sw9fGd57tp/4NFx7QYWg/
   xGrh/1z+qAaW5SrgE+nxHjp47cHYozD8jNqJprQOUOyGA6CYYqhOTkHHl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="12242641"
X-IronPort-AV: E=Sophos;i="6.05,252,1701158400"; 
   d="scan'208";a="12242641"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 23:45:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,252,1701158400"; 
   d="scan'208";a="6195657"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 23:45:17 -0800
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
Subject: [PATCH v3 3/3] drm/i915: Convert REG_GENMASK* to fixed-width GENMASK_*
Date: Wed,  7 Feb 2024 23:45:21 -0800
Message-ID: <20240208074521.577076-4-lucas.demarchi@intel.com>
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

Now that include/linux/bits.h implements fixed-width GENMASK_*, use them
to implement the i915/xe specific macros. Converting each driver to use
the generic macros are left for later, when/if other driver-specific
macros are also generalized.

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/i915/i915_reg_defs.h | 108 +++------------------------
 1 file changed, 11 insertions(+), 97 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_reg_defs.h b/drivers/gpu/drm/i915/i915_reg_defs.h
index a685db1e815d..52f99eb96f86 100644
--- a/drivers/gpu/drm/i915/i915_reg_defs.h
+++ b/drivers/gpu/drm/i915/i915_reg_defs.h
@@ -9,76 +9,19 @@
 #include <linux/bitfield.h>
 #include <linux/bits.h>
 
-/**
- * REG_BIT() - Prepare a u32 bit value
- * @__n: 0-based bit number
- *
- * Local wrapper for BIT() to force u32, with compile time checks.
- *
- * @return: Value with bit @__n set.
- */
-#define REG_BIT(__n)							\
-	((u32)(BIT(__n) +						\
-	       BUILD_BUG_ON_ZERO(__is_constexpr(__n) &&		\
-				 ((__n) < 0 || (__n) > 31))))
-
-/**
- * REG_BIT8() - Prepare a u8 bit value
- * @__n: 0-based bit number
- *
- * Local wrapper for BIT() to force u8, with compile time checks.
- *
- * @return: Value with bit @__n set.
- */
-#define REG_BIT8(__n)                                                   \
-	((u8)(BIT(__n) +                                                \
-	       BUILD_BUG_ON_ZERO(__is_constexpr(__n) &&         \
-				 ((__n) < 0 || (__n) > 7))))
-
-/**
- * REG_GENMASK() - Prepare a continuous u32 bitmask
- * @__high: 0-based high bit
- * @__low: 0-based low bit
- *
- * Local wrapper for GENMASK() to force u32, with compile time checks.
- *
- * @return: Continuous bitmask from @__high to @__low, inclusive.
- */
-#define REG_GENMASK(__high, __low)					\
-	((u32)(GENMASK(__high, __low) +					\
-	       BUILD_BUG_ON_ZERO(__is_constexpr(__high) &&	\
-				 __is_constexpr(__low) &&		\
-				 ((__low) < 0 || (__high) > 31 || (__low) > (__high)))))
-
-/**
- * REG_GENMASK64() - Prepare a continuous u64 bitmask
- * @__high: 0-based high bit
- * @__low: 0-based low bit
- *
- * Local wrapper for GENMASK_ULL() to force u64, with compile time checks.
- *
- * @return: Continuous bitmask from @__high to @__low, inclusive.
+/*
+ * Wrappers over the generic BIT_* and GENMASK_* implementations,
+ * for compatibility reasons with previous implementation
  */
-#define REG_GENMASK64(__high, __low)					\
-	((u64)(GENMASK_ULL(__high, __low) +				\
-	       BUILD_BUG_ON_ZERO(__is_constexpr(__high) &&		\
-				 __is_constexpr(__low) &&		\
-				 ((__low) < 0 || (__high) > 63 || (__low) > (__high)))))
+#define REG_GENMASK(__high, __low)	GENMASK_U32(__high, __low)
+#define REG_GENMASK64(__high, __low)	GENMASK_U64(__high, __low)
+#define REG_GENMASK16(__high, __low)	GENMASK_U16(__high, __low)
+#define REG_GENMASK8(__high, __low)	GENMASK_U8(__high, __low)
 
-/**
- * REG_GENMASK8() - Prepare a continuous u8 bitmask
- * @__high: 0-based high bit
- * @__low: 0-based low bit
- *
- * Local wrapper for GENMASK() to force u8, with compile time checks.
- *
- * @return: Continuous bitmask from @__high to @__low, inclusive.
- */
-#define REG_GENMASK8(__high, __low)                                     \
-	((u8)(GENMASK(__high, __low) +                                  \
-	       BUILD_BUG_ON_ZERO(__is_constexpr(__high) &&      \
-				 __is_constexpr(__low) &&               \
-				 ((__low) < 0 || (__high) > 7 || (__low) > (__high)))))
+#define REG_BIT(__n)			BIT_U32(__n)
+#define REG_BIT64(__n)			BIT_U64(__n)
+#define REG_BIT16(__n)			BIT_U16(__n)
+#define REG_BIT8(__n)			BIT_U8(__n)
 
 /*
  * Local integer constant expression version of is_power_of_2().
@@ -143,35 +86,6 @@
  */
 #define REG_FIELD_GET64(__mask, __val)	((u64)FIELD_GET(__mask, __val))
 
-/**
- * REG_BIT16() - Prepare a u16 bit value
- * @__n: 0-based bit number
- *
- * Local wrapper for BIT() to force u16, with compile time
- * checks.
- *
- * @return: Value with bit @__n set.
- */
-#define REG_BIT16(__n)                                                   \
-	((u16)(BIT(__n) +                                                \
-	       BUILD_BUG_ON_ZERO(__is_constexpr(__n) &&         \
-				 ((__n) < 0 || (__n) > 15))))
-
-/**
- * REG_GENMASK16() - Prepare a continuous u8 bitmask
- * @__high: 0-based high bit
- * @__low: 0-based low bit
- *
- * Local wrapper for GENMASK() to force u16, with compile time
- * checks.
- *
- * @return: Continuous bitmask from @__high to @__low, inclusive.
- */
-#define REG_GENMASK16(__high, __low)                                     \
-	((u16)(GENMASK(__high, __low) +                                  \
-	       BUILD_BUG_ON_ZERO(__is_constexpr(__high) &&      \
-				 __is_constexpr(__low) &&               \
-				 ((__low) < 0 || (__high) > 15 || (__low) > (__high)))))
 
 /**
  * REG_FIELD_PREP16() - Prepare a u16 bitfield value
-- 
2.43.0


