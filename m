Return-Path: <linux-kernel+bounces-33919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E684837036
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3BFF295E36
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04A160862;
	Mon, 22 Jan 2024 18:08:27 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCD260247
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 18:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946906; cv=none; b=NIcDazXzgSwp0L70mgxghkxd2U0+NBKiZSD7HSLp8uzqNGlCICR6Ju7TL1jSGcL2xwg/uBtlBio3eVxavpxKls2tl6GZ2Z7nj6gl7QgUjuhuIAleJ4Ou069uSVDj9m10XhNUxcbBevfwN6LLIYjJSPbMnXu/vMWM5AwOIzBrSRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946906; c=relaxed/simple;
	bh=8dv/wBsJwJ3/ohbuVOHTuYVGhoSkMc8iB3lWpL8EkJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pcBaH/fdeQD7z454h4k+kBjxUhXatt1lp3Rdvuz+RbxcvwkPIHSAYB/wgwhG7J21BCJtoJWFtTAqw4Gd18d2zDa057wovD/noR9cXLrxKttgqJbc7+Q5uDdLRtklMaiMS4XAobpRg3ARcdtgJnImTa+0vzhyuW4EH/khUxyldDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiV-0001p0-0K; Mon, 22 Jan 2024 19:08:15 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiU-001ePi-J9; Mon, 22 Jan 2024 19:08:14 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiU-005ZxJ-1f;
	Mon, 22 Jan 2024 19:08:14 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: [PATCH v2 09/33] media: v4l2-subdev: Follow renaming of SPI "master" to "controller"
Date: Mon, 22 Jan 2024 19:07:04 +0100
Message-ID:  <2fde98863c24e77ba9e50ce0acff7a849cbd194d.1705944943.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2489; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=8dv/wBsJwJ3/ohbuVOHTuYVGhoSkMc8iB3lWpL8EkJg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlrq7NWs6N/jG6Y+Y3QZwxTqvzpAW652qqqy0sh pm9E1vTc6yJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZa6uzQAKCRCPgPtYfRL+ Tg2nCACvoKfBZV0IsTey5o4twVKiWpo9THxbLbr3ENgWSOdukyg8msgQvbfGA7llDN7zSkr0WZp AO0zc/J7Zi5W3iqJGWTzKEtiYsojh4zy36VDhHIECR6frcvotthnfzK+/gYQURmW0wZFdHXGYjt dnDDOzgFGquDV1nu9sgN/+fGnutDwH/zXsuLbqzkXV2TvGZ6ocBwYHDInyfjg6pH+l9r+fh9ZVE WpnH010msNLfjjAvMK2jTti6yXGMqVthFThL/uxB2QRvdCcLaF0DbVbsV5wpXLXbSdfHvf0d6Vy K48aXRo/s7WuiUVOv8SYbY2dfCX5aZgio0sJEtq7S+nfMzV3
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
v4l2_spi_new_subdev().

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/media/v4l2-core/v4l2-spi.c | 4 ++--
 include/media/v4l2-common.h        | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-spi.c b/drivers/media/v4l2-core/v4l2-spi.c
index eadecdff7349..a7092c3930d6 100644
--- a/drivers/media/v4l2-core/v4l2-spi.c
+++ b/drivers/media/v4l2-core/v4l2-spi.c
@@ -34,7 +34,7 @@ void v4l2_spi_subdev_init(struct v4l2_subdev *sd, struct spi_device *spi,
 EXPORT_SYMBOL_GPL(v4l2_spi_subdev_init);
 
 struct v4l2_subdev *v4l2_spi_new_subdev(struct v4l2_device *v4l2_dev,
-					struct spi_master *master,
+					struct spi_controller *ctlr,
 					struct spi_board_info *info)
 {
 	struct v4l2_subdev *sd = NULL;
@@ -45,7 +45,7 @@ struct v4l2_subdev *v4l2_spi_new_subdev(struct v4l2_device *v4l2_dev,
 	if (info->modalias[0])
 		request_module(info->modalias);
 
-	spi = spi_new_device(master, info);
+	spi = spi_new_device(ctlr, info);
 
 	if (!spi || !spi->dev.driver)
 		goto error;
diff --git a/include/media/v4l2-common.h b/include/media/v4l2-common.h
index acf5be24a5ca..739b0f0fc1a0 100644
--- a/include/media/v4l2-common.h
+++ b/include/media/v4l2-common.h
@@ -278,13 +278,13 @@ static inline void v4l2_i2c_subdev_unregister(struct v4l2_subdev *sd)
  *
  *
  * @v4l2_dev: pointer to &struct v4l2_device.
- * @master: pointer to struct spi_master.
+ * @ctlr: pointer to struct spi_controller.
  * @info: pointer to struct spi_board_info.
  *
  * returns a &struct v4l2_subdev pointer.
  */
 struct v4l2_subdev *v4l2_spi_new_subdev(struct v4l2_device *v4l2_dev,
-		struct spi_master *master, struct spi_board_info *info);
+		struct spi_controller *ctlr, struct spi_board_info *info);
 
 /**
  * v4l2_spi_subdev_init - Initialize a v4l2_subdev with data from an
@@ -308,7 +308,7 @@ void v4l2_spi_subdev_unregister(struct v4l2_subdev *sd);
 
 static inline struct v4l2_subdev *
 v4l2_spi_new_subdev(struct v4l2_device *v4l2_dev,
-		    struct spi_master *master, struct spi_board_info *info)
+		    struct spi_controller *ctlr, struct spi_board_info *info)
 {
 	return NULL;
 }
-- 
2.43.0


