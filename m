Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65FCB7E721F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 20:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjKITT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 14:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjKITT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 14:19:27 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861BE3A84
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 11:19:25 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3b40d5ea323so715145b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 11:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699557565; x=1700162365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ydcfllMEeEZX6H39u2ZgHbnzb4EW6sJnHz8YiR+XiJg=;
        b=lLhuHNBiTyr/0bSv4R4McFpn3VhEO6iS69qgdS3rFu1FWQ1fwRSuOGTVATbbTkXXOm
         gSKP5aB/LsokgEtr+uiVFGqx2CM+G7PtnvejuB2AH1MHcAcD+k6gqlbjvYBDFVHT9NH3
         qW6ZBxunwT3BXgL2m8eEPeiIoEVAj1XqjS9fI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699557565; x=1700162365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ydcfllMEeEZX6H39u2ZgHbnzb4EW6sJnHz8YiR+XiJg=;
        b=W7w+xmX8MAQLDIbIXp8fnx1OZ8DQc5DrRwvYBD/ukpF9OoCYU4sf+/kFjbK73hmYQ2
         WoOHJAvCqr0vZt5E0w9vIPr758bbrmC3xg/oX5zB7JD/AltxC5RqC2ORhEQYr/1zxQMI
         T5MdDGB/i6COfRCmFPUsZNsZm4gwNntIwfCFZGC8Vbzy0l66w1/Iojt60UA/Bo/PPaya
         UhT7iglDRZlHfH7SDDfehQufaLUHzo5vR0ywOa1j5hNC6eeVe3FePPqnW1/BSSzZ44rP
         zeES/X0pdQFadHjSD51hyxCA7e9PH20m1tpGZglg8u8qJMMbbTVRBWuc3FEetAWdqHzN
         X19g==
X-Gm-Message-State: AOJu0YzDOfFzzNF3WMSlno4J4/naa984PpJhdFQgc7y0Pm0ICBSbke6B
        0i6I5odZRmnzDBCrNioxW0G7m1M/Rr+SnyhLe0EXEw==
X-Google-Smtp-Source: AGHT+IE6FBhCU6plmujlP1Eh9ePsZAHoNYSchpX4ZhmLAVcLjEgfUJRSYDpY2XXMcrUnJr2O60Mx/W5En8+Y4MgS7ow=
X-Received: by 2002:a05:6808:2017:b0:3b6:cadf:be06 with SMTP id
 q23-20020a056808201700b003b6cadfbe06mr768113oiw.23.1699557564771; Thu, 09 Nov
 2023 11:19:24 -0800 (PST)
MIME-Version: 1.0
References: <20231109111934.4172565-1-korneld@chromium.org>
In-Reply-To: <20231109111934.4172565-1-korneld@chromium.org>
From:   Sven van Ashbrook <svenva@chromium.org>
Date:   Thu, 9 Nov 2023 14:19:14 -0500
Message-ID: <CAG-rBijqw2VO8AQbwBh5Cu47gBbDsOGwPgw-8hSXMWCHXi6GLw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci-gli: Disable LPM during initialization
To:     =?UTF-8?Q?Kornel_Dul=C4=99ba?= <korneld@chromium.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jason Lai <jasonlai.genesyslogic@gmail.com>,
        Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        =?UTF-8?Q?Stanis=C5=82aw_Kardach?= <skardach@google.com>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kornel, see below.

On Thu, Nov 9, 2023 at 6:20=E2=80=AFAM Kornel Dul=C4=99ba <korneld@chromium=
.org> wrote:
>
> To address IO performance commit f9e5b33934ce
> ("mmc: host: Improve I/O read/write performance for GL9763E")
> limited LPM negotiation to runtime suspend state.
> The problem is that it only flips the switch in the runtime PM
> resume/suspend logic.
>
> Disable LPM negotiation in gl9763e_add_host.
> This helps in two ways:
> 1. It was found that the LPM switch stays in the same position after
>    warm reboot. Having it set in init helps with consistency.
> 2. Disabling LPM during the first runtime resume leaves us susceptible
>    to the performance issue in the time window between boot and the
>    first runtime suspend.
>
> Fixes: f9e5b33934ce ("mmc: host: Improve I/O read/write performance for G=
L9763E")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kornel Dul=C4=99ba <korneld@chromium.org>
> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pc=
i-gli.c
> index d83261e857a5..ce91d1e63a8e 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -220,6 +220,9 @@
>
>  #define GLI_MAX_TUNING_LOOP 40
>
> +static void gl9763e_set_low_power_negotiation(struct sdhci_pci_slot *slo=
t,
> +                                             bool enable);
> +
>  /* Genesys Logic chipset */
>  static inline void gl9750_wt_on(struct sdhci_host *host)
>  {
> @@ -1281,6 +1284,9 @@ static int gl9763e_add_host(struct sdhci_pci_slot *=
slot)
>         if (ret)
>                 goto cleanup;
>
> +       /* Disable LPM negotiation to avoid entering L1 state. */
> +       gl9763e_set_low_power_negotiation(slot, false);
> +
>         return 0;

What happens if the bridge is not driving the system rootfs? Imagine
the case where
the bridge is used to drive an auxiliary eMMC, unused until a few hours
after boot. After this patch, the bridge may remain active (not-L1)
for the entire time,
although it's not being used...

I suspect we want the following:
1. consistency - LPM register setting and runtime_pm state must agree
2. power-efficient initial state - bridge must come out of probe
runtime-suspended
and LPM must be enabled

I suspect the above will be fulfilled if we do

+ /* Bring to consistent runtime suspended state with LPM negotiation enabl=
ed */
+ gl9763e_set_low_power_negotiation(slot, false);
+ pm_runtime_set_suspended(dev);

WDYT?

>
>  cleanup:
> @@ -1323,7 +1329,6 @@ static void gli_set_gl9763e(struct sdhci_pci_slot *=
slot)
>         pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
>  }
>
> -#ifdef CONFIG_PM
>  static void gl9763e_set_low_power_negotiation(struct sdhci_pci_slot *slo=
t, bool enable)
>  {
>         struct pci_dev *pdev =3D slot->chip->pdev;
> @@ -1349,6 +1354,7 @@ static void gl9763e_set_low_power_negotiation(struc=
t sdhci_pci_slot *slot, bool
>         pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
>  }
>
> +#ifdef CONFIG_PM
>  static int gl9763e_runtime_suspend(struct sdhci_pci_chip *chip)
>  {
>         struct sdhci_pci_slot *slot =3D chip->slots[0];
> --
> 2.42.0.869.gea05f2083d-goog
>
