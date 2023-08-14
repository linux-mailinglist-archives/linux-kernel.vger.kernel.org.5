Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743DB77C3BE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 01:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbjHNXCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 19:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbjHNXBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 19:01:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5095D170B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 16:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=f8o/psJ0TXPeTYoQOnqypZJbdp1Q5AMgt88myFFBs/4=; b=eMEuDRJlcFMvVBNtt4Z5j0lGUb
        7UVx4aDbQvcqNcYhZcxv4BJBZbr2AagsRFMGIsMFSwKeM6yKitzcnmk4LSW6HhV3LG4cYZHdsJK/9
        rCMy2g95xPX/oiTUmgyrMQKUgvP447KJwd0xKdV3TqGLmDcZ4eSvKPfdfTpGzKxaq2eKbKxcwUCgH
        l8vMnHuuCFlhqHkS0jIl22tVhPd0bj6824xGB1nNdzffJUopArf1MXvSwd8CK5IEI7cFf5E3E055M
        EbqNl1+zv/zArNiixUhzp/GqezBG7b646vqP9XuUDJtozXjKuytiDOoUa+NAHmh7QEWDpgkVho0fl
        CIkiMTow==;
Received: from [2601:1c2:980:9ec0::577]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qVgYx-004hU2-T4; Mon, 14 Aug 2023 23:01:28 +0000
Message-ID: <2a7cac4c-a97e-92e2-56db-9429105d7a83@infradead.org>
Date:   Mon, 14 Aug 2023 16:01:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH RFC v2 3/3] mm: Proper document tail pages fields for
 folio
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
References: <20230814184411.330496-1-peterx@redhat.com>
 <20230814184411.330496-4-peterx@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230814184411.330496-4-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 8/14/23 11:44, Peter Xu wrote:
> Tail page struct reuse is over-comlicated.  Not only because we have
> implicit uses of tail page fields (mapcounts, or private for thp swap
> support, etc., that we _may_ still use in the page structs, but not obvious
> the relationship between that and the folio definitions), but also because
> we have 32/64 bits layouts for struct page so it's unclear what we can use
> and what we cannot when trying to find a new spot in folio struct.
> 
> We also have tricks like page->mapping, where we can reuse only the tail
> page 1/2 but nothing more than tail page 2.  It is all mostly hidden, until
> someone starts to read into a VM_BUG_ON_PAGE() of __split_huge_page_tail().
> 
> It's also unclear on how many fields we can reuse for a tail page.  The
> real answer is (after help from Matthew): we have 7 WORDs guaranteed on 64
> bits and 8 WORDs on 32 bits.  Nothing more than that is guaranteed to even
> exist.
> 
> Let's document it clearly on what we can use and what we can't when
> extending folio on reusing tail page fields, with 100% explanations on each
> of them.  Hopefully after the doc update it will make it easier when:
> 
>    (1) Any reader to know exactly what field is where and for what, the
>        relationships between folio tail pages and struct page definitions,
> 
>    (2) Any potential new fields to be added to a large folio, so we're clear
>        which field one can still reuse.
> 
> This is assuming WORD is defined as sizeof(void *) on any archs, just like
> the other comment in struct page we already have.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   include/linux/mm_types.h | 41 ++++++++++++++++++++++++++++++++++------
>   1 file changed, 35 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 829f5adfded1..9c744f70ae84 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -322,11 +322,40 @@ struct folio {
>   		};
>   		struct page page;
>   	};
> +	/*
> +	 * Some of the tail page fields may not be reused by the folio
> +	 * object because they're already been used by the page struct.  On

	                  they have

> +	 * 32bits there're at least 8 WORDs while on 64 bits there're at

preferably s/there're/there are/

> +	 * least 7 WORDs:
> +	 *
> +	 * |--------+-------------+-------------------|
> +	 * |  index | 32 bits     | 64 bits           |
> +	 * |--------+-------------+-------------------|
> +	 * |      0 | flags       | flags             |
> +	 * |      1 | head        | head              |
> +	 * |      2 | FREE        | FREE              |
> +	 * |      3 | FREE [1]    | FREE [1]          |
> +	 * |      4 | FREE        | FREE              |
> +	 * |      5 | FREE        | private [2]       |
> +	 * |      6 | mapcnt      | mapcnt+refcnt [3] |
> +	 * |      7 | refcnt [3]  |                   |
> +	 * |--------+-------------+-------------------|
> +	 *
> +	 * [1] "mapping" field.  It is free to use but needs to be with
> +	 *     some caution due to poisoning, see TAIL_MAPPING_REUSED_MAX.
> +	 *
> +	 * [2] "private" field, used when THP_SWAP is on (but disabled on
> +	 *     32 bits, so this index is FREE on 32bit or hugetlb folios).
> +	 *     May need to be fixed finally.
> +	 *
> +	 * [3] "refcount" field must be zero for all tail pages.  See e.g.
> +	 *     has_unmovable_pages() on page_ref_count() check and comment.
> +	 */
>   	union {
>   		struct {
>   			unsigned long _flags_1;
>   			unsigned long _head_1;
> -	/* public: */
> +	/* public: WORD 2 */
>   			unsigned char _folio_dtor;
>   			unsigned char _folio_order;
>   	/* private: 2 bytes can be reused later */
> @@ -335,7 +364,7 @@ struct folio {
>   	/* 4 bytes can be reused later (64 bits only) */
>   			unsigned char _free_1_1[4];
>   #endif
> -	/* public: */
> +	/* public: WORD 3 */
>   			atomic_t _entire_mapcount;
>   			atomic_t _nr_pages_mapped;
>   			atomic_t _pincount;
> @@ -350,20 +379,20 @@ struct folio {
>   		struct page __page_1;
>   	};
>   	union {
> -		struct {
> +		struct {	/* hugetlb folios */
>   			unsigned long _flags_2;
>   			unsigned long _head_2;
> -	/* public: */
> +	/* public: WORD 2 */
>   			void *_hugetlb_subpool;
>   			void *_hugetlb_cgroup;
>   			void *_hugetlb_cgroup_rsvd;
>   			void *_hugetlb_hwpoison;
>   	/* private: the union with struct page is transitional */
>   		};
> -		struct {
> +		struct {	/* non-hugetlb folios */
>   			unsigned long _flags_2a;
>   			unsigned long _head_2a;
> -	/* public: */
> +	/* public: WORD 2-3 */
>   			struct list_head _deferred_list;
>   	/* private: 8 more free bytes for either 32/64 bits */
>   			unsigned char _free_2_1[8];
