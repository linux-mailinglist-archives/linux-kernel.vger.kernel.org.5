Return-Path: <linux-kernel+bounces-33331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD365836878
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4439E1F21152
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB63612DC;
	Mon, 22 Jan 2024 15:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jkm+2wHU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22281482C4
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 15:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935906; cv=none; b=VqrKa3tyOsZAZV4Y3idLpdSKm+HwYrwsSi/xN5eS3em6XyXDqDVHYLgCWYvj2fPJDmm9pjSAPniTOB+oow5uUAcsfQ4VG374k7jrXaTyo1sf4BFtyMLu4akvVr3DW4VhtCZHPPVOW225OuxomY9UsUgpJA/7hK2DqbA30NzugGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935906; c=relaxed/simple;
	bh=jQuHU3SaxaQhCS1YR1LSOojoTHXE2B9LKMjOeqc1Aac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IeEt518OjYUtB+MeIwz51aJsk8gnUTUrgiGmQzDPGxO9Yw5IihEVsc3s5MPQS2F0+thg4EJARpcmpUIHutRTPwsmJ8j0oaBD8ZAGHC6hqsc+iFN8pAbEIApPkcZFTUsVBPSh0q/mvp5LUBHicimpdOCXrMlfpBWPms/pjBTbp0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jkm+2wHU; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705935903; x=1737471903;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jQuHU3SaxaQhCS1YR1LSOojoTHXE2B9LKMjOeqc1Aac=;
  b=jkm+2wHUb6WqqiBJCyUR41M12Xs3t0rM/+GwYhJ0HP6y18ojXEjL9eF5
   WtM7DS8HWk0DkJn6l2vT2InpnOngBftkb05TruiACu1VMSq6OJLQEk+z8
   FC0x/rIl9CFASP0VyPI9w60QsmphcsiMTz1xsaS5c5WeGFazAZLN4jG2V
   +I8Ws4sLkDI3FlCY77LRuHHlkoGx/Llv2hFULHrD+GvM6fd+gDilJsAMo
   3vwzdIJLgFk4NGrcoWwHxxxD/f1EVQi/kuFO69zO9AyR3/iJts6Kqvq8W
   44YmbLhilUYX7tzm4ncD6xHXt2BaCH630ilEveLkk99Ik1J5616YgqkzG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="22706708"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="22706708"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 07:05:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="34062697"
Received: from jmwebb-mobl1.amr.corp.intel.com (HELO [10.251.14.106]) ([10.251.14.106])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 07:04:55 -0800
Message-ID: <4ab80af9-f296-4a45-8d50-35bdaf565631@linux.intel.com>
Date: Mon, 22 Jan 2024 07:04:54 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 3/4] tsm: Allow for mapping RTMRs to TCG TPM PCRs
Content-Language: en-US
To: Samuel Ortiz <sameo@rivosinc.com>, Qinkun Bao <qinkun@google.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org, jiewen.yao@intel.com, ken.lu@intel.com
References: <20240114223532.290550-1-sameo@rivosinc.com>
 <20240114223532.290550-4-sameo@rivosinc.com>
 <1bbf8d3e-aa94-48c7-a1e4-76f9eefc4af7@linux.intel.com>
 <65a72c305291f_3b8e29484@dwillia2-xfh.jf.intel.com.notmuch>
 <5539c533-37b2-4b12-a5c5-056881cf8e3c@linux.intel.com>
 <Za1G9I+tYuIL9ser@vermeer> <90EDEF2B-DB43-413F-840E-3268977FDBD0@google.com>
 <Za4dcowdY84fGF1f@vermeer>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <Za4dcowdY84fGF1f@vermeer>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 1/21/24 11:46 PM, Samuel Ortiz wrote:
