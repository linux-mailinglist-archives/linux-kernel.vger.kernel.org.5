Return-Path: <linux-kernel+bounces-56785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 851D484CF28
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B767C1C26BCA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22DA7C08C;
	Wed,  7 Feb 2024 16:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HUe7EqeK"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468041E498;
	Wed,  7 Feb 2024 16:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707324058; cv=none; b=CTl0sg/F4wSZbo4X8438gw9VlB6BOEC6Mi9jIYu0+yMvxqyjpmOWD661S64sr9lyALA5Eaiga0GYImCMay937moskB6FxcXLAkQoV48n2sMqcU+ifwcPeRITPqbpPvQSiRPMt7CAOUBgR0f2W+z6UFXyMGil0uBlHMp25IKFa8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707324058; c=relaxed/simple;
	bh=66AduItov+Ar031GsDXa/BoNmYe2A6qwD+bgC4xBNLE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Crie2QH1vBexV6aEHuUm4+1xkcMC0QO/ExZEhNpYLQx5MzhmNUAhDVDhcIoQaWOaef+RT+vkgYwMyYuT16MkTNZnuIMlnVw283fN4NIDNIktUwDubgIqY0uKk/JR0ZqsN9Z9/iX1E0FokH19ylPr0a9DUD4KSAd+oB2ID1YVa60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HUe7EqeK; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707324056; x=1738860056;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=66AduItov+Ar031GsDXa/BoNmYe2A6qwD+bgC4xBNLE=;
  b=HUe7EqeKR41B2RDCUG5/fd+Zrjs/xIcOYNkS3Gu84EPKuLXix+okt839
   HYqXtEyVP+9lmxLs7IhgbtYM+KatmmmshN42oMYS5A335kMhmwqrXmJDe
   vQe9Tr/NfOJhGxne/frymIkBqTWAjcAHEDBPj/Yb7Naxq8K9+UHTUjIdM
   MqpwcHYqGEin0UAMuByCdB4FSHMkZ1Kyogmmz2wnLtzgds8pAm27he9m5
   83aNqizqz7i4ePJDYeXS3mHeHC84E2idFG9O7S4U0+H2WUb/Hih77XMtm
   V6BOFUTTlAZwHRbHJYrwCCW65bvyRu5ep3XjO/G9K3MlzKI83F8O7YPqG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="436161675"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="436161675"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 08:40:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="1402855"
Received: from sj-4150-psse-sw-opae-dev2.sj.intel.com ([10.233.115.162])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 08:40:55 -0800
Date: Wed, 7 Feb 2024 08:40:55 -0800 (PST)
From: matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@sj-4150-psse-sw-opae-dev2
To: Xu Yilun <yilun.xu@linux.intel.com>
cc: hao.wu@intel.com, trix@redhat.com, mdf@kernel.org, yilun.xu@intel.com, 
    linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fpga: dfl: afu: support Rev 2 of DFL Port feature
In-Reply-To: <ZcBIjcFJjGKf0qcO@yilunxu-OptiPlex-7050>
Message-ID: <alpine.DEB.2.22.394.2402051600190.122158@sj-4150-psse-sw-opae-dev2>
References: <20240125233715.861883-1-matthew.gerlach@linux.intel.com> <ZbjHl8ptQG5FdHvC@yilunxu-OptiPlex-7050> <alpine.DEB.2.22.394.2401300948590.112016@sj-4150-psse-sw-opae-dev2> <Zbnd8W1ciTKeoKc4@yilunxu-OptiPlex-7050> <alpine.DEB.2.22.394.2401311610020.112016@sj-4150-psse-sw-opae-dev2>
 <ZcBIjcFJjGKf0qcO@yilunxu-OptiPlex-7050>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed



On Mon, 5 Feb 2024, Xu Yilun wrote:

> On Wed, Jan 31, 2024 at 04:26:27PM -0800, matthew.gerlach@linux.intel.com wrote:
>>
>>
>> On Wed, 31 Jan 2024, Xu Yilun wrote:
>>
>>> On Tue, Jan 30, 2024 at 10:00:16AM -0800, matthew.gerlach@linux.intel.com wrote:
>>>>
>>>>
>>>> On Tue, 30 Jan 2024, Xu Yilun wrote:
>>>>
>>>>> On Thu, Jan 25, 2024 at 03:37:15PM -0800, Matthew Gerlach wrote:
>>>>>> Revision 2 of the Device Feature List (DFL) Port feature
>>>>>> adds support for connecting the contents of the port to
>>>>>> multiple PCIe Physical Functions (PF).
>>>>>>
>>>>>> This new functionality requires changing the port reset
>>>>>> behavior during FPGA and software initialization from
>>>>>> revision 1 of the port feature. With revision 1, the initial
>>>>>> state of the logic inside the port was not guaranteed to
>>>>>> be valid until a port reset was performed by software during
>>>>>> driver initialization. With revision 2, the initial state
>>>>>> of the logic inside the port is guaranteed to be valid,
>>>>>> and a port reset is not required during driver initialization.
>>>>>>
>>>>>> This change in port reset behavior avoids a potential race
>>>>>> condition during PCI enumeration when a port is connected to
>>>>>> multiple PFs. Problems can occur if the driver attached to
>>>>>> the PF managing the port asserts reset in its probe function
>>>>>> when a driver attached to another PF accesses the port in its
>>>>>> own probe function. The potential problems include failed or hung
>>>>>
>>>>> Only racing during probe functions? I assume any time port_reset()
>>>>> would fail TLPs for the other PF. And port_reset() could be triggered
>>>>> at runtime by ioctl().
>>>>
>>>> Yes, a port_reset() triggered by ioctl could result in failed TLP for the
>>>> other PFs. The user space SW performing the ioctl needs to ensure all PFs
>>>> involved are properly quiesced before the port_reset is performed.
>>>
>>> How would user get an insight into other PF drivers to know everything
>>> is quiesced?  I mean do we need driver level management for this?
>>
>> Since this is an FPGA, the number of other PFs and the drivers bound to
>> those PFs depends on the FPGA image. There would also be user space software
>> stacks involved with the other PFs as well. The user would have to ensure
>> all the SW stacks and drivers are quiesced as appropriate for the FPGA
>
> User may not know everything about the device, they only get part of the
> controls that drivers grant. This is still true for vfio + userspace
> drivers.

A user performing a port reset would have to know the impact to the 
specific FPGA image being run in order to ensure all SW stacks are ready 
for the reset.

>
>> image. I don't think the driver performing the port_reset() can know all the
>
> Other PF drivers should know their own components. They should be aware
> that their devices are being reset.

The other PF drivers depend on the actual FPGA image being run.

>
>> components to be able to provide any meaningful management.
>
> If the reset provider and reset consumer are not in the same driver,
> they should interact with each other. IIRC, some reset controller class
> works for this purpose.

The other PFs in many cases can present as standard devices with existing 
drivers like virtio-net or virtio-blk. It does not seem desireable 
to have to change existing drivers for a particular FPGA implementation

Thanks,
Matthew
>
> Thanks,
> Yilun
>
>>
>> Thanks,
>> Matthew
>>
>>>
>>> Thanks,
>>> Yilun
>>>
>>>>
>>>> Do you want me to update the commit message with this information?
>>>>
>>>> Thanks,
>>>> Matthew
>>>
>>>
>
>

