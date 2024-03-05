Return-Path: <linux-kernel+bounces-92785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1538C8725F8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5EB22898FD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D471AAC4;
	Tue,  5 Mar 2024 17:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mvHLWkKL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D5517BA6;
	Tue,  5 Mar 2024 17:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709660984; cv=none; b=Q6jvrWI+56r/NhBlR3aJP1CWCQZ6zE9gXS9L2rl14Vmtt13Ck8CHEthRlR6b0iGaTpEv87IvXjnaMJ4hGym5jT8nAWo3jydhFaAmrJ+QZMGrAwHk+WYA7DeGEIOES2c4F9PiI1ueS3ShE4QmUfD+Pg2G23pX7N+zMeuA7UUVF5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709660984; c=relaxed/simple;
	bh=3MlnLBgXOZG1+AlvXxdAehQKpjrynnwPtE67gW/4HCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AIBKSo8wf1IZw51glewrxA+zu58qnr0ZdWGr9UlAugHuv+3Q6eIHs1b0ESIS4zlUYYM5NItXUFcDp8aCtZ6YWxJTgyRKoPVK290yoRhoRNQL3PK8TYWuMoGcSTaRvuVvFPkm3W8HJUNWXbt1xLZz3w/PkAJCjNA8qDCxpVA85+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mvHLWkKL; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709660982; x=1741196982;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3MlnLBgXOZG1+AlvXxdAehQKpjrynnwPtE67gW/4HCw=;
  b=mvHLWkKLiBevmFPEV+Jv5rw5qAJ8RlQqctoFnHomR7w4Pnj4CjkuCFUN
   q9SXJE/UFnJqxMzfINJKZnYF7QBnN467S9pc3n4j+WdiSGxtrRAGE3l6M
   k0pxE1XftoxanDRjOJwQvDs1rvXU5m5fQVsYNCjSiu8fyGlMdrk0FbvmV
   189LbmNbZC0htknatNAh1/wzR8F07MJzoVCTAx6dGHoXbuucmNYtJ6CMW
   Pp5dY+TUKTdX1XtMSHQG3dNZ0qHA0KdQwPWO8HBGkpUNoFqR+BDcbLx1Z
   Isr501eQxL+mh3LH1piMVgkYnzsGVX9ojrIk/lljXINMrkO+Lw+5Brdx6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="4092445"
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="4092445"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 09:49:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="937042796"
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="937042796"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 05 Mar 2024 09:49:36 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 423156FE; Tue,  5 Mar 2024 19:49:35 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH v1 2/5] media: ir-spi: Make use of device properties
Date: Tue,  5 Mar 2024 19:48:27 +0200
Message-ID: <20240305174933.1370708-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240305174933.1370708-1-andriy.shevchenko@linux.intel.com>
References: <20240305174933.1370708-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the module to be property provider agnostic and allow
it to be used on non-OF platforms.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/media/rc/ir-spi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/rc/ir-spi.c b/drivers/media/rc/ir-spi.c
index 28437a35b7ba..846d407a1f7e 100644
--- a/drivers/media/rc/ir-spi.c
+++ b/drivers/media/rc/ir-spi.c
@@ -10,7 +10,7 @@
 #include <linux/math.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of.h>
+#include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
 #include <linux/string.h>
@@ -116,6 +116,7 @@ static int ir_spi_set_duty_cycle(struct rc_dev *dev, u32 duty_cycle)
 
 static int ir_spi_probe(struct spi_device *spi)
 {
+	struct device *dev = &spi->dev;
 	int ret;
 	u8 dc;
 	struct ir_spi_data *idata;
@@ -140,9 +141,8 @@ static int ir_spi_probe(struct spi_device *spi)
 	idata->rc->priv            = idata;
 	idata->spi                 = spi;
 
-	idata->negated = of_property_read_bool(spi->dev.of_node,
-							"led-active-low");
-	ret = of_property_read_u8(spi->dev.of_node, "duty-cycle", &dc);
+	idata->negated = device_property_read_bool(dev, "led-active-low");
+	ret = device_property_read_u8(dev, "duty-cycle", &dc);
 	if (ret)
 		dc = 50;
 
-- 
2.43.0.rc1.1.gbec44491f096


