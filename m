Return-Path: <linux-kernel+bounces-63045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2AE8529D5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C6C21C2279B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 07:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7346E17597;
	Tue, 13 Feb 2024 07:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="od4RxfPD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DE617566;
	Tue, 13 Feb 2024 07:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707809359; cv=none; b=ZU1vKPPhi3emw4iG1C1/eSNM6f0RVZP7wOZuoStvFG2hyJrX42rmsoh2zkX7vinwzBqZfHLY+QtSYseXPof9rP3R7/WJgs5GcmKuGGT6vb6qD5w2jltfBLo5DVXvq1mZWhitL5zJjrLq5FjiwvsjJzaJ5npXCoN+xPUDm6jyTu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707809359; c=relaxed/simple;
	bh=JDucEHydWXrSLUzuo2FD0MxyrhZzIoiGXp3GsPpCJRs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NoWQROs3yc/qISf0NDLyNT2RHQZHU2H2lIBctl7cCKuKSG2sfzGQu2sHjfIRwc8NyJqSiTIvjXS/3VsklliO/9Nx0iFCHJk9+ndlZMgfTH/MPneDKrrx+0cFCOwIFgR3qrqSLJ6QEVq8Bg65AEymVAIQIGqSDwMpNTDrK0PXu60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=od4RxfPD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1AE27C433F1;
	Tue, 13 Feb 2024 07:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707809359;
	bh=JDucEHydWXrSLUzuo2FD0MxyrhZzIoiGXp3GsPpCJRs=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=od4RxfPD9pFzMJie+sZrC/bwzACrs3e3hhPbZm2omcg6x0GgKb1hBxR5YHj9RbtbC
	 y8ObjrPHUQum4uFG5AXC4S/4u9OuSIXemHjUu2KClHWBbGHUKRZ3euzOzQXCtIJ484
	 jInraV0nel15LFgiTg57Zzw07JEfoG8BZF8gdjium6n33o0DFO8E+wDA46lKzexeDv
	 n1GPXw0CcYJ+aINpgrFfshU88F56jGCUIOfFfgaRIxnE2JuXuX61y0kFTObMXcpBGw
	 wuQlLlLmZUntIwD9M0Hg68yuBe9oCZZsLbSY1EJ3xv8oMxpX1jr7t6aKnJmpGu/Ekt
	 4XMK0Yvg++d4Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0853AC48260;
	Tue, 13 Feb 2024 07:29:19 +0000 (UTC)
From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= via B4 Relay
 <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Tue, 13 Feb 2024 10:29:05 +0300
Subject: [PATCH net-next v2] net: dsa: remove OF-based MDIO bus
 registration from DSA core
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240213-for-netnext-dsa-mdio-bus-v2-1-0ff6f4823a9e@arinc9.com>
X-B4-Tracking: v=1; b=H4sIAEAay2UC/yWNzQ6CMBCEX4Xs2SWl5ad48j0MhwqLbCKtaYFgC
 O9urbf5MvlmDgjkmQJcswM8bRzY2QjykkE/Gfsk5CEySCFLUSiBo/NoabG0LzgEg/PADh9rwFo
 2vSgbQVoriPrb08h7mr5DNPCnQBebicPi/Cd9bkXq//NSikqpUud1pVss0Hi2fb5a87ql2Oa9m
 6E7z/ML1dL4grgAAAA=
To: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: mithat.guner@xeront.com, erkin.bozoglu@xeront.com, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <ALSI@bang-olufsen.dk>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707809354; l=4698;
 i=arinc.unal@arinc9.com; s=arinc9-patatt; h=from:subject:message-id;
 bh=FQVu4SdlGCbVhlJyCOryP4ivDPy0SI6ZNNcbaFbu7M0=;
 b=FBdXqqaV0vEKXzhXwwhzwHIG9P6X2VZ1lJ3hEQcD0rAhBYuWM0nf8ZjiLytG+tTVXc8bbAHN7
 u1G4tKR/i4YCZNhxGmuqgAgGAJVxHmYM814pW+T6NThhfNzT6DzChrp
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=VmvgMWwm73yVIrlyJYvGtnXkQJy9CvbaeEqPQO9Z4kA=
X-Endpoint-Received:
 by B4 Relay for arinc.unal@arinc9.com/arinc9-patatt with auth_id=115
X-Original-From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Reply-To: <arinc.unal@arinc9.com>

From: Arınç ÜNAL <arinc.unal@arinc9.com>

The code block under the "!ds->user_mii_bus && ds->ops->phy_read" check
under dsa_switch_setup() populates ds->user_mii_bus. The use of
ds->user_mii_bus is inappropriate when the MDIO bus of the switch is
described on the device tree [1].

