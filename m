Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9225F75C425
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 12:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjGUKMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 06:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbjGUKMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 06:12:00 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141E5359A;
        Fri, 21 Jul 2023 03:11:53 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id a1e0cc1a2514c-7948ad98b85so625371241.1;
        Fri, 21 Jul 2023 03:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689934312; x=1690539112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DYO7zo67xSaRl+DC6kBu7fA4X/BKAUeBcG4AnxU/OzE=;
        b=ozjMtS5Frw4S0oOAcCllFqMmsW4ccVDA1cgYeUUaXoHDumgVkkRXnWHpzQo30b9T4F
         4vASdKaXmj2FbJPYPnJMvFof14ZnNBNeNA9W/26E0Xtqux3TwybHyThWmZZjSTzljX2U
         immsZufTkv4aiJptWnWy48JbwOB14ZJzSfZ2il3rJii6iI/nw7FOfYi0e1M5GPpNIcTe
         zu6YhUEqWzoC9SLF1AN83t+EANxjsjhbdZj+FfxJhC5paxsEX8fLj2htTf9P8NTgt0Kh
         Us6i/9kpyia0IwaREY4phezzK3STk4AcGGkaQexLfxwkx2BobP3AFbgusuwxZHctollz
         Joig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689934312; x=1690539112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DYO7zo67xSaRl+DC6kBu7fA4X/BKAUeBcG4AnxU/OzE=;
        b=l1Qn9em0TPfKyc0Jb4loExJg1uUC6ds1giDssSGfzzieuu36ZJEwCDUUOqkd75aBAT
         B9jhoPDg6128TpZpFm+o9D5lYKWwDNUc7pYomtrv+yH7JBWqD9rytr/iLpHEUDbrIVVc
         FyDfpKN0aoN5136/fvqqKcyzSLY37I2GJ6RYut1/lOLmVdMmu0FMdQYq4u/OanRFIKuC
         A0GWpBuHuHW5gPtsBkBKY9wRxOO+TDcBtbBxFGzLXWon1vnEhu05Ogzoy+MHuAGwI6ZX
         hBV/2MElcE4vo1XbeDKQ2nH9e0kq7L228i4OiA01nhv2SS2fQm4orITmZYYTlXcV/YxJ
         wPgQ==
X-Gm-Message-State: ABy/qLZjfLd3ACJx0iTq8yvyYR8UtICtI6GjQCV6gluk///4TLMkBWzB
        mDYeYB67cbUCcJ1MmbdwQc6VksLdGcD20wjognk=
X-Google-Smtp-Source: APBJJlEUglDURuRtxO0r1K8+1mhQwscmgCfEVgwt/uBY5MbAnmQtAWZ0iCDUXmt7h7bOVS80ZP2CNYIqkesmjqL4kJk=
X-Received: by 2002:a67:f408:0:b0:443:7ab8:b5d7 with SMTP id
 p8-20020a67f408000000b004437ab8b5d7mr338332vsn.14.1689934311881; Fri, 21 Jul
 2023 03:11:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230621100151.6329-1-victorshihgli@gmail.com>
 <20230621100151.6329-12-victorshihgli@gmail.com> <22c0134f-205e-e14d-f0ed-480cd779beff@intel.com>
