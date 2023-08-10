Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32477782CC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 23:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjHJVny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 17:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjHJVnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 17:43:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDD4272C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 14:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cfv6u3KXjLTD2Hyi3b7y8e+BLY07iCzMi/8rXJR4Pck=; b=RgqS/6bTSStFoDDUNWeTP328tm
        shlFBhKxpBFHIATWUpOvy7PgueAx2rnvy6JCFgeCQtNKq0gWo7jWh6q51miPUODvG6rwhu4XMiYKi
        EkV7wq22eprurTZJf/nf0VfcqJzzI3L13O1a4nU/OLeXcvTDvh1ztgEoBSwRfPiLtuYwMvlvFdHnm
        jYd1xQ7R0izBtwhTwmluWPobNCKq8Hgi5fr0vmwMwDE271TP98IKfaGxaVkEouazgT7ZzNHzWAK9P
        b6sje6dGQm0p9s00ZYY8wAkCAWE+TaCGy0M1lBiQWEhsnCGiAJHNHKz5kIDGgbG7sPmqGsjNnfytH
        FnZgXtSQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qUDRY-00EspT-AN; Thu, 10 Aug 2023 21:43:44 +0000
Date:   Thu, 10 Aug 2023 22:43:44 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Peter Xu <peterx@redhat.com>
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
Message-ID: <ZNVaEOmUUM5rR4CA@casper.infradead.org>
References: <20230810204944.53471-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810204944.53471-1-peterx@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 04:49:44PM -0400, Peter Xu wrote:
> Tail page struct reuse is over-comlicated.  Not only because we have
> implicit uses of tail page fields (mapcounts, or private for thp swap
> support, etc., that we _may_ still use in the page structs, but not obvious
> the relationship between that and the folio definitions), but also because
> we have 32/64 bits layouts for struct page so it's unclear what we can use
> and what we cannot when trying to find a new spot in folio struct.

I do not like this patch.

> We also have tricks like page->mapping, where we can reuse only the tail
> page 1/2 but nothing more than tail page 2.  It is all mostly hidden, until
> someone starts to read into a VM_BUG_ON_PAGE() of __split_huge_page_tail().

We can change those BUG_ON if we want to reuse mapping in more tail pages.
Ask!

> Let's document it clearly on what we can use and what we can't, with 100%
> explanations on each of them.  Hopefully this will make:

The explanations are still very page centric.  I do not like the style
of them, nor how you explain them.

> One pitfall is I'll need to split part of the tail page 1 definition into
> 32/64 bits differently, that introduced some duplications on the fields.
> But hopefully that's worthwhile as it makes everything crystal clear.  Not
> to mention that "pitfall" also brings a benefit that we can actually define
> fields in different order for 32/64 bits when we want.

No.  This is going to ruin kernel-doc.

> +	/*
> +	 * Some of the tail page fields (out of 8 WORDs for either 32/64

There's your first mistake; struct page is not necessarily 8 WORDs.
You've got 7 words for sure, then on 32-bit you have 8 because atomic_t
is word-sized.  memcg_data might be the 9th word, virtual could be
the tenth, two awful kmsan intrusions could bring it to twelve, and
last_cpupid could bring it to thirteen.

Sure, it's 8 words on x86-64 with CONFIG_MEMCG enabled.  But that's
just your system.

> +	 * bits archs) may not be reused by the folio object because
> +	 * they're already been used by the page struct:
> +	 *
> +	 * |-------+---------------|
> +	 * | Index | Field         |
> +	 * |-------+---------------|
> +	 * |     0 | flag          |
> +	 * |     1 | compound_head |
> +	 * |     2 | N/A [0]       |
> +	 * |     3 | mapping [1]   |
> +	 * |     4 | N/A [0]       |
> +	 * |     5 | private [2]   |
> +	 * |     6 | mapcount      |
> +	 * |     7 | N/A [0]       |

This is wrong.  You mustn't reuse refcount.  refcount must remain 0 on
all tail pages.  And you can't use anything after refcount, because it's
all optional on various configurations.

> +	 * |-------+---------------|
> +	 *
> +	 * [0] "N/A" marks fields that are available to leverage for the
> +	 *     large folio.

N/A is a bad way to say this.  "Free" or "Available" would be better.

> +	 * [1] "mapping" field is only used for sanity check, see
> +	 *     TAIL_MAPPING.  Still valid to use for tail pages 1/2.
> +	 *     (for that, see __split_huge_page_tail()).

No, definitely wrong to document this.

> +	 * [2] "private" field is used when THP_SWAP is on (disabled on 32
> +	 *     bits, or on hugetlb folios) .

Ugh, this needs to be fixed, not documented.  If you really must
document it, at least say that this needs to be fixed.

> +	 */
>  	union {
>  		struct {
> +	/* WORD 0-1: not valid to reuse */

... so now you're repeating all the information you provided above?

>  			unsigned long _flags_1;
>  			unsigned long _head_1;
> -	/* public: */

... did you check kernel-doc after removing this?

> +	/* WORD 2 */
>  			unsigned char _folio_dtor;
>  			unsigned char _folio_order;
> +			unsigned char _holes_1[2];

No.  If you need to search for holes, use pahole.

> +#ifdef CONFIG_64BIT
>  			atomic_t _entire_mapcount;
> +	/* WORD 3 */
>  			atomic_t _nr_pages_mapped;
>  			atomic_t _pincount;
> -#ifdef CONFIG_64BIT
> +	/* WORD 4 */
>  			unsigned int _folio_nr_pages;
> +			unsigned int _reserved_1_1;
> +	/* WORD 5-6: not valid to reuse */
> +			unsigned long _used_1_2[2];
> +	/* WORD 7 */
> +			unsigned long _reserved_1_2;
> +#else
> +	/* WORD 3 */
> +			atomic_t _entire_mapcount;
> +	/* WORD 4 */
> +			atomic_t _nr_pages_mapped;
> +	/* WORD 5: only valid for 32bits */
> +			atomic_t _pincount;
> +	/* WORD 6: not valid to reuse */
> +			unsigned long _used_1_2;
> +	/* WORD 7 */
> +			unsigned long _reserved_1;
>  #endif
> -	/* private: the union with struct page is transitional */
>  		};
> +	/* private: the union with struct page is transitional */

You don't understand why I did it like this.  Again, you have to build
the kernel-doc and you'll see why the private: and public: markers are
where they are.

There was even a thread on it, a year or two ago, where I outlined the
various tradeoffs between complexity of the output and the complexity
of the input.
