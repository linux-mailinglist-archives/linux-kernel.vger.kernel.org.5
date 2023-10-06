Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701967BBFE0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 21:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233203AbjJFTxC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 6 Oct 2023 15:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjJFTxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 15:53:01 -0400
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C831983;
        Fri,  6 Oct 2023 12:52:59 -0700 (PDT)
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-57b68555467so125268eaf.0;
        Fri, 06 Oct 2023 12:52:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696621979; x=1697226779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JxC1UMvrDtQX6U211gJNLgAyLVSbgicwt9tFcS3Rr8E=;
        b=PiTsUN66pPKdG26/3t04ObGknAOnrvSufjHzKK2ksA8oLxFifZ3tW+olEZMfogV4p9
         2CihlRX6BYx5YY8ekkc9p3gVEjfc04ZbgVtvE9rTJPIvDQ6lGX4Z826xSjChubq4TUDe
         iVT60bimzqtwe8XlQf/KFPOL4IykXjhD0oOO8b39AeSyMHpKk/96FGlhb6h0H4Q35KgK
         0/xI6hI1iCSauTntmZRTunG7lEcfS5gQpPy+Izukq06n7Aj575U044Ztwe85iHnjpP87
         Po3LGpuA4Os3iY7uAoaqEkfZkoWHUEo7ab5M7UDETjUJMpy415YR9XGjP2Qc8erxLFVC
         U0/w==
X-Gm-Message-State: AOJu0YzBft5kIucqFgb/dPPTiaC+/ycncPFJa/y+nmImxfxjb5hKV+Sr
        /4i1/1LlmJVYyZ5TgUXJ+RYE3ke3y0RF7TGz+9Y=
X-Google-Smtp-Source: AGHT+IHtlGwfI23JH2FvFHgIzSXFsChzajF8vEJPKLNs10VBKlj+l8ZPTE3bl5cYPiK21rs9FHPN5ZjIyA2Tdc8jXtM=
X-Received: by 2002:a4a:b807:0:b0:57b:3b64:7ea5 with SMTP id
 g7-20020a4ab807000000b0057b3b647ea5mr8310123oop.1.1696621979075; Fri, 06 Oct
 2023 12:52:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230908031604.2262422-1-liaochang1@huawei.com> <20230927085517.udfg3udsqkmrugj2@vireshk-i7>
In-Reply-To: <20230927085517.udfg3udsqkmrugj2@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 6 Oct 2023 21:52:48 +0200
Message-ID: <CAJZ5v0ji+=6xUk1yDkEMe=3tuUSJxOhe+wgVb4cgjJ07R9-vsA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: schedutil: Merge initialization code of sg_cpu
 in single loop
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Liao Chang <liaochang1@huawei.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Wed, Sep 27, 2023 at 10:55 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 08-09-23, 03:16, Liao Chang wrote:
> > The initialization code of the per-cpu sg_cpu struct is currently split
> > into two for-loop blocks. This can be simplified by merging the two
> > blocks into a single loop. This will make the code more maintainable.
> >
> > Signed-off-by: Liao Chang <liaochang1@huawei.com>
> > ---
> >  kernel/sched/cpufreq_schedutil.c | 11 +++--------
> >  1 file changed, 3 insertions(+), 8 deletions(-)
> >
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > index 4492608b7d7f..f3a95def49cc 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -767,14 +767,6 @@ static int sugov_start(struct cpufreq_policy *policy)
> >
> >       sg_policy->need_freq_update = cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);
> >
> > -     for_each_cpu(cpu, policy->cpus) {
> > -             struct sugov_cpu *sg_cpu = &per_cpu(sugov_cpu, cpu);
> > -
> > -             memset(sg_cpu, 0, sizeof(*sg_cpu));
> > -             sg_cpu->cpu                     = cpu;
> > -             sg_cpu->sg_policy               = sg_policy;
> > -     }
> > -
> >       if (policy_is_shared(policy))
> >               uu = sugov_update_shared;
> >       else if (policy->fast_switch_enabled && cpufreq_driver_has_adjust_perf())
> > @@ -785,6 +777,9 @@ static int sugov_start(struct cpufreq_policy *policy)
> >       for_each_cpu(cpu, policy->cpus) {
> >               struct sugov_cpu *sg_cpu = &per_cpu(sugov_cpu, cpu);
> >
> > +             memset(sg_cpu, 0, sizeof(*sg_cpu));
> > +             sg_cpu->cpu = cpu;
> > +             sg_cpu->sg_policy = sg_policy;
> >               cpufreq_add_update_util_hook(cpu, &sg_cpu->update_util, uu);
> >       }
> >       return 0;
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied as 6.7 material, thanks!
