Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08E77DA108
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 20:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346360AbjJ0SuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 14:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbjJ0SuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 14:50:12 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13238B0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 11:50:07 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1ef370c2e1aso1523598fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 11:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698432606; x=1699037406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rRzJv2xbx4CRjZ9+JI4MEGagQBSoeUXpZmEwiOibrR4=;
        b=RIMYt4L0BOXkXYE8ls9fIj/MucC8kEc6w+1ZzOsPVnvhx5JZlXxOK9kxddlSZ+kxds
         ieZEawuhYhfQnihbM14VV9yEiu9VwOy0QjOfCxHYpXiWjI9w1YVouXwe4BRDCx9/JFaE
         VIe5M0tOZzz0Aom8N32aakYzOaBZ/Ei3eDs2WmKjE4ndl1JGfJSn1xJmgdS9Cs672+k5
         xZR20ttUTdjgiywFKNAb2Yc+3fQjORZWZx8XMmTAvmsDGnFiyK2DFBzGGr7DqQHtSSAB
         wozIelbrwsWbCkgRrrgXR2ytFhXUhn2wO6Qn1VnKW/BKsctI2OVZi5u5sdptQWMU8P5c
         on3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698432606; x=1699037406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rRzJv2xbx4CRjZ9+JI4MEGagQBSoeUXpZmEwiOibrR4=;
        b=l1s3MUPLljyuFTWgyR4mLGbmPZi58mX3p+t+b19MLrENJnTyIIbaZu1a//ZXCrVdbx
         Rhsg5QxKkOFuxQWYmK3sb7A6o/UMz9vXSr/F/lvnxjJm2au5AhFZuuLDSWd/zVe9vjcD
         5Pxig1qKjfrmWGruW3w0H4filAVftZFrQOeVoozIeBaswtgWaP0k2QSKTumVPGDVKadU
         y4YhPhixzDpC/l1c7bGmzHCO+8Hs38xxmBnAV34fbobL20VRteeOA8BdTBGnkMy379VX
         BjU4rOraNYgYoCVgC91Y85MbAY+GnrgBvh9s7zpzKtMpdpFE1G4O97LDXzyQrbXk0I0K
         wwHg==
X-Gm-Message-State: AOJu0Ywvgs9HXS3Tr5wGo+tejOxU8uOl1CUP1RnszFLFoOdv5i6sXCfL
        K6/DbKYRhLf+gcazye9hODuxScGshPfSEy+E5QVGMO1q5a4=
X-Google-Smtp-Source: AGHT+IGEKrtq5L0tp/6ILcXCv2meqDapMsfF3DozAPQsunA8B7ghEFpwqhhRANIlZbVjG8FR9fkheO0/6/aqdeogbQw=
X-Received: by 2002:a05:6870:c18e:b0:1ea:7470:a15c with SMTP id
 h14-20020a056870c18e00b001ea7470a15cmr4213157oad.15.1698432606223; Fri, 27
 Oct 2023 11:50:06 -0700 (PDT)
MIME-Version: 1.0
References: <20231019110543.3284654-1-ryan.roberts@arm.com>
In-Reply-To: <20231019110543.3284654-1-ryan.roberts@arm.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Fri, 27 Oct 2023 11:49:55 -0700
Message-ID: <CAKEwX=PfAMZ2qJtwKwJsVx3TZWxV5z2ZaU1Epk1UD=DBdMsjFA@mail.gmail.com>
Subject: Re: [RFC PATCH v1] mm: zswap: Store large folios without splitting
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
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

