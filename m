Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B022D7B6F3E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 19:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbjJCRF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 13:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjJCRF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 13:05:56 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F6BC9
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 10:05:53 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-59f6441215dso14073597b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 10:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696352752; x=1696957552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kE/nyAurwDzdK2tqw1L/eVudIzwCJX4Y+og2uP8HFDs=;
        b=ZEgP3DpzQfb/jvnvFqw6QiH2E/o1akmP5ASc4Ge9y3WR17oUP34VY5vBdnsFfwGfFj
         C3Ibhmh8gBZCw4mJvCfk5A2Hzaew/0flhQAXp5QOyeChx9BXt3pJNNkFuyVQm0faz0Tu
         E8tv+na3D6W0tSnZ+iYimkkysb6SbYVAh8bE+liRkkyXCRdXaj7ScAB/f5bB7SE3r0im
         Rm3EhlAXDf2Ruz+2KCL5awLxZC/1fU3HNRDT0LvUmY3RVppaSZLpsb6jfhY1dnlz0vs9
         Mf+7s46bmw+SXMRhzVIh2D2+TDVQeOqHC545EDXkhGVPv93fpFgDIvY9/m8lSJ6vciMy
         CmvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696352752; x=1696957552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kE/nyAurwDzdK2tqw1L/eVudIzwCJX4Y+og2uP8HFDs=;
        b=iZX0AiUEw2EFgAx3OYfQDJWd2GNAq7INLJATxHClVLpVXxQUePCAQcNtFWtBI7yfOa
         OyJWAyXaYfYJrWfcmSDxJ0rZyztjRlcjY7rH8YdaD9omcZ9eeaedUgcNkuhFtyS7mPcW
         dUUmV11oynTdiIKfaJ8qNJFrUciSR6P0yTr+7QNuQjXAerCtw3TasM4uW4iqQ8HRGvA9
         IjoVlJilwTO6D/oMLZFSrIc7Jo2RIuxEeMWy3mb6crbVwQ5E4+VFDSne6Oa1phlP13bR
         sJrMa7RjdYR8vuNdWLWETpOYWmmfnI5FBWQMYjeKPxIgSjPet083mv9TFFU7mp+W6pOE
         blYA==
X-Gm-Message-State: AOJu0YxMxwplutg96cdW64oBzg27zj16B+qZr6BHgJu+2vG93usQUMI+
        2yNbyRgdLAPv461M68bAKVt9l9Y4UdnP+dwHzL0C1Q==
X-Google-Smtp-Source: AGHT+IFOBTGDr3z17QB1h/c0MEFVwbJHry4jAVb8rptfffIwJ39fp9N6et3l2kKPWmNuGVc3UUb4nugmPHHTo7XY5vw=
X-Received: by 2002:a0d:cf01:0:b0:59b:54b5:7d66 with SMTP id
 r1-20020a0dcf01000000b0059b54b57d66mr164154ywd.34.1696352752406; Tue, 03 Oct
 2023 10:05:52 -0700 (PDT)
MIME-Version: 1.0
References: <20231002142949.235104-1-david@redhat.com> <20231002142949.235104-4-david@redhat.com>
In-Reply-To: <20231002142949.235104-4-david@redhat.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 3 Oct 2023 10:05:39 -0700
Message-ID: <CAJuCfpHKPDzy0Z4a_rm8K=xnNBD9T+Y-cXCBYmQDG+3xinzuOQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] memory: move exclusivity detection in do_wp_page()
 into wp_can_reuse_anon_folio()
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 2, 2023 at 7:29=E2=80=AFAM David Hildenbrand <david@redhat.com>=
 wrote:
>
> Let's clean up do_wp_page() a bit, removing two labels and making it
> a easier to read.
>
> wp_can_reuse_anon_folio() now only operates on the whole folio. Move the
> SetPageAnonExclusive() out into do_wp_page(). No need to do this under
> page lock -- the page table lock is sufficient.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/memory.c | 88 +++++++++++++++++++++++++++--------------------------
>  1 file changed, 45 insertions(+), 43 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 1f0e3317cbdd..512f6f05620e 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3358,6 +3358,44 @@ static vm_fault_t wp_page_shared(struct vm_fault *=
vmf, struct folio *folio)
>         return ret;
>  }
>
> +static bool wp_can_reuse_anon_folio(struct folio *folio,
> +                                   struct vm_area_struct *vma)

