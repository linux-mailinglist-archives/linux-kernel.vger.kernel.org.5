Return-Path: <linux-kernel+bounces-15708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D15F8230A9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 16:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F02E51F24886
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 15:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1C31B27F;
	Wed,  3 Jan 2024 15:37:50 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C371B267;
	Wed,  3 Jan 2024 15:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-595ffa2e6a2so164913eaf.0;
        Wed, 03 Jan 2024 07:37:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704296266; x=1704901066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=40j+IqysrfYQAUt1SJO3JpRmqTkW8BeHGoeDA+iZloI=;
        b=OoMLNn83L1QCMLgwVxFhxrcH9l0Y3nKZ7K8xTz8Kj9CYYO78NoVsqngB4f7rGeouZ6
         OGAdDK1nLxmHxJYmzFGH8dBMOR7DTvpha8xPV9p7fnMuaPPW2sIi2jZHNAD/fbP0wwdr
         uneEZLMnvJnfyocfMUgEx3tuZfN4TuVgp99P2nME/0qGO0Wj7RCNfxTdvcpye1ClXKda
         d3IwKVtMAW43hX6xrPHiB11hAkabITWwyrqHJuXHiyLkd4VrJcY8nIANOKpfcWDVcCwU
         bB0i7Tpw9pcRjXk1AVMy7iOTlJb1bTUGFOnGSXWVyHEiVcqrb3gbBd9B3tvqEivChZAh
         VuKg==
X-Gm-Message-State: AOJu0YzOs+YGVoUqxhki/LDr8FVQ2uikLtVdgVkqa6OoeRETQUPkvGHB
	jMJUslxVIoM7cgbPIHx0xo08Yxp9zHSEEDWTJZk=
X-Google-Smtp-Source: AGHT+IEQNWRFK5ZWxSqawWVegeMCE+VE1LW3uWj3cWaGWt2FsA5ZWT7ccUJrKWdr45QdTslurAf486vxU50F76ICkVM=
X-Received: by 2002:a4a:b38c:0:b0:595:6024:c4f8 with SMTP id
 p12-20020a4ab38c000000b005956024c4f8mr8288888ooo.1.1704296266137; Wed, 03 Jan
 2024 07:37:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228075705.26652-1-TonyWWang-oc@zhaoxin.com> <20231228075705.26652-4-TonyWWang-oc@zhaoxin.com>
In-Reply-To: <20231228075705.26652-4-TonyWWang-oc@zhaoxin.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 3 Jan 2024 16:37:35 +0100
Message-ID: <CAJZ5v0hEd-NV5WoRPOZgZwxNS6M=TKcw7DpDUM9MWFYAaa+1Mw@mail.gmail.com>
Subject: Re: [PATCH 3/3] ACPI: cpufreq: Add ITMT support when CPPC enabled for
 Zhaoxin CPUs
To: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Cc: rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	acpica-devel@lists.linux.dev, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	mcgrof@kernel.org, peterz@infradead.org, j.granados@samsung.com, 
	ricardo.neri-calderon@linux.intel.com, viresh.kumar@linaro.org, 
	linux-pm@vger.kernel.org, CobeChen@zhaoxin.com, TimGuo@zhaoxin.com, 
	LeoLiu-oc@zhaoxin.com, LindaChai@zhaoxin.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 28, 2023 at 8:57=E2=80=AFAM Tony W Wang-oc <TonyWWang-oc@zhaoxi=
n.com> wrote:
>
> For Zhaoxin CPUs, the cores' highest frequencies may be different, which
> means that cores may run at different max frequencies,
>
> According to ACPI-spec6 chapter 8.4.7, the per-core highest frequency
> value can be obtained via cppc.
>
> The core with the higher frequency have better performance, which can be
> called as preferred core. And better performance can be achieved by
> making the scheduler to run tasks on these preferred cores.
>
> The cpufreq driver can use the highest frequency value as the prioriy of
> core to make the scheduler try to get better performace. More specificall=
y,
> in the acpi-cpufreq driver use cppc_get_highest_perf() to get highest
> frequency value of each core, use sched_set_itmt_core_prio() to set
> highest frequency value as core priority, and use sched_set_itmt_support(=
)
> provided by ITMT to tell the scheduler to favor on the preferred cores.
>
> Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
> ---
>  drivers/cpufreq/acpi-cpufreq.c | 56 +++++++++++++++++++++++++++++++++-
>  1 file changed, 55 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufre=
q.c
> index 37f1cdf46d29..f4c1ff9e4bb0 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -663,8 +663,56 @@ static u64 get_max_boost_ratio(unsigned int cpu)
>
>         return div_u64(highest_perf << SCHED_CAPACITY_SHIFT, nominal_perf=
);
>  }
> +
> +/* The work item is needed to avoid CPU hotplug locking issues */
> +static void sched_itmt_work_fn(struct work_struct *work)
> +{
> +       sched_set_itmt_support();
> +}
> +
> +static DECLARE_WORK(sched_itmt_work, sched_itmt_work_fn);
> +
> +static void set_itmt_prio(int cpu)
> +{
> +       static bool cppc_highest_perf_diff;
> +       static struct cpumask core_prior_mask;
> +       u64 highest_perf;
> +       static u64 max_highest_perf =3D 0, min_highest_perf =3D U64_MAX;
> +       int ret;
> +
> +       ret =3D cppc_get_highest_perf(cpu, &highest_perf);
> +       if (ret)
> +               return;
> +
> +       sched_set_itmt_core_prio(highest_perf, cpu);
> +       cpumask_set_cpu(cpu, &core_prior_mask);
> +
> +       if (max_highest_perf <=3D min_highest_perf) {
> +               if (highest_perf > max_highest_perf)
> +                       max_highest_perf =3D highest_perf;
> +
> +               if (highest_perf < min_highest_perf)
> +                       min_highest_perf =3D highest_perf;
> +
> +               if (max_highest_perf > min_highest_perf) {
> +                       /*
> +                        * This code can be run during CPU online under t=
he
> +                        * CPU hotplug locks, so sched_set_itmt_support()
> +                        * cannot be called from here.  Queue up a work i=
tem
> +                        * to invoke it.
> +                        */
> +                       cppc_highest_perf_diff =3D true;
> +               }
> +       }
> +
> +       if (cppc_highest_perf_diff && cpumask_equal(&core_prior_mask, cpu=
_online_mask)) {
> +               pr_debug("queue a work to set itmt enabled\n");
> +               schedule_work(&sched_itmt_work);
> +       }
> +}
>  #else
>  static inline u64 get_max_boost_ratio(unsigned int cpu) { return 0; }
> +static void set_itmt_prio(int cpu) { }
>  #endif
>
>  static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
> @@ -677,7 +725,7 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_polic=
y *policy)
>         unsigned int valid_states =3D 0;
>         unsigned int result =3D 0;
>         u64 max_boost_ratio;
> -       unsigned int i;
> +       unsigned int i, j;
>  #ifdef CONFIG_SMP
>         static int blacklisted;
>  #endif
> @@ -742,6 +790,12 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_poli=
cy *policy)
>         }
>  #endif
>
> +       if (c->x86_vendor =3D=3D X86_VENDOR_CENTAUR || c->x86_vendor =3D=
=3D X86_VENDOR_ZHAOXIN) {
> +               for_each_cpu(j, policy->cpus) {
> +                       set_itmt_prio(j);
> +               }
> +       }
> +
>         /* capability check */
>         if (perf->state_count <=3D 1) {
>                 pr_debug("No P-States\n");
> --

Have you considered using the CPPC cpufreq driver on those platforms?

