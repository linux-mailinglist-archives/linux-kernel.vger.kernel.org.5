Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF27A7C9850
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 10:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbjJOICv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 04:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbjJOICu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 04:02:50 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA11D8
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 01:02:47 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3ae35773a04so2259086b6e.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 01:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697356967; x=1697961767; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yN7gGAyE9oM4bMEMV3YqtWjtS74g/Jr4Bfj1PCxwr0I=;
        b=NCbEChlsjltWqnEb/aHW5HL/y1rfiaIDI5kaDAb7A7+6NZI1eNSbm9vzvEbEb/ZKqP
         rzCYuKXXnoaLvOu4iQaxu/vMCXWdSVQtYSBi8Xaad5mJv/8bxS/6To2GWZgKClF54nJT
         vzE9u/omiwsogJx7Kv+uYtywGBmvUO61M/kheB3FWp8Gf+wBoFn4rwrjwHHX5ZDIenAc
         uICzOFd1n0KiWt1hfJZ0Er4B4Hsx6q2y71zvrvm8H02UccGW0zI8gDmiAJUgU0XSGChp
         j5TRjj3OBMHWFY2gzRCN3Nci6abMeKZYj7FdDBXJ1qk1RB9yYhNyzNwjWl88ubuEKrda
         p/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697356967; x=1697961767;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yN7gGAyE9oM4bMEMV3YqtWjtS74g/Jr4Bfj1PCxwr0I=;
        b=GOrXGRElSRNWzjhH3dF/uq0VvvSVg3z+luE4tfBOLGAsGfHuehgrUSSKLK3dlv+JIQ
         i6lQv8BHJKs3kTxqBo6t/LdDTte/bLSE4/g/N4onZ5+SKl721I+/fq+ZVftgATwVdFRx
         wEWZeDI5+6f4B0zGfrUwHwuczFX+9/EYY0/NDMDoqDmXFVrEysVmQuBJbNYqedeWuvt/
         4xFPZ8hjOzrueRLotxs6nhb/KStHGcznTdwoO06r43y39krvHRv05LrAZYLRz61mSJuQ
         5iXG1Ipg1SMhVkK2SytW8anRxxASzm1gWHCa7MB57qEKbh88Gd2OSZe1Jd5vUA30BAYN
         u4oQ==
X-Gm-Message-State: AOJu0Yxd03arTCF2T6iroC9TXqqwdcfYADXe2zEDFh718e63KWqTiwpj
        vDtXlW1SqvGQo0jrV6L3cUCkwwSysOLpB8smML3epg==
X-Google-Smtp-Source: AGHT+IG9T95ajcOIGWflHX4h5cBu2PDMdVbEeEmGi5QM8j8TK2rJj7HN3MusQMJwoDDWlZkFomQBw1Q77yhDCoaMVNM=
X-Received: by 2002:a05:6808:14c3:b0:3a7:2621:2daf with SMTP id
 f3-20020a05680814c300b003a726212dafmr42247567oiw.42.1697356966769; Sun, 15
 Oct 2023 01:02:46 -0700 (PDT)
MIME-Version: 1.0
References: <20231013151450.257891-1-vincent.guittot@linaro.org>
 <20231013151450.257891-2-vincent.guittot@linaro.org> <ZSmKiquvV6clE1ux@gmail.com>
In-Reply-To: <ZSmKiquvV6clE1ux@gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Sun, 15 Oct 2023 10:02:35 +0200
Message-ID: <CAKfTPtBSm9w7uKpQ8r9YcTMT86j2_cqdZ-BCrkv5yhJJJud0ug@mail.gmail.com>
Subject: Re: [PATCH 1/2] sched/schedutil: rework performance estimation
To:     Ingo Molnar <mingo@kernel.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        rafael@kernel.org, viresh.kumar@linaro.org, qyousef@layalina.io,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Oct 2023 at 20:21, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Vincent Guittot <vincent.guittot@linaro.org> wrote:
>
> > +
> > +     /* The minimum utilization returns the highest level between:
> > +      * - the computed DL bandwidth needed with the irq pressure which
> > +      *   steals time to the deadline task.
> > +      * - The minimum bandwidth requirement for CFS.
> > +      */
>
> Nit: please use the standard multi-line Linux kernel comment style.

Yes, I don't know how I ended up with such comment style. I will fix
it and others below

>
> > +     /* The maximum hint is a soft bandwidth requirement which can be lower
> > +      * than the actual utilization because of max uclamp requirments
> >        */
>
> Ditto.
>
> > +unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
> > +                              unsigned long min,
> > +                              unsigned long max)
> > +{
> > +     unsigned long target;
> > +     struct rq *rq = cpu_rq(cpu);
> > +
> > +     if (rt_rq_is_runnable(&rq->rt))
> > +             return max;
> > +
> > +     /* Provide at least enough capacity for DL + irq */
> > +     target =  min;
>
> s/  / /
> s/irq/IRQ/
>
> Thanks,
>
>         Ingo
