Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A9B7CFC45
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345829AbjJSOQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345801AbjJSOQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:16:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AD2B0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697724917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=CCo1091ggm1hO3q6hOkiQKZJLIb4NgbMXPPTWacbZHo=;
        b=NQYA16zb8ben+7WYJ/z8JjA1CteQLfk18WJTU0/uWun1JjnFcba8W9F2lpg9IsT4mdu8sK
        u+k33f+ggf4VMBm2m9ROBIiUAGloTS4dLe6czHKVC/yuZa/+snGbDvZ1PhLzJM4rudf8My
        YgG1MB24amJz5On/w5thn0MAqMr4R6M=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-XH-hzU8aNVO9XtCJoGTung-1; Thu, 19 Oct 2023 10:15:11 -0400
X-MC-Unique: XH-hzU8aNVO9XtCJoGTung-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-32d9751ca2cso4190818f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:15:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697724910; x=1698329710;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CCo1091ggm1hO3q6hOkiQKZJLIb4NgbMXPPTWacbZHo=;
        b=fu0Hvz2d/Gn6Gw+/bqxcJy3hzN3KG+CwPrtw+U65hYnTrmd1Fb3axdPS17qIjmgrKN
         jjIuvHP8TcbszAzn7rsparu5T8jXfIG6aISJp6cqP2DQsfPE92wKV7Tmox3EH7oF58fS
         NTJ4EEMBe/iaI1/oMB300xASixuUDEyGvQ1boMeEFK8Dx7LaIIx+xR6wWHFiL2nxG0cE
         UncoiKh2HIUVu6QvWSopScDwySPdBz9HVwMtdblAm5cDvLePPjzz8HH1EqeD8Pj0fUCB
         f+hP318lnrEWBKR8pSaIhDHSdet0wEY25gk9s4X7T2wAQn88sO9YqWZZdeCroSp4oOqZ
         T75Q==
X-Gm-Message-State: AOJu0Yyq8s14TFE+c2tfwd/x7+fZQzL5Hy2cq37eKT9gYLECmnz/fHTm
        iAkZSwQ1zRz5Lk/pRdrPvK+fGNd2LbUn/7WWFhED2M8jl7i68qb0YTKgqD9/dEd8MwQ1g8tmDEL
        iMqCx/lv7v3T+YtYwMQ8h6wB3
X-Received: by 2002:adf:fe8f:0:b0:32d:ba78:d60e with SMTP id l15-20020adffe8f000000b0032dba78d60emr1641376wrr.65.1697724910370;
        Thu, 19 Oct 2023 07:15:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzRa+Zq9W/TPC1OFVxtO3pWloe/YIKt/t8JUvwxXHEgAgzhAZP3DJl+uh9QbRnzz3Z5Q6KIA==
X-Received: by 2002:adf:fe8f:0:b0:32d:ba78:d60e with SMTP id l15-20020adffe8f000000b0032dba78d60emr1641360wrr.65.1697724909881;
        Thu, 19 Oct 2023 07:15:09 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:500:6a06:17fc:810b:b054? (p200300cbc70b05006a0617fc810bb054.dip0.t-ipconnect.de. [2003:cb:c70b:500:6a06:17fc:810b:b054])
        by smtp.gmail.com with ESMTPSA id b17-20020a05600010d100b003197869bcd7sm4555315wrx.13.2023.10.19.07.15.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 07:15:09 -0700 (PDT)
Message-ID: <2d847d76-2e33-4296-992f-1a6d00c66ff5@redhat.com>
Date:   Thu, 19 Oct 2023 16:15:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm:vmscan: the dirty folio in folio_list skip
 unmap
Content-Language: en-US
To:     Zhiguo Jiang <justinjiang@vivo.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
References: <20231019131446.317-1-justinjiang@vivo.com>
 <20231019131446.317-2-justinjiang@vivo.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20231019131446.317-2-justinjiang@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.10.23 15:14, Zhiguo Jiang wrote:
