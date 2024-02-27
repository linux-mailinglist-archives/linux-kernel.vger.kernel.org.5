Return-Path: <linux-kernel+bounces-83460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 593BC8699D6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 684C5B2A150
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECDC14533E;
	Tue, 27 Feb 2024 15:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O7hkHzT7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E430014534C
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 15:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046069; cv=none; b=eoFyl3G1f5zqq32RRuhhuILHJk7/zumOhG4KJYke2/XInahWNe6lcnOjekH0hxnDiFahCLHGbcjMNGjiOpS+/wlrujGTPUXHLJlC2+lZL8z+djdcr0sK1N7YSP6I4DhSv+iaxkwt+a+oEnN46HwgId825qKHPqj+a42VJyfuRIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046069; c=relaxed/simple;
	bh=+EuFjpu1vIf2NQ2DrIIWSkzsULMloP3gz7XhGdpS4IU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ealm7a2tmU6jpgaW+ARB0CPWjxijCE+xuK5NzYhzF8lw6IJNmNZ2l75a4Hw9q2ln0cLXW2firvQ6u7bt9C9J/Ta32ns/X3r0n+b/DQArtzdNJ2QITmgxkzg/reCE0hxAYVyPYdpzSGossJGMqHpmDHHMP+8oS0OptueAiWLqjDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O7hkHzT7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709046065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5Pbw1rLa/3NEYjmsKz/L4GYGbrEc8/6OThTNR654NLk=;
	b=O7hkHzT7Tbo1ZBjFAOiYatK4QC4umFbG2J01WKrMqowffH+/M5je8NwfnqGsfjmh8pTRIF
	jyaUxB8HgWpHLLS76FNaUr7nNTD9qUi4FQXxaptLUXhwMTzzONF5swqtXBDkX4V0TY4P7M
	I8pa1+KMdmFOfnT4/VM5+0SjeTwMLEU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-ozrCf11AP_eebB_8s3fb3w-1; Tue, 27 Feb 2024 10:01:04 -0500
X-MC-Unique: ozrCf11AP_eebB_8s3fb3w-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33d7fcb70c2so1799785f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 07:01:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709046063; x=1709650863;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Pbw1rLa/3NEYjmsKz/L4GYGbrEc8/6OThTNR654NLk=;
        b=V8hEE1zdJn627cd6Slq3f4IEMakKOjl7vAHEm6B+Fz/7yt+4eu9vpSDwOxe4nwDhjJ
         NIamKu51sKxHl8JeCb95bZGxsJm3RcXRbbZW72t95vfpxPB7+fcrEeM70sJW66Mb+qbO
         u9E+lRLsnMuhbMFUREKyuTptN+uaf74Y1bCFp2TFmXNoQEtCk/K4QBmCKsMORlOOd2XO
         VkIv7l1Pe0UgvJD9LpYW28t+hnN52dtSHLy5MwF1kILJmJPw0NiV+Sng+3iB8Xp+SHGg
         ryvAQG6J7tRu0ByGrrnbUI3zrH6txocUklLcAKVQMIjZVJdeCty/Gh4TNAnOSwbPHwYq
         MOWA==
X-Forwarded-Encrypted: i=1; AJvYcCWFMrw6V8gKnqOji3y1V1wHLmx7zScctFN2OKju+VJ3GCFc9dqfD6ceN4zHyXIuUoXk8WV3RVPh6CxWNRBh8/5WP5P1qPLdXrVJcZHb
X-Gm-Message-State: AOJu0YyAVqqQ3Dee1oPEp+xn70GsFd6rBUDAdvYBbOyuZaXTKJTgPUkm
	BnMi5VgWwm5QHlWC/RQ6V9E8kfHFPqJQIHUTSnTb8l/zSsGDacSNA369WkmydjVPQvSxsOzz+co
	97x3F/sIT+Uz2AdYMkSBFYxuNeDJwN88sZutLVHnT3sOvVr4xIWhpEely8QEH8Q==
