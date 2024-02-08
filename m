Return-Path: <linux-kernel+bounces-58559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0486984E809
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD50A1F2D891
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E26D288B6;
	Thu,  8 Feb 2024 18:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RkEyE7SD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220B623769;
	Thu,  8 Feb 2024 18:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707418168; cv=none; b=aGc7zyBBlvUe82E9p5Yr2zEiJz2eQnT0Ygt/lzOVdDrPgpLBzgmVcMpU0Cr9037y8nV444XVxJWCWbEQuYb0tYOJRM+Iil79sxtheU3cm9EH82t5QE39uOYS5reaVfBwvdlP+4sZ1Wgs2EZeCRXdj8xsp4k4+JmmqCc+5AkroJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707418168; c=relaxed/simple;
	bh=LvC0jNLSvlISq+pfX0tunOut+CloWPeckMMVxbBHVes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NW7OmF4ZdehdFH0MJMKyW3tguaVVAxLTY8Dk+DgURLNK57nSvX6a1H0/24UJm22fXs3akQ65ArBxqdb73Sy8k7O93zRC6dfPkMT56l1SayOPsvsVD5J0zE6nirE/O6rfSazacGyVrXsOuyiVWQ/9yCOJ25ZKbF3p6p1fZBVB9e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RkEyE7SD; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707418167; x=1738954167;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LvC0jNLSvlISq+pfX0tunOut+CloWPeckMMVxbBHVes=;
  b=RkEyE7SD3POtTy8ltnwXMDkbN3t6HkF7H7CteCHFV0QDiyaVvoWNh+Zg
   yOqKbM0Evd631cDjzhLnLO2DX1YmhLsxoMTJW6o7FjRtXRY/u1yhCY6Sp
   yke4HE2BpZVmVZ7Qy+1X6qel5Rqc4mAcD7PWErK0cL5S5OQmk20R6n4Vm
   Y4iaBCs0Jnul1SY5Voyek9NaK7NXVAv25tfri+YQSpi6DCAEnlEwBMmNs
   zGhljZ4UQc0+xEnTDH/X1scevCCcZAhHUtwTI71SBRxLdvVZ17PrWhFva
   /2f0AvUIHwkYtR+iMNp7fc6wBUXCEAOarq1j7H1ksfDFKdJq/o9RB8RD6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1186082"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1186082"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 10:49:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="934215512"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="934215512"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 08 Feb 2024 10:49:22 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 4D0DB1FF; Thu,  8 Feb 2024 20:49:21 +0200 (EET)
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
Subject: [PATCH v1 03/15] auxdisplay: linedisp: Use unique number for id
Date: Thu,  8 Feb 2024 20:48:01 +0200
Message-ID: <20240208184919.2224986-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240208184919.2224986-1-andriy.shevchenko@linux.intel.com>
References: <20240208184919.2224986-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The absence of decrementation of linedisp_id is incorrect in two ways,
i.e. it may cause:
- an ID exhaustion
- (and if the above is addressed) a duplicate id number may be allocated
  next time a device is added

Replace above mentioned approach by using IDA framework.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/auxdisplay/line-display.c | 13 ++++++++++---
 drivers/auxdisplay/line-display.h |  2 ++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/auxdisplay/line-display.c b/drivers/auxdisplay/line-display.c
index 310e9bfb41ae..c4dbb13293d1 100644
--- a/drivers/auxdisplay/line-display.c
+++ b/drivers/auxdisplay/line-display.c
@@ -11,6 +11,7 @@
 #include <generated/utsrelease.h>
 
 #include <linux/device.h>
+#include <linux/idr.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/string.h>
@@ -188,11 +189,14 @@ static struct attribute *linedisp_attrs[] = {
 };
 ATTRIBUTE_GROUPS(linedisp);
 
+static DEFINE_IDA(linedisp_id);
+
 static void linedisp_release(struct device *dev)
 {
 	struct linedisp *linedisp = container_of(dev, struct linedisp, dev);
 
 	kfree(linedisp->message);
+	ida_free(&linedisp_id, linedisp->id);
 }
 
 static const struct device_type linedisp_type = {
@@ -214,7 +218,6 @@ int linedisp_register(struct linedisp *linedisp, struct device *parent,
 		      unsigned int num_chars, char *buf,
 		      void (*update)(struct linedisp *linedisp))
 {
-	static atomic_t linedisp_id = ATOMIC_INIT(-1);
 	int err;
 
 	memset(linedisp, 0, sizeof(*linedisp));
@@ -225,9 +228,13 @@ int linedisp_register(struct linedisp *linedisp, struct device *parent,
 	linedisp->num_chars = num_chars;
 	linedisp->scroll_rate = DEFAULT_SCROLL_RATE;
 
+	err = ida_alloc(&linedisp_id, GFP_KERNEL);
+	if (err < 0)
+		return err;
+	linedisp->id = err;
+
 	device_initialize(&linedisp->dev);
-	dev_set_name(&linedisp->dev, "linedisp.%lu",
-		     (unsigned long)atomic_inc_return(&linedisp_id));
+	dev_set_name(&linedisp->dev, "linedisp.%u", linedisp->id);
 
 	/* initialise a timer for scrolling the message */
 	timer_setup(&linedisp->timer, linedisp_scroll, 0);
diff --git a/drivers/auxdisplay/line-display.h b/drivers/auxdisplay/line-display.h
index 0f5891d34c48..1fbe57fdc4cb 100644
--- a/drivers/auxdisplay/line-display.h
+++ b/drivers/auxdisplay/line-display.h
@@ -14,6 +14,7 @@
 /**
  * struct linedisp - character line display private data structure
  * @dev: the line display device
+ * @id: instance id of this display
  * @timer: timer used to implement scrolling
  * @update: function called to update the display
  * @buf: pointer to the buffer for the string currently displayed
@@ -25,6 +26,7 @@
  */
 struct linedisp {
 	struct device dev;
+	unsigned int id;
 	struct timer_list timer;
 	void (*update)(struct linedisp *linedisp);
 	char *buf;
-- 
2.43.0.rc1.1.gbec44491f096


