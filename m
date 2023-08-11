Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44E1778C58
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 12:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235909AbjHKKsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 06:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235538AbjHKKsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:48:16 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA9BE52;
        Fri, 11 Aug 2023 03:48:15 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37BAlpxn092957;
        Fri, 11 Aug 2023 05:47:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691750871;
        bh=pfeJn5pyuS1Kn375QoTKmqM/B3qqrMhFRPx327xhsos=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=gIbjb+UwYG9ssgfLaDISc9GrdglAG+3A3uGe8GTcMeWr9YOj0g9stuL5NzU6YjRfy
         o2kOgftOWEWrdSRAZmSfq6OAf5YtVb1dEmJUZR08IpBojFrngPWoSCNkZNnGQzADi9
         p59zffgdTEIyIXe+HaZ2pV1+TpSjlSA0wN2am5kk=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37BAlpGg110742
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Aug 2023 05:47:51 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Aug 2023 05:47:51 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Aug 2023 05:47:51 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37BAlo43060405;
        Fri, 11 Aug 2023 05:47:51 -0500
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
Subject: [PATCH v9 08/13] media: cadence: csi2rx: Set the STOP bit when stopping a stream
Date:   Fri, 11 Aug 2023 16:17:30 +0530
Message-ID: <20230811-upstream_csi-v9-8-8943f7a68a81@ti.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230811-upstream_csi-v9-0-8943f7a68a81@ti.com>
References: <20230811-upstream_csi-v9-0-8943f7a68a81@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2584; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=B9IsBzzslnxknnw5dp9TzgoPZyb3XNoa/gIIm3UOPT4=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBk1g8DZlrpcKDW2I0NMphSc/hdLQPuTsHKoXapk
 rWT7sAXJXmJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZNYPAwAKCRBD3pH5JJpx
 RXumEAC4O92x8fA2Qul+1He0FNQKRLbq358F7DtBxFxn1dwqq/nsAU97WYEobNA9dTR/rdfE6o3
 YHHZyGzBw0fS9e4mXT0C+twhKLpdYbrC5X9r4LBx0GMH7Ggw4z2W+K+FjFTM19jC3uKmPs0hNlK
 I/C2OIF+mMtM9M2M/zNlSCU1wAKotUXN8dudq52DTme8SuBQJGdIra/IyKgcZIf67dxCCJqV3+Y
 mMdVyyMeeAwVPBg5tEitFRWS1RB3oq63v0HGtF10kHKyt6OEYSsnccHQaKJPd55fOixVE5DIkWV
 Jxsj1Qq9kHoSob2QnaRd2+MaLaUIZ6bX5m5bRFPbhMQmsVOEGTZhMSq97u7Q4i7QvUyHv4JQvv3
 nMsS+27QFxJVbhmuAUociaKofSkqKtwsjaDrrIJBKZ2JmJLbmO6KZaqBIV0+0wx5TblCbQFGoOl
 mq20EMLs1jnkHgv88W03DAl174SWTehzl50Ltdmi0bWVyd3svGYbMs98w1V6cr+BegklQ9E/i4u
 qHj+6BM39svgFBBqMn23OsS05HGZcHLdqRjAEp0ru2crtrQoRkSdgkmEi0UrMw5tz1PnKdOdYGG
 jHwQhubJGu6ZEzic9kenTK3Bep6MddIXi00/Es/RQ/CzOCahx82rKMWeFxvktAI7WtWMPXEcFcG
 QP+cZbYempGBJwg==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp; fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
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
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
Changes from v8:
    - Better log message to avoid confusion between cadence streams and v4l2 
    streams

 drivers/media/platform/cadence/cdns-csi2rx.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index b57e0c3b1944..f8205c3a28c0 100644
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
2.41.0
