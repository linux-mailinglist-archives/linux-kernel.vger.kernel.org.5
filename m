Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958A7760109
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 23:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjGXVTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 17:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjGXVTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 17:19:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247B2173B;
        Mon, 24 Jul 2023 14:18:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFEF861418;
        Mon, 24 Jul 2023 21:18:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8777C433C7;
        Mon, 24 Jul 2023 21:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690233536;
        bh=N4OuHYLYh0XTbs0p57g4iiEmvIO8lb9r0X7HGPxsqFc=;
        h=From:To:Cc:Subject:Date:From;
        b=U3oJkQB3A0WbwrAOyw5CPf94OoZqbYk0mzmN+A42nLJLREQ1i3NoARsoF64EWOEuq
         ehsrl7m0ICSj8a+12OmMq8RhyoL6tgc8xahROFAu+U5dEgzKica5ms2qBhTXYErOoq
         EHTgz+ie961FIQNgXbMP4nRByL2eRbWWlZ/8tJ/Q8dPyT3tfDSMTBZLq1exCi8U15R
         jlUwzNZr36SYyNItvKyVLUyCuaEXQ8Sf5khlqYGZRS1KEAvlssFifRPK2ulT5iMwyy
         jWGNybvepS1bf5MRqVYjjvKN4y/XoRCQtsdggbhk7SmlGZVUt9kR2TkUQYmsI1Fiz7
         yLP/h56I8yinw==
Received: (nullmailer pid 805390 invoked by uid 1000);
        Mon, 24 Jul 2023 21:18:54 -0000
From:   Rob Herring <robh@kernel.org>
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH v2] can: Explicitly include correct DT includes, part 2
Date:   Mon, 24 Jul 2023 15:18:40 -0600
Message-Id: <20230724211841.805053-1-robh@kernel.org>
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
I had the CAN changes in a separate patch, but inadvertently put these
in the 'net' patch.

v2:
 - Split out can, dsa, wireless, phy/pcs to separate patches
---
 drivers/net/can/bxcan.c                    | 1 -
 drivers/net/can/ifi_canfd/ifi_canfd.c      | 1 -
 drivers/net/can/m_can/m_can.c              | 1 -
 drivers/net/can/m_can/m_can.h              | 1 -
 drivers/net/can/rcar/rcar_canfd.c          | 1 -
 drivers/net/can/sja1000/sja1000_platform.c | 1 -
 drivers/net/can/sun4i_can.c                | 1 -
 drivers/net/can/ti_hecc.c                  | 1 -
 8 files changed, 8 deletions(-)

diff --git a/drivers/net/can/bxcan.c b/drivers/net/can/bxcan.c
index 39de7164bc4e..49cf9682b925 100644
--- a/drivers/net/can/bxcan.c
+++ b/drivers/net/can/bxcan.c
@@ -23,7 +23,6 @@
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
diff --git a/drivers/net/can/ifi_canfd/ifi_canfd.c b/drivers/net/can/ifi_canfd/ifi_canfd.c
index 1d6642c94f2f..72307297d75e 100644
--- a/drivers/net/can/ifi_canfd/ifi_canfd.c
+++ b/drivers/net/can/ifi_canfd/ifi_canfd.c
@@ -20,7 +20,6 @@
 #include <linux/module.h>
 #include <linux/netdevice.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 
 #include <linux/can/dev.h>
diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index c5af92bcc9c9..4e76cd9c02b0 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -18,7 +18,6 @@
 #include <linux/module.h>
 #include <linux/netdevice.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/phy/phy.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index a839dc71dc9b..267d06ce6ade 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -22,7 +22,6 @@
 #include <linux/module.h>
 #include <linux/netdevice.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/phy/phy.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/pm_runtime.h>
diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index e4d748913439..b82842718735 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -34,7 +34,6 @@
 #include <linux/moduleparam.h>
 #include <linux/netdevice.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
diff --git a/drivers/net/can/sja1000/sja1000_platform.c b/drivers/net/can/sja1000/sja1000_platform.c
index 4e59952c66d4..33f0e46ab1c2 100644
--- a/drivers/net/can/sja1000/sja1000_platform.c
+++ b/drivers/net/can/sja1000/sja1000_platform.c
@@ -17,7 +17,6 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 
 #include "sja1000.h"
 
diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
index 0827830bbf28..b493a3d8ea9a 100644
--- a/drivers/net/can/sun4i_can.c
+++ b/drivers/net/can/sun4i_can.c
@@ -59,7 +59,6 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 
diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
index 54284661992e..a8243acde92d 100644
--- a/drivers/net/can/ti_hecc.c
+++ b/drivers/net/can/ti_hecc.c
@@ -21,7 +21,6 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/regulator/consumer.h>
 
 #include <linux/can/dev.h>
-- 
2.40.1

