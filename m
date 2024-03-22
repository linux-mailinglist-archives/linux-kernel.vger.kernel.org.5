Return-Path: <linux-kernel+bounces-111441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B75B4886C67
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4790FB212C2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 12:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191B245022;
	Fri, 22 Mar 2024 12:54:28 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0EF44C84;
	Fri, 22 Mar 2024 12:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711112067; cv=none; b=dIpliw/5mBHmRmToFPP/sy4GctEuMAN9LBVXP2Y1ohs/20r4PxsHUjPYAeg6QNLiBWEN7535gBo4U4OG0dUCzhCP+RfFLpe+A+TKPpClWWAPKjkJ/P5JV/KRCwOsWa4ryAdLn3G42AjVlB3rC9cF+wxz6hi7A0ZIpPTx0UDW/H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711112067; c=relaxed/simple;
	bh=w4OncPFEVgHt/sZMulU9LuHwZDWetxuOFd+FfSV5f1Q=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=o/Rh/tb/stQ07Fqwv5oGpZvmVlGQ0wJlxK8kiubsE0R5cATe21XVRjhUJ+xryf+NK644vdeLFm98WzUto5IMpEEh6QuWlGzP4K5D7YMMSjByd04TkusM0kgzts1FXjJ+ej9R0v2F33pjjWvgzhxJJN9GN8TWzXKAcjbxpVZmeB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4V1Mf408bbz1R7yR;
	Fri, 22 Mar 2024 20:51:40 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id 93F6118005F;
	Fri, 22 Mar 2024 20:54:15 +0800 (CST)
Received: from [10.67.111.82] (10.67.111.82) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 22 Mar
 2024 20:54:15 +0800
Subject: Re: [PATCH v2] ARM: unwind: improve unwinders for noreturn case
To: "Russell King (Oracle)" <linux@armlinux.org.uk>, David Laight
	<David.Laight@aculab.com>
References: <1710906278-23851-1-git-send-email-xiaojiangfeng@huawei.com>
 <ZfqiD8Yw0oOVHW/p@shell.armlinux.org.uk>
 <84a57ca8-8963-ca24-8bd1-ddc5c33bf4da@huawei.com>
 <Zfs7sT6Pxy5yjnPC@shell.armlinux.org.uk>
 <bad25937-fc98-8e11-4279-ab6b3a727c1f@huawei.com>
 <bbcca1e205384cf0b42236e17f3969f7@AcuMS.aculab.com>
 <ZfwYx/8k8FVONg6+@shell.armlinux.org.uk>
 <CAMj1kXG2EGvgGuV-K7h5qDVJeLMd5hkq8GzigzCRzh9Z8cgyWw@mail.gmail.com>
 <ZfzMFv3zmYY36l9u@shell.armlinux.org.uk>
 <2b2993fb215c4a5abd7d77ff1c984113@AcuMS.aculab.com>
 <Zf1UyxlDf/oCjXxr@shell.armlinux.org.uk>
CC: Ard Biesheuvel <ardb@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
	"keescook@chromium.org" <keescook@chromium.org>, "haibo.li@mediatek.com"
	<haibo.li@mediatek.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "amergnat@baylibre.com"
	<amergnat@baylibre.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "douzhaolei@huawei.com"
	<douzhaolei@huawei.com>, "gustavoars@kernel.org" <gustavoars@kernel.org>,
	"jpoimboe@kernel.org" <jpoimboe@kernel.org>, "kepler.chenxin@huawei.com"
	<kepler.chenxin@huawei.com>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "nixiaoming@huawei.com"
	<nixiaoming@huawei.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"wangbing6@huawei.com" <wangbing6@huawei.com>, "wangfangpeng1@huawei.com"
	<wangfangpeng1@huawei.com>, "jannh@google.com" <jannh@google.com>,
	"willy@infradead.org" <willy@infradead.org>
From: Jiangfeng Xiao <xiaojiangfeng@huawei.com>
Message-ID: <18f5c5fd-4a5d-0c33-9d73-7e94c1e42f3f@huawei.com>
Date: Fri, 22 Mar 2024 20:54:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Zf1UyxlDf/oCjXxr@shell.armlinux.org.uk>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500010.china.huawei.com (7.192.105.118)



On 2024/3/22 17:52, Russell King (Oracle) wrote:
> On Fri, Mar 22, 2024 at 09:24:20AM +0000, David Laight wrote:
>> From: Russell King
>>> Sent: 22 March 2024 00:09
>>>
>>> On Thu, Mar 21, 2024 at 11:43:41PM +0100, Ard Biesheuvel wrote:
>>>> Given that this particular issue would just disappear if the compiler
>>>> would just insert a BRK after the BL, I'd prefer to explore first
>>>> whether we can get this fixed on the compiler side.
>>>
>>> Arm32 doesn't have a BRK instruction. What would be appropriate after
>>> the no-return BL would be OS specific.
>>
>> It would need to depend on what was being compiled.
> 
> Yes, but as for the rest...
> 
>> For the kernel it could be much the same as BUG().
>> (Probably without any extra data.)
>> I suspect that arm32 could use 'swi' in kernel space,
>> but you wouldn't want to use that in userspace.
>>
>> Looks like armv5 has a bkpt instruction - could that be used?
>> Or does the kernel need to support armv4?
>>
>> The last arm I wrote anything for was a strongarm.
> 
> Thank you David, but remember - I have programmed 32-bit Arm since 1992,
> and wrote the majority of the 32-bit Arm kernel support. I think I know
> what I'm walking about by now.
> 
> The compiler can't do the same as BUG() - that is a kernel specific
> construct and not an architecture one. It is an undefined instruction
> specifically chosen to be undefined on both 32-bit and 16-bit Arm ISAs.
> 
> As for your idea of using "swi" in kernel space, no that's never going
> to happen - to shoe-horn that into the SWI exception path for the sake
> of the compiler would be totally idiotic - it would cause userspace
> performance regressions for something that never happens. Moreover,
> with EABI the "comment" field in the "swi" instruction is ignored so
> all SWIs under EABI are treated the same. So no, that's not going to
> work without causing inefficiencies - again - for a case that will
> likely never happen.
> 
> Whereas we already provide an abort() function because iirc the
> compiler used to emit branches to that due to noreturn functions. If
> correct, there's previous convention for doing this - and abort() is
> still exists in the kernel and in userspace since it's part of ANSI
> C. This would be a more reliable and portable solution, but probably
> not for embedded platforms - and that's probably why it got removed.
> 
> There isn't going to be a single solution to this which satisfies
> everyone, and I don't blame the compiler people for deciding to
> basically give up with putting any instruction after a call to a
> no-return function - because there isn't an instruction defined in
> the architecture that _could_ be put there that would work everywhere.
> 


If the compiler inserts (a branch to 'abort') behind (no-return BL)
that does not apply to ARM32 embedded platforms, do you think the
 "[PATCH v3] ARM: unwind: improve unwinders for noreturn case"
submitted the day before yesterday can be used as a
complementary solution?

2) we're unwinding a frame that has been created because of a branch,
   where the PC points at the next instruction _after_ that callsite.

When we hit the second type of frame, "pc-1" is closer to callsite,
and no problem is introduced. In addition, the issue of the 'noreturn'
can be solved.

