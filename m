Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3453C791091
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 06:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351694AbjIDE0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 00:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjIDE0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 00:26:12 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A6910F
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 21:26:08 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230904042606epoutp0355e448212c1ffb93f646f7a74068e43f~Bl4zYKmPr3054530545epoutp03d
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 04:26:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230904042606epoutp0355e448212c1ffb93f646f7a74068e43f~Bl4zYKmPr3054530545epoutp03d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1693801566;
        bh=mmg8oLshxsrQdYCnlidyh+NTlXcuOiwPxXyFC6ElhqU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rURroMtgX50oUCXNUesga54s9Igo7WJiGoMPI2Du4/AoOlOKVQenhJHSme6iI32Un
         eex2qYRlnc+b4hnyz3rIjUg0i5OKiDYlVwSryAWyb5YsxVjaJ7l98NZNNwghZfl9EL
         4ozmO0ecQJioKKE7bpB/rSey29ItG4AQ2BKwT9AE=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20230904042605epcas1p4d7153219063c82dcb8c966b945367045~Bl4yuYe1o0894808948epcas1p4H;
        Mon,  4 Sep 2023 04:26:05 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.36.136]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4RfFv03CB2z4x9Px; Mon,  4 Sep
        2023 04:26:04 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        07.34.09646.C5C55F46; Mon,  4 Sep 2023 13:26:04 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230904042603epcas1p2ae04f309c60dde70a0b254287f61dfb1~Bl4xYoBCf1830118301epcas1p2p;
        Mon,  4 Sep 2023 04:26:03 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230904042603epsmtrp24e110468c9bf53abe831621452a64519~Bl4xXrCP50179101791epsmtrp2I;
        Mon,  4 Sep 2023 04:26:03 +0000 (GMT)
