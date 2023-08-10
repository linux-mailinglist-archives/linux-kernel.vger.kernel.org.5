Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04527781A2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 21:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236490AbjHJTaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 15:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236489AbjHJTaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 15:30:01 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EA2213B;
        Thu, 10 Aug 2023 12:29:59 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37AJTZ3c009849;
        Thu, 10 Aug 2023 14:29:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691695775;
        bh=QakJF0vKD4LI2ux0hj8NDYuIaIlYgUscRa6sAwZTxvE=;
        h=From:Date:Subject:References:In-Reply-To:To:CC;
        b=EMs69mcoOWZUGQ7zuitC9jD9tZjZtlHw2q/CNSmPZuUQsKP0ni9Sa/WTsc2IAJgj1
         iap9z/5cHiMWvVALFwRrbd7lV2T9YPBbM3cAngE4Ef4/AFt5tZhk6OrPgqyp7DTU3U
         EsmRNFoTcJMfqY1HMVvIijeRYcImaUbmow9CpCpY=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37AJTZ59083927
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Aug 2023 14:29:35 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 10
 Aug 2023 14:29:34 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 10 Aug 2023 14:29:34 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37AJTYO0047074;
        Thu, 10 Aug 2023 14:29:34 -0500
From:   Kamlesh Gurudasani <kamlesh@ti.com>
Date:   Fri, 11 Aug 2023 00:58:51 +0530
Subject: [PATCH v2 4/6] crypto: ti - add driver for MCRC64 engine
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230719-mcrc-upstream-v2-4-4152b987e4c2@ti.com>
References: <20230719-mcrc-upstream-v2-0-4152b987e4c2@ti.com>
In-Reply-To: <20230719-mcrc-upstream-v2-0-4152b987e4c2@ti.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Kamlesh Gurudasani <kamlesh@ti.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691695767; l=14352;
 i=kamlesh@ti.com; s=20230614; h=from:subject:message-id;
 bh=tNm+93tT5JPLHvkjsdglcwj3W2ZGxFI8cDayuuEd7OU=;
 b=S1NisAwEg9ZHMUOR+gvCCj5HVYBtBHUn2bHNI475XgqIfbNXAZ1BWJJyWEg/UW7ZIsB33lSOm
 LCPoPTNsfMgACpd1Deizy/EL4ct+7/A25MmAg0eAlh5+yagvdwe6o70
X-Developer-Key: i=kamlesh@ti.com; a=ed25519;
 pk=db9XKPVWDGJVqj2jDqgnPQd6uQf3GZ3oaQa4bq1odGo=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for MCRC64 engine to calculate 64-bit CRC in Full-CPU mode.

In Full-CPU mode, the CPU does the data patterns transfer and signature
verification all by itself, only CRC calculation is being done by MCRC64
engine.

MCRC64 engine calculates 64-bit cyclic redundancy checks (CRC)
according to the ISO 3309 standard.

The ISO 3309 64-bit CRC model parameters are as follows:
    Generator Polynomial: x^64 + x^4 + x^3 + x + 1
    Polynomial Value: 0x000000000000001B
    Initial value: 0x0000000000000000
    Reflected Input: False
    Reflected Output: False
    Xor Final: 0x0000000000000000

Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
---
 MAINTAINERS                |   2 +
 drivers/crypto/Kconfig     |   1 +
 drivers/crypto/Makefile    |   1 +
 drivers/crypto/ti/Kconfig  |  10 +++
 drivers/crypto/ti/Makefile |   2 +
 drivers/crypto/ti/mcrc64.c | 442 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 458 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 66b51f43d196..0ceca7dbede9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21483,8 +21483,10 @@ F:	drivers/iio/adc/ti-lmp92064.c
 
 TI MEMORY CYCLIC REDUNDANCY CHECK (MCRC64) DRIVER
 M:	Kamlesh Gurudasani <kamlesh@ti.com>
+L:	linux-crypto@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/crypto/ti,mcrc64.yaml
+F:	drivers/crypto/ti/mcrc64.c
 
 TI PCM3060 ASoC CODEC DRIVER
 M:	Kirill Marinushkin <kmarinushkin@birdec.com>
diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index c761952f0dc6..2101f92ead66 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -796,5 +796,6 @@ config CRYPTO_DEV_SA2UL
 
 source "drivers/crypto/aspeed/Kconfig"
 source "drivers/crypto/starfive/Kconfig"
