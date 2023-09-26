Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02537AF41B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 21:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235738AbjIZT0h convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 26 Sep 2023 15:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235724AbjIZT0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 15:26:35 -0400
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852D311F;
        Tue, 26 Sep 2023 12:26:28 -0700 (PDT)
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-57de3096e25so80284eaf.1;
        Tue, 26 Sep 2023 12:26:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695756388; x=1696361188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i4Jq5nSjfc/CI/cvpv3MrTFI/arZy6OI2bEoo1gBoe8=;
        b=RlYAYGu/E9PyNPADMtSwGFmWq+LKF/HxldbK2O/laa9pRGe+J4JJUUYnTzMwcJu3gw
         nZWVQMzmn2VvdugEmk+Ca+qo0mnpWGTE70XithwyqP5MZyF5NmquuJnJ7gpHCXDKq9FR
         Plda6hOE/stq1GknyWWPb+eZ8RSwdotsSyfG72FYSZF37K8UZ6CxOwp59qPWG6H8AjtE
         j1PxwNA5L9S8aULmitly7TYhjFu9HaM0YDtREPfU73vty+zD5ix0vfnEYlXG7wUuF5iU
         FxgMYVclLuojFMu0hh9sVOQv7KuD5H8J5grJEuliXVBjwCLidM9F8lQOUPQfmnqipQ/t
         mktQ==
X-Gm-Message-State: AOJu0Yz29bvPRk5YpBcl7K0095i0gMBwBGKb5zeTulhBvqHC6LbgNL+J
        3pb2x2d09czQQvbGp5PM95htCipJg5Z4zichlJg=
X-Google-Smtp-Source: AGHT+IF41kAFJEUJpDEBURDcOZ7UFLM5SsrQuwAwYxGOOHom20VI62UJHURJ66mby2R6X10BAwSQTInLefgYj9Iri9o=
X-Received: by 2002:a4a:e704:0:b0:57b:94b7:c6ba with SMTP id
 y4-20020a4ae704000000b0057b94b7c6bamr78238oou.0.1695756387728; Tue, 26 Sep
 2023 12:26:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230925081139.1305766-1-lukasz.luba@arm.com> <20230925081139.1305766-11-lukasz.luba@arm.com>
In-Reply-To: <20230925081139.1305766-11-lukasz.luba@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 26 Sep 2023 21:26:16 +0200
Message-ID: <CAJZ5v0g6jPr3LqTuRfwUWsK4em7F1pfsZDn9pVziyu3tV56m8A@mail.gmail.com>
Subject: Re: [PATCH v4 10/18] PM: EM: Add RCU mechanism which safely cleans
 the old data
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 10:11 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> The EM is going to support runtime modifications of the power data.
> Introduce RCU safe mechanism to clean up the old allocated EM data.

"RCU-based" probably and "to clean up the old EM data safely".

> It also adds a mutex for the EM structure to serialize the modifiers.

This part doesn't match the code changes in the patch.

> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  kernel/power/energy_model.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index 5b40db38b745..2345837bfd2c 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -23,6 +23,9 @@
>   */
>  static DEFINE_MUTEX(em_pd_mutex);
>
> +static void em_cpufreq_update_efficiencies(struct device *dev,
> +                                          struct em_perf_state *table);
> +
>  static bool _is_cpu_device(struct device *dev)
>  {
>         return (dev->bus == &cpu_subsys);
> @@ -104,6 +107,32 @@ static void em_debug_create_pd(struct device *dev) {}
>  static void em_debug_remove_pd(struct device *dev) {}
>  #endif
>
> +static void em_destroy_rt_table_rcu(struct rcu_head *rp)

Adding static functions without callers will obviously cause the
compiler to complain, which is one of the reasons to avoid doing that.
The other is that it is hard to say how these functions are going to
be used without reviewing multiple patches simultaneously, which is a
pain as far as I'm concerned.

> +{
> +       struct em_perf_table *runtime_table;
> +
> +       runtime_table = container_of(rp, struct em_perf_table, rcu);
> +       kfree(runtime_table->state);
> +       kfree(runtime_table);

If runtime_table and its state were allocated in one go, it would be
possible to free them in one go either.

For some reason, you don't seem to want to do that, but why?

> +}
> +
> +static void em_perf_runtime_table_set(struct device *dev,
> +                                     struct em_perf_table *runtime_table)
> +{
> +       struct em_perf_domain *pd = dev->em_pd;
> +       struct em_perf_table *tmp;
> +
> +       tmp = pd->runtime_table;
> +
> +       rcu_assign_pointer(pd->runtime_table, runtime_table);
> +
> +       em_cpufreq_update_efficiencies(dev, runtime_table->state);
> +
> +       /* Don't free default table since it's used by other frameworks. */

Apparently, some frameworks are only going to use the default table
while the runtime-updatable table will be used somewhere else at the
same time.

I'm not really sure if this is a good idea.

> +       if (tmp != pd->default_table)
> +               call_rcu(&tmp->rcu, em_destroy_rt_table_rcu);
> +}
> +
>  static int em_compute_costs(struct device *dev, struct em_perf_state *table,
>                             struct em_data_callback *cb, int nr_states,
>                             unsigned long flags)
> --
