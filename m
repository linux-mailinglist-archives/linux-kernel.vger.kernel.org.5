Return-Path: <linux-kernel+bounces-82721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD468688A4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 06:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C371C1C215A0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 05:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A62352F91;
	Tue, 27 Feb 2024 05:32:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF221AACE
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 05:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709011922; cv=none; b=EB9PbfyWibspAOOUOjnlygZgTfSAa2mO8m0dy93NLK+yMIlV2LsJQQnYva5SlROg5IboOZSCMjwa8NZLZD/Hhqm/0Ha1G+Yxs0Mh7Ms4i3N54ABRZK8EZAWOdRgLGWwNZPtd29qy3/Zk5WQgi9zQOTh77BQlbYKYzAYcvWLph1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709011922; c=relaxed/simple;
	bh=MULxpeaD/ViV6fujeZYHcokbWGSluuQ/LDYbbkn2tfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QZKETCqB8Aud91QPdhfvldZHkqWUxW5Y6BWZM1QYpUbsULEpF//cRANVAHXO/a7uBOp/JnsBYEp89sDnJSXyOnw/jQ5ono+D/OAznPb92ZepWcxCM3Icop1WoOSGnrRN19MS22L2/Z71EbHAoNen24wCHI5uNjAHe/7ERlm0oDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8DD2DA7;
	Mon, 26 Feb 2024 21:32:36 -0800 (PST)
Received: from [10.163.48.107] (unknown [10.163.48.107])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D06B3F6C4;
	Mon, 26 Feb 2024 21:31:56 -0800 (PST)
Message-ID: <c37bd84e-d4f7-42df-a333-f2ad6ebc9527@arm.com>
Date: Tue, 27 Feb 2024 11:01:54 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/hw_breakpoint: Determine lengths from generic perf
 breakpoint macros
Content-Language: en-US
To: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
 broonie@kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 linux-kernel@vger.kernel.org
References: <20240223113102.4027779-1-anshuman.khandual@arm.com>
 <20240223125224.GC10641@willie-the-truck>
 <1901fadb-1d71-4374-be8c-00935bb27854@arm.com>
 <ZdxwTkUALQfqjagf@FVFF77S0Q05N>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <ZdxwTkUALQfqjagf@FVFF77S0Q05N>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/26/24 16:34, Mark Rutland wrote:
> On Mon, Feb 26, 2024 at 08:19:39AM +0530, Anshuman Khandual wrote:
>> On 2/23/24 18:22, Will Deacon wrote:
>>> On Fri, Feb 23, 2024 at 05:01:02PM +0530, Anshuman Khandual wrote:
>>>> Both platform i.e ARM_BREAKPOINT_LEN_X and generic i.e HW_BREAKPOINT_LEN_X
>>>> macros are used interchangeably to convert event->attr.bp_len and platform
>>>> breakpoint control arch_hw_breakpoint_ctrl->len. Let's be consistent while
>>>> deriving one from the other. This does not cause any functional changes.
>>>>
>>>> Cc: Will Deacon <will@kernel.org>
>>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>>> Cc: linux-arm-kernel@lists.infradead.org
>>>> Cc: linux-kernel@vger.kernel.org
>>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>>> ---
>>>> This applies on v6.8-rc5
>>>>
>>>>  arch/arm64/kernel/hw_breakpoint.c | 16 ++++++++--------
>>>>  1 file changed, 8 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
>>>> index 35225632d70a..1ab9fc865ddd 100644
>>>> --- a/arch/arm64/kernel/hw_breakpoint.c
>>>> +++ b/arch/arm64/kernel/hw_breakpoint.c
>>>> @@ -301,28 +301,28 @@ static int get_hbp_len(u8 hbp_len)
>>>>  
>>>>  	switch (hbp_len) {
>>>>  	case ARM_BREAKPOINT_LEN_1:
>>>> -		len_in_bytes = 1;
>>>> +		len_in_bytes = HW_BREAKPOINT_LEN_1;
>>>
>>> I don't think we should do this. The HW_BREAKPOINT_LEN_* definitions are
>>> part of the user ABI and, although they correspond to the length in bytes,
>>> that's not necessarily something we should rely on.
>>
>> Why should not we rely on the user ABI macros if these byte lengths were
>> initially derived from them. 
> 
> Why should we change the clear:
> 	
> 	len_in_bytes = 1;
> 
> ... to the longer, and less clear:
> 
> 	len_in_bytes = HW_BREAKPOINT_LEN_1;
> 
> ... ?
> 
>> But also there are similar conversions in arch_bp_generic_fields().
> 
> Those are specifically for converting from the rch_hw_breakpoint_ctrl encodings
> to the perf_event_attr encodings. There we don't care about the specific value
> of the byte, just that we're using the correct encoding.
> 
>> These hard coded raw byte length numbers seems cryptic, where as in reality
>> these are just inter converted from generic HW breakpoints lengths.
> 
> There are three distinct concepts here:
> 
> 1. The length in bytes, as returned above by get_hbp_len()
> 
> 2. The length as encoded in the ARM_BREAKPOINT_LEN_* encoding
> 
> 3. The length as encoded in the HW_BREAKPOINT_LEN_* encoding.
> 
> I think you're arguing that since 1 and 3 happen to have the values we should
> treat them as the same thing. I think that Will and I believe that they should
> be kept distinct because they are distinct concepts.
> 
> I don't think this needs to change, and can be left as-is.

Fair enough, but just wondering how about deriving len_in_bytes from
hweight_long(ARM_BREAKPOINT_LEN_*) instead ? This also drops the hard
coding using the platform macros itself, without going to user ABI.

