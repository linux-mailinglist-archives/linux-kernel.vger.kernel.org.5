Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33033765E6B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 23:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbjG0Vwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 17:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbjG0Vwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 17:52:31 -0400
Received: from qs51p00im-qukt01072102.me.com (qs51p00im-qukt01072102.me.com [17.57.155.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FAC2135
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 14:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1690494749; bh=4Q2kPpx9tnkAzIsBSu0lR+5VOLaRmSNvSKU5kR9IbKY=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=0RBvR1s3gPsmnwWxF3fgSp6Vr5lH/sKdAVs7b3TKhp7TfOQsxqRFPin8qLOvAfTgX
         GXdmWe2m/l+ywwqZv5Ihnm/rfJFvuyWutgL1AXJQs0txL870Zm6ViDH2Hge/8Twxpm
         1Dhv3i90ExxqIWhwsVCEUbDgccbaDFTtZNTHiRlmx0pPi4JtMAMWuQUGUWPRdByuNp
         +boLnefyT5BWdh6L+DN0ki6SbX/CTiGzkxkl/s0sIJMDWtEK0i28IDuI/H0JrhSQTU
         c8tQsfOnaoeuA7FtdlGeaDQlAyvQScsjI8N8BCSelzqKx3C7JH4FBv3ee8v0w/7nnS
         a3ThaBe9L7aSw==
Received: from localhost (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
        by qs51p00im-qukt01072102.me.com (Postfix) with ESMTPSA id 7940734099C;
        Thu, 27 Jul 2023 21:52:28 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Alain Volmat <alain.volmat@foss.st.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Alain Volmat <avolmat@me.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/14] drm/sti: add support for VTG on the stih418 platform
Date:   Thu, 27 Jul 2023 21:51:27 +0000
Message-Id: <20230727215141.53910-4-avolmat@me.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230727215141.53910-1-avolmat@me.com>
References: <20230727215141.53910-1-avolmat@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: TYCF9UE_guExnaT3ERZOGvZzEjQFonTj
X-Proofpoint-GUID: TYCF9UE_guExnaT3ERZOGvZzEjQFonTj
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.790,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-12=5F02:2020-02-14=5F02,2022-01-12=5F02,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 clxscore=1015 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2307270199
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VTG integrated into the STiH418 differ in the number of outputs
available and allocation of each output.  Indeed on STiH418, there
are 6 outputs (4 on the STiH407/STiH410) and HDMI is connected to
the 5th output in case of STiH418 while it is on the 1st output
in case of STiH407/STiH410.

A new compatible st,stih418-vtg is added to differentiate that.

Signed-off-by: Alain Volmat <avolmat@me.com>
---
 drivers/gpu/drm/sti/sti_vtg.c | 62 +++++++++++++++++++++++++++++------
 1 file changed, 52 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/sti/sti_vtg.c b/drivers/gpu/drm/sti/sti_vtg.c
index 5e5f82b6a5d9..b0cab72ea502 100644
--- a/drivers/gpu/drm/sti/sti_vtg.c
+++ b/drivers/gpu/drm/sti/sti_vtg.c
@@ -60,6 +60,18 @@
 #define VTG_TOP_V_HD_4      0x012c
 #define VTG_BOT_V_HD_4      0x0130
 
+#define VTG_H_HD_5          0x0140
+#define VTG_TOP_V_VD_5      0x0144
+#define VTG_BOT_V_VD_5      0x0148
+#define VTG_TOP_V_HD_5      0x014c
+#define VTG_BOT_V_HD_5      0x0150
+
+#define VTG_H_HD_6          0x0160
+#define VTG_TOP_V_VD_6      0x0164
+#define VTG_BOT_V_VD_6      0x0168
+#define VTG_TOP_V_HD_6      0x016c
+#define VTG_BOT_V_HD_6      0x0170
+
 #define VTG_IRQ_BOTTOM      BIT(0)
 #define VTG_IRQ_TOP         BIT(1)
 #define VTG_IRQ_MASK        (VTG_IRQ_TOP | VTG_IRQ_BOTTOM)
@@ -92,7 +104,12 @@ struct sti_vtg_regs_offs {
 	u32 bot_v_hd;
 };
 
-#define VTG_MAX_SYNC_OUTPUT 4
+struct sti_vtg_data {
+	unsigned int nb_sync_output;
+	unsigned int hdmi_sync_id;
+};
+
+#define VTG_MAX_SYNC_OUTPUT 6
 static const struct sti_vtg_regs_offs vtg_regs_offs[VTG_MAX_SYNC_OUTPUT] = {
 	{ VTG_H_HD_1,
 	  VTG_TOP_V_VD_1, VTG_BOT_V_VD_1, VTG_TOP_V_HD_1, VTG_BOT_V_HD_1 },
@@ -101,7 +118,11 @@ static const struct sti_vtg_regs_offs vtg_regs_offs[VTG_MAX_SYNC_OUTPUT] = {
 	{ VTG_H_HD_3,
 	  VTG_TOP_V_VD_3, VTG_BOT_V_VD_3, VTG_TOP_V_HD_3, VTG_BOT_V_HD_3 },
 	{ VTG_H_HD_4,
-	  VTG_TOP_V_VD_4, VTG_BOT_V_VD_4, VTG_TOP_V_HD_4, VTG_BOT_V_HD_4 }
+	  VTG_TOP_V_VD_4, VTG_BOT_V_VD_4, VTG_TOP_V_HD_4, VTG_BOT_V_HD_4 },
+	{ VTG_H_HD_5,
+	  VTG_TOP_V_VD_5, VTG_BOT_V_VD_5, VTG_TOP_V_HD_5, VTG_BOT_V_HD_5 },
+	{ VTG_H_HD_6,
+	  VTG_TOP_V_VD_6, VTG_BOT_V_VD_6, VTG_TOP_V_HD_6, VTG_BOT_V_HD_6 }
 };
 
 /*
@@ -138,6 +159,7 @@ struct sti_vtg {
 	u32 irq_status;
 	struct raw_notifier_head notifier_list;
 	struct drm_crtc *crtc;
+	struct sti_vtg_data data;
 };
 
 struct sti_vtg *of_vtg_find(struct device_node *np)
@@ -252,7 +274,7 @@ static void vtg_set_mode(struct sti_vtg *vtg,
 	vtg_set_output_window(vtg->regs, mode);
 
 	/* Set hsync and vsync position for HDMI */
-	vtg_set_hsync_vsync_pos(&sync[VTG_SYNC_ID_HDMI - 1], HDMI_DELAY, mode);
+	vtg_set_hsync_vsync_pos(&sync[vtg->data.hdmi_sync_id - 1], HDMI_DELAY, mode);
 
 	/* Set hsync and vsync position for HD DCS */
 	vtg_set_hsync_vsync_pos(&sync[VTG_SYNC_ID_HDDCS - 1], 0, mode);
@@ -264,7 +286,7 @@ static void vtg_set_mode(struct sti_vtg *vtg,
 	vtg_set_hsync_vsync_pos(&sync[VTG_SYNC_ID_DVO - 1], DVO_DELAY, mode);
 
 	/* Progam the syncs outputs */
-	for (i = 0; i < VTG_MAX_SYNC_OUTPUT ; i++) {
+	for (i = 0; i < vtg->data.nb_sync_output ; i++) {
 		writel(sync[i].hsync,
 		       vtg->regs + vtg_regs_offs[i].h_hd);
 		writel(sync[i].vsync_line_top,
@@ -376,9 +398,27 @@ static irqreturn_t vtg_irq(int irq, void *arg)
 	return IRQ_WAKE_THREAD;
 }
 
+static const struct sti_vtg_data stih407_vtg_data = {
+	.nb_sync_output = 4,
+	.hdmi_sync_id = 1,
+};
+
+static const struct sti_vtg_data stih418_vtg_data = {
+	.nb_sync_output = 6,
+	.hdmi_sync_id = 5,
+};
+
+static const struct of_device_id vtg_of_match[] = {
+	{ .compatible = "st,vtg", .data = &stih407_vtg_data, },
+	{ .compatible = "st,stih418-vtg", .data = &stih418_vtg_data, },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, vtg_of_match);
+
 static int vtg_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
 	struct sti_vtg *vtg;
 	struct resource *res;
 	int ret;
@@ -387,6 +427,14 @@ static int vtg_probe(struct platform_device *pdev)
 	if (!vtg)
 		return -ENOMEM;
 
+	memcpy(&vtg->data, of_match_node(vtg_of_match, np)->data,
+	       sizeof(struct sti_vtg_data));
+
+	if (vtg->data.nb_sync_output > VTG_MAX_SYNC_OUTPUT) {
+		dev_err(dev, "Invalid number of VTG sync output\n");
+		return -EINVAL;
+	}
+
 	/* Get Memory ressources */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
@@ -422,12 +470,6 @@ static int vtg_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id vtg_of_match[] = {
-	{ .compatible = "st,vtg", },
-	{ /* sentinel */ }
-};
-MODULE_DEVICE_TABLE(of, vtg_of_match);
-
 struct platform_driver sti_vtg_driver = {
 	.driver = {
 		.name = "sti-vtg",
-- 
2.34.1

