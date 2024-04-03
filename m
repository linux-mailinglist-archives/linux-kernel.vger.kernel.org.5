Return-Path: <linux-kernel+bounces-130664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB476897B6C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 00:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2376B1C21221
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41C215689D;
	Wed,  3 Apr 2024 22:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CVMrjRdB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847C9155A46
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 22:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712181968; cv=none; b=AYGSmFmE6KPEh7rWYhC64VToJNshjBJtorw7/noBbKqyr0uU6yY2eWSNBbDsVx+5uPbj6tb5uqh14w37sJuXEULnPu3racpl9tOpfYotQ3QRklT4SB7SAF4wtJXSUMB3VDOiiWRH76S9HNLk9EExInvd/uAdAsPlWT6U1ApOiUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712181968; c=relaxed/simple;
	bh=YoIEg4M4U8yQgqRYO1BqApgeQdU6ITM6199t0PhCzfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hLWDtUHoMk6yhYLcqhBP9mEWXVSv2DzB8/49BRHlCFpBrsxrSWfH0qodz21QJhOWbeUNIq0QDsYaXsC3hhK3hwTeRi3+FTmXSlfkBceIIaZaU5Xh4ksNqHP1t8/SgfHHJ3N/sZgptClvBf0vnvk+fDIhv5VklSk6Max8fVEFMzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CVMrjRdB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712181963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=t8YkZy1qaLR4bR/YpHr6Vo0yptg2TnZ4SN8lEqDcnnE=;
	b=CVMrjRdBQeeBYnAhnqZw6i4OYpAhY2aJOg25aBKoIEkUmTTID+ZJGb1TrVbK1tZc1GPGfZ
	0SY6FaJnF55cz/w20ouzKIIKTphwg7szrS+6fadjCDxJRj+vXfk4wk1Z7coA2TPn83nm9Q
	s235Hw1n5UI966s+gAdMqHqqupln4YI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-usdnQEpDPHOyA24_ZlIM6g-1; Wed, 03 Apr 2024 18:06:01 -0400
X-MC-Unique: usdnQEpDPHOyA24_ZlIM6g-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33ec4fb1a83so117081f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 15:06:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712181960; x=1712786760;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=t8YkZy1qaLR4bR/YpHr6Vo0yptg2TnZ4SN8lEqDcnnE=;
        b=H1TQaqCL0ghH9La0yU5yZFhAeXnwp3VW4Pjg60BI8XLfIrIX7rUoLaDPzwicoE7nWr
         2HzoE7Os2b8N+3mnUCOOLEiKm6j2+Ri5O8d4H4sl804RIZg6/ws6I9RlJ9mpliaSlDme
         +uWSmiGgxqpuqEcNq7wkecjhMnLduvleD1ubsGn4P8Qapcl0GmlirYd3MjUyPivF6ygN
         oF1Oyw/7SDiif8s2gv0glzOK6Ha+YKg5Vstfg0+Zrpe/Da8b09qOKIWIHHa3EkpocNWR
         b51x7JVukctXbHXOpCshF79iQ5xLPPbPXQgk2Qe9UupCFNFOdFX+2w2RZY47O01iwTAx
         TiIg==
X-Gm-Message-State: AOJu0Yy0eQuK1d4IXXXxaNeBC/0y/Z72sfuKKUBWVQo0mvwqgWIUX8/K
	IHeNPRrcCJ03JfEdz3uCroo+EticWnCuqH6jsNcoCL66SbOW6QTrE913hpr4ieHZFxyOrOqb45J
	ET+cs10mRCdjYoAy0YRlbfRqRp85M2F6YaVe7TW+QX9DYkb4/5qDljC8Bjj+XNA/KgI2qww==
X-Received: by 2002:adf:fa50:0:b0:33e:cb03:2471 with SMTP id y16-20020adffa50000000b0033ecb032471mr510317wrr.30.1712181960527;
        Wed, 03 Apr 2024 15:06:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEhazweCmzvTC6fUehDdMKi9e7HXIOhr/gtTXdggI8dczfi5e+tSnJgbLdDsa00icvtL66SA==
X-Received: by 2002:adf:fa50:0:b0:33e:cb03:2471 with SMTP id y16-20020adffa50000000b0033ecb032471mr510306wrr.30.1712181960132;
        Wed, 03 Apr 2024 15:06:00 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73b:3100:2d28:e0b7:1254:b2f6? (p200300cbc73b31002d28e0b71254b2f6.dip0.t-ipconnect.de. [2003:cb:c73b:3100:2d28:e0b7:1254:b2f6])
        by smtp.gmail.com with ESMTPSA id o8-20020adfe808000000b00341b451a31asm1846887wrm.36.2024.04.03.15.05.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 15:05:59 -0700 (PDT)
Message-ID: <f5997630-f098-480a-ae4d-a8b038a0a716@redhat.com>
Date: Thu, 4 Apr 2024 00:05:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] KCSAN: data-race in __delete_from_swap_cache /
 folio_mapping (3)
