Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2A377FEDC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 22:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354784AbjHQUIr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 17 Aug 2023 16:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349592AbjHQUI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 16:08:29 -0400
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C978611F;
        Thu, 17 Aug 2023 13:08:27 -0700 (PDT)
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-56d67c5e87cso37118eaf.0;
        Thu, 17 Aug 2023 13:08:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692302907; x=1692907707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zYLLFg5J3pvVGTsozGZREo6sNtQR5BDQuFmmPb98G/Y=;
        b=UnJIsblKVVO8MjpgACSUYMThIdpYKtiMR4JveVJ9ej3B2y3dEdwo21+e4liUfpOFIo
         +td03/TfN1luDL++hVJj69LG1C6Vq6CncVz5ix7bsZyTUyvmCZaidbNhbmyqYCfS3iEA
         e/8Y+QQqwFkIpkRmUrvaXPkqt/dfcY87VSR3A4UDZMAD5bC16ckq9R7wnBjC4oIhcTNH
         JU0QSORYXDxoxqqj2jyEsyCljU1qnXuRBw4SzmsFOu/bSZgxVqKn2KFX2CNjxvxNYZzX
         q9hOsk6VPAveAVp8kN1mSgWpFEeW2tpCnIYByRbokKOGBd+HunwVHGKEZSadNXcOjZQf
         /E3Q==
X-Gm-Message-State: AOJu0YxbGMf7Qkn7QASx4pkt0JL4v1/MJ5hZJ6OnHVV69h9Hun7D8Oxa
        FC7/CfhxB+l59vD+tUUomSJgV/NsqL4rL+myfIo=
X-Google-Smtp-Source: AGHT+IENlZsy4csR9d3AU8Pqm33/NSU6t5KMbTjq1UtBhxlnn7mQjpwH5Nj9dZi80xJuBRHRJvnp8JR8Hq9vSt8I9xU=
X-Received: by 2002:a05:6820:44a:b0:563:3b56:5dc1 with SMTP id
 p10-20020a056820044a00b005633b565dc1mr872071oou.0.1692302907041; Thu, 17 Aug
 2023 13:08:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230717195405.730869-1-srinivas.pandruvada@linux.intel.com> <20230717195405.730869-4-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20230717195405.730869-4-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Aug 2023 22:08:16 +0200
Message-ID: <CAJZ5v0jo3iDUpc9-jWuqGhWHpM0VYctXmkEdo4_s45_NSuw92w@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] thermal: int340x: processor_thermal: Use non MSI interrupts
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     daniel.lezcano@linaro.org, rafael@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 9:54 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> There are issues in using MSI interrupts for processor thermal device.
> The support is not consistent across generations. But the legacy PCI
> interrupts work on all current generations.
>
> Hence always use legacy PCI interrupts by default, instead of MSI.
> Add a module param to use of MSI, so that MSI can be still used.

So I would prefer the subject of this patch to say "Use non-MSI
interrupts by default".  Otherwise it suggests that it won't be
possible to use MSIs at all.

> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> v2:
> Changed msi_enabled to type bool
>
>  .../processor_thermal_device_pci.c            | 33 ++++++++++++-------
>  1 file changed, 22 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
> index 5a2bcfff0a68..2be9b7f660d1 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
> @@ -15,6 +15,11 @@
>
>  #define DRV_NAME "proc_thermal_pci"
>
> +static bool msi_enabled;
> +module_param(msi_enabled, bool, 0644);
> +MODULE_PARM_DESC(msi_enabled,
> +       "Use PCI MSI based interrupts for processor thermal device.");

I think that "use_msi" would be a better name for this switch.

> +
>  struct proc_thermal_pci {
>         struct pci_dev *pdev;
>         struct proc_thermal_device *proc_priv;
> @@ -219,8 +224,6 @@ static int proc_thermal_pci_probe(struct pci_dev *pdev, const struct pci_device_
>                 return ret;
>         }
>
> -       pci_set_master(pdev);
> -

How is this change related to the rest of the patch?

>         INIT_DELAYED_WORK(&pci_info->work, proc_thermal_threshold_work_fn);
>
>         ret = proc_thermal_add(&pdev->dev, proc_priv);
> @@ -248,16 +251,23 @@ static int proc_thermal_pci_probe(struct pci_dev *pdev, const struct pci_device_
>                 goto err_ret_mmio;
>         }
>
> -       /* request and enable interrupt */
> -       ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
> -       if (ret < 0) {
> -               dev_err(&pdev->dev, "Failed to allocate vectors!\n");
> -               goto err_ret_tzone;
> -       }
> -       if (!pdev->msi_enabled && !pdev->msix_enabled)
> +       if (msi_enabled) {

Shouldn't this still check the pdev MSI flags?

> +               pci_set_master(pdev);
> +               /* request and enable interrupt */
> +               ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
> +               if (ret < 0) {
> +                       dev_err(&pdev->dev, "Failed to allocate vectors!\n");
> +                       goto err_ret_tzone;
> +               }
> +               if (!pdev->msi_enabled && !pdev->msix_enabled)
> +                       irq_flag = IRQF_SHARED;
> +
> +               irq =  pci_irq_vector(pdev, 0);
> +       } else {
>                 irq_flag = IRQF_SHARED;
> +               irq = pdev->irq;
> +       }
>
> -       irq =  pci_irq_vector(pdev, 0);
>         ret = devm_request_threaded_irq(&pdev->dev, irq,
>                                         proc_thermal_irq_handler, NULL,
>                                         irq_flag, KBUILD_MODNAME, pci_info);
> @@ -273,7 +283,8 @@ static int proc_thermal_pci_probe(struct pci_dev *pdev, const struct pci_device_
>         return 0;
>
>  err_free_vectors:
> -       pci_free_irq_vectors(pdev);
> +       if (msi_enabled)
> +               pci_free_irq_vectors(pdev);
>  err_ret_tzone:
>         thermal_zone_device_unregister(pci_info->tzone);
>  err_ret_mmio:
> --
