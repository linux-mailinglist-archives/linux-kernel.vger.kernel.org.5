Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2617EB072
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 14:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbjKNNCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 08:02:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbjKNNCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 08:02:14 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0BD1A2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 05:02:10 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-586940ee5a5so2843139eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 05:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699966930; x=1700571730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lZ7lI/47qj9ovIXjugVBgcYNb/63apU98UAvoft/LRY=;
        b=JYlvoiNcLLfYSdWrAyyez9wj/BJMRoQnxBx8MW7mi14YuQ4HyTnkgVtKU2jRaH+3EC
         VvQnMjadCEd4otF1R+oEPX1EuzZauClkoAdH4+JrjYTT6mtJz3ZONFBNTZeo76jZ/c/h
         LDW/EZZGextjuJoj4eoZiQL3wdVTdHdKTdEYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699966930; x=1700571730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lZ7lI/47qj9ovIXjugVBgcYNb/63apU98UAvoft/LRY=;
        b=wtziF4pKBUQIZ+PhHydyRbO85aBgm78P55LFR64TzrVSIdoeFiaQZNAIdNgS1dhVYf
         aXMCWYgdb2INYo9MA2SQNhnaTFlOXnb65mDd4LJQ6kdO84uHA0Uk+f0rFPY4pUfcbfU7
         WbHqWogvfRNjFMW1rDVXRxhZemi2LLEhrftiTHdR3V9nqzlTgLVLVp04VtPwWj9e7f4i
         9aSRP/METPR5C7ZjhUZWCvYtNnd/8R6zrCR2enjUA7txEvIExjIpLsIisftx8LHu+Tno
         Up4jFKOjxOwNh+xbUuQiBdWsfrLGz5NSnerhc9+X4v9pUr9iU7LUp/hsveIRa7P8wM2/
         OGFA==
X-Gm-Message-State: AOJu0YxeXwQDu7aeiJkvwGOSgI4Jyvpj2j+bx4r/rwRNTzpajSSR1Tic
        jX1weTLYqZFDkfGTyzMt7ws/4TmLGJCYqS7vNuSaiw==
X-Google-Smtp-Source: AGHT+IEwtd5gnwVHSVciuUo8/FI+ZjQufFQEbeZiEA0eq9eSDp56QnoYf+Ox8zdKBQCKrrwrz0s04Z+SzhYiXAAhENo=
X-Received: by 2002:a05:6820:293:b0:584:bb9:4945 with SMTP id
 q19-20020a056820029300b005840bb94945mr10923648ood.3.1699966929817; Tue, 14
 Nov 2023 05:02:09 -0800 (PST)
MIME-Version: 1.0
References: <20231114115516.1585361-1-korneld@chromium.org>
In-Reply-To: <20231114115516.1585361-1-korneld@chromium.org>
From:   Sven van Ashbrook <svenva@chromium.org>
Date:   Tue, 14 Nov 2023 08:01:58 -0500
Message-ID: <CAG-rBig6XHoPSch5OqO_yNrYsX2szkyce0K==xqmrJXKT-2Jgg@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-pci-gli: Disable LPM during initialization
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LGTM.
Reviewed-by: Sven van Ashbrook <svenva@chromium.org>

On Tue, Nov 14, 2023 at 6:56=E2=80=AFAM Kornel Dul=C4=99ba <korneld@chromiu=
m.org> wrote:
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
> v2: Move up gl9763e_set_low_power_negotiation to avoid having to forward
>     declare it.
>
>  drivers/mmc/host/sdhci-pci-gli.c | 54 +++++++++++++++++---------------
>  1 file changed, 29 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pc=
i-gli.c
> index d8a991b349a8..77911a57b12c 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -1189,6 +1189,32 @@ static void gl9763e_hs400_enhanced_strobe(struct m=
mc_host *mmc,
>         sdhci_writel(host, val, SDHCI_GLI_9763E_HS400_ES_REG);
>  }
>
> +static void gl9763e_set_low_power_negotiation(struct sdhci_pci_slot *slo=
t,
> +                                             bool enable)
> +{
> +       struct pci_dev *pdev =3D slot->chip->pdev;
> +       u32 value;
> +
> +       pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
> +       value &=3D ~GLI_9763E_VHS_REV;
> +       value |=3D FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_W);
> +       pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
> +
> +       pci_read_config_dword(pdev, PCIE_GLI_9763E_CFG, &value);
> +
> +       if (enable)
> +               value &=3D ~GLI_9763E_CFG_LPSN_DIS;
> +       else
> +               value |=3D GLI_9763E_CFG_LPSN_DIS;
> +
> +       pci_write_config_dword(pdev, PCIE_GLI_9763E_CFG, value);
> +
> +       pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
> +       value &=3D ~GLI_9763E_VHS_REV;
> +       value |=3D FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_R);
> +       pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
> +}
> +
>  static void sdhci_set_gl9763e_signaling(struct sdhci_host *host,
>                                         unsigned int timing)
>  {
> @@ -1297,6 +1323,9 @@ static int gl9763e_add_host(struct sdhci_pci_slot *=
slot)
>         if (ret)
>                 goto cleanup;
>
> +       /* Disable LPM negotiation to avoid entering L1 state. */
> +       gl9763e_set_low_power_negotiation(slot, false);
> +
>         return 0;
>
>  cleanup:
> @@ -1340,31 +1369,6 @@ static void gli_set_gl9763e(struct sdhci_pci_slot =
*slot)
>  }
>
>  #ifdef CONFIG_PM
> -static void gl9763e_set_low_power_negotiation(struct sdhci_pci_slot *slo=
t, bool enable)
> -{
> -       struct pci_dev *pdev =3D slot->chip->pdev;
> -       u32 value;
> -
> -       pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
> -       value &=3D ~GLI_9763E_VHS_REV;
> -       value |=3D FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_W);
> -       pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
> -
> -       pci_read_config_dword(pdev, PCIE_GLI_9763E_CFG, &value);
> -
> -       if (enable)
> -               value &=3D ~GLI_9763E_CFG_LPSN_DIS;
> -       else
> -               value |=3D GLI_9763E_CFG_LPSN_DIS;
> -
> -       pci_write_config_dword(pdev, PCIE_GLI_9763E_CFG, value);
> -
> -       pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
> -       value &=3D ~GLI_9763E_VHS_REV;
> -       value |=3D FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_R);
> -       pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
> -}
> -
>  static int gl9763e_runtime_suspend(struct sdhci_pci_chip *chip)
>  {
>         struct sdhci_pci_slot *slot =3D chip->slots[0];
> --
> 2.43.0.rc0.421.g78406f8d94-goog
>
