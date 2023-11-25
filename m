Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66ED7F8D0C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 19:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbjKYSWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 13:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjKYSW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 13:22:28 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93F4DB;
        Sat, 25 Nov 2023 10:22:33 -0800 (PST)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3APDTRpj020744;
        Sat, 25 Nov 2023 19:22:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        selector1; bh=gkm0I1oG8oLv8E35BJU9COk/VzlDRgAl0VXDkgVpWVw=; b=RR
        NdDkwTsT5T9ZLOG2E4STcei6kFaX59Nelo++Bmy48aPf3XLgJ3bLAoFvSKc1lnG+
        0Q6MKAPFCo2AfxtkJ5qbhGhrGAzPJW2imHvT37ZkmzYPKL4We4XVuQpljkvO0EtM
        Vu8UyHN6xl7qVMQqom6saBkHFx9kZgh0DGm8XSltobzN47gFCVEat0zLwB6LQRI1
        tMljnyfmU6JRKKZiWFMI+ET9HFJKFCnNB2G31m+TO6DXQL96unKdjJkLBaK3H0Ac
        QKQOQfAzyujtT/dek1HGcnOwWgJuaxfXMXFmbJqZ+qY0yL+QiTGhe+PunytCWms+
        QPd1CMG0CCMuXQEEG2tA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3uk951hvng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 25 Nov 2023 19:22:06 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 209B510004A;
        Sat, 25 Nov 2023 19:22:05 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DBF2823C6A6;
        Sat, 25 Nov 2023 19:22:05 +0100 (CET)
Received: from localhost (10.129.178.213) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 25 Nov
 2023 19:22:06 +0100
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Sylvain Petinot <sylvain.petinot@foss.st.com>
CC:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/7] media: i2c: st-mipid02: use cci_* helpers for register access.
Date:   Sat, 25 Nov 2023 19:20:51 +0100
Message-ID: <20231125182057.1379357-4-alain.volmat@foss.st.com>
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

Use cci_read & cci_write functions for accessing registers.

Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
---
 drivers/media/i2c/Kconfig      |   1 +
 drivers/media/i2c/st-mipid02.c | 169 +++++++++------------------------
 2 files changed, 47 insertions(+), 123 deletions(-)

diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
index 59ee0ca2c978..68f84a47f307 100644
--- a/drivers/media/i2c/Kconfig
+++ b/drivers/media/i2c/Kconfig
@@ -1432,6 +1432,7 @@ config VIDEO_ST_MIPID02
 	depends on I2C && VIDEO_DEV
 	select MEDIA_CONTROLLER
 	select VIDEO_V4L2_SUBDEV_API
+	select V4L2_CCI_I2C
 	select V4L2_FWNODE
 	help
 	  Support for STMicroelectronics MIPID02 CSI-2 to PARALLEL bridge.
diff --git a/drivers/media/i2c/st-mipid02.c b/drivers/media/i2c/st-mipid02.c
index 1efaa54866a8..15f6c9e8b7f1 100644
--- a/drivers/media/i2c/st-mipid02.c
+++ b/drivers/media/i2c/st-mipid02.c
@@ -17,24 +17,25 @@
 #include <linux/of_graph.h>
 #include <linux/regulator/consumer.h>
 #include <media/v4l2-async.h>
+#include <media/v4l2-cci.h>
 #include <media/v4l2-ctrls.h>
 #include <media/v4l2-device.h>
 #include <media/v4l2-fwnode.h>
 #include <media/v4l2-subdev.h>
 
-#define MIPID02_CLK_LANE_WR_REG1			0x01
-#define MIPID02_CLK_LANE_REG1				0x02
-#define MIPID02_CLK_LANE_REG3				0x04
-#define MIPID02_DATA_LANE0_REG1				0x05
-#define MIPID02_DATA_LANE0_REG2				0x06
-#define MIPID02_DATA_LANE1_REG1				0x09
-#define MIPID02_DATA_LANE1_REG2				0x0a
-#define MIPID02_MODE_REG1				0x14
-#define MIPID02_MODE_REG2				0x15
-#define MIPID02_DATA_ID_RREG				0x17
-#define MIPID02_DATA_SELECTION_CTRL			0x19
-#define MIPID02_PIX_WIDTH_CTRL				0x1e
-#define MIPID02_PIX_WIDTH_CTRL_EMB			0x1f
+#define MIPID02_CLK_LANE_WR_REG1	CCI_REG8(0x01)
+#define MIPID02_CLK_LANE_REG1		CCI_REG8(0x02)
+#define MIPID02_CLK_LANE_REG3		CCI_REG8(0x04)
+#define MIPID02_DATA_LANE0_REG1		CCI_REG8(0x05)
+#define MIPID02_DATA_LANE0_REG2		CCI_REG8(0x06)
+#define MIPID02_DATA_LANE1_REG1		CCI_REG8(0x09)
+#define MIPID02_DATA_LANE1_REG2		CCI_REG8(0x0a)
+#define MIPID02_MODE_REG1		CCI_REG8(0x14)
+#define MIPID02_MODE_REG2		CCI_REG8(0x15)
+#define MIPID02_DATA_ID_RREG		CCI_REG8(0x17)
+#define MIPID02_DATA_SELECTION_CTRL	CCI_REG8(0x19)
+#define MIPID02_PIX_WIDTH_CTRL		CCI_REG8(0x1e)
+#define MIPID02_PIX_WIDTH_CTRL_EMB	CCI_REG8(0x1f)
 
 /* Bits definition for MIPID02_CLK_LANE_REG1 */
 #define CLK_ENABLE					BIT(0)
