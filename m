Return-Path: <linux-kernel+bounces-153921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AADF48AD4DF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6138E2822CB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E36F155338;
	Mon, 22 Apr 2024 19:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ExsgPTj8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB57154BF9
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 19:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713814294; cv=none; b=q52uoz0PE7dCYxBgAocqPx1PgsSei/Ey8tEvSSTnMGB6pox1hTNJ4lL1NU+v/a8TPqbmeYWsrhLpBAj2TConzpEwW8oC7eZqSQi/wwdeKUbfEgOfJJ/NwOhnw8XRBe0ErCnnHK9VhBQw2wDXPrtKipjKM9TBL5fFg2omwSj4DO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713814294; c=relaxed/simple;
	bh=TFfGHMKQOZun9bEi6Y0n/pcGDKNvx+RYmUjxyt5eLWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VSKxm0x3afgYlgWErOCKOoVYifKaJgJopQeCHM0I/1uFN8mPm8ZTZTQkpbSg73ksSp67X5cNKQyEyGfZtHptR6iGBoYLDryaydGcUgBEajz89bguog8GXp1DRRcgnCUxfWkd+23YwXJKUZ1vo5mhd0xkYVJRXTLiBkMGVSy4ouo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ExsgPTj8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713814291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nfeRiUr9RWa+jMkA5amGoh/iwJKq4yrGajf3G0hyl8g=;
	b=ExsgPTj8ZuUkqyADTzCIuENuNY/KJorYLiwcfgaF/DGMAfEod4ooY/7Ja6z+ikG2f1V8me
	Q9sVVhK9LdSAy/o0SMIGUS/sQ4QMqjVGOhKZd/dNaE243FS4rjlO8S2Yq/ZEne7PqBfORP
	SOxG0qkZRjoI7H0FHM7RPcQpYvMbE/U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-T1NcjrADNkmOt1qPOw2Zpg-1; Mon, 22 Apr 2024 15:31:29 -0400
X-MC-Unique: T1NcjrADNkmOt1qPOw2Zpg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-343d6732721so3036722f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 12:31:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713814288; x=1714419088;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nfeRiUr9RWa+jMkA5amGoh/iwJKq4yrGajf3G0hyl8g=;
        b=UgF6ec3TmIwOsuKna/haYJ8r9DrDUnJFuazqQRG4Xeh0WiXzyGepGjYMvngIoSf0XJ
         KL8P9QC0jbpgP6+4qTRHvtMWj3FpYPalR7ti4QVko0XGcw5Oq77QpY7XjodXqOCFOnI/
         tce+6FkPIaAdfKdbrQ4oS98P3HO/HLCwkH9HQdxA0+7FZpjFQfwXrjaJlLWtYDgAFTTH
         iXLC8dnkMlvXee79RaR+6gXvDRbzYL7TSBoGatIbNe2k62OAT4Igu0ApOlqObafakmOu
         +Wq93YaU+JAFiqTainPAXTdb3z11xEWhtA53GOuEHLEJhULbcmKeSdBvsQNDu57clvd5
         /sYg==
X-Forwarded-Encrypted: i=1; AJvYcCXxdiyUdamAHQT1lgHcOf8C8IjSUCItPSruGNJuSD6IqGSeYOqp+LScEIKgfujCYa4IZcEzXkEtKalQtQ9ePBzByhuM9EFLT1ezYyDo
X-Gm-Message-State: AOJu0YxptWa6A1Rysqg0N8M7yGPSFlXm9AitFgfE3UsbVANIVRXsrcx5
	iPMVlPTw45GI+FIuURNxgnrvzj7An4hr20l7pk4ThE1sU13JpZkHsXYySUKo3EG7WgK0sqEL/Os
	dTzOoEfajNqnkjrZvVrPbOfVeDfG49EJeEBeO4rv1b6zYqg5GJmX5AagMwXpZlg==
X-Received: by 2002:a05:6000:10c:b0:346:c0f6:8b8 with SMTP id o12-20020a056000010c00b00346c0f608b8mr9026755wrx.12.1713814288719;
        Mon, 22 Apr 2024 12:31:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErrJssZudGpU2It9IqQjWUj9slucUsRnpeHOVjF4pGZ34BGunkw5/JXthgYECez89vO2Z1BA==
X-Received: by 2002:a05:6000:10c:b0:346:c0f6:8b8 with SMTP id o12-20020a056000010c00b00346c0f608b8mr9026741wrx.12.1713814288236;
        Mon, 22 Apr 2024 12:31:28 -0700 (PDT)
