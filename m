Return-Path: <linux-kernel+bounces-90196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D484486FBC6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11BEB1C219F5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241091754E;
	Mon,  4 Mar 2024 08:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LA1HMK3b"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF346171BC
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 08:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709540626; cv=none; b=NpmBUTvtXszGnG1LzA7frzUsrY9PCxCoHCMyqQAAZnC8BbmuwaCglXi8gHW7prPD9KehOtVyr0eHqJbxY7qTXT09RdJv9SvWELKWi/UqO3ogrOtPj3nQUOZR+s15EMOeQXCEVbEdiPJEwJ9VSJIf6iwVsuXZ1fe7A9Uv7Q+Gxi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709540626; c=relaxed/simple;
	bh=JFnvDOTZ9hN8lIcmCHeczTlNWmRmqYAtymvqYrWogEs=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lqk+wCcr5qVoeACfwngLvcAKlV+O1oUpVT3lsXDFSFzFRS0q9wX7dSx3lzKupWNKsuBpPZ8lnNHT75zSsPOOsyfnWysk49yBROUd3KmTxXRYTdf1N9auJpwvKhYDTp4FMqO58wJynqcphk72d9p6F3nbugU46q4TgGfTQZdkuLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LA1HMK3b; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709540625; x=1741076625;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JFnvDOTZ9hN8lIcmCHeczTlNWmRmqYAtymvqYrWogEs=;
  b=LA1HMK3bFyKzUfAfrQ8lV1Uo+LHD2QILJqN1JJGkBNHU7xlgS1B0hbsa
   9DHvyIFBozubUqiz1edDwVmSROjcflEXK25qo2R5aD0OweaWREGTH1ZYK
   JqpTlCUVddl8dwICy/x9gIKRnywHxQ6YGcwI59mfDBJWXkDkzQRGHHys9
   x9o4vaUF8knd/qOlpXIZXwKAq6Wfm3XGfQVYKVKGIR3goE4Hw4pEMB3IL
   vtghU1SSPvNcvpg6gBquwCFHLeZ5UGgWyBlDxJiZFenO2Kr7xayZ4DaQ4
   KkbRc2niqdEMGPOOVGAt7IKmuMKVGkxVXjX6DrFxogRrp8NPDq09KQq17
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="3870171"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="3870171"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 00:23:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="9048888"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.211.18]) ([10.254.211.18])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 00:23:38 -0800
Message-ID: <3ad0e349-0ba4-4a89-a664-800c5615ef77@linux.intel.com>
Date: Mon, 4 Mar 2024 16:23:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] iommu/vt-d: Setup scalable mode context entry in
 probe path
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, "Badger, Eric" <ebadger@purestorage.com>
References: <20240229094804.121610-1-baolu.lu@linux.intel.com>
 <20240229094804.121610-2-baolu.lu@linux.intel.com>
 <BN9PR11MB52762BCC8AC154A601B6EBCA8C232@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52762BCC8AC154A601B6EBCA8C232@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/3/4 15:48, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Thursday, February 29, 2024 5:48 PM
>>
>> +static int device_pasid_table_setup(struct device *dev, u8 bus, u8 devfn)
>> +{
>> +	struct device_domain_info *info = dev_iommu_priv_get(dev);
>> +	struct intel_iommu *iommu = info->iommu;
>> +	struct context_entry *context;
>> +
>> +	spin_lock(&iommu->lock);
>> +	context = iommu_context_addr(iommu, bus, devfn, true);
>> +	if (!context) {
>> +		spin_unlock(&iommu->lock);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	if (context_present(context) && !context_copied(iommu, bus, devfn))
>> {
>> +		spin_unlock(&iommu->lock);
>> +		return 0;
>> +	}
>> +
>> +	/*
>> +	 * For kdump case, at this point, the device is supposed to finish
>> +	 * reset at its driver probe stage, so no in-flight DMA will exist,
>> +	 * and we don't need to worry anymore hereafter.
>> +	 */
>> +	if (context_copied(iommu, bus, devfn)) {
>> +		context_clear_entry(context);
>> +		if (!ecap_coherent(iommu->ecap))
>> +			clflush_cache_range(context, sizeof(*context));
>> +		sm_context_flush_caches(dev);
>> +		clear_context_copied(iommu, bus, devfn);
>> +	}
> 
> it's unclear to me why this doesn't need refer to old did as done in the
> existing code. If scalable mode makes any difference could you extend
> the comment to explain so people can avoid similar confusion when
> comparing the different paths between legacy and sm?

The previous code gets the domain ID from the copied context entry:

u16 did_old = context_domain_id(context);

This makes no sense for scalable mode, as the domain ID has been moved
to the PASID entry in scalable mode. As the result, did_old always gets
0.

> anyway it's kind of a semantics change probably worth a separate patch
> to special case sm for bisect and then doing cleanup...

This change doesn't impact anything as the hardware will skip domain id
field in the Context-cache Invalidate Descriptor in scalable mode.

Spec section 6.5.2.1 Context-cache Invalidate Descriptor:

Domain-ID (DID): ... This field is ignored by hardware when operating in
scalable mode (RTADDR_REG.TTM=01b).

Best regards,
baolu


