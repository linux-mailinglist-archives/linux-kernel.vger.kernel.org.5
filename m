Return-Path: <linux-kernel+bounces-86119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 665A186BFEC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 05:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBBAE1F25193
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 04:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B251D38DE7;
	Thu, 29 Feb 2024 04:40:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D571812
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 04:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709181618; cv=none; b=gHo8OUNxmts28vbe/+XGb1lfnyeuES+DX5FSQ5fdbOVfkEyOZNAsOaYQxd3XqloNFj1LeNwDLpUbLNeuZSxV+gnElDgzOYIcAXfZBYz42JzCVCKnahwSa5ZGEROOgCFwVHVJhuvXOqzY/5dgyZ6Si9GstDr4GQ5CDfw4Kyjl/iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709181618; c=relaxed/simple;
	bh=146u6e05JLM9DMBEkdSeB9sjd4Z8y+TPkEBaMUYGnG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K6w1h0osMvaS07sPqgx3fzG7cUOcCC/NaywLwE1aTbMLlu7HtHJg4mNrIIYYeLXxZDDy3qz7bnZlUie/1t+h6nsNLxl0DerMJvmq5czoHrV0o0ilvUJy5tCVLhNbQh9HrhzEoeTl5irwp/NBs94sktI8ja0M1xWsASIamT8DNME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3695B1FB;
	Wed, 28 Feb 2024 20:40:44 -0800 (PST)
Received: from [10.163.47.238] (unknown [10.163.47.238])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 368783F762;
	Wed, 28 Feb 2024 20:40:02 -0800 (PST)
Message-ID: <aec4481a-25d5-41db-9d6a-c9e8b9bce310@arm.com>
Date: Thu, 29 Feb 2024 10:10:00 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/hw_breakpoint: Define an ISS code for watchpoint
 exception
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, broonie@kernel.org,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 linux-kernel@vger.kernel.org
References: <20240223094615.3977323-1-anshuman.khandual@arm.com>
 <Zd9RY68L8cJRRSzE@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <Zd9RY68L8cJRRSzE@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2/28/24 20:59, Catalin Marinas wrote:
> On Fri, Feb 23, 2024 at 03:16:15PM +0530, Anshuman Khandual wrote:
>> diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
>> index 353fe08546cf..6c0a0b77fd2c 100644
>> --- a/arch/arm64/include/asm/esr.h
>> +++ b/arch/arm64/include/asm/esr.h
>> @@ -143,6 +143,10 @@
>>  #define ESR_ELx_CM_SHIFT	(8)
>>  #define ESR_ELx_CM 		(UL(1) << ESR_ELx_CM_SHIFT)
>>  
>> +/* ISS field definitions for Watchpoint exception */
>> +#define ESR_ELx_WnR_SHIFT	(6)
>> +#define ESR_ELx_WnR		(UL(1) << ESR_ELx_WnR_SHIFT)
> 
> We had ESR_ELx_WNR since about 2015, maybe even earlier in the form of
> EL1 or EL2. Only that the 'n' is uppercase. So please use that, don't
> add a new definition.

Right, reusing existing ESR_ELx_WNR makes sense, will respin the patch.