X-Received: by 2002:a05:6000:120a:b0:33d:c5c7:45ed with SMTP id e10-20020a056000120a00b0033dc5c745edmr6829938wrx.3.1709046063173;
        Tue, 27 Feb 2024 07:01:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjmHQCa/PqHrul04UYZcdA8prGv3O641g8TWZNxL3MoR1VLYGkibNcfMut/yLENdEC0XRTkg==
X-Received: by 2002:a05:6000:120a:b0:33d:c5c7:45ed with SMTP id e10-20020a056000120a00b0033dc5c745edmr6829902wrx.3.1709046062743;
        Tue, 27 Feb 2024 07:01:02 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:7600:5c18:5a7d:c5b7:e7a9? (p200300cbc70776005c185a7dc5b7e7a9.dip0.t-ipconnect.de. [2003:cb:c707:7600:5c18:5a7d:c5b7:e7a9])
        by smtp.gmail.com with ESMTPSA id ck12-20020a5d5e8c000000b0033d9f0dcb35sm11920501wrb.87.2024.02.27.07.01.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 07:01:02 -0800 (PST)
Message-ID: <42be658c-cb13-4001-aae4-8d8275a84038@redhat.com>
Date: Tue, 27 Feb 2024 16:01:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/huge_memory: fix swap entry values of tail pages of
 THP
Content-Language: en-US
To: Zi Yan <ziy@nvidia.com>
Cc: Matthew Wilcox <willy@infradead.org>,
 Charan Teja Kalla <quic_charante@quicinc.com>, gregkh@linuxfoundation.org,
 akpm@linux-foundation.org, vbabka@suse.cz, dhowells@redhat.com,
 surenb@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 # see patch description <stable@vger.kernel.org>,
 Huang Ying <ying.huang@intel.com>,
 Naoya Horiguchi <naoya.horiguchi@linux.dev>
References: <1707814102-22682-1-git-send-email-quic_charante@quicinc.com>
 <a683e199-ce8a-4534-a21e-65f2528415a6@redhat.com>
 <8620c1a0-e091-46e9-418a-db66e621b9c4@quicinc.com>
 <845ca78f-913b-4a92-8b40-ff772a7ad333@redhat.com>
 <bc1a5e36-1983-1a39-4d06-8062993a4ca4@quicinc.com>
 <ZczLoOqdpMJpkO5N@casper.infradead.org>
 <f2ad5918-7e36-4a7c-a619-c6807cfca5ec@redhat.com>
 <30ea073d-0ccf-46e1-954d-e22f5cbf69f7@redhat.com>
 <1ABD022A-35FC-4A6E-ADAD-36F3D745FB91@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <1ABD022A-35FC-4A6E-ADAD-36F3D745FB91@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27.02.24 15:52, Zi Yan wrote:
