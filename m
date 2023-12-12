Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96E380F21F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbjLLQOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbjLLQOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:14:39 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECB4C3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:14:45 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-551d5cd1c42so4194a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702397683; x=1703002483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4+KqdeA+ayPueTXRbDqPJvGB/NHejJMBX/m1tCj9sbw=;
        b=CjhpNPQnMdSfwXoXcKA+pIfjlo2kfAzCePL1rAlHfnlZoGF9HReaipOXValH1ZeqHU
         Tq8ZAu9PAsluboSaMIRbGk8i4kA4KUVuzfyWLCf57S/vf1b2qAnUqiJ6b/8gGh+3pOy+
         w2RQQmp7oqeVaCjIqOj/fITm21yhC86cD6LD6/Sd8EaUB3dJw7+STiKarpuC5c2WMIfo
         rg1VusBNmbNMfUoH5ZRWnRV0yOhSCdGL0Qs2yaTZhXJ7vL5uE2brXUtjgP6Xup+bBFHB
         zhqCPTLAqamOCgwOKky4dmcUYngdEMprU5hAmJqB2NsoZT6aU00H06YoEGKSv3yWYdkW
         WFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702397683; x=1703002483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4+KqdeA+ayPueTXRbDqPJvGB/NHejJMBX/m1tCj9sbw=;
        b=mcfcM9EO33dhF9/bi4QpMWz1nd0AF2P+mrVNzgpcBKbxwCyQKStvM5YpY94CPTN3zM
         YxzJcMi58U1jv/9Ma9+0h3vykxNzt3i3Ue6nmOdrrVjvDZ9z4V0eeWuBD/NLU+/i03uh
         VBVTXoqSA18zn2dc2bvGIpEPlnJSLs/TjIn6oRSNxMspXHcZddna1HB+vZ153KffbJIN
         CT3XQPjLdM3NdrAueIkQ1X71hSHHtghC6FZIwHwvP5qcMCUcPnvkscCNaIHQPKDLOWvJ
         x86ZoUbkWuhUXuzw5s7jGNvbtrRt80U4Dc09NilOahPPe9xMvBSoNlSCyUJCfwLdWE3c
         bh4A==
X-Gm-Message-State: AOJu0Yyli3Ffys9algqAch/QrJoA9KhXrMxuRDkxY1Muz29c4nlKfOB2
        4nSGkDEVVc2Rdqg8H83zp+7vO/DmdH4loZdpF7DE3A==
X-Google-Smtp-Source: AGHT+IEOrbAlfEXGbCpnPiqNJ+5Bw4w9KX9cczd2NR+wukuJGlmQ8px0UPC+t5mIgp5TMKASOnLn23zvmKYPO/xzclI=
X-Received: by 2002:a50:c092:0:b0:543:fb17:1a8 with SMTP id
 k18-20020a50c092000000b00543fb1701a8mr336717edf.3.1702397683342; Tue, 12 Dec
 2023 08:14:43 -0800 (PST)
MIME-Version: 1.0
References: <20231208220545.7452-1-frederic@kernel.org> <20231208220545.7452-5-frederic@kernel.org>
In-Reply-To: <20231208220545.7452-5-frederic@kernel.org>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Tue, 12 Dec 2023 11:14:31 -0500
Message-ID: <CAC_TJvfG_+iZP3O1mV1y9emMnZHgmfTq=mUAxPWc+fY=kx+=gg@mail.gmail.com>
Subject: Re: [PATCH 4/8] rcu/exp: Handle RCU expedited grace period kworker
 allocation failure
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria.behnsen@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
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

