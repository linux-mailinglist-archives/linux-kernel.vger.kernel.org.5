Return-Path: <linux-kernel+bounces-164365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A99CF8B7CC9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8E901C20BCF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418D5179641;
	Tue, 30 Apr 2024 16:25:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70315176FB2;
	Tue, 30 Apr 2024 16:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714494319; cv=none; b=c85Xe0b9Mtlxp/wEt1Jf55snTKDKWDF3PD293yhKA4gx0s7AUu6UvS3YV6fQ/SqWPnBPebYhccq/Q9lBDy/MsKhIhS8DVqR6UL3ziWY3RQUhsE62G2zUApi99Z6IdvKm97rVMSilSYf3cD9mh8CjdqNJzZkrOvJjT9ds0Ri5OQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714494319; c=relaxed/simple;
	bh=sa7lb/wxyZc1QWCVRIqsvkBHEPUWeVpp/sXduNCivvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=unOVvmSqzMR3Xn7dV7O64z6Mz2V5RwSs8LSAlN1X++46jUIll6lOAUgZRQUq/r1Xslm8spnujeds12Tzz3LyPphQqeoEkvceUDSuvMyhoSxeiw39G3SkjVbF/36ql/ZM+PuvqC1pxH9pn8/j16GTMgdZujAGBjMTjgKUW7/3GFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 315882F4;
	Tue, 30 Apr 2024 09:25:44 -0700 (PDT)
Received: from [10.1.38.140] (XHFQ2J9959.cambridge.arm.com [10.1.38.140])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 66AA23F73F;
	Tue, 30 Apr 2024 09:25:16 -0700 (PDT)
Message-ID: <8645f1a3-1d8c-4883-bbfa-6bdf5b9451af@arm.com>
Date: Tue, 30 Apr 2024 17:25:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64/mm: pmd_mkinvalid() must handle swap pmds
Content-Language: en-GB
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <zi.yan@cs.rutgers.edu>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240430133138.732088-1-ryan.roberts@arm.com>
 <20240430135534.GA14069@willie-the-truck>
 <41a83b7a-17e0-469d-bec4-10ebfff4ef57@arm.com> <ZjEbBasQ8H-wa84I@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ZjEbBasQ8H-wa84I@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/04/2024 17:23, Catalin Marinas wrote:
> On Tue, Apr 30, 2024 at 03:04:32PM +0100, Ryan Roberts wrote:
>> On 30/04/2024 14:55, Will Deacon wrote:
>>> But it might be worth splitting the tests from the fix to make backporting
>>> easier.
>>
>> Yes good point. I'll leave this hanging for today to see if any more comments
>> come in, and will re-post tomorrow as 2 patches. I assume we need to go fast to
>> catch 6.9.
> 
> Yes, I'll pick it up for 6.9. I can drop the tests from the patch (and
> their mention in the log) and you can post your tests separately to go
> via Andrew's tree.
> 

Yep that works for me! thanks.