> On Sun, Jan 21, 2024 at 06:09:19PM -0800, Qinkun Bao wrote:
>>
>>> On Jan 21, 2024, at 8:31 AM, Samuel Ortiz <sameo@rivosinc.com> wrote:
>>>
>>> On Tue, Jan 16, 2024 at 07:35:30PM -0800, Kuppuswamy Sathyanarayanan wrote:
>>>> On 1/16/24 5:24 PM, Dan Williams wrote:
>>>>> Kuppuswamy Sathyanarayanan wrote:
>>>>>> On 1/14/24 2:35 PM, Samuel Ortiz wrote:
>>>>>>> Many user space and internal kernel subsystems (e.g. the Linux IMA)
>>>>>>> expect a Root of Trust for Storage (RTS) that allows for extending
>>>>>>> and reading measurement registers that are compatible with the TCG TPM
>>>>>>> PCRs layout, e.g. a TPM. In order to allow those components to
>>>>>>> alternatively use a platform TSM as their RTS, a TVM could map the
>>>>>>> available RTMRs to one or more TCG TPM PCRs. Once configured, those PCR
>>>>>>> to RTMR mappings give the kernel TSM layer all the necessary information
>>>>>>> to be a RTS for e.g. the Linux IMA or any other components that expects
>>>>>>> a TCG compliant TPM PCRs layout.
>>>>>>>
>>>>>>> TPM PCR mappings are configured through configfs:
>>>>>>>
>>>>>>> // Create and configure 2 RTMRs
>>>>>>> mkdir /sys/kernel/config/tsm/rtmrs/rtmr0
>>>>>>> mkdir /sys/kernel/config/tsm/rtmrs/rtmr1
>>>>>>> echo 0 > /sys/kernel/config/tsm/rtmrs/rtmr0/index
>>>>>>> echo 1 > /sys/kernel/config/tsm/rtmrs/rtmr1/index
>>>>>>>
>>>>>>> // Map RTMR 0 to PCRs 4, 5, 6, 7 and 8
>>>>>>> echo 4-8 > /sys/kernel/config/tsm/rtmrs/rtmr0/tcg_map
>>>>>>>
>>>>>>> // Map RTMR 1 to PCRs 16, 17 and 18
>>>>>>> echo 16-18 > /sys/kernel/config/tsm/rtmrs/rtmr1/tcg_map
>>>>>> Any information on how this mapping will be used by TPM or IMA ?
>>>>>>
>>>>>> RTMR to PCR mapping is fixed by design, right? If yes, why allow
>>>>>> user to configure it. We can let vendor drivers to configure it, right?
>>>>> I assume the "vendor driver", that publishes the RTMR to the tsm-core,
>>>>> has no idea whether they will be used for PCR emulation, or not. The TPM
>>>>> proxy layer sitting on top of this would know the mapping of which RTMRs
>>>>> are recording a transcript of which PCR extend events.
>>>> My thinking is, since this mapping is ARCH-specific information
>>>> and fixed by design, it makes more sense to hide this detail in the
>>>> vendor driver than letting userspace configure it. If we allow users to
>>>> configure it, there is a chance for incorrect mapping.
>>> I think I agree with the fact that letting users configure that mapping
>>> may be error prone. But I'm not sure this is an architecture specific
>>> mapping, but rather a platform specific one. I'd expect the guest firmware
>>> to provide it through e.g. the MapPcrToMrIndex EFI CC protocol.
>>>
>>> So I agree I should remove the user interface for setting that mapping,
>>> and pass it from the provider capabilities instead. It is then up to the
>>> provider to choose how it'd build that information (hard coded, from
>>> EFI, etc).
>> The UEFI specification has defined the mapping relationship between the 
>> TDX RTMR and TPM PCRs (See https://uefi.org/specs/UEFI/2.10/38_Confidential_Computing.html#intel-trust-domain-extension). The current RTMR implementation in the boot loader 
>> is “hooked” in the implementation for the TPM. 
>>
>> When the bootloader needs to extend the PCR value, it calls 
>> `map_pcr_to_mr_index`  to retrieve the corresponding RTMR index and 
>> then extends the RTMR. Considering this behavior, I don’t think we should
>>  allow users to configure the mappings between the PCR and RTMR. (See https://github.com/rhboot/shim/pull/485/files <https://github.com/rhboot/shim/pull/485/files>).
> Just to be clear: I agree with that and I am going to send a v2 with
> that user interface removed.
> However I believe that we still need the TSM framework to know about
> these mappings and the question is where does the kernel get it from?
>
> You're suggesting that for TDX these mappings are architecturally
> defined, as described by the UEFI spec. For other architectures (CCA,
> CoVE) they are not (yet), so I'm suggesting to leave each TSM provider
> backend decide how the PCR to RTMR mapping should be built/fetched and
> provide it to the TSM framework through the tsm_capabilities structure
> that this patchset introduces. The TDX implementation could decide to
> hardcode it to the UEFI specification.

Agree. Lets leave it to TSM vendor drivers to provide this
mapping.


> Cheers,
> Samuel.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


