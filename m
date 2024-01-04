Return-Path: <linux-kernel+bounces-17171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F12824926
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 20:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E3FD1C22171
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 19:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF37A2C6B4;
	Thu,  4 Jan 2024 19:35:29 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DA02C6A0;
	Thu,  4 Jan 2024 19:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-59629f0f67aso117580eaf.0;
        Thu, 04 Jan 2024 11:35:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704396927; x=1705001727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wp++XMNDXxDK3eCoflFxpDVjis98CPwruo3etDqEbNw=;
        b=d6EhSpOeVuF/Nb490i0duTTswYaKcoRdfsP646m6hK5oOGAND6S7yp4nCsBLAJKOBX
         hekTQMgolaWsjUp/cetIcaEl5m+P4pCtpB7GSQhjUkLhtWwYBsexbItnnP/Rl9qEtv4D
         ekGYt6O94LtTKMfwz31f02a1EfS5luatGZzBdGS1nSwwZw3Rzm+qxpQUdAI8ICJKGv4r
         ImgKY3ooeaf5DcC8SheaZbDOtoWWAT+OdXpCDkD7aV8s6LIGWUYOABqZHtf1vEaLdUHm
         on7osSlUiaTmm8j3gOUisQZwiRCh6q2YY420o8M5YUC8FqRd0udiykubXQoRNWksCZrM
         F+Ag==
X-Gm-Message-State: AOJu0YwRkjnJ9uRYhw+zoMDToduX1vudW5dktSJIFf8lOsb1U09i0HEb
	CEq1pwNoHsEuzyUk72YrEsED4uezLl1VIu87JB0=
X-Google-Smtp-Source: AGHT+IFxnlwS+SBeVjeB4OB7ubF9SRqFf/Sd24+Uw5YIep80l/JL/mJSnOacRGp32v0lpxpCjjM4BNkPBjvtaIgKWdU=
X-Received: by 2002:a4a:da09:0:b0:596:2965:be22 with SMTP id
 e9-20020a4ada09000000b005962965be22mr1741474oou.1.1704396927060; Thu, 04 Jan
 2024 11:35:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104171553.2080674-1-lukasz.luba@arm.com> <20240104171553.2080674-11-lukasz.luba@arm.com>
In-Reply-To: <20240104171553.2080674-11-lukasz.luba@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 4 Jan 2024 20:35:16 +0100
Message-ID: <CAJZ5v0grn7RHLxf0Bfxh-PtwvQXfr0F8bGc9bWDuuD3_noLjGw@mail.gmail.com>
Subject: Re: [PATCH v6 10/23] PM: EM: Add API for memory allocations for new tables
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, rafael@kernel.org, 
	dietmar.eggemann@arm.com, rui.zhang@intel.com, amit.kucheria@verdurent.com, 
	amit.kachhap@gmail.com, daniel.lezcano@linaro.org, viresh.kumar@linaro.org, 
	len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org, qyousef@layalina.io, 
	wvw@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 6:15=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> wr=
