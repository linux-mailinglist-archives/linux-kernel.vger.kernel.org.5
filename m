Return-Path: <linux-kernel+bounces-8539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F9C81B923
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 812F4B2125A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93723609A;
	Thu, 21 Dec 2023 13:55:47 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9E236080;
	Thu, 21 Dec 2023 13:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6dbb9d03b5eso95556a34.1;
        Thu, 21 Dec 2023 05:55:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703166945; x=1703771745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tn1YpB9RSUb3kYqtYjrWXVkua1HlT1atP73EUz1/0nY=;
        b=AP3Z9VeeKl3jB2MCKXBmdlCJrJacLeC9oYo684TxHCay2sVYpIcqCFpp6k4jBX7IP2
         D45fRN2ex+QCUTENHS1Et7uG4qgLslwmy81OBO0ErDnwhIcg0+Nfw4voI6GJ8KMYTwOd
         uK5h6Mh7MTfJsrQauGSYg8we6ehumpl4iHbnugIg2PPnx3MmnQ6RmTB7ZFzFpYpLRfe6
         fceoVE+MhtRhsRJPvrvUlbT4EQ3N21MFzQ2ffLishVbxPBLM7+z/CQC/ef7Kpxs1ivoy
         cqkz9esf2qc/8m1RvWZnGeR4e6axmw8mxZ4zEZG2QyvDHd6nOeWqGA0vMQ03XkGL4QU4
         DMrQ==
X-Gm-Message-State: AOJu0Yz3wEaZnXX6qGh5rDlL/oecy9zECauQiYDbOl60jdyq8NHfTJoJ
	QEc3V5tmFxSg2OxRmDWYPfQbXND6NLOunFnSWPI=
X-Google-Smtp-Source: AGHT+IGyDCjQzUrqeW1hQnA1vPHGjsH39gBljxA4HGmC4zmiOGkpax/gOnaTZ3Hp+uBUwVKFr9RB00v6d1OjIBF6qys=
X-Received: by 2002:a4a:a581:0:b0:591:cdc0:f28d with SMTP id
 d1-20020a4aa581000000b00591cdc0f28dmr13283358oom.0.1703166944879; Thu, 21 Dec
 2023 05:55:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com> <20231218064521.37324-2-xueshuai@linux.alibaba.com>
In-Reply-To: <20231218064521.37324-2-xueshuai@linux.alibaba.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 21 Dec 2023 14:55:33 +0100
Message-ID: <CAJZ5v0hnKP9S+5PfuO1EzvpSdHM09s0HidGjfinf491xkdop3g@mail.gmail.com>
Subject: Re: [PATCH v10 1/4] ACPI: APEI: set memory failure flags as
 MF_ACTION_REQUIRED on synchronous events
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: bp@alien8.de, rafael@kernel.org, wangkefeng.wang@huawei.com, 
	tanxiaofei@huawei.com, mawupeng1@huawei.com, tony.luck@intel.com, 
	linmiaohe@huawei.com, naoya.horiguchi@nec.com, james.morse@arm.com, 
	gregkh@linuxfoundation.org, will@kernel.org, jarkko@kernel.org, 
	linux-acpi@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org, linux-edac@vger.kernel.org, 
	acpica-devel@lists.linuxfoundation.org, stable@vger.kernel.org, 
	x86@kernel.org, justin.he@arm.com, ardb@kernel.org, ying.huang@intel.com, 
	ashish.kalra@amd.com, baolin.wang@linux.alibaba.com, tglx@linutronix.de, 
	mingo@redhat.com, dave.hansen@linux.intel.com, lenb@kernel.org, hpa@zytor.com, 
	robert.moore@intel.com, lvying6@huawei.com, xiexiuqi@huawei.com, 
	zhuo.song@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 7:45=E2=80=AFAM Shuai Xue <xueshuai@linux.alibaba.c=
om> wrote:
>
> There are two major types of uncorrected recoverable (UCR) errors :
>
> - Synchronous error: The error is detected and raised at the point of the
>   consumption in the execution flow, e.g. when a CPU tries to access
>   a poisoned cache line. The CPU will take a synchronous error exception
>   such as Synchronous External Abort (SEA) on Arm64 and Machine Check
>   Exception (MCE) on X86. OS requires to take action (for example, offlin=
e
>   failure page/kill failure thread) to recover this uncorrectable error.
>
> - Asynchronous error: The error is detected out of processor execution
>   context, e.g. when an error is detected by a background scrubber. Some =
data
>   in the memory are corrupted. But the data have not been consumed. OS is
>   optional to take action to recover this uncorrectable error.
>
> When APEI firmware first is enabled, a platform may describe one error
> source for the handling of synchronous errors (e.g. MCE or SEA notificati=
on
> ), or for handling asynchronous errors (e.g. SCI or External Interrupt
> notification). In other words, we can distinguish synchronous errors by
> APEI notification. For synchronous errors, kernel will kill the current
> process which accessing the poisoned page by sending SIGBUS with
> BUS_MCEERR_AR. In addition, for asynchronous errors, kernel will notify t=
he
> process who owns the poisoned page by sending SIGBUS with BUS_MCEERR_AO i=
n
> early kill mode. However, the GHES driver always sets mf_flags to 0 so th=
at
> all synchronous errors are handled as asynchronous errors in memory failu=
re.
>
> To this end, set memory failure flags as MF_ACTION_REQUIRED on synchronou=
s
> events.
>
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Tested-by: Ma Wupeng <mawupeng1@huawei.com>
> Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Reviewed-by: Xiaofei Tan <tanxiaofei@huawei.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Reviewed-by: James Morse <james.morse@arm.com>

