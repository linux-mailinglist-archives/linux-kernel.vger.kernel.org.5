Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B067BBFF9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 22:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbjJFUDT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 6 Oct 2023 16:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjJFUDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 16:03:17 -0400
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64ED83;
        Fri,  6 Oct 2023 13:03:14 -0700 (PDT)
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6bc9353be9bso352413a34.1;
        Fri, 06 Oct 2023 13:03:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696622594; x=1697227394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nrnQlg+Ks22EwGBpOoGufahFztzvaGoZvpb10F2egwQ=;
        b=UTKLJa09Xmgyttk1+eZD4QFPifDz58ws5WB5dGJfQs8c5U5eSSmBtSjdumIT3msDsu
         3agrzizzDZk3B9/qiAm9ipjkhvmSW7Q5yUOL/MsPMHQ1n+TWLhleQoB9Hs3o5mL2UWkn
         m5kRKOo4/EQIbNBxRJVyXIhasE16w0erBeKR/HPHS2gfCS9WgH6UBiZ85QkgDYRQMfc4
         lRsw6iboE4YuG/Bx8yF9d3blYobU6OL2O+uv20+ckXAMAc/Mq/uNZM91ENoHF5aVO6C0
         N9bGWnWrj4114ntTjSVtujmvnI99DchTqQAm2yigOb3XBeu92UVTbk9U7msD26+Q4CS6
         dy6g==
X-Gm-Message-State: AOJu0YxwmH6dQMNQy5C+MKYX6yEbEJ3k2nfBSdGFoXxKzo/1/CHzCJCY
        aNrBcDa6QCAWUA+u1DZsKVWVn4A/FxSdH8Bw9AYfacFt
X-Google-Smtp-Source: AGHT+IE5lf+OzVD0JblqRIq9hmdGUD6xjJvQXOB/f7VFJrSqWnkhXWjdREK1gIYLCAer976QignmLzOkzCqB8ZrSWno=
X-Received: by 2002:a4a:b588:0:b0:578:c2af:45b5 with SMTP id
 t8-20020a4ab588000000b00578c2af45b5mr8791223ooo.0.1696622594035; Fri, 06 Oct
 2023 13:03:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230912061057.2516963-1-liaochang1@huawei.com> <20231005110255.fk736npzqsrffl2c@vireshk-i7>
