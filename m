Return-Path: <linux-kernel+bounces-156404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F35B8B0264
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C7D11F235BD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98036157496;
	Wed, 24 Apr 2024 06:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="Adv0wqJ6"
Received: from out187-13.us.a.mail.aliyun.com (out187-13.us.a.mail.aliyun.com [47.90.187.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E018B157E6F;
	Wed, 24 Apr 2024 06:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.187.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713941254; cv=none; b=I0P9kiaCM/zFt7/t8GBc1/+VGbakDIJF0zfpRhKwiDo4WQyVZahL88S9Y1WdcVZLEl/yMLIR5UdkD31hVW99MdIK1nw6gLPTSj7051bp7dkFbR4niDlDubF2nc+ceNIB6WW3pP1sjYx/eJT2/fdeq9SuFD05a0uFZlqSXrI+pKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713941254; c=relaxed/simple;
	bh=uiA6RahtXpQY6x5T9I+rP5/7J6g1Eo/odP5FiYDOeq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cg+HKaoQO3npIX5wUtK+Oof8cbbq4oLzJzqiWrZCM8HJUYUgyZ33G3N9WF8ZMDTaSkle41aIRn5sYkguD/n2NIXYjnjayA/Bn9vg3PQWtkFQCxjFW/DMl6GAJy+2WGs3ZRLIg1xuTG7FQQ/PskxhqlZsOpfW+uZULTLtCy5qNx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=Adv0wqJ6; arc=none smtp.client-ip=47.90.187.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1713941236; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=pLySQKq/ziiSx3OElMQkmWhbR3BRW+QYdJXOWSjqiIc=;
	b=Adv0wqJ6FOEAj8fqmuXiF5KyRd2Jzt4FY4cIBbJgqt/5wyPZqsBZnpvcEWY0HYg0p6NcucqNvTjIJ60/k0QXQPokkbR3dYCfE8IAXr/ZnRBEGCftJFyuxWsdCsChY5RTlKZxNbeoi2c+fujnBKeh4yhBqy49TPcuKpRVRcZQxAM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047206;MF=zhubojun.zbj@antgroup.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---.XK6ecGE_1713941213;
Received: from 30.177.49.56(mailfrom:zhubojun.zbj@antgroup.com fp:SMTPD_---.XK6ecGE_1713941213)
          by smtp.aliyun-inc.com;
          Wed, 24 Apr 2024 14:47:16 +0800
Message-ID: <85dfbebc-a2d5-4828-b3b9-f929cd6e30cf@antgroup.com>
Date: Wed, 24 Apr 2024 14:46:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] x86/sgx: Explicitly give up the CPU in EDMM's
 ioctl() to avoid softlockup
To: "Huang, Kai" <kai.huang@intel.com>,
 "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "jarkko@kernel.org" <jarkko@kernel.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Cc: "=?UTF-8?B?5YiY5Y+MKOi9qeWxuSk=?=" <ls123674@antgroup.com>,
  "=?UTF-8?B?Q2hhdHJlLCBSZWluZXR0ZQ==?=" <reinette.chatre@intel.com>
References: <20240423092550.59297-1-zhubojun.zbj@antgroup.com>
 <20240423092550.59297-2-zhubojun.zbj@antgroup.com>
 <02fe00c3b10e4476d500ad7a34024b7eae5e3c97.camel@intel.com>
Content-Language: en-US
From: "Bojun Zhu" <zhubojun.zbj@antgroup.com>
In-Reply-To: <02fe00c3b10e4476d500ad7a34024b7eae5e3c97.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Kai,

On 2024/4/23 19:50, Huang, Kai wrote:
> On Tue, 2024-04-23 at 17:25 +0800, 朱伯君(杰铭) wrote:
>> EDMM's ioctl()s support batch operations, which may be
>> time-consuming. Try to explicitly give up the CPU at
>> the every end of "for loop" in
>> sgx_enclave_{ modify_types | restrict_permissions | remove_pages}
>> to give other tasks a chance to run, and avoid softlockup warning.
>>
>> The following has been observed on Linux v6.9-rc5 with kernel
>> preemptions disabled(by configuring "PREEMPT_NONE=y"), when kernel
>> is requested to restrict page permissions of a large number of EPC pages.
>>
>>      ------------[ cut here ]------------
>>      watchdog: BUG: soft lockup - CPU#45 stuck for 22s! [occlum-run:3905]
>>      ...
>>      CPU: 45 PID: 3905 Comm: occlum-run Not tainted 6.9.0-rc5 #7
>>      ...
>>      RIP: 0010:sgx_enclave_restrict_permissions+0xba/0x1f0
>>      Code: 48 c1 e6 05 48 89 d1 48 8d 5c 24 40 b8 0e 00 00 00 48 2b 8e 70 8e f5 93 48 c1 e9 05 48 c1 e1 0c 48 03 8e 68 8e f5 93 0f 01 cf <a9> 00 00 00 40 0f 85 b2 00 00 00 85 c0 0f 85 db 00 00 00 4c 89 ef
>>      RSP: 0018:ffffb55a6591fa80 EFLAGS: 00000202
>>      RAX: 0000000000000000 RBX: ffffb55a6591fac0 RCX: ffffb581e7384000
>>      RDX: ffffb59a9e4e8080 RSI: 0000000000000020 RDI: ffff91d69e8cc000
>>      RBP: ffffb55a6591fb70 R08: 0000000000000002 R09: ffff91d646e12be0
>>      R10: 000000000000006e R11: 0000000000000002 R12: 000000072052d000
>>      R13: ffff91d69e8cc000 R14: ffffb55a6591fbd8 R15: ffff91d69e8cc020
>>      FS:  00007fe10dbda740(0000) GS:ffff92163e480000(0000) knlGS:0000000000000000
>>      CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>      CR2: 00007fc041811000 CR3: 00000040d95c8005 CR4: 0000000000770ef0
>>      DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>      DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
>>      PKRU: 55555554
>>      Call Trace:
>>       <IRQ>
>>       ? show_regs+0x67/0x70
>>       ? watchdog_timer_fn+0x1f3/0x280
>>       ? __pfx_watchdog_timer_fn+0x10/0x10
>>       ? __hrtimer_run_queues+0xc8/0x220
>>       ? hrtimer_interrupt+0x10c/0x250
>>       ? __sysvec_apic_timer_interrupt+0x53/0x130
>>       ? sysvec_apic_timer_interrupt+0x7b/0x90
>>       </IRQ>
>>       <TASK>
>>       ? asm_sysvec_apic_timer_interrupt+0x1b/0x20
>>       ? sgx_enclave_restrict_permissions+0xba/0x1f0
>>       ? __pte_offset_map_lock+0x94/0x110
>>       ? sgx_encl_test_and_clear_young_cb+0x40/0x60
>>       sgx_ioctl+0x1ab/0x900
>>       ? do_syscall_64+0x79/0x110
>>       ? apply_to_page_range+0x14/0x20
>>       ? sgx_encl_test_and_clear_young+0x6c/0x80
>>       ? sgx_vma_fault+0x132/0x4f0
>>       __x64_sys_ioctl+0x95/0xd0
>>       x64_sys_call+0x1209/0x20c0
>>       do_syscall_64+0x6d/0x110
>>       ? do_syscall_64+0x79/0x110
>>       ? do_pte_missing+0x2e8/0xcc0
>>       ? __pte_offset_map+0x1c/0x190
>>       ? __handle_mm_fault+0x7b9/0xe60
>>       ? __count_memcg_events+0x70/0x100
>>       ? handle_mm_fault+0x256/0x360
>>       ? do_user_addr_fault+0x3c1/0x860
>>       ? irqentry_exit_to_user_mode+0x67/0x190
>>       ? irqentry_exit+0x3b/0x50
>>       ? exc_page_fault+0x89/0x180
>>       entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>      RIP: 0033:0x7fe10e2ee5cb
>>      Code: 0f 1e fa 48 8b 05 c5 78 0d 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 95 78 0d 00 f7 d8 64 89 01 48
>>      RSP: 002b:00007fffb2c75518 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>>      RAX: ffffffffffffffda RBX: 0000000780000000 RCX: 00007fe10e2ee5cb
>>      RDX: 00007fffb2c75520 RSI: 00000000c028a405 RDI: 0000000000000005
>>      RBP: 0000000000000005 R08: 0000000000000000 R09: 00007fffb2c75594
>>      R10: 00007fffb2c755c8 R11: 0000000000000246 R12: 00000000c028a405
>>      R13: 00007fffb2c75520 R14: 0000000780000000 R15: 00007fe10e1a7980
>>       </TASK>
>>       ------------[ end trace ]------------
> Could you trim down the trace to only include the relevant part?
>
> E.g., please at least remove the two register dumps at the beginning and
> end of the trace.
>
> Please refer to "Backtraces in commit messages" section in
> Documentation/process/submitting-patches.rst.


Thanks for your advice! I will refine the trace log according to the 
suggestions
in Documentation/process/submitting-patches.rst. and highlight the 
related part.


>> Signed-off-by: Bojun Zhu <zhubojun.zbj@antgroup.com>
>> ---
>>   arch/x86/kernel/cpu/sgx/ioctl.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
>> index b65ab214bdf5..2340a82fa796 100644
>> --- a/arch/x86/kernel/cpu/sgx/ioctl.c
>> +++ b/arch/x86/kernel/cpu/sgx/ioctl.c
>> @@ -806,6 +806,9 @@ sgx_enclave_restrict_permissions(struct sgx_encl *encl,
>>   		}
>>   
>>   		mutex_unlock(&encl->lock);
>> +
>> +		if (need_resched())
>> +			cond_resched();
>>   	}
>>   
>>   	ret = 0;
>> @@ -1010,6 +1013,9 @@ static long sgx_enclave_modify_types(struct sgx_encl *encl,
>>   		entry->type = page_type;
>>   
>>   		mutex_unlock(&encl->lock);
>> +
>> +		if (need_resched())
>> +			cond_resched();
>>   	}
>>   
>>   	ret = 0;
>> @@ -1156,6 +1162,9 @@ static long sgx_encl_remove_pages(struct sgx_encl *encl,
>>   		kfree(entry);
>>   
>>   		mutex_unlock(&encl->lock);
>> +
>> +		if (need_resched())
>> +			cond_resched();
>>   	}
>>
> You can remove the need_reshced() in all 3 places above but just call
> cond_resched() directly.
>

Based on the the discussion among you, Jarkko and Reinette,
I will keep the need_resched() and wrap the logic in using sgx_resched(),
as suggested by Jarkko.

Regards,

Bojun


