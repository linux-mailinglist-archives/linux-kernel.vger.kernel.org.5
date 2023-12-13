Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA55E811C8D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbjLMSbS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 13 Dec 2023 13:31:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjLMSbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:31:16 -0500
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E915A12A;
        Wed, 13 Dec 2023 10:31:22 -0800 (PST)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1fb00ea5e5fso828710fac.1;
        Wed, 13 Dec 2023 10:31:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702492282; x=1703097082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6GFuhiuAmmv14y95jUIfEovlJ4riX0jxcWwBbscHjw0=;
        b=oitiWD1Idwi1eogE8sxBJWsN5Z6sfPhUJHy8cfZi1eAYAS+LviWpgG6LU8EMH8Nc6S
         SJb144DVM0k+xBNtMgZPHDiCdIQmetNyZQpYOTmpfet7q4sL4/4UwFZ81wMKIK+wlhO8
         iAI/N8gvYP++OG2uyfgmmpt7plga97woD2k19+l/M9gglutKyc+LIxnWd+hzMrGsqHBz
         54Wr7nOP7daVQVHS79lDLaaqUCSaw2u3RsU0YrnYGO1SpKuCtav30dYxdHtqaHO5SM4m
         bfQzrHj3ZHF0gBCo3a6iVmFUa4F1Q2ULavcFfQ2Edh3h+XYT2wTEBkt7GF1fxvuLpRyf
         mdaQ==
X-Gm-Message-State: AOJu0YzMFRI0ayxMiY4xC73lJRvUdcUpoOCYn4NBwCrbHCPPugQmDpjp
        38kxRHSNDND+HCfyau1l8O5tEavTZUrneXnxfc4=
X-Google-Smtp-Source: AGHT+IFuugqd10lcnv9N9J4aw4AuZHW8Ul6NlK41/v9yX3U+owk+XD7/CsSFr1G6OXmx0uuOZvsNc342xFydwPE8B08=
X-Received: by 2002:a05:6871:892:b0:203:1727:c6b with SMTP id
 r18-20020a056871089200b0020317270c6bmr3865692oaq.5.1702492282111; Wed, 13 Dec
 2023 10:31:22 -0800 (PST)
MIME-Version: 1.0
References: <20231213182656.6165-1-mario.limonciello@amd.com> <20231213182656.6165-2-mario.limonciello@amd.com>
In-Reply-To: <20231213182656.6165-2-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 Dec 2023 19:31:11 +0100
Message-ID: <CAJZ5v0g0j2fpaHUdvxAkfo-3bRp=GRrKOgespUnz_BqX6timOw@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: Avoid runtime resuming devices if system is
 shutting down
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, mpearson-lenovo@squebb.ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 7:27 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> When the system is going to S5 resuming devices is unnecessary at
> best and may cause problems for power consumption at S5 at worst.
>
> Check the target `system_state` in the pci driver shutdown() callback
> and skip the runtime resume step if the system is being powered off.
>
> Cc: mpearson-lenovo@squebb.ca
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/pci/pci-driver.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 51ec9e7e784f..5a6f7a786952 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -507,7 +507,9 @@ static void pci_device_shutdown(struct device *dev)
>         struct pci_dev *pci_dev = to_pci_dev(dev);
>         struct pci_driver *drv = pci_dev->driver;
>
> -       pm_runtime_resume(dev);
> +       /* If system will go to S5, don't wake up PCI devices for shutdown */
> +       if (system_state != SYSTEM_POWER_OFF)
> +               pm_runtime_resume(dev);

What's the guarantee that the driver's shutdown callback will not
access MMIO regions of a runtime-suspended device?

>         if (drv && drv->shutdown)
>                 drv->shutdown(pci_dev);
> --
