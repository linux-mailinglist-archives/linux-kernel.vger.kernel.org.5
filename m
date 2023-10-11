Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75817C5DB8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 21:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbjJKTg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 15:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbjJKTgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 15:36:24 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDA49E
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 12:36:20 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-79fb64b5265so9988739f.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 12:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697052980; x=1697657780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NN0fhReL4fwvEyFnpMknXmGYf2i7Jn53Tm9WQAjbyMM=;
        b=TwFoOn4GZ38L4pMpHz5Y6TkUW1Bqu6wKAACdSbhOj172w1k4ztmEOKuCXMCx9Lvf5H
         ZV6FM/meWHU3QdU65UaUsZOWmwn+mnMyTy+NICznyg1Ypouuq+a5frjfOjaW7SsxSRU2
         blBQH8LwMebDKev9DOHrE7cU9DRcJbnJpE51pjsi3FLssjadAPMJa+WxWAHHEhh4eaDD
         9PXKqcmy4k9v9w87ZYSbFyqg0UvwoRJQ9HrliPOqPwNeT9LK8WppJRQiu+h0lvtFRps2
         NTbAJnDTDAzTQkS8fmULK2J69oStRmse9384ddZyOlyKkazQGoaOgnWVWn+4Iltgh9Od
         AyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697052980; x=1697657780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NN0fhReL4fwvEyFnpMknXmGYf2i7Jn53Tm9WQAjbyMM=;
        b=uvvur1t+pyB+z37P0G0l+0WaVs3xXz1d6mQAw8gDvcHbuejHBYA+Uicx4bLAvHaWTG
         NbIL/fNB9VDB2rUX54oa1kzQUAS1NNUhohJFchJK+O/05NBLIUAcoYHciL0Pb17E8wGd
         lL1YR1Qf6jWkj2PPB5KHx8ZppacKCepSWbgH9vWKAtt4ofTML1uKEz7OXnrjzWQolJqh
         n87UtcMvGHUFSkxBF4W4SSA/6u5i2A9cAxquhgUK/Y8tve2wlaQIaNYyPmDqeJYYTKJB
         KbcvfLQCOD0b+FdC3Chz9kn4udlkK9/Qhts7nMjmRiVmvAABoKqtFLBv5JANHIvF6Alo
         /ocg==
X-Gm-Message-State: AOJu0Yzteaazddkk5aR69u5pXbT8YKaDvRLFB32oDQNR7CslaMct4xlw
        gfGkGUQPRdUC6HcuboIqaf3V18fQG+z504l8OlM=
X-Google-Smtp-Source: AGHT+IFvUisG3I7gbgQmWmeuvVI6Ay29thGkWuYwI35830tDVghRRVq/pZmRwx5tvbOD5wirZbG50cXLzKrt5JusxY8=
X-Received: by 2002:a05:6602:211a:b0:792:43b4:dc2 with SMTP id
 x26-20020a056602211a00b0079243b40dc2mr24853156iox.3.1697052979949; Wed, 11
 Oct 2023 12:36:19 -0700 (PDT)
MIME-Version: 1.0
References: <20231011051117.2289518-1-hezhongkun.hzk@bytedance.com>
In-Reply-To: <20231011051117.2289518-1-hezhongkun.hzk@bytedance.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Wed, 11 Oct 2023 12:36:08 -0700
Message-ID: <CAKEwX=OBYiH+G17YLRvEhx2Ode6q_hc0NgR6ZisBD_h0URcgSw@mail.gmail.com>
Subject: Re: [RFC PATCH] zswap: add writeback_time_threshold interface to
 shrink zswap pool
To:     Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org,
        yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 10:11=E2=80=AFPM Zhongkun He
<hezhongkun.hzk@bytedance.com> wrote:
>
> zswap does not have a suitable method to select objects that have not
> been accessed for a long time, and just shrink the pool when the limit
> is hit. There is a high probability of wasting memory in zswap if the
> limit is too high.

We're currently trying to solve this exact problem. Our approach is to
add a shrinker that automatically shrinks the size of the zswap pool:

https://lore.kernel.org/lkml/20230919171447.2712746-1-nphamcs@gmail.com/

