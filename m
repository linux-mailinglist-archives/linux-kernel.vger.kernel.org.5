Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADA8808648
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbjLGKEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 05:04:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbjLGKD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 05:03:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC14E121
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 02:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701943445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=Si5Uf9JXYLkLz9vVl6AcC7k8sGry4Y0iRmrtVSMM5AE=;
        b=ilgNK9pmViSkFhrmGctschicXF9yt+tdsmaefR5t++yt2eEIdkbt9nYGaD9xGSa8RtkSco
        4kuOHFZqL+u+gPqr+sSk/UCDsB/fs7uG/gOZVjgcAtxzWdC+U547k8A7UPvxGcdtr1ppCC
        i2svAtPeKli/FH0/L7ineVeQHknFrtQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-owF_dRyyPIqk1H_6TCSR1g-1; Thu, 07 Dec 2023 05:04:02 -0500
X-MC-Unique: owF_dRyyPIqk1H_6TCSR1g-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-333405020afso663645f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 02:04:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701943441; x=1702548241;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Si5Uf9JXYLkLz9vVl6AcC7k8sGry4Y0iRmrtVSMM5AE=;
        b=cxzeGRv0B6ZxokNfoB6ONT79APx8OTPySl41Ew5Lv7PDQ6XFOIs+UnBOV07gFHV/kP
         HrITGrr3ZF+86pr5hnI47CMnQu5VL1MqkKe5vY5uWqcPwLkEiYP//3J7fZYNoHtX0OX5
         lYMnLo7Xdl9mqpKPGA+A1U2qKB6UGdpbUmUkg7sETqmAQ6aZ4KYYcPg1fuHoo9BD1jwm
         bbf6Li3ECFYo/J1Ccr3s3A4pJaMrmqmljH3sIPZnEoEBFPDvxVlrY2K5xi3kvvlFznFk
         /mZ6o6GxPM8Mk1HtdGuNz5+r4JmTYYJm5RPRMBpRKISXab4fl5BTXrErLAXLz/KajufJ
         QERQ==
X-Gm-Message-State: AOJu0YzswItCX4RUDot3YYa1a75DM1xz/hZ82ZG7zwM+k+vcdvm843Xk
        LcNNLwPgKzpOIJloc+WEV+UGGiyHrmHk/b2qbUeVpJj/IagGbnDBa+NrT6I3wdaGCbBHMG54uoh
        AyDuDCxZNkmUyRp+CgkPIu0is
X-Received: by 2002:a5d:456f:0:b0:334:b291:27cb with SMTP id a15-20020a5d456f000000b00334b29127cbmr801084wrc.130.1701943441322;
        Thu, 07 Dec 2023 02:04:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEganLE49LdjnwUYvr+mB7Uts+0lx8bjA2U3+GucFMb2BObc80+fklAfbKYFq7KyaEoLJd5ag==
X-Received: by 2002:a5d:456f:0:b0:334:b291:27cb with SMTP id a15-20020a5d456f000000b00334b29127cbmr801068wrc.130.1701943440938;
        Thu, 07 Dec 2023 02:04:00 -0800 (PST)
Received: from ?IPV6:2003:cb:c71b:5d00:18d7:1475:24bc:2417? (p200300cbc71b5d0018d7147524bc2417.dip0.t-ipconnect.de. [2003:cb:c71b:5d00:18d7:1475:24bc:2417])
        by smtp.gmail.com with ESMTPSA id h15-20020adfa4cf000000b003333040e7f3sm1022671wrb.60.2023.12.07.02.03.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 02:04:00 -0800 (PST)
Message-ID: <1dcd6985-aa29-4df7-a7cb-ef57ae658861@redhat.com>
Date:   Thu, 7 Dec 2023 11:03:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V3 PATCH] arm64: mm: swap: save and restore mte tags for
 large folios
Content-Language: en-US
To:     Barry Song <21cnbao@gmail.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>,
        Steven Price <steven.price@arm.com>, akpm@linux-foundation.org,
        catalin.marinas@arm.com, will@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        shy828301@gmail.com, v-songbaohua@oppo.com,
        wangkefeng.wang@huawei.com, willy@infradead.org, xiang@kernel.org,
        ying.huang@intel.com, yuzhao@google.com
