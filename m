Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC658133EE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573668AbjLNPF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573645AbjLNPFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:05:24 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261AF11B;
        Thu, 14 Dec 2023 07:05:29 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BE9LPtu002192;
        Thu, 14 Dec 2023 07:04:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        pfpt0220; bh=0k5JxIroS0rjZhxYB09WliNOhejrEn49LGWcWaMMDF4=; b=bz7
        DLXRqTTtqmAEkb2/+DBVhRz3c2cvz0tm4MKgdsj05Z8ptaFSx+aAGxgECXM5yqCk
        NhljViKNcmoO/XMh/igyGK4oENPGgeSJdVFzGwqsR9jA3BEoRzCGqOviKkN6Ip+i
        bo7zQj1uo8RI5GGpVF6htWAZUrZ1jOSvlf6/2vNv0RvfqD0TggzN5G57eeFE9nzz
        xORpczZq9OTGMoPW7+ht4FuapZPHryxyzs1HOpEqt3BjKXkkX6evhRrZeWqNahkY
        JEmzTS8/mWaDsg25xsiYXplmMfke1aj+GxPWeRiehTOwRZdeYtGa44zZ9Fzdd/8q
        18+hR8PVhQa9p6/L7Rg==
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3uyy0m93u9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 07:04:36 -0800 (PST)
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 14 Dec
 2023 07:04:35 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 14 Dec 2023 07:04:35 -0800
Received: from dc3lp-swdev041.marvell.com (dc3lp-swdev041.marvell.com [10.6.60.191])
        by maili.marvell.com (Postfix) with ESMTP id 82B433F7074;
        Thu, 14 Dec 2023 07:04:30 -0800 (PST)
From:   Elad Nachman <enachman@marvell.com>
To:     <wim@linux-watchdog.org>, <linux@roeck-us.net>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <gregory.clement@bootlin.com>,
        <chris.packham@alliedtelesis.co.nz>, <andrew@lunn.ch>,
        <fu.wei@linaro.org>, <Suravee.Suthikulpanit@amd.com>,
        <al.stone@linaro.org>, <timur@codeaurora.org>,
        <linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <enachman@marvell.com>, <cyuval@marvell.com>
Subject: [PATCH 3/3] watchdog: sbsa_gwdt: add support for Marvell ac5
Date:   Thu, 14 Dec 2023 17:04:14 +0200
Message-ID: <20231214150414.1849058-4-enachman@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231214150414.1849058-1-enachman@marvell.com>
References: <20231214150414.1849058-1-enachman@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: xhSphp6M_DwYrAhq7xFM_hy2fbhCyZUi
X-Proofpoint-ORIG-GUID: xhSphp6M_DwYrAhq7xFM_hy2fbhCyZUi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Elad Nachman <enachman@marvell.com>

Add support for Marvell ac5/x variant of the ARM
sbsa global watchdog. This watchdog deviates from
the standard driver by the following items:

1. Registers reside in secure register section.
   hence access is only possible via SMC calls to ATF.

2. There are couple more registers which reside in
   other register areas, which needs to be configured
   in order for the watchdog to properly generate
   reset through the SOC.

The new Marvell compatibility string differentiates between
the original sbsa mode of operation and the Marvell mode of
operation.

Signed-off-by: Elad Nachman <enachman@marvell.com>
---
 drivers/watchdog/sbsa_gwdt.c | 247 ++++++++++++++++++++++++++++++++---
 1 file changed, 226 insertions(+), 21 deletions(-)

diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
index 5f23913ce3b4..0bc6f53f0968 100644
--- a/drivers/watchdog/sbsa_gwdt.c
+++ b/drivers/watchdog/sbsa_gwdt.c
@@ -46,10 +46,13 @@
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/uaccess.h>
 #include <linux/watchdog.h>
 #include <asm/arch_timer.h>
+#include <linux/arm-smccc.h>
 
 #define DRV_NAME		"sbsa-gwdt"
 #define WATCHDOG_NAME		"SBSA Generic Watchdog"
@@ -75,6 +78,68 @@
 #define SBSA_GWDT_VERSION_MASK  0xF
 #define SBSA_GWDT_VERSION_SHIFT 16
 
