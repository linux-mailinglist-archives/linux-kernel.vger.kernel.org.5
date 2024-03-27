Return-Path: <linux-kernel+bounces-121642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 547A188EB76
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C06CD1F24BC1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC81F149E1B;
	Wed, 27 Mar 2024 16:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YoLxYmUQ"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2AC12FB2F
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 16:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711557670; cv=none; b=X0nG9qCQeWaYZyefFYaX2Utah5U1OVaCFM5cdKDgPTdxOAusxHg8w8+hefs731ciGLVXLJHgeJmt0J655NVJKgx7pJKSMgMramTYEtU1jWuE1Bik/Apzp3bjPKoiwjpnFUoumNU8dVz1ngEOPKwF4iG5PWXUyhw0XnAlPIkB8LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711557670; c=relaxed/simple;
	bh=Lt8v29rfoTTzWFuyXWFLKvY4kmtkIVJavMxahFMZrKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=edThXvEbKLBOEaZDmEbF2ad7TJPSUoNPBJZbu3pru822Q4P9XvgDMx6VY9QaLWEQvUhkE9gIQAORpYHtRqpgH6/fnKDfW3lWiltSBDl/GcTjm4KfB19UMgbIjTCwfjNsh2D+jjfGuOiv62IBLzNAAMeILzRdRlzU6N50GSdUCzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YoLxYmUQ; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-690d7a8f904so9300076d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 09:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711557668; x=1712162468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YMZWWaTaJ3lxeA3Kz3iKtD6XUKMHdnC8EWB2x35/ZWU=;
        b=YoLxYmUQ/0sVNtPDv7dDa4WNcYnkIQkXlVrB2BIotztWuxGBdpARLfVBWY0opcZoa5
         sWqmthJyhfh33DWoCd+KTauqyQF2apb+nHPj2UXCG5Gz9588lCC+22gagHPHSuncAScI
         SO67m5Dco6Lagg1CrQ9lPQMtEsWi9R047jJmsq1ucreQwqWVXI34mP5bodFiB8kvyioe
         yW7rm8ogY+3UHCvBaQw5H1j3FsBngYfvQVl/Gr0tJWjj0aFfS9scdprR1HxrrgT4gI7q
         Ci9EFtGEc6h6wKHWFUHfKTTXWrieNg0YNA7t2cCpfpBx9PlpAzvX8Al+l7Gnm9GBLIja
         14LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711557668; x=1712162468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YMZWWaTaJ3lxeA3Kz3iKtD6XUKMHdnC8EWB2x35/ZWU=;
        b=Hf/rlweyR/CiDVWRR8wIQ5jgDnn2sYlX1YZMS6SKc8VUPc5ov8a3g/ndZbGlOkTv81
         lSFfh/pus3J4Nc+AFbTX1cCoO0iR6DQc+RGd9igxJE5v3FNPz+Xc9Zbdzw9t6/aEYkZr
         /Osa4Ws/hX/zj+6MPHLdCWEFXgA/LJkcYd9lrtBrKy72sLtcVLYkJTalydpF6MU0/dsm
         FHhdS8tq+ZoT8GxVDB6HiZHA2bGKk+fy45srbqXZsHhRjveUr+Jy/NB/IylE80RP2cib
         t4VSygJdm8Qaajj9PDjMa2taOyCpmyxg/6gGwSxxYliGMZfQy9hDV3U3oF95bCeXe+N6
         TiyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfkOEn2y+LjdtoIVxqL94mBgIep6RMkjXyfQPIwCC9K2+8k02DjXTUoWQ+Hk3mVi70PpgBScE38kwk6WH0nu6QxOlkQALoFMe07G8Q
X-Gm-Message-State: AOJu0Yy3yhtm8ALQ5I+mbukuHzz7MGSN0NZACQP0ue//hyiKuDs78sRN
	uu0pqVNOW3CvMVDm31IYfU3LcO3+m4H9r5cWt6/VDU/lcLl+xbPMjHWODcPS65KOFvo9x6pL2KE
	Ow+BHvVUHxLFwZGjonJJS+Ni8NPM=
X-Google-Smtp-Source: AGHT+IEfdLDNpbWNtIYAq0kAU3sG8ft7rxFt6Nf3L/NlFTwxzVHYEkr+dnSwRJ1+e1UAcljWtVgdECbC493hK/wW/9Y=
X-Received: by 2002:a05:6214:b14:b0:690:dc3b:179d with SMTP id
 u20-20020a0562140b1400b00690dc3b179dmr203067qvj.20.1711557667999; Wed, 27 Mar
 2024 09:41:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325235018.2028408-1-yosryahmed@google.com> <20240325235018.2028408-7-yosryahmed@google.com>