Applied as 6.8 material.

The other patches in the series still need to receive tags from the
APEI designated reviewers (as per MAINTAINERS).

Thanks!


> ---
>  drivers/acpi/apei/ghes.c | 29 +++++++++++++++++++++++------
>  1 file changed, 23 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 63ad0541db38..ab2a82cb1b0b 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -101,6 +101,20 @@ static inline bool is_hest_type_generic_v2(struct gh=
es *ghes)
>         return ghes->generic->header.type =3D=3D ACPI_HEST_TYPE_GENERIC_E=
RROR_V2;
>  }
>
> +/*
> + * A platform may describe one error source for the handling of synchron=
ous
> + * errors (e.g. MCE or SEA), or for handling asynchronous errors (e.g. S=
CI
> + * or External Interrupt). On x86, the HEST notifications are always
> + * asynchronous, so only SEA on ARM is delivered as a synchronous
> + * notification.
> + */
> +static inline bool is_hest_sync_notify(struct ghes *ghes)
> +{
> +       u8 notify_type =3D ghes->generic->notify.type;
> +
> +       return notify_type =3D=3D ACPI_HEST_NOTIFY_SEA;
> +}
> +
>  /*
>   * This driver isn't really modular, however for the time being,
>   * continuing to use module_param is the easiest way to remain
> @@ -489,7 +503,7 @@ static bool ghes_do_memory_failure(u64 physical_addr,=
 int flags)
>  }
>
>  static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gd=
ata,
> -                                      int sev)
> +                                      int sev, bool sync)
>  {
>         int flags =3D -1;
>         int sec_sev =3D ghes_severity(gdata->error_severity);
> @@ -503,7 +517,7 @@ static bool ghes_handle_memory_failure(struct acpi_he=
st_generic_data *gdata,
>             (gdata->flags & CPER_SEC_ERROR_THRESHOLD_EXCEEDED))
>                 flags =3D MF_SOFT_OFFLINE;
>         if (sev =3D=3D GHES_SEV_RECOVERABLE && sec_sev =3D=3D GHES_SEV_RE=
COVERABLE)
> -               flags =3D 0;
> +               flags =3D sync ? MF_ACTION_REQUIRED : 0;
>
>         if (flags !=3D -1)
>                 return ghes_do_memory_failure(mem_err->physical_addr, fla=
gs);
> @@ -511,9 +525,11 @@ static bool ghes_handle_memory_failure(struct acpi_h=
est_generic_data *gdata,
>         return false;
>  }
>
> -static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdat=
a, int sev)
> +static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdat=
a,
> +                                      int sev, bool sync)
>  {
>         struct cper_sec_proc_arm *err =3D acpi_hest_get_payload(gdata);
> +       int flags =3D sync ? MF_ACTION_REQUIRED : 0;
>         bool queued =3D false;
>         int sec_sev, i;
>         char *p;
> @@ -538,7 +554,7 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest=
_generic_data *gdata, int s
>                  * and don't filter out 'corrected' error here.
>                  */
>                 if (is_cache && has_pa) {
> -                       queued =3D ghes_do_memory_failure(err_info->physi=
cal_fault_addr, 0);
> +                       queued =3D ghes_do_memory_failure(err_info->physi=
cal_fault_addr, flags);
>                         p +=3D err_info->length;
>                         continue;
>                 }
> @@ -666,6 +682,7 @@ static bool ghes_do_proc(struct ghes *ghes,
>         const guid_t *fru_id =3D &guid_null;
>         char *fru_text =3D "";
>         bool queued =3D false;
> +       bool sync =3D is_hest_sync_notify(ghes);
>
>         sev =3D ghes_severity(estatus->error_severity);
>         apei_estatus_for_each_section(estatus, gdata) {
> @@ -683,13 +700,13 @@ static bool ghes_do_proc(struct ghes *ghes,
>                         atomic_notifier_call_chain(&ghes_report_chain, se=
v, mem_err);
>
>                         arch_apei_report_mem_error(sev, mem_err);
> -                       queued =3D ghes_handle_memory_failure(gdata, sev)=
;
> +                       queued =3D ghes_handle_memory_failure(gdata, sev,=
 sync);
>                 }
>                 else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
>                         ghes_handle_aer(gdata);
>                 }
>                 else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
> -                       queued =3D ghes_handle_arm_hw_error(gdata, sev);
> +                       queued =3D ghes_handle_arm_hw_error(gdata, sev, s=
ync);
>                 } else {
>                         void *err =3D acpi_hest_get_payload(gdata);
>
> --
> 2.39.3
>

