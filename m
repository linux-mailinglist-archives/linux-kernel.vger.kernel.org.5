Return-Path: <linux-kernel+bounces-151299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D328AAC95
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56C0428303D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5E812C53D;
	Fri, 19 Apr 2024 10:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ObIKwWPt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE917F7C6;
	Fri, 19 Apr 2024 10:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713521378; cv=none; b=g2ttYolzgcYgL65d1mRHYVY7+RnnR2ncDrQ4TAvIKeM+mtOm2K2GiBC2KWbugxh+Wm2vmGZVX2rdp7AgsT1NCp060gXrhcm8D2YSGQ8ZjBeld+mFgffULB0X5sEc0kv4EHOhQraYWFgQy063LnluhcXPgTKCtwEPGtg/py4iZK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713521378; c=relaxed/simple;
	bh=A/6I8pJ7fmJZa2NSEfrteMXm9y4a13URFTnLtu4q6Cs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kpB7QM/zyQdVDBV5PT6iM5JJ2uj3q54hUpXQcv5DhnwiaytZ29NKOj0Hp80eTUGu4Iko9SoKf9m/DyiVh52Phi7Voy7PCTekfMGQHPqn4oDHsSAhpVyGHftzRH0TGdnma7bAjGN9syAovUpGry0hn82VxOX3iO22yBmItz0sgbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ObIKwWPt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E8994C4AF0E;
	Fri, 19 Apr 2024 10:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713521378;
	bh=A/6I8pJ7fmJZa2NSEfrteMXm9y4a13URFTnLtu4q6Cs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ObIKwWPt7llKjt5GGySWvobJqBQSRc+UkgqKI75jxI2LZgRgygtEaPXj7yRhybCvm
	 +WyLso0DvQE5L12dDBwq0y1Jq/MulFFsZ8Z7fMFM1jzrRVSxj+/fL27lEJcOQCBym2
	 ngxW4jPnzx675858qb2dfWs1dBlcWjqqev5uaTyQQMLBaBUx/sE3HMZiBSiSagXulo
	 318NM6JTHY+BtJTaPcYUZSpq+Ver0NctBna4FoAsr3sEqco1E88kedM76WcdEXudAi
	 7kn7j8KM1SKfAp9bIUttUGa9yukvS2m2Q9pTXiLemE8rHDWhuat10GyMvB5FeEuuGr
	 cqCeEY+cB/7vA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB626C4345F;
	Fri, 19 Apr 2024 10:09:37 +0000 (UTC)
From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL_via_B4_Relay?= <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Fri, 19 Apr 2024 13:09:31 +0300
Subject: [PATCH net-next 08/13] net: dsa: mt7530: return mt7530_setup_mdio
 & mt7531_setup_common on error
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240419-for-netnext-mt7530-improvements-4-v1-8-6d852ca79b1d@arinc9.com>
References: <20240419-for-netnext-mt7530-improvements-4-v1-0-6d852ca79b1d@arinc9.com>
In-Reply-To: <20240419-for-netnext-mt7530-improvements-4-v1-0-6d852ca79b1d@arinc9.com>
To: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>, 
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Bartel Eerdekens <bartel.eerdekens@constell8.be>, 
 mithat.guner@xeront.com, erkin.bozoglu@xeront.com, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713521374; l=1000;
 i=arinc.unal@arinc9.com; s=arinc9-Xeront; h=from:subject:message-id;
 bh=dhGaiF9+p4oldvBExDhNwz/DfR5nSajm98YgCgzXa+8=;
 b=2BxAch20eM2c8wvH4hsKCRmrCfJCbUYkFInLzGJsmliu0YwKZHxbIUtyCnjWf3L2zY6HGcE7O
 lOdPe2ZZRPVDm1XFB0M03gpIYRxE1oIfpmsEqmNnYWIpJzGSVIVGTGJ
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=z49tLn29CyiL4uwBTrqH9HO1Wu3sZIuRp4DaLZvtP9M=
X-Endpoint-Received: by B4 Relay for arinc.unal@arinc9.com/arinc9-Xeront
 with auth_id=137
X-Original-From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Reply-To: arinc.unal@arinc9.com

From: Arınç ÜNAL <arinc.unal@arinc9.com>

The mt7530_setup_mdio() and mt7531_setup_common() functions should be
checked for errors. Return if the functions return a non-zero value.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/net/dsa/mt7530.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 83436723cb16..4e9aa78ca3d0 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2667,7 +2667,9 @@ mt7531_setup(struct dsa_switch *ds)
 					 0);
 	}
 
-	mt7531_setup_common(ds);
+	ret = mt7531_setup_common(ds);
+	if (ret)
+		return ret;
 
 	/* Setup VLAN ID 0 for VLAN-unaware bridges */
 	ret = mt7530_setup_vlan0(priv);
@@ -3020,6 +3022,8 @@ mt753x_setup(struct dsa_switch *ds)
 	ret = mt7530_setup_mdio(priv);
 	if (ret && priv->irq)
 		mt7530_free_irq_common(priv);
+	if (ret)
+		return ret;
 
 	/* Initialise the PCS devices */
 	for (i = 0; i < priv->ds->num_ports; i++) {

-- 
2.40.1



