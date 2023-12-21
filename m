Return-Path: <linux-kernel+bounces-7889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0B681AEBF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 07:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90FEF1F24172
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 06:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83C6B673;
	Thu, 21 Dec 2023 06:26:34 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DC3B654
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 06:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1703139979-1eb14e740b040b0002-xx1T2L
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by mx2.zhaoxin.com with ESMTP id c5eegCnApH9lyKf5 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Thu, 21 Dec 2023 14:26:22 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ZXBJMBX03.zhaoxin.com (10.29.252.7) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 21 Dec
 2023 14:26:19 +0800
Received: from xin.lan (10.32.64.1) by ZXBJMBX03.zhaoxin.com (10.29.252.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 21 Dec
 2023 14:26:03 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
From: LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.7
To: <olivia@selenic.com>, <herbert@gondor.apana.org.au>,
	<jiajie.ho@starfivetech.com>, <conor.dooley@microchip.com>,
	<martin@kaiser.cx>, <mmyangfl@gmail.com>, <jenny.zhang@starfivetech.com>,
	<robh@kernel.org>, <l.stelmach@samsung.com>, <ardb@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>
CC: <CobeChen@zhaoxin.com>, <TonyWWang@zhaoxin.com>, <YunShen@zhaoxin.com>,
	<LeoLiu@zhaoxin.com>, LeoLiuoc <LeoLiu-oc@zhaoxin.com>
Subject: [PATCH v3] hwrng: add Zhaoxin rng driver base on rep_xstore instruction
Date: Thu, 21 Dec 2023 14:26:02 +0800
X-ASG-Orig-Subj: [PATCH v3] hwrng: add Zhaoxin rng driver base on rep_xstore instruction
Message-ID: <20231221062602.799432-1-LeoLiu-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107070900.496827-1-LeoLiu-oc@zhaoxin.com>
References: <20231107070900.496827-1-LeoLiu-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1703139981
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 6401
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.118357
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------

From: LeoLiuoc <LeoLiu-oc@zhaoxin.com>

Add support for Zhaoxin hardware random number generator.
This driver base on rep_xstore instruction and uses the same
X86_FEATURE_XSTORE as via-rng driver. Therefore, modify the x86_cpu_id
array in the via-rng driver, so that the corresponding driver can be
correctly loader on respective platforms.

v1 -> v2:
1. Fix assembler code errors
2. Remove redundant CPU model check codes

v2 -> v3:
1. Optimize code details based on the kernel style

Signed-off-by: LeoLiuoc <LeoLiu-oc@zhaoxin.com>
---
 drivers/char/hw_random/Kconfig       | 12 ++++
 drivers/char/hw_random/Makefile      |  1 +
 drivers/char/hw_random/via-rng.c     | 10 +--
 drivers/char/hw_random/zhaoxin-rng.c | 95 ++++++++++++++++++++++++++++
 4 files changed, 113 insertions(+), 5 deletions(-)
 create mode 100644 drivers/char/hw_random/zhaoxin-rng.c

diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
index 442c40efb200..3c1c4fa1203c 100644
--- a/drivers/char/hw_random/Kconfig
+++ b/drivers/char/hw_random/Kconfig
@@ -152,6 +152,18 @@ config HW_RANDOM_VIA
 
 	  If unsure, say Y.
 
+config HW_RANDOM_ZHAOXIN
+	tristate "Zhaoxin HW Random Number Generator support"
+	depends on X86
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
diff --git a/drivers/char/hw_random/via-rng.c b/drivers/char/hw_random/via-rng.c
index a9a0a3b09c8b..285505b4d620 100644
--- a/drivers/char/hw_random/via-rng.c
+++ b/drivers/char/hw_random/via-rng.c
@@ -35,7 +35,7 @@
 #include <asm/cpufeature.h>
 #include <asm/fpu/api.h>
 
-
+static const struct x86_cpu_id via_rng_cpu_ids[];
 
 
 enum {
@@ -135,7 +135,7 @@ static int via_rng_init(struct hwrng *rng)
 	 * is always enabled if CPUID rng_en is set.  There is no
 	 * RNG configuration like it used to be the case in this
 	 * register */
-	if (((c->x86 == 6) && (c->x86_model >= 0x0f))  || (c->x86 > 6)){
+	if ((c->x86 == 6) && (c->x86_model >= 0x0f)) {
 		if (!boot_cpu_has(X86_FEATURE_XSTORE_EN)) {
 			pr_err(PFX "can't enable hardware RNG "
 				"if XSTORE is not enabled\n");
@@ -196,7 +196,7 @@ static int __init via_rng_mod_init(void)
 {
 	int err;
 
-	if (!boot_cpu_has(X86_FEATURE_XSTORE))
+	if (!x86_match_cpu(via_rng_cpu_ids))
 		return -ENODEV;
 
 	pr_info("VIA RNG detected\n");
@@ -217,8 +217,8 @@ static void __exit via_rng_mod_exit(void)
 }
 module_exit(via_rng_mod_exit);
 
-static struct x86_cpu_id __maybe_unused via_rng_cpu_id[] = {
-	X86_MATCH_FEATURE(X86_FEATURE_XSTORE, NULL),
+static struct x86_cpu_id via_rng_cpu_id[] = {
+	X86_MATCH_VENDOR_FAM_FEATURE(CENTAUR, 6, X86_FEATURE_XSTORE, NULL),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, via_rng_cpu_id);
diff --git a/drivers/char/hw_random/zhaoxin-rng.c b/drivers/char/hw_random/zhaoxin-rng.c
new file mode 100644
index 000000000000..3e5770df9948
--- /dev/null
+++ b/drivers/char/hw_random/zhaoxin-rng.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RNG driver for Zhaoxin RNGs
+ *
+ * Copyright 2023 (c) Zhaoxin Semiconductor Co., Ltd
+ */
+
+#include <asm/cpu_device_id.h>
+#include <asm/fpu/api.h>
+#include <crypto/padlock.h>
+#include <linux/cpufeature.h>
+#include <linux/delay.h>
+#include <linux/hw_random.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+enum {
+	ZHAOXIN_RNG_CHUNK_8		= 0x00, /* 64 rand bits, 64 stored bits */
+	ZHAOXIN_RNG_CHUNK_4		= 0x01, /* 32 rand bits, 32 stored bits */
+	ZHAOXIN_RNG_CHUNK_2		= 0x02, /* 16 rand bits, 32 stored bits */
+	ZHAOXIN_RNG_CHUNK_1		= 0x03, /*  8 rand bits, 32 stored bits */
+	ZHAOXIN_RNG_MAX_SIZE	= (128 * 1024),
+};
+
+static int zhaoxin_rng_init(struct hwrng *rng)
+{
+	if (!boot_cpu_has(X86_FEATURE_XSTORE_EN)) {
+		pr_err(PFX "can't enable hardware RNG if XSTORE is not enabled\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static inline int rep_xstore(size_t size, size_t factor, void *result)
+{
+	asm(".byte 0xf3, 0x0f, 0xa7, 0xc0"
+		: "=m"(*(size_t *)result), "+c"(size), "+d"(factor), "+D"(result));
+
+	return 0;
+}
+
+static int zhaoxin_rng_read(struct hwrng *rng, void *data, size_t max, bool wait)
+{
+	if (max > ZHAOXIN_RNG_MAX_SIZE)
+		max = ZHAOXIN_RNG_MAX_SIZE;
+
+	rep_xstore(max, ZHAOXIN_RNG_CHUNK_1, data);
+
+	return max;
+}
+
+static struct hwrng zhaoxin_rng = {
+	.name = "zhaoxin",
+	.init = zhaoxin_rng_init,
+	.read = zhaoxin_rng_read,
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
+	if (!x86_match_cpu(zhaoxin_rng_cpu_ids)) {
+		pr_err(PFX "The CPU isn't support XSTORE.\n");
+		return -ENODEV;
+	}
+
+	pr_info("Zhaoxin RNG detected\n");
+
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
+
+MODULE_DESCRIPTION("H/W RNG driver for Zhaoxin CPUs");
+MODULE_AUTHOR("YunShen@zhaoxin.com");
+MODULE_LICENSE("GPL");
-- 
2.34.1