> On 27 Feb 2024, at 9:11, David Hildenbrand wrote:
> 
>> On 14.02.24 15:34, David Hildenbrand wrote:
>>> On 14.02.24 15:18, Matthew Wilcox wrote:
>>>> On Wed, Feb 14, 2024 at 12:04:10PM +0530, Charan Teja Kalla wrote:
>>>>>> 1) Is it broken in 5.15? Did you actually try to reproduce or is this
>>>>>>       just a guess?
>>>>>>
>>>>>
>>>>> We didn't run the tests with THP enabled on 5.15, __so we didn't
>>>>> encounter this issue__ on older to 6.1 kernels.
>>>>>
>>>>> I mentioned that issue exists is based on my understanding after code
>>>>> walk through. To be specific, I just looked to the
>>>>> migrate_pages()->..->migrate_page_move_mapping() &
>>>>> __split_huge_page_tail() where the ->private field of thp sub-pages is
>>>>> not filled with swap entry. If it could have set, I think these are the
>>>>> only places where it would have done, per my understanding. CMIW.
>>>>
>>>> I think you have a misunderstanding.  David's patch cfeed8ffe55b (part
>>>> of 6.6) _stopped_ us using the tail ->private entries.  So in 6.1, these
>>>> tail pages should already have page->private set, and I don't understand
>>>> what you're fixing.
>>>
>>> I think the issue is, that migrate_page_move_mapping() /
>>> folio_migrate_mapping() would update ->private for a folio in the
>>> swapcache (head page)
>>>
>>> 	newfolio->private = folio_get_private(folio);
>>>
>>> but not the ->private of the tail pages.
>>>
>>> So once you migrate a THP that is in the swapcache, ->private of the
>>> tail pages would not be migrated and, therefore, be stale/wrong.
>>>
>>> Even before your patch that was the case.
>>>
>>> Looking at migrate_page_move_mapping(), we had:
>>>
>>> 	if (PageSwapBacked(page)) {
>>> 		__SetPageSwapBacked(newpage);
>>> 		if (PageSwapCache(page)) {
>>> 			SetPageSwapCache(newpage);
>>> 			set_page_private(newpage, page_private(page));
>>> 		}
>>> 	} else {
>>> 		VM_BUG_ON_PAGE(PageSwapCache(page), page);
>>> 	}
>>>
>>>
>>> I don't immediately see where the tail pages would similarly get updated
>>> (via set_page_private).
>>>
>>> With my patch the problem is gone, because the tail page entries don't
>>> have to be migrated, because they are unused.
>>>
>>>
>>> Maybe this was an oversight from THP_SWAP -- 38d8b4e6bdc8 ("mm, THP,
>>> swap: delay splitting THP during swap out").
>>>
>>> It did update __add_to_swap_cache():
>>>
>>> for (i = 0; i < nr; i++) {
>>>            set_page_private(page + i, entry.val + i);
>>>            error = radix_tree_insert(&address_space->page_tree,
>>>                                      idx + i, page + i);
>>>            if (unlikely(error))
>>>                    break;
>>> }
>>>
>>> and similarly __delete_from_swap_cache().
>>>
>>> But I don't see any updates to migration code.
>>>
>>> Now, it could be that THP migration was added later (post 2017), in that
>>> case the introducing commit would not have been 38d8b4e6bdc8.
>>>
>>
>> Let's continue:
>>
>> The introducing commit is likely either
>>
>> (1) 38d8b4e6bdc87 ("mm, THP, swap: delay splitting THP during swap out")
>>
>> That one added THP_SWAP, but THP migration wasn't supported yet AFAIKS.
>>
>> -> v4.13
>>
>> (2) 616b8371539a6 ("mm: thp: enable thp migration in generic path")
> 
> I think this is the one, since it makes THP entering migrate_page_move_mapping()
> possible.
> 
>>
>> Or likely any of the following that actually allocate THP for migration:
>>
>> 8135d8926c08e mm: memory_hotplug: memory hotremove supports thp migration
>> e8db67eb0ded3 mm: migrate: move_pages() supports thp migration
>> c8633798497ce mm: mempolicy: mbind and migrate_pages support thp migration
>>
>> That actually enable THP migration.
>>
>> -> v4.14
>>
>>
>> So likely we'd have to fix the stable kernels:
>>
>> 4.19
>> 5.4
>> 5.10
>> 5.15
>> 6.1
>>
>> That's a lot of pre-folio code. A backport of my series likely won't really make any sense.
>>
>> Staring at 4.19.307 code base, we likely have to perform a stable-only fix that properly handles the swapcache of compoud pages in migrate_page_move_mapping().
> 
> Something like (applies to v4.19.307):
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 171573613c39..59878459c28c 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -514,8 +514,13 @@ int migrate_page_move_mapping(struct address_space *mapping,
>          if (PageSwapBacked(page)) {
>                  __SetPageSwapBacked(newpage);
>                  if (PageSwapCache(page)) {
> +                       int i;
> +
>                          SetPageSwapCache(newpage);
> -                       set_page_private(newpage, page_private(page));
> +                       for (i = 0; i < (1 << compound_order(page)); i++) {
> +                               set_page_private(newpage + i,
> +                                                page_private(page + i));
> +                       }
>                  }
>          } else {
>                  VM_BUG_ON_PAGE(PageSwapCache(page), page);

I'm wondering if there is a swapcache update missing as well.

-- 
Cheers,

David / dhildenb


