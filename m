Return-Path: <linux-kernel+bounces-54008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F83D84A912
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3588B296DAA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EC85473D;
	Mon,  5 Feb 2024 22:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHkFi07e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401C94F898;
	Mon,  5 Feb 2024 22:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707170895; cv=none; b=Z+i6UY4/lO6K/eiy4Xe2ZPUuGLiCVLlVozLcsGwtBb8RgDxkz3xZU1hovC4p7VRtORqrCR8aNX4BehyxmC7RU+fCXRwVBpkmWPfZqSrKQ7pP73CFDka40KxNG/VfOv20U0QAex1BUvhDwRr6wEDxGwVC2hxRd2WOILzbqGXxyEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707170895; c=relaxed/simple;
	bh=eSAMiQYO18/EtJkI2c545ErONhke45hKS5pG6am6UZo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rGILhE10YaH3htSH8XNEW/+7KELseMLWMy/qYQg8hpQs3rOzyLNNOdTv6M/oX/7hXwIYgVVzzyZL1CmyvSTJgcNo98xZce167PStSy0Wcih+3/PilHyB4FGfef+H8ZPS+9QqYTWyP++7WS3gxGQ3L3ktoiWAjiL163QYtxhJsXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHkFi07e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BA60AC43394;
	Mon,  5 Feb 2024 22:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707170894;
	bh=eSAMiQYO18/EtJkI2c545ErONhke45hKS5pG6am6UZo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ZHkFi07eqePPgcqTrbsaLzFQW3jzw5y0aLssRJQX0UFpK0a+4VpamVOwT2WbMMTgP
	 otmbL2/Q2yzbCwUA9S7V2WSS03r8erJE4lOcmcedTO+FhGXxxPl6XSrJ3yrH1e9ulH
	 qw4HNjKAJYT7CFZVV8kay2OZ0GnqoGP1fsLLtm0fqfp3wBInquB3bbX3mOefxFtFp0
	 3J5Ni5Jd/mupT3FF+HjdQ1nRZT6yMRld5hoSYHitN5iw7S83NIj+UHkKWPMAINzK+C
	 KADnRazg7WCmx5tDc2C3lN61GdHWtNmoVKqXNdFbxY8fQ+Nc+vKqUgkRh935xTmZRm
	 JnQ0Bw/z0JAsg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5864C4829C;
	Mon,  5 Feb 2024 22:08:14 +0000 (UTC)
From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= via B4 Relay
 <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Tue, 06 Feb 2024 01:08:08 +0300
Subject: [PATCH net-next v5 7/7] net: dsa: mt7530: do not clear
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
 <20240206-for-netnext-mt7530-improvements-2-v5-7-d7d92a185cb1@arinc9.com>
References:
 <20240206-for-netnext-mt7530-improvements-2-v5-0-d7d92a185cb1@arinc9.com>
In-Reply-To:
 <20240206-for-netnext-mt7530-improvements-2-v5-0-d7d92a185cb1@arinc9.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707170890; l=1302;
 i=arinc.unal@arinc9.com; s=arinc9-patatt; h=from:subject:message-id;
 bh=gvaXZPxx1roTT4+mw5MzgfJe6pP7pdjnL2vUf+qUSy4=;
 b=2y+1C1w+kG/Rf4v/HYdsGB4n39PCvJsb8Gne5yNMqbYUhOaICYtGyNsOfsOo6l6HlCir4zV5U
 yiQaMMZrhx5BcESuWP7ftnYrOlNH+JGo6VngDtfH5l0woB3SE10tidx
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
index 4ca7ba94788e..aed1ea6815ee 100644
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


