Return-Path: <linux-kernel+bounces-159243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE6B8B2B5A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 23:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ABE2281D0F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 21:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566B3155A4F;
	Thu, 25 Apr 2024 21:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cxskvaVk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A138152526;
	Thu, 25 Apr 2024 21:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714081918; cv=none; b=PJWTB7aThL65ue6JOo/yeUZBnRMJ3uwxovIfHHFqtHnHJ7E1TL+rekVa1oqGqIa9FZOM1xQBpy3WiaDi2CeNx9YQdbuhTR7MaXhGkjPVNlNodHl6NuIyRbJPMSNol09XqaF+YcclJwZsX57mTmF7k4jcoQAUkRQAK6Q2t/SxJVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714081918; c=relaxed/simple;
	bh=x+dBzqNSH49rZazhRf4nqK+tLEJjJqmYYDFM1eu5ETs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eS5wT4LwQ5c23ndf6+pKYt+1tL1xLF5efvJZd4KaoeWFu7ECieMQzYRYeUQ2y2GfiIh91IqKWcQCU6nw5Bu9vfTeVXQTFYpttFaHHPNl1aEvs14/zDKeVZWhsg6hLlzJ1lSifdYmC32ktTUuBkKegdppSmwo7a3T5ruyEtmKCjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cxskvaVk; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714081918; x=1745617918;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=x+dBzqNSH49rZazhRf4nqK+tLEJjJqmYYDFM1eu5ETs=;
  b=cxskvaVkGvvKVhPLWzJAAimwTVJ5Xo5Qe6Ewu9wH2vFJvGzTU5G8PSbi
   PRpM/VXSUY4yyxypL6W6MDio2TleC3rpoMBwBkwaE7USrP9f6jqKJHC1U
   SV9NLE5WSREqaF1adhVC+6sJiSktt9xg6O69GHdPmV/EgX2SDz5wwTMuo
   rcygdZpl9ti1VnjU22OCwVrdUK1fNEKqdv5daVN6zcrNTyxq4lNdKZ/E6
   U5pFW2Y4rkehEMNTfpp6dUdlNizG/9HsbyL7sx09vwDf0FSVWjbMrtesq
   tWgDV1/MILnUJPGvz1aT09Mlo8GcAx7+U2bjybqOeG7Fe+/OW8CivAM1P
   Q==;
X-CSE-ConnectionGUID: +5ILbMkmSuGW0THV7ZyCew==
X-CSE-MsgGUID: WxaTiXdvR6mgP8/e0A0vmg==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="20952678"
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="20952678"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 14:51:56 -0700
X-CSE-ConnectionGUID: u7et1VtPTn+s4+O2D7fzWg==
X-CSE-MsgGUID: IfshLvBcT+Kec7dLt4kotA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="25208713"
Received: from mmubarik-mobl3.amr.corp.intel.com (HELO [10.212.65.9]) ([10.212.65.9])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 14:51:55 -0700
Message-ID: <3cf80056-e62d-4be1-9716-4c843ae2f88c@linux.intel.com>
Date: Thu, 25 Apr 2024 14:51:42 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: dell-laptop: Implement platform_profile
To: Mario Limonciello <mario.limonciello@amd.com>,
 Lyndon Sanche <lsanche@lyndeno.ca>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, =?UTF-8?Q?Pali_Roh=C3=A1r?=
 <pali@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dell.Client.Kernel@dell.com
References: <20240425172758.67831-1-lsanche@lyndeno.ca>
 <a6009bed-aa34-4a3f-91f5-23937e915132@amd.com>
 <24c7a9ea-7755-4270-a338-4701c8e262e2@app.fastmail.com>
 <ae6a5b66-86e9-44cd-8484-1d218e7bc72c@amd.com>
Content-Language: en-US
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
In-Reply-To: <ae6a5b66-86e9-44cd-8484-1d218e7bc72c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/25/24 13:28, Mario Limonciello wrote:
> On 4/25/2024 15:24, Lyndon Sanche wrote:
>> On Thu, Apr 25, 2024, at 2:07 PM, Mario Limonciello wrote:
>>> + Srinivas
>>>
>>> On 4/25/2024 12:27, Lyndon Sanche wrote:
>>>> Some Dell laptops support configuration of preset
>>>> fan modes through smbios tables.
>>>>
>>>> If the platform supports these fan modes, set up
>>>> platform_profile to change these modes. If not
>>>> supported, skip enabling platform_profile.
>>>>
>>>> Signed-off-by: Lyndon Sanche <lsanche@lyndeno.ca>
>>>> ---
>>>
>>> When you developed this was it using a Dell Intel or Dell AMD system?
>>>
>>> If it was an Intel system, did you test it with thermald installed and
>>> active?
>>>
>>> I'm wondering how all this stuff jives with the stuff that thermald
>>> does.  I don't know if they fight for any of the same "resources".
>>
>> Thank you for your response.
>>
>> I did my development and testing on a Dell Intel system. Specifically 
>> the XPS 15 9560 with i7-7700HQ.
>>
>> I do have thermald running, though I admit I am not really aware of 
>> what exactly it does, besides being related to thermals in some way.
>>
>> I normally set the thermal mode with Dell's smbios-thermal-ctl 
>> program. I am not too sure all the values that the bios configures on 
>> it's own depending on the provided mode, so I am not sure if thermald 
>> conflicts. But my understanding is that would be out of scope of this 
>> driver, since we are only telling the bios what we want at a high level.
>>
>> Lyndon
>
> Yeah it's not say it's a "new" conflict, it would just become a lot 
> more prevalent since software like GNOME and KDE use 
> power-profiles-daemon to manipulate the new power profile you're 
> exporting from the driver.
>
> If there really is no conflict, then great!
> If there is a conflict then I was just wondering if there needs to be 
> an easy way to turn on/off the profile support when thermald is in use.

This shouldn't be in conflict as this should be directly changing some 
settings in BIOS. BIOS should send some notification, if it wants some 
changes in thermal tables used by thermald.


Thanks,

Srinivas



