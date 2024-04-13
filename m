Return-Path: <linux-kernel+bounces-143732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D552D8A3CC2
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 15:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 118471C20CBD
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 13:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBBF44C7E;
	Sat, 13 Apr 2024 13:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCQPqIA0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383B43F8C7;
	Sat, 13 Apr 2024 13:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713013362; cv=none; b=lyFsH6tSa6xEyviOc3Kf5bKzM7q8gVGLbzexWuaOX5VljObs1ff72N78VwvDbKf5Mxh0iWQFwkL0y2uQ4+LrsSqDPD+e9mZWAYdxbXD1+SvGbHjbwKiTJenfY3+2jq58VqEiAPZ8/xiv/EaXCiMJC6arNzX8JIn8sSeGd88sWO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713013362; c=relaxed/simple;
	bh=1hfFJpbVy+jRqc4NBcjfKebyqWZeLEI6ADFhHCGKzT4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FsTt7uu8RMFB0nOjFFW+nvJwpMzzI7HfhimcCIzN6C5kTQCSq8UMe7OXDm173ZuE0pFeUv4R4TbLPRulATcpZPIiGMfK/ocdkamfz3KxH+4oNYDaavbs1HGKS/DEw2YKAf3c4G2sBoCC9pf4JA2LdyxCa1LTB4Jxq2UBUMwP1Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCQPqIA0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A3EB9C2BBFC;
	Sat, 13 Apr 2024 13:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713013361;
	bh=1hfFJpbVy+jRqc4NBcjfKebyqWZeLEI6ADFhHCGKzT4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=CCQPqIA06KHZZ/+XG8gQbIoK5NvuyjL91mRzOaJYMlENGMi4mzkudX8VdVSe/EAep
	 Q5aUgzhl3cl1L3gowy5Hw3YE35ElF+LyYQ+r3Zld2CofPeD4Lr5TvL1b5LARxXcQnD
	 HmAKjbHSYTFOzQxax7D2mniLZoS9fW7vPWoCIY7bFbXcVLol3W1uHc5Uu9I3+p+tHQ
	 isds+FcGceR080wyqyyBb4UhGgpU3N008ZJ1pBcWAFUcUt+T9SOApBMJhLR+2gsHyO
	 bq1UZHae8A4WP/sY9MKbN8yqda2ZHOQtatWVH4IIjrX0Yc689WKyqPBc+NmWtlrm5K
	 Z2Q9+ZRE7BiFw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0BBC04FFF;
	Sat, 13 Apr 2024 13:02:41 +0000 (UTC)
From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL_via_B4_Relay?= <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Sat, 13 Apr 2024 16:01:40 +0300
Subject: [PATCH net 2/2] net: dsa: mt7530: fix port mirroring for MT7988
 SoC switch
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240413-b4-for-net-mt7530-fix-mirroring-to-local-port-and-mt7988-v1-2-476deff8cc06@arinc9.com>
References: <20240413-b4-for-net-mt7530-fix-mirroring-to-local-port-and-mt7988-v1-0-476deff8cc06@arinc9.com>
In-Reply-To: <20240413-b4-for-net-mt7530-fix-mirroring-to-local-port-and-mt7988-v1-0-476deff8cc06@arinc9.com>
To: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>, 
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Holger Stadali <hs@giax.de>, 
 Bartel Eerdekens <bartel.eerdekens@constell8.be>, mithat.guner@xeront.com, 
 erkin.bozoglu@xeront.com, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713013352; l=1595;
 i=arinc.unal@arinc9.com; s=arinc9-patatt; h=from:subject:message-id;
 bh=J5sBZDEYQ2MZhOw2PxMAD+gQryIOB3G0EIw5h33fGKY=;
 b=1ey++0YizyHi3vcP2NlwKUdn8ZXxyN89dYXm/TAlv6xdycNAjjkoeViF08Xq34iWLaB/yBlgs
 7aq3qAX1yCuA5RcztQ1SxOoidtaDCWL3nktMXq4ac2BoLg8BcYRTy5I
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=VmvgMWwm73yVIrlyJYvGtnXkQJy9CvbaeEqPQO9Z4kA=
X-Endpoint-Received: by B4 Relay for arinc.unal@arinc9.com/arinc9-patatt
 with auth_id=115
X-Original-From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Reply-To: arinc.unal@arinc9.com

From: Arınç ÜNAL <arinc.unal@arinc9.com>

The "MT7988A Wi-Fi 7 Generation Router Platform: Datasheet (Open Version)
v0.1" document shows bits 16 to 18 as the MIRROR_PORT field of the CPU
forward control register. Currently, the MT7530 DSA subdriver configures
bits 0 to 2 of the CPU forward control register which breaks the port
mirroring feature for the MT7988 SoC switch.

Fix this by using the MT7531_MIRROR_PORT_GET() and MT7531_MIRROR_PORT_SET()
macros which utilise the correct bits.

Fixes: 110c18bfed41 ("net: dsa: mt7530: introduce driver for MT7988 built-in switch")
Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/net/dsa/mt7530.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index b84e1845fa02..8090390edaf9 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -1883,14 +1883,16 @@ mt7530_port_vlan_del(struct dsa_switch *ds, int port,
 
 static int mt753x_mirror_port_get(unsigned int id, u32 val)
 {
-	return (id == ID_MT7531) ? MT7531_MIRROR_PORT_GET(val) :
-				   MIRROR_PORT(val);
+	return (id == ID_MT7531 || id == ID_MT7988) ?
+		       MT7531_MIRROR_PORT_GET(val) :
+		       MIRROR_PORT(val);
 }
 
 static int mt753x_mirror_port_set(unsigned int id, u32 val)
 {
-	return (id == ID_MT7531) ? MT7531_MIRROR_PORT_SET(val) :
-				   MIRROR_PORT(val);
+	return (id == ID_MT7531 || id == ID_MT7988) ?
+		       MT7531_MIRROR_PORT_SET(val) :
+		       MIRROR_PORT(val);
 }
 
 static int mt753x_port_mirror_add(struct dsa_switch *ds, int port,

-- 
2.40.1