ote:
>
> The runtime modified EM table can be provided from drivers. Create
> mechanism which allows safely allocate and free the table for device
> drivers. The same table can be used by the EAS in task scheduler code
> paths, so make sure the memory is not freed when the device driver module
> is unloaded.
>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  include/linux/energy_model.h | 11 +++++++++
>  kernel/power/energy_model.c  | 43 ++++++++++++++++++++++++++++++++++--
>  2 files changed, 52 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> index 5f842da3bb0c..753d70d0ce7e 100644
> --- a/include/linux/energy_model.h
> +++ b/include/linux/energy_model.h
> @@ -5,6 +5,7 @@
>  #include <linux/device.h>
>  #include <linux/jump_label.h>
>  #include <linux/kobject.h>
> +#include <linux/kref.h>
>  #include <linux/rcupdate.h>
>  #include <linux/sched/cpufreq.h>
>  #include <linux/sched/topology.h>
> @@ -39,10 +40,12 @@ struct em_perf_state {
>  /**
>   * struct em_perf_table - Performance states table
>   * @rcu:       RCU used for safe access and destruction
> + * @refcount:  Reference count to track the owners

"Reference counter to track the users"

Also it is not really just a counter - it provides the memory release
mechanism too.

>   * @state:     List of performance states, in ascending order
>   */
>  struct em_perf_table {
>         struct rcu_head rcu;
> +       struct kref refcount;

So I would just call it kref.

>         struct em_perf_state state[];
>  };
>
> @@ -184,6 +187,8 @@ int em_dev_register_perf_domain(struct device *dev, u=
nsigned int nr_states,
>                                 struct em_data_callback *cb, cpumask_t *s=
pan,
>                                 bool microwatts);
>  void em_dev_unregister_perf_domain(struct device *dev);
> +struct em_perf_table __rcu *em_allocate_table(struct em_perf_domain *pd)=
;
> +void em_free_table(struct em_perf_table __rcu *table);
>
>  /**
>   * em_pd_get_efficient_state() - Get an efficient performance state from=
 the EM
> @@ -365,6 +370,12 @@ static inline int em_pd_nr_perf_states(struct em_per=
f_domain *pd)
>  {
>         return 0;
>  }
> +static inline
> +struct em_perf_table __rcu *em_allocate_table(struct em_perf_domain *pd)
> +{
> +       return NULL;
> +}
> +static inline void em_free_table(struct em_perf_table __rcu *table) {}
>  #endif
>
>  #endif
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index c03010084208..bbc406db0be1 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -114,12 +114,46 @@ static void em_destroy_table_rcu(struct rcu_head *r=
p)
>         kfree(table);
>  }
>
> -static void em_free_table(struct em_perf_table __rcu *table)
> +static void em_release_table_kref(struct kref *kref)
>  {
> +       struct em_perf_table __rcu *table;
> +
> +       /* It was the last owner of this table so we can free */
> +       table =3D container_of(kref, struct em_perf_table, refcount);
> +
>         call_rcu(&table->rcu, em_destroy_table_rcu);
>  }
>
> -static struct em_perf_table __rcu *
> +static inline void em_table_inc(struct em_perf_table __rcu *table)

Why not em_table_get()?

> +{
> +       kref_get(&table->refcount);
> +}
> +
> +static void em_table_dec(struct em_perf_table __rcu *table)

And em_table_put() here?

Note that I do realize that the "put" and "get" terminology is used in
one of the subsequent patches - I'll get to it later.

> +{
> +       kref_put(&table->refcount, em_release_table_kref);
> +}
> +
> +/**
> + * em_free_table() - Handles safe free of the EM table when needed
> + * @table : EM memory which is going to be freed
> + *
> + * No return values.
> + */
> +void em_free_table(struct em_perf_table __rcu *table)
> +{
> +       em_table_dec(table);
> +}

Why is this necessary?  The function called by it could be extern
instead and wrapped into a static inline wrapper in a header (if you
really need the alias).

> +
> +/**
> + * em_allocate_table() - Handles safe allocation of the new EM table

" - Allocate a new EM table"

And I would call this em_table_alloc() and (maybe) add an
em_table_free() alias for em_table_put().

> + * @table : EM memory which is going to be freed

So the argument is called "pd" and it is not a table.  It is also used
for computing the size of the new table AFAICS.

> + *
> + * Increments the reference counter to mark that there is an owner of th=
at

"Allocate a new EM table and initialize its kref to indicate that it
has a user."

> + * EM table. That might be a device driver module or EAS.
> + * Returns allocated table or error.
> + */
> +struct em_perf_table __rcu *
>  em_allocate_table(struct em_perf_domain *pd)
>  {
>         struct em_perf_table __rcu *table;
> @@ -128,6 +162,11 @@ em_allocate_table(struct em_perf_domain *pd)
>         table_size =3D sizeof(struct em_perf_state) * pd->nr_perf_states;
>
>         table =3D kzalloc(sizeof(*table) + table_size, GFP_KERNEL);
> +       if (!table)
> +               return table;

I would return NULL from here explicitly.

> +
> +       kref_init(&table->refcount);
> +
>         return table;
>  }
>
> --

