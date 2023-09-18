Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3D57A4034
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 06:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239594AbjIREwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 00:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239547AbjIREvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 00:51:47 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE96A10C
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 21:51:40 -0700 (PDT)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230918045136epoutp01f72dad470401f7e9942604577a2738bb~F5REWy49v0170101701epoutp01H
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 04:51:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230918045136epoutp01f72dad470401f7e9942604577a2738bb~F5REWy49v0170101701epoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695012696;
        bh=22mi+Jh5tY/CloHNfjvU1mTUGZ/1X9L0+psaGJ0+Oeg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zsq7L6M9v+mTROdsXmtm6tHBM7w360WAiBTb1hb4DDt5L3iGbGF23v5Lb5p9dOEHc
         AS9efuhrFuSOLdeJ9VvvHq1fYQdZPFMCZ188hZQVW0uBi8ebOtBhSwC0mXqs+ag+H7
         bBjgDp8tVU265veWHp1h58rzhiOtM1jpXLuGG4DE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20230918045135epcas1p315653a6c68e5bbd2ed60377803539f71~F5RD3CDvM0980709807epcas1p3v;
        Mon, 18 Sep 2023 04:51:35 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.36.135]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Rpsny5sHLz4x9Q2; Mon, 18 Sep
        2023 04:51:34 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        66.EC.10163.657D7056; Mon, 18 Sep 2023 13:51:34 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20230918045134epcas1p41321973f5fc3aae29e8d27c6b8f35ec2~F5RCdBV-D3009130091epcas1p4H;
        Mon, 18 Sep 2023 04:51:34 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230918045134epsmtrp270feb55be0ff034b7fab82f6fcd50737~F5RCaMt092495524955epsmtrp2a;
        Mon, 18 Sep 2023 04:51:34 +0000 (GMT)
