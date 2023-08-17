Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9201777FEE7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 22:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354818AbjHQUON convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 17 Aug 2023 16:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354392AbjHQUN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 16:13:58 -0400
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328D630DF;
        Thu, 17 Aug 2023 13:13:57 -0700 (PDT)
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-56d67c5e87cso37785eaf.0;
        Thu, 17 Aug 2023 13:13:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692303236; x=1692908036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EOOmb1fYQq61nhxtEFTLGG2RcS7GExUOqCV3eOpnV0g=;
        b=jDX0mwaXFGiz67630thfsu5IOb5l6kW43G9vk4IRjwgk/SeANRRxuBuOJcHWim0cOr
         cXEvNw0Qhkx14IskwPUbUtnUTpEXTx1yZMSmjr6bMhAjQi2B3AmvuuGpRhDDuUy4B3Bb
         7WXNZ/fOKxCZR2DCuLN3NOJZG2pYLwI3dDMc1gjaiL/Ak2NVu8G//P/G0bswkgHx7IGn
         6QTOoyIQhnuX9zk3FxL/JG8ksLZPXqX93TUlzqIXR8/ChfE7ps5kdlDXZNnw9DfXIEBW
         UX5ZNMu2pbSmqGAi2Apm+BJpV6AJwLrqzAF2spcpu5qwqF1UWgch5WV0ZCCC/+IatjI3
         XyRQ==
X-Gm-Message-State: AOJu0YzK8REa2hq1bUU4lCkwmRp3gjTjWgxwqSeYhjXqybF9PTh1snuy
        0mRwpTL82Vutafdn38f6xik81hIRH2dPvYCvSZMB1QvX
X-Google-Smtp-Source: AGHT+IGjC9+wUR9A0gG3IWLckX1X6Q5UeD/Qk4UQ+t+dOUMjkRWCz3mvd18QlzJOJ50MjmHkAQQ79RUXJ/N5v2JoerM=
X-Received: by 2002:a05:6820:44a:b0:563:3b56:5dc1 with SMTP id
 p10-20020a056820044a00b005633b565dc1mr886196oou.0.1692303236438; Thu, 17 Aug
 2023 13:13:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230717195405.730869-1-srinivas.pandruvada@linux.intel.com> <20230717195405.730869-7-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20230717195405.730869-7-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Aug 2023 22:13:45 +0200
Message-ID: <CAJZ5v0juNDN+8ZiSLp4XT6yYHGMrKHfQK08ZX1EAaFx6f4PWXg@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] thermal/drivers/int340x: Support workload hint interrupts
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     daniel.lezcano@linaro.org, rafael@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 9:54 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On thermal device interrupt, if the interrupt is generated for passing
> workload hint, call the callback to pass notification to the user
> space.
>
> First call proc_thermal_check_wlt_intr() to check interrupt, if this
> callback returns true, wake IRQ thread. Call
> proc_thermal_wlt_intr_callback() to notify user space.
>
> While here remove function pkg_thermal_schedule_work() and move the
> processing to the caller. The function pkg_thermal_schedule_work() just
> called schedule_delayed_work().

This extra change is somewhat confusing.  I would move it to a separate patch.

> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> v2:
> No change
>
>  .../processor_thermal_device_pci.c            | 33 ++++++++++++++-----
>  1 file changed, 24 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
> index ee5a4c227d96..83177ed9db49 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
> @@ -115,27 +115,40 @@ static void proc_thermal_threshold_work_fn(struct work_struct *work)
>         proc_thermal_mmio_write(pci_info, PROC_THERMAL_MMIO_INT_ENABLE_0, 1);
>  }
>
> -static void pkg_thermal_schedule_work(struct delayed_work *work)
> +static irqreturn_t proc_thermal_irq_thread_handler(int irq, void *devid)
>  {
> -       unsigned long ms = msecs_to_jiffies(notify_delay_ms);
> +       struct proc_thermal_pci *pci_info = devid;
> +
> +       proc_thermal_wlt_intr_callback(pci_info->pdev, pci_info->proc_priv);
>
> -       schedule_delayed_work(work, ms);
> +       return IRQ_HANDLED;
>  }
>
>  static irqreturn_t proc_thermal_irq_handler(int irq, void *devid)
>  {
>         struct proc_thermal_pci *pci_info = devid;
> +       struct proc_thermal_device *proc_priv;
> +       int ret = IRQ_HANDLED;
>         u32 status;
>
> +       proc_priv = pci_info->proc_priv;
> +
> +       if (proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_WLT_HINT) {
> +               if (proc_thermal_check_wlt_intr(pci_info->proc_priv))
> +                       ret = IRQ_WAKE_THREAD;
> +       }
> +
>         proc_thermal_mmio_read(pci_info, PROC_THERMAL_MMIO_INT_STATUS_0, &status);
> +       if (status) {
> +               unsigned long ms = msecs_to_jiffies(notify_delay_ms);
>
> -       /* Disable enable interrupt flag */
> -       proc_thermal_mmio_write(pci_info, PROC_THERMAL_MMIO_INT_ENABLE_0, 0);
> +               /* Disable enable interrupt flag */
> +               proc_thermal_mmio_write(pci_info, PROC_THERMAL_MMIO_INT_ENABLE_0, 0);
> +               schedule_delayed_work(&pci_info->work, ms);
> +       }
>         pci_write_config_byte(pci_info->pdev, 0xdc, 0x01);
>
> -       pkg_thermal_schedule_work(&pci_info->work);
> -
> -       return IRQ_HANDLED;
> +       return ret;
>  }
>
>  static int sys_get_curr_temp(struct thermal_zone_device *tzd, int *temp)
> @@ -269,7 +282,7 @@ static int proc_thermal_pci_probe(struct pci_dev *pdev, const struct pci_device_
>         }
>
>         ret = devm_request_threaded_irq(&pdev->dev, irq,
> -                                       proc_thermal_irq_handler, NULL,
> +                                       proc_thermal_irq_handler, proc_thermal_irq_thread_handler,
>                                         irq_flag, KBUILD_MODNAME, pci_info);
>         if (ret) {
>                 dev_err(&pdev->dev, "Request IRQ %d failed\n", pdev->irq);
> @@ -383,6 +396,8 @@ static struct pci_driver proc_thermal_pci_driver = {
>
>  module_pci_driver(proc_thermal_pci_driver);
>
> +MODULE_IMPORT_NS(INT340X_THERMAL);
> +
>  MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>");
>  MODULE_DESCRIPTION("Processor Thermal Reporting Device Driver");
>  MODULE_LICENSE("GPL v2");
> --
> 2.38.1
>
