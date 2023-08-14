Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B73077C3BD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 01:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbjHNXBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 19:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233450AbjHNXBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 19:01:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE95E5F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 16:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=/gAMpDx01vrh+7kNmzGJlT4j56F5fz+EKmNUk4NrmMY=; b=MhagY0jOxb1/oYTD0k+udjkgfr
        EtbMxB048zEPYAkfklwlSVQaLc3tC6LCvEqXxX/kwd5yN1+n4Lj48KolLA0y9CTj1g8euLug6XWVz
        xbGCQxU87+1pty21i6D0XmIZV8Z4cH7CkE5WX20jY3qs0jzF3p3dW7qeYijYuLJJs5M6gdJ7nVErz
        24I1MqL2Qe3GvHj8gA00XJk1Tz9Cp82vDRh096cDdmARUuyn6xuH/bDORq6N3PIA3N61sFyY4j33v
        x6fhVAvJ79b0X5PVM5mRSDr3x4N83FIVQv0v8Pw6eSfMatz0dISJuPK62DN9risg5Bd5SEV7K3vB0
        gWRScRyg==;
Received: from [2601:1c2:980:9ec0::577]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qVgYi-004hTe-Ef; Mon, 14 Aug 2023 23:01:12 +0000
Message-ID: <9d90cd4b-dd7a-6e1c-9003-d6d5b203d342@infradead.org>
Date:   Mon, 14 Aug 2023 16:01:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH RFC v2 0/3] mm: Properly document tail pages for a folio
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>, Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
References: <20230814184411.330496-1-peterx@redhat.com>
 <ZNqHdIi8ySqwoswd@casper.infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ZNqHdIi8ySqwoswd@casper.infradead.org>
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



On 8/14/23 12:58, Matthew Wilcox wrote:
> On Mon, Aug 14, 2023 at 02:44:08PM -0400, Peter Xu wrote:
> 
> Look, this is all still too complicated.  And you're trying to make
> something better that I'm trying to make disappear.  I'd really rather
> you spent your time worrying about making userfaultfd use folios
> than faffing with this.
> 
> How about this?
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 5e74ce4a28cd..873285bb5d45 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -334,11 +334,14 @@ struct folio {
>   	/* public: */
>   			unsigned char _folio_dtor;
>   			unsigned char _folio_order;
> +			/* two bytes available here */
>   			atomic_t _entire_mapcount;
>   			atomic_t _nr_pages_mapped;
>   			atomic_t _pincount;
> +			/* no more space on 32-bt */

			                    32-bit

>   #ifdef CONFIG_64BIT
>   			unsigned int _folio_nr_pages;
> +			/* twelve bytes available on 64-bit */
>   #endif
>   	/* private: the union with struct page is transitional */
>   		};
> @@ -360,6 +363,7 @@ struct folio {
>   			unsigned long _head_2a;
>   	/* public: */
>   			struct list_head _deferred_list;
> +			/* three more words available here */
>   	/* private: the union with struct page is transitional */
>   		};
>   		struct page __page_2;
