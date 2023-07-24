Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7FE75EB14
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 07:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjGXF64 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 24 Jul 2023 01:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjGXF6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 01:58:53 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466C5DE;
        Sun, 23 Jul 2023 22:58:51 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id DAA2D80A8;
        Mon, 24 Jul 2023 13:58:46 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 24 Jul
 2023 13:58:47 +0800
Received: from localhost.localdomain (183.27.99.135) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 24 Jul
 2023 13:58:46 +0800
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
To:     <linux-riscv@lists.infradead.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Conor Dooley <conor@kernel.org>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: [PATCH v1] reset: starfive: jh7110: Add StarFive STG/ISP/VOUT resets support
Date:   Mon, 24 Jul 2023 13:54:40 +0800
Message-ID: <20230724055440.100947-1-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.99.135]
X-ClientProxiedBy: EXCAS061.cuchost.com (172.16.6.21) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new struct members and auxiliary_device_id of resets to support
System-Top-Group, Image-Signal-Process and Video-Output on the StarFive
JH7110 SoC.

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
---

Hi Stephen,

I found that the PR sent by conor was missing this STG/ISP/VOUT
resets patch:
https://lore.kernel.org/all/20230719-trough-frisk-40b92acb485a@spud/

I resend this patch to make the CRG drivers completed.

Thanks,
Xingyu Wu

---
 .../reset/starfive/reset-starfive-jh7110.c    | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/reset/starfive/reset-starfive-jh7110.c b/drivers/reset/starfive/reset-starfive-jh7110.c
index 2d26ae95c8cc..29a43f0f2ad6 100644
--- a/drivers/reset/starfive/reset-starfive-jh7110.c
+++ b/drivers/reset/starfive/reset-starfive-jh7110.c
@@ -31,6 +31,24 @@ static const struct jh7110_reset_info jh7110_aon_info = {
 	.status_offset = 0x3C,
 };
 
+static const struct jh7110_reset_info jh7110_stg_info = {
+	.nr_resets = JH7110_STGRST_END,
+	.assert_offset = 0x74,
+	.status_offset = 0x78,
+};
+
+static const struct jh7110_reset_info jh7110_isp_info = {
+	.nr_resets = JH7110_ISPRST_END,
+	.assert_offset = 0x38,
+	.status_offset = 0x3C,
+};
+
+static const struct jh7110_reset_info jh7110_vout_info = {
+	.nr_resets = JH7110_VOUTRST_END,
+	.assert_offset = 0x48,
+	.status_offset = 0x4C,
+};
+
 static int jh7110_reset_probe(struct auxiliary_device *adev,
 			      const struct auxiliary_device_id *id)
 {
@@ -58,6 +76,18 @@ static const struct auxiliary_device_id jh7110_reset_ids[] = {
 		.name = "clk_starfive_jh7110_sys.rst-aon",
 		.driver_data = (kernel_ulong_t)&jh7110_aon_info,
 	},
+	{
+		.name = "clk_starfive_jh7110_sys.rst-stg",
+		.driver_data = (kernel_ulong_t)&jh7110_stg_info,
+	},
+	{
+		.name = "clk_starfive_jh7110_sys.rst-isp",
+		.driver_data = (kernel_ulong_t)&jh7110_isp_info,
+	},
+	{
+		.name = "clk_starfive_jh7110_sys.rst-vo",
+		.driver_data = (kernel_ulong_t)&jh7110_vout_info,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(auxiliary, jh7110_reset_ids);
-- 
2.25.1

