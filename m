Return-Path: <linux-kernel+bounces-25200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB87D82CA0C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 06:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2A021C227C9
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 05:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFCA18EA9;
	Sat, 13 Jan 2024 05:57:49 +0000 (UTC)
Received: from out0-221.mail.aliyun.com (out0-221.mail.aliyun.com [140.205.0.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2AD18C21
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 05:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047205;MF=libang.li@antgroup.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---.W59eyl6_1705125139;
Received: from 30.39.211.193(mailfrom:libang.li@antgroup.com fp:SMTPD_---.W59eyl6_1705125139)
          by smtp.aliyun-inc.com;
          Sat, 13 Jan 2024 13:52:20 +0800
Message-ID: <a15af04e-ed31-45a7-958c-8c727ee046db@antgroup.com>
Date: Sat, 13 Jan 2024 13:52:17 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/compaction: Reduce unnecessary loops
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>
Cc:  <linux-mm@kvack.org>,
   <linux-kernel@vger.kernel.org>,
  "=?UTF-8?B?5pyx6L6JKOiMtuawtCk=?=" <teawater@antgroup.com>,
  "=?UTF-8?B?WWFuIFlhbihjYWlsaW5nKQ==?=" <yanyan.yan@antgroup.com>
References: <20240112073524.80724-1-libang.li@antgroup.com>
 <20240112112551.bbc9d5114fd2c6fb421fed2d@linux-foundation.org>
From: "Bang Li" <libang.li@antgroup.com>
In-Reply-To: <20240112112551.bbc9d5114fd2c6fb421fed2d@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2024/1/13 3:25, Andrew Morton wrote:
> On Fri, 12 Jan 2024 15:35:24 +0800 "Bang Li" <libang.li@antgroup.com> wrote:
> 
>> Compaction will be triggered when we write 1 to '/proc/sys/vm/
>> compact_memory'. During the execution of the process, when we send
>> SIGKILL to terminate the compaction, the process does not exit
>> immediately. Instead, it will continue to loop through the remaining
>> zones and nodes before exiting.
>>
>> in my environment:
>>
>> [root]# cat /proc/buddyinfo
>> Node 0, zone      DMA      1      1      1      0      2      1      1      0      1      1      3
>> Node 0, zone    DMA32   1666   1123    804    625    488    356    321    278    209    178    250
>> Node 0, zone   Normal  58852  83160  49983   9812   2287   1229  19604  24471  10346   5219  12205
>> [root]# echo 1 > /sys/kernel/debug/tracing/events/compaction/mm_compaction_end/enable
>>
>> before the patch:
>>
>> [root]# timeout --signal=SIGKILL 0.002 bash -c 'echo 1 > /proc/sys/vm/compact_memory'
>> [root]# cat /sys/kernel/debug/tracing/trace_pipe
>>             <...>-26494   [014] .....   226.468993: mm_compaction_end: zone_start=0x1 migrate_pfn=0xe00 free_pfn=0xe00 zone_end=0x1000, mode=sync status=complete
>>             <...>-26494   [014] .....   226.469718: mm_compaction_end: zone_start=0x1000 migrate_pfn=0x20a80 free_pfn=0xffe00 zone_end=0x100000, mode=sync status=contended
>>             <...>-26494   [014] .....   226.469720: mm_compaction_end: zone_start=0x100000 migrate_pfn=0x100000 free_pfn=0x307fe00 zone_end=0x3080000, mode=sync status=contended
>>
>> after the patch:
>>
>> [root]# timeout --signal=SIGKILL 0.002 bash -c 'echo 1 > /proc/sys/vm/compact_memory'
>> [root]# cat /sys/kernel/debug/tracing/trace_pipe
>>             <...>-17491   [053] .....   109.005387: mm_compaction_end: zone_start=0x1 migrate_pfn=0xe00 free_pfn=0xe00 zone_end=0x1000, mode=sync status=complete
>>             <...>-17491   [053] .....   109.006139: mm_compaction_end: zone_start=0x1000 migrate_pfn=0x22220 free_pfn=0xffe00 zone_end=0x100000, mode=sync status=contended
>>
>> Although it exits quickly after receiving the SIGKILL signal, a better
>> solution is to terminate the loop early after receiving the SIGKILL
>> signal.
>>
> 
> What is the use case here?  The requirement?  Why is this change
> valuable to anyone?

Thanks for the quick reply! I'm very sorry that my inappropriate use
case confused you. What I want to explain is that when receiving the
SIGKILL signal, we can break in advance to reduce unnecessary loops.
This is a clean up patch, the purpose is to reduce the execution of
unnecessary code. If possible, I will remove the confusing use case
in V2.

Thanks,
Bang