In-Reply-To: <22c0134f-205e-e14d-f0ed-480cd779beff@intel.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Fri, 21 Jul 2023 18:11:39 +0800
Message-ID: <CAK00qKDtviQE7Og1bf=4uT3+XLTWTwvb91xEa9e_xjdm73ty5w@mail.gmail.com>
Subject: Re: [PATCH V8 11/23] mmc: sdhci-uhs2: add set_power() to support vdd2
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        takahiro.akashi@linaro.org, dlunev@chromium.org,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 12:01=E2=80=AFAM Adrian Hunter <adrian.hunter@intel=
.com> wrote:
>
> On 21/06/23 13:01, Victor Shih wrote:
> > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> >
> > This is a UHS-II version of sdhci's set_power operation.
> > VDD2, as well as VDD, is handled here.
> >
> > Updates in V8:
> >  - Adjust the position of matching brackets.
> >  - Add the initial value of the pwr in
> >    sdhci_uhs2_set_power().
> >
> > Updates in V7:
> >  - Add clear the power reg before setting a new value
> >    in sdhci_uhs2_set_power().
> >  - Add MMC_VDD_34_35 case and MMC_VDD_35_36 case in
> >    sdhci_get_vdd_value().
> >  - Drop pwr variable in sdhci_get_vdd_value().
> >
> > Updates in V6:
> >  - Add mmc_opt_regulator_set_ocr().
> >  - Remove unnecessary functions.
> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > ---
> >  drivers/mmc/host/sdhci-uhs2.c | 48 +++++++++++++++++++++++++++
> >  drivers/mmc/host/sdhci.c      | 61 +++++++++++++++++++----------------
> >  drivers/mmc/host/sdhci.h      |  1 +
> >  3 files changed, 82 insertions(+), 28 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs=
2.c
> > index dfc80a7f1bad..fc37a34629c2 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.c
> > +++ b/drivers/mmc/host/sdhci-uhs2.c
> > @@ -57,6 +57,13 @@ EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);
> >   *                                                                    =
       *
