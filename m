Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A0D7B328A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 14:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233203AbjI2M1V convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 29 Sep 2023 08:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbjI2M1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 08:27:18 -0400
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044C31A4;
        Fri, 29 Sep 2023 05:27:16 -0700 (PDT)
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-57bc11c197aso1220958eaf.1;
        Fri, 29 Sep 2023 05:27:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695990435; x=1696595235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YtzJRowMW7e/E03q1lTUM5DVXc8/q+Drl19Zckr7ENQ=;
        b=xLcibNgp0FRB9aYCsgGKj15qJqrxxZ+RFgtDg76lp9YaDs5DrtY/Mhy9RnTjB67qSq
         hba/WKFUq/po/2UVoXiF63YUiyKflEcgPF6DwT3dJjTiowp05WdL+nj3bt4ikREDmx3n
         vLqFqNbkjaQrGvXIVJDHws3He9WDs/MTtIQVV99aLvts37OUMUG6n/t4/Oq2SoIYgloc
         1PAhBRr5MY0RWWBUyLYfECUXgoQU5i6v0aEFuo49PIX/wfYTRmzGuDrGQuzYabe05Os7
         FS+P8t/9Pn2Ddjepqi8mz49QM4v8+ppf6r+QkKvAahp0m0MvuoBe1M+JDvP67VbTUDBc
         f47g==
X-Gm-Message-State: AOJu0YzfoEJX0h5w+t9SJLVp4a+teEW5AkaqogCb0Le2i1yb8eNs05+h
        2w3PMHw2fusIU+gn6pTtFA8Zzd46Ec7hpcGfYvA=
X-Google-Smtp-Source: AGHT+IEtWG6gWh2H8Sy+zC4ImyVW6S3AzZ5nzFhIapMQ4DfuepOZ6G4Rron/XwY+FxOvCAEaixm+lckahESotu0wlCw=
X-Received: by 2002:a05:6820:629:b0:57b:7e31:c12 with SMTP id
 e41-20020a056820062900b0057b7e310c12mr4488775oow.1.1695990435118; Fri, 29 Sep
 2023 05:27:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230925081139.1305766-1-lukasz.luba@arm.com> <20230925081139.1305766-10-lukasz.luba@arm.com>
 <CAJZ5v0gxjJRoZpGjs4qWy_CQbwnztgrQxHJpffdFHeEL7ikbYQ@mail.gmail.com> <e1b36a7b-0524-0559-7ae1-801bdda91e60@arm.com>
In-Reply-To: <e1b36a7b-0524-0559-7ae1-801bdda91e60@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 29 Sep 2023 14:27:03 +0200
Message-ID: <CAJZ5v0g1MYxABDEYJxjveWALV6yecuV1=Ly6REkR4eb1kS-cUA@mail.gmail.com>
Subject: Re: [PATCH v4 09/18] PM: EM: Introduce runtime modifiable table
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
        qyousef@layalina.io, wvw@google.com
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

