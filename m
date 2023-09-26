Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316517AF47E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 21:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235404AbjIZTya convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 26 Sep 2023 15:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235606AbjIZTy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 15:54:27 -0400
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE55C0;
        Tue, 26 Sep 2023 12:54:21 -0700 (PDT)
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-57be74614c0so317848eaf.1;
        Tue, 26 Sep 2023 12:54:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695758060; x=1696362860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=06BDXw+aAsRZJmkH29TBr2CENepoEaV3xhr3PlQFcqA=;
        b=j8pJ0Iv7DFKZqJoZR3C+GSAl68bWY35bLPTo0DqbNgMb5Ve1Kcftpbc0/2b6jYmOCK
         Af6lrMTsc7n6bzPzf4ksMAa3ZTBu0vPmhJKz8b5vkfxRAlqZALAmIXOtx4MX2lOt80vw
         KaHiMKw4zgtwquxC9egJRprTcQX+lro78xzJpKpU9Kzuj7HeGlgivKuFqxHD4/lXw7V+
         r9fuBSdYXdl/GFmwtYUtzOONxYfOyVh/76GWjiwx/Latr1BNWqFlUL49LPOXpYUTywmN
         jC0T+ZTOWW8nHV/aZRbg6UJPcgGMcEE6KGoBvu20NPjA8JktUIXvD79ON+phrxMw5PcU
         4ZWA==
X-Gm-Message-State: AOJu0Yxi7PtJsfiKhvB57bXiCZ7l5qF9E4NckRrEEegJvuU7Z4ethPuo
        cYCI7g0m18jHjOuPXBirn96OREeIIc4vWZVNheY=
X-Google-Smtp-Source: AGHT+IEz9FuVLAFKk1rCFfQcKhvYL1wc0uuG6qkYOGCi08eKz+4CbpYXS5/O4EdhAsoBPP/x0iUQZoh2GGF3VXNjSrQ=
X-Received: by 2002:a4a:e687:0:b0:57b:3b64:7ea5 with SMTP id
 u7-20020a4ae687000000b0057b3b647ea5mr80798oot.1.1695758060246; Tue, 26 Sep
 2023 12:54:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230925081139.1305766-1-lukasz.luba@arm.com> <20230925081139.1305766-13-lukasz.luba@arm.com>
In-Reply-To: <20230925081139.1305766-13-lukasz.luba@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 26 Sep 2023 21:54:09 +0200
Message-ID: <CAJZ5v0igw77JdpoSbOkbdWxw3pwX2ejr+sv077OuQJWLLD5GxA@mail.gmail.com>
Subject: Re: [PATCH v4 12/18] PM: EM: Use runtime modified EM for CPUs energy
 estimation in EAS
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org, dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
        qyousef@layalina.io, wvw@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 10:11 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> The new Energy Model (EM) supports runtime modification of the performance
> state table to better model the power used by the SoC. Use this new
> feature to improve energy estimation and therefore task placement in
> Energy Aware Scheduler (EAS).
>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  include/linux/energy_model.h | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> index 8f055ab356ed..41290ee2cdd0 100644
> --- a/include/linux/energy_model.h
> +++ b/include/linux/energy_model.h
> @@ -261,15 +261,14 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
>                                 unsigned long max_util, unsigned long sum_util,
>                                 unsigned long allowed_cpu_cap)
>  {
> +       struct em_perf_table *runtime_table;

You may as well call it just "table".  The "runtime_" prefix doesn't
add much value here IMO.

>         unsigned long freq, scale_cpu;
> -       struct em_perf_state *table, *ps;
> +       struct em_perf_state *ps;
>         int cpu, i;
>
>         if (!sum_util)
>                 return 0;
>
> -       table = pd->default_table->state;
> -
>         /*
>          * In order to predict the performance state, map the utilization of
>          * the most utilized CPU of the performance domain to a requested
> @@ -280,7 +279,14 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
>          */
>         cpu = cpumask_first(to_cpumask(pd->cpus));
>         scale_cpu = arch_scale_cpu_capacity(cpu);
> -       ps = &table[pd->nr_perf_states - 1];
> +
> +       /*
> +        * No rcu_read_lock() since it's already called by task scheduler.
> +        * The runtime_table is always there for CPUs, so we don't check.
> +        */
> +       runtime_table = rcu_dereference(pd->runtime_table);
> +
> +       ps = &runtime_table->state[pd->nr_perf_states - 1];
>
>         max_util = map_util_perf(max_util);
>         max_util = min(max_util, allowed_cpu_cap);
> @@ -290,9 +296,9 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
>          * Find the lowest performance state of the Energy Model above the
>          * requested frequency.
>          */
> -       i = em_pd_get_efficient_state(table, pd->nr_perf_states, freq,
> -                                     pd->flags);
> -       ps = &table[i];
> +       i = em_pd_get_efficient_state(runtime_table->state, pd->nr_perf_states,
> +                                     freq, pd->flags);
> +       ps = &runtime_table->state[i];
>
>         /*
>          * The capacity of a CPU in the domain at the performance state (ps)
> --
