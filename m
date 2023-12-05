Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7EEF8043A4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 01:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234801AbjLEA6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 19:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbjLEA6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 19:58:16 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA634109
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 16:58:20 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-7c513dc5815so1736252241.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 16:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701737900; x=1702342700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m97CsDjIvuM5Yw/O14me8+/R6uFBIRKDK86GXz6XBIc=;
        b=aeLWivWZrYqochOUTKe9jYs67fBz5GrqXCZfQqp2y4gBfFvZP+F8vD2D8FtI66mw0a
         E57KtV5nqNDgZ97E9l+Z4FA8nKP78StPE3g2bH2GG1kYeDPSLR7WpsooM++vEDkeHulZ
         /eOcMdPHpL4e+F3DGr/GwIT9d2MxUn1aLFIZAv6C4Q++UP8+sbBxMjTke+sp1rS0u5Mg
         Lrm9NpeOsgEJhsytcMEC+apvskTmgh0ihPmyiGNbYQVqBzKHPwubaq1cAXq8PqA8NPei
         goFNx6J8VEHeCbvmIoO14qoTlnutPJC4AMRY8P7qPATFVYZ80DPFHLtm/rmHB7RTJLMD
         rPIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701737900; x=1702342700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m97CsDjIvuM5Yw/O14me8+/R6uFBIRKDK86GXz6XBIc=;
        b=B/RFBqbCvC1GUocit2WQMJNrY/L1D88AkC/WEzptuoyzQcvz6IQFjlOOzTcMCKxc6B
         vKUmbotHU/1W14AY5y6A+sLG1kQyJ+XMS15YkPg8qcvLm7rjJY8+wgaQmKW8BtZZt3tW
         Bivoox7qOn7TEUYvqZcjFaD5bJn38huy4Wnec2IaYcCD2iszg8GzJ1ZKIPRo0hKUiQGL
         R/9ZvWVq0PADmHvg0l9gpYxSW24hB3sK2JFG/+iJk9I0y1SNWiPXthyNI2Q9jaDUINoe
         DXB/g5nluw81IrrAPOnhYS/sCWk0JpQEEQ8SIEzHkNFzadatAW0KdblFIZ01OLroZM+9
         m3Yg==
X-Gm-Message-State: AOJu0YwuJ1PqX4NwI0i08erWPnMFwupGjZXodX+PIAYM/olJGUabiFKq
        2MPSQ+xpuzoxvq74JL3mk7o3DBsFAY61ktPDqhs=
X-Google-Smtp-Source: AGHT+IF2q2TWOeMqSOd1vGhXRTy8XjsdY6/XzmUXxY7h4GGg4Ey5kD+gl45fWsULNkFj8TX/YlG/FDEoew2Vr7TxtGI=
X-Received: by 2002:a67:e444:0:b0:464:a39f:c58b with SMTP id
 n4-20020a67e444000000b00464a39fc58bmr595462vsm.62.1701737899771; Mon, 04 Dec
 2023 16:58:19 -0800 (PST)
MIME-Version: 1.0
References: <20231204102027.57185-1-ryan.roberts@arm.com> <20231204102027.57185-3-ryan.roberts@arm.com>
In-Reply-To: <20231204102027.57185-3-ryan.roberts@arm.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Tue, 5 Dec 2023 08:58:07 +0800
Message-ID: <CAGsJ_4yyx2+BZS1-bgbJnYJ+FByrMbOqV_Aa3A-nAm2kUtPk+A@mail.gmail.com>
Subject: Re: [PATCH v8 02/10] mm: Non-pmd-mappable, large folios for folio_add_new_anon_rmap()
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 4, 2023 at 6:20=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> In preparation for supporting anonymous multi-size THP, improve
> folio_add_new_anon_rmap() to allow a non-pmd-mappable, large folio to be
> passed to it. In this case, all contained pages are accounted using the
> order-0 folio (or base page) scheme.
>
> Reviewed-by: Yu Zhao <yuzhao@google.com>
> Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Reviewed-by: Barry Song <v-songbaohua@oppo.com>

> ---
>  mm/rmap.c | 28 ++++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)
>
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 2a1e45e6419f..846fc79f3ca9 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1335,32 +1335,44 @@ void page_add_anon_rmap(struct page *page, struct=
 vm_area_struct *vma,
>   * This means the inc-and-test can be bypassed.
>   * The folio does not have to be locked.
>   *
> - * If the folio is large, it is accounted as a THP.  As the folio
> + * If the folio is pmd-mappable, it is accounted as a THP.  As the folio
>   * is new, it's assumed to be mapped exclusively by a single process.
>   */
>  void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct =
*vma,
>                 unsigned long address)
>  {
> -       int nr;
> +       int nr =3D folio_nr_pages(folio);
>
> -       VM_BUG_ON_VMA(address < vma->vm_start || address >=3D vma->vm_end=
, vma);
> +       VM_BUG_ON_VMA(address < vma->vm_start ||
> +                       address + (nr << PAGE_SHIFT) > vma->vm_end, vma);
>         __folio_set_swapbacked(folio);
> +       __folio_set_anon(folio, vma, address, true);
>
> -       if (likely(!folio_test_pmd_mappable(folio))) {
> +       if (likely(!folio_test_large(folio))) {
>                 /* increment count (starts at -1) */
>                 atomic_set(&folio->_mapcount, 0);
> -               nr =3D 1;
> +               SetPageAnonExclusive(&folio->page);
> +       } else if (!folio_test_pmd_mappable(folio)) {
> +               int i;
> +
> +               for (i =3D 0; i < nr; i++) {
> +                       struct page *page =3D folio_page(folio, i);
> +
> +                       /* increment count (starts at -1) */
> +                       atomic_set(&page->_mapcount, 0);
> +                       SetPageAnonExclusive(page);
> +               }
> +
> +               atomic_set(&folio->_nr_pages_mapped, nr);
>         } else {
>                 /* increment count (starts at -1) */
>                 atomic_set(&folio->_entire_mapcount, 0);
>                 atomic_set(&folio->_nr_pages_mapped, COMPOUND_MAPPED);
> -               nr =3D folio_nr_pages(folio);
> +               SetPageAnonExclusive(&folio->page);
>                 __lruvec_stat_mod_folio(folio, NR_ANON_THPS, nr);
>         }
>
>         __lruvec_stat_mod_folio(folio, NR_ANON_MAPPED, nr);
> -       __folio_set_anon(folio, vma, address, true);
> -       SetPageAnonExclusive(&folio->page);
>  }
>
>  /**
> --
> 2.25.1
>
