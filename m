Return-Path: <linux-kernel+bounces-161341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF778B4AF4
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 11:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 809CA1F2164B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 09:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6801154BFD;
	Sun, 28 Apr 2024 09:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZKXGUVw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D6E33C8;
	Sun, 28 Apr 2024 09:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714296022; cv=none; b=icaj8fNXpTlfutY+biaE+YcNC4i9Xzy5QtlXYwYyHdqJP9QEpsbu6lvcpRNKDnHXN5iPBWdZrUp/Wpf1NbYonCZL+ZY2dH5LEGdYQkyal1rsIl2dHGtMUqBRptCidUfQYsFLIDL8ofJ1W4S+RDlqBwqL3t54llAvshePUuh5tb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714296022; c=relaxed/simple;
	bh=tTcSI2He67CI3Bx08DQeboEo2tW7XByRd7BFoSlFVNI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rRj5qsX6N7hEAqEBNDLcgq/6BbiG/8zDInMT+Sl7ZL8HBuslZD04P6G8kO9CFq85Tz1bxABcp3hCycS+gfNNt5OXLQzBFggilX02Cyazrq2GkO/CuL7UUdaIZmc+5l86JCtIGaPRAvFZR9EPXzc7qtngYmmpzLRB5OypfQxmius=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZKXGUVw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1FCC3C113CC;
	Sun, 28 Apr 2024 09:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714296022;
	bh=tTcSI2He67CI3Bx08DQeboEo2tW7XByRd7BFoSlFVNI=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=XZKXGUVwBO3S/f+J33iIx2bUkBDqcBhVQNzXpdKlZHIXBp7tHqCinBxD/4a3uUXEq
	 oVb0wiN1anfd9DWl3LtauefrWiszXFknLYEiIRhHkK78HeP5s1SOiz5Xfl+/7Sp1fh
	 3R3dHd9u3lJZINnAEQBQOV3BzCCS+XSDOXpwdtIZNcda+6ODZVhguXm0q6Dudv7/hu
	 hrKVaQPUEokY3oz4qpHEhz2HkJ6Q1hETt1zVaH38dydhIz5p27YduGZVsokX0kytJp
	 0gMxJy2W07ZdirlDbmW1z7Nu6oaAxv53XuiwSJyfye0wOLNHWs4Pb2JGUSZ+uw+/Md
	 VsqwZaY1CJquw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A01EC4345F;
	Sun, 28 Apr 2024 09:20:22 +0000 (UTC)
From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL_via_B4_Relay?= <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Sun, 28 Apr 2024 12:19:58 +0300
Subject: [PATCH net-next v2] net: dsa: mt7530: do not set MT7530_P5_DIS
 when PHY muxing is being used
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240428-for-netnext-mt7530-do-not-disable-port5-when-phy-muxing-v2-1-bb7c37d293f8@arinc9.com>
X-B4-Tracking: v=1; b=H4sIAL0ULmYC/6WOQQqDMBBFryKz7pQYlZCueo/iwpqJDtREktQq4
 t2beoUuHx/e+ztECkwRbsUOgRaO7F0GeSmgHzs3ELLJDFLIWtRSofUBHSVHa8IpqaYSaDw6n9B
 w7J4vwtmH1OBnJIfzuOH0XtkNqKxtrBFaN0ZBts+BLK9n+QFZiD8jtHkZOSYftvPSUp773/Wlx
 BKVrnpjtVFKqHsX2PX62vsJ2uM4voIqUjcJAQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714295997; l=2134;
 i=arinc.unal@arinc9.com; s=arinc9-patatt; h=from:subject:message-id;
 bh=mooBBatpyIktEez2DpRO7+tS0DbjK7qafqYlayMk1R4=;
 b=EH/F59K96vk3QVfn9tauaQDX4oX1KGLZrhENnMQ3zPIzdDGpVuG9d19WaDUmDkSL9oXlKYEUD
 RqTQzjjJFslCKXPH20Nulu1HorEX1WU6Kmh1q5sJpvuvG/541ly6mX6
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=VmvgMWwm73yVIrlyJYvGtnXkQJy9CvbaeEqPQO9Z4kA=
X-Endpoint-Received: by B4 Relay for arinc.unal@arinc9.com/arinc9-patatt
 with auth_id=115
X-Original-From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Reply-To: arinc.unal@arinc9.com

From: Arınç ÜNAL <arinc.unal@arinc9.com>

DSA initalises the ds->num_ports amount of ports in
dsa_switch_touch_ports(). When the PHY muxing feature is in use, port 5
won't be defined in the device tree. Because of this, the type member of
the dsa_port structure for this port will be assigned DSA_PORT_TYPE_UNUSED.
The dsa_port_setup() function calls ds->ops->port_disable() when the port
type is DSA_PORT_TYPE_UNUSED.

The MT7530_P5_DIS bit is unset in mt7530_setup() when PHY muxing is being
used. mt7530_port_disable() which is assigned to ds->ops->port_disable() is
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
Changes in v2:
- Add a comment to the code.
- Improve the patch log.
- Link to v1: https://lore.kernel.org/r/20240427-for-netnext-mt7530-do-not-disable-port5-when-phy-muxing-v1-1-793cdf9d7707@arinc9.com
---
 drivers/net/dsa/mt7530.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 2b9f904a98f0..2090f34e5289 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -1220,7 +1220,8 @@ mt7530_port_disable(struct dsa_switch *ds, int port)
 	if (priv->id != ID_MT7530 && priv->id != ID_MT7621)
 		return;
 
-	if (port == 5)
+	/* Do not set MT7530_P5_DIS when port 5 is being used for PHY muxing. */
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



