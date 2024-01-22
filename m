Return-Path: <linux-kernel+bounces-34228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D955B8375E1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 23:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90CB21F251EE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794294878C;
	Mon, 22 Jan 2024 22:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fuybMpwo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56270482E2
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 22:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705961531; cv=none; b=eGaAjisRBrt/OJa1oyYfvVPf1S4TeOSJTdt2lK76VF2sOKMA4utmrDgNoNXhdQJ7mRJnbCaJFT11PUJLCYsHYL6aqu4AVQv1SCetmtidzUU6Fvskl3OqSOlNHtx1xykPSctmrxfnW0mXtFnT+WVRS0xfBTR2GnRDgFU06pZM4A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705961531; c=relaxed/simple;
	bh=eWQXk0sfcnAQS723Yb4pigupSKjfFt31ay1qJ/1xMKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W8eo7EjHZIvCPqkEuEZcBYisir1LK5ozPWmbvDRAbTgigHwgxiEU4gAoizpBGMgSK5+sMzzWC9nVgFHcEnJnCJR08cF9GXOcNXNOHbsq2yHPHGaMCADN33MpgTVJqKNkdaZCasUh228ySg2PF4TEyjOOwFdIX1YXUIpKu7CAK7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fuybMpwo; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705961530; x=1737497530;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eWQXk0sfcnAQS723Yb4pigupSKjfFt31ay1qJ/1xMKE=;
  b=fuybMpwoDcgYsYu1BfNuufI2Nh5Pg+8uB2SlvM1G6WjoLMgEH9c7E7Jq
   74ob4FTe5wHTanoMAxmET9uIHyhl8bxUfDZubLsiQfR6sycIXSYicLUFy
   ycx9nPXdxphoOcaSsYuF2L/ThWyMEaiSxaA9nEXj8WxK3LsvS/1lXVZSk
   qceO/qfu1Wki8GaKZlSEj1DVGe2g1bb7sRHNF+EORafyl27KGDhVQW1xC
   OaGOZDlCjor4laUARDbZRI/ylNY0UVlgJKm/CHx1lrcuoEfGmucEqv4Xf
   2hX2Z2dOHhy3wf0imZDyqkfHYxG4oC2VYIWwtNtY4xO5yvDa/JQAmueZt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="1194488"
X-IronPort-AV: E=Sophos;i="6.05,212,1701158400"; 
   d="scan'208";a="1194488"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 14:12:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="929121025"
X-IronPort-AV: E=Sophos;i="6.05,212,1701158400"; 
   d="scan'208";a="929121025"
Received: from sjbowden-mobl1.amr.corp.intel.com (HELO [10.209.73.34]) ([10.209.73.34])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 14:12:09 -0800
Message-ID: <2bd7c80b-9cd8-4450-a410-c3739d224167@linux.intel.com>
Date: Mon, 22 Jan 2024 14:12:08 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 3/4] tsm: Allow for mapping RTMRs to TCG TPM PCRs
Content-Language: en-US
To: Samuel Ortiz <sameo@rivosinc.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240114223532.290550-1-sameo@rivosinc.com>
 <20240114223532.290550-4-sameo@rivosinc.com>
 <1bbf8d3e-aa94-48c7-a1e4-76f9eefc4af7@linux.intel.com>
 <65a72c305291f_3b8e29484@dwillia2-xfh.jf.intel.com.notmuch>
 <5539c533-37b2-4b12-a5c5-056881cf8e3c@linux.intel.com>
 <Za1G9I+tYuIL9ser@vermeer>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <Za1G9I+tYuIL9ser@vermeer>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 1/21/24 8:31 AM, Samuel Ortiz wrote:
> On Tue, Jan 16, 2024 at 07:35:30PM -0800, Kuppuswamy Sathyanarayanan wrote:
>> On 1/16/24 5:24 PM, Dan Williams wrote:
>>> Kuppuswamy Sathyanarayanan wrote:
>>>> On 1/14/24 2:35 PM, Samuel Ortiz wrote:
>>>>> Many user space and internal kernel subsystems (e.g. the Linux IMA)
>>>>> expect a Root of Trust for Storage (RTS) that allows for extending
>>>>> and reading measurement registers that are compatible with the TCG TPM
>>>>> PCRs layout, e.g. a TPM. In order to allow those components to
>>>>> alternatively use a platform TSM as their RTS, a TVM could map the
>>>>> available RTMRs to one or more TCG TPM PCRs. Once configured, those PCR
>>>>> to RTMR mappings give the kernel TSM layer all the necessary information
>>>>> to be a RTS for e.g. the Linux IMA or any other components that expects
>>>>> a TCG compliant TPM PCRs layout.
>>>>>
>>>>> TPM PCR mappings are configured through configfs:
>>>>>
>>>>> // Create and configure 2 RTMRs
>>>>> mkdir /sys/kernel/config/tsm/rtmrs/rtmr0
>>>>> mkdir /sys/kernel/config/tsm/rtmrs/rtmr1
>>>>> echo 0 > /sys/kernel/config/tsm/rtmrs/rtmr0/index
>>>>> echo 1 > /sys/kernel/config/tsm/rtmrs/rtmr1/index
>>>>>
>>>>> // Map RTMR 0 to PCRs 4, 5, 6, 7 and 8
>>>>> echo 4-8 > /sys/kernel/config/tsm/rtmrs/rtmr0/tcg_map
>>>>>
>>>>> // Map RTMR 1 to PCRs 16, 17 and 18
>>>>> echo 16-18 > /sys/kernel/config/tsm/rtmrs/rtmr1/tcg_map
>>>> Any information on how this mapping will be used by TPM or IMA ?
>>>>
>>>> RTMR to PCR mapping is fixed by design, right? If yes, why allow
>>>> user to configure it. We can let vendor drivers to configure it, right?
>>> I assume the "vendor driver", that publishes the RTMR to the tsm-core,
>>> has no idea whether they will be used for PCR emulation, or not. The TPM
>>> proxy layer sitting on top of this would know the mapping of which RTMRs
>>> are recording a transcript of which PCR extend events. 
>> My thinking is, since this mapping is ARCH-specific information
>> and fixed by design, it makes more sense to hide this detail in the
>> vendor driver than letting userspace configure it. If we allow users to
>> configure it, there is a chance for incorrect mapping.
> I think I agree with the fact that letting users configure that mapping
> may be error prone. But I'm not sure this is an architecture specific
> mapping, but rather a platform specific one. I'd expect the guest firmware
> to provide it through e.g. the MapPcrToMrIndex EFI CC protocol.
>
> So I agree I should remove the user interface for setting that mapping,
> and pass it from the provider capabilities instead. It is then up to the
> provider to choose how it'd build that information (hard coded, from
> EFI, etc).
>
>> Regarding the TPM proxy, I am still not clear how it is going to use
>> this mapping. If we want to provide TPM like feature, it needs a
>> special kernel TPM driver, right? Even if we enable TPM support
>> with RTMR, I assume it can only support pcr_extend().
> Extend and read, yes.
>
>> Other TPM
>> features should be disabled. If yes, since we already have this ABI
>> for measurement extension, why again support it via TPM or did
>> I misunderstand the use case.
> I am not sure the TPM compatibility is always needed, but for subsystems
> (like e.g. IMA) that look for a TPM as their root of trust for storage,
> providing the extend+read ABI and the PCR mapping should be sufficient.

My question is, do we even want to expose the PCR-RTMR mapping to the
user? Even if we want to support IMA with RTMR, I think the mapping
needs to be done in the kernel and the userspace does not need to
worry about it.

> Cheers,
> Samuel.
>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


