Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0ED77BF79
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 20:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjHNSCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 14:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjHNSCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 14:02:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F88EB5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 11:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692036117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y9sMPe+Kwek1Ji2+kkeZXB86uj+BWaugfVuZa/slwSQ=;
        b=GSfLLI1x38VX7Eh4uRTEchfe55Fg73TWhGOHMq0SwuoXNefc2v5cAymseCKBVZfF86cGBJ
        OxTiP55gzsaQx88cCjagUJvG/HzPIFcqq/zig1QOhYAXwUufBpOlufL/DkXZDbHzZV8xsL
        4SLwe6NNs+Qr0KrcNIJjBvCt4kyZLVk=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-Hi7X3PLeOHKKr5knGL6evQ-1; Mon, 14 Aug 2023 14:01:56 -0400
X-MC-Unique: Hi7X3PLeOHKKr5knGL6evQ-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3a76f187051so1038479b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 11:01:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692036115; x=1692640915;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y9sMPe+Kwek1Ji2+kkeZXB86uj+BWaugfVuZa/slwSQ=;
        b=XAWLKiKyOEWz3N2ZG4OH3GglCjjRI0XCNQavDy0o13HHlwWNRUJ9QBuzob7lUyooh/
         SvOjFmIDbMtHf/umxED3PiyqvIRog8sZxmm0CYB8GqHoVST2UiwqxzEvWNbQN3HNk6zH
         KwfBkr4fGGmHFdnUhW8FIAhnIDBSskOU+jLSfYmdedn2tX3fz8gHy3M5ZJdxHKwWTfL7
         BJODY9R1rElnv8tAkFL+IeU2tsawloqynx83saiti9V9256f0eYUXNaVG0bQue9dVDS1
         41RRuylFyKmXftLMUaiaX0cN20+Wc5PKfml7eoHug5WtWa2A8w30LpYSAc6aEc3KtT2B
         S89Q==
X-Gm-Message-State: AOJu0YwbXLrk3+KU2O9ctP2DnTuTwgBqjxldCQgxoL0LgBx+ZWxHmSS8
        MtGL3G4Mx8IM+1aVYjUuvoHUC9l8tBkX2IXvaihfTBtUnPEWc20xV51Eo+sxGwsn5PI3Cg5dl3f
        4QZGV3uvcNqaC9IuPKqjHLUzGwB9LnMJk
X-Received: by 2002:a05:6808:1390:b0:3a7:7366:7523 with SMTP id c16-20020a056808139000b003a773667523mr10518171oiw.3.1692036115519;
        Mon, 14 Aug 2023 11:01:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHEC89SqCMfmgjD5jaRzwwyArD812xaC8JCaUtgl5SkCR9L5tIM/wFASuUWwjGt2+M7L+FuA==
X-Received: by 2002:a05:6808:1390:b0:3a7:7366:7523 with SMTP id c16-20020a056808139000b003a773667523mr10518136oiw.3.1692036115138;
        Mon, 14 Aug 2023 11:01:55 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id e14-20020a05620a12ce00b0076ce477b85dsm3158400qkl.134.2023.08.14.11.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 11:01:54 -0700 (PDT)
Date:   Mon, 14 Aug 2023 14:01:52 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yu Zhao <yuzhao@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        David Hildenbrand <david@redhat.com>,
        Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: [PATCH RFC] mm: Properly document tail pages for compound pages
Message-ID: <ZNpsEN5CPqlVpGHp@x1n>
References: <20230810204944.53471-1-peterx@redhat.com>
 <ZNVaEOmUUM5rR4CA@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZNVaEOmUUM5rR4CA@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 10:43:44PM +0100, Matthew Wilcox wrote:
> On Thu, Aug 10, 2023 at 04:49:44PM -0400, Peter Xu wrote:
> > Tail page struct reuse is over-comlicated.  Not only because we have
> > implicit uses of tail page fields (mapcounts, or private for thp swap
> > support, etc., that we _may_ still use in the page structs, but not obvious
> > the relationship between that and the folio definitions), but also because
> > we have 32/64 bits layouts for struct page so it's unclear what we can use
> > and what we cannot when trying to find a new spot in folio struct.
> 
> I do not like this patch.
> 
> > We also have tricks like page->mapping, where we can reuse only the tail
> > page 1/2 but nothing more than tail page 2.  It is all mostly hidden, until
> > someone starts to read into a VM_BUG_ON_PAGE() of __split_huge_page_tail().
> 
> We can change those BUG_ON if we want to reuse mapping in more tail pages.
> Ask!
> 
> > Let's document it clearly on what we can use and what we can't, with 100%
> > explanations on each of them.  Hopefully this will make:
> 
> The explanations are still very page centric.  I do not like the style
> of them, nor how you explain them.
> 
> > One pitfall is I'll need to split part of the tail page 1 definition into
> > 32/64 bits differently, that introduced some duplications on the fields.
> > But hopefully that's worthwhile as it makes everything crystal clear.  Not
> > to mention that "pitfall" also brings a benefit that we can actually define
> > fields in different order for 32/64 bits when we want.
> 
> No.  This is going to ruin kernel-doc.

My fault. I'll make sure kernel-doc will keep looking sane.

It'll mean that my below trick on separating for 32/64 bits with duplicated
fields will stop working, but I found some other way to represent this.