+/* Marvell AC5/X SMCs, taken from arm trusted firmware */
+#define SMC_FID_READ_REG	0x80007FFE
+#define SMC_FID_WRITE_REG	0x80007FFD
+
+/* Marvell registers offsets: */
+#define SBSA_GWDT_MARVELL_CPU_WD_RST_EN_REG	0x30
+#define SBSA_GWDT_MARVELL_MNG_ID_REG		0x4C
+#define SBSA_GWDT_MARVELL_RST_CTRL_REG		0x0C
+
+#define SBSA_GWDT_MARVELL_ID_MASK	GENMASK(19, 12)
+#define SBSA_GWDT_MARVELL_AC5_ID	0xB4000
+#define SBSA_GWDT_MARVELL_AC5X_ID	0x98000
+#define SBSA_GWDT_MARVELL_IML_ID	0xA0000
+#define SBSA_GWDT_MARVELL_IMM_ID	0xA2000
+
+#define SBSA_GWDT_MARVELL_AC5_RST_UNIT_WD_BIT		BIT(6)
+/* The following applies to AC5X, IronMan L and M: */
+#define SBSA_GWDT_MARVELL_IRONMAN_RST_UNIT_WD_BIT	BIT(7)
+
+/*
+ * Action to perform after watchdog gets WS1 (watchdog signal 1) interrupt
+ * PWD = Private Watchdog, GWD - Global Watchdog, mpp - multi purpose pin
+ *
+ * 0 = Enable  1 = Disable (Default)
+ *
+ * BIT  0: CPU 0 reset by PWD 0
+ * BIT  1: CPU 1 reset by PWD 1
+ * BIT  2: CPU 0 reset by GWD
+ * BIT  3: CPU 1 reset by GWD
+ * BIT  4: PWD 0 sys reset out
+ * BIT  5: PWD 1 sys reset out
+ * BIT  6: GWD sys reset out
+ * BIT  7: Reserved
+ * BIT  8: PWD 0 mpp reset out
+ * BIT  9: PWD 1 mpp reset out
+ * BIT 10: GWD mpp reset out
+ *
+ */
+#define SBSA_GWDT_MARVELL_RST_CPU0_BY_PWD0	BIT(0)
+#define SBSA_GWDT_MARVELL_RST_CPU1_BY_PWD1	BIT(1)
+#define SBSA_GWDT_MARVELL_RST_CPU0_BY_GWD	BIT(2)
+#define SBSA_GWDT_MARVELL_RST_CPU1_BY_GWD	BIT(3)
+#define SBSA_GWDT_MARVELL_RST_SYSRST_BY_PWD0	BIT(4)
+#define SBSA_GWDT_MARVELL_RST_SYSRST_BY_PWD1	BIT(5)
+#define SBSA_GWDT_MARVELL_RST_SYSRST_BY_GWD	BIT(6)
+#define SBSA_GWDT_MARVELL_RST_RESERVED		BIT(7)
+#define SBSA_GWDT_MARVELL_RST_MPP_BY_PWD0	BIT(8)
+#define SBSA_GWDT_MARVELL_RST_MPP_BY_PWD1	BIT(9)
+#define SBSA_GWDT_MARVELL_RST_MPP_BY_GWD	BIT(10)
+
+/**
+ * struct sbsa_gwdt_regs_ops - ops for register read/write, depending on SOC
+ * @reg_read:			register read ops function
+ * @read_write:			register write ops function
+ */
+struct sbsa_gwdt_regs_ops {
+	u32 (*reg_read32)(void __iomem *ptr);
+	__u64 (*reg_read64)(void __iomem *ptr);
+	void (*reg_write32)(u32 val, void __iomem *ptr);
+	void (*reg_write64)(__u64 val, void __iomem *ptr);
+};
+
 /**
  * struct sbsa_gwdt - Internal representation of the SBSA GWDT
  * @wdd:		kernel watchdog_device structure
@@ -89,6 +154,7 @@ struct sbsa_gwdt {
 	int			version;
 	void __iomem		*refresh_base;
 	void __iomem		*control_base;
+	const struct sbsa_gwdt_regs_ops *soc_reg_ops;
 };
 
 #define DEFAULT_TIMEOUT		10 /* seconds */
