Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFC27690B3
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbjGaIri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjGaIqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:46:46 -0400
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D837213C
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 01:45:29 -0700 (PDT)
X-ASG-Debug-ID: 1690793120-086e23186c033c0001-xx1T2L
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by mx1.zhaoxin.com with ESMTP id S2cxMzuC0SFUPNlg (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Mon, 31 Jul 2023 16:45:20 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from ZXBJMBX03.zhaoxin.com (10.29.252.7) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Mon, 31 Jul
 2023 16:45:20 +0800
Received: from xin.lan (10.32.64.1) by ZXBJMBX03.zhaoxin.com (10.29.252.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Mon, 31 Jul
 2023 16:45:18 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
From:   LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.7
To:     <olivia@selenic.com>, <herbert@gondor.apana.org.au>,
        <jiajie.ho@starfivetech.com>, <conor.dooley@microchip.com>,
        <martin@kaiser.cx>, <mmyangfl@gmail.com>,
        <jenny.zhang@starfivetech.com>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>
CC:     <leoliu@zhaoxin.com>, <CobeChen@zhaoxin.com>,
        <YunShen@zhaoxin.com>, <TonyWWang@zhaoxin.com>,
        leoliu-oc <leoliu-oc@zhaoxin.com>
Subject: [PATCH v2 2/2] hwrng: add Zhaoxin HW RNG driver
Date:   Mon, 31 Jul 2023 16:45:15 +0800
X-ASG-Orig-Subj: [PATCH v2 2/2] hwrng: add Zhaoxin HW RNG driver
Message-ID: <20230731084515.2057375-3-LeoLiu-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230731084515.2057375-1-LeoLiu-oc@zhaoxin.com>
References: <20230731084515.2057375-1-LeoLiu-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.32.64.1]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1690793120
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 4487
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.112114
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: leoliu-oc <leoliu-oc@zhaoxin.com>

Add support for Zhaoxin HW RNG.

Signed-off-by: leoliu-oc <leoliu-oc@zhaoxin.com>
---
 drivers/char/hw_random/Kconfig       | 13 +++++
 drivers/char/hw_random/Makefile      |  1 +
 drivers/char/hw_random/zhaoxin-rng.c | 87 ++++++++++++++++++++++++++++
 3 files changed, 101 insertions(+)
 create mode 100644 drivers/char/hw_random/zhaoxin-rng.c

diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
index e0b3786ca51b..e315cd444c77 100644
--- a/drivers/char/hw_random/Kconfig
+++ b/drivers/char/hw_random/Kconfig
@@ -150,6 +150,19 @@ config HW_RANDOM_VIA
 
 	  If unsure, say Y.
 
+config HW_RANDOM_ZHAOXIN
+	tristate "Zhaoxin HW Random Number Generator support"
+	depends on X86 || COMPILE_TEST
+	default HW_RANDOM
+	help
+	  This driver provides kernel-side support for the Random Number
+	  Generator hardware found on Zhaoxin based motherboards.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called zhaoxin-rng.
+
+	  If unsure, say Y.
+
 config HW_RANDOM_IXP4XX
 	tristate "Intel IXP4xx NPU HW Pseudo-Random Number Generator support"
 	depends on ARCH_IXP4XX || COMPILE_TEST
diff --git a/drivers/char/hw_random/Makefile b/drivers/char/hw_random/Makefile
index 32549a1186dc..ef5b3ae0794d 100644
--- a/drivers/char/hw_random/Makefile
+++ b/drivers/char/hw_random/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_HW_RANDOM_GEODE) += geode-rng.o
 obj-$(CONFIG_HW_RANDOM_N2RNG) += n2-rng.o
 n2-rng-y := n2-drv.o n2-asm.o
 obj-$(CONFIG_HW_RANDOM_VIA) += via-rng.o
+obj-$(CONFIG_HW_RANDOM_ZHAOXIN) += zhaoxin-rng.o
 obj-$(CONFIG_HW_RANDOM_EXYNOS) += exynos-trng.o
 obj-$(CONFIG_HW_RANDOM_IXP4XX) += ixp4xx-rng.o
 obj-$(CONFIG_HW_RANDOM_OMAP) += omap-rng.o