@@ -88,6 +89,7 @@ struct mipid02_dev {
 	struct i2c_client *i2c_client;
 	struct regulator_bulk_data supplies[MIPID02_NUM_SUPPLIES];
 	struct v4l2_subdev sd;
+	struct regmap *regmap;
 	struct media_pad pad[MIPID02_PAD_NB];
 	struct clk *xclk;
 	struct gpio_desc *reset_gpio;
@@ -237,62 +239,6 @@ static inline struct mipid02_dev *to_mipid02_dev(struct v4l2_subdev *sd)
 	return container_of(sd, struct mipid02_dev, sd);
 }
 
-static int mipid02_read_reg(struct mipid02_dev *bridge, u16 reg, u8 *val)
-{
-	struct i2c_client *client = bridge->i2c_client;
-	struct i2c_msg msg[2];
-	u8 buf[2];
-	int ret;
-
-	buf[0] = reg >> 8;
-	buf[1] = reg & 0xff;
-
-	msg[0].addr = client->addr;
-	msg[0].flags = client->flags;
-	msg[0].buf = buf;
-	msg[0].len = sizeof(buf);
-
-	msg[1].addr = client->addr;
-	msg[1].flags = client->flags | I2C_M_RD;
-	msg[1].buf = val;
-	msg[1].len = 1;
-
-	ret = i2c_transfer(client->adapter, msg, 2);
-	if (ret < 0) {
-		dev_dbg(&client->dev, "%s: %x i2c_transfer, reg: %x => %d\n",
-			    __func__, client->addr, reg, ret);
-		return ret;
-	}
-
-	return 0;
-}
-
-static int mipid02_write_reg(struct mipid02_dev *bridge, u16 reg, u8 val)
-{
-	struct i2c_client *client = bridge->i2c_client;
-	struct i2c_msg msg;
-	u8 buf[3];
-	int ret;
-
-	buf[0] = reg >> 8;
-	buf[1] = reg & 0xff;
-	buf[2] = val;
-
-	msg.addr = client->addr;
-	msg.flags = client->flags;
-	msg.buf = buf;
-	msg.len = sizeof(buf);
-
-	ret = i2c_transfer(client->adapter, &msg, 1);
-	if (ret < 0) {
-		dev_dbg(&client->dev, "%s: i2c_transfer, reg: %x => %d\n",
-			    __func__, reg, ret);
-		return ret;
-	}
-
-	return 0;
-}
-
 static int mipid02_get_regulators(struct mipid02_dev *bridge)
 {
 	unsigned int i;
@@ -357,13 +303,13 @@ static void mipid02_set_power_off(struct mipid02_dev *bridge)
 
 static int mipid02_detect(struct mipid02_dev *bridge)
 {
-	u8 reg;
+	u64 reg;
 
 	/*
 	 * There is no version registers. Just try to read register
 	 * MIPID02_CLK_LANE_WR_REG1.
 	 */
-	return mipid02_read_reg(bridge, MIPID02_CLK_LANE_WR_REG1, &reg);
+	return cci_read(bridge->regmap, MIPID02_CLK_LANE_WR_REG1, &reg, NULL);
 }
 
 /*
@@ -524,13 +470,9 @@ static int mipid02_stream_disable(struct mipid02_dev *bridge)
 		goto error;
 
 	/* Disable all lanes */
-	ret = mipid02_write_reg(bridge, MIPID02_CLK_LANE_REG1, 0);
-	if (ret)
-		goto error;
-	ret = mipid02_write_reg(bridge, MIPID02_DATA_LANE0_REG1, 0);
-	if (ret)
-		goto error;
-	ret = mipid02_write_reg(bridge, MIPID02_DATA_LANE1_REG1, 0);
+	cci_write(bridge->regmap, MIPID02_CLK_LANE_REG1, 0, &ret);
+	cci_write(bridge->regmap, MIPID02_DATA_LANE0_REG1, 0, &ret);
+	cci_write(bridge->regmap, MIPID02_DATA_LANE1_REG1, 0, &ret);
 	if (ret)
 		goto error;
 error:
@@ -561,51 +503,26 @@ static int mipid02_stream_enable(struct mipid02_dev *bridge)
 		goto error;
 
 	/* write mipi registers */
-	ret = mipid02_write_reg(bridge, MIPID02_CLK_LANE_REG1,
-		bridge->r.clk_lane_reg1);
-	if (ret)
-		goto error;
-	ret = mipid02_write_reg(bridge, MIPID02_CLK_LANE_REG3, CLK_MIPI_CSI);
-	if (ret)
-		goto error;
-	ret = mipid02_write_reg(bridge, MIPID02_DATA_LANE0_REG1,
-		bridge->r.data_lane0_reg1);
-	if (ret)
-		goto error;
-	ret = mipid02_write_reg(bridge, MIPID02_DATA_LANE0_REG2,
-		DATA_MIPI_CSI);
-	if (ret)
-		goto error;
-	ret = mipid02_write_reg(bridge, MIPID02_DATA_LANE1_REG1,
-		bridge->r.data_lane1_reg1);
-	if (ret)
-		goto error;
-	ret = mipid02_write_reg(bridge, MIPID02_DATA_LANE1_REG2,
-		DATA_MIPI_CSI);
-	if (ret)
-		goto error;
-	ret = mipid02_write_reg(bridge, MIPID02_MODE_REG1,
-		MODE_NO_BYPASS | bridge->r.mode_reg1);
-	if (ret)
-		goto error;
-	ret = mipid02_write_reg(bridge, MIPID02_MODE_REG2,
-		bridge->r.mode_reg2);
-	if (ret)
-		goto error;
-	ret = mipid02_write_reg(bridge, MIPID02_DATA_ID_RREG,
-		bridge->r.data_id_rreg);
-	if (ret)
-		goto error;
-	ret = mipid02_write_reg(bridge, MIPID02_DATA_SELECTION_CTRL,
-		bridge->r.data_selection_ctrl);
-	if (ret)
-		goto error;
-	ret = mipid02_write_reg(bridge, MIPID02_PIX_WIDTH_CTRL,
-		bridge->r.pix_width_ctrl);
-	if (ret)
-		goto error;
-	ret = mipid02_write_reg(bridge, MIPID02_PIX_WIDTH_CTRL_EMB,
-		bridge->r.pix_width_ctrl_emb);
+	cci_write(bridge->regmap, MIPID02_CLK_LANE_REG1,
+		  bridge->r.clk_lane_reg1, &ret);
+	cci_write(bridge->regmap, MIPID02_CLK_LANE_REG3, CLK_MIPI_CSI, &ret);
+	cci_write(bridge->regmap, MIPID02_DATA_LANE0_REG1,
+		  bridge->r.data_lane0_reg1, &ret);
+	cci_write(bridge->regmap, MIPID02_DATA_LANE0_REG2, DATA_MIPI_CSI, &ret);
+	cci_write(bridge->regmap, MIPID02_DATA_LANE1_REG1,
+		  bridge->r.data_lane1_reg1, &ret);
+	cci_write(bridge->regmap, MIPID02_DATA_LANE1_REG2, DATA_MIPI_CSI, &ret);
+	cci_write(bridge->regmap, MIPID02_MODE_REG1,
+		  MODE_NO_BYPASS | bridge->r.mode_reg1, &ret);
+	cci_write(bridge->regmap, MIPID02_MODE_REG2, bridge->r.mode_reg2, &ret);
+	cci_write(bridge->regmap, MIPID02_DATA_ID_RREG, bridge->r.data_id_rreg,
+		  &ret);
+	cci_write(bridge->regmap, MIPID02_DATA_SELECTION_CTRL,
+		  bridge->r.data_selection_ctrl, &ret);
+	cci_write(bridge->regmap, MIPID02_PIX_WIDTH_CTRL,
+		  bridge->r.pix_width_ctrl, &ret);
+	cci_write(bridge->regmap, MIPID02_PIX_WIDTH_CTRL_EMB,
+		  bridge->r.pix_width_ctrl_emb, &ret);
 	if (ret)
 		goto error;
 
@@ -984,6 +901,12 @@ static int mipid02_probe(struct i2c_client *client)
 		return ret;
 	}
 
+	/* Initialise the regmap for further cci access */
+	bridge->regmap = devm_cci_regmap_init_i2c(client, 16);
+	if (IS_ERR(bridge->regmap))
+		return dev_err_probe(dev, PTR_ERR(bridge->regmap),
+				     "failed to get cci regmap\n");
+
 	mutex_init(&bridge->lock);
 	bridge->sd.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
 	bridge->sd.entity.function = MEDIA_ENT_F_VID_IF_BRIDGE;
-- 
2.25.1

