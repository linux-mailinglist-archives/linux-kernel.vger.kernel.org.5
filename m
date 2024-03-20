Return-Path: <linux-kernel+bounces-108409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C224880A23
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 04:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF93AB21897
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 03:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD7511717;
	Wed, 20 Mar 2024 03:30:31 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA62212E40;
	Wed, 20 Mar 2024 03:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710905430; cv=none; b=Mxu6yYSyUiES8UvBKp9sFnB14mNjLD0UWvsO1UULHGOv0nA65kxmX4c5CjB3HwQqqvO3mxqDvHx+3coZvlHKdWNdjl0H9ntUNMTEw/QgDp3/6IqY0RRSCuD7zzdGxpvjmgfmNwsXjl5WMOeFzqrCRxE51PRjSjrJwaIebW1dVZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710905430; c=relaxed/simple;
	bh=wNIYr0YRIvV7+ACKzGHG2nKgc76mfD09xmnyWCrTk0w=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=hWovm4NmRTSu+YYvyVcmp4yNRWjgOljKfuEtlNDxoBW6xbIekXPdCmdpETtKUkfmHTgBhWDE2S2f9XD/SDPR/nwkVV7BlcVZTfbpxq9BuRs2YyEI1qgA9MyuPPnwBRsTri6QwND7r9pjGSMpYBBKfVNHWlzPV73ulANM3qk9GZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4TzvF56Y93zNmFg;
	Wed, 20 Mar 2024 11:28:25 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id DE0BF140487;
	Wed, 20 Mar 2024 11:30:18 +0800 (CST)
Received: from [10.67.111.82] (10.67.111.82) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 20 Mar
 2024 11:30:18 +0800
Subject: Re: [PATCH] ARM: unwind: improve unwinders for noreturn case
To: Kees Cook <keescook@chromium.org>
References: <1709516385-7778-1-git-send-email-xiaojiangfeng@huawei.com>
 <1710901169-22763-1-git-send-email-xiaojiangfeng@huawei.com>
 <202403191945.661DBCE8@keescook>
CC: <linux@armlinux.org.uk>, <arnd@arndb.de>, <rmk+kernel@armlinux.org.uk>,
	<haibo.li@mediatek.com>, <angelogioacchino.delregno@collabora.com>,
	<amergnat@baylibre.com>, <akpm@linux-foundation.org>,
	<dave.hansen@linux.intel.com>, <douzhaolei@huawei.com>,
	<gustavoars@kernel.org>, <jpoimboe@kernel.org>, <kepler.chenxin@huawei.com>,
	<kirill.shutemov@linux.intel.com>, <linux-hardening@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-arm-kernel@lists.infradead.org>, <nixiaoming@huawei.com>,
	<peterz@infradead.org>, <wangbing6@huawei.com>, <wangfangpeng1@huawei.com>,
	<jannh@google.com>, <David.Laight@aculab.com>
From: Jiangfeng Xiao <xiaojiangfeng@huawei.com>
Message-ID: <fb8c6e8f-de47-8cbc-e30a-60961f5ce7ad@huawei.com>
Date: Wed, 20 Mar 2024 11:30:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <202403191945.661DBCE8@keescook>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500010.china.huawei.com (7.192.105.118)



