Return-Path: <linux-kernel+bounces-125399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7D6892578
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1248B283C1A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C856A014;
	Fri, 29 Mar 2024 20:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XqiX32Sj"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3ACE3C08F;
	Fri, 29 Mar 2024 20:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711744952; cv=none; b=XhaK8gSGuO2O9CzBOOOzcEIjn5jY2PnW9ieLhcBwDptjDoNblQaS72BFbwoNBKvcs/9FavA0b13L+bJR7VD0fkdSjW7WzEc90Pj1A1gA8VHpS7znBDHly7mJdvpedUZeH3Y0XfMPOWA2zHOzIzcE/yy91PVE0soZmjQQinAI1jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711744952; c=relaxed/simple;
	bh=hz5RR0GReCD0o+TbGpPzwpXzow8mvQnlmHPDe6BzQNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cDuFMISyU/0W7NAamxJut++EEeR83zlIzZH/qiyJsJdnezPQCTHk2wjeLq6Db47PjB0SJ2aCKz+TP4vUVoiDi6K2DJQWiWFuGeStNdVbfbI+WCVX4YqhhYGxNszGGGOIZ0a6HxnLuiJ+S7OJ5hg2KSP1zz+KxfUS6k9Dsj5j9Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XqiX32Sj; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.65.59] (unknown [20.29.225.195])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0787420E6F42;
	Fri, 29 Mar 2024 13:42:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0787420E6F42
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1711744950;
	bh=T3bq+rfTxoFcrWlHxiM/MsuE/8OiSBnZvhXgUAsFCnQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XqiX32SjGqD3vk/hUo4BhZDOk+DdTVyaYWF0zAdPXk7zAPwBavYyWo7D6sBZ68dFM
	 L/TJp4duCoEIVCMuOHHW4ZCL+J6aZF4kQn9MMkQ/Rrv/qeFr0jl+jI9CJ8Ck9rFn6n
	 NPijVBOT4MeX1n6mROxFMxLlPNRa1eBx5dJHF0DM=
Message-ID: <9336949d-6fa4-457c-8d7e-9aaa5d62cbd7@linux.microsoft.com>
Date: Fri, 29 Mar 2024 13:42:27 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] swiotlb: Do not set total_used to 0 in
 swiotlb_create_debugfs_files()
To: Dexuan Cui <decui@microsoft.com>, "hch@lst.de" <hch@lst.de>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "zhangpeng362@huawei.com" <zhangpeng362@huawei.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "mhklinux@outlook.com" <mhklinux@outlook.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20240329192809.17318-1-decui@microsoft.com>
 <07ed50c1-75a9-494c-8a6a-5edcc2d6f932@linux.microsoft.com>
 <CY5PR21MB3759BEE344CCD8F20FBB4E4CBF3A2@CY5PR21MB3759.namprd21.prod.outlook.com>
 <CY5PR21MB3759C7C9F4637F6D157635A1BF3A2@CY5PR21MB3759.namprd21.prod.outlook.com>
Content-Language: en-CA
From: Easwar Hariharan <eahariha@linux.microsoft.com>
In-Reply-To: <CY5PR21MB3759C7C9F4637F6D157635A1BF3A2@CY5PR21MB3759.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/29/2024 1:30 PM, Dexuan Cui wrote:
>> From: Dexuan Cui
>> Sent: Friday, March 29, 2024 1:23 PM
>> To: Easwar Hariharan <eahariha@linux.microsoft.com>; hch@lst.de;
>> m.szyprowski@samsung.com; robin.murphy@arm.com;
>> zhangpeng362@huawei.com; iommu@lists.linux.dev;
>> mhklinux@outlook.com
>> Cc: linux-kernel@vger.kernel.org; stable@vger.kernel.org
>> Subject: RE: [PATCH] swiotlb: Do not set total_used to 0 in
>> swiotlb_create_debugfs_files()
>>
>>> From: Easwar Hariharan <eahariha@linux.microsoft.com>
>>> Sent: Friday, March 29, 2024 12:47 PM
>>> [...]
>>> Sorry, I'm missing a why in this commit message. Can you say what
>> happens
>>> if the total_used and used_hiwater IS blindly set to 0? Is the only effect
>>> the change  in the readout of the swiotlb debugfs files?
>>>
>>> Thanks,
>>> Easwar
>>
>> Right, when the system is not doing any I/O, the readout may
>> return a huge number while it should return 0. This is the only effect.
>>
>> Thanks,
>> Dexuan
> 
> Let me share more details.
> 
> kernel/dma/swiotlb.c uses inc_used_and_hiwater() and dec_used()
> to do the accounting.
> 
> The issue happens this way:
> 
> 1. inc_used_and_hiwater() adds n to total_used.
> 2. swiotlb_create_debugfs_files() sets total_used to 0.
> 3. dec_used() decreases total_used by n, i.e. total_used incorrectly 
> becomes a negative number -n, which is a huge number since
> mem_used() converts the 'long' to 'unsigned long'.
> 
> Thanks,
> Dexuan
> 

Thanks for the detail. I only ask because the patch is marked for stable, and
I was wondering if it meets the criteria. But, as you mentioned off list, two Fixes
tags probably do meet the bar.

Thanks,
Easwar

