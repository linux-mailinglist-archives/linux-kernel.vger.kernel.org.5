Return-Path: <linux-kernel+bounces-16-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74461813AC7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 20:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B26E1C20F3F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98F1697A4;
	Thu, 14 Dec 2023 19:31:31 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C0F69790;
	Thu, 14 Dec 2023 19:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6d9d6f8485eso1180153a34.0;
        Thu, 14 Dec 2023 11:31:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702582288; x=1703187088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T2HZk8v/RsD0JKPft+UxXNVM6N+oiGp8mnW19Rl92ho=;
        b=DXf9X6O+pspD4oXYlP9G8nfNejpJYNdzJcCRNc4EQX4XvJ88axQCTn4YuW+g4BCDFo
         L0shO8fDA8NKySVqncIAv80ZTaLdvmz8k+uylBwIX+GxY02ZOXC37mXGqSUv3SuZeKx0
         iz8DuPJ3rTxvRlU21PoeudLG2lCN6/mhcm+y/7Ao2y9FnlYjnOdFLEP3Q4vTSzAfejXJ
         NPefy3jHb7u6gOuXeNQ9PY63rJyol4+LI7JHXGnanHbT0b+cRxuTzXYmc7kmlGFi+A8g
         iLIDRAhl/da6MfWi5vr/5asMowjJ//UasOj8N3kIb7j2F1XjrVGYNcIOXyEhWTG14pjS
         OFYA==
X-Gm-Message-State: AOJu0YxBVTFcTzGwvORMITTXJR84So7FpT5D+5sn1IcrCskRzsWYUV/k
	pCVOfGsaMcpYRJkT5AU1MPWXhx0ffxfevSDP+pg=
X-Google-Smtp-Source: AGHT+IEC0xVxvkwc5escb+tNQvJB+H0lUpyobal4AjpzQyhi/i4Oq0kFUcNVb0yFJDpAGV5WCcMkznODVDUeWCwECvo=
X-Received: by 2002:a05:6871:d287:b0:1fb:790:72fa with SMTP id
 pl7-20020a056871d28700b001fb079072famr17624418oac.0.1702582288292; Thu, 14
 Dec 2023 11:31:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212072617.14756-1-lihuisong@huawei.com>
In-Reply-To: <20231212072617.14756-1-lihuisong@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 14 Dec 2023 20:31:17 +0100
Message-ID: <CAJZ5v0jwW0=8cNvC-Vu_o+pEHFpN9nrPD4LXCpmSTgQBTHODgg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: CPPC: Resolve the large frequency discrepancy
 from cpuinfo_cur_freq
To: Huisong Li <lihuisong@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, rafael@kernel.org, 
	beata.michalska@arm.com, sumitg@nvidia.com, ionela.voinescu@arm.com, 
	zengheng4@huawei.com, yang@os.amperecomputing.com, will@kernel.org, 
	sudeep.holla@arm.com, liuyonglong@huawei.com, zhanjie9@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 8:26=E2=80=AFAM Huisong Li <lihuisong@huawei.com> w=
