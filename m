Return-Path: <linux-kernel+bounces-109878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 097DE8856FA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CDC01C21A6F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB1F55E6A;
	Thu, 21 Mar 2024 09:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z53xnkHG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE0253E1E
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 09:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711015089; cv=none; b=BH/tnJa/52o7pj7Udon0tZ1UP4rFOvhu+B1q9MUvAd4ala/BC2ZiBMQi/3A6NDAUn3YsiUaZO7LLrbLo5weYnIfFHcJQv3wwj3/dBuppx6gku3dNEeKZqwjhSHDus4Fkxic6QxqLuQarGH2lLtm3LT9/+l86Nmh0G/lKjnpnLv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711015089; c=relaxed/simple;
	bh=wIXaF69GYpm7Zwgtk8pz3GT+ZJJ/YGzldTFEtZLipX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dlcQoqzZR+KeCRhsBTg98FjJB+31h//2ovR5dDY86QhMfH5iotX0eQ211XkwhVCuFq6rJKtu9+pHAz/qLJlz6D5yt2dTgjIrp7GqtRsKcBwoM4nVDfXQiY5bVGPOWXisFBP85x0FmBJDQjC8rzGdVlCVd5wqHrEHxYDM+hX6ilY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z53xnkHG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711015086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rYLDXAVfWEUBeFKPMdJQGxtkIv6hjIqodLMpkUKFwTk=;
	b=Z53xnkHGzSJO7Vu/yaiuaXynYd5fnaMLQZ0hl8vwTWxvPhga6LLqSIYb7I4a0pufuQFXDk
	e2JdKotBKYTPMxsts48KgNcjkzlhDl/FrdZOcPvhUwyNEpP2hORsd+cEUllTc8/yw3NPsh
	nZ5MAHwirsktOP/v/UgNqCPyBxYVJjk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-ijDZaxnNN_OiUXOFiJgAeg-1; Thu, 21 Mar 2024 05:58:04 -0400
X-MC-Unique: ijDZaxnNN_OiUXOFiJgAeg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4140eacf418so3921575e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 02:58:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711015083; x=1711619883;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rYLDXAVfWEUBeFKPMdJQGxtkIv6hjIqodLMpkUKFwTk=;
        b=bEJLgWfnf5XhPR7++WzJSJTc0R8JQdGo1p868+AIIdgAL5T1G6gHDpTxbhctXKefsB
         5ltjkcvB2lF2rz+Ljj9bBEIGQyB2BJ5/9pkftNaPZmBrFRFAk9JSyhrVk7Bmz98Xcn2n
         IrdS/Xt2uVaAnTH9fakcqjSeBWNN9GLDVj1ovyFalQiNiBLQmTib+bGGTKi8zDl4pL6V
         ReNkn8b0ECiVsp6XqJXKJEh/c7c4HbMmeJTbJE02Bk4Doyp47sdPChbVQxoTLDr6sitB
         ex9hwFJIN1UNMKEvvQdHjibtyGveDf1l+R8ooCxaWjr+rUK1vyaiICYoDCmakkpvGJnf
         qSXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdgVjGN/L3cLSqN253E2Osdfkw02Ol2zYS9wBwB6vBA52f4mXN2NW9LDsrBKTo0ay+qXqCYpkvDJbPN5NRbLGVlDL4ftOt5DlaE2is
X-Gm-Message-State: AOJu0YzWzBC2f7vANXTrg4FK9XWS6DoDwio6kLbgFFe/INx8RfbIj+RV
	zJEvlwflAOUiJWKamYD6kK40618+n0TP04TaNcSn5RRpcIOA/Zng81uZ3DOFyr06wyWnFXEeHiR
	lG+AUubE8x+yQM2fDULWFgEXFmkvLh0cnnLvOj6JWgNmCHltpc4XGkzr9RuWM6g==
X-Received: by 2002:a05:600c:a4c:b0:414:729:1189 with SMTP id c12-20020a05600c0a4c00b0041407291189mr12106432wmq.21.1711015083049;
        Thu, 21 Mar 2024 02:58:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0RyM4UfZuoh9Uo/6ZxxysSyo8eFsLzjED5kdOIxWx56T/5XAzYobF8Es3cXFwgn/uWgmgPQ==
