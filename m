Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEDEE780E1B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 16:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377775AbjHROjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 10:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353226AbjHROit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 10:38:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061F513D
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 07:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692369490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6AO8bLQMMqRA/kR1FMLwLK33QBpyyFpkWuDBu3UgDsQ=;
        b=FzqveNu0Js06AxHs6Qz3O7+LlBRJUlk2Co9vj38PL4ZkfHUSoUl/lY9+WYazLoK/DvCiU5
        a7ccuj2LiGJTdXRgPZCLYTPyaWDcwFxV6uSF9XKMV2HYWuAYbdQs8sVg17mxV8RQjbwNdo
        UPasZrFi4+56VsqOiG2HnMY7KR63UvI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-05jCnKXvOkq7z5qGjd7DcA-1; Fri, 18 Aug 2023 10:38:08 -0400
X-MC-Unique: 05jCnKXvOkq7z5qGjd7DcA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3fe603e8054so7069215e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 07:38:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692369487; x=1692974287;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6AO8bLQMMqRA/kR1FMLwLK33QBpyyFpkWuDBu3UgDsQ=;
        b=Vm1GJxaXIzaVdnizp3ez2D9qjyZIoPEjWBCrmLB6fKbpP+9fN0/Otg4jB1yFkAdeze
         NkrkM4oBEH+Kv64rkmqRP8kFafxbep6j+sy8H18IhBdJ/L/NS/iOum0DwC78shJOvW1v
         CDEWh3XFrnW22+wdZdZk//MarBjvhGjv1b/VO4SRXgTlZ1hx5BGQQ5qcRiqre3g/NJ9f
         PB9hgy6MD5W4mYuTl6BrBQq7vE6Um6Ino4t4bM6NgUwMwPXJfGnr+8w7wSa8bAJF0EIh
         D6YgDLJjdZTtAuGZ7y+xtJ2MaZywdQXbwYXeMc0nxeQsaqwir41GN7IpG6M7Zzy3WH94
         McGQ==
X-Gm-Message-State: AOJu0YzxB8jMRrQb4zgXLpnJGAWMLJf1qMrkmx0nojGrKFdQDK/18wx6
        FZW9BllhRdmNha/G7XGToPvo1gIqLOERInwg1BSzda2VZbakh7skNSew0STXon2IJzR0qZjv7g6
        ASgAI23UDZJ8GPCCzkiEL86+QaS+uIzG3
X-Received: by 2002:a1c:ed1a:0:b0:3fa:96ad:5d2e with SMTP id l26-20020a1ced1a000000b003fa96ad5d2emr2353262wmh.19.1692369487538;
        Fri, 18 Aug 2023 07:38:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTQmCt8Bmk74oFkZxUBhky826R2XGHuTRXwL4/0sN/eFqiJynhHbdlec1cDmlmtyABhmh5Mw==
X-Received: by 2002:a1c:ed1a:0:b0:3fa:96ad:5d2e with SMTP id l26-20020a1ced1a000000b003fa96ad5d2emr2353237wmh.19.1692369487088;
        Fri, 18 Aug 2023 07:38:07 -0700 (PDT)
Received: from ?IPV6:2003:cb:c726:ff00:a22a:6d42:439d:de2? (p200300cbc726ff00a22a6d42439d0de2.dip0.t-ipconnect.de. [2003:cb:c726:ff00:a22a:6d42:439d:de2])
        by smtp.gmail.com with ESMTPSA id eo4-20020a05600c82c400b003fe1a092925sm3036929wmb.19.2023.08.18.07.38.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Aug 2023 07:38:06 -0700 (PDT)
Message-ID: <6259fc1c-62e4-5ac0-33cb-0cd9a985c5f4@redhat.com>
Date:   Fri, 18 Aug 2023 16:38:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH RFC v3] mm: Proper document tail pages fields for folio
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yu Zhao <yuzhao@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>
References: <20230815212547.431693-1-peterx@redhat.com>
 <b887e764-ffa3-55ee-3c44-69cb15f8a115@redhat.com>
 <ZN0YSOQmSR/voPVO@casper.infradead.org>
 <ae8ea59e-3081-072b-faa0-b67a5d5af047@redhat.com>
 <ZN1IH/8JxkkOU5Ec@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZN1IH/8JxkkOU5Ec@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.08.23 00:05, Matthew Wilcox wrote:
