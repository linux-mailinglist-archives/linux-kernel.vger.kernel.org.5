Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55977811249
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379018AbjLMNB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 08:01:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379016AbjLMNBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:01:19 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F114818E;
        Wed, 13 Dec 2023 05:01:21 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-551ee7d5214so1781010a12.0;
        Wed, 13 Dec 2023 05:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702472480; x=1703077280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BjR4GTzbD+ztOczUPclPn7Vi4rG18p+B+ycvMIj49cc=;
        b=GcnDdyiWOLgWg6q+1R5IivLY15dQIq0wBSMIzts5MDUcyc62vTRdF9mqSeJ9Tk19zT
         3fp5eyoe96CEwDg0jHs/aQwWluEH9qP+lDaP4jWh2x+qHI+O2HyKD6Pft7U1AtbiRGiO
         4Ov4t2Sw+9QP7ooDmHrXpsdTPqEtlLDImzlNVMNwCZ8ZoqJ2EHY8+ly8jOsgL7eU5toB
         UpVjFshTgKEB/sorXU5/KBgG5MLsfTIVa7fTcSXnfuhzp7HnzWF2Eoa5NA99YdzoTk7g
         Wn7B26niWWXTHPVYXPPQsnSw3HBNpUYIhp564jdJuql2NVOcQBSK5SEfJr65HhCgkIWf
         mrKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702472480; x=1703077280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BjR4GTzbD+ztOczUPclPn7Vi4rG18p+B+ycvMIj49cc=;
        b=M23P6gQbX1/qkU1tI5H1PjC2vj6ELfxPgTH6g18IwpLeWCn5NWUEuZ+ChKUiXNjztH
         lrjUMr7q/VdSiU4ow5uu5oP4SKbQT0R/p6EKxFRO8NVKo2qxVstGn41W3dQgTVzHxX6b
         UIsBM7L9K5zewu68g6H698dJZqhDd2tUDRCLQrm7bqgl6cfvKWXg/fnMZJmJoHdDwEZo
         L16gf4daFxQ9aauyxUlJHOVmv0v1ifLSsjeKNPwPK/h25o6Iy6QcW8/1tYf1tFBi6e/f
         MUOlnid4DnV8RGQrS3VMH8GSj+Amw3fBUOleZZxJCYsqVx9wtNV0ySQ9R5Y7Wb9kW3Vw
         1vtA==
X-Gm-Message-State: AOJu0YwXCf2dP0J6ViBVt0tGP+eYHJiFMURxRlekFRdtVUpiQAbdjDLx
        KoIg2nsUO+so15XXEK8gq/dJf+BDoA0lA0b8sw8=
X-Google-Smtp-Source: AGHT+IHkjpgOArvGX6PoFoREmY9ZaOYav27hT0YCYst2VY7YTTAiD8kLE4mXTMByEOqYf7+3kANia1x38jtI6KJtB6Y=
X-Received: by 2002:a17:906:51c6:b0:a1e:ac03:9752 with SMTP id
 v6-20020a17090651c600b00a1eac039752mr7386746ejk.52.1702472479965; Wed, 13 Dec
 2023 05:01:19 -0800 (PST)
MIME-Version: 1.0
References: <20231208220545.7452-1-frederic@kernel.org> <20231208220545.7452-2-frederic@kernel.org>
In-Reply-To: <20231208220545.7452-2-frederic@kernel.org>
From:   Neeraj upadhyay <neeraj.iitr10@gmail.com>
Date:   Wed, 13 Dec 2023 18:31:07 +0530
Message-ID: <CAFwiDX8NN_vJ7S50SRiyQKMZ9YpGemB-GLOAHuTQSSD+f0SiVA@mail.gmail.com>
Subject: Re: [PATCH 1/8] rcu/nocb: Make IRQs disablement symetric
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 9, 2023 at 3:35=E2=80=AFAM Frederic Weisbecker <frederic@kernel=
.org> wrote:
>
> Currently IRQs are disabled on call_rcu() and then depending on the
> context:
>
> * If the CPU is in nocb mode:
>
>    - If the callback is enqueued in the bypass list, IRQs are re-enabled
>      implictly by rcu_nocb_try_bypass()
>
>    - If the callback is enqueued in the normal list, IRQs are re-enabled
>      implicitly by __call_rcu_nocb_wake()
>
> * If the CPU is NOT in nocb mode, IRQs are reenabled explicitly from call=
_rcu()
>
> This makes the code a bit hard to follow, especially as it interleaves
> with nocb locking.
>
> To make the IRQ flags coverage clearer and also in order to prepare for
> moving all the nocb enqueue code to its own function, always re-enable
> the IRQ flags explicitly from call_rcu().
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  kernel/rcu/tree.c      |  9 ++++++---
>  kernel/rcu/tree_nocb.h | 20 +++++++++-----------
>  2 files changed, 15 insertions(+), 14 deletions(-)
>

Nit: s/symetric/symmetric/

Reviewed-by: Neeraj Upadhyay (AMD) <neeraj.iitr10@gmail.com>


Thanks
Neeraj

> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 52c2fdbc6363..74159c6d3bdf 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2697,8 +2697,10 @@ __call_rcu_common(struct rcu_head *head, rcu_callb=
ack_t func, bool lazy_in)
>         }
>
>         check_cb_ovld(rdp);
> -       if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags, lazy))
> +       if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags, lazy)) {
> +               local_irq_restore(flags);
>                 return; // Enqueued onto ->nocb_bypass, so just leave.
> +       }
>         // If no-CBs CPU gets here, rcu_nocb_try_bypass() acquired ->nocb=
_lock.
>         rcu_segcblist_enqueue(&rdp->cblist, head);
>         if (__is_kvfree_rcu_offset((unsigned long)func))
> @@ -2716,8 +2718,8 @@ __call_rcu_common(struct rcu_head *head, rcu_callba=
ck_t func, bool lazy_in)
>                 __call_rcu_nocb_wake(rdp, was_alldone, flags); /* unlocks=
 */
>         } else {
>                 __call_rcu_core(rdp, head, flags);
> -               local_irq_restore(flags);
>         }
> +       local_irq_restore(flags);
>  }
>
>  #ifdef CONFIG_RCU_LAZY
> @@ -4615,8 +4617,9 @@ void rcutree_migrate_callbacks(int cpu)
>                 __call_rcu_nocb_wake(my_rdp, true, flags);
>         } else {
>                 rcu_nocb_unlock(my_rdp); /* irqs remain disabled. */
> -               raw_spin_unlock_irqrestore_rcu_node(my_rnp, flags);
> +               raw_spin_unlock_rcu_node(my_rnp); /* irqs remain disabled=
. */
>         }
> +       local_irq_restore(flags);
>         if (needwake)
>                 rcu_gp_kthread_wake();
>         lockdep_assert_irqs_enabled();
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index 5598212d1f27..3f70fd0a2db4 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -532,9 +532,7 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp,=
 struct rcu_head *rhp,
>         // 2. Both of these conditions are met:
>         //    a. The bypass list previously had only lazy CBs, and:
>         //    b. The new CB is non-lazy.
> -       if (ncbs && (!bypass_is_lazy || lazy)) {
> -               local_irq_restore(flags);
> -       } else {
> +       if (!ncbs || (bypass_is_lazy && !lazy)) {
>                 // No-CBs GP kthread might be indefinitely asleep, if so,=
 wake.
>                 rcu_nocb_lock(rdp); // Rare during call_rcu() flood.
>                 if (!rcu_segcblist_pend_cbs(&rdp->cblist)) {
> @@ -544,7 +542,7 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp,=
 struct rcu_head *rhp,
>                 } else {
>                         trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
>                                             TPS("FirstBQnoWake"));
> -                       rcu_nocb_unlock_irqrestore(rdp, flags);
> +                       rcu_nocb_unlock(rdp);
>                 }
>         }
>         return true; // Callback already enqueued.
> @@ -570,7 +568,7 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp=
, bool was_alldone,
>         // If we are being polled or there is no kthread, just leave.
>         t =3D READ_ONCE(rdp->nocb_gp_kthread);
>         if (rcu_nocb_poll || !t) {
> -               rcu_nocb_unlock_irqrestore(rdp, flags);
> +               rcu_nocb_unlock(rdp);
>                 trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
>                                     TPS("WakeNotPoll"));
>                 return;
> @@ -583,17 +581,17 @@ static void __call_rcu_nocb_wake(struct rcu_data *r=
dp, bool was_alldone,
>                 rdp->qlen_last_fqs_check =3D len;
>                 // Only lazy CBs in bypass list
>                 if (lazy_len && bypass_len =3D=3D lazy_len) {
> -                       rcu_nocb_unlock_irqrestore(rdp, flags);
> +                       rcu_nocb_unlock(rdp);
>                         wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE_LAZY,
>                                            TPS("WakeLazy"));
>                 } else if (!irqs_disabled_flags(flags)) {
>                         /* ... if queue was empty ... */
> -                       rcu_nocb_unlock_irqrestore(rdp, flags);
> +                       rcu_nocb_unlock(rdp);
>                         wake_nocb_gp(rdp, false);
>                         trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
>                                             TPS("WakeEmpty"));
>                 } else {
> -                       rcu_nocb_unlock_irqrestore(rdp, flags);
> +                       rcu_nocb_unlock(rdp);
>                         wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE,
>                                            TPS("WakeEmptyIsDeferred"));
>                 }
> @@ -611,15 +609,15 @@ static void __call_rcu_nocb_wake(struct rcu_data *r=
dp, bool was_alldone,
>                 if ((rdp->nocb_cb_sleep ||
>                      !rcu_segcblist_ready_cbs(&rdp->cblist)) &&
>                     !timer_pending(&rdp->nocb_timer)) {
> -                       rcu_nocb_unlock_irqrestore(rdp, flags);
> +                       rcu_nocb_unlock(rdp);
>                         wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE_FORCE,
>                                            TPS("WakeOvfIsDeferred"));
>                 } else {
> -                       rcu_nocb_unlock_irqrestore(rdp, flags);
> +                       rcu_nocb_unlock(rdp);
>                         trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS=
("WakeNot"));
>                 }
>         } else {
> -               rcu_nocb_unlock_irqrestore(rdp, flags);
> +               rcu_nocb_unlock(rdp);
>                 trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WakeNo=
t"));
>         }
>  }
> --
> 2.42.1
>
>
