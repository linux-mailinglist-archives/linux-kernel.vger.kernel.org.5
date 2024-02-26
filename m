Return-Path: <linux-kernel+bounces-81537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AA3867736
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5C4A1C29BC7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE891292EE;
	Mon, 26 Feb 2024 13:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YQ5PnwfN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C63128386
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 13:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708955434; cv=none; b=gSA9fOn+wAjFOaL5c1s9MUR6m5azhZTlxANMSrE5GuZT5aK2E+cvWGCgcow0AJ9qQjyTCQa4rplIuUlbyjIhJRqwdC5tR7ClvySLr0qjw+oJHp3QtsoWggmo8+E3gaUIDlEEzm66pHeDrFMmCEx4Uv7LeMbKgRLK68srniANGZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708955434; c=relaxed/simple;
	bh=1B5ssE9qAKVAfCNNgDaej8Uv0ChLHq2otxvJ/QFbnVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IMpe28X1n+2VxW7gaIJHAKIiZm3BjvdFoM3OuAjLbfxhvim8gR5RyAd6Lh55FgvUhlzLTIgbWKBUg5bQCc2SYcsGFl0p+6hfMUCzNyN60SlCYvUVS+o5kXr/0R12lU0l7j5Hfx1STgZSTOwuOCfso+t28xuB90rez+6hkL4spaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YQ5PnwfN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708955431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QVCRKSA4ldsqpe3HRG/6UsUQf4b5DTlM1+Qw9DzJKMg=;
	b=YQ5PnwfNW+myGVO22CdrXzZcBsF+oTaBdeUvxILsz0dRagGQMppUa1y1yj0iG0nQnxC+eh
	EKREjdhHV/ujdy4aHwK18Soi9AybGzLdlvQ/HXw/wVttU6zXte4bklSC5fylS7w604YaG0
	kSlgQ6JSFIXQ9rVYWxk8GtkyErU+tW4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-XUeBvHPNOFajO3-fNEwHkA-1; Mon, 26 Feb 2024 08:50:29 -0500
X-MC-Unique: XUeBvHPNOFajO3-fNEwHkA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40d62d3ae0cso17181795e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 05:50:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708955428; x=1709560228;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVCRKSA4ldsqpe3HRG/6UsUQf4b5DTlM1+Qw9DzJKMg=;
        b=ckCYhIXQ0b1FEsc6i3MpInzCjFlTBYQba2QjAzRbSTy3NH2j7pTAQycdTjtYpszL0q
         76dxRTPrb2AQLw7D51BEyMtUML+LVpDio4WWyQcWy1AQxbAG2qIAWSUQt+kRSB9ldzRb
         wcsYaT419019DDetfWV0N0kRftqM7syvN16Ag0lnjuT6NKZpEI3UiXHT19bkXSb3Heui
         PHyprifL72tGHSz3ZUwsXfrgDcgtlLr3nL85QB7a/ccMfMRiTjax9fgHXn/KvTFrIvMk
         TlHCcNZ4Yis6DQcNWkwzrCVOktVforH8ArkTVIYdA3dCImYtxIgxAduAH/EP4WK0xmLm
         iaEA==
X-Gm-Message-State: AOJu0YwZ2yfqgmJVelkO1OFb+ZqjGtYctlg23xq86bxTinAek8pJqnZx
	okkLuraP7Mg7tKT/uTPyyllR4NiMKmRZmjfZeKRJGGjkXSt1OJ03HTgheS2oF1duoO9xKnaJEgl
	g2wJTKtUiqoY+QfX9LNxUi97UV3myO9BhOQM8AJ+3sNlutU7hZQgEaQY9m6oFyw==
X-Received: by 2002:a05:600c:1c14:b0:412:6dd7:1d44 with SMTP id j20-20020a05600c1c1400b004126dd71d44mr4842301wms.17.1708955428029;
        Mon, 26 Feb 2024 05:50:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEb027wYZOdNfWQLGBf7QjQcoi8uUl9MHCUw9pusEZiwiRUrkBvTYeWFsIv0R9V8c8u+8ooSg==
X-Received: by 2002:a05:600c:1c14:b0:412:6dd7:1d44 with SMTP id j20-20020a05600c1c1400b004126dd71d44mr4842284wms.17.1708955427676;
        Mon, 26 Feb 2024 05:50:27 -0800 (PST)
