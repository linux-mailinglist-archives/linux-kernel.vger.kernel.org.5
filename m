Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C151C803B82
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 18:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343823AbjLDR1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 12:27:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234834AbjLDR1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 12:27:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2389CD7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 09:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701710834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=tsKdHmjP3jKe+gcRqJMG/+fEJNRcoaZo0qzvmy398hw=;
        b=aw1Pg3tU/jevQUyT3xERhVl/aavZWxj1b+k6JfSbVB1nRRocNsqF45YXdFkzO7vNsVW6wH
        W/9LhlYNa9+sv3/NklQPbNsYi6tg6ttvgTtQvyqOa25o8zD6At3yfN3TAZvk2iWAMyyVqh
        oaBGiwUpJQ0xT5QFPWyRAGr6wG6NVF8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-L1jZ8oqsPMOaoaxYwVqKGQ-1; Mon, 04 Dec 2023 12:27:12 -0500
X-MC-Unique: L1jZ8oqsPMOaoaxYwVqKGQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40b39377136so35079855e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 09:27:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701710831; x=1702315631;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:from:content-language:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tsKdHmjP3jKe+gcRqJMG/+fEJNRcoaZo0qzvmy398hw=;
        b=Q0f2F5dHa7dxQlfC4KDKDV+k//CD3rgKca9sUQ1GFUvAo2brzclUMV82iVSs79osWm
         4DxBvECF/ixOfJw0Xj312jmqUYfexRE7yK8zv6DQ+3Vdi0gx2wQvc5Mw6NupTmajnq8e
         QBzsBnf1dijNqIGQd/YtbAuTiuWZLbH5FWulRtEdd7dV+L2xK7UHEIg1HSjGeLpR4Y2W
         ZOGSb6s7egpYpBqNZIovlHcxkxwzfZzdUXENmzDIwteR6Qy4pViU3qHdWSMDRpiTHqiw
         itdX/zbQwx9jW5KekCtXSxU3jR1BOknCi96cNqF2tVCYe9mPlyD1QwUeGLfggiiE4ACT
         VtkQ==
X-Gm-Message-State: AOJu0YyaS/Mi0gBUo8ccbZUuneRyBwNYHV1/e2ANI0g3SUwqBgDe5oY6
        OtaVznihSI9IegfzddQqfmyjC0YWwZHdlFK2FKD6K+l5VCj0ch6NsOk1niC29x1GWAKmPtGanG5
        Jozlg/f75GvE3f1Tmp45+tpvl
X-Received: by 2002:a05:600c:4f56:b0:40b:5e21:ec2e with SMTP id m22-20020a05600c4f5600b0040b5e21ec2emr2624245wmq.96.1701710830953;
        Mon, 04 Dec 2023 09:27:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZpppk/Ek5hiplry8oPh7cMDdu9VjtAaLpqrqvMOOnVRVoE15yBSoajHa8oW0LNlDUiX4nsA==
X-Received: by 2002:a05:600c:4f56:b0:40b:5e21:ec2e with SMTP id m22-20020a05600c4f5600b0040b5e21ec2emr2624237wmq.96.1701710830576;
        Mon, 04 Dec 2023 09:27:10 -0800 (PST)
Received: from ?IPV6:2003:cb:c722:3700:6501:8925:6f9:fcdc? (p200300cbc72237006501892506f9fcdc.dip0.t-ipconnect.de. [2003:cb:c722:3700:6501:8925:6f9:fcdc])
        by smtp.gmail.com with ESMTPSA id h6-20020a05600c350600b0040b43da0bbasm15709934wmq.30.2023.12.04.09.27.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 09:27:10 -0800 (PST)
Message-ID: <5b8b9f8c-8e9b-42a5-b8b2-9b96903f3ada@redhat.com>
Date:   Mon, 4 Dec 2023 18:27:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/15] mm: Batch-copy PTE ranges during fork()
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        John Hubbard <jhubbard@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Barry Song <21cnbao@gmail.com>,
        Alistair Popple <apopple@nvidia.com>,
        Yang Shi <shy828301@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20231204105440.61448-1-ryan.roberts@arm.com>
 <20231204105440.61448-2-ryan.roberts@arm.com>
 <a12ce4f8-feb0-4e35-8f55-9270fe5a808b@redhat.com>
 <104de2d6-ecf9-4b0c-a982-5bd8e1aea758@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <104de2d6-ecf9-4b0c-a982-5bd8e1aea758@redhat.com>
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

> 
> With rmap batching from [1] -- rebased+changed on top of that -- we could turn
> that into an effective (untested):
> 
>           if (page && folio_test_anon(folio)) {
> +               nr = folio_nr_pages_cont_mapped(folio, page, src_pte, addr, end,
> +                                               pte, enforce_uffd_wp, &nr_dirty,
> +                                               &nr_writable);
>                   /*
>                    * If this page may have been pinned by the parent process,
>                    * copy the page immediately for the child so that we'll always
>                    * guarantee the pinned page won't be randomly replaced in the
>                    * future.
>                    */
> -               folio_get(folio);
> -               if (unlikely(folio_try_dup_anon_rmap_pte(folio, page, src_vma))) {
> +               folio_ref_add(folio, nr);
> +               if (unlikely(folio_try_dup_anon_rmap_ptes(folio, page, nr, src_vma))) {
>                           /* Page may be pinned, we have to copy. */
> -                       folio_put(folio);
> -                       return copy_present_page(dst_vma, src_vma, dst_pte, src_pte,
> -                                                addr, rss, prealloc, page);
> +                       folio_ref_sub(folio, nr);
> +                       ret = copy_present_page(dst_vma, src_vma, dst_pte,
> +                                               src_pte, addr, rss, prealloc,
> +                                               page);
> +                       return ret == 0 ? 1 : ret;
>                   }
> -               rss[MM_ANONPAGES]++;
> +               rss[MM_ANONPAGES] += nr;
>           } else if (page) {
> -               folio_get(folio);
> -               folio_dup_file_rmap_pte(folio, page);
> -               rss[mm_counter_file(page)]++;
> +               nr = folio_nr_pages_cont_mapped(folio, page, src_pte, addr, end,
> +                                               pte, enforce_uffd_wp, &nr_dirty,
> +                                               &nr_writable);
> +               folio_ref_add(folio, nr);
> +               folio_dup_file_rmap_ptes(folio, page, nr);
> +               rss[mm_counter_file(page)] += nr;
>           }
> 
> 
> We'll have to test performance, but it could be that we want to specialize
> more on !folio_test_large(). That code is very performance-sensitive.
> 
> 
> [1] https://lkml.kernel.org/r/20231204142146.91437-1-david@redhat.com

So, on top of [1] without rmap batching but with a slightly modified 
version of yours (that keeps the existing code structure as pointed out 
and e.g., updates counter updates), running my fork() microbenchmark 
with a 1 GiB of memory:

Compared to [1], with all order-0 pages it gets 13--14% _slower_ and 
with all PTE-mapped THP (order-9) it gets ~29--30% _faster_.

So looks like we really want to have a completely seprate code path for 
"!folio_test_large()" to keep that case as fast as possible. And 
"Likely" we want to use "likely(!folio_test_large()". ;)

Performing rmap batching on top of that code only slightly (another 1% 
or so) improves performance in the PTE-mapped THP (order-9) case right 
now, in contrast to other rmap batching. Reason is as all rmap code gets 
inlined here and we're only doing subpage mapcount updates + PAE handling.

-- 
Cheers,

David / dhildenb

