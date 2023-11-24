Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C537F7C99
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 19:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbjKXSQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 13:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjKXSQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 13:16:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7F319A3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 10:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700849801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eg/pahNY1sda15m0S5y8qWCWFh+lk9Yndlzoe9hnA8c=;
        b=F0o8X5Ys5/H19in7q+tRNwpkSKXjckUC9BiG7nwJkoz67LsTkabzDwGGtQHVPrAewMDSNA
        oBlnxZwhZZQePnRHHt3I6simtprG311ypSt86b1P5eu7Y7VHQ7DlgnAZKQVAYk11YhVBhu
        uBjZTeFSuJzpK8/qhSaAPg7CfjK1z54=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-BoflYNN0MC67cM5AiX6VAA-1; Fri, 24 Nov 2023 13:16:39 -0500
X-MC-Unique: BoflYNN0MC67cM5AiX6VAA-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-67a0921b293so4590186d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 10:16:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700849799; x=1701454599;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eg/pahNY1sda15m0S5y8qWCWFh+lk9Yndlzoe9hnA8c=;
        b=cXWA5hElocQg2RD96gibxJ2ITPujt/8L5MAcWsYAubvi8E/oV0qDXCj2qeFAuYmUrv
         nqURYXq4TRjgKyLQ3I0xpIdDutDpYWWtL/hJ5SVHtEk/hmkPyh1aH7Ch40Uv9JF3+TgD
         jNvsJc4gX/dW4QXugaAvp6x8vz/k8lrh8GI6RalpXjrJ2i3WAhvWIGueCnT76/lr51tZ
         J+KzvRWSPULf2uhKXVc0fD3AmMebdVn8NOs3zDdPfUq69ztWpMi8zv6/tskY5+F00qhY
         Cz4/8oL2lhNfRQvz9073tQgsXDA29jpWtYDH5LYHO04xk/yeo2q0cjsuoY4rCfpXIjs/
         qbDw==
X-Gm-Message-State: AOJu0YwGZoI1A0aD3+gHFYt5qcur2GAaNiC6rsxjI8EkuJAezOUGQDu/
        Z4GpbfUcfg0mVqdTQSYQviovvCoHLEgQBdQovEH1NPD20pO0E6u+yAPx0tAJU6FR8tAmL4mHmBJ
        gt1cFZ1UnH+ZuL4HsJrXzOwqa
X-Received: by 2002:a05:6214:2f02:b0:67a:1458:aacd with SMTP id od2-20020a0562142f0200b0067a1458aacdmr3565238qvb.1.1700849799395;
        Fri, 24 Nov 2023 10:16:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJ43dGQneaoWsZVvBliGQZdzl2B0g+563xfr5Uv9AkDlwk6RFuauEFWEn1YHQGStxmMuIbQg==
X-Received: by 2002:a05:6214:2f02:b0:67a:1458:aacd with SMTP id od2-20020a0562142f0200b0067a1458aacdmr3565222qvb.1.1700849799109;
        Fri, 24 Nov 2023 10:16:39 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id cp4-20020ad44ae4000000b0067a154df4cesm747802qvb.70.2023.11.24.10.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 10:16:38 -0800 (PST)
Date:   Fri, 24 Nov 2023 13:16:35 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH RFC 06/12] mm/gup: Drop folio_fast_pin_allowed() in
 hugepd processing
Message-ID: <ZWDog_cz66g38d0I@x1n>
References: <20231116012908.392077-1-peterx@redhat.com>
 <20231116012908.392077-7-peterx@redhat.com>
 <ZVsYMMJpmFV2T/Zc@infradead.org>
 <ZVzT5_3Zn-Y-6xth@x1n>
 <ZV21GCbG48nTLDzn@infradead.org>
 <ZV4co7wcI-_wK91F@x1n>
 <57be0ed0-f1d7-4583-9a5f-3ed7deb0ea97@csgroup.eu>
 <ZV-p7haI5SmIYACs@x1n>
 <1a1cbd2c-ef59-4b73-bffc-a375bf81243c@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1a1cbd2c-ef59-4b73-bffc-a375bf81243c@csgroup.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Christophe, Michael, Aneesh,

