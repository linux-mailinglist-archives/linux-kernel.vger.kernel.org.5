Return-Path: <linux-kernel+bounces-20803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E77DC828568
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 027121C23A2B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 11:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C25374D1;
	Tue,  9 Jan 2024 11:47:14 +0000 (UTC)
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CFD37149;
	Tue,  9 Jan 2024 11:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelsoft.com
Received: from localhost.localdomain (unknown [106.37.191.2])
	by mail (Coremail) with SMTP id AQAAfwAXEEwSMp1lYIpFAA--.14466S2;
	Tue, 09 Jan 2024 19:46:27 +0800 (CST)
From: tianyu2 <tianyu2@kernelsoft.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: imx6: use regmap to read ocotp register
Date: Tue,  9 Jan 2024 19:45:21 +0800
Message-Id: <20240109114521.518195-1-tianyu2@kernelsoft.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwAXEEwSMp1lYIpFAA--.14466S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXr13WF4kKFW8GFWxGw1DAwb_yoW5Xw4Dpa
	y7uFWayrW5XFnrtw1vyF4kG3W3trn2yayUJa10kwnaqwnxtFyrWas0vF9YyF95ZF95GF15
	XF1ktrWxCw4UXr7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UUUUUUUUU==
X-CM-SenderInfo: xwld05zxs6yvxuqhz2xriwhudrp/

Reading the ocotp register directly is unsafe and will cause the system
to hang if its clock is not turned on in CCM. The regmap interface has
clk enabled, which can solve this problem.

Signed-off-by: tianyu2 <tianyu2@kernelsoft.com>
---
 drivers/cpufreq/imx6q-cpufreq.c | 45 +++++++++++----------------------
 1 file changed, 15 insertions(+), 30 deletions(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index 494d044b9e72..f18b9ee5e484 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -14,6 +14,8 @@
 #include <linux/pm_opp.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
 
 #define PU_SOC_VOLTAGE_NORMAL	1250000
 #define PU_SOC_VOLTAGE_HIGH	1275000
@@ -225,8 +227,6 @@ static void imx6x_disable_freq_in_opp(struct device *dev, unsigned long freq)
 
 static int imx6q_opp_check_speed_grading(struct device *dev)
 {
-	struct device_node *np;
-	void __iomem *base;
 	u32 val;
 	int ret;
 
@@ -235,16 +235,11 @@ static int imx6q_opp_check_speed_grading(struct device *dev)
 		if (ret)
 			return ret;
 	} else {
-		np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-ocotp");
-		if (!np)
-			return -ENOENT;
+		struct regmap *ocotp;
 
-		base = of_iomap(np, 0);
-		of_node_put(np);
-		if (!base) {
-			dev_err(dev, "failed to map ocotp\n");
-			return -EFAULT;
-		}
+		ocotp = syscon_regmap_lookup_by_compatible("fsl,imx6q-ocotp");
+		if (IS_ERR(ocotp))
+			return -ENOENT;
 
 		/*
 		 * SPEED_GRADING[1:0] defines the max speed of ARM:
@@ -254,8 +249,7 @@ static int imx6q_opp_check_speed_grading(struct device *dev)
 		 * 2b'00: 792000000Hz;
 		 * We need to set the max speed of ARM according to fuse map.
 		 */
-		val = readl_relaxed(base + OCOTP_CFG3);
-		iounmap(base);
+		regmap_read(ocotp, OCOTP_CFG3, &val);
 	}
 
 	val >>= OCOTP_CFG3_SPEED_SHIFT;
@@ -290,25 +284,16 @@ static int imx6ul_opp_check_speed_grading(struct device *dev)
 		if (ret)
 			return ret;
 	} else {
-		struct device_node *np;
-		void __iomem *base;
-
-		np = of_find_compatible_node(NULL, NULL, "fsl,imx6ul-ocotp");
-		if (!np)
-			np = of_find_compatible_node(NULL, NULL,
-						     "fsl,imx6ull-ocotp");
-		if (!np)
-			return -ENOENT;
+		struct regmap *ocotp;
 
-		base = of_iomap(np, 0);
-		of_node_put(np);
-		if (!base) {
-			dev_err(dev, "failed to map ocotp\n");
-			return -EFAULT;
-		}
+		ocotp = syscon_regmap_lookup_by_compatible("fsl,imx6ul-ocotp");
+		if (IS_ERR(ocotp))
+			ocotp = syscon_regmap_lookup_by_compatible("fsl,imx6ull-ocotp");
+
+		if (IS_ERR(ocotp))
+			return -ENOENT;
 
-		val = readl_relaxed(base + OCOTP_CFG3);
-		iounmap(base);
+		regmap_read(ocotp, OCOTP_CFG3, &val);
 	}
 
 	/*
-- 
2.25.1


