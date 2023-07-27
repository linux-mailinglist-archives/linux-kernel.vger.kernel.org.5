Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B2E76441D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 05:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbjG0DB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 23:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbjG0DBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 23:01:55 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B5B1BD5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 20:01:54 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b9aa1d3029so6358451fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 20:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1690426912; x=1691031712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=28kM+66MW+/ZE/QhfQIXTCdNMEwChH0F8W+wviNU5N4=;
        b=i261GX+ISLVBQWkZJlC8JRSTm8YljJalFdC0xw+oAOtekwYguIX3lJETIZEfqN6p6e
         hbc+y0nlxiMJ1OIUQAUmvgz3nM1Um64qCuh0JGjRzewYJM/VmOn5dwj7nq2BJJYjb8Be
         DP11WIROHODl84N7ysvCYEPdQSeb8it8IOSPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690426912; x=1691031712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=28kM+66MW+/ZE/QhfQIXTCdNMEwChH0F8W+wviNU5N4=;
        b=KnZr4igwEdtNsVSLkeAv2AWIzymakvs+uviHr+LHvIUn/IXyaZTMCTMAN3iU5enX9a
         LfLE8khgvUB8os5PRVH8cDW3mMVLjUN3NtWSXnwBBEG20jLDsOe/VHz2Q/bbjKlDS8BJ
         GRok7T6aRFdIIHv8M735dSNx/M4rwK6OVgK//woaTDG6LYxwyXtbJ/3BtsP7BuafVc9w
         Y7h6xJB7g3ScrDR5HwxpeIyTkqmrxKqJxsWfKh2Iiuv1E+jXXpXyejkRsZC2qrHeN5sW
         CuvuoUbX+/2GYHahx3+6qWbMN9ZxR+RWjIRj49yJXQODAIcJ1FmdxCP2ve6U/Kq0qDHV
         9B/g==
X-Gm-Message-State: ABy/qLZLcAIUONe7XMBux0RPP7sTV/uxL260XBsyE7ChVXvxZ0qtU4sS
        hZmwo7Ujm1PgK6FCKjNTj11nIWViX9SxZL6+PK2HE0dhq3Ko7UqAHqs=
X-Google-Smtp-Source: APBJJlEx6ky2cjrQJP4D+4530EmV6PxTY62HotbnTfmh+ipGNijarsBTGEmVIjyEv5iR/HbLmjdJG6rq5EMrz4S83rw=
X-Received: by 2002:a2e:a0ca:0:b0:2b6:cf0f:1fbf with SMTP id
 f10-20020a2ea0ca000000b002b6cf0f1fbfmr538037ljm.42.1690426912206; Wed, 26 Jul
 2023 20:01:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230725232913.2981357-1-joel@joelfernandes.org>
 <20230725232913.2981357-2-joel@joelfernandes.org> <f6ef4762-6d37-40a4-8272-13b248c46f5b@paulmck-laptop>
