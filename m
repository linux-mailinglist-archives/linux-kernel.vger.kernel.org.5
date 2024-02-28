Return-Path: <linux-kernel+bounces-84464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE43686A716
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 04:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 058F02835C7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABAE1DFFB;
	Wed, 28 Feb 2024 03:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J2yH1+pS"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC621DDF5
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 03:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709090221; cv=none; b=A/Nu5vsO7VUbH/32ixalTc92e8tA/okW44uurL9s+le0CmFeLBG5Sb5i4mDGVPXfD1FWQIUvypj8DGjv6hqqIwzI6nJ/8EJ5MpCf1wyebh+nCJjaSq8cKFzgUpD109PYFUNl5DrnnvuyoDIr2maH6US0HzI8ZcAjvDocMdicIn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709090221; c=relaxed/simple;
	bh=0KdTPWMru+xfweo66KvjuRZDB4qBIIrrYr1uS8ZAx8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qIikIBO1ZT4TSiDGyFiG223Ub47MsLZyImSS3QQzJbRm6Uiuh32iiorRq9ydRLx5r8pt9VDjf09ytIiM2dQTk6r6cp5yBLzqzdBz3lIjnPblBuM9OcbkZGCuQzu4pVMZjW6QI/2wzYU2nx2c2MwMFOyx11dBK06rTD6ZTBoOTQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J2yH1+pS; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e30fa7b9-e04b-48f8-9068-0a7afed2107e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709090218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q94KM6gcpM8pQoPvK7faabgANBdOOMF+oah02Ewb8ys=;
	b=J2yH1+pSqzP1U6gjneMP/EO1gmyllNDn/eJJ5z1pOfcYCT7IFnaIWLzAuIBCZ7HaLWZVEY
	o3HFIPfibXvyLSAIcvEWVgH3nz47duNfp9giLn4cGzJaRynD8GR02C3eZBxwaxEkHxBBMj
	Vghaddk2NMghxARmAfRbL6XAtgVZPWI=
Date: Wed, 28 Feb 2024 11:16:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] dax: remove SLAB_MEM_SPREAD flag usage
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, dan.j.williams@intel.com,
 vishal.l.verma@intel.com
Cc: nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240224134728.829289-1-chengming.zhou@linux.dev>
 <b9966efa-8efe-4de7-b962-a6edcf2f6904@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <b9966efa-8efe-4de7-b962-a6edcf2f6904@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/2/28 00:29, Dave Jiang wrote:
> 
> 
> On 2/24/24 6:47 AM, chengming.zhou@linux.dev wrote:
>> From: Chengming Zhou <zhouchengming@bytedance.com>
>>
>> The SLAB_MEM_SPREAD flag is already a no-op as of 6.8-rc1, remove
>> its usage so we can delete it from slab. No functional change.
> 
> Can you please provide a Link tag to the lore post that indicates SLAB_MEM_SPREAD flag is now a no-op?

Update changelog to make it clearer:

The SLAB_MEM_SPREAD flag used to be implemented in SLAB, which was
removed as of v6.8-rc1, so it became a dead flag since the commit
16a1d968358a ("mm/slab: remove mm/slab.c and slab_def.h"). And the
series[1] went on to mark it obsolete explicitly to avoid confusion
for users. Here we can just remove all its users, which has no any
functional change.

[1] https://lore.kernel.org/all/20240223-slab-cleanup-flags-v2-1-02f1753e8303@suse.cz/

Thanks!

>>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>> ---
>>  drivers/dax/super.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
>> index 54e528779877..cff0a15b7236 100644
>> --- a/drivers/dax/super.c
>> +++ b/drivers/dax/super.c
>> @@ -547,7 +547,7 @@ static int dax_fs_init(void)
>>  
>>  	dax_cache = kmem_cache_create("dax_cache", sizeof(struct dax_device), 0,
>>  			(SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT|
>> -			 SLAB_MEM_SPREAD|SLAB_ACCOUNT),
>> +			 SLAB_ACCOUNT),
>>  			init_once);
>>  	if (!dax_cache)
>>  		return -ENOMEM;

