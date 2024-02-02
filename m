Return-Path: <linux-kernel+bounces-49556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C71846BD2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0C8A296CDC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101207A725;
	Fri,  2 Feb 2024 09:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lm4tYbmZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2187A70C;
	Fri,  2 Feb 2024 09:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706865725; cv=none; b=jrl7xo1BscrLBuSK97PYlLfFS7fvAmfrxnIGGjNNAdEOguo3of0yykUHyVyGMtlpoCaP9iLwDxF39w6/OyGGB/dB4WaJPL6bND27I0SzVWGjhi8hyR0++J7LSzI5+zYN/TdD0Ne27o/IoeWnD0s2JMUa6wdfHfRN5GEBAGC3Q6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706865725; c=relaxed/simple;
	bh=M30zJ8jiKBRt9vcEZBXNCa9ddRJLNILlVAiBhO8gJps=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hZD9a+dIgIRfwoBOXNxTslZHRH66YZtR5PViGq9k2M3QlXy6jC8rOBfef5ad7+FlfTWFnHLq1yqjDLVCmQ9ORMW2VL5buR6yCyTJVRyVEKpoT1LQC82s1OIOC8vvY5N7Hft9jh2J4uJT9KSXSYULC8RdMYvTBBtBtqFkJngYrzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lm4tYbmZ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706865724; x=1738401724;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M30zJ8jiKBRt9vcEZBXNCa9ddRJLNILlVAiBhO8gJps=;
  b=lm4tYbmZn+CmQ+z5JJ55txXOqZl070JcoR6tHWGKpiluY8NuUEv9GmCC
   DTZZ/snkFlD/iN7mUchJhdw5DF/D+SMNg0q5r1E2b4S1E85hXTnEjVYiu
   B/HZNb07Sxvm01dtcTo/w4dsJume52T0ml9iJz7WHOJHcVFaQ458EpKDz
   br54ADKq5dBywiY9VcDVfrlhIFQdAYqHbiGDaW3P/IL6uSY3zs0lwykma
   SSBF0cn62Nn+xcba6Va9egf1dX04uJlM042mGTAnHBANKgOvtSjwg65qA
   GdySmDdA643DQaGJqhucjafbVaFjyvXJ7LgHjjVpjHHSWM/NlTpfIraJ3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="11483053"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="11483053"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 01:22:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="4639703"
Received: from wangnin3-mobl.ccr.corp.intel.com (HELO rzhang1-mobl7.ccr.corp.intel.com) ([10.254.214.177])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 01:22:01 -0800
From: Zhang Rui <rui.zhang@intel.com>
To: linux@roeck-us.net,
	jdelvare@suse.com
Cc: fenghua.yu@intel.com,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2 03/11] hwmon: (coretemp) Enlarge per package core count limit
Date: Fri,  2 Feb 2024 17:21:36 +0800
Message-Id: <20240202092144.71180-4-rui.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202092144.71180-1-rui.zhang@intel.com>
References: <20240202092144.71180-1-rui.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, coretemp driver supports only 128 cores per package.
This loses some core temperature information on systems that have more
than 128 cores per package.
 [   58.685033] coretemp coretemp.0: Adding Core 128 failed
 [   58.692009] coretemp coretemp.0: Adding Core 129 failed
 ...

Enlarge the limitation to 512 because there are platforms with more than
256 cores per package.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/hwmon/coretemp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 95f4c0b00b2d..b8fc8d1ef20d 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -41,7 +41,7 @@ MODULE_PARM_DESC(tjmax, "TjMax value in degrees Celsius");
 
 #define PKG_SYSFS_ATTR_NO	1	/* Sysfs attribute for package temp */
 #define BASE_SYSFS_ATTR_NO	2	/* Sysfs Base attr no for coretemp */
-#define NUM_REAL_CORES		128	/* Number of Real cores per cpu */
+#define NUM_REAL_CORES		512	/* Number of Real cores per cpu */
 #define CORETEMP_NAME_LENGTH	28	/* String Length of attrs */
 #define MAX_CORE_ATTRS		4	/* Maximum no of basic attrs */
 #define TOTAL_ATTRS		(MAX_CORE_ATTRS + 1)
-- 
2.34.1


