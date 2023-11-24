Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCAF7F77E6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 16:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345844AbjKXPeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 10:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345746AbjKXPeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 10:34:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D908E19D
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 07:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700840052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ozG2lEKJl9jjPfth2z4nFDkyOFFciaTcIOevz9X1e8c=;
        b=DlrFuL1qLNbpJUYeYhaVe7ZGnMtqq9WPYQzDI132SH8t3bz6hqWapQNdrITbMRi3cDTE+D
        CeGmEuxep7ZM4osL5oOXFukkAl1xdtmdf0Tg5TjyN7+tcq6UjEWPrPT/eD/07m+7dApcz6
        08gb0cFBD7bouRxC3HLwrgJ+KIu2LDw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-CzR3SOhyPT6AxiK8ECB_3A-1; Fri, 24 Nov 2023 10:34:10 -0500
X-MC-Unique: CzR3SOhyPT6AxiK8ECB_3A-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-67a0921b293so4084516d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 07:34:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700840050; x=1701444850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ozG2lEKJl9jjPfth2z4nFDkyOFFciaTcIOevz9X1e8c=;
        b=RJNqvcRJeh8y0mz2r0R6yaUhg3gkIFv5tmv26FqWCNxhtTZqnS4FXjwtg0QLl3fOpT
         /RkySaKZ0EAU8vjWJ3JG3US0e4R4w0stt+h0M0doezkQW4Ep8EHnwhS8QGi29PyF4cQ0
         WW0F/tq5SYjlgrg1RLaz+EBINoFVau0TjrhIX4IP+MyuM4bgjjw2TqPf1W/BN0+El9Nt
         TpJz+0uLAyOCXA8/g6fFo+c6qOJOt/j+zdxFHu4ObisVpHV5ud/19plazznUfuR1ti9V
         FLWLX0ZK0gvw/FOKhYwURZnXL2R/AUDQD7K6cNnCcxKG0yFbhVfbvZ8jasrPLb2AeKzs
         skvg==
X-Gm-Message-State: AOJu0YzV1JlcGXgzbaWRiIvbx5hI0qC/0a9L8hE0kIx6chvQ9QEK7s91
        Ackb+Rcx7C/+opqtC446VAYNOMIo0CW9ohQ4OZsNQjb5vDPzTn6qgQxOncZrU/GgjA93f1a3G+6
        N9cmlRmXnop+0PV/fZdAxSVME
X-Received: by 2002:a05:6214:5845:b0:679:d92e:3915 with SMTP id ml5-20020a056214584500b00679d92e3915mr3426469qvb.6.1700840050263;
        Fri, 24 Nov 2023 07:34:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGvKONDQBUoQiMSxqSvbizULoHuFMqfQOSC8H1FGk9No9YBkdcMBDOGZLBUzauwPsWegc03FQ==
X-Received: by 2002:a05:6214:5845:b0:679:d92e:3915 with SMTP id ml5-20020a056214584500b00679d92e3915mr3426445qvb.6.1700840049922;
        Fri, 24 Nov 2023 07:34:09 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id k14-20020a0cf58e000000b00679ff35c886sm1479472qvm.142.2023.11.24.07.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 07:34:09 -0800 (PST)
Date:   Fri, 24 Nov 2023 10:34:07 -0500
From:   Peter Xu <peterx@redhat.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
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
Subject: Re: [PATCH RFC 04/12] mm: Introduce vma_pgtable_walk_{begin|end}()
Message-ID: <ZWDCb9oKV_kQg2qV@x1n>
References: <20231116012908.392077-1-peterx@redhat.com>
 <20231116012908.392077-5-peterx@redhat.com>
 <874jhb94u2.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <874jhb94u2.fsf@kernel.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 09:32:13AM +0530, Aneesh Kumar K.V wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > Introduce per-vma begin()/end() helpers for pgtable walks.  This is a
> > preparation work to merge hugetlb pgtable walkers with generic mm.
> >
> > The helpers need to be called before and after a pgtable walk, will start
> > to be needed if the pgtable walker code supports hugetlb pages.  It's a
> > hook point for any type of VMA, but for now only hugetlb uses it to
> > stablize the pgtable pages from getting away (due to possible pmd
> > unsharing).
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  include/linux/mm.h |  3 +++
> >  mm/memory.c        | 12 ++++++++++++
> >  2 files changed, 15 insertions(+)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 64cd1ee4aacc..349232dd20fb 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -4154,4 +4154,7 @@ static inline bool pfn_is_unaccepted_memory(unsigned long pfn)
> >  	return range_contains_unaccepted_memory(paddr, paddr + PAGE_SIZE);
> >  }
> >  
> > +void vma_pgtable_walk_begin(struct vm_area_struct *vma);
> > +void vma_pgtable_walk_end(struct vm_area_struct *vma);
> > +
> >  #endif /* _LINUX_MM_H */
> > diff --git a/mm/memory.c b/mm/memory.c
> > index e27e2e5beb3f..3a6434b40d87 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -6180,3 +6180,15 @@ void ptlock_free(struct ptdesc *ptdesc)
> >  	kmem_cache_free(page_ptl_cachep, ptdesc->ptl);
> >  }
> >  #endif
> > +
> > +void vma_pgtable_walk_begin(struct vm_area_struct *vma)
> > +{
> > +	if (is_vm_hugetlb_page(vma))
> > +		hugetlb_vma_lock_read(vma);
> > +}
> >
> 
> That is required only if we support pmd sharing?

Correct.

Note that for this specific gup code path, we're not changing the lock
behavior because we used to call hugetlb_vma_lock_read() the same in
hugetlb_follow_page_mask(), that's also unconditionally.

It make things even more complicated if we see the recent private mapping
change that Rik introduced in bf4916922c.  I think it means we'll also take
that lock if private lock is allocated, but I'm not really sure whether
that's necessary for all pgtable walks, as the hugetlb vma lock is taken
mostly in all walk paths currently, only some special paths take i_mmap
rwsem instead of the vma lock.

Per my current understanding, the private lock was only for avoiding a race
between truncate & zapping.  I had a feeling that maybe there's better way
to do this rather than sticking different functions with the same lock (or,
lock api).

In summary, the hugetlb vma lock is still complicated and may prone to
further refactoring.  But all those needs further investigations.  This
series can be hopefully seen as completely separated from that so far.

Thanks,

-- 
Peter Xu

