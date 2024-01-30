Return-Path: <linux-kernel+bounces-44000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18828841C05
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C310A28439F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 06:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD70383B5;
	Tue, 30 Jan 2024 06:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NwhTjqAc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82252383A2
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 06:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706596753; cv=none; b=XlMCAfpNKoqc9NyGeGtXuoB/qALLWT73YLqv7zBc9TprV7w8j0lON9tQn+mFv/IBVhoNWzjHlWVdG2/nGp2aZdTECMEtpfin+QvNOlDD+AxWRgNuxqihLpSGx6AiI2ZC0JVINMKX+PFNem3nZwqTrWVfBKBQgB13gAMXC4EdBYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706596753; c=relaxed/simple;
	bh=ql8JyOqXu4hDbI4cy8/jf9zI9M1di9RVCr3fSSdMWeE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ssJMK0Dnxm+yJfANDYuLg4kaBoIHLCKOyRQu/dZza1Rx1rPgxgf9qAiEq+kSVJgeyzm/rGUSOU8aKUPcFRK+xovalT2cR7a2cxvJIR8zFxPWDIejt3Fv7RxDvItMrJk706dh6AGrO8qV3yGdfVDgbD4UbGmIFs2WUt13eKi0QZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NwhTjqAc; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706596751; x=1738132751;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ql8JyOqXu4hDbI4cy8/jf9zI9M1di9RVCr3fSSdMWeE=;
  b=NwhTjqAc0GCVieCAS1FSnqaajcJl42FRE1QBhcZkeCLMu3EpSV2TJ0Ud
   OSrRZBuCAMPBwkgoNNaADsZKkGzBLV0C7r01F82J/G/++M7tdUkNRQNvi
   MD/RnK6dFrx4GvtLwm3TgfgX8ML46ljedoRK+JRJNPA55G3S1fkeOEV63
   QTpq1y8h67rYgJ5jRjv2OLDdD7R/WKKrwcLCu9la4WtrbvM9hdpizYSRV
   Ez/SCQ5FxJ9Vk7XQYWnDJNDx2lDWKhUy7DtiMoIskFWAXx1I8goQkTH9l
   VCLrDuuRkJ7L9ZcMt/Az2vwL+dBoduAmGTpQ6+0YNRa2q41tQy7PZZnBm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="24662706"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="24662706"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 22:39:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="36394744"
Received: from unknown (HELO [10.249.174.186]) ([10.249.174.186])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 22:39:08 -0800
Message-ID: <757c6b52-628c-4d73-8e66-43a06e1cd982@linux.intel.com>
Date: Tue, 30 Jan 2024 14:39:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] iommu/vt-d: Remove INTEL_IOMMU_BROKEN_GFX_WA
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
References: <20240130060823.57990-1-baolu.lu@linux.intel.com>
 <BN9PR11MB5276DD160FDBEC47F9441F008C7D2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276DD160FDBEC47F9441F008C7D2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/1/30 14:24, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Tuesday, January 30, 2024 2:08 PM
>>
>> Commit 62edf5dc4a524 ("intel-iommu: Restore DMAR_BROKEN_GFX_WA
>> option for
>> broken graphics drivers") was introduced 24 years ago as a temporary
>> workaround for graphics drivers that used physical addresses for DMA and
>> avoided DMA APIs. This workaround was disabled by default.
>>
>> As 24 years have passed, it is expected that graphics driver developers
>> have migrated their drivers to use kernel DMA APIs. Therefore, this
>> workaround is no longer required and could been removed.
>>
>> The Intel iommu driver also provides a "igfx_off" option to turn off
>> the DAM translation for the graphic dedicated IOMMU. Hence, there is
>> really no good reason to keep this config option.
>>
> 
> s/DAM/DMA/

Fixed. :-)

Best regards,
baolu

