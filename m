Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5E97E6A9A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 13:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbjKIMbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 07:31:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbjKIMbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 07:31:51 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847F7B4
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 04:31:49 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c6ed1b9a1cso10046421fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 04:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1699533108; x=1700137908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3DDZ9WWhlSJTj99vRms41i5126FH0OEo1/oVYH6FmdY=;
        b=wwNfIUXCRumq2CroxE2urj7W8rDQrBj7EGjzx8Dy1i8FqRH3/YBw8VEMh8SRGNwG32
         Od4JJEhgufws+oUQdONWI214FFhwEDfvo5NgiC4aF/wGIToCX/o8X8P3YUnWDx/sd4ul
         H+/vcWMtzUN+ATLydhlTwTApGWGfHhUQlbP8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699533108; x=1700137908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3DDZ9WWhlSJTj99vRms41i5126FH0OEo1/oVYH6FmdY=;
        b=UCC2J4it0sK2i079xtPt0fGfQAip9N7gQbEhD0Ghzzy+iiiav3urnrCHpxP3C8wnX2
         +NWsWdIGZz0R4aRErIB5kQNRg3ylIuv5JH1jIEfak8gl3hdqi9/cOTdhDbkS89yt+q0l
         Ej0LEbHMruR6Qw54QiGAxWvAnB8CVg4Gq0Hvvje9WUjK8+NuAtOu/Y+wRVKptmBI2X/J
         O7XMvEh9Lop7902J24FgsJEe/sXx/4lAYweMvW/7wBNkna/pnri7k9SuSoCcY+Jeubbt
         lndjW98LNGycc14xcw+ifimE5iq/QYzCoHrCU8euHI5kjOvh7jO3O17gRZv+oqb3yfOd
         h+lQ==
X-Gm-Message-State: AOJu0YwKKXzWZbr4G+jS5VpTr6WWmBfJLzSIbjZaPtu9RRlzSfoSu1Ji
        vUP8As3fKeQBG9QuhmeHYEyTkr3Pcv/OoE+hO+ORAg==
X-Google-Smtp-Source: AGHT+IHZwdKtI1G6rZOpL/McgczrPMkVBTdBQ+GYsHRVfXuWbUjzCKzR2kzGLrgFXse56XjzrNWfSEGiGithljkq124=
X-Received: by 2002:a2e:9682:0:b0:2c5:1809:69ba with SMTP id
 q2-20020a2e9682000000b002c5180969bamr4046024lji.40.1699533107509; Thu, 09 Nov
 2023 04:31:47 -0800 (PST)
MIME-Version: 1.0
References: <20231020014031.919742-1-joel@joelfernandes.org>
 <20231020014031.919742-3-joel@joelfernandes.org> <CAKfTPtDk+awL2RxrRL_4-epj069-iXRbUeSwPH5NYz7ncpVzHA@mail.gmail.com>
 <20231022002805.GA3219395@google.com> <CAKfTPtCAbMERMkD9h1QRLUti0nPVW_u9N1Vr7W4ONbu_rEjTtw@mail.gmail.com>
 <20231109100254.GA111915@google.com>
In-Reply-To: <20231109100254.GA111915@google.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 9 Nov 2023 07:31:36 -0500
Message-ID: <CAEXW_YRt2guqmrL1iZwECnEJf-xdwrDrPrmfgdWYzcPTsA22+A@mail.gmail.com>
Subject: Re: [PATCH 3/3] sched: Update ->next_balance correctly during newidle balance
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
        Suleiman Souhlal <suleiman@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 9, 2023 at 5:02=E2=80=AFAM Joel Fernandes <joel@joelfernandes.o=
rg> wrote:
[...]
> > > things worse for power on ARM where you have uclamp stuff happening i=
n the
> > > load balance paths which is quite heavy when I last traced that..
> > >
> > > Further, we have observed in our tracing on real device that the upda=
te of
> > > rq->next_balance from the newidle path is itself buggy... we observed=
 that
> > > because newidle balance may not update rq->last_balance, it is possib=
le that
> > > rq->next_balance when updated by update_next_balance() will be update=
d to a
> > > value that is in the past and it will be stuck there for a long time!=
 Perhaps
> > > we should investigate more and fix that bug separately. Vineeth could=
 provide
> > > more details on the "getting stuck in the past" behavior as well.
> >
> > sd->last_balance reflects last time an idle/busy load_balance happened
> > (newly idle is out of the scope for the points that I mentioned
> > previously).  So if no load balance happens for a while, the
> > rq->next_balance can be in the past but I don't see a problem here. It
> > just means that a load balance hasn't happened for a while. It can
> > even move backward if it has been set when busy but the cpu is now
> > idle
>
> Sure, but I think it should at least set it by get_sd_balance_interval() =
into
> the future. Like so (untested)? Let me know what you think and thanks!

Btw, I also drew a graph showing the issue without patch:
https://i.imgur.com/RgTr45l.png

Each "x" mark is run_rebalance_domains() running on a CPU. As can be
seen, there were some 10 occurrences in a span of 15ms in one
instance.

Thanks,

 - Joel


> ---8<-----------------------
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a3318aeff9e8..0d6667d31c51 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11314,6 +11314,30 @@ get_sd_balance_interval(struct sched_domain *sd,=
 int cpu_busy)
>         return interval;
>  }
>
> +/*
> + * Update the next balance from newidle balance.
> + * The update of next_balance from newidle balance tries to make sure th=
at
> + * we don't trigger periodic balance too far in the future on a now-idle
> + * system.  This is just like update_next_balance except that since
> + * sd->last_balance may not have been updated for a while, we're careful=
 to
> + * not set next_balance in the past.
> + */
> +static inline void
> +update_next_balance_newidle(struct sched_domain *sd, unsigned long *next=
_balance)
> +{
> +       unsigned long interval, next;
> +
> +       /* used by new idle balance, so cpu_busy =3D 0 */
> +       interval =3D get_sd_balance_interval(sd, 0);
> +       next =3D sd->last_balance + interval;
> +
> +       next =3D max(next, jiffies + interval);
> +
> +       if (time_after(*next_balance, next)) {
> +               *next_balance =3D next;
> +       }
> +}
> +
>  static inline void
>  update_next_balance(struct sched_domain *sd, unsigned long *next_balance=
)
>  {
> @@ -12107,7 +12131,7 @@ static int newidle_balance(struct rq *this_rq, st=
ruct rq_flags *rf)
>             (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
>
>                 if (sd)
> -                       update_next_balance(sd, &next_balance);
> +                       update_next_balance_newidle(sd, &next_balance);
>                 rcu_read_unlock();
>
>                 goto out;
> @@ -12124,7 +12148,7 @@ static int newidle_balance(struct rq *this_rq, st=
ruct rq_flags *rf)
>                 int continue_balancing =3D 1;
>                 u64 domain_cost;
>
> -               update_next_balance(sd, &next_balance);
> +               update_next_balance_newidle(sd, &next_balance);
>
>                 if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_co=
st)
>                         break;
