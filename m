Return-Path: <linux-kernel+bounces-68492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF09D857B16
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 943FC1C20CCA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8A659B61;
	Fri, 16 Feb 2024 11:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pFNyw18O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB0758236;
	Fri, 16 Feb 2024 11:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708081544; cv=none; b=CYAaKunjipyJNppuVOok+4O++qcYaqMK5E7ARWYEw6fHiXBEXTA6kz2+aBxpsV03t/IXFB96/WvdzFnJMUVixqbTWVUi/gxpz5clRgrK4jEdQZZRY7zuaNiFxSjHDcu1ocWjqKOQ8PfgkdnMuqIf0aa9crE01hkBD4UZzliuIpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708081544; c=relaxed/simple;
	bh=wUpyw43HcHACBQ/8AUAV0rAR4ahB+zKQE8l7LVuV9Hs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PV/33nBABTduxLHq65wwIcy3C2F/WVaDC3YyVmBKnazx480d1fp8KAmfI5m881Arh0fnilB5uBU8bkEH8F+f6yjrDkZMlogOLhR4QUJ21q3wxU3v2/EdLIiCGKuEQjM+3X4rndf2tsd7z1VLDdz3sLtrvMDPScBa/tSlCUVKZUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pFNyw18O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A2EEC433B2;
	Fri, 16 Feb 2024 11:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708081544;
	bh=wUpyw43HcHACBQ/8AUAV0rAR4ahB+zKQE8l7LVuV9Hs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=pFNyw18OAAkzXv/oyOGsjok5ynwPiWn+63+4hPnZ3AHlMi9lWz4tz9bgdca28pzdV
	 rIVVaaL8FNfdP3bz+BFtuPVdCYsiz4OUijLD5/ekJ/bfQIqo/D0njzYm2V5okaDo93
	 XL0M3SKIU2JjwvD5Q/VTI9UoXZtGezhljkckFx2yRHl71MvUR1O0IiUBD/xDB/T36W
	 ZAwKZDon2Dc0kdYh3KWr5cJ1jKme5yE+YETlVj+z4s6rWqSNBfIlyhv8VI+vihNOcf
	 QMk1kJ0fsMISQDX/EUEKScjeSnGexdLtwfSXc7Mmiaouhes28TGVc/GjYYqKUjsjXS
	 5KEePLwYnEZAg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08323C48BF0;
	Fri, 16 Feb 2024 11:05:44 +0000 (UTC)
From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= via B4 Relay
 <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Fri, 16 Feb 2024 14:05:31 +0300
Subject: [PATCH net-next v2 3/8] net: dsa: mt7530: do not use SW_PHY_RST to
 reset MT7531 switch
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id:
 <20240216-for-netnext-mt7530-improvements-3-v2-3-094cae3ff23b@arinc9.com>
References:
 <20240216-for-netnext-mt7530-improvements-3-v2-0-094cae3ff23b@arinc9.com>
In-Reply-To:
 <20240216-for-netnext-mt7530-improvements-3-v2-0-094cae3ff23b@arinc9.com>
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
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708081540; l=1298;
 i=arinc.unal@arinc9.com; s=arinc9-patatt; h=from:subject:message-id;
 bh=ecurYkRWOTqqGU2AKHni4Fzup3XR61+gzZ3STlqM5Z4=;
 b=fEWM74MriRVDSMV+6+deRf2A3cu97D6P21qRqy0TPnGl++e++WtH/c3X2a+JfqJ/BSw+2GTJm
 avzMhem9AbqCFQ5L/8bWGjAU7HZJ+aT0WpmyIJnwgpA6Q1ZcnsppKl/
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=VmvgMWwm73yVIrlyJYvGtnXkQJy9CvbaeEqPQO9Z4kA=
X-Endpoint-Received:
 by B4 Relay for arinc.unal@arinc9.com/arinc9-patatt with auth_id=115
X-Original-From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Reply-To: <arinc.unal@arinc9.com>

From: Arınç ÜNAL <arinc.unal@arinc9.com>

According to the document MT7531 Reference Manual for Development Board
v1.0, the SW_PHY_RST bit on the SYS_CTRL register doesn't exist for
MT7531. This is likely why forcing link down on all ports is necessary for
MT7531.

Therefore, do not set SW_PHY_RST on mt7531_setup().

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/net/dsa/mt7530.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 5cfd303b773f..296711fd5c43 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2451,14 +2451,12 @@ mt7531_setup(struct dsa_switch *ds)
 	val = mt7530_read(priv, MT7531_TOP_SIG_SR);
 	priv->p5_sgmii = !!(val & PAD_DUAL_SGMII_EN);
 
-	/* all MACs must be forced link-down before sw reset */
+	/* Force link down on all ports before internal reset */
 	for (i = 0; i < MT7530_NUM_PORTS; i++)
 		mt7530_write(priv, MT7530_PMCR_P(i), MT7531_FORCE_LNK);
 
 	/* Reset the switch through internal reset */
-	mt7530_write(priv, MT7530_SYS_CTRL,
-		     SYS_CTRL_PHY_RST | SYS_CTRL_SW_RST |
-		     SYS_CTRL_REG_RST);
+	mt7530_write(priv, MT7530_SYS_CTRL, SYS_CTRL_SW_RST | SYS_CTRL_REG_RST);
 
 	if (!priv->p5_sgmii) {
 		mt7531_pll_setup(priv);

-- 
2.40.1