@@ -116,6 +182,91 @@ MODULE_PARM_DESC(nowayout,
 		 "Watchdog cannot be stopped once started (default="
 		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
 
+/*
+ * By default, have the Global watchdog cause System Reset:
+ */
+static unsigned int reset = 0xFFFFFFFF ^ SBSA_GWDT_MARVELL_RST_SYSRST_BY_GWD;
+module_param(reset, uint, 0);
+MODULE_PARM_DESC(reset, "Action to perform after watchdog gets WS1 interrupt");
+
+/*
+ * Marvell AC5/X use SMC, while others use direct register access
+ */
+static u32 sbsa_gwdt_smc_readl(void __iomem *addr)
+{
+	struct arm_smccc_res smc_res;
+
+	arm_smccc_smc(SMC_FID_READ_REG, (unsigned long)addr,
+		      0, 0, 0, 0, 0, 0, &smc_res);
+	return (u32)smc_res.a0;
+}
+
+static void sbsa_gwdt_smc_writel(u32 val, void __iomem *addr)
+{
+	struct arm_smccc_res smc_res;
+
+	arm_smccc_smc(SMC_FID_WRITE_REG, (unsigned long)addr,
+		      (unsigned long)val, 0, 0, 0, 0, 0, &smc_res);
+}
+
+static inline u64 sbsa_gwdt_lo_hi_smc_readq(void __iomem *addr)
+{
+	u32 low, high;
+
+	low = sbsa_gwdt_smc_readl(addr);
+	high = sbsa_gwdt_smc_readl(addr + 4);
+	/* read twice, as a workaround to HW limitation */
+	low = sbsa_gwdt_smc_readl(addr);
+
+	return low + ((u64)high << 32);
+}
+
+static inline void sbsa_gwdt_lo_hi_smc_writeq(__u64 val, void __iomem *addr)
+{
+	u32 low, high;
+
+	low = val & 0xffffffff;
+	high = val >> 32;
+	sbsa_gwdt_smc_writel(low, addr);
+	sbsa_gwdt_smc_writel(high, addr + 4);
+	/* write twice, as a workaround to HW limitation */
+	sbsa_gwdt_smc_writel(low, addr);
+}
+
+static u32 sbsa_gwdt_direct_reg_readl(void __iomem *addr)
+{
+	return readl(addr);
+}
+
+static void sbsa_gwdt_direct_reg_writel(u32 val, void __iomem *addr)
+{
+	writel(val, addr);
+}
+
+static inline u64 sbsa_gwdt_lo_hi_direct_readq(void __iomem *addr)
+{
+	return lo_hi_readq(addr);
+}
+
+static inline void sbsa_gwdt_lo_hi_direct_writeq(__u64 val, void __iomem *addr)
+{
+	lo_hi_writeq(val, addr);
+}
+
+static const struct sbsa_gwdt_regs_ops smc_reg_ops = {
+	.reg_read32 = sbsa_gwdt_smc_readl,
+	.reg_read64 = sbsa_gwdt_lo_hi_smc_readq,
+	.reg_write32 = sbsa_gwdt_smc_writel,
+	.reg_write64 = sbsa_gwdt_lo_hi_smc_writeq
+};
+
+static const struct sbsa_gwdt_regs_ops direct_reg_ops = {
+	.reg_read32 = sbsa_gwdt_direct_reg_readl,
+	.reg_read64 = sbsa_gwdt_lo_hi_direct_readq,
+	.reg_write32 = sbsa_gwdt_direct_reg_writel,
+	.reg_write64 = sbsa_gwdt_lo_hi_smc_writeq
+};
+
 /*
  * Arm Base System Architecture 1.0 introduces watchdog v1 which
  * increases the length watchdog offset register to 48 bits.
@@ -127,17 +278,17 @@ MODULE_PARM_DESC(nowayout,
 static u64 sbsa_gwdt_reg_read(struct sbsa_gwdt *gwdt)
 {
 	if (gwdt->version == 0)
-		return readl(gwdt->control_base + SBSA_GWDT_WOR);
+		return gwdt->soc_reg_ops->reg_read32(gwdt->control_base + SBSA_GWDT_WOR);
 	else
-		return lo_hi_readq(gwdt->control_base + SBSA_GWDT_WOR);
+		return gwdt->soc_reg_ops->reg_read64(gwdt->control_base + SBSA_GWDT_WOR);
 }
 
 static void sbsa_gwdt_reg_write(u64 val, struct sbsa_gwdt *gwdt)
 {
 	if (gwdt->version == 0)
-		writel((u32)val, gwdt->control_base + SBSA_GWDT_WOR);
+		gwdt->soc_reg_ops->reg_write32((u32)val, gwdt->control_base + SBSA_GWDT_WOR);
 	else
-		lo_hi_writeq(val, gwdt->control_base + SBSA_GWDT_WOR);
+		gwdt->soc_reg_ops->reg_write64(val, gwdt->control_base + SBSA_GWDT_WOR);
 }
 
 /*
@@ -175,10 +326,11 @@ static unsigned int sbsa_gwdt_get_timeleft(struct watchdog_device *wdd)
 	 * timeleft = WOR + (WCV - system counter)
 	 */
 	if (!action &&
-	    !(readl(gwdt->control_base + SBSA_GWDT_WCS) & SBSA_GWDT_WCS_WS0))
+	    !(gwdt->soc_reg_ops->reg_read32(gwdt->control_base + SBSA_GWDT_WCS)
+					    & SBSA_GWDT_WCS_WS0))
 		timeleft += sbsa_gwdt_reg_read(gwdt);
 