X-AuditID: b6c32a38-4dbf8700000027b3-0b-6507d7566e1b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B1.94.08788.657D7056; Mon, 18 Sep 2023 13:51:34 +0900 (KST)
Received: from mediaserver.. (unknown [10.113.111.131]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230918045133epsmtip17031ee3921d27792540f554ac85450aa~F5RCJuwSg1742617426epsmtip1i;
        Mon, 18 Sep 2023 04:51:33 +0000 (GMT)
From:   Kwanghoon Son <k.son@samsung.com>
To:     p.zabel@pengutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jszhang@kernel.org, guoren@kernel.org, wefu@redhat.com,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, inki.dae@samsung.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v3 2/3] reset: Add th1520 reset driver support
Date:   Mon, 18 Sep 2023 04:51:24 +0000
Message-Id: <20230918045125.4000083-3-k.son@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230918045125.4000083-1-k.son@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCJsWRmVeSWpSXmKPExsWy7bCmnm7YdfZUg+1zdC22/p7FbrFm7zkm
        i/lHzrFavNjbyGIx6f4EFovmY+vZLPpePGS2uLxrDpvFts8tbBZ3751gsXh5uYfZom0Wv0Xr
        3iPsFi37p7A48Hm8efmSxeNwxxd2j02rOtk87lzbw+axeUm9R/9fA4/3+66yefRtWcXocan5
        OrvH501yAVxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6
        bpk5QPcrKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgpMC/SKE3OLS/PS9fJSS6wM
        DQyMTIEKE7Izrl2azljQpVZx6qhCA+NX+S5GTg4JAROJmRvmMHcxcnEICexglJi6bTo7hPOJ
        UWL3p2NsEM43RolLV04ywrTsvNEKVbWXUeL1pO0sEM4bRokZGxrBqtgE1CWWtK0FqxIR+M8o
        8eZPKxNIglkgXuLEtXNAGzk4hAXsJF60eYKEWQRUJfbc/AjWyytgIdE/Zx0TxDZ5if0HzzKD
        2JwClhLnb+2EqhGUODnzCQvESHmJ5q2zwZ6QENjDIXH851uoZheJubOOskDYwhKvjm9hh7Cl
        JD6/28sGYWdLHP0IY5dIXJ+1iBXCNpbYv3QyE8idzAKaEut36UOEFSV2/p7LCLGXT+Ld1x5W
        kBIJAV6JjjYhCFNe4lZnOUS1qMSZpx+hhntITFraBQ2qHkaJFTPnsE9gVJiF5JtZSL6ZhbB4
        ASPzKkax1ILi3PTUYsMCE3gEJ+fnbmIEJ2ctix2Mc99+0DvEyMTBeIhRgoNZSYR3piFbqhBv
        SmJlVWpRfnxRaU5q8SFGU2BYT2SWEk3OB+aHvJJ4QxNLAxMzI2MTC0MzQyVx3mOvelOEBNIT
        S1KzU1MLUotg+pg4OKUamJSPssxxEJRZrCX63mLvr4xTD4/n9obsvtL3e/Jv5zu6WU5yliwi
        e1+u2/9FSCZzoo18UBP7y9kuQpuXLAxtOzMn1Ck2OWVK8vspey4cueawN33mmZRntdXzPe8e
        i/fT0D50M7Pnk9PavEfnHU5EqtQ7P654WSHZ3c8WJiPCw9Ex5/G6NVt4rsofePGc4cjyKTHM
        thxLPwvbzQ4/lL/KzSFPyjKkqSyy7Scjt473a1tlu56HTlsmsqfPKmu9IKJ6/OT/hfNNJq3Y
        JVzOufRZ35KJHIt0fSZpB+18Ufp3fkDx/1dfl904Pj9epOdx8Yv1JrpJfU4xuVI/AtZGms8L
        umMuvyiEUUtbzeDHax8JIyWW4oxEQy3mouJEAC0HBDpXBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHLMWRmVeSWpSXmKPExsWy7bCSnG7YdfZUg/ufOC22/p7FbrFm7zkm
        i/lHzrFavNjbyGIx6f4EFovmY+vZLPpePGS2uLxrDpvFts8tbBZ3751gsXh5uYfZom0Wv0Xr
        3iPsFi37p7A48Hm8efmSxeNwxxd2j02rOtk87lzbw+axeUm9R/9fA4/3+66yefRtWcXocan5
        OrvH501yAVxRXDYpqTmZZalF+nYJXBnXLk1nLOhSqzh1VKGB8at8FyMnh4SAicTOG63sXYxc
        HEICuxklFm9eygKREJXouNzI2MXIAWQLSxw+XAxR84pRovvIUlaQGjYBdYklbWvBmkUEepkk
        PnxcwgSSYBZIlNjy9TUzSLOwgJ3EizZPkDCLgKrEnpsfGUFsXgELif4565ggdslL7D94lhnE
        5hSwlDh/aydYjRBQTe+HV1D1ghInZz5hgRgvL9G8dTbzBEaBWUhSs5CkFjAyrWKUTC0ozk3P
        LTYsMMpLLdcrTswtLs1L10vOz93ECI4iLa0djHtWfdA7xMjEwXiIUYKDWUmEd6YhW6oQb0pi
        ZVVqUX58UWlOavEhRmkOFiVx3m+ve1OEBNITS1KzU1MLUotgskwcnFINTAJLQnvfiOUeulSq
        7r0mY96y+78r/k1n3PtaL5ThT5kbd+/Tm2/U/jdG/t3OITw1bOuytvozgo4matGLOLVY/+hs
        UFQSm/Li1uTu3HNBpqoXRVlFqiV5m08oHtu1bM/NSXo9U1c2Ced0bPl/+J/iucYdQqzL5+dM
        uLngZfHX3JTNNswqL91yeI7HhrNFMOa6+S7I1YlkiwxZc7furHLrhLAfX1Xjr7iYXdTYfX7j
        9y+pXTHXs021utvTX7q2T3Pu557a388qe+ui6Jn82uqU6WWs818/drx0qb3py+vrLI/n3UuN
        mzlHZ2e/oPO76zvWrV+7dxL7s509OUa31VZy2jWXPTzWEHaBx+pjpm7IcSWW4oxEQy3mouJE
        ALvWBDwRAwAA
X-CMS-MailID: 20230918045134epcas1p41321973f5fc3aae29e8d27c6b8f35ec2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230918045134epcas1p41321973f5fc3aae29e8d27c6b8f35ec2
References: <20230918045125.4000083-1-k.son@samsung.com>
        <CGME20230918045134epcas1p41321973f5fc3aae29e8d27c6b8f35ec2@epcas1p4.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver supports th1520 T-HEAD SoC reset platform device.

Signed-off-by: Kwanghoon Son <k.son@samsung.com>
---
 drivers/reset/Kconfig        |  10 ++++
 drivers/reset/Makefile       |   1 +
 drivers/reset/reset-th1520.c | 109 +++++++++++++++++++++++++++++++++++
 3 files changed, 120 insertions(+)
 create mode 100644 drivers/reset/reset-th1520.c

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index ccd59ddd7610..ec69e6bbba6e 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -253,6 +253,16 @@ config RESET_SUNXI
 	help
 	  This enables the reset driver for Allwinner SoCs.
 
