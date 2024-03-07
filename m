Return-Path: <linux-kernel+bounces-95793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3708752AA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF985282F72
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A6012FB0D;
	Thu,  7 Mar 2024 15:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PzWiJLGH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E6F12F36D;
	Thu,  7 Mar 2024 15:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709823785; cv=none; b=noyQ3C+EHRoW6UHalQYSSqPpanjgj3TNKaHOhBytbGHvNn6tuEW81ohO5A8fYUy0meNoPj3Mb2elNce0ei4CQf9c9tuPmhSggkpRGz24IO3Ws3KZ72p53xydC0N5PZUSJtO5wOyMDXMDweixkVq7CWD1OBN+vxgBX/ZUppEwHsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709823785; c=relaxed/simple;
	bh=igdABOawL1h4rO87mXAA8AcyfRv/CCBWSRMMYoBQs2w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fzzi3ddvZgzPNlY1aBK75nojl8q+9nSO7w8lRwaPdyaZNz7R+OwkZgJI9RafxbmqwpirgP9Cmi+rmvkaUzBedi5bhNonV67/50mdJLf5H8DaBtJVg8LAaO8jCzevJpf0XbWXhwckCv2UoqIU/HtDJCjyp0uWHaukXEm4HXaOcvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PzWiJLGH; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709823784; x=1741359784;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=igdABOawL1h4rO87mXAA8AcyfRv/CCBWSRMMYoBQs2w=;
  b=PzWiJLGHTW4YEQUEv0ZQPGsJZRgQy/esrszRFiyALy2aSl+BRsbU5bzT
   VjTUPLPA2w3fdIoVLsZxz64vUT6Mgz4D+aWpCdiJU+o/SJG6OhwhkI4iz
   brmfSpRhJeHagxnJWbCnWDU2gJnJIazbV5KkJEpcIoiW45j8fYo/Nv5nH
   lLDh7yT4dP960TYuEkliepbrIlGHKF5hDkjw9EC6Kef1HCEcAX6RTJmxM
   tT2rwKRHULaNVzE8PrAynFaLQGVjcEpDyVgXImbcsIaksMqbZ/Nfz+W8P
   2ZKowTB9COGJIMgG29GJ6gEyAON7+pj78B0+eXUpsjEv0c6Gl8zWuaVZO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4351053"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="4351053"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 07:03:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="937046328"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="937046328"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Mar 2024 07:02:59 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 30DB15BB; Thu,  7 Mar 2024 17:02:58 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/3] spi: Introduce SPI_INVALID_CS and is_valid_cs()
Date: Thu,  7 Mar 2024 17:01:01 +0200
Message-ID: <20240307150256.3789138-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240307150256.3789138-1-andriy.shevchenko@linux.intel.com>
References: <20240307150256.3789138-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SPI core inconsistently uses the marker value for unused chip select
pin. Define a constant (with appropriate type) and introduce is_valid_cs()
helper function to avoid spreading this inconsistency in the future.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 4ab155f698c8..f18738ae95f8 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -608,6 +608,22 @@ static void spi_dev_set_name(struct spi_device *spi)
 		     spi_get_chipselect(spi, 0));
 }
 
+/*
+ * Zero(0) is a valid physical CS value and can be located at any
+ * logical CS in the spi->chip_select[]. If all the physical CS
+ * are initialized to 0 then It would be difficult to differentiate
+ * between a valid physical CS 0 & an unused logical CS whose physical
+ * CS can be 0. As a solution to this issue initialize all the CS to -1.
+ * Now all the unused logical CS will have -1 physical CS value & can be
+ * ignored while performing physical CS validity checks.
+ */
+#define SPI_INVALID_CS		((s8)-1)
+
+static inline bool is_valid_cs(s8 chip_select)
+{
+	return chip_select != SPI_INVALID_CS;
+}
+
 static inline int spi_dev_check_cs(struct device *dev,
 				   struct spi_device *spi, u8 idx,
 				   struct spi_device *new_spi, u8 new_idx)
@@ -618,7 +634,7 @@ static inline int spi_dev_check_cs(struct device *dev,
 	cs = spi_get_chipselect(spi, idx);
 	for (idx_new = new_idx; idx_new < SPI_CS_CNT_MAX; idx_new++) {
 		cs_new = spi_get_chipselect(new_spi, idx_new);
-		if (cs != 0xFF && cs_new != 0xFF && cs == cs_new) {
+		if (is_valid_cs(cs) && is_valid_cs(cs_new) && cs == cs_new) {
 			dev_err(dev, "chipselect %u already in use\n", cs_new);
 			return -EBUSY;
 		}
@@ -658,7 +674,7 @@ static int __spi_add_device(struct spi_device *spi)
 	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
 		/* Chipselects are numbered 0..max; validate. */
 		cs = spi_get_chipselect(spi, idx);
-		if (cs != 0xFF && cs >= ctlr->num_chipselect) {
+		if (is_valid_cs(cs) && cs >= ctlr->num_chipselect) {
 			dev_err(dev, "cs%d >= max %d\n", spi_get_chipselect(spi, idx),
 				ctlr->num_chipselect);
 			return -EINVAL;
@@ -698,7 +714,7 @@ static int __spi_add_device(struct spi_device *spi)
 
 		for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
 			cs = spi_get_chipselect(spi, idx);
-			if (cs != 0xFF)
+			if (is_valid_cs(cs))
 				spi_set_csgpiod(spi, idx, ctlr->cs_gpiods[cs]);
 		}
 	}
@@ -756,17 +772,8 @@ static void spi_set_all_cs_unused(struct spi_device *spi)
 {
 	u8 idx;
 
-	/*
-	 * Zero(0) is a valid physical CS value and can be located at any
-	 * logical CS in the spi->chip_select[]. If all the physical CS
-	 * are initialized to 0 then It would be difficult to differentiate
-	 * between a valid physical CS 0 & an unused logical CS whose physical
-	 * CS can be 0. As a solution to this issue initialize all the CS to 0xFF.
-	 * Now all the unused logical CS will have 0xFF physical CS value & can be
-	 * ignore while performing physical CS validity checks.
-	 */
 	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++)
-		spi_set_chipselect(spi, idx, 0xFF);
+		spi_set_chipselect(spi, idx, SPI_INVALID_CS);
 }
 
 /**
@@ -1050,7 +1057,7 @@ static void spi_set_cs(struct spi_device *spi, bool enable, bool force)
 
 	spi->controller->last_cs_index_mask = spi->cs_index_mask;
 	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++)
-		spi->controller->last_cs[idx] = enable ? spi_get_chipselect(spi, 0) : -1;
+		spi->controller->last_cs[idx] = enable ? spi_get_chipselect(spi, 0) : SPI_INVALID_CS;
 	spi->controller->last_cs_mode_high = spi->mode & SPI_CS_HIGH;
 
 	if (spi->mode & SPI_CS_HIGH)
@@ -3333,9 +3340,9 @@ int spi_register_controller(struct spi_controller *ctlr)
 		goto free_bus_id;
 	}
 
-	/* Setting last_cs to -1 means no chip selected */
+	/* Setting last_cs to SPI_INVALID_CS means no chip selected */
 	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++)
-		ctlr->last_cs[idx] = -1;
+		ctlr->last_cs[idx] = SPI_INVALID_CS;
 
 	status = device_add(&ctlr->dev);
 	if (status < 0)
-- 
2.43.0.rc1.1.gbec44491f096