For this reason, use this code block only for switches [with MDIO bus]
probed on platform_data, and OF which the switch MDIO bus isn't described
on the device tree. Therefore, remove OF-based MDIO bus registration as
it's useless for these cases.

These subdrivers which control switches [with MDIO bus] probed on OF, will
lose the ability to register the MDIO bus OF-based:

drivers/net/dsa/b53/b53_common.c
drivers/net/dsa/lan9303-core.c
drivers/net/dsa/vitesse-vsc73xx-core.c

These subdrivers let the DSA core driver register the bus:
- ds->ops->phy_read() and ds->ops->phy_write() are present.
- ds->user_mii_bus is not populated.

The commit fe7324b93222 ("net: dsa: OF-ware slave_mii_bus") which brought
OF-based MDIO bus registration on the DSA core driver is reasonably recent
and, in this time frame, there have been no device trees in the Linux
repository that started describing the MDIO bus, or dt-bindings defining
the MDIO bus for the switches these subdrivers control. So I don't expect
any devices to be affected.

The logic we encourage is that all subdrivers should register the switch
MDIO bus on their own [2]. And, for subdrivers which control switches [with
MDIO bus] probed on OF, this logic must be followed to support all cases
properly:

No switch MDIO bus defined: Populate ds->user_mii_bus, register the MDIO
bus, set the interrupts for PHYs if "interrupt-controller" is defined at
the switch node. This case should only be covered for the switches which
their dt-bindings documentation didn't document the MDIO bus from the
start. This is to keep supporting the device trees that do not describe the
MDIO bus on the device tree but the MDIO bus is being used nonetheless.

Switch MDIO bus defined: Don't populate ds->user_mii_bus, register the MDIO
bus, set the interrupts for PHYs if ["interrupt-controller" is defined at
the switch node and "interrupts" is defined at the PHY nodes under the
switch MDIO bus node].

Switch MDIO bus defined but explicitly disabled: If the device tree says
status = "disabled" for the MDIO bus, we shouldn't need an MDIO bus at all.
Instead, just exit as early as possible and do not call any MDIO API.

After all subdrivers that control switches with MDIO buses are made to
register the MDIO buses on their own, we will be able to get rid of
dsa_switch_ops :: phy_read() and :: phy_write(), and the code block for
registering the MDIO bus on the DSA core driver.

Link: https://lore.kernel.org/netdev/20231213120656.x46fyad6ls7sqyzv@skbuf/ [1]
Link: https://lore.kernel.org/netdev/20240103184459.dcbh57wdnlox6w7d@skbuf/ [2]
Suggested-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Acked-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
Changes in v2:
- Remove mention to drivers/net/dsa/realtek/realtek-mdio.c as it now
  registers the MDIO bus OF-based on its own, and now under
  drivers/net/dsa/realtek/rtl83xx.c. I've waited until this happened
  because if this patch was applied beforehand, there would be no way to
  set IRQs on PHYs as the subdriver doesn't do that for the MDIO bus
  registered non-OF-based.
- Link to v1: https://lore.kernel.org/r/20240122053348.6589-1-arinc.unal@arinc9.com
---
 net/dsa/dsa.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index ac7be864e80d..09d2f5d4b3dd 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -15,7 +15,6 @@
 #include <linux/slab.h>
 #include <linux/rtnetlink.h>
 #include <linux/of.h>
-#include <linux/of_mdio.h>
 #include <linux/of_net.h>
 #include <net/dsa_stubs.h>
 #include <net/sch_generic.h>
@@ -626,7 +625,6 @@ static void dsa_switch_teardown_tag_protocol(struct dsa_switch *ds)
 
 static int dsa_switch_setup(struct dsa_switch *ds)
 {
-	struct device_node *dn;
 	int err;
 
 	if (ds->setup)
@@ -666,10 +664,7 @@ static int dsa_switch_setup(struct dsa_switch *ds)
 
 		dsa_user_mii_bus_init(ds);
 
-		dn = of_get_child_by_name(ds->dev->of_node, "mdio");
-
-		err = of_mdiobus_register(ds->user_mii_bus, dn);
-		of_node_put(dn);
+		err = mdiobus_register(ds->user_mii_bus);
 		if (err < 0)
 			goto free_user_mii_bus;
 	}

---
base-commit: 4acf4e62cd572b0c806035046b3698f5585ab821
change-id: 20240130-for-netnext-dsa-mdio-bus-627c0470e883

Best regards,
-- 
Arınç ÜNAL <arinc.unal@arinc9.com>


