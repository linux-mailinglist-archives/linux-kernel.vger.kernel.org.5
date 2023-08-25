Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF857787DA5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 04:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240025AbjHYC3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 22:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241053AbjHYC2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 22:28:52 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DE01BFB;
        Thu, 24 Aug 2023 19:28:49 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-26f3e26e55aso277471a91.3;
        Thu, 24 Aug 2023 19:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692930529; x=1693535329;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WsvObY4iMN9Z9CsQkQU8ffng3Vh8WH9nCAEFkBwr4JQ=;
        b=Nd7ubQ3FdVgQGi399mXi5aT635L7Jk+fOOzeoM650+n0Ql6L0crbAQI0yhGfY7Ma4R
         b2OS/Jg82swq3khYZDantj/XmCzJI7NZ710YG/b5DY7hgSVlRVdoo8V22cpJ8xl17vTY
         2MySIpsrss/dr09dyIY7jgXR8rfIMCIOY6cUZb6ddyPl8viAJxhJOdvbG/Eo2aB/6Aru
         LDRFaTQlpQLrCFrgznHFj/4sG7t7Jd5y66YuVw3XrsHke/ib1dHBJQ7Zwn3YT/7ddaWG
         k1fKTaQcd2abHcs41B3cTzURty0uN61gDDKA+kAFzKUFfq0mELuo4J8N7Nbtr74HGEEQ
         ufFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692930529; x=1693535329;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WsvObY4iMN9Z9CsQkQU8ffng3Vh8WH9nCAEFkBwr4JQ=;
        b=SJk6bV0BonZ25SbtIOj5oaDzQNNiXJBEUobVAF0S7EkHnPPr1QQDccW70eJTEhccsV
         t84DodWjVxxbNx9SDj6u5RBIe4Hf8P11RcfuCSWyKP4s4NbpCNQ+l7PYkRf0zB7J0ZSc
         JWQeGZFemWyGTxIp7es6WDKumhd95fxFMq1y7sqNmtY9aVpsAnd2edvZHPyZCrv33DeM
         vABGQJ0Msm7W8NYlFUgjueyJoWV5ZCR9jmN5fn7wMmoOCd2pMdLcU4iDtbIzISml2a5y
         rDAMZnORS5o9Tsk1IcCIs9ptJYvykFY5gd63AUuCS6IREqWSfWrQmR/Qd5hI17Qe1G8F
         UbtQ==
X-Gm-Message-State: AOJu0YzOS+h/C4c5Sc2ca3+G4LZrorBF+UuluUxIwpm0z+TjiuvmPz/A
        30iAJxnGgcCsm9RLwMveCvvz5ghZI6N5Vntzfguhie9TZhQ=
X-Google-Smtp-Source: AGHT+IEPY8RDYBubCSP19QfmpP0539Pm+06ocq19gbo2bV1/lYdpFOTQ2hf+0P/TS5KOTWnx01wj2qrkdxwBjZaOSCI=
X-Received: by 2002:a17:90b:1081:b0:267:717f:2f91 with SMTP id
 gj1-20020a17090b108100b00267717f2f91mr13521657pjb.40.1692930529127; Thu, 24
 Aug 2023 19:28:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230824084206.22844-1-qiang.zhang1211@gmail.com> <162989fe-5ed8-4d1f-8c99-144e2de532f5@paulmck-laptop>
In-Reply-To: <162989fe-5ed8-4d1f-8c99-144e2de532f5@paulmck-laptop>
From:   Z qiang <qiang.zhang1211@gmail.com>
Date:   Fri, 25 Aug 2023 10:28:37 +0800
Message-ID: <CALm+0cVgg9u1-E+XrnbEyD75a_H3ifN9oB9j6xx0=cm8kuXE-Q@mail.gmail.com>
Subject: Re: [PATCH] rcutorture: Traverse possible cpu to set maxcpu in rcu_nocb_toggle()
To:     paulmck@kernel.org
Cc:     joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> On Thu, Aug 24, 2023 at 04:42:06PM +0800, Zqiang wrote:
> > Currently, the maxcpu is set by traversing online CPUs, however, if
> > the rcutorture.onoff_holdoff is set zero and onoff_interval is set
> > non-zero, and the some CPUs with larger cpuid has been offline before
> > setting maxcpu, for these CPUs, even if they are online again, also
> > cannot be offload or deoffload.
> >
> > This commit therefore use for_each_possible_cpu() instead of
> > for_each_online_cpu() in rcu_nocb_toggle().
> >
> > Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> > ---
> >  kernel/rcu/rcutorture.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> > index a58372bdf0c1..b75d0fe558ce 100644
> > --- a/kernel/rcu/rcutorture.c
> > +++ b/kernel/rcu/rcutorture.c
> > @@ -2131,7 +2131,7 @@ static int rcu_nocb_toggle(void *arg)
> >       VERBOSE_TOROUT_STRING("rcu_nocb_toggle task started");
> >       while (!rcu_inkernel_boot_has_ended())
> >               schedule_timeout_interruptible(HZ / 10);
> > -     for_each_online_cpu(cpu)
> > +     for_each_possible_cpu(cpu)
>
> Last I checked, bad things could happen if the code attempted to
> nocb_toggle a CPU that had not yet come online.  Has that changed?

For example, there are 8 online CPUs in the system, before we traversing online
CPUs and set maxcpu,  CPU7 has been offline, this causes us to miss nocb_toggle
for CPU7(maxcpu=6)

Even though we still use for_each_online_cpu(), the things described
above also happen.  before we toggle the CPU, this CPU has been offline.


Thanks
Zqiang


>
>                                                         Thanx, Paul
>
> >               maxcpu = cpu;
> >       WARN_ON(maxcpu < 0);
> >       if (toggle_interval > ULONG_MAX)
> > --
> > 2.17.1
> >
