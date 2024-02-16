Return-Path: <linux-kernel+bounces-68919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AFB8581E9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB6561F22FAD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CED134CF9;
	Fri, 16 Feb 2024 15:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PhoLSlMt"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D005A131E2F;
	Fri, 16 Feb 2024 15:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708098792; cv=none; b=m0WqY4VKEC2verebOIUnI5Io2NWD3aVwzhtyQ2heW9+ueTAuY0dwuTYcXMt3ir2B2p0p9qQjTBxGP287eQ+ZCeM24ItBsvS0RE660PPtULOc63FZcsxxIOXvE8z53x93kuSg+ib8c0SmjUO4Eb7p+yhxpbEzUKb/PVRlGn7F/Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708098792; c=relaxed/simple;
	bh=ofguNo6Qw8u4BIZ10jVG4IP+SAipIpHr2SfAps5s9LY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MNpHQBP+tbs9163mVu7q+/gDo56BZjnhjiIh8B3NujJxGRtDsug5iqQbzJd9Zo2ECjow1p4VlPo65kbFGFQgVxT+JGlBe0kyEi6S7wG2VMLVHskmgd5mhOUI5kIhvu1EkJgy3d7XqalxualstC8e+KX+2e5V5G3wJnivCUvR4Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PhoLSlMt; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 16CD724000A;
	Fri, 16 Feb 2024 15:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708098788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ybkeqbNzvHWp95Jf30SwLVuY/Le8DIafmSMZ2+PWjs=;
	b=PhoLSlMthm/EXYwqoHTv3Bne5dbFJhznoy/b6fYCgNMjy+SLvwPXIGnFc0sLbeFfcxJ0s2
	2ZYIuylV2ci/aT2/orhwgzV8h3viS/ZRfAxseRd6dsFCLbA/NbTziHaxe3+zx6MYKQ0mop
	I5fNw1mu4pOCTvUIt7BhQVwzWOG2bW4yLig3RPFtX9bBLppPSo+78NHkDSCCHbMMVVwYp+
	lb7cifYLjbl1RgCxzytKoJluiGbLAOzUB53EtDpqdSbvRmdVnnN1G8U5PaXGD0Q7L2AtwD
	idKaewdhVsziWtJHzah8WzMH+iNgrvD39BXilsx8g4v/uIdFVsFvls/SUG09eg==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 16 Feb 2024 16:52:28 +0100
Subject: [PATCH RFC net-next v8 10/13] net: netdevsim: ptp_mock: Convert to
 netdev_ptp_clock_register
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240216-feature_ptp_netnext-v8-10-510f42f444fb@bootlin.com>
References: <20240216-feature_ptp_netnext-v8-0-510f42f444fb@bootlin.com>
In-Reply-To: <20240216-feature_ptp_netnext-v8-0-510f42f444fb@bootlin.com>
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
X-Mailer: b4 0.12.4
X-GND-Sasl: kory.maincent@bootlin.com

The hardware registration clock for net device is now using
netdev_ptp_clock_register to save the net_device pointer within the PTP
clock xarray. netdevsim is registering its ptp through the mock driver.
It is the only driver using the mock driver to register a ptp clock.
Convert the mock driver to the new API.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
Shouldn't we move the mock driver in the netdevsim directory as it is only
used by netdevsim driver?

Changes in v8:
- New patch
---
 drivers/net/netdevsim/netdev.c | 19 +++++++++++--------
 drivers/ptp/ptp_mock.c         |  4 ++--
 include/linux/ptp_mock.h       |  4 ++--
 3 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 77e8250282a5..7f58645559b5 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -321,16 +321,11 @@ static int nsim_init_netdevsim(struct netdevsim *ns)
 	struct mock_phc *phc;
 	int err;
 
-	phc = mock_phc_create(&ns->nsim_bus_dev->dev);
-	if (IS_ERR(phc))
-		return PTR_ERR(phc);
-
-	ns->phc = phc;
 	ns->netdev->netdev_ops = &nsim_netdev_ops;
 
 	err = nsim_udp_tunnels_info_create(ns->nsim_dev, ns->netdev);
 	if (err)
-		goto err_phc_destroy;
+		return err;
 
 	rtnl_lock();
 	err = nsim_bpf_init(ns);
@@ -344,8 +339,18 @@ static int nsim_init_netdevsim(struct netdevsim *ns)
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
@@ -353,8 +358,6 @@ static int nsim_init_netdevsim(struct netdevsim *ns)
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
2.25.1


