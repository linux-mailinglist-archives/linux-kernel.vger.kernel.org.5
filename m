Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B2A7B65D1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 11:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbjJCJrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 05:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239775AbjJCJrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 05:47:04 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9257AD
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 02:46:55 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d81afd5273eso728461276.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 02:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696326415; x=1696931215; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EWXnbKCGMKRxWFwVeSaYnuznQwZrR+ai+1tVVhaF48Q=;
        b=qLodcR07eseAJ9KFLO4l7TO5J8bWWSCPQLEJXpC76aps5b7v4MMoTQ9SeTpk23+3Dx
         hw/TMP4zJAUgqVnGuAneJeMLFWx/XuwULpvpvNaljCaY6jK48VEhKrZ503+qhz7xbzxh
         HxYQPpUltsZmvF/IkltFALuhNOLNC0k4am+q7EkOU0RWME/Di462iO2aJsDsxxgFP+Fu
         CW7x97EDMJG5lwBQp4SXFI7ujG2xcAKOzj/3M+pKA7SCbYvGbkaNOV45lU+xeLABYI0b
         RxG2NfiD1/m8mFK9Kr5Wr0gEOA8KvlTRcY7JzeiGgubbhPwYNHo+pTjxtGnAmwsyz+5t
         Qvxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696326415; x=1696931215;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EWXnbKCGMKRxWFwVeSaYnuznQwZrR+ai+1tVVhaF48Q=;
        b=tBPe7R7TvACUBgQ+fFKF3PIH5fuFICiU5L90gNt/r88Zq8Tf/HOAa4iRornymK1Z9/
         B0AwteKGPC4tydThQ2lu1NeEc38i1lEH3FvYIm2IM8WDiHxGk2HXtBmDbnOcgLkxJnvN
         WukqdChxtOZGhJ5Ry9iK/U0Kl9PW+3JItxhAe5GpH5DAUaOHjRRbSo37tHXhT8lezBPz
         qNGlOByWAoXfXJpD0aZKAYkbuKROviM1QlyEEDQt6XUvxjV+I5YIi14KVlnVv556cblX
         tmNyJkrPtFDXIjQI5U3bUxVBf26KbyLtQKnXFtgbhV+KUFF8rArz6mCAJO9Mg+FeIHR/
         U5eQ==
X-Gm-Message-State: AOJu0Ywu9ol64qdb6tztcxKr4tWql+JSxuey707zsw4+CzL+/zBVwYYr
        TBF2BKFfN40iFNs7aEgshF9PgFJh5v+t5Upw9vp5UQ==
X-Google-Smtp-Source: AGHT+IGqHU/uHTRCpUjdPRgnr30EjfpfaPr7DiNzxfBFI3+32gm3A/PhdxWE9u4nN49eKa8f3LqebwyFBLilDfoN1Xc=
X-Received: by 2002:a5b:748:0:b0:d7f:13da:f773 with SMTP id
 s8-20020a5b0748000000b00d7f13daf773mr12748090ybq.6.1696326414938; Tue, 03 Oct
 2023 02:46:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230915094351.11120-1-victorshihgli@gmail.com> <20230915094351.11120-12-victorshihgli@gmail.com>
In-Reply-To: <20230915094351.11120-12-victorshihgli@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 3 Oct 2023 11:46:18 +0200
Message-ID: <CAPDyKFqpT3Z99gv=5W8sWquq8ogSjEuwyL97nqm8xZP2ce9QMw@mail.gmail.com>
Subject: Re: [PATCH V12 11/23] mmc: sdhci-uhs2: add set_power() to support vdd2
To:     Victor Shih <victorshihgli@gmail.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        takahiro.akashi@linaro.org, dlunev@chromium.org,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sept 2023 at 11:44, Victor Shih <victorshihgli@gmail.com> wrote:
>
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
>
> This is a UHS-II version of sdhci's set_power operation.
> VDD2, as well as VDD, is handled here.

Okay, but why?

Please justify the change in the commit messages, don't just tell what
is being done. This applied to the whole series - and I believe I have
said this before too.

