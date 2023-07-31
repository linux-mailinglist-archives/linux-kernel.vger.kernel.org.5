Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D550C769FC5
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 19:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbjGaRut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 13:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjGaRur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 13:50:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561E995;
        Mon, 31 Jul 2023 10:50:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABFE161265;
        Mon, 31 Jul 2023 17:50:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C4AC43391;
        Mon, 31 Jul 2023 17:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690825837;
        bh=yWKGZpq/+KlEiVpsQJNfxvQ7UA5Sm8iHfPI9KfQO9s4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tRyAhL3YwXZ0rUUdSxMGDzJfJSLs7GUgYJ7dUZm61tZ3KdSL5a5/pEzOx/95xu3kn
         l9KoCpk8XT73JeGqa/2Q4oS2LEC91zcxD6DkIsZsAzn2FEHW0307m0EBKeuQCkIwdS
         1TjZxARbx/wbqCMXNI3Ij5my3Nkuw9rqFHpPpvaninQUROt/lEpfulnT6cTuIcsLV+
         z+qfpcxARim6VGFc786BnV63J9AAh9AVyOGx4jXet2Sy8jMfrK+V9L2yqgLhwgl5qI
         UgIpG9iBRG5QyUQo1Kdw7La5OYpi9G3E4gm/b82WwiVANrCMWAdJYCclevhYItQPBJ
         IgK4wz9QWHQRQ==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2b9cdba1228so54737351fa.2;
        Mon, 31 Jul 2023 10:50:36 -0700 (PDT)
X-Gm-Message-State: ABy/qLZs6pxVeiFP81gWgJ9QR+sejw/ZxtJucc/ofqgwQIEAbF24mUK1
        ezgeaD5RG0Mm4U7Bn42bfgs/xES43cMRigJ4bWk=
X-Google-Smtp-Source: APBJJlGawuiG3+hdVed8tBfx9F1ZlXAQCAlN4eYkU/Y7f1S1t10pKbn4gYh2VqCZKlCoKOdbgwm7/VbzrcEPKGkiIWs=
X-Received: by 2002:a2e:80d7:0:b0:2b6:d63d:cc1e with SMTP id
 r23-20020a2e80d7000000b002b6d63dcc1emr477626ljg.51.1690825834895; Mon, 31 Jul
 2023 10:50:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230719-mcrc-upstream-v1-0-dc8798a24c47@ti.com> <20230719-mcrc-upstream-v1-3-dc8798a24c47@ti.com>