Since this function is calling folio_move_anon_rmap(), I would suggest
changing its name to wp_reuse_anon_folio(). This would clarify that
it's actually doing that operation instead of just checking if it's
possible. That would also let us keep unconditional
SetPageAnonExclusive() in it and do that under folio lock like it used
to do (keeping rules simple). Other than that, it looks good to me.

> +{
> +       /*
> +        * We have to verify under folio lock: these early checks are
> +        * just an optimization to avoid locking the folio and freeing
> +        * the swapcache if there is little hope that we can reuse.
> +        *
> +        * KSM doesn't necessarily raise the folio refcount.
> +        */
> +       if (folio_test_ksm(folio) || folio_ref_count(folio) > 3)
> +               return false;
> +       if (!folio_test_lru(folio))
> +               /*
> +                * We cannot easily detect+handle references from
> +                * remote LRU caches or references to LRU folios.
> +                */
> +               lru_add_drain();
> +       if (folio_ref_count(folio) > 1 + folio_test_swapcache(folio))
> +               return false;
> +       if (!folio_trylock(folio))
> +               return false;
> +       if (folio_test_swapcache(folio))
> +               folio_free_swap(folio);
> +       if (folio_test_ksm(folio) || folio_ref_count(folio) !=3D 1) {
> +               folio_unlock(folio);
> +               return false;
> +       }
> +       /*
> +        * Ok, we've got the only folio reference from our mapping
> +        * and the folio is locked, it's dark out, and we're wearing
> +        * sunglasses. Hit it.
> +        */
> +       folio_move_anon_rmap(folio, vma);
> +       folio_unlock(folio);
> +       return true;
> +}
> +
>  /*
>   * This routine handles present pages, when
>   * * users try to write to a shared page (FAULT_FLAG_WRITE)
> @@ -3444,49 +3482,14 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf=
)
>         /*
>          * Private mapping: create an exclusive anonymous page copy if re=
use
>          * is impossible. We might miss VM_WRITE for FOLL_FORCE handling.
> +        *
> +        * If we encounter a page that is marked exclusive, we must reuse
> +        * the page without further checks.
>          */
> -       if (folio && folio_test_anon(folio)) {
> -               /*
> -                * If the page is exclusive to this process we must reuse=
 the
> -                * page without further checks.
> -                */
> -               if (PageAnonExclusive(vmf->page))
> -                       goto reuse;
> -
> -               /*
> -                * We have to verify under folio lock: these early checks=
 are
> -                * just an optimization to avoid locking the folio and fr=
eeing
> -                * the swapcache if there is little hope that we can reus=
e.
> -                *
> -                * KSM doesn't necessarily raise the folio refcount.
> -                */
> -               if (folio_test_ksm(folio) || folio_ref_count(folio) > 3)
> -                       goto copy;
> -               if (!folio_test_lru(folio))
> -                       /*
> -                        * We cannot easily detect+handle references from
> -                        * remote LRU caches or references to LRU folios.
> -                        */
> -                       lru_add_drain();
> -               if (folio_ref_count(folio) > 1 + folio_test_swapcache(fol=
io))
> -                       goto copy;
> -               if (!folio_trylock(folio))
> -                       goto copy;
> -               if (folio_test_swapcache(folio))
> -                       folio_free_swap(folio);
> -               if (folio_test_ksm(folio) || folio_ref_count(folio) !=3D =
1) {
> -                       folio_unlock(folio);
> -                       goto copy;
> -               }
> -               /*
> -                * Ok, we've got the only folio reference from our mappin=
g
> -                * and the folio is locked, it's dark out, and we're wear=
ing
> -                * sunglasses. Hit it.
> -                */
> -               folio_move_anon_rmap(folio, vma);
> -               SetPageAnonExclusive(vmf->page);
> -               folio_unlock(folio);
> -reuse:
> +       if (folio && folio_test_anon(folio) &&
> +           (PageAnonExclusive(vmf->page) || wp_can_reuse_anon_folio(foli=
o, vma))) {
> +               if (!PageAnonExclusive(vmf->page))
> +                       SetPageAnonExclusive(vmf->page);
>                 if (unlikely(unshare)) {
>                         pte_unmap_unlock(vmf->pte, vmf->ptl);
>                         return 0;
> @@ -3494,7 +3497,6 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
>                 wp_page_reuse(vmf);
>                 return 0;
>         }
> -copy:
>         /*
>          * Ok, we need to copy. Oh, well..
>          */
> --
> 2.41.0
>
