Return-Path: <linux-kernel+bounces-28500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C80182FF4E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 04:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AD4E1C23D95
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 03:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C574690;
	Wed, 17 Jan 2024 03:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EfAnh+YB"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B281C11
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 03:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705462533; cv=none; b=CxO2nrAhQ6/f83SygRpp6N+dhIFQqEGV4FK4Lfu/OP0BMAz3JJMpKGCsRKZ0lRm16ctYtAdMefyQKoJsG+DLHK7ESaKtorAO4MV9iz8rVRMaKnqS1xPlkWygcO2sNTCiMejk2taLE8UQIBREJfa8X5wlo19DnFG7T7TEV2AIvvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705462533; c=relaxed/simple;
	bh=9nDQIlSt6xsOi7mqkg97CDkr7r22IzuP+v40N6vIppI=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding; b=N797rlhKrluc02hsldINGDrgGvgTbHyaeo1aXMr7Sl5G4v7xwxh9BAT2KI46N38Y17tonboDh/LxzgPxQ81ZXdVsE/0SusFuzPaRKCdKvjbMjOR2apN7TH54alAix0frG48nfMuPbjNRJELJuoeD7bRtrCpA5nriBDwJRINlnwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EfAnh+YB; arc=none smtp.client-ip=192.55.52.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705462532; x=1736998532;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9nDQIlSt6xsOi7mqkg97CDkr7r22IzuP+v40N6vIppI=;
  b=EfAnh+YByIDbg3afghsVof4R8XNwgQZnewsL1ywNj5z8hMPrO/ZM4qYW
   pBP/n1Q8YpDsrdbQxdKtIEPjrujGqFJ8C5gQGNtgXKCZz2H4zQLyvqP/a
   BQ6tTwp0tT1sxHEjPwhJXzoEQzVMrkpOZhZa7fL45I2GC7tod/XCGYRHu
   ggyxuq65JMkmpnJXpprjVyZu0lfrMZLUEKDygX9PHQDLQXIiqx+S1Gf5L
   DdxS1mMu/DyOdX/FTfu6uZCfjnGym24TrfWudXM2AP/PtAf74YBKh6+o0
   nMAwZAH7UiVrfGXEVyBFelpQWW8xyE0dIDRQ4CfN08eCmBJL+yxrD/SQc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="486213920"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="486213920"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 19:35:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="18694093"
Received: from kogunron-mobl1.amr.corp.intel.com (HELO [10.209.49.98]) ([10.209.49.98])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 19:35:30 -0800
Message-ID: <5539c533-37b2-4b12-a5c5-056881cf8e3c@linux.intel.com>
Date: Tue, 16 Jan 2024 19:35:30 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 3/4] tsm: Allow for mapping RTMRs to TCG TPM PCRs
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, Samuel Ortiz <sameo@rivosinc.com>
Cc: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240114223532.290550-1-sameo@rivosinc.com>
 <20240114223532.290550-4-sameo@rivosinc.com>
 <1bbf8d3e-aa94-48c7-a1e4-76f9eefc4af7@linux.intel.com>
 <65a72c305291f_3b8e29484@dwillia2-xfh.jf.intel.com.notmuch>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <65a72c305291f_3b8e29484@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 1/16/24 5:24 PM, Dan Williams wrote:
> Kuppuswamy Sathyanarayanan wrote:
>> On 1/14/24 2:35 PM, Samuel Ortiz wrote:
>>> Many user space and internal kernel subsystems (e.g. the Linux IMA)
>>> expect a Root of Trust for Storage (RTS) that allows for extending
>>> and reading measurement registers that are compatible with the TCG TPM
>>> PCRs layout, e.g. a TPM. In order to allow those components to
>>> alternatively use a platform TSM as their RTS, a TVM could map the
>>> available RTMRs to one or more TCG TPM PCRs. Once configured, those PCR
>>> to RTMR mappings give the kernel TSM layer all the necessary information
>>> to be a RTS for e.g. the Linux IMA or any other components that expects
>>> a TCG compliant TPM PCRs layout.
>>>
>>> TPM PCR mappings are configured through configfs:
>>>
>>> // Create and configure 2 RTMRs
>>> mkdir /sys/kernel/config/tsm/rtmrs/rtmr0
>>> mkdir /sys/kernel/config/tsm/rtmrs/rtmr1
>>> echo 0 > /sys/kernel/config/tsm/rtmrs/rtmr0/index
>>> echo 1 > /sys/kernel/config/tsm/rtmrs/rtmr1/index
>>>
>>> // Map RTMR 0 to PCRs 4, 5, 6, 7 and 8
>>> echo 4-8 > /sys/kernel/config/tsm/rtmrs/rtmr0/tcg_map
>>>
>>> // Map RTMR 1 to PCRs 16, 17 and 18
>>> echo 16-18 > /sys/kernel/config/tsm/rtmrs/rtmr1/tcg_map
>> Any information on how this mapping will be used by TPM or IMA ?
>>
>> RTMR to PCR mapping is fixed by design, right? If yes, why allow
>> user to configure it. We can let vendor drivers to configure it, right?
> I assume the "vendor driver", that publishes the RTMR to the tsm-core,
> has no idea whether they will be used for PCR emulation, or not. The TPM
> proxy layer sitting on top of this would know the mapping of which RTMRs
> are recording a transcript of which PCR extend events. 

My thinking is, since this mapping is ARCH-specific information
and fixed by design, it makes more sense to hide this detail in the
vendor driver than letting userspace configure it. If we allow users to
configure it, there is a chance for incorrect mapping.

Regarding the TPM proxy, I am still not clear how it is going to use
this mapping. If we want to provide TPM like feature, it needs a
special kernel TPM driver, right? Even if we enable TPM support
with RTMR, I assume it can only support pcr_extend(). Other TPM
features should be disabled. If yes, since we already have this ABI
for measurement extension, why again support it via TPM or did
I misunderstand the use case.

>
> For IMA the situation is different because that can be a kernel internal
> configuration flow without need to involve userspace.
>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


