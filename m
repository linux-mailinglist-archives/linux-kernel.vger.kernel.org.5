Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185D9760260
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 00:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbjGXWcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 18:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbjGXWcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 18:32:01 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFDD19A0;
        Mon, 24 Jul 2023 15:31:41 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36OLnIoq014121;
        Mon, 24 Jul 2023 22:31:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=7zCDwDuNPEk6XuxGoTgy162uXdxAuBzpKTYh0NZ7KkE=;
 b=Wj5J1Nzxf62puMxfMeKOecG44yRQ1iq9552b1upl7TSY3rw1LXuq8MHmecYkMQZPTbfQ
 pTcdrfTsShMVqPOl21aX+/Z9/zjcOtPGVf92RnbjxXOOPuH3QhMm+aB54dut8lXbfn1s
 N5lLOELHWkkitrepblp5J2kxCm4Xz9ZieecqfhHwmTP4sPtgW3MmeqvuWIT3KLy+EIB0
 QfLjxef2fB8lBWSIDo/cR2x0PRSHJ26mv4aWZbLKrD3gA2tolXREX4ocHwfbmkheWODG
 HfMiMI8RbvveiB8MsiFdxcb8mK6G4OiJYabAvTh/CoDP7UdXfbXpQ4Sa1M7wLtrp/D4p iA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s1pfh9nqb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 22:31:31 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36OMVVYL000969
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 22:31:31 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 24 Jul 2023 15:31:30 -0700
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
CC:     Elliot Berman <quic_eberman@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <kernel@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        "Prasad Sodagudi" <quic_psodagud@quicinc.com>
Subject: [RFC PATCH 4/4] power: reset: Implement a PSCI SYSTEM_RESET2 reboot-mode driver
Date:   Mon, 24 Jul 2023 15:30:54 -0700
Message-ID: <20230724223057.1208122-5-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230724223057.1208122-1-quic_eberman@quicinc.com>
References: <20230724223057.1208122-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: OamcRKc4R8jr9pYGFvttDRzCQiyKt5mV
X-Proofpoint-GUID: OamcRKc4R8jr9pYGFvttDRzCQiyKt5mV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_18,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 impostorscore=0
 mlxscore=0 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307240198
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PSCI implements a restart notifier for architectural defined resets.
The SYSTEM_RESET2 allows vendor firmware to define additional reset
types which could be mapped to the reboot reason.

Implement a driver to wire the reboot-mode framework to make vendor
SYSTEM_RESET2 calls on reboot.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 MAINTAINERS                             |  1 +
 drivers/firmware/psci/psci.c            |  9 +++++
 drivers/power/reset/Kconfig             |  9 +++++
 drivers/power/reset/Makefile            |  1 +
 drivers/power/reset/psci-vendor-reset.c | 49 +++++++++++++++++++++++++
 include/linux/psci.h                    |  2 +
 6 files changed, 71 insertions(+)
 create mode 100644 drivers/power/reset/psci-vendor-reset.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 2da4c5f1917b..214b14c1da63 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16984,6 +16984,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/power/reset/arm,psci-vendor-reset.yaml
 F:	drivers/firmware/psci/
+F:	drivers/power/reset/psci-vendor-reset.c
 F:	include/linux/psci.h
 F:	include/uapi/linux/psci.h
 
diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index d9629ff87861..6db73f9d2304 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -328,6 +328,15 @@ static struct notifier_block psci_sys_reset_nb = {
 	.priority = 129,
 };
 
+void psci_vendor_sys_reset2(u32 reset_type, u32 cookie)
+{
+	if (psci_system_reset2_supported)
+		invoke_psci_fn(PSCI_FN_NATIVE(1_1, SYSTEM_RESET2),
+			reset_type | BIT_ULL(31),
+			cookie, 0);
+}
+EXPORT_SYMBOL_GPL(psci_vendor_sys_reset2);
+
 static void psci_sys_poweroff(void)
 {
 	invoke_psci_fn(PSCI_0_2_FN_SYSTEM_OFF, 0, 0, 0);
diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index fff07b2bd77b..1474b9d51089 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -311,4 +311,13 @@ config POWER_MLXBF
 	help
 	  This driver supports reset or low power mode handling for Mellanox BlueField.
 
+config POWER_RESET_PSCI_VENDOR_RESET
+	tristate "PSCI Vendor SYSTEM_RESET2 driver"
+	depends on ARM64 || ARM || COMPILE_TEST
+	select ARM_PSCI_FW
+	select REBOOT_MODE
+	help
+	  Say y/m here to enable driver to use Vendor SYSTEM_RESET2 types on
+	  chips which have firmware implementing custom SYSTEM_RESET2 types.
+
 endif
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index d763e6735ee3..d09243966b74 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -37,3 +37,4 @@ obj-$(CONFIG_SYSCON_REBOOT_MODE) += syscon-reboot-mode.o
 obj-$(CONFIG_POWER_RESET_SC27XX) += sc27xx-poweroff.o
 obj-$(CONFIG_NVMEM_REBOOT_MODE) += nvmem-reboot-mode.o
 obj-$(CONFIG_POWER_MLXBF) += pwr-mlxbf.o
+obj-$(CONFIG_POWER_RESET_PSCI_VENDOR_RESET) += psci-vendor-reset.o
diff --git a/drivers/power/reset/psci-vendor-reset.c b/drivers/power/reset/psci-vendor-reset.c
new file mode 100644
index 000000000000..95d027225185
--- /dev/null
+++ b/drivers/power/reset/psci-vendor-reset.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/**
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/reboot-mode.h>
+#include <linux/psci.h>
+
+static int psci_vendor_system_reset2(struct reboot_mode_driver *reboot, unsigned int magic)
+{
+	psci_vendor_sys_reset2(magic, 0);
+
+	return NOTIFY_DONE;
+}
+
+static int psci_vendor_reset_probe(struct platform_device *pdev)
+{
+	struct reboot_mode_driver *reboot;
+
+	reboot = devm_kzalloc(&pdev->dev, sizeof(*reboot), GFP_KERNEL);
+	if (!reboot)
+		return -ENOMEM;
+
+	reboot->write = psci_vendor_system_reset2;
+
+	return devm_reboot_mode_register(&pdev->dev, reboot);
+}
+
+static const struct of_device_id psci_vendor_reset_id_table[] = {
+	{ .compatible = "arm,psci-vendor-reset" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, psci_vendor_reset_id_table);
+
+static struct platform_driver psci_vendor_reset_driver = {
+	.probe = psci_vendor_reset_probe,
+	.driver = {
+		.name = "psci-vendor-reset",
+		.of_match_table = of_match_ptr(psci_vendor_reset_id_table),
+	},
+};
+module_platform_driver(psci_vendor_reset_driver);
+
+MODULE_DESCRIPTION("PSCI Vendor SYSTEM_RESET2 Driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/psci.h b/include/linux/psci.h
index 4ca0060a3fc4..0c652c12e0a8 100644
--- a/include/linux/psci.h
+++ b/include/linux/psci.h
@@ -21,6 +21,8 @@ bool psci_power_state_is_valid(u32 state);
 int psci_set_osi_mode(bool enable);
 bool psci_has_osi_support(void);
 
+void psci_vendor_sys_reset2(u32 reset_type, u32 cookie);
+
 struct psci_operations {
 	u32 (*get_version)(void);
 	int (*cpu_suspend)(u32 state, unsigned long entry_point);
-- 
2.41.0

