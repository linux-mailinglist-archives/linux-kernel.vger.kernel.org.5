Return-Path: <linux-kernel+bounces-56935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B3284D196
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0E8A1F22AB5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96A3132C1E;
	Wed,  7 Feb 2024 18:43:33 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBD9127B55
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 18:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707331406; cv=none; b=E2eu99A0AsZ7PnvMuOcTdR6it/izNVgojZM9jbWXyzoPr7kXYGdwst3RbgSCE5+uTXhWpt+mfZAf9ArrNWnXqnpUfpv3KrynI66JOUWAP2SG5QjgObaGk3y2pNTTyZg07hulvMrRVBpok57ZC7IC0GfIcQerTOXRvA5DSHlu/zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707331406; c=relaxed/simple;
	bh=jhiShNIsUFW7WZuiPMMO9tp0A0zw/Nl6K1uMEilFM+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VKcpPcqiIOmimvciCli6bEE+BGMwJOBmhDjNmKsRkWn8RNrw3yvA/RjpEpzbA1mqukNF6tFjIz6IoJ4ImIqVD/DSfOTC1z8SvemK9anbclOARVqBDFnXC1Omq3jvZ5Ombc/imQ97BbbMGGkUrGRcwBT5E82ArjmtVCTn5uPSRmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmt4-0007PH-4K; Wed, 07 Feb 2024 19:43:10 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmt1-0054Wu-TG; Wed, 07 Feb 2024 19:43:07 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmt1-00HRrp-2b;
	Wed, 07 Feb 2024 19:43:07 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 02/32] ieee802154: ca8210: Follow renaming of SPI "master" to "controller"
Date: Wed,  7 Feb 2024 19:40:16 +0100
Message-ID:  <dec96b1d3cf43bb442128957b27d02007ffeb68d.1707324794.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1119; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=jhiShNIsUFW7WZuiPMMO9tp0A0zw/Nl6K1uMEilFM+o=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlw86YpPADTu1RuChoK8XIhMWiUShig6V8EeR+A faon0258syJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcPOmAAKCRCPgPtYfRL+ Tk6LB/9wjazXcYYE7uG7eQtfAxFqUm9bUtQLOuOGo6MAeDXe6a5q6Di/eDdcaU7n+YTl43PLWn2 JwzVRuZ9NUPC01hYfdcKEMm9imlqBsOQf76A+3QCkiULt7kK8yvKDDRqp6t3c79K+wThBQiHLdJ QscK83OjZMtls5lniE9ZCOyPOsKhOz3baheWT+BZGzmA+n3vYo6P8TNM4S+3/XVVzX0JiVH13BN 0/dks7nExTrhJr6EN8CAmAkaOn2+ICax5hIVHZi6sLEjCZoZju8UDpljS3JtKFRJwUxl/+XnPgX 9auINxcE5koDy+wsS38mAqJiZVGP8QgM8pcatTeQuoVefGL4
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
Acked-by: Stefan Schmidt <stefan@datenfreihafen.org>
Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/net/ieee802154/ca8210.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index 4ec0dab38872..f732c150462b 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -2956,7 +2956,7 @@ static int ca8210_test_interface_init(struct ca8210_priv *priv)
 		node_name,
 		sizeof(node_name),
 		"ca8210@%d_%d",
-		priv->spi->master->bus_num,
+		priv->spi->controller->bus_num,
 		spi_get_chipselect(priv->spi, 0)
 	);
 
-- 
2.43.0


