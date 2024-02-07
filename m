Return-Path: <linux-kernel+bounces-56948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7684B84D1A6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A89231C2269C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D353B135A52;
	Wed,  7 Feb 2024 18:43:35 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9FD85281
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 18:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707331411; cv=none; b=QFvTqLE78frNptwtQaK4eFbw+9D8iDU9ZynGjx8fBG8w1F+4J9UTwdYGroheKXRU8wjp6+e5EAz+yszQt5kW3YlTaC06LvhPvgydxhFkt0vrX8Y2J6hDmw0NDuEhXN3b+pFDwxPccRakHyIqCGS1D1cvr3GjGFZHiOQHQ4ciVuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707331411; c=relaxed/simple;
	bh=Ev++aCx6/d1wDcv2MJFM1i0hfOpiN4a5Nl2m2PQoCTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gRGWxtwR6MAh0a4wg+IT6pkihwPQgAlxaWa6w31KpEpcWR+KHBzp0T2kvbkt7fKPjd2O1xnMcNBH3qqDm8nKI/KfYbE6V8DsHME/zcZty/ajCUewdDRb/t9dmNXxGPOhbtgskx7OFoXlbD3DSDOYNCkFGSc/t75+MZsAgsTmKVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmt6-0007ag-HB; Wed, 07 Feb 2024 19:43:12 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmt5-0054Xf-O1; Wed, 07 Feb 2024 19:43:11 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmt5-00HRsg-26;
	Wed, 07 Feb 2024 19:43:11 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 14/32] net: vertexcom: mse102x: Follow renaming of SPI "master" to "controller"
Date: Wed,  7 Feb 2024 19:40:28 +0100
Message-ID:  <feacee68c00f6f976c82864ba2f10a3f0c1b99f2.1707324794.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1148; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=Ev++aCx6/d1wDcv2MJFM1i0hfOpiN4a5Nl2m2PQoCTE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlw86lVfFyg9pBoMFRnaLT01mJvefY9M/ZVZrT8 YfKGChibRyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcPOpQAKCRCPgPtYfRL+ TuJJB/406hU4AmOMOAe9HQg+TMU8xoT78Kq/OjYU65U9i95ZrB/WZLlnQ4y2S+udBxYeBIQmRLh cjtIv3qTJk4a/fLnPaxMs2TweEcl0dFwopgw34Tw2OpQIwtXmehUR2/xBOoY4WUDhmryJPLJlCQ 3PuX9o/qTo59i10zvC/MPugL6KP6DvHCiflEik+pNqvDRlo8PXODoZDg1z6pMjYkHy67+YuZ48p m8wZlbqoLgW3/HdPEt53C86ahFMfgPFXBHj6LCYLCjRz7NsmbsbwrjT0usOd0MsqhvM7YaTWGpB SRgJbHAxvcJ/HqIbCTGH4a7FZQtvwQNj0jEyhM/UqP7eYeps
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
 drivers/net/ethernet/vertexcom/mse102x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/vertexcom/mse102x.c b/drivers/net/ethernet/vertexcom/mse102x.c
index aeed2a093e34..edd8b59680e5 100644
--- a/drivers/net/ethernet/vertexcom/mse102x.c
+++ b/drivers/net/ethernet/vertexcom/mse102x.c
@@ -664,7 +664,7 @@ static int mse102x_probe_spi(struct spi_device *spi)
 	spi->bits_per_word = 8;
 	spi->mode |= SPI_MODE_3;
 	/* enforce minimum speed to ensure device functionality */
-	spi->master->min_speed_hz = MIN_FREQ_HZ;
+	spi->controller->min_speed_hz = MIN_FREQ_HZ;
 
 	if (!spi->max_speed_hz)
 		spi->max_speed_hz = MAX_FREQ_HZ;
-- 
2.43.0


