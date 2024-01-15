Return-Path: <linux-kernel+bounces-25753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8644082D552
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BB7A1F21AF5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 08:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5890D521;
	Mon, 15 Jan 2024 08:50:33 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE36D308;
	Mon, 15 Jan 2024 08:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 583e9824b00a404c951f36b996001b4a-20240115
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:fbdb9046-cc15-4f62-8261-5b129439ce27,IP:10,
	URL:0,TC:0,Content:-5,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,AC
	TION:release,TS:15
X-CID-INFO: VERSION:1.1.35,REQID:fbdb9046-cc15-4f62-8261-5b129439ce27,IP:10,UR
	L:0,TC:0,Content:-5,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:15
X-CID-META: VersionHash:5d391d7,CLOUDID:3b3cdc82-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:2401151650265V38VMXJ,BulkQuantity:0,Recheck:0,SF:24|17|19|44|66|38|1
	02,TC:nil,Content:0,EDM:5,IP:-2,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,
	COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,
	TF_CID_SPAM_ULN
X-UUID: 583e9824b00a404c951f36b996001b4a-20240115
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 252634715; Mon, 15 Jan 2024 16:50:24 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id B0811E000EB9;
	Mon, 15 Jan 2024 16:50:23 +0800 (CST)
X-ns-mid: postfix-65A4F1CF-609187206
Received: from kernel.. (unknown [172.20.15.234])
	by mail.kylinos.cn (NSMail) with ESMTPA id E6D60E000EB9;
	Mon, 15 Jan 2024 16:50:21 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: f.fainelli@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH net v2] net: phy: Fix possible NULL pointer dereference issues caused by phy_attached_info_irq
Date: Mon, 15 Jan 2024 16:50:18 +0800
Message-Id: <20240115085018.30300-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

kasprintf() returns a pointer to dynamically allocated memory
which can be NULL upon failure. Ensure the allocation was successful
by checking the pointer validity.

phylink_bringup_phy needs to be done, otherwise network interface is
likely to be dead, so when irq_str is NULL, just print an empty string.

Fixes: e27f178793de ("net: phy: Added IRQ print to phylink_bringup_phy()"=
)
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Suggested-by: Andrew Lunn <andrew@lunn.ch>
---
v2: Print empty string when irq_str is NULL in phylink_bringup_phy
---
 drivers/net/phy/phy_device.c | 3 +++
 drivers/net/phy/phylink.c    | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 3611ea64875e..10fa99d957c0 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1299,6 +1299,9 @@ void phy_attached_print(struct phy_device *phydev, =
const char *fmt, ...)
 	const char *unbound =3D phydev->drv ? "" : "[unbound] ";
 	char *irq_str =3D phy_attached_info_irq(phydev);
=20
+	if (!irq_str)
+		return;
+
 	if (!fmt) {
 		phydev_info(phydev, ATTACHED_FMT "\n", unbound,
 			    phydev_name(phydev), irq_str);
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index ed0b4ccaa6a6..819574a06036 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1886,7 +1886,7 @@ static int phylink_bringup_phy(struct phylink *pl, =
struct phy_device *phy,
 	irq_str =3D phy_attached_info_irq(phy);
 	phylink_info(pl,
 		     "PHY [%s] driver [%s] (irq=3D%s)\n",
-		     dev_name(&phy->mdio.dev), phy->drv->name, irq_str);
+		     dev_name(&phy->mdio.dev), phy->drv->name, irq_str ? irq_str : "")=
;
 	kfree(irq_str);
=20
 	mutex_lock(&phy->lock);
--=20
2.39.2


