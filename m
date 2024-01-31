Return-Path: <linux-kernel+bounces-46403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75519843F32
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99D811C26F15
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CE978680;
	Wed, 31 Jan 2024 12:11:02 +0000 (UTC)
Received: from out0-195.mail.aliyun.com (out0-195.mail.aliyun.com [140.205.0.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E8E7690F
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 12:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706703061; cv=none; b=YMx5E1UXw8GPdSXhTfPoLoRjYwch2ZxjI4r3rOStl07OChFg6HzG0RsTOB7Re2yFW4csJegYiIKhmx/ywxNvb+2h6IwcyWTYNBas72m3zt2wR9RXaqAIY26FA+BTHPLRn+G+L4sPKwLezD6dXdxgg3TTb6f5l7ku3tfKZasXm6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706703061; c=relaxed/simple;
	bh=0tbhu6X+MvgMtkaQTGKvfJ2vOsiP6uS+f3BLBu5E1MU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mOh7Z6QBmuMiiOigrs68QRuFKVLy9/6X7HrEEvoKgVXErNjaM1tda1JzxNo5q77TK826OXqgbB7Y2kuXDauOEIFQYz9NeKq42Fi4+baBh5U2CcyTIZePKKXhwm625VFjDXo8MaEQQt78XQJ+1lZST4Jw06qEf6zUa+ygQNzH5xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; arc=none smtp.client-ip=140.205.0.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047212;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---.WKJVyfM_1706703045;
Received: from 30.230.20.161(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.WKJVyfM_1706703045)
          by smtp.aliyun-inc.com;
          Wed, 31 Jan 2024 20:10:50 +0800
Message-ID: <8b21e697-c9b9-49aa-a7ad-e88a5d7f9c92@antgroup.com>
Date: Wed, 31 Jan 2024 20:10:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [sched/eevdf] 2227a957e1:
 BUG:kernel_NULL_pointer_dereference,address
Content-Language: en-US
To: Abel Wu <wuyun.abel@bytedance.com>,
 kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, aubrey.li@linux.intel.com,
 yu.c.chen@intel.com
References: <202401301012.2ed95df0-oliver.sang@intel.com>
 <23cbb613-c8a2-4f07-b83b-fa3104bef642@bytedance.com>
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <23cbb613-c8a2-4f07-b83b-fa3104bef642@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/30/24 6:13 PM, Abel Wu wrote:
> On 1/30/24 3:24 PM, kernel test robot Wrote:
>>
>>
>> Hello,
>>
>> (besides a previous performance report),
>> kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:
>>
>> commit: 2227a957e1d5b1941be4e4207879ec74f4bb37f8 ("sched/eevdf: Sort the rbtree by virtual deadline")
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>
>> [test failed on linus/master 3a5879d495b226d0404098e3564462d5f1daa33b]
>> [test failed on linux-next/master 01af33cc9894b4489fb68fa35c40e9fe85df63dc]
>>
>> in testcase: trinity
>> version: trinity-i386-abe9de86-1_20230429
>> with following parameters:
>>
>>     runtime: 300s
>>     group: group-03
>>     nr_groups: 5
>>
>> test-description: Trinity is a linux system call fuzz tester.
>> test-url: http://codemonkey.org.uk/projects/trinity/
>>
>>
>> compiler: clang-17
>> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
>>
>> (please refer to attached dmesg/kmsg for entire log/backtrace)
>>
>>
>>
>> we found this issue happens in very random way (23 out of 999 runs).
>> but keeps clean on parent.
> 
> Thanks for reporting, I will try to reproduce the issue. Does the 'parent'
> mean the same code branch without this commit?
> 
>>
>> 84db47ca7146d7bd 2227a957e1d5b1941be4e420787
>> ---------------- ---------------------------
>>         fail:runs  %reproduction    fail:runs
>>             |             |             |
>>             :999          2%          23:999   dmesg.BUG:kernel_NULL_pointer_dereference,address
>>             :999          2%          23:999   dmesg.Kernel_panic-not_syncing:Fatal_exception
>>             :999          2%          23:999   dmesg.Oops:#[##]
>>
>>
>>
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <oliver.sang@intel.com>
>> | Closes: https://lore.kernel.org/oe-lkp/202401301012.2ed95df0-oliver.sang@intel.com
>>
>>
>> sorry for below parse failure which caused no real line numbers.
>> we will follow further. the orgial dmesg could be fetch from below link.
>>
>>
>> [  512.079810][ T8305] BUG: kernel NULL pointer dereference, address: 0000002c
>> [  512.080897][ T8305] #PF: supervisor read access in kernel mode
>> [  512.081636][ T8305] #PF: error_code(0x0000) - not-present page
>> [  512.082337][ T8305] *pde = 00000000
>> [  512.082829][ T8305] Oops: 0000 [#1] PREEMPT SMP
>> [  512.083407][ T8305] CPU: 1 PID: 8305 Comm: watchdog Tainted: G        W        N 6.7.0-rc1-00006-g2227a957e1d5 #1 819e6d1a8b887f5f97adb4aed77d98b15504c836
>> [  512.084986][ T8305] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
>> [ 512.086203][ T8305] EIP: set_next_entity (fair.c:?)
> 
> There was actually a NULL-test in pick_eevdf() before this commit,
> but I removed it by intent as I found it impossible to be NULL after
> examining 'all' the cases.
> 
> Also cc Tiwei who once proposed to add this check back.
> https://lore.kernel.org/all/20231208112100.18141-1-tiwei.btw@antgroup.com/

Thanks for cc'ing me. That's the case I worried about and why I thought
it might be worthwhile to add the sanity check back. I just sent out a
new version of the above patch with updated commit log and error message.

https://lore.kernel.org/lkml/20240131120340.76461-1-tiwei.btw@antgroup.com/

Regards,
Tiwei


> 
> Thanks,
>     Abel
> 
>> [ 512.086881][ T8305] Code: 89 d6 89 cf 85 d2 74 22 39 77 58 75 1d 89 f0 90 90 90 90 90 8b 48 70 39 41 58 75 0e c7 41 58 00 00 00 00 8b 40 6c 85 c0 75 ea <83> 7e 2c 00 74 28 3e 8d 74 26 00 89 f9 89 f2 e8 36 59 00 00 89 f9
>> All code
>> ========
>>     0:    89 d6                    mov    %edx,%esi
>>     2:    89 cf                    mov    %ecx,%edi
>>     4:    85 d2                    test   %edx,%edx
>>     6:    74 22                    je     0x2a
>>     8:    39 77 58                 cmp    %esi,0x58(%rdi)
>>     b:    75 1d                    jne    0x2a
>>     d:    89 f0                    mov    %esi,%eax
>>     f:    90                       nop
>>    10:    90                       nop
>>    11:    90                       nop
>>    12:    90                       nop
>>    13:    90                       nop
>>    14:    8b 48 70                 mov    0x70(%rax),%ecx
>>    17:    39 41 58                 cmp    %eax,0x58(%rcx)
>>    1a:    75 0e                    jne    0x2a
>>    1c:    c7 41 58 00 00 00 00     movl   $0x0,0x58(%rcx)
>>    23:    8b 40 6c                 mov    0x6c(%rax),%eax
>>    26:    85 c0                    test   %eax,%eax
>>    28:    75 ea                    jne    0x14
>>    2a:*    83 7e 2c 00              cmpl   $0x0,0x2c(%rsi)        <-- trapping instruction
>>    2e:    74 28                    je     0x58
>>    30:    3e 8d 74 26 00           lea    %ds:0x0(%rsi,%riz,1),%esi
>>    35:    89 f9                    mov    %edi,%ecx
>>    37:    89 f2                    mov    %esi,%edx
>>    39:    e8 36 59 00 00           callq  0x5974
>>    3e:    89 f9                    mov    %edi,%ecx
>>
>> Code starting with the faulting instruction
>> ===========================================
>>     0:    83 7e 2c 00              cmpl   $0x0,0x2c(%rsi)
>>     4:    74 28                    je     0x2e
>>     6:    3e 8d 74 26 00           lea    %ds:0x0(%rsi,%riz,1),%esi
>>     b:    89 f9                    mov    %edi,%ecx
>>     d:    89 f2                    mov    %esi,%edx
>>     f:    e8 36 59 00 00           callq  0x594a
>>    14:    89 f9                    mov    %edi,%ecx
>> [  512.089261][ T8305] EAX: 00000000 EBX: e75ff100 ECX: e75ff100 EDX: 00000000
>> [  512.090180][ T8305] ESI: 00000000 EDI: e75ff100 EBP: ed229dd0 ESP: ed229dc0
>> [  512.091097][ T8305] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00010046
>> [  512.092138][ T8305] CR0: 80050033 CR2: 0000002c CR3: 0a508000 CR4: 000406d0
>> [  512.093076][ T8305] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
>> [  512.094004][ T8305] DR6: fffe0ff0 DR7: 00000400
>> [  512.094643][ T8305] Call Trace:
>> [ 512.095145][ T8305] ? __die_body (dumpstack.c:?)
>> [ 512.095755][ T8305] ? __die (??:?)
>> [ 512.096309][ T8305] ? page_fault_oops (fault.c:?)
>> [ 512.096994][ T8305] ? __lock_acquire (lockdep.c:?)
>> [ 512.097677][ T8305] ? kmemleak_alloc (??:?)
>> [ 512.098343][ T8305] ? kernelmode_fixup_or_oops (fault.c:?)
>> [ 512.099085][ T8305] ? __bad_area_nosemaphore (fault.c:?)
>> [ 512.099839][ T8305] ? bad_area_nosemaphore (fault.c:?)
>> [ 512.100579][ T8305] ? do_user_addr_fault (fault.c:?)
>> [ 512.101325][ T8305] ? exc_page_fault (??:?)
>> [ 512.101992][ T8305] ? pvclock_clocksource_read_nowd (??:?)
>> [ 512.102799][ T8305] ? handle_exception (init_task.c:?)
>> [ 512.103492][ T8305] ? yield_to_task_fair (fair.c:?)
>> [ 512.104166][ T8305] ? pvclock_clocksource_read_nowd (??:?)
>> [ 512.104975][ T8305] ? set_next_entity (fair.c:?)
>> [ 512.105655][ T8305] ? pvclock_clocksource_read_nowd (??:?)
>> [ 512.106447][ T8305] ? set_next_entity (fair.c:?)
>> [ 512.107106][ T8305] pick_next_task_fair (??:?)
>> [ 512.107788][ T8305] ? put_prev_task_rt (build_policy.c:?)
>> [ 512.108460][ T8305] __pick_next_task_fair (fair.c:?)
>> [ 512.109162][ T8305] __schedule (core.c:?)
>> [ 512.109753][ T8305] schedule (??:?)
>> [ 512.110284][ T8305] do_nanosleep (hrtimer.c:?)
>> [ 512.110900][ T8305] hrtimer_nanosleep (??:?)
>> [ 512.111581][ T8305] ? __remove_hrtimer (hrtimer.c:?)
>> [ 512.112264][ T8305] common_nsleep (posix-timers.c:?)
>> [ 512.112891][ T8305] __ia32_sys_clock_nanosleep (??:?)
>> [ 512.113657][ T8305] ? syscall_enter_from_user_mode_work (??:?)
>> [ 512.114486][ T8305] __do_fast_syscall_32 (common.c:?)
>> [ 512.115180][ T8305] ? irqentry_exit_to_user_mode (??:?)
>> [ 512.115936][ T8305] ? irqentry_exit_to_user_mode (??:?)
>> [ 512.116690][ T8305] do_fast_syscall_32 (??:?)
>> [ 512.117386][ T8305] do_SYSENTER_32 (??:?)
>> [ 512.118022][ T8305] entry_SYSENTER_32 (??:?)
>> [  512.118645][ T8305] EIP: 0xb7edf539
>> [ 512.119172][ T8305] Code: 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 0f 1f 00 58 b8 77 00 00 00 cd 80 90 0f 1f
>> All code
>> ========
>>     0:    03 74 b4 01              add    0x1(%rsp,%rsi,4),%esi
>>     4:    10 07                    adc    %al,(%rdi)
>>     6:    03 74 b0 01              add    0x1(%rax,%rsi,4),%esi
>>     a:    10 08                    adc    %cl,(%rax)
>>     c:    03 74 d8 01              add    0x1(%rax,%rbx,8),%esi
>>     ...
>>    20:    00 51 52                 add    %dl,0x52(%rcx)
>>    23:    55                       push   %rbp
>>    24:*    89 e5                    mov    %esp,%ebp        <-- trapping instruction
>>    26:    0f 34                    sysenter
>>    28:    cd 80                    int    $0x80
>>    2a:    5d                       pop    %rbp
>>    2b:    5a                       pop    %rdx
>>    2c:    59                       pop    %rcx
>>    2d:    c3                       retq
>>    2e:    90                       nop
>>    2f:    90                       nop
>>    30:    90                       nop
>>    31:    90                       nop
>>    32:    0f 1f 00                 nopl   (%rax)
>>    35:    58                       pop    %rax
>>    36:    b8 77 00 00 00           mov    $0x77,%eax
>>    3b:    cd 80                    int    $0x80
>>    3d:    90                       nop
>>    3e:    0f                       .byte 0xf
>>    3f:    1f                       (bad)
>>
>> Code starting with the faulting instruction
>> ===========================================
>>     0:    5d                       pop    %rbp
>>     1:    5a                       pop    %rdx
>>     2:    59                       pop    %rcx
>>     3:    c3                       retq
>>     4:    90                       nop
>>     5:    90                       nop
>>     6:    90                       nop
>>     7:    90                       nop
>>     8:    0f 1f 00                 nopl   (%rax)
>>     b:    58                       pop    %rax
>>     c:    b8 77 00 00 00           mov    $0x77,%eax
>>    11:    cd 80                    int    $0x80
>>    13:    90                       nop
>>    14:    0f                       .byte 0xf
>>    15:    1f                       (bad)
>>
>>
>> The kernel config and materials to reproduce are available at:
>> https://download.01.org/0day-ci/archive/20240130/202401301012.2ed95df0-oliver.sang@intel.com
>>
>>
>>


