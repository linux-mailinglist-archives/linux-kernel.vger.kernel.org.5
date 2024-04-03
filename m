Return-Path: <linux-kernel+bounces-129687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E540896E6F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E17A1C22DB8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517A4143869;
	Wed,  3 Apr 2024 11:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ATYTlqTP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8C017583
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 11:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712144833; cv=none; b=q27oayQo7Q/WzmeqHqsTIKTZ7k584t/3D3F8Pva4u0MgWwULsESG/9+bc/o01TT1l5jpMjbdzlqt+bffDDRZG7dFVd4o4sxPMkijV2ByIqk2HnTfhPU99cfMHVDonTabDIIHfCu5O+mlkUnwEY+w3hjgEhqSqwkTJwFDilw/ohs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712144833; c=relaxed/simple;
	bh=zOBFBOm84jnvTByUHkNrhQKEU+rD/tjfciwAK17g9Qk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FHZA7mL9fMqgSl7cyVNrrAS4IFSWNwPIO6wv1lZ/97ov4qQ48iFuOFPzADuHV7MFIlWUS6l+FpF2MxnPdSVQY9oSztaJnprkQQxRG4YpyKtbsNwpNaziyPR1buhQCDjbX6zgIC72V2EZrsfhju3uiQi7GzRopuBuEGjRkqt4Ikc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ATYTlqTP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712144830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4EH43NCAOAEvIVjIotzKi6szn6apSJ1oO/kMzNhskaI=;
	b=ATYTlqTPCz6eeCGREIuviICI0dXAmpKAA4rBDs/E7cAtmCMzHpTgunhOdVCwPM5zwtTqWO
	y7UYghK7Sa9HIDJNi5H5XIBY7b3PKZvDe9Oxwn6lA5JY4oTIMdjLs4965zbxb3WMoB+aXA
	0qD2ROkTsHImqA2/q4N4zoNclg+a8eE=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-nnJWAvlfO92GLUmjmf7niA-1; Wed, 03 Apr 2024 07:47:09 -0400
X-MC-Unique: nnJWAvlfO92GLUmjmf7niA-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2d6fcb884bbso53821351fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 04:47:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712144827; x=1712749627;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4EH43NCAOAEvIVjIotzKi6szn6apSJ1oO/kMzNhskaI=;
        b=AQV6xb+yS+BdSp1uK9QFSlu11usmM2Ruz7it5FZYiHwgFSmjfpL5paPHsm4NW9RRAv
         qAMR7Hp6GnWsR7Yk+H76BHTnYsWTB8ANw/llt1fY+nxafU9BcgW0eLbBBkM8hRSp9IwO
         Hqlc76o+SPGR86kFGiEtkm157PAGWu5J1XKfO64sHmTYNJwr/a/s92+cCTP82DxhXrq/
         wULNgU1lNDoB5HwqjNukD7Lr7NQeiKvbizQs0QzHY8yUu4LHyV7/AdVKwKLY3Bl29wnL
         /VmbmYmV1mbUeN/ShWRY5cnDc9N4ooBD41PWpyEhXxR7ARFLCDKfpXVbrgXIJAJrTm/m
         +i7Q==
X-Forwarded-Encrypted: i=1; AJvYcCV2Aehc0qwjtFfc2noo/3scqdpvtHE8aNZiAziiP8WY1bjYSVBncn2Yt/PEzTVJeIEcaatwIf8wxBWmPHVZlt9VFxUsfdrPmXMOec4J
X-Gm-Message-State: AOJu0YwhlYbX4eWBNX4iSlUFYM0XsPQkrLpTbSvUugImVNyKYCaptpLK
	FLUoUNwlY/88j6oKW07THhrFuSBk+JADyYfuAOzHZB8QWcxf+xZEk9dJ+Pj6tRFMtNBWTYtgtcu
	yUuWTas+poi/+DV7nKepeB4+mqtnRx7DkPz+qycNpwre7umjwbQWNJKL8dI7I1g==
X-Received: by 2002:a2e:8699:0:b0:2d4:6815:fc6f with SMTP id l25-20020a2e8699000000b002d46815fc6fmr9160585lji.30.1712144827731;
        Wed, 03 Apr 2024 04:47:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZqnJgLL/YiGK+9ovJiWvcIupsw1RJf8htEu880b90z4FWi+yxmK2hf6PfidgHVNy13PwvjQ==
X-Received: by 2002:a2e:8699:0:b0:2d4:6815:fc6f with SMTP id l25-20020a2e8699000000b002d46815fc6fmr9160573lji.30.1712144827310;
        Wed, 03 Apr 2024 04:47:07 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73b:3100:2d28:e0b7:1254:b2f6? (p200300cbc73b31002d28e0b71254b2f6.dip0.t-ipconnect.de. [2003:cb:c73b:3100:2d28:e0b7:1254:b2f6])
        by smtp.gmail.com with ESMTPSA id u22-20020a05600c139600b00414906f1ea1sm21196816wmf.17.2024.04.03.04.47.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 04:47:06 -0700 (PDT)
Message-ID: <134b6c6d-5bcf-4394-85ad-2da2e8dec1d3@redhat.com>
Date: Wed, 3 Apr 2024 13:47:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 1/1] mm: fix unproperly folio_put by changing API in
 read_pages
To: Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
 Andrew Morton <akpm@linux-foundation.org>, NeilBrown <neilb@suse.de>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, steve.kang@unisoc.com,
 Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>