Received: from ?IPV6:2003:cb:c72f:f700:104b:9184:1b45:1898? (p200300cbc72ff700104b91841b451898.dip0.t-ipconnect.de. [2003:cb:c72f:f700:104b:9184:1b45:1898])
        by smtp.gmail.com with ESMTPSA id r1-20020a05600c35c100b0041228b2e179sm8357026wmq.39.2024.02.26.05.50.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 05:50:27 -0800 (PST)
Message-ID: <d1f5f4cf-8cc0-49b3-be78-a14a7ee8100f@redhat.com>
Date: Mon, 26 Feb 2024 14:50:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] madvise:madvise_cold_or_pageout_pte_range(): allow split
 while folio_estimated_sharers = 0
Content-Language: en-US
To: Ryan Roberts <ryan.roberts@arm.com>, Barry Song <21cnbao@gmail.com>,
 akpm@linux-foundation.org, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>,
 Yin Fengwei <fengwei.yin@intel.com>, Yu Zhao <yuzhao@google.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>,
 Matthew Wilcox <willy@infradead.org>, Minchan Kim <minchan@kernel.org>,
 Vishal Moola <vishal.moola@gmail.com>, Yang Shi <shy828301@gmail.com>
References: <20240221085036.105621-1-21cnbao@gmail.com>
 <71fa4302-2df6-4e55-a5a8-7609476c41d4@arm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <71fa4302-2df6-4e55-a5a8-7609476c41d4@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.02.24 14:46, Ryan Roberts wrote:
> On 21/02/2024 08:50, Barry Song wrote:
>> From: Barry Song <v-songbaohua@oppo.com>
>>
>> The purpose is stopping splitting large folios whose mapcount are 2 or
>> above. Folios whose estimated_shares = 0 should be still perfect and
>> even better candidates than estimated_shares = 1.
>>
>> Consider a pte-mapped large folio with 16 subpages, if we unmap 1-15,
>> the current code will split folios and reclaim them while madvise goes
>> on this folio; but if we unmap subpage 0, we will keep this folio and
>> break. This is weird.
>>
>> For pmd-mapped large folios, we can still use "= 1" as the condition
>> as anyway we have the entire map for it. So this patch doesn't change
>> the condition for pmd-mapped large folios.
>> This also explains why we had been using "= 1" for both pmd-mapped and
>> pte-mapped large folios before commit 07e8c82b5eff ("madvise: convert
>> madvise_cold_or_pageout_pte_range() to use folios"), because in the
>> past, we used the mapcount of the specific subpage, since the subpage
>> had pte present, its mapcount wouldn't be 0.
>>
>> The problem can be quite easily reproduced by writing a small program,
>> unmapping the first subpage of a pte-mapped large folio vs. unmapping
>> anyone other than the first subpage.
>>
>> Fixes: 2f406263e3e9 ("madvise:madvise_cold_or_pageout_pte_range(): don't use mapcount() against large folio for sharing check")
>> Cc: Yin Fengwei <fengwei.yin@intel.com>
>> Cc: Yu Zhao <yuzhao@google.com>
>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Minchan Kim <minchan@kernel.org>
>> Cc: Vishal Moola (Oracle) <vishal.moola@gmail.com>
>> Cc: Yang Shi <shy828301@gmail.com>
>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>> ---
>>   mm/madvise.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/madvise.c b/mm/madvise.c
>> index cfa5e7288261..abde3edb04f0 100644
>> --- a/mm/madvise.c
>> +++ b/mm/madvise.c
>> @@ -453,7 +453,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>>   		if (folio_test_large(folio)) {
>>   			int err;
>>   
>> -			if (folio_estimated_sharers(folio) != 1)
>> +			if (folio_estimated_sharers(folio) > 1)
>>   				break;
>>   			if (pageout_anon_only_filter && !folio_test_anon(folio))
>>   				break;
> 
> I wonder if we should change all the instances:
> 
> folio_estimated_sharers() != 1   ->   folio_estimated_sharers() > 1
> folio_estimated_sharers() == 1   ->   folio_estimated_sharers() <= 1

I'll send out something that wraps that in folio_mapped_shared() later 
today or tomorrow.

-- 
Cheers,

David / dhildenb


