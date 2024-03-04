Return-Path: <linux-kernel+bounces-90492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4974987000E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C01F4B2162D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6983839F;
	Mon,  4 Mar 2024 11:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nsLn6j6t"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EF2374FC
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 11:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709550814; cv=none; b=tA6BwVaWdt8qgxW7SgIh7GJWWcLBAkz6rr8VjTUFPcUzuC2Vt4A77hCUpfQEjPXXjsrlQvV1Fah6mcXFTt2Di+LOx3IBZ7ZVNp1dle6eThXxab5251MwBMvOTymwWI4/NmIzBD3EfXvg8R9DKCjMZIe/d4C2mGtWA1VbRPKY2VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709550814; c=relaxed/simple;
	bh=HqUqg/Wa53cQbaSF5Qd2u9XC2JhUzuVO9f0/Fxehy84=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aCOX/rvQWPHOvl/emFbICdRB4SvbCN3DnBqozfqpwgLFa6HuC/8dNaTFcNi98Q6hEdhK5mAwHYbeg1o4G2lQ8bqyh8m5cpU2pz0YeC/OpJkrtxZ5he/2aI89OKAhoSL65HI207xjPYvmKcnWSnktzGkfMjpqVj923WpSv3a00jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nsLn6j6t; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709550813; x=1741086813;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HqUqg/Wa53cQbaSF5Qd2u9XC2JhUzuVO9f0/Fxehy84=;
  b=nsLn6j6thXLBgBXcQntg/zxgkyEdWL5gdNO0Vn3IkjCpkOKHa5ga6QGg
   cg647ysFTb2Rs9tf3cPKqFMK0kQJ3Amut40Ij7R9d+hur+IusBOxQbQfX
   r2ZXRzJKzn/5da/bLBn9Lhh1vHgyLm9c75GYZgY1FGXKL8uMzlKMrvABc
   +ZGHJKCk0cmqTGJj7AloJAl494E2Q9etBPluJno0qACj0uw9WIyurR0Ba
   pzm7ETMk33SWAvRlKxd5OCdTATfmVXMsfF0GM96pgHyMqrfCQ6jEE+Wli
   PqXzy805L2YSP3nz8M17dZMkR/0AcT9VQZ/GyUtWPpUXK2FIltrsaqbJV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="3923528"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="3923528"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 03:13:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="13645690"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.211.18]) ([10.254.211.18])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 03:13:30 -0800
Message-ID: <2d2b605f-3b95-4764-b7c3-005824709078@linux.intel.com>
Date: Mon, 4 Mar 2024 19:13:27 +0800
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
 <3ad0e349-0ba4-4a89-a664-800c5615ef77@linux.intel.com>
 <BL1PR11MB52719E06919ECFF95A91EC028C232@BL1PR11MB5271.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BL1PR11MB52719E06919ECFF95A91EC028C232@BL1PR11MB5271.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/3/4 17:05, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Monday, March 4, 2024 4:24 PM
>>
>> On 2024/3/4 15:48, Tian, Kevin wrote:
>>>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>>> Sent: Thursday, February 29, 2024 5:48 PM
>>>>
>>>> +	/*
>>>> +	 * For kdump case, at this point, the device is supposed to finish
>>>> +	 * reset at its driver probe stage, so no in-flight DMA will exist,
>>>> +	 * and we don't need to worry anymore hereafter.
>>>> +	 */
>>>> +	if (context_copied(iommu, bus, devfn)) {
>>>> +		context_clear_entry(context);
>>>> +		if (!ecap_coherent(iommu->ecap))
>>>> +			clflush_cache_range(context, sizeof(*context));
>>>> +		sm_context_flush_caches(dev);
>>>> +		clear_context_copied(iommu, bus, devfn);
>>>> +	}
>>>
>>> it's unclear to me why this doesn't need refer to old did as done in the
>>> existing code. If scalable mode makes any difference could you extend
>>> the comment to explain so people can avoid similar confusion when
>>> comparing the different paths between legacy and sm?
>>
>> The previous code gets the domain ID from the copied context entry:
>>
>> u16 did_old = context_domain_id(context);
>>
>> This makes no sense for scalable mode, as the domain ID has been moved
>> to the PASID entry in scalable mode. As the result, did_old always gets
>> 0.
> 
> The point is whether the driver requires to invalidate cache for old did
> which is orthogonal to using legacy or sm. If yes, then we should fix the
> code to find the right did instead of ignoring it. If no then the legacy path
> should be cleared too to avoid unnecessary burden.
> 
>>
>>> anyway it's kind of a semantics change probably worth a separate patch
>>> to special case sm for bisect and then doing cleanup...
>>
>> This change doesn't impact anything as the hardware will skip domain id
>> field in the Context-cache Invalidate Descriptor in scalable mode.
>>
> 
> no semantics change but if old code has bug we should fix it instead
> of carrying the behavior. 😊

The driver is required to invalidate the cache for the old did.

The previous code invalidated the cache twice, once in
intel_pasid_tear_down_entry() and another time in
domain_context_clear().

The new code attempts to eliminate this duplication by invalidating the
cache for the did during blocking domain attachment and skipping it in
sm-context-entry teardown.

Best regards,
baolu

