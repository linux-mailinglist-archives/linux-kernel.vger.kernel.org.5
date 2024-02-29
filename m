Return-Path: <linux-kernel+bounces-86584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DE586C76C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32D701C231A8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042FB7B3E8;
	Thu, 29 Feb 2024 10:53:32 +0000 (UTC)
Received: from mail.actia.se (mail.actia.se [212.181.117.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB517AE4B;
	Thu, 29 Feb 2024 10:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.181.117.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709204011; cv=none; b=FelLRIKFDG1P6ygUPWqhCnpgSpDHXbGxwi17l0hw+gMRb10TiiCpkBUkTMkjdf/tgDr4de6b114EFMLlGLmuuHcLUXIF10lk9FJhaNHcQS02lqwsm3pQt8W36MSZ0bqTzu322pDiAhejH/Rm+7ApM7TeW02NGN6cn2fiHMq9VVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709204011; c=relaxed/simple;
	bh=PNwWwvuBJawLAblzdVhyPVN105zb/MBZ+sqrDXI5M8A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UJjy9LnjKDsiYK8KQeo1PH2wpj1R35fuBSJq53jqxKtY8f8QH6L/o/JeTKGfqGAozGJsgcus4Q8nzKoRiJLUjH9a0FVWApdaV0qp7LR9bJSPkvQ6XMib3AcpLwGrqzDGg26KCGSHhTGzFjeHvdJ5fBK55BhEhdb4kAMEnaNSwsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=actia.se; spf=pass smtp.mailfrom=actia.se; arc=none smtp.client-ip=212.181.117.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=actia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=actia.se
Received: from S036ANL.actianordic.se (10.12.31.117) by S035ANL.actianordic.se
 (10.12.31.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 29 Feb
 2024 11:53:15 +0100
Received: from S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69]) by
 S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69%4]) with mapi id
 15.01.2507.035; Thu, 29 Feb 2024 11:53:15 +0100
From: John Ernberg <john.ernberg@actia.se>
To: Wei Fang <wei.fang@nxp.com>
CC: Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Heiner Kallweit <hkallweit1@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, John Ernberg
	<john.ernberg@actia.se>
Subject: [PATCH net v2 2/2] net: fec: Suspend and resume the PHY
Thread-Topic: [PATCH net v2 2/2] net: fec: Suspend and resume the PHY
Thread-Index: AQHaav1/Ffv5x8jH7kmxx77YLYL/oA==
Date: Thu, 29 Feb 2024 10:53:15 +0000
Message-ID: <20240229105256.2903095-3-john.ernberg@actia.se>
References: <20240229105256.2903095-1-john.ernberg@actia.se>
In-Reply-To: <20240229105256.2903095-1-john.ernberg@actia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.43.0
x-esetresult: clean, is OK
x-esetid: 37303A2921D72955637266
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

PHYs that are always-on will not enter their low power modes otherwise as
they have no regulator to be powered off with.

Since the PHY is picked up via {of_,}phy_connect() and dropped with
phy_disconnect() when the link is brought up and down respectively the only
cases were pm is needed is when the netif is running or or when the link
has never been up.

To deal with the latter case the PHY is suspended on discovery in probe,
since it won't be needed until link up.

Fixes: 557d5dc83f68 ("net: fec: use mac-managed PHY PM")
Signed-off-by: John Ernberg <john.ernberg@actia.se>
---

v2: New patch
---
 drivers/net/ethernet/freescale/fec_main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethern=
et/freescale/fec_main.c
index 8decb1b072c5..c5394a4d8491 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -2539,8 +2539,10 @@ static int fec_enet_mii_init(struct platform_device =
*pdev)
 	/* find all the PHY devices on the bus and set mac_managed_pm to true */
 	for (addr =3D 0; addr < PHY_MAX_ADDR; addr++) {
 		phydev =3D mdiobus_get_phy(fep->mii_bus, addr);
-		if (phydev)
+		if (phydev) {
 			phydev->mac_managed_pm =3D true;
+			phy_suspend(phydev);
+		}
 	}
=20
 	mii_cnt++;
@@ -4631,6 +4633,7 @@ static int __maybe_unused fec_suspend(struct device *=
dev)
 		if (fep->wol_flag & FEC_WOL_FLAG_ENABLE)
 			fep->wol_flag |=3D FEC_WOL_FLAG_SLEEP_ON;
 		phy_stop(ndev->phydev);
+		phy_suspend(ndev->phydev);
 		napi_disable(&fep->napi);
 		netif_tx_lock_bh(ndev);
 		netif_device_detach(ndev);
@@ -4716,6 +4719,7 @@ static int __maybe_unused fec_resume(struct device *d=
ev)
 		netif_tx_unlock_bh(ndev);
 		napi_enable(&fep->napi);
 		phy_init_hw(ndev->phydev);
+		phy_resume(ndev->phydev);
 		phy_start(ndev->phydev);
 	}
 	rtnl_unlock();
--=20
2.43.0

