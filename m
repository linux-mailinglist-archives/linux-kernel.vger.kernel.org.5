Return-Path: <linux-kernel+bounces-33929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B11AC83703E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 661931F252F3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6916612E4;
	Mon, 22 Jan 2024 18:08:33 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D125605C6
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 18:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946912; cv=none; b=birtQB3N4DeafQtUaDmDUgq1pcyDcEd+HBehcYsTv+iLdV6eI0xcAczYRnbGL4Qwzt3GW6cUxPw8mHutyccus/RBgnmNqkSXaAkgpF8mCRtpYv6d5NwGgaMJa6/NGzTDnBw37LvCVEveDdogVlVkhvDIaERe+8RQqWIhjYzHSec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946912; c=relaxed/simple;
	bh=2MA+sC/rCpHKdoPmG382ChumO+RJ0JKIPBE41/vRIrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WJdhbmvjfIQGT1AeFEq2iWyBbMhF/lcE7hxQFGO/LSysNHSK1RzZjatQ0MkXTf2pUUi+mFGAiJ9R6QFSCUdKXfLsIvDlyA3Az4DRGQTo7d9tqGwnL68/seAT0K24abHRn4gWE7+88kaS+VkXSvxvGbIsdu/2opGoByg5C4VsLYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiW-0001s7-H7; Mon, 22 Jan 2024 19:08:16 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiW-001eQB-21; Mon, 22 Jan 2024 19:08:16 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiV-005Zxl-39;
	Mon, 22 Jan 2024 19:08:15 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: [PATCH v2 16/33] platform/chrome: cros_ec_spi: Follow renaming of SPI "master" to "controller"
Date: Mon, 22 Jan 2024 19:07:11 +0100
Message-ID:  <0ba199703663e8afb7f2393e2f1ec6d634bf01c2.1705944943.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1841; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=2MA+sC/rCpHKdoPmG382ChumO+RJ0JKIPBE41/vRIrM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlrq7VgUJLFErdtr+/VLqw0eTk/jpgdi6VSzbWL PFsL6pouYKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZa6u1QAKCRCPgPtYfRL+ Tr/mCACWHKMmC1uSU0J2K1epNBzQ0q9FJw8FZbPiT3ixkghgXaoyysxsJwWaZIyEwhxBdwo97Oy uqZj1QmS9k3LaXLXN4Qo2UPPp0tu+iRvul5WJNNVGk9d7UNZOtnHoCIIBAyLAW1b8tu5aH8xXFA Y7ZZymUURdVwpmH3PGluhEtu8/sDGd6oP5yOeMN9FA/ivoJF5RzWgFsUEZPvqJLHIaUu9atE+NQ T0SGLYwlYBuUZEfpKtmbCATRQj2XOght2TqM4t6hwmcMYRh7Nv9YJ/zC3Y3suWbwQQftc/dvdXQ n8cgJD9wAo27dK7qvzDfrPpe5r1b9dP0HzRqHK0OtumYq9aA
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

Acked-by: Tzung-Bi Shih <tzungbi@kernel.org>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/platform/chrome/cros_ec_spi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
index 3e88cc92e819..86a3d32a7763 100644
--- a/drivers/platform/chrome/cros_ec_spi.c
+++ b/drivers/platform/chrome/cros_ec_spi.c
@@ -409,7 +409,7 @@ static int do_cros_ec_pkt_xfer_spi(struct cros_ec_device *ec_dev,
 	if (!rx_buf)
 		return -ENOMEM;
 
-	spi_bus_lock(ec_spi->spi->master);
+	spi_bus_lock(ec_spi->spi->controller);
 
 	/*
 	 * Leave a gap between CS assertion and clocking of data to allow the
@@ -469,7 +469,7 @@ static int do_cros_ec_pkt_xfer_spi(struct cros_ec_device *ec_dev,
 
 	final_ret = terminate_request(ec_dev);
 
-	spi_bus_unlock(ec_spi->spi->master);
+	spi_bus_unlock(ec_spi->spi->controller);
 
 	if (!ret)
 		ret = final_ret;
@@ -554,7 +554,7 @@ static int do_cros_ec_cmd_xfer_spi(struct cros_ec_device *ec_dev,
 	if (!rx_buf)
 		return -ENOMEM;
 
-	spi_bus_lock(ec_spi->spi->master);
+	spi_bus_lock(ec_spi->spi->controller);
 
 	/* Transmit phase - send our message */
 	debug_packet(ec_dev->dev, "out", ec_dev->dout, len);
@@ -590,7 +590,7 @@ static int do_cros_ec_cmd_xfer_spi(struct cros_ec_device *ec_dev,
 
 	final_ret = terminate_request(ec_dev);
 
-	spi_bus_unlock(ec_spi->spi->master);
+	spi_bus_unlock(ec_spi->spi->controller);
 
 	if (!ret)
 		ret = final_ret;
-- 
2.43.0


