Return-Path: <linux-kernel+bounces-116723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 810B688A2DD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0868F2E0B8E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7C26CDCB;
	Mon, 25 Mar 2024 10:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pp0Lgzsr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00128161308
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 08:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711356996; cv=none; b=jgclOpzVGpAyCgZ9YtTRZGKcWqsmLU7ev7zd95CsDtxfwXxy93BjjHPefQ3JioHTbHiRl2Q6UOhy+OJSKUkZVJ33g/x/sKrGFQh0GJGHzhkKPro6QJ5qLhBBYSA+8AAJJUBJj3UMXmbuBSdzYDU2JH+KgpVS8mc2zSZikWZUcWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711356996; c=relaxed/simple;
	bh=SeAU1jrjWtZUgQVReeR6U+iS4ui9QpW84hBQGpCga0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dbw85VAu4Ao3KevHmDUeE+WRDQK2Q9Ojc2CL439sWWKMAQ1+cmEaBAL4vsylrufBORxFLpms27gME3S1PRK/TVcYNEAXljv1vohJ+oAzHREMb1wTOh4lmDpNoB5pbM4sfd7126fZI33Y7ZvVmCb3f5sN/D+oSwOWVKKivKePDJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pp0Lgzsr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711356993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VTiL9YgVP/MAE1QhsPxOonqe4MNQ1qaQe56fmMWAciI=;
	b=Pp0Lgzsruqkh9SqvWbPLB4pjDXyrZ2iMkjz3vsEthU9u3OTzoZe0VtUJG2mnCykkv5qGrg
	uACZYrA5/PwtPdvX3teIsvtOtceivAd1aX+54dDcwkGcg4K2ge88RA2L940o4CW+t061N8
	A7Z90kKrCbBkdeZZaUzjmkF2zDXrDk0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-8BCCgwK8O6SLGNj1PT8wiw-1; Mon, 25 Mar 2024 04:56:30 -0400
X-MC-Unique: 8BCCgwK8O6SLGNj1PT8wiw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4140d2917e6so22579305e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 01:56:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711356989; x=1711961789;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VTiL9YgVP/MAE1QhsPxOonqe4MNQ1qaQe56fmMWAciI=;
        b=MnvPeLsYFRWNYusN1k+ZSP/Dcl4Hv5YG6bjD05ezrQT94erHxer8Cmtnon8KGO8EFM
         WxMfYNsIcpDvmNsco9CVZTYy7nSZqmzcMyZGiMjOSryAJeqRLYhyqAIZq8KklVQFU0An
         SfurGiirTS16QeHPQj6jCv0xkJ8wgZo7/tXcw2EsXpcVBiqat6htbe/xu59DUPDinuuj
         nZbAeYON1UUIle5gsdK6X0ugv71O+7BsXi71ntt5szEFTr1LwsazlZOdNqriPQqcpsk2
         DejcSezIepxfBrBw9HCot+0JGNq8LedTbWRom7jf+icHC4q95MPCupGB7Ssn5J7R0be2
         VFxQ==
X-Gm-Message-State: AOJu0YxEsXCiwrRYhDEp0aXx5xCJv+7DSUO5NcRAiI/ZhPZAIKEP3H0M
	6GkIbsSsM6nsBdIcG11NKBvI9/d2WkSIPXgwuJe0GmrYtIiXak/Itte71LAxX1YUS2mm6vlgAIm
	PajnP5dLgLymV4LHSMmH6iDWhf4N0cfecUg9xKAO+0IWkXXzrvaYlk23WOe68XSVd6eTUWw==
X-Received: by 2002:a05:600c:524c:b0:414:8abb:a96b with SMTP id fc12-20020a05600c524c00b004148abba96bmr611222wmb.34.1711356989307;
        Mon, 25 Mar 2024 01:56:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdx8qJrJqYTJj20nYwwryKiBqzCd80D5r5FkVUWwJopLPpsWro19Qh6ZlhaYvOH4johY6eNg==
X-Received: by 2002:a05:600c:524c:b0:414:8abb:a96b with SMTP id fc12-20020a05600c524c00b004148abba96bmr611210wmb.34.1711356988913;
        Mon, 25 Mar 2024 01:56:28 -0700 (PDT)
