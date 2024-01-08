Return-Path: <linux-kernel+bounces-19668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0FF82709A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 619C41C2265E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E56D46542;
	Mon,  8 Jan 2024 14:03:11 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4F047A52;
	Mon,  8 Jan 2024 14:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 285F8C15;
	Mon,  8 Jan 2024 06:03:54 -0800 (PST)
Received: from localhost (ionvoi01-desktop.cambridge.arm.com [10.2.78.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC12E3F64C;
	Mon,  8 Jan 2024 06:03:07 -0800 (PST)
Date: Mon, 8 Jan 2024 14:03:06 +0000
From: Ionela Voinescu <ionela.voinescu@arm.com>
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, rafael@kernel.org,
	beata.michalska@arm.com, sumitg@nvidia.com, zengheng4@huawei.com,
	yang@os.amperecomputing.com, will@kernel.org, sudeep.holla@arm.com,
	liuyonglong@huawei.com, zhanjie9@hisilicon.com,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: CPPC: Resolve the large frequency discrepancy
 from cpuinfo_cur_freq
Message-ID: <ZZwAmqp6hcmMF8aN@arm.com>
References: <20231212072617.14756-1-lihuisong@huawei.com>
 <ZZWfJOsDlEXWYHA5@arm.com>
 <9428a1ed-ba4d-1fe6-63e8-11e152bf1f09@huawei.com>
 <lnocwcitdbmgcyhd2dlczgdlhtfw4pfot2br2i3hqscnvr3xgq@nuxlauxum3nr>
 <d0f47e9d-6a58-8b46-89be-b3182abb69f0@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d0f47e9d-6a58-8b46-89be-b3182abb69f0@huawei.com>

Hi,

On Friday 05 Jan 2024 at 15:04:47 (+0800), lihuisong (C) wrote:
> Hi Vanshi,
> 
> 在 2024/1/5 8:48, Vanshidhar Konda 写道:
> > On Thu, Jan 04, 2024 at 05:36:51PM +0800, lihuisong (C) wrote:
> > > 
> > > 在 2024/1/4 1:53, Ionela Voinescu 写道:
> > > > Hi,
> > > > 
> > > > On Tuesday 12 Dec 2023 at 15:26:17 (+0800), Huisong Li wrote:
> > > > > Many developers found that the cpu current frequency is greater than
> > > > > the maximum frequency of the platform, please see [1], [2] and [3].
> > > > > 
> > > > > In the scenarios with high memory access pressure, the patch [1] has
> > > > > proved the significant latency of cpc_read() which is used to obtain
> > > > > delivered and reference performance counter cause an absurd frequency.
> > > > > The sampling interval for this counters is very critical and
> > > > > is expected
> > > > > to be equal. However, the different latency of cpc_read() has a direct
> > > > > impact on their sampling interval.
> > > > > 
> > > > Would this [1] alternative solution work for you?
> > > It would work for me AFAICS.
> > > Because the "arch_freq_scale" is also from AMU core and constant
> > > counter, and read together.
> > > But, from their discuss line, it seems that there are some tricky
> > > points to clarify or consider.
> > 
> > I think the changes in [1] would work better when CPUs may be idle. With
> > this
> > patch we would have to wake any core that is in idle state to read the
> > AMU
> > counters. Worst case, if core 0 is trying to read the CPU frequency of
> > all
> > cores, it may need to wake up all the other cores to read the AMU
> > counters.
> From the approach in [1], if all CPUs (one or more cores) under one policy
> are idle, they still cannot be obtained the CPU frequency, right?
> In this case, the [1] API will return 0 and have to back to call
> cpufreq_driver->get() for cpuinfo_cur_freq.
> Then we still need to face the issue this patch mentioned.

With the implementation at [1], arch_freq_get_on_cpu() will not return 0
for idle CPUs and the get() callback will not be called to wake up the
CPUs.

Worst case, arch_freq_get_on_cpu() will return a frequency based on the
AMU counter values obtained on the last tick on that CPU. But if that CPU
is not a housekeeping CPU, a housekeeping CPU in the same policy will be
selected, as it would have had a more recent tick, and therefore a more
recent frequency value for the domain.

I understand that the frequency returned here will not be up to date,
but there's no proper frequency feedback for an idle CPU. If one only
wakes up a CPU to sample counters, before the CPU goes back to sleep,
the obtained frequency feedback is meaningless.

> > For systems with 128 cores or more, this could be very expensive and
> > happen
> > very frequently.
> > 
> > AFAICS, the approach in [1] would avoid this cost.
> But the CPU frequency is just an average value for the last tick period
> instead of the current one the CPU actually runs at.
> In addition, there are some conditions to use 'arch_freq_scale' in this
> approach.

What are the conditions you are referring to?

> So I'm not sure if this approach can entirely cover the frequency
> discrepancy issue.

Unfortunately there is no perfect frequency feedback. By the time you
observe/use the value of scaling_cur_freq/cpuinfo_cur_freq, the frequency
of the CPU might have already changed. Therefore, an average value might
be a better indication of the recent performance level of a CPU.

Would you be able to test [1] on your platform and usecase?

Many thanks,
Ionela.

> 
> /Huisong
> 
> > > > 
> > > > [1] https://lore.kernel.org/lkml/20231127160838.1403404-1-beata.michalska@arm.com/
> > > > 
> > > > Thanks,
> > > > Ionela.
> > > > 
> > > > > This patch adds a interface, cpc_read_arch_counters_on_cpu, to read
> > > > > delivered and reference performance counter together. According to my
> > > > > test[4], the discrepancy of cpu current frequency in the
> > > > > scenarios with
> > > > > high memory access pressure is lower than 0.2% by stress-ng
> > > > > application.
> > > > > 
> > > > > [1] https://lore.kernel.org/all/20231025093847.3740104-4-zengheng4@huawei.com/
> > > > > [2] https://lore.kernel.org/all/20230328193846.8757-1-yang@os.amperecomputing.com/
> > > > > [3]
> > > > > https://lore.kernel.org/all/20230418113459.12860-7-sumitg@nvidia.com/
> > > > > 
> > > > > [4] My local test:
> > > > > The testing platform enable SMT and include 128 logical CPU in total,
> > > > > and CPU base frequency is 2.7GHz. Reading "cpuinfo_cur_freq" for each
> > > > > physical core on platform during the high memory access pressure from
> > > > > stress-ng, and the output is as follows:
> > > > >   0: 2699133     2: 2699942     4: 2698189     6: 2704347
> > > > >   8: 2704009    10: 2696277    12: 2702016    14: 2701388
> > > > >  16: 2700358    18: 2696741    20: 2700091    22: 2700122
> > > > >  24: 2701713    26: 2702025    28: 2699816    30: 2700121
> > > > >  32: 2700000    34: 2699788    36: 2698884    38: 2699109
> > > > >  40: 2704494    42: 2698350    44: 2699997    46: 2701023
> > > > >  48: 2703448    50: 2699501    52: 2700000    54: 2699999
> > > > >  56: 2702645    58: 2696923    60: 2697718    62: 2700547
> > > > >  64: 2700313    66: 2700000    68: 2699904    70: 2699259
> > > > >  72: 2699511    74: 2700644    76: 2702201    78: 2700000
> > > > >  80: 2700776    82: 2700364    84: 2702674    86: 2700255
> > > > >  88: 2699886    90: 2700359    92: 2699662    94: 2696188
> > > > >  96: 2705454    98: 2699260   100: 2701097   102: 2699630
> > > > > 104: 2700463   106: 2698408   108: 2697766   110: 2701181
> > > > > 112: 2699166   114: 2701804   116: 2701907   118: 2701973
> > > > > 120: 2699584   122: 2700474   124: 2700768   126: 2701963
> > > > > 
> > > > > Signed-off-by: Huisong Li <lihuisong@huawei.com>
> > > > > ---
> > > > >  arch/arm64/kernel/topology.c | 43
> > > > > ++++++++++++++++++++++++++++++++++--
> > > > >  drivers/acpi/cppc_acpi.c     | 22 +++++++++++++++---
> > > > >  include/acpi/cppc_acpi.h     |  5 +++++
> > > > >  3 files changed, 65 insertions(+), 5 deletions(-)
> > > > > 
> > > > > diff --git a/arch/arm64/kernel/topology.c
> > > > > b/arch/arm64/kernel/topology.c
> > > > > index 7d37e458e2f5..c3122154d738 100644
> > > > > --- a/arch/arm64/kernel/topology.c
> > > > > +++ b/arch/arm64/kernel/topology.c
> > > > > @@ -299,6 +299,11 @@ core_initcall(init_amu_fie);
> > > > >  #ifdef CONFIG_ACPI_CPPC_LIB
> > > > >  #include <acpi/cppc_acpi.h>
> > > > > +struct amu_counters {
> > > > > +    u64 corecnt;
> > > > > +    u64 constcnt;
> > > > > +};
> > > > > +
> > > > >  static void cpu_read_corecnt(void *val)
> > > > >  {
> > > > >      /*
> > > > > @@ -322,8 +327,27 @@ static void cpu_read_constcnt(void *val)
> > > > >                0UL : read_constcnt();
> > > > >  }
> > > > > +static void cpu_read_amu_counters(void *data)
> > > > > +{
> > > > > +    struct amu_counters *cnt = (struct amu_counters *)data;
> > > > > +
> > > > > +    /*
> > > > > +     * The running time of the this_cpu_has_cap() might
> > > > > have a couple of
> > > > > +     * microseconds and is significantly increased to tens
> > > > > of microseconds.
> > > > > +     * But AMU core and constant counter need to be read
> > > > > togeter without any
> > > > > +     * time interval to reduce the calculation discrepancy
> > > > > using this counters.
> > > > > +     */
> > > > > +    if (this_cpu_has_cap(ARM64_WORKAROUND_2457168)) {
> > > > > +        cnt->corecnt = read_corecnt();
> > > > > +        cnt->constcnt = 0;
> > > > > +    } else {
> > > > > +        cnt->corecnt = read_corecnt();
> > > > > +        cnt->constcnt = read_constcnt();
> > > > > +    }
> > > > > +}
> > > > > +
> > > > >  static inline
> > > > > -int counters_read_on_cpu(int cpu, smp_call_func_t func, u64 *val)
> > > > > +int counters_read_on_cpu(int cpu, smp_call_func_t func, void *data)
> > > > >  {
> > > > >      /*
> > > > >       * Abort call on counterless CPU or when interrupts are
> > > > > @@ -335,7 +359,7 @@ int counters_read_on_cpu(int cpu,
> > > > > smp_call_func_t func, u64 *val)
> > > > >      if (WARN_ON_ONCE(irqs_disabled()))
> > > > >          return -EPERM;
> > > > > -    smp_call_function_single(cpu, func, val, 1);
> > > > > +    smp_call_function_single(cpu, func, data, 1);
> > > > >      return 0;
> > > > >  }
> > > > > @@ -364,6 +388,21 @@ bool cpc_ffh_supported(void)
> > > > >      return true;
> > > > >  }
> > > > > +int cpc_read_arch_counters_on_cpu(int cpu, u64 *delivered,
> > > > > u64 *reference)
> > > > > +{
> > > > > +    struct amu_counters cnts = {0};
> > > > > +    int ret;
> > > > > +
> > > > > +    ret = counters_read_on_cpu(cpu, cpu_read_amu_counters, &cnts);
> > > > > +    if (ret)
> > > > > +        return ret;
> > > > > +
> > > > > +    *delivered = cnts.corecnt;
> > > > > +    *reference = cnts.constcnt;
> > > > > +
> > > > > +    return 0;
> > > > > +}
> > > > > +
> > > > >  int cpc_read_ffh(int cpu, struct cpc_reg *reg, u64 *val)
> > > > >  {
> > > > >      int ret = -EOPNOTSUPP;
> > > > > diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> > > > > index 7ff269a78c20..f303fabd7cfe 100644
> > > > > --- a/drivers/acpi/cppc_acpi.c
> > > > > +++ b/drivers/acpi/cppc_acpi.c
> > > > > @@ -1299,6 +1299,11 @@ bool cppc_perf_ctrs_in_pcc(void)
> > > > >  }
> > > > >  EXPORT_SYMBOL_GPL(cppc_perf_ctrs_in_pcc);
> > > > > +int __weak cpc_read_arch_counters_on_cpu(int cpu, u64
> > > > > *delivered, u64 *reference)
> > > > > +{
> > > > > +    return 0;
> > > > > +}
> > > > > +
> > > > >  /**
> > > > >   * cppc_get_perf_ctrs - Read a CPU's performance feedback counters.
> > > > >   * @cpunum: CPU from which to read counters.
> > > > > @@ -1313,7 +1318,8 @@ int cppc_get_perf_ctrs(int cpunum,
> > > > > struct cppc_perf_fb_ctrs *perf_fb_ctrs)
> > > > >          *ref_perf_reg, *ctr_wrap_reg;
> > > > >      int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
> > > > >      struct cppc_pcc_data *pcc_ss_data = NULL;
> > > > > -    u64 delivered, reference, ref_perf, ctr_wrap_time;
> > > > > +    u64 delivered = 0, reference = 0;
> > > > > +    u64 ref_perf, ctr_wrap_time;
> > > > >      int ret = 0, regs_in_pcc = 0;
> > > > >      if (!cpc_desc) {
> > > > > @@ -1350,8 +1356,18 @@ int cppc_get_perf_ctrs(int cpunum,
> > > > > struct cppc_perf_fb_ctrs *perf_fb_ctrs)
> > > > >          }
> > > > >      }
> > > > > -    cpc_read(cpunum, delivered_reg, &delivered);
> > > > > -    cpc_read(cpunum, reference_reg, &reference);
> > > > > +    if (cpc_ffh_supported()) {
> > > > > +        ret = cpc_read_arch_counters_on_cpu(cpunum,
> > > > > &delivered, &reference);
> > > > > +        if (ret) {
> > > > > +            pr_debug("read arch counters failed, ret=%d.\n", ret);
> > > > > +            ret = 0;
> > > > > +        }
> > > > > +    }
> > > > > +    if (!delivered || !reference) {
> > > > > +        cpc_read(cpunum, delivered_reg, &delivered);
> > > > > +        cpc_read(cpunum, reference_reg, &reference);
> > > > > +    }
> > > > > +
> > > > >      cpc_read(cpunum, ref_perf_reg, &ref_perf);
> > > > >      /*
> > > > > diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> > > > > index 6126c977ece0..07d4fd82d499 100644
> > > > > --- a/include/acpi/cppc_acpi.h
> > > > > +++ b/include/acpi/cppc_acpi.h
> > > > > @@ -152,6 +152,7 @@ extern bool cpc_ffh_supported(void);
> > > > >  extern bool cpc_supported_by_cpu(void);
> > > > >  extern int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val);
> > > > >  extern int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val);
> > > > > +extern int cpc_read_arch_counters_on_cpu(int cpu, u64
> > > > > *delivered, u64 *reference);
> > > > >  extern int cppc_get_epp_perf(int cpunum, u64 *epp_perf);
> > > > >  extern int cppc_set_epp_perf(int cpu, struct
> > > > > cppc_perf_ctrls *perf_ctrls, bool enable);
> > > > >  extern int cppc_get_auto_sel_caps(int cpunum, struct
> > > > > cppc_perf_caps *perf_caps);
> > > > > @@ -209,6 +210,10 @@ static inline int cpc_write_ffh(int
> > > > > cpunum, struct cpc_reg *reg, u64 val)
> > > > >  {
> > > > >      return -ENOTSUPP;
> > > > >  }
> > > > > +static inline int cpc_read_arch_counters_on_cpu(int cpu,
> > > > > u64 *delivered, u64 *reference)
> > > > > +{
> > > > > +    return -EOPNOTSUPP;
> > > > > +}
> > > > >  static inline int cppc_set_epp_perf(int cpu, struct
> > > > > cppc_perf_ctrls *perf_ctrls, bool enable)
> > > > >  {
> > > > >      return -ENOTSUPP;
> > > > > -- 
> > > > > 2.33.0
> > > > > 
> > > > .
> > > 
> > > _______________________________________________
> > > linux-arm-kernel mailing list
> > > linux-arm-kernel@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > 
> > .

