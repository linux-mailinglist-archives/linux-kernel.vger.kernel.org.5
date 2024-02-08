Return-Path: <linux-kernel+bounces-57569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFD984DAD7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 834C61F227BF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1066A00B;
	Thu,  8 Feb 2024 07:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JIjCUp/O"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A2A67E8D
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 07:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707378320; cv=none; b=tj95Pv1txOxzgktu4oDCemBbVPyvgqmCWUU/N9sEP+RGVCea8x0FZ0DYF+tZ1t9YROu9Ig2D2+e+pFWJjD52TM+DWNrW5ZTkfHL7GVvmJjPHGy2DsdNIZxxL6ewIqUKJP1iigsNdyZNS7+UduKzojvD2FhI1wO4yJCq3nObYagw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707378320; c=relaxed/simple;
	bh=9VUCCkK7ZSfSAVEAuYXB94bymXAqg5yRUhO4NtdM7cM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nim1Laqywd15Lyiqv70loghN6WVP7K5DafZDRU7Cu9UCXIvAFm9BuGDKuRTdhC33hDbKK3mN0ttVLiEgd23idFx1J/wqVag5turKBDaQctnnZLVbI/rBY2Id50l50//aLnr66fqbzB06AbWX0TWopGzyaV8AMBNu44bbbdsfdk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JIjCUp/O; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707378319; x=1738914319;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9VUCCkK7ZSfSAVEAuYXB94bymXAqg5yRUhO4NtdM7cM=;
  b=JIjCUp/OvxCdTIdwz/KENcHvCFqOljwYMZskmN0YGoxrUfk+xQhFtMB3
   4T/MZdYyMGae0T0uNJkuPTR59s1sEYu2NpCPpZ1vC/GJY+NxNzZnC9+sE
   I7QWPwH6Ojt2A0AjhM0ZWaHw8GJ5j5Cn1UFN9Wl9Xa8sPcirxz6HzGECz
   qjgUYyTntUizXJ9KsTB+xvzZ1iZ4ceo+TUADqCd7mSVHVu9J+VY544zIW
   cHzk12shR9JqOJ/pdk5sGuqX+0isKGMlEAVvSxhLcALGr9vdHLwlgxqMB
   qBm9gozkRr5sIDNt8bFRtr4IPtw9c9/KzWg0e5ZRc7vx4/pWvEph1dI09
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="12242638"
X-IronPort-AV: E=Sophos;i="6.05,252,1701158400"; 
   d="scan'208";a="12242638"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 23:45:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,252,1701158400"; 
   d="scan'208";a="6195652"
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
Subject: [PATCH v3 2/3] bits: Introduce fixed-type BIT
Date: Wed,  7 Feb 2024 23:45:20 -0800
Message-ID: <20240208074521.577076-3-lucas.demarchi@intel.com>
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

Implement fixed-type BIT() to help drivers add stricter checks, like was
done for GENMASK.

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
---
 include/linux/bits.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/bits.h b/include/linux/bits.h
index bd56f32de44e..811846ce110e 100644
--- a/include/linux/bits.h
+++ b/include/linux/bits.h
@@ -24,12 +24,16 @@
 #define GENMASK_INPUT_CHECK(h, l) \
 	(BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
 		__is_constexpr((l) > (h)), (l) > (h), 0)))
+#define BIT_INPUT_CHECK(type, b) \
+	((BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
+		__is_constexpr(b), (b) >= BITS_PER_TYPE(type), 0))))
 #else
 /*
  * BUILD_BUG_ON_ZERO is not available in h files included from asm files,
  * disable the input check if that is the case.
  */
 #define GENMASK_INPUT_CHECK(h, l) 0
+#define BIT_INPUT_CHECK(type, b) 0
 #endif
 
 /*
@@ -54,4 +58,17 @@
 #define GENMASK_U32(h, l)	__GENMASK(u32, h, l)
 #define GENMASK_U64(h, l)	__GENMASK(u64, h, l)
 
+/*
+ * Fixed-type variants of BIT(), with additional checks like __GENMASK().  The
+ * following examples generate compiler warnings due to shift-count-overflow:
+ *
+ * - BIT_U8(8)
+ * - BIT_U32(-1)
+ * - BIT_U32(40)
+ */
+#define BIT_U8(b)		((u8)(BIT_INPUT_CHECK(u8, b) + BIT(b)))
+#define BIT_U16(b)		((u16)(BIT_INPUT_CHECK(u16, b) + BIT(b)))
+#define BIT_U32(b)		((u32)(BIT_INPUT_CHECK(u32, b) + BIT(b)))
+#define BIT_U64(b)		((u64)(BIT_INPUT_CHECK(u64, b) + BIT(b)))
+
 #endif	/* __LINUX_BITS_H */
-- 
2.43.0


