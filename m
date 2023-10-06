Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC647BC003
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 22:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbjJFUJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 16:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233396AbjJFUJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 16:09:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE27BF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 13:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696622904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ms/DXkkYNfaLBZlXzvAGFAiNgJdqqoDux/SIe2Qpatk=;
        b=WzOemcF3ntdA5BK7bnMF9mBVK/Y3f3ZHW+/Yykpr73QaqSC+BGTk7VraCudELEVjMRCedm
        NiOm9KP8iRZoES8ukbZZ/G8LcN61rJPKbKihhp6tUZckzewvLLNBfJrIQll1AcwxBlYNtV
        QffvnLdscgHQJjKS7RYDHEu1Z2+PLuk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-gq1ImO3nP06FnJB0sPbnFw-1; Fri, 06 Oct 2023 16:08:23 -0400
X-MC-Unique: gq1ImO3nP06FnJB0sPbnFw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-406710d9a4aso18431215e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 13:08:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696622902; x=1697227702;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ms/DXkkYNfaLBZlXzvAGFAiNgJdqqoDux/SIe2Qpatk=;
        b=TzYmVnyf4eR8kStBV9x+pO5RokvSs5S8AG/9YoytbbTfSVgXtMadhbqbUyf3ICEh89
         itzMlWUtg9oEFR32CKZDIcM1rZ5DQ78DzQvSpBWHtrjwjDXex7WzN59rW4EtQfW/CdF4
         9NGjFNoTYzpiaT1YD2X37mojlp0esE/yBmKd5AVsDumDbfNvHHES46QfLY5bxjLHkDn9
         OcXOubDzC4X+xmT+0R9nCCyIdB5UeuaFzKwD5H7wGauSqg56dX/tvM2mWt9iX1B+sRR9
         hFAOwlnEzbM6MnjIR0ehcO7L+brhrdhjSmokTL9l/3Yaf0/dWoYABpFtw02Le40/rBD/
         MXEw==
X-Gm-Message-State: AOJu0YwfK6bPEDEkqSXrZVehcZLDBt1B5xF/FydwOh5DT09yqsof3Wfw
        8MrsqxhuRQbJQr6N+od1f/wpcTvRQxcnDFQ/kMb9Urn/C/dMq0/k+T595ZV6K9AmLuzrkrA8bwp
        Z7Pyii6SsrL+Lq6P2Zuby2C59
X-Received: by 2002:a05:600c:d1:b0:405:3a3d:6f42 with SMTP id u17-20020a05600c00d100b004053a3d6f42mr8171885wmm.39.1696622901964;
        Fri, 06 Oct 2023 13:08:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENTI2KRa9s/ItyJi1/4U0Y6qvQkJ3F+dDC3uabzJW4LFvFgnLD/TOZGvGmi56M5FncjAz+7Q==
X-Received: by 2002:a05:600c:d1:b0:405:3a3d:6f42 with SMTP id u17-20020a05600c00d100b004053a3d6f42mr8171870wmm.39.1696622901443;
        Fri, 06 Oct 2023 13:08:21 -0700 (PDT)
Received: from ?IPV6:2003:cb:c715:ee00:4e24:cf8e:3de0:8819? (p200300cbc715ee004e24cf8e3de08819.dip0.t-ipconnect.de. [2003:cb:c715:ee00:4e24:cf8e:3de0:8819])
        by smtp.gmail.com with ESMTPSA id c19-20020a7bc853000000b004064288597bsm4411230wml.30.2023.10.06.13.08.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 13:08:21 -0700 (PDT)
Message-ID: <2f64809e-0d0d-cc61-71ac-8d9b072efc3a@redhat.com>
Date:   Fri, 6 Oct 2023 22:08:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v6 6/9] mm: thp: Add "recommend" option for anon_orders
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
        Hugh Dickins <hughd@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230929114421.3761121-1-ryan.roberts@arm.com>
 <20230929114421.3761121-7-ryan.roberts@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230929114421.3761121-7-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.09.23 13:44, Ryan Roberts wrote:
