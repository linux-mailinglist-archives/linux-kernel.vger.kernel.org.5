Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079087BDD8F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 15:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376819AbjJINKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 09:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376806AbjJINKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 09:10:10 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCCA94;
        Mon,  9 Oct 2023 06:10:06 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 399D9s5x035863;
        Mon, 9 Oct 2023 08:09:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696856994;
        bh=vtgYRdhRlk1YmzBEx3yb0mO0lU3pX1Lt5Kg7jv1XUqo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=KhE8NnpkwZjv3z4LQITwymDZDqQlfBKXZE75SNdbh2c+BgGFYwFQLNXJTgXlbkL90
         x4GDL4gtXxF1C62iVcQXu06A0Dw99Q95XY15ufuoZpfOpStJPSSwAZw0JCZ536D3Tv
         fzrD8cakucoQx+V/+kWyZ651xAeKER4TLPA0QXEM=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 399D9sFW014548
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Oct 2023 08:09:54 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 9
 Oct 2023 08:09:53 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 9 Oct 2023 08:09:53 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 399D9rXu007359;
        Mon, 9 Oct 2023 08:09:53 -0500
From:   Jai Luthra <j-luthra@ti.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        <niklas.soderlund+renesas@ragnatech.se>,
        Benoit Parrot <bparrot@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, <nm@ti.com>,
        <devarsht@ti.com>, <j-luthra@ti.com>, <a-bhatia1@ti.com>,
        Martyn Welch <martyn.welch@collabora.com>,
        Julien Massot <julien.massot@collabora.com>
Subject: [PATCH v10 08/13] media: cadence: csi2rx: Set the STOP bit when stopping a stream
Date:   Mon, 9 Oct 2023 18:39:34 +0530
Message-ID: <20231009-upstream_csi-v10-8-330aaed24c5d@ti.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009-upstream_csi-v10-0-330aaed24c5d@ti.com>
References: <20231009-upstream_csi-v10-0-330aaed24c5d@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2528; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=yTXIIHZ7yHvfkBehaXvly8sQUzrqAsJQob6QxmW6ETc=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBlI/sssGXfTN0tDNfaKfrem+MZS1CyNLez01/xX
 8FBJez74+GJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZSP7LAAKCRBD3pH5JJpx
 RdRUD/98bxH17x9qQpAtrD9RgbsXY0FDbGxBI52epF0LkkxtecvitpLpr0KAgiW13usR0JGIHNu
 EICehuM9EwWJwElxkXdrfYR51fGXcJH3xU5oJM7cVg1GAiJrLmBzY4XxVmSE3r/rlxMmqpNlg/C
 tjPRGw1iGkTKZi8s/x6F5uoiu/37PkL/XoO2st9z0aLsOw4KZcNOsbBmypp5rx6AnWHmfstWcrb
 PmH2ja5f00Bjnl0FtoI6zwVDYbee/PWcM101KX4olF4xKspHU/hDHZ7rmQGi0UnUfq8tmZ3Qeur
 gpZvAZzYJBw13phWDqhZEm0OI89qW8L8pEL71xeYi8/trGPdN1TRLghqS2T2ol9l0HdDlZbCIK6
 gJt4LwRBSGW8k1Xb9TdcuH+QQ7CKudBQcp7GYV9O0HxGvOfQvcu8JdmtMtd64bas4wWzU79DCVh
 BrvHeiXkt07ByBOYEVm2OSUOUkPyX5+bG/RhB2M6fjI2U4Ys7FjQObotwvLqSkwICygQCXyfI7Y
 ZbsV65Ye00kWINAg3IXGz07sNLErUPOvedAW4DlbugPK2bzrDzBxrxFsvC0RalwtYyr78noWizk
 W4uxQehxmSF3+qoQx5tD8ztWg4Jr3T8BFDHPihh9w0g3CUywcWpkFgwxZXZ0FcsNRIDdRDwDV+0
 KH3YwIVWscwUnHQ==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp; fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pratyush Yadav <p.yadav@ti.com>

The stream stop procedure says that the STOP bit should be set when the
stream is to be stopped, and then the ready bit in stream status
register polled to make sure the STOP operation is finished.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Tested-by: Julien Massot <julien.massot@collabora.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 drivers/media/platform/cadence/cdns-csi2rx.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index 913f84c341f4..230c627ef1f4 100644
--- a/drivers/media/platform/cadence/cdns-csi2rx.c
+++ b/drivers/media/platform/cadence/cdns-csi2rx.c
@@ -8,6 +8,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_graph.h>
@@ -41,8 +42,12 @@
 
 #define CSI2RX_STREAM_CTRL_REG(n)		(CSI2RX_STREAM_BASE(n) + 0x000)
 #define CSI2RX_STREAM_CTRL_SOFT_RST			BIT(4)
+#define CSI2RX_STREAM_CTRL_STOP				BIT(1)
 #define CSI2RX_STREAM_CTRL_START			BIT(0)
 
+#define CSI2RX_STREAM_STATUS_REG(n)		(CSI2RX_STREAM_BASE(n) + 0x004)
+#define CSI2RX_STREAM_STATUS_RDY			BIT(31)
+
 #define CSI2RX_STREAM_DATA_CFG_REG(n)		(CSI2RX_STREAM_BASE(n) + 0x008)
 #define CSI2RX_STREAM_DATA_CFG_EN_VC_SELECT		BIT(31)
 #define CSI2RX_STREAM_DATA_CFG_VC_SELECT(n)		BIT((n) + 16)
@@ -310,13 +315,25 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
 static void csi2rx_stop(struct csi2rx_priv *csi2rx)
 {
 	unsigned int i;
+	u32 val;
+	int ret;
 
 	clk_prepare_enable(csi2rx->p_clk);
 	reset_control_assert(csi2rx->sys_rst);
 	clk_disable_unprepare(csi2rx->sys_clk);
 
 	for (i = 0; i < csi2rx->max_streams; i++) {
-		writel(0, csi2rx->base + CSI2RX_STREAM_CTRL_REG(i));
+		writel(CSI2RX_STREAM_CTRL_STOP,
+		       csi2rx->base + CSI2RX_STREAM_CTRL_REG(i));
+
+		ret = readl_relaxed_poll_timeout(csi2rx->base +
+						 CSI2RX_STREAM_STATUS_REG(i),
+						 val,
+						 !(val & CSI2RX_STREAM_STATUS_RDY),
+						 10, 10000);
+		if (ret)
+			dev_warn(csi2rx->dev,
+				 "Failed to stop streaming on pad%u\n", i);
 
 		reset_control_assert(csi2rx->pixel_rst[i]);
 		clk_disable_unprepare(csi2rx->pixel_clk[i]);

-- 
2.42.0
