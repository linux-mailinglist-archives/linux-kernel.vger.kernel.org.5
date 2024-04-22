Return-Path: <linux-kernel+bounces-152849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFE98AC53F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F9131F213C8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C115255E72;
	Mon, 22 Apr 2024 07:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMlUQ7NV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B3CC8F3;
	Mon, 22 Apr 2024 07:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713770131; cv=none; b=hDivWNG/ybfFVTsWdXsxqfPNoPvFVZPSE5FK0zQ1yZpq/mwPxVEx1vseZGMPhZdyDSX0CHKVj8b3uIdsFk93Fj20xnMT17n5AACWUKoEqJ/I1KEscFNRB1+uU8cRoW8gFHzZe/EUq1a6xPqXIRwIKzRFs8rSsaSKOJqTKbNttSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713770131; c=relaxed/simple;
	bh=Opp1CZsglNYhlA4uuP5oQQWhKy/UVwr883h+FPxyU0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mOQ+2MmoYrrMdGTAB/KAbt/QEjX35aiv2icN8/JsR4MfthR3kn5BrkrQmCEO4o8yZSK+3EmyQMbJii5r4VlaN+GDhk+nev6JFM/E0VfSXA/LtSpGiTlX4jPx2fHwaufwk5Pn7cyWszyZ0UEc29Ff0EqM+aimQLJFHZpXlXxsj9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMlUQ7NV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1D25CC4AF15;
	Mon, 22 Apr 2024 07:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713770131;
	bh=Opp1CZsglNYhlA4uuP5oQQWhKy/UVwr883h+FPxyU0s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hMlUQ7NVm2JPTLZxxqwY7a4yuEAnFs9SAvZX4Qfu1szOLwcs5UhI1Fald//FVnbUA
	 1v85vuFpHCIEOn8jIgCfHwwW5XeQWemcjvDFW6SEXOgPmS7oU3KF4PiT5km098RyNN
	 hHlmD8bDC8NF2rxRP8m+mTYYqiht5Jy3ryPnFhP6YlXW0D9TLUyXK8oOulC3MgL1Ms
	 TFyeX+ZzsVK3fI0UgOJXpsMFm8V1nzmgbBJeexEamtSmoYhvuS0kJbWc/wbqDFSJNX
	 pwzUZqjOXROPqkEuwzg5e7nTsDOnaXxqy342KwEi3CHXoYlbAf+J24hyqyDjFBBHhJ
	 I1yizjUar55FQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E064C07E8F;
	Mon, 22 Apr 2024 07:15:31 +0000 (UTC)
From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL_via_B4_Relay?= <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Mon, 22 Apr 2024 10:15:17 +0300
Subject: [PATCH net-next v2 10/15] net: dsa: mt7530: get rid of function
 sanity check
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240422-for-netnext-mt7530-improvements-4-v2-10-a75157ba76ad@arinc9.com>
References: <20240422-for-netnext-mt7530-improvements-4-v2-0-a75157ba76ad@arinc9.com>
In-Reply-To: <20240422-for-netnext-mt7530-improvements-4-v2-0-a75157ba76ad@arinc9.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713770127; l=960;
 i=arinc.unal@arinc9.com; s=arinc9-Xeront; h=from:subject:message-id;
 bh=HUYFdupAh6c43NX7egvGTzUNU8mBqV4dnjn+5D+OLfw=;
 b=jChabMEZw2/XRVWzIE7N3hjTPvLZVl7ixRyVJJEQ6O2gjUnkGwTFgbr5jtZOwuIIpHRoxMGNt
 fNVpm/KdCTvCzOTtWcLuoNBNPHhn//ZQyRRieQ9Y3HCqtK8wjqVKOnM
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=z49tLn29CyiL4uwBTrqH9HO1Wu3sZIuRp4DaLZvtP9M=
X-Endpoint-Received: by B4 Relay for arinc.unal@arinc9.com/arinc9-Xeront
 with auth_id=137
X-Original-From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Reply-To: arinc.unal@arinc9.com

From: Arınç ÜNAL <arinc.unal@arinc9.com>

Get rid of checking whether functions are filled properly. priv->info which
is an mt753x_info structure is filled and checked for before this check.
It's unnecessary checking whether it's filled properly.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/net/dsa/mt7530.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 8a141f849673..842c2573dfe4 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -3232,13 +3232,6 @@ mt7530_probe_common(struct mt7530_priv *priv)
 	if (!priv->info)
 		return -EINVAL;
 
-	/* Sanity check if these required device operations are filled
-	 * properly.
-	 */
-	if (!priv->info->sw_setup || !priv->info->phy_read_c22 ||
-	    !priv->info->phy_write_c22 || !priv->info->mac_port_get_caps)
-		return -EINVAL;
-
 	priv->id = priv->info->id;
 	priv->dev = dev;
 	priv->ds->priv = priv;

-- 
2.40.1



