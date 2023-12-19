Return-Path: <linux-kernel+bounces-5665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA5F818DD6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1C151F27F22
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F9031755;
	Tue, 19 Dec 2023 17:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="bfismZTE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E278436AF7;
	Tue, 19 Dec 2023 17:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=xfb6kuDgKADdMzZzBWchLLnlFd6E5qjoWxtuwWK9Sxk=; b=bfismZTEkWG4Ih0UN0v1U5iSdR
	I6D5TQ4LYGpXeirp/GWIg4PAY9wNRxLtQFySR17aQnh5kq0s3PEU6SPugupj1/OOWiIxK6vc9jL6x
	N7J+/+kIKSEiaAfzEU0YeWn/wnoW9Tkl+ByzXzZ4ly0YLpiZTH93ol6SPz4yhi34Zuoo=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:40128 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rFdkO-0007Ao-PK; Tue, 19 Dec 2023 12:19:13 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	jringle@gridpoint.com,
	kubakici@wp.pl,
	phil@raspberrypi.org,
	bo.svangard@embeddedart.se
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 19 Dec 2023 12:18:50 -0500
Message-Id: <20231219171903.3530985-7-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231219171903.3530985-1-hugo@hugovil.com>
References: <20231219171903.3530985-1-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
Subject: [PATCH 06/18] serial: sc16is7xx: use spi_get_device_match_data()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Use preferred spi_get_device_match_data() instead of
device_get_match_data() and spi_get_device_id() to get the driver match
data.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/sc16is7xx.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 597280a5d0f3..8cbf54d0a16c 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1742,14 +1742,10 @@ static int sc16is7xx_spi_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	if (spi->dev.of_node) {
-		devtype = device_get_match_data(&spi->dev);
-		if (!devtype)
-			return -ENODEV;
-	} else {
-		const struct spi_device_id *id_entry = spi_get_device_id(spi);
-
-		devtype = (struct sc16is7xx_devtype *)id_entry->driver_data;
+	devtype = (struct sc16is7xx_devtype *)spi_get_device_match_data(spi);
+	if (!devtype) {
+		dev_err(&spi->dev, "Failed to match device\n");
+		return -ENODEV;
 	}
 
 	for (i = 0; i < devtype->nr_uart; i++) {
-- 
2.39.2


