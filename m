Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0647E97CA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 09:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbjKMIdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 03:33:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbjKMIdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 03:33:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A19D1707
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 00:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699864352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=SfXLxhKvYL2Q3k0S5J8D2va2LGcyePL2i7NJhihVP1M=;
        b=VOpKspO4bQGW0v6MQ2mBn1ourNyiLJrmF3K6O84rUk1O/oS3mZAx03Wty1PAy9k+7mK4ur
        uyNhukf2Gl5D7hIa2Cx/e+k/nkk3izvTuPBQnfSq/VMbSn7y77CzHc1ragFCh1yzJXmJJV
        xzUJGR2yzE3r0BFl+2CCYm/7pYoq+fg=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-aBUQw4clPv-wAKth8RuidA-1; Mon, 13 Nov 2023 03:32:29 -0500
X-MC-Unique: aBUQw4clPv-wAKth8RuidA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-507be692ce4so4028564e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 00:32:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699864348; x=1700469148;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SfXLxhKvYL2Q3k0S5J8D2va2LGcyePL2i7NJhihVP1M=;
        b=D1laXDUFJv2joFjfQwGM8a0pvOaUqoFVqg8EoNORVoMfGcjTMM8l5arW5sH21swMpM
         Aaliqm1KDfhqlTWGocAO9pqlXYUMy3Shif1q3fOhDO4PPMf7ENXg985gdfJjpbH0Z8wj
         6iLwrGgVbBEov4lr84TyMgT8vBGwlL87tNxtCcWPzOAIhmdilNk9Er8mrJCGBtUZuC/y
         KIxK807xRpSeddet2GZ3qXGSe52Vg2LgnsNFGjMHW9rzSqU7zQtBnHJWlpy+9kl/0DnL
         ZiXxGnb3ytyk0SsjIHwfamX8Aw0Gw1GZDRyfI4PkuRnv+vsRwVFT1/ZmnXjLhTY47iEg
         w9Cw==
X-Gm-Message-State: AOJu0YxGrYhS/513xkikuhAlKo4qTyJhqNFxyeiRFm+LXCAukJS/5vRf
        z+SyEOIHEdcZrPj4QcP7vneG4FCRavCD7kfpRoVX0WwYS8LfPhQHQ8t0HgnpoUR31kt5OVcynkF
        pSYiDuiBzAxBsgx1M+sk/xxgU
X-Received: by 2002:a05:6512:41c:b0:509:2b81:fc40 with SMTP id u28-20020a056512041c00b005092b81fc40mr3544033lfk.9.1699864348210;
        Mon, 13 Nov 2023 00:32:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGP5KddZV715bE9zRi1LCYED+VcbUC1bP2pUyQiRhR+wpWKGwNGKr9o3YO+q+0UmggLLKgZnQ==
X-Received: by 2002:a05:6512:41c:b0:509:2b81:fc40 with SMTP id u28-20020a056512041c00b005092b81fc40mr3544014lfk.9.1699864347757;
        Mon, 13 Nov 2023 00:32:27 -0800 (PST)
Received: from ?IPV6:2003:d8:2f09:f500:a38f:d086:59d4:9df? (p200300d82f09f500a38fd08659d409df.dip0.t-ipconnect.de. [2003:d8:2f09:f500:a38f:d086:59d4:9df])
        by smtp.gmail.com with ESMTPSA id x15-20020adfffcf000000b0031984b370f2sm4878031wrs.47.2023.11.13.00.32.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 00:32:27 -0800 (PST)
Message-ID: <d5fed34e-359d-4a06-85bd-27694bcf6e4d@redhat.com>
Date:   Mon, 13 Nov 2023 09:32:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] mm: ksm: use more folio api in
 ksm_might_need_to_copy()
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20231107135216.415926-1-wangkefeng.wang@huawei.com>
 <20231107135216.415926-2-wangkefeng.wang@huawei.com>
 <ZUpIlkO0E7+i2hCg@casper.infradead.org>
 <81e0289c-225c-4468-959c-937d3678cb2d@huawei.com>
 <ZUuUVDbiWETJ2OU1@casper.infradead.org>
 <67eedbab-bf15-4bc3-88ce-36fc074393bd@huawei.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <67eedbab-bf15-4bc3-88ce-36fc074393bd@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.11.23 08:09, Kefeng Wang wrote:
> 
> 
> On 2023/11/8 21:59, Matthew Wilcox wrote:
>> On Wed, Nov 08, 2023 at 09:40:09AM +0800, Kefeng Wang wrote:
>>>
>>>
>>> On 2023/11/7 22:24, Matthew Wilcox wrote:
>>>> On Tue, Nov 07, 2023 at 09:52:11PM +0800, Kefeng Wang wrote:
>>>>>     struct page *ksm_might_need_to_copy(struct page *page,
>>>>> -			struct vm_area_struct *vma, unsigned long address)
>>>>> +			struct vm_area_struct *vma, unsigned long addr)
>>>>>     {
>>>>>     	struct folio *folio = page_folio(page);
>>>>>     	struct anon_vma *anon_vma = folio_anon_vma(folio);
>>>>> -	struct page *new_page;
>>>>> +	struct folio *new_folio;
>>>>> -	if (PageKsm(page)) {
>>>>> -		if (page_stable_node(page) &&
>>>>> +	if (folio_test_ksm(folio)) {
>>>>> +		if (folio_stable_node(folio) &&
>>>>>     		    !(ksm_run & KSM_RUN_UNMERGE))
>>>>>     			return page;	/* no need to copy it */
>>>>>     	} else if (!anon_vma) {
>>>>>     		return page;		/* no need to copy it */
>>>>> -	} else if (page->index == linear_page_index(vma, address) &&
>>>>> +	} else if (page->index == linear_page_index(vma, addr) &&
>>>>
>>>> Hmm.  page->index is going away.  What should we do here instead?
>>>
>>> Do you mean to replace page->index to folio->index, or kill index from
>>> struct page?
>>
>> I'm asking you what we should do.
>>
>> Tail pages already don't have a valid ->index (or ->mapping).
>> So presumably we can't see a tail page here today.  But will we in future?
> 
> I think we could replace page->index to page_to_pgoff(page).

What the second part of that code does is check whether a page might 
have been a KSM page before swapout.

Once a KSM page is swapped out, we lose the KSM marker. To recover, we 
have to check whether the new page logically "fits" into the VMA.

Large folios are never KSM folios, and we only swap in small folios (and 
in the future, once we would swap in large folios, they couldn't have 
been KSM folios before).

So you could return early in the function if we have a large folio and 
make all operations based on the (small) folio.

-- 
Cheers,

David / dhildenb

