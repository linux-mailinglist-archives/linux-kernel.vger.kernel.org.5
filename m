Return-Path: <linux-kernel+bounces-52881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC469849DC8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A3721F24F31
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E972C861;
	Mon,  5 Feb 2024 15:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hf6JWvy7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EE52C6AD;
	Mon,  5 Feb 2024 15:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707146074; cv=none; b=TrGmV+4X9TDpZ+ZjVHjSOfJ8pADc4f0Dt5zJRVRzsOdbLh62DC+fo4djWDECA74aIbxRnE8S5gwZaHU97/t3DtSWlGAC9Tiltl+lrfbv5/DVWfIFbRV8AwtJiARyJ4T+uvLbHu/88AqGPVN85dqFoVO/xLC8VhkipIzijBrBVtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707146074; c=relaxed/simple;
	bh=q8z3CzrTGrksXvC58CXDpb8372Ql+5oenU5FI2xdeiQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=rVTBX+PwBTSbi2FBzdo1BiD5MElKDWpR7KgySm/CcdMq0v3gB7gd8dkGpPO0Pca/9megSuR6y4XbB4KMPBJZhKdaW1thFQeQmiomBd1JP1+y0N0evVKasEvbBwvHz+VBrn4c7mzWRK6Zg3UQdLVNiupdT8n/6J2SGROcXgo6dG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hf6JWvy7; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707146073; x=1738682073;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=q8z3CzrTGrksXvC58CXDpb8372Ql+5oenU5FI2xdeiQ=;
  b=hf6JWvy774JDny9i8xrUj1cIpY78533+1KUOCfUGLFRFWlqZl1B2HEro
   Q5mE95YGn0PvOTUt++ooMpzuYU6E0AonNdTTHj3uX5jWlSL/LeS/+LyI/
   rRuHOrKHS7qlxC0fwJtcXasv2gdUlDCYhCv4o8kNxnuw5utZgpNEqj5nJ
   GsjLwHg1Sd1sRrtzqTUBLe4kGGPSe0yLR3LETTSCpgdSfn4Q6gp0hzcrO
   rHKbSadUEiyD6WkregQKw3aK/YfeznvPa4TIv8e1JbuqkndE9E/0azKve
   iu95xoJ/MXpFVdqxCeI3T2iI3K4ccaycRwMx1CHyE/fPdr8/DDo8ljci8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="11276716"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="11276716"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 07:14:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="823881963"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="823881963"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga001.jf.intel.com with ESMTP; 05 Feb 2024 07:14:21 -0800
Message-ID: <e595bcb8-bfc0-aa12-a5c1-a62c5fe9e950@linux.intel.com>
Date: Mon, 5 Feb 2024 17:15:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Content-Language: en-US
To: Paul Menzel <pmenzel@molgen.mpg.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Hans de Goede <hdegoede@redhat.com>
References: <b97d07bf-da27-4576-bed6-fd63e3e0b569@molgen.mpg.de>
From: Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: Linux warning `usb: port power management may be unreliable` on
 Dell XPS 13 9360
In-Reply-To: <b97d07bf-da27-4576-bed6-fd63e3e0b569@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4.2.2024 10.45, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> On the Dell XPS 13 9360, Linux warns:
> 
>      usb: port power management may be unreliable

Is this a new issue, regression?
Was the firmware recently updated?

> 
>      $ lsusb -t
>      /:  Bus 001.Port 001: Dev 001, Class=root_hub, Driver=xhci_hcd/12p, 480M
>          |__ Port 003: Dev 002, If 0, Class=Wireless, Driver=[none], 12M
>          |__ Port 003: Dev 002, If 1, Class=Wireless, Driver=[none], 12M
>          |__ Port 004: Dev 003, If 0, Class=Human Interface Device, Driver=usbhid, 12M
>          |__ Port 005: Dev 004, If 0, Class=Video, Driver=uvcvideo, 480M
>          |__ Port 005: Dev 004, If 1, Class=Video, Driver=uvcvideo, 480M
>      /:  Bus 002.Port 001: Dev 001, Class=root_hub, Driver=xhci_hcd/6p, 5000M
> 
> Enabling dynamic debug with `usbcore.dyndbg=+p` – `dyndbg="file port.c +p"` did not work¹ – the additional messages are:
> 
>      [    1.149417] usb usb2-port1: peered to usb1-port1
>      [    1.150123] usb usb2-port2: peered to usb1-port2
>      [    1.150916] usb usb2-port3: peered to usb1-port6
>      [    1.151621] usb: failed to peer usb2-port4 and usb1-port6 by location (usb2-port4:none) (usb1-port6:usb2-port3)
>      [    1.151634] usb usb2-port4: failed to peer to usb1-port6 (-16)
>      [    1.151642] usb: port power management may be unreliable
>      [    1.152314] usb: failed to peer usb2-port5 and usb1-port6 by location (usb2-port5:none) (usb1-port6:usb2-port3)
>      [    1.152325] usb usb2-port5: failed to peer to usb1-port6 (-16)
>      [    1.153020] usb: failed to peer usb2-port6 and usb1-port6 by location (usb2-port6:none) (usb1-port6:usb2-port3)
>      [    1.153031] usb usb2-port6: failed to peer to usb1-port6 (-16)
>      [    1.153079] usb usb2: port-1 no _DSM function 5
>      [    1.153096] usb usb2: port-2 no _DSM function 5
>      [    1.153111] usb usb2: port-3 no _DSM function 5
>      [    1.153124] usb usb2: port-4 no _DSM function 5
>      [    1.153137] usb usb2: port-5 no _DSM function 5
>      [    1.153151] usb usb2: port-6 no _DSM function 5
>      [    1.166521] usb usb1-port3: status 0101 change 0001
>      [    1.166555] usb usb1-port4: status 0101 change 0001
>      [    1.166584] usb usb1-port5: status 0101 change 0001
>      [    1.270442] usb usb1-port3: status 0101, change 0000, 12 Mb/s
>      [    1.362751] usb usb2: bus auto-suspend, wakeup 1

These are all related to reading values from firmware ACPI tables.

The "failed to peer portx-porty.." messages are because driver can't match which
HS USB 2 and SS USB3 ports are in the same physical connector based on info
read from firmware ACPI _PLD entries

_DSM function 5 is related to port link power management.

Both cases mostly impact power management, but might affects something
else. Haven't looked at it in detail.

ACPI table dump could show more info, especially the DSDT table


> 
> So the problematic ports do not show up in `lsusb`, do they?
> 
> Please find the output of `dmesg` attached.

dmesg shows that "usb2" is the SuperSpeed USB 3 roothub.
It's suspended as no SuperSpeed devices are connected to it.

Do USB 3 devices work normally on this machine?

Thanks
Mathias


