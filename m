Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63D378F8A0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 08:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244856AbjIAGeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 02:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348387AbjIAGeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 02:34:11 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72AD9E;
        Thu, 31 Aug 2023 23:34:07 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2bd3f629c76so1865281fa.0;
        Thu, 31 Aug 2023 23:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693550046; x=1694154846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XdL7aZru6UQ1sfE0HKZDJ1DL8Cs+cqlVXGOmzcWh+GU=;
        b=ZOlCzdO3E/e9zXNgPAmzOuxG75h99IJxO4JUop/fvHfA90HlzCu91RgSs4bkQVQMrD
         iQzNG5DG9wqlSSPliu7kYGL9yXiHCCSZJKZgZ84dRPcCB2DeuccXbqnwchDIB2JLn4t2
         /2cDT7nj3lCFoz7VXWAU1WlhXDR4UCpcNa8ryaMKHWZmIILDSPpTJLVxPFy36eKzaVHl
         LkVXKl1m7xCkPi319vBG5aoVB4yiYCXb1RI8W4aEf5MY/AbBfMrm2TYO7cZF5yBO/uim
         Tm5sNw/yXnxBScN88B95jkU09V2TogCgSeCojYwhBLeHiz0lslIYKlP5KZjRSLiMi2Hb
         fRNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693550046; x=1694154846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XdL7aZru6UQ1sfE0HKZDJ1DL8Cs+cqlVXGOmzcWh+GU=;
        b=EBQqN+RJ6pTU0zbU9/2zsZ01zKWU0myRlw25so+Eh8OCoIWX2XeUj7krjFPI/Xscb1
         ki6JJ0Q2f5Ufioq80e7O+HA4S3fiUnXSQj6rcTWjfYHCbsrlYHTZ6ZUoe+bjUBUjC1jz
         jUJZ8ZpXmb3XQqWzo7snmqav6ZStTZmHEnnqrf0aYRrfqVGxlZO3sUPRrJFjPUR2dy2b
         oUCijalU4ehq390wfltYudr3tpg8CZdyChUheqyRYFU1AmM3635D1LZgApuTJUZaJNkP
         jYf6u3CRGwTn4u0DOfOpcI9sRzHjjZfCD77+jgQVnNI7GkngMQ0yrBvemKVHYG0dpcKt
         rktw==
X-Gm-Message-State: AOJu0YwlRNUB9a53rHbx0Oz3cTj7RtV5OD9YACe6Ipq1769uokFxq/k9
        +WV2hAKkzhxWYoQTuY99pltUE4biTa+4BL9+Mss=
X-Google-Smtp-Source: AGHT+IGqokjKDL/nG58CBTt47FAmp3Pe1+r/nMq1CRRpT1KVXvg4tCvb9xwUxz0K378Y+5K7aHzD0qYrmod91jHx/lg=
X-Received: by 2002:a2e:8206:0:b0:2b9:4b2b:89d8 with SMTP id
 w6-20020a2e8206000000b002b94b2b89d8mr776404ljg.35.1693550045852; Thu, 31 Aug
 2023 23:34:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230831160055.v3.1.I7ed1ca09797be2dd76ca914c57d88b32d24dac88@changeid>
In-Reply-To: <20230831160055.v3.1.I7ed1ca09797be2dd76ca914c57d88b32d24dac88@changeid>
From:   Lai Jason <jasonlai.genesyslogic@gmail.com>
Date:   Fri, 1 Sep 2023 14:33:54 +0800
Message-ID: <CAG0XXUE+stL_vZa4UBdm1wciWqLUfx4Yx3c7UchAB5i-SoYPFg@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: sdhci-pci-gli: fix LPM negotiation so x86/S0ix
 SoCs can suspend
To:     Sven van Ashbrook <svenva@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, ulf.hansson@linaro.org,
        adrian.hunter@intel.com, ben.chuang@genesyslogic.com.tw,
        jason.lai@genesyslogic.com.tw, skardach@google.com,
        Renius Chen <reniuschengl@gmail.com>,
        rafael.j.wysocki@intel.com, linux-mmc@vger.kernel.org,
        stable@vger.kernel.org, SeanHY.chen@genesyslogic.com.tw,
        victor.shih@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Sep 1, 2023 at 12:01=E2=80=AFAM Sven van Ashbrook <svenva@chromium.=
