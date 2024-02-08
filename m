Return-Path: <linux-kernel+bounces-57508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DFA84D9FB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05B452835E4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 06:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B0F67E67;
	Thu,  8 Feb 2024 06:21:17 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434B167C77;
	Thu,  8 Feb 2024 06:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707373276; cv=none; b=dfDkCZ1cc3/wbNNqBj398MMaIXivgFQtg0UdThoo/HDCxFlQt9uO8xRWH4m2ORJZd/GvHE6Z8ATVHDWkyvYdnT6K87y/aYkMsbAW5j8NW1WJh6hIMI10tlowlLQQUVKHSgZ+WmFkdzH0BBrgiioSpqTkjY+9KcwsmiLLjl+X1fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707373276; c=relaxed/simple;
	bh=jr/FNE0BK/q46g+V1wHFk44ROrOmP3I9E2CvnONQhH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aj8KVgyaJN2X24dxwdTj5RDSdqKFi+2R0AJXhPOaWmMXSoTBCRLAfS1lKLKt+QDtClrZceC0+hSTMxTQPLDo6BR3l779D56Bdy4XLQ6pYVfTQUwy/Yh7HGmv63sjRm4Fj3SUXMiFX0Bv+ORKYKYpZizzJ0ybEFP8vfOIr5mTt2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TVmz21yp8z29lKN;
	Thu,  8 Feb 2024 14:19:10 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (unknown [7.193.23.234])
	by mail.maildlp.com (Postfix) with ESMTPS id 901C3180060;
	Thu,  8 Feb 2024 14:21:07 +0800 (CST)
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 14:21:06 +0800
Message-ID: <34957b85-717a-055b-6b9b-5af16e57c31f@huawei.com>
Date: Thu, 8 Feb 2024 14:21:05 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH -next v5 2/3] x86/mce: set MCE_IN_KERNEL_COPYIN for
 DEFAULT_MCE_SAFE exception
To: Borislav Petkov <bp@alien8.de>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	<wangkefeng.wang@huawei.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Tony Luck
	<tony.luck@intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Naoya
 Horiguchi <naoya.horiguchi@nec.com>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, <linux-mm@kvack.org>, Guohanjun
	<guohanjun@huawei.com>
References: <20240204082627.3892816-1-tongtiangen@huawei.com>
 <20240204082627.3892816-3-tongtiangen@huawei.com>
 <20240207122942.GRZcN3tqWkV-WE-pak@fat_crate.local>
From: Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <20240207122942.GRZcN3tqWkV-WE-pak@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600017.china.huawei.com (7.193.23.234)



在 2024/2/7 20:29, Borislav Petkov 写道:
> On Sun, Feb 04, 2024 at 04:26:26PM +0800, Tong Tiangen wrote:
>> diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
>> index bca780fa5e57..b2cce1b6c96d 100644
>> --- a/arch/x86/kernel/cpu/mce/severity.c
>> +++ b/arch/x86/kernel/cpu/mce/severity.c
>> @@ -292,11 +292,11 @@ static noinstr int error_context(struct mce *m, struct pt_regs *regs)
>>   	case EX_TYPE_UACCESS:
>>   		if (!copy_user)
>>   			return IN_KERNEL;
>> +		fallthrough;
>> +	case EX_TYPE_DEFAULT_MCE_SAFE:
>>   		m->kflags |= MCE_IN_KERNEL_COPYIN;
>>   		fallthrough;
> 
> I knew something was still bugging me here and this is still wrong.
> 
> Let's imagine this flow:
> 
> copy_mc_to_user() - note *src is kernel memory
> |-> copy_mc_enhanced_fast_string or copy_mc_fragile - it's the same thing
>    |-> -#MC, exception type EX_TYPE_DEFAULT_MCE_SAFE
>      |-> error_context():
>         case EX_TYPE_DEFAULT_MCE_SAFE:
>                  m->kflags |= MCE_IN_KERNEL_COPYIN;
> 
> MCE_IN_KERNEL_COPYIN does kill_me_never():
> 
> 	pr_err("Kernel accessed poison in user space at %llx\n", p->mce_addr);
> 
> but that's reading from kernel memory!
> 
> IOW, I *think* that switch statement should be this:
> 
> 	switch (fixup_type) {
> 	case EX_TYPE_UACCESS:
> 	case EX_TYPE_DEFAULT_MCE_SAFE:
> 		if (!copy_user)
> 			return IN_KERNEL;
> 
> 		m->kflags |= MCE_IN_KERNEL_COPYIN;
> 		fallthrough;
> 
> 	case EX_TYPE_FAULT_MCE_SAFE:
> 		m->kflags |= MCE_IN_KERNEL_RECOV;
> 		return IN_KERNEL_RECOV;
> 
> 	default:
> 		return IN_KERNEL;
> 	}
> 
> Provided I'm not missing a case and provided is_copy_from_user() really
> detects all cases properly.
> 
> And then patch 3 is wrong because we only can handle "copy in" - not
> just any copy.

That makes sense. I'll check that point out later.

Many thanks.
Tong.
> 
> Thx.
> 