>
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>
> Updates in V10:
>  - Move some definitions of PatchV9[05/23] to PatchV10[11/23].
>
> Updates in V9:
>  - Modify annotations in sdhci_get_vdd_value().
>
> Updates in V8:
>  - Adjust the position of matching brackets.
>  - Add the initial value of the pwr in sdhci_uhs2_set_power().
>
> Updates in V7:
>  - Add clear the power reg before setting a new value
>    in sdhci_uhs2_set_power().
>  - Add MMC_VDD_34_35 case and MMC_VDD_35_36 case in sdhci_get_vdd_value().
>  - Drop pwr variable in sdhci_get_vdd_value().
>
> Updates in V6:
>  - Add mmc_opt_regulator_set_ocr().
>  - Remove unnecessary functions.
>
> ---
>
>  drivers/mmc/host/sdhci-uhs2.c | 48 +++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci.c      | 61 +++++++++++++++++++----------------
>  drivers/mmc/host/sdhci.h      |  1 +
>  include/linux/mmc/host.h      |  1 +
>  4 files changed, 83 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index dfc80a7f1bad..fc37a34629c2 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -57,6 +57,13 @@ EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);
>   *                                                                           *
>  \*****************************************************************************/
>
> +static inline int mmc_opt_regulator_set_ocr(struct mmc_host *mmc,
> +                                           struct regulator *supply,
> +                                           unsigned short vdd_bit)
> +{
> +       return IS_ERR_OR_NULL(supply) ? 0 : mmc_regulator_set_ocr(mmc, supply, vdd_bit);
> +}
> +
>  bool sdhci_uhs2_mode(struct sdhci_host *host)
>  {
>         return host->mmc->flags & MMC_UHS2_SUPPORT;
> @@ -94,6 +101,47 @@ void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask)
>  }
>  EXPORT_SYMBOL_GPL(sdhci_uhs2_reset);
>
> +static void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode, unsigned short vdd)
> +{
> +       struct mmc_host *mmc = host->mmc;
> +       u8 pwr = 0;
> +
> +       if (mode != MMC_POWER_OFF) {
> +               pwr = sdhci_get_vdd_value(vdd);
> +               if (!pwr)
> +                       WARN(1, "%s: Invalid vdd %#x\n",
> +                            mmc_hostname(host->mmc), vdd);
> +               pwr |= SDHCI_VDD2_POWER_180;
> +       }
> +
> +       if (host->pwr == pwr)
> +               return;
> +       host->pwr = pwr;
> +
> +       if (pwr == 0) {
> +               sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
> +
> +               mmc_opt_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
> +               mmc_opt_regulator_set_ocr(mmc, mmc->supply.vmmc2, 0);

We added mmc_regulator_set_vqmmc2() in patch4. Please use that instead.

> +       } else {
> +               mmc_opt_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
> +               /* support 1.8v only for now */
> +               mmc_opt_regulator_set_ocr(mmc, mmc->supply.vmmc2, fls(MMC_VDD_165_195) - 1);
> +
> +               /* Clear the power reg before setting a new value */
> +               sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
> +
> +               /* vdd first */
> +               pwr |= SDHCI_POWER_ON;
> +               sdhci_writeb(host, pwr & 0xf, SDHCI_POWER_CONTROL);
> +               mdelay(5);
> +
> +               pwr |= SDHCI_VDD2_POWER_ON;
> +               sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
> +               mdelay(5);
> +       }
> +}
> +
>  /*****************************************************************************\
>   *                                                                           *
>   * Driver init/exit                                                          *
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 753b251179f2..eca54a16e7fc 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -23,7 +23,7 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/of.h>
> -
> +#include <linux/bug.h>
>  #include <linux/leds.h>
>
>  #include <linux/mmc/mmc.h>
> @@ -2061,41 +2061,46 @@ static void sdhci_set_power_reg(struct sdhci_host *host, unsigned char mode,
>                 sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
>  }
>
> +unsigned short sdhci_get_vdd_value(unsigned short vdd)
> +{
> +       switch (1 << vdd) {
> +       case MMC_VDD_165_195:
> +       /*
> +        * Without a regulator, SDHCI does not support 2.0v
> +        * so we only get here if the driver deliberately
> +        * added the 2.0v range to ocr_avail. Map it to 1.8v
> +        * for the purpose of turning on the power.
> +        */
> +       case MMC_VDD_20_21:
> +               return SDHCI_POWER_180;
> +       case MMC_VDD_29_30:
> +       case MMC_VDD_30_31:
> +               return SDHCI_POWER_300;
> +       case MMC_VDD_32_33:
> +       case MMC_VDD_33_34:
> +       /*
> +        * 3.4V ~ 3.6V are valid only for those platforms where it's
> +        * known that the voltage range is supported by hardware.
> +        */
> +       case MMC_VDD_34_35:
> +       case MMC_VDD_35_36:
> +               return SDHCI_POWER_330;
> +       default:
> +               return 0;
> +       }
> +}
> +EXPORT_SYMBOL_GPL(sdhci_get_vdd_value);
> +
>  void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
>                            unsigned short vdd)
>  {
>         u8 pwr = 0;
>
>         if (mode != MMC_POWER_OFF) {
> -               switch (1 << vdd) {
> -               case MMC_VDD_165_195:
> -               /*
> -                * Without a regulator, SDHCI does not support 2.0v
> -                * so we only get here if the driver deliberately
> -                * added the 2.0v range to ocr_avail. Map it to 1.8v
> -                * for the purpose of turning on the power.
> -                */
> -               case MMC_VDD_20_21:
> -                       pwr = SDHCI_POWER_180;
> -                       break;
> -               case MMC_VDD_29_30:
> -               case MMC_VDD_30_31:
> -                       pwr = SDHCI_POWER_300;
> -                       break;
> -               case MMC_VDD_32_33:
> -               case MMC_VDD_33_34:
> -               /*
> -                * 3.4 ~ 3.6V are valid only for those platforms where it's
> -                * known that the voltage range is supported by hardware.
> -                */
> -               case MMC_VDD_34_35:
> -               case MMC_VDD_35_36:
> -                       pwr = SDHCI_POWER_330;
> -                       break;
> -               default:
> +               pwr = sdhci_get_vdd_value(vdd);
> +               if (!pwr) {
>                         WARN(1, "%s: Invalid vdd %#x\n",
>                              mmc_hostname(host->mmc), vdd);
> -                       break;
>                 }
>         }
>
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 43ad3f4b7672..f3bd558b337f 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -837,6 +837,7 @@ void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
>  void sdhci_set_power_and_bus_voltage(struct sdhci_host *host,
>                                      unsigned char mode,
>                                      unsigned short vdd);
> +unsigned short sdhci_get_vdd_value(unsigned short vdd);
>  void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
>                            unsigned short vdd);
>  int sdhci_get_cd_nogpio(struct mmc_host *mmc);
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 6c8258310641..610644a0ace5 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -363,6 +363,7 @@ struct mmc_pwrseq;
>
>  struct mmc_supply {
>         struct regulator *vmmc;         /* Card power supply */
> +       struct regulator *vmmc2;        /* UHS2 VDD2 power supply */

In patch4 we added vqmmc2. Please use that instead.

>         struct regulator *vqmmc;        /* Optional Vccq supply */
>         struct regulator *vqmmc2;       /* Optional supply for phy */
>  };
> --
> 2.25.1
>

Kind regards
Uffe