On Fri, Sep 29, 2023 at 11:15 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
>
>
> On 9/26/23 20:12, Rafael J. Wysocki wrote:
> > On Mon, Sep 25, 2023 at 10:11 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
> >>
> >> The new runtime table would be populated with a new power data to better
> >> reflect the actual power. The power can vary over time e.g. due to the
> >> SoC temperature change. Higher temperature can increase power values.
> >> For longer running scenarios, such as game or camera, when also other
> >> devices are used (e.g. GPU, ISP) the CPU power can change. The new
> >> EM framework is able to addresses this issue and change the data
> >> at runtime safely.
> >>
> >> The runtime modifiable EM data is used by the Energy Aware Scheduler (EAS)
> >> for the task placement. All the other users (thermal, etc.) are still
> >> using the default (basic) EM. This fact drove the design of this feature.
> >>
> >> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> >> ---
> >>   include/linux/energy_model.h |  4 +++-
> >>   kernel/power/energy_model.c  | 12 +++++++++++-
> >>   2 files changed, 14 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> >> index 546dee90f716..740e7c25cfff 100644
> >> --- a/include/linux/energy_model.h
> >> +++ b/include/linux/energy_model.h
> >> @@ -39,7 +39,7 @@ struct em_perf_state {
> >>   /**
> >>    * struct em_perf_table - Performance states table
> >>    * @state:     List of performance states, in ascending order
> >> - * @rcu:       RCU used for safe access and destruction
> >> + * @rcu:       RCU used only for runtime modifiable table
> >
> > This still doesn't appear to be used anywhere, so why change it here?
>
> I will try to move this later in the series.
>
> >
> >>    */
> >>   struct em_perf_table {
> >>          struct em_perf_state *state;
> >> @@ -49,6 +49,7 @@ struct em_perf_table {
> >>   /**
> >>    * struct em_perf_domain - Performance domain
> >>    * @default_table:     Pointer to the default em_perf_table
> >> + * @runtime_table:     Pointer to the runtime modifiable em_perf_table
> >
> > "Pointer to em_perf_table that can be dynamically updated"
>
> OK
>
> >
> >>    * @nr_perf_states:    Number of performance states
> >>    * @flags:             See "em_perf_domain flags"
> >>    * @cpus:              Cpumask covering the CPUs of the domain. It's here
> >> @@ -64,6 +65,7 @@ struct em_perf_table {
> >>    */
> >>   struct em_perf_domain {
> >>          struct em_perf_table *default_table;
> >> +       struct em_perf_table __rcu *runtime_table;
> >>          int nr_perf_states;
> >>          unsigned long flags;
> >>          unsigned long cpus[];
> >> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> >> index 797141638b29..5b40db38b745 100644
> >> --- a/kernel/power/energy_model.c
> >> +++ b/kernel/power/energy_model.c
> >> @@ -251,6 +251,9 @@ static int em_create_pd(struct device *dev, int nr_states,
> >>                  return ret;
> >>          }
> >>
> >> +       /* Initialize runtime table as default table. */
> >
> > Redundant comment.
>
> I'll drop it.
>
> >
> >> +       rcu_assign_pointer(pd->runtime_table, default_table);
> >> +
> >>          if (_is_cpu_device(dev))
> >>                  for_each_cpu(cpu, cpus) {
> >>                          cpu_dev = get_cpu_device(cpu);
> >> @@ -448,6 +451,7 @@ EXPORT_SYMBOL_GPL(em_dev_register_perf_domain);
> >>    */
> >>   void em_dev_unregister_perf_domain(struct device *dev)
> >>   {
> >> +       struct em_perf_table __rcu *runtime_table;
> >>          struct em_perf_domain *pd;
> >>
> >>          if (IS_ERR_OR_NULL(dev) || !dev->em_pd)
> >> @@ -457,18 +461,24 @@ void em_dev_unregister_perf_domain(struct device *dev)
> >>                  return;
> >>
> >>          pd = dev->em_pd;
> >> -
> >
> > Unrelated change.
>
> ACK
>
> >
> >>          /*
> >>           * The mutex separates all register/unregister requests and protects
> >>           * from potential clean-up/setup issues in the debugfs directories.
> >>           * The debugfs directory name is the same as device's name.
> >>           */
> >>          mutex_lock(&em_pd_mutex);
> >> +
> >
> > Same here.
>
> ACK
>
> >
> >>          em_debug_remove_pd(dev);
> >>
> >> +       runtime_table = pd->runtime_table;
> >> +
> >> +       rcu_assign_pointer(pd->runtime_table, NULL);
> >> +       synchronize_rcu();
> >
> > Is it really a good idea to call this under a mutex?
>
> This is the unregistration of the EM code path, so a thermal
> driver which gets some IRQs might not be aware that the EM
> is going to vanish. That's why those two code paths: update
> & unregister are protected with the same lock.
>
> This synchronize_rcu() won't be long,

Are you sure?  This potentially waits for all of the CPUs in the
system to go through a quiescent state which may take a while in
principle.

In any case, though, this effectively makes everyone waiting for the
mutex also wait for the grace period to elapse and they may not care
about it.

> but makes sure that when we free(dev->em_pd) we don't leak runtime_table.
>
> >
> >> +
> >>          kfree(pd->default_table->state);
> >>          kfree(pd->default_table);
> >>          kfree(dev->em_pd);
> >> +
> >
> > Unrelated change.
>
> ACK
>
> >
> >>          dev->em_pd = NULL;
> >>          mutex_unlock(&em_pd_mutex);
> >>   }
> >> --
> >
> > So this really adds a pointer to a table that can be dynamically
> > updated to struct em_perf_domain without any users so far.  It is not
> > used anywhere as of this patch AFAICS, which is not what the changelog
> > is saying.
>
> Good catch. I will adjust the changlog in header and say:
>
> 'Add infrastructure and mechanisms for the new runtime table.
> The runtime modifiable EM data is used by the Energy Aware Scheduler
> (EAS)for the task placement.

I would make it more clear that this is going to happen after some
other subsequent changes.

> All the other users (thermal, etc.) are
> still using the default (basic) EM. This fact drove the design of this
> feature.'
