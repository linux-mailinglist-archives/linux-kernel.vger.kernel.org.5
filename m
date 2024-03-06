Return-Path: <linux-kernel+bounces-93988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5064A8737DD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB9A91F274D6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DB3132C28;
	Wed,  6 Mar 2024 13:37:58 +0000 (UTC)
Received: from mail.actia.se (mail.actia.se [212.181.117.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5258213174E;
	Wed,  6 Mar 2024 13:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.181.117.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709732278; cv=none; b=WojMiZK9H/1qYbZSfzFU43fLaurWfkpnS48tFhHi5lIA8lNmOf9fAgmHs3wwz4+ri0lGNUhgy3LmorBplENxfjU6+6EkeKC+iYaTY97Op9myNk1T/IdoreUA5y5/379Sg6THznf5n1DfkiK1XIwOO8PPUqF11tHpqiTksuaEGl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709732278; c=relaxed/simple;
	bh=zmEX1PyysnR4IfejG+xCR/9Da+bh9s0rL8ilvGkuH2s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m64QoLE8emtjdw/R7LDWxQT/C8ulULSNLZ2W+/AC4/QDZohUtKB0Xvt+KB9A/U3uAkscp6zJK9Vt7BJHQvdYRsTqWJg0eUbMi7aT+K9UEbRTCdUmOQDVCHQQ56JTFrW5FIFFte2TZHx6Q5bvxMWw46lPqUN8CA8B6Kcv6g4a/4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=actia.se; spf=pass smtp.mailfrom=actia.se; arc=none smtp.client-ip=212.181.117.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=actia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=actia.se
Received: from S036ANL.actianordic.se (10.12.31.117) by S035ANL.actianordic.se
 (10.12.31.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 6 Mar
 2024 14:37:46 +0100
Received: from S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69]) by
 S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69%4]) with mapi id
 15.01.2507.035; Wed, 6 Mar 2024 14:37:46 +0100
From: John Ernberg <john.ernberg@actia.se>
To: Wei Fang <wei.fang@nxp.com>
CC: Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Heiner Kallweit <hkallweit1@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, John Ernberg
	<john.ernberg@actia.se>
Subject: [PATCH net v3 2/2] net: fec: Suspend the PHY on probe
Thread-Topic: [PATCH net v3 2/2] net: fec: Suspend the PHY on probe
Thread-Index: AQHab8t46xO1JP3Hxke5Lu7SCFbkbQ==
Date: Wed, 6 Mar 2024 13:37:45 +0000
Message-ID: <20240306133734.4144808-3-john.ernberg@actia.se>
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

Since the power management is now performed by the FEC instead of generic
pm the PHY will not suspend until the link has been up.

Therefor suspend it on probe. It will be resumed by {of_,}phy_connect()
when the link is brought up.

Since {of_,}phy_connect() and phy_disconnect() will resume and suspend the
PHY when the link is brought up and down respectively, and phy_stop() and
phy_start() will resume and suspend the PHY in the suspend-resume paths
there is no need for any additional calls anywhere.

Signed-off-by: John Ernberg <john.ernberg@actia.se>

---

v3:
 - Only call phy_suspend() in probe, it is taken care of by the phy framewo=
rk (Wei Fang)
 - Update commit message to reflect the above
 - Drop fixes tag, this is technically not a fix anymore (Wei Fang)
    Should I re-send this for the net-next tree later, or is it still ok fo=
r net?

v2:
 - New patch
---
 drivers/net/ethernet/freescale/fec_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethern=
et/freescale/fec_main.c
index 8decb1b072c5..fb092b7bfe85 100644
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
--=20
2.43.0

