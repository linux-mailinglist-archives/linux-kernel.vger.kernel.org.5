Return-Path: <linux-kernel+bounces-117492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3C688ABF4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EA681C3C579
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D605B1494D8;
	Mon, 25 Mar 2024 16:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iqav50Pe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C4D148FEA
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 16:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711385011; cv=none; b=Vf492YcJjzZccf/lHT3UEIKgPM8VBFmlehg7lxTr18C+y7YFjyrbyGVliB2jcR8fMTbcW7E1yJLDoF5l5RuZswyHTXJaeXG72noxpwGb0//bd5CM1fI8JyfuSb3g3EVJrtsa7C7szQ4OZTmIsa/1O1oFGTb6GK8hsTnUruOt7MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711385011; c=relaxed/simple;
	bh=CIEeNqc1cwLb3jW6LUEsuWoRzNKO5RMg20d3I9LYa4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=agpDC+bRfbT0BYr7NaQ/oCYDFEig4Nhc4nko333h2v0aCb+pzPo0kFRi3K6r1TcfQEBOtZmDKLCyb/6UuqFu5rlhlrYFkQamo8ceM8H2GRyWIqrUB7HZs5SS6AaJZBAZWaFCYslWz42X/2YjrQnv2RlzWjl0+55KJdWH4u6H24M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iqav50Pe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711385009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dKggcYKrKbSOf59PMz2SlOiibK9P2zLY4M6JQ3qRj44=;
	b=iqav50PeLv5BbmeUsTFtCeORwysKkOKVz52FQ/vLMpZPzMnXNd2Uf2QqzTj0zV39X/xxI5
	iJ69GJqTlfQs0z/8YJI1awVIzNnKLusgyUA4i/VgxKpwGgBDtukQTKdaggTM31dS2AC2Qo
	tbcu40Ra/XV23/ZjVt1UgFZRq0XNVGo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-VA22Z6ytPJmgMxlgfxJfnQ-1; Mon, 25 Mar 2024 12:43:26 -0400
X-MC-Unique: VA22Z6ytPJmgMxlgfxJfnQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33ed44cb765so2584828f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 09:43:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711385005; x=1711989805;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dKggcYKrKbSOf59PMz2SlOiibK9P2zLY4M6JQ3qRj44=;
        b=gVHn68QYDVm8TAwXu/Q81Bc9se9kshT4andC3NA8K0JLanmIwRGxt437AOBOpVCjpE
         54p8h72GX1lWBXgmWCIhlJFu5ywRiBiYmC9UzZiPcnTqbAETF4nVk+d/KQqrW0lmyU+v
         4Pn6eO3XOWDtWhTUcz/bOyHGDqfUeaT46SSSxUKrGKw3bl99MnwuZOGmjo0dwS9BXyUu
         J21CBVB+j6adwuk+x9CqjAq9WucI/5H1WYjp+F7avve49n52QBuvuRXMLg42kcQsUj/i
         ucW6Zk6ACNvgOHwKN0UbFrILsHBsldZEETl6wT9+gbs7UAAW7Cxf+mGmzw2Dq/rJMkJG
         Bisg==
X-Gm-Message-State: AOJu0YyfFs1m1b9fIeFYTvjrQ2fdpd3Das5HW41/X4u1ATZRWz9bwhnZ
	gWg0BoCRuGdATea2vic199KH/G1wPJeTxcvgFrXUMrmpxgaxjUNbeEgX/zYIzaah7odf3vo0y4k
	NNEoQ7fxapDJEc28L14tv4I8Rw2auuTO3ytZOatAsmpD784c94ztTcc8P9SZO8w==
X-Received: by 2002:adf:f544:0:b0:341:a813:2679 with SMTP id j4-20020adff544000000b00341a8132679mr4626470wrp.29.1711385005037;
        Mon, 25 Mar 2024 09:43:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE19BMNdXGGF1XYo7pZ1qfO8psm15Eug70i/RhGNoNWHzlY72pI7JA4rA2tQtv59a0goajrQA==
X-Received: by 2002:adf:f544:0:b0:341:a813:2679 with SMTP id j4-20020adff544000000b00341a8132679mr4626455wrp.29.1711385004614;
        Mon, 25 Mar 2024 09:43:24 -0700 (PDT)
Received: from ?IPV6:2003:cb:c738:b400:6a82:1eac:2b5:8fca? (p200300cbc738b4006a821eac02b58fca.dip0.t-ipconnect.de. [2003:cb:c738:b400:6a82:1eac:2b5:8fca])
        by smtp.gmail.com with ESMTPSA id x16-20020a5d6b50000000b0033e93e00f68sm9960271wrw.61.2024.03.25.09.43.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 09:43:24 -0700 (PDT)
Message-ID: <6f5b9d18-2d04-495c-970c-eb5eada5f676@redhat.com>
Date: Mon, 25 Mar 2024 17:43:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: kernel BUG at mm/usercopy.c:102 -- pc : usercopy_abort
Content-Language: en-US
To: Xiubo Li <xiubli@redhat.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
 Ceph Development <ceph-devel@vger.kernel.org>,
 linux-fsdevel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>
References: <e119b3e2-09a0-47a7-945c-98a1f03633ef@redhat.com>
 <f453061e-6e01-4ad7-8fc6-a39108beacfc@redhat.com>
 <d689e8bf-6628-499e-8a11-c74ce1b1fd8b@redhat.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <d689e8bf-6628-499e-8a11-c74ce1b1fd8b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25.03.24 13:06, Xiubo Li wrote:
