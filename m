Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086797F638D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 17:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjKWQGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 11:06:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjKWQGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 11:06:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2BDD43
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 08:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700755611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PBfkuN+8kqgz4YwTIPKlrUbx6SBXFOUPuEOnMG73eBs=;
        b=Qb9/6LIsuEj5O+T/wZ9SCNlujw00fqhfS1cown3/c9RtG1+JzZVB9Tp/sIYKkB/WGyk2W9
        mNekAEgcVnoG5XjPP4lY1Oce+DZetbPf+l9ghO3sUJI1mHXAOyU/xTDbBhvLEn3siifyp7
        FxQRiPNJHb2UwEINYwEVb5nVNaiLLFo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-hdlM9_1cPtWIgmbmiCMmeg-1; Thu, 23 Nov 2023 11:05:46 -0500
X-MC-Unique: hdlM9_1cPtWIgmbmiCMmeg-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-67a05428cceso1915336d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 08:05:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700755545; x=1701360345;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PBfkuN+8kqgz4YwTIPKlrUbx6SBXFOUPuEOnMG73eBs=;
        b=SRqiwncS1XaTp1lstEtPsI0Qi3H/icau1RBLz0/7kVXxGl62aMIyNrkRLdnWf9O/xj
         OUa8hN4ym5JBbcXmbCUWQEntPw/fPxM4emxrGFIbMPNvk9p4K692L/sEChLazQ50APDI
         CE+bbz7W61r3Xjk8ytT90Wwk04Xm3UULB65GbTCZaHuHZvMJ1S2qQx88cp3V2rLKNDAm
         3eBI6aLU7Ttjc2HHCZabQU9nYe+b9dLI1mEvd5zNkPS4P5WH2EMnY9+VOWbafTGo58FI
         uk9wl1BElDGv3s7pIvAgNihdG9vr+yJAFrHsxAq13r/w+j43XIL98T6z9UlVzvazVjAW
         Jgqg==
X-Gm-Message-State: AOJu0YzfjkSxFEo3VFbN4ATq3rhdNY+OgxBYH0VW6+KLRWfnwreEP64G
        +DGCa7dwg21bKt6iQ1nZgG/V5cJRvzrsaAGIpw6Jl0dKJ7O6T+MTJ8NO7cvRKllzuSU0VXIyx4S
        UXjaQFYaXGAav7PbZgqZe/xKi
X-Received: by 2002:a05:6214:7f0:b0:67a:826:df8c with SMTP id bp16-20020a05621407f000b0067a0826df8cmr1824360qvb.3.1700755545591;
        Thu, 23 Nov 2023 08:05:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHceTZsgETgD6TUpriE8C2r98sh9PhkcjYZSjxDYN1lGZlX731umsxtmk6Pc/7HD1TdP38mzQ==
X-Received: by 2002:a05:6214:7f0:b0:67a:826:df8c with SMTP id bp16-20020a05621407f000b0067a0826df8cmr1824326qvb.3.1700755545264;
        Thu, 23 Nov 2023 08:05:45 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id n11-20020ad444ab000000b0067a08bba0bbsm519516qvt.0.2023.11.23.08.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 08:05:45 -0800 (PST)
Date:   Thu, 23 Nov 2023 11:05:42 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Rapoport <rppt@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        James Houghton <jthoughton@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH RFC 01/12] mm/hugetlb: Export
 hugetlbfs_pagecache_present()
Message-ID: <ZV94VsUOE34B1H-i@x1n>
References: <20231116012908.392077-1-peterx@redhat.com>
 <20231116012908.392077-2-peterx@redhat.com>
 <ZV7923j4gQOZYAqe@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZV7923j4gQOZYAqe@infradead.org>
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 11:23:07PM -0800, Christoph Hellwig wrote:
> You're (thankfully) not actually exporting anything, so please
> don't claim that in the subject.

Ah, I'll rename the subject to "mm/hugetlb: Declare
hugetlbfs_pagecache_present() non-static".

> 
> >  pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
> >  		      unsigned long addr, pud_t *pud);
> > +bool hugetlbfs_pagecache_present(struct hstate *h,
> > +				 struct vm_area_struct *vma,
> > +				 unsigned long address);
> 
> Can you just follow the much more readable two tab indent of the
> function above?
> 
> > -static bool hugetlbfs_pagecache_present(struct hstate *h,
> > -			struct vm_area_struct *vma, unsigned long address)
> > +bool hugetlbfs_pagecache_present(struct hstate *h,
> > +				 struct vm_area_struct *vma, unsigned long address)
> 
> Same here.  The new indentation not only is less readable but also
> creates a pointlessly overlong line.

I can easily follow what you suggest for this single patch, but afaict the
kernel doesn't document that in the style guide.

https://www.kernel.org/doc/html/v4.10/process/coding-style.html#functions

And the reality is at least across mm codes it's used in a mixture of ways,
even more than these two major forms of indentations.

To be explicit, I think 2-tab is Vim's default, while this patch follows
Emacs's c-mode default.  It means if this patch indents wrongly, probably
99% of Emacs users are doomed. :(

Before we have a clear and thorough rule over this, shall we just allow
either sane indent to still be accepted?  Or maybe there's some rule that I
have missed?  Personally I actually prefer Emacs's indentations to align
with left bracket, but that's just subjective so doesn't count.

Thanks,

-- 
Peter Xu