-	timeleft += lo_hi_readq(gwdt->control_base + SBSA_GWDT_WCV) -
+	timeleft += gwdt->soc_reg_ops->reg_read64(gwdt->control_base + SBSA_GWDT_WCV) -
 		    arch_timer_read_counter();
 
 	do_div(timeleft, gwdt->clk);
@@ -194,7 +346,7 @@ static int sbsa_gwdt_keepalive(struct watchdog_device *wdd)
 	 * Writing WRR for an explicit watchdog refresh.
 	 * You can write anyting (like 0).
 	 */
-	writel(0, gwdt->refresh_base + SBSA_GWDT_WRR);
+	gwdt->soc_reg_ops->reg_write32(0, gwdt->refresh_base + SBSA_GWDT_WRR);
 
 	return 0;
 }
@@ -204,7 +356,7 @@ static void sbsa_gwdt_get_version(struct watchdog_device *wdd)
 	struct sbsa_gwdt *gwdt = watchdog_get_drvdata(wdd);
 	int ver;
 
-	ver = readl(gwdt->control_base + SBSA_GWDT_W_IIDR);
+	ver = gwdt->soc_reg_ops->reg_read32(gwdt->control_base + SBSA_GWDT_W_IIDR);
 	ver = (ver >> SBSA_GWDT_VERSION_SHIFT) & SBSA_GWDT_VERSION_MASK;
 
 	gwdt->version = ver;
@@ -215,7 +367,7 @@ static int sbsa_gwdt_start(struct watchdog_device *wdd)
 	struct sbsa_gwdt *gwdt = watchdog_get_drvdata(wdd);
 
 	/* writing WCS will cause an explicit watchdog refresh */
-	writel(SBSA_GWDT_WCS_EN, gwdt->control_base + SBSA_GWDT_WCS);
+	gwdt->soc_reg_ops->reg_write32(SBSA_GWDT_WCS_EN, gwdt->control_base + SBSA_GWDT_WCS);
 
 	return 0;
 }
@@ -225,7 +377,7 @@ static int sbsa_gwdt_stop(struct watchdog_device *wdd)
 	struct sbsa_gwdt *gwdt = watchdog_get_drvdata(wdd);
 
 	/* Simply write 0 to WCS to clean WCS_EN bit */
-	writel(0, gwdt->control_base + SBSA_GWDT_WCS);
+	gwdt->soc_reg_ops->reg_write32(0, gwdt->control_base + SBSA_GWDT_WCS);
 
 	return 0;
 }
