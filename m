Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339AF75709B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjGQXjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjGQXjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:39:16 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B4E10C7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:38:51 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-bcb6dbc477eso3819609276.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689637061; x=1692229061;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLu2xhwd4SAqbSYI2ps1VyFCry+LyNldvcwZWPQNIvo=;
        b=xgmV+C3G4eKZrk06U+JRuxOEbOvrN8vsGVx7JH5ITC5xHrh8dYiRF7tBA0EJtNrDP2
         wOqChQD4Jrv4EbshHiPvhsxYuat1xtKSTyUoK8bv/Mwf8W3j50zYsrqP0nm5bwbGZW8l
         bpUdpXg3sWLAOzI0goJtj1gpJ8tIDaKzOBSrYC4SXKq1naWk5HgzCuPjAm7yEXt2z7ct
         eLnrySKUHZmL3iguIw3nA5turmozcLLMv2kKOzdDFs2O+ZKzrWiZIcl4DCjlsVcdQ0/f
         lsZ4XFCgYcb3pH0LH+U+WL7ciZp6yBKJPcDKZZWrT1WkhCS960H684y8mePbsVJneIz9
         +7RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689637061; x=1692229061;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLu2xhwd4SAqbSYI2ps1VyFCry+LyNldvcwZWPQNIvo=;
        b=f0fCpdZJd38Lq1C16QZ9Eo6C5cMWyEjm154gg3l7hJYzmiJAHUNk3h25msnI6l0i5f
         y2iwBAtxJf5sCTGp359O5ZFqJGy6DH9qwLGqjBo6SNBc08ptjzkjicpNIHYJuYnw+LoH
         rcE0dhxlxpPJP9p4xbXW10Znf5E0kWLgEy/8vFRhEeqDoGJ8ytSZWc2AwQZ1F/rgig6T
         N6AftnZfsPlOmwfBAh7ORL9imumH/qW3ie2DD4VWT9adeYN1BUv1m1h8w21vXwZw2eYt
         OlN5ZTgsPFcXD+ypJ5s6dKqxMSsipzPdWKbhhRVm2SgIG4D/zDG5P+vXaPrUwn2uU9WM
         Xz/w==
X-Gm-Message-State: ABy/qLaJg1lTIB/7v2qtvGnIcED1Tk6LrEqvt0YerIosD1WpVc8VCERC
        ek0Z5wrKK9c1pD6WsbVBOvu0Jw==
X-Google-Smtp-Source: APBJJlHbG9lgcp914LKgXhja8Amg4xcjiZMX1if2yS+Nn7RkrbWXjIgJApIlAYuBISZHBJ/wewImPQ==
X-Received: by 2002:a81:4f0c:0:b0:56d:2f9d:42cc with SMTP id d12-20020a814f0c000000b0056d2f9d42ccmr7057474ywb.51.1689637061083;
        Mon, 17 Jul 2023 16:37:41 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d126-20020a0ddb84000000b00577139f85dfsm151563ywe.22.2023.07.17.16.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 16:37:40 -0700 (PDT)
Date:   Mon, 17 Jul 2023 16:37:31 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Ryan Roberts <ryan.roberts@arm.com>
cc:     Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v3 3/4] mm: FLEXIBLE_THP for improved performance
In-Reply-To: <5df787a0-8e69-2472-cdd6-f96a3f7dfaaf@arm.com>
Message-ID: <8bdfd8d8-5662-4615-86dc-d60259bd16d@google.com>
References: <20230714160407.4142030-1-ryan.roberts@arm.com> <20230714161733.4144503-3-ryan.roberts@arm.com> <CAOUHufacQ8Vx9WQ3BVjGGWKGhcRkL7u79UMX=O7oePDwZ0iNxw@mail.gmail.com> <432490d1-8d1e-1742-295a-d6e60a054ab6@arm.com>
 <CAOUHufaDfJwF_-zb6zV5COG-KaaGcSyrNmbaEzaWz2UjcGGgHQ@mail.gmail.com> <5df787a0-8e69-2472-cdd6-f96a3f7dfaaf@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jul 2023, Ryan Roberts wrote:

> >>>> +static int alloc_anon_folio(struct vm_fault *vmf, struct folio **folio)
> >>>> +{
> >>>> +       int i;
> >>>> +       gfp_t gfp;
> >>>> +       pte_t *pte;
> >>>> +       unsigned long addr;
> >>>> +       struct vm_area_struct *vma = vmf->vma;
> >>>> +       int prefer = anon_folio_order(vma);
> >>>> +       int orders[] = {
> >>>> +               prefer,
> >>>> +               prefer > PAGE_ALLOC_COSTLY_ORDER ? PAGE_ALLOC_COSTLY_ORDER : 0,
> >>>> +               0,
> >>>> +       };
> >>>> +
> >>>> +       *folio = NULL;
> >>>> +
> >>>> +       if (vmf_orig_pte_uffd_wp(vmf))
> >>>> +               goto fallback;
> >>>> +
> >>>> +       for (i = 0; orders[i]; i++) {
> >>>> +               addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << orders[i]);
> >>>> +               if (addr >= vma->vm_start &&
> >>>> +                   addr + (PAGE_SIZE << orders[i]) <= vma->vm_end)
> >>>> +                       break;
> >>>> +       }
> >>>> +
> >>>> +       if (!orders[i])
> >>>> +               goto fallback;
> >>>> +
> >>>> +       pte = pte_offset_map(vmf->pmd, vmf->address & PMD_MASK);
> >>>> +       if (!pte)
> >>>> +               return -EAGAIN;
> >>>
> >>> It would be a bug if this happens. So probably -EINVAL?
> >>
> >> Not sure what you mean? Hugh Dickins' series that went into v6.5-rc1 makes it
> >> possible for pte_offset_map() to fail (if I understood correctly) and we have to
> >> handle this. The intent is that we will return from the fault without making any
> >> change, then we will refault and try again.
> > 
> > Thanks for checking that -- it's very relevant. One detail is that
> > that series doesn't affect anon. IOW, collapsing PTEs into a PMD can't
> > happen while we are holding mmap_lock for read here, and therefore,
> > the race that could cause pte_offset_map() on shmem/file PTEs to fail
> > doesn't apply here.
> 
> But Hugh's patches have changed do_anonymous_page() to handle failure from
> pte_offset_map_lock(). So I was just following that pattern. If this really
> can't happen, then I'd rather WARN/BUG on it, and simplify alloc_anon_folio()'s
> prototype to just return a `struct folio *` (and if it's null that means ENOMEM).
> 
> Hugh, perhaps you can comment?

I agree with your use of -EAGAIN there: I find it better to allow for the
possibility, than to go to great effort persuading that it's impossible;
especially because what's possible tomorrow may differ from today.

And notice that, before my changes, there used to be a pmd_trans_unstable()
check above, implying that it is possible for it to fail (for more reasons
than corruption causing pmd_bad()) - one scenario would be that the
pte_alloc() above succeeded *because* someone else had managed to insert
a huge pmd there already (maybe we have MMF_DISABLE_THP but they did not).

But I see from later mail that Yu Zhao now agrees with your -EAGAIN too,
so we are all on the same folio.

Hugh

p.s. while giving opinions, I'm one of those against using "THP" for
large but not pmd-mappable folios; and was glad to see Matthew arguing
the same way when considering THP_SWPOUT in another thread today.
