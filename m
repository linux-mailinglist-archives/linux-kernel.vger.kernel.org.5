Return-Path: <linux-kernel+bounces-5259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1714E8188A7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30B181C2149B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3357619477;
	Tue, 19 Dec 2023 13:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="swx77HIL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4031945B
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 13:29:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C742DC433CD
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 13:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702992587;
	bh=wtONm7V5xDBbfpKe/H0yV1IHXxZtMbaa9hmxX+JTfxU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=swx77HILJFExW8MeeRGHSYGvg5TdeHvuCDD1aYjXwfiJa2hb/5jad9qlxBtsERaBk
	 50XvfyGqgVYE00SdKmyijeXWYpitRFEZIGoRfn1gkRwtM9mLNLvKzQSQryOUynAh7S
	 ienn/a+PSqGu2J5IhIezK9o5hOc2tZjvflNOcuS0Wc6pUMC0zgVmviE22jzP0Qprhc
	 Gs/3bebDSDrdqre9kOVCJw5XovrPi/Dm8w9P72KgyEp/7sVTdcg5dkQgAb4dx5i7to
	 8iOlgfM5QnJullHBcGzqKuqO/cQSgema2foaBhfEYPqKuxr+85Z1CCuOAfCUlcsVIt
	 0qd+w0pKjtUzQ==
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6d9344f30caso470721b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 05:29:47 -0800 (PST)
X-Gm-Message-State: AOJu0Yxc6CVhOxaC/J0/8liNCmeLaSwvk0pn88zHpr4d1UDQ0wxzwrE8
	0ibh8l2h9m80JBDvFtPfTlqhBa4n17L/f9jZgFWxQx+D4G1k
X-Google-Smtp-Source: AGHT+IElXxWjFH4hfi4IqbwsaLLXMphWbj2Z9cpauZu+/IjDhN1kDlh3R9U6iPVDINYjbuXqv7pbAH98gsUeYfMUu38=
X-Received: by 2002:aa7:814d:0:b0:6d9:3e48:a782 with SMTP id
 d13-20020aa7814d000000b006d93e48a782mr389079pfn.18.1702992586975; Tue, 19 Dec
 2023 05:29:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213-zswap-dstmem-v3-0-4eac09b94ece@bytedance.com> <20231213-zswap-dstmem-v3-6-4eac09b94ece@bytedance.com>
In-Reply-To: <20231213-zswap-dstmem-v3-6-4eac09b94ece@bytedance.com>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 19 Dec 2023 05:29:35 -0800
X-Gmail-Original-Message-ID: <CAF8kJuOv+k0TcKJhs8wEWi20=B84bomj5BvpUAHvj6k3A+WE5A@mail.gmail.com>
Message-ID: <CAF8kJuOv+k0TcKJhs8wEWi20=B84bomj5BvpUAHvj6k3A+WE5A@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] mm/zswap: directly use percpu mutex and buffer in load/store
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Seth Jennings <sjenning@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Vitaly Wool <vitaly.wool@konsulko.com>, Dan Streetman <ddstreet@ieee.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nhat Pham <nphamcs@gmail.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chengming and Yosry,

On Mon, Dec 18, 2023 at 3:50=E2=80=AFAM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> Since the introduce of reusing the dstmem in the load path, it seems
> confusing that we are now using acomp_ctx->dstmem and acomp_ctx->mutex
> now for purposes other than what the naming suggests.
>
> Yosry suggested removing these two fields from acomp_ctx, and directly
> using zswap_dstmem and zswap_mutex in both the load and store paths,
> rename them, and add proper comments above their definitions that they
> are for generic percpu buffering on the load and store paths.
>
> So this patch remove dstmem and mutex from acomp_ctx, and rename the
> zswap_dstmem to zswap_buffer, using the percpu mutex and buffer on
> the load and store paths.

Sorry joining this discussion late.

I get the rename of "dstmem" to "buffer". Because the buffer is used
for both load and store as well. What I don't get is that, why do we
move it out of the acomp_ctx struct. Now we have 3 per cpu entry:
buffer, mutex and acomp_ctx. I think we should do the reverse, fold
this three per cpu entry into one struct the acomp_ctx. Each per_cpu
load() has a sequence of dance around the cpu id and disable preempt
etc, while each of the struct member load is just a plan memory load.
It seems to me it would be more optimal to combine this three per cpu
entry into acomp_ctx. Just do the per cpu for the acomp_ctx once.

