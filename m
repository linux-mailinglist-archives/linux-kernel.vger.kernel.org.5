Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2296276010D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 23:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjGXVTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 17:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjGXVTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 17:19:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242FC199B;
        Mon, 24 Jul 2023 14:19:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96E1C6142E;
        Mon, 24 Jul 2023 21:19:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B491C433C7;
        Mon, 24 Jul 2023 21:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690233553;
        bh=Kj3XfjZcezJ9YNhnOjElUCHift7/ySxvviPokSxuUfw=;
        h=From:To:Cc:Subject:Date:From;
        b=N20CdsGLjqTiQ1aVBymIuJeFt3sAkR8Xs1S7Xrei7URkWIFKMPxKhvZ7JzBAY/tZ6
         qeTGRI23GVQlJFw1i/SX6IMCz6HlvbNT4Q9ktfo82y4YZRKyIZm7Iz5GBX2naAD0La
         qhqGFY8QH33p0o4SGOfIRjTR5tUrDGDLgjopTQ44GGbgm+Nb8P/GSwNyCwKtR1YAi+
         lrDqOHcF6gCnWmjZR66gSRQlh3rrdfLvOzOqozasSXt7W3z6DbqQa8H4kqld8Vcmjy
         1EAvGj1phm/OfwT+nNWqHbtxEHMUq5UvGv9dZecMisg1azwXg1WCKoqPgkmDGHaCeu
         BXxlaySrNaymg==
Received: (nullmailer pid 805831 invoked by uid 1000);
        Mon, 24 Jul 2023 21:19:11 -0000
From:   Rob Herring <robh@kernel.org>
To:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Qingfang Deng <dqfext@gmail.com>,
        SkyLake Huang <SkyLake.Huang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2] net: phy/pcs: Explicitly include correct DT includes
Date:   Mon, 24 Jul 2023 15:19:05 -0600
Message-Id: <20230724211905.805665-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT of_device.h and of_platform.h date back to the separate
of_platform_bus_type before it as merged into the regular platform bus.
As part of that merge prepping Arm DT support 13 years ago, they
"temporarily" include each other. They also include platform_device.h
and of.h. As a result, there's a pretty much random mix of those include
files used throughout the tree. In order to detangle these headers and
replace the implicit includes with struct declarations, users need to
explicitly include the correct includes.

Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - Split out can, dsa, wireless, phy/pcs to separate patches
---
 drivers/net/pcs/pcs-rzn1-miic.c   | 1 +
 drivers/net/phy/marvell-88x2222.c | 1 -
 drivers/net/phy/mediatek-ge-soc.c | 2 --
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/pcs/pcs-rzn1-miic.c b/drivers/net/pcs/pcs-rzn1-miic.c
index 323bec5e57f8..e5d642c67a2c 100644
--- a/drivers/net/pcs/pcs-rzn1-miic.c
+++ b/drivers/net/pcs/pcs-rzn1-miic.c
@@ -12,6 +12,7 @@
 #include <linux/of_platform.h>
 #include <linux/pcs-rzn1-miic.h>
 #include <linux/phylink.h>
+#include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <dt-bindings/net/pcs-rzn1-miic.h>
 
diff --git a/drivers/net/phy/marvell-88x2222.c b/drivers/net/phy/marvell-88x2222.c
index f83cae64585d..e3aa30dad2e6 100644
--- a/drivers/net/phy/marvell-88x2222.c
+++ b/drivers/net/phy/marvell-88x2222.c
@@ -14,7 +14,6 @@
 #include <linux/mdio.h>
 #include <linux/marvell_phy.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/of_gpio.h>
 #include <linux/sfp.h>
 #include <linux/netdevice.h>
diff --git a/drivers/net/phy/mediatek-ge-soc.c b/drivers/net/phy/mediatek-ge-soc.c
index 95369171a7ba..da512fab0eb0 100644
--- a/drivers/net/phy/mediatek-ge-soc.c
+++ b/drivers/net/phy/mediatek-ge-soc.c
@@ -2,8 +2,6 @@
 #include <linux/bitfield.h>
 #include <linux/module.h>
 #include <linux/nvmem-consumer.h>
-#include <linux/of_address.h>
-#include <linux/of_platform.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/phy.h>
 
-- 
2.40.1