In-Reply-To: <20231005110255.fk736npzqsrffl2c@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 6 Oct 2023 22:03:03 +0200
Message-ID: <CAJZ5v0iA0HbvFnOUDcrJKDVxEBx_87HK4QVoqCVEeGsntsgiQw@mail.gmail.com>
Subject: Re: [PATCH 1/2] cpufreq: userspace: Use fine-grained mutex in
 userspace governor
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Liao Chang <liaochang1@huawei.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Thu, Oct 5, 2023 at 1:05 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 12-09-23, 06:10, Liao Chang wrote:
> > The userspace governor currently uses a big global mutex to avoid the
> > race condition on the governor_data field of cpufreq_policy structure.
> > This leads to a low concurrency if multiple userspace applications are
> > trying to set the speed of different policies at the same time. This
> > patch introduces a per-policy mutex to allow the updating of different
> > policies to be performed concurrently, improving overall concurrency.
> >
> > Signed-off-by: Liao Chang <liaochang1@huawei.com>
> > ---
> >  drivers/cpufreq/cpufreq_userspace.c | 69 +++++++++++++++++------------
> >  1 file changed, 40 insertions(+), 29 deletions(-)
> >
> > diff --git a/drivers/cpufreq/cpufreq_userspace.c b/drivers/cpufreq/cpufreq_userspace.c
> > index 50a4d7846580..442e31060d62 100644
> > --- a/drivers/cpufreq/cpufreq_userspace.c
> > +++ b/drivers/cpufreq/cpufreq_userspace.c
> > @@ -16,7 +16,11 @@
> >  #include <linux/slab.h>
> >
> >  static DEFINE_PER_CPU(unsigned int, cpu_is_managed);
> > -static DEFINE_MUTEX(userspace_mutex);
> > +
> > +struct userspace_policy {
> > +     unsigned int setspeed;
> > +     struct mutex mutex;
> > +};
> >
> >  /**
> >   * cpufreq_set - set the CPU frequency
> > @@ -28,19 +32,19 @@ static DEFINE_MUTEX(userspace_mutex);
> >  static int cpufreq_set(struct cpufreq_policy *policy, unsigned int freq)
> >  {
> >       int ret = -EINVAL;
> > -     unsigned int *setspeed = policy->governor_data;
> > +     struct userspace_policy *userspace = policy->governor_data;
> >
> >       pr_debug("cpufreq_set for cpu %u, freq %u kHz\n", policy->cpu, freq);
> >
> > -     mutex_lock(&userspace_mutex);
> > +     mutex_lock(&userspace->mutex);
> >       if (!per_cpu(cpu_is_managed, policy->cpu))
> >               goto err;
> >
> > -     *setspeed = freq;
> > +     userspace->setspeed = freq;
> >
> >       ret = __cpufreq_driver_target(policy, freq, CPUFREQ_RELATION_L);
> >   err:
> > -     mutex_unlock(&userspace_mutex);
> > +     mutex_unlock(&userspace->mutex);
> >       return ret;
> >  }
> >
> > @@ -51,67 +55,74 @@ static ssize_t show_speed(struct cpufreq_policy *policy, char *buf)
> >
> >  static int cpufreq_userspace_policy_init(struct cpufreq_policy *policy)
> >  {
> > -     unsigned int *setspeed;
> > +     struct userspace_policy *userspace;
> >
> > -     setspeed = kzalloc(sizeof(*setspeed), GFP_KERNEL);
> > -     if (!setspeed)
> > +     userspace = kzalloc(sizeof(*userspace), GFP_KERNEL);
> > +     if (!userspace)
> >               return -ENOMEM;
> >
> > -     policy->governor_data = setspeed;
> > +     mutex_init(&userspace->mutex);
> > +
> > +     policy->governor_data = userspace;
> >       return 0;
> >  }
> >
> > +/*
> > + * Any routine that writes to the policy struct will hold the "rwsem" of
> > + * policy struct that means it is free to free "governor_data" here.
> > + */
> >  static void cpufreq_userspace_policy_exit(struct cpufreq_policy *policy)
> >  {
> > -     mutex_lock(&userspace_mutex);
> >       kfree(policy->governor_data);
> >       policy->governor_data = NULL;
> > -     mutex_unlock(&userspace_mutex);
> >  }
> >
> >  static int cpufreq_userspace_policy_start(struct cpufreq_policy *policy)
> >  {
> > -     unsigned int *setspeed = policy->governor_data;
> > +     struct userspace_policy *userspace = policy->governor_data;
> >
> >       BUG_ON(!policy->cur);
> >       pr_debug("started managing cpu %u\n", policy->cpu);
> >
> > -     mutex_lock(&userspace_mutex);
> > +     mutex_lock(&userspace->mutex);
> >       per_cpu(cpu_is_managed, policy->cpu) = 1;
> > -     *setspeed = policy->cur;
> > -     mutex_unlock(&userspace_mutex);
> > +     userspace->setspeed = policy->cur;
> > +     mutex_unlock(&userspace->mutex);
> >       return 0;
> >  }
> >
> >  static void cpufreq_userspace_policy_stop(struct cpufreq_policy *policy)
> >  {
> > -     unsigned int *setspeed = policy->governor_data;
> > +     struct userspace_policy *userspace = policy->governor_data;
> >
> >       pr_debug("managing cpu %u stopped\n", policy->cpu);
> >
> > -     mutex_lock(&userspace_mutex);
> > +     mutex_lock(&userspace->mutex);
> >       per_cpu(cpu_is_managed, policy->cpu) = 0;
> > -     *setspeed = 0;
> > -     mutex_unlock(&userspace_mutex);
> > +     userspace->setspeed = 0;
> > +     mutex_unlock(&userspace->mutex);
> >  }
> >
> >  static void cpufreq_userspace_policy_limits(struct cpufreq_policy *policy)
> >  {
> > -     unsigned int *setspeed = policy->governor_data;
> > +     struct userspace_policy *userspace = policy->governor_data;
> >
> > -     mutex_lock(&userspace_mutex);
> > +     mutex_lock(&userspace->mutex);
> >
> >       pr_debug("limit event for cpu %u: %u - %u kHz, currently %u kHz, last set to %u kHz\n",
> > -              policy->cpu, policy->min, policy->max, policy->cur, *setspeed);
> > -
> > -     if (policy->max < *setspeed)
> > -             __cpufreq_driver_target(policy, policy->max, CPUFREQ_RELATION_H);
> > -     else if (policy->min > *setspeed)
> > -             __cpufreq_driver_target(policy, policy->min, CPUFREQ_RELATION_L);
> > +              policy->cpu, policy->min, policy->max, policy->cur, userspace->setspeed);
> > +
> > +     if (policy->max < userspace->setspeed)
> > +             __cpufreq_driver_target(policy, policy->max,
> > +                                     CPUFREQ_RELATION_H);
> > +     else if (policy->min > userspace->setspeed)
> > +             __cpufreq_driver_target(policy, policy->min,
> > +                                     CPUFREQ_RELATION_L);
> >       else
> > -             __cpufreq_driver_target(policy, *setspeed, CPUFREQ_RELATION_L);
> > +             __cpufreq_driver_target(policy, userspace->setspeed,
> > +                                     CPUFREQ_RELATION_L);
> >
> > -     mutex_unlock(&userspace_mutex);
> > +     mutex_unlock(&userspace->mutex);
> >  }
> >
> >  static struct cpufreq_governor cpufreq_gov_userspace = {
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied as 6.7 material along with the [2/2], thanks!