[I'll reply altogether here]

On Fri, Nov 24, 2023 at 07:03:11AM +0000, Christophe Leroy wrote:
> I added that code with commit e17eae2b8399 ("mm: pagewalk: fix walk for 
> hugepage tables") because I was getting crazy displays when dumping 
> /sys/kernel/debug/pagetables
> 
> Huge pages can be used for many thing.
> 
> On powerpc 8xx, there are 4 possible page size: 4k, 16k, 512k and 8M.
> Each PGD entry addresses 4M areas, so hugepd is used for anything using 
> 8M pages. Could have used regular page tables instead, but it is not 
> worth allocating a 4k table when the HW will only read first entry.
> 
> At the time being, linear memory mapping is performed with 8M pages, so 
> ptdump_walk_pgd() will walk into huge page directories.
> 
> Also, huge pages can be used in vmalloc() and in vmap(). At the time 
> being we support 512k pages there on the 8xx. 8M pages will be supported 
> once vmalloc() and vmap() support hugepd, as explained in commit 
> a6a8f7c4aa7e ("powerpc/8xx: add support for huge pages on VMAP and VMALLOC")
> 
> So yes as a conclusion hugepd is used outside hugetlbfs, hope it 
> clarifies things.

Yes it does, thanks a lot for all of your replies.

So I think this is what I missed: on Freescale ppc 8xx there's a special
hugepd_populate_kernel() defined to install kernel pgtables for hugepd.
Obviously I didn't check further than hugepd_populate() when I first
looked, and stopped at the first instance of hugepd_populate() definition
on the 64 bits ppc.

For this specific patch: I suppose the change is still all fine to reuse
the fast-gup function, because it is still true when there's a VMA present
(GUP applies only to user mappings, nothing like KASAN should ever pop up).
So AFAIU it's still true that hugepd is only used in hugetlb pages in this
case even for Freescale 8xx, and nothing should yet explode.  So maybe I
can still keep the code changes.

However the comment at least definitely needs fixing (that I'm going to add
some, which hch requested and I agree), that is not yet in the patch I
posted here but I'll refine them locally.

For the whole work: the purpose of it is to start merging hugetlb pgtable
processing with generic mm.  That is my take of previous lsfmm discussions
in the community on how we should move forward with hugetlb in the future,
to avoid code duplications against generic mm.  Hugetlb is kind of blocked
on adding new (especially, large) features in general because of such
complexity.  This is all about that, but a small step towards it.

I see that it seems a trend to make hugepd more general.  Christophe's fix
on dump pgtable is exactly what I would also look for if keep going.  I
hope that's the right way to go.

I'll also need to think more on how this will affect my plan, currently it
seems all fine: I won't ever try to change any kernel mapping specific
code. I suppose any hugetlbfs based test should still cover all codes I
will touch on hugepd.  Then it should just work for kernel mappings on
Freescales; it'll be great if e.g. Christophe can help me double check that
if the series can stablize in a few versions.  If any of you have any hint
on testing it'll be more than welcomed, either specific test case or hints;
currently I'm still at a phase looking for a valid ppc systems - QEMU tcg
ppc64 emulation on x86 is slow enough to let me give up already.

Considering hugepd's specialty in ppc and the possibility that I'll break
it, there's yet another option which is I only apply the new logic into
archs with !ARCH_HAS_HUGEPD.  It'll make my life easier, but that also
means even if my attempt would work out anything new will by default rule
ppc out.  And we'll have a bunch of "#ifdef ARCH_HAS_HUGEPD" in generic
code, which is not preferred either.  For gup, it might be relatively easy
when comparing to the rest. I'm still hesitating for the long term plan.

Please let me know if you have any thoughts on any of above.

Thanks!

-- 
Peter Xu

