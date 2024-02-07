Return-Path: <linux-kernel+bounces-56942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF65284D19D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79998284A96
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCC11339B8;
	Wed,  7 Feb 2024 18:43:33 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F7B85C64
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 18:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707331409; cv=none; b=ciAMmIlQNX/ra8kCoWKi26VPIcTvd4gwlQ5qBTVEPHFFtleRS1+HfcFUcPWh1jEfmsBbAc4eVLj25qBqwYHIGpNvLEguQOZjKeQolblDH/CU5nmiT/VdG558+1oqaWDS6MHZBWcHYrwRfJoyUCFQybod9hUG7V+HlcuJqmWA9G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707331409; c=relaxed/simple;
	bh=mdwBi3Gt1cG0DX3WTfBzo1jaCcILClmPsuQWChC91NE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fmcg8+oiv2Qii7pQ13JPzFFKRq8tIEFlqk3RZO+j9KaeZ5dg1HqamNm6qexblfvZlNU3wKW855LnLVXnjA3LmBptps9a1O8TnXLOauMBaQsEiE/cpb+i6U31t6GV6HuI5XkGUzoARfTGhMkUYN5o4Dic8YYZVua2UcQW7xScbxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmt6-0007Wx-GE; Wed, 07 Feb 2024 19:43:12 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmt5-0054Xb-Cj; Wed, 07 Feb 2024 19:43:11 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmt5-00HRsc-0y;
	Wed, 07 Feb 2024 19:43:11 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Ronald Wahl <ronald.wahl@raritan.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 13/32] net: ks8851: Follow renaming of SPI "master" to "controller"
Date: Wed,  7 Feb 2024 19:40:27 +0100
Message-ID:  <4f26761c0c86072a084b2a20439da1d0a681b07b.1707324794.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1533; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=mdwBi3Gt1cG0DX3WTfBzo1jaCcILClmPsuQWChC91NE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlw86k9EqMmy0LbIMCuyFFQLhB3tqOih4LKdVNG KI/UOAY1haJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcPOpAAKCRCPgPtYfRL+ TmPxCACuusIwJoxvplewh7tp3xA8zp7Nt5arOfpSCDlr/xJ1JEFphV0FPRqpAvK5njlV8tTO7KG tB++GQjC/ToR8xZnCJj0+RTaGeLmXSaXjPwntEbITXOxfos/M68s6pEBVqcYwuBmfS4fSuICzTI iT6j4fT+Trobv2m/4azGbhXodf1oHuafhIasTvNM1tfonTjmW4o1xlF4Se1frJ240DBo5CQw2jf Eujd0cnILh6sVaOMV+4dMXeHD+FsJS0eDLYQF9ulAg5F1Tg/kr7JlgxJWGoGWpevE3Z+EevjJUz jIlZ5H6BNDeCYipiLNRcehw+tWIvmUadOkbqG2bI2AmkaCZQ
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

Reviewed-by: Simon Horman <horms@kernel.org>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/net/ethernet/micrel/ks8851_spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/micrel/ks8851_spi.c b/drivers/net/ethernet/micrel/ks8851_spi.c
index 54f2eac11a63..2f803377c9f9 100644
--- a/drivers/net/ethernet/micrel/ks8851_spi.c
+++ b/drivers/net/ethernet/micrel/ks8851_spi.c
@@ -156,7 +156,7 @@ static void ks8851_rdreg(struct ks8851_net *ks, unsigned int op,
 
 	txb[0] = cpu_to_le16(op | KS_SPIOP_RD);
 
-	if (kss->spidev->master->flags & SPI_CONTROLLER_HALF_DUPLEX) {
+	if (kss->spidev->controller->flags & SPI_CONTROLLER_HALF_DUPLEX) {
 		msg = &kss->spi_msg2;
 		xfer = kss->spi_xfer2;
 
@@ -180,7 +180,7 @@ static void ks8851_rdreg(struct ks8851_net *ks, unsigned int op,
 	ret = spi_sync(kss->spidev, msg);
 	if (ret < 0)
 		netdev_err(ks->netdev, "read: spi_sync() failed\n");
-	else if (kss->spidev->master->flags & SPI_CONTROLLER_HALF_DUPLEX)
+	else if (kss->spidev->controller->flags & SPI_CONTROLLER_HALF_DUPLEX)
 		memcpy(rxb, trx, rxl);
 	else
 		memcpy(rxb, trx + 2, rxl);
-- 
2.43.0


