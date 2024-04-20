Return-Path: <linux-kernel+bounces-152327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE958ABC70
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 18:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2853F280F85
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 16:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9A0205E30;
	Sat, 20 Apr 2024 16:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KT2p/Xu4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833DF2572
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 16:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713630726; cv=none; b=fCmXio1x91Zd+ZGyEmFiuIrnwQ+oCJa1DdMbLv56r5VTiMajTu3XsHpYzuaFldF6AmiUL1F84ESS1mqkvkx3Xm73UvampeBH62LrErjQEtX48U51xcp3fpiyAni6AKFKNmcA04QdfoBIv1b07N+FbtUHSf/bwQxhCCJsr2MGdCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713630726; c=relaxed/simple;
	bh=c0rO3xnaxqDyRUTtpHmkcxU42Yy8H0Ic5YxZdQvgMi8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AidSyvCJMdx2TILK385jumq0GCUBCGOvAYrw2e2VaVwh5RlCnlq2VHG3XPCNsOEbOVdpCSsaNkKDFv3IyVReJe/Ki7OKZoLmwUZDoo9hto9gbbsXB8YbgTmVAfzWTIU3LqIdo2eJiy4w7DeLdK34kfOC03iYJny6uMZ2WhiZw/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KT2p/Xu4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713630723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9cCh/H15mQop5KOIhSP0+kWn7LyNCA1srgUtmvqjop4=;
	b=KT2p/Xu4b8ziJZ00+ij8H7i1P+v3oWK6svKOFI0BdubIYl+gWcUiasqBMKHP0ki+vfSWXD
	/Wx90ftLVnrjskJjUwpBTGvRurHy98bMos1n5hzn7e74b5QaoRRfAgfd6yjygtK8Nf/d5Z
	ibR4Yx2kYJyiWoC1ZBMJov4MrEoBN9M=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-Wz-QOggMNE2rYKmAlEjaNg-1; Sat, 20 Apr 2024 12:32:01 -0400
X-MC-Unique: Wz-QOggMNE2rYKmAlEjaNg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-349c63ea688so1860702f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 09:32:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713630720; x=1714235520;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9cCh/H15mQop5KOIhSP0+kWn7LyNCA1srgUtmvqjop4=;
        b=XUhOPL6X9n2e29cIkqQJ0JQeFrtbKtFoC6RaKgWiozhcEIras5klEIyeCoBPTJ8vtJ
         sjL1ruym3OR1HdRBXsDwJqF8e0cOiX6WCEhRQc9EfjfkVo3PZ8c+DlHEraf39sWIbMba
         Zl3MTomx/C/zLKHGXCxb3NXHh62qi0vjoqHB5x8QTvYSzi7reDbGugH6iTC2qnYdaaoo
         4ftBtmkZM+WfqOUyfR54ubHw/qRJ41UA2ZqrZPjAi++0gwTbgbD+si9I4O752FF6QVfZ
         szfwpHtND7B3pFS3HDZFkV0Ba1R8xJd7FyyC6Ors09xWjf8l22vrGzwrF+wGsa6yLpP6
         Aq+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXgJ0SIGGQhMXxYMD2nEetqfFFf7TXkxA/VLrRO09huPnKMwR6NIAipQoXm7k6di/iNiUBbSLL3IlkzY7K1Vb+KTJPT5mBn5szCb6Vc
X-Gm-Message-State: AOJu0YxDHop6Bvf15nXb99V7Tu9irUodnK2QMXneW3BMoLrcVuBzGh6K
	1yjt6mIer7FOxWhmvC91WVACI5GOgITjG7usZ5uY5T+S1JmoN562i5FSTAgKzhvQZimlKQumqst
	N0+mf7Dappm3oRR+yZnYBfJDQMkgaXryQ/RGtLmEuNgaAitDFyNWUdPGT7xfzMw==
X-Received: by 2002:a05:6000:905:b0:349:cd18:abbd with SMTP id cw5-20020a056000090500b00349cd18abbdmr3283117wrb.46.1713630720530;
        Sat, 20 Apr 2024 09:32:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgB8SEAlRCBKHL5/3IDmg0hq233BgRIC9ndzg1O/z2ptI45dKlIwDt0hLl4tTzWLxNBcMVoA==
X-Received: by 2002:a05:6000:905:b0:349:cd18:abbd with SMTP id cw5-20020a056000090500b00349cd18abbdmr3283091wrb.46.1713630720051;
        Sat, 20 Apr 2024 09:32:00 -0700 (PDT)
