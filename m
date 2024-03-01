Return-Path: <linux-kernel+bounces-89099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF1286EA6C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 189481C2286A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C55D3C492;
	Fri,  1 Mar 2024 20:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hscPwgTO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40FEC132;
	Fri,  1 Mar 2024 20:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709325619; cv=none; b=bVOz/KMtcBXdSJS8oNlbuXeID/IvCCId0Hh/cyZJ7JZLVFaRBpe4H54sykKmSCs5jBs8yQslIa6MtWlrkqM05cl9U1Mw5fK/8yMm9UQTkOBBzoTNjTwwvDNvR+U/tQWZzhJkW99Q0L16rGlch1qk6jVpQD89Krf7sYZoAJkQzR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709325619; c=relaxed/simple;
	bh=ZwhwYeZHjwCE+vDRa8E+VJ06lF+5Z0Wtom9hTPOPs8M=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Wamq6H8UYhky78iDOLTJwrc4JLT3zP6SR2PlwzTLMWS47VdHM6fouujT3c1Jn6g2URdrjWKAJf0cYMxn5Tud9Ob5si7y3numYMpI/upFaRfxg/qR38xHoSz5W8Ui0JDOKQX9Esj3dxHVGfnHesM7zqFzAzUDU9ejtaBcQAXLplg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hscPwgTO; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709325619; x=1740861619;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ZwhwYeZHjwCE+vDRa8E+VJ06lF+5Z0Wtom9hTPOPs8M=;
  b=hscPwgTOcCkqnNF0Z4n5cAm4OhXl2w0iVRENYarPm4cWNu8b4+kMAfog
   +RMVmVH9OX+yRaiPAjKjkE7+UjyxMTrou+Vi+Vj7vLa6ectjRGDbNjXYI
   CiYpHZaQH2tveb9IPiDo5Az00Gu9Ui1tuWOf8pZ7aQV80n6c+1OOc5MIz
   wDjXNSX0dmY8fOC3dC8+SKA6te9CACC5HqH9osdzh9Vpr4tXqQw2FOMDI
   x2XLkijVunz8CG/k6w9LqonkOv5+rSsh8K7bfIVlfB9XVH7Rw9e4JrS9n
   iz8pKwURewsy1gbjPD6vDEh3441w0F5DGsfUdZ7V8lQCu9p+9yhzVYduO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="4000389"
X-IronPort-AV: E=Sophos;i="6.06,197,1705392000"; 
   d="scan'208";a="4000389"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 12:40:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,197,1705392000"; 
   d="scan'208";a="8243052"
Received: from sj-4150-psse-sw-opae-dev2.sj.intel.com ([10.233.115.162])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 12:40:17 -0800
Date: Fri, 1 Mar 2024 12:39:24 -0800 (PST)
From: matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@sj-4150-psse-sw-opae-dev2
To: Xu Yilun <yilun.xu@linux.intel.com>
cc: hao.wu@intel.com, trix@redhat.com, mdf@kernel.org, yilun.xu@intel.com, 
    linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fpga: dfl: afu: support Rev 2 of DFL Port feature
In-Reply-To: <ZdYhUK5yFFlhVV62@yilunxu-OptiPlex-7050>
Message-ID: <alpine.DEB.2.22.394.2403011142350.240045@sj-4150-psse-sw-opae-dev2>
References: <20240125233715.861883-1-matthew.gerlach@linux.intel.com> <ZbjHl8ptQG5FdHvC@yilunxu-OptiPlex-7050> <alpine.DEB.2.22.394.2401300948590.112016@sj-4150-psse-sw-opae-dev2> <Zbnd8W1ciTKeoKc4@yilunxu-OptiPlex-7050> <alpine.DEB.2.22.394.2401311610020.112016@sj-4150-psse-sw-opae-dev2>
 <ZcBIjcFJjGKf0qcO@yilunxu-OptiPlex-7050> <alpine.DEB.2.22.394.2402051600190.122158@sj-4150-psse-sw-opae-dev2> <ZdF4JvYQQL8irnbW@yilunxu-OptiPlex-7050> <alpine.DEB.2.22.394.2402201658400.191484@sj-4150-psse-sw-opae-dev2>
 <ZdYhUK5yFFlhVV62@yilunxu-OptiPlex-7050>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed



