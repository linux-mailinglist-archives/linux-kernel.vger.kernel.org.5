Return-Path: <linux-kernel+bounces-82042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E83867E25
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 955861C2C45F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AB5130AED;
	Mon, 26 Feb 2024 17:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ua0qrjg+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC33C12B166;
	Mon, 26 Feb 2024 17:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708967971; cv=none; b=dbfV3XJTlCnzHnc7igha6CZEDNvXat6oBKxIzk2frzcZE9N87GBXnkBL5WuYL71tzqQ4LPtjw+wmWyPi1kCwwrY1iRcWWTOy2zFYK+Eq+UH7022aoWUTt4if/lg+Vtc0hYtZrSPFD1GSReizWNwc0AGLZ2FAz0zc1KDEnU9HJtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708967971; c=relaxed/simple;
	bh=dSCOT5VowSSiF2b2NApXSB/9K003MpinyKVVYOsEMq8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=dIrA8Hf3gbBJBM+UsiEIYTPqwezf3SM6q8C2S41/RdgtAzh6QzzMRrnIZksx4KmTgBBTqm4tcQnckO9yPNNz0vnGiZdbuvumljuMrjqewFQ98dXiLBxNzKMEYZLcM5jRCG0664Hy7Ie7y2/kH8ktis6zQd7QFhdaEp2oNQQYgIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ua0qrjg+; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708967970; x=1740503970;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=dSCOT5VowSSiF2b2NApXSB/9K003MpinyKVVYOsEMq8=;
  b=Ua0qrjg+Q9qi2rb3PAY5C8K0GZjHoWk6k4o+laeT9fyRPnqPz5qRbfz9
   6KD37sd60HhTMFZHXi61/fuH2P994BrAMaPh67HWnYIxJpKyRuPXzelZd
   NFpznx2ymcoFmz8m7xgpcSazkKt4wJlEnyZLEYs/sMVqhxO+aR9/i9T8e
   5JH2fGB4pNsmCaVaRAAxBEayME+3/BuQp1jm8LqoVW3QyQu/ZxyqEKFiz
   EY+DwXs/546z58oOnzUFVxGgtcgVITKM72tkNcppPTdQpE4XdNSUo8AT/
   PD6YPCte87je6A2OGyYV0pPYLFdxDEbyBq6/mAxOxkrwp7Vu9CnRyMINt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="20714036"
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="20714036"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 09:19:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="937030284"
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="937030284"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga001.fm.intel.com with ESMTP; 26 Feb 2024 09:19:26 -0800
Message-ID: <785ddb6f-dca2-466d-c4bb-a6723a51e3e8@linux.intel.com>
Date: Mon, 26 Feb 2024 19:21:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Content-Language: en-US
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Mike Jones <mike@mjones.io>
References: <14c16bf9-bcdf-4e6b-ac36-f995f5f088a1@molgen.mpg.de>
 <ZdxVTBkym5ovV8ss@kuha.fi.intel.com>
From: Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: xhci_hcd: `Timeout while waiting for setup device command`, 37 s
 until Ethernet connection is established
