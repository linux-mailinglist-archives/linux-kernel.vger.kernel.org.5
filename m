Return-Path: <linux-kernel+bounces-56923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7E984D16E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D18B81C25369
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9D584FD4;
	Wed,  7 Feb 2024 18:43:18 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0A782883
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 18:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707331398; cv=none; b=VMPx7+kpByiTWBvZcAaxJY0D0uqraMjuE31w9B+a/88E9K/bnChsNYdSZ9zwgcV+9nP5Jz9CnX/7J9xWeEZsSH3ML1qXnHmdKYNuXJGQxvG9o6QwxcamU84KkzFj6LX6zxJdghN2/98/eFNrneWxtJz66zRlzTEbl92bWUA/DuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707331398; c=relaxed/simple;
	bh=ISdH8w89RgoFeG4mw+w0XtCxZMCx6Ijs0xa+U6wuLM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V7e8j7BlnGPVnGpJb4djVn3clYg0LsrMBCDL//5ZHJ0BWsEtjtFY5M0Wh190A5mrHQ5l6j6ZkJHbgH1psaPlEOSjeJhU1OVJrQHFKu9unXrlDDxtGiwVDsB+OpjCeDfMPkZu4SFTaAmSUd+JHlncVo/KIlEhXQp29rED6eWNjEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmt4-0007Qk-Sj; Wed, 07 Feb 2024 19:43:10 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmt4-0054XQ-G3; Wed, 07 Feb 2024 19:43:10 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmt4-00HRsL-1K;
	Wed, 07 Feb 2024 19:43:10 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 10/32] misc: gehc-achc: Follow renaming of SPI "master" to "controller"
Date: Wed,  7 Feb 2024 19:40:24 +0100
Message-ID:  <3c93bf41d2399d06b5a379a76c8f6e877f3560b7.1707324794.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1646; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=ISdH8w89RgoFeG4mw+w0XtCxZMCx6Ijs0xa+U6wuLM4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlw86hQkaBkuFTlFDYTUPSXZKwC7XJB4U1RkwxD /64HwYu55eJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcPOoQAKCRCPgPtYfRL+ Tg5RB/4ji79EENz4deLH5Q76yZhhYsQ9eDPTGWfeEzPgkxTu3IOw+T48nZ6I84b0W0ierBRekQ4 fOx1DqZaTZnZEHoD+YQvZqPh+L8pUgQGsSv9h9mrVR4GMoAEo5746xSOb4TGC6eR3w3O06pGdpf Wb5xOQ2eblckz/NQ3P5s1OOH892/0EShPR3hppQhNXTQ9mutnD7ivHuZ4MaoaV41mrRs/yCGRQ3 40a9vjgD76bZMlsCPwLkjdOqwIR1DIC68O1Dj3fWnTa1E0RxX93QshQSBbh8DBgwYah84vb7/OC SdjIS/4RkrrNdIjyVwOiVEoCJLB9bwbK207HpxWijqc9ZuMT
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

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/misc/gehc-achc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/gehc-achc.c b/drivers/misc/gehc-achc.c
index 4c9c5394da6f..b8fca4d393c6 100644
--- a/drivers/misc/gehc-achc.c
+++ b/drivers/misc/gehc-achc.c
@@ -65,7 +65,7 @@ static int ezport_start_programming(struct spi_device *spi, struct gpio_desc *re
 	struct spi_transfer release_cs = { };
 	int ret;
 
-	spi_bus_lock(spi->master);
+	spi_bus_lock(spi->controller);
 
 	/* assert chip select */
 	spi_message_init(&msg);
@@ -85,16 +85,16 @@ static int ezport_start_programming(struct spi_device *spi, struct gpio_desc *re
 	ret = spi_sync_locked(spi, &msg);
 
 fail:
-	spi_bus_unlock(spi->master);
+	spi_bus_unlock(spi->controller);
 	return ret;
 }
 
 static void ezport_stop_programming(struct spi_device *spi, struct gpio_desc *reset)
 {
 	/* reset without asserted chip select to return into normal mode */
-	spi_bus_lock(spi->master);
+	spi_bus_lock(spi->controller);
 	ezport_reset(reset);
-	spi_bus_unlock(spi->master);
+	spi_bus_unlock(spi->controller);
 }
 
 static int ezport_get_status_register(struct spi_device *spi)
-- 
2.43.0


