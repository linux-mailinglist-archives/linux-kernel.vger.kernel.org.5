Return-Path: <linux-kernel+bounces-161035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A87148B461F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 13:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D5211F26122
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 11:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057034C62E;
	Sat, 27 Apr 2024 11:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNgFlxNQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B154AEE6;
	Sat, 27 Apr 2024 11:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714217141; cv=none; b=ZVEBwpv++dPvUVeQBmOzNsCHk/iVS4w9I2wmMSiu7fG1cPxEoRGdD9oioESba345mIjeJybcqZGekx06hnbg0nXVVykR1A/wsi6+opmK1G/7Jt+diNUCtVvhIrqIP3RAF7kKceHf4g/Txa3iMXSZ8Q6ldwDLIG2ihWISoa1j7kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714217141; c=relaxed/simple;
	bh=mTWwU46l7ts0rLk94ziiyqQWkCiH5M84Cw14kTJlkHQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=L/pY8TDUwO5+GtfbXukiOlldZZVII2bHzIhygpM74Z1WYEAsaD14LETFI7eOkAlgxVNIW72rBizVo+7g21IBRerlTG8CwKn75cbbjHe2VR+TySDJm1Xj7d4V67retSbUrLaq6HqIprqbMInWFGlskTlNTLMat2cSYOH5BZ3SqJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNgFlxNQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB941C113CE;
	Sat, 27 Apr 2024 11:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714217140;
	bh=mTWwU46l7ts0rLk94ziiyqQWkCiH5M84Cw14kTJlkHQ=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=nNgFlxNQKbEEYwn7siUSyUFtWsuUFnKXgVnZumKWsR9jlyXZOvWxv+O3QmwybfN86
	 wUFH79cBOEwTpC3eeRHVBveHaFWX2vHtleW5M4jqzA48l7xDjSgzIopRVnYcDLuMwl
	 85Fw2cQ3F+dZbup4KTBKg2V4vqR7C8ImPysTSogp94FBwOCXeffSX9SDCvA/VhlQZW
	 ehl2L2+EFybStbc3Dd1Fj/eTPynDKMaLMaP6MSmGvNRFkHNZoV8frfYrTsZBCOScmy
	 FezswZq6askDMrxJupR4V8oLM8SqHqWsenKvy9suLNkf1r3k9p1hw3i74M/Y9Dlmly
	 spnUu9Q9UrKEg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9466FC4345F;
	Sat, 27 Apr 2024 11:25:40 +0000 (UTC)
From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL_via_B4_Relay?= <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Sat, 27 Apr 2024 14:24:42 +0300
Subject: [PATCH net-next] net: dsa: mt7530: do not set MT7530_P5_DIS when
 PHY muxing is being used
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240427-for-netnext-mt7530-do-not-disable-port5-when-phy-muxing-v1-1-793cdf9d7707@arinc9.com>
X-B4-Tracking: v=1; b=H4sIAHngLGYC/x3NQQ6CMBBG4auQWfsnFWkavIpxgXYKk8iUtFUxh
 LtbXb7N9zbKnIQznZuNEr8kS9Qax0ND92nQkSG+NrWm7UzXOoSYoFyU14K5OHsy8BEaC7zk4fZ
 gLDEVi/fEimX6YH6uoiNcCDZ40/fWO6r6kjjI+j9fqIL4iXTd9y/zSRLdkwAAAA==
To: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>, 
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714217117; l=1747;
 i=arinc.unal@arinc9.com; s=arinc9-patatt; h=from:subject:message-id;
 bh=VasDaHgnHDdOqWDdjqgzeJKJ1I8lWhlpo+kDcDotXgI=;
 b=/c0zUKnpKv7yif6iCmwhpJFhCS5YvTpA9cc1RESiRDOk46zS5DwLrpcI1CAT0JWV8N7QaGoBO
 v5mzrNL+eSQDg2l2KC18hVg911AX5J52ZSHtNadCU93H5Xn9sM2FVZt
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=VmvgMWwm73yVIrlyJYvGtnXkQJy9CvbaeEqPQO9Z4kA=
X-Endpoint-Received: by B4 Relay for arinc.unal@arinc9.com/arinc9-patatt
 with auth_id=115
X-Original-From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Reply-To: arinc.unal@arinc9.com

From: Arınç ÜNAL <arinc.unal@arinc9.com>

When the PHY muxing feature is in use, port 5 won't be defined in the
device tree. Because of this, the type member of the dsa_port structure for
this port will be assigned DSA_PORT_TYPE_UNUSED. The dsa_port_setup()
function calls ds->ops->port_disable() when the port type is
DSA_PORT_TYPE_UNUSED.

The MT7530_P5_DIS bit is unset when PHY muxing is being used.
mt7530_port_disable() which is assigned to ds->ops->port_disable() is
called afterwards. Currently, mt7530_port_disable() sets MT7530_P5_DIS
which breaks network connectivity when PHY muxing is being used.

Therefore, do not set MT7530_P5_DIS when PHY muxing is being used.

Fixes: 377174c5760c ("net: dsa: mt7530: move MT753X_MTRAP operations for MT7530")
Reported-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
Hello.

I've sent this to net-next as the patch it fixes is on the current
development cycle.
---
 drivers/net/dsa/mt7530.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 2b9f904a98f0..07b6da3ae97c 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -1220,7 +1220,7 @@ mt7530_port_disable(struct dsa_switch *ds, int port)
 	if (priv->id != ID_MT7530 && priv->id != ID_MT7621)
 		return;
 
-	if (port == 5)
+	if (port == 5 && priv->p5_mode == GMAC5)
 		mt7530_set(priv, MT753X_MTRAP, MT7530_P5_DIS);
 	else if (port == 6)
 		mt7530_set(priv, MT753X_MTRAP, MT7530_P6_DIS);

---
base-commit: 5c4c0edca68a5841a8d53ccd49596fe199c8334c
change-id: 20240427-for-netnext-mt7530-do-not-disable-port5-when-phy-muxing-7ff5fd0995d7

Best regards,
-- 
Arınç ÜNAL <arinc.unal@arinc9.com>