+source "drivers/crypto/ti/Kconfig"
 
 endif # CRYPTO_HW
diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
index d859d6a5f3a4..f1a151b73ff1 100644
--- a/drivers/crypto/Makefile
+++ b/drivers/crypto/Makefile
@@ -41,6 +41,7 @@ obj-$(CONFIG_CRYPTO_DEV_SAHARA) += sahara.o
 obj-$(CONFIG_CRYPTO_DEV_SL3516) += gemini/
 obj-y += stm32/
 obj-$(CONFIG_CRYPTO_DEV_TALITOS) += talitos.o
+obj-$(CONFIG_ARCH_K3) += ti/
 obj-$(CONFIG_CRYPTO_DEV_VIRTIO) += virtio/
 obj-$(CONFIG_CRYPTO_DEV_VMX) += vmx/
 obj-$(CONFIG_CRYPTO_DEV_BCM_SPU) += bcm/
diff --git a/drivers/crypto/ti/Kconfig b/drivers/crypto/ti/Kconfig
new file mode 100644
index 000000000000..548d4cb905bf
--- /dev/null
+++ b/drivers/crypto/ti/Kconfig
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config CRYPTO_DEV_TI_MCRC64
+	tristate "Support for TI MCRC64 engine"
+	depends on ARCH_K3
+	select CRYPTO_HASH
+	help
+	  This enables support for the MCRC64 engine
+	  which can be found on TI K3 SOC.
+	  MCRC64 engine calculates 64-bit cyclic redundancy checks (CRC)
+	  according to the ISO 3309 standard.
diff --git a/drivers/crypto/ti/Makefile b/drivers/crypto/ti/Makefile
new file mode 100644
index 000000000000..94ffc2576137
--- /dev/null
+++ b/drivers/crypto/ti/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_CRYPTO_DEV_TI_MCRC64) += mcrc64.o
diff --git a/drivers/crypto/ti/mcrc64.c b/drivers/crypto/ti/mcrc64.c
new file mode 100644
index 000000000000..9a7634bf1c21
--- /dev/null
+++ b/drivers/crypto/ti/mcrc64.c
@@ -0,0 +1,442 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) Texas Instruments 2023 - http://www.ti.com
+ * Author: Kamlesh Gurudasani <kamlesh@ti.com>
+ */
+
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+
+#include <crypto/internal/hash.h>
+
+#include <asm/unaligned.h>
+
+#define DRIVER_NAME		"mcrc64"
+#define CHKSUM_DIGEST_SIZE	8
+#define CHKSUM_BLOCK_SIZE	1
+
+/* Registers */
+#define CRC_CTRL0 0x0000 /* CRC Global Control Register 0 */
+#define CH_PSA_SWRE(ch) BIT(((ch) - 1) << 3) /* PSA Software Reset  */
+
+#define CRC_CTRL1 0x0008 /* CRC Global Control Register 1 */
+#define PWDN BIT(0) /* Power Down  */
+
+#define CRC_CTRL2 0x0010 /* CRC Global Control Register 2 */
+#define CH_MODE(ch, m) ((m) << (((ch) - 1) << 3))
+
+#define PSA_SIGREGL(ch) ((0x6 + (4 * ((ch) - 1))) << 4) /* Signature register */
+
+#define MCRC64_ALG_MASK 0x8000000000000000
+#define MCRC64_CRC64_POLY 0x000000000000001b
+
+#define MCRC64_AUTOSUSPEND_DELAY 50
+
+enum mcrc64_mode {
+	MCRC64_MODE_DATA_CAPTURE = 0,
+	MCRC64_MODE_AUTO,
+	MCRC64_MODE_SEMI_CPU,
+	MCRC64_MODE_FULL_CPU,
+	MCRC64_MODE_INVALID,
+};
+
+enum mcrc64_channel {
+	MCRC64_CHANNEL_1 = 1,
+	MCRC64_CHANNEL_2,
+	MCRC64_CHANNEL_3,
+	MCRC64_CHANNEL_4,
+	MCRC64_CHANNEL_INVALID,
+};
+
+struct mcrc64_data {
+	struct list_head list;
+	struct device *dev;
+	void __iomem *regs;
+};
+
+struct mcrc64_list {
+	struct list_head dev_list;
+	spinlock_t lock; /* protect dev_list */
+};
+
+static struct mcrc64_list mcrc64_dev_list = {
+	.dev_list = LIST_HEAD_INIT(mcrc64_dev_list.dev_list),
+	.lock = __SPIN_LOCK_UNLOCKED(mcrc64_dev_list.lock),
+};
+
+struct mcrc64_tfm_ctx {
+	struct mcrc64_data *dev_data;
+	u64 key;
+};
+
+struct mcrc64_desc_ctx {
+	u64 signature;
+};
+
+static struct mcrc64_data *mcrc64_get_dev(struct mcrc64_tfm_ctx *tctx)
+{
+	struct mcrc64_data *dev_data;
+
+	if (tctx->dev_data)
+		return tctx->dev_data;
+
+	spin_lock_bh(&mcrc64_dev_list.lock);
+	dev_data = list_first_entry(&mcrc64_dev_list.dev_list, struct mcrc64_data, list);
+	if (dev_data)
+		list_move_tail(&dev_data->list, &mcrc64_dev_list.dev_list);
+	spin_unlock_bh(&mcrc64_dev_list.lock);
+
+	return dev_data;
+}
+
+static int mcrc64_set_mode(void __iomem *regs, u32 channel, u32 mode)
+{
+	u32 mode_set_val;
+	u32 crc_ctrl2_reg = 0;
+
+	if (mode < 0 || mode >= MCRC64_MODE_INVALID)
+		return -EINVAL;
+
+	if (channel <= 0 || channel >= MCRC64_CHANNEL_INVALID)
+		return -EINVAL;
+
+	mode_set_val = crc_ctrl2_reg | CH_MODE(channel, mode);
+
+	/* Write CRC_CTRL2, set mode */
+	writel_relaxed(mode_set_val, regs + CRC_CTRL2);
+
+	return 0;
+}
+
+static int mcrc64_reset_signature(void __iomem *regs, u32 channel)
+{
+	u32 crc_ctrl0_reg, reset_val, reset_undo_val;
+
+	if (channel <= 0 || channel >= MCRC64_CHANNEL_INVALID)
+		return -EINVAL;
+
+	/* reset PSA */
+	crc_ctrl0_reg = readl_relaxed(regs + CRC_CTRL0);
+
+	reset_val = crc_ctrl0_reg | CH_PSA_SWRE(channel);
+	reset_undo_val = crc_ctrl0_reg & ~CH_PSA_SWRE(channel);
+
+	/* Write CRC_CTRL0 register, reset PSA register */
+	writel_relaxed(reset_val, regs + CRC_CTRL0);
+	writel_relaxed(reset_undo_val, regs + CRC_CTRL0);
+
+	return 0;
+}
+
+/* This helper implements crc64 calculation using CPU */
+static u64 mcrc64_calculate_sw_crc(u64 crc, u8 byte)
+{
+	u64 bit = 0;
+	u8 j;
+
+	for (j = 0; j < 8; j++) {
+		bit = crc & MCRC64_ALG_MASK;
+		crc <<= 1;
+		if (byte & (0x80 >> j))
+			bit ^= MCRC64_ALG_MASK;
+		if (bit)
+			crc ^= MCRC64_CRC64_POLY;
+	}
+
+	return crc;
+}
+
+static int mcrc64_calculate_crc(void __iomem *regs, u32 channel,
+				const u8 *d8, size_t length, u64 *crc64)
+{
+	void __iomem *psa_reg;
+	u64 signature = 0;
+
+	if (channel <= 0 || channel >= MCRC64_CHANNEL_INVALID)
+		return -EINVAL;
+
+	psa_reg = regs + PSA_SIGREGL(channel);
+
+	for (; length >= sizeof(u64); d8 += sizeof(u64), length -= sizeof(u64))
+		writeq_relaxed(cpu_to_be64p((u64 *)d8), psa_reg);
+
+	signature = readq_relaxed(psa_reg);
+
+	if (length) {
+		while (length--)
+			signature = mcrc64_calculate_sw_crc(signature, *d8++);
+
+		/* set capture mode */
+		int ret = mcrc64_set_mode(regs, MCRC64_CHANNEL_1,
+					MCRC64_MODE_DATA_CAPTURE);
+		if (ret)
+			return ret;
+
+		ret = mcrc64_reset_signature(regs, MCRC64_CHANNEL_1);
+		if (ret)
+			return ret;
+
+		writeq_relaxed(signature, psa_reg);
+
+		ret = mcrc64_set_mode(regs, MCRC64_CHANNEL_1,
+				      MCRC64_MODE_FULL_CPU);
+		if (ret)
+			return ret;
+	}
+
+	*crc64 = signature;
+
+	return 0;
+}
+
+static int mcrc64_cra_init(struct crypto_tfm *tfm)
+{
+	struct mcrc64_tfm_ctx *tctx = crypto_tfm_ctx(tfm);
+	struct mcrc64_data *dev_data;
+
+	dev_data = mcrc64_get_dev(tctx);
+	if (!dev_data)
+		return -ENODEV;
+
+	pm_runtime_get_sync(dev_data->dev);
+
+	tctx->key = 0;
+
+	return 0;
+}
+
+static void mcrc64_cra_exit(struct crypto_tfm *tfm)
+{
+	struct mcrc64_tfm_ctx *tctx = crypto_tfm_ctx(tfm);
+	struct mcrc64_data *dev_data;
+
+	dev_data = mcrc64_get_dev(tctx);
+
+	pm_runtime_mark_last_busy(dev_data->dev);
+	pm_runtime_put_autosuspend(dev_data->dev);
+}
+
+static int mcrc64_setkey(struct crypto_shash *tfm, const u8 *key,
+			 unsigned int keylen)
+{
+	struct mcrc64_tfm_ctx *tctx = crypto_shash_ctx(tfm);
+
+	if (keylen != sizeof(u64))
+		return -EINVAL;
+
+	tctx->key = get_unaligned_le64(key);
+
+	return 0;
+}
+
+static int mcrc64_init(struct shash_desc *desc)
+{
+	struct mcrc64_desc_ctx *ctx = shash_desc_ctx(desc);
+	struct mcrc64_tfm_ctx *tctx = crypto_shash_ctx(desc->tfm);
+	struct mcrc64_data *dev_data;
+	void __iomem *psa_reg;
+
+	dev_data = mcrc64_get_dev(tctx);
+	if (!dev_data)
+		return -ENODEV;
+
+	pm_runtime_get_sync(dev_data->dev);
+
+	/* set capture mode */
+	int ret = mcrc64_set_mode(dev_data->regs, MCRC64_CHANNEL_1,
+				  MCRC64_MODE_DATA_CAPTURE);
+	if (ret)
+		return ret;
+
+	/* reset PSA */
+	psa_reg = dev_data->regs + PSA_SIGREGL(MCRC64_CHANNEL_1);
+	ret =  mcrc64_reset_signature(dev_data->regs, MCRC64_CHANNEL_1);
+	if (ret)
+		return ret;
+
+	/* write key  */
+	writeq_relaxed(tctx->key, psa_reg);
+
+	/* set full cpu mode */
+	ret = mcrc64_set_mode(dev_data->regs, MCRC64_CHANNEL_1,
+			      MCRC64_MODE_FULL_CPU);
+	if (ret)
+		return ret;
+
+	ctx->signature = readq_relaxed(psa_reg);
+
+	return 0;
+}
+
+static int mcrc64_update(struct shash_desc *desc, const u8 *d8,
+			 unsigned int length)
+{
+	struct mcrc64_desc_ctx *ctx = shash_desc_ctx(desc);
+	struct mcrc64_tfm_ctx *tctx = crypto_shash_ctx(desc->tfm);
+	struct mcrc64_data *dev_data;
+
+	dev_data = mcrc64_get_dev(tctx);
+	if (!dev_data)
+		return -ENODEV;
+
+	return mcrc64_calculate_crc(dev_data->regs, MCRC64_CHANNEL_1,
+				    d8, length, &ctx->signature);
+}
+
+static int mcrc64_final(struct shash_desc *desc, u8 *out)
+{
+	struct mcrc64_desc_ctx *ctx = shash_desc_ctx(desc);
+
+	/* Send computed CRC */
+	put_unaligned_le64(ctx->signature, out);
+	return 0;
+}
+
+static int mcrc64_finup(struct shash_desc *desc, const u8 *data,
+			unsigned int length, u8 *out)
+{
+	return mcrc64_update(desc, data, length) ?:
+		mcrc64_final(desc, out);
+}
+
+static int mcrc64_digest(struct shash_desc *desc, const u8 *data,
+			 unsigned int length, u8 *out)
+{
+	return mcrc64_init(desc) ?: mcrc64_finup(desc, data, length, out);
+}
+
+static unsigned int refcnt;
+static DEFINE_MUTEX(refcnt_lock);
+static struct shash_alg algs[] = {
+	/* CRC-64 */
+	{
+		.setkey		= mcrc64_setkey,
+		.init		= mcrc64_init,
+		.update		= mcrc64_update,
+		.final		= mcrc64_final,
+		.finup		= mcrc64_finup,
+		.digest		= mcrc64_digest,
+		.descsize	= sizeof(struct mcrc64_desc_ctx),
+		.digestsize	= CHKSUM_DIGEST_SIZE,
+		.base		= {
+			.cra_name		= "crc64-iso",
+			.cra_driver_name	= "mcrc64",
+			.cra_priority		= 300,
+			.cra_flags		= CRYPTO_ALG_OPTIONAL_KEY,
+			.cra_blocksize		= CHKSUM_BLOCK_SIZE,
+			.cra_alignmask		= 7,
+			.cra_ctxsize		= sizeof(struct mcrc64_tfm_ctx),
+			.cra_module		= THIS_MODULE,
+			.cra_init		= mcrc64_cra_init,
+			.cra_exit		= mcrc64_cra_exit,
+		}
+	}
+};
+
+static int mcrc64_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mcrc64_data *dev_data;
+	int ret;
+
+	dev_data = devm_kzalloc(dev, sizeof(*dev_data), GFP_KERNEL);
+	if (!dev_data)
+		return -ENOMEM;
+
+	dev_data->dev = dev;
+	dev_data->regs = devm_platform_ioremap_resource(pdev, 0);
+
+	platform_set_drvdata(pdev, dev_data);
+
+	spin_lock(&mcrc64_dev_list.lock);
+	list_add(&dev_data->list, &mcrc64_dev_list.dev_list);
+	spin_unlock(&mcrc64_dev_list.lock);
+
+	mutex_lock(&refcnt_lock);
+	if (!refcnt) {
+		ret = crypto_register_shashes(algs, ARRAY_SIZE(algs));
+		if (ret) {
+			mutex_unlock(&refcnt_lock);
+			dev_err(dev, "Failed to register\n");
+			return ret;
+		}
+	}
+	refcnt++;
+	mutex_unlock(&refcnt_lock);
+
+	pm_runtime_set_autosuspend_delay(dev, MCRC64_AUTOSUSPEND_DELAY);
+	pm_runtime_use_autosuspend(dev);
+
+	pm_runtime_get_noresume(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
+	pm_runtime_put_sync(dev);
+
+	return 0;
+}
+
+static int mcrc64_remove(struct platform_device *pdev)
+{
+	struct mcrc64_data *dev_data = platform_get_drvdata(pdev);
+	int ret;
+
+	ret = pm_runtime_resume_and_get(dev_data->dev);
+	if (ret < 0)
+		return ret;
+
+	spin_lock(&mcrc64_dev_list.lock);
+	list_del(&dev_data->list);
+	spin_unlock(&mcrc64_dev_list.lock);
+
+	mutex_lock(&refcnt_lock);
+	if (!--refcnt)
+		crypto_unregister_shashes(algs, ARRAY_SIZE(algs));
+	mutex_unlock(&refcnt_lock);
+
+	pm_runtime_disable(dev_data->dev);
+	pm_runtime_put_noidle(dev_data->dev);
+
+	return 0;
+}
+
+static int __maybe_unused mcrc64_suspend(struct device *dev)
+{
+	return	pm_runtime_force_suspend(dev);
+}
+
+static int __maybe_unused mcrc64_resume(struct device *dev)
+{
+	return pm_runtime_force_resume(dev);
+}
+
+static const struct dev_pm_ops mcrc64_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(mcrc64_suspend,
+				mcrc64_resume)
+};
+
+static const struct of_device_id of_match[] = {
+	{ .compatible = "ti,am62-mcrc64", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, of_match);
+
+static struct platform_driver mcrc64_driver = {
+	.probe	= mcrc64_probe,
+	.remove = mcrc64_remove,
+	.driver = {
+		.name		= DRIVER_NAME,
+		.pm		= &mcrc64_pm_ops,
+		.of_match_table = of_match,
+	},
+};
+
+module_platform_driver(mcrc64_driver);
+
+MODULE_AUTHOR("Kamlesh Gurudasani <kamlesh@ti.com>");
+MODULE_DESCRIPTION("Texas Instruments MCRC64 driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1

