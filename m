Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0DA77AF350
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 20:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235635AbjIZSw0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 26 Sep 2023 14:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235600AbjIZSwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 14:52:24 -0400
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4545194;
        Tue, 26 Sep 2023 11:52:14 -0700 (PDT)
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-57c0775d4fcso237003eaf.0;
        Tue, 26 Sep 2023 11:52:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695754334; x=1696359134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T9EEcz88p/fMmIocGQC2OR/atoxLGQssRLX7uVCAPaw=;
        b=dxvB0OYlTRWk8m9GwiNlLSnUbZm0IgD0z69XrJYbi3+bzrb1HnAPU64ssEfGnjGIfl
         jV1ER00N0VchxtBzc70rsUck/sZ4wxAjlr+L1vEVCgXGtcwT52XyAfMx5ncNMi5UddWZ
         iClQypXMfPAHMsQKIVmgW1kzc6xNVWLbXpPhBz8xwqsEEF/UJjOhFuI4Wfd8w7MPm23v
         PNptk5OTnwafWQQIegi88ZlWzsEYT6WI7stG8mUr7qVTkKV8xBEg+XyVbS8f3W85C5JO
         tKkYa63gsh4SrSxGsuR1fTpFhloYihDWCufCX0yNx3mn/0QrlbxbjEcwPfbanjIMfHYN
         6caA==
X-Gm-Message-State: AOJu0YzPeN7hVE4QPPTDFBRjDdb76FLXLF4VPmfaY+zptPMcssqk5cf8
        8ZBhbUm/0xe0MzF75qOdfHZyzklGQgktpQeEZ+u/cyhH
X-Google-Smtp-Source: AGHT+IEps5gwhuO7dDcFysow/IakaV/533AnYfhx3qTxsdw8lwQoj9Y8KgqfkupQ33jpcOEe8kTM558LzkgKrI5qA+8=
X-Received: by 2002:a4a:d9da:0:b0:56e:94ed:c098 with SMTP id
 l26-20020a4ad9da000000b0056e94edc098mr9353747oou.0.1695754333687; Tue, 26 Sep
 2023 11:52:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230925081139.1305766-1-lukasz.luba@arm.com> <20230925081139.1305766-8-lukasz.luba@arm.com>
In-Reply-To: <20230925081139.1305766-8-lukasz.luba@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 26 Sep 2023 20:52:02 +0200
Message-ID: <CAJZ5v0iYkVKuVULv9X7EKpC9feh8UPf8S2ZnY+X+1tyOYn0ing@mail.gmail.com>
Subject: Re: [PATCH v4 07/18] PM: EM: Refactor struct em_perf_domain and add default_table
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org, dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
        qyousef@layalina.io, wvw@google.com
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

