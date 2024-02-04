Return-Path: <linux-kernel+bounces-51796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D09848F5B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 17:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A3C7283CF0
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 16:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1223A27E;
	Sun,  4 Feb 2024 16:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l54+HlCl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F104241E5;
	Sun,  4 Feb 2024 16:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707064492; cv=none; b=GNQ3N347dYbmwziGfiEF+o+JPrm8SuzflZ3nXX36AaAMCzNOjJIm2avjlAE+YiQ9eYMShK0koGgO3ASNgu/3Dmxv8e4GxJV9helrjnap4tO7Wkc+Pv3JEzSmhorYRlOQJ6MKTcm+fj2qNRbqBfjjBNVkBoKpUdQpwQhqnmO1WVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707064492; c=relaxed/simple;
	bh=QNJ/FUkek4zfpJCs3ALbQrDP6k/nsMeMTN9krAwrpS0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XjOk33ysxOjEAYiiGzj1FW8VjEU86IRMCdIWpQv96WqTLp/VUAuItjbthIga737TVdl4y91dQwec3zuZfi9zgBDdCIHkGy4W6qPZ/8x7WyOk4XCL6mNUc6OTmFWdzvd8CpQ2bFMsENEwA4pONWV7NXwrxJN/X5ONdh4FYFkXHM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l54+HlCl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1C173C43141;
	Sun,  4 Feb 2024 16:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707064492;
	bh=QNJ/FUkek4zfpJCs3ALbQrDP6k/nsMeMTN9krAwrpS0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=l54+HlClKDclISIpoGSFFfwupmj41otZ+Ct54j/DsI9VBtsl7eBSyNJDIzP/Edu1B
	 RFa8zILbY/S+swFIVW0SwJqE7zC74k2apqiZlSNWEJ6i4CPwy5+pirP/H143rspyaM
	 uq/zis8oqHbpRot13pkWJk4a6K07JYSgaDhJ4a/m+ty8Lj5AeK3RCK6cMjhcq77D6N
	 EOhZXhGlRJcB6HkhZCrDark7L9U+jpxyBMp3D7sAo/EksG+4IQld2nxNn96VjHXZnV
	 Bm+58DYWCIM1fjoS5zfnCfczee97NPjtnmwgM/w0WKJmeNU2VERuZp/TbBjQ9cmqPW
	 lqnPicBULggYA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09ADFC48295;
	Sun,  4 Feb 2024 16:34:52 +0000 (UTC)
From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= via B4 Relay
 <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Sun, 04 Feb 2024 19:34:25 +0300
Subject: [PATCH net-next v4 7/7] net: dsa: mt7530: do not clear
 config->supported_interfaces
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id:
 <20240204-for-netnext-mt7530-improvements-2-v4-7-02bf0abaadb8@arinc9.com>
References:
 <20240204-for-netnext-mt7530-improvements-2-v4-0-02bf0abaadb8@arinc9.com>
In-Reply-To:
 <20240204-for-netnext-mt7530-improvements-2-v4-0-02bf0abaadb8@arinc9.com>
To: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>, 
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
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>, 
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707064489; l=1302;
 i=arinc.unal@arinc9.com; s=arinc9-patatt; h=from:subject:message-id;
 bh=PehRtB3XZCHuW/U8urBTuyz7o46J8EJ0NxZ+pj2gVEw=;
 b=l9qsIaVo15nnVv8Z8wVDB9smKXlleuos9uaU31zcCJnya5rEbMkgJt3By0WLXmoAnBOVDQLlg
 bX4jVtZvx1ZAmfTQAd7/LSRbI6HcK/aVaaN5yt72t04mxg4JrmjRmM9
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=VmvgMWwm73yVIrlyJYvGtnXkQJy9CvbaeEqPQO9Z4kA=
X-Endpoint-Received:
 by B4 Relay for arinc.unal@arinc9.com/arinc9-patatt with auth_id=115
X-Original-From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Reply-To: <arinc.unal@arinc9.com>

From: Arınç ÜNAL <arinc.unal@arinc9.com>

There's no need to clear the config->supported_interfaces bitmap before
reporting the supported interfaces as all bits in the bitmap will already
be initialized to zero when the phylink_config structure is allocated. The
"config" pointer points to &dp->phylink_config, and "dp" is allocated by
dsa_port_touch() with kzalloc(), so all its fields are filled with zeroes.

There's no code that would change the bitmap beforehand. Remove it.

Acked-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/net/dsa/mt7530.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 08d5d7dd5969..c7e1af1ea4bb 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2573,8 +2573,6 @@ static void mt7531_mac_port_get_caps(struct dsa_switch *ds, int port,
 static void mt7988_mac_port_get_caps(struct dsa_switch *ds, int port,
 				     struct phylink_config *config)
 {
-	phy_interface_zero(config->supported_interfaces);
-
 	switch (port) {
 	/* Ports which are connected to switch PHYs. There is no MII pinout. */
 	case 0 ... 3:

-- 
2.40.1


