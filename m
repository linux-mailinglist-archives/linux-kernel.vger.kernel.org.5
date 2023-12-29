Return-Path: <linux-kernel+bounces-13182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00EB58200CE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 18:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84CDBB21F49
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 17:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F1212B89;
	Fri, 29 Dec 2023 17:27:43 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FB112B72;
	Fri, 29 Dec 2023 17:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6dbca8c6eeeso1488846a34.1;
        Fri, 29 Dec 2023 09:27:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703870861; x=1704475661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qJAYsDTmYmyvQGFSeJtiB4aaPRQYv97IAZCo7KpDKGo=;
        b=NxHycAn6keiJCyvJOx9CNRoB5861vX1e9fQ3bM8gIou8W1AKSJpY8tgd47bJ2LPm2A
         2Px5PkNPHtfexKu2RJguPMdzrjXVglXhgrso2LMTqsyE3vbNZum9lcG9Ojqo35wDeJjo
         dqmKxM8s0GeNrueVJkgzNp/PNpcEjmJJEvyBB/V3uWWTLGycwuAcCr2sr/mPFfS9CeaI
         ziWFrm4tnsheEOOQu7lTiGzRcZTyrqy7FcpgBGpEELDY/+mhpAkydJZvbi7N7BPxbAmR
         SRV/9q9WAJJ8rrQ+QXn9HBoEryNolfTKTOlsfi29sG5VCEhx7SvtX48+wcEyXmM2csU2
         lc6g==
X-Gm-Message-State: AOJu0YxJCDpP5QfcLtY0Iq0BFYAGEWC/SvH3A1ZXS3LPnwTChADzpPKj
	JQf+iqv+yMfvinKopFh3bRLeVn4oYK2wZF4aKA8=
X-Google-Smtp-Source: AGHT+IHHs52Y/YvXjeCcLgRjwN4KgLAu8x7NEb0xdA+Q5Ye49v2GGBGMB0Ax1smVMoQQDPdb/S2YZiCjmS6Z6ilNgYE=
X-Received: by 2002:a05:6820:358:b0:593:fbd5:10aa with SMTP id
 m24-20020a056820035800b00593fbd510aamr17655974ooe.1.1703870861144; Fri, 29
 Dec 2023 09:27:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231227062940.10780-1-ricardo.neri-calderon@linux.intel.com> <20231227062940.10780-5-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20231227062940.10780-5-ricardo.neri-calderon@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 29 Dec 2023 18:27:30 +0100
Message-ID: <CAJZ5v0hHu7R+mnW=w1NM80=Ha0QL853+O6i3RKrw18wuhRPUOg@mail.gmail.com>
Subject: Re: [PATCH 4/4] thermal: intel: hfi: Add a suspend notifier
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Chen Yu <yu.c.chen@intel.com>, 
	Len Brown <len.brown@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	Zhao Liu <zhao1.liu@intel.com>, stable@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zhao Liu <zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 27, 2023 at 7:28=E2=80=AFAM Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> The kernel gives the HFI hardware a memory region that the latter uses to
> provide updates to the HFI table. The kernel allocates this memory region
> at boot. It remains constant throughout runtime time.
>
> When resuming from suspend or hibernation, the restore kernel allocates a
> second memory buffer and reprograms the HFI hardware with the new locatio=
n
> as part of a normal boot. The location of the second memory buffer may
> differ from the one allocated by the image kernel. Subsequently, when the
> restore kernel transfers control to the image kernel, the second buffer
> becomes invalid, potentially leading to memory corruption if the hardware
> writes to it (hardware continues using the buffer from the restore kernel=
).
>
> Add a suspend notifier to disable all HFI instances before jumping to the
> image kernel and enable them once the image kernel has been restored. Use
> the memory buffer that the image kernel allocated.
>
> For non-boot CPUs, rely on the CPU hotplug callbacks as CPUs are disabled
> and enabled during suspend and resume, respectively.
>
> The CPU hotplug callbacks do not cover the boot CPU. Handle the HFI
> instance of the boot CPU from the suspend notifier callback.
>
> Cc: Chen Yu <yu.c.chen@intel.com>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Zhao Liu <zhao1.liu@linux.intel.com>
> Cc: linux-pm@vger.kernel.org
> Cc: stable@vger.kernel.org
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
>  drivers/thermal/intel/intel_hfi.c | 53 +++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>
> diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/in=
tel_hfi.c
> index d2c874f43786..965c245e5e78 100644
> --- a/drivers/thermal/intel/intel_hfi.c
> +++ b/drivers/thermal/intel/intel_hfi.c
> @@ -30,11 +30,13 @@
>  #include <linux/kernel.h>
>  #include <linux/math.h>
>  #include <linux/mutex.h>
> +#include <linux/notifier.h>
>  #include <linux/percpu-defs.h>
>  #include <linux/printk.h>
>  #include <linux/processor.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
> +#include <linux/suspend.h>
>  #include <linux/string.h>
>  #include <linux/topology.h>
>  #include <linux/workqueue.h>
> @@ -569,11 +571,62 @@ static __init int hfi_parse_features(void)
>         return 0;
>  }
>
> +static void hfi_do_pm_enable(void *info)
> +{
> +       struct hfi_instance *hfi_instance =3D info;
> +
> +       hfi_set_hw_table(hfi_instance);
> +       hfi_enable();

The above do RMW, so should locking be used here?

> +}
> +
> +static void hfi_do_pm_disable(void *info)
> +{
> +       hfi_disable();
> +}

And here?

> +
> +static int hfi_pm_notify(struct notifier_block *nb,
> +                        unsigned long mode, void *unused)
> +{
> +       struct hfi_cpu_info *info =3D &per_cpu(hfi_cpu_info, 0);
> +       struct hfi_instance *hfi_instance =3D info->hfi_instance;
> +
> +       /* HFI may not be in use. */
> +       if (!hfi_instance)
> +               return 0;
> +
> +       /*
> +        * Only handle the HFI instance of the package of the boot CPU. T=
he
> +        * instances of other packages are handled in the CPU hotplug cal=
lbacks.
> +        */
> +       switch (mode) {
> +       case PM_HIBERNATION_PREPARE:
> +       case PM_SUSPEND_PREPARE:
> +       case PM_RESTORE_PREPARE:
> +               return smp_call_function_single(0, hfi_do_pm_disable,
> +                                               NULL, true);
> +
> +       case PM_POST_RESTORE:
> +       case PM_POST_HIBERNATION:
> +       case PM_POST_SUSPEND:
> +               return smp_call_function_single(0, hfi_do_pm_enable,
> +                                               hfi_instance, true);
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +
> +static struct notifier_block hfi_pm_nb =3D {
> +       .notifier_call =3D hfi_pm_notify,
> +};
> +
>  void __init intel_hfi_init(void)
>  {
>         struct hfi_instance *hfi_instance;
>         int i, j;
>
> +       if (register_pm_notifier(&hfi_pm_nb))
> +               return;
> +
>         if (hfi_parse_features())
>                 return;
>
> --

