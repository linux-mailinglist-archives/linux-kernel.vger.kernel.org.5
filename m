Return-Path: <linux-kernel+bounces-65678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC97855053
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEE1C1F248FB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9C384A35;
	Wed, 14 Feb 2024 17:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RtKIK+kD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F140860BB3
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 17:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707931683; cv=none; b=XOHR78ohdHF+JxCg+5dHfQ4Rul88vGkFaZwsDGZXIb8ikb/LM8EWdjJHjcrbV7bzlyCAS62B+U7Xu/B6FeQro8ZMNpZTgxnmzhYLxn6BWxosiz+8hsv+PzXTBZ3NJLykw6G0BbPSCsKkmH1Ebcr4fzISVN13VTpLpZl3zVyLBuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707931683; c=relaxed/simple;
	bh=4y5RCjrkFomzRsl8jNB3sj0wMY3cFNqM6ZRGm9+de/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qmGaymJJ6P45Ah1FgVhPW2DEmKaDVhipDg9j9Opo+wCHba2mR4b6EQi5ikcqbo2ndiU0WDVfWgI/9LFwozuY4WLZVtiLvkdLzU5wkVXaP3mZiMwhvSNuowzuxf6nSw/tqzUx/dFtxpz7hCycp1V+QbiuSD1t50EgeJ2Txs2HFRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RtKIK+kD; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707931681; x=1739467681;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4y5RCjrkFomzRsl8jNB3sj0wMY3cFNqM6ZRGm9+de/8=;
  b=RtKIK+kDnTjjMh3VHMrDBUNB9eEzpv3qJwIXKmy8H/W+vUy57HgWuEnb
   JAX6vzE+xcKf1EDMGvM4YWf3k+EwwBzRzPB3M0bfyvKlZvNzKRU/RJY13
   fJUFZ8Mgn53U5fzU9MCpQNkmEDB5zvYUm7hSdAdEnka6/DvUAJpT4JZEt
   Kv6cnUdRDuksrxgOYVFY5D/PHJWMrZ946jjL+Ea7954eOTrJwc8Q/z4kF
   L9t0oPAOuLUdBdKNFwLoH/brHHWVMU/PpIjkAQ8s1JzEsJcc6Qp4FFCD6
   ygFKkgLK0rVMntR713qp26y3yltn2g/EkLoCyeUsEkt5oRlmjCglQrCUu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="1863227"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="1863227"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 09:28:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="935617307"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="935617307"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 14 Feb 2024 09:27:58 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 1DD06204; Wed, 14 Feb 2024 19:27:57 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Michal Wajdeczko <michal.wajdeczko@intel.com>
Subject: [PATCH v1 1/1] kernel.h: Move upper_*_bits() and lower_*_bits() to wordpath.h
Date: Wed, 14 Feb 2024 19:26:32 +0200
Message-ID: <20240214172752.3605073-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The wordpart.h header is collecting APIs related to the handling
parts of the word (usually in byte granularity). The upper_*_bits()
and lower_*_bits() are good candidates to be moved to there.

This helps to clean up header dependency hell with regard to kernel.h
as the latter gathers completely unrelated stuff together and slows
down compilation (especially when it's included into other header).

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

Kees, since wordpart.h is now only in your tree, this is supposed
to go there as well.

 include/linux/kernel.h   | 30 ++----------------------------
 include/linux/wordpart.h | 29 +++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 28 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 5f74733391ed..d718fbec72dd 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -33,6 +33,8 @@
 #include <linux/sprintf.h>
 #include <linux/static_call_types.h>
 #include <linux/instruction_pointer.h>
+#include <linux/wordpart.h>
+
 #include <asm/byteorder.h>
 
 #include <uapi/linux/kernel.h>
@@ -52,34 +54,6 @@
 }					\
 )
 
-/**
- * upper_32_bits - return bits 32-63 of a number
- * @n: the number we're accessing
- *
- * A basic shift-right of a 64- or 32-bit quantity.  Use this to suppress
- * the "right shift count >= width of type" warning when that quantity is
- * 32-bits.
- */
-#define upper_32_bits(n) ((u32)(((n) >> 16) >> 16))
-
-/**
- * lower_32_bits - return bits 0-31 of a number
- * @n: the number we're accessing
- */
-#define lower_32_bits(n) ((u32)((n) & 0xffffffff))
-
-/**
- * upper_16_bits - return bits 16-31 of a number
- * @n: the number we're accessing
- */
-#define upper_16_bits(n) ((u16)((n) >> 16))
-
-/**
- * lower_16_bits - return bits 0-15 of a number
- * @n: the number we're accessing
- */
-#define lower_16_bits(n) ((u16)((n) & 0xffff))
-
 struct completion;
 struct user;
 
diff --git a/include/linux/wordpart.h b/include/linux/wordpart.h
index c9e6bd773ebd..f6f8f83b15b0 100644
--- a/include/linux/wordpart.h
+++ b/include/linux/wordpart.h
@@ -2,6 +2,35 @@
 
 #ifndef _LINUX_WORDPART_H
 #define _LINUX_WORDPART_H
+
+/**
+ * upper_32_bits - return bits 32-63 of a number
+ * @n: the number we're accessing
+ *
+ * A basic shift-right of a 64- or 32-bit quantity.  Use this to suppress
+ * the "right shift count >= width of type" warning when that quantity is
+ * 32-bits.
+ */
+#define upper_32_bits(n) ((u32)(((n) >> 16) >> 16))
+
+/**
+ * lower_32_bits - return bits 0-31 of a number
+ * @n: the number we're accessing
+ */
+#define lower_32_bits(n) ((u32)((n) & 0xffffffff))
+
+/**
+ * upper_16_bits - return bits 16-31 of a number
+ * @n: the number we're accessing
+ */
+#define upper_16_bits(n) ((u16)((n) >> 16))
+
+/**
+ * lower_16_bits - return bits 0-15 of a number
+ * @n: the number we're accessing
+ */
+#define lower_16_bits(n) ((u16)((n) & 0xffff))
+
 /**
  * REPEAT_BYTE - repeat the value @x multiple times as an unsigned long value
  * @x: value to repeat
-- 
2.43.0.rc1.1.gbec44491f096


