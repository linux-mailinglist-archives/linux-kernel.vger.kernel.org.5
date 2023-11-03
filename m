Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3927E0103
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376296AbjKCKOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 06:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347633AbjKCKOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 06:14:01 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9329E13E;
        Fri,  3 Nov 2023 03:13:58 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-495eb6e2b80so697172e0c.1;
        Fri, 03 Nov 2023 03:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699006437; x=1699611237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+ADtzhxZ6RdxuvI42DF3VVuo0agKsBYzgsrJ1KxhwY=;
        b=cEAMqvZxa/ukoJSyhapG7RB3vcz0WWA+DyySwTCR/0lU9g+8QlD7+7F8ug1uyBg2ad
         6H6CbPXFR+L1baSGprtgGw9XkntXHdmY2zI7d7f1Mt50srx7fKsdkM0bCbqzDD1zppfF
         V9iak0GYmNuJMX/OOiToO/BtvWDwK0r/ZvCX6j8HBhwo18GhZymGj+n/8mE5D/d0mCtv
         KcxFjGxgUNfQe2smZ0vjeteXmxr6fRJx8kDvb5UINIrl+Rr4DSTHiyWBR4z8O5vX5+bz
         cttgrctArS+zoSnoRrRewMLuLuqJMp8eXG1zVP/Ql0Ycb4BcGHIYFwrQaBni2xW8ugKz
         yf2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699006437; x=1699611237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z+ADtzhxZ6RdxuvI42DF3VVuo0agKsBYzgsrJ1KxhwY=;
        b=kaJvT19UMhEuQ/fTqUj++yvdmD2vF1HId21NFNgj68jM1QNSsDFNfcWILqceygD1P3
         ZF98GEwFV5fua0x8+no/YOpUbXI96vCFlC9mZCcTcn+nlfxWfxT27J4zxpbpI6JqL1/x
         rs21pFZrplsUntcq9iw5WarVF1t/KVui5rBDz7GS+SMrZHjHHbHnaRT5SIhjtVaQp8MC
         8iHIXlBIOzqRH6TOaKWMgunQv41ldgi0oyq9A0gKa29Zn/lT90TA5gjvig0cI0AVuLIR
         RNd2AtKYdycdWRtyxjKQZv4KconQhZ7rOHklTZnNNeATQsF+ZKoZTDLHMRHbpCdZU0Ib
         g/+w==
X-Gm-Message-State: AOJu0Yyid8BlC4WEUQAd9+PNbrqAu5iFNVxbGZM4GLnodw6K5zgoaghV
        JhzBiwR6ZoLKtbnGZoLEp45+V7HCoWaRUz3iyQg=
X-Google-Smtp-Source: AGHT+IELdAyAxzEZSxxVdN+ZxlNC5S4Rw4tVjjvEyx4Ff8WI+DQAaKEYH7mlutWHSDQ1+D59y5Swv5KEvsM7MujC188=
X-Received: by 2002:a1f:29d7:0:b0:4ac:5d9:e655 with SMTP id
 p206-20020a1f29d7000000b004ac05d9e655mr249516vkp.0.1699006437640; Fri, 03 Nov
 2023 03:13:57 -0700 (PDT)
MIME-Version: 1.0
References: <20231018103337.34622-1-victorshihgli@gmail.com>
In-Reply-To: <20231018103337.34622-1-victorshihgli@gmail.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Fri, 3 Nov 2023 18:13:45 +0800
Message-ID: <CAK00qKBH5P3naXUHhbQ3zgMzQrUxy=v8r84a8RCcdNORVoRPkA@mail.gmail.com>
Subject: Re: [PATCH V2] mmc: sdhci-pci-gli: GL975[05]: Mask the replay timer
 timeout of AER
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, SeanHY.Chen@genesyslogic.com.tw,
        kai.heng.feng@canonical.com,
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

Hi, Ulf

Please help review this patch and give me some advice.
I look forward to your reply.

Thanks, Victor Shih

On Wed, Oct 18, 2023 at 6:33=E2=80=AFPM Victor Shih <victorshihgli@gmail.co=
m> wrote:
>
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
>
> Due to a flaw in the hardware design, the GL975x replay timer frequently
> times out when ASPM is enabled. As a result, the warning messages that wi=
ll
> often appear in the system log when the system accesses the GL975x
> PCI config. Therefore, the replay timer timeout must be masked.
>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> ---
>
> Updates in V2:
>  - Modify the commit message.
>
> ---
>
>  drivers/mmc/host/sdhci-pci-gli.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pc=
i-gli.c
> index d83261e857a5..d8a991b349a8 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -28,6 +28,9 @@
>  #define PCI_GLI_9750_PM_CTRL   0xFC
>  #define   PCI_GLI_9750_PM_STATE          GENMASK(1, 0)
>
> +#define PCI_GLI_9750_CORRERR_MASK                              0x214
> +#define   PCI_GLI_9750_CORRERR_MASK_REPLAY_TIMER_TIMEOUT         BIT(12)
> +
>  #define SDHCI_GLI_9750_CFG2          0x848
>  #define   SDHCI_GLI_9750_CFG2_L1DLY    GENMASK(28, 24)
>  #define   GLI_9750_CFG2_L1DLY_VALUE    0x1F
> @@ -152,6 +155,9 @@
>  #define PCI_GLI_9755_PM_CTRL     0xFC
>  #define   PCI_GLI_9755_PM_STATE    GENMASK(1, 0)
>
> +#define PCI_GLI_9755_CORRERR_MASK                              0x214
> +#define   PCI_GLI_9755_CORRERR_MASK_REPLAY_TIMER_TIMEOUT         BIT(12)
> +
>  #define SDHCI_GLI_9767_GM_BURST_SIZE                   0x510
>  #define   SDHCI_GLI_9767_GM_BURST_SIZE_AXI_ALWAYS_SET    BIT(8)
>
> @@ -561,6 +567,11 @@ static void gl9750_hw_setting(struct sdhci_host *hos=
t)
>         value &=3D ~PCI_GLI_9750_PM_STATE;
>         pci_write_config_dword(pdev, PCI_GLI_9750_PM_CTRL, value);
>
> +       /* mask the replay timer timeout of AER */
> +       pci_read_config_dword(pdev, PCI_GLI_9750_CORRERR_MASK, &value);
> +       value |=3D PCI_GLI_9750_CORRERR_MASK_REPLAY_TIMER_TIMEOUT;
> +       pci_write_config_dword(pdev, PCI_GLI_9750_CORRERR_MASK, value);
> +
>         gl9750_wt_off(host);
>  }
>
> @@ -770,6 +781,11 @@ static void gl9755_hw_setting(struct sdhci_pci_slot =
*slot)
>         value &=3D ~PCI_GLI_9755_PM_STATE;
>         pci_write_config_dword(pdev, PCI_GLI_9755_PM_CTRL, value);
>
> +       /* mask the replay timer timeout of AER */
> +       pci_read_config_dword(pdev, PCI_GLI_9755_CORRERR_MASK, &value);
> +       value |=3D PCI_GLI_9755_CORRERR_MASK_REPLAY_TIMER_TIMEOUT;
> +       pci_write_config_dword(pdev, PCI_GLI_9755_CORRERR_MASK, value);
> +
>         gl9755_wt_off(pdev);
>  }
>
> --
> 2.25.1
>
