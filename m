Return-Path: <linux-kernel+bounces-9016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D5081BF4D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0C19287C83
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF56745C7;
	Thu, 21 Dec 2023 20:02:05 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2E4651AC;
	Thu, 21 Dec 2023 20:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3b9fb227545so128397b6e.1;
        Thu, 21 Dec 2023 12:02:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703188922; x=1703793722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XtaH4nkfWzBTwDdIvfbGlDnvjw8JE5Ezgnk1g1ujwFU=;
        b=SZUYhR1COwghtL1SSkwv3ODZN6gJgaJlFX+LhepSn/Z/1x5In6x1qw/jsLUySmPyN1
         gMCJ+0QR/lWYS8gCN1hnaqvFvg2TLMmVbsfEFuTRXeaFSIjiUI3mMKAg+cxD7Dzf61NC
         iUa+55f1wVJZy09usJzhcK7kSQQeVgmvpnFzRwWQMLjgFGOI3FNyzfo6FwBbdBymHYjd
         KjJDz0aDxdcLx18ENlW9ebrvVuXtL2tqE/GcW3neRWBaeQnIhy11/VbvJF6qTZK2hqmi
         Crw7AhfaSUibW45tftytL+h2LPpysZHcqijM/DK2oaTov/kJ4w3SKSmw5B+HAik2P7xv
         fO9w==
X-Gm-Message-State: AOJu0YztrOgglb6rc7qu7X1/hXxUcHf5IOkJJNR3ah/iiDjriq8oHIag
	vb6oVyTWdcW3GnaqiKOMdh9qhumoMkdkXsFyqBw=
X-Google-Smtp-Source: AGHT+IH33M1GYQpUeZctljakeSCCKWDW84ql+MSWV1uSzlfgr2dBzY+jzJjK2q40LQCBT5BHCrdWJqsMldXJwwVwD+A=
X-Received: by 2002:a05:6820:1043:b0:594:36ea:b0ce with SMTP id
 x3-20020a056820104300b0059436eab0cemr361932oot.0.1703188922498; Thu, 21 Dec
 2023 12:02:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221152407.436177-1-vincent.guittot@linaro.org>
 <20231221152407.436177-2-vincent.guittot@linaro.org> <CAJZ5v0iU+nx_Tk_K74=dfeOuA7Lyvbq51UW=U1L4mZVEKy-+ZQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0iU+nx_Tk_K74=dfeOuA7Lyvbq51UW=U1L4mZVEKy-+ZQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 21 Dec 2023 21:01:51 +0100
Message-ID: <CAJZ5v0iChOQKpHaQy+Q0e9bBDjPsB107qk0FfT1z8_exFXiJdQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] cpufreq: Add a cpufreq pressure feedback for the scheduler
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: catalin.marinas@arm.com, will@kernel.org, sudeep.holla@arm.com, 
	rafael@kernel.org, viresh.kumar@linaro.org, agross@kernel.org, 
	andersson@kernel.org, konrad.dybcio@linaro.org, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, bristot@redhat.com, 
	vschneid@redhat.com, lukasz.luba@arm.com, rui.zhang@intel.com, 
	mhiramat@kernel.org, daniel.lezcano@linaro.org, amit.kachhap@gmail.com, 
	linux@armlinux.org.uk, corbet@lwn.net, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 8:57=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Thu, Dec 21, 2023 at 4:24=E2=80=AFPM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > Provide to the scheduler a feedback about the temporary max available
