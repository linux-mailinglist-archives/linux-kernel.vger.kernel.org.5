Return-Path: <linux-kernel+bounces-80423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6611866854
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7BA11C214EA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 02:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DBF14008;
	Mon, 26 Feb 2024 02:49:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9457212E55
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 02:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708915788; cv=none; b=Y+Z7jzfb8mB46s4W4+KWoI89uInZnCJXMeL0+JrH5GxBOVSjZhmvnjK8CT2v737q9lo/wi+cgpWFG1EEKwj7AFehSJacE7gzdUXAFdynUJkHkKMjJT0GQeAK0g4G1VvdfPfXgQKUTe+lD5U+iE8tcAbidxMnYhAJS4Cna68aGzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708915788; c=relaxed/simple;
	bh=gTKXxYMLTzZTps02t2q9eElIfc+g8SPI/ED2qi5DiLA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PnFpYkdGXCV+CGRNdmz5rTCigUXyAAujrhgML80+PGToGxoo4qjD7Pn/w77/+uLV25uiUagwlfaxRVfppLXyD7COipY2GRrLQHWQCOcqh33rv+V4y0RiaxGTeSWNUwtoujRy+6ZfoYh5vL/6ai+ycvP/J8HlaIYfL7xqVkpvVDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 638D61042;
	Sun, 25 Feb 2024 18:50:23 -0800 (PST)
Received: from [10.162.40.19] (a077893.blr.arm.com [10.162.40.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 945723F6C4;
	Sun, 25 Feb 2024 18:49:42 -0800 (PST)
Message-ID: <1901fadb-1d71-4374-be8c-00935bb27854@arm.com>
Date: Mon, 26 Feb 2024 08:19:39 +0530
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
To: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, broonie@kernel.org,
 Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org
References: <20240223113102.4027779-1-anshuman.khandual@arm.com>
 <20240223125224.GC10641@willie-the-truck>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240223125224.GC10641@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/23/24 18:22, Will Deacon wrote:
> On Fri, Feb 23, 2024 at 05:01:02PM +0530, Anshuman Khandual wrote:
>> Both platform i.e ARM_BREAKPOINT_LEN_X and generic i.e HW_BREAKPOINT_LEN_X
>> macros are used interchangeably to convert event->attr.bp_len and platform
>> breakpoint control arch_hw_breakpoint_ctrl->len. Let's be consistent while
>> deriving one from the other. This does not cause any functional changes.
>>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>> This applies on v6.8-rc5
>>
>>  arch/arm64/kernel/hw_breakpoint.c | 16 ++++++++--------
>>  1 file changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
>> index 35225632d70a..1ab9fc865ddd 100644
>> --- a/arch/arm64/kernel/hw_breakpoint.c
>> +++ b/arch/arm64/kernel/hw_breakpoint.c
>> @@ -301,28 +301,28 @@ static int get_hbp_len(u8 hbp_len)
>>  
>>  	switch (hbp_len) {
>>  	case ARM_BREAKPOINT_LEN_1:
>> -		len_in_bytes = 1;
>> +		len_in_bytes = HW_BREAKPOINT_LEN_1;
> 
> I don't think we should do this. The HW_BREAKPOINT_LEN_* definitions are
> part of the user ABI and, although they correspond to the length in bytes,
> that's not necessarily something we should rely on.

Why should not we rely on the user ABI macros if these byte lengths were
initially derived from them. But also there are similar conversions in
arch_bp_generic_fields(). These hard coded raw byte length numbers seems
cryptic, where as in reality these are just inter converted from generic
HW breakpoints lengths.

