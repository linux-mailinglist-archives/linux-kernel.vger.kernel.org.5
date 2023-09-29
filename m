Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC3F7B32FD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 15:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbjI2NAJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 29 Sep 2023 09:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232990AbjI2NAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 09:00:06 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A732E1B4;
        Fri, 29 Sep 2023 06:00:02 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3ae473c0bd6so1205110b6e.0;
        Fri, 29 Sep 2023 06:00:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695992402; x=1696597202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=01V3P6+msIVHSmslLlWF4i0z60WIhO/ur5s2K2/Of2o=;
        b=qZIsJbc/1rQq5VlAcE/GO8Esu+cc0pHTSG/XWMUOqp2lxUrQXZnbzT9yL9ORSAUcjc
         j1PCtrLoHEPMvVLqXXOU/iUO0mzM32uPszQQ3m0oYxbVPeckHFku3+Pma3xJcGRyWRY/
         Ton4ay1CLuaOeZg6LbB/gWx3h2Cyk+NVr0v4uIunrmvi06lYQ3O3l0cWID1axWH+AzlY
         ajGp8xJZV+9KRv0Zbk40vumOxwDgNZNgF21AuW/J86TVKexFu9UfUXNaF9Wyw5s+Q0Ww
         IiCQLz42zQ9NqYhdlIQHPPqRqTuYhvI4EcMC/DVDW8YojmQejI1pnt37kTC1thDUYwNb
         3ZYg==
X-Gm-Message-State: AOJu0Yx+evnJ3WhyUqLnvjBHSBdMnrVnX9YZCDziUekiGDkFJt8Fs4ob
        NpIQwEHTCCtBVCr+91PsY8oWEhR6MpuCUjma4gQ=
X-Google-Smtp-Source: AGHT+IFvnQLuy3+BVdcbBi3YOd/7Lyty9O7edPDmUmadJJeh/c6WUjSCuOZc9ZMxlZh+L39fYGx/MOIzlq/4DHZKCS8=
X-Received: by 2002:a05:6808:212a:b0:3ae:b06:2140 with SMTP id
 r42-20020a056808212a00b003ae0b062140mr5147515oiw.4.1695992401881; Fri, 29 Sep
 2023 06:00:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230925081139.1305766-1-lukasz.luba@arm.com> <20230925081139.1305766-11-lukasz.luba@arm.com>
 <CAJZ5v0g6jPr3LqTuRfwUWsK4em7F1pfsZDn9pVziyu3tV56m8A@mail.gmail.com> <f7a6da56-93e4-0b7c-1746-bc3357bf8163@arm.com>
In-Reply-To: <f7a6da56-93e4-0b7c-1746-bc3357bf8163@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 29 Sep 2023 14:59:50 +0200
Message-ID: <CAJZ5v0hBPD8cHJe-Xa8354SE5jdM1bYw94DjG-MVHsRKrUY=gQ@mail.gmail.com>
Subject: Re: [PATCH v4 10/18] PM: EM: Add RCU mechanism which safely cleans
 the old data
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
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 11:36 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
>
>
> On 9/26/23 20:26, Rafael J. Wysocki wrote:
> > On Mon, Sep 25, 2023 at 10:11 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
> >>
> >> The EM is going to support runtime modifications of the power data.
> >> Introduce RCU safe mechanism to clean up the old allocated EM data.
> >
> > "RCU-based" probably and "to clean up the old EM data safely".
>
> Yes, thanks
>
> >
> >> It also adds a mutex for the EM structure to serialize the modifiers.
> >
> > This part doesn't match the code changes in the patch.
>
> Good catch. It left from some older version. We use the existing
> em_pd_mutex.
>
> >
> >> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> >> ---
> >>   kernel/power/energy_model.c | 29 +++++++++++++++++++++++++++++
> >>   1 file changed, 29 insertions(+)
> >>
> >> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> >> index 5b40db38b745..2345837bfd2c 100644
> >> --- a/kernel/power/energy_model.c
> >> +++ b/kernel/power/energy_model.c
> >> @@ -23,6 +23,9 @@
> >>    */
> >>   static DEFINE_MUTEX(em_pd_mutex);
> >>
> >> +static void em_cpufreq_update_efficiencies(struct device *dev,
> >> +                                          struct em_perf_state *table);
> >> +
> >>   static bool _is_cpu_device(struct device *dev)
> >>   {
> >>          return (dev->bus == &cpu_subsys);
> >> @@ -104,6 +107,32 @@ static void em_debug_create_pd(struct device *dev) {}
> >>   static void em_debug_remove_pd(struct device *dev) {}
> >>   #endif
> >>
> >> +static void em_destroy_rt_table_rcu(struct rcu_head *rp)
> >
> > Adding static functions without callers will obviously cause the
> > compiler to complain, which is one of the reasons to avoid doing that.
> > The other is that it is hard to say how these functions are going to
> > be used without reviewing multiple patches simultaneously, which is a
> > pain as far as I'm concerned.
>
> It is used in this patch, but inside the call_rcu() as 2nd arg.

I missed that, sorry for the noise.

> I have marked that below. The compiler didn't complain IIRC.
>
> >
> >> +{
> >> +       struct em_perf_table *runtime_table;
> >> +
> >> +       runtime_table = container_of(rp, struct em_perf_table, rcu);
> >> +       kfree(runtime_table->state);
> >> +       kfree(runtime_table);
> >
> > If runtime_table and its state were allocated in one go, it would be
> > possible to free them in one go either.
> >
> > For some reason, you don't seem to want to do that, but why?
>
> We had a few internal reviews and there were voices where saying that
> it's better to have 2 identical tables: 'default_table' and
> 'runtime_table' to make sure it's visible everywhere when it's used.
> That made the need to actually have also the 'state' table inside.
> I don't see it as a big problem, though.

What I'm trying to say is that you can allocate runtime_table along
with the table pointed to by its state field in one invocation of
kzalloc() (say).

Having just one memory region to free eventually instead of two of
them would help to avoid some complexity, especially in the next
patch.

> >
> >> +}
> >> +
> >> +static void em_perf_runtime_table_set(struct device *dev,
> >> +                                     struct em_perf_table *runtime_table)
> >> +{
> >> +       struct em_perf_domain *pd = dev->em_pd;
> >> +       struct em_perf_table *tmp;
> >> +
> >> +       tmp = pd->runtime_table;
> >> +
> >> +       rcu_assign_pointer(pd->runtime_table, runtime_table);
> >> +
> >> +       em_cpufreq_update_efficiencies(dev, runtime_table->state);
> >> +
> >> +       /* Don't free default table since it's used by other frameworks. */
> >
> > Apparently, some frameworks are only going to use the default table
> > while the runtime-updatable table will be used somewhere else at the
> > same time.
> >
> > I'm not really sure if this is a good idea.
>
> Runtime table is only for driving the task placement in the EAS.
>
> The thermal gov IPA won't make better decisions because it already
> has the mechanism to accumulate the error that it made.
>
> The same applies to DTPM, which works in a more 'configurable' way,
> rather that hard optimization mechanism (like EAS).

My understanding of the above is that the other EM users don't really
care that much so they can get away with using the default table all
the time, but EAS needs more accuracy, so the table used by it needs
to be adjusted in certain situations.

Fair enough, I'm assuming that you've done some research around it.
Still, this is rather confusing.

> >
> >> +       if (tmp != pd->default_table)
> >> +               call_rcu(&tmp->rcu, em_destroy_rt_table_rcu);
>
> The em_destroy_rt_table_rcu() is used here ^^^^^^
