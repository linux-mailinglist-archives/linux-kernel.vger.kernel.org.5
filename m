Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB08E7D5FF6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 04:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbjJYCaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 22:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjJYCaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 22:30:00 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB169C;
        Tue, 24 Oct 2023 19:29:58 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-5b8f68ba4e5so789760a12.1;
        Tue, 24 Oct 2023 19:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698200998; x=1698805798; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UBs7BhHj7osv0k6psRfJTocN6ObSQb2o0iZG5n+6D9E=;
        b=CPfyJ9S/JKi9ygb+bH1zPZa4AqNQ+W8Aqs6GqccQvsjIZ4rO1peFaOGFlXwGA3fS7l
         1EHQOFdZo5Gfv36SHVCf4aczT/qRqfWtcl5Yid8hB2f327rU2/p3SQXYju8XpVICTiGb
         KbFoHSQAcsgYPGzleAFhBSifGrLrTmZOeHPiYff+7Whq60FryI++qnUR1pWpqe2dNEVf
         XPXcR29K+il6KqrPMUyEuAyqrqsF5OGsiJFHE/J3X6eI0ND/+DDYwbbVFwwzraIgVxNS
         HQifI4FyxyQjsymyM2pp17oqpfLlNg0muBiEKTPBTAYBhr8zPrWyvaXBf6BayjXfjvOo
         SBiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698200998; x=1698805798;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UBs7BhHj7osv0k6psRfJTocN6ObSQb2o0iZG5n+6D9E=;
        b=Kq5FPnzy3TAi+FC6jiDnyKZVqXGy3xto5Sp0ruMkZewQJ6O1nC72RmaWayOsTqmAo9
         e7TEet08KbpSJ44x4wmIJCbyJoRbAKi+5ogjxerk1eujk3S5QaLFT/SlAV3qlnOidKS3
         7XjK+u+ua6930Ai/b3GRU40I2QyztmCjxfNMcJi5pKW1FWQ7AC7CwWIxd5GXWAza9OwE
         YCeLdYpelCX0hmEBqI4V4IdHqnOJZrsdNzUycAwI3umw+gXbcGRcjYg1h7MOrOlQwX6F
         xe7M+NGazEobkerRwKmxgC3yjfAR3moqwfw8EK81o++xkE3c/DBm904C+Au518cWWeaC
         UtXw==
X-Gm-Message-State: AOJu0YzZQ2g5UphUBoSYT6RaZpef5jttsPOZNRjOWwVqyb1xdyC6FXHk
        3ApS9ez2zjOV61URmHEjK0H8ymS8VLz0ub3xrbM=
X-Google-Smtp-Source: AGHT+IHNAVwtfMn/MXAQZV4LGATKDVSqX0E8w/yecWgJbGg3prk+XMIh/QjpOshbqJrTlw3AA2EY4YZz6I89PBQ1Jig=
X-Received: by 2002:a17:90b:3949:b0:27c:ef18:d270 with SMTP id
 oe9-20020a17090b394900b0027cef18d270mr10698424pjb.20.1698200997712; Tue, 24
 Oct 2023 19:29:57 -0700 (PDT)
MIME-Version: 1.0
References: <20231024214625.6483-1-frederic@kernel.org> <20231024214625.6483-2-frederic@kernel.org>
In-Reply-To: <20231024214625.6483-2-frederic@kernel.org>
From:   Z qiang <qiang.zhang1211@gmail.com>
Date:   Wed, 25 Oct 2023 10:29:46 +0800
Message-ID: <CALm+0cVP+4ogirqUYMXp63vb7yisXCB0xpq+DSX9kqth0BpW6g@mail.gmail.com>
Subject: Re: [PATCH 1/4] rcu: Introduce rcu_cpu_online()
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Export the RCU point of view as to when a CPU is considered offline
> (ie: when does RCU consider that a CPU is sufficiently down in the
> hotplug process to not feature any possible read side).
>
> This will be used by RCU-tasks whose vision of an offline CPU should
> reasonably match the one of RCU core.
>
> Fixes: cff9b2332ab7 ("kernel/sched: Modify initial boot task idle setup")
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  kernel/rcu/rcu.h  | 2 ++
>  kernel/rcu/tree.c | 7 +++++++
>  2 files changed, 9 insertions(+)
>
> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> index 0d866eaa4cc8..b531c33e9545 100644
> --- a/kernel/rcu/rcu.h
> +++ b/kernel/rcu/rcu.h
> @@ -500,6 +500,7 @@ static inline void rcu_expedite_gp(void) { }
>  static inline void rcu_unexpedite_gp(void) { }
>  static inline void rcu_async_hurry(void) { }
>  static inline void rcu_async_relax(void) { }
> +static inline bool rcu_cpu_online(int cpu) { return true; }
>  #else /* #ifdef CONFIG_TINY_RCU */
>  bool rcu_gp_is_normal(void);     /* Internal RCU use. */
>  bool rcu_gp_is_expedited(void);  /* Internal RCU use. */
> @@ -509,6 +510,7 @@ void rcu_unexpedite_gp(void);
>  void rcu_async_hurry(void);
>  void rcu_async_relax(void);
>  void rcupdate_announce_bootup_oddness(void);
> +bool rcu_cpu_online(int cpu);
>  #ifdef CONFIG_TASKS_RCU_GENERIC
>  void show_rcu_tasks_gp_kthreads(void);
>  #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 700524726079..fd21c1506092 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -4202,6 +4202,13 @@ static bool rcu_rdp_cpu_online(struct rcu_data *rdp)
>         return !!(rdp->grpmask & rcu_rnp_online_cpus(rdp->mynode));
>  }
>
> +bool rcu_cpu_online(int cpu)
> +{
> +       struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
>
>

Should 'struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu)' be used ?

Thanks
Zqiang


>
> +
> +       return rcu_rdp_cpu_online(rdp);
> +}
> +
>  #if defined(CONFIG_PROVE_RCU) && defined(CONFIG_HOTPLUG_CPU)
>
>  /*
> --
> 2.41.0
>