+config RESET_TH1520
+	bool "TH1520 Reset Driver"
+	depends on (ARCH_THEAD || COMPILE_TEST) && OF
+	select MFD_SYSCON
+	default ARCH_THEAD
+	help
+	  Support for the T-HEAD 1520 RISC-V SoC reset controller.
+	  Say Y if you want to control reset signals provided by this
+	  controller.
+
 config RESET_TI_SCI
 	tristate "TI System Control Interface (TI-SCI) reset driver"
 	depends on TI_SCI_PROTOCOL || (COMPILE_TEST && TI_SCI_PROTOCOL=n)
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 8270da8a4baa..5c858e62241a 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_RESET_SIMPLE) += reset-simple.o
 obj-$(CONFIG_RESET_SOCFPGA) += reset-socfpga.o
 obj-$(CONFIG_RESET_SUNPLUS) += reset-sunplus.o
 obj-$(CONFIG_RESET_SUNXI) += reset-sunxi.o
+obj-$(CONFIG_RESET_TH1520) += reset-th1520.o
 obj-$(CONFIG_RESET_TI_SCI) += reset-ti-sci.o
 obj-$(CONFIG_RESET_TI_SYSCON) += reset-ti-syscon.o
 obj-$(CONFIG_RESET_TI_TPS380X) += reset-tps380x.o
diff --git a/drivers/reset/reset-th1520.c b/drivers/reset/reset-th1520.c
new file mode 100644
index 000000000000..5a89d201fc0c
--- /dev/null
+++ b/drivers/reset/reset-th1520.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/mfd/syscon.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/reset-controller.h>
+#include <linux/regmap.h>
+#include <dt-bindings/reset/thead,th1520-reset.h>
+
+struct th1520_rst_signal {
+	unsigned int offset, bit;
+};
+
+struct th1520_rst {
+	struct reset_controller_dev rcdev;
+	struct regmap *regmap;
+	const struct th1520_rst_signal *signals;
+};
+
+enum th1520_rst_registers {
+	RST_WDT0 = 0x0034,
+	RST_WDT1 = 0x0038,
+};
+
+static int th1520_reset_update(struct th1520_rst *rst, unsigned long id,
+			       unsigned int value)
+{
+	const struct th1520_rst_signal *signal = &rst->signals[id];
+
+	return regmap_update_bits(rst->regmap, signal->offset, signal->bit,
+				  value);
+}
+
+static const struct th1520_rst_signal th1520_rst_signals[] = {
+	[TH1520_RESET_WDT0] = { RST_WDT0, BIT(0) },
+	[TH1520_RESET_WDT1] = { RST_WDT1, BIT(0) },
+};
+
+static struct th1520_rst *to_th1520_rst(struct reset_controller_dev *rcdev)
+{
+	return container_of(rcdev, struct th1520_rst, rcdev);
+}
+
+static int th1520_reset_set(struct reset_controller_dev *rcdev,
+			    unsigned long id, bool assert)
+{
+	struct th1520_rst *rst = to_th1520_rst(rcdev);
+	const unsigned int bit = rst->signals[id].bit;
+	unsigned int value = assert ? bit : 0;
+
+	return th1520_reset_update(rst, id, value);
+}
+
+static int th1520_reset_assert(struct reset_controller_dev *rcdev,
+			       unsigned long id)
+{
+	return th1520_reset_set(rcdev, id, false);
+}
+
+static int th1520_reset_deassert(struct reset_controller_dev *rcdev,
+				 unsigned long id)
+{
+	return th1520_reset_set(rcdev, id, true);
+}
+
+static const struct reset_control_ops th1520_rst_ops = {
+	.assert = th1520_reset_assert,
+	.deassert = th1520_reset_deassert,
+};
+
+static int th1520_reset_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct th1520_rst *rst;
+	struct regmap_config config = { .name = "rst" };
+
+	rst = devm_kzalloc(dev, sizeof(*rst), GFP_KERNEL);
+	if (!rst)
+		return -ENOMEM;
+
+	rst->signals = th1520_rst_signals;
+	rst->regmap = syscon_node_to_regmap(dev->of_node);
+	if (IS_ERR(rst->regmap))
+		return PTR_ERR(rst->regmap);
+
+	regmap_attach_dev(dev, rst->regmap, &config);
+
+	rst->rcdev.owner = THIS_MODULE;
+	rst->rcdev.dev = dev;
+	rst->rcdev.of_node = dev->of_node;
+	rst->rcdev.ops = &th1520_rst_ops;
+	rst->rcdev.nr_resets = ARRAY_SIZE(th1520_rst_signals);
+
+	return devm_reset_controller_register(dev, &rst->rcdev);
+}
+
+static const struct of_device_id th1520_reset_dt_ids[] = {
+	{ .compatible = "thead,th1520-reset" },
+	{ /* sentinel */ },
+};
+
+static struct platform_driver th1520_reset_driver = {
+	.probe	= th1520_reset_probe,
+	.driver = {
+		.name		= "th1520-reset",
+		.of_match_table	= th1520_reset_dt_ids,
+	},
+};
+builtin_platform_driver(th1520_reset_driver);
-- 
2.34.1

