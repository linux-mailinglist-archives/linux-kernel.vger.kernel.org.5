Return-Path: <linux-kernel+bounces-33913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6DC837235
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DA10B3829B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428F360265;
	Mon, 22 Jan 2024 18:08:25 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9E356470
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 18:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946904; cv=none; b=QWQKTbRqv7QyVMonc4N6uYLg0PNFkaOaO4c2e+uyyHVbe1n4pTVidbnjdccM+lyifOmMKI/zdgGqZ6XmsBSapgcCSLf4FBjoDrtciz4bxutJMLzAzafKpZPFEv5/6cmesK9nCL9FWY434KcW0RBbqQ6UJ6JSpUwTVLn4NE34pps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946904; c=relaxed/simple;
	bh=5kp3Ks9t2Ea2aSTspz0TdIMs+rWMHy3IGA7GHyomVFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BEmeIsQyh8IirhJ7UNcOAi5uGBKM6Gj9hEwhjTRT8xKzMwXwIdvamdYfAPKrbWLudNDTyYh4EbijjbducDpFuFIa4kqoOBVmGnx6vtsyLgFMpkW6BJOhDwOKCuBxL5R9+3UJaFLFpf7lSwCytMM7W0LB38DqDDniHAeQNe6YeHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiU-0001lr-V1; Mon, 22 Jan 2024 19:08:14 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiT-001ePX-Ue; Mon, 22 Jan 2024 19:08:13 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiT-005Zx7-2o;
	Mon, 22 Jan 2024 19:08:13 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de,
	Martin Tuma <martin.tuma@digiteqautomotive.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: [PATCH v2 06/33] media: mgb4: Follow renaming of SPI "master" to "controller"
Date: Mon, 22 Jan 2024 19:07:01 +0100
Message-ID:  <250ee63915ba9989bab180200ad2d552e1a765a9.1705944943.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2411; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=5kp3Ks9t2Ea2aSTspz0TdIMs+rWMHy3IGA7GHyomVFQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlrq7J1k1XKFTBqaic+XhNlH2OrYCv6WMwqGDjG Emt161au92JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZa6uyQAKCRCPgPtYfRL+ TsYoCACT5+MRbues0ycMQqOGK5MIggyAH9tHi/k/T6TzPkQVDfrm/BcZviCRR2CHptqBQcspWda ib0cCWTR+klniVi2LzgMs/bilyahlav/ceotu3T2n+KNCUM/DOQT3dlXWx5R4LNeS3dWyHHqjlj 89rdMwT4vk7L23lmUfEb5DGFuJDCPN8SGZgbas1XJciQ8ulKy8L51GS5zyGUf1ex9/jlp4FqR/Y 2cbaP6kQPhWwueHyHRLctaL/Oy/93S9UiwKhWcjWlkFPRO7xhXmaNhqSYImDaTuUI24BxrgAu+P gvv5tJZAkOZIkJEuE/EuLlKg362SaGXP/lsbX2Fanwlw5GVj
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

Reviewed-by: Martin Tůma <martin.tuma@digiteqautomotive.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/media/pci/mgb4/mgb4_core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/media/pci/mgb4/mgb4_core.c b/drivers/media/pci/mgb4/mgb4_core.c
index 5bfb8a06202e..9bcf10a77fd3 100644
--- a/drivers/media/pci/mgb4/mgb4_core.c
+++ b/drivers/media/pci/mgb4/mgb4_core.c
@@ -144,7 +144,7 @@ static int match_spi_adap(struct device *dev, void *data)
 	return to_spi_device(dev) ? 1 : 0;
 }
 
-static struct spi_master *get_spi_adap(struct platform_device *pdev)
+static struct spi_controller *get_spi_adap(struct platform_device *pdev)
 {
 	struct device *dev;
 
@@ -152,7 +152,7 @@ static struct spi_master *get_spi_adap(struct platform_device *pdev)
 	dev = device_find_child(&pdev->dev, NULL, match_spi_adap);
 	mutex_unlock(&pdev->dev.mutex);
 
-	return dev ? container_of(dev, struct spi_master, dev) : NULL;
+	return dev ? container_of(dev, struct spi_controller, dev) : NULL;
 }
 
 static int init_spi(struct mgb4_dev *mgbdev, u32 devid)
@@ -179,7 +179,7 @@ static int init_spi(struct mgb4_dev *mgbdev, u32 devid)
 	};
 	struct pci_dev *pdev = mgbdev->pdev;
 	struct device *dev = &pdev->dev;
-	struct spi_master *master;
+	struct spi_controller *ctlr;
 	struct spi_device *spi_dev;
 	u32 irq;
 	int rv, id;
@@ -207,8 +207,8 @@ static int init_spi(struct mgb4_dev *mgbdev, u32 devid)
 		return PTR_ERR(mgbdev->spi_pdev);
 	}
 
-	master = get_spi_adap(mgbdev->spi_pdev);
-	if (!master) {
+	ctlr = get_spi_adap(mgbdev->spi_pdev);
+	if (!ctlr) {
 		dev_err(dev, "failed to get SPI adapter\n");
 		rv = -EINVAL;
 		goto err_pdev;
@@ -242,8 +242,8 @@ static int init_spi(struct mgb4_dev *mgbdev, u32 devid)
 
 	spi_info.platform_data = &mgbdev->flash_data;
 
-	spi_dev = spi_new_device(master, &spi_info);
-	put_device(&master->dev);
+	spi_dev = spi_new_device(ctlr, &spi_info);
+	put_device(&ctlr->dev);
 	if (!spi_dev) {
 		dev_err(dev, "failed to create MTD device\n");
 		rv = -EINVAL;
-- 
2.43.0


