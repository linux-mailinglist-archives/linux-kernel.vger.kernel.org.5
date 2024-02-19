Return-Path: <linux-kernel+bounces-71162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E02285A17F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF9AA281836
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C371C28E2B;
	Mon, 19 Feb 2024 10:59:41 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F20F28DD1
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 10:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708340381; cv=none; b=afFaqVSEHUYr0CzYdT7f+fEbLxzRxEjBqrTbSB1I3rCZTrfRz4ShQL9sn8k2q3Ma1xSfkDlhjiXEwhiZM5AJ7DuOJYNnD5uaPE3KAWdNWTpS7HiJ9/eEluGnZjW5WWPluU0k3X2C9f+qkNuR0ATQdhRMZecGkofjQEXK2ni6+7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708340381; c=relaxed/simple;
	bh=00egCWTf/Xz90viScRQeUZaKnDU/N7KFipBuJnl8Wp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e187HLA7PJ5tNfvNJ5vsbbgNBvskQBzj9mT34F/f/Vm6xZzRU1UUYuWFpAfdAW5+/gOmjCUFV5lXnDXe+zOsUvKV/E4xo6WD4qsKvSXjF+PSC3fW6CA4yrHH2CxltclPj1grqnTtGXPG+Yj8EL1nbuJuGbCFC4kr59LzJo8lGRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rc1N2-0007tT-JA; Mon, 19 Feb 2024 11:59:36 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rc1N2-001dBG-6F; Mon, 19 Feb 2024 11:59:36 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rc1N2-007lm9-0N;
	Mon, 19 Feb 2024 11:59:36 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: kernel@pengutronix.de,
	Rob Herring <robh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] w1: w1-gpio: Convert to platform remove callback returning void
Date: Mon, 19 Feb 2024 11:59:30 +0100
Message-ID:  <bd69ccde7395cf4bf63765e29c1ce83834d3669b.1708340114.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1708340114.git.u.kleine-koenig@pengutronix.de>
References: <cover.1708340114.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1873; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=00egCWTf/Xz90viScRQeUZaKnDU/N7KFipBuJnl8Wp8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl0zSTrq456IYWTjU+KXkxkmXQkNFMCKWgFxPeF 73xd2/n6FKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZdM0kwAKCRCPgPtYfRL+ TkKdB/9Nux88D/xvqCPsFwszanxBm2bILV18T4Ub+x9ms/hcYEGQUHyWyiPA1+6ByDeIKJaoR9T Uf63vNWNwVoKavgzTS6VssxsHw9EN41Xg9ftCbvwNTMgPtkUbop0uyuRQTAbNIrRQ0TKKyLUeMV ZXWahZ+BVxAEATso9pWa4sDt5DzzoohY+q1UKYXP2bxA4/3K+l1FNVUDcBWsexPl2RtpyibuBTj Ds6qsQHc0ngNXgbBwMR8zMS6xe5XbVdl9x5IoR5NOCdzasu5wVmFdo429TFwGyE7KFx5RC2Hgsl SbzekQjXrg7aXDor58e4YNb45qbQWxrQXMrFKlBaDeTcZiIC
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.

To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/w1/masters/w1-gpio.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/w1/masters/w1-gpio.c b/drivers/w1/masters/w1-gpio.c
index 05c67038ed20..34128e6bbbfa 100644
--- a/drivers/w1/masters/w1-gpio.c
+++ b/drivers/w1/masters/w1-gpio.c
@@ -141,7 +141,7 @@ static int w1_gpio_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int w1_gpio_remove(struct platform_device *pdev)
+static void w1_gpio_remove(struct platform_device *pdev)
 {
 	struct w1_bus_master *master = platform_get_drvdata(pdev);
 	struct w1_gpio_ddata *ddata = master->data;
@@ -150,8 +150,6 @@ static int w1_gpio_remove(struct platform_device *pdev)
 		gpiod_set_value(ddata->pullup_gpiod, 0);
 
 	w1_remove_master_device(master);
-
-	return 0;
 }
 
 static struct platform_driver w1_gpio_driver = {
@@ -160,7 +158,7 @@ static struct platform_driver w1_gpio_driver = {
 		.of_match_table = of_match_ptr(w1_gpio_dt_ids),
 	},
 	.probe = w1_gpio_probe,
-	.remove = w1_gpio_remove,
+	.remove_new = w1_gpio_remove,
 };
 
 module_platform_driver(w1_gpio_driver);
-- 
2.43.0


