Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80893778279
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 22:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjHJU6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 16:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjHJU6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 16:58:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B950273C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 13:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691701034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c57XtBA66AtpZhTDt6oR9gySLUoblqFZkKBt5oz+BZQ=;
        b=cVisatRB4/yvxp8EwaBuZW0w2FeVyC/KLnBvCLz1IFvXa19/UPpDCZ6IIie0YolNGFq+b0
        bLvd+PQPpOYaT4sdErU+TlUBiI2jT2l7DjHFwxEX35eL90GTiXBAgUN411lih6j1xMdfal
        8fOcwtvDpo2Aa6ar4K8RFHXOtfXHs6E=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-_HFgAOtEPjWaHlTET3ORCw-1; Thu, 10 Aug 2023 16:57:13 -0400
X-MC-Unique: _HFgAOtEPjWaHlTET3ORCw-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-76c7cffef41so31662985a.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 13:57:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691701033; x=1692305833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c57XtBA66AtpZhTDt6oR9gySLUoblqFZkKBt5oz+BZQ=;
        b=NDXqxz61r5IB/3f+5aQ81+E3dD2kbnBN6xWA8Bq+Yh7piS+WdkSmLcWlvCDHf3F6D7
         2Lxmc6K4zsVrl7DFliGkBohhueswq9NMFK398mYLHTrA4lhpnU05+ELar8EQK2mU45Zi
         /Crvy79YxjaemdqQCZ66d/D3CROWNvEZOBR0Br7DGUxG1VB1DMb5y5AwsIRKlG9W133p
         1LWENKhe6KZSP32hOYTTjDsfyZmWX9Ikw2VbV4PxkEEZHGepC1WfEhDoLJFi5YIg91h8
         iXddMzT4mwXNGmjBZD79vAuzYHx2uSX4Yk7ZN41+XzoNdTCK2FA4UUVKPodFzUS3ESG/
         FbrA==
X-Gm-Message-State: AOJu0Yy7ONO0rTxXbX+icOE+MtBkxGw5M5wND5juEoPsg2I4CU4fXRCH
        MVusj1NchJqWIuJ4+fnDCgsmkoipnbh2h4//N6XzwYW1QIse6k9FF7kD65XFkSHuBdIWiXXmK5H
        RRAK2ZxlJ6/kexYAsgbGDR5xo
X-Received: by 2002:a05:620a:31a0:b0:767:346c:4b37 with SMTP id bi32-20020a05620a31a000b00767346c4b37mr4390975qkb.7.1691701033209;
        Thu, 10 Aug 2023 13:57:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFy2ZcN8TgfL1/LVy5I3Vmk2HDJjfFr+opHM9AF0KOIf/olK85CZeVLDi0THySO2F2YMshvqg==
X-Received: by 2002:a05:620a:31a0:b0:767:346c:4b37 with SMTP id bi32-20020a05620a31a000b00767346c4b37mr4390952qkb.7.1691701032833;
        Thu, 10 Aug 2023 13:57:12 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id a2-20020a05620a102200b007671678e325sm744131qkk.88.2023.08.10.13.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 13:57:12 -0700 (PDT)
Date:   Thu, 10 Aug 2023 16:57:11 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH mm-unstable v1] mm: add a total mapcount for large folios
Message-ID: <ZNVPJ9xxd2oarR3I@x1n>
References: <20230809083256.699513-1-david@redhat.com>
 <ZNQD4pxo8svpGmvX@x1n>
 <e5e29217-11d3-a84b-9e29-44acc72222f3@redhat.com>
 <155bd03e-b75c-4d2d-a89d-a12271ada71b@arm.com>
 <ZNUbNDiciFefJngZ@x1n>
 <db3c4d94-a0a9-6703-6fe0-e1b8851e531f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <db3c4d94-a0a9-6703-6fe0-e1b8851e531f@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 07:47:35PM +0200, David Hildenbrand wrote:
> On 10.08.23 19:15, Peter Xu wrote:
> > On Thu, Aug 10, 2023 at 11:48:27AM +0100, Ryan Roberts wrote:
> > > > For PTE-mapped THP, it might be a bit bigger noise, although I doubt it is
> > > > really significant (judging from my experience on managing PageAnonExclusive
> > > > using set_bit/test_bit/clear_bit when (un)mapping anon pages).
> > > > 
> > > > As folio_add_file_rmap_range() indicates, for PTE-mapped THPs we should be
> > > > batching where possible (and Ryan is working on some more rmap batching).
> > > 
> > > Yes, I've just posted [1] which batches the rmap removal. That would allow you
> > > to convert the per-page atomic_dec() into a (usually) single per-large-folio
> > > atomic_sub().
> > > 
> > > [1] https://lore.kernel.org/linux-mm/20230810103332.3062143-1-ryan.roberts@arm.com/
> > 
> > Right, that'll definitely make more sense, thanks for the link; I'd be very
> > happy to read more later (finally I got some free time recently..).  But
> > then does it mean David's patch can be attached at the end instead of
> > proposed separately and early?
> 
> Not in my opinion. Batching rmap makes sense even without this change, and
> this change makes sense even without batching.
> 
> > 
> > I was asking mostly because I read it as a standalone patch first, and
> > honestly I don't know the effect.  It's based on not only the added atomic
> > ops itself, but also the field changes.
> > 
> > For example, this patch moves Hugh's _nr_pages_mapped into the 2nd tail
> > page, I think it means for any rmap change of any small page of a huge one
> > we'll need to start touching one more 64B cacheline on x86.  I really have
> > no idea what does it mean for especially a large SMP: see 292648ac5cf1 on
> > why I had an impression of that.  But I've no enough experience or clue to
> > prove it a problem either, maybe would be interesting to measure the time
> > needed for some pte-mapped loops?  E.g., something like faulting in a thp,
> 
> Okay, so your speculation right now is:
> 
> 1) The change in cacheline might be problematic.
> 
> 2) The additional atomic operation might be problematic.
> 
> > then measure the split (by e.g. mprotect() at offset 1M on a 4K?) time it
> > takes before/after this patch.
> 
> I can certainly try getting some numbers on that. If you're aware of other
> micro-benchmarks that would likely notice slower pte-mapping of THPs, please
> let me know.

Thanks.

> 
> > 
> > When looking at this, I actually found one thing that is slightly
> > confusing, not directly relevant to your patch, but regarding the reuse of
> > tail page 1 on offset 24 bytes.  Current it's Hugh's _nr_pages_mapped,
> > and you're proposing to replace it with the total mapcount:
> > 
> >          atomic_t   _nr_pages_mapped;     /*    88     4 */
> > 
> > Now my question is.. isn't byte 24 of tail page 1 used for keeping a
> > poisoned mapping?  See prep_compound_tail() where it has:
> > 
> > 	p->mapping = TAIL_MAPPING;
> > 
> > While here mapping is, afaict, also using offset 24 of the tail page 1:
> > 
> >          struct address_space * mapping;  /*    24     8 */
> > 
> > I hope I did a wrong math somewhere, though.
> > 
> 
> I think your math is correct.
> 
> prep_compound_head() is called after prep_compound_tail(), so
> prep_compound_head() wins.
> 
> In __split_huge_page_tail() there is a VM_BUG_ON_PAGE() that explains the
> situation:
> 
> /* ->mapping in first and second tail page is replaced by other uses */
> VM_BUG_ON_PAGE(tail > 2 && page_tail->mapping != TAIL_MAPPING,
> 	       page_tail);
> 
> Thanks for raising that, I had to look into that myself.

It's so confusing so I did try to document them a bit myself, then I found
maybe I should just post a patch for it and I just did:

https://lore.kernel.org/r/20230810204944.53471-1-peterx@redhat.com

It'll conflict with yours, but I marked RFC so it's never anything urgent,
but maybe that'll be helpful already for you to introduce any new fields
like total_mapcounts.

AFAICS if that patch was all correct (while I'm not yet sure..), you can
actually fit your new total mapcount field into page 1 so even avoid the
extra cacheline access.  You can have a look: the trick is refcount for
tail page 1 is still seems to be free on 32 bits (if that was your worry
before).  Then it'll be very nice if to keep Hugh's counter all in tail 1.

-- 
Peter Xu