rote:
>
> Many developers found that the cpu current frequency is greater than
> the maximum frequency of the platform, please see [1], [2] and [3].
>
> In the scenarios with high memory access pressure, the patch [1] has
> proved the significant latency of cpc_read() which is used to obtain
> delivered and reference performance counter cause an absurd frequency.
> The sampling interval for this counters is very critical and is expected
> to be equal. However, the different latency of cpc_read() has a direct
> impact on their sampling interval.
>
> This patch adds a interface, cpc_read_arch_counters_on_cpu, to read
> delivered and reference performance counter together. According to my
> test[4], the discrepancy of cpu current frequency in the scenarios with
> high memory access pressure is lower than 0.2% by stress-ng application.
>
> [1] https://lore.kernel.org/all/20231025093847.3740104-4-zengheng4@huawei=
.com/
> [2] https://lore.kernel.org/all/20230328193846.8757-1-yang@os.amperecompu=
ting.com/
> [3] https://lore.kernel.org/all/20230418113459.12860-7-sumitg@nvidia.com/
>
> [4] My local test:
> The testing platform enable SMT and include 128 logical CPU in total,
> and CPU base frequency is 2.7GHz. Reading "cpuinfo_cur_freq" for each
> physical core on platform during the high memory access pressure from
> stress-ng, and the output is as follows:
>   0: 2699133     2: 2699942     4: 2698189     6: 2704347
>   8: 2704009    10: 2696277    12: 2702016    14: 2701388
>  16: 2700358    18: 2696741    20: 2700091    22: 2700122
>  24: 2701713    26: 2702025    28: 2699816    30: 2700121
>  32: 2700000    34: 2699788    36: 2698884    38: 2699109
>  40: 2704494    42: 2698350    44: 2699997    46: 2701023
>  48: 2703448    50: 2699501    52: 2700000    54: 2699999
>  56: 2702645    58: 2696923    60: 2697718    62: 2700547
>  64: 2700313    66: 2700000    68: 2699904    70: 2699259
>  72: 2699511    74: 2700644    76: 2702201    78: 2700000
>  80: 2700776    82: 2700364    84: 2702674    86: 2700255
>  88: 2699886    90: 2700359    92: 2699662    94: 2696188
>  96: 2705454    98: 2699260   100: 2701097   102: 2699630
> 104: 2700463   106: 2698408   108: 2697766   110: 2701181
> 112: 2699166   114: 2701804   116: 2701907   118: 2701973
> 120: 2699584   122: 2700474   124: 2700768   126: 2701963
>
> Signed-off-by: Huisong Li <lihuisong@huawei.com>

First off, please Cc ACPI-related patches to linux-acpi.