org> wrote:
>
> To improve the r/w performance of GL9763E, the current driver inhibits LP=
M
> negotiation while the device is active.
>
> This prevents a large number of SoCs from suspending, notably x86 systems
> which commonly use S0ix as the suspend mechanism - for example, Intel
> Alder Lake and Raptor Lake processors.
>
> Failure description:
> 1. Userspace initiates s2idle suspend (e.g. via writing to
>    /sys/power/state)
> 2. This switches the runtime_pm device state to active, which disables
>    LPM negotiation, then calls the "regular" suspend callback
> 3. With LPM negotiation disabled, the bus cannot enter low-power state
> 4. On a large number of SoCs, if the bus not in a low-power state, S0ix
>    cannot be entered, which in turn prevents the SoC from entering
>    suspend.
>
> Fix by re-enabling LPM negotiation in the device's suspend callback.
>
> Suggested-by: Stanislaw Kardach <skardach@google.com>
> Fixes: f9e5b33934ce ("mmc: host: Improve I/O read/write performance for G=
L9763E")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sven van Ashbrook <svenva@chromium.org>

LGTM.
But I prefer Ben's opinion "I suppose cqhci_suspend() may need to be
done first safely, then
gl9763e_set_low_power_negotiation(slot, true)." because it can avoid
GL9763E entering L1
while cmdq engine processes I/O.

Best regards,
Jason Lai

> ---
>
> Changes in v3:
> - applied maintainer feedback from https://lore.kernel.org/lkml/CACT4zj-B=
aX4tHji8B8gS5jiKkd-2BcwfzHM4fS-OUn0f8DSxcw@mail.gmail.com/T/#m7cea7b6b987d1=
ab1ca95feedf2c6f9da5783da5c
>
> Changes in v2:
> - improved symmetry and error path in s2idle suspend callback (internal r=
eview)
>
>  drivers/mmc/host/sdhci-pci-gli.c | 104 ++++++++++++++++++++-----------
>  1 file changed, 66 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pc=
i-gli.c
> index 1792665c9494a..a4ccb6c3e27a6 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -745,42 +745,6 @@ static u32 sdhci_gl9750_readl(struct sdhci_host *hos=
t, int reg)
>         return value;
>  }
>
> -#ifdef CONFIG_PM_SLEEP
> -static int sdhci_pci_gli_resume(struct sdhci_pci_chip *chip)
> -{
> -       struct sdhci_pci_slot *slot =3D chip->slots[0];
> -
> -       pci_free_irq_vectors(slot->chip->pdev);
> -       gli_pcie_enable_msi(slot);
> -
> -       return sdhci_pci_resume_host(chip);
> -}
> -
> -static int sdhci_cqhci_gli_resume(struct sdhci_pci_chip *chip)
> -{
> -       struct sdhci_pci_slot *slot =3D chip->slots[0];
> -       int ret;
> -
> -       ret =3D sdhci_pci_gli_resume(chip);
> -       if (ret)
> -               return ret;
> -
> -       return cqhci_resume(slot->host->mmc);
> -}
> -
> -static int sdhci_cqhci_gli_suspend(struct sdhci_pci_chip *chip)
> -{
> -       struct sdhci_pci_slot *slot =3D chip->slots[0];
> -       int ret;
> -
> -       ret =3D cqhci_suspend(slot->host->mmc);
> -       if (ret)
> -               return ret;
> -
> -       return sdhci_suspend_host(slot->host);
> -}
> -#endif
> -
>  static void gl9763e_hs400_enhanced_strobe(struct mmc_host *mmc,
>                                           struct mmc_ios *ios)
>  {
> @@ -1029,6 +993,70 @@ static int gl9763e_runtime_resume(struct sdhci_pci_=
chip *chip)
>  }
>  #endif
>
> +#ifdef CONFIG_PM_SLEEP
> +static int sdhci_pci_gli_resume(struct sdhci_pci_chip *chip)
> +{
> +       struct sdhci_pci_slot *slot =3D chip->slots[0];
> +
> +       pci_free_irq_vectors(slot->chip->pdev);
> +       gli_pcie_enable_msi(slot);
> +
> +       return sdhci_pci_resume_host(chip);
> +}
> +
> +static int gl9763e_resume(struct sdhci_pci_chip *chip)
> +{
> +       struct sdhci_pci_slot *slot =3D chip->slots[0];
> +       int ret;
> +
> +       ret =3D sdhci_pci_gli_resume(chip);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D cqhci_resume(slot->host->mmc);
> +       if (ret)
> +               return ret;
> +
> +       /*
> +        * Disable LPM negotiation to bring device back in sync
> +        * with its runtime_pm state.
> +        */
> +       gl9763e_set_low_power_negotiation(slot, false);
> +
> +       return 0;
> +}
> +
> +static int gl9763e_suspend(struct sdhci_pci_chip *chip)
> +{
> +       struct sdhci_pci_slot *slot =3D chip->slots[0];
> +       int ret;
> +
> +       /*
> +        * Certain SoCs can suspend only with the bus in low-
> +        * power state, notably x86 SoCs when using S0ix.
> +        * Re-enable LPM negotiation to allow entering L1 state
> +        * and entering system suspend.
> +        */
> +       gl9763e_set_low_power_negotiation(slot, true);
> +
> +       ret =3D cqhci_suspend(slot->host->mmc);
> +       if (ret)
> +               goto err_suspend;
> +
> +       ret =3D sdhci_suspend_host(slot->host);
> +       if (ret)
> +               goto err_suspend_host;
> +
> +       return 0;
> +
> +err_suspend_host:
> +       cqhci_resume(slot->host->mmc);
> +err_suspend:
> +       gl9763e_set_low_power_negotiation(slot, false);
> +       return ret;
> +}
> +#endif
> +
>  static int gli_probe_slot_gl9763e(struct sdhci_pci_slot *slot)
>  {
>         struct pci_dev *pdev =3D slot->chip->pdev;
> @@ -1113,8 +1141,8 @@ const struct sdhci_pci_fixes sdhci_gl9763e =3D {
>         .probe_slot     =3D gli_probe_slot_gl9763e,
>         .ops            =3D &sdhci_gl9763e_ops,
>  #ifdef CONFIG_PM_SLEEP
> -       .resume         =3D sdhci_cqhci_gli_resume,
> -       .suspend        =3D sdhci_cqhci_gli_suspend,
> +       .resume         =3D gl9763e_resume,
> +       .suspend        =3D gl9763e_suspend,
>  #endif
>  #ifdef CONFIG_PM
>         .runtime_suspend =3D gl9763e_runtime_suspend,
> --
> 2.42.0.283.g2d96d420d3-goog
>
