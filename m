Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81070750F31
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 19:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbjGLRDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 13:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbjGLRCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 13:02:50 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA26119A7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 10:02:48 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b6f943383eso117355181fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 10:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1689181367; x=1691773367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OvoEOajiEwYXBD3xzLluGfgCVtGjTJSaHMHQydgzNEE=;
        b=cqQDuh7KkBC7Bp6ndhg7nXNYsINnQl/XnlT+1UAc8RaZTq+BuxgRGEoG8mqoOpE6js
         XKPABgipIV5zI1bbzGToaFdttSQ9on3vO/0h7AHhN2349r+/o4nXk2tQ9zir/uj+PMqf
         7U3DT3YK7cdjRWUEqF0PhnLEVmVuRgxy0mUC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689181367; x=1691773367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OvoEOajiEwYXBD3xzLluGfgCVtGjTJSaHMHQydgzNEE=;
        b=MlOVAnht5toPfNCnVlkDiTTUAMKKnckqIG8wzrjP7B1CHihMqB+ECb5oAcIwZlc0Zf
         nu+LW8O4tN83rjP7DOCDAXOuYpwL0aJoX/eN4wGyhQt06eKpxS+15QQmk/tdYlQKgPuu
         4cCfDPlq4lk2TkhtCmnfaRhXPmZkCI+JIAYKLjYjO2DirGJqMeelTKh/iBTtaqcZhG09
         kICTnFAgv3aU1reCs1bcmnjOMO/1gJeu4Y54t0K2cdO8Jp++W7tcUZCSLBzhqnZ9AzSh
         zSTpa2b6oH50F1UZ5zLTJXUNTLgiOw4oUQhVRErxmh2ox++wjP3qilzEv89iHOBt26XR
         ktbA==
X-Gm-Message-State: ABy/qLYpSNYyFcZVqaGgUGRXJ8JG6CLeC0DcRntNk+tf9dslJ54VFnOT
        T+T7GesIACFm7+G6lz/Ts5nUjYbh8Tl7cKPE9aKQOA==
X-Google-Smtp-Source: APBJJlGlT858DQ/NfqPA3OlYGxIXp57HPZH8ded5Q4ToS48ybKGBOA2p1X6hcXClrEz/A6yz7yx5y/8vtOtl4ryFQpk=
X-Received: by 2002:a2e:8909:0:b0:2b6:9f5d:e758 with SMTP id
 d9-20020a2e8909000000b002b69f5de758mr19193207lji.9.1689181367032; Wed, 12 Jul
 2023 10:02:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230711233816.2187577-1-dhavale@google.com>
In-Reply-To: <20230711233816.2187577-1-dhavale@google.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 12 Jul 2023 13:02:35 -0400
Message-ID: <CAEXW_YQvpiFEaaNoS=Msgi17mU3kZD+q8bNBaHYasMArG9aPig@mail.gmail.com>
Subject: Re: [PATCH v1] rcu: Fix and improve RCU read lock checks when !CONFIG_DEBUG_LOCK_ALLOC
To:     Sandeep Dhavale <dhavale@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-erofs@lists.ozlabs.org, xiang@kernel.org,
        Will Shiu <Will.Shiu@mediatek.com>, kernel-team@android.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 7:38=E2=80=AFPM Sandeep Dhavale <dhavale@google.com=