> > capacity. Unlike arch_update_thermal_pressure, this doesn't need to be
> > filtered as the pressure will happen for dozens ms or more.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  drivers/cpufreq/cpufreq.c | 34 ++++++++++++++++++++++++++++++++++
> >  include/linux/cpufreq.h   | 10 ++++++++++
> >  2 files changed, 44 insertions(+)
> >
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 44db4f59c4cc..15bd41f9bb5e 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -2563,6 +2563,38 @@ int cpufreq_get_policy(struct cpufreq_policy *po=
licy, unsigned int cpu)
> >  }
> >  EXPORT_SYMBOL(cpufreq_get_policy);
> >
> > +DEFINE_PER_CPU(unsigned long, cpufreq_pressure);
> > +
> > +/**
> > + * cpufreq_update_pressure() - Update cpufreq pressure for CPUs
> > + * @policy: cpufreq policy of the CPUs.
> > + *
> > + * Update the value of cpufreq pressure for all @cpus in the policy.
> > + */
> > +static void cpufreq_update_pressure(struct cpufreq_policy *policy)
> > +{
> > +       unsigned long max_capacity, capped_freq, pressure;
> > +       u32 max_freq;
> > +       int cpu;
> > +
> > +       cpu =3D cpumask_first(policy->related_cpus);
> > +       pressure =3D max_capacity =3D arch_scale_cpu_capacity(cpu);
>
> I would prefer two separate statements instead of the above.
>
> Other than this
>
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>
>
> > +       capped_freq =3D policy->max;
> > +       max_freq =3D arch_scale_freq_ref(cpu);
> > +
> > +       /*
> > +        * Handle properly the boost frequencies, which should simply c=
lean
> > +        * the thermal pressure value.
> > +        */
> > +       if (max_freq <=3D capped_freq)
> > +               pressure -=3D max_capacity;

Actually, it would be somewhat cleaner to do

pressure =3D 0;

here and

> > +       else
> > +               pressure -=3D mult_frac(max_capacity, capped_freq, max_=
freq);

pressure =3D max_capacity - mult_frac(max_capacity, capped_freq, max_freq);

and it would not be necessary to initialize pressure.

> > +
> > +       for_each_cpu(cpu, policy->related_cpus)
> > +               WRITE_ONCE(per_cpu(cpufreq_pressure, cpu), pressure);
> > +}
> > +
> >  /**
> >   * cpufreq_set_policy - Modify cpufreq policy parameters.
> >   * @policy: Policy object to modify.
> > @@ -2618,6 +2650,8 @@ static int cpufreq_set_policy(struct cpufreq_poli=
cy *policy,
> >         policy->max =3D __resolve_freq(policy, policy->max, CPUFREQ_REL=
ATION_H);
> >         trace_cpu_frequency_limits(policy);
> >
> > +       cpufreq_update_pressure(policy);
> > +
> >         policy->cached_target_freq =3D UINT_MAX;
> >
> >         pr_debug("new min and max freqs are %u - %u kHz\n",
> > diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> > index afda5f24d3dd..b1d97edd3253 100644
> > --- a/include/linux/cpufreq.h
> > +++ b/include/linux/cpufreq.h
> > @@ -241,6 +241,12 @@ struct kobject *get_governor_parent_kobj(struct cp=
ufreq_policy *policy);
> >  void cpufreq_enable_fast_switch(struct cpufreq_policy *policy);
> >  void cpufreq_disable_fast_switch(struct cpufreq_policy *policy);
> >  bool has_target_index(void);
> > +
> > +DECLARE_PER_CPU(unsigned long, cpufreq_pressure);
> > +static inline unsigned long cpufreq_get_pressure(int cpu)
> > +{
> > +       return per_cpu(cpufreq_pressure, cpu);
> > +}
> >  #else
> >  static inline unsigned int cpufreq_get(unsigned int cpu)
> >  {
> > @@ -263,6 +269,10 @@ static inline bool cpufreq_supports_freq_invarianc=
e(void)
> >         return false;
> >  }
> >  static inline void disable_cpufreq(void) { }
> > +static inline unsigned long cpufreq_get_pressure(int cpu)
> > +{
> > +       return 0;
> > +}
> >  #endif
> >
> >  #ifdef CONFIG_CPU_FREQ_STAT
> > --
> > 2.34.1
> >

