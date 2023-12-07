Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E2F80892D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 14:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441842AbjLGN2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 08:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjLGN2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 08:28:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B6FC6
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 05:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701955721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=Nc+r6GKUjG2TpAk0SNHy/so/MSPZ/iOcLc5bjuo0jME=;
        b=ikZLfWR5Z8faYp2JFmrrKod2lB2wbk80b6UjWv7L21pUF6gDyGsNw2DvDIgMWPFH1w6AMq
        sM/t11BcShEEIgXpLNFRWNVDkJFqKbgmAX4meJELeltSKb882+gbTsjwFVbk8vz7+1uoia
        FQmhoCu0d59UMEuzzFEefLa8Zweu+Qs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-7gOZj-k5OleRzpzotRzOyg-1; Thu, 07 Dec 2023 08:28:40 -0500
X-MC-Unique: 7gOZj-k5OleRzpzotRzOyg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-333354a9242so973096f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 05:28:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701955719; x=1702560519;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nc+r6GKUjG2TpAk0SNHy/so/MSPZ/iOcLc5bjuo0jME=;
        b=gQ9LZWzNAKaod+AJg+EOldVXbt0w3N6puVxwkvgYzRwnLl16PWUs9XzH1Z7LKIH8Py
         SMjzCxvWa3hcAZpKTZyZicv2TUpgL9rRK4b/sa/GusGokejHBqPXPJDjwC3P6SNSc3HX
         ncYsL76nVcs9iWfR8MccA3xzNUcP4Xi0IwJWQ4WKXIPtAoySkV9x/KdAIQEJ9ahOFFi/
         V5hB/fsu8v/SL8N9Ees5fstnoeQnBKeYiOrlX6KX/t7pppqdxaU1szLRn32rBAV8J/5T
         mr5D3q2LRAvHAxhmzKqQXCrXmjdX5uusrCZJvj3FGRy2puR2U3TP0eYUgbG57hcMW6F9
         VLbQ==
X-Gm-Message-State: AOJu0Ywn5Bqb3eZf5ftu/3klAO0bEsjbli12+2h0jSGhfOUpfJDvrc3r
        Dpd2iczYlYRytCUSaUZQzwjomXoK7mIuCmDY+MNggyCViVGsTMaey/M/pLJWtedUrpIarbDm3yR
        uljSr51qpdvD4KBR7zV4tCq3LVEFKjnvD
X-Received: by 2002:a05:600c:3b25:b0:40b:29e7:c150 with SMTP id m37-20020a05600c3b2500b0040b29e7c150mr2494016wms.0.1701955719087;
        Thu, 07 Dec 2023 05:28:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHRb0ZapIbXS8TeZnDXnQ6I7Z3g27Krpjg3/lG4s+okZUQRBniw+qoBXj39jzeWcJ/ibGa6CA==
X-Received: by 2002:a05:600c:3b25:b0:40b:29e7:c150 with SMTP id m37-20020a05600c3b2500b0040b29e7c150mr2493989wms.0.1701955718567;
        Thu, 07 Dec 2023 05:28:38 -0800 (PST)
Received: from ?IPV6:2003:cb:c71b:5d00:18d7:1475:24bc:2417? (p200300cbc71b5d0018d7147524bc2417.dip0.t-ipconnect.de. [2003:cb:c71b:5d00:18d7:1475:24bc:2417])
        by smtp.gmail.com with ESMTPSA id t8-20020a05600c450800b0040b4c7e1a65sm1951721wmo.13.2023.12.07.05.28.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 05:28:38 -0800 (PST)
Message-ID: <94806b4f-2370-4999-9586-2c936955cb87@redhat.com>
Date:   Thu, 7 Dec 2023 14:28:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/10] mm: thp: Support allocation of anonymous
 multi-size THP
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Barry Song <21cnbao@gmail.com>,
        Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20231204102027.57185-1-ryan.roberts@arm.com>
 <20231204102027.57185-5-ryan.roberts@arm.com>
 <71040a8c-4ea1-4f21-8ac8-65f7c25c217e@redhat.com>
 <f2896d7f-183b-48fb-a3aa-d21bf2257043@arm.com>
 <ca649aad-7b76-4c6d-b513-26b3d58f8e68@redhat.com>
 <126c3b71-1acc-4851-9986-4228cb8a8660@arm.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <126c3b71-1acc-4851-9986-4228cb8a8660@arm.com>
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

>>
>> Right, but you know from the first loop which order is applicable (and will be
>> fed to the second loop) and could just pte_unmap(pte) + tryalloc. If that fails,
>> remap and try with the next orders.
> 
> You mean something like this?
> 
> 	pte = pte_offset_map(vmf->pmd, vmf->address & PMD_MASK);
> 	if (!pte)
> 		return ERR_PTR(-EAGAIN);
> 
> 	order = highest_order(orders);
> 	while (orders) {
> 		addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
> 		if (!pte_range_none(pte + pte_index(addr), 1 << order)) {
> 			order = next_order(&orders, order);
> 			continue;
> 		}
> 
> 		pte_unmap(pte);
> 		
> 		folio = vma_alloc_folio(gfp, order, vma, addr, true);
> 		if (folio) {
> 			clear_huge_page(&folio->page, vmf->address, 1 << order);
> 			return folio;
> 		}
> 
> 		pte = pte_offset_map(vmf->pmd, vmf->address & PMD_MASK);
> 		if (!pte)
> 			return ERR_PTR(-EAGAIN);
> 
> 		order = next_order(&orders, order);
> 	}
> 
> 	pte_unmap(pte);
> 
> I don't really like that because if high order folio allocations fail, then you
> are calling pte_range_none() again for the next lower order; once that check has
> succeeded for an order it shouldn't be required for any lower orders. In this
> case you also have lots of pte map/unmap.

I see what you mean.

> 
> The original version feels more efficient to me.
Yes it is. Adding in some comments might help, like

/*
  * Find the largest order where the aligned range is completely prot_none(). Note
  * that all remaining orders will be completely prot_none().
  */
...

/* Try allocating the largest of the remaining orders. */

> 
>>
>> That would make the code certainly easier to understand. That "orders" magic of
>> constructing, filtering, walking is confusing :)
>>
>>
>> I might find some time today to see if there is an easy way to cleanup all what
>> I spelled out above. It really is a mess. But likely that cleanup could be
>> deferred (but you're touching it, so ... :) ).
> 
> I'm going to ignore the last 5 words. I heard the "that cleanup could be
> deferred" part loud and clear though :)

:)

If we could stop passing orders into thp_vma_allowable_orders(), that would probably
be the biggest win. It's just all a confusing mess.

-- 
Cheers,

David / dhildenb

