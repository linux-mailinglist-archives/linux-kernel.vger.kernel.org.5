Return-Path: <linux-kernel+bounces-56951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7022284D1AB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8EB928C291
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D0A13666D;
	Wed,  7 Feb 2024 18:43:36 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0710312C54B
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 18:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707331413; cv=none; b=J55oA0u8ZvB3n1J8WDGA3J4NiKkI4CRZmyZELO/YgreOUSsZHgkXykPX/zegKIOaqo9q5XjgPtTJlyM/PD0fLMZ0xO9tn42evVehBPQL1DQF0zn1zEx6bD6ELb8//1/ymeYcsItIXBxyRMBR11jpnLUe9WVGt4chRuOCob8xxaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707331413; c=relaxed/simple;
	bh=vpDuTe5EAw0ElIUOb6YoyY9WKiKn5pwm75mKyxxDj84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ARB/yHe3Djn49UvMyD4zAk9K+eRp4asYNdWKfRxQ03eju9MEir1+b1O6XfDluGslrMXxR0He57cIXAEcUVLp/u2PrMjH0kBClqKJlpihYCnewlegw0bM76So3PO+zhRSZ4pVf6omX7JVPdxqMaWIlA5eWAawb+qQSdprHGPY3yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmtC-0007vF-7U; Wed, 07 Feb 2024 19:43:18 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmtB-0054YP-Jl; Wed, 07 Feb 2024 19:43:17 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmtB-00HRtV-1g;
	Wed, 07 Feb 2024 19:43:17 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de,
	Viresh Kumar <vireshk@kernel.org>,
	Rui Miguel Silva <rmfrfs@gmail.com>,
	Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 25/32] staging: greybus: spi: Follow renaming of SPI "master" to "controller"
Date: Wed,  7 Feb 2024 19:40:39 +0100
Message-ID:  <f6f0568df29f9a51358e86326b917d81af8aba74.1707324794.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6419; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=vpDuTe5EAw0ElIUOb6YoyY9WKiKn5pwm75mKyxxDj84=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlw87LbyOl/56v1AiUmZxs/6QoCHYQx7QvZoZP5 cG28YYGs2iJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcPOywAKCRCPgPtYfRL+ TjFxB/958zzfe6nppdfLKw+CAd+OkRm1DjnN94AI4WhAwTtvQkWb7ExN6WpJn+NVwnOzDZshMMY Aat7x6KudEEUagTdYZcQUurlPZ0lmGyclsbXXwE1Kb/j5t/YdmsTwtY727bqQmiPfvm04yCQMJi BzgEfHDSflaMd/r7TM+0yG4mo/56a0boSVtBtu5HVbPZp+lXzazEZU0bRnF/vVOeZVaEAHPE8Rb xlWnZNAXCnM0GnFkaLaD+eNaDONuSOZhO9XiBD6XCfnQlaLis7ymVuSLclUY0FX82vhkcO4tb9G hA+XYGwO0hpJoxTCJUAPDsfmqsfY/bo3oxgW1/J3fX7KXQHU
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

In commit 8caab75fd2c2 ("spi: Generalize SPI "master" to "controller"")
some functions and struct members were renamed. To not break all drivers
compatibility macros were provided.

To be able to remove these compatibility macros push the renaming into
this driver.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/staging/greybus/spilib.c | 66 ++++++++++++++++----------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/drivers/staging/greybus/spilib.c b/drivers/staging/greybus/spilib.c
index efb3bec58e15..34f10685139f 100644
--- a/drivers/staging/greybus/spilib.c
+++ b/drivers/staging/greybus/spilib.c
@@ -42,7 +42,7 @@ struct gb_spilib {
 
 #define XFER_TIMEOUT_TOLERANCE		200
 
-static struct spi_master *get_master_from_spi(struct gb_spilib *spi)
+static struct spi_controller *get_controller_from_spi(struct gb_spilib *spi)
 {
 	return gb_connection_get_data(spi->connection);
 }
@@ -324,10 +324,10 @@ static void gb_spi_decode_response(struct gb_spilib *spi,
 	}
 }
 
