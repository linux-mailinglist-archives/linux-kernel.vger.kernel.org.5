Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3467D760BE7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 09:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjGYHeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 03:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbjGYHd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 03:33:58 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BD5DC18D;
        Tue, 25 Jul 2023 00:31:31 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 36P7V1Ni8028318, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 36P7V1Ni8028318
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 25 Jul 2023 15:31:01 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 25 Jul 2023 15:31:12 +0800
Received: from fc38.localdomain (172.22.228.98) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 25 Jul
 2023 15:31:10 +0800
From:   Hayes Wang <hayeswang@realtek.com>
To:     <kuba@kernel.org>, <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <nic_swsd@realtek.com>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        Hayes Wang <hayeswang@realtek.com>
Subject: [PATCH net-next 2/2] r8152: set bp in bulk
Date:   Tue, 25 Jul 2023 15:30:50 +0800
Message-ID: <20230725073051.5150-416-nic_swsd@realtek.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725073051.5150-414-nic_swsd@realtek.com>
References: <20230725073051.5150-414-nic_swsd@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.22.228.98]
X-ClientProxiedBy: RTEXH36506.realtek.com.tw (172.21.6.27) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PLA_BP_0 ~ PLA_BP_15 (0xfc28 ~ 0xfc46) are continuous registers, so we
could combine the control transfers into one control transfer.

Signed-off-by: Hayes Wang <hayeswang@realtek.com>
---
 drivers/net/usb/r8152.c | 75 ++++++++++++++---------------------------
 1 file changed, 25 insertions(+), 50 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index f6578a99dbac..db9897e825b4 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -3978,29 +3978,10 @@ static void rtl_reset_bmu(struct r8152 *tp)
 /* Clear the bp to stop the firmware before loading a new one */
 static void rtl_clear_bp(struct r8152 *tp, u16 type)
 {
-	switch (tp->version) {
-	case RTL_VER_01:
-	case RTL_VER_02:
-	case RTL_VER_07:
-		break;
-	case RTL_VER_03:
-	case RTL_VER_04:
-	case RTL_VER_05:
-	case RTL_VER_06:
-		ocp_write_byte(tp, type, PLA_BP_EN, 0);
-		break;
-	case RTL_VER_14:
-		ocp_write_word(tp, type, USB_BP2_EN, 0);
+	u16 bp[16] = {0};
+	u16 bp_num;
 
-		ocp_write_word(tp, type, USB_BP_8, 0);
-		ocp_write_word(tp, type, USB_BP_9, 0);
-		ocp_write_word(tp, type, USB_BP_10, 0);
-		ocp_write_word(tp, type, USB_BP_11, 0);
-		ocp_write_word(tp, type, USB_BP_12, 0);
-		ocp_write_word(tp, type, USB_BP_13, 0);
-		ocp_write_word(tp, type, USB_BP_14, 0);
-		ocp_write_word(tp, type, USB_BP_15, 0);
-		break;
+	switch (tp->version) {
 	case RTL_VER_08:
 	case RTL_VER_09:
 	case RTL_VER_10:
@@ -4008,32 +3989,31 @@ static void rtl_clear_bp(struct r8152 *tp, u16 type)
 	case RTL_VER_12:
 	case RTL_VER_13:
 	case RTL_VER_15:
-	default:
 		if (type == MCU_TYPE_USB) {
 			ocp_write_word(tp, MCU_TYPE_USB, USB_BP2_EN, 0);
-
-			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_8, 0);
-			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_9, 0);
-			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_10, 0);
-			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_11, 0);
-			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_12, 0);
-			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_13, 0);
-			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_14, 0);
-			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_15, 0);
-		} else {
-			ocp_write_byte(tp, MCU_TYPE_PLA, PLA_BP_EN, 0);
+			bp_num = 16;
+			break;
 		}
+		fallthrough;
+	case RTL_VER_03:
+	case RTL_VER_04:
+	case RTL_VER_05:
+	case RTL_VER_06:
+		ocp_write_byte(tp, type, PLA_BP_EN, 0);
+		fallthrough;
+	case RTL_VER_01:
+	case RTL_VER_02:
+	case RTL_VER_07:
+		bp_num = 8;
+		break;
+	case RTL_VER_14:
+	default:
+		ocp_write_word(tp, type, USB_BP2_EN, 0);
+		bp_num = 16;
 		break;
 	}
 
-	ocp_write_word(tp, type, PLA_BP_0, 0);
-	ocp_write_word(tp, type, PLA_BP_1, 0);
-	ocp_write_word(tp, type, PLA_BP_2, 0);
-	ocp_write_word(tp, type, PLA_BP_3, 0);
-	ocp_write_word(tp, type, PLA_BP_4, 0);
-	ocp_write_word(tp, type, PLA_BP_5, 0);
-	ocp_write_word(tp, type, PLA_BP_6, 0);
-	ocp_write_word(tp, type, PLA_BP_7, 0);
+	generic_ocp_write(tp, PLA_BP_0, BYTE_EN_DWORD, bp_num << 1, bp, type);
 
 	/* wait 3 ms to make sure the firmware is stopped */
 	usleep_range(3000, 6000);
@@ -5007,10 +4987,9 @@ static void rtl8152_fw_phy_nc_apply(struct r8152 *tp, struct fw_phy_nc *phy)
 
 static void rtl8152_fw_mac_apply(struct r8152 *tp, struct fw_mac *mac)
 {
-	u16 bp_en_addr, bp_index, type, bp_num, fw_ver_reg;
+	u16 bp_en_addr, type, fw_ver_reg;
 	u32 length;
 	u8 *data;
-	int i;
 
 	switch (__le32_to_cpu(mac->blk_hdr.type)) {
 	case RTL_FW_PLA:
@@ -5052,12 +5031,8 @@ static void rtl8152_fw_mac_apply(struct r8152 *tp, struct fw_mac *mac)
 	ocp_write_word(tp, type, __le16_to_cpu(mac->bp_ba_addr),
 		       __le16_to_cpu(mac->bp_ba_value));
 
-	bp_index = __le16_to_cpu(mac->bp_start);
-	bp_num = __le16_to_cpu(mac->bp_num);
-	for (i = 0; i < bp_num; i++) {
-		ocp_write_word(tp, type, bp_index, __le16_to_cpu(mac->bp[i]));
-		bp_index += 2;
-	}
+	generic_ocp_write(tp, __le16_to_cpu(mac->bp_start), BYTE_EN_DWORD,
+			  __le16_to_cpu(mac->bp_num) << 1, mac->bp, type);
 
 	bp_en_addr = __le16_to_cpu(mac->bp_en_addr);
 	if (bp_en_addr)
-- 
2.41.0

