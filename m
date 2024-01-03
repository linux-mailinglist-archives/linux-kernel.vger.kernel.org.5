Return-Path: <linux-kernel+bounces-15419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C55822BBB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 062481F22338
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180D818E0E;
	Wed,  3 Jan 2024 10:59:50 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1418E18EA1;
	Wed,  3 Jan 2024 10:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5958d3f2d8aso439257eaf.1;
        Wed, 03 Jan 2024 02:59:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704279587; x=1704884387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kqXRk5DIjzSB7AnsVyWSH2H3h90xOz+WExtNtBrGdC4=;
        b=ktVACQUDOhRF4evD8dlf0SkK83wLJ2GUiyDUP8YXwrIwY/anhEp5ofEcoRtIK7jIlp
         jIRMHJjrKI9Ww1AWGxckhO1zjj6Aow1+Y1tMrUTOviXGuc/NDP/ewkmlUNXnU38HaUao
         JkHbJ/Ajv27mnNNG5ZAELe8JFP9HfVnDOoALBU8qZcqlY8IWRfOV2Zaf6CnlvtJtpWV6
         SVdfZSa1kmf9ZnCvjs4eZ5Y3wL7rqTaxsDSEc7eQo+H6q0zL70QK4Yw0jAcJGD+PaYli
         IfHskjoogx9pnPY73OGojP+APAVA4yWH4MxuwYYyv+nZ4QeicPjz17kr7xfzziok1GSe
         lO6g==
X-Gm-Message-State: AOJu0YzUuPm0QHnjyTOIjUBZ+pKc3iPw2LMUXeop3YUBjR2VdFpzHKX/
	U0QJ7ByarX/IPd18LIk+R0gFETodMzhXuUCeQvk=
X-Google-Smtp-Source: AGHT+IGJQQ0+ihemOXe2hNhzAelywrIvAehD+bERJWXgZLiaTURNFtmsZ9zmDvJmfwYeCjPTx9cs7l+QMVX+cwb3Ids=
X-Received: by 2002:a4a:ea4b:0:b0:595:fcca:e203 with SMTP id
 j11-20020a4aea4b000000b00595fccae203mr1634656ooe.0.1704279587016; Wed, 03 Jan
 2024 02:59:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212072617.14756-1-lihuisong@huawei.com> <CAJZ5v0jwW0=8cNvC-Vu_o+pEHFpN9nrPD4LXCpmSTgQBTHODgg@mail.gmail.com>
 <486f8563-42b7-a049-97a2-bc0b553926aa@huawei.com> <26ba9fa9-7871-27c3-0de5-62f61071dacd@huawei.com>
In-Reply-To: <26ba9fa9-7871-27c3-0de5-62f61071dacd@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 3 Jan 2024 11:59:35 +0100
Message-ID: <CAJZ5v0jSYajeYP1r+qKOmbwzn4PE5LL9E9LKsuYUygiXxmt2MA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: CPPC: Resolve the large frequency discrepancy
 from cpuinfo_cur_freq
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, beata.michalska@arm.com, sumitg@nvidia.com, 
	ionela.voinescu@arm.com, zengheng4@huawei.com, yang@os.amperecomputing.com, 
	will@kernel.org, sudeep.holla@arm.com, liuyonglong@huawei.com, 
	zhanjie9@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 3:15=E2=80=AFAM lihuisong (C) <lihuisong@huawei.com=
