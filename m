Return-Path: <linux-kernel+bounces-36445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E3D83A0DF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 06:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76F021C27222
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 05:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58054E56D;
	Wed, 24 Jan 2024 05:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EjhNUJ/x"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B473C2D9
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 05:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706072548; cv=none; b=bVMymIzlT6rsWYf+nb7ItJczfXcRsUOrqlGfkwu7nt6GhAcG40AyH+AGewsIX6slEzpvghZyB2CwLS+w6XKs0wS/+Gdsi7UG7eZwAwM7Eq5u1oKCXnhAgAHyCMfTltnHXuiT0gjgBmXZGoFyA85V5zSLq1MuMa5BJxvBDMQs4F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706072548; c=relaxed/simple;
	bh=ThgMTkix4es6j5rky2OKrHCglG8hdtZ/YRFkq6PjGxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PIRelFfSJoQLYZQJ7IJfrPKQKLRVqDRXuEYzX9Fl3F/tICFocMMmi4qC9lrRWY7Dq6rZLX2xEpn1fY521pkwSk8Mi/GfdnjJNpj6rBnMr4w9DJgR1CeyeU1yOrxlIRHzK8pbMyXSmbOaZJSw4gUCTr2jEQv1/k/JgZD4ogvruYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EjhNUJ/x; arc=none smtp.client-ip=192.55.52.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706072547; x=1737608547;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ThgMTkix4es6j5rky2OKrHCglG8hdtZ/YRFkq6PjGxQ=;
  b=EjhNUJ/xnItscaGjesrNp7mLtE9p/yFQbPkII000R/xSsKddaoDQOFP0
   PGdV4oOOfk5XQkFe9wCgfTl/h7LHUWoSqCU6Jw1iMfEJrf3RxF6smq8KL
   vLXgnL3bhlhnN7KR2vohYxAMHnjOu55L14ZUYAF1kaEG04LEVypH8Wrqw
   LYiIEdUeftYvHlWErm8E/dndQn2bM+BZ3hdUln1yD3XGbeu3P1fhJABhx
   Va+ZyNijat5G19l7EFIJ0qSsNKTNfjT4y/59ZZPzecElG1sPACBGLE2uM
   ZQs2rXbmE/ucBolAZEcW5HFI5ilYg5iDnqUXBlaZ6wrCAh2rq1Si/1KJC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="401399356"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="401399356"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 21:02:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="909551509"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="909551509"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 21:02:23 -0800
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	intel-xe@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 2/3] bits: Introduce fixed-type BIT
Date: Tue, 23 Jan 2024 21:02:04 -0800
Message-ID: <20240124050205.3646390-3-lucas.demarchi@intel.com>
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

Implement fixed-type BIT() to help drivers add stricter checks, like was
done for GENMASK.

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 include/linux/bits.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/bits.h b/include/linux/bits.h
index cb94128171b2..5754a1251078 100644
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
 
 #define __GENMASK(t, h, l) \
@@ -44,4 +48,9 @@
 #define GENMASK_U32(h, l)	__GENMASK(u32, h, l)
 #define GENMASK_U64(h, l)	__GENMASK(u64, h, l)
 
+#define BIT_U8(b)		((u8)(BIT_INPUT_CHECK(u8, b) + BIT(b)))
+#define BIT_U16(b)		((u16)(BIT_INPUT_CHECK(u16, b) + BIT(b)))
+#define BIT_U32(b)		((u32)(BIT_INPUT_CHECK(u32, b) + BIT(b)))
+#define BIT_U64(b)		((u64)(BIT_INPUT_CHECK(u64, b) + BIT(b)))
+
 #endif	/* __LINUX_BITS_H */
-- 
2.43.0


