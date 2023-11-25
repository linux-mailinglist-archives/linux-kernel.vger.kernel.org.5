Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A177F8D10
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 19:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbjKYSWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 13:22:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjKYSW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 13:22:28 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063AB119;
        Sat, 25 Nov 2023 10:22:33 -0800 (PST)
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3APGHDXE019482;
        Sat, 25 Nov 2023 19:21:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        selector1; bh=HOBURhp8B0dbJzUA2B/3kWV5TC4bgsvCrRl8HPobFgo=; b=Qm
        IRdHp7bvWmEGwWkl8j9Fkh36WiWP2HkuXbZqZpfua5QOpkERoe387jVCAq0+BX2L
        cG9WfETDaxKP3evd9SnAwK2ZVPYnrzEBNM8sc/dDqw4AonuwGlM89Fo2XCpYB5Qh
        FD4Hwk8gEr7YzwbzdPxQC3Z0qpNxV9PdoZ/9kVMCPbhlMWVnH91O1AR1Kgh6JjZd
        CrlXmPPerIOZGRbqIeAPMJNbx/Za/D+IyqWnXU0jR7LSyxQB7wqBjs+UsBmgh1a6
        RvE8aRQHDnhLARdb4HE+mwYUpzaBHw1MuSWxiZesEckO1ezWaIwKOzVmk6EQquSu
        GVsxgOXRdaIIzskD04LA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3uhr8amwd0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 25 Nov 2023 19:21:48 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9995510002A;
        Sat, 25 Nov 2023 19:21:47 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 92DF223C6AC;
        Sat, 25 Nov 2023 19:21:47 +0100 (CET)
Received: from localhost (10.129.178.213) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 25 Nov
 2023 19:21:48 +0100
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Sylvain Petinot <sylvain.petinot@foss.st.com>
CC:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/7] media: i2c: st-mipid02: add usage of v4l2_get_link_freq
Date:   Sat, 25 Nov 2023 19:20:49 +0100
Message-ID: <20231125182057.1379357-2-alain.volmat@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231125182057.1379357-1-alain.volmat@foss.st.com>
References: <20231125182057.1379357-1-alain.volmat@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.129.178.213]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-25_17,2023-11-22_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the helper v4l2_get_link_freq instead of performing manually
check of the LINK_FREQ or PIXELRATE ctrls.

Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
---
 drivers/media/i2c/st-mipid02.c | 66 ++++++++++------------------------
 1 file changed, 18 insertions(+), 48 deletions(-)

diff --git a/drivers/media/i2c/st-mipid02.c b/drivers/media/i2c/st-mipid02.c
index 914f915749a8..b699f0b4efe7 100644
--- a/drivers/media/i2c/st-mipid02.c
+++ b/drivers/media/i2c/st-mipid02.c
@@ -367,64 +367,34 @@ static int mipid02_detect(struct mipid02_dev *bridge)
 	return mipid02_read_reg(bridge, MIPID02_CLK_LANE_WR_REG1, &reg);
 }
 
-static u32 mipid02_get_link_freq_from_cid_link_freq(struct mipid02_dev *bridge,
-						    struct v4l2_subdev *subdev)
-{
-	struct v4l2_querymenu qm = {.id = V4L2_CID_LINK_FREQ, };
-	struct v4l2_ctrl *ctrl;
-	int ret;
-
-	ctrl = v4l2_ctrl_find(subdev->ctrl_handler, V4L2_CID_LINK_FREQ);
-	if (!ctrl)
-		return 0;
-	qm.index = v4l2_ctrl_g_ctrl(ctrl);
-
-	ret = v4l2_querymenu(subdev->ctrl_handler, &qm);
-	if (ret)
-		return 0;
-
-	return qm.value;
-}
-
-static u32 mipid02_get_link_freq_from_cid_pixel_rate(struct mipid02_dev *bridge,
-						     struct v4l2_subdev *subdev)
-{
-	struct v4l2_fwnode_endpoint *ep = &bridge->rx;
-	struct v4l2_ctrl *ctrl;
-	u32 pixel_clock;
-	u32 bpp = bpp_from_code(bridge->fmt.code);
-
-	ctrl = v4l2_ctrl_find(subdev->ctrl_handler, V4L2_CID_PIXEL_RATE);
-	if (!ctrl)
-		return 0;
-	pixel_clock = v4l2_ctrl_g_ctrl_int64(ctrl);
-
-	return pixel_clock * bpp / (2 * ep->bus.mipi_csi2.num_data_lanes);
-}
-
 /*
  * We need to know link frequency to setup clk_lane_reg1 timings. Link frequency
- * will be computed using connected device V4L2_CID_PIXEL_RATE, bit per pixel
+ * will be retrieve from connected device via v4l2_get_link_freq, bit per pixel
  * and number of lanes.
  */
 static int mipid02_configure_from_rx_speed(struct mipid02_dev *bridge)
 {
 	struct i2c_client *client = bridge->i2c_client;
 	struct v4l2_subdev *subdev = bridge->s_subdev;
-	u32 link_freq;
-
-	link_freq = mipid02_get_link_freq_from_cid_link_freq(bridge, subdev);
-	if (!link_freq) {
-		link_freq = mipid02_get_link_freq_from_cid_pixel_rate(bridge,
-								      subdev);
-		if (!link_freq) {
-			dev_err(&client->dev, "Failed to get link frequency");
-			return -EINVAL;
-		}
+	struct v4l2_fwnode_endpoint *ep = &bridge->rx;
+	u32 bpp = bpp_from_code(bridge->fmt.code);
+	/*
+	 * clk_lane_reg1 requires 4 times the unit interval time, and bitrate
+	 * is twice the link frequency, hence ui_4 = 1000000000 * 4 / 2
+	 */
+	u64 ui_4 = 2000000000;
+	s64 link_freq;
+
+	link_freq = v4l2_get_link_freq(subdev->ctrl_handler, bpp,
+				       2 * ep->bus.mipi_csi2.num_data_lanes);
+	if (link_freq < 0) {
+		dev_err(&client->dev, "Failed to get link frequency");
+		return -EINVAL;
 	}
 
-	dev_dbg(&client->dev, "detect link_freq = %d Hz", link_freq);
-	bridge->r.clk_lane_reg1 |= (2000000000 / link_freq) << 2;
+	dev_dbg(&client->dev, "detect link_freq = %lld Hz", link_freq);
+	do_div(ui_4, link_freq);
+	bridge->r.clk_lane_reg1 |= ui_4 << 2;
 
 	return 0;
 }
-- 
2.25.1

