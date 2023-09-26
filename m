Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03277AEA69
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 12:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234400AbjIZKaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 06:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234404AbjIZKaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 06:30:30 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD12127
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 03:30:22 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d8198ca891fso9298931276.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 03:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695724221; x=1696329021; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Zs6EsaFrBTKV0IZZFceNWjelEHVonwomtwZivcGV1MQ=;
        b=lU80vkHh31axo5iGUE+vnHZ2qpgTXZxTiq0ybyQxpGdw0I9zBfnIQPcEyOmZBL6+Ks
         hdLVwQak6McJzhKwT3RH0wSbl7Er17VedMwP0W8hTXSBjCIXvS8dcf0+53eCZ8W5DXm5
         6RTA2v771ry3b7d6bJ3EoDVaNE7vdhf2TPiMJ3cNmEAGBPi88rC/G2xS9DOhivwFUzS7
         MlnyVgmJuLsBCqmG4ZMzXJPsAmFXw4bq6Hnq4fgQqRe420GafiuVjfUqfGQqZ8IDMW4N
         rGq0FKCbuO/Y++SuOfZJIMssJDs8ZB3L2q6ZeJ+kdCNckyI+JQnKhJDXrTyvSU2R+pzB
         IRXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695724221; x=1696329021;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zs6EsaFrBTKV0IZZFceNWjelEHVonwomtwZivcGV1MQ=;
        b=RAUgkG7HGFRT5+jZhWKf6X9jLaMRARmWRkipnwVU3BCrn8neCI+azxK99pGabJf7LW
         870+Hnh4ypottlhNkI9yUIpBFHLSvN7SbiTqMCGP3mIpXjHW72P5gW87cVJEWtNCzeg4
         GpVugWtBsJlKXKPPkNjmLfkdvPGbHyIAs6wMl/hD/RXgtcsGufMXnHGchUUyYprgG8ye
         qdO9ip16EDp9zOhXI65wBLV95XeftNcUzKsWBI4WWOOnGbWCBIUwdceMTmcAEE3r+e1L
         ETzQjk3JNDILJGkfBQNJ+Ge+3rOU12DZx4IzElhdxoicZYrgerbETpi2cfKyd3vT5V8A
         AsxQ==
X-Gm-Message-State: AOJu0Yx2qb5CbKJXlpERIq6htbkrKHajWX3bvhWPqheo13CKHrOOXxWJ
        pQoMdhLCHHPmN8nBUVEdvR+mtMkR2JpyDL5C9LyW1A==
X-Google-Smtp-Source: AGHT+IHZilRoOWb3DKIhWHeylO1T8c/K+BDCkD7/mjz70rFuaPmSIWKBXiXeUcy/mHxX0LQMsysaP0GW8DLzuQYBZk0=
X-Received: by 2002:a25:d3d0:0:b0:d22:af93:1abb with SMTP id
 e199-20020a25d3d0000000b00d22af931abbmr9393570ybf.59.1695724221360; Tue, 26
 Sep 2023 03:30:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230914150904.155630-1-yann.gautier@foss.st.com>
