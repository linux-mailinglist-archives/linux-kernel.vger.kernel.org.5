Return-Path: <linux-kernel+bounces-55934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AC684C39D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 05:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2987E1F26F1B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 04:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2D4134A4;
	Wed,  7 Feb 2024 04:34:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2761712B71
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 04:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707280479; cv=none; b=loTjMAb4hSifAhs+R3NBoGw2qA8ja6MkXqpfNliaBbXPBV40HfGdyRPxRAw1zhNdm/lNfltbRXU5LFG/l/GKnAk9D1uWlB6K3Kqv/6XnAIpAx0sWXXNKjmIOyQae7u9p0fNGeO8ihCMJjVuv9yuwSLuiOUC+yGA68oywit/Zxe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707280479; c=relaxed/simple;
	bh=5SC92MxPuA44KXqdmryQh6nFTEySvoc2sDpD9I4xptM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TIvMDHjWgBkP03x7h+a3W/j51UwhbEFLRpxyDyuPEAC0y/+d6iEfVWSnUafRKrV4LCIXOrGr5UnR5IaUO+xnWMV+jmE064ZMh7nn6a0WG9keSbwvMAyB8tNOvbSp1CmJ3fWmCtDyjxZmtoH0fSdUP0CtruwRIWYQoYY0Kl/7WgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 267511FB;
	Tue,  6 Feb 2024 20:35:18 -0800 (PST)
Received: from [10.162.40.23] (a077893.blr.arm.com [10.162.40.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6BA453F5A1;
	Tue,  6 Feb 2024 20:34:34 -0800 (PST)
Message-ID: <8d9f2950-6805-481f-a5e7-e5ea45128fb5@arm.com>
Date: Wed, 7 Feb 2024 10:04:31 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/cma: Add sysfs file 'release_pages_success'
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, alexandru.elisei@arm.com, linux-kernel@vger.kernel.org
References: <20240206045731.472759-1-anshuman.khandual@arm.com>
 <20240206093857.d834af4f96d643c53e29e02d@linux-foundation.org>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240206093857.d834af4f96d643c53e29e02d@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2/6/24 23:08, Andrew Morton wrote:
> On Tue,  6 Feb 2024 10:27:31 +0530 Anshuman Khandual <anshuman.khandual@arm.com> wrote:
> 
>> This adds the following new sysfs file tracking the number of successfully
>> released pages from a given CMA heap area. Also like before - this will be
>> available via CONFIG_CMA_SYSFS, and help in determining active CMA pages
>> available on the system.
> 
> "like before" is mysterious.  Is this referring to some other patch? 
> To existing code?  Please be explicit and complete.

This was just referring to existing sysfs files i.e 'alloc_pages_success'
and 'alloc_pages_fail'.

> 
>> /sys/kernel/mm/cma/<cma-heap-area>/release_pages_success
>>
>> It adds an element 'nr_pages_released' (with CONFIG_CMA_SYSFS config) into
>> 'struct cma' which gets updated during cma_release().
> 
> The changelog doesn't explain why Linux needs this feature.  The value
> to our users.  Perhaps that info is buried in the link which is buried
> below the ^---$, but as this is the most important part of a changelog,
> it really should be spelled out here, completely and carefully please.

Does this look better ?

mm/cma: Add sysfs file 'release_pages_success'

This adds the following new sysfs file tracking the number of successfully
released pages from a given CMA heap area. This file will be available via
CONFIG_CMA_SYSFS and help in determining active CMA pages available on the
CMA heap area. This adds a new 'nr_pages_released' (CONFIG_CMA_SYSFS) into
'struct cma' which gets updated during cma_release().

/sys/kernel/mm/cma/<cma-heap-area>/release_pages_success

After this change, an user will be able to find active CMA pages available
in a given CMA heap area via the following method.

Active pages = alloc_pages_success - release_pages_success

That's valuable information for both software designers, and system admins
as it allows them to tune the number of CMA pages available in the system.
This increases user visibility for allocated CMA area and its utilization.

> 
>> ---
>> This patch applies on v6.8-rc3
>>
>> Some earlier relevant discussions regarding arm64 MTE dynamic tag storage
>> in this regard can be found here.
>>
>> https://lore.kernel.org/all/ZbpKyNVHfhf1-AAv@raptor/

