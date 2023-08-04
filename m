Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4D676FF02
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 12:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjHDKvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 06:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjHDKun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 06:50:43 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A58349C3;
        Fri,  4 Aug 2023 03:48:53 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 374AlwcR7004861, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 374AlwcR7004861
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 4 Aug 2023 18:47:58 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 4 Aug 2023 18:47:41 +0800
Received: from localhost.localhost (172.21.132.123) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 4 Aug 2023 18:47:40 +0800
From:   <max.chou@realtek.com>
To:     <marcel@holtmann.org>
CC:     <johan.hedberg@gmail.com>, <luiz.dentz@gmail.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alex_lu@realsil.com.cn>, <hildawu@realtek.com>,
        <karenhsu@realtek.com>, <kidman@realtek.com>,
        <max.chou@realtek.com>, <juerg.haefliger@canonical.com>,
        <vicamo.yang@canonical.com>, <Riley.Kao@dell.com>,
        <stable@vger.kernel.org>, <jwboyer@kernel.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <regressions@lists.linux.dev>
Subject: [PATCH v2] Bluetooth: btrtl: Load FW v2 otherwise FW v1 for RTL8852C
Date:   Fri, 4 Aug 2023 18:47:35 +0800
Message-ID: <20230804104735.9281-1-max.chou@realtek.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.132.123]
X-ClientProxiedBy: RTEXH36505.realtek.com.tw (172.21.6.25) To
 RTEXMBS03.realtek.com.tw (172.21.6.96)
X-KSE-ServerInfo: RTEXMBS03.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Chou <max.chou@realtek.com>

In the commit of linux-firmware project, rtl8852cu_fw.bin is updated as
FW v2 format[1]. Consider the case that if driver did not be updated for
FW v2 supported[2], it can not use FW v2.
By Canonical's suggestion, older driver should be able to load FW v1,
so rtl8852cu_fw.bin will be revert to the previous commit as FW v1 and
add rtl8852cu_fw_v2.bin as FW v2. This item will be started on
linux-firmware project.

In this commit, the driver prefers to load FW v2 if available. Fallback to
FW v1 otherwise.

Note that the driver has supported to extract the data for v1 and v2
since the commit[1].
The previous FW format of RTL8852C is v1. After the commit[2], the FW format
was changed to v2. Only RTL8852C suffered the different FW formats, so
we will use rtl8852cu_fw.bin for the original commit as FW v1 and
rtl8852cu_fw_v2.bin for the future maintained as FW v2. Other Realtek chips
will not been impacted by this patch.

To do on linux-firmware project after this commit.
1. revert '55e7448533e7 ("rtl_bt: Update RTL8852C BT USB firmware
   to 0x040D_7225")'
   => rtl_bt/rtl8852cu_fw.bin: FW v1 (stay at ver. 0xD7B8_FABF)
2. Add a new commit for rtl8852cu_fw_v2.bin
   =>rtl_bt/rtl8852cu_fw_v2.bin: FW v2 (to be maintained)

Reference:
[1]'9a24ce5e29b1 ("Bluetooth: btrtl: Firmware format v2 support")'
[2]'55e7448533e7 ("rtl_bt: Update RTL8852C BT USB firmware
    to 0x040D_7225")'

Fixes: 9a24ce5e29b ("Bluetooth: btrtl: Firmware format v2 support")
Suggested-by: Juerg Haefliger <juerg.haefliger@canonical.com>
Tested-by: Hilda Wu <hildawu@realtek.com>
Signed-off-by: Max Chou <max.chou@realtek.com>