On Mon, Sep 25, 2023 at 10:11 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> The Energy Model is going to support runtime modifications. Refactor old
> implementation which accessed struct em_perf_state and introduce
> em_perf_domain::default_table to clean up the design. This new field
> will help to better distinguish 2 performance state tables.
>
> Update all drivers or frameworks which used the old field:
> em_perf_domain::table and now should use em_perf_domain::default_table.
>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/powercap/dtpm_cpu.c       | 27 +++++++++++++++++++--------
>  drivers/powercap/dtpm_devfreq.c   | 23 ++++++++++++++++-------
>  drivers/thermal/cpufreq_cooling.c | 24 ++++++++++++++++--------
>  drivers/thermal/devfreq_cooling.c | 23 +++++++++++++++++------
>  include/linux/energy_model.h      | 24 ++++++++++++++++++------
>  kernel/power/energy_model.c       | 26 ++++++++++++++++++++++----
>  6 files changed, 108 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
> index 2ff7717530bf..743a0ac8ecdf 100644
> --- a/drivers/powercap/dtpm_cpu.c
> +++ b/drivers/powercap/dtpm_cpu.c
> @@ -43,6 +43,7 @@ static u64 set_pd_power_limit(struct dtpm *dtpm, u64 power_limit)
>  {
>         struct dtpm_cpu *dtpm_cpu = to_dtpm_cpu(dtpm);
>         struct em_perf_domain *pd = em_cpu_get(dtpm_cpu->cpu);
> +       struct em_perf_state *table;
>         struct cpumask cpus;
>         unsigned long freq;
>         u64 power;
> @@ -51,19 +52,21 @@ static u64 set_pd_power_limit(struct dtpm *dtpm, u64 power_limit)
>         cpumask_and(&cpus, cpu_online_mask, to_cpumask(pd->cpus));
>         nr_cpus = cpumask_weight(&cpus);
>
> +       table = pd->default_table->state;
> +
>         for (i = 0; i < pd->nr_perf_states; i++) {
>
> -               power = pd->table[i].power * nr_cpus;
> +               power = table[i].power * nr_cpus;
>
>                 if (power > power_limit)
>                         break;
>         }
>
> -       freq = pd->table[i - 1].frequency;
> +       freq = table[i - 1].frequency;
>
>         freq_qos_update_request(&dtpm_cpu->qos_req, freq);
>
> -       power_limit = pd->table[i - 1].power * nr_cpus;
> +       power_limit = table[i - 1].power * nr_cpus;
>
>         return power_limit;
>  }
> @@ -88,12 +91,14 @@ static u64 scale_pd_power_uw(struct cpumask *pd_mask, u64 power)
>  static u64 get_pd_power_uw(struct dtpm *dtpm)
>  {
>         struct dtpm_cpu *dtpm_cpu = to_dtpm_cpu(dtpm);
> +       struct em_perf_state *table;
>         struct em_perf_domain *pd;
>         struct cpumask *pd_mask;
>         unsigned long freq;
>         int i;
>
>         pd = em_cpu_get(dtpm_cpu->cpu);
> +       table = pd->default_table->state;
>
>         pd_mask = em_span_cpus(pd);
>
> @@ -101,10 +106,10 @@ static u64 get_pd_power_uw(struct dtpm *dtpm)
>
>         for (i = 0; i < pd->nr_perf_states; i++) {
>
> -               if (pd->table[i].frequency < freq)
> +               if (table[i].frequency < freq)
>                         continue;
>
> -               return scale_pd_power_uw(pd_mask, pd->table[i].power *
> +               return scale_pd_power_uw(pd_mask, table[i].power *
>                                          MICROWATT_PER_MILLIWATT);
>         }
>
> @@ -115,17 +120,20 @@ static int update_pd_power_uw(struct dtpm *dtpm)
>  {
>         struct dtpm_cpu *dtpm_cpu = to_dtpm_cpu(dtpm);
>         struct em_perf_domain *em = em_cpu_get(dtpm_cpu->cpu);
> +       struct em_perf_state *table;
>         struct cpumask cpus;
>         int nr_cpus;
>
>         cpumask_and(&cpus, cpu_online_mask, to_cpumask(em->cpus));
>         nr_cpus = cpumask_weight(&cpus);
>
> -       dtpm->power_min = em->table[0].power;
> +       table = em->default_table->state;
> +
> +       dtpm->power_min = table[0].power;
>         dtpm->power_min *= MICROWATT_PER_MILLIWATT;
>         dtpm->power_min *= nr_cpus;
>
> -       dtpm->power_max = em->table[em->nr_perf_states - 1].power;
> +       dtpm->power_max = table[em->nr_perf_states - 1].power;
>         dtpm->power_max *= MICROWATT_PER_MILLIWATT;
>         dtpm->power_max *= nr_cpus;
>
> @@ -182,6 +190,7 @@ static int __dtpm_cpu_setup(int cpu, struct dtpm *parent)
>  {
>         struct dtpm_cpu *dtpm_cpu;
>         struct cpufreq_policy *policy;
> +       struct em_perf_state *table;
>         struct em_perf_domain *pd;
>         char name[CPUFREQ_NAME_LEN];
>         int ret = -ENOMEM;
> @@ -198,6 +207,8 @@ static int __dtpm_cpu_setup(int cpu, struct dtpm *parent)
>         if (!pd || em_is_artificial(pd))
>                 return -EINVAL;
>
> +       table = pd->default_table->state;
> +
>         dtpm_cpu = kzalloc(sizeof(*dtpm_cpu), GFP_KERNEL);
>         if (!dtpm_cpu)
>                 return -ENOMEM;
> @@ -216,7 +227,7 @@ static int __dtpm_cpu_setup(int cpu, struct dtpm *parent)
>
>         ret = freq_qos_add_request(&policy->constraints,
>                                    &dtpm_cpu->qos_req, FREQ_QOS_MAX,
> -                                  pd->table[pd->nr_perf_states - 1].frequency);
> +                                  table[pd->nr_perf_states - 1].frequency);
>         if (ret)
>                 goto out_dtpm_unregister;
>
> diff --git a/drivers/powercap/dtpm_devfreq.c b/drivers/powercap/dtpm_devfreq.c
> index 91276761a31d..6ef0f2b4a683 100644
> --- a/drivers/powercap/dtpm_devfreq.c
> +++ b/drivers/powercap/dtpm_devfreq.c
> @@ -37,11 +37,14 @@ static int update_pd_power_uw(struct dtpm *dtpm)
>         struct devfreq *devfreq = dtpm_devfreq->devfreq;
>         struct device *dev = devfreq->dev.parent;
>         struct em_perf_domain *pd = em_pd_get(dev);
> +       struct em_perf_state *table;
>
> -       dtpm->power_min = pd->table[0].power;
> +       table = pd->default_table->state;
> +
> +       dtpm->power_min = table[0].power;
>         dtpm->power_min *= MICROWATT_PER_MILLIWATT;
>
> -       dtpm->power_max = pd->table[pd->nr_perf_states - 1].power;
> +       dtpm->power_max = table[pd->nr_perf_states - 1].power;
>         dtpm->power_max *= MICROWATT_PER_MILLIWATT;
>
>         return 0;
> @@ -53,22 +56,25 @@ static u64 set_pd_power_limit(struct dtpm *dtpm, u64 power_limit)
>         struct devfreq *devfreq = dtpm_devfreq->devfreq;
>         struct device *dev = devfreq->dev.parent;
>         struct em_perf_domain *pd = em_pd_get(dev);
> +       struct em_perf_state *table;
>         unsigned long freq;
>         u64 power;
>         int i;
>
> +       table = pd->default_table->state;
> +
>         for (i = 0; i < pd->nr_perf_states; i++) {
>
> -               power = pd->table[i].power * MICROWATT_PER_MILLIWATT;
> +               power = table[i].power * MICROWATT_PER_MILLIWATT;
>                 if (power > power_limit)
>                         break;
>         }
>
> -       freq = pd->table[i - 1].frequency;
> +       freq = table[i - 1].frequency;
>
>         dev_pm_qos_update_request(&dtpm_devfreq->qos_req, freq);
>
> -       power_limit = pd->table[i - 1].power * MICROWATT_PER_MILLIWATT;
> +       power_limit = table[i - 1].power * MICROWATT_PER_MILLIWATT;
>
>         return power_limit;
>  }
> @@ -94,6 +100,7 @@ static u64 get_pd_power_uw(struct dtpm *dtpm)
>         struct device *dev = devfreq->dev.parent;
>         struct em_perf_domain *pd = em_pd_get(dev);
>         struct devfreq_dev_status status;
> +       struct em_perf_state *table;
>         unsigned long freq;
>         u64 power;
>         int i;
> @@ -102,15 +109,17 @@ static u64 get_pd_power_uw(struct dtpm *dtpm)
>         status = devfreq->last_status;
>         mutex_unlock(&devfreq->lock);
>
> +       table = pd->default_table->state;
> +
>         freq = DIV_ROUND_UP(status.current_frequency, HZ_PER_KHZ);
>         _normalize_load(&status);
>
>         for (i = 0; i < pd->nr_perf_states; i++) {
>
> -               if (pd->table[i].frequency < freq)
> +               if (table[i].frequency < freq)
>                         continue;
>
> -               power = pd->table[i].power * MICROWATT_PER_MILLIWATT;
> +               power = table[i].power * MICROWATT_PER_MILLIWATT;
>                 power *= status.busy_time;
>                 power >>= 10;
>
> diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
> index e2cc7bd30862..d468aca241e2 100644
> --- a/drivers/thermal/cpufreq_cooling.c
> +++ b/drivers/thermal/cpufreq_cooling.c
> @@ -91,10 +91,11 @@ struct cpufreq_cooling_device {
>  static unsigned long get_level(struct cpufreq_cooling_device *cpufreq_cdev,
>                                unsigned int freq)
>  {
> +       struct em_perf_state *table = cpufreq_cdev->em->default_table->state;
>         int i;
>
>         for (i = cpufreq_cdev->max_level - 1; i >= 0; i--) {
> -               if (freq > cpufreq_cdev->em->table[i].frequency)
> +               if (freq > table[i].frequency)
>                         break;
>         }
>
> @@ -104,15 +105,16 @@ static unsigned long get_level(struct cpufreq_cooling_device *cpufreq_cdev,
>  static u32 cpu_freq_to_power(struct cpufreq_cooling_device *cpufreq_cdev,
>                              u32 freq)
>  {
> +       struct em_perf_state *table = cpufreq_cdev->em->default_table->state;
>         unsigned long power_mw;
>         int i;
>
>         for (i = cpufreq_cdev->max_level - 1; i >= 0; i--) {
> -               if (freq > cpufreq_cdev->em->table[i].frequency)
> +               if (freq > table[i].frequency)
>                         break;
>         }
>
> -       power_mw = cpufreq_cdev->em->table[i + 1].power;
> +       power_mw = table[i + 1].power;
>         power_mw /= MICROWATT_PER_MILLIWATT;
>
>         return power_mw;
> @@ -121,18 +123,19 @@ static u32 cpu_freq_to_power(struct cpufreq_cooling_device *cpufreq_cdev,
>  static u32 cpu_power_to_freq(struct cpufreq_cooling_device *cpufreq_cdev,
>                              u32 power)
>  {
> +       struct em_perf_state *table = cpufreq_cdev->em->default_table->state;
>         unsigned long em_power_mw;
>         int i;
>
>         for (i = cpufreq_cdev->max_level; i > 0; i--) {
>                 /* Convert EM power to milli-Watts to make safe comparison */
> -               em_power_mw = cpufreq_cdev->em->table[i].power;
> +               em_power_mw = table[i].power;
>                 em_power_mw /= MICROWATT_PER_MILLIWATT;
>                 if (power >= em_power_mw)
>                         break;
>         }
>
> -       return cpufreq_cdev->em->table[i].frequency;
> +       return table[i].frequency;
>  }
>
>  /**
> @@ -262,8 +265,9 @@ static int cpufreq_get_requested_power(struct thermal_cooling_device *cdev,
>  static int cpufreq_state2power(struct thermal_cooling_device *cdev,
>                                unsigned long state, u32 *power)
>  {
> -       unsigned int freq, num_cpus, idx;
>         struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
> +       unsigned int freq, num_cpus, idx;
> +       struct em_perf_state *table;
>
>         /* Request state should be less than max_level */
>         if (state > cpufreq_cdev->max_level)
> @@ -271,8 +275,9 @@ static int cpufreq_state2power(struct thermal_cooling_device *cdev,
>
>         num_cpus = cpumask_weight(cpufreq_cdev->policy->cpus);
>
> +       table = cpufreq_cdev->em->default_table->state;
>         idx = cpufreq_cdev->max_level - state;
> -       freq = cpufreq_cdev->em->table[idx].frequency;
> +       freq = table[idx].frequency;
>         *power = cpu_freq_to_power(cpufreq_cdev, freq) * num_cpus;
>
>         return 0;
> @@ -378,8 +383,11 @@ static unsigned int get_state_freq(struct cpufreq_cooling_device *cpufreq_cdev,
>  #ifdef CONFIG_THERMAL_GOV_POWER_ALLOCATOR
>         /* Use the Energy Model table if available */
>         if (cpufreq_cdev->em) {
> +               struct em_perf_state *table;
> +
> +               table = cpufreq_cdev->em->default_table->state;
>                 idx = cpufreq_cdev->max_level - state;
> -               return cpufreq_cdev->em->table[idx].frequency;
> +               return table[idx].frequency;
>         }
>  #endif
>
> diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
> index 262e62ab6cf2..4207ef850582 100644
> --- a/drivers/thermal/devfreq_cooling.c
> +++ b/drivers/thermal/devfreq_cooling.c
> @@ -87,6 +87,7 @@ static int devfreq_cooling_set_cur_state(struct thermal_cooling_device *cdev,
>         struct devfreq_cooling_device *dfc = cdev->devdata;
>         struct devfreq *df = dfc->devfreq;
>         struct device *dev = df->dev.parent;
> +       struct em_perf_state *table;
>         unsigned long freq;
>         int perf_idx;
>
> @@ -99,8 +100,9 @@ static int devfreq_cooling_set_cur_state(struct thermal_cooling_device *cdev,
>                 return -EINVAL;
>
>         if (dfc->em_pd) {
> +               table = dfc->em_pd->default_table->state;
>                 perf_idx = dfc->max_state - state;
> -               freq = dfc->em_pd->table[perf_idx].frequency * 1000;
> +               freq = table[perf_idx].frequency * 1000;
>         } else {
>                 freq = dfc->freq_table[state];
>         }
> @@ -123,10 +125,11 @@ static int devfreq_cooling_set_cur_state(struct thermal_cooling_device *cdev,
>   */
>  static int get_perf_idx(struct em_perf_domain *em_pd, unsigned long freq)
>  {
> +       struct em_perf_state *table = em_pd->default_table->state;
>         int i;
>
>         for (i = 0; i < em_pd->nr_perf_states; i++) {
> -               if (em_pd->table[i].frequency == freq)
> +               if (table[i].frequency == freq)
>                         return i;
>         }
>
> @@ -181,6 +184,7 @@ static int devfreq_cooling_get_requested_power(struct thermal_cooling_device *cd
>         struct devfreq_cooling_device *dfc = cdev->devdata;
>         struct devfreq *df = dfc->devfreq;
>         struct devfreq_dev_status status;
> +       struct em_perf_state *table;
>         unsigned long state;
>         unsigned long freq;
>         unsigned long voltage;
> @@ -192,6 +196,8 @@ static int devfreq_cooling_get_requested_power(struct thermal_cooling_device *cd
>
>         freq = status.current_frequency;
>
> +       table = dfc->em_pd->default_table->state;
> +
>         if (dfc->power_ops && dfc->power_ops->get_real_power) {
>                 voltage = get_voltage(df, freq);
>                 if (voltage == 0) {
> @@ -204,7 +210,7 @@ static int devfreq_cooling_get_requested_power(struct thermal_cooling_device *cd
>                         state = dfc->capped_state;
>
>                         /* Convert EM power into milli-Watts first */
> -                       dfc->res_util = dfc->em_pd->table[state].power;
> +                       dfc->res_util = table[state].power;
>                         dfc->res_util /= MICROWATT_PER_MILLIWATT;
>
>                         dfc->res_util *= SCALE_ERROR_MITIGATION;
> @@ -225,7 +231,7 @@ static int devfreq_cooling_get_requested_power(struct thermal_cooling_device *cd
>                 _normalize_load(&status);
>
>                 /* Convert EM power into milli-Watts first */
> -               *power = dfc->em_pd->table[perf_idx].power;
> +               *power = table[perf_idx].power;
>                 *power /= MICROWATT_PER_MILLIWATT;
>                 /* Scale power for utilization */
>                 *power *= status.busy_time;
> @@ -245,13 +251,15 @@ static int devfreq_cooling_state2power(struct thermal_cooling_device *cdev,
>                                        unsigned long state, u32 *power)
>  {
>         struct devfreq_cooling_device *dfc = cdev->devdata;
> +       struct em_perf_state *table;
>         int perf_idx;
>
>         if (state > dfc->max_state)
>                 return -EINVAL;
>
> +       table = dfc->em_pd->default_table->state;
>         perf_idx = dfc->max_state - state;
> -       *power = dfc->em_pd->table[perf_idx].power;
> +       *power = table[perf_idx].power;
>         *power /= MICROWATT_PER_MILLIWATT;
>
>         return 0;
> @@ -264,6 +272,7 @@ static int devfreq_cooling_power2state(struct thermal_cooling_device *cdev,
>         struct devfreq *df = dfc->devfreq;
>         struct devfreq_dev_status status;
>         unsigned long freq, em_power_mw;
> +       struct em_perf_state *table;
>         s32 est_power;
>         int i;
>
> @@ -273,6 +282,8 @@ static int devfreq_cooling_power2state(struct thermal_cooling_device *cdev,
>
>         freq = status.current_frequency;
>
> +       table = dfc->em_pd->default_table->state;
> +
>         if (dfc->power_ops && dfc->power_ops->get_real_power) {
>                 /* Scale for resource utilization */
>                 est_power = power * dfc->res_util;
> @@ -290,7 +301,7 @@ static int devfreq_cooling_power2state(struct thermal_cooling_device *cdev,
>          */
>         for (i = dfc->max_state; i > 0; i--) {
>                 /* Convert EM power to milli-Watts to make safe comparison */
> -               em_power_mw = dfc->em_pd->table[i].power;
> +               em_power_mw = table[i].power;
>                 em_power_mw /= MICROWATT_PER_MILLIWATT;
>                 if (est_power >= em_power_mw)
>                         break;
> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> index 8069f526c9d8..d236e08e80dc 100644
> --- a/include/linux/energy_model.h
> +++ b/include/linux/energy_model.h
> @@ -36,9 +36,19 @@ struct em_perf_state {
>   */
>  #define EM_PERF_STATE_INEFFICIENT BIT(0)
>
> +/**
> + * struct em_perf_table - Performance states table
> + * @state:     List of performance states, in ascending order
> + * @rcu:       RCU used for safe access and destruction
> + */
> +struct em_perf_table {
> +       struct em_perf_state *state;
> +       struct rcu_head rcu;

There is no explanation of the role of this rcu_head in the changelog
or anywhere in this patch.

It is also not used as of this patch AFAICS.

It would be better to add it when it actually gets used IMV.