-static int gb_spi_transfer_one_message(struct spi_master *master,
+static int gb_spi_transfer_one_message(struct spi_controller *ctlr,
 				       struct spi_message *msg)
 {
-	struct gb_spilib *spi = spi_master_get_devdata(master);
+	struct gb_spilib *spi = spi_controller_get_devdata(ctlr);
 	struct gb_connection *connection = spi->connection;
 	struct gb_spi_transfer_response *response;
 	struct gb_operation *operation;
@@ -371,21 +371,21 @@ static int gb_spi_transfer_one_message(struct spi_master *master,
 out:
 	msg->status = ret;
 	clean_xfer_state(spi);
-	spi_finalize_current_message(master);
+	spi_finalize_current_message(ctlr);
 
 	return ret;
 }
 
-static int gb_spi_prepare_transfer_hardware(struct spi_master *master)
+static int gb_spi_prepare_transfer_hardware(struct spi_controller *ctlr)
 {
-	struct gb_spilib *spi = spi_master_get_devdata(master);
+	struct gb_spilib *spi = spi_controller_get_devdata(ctlr);
 
 	return spi->ops->prepare_transfer_hardware(spi->parent);
 }
 
-static int gb_spi_unprepare_transfer_hardware(struct spi_master *master)
+static int gb_spi_unprepare_transfer_hardware(struct spi_controller *ctlr)
 {
-	struct gb_spilib *spi = spi_master_get_devdata(master);
+	struct gb_spilib *spi = spi_controller_get_devdata(ctlr);
 
 	spi->ops->unprepare_transfer_hardware(spi->parent);
 
@@ -440,7 +440,7 @@ static int gb_spi_get_master_config(struct gb_spilib *spi)
 
 static int gb_spi_setup_device(struct gb_spilib *spi, u8 cs)
 {
-	struct spi_master *master = get_master_from_spi(spi);
+	struct spi_controller *ctlr = get_controller_from_spi(spi);
 	struct gb_spi_device_config_request request;
 	struct gb_spi_device_config_response response;
 	struct spi_board_info spi_board = { {0} };
@@ -471,11 +471,11 @@ static int gb_spi_setup_device(struct gb_spilib *spi, u8 cs)
 		return -EINVAL;
 
 	spi_board.mode		= le16_to_cpu(response.mode);
-	spi_board.bus_num	= master->bus_num;
+	spi_board.bus_num	= ctlr->bus_num;
 	spi_board.chip_select	= cs;
 	spi_board.max_speed_hz	= le32_to_cpu(response.max_speed_hz);
 
-	spidev = spi_new_device(master, &spi_board);
+	spidev = spi_new_device(ctlr, &spi_board);
 	if (!spidev)
 		return -EINVAL;
 
@@ -486,52 +486,52 @@ int gb_spilib_master_init(struct gb_connection *connection, struct device *dev,
 			  struct spilib_ops *ops)
 {
 	struct gb_spilib *spi;
-	struct spi_master *master;
+	struct spi_controller *ctlr;
 	int ret;
 	u8 i;
 
 	/* Allocate master with space for data */
-	master = spi_alloc_master(dev, sizeof(*spi));
-	if (!master) {
+	ctlr = spi_alloc_master(dev, sizeof(*spi));
+	if (!ctlr) {
 		dev_err(dev, "cannot alloc SPI master\n");
 		return -ENOMEM;
 	}
 
-	spi = spi_master_get_devdata(master);
+	spi = spi_controller_get_devdata(ctlr);
 	spi->connection = connection;
-	gb_connection_set_data(connection, master);
+	gb_connection_set_data(connection, ctlr);
 	spi->parent = dev;
 	spi->ops = ops;
 
-	/* get master configuration */
+	/* get controller configuration */
 	ret = gb_spi_get_master_config(spi);
 	if (ret)
 		goto exit_spi_put;
 
-	master->bus_num = -1; /* Allow spi-core to allocate it dynamically */
-	master->num_chipselect = spi->num_chipselect;
-	master->mode_bits = spi->mode;
-	master->flags = spi->flags;
-	master->bits_per_word_mask = spi->bits_per_word_mask;
+	ctlr->bus_num = -1; /* Allow spi-core to allocate it dynamically */
+	ctlr->num_chipselect = spi->num_chipselect;
+	ctlr->mode_bits = spi->mode;
+	ctlr->flags = spi->flags;
+	ctlr->bits_per_word_mask = spi->bits_per_word_mask;
 
 	/* Attach methods */
-	master->cleanup = gb_spi_cleanup;
-	master->setup = gb_spi_setup;
-	master->transfer_one_message = gb_spi_transfer_one_message;
+	ctlr->cleanup = gb_spi_cleanup;
+	ctlr->setup = gb_spi_setup;
+	ctlr->transfer_one_message = gb_spi_transfer_one_message;
 
 	if (ops && ops->prepare_transfer_hardware) {
-		master->prepare_transfer_hardware =
+		ctlr->prepare_transfer_hardware =
 			gb_spi_prepare_transfer_hardware;
 	}
 
 	if (ops && ops->unprepare_transfer_hardware) {
-		master->unprepare_transfer_hardware =
+		ctlr->unprepare_transfer_hardware =
 			gb_spi_unprepare_transfer_hardware;
 	}
 
-	master->auto_runtime_pm = true;
+	ctlr->auto_runtime_pm = true;
 
-	ret = spi_register_master(master);
+	ret = spi_register_controller(ctlr);
 	if (ret < 0)
 		goto exit_spi_put;
 
@@ -548,12 +548,12 @@ int gb_spilib_master_init(struct gb_connection *connection, struct device *dev,
 	return 0;
 
 exit_spi_put:
-	spi_master_put(master);
+	spi_controller_put(ctlr);
 
 	return ret;
 
 exit_spi_unregister:
-	spi_unregister_master(master);
+	spi_unregister_controller(ctlr);
 
 	return ret;
 }
@@ -561,9 +561,9 @@ EXPORT_SYMBOL_GPL(gb_spilib_master_init);
 
 void gb_spilib_master_exit(struct gb_connection *connection)
 {
-	struct spi_master *master = gb_connection_get_data(connection);
+	struct spi_controller *ctlr = gb_connection_get_data(connection);
 
-	spi_unregister_master(master);
+	spi_unregister_controller(ctlr);
 }
 EXPORT_SYMBOL_GPL(gb_spilib_master_exit);
 
-- 
2.43.0


