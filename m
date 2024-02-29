Return-Path: <linux-kernel+bounces-86582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C99286C768
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBB6A288E05
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B4A7A726;
	Thu, 29 Feb 2024 10:53:28 +0000 (UTC)
Received: from mail.actia.se (mail.actia.se [212.181.117.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE4F79DCF;
	Thu, 29 Feb 2024 10:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.181.117.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709204007; cv=none; b=nI7ZAHuERxihbUKQ4gdMB2F2EImRvq6Ln7rjDYCOHvfkvFaIxPDdKMQDmimKkz+Vbcvg3nTTbi5mld9n3mAeS0jllGCFQarStTdzkAwBVGxWeguBVR2LSjjurwzHmbo4bMjeW65tWyquscH5oD8/XN8CKG55eWdj2wHODfAdoXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709204007; c=relaxed/simple;
	bh=o7cbmOCpAyj2Lh1VjiptfXjVn33mIRYdRiUPQYlEcn8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=MIsYusJujqmD5K6ob0r01Ms/A/ss/DKBRMiTo7rSx/kWd2Q0u9QuWYapb/Fnoj/N82DKYMgdHsGS96pSrbo9xOhsyiYIK4X3sROp6U+y+bk3OsQkqciP2PWrPrrXz8O9Fb9Zq4oRp7BSbwRHqrQhbSjVxpf2MvUIrWHHFEnDkfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=actia.se; spf=pass smtp.mailfrom=actia.se; arc=none smtp.client-ip=212.181.117.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=actia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=actia.se
Received: from S036ANL.actianordic.se (10.12.31.117) by S036ANL.actianordic.se
 (10.12.31.117) with Microsoft SMTP Server (version=TLS1_2,
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
Subject: [PATCH net v2 0/2] net: fec: Fixes to suspend / resume with
 mac_managed_pm
Thread-Topic: [PATCH net v2 0/2] net: fec: Fixes to suspend / resume with
 mac_managed_pm
Thread-Index: AQHaav1+R0XAsBAPyEuuMQx/2+BDqQ==
Date: Thu, 29 Feb 2024 10:53:14 +0000
Message-ID: <20240229105256.2903095-1-john.ernberg@actia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.43.0
x-esetresult: clean, is OK
x-esetid: 37303A2958D72955637266
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Since the introduction of mac_managed_pm in the FEC driver there were some
discrepancies regarding power management of the PHY.

This failed on our board that has a permanently powered Microchip LAN8700R
attached to the FEC. Although the root cause of the failure can be traced
back to f166f890c8f0 ("net: ethernet: fec: Replace interrupt driven MDIO
with polled IO") and probably even before that, we only started noticing
the problem going from 5.10 to 6.1.

Since 557d5dc83f68 ("net: fec: use mac-managed PHY PM") is actually a fix
to most of the power management sequencing problems that came with power
managing the MDIO bus which for the FEC meant adding a race with FEC
resume (and phy_start() if netif was running) and PHY resume.

That it worked before for us was probably just luck...

Thanks to Wei's response to my report at [1] I was able to pick up his
patch and start honing in on the remaining missing details.

[1]: https://lore.kernel.org/netdev/1f45bdbe-eab1-4e59-8f24-add177590d27@ac=
tia.se/

v2:
 - Completely different approach that should be much more correct
   (Wei Fang, Jakub Kucinski)
 - Re-target to net tree, because I have fixes tags now

v1: https://lore.kernel.org/netdev/20240212105010.2258421-1-john.ernberg@ac=
tia.se/

John Ernberg (1):
  net: fec: Suspend and resume the PHY

Wei Fang (1):
  net: fec: Set mac_managed_pm during probe

 drivers/net/ethernet/freescale/fec_main.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

--=20
2.43.0

