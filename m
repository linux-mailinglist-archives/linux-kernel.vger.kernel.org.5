Return-Path: <linux-kernel+bounces-104387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B259487CD20
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 13:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6CF01C218ED
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019131C694;
	Fri, 15 Mar 2024 12:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EIqwtruI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C3A1C683
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 12:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710505111; cv=none; b=pD9Jl3dMes+JfmbW6vIudpodzGa7AyCUbfIsaTcznC7spb0MYmaFTdHwiQ+sd0Vmcosam7eIrOYZslSt73EJzRCxzSKd+Ew43+oqkWLzteOZ0/iZTFgctScbHQTy1tS+arS+eE+asyMsxwRljpT0vNn9ty6h2mAcMJ4c6rGFRY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710505111; c=relaxed/simple;
	bh=SQgqXlRnDyw92kAhwjNwDxeeaCrqlR2DKUqUs6S3GpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AlL+f5PwU7OxR640zJIxvnRtYYn+Z5lpYfne0l9sdpxjRXQBzDdmBJvnyXsYryBXtqxkGrWjoqUZQv7kGlE8JgmpXHYuiXMbqOPLFNf0QMMa39+b17ZRIu8nnv8BN0o6kAKaURTwu6V97EgazqnMiYUEniLed+0p7NxpAe4Pmb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EIqwtruI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710505108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LT2POqbfgrZp4xIkCsgMst+ERqrnYOoLDyndXBBv0s0=;
	b=EIqwtruI9XiN4esqiV/DkQ0tox4Mo/xK+o6Xt/9hrqJKpUAuEUm/TvOrBUSCLTOIGcP5dC
	BEuJtoazp9ysQsxX+U5eIa9gPghOtebs9vSOlA/1Dj47ZS708dZg8QK7pUJY5UMid8kMfk
	LoV8ZkmVTJGdzr5VAgn1hxId82YRF5I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-0X87yacEOp2y-1vaLWLDAA-1; Fri, 15 Mar 2024 08:18:27 -0400
X-MC-Unique: 0X87yacEOp2y-1vaLWLDAA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4131c96569dso9586985e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 05:18:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710505106; x=1711109906;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LT2POqbfgrZp4xIkCsgMst+ERqrnYOoLDyndXBBv0s0=;
        b=F3hiona4ZiFVkkT4uH+rGrBucDZcklbM7gj/x4GIvBbh4Uyxx2VCWeP/zkYMPKjJ52
         cHx13Ea0oPazgkbKqfpWQxWG6amJOJ4nKbGgnqdDygwGdLNrMHV0ZhbV4E+crUjeq160
         usEAmFHE2cDBTwIb88ZYMMqT5WDtXvSWBnCYptobJWYyrto7MZrPH7cEANerHx2wf35U
         HA7yxhorvFTD6yVu2Avgcd7okvNF/eq2mZJShqB3RODGjDWWEwWqdLv02wBR806JJ5X+
         4YqxA7PfmolvoTPUnLWQ8Yv9H9TGAduyzRO3+nIWIEBP3BbmM6PZuGrxybKfZkG+lO7e
         5Dyw==
X-Forwarded-Encrypted: i=1; AJvYcCW+ZZWThJRFHRShT05NURnGEnZTpJ5uhFdvKvok5w03Zk1A/BeHoPenHp8bpDETVIeeOlSp95MrpJ67mBIFc1mRjFHgIXDsrDvNkN4e
X-Gm-Message-State: AOJu0YyZTG4/DHhxzxSlxLS/2T+7Og6Dd/efjxs9BgZIAb8kiKzDc5ED
	+XuigaP9yeZglFwCBNWKbYpCrFR+quARKXSL6nCjE7rHdUeu/cxTkBxuJupUfYJyVBIfco5eg3y
	kQh+N45HzawdAOBPK/zrjpl0QE3RvfO0HmGK7uS1HnNeWViW3rE07kyceXwGvfw==
