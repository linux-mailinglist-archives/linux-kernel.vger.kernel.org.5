Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDACD7BBFFF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 22:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbjJFUH4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 6 Oct 2023 16:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233306AbjJFUHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 16:07:54 -0400
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D47BD;
        Fri,  6 Oct 2023 13:07:53 -0700 (PDT)
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-57de3096e25so468179eaf.1;
        Fri, 06 Oct 2023 13:07:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696622872; x=1697227672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yi8IHkhUe0aac+4wlgQ6/aSkZ2gvlW+JPHDq/3mOla0=;
        b=tEXBpTPSXU2T3MQXxPGKb2ka+1B3mC/6jHEZKtH/5P+/Zk9t41IPd3SZzk+taBF2XB
         UBb/b8sfedGCOlcHTjWQGQMspxqU1mAsLeoHh/NUWNPRO0GW2lTMCjHeOgEt7xc/pum4
         LhKMwqFLh/GV7gbwOiyi6HuX91RbZiQjRLFdooinOEzJlw6foob3IyNbOkUypzZ5s8IR
         nuOz4W8uSWO6hzlYxKbS26fIxwoD04AcgOi1EPLR8ouaPJ5EasJxRtQrjgAvk3YmXNPF
         CDNG+ScrrdKstmrNA2uSYTTLNHl/WGEQzztnDszgDHT22FU8npO1fKC620yokrj3k++g
         9BsQ==
X-Gm-Message-State: AOJu0Yyhjq8f3s66WJWSAf+iG4OPxVh76r35Evjcbtaz0ekydSGiWZsK
        6F7A+ytT1rMYAiFPDTh7TuYP04t64phzAEjIk/c=
X-Google-Smtp-Source: AGHT+IH83w1+L9n9SEM0zfgntM+xmt+afPwlFw05NNYwUcG+AlqS8R1yQE+t4ohzfK8blQkiwoxZnH/jijtFP2zINSI=
X-Received: by 2002:a4a:c509:0:b0:57e:c9bf:696e with SMTP id
 i9-20020a4ac509000000b0057ec9bf696emr9112969ooq.1.1696622872620; Fri, 06 Oct
 2023 13:07:52 -0700 (PDT)
