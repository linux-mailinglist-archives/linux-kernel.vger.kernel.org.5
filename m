Return-Path: <linux-kernel+bounces-89967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD0C86F854
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 02:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12FCD1F210A5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 01:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF6717E9;
	Mon,  4 Mar 2024 01:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YuT/mdL0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4088137E
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 01:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709517143; cv=none; b=GEgoO2Zo9VyZmYfjbRNPfU+aRuqiL8FLlm6dpRZ3zIvYixVNS/UAHFMN7IaARHBuK+GorXInDBa20FWnNMy06TznKIWcXJTKDeJWjmpAaz5yFz1MJyLv+/xIqgeQrYZ9DOdNlfIrSRDyg83Rrb/SxHMbjD+KBcq1eCPXjd1xo+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709517143; c=relaxed/simple;
	bh=ryzVKDVJdRXkf1w4Nn2pTtkFqNfXCs5KG7YB8Xq9NNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YQqnLpQouZo8jgFS9puHRBSYc3ynex1triQCxNTCDqXGRTGHtTZ1BqROGJ5GGEJTAuEuxgSaNWJTZs7MSkW1avuZWN5C5nPLgxH+s5/PdMeWKRD1B1/7szRnTdZ8DkaZ4StztGv1wwmiwZfG2mJIbroAcz26Em1bKXL3LTPQltI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YuT/mdL0; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709517142; x=1741053142;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ryzVKDVJdRXkf1w4Nn2pTtkFqNfXCs5KG7YB8Xq9NNY=;
  b=YuT/mdL0Rnsh59l/3+PxiitkclG/IkJxwlFFmfwPgwd5rPr8aadKzYUL
   bMNIg2ELCWaSF8cP/fPR/FqV8orIv8ynGSwnSxXcOg0KSJYjUFtkCC4pL
   oSugJgqgApBp/M8IpyQdzaZ9qgVHrLkzIEO3KuseTEcoBHgdAqbK4DxwC
   UD809foFG55DVWqeI8v2S4UsPj+M72BPkE9Mhk137mUyXvXs3ISDrKNTB
   lEqLQTDIDY4cE9ElasH1qWCd2vJ3+KIdrJH/6I3X+UMXgvY6Fd1RC4Rha
   R5k4EDkeA+aNpyfKJ4gk2a2tMSnlewFvu95V7j/N4qVOB//WRJ6sxa0WC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="4157284"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="4157284"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2024 17:52:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="13495543"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.124.229.115]) ([10.124.229.115])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2024 17:52:17 -0800
Message-ID: <82f5aa96-ddf8-4ba4-a8f6-9bf099caadad@linux.intel.com>
Date: Mon, 4 Mar 2024 09:52:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/vt-d: avoid sending explicit ATS invalidation
 request to released device
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: baolu.lu@linux.intel.com, bhelgaas@google.com, robin.murphy@arm.com,
 jgg@ziepe.ca, kevin.tian@intel.com, dwmw2@infradead.org, will@kernel.org,
 lukas@wunner.de, yi.l.liu@intel.com, dan.carpenter@linaro.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240301215630.GA409512@bhelgaas>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <20240301215630.GA409512@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/2/2024 5:56 AM, Bjorn Helgaas wrote:
> On Fri, Mar 01, 2024 at 09:50:36AM +0800, Ethan Zhao wrote:
>> On 3/1/2024 5:06 AM, Bjorn Helgaas wrote:
>>> On Wed, Feb 28, 2024 at 10:31:38PM -0500, Ethan Zhao wrote:
>>>> The introduction of per iommu device rbtree also defines the lifetime of
>>>> interoperation between iommu and devices, if the device has been released
>>>> from device rbtree, no need to send ATS invalidation request to it anymore,
>>>> thus avoid the possibility of later ITE fault to be triggered.
>>>>
>>>> This is part of the followup of prior proposed patchset
>>>>
>>>> https://do-db2.lkml.org/lkml/2024/2/22/350
>>> Please use https://lore.kernel.org/ URLs instead.  This one looks like
>>> https://lore.kernel.org/r/20240222090251.2849702-1-haifeng.zhao@linux.intel.com/
>>>
>>>> To make sure all the devTLB entries to be invalidated in the device release
>>>> path, do implict invalidation by fapping the E bit of ATS control register.
>>>> see PCIe spec v6.2, sec 10.3.7 implicit invalidation events.
>>> s/implict/implicit/
>>>
>>> s/fapping/?/  (no idea :)  "flipping"?  Oh, probably "flapping" per the
>>> comment below.  But I think "flapping" is ambiguous; "setting" would be
>>> better)
>> Yup, like the memory bit flipping, no idea what is the right word,
>> setting one bit to 0, then 1, then back to 0. perhaps details the
>> setting action 0-->1-->0 ?
> In PCIe spec-speak, "Set" means "assign 1 to this", and "Clear" means
> "assign 0 to this".
>
> Maybe you could copy the spec language like this:
>
>    Invalidate all ATC entries by changing the E field in the ATS
>    Capability from Clear to Set, which causes an implicit invalidation
>    event.

Fair enough.

Thanks,
Ethan

>
> Bjorn
>

