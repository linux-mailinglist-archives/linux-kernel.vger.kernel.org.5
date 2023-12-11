Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F34B80DB7C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 21:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345179AbjLKUVW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 11 Dec 2023 15:21:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345102AbjLKUVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 15:21:09 -0500
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D68C4;
        Mon, 11 Dec 2023 12:20:58 -0800 (PST)
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5907b9c3fd6so407938eaf.0;
        Mon, 11 Dec 2023 12:20:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702326057; x=1702930857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KdR2OSdlfkd+7aN8MdL4iIUqAicY4t8Ra3rktJ3z8SE=;
        b=tJRUYbsXOW31TXaf6p1jCDSBV56XVDINPMmvMkAFpy8+EyMeuDKAEPM0E7Dab+GTu5
         93GRqxXv/0BwXCXOnLsSKd1Gy32m3GGx95wslMqvcbqdoAt6KLVyxUnyK5G7QqMlgoJB
         KTHh8m5y24oepm17LsJcJRoiSJ9EWhXXjUDf9woiDtWcsqkF8wThcKyCqlpJ/W4viW1P
         /AnjaCPYsb97q6ixNGzJ1AEI6V4gIx5t5o4cCnRMjfCO1hm+KUdE/MA9DBlOPKeTwTA0
         mHBGoRcc0jP7ZHfBeF2UW0PqvOy8dbOJ4f7Qz+SpyeT2NeBJ66W+sMCgkBs5hXMu08sN
         XRrw==
X-Gm-Message-State: AOJu0Yx0aVLnqSuOwW6sogzy7LIVnl5QGqxuQ7VDIOi2kCrzxhWfS+L9
        dOjUUzoQu1AHy1VNkd8H+1rfzI1RMfpmnRNs0es=
X-Google-Smtp-Source: AGHT+IEQRGRF5nvWrjxXfEGtm15kh9H0lNY8Rthoy64xk0jPRWIg20xykSPP6T/ww8c2kWzq33udXAnpjkj7vrW2OME=
X-Received: by 2002:a05:6820:220d:b0:58d:5302:5b18 with SMTP id
 cj13-20020a056820220d00b0058d53025b18mr10519759oob.1.1702326057573; Mon, 11
 Dec 2023 12:20:57 -0800 (PST)
MIME-Version: 1.0
References: <20231208002342.367117-1-qyousef@layalina.io> <20231208002342.367117-8-qyousef@layalina.io>
 <CAJZ5v0iYUY-LrL3LNdMqxyMntBij_pkpETB2esYPraPekqtbhw@mail.gmail.com> <20231210204032.fficzltp2gq66pne@airbuntu>
In-Reply-To: <20231210204032.fficzltp2gq66pne@airbuntu>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 11 Dec 2023 21:20:46 +0100
Message-ID: <CAJZ5v0iKwcwkUBYaKkSkz0sPoHxrG_5pD295v_Z0jFDhR4FRFA@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] sched/schedutil: Add a new tunable to dictate
 response time
To:     Qais Yousef <qyousef@layalina.io>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
        Rick Yiu <rickyiu@google.com>,
        Chung-Kai Mei <chungkai@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 10, 2023 at 9:40 PM Qais Yousef <qyousef@layalina.io> wrote:
>
> On 12/08/23 19:06, Rafael J. Wysocki wrote:
> > On Fri, Dec 8, 2023 at 1:24 AM Qais Yousef <qyousef@layalina.io> wrote:
> > >
> > > The new tunable, response_time_ms,  allow us to speed up or slow down
> > > the response time of the policy to meet the perf, power and thermal
> > > characteristic desired by the user/sysadmin. There's no single universal
> > > trade-off that we can apply for all systems even if they use the same
> > > SoC. The form factor of the system, the dominant use case, and in case
> > > of battery powered systems, the size of the battery and presence or
> > > absence of active cooling can play a big role on what would be best to
> > > use.
> > >
> > > The new tunable provides sensible defaults, but yet gives the power to
> > > control the response time to the user/sysadmin, if they wish to.
> > >
> > > This tunable is applied before we apply the DVFS headroom.
> > >
> > > The default behavior of applying 1.25 headroom can be re-instated easily
> > > now. But we continue to keep the min required headroom to overcome
> > > hardware limitation in its speed to change DVFS. And any additional
> > > headroom to speed things up must be applied by userspace to match their
> > > expectation for best perf/watt as it dictates a type of policy that will
> > > be better for some systems, but worse for others.
> > >
> > > There's a whitespace clean up included in sugov_start().
> > >
> > > Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> >
> > I thought that there was an agreement to avoid adding any new tunables
> > to schedutil.
>
> Oh. I didn't know that.
>
> What alternatives do we have? I couldn't see how can we universally make the
> response work for every possible system (not just SoC, but different platforms
> with same SoC even) and workloads. We see big power saving with no or little
> perf impact on many workloads when not applying the current 125%. Others want
> to push it faster under gaming scenarios etc to get more stable FPS.
>
> Hopefully uclamp will make the need for this tuning obsolete over time. But
> until userspace gains critical mass; I can't see how we can know best
> trade-offs for all myriads of use cases/systems.
>
> Some are happy to gain more perf and lose power. Others prefer to save power
> over perf. DVFS response time plays a critical role in this trade-off and I'm
> not sure how we can crystal ball it without delegating.

I understand the motivation, but counter-arguments are based on the
experience with the cpufreq governors predating schedutil, especially
ondemand.  Namely, at one point people focused on adjusting all of the
governor tunables to their needs without contributing any code or even
insights back, so when schedutil was introduced, a decision was made
to reduce the tunability to a minimum (preferably no tunables at all,
but it turned out to be hard to avoid the one tunable existing today).
Peter was involved in those discussions and I think that the point
made then is still valid.

The headroom formula was based on the observation that it would be a
good idea to have some headroom in the majority of cases and on the
balance between the simplicity of computation and general suitability.

Of course, it is hard to devise a single value that will work for
everyone, but tunables complicate things from the maintenance
perspective.  For example, the more tunables there are, the harder it
is to make changes without altering the behavior in ways that will
break someone's setup.