To: Andrew Morton <akpm@linux-foundation.org>,
 syzbot <syzbot+58fc2a881f3b3df5e336@syzkaller.appspotmail.com>,
 Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 syzkaller-bugs@googlegroups.com
References: <00000000000092ec58061522b2c7@google.com>
 <20240403144452.1c68c2be42383de895795cfd@linux-foundation.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240403144452.1c68c2be42383de895795cfd@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.04.24 23:44, Andrew Morton wrote:
> On Tue, 02 Apr 2024 13:10:29 -0700 syzbot <syzbot+58fc2a881f3b3df5e336@syzkaller.appspotmail.com> wrote:
> 
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    39cd87c4eb2b Linux 6.9-rc2
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=129de21d180000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=d024e89f7bb376ce
>> dashboard link: https://syzkaller.appspot.com/bug?extid=58fc2a881f3b3df5e336
>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>>
>> Unfortunately, I don't have any reproducer for this issue yet.
>>
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/b9b2dcffd7d5/disk-39cd87c4.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/5f4981fa60e6/vmlinux-39cd87c4.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/691f671f70ad/bzImage-39cd87c4.xz
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+58fc2a881f3b3df5e336@syzkaller.appspotmail.com
>>
>> ==================================================================
>> BUG: KCSAN: data-race in __delete_from_swap_cache / folio_mapping
>>
>> write to 0xffffea0004798fa8 of 8 bytes by task 29 on cpu 0:
>>   __delete_from_swap_cache+0x1f2/0x290 mm/swap_state.c:161
> 
> 	folio->swap.val = 0;

Here we are holding the folio lock and really must invalidate that swap 
entry, because we are removing it from the swap cache.

> 
>>   delete_from_swap_cache+0x72/0xe0 mm/swap_state.c:241
>>   folio_free_swap+0x19f/0x1c0 mm/swapfile.c:1600
>>   free_swap_cache mm/swap_state.c:290 [inline]
>>   free_pages_and_swap_cache+0x1d9/0x400 mm/swap_state.c:322
>>   __tlb_batch_free_encoded_pages mm/mmu_gather.c:136 [inline]
>>   tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
>>   tlb_flush_mmu_free mm/mmu_gather.c:366 [inline]
>>   tlb_flush_mmu+0x2cf/0x440 mm/mmu_gather.c:373
>>   tlb_finish_mmu+0x8c/0x100 mm/mmu_gather.c:465
>>   __oom_reap_task_mm+0x231/0x2e0 mm/oom_kill.c:553
>>   oom_reap_task_mm mm/oom_kill.c:589 [inline]
>>   oom_reap_task mm/oom_kill.c:613 [inline]
>>   oom_reaper+0x264/0x850 mm/oom_kill.c:654
>>   kthread+0x1d1/0x210 kernel/kthread.c:388
>>   ret_from_fork+0x4b/0x60 arch/x86/kernel/process.c:147
>>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
>>
>> read to 0xffffea0004798fa8 of 8 bytes by task 14567 on cpu 1:
>>   folio_mapping+0xd2/0x110 mm/util.c:797
> 
> 		return swap_address_space(folio->swap);
> 

And in this black-magic LRU thingy we don't.

We call folio_evictable()->folio_mapping()

Which ends up doing:

	if (unlikely(folio_test_swapcache(folio))
		return swap_address_space(folio->swap);

that can easily race with above code because we don't hold the folio lock.

Not sure if we should use READ_ONCE/WRITE_ONCE here, and try to handle
the race differently. We have to be prepared for 
folio_test_swapcache()==true but then failing to get the address space 
because we are concurrently removing the folio from the swapcache.

>>   folio_evictable mm/internal.h:256 [inline]
>>   move_folios_to_lru+0x137/0x690 mm/vmscan.c:1808
>>   shrink_inactive_list mm/vmscan.c:1929 [inline]
>>   shrink_list mm/vmscan.c:2163 [inline]
>>   shrink_lruvec+0xbd8/0x1640 mm/vmscan.c:5687
>>   shrink_node_memcgs mm/vmscan.c:5873 [inline]
>>   shrink_node+0xa78/0x15a0 mm/vmscan.c:5908
>>   shrink_zones mm/vmscan.c:6152 [inline]
>>   do_try_to_free_pages+0x3cc/0xca0 mm/vmscan.c:6214
>>
>> ...
>>
> 
> These both point at David's 3d2c90876887 ("mm/swap: inline
> folio_set_swap_entry() and folio_swap_entry()") which is probably
> innocent, but I have to blame someone ;)

Heh, I'm pretty sure that one is innocent. But also the other work in 
the same series is likely innocent after staring at above race. But 
nothing is impossible ;)

@Willy, Hugh, any idea regarding above race?

-- 
Cheers,

David / dhildenb


