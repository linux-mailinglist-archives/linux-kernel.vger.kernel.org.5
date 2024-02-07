Return-Path: <linux-kernel+bounces-56952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6C684D1AD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42BE828C94B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94A9136989;
	Wed,  7 Feb 2024 18:43:36 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDB212F5A1
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 18:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707331414; cv=none; b=WicPBoRZMFQifTyeQz4XyG6zDPtVE3BNC/KJRIcc2CNcdtlmn/PeRWyiwD+MHNOMaza7MO2fBbA7puDhHdyrB2JMMD9MGivI5gMFSTxmMmluKIlWfePk4HEELKnigGfl9pqnYhvobGoveGTJW2WKxyj+hI7iFL2G8ZIcRedcr40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707331414; c=relaxed/simple;
	bh=jLSDSfpv7WSEI2jePythvXMi4bwtOGfFN61uJJKBvR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YxPpDCh8ripNT69FHvLkSiHbQYUMEhe2eMc/S5Au2AWBVVMAHbURg6aRGPOFLF9mb1FlnxwzX7YKg3qCXYYH8uiehV14P3xHFogRHLrbUjNqlXnXrb/gz2wT+YF7lVg6dbz0lEVWkXrSjR8JJrUGhSrLKReaWXp1NAA+iPPxqtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmtC-0007se-3M; Wed, 07 Feb 2024 19:43:18 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmtB-0054YL-A0; Wed, 07 Feb 2024 19:43:17 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmtB-00HRtR-0h;
	Wed, 07 Feb 2024 19:43:17 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 24/32] staging: fbtft: Follow renaming of SPI "master" to "controller"
Date: Wed,  7 Feb 2024 19:40:38 +0100
Message-ID:  <df79f22caf31d2c5ca2b15b33670323d1e1120c7.1707324794.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1645; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=jLSDSfpv7WSEI2jePythvXMi4bwtOGfFN61uJJKBvR4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlw87GXqnqC9di7ObQ9f5f86SeO9J8OHbB6IyeF M0/bFpSbpmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcPOxgAKCRCPgPtYfRL+ TuGBB/9TlS6oRq9gEfvRb9gRhMiLfLJhtlORbYI0ifh40f/j0hyzeyZynD3Fq61MCA25AK4L1oL bUEmiFI9dkmdpl/wxEeoFDRn3uUORsjdca5iTgkJ61wtS+nHjVGel9Itd+lMwVfVKjEOurt1mc2 QFyyRLeIt5WqYZhtg25+BcZnHayunBMMYQgFCPVv9FsauTTBQwpUJWl3B7rEoPfzPJENssYMRIO MwvUqvxZfVtdIDlV5jpwCkzw7dgKr6qQECrj/iiev9zmuIJrkYjPKc/Kd1fQwnxbdkopXRbpvns dBa9kOZixjMojyHMla3Xgcm7uqCKemj6XZLqGQIuEbIj7IhH
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
 drivers/staging/fbtft/fbtft-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index 3626f429b002..68add4d598ae 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -794,7 +794,7 @@ int fbtft_register_framebuffer(struct fb_info *fb_info)
 	if (par->txbuf.buf && par->txbuf.len >= 1024)
 		sprintf(text1, ", %zu KiB buffer memory", par->txbuf.len >> 10);
 	if (spi)
-		sprintf(text2, ", spi%d.%d at %d MHz", spi->master->bus_num,
+		sprintf(text2, ", spi%d.%d at %d MHz", spi->controller->bus_num,
 			spi_get_chipselect(spi, 0), spi->max_speed_hz / 1000000);
 	dev_info(fb_info->dev,
 		 "%s frame buffer, %dx%d, %d KiB video memory%s, fps=%lu%s\n",
@@ -1215,7 +1215,7 @@ int fbtft_probe_common(struct fbtft_display *display,
 
 	/* 9-bit SPI setup */
 	if (par->spi && display->buswidth == 9) {
-		if (par->spi->master->bits_per_word_mask & SPI_BPW_MASK(9)) {
+		if (par->spi->controller->bits_per_word_mask & SPI_BPW_MASK(9)) {
 			par->spi->bits_per_word = 9;
 		} else {
 			dev_warn(&par->spi->dev,
-- 
2.43.0


