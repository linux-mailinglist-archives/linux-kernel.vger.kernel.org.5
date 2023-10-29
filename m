Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173367DAC27
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 12:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjJ2LT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 07:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjJ2LTS (ORCPT
        <RFC822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 07:19:18 -0400
Received: from smtp1.ms.mff.cuni.cz (smtp1.ms.mff.cuni.cz [IPv6:2001:718:1e03:801::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE38AB;
        Sun, 29 Oct 2023 04:19:15 -0700 (PDT)
X-SubmittedBy: id balejk@matfyz.cz subject /postalCode=110+2000/O=Univerzita+20Karlova/street=Ovocn+5CxC3+5CxBD+20trh+20560/5/ST=Praha,+20Hlavn+5CxC3+5CxAD+20m+5CxC4+5Cx9Bsto/C=CZ/CN=Karel+20Balej/emailAddress=balejk@matfyz.cz
        serial F5FD910E8FE2121B897F7E55B84E351D
        issued by /C=NL/O=GEANT+20Vereniging/CN=GEANT+20Personal+20CA+204
        auth type TLS.CUNI
Received: from localhost (internet5.mraknet.com [185.200.108.250])
        (authenticated)
        by smtp1.ms.mff.cuni.cz (8.16.1/8.16.1) with ESMTPS id 39TBItej065444
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
        Sun, 29 Oct 2023 12:18:57 +0100 (CET)
        (envelope-from balejk@matfyz.cz)
From:   Karel Balej <balejk@matfyz.cz>
To:     Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Karel Balej <balejk@matfyz.cz>
Subject: [PATCH 2/2] net: mwifiex: add support for the SD8777 chipset
Date:   Sun, 29 Oct 2023 12:08:17 +0100
Message-ID: <20231029111807.19261-3-balejk@matfyz.cz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029111807.19261-1-balejk@matfyz.cz>
References: <20231029111807.19261-1-balejk@matfyz.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marvell SD8777 is a wireless chipset used for instance in the PXA1908
SoC found for example in the samsung,coreprimevelte smartphone, with
which this was tested. The driver seems to be compatible with this
chipset so enable this support by adding the necessary information based
on the downstream code.

Signed-off-by: Karel Balej <balejk@matfyz.cz>
---
 drivers/net/wireless/marvell/mwifiex/Kconfig |  4 ++--
 drivers/net/wireless/marvell/mwifiex/sdio.c  | 19 +++++++++++++++++++
 drivers/net/wireless/marvell/mwifiex/sdio.h  |  1 +
 include/linux/mmc/sdio_ids.h                 |  1 +
 4 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/Kconfig b/drivers/net/wireless/marvell/mwifiex/Kconfig
index b182f7155d66..a7bd2c5735f6 100644
--- a/drivers/net/wireless/marvell/mwifiex/Kconfig
+++ b/drivers/net/wireless/marvell/mwifiex/Kconfig
@@ -10,13 +10,13 @@ config MWIFIEX
 	  mwifiex.
 
 config MWIFIEX_SDIO
-	tristate "Marvell WiFi-Ex Driver for SD8786/SD8787/SD8797/SD8887/SD8897/SD8977/SD8978/SD8987/SD8997"
+	tristate "Marvell WiFi-Ex Driver for SD8777/SD8786/SD8787/SD8797/SD8887/SD8897/SD8977/SD8978/SD8987/SD8997"
 	depends on MWIFIEX && MMC
 	select FW_LOADER
 	select WANT_DEV_COREDUMP
 	help
 	  This adds support for wireless adapters based on Marvell
-	  8786/8787/8797/8887/8897/8977/8978/8987/8997 chipsets with
+	  8777/8786/8787/8797/8887/8897/8977/8978/8987/8997 chipsets with
 	  SDIO interface. SD8978 is also known as NXP IW416.
 
 	  If you choose to build it as a module, it will be called
diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wireless/marvell/mwifiex/sdio.c
index 774858cfe86f..c55f1f5669cb 100644
--- a/drivers/net/wireless/marvell/mwifiex/sdio.c
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
@@ -318,6 +318,21 @@ static const struct mwifiex_sdio_card_reg mwifiex_reg_sd89xx = {
 				 0x68, 0x69, 0x6a},
 };
 
+static const struct mwifiex_sdio_device mwifiex_sdio_sd8777 = {
+	.firmware = SD8777_DEFAULT_FW_NAME,
+	.reg = &mwifiex_reg_sd87xx,
+	.max_ports = 16,
+	.mp_agg_pkt_limit = 8,
+	.tx_buf_size = MWIFIEX_TX_DATA_BUF_SIZE_2K,
+	.mp_tx_agg_buf_size = MWIFIEX_MP_AGGR_BUF_SIZE_16K,
+	.mp_rx_agg_buf_size = MWIFIEX_MP_AGGR_BUF_SIZE_16K,
+	.supports_sdio_new_mode = false,
+	.has_control_mask = true,
+	.can_dump_fw = false,
+	.can_auto_tdls = false,
+	.can_ext_scan = true,
+};
+
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8786 = {
 	.firmware = SD8786_DEFAULT_FW_NAME,
 	.reg = &mwifiex_reg_sd87xx,
@@ -496,6 +511,7 @@ static struct memory_type_mapping mem_type_mapping_tbl[] = {
 };
 
 static const struct of_device_id mwifiex_sdio_of_match_table[] __maybe_unused = {
+	{ .compatible = "marvell,sd8777" },
 	{ .compatible = "marvell,sd8787" },
 	{ .compatible = "marvell,sd8897" },
 	{ .compatible = "marvell,sd8978" },
@@ -924,6 +940,8 @@ static void mwifiex_sdio_coredump(struct device *dev)
 
 /* WLAN IDs */
 static const struct sdio_device_id mwifiex_ids[] = {
+	{SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8777_WLAN),
+		.driver_data = (unsigned long)&mwifiex_sdio_sd8777},
 	{SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8786_WLAN),
 		.driver_data = (unsigned long) &mwifiex_sdio_sd8786},
 	{SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8787_WLAN),
@@ -3180,6 +3198,7 @@ MODULE_AUTHOR("Marvell International Ltd.");
 MODULE_DESCRIPTION("Marvell WiFi-Ex SDIO Driver version " SDIO_VERSION);
 MODULE_VERSION(SDIO_VERSION);
 MODULE_LICENSE("GPL v2");
+MODULE_FIRMWARE(SD8777_DEFAULT_FW_NAME);
 MODULE_FIRMWARE(SD8786_DEFAULT_FW_NAME);
 MODULE_FIRMWARE(SD8787_DEFAULT_FW_NAME);
 MODULE_FIRMWARE(SD8797_DEFAULT_FW_NAME);
diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.h b/drivers/net/wireless/marvell/mwifiex/sdio.h
index ae94c172310f..ed92256b2302 100644
--- a/drivers/net/wireless/marvell/mwifiex/sdio.h
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.h
@@ -18,6 +18,7 @@
 
 #include "main.h"
 
+#define SD8777_DEFAULT_FW_NAME "mrvl/sd8777_uapsta.bin"
 #define SD8786_DEFAULT_FW_NAME "mrvl/sd8786_uapsta.bin"
 #define SD8787_DEFAULT_FW_NAME "mrvl/sd8787_uapsta.bin"
 #define SD8797_DEFAULT_FW_NAME "mrvl/sd8797_uapsta.bin"
diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
index 7fada7a714fe..c46ab35ceb20 100644
--- a/include/linux/mmc/sdio_ids.h
+++ b/include/linux/mmc/sdio_ids.h
@@ -94,6 +94,7 @@
 #define SDIO_DEVICE_ID_MARVELL_8797_BT		0x912a
 #define SDIO_DEVICE_ID_MARVELL_8897_WLAN	0x912d
 #define SDIO_DEVICE_ID_MARVELL_8897_BT		0x912e
+#define SDIO_DEVICE_ID_MARVELL_8777_WLAN	0x9131
 #define SDIO_DEVICE_ID_MARVELL_8887_F0		0x9134
 #define SDIO_DEVICE_ID_MARVELL_8887_WLAN	0x9135
 #define SDIO_DEVICE_ID_MARVELL_8887_BT		0x9136
-- 
2.42.0