On Thu, Oct 19, 2023 at 4:06=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> Previously zswap would refuse to store any folio bigger than order-0,
> and therefore all of those folios would be sent directly to the swap
> file. This is a minor inconvenience since swap can currently only
> support order-0 and PMD-sized THP, but with the pending introduction of
> "small-sized THP", and corresponding changes to swapfile to support any
> order of folio, these large folios will become more prevalent and
> without this zswap change, zswap will become unusable. Independently of
> the "small-sized THP" feature, this change makes it possible to store
> existing PMD-sized THPs in zswap.
>
> Modify zswap_store() to allow storing large folios. The function is
> split into 2 parts; zswap_store() does all the per-folio operations
> (i.e. checking there is enough space, etc). Then it calls a new helper,
> zswap_store_page(), for each page in the folio, which are stored as
> their own entries in the zswap pool. (These entries continue to be
> loaded back individually as single pages). If a store fails for any
> single page, then all previously successfully stored folio pages are
> invalidated.
>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
> I've tested this on arm64 (m2) with zswap enabled, and running
> vm-scalability's `usemem` across multiple cores from within a
> memory-constrained memcg to force high volumes of swap. I've also run mm
> selftests and observe no regressions (although there is nothing [z]swap
> specific there) - does zswap have any specific tests I should run?

There is a zswap kselftest in the cgroup suite:
https://lore.kernel.org/all/20230621153548.428093-1-cerasuolodomenico@gmail=
.com/

Regardless, I feel like this kind of change is probably better to be tested
via stress tests anyway - allocating a bunch of anon memory with a certain
pattern, making sure they're not corrupted after being zswapped out etc.