> >  \*********************************************************************=
********/
> >
> > +static inline int mmc_opt_regulator_set_ocr(struct mmc_host *mmc,
> > +                                         struct regulator *supply,
> > +                                         unsigned short vdd_bit)
> > +{
> > +     return IS_ERR_OR_NULL(supply) ? 0 : mmc_regulator_set_ocr(mmc, su=
pply, vdd_bit);
> > +}
> > +
> >  bool sdhci_uhs2_mode(struct sdhci_host *host)
> >  {
> >       return host->mmc->flags & MMC_UHS2_SUPPORT;
> > @@ -94,6 +101,47 @@ void sdhci_uhs2_reset(struct sdhci_host *host, u16 =
mask)
> >  }
> >  EXPORT_SYMBOL_GPL(sdhci_uhs2_reset);
> >
> > +static void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned cha=
r mode, unsigned short vdd)
> > +{
> > +     struct mmc_host *mmc =3D host->mmc;
> > +     u8 pwr =3D 0;
> > +
> > +     if (mode !=3D MMC_POWER_OFF) {
> > +             pwr =3D sdhci_get_vdd_value(vdd);
> > +             if (!pwr)
> > +                     WARN(1, "%s: Invalid vdd %#x\n",
> > +                          mmc_hostname(host->mmc), vdd);
> > +             pwr |=3D SDHCI_VDD2_POWER_180;
> > +     }
> > +
> > +     if (host->pwr =3D=3D pwr)
> > +             return;
> > +     host->pwr =3D pwr;
> > +
> > +     if (pwr =3D=3D 0) {
> > +             sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
> > +
> > +             mmc_opt_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
> > +             mmc_opt_regulator_set_ocr(mmc, mmc->supply.vmmc2, 0);
> > +     } else {
> > +             mmc_opt_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
> > +             /* support 1.8v only for now */
> > +             mmc_opt_regulator_set_ocr(mmc, mmc->supply.vmmc2, fls(MMC=
_VDD_165_195) - 1);
> > +
> > +             /* Clear the power reg before setting a new value */
> > +             sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
> > +
> > +             /* vdd first */
> > +             pwr |=3D SDHCI_POWER_ON;
> > +             sdhci_writeb(host, pwr & 0xf, SDHCI_POWER_CONTROL);
> > +             mdelay(5);
> > +
> > +             pwr |=3D SDHCI_VDD2_POWER_ON;
> > +             sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
> > +             mdelay(5);
> > +     }
> > +}
> > +
> >  /*********************************************************************=
********\
> >   *                                                                    =
       *
> >   * Driver init/exit                                                   =
       *
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index 753b251179f2..ef344d4edf8f 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -23,7 +23,7 @@
> >  #include <linux/regulator/consumer.h>
> >  #include <linux/pm_runtime.h>
> >  #include <linux/of.h>
> > -
> > +#include <linux/bug.h>
> >  #include <linux/leds.h>
> >
> >  #include <linux/mmc/mmc.h>
> > @@ -2061,41 +2061,46 @@ static void sdhci_set_power_reg(struct sdhci_ho=
st *host, unsigned char mode,
> >               sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
> >  }
> >
> > +unsigned short sdhci_get_vdd_value(unsigned short vdd)
> > +{
> > +     switch (1 << vdd) {
> > +     case MMC_VDD_165_195:
> > +     /*
> > +      * Without a regulator, SDHCI does not support 2.0v
> > +      * so we only get here if the driver deliberately
> > +      * added the 2.0v range to ocr_avail. Map it to 1.8v
> > +      * for the purpose of turning on the power.
> > +      */
> > +     case MMC_VDD_20_21:
> > +             return SDHCI_POWER_180;
> > +     case MMC_VDD_29_30:
> > +     case MMC_VDD_30_31:
> > +             return SDHCI_POWER_300;
> > +     case MMC_VDD_32_33:
> > +     case MMC_VDD_33_34:
> > +     /*
> > +      * 3.4V ~ 3.6V are valid only for those platforms where it's
> > +      * known that the voltage reange is supported by hardware.
>
> reange -> range
>

Hi, Adrian

      I will fix it in the V9 version.

Thanks, Victor Shih

> > +      */
> > +     case MMC_VDD_34_35:
> > +     case MMC_VDD_35_36:
> > +             return SDHCI_POWER_330;
> > +     default:
> > +             return 0;
> > +     }
> > +}
> > +EXPORT_SYMBOL_GPL(sdhci_get_vdd_value);
> > +
> >  void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode=
,
> >                          unsigned short vdd)
> >  {
> >       u8 pwr =3D 0;
> >
> >       if (mode !=3D MMC_POWER_OFF) {
> > -             switch (1 << vdd) {
> > -             case MMC_VDD_165_195:
> > -             /*
> > -              * Without a regulator, SDHCI does not support 2.0v
> > -              * so we only get here if the driver deliberately
> > -              * added the 2.0v range to ocr_avail. Map it to 1.8v
> > -              * for the purpose of turning on the power.
> > -              */
> > -             case MMC_VDD_20_21:
> > -                     pwr =3D SDHCI_POWER_180;
> > -                     break;
> > -             case MMC_VDD_29_30:
> > -             case MMC_VDD_30_31:
> > -                     pwr =3D SDHCI_POWER_300;
> > -                     break;
> > -             case MMC_VDD_32_33:
> > -             case MMC_VDD_33_34:
> > -             /*
> > -              * 3.4 ~ 3.6V are valid only for those platforms where it=
's
> > -              * known that the voltage range is supported by hardware.
> > -              */
> > -             case MMC_VDD_34_35:
> > -             case MMC_VDD_35_36:
> > -                     pwr =3D SDHCI_POWER_330;
> > -                     break;
> > -             default:
> > +             pwr =3D sdhci_get_vdd_value(vdd);
> > +             if (!pwr) {
> >                       WARN(1, "%s: Invalid vdd %#x\n",
> >                            mmc_hostname(host->mmc), vdd);
> > -                     break;
> >               }
> >       }
> >
> > diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> > index 43ad3f4b7672..f3bd558b337f 100644
> > --- a/drivers/mmc/host/sdhci.h
> > +++ b/drivers/mmc/host/sdhci.h
> > @@ -837,6 +837,7 @@ void sdhci_set_power(struct sdhci_host *host, unsig=
ned char mode,
> >  void sdhci_set_power_and_bus_voltage(struct sdhci_host *host,
> >                                    unsigned char mode,
> >                                    unsigned short vdd);
> > +unsigned short sdhci_get_vdd_value(unsigned short vdd);
> >  void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode=
,
> >                          unsigned short vdd);
> >  int sdhci_get_cd_nogpio(struct mmc_host *mmc);
>
