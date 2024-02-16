Return-Path: <linux-kernel+bounces-68308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A797857886
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C868A286608
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569251B81B;
	Fri, 16 Feb 2024 09:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fyj/55Yi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CF91B818
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 09:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708074482; cv=none; b=Y0zixR64JYwJDl0vPdwOdwbKuSGC6ifKvgNnLXYHo5YUMc7Ewgez1HssYVB82rQJ0ANivYBllt8GQlrtkNV7S5MvnFwfjL+yG35E45unUm+savjIoS/D673YQEPuKXGXGyUNqx7Vcp/CBdqwbk/vebQV3chzRSKHipJx4ll9TA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708074482; c=relaxed/simple;
	bh=7J8pSL/32D94uVprNImCvGjjaFCv6Y80DkeF9Zb0ecc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bbSDLSO776JjnlmrcZub+2pxvIdprAqdYe1lxg/HfWoKNex2EUfKcon9b8l3n4dWhre8I49NjC9HI+EdvzONEG9QqQhSx3RWX8wHLfh9jcQxccJ6rEPkkBxlfdd6nQiQ9An/xyt4qV3NpDa2FcyJ0U7AiPA+eiDe+lBzRcOBMd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fyj/55Yi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708074479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nZitMWe+tPaHyOlddPHAfwqLwys1/LvTwfEIL/HS1ek=;
	b=Fyj/55YiXFZpzxsfIcAuphU54pnHpeCAjnAw3gWrobM5SV8igqriQb1qtJtu+PjCLVhv0l
	2+NbVROZlBUqLmzwynBuTI/SEN6oUCWw/qq+EZEcwe7Fvi8HpQ5UjelmJV0kPAM148npUm
	aWHmpRdq9SV2DscKsv5hzKVqjZC5arw=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-8-mlE5rCOhGR8kWAhFRcow-1; Fri, 16 Feb 2024 04:07:58 -0500
X-MC-Unique: 8-mlE5rCOhGR8kWAhFRcow-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-51145df2a08so1016239e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 01:07:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708074476; x=1708679276;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZitMWe+tPaHyOlddPHAfwqLwys1/LvTwfEIL/HS1ek=;
        b=wJVJGYRaObyJ9Tv5fneUECgGGNDZXTkL8IiWRTiZv7VfeamwyXS4yXZKBF7tvtCByF
         RrPtTtEvWi5neRIevXQnMxapzJEHOPKWGxJFWjrdg+QK6TGaqbpcnivG/5buWw35/kTe
         fZ1/NXZJFEXeT9s7Ejy7puDpBNRglcUlRhO4skAokBjgX6rLOpsDxxN7WDJvjJIvvhgP
         i4wMpaapdGzDkf7P3Xau444LVsPptEE7vIOE/wMVRmvZEGY63oiy2Yipm4fi7B2OVaGu
         7IHwIHQYFwDZuWuH7xVWEt6hEzhQT+dToEDthSIuPbhWuR1zAYfj49sF/KeWdFy39cTP
         GTEw==
X-Gm-Message-State: AOJu0Yy89y3FjqERtO/8C97ZDNlfVoVqY1Q7PgHtGBpZ2h9pfyoXMfhK
	ZrMNbxy2sy2SQmy8rMs9D+1f2aLrQ/9jg9as7GEjyk+G7/zAIv5sl4e7liqBc+FpvcXEkto/n1k
	KvvpGulxjW75PE7r366EdvtSbIm2sdexcMply7+r2tVJzAa8KeJsgTZDjeh71Fg==
X-Received: by 2002:a05:6512:3a85:b0:512:8482:a7e0 with SMTP id q5-20020a0565123a8500b005128482a7e0mr1633154lfu.33.1708074476628;
        Fri, 16 Feb 2024 01:07:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRmxUki7Suc5I/78almuAPevH2G9vaTICnUFr00lsv2dp2nHb7Tv9xubh64Vh932zCSKlWBQ==
X-Received: by 2002:a05:6512:3a85:b0:512:8482:a7e0 with SMTP id q5-20020a0565123a8500b005128482a7e0mr1633137lfu.33.1708074476142;
        Fri, 16 Feb 2024 01:07:56 -0800 (PST)