In-Reply-To: <20230719-mcrc-upstream-v1-3-dc8798a24c47@ti.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 31 Jul 2023 19:50:23 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHpLsPU1p0eoW0meCx-NGP7bgD2ZzQkgX4OUssGdONSnA@mail.gmail.com>
Message-ID: <CAMj1kXHpLsPU1p0eoW0meCx-NGP7bgD2ZzQkgX4OUssGdONSnA@mail.gmail.com>
Subject: Re: [PATCH 3/5] crypto: ti - add driver for MCRC64 engine
To:     Kamlesh Gurudasani <kamlesh@ti.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Jul 2023 at 20:56, Kamlesh Gurudasani <kamlesh@ti.com> wrote:
>
> Add support for MCRC64 engine to calculate 64-bit CRC in Full-CPU mode.
>
> In Full-CPU mode, the CPU does the data patterns transfer and signature
> verification all by itself, only CRC calculation is being done by MCRC64
> engine.
>
> MCRC64 engine calculates 64-bit cyclic redundancy checks (CRC)
> according to the ISO 3309 standard.
>
> Generator polynomial: x^64 + x^4 + x^3 + x + 1
> Polynomial value: 0x000000000000001b
>
> Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
> ---
>  MAINTAINERS                |   2 +
>  drivers/crypto/Kconfig     |   1 +
>  drivers/crypto/Makefile    |   1 +
>  drivers/crypto/ti/Kconfig  |  10 +++
>  drivers/crypto/ti/Makefile |   2 +
>  drivers/crypto/ti/mcrc64.c | 360 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 376 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d8680f6969e3..a2f50adb51ac 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21464,8 +21464,10 @@ F:     drivers/iio/adc/ti-lmp92064.c
>
>  TI MEMORY CYCLIC REDUNDANCY CHECK (MCRC64) DRIVER
>  M:     Kamlesh Gurudasani <kamlesh@ti.com>
> +L:     linux-crypto@vger.kernel.org
>  S:     Maintained
>  F:     Documentation/devicetree/bindings/crypto/ti,mcrc64.yaml
> +F:     drivers/crypto/ti/mcrc64.c
>
>  TI PCM3060 ASoC CODEC DRIVER
>  M:     Kirill Marinushkin <kmarinushkin@birdec.com>
> diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
> index c761952f0dc6..2101f92ead66 100644
> --- a/drivers/crypto/Kconfig
> +++ b/drivers/crypto/Kconfig
> @@ -796,5 +796,6 @@ config CRYPTO_DEV_SA2UL
>
>  source "drivers/crypto/aspeed/Kconfig"
>  source "drivers/crypto/starfive/Kconfig"
> +source "drivers/crypto/ti/Kconfig"
>
>  endif # CRYPTO_HW
> diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
> index d859d6a5f3a4..f1a151b73ff1 100644
> --- a/drivers/crypto/Makefile
> +++ b/drivers/crypto/Makefile
> @@ -41,6 +41,7 @@ obj-$(CONFIG_CRYPTO_DEV_SAHARA) += sahara.o
>  obj-$(CONFIG_CRYPTO_DEV_SL3516) += gemini/
>  obj-y += stm32/
>  obj-$(CONFIG_CRYPTO_DEV_TALITOS) += talitos.o
> +obj-$(CONFIG_ARCH_K3) += ti/
>  obj-$(CONFIG_CRYPTO_DEV_VIRTIO) += virtio/
>  obj-$(CONFIG_CRYPTO_DEV_VMX) += vmx/
>  obj-$(CONFIG_CRYPTO_DEV_BCM_SPU) += bcm/
> diff --git a/drivers/crypto/ti/Kconfig b/drivers/crypto/ti/Kconfig
> new file mode 100644
> index 000000000000..8e3b2b8b7623
> --- /dev/null
> +++ b/drivers/crypto/ti/Kconfig
> @@ -0,0 +1,10 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config CRYPTO_DEV_TI_MCRC64
> +       tristate "Support for TI MCRC64 crc64 accelerators"
> +       depends on ARCH_K3
> +       select CRYPTO_HASH
> +       help
> +         This enables support for the MCRC64 hw accelerator
> +         which can be found on TI SOC.
> +         MCRC64 engine calculates 64-bit cyclic redundancy checks (CRC)
> +         according to the ISO 3309 standard using Full-CPU mode.
> \ No newline at end of file
> diff --git a/drivers/crypto/ti/Makefile b/drivers/crypto/ti/Makefile
> new file mode 100644
> index 000000000000..94ffc2576137
> --- /dev/null
> +++ b/drivers/crypto/ti/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +obj-$(CONFIG_CRYPTO_DEV_TI_MCRC64) += mcrc64.o
> diff --git a/drivers/crypto/ti/mcrc64.c b/drivers/crypto/ti/mcrc64.c
> new file mode 100644
> index 000000000000..45f8ae6078ff
> --- /dev/null
> +++ b/drivers/crypto/ti/mcrc64.c
> @@ -0,0 +1,360 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) Texas Instruments 2023 - http://www.ti.com
> + * Author: Kamlesh Gurudasani <kamlesh@ti.com>
> + */
> +
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +
> +#include <crypto/internal/hash.h>
> +
> +#include <asm/unaligned.h>
> +
> +#define DRIVER_NAME            "mcrc64"
> +#define CHKSUM_DIGEST_SIZE     8
> +#define CHKSUM_BLOCK_SIZE      1
> +
> +/* Registers */
> +#define CRC_CTRL0 0x0000 /* CRC Global Control Register 0 */
> +#define CH_PSA_SWRE(ch) BIT(((ch) - 1) << 3) /* PSA Software Reset  */
> +
> +#define CRC_CTRL1 0x0008 /* CRC Global Control Register 1 */
> +#define PWDN BIT(0) /* Power Down  */
> +
> +#define CRC_CTRL2 0x0010 /* CRC Global Control Register 2 */
> +#define CH_MODE(ch, m) ((m) << (((ch) - 1) << 3))
> +
> +#define PSA_SIGREGL(ch) ((0x6 + (4 * ((ch) - 1))) << 4) /* Signature register */
> +
> +#define MCRC64_ALG_MASK 0x8000000000000000
> +#define MCRC64_CRC64_POLY 0x000000000000001b
> +
> +#define MCRC64_AUTOSUSPEND_DELAY       50
> +
> +static struct device *mcrc64_k3_dev;
> +
> +enum mcrc64_mode {
> +       MCRC64_MODE_DATA_CAPTURE = 0,
> +       MCRC64_MODE_AUTO,
> +       MCRC64_MODE_SEMI_CPU,
> +       MCRC64_MODE_FULL_CPU,
> +       MCRC64_MODE_INVALID,
> +};
> +
> +enum mcrc64_channel {
> +       MCRC64_CHANNEL_1 = 1,
> +       MCRC64_CHANNEL_2,
> +       MCRC64_CHANNEL_3,
> +       MCRC64_CHANNEL_4,
> +       MCRC64_CHANNEL_INVALID,
> +};
> +
> +struct mcrc64_data {
> +       struct device    *dev;
> +       void __iomem     *regs;
> +};
> +
> +struct mcrc64_ctx {
> +       u32 key;
> +};
> +
> +struct mcrc64_desc_ctx {
> +       u64    signature;
> +};
> +
> +static int mcrc64_set_mode(void __iomem *regs, u32 channel, u32 mode)
> +{
> +       u32 mode_set_val;
> +       u32 crc_ctrl2_reg = 0;
> +
> +       if (mode < 0 || mode >= MCRC64_MODE_INVALID)
> +               return -EINVAL;
> +
> +       if (channel <= 0 || channel >= MCRC64_CHANNEL_INVALID)
> +               return -EINVAL;
> +
> +       mode_set_val = crc_ctrl2_reg | CH_MODE(channel, mode);
> +
> +       /* Write CRC_CTRL2, set mode */
> +       writel_relaxed(mode_set_val, regs + CRC_CTRL2);
> +
> +       return 0;
> +}
> +
> +static int mcrc64_reset_signature(void __iomem *regs, u32 channel)
> +{
> +       u32 crc_ctrl0_reg, reset_val, reset_undo_val;
> +
> +       if (channel <= 0 || channel >= MCRC64_CHANNEL_INVALID)
> +               return -EINVAL;
> +
> +       /* reset PSA */
> +       crc_ctrl0_reg = readl_relaxed(regs + CRC_CTRL0);
> +
> +       reset_val = crc_ctrl0_reg | CH_PSA_SWRE(channel);
> +       reset_undo_val = crc_ctrl0_reg & ~CH_PSA_SWRE(channel);
> +
> +       /* Write CRC_CTRL0 register, reset PSA register */
> +       writel_relaxed(reset_val, regs + CRC_CTRL0);
> +       writel_relaxed(reset_undo_val, regs + CRC_CTRL0);
> +
> +       return 0;
> +}
> +
> +/* This helper implements crc64 calculation using CPU */
> +static u64 mcrc64_calculate_sw_crc(u64 crc, u8 byte)
> +{
> +       u64 bit = 0;
> +       u8 j;
> +
> +       for (j = 0; j < 8; j++) {
> +               bit = crc & MCRC64_ALG_MASK;
> +               crc <<= 1;
> +               if (byte & (0x80 >> j))
> +                       bit ^= MCRC64_ALG_MASK;
> +               if (bit)
> +                       crc ^= MCRC64_CRC64_POLY;
> +       }
> +
> +       return crc;
> +}
> +
> +static int mcrc64_calculate_crc(void __iomem *regs, u32 channel,
> +                               const u8 *d8, size_t length, u64 *crc64)
> +{
> +       void __iomem *psa_reg;
> +       u64 signature = 0;
> +
> +       if (channel <= 0 || channel >= MCRC64_CHANNEL_INVALID)
> +               return -EINVAL;
> +
> +       psa_reg = regs + PSA_SIGREGL(channel);
> +
> +       for (; length >= sizeof(u64); d8 += sizeof(u64), length -= sizeof(u64))
> +               writeq_relaxed(cpu_to_be64p((u64 *)d8), psa_reg);
> +
> +       signature = readq_relaxed(psa_reg);
> +
> +       if (length) {
> +               while (length--)
> +                       signature = mcrc64_calculate_sw_crc(signature, *d8++);
> +
> +               /* set capture mode */
> +               int ret = mcrc64_set_mode(regs, MCRC64_CHANNEL_1,
> +                                       MCRC64_MODE_DATA_CAPTURE);
> +               if (ret)
> +                       return ret;
> +
> +               ret = mcrc64_reset_signature(regs, MCRC64_CHANNEL_1);
> +               if (ret)
> +                       return ret;
> +
> +               writeq_relaxed(signature, psa_reg);
> +
> +               ret = mcrc64_set_mode(regs, MCRC64_CHANNEL_1,
> +                                     MCRC64_MODE_FULL_CPU);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       *crc64 = signature;
> +
> +       return 0;
> +}
> +
> +static int mcrc64_cra_init(struct crypto_tfm *tfm)
> +{
> +       struct mcrc64_ctx *mctx = crypto_tfm_ctx(tfm);
> +
> +       struct mcrc64_data *dev_data = dev_get_drvdata(mcrc64_k3_dev);
> +
> +       pm_runtime_get_sync(dev_data->dev);
> +
> +       mctx->key = 0;
> +
> +       return 0;
> +}
> +
> +static void mcrc64_cra_exit(struct crypto_tfm *tfm)
> +{
> +       struct mcrc64_data *dev_data = dev_get_drvdata(mcrc64_k3_dev);
> +
> +       pm_runtime_mark_last_busy(dev_data->dev);
> +       pm_runtime_put_autosuspend(dev_data->dev);
> +}
> +
> +static int mcrc64_setkey(struct crypto_shash *tfm, const u8 *key,
> +                        unsigned int keylen)
> +{
> +       struct mcrc64_ctx *mctx = crypto_shash_ctx(tfm);
> +
> +       if (keylen != sizeof(u32))
> +               return -EINVAL;
> +
> +       mctx->key = get_unaligned_le32(key);
> +

What is the point of this key?


> +       return 0;
> +}
> +
> +static int mcrc64_init(struct shash_desc *desc)
> +{
> +       struct mcrc64_data *dev_data = dev_get_drvdata(mcrc64_k3_dev);
> +
> +       /* set full cpu mode */
> +       int ret = mcrc64_set_mode(dev_data->regs, MCRC64_CHANNEL_1,
> +                               MCRC64_MODE_FULL_CPU);
> +       if (ret)
> +               return ret;
> +
> +       /* reset PSA */
> +       return mcrc64_reset_signature(dev_data->regs, MCRC64_CHANNEL_1);
> +}
> +
> +static int mcrc64_update(struct shash_desc *desc, const u8 *d8,
> +                        unsigned int length)
> +{
> +       struct mcrc64_desc_ctx *ctx = shash_desc_ctx(desc);
> +       struct mcrc64_data *dev_data = dev_get_drvdata(mcrc64_k3_dev);
> +
> +       return mcrc64_calculate_crc(dev_data->regs, MCRC64_CHANNEL_1,
> +                                 d8, length, &ctx->signature);
> +}
> +
> +static int mcrc64_final(struct shash_desc *desc, u8 *out)
> +{
> +       struct mcrc64_desc_ctx *ctx = shash_desc_ctx(desc);
> +
> +       /* Send computed CRC */
> +       put_unaligned_le64(ctx->signature, out);
> +       return 0;
> +}
> +
> +static int mcrc64_finup(struct shash_desc *desc, const u8 *data,
> +                       unsigned int length, u8 *out)
> +{
> +       return mcrc64_update(desc, data, length) ?:
> +               mcrc64_final(desc, out);
> +}
> +
> +static int mcrc64_digest(struct shash_desc *desc, const u8 *data,
> +                        unsigned int length, u8 *out)
> +{
> +       return mcrc64_init(desc) ?: mcrc64_finup(desc, data, length, out);
> +}
> +
> +static struct shash_alg algs[] = {
> +       /* CRC-64 */
> +       {
> +               .setkey         = mcrc64_setkey,
> +               .init           = mcrc64_init,
> +               .update         = mcrc64_update,
> +               .final          = mcrc64_final,
> +               .finup          = mcrc64_finup,
> +               .digest         = mcrc64_digest,
> +               .descsize       = sizeof(struct mcrc64_desc_ctx),
> +               .digestsize     = CHKSUM_DIGEST_SIZE,
> +               .base           = {
> +                       .cra_name               = "crc64-iso",
> +                       .cra_driver_name        = "mcrc64",
> +                       .cra_priority           = 200,
> +                       .cra_flags              = CRYPTO_ALG_OPTIONAL_KEY,
> +                       .cra_blocksize          = CHKSUM_BLOCK_SIZE,
> +                       .cra_alignmask          = 7,
> +                       .cra_ctxsize            = sizeof(struct mcrc64_ctx),
> +                       .cra_module             = THIS_MODULE,
> +                       .cra_init               = mcrc64_cra_init,
> +                       .cra_exit               = mcrc64_cra_exit,
> +               }
> +       }
> +};
> +
> +static int mcrc64_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct mcrc64_data *dev_data;
> +
> +       dev_data = devm_kzalloc(dev, sizeof(*dev_data), GFP_KERNEL);
> +       if (!dev_data)
> +               return -ENOMEM;
> +
> +       mcrc64_k3_dev = dev;
> +       dev_data->dev = dev;
> +       dev_data->regs = devm_platform_ioremap_resource(pdev, 0);
> +
> +       platform_set_drvdata(pdev, dev_data);
> +       dev_set_drvdata(mcrc64_k3_dev, dev_data);
> +
> +       crypto_register_shashes(algs, ARRAY_SIZE(algs));
> +
> +       pm_runtime_set_autosuspend_delay(dev, MCRC64_AUTOSUSPEND_DELAY);
> +       pm_runtime_use_autosuspend(dev);
> +
> +       pm_runtime_get_noresume(dev);
> +       pm_runtime_set_active(dev);
> +       pm_runtime_enable(dev);
> +
> +       pm_runtime_put_sync(dev);
> +
> +       return 0;
> +}
> +
> +static int mcrc64_remove(struct platform_device *pdev)
> +{
> +       struct mcrc64_data *dev_data = platform_get_drvdata(pdev);
> +
> +       int ret = pm_runtime_get_sync(dev_data->dev);
> +
> +       if (ret < 0) {
> +               pm_runtime_put_noidle(dev_data->dev);
> +               return ret;
> +       }
> +
> +       crypto_unregister_shashes(algs, ARRAY_SIZE(algs));
> +
> +       pm_runtime_disable(dev_data->dev);
> +       pm_runtime_put_noidle(dev_data->dev);
> +
> +       return 0;
> +}
> +
> +static int __maybe_unused mcrc64_suspend(struct device *dev)
> +{
> +       return  pm_runtime_force_suspend(dev);
> +}
> +
> +static int __maybe_unused mcrc64_resume(struct device *dev)
> +{
> +       return pm_runtime_force_resume(dev);
> +}
> +
> +static const struct dev_pm_ops mcrc64_pm_ops = {
> +       SET_SYSTEM_SLEEP_PM_OPS(mcrc64_suspend,
> +                               mcrc64_resume)
> +};
> +
> +static const struct of_device_id of_match[] = {
> +       { .compatible = "ti,mcrc64", },
> +       {},
> +};
> +MODULE_DEVICE_TABLE(of, of_match);
> +
> +static struct platform_driver mcrc64_driver = {
> +       .probe  = mcrc64_probe,
> +       .remove = mcrc64_remove,
> +       .driver = {
> +               .name           = DRIVER_NAME,
> +               .pm             = &mcrc64_pm_ops,
> +               .of_match_table = of_match,
> +       },
> +};
> +
> +module_platform_driver(mcrc64_driver);
> +
> +MODULE_AUTHOR("Kamlesh Gurudasani <kamlesh@ti.com>");
> +MODULE_DESCRIPTION("Texas Instruments MCRC64 hardware driver");
> +MODULE_LICENSE("GPL");
>
> --
> 2.34.1
>
