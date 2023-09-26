Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24BD7AF463
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 21:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233922AbjIZTsk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 26 Sep 2023 15:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjIZTsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 15:48:39 -0400
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B82592;
        Tue, 26 Sep 2023 12:48:32 -0700 (PDT)
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-57b83ff7654so244077eaf.1;
        Tue, 26 Sep 2023 12:48:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695757712; x=1696362512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QhlNiAk3BDM82ZwDVqCvko/vR/btlls97+/dsCckRpU=;
        b=AuKTbpHzE4W2GqtsrPYmQjR9wFBU2bkwG4QGoIaA+W1yojuCoDq89FkMDHxQH14KZk
         Tj0zUbI43u7V3BVox8IZmjCcYHLATtOj/vwNkMjtTI+wuRH9fao99XWS28ZKqxFwyASC
         Q+CwH+Z5wq3eVXmr7qQ3gDYCSMFN5fEawLG9Ab+sSoHt1GePYS7oMRdTeE+mlb82d8Tc
         76YXtLxFqt69B8eQQgHQjI49g4+kb3YdRckxgO4gmV3NsaYZSeu6fGZwwv5xTXvFrl7Q
         byASb1co6EamSl9tQxsG98gcuHUqcxZk8OovP3bIPvw51GGUI+20zw0sQGY/3FJH2WOT
         5KFQ==
X-Gm-Message-State: AOJu0YyQbPo4VZZL0iReyFd+H9/O9bd2alrq0wL2ZP5421dr8QQaIpRA
        kwXojdwc+/O25xI4j+4Tg6+h05k2nuvvbma5ZBE=
X-Google-Smtp-Source: AGHT+IFV9/V/WuwC1oXtLytZIEVRRQGEnamOe+oHwg1Ntj9qproRlPbDWXYvLRMVlfvG1TNOT+wxiqsiZYFR76RYCyE=
X-Received: by 2002:a4a:a504:0:b0:57c:6e35:251e with SMTP id
 v4-20020a4aa504000000b0057c6e35251emr69511ook.1.1695757711630; Tue, 26 Sep
 2023 12:48:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230925081139.1305766-1-lukasz.luba@arm.com> <20230925081139.1305766-12-lukasz.luba@arm.com>
In-Reply-To: <20230925081139.1305766-12-lukasz.luba@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 26 Sep 2023 21:48:20 +0200
Message-ID: <CAJZ5v0iebSOT--AiP-9-CYwqtTe7+kRddryJ3DdvFb3WUeji7w@mail.gmail.com>
Subject: Re: [PATCH v4 11/18] PM: EM: Add runtime update interface to modify
 EM power
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

First off, I would merge this with the previous patch, as the changes
would be much clearer then IMO.

> Add an interface which allows to modify EM power data at runtime.
> The new power information is populated by the provided callback, which
> is called for each performance state.

But it all starts with copying the frequencies from the default table.

> The CPU frequencies' efficiency is
> re-calculated since that might be affected as well. The old EM memory
> is going to be freed later using RCU mechanism.

Not all of it, but the old runtime table that is not going to be used any more.

> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  include/linux/energy_model.h |   8 +++
>  kernel/power/energy_model.c  | 111 +++++++++++++++++++++++++++++++++++
>  2 files changed, 119 insertions(+)
>
> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> index 740e7c25cfff..8f055ab356ed 100644
> --- a/include/linux/energy_model.h
> +++ b/include/linux/energy_model.h
> @@ -201,6 +201,8 @@ struct em_data_callback {
>
>  struct em_perf_domain *em_cpu_get(int cpu);
>  struct em_perf_domain *em_pd_get(struct device *dev);
> +int em_dev_update_perf_domain(struct device *dev, struct em_data_callback *cb,
> +                             void *priv);
>  int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
>                                 struct em_data_callback *cb, cpumask_t *span,
>                                 bool microwatts);
> @@ -384,6 +386,12 @@ static inline int em_pd_nr_perf_states(struct em_perf_domain *pd)
>  {
>         return 0;
>  }
> +static inline
> +int em_dev_update_perf_domain(struct device *dev, struct em_data_callback *cb,
> +                             void *priv)
> +{
> +       return -EINVAL;
> +}
>  #endif
>
>  #endif
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index 2345837bfd2c..78e1495dc87e 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -172,6 +172,101 @@ static int em_compute_costs(struct device *dev, struct em_perf_state *table,
>         return 0;
>  }
>
> +/**
> + * em_dev_update_perf_domain() - Update runtime EM table for a device
> + * @dev                : Device for which the EM is to be updated
> + * @cb         : Callback function providing the power data for the EM
> + * @priv       : Pointer to private data useful for passing context
> + *             which might be required while calling @cb

It is still unclear to me who is going to use this priv pointer and how.

> + *
> + * Update EM runtime modifiable table for a @dev using the callback
> + * defined in @cb. The EM new power values are then used for calculating
> + * the em_perf_state::cost for associated performance state.

It actually allocates a new runtime table and populates it from
scratch, using the frequencies from the default table and the
callback.

> + *
> + * This function uses mutex to serialize writers, so it must not be called

"a mutex"

> + * from non-sleeping context.
> + *
> + * Return 0 on success or a proper error in case of failure.
> + */
> +int em_dev_update_perf_domain(struct device *dev, struct em_data_callback *cb,
> +                             void *priv)
> +{
> +       struct em_perf_table *runtime_table;
> +       unsigned long power, freq;
> +       struct em_perf_domain *pd;
> +       int ret, i;
> +
> +       if (!cb || !cb->update_power)
> +               return -EINVAL;
> +
> +       /*
> +        * The lock serializes update and unregister code paths. When the
> +        * EM has been unregistered in the meantime, we should capture that
> +        * when entering this critical section. It also makes sure that
> +        * two concurrent updates will be serialized.
> +        */
> +       mutex_lock(&em_pd_mutex);
> +
> +       if (!dev || !dev->em_pd) {

Checking dev against NULL under the mutex is pointless (either it is
NULL or it isn't, so check it earlier).

> +               ret = -EINVAL;
> +               goto unlock_em;
> +       }
> +
> +       pd = dev->em_pd;

And I would check pd against NULL here.

> +
> +       runtime_table = kzalloc(sizeof(*runtime_table), GFP_KERNEL);
> +       if (!runtime_table) {
> +               ret = -ENOMEM;
> +               goto unlock_em;
> +       }
> +
> +       runtime_table->state = kcalloc(pd->nr_perf_states,
> +                                      sizeof(struct em_perf_state),
> +                                      GFP_KERNEL);
> +       if (!runtime_table->state) {
> +               ret = -ENOMEM;
> +               goto free_runtime_table;
> +       }

The above allocations can be merged into one and allocating memory
under the mutex is questionable.

> +
> +       /* Populate runtime table with updated values using driver callback */
> +       for (i = 0; i < pd->nr_perf_states; i++) {
> +               freq = pd->default_table->state[i].frequency;
> +               runtime_table->state[i].frequency = freq;
> +
> +               /*
> +                * Call driver callback to get a new power value for
> +                * a given frequency.
> +                */
> +               ret = cb->update_power(dev, freq, &power, priv);
> +               if (ret) {
> +                       dev_dbg(dev, "EM: runtime update error: %d\n", ret);
> +                       goto free_runtime_state_table;
> +               }
> +
> +               runtime_table->state[i].power = power;
> +       }
> +
> +       ret = em_compute_costs(dev, runtime_table->state, cb,
> +                              pd->nr_perf_states, pd->flags);
> +       if (ret)
> +               goto free_runtime_state_table;
> +
> +       em_perf_runtime_table_set(dev, runtime_table);
> +
> +       mutex_unlock(&em_pd_mutex);
> +       return 0;
> +
> +free_runtime_state_table:
> +       kfree(runtime_table->state);
> +free_runtime_table:
> +       kfree(runtime_table);
> +unlock_em:
> +       mutex_unlock(&em_pd_mutex);
> +
> +       return -EINVAL;
> +}
> +EXPORT_SYMBOL_GPL(em_dev_update_perf_domain);
> +
>  static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
>                                 int nr_states, struct em_data_callback *cb,
>                                 unsigned long flags)
> @@ -494,6 +589,8 @@ void em_dev_unregister_perf_domain(struct device *dev)
>          * The mutex separates all register/unregister requests and protects
>          * from potential clean-up/setup issues in the debugfs directories.
>          * The debugfs directory name is the same as device's name.
> +        * The lock also protects the updater of the runtime modifiable
> +        * EM and this remover.
>          */
>         mutex_lock(&em_pd_mutex);
>
> @@ -501,9 +598,23 @@ void em_dev_unregister_perf_domain(struct device *dev)
>
>         runtime_table = pd->runtime_table;
>
> +       /*
> +        * Safely destroy runtime modifiable EM. By using the call
> +        * synchronize_rcu() we make sure we don't progress till last user
> +        * finished the RCU section and our update got applied.
> +        */
>         rcu_assign_pointer(pd->runtime_table, NULL);
>         synchronize_rcu();
>
> +       /*
> +        * After the sync no updates will be in-flight, so free the
> +        * memory allocated for runtime table (if there was such).
> +        */
> +       if (runtime_table != pd->default_table) {
> +               kfree(runtime_table->state);
> +               kfree(runtime_table);
> +       }

Can't this race with the RCU callback freeing the runtime table?

> +
>         kfree(pd->default_table->state);
>         kfree(pd->default_table);
>         kfree(dev->em_pd);
> --