>
> This is based on mm-stable, since mm-unstable contains a zswap patch
> known to be buggy [1]. I thought it would be best to get comments on the
> shape, then do the rebase after that patch has been fixed.
>
> For context, small-sized THP is being discussed here [2], and I'm
> working on changes to swapfile to support non-PMD-sized large folios
> here [3].
>
> [1] https://lore.kernel.org/linux-mm/21606fe5-fb9b-4d37-98ab-38c96819893b=
@arm.com/
> [2] https://lore.kernel.org/linux-mm/20230929114421.3761121-1-ryan.robert=
s@arm.com/
> [3] https://lore.kernel.org/linux-mm/20231017161302.2518826-1-ryan.robert=
s@arm.com/
>
> Thanks,
> Ryan
>
>
>  mm/zswap.c | 155 +++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 98 insertions(+), 57 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 37d2b1cb2ecb..51cbfc4e1ef8 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1188,18 +1188,17 @@ static void zswap_fill_page(void *ptr, unsigned l=
ong value)
>         memset_l(page, value, PAGE_SIZE / sizeof(unsigned long));
>  }
>
> -bool zswap_store(struct folio *folio)
> +static bool zswap_store_page(struct folio *folio, long index,
> +                            struct obj_cgroup *objcg, struct zswap_pool =
*pool)
>  {
>         swp_entry_t swp =3D folio->swap;
>         int type =3D swp_type(swp);
> -       pgoff_t offset =3D swp_offset(swp);
> -       struct page *page =3D &folio->page;
> +       pgoff_t offset =3D swp_offset(swp) + index;
> +       struct page *page =3D folio_page(folio, index);
>         struct zswap_tree *tree =3D zswap_trees[type];
>         struct zswap_entry *entry, *dupentry;
>         struct scatterlist input, output;
>         struct crypto_acomp_ctx *acomp_ctx;
> -       struct obj_cgroup *objcg =3D NULL;
> -       struct zswap_pool *pool;
>         struct zpool *zpool;
>         unsigned int dlen =3D PAGE_SIZE;
>         unsigned long handle, value;
> @@ -1208,51 +1207,11 @@ bool zswap_store(struct folio *folio)
>         gfp_t gfp;
>         int ret;
>
> -       VM_WARN_ON_ONCE(!folio_test_locked(folio));
> -       VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
> -
> -       /* Large folios aren't supported */
> -       if (folio_test_large(folio))
> -               return false;
> -
> -       if (!zswap_enabled || !tree)
> +       /* entry keeps the references if successfully stored. */
> +       if (!zswap_pool_get(pool))
>                 return false;
> -
> -       /*
> -        * If this is a duplicate, it must be removed before attempting t=
o store
> -        * it, otherwise, if the store fails the old page won't be remove=
d from
> -        * the tree, and it might be written back overriding the new data=
.
> -        */
> -       spin_lock(&tree->lock);
> -       dupentry =3D zswap_rb_search(&tree->rbroot, offset);
> -       if (dupentry) {
> -               zswap_duplicate_entry++;
> -               zswap_invalidate_entry(tree, dupentry);
> -       }
> -       spin_unlock(&tree->lock);
> -
> -       /*
> -        * XXX: zswap reclaim does not work with cgroups yet. Without a
> -        * cgroup-aware entry LRU, we will push out entries system-wide b=
ased on
> -        * local cgroup limits.
> -        */
> -       objcg =3D get_obj_cgroup_from_folio(folio);
> -       if (objcg && !obj_cgroup_may_zswap(objcg))
> -               goto reject;
> -
> -       /* reclaim space if needed */
> -       if (zswap_is_full()) {
> -               zswap_pool_limit_hit++;
> -               zswap_pool_reached_full =3D true;
> -               goto shrink;
> -       }
> -
> -       if (zswap_pool_reached_full) {
> -              if (!zswap_can_accept())
> -                       goto shrink;
> -               else
> -                       zswap_pool_reached_full =3D false;
> -       }
> +       if (objcg)
> +               obj_cgroup_get(objcg);
>
>         /* allocate entry */
>         entry =3D zswap_entry_cache_alloc(GFP_KERNEL);
> @@ -1260,6 +1219,8 @@ bool zswap_store(struct folio *folio)
>                 zswap_reject_kmemcache_fail++;
>                 goto reject;
>         }
> +       entry->objcg =3D objcg;
> +       entry->pool =3D pool;
>
>         if (zswap_same_filled_pages_enabled) {
>                 src =3D kmap_atomic(page);
> @@ -1277,11 +1238,6 @@ bool zswap_store(struct folio *folio)
>         if (!zswap_non_same_filled_pages_enabled)
>                 goto freepage;
>
> -       /* if entry is successfully added, it keeps the reference */
> -       entry->pool =3D zswap_pool_current_get();
> -       if (!entry->pool)
> -               goto freepage;
> -
>         /* compress */
>         acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
>
> @@ -1337,7 +1293,6 @@ bool zswap_store(struct folio *folio)
>         entry->length =3D dlen;
>
>  insert_entry:
> -       entry->objcg =3D objcg;
>         if (objcg) {
>                 obj_cgroup_charge_zswap(objcg, entry->length);
>                 /* Account before objcg ref is moved to tree */
> @@ -1373,19 +1328,105 @@ bool zswap_store(struct folio *folio)
>
>  put_dstmem:
>         mutex_unlock(acomp_ctx->mutex);
> -       zswap_pool_put(entry->pool);
>  freepage:
>         zswap_entry_cache_free(entry);
>  reject:
>         if (objcg)
>                 obj_cgroup_put(objcg);
> +       zswap_pool_put(pool);
>         return false;
> +}
>
> +bool zswap_store(struct folio *folio)
> +{
> +       long nr_pages =3D folio_nr_pages(folio);
> +       swp_entry_t swp =3D folio->swap;
> +       int type =3D swp_type(swp);
> +       pgoff_t offset =3D swp_offset(swp);
> +       struct zswap_tree *tree =3D zswap_trees[type];
> +       struct zswap_entry *entry;
> +       struct obj_cgroup *objcg =3D NULL;
> +       struct zswap_pool *pool;
> +       bool ret =3D false;
> +       long i;
> +
> +       VM_WARN_ON_ONCE(!folio_test_locked(folio));
> +       VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
> +
> +       if (!zswap_enabled || !tree)
> +               return false;
> +
> +       /*
> +        * If this is a duplicate, it must be removed before attempting t=
o store
> +        * it, otherwise, if the store fails the old page won't be remove=
d from
> +        * the tree, and it might be written back overriding the new data=
.
> +        */
> +       spin_lock(&tree->lock);
> +       for (i =3D 0; i < nr_pages; i++) {
> +               entry =3D zswap_rb_search(&tree->rbroot, offset + i);
> +               if (entry) {
> +                       zswap_duplicate_entry++;
> +                       zswap_invalidate_entry(tree, entry);
> +               }
> +       }
> +       spin_unlock(&tree->lock);
> +
> +       /*
> +        * XXX: zswap reclaim does not work with cgroups yet. Without a
> +        * cgroup-aware entry LRU, we will push out entries system-wide b=
ased on
> +        * local cgroup limits.
> +        */
> +       objcg =3D get_obj_cgroup_from_folio(folio);
> +       if (objcg && !obj_cgroup_may_zswap(objcg))
> +               goto put_objcg;

Hmm would this make more sense to check these limits
at a higher order page level or at a backing page (4 KB)
level?

What if the cgroup still has some space before the new
folio comes in, but the new folio would drive the pool size
beyond the limit? Ditto for global zswap pool limit.

Previously, the object size is capped by the size of
a page (since we don't accept bigger size pages into
zswap). If zswap limit is exceded, it will not be exceeded
by more than 4 KB. No big deal. But I'm not sure
this will be OK as we move to bigger and bigger
sizes for the pages...

If we do decide to check the cgroup's zswap limit for
each backing page, I'm not sure how the reclaim logic
(which will be introduced in the cgroup-aware zswap
LRU patch) will interact with this though.

> +
> +       /* reclaim space if needed */
> +       if (zswap_is_full()) {
> +               zswap_pool_limit_hit++;
> +               zswap_pool_reached_full =3D true;
> +               goto shrink;
> +       }
> +
> +       if (zswap_pool_reached_full) {
> +               if (!zswap_can_accept())
> +                       goto shrink;
> +               else
> +                       zswap_pool_reached_full =3D false;
> +       }
> +
> +       pool =3D zswap_pool_current_get();
> +       if (!pool)
> +               goto put_objcg;
> +
> +       /*
> +        * Store each page of the folio as a separate entry. If we fail t=
o store
> +        * a page, unwind by removing all the previous pages we stored.
> +        */
> +       for (i =3D 0; i < nr_pages; i++) {
> +               if (!zswap_store_page(folio, i, objcg, pool)) {
> +                       spin_lock(&tree->lock);
> +                       for (i--; i >=3D 0; i--) {
> +                               entry =3D zswap_rb_search(&tree->rbroot, =
offset + i);
> +                               if (entry)
> +                                       zswap_invalidate_entry(tree, entr=
y);
> +                       }
> +                       spin_unlock(&tree->lock);
> +                       goto put_pool;
> +               }
> +       }
> +
> +       ret =3D true;
> +put_pool:
> +       zswap_pool_put(pool);
> +put_objcg:
> +       if (objcg)
> +               obj_cgroup_put(objcg);
> +       return ret;
>  shrink:
>         pool =3D zswap_pool_last_get();
>         if (pool && !queue_work(shrink_wq, &pool->shrink_work))
>                 zswap_pool_put(pool);
> -       goto reject;
> +       goto put_objcg;
>  }
>
>  bool zswap_load(struct folio *folio)
>
> base-commit: 158978945f3173b8c1a88f8c5684a629736a57ac
> --
> 2.25.1
>
>

I don't see anything else that is obviously wrong with this.
Seems straightforward to me.

But I'm not too super familiar with THP swapping
logic either :) So maybe someone with exposure to both
should take a look too.

And would it make sense to introduce a gate that guard
this so that users can opt-in/opt-out of this new feature,
at least as we experiment more with it to get more
data?
