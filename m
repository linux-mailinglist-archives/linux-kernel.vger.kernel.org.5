Return-Path: <linux-kernel+bounces-82972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80301868C68
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07C7CB23B52
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8C81369BF;
	Tue, 27 Feb 2024 09:39:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEDD1369AE
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 09:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709026798; cv=none; b=MPctsVtiXWAgkq6nYOrWr81VGA4WgitEMV563lYcQ2qIP6mif30Eu1wgMi5lqEFbjU5cB0HgpqFVpzSLYkT4sfe05R+0bRV9DjvxSioLDwriyA3u+MloipHDm8Uf0w84/23i00+i03rzHugmeIgdf229Af/4VqKzZGj8+khDEqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709026798; c=relaxed/simple;
	bh=WLikBwdKRgfqzN0Fv6VtBzyq5SN5Elqbqt34MJQaPhA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZfV+O20bG74dSuTRpjfZMs8uWdiNx+8lJKkwxXH8ZLV48B6tFDqYVXgAQfsGIGTsSSkQB1LiQMo4dUBOdWbxuBJ4iU9oVujlooSeqCE6WUrbeLHxePz8gIjqGaHA8ZmKwzWFwlzBNfIOLRWRk0zL8MQzDh8Ps5p97pikk0kOs7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5933DDA7;
	Tue, 27 Feb 2024 01:40:34 -0800 (PST)
Received: from [10.163.48.107] (unknown [10.163.48.107])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D6BB13F762;
	Tue, 27 Feb 2024 01:39:53 -0800 (PST)
Message-ID: <9f20e601-a5b8-48be-8364-3ea9b45d0940@arm.com>
Date: Tue, 27 Feb 2024 15:09:51 +0530
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 linux-arm-kernel@lists.infradead.org, broonie@kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org
References: <20240223113102.4027779-1-anshuman.khandual@arm.com>
 <20240223125224.GC10641@willie-the-truck>
 <1901fadb-1d71-4374-be8c-00935bb27854@arm.com>
 <ZdxwTkUALQfqjagf@FVFF77S0Q05N>
 <c37bd84e-d4f7-42df-a333-f2ad6ebc9527@arm.com>
 <20240227090529.GA13359@willie-the-truck>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240227090529.GA13359@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/27/24 14:35, Will Deacon wrote:
> On Tue, Feb 27, 2024 at 11:01:54AM +0530, Anshuman Khandual wrote:
>> On 2/26/24 16:34, Mark Rutland wrote:
>>> I don't think this needs to change, and can be left as-is.
>>
>> Fair enough, but just wondering how about deriving len_in_bytes from
>> hweight_long(ARM_BREAKPOINT_LEN_*) instead ? This also drops the hard
>> coding using the platform macros itself, without going to user ABI.
> 
> Please leave this code alone. It's fine like it is and there are plenty of
> other things that would actually benefit from your attention. The BRBE
> series, for example.

Sure, no problem, will drop this patch.

