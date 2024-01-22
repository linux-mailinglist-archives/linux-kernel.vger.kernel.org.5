Return-Path: <linux-kernel+bounces-33739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EECF836DFE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F17F31F231B2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0498547F74;
	Mon, 22 Jan 2024 17:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bDRwROAf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5B041767
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 17:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705942927; cv=none; b=i2U2AdTr7AJUqdDqc3iwwIyWNa3pi4yMP2116OngNfSk37zRhXJVLJ3ckZtcqlcfrUrjZdfgl2i7SraT4NNPgwTjjgh6t2WtaBo7eUMzBelnlNLwqGA/h4TBaVFzj/CFiLU6YOpR0prASR09Sm4jV22HMSwzLpsqGVtlV3Ifk4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705942927; c=relaxed/simple;
	bh=jBglYrXID9SRngGLw6crEJwun/a6h41WDV4D4dVusAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FPwtKxW4p3wr76lsm2J6ZEQB3jaRrZ7rVj3riRcu/PvYC69qP5To1bpls+8cPf4kQIPXrgQOMg4ZSywmy3/vuzP7sXLrghzgqCFqm7192ftC2E5Bv8UkZ6L3sEFQRbt6ML8zxvSgaHccoqgEcf82yc0eCCYznbagJUfQBEtN6L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bDRwROAf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705942924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dOr3M/UPrLub/x/c3PZ8Lu+PQBMgphrZEZ1ZGLkQwfE=;
	b=bDRwROAfj9xwsvBkzU17F2XdUYu+sAUGkaa9BIr68qRIIkZb6HY7aQLT9iskrNc03HSBtm
	JsZr/pH4EMVb464mUFaDy/zcIGtRDX+CJYjCCupFLa4k+nG1tRfLwwL7eX9/Q/gAbBFaF5
	JCw9yRqCsdlce0l7vx7o1zcI4qjv2x0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-2C0Ni8LLORmIwAtXsSpUPA-1; Mon, 22 Jan 2024 12:02:02 -0500
X-MC-Unique: 2C0Ni8LLORmIwAtXsSpUPA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-337cc89a049so1713964f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 09:02:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705942920; x=1706547720;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dOr3M/UPrLub/x/c3PZ8Lu+PQBMgphrZEZ1ZGLkQwfE=;
        b=bIElBEEtkj8BUWnIrR6lq60LDqqzX0/HttyPsuqnvo/K2PWfDwOOwEYzvvuyVUJBym
         blA+w3zmgAF1E0BqhIqeP6zrWyGfIRvx1uHeZ0dtE9TJILFwD9dXiOZvp53IrHO7Mkzy
         Uhl6Fwxxuldn4zZcLyRVs2wTwobP/5UJY+qqPMc9beqVaz0YoOjQWgxvmUjL2um5EFcn
         cubGLYDrRIozl1PlBXKem9Tb8skWaXsrV8WTaMN84pyAjDOv3AKyKypA7Cljdal1r0VW
         z9w46gQhBBfgLecQ0Uq5KxpbF0xwMimZzRJsGjqA6jXEwelY8JUhFn4rkDbS1SHhiPro
         /Smg==
X-Gm-Message-State: AOJu0Yzs4rMGWl26uxuZsnBx/El4AsgRW/gBtS6Lxkslhf5s5udJMANN
	5yGEhqdtbGcSZ0uyVXidBipTVf5CgqOCJvH2WhWARcQVtIyoxvpkgibnwspn0m/aKl5Jt7qyQDS
	2XNTt07c0wEVgnKwfirbwJKT88knWHALVMPAu9y2dUbdlbohMFJtKEbogyT6Ccg==
X-Received: by 2002:a5d:4a0c:0:b0:337:c4e2:a1de with SMTP id m12-20020a5d4a0c000000b00337c4e2a1demr2194593wrq.105.1705942920333;
        Mon, 22 Jan 2024 09:02:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEUOIF5rkWUUJ+hLGMup5NPgQg8SO8qlc9p87ZfoF44SznQROhwbW8uQS+KYAmTt4Ct+qf6TA==
X-Received: by 2002:a5d:4a0c:0:b0:337:c4e2:a1de with SMTP id m12-20020a5d4a0c000000b00337c4e2a1demr2194575wrq.105.1705942919863;
        Mon, 22 Jan 2024 09:01:59 -0800 (PST)
Received: from ?IPV6:2003:cb:c737:f400:b194:1841:c4a5:75f5? (p200300cbc737f400b1941841c4a575f5.dip0.t-ipconnect.de. [2003:cb:c737:f400:b194:1841:c4a5:75f5])
        by smtp.gmail.com with ESMTPSA id x7-20020a5d6507000000b003392940f749sm6660821wru.77.2024.01.22.09.01.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 09:01:59 -0800 (PST)
Message-ID: <007e83fa-16c7-4700-b326-ee8cb7809f9f@redhat.com>
Date: Mon, 22 Jan 2024 18:01:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 28/40] mm/memory: page_remove_rmap() ->
 folio_remove_rmap_pte()
Content-Language: en-US
To: Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Hugh Dickins <hughd@google.com>, Yin Fengwei <fengwei.yin@intel.com>,
 Mike Kravetz <mike.kravetz@oracle.com>, Muchun Song <muchun.song@linux.dev>,
 Peter Xu <peterx@redhat.com>
References: <20231220224504.646757-1-david@redhat.com>
 <20231220224504.646757-29-david@redhat.com>
 <2445cedb-61fb-422c-8bfb-caf0a2beed62@arm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <2445cedb-61fb-422c-8bfb-caf0a2beed62@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.01.24 17:58, Ryan Roberts wrote:
> On 20/12/2023 22:44, David Hildenbrand wrote:
>> Let's convert zap_pte_range() and closely-related
>> tlb_flush_rmap_batch(). While at it, perform some more folio conversion
>> in zap_pte_range().
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   mm/memory.c     | 23 +++++++++++++----------
>>   mm/mmu_gather.c |  2 +-
>>   2 files changed, 14 insertions(+), 11 deletions(-)
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 6552ea27b0bfa..eda2181275d9b 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -1434,6 +1434,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>>   	arch_enter_lazy_mmu_mode();
>>   	do {
>>   		pte_t ptent = ptep_get(pte);
>> +		struct folio *folio;
>>   		struct page *page;
>>   
>>   		if (pte_none(ptent))
>> @@ -1459,21 +1460,22 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>>   				continue;
>>   			}
>>   
>> +			folio = page_folio(page);
>>   			delay_rmap = 0;
>> -			if (!PageAnon(page)) {
>> +			if (!folio_test_anon(folio)) {
>>   				if (pte_dirty(ptent)) {
>> -					set_page_dirty(page);
>> +					folio_set_dirty(folio);
> 
> Is this foliation change definitely correct? I note that set_page_dirty() is
> defined as this: >
> bool set_page_dirty(struct page *page)
> {
> 	return folio_mark_dirty(page_folio(page));
> }
> 
> And folio_mark_dirty() is doing more than just setting teh PG_dirty bit. In my
> equivalent change, as part of the contpte series, I've swapped set_page_dirty()
> for folio_mark_dirty().

Good catch, that should be folio_mark_dirty(). Let me send a fixup.

(the difference in naming for both functions really is bad)


-- 
Cheers,

David / dhildenb