It is triggered on memory-pressure, and can perform reclaim in a
workload-specific manner.

I'm currently working on v3 of this patch series, but in the meantime,
could you take a look and see if it will address your issues as well?

Comments and suggestions are always welcome, of course :)

>
> This patch add a new interface writeback_time_threshold to shrink zswap
> pool proactively based on the time threshold in second, e.g.::
>
> echo 600 > /sys/module/zswap/parameters/writeback_time_threshold

My concern with this approach is that this value seems rather arbitrary.
I imagine that it is workload- and memory access pattern- dependent,
and will have to be tuned. Other than a couple of big users, no one
will have the resources to do this.

And since this is a one-off knob, there's another parameter users
will have to decide - frequency, i.e how often should the userspace
agent trigger this reclaim action. This is again very hard to determine
a priori, and most likely has to be tuned as well.

>
> If zswap_entrys have not been accessed for more than 600 seconds, they
> will be swapout to swap. if set to 0, all of them will be swapout.
>
> Signed-off-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
> ---
>  Documentation/admin-guide/mm/zswap.rst |  9 +++
>  mm/zswap.c                             | 76 ++++++++++++++++++++++++++
>  2 files changed, 85 insertions(+)
>
> diff --git a/Documentation/admin-guide/mm/zswap.rst b/Documentation/admin=
-guide/mm/zswap.rst
> index 45b98390e938..9ffaed26c3c0 100644
> --- a/Documentation/admin-guide/mm/zswap.rst
> +++ b/Documentation/admin-guide/mm/zswap.rst
> @@ -153,6 +153,15 @@ attribute, e. g.::
>
>  Setting this parameter to 100 will disable the hysteresis.
>
> +When there is a lot of cold memory according to the store time in the zs=
wap,
> +it can be swapout and save memory in userspace proactively. User can wri=
te
> +writeback time threshold in second to enable it, e.g.::
> +
> +  echo 600 > /sys/module/zswap/parameters/writeback_time_threshold
> +
> +If zswap_entrys have not been accessed for more than 600 seconds, they w=
ill be
> +swapout. if set to 0, all of them will be swapout.
> +
>  A debugfs interface is provided for various statistic about pool size, n=
umber
>  of pages stored, same-value filled pages and various counters for the re=
asons
>  pages are rejected.
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 083c693602b8..c3a19b56a29b 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -141,6 +141,16 @@ static bool zswap_exclusive_loads_enabled =3D IS_ENA=
BLED(
>                 CONFIG_ZSWAP_EXCLUSIVE_LOADS_DEFAULT_ON);
>  module_param_named(exclusive_loads, zswap_exclusive_loads_enabled, bool,=
 0644);
>
> +/* zswap writeback time threshold in second */
> +static unsigned int  zswap_writeback_time_thr;
> +static int zswap_writeback_time_thr_param_set(const char *, const struct=
 kernel_param *);