In-Reply-To: <20240325235018.2028408-7-yosryahmed@google.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 27 Mar 2024 09:40:57 -0700
Message-ID: <CAKEwX=OMtqFKLRXF5v2P-Z5WEq3x0Tb=6dPKta8uGqi3MXsZEA@mail.gmail.com>
Subject: Re: [RFC PATCH 6/9] mm: zswap: drop support for non-zero same-filled
 pages handling
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 4:50=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> The current same-filled pages handling supports pages filled with any
> repeated word-sized pattern. However, in practice, most of these should
> be zero pages anyway. Other patterns should be nearly as common.

It'd be nice if we can verify this somehow. Maybe hooking bpftrace,
trace_printk, etc. here?

That aside, my intuition is that this is correct too. It's much less
likely to see a non-zero filled page.

>
> Drop the support for non-zero same-filled pages, but keep the names of
> knobs exposed to userspace as "same_filled", which isn't entirely
> inaccurate.
>
> This yields some nice code simplification and enables a following patch
> that eliminates the need to allocate struct zswap_entry for those pages
> completely.
>
> There is also a very small performance improvement observed over 50 runs
> of kernel build test (kernbench) comparing the mean build time on a
> skylake machine when building the kernel in a cgroup v1 container with a
> 3G limit:
>
>                 base            patched         % diff
> real            70.167          69.915          -0.359%
> user            2953.068        2956.147        +0.104%
> sys             2612.811        2594.718        -0.692%
>
> This probably comes from more optimized operations like memchr_inv() and
> clear_highpage(). Note that the percentage of zero-filled pages during

TIL clear_highpage() is a thing :)


