Return-Path: <linux-kernel+bounces-22266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E7F829B99
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 316802853A9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7B748CE4;
	Wed, 10 Jan 2024 13:47:04 +0000 (UTC)
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E047495C8;
	Wed, 10 Jan 2024 13:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-59886dcd996so157786eaf.0;
        Wed, 10 Jan 2024 05:47:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704894421; x=1705499221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6xaGyYtLgAFKBwXQW+MJ645DyX0dzcV/GaiLsbnQgI4=;
        b=Z0hxBVusboRJ8Vfwj35Ls07oG9iVTpDmOqtOlID5LATckP7Dl8Wt6wprK13xyfm8Ff
         zvj3Dwpu/QWKWvLLlELNhmfaCD37X6HAc+EkXLHnVmENv2RN7BqqdgqOBLh/gy4Y8jeM
         JXKf1W25LopV1Qi19VTd5HjP3buo3y5W/LOoOzmM+eU5GzXHqY/e3sLQcFz7mJWkS/qj
         1swSkGFHCj4MRvB7y39MhPPdRFWXHu7PeFxNfxRhYyI9yDZ/zjPFFik9/XspdytwXOx1
         pPkDBz0hLRvtZ6c2cd7LdmeWS0OUsj6u8hv6920wphIBCYJR8OjVdiRSAj8fYWKTXWUM
         sfbw==
X-Gm-Message-State: AOJu0YzFGoxiV3/xvyxMEbpuqTdaeNEkWyUgadqmhLfon6WMmFCeZ25l
	8XkI80SoGdetqA9VHpa40QySmOa4ND/NNjAhIX3FABTuRgI=
X-Google-Smtp-Source: AGHT+IEeGMYG86tJMj3VPON+zivQhfDUn9O62ZqrfMQFQsoHR8DSMuv2+DJQ6ZONAnqTQzwIIHEiRnHAizZTBlpAV2k=
X-Received: by 2002:a4a:bb11:0:b0:598:7f90:b164 with SMTP id
 f17-20020a4abb11000000b005987f90b164mr2105158oop.0.1704894421575; Wed, 10 Jan
 2024 05:47:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110030704.11305-1-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20240110030704.11305-1-ricardo.neri-calderon@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 10 Jan 2024 14:46:50 +0100
Message-ID: <CAJZ5v0gj_YtVCa+c3KLwe8va9j110JBg=4F13LsvurPvUHyBOA@mail.gmail.com>
Subject: Re: [PATCH v3] thermal: intel: hfi: Add syscore callbacks
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Chen Yu <yu.c.chen@intel.com>, 
	Len Brown <len.brown@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	Zhao Liu <zhao1.liu@intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 4:05=E2=80=AFAM Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> The kernel allocates a memory buffer and provides its location to the
> hardware, which uses it to update the HFI table. This allocation occurs
> during boot and remains constant throughout runtime.
>
> When resuming from hibernation, the restore kernel allocates a second
> memory buffer and reprograms the HFI hardware with the new location as pa=
rt
> of a normal boot. The location of the second memory buffer may differ fro=
m
> the one allocated by the image kernel. When the restore kernel transfers
> control to the image kernel, the second buffer becomes invalid, potential=
ly
> leading to memory corruption if the hardware writes to it (the hardware
> continues using the buffer from the restore kernel).
>
> It is also possible that the hardware forgets the address of the memory
> buffer when resuming from "deep" suspend. Memory corruption may also occu=
r
> in such a scenario.
>
> To prevent the described memory corruption, disable HFI when preparing to
> suspend or hibernate. Enable it when resuming.
>
> Add syscore callbacks to handle the package of the boot CPU (packages of
> non-boot CPUs are handled via CPU offline). Syscore ops always run on the
> boot CPU. Additionally, HFI only needs to be disabled during "deep" suspe=
nd
> and hibernation. Syscore ops only run in these cases.
>
> Cc: Chen Yu <yu.c.chen@intel.com>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Zhao Liu <zhao1.liu@linux.intel.com>
> Cc: linux-pm@vger.kernel.org
> Cc: stable@vger.kernel.org    # 6.1
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
> This is v3 of the patch [4/4] of [1]. Rafael has already accepted the
> first three patches. Thanks!
>
> I tested this patch on the testing branch of Rafael on Jan 9th. 2024. I
> tested it on a Meteor Lake system. It completed 1000 hibernation-resume
> cycles.
>
> [1]. https://lore.kernel.org/all/20240103041459.11113-1-ricardo.neri-cald=
eron@linux.intel.com/
>
> ---
> Changes since v2:
>  * Switched to syscore ops instead of a suspend notifier as it is a bette=
r
>    fit: we only need to handle the boot CPU, disabling HFI is only needed
>    for "deep" suspend and hibernation. (Rafael)
>  * Removed incorrect statement about the suspend flow in the commit
>    message. (Rafael)
>
> Changes since v1:
>  * Moved registration of the suspend notifier towards the end of
>    intel_hfi_init(). (Stan)
>  * Renamed hfi_do_pm_[enable|disable]() to hfi_do_[enable|disable](). Sta=
n
>    will use these functions outside the suspend notifier. (Stan)
>  * Added locking to calls to hfi_[enable|disable]() from the suspend
>    notifier. (Rafael)
> ---
>  drivers/thermal/intel/intel_hfi.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/in=
tel_hfi.c
> index 22445403b520..768cd5f9eb32 100644
> --- a/drivers/thermal/intel/intel_hfi.c
> +++ b/drivers/thermal/intel/intel_hfi.c
> @@ -35,7 +35,9 @@
>  #include <linux/processor.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
> +#include <linux/suspend.h>
>  #include <linux/string.h>
> +#include <linux/syscore_ops.h>
>  #include <linux/topology.h>
>  #include <linux/workqueue.h>
>
> @@ -571,6 +573,30 @@ static __init int hfi_parse_features(void)
>         return 0;
>  }
>
> +static void hfi_do_enable(void)
> +{
> +       /* If we are here, we are on the boot CPU */
> +       struct hfi_cpu_info *info =3D &per_cpu(hfi_cpu_info, 0);
> +       struct hfi_instance *hfi_instance =3D info->hfi_instance;
> +
> +       /* No locking needed. There is no concurrency with CPU online. */
> +       hfi_set_hw_table(hfi_instance);
> +       hfi_enable();
> +}
> +
> +static int hfi_do_disable(void)
> +{
> +       /* No locking needed. There is no concurrency with CPU offline. *=
/
> +       hfi_disable();
> +
> +       return 0;
> +}
> +
> +static struct syscore_ops hfi_pm_ops =3D {
> +       .resume =3D hfi_do_enable,
> +       .suspend =3D hfi_do_disable,
> +};
> +
>  void __init intel_hfi_init(void)
>  {
>         struct hfi_instance *hfi_instance;
> @@ -602,6 +628,8 @@ void __init intel_hfi_init(void)
>         if (!hfi_updates_wq)
>                 goto err_nomem;
>
> +       register_syscore_ops(&hfi_pm_ops);
> +
>         return;
>
>  err_nomem:
> --

Applied as 6.8-rc1 material, with edited subject and changelog, and
I've reworded a comment in hfi_do_enable() to speak about the code.

Thanks!

