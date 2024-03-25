Return-Path: <linux-kernel+bounces-116722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD1588A543
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B47DB22A0A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8A7144D0D;
	Mon, 25 Mar 2024 10:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WOMb5zz+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEF2153587
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 08:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711357075; cv=none; b=fZoqP7k0salBkJXpOZv44CeWc6FnC6ZJi5ba3N0RmSXN1izbiye2V9SAY55geeIrcVlhDI6b6YWE7NkwbPyAuPdwF4tVd6YoNJhWu/VBZAIl+sycYuH9Z14dswLZ+T79NhTkafx4Fb4pGSxRyr2WDbIwKskXOhA/oaFDwJPmK4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711357075; c=relaxed/simple;
	bh=GziPOiRtKGtmT9kOn/TQJ2iwd6JunUdIyzWdMOCM96I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jzfhRiIp2DB1Vq3umBlHxuYDWYr0cWDylGNKwOH/CKmlyK1EQuuWwrqe4jyDyPnbRuguw6F3+j19D3e/dgF1GiXMarX1uT0Xu1ABMXYLecIw/Fc8Q29JEgtrpv2QntM61YjApZFrxdnEhHtPtQi+xltclsAFj92PtE/p+h/Duso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WOMb5zz+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711357072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pZyzpi9K7bsdk4j5yl1WxVOCYrVneu5x/R/AwPZUAn4=;
	b=WOMb5zz+nKCI7Qe7rZwiX6kjjj8mP6d0AUa6RLk2Tvd9ZieD3ePuMU94+GVe/9cgLUJMcY
	1BS0Ov6XYMaLsfZvK+m5T+j2xl32+Pmt+Tde5yVBtMDlwL5cs6VLOhT9Hcx1e75dvXjcp9
	6CMunXi7MFsPd2Y3ByZrh9LIO0Ikl5o=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-EIbDKphRM4eucWh7Nv758Q-1; Mon, 25 Mar 2024 04:57:51 -0400
X-MC-Unique: EIbDKphRM4eucWh7Nv758Q-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2d486c08c6eso39973611fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 01:57:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711357070; x=1711961870;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZyzpi9K7bsdk4j5yl1WxVOCYrVneu5x/R/AwPZUAn4=;
        b=QegKru7cpBCwyGQC9z2HyM5OkN1ds8Bz1giCksviIKt6FKP37pQWLP/ukWptVIW9OB
         CC0Qv3tKXffu6RGjiWwdqO8HX/oXbXxS66q2U7IMikF7VJUWblIEjzrqbFU4BSU1EHtd
         kY5hC3ieU3L7Oo1xKulttNvJbX8RAjIcUGw60OzYyFfCW2m95ScyM5puGoggmtrNMZg4
         rfO3gwCxaoQaeBtFcPw/x1ExbaIlDBkXywlWJV1pnWD0MxBViwAq08el1JbRjdcEsG8D
         8F49tfUr7SZTesFLlUSc6U97U4PEN40VfbWbwdyZZ+7y7ZRTWwH6WwGC3SJ/syG+/1bz
         OtQg==
X-Gm-Message-State: AOJu0YweVJTQbIkzCcyH+CjF5RRS9e16a80nLv6HEfSxt2X1SBb07/Hy
	uG4KaE0ll63luaJGAXQ+6YC5+o7v8PstHvyqTgnxjzchrKqL+qmXaz0VEsgStOmvHDbtmwsUQtI
	WIOUHkbIlD8A5SfPeaoj/Ql5R6YB2k5N4ccJKMDhtWcFVvcuL2t3zLN0CoSVgDi0gLp7Eqwgj+H
	VPuIyDwPUanU5a5M/IievuVh9XxY8TcEm8NNU6WEQVmQ==
X-Received: by 2002:a2e:8014:0:b0:2d4:376f:5b44 with SMTP id j20-20020a2e8014000000b002d4376f5b44mr3965364ljg.34.1711357069954;
        Mon, 25 Mar 2024 01:57:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNzbeNzbJTn6JFsSysiPSbuof6Lkep/SYx4bIM5mFKTaxJVI0ixjyRg+uk4F8J/Zmx6l76Fw==
X-Received: by 2002:a2e:8014:0:b0:2d4:376f:5b44 with SMTP id j20-20020a2e8014000000b002d4376f5b44mr3965338ljg.34.1711357069413;
        Mon, 25 Mar 2024 01:57:49 -0700 (PDT)
Received: from ?IPV6:2003:cb:c738:b400:6a82:1eac:2b5:8fca? (p200300cbc738b4006a821eac02b58fca.dip0.t-ipconnect.de. [2003:cb:c738:b400:6a82:1eac:2b5:8fca])
        by smtp.gmail.com with ESMTPSA id k30-20020a05600c1c9e00b0041469869d11sm7763099wms.47.2024.03.25.01.57.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 01:57:49 -0700 (PDT)
Message-ID: <dd0ad9f2-2d7a-45f3-9ba3-979488c7dd27@redhat.com>
Date: Mon, 25 Mar 2024 09:57:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm: convert folio_estimated_sharers() to
 folio_likely_mapped_shared()
Content-Language: en-US
To: linux-kernel@vger.kernel.org, akpm@linuxfoundation.org
Cc: linux-mm@kvack.org, Barry Song <v-songbaohua@oppo.com>,
 Vishal Moola <vishal.moola@gmail.com>, Ryan Roberts <ryan.roberts@arm.com>
References: <20240227201548.857831-1-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240227201548.857831-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.02.24 21:15, David Hildenbrand wrote:
> Callers of folio_estimated_sharers() only care about "mapped shared vs.
> mapped exclusively", not the exact estimate of sharers. Let's consolidate
> and unify the condition users are checking. While at it clarify the
> semantics and extend the discussion on the fuzziness.
> 
> Use the "likely mapped shared" terminology to better express what the
> (adjusted) function actually checks.
> 
> Whether a partially-mappable folio is more likely to not be partially
> mapped than partially mapped is debatable. In the future, we might be able
> to improve our estimate for partially-mappable folios, though.
> 
> Note that we will now consistently detect "mapped shared" only if the
> first subpage is actually mapped multiple times. When the first subpage
> is not mapped, we will consistently detect it as "mapped exclusively".
> This change should currently only affect the usage in
> madvise_free_pte_range() and queue_folios_pte_range() for large folios: if
> the first page was already unmapped, we would have skipped the folio.
> 
> Cc: Barry Song <v-songbaohua@oppo.com>
> Cc: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

The following fixup on top to make kerneldoc happy:


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


