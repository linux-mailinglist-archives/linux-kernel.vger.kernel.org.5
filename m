Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F18792B83
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243636AbjIEQyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354721AbjIENuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 09:50:50 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8300198
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 06:50:46 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-68a402c1fcdso1587146b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 06:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693921846; x=1694526646; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8746KGEIMDYvZy66/CTNAkcgr/TmGj5aYpS8lwWYVY4=;
        b=VdDtTqAhtNYocHoiJ9gVHQu/RRHFvUxUN0VLFX4b4PcaZGilpvNYsTb19CqYFX1wFx
         XUAnubf9yBXcyRp8+GGmTZq7i8J3dtYOG3m1rmHnLl1itnPdZURPtVpF6kNYWyAdzprG
         7wyonjqB8D0fR9WV+mVObsg0wZdwYSsygeUi+bOOmI26x5/skn0HBimEDnQnADeDO/Tu
         oahms2UAjUCcE8F9aWfJ+tXRM7ebf9NJImAP/l0Q+inapHnPJ2uINpdNM8F/YW2XDm0T
         b+O8qyhVjAf5jttGjKvJyhU5vOBNFaBB0WnKfLfZ3ci3GKMLPW6tukYHJDi0gyyw47iB
         d5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693921846; x=1694526646;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8746KGEIMDYvZy66/CTNAkcgr/TmGj5aYpS8lwWYVY4=;
        b=WQIrhy+aSr+7eRRKxTePzyhDBBaHbtz+PQ8rrieES9cyijchkGObKJTBkwsGlS1QsQ
         DgmLUBq+DT4FLzoAYBgAdDuth1E3g9aGdZgCP9yBpwmJEF7MxhNLgSBmpeIeGL1qtPjC
         IC3ij/O3xJvlWV5GWscZqP218kXiGnv/PrXcO1/FZTuT02OCeUSBJeGjtjvD+5UMDej+
         HlafF+9AC+DC0+4d0GDtvLQM75Npd9f3xxshjvbg08mwImUD97oK3YvvJY0/hp4O02+W
         ngHeRpllxmYhL73ttK0rqJ7zxUd9dbVnZbf5zSEqZEibgzfPWHm6KmRvtFbz5cAypuWF
         SfFQ==
X-Gm-Message-State: AOJu0YxyjfHlLOcYR43n/4wY6rE9oqi9yC2XmNHMNax7kF58tYqN2TPD
        anzlo2ecZix5hY8yqm799/Z1rKPY409JJ0vDzVqAyA==
X-Google-Smtp-Source: AGHT+IHyxlfWoLfe4fGuaYHNWVkerDWNPmsQOGwuwZTCoO+MCc5SzD8LdTfSRFNhOHbuXHxmu5RBbYiGz+ziPJEEFVE=
X-Received: by 2002:a05:6a00:1705:b0:68c:33a9:e572 with SMTP id
 h5-20020a056a00170500b0068c33a9e572mr13265343pfc.29.1693921846035; Tue, 05
 Sep 2023 06:50:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230901130312.247719-1-vincent.guittot@linaro.org>
 <20230901130312.247719-4-vincent.guittot@linaro.org> <20230905112455.GD28319@noisy.programming.kicks-ass.net>
In-Reply-To: <20230905112455.GD28319@noisy.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 5 Sep 2023 15:50:34 +0200
Message-ID: <CAKfTPtCt7m5c0y1ttF3k3coZ34fbALpAToK5vUpgtZVTPwNrzg@mail.gmail.com>
Subject: Re: [PATCH 3/4] cpufreq/schedutil: use a fixed reference frequency
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, viresh.kumar@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org,
        conor.dooley@microchip.com, suagrfillet@gmail.com,
        ajones@ventanamicro.com, lftan@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Sept 2023 at 13:25, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Sep 01, 2023 at 03:03:11PM +0200, Vincent Guittot wrote:
>
> > +#ifdef arch_scale_freq_ref
> > +/**
> > + * arch_scale_freq_ref_policy - get the reference frequency of a given CPU that
> > + * has been used to correlate frequency and compute capacity.
> > + * @cpu: the CPU in question.
> > + *
> > + * Return: the reference CPU frequency.
> > + */
> > +static __always_inline
> > +unsigned long  arch_scale_freq_ref_policy(struct cpufreq_policy *policy)
> > +{
> > +     return arch_scale_freq_ref(policy->cpu);
> > +}
> > +#else
> > +static __always_inline
> > +unsigned long  arch_scale_freq_ref_policy(struct cpufreq_policy *policy)
>
> double space    ^^

I was expecting checkpatch.pl to catch it

will fix them

>
> > +{
> > +     if (arch_scale_freq_invariant())
> > +             return policy->cpuinfo.max_freq;
> > +
> > +
>
> superfluous whitespace there.
>
> > +     return policy->cur;
> > +}
> > +#endif
>
> static __always_inline
> unsigned long arch_scale_freq_ref_policy(struct cpufreq_policy *policy)
> {
> #ifdef arch_scale_freq_ref
>         return arch_scale_freq_ref(policy->cpu);
> #endif
>
>         if (arch_scale_freq_invariant())
>                 return policy->cpuinfo.max_freq;
>
>         return policy->cur;
> }
>
> Would have the lot in a single function and possibly easier to read?

yes

>
> > +
> >  /**
> >   * get_next_freq - Compute a new frequency for a given cpufreq policy.
> >   * @sg_policy: schedutil policy object to compute the new frequency for.
> > @@ -139,11 +164,11 @@ static void sugov_deferred_update(struct sugov_policy *sg_policy)
> >  static unsigned int get_next_freq(struct sugov_policy *sg_policy,
> >                                 unsigned long util, unsigned long max)
> >  {
> > +     unsigned int freq;
> >       struct cpufreq_policy *policy = sg_policy->policy;
> > -     unsigned int freq = arch_scale_freq_invariant() ?
> > -                             policy->cpuinfo.max_freq : policy->cur;
>
> Leave the variable below per the inverse christmas thing.
>
> >
> >       util = map_util_perf(util);
> > +     freq = arch_scale_freq_ref_policy(policy);
> >       freq = map_util_freq(util, freq, max);
> >
> >       if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
> > --
> > 2.34.1
> >
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