References: <20240401081734.1433755-1-zhaoyang.huang@unisoc.com>
 <736b982a-57c9-441a-812c-87cdee2e096e@redhat.com>
 <CAGWkznF6NQrB-vwBZCfCF-1WQJv8iwPPrwND7yDsPJw1EbfxQA@mail.gmail.com>
 <2f8af9d1-8c8e-4e1c-a794-76f6bb287b08@redhat.com>
 <CAGWkznEcS7rNWMudMBA7e-bjudX-sR4TGofyB5G1E=OmW_0Ckw@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAGWkznEcS7rNWMudMBA7e-bjudX-sR4TGofyB5G1E=OmW_0Ckw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 03.04.24 13:08, Zhaoyang Huang wrote:
> On Wed, Apr 3, 2024 at 4:01 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 03.04.24 07:50, Zhaoyang Huang wrote:
>>> On Tue, Apr 2, 2024 at 8:58 PM David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>> On 01.04.24 10:17, zhaoyang.huang wrote:
>>>>> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>>>>>
>>>>> An VM_BUG_ON in step 9 of [1] could happen as the refcnt is dropped
>>>>> unproperly during the procedure of read_pages()->readahead_folio->folio_put.
>>>>> This is introduced by commit 9fd472af84ab ("mm: improve cleanup when
>>>>> ->readpages doesn't process all pages")'.
>>>>>
>>>>> key steps of[1] in brief:
>>>>> 2'. Thread_truncate get folio to its local fbatch by find_get_entry in step 2
>>>>> 7'. Last refcnt remained which is not as expect as from alloc_pages
>>>>>        but from thread_truncate's local fbatch in step 7
>>>>> 8'. Thread_reclaim succeed to isolate the folio by the wrong refcnt(not
>>>>>        the value but meaning) in step 8
>>>>> 9'. Thread_truncate hit the VM_BUG_ON in step 9
>>>>>
>>>>> [1]
>>>>> Thread_readahead:
>>>>> 0. folio = filemap_alloc_folio(gfp_mask, 0);
>>>>>           (refcount 1: alloc_pages)
>>>>> 1. ret = filemap_add_folio(mapping, folio, index + i, gfp_mask);
>>>>>           (refcount 2: alloc_pages, page_cache)
>>
>> [not going into all details, just a high-level remark]
>>
>> page_cache_ra_unbounded() does a filemap_invalidate_lock_shared(), which
>> is a down_read_trylock(&mapping->invalidate_lock).
>>
>> That is, all read_pages() calls in mm/readahead.c happen under
>> mapping->invalidate_lock in read mode.
>>
>> ... and ...
>>
>>>>>
>>>>> Thread_truncate:
>>>>> 2. folio = find_get_entries(&fbatch_truncate);
>>>>>           (refcount 3: alloc_pages, page_cache, fbatch_truncate))
>>
>> truncation, such as truncate_inode_pages() must be called under
>> mapping->invalidate_lock held in write mode. So naive me would have
>> thought that readahead and truncate cannot race in that way.
>>
>> [...]
>>
> Thanks for the reminder. But I don't find the spot where holding
> "mapping->invalidate_lock" by check the callstack of
> 'kill_bdev()->truncate_inode_pages()->truncate_inode_pages_range()',
> or the lock is holded beyond this?

Well, truncate_inode_pages() documents:

"Called under (and serialised by) inode->i_rwsem and 
mapping->invalidate_lock."

If that's not the case than that's either (a) a BUG or (b) an 
undocumented exception to the rule, whereby other mechanisms are in 
place to prevent any further pagecache magic.

I mean, kill_bdev() documents " Kill _all_ buffers and pagecache , dirty 
or not..", so *something* has to be in place to guarantee that there 
cannot be something concurrently filling the pagecache again, otherwise 
kill_bdev() could not possibly do something reasonable.

For example, blkdev_flush_mapping() is called when bd_openers goes to 0, 
and my best guess is that nobody should be able to make use of that 
device at that point.

Similarly, changing the blocksize sounds like something that wouldn't be 
done at arbitrary points in time ...

So kill_bdev() already has a "special" smell to it and I suspect (b) 
applies, where concurrent pagecache action is not really any concern.

But I'm not an expert and I looked at most of that code right now for 
the first time ...

>>
>>>>
>>>> Something that would help here is an actual reproducer that triggersthis
>>>> issue.
>>>>
>>>> To me, it's unclear at this point if we are talking about an actual
>>>> issue or a theoretical issue?
>>> Thanks for feedback. Above callstack is a theoretical issue so far
>>> which is arised from an ongoing analysis of a practical livelock issue
>>> generated by folio_try_get_rcu which is related to abnormal folio
>>> refcnt state. So do you think this callstack makes sense?
>>
>> I'm not an expert on that code, and only spent 5 min looking into the
>> code. So my reasoning about invalidate_lock above might be completely wrong.
>>
>> It would be a very rare race that was not reported so far in practice.
>> And it certainly wouldn't be the easiest one to explain, because the
>> call chain above is a bit elaborate and does not explain which locks are
>> involved and how they fail to protect us from any such race.
>>
>> For this case in particular, I think we really need a real reproducer to
>> convince people that the actual issue does exist and the fix actually
>> resolves the issue.
> Sorry, it is theoretically yet according to my understanding.

Okay, if you find a reproducer, please share it and we can investigate 
if it's a locking problem or something else. As of now, I'm not 
convinced that there is an actual issue that needs fixing.

-- 
Cheers,

David / dhildenb


