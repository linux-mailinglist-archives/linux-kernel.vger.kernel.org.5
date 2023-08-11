Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C01778848
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 09:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233994AbjHKHfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 03:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233943AbjHKHfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 03:35:38 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444DD196
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 00:35:37 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b9cf2b1309so19787671fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 00:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1691739335; x=1692344135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFTU7Qp0U4fO78OlPa7W/8TemF4eYsGTKoniJ6Y9ewc=;
        b=MGs8z7zpTzaN3nx5+XZVK0bNh1+wAnaJ0QUcT7RwifGeXBEjcYhlzT5F699DmRenjJ
         v0XUYbYIQR08v3fJmklj7rJ6b7YjOSHq3LRepZAr0HcpdAuJGN34EP/Wt4JZ4KF8k7Nm
         X87soOAcPZgHRrerlwKqvn8Vig9Lb462OS/fg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691739335; x=1692344135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VFTU7Qp0U4fO78OlPa7W/8TemF4eYsGTKoniJ6Y9ewc=;
        b=EGYhQiDQ4Emfmmp+7QhPt3WQbS8K6C7bikewL7sb95O17eIMD2oAABWf+LDmM/nP45
         CufopBaUmyH9j6zxdWry8GeocC6yZf6V8TlaQzwtIn3YfsIC3BqJlbsg6LdufYaM9ZyC
         QMet1WHX/0Nswv4Fl2w40DI/NSMaIcux9xucZnkOX7TsezUPt002HpfLSmsj2e8vRH7o
         FtPgUw25fUkgdbmyfUCn37CkDI1kj5DCoNl5qFbv9mk7UlNnjXGmHl2OW1ILIJq+NcQp
         432auOkEZn1Qt/FX5/u2U0VABeF8PwBa4EzNHk2HtHaKNelSURbwW1vUKKy5A/Hr2xlc
         Dr5g==
X-Gm-Message-State: AOJu0YwADx1t1pm8BeEgPjSR9iyySnK1AT5qSPuMV3rVLnfzmLPhho4P
        m3Kt2pG/ebzG1RGl21VjIKsQ6oWDDlnMu+8yO/We9A==
X-Google-Smtp-Source: AGHT+IGHe0oVKS3cAgjVToqo17E1RhNSzjOkWL5PwGgw9KxVUPJw4K0lxSj+ccMGZ6RUuXQB9REPQGHTuJeNd/xKVjc=
X-Received: by 2002:a2e:b54a:0:b0:2b9:c2dc:619c with SMTP id
 a10-20020a2eb54a000000b002b9c2dc619cmr1768426ljn.10.1691739334773; Fri, 11
 Aug 2023 00:35:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230801204121.929256934@infradead.org> <20230801211811.828443100@infradead.org>
 <CAEXW_YSJ-G_zUKLzLgvCkxAY-dg_Zxo6n=bEXyeEmo9hEMcZpg@mail.gmail.com> <20230809194822.GV212435@hirez.programming.kicks-ass.net>
In-Reply-To: <20230809194822.GV212435@hirez.programming.kicks-ass.net>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 11 Aug 2023 03:35:23 -0400
Message-ID: <CAEXW_YRZE7goE+KpoV5zkj=fLY3q33bf8HVMs0vWggZnxmdb5A@mail.gmail.com>
Subject: Re: [PATCH 1/9] sched: Simplify get_nohz_timer_target()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 9, 2023 at 3:48=E2=80=AFPM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Sun, Aug 06, 2023 at 05:39:24PM -0400, Joel Fernandes wrote:
> > On Sun, Aug 6, 2023 at 9:52=E2=80=AFAM Peter Zijlstra <peterz@infradead=
.org> wrote:
> > >
> > > Use guards to reduce gotos and simplify control flow.
> > >
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > ---
> > >  kernel/sched/core.c |   15 ++++++---------
> > >  1 file changed, 6 insertions(+), 9 deletions(-)
> > >
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -1097,25 +1097,22 @@ int get_nohz_timer_target(void)
> > >
> > >         hk_mask =3D housekeeping_cpumask(HK_TYPE_TIMER);
> > >
> > > -       rcu_read_lock();
> > > +       guard(rcu)();
> > > +
> > >         for_each_domain(cpu, sd) {
> > >                 for_each_cpu_and(i, sched_domain_span(sd), hk_mask) {
> > >                         if (cpu =3D=3D i)
> > >                                 continue;
> > >
> > > -                       if (!idle_cpu(i)) {
> > > -                               cpu =3D i;
> > > -                               goto unlock;
> > > -                       }
> > > +                       if (!idle_cpu(i))
> > > +                               return i;
> > >                 }
> > >         }
> > >
> > >         if (default_cpu =3D=3D -1)
> > >                 default_cpu =3D housekeeping_any_cpu(HK_TYPE_TIMER);
> > > -       cpu =3D default_cpu;
> > > -unlock:
> > > -       rcu_read_unlock();
> > > -       return cpu;
> > > +
> > > +       return default_cpu;
> > >  }
> >
> > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> >
> > I haven't looked into the actual implementation of the guard stuff,
> > but rcu_read_lock_guarded() is less of an eyesore to me than
> > guard(rcu)(); TBH.
>
> I readily admit it isn't the prettiest construct, my brain is warped by
> many years of C++ and I can read it as: guard<rcu>(), but I'm not sure
> that's actually better :-)
>
> The advantage of all this is that you also get:
>
>         scoped_guard (rcu) {
>         }
>
> for 'free'.

Yes, overall the readability improvement is quite appealing. Thank you Pete=
r!

 - Joel