> wrote:
>
>
> =E5=9C=A8 2023/12/15 10:41, lihuisong (C) =E5=86=99=E9=81=93:
> > Hi Rafael,
> >
> > Thanks for your review.=F0=9F=98=81
> >
> > =E5=9C=A8 2023/12/15 3:31, Rafael J. Wysocki =E5=86=99=E9=81=93:
> >> On Tue, Dec 12, 2023 at 8:26=E2=80=AFAM Huisong Li <lihuisong@huawei.c=
om> wrote:
> >>> Many developers found that the cpu current frequency is greater than
> >>> the maximum frequency of the platform, please see [1], [2] and [3].
> >>>
> >>> In the scenarios with high memory access pressure, the patch [1] has
> >>> proved the significant latency of cpc_read() which is used to obtain
> >>> delivered and reference performance counter cause an absurd frequency=
.
> >>> The sampling interval for this counters is very critical and is
> >>> expected
> >>> to be equal. However, the different latency of cpc_read() has a direc=
t
> >>> impact on their sampling interval.
> >>>
> >>> This patch adds a interface, cpc_read_arch_counters_on_cpu, to read
> >>> delivered and reference performance counter together. According to my
> >>> test[4], the discrepancy of cpu current frequency in the scenarios wi=
th
> >>> high memory access pressure is lower than 0.2% by stress-ng
> >>> application.
> >>>
> >>> [1]
> >>> https://lore.kernel.org/all/20231025093847.3740104-4-zengheng4@huawei=
.com/
> >>> [2]
> >>> https://lore.kernel.org/all/20230328193846.8757-1-yang@os.amperecompu=
ting.com/
> >>> [3]
> >>> https://lore.kernel.org/all/20230418113459.12860-7-sumitg@nvidia.com/
> >>>
> >>> [4] My local test:
> >>> The testing platform enable SMT and include 128 logical CPU in total,
> >>> and CPU base frequency is 2.7GHz. Reading "cpuinfo_cur_freq" for each
> >>> physical core on platform during the high memory access pressure from
> >>> stress-ng, and the output is as follows:
> >>>    0: 2699133     2: 2699942     4: 2698189     6: 2704347
> >>>    8: 2704009    10: 2696277    12: 2702016    14: 2701388
> >>>   16: 2700358    18: 2696741    20: 2700091    22: 2700122
> >>>   24: 2701713    26: 2702025    28: 2699816    30: 2700121
> >>>   32: 2700000    34: 2699788    36: 2698884    38: 2699109
> >>>   40: 2704494    42: 2698350    44: 2699997    46: 2701023
> >>>   48: 2703448    50: 2699501    52: 2700000    54: 2699999
> >>>   56: 2702645    58: 2696923    60: 2697718    62: 2700547
> >>>   64: 2700313    66: 2700000    68: 2699904    70: 2699259
> >>>   72: 2699511    74: 2700644    76: 2702201    78: 2700000
> >>>   80: 2700776    82: 2700364    84: 2702674    86: 2700255
> >>>   88: 2699886    90: 2700359    92: 2699662    94: 2696188
> >>>   96: 2705454    98: 2699260   100: 2701097   102: 2699630
> >>> 104: 2700463   106: 2698408   108: 2697766   110: 2701181
> >>> 112: 2699166   114: 2701804   116: 2701907   118: 2701973
> >>> 120: 2699584   122: 2700474   124: 2700768   126: 2701963
> >>>
> >>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> >> First off, please Cc ACPI-related patches to linux-acpi.
> >
> > got it.
> >
> > +linux-acpi@vger.kernel.org
> >
> >>
> >>> ---
> >>>   arch/arm64/kernel/topology.c | 43
> >>> ++++++++++++++++++++++++++++++++++--
> >>>   drivers/acpi/cppc_acpi.c     | 22 +++++++++++++++---
> >>>   include/acpi/cppc_acpi.h     |  5 +++++
> >>>   3 files changed, 65 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/arch/arm64/kernel/topology.c
> >>> b/arch/arm64/kernel/topology.c
> >>> index 7d37e458e2f5..c3122154d738 100644
> >>> --- a/arch/arm64/kernel/topology.c
> >>> +++ b/arch/arm64/kernel/topology.c
> >>> @@ -299,6 +299,11 @@ core_initcall(init_amu_fie);
> >>>   #ifdef CONFIG_ACPI_CPPC_LIB
> >>>   #include <acpi/cppc_acpi.h>
> >>>
> >>> +struct amu_counters {
> >>> +       u64 corecnt;
> >>> +       u64 constcnt;
> >>> +};
> >>> +
> >>>   static void cpu_read_corecnt(void *val)
> >>>   {
> >>>          /*
> >>> @@ -322,8 +327,27 @@ static void cpu_read_constcnt(void *val)
> >>>                        0UL : read_constcnt();
> >>>   }
> >>>
> >>> +static void cpu_read_amu_counters(void *data)
> >>> +{
> >>> +       struct amu_counters *cnt =3D (struct amu_counters *)data;
> >>> +
> >>> +       /*
> >>> +        * The running time of the this_cpu_has_cap() might have a
> >>> couple of
> >>> +        * microseconds and is significantly increased to tens of
> >>> microseconds.
> >>> +        * But AMU core and constant counter need to be read togeter
> >>> without any
> >>> +        * time interval to reduce the calculation discrepancy using
> >>> this counters.
> >>> +        */
> >>> +       if (this_cpu_has_cap(ARM64_WORKAROUND_2457168)) {
> >>> +               cnt->corecnt =3D read_corecnt();
> >> This statement is present in both branches, so can it be moved before
> >> the if ()?
> > Yes.
> > Do you mean adding a blank line before if()?
> Sorry, I misunderstood you.
> The statement "cnt->corecnt =3D read_corecnt();" cannot be moved before
> the if().
> The AMU core and constant counter need to be read togeter without any
> time interval as described in code comments.
> The this_cpu_has_cap() is time-consuming.
> That is why I don't use the cpu_read_constcnt() to read constant counter.

So define something like

static inline void amu_read_counters(struct amu_counters *cnt, bool
read_constcnt)
{
              cnt->corecnt =3D read_corecnt();
              if (read_constcnt)
                            cnt->constcnt =3D read_constcnt();
              else
                            cnt->constcnt =3D 0;
}

> >>
> >>> +               cnt->constcnt =3D 0;
> >>> +       } else {
> >>> +               cnt->corecnt =3D read_corecnt();
> >>> +               cnt->constcnt =3D read_constcnt();
> >>> +       }

and use it like this:

amu_read_counters(cnt, !this_cpu_has_cap(ARM64_WORKAROUND_2457168);

It should work as expected AFAICS.

> >>> +}
> >>> +
> >>>   static inline
> >>> -int counters_read_on_cpu(int cpu, smp_call_func_t func, u64 *val)
> >>> +int counters_read_on_cpu(int cpu, smp_call_func_t func, void *data)
> >>>   {
> >>>          /*
> >>>           * Abort call on counterless CPU or when interrupts are
> >>> @@ -335,7 +359,7 @@ int counters_read_on_cpu(int cpu,
> >>> smp_call_func_t func, u64 *val)
> >>>          if (WARN_ON_ONCE(irqs_disabled()))
> >>>                  return -EPERM;
> >>>
> >>> -       smp_call_function_single(cpu, func, val, 1);
> >>> +       smp_call_function_single(cpu, func, data, 1);
> >>>
> >>>          return 0;
> >>>   }
> >>> @@ -364,6 +388,21 @@ bool cpc_ffh_supported(void)
> >>>          return true;
> >>>   }
> >>>
> >>> +int cpc_read_arch_counters_on_cpu(int cpu, u64 *delivered, u64
> >>> *reference)
> >>> +{
> >>> +       struct amu_counters cnts =3D {0};
> >>> +       int ret;
> >>> +
> >>> +       ret =3D counters_read_on_cpu(cpu, cpu_read_amu_counters, &cnt=
s);
> >>> +       if (ret)
> >>> +               return ret;
> >>> +
> >>> +       *delivered =3D cnts.corecnt;
> >>> +       *reference =3D cnts.constcnt;
> >>> +
> >>> +       return 0;
> >>> +}
> >>> +
> >>>   int cpc_read_ffh(int cpu, struct cpc_reg *reg, u64 *val)
> >>>   {
> >>>          int ret =3D -EOPNOTSUPP;
> >>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> >>> index 7ff269a78c20..f303fabd7cfe 100644
> >>> --- a/drivers/acpi/cppc_acpi.c
> >>> +++ b/drivers/acpi/cppc_acpi.c
> >>> @@ -1299,6 +1299,11 @@ bool cppc_perf_ctrs_in_pcc(void)
> >>>   }
> >>>   EXPORT_SYMBOL_GPL(cppc_perf_ctrs_in_pcc);
> >>>
> >>> +int __weak cpc_read_arch_counters_on_cpu(int cpu, u64 *delivered,
> >>> u64 *reference)
> >>> +{
> >>> +       return 0;
> >>> +}
> >>> +
> >>>   /**
> >>>    * cppc_get_perf_ctrs - Read a CPU's performance feedback counters.
> >>>    * @cpunum: CPU from which to read counters.
> >>> @@ -1313,7 +1318,8 @@ int cppc_get_perf_ctrs(int cpunum, struct
> >>> cppc_perf_fb_ctrs *perf_fb_ctrs)
> >>>                  *ref_perf_reg, *ctr_wrap_reg;
> >>>          int pcc_ss_id =3D per_cpu(cpu_pcc_subspace_idx, cpunum);
> >>>          struct cppc_pcc_data *pcc_ss_data =3D NULL;
> >>> -       u64 delivered, reference, ref_perf, ctr_wrap_time;
> >>> +       u64 delivered =3D 0, reference =3D 0;
> >>> +       u64 ref_perf, ctr_wrap_time;
> >>>          int ret =3D 0, regs_in_pcc =3D 0;
> >>>
> >>>          if (!cpc_desc) {
> >>> @@ -1350,8 +1356,18 @@ int cppc_get_perf_ctrs(int cpunum, struct
> >>> cppc_perf_fb_ctrs *perf_fb_ctrs)
> >>>                  }
> >>>          }
> >>>
> >>> -       cpc_read(cpunum, delivered_reg, &delivered);
> >>> -       cpc_read(cpunum, reference_reg, &reference);
> >>> +       if (cpc_ffh_supported()) {
> >>> +               ret =3D cpc_read_arch_counters_on_cpu(cpunum,
> >>> &delivered, &reference);
> >>> +               if (ret) {
> >>> +                       pr_debug("read arch counters failed,
> >>> ret=3D%d.\n", ret);
> >>> +                       ret =3D 0;
> >>> +               }
> >>> +       }
> >> The above is surely not applicable to every platform using CPPC.  Also
> >
> > cpc_ffh_supported is aimed to control only the platform supported FFH
> > to enter.
> > cpc_read_arch_counters_on_cpu is also needed to implemented by each
> > platform according to their require.

Well, exactly.

> > Here just implement this interface for arm64.

So on x86 cpc_ffh_supported() returns true and
cpc_read_arch_counters_on_cpu() will do nothing, so it will always
fall back to using cpc_read().  That is not particularly
straightforward IMV.

> >
> >> it looks like in the ARM64_WORKAROUND_2457168 enabled case it is just
> >> pointless overhead, because "reference" is always going to be 0 here
> >> then.
> > Right, it is always going to be 0 here for the
> > ARM64_WORKAROUND_2457168 enabled case .
> > But ARM64_WORKAROUND_2457168 is a macro releated to ARM.
> > It seems that it is not appropriate for this macro to appear this
> > common place for all platform, right?
> >
> >>
> >> Please clean that up.
> >>
> >>> +       if (!delivered || !reference) {
> >>> +               cpc_read(cpunum, delivered_reg, &delivered);
> >>> +               cpc_read(cpunum, reference_reg, &reference);
> >>> +       }
> >>> +
> >>>          cpc_read(cpunum, ref_perf_reg, &ref_perf);
> >>>
> >>>          /*
> >>> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> >>> index 6126c977ece0..07d4fd82d499 100644
> >>> --- a/include/acpi/cppc_acpi.h
> >>> +++ b/include/acpi/cppc_acpi.h
> >>> @@ -152,6 +152,7 @@ extern bool cpc_ffh_supported(void);
> >>>   extern bool cpc_supported_by_cpu(void);
> >>>   extern int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val);
> >>>   extern int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val);
> >>> +extern int cpc_read_arch_counters_on_cpu(int cpu, u64 *delivered,
> >>> u64 *reference);
> >>>   extern int cppc_get_epp_perf(int cpunum, u64 *epp_perf);
> >>>   extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls
> >>> *perf_ctrls, bool enable);
> >>>   extern int cppc_get_auto_sel_caps(int cpunum, struct
> >>> cppc_perf_caps *perf_caps);
> >>> @@ -209,6 +210,10 @@ static inline int cpc_write_ffh(int cpunum,
> >>> struct cpc_reg *reg, u64 val)
> >>>   {
> >>>          return -ENOTSUPP;
> >>>   }
> >>> +static inline int cpc_read_arch_counters_on_cpu(int cpu, u64
> >>> *delivered, u64 *reference)
> >>> +{
> >>> +       return -EOPNOTSUPP;
> >>> +}
> >>>   static inline int cppc_set_epp_perf(int cpu, struct
> >>> cppc_perf_ctrls *perf_ctrls, bool enable)
> >>>   {
> >>>          return -ENOTSUPP;
> >>> --
> >> .
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

