Return-Path: <linux-kernel+bounces-164317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2205E8B7C3B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D135F285FA9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE5117A93E;
	Tue, 30 Apr 2024 15:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ElhFqnSP"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE787175571;
	Tue, 30 Apr 2024 15:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714492254; cv=none; b=MN/OiRqs1c5SlRekFwqA6GN7zfUxZZCJdk+YZ0qZBc/Y1xTSOgFDDejWqqDpTTRx2WscTIwjUvjESFSQQg3w2aFC8VJ/xd3d76h2oLRqH2+caY1BvAKipTcARS2xd3UoMo+EJ454THMehsQI54OSjgtw/zkFW/YVh0MXoPkmxZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714492254; c=relaxed/simple;
	bh=MR4T+aVryHDlCdLIA+7+MzjoHtX5UbAViJjBqaEXzNI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tqOAh/NWtCDDizgTg8CGaoZwZ1dFgopp8nKvyocckvpHHaROZj6VfVlkeeuEgJmjaQjzZGE5gf2eILdNGKpJBRn+zBsIYy2omwizFx3DL8KuzjZbnMOzfmNS+p+RQrvAPIvvqGtgTDp3qXr73UlbsN+uRpzJq3oerUv+MmpzYjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ElhFqnSP; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D4F7520016;
	Tue, 30 Apr 2024 15:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714492239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EtjDyVeqqMgYUVSHB7nyuZRP2kSxS8c/e1unyRtkL5I=;
	b=ElhFqnSPGOxirfUFhmp8R2K6zVMRcIlW7z0lkVPipo6NHYFqJrlJOrKs6Zciz2XzHcKDTY
	a9X5/vzDV/Hbnk+aQqj8QiHGko3GFjvlbaAHs6Usf0i3MRRz8GZtqXRY6OXmhhlMEJVBei
	JKdirDIoNp+XiGdQVqj/AyWgWVwpP5PCUZXQjcK5hb2+xXkOfs9x6pKRjWqySTAkHvbIkt
	BbeIhCxWADpn0x6eTBR6JQ6RuHbi1d+dAnr5nXPaHpkSRxL8EwvD6LL96vnTtx3IN0cjg4
	GtQYcXLd2kI73yOlDHLcOPBsAr8I6DmyGn766H1ybHhr/ct1HXSU5ab8sEnrfQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 30 Apr 2024 17:49:53 +0200
Subject: [PATCH net-next v12 10/13] net: netdevsim: ptp_mock: Convert to
 netdev_ptp_clock_register
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240430-feature_ptp_netnext-v12-10-2c5f24b6a914@bootlin.com>
References: <20240430-feature_ptp_netnext-v12-0-2c5f24b6a914@bootlin.com>
In-Reply-To: <20240430-feature_ptp_netnext-v12-0-2c5f24b6a914@bootlin.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Radu Pirea <radu-nicolae.pirea@oss.nxp.com>, 
 Jay Vosburgh <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Horatiu Vultur <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com, 
 Simon Horman <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: kory.maincent@bootlin.com

The hardware registration clock for net device is now using
netdev_ptp_clock_register to save the net_device pointer within the PTP
clock xarray. netdevsim is registering its ptp through the mock driver.
It is the only driver using the mock driver to register a ptp clock.
Convert the mock driver to the new API.

Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
Changes in v8:
- New patch
---
 drivers/net/netdevsim/netdev.c | 19 +++++++++++--------
 drivers/ptp/ptp_mock.c         |  4 ++--
 include/linux/ptp_mock.h       |  4 ++--
 3 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index d127856f8f36..c53d2163022e 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -482,17 +482,12 @@ static int nsim_init_netdevsim(struct netdevsim *ns)
 	struct mock_phc *phc;
 	int err;
 
-	phc = mock_phc_create(&ns->nsim_bus_dev->dev);
-	if (IS_ERR(phc))
-		return PTR_ERR(phc);
-
-	ns->phc = phc;
 	ns->netdev->netdev_ops = &nsim_netdev_ops;
 	ns->netdev->stat_ops = &nsim_stat_ops;
 
 	err = nsim_udp_tunnels_info_create(ns->nsim_dev, ns->netdev);
 	if (err)
-		goto err_phc_destroy;
+		return err;
 
 	rtnl_lock();
 	err = nsim_bpf_init(ns);
@@ -506,8 +501,18 @@ static int nsim_init_netdevsim(struct netdevsim *ns)
 	if (err)
 		goto err_ipsec_teardown;
 	rtnl_unlock();
+
+	phc = mock_phc_create(ns->netdev);
+	if (IS_ERR(phc)) {
+		err = PTR_ERR(phc);
+		goto err_register_netdevice;
+	}
+
+	ns->phc = phc;
 	return 0;
 
+err_register_netdevice:
+	unregister_netdevice(ns->netdev);
 err_ipsec_teardown:
 	nsim_ipsec_teardown(ns);
 	nsim_macsec_teardown(ns);
@@ -515,8 +520,6 @@ static int nsim_init_netdevsim(struct netdevsim *ns)
 err_utn_destroy:
 	rtnl_unlock();
 	nsim_udp_tunnels_info_destroy(ns->netdev);
-err_phc_destroy:
-	mock_phc_destroy(ns->phc);
 	return err;
 }
 
diff --git a/drivers/ptp/ptp_mock.c b/drivers/ptp/ptp_mock.c
index e7b459c846a2..1dcbe7426746 100644
--- a/drivers/ptp/ptp_mock.c
+++ b/drivers/ptp/ptp_mock.c
@@ -115,7 +115,7 @@ int mock_phc_index(struct mock_phc *phc)
 }
 EXPORT_SYMBOL_GPL(mock_phc_index);
 
-struct mock_phc *mock_phc_create(struct device *dev)
+struct mock_phc *mock_phc_create(struct net_device *dev)
 {
 	struct mock_phc *phc;
 	int err;
@@ -147,7 +147,7 @@ struct mock_phc *mock_phc_create(struct device *dev)
 	spin_lock_init(&phc->lock);
 	timecounter_init(&phc->tc, &phc->cc, 0);
 
-	phc->clock = ptp_clock_register(&phc->info, dev);
+	phc->clock = netdev_ptp_clock_register(&phc->info, dev);
 	if (IS_ERR(phc->clock)) {
 		err = PTR_ERR(phc->clock);
 		goto out_free_phc;
diff --git a/include/linux/ptp_mock.h b/include/linux/ptp_mock.h
index 72eb401034d9..e226011071f8 100644
--- a/include/linux/ptp_mock.h
+++ b/include/linux/ptp_mock.h
@@ -13,13 +13,13 @@ struct mock_phc;
 
 #if IS_ENABLED(CONFIG_PTP_1588_CLOCK_MOCK)
 
-struct mock_phc *mock_phc_create(struct device *dev);
+struct mock_phc *mock_phc_create(struct net_device *dev);
 void mock_phc_destroy(struct mock_phc *phc);
 int mock_phc_index(struct mock_phc *phc);
 
 #else
 
-static inline struct mock_phc *mock_phc_create(struct device *dev)
+static inline struct mock_phc *mock_phc_create(struct net_device *dev)
 {
 	return NULL;
 }

-- 
2.34.1


