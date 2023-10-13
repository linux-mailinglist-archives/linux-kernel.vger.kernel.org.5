Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847927C7BB5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 04:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjJMCre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 22:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjJMCrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 22:47:33 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C2DCA
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 19:47:30 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99c1c66876aso262798966b.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 19:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697165249; x=1697770049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cYYs7lQd4WDMEoTxMMLaOduMsvwNYj0Il5pdvl2CUOQ=;
        b=mcxWrfYxBxAQWxOan1WVQkUvzgylkp98gpQ27sieCi4qgTLBlHKG9uisgOsJP04fF1
         z8cQ0jnkrItfb3oKlSoNrhp3d9OqYdfTeJQTl+Ri5DX6315IFtBCfNYaeck4is14S1IC
         R1zGEj+avGTdv+a5qw3lXG6e9eolu0hw5cIGvhkCOn12eSQn7A6oocfzd7yKEc5i4aME
         y7mcIou7zz5cNDQravX5JPAuE9BSqJCvCxFZ68L6HgQhWWSSFsmgE9c57qVt/eqXzfoG
         y0CyhrgcTQ+UMWYsJm0oKVCdTqr53kZDTeq3ptoMFFWQzTL3OYcapL1bJ8Gx3luDjhJJ
         o7xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697165249; x=1697770049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cYYs7lQd4WDMEoTxMMLaOduMsvwNYj0Il5pdvl2CUOQ=;
        b=L4nlyNNsz0JCea7zN5JtsZWHbWlQK5He2gFHdbKPOZ3emjae7RvAoO+KM5xD6+fLGB
         eeBcFfogZI02kmis/lBV7krWTcDl6Pr3AX1HaLADwKUK8HcFvhhTRaXGmIx69azPuYLj
         FKN7o6097+0VY0/udPcRZY8eKzhld8XIGVcfL+4ZxK1j8Gw6qDEMPjehnkCWwxnyfO3z
         KxkaewY3W2OvmHQPNTox4G2VblSciFZv0/xTntxM/K8jD8gEcNQhXiAamENmSHSmpeh/
         s8fI1ghV5cCRSrgcC3PvIMmAZaGVklkEMMPejYWK3xLddH7LE52ehP0X6MO1u5iVQ1El
         OfFQ==
X-Gm-Message-State: AOJu0Yy93NlCYdJc7DxxXK1a3fqHO37Xymwny4+pz/sXWFy37jRdiCxF
        +FNmbpiOGwMqNZAyLAix85N5sP68uVcejQBRfn4Bug==
X-Google-Smtp-Source: AGHT+IGXCOZZfR7HN3szDEzM2KtARzOb70RibFw64isCYaTnTXGWMypafHZeB6GYKf6Nl7sDAU/2En57ZYXG1TUzrSM=
X-Received: by 2002:a17:906:7484:b0:9b9:f980:8810 with SMTP id
 e4-20020a170906748400b009b9f9808810mr16268302ejl.34.1697165248449; Thu, 12
 Oct 2023 19:47:28 -0700 (PDT)
MIME-Version: 1.0
References: <20231011051117.2289518-1-hezhongkun.hzk@bytedance.com>
In-Reply-To: <20231011051117.2289518-1-hezhongkun.hzk@bytedance.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 12 Oct 2023 19:46:52 -0700
Message-ID: <CAJD7tka+35CKYDLHus+LnN1yi_J=t_+kYXrZYh3asiWR41GKww@mail.gmail.com>
Subject: Re: [RFC PATCH] zswap: add writeback_time_threshold interface to
 shrink zswap pool
To:     Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, nphamcs@gmail.com,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
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
>
> This patch add a new interface writeback_time_threshold to shrink zswap
> pool proactively based on the time threshold in second, e.g.::
>
> echo 600 > /sys/module/zswap/parameters/writeback_time_threshold
>
> If zswap_entrys have not been accessed for more than 600 seconds, they
> will be swapout to swap. if set to 0, all of them will be swapout.
>
> Signed-off-by: Zhongkun He <hezhongkun.hzk@bytedance.com>

I prefer if this can be done through memory.reclaim when the zswap
shrinker is in place, as others have suggested. I understand that this
provides more control by specifying the time at which to start writing
pages out, which is similar to zram writeback AFAICT, but it is also
difficult to determine the right value to write here.

I am also not sure how you decide that it is better to writeback cold
pages in zswap or compress cold pages in the LRUs. The pages in zswap
are obviously colder, but accessing them after they are written back
is much more expensive, to the point that it could be better to
compress more cold memory from the LRUs. This is obviously not
straightforward and requires a fair amount of tuning to do more good
than harm.

That being said, if we decide to move forward with this I have a
couple of comments:

- I think you should check out how zram implements idle writeback and
try to make things consistent. Zswap and zram don't really see eye to
eye, but some consistency would be nice. If you looked at zram's
implementation you would realize that you also need to update the
access time when a page is read (unless the load is exclusive).

- This should be behind a config option. Every word that we add to
struct zswap_entry reduces the zswap savings by roughly 0.2%. Maybe
this doesn't sound like much but it adds up. Let's not opt everyone in
unless they ask for it.

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
>         spin_unlock(&tree->lock);
> --
> 2.25.1
>
