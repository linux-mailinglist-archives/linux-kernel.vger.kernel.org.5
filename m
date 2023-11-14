Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82CB7EB683
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 19:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbjKNSju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 13:39:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjKNSjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 13:39:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7150FE
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 10:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699987185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=lMzxw7MpAdlI2fv1gHp8QXTc6SEWuODVU51yYvgu0/s=;
        b=H3CYe8iangs6yc2xkznPwAoN5PZWwKacWmkzBx9g79eW1sGgWZEqUQB6zC2PEHaPENu0Xg
        byXAb7EJcBtB86/cFUh5zkgqXaIQ2zQmBJPolmx/03TzxptNatNPBLFmlF7OshPzcyJYKn
        m50TJSH1BqlSS0xrxb70Lj+/zCtcGyU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606--O7KDJWGOR62SP6f6FX-dA-1; Tue, 14 Nov 2023 13:39:43 -0500
X-MC-Unique: -O7KDJWGOR62SP6f6FX-dA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4084e263ec4so39956765e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 10:39:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699987182; x=1700591982;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMzxw7MpAdlI2fv1gHp8QXTc6SEWuODVU51yYvgu0/s=;
        b=BryddCiV/bb1SX6L3TyXG2l5MszPzTI06F3QsJ/YXjeGQ/hokBKyLCf6DYkIQP5mbU
         ra7R7wBkIdrENsAG5C+R1k5ITSwdalpDUp8J6BnVj2MxQqROeQ7DrH5L+Lsb8KhKrxEW
         nRSHk9KVpltDbPCk2WWhyA5xI42jnke+FLWgq9rE8B/9w4omRdckOW3bO+1lUQER7nSy
         riqb/6TG2VuelIU8fsG0FNoL3EpWxiogRxrN2Kq9Us/cBFMFMYWGHiukmESlD9bXSnFx
         525dPE74ARkN52owuChcK286D1e/+iWV5c47w0Pk9MU4qAP5q2rqzux2VwKOszC6Eo+P
         ibqQ==
X-Gm-Message-State: AOJu0YwLRqpj8PQ5n0jypZB7dyYaXUxYT9lbQAJY5JNRGt6//xe2Qf20
        oSS8/5RB8Hf3ppy9hP8+0EiEf+io4hMJLtZxAaFWIm0dzmr80kjfRvd6y7grvTYcyxkItp+9W6r
        V1mtijaFjk/gronIXYCpWfKe7
X-Received: by 2002:a05:600c:1695:b0:3fe:2bb1:11ba with SMTP id k21-20020a05600c169500b003fe2bb111bamr8763291wmn.27.1699987182478;
        Tue, 14 Nov 2023 10:39:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZXV2odJ/j8P9xGS6bVV1sMppBwnilp87FedLQhpCqCfvR3Yot4+anzqUz+v1b/GpLTVWLaA==
X-Received: by 2002:a05:600c:1695:b0:3fe:2bb1:11ba with SMTP id k21-20020a05600c169500b003fe2bb111bamr8763284wmn.27.1699987182081;
        Tue, 14 Nov 2023 10:39:42 -0800 (PST)
Received: from ?IPV6:2003:cb:c73e:8900:2d8:c9f0:f3fb:d4fd? (p200300cbc73e890002d8c9f0f3fbd4fd.dip0.t-ipconnect.de. [2003:cb:c73e:8900:2d8:c9f0:f3fb:d4fd])
        by smtp.gmail.com with ESMTPSA id fl14-20020a05600c0b8e00b004080f0376a0sm12442292wmb.42.2023.11.14.10.39.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Nov 2023 10:39:41 -0800 (PST)
Message-ID: <458da84d-3838-4c5d-abda-1aebba676186@redhat.com>
Date:   Tue, 14 Nov 2023 19:39:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] s390/mm: implement MEM_PHYS_ONLINE MEM_PHYS_OFFLINE
 memory notifiers
Content-Language: en-US
To:     Sumanth Korikkar <sumanthk@linux.ibm.com>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@suse.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20231114180238.1522782-1-sumanthk@linux.ibm.com>
 <20231114180238.1522782-7-sumanthk@linux.ibm.com>
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
In-Reply-To: <20231114180238.1522782-7-sumanthk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.11.23 19:02, Sumanth Korikkar wrote:
> Implement MEM_PHYS_ONLINE and MEM_PHYS_OFFLINE memory notifiers on s390
> 
> Implementation of MEM_PHYS_ONLINE Memory Notifier:
> * Transition the memory block to an accessible/online state using the
>    sclp assign command.
> * Execute __add_pages() for the memory block, enabling a self-contained
>    memory map range. For boot-time memory, vmemmap mapping is carried out
>    through sparse_init().
> 
> Implementation of MEM_PHYS_OFFLINE Memory Notifier:
> * Execute __remove_pages() exclusively for the memory block (applicable
>    where a self-contained memory map was possible before).
> * Shift the memory block to an inaccessible/offline state using the sclp
>    unassign command.
> 
> Additional Implementation Considerations:
> * When MHP_MEMMAP_ON_MEMORY is disabled, the system retains the old
>    behavior. This means the memory map is allocated from default memory,
>    and struct vmemmap pages are populated during the standby memory
>    detection phase.
> * With MHP_MEMMAP_ON_MEMORY enabled (allowing self-contained memory
>    map), the memory map is allocated using the self-contained memory map
>    range. Struct vmemmap pages are populated during the memory hotplug
>    phase.
> * If MACHINE_HAS_EDAT1 is unavailable, MHP_MEMMAP_ON_MEMORY is
>    automatically disabled. This ensures that vmemmap pagetables do not
>    consume additional memory from the default memory allocator.
> * The MEM_GOING_ONLINE notifier has been modified to perform no
>    operation, as MEM_PHYS_ONLINE already executes the sclp assign
>    command.
> * The MEM_CANCEL_ONLINE notifier now performs no operation, as
>    MEM_PHYS_OFFLINE already executes the sclp unassign command.
> * The call to __add_pages() in arch_add_memory() with altmap support is
>    skipped. This operation is deferred and will be performed later in the
>    MEM_PHYS_ONLINE notifier.
> 
> Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> ---
>   arch/s390/mm/init.c          | 16 +++++++++++++++-
>   drivers/s390/char/sclp_cmd.c | 33 ++++++++++++++++++++++++++++++---
>   2 files changed, 45 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
> index 8d9a60ccb777..db505ed590b2 100644
> --- a/arch/s390/mm/init.c
> +++ b/arch/s390/mm/init.c
> @@ -288,6 +288,12 @@ int arch_add_memory(int nid, u64 start, u64 size,
>   	rc = vmem_add_mapping(start, size);
>   	if (rc)
>   		return rc;
> +	/*
> +	 * If MHP_MEMMAP_ON_MEMORY is enabled, perform __add_pages() during memory
> +	 * onlining phase
> +	 */
> +	if (params->altmap)
> +		return 0;


So we'd have added memory blocks without a memmap? Sorry, but this seems 
to further hack into the s390x direction.

Maybe s390x should just provide a dedicate interface to add these memory 
blocks instead of adding them during boot and then relying on the old 
way of using online/offline set them online/offline.

-- 
Cheers,

David / dhildenb

