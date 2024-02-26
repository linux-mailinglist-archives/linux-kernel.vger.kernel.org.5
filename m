Return-Path: <linux-kernel+bounces-81994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 946A8867D83
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7D321C24E36
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E156E12FF7C;
	Mon, 26 Feb 2024 16:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="it1F984Q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D46112C7E1
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 16:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708966577; cv=none; b=pFZedskzWOQCYtH+xPWlBA1E6mpobp1fFTcDb8PJQoKJ3FfvOsasIjzY3OwblKbENYaboVTlDUwSU1VR9ucO5V6RsSDu05IvYjv9ON8DEQoMs5rUME+rV2OmQHQZ+n/Hw04RBEtHgFyOU5Mb9TQSRuJPYGKoMDGwGJT+82bWkWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708966577; c=relaxed/simple;
	bh=SDpGx07c82kkWDvDLBcxoJ8sEvb9l9uRNMiuyfgfaD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WgwVhKzqX7306iziSS07ruBbTIkairIXwQNP1i0UYKmPsRvMokYnP6b/Ob3PrfaVLkFXwfPl5cFyTJOwE3uxCRptz59AR5kGVgDPWcw5QDxtkRhiVBNst23T6hrRZzI6G+hiZSXyyJEvUFAXsGIiDWgi8T25egIDnL6bSij6k3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=it1F984Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708966574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=L8ZYuM556rFAGa1fx6SYRADlzxIlSq0PPDJ7cCfgDPk=;
	b=it1F984QoRrzGo6eSp6/QRwK1ESD9T+QUktKoaQCltGJ4cPaT4G2IBix7bzR37OFySx9wY
	cYSO/ONQmAAGemb1aj+fwEzqHO0ScOpy/HHDstmvVQWkeUJWCbYU/9NCVqTWbrPA2Tmnip
	gMn32rxar/RfjU4jKy+SHxHJYqCmUfY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-Dm-kyfVEOtiliKR5C0iykA-1; Mon, 26 Feb 2024 11:56:12 -0500
X-MC-Unique: Dm-kyfVEOtiliKR5C0iykA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33dc175ff8fso1358309f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 08:56:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708966571; x=1709571371;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L8ZYuM556rFAGa1fx6SYRADlzxIlSq0PPDJ7cCfgDPk=;
        b=bk1L1cD8YeavsmzJ4otW9VfyxENExndXQi1Y6F7eDYe13xSNH3wmyhflyfNBIVVG4B
         rZ43yTcXnH5RZw9qDTPdVi1TJgVhydti/DgzJIyMx9Y8n5/Ox5lNXlnhEOib2k3ZlC1v
         fJOv2v76WnETY0mDy4QKiXNZHaDNOGag07934YmduZfi9Ut++iNqCENA7dt+uZqSGkOT
         YuPVarMAugOwgJfFIXxAlJ9cgmYdCmmL/b6upvL53/4XtsCVzTsTMpkY/KdV7BIQsPJZ
         t3c3Y8jYnPknjOlMNmPXWJz7IxN/67Y04vYOs/iUe0bfTUT6NeY9oLQDpS3riMt4BvQ6
         ANIg==
X-Gm-Message-State: AOJu0YyXM3+f4UFgOuYUnGzptQ0v5NkWz0rwwi/kpPX2pFhF2RSs9WHq
	wU50wUcR6X2uyJy+Izserg02ISg2S5pkxUHYR1v2qXLQKEafF2lV8OYX3I+DiRI+gn4B5Bl76hw
	jokfDOBXJ6cVqbO5ZkbHQkwj2YYKJykyB/rCKM2o+/KLfuhZHfDAyi+zKjwuI9HPpKh3u7g==
X-Received: by 2002:adf:e284:0:b0:33d:3098:c1f with SMTP id v4-20020adfe284000000b0033d30980c1fmr5413047wri.44.1708966570978;
        Mon, 26 Feb 2024 08:56:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEyGtfMlkxAt/2r2+lRf/T9PrQvP7CUZvB87UoSHbYZMTZd0INdC863VuMSFR6Ct7ErhMferA==
X-Received: by 2002:adf:e284:0:b0:33d:3098:c1f with SMTP id v4-20020adfe284000000b0033d30980c1fmr5413029wri.44.1708966570539;
        Mon, 26 Feb 2024 08:56:10 -0800 (PST)
Received: from ?IPV6:2003:cb:c72f:f700:104b:9184:1b45:1898? (p200300cbc72ff700104b91841b451898.dip0.t-ipconnect.de. [2003:cb:c72f:f700:104b:9184:1b45:1898])
        by smtp.gmail.com with ESMTPSA id j3-20020a5d4523000000b0033cfa00e497sm8749849wra.64.2024.02.26.08.56.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 08:56:10 -0800 (PST)
Message-ID: <02e4e497-d70f-4f4b-8b2c-55fe3a0b726e@redhat.com>
Date: Mon, 26 Feb 2024 17:56:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm/memfd: refactor memfd_tag_pins() and
 memfd_wait_for_pins()
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>
References: <20240226141324.278526-1-david@redhat.com>
 <20240226141324.278526-2-david@redhat.com>
 <Zdy3KRi3mnA2ZaDQ@casper.infradead.org>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zdy3KRi3mnA2ZaDQ@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.02.24 17:07, Matthew Wilcox wrote:
> On Mon, Feb 26, 2024 at 03:13:23PM +0100, David Hildenbrand wrote:
>> +	xas_for_each(xas, folio, ULONG_MAX) {
>> +		if (!xa_is_value(folio) && memfd_folio_has_extra_refs(folio))
>>   			xas_set_mark(xas, MEMFD_TAG_PINNED);
> 
> ... we decline to tag value entries here ...
> 
>> @@ -95,20 +90,15 @@ static int memfd_wait_for_pins(struct address_space *mapping)
>>   
>>   		xas_set(&xas, 0);
>>   		xas_lock_irq(&xas);
>> -		xas_for_each_marked(&xas, page, ULONG_MAX, MEMFD_TAG_PINNED) {
>> +		xas_for_each_marked(&xas, folio, ULONG_MAX, MEMFD_TAG_PINNED) {
>>   			bool clear = true;
>>   
>> -			cache_count = 1;
>> -			if (!xa_is_value(page) &&
>> -			    PageTransHuge(page) && !PageHuge(page))
>> -				cache_count = HPAGE_PMD_NR;
>> -
>> -			if (!xa_is_value(page) && cache_count !=
>> -			    page_count(page) - total_mapcount(page)) {
>> +			if (!xa_is_value(folio) &&
>> +			    memfd_folio_has_extra_refs(folio)) {
> 
> ... so we don't need to test it here because we'll never see any value
> entries.  No?

I was not able to convince myself that swapout code would clear the mark 
when replacing the entry.

shmem_writepage()->shmem_delete_from_page_cache()->shmem_replace_entry()

will perform a xas_store() with swp_to_radix_entry(swap) under 
xa_lock_irq().

Reading the doc, and staring at the code for a bit too long, I think 
xas_store() would only clear tags when deleting an entry (passing NULL).

But maybe xas_store() will always clear tags?

In memfd code, I think we could see swapout between memfd_tag_pins() and 
the check for tags, where we drop the xa_lock. Unless some other lock 
(inode lock?) protects us.

Thanks!

-- 
Cheers,

David / dhildenb