diff --git a/drivers/char/hw_random/zhaoxin-rng.c b/drivers/char/hw_random/zhaoxin-rng.c
new file mode 100644
index 000000000000..0ceeb9c3f989
--- /dev/null
+++ b/drivers/char/hw_random/zhaoxin-rng.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * RNG driver for Zhaoxin RNGs
+ *
+ * Copyright 2023 (c) Zhaoxin Semiconductor Co., Ltd.
+ *
+ */
+
+#include <crypto/padlock.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/hw_random.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/cpufeature.h>
+#include <asm/cpu_device_id.h>
+#include <asm/fpu/api.h>
+
+enum {
+	ZHAOXIN_RNG_CHUNK_8		= 0x00, /* 64 rand bits, 64 stored bits*/
+	ZHAOXIN_RNG_CHUNK_4		= 0x01, /* 32 rand bits, 32 stored bits */
+	ZHAOXIN_RNG_CHUNK_2		= 0x02, /* 16 rand bits, 32 stored bits */
+	ZHAOXIN_RNG_CHUNK_1		= 0x03, /* 8 rand bits, 32 stored bits */
+	ZHAOXIN_RNG_MAX_SIZE		= (128*1024),
+};
+
+static int zhaoxin_rng_init(struct hwrng *rng)
+{
+	if (!boot_cpu_has(X86_FEATURE_XSTORE_EN)) {
+		pr_err(PFX "can't enable hardware RNG if XSTORE is not enabled\n");
+		return -ENODEV;
+	}
+	return 0;
+}
+
+static inline void rep_xstore(size_t size, size_t factor, void *result)
+{
+	asm(".byte 0xF3, 0x0F, 0xA7, 0xC0 /*rep xstore*/"
+		: "=m" (*(size_t *)result), "+c" (size), "+d" (factor), "+D" (result));
+}
+
+static int zhaoxin_rng_read(struct hwrng *rng, void *data, size_t max, bool wait)
+{
+	if (max > ZHAOXIN_RNG_MAX_SIZE)
+		max = ZHAOXIN_RNG_MAX_SIZE;
+	rep_xstore(max, ZHAOXIN_RNG_CHUNK_1, data);
+	return max;
+}
+
+static struct hwrng zhaoxin_rng = {
+	.name   = "zhaoxin",
+	.init   = zhaoxin_rng_init,
+	.read   = zhaoxin_rng_read,
+};
+
+static const struct x86_cpu_id zhaoxin_rng_cpu_ids[] = {
+	X86_MATCH_VENDOR_FAM_FEATURE(ZHAOXIN, 6, X86_FEATURE_XSTORE, NULL),
+	X86_MATCH_VENDOR_FAM_FEATURE(ZHAOXIN, 7, X86_FEATURE_XSTORE, NULL),
+	X86_MATCH_VENDOR_FAM_FEATURE(CENTAUR, 7, X86_FEATURE_XSTORE, NULL),
+	{}
+};
+MODULE_DEVICE_TABLE(x86cpu, zhaoxin_rng_cpu_ids);
+
+static int __init zhaoxin_rng_mod_init(void)
+{
+	int err;
+
+	if (!x86_match_cpu(zhaoxin_rng_cpu_ids))
+		return -ENODEV;
+
+	pr_info("Zhaoxin RNG detected\n");
+	err = hwrng_register(&zhaoxin_rng);
+	if (err)
+		pr_err(PFX "RNG registering failed (%d)\n", err);
+
+	return err;
+}
+module_init(zhaoxin_rng_mod_init);
+
+static void __exit zhaoxin_rng_mod_exit(void)
+{
+	hwrng_unregister(&zhaoxin_rng);
+}
+module_exit(zhaoxin_rng_mod_exit);
+MODULE_DESCRIPTION("H/W RNG driver for Zhaoxin CPU");
+MODULE_AUTHOR("YunShen@zhaoxin.com");
+MODULE_LICENSE("GPL");
-- 
2.34.1