X-AuditID: b6c32a37-39cc9a80000025ae-77-64f55c5c5f1d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        37.1A.08742.B5C55F46; Mon,  4 Sep 2023 13:26:03 +0900 (KST)
Received: from mediaserver.. (unknown [10.113.111.131]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230904042603epsmtip175f6ce79549cbc599c80236f3c6b86c5~Bl4xEnndG1856018560epsmtip1f;
        Mon,  4 Sep 2023 04:26:03 +0000 (GMT)
From:   Kwanghoon Son <k.son@samsung.com>
To:     p.zabel@pengutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jszhang@kernel.org, guoren@kernel.org, wefu@redhat.com,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, inki.dae@samsung.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [RFC PATCH 2/3] reset: Add th1520 reset driver support
Date:   Mon,  4 Sep 2023 04:25:58 +0000
Message-Id: <20230904042559.2322997-3-k.son@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230904042559.2322997-1-k.son@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMJsWRmVeSWpSXmKPExsWy7bCmrm5MzNcUgyNtYhZbf89it1iz9xyT
        xfwj51gtXuxtZLGYdH8Ci0XzsfVsFn0vHjJbXN41h81i2+cWNou7906wWLy83MNs0TaL36J1
        7xF2i5b9U1gc+DzevHzJ4nG44wu7x6ZVnWwed67tYfPYvKTeo/+vgcf7fVfZPPq2rGL0uNR8
        nd3j8ya5AK6obJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBd
        t8wcoPuVFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQWmBXrFibnFpXnpenmpJVaG
        BgZGpkCFCdkZbW/iC85qVdw7Wt7AeFG5i5GTQ0LARGLRqessXYxcHEICOxglDvavYoNwPjFK
        bLq3kwnC+cYosfnfWTaYlhfL1rOA2EICexklnqyAan/DKHG1Zw9YEZuAusSStrXsIAkRgf+M
        Em/+tDKBJJgF4iVOXDvHDGILC9hLXLrxih3EZhFQBbI3MYLYvAIWEqfPb2KH2CYvsf/gWbB6
        TgFLiQ8PD0LVCEqcnPmEBWKmvETz1tnMIMskBPZwSDyY9Ayq2UXi/bVtULawxKvjW6BsKYnP
        7/ZCvZMtcfQjjF0icX3WIlYI21hi/9LJQEdzAC3QlFi/Sx8irCix8/dcRoi9fBLvvvawgpRI
        CPBKdLQJQZjyErc6yyGqRSXOPP0INdxD4vixdcyQsOphlHjVuZNlAqPCLCTfzELyzSyExQsY
        mVcxiqUWFOempxYbFhjD4zc5P3cTIzg1a5nvYJz29oPeIUYmDsZDjBIczEoivHLan1KEeFMS
        K6tSi/Lji0pzUosPMZoCw3ois5Rocj4wO+SVxBuaWBqYmBkZm1gYmhkqifPeetabIiSQnliS
        mp2aWpBaBNPHxMEp1cD00P5f4B5HhUXKrZ83PxDrP2rwsM7V79KMY7W2UU3z1xm9XCe8MIKh
        1i47QzCET0N3Mt+qzP33Zxy5YXq6YK7R0X2ehgViryb9XaEtmH1Ec55/7mvhvpY/B47umqO1
        8uFxMz6dr/NLPH5UrrcPe/rPMuod8+UpR1ME9Ljuem3OTNq3m+MGr+hqgURnns2fiv0Z0g9O
        ddtbvSZy3us2YdONISckPvn0bdjBrR/CJbD8fcjhkwIxqXydZuaGZ9iYrqcHnfwgmWW8aXGS
        BdsMA9YNK3xeFjDuMLmdVfpypmndwcs/3AuNT7il7Zz9zUda9Ex/2+od11w+vHb32JrAtGeG
        icHappzXen3LtW7ZnP6pxFKckWioxVxUnAgA3uRjNVYEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLLMWRmVeSWpSXmKPExsWy7bCSnG50zNcUg6ML9Cy2/p7FbrFm7zkm
        i/lHzrFavNjbyGIx6f4EFovmY+vZLPpePGS2uLxrDpvFts8tbBZ3751gsXh5uYfZom0Wv0Xr
        3iPsFi37p7A48Hm8efmSxeNwxxd2j02rOtk87lzbw+axeUm9R/9fA4/3+66yefRtWcXocan5
        OrvH501yAVxRXDYpqTmZZalF+nYJXBltb+ILzmpV3Dta3sB4UbmLkZNDQsBE4sWy9SxdjFwc
        QgK7GSU2rDjGCJEQlei43AhkcwDZwhKHDxeDhIUEXjFK/GnnArHZBNQllrStZQfpFRHoZZL4
        8HEJE0iCWSBRYsvX18wgtrCAvcSlG6/YQWwWAVUgexPYfF4BC4nT5zexQ+ySl9h/8CxYPaeA
        pcSHhwcZIZZZSGz49YoFol5Q4uTMJywQ8+UlmrfOZp7AKDALSWoWktQCRqZVjJKpBcW56bnF
        hgWGeanlesWJucWleel6yfm5mxjBMaSluYNx+6oPeocYmTgYDzFKcDArifDKaX9KEeJNSays
        Si3Kjy8qzUktPsQozcGiJM4r/qI3RUggPbEkNTs1tSC1CCbLxMEp1cA0N3Fr1YklW7zDn786
        /T3JToApwZVnz7/WgNeT/MNYysy8H8/arfHqPlsQ08QlH2Tfb7+zOzV8ng3Ddft7n2stHkrM
        WZ9yV3N5/IYJbuqOXZYd83KmV8Y9utu05vbpG3vkZ/lXMFRvCN9w/pD33suGR09bND44ERR3
        +qacwNvKAwdSPTlv9Ak5HhI5fKjdi0moeuHyVEYtB3PN07/5Ew8qb/fOmRUvMVspxVVM+sSc
        1j+fjZP+7LecpPpktUNcJoPPqfYkpbkiNf+iXUyvTHCcnxOmI7+gjF/L5Gm6Qryy0Z470i26
        D7jSo78c3MtQMGf18mD1r64G1gcPRn5rlt9RWHng1TvNig1mNdbHbzxXYinOSDTUYi4qTgQA
        UyobFxADAAA=
X-CMS-MailID: 20230904042603epcas1p2ae04f309c60dde70a0b254287f61dfb1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230904042603epcas1p2ae04f309c60dde70a0b254287f61dfb1
References: <20230904042559.2322997-1-k.son@samsung.com>
        <CGME20230904042603epcas1p2ae04f309c60dde70a0b254287f61dfb1@epcas1p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver supports th1520 T-HEAD SoC reset platform device.

Signed-off-by: Kwanghoon Son <k.son@samsung.com>
---
 drivers/reset/Kconfig                    |  10 +++
 drivers/reset/Makefile                   |   1 +
 drivers/reset/reset-th1520.c             | 109 +++++++++++++++++++++++
 include/dt-bindings/reset/th1520-reset.h |   9 ++
 4 files changed, 129 insertions(+)
 create mode 100644 drivers/reset/reset-th1520.c
 create mode 100644 include/dt-bindings/reset/th1520-reset.h

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
diff --git a/include/dt-bindings/reset/th1520-reset.h b/include/dt-bindings/reset/th1520-reset.h
new file mode 100644
index 000000000000..ec10751814e5
--- /dev/null
+++ b/include/dt-bindings/reset/th1520-reset.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef DT_BINDING_RESET_TH1520_H
+#define DT_BINDING_RESET_TH1520_H
+
+#define TH1520_RESET_WDT0 0
+#define TH1520_RESET_WDT1 1
+
+#endif
-- 
2.34.1

