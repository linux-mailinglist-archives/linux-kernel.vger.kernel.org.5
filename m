Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7CC778E6E3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 08:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244168AbjHaG6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 02:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjHaG63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 02:58:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7061A6;
        Wed, 30 Aug 2023 23:58:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55B6563191;
        Thu, 31 Aug 2023 06:58:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B948FC433CA;
        Thu, 31 Aug 2023 06:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693465104;
        bh=S8R6bJPNyfFXxUtXYbmYZzec2iv1T2UhOHlXqJod+VI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FSqkEaBWycoouCAemdr021z1UnbqQparN+NfMa7wbM64ZeqTIAFoypGfOILESSOMy
         xA8JbCFf2gyMAmOK+zWbDrUS1M3OpUpCbpCVLr8AqWWUiVxn3C/JYKQwixX79v+mW4
         Mf2E0ifZZshSqPPG87kYrm3fbpn9i8VujwQr2eE8gbLIbaMl5QgzNFZP3dt/vyUhop
         DfcUEHe7kEH7+6dMvKRZTtdjuwcGwwei0Tre1ifwt7Y3lhOtoDZJY3NcDu7jVj1vwK
         EUz76Jq1n4aCORQpq+cTUMj+x4j26rAGIzpwY1gd16EadczgQftQtODF6AD8qJRJGy
         tj+qS5PAlKjug==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5007abb15e9so1043389e87.0;
        Wed, 30 Aug 2023 23:58:24 -0700 (PDT)
X-Gm-Message-State: AOJu0YwbDRo/vtIJKblDnkz6uGk33K94ENbQABNJroYJ/62A48vygLnx
        P6Flrlj1Ivs+XoGAM7GUHJZB171n0wx20ldqXH8=
X-Google-Smtp-Source: AGHT+IHI2CO+Pc3L3hrQuyNEP22KByNiGLUelqPdgmCSoLgQ1/DYXouWimP/EBKFIg1ZC2BVgg64OoUSKMgspS74DxY=
X-Received: by 2002:a05:6512:3714:b0:4f8:7513:8cb0 with SMTP id
 z20-20020a056512371400b004f875138cb0mr2554811lfr.2.1693465102544; Wed, 30 Aug
 2023 23:58:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230831063129.335425-1-leobras@redhat.com>
In-Reply-To: <20230831063129.335425-1-leobras@redhat.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 31 Aug 2023 14:58:08 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSo5opLeRrOevU_g5C9iJZO1O4=+F7vsrwbBrY_KqaYQA@mail.gmail.com>
Message-ID: <CAJF2gTSo5opLeRrOevU_g5C9iJZO1O4=+F7vsrwbBrY_KqaYQA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] smp: Change function signatures to use call_single_data_t
To:     Leonardo Bras <leobras@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Yury Norov <yury.norov@gmail.com>,
        Imran Khan <imran.f.khan@oracle.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 2:31=E2=80=AFPM Leonardo Bras <leobras@redhat.com> =
wrote:
>
> call_single_data_t is a size-aligned typedef of struct __call_single_data=
.
>
> This alignment is desirable in order to have smp_call_function*() avoid
> bouncing an extra cacheline in case of an unaligned csd, given this
> would hurt performance.
>
> Since the removal of struct request->csd in commit 660e802c76c8
> ("blk-mq: use percpu csd to remote complete instead of per-rq csd") there
> are no current users of smp_call_function*() with unaligned csd.
>
> Change every 'struct __call_single_data' function parameter to
> 'call_single_data_t', so we have warnings if any new code tries to
> introduce an smp_call_function*() call with unaligned csd.
I agree to prevent __call_single_data usage.

Reviewed-by: Guo Ren <guoren@kernel.org>

/*
 * structure shares (partial) layout with struct irq_work
 */
struct __call_single_data {
        struct __call_single_node node;
        smp_call_func_t func;
        void *info;
};

#define CSD_INIT(_func, _info) \
        (struct __call_single_data){ .func =3D (_func), .info =3D (_info), =
}

/* Use __aligned() to avoid to use 2 cache lines for 1 csd */
typedef struct __call_single_data call_single_data_t
        __aligned(sizeof(struct __call_single_data));

