Return-Path: <linux-kernel+bounces-56954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B2084D1B0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE5121C21DFF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864C31386DB;
	Wed,  7 Feb 2024 18:43:39 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E6312E1FF
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 18:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707331415; cv=none; b=IZwDicJ9rmls9/CeYRpWiXq+kGulWbMtDRWugtjPnWH3sSC73x9skZa9/OxB0jF6a7/Yhd+weixInuizbzldm8zqsP4uSCsUSzFhdcsnTzQfrYTgPHwTZGv1y29S3OiwkpEQIBQ2CtIN+Olplp3237l222LBF+O0L1uklrNhnfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707331415; c=relaxed/simple;
	bh=uB3EFp1QO1hexwLLVQgbTObbWoAfnWMVl1AIy0DdRhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dymoGIE0btWD9WnSXzOH/H4kQmHH1x/oBBxCMz3QHsKfcRRf7lwbqpU5u+gBPDVPvqC0Ro26WYHmZBbcNzuUOAkfVpaV6zo8c7x/IzY9Nsm/P4PAn3jzb5QcK4L9YXhHjLfZB4kcfZcFlOV6z+qU/lp9LYXsInFf913De4Q4M94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmtE-00089Y-UF; Wed, 07 Feb 2024 19:43:20 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmtE-0054Ym-3e; Wed, 07 Feb 2024 19:43:20 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmtE-00HRtt-05;
	Wed, 07 Feb 2024 19:43:20 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de,
	Jonathan Corbet <corbet@lwn.net>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	James Clark <james.clark@arm.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: [PATCH v3 31/32] spi: Drop compat layer from renaming "master" to "controller"
Date: Wed,  7 Feb 2024 19:40:45 +0100
Message-ID:  <ad1d949325b61a4682e8d6ecf9d05da751e6a99f.1707324794.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1707324793.git.u.kleine-koenig@pengutronix.de>
References: <cover.1707324793.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3777; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=uB3EFp1QO1hexwLLVQgbTObbWoAfnWMVl1AIy0DdRhs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlw87m7jcEk6MBx1cg+GuyUSMqcytNRFv3xCFiM 6JtdE0QP2qJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcPO5gAKCRCPgPtYfRL+ TpzWCACjfAyRML6L8ZOoMmat3fJR2FLO4Aw3vRds41Bmzf0wXRoRCuJhA7rAaSG9rTc8tijCWr5 v9asd7VwhesST11FK/hrFHqlriBG8zT8nYNYJRES2yc3qrVE4+n/t0FJJ1CGTY/TPodjABqLOqH m6XS0WWv9+0WfUNypQk14db+sT8KpDuom7TuwLa4ylkkFfhUkSbzmXXN+vlbaKwTKoDz5Nw5UZG JzXvWjlau2v20A8Zp219c7Jet0Wqb3kjbWPODyIQ3t+35PIfW+YbGhpBe51c5NjMo0R5fbxjhin Ka94760BEZONczT3M69IXKcCp73KaoEm5skKp6ejTi9XbLj7
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Now that all in-tree users followed the rename, the compat stuff can go
away.  This completes the renaming started with commit 8caab75fd2c2
("spi: Generalize SPI "master" to "controller"")

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 .../driver-api/driver-model/devres.rst        |  2 +-
 drivers/spi/spi.c                             |  2 +-
 include/linux/spi/spi.h                       | 20 +------------------
 3 files changed, 3 insertions(+), 21 deletions(-)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index c5f99d834ec5..49c6fd82cd5d 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -462,7 +462,7 @@ SLAVE DMA ENGINE
 SPI
   devm_spi_alloc_master()
   devm_spi_alloc_slave()
-  devm_spi_register_master()
+  devm_spi_register_controller()
 
 WATCHDOG
   devm_watchdog_register_device()
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 53c25a351dab..c08fe2cb256c 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -584,7 +584,7 @@ struct spi_device *spi_alloc_device(struct spi_controller *ctlr)
 		return NULL;
 	}
 
-	spi->master = spi->controller = ctlr;
+	spi->controller = ctlr;
 	spi->dev.parent = &ctlr->dev;
 	spi->dev.bus = &spi_bus_type;
 	spi->dev.release = spidev_release;
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 9e3866809a0e..7500db33f70c 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -131,7 +131,6 @@ extern void spi_transfer_cs_change_delay_exec(struct spi_message *msg,
  * struct spi_device - Controller side proxy for an SPI slave device
  * @dev: Driver model representation of the device.
  * @controller: SPI controller used with the device.
- * @master: Copy of controller, for backwards compatibility.
  * @max_speed_hz: Maximum clock rate to be used with this chip
  *	(on this board); may be changed by the device's driver.
  *	The spi_transfer.speed_hz can override this for each transfer.
@@ -185,7 +184,6 @@ extern void spi_transfer_cs_change_delay_exec(struct spi_message *msg,
 struct spi_device {
 	struct device		dev;
 	struct spi_controller	*controller;
-	struct spi_controller	*master;	/* Compatibility layer */
 	u32			max_speed_hz;
 	u8			chip_select[SPI_CS_CNT_MAX];
 	u8			bits_per_word;
@@ -1298,7 +1296,7 @@ spi_max_transfer_size(struct spi_device *spi)
  */
 static inline bool spi_is_bpw_supported(struct spi_device *spi, u32 bpw)
 {
-	u32 bpw_mask = spi->master->bits_per_word_mask;
+	u32 bpw_mask = spi->controller->bits_per_word_mask;
 
 	if (bpw == 8 || (bpw <= 32 && bpw_mask & SPI_BPW_MASK(bpw)))
 		return true;
@@ -1670,20 +1668,4 @@ spi_transfer_is_last(struct spi_controller *ctlr, struct spi_transfer *xfer)
 	return list_is_last(&xfer->transfer_list, &ctlr->cur_msg->transfers);
 }
 
-/* Compatibility layer */
-#define spi_master			spi_controller
-
-#define spi_master_get_devdata(_ctlr)	spi_controller_get_devdata(_ctlr)
-#define spi_master_set_devdata(_ctlr, _data)	\
-	spi_controller_set_devdata(_ctlr, _data)
-#define spi_master_get(_ctlr)		spi_controller_get(_ctlr)
-#define spi_master_put(_ctlr)		spi_controller_put(_ctlr)
-#define spi_master_suspend(_ctlr)	spi_controller_suspend(_ctlr)
-#define spi_master_resume(_ctlr)	spi_controller_resume(_ctlr)
-
-#define spi_register_master(_ctlr)	spi_register_controller(_ctlr)
-#define devm_spi_register_master(_dev, _ctlr) \
-	devm_spi_register_controller(_dev, _ctlr)
-#define spi_unregister_master(_ctlr)	spi_unregister_controller(_ctlr)
-
 #endif /* __LINUX_SPI_H */
-- 
2.43.0