Received: from ?IPV6:2003:cb:c739:600:d2fb:3a8a:9944:7910? (p200300cbc7390600d2fb3a8a99447910.dip0.t-ipconnect.de. [2003:cb:c739:600:d2fb:3a8a:9944:7910])
        by smtp.gmail.com with ESMTPSA id je12-20020a05600c1f8c00b004183edc31adsm21293294wmb.44.2024.04.22.12.31.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 12:31:27 -0700 (PDT)
Message-ID: <d97f8fdc-eb38-485e-81e2-51f748089939@redhat.com>
Date: Mon, 22 Apr 2024 21:31:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm/huge_memory: improve
 split_huge_page_to_list_to_order() return value documentation
To: John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Zi Yan <ziy@nvidia.com>,
 Matthew Wilcox <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20240418151834.216557-1-david@redhat.com>
 <18faa967-4fbc-4694-a7f7-02c3887ee6f3@nvidia.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <18faa967-4fbc-4694-a7f7-02c3887ee6f3@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.04.24 02:15, John Hubbard wrote:
> On 4/18/24 8:18 AM, David Hildenbrand wrote:
>> The documentation is wrong and relying on it almost resulted in BUGs
>> in new callers: we return -EAGAIN on unexpected folio references, not
>> -EBUSY.
>>
>> Let's fix that and also document which other return values we can
>> currently see and why they could happen.
>>
>> Cc: John Hubbard <jhubbard@nvidia.com>
>> Cc: Zi Yan <ziy@nvidia.com>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>    mm/huge_memory.c | 13 ++++++++++---
>>    1 file changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index ee12726291f1b..824eff9211db8 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -2956,7 +2956,7 @@ bool can_split_folio(struct folio *folio, int *pextra_pins)
>>     *
>>     * 3) The folio must not be pinned. Any unexpected folio references, including
>>     *    GUP pins, will result in the folio not getting split; instead, the caller
>> - *    will receive an -EBUSY.
>> + *    will receive an -EAGAIN.
>>     *
>>     * 4) @new_order > 1, usually. Splitting to order-1 anonymous folios is not
>>     *    supported for non-file-backed folios, because folio->_deferred_list, which
>> @@ -2975,8 +2975,15 @@ bool can_split_folio(struct folio *folio, int *pextra_pins)
> 
> As an aside, the use of unconditional local_irq_disable() / local_irq_enable()
> calls in this routine almost makes me believe that we should have:
> 
> 5) Local IRQs should be enabled. Because this routine may enable them.
> 
> ...but I can't imagine a way to end up calling this with interrupts
> disabled, so it seems like documentation overkill. Just thought I'd mention
> it, though.

Yes, I think there might be more issues lurking with disabled interrupts.

anon_vma_lock_write() and i_mmap_lock_read() might even sleep ... so we
must not be in any atomic context. that's why relevant page table walkers drop the PTL.

> 
> 
>>     *
>>     * Returns 0 if the huge page was split successfully.
>>     *
>> - * Returns -EBUSY if @page's folio is pinned, or if the anon_vma disappeared
>> - * from under us.
>> + * Returns -EAGAIN if the folio has unexpected reference (e.g., GUP).
> 
> ...or if the folio was removed from the page cache before this routine
> got a chance to lock it, right? (See the "fail:" path.)

Right, that is sneaky. Let me extend to cover that case as well.

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 824eff9211db8..a7406267323ed 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2975,7 +2975,8 @@ bool can_split_folio(struct folio *folio, int *pextra_pins)
   *
   * Returns 0 if the huge page was split successfully.
   *
- * Returns -EAGAIN if the folio has unexpected reference (e.g., GUP).
+ * Returns -EAGAIN if the folio has unexpected reference (e.g., GUP) or if
+ * the folio was concurrently removed from the page cache.
   *
   * Returns -EBUSY when trying to split the huge zeropage, if the folio is
   * under writeback, if fs-specific folio metadata cannot currently be


Naive me would assume that this happens rarely ... but not an expert :)

> 
>> + *
>> + * Returns -EBUSY when trying to split the huge zeropage, if the folio is
>> + * under writeback, if fs-specific folio metadata cannot currently be
>> + * released, or if some unexpected race happened (e.g., anon VMA disappeared,
>> + * truncation).
>> + *
>> + * Returns -EINVAL when trying to split to an order that is incompatible
>> + * with the folio. Splitting to order 0 is compatible with all folios.
>>     */
>>    int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>>    				     unsigned int new_order)
> 
> Otherwise, looks good.

Thanks!

-- 
Cheers,

David / dhildenb