In-Reply-To: <f6ef4762-6d37-40a4-8272-13b248c46f5b@paulmck-laptop>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 26 Jul 2023 23:01:40 -0400
Message-ID: <CAEXW_YTfo8MDcAQk23cw=vxzReZntSXgkUefD+=4yZ+Gb+ZAww@mail.gmail.com>
Subject: Re: [PATCH 1/5] rcutorture: Fix stuttering races and other issues
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 4:59=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Tue, Jul 25, 2023 at 11:29:06PM +0000, Joel Fernandes (Google) wrote:
> > The stuttering code isn't functioning as expected. Ideally, it should
> > pause the torture threads for a designated period before resuming. Yet,
> > it fails to halt the test for the correct duration. Additionally, a rac=
e
> > condition exists, potentially causing the stuttering code to pause for
> > an extended period if the 'spt' variable is non-zero due to the stutter
> > orchestration thread's inadequate CPU time.
> >
> > Moreover, over-stuttering can hinder RCU's progress on TREE07 kernels.
> > This happens as the stuttering code may run within a softirq due to RCU
> > callbacks. Consequently, ksoftirqd keeps a CPU busy for several seconds=
,
> > thus obstructing RCU's progress. This situation triggers a warning
> > message in the logs:
> >
> > [ 2169.481783] rcu_torture_writer: rtort_pipe_count: 9
> >
> > This warning suggests that an RCU torture object, although invisible to
> > RCU readers, couldn't make it past the pipe array and be freed -- a
> > strong indication that there weren't enough grace periods during the
> > stutter interval.
> >
> > To address these issues, this patch sets the "stutter end" time to an
> > absolute point in the future set by the main stutter thread. This is
> > then used for waiting in stutter_wait(). While the stutter thread still
> > defines this absolute time, the waiters' waiting logic doesn't rely on
> > the stutter thread receiving sufficient CPU time to halt the stuttering
> > as the halting is now self-controlled.
> >
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  kernel/torture.c | 46 +++++++++++++---------------------------------
> >  1 file changed, 13 insertions(+), 33 deletions(-)
> >
> > diff --git a/kernel/torture.c b/kernel/torture.c
> > index 68dba4ecab5c..63f8f2a7d960 100644
> > --- a/kernel/torture.c
> > +++ b/kernel/torture.c
> > @@ -719,7 +719,7 @@ static void torture_shutdown_cleanup(void)
> >   * suddenly applied to or removed from the system.
> >   */
> >  static struct task_struct *stutter_task;
> > -static int stutter_pause_test;
> > +static ktime_t stutter_till_abs_time;
> >  static int stutter;
> >  static int stutter_gap;
> >
> > @@ -729,30 +729,17 @@ static int stutter_gap;
> >   */
> >  bool stutter_wait(const char *title)
> >  {
> > -     unsigned int i =3D 0;
> >       bool ret =3D false;
> > -     int spt;
> > +     ktime_t now_ns, till_ns;
> >
> >       cond_resched_tasks_rcu_qs();
> > -     spt =3D READ_ONCE(stutter_pause_test);
> > -     for (; spt; spt =3D READ_ONCE(stutter_pause_test)) {
> > -             if (!ret && !rt_task(current)) {
> > -                     sched_set_normal(current, MAX_NICE);
> > -                     ret =3D true;
> > -             }
> > -             if (spt =3D=3D 1) {
> > -                     torture_hrtimeout_jiffies(1, NULL);
> > -             } else if (spt =3D=3D 2) {
> > -                     while (READ_ONCE(stutter_pause_test)) {
> > -                             if (!(i++ & 0xffff))
> > -                                     torture_hrtimeout_us(10, 0, NULL)=
;
> > -                             cond_resched();
> > -                     }
> > -             } else {
> > -                     torture_hrtimeout_jiffies(round_jiffies_relative(=
HZ), NULL);
> > -             }
> > -             torture_shutdown_absorb(title);
> > +     now_ns =3D ktime_get();
> > +     till_ns =3D READ_ONCE(stutter_till_abs_time);
> > +     if (till_ns && ktime_before(now_ns, till_ns)) {
> > +             torture_hrtimeout_ns(ktime_sub(till_ns, now_ns), 0, NULL)=
;
>
> This ktime_sub() is roughly cancelled out by a ktime_add_safe() in
> __hrtimer_start_range_ns().

Yes, functionally it is the same but your suggestion is more robust I think=
.

> Perhaps torture_hrtimeout_ns() needs to
> take a mode argument as in the patch at the end of this email, allowing
> you to ditch that ktime_sub() in favor of HRTIMER_MODE_ABS.

Sure, or we can add a new API and keep the default as relative?

Or have 2 APIs:
torture_hrtimeout_relative_ns();

and:
torture_hrtimeout_absolute_ns();

That makes it more readable IMHO.

Also, do you want me to make both changes (API and usage) in the same
patch? Or were you planning to have a separate patch yourself in -dev
which I can use? Let me know either way, and then I'll refresh the
patch.

thanks,

 - Joel

[..]
