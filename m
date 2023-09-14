Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7E679F8C5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 05:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234383AbjINDQm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 13 Sep 2023 23:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234151AbjINDQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 23:16:19 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD271BDF;
        Wed, 13 Sep 2023 20:16:13 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 0FAC380B6;
        Thu, 14 Sep 2023 11:16:12 +0800 (CST)
Received: from EXMBX073.cuchost.com (172.16.6.83) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 14 Sep
 2023 11:16:11 +0800
Received: from xiaofei.localdomain (180.164.60.184) by EXMBX073.cuchost.com
 (172.16.6.83) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 14 Sep
 2023 11:16:11 +0800
From:   Jack Zhu <jack.zhu@starfivetech.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        <bryan.odonoghue@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-staging@lists.linux.dev>,
        <jack.zhu@starfivetech.com>, <changhuang.liang@starfivetech.com>
Subject: [PATCH v9 7/8] media: staging: media: starfive: camss: Add interrupt handling
Date:   Thu, 14 Sep 2023 11:16:06 +0800
Message-ID: <20230914031607.34877-8-jack.zhu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230914031607.34877-1-jack.zhu@starfivetech.com>
References: <20230914031607.34877-1-jack.zhu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [180.164.60.184]
X-ClientProxiedBy: EXCAS061.cuchost.com (172.16.6.21) To EXMBX073.cuchost.com
 (172.16.6.83)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parse interrupt resources and register interrupt handlers.

Signed-off-by: Jack Zhu <jack.zhu@starfivetech.com>
---
 .../staging/media/starfive/camss/stf-camss.c  | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/staging/media/starfive/camss/stf-camss.c b/drivers/staging/media/starfive/camss/stf-camss.c
index f083bc0e6e97..373467322885 100644
--- a/drivers/staging/media/starfive/camss/stf-camss.c
+++ b/drivers/staging/media/starfive/camss/stf-camss.c
@@ -35,6 +35,12 @@ static const char * const stfcamss_resets[] = {
 	"rst_isp_top_axi",
 };
 
+static const struct stf_isr_data stf_isrs[] = {
+	{"wr_irq", stf_wr_irq_handler},
+	{"isp_irq", stf_isp_irq_handler},
+	{"line_irq", stf_line_irq_handler},
+};
+
 static int stfcamss_get_mem_res(struct stfcamss *stfcamss)
 {
 	struct platform_device *pdev = to_platform_device(stfcamss->dev);
@@ -160,6 +166,21 @@ static int stfcamss_probe(struct platform_device *pdev)
 
 	stfcamss->dev = dev;
 
+	for (i = 0; i < ARRAY_SIZE(stf_isrs); ++i) {
+		int irq;
+
+		irq = platform_get_irq(pdev, i);
+		if (irq < 0)
+			return irq;
+
+		ret = devm_request_irq(stfcamss->dev, irq, stf_isrs[i].isr, 0,
+				       stf_isrs[i].name, stfcamss);
+		if (ret) {
+			dev_err(dev, "request irq failed: %d\n", ret);
+			return ret;
+		}
+	}
+
 	stfcamss->nclks = ARRAY_SIZE(stfcamss->sys_clk);
 	for (i = 0; i < stfcamss->nclks; ++i)
 		stfcamss->sys_clk[i].id = stfcamss_clocks[i];
-- 
2.34.1