> In the shrink_folio_list() the sources of the file dirty folio include
> two ways below:
> 1. The dirty folio is from the incoming parameter folio_list,
>     which is the inactive file lru.
> 2. The dirty folio is from the PTE dirty bit transferred by
>     the try_to_unmap().
> 
> For the first source of the dirty folio, if the dirty folio does not
> support pageout, the dirty folio can skip unmap in advance to reduce
> recyling time.
> 
> Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
> ---
> 
> Changelog:
> v1->v2:
> 1. Keep the original judgment flow.
> 2. Add the interface of folio_check_pageout().
> 3. The dirty folio which does not support pageout in inactive file lru
>     skip unmap in advance.
> 
>   mm/vmscan.c | 103 +++++++++++++++++++++++++++++++++-------------------
>   1 file changed, 66 insertions(+), 37 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index a68d01fcc307..e067269275a5 100755
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -925,6 +925,44 @@ static void folio_check_dirty_writeback(struct folio *folio,
>   		mapping->a_ops->is_dirty_writeback(folio, dirty, writeback);
>   }
>   
> +/* Check if a dirty folio can support pageout in the recyling process*/
> +static bool folio_check_pageout(struct folio *folio,
> +						struct pglist_data *pgdat)
> +{
> +	int ret = true;
> +
> +	/*
> +	 * Anonymous folios are not handled by flushers and must be written
> +	 * from reclaim context. Do not stall reclaim based on them.
> +	 * MADV_FREE anonymous folios are put into inactive file list too.
> +	 * They could be mistakenly treated as file lru. So further anon
> +	 * test is needed.
> +	 */
> +	if (!folio_is_file_lru(folio) ||
> +		(folio_test_anon(folio) && !folio_test_swapbacked(folio)))
> +		goto out;
> +
> +	if (folio_test_dirty(folio) &&
> +		(!current_is_kswapd() ||
> +		 !folio_test_reclaim(folio) ||
> +		 !test_bit(PGDAT_DIRTY, &pgdat->flags))) {
> +		/*
> +		 * Immediately reclaim when written back.
> +		 * Similar in principle to folio_deactivate()
> +		 * except we already have the folio isolated
> +		 * and know it's dirty
> +		 */
> +		node_stat_mod_folio(folio, NR_VMSCAN_IMMEDIATE,
> +			folio_nr_pages(folio));
> +		folio_set_reclaim(folio);
> +
> +		ret = false;
> +	}
> +
> +out:
> +	return ret;
> +}
> +
>   static struct folio *alloc_demote_folio(struct folio *src,
>   		unsigned long private)
>   {
> @@ -1078,6 +1116,12 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>   		if (dirty && !writeback)
>   			stat->nr_unqueued_dirty += nr_pages;
>   
> +		/* If the dirty folio dose not support pageout,
> +		 * the dirty folio can skip this recycling.
> +		 */
> +		if (!folio_check_pageout(folio, pgdat))
> +			goto activate_locked;
> +
>   		/*
>   		 * Treat this folio as congested if folios are cycling
>   		 * through the LRU so quickly that the folios marked
> @@ -1261,43 +1305,6 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>   			enum ttu_flags flags = TTU_BATCH_FLUSH;
>   			bool was_swapbacked = folio_test_swapbacked(folio);
>   
> -			if (folio_test_dirty(folio)) {
> -				/*
> -				 * Only kswapd can writeback filesystem folios
> -				 * to avoid risk of stack overflow. But avoid
> -				 * injecting inefficient single-folio I/O into
> -				 * flusher writeback as much as possible: only
> -				 * write folios when we've encountered many
> -				 * dirty folios, and when we've already scanned
> -				 * the rest of the LRU for clean folios and see
> -				 * the same dirty folios again (with the reclaim
> -				 * flag set).
> -				 */
> -				if (folio_is_file_lru(folio) &&
> -					(!current_is_kswapd() ||
> -					 !folio_test_reclaim(folio) ||
> -					 !test_bit(PGDAT_DIRTY, &pgdat->flags))) {
> -					/*
> -					 * Immediately reclaim when written back.
> -					 * Similar in principle to folio_deactivate()
> -					 * except we already have the folio isolated
> -					 * and know it's dirty
> -					 */
> -					node_stat_mod_folio(folio, NR_VMSCAN_IMMEDIATE,
> -							nr_pages);
> -					folio_set_reclaim(folio);
> -
> -					goto activate_locked;
> -				}
> -
> -				if (references == FOLIOREF_RECLAIM_CLEAN)
> -					goto keep_locked;
> -				if (!may_enter_fs(folio, sc->gfp_mask))
> -					goto keep_locked;
> -				if (!sc->may_writepage)
> -					goto keep_locked;
> -			}
> -
>   			if (folio_test_pmd_mappable(folio))
>   				flags |= TTU_SPLIT_HUGE_PMD;
>   
> @@ -1323,6 +1330,28 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>   
>   		mapping = folio_mapping(folio);
>   		if (folio_test_dirty(folio)) {
> +			/*
> +			 * Only kswapd can writeback filesystem folios
> +			 * to avoid risk of stack overflow. But avoid
> +			 * injecting inefficient single-folio I/O into
> +			 * flusher writeback as much as possible: only
> +			 * write folios when we've encountered many
> +			 * dirty folios, and when we've already scanned
> +			 * the rest of the LRU for clean folios and see
> +			 * the same dirty folios again (with the reclaim
> +			 * flag set).
> +			 */
> +			if (folio_is_file_lru(folio) &&
> +				!folio_check_pageout(folio, pgdat))
> +				goto activate_locked;
> +
> +			if (references == FOLIOREF_RECLAIM_CLEAN)
> +				goto keep_locked;
> +			if (!may_enter_fs(folio, sc->gfp_mask))
> +				goto keep_locked;
> +			if (!sc->may_writepage)
> +				goto keep_locked;
> +
>   			/*
>   			 * Folio is dirty. Flush the TLB if a writable entry
>   			 * potentially exists to avoid CPU writes after I/O

I'm confused. Did you apply this on top of v1 by accident?

-- 
Cheers,

David / dhildenb