On Fri, Dec 8, 2023 at 5:06=E2=80=AFPM Frederic Weisbecker <frederic@kernel=
.org> wrote:
>
> Just like is done for the kworker performing nodes initialization,
> gracefully handle the possible allocation failure of the RCU expedited
> grace period main kworker.
>
> While at it perform a rename of the related checking functions to better
> reflect the expedited specifics.
>
> Fixes: 9621fbee44df ("rcu: Move expedited grace period (GP) work to RT kt=
hread_worker")
> Cc: Kalesh Singh <kaleshsingh@google.com>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Reviewed-by: Kalesh Singh <kaleshsingh@google.com>

Thanks,
Kalesh

> ---
>  kernel/rcu/tree.c     |  2 ++
>  kernel/rcu/tree_exp.h | 25 +++++++++++++++++++------
>  2 files changed, 21 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 055f4817bc70..39679cf66c3a 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -4717,6 +4717,7 @@ static void __init rcu_start_exp_gp_kworkers(void)
>         rcu_exp_gp_kworker =3D kthread_create_worker(0, gp_kworker_name);
>         if (IS_ERR_OR_NULL(rcu_exp_gp_kworker)) {
>                 pr_err("Failed to create %s!\n", gp_kworker_name);
> +               rcu_exp_gp_kworker =3D NULL;
>                 return;
>         }
>
> @@ -4725,6 +4726,7 @@ static void __init rcu_start_exp_gp_kworkers(void)
>                 pr_err("Failed to create %s!\n", par_gp_kworker_name);
>                 rcu_exp_par_gp_kworker =3D NULL;
>                 kthread_destroy_worker(rcu_exp_gp_kworker);
> +               rcu_exp_gp_kworker =3D NULL;
>                 return;
>         }
>
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index 6d7cea5d591f..cb31f4fb4b36 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -429,7 +429,12 @@ static void sync_rcu_exp_select_node_cpus(struct kth=
read_work *wp)
>         __sync_rcu_exp_select_node_cpus(rewp);
>  }
>
> -static inline bool rcu_gp_par_worker_started(void)
> +static inline bool rcu_exp_worker_started(void)
> +{
> +       return !!READ_ONCE(rcu_exp_gp_kworker);
> +}
> +
> +static inline bool rcu_exp_par_worker_started(void)
>  {
>         return !!READ_ONCE(rcu_exp_par_gp_kworker);
>  }
> @@ -479,7 +484,12 @@ static void sync_rcu_exp_select_node_cpus(struct wor=
k_struct *wp)
>         __sync_rcu_exp_select_node_cpus(rewp);
>  }
>
> -static inline bool rcu_gp_par_worker_started(void)
> +static inline bool rcu_exp_worker_started(void)
> +{
> +       return !!READ_ONCE(rcu_gp_wq);
> +}
> +
> +static inline bool rcu_exp_par_worker_started(void)
>  {
>         return !!READ_ONCE(rcu_par_gp_wq);
>  }
> @@ -542,7 +552,7 @@ static void sync_rcu_exp_select_cpus(void)
>                 rnp->exp_need_flush =3D false;
>                 if (!READ_ONCE(rnp->expmask))
>                         continue; /* Avoid early boot non-existent wq. */
> -               if (!rcu_gp_par_worker_started() ||
> +               if (!rcu_exp_par_worker_started() ||
>                     rcu_scheduler_active !=3D RCU_SCHEDULER_RUNNING ||
>                     rcu_is_last_leaf_node(rnp)) {
>                         /* No worker started yet or last leaf, do direct =
call. */
> @@ -957,7 +967,7 @@ static void rcu_exp_print_detail_task_stall_rnp(struc=
t rcu_node *rnp)
>   */
>  void synchronize_rcu_expedited(void)
>  {
> -       bool boottime =3D (rcu_scheduler_active =3D=3D RCU_SCHEDULER_INIT=
);
> +       bool can_queue;
>         unsigned long flags;
>         struct rcu_exp_work rew;
>         struct rcu_node *rnp;
> @@ -968,6 +978,9 @@ void synchronize_rcu_expedited(void)
>                          lock_is_held(&rcu_sched_lock_map),
>                          "Illegal synchronize_rcu_expedited() in RCU read=
-side critical section");
>
> +       can_queue =3D (rcu_scheduler_active !=3D RCU_SCHEDULER_INIT) &&
> +                   rcu_exp_worker_started();
> +
>         /* Is the state is such that the call is a grace period? */
>         if (rcu_blocking_is_gp()) {
>                 // Note well that this code runs with !PREEMPT && !SMP.
> @@ -997,7 +1010,7 @@ void synchronize_rcu_expedited(void)
>                 return;  /* Someone else did our work for us. */
>
>         /* Ensure that load happens before action based on it. */
> -       if (unlikely(boottime)) {
> +       if (unlikely(!can_queue)) {
>                 /* Direct call during scheduler init and early_initcalls(=
). */
>                 rcu_exp_sel_wait_wake(s);
>         } else {
> @@ -1015,7 +1028,7 @@ void synchronize_rcu_expedited(void)
>         /* Let the next expedited grace period start. */
>         mutex_unlock(&rcu_state.exp_mutex);
>
> -       if (likely(!boottime))
> +       if (likely(can_queue))
>                 synchronize_rcu_expedited_destroy_work(&rew);
>  }
>  EXPORT_SYMBOL_GPL(synchronize_rcu_expedited);
> --
> 2.42.1
>
