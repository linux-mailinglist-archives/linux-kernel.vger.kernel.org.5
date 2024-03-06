Return-Path: <linux-kernel+bounces-93987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0A78737DB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8920B21E03
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83875131E25;
	Wed,  6 Mar 2024 13:37:56 +0000 (UTC)
Received: from mail.actia.se (mail.actia.se [212.181.117.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E554C130ADC;
	Wed,  6 Mar 2024 13:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.181.117.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709732276; cv=none; b=CXEFmKTslAKc7oEzHcOMuXZXpHOdkcnc0YetlAW6IHKKX2sCNJkrW3H+XEZl89q7oD6Q0A7Xf1uHI2Zmin7MVH8xjWXWe46Hx9k/aZC3XrMBPpREIgoNGpoCE0NoP7GIGsqbHckD4RLunv/LBM7/y5y6+8qdPGJtvJIVlKxW9mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709732276; c=relaxed/simple;
	bh=uLxSxO5hAwNk8FrVWMsRzI5JmztxPkdioRJyZ8+FlIM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EMAPS26QsRpHc2XBYO8kV+7mAWKONr4AE6W7hwGpnR7WBouPn5cBYDDFe/4YAptOCgSL0APISrkAtEvnyv+zBNyg9y0OKpMtAOcLKIWyGYkB/iOy7GdZLAbVj3XGdpT/TqMeKS2pi72EGWY2VapnA9Z2U3TV3vEVYdQvAHjhtjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=actia.se; spf=pass smtp.mailfrom=actia.se; arc=none smtp.client-ip=212.181.117.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=actia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=actia.se
Received: from S036ANL.actianordic.se (10.12.31.117) by S035ANL.actianordic.se
 (10.12.31.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 6 Mar
 2024 14:37:45 +0100
Received: from S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69]) by
 S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69%4]) with mapi id
 15.01.2507.035; Wed, 6 Mar 2024 14:37:45 +0100
From: John Ernberg <john.ernberg@actia.se>
To: Wei Fang <wei.fang@nxp.com>
CC: Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Heiner Kallweit <hkallweit1@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, John Ernberg
	<john.ernberg@actia.se>
Subject: [PATCH net v3 1/2] net: fec: Set mac_managed_pm during probe
Thread-Topic: [PATCH net v3 1/2] net: fec: Set mac_managed_pm during probe
Thread-Index: AQHab8t45Eo7PpKcikKmtUVR9yzd+A==
Date: Wed, 6 Mar 2024 13:37:45 +0000
Message-ID: <20240306133734.4144808-2-john.ernberg@actia.se>
References: <20240306133734.4144808-1-john.ernberg@actia.se>
In-Reply-To: <20240306133734.4144808-1-john.ernberg@actia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.43.0
x-esetresult: clean, is OK
x-esetid: 37303A2921D72955627162
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

From: Wei Fang <wei.fang@nxp.com>

Setting mac_managed_pm during interface up is too late.

In situations where the link is not brought up yet and the system suspends
the regular PHY power management will run. Since the FEC ETHEREN control
bit is cleared (automatically) on suspend the controller is off in resume.
When the regular PHY power management resume path runs in this context it
will write to the MII_DATA register but nothing will be transmitted on the
MDIO bus.

This can be observed by the following log:

    fec 5b040000.ethernet eth0: MDIO read timeout
    Microchip LAN87xx T1 5b040000.ethernet-1:04: PM: dpm_run_callback(): md=
io_bus_phy_resume+0x0/0xc8 returns -110
    Microchip LAN87xx T1 5b040000.ethernet-1:04: PM: failed to resume: erro=
r -110

The data written will however remain in the MII_DATA register.

When the link later is brought up it will trigger a call to fec_restart()
which will restore the MII_SPEED register. This triggers the quirk
explained in f166f890c8f0 ("net: ethernet: fec: Replace interrupt driven
MDIO with polled IO") causing a MII_EVENT storm.

This event storm causes all the MDIO register reads to read as 0 because
fec_enet_mdio_wait() returns too early.

When a Microchip LAN8700R PHY is connected to the FEC, the 0 reads causes
the PHY to be initialized incorrectly and the PHY will not transmit any
ethernet signal in this state. It cannot be brought out of this state
without a power cycle of the PHY.

Fixes: 557d5dc83f68 ("net: fec: use mac-managed PHY PM")
Closes: https://lore.kernel.org/netdev/1f45bdbe-eab1-4e59-8f24-add177590d27=
@actia.se/
Signed-off-by: Wei Fang <wei.fang@nxp.com>
[jernberg: commit message]
Signed-off-by: John Ernberg <john.ernberg@actia.se>
---

v3:
 - No changes

v2:
 - New patch. Big thanks to Wei for the help on this issue.
---
 drivers/net/ethernet/freescale/fec_main.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethern=
et/freescale/fec_main.c
index 432523b2c789..8decb1b072c5 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -2406,8 +2406,6 @@ static int fec_enet_mii_probe(struct net_device *ndev=
)
 	fep->link =3D 0;
 	fep->full_duplex =3D 0;
=20
-	phy_dev->mac_managed_pm =3D true;
-
 	phy_attached_info(phy_dev);
=20
 	return 0;
@@ -2419,10 +2417,12 @@ static int fec_enet_mii_init(struct platform_device=
 *pdev)
 	struct net_device *ndev =3D platform_get_drvdata(pdev);
 	struct fec_enet_private *fep =3D netdev_priv(ndev);
 	bool suppress_preamble =3D false;
+	struct phy_device *phydev;
 	struct device_node *node;
 	int err =3D -ENXIO;
 	u32 mii_speed, holdtime;
 	u32 bus_freq;
+	int addr;
=20
 	/*
 	 * The i.MX28 dual fec interfaces are not equal.
@@ -2536,6 +2536,13 @@ static int fec_enet_mii_init(struct platform_device =
*pdev)
 		goto err_out_free_mdiobus;
 	of_node_put(node);
=20
+	/* find all the PHY devices on the bus and set mac_managed_pm to true */
+	for (addr =3D 0; addr < PHY_MAX_ADDR; addr++) {
+		phydev =3D mdiobus_get_phy(fep->mii_bus, addr);
+		if (phydev)
+			phydev->mac_managed_pm =3D true;
+	}
+
 	mii_cnt++;
=20
 	/* save fec0 mii_bus */
--=20
2.43.0

