Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32195782EC1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 18:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236744AbjHUQtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 12:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjHUQtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:49:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248B2113
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692636504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FfO9iw8ZrQkMAkZ0ZI6xh3gNXetrFGiLWgqaCN9zzcI=;
        b=KFNULy/fPft71+TYeo9DTp9GOZizkSt2R+DGj1zKECIB4COLuvKW5v0CNY9fjgVyp3EidG
        yf2t/4yDI0zsiJAULW9WkEvEjzGgZC+ZrgYX2LSdUasYJvB4CJgofWJVRrQhWwlzLpF4Sb
        xnoCmL2piT8TF0RXnEtsPW1FqAqRHM8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-1PzlNsr-NBqafh2Ua13P9Q-1; Mon, 21 Aug 2023 12:48:20 -0400
X-MC-Unique: 1PzlNsr-NBqafh2Ua13P9Q-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-76da784987aso30248985a.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:48:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692636500; x=1693241300;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FfO9iw8ZrQkMAkZ0ZI6xh3gNXetrFGiLWgqaCN9zzcI=;
        b=H5lZ2PwtZELZl/oS91t/+C5a8CFvYqD6mvC9MOVYJ6Zz9ZFyIl8RhXlSqXywxX+SPt
         4oFoU6mEgHeJNwlPawQBZiwpsb8h5vNKRWNETLv9vbQ/kOSEGVoMwCsRMFNnps6COmJd
         CMp/n2iLgODNycsL9Bee54tvyVjv04HFuJ4jHtxZJgv7Un1INbBgDgvO3S1tMoXOlduj
         UNfq3DaE5AmVww1ORgtR4WV3ja6S49syTDny/vzDzR8MCT0Ort7fMFiX8IPYDQ84ZIC6
         kuL09sLf5YJlkESPuKIe4UOopKQmC6LUW8O8sCy0a+3gWVrtRDGP7WA6dfQf4CRP/DyS
         dLLA==
X-Gm-Message-State: AOJu0YzRx8VbnFqAVzSLEAlTVurJVbuMHc2bBSh2+vHj39/e1aMT0STb
        8lBw1lRicqBJdBufYy4ZYLCSSA2GbHT9tbbGOtmJ4l5drxdZ7RJLkt7YaVeclYzpbkJ5pe6ftIH
        Ri+VJ0Rp9AAVck8zYNCHUCIiS
X-Received: by 2002:a05:620a:1a1c:b0:76d:95d3:800f with SMTP id bk28-20020a05620a1a1c00b0076d95d3800fmr9787866qkb.3.1692636500233;
        Mon, 21 Aug 2023 09:48:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgc1yyExO/s4EFGIm8G5RpBPVJ+Kir8Jj4F40Wb4rI0lKlydsyKeJCPBf2UbuvMaXVgJ0CpA==
X-Received: by 2002:a05:620a:1a1c:b0:76d:95d3:800f with SMTP id bk28-20020a05620a1a1c00b0076d95d3800fmr9787854qkb.3.1692636499934;
        Mon, 21 Aug 2023 09:48:19 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id h27-20020a05620a10bb00b0076cda7eab11sm2566443qkk.133.2023.08.21.09.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 09:48:19 -0700 (PDT)
Date:   Mon, 21 Aug 2023 12:48:18 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yang Shi <shy828301@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: Wire up tail page poisoning over ->mappings
Message-ID: <ZOOVUgsCcLx2ZxtI@x1n>
References: <20230815210659.430010-1-peterx@redhat.com>
 <ZN/tRLy0e+Iod9z3@casper.infradead.org>
 <ZOK6U4vOFn8IbcGp@x1n>
 <ZOLL7f+Ihc93lyo0@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZOLL7f+Ihc93lyo0@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 03:29:01AM +0100, Matthew Wilcox wrote:
> On Sun, Aug 20, 2023 at 09:13:55PM -0400, Peter Xu wrote:
> > > https://lore.kernel.org/linux-mm/ZNp7yUgUrIpILnXu@casper.infradead.org/
> > 
> > https://lore.kernel.org/linux-mm/ZNqFv0AwkfDKExiw@x1n/#t
> > 
> > Firstly, I've answered and you didn't follow that up.
> 
> I didn't see it.  I get a lot of email ...
> 
> > > > More importantly, I think this is over-parametrisation.  If you start to
> > > > use extra fields in struct folio, just change the code in page_alloc.c
> > > > directly.
> > 
> > Change the hard-coded "2"s in different functions?  Can you kindly explain
> > why can't we just have a macro to help?
> 
> Because it's unnecessary.  You're putting in way too much effort here
> for something that might happen once.
> 
> > Setting tail mapping for tail 1/2 is even wrong, which part of this patch
> > fixes:
> > 
> > @@ -428,7 +428,8 @@ static inline void prep_compound_tail(struct page *head, int tail_idx)
> >  {
> >         struct page *p = head + tail_idx;
> > 
> > -       p->mapping = TAIL_MAPPING;
> > +       if (tail_idx > TAIL_MAPPING_REUSED_MAX)
> > +               p->mapping = TAIL_MAPPING;
> >         set_compound_head(p, head);
> >         set_page_private(p, 0);
> >  }
> 
> I didn't see this.  This is wrong.  tail->mapping is only reused for
> large rmappable pages.  It's not reused for other compound pages.

Just to make sure we're on the same page: I think it's not only
_deferred_list (of tail page 2) that reused the mapping field (word offset
3), but also _nr_pages_mapped (of tail page 1)?

> 
> If you really insist on cleaning this up, the special casing of tail pages
> should move out of page_alloc entirely.  folio_undo_large_rmappable()
> should restore TAIL_MAPPING for all tail pages that were modified by
> folio_prep_large_rmappable().
> 
> The other thing we should do is verify that the additional large-rmap
> fields have the correct values in folio_undo_large_rmappable().
> 
> But let's look back to why TAIL_MAPPING was introduced.  Commit
> 1c290f642101e poisoned tail->mapping to catch users which forgot to
> call compound_head().  So we can actually remove TAIL_MAPPING entirely
> if we get rid of page->mapping.
> 
> You probably think that's an unattainable goal; there are something like
> 340 occurrences of the string 'page->mapping' in the kernel right now
> (and there are probably instances of struct page named something other
> than 'page'), but a lot of those are actually in comments, which would
> be my fault for not fixing them during folio conversions.
> 
> However, I have a small patch series which enables 'allnoconfig' to
> build after renaming page->mapping to page->_mapping.  Aside from fs/
> there are *very* few places which look at page->mapping [1].  I'll post
> that patch series tomorrow.

Assuming it's still not yet posted; I can wait and read it.

If you plan to remove the whole TAIL_MAPPING in a few days then I agree
this patch is not needed, but so far I don't know when it'll land and also
why, before that it does sound like we can still keep this patch.

Regarding the question on "why removing TAIL_MAPPING": poisoning an unused
field is always helpful to me even if not referenced with "page->mapping".
So I don't see an immediate benefit from removing the poisoning if it's
already there; OTOH not sure whether poison more unused fields will be more
helpful in general?

> 
> I think with some serious work, we can land "remove page->mapping"
> (which would include removing TAIL_MAPPING) by the end of the year.
> And that work gets us closer to the goal of shrinking struct page.
> 
> [1] device-dax, intel_th, mthca, cortina, fb_defio

Thanks,

-- 
Peter Xu

