Return-Path: <linux-kernel+bounces-87036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1811D86CE80
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A301A1F22599
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605BD4AEF3;
	Thu, 29 Feb 2024 15:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hoyazW9/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314B84AECB
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 15:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709222118; cv=none; b=Nit8FjKGc2Ao6MqWwMSO7zPnrm3VPru/0wzcwhzROQWJ9Q6yxpeB/hTyNC3xdXY/sR4ZE5WP9JA3sB+O71QC3JOt1aZ+p7pdXMqG+xVdJXkk0TCafX35g+Nhd9oWlZLbDhOXgb53C24Fh+NnOkIIM8y7QB/uVPkRDmU3y0qyFjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709222118; c=relaxed/simple;
	bh=qjXLbtPJOtzcFmiEigBlQuXlreS7DVmZQkZxpCejSHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DLPZIZAU3yqpki+tBNNQ1wY1dHEv7xKy9O6Oc+/mA6lWgkejdIffckh6a/GXeEFlcCMNQeD9kSX30KpakP13S8iAo9axgCyT/wLfyoNyMVphG5ql9W9gtD4ImgRH51gT6UkYQBQs6gc3Cqlp2/sD6w1NqSFn9yHXFjX7qrymivY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hoyazW9/; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709222117; x=1740758117;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qjXLbtPJOtzcFmiEigBlQuXlreS7DVmZQkZxpCejSHc=;
  b=hoyazW9/vDaDAFlON50p0H38HVP/C05jjMIzbIdQW8x+YDTwmOHw5Wgv
   hv915nQgSDcLVImfnWeAd2nE6tJexQY19nf1pDUoIxos1qBh3vnDCcqz4
   gebtI7G+2jLm8Uom+NdxTW3XFFdOb0/PI6PsJaGHNphpNX/b22cdX3I5j
   58wh6IUW45xCG40HaacUSqWBg2yVNCAtUFOv6CRggR40bjFopxhd9oNqL
   S0r7K8yNTjQ/DPgIvvClbn3vqztdqWUokCHcGUgcC/dYCM2znPk5WpqJf
   eATqrTe73wGXMzqQL55QCQyn4kmOl/GdhmifdENrQ1B9s65yu/q7Rd8Jy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="7479288"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="7479288"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 07:55:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="937036110"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="937036110"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 29 Feb 2024 07:55:14 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 41291476; Thu, 29 Feb 2024 17:55:13 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Philipp Stanner <pstanner@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2 2/2] devres: Don't use "proxy" headers
Date: Thu, 29 Feb 2024 17:53:40 +0200
Message-ID: <20240229155507.3853059-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240229155507.3853059-1-andriy.shevchenko@linux.intel.com>
References: <20240229155507.3853059-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update header inclusions to follow IWYU (Include What You Use)
principle.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/devres.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/lib/devres.c b/lib/devres.c
index 27f280a39dca..4fc152de6d8b 100644
--- a/lib/devres.c
+++ b/lib/devres.c
@@ -1,10 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/bug.h>
 #include <linux/device.h>
-#include <linux/err.h>
-#include <linux/io.h>
-#include <linux/gfp.h>
+#include <linux/errno.h>
 #include <linux/export.h>
+#include <linux/gfp_types.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
 #include <linux/of_address.h>
+#include <linux/types.h>
 
 enum devm_ioremap_type {
 	DEVM_IOREMAP = 0,
-- 
2.43.0.rc1.1.gbec44491f096


