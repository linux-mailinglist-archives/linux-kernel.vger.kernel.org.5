Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07DA576936B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 12:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjGaKsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 06:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbjGaKso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 06:48:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2A210C8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 03:48:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DAF9A60FC5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 10:48:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE57DC433C7;
        Mon, 31 Jul 2023 10:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690800521;
        bh=oNk8L5AIJtMIWh7kVldokACXw0Wm983RCwSZY11UU+A=;
        h=From:Date:Subject:To:Cc:From;
        b=ia8SJdUzrWij7F9w89Pjty6Ao6sfFlGKydNihv1ATial7l2f01N5rUJU/jsMw2CJO
         GAnObRbmDAT2N9lzB3ug9gHFSC3DFTxmqAb2LGSXHTorZbiiYvZBOeT9SfBZ5a7Ix/
         rmeKZN+08ujYC6Od4epwA4SAAYN2Kblz0LNaYO2A526wO0BP63qfB0JHr40Zvt/gH0
         1lRWA7eZ6meXE6arg/Jmm1IMOL8Ap2mVxK4GD4+2WvNwU2AspLGD3wDxCYjp0eSX+4
         gNr42mkqiO/6iSaz79Kmm9SJQYYh2c7w0HlJfxi0JYnx9ADy6VACmggu0hbne5py4J
         dJEy2vfXLxqUg==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 31 Jul 2023 11:48:32 +0100
Subject: [PATCH v3] net: netsec: Ignore 'phy-mode' on SynQuacer in DT mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230731-synquacer-net-v3-1-944be5f06428@kernel.org>
X-B4-Tracking: v=1; b=H4sIAH+Rx2QC/3WMQQ7CIBAAv9LsWUxZ0FZP/sN4oLC0REMVKrFp+
 ndpT2ricSaZmSBScBThWEwQKLnoep9BbArQnfItMWcyA5YoygorFkf/eCpNgXkaGKHkVsgmiwZ
 ycw9k3Wv9nS+ZOxeHPozrPvHF/jslzjiTprI7LbWuzeF0peDptu1DC8sq4Wde/+aYc0VKGmkFN
 rj/yud5fgPcs5si6gAAAA==
To:     Jassi Brar <jaswinder.singh@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=2536; i=broonie@kernel.org;
 h=from:subject:message-id; bh=oNk8L5AIJtMIWh7kVldokACXw0Wm983RCwSZY11UU+A=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkx5GFMajA5DliNO2u5vKItnjruuSpMkQmEXKRw
 NVcdiEylu6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZMeRhQAKCRAk1otyXVSH
 0BeTB/9IUvCO8AZO4/d9ZU0jOMCPfXoTpl364HC5MSQbHZA6sqkkl1QZhlDjtvqRqsfwgdGyutY
 0W20etlwzK1LRCx493u/jF+okfDcfevmm76CR09Q2Za7rN4vz3oTRp8kT7lijn4oDQO8f1n4dsz
 PkaOYyYHdX8VkLbS7uTTE01x+jc6fImOGFFRrMtZdFxWUvfJzSP76Rk6TSQ38QEYCuaNX5NEQgN
 tA49PZLM2pglvhWsOsoz2DWBE9t3bSnVh7rfLSkGIrvzGvE7WLOJPs/unioQQ9G7nQeQK4ar+ds
 taY8+GTl5jCb5AWotdU8jl/oiPPtckPpFK7Y6gLtv07EJn9G
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As documented in acd7aaf51b20 ("netsec: ignore 'phy-mode' device
property on ACPI systems") the SocioNext SynQuacer platform ships with
firmware defining the PHY mode as RGMII even though the physical
configuration of the PHY is for TX and RX delays.  Since bbc4d71d63549bc
("net: phy: realtek: fix rtl8211e rx/tx delay config") this has caused
misconfiguration of the PHY, rendering the network unusable.

This was worked around for ACPI by ignoring the phy-mode property but
the system is also used with DT.  For DT instead if we're running on a
SynQuacer force a working PHY mode, as well as the standard EDK2
firmware with DT there are also some of these systems that use u-boot
and might not initialise the PHY if not netbooting.  Newer firmware
imagaes for at least EDK2 are available from Linaro so print a warning
when doing this.

Fixes: 533dd11a12f6 ("net: socionext: Add Synquacer NetSec driver")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v3:
- Typo fixes.
- Link to v2: https://lore.kernel.org/r/20230728-synquacer-net-v2-1-aea4d4f32b26@kernel.org

Changes in v2:
- Unlike ACPI force what appears to be the correct mode, there are
  u-boot firmwares which might not configure the PHY.
- Link to v1: https://lore.kernel.org/r/20230727-synquacer-net-v1-1-4d7f5c4cc8d9@kernel.org
---
 drivers/net/ethernet/socionext/netsec.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/socionext/netsec.c b/drivers/net/ethernet/socionext/netsec.c
index 2d7347b71c41..0dcd6a568b06 100644
--- a/drivers/net/ethernet/socionext/netsec.c
+++ b/drivers/net/ethernet/socionext/netsec.c
@@ -1851,6 +1851,17 @@ static int netsec_of_probe(struct platform_device *pdev,
 		return err;
 	}
 
+	/*
+	 * SynQuacer is physically configured with TX and RX delays
+	 * but the standard firmware claimed otherwise for a long
+	 * time, ignore it.
+	 */
+	if (of_machine_is_compatible("socionext,developer-box") &&
+	    priv->phy_interface != PHY_INTERFACE_MODE_RGMII_ID) {
+		dev_warn(&pdev->dev, "Outdated firmware reports incorrect PHY mode, overriding\n");
+		priv->phy_interface = PHY_INTERFACE_MODE_RGMII_ID;
+	}
+
 	priv->phy_np = of_parse_phandle(pdev->dev.of_node, "phy-handle", 0);
 	if (!priv->phy_np) {
 		dev_err(&pdev->dev, "missing required property 'phy-handle'\n");

---
base-commit: 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4
change-id: 20230727-synquacer-net-e241f34baceb

Best regards,
-- 
Mark Brown <broonie@kernel.org>

