Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545A27EE9E1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 00:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjKPXK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 18:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKPXKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 18:10:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C60D4A
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 15:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700176220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=+MKeibb6KnKnaA+iE0iv1obj46zXM3TXwKHeMWH8DpE=;
        b=FxRr1p9kBQD8SqJSQQtJ11OPPTF0QnHJhqJ9rPBpjNATk0PmUKiFO3CowVmFe9ZopQY4fH
        7LhNfSwbd2WnJLaT4xgkUzOrBfgeogL6iaV6YKr5LoOaKFh7+RlESPpgkXlIgbwWQVmFyb
        KJ4Ak1ZNYbwoGwdS/RP2y2d+Ukas5Mg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-ng2OKuG0NnKrvZdyJ8yCAw-1; Thu, 16 Nov 2023 18:10:19 -0500
X-MC-Unique: ng2OKuG0NnKrvZdyJ8yCAw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4084001846eso8814065e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 15:10:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700176218; x=1700781018;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+MKeibb6KnKnaA+iE0iv1obj46zXM3TXwKHeMWH8DpE=;
        b=YU5OQSfc3r/xf9Pg8sgl0AwZfgdv5uHzESS1T05ObXlhg4nW0ER8bzBlk4Mw3K5NXP
         6Sg9Bb0eYVuqRr8brlaQblKSTAaFhrCpfjZAx4X7iYre8nq9sPbbht7Q95b01Y2F6wNc
         RFhhqGZ8n6OVr17PX1Svh26ebSo/wp4JkeZYJXXF3P2WZoxVyo1VJY6akgQBytFqpUr7
         xsiB2weSH3N2lFZDrWj95pOQosChIazmbdJKfMjPGrR3UYk2FOUp1VF7dJETAY3dJQ7b
         XJreYlP6d+rhdF51zdUCU9p8JmXrhHyYld1vRTXADOJhbDURovyNguV++t8cJd2CCNId
         Kpnw==
X-Gm-Message-State: AOJu0YyD+1daycy/+zLS3ma+sQqxDHMmp8V7+7tcdip7nLn65jiLhfGQ
        sbX17LizjqLaEWiJgtytUnOn4IOttlcpIXAtF5sK0r9MWqGpJeKtT94TunF6FRd/g1taS5oL3iD
        aNQaJ56yKrMf0GXaYGuqUG7Pb
X-Received: by 2002:a5d:64cd:0:b0:32d:8830:ee2 with SMTP id f13-20020a5d64cd000000b0032d88300ee2mr16315194wri.43.1700176218356;
        Thu, 16 Nov 2023 15:10:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQ5ev20kMVvuY/jGfQ6WXoGS09jmwNDwDquYUYfg5EhOSnq0pu0DG+aLWEXCkaL3A/isVylQ==
X-Received: by 2002:a5d:64cd:0:b0:32d:8830:ee2 with SMTP id f13-20020a5d64cd000000b0032d88300ee2mr16315180wri.43.1700176217987;
        Thu, 16 Nov 2023 15:10:17 -0800 (PST)
Received: from ?IPV6:2003:cb:c714:e000:d929:2324:97c7:112c? (p200300cbc714e000d929232497c7112c.dip0.t-ipconnect.de. [2003:cb:c714:e000:d929:2324:97c7:112c])
        by smtp.gmail.com with ESMTPSA id d5-20020adfef85000000b0032fb46812c2sm573718wro.12.2023.11.16.15.10.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 15:10:17 -0800 (PST)
Message-ID: <b930ef9c-8795-40f6-bcad-11d081f65e5e@redhat.com>
Date:   Fri, 17 Nov 2023 00:10:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] mm/pagemap: Fix ioctl(PAGEMAP_SCAN) on vma check
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrei Vagin <avagin@gmail.com>,
        syzbot+e94c5aaf7890901ebf9b@syzkaller.appspotmail.com
References: <20231116201547.536857-1-peterx@redhat.com>
 <20231116201547.536857-2-peterx@redhat.com>
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
In-Reply-To: <20231116201547.536857-2-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.11.23 21:15, Peter Xu wrote:
> The new ioctl(PAGEMAP_SCAN) relies on vma wr-protect capability provided by
> userfault, however in the vma test it didn't explicitly require the vma to
> have wr-protect function enabled, even if PM_SCAN_WP_MATCHING flag is set.
> 
> It means the pagemap code can now apply uffd-wp bit to a page in the vma
> even if not registered to userfaultfd at all.
> 
> Then in whatever way as long as the pte got written and page fault
> resolved, we'll apply the write bit even if uffd-wp bit is set.  We'll see
> a pte that has both UFFD_WP and WRITE bit set.  Anything later that looks
> up the pte for uffd-wp bit will trigger the warning:
> 
> WARNING: CPU: 1 PID: 5071 at arch/x86/include/asm/pgtable.h:403 pte_uffd_wp arch/x86/include/asm/pgtable.h:403 [inline]
> 
> Fix it by doing proper check over the vma attributes when
> PM_SCAN_WP_MATCHING is specified.
> 
> Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and optionally clear info about PTEs")
> Reported-by: syzbot+e94c5aaf7890901ebf9b@syzkaller.appspotmail.com
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