X-Received: by 2002:a05:600c:a4c:b0:414:729:1189 with SMTP id c12-20020a05600c0a4c00b0041407291189mr12106411wmq.21.1711015082589;
        Thu, 21 Mar 2024 02:58:02 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id k36-20020a05600c1ca400b00412f2136793sm5071474wms.44.2024.03.21.02.58.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 02:58:02 -0700 (PDT)
Message-ID: <989d5e03-d18e-4fbf-8b55-a847a928c8fd@redhat.com>
Date: Thu, 21 Mar 2024 10:58:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] kernel BUG in const_folio_flags
Content-Language: en-US
To: Muchun Song <muchun.song@linux.dev>,
 syzbot <syzbot+3b9148f91b7869120e81@syzkaller.appspotmail.com>,
 Oscar Salvador <osalvador@suse.de>, Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
 syzkaller-bugs@googlegroups.com
References: <0000000000006cfe98061423cde7@google.com>
 <812E97E8-668F-414D-9480-1D284834A034@linux.dev>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <812E97E8-668F-414D-9480-1D284834A034@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.03.24 10:49, Muchun Song wrote:
> 
> 
>> On Mar 21, 2024, at 12:04, syzbot <syzbot+3b9148f91b7869120e81@syzkaller.appspotmail.com> wrote:
>>
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    78c3925c048c Merge tag 'soc-late-6.9' of git://git.kernel...
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=1267d879180000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=f3c2635ded15fbc9
>> dashboard link: https://syzkaller.appspot.com/bug?extid=3b9148f91b7869120e81
>> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
>> userspace arch: i386
>>
>> Unfortunately, I don't have any reproducer for this issue yet.
>>
>> Downloadable assets:
>> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-78c3925c.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/cf2bceeccde3/vmlinux-78c3925c.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/fc938dfaea6d/bzImage-78c3925c.xz
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+3b9148f91b7869120e81@syzkaller.appspotmail.com
>>
>> veth_newlink+0x627/0xa10 drivers/net/veth.c:1895
>> rtnl_newlink_create net/core/rtnetlink.c:3494 [inline]
>> __rtnl_newlink+0x119c/0x1960 net/core/rtnetlink.c:3714
>> rtnl_newlink+0x67/0xa0 net/core/rtnetlink.c:3727
>> rtnetlink_rcv_msg+0x3c7/0xe60 net/core/rtnetlink.c:6595
>> ------------[ cut here ]------------
>> kernel BUG at include/linux/page-flags.h:315!
> 
> There are some more page dumping information from console:
> 
> [ 61.367144][ T42] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff888028132880 pfn:0x28130
> [ 61.371430][ T42] flags: 0xfff80000000000(node=0|zone=1|lastcpupid=0xfff)
> [ 61.374455][ T42] page_type: 0xffffffff()
> [ 61.376096][ T42] raw: 00fff80000000000 ffff888015ecd540 dead000000000100 0000000000000000
> [ 61.379994][ T42] raw: ffff888028132880 0000000000190000 00000000ffffffff 0000000000000000
> 
> Alright, the page is freed (with a refcount of 0).
> 
>> invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
>> CPU: 1 PID: 42 Comm: kcompactd0 Not tainted 6.8.0-syzkaller-11725-g78c3925c048c #0
>> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
>> RIP: 0010:const_folio_flags+0x1bd/0x1f0 include/linux/page-flags.h:315
> 
> The RIP is in const_folio_flags() (called from folio_test_hugetlb()):
> 
> 	VM_BUG_ON_PGFLAGS(n > 0 && !test_bit(PG_head, &page->flags), page);
> 
> It is reasonable to WARN because the page is freed (PG_head is not set
> in this case).
> 
> The comments from folio_test_hugetlb() says "Caller should have a
> reference on the folio", so the caller of PageHuge() should grab
> a refcount before calling folio_test_hugetlb() since commit
> 9c5ccf2db04b. But it does not mean that the @page must be a HugeTLB page
> even if PageHuge(@page) returns true when the user does not hold
> a extra refcount on the @page. Seems the WARN could be acceptable, so
> should we remove this WARN? I am not sure. Cc more experts.

Isn't this the problem Willy is fixing with the upcoing 
folio_test_hugetlb() changes?

We cannot always grab a folio reference on hugetlb folios: free hugetlb 
folios have a refcount of 0.

-- 
Cheers,

David / dhildenb


