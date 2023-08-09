Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096507756D2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 12:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbjHIKJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 06:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjHIKJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 06:09:19 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CF61FD6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 03:09:18 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d44c2ca78ceso1082990276.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 03:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691575758; x=1692180558;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kRBBB72Xo69T0OElGoYsRuiUCmdlEmov0FVADVHXFyg=;
        b=JAxH3YPWYi4xNEfMyew1y0fJU6S3WH9fG3+i2rNMsoN+we0EEVQNsvxaBgioK1CMgW
         nJ9K+JFDZx11FqBW0wU2q+BvQeZZvYrTnZFnibxca7Z+A3P6HoZrPSHGO93oPKSXcAdh
         qyV8sDu5UFv6Zpc/bCHNXQ4Wj6QT8wOSMMcuDeM1g5ciPqI+vxle6bUjfSvEFLgEF+rL
         kmKTis7EBkhx8y0Ylf/FlehJNm0yJSFFagZ80Z3ycj+6fbJOkBwcYvMg+hLtSCLv7Gcg
         VPosQ9ajcvXetcMNqbXPa5utZBfQx1WhhH2LUepoh4Swgper3qy1CXSi3UaqPFKm8r/m
         KVaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691575758; x=1692180558;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kRBBB72Xo69T0OElGoYsRuiUCmdlEmov0FVADVHXFyg=;
        b=XHJx5oH6tqc1qoVTKn35eeq1Ynojv5Dl0KP5GkYve3GqOus6UeTZI4PGpzrfuODOan
         mtFqo6kP0lDbUxpOeGZ3qDsbVW30F6S62Avwk/nNRVWGmPcb0o9u89IY/uxe2TRV8IVJ
         gtBppjLx/igJsfNG50hSGhyZVFdpd+7imPthNQ/FKIs7V0vGLfoxqM3I2zFK6VPYcxdw
         QAqe6OtsNqldRH2fyKkXC5jEtFOa3Pk4GA4gMYVhcAv01rWCEAvDVs9uXgY3D375RiYf
         R/GzGxAT4QgIp6hA5sUpCZZZwMdhLWDARcT4U8PB4vQgNq5TV4AW9UNOKtYcaRkR6qoT
         1dYw==
X-Gm-Message-State: AOJu0YxQfC60ozdx+D7nkx9/j2irs3qZo/C1wSal7KwY/0O8wy0pk+6R
        T/5Aqy3e0L7M00LtWoXQ5ufkp7r+SyuPLb/8rr4myQ==
X-Google-Smtp-Source: AGHT+IHJSSi19qUsX44JVBSz7ym7Yn+t4tELB3+w2VWQHTlSXnat5hS/Z+XvN2H6ZVQI3H5/kyhYIx+Q9jGZxy351AY=
X-Received: by 2002:a25:aca6:0:b0:d40:3069:b3b1 with SMTP id
 x38-20020a25aca6000000b00d403069b3b1mr12852982ybi.17.1691575757838; Wed, 09
 Aug 2023 03:09:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230809052952.323-1-wenchao.chen@unisoc.com>
In-Reply-To: <20230809052952.323-1-wenchao.chen@unisoc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 9 Aug 2023 12:08:41 +0200
Message-ID: <CAPDyKFoykxdP70t2pjeiX0pkKuUCZ2AeFM4yT4-wfVijxB7OHw@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Add host specific tuning support for SD HS mode
To:     Wenchao Chen <wenchao.chen@unisoc.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, wenchao.chen666@gmail.com,
        zhenxiong.lai@unisoc.com, chunyan.zhang@unisoc.com,
        yuelin.tang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Aug 2023 at 07:30, Wenchao Chen <wenchao.chen@unisoc.com> wrote:
>
> Added .prepare_hs_tuning and .execute_hs_tuning host
> callbacks to support host-specific tuning for SD high
> speed mode.

This certainly needs to be clarified more. Especially why it's needed
for the sdhci-sprd variant.

>
> Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
> ---
>  drivers/mmc/core/sd.c         |  12 ++++
>  drivers/mmc/host/sdhci-sprd.c | 124 ++++++++++++++++++++++++++++++++++
>  include/linux/mmc/host.h      |   6 ++
>  3 files changed, 142 insertions(+)
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 246ce027ae0a..ac2da8f2fbce 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -1518,6 +1518,12 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
>                  */
>                 mmc_set_clock(host, mmc_sd_get_max_clock(card));
>
> +               if (host->ops->prepare_hs_tuning) {
> +                       err = host->ops->prepare_hs_tuning(host, card);
> +                       if (err)
> +                               goto free_card;
> +               }

Adding a new callback for this is a bit questionable, I think.

