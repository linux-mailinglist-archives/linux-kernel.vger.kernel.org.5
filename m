Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC271756344
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 14:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjGQMxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 08:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbjGQMw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 08:52:59 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6CDE47;
        Mon, 17 Jul 2023 05:52:55 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36H5To5Y020411;
        Mon, 17 Jul 2023 05:52:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=CKZ7XtME/7XZOsmvtz8KPGVZW7vXR/qqmoCpnIai4qA=;
 b=PnlQOma3tNCLhBoKqkse7iXzb2MMijY6xK6435Np1TMZue095Ka6kMLCq8htyn9xRdJE
 08kWvc74nE9uUMqvozkU8s/z3BHP2f36edyy392Ps488wn+SDkh6PypRWODIz2fNIpw+
 pI135SdTPv3a8hEgQAU9SqhJzao53d6lQErUn0mqyzBjfeh1DqXZJ8sPCJEMaT+CALbG
 F1SyxJ23SXzoPu+Mk+G2gUe3xKz9zDG0SAY9B7U1CR223PSglSR6aUSZefdxdkKI6FKl
 gzWivOrkVzUTLoiGEReQZZj6xRE30ifCpU/11rGpKXCZD0JPwpD0cvdUsMfjXo58gEv5 Dw== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3rvyhx18n0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 05:52:46 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 17 Jul
 2023 05:52:44 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 17 Jul 2023 05:52:44 -0700
Received: from localhost.localdomain (unknown [10.110.150.250])
        by maili.marvell.com (Postfix) with ESMTP id 631E83F70A4;
        Mon, 17 Jul 2023 05:52:44 -0700 (PDT)
From:   Piyush Malgujar <pmalgujar@marvell.com>
To:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <yamada.masahiro@socionext.com>, <devicetree@vger.kernel.org>
CC:     <jannadurai@marvell.com>, <cchavva@marvell.com>,
        Piyush Malgujar <pmalgujar@marvell.com>
Subject: [PATCH v4 4/6] mmc: sdhci-cadence: enable MMC_SDHCI_IO_ACCESSORS support
Date:   Mon, 17 Jul 2023 05:51:44 -0700
Message-ID: <20230717125146.16791-5-pmalgujar@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230717125146.16791-1-pmalgujar@marvell.com>
References: <20230717125146.16791-1-pmalgujar@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: yDQ-TYkcBfpsu3kVag6JqhmZXZYbXeED
X-Proofpoint-ORIG-GUID: yDQ-TYkcBfpsu3kVag6JqhmZXZYbXeED
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_10,2023-07-13_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jayanthi Annadurai <jannadurai@marvell.com>

Add support of CONFIG_MMC_SDHCI_IO_ACCESSORS to allow Marvell
SoC ops for SD6 controller to overwrite the SDHCI IO memory
accessors.

Signed-off-by: Jayanthi Annadurai <jannadurai@marvell.com>
Signed-off-by: Piyush Malgujar <pmalgujar@marvell.com>
---
 drivers/mmc/host/sdhci-cadence.c | 59 ++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index 8bcf585185053b0afaff2625d62316cec1824fa3..f1e597219c603f3921439cedb22dcb2884abe68d 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence.c
@@ -448,6 +448,59 @@ static u32 read_dqs_cmd_delay, clk_wrdqs_delay, clk_wr_delay, read_dqs_delay;
 
 static u32 sdhci_cdns_sd6_get_mode(struct sdhci_host *host, unsigned int timing);
 
+static u32 sdhci_cdns_sd6_readl(struct sdhci_host *host, int reg)
+{
+	return readl(host->ioaddr + reg);
+}
+
+static void sdhci_cdns_sd6_writel(struct sdhci_host *host, u32 val, int reg)
+{
+	writel(val, host->ioaddr + reg);
+}
+
+static u16 sdhci_cdns_sd6_readw(struct sdhci_host *host, int reg)
+{
+	u32 val, regoff;
+
+	regoff = reg & ~3;
+
+	val = readl(host->ioaddr + regoff);
+	if ((reg & 0x3) == 0)
+		return (val & 0xFFFF);
+	else
+		return ((val >> 16) & 0xFFFF);
+}
+
+static void sdhci_cdns_sd6_writew(struct sdhci_host *host, u16 val, int reg)
+{
+	writew(val, host->ioaddr + reg);
+}
+
+static u8 sdhci_cdns_sd6_readb(struct sdhci_host *host, int reg)
+{
+	u32 val, regoff;
+
+	regoff = reg & ~3;
+
+	val = readl(host->ioaddr + regoff);
+	switch (reg & 3) {
+	case 0:
+		return (val & 0xFF);
+	case 1:
+		return ((val >> 8) & 0xFF);
+	case 2:
+		return ((val >> 16) & 0xFF);
+	case 3:
+		return ((val >> 24) & 0xFF);
+	}
+	return 0;
+}
+
+static void sdhci_cdns_sd6_writeb(struct sdhci_host *host, u8 val, int reg)
+{
+	writeb(val, host->ioaddr + reg);
+}
+
 static int sdhci_cdns_sd6_phy_lock_dll(struct sdhci_cdns_sd6_phy *phy)
 {
 	u32 delay_element = phy->d.delay_element_org;
@@ -1666,6 +1719,12 @@ static const struct sdhci_ops sdhci_cdns_sd4_ops = {
 };
 
 static const struct sdhci_ops sdhci_cdns_sd6_ops = {
+	.read_l = sdhci_cdns_sd6_readl,
+	.write_l = sdhci_cdns_sd6_writel,
+	.read_w = sdhci_cdns_sd6_readw,
+	.write_w = sdhci_cdns_sd6_writew,
+	.read_b = sdhci_cdns_sd6_readb,
+	.write_b = sdhci_cdns_sd6_writeb,
 	.get_max_clock = sdhci_cdns_get_max_clock,
 	.set_clock = sdhci_cdns_sd6_set_clock,
 	.get_timeout_clock = sdhci_cdns_get_timeout_clock,
-- 
2.17.1

