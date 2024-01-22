Return-Path: <linux-kernel+bounces-33943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E93F837072
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF6941C2939F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733A2651BA;
	Mon, 22 Jan 2024 18:08:41 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0F4634FF
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 18:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946920; cv=none; b=qTdDeUVniLf3jde3ucprkwr/kglkLa4palPm/tXnMHuhlBOZofxJYhDSlGxi+kUv5qQ2dSdO7quRNZT1k7gpLFiryTTTq9b9GoCZ1fK6C+em0nUlFDG3LZ/roGxgaRUJlVvnXncBTeQlFlPPjiToEbms1ekyjEvGa/Tz891A0F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946920; c=relaxed/simple;
	bh=J3Kg6Pne81WC2uyFntZ9I84SGrw3wcOXoVXD9oa+W64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uz/AyaHeaA7zIEg5zxRmpbvzUOpqEpZGgqIPoV5yqDaw3SU/hCT1xKTDqw2UTwo65ZJBkmxD/zdkJwTCrG7Hh3LX8xMVmP4j717+CjXK1ZVxQPjbHX5AlRXj6rzL2+hz0NNHyKn4sDV1ix3Csee0jgAdsyX36hjJ4PTv7s6zW7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiZ-00025v-7J; Mon, 22 Jan 2024 19:08:19 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiY-001eQx-Fe; Mon, 22 Jan 2024 19:08:18 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiY-005Zyh-1G;
	Mon, 22 Jan 2024 19:08:18 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Rob Herring <robh@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: [PATCH v2 28/33] usb: gadget: max3420_udc: Follow renaming of SPI "master" to "controller"
Date: Mon, 22 Jan 2024 19:07:23 +0100
Message-ID:  <f2a5160a4153b1b0f90bb3f84adc57e035d3da8d.1705944943.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1038; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=J3Kg6Pne81WC2uyFntZ9I84SGrw3wcOXoVXD9oa+W64=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlrq7kW5khjsMXVuni4K5pmatgAOShUKnb79I+b YnyDvvmJHWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZa6u5AAKCRCPgPtYfRL+ ToUvB/9IR2NnLJS9QkKTZgZnR9AzyxhGIpSQZvr5YdgoAKY7vLJDVUqu6TPNvCcfG57tbbqwt/R 5NU+9tjWJyjIQZ6FCsGqj8u+k93qQIhkAQd8i68TisRhmq3v9sjnThjVafy/PpdShCOWYhyD2rm CKmy/q7cvVxr3GbDYKIbXlcW3eXSa/qBI0Dzx6mE2jGyXbwDzuPutFvLwDnr+P3HSqvWsYyxoua qkhuDNw+exogil4cd0XzDu0fSCnARb66WXxfrF4qFAdq9Bc1Jj7F+HtiaugiBmKrpkfKkzMzNBN 5nTWv2LFS23YMT2yypWQ/9ro2Ly0K2NcE5/I8Me5XgWCHL15
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

Reviewed-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/usb/gadget/udc/max3420_udc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/max3420_udc.c b/drivers/usb/gadget/udc/max3420_udc.c
index 89e8cf2a2a7d..7349ea774adf 100644
--- a/drivers/usb/gadget/udc/max3420_udc.c
+++ b/drivers/usb/gadget/udc/max3420_udc.c
@@ -1201,7 +1201,7 @@ static int max3420_probe(struct spi_device *spi)
 	int err, irq;
 	u8 reg[8];
 
-	if (spi->master->flags & SPI_CONTROLLER_HALF_DUPLEX) {
+	if (spi->controller->flags & SPI_CONTROLLER_HALF_DUPLEX) {
 		dev_err(&spi->dev, "UDC needs full duplex to work\n");
 		return -EINVAL;
 	}
-- 
2.43.0


