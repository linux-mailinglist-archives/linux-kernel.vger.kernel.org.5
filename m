Return-Path: <linux-kernel+bounces-61378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DE285118F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96D511C235DE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6B53B797;
	Mon, 12 Feb 2024 10:50:44 +0000 (UTC)
Received: from mail.actia.se (mail.actia.se [212.181.117.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2B03B1AC;
	Mon, 12 Feb 2024 10:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.181.117.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707735044; cv=none; b=PfqNI8iAE+GK9Ag84U0TkYcC+ha4E6ib+631URnszKkwtQuohVxNaLBd4N5r2GO80nTVnbjJer9qdProfkS8n6sBYPNusZm4Jdqcco4Nwj5uDs4videK/Kb1iknD33zxQtFaP641VKagHswAoJJPpguC0ehIocH7Dz1vnLRi7Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707735044; c=relaxed/simple;
	bh=DslaFWZZuV/SwGQuQpMrEYo+M/OcOIqoqJTfsY93H9U=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ORr5cz/Zey7vRqygcj/cbdB4SKMdcKMSZKn5xALxGbomL+oI5YLKtf+VokOxmTdFkxIfdo0PzSNL/WrmEvQG8pm4aIiGZVYSAQ5P/Lw7bb7LAhOTbNWyNbw34x+JI4p9wpnGx9kOBK9+AqkTHB7OKnm11ZYJa/dr7RY3YWs7B0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=actia.se; spf=pass smtp.mailfrom=actia.se; arc=none smtp.client-ip=212.181.117.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=actia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=actia.se
Received: from S036ANL.actianordic.se (10.12.31.117) by S036ANL.actianordic.se
 (10.12.31.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 12 Feb
 2024 11:50:30 +0100
Received: from S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69]) by
 S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69%4]) with mapi id
 15.01.2507.035; Mon, 12 Feb 2024 11:50:30 +0100
From: John Ernberg <john.ernberg@actia.se>
To: Wei Fang <wei.fang@nxp.com>
CC: Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, John Ernberg <john.ernberg@actia.se>
Subject: [PATCH net-next] net: fec: Always call fec_restart() in resume path
Thread-Topic: [PATCH net-next] net: fec: Always call fec_restart() in resume
 path
Thread-Index: AQHaXaFLRIYd45z3UU+7Sl3MRdVj/Q==
Date: Mon, 12 Feb 2024 10:50:30 +0000
Message-ID: <20240212105010.2258421-1-john.ernberg@actia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.43.0
x-esetresult: clean, is OK
x-esetid: 37303A2958D72955617D6A
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

When trying to resume from suspend the following can be observed:

    fec 5b040000.ethernet eth0: MDIO read timeout
    Microchip LAN87xx T1 5b040000.ethernet-1:04: PM: dpm_run_callback(): md=
io_bus_phy_resume+0x0/0xc8 returns -110
    Microchip LAN87xx T1 5b040000.ethernet-1:04: PM: failed to resume: erro=
r -110

This is because the MAC is left powered down after resuming from suspend.

The MAC is brought up in both probe and open, so leaving it off in resume
from suspend is an imbalance.
This imbalance combined with a LAN8700R that is permanently powered
results in unusuable networking if the board would happen to suspend before
the link is brought up, and the only way to get out of it would be a full
power cycle.

NOTE: With this change the PHY ends up taking different resume paths when
the link has never been up compared to once the link has been up. Currently
the resume process is identical and just happens at different times, so
this *should* not have any unforseen consequences.

Signed-off-by: John Ernberg <john.ernberg@actia.se>
---

Tested on 6.1 kernel and forward ported. I discovered this when we
upgraded from 5.10 to 6.1, but the resume path in the FEC driver has had
this imbalance since at least 2009.

This is also why I target the -next tree, I can't identify a proper commit
to blame with a Fixes. Let me know if this should be the net tree anyway.

 drivers/net/ethernet/freescale/fec_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethern=
et/freescale/fec_main.c
index 42bdc01a304e..e6804c068d6b 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -4706,6 +4706,8 @@ static int __maybe_unused fec_resume(struct device *d=
ev)
 		napi_enable(&fep->napi);
 		phy_init_hw(ndev->phydev);
 		phy_start(ndev->phydev);
+	} else {
+		fec_restart(ndev);
 	}
 	rtnl_unlock();
=20
--=20
2.43.0