[snip]

>>
>> Hi Yilun,
>>
>> I think this conversation has gotten a little off track. This patch only
>> changes the port reset behavior at driver initialization for revision 2 of
>> the port IP. The behavior and the requirements of port reset during run time
>> have not changed. The existing implementation requires the user performing
>> the port reset to ensure appropriate SW was quiesced. This patch does not
>> change this requirement.
>
> You are actually adding support to the new devices behavior defined by
> revision 2.  Previously the user requires the management PF driver to do port
> reset, and this only affects some logic in the PF itself and the impact could
> be handled inside the driver.  The current PF driver doesn't actually do anything
> because it (or any kernel component) never touches the disabled logic, and the
> user accessing of the mmapped but disabled logic won't cause system issues.

I'm wondering about the use case when Virtual Functions (VFs) 
are enabled with the current driver. If partial reconfiguration of the port 
occurs, which includes a reset, what happens to the user software attached 
to the VFs when the hardware has changed out from under it? While the 
current port implementation won't cause PCIe errors when the logic is 
disable, something has to notify the user software that the hardware 
changed. I think the user space software would be typically notified of 
the change by the orchestration software performing the partial 
reconfiguration. I think the use case of VFs with the original port 
implementation is logically equivalent to the new port implementation with 
multiple PFs/VFs.

>
> But the new management PF does port reset and affect other PFs, and may
> cause disorder in other drivers. so you need extra code to support the
> behavior.

I think the real problem is that the new port is not doing as good of a 
job preventing PCIe errors during port reset as the previous version.

Matthew
>
> This patch does make some progress, as you said, "With revision 2,the
> initial state of the logic inside the port is guaranteed to be valid, and
> a port reset is not required during driver initialization".  But it
> should not be the only patch to enable the new port reset behavior.
>
>>
>>>
>>>>
>>>>>
>>>>>> image. I don't think the driver performing the port_reset() can know all the
>>>>>
>>>>> Other PF drivers should know their own components. They should be aware
>>>>> that their devices are being reset.
>>>>
>>>> The other PF drivers depend on the actual FPGA image being run.
>>>>
>>>>>
>>>>>> components to be able to provide any meaningful management.
>>>>>
>>>>> If the reset provider and reset consumer are not in the same driver,
>>>>> they should interact with each other. IIRC, some reset controller class
>>>>> works for this purpose.
>>>>
>>>> The other PFs in many cases can present as standard devices with existing
>>>> drivers like virtio-net or virtio-blk. It does not seem desireable to have
>>>> to change existing drivers for a particular FPGA implementation
>>>
>>> If you have to use a specific method for reset, it is not a standard virtio
>>> pci device, and you have to make some change.
>>
>> From the perspective of the PCI PF/VF implementing the virtio or other
>> standard device, the pci endpoint is completely compliant to the standard,
>> and no driver changes should be required. As mentioned above, this patch
>> does nothing to change any of this behavior. Consider a port reset that is
>> part of a partial configuration flow. The virtio endpoint can become
>> something completely different with a completely different driver. This
>
> Then how could the virtio driver stop and remove itself to avoid crashing the
> kernel, and how could the new driver be probed.  If the answer is still
> userspace responsible for everything, that's not good to me.
>
> Thanks,
> Yilun
>
>> patch does not affect this flow either.
>>
>> Thanks,
>> Matthew
>>
>>>
>>> Thanks,
>>> Yilun
>>>
>>>>
>>>> Thanks,
>>>> Matthew
>>>>>
>>>>> Thanks,
>>>>> Yilun
>>>>>
>>>>>>
>>>>>> Thanks,
>>>>>> Matthew
>>>>>>
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Yilun
>>>>>>>
>>>>>>>>
>>>>>>>> Do you want me to update the commit message with this information?
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Matthew
>>>>>>>
>>>>>>>
>>>>>
>>>>>
>>>
>

