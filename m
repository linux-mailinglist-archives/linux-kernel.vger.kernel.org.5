Return-Path: <linux-kernel+bounces-62047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF578851AC5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CFFA1F24DFE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6723041238;
	Mon, 12 Feb 2024 17:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d6CtesN0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D3D41764;
	Mon, 12 Feb 2024 17:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707757493; cv=none; b=MqpjZZ7pQklLXUzOhzPCxmkSVlS2EF77AyKtlYG4gYEk8IQCtOUYbfjPfNXmNHSdEsGXYwXjzPOhLMIcObFcHPCxB0N8qy/A+4xHUpjH59dSRQu4ltw8p+dx50QmffPgGC+pAMtdplBXdQP+SP+/z8hFMdr5fVA2XHvAESHNYh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707757493; c=relaxed/simple;
	bh=T7Mp/G619hZCfbmKq4sfu5Mlrc26ZVC0R/tzaJ91tuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l3OVrSN71A1yvjODEQu3A/jmRgZe4TRmCjBdD5c3vFG28wyhET9tFLU4JN2Tnp0Giw9/9nGomXSvqsjXxP7mnlry4rmPZdKprHC1apBiPoO5ZqGQC1WNNFjly9KB6OOazYC2Q54wPcIDH+1eP0Wh+Gu3JHoG7aRX1WeNuXWjhcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d6CtesN0; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707757492; x=1739293492;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T7Mp/G619hZCfbmKq4sfu5Mlrc26ZVC0R/tzaJ91tuc=;
  b=d6CtesN0w0FZKj1ZTZ9lc+9xsf/dP8IlKvnpU3iVmD/ML9Cduz/Ao7jp
   gLTuodxN4MJU6rhhltsdvsI7ipBaL6FvoQ6Rgq6n0x3JSJ+k66WZZIrF/
   wVwjc6NWLN/B89lHZCxWtew1LpsDnw08xIrZiCTj/Y+vlaYfLdeGWLP7d
   ZCuQ8fRXv5+tFNq8/AF1y+o+zqY8dpq35c9/7zsAw/zgxrrRS5o/pvyR8
   TXYnGMjDxa4Qcs8SbhoumGG5RoPPxKjdamaHCcA4PnDha8+0S1NKzUB3q
   28eRQ7UIaHHEeKwb66tntCg9/BNDjgfLBV247Td3y6MkhbXaRm7Tf2I8d
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="19153201"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="19153201"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 09:04:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="935116820"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="935116820"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 12 Feb 2024 09:04:46 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id C465D204; Mon, 12 Feb 2024 19:04:42 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin van der Gracht <robin@protonic.nl>,
	Paul Burton <paulburton@kernel.org>
Subject: [PATCH v2 05/15] auxdisplay: linedisp: Add missing header(s)
Date: Mon, 12 Feb 2024 19:01:38 +0200
Message-ID: <20240212170423.2860895-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240212170423.2860895-1-andriy.shevchenko@linux.intel.com>
References: <20240212170423.2860895-1-andriy.shevchenko@linux.intel.com>
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
index 8d91c2099661..a0339e4b5939 100644
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


