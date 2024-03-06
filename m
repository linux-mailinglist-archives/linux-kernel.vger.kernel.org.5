Return-Path: <linux-kernel+bounces-93986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A478737D8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33D4B1F27423
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B5A131734;
	Wed,  6 Mar 2024 13:37:56 +0000 (UTC)
Received: from mail.actia.se (mail.actia.se [212.181.117.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5599130AF7;
	Wed,  6 Mar 2024 13:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.181.117.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709732275; cv=none; b=fwE7LpzIs00LATRBvuTUSu60SaXpD9Z8lsnquZdHClcbM4H0t0FyHrYhdXI/p0gdOo5ZTn9Xuw0iA5617mGA6PHRaH7JvxmGYhYQ2lz4I8RTj6P6ley4Q5RtT67QzIZdCVgji8Z7JO/XLLZiCw5oPbI+tnv7HdwuRaoFzxB331U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709732275; c=relaxed/simple;
	bh=dTTRBS7bG/8ZSH3M64mBci0tWA+vNQEp1kcS8aS3mrM=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mdVsyVRHCHerJb9Cr3BAuVnkm6Ipc7oUWWHaihoEV6TQ/YhU0X8hcLD+8QGVLo2iq7lC3wiX36dPBYmWRLhr7/mRlVSYFEnNCgXO7xB84EB1pW6/ti3mewCv/5+pNJNC4Pui/BgSILmY8gwXISji0qUu/2CAvMFdQICLy1a7/Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=actia.se; spf=pass smtp.mailfrom=actia.se; arc=none smtp.client-ip=212.181.117.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=actia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=actia.se
Received: from S036ANL.actianordic.se (10.12.31.117) by S036ANL.actianordic.se
 (10.12.31.117) with Microsoft SMTP Server (version=TLS1_2,
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
Subject: [PATCH net v3 0/2] net: fec: Fixes to suspend / resume with
 mac_managed_pm
Thread-Topic: [PATCH net v3 0/2] net: fec: Fixes to suspend / resume with
 mac_managed_pm
Thread-Index: AQHab8t4ec6I8Jhhj0eD3dmYTsGDgA==
Date: Wed, 6 Mar 2024 13:37:45 +0000
Message-ID: <20240306133734.4144808-1-john.ernberg@actia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.43.0
x-esetresult: clean, is OK
x-esetid: 37303A2958D72955627162
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

v3:
 - Implement feedback from Wei Fang for patch 2
 - Fixes tag in patch 2 dropped, should it be delayed for net-next now?

v2: https://lore.kernel.org/netdev/20240229105256.2903095-1-john.ernberg@ac=
tia.se/
 - Completely different approach that should be much more correct
   (Wei Fang, Jakub Kicinski)
 - Re-target to net tree, because I have fixes tags now

v1: https://lore.kernel.org/netdev/20240212105010.2258421-1-john.ernberg@ac=
tia.se/

John Ernberg (1):
  net: fec: Suspend the PHY on probe

Wei Fang (1):
  net: fec: Set mac_managed_pm during probe

 drivers/net/ethernet/freescale/fec_main.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

--=20
2.43.0