X-Received: by 2002:a05:600c:358e:b0:414:24b:3387 with SMTP id p14-20020a05600c358e00b00414024b3387mr786598wmq.19.1710505105991;
        Fri, 15 Mar 2024 05:18:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsvTp/X1ZKGcmuKsmDWlyVlYbB27eraY/h/vb3UwagJfQUtz62OBIR5X/K+MSoZQjAznE58g==
X-Received: by 2002:a05:600c:358e:b0:414:24b:3387 with SMTP id p14-20020a05600c358e00b00414024b3387mr786575wmq.19.1710505105601;
        Fri, 15 Mar 2024 05:18:25 -0700 (PDT)
Received: from ?IPV6:2003:cb:c719:7700:ef08:112b:278d:7d90? (p200300cbc7197700ef08112b278d7d90.dip0.t-ipconnect.de. [2003:cb:c719:7700:ef08:112b:278d:7d90])
        by smtp.gmail.com with ESMTPSA id m8-20020a05600c4f4800b00413ea26f942sm8380355wmq.14.2024.03.15.05.18.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 05:18:25 -0700 (PDT)
Message-ID: <893fd7d3-6f11-45ee-8fe6-52f11dc42cc7@redhat.com>
Date: Fri, 15 Mar 2024 13:18:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm/khugepaged: reduce process visible downtime by
 pre-zeroing hugepage
Content-Language: en-US
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, mhocko@suse.com, zokeefe@google.com,
 shy828301@gmail.com, xiehuan09@gmail.com, songmuchun@bytedance.com,
 minchan@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 libang.li@antgroup.com
References: <20240308074921.45752-1-ioworker0@gmail.com>
 <ef409d5e-5652-4fff-933c-49bda6d75018@redhat.com>
 <CAK1f24k_+qAqxKGMpKziouuds=PQ6kfKyQ8D3SYEyW7cQOAJWw@mail.gmail.com>
 <75630ba6-79b6-4105-b614-29cfb0331084@redhat.com>
 <CAK1f24=vU5kEuJC6x099JGFD7z6FK5q+o1to7QY8Q12jNQzr_g@mail.gmail.com>
 <CAK1f24ktQMYogUETyu04KahC1YAdrY1XwCNNrYUQXN4tSEPKsQ@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAK1f24ktQMYogUETyu04KahC1YAdrY1XwCNNrYUQXN4tSEPKsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.03.24 15:19, Lance Yang wrote:
> Another thought suggested by Bang Li is that we record which pte is none
> in hpage_collapse_scan_pmd. Then, before acquiring the mmap_lock (write mode),
> we will pre-zero pages as needed.

Here is my point of view: we cannot optimize the common case where we 
have mostly !pte_none() in a similar way.

So why do we care about the less common case? Is the process visible 
downtime reduction for that less common case really noticable?

Or is it rather something that looks good in a micro-benchmark, but 
won't really make any difference in actual applications (again, where 
the common case will still result the same downtime).

I'm not against this, I'm rather wonder "do we really care". I'd like to 
hear other opinions.

>>>>>
>>>>> So my question is: do we really care about it that much that we care to
>>>>> optimize?
>>>>
>>>> IMO, although it may not be our main concern, reducing the impact of
>>>> khugepaged on the process remains crucial. I think that users also prefer
>>>> minimal interference from khugepaged.
>>>
>>> The problem I am having with this is that for the *common* case where we
>>> have a small number of pte_none(), we cannot really optimize because we
>>> have to perform the copy.
>>>
>>> So this feels like we're rather optimizing a corner case, and I am not
>>> so sure if that is really worth it.
>>>
>>> Other thoughts?
>>
>> Another thought is to introduce khugepaged/alloc_zeroed_hpage for THP
>> sysfs settings. This would enable users to decide whether to avoid unnecessary
>> copies when nr_ptes_none > 0.

Hm, new toggles for that, not sure ... I much rather prefer something 
without any new toggles, especially for this case.

-- 
Cheers,

David / dhildenb