> wrote:
>
> Currently if CONFIG_DEBUG_LOCK_ALLOC is not set
>
> - rcu_read_lock_held() always returns 1
> - rcu_read_lock_any_held() may return 0 with CONFIG_PREEMPT_RCU
>
> This is inconsistent and it was discovered when trying a fix
> for problem reported [1] with CONFIG_DEBUG_LOCK_ALLOC is not
> set and CONFIG_PREEMPT_RCU is enabled. Gist of the problem is
> that EROFS wants to detect atomic context so it can do inline
> decompression whenever possible, this is important performance
> optimization. It turns out that z_erofs_decompressqueue_endio()
> can be called from blk_mq_flush_plug_list() with rcu lock held
> and hence fix uses rcu_read_lock_any_held() to decide to use
> sync/inline decompression vs async decompression.
>
> As per documentation, we should return lock is held if we aren't
> certain. But it seems we can improve the checks for if the lock
> is held even if CONFIG_DEBUG_LOCK_ALLOC is not set instead of
> hardcoding to always return true.
>
> * rcu_read_lock_held()
> - For CONFIG_PREEMPT_RCU using rcu_preempt_depth()
> - using preemptible() (indirectly preempt_count())
>
> * rcu_read_lock_bh_held()
> - For CONFIG_PREEMPT_RT Using in_softirq() (indirectly softirq_cont())
> - using preemptible() (indirectly preempt_count())
>
> Lastly to fix the inconsistency, rcu_read_lock_any_held() is updated
> to use other rcu_read_lock_*_held() checks.
>
> Two of the improved checks are moved to kernel/rcu/update.c because
> rcupdate.h is included from the very low level headers which do not know
> what current (task_struct) is so the macro rcu_preempt_depth() cannot be
> expanded in the rcupdate.h. See the original comment for
> rcu_preempt_depth() in patch at [2] for more information.
>
> [1]
> https://lore.kernel.org/all/20230621220848.3379029-1-dhavale@google.com/
> [2]
> https://lore.kernel.org/all/1281392111-25060-8-git-send-email-paulmck@lin=
ux.vnet.ibm.com/
>
> Reported-by: Will Shiu <Will.Shiu@mediatek.com>
> Signed-off-by: Sandeep Dhavale <dhavale@google.com>
> ---
>  include/linux/rcupdate.h | 12 +++---------
>  kernel/rcu/update.c      | 21 ++++++++++++++++++++-
>  2 files changed, 23 insertions(+), 10 deletions(-)
>
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 5e5f920ade90..0d1d1d8c2360 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -319,14 +319,11 @@ int rcu_read_lock_any_held(void);
>  # define rcu_lock_acquire(a)           do { } while (0)
>  # define rcu_lock_release(a)           do { } while (0)
>
> -static inline int rcu_read_lock_held(void)
> -{
> -       return 1;
> -}
> +int rcu_read_lock_held(void);
>
>  static inline int rcu_read_lock_bh_held(void)
>  {
> -       return 1;
> +       return !preemptible() || in_softirq();
>  }
>
>  static inline int rcu_read_lock_sched_held(void)
> @@ -334,10 +331,7 @@ static inline int rcu_read_lock_sched_held(void)
>         return !preemptible();
>  }
>
> -static inline int rcu_read_lock_any_held(void)
> -{
> -       return !preemptible();
> -}
> +int rcu_read_lock_any_held(void);
>
>  static inline int debug_lockdep_rcu_enabled(void)
>  {
> diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> index 19bf6fa3ee6a..b34fc5bb96cf 100644
> --- a/kernel/rcu/update.c
> +++ b/kernel/rcu/update.c
> @@ -390,8 +390,27 @@ int rcu_read_lock_any_held(void)
>  }
>  EXPORT_SYMBOL_GPL(rcu_read_lock_any_held);
>
> -#endif /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
> +#else /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
>
> +int rcu_read_lock_held(void)
> +{
> +       if (IS_ENABLED(CONFIG_PREEMPT_RCU))
> +               return rcu_preempt_depth();
> +       return !preemptible();
> +}
> +EXPORT_SYMBOL_GPL(rcu_read_lock_held);
> +
> +int rcu_read_lock_any_held(void)
> +{
> +       if (rcu_read_lock_held() ||
> +           rcu_read_lock_bh_held() ||
> +           rcu_read_lock_sched_held())
> +               return 1;
> +       return !preemptible();

Actually even the original code is incorrect (the lockdep version)
since preemptible() cannot be relied upon if CONFIG_PREEMPT_COUNT is
not set. However, that's debug code. In this case, it is a real
user (the fs code). In non-preemptible kernels, we are always in an
RCU-sched section. So you can't really see if anyone called your code
under rcu_read_lock(). The rcu_read_lock/unlock() would be getting
NOOPed. In such a kernel, it will always tell your code it is in an
RCU reader. That's not ideal for that erofs code?

Also, per that erofs code:
        /* Use (kthread_)work and sync decompression for atomic contexts on=
ly */
        if (!in_task() || irqs_disabled() || rcu_read_lock_any_held()) {

I guess you are also assuming that rcu_read_lock_any_held() tells you
something about atomicity but strictly speaking, it doesn't because
preemptible RCU readers are preemptible. You can't block but
preemption is possible so it is not "atomic". Maybe you meant "cannot
block"?

As such this patch looks correct to me, one thing I noticed is that
you can check rcu_is_watching() like the lockdep-enabled code does.
That will tell you also if a reader-section is possible because in
extended-quiescent-states, RCU readers should be non-existent or
that's a bug.

Could you also verify that this patch does not cause bloating of the
kernel if lockdep is disabled?

thanks,

 - Joel
