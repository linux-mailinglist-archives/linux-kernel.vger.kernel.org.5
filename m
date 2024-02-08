Return-Path: <linux-kernel+bounces-57482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C879D84D9B2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 06:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6538F1F236EA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 05:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F5C6A8A0;
	Thu,  8 Feb 2024 05:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="duV/XThz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2DC67C73;
	Thu,  8 Feb 2024 05:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707371494; cv=none; b=uqUFyOcwUicHRzu8fVAhAyhiGFQ28Mmkk435CP2Z4gP+qnFaPcRoCNMNudNw0DzKr78XvJtiamvlzgMn+xcjSoiuUAw2wAzomHZoHqLR7mX5Uld/w5CAfu8ClT8ed8As5JSJ8JlYRQt3CTYPXF6+t9l7Ubkv+64aFAPg2GfKL+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707371494; c=relaxed/simple;
	bh=bdj2sXbKKEcSVYU72hwdKppcUWhM0GPYmoe4dwmAPtA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dNkTVtrrvJH5VBmGHsyXkAVT2rE3ZnSOOE3ExrBwy7evVJSDANiMFNKw4dG3ySmMaWXKzhS7fj15EX1PGPuNFh6IEltLrFeM0IEu/eSeEQ4Mk46o+oC2Qp7Q1EDlaPwmghqY6qVm+w1nn3eOhb3ENERPloR/mK4CbTLMzQot6eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=duV/XThz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 851BDC43143;
	Thu,  8 Feb 2024 05:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707371493;
	bh=bdj2sXbKKEcSVYU72hwdKppcUWhM0GPYmoe4dwmAPtA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=duV/XThzlx5FOGwO0s+gVWnEFACGOOH9JyeIdcBl2dgbcf/ZMutPwU95YUxJ4iyCY
	 jj1N/PtkeAgrfabl4VgS6bSHcahoQKQR1s690LM9vG9D5M2WkCucG4hSZmTrpG9hOp
	 7BFDttsgSJeYIjSvYJNpw+9M9Ta3feM2wJLHBO2X1Gn6rp4gHpCJRG1bSDVtbCrvsx
	 7AUXrO6CkGcCW6GtbA0lb5EZwGt+P0xl3ZspfmD+hWuxd/pGr+uSPy8dDYf4cR4sRw
	 gwAdJYHHmcCECDZjrKfcBCUrRM9pov30cCQY9hwJ4XgCd9UDS9WBK7p4VjVB0FUq/s
	 /XuCaCIIlzuTg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74549C4828F;
	Thu,  8 Feb 2024 05:51:33 +0000 (UTC)
From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= via B4 Relay
 <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Thu, 08 Feb 2024 08:51:35 +0300
Subject: [PATCH netnext 7/8] net: dsa: mt7530: put initialising PCS devices
 code back to original order
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id:
 <20240208-for-netnext-mt7530-improvements-3-v1-7-d7c1cfd502ca@arinc9.com>
References:
 <20240208-for-netnext-mt7530-improvements-3-v1-0-d7c1cfd502ca@arinc9.com>
In-Reply-To:
 <20240208-for-netnext-mt7530-improvements-3-v1-0-d7c1cfd502ca@arinc9.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707371489; l=1570;
 i=arinc.unal@arinc9.com; s=arinc9-patatt; h=from:subject:message-id;
 bh=/2CkKGukm0R4V69WhBvbbIMKcr0CwYye/LAy2VcbSV0=;
 b=cgYWWkSZCAhdXnX66ltsxkY85bNLVeKuY+rvkDi7qWt0AaUJl007QE1+K/VOCDyRWB+gn74zR
 AWtK+mJWyxICShfCxhlkB4+HkAyHCmc7TQzDaC61rogpfRYrm6NcEoh
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=VmvgMWwm73yVIrlyJYvGtnXkQJy9CvbaeEqPQO9Z4kA=
X-Endpoint-Received:
 by B4 Relay for arinc.unal@arinc9.com/arinc9-patatt with auth_id=115
X-Original-From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Reply-To: <arinc.unal@arinc9.com>

From: Arınç ÜNAL <arinc.unal@arinc9.com>

The commit fae463084032 ("net: dsa: mt753x: fix pcs conversion regression")
fixes regression caused by cpu_port_config manually calling phylink
operations. cpu_port_config was deemed useless and was removed. Therefore,
put initialising PCS devices code back to its original order.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/net/dsa/mt7530.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index e353c03dd1db..5c8ad41ce8cd 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2812,17 +2812,9 @@ static int
 mt753x_setup(struct dsa_switch *ds)
 {
 	struct mt7530_priv *priv = ds->priv;
-	int i, ret;
-
-	/* Initialise the PCS devices */
-	for (i = 0; i < priv->ds->num_ports; i++) {
-		priv->pcs[i].pcs.ops = priv->info->pcs_ops;
-		priv->pcs[i].pcs.neg_mode = true;
-		priv->pcs[i].priv = priv;
-		priv->pcs[i].port = i;
-	}
+	int ret = priv->info->sw_setup(ds);
+	int i;
 
-	ret = priv->info->sw_setup(ds);
 	if (ret)
 		return ret;
 
@@ -2834,6 +2826,14 @@ mt753x_setup(struct dsa_switch *ds)
 	if (ret && priv->irq)
 		mt7530_free_irq_common(priv);
 
+	/* Initialise the PCS devices */
+	for (i = 0; i < priv->ds->num_ports; i++) {
+		priv->pcs[i].pcs.ops = priv->info->pcs_ops;
+		priv->pcs[i].pcs.neg_mode = true;
+		priv->pcs[i].priv = priv;
+		priv->pcs[i].port = i;
+	}
+
 	if (priv->create_sgmii) {
 		ret = priv->create_sgmii(priv);
 		if (ret && priv->irq)

-- 
2.40.1