> On Wed, Aug 16, 2023 at 08:51:49PM +0200, David Hildenbrand wrote:
>> On 16.08.23 20:41, Matthew Wilcox wrote:
>>> On Wed, Aug 16, 2023 at 03:33:30PM +0200, David Hildenbrand wrote:
>>>> My simple tests passed so far. If there isn't something obvious missing,
>>>> I can do more testing and send this as an official patch.
>>>
>>> I think you missed one:
>>>
>>> +++ b/mm/swapfile.c
>>> @@ -1490,7 +1490,7 @@ int swp_swapcount(swp_entry_t entry)
>>>
>>>           page = vmalloc_to_page(p->swap_map + offset);
>>>           offset &= ~PAGE_MASK;
>>> -       VM_BUG_ON(page_private(page) != SWP_CONTINUED);
>>> +       VM_BUG_ON(page_swap_entry(page).val != SWP_CONTINUED);
>>
>> That falls under the "weird handling of SWP_CONTINUED using vmalloced
>> pages". So different user of page_private().
>>
>> Note that we don't even store swap entries in there but extended swap
>> counts.
> 
> Ah, right.  I see now.
> 
> 
> Not necessarily as part of this patch, but it got me wondering ...
> should we do this?  And then maybe we could remove folio_swap_entry()
> and folio_set_swap_entry() and just use folio->swap directly.
> 
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 3880b3f2e321..e23d1356e504 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -266,6 +266,14 @@ static inline struct page *encoded_page_ptr(struct encoded_page *page)
>   	return (struct page *)(~ENCODE_PAGE_BITS & (unsigned long)page);
>   }
>   
> +/*
> + * A swap entry has to fit into a "unsigned long", as the entry is hidden
> + * in the "index" field of the swapper address space.
> + */
> +typedef struct {
> +	unsigned long val;
> +} swp_entry_t;
> +
>   /**
>    * struct folio - Represents a contiguous set of bytes.
>    * @flags: Identical to the page flags.
> @@ -276,7 +284,7 @@ static inline struct page *encoded_page_ptr(struct encoded_page *page)
>    * @index: Offset within the file, in units of pages.  For anonymous memory,
>    *    this is the index from the beginning of the mmap.
>    * @private: Filesystem per-folio data (see folio_attach_private()).
> - *    Used for swp_entry_t if folio_test_swapcache().
> + * @swap: Used for swp_entry_t if folio_test_swapcache().
>    * @_mapcount: Do not access this member directly.  Use folio_mapcount() to
>    *    find out how many times this folio is mapped by userspace.
>    * @_refcount: Do not access this member directly.  Use folio_ref_count()
> @@ -319,7 +327,10 @@ struct folio {
>   			};
>   			struct address_space *mapping;
>   			pgoff_t index;
> -			void *private;
> +			union {
> +				void *private;
> +				swp_entry_t swap;

Probably with "/* for anon and shm pages only */

> +			};
>   			atomic_t _mapcount;
>   			atomic_t _refcount;
>   #ifdef CONFIG_MEMCG
> @@ -1158,14 +1169,6 @@ enum tlb_flush_reason {
>   	NR_TLB_FLUSH_REASONS,
>   };
>   
> - /*
> -  * A swap entry has to fit into a "unsigned long", as the entry is hidden
> -  * in the "index" field of the swapper address space.
> -  */
> -typedef struct {
> -	unsigned long val;
> -} swp_entry_t;
> -
>   /**
>    * enum fault_flag - Fault flag definitions.
>    * @FAULT_FLAG_WRITE: Fault was a write fault.
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index bb5adc604144..59b0f37eae5b 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -335,13 +335,12 @@ struct swap_info_struct {
>   
>   static inline swp_entry_t folio_swap_entry(struct folio *folio)
>   {
> -	swp_entry_t entry = { .val = page_private(&folio->page) };
> -	return entry;
> +	return folio->swap;
>   }
>   
>   static inline void folio_set_swap_entry(struct folio *folio, swp_entry_t entry)
>   {
> -	folio->private = (void *)entry.val;
> +	folio->swap = entry;
>   }
>   
>   /* linux/mm/workingset.c */
> 

Sound reasonable, but maybe we should even get rid of the getter/setter 
completely then?

-- 
Cheers,

David / dhildenb