In-Reply-To: <20230914150904.155630-1-yann.gautier@foss.st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 26 Sep 2023 12:29:45 +0200
Message-ID: <CAPDyKFrBUcqwuwVJsVi1JrG+0S=vWJ7D-BjQhjg-AU0GsbKO1Q@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: mmci: stm32: add SDIO in-band interrupt mode
To:     Yann Gautier <yann.gautier@foss.st.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Rob Herring <robh@kernel.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Sept 2023 at 17:09, Yann Gautier <yann.gautier@foss.st.com> wrote:
>
> From: Christophe Kerello <christophe.kerello@foss.st.com>
>
> Add the support of SDIO in-band interrupt mode for STM32 and Ux500
> variants.
> It allows the SD I/O card to interrupt the host on SDMMC_D1 data line.
> It is not enabled by default on Ux500 variant as this is unstable and
> Ux500 users should use out-of-band IRQs.
>
> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
> ---
> Updates on v2:
> * rename use_sdio_irq to supports_sdio_irq and change it to bool
> * use common code for ux500 and stm32 variants
>
> ---
>  drivers/mmc/host/mmci.c             | 85 +++++++++++++++++++++++++++++
>  drivers/mmc/host/mmci.h             |  7 +++
>  drivers/mmc/host/mmci_stm32_sdmmc.c |  2 +
>  3 files changed, 94 insertions(+)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index dda756a563793..65cc03ee7f23b 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -272,6 +272,7 @@ static struct variant_data variant_stm32_sdmmc = {
>         .datactrl_mask_sdio     = MCI_DPSM_ST_SDIOEN,
>         .stm32_idmabsize_mask   = GENMASK(12, 5),
>         .stm32_idmabsize_align  = BIT(5),
> +       .supports_sdio_irq      = true,
>         .busy_timeout           = true,
>         .busy_detect            = true,
>         .busy_detect_flag       = MCI_STM32_BUSYD0,
> @@ -299,6 +300,7 @@ static struct variant_data variant_stm32_sdmmcv2 = {
>         .datactrl_mask_sdio     = MCI_DPSM_ST_SDIOEN,
>         .stm32_idmabsize_mask   = GENMASK(16, 5),
>         .stm32_idmabsize_align  = BIT(5),
> +       .supports_sdio_irq      = true,
>         .dma_lli                = true,
>         .busy_timeout           = true,
>         .busy_detect            = true,
> @@ -327,6 +329,7 @@ static struct variant_data variant_stm32_sdmmcv3 = {
>         .datactrl_mask_sdio     = MCI_DPSM_ST_SDIOEN,
>         .stm32_idmabsize_mask   = GENMASK(16, 6),
>         .stm32_idmabsize_align  = BIT(6),
> +       .supports_sdio_irq      = true,
>         .dma_lli                = true,
>         .busy_timeout           = true,
>         .busy_detect            = true,
> @@ -423,6 +426,11 @@ static void mmci_write_datactrlreg(struct mmci_host *host, u32 datactrl)
>         /* Keep busy mode in DPSM if enabled */
>         datactrl |= host->datactrl_reg & host->variant->busy_dpsm_flag;
>
> +       /* Keep SD I/O interrupt mode enabled */
> +       if (host->variant->supports_sdio_irq &&
> +           host->mmc->caps & MMC_CAP_SDIO_IRQ)
> +               datactrl |= host->variant->datactrl_mask_sdio;
> +

This doesn't look entirely correct to me, as it will make the
->datactrl_mask_sdio bit to be set even when it shouldn't. If I
understand correctly, we really want the bit to be set if the SDIO
irqs has been enabled, but otherwise leave it for mmci_start_data() to
manage it, right?

That said, perhaps the comment a few lines above, deserves some
clarification too. Would rephrasing it into "Keep the SDIO mode bit if
SDIO irqs are enabled" make it more clear?

From an implementation point of view, an idea is to add a
"host->datactrl_reg_add" variable (we have this for the clk and pwr
registers already). mmci_write_datactrlreg() should then OR these bits
when writing to the register. In this way, mmci_enable_sdio_irq() can
update the host->datactrl_reg_add with ->datactrl_mask_sdio, when
needed. This should also work for the ->busy_dpsm_flag a few lines
above, I think.

>         if (host->datactrl_reg != datactrl) {
>                 host->datactrl_reg = datactrl;
>                 writel(datactrl, host->base + MMCIDATACTRL);
> @@ -817,6 +825,25 @@ static bool ux500_busy_complete(struct mmci_host *host, struct mmc_command *cmd,
>         return (host->busy_state == MMCI_BUSY_DONE);
>  }
>
> +void ux500_and_stm32_enable_sdio_irq(struct mmci_host *host, int enable)
> +{
> +       void __iomem *base = host->base;
> +       u32 mask = readl_relaxed(base + MMCIMASK0);
> +
> +       if (enable)
> +               writel_relaxed(mask | MCI_ST_SDIOITMASK, base + MMCIMASK0);
> +       else
> +               writel_relaxed(mask & ~MCI_ST_SDIOITMASK, base + MMCIMASK0);
> +}
> +
> +void ux500_and_stm32_sdio_irq(struct mmci_host *host, u32 status)
> +{
> +       if (status & MCI_ST_SDIOIT) {
> +               ux500_and_stm32_enable_sdio_irq(host, 0);
> +               sdio_signal_irq(host->mmc);
> +       }
> +}
> +
>  /*
>   * All the DMA operation mode stuff goes inside this ifdef.
>   * This assumes that you have a generic DMA device interface,
> @@ -1191,6 +1218,8 @@ static void ux500_variant_init(struct mmci_host *host)
>  {
>         host->ops = &mmci_variant_ops;
>         host->ops->busy_complete = ux500_busy_complete;
> +       host->ops->enable_sdio_irq = ux500_and_stm32_enable_sdio_irq;
> +       host->ops->sdio_irq = ux500_and_stm32_sdio_irq;
>  }
>
>  static void ux500v2_variant_init(struct mmci_host *host)
> @@ -1198,6 +1227,8 @@ static void ux500v2_variant_init(struct mmci_host *host)
>         host->ops = &mmci_variant_ops;
>         host->ops->busy_complete = ux500_busy_complete;
>         host->ops->get_datactrl_cfg = ux500v2_get_dctrl_cfg;
> +       host->ops->enable_sdio_irq = ux500_and_stm32_enable_sdio_irq;
> +       host->ops->sdio_irq = ux500_and_stm32_sdio_irq;
>  }

It looks to me that the extra layer of mmci variant callbacks is a bit
"heavy" at this point. ux500 and the st variants seem to work very
similarly in this regard. So maybe just the mmci_ops callbacks
directly and stick to the mmci* prefix of the function names. At least
until we see a better reason to have the extra layer of callbacks.

Of course, this also means that we need to assign
mmci_ops->enable_sdio_irq|ack_sdio_irq() conditionally during probe,
based upon the variant->supports_sdio_irq bit.

>
>  static void mmci_pre_request(struct mmc_host *mmc, struct mmc_request *mrq)
> @@ -1805,6 +1836,11 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
>                         mmci_data_irq(host, host->data, status);
>                 }
>
> +               if (host->variant->supports_sdio_irq &&
> +                   host->mmc->caps & MMC_CAP_SDIO_IRQ &&

Checking the caps seems superfluous. The SDIO irqs must not be
enabled, unless MMC_CAP_SDIO_IRQ is supported, right?

> +                   host->ops && host->ops->sdio_irq)
> +                       host->ops->sdio_irq(host, status);
> +
>                 /*
>                  * Busy detection has been handled by mmci_cmd_irq() above.
>                  * Clear the status bit to prevent polling in IRQ context.
> @@ -2041,6 +2077,45 @@ static int mmci_sig_volt_switch(struct mmc_host *mmc, struct mmc_ios *ios)
>         return ret;
>  }
>
> +static void mmci_enable_sdio_irq(struct mmc_host *mmc, int enable)
> +{
> +       struct mmci_host *host = mmc_priv(mmc);
> +       unsigned long flags;
> +
> +       if (!host->variant->supports_sdio_irq)
> +               return;

According to the earlier comment above about the extra layers of
callbacks, this can then be checked during probe instead and dropped
from here.

> +
> +       if (host->ops && host->ops->enable_sdio_irq) {
> +               if (enable)
> +                       /* Keep device active while SDIO IRQ is enabled */
> +                       pm_runtime_get_sync(mmc_dev(mmc));
> +
> +               spin_lock_irqsave(&host->lock, flags);
> +               host->ops->enable_sdio_irq(host, enable);
> +               spin_unlock_irqrestore(&host->lock, flags);
> +
> +               if (!enable) {
> +                       pm_runtime_mark_last_busy(mmc_dev(mmc));
> +                       pm_runtime_put_autosuspend(mmc_dev(mmc));
> +               }
> +       }
> +}
> +
> +static void mmci_ack_sdio_irq(struct mmc_host *mmc)
> +{
> +       struct mmci_host *host = mmc_priv(mmc);
> +       unsigned long flags;
> +
> +       if (!host->variant->supports_sdio_irq)
> +               return;

Ditto.

> +
> +       if (host->ops && host->ops->enable_sdio_irq) {
> +               spin_lock_irqsave(&host->lock, flags);
> +               host->ops->enable_sdio_irq(host, 1);
> +               spin_unlock_irqrestore(&host->lock, flags);
> +       }
> +}
> +
>  static struct mmc_host_ops mmci_ops = {
>         .request        = mmci_request,
>         .pre_req        = mmci_pre_request,
> @@ -2049,6 +2124,8 @@ static struct mmc_host_ops mmci_ops = {
>         .get_ro         = mmc_gpio_get_ro,
>         .get_cd         = mmci_get_cd,
>         .start_signal_voltage_switch = mmci_sig_volt_switch,
> +       .enable_sdio_irq = mmci_enable_sdio_irq,
> +       .ack_sdio_irq   = mmci_ack_sdio_irq,
>  };
>
>  static void mmci_probe_level_translator(struct mmc_host *mmc)
> @@ -2316,6 +2393,14 @@ static int mmci_probe(struct amba_device *dev,
>                 mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
>         }
>
> +       if (variant->supports_sdio_irq && host->mmc->caps & MMC_CAP_SDIO_IRQ) {
> +               mmc->caps2 |= MMC_CAP2_SDIO_IRQ_NOTHREAD;
> +
> +               if (variant->datactrl_mask_sdio)
> +                       mmci_write_datactrlreg(host,
> +                                              host->variant->datactrl_mask_sdio);

As I stated earlier, it looks to me that this should be managed when
enabling/disabling the SDIO irqs and not during probe. No?

> +       }
> +
>         /* Variants with mandatory busy timeout in HW needs R1B responses. */
>         if (variant->busy_timeout)
>                 mmc->caps |= MMC_CAP_NEED_RSP_BUSY;
> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> index 253197f132fca..5ea4975c18ec5 100644
> --- a/drivers/mmc/host/mmci.h
> +++ b/drivers/mmc/host/mmci.h
> @@ -331,6 +331,7 @@ enum mmci_busy_state {
>   *            register.
>   * @opendrain: bitmask identifying the OPENDRAIN bit inside MMCIPOWER register
>   * @dma_lli: true if variant has dma link list feature.
> + * @supports_sdio_irq: allow SD I/O card to interrupt the host
>   * @stm32_idmabsize_mask: stm32 sdmmc idma buffer size.
>   */
>  struct variant_data {
> @@ -376,6 +377,7 @@ struct variant_data {
>         u32                     start_err;
>         u32                     opendrain;
>         u8                      dma_lli:1;
> +       bool                    supports_sdio_irq;
>         u32                     stm32_idmabsize_mask;
>         u32                     stm32_idmabsize_align;
>         void (*init)(struct mmci_host *host);
> @@ -400,6 +402,8 @@ struct mmci_host_ops {
>         bool (*busy_complete)(struct mmci_host *host, struct mmc_command *cmd, u32 status, u32 err_msk);
>         void (*pre_sig_volt_switch)(struct mmci_host *host);
>         int (*post_sig_volt_switch)(struct mmci_host *host, struct mmc_ios *ios);
> +       void (*enable_sdio_irq)(struct mmci_host *host, int enable);
> +       void (*sdio_irq)(struct mmci_host *host, u32 status);
>  };
>
>  struct mmci_host {
> @@ -481,6 +485,9 @@ void mmci_dmae_finalize(struct mmci_host *host, struct mmc_data *data);
>  void mmci_dmae_error(struct mmci_host *host);
>  #endif
>
> +void ux500_and_stm32_enable_sdio_irq(struct mmci_host *host, int enable);
> +void ux500_and_stm32_sdio_irq(struct mmci_host *host, u32 status);
> +
>  #ifdef CONFIG_MMC_QCOM_DML
>  void qcom_variant_init(struct mmci_host *host);
>  #else
> diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
> index 35067e1e6cd80..fbfaa0bcec51e 100644
> --- a/drivers/mmc/host/mmci_stm32_sdmmc.c
> +++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
> @@ -681,6 +681,8 @@ static struct mmci_host_ops sdmmc_variant_ops = {
>         .busy_complete = sdmmc_busy_complete,
>         .pre_sig_volt_switch = sdmmc_pre_sig_volt_vswitch,
>         .post_sig_volt_switch = sdmmc_post_sig_volt_switch,
> +       .enable_sdio_irq = ux500_and_stm32_enable_sdio_irq,
> +       .sdio_irq = ux500_and_stm32_sdio_irq,
>  };
>
>  static struct sdmmc_tuning_ops dlyb_tuning_mp15_ops = {
> --
> 2.34.1
>

Kind regards
Uffe
