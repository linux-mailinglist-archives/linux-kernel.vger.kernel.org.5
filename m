Return-Path: <linux-kernel+bounces-36446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAA883A0E0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 06:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE5A8B2700C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 05:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BAEF51C;
	Wed, 24 Jan 2024 05:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MrQnhGrA"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F002C8F1
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 05:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706072549; cv=none; b=Y3PY0QWGs6xBRpx8wRdvfTDCoswkgJFnnYJoDo7NNy2z8plvYQzEIv6yWh75gr4b0Yrm38L27l1S4/t953kGMiyQtXInwUd3C81b/ZPiZaC/JLPN5QC6W2KZLZZgRjAQr9fk/LyK41frczBhhsT3HbEzVpqquG8uYX7IRsbAhkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706072549; c=relaxed/simple;
	bh=fGpX5d8msWVViBqm7sRAsYLfy5pDgJccFA8lspAl428=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uiocoVPPkilVTWn0nUry9KhbceSO61/LbkT4KG4oIcLgKtTYgncSVnaBNUwKWSglQCp1bgy2LksMYxXnucOqOfF7kP5pfYKPbKzTVyeKWHvRypWnJsyEgdRu7Zp2MJmlpNyHVBp0eAOxoWoIxPNQ4PYsmTRyhj+RUUsgulEghEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MrQnhGrA; arc=none smtp.client-ip=192.55.52.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706072547; x=1737608547;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fGpX5d8msWVViBqm7sRAsYLfy5pDgJccFA8lspAl428=;
  b=MrQnhGrA6wZIvmbGcsytF5q2nf2KbMhUGpwXbdolK5AlaNHuUqE9Ee6w
   91z8AF/a79MuVhQH2x5sA+RzXanK7a6/PF7HjZrD4PmXNtbk5GovONj1S
   ZDJGLNrKDsaBOj11dkJgL+2JYrdoy5kGM3t0gaF+LUfpIpSZhUkEnKNdL
   faSa71kUMBaCztDcTuHHH0BbQ2KyX1mlcUP4Oitl7vSEzEx5VshMfegxE
   jhyYDSBdMWovfNH/clNry/q72YZuHmblNk6LpsJsStdX095CLRdF6gMnU
   vmVI3Dd30kOgtoqfIiDGdZAa4q+S9rIBwTqVbPwV75zpu05UP7jHfZ5Xy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="401399359"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="401399359"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 21:02:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="909551505"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="909551505"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 21:02:23 -0800
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	intel-xe@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] bits: introduce fixed-type genmasks
Date: Tue, 23 Jan 2024 21:02:03 -0800
Message-ID: <20240124050205.3646390-2-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124050205.3646390-1-lucas.demarchi@intel.com>
References: <20240124050205.3646390-1-lucas.demarchi@intel.com>
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

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/bitops.h |  1 -
 include/linux/bits.h   | 22 ++++++++++++----------
 2 files changed, 12 insertions(+), 11 deletions(-)

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
index 7c0cf5031abe..cb94128171b2 100644
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
@@ -30,16 +32,16 @@
 #define GENMASK_INPUT_CHECK(h, l) 0
 #endif
 
-#define __GENMASK(h, l) \
-	(((~UL(0)) - (UL(1) << (l)) + 1) & \
-	 (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
-#define GENMASK(h, l) \
-	(GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
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