MIME-Version: 1.0
References: <20231005134120.1217829-1-pierre.gondois@arm.com> <20231006070707.ia4qa25citvvbn45@vireshk-i7>
In-Reply-To: <20231006070707.ia4qa25citvvbn45@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 6 Oct 2023 22:07:41 +0200
Message-ID: <CAJZ5v0jB2kn3CfX_-hdH0cVcEo5pwrMAEhvPmpmHgYkYx9GW1g@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: Rebuild sched-domains when removing cpufreq driver
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Pierre Gondois <pierre.gondois@arm.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 6, 2023 at 9:07 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 05-10-23, 15:41, Pierre Gondois wrote:
> > The Energy Aware Scheduler (EAS) relies on the schedutil governor.
> > When moving to/from the schedutil governor, sched domains must be
> > rebuilt to allow re-evaluating the enablement conditions of EAS.
> > This is done through sched_cpufreq_governor_change().
> >
> > Having a cpufreq governor assumes a cpufreq driver is running.
> > Inserting/removing a cpufreq driver should trigger a re-evaluation
> > of EAS enablement conditions, avoiding to see EAS enabled when
> > removing a running cpufreq driver.
> >
> > Rebuild the sched domains in schedutil's sugov_init()/sugov_exit(),
> > allowing to check EAS's enablement condition whenever schedutil
> > governor is initialized/exited from.
> > Move relevant code up in schedutil.c to avoid a split and conditional
> > function declaration.
> > Rename sched_cpufreq_governor_change() to sugov_eas_rebuild_sd().
> >
> > Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> > ---
> >  drivers/cpufreq/cpufreq.c        |  3 +-
> >  include/linux/cpufreq.h          |  8 -----
> >  kernel/sched/cpufreq_schedutil.c | 55 +++++++++++++++++---------------
> >  3 files changed, 30 insertions(+), 36 deletions(-)
> >
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 60ed89000e82..4bc15634d49c 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -1544,7 +1544,7 @@ static int cpufreq_online(unsigned int cpu)
> >
> >               /*
> >                * Register with the energy model before
> > -              * sched_cpufreq_governor_change() is called, which will result
> > +              * sugov_eas_rebuild_sd() is called, which will result
> >                * in rebuilding of the sched domains, which should only be done
> >                * once the energy model is properly initialized for the policy
> >                * first.
> > @@ -2652,7 +2652,6 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
> >               ret = cpufreq_start_governor(policy);
> >               if (!ret) {
> >                       pr_debug("governor change\n");
> > -                     sched_cpufreq_governor_change(policy, old_gov);
> >                       return 0;
> >               }
> >               cpufreq_exit_governor(policy);
> > diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> > index 71d186d6933a..1c5ca92a0555 100644
> > --- a/include/linux/cpufreq.h
> > +++ b/include/linux/cpufreq.h
> > @@ -1193,14 +1193,6 @@ static inline int of_perf_domain_get_sharing_cpumask(int pcpu, const char *list_
> >  }
> >  #endif
> >
> > -#if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
> > -void sched_cpufreq_governor_change(struct cpufreq_policy *policy,
> > -                     struct cpufreq_governor *old_gov);
> > -#else
> > -static inline void sched_cpufreq_governor_change(struct cpufreq_policy *policy,
> > -                     struct cpufreq_governor *old_gov) { }
> > -#endif
> > -
> >  extern unsigned int arch_freq_get_on_cpu(int cpu);
> >
> >  #ifndef arch_set_freq_scale
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > index 4492608b7d7f..901cada51ba7 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -555,6 +555,31 @@ static const struct kobj_type sugov_tunables_ktype = {
> >
> >  /********************** cpufreq governor interface *********************/
> >
> > +#ifdef CONFIG_ENERGY_MODEL
> > +static void rebuild_sd_workfn(struct work_struct *work)
> > +{
> > +     rebuild_sched_domains_energy();
> > +}
> > +
> > +static DECLARE_WORK(rebuild_sd_work, rebuild_sd_workfn);
> > +
> > +/*
> > + * EAS shouldn't be attempted without sugov, so rebuild the sched_domains
> > + * on governor changes to make sure the scheduler knows about it.
> > + */
> > +static void sugov_eas_rebuild_sd(void)
> > +{
> > +     /*
> > +      * When called from the cpufreq_register_driver() path, the
> > +      * cpu_hotplug_lock is already held, so use a work item to
> > +      * avoid nested locking in rebuild_sched_domains().
> > +      */
> > +     schedule_work(&rebuild_sd_work);
> > +}
> > +#else
> > +static inline void sugov_eas_rebuild_sd(void) { };
> > +#endif
> > +
> >  struct cpufreq_governor schedutil_gov;
> >
> >  static struct sugov_policy *sugov_policy_alloc(struct cpufreq_policy *policy)
> > @@ -709,6 +734,8 @@ static int sugov_init(struct cpufreq_policy *policy)
> >       if (ret)
> >               goto fail;
> >
> > +     sugov_eas_rebuild_sd();
> > +
> >  out:
> >       mutex_unlock(&global_tunables_lock);
> >       return 0;
> > @@ -750,6 +777,8 @@ static void sugov_exit(struct cpufreq_policy *policy)
> >       sugov_kthread_stop(sg_policy);
> >       sugov_policy_free(sg_policy);
> >       cpufreq_disable_fast_switch(policy);
> > +
> > +     sugov_eas_rebuild_sd();
> >  }
> >
> >  static int sugov_start(struct cpufreq_policy *policy)
> > @@ -838,29 +867,3 @@ struct cpufreq_governor *cpufreq_default_governor(void)
> >  #endif
> >
> >  cpufreq_governor_init(schedutil_gov);
> > -
> > -#ifdef CONFIG_ENERGY_MODEL
> > -static void rebuild_sd_workfn(struct work_struct *work)
> > -{
> > -     rebuild_sched_domains_energy();
> > -}
> > -static DECLARE_WORK(rebuild_sd_work, rebuild_sd_workfn);
> > -
> > -/*
> > - * EAS shouldn't be attempted without sugov, so rebuild the sched_domains
> > - * on governor changes to make sure the scheduler knows about it.
> > - */
> > -void sched_cpufreq_governor_change(struct cpufreq_policy *policy,
> > -                               struct cpufreq_governor *old_gov)
> > -{
> > -     if (old_gov == &schedutil_gov || policy->governor == &schedutil_gov) {
> > -             /*
> > -              * When called from the cpufreq_register_driver() path, the
> > -              * cpu_hotplug_lock is already held, so use a work item to
> > -              * avoid nested locking in rebuild_sched_domains().
> > -              */
> > -             schedule_work(&rebuild_sd_work);
> > -     }
> > -
> > -}
> > -#endif
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied as 6.7 material, thanks!
