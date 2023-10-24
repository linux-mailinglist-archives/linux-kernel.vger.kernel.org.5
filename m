Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3027D59DD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 19:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344042AbjJXRlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 13:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344122AbjJXRiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 13:38:07 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60E683
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 10:38:04 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6b1d1099a84so4511480b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 10:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698169084; x=1698773884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g7zN8TITOFW53OV70gZW15XJJiZwhp5pdZptIds+tMc=;
        b=GtSy/i8dDphcrTPGs8l5GfzhsgFSqqNAm6m5aiMKCVcKBc6yVdH5iah1nuROb9yagY
         NvtNTo7UWlJxuyrKYBrOsU/tYFpoy6FvzP7+6yjxyEgmE4KSX1d5dOP5eA3hTaKXOkO1
         E1Y6d481j5sSAhDpfGJydqaJKSEC6lJJ0N3ENIgFNdiCx+lZCFWcM09R/d2EPTxXuZNd
         4YshaUgQKnEIE2A52IGenVJkbICiIMZDQs1wTvFnuaRC01kekSWzN3M2kJpsCEHX42k1
         x4VSnbd7L03z3GbaR2yCy9p+EQzjnzAaBzuRUc8FF1fDCsMdEIj7z26qvzX23bLsOxJz
         j9cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698169084; x=1698773884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g7zN8TITOFW53OV70gZW15XJJiZwhp5pdZptIds+tMc=;
        b=SmEYT3AzqZaQXw+XVEPQiTETrvv5JJuw+KbBfa7vhZ1RPQZP+QJiWaq9xOBzo0b8f5
         Or54SallUIUVlkvQJT8GPuGVXeEivAvX9d0uHPabKGY/F3sov6UiXXVRMuErZ0+N7ul7
         lhOmYFubg6Keu/4tguX4cMc045fraf0j41QZWSyR/ZfzIksl7IUsgQpWMzdAYxt3Hlbd
         h39sXeKOf6KfovWc91TqNRF8aOvXCK+HnzhYa5INEC+OVJIVRYUbC9PIVfLhMlfQc/Ma
         gRKHRJfUcepcRtfvoHKMKTzhqxV0YJMR9GkD7j679Vcqox1Xo8TeWla3VVvUir1Qjazd
         ZA1g==
X-Gm-Message-State: AOJu0YzKqWvlImSocILKIhQtkILyS7yAycvz0sVTUUiFxTqHQq3YVYz3
        4knM59x4bRykMQdKMZNl6RFEPZpsmUFl9GcDhOQr33VK
X-Google-Smtp-Source: AGHT+IGH8x9WV2KFCDlabjXB0cys93DMPBhKOh3cSI9O76HdDAzZbggT47bUR1f0qAzCWvabzQbqFQFRUH4esfQPaVw=
X-Received: by 2002:a05:6a20:12c5:b0:17a:284:de50 with SMTP id
 v5-20020a056a2012c500b0017a0284de50mr4011177pzg.6.1698169084187; Tue, 24 Oct
 2023 10:38:04 -0700 (PDT)
MIME-Version: 1.0
References: <20231020183331.10770-1-vishal.moola@gmail.com> <20231020183331.10770-2-vishal.moola@gmail.com>
In-Reply-To: <20231020183331.10770-2-vishal.moola@gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 24 Oct 2023 10:37:52 -0700
Message-ID: <CAHbLzkphG4XrV91WjeY9fuurTXcCnyev+RKbg+nzZk6hgZ=Kcg@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] mm/khugepaged: Convert __collapse_huge_page_isolate()
 to use folios
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 11:33=E2=80=AFAM Vishal Moola (Oracle)
<vishal.moola@gmail.com> wrote:
>
> Replaces 11 calls to compound_head() with 1, and removes 1348 bytes of
> kernel text.
>
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Reviewed-by: Yang Shi <shy828301@gmail.com>