Received: from ?IPV6:2003:cb:c738:b400:6a82:1eac:2b5:8fca? (p200300cbc738b4006a821eac02b58fca.dip0.t-ipconnect.de. [2003:cb:c738:b400:6a82:1eac:2b5:8fca])
        by smtp.gmail.com with ESMTPSA id k30-20020a05600c1c9e00b0041469869d11sm7763099wms.47.2024.03.25.01.56.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 01:56:28 -0700 (PDT)
Message-ID: <074ff62c-1533-4566-9375-24e353b53712@redhat.com>
Date: Mon, 25 Mar 2024 09:56:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build warning after merge of the mm tree
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20240325122250.48128d5a@canb.auug.org.au>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
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
In-Reply-To: <20240325122250.48128d5a@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.03.24 02:22, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the mm tree, today's linux-next build (htmldocs) produced
> this warning:
> 
> Documentation/core-api/mm-api:112: include/linux/mm.h:2187: ERROR: Unexpected indentation.
> Documentation/core-api/mm-api:112: include/linux/mm.h:2189: WARNING: Block quote ends without a blank line; unexpected unindent.
> Documentation/core-api/mm-api:112: include/linux/mm.h:2199: ERROR: Unexpected indentation.
> Documentation/core-api/mm-api:112: include/linux/mm.h:2200: WARNING: Block quote ends without a blank line; unexpected unindent.
> 
> Introduced by commit
> 
>    08ec651d776e ("mm: convert folio_estimated_sharers() to folio_likely_mapped_shared()")
> 
> from the mm-unstable branch of the mm tree.
> 

Seems like kerneldoc does not appreciate my lists+indentation. The following
should get the job done:

 From 3e472636d266e3acba3755ed5712992adbc2151d Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Mon, 25 Mar 2024 09:23:03 +0100
Subject: [PATCH] folio_likely_mapped_shared() kerneldoc fixup

Fixup "mm: convert folio_estimated_sharers() to
folio_likely_mapped_shared()".

Signed-off-by: David Hildenbrand <david@redhat.com>
---
  include/linux/mm.h | 32 +++++++++++++++++---------------
  1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index afe27ff3fa94..fb3724723448 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2183,23 +2183,25 @@ static inline size_t folio_size(struct folio *folio)
   * at most once into an MM, and they cannot be partially mapped.
   *
   * For other folios, the result can be fuzzy:
- * (a) For partially-mappable large folios (THP), the return value can wrongly
- *     indicate "mapped exclusively" (false negative) when the folio is
- *     only partially mapped into at least one MM.
- * (b) For pagecache folios (including hugetlb), the return value can wrongly
- *     indicate "mapped shared" (false positive) when two VMAs in the same MM
- *     cover the same file range.
- * (c) For (small) KSM folios, the return value can wrongly indicate "mapped
- *     shared" (false negative), when the folio is mapped multiple times into
- *     the same MM.
+ *    #. For partially-mappable large folios (THP), the return value can wrongly
+ *       indicate "mapped exclusively" (false negative) when the folio is
+ *       only partially mapped into at least one MM.
+ *    #. For pagecache folios (including hugetlb), the return value can wrongly
+ *       indicate "mapped shared" (false positive) when two VMAs in the same MM
+ *       cover the same file range.
+ *    #. For (small) KSM folios, the return value can wrongly indicate "mapped
+ *       shared" (false negative), when the folio is mapped multiple times into
+ *       the same MM.
   *
   * Further, this function only considers current page table mappings that
- * are tracked using the folio mapcount(s). It does not consider:
- * (1) If the folio might get mapped in the (near) future (e.g., swapcache,
- *     pagecache, temporary unmapping for migration).
- * (2) If the folio is mapped differently (VM_PFNMAP).
- * (3) If hugetlb page table sharing applies. Callers might want to check
- *     hugetlb_pmd_shared().
+ * are tracked using the folio mapcount(s).
+ *
+ * This function does not consider:
+ *    #. If the folio might get mapped in the (near) future (e.g., swapcache,
+ *       pagecache, temporary unmapping for migration).
+ *    #. If the folio is mapped differently (VM_PFNMAP).
+ *    #. If hugetlb page table sharing applies. Callers might want to check
+ *       hugetlb_pmd_shared().
   *
   * Return: Whether the folio is estimated to be mapped into more than one MM.
   */
-- 
2.43.2


-- 
Cheers,

David / dhildenb


