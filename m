Return-Path: <linux-kernel+bounces-70124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4908E8593B1
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 01:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDB4728152B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 00:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C366E7FF;
	Sun, 18 Feb 2024 00:34:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97D3360
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 00:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708216483; cv=none; b=Q7SpPpZhvvwR154W+xPVDM6UT8GSJbYotf98Trsyt7EXaJvSPNbNAc+18Tqhx0bo91qZ5tbIKnyZRun3qZD4ihytKo4Aqwe6f6ElMUu69jaTh5zegXckwL0kpiHVxXMD4jX+ejE7/M6wSveX+ZModonrh6SLQlzth8jUWazAhJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708216483; c=relaxed/simple;
	bh=PvYE+aZ+IRwRox1Xt4CLZHe5EcgUWS1ssFaHy2+vS/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hMR2PAqUH3/6ncE2nBHFqm94ykOeTv9tGKRHY0xFMjojcadzZi/B71pu5wTz4mfj1bqoahN3bJAL/WTttO7NKA1x20Itl34GbO9RI6NVDIy90fCS02evzrvAdNxIFdAjYQSGNkT8FzsH3ytdLhDRM1LHZR9kR5f5Pjwgg5k7svQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34B61DA7;
	Sat, 17 Feb 2024 16:35:14 -0800 (PST)
Received: from [10.163.45.155] (unknown [10.163.45.155])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B0433F694;
	Sat, 17 Feb 2024 16:34:31 -0800 (PST)
Message-ID: <785e9bd7-f47b-4e8f-9291-0616aa87fa27@arm.com>
Date: Sun, 18 Feb 2024 06:04:34 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/sysreg: Add register fields for ID_AA64DFR1_EL1
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20240215065454.2489075-1-anshuman.khandual@arm.com>
 <d2722ae9-d29c-41f9-9eec-f829589adf6e@sirena.org.uk>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <d2722ae9-d29c-41f9-9eec-f829589adf6e@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/15/24 18:34, Mark Brown wrote:
> On Thu, Feb 15, 2024 at 12:24:54PM +0530, Anshuman Khandual wrote:
> 
>>  Sysreg	ID_AA64DFR1_EL1	3	0	0	5	1
>> -Res0	63:0
>> +Field	63:56	ABL_CMPs
>> +Field	55:52	DPFZS
> 
> This is documented in the architecture as an enumeration, though I'm not
> immediately seeing what values to use.

Just wondering - would something like the following make sense. Because
0b0000 signifies that the cycle counter would just ignore PMCR_EL0.FZS,
where as it gets frozen with 0b0001.

UnsignedEnum   55:52   DPFZS
       0b0000  IGNR
       0b0001  FRZN
EndEnum

> 
> Otherwise this looks good.

