Return-Path: <linux-kernel+bounces-109860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0278B8856A9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 853C81F21AAC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6089655E73;
	Thu, 21 Mar 2024 09:44:20 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948FE53384;
	Thu, 21 Mar 2024 09:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711014259; cv=none; b=fERYQJks0jZCzMtOQrf359UofY84YgAIW5FFAkdCWb6Osg0MMHwR8wSTw7/IHhH3NMQiVCNekZSLNd1vRCjODYaYHQd7TkUjCIhX/bn1oUT6g+UaXqb+RvMbIIPgops8IBHtpgeDfwHrTKJYD1RlIse/2iRnV8j0Jg4hFJNlJTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711014259; c=relaxed/simple;
	bh=nC4zC/ekvm31nkrj1AOh27fmuR8c5ikECCO9VZEASp4=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Q+sIBKMBhheq52xcBM/pTNdV8qW0Cx8/vy3+Txk/ldBRgcysthnOON6UyBDoLpym6ofCO3CCPe8Y0wUggefk8BUaAIOaBUDlY+yij29lxJRyx1V/GahFxq/QJYV+Mi/8xyRDduP94AhSvu1F3Uapu+uqj2dX5nsIifDZ+Iuhvug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4V0gTH1hZzz1R7hs;
	Thu, 21 Mar 2024 17:41:39 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id CD0C81A0188;
	Thu, 21 Mar 2024 17:44:13 +0800 (CST)
Received: from [10.67.111.82] (10.67.111.82) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 21 Mar
 2024 17:44:13 +0800
Subject: Re: [PATCH v2] ARM: unwind: improve unwinders for noreturn case
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
References: <1709516385-7778-1-git-send-email-xiaojiangfeng@huawei.com>
 <1710906278-23851-1-git-send-email-xiaojiangfeng@huawei.com>
 <ZfqiD8Yw0oOVHW/p@shell.armlinux.org.uk>
 <84a57ca8-8963-ca24-8bd1-ddc5c33bf4da@huawei.com>
 <Zfs7sT6Pxy5yjnPC@shell.armlinux.org.uk>
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
Message-ID: <bad25937-fc98-8e11-4279-ab6b3a727c1f@huawei.com>
Date: Thu, 21 Mar 2024 17:44:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Zfs7sT6Pxy5yjnPC@shell.armlinux.org.uk>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500010.china.huawei.com (7.192.105.118)



On 2024/3/21 3:40, Russell King (Oracle) wrote:
> On Wed, Mar 20, 2024 at 11:30:05PM +0800, Jiangfeng Xiao wrote:
>>
>>
>> On 2024/3/20 16:45, Russell King (Oracle) wrote:
>>> On Wed, Mar 20, 2024 at 11:44:38AM +0800, Jiangfeng Xiao wrote:
>>>> This is an off-by-one bug which is common in unwinders,
>>>> due to the fact that the address on the stack points
>>>> to the return address rather than the call address.
>>>>
>>>> So, for example, when the last instruction of a function
>>>> is a function call (e.g., to a noreturn function), it can
>>>> cause the unwinder to incorrectly try to unwind from
>>>> the function after the callee.
>>>>
>>>> foo:
>>>> ...
>>>> 	bl	bar
>>>> ... end of function and thus next function ...
>>>>
>>>> which results in LR pointing into the next function.
>>>>
>>>> Fixed this by subtracting 1 from frmae->pc in the call frame
>>>> (but not exception frames) like ORC on x86 does.
>>>
>>> The reason that I'm not accepting this patch is because the above says
>>> that it fixes it by subtracting 1 from the PC value, but the patch is
>>> *way* more complicated than that and there's no explanation why.
>>>
>>> For example, the following are unexplained:
>>>
>>> - Why do we always need ex_frame
>>
>> ```
>> bar:
>> ...
>> ... end of function bar ...
>>
>> foo:
>>     BUG();
>> ... end of function foo ...
>> ```
>>
>> For example, when the first instruction of function 'foo'
>> is a undefined instruction, after function 'foo' is executed
>> to trigger an exception, 'arm_get_current_stackframe' assigns
>> 'regs->ARM_pc' to 'frame.pc'.
>>
>> If we always decrement frame.pc by 1, unwinder will incorrectly
>> try to unwind from the function 'bar' before the function 'foo'.
>>
>> So we need to 'ext_frame' to distinguish this case
>> where we don't need to subtract 1.
> 
> This just sounds wrong to me. We have two different cases:
> 
> 1) we're unwinding a frame where PC points at the offending instruction.
>    This may or may not be in the exception text.
> 2) we're unwinding a frame that has been created because of a branch,
>    where the PC points at the next instruction _after_ that callsite.
> 
> While we're unwinding, we will mostly hit the second type of frames, but
> we'll only hit the first type on the initial frame. Some exception
> entries will have the PC pointing at the next instruction to be
> executed, others will have it pointing at the offending instruction
> (e.g. if it needs to be retried.)


Thank you for your summary.

Now we try to enumerate all cases:

1) When we hit the first type of frames

1.1) If the pc pointing at the next instruction
     of the offending instruction

1.1.1) If the offending instruction is the first instruction
       of the function
       pc:   cause to unwind from current function
       pc-1: casue to unwind from current function

1.1.2) If the offending instruction is neither the first
       instruction nor the last instruction of the function
       pc:   cause to unwind from current function
       pc-1: casue to unwind from current function

1.1.3) If the offending instruction is the last instruction
       of the function
       pc:   cause to unwind from next    function
       pc-1: casue to unwind from current function

1.2) If the pc pointing at the offending instruction

1.2.1) If the offending instruction is the first instruction
       of the function
       pc:   cause to unwind from current  function
       pc-1: casue to unwind from previous function

1.2.2) If the offending instruction is neither the first
       instruction nor the last instruction of the function
       pc:   cause to unwind from current function
       pc-1: casue to unwind from current function

1.2.3) If the offending instruction is the last instruction
       of the function
       pc:   cause to unwind from current function
       pc-1: casue to unwind from current function

2) When we hit the second type of frames
2.1) pc always pointing at the next instruction after that callsite
2.1.1) If the callsite is the first instruction
       pc:   cause to unwind from current function
       pc-1: casue to unwind from current function

2.1.2) If the callsite is neither the first nor last instruction
       pc:   cause to unwind from current function
       pc-1: casue to unwind from current function

2.1.3) If the callsite is the last instruction
       pc:   cause to unwind from next    function
       pc-1: casue to unwind from current function


All in all, I think you are right.

In case 2), We can always unwind by 'pc-1'.

In case 1), If we unwind by 'pc', case 1.1.3) is problematic.
If we unwind by 'pc-1', 1.2.1) is problematic.


> 
> So, I don't see what being in the exception/entry text really has much
> to do with any decision making here. I think you've found that it works
> for your case, but it won't _always_ work and you're just shifting the
> "bug" with how these traces work from one issue to a different but
> similar issue.


