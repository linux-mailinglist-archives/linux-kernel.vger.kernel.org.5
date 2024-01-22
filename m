Return-Path: <linux-kernel+bounces-33937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 862288371B3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E578B2E084
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946BC63134;
	Mon, 22 Jan 2024 18:08:37 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B09612C1
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 18:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946915; cv=none; b=L3Vf1IRF5JYH3EnPgUKlQ6+3H+e5TYXirC2+BezyANMMBifKLmXbQF5+ehHDEsxB8bXyR5R4hWAwsNVEvoOlPB86rYwLGyatz6FGRjLmQnmFtRCR6Ixrz8xx3NAP5XQdZsJwfMReGcKVQLsDZ/i4t6XRLu9avvTX1aJ8UjEIlmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946915; c=relaxed/simple;
	bh=J5G8sNk8EOiCf1vT1VH2qoFSGlM7S/4V1Y+pnNGwgPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VUBtOrmXX/BeGc2uzif9k7o0VhI6Mt1EGoX0hSIStWK4q/eIlN3iRBCqJt4WXauOVlB5c3iUsVpcueFH7jNxwiT2DO2gE1ZBi/Y4a6USmkZ9yd6mJvANgkR+QT3y6oSHrWy3MtERL+XKO6N40JPjSOiqxHnOcLKYzs17b/GAOdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiW-0001rg-36; Mon, 22 Jan 2024 19:08:16 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiV-001eQ2-J1; Mon, 22 Jan 2024 19:08:15 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiV-005Zxd-1b;
	Mon, 22 Jan 2024 19:08:15 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ronald Wahl <ronald.wahl@raritan.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: [PATCH v2 14/33] net: ks8851: Follow renaming of SPI "master" to "controller"
Date: Mon, 22 Jan 2024 19:07:09 +0100
Message-ID:  <8fd38ae26985ad770b21979469b36e5afff0473a.1705944943.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1475; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=J5G8sNk8EOiCf1vT1VH2qoFSGlM7S/4V1Y+pnNGwgPk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlrq7T21kGgzgUSXStTOMt1lumvjV7wRCdpjd8j 2lNzDkK8uyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZa6u0wAKCRCPgPtYfRL+ Tqs/B/0U7IcHfVYiJyOo5g2gyk1I7tklQqpDglnCsNwWZyldX1WQAg87/+4JRL5VvMD3sOuLObU wOzcy9EzUaq31dmam8Ij3/wjiS9youm4NGNKvfFAJF1hvZvAN0Xytd6N6SbMdcYHpnCeLgRWyUE AvZmteteMvlopxMHDP0Xe71//iQLd1I+LznN+VRaMtDQKnQMZY59hKVL425t50FKKPh4tUMeXiv WOH1Ea/Cj1JrGlzBaxGTOgly/uK1Dw7jQxaRorukPj0RkFN0zpQauSfgumke13cAmYH1A+PnA2Q Tu8wfNU7dlNr/KnziNf0SQ5AdcEd5CEca8ae4Siq22a9QUew
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


