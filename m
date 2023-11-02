Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D783C7DEBEB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 05:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348485AbjKBEgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 00:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348495AbjKBEgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 00:36:24 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B2D127
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 21:36:19 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9a58dbd5daeso77659466b.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 21:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698899778; x=1699504578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4e1IhG3dgX5+0jBGESSJg3foTb8prRBl9Wa07epnXo=;
        b=JtMDgyaMijhzsJ48mDezJaUQnAOc0ypv8MwVD7WzeSiIpznZEuxAR3yfTeoUGTTEUe
         VEdoqnr6tV/3D/xXvH5nesoGvr0fNGOYtiX3Fma504NrTx249UCRvFNul7aIX+Lf+797
         tqsAzpF505qJT9XRVUuj/zhWhFV8mAUXlncJTGlKlgs3UuB5mOgRSmPbdOT/e0um8HoR
         K0+nr5Wz5Xh5jyfBmXOTWu7ou6UyrAGfLlhgv5J/MvLVtNOD7c45IfNvTvhuSwfq+ac4
         h4SYzSOcYV9sS+uHDOQDxpU5R4dIBBHOqIcCKMHbONpoxvlix5G4nf/z1hP3GvkKhVdN
         /8DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698899778; x=1699504578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b4e1IhG3dgX5+0jBGESSJg3foTb8prRBl9Wa07epnXo=;
        b=ucyoMPLMB86ctMORPriBQEcfITglKL12I6+aPCj582fRMMeoQX4Pqr7ZjFKtsr9OJC
         T0MyYDNUi00j035MOrOq3L6lLtN/VQpzD5hgBoDM7BMP+OZcxjBP6Aju+4guLg2t0CF5
         B4AUkyl2Lbp2TXKcHe5LKdC3snFg15M3Ih9rSTkFqb3iIRz2bknWM+amUAtWZaohG5WM
         5814cEbXvFsGzJ0OeIXE6FZziTyd9CHuJtDZBV9+vFpuPRkfbHFK4Jq59KdsC4VVNR7q
         d3NfchPEdhKHz8EO65cK9XE4cjvbl+/YcT1NPmXpIuj+NatlZxyg67fRRl14VR8zSySa
         wIuA==
X-Gm-Message-State: AOJu0Yz6DTso3UMNB3fVYV0Nzn8IZyhgMzT6JiOpX+KxH0SXWZM1/sbd
        c/UeFPih/O52tPT0Tphc0Twk+C/Dcx3jFFXVehaiDUbSwG7LJvet7/U=
X-Google-Smtp-Source: AGHT+IEKxBn75Of5h7wUg/bwjn/Aaw9ALtXjPAMj7mA/p8EzPQ/S83r/m6SM658Ar5S2hd0wvqu47J/73O0hobvY8zY=
X-Received: by 2002:a17:907:a45:b0:9d5:b7fb:7b62 with SMTP id
 be5-20020a1709070a4500b009d5b7fb7b62mr3860026ejc.20.1698899777742; Wed, 01
 Nov 2023 21:36:17 -0700 (PDT)
MIME-Version: 1.0
References: <20231102005310.439588-1-longman@redhat.com>
In-Reply-To: <20231102005310.439588-1-longman@redhat.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 1 Nov 2023 21:35:39 -0700
Message-ID: <CAJD7tkZLKiKJQRgJ6MexFwt2_iDHeBzyDxuT3ZWtL0yjN+7pHg@mail.gmail.com>
Subject: Re: [PATCH v2] cgroup/rstat: Reduce cpu_lock hold time in cgroup_rstat_flush_locked()
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Joe Mario <jmario@redhat.com>,
        Sebastian Jug <sejug@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 1, 2023 at 5:53=E2=80=AFPM Waiman Long <longman@redhat.com> wro=
te:
>
> When cgroup_rstat_updated() isn't being called concurrently with
> cgroup_rstat_flush_locked(), its run time is pretty short. When
> both are called concurrently, the cgroup_rstat_updated() run time
> can spike to a pretty high value due to high cpu_lock hold time in
> cgroup_rstat_flush_locked(). This can be problematic if the task calling
> cgroup_rstat_updated() is a realtime task running on an isolated CPU
> with a strict latency requirement. The cgroup_rstat_updated() call can
> happens when there is a page fault even though the task is running in

s/happens/happen

> user space most of the time.
>
> The percpu cpu_lock is used to protect the update tree -
> updated_next and updated_children. This protection is only needed
> when cgroup_rstat_cpu_pop_updated() is being called. The subsequent
> flushing operation which can take a much longer time does not need
> that protection.

nit: add: as it is already protected by cgroup_rstat_lock.

>
> To reduce the cpu_lock hold time, we need to perform all the
> cgroup_rstat_cpu_pop_updated() calls up front with the lock
> released afterward before doing any flushing. This patch adds a new
> cgroup_rstat_updated_list() function to return a singly linked list of
> cgroups to be flushed.
>
> By adding some instrumentation code to measure the maximum elapsed times
> of the new cgroup_rstat_updated_list() function and each cpu iteration of
> cgroup_rstat_updated_locked() around the old cpu_lock lock/unlock pair
> on a 2-socket x86-64 server running parallel kernel build, the maximum
> elapsed times are 27us and 88us respectively. The maximum cpu_lock hold
> time is now reduced to about 30% of the original.
>
> Below were the run time distribution of cgroup_rstat_updated_list()
> during the same period:
>
>       Run time             Count
>       --------             -----
>          t <=3D 1us       12,574,302
>    1us < t <=3D 5us        2,127,482
>    5us < t <=3D 10us           8,445
>   10us < t <=3D 20us           6,425
>   20us < t <=3D 30us              50
>
> Signed-off-by: Waiman Long <longman@redhat.com>