> ---
>  mm/khugepaged.c | 45 +++++++++++++++++++++++----------------------
>  1 file changed, 23 insertions(+), 22 deletions(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 88433cc25d8a..500756604488 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -542,6 +542,7 @@ static int __collapse_huge_page_isolate(struct vm_are=
a_struct *vma,
>                                         struct list_head *compound_pageli=
st)
>  {
>         struct page *page =3D NULL;
> +       struct folio *folio =3D NULL;
>         pte_t *_pte;
>         int none_or_zero =3D 0, shared =3D 0, result =3D SCAN_FAIL, refer=
enced =3D 0;
>         bool writable =3D false;
> @@ -576,7 +577,8 @@ static int __collapse_huge_page_isolate(struct vm_are=
a_struct *vma,
>                         goto out;
>                 }
>
> -               VM_BUG_ON_PAGE(!PageAnon(page), page);
> +               folio =3D page_folio(page);
> +               VM_BUG_ON_FOLIO(!folio_test_anon(folio), folio);
>
>                 if (page_mapcount(page) > 1) {
>                         ++shared;
> @@ -588,16 +590,15 @@ static int __collapse_huge_page_isolate(struct vm_a=
rea_struct *vma,
>                         }
>                 }
>
> -               if (PageCompound(page)) {
> -                       struct page *p;
> -                       page =3D compound_head(page);
> +               if (folio_test_large(folio)) {
> +                       struct folio *f;
>
>                         /*
>                          * Check if we have dealt with the compound page
>                          * already
>                          */
> -                       list_for_each_entry(p, compound_pagelist, lru) {
> -                               if (page =3D=3D p)
> +                       list_for_each_entry(f, compound_pagelist, lru) {
> +                               if (folio =3D=3D f)
>                                         goto next;
>                         }
>                 }
> @@ -608,7 +609,7 @@ static int __collapse_huge_page_isolate(struct vm_are=
a_struct *vma,
>                  * is needed to serialize against split_huge_page
>                  * when invoked from the VM.
>                  */
> -               if (!trylock_page(page)) {
> +               if (!folio_trylock(folio)) {
>                         result =3D SCAN_PAGE_LOCK;
>                         goto out;
>                 }
> @@ -624,8 +625,8 @@ static int __collapse_huge_page_isolate(struct vm_are=
a_struct *vma,
>                  * but not from this process. The other process cannot wr=
ite to
>                  * the page, only trigger CoW.
>                  */
> -               if (!is_refcount_suitable(page)) {
> -                       unlock_page(page);
> +               if (!is_refcount_suitable(&folio->page)) {
> +                       folio_unlock(folio);
>                         result =3D SCAN_PAGE_COUNT;
>                         goto out;
>                 }
> @@ -634,27 +635,27 @@ static int __collapse_huge_page_isolate(struct vm_a=
rea_struct *vma,
>                  * Isolate the page to avoid collapsing an hugepage
>                  * currently in use by the VM.
>                  */
> -               if (!isolate_lru_page(page)) {
> -                       unlock_page(page);
> +               if (!folio_isolate_lru(folio)) {
> +                       folio_unlock(folio);
>                         result =3D SCAN_DEL_PAGE_LRU;
>                         goto out;
>                 }
> -               mod_node_page_state(page_pgdat(page),
> -                               NR_ISOLATED_ANON + page_is_file_lru(page)=
,
> -                               compound_nr(page));
> -               VM_BUG_ON_PAGE(!PageLocked(page), page);
> -               VM_BUG_ON_PAGE(PageLRU(page), page);
> +               node_stat_mod_folio(folio,
> +                               NR_ISOLATED_ANON + folio_is_file_lru(foli=
o),
> +                               folio_nr_pages(folio));
> +               VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
> +               VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
>
> -               if (PageCompound(page))
> -                       list_add_tail(&page->lru, compound_pagelist);
> +               if (folio_test_large(folio))
> +                       list_add_tail(&folio->lru, compound_pagelist);
>  next:
>                 /*
>                  * If collapse was initiated by khugepaged, check that th=
ere is
>                  * enough young pte to justify collapsing the page
>                  */
>                 if (cc->is_khugepaged &&
> -                   (pte_young(pteval) || page_is_young(page) ||
> -                    PageReferenced(page) || mmu_notifier_test_young(vma-=
>vm_mm,
> +                   (pte_young(pteval) || folio_test_young(folio) ||
> +                    folio_test_referenced(folio) || mmu_notifier_test_yo=
ung(vma->vm_mm,
>                                                                      addr=
ess)))
>                         referenced++;
>
> @@ -668,13 +669,13 @@ static int __collapse_huge_page_isolate(struct vm_a=
rea_struct *vma,
>                 result =3D SCAN_LACK_REFERENCED_PAGE;
>         } else {
>                 result =3D SCAN_SUCCEED;
> -               trace_mm_collapse_huge_page_isolate(page, none_or_zero,
> +               trace_mm_collapse_huge_page_isolate(&folio->page, none_or=
_zero,
>                                                     referenced, writable,=
 result);
>                 return result;
>         }
>  out:
>         release_pte_pages(pte, _pte, compound_pagelist);
> -       trace_mm_collapse_huge_page_isolate(page, none_or_zero,
> +       trace_mm_collapse_huge_page_isolate(&folio->page, none_or_zero,
>                                             referenced, writable, result)=
;
>         return result;
>  }
> --
> 2.40.1
>
