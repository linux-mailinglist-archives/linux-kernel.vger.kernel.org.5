Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8AA979C3F7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 05:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241726AbjILDTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 23:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242556AbjILDTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 23:19:21 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947CB4212
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 19:49:23 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230912024919epoutp02f7cf3aa40e7654e22648da0931ee6f92~EBul7pmot2389023890epoutp02k
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 02:49:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230912024919epoutp02f7cf3aa40e7654e22648da0931ee6f92~EBul7pmot2389023890epoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1694486959;
        bh=jDYZmDUeTmt2O3a/Ef2SDGzOD2Hkcty68MUJtsHU2FY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kgdyA6mbbdnNaf24wjf8rAAh9vyDRXYJfGme1gb2+AMkQl9PPWQlv0QO0TcqjStTk
         4+9adBtw0ORVaId2Fv2RkYWSmXwJawasONC3Ck/dTaXnCsAOVnwnaJtS8L/C6xc16L
         vBxYLn8UmHs+cNfSbSm2CXA/NQZCsnYUsxk7ZLQ4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230912024919epcas1p1f7ca91929217cf85eed9ae9da76f319e~EBulT1dF90079800798epcas1p1N;
        Tue, 12 Sep 2023 02:49:19 +0000 (GMT)
Received: from epsmgec1p1-new.samsung.com (unknown [182.195.36.134]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Rl7Md6QgPz4x9Q1; Tue, 12 Sep
        2023 02:49:17 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmgec1p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1C.CF.18968.DA1DFF46; Tue, 12 Sep 2023 11:49:17 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230912024917epcas1p26c59f79ab6904823417d625d6a711d36~EBuj65lQh1134811348epcas1p2p;
        Tue, 12 Sep 2023 02:49:17 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230912024917epsmtrp23542eae371122245bb0958d57aa2d4ff~EBuj6GoCx1886418864epsmtrp2g;
        Tue, 12 Sep 2023 02:49:17 +0000 (GMT)
X-AuditID: b6c32a4c-a9bff70000004a18-7e-64ffd1ad18dc
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        63.A7.08649.DA1DFF46; Tue, 12 Sep 2023 11:49:17 +0900 (KST)
Received: from mediaserver.. (unknown [10.113.111.131]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230912024917epsmtip153395a4c23ac602aa74f5c5e34d07309~EBujrGCwI0225002250epsmtip1F;
        Tue, 12 Sep 2023 02:49:17 +0000 (GMT)
From:   k.son@samsung.com
To:     p.zabel@pengutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jszhang@kernel.org, guoren@kernel.org, wefu@redhat.com,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, inki.dae@samsung.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Kwanghoon Son <k.son@samsung.com>
Subject: [PATCH 2/3] reset: Add th1520 reset driver support
Date:   Tue, 12 Sep 2023 02:49:13 +0000
Message-Id: <20230912024914.3769440-3-k.son@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912024914.3769440-1-k.son@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPJsWRmVeSWpSXmKPExsWy7bCmge7ai/9TDF41Glts/T2L3WLN3nNM
        FvOPnGO1eLG3kcVi0v0JLBbNx9azWfSuucpk0ffiIbPF5V1z2Cy2fW5hs7h77wSLxcvLPcwW
        bbP4LVr3HmG3aNk/hcWB3+PNy5csHoc7vrB7bFrVyeZx59oeNo/NS+o9+v8aeLzfd5XNo2/L
        KkaPS83X2T0+b5IL4IrKtslITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21
        VXLxCdB1y8wBekJJoSwxpxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BaoFecmFtcmpeu
        l5daYmVoYGBkClSYkJ3x+N0N1oL1ahVP33s2ME5W6GLk5JAQMJE4+2A5WxcjF4eQwB5GicZD
        R1kgnE+MEq3/FjBCON8YJZZ/X8oK07L+xF12iMReRon53xeyQjhvGCV6309iA6liExCX6Ly2
        EqxdROA/o8SbP61MIA6zQBOjxOy2GWBVwgLWEpMO7GMCsVkEVCV2z10HZvMKWEhcOLGMDWKf
        vMT+g2eZQWxOAUuJuVO6GSFqBCVOznzCAmIzA9U0b53NDLJAQuAMh8SNq1uhml0kLl+4xw5h
        C0u8Or4FypaS+PxuL1RNtsTRjzB2icT1WYugHjWW2L90MtBBHEALNCXW79KHCCtK7Pw9lxFi
        L5/Eu689rCAlEgK8Eh1tQhCmvMStznKIalGJM08/Qg33kJjRtRgapD2MEud//GGdwKgwC8k3
        s5B8Mwth8QJG5lWMUqkFxbnpqcmGBYa6eanl8GhOzs/dxAhO2Vo+Oxi/r/+rd4iRiYPxEKME
        B7OSCG/Job8pQrwpiZVVqUX58UWlOanFhxhNgeE9kVlKNDkfmDXySuINTSwNTMyMjE0sDM0M
        lcR5Yz61pwgJpCeWpGanphakFsH0MXFwSjUwpe1ym+Ve9u9PL4u13XGzldtX/jThPXjr1JUf
        ZxewXjbr+9wQfDx2h1tp/sUHwacud6r8P+nRfO7xOd/P0U4RJ+dPDQ/jtFaL8dphYvWl9u7P
        U0duJvPfFDUpnO8nbM+VYaTLw74w4rNQ1RRx5gWPygum586/47iwoCx71xHlbpVi1Y4XFSfX
        z5Jf1Da3MPN/mAv3RvGUGMXk+Pbf1eWqrwrm7iiMUmZa+VTpj8PECvsTKyd+mtG/+e3XvwG7
        nNb9+r1Iqmo3m8/jsoqtWWKm+e0SwkusZQqW2SnELNEsUX1z9XS1xosrO+UEuB/sbZPis5jL
        VtutFatx6edL44/mRuuO+HWmWz7k2Fqzf9IKJZbijERDLeai4kQAa/VPBGIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplkeLIzCtJLcpLzFFi42LZdlhJTnftxf8pBtdmS1ls/T2L3WLN3nNM
        FvOPnGO1eLG3kcVi0v0JLBbNx9azWfSuucpk0ffiIbPF5V1z2Cy2fW5hs7h77wSLxcvLPcwW
        bbP4LVr3HmG3aNk/hcWB3+PNy5csHoc7vrB7bFrVyeZx59oeNo/NS+o9+v8aeLzfd5XNo2/L
        KkaPS83X2T0+b5IL4IrisklJzcksSy3St0vgynj87gZrwXq1iqfvPRsYJyt0MXJySAiYSKw/
        cZe9i5GLQ0hgN6PE+eMbWCASohIdlxsZuxg5gGxhicOHiyFqXjFKTF71jB2khk1AXKLz2kpG
        kISIQC+TxIePS5hAHGaBNkaJEx+2MoNUCQtYS0w6sI8JxGYRUJXYPXcdmM0rYCFx4cQyNoht
        8hL7D54Fq+cUsJSYO6WbEcQWAqq5/+EzI0S9oMTJmU/ArmMGqm/eOpt5AqPALCSpWUhSCxiZ
        VjFKphYU56bnJhsWGOallusVJ+YWl+al6yXn525iBMeUlsYOxnvz/+kdYmTiYDzEKMHBrCTC
        W3Lob4oQb0piZVVqUX58UWlOavEhRmkOFiVxXsMZs1OEBNITS1KzU1MLUotgskwcnFINTP3t
        rfmxR1bk9y7XVbnwfa/Ph2c/313O/BKpfa+t/sYu5y3bGS4/1/jbedwr4qr7d51WycnSU8oP
        /bjAo6C/eGHZltUnT57sKJuXqPjdZMGTYx+Ytun/5Wu8KTpHnnlTmM77W9K7G+yevFdTfbb7
        dcn6uo3Mp3LvzT3IIR+Vc8BY3Wmy3eQN91xf/rSffPXcc5+p0xVMCo35+cTWrIpY+Pru/Zcv
        2d9KKJyTWb3W4PH3eIUJIqLftaXMu7q47ygK5r3J8C3b+9Py/KVJVbdOFbJUVu198O25eq6S
        0Iad8S1TE59fvvF+JZMzr5SQN7+at8bdbr59LiwhNf/XNYV+nDDn366+84+WPpxYKihlJfNd
        iaU4I9FQi7moOBEAAIRXDxgDAAA=
X-CMS-MailID: 20230912024917epcas1p26c59f79ab6904823417d625d6a711d36
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230912024917epcas1p26c59f79ab6904823417d625d6a711d36
References: <20230912024914.3769440-1-k.son@samsung.com>
        <CGME20230912024917epcas1p26c59f79ab6904823417d625d6a711d36@epcas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kwanghoon Son <k.son@samsung.com>

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
index 000000000000..4c781377ac23
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
+#include <dt-bindings/reset/th1520-reset.h>
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

