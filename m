Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FB5769031
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbjGaIah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjGaI36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:29:58 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9C11AD;
        Mon, 31 Jul 2023 01:29:56 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36V8Tnaf054973;
        Mon, 31 Jul 2023 03:29:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690792189;
        bh=30ahlwMEWy8UHgZ6OwU/9F3tt2IrND9+tluitn/vXsc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=vtTEqU6g2L0YeVAk6xhzsP2zyAG1xfK1Wpq3bK/YvAsBVv9GpWm2fEmuRskzJSjEa
         /m1iQVjbDwj5utzkDQUp/p29cjq3FSxLeiKOfwaZpVZ/TeDfEzjV7177Ps8xxH+Qx4
         2ZjWUntT3gYW9xJ2Nu+6Ua4l6EFYAM+tfBhaCV60=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36V8TnSw016455
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Jul 2023 03:29:49 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 31
 Jul 2023 03:29:48 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 31 Jul 2023 03:29:48 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36V8Tm5R041977;
        Mon, 31 Jul 2023 03:29:48 -0500
From:   Jai Luthra <j-luthra@ti.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        <niklas.soderlund+renesas@ragnatech.se>,
        Benoit Parrot <bparrot@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, <nm@ti.com>,
        <devarsht@ti.com>, <j-luthra@ti.com>
Subject: [PATCH v8 11/16] media: cadence: csi2rx: Fix stream data configuration
Date:   Mon, 31 Jul 2023 13:59:29 +0530
Message-ID: <20230731-upstream_csi-v8-11-fb7d3661c2c9@ti.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230731-upstream_csi-v8-0-fb7d3661c2c9@ti.com>
References: <20230731-upstream_csi-v8-0-fb7d3661c2c9@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2031; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=wyZ18n/oOpfvaAzrGd/kqAY+gSdA+SWheBFupQKZTHo=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBkx2xsMI/ZvY7g5YmfZvpkpM/XlvmTsu7Ptd3Jt
 f2YSlXy/gqJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZMdsbAAKCRBD3pH5JJpx
 RWw6D/sG/kFdmASxlUukMFkSHPWFJRKW4YrrCcqvSp6l0Be/WmCopnhf2H4h6JB3czslnZnlROU
 ZuWhiBqQKJ8/P4oa6Jm5ZYff9RHk6RTsHMtIEqVS3BfoZWXYrq4TIs4IjKTKZ8imiIk8+q6RUjs
 Nf6WUNkFPv89cWreU/0KfnYeUnX95nmxhQRgTreXD6DLf5O+o8vD3z/ATHKhyfu77sHl66VIENA
 NnJOWQHTy+UElFFHG7cwmxBU7BmqRHCSvIw4o5hpe7KcE+g9DNH6q1yBdT4QQGNSH78FvqAQfq4
 H7cvONrREv4YXkFs+oY3vOUCd46VadJem5H2pO8YTrofS8/jaVBmz1TT5hdlVAReuXwmyWwVZi7
 kwvoQKSa65wVRfHG9UiyYCFnl4crNeDQIpsVJt7yIpyqdmzgSOFMz896A2pIXRP7JdfNjKkkhe1
 tcHc2HNwgpUivzzWNvhRnH/QWAM5AAmOH4Uw6/FEjfbVfusP7W8U+Z3CPJrgKoKTcGPqucKGYgM
 Sk/NNqKMhOW/yNCWyO/c2IZ2COr2mX/6PQGRcw99fcqdpt213OU4dEp4fx3+XGGPqg6X6sZcKdH
 RDuJllZg+C3xwRTrL3E7ib/CFR6n1tzrAY4j6gX+Um0O62C5OB9AepJ7n6jM/w5OD1lcf+Rkt7I
 VGeqSln9XYpT7nQ==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp; fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pratyush Yadav <p.yadav@ti.com>

Firstly, there is no VC_EN bit present in the STREAM_DATA_CFG register.
Bit 31 is part of the VL_SELECT field. Remove it completely.

Secondly, it makes little sense to enable ith virtual channel for ith
stream. Sure, there might be a use-case that demands it. But there might
also be a use case that demands all streams to use the 0th virtual
channel. Prefer this case over the former because it is less arbitrary
and also makes it very clear what the limitations of the current driver
is instead of giving a false impression that multiple virtual channels
are supported.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
v7->v8: No change

 drivers/media/platform/cadence/cdns-csi2rx.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index a17ef88dff82..cde7fd6463e1 100644
--- a/drivers/media/platform/cadence/cdns-csi2rx.c
+++ b/drivers/media/platform/cadence/cdns-csi2rx.c
@@ -49,7 +49,6 @@
 #define CSI2RX_STREAM_STATUS_RDY			BIT(31)
 
 #define CSI2RX_STREAM_DATA_CFG_REG(n)		(CSI2RX_STREAM_BASE(n) + 0x008)
-#define CSI2RX_STREAM_DATA_CFG_EN_VC_SELECT		BIT(31)
 #define CSI2RX_STREAM_DATA_CFG_VC_SELECT(n)		BIT((n) + 16)
 
 #define CSI2RX_STREAM_CFG_REG(n)		(CSI2RX_STREAM_BASE(n) + 0x00c)
@@ -275,8 +274,11 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
 		writel(CSI2RX_STREAM_CFG_FIFO_MODE_LARGE_BUF,
 		       csi2rx->base + CSI2RX_STREAM_CFG_REG(i));
 
-		writel(CSI2RX_STREAM_DATA_CFG_EN_VC_SELECT |
-		       CSI2RX_STREAM_DATA_CFG_VC_SELECT(i),
+		/*
+		 * Enable one virtual channel. When multiple virtual channels
+		 * are supported this will have to be changed.
+		 */
+		writel(CSI2RX_STREAM_DATA_CFG_VC_SELECT(0),
 		       csi2rx->base + CSI2RX_STREAM_DATA_CFG_REG(i));
 
 		writel(CSI2RX_STREAM_CTRL_START,

-- 
2.41.0
