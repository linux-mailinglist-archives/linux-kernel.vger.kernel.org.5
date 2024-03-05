Return-Path: <linux-kernel+bounces-92326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2DA871E7A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBA0D285075
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2115822E;
	Tue,  5 Mar 2024 12:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CIUY37uS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCDD5810B
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 12:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709640115; cv=none; b=GkploqimUiEj8HXS7P/AZubNbS+k9rxYJK+jelKeK4+pjcqfwxsEHkywIYmrzt9dTuRsf/ZMCN4RbewtKMiRTcIA5i7PNclJ4CkMGtHJR/AX2qn3vwCRCAgbrg93+yRiOAX+V+6HRDDt1SveIGgiaEQxhKI3ADVETWRYq0jSxKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709640115; c=relaxed/simple;
	bh=p3MEnM7Hc3Q02hOH9T/CHTh7Gwecqmsvh/qEe+3UuM8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qTBa+O6coMSVJBygKGzB4o7RgXU/zYizt59AZmnx+PhrL8mQ7Up5635Vjy65n3UmtiSpA3JaBPeHLBRQrOE3tmGOU72UVHYxSquK9JFom02FJkU/Zq9LDo6dXS86pp2g4UrXD9wuMywYK4iEH5NmMvnNi0hQ/XcPwl3N0PBT/Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CIUY37uS; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709640115; x=1741176115;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=p3MEnM7Hc3Q02hOH9T/CHTh7Gwecqmsvh/qEe+3UuM8=;
  b=CIUY37uSzllmApnZq4yTklcrOw5fNuShV1nIkT0JFgmduseD7zD1hz3B
   x3+zXw9lhQorjNIXSIBfJO2ZskuyNXK9d7w0AOb1iE8MBxDTuLzTYcbhX
   g7WvIO2NS/k5yCYhdyjfo0jg9u8t6xSrQL03IWRsmlXuBxY1TN3PCPMcw
   VTtxivmW4LkNcyZXsizy5n/3KEOmx9iEMZR19n+6IJnm+K9+F5zJjn24q
   RucrVepSso7qqQlKkhauzhga5swCW0pTw8Z81wzRt2T/TW8ZClGXZqULS
   yLWtcKaTKVy0bAOBwsbUMoNkQi7JIZ/NPE2LFAJ9BL1RB/LLt1JDfPGQL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="21641595"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="21641595"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 04:01:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="9219180"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.173.205]) ([10.249.173.205])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 04:01:51 -0800
Message-ID: <eb7dc225-d7e3-471f-9758-b03089be5a3f@linux.intel.com>
Date: Tue, 5 Mar 2024 20:01:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>, Eric Badger <ebadger@purestorage.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] iommu: Fix domain check on release
Content-Language: en-US
To: Joerg Roedel <joro@8bytes.org>
References: <20240305013305.204605-1-baolu.lu@linux.intel.com>
 <ZebPsvHQWJcOgmUW@8bytes.org>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZebPsvHQWJcOgmUW@8bytes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/3/5 15:54, Joerg Roedel wrote:
> On Tue, Mar 05, 2024 at 09:33:00AM +0800, Lu Baolu wrote:
>> It fixes a NULL pointer dereference issue in the Intel iommu driver and
>> strengthens the iommu core to possibly prevent similar failures in other
>> iommu drivers.
> Please send me another pull request once you consider this ready. I
> guess it is v6.9 material.

Sure. I will queue this series in a pull request.

Best regards,
baolu

