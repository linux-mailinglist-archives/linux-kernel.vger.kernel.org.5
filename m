Return-Path: <linux-kernel+bounces-56937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2943A84D19B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC89BB2359C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DEC13341A;
	Wed,  7 Feb 2024 18:43:33 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16DA1272BE
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 18:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707331407; cv=none; b=hMKUntfi7GmY2pHIWl5RivN6SiIkEeUD0jTfBqK1Axvgju95LliPIKfESIH5WakLVHJ1eXy2RpquWqQlA1vH4AshE7HNrqH6hkJDlm6ERefF34X+MY88+RbdzV85aTc3t9eHPWXWBdSKJivE2Rq6tz0rCEoNTLTOoege2uzUPVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707331407; c=relaxed/simple;
	bh=w0zib0uOKooelRoLHu2pzWNfd/AGL8toKNMFBf38rNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tj5qBJokQikEfAAw1Xb+olf6xtb9Dw+C8v4E6f/5xPiRTpwU6T8qI28tzIHz3G22aEuj2dKkse6D9TI9iYX+O63v3UuqfoVmJ+IKfJZqG42WeXWvPnnfy/PHLqJKGbGtFXwD7zef9XXHF9k1UTELSDcJ/7sKlXHTOMhoTZEblgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmt4-0007PJ-4K; Wed, 07 Feb 2024 19:43:10 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmt2-0054X0-Gd; Wed, 07 Feb 2024 19:43:08 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmt2-00HRrx-1O;
	Wed, 07 Feb 2024 19:43:08 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/32] Input: pxspad - follow renaming of SPI "master" to "controller"
Date: Wed,  7 Feb 2024 19:40:18 +0100
Message-ID:  <820fa151077dc192391d546aec35328680803f9f.1707324794.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1193; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=w0zib0uOKooelRoLHu2pzWNfd/AGL8toKNMFBf38rNI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlw86a49NhPc2rBdHMRT3qom8TuhcSwM8PCc4D/ 75Kh/chVyGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcPOmgAKCRCPgPtYfRL+ TrW9CACPbeIOVyr466gklm2IUIKjis01iGt6HkKm4UnTUD26/My5rpTW49fL3c7R/KJj8/Kxip2 cxBHk044T0BvLB7BWatDCF9t2CUf1wMkAZ4q+UiZaYzIqu/W7+z7NzL3H4sBpsSsLE0EPbSC8Ll 5W7rraAbWwpk1ebzWzwMaEzObo9TbExVCsRMoENY0tW4pU+JJ6m8wtR0N2SaNGxWH+5w0jXdl+b atoBC/7q4zcVQsI86QGh3hB12MA5B0IiO8suyN/pVXFVDp/O0rb4F45F6nyUyZetfnhyPKZNYAE pL72XnTyhznJA60T6U5N/Bz1DoDZ1duK6hH7I9QcqLNUX4a5
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

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/input/joystick/psxpad-spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/joystick/psxpad-spi.c b/drivers/input/joystick/psxpad-spi.c
index de734a927b4d..c47fc5f34bd0 100644
--- a/drivers/input/joystick/psxpad-spi.c
+++ b/drivers/input/joystick/psxpad-spi.c
@@ -342,8 +342,8 @@ static int psxpad_spi_probe(struct spi_device *spi)
 	spi->mode = SPI_MODE_3;
 	spi->bits_per_word = 8;
 	/* (PlayStation 1/2 joypad might be possible works 250kHz/500kHz) */
-	spi->master->min_speed_hz = 125000;
-	spi->master->max_speed_hz = 125000;
+	spi->controller->min_speed_hz = 125000;
+	spi->controller->max_speed_hz = 125000;
 	spi_setup(spi);
 
 	/* pad settings */
-- 
2.43.0