LGTM with some nits.

Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

> ---
>  include/linux/cgroup-defs.h |  6 +++++
>  kernel/cgroup/rstat.c       | 45 ++++++++++++++++++++++++-------------
>  2 files changed, 36 insertions(+), 15 deletions(-)
>
> diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
> index 265da00a1a8b..daaf6d4eb8b6 100644
> --- a/include/linux/cgroup-defs.h
> +++ b/include/linux/cgroup-defs.h
> @@ -491,6 +491,12 @@ struct cgroup {
>         struct cgroup_rstat_cpu __percpu *rstat_cpu;
>         struct list_head rstat_css_list;
>
> +       /*
> +        * A singly-linked list of cgroup structures to be rstat flushed.
> +        * Protected by cgroup_rstat_lock.

Do you think we should mention that this is a scratch area for
cgroup_rstat_flush_locked()? IOW, this field will be invalid or may
contain garbage otherwise.

It might be also useful to mention that the scope of usage for this is
for each percpu flushing iteration. The cgroup_rstat_lock can be
dropped between percpu flushing iterations, so different flushers can
reuse this field safely because it is re-initialized in every
iteration and only used there.

> +        */
> +       struct cgroup   *rstat_flush_next;
> +
>         /* cgroup basic resource statistics */
>         struct cgroup_base_stat last_bstat;
>         struct cgroup_base_stat bstat;
> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> index d80d7a608141..a86d40ed8bda 100644
> --- a/kernel/cgroup/rstat.c
> +++ b/kernel/cgroup/rstat.c
> @@ -145,6 +145,34 @@ static struct cgroup *cgroup_rstat_cpu_pop_updated(s=
truct cgroup *pos,
>         return pos;
>  }
>
> +/*
> + * Return a list of updated cgroups to be flushed
> + */

Why not just on a single line?
/* Return a list of updated cgroups to be flushed */

> +static struct cgroup *cgroup_rstat_updated_list(struct cgroup *root, int=
 cpu)
> +{
> +       raw_spinlock_t *cpu_lock =3D per_cpu_ptr(&cgroup_rstat_cpu_lock, =
cpu);
> +       struct cgroup *head, *tail, *next;
> +       unsigned long flags;
> +
> +       /*
> +        * The _irqsave() is needed because cgroup_rstat_lock is
> +        * spinlock_t which is a sleeping lock on PREEMPT_RT. Acquiring
> +        * this lock with the _irq() suffix only disables interrupts on
> +        * a non-PREEMPT_RT kernel. The raw_spinlock_t below disables
> +        * interrupts on both configurations. The _irqsave() ensures
> +        * that interrupts are always disabled and later restored.
> +        */
> +       raw_spin_lock_irqsave(cpu_lock, flags);
> +       head =3D tail =3D cgroup_rstat_cpu_pop_updated(NULL, root, cpu);
> +       while (tail) {
> +               next =3D cgroup_rstat_cpu_pop_updated(tail, root, cpu);
> +               tail->rstat_flush_next =3D next;
> +               tail =3D next;
> +       }
> +       raw_spin_unlock_irqrestore(cpu_lock, flags);
> +       return head;
> +}
> +
>  /*
>   * A hook for bpf stat collectors to attach to and flush their stats.
>   * Together with providing bpf kfuncs for cgroup_rstat_updated() and
> @@ -179,21 +207,9 @@ static void cgroup_rstat_flush_locked(struct cgroup =
*cgrp)
>         lockdep_assert_held(&cgroup_rstat_lock);
>
>         for_each_possible_cpu(cpu) {
> -               raw_spinlock_t *cpu_lock =3D per_cpu_ptr(&cgroup_rstat_cp=
u_lock,
> -                                                      cpu);
> -               struct cgroup *pos =3D NULL;
> -               unsigned long flags;
> +               struct cgroup *pos =3D cgroup_rstat_updated_list(cgrp, cp=
u);
>
> -               /*
> -                * The _irqsave() is needed because cgroup_rstat_lock is
> -                * spinlock_t which is a sleeping lock on PREEMPT_RT. Acq=
uiring
> -                * this lock with the _irq() suffix only disables interru=
pts on
> -                * a non-PREEMPT_RT kernel. The raw_spinlock_t below disa=
bles
> -                * interrupts on both configurations. The _irqsave() ensu=
res
> -                * that interrupts are always disabled and later restored=
.
> -                */
> -               raw_spin_lock_irqsave(cpu_lock, flags);
> -               while ((pos =3D cgroup_rstat_cpu_pop_updated(pos, cgrp, c=
pu))) {
> +               for (; pos; pos =3D pos->rstat_flush_next) {
>                         struct cgroup_subsys_state *css;
>
>                         cgroup_base_stat_flush(pos, cpu);
> @@ -205,7 +221,6 @@ static void cgroup_rstat_flush_locked(struct cgroup *=
cgrp)
>                                 css->ss->css_rstat_flush(css, cpu);
>                         rcu_read_unlock();
>                 }
> -               raw_spin_unlock_irqrestore(cpu_lock, flags);
>
>                 /* play nice and yield if necessary */
>                 if (need_resched() || spin_needbreak(&cgroup_rstat_lock))=
 {
> --
> 2.39.3
>
