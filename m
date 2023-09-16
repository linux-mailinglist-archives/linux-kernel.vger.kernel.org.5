Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66AA07A2D16
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 03:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237857AbjIPBj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 21:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236002AbjIPBjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 21:39:07 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3597C1BF0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 18:39:02 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2bfd3790178so24509441fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 18:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1694828340; x=1695433140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EoAqZjgdFYlv3QsBNPQhl9HtZgUy03KlZ6jFB9UM8P0=;
        b=YNtD9G4f8u7zK8hIfTygE62NrzFwQRP+z5jMElQ5ji3YMEMRvkAhR6umvgCUpiA58G
         8btbXiwPOLEOW4hnQEwpE8H807Qu3U7SvlnGyUl02kkQ6qDbjLerLWOQ7dSuvrgLqB++
         BHWgHglGMetKINR/M3eE8tuBrZCvv2hrRL3I8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694828340; x=1695433140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EoAqZjgdFYlv3QsBNPQhl9HtZgUy03KlZ6jFB9UM8P0=;
        b=Ref9pjbEI8j+LbN5FXh4OLlD4ABE65rD4/3uKrDpeFXvuxuJEvuQEWbW+F37O/68Jo
         otK+whVzBMxE1b0XLHWgc5wpuek8nlrIQeGskKGSgV4Q9c5nSraQc7oqMHTXdMVoXyqb
         5IDhzW7yQ1RDP58aJDeMlikGgR/sERJ714i94VIIyOi4u+O2T+I0dlWQyoP593YhVsP4
         dykEIoCO/e5d/g8XN8fTPKu3d0JPBCbylfSMnz0bp2zxHC7TXjuM63uDRy11QymwvW7n
         CZS8F5ImfDZY9B2DRne35UXaLxOWHTpMuAypzrRcul7rWtJEqvIpCPjGRWRlaPFmNxMh
         xBlw==
X-Gm-Message-State: AOJu0YwmsdcERBq0cbBTwQJ6VK026cUGAKFhkFwT36i/kz7BSaQ06eGC
        i05snEl5akM/k39F5nS6izj1W7RTJwilqThsIHVjznzwPz3sfTnnf/Q=
X-Google-Smtp-Source: AGHT+IEMUZeq71EFs3SfIrL5t6IehgxI2qHXcL93VH9x4C+MGbETA06Ojx8rSlo6+DLR6zjaUDzQ+8JUza6Kqqi4tWo=
X-Received: by 2002:a05:651c:22c:b0:2b6:de52:357 with SMTP id
 z12-20020a05651c022c00b002b6de520357mr2980792ljn.40.1694828339645; Fri, 15
 Sep 2023 18:38:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230912104406.312185-1-frederic@kernel.org> <20230912104406.312185-6-frederic@kernel.org>
In-Reply-To: <20230912104406.312185-6-frederic@kernel.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 15 Sep 2023 21:38:48 -0400
Message-ID: <CAEXW_YQEy7o4swk3voKXsWZN7V=BuaKwrcaHft4vV56TqcxNTA@mail.gmail.com>
Subject: Re: [PATCH 5/5] timers: Tag (hr)timer softirq as hotplug safe
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, vineethrp@gmail.com
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

On Tue, Sep 12, 2023 at 6:44=E2=80=AFAM Frederic Weisbecker <frederic@kerne=
l.org> wrote:
>
> Specific stress involving frequent CPU-hotplug operations, such as
> running rcutorture for example, may trigger the following message:
>
>         "NOHZ tick-stop error: local softirq work is pending, handler #02=
!!!"
>
> This happens in the CPU-down hotplug process, after
> CPUHP_AP_SMPBOOT_THREADS whose teardown callback parks ksoftirqd, and
> before the target CPU shuts down through CPUHP_AP_IDLE_DEAD. In this
> fragile intermediate state, softirqs waiting for threaded handling may
> be forever ignored and eventually reported by the idle task as in the
> above example.
>
> However some vectors are known to be safe as long as the corresponding
> subsystems have teardown callbacks handling the migration of their
> events. The above error message reports pending timers softirq although
> this vector can be considered as hotplug safe because the
> CPUHP_TIMERS_PREPARE teardown callback performs the necessary migration
> of timers after the death of the CPU. Hrtimers also have a similar
> hotplug handling.
>
> Therefore this error message, as far as (hr-)timers are concerned, can
> be considered spurious and the relevant softirq vectors can be marked as
> hotplug safe.

We could:
Cc: stable@vger.kernel.org

Since hell is breaking loose a bit because of:
https://lore.kernel.org/all/20230831133214.XF2yjiEb@linutronix.de/T/

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel


> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  include/linux/interrupt.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> index a92bce40b04b..4a1dc88ddbff 100644
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -569,8 +569,12 @@ enum
>   *     2) rcu_report_dead() reports the final quiescent states.
>   *
>   * _ IRQ_POLL: irq_poll_cpu_dead() migrates the queue
> + *
> + * _ (HR)TIMER_SOFTIRQ: (hr)timers_dead_cpu() migrates the queue
>   */
> -#define SOFTIRQ_HOTPLUG_SAFE_MASK (BIT(RCU_SOFTIRQ) | BIT(IRQ_POLL_SOFTI=
RQ))
> +#define SOFTIRQ_HOTPLUG_SAFE_MASK (BIT(TIMER_SOFTIRQ) | BIT(IRQ_POLL_SOF=
TIRQ) |\
> +                                  BIT(HRTIMER_SOFTIRQ) | BIT(RCU_SOFTIRQ=
))
> +
>

Perhaps

>  /* map softirq index to softirq name. update 'softirq_to_name' in
>   * kernel/softirq.c when adding a new softirq.
> --
> 2.34.1
>
