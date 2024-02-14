Return-Path: <linux-kernel+bounces-66006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F15C855526
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF022283DAA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 21:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8C913F008;
	Wed, 14 Feb 2024 21:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ap5mWWwr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF2E18E0C
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 21:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707947251; cv=none; b=ncHeaUW+ScDHvykKkD40mvgv8rxx11LdGyeZxJ+s05Eg6wfd0F3jPUGoUGYBYFF93CYRHUfL/IyMnjHu/hmnOvkA8wEBBQYQboxVCmVm/MqMM3zdkMOgr1A1kzGlv3u9sMeSAVqiIgpOz4c+ESxTiRwfhXUJSxNoti5bNFqx1y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707947251; c=relaxed/simple;
	bh=vFBM2F2A9I1qO4nMCigy3x7IwAGUGa7Swx0qaWY1OkE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Tu/vttvyafHuQ4hbiv5n2lrLcGaHa8MYYbuWJa9v0+kntOfECSyM18JRcJLIpBlbpK4C6f0jzKj2Uyh7QBe8bCDh0JIYdq3Do8zK2W0UaSStK/xyquEWwx3RpyCuVlXiE7a2SzJlYc5FM+RZfhH0+dJ4jfXj3vGSIyRee10obOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ap5mWWwr; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707947249; x=1739483249;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vFBM2F2A9I1qO4nMCigy3x7IwAGUGa7Swx0qaWY1OkE=;
  b=Ap5mWWwrBAgztqYpKeVmTt0rmXGBnsyybvwf3LC2yyo1KZ746h7ueNJ+
   zGArcz51b1c46BAiWmZbesqzTCb9Ny/+Cz33Da4mxjvrZWhSyx7OXHMeQ
   5L58jW3Gx3senzq+8lLnGFJ0aJ1NL9puXVUM8w89zrKh0KTjV9IGbGXfo
   5grgq7gC9hRpR1QduLnqC5EiJlaD91Eq/hZa0GHtYH9nncLyWnpAPrty8
   bYfVaZy78QoQtj7thFML3eeDTzUjBZoC+fkm2qlGj7NNzYqXJgYzSmjmy
   KDKlg9kp9tG5RWRdvoM9Hg6JfH7cAPjp1aM5qSBeQLqa8Np5fGOyGy8Bw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="1895078"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="1895078"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 13:47:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="7932105"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.249.138.241])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 13:47:27 -0800
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
To: linux-kernel@vger.kernel.org
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Kees Cook <keescook@chromium.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH 1/2] wordpart.h: Helpers for making u16/u32/u64 values
Date: Wed, 14 Feb 2024 22:46:53 +0100
Message-Id: <20240214214654.1700-1-michal.wajdeczko@intel.com>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is quite common practice to make u16, u32 or u64 values from
smaller words.  Add simple helpers for that.

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
---
v2: new macro names due to conflict with crypto/aria.h
    explicit cast and truncation everywhere (Alexey)
    moved to wordpart.h (Andy)
---
Cc: Kees Cook <keescook@chromium.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Jani Nikula <jani.nikula@intel.com>
---
 include/linux/wordpart.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/include/linux/wordpart.h b/include/linux/wordpart.h
index f6f8f83b15b0..8c75a5355112 100644
--- a/include/linux/wordpart.h
+++ b/include/linux/wordpart.h
@@ -31,6 +31,38 @@
  */
 #define lower_16_bits(n) ((u16)((n) & 0xffff))
 
+/**
+ * make_u16_from_u8 - make u16 value from two u8 values
+ * @hi: value representing upper 8 bits
+ * @lo: value representing lower 8 bits
+ */
+#define make_u16_from_u8(hi, lo) ((u16)((u16)(u8)(hi) << 8 | (u8)(lo)))
+
+/**
+ * make_u32_from_u16 - make u32 value from two u16 values
+ * @hi: value representing upper 16 bits
+ * @lo: value representing lower 16 bits
+ */
+#define make_u32_from_u16(hi, lo) ((u32)((u32)(u16)(hi) << 16 | (u16)(lo)))
+
+/**
+ * make_u32_from_u8 - make u32 value from u8 values
+ * @a: value representing bits 31-24
+ * @b: value representing bits 23-16
+ * @c: value representing bits 15-8
+ * @d: value representing bits 7-0
+ */
+#define make_u32_from_u8(a, b, c, d) \
+	make_u32_from_u16(make_u16_from_u8((a), (b)), \
+			  make_u16_from_u8((c), (d)))
+
+/**
+ * make_u64_from_u32 - make u64 value from two u32 values
+ * @hi: value representing upper 32 bits
+ * @lo: value representing lower 32 bits
+ */
+#define make_u64_from_u32(hi, lo) ((u64)((u64)(u32)(hi) << 32 | (u32)(lo)))
+
 /**
  * REPEAT_BYTE - repeat the value @x multiple times as an unsigned long value
  * @x: value to repeat
-- 
2.43.0