> In addition to passing a bitfield of folio orders to enable for THP,
> allow the string "recommend" to be written, which has the effect of
> causing the system to enable the orders preferred by the architecture
> and by the mm. The user can see what these orders are by subsequently
> reading back the file.
> 
> Note that these recommended orders are expected to be static for a given
> boot of the system, and so the keyword "auto" was deliberately not used,
> as I want to reserve it for a possible future use where the "best" order
> is chosen more dynamically at runtime.
> 
> Recommended orders are determined as follows:
>    - PMD_ORDER: The traditional THP size
>    - arch_wants_pte_order() if implemented by the arch
>    - PAGE_ALLOC_COSTLY_ORDER: The largest order kept on per-cpu free list
> 
> arch_wants_pte_order() can be overridden by the architecture if desired.
> Some architectures (e.g. arm64) can coalsece TLB entries if a contiguous
> set of ptes map physically contigious, naturally aligned memory, so this
> mechanism allows the architecture to optimize as required.
> 
> Here we add the default implementation of arch_wants_pte_order(), used
> when the architecture does not define it, which returns -1, implying
> that the HW has no preference.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>   Documentation/admin-guide/mm/transhuge.rst |  4 ++++
>   include/linux/pgtable.h                    | 13 +++++++++++++
>   mm/huge_memory.c                           | 14 +++++++++++---
>   3 files changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
> index 732c3b2f4ba8..d6363d4efa3a 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -187,6 +187,10 @@ pages (=16K if the page size is 4K). The example above enables order-9
>   By enabling multiple orders, allocation of each order will be
>   attempted, highest to lowest, until a successful allocation is made.
>   If the PMD-order is unset, then no PMD-sized THPs will be allocated.
> +It is also possible to enable the recommended set of orders, which
> +will be optimized for the architecture and mm::
> +
> +	echo recommend >/sys/kernel/mm/transparent_hugepage/anon_orders
>   
>   The kernel will ignore any orders that it does not support so read the
>   file back to determine which orders are enabled::
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index af7639c3b0a3..0e110ce57cc3 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -393,6 +393,19 @@ static inline void arch_check_zapped_pmd(struct vm_area_struct *vma,
>   }
>   #endif
>   
> +#ifndef arch_wants_pte_order
> +/*
> + * Returns preferred folio order for pte-mapped memory. Must be in range [0,
> + * PMD_ORDER) and must not be order-1 since THP requires large folios to be at
> + * least order-2. Negative value implies that the HW has no preference and mm
> + * will choose it's own default order.
> + */
> +static inline int arch_wants_pte_order(void)
> +{
> +	return -1;
> +}
> +#endif
> +
>   #ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
>   static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
>   				       unsigned long address,
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index bcecce769017..e2e2d3906a21 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -464,10 +464,18 @@ static ssize_t anon_orders_store(struct kobject *kobj,
>   	int err;
>   	int ret = count;
>   	unsigned int orders;
> +	int arch;
>   
> -	err = kstrtouint(buf, 0, &orders);
> -	if (err)
> -		ret = -EINVAL;
> +	if (sysfs_streq(buf, "recommend")) {
> +		arch = max(arch_wants_pte_order(), PAGE_ALLOC_COSTLY_ORDER);
> +		orders = BIT(arch);
> +		orders |= BIT(PAGE_ALLOC_COSTLY_ORDER);
> +		orders |= BIT(PMD_ORDER);
> +	} else {
> +		err = kstrtouint(buf, 0, &orders);
> +		if (err)
> +			ret = -EINVAL;
> +	}
>   
>   	if (ret > 0) {
>   		orders &= THP_ORDERS_ALL_ANON;

:/ don't really like that. Regarding my proposal, one could have 
something like that in an "auto" setting for the "enabled" value, or a 
"recommended" setting [not sure].

-- 
Cheers,

David / dhildenb

