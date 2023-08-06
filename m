Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7247716CE
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 23:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjHFVjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 17:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHFVjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 17:39:39 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3110210E2
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 14:39:38 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b95d5ee18dso59928991fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Aug 2023 14:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1691357976; x=1691962776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ztzaeCtYtwCP+TgK4LroPEckG2nZ7GulZsmnVxqKrI=;
        b=oYyQ6Swk9jieohmBrfD2myp/B8UG+qQ+Nqjm7UmTn2JCa/8B+rk/kLZacdjIbVrO4t
         wd2vEw/XFzG5r4a7anvJKuIsunPBL+xTqaqed00iPMiU0m7rfMbuwy6pbM2o9c9W7U3p
         2OupnbaD/vZvWkGzVptz5fYc9JdJw+qV0ut5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691357976; x=1691962776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ztzaeCtYtwCP+TgK4LroPEckG2nZ7GulZsmnVxqKrI=;
        b=cvDCrDWjYoRi9AjzLKYYGwZanDBxWTgeQlX/XpafRO0+tnSqS6jf0wb6a4E3jThzON
         HYA6q10VSBt33tlhDA/L3/OQBrCubg0L6nzvsQ14a3zyf4FzFaoqha3+g2TOdu+r/Aq9
         L1V9DYqaJWNfF57N4wqjrSi+O75m6uy9IDp9l1SEoc58C3UWM4Gqp1a+SCW/C3Z2IEx9
         UGFb6BEYfIlfxqOfJaOVPiqLS87ge7IoYhM2hCVIlvW/onjuv8fZejlldi7dzvRa2Ewc
         sz8BloX0XxwC2y2At2xSAxcqNW4CZEoBJhQvrcckrSpp3YSC2RAC5yy6urOyspAP5IVV
         PVAA==
X-Gm-Message-State: AOJu0YzXkxhAmPOqmx5mIS2Y2byrJ0V5JVjZqgiXku/MmH1zvM2bFL8d
        612Ftl1xtkyDX3vIFItTCCPv11i7B2LwfgvHquUbZw==
X-Google-Smtp-Source: AGHT+IEOxIY/z9rhtWsusYCYlEoY8E+2R1L0c43csytsTHMVyPOdrzbnR+Us6cYwtly+EMeRP0LLWoK6susUMxWOunk=
X-Received: by 2002:a2e:90d4:0:b0:2b9:cd79:8f94 with SMTP id
 o20-20020a2e90d4000000b002b9cd798f94mr5231918ljg.39.1691357975659; Sun, 06
 Aug 2023 14:39:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230801204121.929256934@infradead.org> <20230801211811.828443100@infradead.org>
In-Reply-To: <20230801211811.828443100@infradead.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sun, 6 Aug 2023 17:39:24 -0400
Message-ID: <CAEXW_YSJ-G_zUKLzLgvCkxAY-dg_Zxo6n=bEXyeEmo9hEMcZpg@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 6, 2023 at 9:52=E2=80=AFAM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> Use guards to reduce gotos and simplify control flow.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/sched/core.c |   15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
>
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1097,25 +1097,22 @@ int get_nohz_timer_target(void)
>
>         hk_mask =3D housekeeping_cpumask(HK_TYPE_TIMER);
>
> -       rcu_read_lock();
> +       guard(rcu)();
> +
>         for_each_domain(cpu, sd) {
>                 for_each_cpu_and(i, sched_domain_span(sd), hk_mask) {
>                         if (cpu =3D=3D i)
>                                 continue;
>
> -                       if (!idle_cpu(i)) {
> -                               cpu =3D i;
> -                               goto unlock;
> -                       }
> +                       if (!idle_cpu(i))
> +                               return i;
>                 }
>         }
>
>         if (default_cpu =3D=3D -1)
>                 default_cpu =3D housekeeping_any_cpu(HK_TYPE_TIMER);
> -       cpu =3D default_cpu;
> -unlock:
> -       rcu_read_unlock();
> -       return cpu;
> +
> +       return default_cpu;
>  }

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

I haven't looked into the actual implementation of the guard stuff,
but rcu_read_lock_guarded() is less of an eyesore to me than
guard(rcu)(); TBH.

thanks,

 - Joel
