Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28FF80EF63
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 15:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376950AbjLLOyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 09:54:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376919AbjLLOye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 09:54:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E01DD3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 06:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702392879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=nHow/OuTkq7ZGC7us2BB0pRida/FxOxA+wS3+9JxabI=;
        b=EpWPonnDkYtIfTi23kKvPSOITPnfvWg3KKrO24x1iLIq1KeZWgTDyblwHPJ8/vWQ0KKa55
        NH369uGEwCF/5/XYUc8vJGpx8KbtIf2/mnbN02oAUYSYVVLXTf+pBwCEPSSYpbATfjmf/8
        e0HuZQOX+Bp4WndGisPLr1rnemN5+lg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-4up4vSD8OUqKGXWxqsZbIw-1; Tue, 12 Dec 2023 09:54:38 -0500
X-MC-Unique: 4up4vSD8OUqKGXWxqsZbIw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40c3f0f88e3so20910885e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 06:54:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702392877; x=1702997677;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nHow/OuTkq7ZGC7us2BB0pRida/FxOxA+wS3+9JxabI=;
        b=WOWFVGV/4Ir9qJjvtzwFtbjvQ2NhPgNK8OjVdyKmygSWdyn5OIyo58+qP82izXbOeI
         DKsikh4xQPuxIGcUxBNqjQqNzTdlwWkeLMCnab7+oJMRQk/4m5GTzOJM4JQnu9ImpQAy
         ajOmqtjGtsI4UHsVchtoQmQlA3WJr56al/jS+RoFO4qvInkbHQPizbwqJzzc8Mn+4Gre
         WP0w2QZYdT1JU5V66nyzixCAsG0+NC+Xj26xM8d9N40Dfq0LaciDn6dM0RdKvbThR8IL
         sl3u72Ohl9hE6SYevBKQw8Qs633XR3DmGtF1Dx/pPw/1YRIoKgr+NTyv6KcIGdq8xbaA
         k8+A==
X-Gm-Message-State: AOJu0YyUprQ3qfbHEY6M1Y0xwezJGIkspdQTjJdgUTBGmGAI5rHFNlg3
        GrDDT0FhCZu+vJhPRb+dYbuP5uRcxDPMfYDkCTCWw5RnLcY5a1AwMw9pWfXovR+ih4ORSmBjowH
        O6WfkgyM4sGQg/zXx9bFyOhnk
X-Received: by 2002:a05:600c:2946:b0:40c:296e:7bfe with SMTP id n6-20020a05600c294600b0040c296e7bfemr3180077wmd.140.1702392876801;
        Tue, 12 Dec 2023 06:54:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGuE/LNZkhO6BY7R3E00Okx+cRdSCf/S+VdKZyExVc3zn/84/FQA0KMC/O7nHgd8h2W5hfVTQ==
X-Received: by 2002:a05:600c:2946:b0:40c:296e:7bfe with SMTP id n6-20020a05600c294600b0040c296e7bfemr3180058wmd.140.1702392876335;
        Tue, 12 Dec 2023 06:54:36 -0800 (PST)
Received: from ?IPV6:2003:cb:c74b:ca00:4ca2:ff2c:9092:f070? (p200300cbc74bca004ca2ff2c9092f070.dip0.t-ipconnect.de. [2003:cb:c74b:ca00:4ca2:ff2c:9092:f070])
        by smtp.gmail.com with ESMTPSA id fs27-20020a05600c3f9b00b0040b36050f1bsm16489167wmb.44.2023.12.12.06.54.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 06:54:35 -0800 (PST)
Message-ID: <ff7a3e9c-53cb-4283-9298-781d4fb7c7f8@redhat.com>
Date:   Tue, 12 Dec 2023 15:54:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 03/10] mm: thp: Introduce multi-size THP sysfs
 interface
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
        linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>
References: <20231207161211.2374093-1-ryan.roberts@arm.com>
 <20231207161211.2374093-4-ryan.roberts@arm.com>
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
In-Reply-To: <20231207161211.2374093-4-ryan.roberts@arm.com>
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

On 07.12.23 17:12, Ryan Roberts wrote:
> In preparation for adding support for anonymous multi-size THP,
> introduce new sysfs structure that will be used to control the new
> behaviours. A new directory is added under transparent_hugepage for each
> supported THP size, and contains an `enabled` file, which can be set to
> "inherit" (to inherit the global setting), "always", "madvise" or
> "never". For now, the kernel still only supports PMD-sized anonymous
> THP, so only 1 directory is populated.
> 
> The first half of the change converts transhuge_vma_suitable() and
> hugepage_vma_check() so that they take a bitfield of orders for which
> the user wants to determine support, and the functions filter out all
> the orders that can't be supported, given the current sysfs
> configuration and the VMA dimensions. The resulting functions are
> renamed to thp_vma_suitable_orders() and thp_vma_allowable_orders()
> respectively. Convenience functions that take a single, unencoded order
> and return a boolean are also defined as thp_vma_suitable_order() and
> thp_vma_allowable_order().
> 
> The second half of the change implements the new sysfs interface. It has
> been done so that each supported THP size has a `struct thpsize`, which
> describes the relevant metadata and is itself a kobject. This is pretty
> minimal for now, but should make it easy to add new per-thpsize files to
> the interface if needed in future (e.g. per-size defrag). Rather than
> keep the `enabled` state directly in the struct thpsize, I've elected to
> directly encode it into huge_anon_orders_[always|madvise|inherit]
> bitfields since this reduces the amount of work required in
> thp_vma_allowable_orders() which is called for every page fault.
> 
> See Documentation/admin-guide/mm/transhuge.rst, as modified by this
> commit, for details of how the new sysfs interface works.
> 
> Reviewed-by: Barry Song <v-songbaohua@oppo.com>
> Tested-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Tested-by: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---

[...]

> +
> +static ssize_t thpsize_enabled_store(struct kobject *kobj,
> +				     struct kobj_attribute *attr,
> +				     const char *buf, size_t count)
> +{
> +	int order = to_thpsize(kobj)->order;
> +	ssize_t ret = count;
> +
> +	if (sysfs_streq(buf, "always")) {
> +		spin_lock(&huge_anon_orders_lock);
> +		clear_bit(order, &huge_anon_orders_inherit);
> +		clear_bit(order, &huge_anon_orders_madvise);
> +		set_bit(order, &huge_anon_orders_always);
> +		spin_unlock(&huge_anon_orders_lock);
> +	} else if (sysfs_streq(buf, "inherit")) {
> +		spin_lock(&huge_anon_orders_lock);
> +		clear_bit(order, &huge_anon_orders_always);
> +		clear_bit(order, &huge_anon_orders_madvise);
> +		set_bit(order, &huge_anon_orders_inherit);
> +		spin_unlock(&huge_anon_orders_lock);
> +	} else if (sysfs_streq(buf, "madvise")) {
> +		spin_lock(&huge_anon_orders_lock);
> +		clear_bit(order, &huge_anon_orders_always);
> +		clear_bit(order, &huge_anon_orders_inherit);
> +		set_bit(order, &huge_anon_orders_madvise);
> +		spin_unlock(&huge_anon_orders_lock);
> +	} else if (sysfs_streq(buf, "never")) {
> +		spin_lock(&huge_anon_orders_lock);
> +		clear_bit(order, &huge_anon_orders_always);
> +		clear_bit(order, &huge_anon_orders_inherit);
> +		clear_bit(order, &huge_anon_orders_madvise);
> +		spin_unlock(&huge_anon_orders_lock);

Why not perform lock/unlock only once in surrounding code? :)


Much better

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