>
> Suggested-by: Yosry Ahmed <yosryahmed@google.com>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  mm/zswap.c | 69 +++++++++++++++++++++++++++++++++-----------------------=
------
>  1 file changed, 37 insertions(+), 32 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 2c349fd88904..71bdcd552e5b 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -166,8 +166,6 @@ struct crypto_acomp_ctx {
>         struct crypto_acomp *acomp;
>         struct acomp_req *req;
>         struct crypto_wait wait;
> -       u8 *dstmem;
> -       struct mutex *mutex;
>  };
>
>  /*
> @@ -694,7 +692,7 @@ static void zswap_alloc_shrinker(struct zswap_pool *p=
ool)
>  /*********************************
>  * per-cpu code
>  **********************************/
> -static DEFINE_PER_CPU(u8 *, zswap_dstmem);
> +static DEFINE_PER_CPU(u8 *, zswap_buffer);
>  /*
>   * If users dynamically change the zpool type and compressor at runtime,=
 i.e.
>   * zswap is running, zswap can have more than one zpool on one cpu, but =
they
> @@ -702,39 +700,39 @@ static DEFINE_PER_CPU(u8 *, zswap_dstmem);
>   */
>  static DEFINE_PER_CPU(struct mutex *, zswap_mutex);
>
> -static int zswap_dstmem_prepare(unsigned int cpu)
> +static int zswap_buffer_prepare(unsigned int cpu)
>  {
>         struct mutex *mutex;
> -       u8 *dst;
> +       u8 *buf;
>
> -       dst =3D kmalloc_node(PAGE_SIZE, GFP_KERNEL, cpu_to_node(cpu));
> -       if (!dst)
> +       buf =3D kmalloc_node(PAGE_SIZE, GFP_KERNEL, cpu_to_node(cpu));
> +       if (!buf)
>                 return -ENOMEM;
>
>         mutex =3D kmalloc_node(sizeof(*mutex), GFP_KERNEL, cpu_to_node(cp=
u));
>         if (!mutex) {
> -               kfree(dst);
> +               kfree(buf);
>                 return -ENOMEM;
>         }
>
>         mutex_init(mutex);
> -       per_cpu(zswap_dstmem, cpu) =3D dst;
> +       per_cpu(zswap_buffer, cpu) =3D buf;
>         per_cpu(zswap_mutex, cpu) =3D mutex;
>         return 0;
>  }
>
> -static int zswap_dstmem_dead(unsigned int cpu)
> +static int zswap_buffer_dead(unsigned int cpu)
>  {
>         struct mutex *mutex;
> -       u8 *dst;
> +       u8 *buf;
>
>         mutex =3D per_cpu(zswap_mutex, cpu);
>         kfree(mutex);
>         per_cpu(zswap_mutex, cpu) =3D NULL;
>
> -       dst =3D per_cpu(zswap_dstmem, cpu);
> -       kfree(dst);
> -       per_cpu(zswap_dstmem, cpu) =3D NULL;
> +       buf =3D per_cpu(zswap_buffer, cpu);
> +       kfree(buf);
> +       per_cpu(zswap_buffer, cpu) =3D NULL;
>
>         return 0;
>  }
> @@ -772,9 +770,6 @@ static int zswap_cpu_comp_prepare(unsigned int cpu, s=
truct hlist_node *node)
>         acomp_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
>                                    crypto_req_done, &acomp_ctx->wait);
>
> -       acomp_ctx->mutex =3D per_cpu(zswap_mutex, cpu);
> -       acomp_ctx->dstmem =3D per_cpu(zswap_dstmem, cpu);
> -
>         return 0;
>  }
>
> @@ -1397,15 +1392,21 @@ static void __zswap_load(struct zswap_entry *entr=
y, struct page *page)
>         struct zpool *zpool =3D zswap_find_zpool(entry);
>         struct scatterlist input, output;
>         struct crypto_acomp_ctx *acomp_ctx;
> -       u8 *src;
> +       u8 *src, *buf;
> +       int cpu;
> +       struct mutex *mutex;
>
> -       acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
> -       mutex_lock(acomp_ctx->mutex);
> +       cpu =3D raw_smp_processor_id();
> +       mutex =3D per_cpu(zswap_mutex, cpu);
First per cpu call.
> +       mutex_lock(mutex);
> +
> +       acomp_ctx =3D per_cpu_ptr(entry->pool->acomp_ctx, cpu);
Second per cpu
>
>         src =3D zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
>         if (!zpool_can_sleep_mapped(zpool)) {
> -               memcpy(acomp_ctx->dstmem, src, entry->length);
> -               src =3D acomp_ctx->dstmem;
> +               buf =3D per_cpu(zswap_buffer, cpu);

Here is the function that does the third per_cpu call. I think doing
one per_cpu and the rest of them load from the context is more
optimal.
Conceptually it is cleaner as well. It is clear what this mutex is
supposed to protect. It is protecting the compression context struct.
Move it out as per cpu, it is less clear what is the protection scope
of the mutex.

What am I missing?

Chris


> +               memcpy(buf, src, entry->length);
> +               src =3D buf;
>                 zpool_unmap_handle(zpool, entry->handle);
>         }
>
> @@ -1415,7 +1416,7 @@ static void __zswap_load(struct zswap_entry *entry,=
 struct page *page)
