Return-Path: <linux-kernel+bounces-94839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 733188745C8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 725641C22EC5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 01:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7D9522A;
	Thu,  7 Mar 2024 01:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PI/bVbYE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEDF2F37
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 01:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709776501; cv=none; b=GsIHOMN7OulrurYlwFhHikSFm61AHtCPvHxGeti1zFLU4nTf12H8n6dRR6vSvpqQIrW7ne9a7//MMa7cL5Si8QTjzC/NZweQpCks5e1SAt4xu2fP+BnilNn9fie+vNPiYJ3XJGjRUwLlRJ361zU/MrQxCPwuB3uVxmXWUn3lbDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709776501; c=relaxed/simple;
	bh=5WFadBJ053HVtxwSAi8UYcspvQWJ8KI5l/JwPFHYq1w=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lSga4CbZPODQupyIa9TUTWFpT9EWrDIaDmotXvIAa9YTQHQk6kI487MmdEl4WmIzEJejgWN/VPTNFbyXGTQM86SoE47Z+W6oSCAC/KMfqWMcdqThvYLN691BBvbSdQSj4FMNJA/0xpcCYfAqHTF20JfNNgUR/Ve/rMnDj+IxBJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PI/bVbYE; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709776500; x=1741312500;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5WFadBJ053HVtxwSAi8UYcspvQWJ8KI5l/JwPFHYq1w=;
  b=PI/bVbYEDahAZr+cbvPJJ/UX+kWgOSrZPakTzTKo+r5jNMWWICCcsAbz
   6Lg133uDJd80+nRjOt+dv8pjUEZpDl2s05kdEKzkHYGgrdHPe3tXFVb0R
   hGID5yRgTD9Zbslfh8UMlUMXkvo1eFYttVcxPSYqy2g6ej9Uj1mNleVcJ
   XV/q5SUHvxFcR0n2QiV97LyfRBAUUguzjzm2U9L9P9ovvPaHfNbbO84Wt
   iV1VVGsCnAfueGz5yIciZXBqzCA/lW1lpmwBbS+ylueG8JQpIMcEqQJS/
   oo3BzOSQ1w2Uwo7fbr0MoqkZy76TxXfuaW9v1hlez+eGINBklU5wzv+7D
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="4311265"
X-IronPort-AV: E=Sophos;i="6.06,209,1705392000"; 
   d="scan'208";a="4311265"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 17:54:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,209,1705392000"; 
   d="scan'208";a="14510975"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.213.185]) ([10.254.213.185])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 17:54:56 -0800
Message-ID: <74d6f11a-9415-48e5-a165-7b9f5b87873d@linux.intel.com>
Date: Thu, 7 Mar 2024 09:54:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/8] iommufd: Associate fault object with
 iommufd_hw_pgtable
To: Jason Gunthorpe <jgg@ziepe.ca>, Zhangfei Gao <zhangfei.gao@linaro.org>
References: <20240122073903.24406-1-baolu.lu@linux.intel.com>
 <20240122073903.24406-6-baolu.lu@linux.intel.com>
 <CABQgh9FwOVsFe3+5VG0_rDruJVW0ueHTcsnxUcVAvFqrF4Vz6Q@mail.gmail.com>
 <CABQgh9G5yFZ_p+tfvnJqOQo+Be62rMDatsEX1rhD_oTiXDaw5w@mail.gmail.com>
 <20240306160120.GN9225@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240306160120.GN9225@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/3/7 0:01, Jason Gunthorpe wrote:
> On Wed, Mar 06, 2024 at 11:15:50PM +0800, Zhangfei Gao wrote:
>> Double checked, this does not send flags, 0 is OK,
>> Only domain_alloc_user in iommufd_hwpt_paging_alloc requires flags.
>>
>> In my debug, I need this patch, otherwise NULL pointer errors happen
>> since SVA is not set.
> This is some driver bug, we need to get rid of these
> iommu_dev_enable_feature() requirements.

Yes. Especially iopf should be independent of SVA.

The problem in the arm smmu v3 driver is that enabling iopf is actually
done in the enabling SVA path, while the enabling iopf path does nothing
except for some checks. It doesn't matter if iopf is tied with SVA, but
when it comes to delivering iopf to user space, we need to decouple it.

Best regards,
baolu