References: <20231114014313.67232-1-v-songbaohua@oppo.com>
 <CAGsJ_4wsWzhosZJWegOb8ggoON3KdiH1mO-8mFZd7kWcn6diuw@mail.gmail.com>
 <CAGsJ_4w4VgpO02YUVEn4pbKThg+SszD_bDpBGbKC9d2G90MpGA@mail.gmail.com>
 <8c7f1a2f-57d2-4f20-abb2-394c7980008e@redhat.com>
 <CAGsJ_4zqAehJSY9aAQEKkp9+JvuxtJuF1c7OBCxmaG8ZeEze_Q@mail.gmail.com>
 <e1e6dba5-8702-457e-b149-30b2e43156cf@redhat.com>
 <fb34d312-1049-4932-8f2b-d7f33cfc297c@arm.com>
 <CAGsJ_4zNOCa-bLkBdGXmOAGSZkJQZ0dTe-YWBubkdHmOyOimWg@mail.gmail.com>
 <5de66ff5-b6c8-4ffc-acd9-59aec4604ca4@redhat.com>
 <bab848b8-edd3-4c57-9a96-f17a33e030d0@arm.com>
 <71c4b8b2-512a-4e50-9160-6ee77a5ec0a4@arm.com>
 <CAGsJ_4yoYowJLm+cC8i-HujLcNJKGut+G-NnjRhg2eGkYvXz8Q@mail.gmail.com>
 <679a144a-db47-4d05-bbf7-b6a0514f5ed0@arm.com>
 <c5c82611-3153-4d56-b799-a1df3c953efe@redhat.com>
 <8aa8f095-1840-4a2e-ad06-3f375282ab6a@arm.com>
 <7065bbd3-64b3-4cd6-a2cd-146c556aac66@redhat.com>
 <CAGsJ_4xR9HsXU-Sib6LF_KRJHpU38g8Xu33HGgogPAVbb=BKbg@mail.gmail.com>
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
In-Reply-To: <CAGsJ_4xR9HsXU-Sib6LF_KRJHpU38g8Xu33HGgogPAVbb=BKbg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>
>>> not per-folio? I'm also not sure what it buys us - instead of reading a per-page
>>> flag we now have to read 128 bytes of tag for each page and check its zero.
>>
>> My point is, if that is the corner case, we might not care about that.
> 
> Hi David,

Hi!

> my understanding is that this is NOT a corner. Alternatively, it is
> really a common case.

If it happens with < 1% of all large folios on swapout/swapin, it's not 
the common case. Even if some scenarios you point out below can and will 
happen.

> 
> 1. a large folio can be partially unmapped when it is in swapche and
> after it is swapped out
> in all cases, its tags can be partially invalidated. I don't think
> this is a corner case, as long
> as userspaces are still working at the granularity of basepages, this
> is always going to
> happen. For example, userspace libc such as jemalloc can identify
> PAGESIZE, and use
> madvise(DONTNEED) to return memory to the kernel. Heap management is
> still working
> at the granularity of the basepage.
> 
> 2. mprotect on a part of a large folio as Steven pointed out.
> 
> 3.long term, we are working to swap-in large folios as a whole[1] just
> like swapping out large
> folios as a whole. for those ptes which are still contiguous swap
> entries, i mean, which
> are not unmapped by userspace after the large folios are swapped out
> to swap devices,
> we have a chance to swap in a whole large folio, we do have a chance
> to restore tags
> for the large folio without early-exit. but we still have a good
> chance to fall back to base
> page if we fail to allocate large folio, in this case, do_swap_page()
> still works at the
> granularity of basepage. and do_swap_page() will call swap_free(entry),  tags of
> 
> this particular page can be invalidated as a result.

I don't immediately see how that relates. You get a fresh small folio 
and simply load that tag from the internal datastructure. No messing 
with large folios required, because you don't have a large folio. So no 
considerations about large folio batch MTE tag restore apply.

> 
> 4. too many early-exit might be negative to performance.
> 
> 
> So I am thinking that in the future, we need two helpers,
> 1. void __arch_swap_restore(swp_entry_t entry, struct page *page);
> this is always needed to support page-level tag restore.
> 
> 2.  void arch_swap_restore(swp_entry_t entry, struct folio *folio);
> this can be a helper when we are able to swap in a whole folio. two
> conditions must be met
> (a). PTEs entries are still contiguous swap entries just as when large
> folios were swapped
> out.
> (b). we succeed in the allocation of a large folio in do_swap_page.
> 
> For this moment, we only need 1; we will add 2 in swap-in large folio series.
> 
> What do you think?

I agree that it's better to keep it simple for now.

-- 
Cheers,

David / dhildenb