> 
> > +	/*
> > +	 * Some of the tail page fields (out of 8 WORDs for either 32/64
> 
> There's your first mistake; struct page is not necessarily 8 WORDs.
> You've got 7 words for sure, then on 32-bit you have 8 because atomic_t
> is word-sized.  memcg_data might be the 9th word, virtual could be
> the tenth, two awful kmsan intrusions could bring it to twelve, and
> last_cpupid could bring it to thirteen.
> 
> Sure, it's 8 words on x86-64 with CONFIG_MEMCG enabled.  But that's
> just your system.

True.  I messed up the mapcount/refcount position on 64 bits, sorry.

I hope atomic_t can always be assumed as 4 bytes though, and should hardly
change trivially, so I can still rely upon.

> 
> > +	 * bits archs) may not be reused by the folio object because
> > +	 * they're already been used by the page struct:
> > +	 *
> > +	 * |-------+---------------|
> > +	 * | Index | Field         |
> > +	 * |-------+---------------|
> > +	 * |     0 | flag          |
> > +	 * |     1 | compound_head |
> > +	 * |     2 | N/A [0]       |
> > +	 * |     3 | mapping [1]   |
> > +	 * |     4 | N/A [0]       |
> > +	 * |     5 | private [2]   |
> > +	 * |     6 | mapcount      |
> > +	 * |     7 | N/A [0]       |
> 
> This is wrong.  You mustn't reuse refcount.  refcount must remain 0 on
> all tail pages.  And you can't use anything after refcount, because it's
> all optional on various configurations.

I got the answer in the other thread.  I still don't know a full list of
things that we may require that, the only two things I got now are: (1)
fast-gup over any-sized folio on speculative boosts of refs, and (2) pfn
walkers like has_unmovable_pages().

I'll make an example here describing this, but if anyone can have a full
list of why it must keep zero here I think it'll be great to document all
of them, and this seems to be one of the best places to do it.

> 
> > +	 * |-------+---------------|
> > +	 *
> > +	 * [0] "N/A" marks fields that are available to leverage for the
> > +	 *     large folio.
> 
> N/A is a bad way to say this.  "Free" or "Available" would be better.

Indeed.  I'll choose FREE.

> 
> > +	 * [1] "mapping" field is only used for sanity check, see
> > +	 *     TAIL_MAPPING.  Still valid to use for tail pages 1/2.
> > +	 *     (for that, see __split_huge_page_tail()).
> 
> No, definitely wrong to document this.

I can document it in a "less detailed" way.  I tend to introduce one macro
TAIL_MAPPING_REUSED_MAX=2 and use it in __split_huge_page_tail().

> 
> > +	 * [2] "private" field is used when THP_SWAP is on (disabled on 32
> > +	 *     bits, or on hugetlb folios) .
> 
> Ugh, this needs to be fixed, not documented.  If you really must
> document it, at least say that this needs to be fixed.

Sure.  Any further description on the problem and "a proper fix"?  I will
document that as "may need fixing" for now, but I'd try to reference more
on it if I can understand better on the problem.

> 
> > +	 */
> >  	union {
> >  		struct {
> > +	/* WORD 0-1: not valid to reuse */
> 
> ... so now you're repeating all the information you provided above?

I'll try to remove many of them, but keep some so we read the fields
easier, knowing the offset of the WORD.  I'm still open to remove all of
them if you think that's preferred.

> 
> >  			unsigned long _flags_1;
> >  			unsigned long _head_1;
> > -	/* public: */
> 
> ... did you check kernel-doc after removing this?
> 
> > +	/* WORD 2 */
> >  			unsigned char _folio_dtor;
> >  			unsigned char _folio_order;
> > +			unsigned char _holes_1[2];
> 
> No.  If you need to search for holes, use pahole.

Actually using _holes_* is definitely not right, because holes are
literally free spaces that can be reused.  Here IMHO I should describe it
as two free bytes just like below, and that's one major goal of such a
patch, to be clear on what can be still reused in tail pages.

> 
> > +#ifdef CONFIG_64BIT
> >  			atomic_t _entire_mapcount;
> > +	/* WORD 3 */
> >  			atomic_t _nr_pages_mapped;
> >  			atomic_t _pincount;
> > -#ifdef CONFIG_64BIT
> > +	/* WORD 4 */
> >  			unsigned int _folio_nr_pages;
> > +			unsigned int _reserved_1_1;
> > +	/* WORD 5-6: not valid to reuse */
> > +			unsigned long _used_1_2[2];

(These "_used*" things will go away; I took another trick to represent only
 "free" slots not "used", side effect of making kernel-doc happy)

> > +	/* WORD 7 */
> > +			unsigned long _reserved_1_2;
> > +#else
> > +	/* WORD 3 */
> > +			atomic_t _entire_mapcount;
> > +	/* WORD 4 */
> > +			atomic_t _nr_pages_mapped;
> > +	/* WORD 5: only valid for 32bits */
> > +			atomic_t _pincount;
> > +	/* WORD 6: not valid to reuse */
> > +			unsigned long _used_1_2;
> > +	/* WORD 7 */
> > +			unsigned long _reserved_1;
> >  #endif
> > -	/* private: the union with struct page is transitional */
> >  		};
> > +	/* private: the union with struct page is transitional */
> 
> You don't understand why I did it like this.  Again, you have to build
> the kernel-doc and you'll see why the private: and public: markers are
> where they are.
> 
> There was even a thread on it, a year or two ago, where I outlined the
> various tradeoffs between complexity of the output and the complexity
> of the input.

Links would be appreciated, at the meantime I'll send a rfcv2.  I hope that
addresses most of the issues above while still provide most of what I
wanted to provide; not sure about this last one though before I get more
information.  Let me know if the whole idea just won't work, then I can
always stop.

-- 
Peter Xu