> 
> On 3/25/24 18:14, David Hildenbrand wrote:
>> On 25.03.24 08:45, Xiubo Li wrote:
>>> Hi guys,
>>>
>>> We are hitting the same crash frequently recently with the latest kernel
>>> when testing kceph, and the call trace will be something likes:
>>>
>>> [ 1580.034891] usercopy: Kernel memory exposure attempt detected from
>>> SLUB object 'kmalloc-192' (offset 82, size 499712)!^M
>>> [ 1580.045866] ------------[ cut here ]------------^M
>>> [ 1580.050551] kernel BUG at mm/usercopy.c:102!^M
>>> ^M
>>> Entering kdb (current=0xffff8881211f5500, pid 172901) on processor 4
>>> Oops: (null)^M
>>> due to oops @ 0xffffffff8138cabd^M
>>> CPU: 4 PID: 172901 Comm: fsstress Tainted: G S 6.6.0-g623393c9d50c #1^M
>>> Hardware name: Supermicro SYS-5018R-WR/X10SRW-F, BIOS 1.0c 09/07/2015^M
>>> RIP: 0010:usercopy_abort+0x6d/0x80^M
>>> Code: 4c 0f 44 d0 41 53 48 c7 c0 1c e9 13 82 48 c7 c6 71 62 13 82 48 0f
>>> 45 f0 48 89 f9 48 c7 c7 f0 6b 1b 82 4c 89 d2 e8 63 2b df ff <0f> 0b 49
>>> c7 c1 44 c8 14 82 4d 89 cb 4d 89 c8 eb a5 66 90 f3 0f 1e^M
>>> RSP: 0018:ffffc90006dfba88 EFLAGS: 00010246^M
>>> RAX: 000000000000006a RBX: 000000000007a000 RCX: 0000000000000000^M
>>> RDX: 0000000000000000 RSI: ffff88885fd1d880 RDI: ffff88885fd1d880^M
>>> RBP: 000000000007a000 R08: 0000000000000000 R09: c0000000ffffdfff^M
>>> R10: 0000000000000001 R11: ffffc90006dfb930 R12: 0000000000000001^M
>>> R13: ffff8882b7bbed12 R14: ffff88827a375830 R15: ffff8882b7b44d12^M
>>> FS:  00007fb24c859500(0000) GS:ffff88885fd00000(0000)
>>> knlGS:0000000000000000^M
>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033^M
>>> CR2: 000055c2bcf9eb00 CR3: 000000028956c005 CR4: 00000000001706e0^M
>>> Call Trace:^M
>>>     <TASK>^M
>>>     ? kdb_main_loop+0x32c/0xa10^M
>>>     ? kdb_stub+0x216/0x420^M
>>> more>
>>>
>>> You can see more detail in ceph tracker
>>> https://tracker.ceph.com/issues/64471.
>>
>> Where is the full backtrace? Above contains only the backtrace of kdb.
>>
> Hi David,
> 
> The bad news is that there is no more backtrace. All the failures we hit
> are similar with the following logs:
> 

That's unfortunate :/

"exposure" in the message means we are in copy_to_user().

SLUB object 'kmalloc-192' means that we come from __check_heap_object() 
.. we have 192 bytes, but the length we want to access is 499712 ... 
488 KiB.

So we ended  up somehow in

__copy_to_user()->check_object_size()->__check_object_size()->
check_heap_object()->__check_heap_object()->usercopy_abort()


.. but the big question is which code tried to copy way too much memory 
out of a slab folio to user space.

> 
>> That link also contains:
>>
>> Entering kdb (current=0xffff9115d14fb980, pid 61925) on processor 5
>> Oops: (null)^M
>> due to oops @ 0xfffffffface3a1d2^M
>> CPU: 5 PID: 61925 Comm: ld Kdump: loaded Not tainted
>> 5.14.0-421.el9.x86_64 #1^M
>> Hardware name: Supermicro SYS-5018R-WR/X10SRW-F, BIOS 2.0 12/17/2015^M
>> RIP: 0010:usercopy_abort+0x74/0x76^M
>> Code: 14 74 ad 51 48 0f 44 d6 49 c7 c3 cb 9f 73 ad 4c 89 d1 57 48 c7
>> c6 60 83 75 ad 48 c7 c7 00 83 75 ad 49 0f 44 f3 e8 1b 3b ff ff <0f> 0b
>> 0f b6 d3 4d 89 e0 48 89 e9 31 f6 48 c7 c7 7f 83 75 ad e8 73^M
>> RSP: 0018:ffffbb97c16af8d0 EFLAGS: 00010246^M
>> RAX: 0000000000000072 RBX: 0000000000000112 RCX: 0000000000000000^M
>> RDX: 0000000000000000 RSI: ffff911d1fd60840 RDI: ffff911d1fd60840^M
>> RBP: 0000000000004000 R08: 80000000ffff84b4 R09: 0000000000ffff0a^M
>> R10: 0000000000000004 R11: 0000000000000076 R12: ffff9115c0be8b00^M
>> R13: 0000000000000001 R14: ffff911665df9f68 R15: ffff9115d16be112^M
>> FS:  00007ff20442eb80(0000) GS:ffff911d1fd40000(0000)
>> knlGS:0000000000000000^M
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033^M
>> CR2: 00007ff20446142d CR3: 00000001215ec003 CR4: 00000000003706e0^M
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000^M
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400^M
>> Call Trace:^M
>>   <TASK>^M
>>   ? show_trace_log_lvl+0x1c4/0x2df^M


.. are we stuck in show_trace_log_lvl(), probably deadlocked not being 
able to print the actuall callstack? If so, that's nasty.

-- 
Cheers,

David / dhildenb