> ---
>  arch/arm64/kernel/topology.c | 43 ++++++++++++++++++++++++++++++++++--
>  drivers/acpi/cppc_acpi.c     | 22 +++++++++++++++---
>  include/acpi/cppc_acpi.h     |  5 +++++
>  3 files changed, 65 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index 7d37e458e2f5..c3122154d738 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -299,6 +299,11 @@ core_initcall(init_amu_fie);
>  #ifdef CONFIG_ACPI_CPPC_LIB
>  #include <acpi/cppc_acpi.h>
>
> +struct amu_counters {
> +       u64 corecnt;
> +       u64 constcnt;
> +};
> +
>  static void cpu_read_corecnt(void *val)
>  {
>         /*
> @@ -322,8 +327,27 @@ static void cpu_read_constcnt(void *val)
>                       0UL : read_constcnt();
>  }
>
> +static void cpu_read_amu_counters(void *data)
> +{
> +       struct amu_counters *cnt =3D (struct amu_counters *)data;
> +
> +       /*
> +        * The running time of the this_cpu_has_cap() might have a couple=
 of
> +        * microseconds and is significantly increased to tens of microse=
conds.
> +        * But AMU core and constant counter need to be read togeter with=
out any
> +        * time interval to reduce the calculation discrepancy using this=
 counters.
> +        */
> +       if (this_cpu_has_cap(ARM64_WORKAROUND_2457168)) {
> +               cnt->corecnt =3D read_corecnt();

This statement is present in both branches, so can it be moved before the i=
f ()?

> +               cnt->constcnt =3D 0;
> +       } else {
> +               cnt->corecnt =3D read_corecnt();
> +               cnt->constcnt =3D read_constcnt();
> +       }
> +}
> +
>  static inline
> -int counters_read_on_cpu(int cpu, smp_call_func_t func, u64 *val)
> +int counters_read_on_cpu(int cpu, smp_call_func_t func, void *data)
>  {
>         /*
>          * Abort call on counterless CPU or when interrupts are
> @@ -335,7 +359,7 @@ int counters_read_on_cpu(int cpu, smp_call_func_t fun=
c, u64 *val)
>         if (WARN_ON_ONCE(irqs_disabled()))
>                 return -EPERM;
>
> -       smp_call_function_single(cpu, func, val, 1);
> +       smp_call_function_single(cpu, func, data, 1);
>
>         return 0;
>  }
> @@ -364,6 +388,21 @@ bool cpc_ffh_supported(void)
>         return true;
>  }
>
> +int cpc_read_arch_counters_on_cpu(int cpu, u64 *delivered, u64 *referenc=
e)
> +{
> +       struct amu_counters cnts =3D {0};
> +       int ret;
> +
> +       ret =3D counters_read_on_cpu(cpu, cpu_read_amu_counters, &cnts);
> +       if (ret)
> +               return ret;
> +
> +       *delivered =3D cnts.corecnt;
> +       *reference =3D cnts.constcnt;
> +
> +       return 0;
> +}
> +
>  int cpc_read_ffh(int cpu, struct cpc_reg *reg, u64 *val)
>  {
>         int ret =3D -EOPNOTSUPP;
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 7ff269a78c20..f303fabd7cfe 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1299,6 +1299,11 @@ bool cppc_perf_ctrs_in_pcc(void)
>  }
>  EXPORT_SYMBOL_GPL(cppc_perf_ctrs_in_pcc);
>
> +int __weak cpc_read_arch_counters_on_cpu(int cpu, u64 *delivered, u64 *r=
eference)
> +{
> +       return 0;
> +}
> +
>  /**
>   * cppc_get_perf_ctrs - Read a CPU's performance feedback counters.
>   * @cpunum: CPU from which to read counters.
> @@ -1313,7 +1318,8 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf=
_fb_ctrs *perf_fb_ctrs)
>                 *ref_perf_reg, *ctr_wrap_reg;
>         int pcc_ss_id =3D per_cpu(cpu_pcc_subspace_idx, cpunum);
>         struct cppc_pcc_data *pcc_ss_data =3D NULL;
> -       u64 delivered, reference, ref_perf, ctr_wrap_time;
> +       u64 delivered =3D 0, reference =3D 0;
> +       u64 ref_perf, ctr_wrap_time;
>         int ret =3D 0, regs_in_pcc =3D 0;
>
>         if (!cpc_desc) {
> @@ -1350,8 +1356,18 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_per=
f_fb_ctrs *perf_fb_ctrs)
>                 }
>         }
>
> -       cpc_read(cpunum, delivered_reg, &delivered);
> -       cpc_read(cpunum, reference_reg, &reference);
> +       if (cpc_ffh_supported()) {
> +               ret =3D cpc_read_arch_counters_on_cpu(cpunum, &delivered,=
 &reference);
> +               if (ret) {
> +                       pr_debug("read arch counters failed, ret=3D%d.\n"=
, ret);
> +                       ret =3D 0;
> +               }
> +       }

The above is surely not applicable to every platform using CPPC.  Also
it looks like in the ARM64_WORKAROUND_2457168 enabled case it is just
pointless overhead, because "reference" is always going to be 0 here
then.

Please clean that up.

> +       if (!delivered || !reference) {
> +               cpc_read(cpunum, delivered_reg, &delivered);
> +               cpc_read(cpunum, reference_reg, &reference);
> +       }
> +
>         cpc_read(cpunum, ref_perf_reg, &ref_perf);
>
>         /*
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index 6126c977ece0..07d4fd82d499 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -152,6 +152,7 @@ extern bool cpc_ffh_supported(void);
>  extern bool cpc_supported_by_cpu(void);
>  extern int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val);
>  extern int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val);
> +extern int cpc_read_arch_counters_on_cpu(int cpu, u64 *delivered, u64 *r=
eference);
>  extern int cppc_get_epp_perf(int cpunum, u64 *epp_perf);
>  extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls=
, bool enable);
>  extern int cppc_get_auto_sel_caps(int cpunum, struct cppc_perf_caps *per=
f_caps);
> @@ -209,6 +210,10 @@ static inline int cpc_write_ffh(int cpunum, struct c=
pc_reg *reg, u64 val)
>  {
>         return -ENOTSUPP;
>  }
> +static inline int cpc_read_arch_counters_on_cpu(int cpu, u64 *delivered,=
 u64 *reference)
> +{
> +       return -EOPNOTSUPP;
> +}
>  static inline int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *per=
f_ctrls, bool enable)
>  {
>         return -ENOTSUPP;
> --

