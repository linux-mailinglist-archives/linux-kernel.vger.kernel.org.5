Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA537AF3E0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 21:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235670AbjIZTM1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 26 Sep 2023 15:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjIZTMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 15:12:24 -0400
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6319F;
        Tue, 26 Sep 2023 12:12:17 -0700 (PDT)
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-57b68555467so703413eaf.0;
        Tue, 26 Sep 2023 12:12:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695755536; x=1696360336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ykZfOZJ1ITttngrJpDx2p0tJ44eHQ73Nv8oUXM/To3g=;
        b=BRPCG7IFw9w4vLQSju0hFrTnyOZDV9PufSpGak14h2WfnTFEeq18/lxQUt1W9Tr9Oc
         344kfRq+ueZTUCU6Iw6fgHiN2ShOusJt0OhYqwGxaU3ltzVL8QVj0WU/lMkFCTjsZDlN
         EH4lEHc9DqBUKCSkFvA4g/0k0HpA5gZgUIHQPPwJrcKcsPyd9BAo8gZUqz8PqWZQ1ifw
         HXnRdrQupgfH8TQIdtSYDIfsHN6/ybVQI9WixOa2+pAl5I+WdLgWkUlQb/sYdhv84+kt
         jv4ivxYae0TViIbDyQ2LseEIoMV/22om4MESAaAxbP7nCfu8Ih/SZmcLQ2UTE5LyvkA9
         IGfg==
X-Gm-Message-State: AOJu0Yw+whEMYWoozhakTHGUro0huk+dyhlOjT7xFOZtqIqLY905Ce3X
        xdrGLxfZ1OyD0Zf0CntPcnc4MoNXQ/SXlPuNgKg=
X-Google-Smtp-Source: AGHT+IEiVQrYe3+rFvZCcJ9JKqjkMoNtf05g/ufF+32vzlk0CXa2Io7YcY0TdKewQDjAoTKgUXm9pT4JjZUHSpQcWkE=
X-Received: by 2002:a4a:e60c:0:b0:57b:73f6:6f80 with SMTP id
 f12-20020a4ae60c000000b0057b73f66f80mr43248oot.0.1695755536621; Tue, 26 Sep
 2023 12:12:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230925081139.1305766-1-lukasz.luba@arm.com> <20230925081139.1305766-10-lukasz.luba@arm.com>
In-Reply-To: <20230925081139.1305766-10-lukasz.luba@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 26 Sep 2023 21:12:05 +0200
Message-ID: <CAJZ5v0gxjJRoZpGjs4qWy_CQbwnztgrQxHJpffdFHeEL7ikbYQ@mail.gmail.com>
Subject: Re: [PATCH v4 09/18] PM: EM: Introduce runtime modifiable table
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
> The new runtime table would be populated with a new power data to better
> reflect the actual power. The power can vary over time e.g. due to the
> SoC temperature change. Higher temperature can increase power values.
> For longer running scenarios, such as game or camera, when also other
> devices are used (e.g. GPU, ISP) the CPU power can change. The new
> EM framework is able to addresses this issue and change the data
> at runtime safely.
>
> The runtime modifiable EM data is used by the Energy Aware Scheduler (EAS)
> for the task placement. All the other users (thermal, etc.) are still
> using the default (basic) EM. This fact drove the design of this feature.
>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  include/linux/energy_model.h |  4 +++-
>  kernel/power/energy_model.c  | 12 +++++++++++-
>  2 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> index 546dee90f716..740e7c25cfff 100644
> --- a/include/linux/energy_model.h
> +++ b/include/linux/energy_model.h
> @@ -39,7 +39,7 @@ struct em_perf_state {
>  /**
>   * struct em_perf_table - Performance states table
>   * @state:     List of performance states, in ascending order
> - * @rcu:       RCU used for safe access and destruction
> + * @rcu:       RCU used only for runtime modifiable table

This still doesn't appear to be used anywhere, so why change it here?

>   */
>  struct em_perf_table {
>         struct em_perf_state *state;
> @@ -49,6 +49,7 @@ struct em_perf_table {
>  /**
>   * struct em_perf_domain - Performance domain
>   * @default_table:     Pointer to the default em_perf_table
> + * @runtime_table:     Pointer to the runtime modifiable em_perf_table

"Pointer to em_perf_table that can be dynamically updated"

>   * @nr_perf_states:    Number of performance states
>   * @flags:             See "em_perf_domain flags"
>   * @cpus:              Cpumask covering the CPUs of the domain. It's here
> @@ -64,6 +65,7 @@ struct em_perf_table {
>   */
>  struct em_perf_domain {
>         struct em_perf_table *default_table;
> +       struct em_perf_table __rcu *runtime_table;
>         int nr_perf_states;
>         unsigned long flags;
>         unsigned long cpus[];
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index 797141638b29..5b40db38b745 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -251,6 +251,9 @@ static int em_create_pd(struct device *dev, int nr_states,
>                 return ret;
>         }
>
> +       /* Initialize runtime table as default table. */

Redundant comment.

> +       rcu_assign_pointer(pd->runtime_table, default_table);
> +
>         if (_is_cpu_device(dev))
>                 for_each_cpu(cpu, cpus) {
>                         cpu_dev = get_cpu_device(cpu);
> @@ -448,6 +451,7 @@ EXPORT_SYMBOL_GPL(em_dev_register_perf_domain);
>   */
>  void em_dev_unregister_perf_domain(struct device *dev)
>  {
> +       struct em_perf_table __rcu *runtime_table;
>         struct em_perf_domain *pd;
>
>         if (IS_ERR_OR_NULL(dev) || !dev->em_pd)
> @@ -457,18 +461,24 @@ void em_dev_unregister_perf_domain(struct device *dev)
>                 return;
>
>         pd = dev->em_pd;
> -

Unrelated change.

>         /*
>          * The mutex separates all register/unregister requests and protects
>          * from potential clean-up/setup issues in the debugfs directories.
>          * The debugfs directory name is the same as device's name.
>          */
>         mutex_lock(&em_pd_mutex);
> +

Same here.

>         em_debug_remove_pd(dev);
>
> +       runtime_table = pd->runtime_table;
> +
> +       rcu_assign_pointer(pd->runtime_table, NULL);
> +       synchronize_rcu();

Is it really a good idea to call this under a mutex?

> +
>         kfree(pd->default_table->state);
>         kfree(pd->default_table);
>         kfree(dev->em_pd);
> +

Unrelated change.

>         dev->em_pd = NULL;
>         mutex_unlock(&em_pd_mutex);
>  }
> --

So this really adds a pointer to a table that can be dynamically
updated to struct em_perf_domain without any users so far.  It is not
used anywhere as of this patch AFAICS, which is not what the changelog
is saying.