>
> Signed-off-by: Leonardo Bras <leobras@redhat.com>
> ---
>  include/linux/smp.h        |  2 +-
>  include/trace/events/csd.h |  8 ++++----
>  kernel/smp.c               | 26 +++++++++++++-------------
>  kernel/up.c                |  2 +-
>  4 files changed, 19 insertions(+), 19 deletions(-)
>
> diff --git a/include/linux/smp.h b/include/linux/smp.h
> index 91ea4a67f8ca..e87520dc2959 100644
> --- a/include/linux/smp.h
> +++ b/include/linux/smp.h
> @@ -53,7 +53,7 @@ int smp_call_function_single(int cpuid, smp_call_func_t=
 func, void *info,
>  void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t fu=
nc,
>                            void *info, bool wait, const struct cpumask *m=
ask);
>
> -int smp_call_function_single_async(int cpu, struct __call_single_data *c=
sd);
> +int smp_call_function_single_async(int cpu, call_single_data_t *csd);
>
>  /*
>   * Cpus stopping functions in panic. All have default weak definitions.
> diff --git a/include/trace/events/csd.h b/include/trace/events/csd.h
> index 67e9d01f80c2..58cc83b99c34 100644
> --- a/include/trace/events/csd.h
> +++ b/include/trace/events/csd.h
> @@ -12,7 +12,7 @@ TRACE_EVENT(csd_queue_cpu,
>         TP_PROTO(const unsigned int cpu,
>                 unsigned long callsite,
>                 smp_call_func_t func,
> -               struct __call_single_data *csd),
> +               call_single_data_t *csd),
>
>         TP_ARGS(cpu, callsite, func, csd),
>
> @@ -39,7 +39,7 @@ TRACE_EVENT(csd_queue_cpu,
>   */
>  DECLARE_EVENT_CLASS(csd_function,
>
> -       TP_PROTO(smp_call_func_t func, struct __call_single_data *csd),
> +       TP_PROTO(smp_call_func_t func, call_single_data_t *csd),
>
>         TP_ARGS(func, csd),
>
> @@ -57,12 +57,12 @@ DECLARE_EVENT_CLASS(csd_function,
>  );
>
>  DEFINE_EVENT(csd_function, csd_function_entry,
> -       TP_PROTO(smp_call_func_t func, struct __call_single_data *csd),
> +       TP_PROTO(smp_call_func_t func, call_single_data_t *csd),
>         TP_ARGS(func, csd)
>  );
>
>  DEFINE_EVENT(csd_function, csd_function_exit,
> -       TP_PROTO(smp_call_func_t func, struct __call_single_data *csd),
> +       TP_PROTO(smp_call_func_t func, call_single_data_t *csd),
>         TP_ARGS(func, csd)
>  );
>
> diff --git a/kernel/smp.c b/kernel/smp.c
> index 8455a53465af..8c714583786b 100644
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -127,7 +127,7 @@ send_call_function_ipi_mask(struct cpumask *mask)
>  }
>
>  static __always_inline void
> -csd_do_func(smp_call_func_t func, void *info, struct __call_single_data =
*csd)
> +csd_do_func(smp_call_func_t func, void *info, call_single_data_t *csd)
>  {
>         trace_csd_function_entry(func, csd);
>         func(info);
> @@ -174,7 +174,7 @@ module_param(csd_lock_timeout, ulong, 0444);
>  static atomic_t csd_bug_count =3D ATOMIC_INIT(0);
>
>  /* Record current CSD work for current CPU, NULL to erase. */
> -static void __csd_lock_record(struct __call_single_data *csd)
> +static void __csd_lock_record(call_single_data_t *csd)
>  {
>         if (!csd) {
>                 smp_mb(); /* NULL cur_csd after unlock. */
> @@ -189,13 +189,13 @@ static void __csd_lock_record(struct __call_single_=
data *csd)
>                   /* Or before unlock, as the case may be. */
>  }
>
> -static __always_inline void csd_lock_record(struct __call_single_data *c=
sd)
> +static __always_inline void csd_lock_record(call_single_data_t *csd)
>  {
>         if (static_branch_unlikely(&csdlock_debug_enabled))
>                 __csd_lock_record(csd);
>  }
>
> -static int csd_lock_wait_getcpu(struct __call_single_data *csd)
> +static int csd_lock_wait_getcpu(call_single_data_t *csd)
>  {
>         unsigned int csd_type;
>
> @@ -210,7 +210,7 @@ static int csd_lock_wait_getcpu(struct __call_single_=
data *csd)
>   * the CSD_TYPE_SYNC/ASYNC types provide the destination CPU,
>   * so waiting on other types gets much less information.
>   */
> -static bool csd_lock_wait_toolong(struct __call_single_data *csd, u64 ts=
0, u64 *ts1, int *bug_id)
> +static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 =
*ts1, int *bug_id)
>  {
>         int cpu =3D -1;
>         int cpux;
> @@ -276,7 +276,7 @@ static bool csd_lock_wait_toolong(struct __call_singl=
e_data *csd, u64 ts0, u64 *
>   * previous function call. For multi-cpu calls its even more interesting
>   * as we'll have to ensure no other cpu is observing our csd.
>   */
> -static void __csd_lock_wait(struct __call_single_data *csd)
> +static void __csd_lock_wait(call_single_data_t *csd)
>  {
>         int bug_id =3D 0;
>         u64 ts0, ts1;
> @@ -290,7 +290,7 @@ static void __csd_lock_wait(struct __call_single_data=
 *csd)
>         smp_acquire__after_ctrl_dep();
>  }
>
> -static __always_inline void csd_lock_wait(struct __call_single_data *csd=
)
> +static __always_inline void csd_lock_wait(call_single_data_t *csd)
>  {
>         if (static_branch_unlikely(&csdlock_debug_enabled)) {
>                 __csd_lock_wait(csd);
> @@ -300,17 +300,17 @@ static __always_inline void csd_lock_wait(struct __=
call_single_data *csd)
>         smp_cond_load_acquire(&csd->node.u_flags, !(VAL & CSD_FLAG_LOCK))=
;
>  }
>  #else
> -static void csd_lock_record(struct __call_single_data *csd)
> +static void csd_lock_record(call_single_data_t *csd)
>  {
>  }
>
> -static __always_inline void csd_lock_wait(struct __call_single_data *csd=
)
> +static __always_inline void csd_lock_wait(call_single_data_t *csd)
>  {
>         smp_cond_load_acquire(&csd->node.u_flags, !(VAL & CSD_FLAG_LOCK))=
;
>  }
>  #endif
>
> -static __always_inline void csd_lock(struct __call_single_data *csd)
> +static __always_inline void csd_lock(call_single_data_t *csd)
>  {
>         csd_lock_wait(csd);
>         csd->node.u_flags |=3D CSD_FLAG_LOCK;
> @@ -323,7 +323,7 @@ static __always_inline void csd_lock(struct __call_si=
ngle_data *csd)
>         smp_wmb();
>  }
>
> -static __always_inline void csd_unlock(struct __call_single_data *csd)
> +static __always_inline void csd_unlock(call_single_data_t *csd)
>  {
>         WARN_ON(!(csd->node.u_flags & CSD_FLAG_LOCK));
>
> @@ -376,7 +376,7 @@ void __smp_call_single_queue(int cpu, struct llist_no=
de *node)
>   * for execution on the given CPU. data must already have
>   * ->func, ->info, and ->flags set.
>   */
> -static int generic_exec_single(int cpu, struct __call_single_data *csd)
> +static int generic_exec_single(int cpu, call_single_data_t *csd)
>  {
>         if (cpu =3D=3D smp_processor_id()) {
>                 smp_call_func_t func =3D csd->func;
> @@ -667,7 +667,7 @@ EXPORT_SYMBOL(smp_call_function_single);
>   *
>   * Return: %0 on success or negative errno value on error
>   */
> -int smp_call_function_single_async(int cpu, struct __call_single_data *c=
sd)
> +int smp_call_function_single_async(int cpu, call_single_data_t *csd)
>  {
>         int err =3D 0;
>
> diff --git a/kernel/up.c b/kernel/up.c
> index a38b8b095251..df50828cc2f0 100644
> --- a/kernel/up.c
> +++ b/kernel/up.c
> @@ -25,7 +25,7 @@ int smp_call_function_single(int cpu, void (*func) (voi=
d *info), void *info,
>  }
>  EXPORT_SYMBOL(smp_call_function_single);
>
> -int smp_call_function_single_async(int cpu, struct __call_single_data *c=
sd)
> +int smp_call_function_single_async(int cpu, call_single_data_t *csd)
>  {
>         unsigned long flags;
>
> --
> 2.42.0
>


--=20
Best Regards
 Guo Ren
