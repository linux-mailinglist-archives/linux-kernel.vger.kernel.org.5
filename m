Return-Path: <linux-kernel+bounces-13180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7948200C9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 18:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33C63282129
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 17:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA53512B80;
	Fri, 29 Dec 2023 17:22:39 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D001E12E40;
	Fri, 29 Dec 2023 17:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6dbca8c6eeeso1488300a34.1;
        Fri, 29 Dec 2023 09:22:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703870557; x=1704475357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3zXsDSVyjkOlIslVUejAQip3X8oIGu+vcHizvG4w/TU=;
        b=wpSfowfKYZMiboymg7TjPTcqnmTVhZg2QGtAJzHppcWjICWMTdQGIVybjV0Gh9G3Ce
         2POMvqWpH1iyDbzwibV+KOffGY5ot2y+jExPJSNifPkAtKymL5nNuggl1aRnbi5VRalx
         PrqSpExcKyMhflIi55tX9KN892RVyBHFM5FiXCzVAewbF/hBKj8J71lo3XatZKZYVTBB
         e61771YmUsYxodxDRrDvXo5QQVvwstEvHsb7xXEAuqJ9NZmcCcxRY+kBMF92moxFBkvu
         irmV78vjcBL6vgka4w740zqEdsL00byX9cHJrDSTk4svxtun2bDq1Qy6/oAFm7+v7k3l
         jD7g==
X-Gm-Message-State: AOJu0YzgCIkPGdtrNnsunaSLxc6fwwHkKa+npqQi8c9bAicghPTlU3oE
	dEPJGmkO2jmdxqXELEmZui5sI+oTv+i350ASp5s=
X-Google-Smtp-Source: AGHT+IFix9+4OOdNeMwDWjSfLcUeqzsSuVHBHBnU+yXmFaQggHNijD7IlcxeVT63CGIrZEqDSfsz4ihGfdhVQc8ScTU=
X-Received: by 2002:a05:6820:358:b0:593:fbd5:10aa with SMTP id
 m24-20020a056820035800b00593fbd510aamr17645813ooe.1.1703870556822; Fri, 29
 Dec 2023 09:22:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231227062940.10780-1-ricardo.neri-calderon@linux.intel.com> <20231227062940.10780-2-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20231227062940.10780-2-ricardo.neri-calderon@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 29 Dec 2023 18:22:25 +0100
Message-ID: <CAJZ5v0iTaoiWWxueysmgx_SxqLZB0iODqSMX0vht9n8r_MC=KA@mail.gmail.com>
Subject: Re: [PATCH 1/4] thermal: intel: hfi: Refactor enabling code into
 helper functions
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Chen Yu <yu.c.chen@intel.com>, 
	Len Brown <len.brown@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	Zhao Liu <zhao1.liu@intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zhao Liu <zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 27, 2023 at 7:28=E2=80=AFAM Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> In preparation to add a suspend notifier, wrap the logic to enable HFI an=
d
> program its memory buffer into helper functions. Both the CPU hotplug
> callback and the suspend notifier will use it.

No functional impact?

> Cc: Chen Yu <yu.c.chen@intel.com>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Zhao Liu <zhao1.liu@linux.intel.com>
> Cc: linux-pm@vger.kernel.org
> Cc: stable@vger.kernel.org

Please don't CC stable@vger on patch submissions, although you may add
a Cc: stable tag without actually CCing it for my information, but in
that case please add a full tag including the earliest stable series
the patch is intended to apply to.

> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
>  drivers/thermal/intel/intel_hfi.c | 46 +++++++++++++++++--------------
>  1 file changed, 25 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/in=
tel_hfi.c
> index c69db6c90869..87ac7b196981 100644
> --- a/drivers/thermal/intel/intel_hfi.c
> +++ b/drivers/thermal/intel/intel_hfi.c
> @@ -347,6 +347,25 @@ static void init_hfi_instance(struct hfi_instance *h=
fi_instance)
>         hfi_instance->data =3D hfi_instance->hdr + hfi_features.hdr_size;
>  }
>
> +static void hfi_enable(void)
> +{
> +       u64 msr_val;
> +
> +       rdmsrl(MSR_IA32_HW_FEEDBACK_CONFIG, msr_val);
> +       msr_val |=3D HW_FEEDBACK_CONFIG_HFI_ENABLE_BIT;
> +       wrmsrl(MSR_IA32_HW_FEEDBACK_CONFIG, msr_val);
> +}
> +
> +static void hfi_set_hw_table(struct hfi_instance *hfi_instance)
> +{
> +       phys_addr_t hw_table_pa;
> +       u64 msr_val;
> +
> +       hw_table_pa =3D virt_to_phys(hfi_instance->hw_table);
> +       msr_val =3D hw_table_pa | HW_FEEDBACK_PTR_VALID_BIT;
> +       wrmsrl(MSR_IA32_HW_FEEDBACK_PTR, msr_val);
> +}
> +
>  /**
>   * intel_hfi_online() - Enable HFI on @cpu
>   * @cpu:       CPU in which the HFI will be enabled
> @@ -364,8 +383,6 @@ void intel_hfi_online(unsigned int cpu)
>  {
>         struct hfi_instance *hfi_instance;
>         struct hfi_cpu_info *info;
> -       phys_addr_t hw_table_pa;
> -       u64 msr_val;
>         u16 die_id;
>
>         /* Nothing to do if hfi_instances are missing. */
> @@ -403,14 +420,16 @@ void intel_hfi_online(unsigned int cpu)
>         /*
>          * Hardware is programmed with the physical address of the first =
page
>          * frame of the table. Hence, the allocated memory must be page-a=
ligned.
> +        *
> +        * Some processors do not forget the initial address of the HFI t=
able
> +        * even after having been reprogrammed. Keep using the same pages=
. Do
> +        * not free them.

This comment change does not seem to belong to this patch.  I guess it
needs to go to one of the subsequent patches?

>          */
>         hfi_instance->hw_table =3D alloc_pages_exact(hfi_features.nr_tabl=
e_pages,
>                                                    GFP_KERNEL | __GFP_ZER=
O);
>         if (!hfi_instance->hw_table)
>                 goto unlock;
>
> -       hw_table_pa =3D virt_to_phys(hfi_instance->hw_table);
> -
>         /*
>          * Allocate memory to keep a local copy of the table that
>          * hardware generates.
> @@ -420,16 +439,6 @@ void intel_hfi_online(unsigned int cpu)
>         if (!hfi_instance->local_table)
>                 goto free_hw_table;
>
> -       /*
> -        * Program the address of the feedback table of this die/package.=
 On
> -        * some processors, hardware remembers the old address of the HFI=
 table
> -        * even after having been reprogrammed and re-enabled. Thus, do n=
ot free
> -        * the pages allocated for the table or reprogram the hardware wi=
th a
> -        * new base address. Namely, program the hardware only once.
> -        */
> -       msr_val =3D hw_table_pa | HW_FEEDBACK_PTR_VALID_BIT;
> -       wrmsrl(MSR_IA32_HW_FEEDBACK_PTR, msr_val);
> -
>         init_hfi_instance(hfi_instance);
>
>         INIT_DELAYED_WORK(&hfi_instance->update_work, hfi_update_work_fn)=
;
> @@ -438,13 +447,8 @@ void intel_hfi_online(unsigned int cpu)
>
>         cpumask_set_cpu(cpu, hfi_instance->cpus);
>
> -       /*
> -        * Enable the hardware feedback interface and never disable it. S=
ee
> -        * comment on programming the address of the table.
> -        */
> -       rdmsrl(MSR_IA32_HW_FEEDBACK_CONFIG, msr_val);
> -       msr_val |=3D HW_FEEDBACK_CONFIG_HFI_ENABLE_BIT;
> -       wrmsrl(MSR_IA32_HW_FEEDBACK_CONFIG, msr_val);
> +       hfi_set_hw_table(hfi_instance);
> +       hfi_enable();
>
>  unlock:
>         mutex_unlock(&hfi_instance_lock);
> --