Received: from ?IPV6:2003:d8:2f3c:3f00:7177:eb0c:d3d2:4b0e? (p200300d82f3c3f007177eb0cd3d24b0e.dip0.t-ipconnect.de. [2003:d8:2f3c:3f00:7177:eb0c:d3d2:4b0e])
        by smtp.gmail.com with ESMTPSA id 20-20020ac24854000000b005115e1d1998sm543119lfy.59.2024.02.16.01.07.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 01:07:55 -0800 (PST)
Message-ID: <b7fa4eb9-2659-4766-b8da-d6281f34a4ee@redhat.com>
Date: Fri, 16 Feb 2024 10:07:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sched/numa, mm: do not promote folios to nodes not set
 N_MEMORY
To: Byungchul Park <byungchul@sk.com>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, akpm@linux-foundation.org
References: <20240216073340.55404-1-byungchul@sk.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240216073340.55404-1-byungchul@sk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.02.24 08:33, Byungchul Park wrote:
> Changes from v1:
> 	1. Trim the verbose oops in the commit message. (feedbacked by
> 	   Phil Auld)
> 	2. Rewrite a comment in code. (feedbacked by Phil Auld)
> 
> --->8---
>  From 6830b59db267a31b78f6f09af12ae0e3132b4bca Mon Sep 17 00:00:00 2001
> From: Byungchul Park <byungchul@sk.com>
> Date: Fri, 16 Feb 2024 16:26:23 +0900
> Subject: [PATCH v2] sched/numa, mm: do not promote folios to nodes not set N_MEMORY
> 
> While running qemu with a configuration where some CPUs don't have their
> local memory and with a kernel numa balancing on, the following oops has
> been observed. It's because of null pointers of ->zone_pgdat of zones of
> those nodes that are not initialized properly at booting time. So should
> avoid nodes not set N_MEMORY from getting promoted.
> 
>> BUG: unable to handle page fault for address: 00000000000033f3
>> #PF: supervisor read access in kernel mode
>> #PF: error_code(0x0000) - not-present page
>> PGD 0 P4D 0
>> Oops: 0000 [#1] PREEMPT SMP NOPTI
>> CPU: 2 PID: 895 Comm: masim Not tainted 6.6.0-dirty #255
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>>     rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
>> RIP: 0010:wakeup_kswapd (./linux/mm/vmscan.c:7812)
>> Code: (omitted)
>> RSP: 0000:ffffc90004257d58 EFLAGS: 00010286
>> RAX: ffffffffffffffff RBX: ffff88883fff0480 RCX: 0000000000000003
>> RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88883fff0480
>> RBP: ffffffffffffffff R08: ff0003ffffffffff R09: ffffffffffffffff
>> R10: ffff888106c95540 R11: 0000000055555554 R12: 0000000000000003
>> R13: 0000000000000000 R14: 0000000000000000 R15: ffff88883fff0940
>> FS:  00007fc4b8124740(0000) GS:ffff888827c00000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00000000000033f3 CR3: 000000026cc08004 CR4: 0000000000770ee0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> PKRU: 55555554
>> Call Trace:
>>   <TASK>
>> ? __die
>> ? page_fault_oops
>> ? __pte_offset_map_lock
>> ? exc_page_fault
>> ? asm_exc_page_fault
>> ? wakeup_kswapd
>> migrate_misplaced_page
>> __handle_mm_fault
>> handle_mm_fault
>> do_user_addr_fault
>> exc_page_fault
>> asm_exc_page_fault
>> RIP: 0033:0x55b897ba0808
>> Code: (omitted)
>> RSP: 002b:00007ffeefa821a0 EFLAGS: 00010287
>> RAX: 000055b89983acd0 RBX: 00007ffeefa823f8 RCX: 000055b89983acd0
>> RDX: 00007fc2f8122010 RSI: 0000000000020000 RDI: 000055b89983acd0
>> RBP: 00007ffeefa821a0 R08: 0000000000000037 R09: 0000000000000075
>> R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
>> R13: 00007ffeefa82410 R14: 000055b897ba5dd8 R15: 00007fc4b8340000
>>   </TASK>
> 

This sounds like we need a Fixes: and want to CC stable?

-- 
Cheers,

David / dhildenb


