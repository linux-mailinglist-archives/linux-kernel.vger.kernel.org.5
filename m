Return-Path: <linux-kernel+bounces-33940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D68F837073
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B82CF28EC07
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD37264AB5;
	Mon, 22 Jan 2024 18:08:39 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BD762A11
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 18:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946918; cv=none; b=dPGqoP6PxwWt0EtM1cbzRhHF5w3Fflk8IEpQq04XoBUcHDrKy8nQvL//UmeD9zPdYRtrX5qY9//LDLhgFUREJ9IZM1TKssXO2dcpvQRPLk8NfOiASeaLSBz9MrpPLuFxHescqSzkglxJsOU23o4BU5+sHlf7ybgNAAZkC+vAkKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946918; c=relaxed/simple;
	bh=yu7xNIM8JxCKE+AFbgKgMhwZWwewLVSSPd3EFE9Z4og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kmFrGlXz28u6YiPDQrin7Vy6JaeQ+In1irAP/WvlxGyjsolAInw7t9IdIAADbr19iZVvF9Tr+bfty7rfXW+nv66cw4qwTVslyrHaPysh5gsuqr9lkuceY5p82HUG2G6t/ly7FnXQWowMB6YK0jg9Ypbn1GfQ3ezBus/CX6tb2bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyia-000293-71; Mon, 22 Jan 2024 19:08:20 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiZ-001eRE-83; Mon, 22 Jan 2024 19:08:19 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiZ-005Zyx-0W;
	Mon, 22 Jan 2024 19:08:19 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de,
	Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	James Clark <james.clark@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: [PATCH v2 32/33] spi: Drop compat layer from renaming "master" to "controller"
Date: Mon, 22 Jan 2024 19:07:27 +0100
Message-ID:  <0107400bb6616ac78c01215320a6bbe6a0d10e7c.1705944943.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1705944943.git.u.kleine-koenig@pengutronix.de>
References: <cover.1705944943.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3719; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=yu7xNIM8JxCKE+AFbgKgMhwZWwewLVSSPd3EFE9Z4og=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlrq7os4dGrOBFnhGPj4Fn83pUK0AmUqwZwnlbl LI4Yy83kg2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZa6u6AAKCRCPgPtYfRL+ Tt31CACR9UgCXZ45LhmjKUsgXa+SuEnJYJRWWhSw3fkuVpJnoJ1UJmZwxSvtycT1iektwMC6o16 F/aj7neEXIPe6bdhMswnHJ0idJFDn2DFFW3SPtwPwWIajB/r/BoQSPJKGQJ9i/Z4jSsU8/oywuf QvfT8S/1JF4GcibRnxAQHHoGVxejrvnTNNs2UDEZWvBXljxQ4Y5aYMj3WKZ4WB39WmTRkxzmzrR lcC+LaPH7LMteiam3Ipiz0i0DbYcf2JIG+osJ/3K9L6qkTtqsDlkvlwocyF+BcKv6TyaZ/WkbSs 4yAO/DrV8aOI+zE5D8tHtbvQ1imLkr6hYSAt4w5zeicAZugI
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Now that all in-tree users followed the rename, the compat stuff can go
away.  This completes the renaming started with commit 8caab75fd2c2
("spi: Generalize SPI "master" to "controller"")

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
index 7477a11e12be..2d7393045384 100644
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
index 471fe2ff9066..6a4f8cbba5ef 100644
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