@@ -257,24 +409,55 @@ static const struct watchdog_ops sbsa_gwdt_ops = {
 static int sbsa_gwdt_probe(struct platform_device *pdev)
 {
 	void __iomem *rf_base, *cf_base;
+	void __iomem *cpu_ctrl_base = NULL, *mng_base = NULL,
+		     *rst_ctrl_base = NULL;
 	struct device *dev = &pdev->dev;
+	struct device_node *np = pdev->dev.of_node;
 	struct watchdog_device *wdd;
 	struct sbsa_gwdt *gwdt;
+	struct resource *res;
 	int ret, irq;
-	u32 status;
+	bool marvell = false;
+	u32 status, id, val;
 
 	gwdt = devm_kzalloc(dev, sizeof(*gwdt), GFP_KERNEL);
 	if (!gwdt)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, gwdt);
 
-	cf_base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(cf_base))
-		return PTR_ERR(cf_base);
-
-	rf_base = devm_platform_ioremap_resource(pdev, 1);
-	if (IS_ERR(rf_base))
-		return PTR_ERR(rf_base);
+	if (of_device_is_compatible(np, "marvell,ac5-wd")) {
+		marvell = true;
+		gwdt->soc_reg_ops = &smc_reg_ops;
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		if (IS_ERR(res))
+			return PTR_ERR(res);
+		cf_base = res->start;
+
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+		if (IS_ERR(res))
+			return PTR_ERR(res);
+		rf_base = res->start;
+
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
+		if (IS_ERR(res))
+			return PTR_ERR(res);
+		cpu_ctrl_base = res->start;
+		mng_base = devm_platform_ioremap_resource(pdev, 3);
+		if (IS_ERR(mng_base))
+			return PTR_ERR(mng_base);
+		rst_ctrl_base = devm_platform_ioremap_resource(pdev, 4);
+		if (IS_ERR(rst_ctrl_base))
+			return PTR_ERR(rst_ctrl_base);
+	} else {
+		gwdt->soc_reg_ops = &direct_reg_ops;
+		cf_base = devm_platform_ioremap_resource(pdev, 0);
+		if (IS_ERR(cf_base))
+			return PTR_ERR(cf_base);
+
+		rf_base = devm_platform_ioremap_resource(pdev, 1);
+		if (IS_ERR(rf_base))
+			return PTR_ERR(rf_base);
+	}
 
 	/*
 	 * Get the frequency of system counter from the cp15 interface of ARM
@@ -299,7 +482,7 @@ static int sbsa_gwdt_probe(struct platform_device *pdev)
 	else
 		wdd->max_hw_heartbeat_ms = GENMASK_ULL(47, 0) / gwdt->clk * 1000;
 
-	status = readl(cf_base + SBSA_GWDT_WCS);
+	status = gwdt->soc_reg_ops->reg_read32(cf_base + SBSA_GWDT_WCS);
 	if (status & SBSA_GWDT_WCS_WS1) {
 		dev_warn(dev, "System reset by WDT.\n");
 		wdd->bootstatus |= WDIOF_CARDRESET;
@@ -317,7 +500,7 @@ static int sbsa_gwdt_probe(struct platform_device *pdev)
 			 * In case there is a pending ws0 interrupt, just ping
 			 * the watchdog before registering the interrupt routine
 			 */
-			writel(0, rf_base + SBSA_GWDT_WRR);
+			gwdt->soc_reg_ops->reg_write32(0, rf_base + SBSA_GWDT_WRR);
 			if (devm_request_irq(dev, irq, sbsa_gwdt_interrupt, 0,
 					     pdev->name, gwdt)) {
 				action = 0;
@@ -347,7 +530,28 @@ static int sbsa_gwdt_probe(struct platform_device *pdev)
 	ret = devm_watchdog_register_device(dev, wdd);
 	if (ret)
 		return ret;
-
+	/*
+	 * Marvell AC5/X/IM: need to configure the watchdog
+	 * HW to trigger reset on WS1 (Watchdog Signal 1):
+	 *
+	 * 1. Configure the watchdog signal enable (routing)
+	 *    according to configuration
+	 * 2. Unmask the wd_rst input signal to the reset unit
+	 */
+	if (marvell) {
+		gwdt->soc_reg_ops->reg_write32(reset, cpu_ctrl_base +
+					       SBSA_GWDT_MARVELL_CPU_WD_RST_EN_REG);
+		id = readl(mng_base + SBSA_GWDT_MARVELL_MNG_ID_REG) &
+			   SBSA_GWDT_MARVELL_ID_MASK;
+
+		if (id == SBSA_GWDT_MARVELL_AC5_ID)
+			val = SBSA_GWDT_MARVELL_AC5_RST_UNIT_WD_BIT;
+		else
+			val = SBSA_GWDT_MARVELL_IRONMAN_RST_UNIT_WD_BIT;
+
+		writel(readl(rst_ctrl_base + SBSA_GWDT_MARVELL_RST_CTRL_REG) & ~val,
+		       rst_ctrl_base + SBSA_GWDT_MARVELL_RST_CTRL_REG);
+	}
 	dev_info(dev, "Initialized with %ds timeout @ %u Hz, action=%d.%s\n",
 		 wdd->timeout, gwdt->clk, action,
 		 status & SBSA_GWDT_WCS_EN ? " [enabled]" : "");
@@ -383,6 +587,7 @@ static const struct dev_pm_ops sbsa_gwdt_pm_ops = {
 
 static const struct of_device_id sbsa_gwdt_of_match[] = {
 	{ .compatible = "arm,sbsa-gwdt", },
+	{ .compatible = "marvell,ac5-wd", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, sbsa_gwdt_of_match);
-- 
2.25.1

