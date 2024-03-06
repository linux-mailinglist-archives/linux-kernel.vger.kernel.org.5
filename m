Return-Path: <linux-kernel+bounces-94219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4940873B91
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7027428A2B4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA6E14037C;
	Wed,  6 Mar 2024 16:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g9pmez6x"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5407A13F42A;
	Wed,  6 Mar 2024 16:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709740888; cv=none; b=rxb2WX+Rras0eoQSSnXSTA3lXNYP8OnLuDdPipPqj2AFt50eds+vxOefHnbDBBF4gysh/ZmU2J2VQOPWpP9JkXAo4xmoznK71NGaL4yryXluc0cSebqUUFRaKZYkvszotvCdUTDakJfMIr32yJy6itAZ5uz4R0TkAscIQ7Gacz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709740888; c=relaxed/simple;
	bh=ONiNnvJDMYm2St92CefVKZ/wRrZ/XLhtQQJUC7bzd/0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q8X9NyQynru8HhK6hrNt1ZHAEAK8mYTMqR+XNp7aCzvsJ+Bblr0KwjwuJg/NVuBUnUkvS3AIbb4+le9gxkhMjA0FSEM/O+2eBgsBsg3S/K++J1R9RGKvWC2f42yGzLwK1oVm5MKBu/1Q7vfdHJaRGjrrxfBfb2fM0+qqK5tDO4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g9pmez6x; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709740888; x=1741276888;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=ONiNnvJDMYm2St92CefVKZ/wRrZ/XLhtQQJUC7bzd/0=;
  b=g9pmez6xwjys9uI+TmsIkVWJGmUWvCZCB4RZkKLAJVXFDNBegQQT1Lgw
   p55ooJYtAz04wvQPgKdowd5/jYNgR7EwXfgu8JfEfUjdD7C/ONkuR8EdG
   tje06NijfQsSkmiiWi9wIskYjnyJMx1pRUdo8bGtn0rT0TS0TP2fmzQVI
   EKquEcyySc4rEG0ScT5qP2BPyClCCPHz9UaQtLTKCj7pRuW5Q8Lhw9HJS
   LKMPF6AutUh5HKnMVPRnK9eVsAaD8oyM072lu69cDSd+MiOZOKbPa5hlr
   bEW35YyV97NcbTuf5vVa6va0s31z7TFNVJ3uNK4d4PDwHWLAaR9KIdMj1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="15504045"
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="15504045"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 08:01:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="937045131"
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="937045131"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 06 Mar 2024 08:01:25 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 963AA3F1; Wed,  6 Mar 2024 18:01:24 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/3] spi: Exctract spi_dev_check_cs() helper
Date: Wed,  6 Mar 2024 17:59:41 +0200
Message-ID: <20240306160114.3471398-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240306160114.3471398-1-andriy.shevchenko@linux.intel.com>
References: <20240306160114.3471398-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It seems a few functions implement the similar for-loop to validate
chip select pins for uniqueness. Let's deduplicate that code in order
to have a single place of that for better maintenance.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi.c | 47 +++++++++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 5e530fa790b0..eb7e3ddf909b 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -608,23 +608,35 @@ static void spi_dev_set_name(struct spi_device *spi)
 		     spi_get_chipselect(spi, 0));
 }
 
+static inline int spi_dev_check_cs(struct device *dev,
+				   struct spi_device *spi, u8 idx,
+				   struct spi_device *new_spi, u8 new_idx)
+{
+	u8 cs, cs_new;
+	u8 idx_new;
+
+	cs = spi_get_chipselect(spi, idx);
+	for (idx_new = new_idx; idx_new < SPI_CS_CNT_MAX; idx_new++) {
+		cs_new = spi_get_chipselect(new_spi, idx_new);
+		if (cs != 0xFF && cs_new != 0xFF && cs == cs_new) {
+			dev_err(dev, "chipselect %u already in use\n", cs_new);
+			return -EBUSY;
+		}
+	}
+	return 0;
+}
+
 static int spi_dev_check(struct device *dev, void *data)
 {
 	struct spi_device *spi = to_spi_device(dev);
 	struct spi_device *new_spi = data;
-	int idx, nw_idx;
-	u8 cs, cs_nw;
+	int status, idx;
 
 	if (spi->controller == new_spi->controller) {
 		for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
-			cs = spi_get_chipselect(spi, idx);
-			for (nw_idx = 0; nw_idx < SPI_CS_CNT_MAX; nw_idx++) {
-				cs_nw = spi_get_chipselect(new_spi, nw_idx);
-				if (cs != 0xFF && cs_nw != 0xFF && cs == cs_nw) {
-					dev_err(dev, "chipselect %d already in use\n", cs_nw);
-					return -EBUSY;
-				}
-			}
+			status = spi_dev_check_cs(dev, spi, idx, new_spi, 0);
+			if (status)
+				return status;
 		}
 	}
 	return 0;
@@ -640,8 +652,8 @@ static int __spi_add_device(struct spi_device *spi)
 {
 	struct spi_controller *ctlr = spi->controller;
 	struct device *dev = ctlr->dev.parent;
-	int status, idx, nw_idx;
-	u8 cs, nw_cs;
+	int status, idx;
+	u8 cs;
 
 	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
 		/* Chipselects are numbered 0..max; validate. */
@@ -658,14 +670,9 @@ static int __spi_add_device(struct spi_device *spi)
 	 * For example, spi->chip_select[0] != spi->chip_select[1] and so on.
 	 */
 	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
-		cs = spi_get_chipselect(spi, idx);
-		for (nw_idx = idx + 1; nw_idx < SPI_CS_CNT_MAX; nw_idx++) {
-			nw_cs = spi_get_chipselect(spi, nw_idx);
-			if (cs != 0xFF && nw_cs != 0xFF && cs == nw_cs) {
-				dev_err(dev, "chipselect %d already in use\n", nw_cs);
-				return -EBUSY;
-			}
-		}
+		status = spi_dev_check_cs(dev, spi, idx, spi, idx + 1);
+		if (status)
+			return status;
 	}
 
 	/* Set the bus ID string */
-- 
2.43.0.rc1.1.gbec44491f096


