Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D849E7F4A2C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344331AbjKVPW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:22:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234695AbjKVPW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:22:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B779ED41
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 07:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700666541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jHf7jc7J8Bv83RTgjktPDmyDKiNjMVCeKkEQ7LZmkKc=;
        b=L+FMgC5Aaw9pf6L3o+76/eGauNJCl1mBqgp/3goyXUkLA8WIs5QS2WX1ARi5N0qVR8BGc1
        jrP9WlAIOC7L4JakJ9GBnfJgL7FwyMd6LIxHT1zEX2xKv3HjgGD25cz/iiId8Aepxp37BW
        uNQcSgCKWOwQqM7D5B0jvm+BAEBdLb4=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-DFcmOlIAM46qhfXRh71zAQ-1; Wed, 22 Nov 2023 10:22:20 -0500
X-MC-Unique: DFcmOlIAM46qhfXRh71zAQ-1
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-581d59ea23dso1612257eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 07:22:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700666540; x=1701271340;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jHf7jc7J8Bv83RTgjktPDmyDKiNjMVCeKkEQ7LZmkKc=;
        b=tNlINmSIBd/qjLdLCCo1aeoPn+w1gONADM5LI0KNggzDE8no9+cBjHbil+KU1ztDiw
         qxmPu2+/fd9ssWbiv2L5hXmHkso9CLLgbQLaaBRPbTBHviSIFiDoPyalEPGNK2UhXBmr
         sDIiJljjf2+wOJR4UF6SU5dq6C+INKPbqFOmNHU3CEPpiRYzrxWlnbOxV9BM70nENS0e
         NJZmayqwVoakctT8U48wYAHSTiEznFFNFKA5zw7wPkxupTqu5Gjh13BCAkaq+jmdxY4q
         67e8k/3bn9goZgqBvRq7nXYeVEXCrFM8PD200h6FF/522K0ZcICtD7KNyup3VbPAgiFG
         89WQ==
X-Gm-Message-State: AOJu0YxpxVCah+TkwFPjT25yBR1yey/X123HBJ9mCA+tHBuGUmC9smuT
        91HswP4r8PdMCi0lar9WX3pcMDZw5BsB5zpBYKkRqNgkM8PhwOd7nh7Kr6Fu8WHeMIrCYgzG1B/
        PtJtyrjw94/8dA1wekgmd8flu
X-Received: by 2002:a05:6820:311:b0:58c:e80a:537d with SMTP id l17-20020a056820031100b0058ce80a537dmr3009151ooe.1.1700666539806;
        Wed, 22 Nov 2023 07:22:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHOaFlUlKMrMvbpX5vlLOYOyqCZqIYmeCKyEeM2CWjyOcsp+BCB1xOxZFIWf6oSiyQQHcWwQQ==
X-Received: by 2002:a05:6820:311:b0:58c:e80a:537d with SMTP id l17-20020a056820031100b0058ce80a537dmr3009114ooe.1.1700666539416;
        Wed, 22 Nov 2023 07:22:19 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id m13-20020a0cbf0d000000b0066d04196c3dsm4941000qvi.49.2023.11.22.07.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 07:22:18 -0800 (PST)
Date:   Wed, 22 Nov 2023 10:22:11 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
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
        linuxppc-dev@lists.ozlabs.org, Mike Rapoport <rppt@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH RFC 06/12] mm/gup: Drop folio_fast_pin_allowed() in
 hugepd processing
Message-ID: <ZV4co7wcI-_wK91F@x1n>
References: <20231116012908.392077-1-peterx@redhat.com>
 <20231116012908.392077-7-peterx@redhat.com>
 <ZVsYMMJpmFV2T/Zc@infradead.org>
 <ZVzT5_3Zn-Y-6xth@x1n>
 <ZV21GCbG48nTLDzn@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZV21GCbG48nTLDzn@infradead.org>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 12:00:24AM -0800, Christoph Hellwig wrote:
> On Tue, Nov 21, 2023 at 10:59:35AM -0500, Peter Xu wrote:
> > > What prevents us from ever using hugepd with file mappings?  I think
> > > it would naturally fit in with how large folios for the pagecache work.
> > > 
> > > So keeping this check and generalizing it seems like the better idea to
> > > me.
> > 
> > But then it means we're still keeping that dead code for fast-gup even if
> > we know that fact..  Or do we have a plan to add that support very soon, so
> > this code will be destined to add back?
> 
> The question wasn't mean retorical - we support arbitrary power of two
> sized folios for the pagepage, what prevents us from using hugepd with
> them right now?

Ah, didn't catch that point previously.  Hugepd is just not used outside
hugetlb right now, afaiu.

For example, __hugepte_alloc() (and that's the only one calls
hugepd_populate()) should be the function to allocate a hugepd (ppc only),
and it's only called in huge_pte_alloc(), which is part of the current
arch-specific hugetlb api.

And generic mm paths don't normally have hugepd handling, afaics.  For
example, page_vma_mapped_walk() doesn't handle hugepd at all unless in
hugetlb specific path.

There're actually (only) two generic mm paths that can handle hugepd,
namely:

  - fast-gup
  - walk_page_*() apis (aka, __walk_page_range())

For fast-gup I think the hugepd code is in use, however for walk_page_*
apis hugepd code shouldn't be reached iiuc as we have the hugetlb specific
handling (walk_hugetlb_range()), so anything within walk_pgd_range() to hit
a hugepd can be dead code to me (but note that this "dead code" is good
stuff to me, if one would like to merge hugetlb instead into generic mm).

This series tries to add slow gup into that list too, so the 3rd one to
support it.  I plan to look more into this area (e.g., __walk_page_range()
can be another good candidate soon).  I'm not sure whether we should teach
the whole mm to understand hugepd yet, but slow gup and __walk_page_range()
does look like good candidates to already remove the hugetlb specific code
paths - slow-gup has average ~add/~del LOCs (which this series does), and
__walk_page_range() can remove some code logically, no harm I yet see.

Indeed above are based on only my code observations, so I'll be more than
happy to be corrected otherwise, as early as possible.

> 
> > The other option is I can always add a comment above gup_huge_pd()
> > explaining this special bit, so that when someone is adding hugepd support
> > to file large folios we'll hopefully not forget it?  But then that
> > generalization work will only happen when the code will be needed.
> 
> If dropping the check is the right thing for now (and I think the ppc
> maintainers and willy as the large folio guy might have a more useful
> opinions than I do), leaving a comment in would be very useful.

Willy is in the loop, and I just notice I didn't really copy ppc list, even
I planned to..  I am adding the list (linuxppc-dev@lists.ozlabs.org) into
this reply.  I'll remember to do so as long as there's a new version.

The other reason I feel like hugepd may or may not be further developed for
new features like large folio is that I saw Power9 started to shift to
radix pgtables, and afaics hugepd is only supported in hash tables
(hugepd_ok()).  But again, I confess I know nothing about Power at all.

Thanks,

-- 
Peter Xu