>         acomp_request_set_params(acomp_ctx->req, &input, &output, entry->=
length, PAGE_SIZE);
>         BUG_ON(crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &=
acomp_ctx->wait));
>         BUG_ON(acomp_ctx->req->dlen !=3D PAGE_SIZE);
> -       mutex_unlock(acomp_ctx->mutex);
> +       mutex_unlock(mutex);
>
>         if (zpool_can_sleep_mapped(zpool))
>                 zpool_unmap_handle(zpool, entry->handle);
> @@ -1551,6 +1552,8 @@ bool zswap_store(struct folio *folio)
>         u8 *src, *dst;
>         gfp_t gfp;
>         int ret;
> +       int cpu;
> +       struct mutex *mutex;
>
>         VM_WARN_ON_ONCE(!folio_test_locked(folio));
>         VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
> @@ -1636,11 +1639,13 @@ bool zswap_store(struct folio *folio)
>         }
>
>         /* compress */
> -       acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
> +       cpu =3D raw_smp_processor_id();
> +       mutex =3D per_cpu(zswap_mutex, cpu);
> +       mutex_lock(mutex);
>
> -       mutex_lock(acomp_ctx->mutex);
> +       acomp_ctx =3D per_cpu_ptr(entry->pool->acomp_ctx, cpu);
> +       dst =3D per_cpu(zswap_buffer, cpu);
>
> -       dst =3D acomp_ctx->dstmem;
>         sg_init_table(&input, 1);
>         sg_set_page(&input, page, PAGE_SIZE, 0);
>
> @@ -1683,7 +1688,7 @@ bool zswap_store(struct folio *folio)
>         buf =3D zpool_map_handle(zpool, handle, ZPOOL_MM_WO);
>         memcpy(buf, dst, dlen);
>         zpool_unmap_handle(zpool, handle);
> -       mutex_unlock(acomp_ctx->mutex);
> +       mutex_unlock(mutex);
>
>         /* populate entry */
>         entry->swpentry =3D swp_entry(type, offset);
> @@ -1726,7 +1731,7 @@ bool zswap_store(struct folio *folio)
>         return true;
>
>  put_dstmem:
> -       mutex_unlock(acomp_ctx->mutex);
> +       mutex_unlock(mutex);
>  put_pool:
>         zswap_pool_put(entry->pool);
>  freepage:
> @@ -1902,10 +1907,10 @@ static int zswap_setup(void)
>         }
>
>         ret =3D cpuhp_setup_state(CPUHP_MM_ZSWP_MEM_PREPARE, "mm/zswap:pr=
epare",
> -                               zswap_dstmem_prepare, zswap_dstmem_dead);
> +                               zswap_buffer_prepare, zswap_buffer_dead);
>         if (ret) {
> -               pr_err("dstmem alloc failed\n");
> -               goto dstmem_fail;
> +               pr_err("buffer alloc failed\n");
> +               goto buffer_fail;
>         }
>
>         ret =3D cpuhp_setup_state_multi(CPUHP_MM_ZSWP_POOL_PREPARE,
> @@ -1940,7 +1945,7 @@ static int zswap_setup(void)
>                 zswap_pool_destroy(pool);
>  hp_fail:
>         cpuhp_remove_state(CPUHP_MM_ZSWP_MEM_PREPARE);
> -dstmem_fail:
> +buffer_fail:
>         kmem_cache_destroy(zswap_entry_cache);
>  cache_fail:
>         /* if built-in, we aren't unloaded on failure; don't allow use */
>
> --
> b4 0.10.1

