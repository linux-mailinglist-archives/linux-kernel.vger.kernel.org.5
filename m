Return-Path: <linux-kernel+bounces-32333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A39835A51
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 06:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD1E31F234E6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 05:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747266AC0;
	Mon, 22 Jan 2024 05:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NqIBtLIM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C534C8E;
	Mon, 22 Jan 2024 05:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705901758; cv=none; b=eRtycW3ors8MZEXGTBQGLYZgDOLRpk2YtQgQHgFaC54X+KzXCv3/N2+ydMmnOWY1h77OI4tmAQ34R6M8dSFpOIlAAqDcIBHEbKDpIapanKx4xomf+7HvCeAyPLKSzYDND0FX5n0cmuxsgKUifd34ZCFOJ0R3Pw/wdMPbDLqj3Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705901758; c=relaxed/simple;
	bh=sqOYOjwzwIWmabwtLIfTKhD0ZRp7ECZfLXHIbLfNCCI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kP6/LwbU9FJ/qOczIEtrx64sGksu260GQuZTJ//bMMSBQwBsBWOElttYrKs1Gf2dzLG65kJ4q2P8er76I5MYP2q8HKGPK0bPsDmUn/IRAVSIRkCAHXhi74dFbKYNCWmYNctWO0mUP+/TSDC/l4cF07kSh53GBnwh6asABcgK9KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NqIBtLIM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44B4EC43390;
	Mon, 22 Jan 2024 05:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705901758;
	bh=sqOYOjwzwIWmabwtLIfTKhD0ZRp7ECZfLXHIbLfNCCI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=NqIBtLIMSvVPdNPkNIfYmr4xaZc7FvAgeivMtkZVhsR68UIFhVPttfEfxqFi+kAxW
	 OuL9KMZLLQeRZ+y3aHGtXBbyxGUV0EfgRX7WWPWhmRbMQ5lmOwyeeWCJDhxveHNby+
	 ZryP9leWecF8NTYYicNE4yoB4JFyUrQLgrXNwclICwSV0xAb8NDjm8eZdgPped/U7K
	 M/Apg/u9ZC/iVCIZH+7pPAFRuoOypnC+yNZlbR7QOTJstxtKVwLLZ28m2Ld6hmNW56
	 wns09g8o9FwBvGlM799vW8HL33/uLneMbgQ4GT/GMl3qAB0vASWMA5wp8hQKrqiFN6
	 XQhL2ESDzAxUA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB8EC47DDB;
	Mon, 22 Jan 2024 05:35:58 +0000 (UTC)
From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= via B4 Relay
 <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Mon, 22 Jan 2024 08:35:53 +0300
Subject: [PATCH net-next v3 2/7] net: dsa: mt7530: use p5_interface_select
 as data type for p5_intf_sel
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id:
 <20240122-for-netnext-mt7530-improvements-1-v3-2-042401f2b279@arinc9.com>
References:
 <20240122-for-netnext-mt7530-improvements-1-v3-0-042401f2b279@arinc9.com>
In-Reply-To:
 <20240122-for-netnext-mt7530-improvements-1-v3-0-042401f2b279@arinc9.com>
To: Daniel Golle <daniel@makrotopia.org>, 
 Landen Chao <Landen.Chao@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, 
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: mithat.guner@xeront.com, erkin.bozoglu@xeront.com, 
 Bartel Eerdekens <bartel.eerdekens@constell8.be>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705901755; l=1228;
 i=arinc.unal@arinc9.com; s=arinc9-patatt; h=from:subject:message-id;
 bh=eeyEB3sOOiz0wO/aOHC7vZ4jcupi1RnCW1Y9LU4gTrY=;
 b=hIKr4GuusrNypD6MbPMVuvEcxmkhEzS94rRRvDe6qBWSz+KkNMZbiGjjLB0fqADMlTsK/7i5T
 Le1XednZ9IIB52YpaxQcd9QPbMQQdAeDRXZ1NAxxSET9qU68nA4uWM4
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=VmvgMWwm73yVIrlyJYvGtnXkQJy9CvbaeEqPQO9Z4kA=
X-Endpoint-Received:
 by B4 Relay for arinc.unal@arinc9.com/arinc9-patatt with auth_id=115
X-Original-From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Reply-To: <arinc.unal@arinc9.com>

From: Arınç ÜNAL <arinc.unal@arinc9.com>

Use the p5_interface_select enumeration as the data type for the
p5_intf_sel field. This ensures p5_intf_sel can only take the values
defined in the p5_interface_select enumeration.

Remove the explicit assignment of 0 to P5_DISABLED as the first enum item
is automatically assigned 0.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Acked-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
---
 drivers/net/dsa/mt7530.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index ebfb3a7acfcd..9cbf18efa416 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -683,7 +683,7 @@ struct mt7530_port {
 
 /* Port 5 interface select definitions */
 enum p5_interface_select {
-	P5_DISABLED = 0,
+	P5_DISABLED,
 	P5_INTF_SEL_PHY_P0,
 	P5_INTF_SEL_PHY_P4,
 	P5_INTF_SEL_GMAC5,
@@ -776,7 +776,7 @@ struct mt7530_priv {
 	bool			mcm;
 	phy_interface_t		p6_interface;
 	phy_interface_t		p5_interface;
-	unsigned int		p5_intf_sel;
+	enum p5_interface_select p5_intf_sel;
 	u8			mirror_rx;
 	u8			mirror_tx;
 	struct mt7530_port	ports[MT7530_NUM_PORTS];

-- 
2.40.1


