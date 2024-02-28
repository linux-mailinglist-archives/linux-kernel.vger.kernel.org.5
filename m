Return-Path: <linux-kernel+bounces-84314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E599486A4DD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 760BB1F24C8C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9648C185E;
	Wed, 28 Feb 2024 01:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lrIEPNnN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7881A1103
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 01:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709083185; cv=none; b=VYn/iopAOZR+naFL/T2EkOjPLdtEC+y+k91crbaqXStEI69ufZ7jIntkcY5c+6F+ZcJJ8fEXE1k6R28dDGVhzscLCiKr6I9XEQlgoog+gDqsQAhgvKi7doWPn/tSk+WfQr6z+lK4eBkcv4LW96j0LUNfAJUu+PKPav0d1lVo+nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709083185; c=relaxed/simple;
	bh=tQvscC8DBlBxs+BhNJ1NwTvV+ccyIZaVmqcCkhwrSXU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VxMVv+T5ccWiNKKTndE0dyVM1EHDufYWvTVGV75MN6blVfGRyfU2BojvqF6rnoiYWZoHQJAoLuqwymFyX1JKnPKk8RXC8j8hUi0W33zEP7RYZRp3LVEDb8e/Vtey2vAsAcENFfkMtZF20n6ydxDQAwGHaNpjpIE8O4x4Nv5YkWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lrIEPNnN; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709083185; x=1740619185;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tQvscC8DBlBxs+BhNJ1NwTvV+ccyIZaVmqcCkhwrSXU=;
  b=lrIEPNnN6wr68RTV/tIdqkwBT0I5JSYgNHZhnppOQNuWHXgTg/SxjSYa
   JHSjtNhG5pCqRn3x8M5fwj6hlewFIwVQ/XGczW9h+5tQvgJiApAB+q5j/
   jmOkDT6khNUStyIcrcjk88Bsa0CX7DKuPQhRWQv37IH8FJtV9s/SOUfmY
   uPw6DiTSS7VKRmDwDJ/6kfp72xpSY7TwCjPevx3HHm+46FjzjC6NGuyJU
   VTh7ewSWtjuP7LHVFPNQ8uGd4vcsMoGcUBiE3aSbz3xF3ccYkE9QlB8qu
   eGmnTqMI4gsh1is1wLy4RZ/PW5X3CymdozO+C1Itfn+HLZ7j1aYUVOB+G
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3620158"
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="3620158"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 17:19:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="11872833"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa004.fm.intel.com with ESMTP; 27 Feb 2024 17:19:41 -0800
Message-ID: <c8bfc031-27a2-464e-b98e-47a7e6a05286@linux.intel.com>
Date: Wed, 28 Feb 2024 09:13:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH 1/2] iommu: Add static iommu_ops->release_domain
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, "Badger, Eric" <ebadger@purestorage.com>
References: <20240223051302.177596-1-baolu.lu@linux.intel.com>
 <20240223051302.177596-2-baolu.lu@linux.intel.com>
 <BN9PR11MB52766C0E58E2CB6989E0EB608C592@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52766C0E58E2CB6989E0EB608C592@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/27/24 3:32 PM, Tian, Kevin wrote:
>> From: Lu Baolu<baolu.lu@linux.intel.com>
>> Sent: Friday, February 23, 2024 1:13 PM
>>
>>
>> +	/*
>> +	 * If the iommu driver provides release_domain then the core code
>> +	 * ensures that domain is attached prior to calling release_device.
>> +	 * Drivers can use this to enforce a translation on the idle iommu.
> 'enforce a translation' is confusing in the context of blocking/identity
> domain.

Blocking or identity domain is also kind of a translation from the
core's perspective. The core does not care what type of translation the
release_domain is; it just enforces this type of translation before
device release if the driver has specified one.

Best regards,
baolu

