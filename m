Return-Path: <linux-kernel+bounces-112109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B02C98875D9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 00:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 667B01F240E3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 23:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6A482C7D;
	Fri, 22 Mar 2024 23:41:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED2782C67;
	Fri, 22 Mar 2024 23:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711150860; cv=none; b=dcJGmi1KgqoBx4QRskqK4lllgSfd1/Pqrp6yqV8jbFejS73PLN7aM+xayUcdWVBWBEcCM/xV2iEtqHN1dWURZsi6+vKl3Os2Ntz9L/olr6w6JrU6BqLEmxPvfCkwu6PEj3HTAkjts2my7uqUS4+SEw/+JwbZqhgz8B1p+6udEYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711150860; c=relaxed/simple;
	bh=zuvDOu0/rlT7v5UCGQJmr8VHmsa8qBfwFGOMkQvldK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E5ka5Jz0iMw55ZTDdlCaqqx561BVZE2BSn1i0dXMGuQgiC3ix4pJgj5ET1UghlqM9tM6uTUD6nfl2jgw0W9iHtnIF+02psFtusY4b0FvqtawxuxlVdJd1SyUSFnOjeVxC1pohf03lAi7N2zXSVUmN3LUydbEPKcdMNmYPJLGtqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56537DA7;
	Fri, 22 Mar 2024 16:41:30 -0700 (PDT)
Received: from [172.27.42.98] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 202903F762;
	Fri, 22 Mar 2024 16:40:55 -0700 (PDT)
Message-ID: <2ebe2ea5-b107-4020-8e60-ff8cf43a3aab@arm.com>
Date: Fri, 22 Mar 2024 18:40:54 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] arm64: syscall: Direct PRNG kstack randomization
Content-Language: en-US
To: Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>
Cc: linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mark Brown <broonie@kernel.org>, Guo Hui <guohui@uniontech.com>,
 Manoj.Iyer@arm.com, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, James Yang <james.yang@arm.com>,
 Shiyou Huang <shiyou.huang@arm.com>
References: <20240305221824.3300322-1-jeremy.linton@arm.com>
 <20240305221824.3300322-2-jeremy.linton@arm.com>
 <202403051526.0BE26F99E@keescook>
 <34351804-ad1d-498f-932a-c1844b78589f@app.fastmail.com>
 <38f9541b-dd88-4d49-af3b-bc7880a4e2f4@arm.com>
 <f1dd15ce-69af-4315-8d7c-b7a480e541aa@app.fastmail.com>
 <db7dfa2d-c7c6-4b10-981a-a7ecc87c8541@arm.com>
 <acfc522a-5162-4b33-9d6c-1e25d0c44a71@app.fastmail.com>
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <acfc522a-5162-4b33-9d6c-1e25d0c44a71@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Sorry about the delay here, PTO and I actually wanted to verify my 
assumptions.

On 3/8/24 14:29, Arnd Bergmann wrote:
> On Fri, Mar 8, 2024, at 17:49, Jeremy Linton wrote:
>> On 3/7/24 05:10, Arnd Bergmann wrote:
>>>
>>> I'm not sure I understand the logic. Do you mean that accessing
>>> CNTVCT itself is slow, or that reseeding based on CNTVCT is slow
>>> because of the overhead of reseeding?
>>
>> Slow, as in, its running at a much lower frequency than a cycle counter.
> 
> Ok, I see. Would it be possible to use PMEVCNTR0 instead?

So, I presume you actually mean PMCCNTR_EL0 because I don't see the 
point of a dedicated event, although maybe...

So, the first and maybe largest problem is the PMxxx registers are all 
optional because the PMU is optional! Although, they are strongly 
recommended and most (AFAIK) machines do implement them. So, maybe if 
its just using a cycle counter to dump some entropy into rnd_state it 
becomes a statement that kstack randomization is slower or unsupported 
if there isn't a PMU?

But then we have to basically enable the PMU cycle counter globally, 
which requires reworking how it works, because the cycle counter is 
enabled/disabled and reset on the fly depending on whether the user is 
trying to profile something. So, I have hacked that up, and it appears 
to be working, although i'm not sure what kind of interaction will 
happen with KVM yet.

But I guess the larger question is whether its worth changing the PMU 
behavior for this?


Thanks,



