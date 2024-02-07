Return-Path: <linux-kernel+bounces-56940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9007F84D199
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1F9E1C24FEB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB5E12CD90;
	Wed,  7 Feb 2024 18:43:33 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57942128814
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 18:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707331407; cv=none; b=MlSDkJMEHg74+XhRgrR5hptpNotgzQU5tQMSJ6FXDCVBZY+BhRnM+O8T/OIU5V0VrPHa1tugjFIWKfURCzZaVxkQAZLcjAhXYZiX35XsZZ7Gh+VJ7cE6+DeA1Jz26Re4bY1hwr4Sznp5/07lQdPEayuaHOFsWXEVO/Bryoin2JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707331407; c=relaxed/simple;
	bh=KaJJ8quxzgWB8y4pMleISYyM1DKK7MkNdnVgj/kZgVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r5uAancIVGZLx9kD0J3YvDd9NfEm6915gzVihxiAiu8EjFiSiMu8OmWC//5Il3f/g6rYLi2t4hSWc/LdNHxtgt6kJvfB6iAA37crC4bPhNpkj6lt5eeLFFqgijvxuJ0m+3ZdIKGjiF10f0aoZveTkvVAooE3hsSnS8fXd9Fc5Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmt4-0007Q6-Fs; Wed, 07 Feb 2024 19:43:10 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmt4-0054XF-1x; Wed, 07 Feb 2024 19:43:10 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmt3-00HRsH-39;
	Wed, 07 Feb 2024 19:43:09 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/32] media: v4l2-subdev: Follow renaming of SPI "master" to "controller"
Date: Wed,  7 Feb 2024 19:40:23 +0100
Message-ID:  <b6e3a53ce75dfb8a21a5958a381070944dfa0875.1707324794.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2547; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=KaJJ8quxzgWB8y4pMleISYyM1DKK7MkNdnVgj/kZgVA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlw86g3V4NkM5t2iVxQniw0e6ww0L3UTrUHmKhS K0i3JBODmeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcPOoAAKCRCPgPtYfRL+ TmxbCACLR1jKX4MTNh5obO5h8YAhLVtwd1uz529v9zFqG4CpBWY3FG8foiklJOZbMNrBvF/CH6I +i4pKx16oVdeywvHnv8/Bnzww8mM1NlfwKf2LB4pVDmnD+6k4dE8eEeyHUQG226ZaeQNil4oW4G MmsR40iwY+soe7R2jsuOZ7drdmwGQDM/tI4y/szddPv4BjtL0iN7PI/nvguOiPVgqwJs0GUOflJ cKnL5E4zrb5JI8otzRQsJydgbtcZmOlTpMALeuQKLBgB3FJK9So/HtSfopdS7tP1+eieUeq/Qi+ cwo31VIPZJr2/DqJK1L08aOtXXmrBAnVofKaZ5E/oZADrQwJ
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

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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


