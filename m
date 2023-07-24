Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE7A76010F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 23:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbjGXVTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 17:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjGXVTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 17:19:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884AC10D8;
        Mon, 24 Jul 2023 14:19:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79DF961418;
        Mon, 24 Jul 2023 21:19:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EB16C433C7;
        Mon, 24 Jul 2023 21:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690233560;
        bh=bSAUEcuXqTqXpKIg7Bv5PY9P3Dl95C0bkG2c+6yz6uE=;
        h=From:To:Cc:Subject:Date:From;
        b=dByrJeAPcbCJsBQexUs5scUmplWaGVUp9/EPOQZt18/lsqhnGVSyumj52MG6ffBNk
         92lD5tebXIk0He97C5SOBgaq2nat970RKtx34vyWtIE+qPj43qYDQ+y9Nc00HQohso
         vaFkDBpyiAJ2+VVMYp7pigzNwRNZ4wlDgyxXt5Jt2mbShYH9/s5ruaztFr3E/psBpt
         +wWP8O24EqyMsDSZRDnTxvzdZWSrCrz4Qu3Ps48xZDM4qsVZy2/9xqJTpoeQVaKkAZ
         pzkrIfT0uHOmVjdR+Dl3gTiGq8nHjO9RvYSIa/9i57DGk5nUYqeXeQqKDrrQUbf9Dr
         Ie7OWZSG/YGrw==
Received: (nullmailer pid 806011 invoked by uid 1000);
        Mon, 24 Jul 2023 21:19:18 -0000
From:   Rob Herring <robh@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath11k@lists.infradead.org,
        wcn36xx@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2] net: wireless: Explicitly include correct DT includes
Date:   Mon, 24 Jul 2023 15:19:13 -0600
Message-Id: <20230724211914.805876-1-robh@kernel.org>
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
 drivers/net/wireless/ath/ath10k/ahb.c            | 2 +-
 drivers/net/wireless/ath/ath11k/qmi.c            | 1 -
 drivers/net/wireless/ath/wcn36xx/main.c          | 3 +--
 drivers/net/wireless/intersil/orinoco/airport.c  | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/init.c | 1 +
 drivers/net/wireless/mediatek/mt76/mt7915/soc.c  | 1 -
 drivers/net/wireless/mediatek/mt76/mt7996/init.c | 1 +
 drivers/net/wireless/silabs/wfx/bus_sdio.c       | 2 +-
 8 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/ahb.c b/drivers/net/wireless/ath/ath10k/ahb.c
index 4a006fb4d424..76efea2f1138 100644
--- a/drivers/net/wireless/ath/ath10k/ahb.c
+++ b/drivers/net/wireless/ath/ath10k/ahb.c
@@ -5,7 +5,7 @@
  */
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/reset.h>
 #include "core.h"
diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index d4eaf7d2ba84..98efa0f299ca 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -13,7 +13,6 @@
 #include <linux/of_address.h>
 #include <linux/ioport.h>
 #include <linux/firmware.h>
-#include <linux/of_device.h>
 #include <linux/of_irq.h>
 
 #define SLEEP_CLOCK_SELECT_INTERNAL_BIT	0x02
diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index 8dbd115a393c..2bd1163177f0 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -19,9 +19,8 @@
 #include <linux/module.h>
 #include <linux/firmware.h>
 #include <linux/platform_device.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_device.h>
-#include <linux/of_irq.h>
 #include <linux/rpmsg.h>
 #include <linux/soc/qcom/smem_state.h>
 #include <linux/soc/qcom/wcnss_ctrl.h>
diff --git a/drivers/net/wireless/intersil/orinoco/airport.c b/drivers/net/wireless/intersil/orinoco/airport.c
index a890bfa0d5cc..45ac00fdafa5 100644
--- a/drivers/net/wireless/intersil/orinoco/airport.c
+++ b/drivers/net/wireless/intersil/orinoco/airport.c
@@ -18,7 +18,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/delay.h>
-#include <linux/of_device.h>
+#include <linux/mod_devicetable.h>
 #include <asm/pmac_feature.h>
 
 #include "orinoco.h"
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index ac2049f49bb3..aec47de35f53 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -4,6 +4,7 @@
 #include <linux/etherdevice.h>
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
+#include <linux/of.h>
 #include <linux/thermal.h>
 #include "mt7915.h"
 #include "mac.h"
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/soc.c b/drivers/net/wireless/mediatek/mt76/mt7915/soc.c
index 32c137066e7f..701a27ffa4c2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/soc.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/soc.c
@@ -6,7 +6,6 @@
 #include <linux/platform_device.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/of_reserved_mem.h>
 #include <linux/of_gpio.h>
 #include <linux/iopoll.h>
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index f1b48cdda58f..5c980534f611 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/etherdevice.h>
+#include <linux/of.h>
 #include <linux/thermal.h>
 #include "mt7996.h"
 #include "mac.h"
diff --git a/drivers/net/wireless/silabs/wfx/bus_sdio.c b/drivers/net/wireless/silabs/wfx/bus_sdio.c
index 51a0d58a9070..909d5f346a01 100644
--- a/drivers/net/wireless/silabs/wfx/bus_sdio.c
+++ b/drivers/net/wireless/silabs/wfx/bus_sdio.c
@@ -10,7 +10,7 @@
 #include <linux/mmc/sdio_func.h>
 #include <linux/mmc/card.h>
 #include <linux/interrupt.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/irq.h>
 #include <linux/align.h>
-- 
2.40.1