In-Reply-To: <ZdxVTBkym5ovV8ss@kuha.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.2.2024 11.09, Heikki Krogerus wrote:
> +Mathias
> 
> On Sat, Feb 24, 2024 at 08:45:43PM +0100, Paul Menzel wrote:
>> Dear Linux folks,
>>
>>
>> I suspended a Dell XPS 13 9360 with no devices attached into ACPI S3. Then
>> connecting an LMP USB-C mini Dock (P/N 15954) [1] with an Ethernet cable
>> attached to the left USB-C port and resumed the system from ACPI S3. It took
>> 37 seconds, until the link was established.
>>
>> ```
>> [    0.000000] Linux version 6.8.0-rc5+

..

>> [135636.985555] hub 4-1.1:1.0: hub_suspend
>> [135636.985997] usb 4-1.1: usb auto-suspend, wakeup 1
>> [135637.005910] usb 4-1.1: usb auto-resume
>> [135637.071744] usb 4-1.1: Waited 0ms for CONNECT
>> [135637.071751] usb 4-1.1: finish resume
>> [135637.072442] hub 4-1.1:1.0: hub_resume
>> [135637.100903] usb 4-1.1-port3: link state change
>> [135637.101072] usb 4-1.1-port3: do warm reset, port only
>> [135637.160024] usb 4-1.1-port3: not warm reset yet, waiting 50ms
>> [135642.359752] xhci_hcd 0000:39:00.0: Timeout while waiting for setup
>> device command
>> [135642.359904] usb 4-1.1: kworker/1:0 timed out on ep0in len=0/4
>> [135642.360403] usb 4-1.1-port3: not warm reset yet, waiting 200ms
>> [135642.567550] usb 4-1.4: device not accepting address 4, error -62
>> [135642.567787] usb 4-1.1-port3: not warm reset yet, waiting 200ms
>> [135642.587834] usb 3-1.1-port3: not reset yet, waiting 10ms
>> [135642.608022] usb 3-1.1-port3: not reset yet, waiting 10ms
>> [135642.627960] usb 3-1.1-port3: not reset yet, waiting 200ms
>> [135642.779575] usb 4-1.1-port3: not warm reset yet, waiting 200ms
>> [135642.836010] usb 3-1.1-port3: not reset yet, waiting 200ms
>> [135642.987924] usb 4-1.1-port3: not warm reset yet, waiting 200ms
>> [135642.989649] usb 4-1.1-port3: not enabled, trying warm reset again...
>> [135643.044090] usb 3-1.1-port3: not reset yet, waiting 200ms
>> [135643.253218] usb 3-1.1-port3: not reset yet, waiting 200ms
>> [135643.254188] hub 3-1.1:1.0: state 7 ports 4 chg 0000 evt 0008
>> [135643.254573] usb 3-1.1-port3: status 0100, change 0001, 12 Mb/s
>> [135643.254782] usb 3-1.1-port3: indicator auto status 0
>> [135643.255501] hub 4-1.1:1.0: state 7 ports 4 chg 0000 evt 0008
>> [135643.256309] usb 4-1.1-port3: status 0203, change 0001, 5.0 Gb/s
>> [135643.272060] usb 4-1-port4: not reset yet, waiting 10ms
>> [135643.292703] usb 4-1-port4: not reset yet, waiting 10ms
>> [135643.311459] usb 4-1-port4: not reset yet, waiting 200ms
>> [135643.395529] usb 3-1.1-port3: debounce total 100ms stable 100ms status
>> 0x100
>> [135643.395546] hub 3-1.1:1.0: hub_suspend
>> [135643.395900] usb 3-1.1: usb auto-suspend, wakeup 1
>> [135643.399598] usb 4-1.1-port3: debounce total 100ms stable 100ms status
>> 0x203
>> [135648.759590] xhci_hcd 0000:39:00.0: Timeout while waiting for setup
>> device command
>> [135654.135471] xhci_hcd 0000:39:00.0: Timeout while waiting for setup
>> device command
>> [135654.343365] usb 4-1.4: device not accepting address 5, error -62
>> [135654.343741] usb 4-1-port4: attempt power cycle
>> [135654.423462] usb 4-1.1.3: new SuperSpeed USB device number 6 using
>> xhci_hcd
>> [135654.443569] usb 4-1.1.3: USB quirks for this device: 400
>> [135654.443996] usb 4-1.1.3: skipped 1 descriptor after endpoint
>> [135654.444015] usb 4-1.1.3: skipped 1 descriptor after endpoint
>> [135654.444026] usb 4-1.1.3: skipped 1 descriptor after endpoint
>> [135654.444146] usb 4-1.1.3: skipped 3 descriptors after interface
>> [135654.444157] usb 4-1.1.3: skipped 1 descriptor after endpoint
>> [135654.444166] usb 4-1.1.3: skipped 1 descriptor after endpoint
>> [135654.444174] usb 4-1.1.3: skipped 1 descriptor after endpoint
>> [135654.444231] usb 4-1.1.3: default language 0x0409
>> [135654.444459] usb 4-1.1.3: udev 6, busnum 4, minor = 389
>> [135654.444472] usb 4-1.1.3: New USB device found, idVendor=0bda,
>> idProduct=8153, bcdDevice=30.00
>> [135654.444485] usb 4-1.1.3: New USB device strings: Mfr=1, Product=2,
>> SerialNumber=6
>> [135654.444495] usb 4-1.1.3: Product: USB 10/100/1000 LAN
>> [135654.444503] usb 4-1.1.3: Manufacturer: Realtek
>> [135654.444510] usb 4-1.1.3: SerialNumber: 000001
>> [135654.444978] r8152-cfgselector 4-1.1.3: usb_probe_device
>> [135654.447545] r8152-cfgselector 4-1.1.3: adding 4-1.1.3:1.0 (config #1,
>> interface 0)
>> [135654.447741] r8152 4-1.1.3:1.0: usb_probe_interface
>> [135654.447753] r8152 4-1.1.3:1.0: usb_probe_interface - got id
>> [135654.527864] r8152-cfgselector 4-1.1.3: reset SuperSpeed USB device
>> number 6 using xhci_hcd
>> [135654.547443] r8152-cfgselector 4-1.1.3: USB quirks for this device: 400
>> [135654.570025] r8152 4-1.1.3:1.0: load rtl8153a-4 v2 02/07/20 successfully
>> [135654.601390] r8152 4-1.1.3:1.0 eth0: v1.12.13
>> [135654.602115] hub 4-1.1:1.0: state 7 ports 4 chg 0000 evt 0008
>> [135660.535346] xhci_hcd 0000:39:00.0: Timeout while waiting for setup
>> device command
>> [135665.911069] xhci_hcd 0000:39:00.0: Timeout while waiting for setup
>> device command
>> [135666.118792] usb 4-1.4: device not accepting address 7, error -62
>> [135666.138995] usb 4-1-port4: not reset yet, waiting 10ms
>> [135666.158967] usb 4-1-port4: not reset yet, waiting 10ms
>> [135666.178919] usb 4-1-port4: not reset yet, waiting 200ms
>> [135666.387360] usb 4-1-port4: not reset yet, waiting 200ms
>> [135666.595345] usb 4-1-port4: not reset yet, waiting 200ms
>> [135666.803419] usb 4-1-port4: not reset yet, waiting 200ms
>> [135666.804994] hub 4-1:1.0: state 7 ports 4 chg 0000 evt 0010
>> [135666.861597] r8152 4-1.1.3:1.0 enx00e04ceabb21: renamed from eth0
>> [135666.922339] r8152 4-1.1.3:1.0 enx00e04ceabb21: carrier on

..

>> The last part continues until unplugging device, but this might be a
>> separate issue, as the Ethernet connection was functional.
>>
>> So from
>>
>>      [135654.601390] r8152 4-1.1.3:1.0 eth0: v1.12.13
>>
>> to
>>
>>      [135666.861597] r8152 4-1.1.3:1.0 enx00e04ceabb21: renamed from eth0
>>
>> it took 12 seconds.
>>
>> Is that a problem with the laptop or the adapter? And can it be fixed
>> somehow?

Your dock has a couple usb hubs, the network adapter is behind the second one.

Looks like several of the usb devices have issues enumerating, hub enumerates one
device at a time so enumeration issue on a hub will block enumerating other
devices on that same hub.

In addition to other devices failing it looks like this network adapter
behind 4-1.1-port3 takes a long time to reset as well.

Are there any other usb devices connected to this hub that can be removed?
Does that improve the situation?

Does dock work normally if its connected to a fully running system, (S0)

Also, those extra hub_suspend and hub_resume entries looks suspicious

Thanks
Mathias