Received: from ?IPV6:2003:cb:c724:7a00:871b:454b:d552:c4ed? (p200300cbc7247a00871b454bd552c4ed.dip0.t-ipconnect.de. [2003:cb:c724:7a00:871b:454b:d552:c4ed])
        by smtp.gmail.com with ESMTPSA id n17-20020adfe791000000b00349be95b5cesm7191251wrm.101.2024.04.20.09.31.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Apr 2024 09:31:59 -0700 (PDT)
Message-ID: <b50af6b1-2fa7-4285-998f-88d28bf57713@redhat.com>
Date: Sat, 20 Apr 2024 18:31:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm/vmscan: avoid split PMD-mapped THP during
 shrink_folio_list()
To: Lance Yang <ioworker0@gmail.com>, Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, maskray@google.com, ziy@nvidia.com,
 ryan.roberts@arm.com, 21cnbao@gmail.com, mhocko@suse.com,
 fengwei.yin@intel.com, zokeefe@google.com, shy828301@gmail.com,
 xiehuan09@gmail.com, wangkefeng.wang@huawei.com, songmuchun@bytedance.com,
 peterx@redhat.com, minchan@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240417141111.77855-1-ioworker0@gmail.com>
 <Zh_mBxJmYe6eCA29@casper.infradead.org>
 <CAK1f24=Mrk7TFnDd=ouCrHaDH9K3VGCUAJbLH9cbn0pGncP+Hw@mail.gmail.com>
 <CAK1f24=0S8qFFNhf5h=wbbAHvYt-n563MOu=bJheLcrfcPAE_Q@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAK1f24=0S8qFFNhf5h=wbbAHvYt-n563MOu=bJheLcrfcPAE_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20.04.24 17:04, Lance Yang wrote:
> On Sat, Apr 20, 2024 at 12:59 PM Lance Yang <ioworker0@gmail.com> wrote:
>>
>> Hey Matthew,
>>
>> Thanks for taking time to review!
>>
>> On Wed, Apr 17, 2024 at 11:09 PM Matthew Wilcox <willy@infradead.org> wrote:
>>>
>>> On Wed, Apr 17, 2024 at 10:11:11PM +0800, Lance Yang wrote:
>>>> When the user no longer requires the pages, they would use madvise(madv_free)
>>>> to mark the pages as lazy free. IMO, they would not typically rewrite to the
>>>> given range.
>>>>
>>>> At present, a PMD-mapped THP marked as lazyfree during shrink_folio_list()
>>>> is unconditionally split, which may be unnecessary. If the THP is exclusively
>>>> mapped and clean, and the PMD associated with it is also clean, then we can
>>>> attempt to remove the PMD mapping from it. This change will improve the
>>>> efficiency of memory reclamation in this case.
>>>>
>>>> On an Intel i5 CPU, reclaiming 1GiB of PMD-mapped THPs using
>>>> mem_cgroup_force_empty() results in the following runtimes in seconds
>>>> (shorter is better):
>>>>
>>>> --------------------------------------------
>>>> |     Old       |      New       |  Change  |
>>>> --------------------------------------------
>>>> |   0.683426    |    0.049197    |  -92.80% |
>>>> --------------------------------------------
>>>>
>>>> Signed-off-by: Lance Yang <ioworker0@gmail.com>
>>>> ---
>>>>   include/linux/huge_mm.h |  1 +
>>>>   include/linux/rmap.h    |  1 +
>>>>   mm/huge_memory.c        |  2 +-
>>>>   mm/rmap.c               | 81 +++++++++++++++++++++++++++++++++++++++++
>>>>   mm/vmscan.c             |  7 ++++
>>>>   5 files changed, 91 insertions(+), 1 deletion(-)
>>>
>>> I'm confused why we need all this extra code.  If we remove a folio
>>
>> Thanks for pointing that out!
>>
>> I've added a lot of extra code to rmap.c, and we don't need it
>> for file pages - sorry. I'll reconsider where to place this code.
>>
>>> from the pagecache, we can just call truncate_inode_folio() and
>>> unmap_mapping_folio() takes care of all the necessary unmappings.
>>> Why can't you call unmap_mapping_folio() here?
>>
>> Thanks for your suggestion.
>>
>> But this change only avoids the splitting of *anon* large folios
>> (PMD-mapped THPs) that are marked as lazyfree during
>> shrink_folio_list().
>>
>> IIUC, in some cases, we cannot unmap the THP marked as lazyfree
>> here, such as when it's not exclusively mapped, dirty, pinned, etc.
> 
> I’d like to make a correction.
> 
> IMO, we can unmap the THP that is not exclusively mapped, but
> ensuring folio_ref_count() equals folio_mapcount() +1.

You must follow the exact same logic as in try_to_unmap_one() I guess.

That is, unmap the page, syncing against concurrent GUP-fast. Then, 
check mapcount vs. refcount. If there are unexpected references, remap 
the page (set_pte_at).

-- 
Cheers,

David / dhildenb