---
Changes in v2:
- Tuning the code for more readable. Thanks Juerg!
- Modify the commit log.
---
 drivers/bluetooth/btrtl.c | 70 +++++++++++++++++++++++++--------------
 1 file changed, 45 insertions(+), 25 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index ddae6524106d..84c2c2e1122f 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -104,7 +104,7 @@ static const struct id_table ic_id_table[] = {
 	{ IC_INFO(RTL_ROM_LMP_8723A, 0xb, 0x6, HCI_USB),
 	  .config_needed = false,
 	  .has_rom_version = false,
-	  .fw_name = "rtl_bt/rtl8723a_fw.bin",
+	  .fw_name = "rtl_bt/rtl8723a_fw",
 	  .cfg_name = NULL,
 	  .hw_info = "rtl8723au" },
 
@@ -112,7 +112,7 @@ static const struct id_table ic_id_table[] = {
 	{ IC_INFO(RTL_ROM_LMP_8723B, 0xb, 0x6, HCI_UART),
 	  .config_needed = true,
 	  .has_rom_version = true,
-	  .fw_name  = "rtl_bt/rtl8723bs_fw.bin",
+	  .fw_name  = "rtl_bt/rtl8723bs_fw",
 	  .cfg_name = "rtl_bt/rtl8723bs_config",
 	  .hw_info  = "rtl8723bs" },
 
@@ -120,7 +120,7 @@ static const struct id_table ic_id_table[] = {
 	{ IC_INFO(RTL_ROM_LMP_8723B, 0xb, 0x6, HCI_USB),
 	  .config_needed = false,
 	  .has_rom_version = true,
-	  .fw_name  = "rtl_bt/rtl8723b_fw.bin",
+	  .fw_name  = "rtl_bt/rtl8723b_fw",
 	  .cfg_name = "rtl_bt/rtl8723b_config",
 	  .hw_info  = "rtl8723bu" },
 
@@ -132,7 +132,7 @@ static const struct id_table ic_id_table[] = {
 	  .hci_bus = HCI_UART,
 	  .config_needed = true,
 	  .has_rom_version = true,
-	  .fw_name  = "rtl_bt/rtl8723cs_cg_fw.bin",
+	  .fw_name  = "rtl_bt/rtl8723cs_cg_fw",
 	  .cfg_name = "rtl_bt/rtl8723cs_cg_config",
 	  .hw_info  = "rtl8723cs-cg" },
 
@@ -144,7 +144,7 @@ static const struct id_table ic_id_table[] = {
 	  .hci_bus = HCI_UART,
 	  .config_needed = true,
 	  .has_rom_version = true,
-	  .fw_name  = "rtl_bt/rtl8723cs_vf_fw.bin",
+	  .fw_name  = "rtl_bt/rtl8723cs_vf_fw",
 	  .cfg_name = "rtl_bt/rtl8723cs_vf_config",
 	  .hw_info  = "rtl8723cs-vf" },
 
@@ -156,7 +156,7 @@ static const struct id_table ic_id_table[] = {
 	  .hci_bus = HCI_UART,
 	  .config_needed = true,
 	  .has_rom_version = true,
-	  .fw_name  = "rtl_bt/rtl8723cs_xx_fw.bin",
+	  .fw_name  = "rtl_bt/rtl8723cs_xx_fw",
 	  .cfg_name = "rtl_bt/rtl8723cs_xx_config",
 	  .hw_info  = "rtl8723cs" },
 
@@ -164,7 +164,7 @@ static const struct id_table ic_id_table[] = {
 	{ IC_INFO(RTL_ROM_LMP_8723B, 0xd, 0x8, HCI_USB),
 	  .config_needed = true,
 	  .has_rom_version = true,
-	  .fw_name  = "rtl_bt/rtl8723d_fw.bin",
+	  .fw_name  = "rtl_bt/rtl8723d_fw",
 	  .cfg_name = "rtl_bt/rtl8723d_config",
 	  .hw_info  = "rtl8723du" },
 
@@ -172,7 +172,7 @@ static const struct id_table ic_id_table[] = {
 	{ IC_INFO(RTL_ROM_LMP_8723B, 0xd, 0x8, HCI_UART),
 	  .config_needed = true,
 	  .has_rom_version = true,
-	  .fw_name  = "rtl_bt/rtl8723ds_fw.bin",
+	  .fw_name  = "rtl_bt/rtl8723ds_fw",
 	  .cfg_name = "rtl_bt/rtl8723ds_config",
 	  .hw_info  = "rtl8723ds" },
 
@@ -180,7 +180,7 @@ static const struct id_table ic_id_table[] = {
 	{ IC_INFO(RTL_ROM_LMP_8821A, 0xa, 0x6, HCI_USB),
 	  .config_needed = false,
 	  .has_rom_version = true,
-	  .fw_name  = "rtl_bt/rtl8821a_fw.bin",
+	  .fw_name  = "rtl_bt/rtl8821a_fw",
 	  .cfg_name = "rtl_bt/rtl8821a_config",
 	  .hw_info  = "rtl8821au" },
 
@@ -189,7 +189,7 @@ static const struct id_table ic_id_table[] = {
 	  .config_needed = false,
 	  .has_rom_version = true,
 	  .has_msft_ext = true,
-	  .fw_name  = "rtl_bt/rtl8821c_fw.bin",
+	  .fw_name  = "rtl_bt/rtl8821c_fw",
 	  .cfg_name = "rtl_bt/rtl8821c_config",
 	  .hw_info  = "rtl8821cu" },
 
@@ -198,7 +198,7 @@ static const struct id_table ic_id_table[] = {
 	  .config_needed = true,
 	  .has_rom_version = true,
 	  .has_msft_ext = true,
-	  .fw_name  = "rtl_bt/rtl8821cs_fw.bin",
+	  .fw_name  = "rtl_bt/rtl8821cs_fw",
 	  .cfg_name = "rtl_bt/rtl8821cs_config",
 	  .hw_info  = "rtl8821cs" },
 
@@ -206,7 +206,7 @@ static const struct id_table ic_id_table[] = {
 	{ IC_INFO(RTL_ROM_LMP_8761A, 0xa, 0x6, HCI_USB),
 	  .config_needed = false,
 	  .has_rom_version = true,
-	  .fw_name  = "rtl_bt/rtl8761a_fw.bin",
+	  .fw_name  = "rtl_bt/rtl8761a_fw",
 	  .cfg_name = "rtl_bt/rtl8761a_config",
 	  .hw_info  = "rtl8761au" },
 
@@ -215,7 +215,7 @@ static const struct id_table ic_id_table[] = {
 	  .config_needed = false,
 	  .has_rom_version = true,
 	  .has_msft_ext = true,
-	  .fw_name  = "rtl_bt/rtl8761b_fw.bin",
+	  .fw_name  = "rtl_bt/rtl8761b_fw",
 	  .cfg_name = "rtl_bt/rtl8761b_config",
 	  .hw_info  = "rtl8761btv" },
 
@@ -223,7 +223,7 @@ static const struct id_table ic_id_table[] = {
 	{ IC_INFO(RTL_ROM_LMP_8761A, 0xb, 0xa, HCI_USB),
 	  .config_needed = false,
 	  .has_rom_version = true,
-	  .fw_name  = "rtl_bt/rtl8761bu_fw.bin",
+	  .fw_name  = "rtl_bt/rtl8761bu_fw",
 	  .cfg_name = "rtl_bt/rtl8761bu_config",
 	  .hw_info  = "rtl8761bu" },
 
@@ -232,7 +232,7 @@ static const struct id_table ic_id_table[] = {
 	  .config_needed = true,
 	  .has_rom_version = true,
 	  .has_msft_ext = true,
-	  .fw_name  = "rtl_bt/rtl8822cs_fw.bin",
+	  .fw_name  = "rtl_bt/rtl8822cs_fw",
 	  .cfg_name = "rtl_bt/rtl8822cs_config",
 	  .hw_info  = "rtl8822cs" },
 
@@ -241,7 +241,7 @@ static const struct id_table ic_id_table[] = {
 	  .config_needed = true,
 	  .has_rom_version = true,
 	  .has_msft_ext = true,
-	  .fw_name  = "rtl_bt/rtl8822cs_fw.bin",
+	  .fw_name  = "rtl_bt/rtl8822cs_fw",
 	  .cfg_name = "rtl_bt/rtl8822cs_config",
 	  .hw_info  = "rtl8822cs" },
 
@@ -250,7 +250,7 @@ static const struct id_table ic_id_table[] = {
 	  .config_needed = false,
 	  .has_rom_version = true,
 	  .has_msft_ext = true,
-	  .fw_name  = "rtl_bt/rtl8822cu_fw.bin",
+	  .fw_name  = "rtl_bt/rtl8822cu_fw",
 	  .cfg_name = "rtl_bt/rtl8822cu_config",
 	  .hw_info  = "rtl8822cu" },
 
@@ -259,7 +259,7 @@ static const struct id_table ic_id_table[] = {
 	  .config_needed = true,
 	  .has_rom_version = true,
 	  .has_msft_ext = true,
-	  .fw_name  = "rtl_bt/rtl8822b_fw.bin",
+	  .fw_name  = "rtl_bt/rtl8822b_fw",
 	  .cfg_name = "rtl_bt/rtl8822b_config",
 	  .hw_info  = "rtl8822bu" },
 
@@ -268,7 +268,7 @@ static const struct id_table ic_id_table[] = {
 	  .config_needed = false,
 	  .has_rom_version = true,
 	  .has_msft_ext = true,
-	  .fw_name  = "rtl_bt/rtl8852au_fw.bin",
+	  .fw_name  = "rtl_bt/rtl8852au_fw",
 	  .cfg_name = "rtl_bt/rtl8852au_config",
 	  .hw_info  = "rtl8852au" },
 
@@ -277,7 +277,7 @@ static const struct id_table ic_id_table[] = {
 	  .config_needed = true,
 	  .has_rom_version = true,
 	  .has_msft_ext = true,
-	  .fw_name  = "rtl_bt/rtl8852bs_fw.bin",
+	  .fw_name  = "rtl_bt/rtl8852bs_fw",
 	  .cfg_name = "rtl_bt/rtl8852bs_config",
 	  .hw_info  = "rtl8852bs" },
 
@@ -286,7 +286,7 @@ static const struct id_table ic_id_table[] = {
 	  .config_needed = false,
 	  .has_rom_version = true,
 	  .has_msft_ext = true,
-	  .fw_name  = "rtl_bt/rtl8852bu_fw.bin",
+	  .fw_name  = "rtl_bt/rtl8852bu_fw",
 	  .cfg_name = "rtl_bt/rtl8852bu_config",
 	  .hw_info  = "rtl8852bu" },
 
@@ -295,7 +295,7 @@ static const struct id_table ic_id_table[] = {
 	  .config_needed = false,
 	  .has_rom_version = true,
 	  .has_msft_ext = true,
-	  .fw_name  = "rtl_bt/rtl8852cu_fw.bin",
+	  .fw_name  = "rtl_bt/rtl8852cu_fw",
 	  .cfg_name = "rtl_bt/rtl8852cu_config",
 	  .hw_info  = "rtl8852cu" },
 
@@ -304,7 +304,7 @@ static const struct id_table ic_id_table[] = {
 	  .config_needed = false,
 	  .has_rom_version = true,
 	  .has_msft_ext = false,
-	  .fw_name  = "rtl_bt/rtl8851bu_fw.bin",
+	  .fw_name  = "rtl_bt/rtl8851bu_fw",
 	  .cfg_name = "rtl_bt/rtl8851bu_config",
 	  .hw_info  = "rtl8851bu" },
 	};
@@ -1045,6 +1045,7 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 	struct sk_buff *skb;
 	struct hci_rp_read_local_version *resp;
 	struct hci_command_hdr *cmd;
+	char fw_name[40];
 	char cfg_name[40];
 	u16 hci_rev, lmp_subver;
 	u8 hci_ver, lmp_ver, chip_type = 0;
@@ -1154,8 +1155,26 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 			goto err_free;
 	}
 
-	btrtl_dev->fw_len = rtl_load_file(hdev, btrtl_dev->ic_info->fw_name,
-					  &btrtl_dev->fw_data);
+	if (!btrtl_dev->ic_info->fw_name) {
+		ret = -ENOMEM;
+		goto err_free;
+	}
+
+	btrtl_dev->fw_len = -EIO;
+	if (lmp_subver == RTL_ROM_LMP_8852A && hci_rev == 0x000c) {
+		snprintf(fw_name, sizeof(fw_name), "%s_v2.bin",
+				btrtl_dev->ic_info->fw_name);
+		btrtl_dev->fw_len = rtl_load_file(hdev, fw_name,
+				&btrtl_dev->fw_data);
+	}
+
+	if (btrtl_dev->fw_len < 0) {
+		snprintf(fw_name, sizeof(fw_name), "%s.bin",
+				btrtl_dev->ic_info->fw_name);
+		btrtl_dev->fw_len = rtl_load_file(hdev, fw_name,
+				&btrtl_dev->fw_data);
+	}
+
 	if (btrtl_dev->fw_len < 0) {
 		rtl_dev_err(hdev, "firmware file %s not found",
 			    btrtl_dev->ic_info->fw_name);
@@ -1491,4 +1510,5 @@ MODULE_FIRMWARE("rtl_bt/rtl8852bs_config.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8852bu_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8852bu_config.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8852cu_fw.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8852cu_fw_v2.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8852cu_config.bin");
-- 
2.34.1