On 2024/3/20 10:46, Kees Cook wrote:
> On Wed, Mar 20, 2024 at 10:19:29AM +0800, Jiangfeng Xiao wrote:
>> This is an off-by-one bug which is common in unwinders,
>> due to the fact that the address on the stack points
>> to the return address rather than the call address.
>>
>> So, for example, when the last instruction of a function
>> is a function call (e.g., to a noreturn function), it can
>> cause the unwinder to incorrectly try to unwind from
>> the function after the callee.
>>
>> foo:
>> ...
>> 	bl	bar
>> ... end of function and thus next function ...
>>
>> which results in LR pointing into the next function.
>>
>> Fixed this by subtracting 1 from frmae->pc in the call frame
>> (but not exception frames) like ORC on x86 does.
>>
>> Refer to the unwind_next_frame function in the unwind_orc.c
>>
>> Suggested-by: Josh Poimboeuf <jpoimboe@kernel.org>
>> Link: https://lkml.kernel.org/lkml/20240305175846.qnyiru7uaa7itqba@treble/
>> Signed-off-by: Jiangfeng Xiao <xiaojiangfeng@huawei.com>
>> ---
>>  arch/arm/include/asm/stacktrace.h |  4 ----
>>  arch/arm/kernel/stacktrace.c      |  2 --
>>  arch/arm/kernel/traps.c           |  4 ++--
>>  arch/arm/kernel/unwind.c          | 18 +++++++++++++++---
>>  4 files changed, 17 insertions(+), 11 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/stacktrace.h b/arch/arm/include/asm/stacktrace.h
>> index 360f0d2..07e4c16 100644
>> --- a/arch/arm/include/asm/stacktrace.h
>> +++ b/arch/arm/include/asm/stacktrace.h
>> @@ -21,9 +21,7 @@ struct stackframe {
>>  	struct llist_node *kr_cur;
>>  	struct task_struct *tsk;
>>  #endif
>> -#ifdef CONFIG_UNWINDER_FRAME_POINTER
>>  	bool ex_frame;
>> -#endif
>>  };
>>  
>>  static __always_inline
>> @@ -37,9 +35,7 @@ void arm_get_current_stackframe(struct pt_regs *regs, struct stackframe *frame)
>>  		frame->kr_cur = NULL;
>>  		frame->tsk = current;
>>  #endif
>> -#ifdef CONFIG_UNWINDER_FRAME_POINTER
>>  		frame->ex_frame = in_entry_text(frame->pc);
>> -#endif
>>  }
>>  
>>  extern int unwind_frame(struct stackframe *frame);
>> diff --git a/arch/arm/kernel/stacktrace.c b/arch/arm/kernel/stacktrace.c
>> index 620aa82..1abd4f9 100644
>> --- a/arch/arm/kernel/stacktrace.c
>> +++ b/arch/arm/kernel/stacktrace.c
>> @@ -154,9 +154,7 @@ static void start_stack_trace(struct stackframe *frame, struct task_struct *task
>>  	frame->kr_cur = NULL;
>>  	frame->tsk = task;
>>  #endif
>> -#ifdef CONFIG_UNWINDER_FRAME_POINTER
>>  	frame->ex_frame = in_entry_text(frame->pc);
>> -#endif
>>  }
>>  
>>  void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
>> diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
>> index 3bad79d..b64e442 100644
>> --- a/arch/arm/kernel/traps.c
>> +++ b/arch/arm/kernel/traps.c
>> @@ -84,10 +84,10 @@ void dump_backtrace_entry(unsigned long where, unsigned long from,
>>  	printk("%sFunction entered at [<%08lx>] from [<%08lx>]\n",
>>  		loglvl, where, from);
>>  #elif defined CONFIG_BACKTRACE_VERBOSE
>> -	printk("%s[<%08lx>] (%ps) from [<%08lx>] (%pS)\n",
>> +	pr_warn("%s[<%08lx>] (%ps) from [<%08lx>] (%pB)\n",
>>  		loglvl, where, (void *)where, from, (void *)from);
> 
> This should stay printk("%s...", loglvl, ...) or loglvl should be
> dropped when converting to pr_warn():
> 
> 	pr_warn([<%08lx>] (%ps) from [<%08lx>] (%pB)\n",
> 		where, (void *)where, from, (void *)from);
> 
> Why did you want to force the "warn" log level?
> 

Thank you for your review. I think I'm wrong.

The checkpatch.pl script reports the "WARNING: printk() should
include KERN_<LEVEL> facility level" warning.

That's why I changed printk to pr_warn.
I should change printk to printk(KERN_DEFAULT).

>>  #else
>> -	printk("%s %ps from %pS\n", loglvl, (void *)where, (void *)from);
>> +	pr_warn("%s %ps from %pB\n", loglvl, (void *)where, (void *)from);
> 
> Ditto.
> 
> -Kees
> 