> this test was only around 1.5% on average, and was not affected by this
> patch. Practical workloads could have a larger proportion of such pages
> (e.g. Johannes observed around 10% [1]), so the performance improvement
> should be larger.
>
> [1]https://lore.kernel.org/linux-mm/20240320210716.GH294822@cmpxchg.org/
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---
>  mm/zswap.c | 76 ++++++++++++++----------------------------------------
>  1 file changed, 20 insertions(+), 56 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 0fc27ae950c74..413d9242cf500 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -44,8 +44,8 @@
>  **********************************/
>  /* The number of compressed pages currently stored in zswap */
>  atomic_t zswap_stored_pages =3D ATOMIC_INIT(0);
> -/* The number of same-value filled pages currently stored in zswap */
> -static atomic_t zswap_same_filled_pages =3D ATOMIC_INIT(0);
> +/* The number of zero-filled pages currently stored in zswap */
> +static atomic_t zswap_zero_filled_pages =3D ATOMIC_INIT(0);
>
>  /*
>   * The statistics below are not protected from concurrent access for
> @@ -123,9 +123,9 @@ static unsigned int zswap_accept_thr_percent =3D 90; =
/* of max pool size */
>  module_param_named(accept_threshold_percent, zswap_accept_thr_percent,
>                    uint, 0644);
>
> -/* Enable/disable handling non-same-value filled pages (enabled by defau=
lt) */
> -static bool zswap_non_same_filled_pages_enabled =3D true;
> -module_param_named(non_same_filled_pages_enabled, zswap_non_same_filled_=
pages_enabled,
> +/* Enable/disable handling non-zero-filled pages (enabled by default) */
> +static bool zswap_non_zero_filled_pages_enabled =3D true;
> +module_param_named(non_same_filled_pages_enabled, zswap_non_zero_filled_=
pages_enabled,
>                    bool, 0644);
>
>  /* Number of zpools in zswap_pool (empirically determined for scalabilit=
y) */
> @@ -187,11 +187,10 @@ static struct shrinker *zswap_shrinker;
>   *
>   * swpentry - associated swap entry, the offset indexes into the red-bla=
ck tree
>   * length - the length in bytes of the compressed page data.  Needed dur=
ing
> - *          decompression. For a same value filled page length is 0, and=
 both
> + *          decompression. For a zero-filled page length is 0, and both
>   *          pool and lru are invalid and must be ignored.
>   * pool - the zswap_pool the entry's data is in
>   * handle - zpool allocation handle that stores the compressed page data
> - * value - value of the same-value filled pages which have same content
>   * objcg - the obj_cgroup that the compressed memory is charged to
>   * lru - handle to the pool's lru used to evict pages.
>   */
> @@ -199,10 +198,7 @@ struct zswap_entry {
>         swp_entry_t swpentry;
>         unsigned int length;
>         struct zswap_pool *pool;
> -       union {
> -               unsigned long handle;
> -               unsigned long value;
> -       };
> +       unsigned long handle;
>         struct obj_cgroup *objcg;
>         struct list_head lru;
>  };
> @@ -805,7 +801,7 @@ static struct zpool *zswap_find_zpool(struct zswap_en=
try *entry)
>  static void zswap_entry_free(struct zswap_entry *entry)
>  {
>         if (!entry->length)
> -               atomic_dec(&zswap_same_filled_pages);
> +               atomic_dec(&zswap_zero_filled_pages);
>         else {
>                 zswap_lru_del(&zswap_list_lru, entry);
>                 zpool_free(zswap_find_zpool(entry), entry->handle);
> @@ -1377,43 +1373,17 @@ static void shrink_worker(struct work_struct *w)
>         } while (zswap_total_pages() > thr);
>  }
>
> -static bool zswap_is_folio_same_filled(struct folio *folio, unsigned lon=
g *value)
> +static bool zswap_is_folio_zero_filled(struct folio *folio)
>  {
> -       unsigned long *page;
> -       unsigned long val;
> -       unsigned int pos, last_pos =3D PAGE_SIZE / sizeof(*page) - 1;
> +       unsigned long *kaddr;
>         bool ret;
>
> -       page =3D kmap_local_folio(folio, 0);
> -       val =3D page[0];
> -
> -       if (val !=3D page[last_pos]) {
> -               ret =3D false;
> -               goto out;
> -       }
> -
> -       for (pos =3D 1; pos < last_pos; pos++) {
> -               if (val !=3D page[pos]) {
> -                       ret =3D false;
> -                       goto out;
> -               }
> -       }
> -
> -       *value =3D val;
> -       ret =3D true;
> -out:
> -       kunmap_local(page);
> +       kaddr =3D kmap_local_folio(folio, 0);
> +       ret =3D !memchr_inv(kaddr, 0, PAGE_SIZE);
> +       kunmap_local(kaddr);
>         return ret;
>  }
>
> -static void zswap_fill_page(void *ptr, unsigned long value)
> -{
> -       unsigned long *page;
> -
> -       page =3D (unsigned long *)ptr;
> -       memset_l(page, value, PAGE_SIZE / sizeof(unsigned long));
> -}
> -
>  static bool zswap_check_limit(void)
>  {
>         unsigned long cur_pages =3D zswap_total_pages();
> @@ -1437,7 +1407,6 @@ bool zswap_store(struct folio *folio)
>         struct obj_cgroup *objcg =3D NULL;
>         struct mem_cgroup *memcg =3D NULL;
>         struct zswap_entry *entry;
> -       unsigned long value;
>
>         VM_WARN_ON_ONCE(!folio_test_locked(folio));
>         VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
> @@ -1470,14 +1439,13 @@ bool zswap_store(struct folio *folio)
>                 goto reject;
>         }
>
> -       if (zswap_is_folio_same_filled(folio, &value)) {
> +       if (zswap_is_folio_zero_filled(folio)) {
>                 entry->length =3D 0;
> -               entry->value =3D value;
> -               atomic_inc(&zswap_same_filled_pages);
> +               atomic_inc(&zswap_zero_filled_pages);
>                 goto insert_entry;
>         }
>
> -       if (!zswap_non_same_filled_pages_enabled)
> +       if (!zswap_non_zero_filled_pages_enabled)
>                 goto freepage;
>
>         /* if entry is successfully added, it keeps the reference */
> @@ -1532,7 +1500,7 @@ bool zswap_store(struct folio *folio)
>
>  store_failed:
>         if (!entry->length)
> -               atomic_dec(&zswap_same_filled_pages);
> +               atomic_dec(&zswap_zero_filled_pages);
>         else {
>                 zpool_free(zswap_find_zpool(entry), entry->handle);
>  put_pool:
> @@ -1563,7 +1531,6 @@ bool zswap_load(struct folio *folio)
>         struct page *page =3D &folio->page;
>         struct xarray *tree =3D swap_zswap_tree(swp);
>         struct zswap_entry *entry;
> -       u8 *dst;
>
>         VM_WARN_ON_ONCE(!folio_test_locked(folio));
>
> @@ -1573,11 +1540,8 @@ bool zswap_load(struct folio *folio)
>
>         if (entry->length)
>                 zswap_decompress(entry, page);
> -       else {
> -               dst =3D kmap_local_page(page);
> -               zswap_fill_page(dst, entry->value);
> -               kunmap_local(dst);
> -       }
> +       else
> +               clear_highpage(page);
>
>         count_vm_event(ZSWPIN);
>         if (entry->objcg)
> @@ -1679,7 +1643,7 @@ static int zswap_debugfs_init(void)
>         debugfs_create_atomic_t("stored_pages", 0444,
>                                 zswap_debugfs_root, &zswap_stored_pages);
>         debugfs_create_atomic_t("same_filled_pages", 0444,
> -                               zswap_debugfs_root, &zswap_same_filled_pa=
ges);
> +                               zswap_debugfs_root, &zswap_zero_filled_pa=
ges);
>
>         return 0;
>  }
> --
> 2.44.0.396.g6e790dbe36-goog
>

The code itself LGTM, FWIW:

Reviewed-by: Nhat Pham <nphamcs@gmail.com>

