Return-Path: <linux-kernel+bounces-24533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DFA82BDFA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 10:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 670701C224D9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 09:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D08F5732F;
	Fri, 12 Jan 2024 09:57:39 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7EA55769;
	Fri, 12 Jan 2024 09:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 466271ff02ce42efb222d7f9b175a673-20240112
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:8a9438d2-85ff-414d-96af-d16c5e2421db,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:20
X-CID-INFO: VERSION:1.1.35,REQID:8a9438d2-85ff-414d-96af-d16c5e2421db,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:5d391d7,CLOUDID:b8fc182f-1ab8-4133-9780-81938111c800,B
	ulkID:240112175728QEUER3N2,BulkQuantity:0,Recheck:0,SF:38|24|17|19|44|66|1
	02,TC:nil,Content:0,EDM:5,IP:-2,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,
	COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,
	TF_CID_SPAM_ULN
X-UUID: 466271ff02ce42efb222d7f9b175a673-20240112
X-User: chentao@kylinos.cn
Received: from kernel.. [(116.128.244.171)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 484211676; Fri, 12 Jan 2024 17:57:27 +0800
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
Subject: [PATCH net] net: phy: Fix possible NULL pointer dereference issues caused by phy_attached_info_irq
Date: Fri, 12 Jan 2024 17:57:24 +0800
Message-Id: <20240112095724.154197-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kasprintf() returns a pointer to dynamically allocated memory
which can be NULL upon failure. Ensure the allocation was successful
by checking the pointer validity.

Fixes: e27f178793de ("net: phy: Added IRQ print to phylink_bringup_phy()")
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 drivers/net/phy/phy_device.c | 3 +++
 drivers/net/phy/phylink.c    | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 3611ea64875e..10fa99d957c0 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1299,6 +1299,9 @@ void phy_attached_print(struct phy_device *phydev, const char *fmt, ...)
 	const char *unbound = phydev->drv ? "" : "[unbound] ";
 	char *irq_str = phy_attached_info_irq(phydev);
 
+	if (!irq_str)
+		return;
+
 	if (!fmt) {
 		phydev_info(phydev, ATTACHED_FMT "\n", unbound,
 			    phydev_name(phydev), irq_str);
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index ed0b4ccaa6a6..db0a545c9468 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1884,6 +1884,8 @@ static int phylink_bringup_phy(struct phylink *pl, struct phy_device *phy,
 	phy->phy_link_change = phylink_phy_change;
 
 	irq_str = phy_attached_info_irq(phy);
+	if (!irq_str)
+		return -ENOMEM;
 	phylink_info(pl,
 		     "PHY [%s] driver [%s] (irq=%s)\n",
 		     dev_name(&phy->mdio.dev), phy->drv->name, irq_str);
-- 
2.39.2