> +static const struct kernel_param_ops zswap_writeback_param_ops =3D {
> +       .set =3D          zswap_writeback_time_thr_param_set,
> +       .get =3D          param_get_uint,
> +};
> +module_param_cb(writeback_time_threshold, &zswap_writeback_param_ops,
> +                       &zswap_writeback_time_thr, 0644);
> +
>  /* Number of zpools in zswap_pool (empirically determined for scalabilit=
y) */
>  #define ZSWAP_NR_ZPOOLS 32
>
> @@ -197,6 +207,7 @@ struct zswap_pool {
>   * value - value of the same-value filled pages which have same content
>   * objcg - the obj_cgroup that the compressed memory is charged to
>   * lru - handle to the pool's lru used to evict pages.
> + * sto_time - the store time of zswap_entry.
>   */
>  struct zswap_entry {
>         struct rb_node rbnode;
> @@ -210,6 +221,7 @@ struct zswap_entry {
>         };
>         struct obj_cgroup *objcg;
>         struct list_head lru;
> +       ktime_t sto_time;
>  };
>
>  /*
> @@ -288,6 +300,31 @@ static void zswap_update_total_size(void)
>         zswap_pool_total_size =3D total;
>  }
>
> +static void zswap_reclaim_entry_by_timethr(void);
> +
> +static bool zswap_reach_timethr(struct zswap_pool *pool)
> +{
> +       struct zswap_entry *entry;
> +       ktime_t expire_time =3D 0;
> +       bool ret =3D false;
> +
> +       spin_lock(&pool->lru_lock);
> +
> +       if (list_empty(&pool->lru))
> +               goto out;
> +
> +       entry =3D list_last_entry(&pool->lru, struct zswap_entry, lru);
> +       expire_time =3D ktime_add(entry->sto_time,
> +                       ns_to_ktime(zswap_writeback_time_thr * NSEC_PER_S=
EC));
> +
> +       if (ktime_after(ktime_get_boottime(), expire_time))
> +               ret =3D true;
> +out:
> +       spin_unlock(&pool->lru_lock);
> +       return ret;
> +}
> +
> +
>  /*********************************
>  * zswap entry functions
>  **********************************/
> @@ -395,6 +432,7 @@ static void zswap_free_entry(struct zswap_entry *entr=
y)
>         else {
>                 spin_lock(&entry->pool->lru_lock);
>                 list_del(&entry->lru);
> +               entry->sto_time =3D 0;
>                 spin_unlock(&entry->pool->lru_lock);
>                 zpool_free(zswap_find_zpool(entry), entry->handle);
>                 zswap_pool_put(entry->pool);
> @@ -709,6 +747,28 @@ static void shrink_worker(struct work_struct *w)
>         zswap_pool_put(pool);
>  }
>
> +static void zswap_reclaim_entry_by_timethr(void)
> +{
> +       struct zswap_pool *pool =3D zswap_pool_current_get();
> +       int ret, failures =3D 0;
> +
> +       if (!pool)
> +               return;
> +
> +       while (zswap_reach_timethr(pool)) {
> +               ret =3D zswap_reclaim_entry(pool);
> +               if (ret) {
> +                       zswap_reject_reclaim_fail++;
> +                       if (ret !=3D -EAGAIN)
> +                               break;
> +                       if (++failures =3D=3D MAX_RECLAIM_RETRIES)
> +                               break;
> +               }
> +               cond_resched();
> +       }
> +       zswap_pool_put(pool);
> +}
> +
>  static struct zswap_pool *zswap_pool_create(char *type, char *compressor=
)
>  {
>         int i;
> @@ -1037,6 +1097,21 @@ static int zswap_enabled_param_set(const char *val=
,
>         return ret;
>  }
>
> +static int zswap_writeback_time_thr_param_set(const char *val,
> +                               const struct kernel_param *kp)
> +{
> +       int ret =3D -ENODEV;
> +
> +       /* if this is load-time (pre-init) param setting, just return. */
> +       if (system_state !=3D SYSTEM_RUNNING)
> +               return ret;
> +
> +       ret =3D param_set_uint(val, kp);
> +       if (!ret)
> +               zswap_reclaim_entry_by_timethr();
> +       return ret;
> +}
> +
>  /*********************************
>  * writeback code
>  **********************************/
> @@ -1360,6 +1435,7 @@ bool zswap_store(struct folio *folio)
>         if (entry->length) {
>                 spin_lock(&entry->pool->lru_lock);
>                 list_add(&entry->lru, &entry->pool->lru);
> +               entry->sto_time =3D ktime_get_boottime();
>                 spin_unlock(&entry->pool->lru_lock);
>         }

I think there might be some issues with just storing the store time here
as well. IIUC, there might be cases where the zswap entry
is accessed and brought into memory, but that entry (with the associated
compressed memory) still hangs around. For e.g and more context,
see this patch that enables exclusive loads:

https://lore.kernel.org/lkml/20230607195143.1473802-1-yosryahmed@google.com=
/

If that happens, this sto_time field does not tell the full story, right?
For instance, if an object is stored a long time ago, but has been
accessed since, it shouldn't be considered a cold object that should be
a candidate for reclaim. But the old sto_time would indicate otherwise.

>         spin_unlock(&tree->lock);
> --
> 2.25.1
>