In the ->set_ios() callback, we could instead check MMC_TIMING_SD_HS
and when the clock is updated, then also run a tuning sequence, right?

> +
>                 /*
>                  * Switch to wider bus (if supported).
>                  */
> @@ -1529,6 +1535,12 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
>
>                         mmc_set_bus_width(host, MMC_BUS_WIDTH_4);
>                 }
> +
> +               if (host->ops->execute_hs_tuning) {
> +                       err = host->ops->execute_hs_tuning(host, card);
> +                       if (err)
> +                               goto free_card;
> +               }

Similar to the above comment, in the ->set_ios() callback we could
instead check MMC_TIMING_SD_HS when moving to MMC_BUS_WIDTH_4, then
run a tuning sequence, right?

>         }
>  cont:
>         if (!oldcard) {
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index 7f4ee2e12735..5f365dcbb9c7 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -9,6 +9,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/highmem.h>
>  #include <linux/iopoll.h>
> +#include <linux/mmc/mmc.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> @@ -22,6 +23,9 @@
>  #include "sdhci-pltfm.h"
>  #include "mmc_hsq.h"
>
> +#include "../core/mmc_ops.h"
> +#include "../core/sd_ops.h"

No, this isn't how we include header files. Instead move the functions
that you may need to include/linux/mmc/host.h.

Also, please split up core changes from host driver changes.

> +
>  /* SDHCI_ARGUMENT2 register high 16bit */
>  #define SDHCI_SPRD_ARG2_STUFF          GENMASK(31, 16)
>
> @@ -73,6 +77,11 @@
>  #define SDHCI_SPRD_CLK_DEF_RATE                26000000
>  #define SDHCI_SPRD_PHY_DLL_CLK         52000000
>
> +#define SDHCI_SPRD_MAX_PHASE           0xff
> +#define SDHCI_SPRD_CMD_DLY_MASK                GENMASK(15, 8)
> +#define SDHCI_SPRD_POSRD_DLY_MASK      GENMASK(23, 16)
> +#define SDHCI_SPRD_CPST_EN             GENMASK(27, 24)
> +
>  struct sdhci_sprd_host {
>         u32 version;
>         struct clk *clk_sdio;
> @@ -86,6 +95,11 @@ struct sdhci_sprd_host {
>         u32 phy_delay[MMC_TIMING_MMC_HS400 + 2];
>  };
>
> +enum sdhci_sprd_tuning_type {
> +       SDHCI_SPRD_TUNING_SD_HS_CMD,
> +       SDHCI_SPRD_TUNING_SD_HS_DATA,
> +};
> +
>  struct sdhci_sprd_phy_cfg {
>         const char *property;
>         u8 timing;
> @@ -533,6 +547,111 @@ static void sdhci_sprd_hs400_enhanced_strobe(struct mmc_host *mmc,
>                      SDHCI_SPRD_REG_32_DLL_DLY);
>  }
>
> +static int mmc_send_tuning_cmd(struct mmc_card *card)
> +{
> +       return mmc_send_status(card, NULL);
> +}
> +
> +static int mmc_send_tuning_data(struct mmc_card *card)
> +{
> +       u8 status[64];

We use kmalloc-ed data for data transfers.

> +
> +       return mmc_sd_switch(card, 0, 0, 0, status);
> +}
> +
> +static int sdhci_sprd_tuning(struct mmc_host *mmc, struct mmc_card *card,
> +                       enum sdhci_sprd_tuning_type type)
> +{
> +       struct sdhci_host *host = mmc_priv(mmc);
> +       struct sdhci_sprd_host *sprd_host = TO_SPRD_HOST(host);
> +       u32 *p = sprd_host->phy_delay;
> +       int err = 0;
> +       int i;
> +       bool value;
> +       int final_phase;
> +       u32 dll_cfg, dll_dly;
> +       int range_end = SDHCI_SPRD_MAX_PHASE;
> +       int len = 0;
> +       int count = 0;
> +
> +       sdhci_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
> +
> +       dll_cfg = sdhci_readl(host, SDHCI_SPRD_REG_32_DLL_CFG);
> +       dll_cfg &= ~SDHCI_SPRD_CPST_EN;
> +       sdhci_writel(host, dll_cfg, SDHCI_SPRD_REG_32_DLL_CFG);
> +
> +       dll_dly = p[mmc->ios.timing];
> +
> +       for (i = 0; i <= SDHCI_SPRD_MAX_PHASE; i++) {
> +               if (type == SDHCI_SPRD_TUNING_SD_HS_CMD) {
> +                       dll_dly &= ~SDHCI_SPRD_CMD_DLY_MASK;
> +                       dll_dly |= ((i << 8) & SDHCI_SPRD_CMD_DLY_MASK);
> +               } else {
> +                       dll_dly &= ~SDHCI_SPRD_POSRD_DLY_MASK;
> +                       dll_dly |= ((i << 16) & SDHCI_SPRD_POSRD_DLY_MASK);
> +               }
> +
> +               sdhci_writel(host, dll_dly, SDHCI_SPRD_REG_32_DLL_DLY);
> +
> +               if (type == SDHCI_SPRD_TUNING_SD_HS_CMD)
> +                       value = !mmc_send_tuning_cmd(card);
> +               else
> +                       value = !mmc_send_tuning_data(card);
> +
> +               if (value) {
> +                       dev_dbg(mmc_dev(host->mmc), "tuning ok: %d\n", i);
> +                       count++;
> +               } else {
> +                       dev_dbg(mmc_dev(host->mmc), "tuning fail: %d\n", i);
> +                       if (len < count) {
> +                               len = count;
> +                               range_end = i - 1;
> +                               count = 0;
> +                       }
> +               }
> +       }
> +
> +       if (!count) {
> +               final_phase = 0;
> +               dev_err(mmc_dev(host->mmc), "all tuning phase fail!\n");
> +               err = -EIO;
> +               goto out;
> +       }
> +
> +       if (count > len) {
> +               len = count;
> +               range_end = i - 1;
> +       }
> +
> +       final_phase = range_end - (len - 1) / 2;

The whole len, count, range_end, final_phase things look rather messy.
Please have a look and try to clean up that part a bit, I am sure it
can be done, somehow.

> +
> +       if (type == SDHCI_SPRD_TUNING_SD_HS_CMD) {
> +               p[mmc->ios.timing] &= ~SDHCI_SPRD_CMD_DLY_MASK;
> +               p[mmc->ios.timing] |= ((final_phase << 8) & SDHCI_SPRD_CMD_DLY_MASK);
> +       } else {
> +               p[mmc->ios.timing] &= ~(SDHCI_SPRD_POSRD_DLY_MASK);
> +               p[mmc->ios.timing] |= ((final_phase << 16) & SDHCI_SPRD_POSRD_DLY_MASK);
> +       }
> +
> +       dev_info(mmc_dev(host->mmc), "the best step %d, phase 0x%02x, delay value 0x%08x\n",
> +                       final_phase, final_phase, p[mmc->ios.timing]);

Does this really deserve to be a dev_info? Looks like a dev_dbg to me, no?

> +
> +out:
> +       sdhci_writel(host, p[mmc->ios.timing], SDHCI_SPRD_REG_32_DLL_DLY);
> +
> +       return err;
> +}
> +
> +static int sdhci_sprd_prepare_hs_cmd_tuning(struct mmc_host *mmc, struct mmc_card *card)
> +{
> +       return sdhci_sprd_tuning(mmc, card, SDHCI_SPRD_TUNING_SD_HS_CMD);
> +}
> +
> +static int sdhci_sprd_execute_hs_data_tuning(struct mmc_host *mmc, struct mmc_card *card)
> +{
> +       return sdhci_sprd_tuning(mmc, card, SDHCI_SPRD_TUNING_SD_HS_DATA);
> +}
> +
>  static void sdhci_sprd_phy_param_parse(struct sdhci_sprd_host *sprd_host,
>                                        struct device_node *np)
>  {
> @@ -577,6 +696,11 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
>         host->mmc_host_ops.request = sdhci_sprd_request;
>         host->mmc_host_ops.hs400_enhanced_strobe =
>                 sdhci_sprd_hs400_enhanced_strobe;
> +       host->mmc_host_ops.prepare_hs_tuning =
> +               sdhci_sprd_prepare_hs_cmd_tuning;
> +       host->mmc_host_ops.execute_hs_tuning =
> +               sdhci_sprd_execute_hs_data_tuning;
> +
>         /*
>          * We can not use the standard ops to change and detect the voltage
>          * signal for Spreadtrum SD host controller, since our voltage regulator
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 461d1543893b..13cf894b9e3c 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -184,6 +184,12 @@ struct mmc_host_ops {
>         /* Execute HS400 tuning depending host driver */
>         int     (*execute_hs400_tuning)(struct mmc_host *host, struct mmc_card *card);
>
> +       /* Prepare HS tuning depending host driver */
> +       int     (*prepare_hs_tuning)(struct mmc_host *host, struct mmc_card *card);
> +
> +       /* Execute HS tuning depending host driver */
> +       int     (*execute_hs_tuning)(struct mmc_host *host, struct mmc_card *card);
> +
>         /* Prepare switch to DDR during the HS400 init sequence */
>         int     (*hs400_prepare_ddr)(struct mmc_host *host);
>

Kind regards
Uffe
