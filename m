Return-Path: <linux-kernel+bounces-109099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F45881499
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B321D1C2248F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA68B53E26;
	Wed, 20 Mar 2024 15:30:18 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDD447F77;
	Wed, 20 Mar 2024 15:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710948618; cv=none; b=NOmVf3RLpxVVtn7GbHJHWU9Yj8kwn8Ilcxy3a/+pyTGcl7ywqK9vDK3hdxDXjEFomBAgDFP56Y3z+NxC9JRbtD8CgsxtrASuoxJOus9ZNVKnIYHigsMmToMji4luS0LEOhIYjh9ISLp/8LpHw+ok2NEHw6z1ZGfNb8D67LANFwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710948618; c=relaxed/simple;
	bh=k+uiAnBPsc4XHfouOVtwfKC4aWoNEiidfKAZ/kUUCp8=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=FgkJAR0VfI7aTAINWZv3mmyQD8elWSi0Ly7/Xhb/xUgg5VpcO121YAS4tl39AKKPONVgJjUZRAaMAokyBab3jXf//XZoq1a8u4F8aqxYxFPaFtHeJKuO/Nwh1+swvJzdauWz4yB4ZeHReOJAWZCu1late+j5LCRAAt1e78HrSpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4V0CBx5BTFz1h3Bm;
	Wed, 20 Mar 2024 23:27:37 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id 22E0F1A0172;
	Wed, 20 Mar 2024 23:30:11 +0800 (CST)
Received: from [10.67.111.82] (10.67.111.82) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 20 Mar
 2024 23:30:10 +0800
Subject: Re: [PATCH v2] ARM: unwind: improve unwinders for noreturn case
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
References: <1709516385-7778-1-git-send-email-xiaojiangfeng@huawei.com>
 <1710906278-23851-1-git-send-email-xiaojiangfeng@huawei.com>
 <ZfqiD8Yw0oOVHW/p@shell.armlinux.org.uk>
CC: <arnd@arndb.de>, <keescook@chromium.org>, <haibo.li@mediatek.com>,
	<angelogioacchino.delregno@collabora.com>, <amergnat@baylibre.com>,
	<akpm@linux-foundation.org>, <dave.hansen@linux.intel.com>,
	<douzhaolei@huawei.com>, <gustavoars@kernel.org>, <jpoimboe@kernel.org>,
	<kepler.chenxin@huawei.com>, <kirill.shutemov@linux.intel.com>,
	<linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-arm-kernel@lists.infradead.org>,
	<nixiaoming@huawei.com>, <peterz@infradead.org>, <wangbing6@huawei.com>,
	<wangfangpeng1@huawei.com>, <jannh@google.com>, <willy@infradead.org>,
	<David.Laight@aculab.com>
From: Jiangfeng Xiao <xiaojiangfeng@huawei.com>
Message-ID: <84a57ca8-8963-ca24-8bd1-ddc5c33bf4da@huawei.com>
Date: Wed, 20 Mar 2024 23:30:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZfqiD8Yw0oOVHW/p@shell.armlinux.org.uk>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500010.china.huawei.com (7.192.105.118)



On 2024/3/20 16:45, Russell King (Oracle) wrote:
> On Wed, Mar 20, 2024 at 11:44:38AM +0800, Jiangfeng Xiao wrote:
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
> 
> The reason that I'm not accepting this patch is because the above says
> that it fixes it by subtracting 1 from the PC value, but the patch is
> *way* more complicated than that and there's no explanation why.
> 
> For example, the following are unexplained:
> 
> - Why do we always need ex_frame

```
bar:
..
.. end of function bar ...

foo:
    BUG();
.. end of function foo ...
```

For example, when the first instruction of function 'foo'
is a undefined instruction, after function 'foo' is executed
to trigger an exception, 'arm_get_current_stackframe' assigns
'regs->ARM_pc' to 'frame.pc'.

If we always decrement frame.pc by 1, unwinder will incorrectly
try to unwind from the function 'bar' before the function 'foo'.

So we need to 'ext_frame' to distinguish this case
where we don't need to subtract 1.


> - What is the purpose of the change in format string for the display of
>   backtraces
```
unwind_frame(&frame);
dump_backtrace_entry(...from) //from = frame.pc
	printk("...%pS\n", ...(void *)from);
```
%pB will do sprint_backtrace and print the symbol at (from - 1) address
%pS will do sprint_symbol_build_id and print the symbol at (from) address

In unwind_frame, although we use 'frame->pc - 1' to execute unwind_find_idx,
but frame->pc itself does not change, in the noreturn case, frame->pc still
pointing into the next function. So this is going to be replaced by %pB.

> 
>>
>> Refer to the unwind_next_frame function in the unwind_orc.c
>>
>> Suggested-by: Josh Poimboeuf <jpoimboe@kernel.org>
>> Link: https://lkml.kernel.org/lkml/20240305175846.qnyiru7uaa7itqba@treble/
>> Signed-off-by: Jiangfeng Xiao <xiaojiangfeng@huawei.com>
>> ---
>> ChangeLog v1->v2
>> - stay printk("%s...", loglvl, ...)


Thank you for your suggestion.
I'll change the code to be more concise in my [patch v3].


>> -- 
>> 1.8.5.6
>>
>>
> 

