Return-Path: <linux-kernel+bounces-42280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1481183FEF9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 08:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B69211F22A51
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 07:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76B24E1C5;
	Mon, 29 Jan 2024 07:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mbYV9foc"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2364E1C8
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 07:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706513107; cv=none; b=FAVXkckluQYcfRokSjdq5zp6BKzuCtJ5AWiyIl8Isjdf86jEfK2BAKZmhVw/ypXFo5+gJp24wFiffkEL52BbHeYjfSpsuhafvjp8DAWHCi6EomP0Hs6gz/52gfulg6UEyEV9toBxGqT85Dl6a3p6xBFzf2bSsCWZK/Zs5jW89zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706513107; c=relaxed/simple;
	bh=oYcxImTQq+1tjT/wwyYicNP+ut2AE6+9OGh0Vd1KEv4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Nzyhfmi0n1bTZrM2egIX71QISo3YrusGdr/+YGmTgJLn6tFj1NUO4iDkhm2ti/9x2wd0clokUmae9nC3LJ3I8mcOOWlpekFYVwdnWtjptW4V0v3emvL6GYYn+z5qrzsNam1X+PdEZ+6wTXSbgF3EY6j7nyx165a7WWoOaaroqNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mbYV9foc; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706513105; x=1738049105;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oYcxImTQq+1tjT/wwyYicNP+ut2AE6+9OGh0Vd1KEv4=;
  b=mbYV9foctAZHUYmBnvPpoGjCcR39ZtweXlKbaR95NKgz/2HS8JAB2LZZ
   IfOI8uCD22UK1B/JOV6nfmt2ORtr91q8gJQ/us7gixDFwXxCzVwtO2kR3
   1O19v0gJaQMtrQoY4y8E16gfnRz2QCo4TX5WLfNsrTUr2FDoyFs4+3tAi
   G+lGdrwfEXYvCbtXs8viSpt4QK+SYlqGuvkGQljfbFd5GeF84SVq8Kgft
   isPiMlcPvGJQMz1Vbh09ChbmHoCkambp50IqOwAB+gewTChn3YiBGCsAx
   veUr3uO0ba0WoiZ1480pBki3kly5A4KClBT409nWKOHacEJpjevHzkko/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="434033273"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="434033273"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 23:24:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="3288660"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.174.51]) ([10.249.174.51])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 23:24:42 -0800
Message-ID: <abc6771f-fafe-4ca7-898a-aecbe017b3c7@linux.intel.com>
Date: Mon, 29 Jan 2024 15:24:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] iommu/vt-d: Remove INTEL_IOMMU_BROKEN_GFX_WA
To: "Tian, Kevin" <kevin.tian@intel.com>,
 Christoph Hellwig <hch@infradead.org>
References: <20240127064512.16744-1-baolu.lu@linux.intel.com>
 <Zbc_mdOYxMIxWAdd@infradead.org>
 <BN9PR11MB5276D63FAC442A415018ACB58C7E2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276D63FAC442A415018ACB58C7E2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/1/29 14:08, Tian, Kevin wrote:
>> From: Christoph Hellwig <hch@infradead.org>
>> Sent: Monday, January 29, 2024 2:03 PM
>>
>> On Sat, Jan 27, 2024 at 02:45:12PM +0800, Lu Baolu wrote:
>>> Commit 62edf5dc4a524 ("intel-iommu: Restore DMAR_BROKEN_GFX_WA
>> option for
>>> broken graphics drivers") was introduced 24 years ago as a temporary
>>> workaround for graphics drivers that used physical addresses for DMA and
>>> avoided DMA APIs. This workaround was disabled by default.
>>>
>>> As 24 years have passed, it is expected that graphics driver developers
>>> have migrated their drivers to use kernel DMA APIs. Therefore, this
>>> workaround is no longer required and could been removed.
>>
>> How about you Cc the intel graphics maintainers and get a confirmation?
>>
> 
> in the worst case there is still "igfx_off" option available to achieve the
> same effect.
> 
> there is really no good reason to keep this config option so long while it
> was intended to be removed in 2.6.32.
> 
> but yes the Intel graphics maintainers should be CCed.
> 

You both are right.

I will add above in the commit message and Cc graphic guys with a new
upgraded version.

Best regards,
baolu

