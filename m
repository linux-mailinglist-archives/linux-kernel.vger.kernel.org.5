Return-Path: <linux-kernel+bounces-58553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 467B084E7F4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F020D293BF2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282D228DD2;
	Thu,  8 Feb 2024 18:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TnxemnN/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066ED2560F;
	Thu,  8 Feb 2024 18:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707417957; cv=none; b=SZASSLVHAUy0uo2eyUUHAtUNL7DG/kSiF1f0Lap3cPnbJiAWXyf16P03ymTHgHNlg43b5JEXVQJybqAkj5FlZssL8Uvp1ry2CP1UUhNAoUUkW54T0PyfNep+Ok/6L4AQmOHr0S3pqV0SF4Sa+t/fZNXOErroquGzJIf5CE6oEyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707417957; c=relaxed/simple;
	bh=FC1cjzT0133HljBbHlbObVyjHCu4QTG/1Zt/QXNpVSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AdLxS789QnRe1OOpI1OpIPuiRxaFZrZJgCF1SylHADx4PwPfzmITI9CZho85BPAwETWgb5NvaRUl4dlhCRSjrKZ6bT6LD5u+OYSRQCbzjkLXjlJznokpnK3uM0Yn96G43a3ACiq3Ni54vsPczzy35jNBts47qGX/nvrm43VkHTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TnxemnN/; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707417956; x=1738953956;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FC1cjzT0133HljBbHlbObVyjHCu4QTG/1Zt/QXNpVSA=;
  b=TnxemnN/eBQMO2L51rE8zBKS2Y6K8M5lIhtDmq/uoJFVmIdkD8wjdC2W
   y2zBWJpFT+LnFGir060Yu7bTK0hzVyb2+pAITTJwwocxpmHplbolZ+Xyd
   82NWqK/x64/5iT98LcVVDzasC9V78BmH5LnhS6+1pqkCmjNOKkOpFJiYk
   MxA6q8LkzJp/Yiqty4xKOp4ArnzUTkmYPyj1MtVuQ7ONN6dAL6DE4iuHW
   3yWe3rll+2KmMdijYXaiM5pM7/wW4MXoEx0kov7MBkNgBTR+bU2w33+2v
   f2K+4XUDDwFDbvbimkLhIGaEVeJSYXmTksOn7NRvNXlA6Gyu40yqcNVp+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1185255"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1185255"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 10:45:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="934214477"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="934214477"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 08 Feb 2024 10:45:51 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 3F5FF13FD; Thu,  8 Feb 2024 18:59:41 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin van der Gracht <robin@protonic.nl>,
	Paul Burton <paulburton@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v1 05/15] auxdisplay: linedisp: Add missing header(s)
Date: Thu,  8 Feb 2024 18:58:48 +0200
Message-ID: <20240208165937.2221193-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240208165937.2221193-1-andriy.shevchenko@linux.intel.com>
References: <20240208165937.2221193-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do not imply that some of the generic headers may be always included.
Instead, include explicitly what we are direct user of.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/auxdisplay/line-display.c | 3 +++
 drivers/auxdisplay/line-display.h | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/auxdisplay/line-display.c b/drivers/auxdisplay/line-display.c
index 4b92ae7781f1..6b3d25e20eeb 100644
--- a/drivers/auxdisplay/line-display.c
+++ b/drivers/auxdisplay/line-display.c
@@ -10,8 +10,11 @@
 
 #include <generated/utsrelease.h>
 
+#include <linux/container_of.h>
 #include <linux/device.h>
+#include <linux/export.h>
 #include <linux/idr.h>
+#include <linux/jiffies.h>
 #include <linux/kstrtox.h>
 #include <linux/module.h>
 #include <linux/slab.h>
diff --git a/drivers/auxdisplay/line-display.h b/drivers/auxdisplay/line-display.h
index 1fbe57fdc4cb..d72c1899dc50 100644
--- a/drivers/auxdisplay/line-display.h
+++ b/drivers/auxdisplay/line-display.h
@@ -11,6 +11,9 @@
 #ifndef _LINEDISP_H
 #define _LINEDISP_H
 
+#include <linux/device.h>
+#include <linux/timer_types.h>
+
 /**
  * struct linedisp - character line display private data structure
  * @dev: the line display device
-- 
2.43.0.rc1.1.gbec44491f096


