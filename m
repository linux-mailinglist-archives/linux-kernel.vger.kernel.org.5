Return-Path: <linux-kernel+bounces-90213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5E386FC04
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52ECD2828AD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD2919473;
	Mon,  4 Mar 2024 08:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gA8Dcpfi"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B0B171B0
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 08:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709541567; cv=none; b=UuP6oAHyuLp08gZSHPcpSGgzYDzSV25rYv4luQjLvW1exrIJKzJoGDCkI9DgRnb+cYd1eDPmr2tJCbXJlvoRn8xjSRC0PlAGwBe1prFdo0+v6G2hNFoq0Y9Gm74hBhlNHBNyajyCp8HNHtrCtoQpUBwmLLPA6AZ9Yz7HQMvtWL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709541567; c=relaxed/simple;
	bh=tnbuylnWDXP+S1B3cukYKyI8V5xN6rznZpSCdmCUPNI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tERhXmp5hhZRhuatz4a+jYquINK7RArlAfmWPnWxDTrND2DxCvJfS562KT0O7M/zZYOphTunycHOsPduHdAN20IriUcDqIzbxMxtxc5f762sTe+o4q3MPhiLi1X4PPZLuSbssHxQnVMEhRQ2Sz1Ou61F3z1Nq9qHq1qLI7iwVyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gA8Dcpfi; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709541565; x=1741077565;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tnbuylnWDXP+S1B3cukYKyI8V5xN6rznZpSCdmCUPNI=;
  b=gA8Dcpfij8s3uzxFHKp/ghSFrkmgsM1eybhBMyZZPn8Intp7XAP0Z1BJ
   KGEH/6GOViJrtnKJ/oB2bq9WBhHeYSDtK3aUDaHLLlGwgFFKE/P/xiaMZ
   U8hWDhKT83l51lPusApe+iLItVse74BOHT4/L/hd1hztJp7F/G9gLAhCz
   RYaMnQ4OUIfNTF5xJzmSAp2gMY2GufSAXb7Jj+lUSudzgnFLm4xyeRYW0
   aU1cmP3LyPO/Wo1Iz+sdy+KIsWOjjvIuJT8vsBlEgaj9owvt0HIGqQxZK
   s97WPVpw/O5JWMT36gYm6m5xZZ6/beoyPPDSDINKgSAjuXNhsSaZT8ftT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="14664908"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="14664908"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 00:39:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="13609098"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.211.18]) ([10.254.211.18])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 00:39:17 -0800
Message-ID: <31054869-9373-481b-a002-5200e26a7bba@linux.intel.com>
Date: Mon, 4 Mar 2024 16:39:14 +0800
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
Subject: Re: [PATCH 3/3] iommu/vt-d: Remove scalabe mode in
 domain_context_clear_one()
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, "Badger, Eric" <ebadger@purestorage.com>
References: <20240229094804.121610-1-baolu.lu@linux.intel.com>
 <20240229094804.121610-4-baolu.lu@linux.intel.com>
 <BN9PR11MB527694903CD8E8FBC6C1FB168C232@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527694903CD8E8FBC6C1FB168C232@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/3/4 15:53, Tian, Kevin wrote:
>> From: Lu Baolu<baolu.lu@linux.intel.com>
>> Sent: Thursday, February 29, 2024 5:48 PM
>>
>> @@ -2175,9 +2175,6 @@ static void domain_context_clear_one(struct
>> device_domain_info *info, u8 bus, u8
>>   	struct context_entry *context;
>>   	u16 did_old;
>>
>> -	if (!iommu)
>> -		return;
>> -
> is this check only relevant to sm mode or should it be removed for
> both legacy/sm? If the latter please add a note in the commit msg.

This kind of check makes no sense. I didn't take it to sm mode. So only
need to remove it in the legacy path.

Anyway, let me update the commit message to reflect this change.

Best regards,
baolu

