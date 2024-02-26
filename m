Return-Path: <linux-kernel+bounces-81011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7482866F06
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA65E1F27475
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC677E11B;
	Mon, 26 Feb 2024 09:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fT8O5ETo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B2721364;
	Mon, 26 Feb 2024 09:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708938599; cv=none; b=MKGtn7y5Q9viK3ECgUaADQqiYHtBRH4dvN6vhGGoxzdr2HXFtC9X1vbt9AEUSyyagY6ax6fmrkA9M9JRNe6S8jQgkRCD1a1PBwl5lNYti+Y+ixrSyge1XPW/98OccCcYqcglzDDt9iEZxXi13zfFjnUmtGJbJEp0g35keyTx5nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708938599; c=relaxed/simple;
	bh=tqoKegRMimmIRl+6Q3GyAg6jRzmvXTuc0FNfqupGA/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Me2nZVbioV33cfgv1ryXSvXHEMUWs8N1Nw5XCkM2tyfB9S9sZD79Y0OVDJhAlmF5OlOyO2qo3A5Xu5VciEGOcbOomIjbth3rIjyqWpPe1LSLqxWJQpmm7d5YWBOgoDO/50arr/+wKIzm2EwFYJ9vG4bioPD1IHq6bin86vd5jaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fT8O5ETo; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708938597; x=1740474597;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=tqoKegRMimmIRl+6Q3GyAg6jRzmvXTuc0FNfqupGA/M=;
  b=fT8O5ETo/t9aWZH0nAEIztQSjgAS3/Hl4KysZDj0NmcUAHwS1ED2ranh
   5ddz0QbEgbZk3CX3qa9KCzdFoM/oW536NTNqkWJ1ScgUFIyxOGKOmFOy1
   hm3Ygk7I6SJUsniZUEu8NggN9F64CKxTL8zur/fP6DsyYYsxjDWYnhY1T
   JWAmCIW6PFVu5047gttkAWqxwJqdzeYjp3Nng07EZ9Pt6CmDdPgVb4GEf
   1XnmPJ9gfX5N4cXs465B6K/f7gRcmIX3E0VwVvjI7xsFumgA+qquXF5Z5
   7wps4gKHjDm0nDtYII9ol5d3o95AyzehEzSW9oeiDai9sZbt2ehjXBwrL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="6998008"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="6998008"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 01:09:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="937029628"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="937029628"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 26 Feb 2024 01:09:33 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 26 Feb 2024 11:09:32 +0200
Date: Mon, 26 Feb 2024 11:09:32 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Mike Jones <mike@mjones.io>,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: xhci_hcd: `Timeout while waiting for setup device command`, 37 s
 until Ethernet connection is established
Message-ID: <ZdxVTBkym5ovV8ss@kuha.fi.intel.com>
References: <14c16bf9-bcdf-4e6b-ac36-f995f5f088a1@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <14c16bf9-bcdf-4e6b-ac36-f995f5f088a1@molgen.mpg.de>

+Mathias

On Sat, Feb 24, 2024 at 08:45:43PM +0100, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> I suspended a Dell XPS 13 9360 with no devices attached into ACPI S3. Then
> connecting an LMP USB-C mini Dock (P/N 15954) [1] with an Ethernet cable
> attached to the left USB-C port and resumed the system from ACPI S3. It took
> 37 seconds, until the link was established.
> 
> ```
> [    0.000000] Linux version 6.8.0-rc5+
> (build@bohemianrhapsody.molgen.mpg.de) (gcc (Debian 13.2.0-13) 13.2.0, GNU
> ld (GNU Binutils for Debian) 2.42) #27 SMP PREEMPT_DYNAMIC Wed Feb 21
> 09:09:49 CET 2024
> [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-6.8.0-rc5+
> root=UUID=32e29882-d94d-4a92-9ee4-4d03002bfa29 ro quiet pci=noaer
> mem_sleep_default=deep log_buf_len=8M cryptomgr.notests usbcore.dyndbg=+p
> […]
> [    0.000000] DMI: Dell Inc. XPS 13 9360/0596KF, BIOS 2.21.0 06/02/2022
> […]
> [135623.339094] PM: suspend entry (deep)
> [135623.345592] Filesystems sync: 0.006 seconds
> [135623.349062] Freezing user space processes
> [135623.352053] Freezing user space processes completed (elapsed 0.002
> seconds)
> [135623.352068] OOM killer disabled.
> [135623.352071] Freezing remaining freezable tasks
> [135623.353870] Freezing remaining freezable tasks completed (elapsed 0.001
> seconds)
> [135623.353985] printk: Suspending console(s) (use no_console_suspend to
> debug)
> [134781.473459] xhci_hcd 0000:00:14.0: hcd_pci_runtime_resume: 0
> [134781.473482] usb usb1: usb auto-resume
> [134781.473509] usb usb2: usb auto-resume
> [134781.473517] hub 1-0:1.0: hub_resume
> [134781.473540] hub 2-0:1.0: hub_resume
> [134781.473597] usb usb1-port3: status 0107 change 0000
> [134781.473616] usb usb1-port4: status 0107 change 0000
> [134781.473632] usb usb1-port5: status 0507 change 0000
> [134781.505615] hub 2-0:1.0: hub_suspend
> [134781.505712] usb usb2: bus suspend, wakeup 0
> [134781.521037] usb 1-4: usb auto-resume
> [134781.589048] usb 1-4: Waited 0ms for CONNECT
> [134781.589071] usb 1-4: finish resume
> [134781.589879] usb 1-4: usb suspend, wakeup 0
> [134781.589992] hub 1-0:1.0: hub_suspend
> [134781.590103] usb usb1: bus suspend, wakeup 0
> [134781.999962] ACPI: EC: interrupt blocked
> [134782.002105] xhci_hcd 0000:00:14.0: wakeup: 1
> [134782.033016] xhci_hcd 0000:00:14.0: --> PCI D3hot
> [134782.033126] ACPI: PM: Preparing to enter system sleep state S3
> [134782.049143] ACPI: EC: event blocked
> [134782.049148] ACPI: EC: EC stopped
> [134782.049150] ACPI: PM: Saving platform NVS memory
> [134782.052592] Disabling non-boot CPUs ...
> [134782.056035] smpboot: CPU 1 is now offline
> [134782.060287] smpboot: CPU 2 is now offline
> [134782.063001] smpboot: CPU 3 is now offline
> [134782.072093] ACPI: PM: Low-level resume complete
> [134782.072137] ACPI: EC: EC started
> [134782.072138] ACPI: PM: Restoring platform NVS memory
> [134782.074101] Enabling non-boot CPUs ...
> [134782.074126] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [134782.074972] CPU1 is up
> [134782.074989] smpboot: Booting Node 0 Processor 2 APIC 0x1
> [134782.075759] CPU2 is up
> [134782.075776] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [134782.076474] CPU3 is up
> [134782.079463] ACPI: PM: Waking up from system sleep state S3
> [134782.126767] ACPI: EC: interrupt unblocked
> [134782.161453] ACPI: EC: event unblocked
> [134782.164047] usb usb1: usb resume
> [134782.164088] usb usb2: usb resume
> [134782.164127] hub 2-0:1.0: hub_resume
> [134782.164970] i915 0000:00:02.0: [drm] [ENCODER:94:DDI A/PHY A] is
> disabled/in DSI mode with an ungated DDI clock, gate it
> [134782.164981] i915 0000:00:02.0: [drm] [ENCODER:102:DDI B/PHY B] is
> disabled/in DSI mode with an ungated DDI clock, gate it
> [134782.164989] i915 0000:00:02.0: [drm] [ENCODER:113:DDI C/PHY C] is
> disabled/in DSI mode with an ungated DDI clock, gate it
> [134782.174398] nvme nvme0: 4/0/0 default/read/poll queues
> [134782.175094] hub 1-0:1.0: hub_resume
> [134782.175153] usb usb1-port3: status 0101 change 0001
> [134782.175176] usb usb1-port4: status 0101 change 0001
> [134782.175195] usb usb1-port5: status 0101 change 0001
> [134782.299331] usb 1-3: Waited 0ms for CONNECT
> [134782.299336] usb 1-5: Waited 0ms for CONNECT
> [134782.299339] usb 1-3: finish reset-resume
> [134782.299343] usb 1-5: finish reset-resume
> [134782.303359] usb 1-4: Waited 0ms for CONNECT
> [134782.303363] usb 1-4: finish reset-resume
> [134782.411326] atkbd serio0: Failed to deactivate keyboard on
> isa0060/serio0
> [134782.427585] usb 1-3: reset full-speed USB device number 2 using xhci_hcd
> [134782.703558] usb 1-5: reset high-speed USB device number 4 using xhci_hcd
> [134782.979518] usb 1-4: reset full-speed USB device number 3 using xhci_hcd
> [134783.137568] OOM killer enabled.
> [134783.137570] Restarting tasks ...
> [134783.137607] hub 2-0:1.0: state 7 ports 6 chg 0000 evt 0000
> [134783.138111] hub 2-0:1.0: hub_suspend
> [134783.138130] usb usb2: bus auto-suspend, wakeup 1
> [134783.139896] usb usb2: usb wakeup-resume
> [134783.139903] usb usb2: usb auto-resume
> [134783.141145] hub 1-0:1.0: state 7 ports 12 chg 0000 evt 0010
> [134783.144869] done.
> [134783.144884] random: crng reseeded on system resumption
> [134783.155322] hub 2-0:1.0: hub_resume
> [134783.187376] hub 2-0:1.0: state 7 ports 6 chg 0000 evt 0000
> [134783.187433] hub 2-0:1.0: hub_suspend
> [134783.187439] usb usb2: bus auto-suspend, wakeup 1
> [134783.225883] PM: suspend exit
> [134783.295100] Process accounting resumed
> [134783.483053] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04:
> bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> [134785.095304] usb 1-3: usb auto-suspend, wakeup 0
> [134785.439272] usb 1-5: usb auto-suspend, wakeup 0
> [134785.583269] usb 1-4: usb auto-suspend, wakeup 1
> [134785.603266] hub 1-0:1.0: hub_suspend
> [134785.603280] usb usb1: bus auto-suspend, wakeup 1
> [134785.603448] xhci_hcd 0000:00:14.0: hcd_pci_runtime_suspend: 0
> [134788.708764] wlp58s0: authenticate with a4:97:33:06:77:d3 (local
> address=9c:b6:d0:d1:6a:b1)
> [134788.708770] wlp58s0: send auth to a4:97:33:06:77:d3 (try 1/3)
> [134788.709809] wlp58s0: authenticated
> [134788.711232] wlp58s0: associate with a4:97:33:06:77:d3 (try 1/3)
> [134788.714287] wlp58s0: RX AssocResp from a4:97:33:06:77:d3 (capab=0x511
> status=0 aid=102)
> [134788.717462] wlp58s0: associated
> [134788.721574] wlp58s0: Limiting TX power to 30 (30 - 0) dBm as advertised
> by a4:97:33:06:77:d3
> [135619.981952] xhci_hcd 0000:00:14.0: hcd_pci_runtime_resume: 0
> [135619.982043] usb usb1: usb wakeup-resume
> [135619.982048] usb usb1: usb auto-resume
> [135619.982072] hub 1-0:1.0: hub_resume
> [135619.982103] usb usb1-port3: status 0107 change 0000
> [135619.982111] usb usb1-port4: status 0107 change 0000
> [135619.982119] usb usb1-port5: status 0507 change 0000
> [135619.982163] usb usb2: usb wakeup-resume
> [135619.982165] usb usb2: usb auto-resume
> [135619.982188] hub 2-0:1.0: hub_resume
> [135619.982198] hub 1-0:1.0: state 7 ports 12 chg 0000 evt 0000
> [135619.987438] hub 1-0:1.0: state 7 ports 12 chg 0000 evt 0000
> [135620.009646] hub 2-0:1.0: state 7 ports 6 chg 0000 evt 0000
> [135620.009700] hub 2-0:1.0: hub_suspend
> [135620.009705] usb usb2: bus auto-suspend, wakeup 1
> [135620.148856] wlp58s0: deauthenticating from a4:97:33:06:77:d3 by local
> choice (Reason: 3=DEAUTH_LEAVING)
> [135620.157614] hub 1-0:1.0: state 7 ports 12 chg 0000 evt 0010
> [135620.177775] usb 1-4: usb wakeup-resume
> [135620.197833] usb 1-4: Waited 0ms for CONNECT
> [135620.197838] usb 1-4: finish resume
> [135620.198318] usb usb1-port4: resume, status 0
> [135622.717569] usb 1-4: usb auto-suspend, wakeup 1
> [135622.737533] hub 1-0:1.0: hub_suspend
> [135622.737550] usb usb1: bus auto-suspend, wakeup 1
> [135622.737701] xhci_hcd 0000:00:14.0: hcd_pci_runtime_suspend: 0
> [135623.339094] PM: suspend entry (deep)
> [135623.345592] Filesystems sync: 0.006 seconds
> [135623.349062] Freezing user space processes
> [135623.352053] Freezing user space processes completed (elapsed 0.002
> seconds)
> [135623.352068] OOM killer disabled.
> [135623.352071] Freezing remaining freezable tasks
> [135623.353870] Freezing remaining freezable tasks completed (elapsed 0.001
> seconds)
> [135623.353985] printk: Suspending console(s) (use no_console_suspend to
> debug)
> [135623.390281] xhci_hcd 0000:00:14.0: hcd_pci_runtime_resume: 0
> [135623.390306] usb usb1: usb auto-resume
> [135623.390319] usb usb2: usb auto-resume
> [135623.390340] hub 1-0:1.0: hub_resume
> [135623.390358] hub 2-0:1.0: hub_resume
> [135623.390535] usb usb1-port3: status 0107 change 0000
> [135623.390593] usb usb1-port4: status 0107 change 0000
> [135623.390671] usb usb1-port5: status 0507 change 0000
> [135623.417795] hub 2-0:1.0: hub_suspend
> [135623.417832] usb usb2: bus suspend, wakeup 0
> [135623.437691] usb 1-4: usb auto-resume
> [135623.505705] usb 1-4: Waited 0ms for CONNECT
> [135623.505722] usb 1-4: finish resume
> [135623.506183] usb 1-4: usb suspend, wakeup 0
> [135623.506226] hub 1-0:1.0: hub_suspend
> [135623.506285] usb usb1: bus suspend, wakeup 0
> [135623.918326] ACPI: EC: interrupt blocked
> [135623.922119] xhci_hcd 0000:00:14.0: wakeup: 1
> [135623.953670] xhci_hcd 0000:00:14.0: --> PCI D3hot
> [135623.953772] ACPI: PM: Preparing to enter system sleep state S3
> [135623.963290] ACPI: EC: event blocked
> [135623.963291] ACPI: EC: EC stopped
> [135623.963292] ACPI: PM: Saving platform NVS memory
> [135623.964787] Disabling non-boot CPUs ...
> [135623.966332] smpboot: CPU 1 is now offline
> [135623.968749] smpboot: CPU 2 is now offline
> [135623.970630] smpboot: CPU 3 is now offline
> [135623.975734] ACPI: PM: Low-level resume complete
> [135623.975778] ACPI: EC: EC started
> [135623.975779] ACPI: PM: Restoring platform NVS memory
> [135623.977741] Enabling non-boot CPUs ...
> [135623.977767] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [135623.978525] CPU1 is up
> [135623.978542] smpboot: Booting Node 0 Processor 2 APIC 0x1
> [135623.979283] CPU2 is up
> [135623.979299] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [135623.979965] CPU3 is up
> [135623.982953] ACPI: PM: Waking up from system sleep state S3
> [135628.953183] ACPI: EC: interrupt unblocked
> [135629.001792] ACPI: EC: event unblocked
> [135629.004635] usb usb1: usb resume
> [135629.004637] usb usb2: usb resume
> [135629.004658] hub 2-0:1.0: hub_resume
> [135629.005256] i915 0000:00:02.0: [drm] [ENCODER:94:DDI A/PHY A] is
> disabled/in DSI mode with an ungated DDI clock, gate it
> [135629.005261] i915 0000:00:02.0: [drm] [ENCODER:102:DDI B/PHY B] is
> disabled/in DSI mode with an ungated DDI clock, gate it
> [135629.005264] i915 0000:00:02.0: [drm] [ENCODER:113:DDI C/PHY C] is
> disabled/in DSI mode with an ungated DDI clock, gate it
> [135629.014542] nvme nvme0: 4/0/0 default/read/poll queues
> [135629.015207] hub 1-0:1.0: hub_resume
> [135629.015226] usb usb1-port3: status 0101 change 0001
> [135629.015235] usb usb1-port4: status 0101 change 0001
> [135629.015243] usb usb1-port5: status 0101 change 0001
> [135629.139830] usb 1-5: Waited 0ms for CONNECT
> [135629.139834] usb 1-5: finish reset-resume
> [135629.139836] usb 1-3: Waited 0ms for CONNECT
> [135629.139838] usb 1-3: finish reset-resume
> [135629.139876] usb 1-4: Waited 0ms for CONNECT
> [135629.139879] usb 1-4: finish reset-resume
> [135629.268021] usb 1-5: reset high-speed USB device number 4 using xhci_hcd
> [135629.544069] usb 1-3: reset full-speed USB device number 2 using xhci_hcd
> [135629.820015] usb 1-4: reset full-speed USB device number 3 using xhci_hcd
> [135629.976929] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04:
> bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> [135629.977326] OOM killer enabled.
> [135629.977329] Restarting tasks ...
> [135629.977351] pci 0000:01:00.0: [8086:1576] type 01 class 0x060400 PCIe
> Switch Upstream Port
> [135629.977404] hub 1-0:1.0: state 7 ports 12 chg 0000 evt 0010
> [135629.977405] pci 0000:01:00.0: PCI bridge to [bus 02-39]
> [135629.977425] pci 0000:01:00.0:   bridge window [mem
> 0xc4000000-0xda0fffff]
> [135629.977446] pci 0000:01:00.0:   bridge window [mem 0xa0000000-0xc1ffffff
> 64bit pref]
> [135629.977475] pci 0000:01:00.0: enabling Extended Tags
> [135629.977561] hub 2-0:1.0: state 7 ports 6 chg 0000 evt 0000
> [135629.977886] pci 0000:01:00.0: supports D1 D2
> [135629.977889] pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [135629.977998] pci 0000:01:00.0: 15.752 Gb/s available PCIe bandwidth,
> limited by 8.0 GT/s PCIe x2 link at 0000:00:1c.0 (capable of 31.504 Gb/s
> with 8.0 GT/s PCIe x4 link)
> [135629.981650] pci 0000:02:00.0: [8086:1576] type 01 class 0x060400 PCIe
> Switch Downstream Port
> [135629.981716] pci 0000:02:00.0: PCI bridge to [bus 03]
> [135629.981738] pci 0000:02:00.0:   bridge window [mem
> 0xda000000-0xda0fffff]
> [135629.981781] pci 0000:02:00.0: enabling Extended Tags
> [135629.981937] pci 0000:02:00.0: supports D1 D2
> [135629.981940] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [135629.982333] pci 0000:02:01.0: [8086:1576] type 01 class 0x060400 PCIe
> Switch Downstream Port
> [135629.982387] pci 0000:02:01.0: PCI bridge to [bus 04-38]
> [135629.982405] pci 0000:02:01.0:   bridge window [mem
> 0xc4000000-0xd9efffff]
> [135629.982426] pci 0000:02:01.0:   bridge window [mem 0xa0000000-0xc1ffffff
> 64bit pref]
> [135629.982450] pci 0000:02:01.0: enabling Extended Tags
> [135629.982621] pci 0000:02:01.0: supports D1 D2
> [135629.982624] pci 0000:02:01.0: PME# supported from D0 D1 D2 D3hot D3cold
> [135629.983907] hub 2-0:1.0: hub_suspend
> [135629.983945] usb usb2: bus auto-suspend, wakeup 1
> [135629.984444] done.
> [135629.984460] random: crng reseeded on system resumption
> [135629.986390] pci 0000:02:02.0: [8086:1576] type 01 class 0x060400 PCIe
> Switch Downstream Port
> [135629.986441] pci 0000:02:02.0: PCI bridge to [bus 39]
> [135629.986458] pci 0000:02:02.0:   bridge window [mem
> 0xd9f00000-0xd9ffffff]
> [135629.986492] pci 0000:02:02.0: enabling Extended Tags
> [135629.986629] pci 0000:02:02.0: supports D1 D2
> [135629.986631] pci 0000:02:02.0: PME# supported from D0 D1 D2 D3hot D3cold
> [135629.986929] pci 0000:01:00.0: PCI bridge to [bus 02-39]
> [135629.987022] pci 0000:02:00.0: PCI bridge to [bus 03]
> [135629.987103] pci 0000:02:01.0: PCI bridge to [bus 04-38]
> [135629.990420] pci 0000:39:00.0: [8086:15b5] type 00 class 0x0c0330 PCIe
> Endpoint
> [135629.990454] pci 0000:39:00.0: BAR 0 [mem 0xd9f00000-0xd9f0ffff]
> [135629.990554] pci 0000:39:00.0: enabling Extended Tags
> [135629.997287] pci 0000:39:00.0: supports D1 D2
> [135629.997295] pci 0000:39:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [135629.997443] pci 0000:39:00.0: 8.000 Gb/s available PCIe bandwidth,
> limited by 2.5 GT/s PCIe x4 link at 0000:02:02.0 (capable of 31.504 Gb/s
> with 8.0 GT/s PCIe x4 link)
> [135629.997814] pci 0000:02:02.0: PCI bridge to [bus 39]
> [135629.997867] pci_bus 0000:02: Allocating resources
> [135629.997892] pci 0000:02:01.0: bridge window [io  0x1000-0x0fff] to [bus
> 04-38] add_size 1000
> [135629.997901] pci 0000:02:02.0: bridge window [io  0x1000-0x0fff] to [bus
> 39] add_size 1000
> [135629.997904] pci 0000:02:02.0: bridge window [mem 0x00100000-0x000fffff
> 64bit pref] to [bus 39] add_size 200000 add_align 100000
> [135629.997908] pci 0000:01:00.0: bridge window [io  0x1000-0x0fff] to [bus
> 02-39] add_size 2000
> [135629.997912] pci 0000:01:00.0: bridge window [io  size 0x2000]: can't
> assign; no space
> [135629.997915] pci 0000:01:00.0: bridge window [io  size 0x2000]: failed to
> assign
> [135629.997917] pci 0000:01:00.0: bridge window [io  size 0x2000]: can't
> assign; no space
> [135629.997924] pci 0000:01:00.0: bridge window [io  size 0x2000]: failed to
> assign
> [135629.997929] pci 0000:02:02.0: bridge window [mem size 0x00200000 64bit
> pref]: can't assign; no space
> [135629.997931] pci 0000:02:02.0: bridge window [mem size 0x00200000 64bit
> pref]: failed to assign
> [135629.997932] pci 0000:02:01.0: bridge window [io  size 0x1000]: can't
> assign; no space
> [135629.997934] pci 0000:02:01.0: bridge window [io  size 0x1000]: failed to
> assign
> [135629.997935] pci 0000:02:02.0: bridge window [io  size 0x1000]: can't
> assign; no space
> [135629.997937] pci 0000:02:02.0: bridge window [io  size 0x1000]: failed to
> assign
> [135629.997940] pci 0000:02:02.0: bridge window [mem size 0x00200000 64bit
> pref]: can't assign; no space
> [135629.997942] pci 0000:02:02.0: bridge window [mem size 0x00200000 64bit
> pref]: failed to assign
> [135629.997982] pci 0000:02:02.0: bridge window [io  size 0x1000]: can't
> assign; no space
> [135629.998009] pci 0000:02:02.0: bridge window [io  size 0x1000]: failed to
> assign
> [135629.998037] pci 0000:02:01.0: bridge window [io  size 0x1000]: can't
> assign; no space
> [135629.998063] pci 0000:02:01.0: bridge window [io  size 0x1000]: failed to
> assign
> [135629.998125] pci 0000:02:00.0: PCI bridge to [bus 03]
> [135629.998131] pci 0000:02:00.0:   bridge window [mem
> 0xda000000-0xda0fffff]
> [135629.998140] pci 0000:02:01.0: PCI bridge to [bus 04-38]
> [135629.998145] pci 0000:02:01.0:   bridge window [mem
> 0xc4000000-0xd9efffff]
> [135629.998149] pci 0000:02:01.0:   bridge window [mem 0xa0000000-0xc1ffffff
> 64bit pref]
> [135629.998156] pci 0000:02:02.0: PCI bridge to [bus 39]
> [135629.998161] pci 0000:02:02.0:   bridge window [mem
> 0xd9f00000-0xd9ffffff]
> [135629.998169] pci 0000:01:00.0: PCI bridge to [bus 02-39]
> [135629.998175] pci 0000:01:00.0:   bridge window [mem
> 0xc4000000-0xda0fffff]
> [135629.998179] pci 0000:01:00.0:   bridge window [mem 0xa0000000-0xc1ffffff
> 64bit pref]
> [135630.003545] xhci_hcd 0000:39:00.0: xHCI Host Controller
> [135630.003562] xhci_hcd 0000:39:00.0: new USB bus registered, assigned bus
> number 3
> [135630.004799] xhci_hcd 0000:39:00.0: hcc params 0x200077c1 hci version
> 0x110 quirks 0x0000000200009810
> [135630.004875] xhci_hcd 0000:39:00.0: supports USB remote wakeup
> [135630.024937] xhci_hcd 0000:39:00.0: xHCI Host Controller
> [135630.024946] xhci_hcd 0000:39:00.0: new USB bus registered, assigned bus
> number 4
> [135630.024953] xhci_hcd 0000:39:00.0: Host supports USB 3.1 Enhanced
> SuperSpeed
> [135630.024956] xhci_hcd 0000:39:00.0: supports USB remote wakeup
> [135630.025073] usb usb3: default language 0x0409
> [135630.025089] usb usb3: udev 1, busnum 3, minor = 256
> [135630.025092] usb usb3: New USB device found, idVendor=1d6b,
> idProduct=0002, bcdDevice= 6.08
> [135630.025095] usb usb3: New USB device strings: Mfr=3, Product=2,
> SerialNumber=1
> [135630.025097] usb usb3: Product: xHCI Host Controller
> [135630.025099] usb usb3: Manufacturer: Linux 6.8.0-rc5+ xhci-hcd
> [135630.025100] usb usb3: SerialNumber: 0000:39:00.0
> [135630.076427] usb usb3: usb_probe_device
> [135630.076432] usb usb3: configuration #1 chosen from 1 choice
> [135630.076450] usb usb3: adding 3-0:1.0 (config #1, interface 0)
> [135630.077078] hub 3-0:1.0: usb_probe_interface
> [135630.077104] hub 3-0:1.0: usb_probe_interface - got id
> [135630.077127] hub 3-0:1.0: USB hub found
> [135630.077169] hub 3-0:1.0: 2 ports detected
> [135630.077171] hub 3-0:1.0: standalone hub
> [135630.077172] hub 3-0:1.0: no power switching (usb 1.0)
> [135630.077174] hub 3-0:1.0: individual port over-current protection
> [135630.077175] hub 3-0:1.0: Single TT
> [135630.077176] hub 3-0:1.0: TT requires at most 8 FS bit times (666 ns)
> [135630.077178] hub 3-0:1.0: power on to power good time: 20ms
> [135630.077188] hub 3-0:1.0: local power source is good
> [135630.078734] hub 3-0:1.0: trying to enable port power on non-switchable
> hub
> [135630.083747] usb usb4: skipped 1 descriptor after endpoint
> [135630.083784] usb usb4: default language 0x0409
> [135630.083877] usb usb4: udev 1, busnum 4, minor = 384
> [135630.083890] usb usb4: New USB device found, idVendor=1d6b,
> idProduct=0003, bcdDevice= 6.08
> [135630.083904] usb usb4: New USB device strings: Mfr=3, Product=2,
> SerialNumber=1
> [135630.083913] usb usb4: Product: xHCI Host Controller
> [135630.083921] usb usb4: Manufacturer: Linux 6.8.0-rc5+ xhci-hcd
> [135630.083927] usb usb4: SerialNumber: 0000:39:00.0
> [135630.091335] usb usb4: usb_probe_device
> [135630.091350] usb usb4: configuration #1 chosen from 1 choice
> [135630.091400] usb usb4: adding 4-0:1.0 (config #1, interface 0)
> [135630.091503] hub 4-0:1.0: usb_probe_interface
> [135630.091509] hub 4-0:1.0: usb_probe_interface - got id
> [135630.091517] hub 4-0:1.0: USB hub found
> [135630.091540] hub 4-0:1.0: 2 ports detected
> [135630.091546] hub 4-0:1.0: standalone hub
> [135630.091551] hub 4-0:1.0: no power switching (usb 1.0)
> [135630.091556] hub 4-0:1.0: individual port over-current protection
> [135630.091562] hub 4-0:1.0: TT requires at most 8 FS bit times (666 ns)
> [135630.091568] hub 4-0:1.0: power on to power good time: 100ms
> [135630.091590] hub 4-0:1.0: local power source is good
> [135630.097020] usb usb4-port1: peered to usb3-port1
> [135630.103851] usb usb3-port1: status 0101 change 0001
> [135630.109207] usb usb4: port-1 no _DSM function 5
> [135630.109224] usb usb4: port-2 no _DSM function 5
> [135630.109230] hub 4-0:1.0: trying to enable port power on non-switchable
> hub
> [135630.110174] pci_bus 0000:02: Allocating resources
> [135630.110197] pcieport 0000:02:01.0: bridge window [io  0x1000-0x0fff] to
> [bus 04-38] add_size 1000
> [135630.110205] pcieport 0000:02:02.0: bridge window [io  0x1000-0x0fff] to
> [bus 39] add_size 1000
> [135630.110210] pcieport 0000:02:02.0: bridge window [mem
> 0x00100000-0x000fffff 64bit pref] to [bus 39] add_size 200000 add_align
> 100000
> [135630.110218] pcieport 0000:01:00.0: bridge window [io  0x1000-0x0fff] to
> [bus 02-39] add_size 2000
> [135630.110224] pcieport 0000:01:00.0: bridge window [io  size 0x2000]:
> can't assign; no space
> [135630.110228] pcieport 0000:01:00.0: bridge window [io  size 0x2000]:
> failed to assign
> [135630.110233] pcieport 0000:01:00.0: bridge window [io  size 0x2000]:
> can't assign; no space
> [135630.110236] pcieport 0000:01:00.0: bridge window [io  size 0x2000]:
> failed to assign
> [135630.110245] pcieport 0000:02:02.0: bridge window [mem size 0x00200000
> 64bit pref]: can't assign; no space
> [135630.110249] pcieport 0000:02:02.0: bridge window [mem size 0x00200000
> 64bit pref]: failed to assign
> [135630.110253] pcieport 0000:02:01.0: bridge window [io  size 0x1000]:
> can't assign; no space
> [135630.110257] pcieport 0000:02:01.0: bridge window [io  size 0x1000]:
> failed to assign
> [135630.110260] pcieport 0000:02:02.0: bridge window [io  size 0x1000]:
> can't assign; no space
> [135630.110263] pcieport 0000:02:02.0: bridge window [io  size 0x1000]:
> failed to assign
> [135630.110271] pcieport 0000:02:02.0: bridge window [mem size 0x00200000
> 64bit pref]: can't assign; no space
> [135630.110275] pcieport 0000:02:02.0: bridge window [mem size 0x00200000
> 64bit pref]: failed to assign
> [135630.110279] pcieport 0000:02:02.0: bridge window [io  size 0x1000]:
> can't assign; no space
> [135630.110282] pcieport 0000:02:02.0: bridge window [io  size 0x1000]:
> failed to assign
> [135630.110286] pcieport 0000:02:01.0: bridge window [io  size 0x1000]:
> can't assign; no space
> [135630.110289] pcieport 0000:02:01.0: bridge window [io  size 0x1000]:
> failed to assign
> [135630.139535] PM: suspend exit
> [135630.211437] hub 3-0:1.0: state 7 ports 2 chg 0002 evt 0000
> [135630.211534] usb usb3-port1: status 0101, change 0000, 12 Mb/s
> [135630.211937] usb usb4-port1: status 0203 change 0011
> [135630.293847] Process accounting resumed
> [135630.319813] hub 4-0:1.0: state 7 ports 2 chg 0002 evt 0000
> [135630.319836] usb usb4-port1: status 0203, change 0000, 10.0 Gb/s
> [135630.339810] usb 3-1: new high-speed USB device number 2 using xhci_hcd
> [135630.497568] usb 3-1: default language 0x0409
> [135630.498182] usb 3-1: udev 2, busnum 3, minor = 257
> [135630.498220] usb 3-1: New USB device found, idVendor=2109,
> idProduct=2817, bcdDevice= 5.e3
> [135630.498252] usb 3-1: New USB device strings: Mfr=1, Product=2,
> SerialNumber=3
> [135630.498254] usb 3-1: Product: USB2.0 Hub
> [135630.498256] usb 3-1: Manufacturer: VIA Labs, Inc.
> [135630.498258] usb 3-1: SerialNumber: 000000000
> [135630.499087] usb 3-1: usb_probe_device
> [135630.499101] usb 3-1: configuration #1 chosen from 1 choice
> [135630.503960] usb 3-1: adding 3-1:1.0 (config #1, interface 0)
> [135630.504782] hub 3-1:1.0: usb_probe_interface
> [135630.504796] hub 3-1:1.0: usb_probe_interface - got id
> [135630.504807] hub 3-1:1.0: USB hub found
> [135630.505081] hub 3-1:1.0: 5 ports detected
> [135630.505094] hub 3-1:1.0: standalone hub
> [135630.505100] hub 3-1:1.0: individual port power switching
> [135630.505107] hub 3-1:1.0: individual port over-current protection
> [135630.509115] hub 3-1:1.0: TT per port
> [135630.509124] hub 3-1:1.0: TT requires at most 32 FS bit times (2664 ns)
> [135630.509130] hub 3-1:1.0: Port indicators are supported
> [135630.509133] hub 3-1:1.0: power on to power good time: 350ms
> [135630.511933] hub 3-1:1.0: local power source is good
> [135630.531819] hub 3-1:1.0: enabling power on all ports
> [135630.655107] hub 3-0:1.0: state 7 ports 2 chg 0000 evt 0000
> [135630.656725] usb 4-1: new SuperSpeed USB device number 2 using xhci_hcd
> [135630.709274] usb 4-1: skipped 1 descriptor after endpoint
> [135630.709452] usb 4-1: default language 0x0409
> [135630.710095] usb 4-1: udev 2, busnum 4, minor = 385
> [135630.710100] usb 4-1: New USB device found, idVendor=2109,
> idProduct=0817, bcdDevice= 5.e3
> [135630.710104] usb 4-1: New USB device strings: Mfr=1, Product=2,
> SerialNumber=3
> [135630.710107] usb 4-1: Product: USB3.0 Hub
> [135630.710110] usb 4-1: Manufacturer: VIA Labs, Inc.
> [135630.710112] usb 4-1: SerialNumber: 000000000
> [135630.710623] usb 4-1: usb_probe_device
> [135630.710629] usb 4-1: configuration #1 chosen from 1 choice
> [135630.711774] usb 4-1: adding 4-1:1.0 (config #1, interface 0)
> [135630.712044] hub 4-1:1.0: usb_probe_interface
> [135630.712049] hub 4-1:1.0: usb_probe_interface - got id
> [135630.712054] hub 4-1:1.0: USB hub found
> [135630.715800] hub 4-1:1.0: 4 ports detected
> [135630.715805] hub 4-1:1.0: standalone hub
> [135630.715807] hub 4-1:1.0: individual port power switching
> [135630.715809] hub 4-1:1.0: individual port over-current protection
> [135630.715811] hub 4-1:1.0: TT requires at most 8 FS bit times (666 ns)
> [135630.715813] hub 4-1:1.0: power on to power good time: 350ms
> [135630.716557] hub 4-1:1.0: local power source is good
> [135630.718147] usb 4-1-port1: peered to 3-1-port1
> [135630.718183] usb 4-1-port2: peered to 3-1-port2
> [135630.718212] usb 4-1-port3: peered to 3-1-port3
> [135630.718233] usb 4-1-port4: peered to 3-1-port4
> [135630.818907] hub 4-1:1.0: enabling power on all ports
> [135630.819762] hub 4-0:1.0: state 7 ports 2 chg 0000 evt 0000
> [135631.039821] usb 3-1-port1: status 0101 change 0001
> [135631.040749] usb 3-1-port5: status 0501 change 0001
> [135631.147824] hub 3-1:1.0: state 7 ports 5 chg 0022 evt 0000
> [135631.148042] usb 3-1-port1: status 0101, change 0000, 12 Mb/s
> [135631.148206] usb 3-1-port1: indicator auto status 0
> [135631.198801] usb 4-1-port1: status 0203 change 0011
> [135631.199751] usb 4-1-port4: status 0203 change 0011
> [135631.275779] usb 3-1.1: new high-speed USB device number 3 using xhci_hcd
> [135631.303781] hub 4-1:1.0: state 7 ports 4 chg 0012 evt 0000
> [135631.326374] usb 4-1-port1: status 0203, change 0000, 5.0 Gb/s
> [135631.425541] usb 3-1.1: default language 0x0409
> [135631.426259] usb 3-1.1: udev 3, busnum 3, minor = 258
> [135631.426263] usb 3-1.1: New USB device found, idVendor=2109,
> idProduct=2817, bcdDevice= 7.b4
> [135631.426266] usb 3-1.1: New USB device strings: Mfr=1, Product=2,
> SerialNumber=3
> [135631.426268] usb 3-1.1: Product: USB2.0 Hub
> [135631.426270] usb 3-1.1: Manufacturer: VIA Labs, Inc.
> [135631.426271] usb 3-1.1: SerialNumber: 000000000
> [135631.426404] usb 3-1.1: usb_probe_device
> [135631.426408] usb 3-1.1: configuration #1 chosen from 1 choice
> [135631.427998] usb 3-1.1: adding 3-1.1:1.0 (config #1, interface 0)
> [135631.428036] hub 3-1.1:1.0: usb_probe_interface
> [135631.428038] hub 3-1.1:1.0: usb_probe_interface - got id
> [135631.428041] hub 3-1.1:1.0: USB hub found
> [135631.428249] hub 3-1.1:1.0: 4 ports detected
> [135631.428251] hub 3-1.1:1.0: standalone hub
> [135631.428252] hub 3-1.1:1.0: individual port power switching
> [135631.428253] hub 3-1.1:1.0: individual port over-current protection
> [135631.429146] hub 3-1.1:1.0: TT per port
> [135631.429149] hub 3-1.1:1.0: TT requires at most 32 FS bit times (2664 ns)
> [135631.429152] hub 3-1.1:1.0: Port indicators are supported
> [135631.429153] hub 3-1.1:1.0: power on to power good time: 350ms
> [135631.429578] hub 3-1.1:1.0: local power source is good
> [135631.429963] hub 3-1.1:1.0: enabling power on all ports
> [135631.521070] usb 4-1.1: new SuperSpeed USB device number 3 using xhci_hcd
> [135631.551487] usb 3-1-port5: status 0501, change 0000, 480 Mb/s
> [135631.551656] usb 3-1-port5: indicator auto status 0
> [135631.579341] usb 4-1.1: skipped 1 descriptor after endpoint
> [135631.579593] usb 4-1.1: default language 0x0409
> [135631.580346] usb 4-1.1: udev 3, busnum 4, minor = 386
> [135631.580348] usb 4-1.1: New USB device found, idVendor=2109,
> idProduct=0817, bcdDevice= 7.b4
> [135631.580351] usb 4-1.1: New USB device strings: Mfr=1, Product=2,
> SerialNumber=3
> [135631.580352] usb 4-1.1: Product: USB3.0 Hub
> [135631.580353] usb 4-1.1: Manufacturer: VIA Labs, Inc.
> [135631.580354] usb 4-1.1: SerialNumber: 000000000
> [135631.580462] usb 4-1.1: usb_probe_device
> [135631.580465] usb 4-1.1: configuration #1 chosen from 1 choice
> [135631.582513] usb 4-1.1: adding 4-1.1:1.0 (config #1, interface 0)
> [135631.582543] hub 4-1.1:1.0: usb_probe_interface
> [135631.582546] hub 4-1.1:1.0: usb_probe_interface - got id
> [135631.582548] hub 4-1.1:1.0: USB hub found
> [135631.582740] hub 4-1.1:1.0: 4 ports detected
> [135631.582742] hub 4-1.1:1.0: standalone hub
> [135631.582744] hub 4-1.1:1.0: individual port power switching
> [135631.582745] hub 4-1.1:1.0: individual port over-current protection
> [135631.582746] hub 4-1.1:1.0: TT requires at most 8 FS bit times (666 ns)
> [135631.582748] hub 4-1.1:1.0: power on to power good time: 350ms
> [135631.583194] hub 4-1.1:1.0: local power source is good
> [135631.583218] usb 4-1.1-port1: peered to 3-1.1-port1
> [135631.583235] usb 4-1.1-port2: peered to 3-1.1-port2
> [135631.583248] usb 4-1.1-port3: peered to 3-1.1-port3
> [135631.583261] usb 4-1.1-port4: peered to 3-1.1-port4
> [135631.655764] usb 3-1.5: new high-speed USB device number 4 using xhci_hcd
> [135631.684088] hub 4-1.1:1.0: enabling power on all ports
> [135631.685155] usb 4-1-port4: status 0203, change 0000, 5.0 Gb/s
> [135631.760364] usb 3-1.5: default language 0x0409
> [135631.760754] usb 3-1.5: udev 4, busnum 3, minor = 259
> [135631.760757] usb 3-1.5: New USB device found, idVendor=2109,
> idProduct=8817, bcdDevice= 0.01
> [135631.760759] usb 3-1.5: New USB device strings: Mfr=1, Product=2,
> SerialNumber=3
> [135631.760761] usb 3-1.5: Product: USB Billboard Device
> [135631.760762] usb 3-1.5: Manufacturer: VIA Labs, Inc.
> [135631.760764] usb 3-1.5: SerialNumber: 0000000000000001
> [135631.760864] usb 3-1.5: usb_probe_device
> [135631.760867] usb 3-1.5: configuration #1 chosen from 1 choice
> [135631.761670] usb 3-1.5: adding 3-1.5:1.0 (config #1, interface 0)
> [135631.928390] usb 3-1.1-port3: status 0101 change 0001
> [135631.995776] usb 1-5: usb auto-suspend, wakeup 0
> [135632.039810] hub 3-1.1:1.0: state 7 ports 4 chg 0008 evt 0000
> [135632.040137] usb 3-1.1-port3: status 0101, change 0000, 12 Mb/s
> [135632.040300] usb 3-1.1-port3: indicator auto status 0
> [135632.215784] usb 1-3: usb auto-suspend, wakeup 0
> [135632.495840] usb 1-4: usb auto-suspend, wakeup 1
> [135632.519768] hub 1-0:1.0: hub_suspend
> [135632.523276] usb usb1: bus auto-suspend, wakeup 1
> [135632.523467] xhci_hcd 0000:00:14.0: hcd_pci_runtime_suspend: 0
> [135636.983657] xhci_hcd 0000:39:00.0: Timeout while waiting for setup
> device command
> [135636.983756] usb 4-1.1: kworker/3:1 timed out on ep0in len=0/4
> [135636.984687] hub 4-1.1:1.0: state 7 ports 4 chg 0000 evt 0000
> [135636.984903] hub 4-1.1:1.0: state 7 ports 4 chg 0000 evt 0008
> [135636.985555] hub 4-1.1:1.0: hub_suspend
> [135636.985997] usb 4-1.1: usb auto-suspend, wakeup 1
> [135637.005910] usb 4-1.1: usb auto-resume
> [135637.071744] usb 4-1.1: Waited 0ms for CONNECT
> [135637.071751] usb 4-1.1: finish resume
> [135637.072442] hub 4-1.1:1.0: hub_resume
> [135637.100903] usb 4-1.1-port3: link state change
> [135637.101072] usb 4-1.1-port3: do warm reset, port only
> [135637.160024] usb 4-1.1-port3: not warm reset yet, waiting 50ms
> [135642.359752] xhci_hcd 0000:39:00.0: Timeout while waiting for setup
> device command
> [135642.359904] usb 4-1.1: kworker/1:0 timed out on ep0in len=0/4
> [135642.360403] usb 4-1.1-port3: not warm reset yet, waiting 200ms
> [135642.567550] usb 4-1.4: device not accepting address 4, error -62
> [135642.567787] usb 4-1.1-port3: not warm reset yet, waiting 200ms
> [135642.587834] usb 3-1.1-port3: not reset yet, waiting 10ms
> [135642.608022] usb 3-1.1-port3: not reset yet, waiting 10ms
> [135642.627960] usb 3-1.1-port3: not reset yet, waiting 200ms
> [135642.779575] usb 4-1.1-port3: not warm reset yet, waiting 200ms
> [135642.836010] usb 3-1.1-port3: not reset yet, waiting 200ms
> [135642.987924] usb 4-1.1-port3: not warm reset yet, waiting 200ms
> [135642.989649] usb 4-1.1-port3: not enabled, trying warm reset again...
> [135643.044090] usb 3-1.1-port3: not reset yet, waiting 200ms
> [135643.253218] usb 3-1.1-port3: not reset yet, waiting 200ms
> [135643.254188] hub 3-1.1:1.0: state 7 ports 4 chg 0000 evt 0008
> [135643.254573] usb 3-1.1-port3: status 0100, change 0001, 12 Mb/s
> [135643.254782] usb 3-1.1-port3: indicator auto status 0
> [135643.255501] hub 4-1.1:1.0: state 7 ports 4 chg 0000 evt 0008
> [135643.256309] usb 4-1.1-port3: status 0203, change 0001, 5.0 Gb/s
> [135643.272060] usb 4-1-port4: not reset yet, waiting 10ms
> [135643.292703] usb 4-1-port4: not reset yet, waiting 10ms
> [135643.311459] usb 4-1-port4: not reset yet, waiting 200ms
> [135643.395529] usb 3-1.1-port3: debounce total 100ms stable 100ms status
> 0x100
> [135643.395546] hub 3-1.1:1.0: hub_suspend
> [135643.395900] usb 3-1.1: usb auto-suspend, wakeup 1
> [135643.399598] usb 4-1.1-port3: debounce total 100ms stable 100ms status
> 0x203
> [135648.759590] xhci_hcd 0000:39:00.0: Timeout while waiting for setup
> device command
> [135654.135471] xhci_hcd 0000:39:00.0: Timeout while waiting for setup
> device command
> [135654.343365] usb 4-1.4: device not accepting address 5, error -62
> [135654.343741] usb 4-1-port4: attempt power cycle
> [135654.423462] usb 4-1.1.3: new SuperSpeed USB device number 6 using
> xhci_hcd
> [135654.443569] usb 4-1.1.3: USB quirks for this device: 400
> [135654.443996] usb 4-1.1.3: skipped 1 descriptor after endpoint
> [135654.444015] usb 4-1.1.3: skipped 1 descriptor after endpoint
> [135654.444026] usb 4-1.1.3: skipped 1 descriptor after endpoint
> [135654.444146] usb 4-1.1.3: skipped 3 descriptors after interface
> [135654.444157] usb 4-1.1.3: skipped 1 descriptor after endpoint
> [135654.444166] usb 4-1.1.3: skipped 1 descriptor after endpoint
> [135654.444174] usb 4-1.1.3: skipped 1 descriptor after endpoint
> [135654.444231] usb 4-1.1.3: default language 0x0409
> [135654.444459] usb 4-1.1.3: udev 6, busnum 4, minor = 389
> [135654.444472] usb 4-1.1.3: New USB device found, idVendor=0bda,
> idProduct=8153, bcdDevice=30.00
> [135654.444485] usb 4-1.1.3: New USB device strings: Mfr=1, Product=2,
> SerialNumber=6
> [135654.444495] usb 4-1.1.3: Product: USB 10/100/1000 LAN
> [135654.444503] usb 4-1.1.3: Manufacturer: Realtek
> [135654.444510] usb 4-1.1.3: SerialNumber: 000001
> [135654.444978] r8152-cfgselector 4-1.1.3: usb_probe_device
> [135654.447545] r8152-cfgselector 4-1.1.3: adding 4-1.1.3:1.0 (config #1,
> interface 0)
> [135654.447741] r8152 4-1.1.3:1.0: usb_probe_interface
> [135654.447753] r8152 4-1.1.3:1.0: usb_probe_interface - got id
> [135654.527864] r8152-cfgselector 4-1.1.3: reset SuperSpeed USB device
> number 6 using xhci_hcd
> [135654.547443] r8152-cfgselector 4-1.1.3: USB quirks for this device: 400
> [135654.570025] r8152 4-1.1.3:1.0: load rtl8153a-4 v2 02/07/20 successfully
> [135654.601390] r8152 4-1.1.3:1.0 eth0: v1.12.13
> [135654.602115] hub 4-1.1:1.0: state 7 ports 4 chg 0000 evt 0008
> [135660.535346] xhci_hcd 0000:39:00.0: Timeout while waiting for setup
> device command
> [135665.911069] xhci_hcd 0000:39:00.0: Timeout while waiting for setup
> device command
> [135666.118792] usb 4-1.4: device not accepting address 7, error -62
> [135666.138995] usb 4-1-port4: not reset yet, waiting 10ms
> [135666.158967] usb 4-1-port4: not reset yet, waiting 10ms
> [135666.178919] usb 4-1-port4: not reset yet, waiting 200ms
> [135666.387360] usb 4-1-port4: not reset yet, waiting 200ms
> [135666.595345] usb 4-1-port4: not reset yet, waiting 200ms
> [135666.803419] usb 4-1-port4: not reset yet, waiting 200ms
> [135666.804994] hub 4-1:1.0: state 7 ports 4 chg 0000 evt 0010
> [135666.861597] r8152 4-1.1.3:1.0 enx00e04ceabb21: renamed from eth0
> [135666.922339] r8152 4-1.1.3:1.0 enx00e04ceabb21: carrier on
> [135667.321109] hub 4-1:1.0: state 7 ports 4 chg 0000 evt 0010
> [135667.321537] usb 4-1-port4: link state change
> [135667.321750] usb 4-1-port4: do warm reset, port only
> [135667.379354] usb 4-1-port4: not warm reset yet, waiting 50ms
> [135667.498936] hub 4-1:1.0: state 7 ports 4 chg 0000 evt 0010
> [135667.499385] usb 4-1-port4: status 0203, change 0001, 5.0 Gb/s
> [135667.642781] usb 4-1-port4: debounce total 100ms stable 100ms status
> 0x203
> [135672.822965] xhci_hcd 0000:39:00.0: Timeout while waiting for setup
> device command
> [135678.198866] xhci_hcd 0000:39:00.0: Timeout while waiting for setup
> device command
> [135678.406490] usb 4-1.4: device not accepting address 9, error -62
> [135678.430725] usb 4-1-port4: not reset yet, waiting 10ms
> [135678.450736] usb 4-1-port4: not reset yet, waiting 10ms
> [135678.470466] usb 4-1-port4: not reset yet, waiting 200ms
> [135678.678449] usb 4-1-port4: not reset yet, waiting 200ms
> [135678.890098] usb 4-1-port4: not reset yet, waiting 200ms
> [135679.094465] usb 4-1-port4: not reset yet, waiting 200ms
> [135679.095792] hub 4-1:1.0: state 7 ports 4 chg 0000 evt 0010
> [135679.608911] hub 4-1:1.0: state 7 ports 4 chg 0000 evt 0010
> [135679.609291] usb 4-1-port4: link state change
> [135679.609623] usb 4-1-port4: do warm reset, port only
> [135679.667019] usb 4-1-port4: not warm reset yet, waiting 50ms
> [135679.727000] usb 4-1-port4: not warm reset yet, waiting 200ms
> [135679.934968] usb 4-1-port4: not warm reset yet, waiting 200ms
> [135680.142806] usb 4-1-port4: not warm reset yet, waiting 200ms
> [135680.350683] usb 4-1-port4: not warm reset yet, waiting 200ms
> [135680.824878] hub 4-1:1.0: state 7 ports 4 chg 0000 evt 0010
> [135680.825079] usb 4-1-port4: link state change
> ```
> 
> The last part continues until unplugging device, but this might be a
> separate issue, as the Ethernet connection was functional.
> 
> So from
> 
>     [135654.601390] r8152 4-1.1.3:1.0 eth0: v1.12.13
> 
> to
> 
>     [135666.861597] r8152 4-1.1.3:1.0 enx00e04ceabb21: renamed from eth0
> 
> it took 12 seconds.
> 
> Is that a problem with the laptop or the adapter? And can it be fixed
> somehow?
> 
> 
> Kind regards,
> 
> Paul
> 
> 
> [1]: https://lmp-adapter.com/product/lmp-usb-c-mini-dock/?attribute_pa_color=silver
>      "LMP USB-C mini Dock (P/N 15954)"
> 
> 
> PS:
> 
> ```
> $ usb-devices
> 
> T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=480  MxCh=12
> D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=1d6b ProdID=0002 Rev=06.08
> S:  Manufacturer=Linux 6.8.0-rc5+ xhci-hcd
> S:  Product=xHCI Host Controller
> S:  SerialNumber=0000:00:14.0
> C:  #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=0mA
> I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
> E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl=256ms
> 
> T:  Bus=01 Lev=01 Prnt=01 Port=02 Cnt=01 Dev#=  2 Spd=12   MxCh= 0
> D:  Ver= 2.01 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=0cf3 ProdID=e300 Rev=00.01
> C:  #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
> I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> 
> T:  Bus=01 Lev=01 Prnt=02 Port=03 Cnt=01 Dev#=  3 Spd=12   MxCh= 0
> D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
> P:  Vendor=04f3 ProdID=2234 Rev=11.11
> S:  Manufacturer=ELAN
> S:  Product=Touchscreen
> C:  #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=100mA
> I:  If#= 0 Alt= 0 #EPs= 2 Cls=03(HID  ) Sub=00 Prot=00 Driver=usbhid
> E:  Ad=02(O) Atr=03(Int.) MxPS=  32 Ivl=2ms
> E:  Ad=81(I) Atr=03(Int.) MxPS=  64 Ivl=1ms
> 
> T:  Bus=01 Lev=01 Prnt=03 Port=04 Cnt=01 Dev#=  4 Spd=480  MxCh= 0
> D:  Ver= 2.01 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=0c45 ProdID=670c Rev=56.26
> S:  Manufacturer=CN09GTFMLOG008C8B7FWA01
> S:  Product=Integrated_Webcam_HD
> C:  #Ifs= 2 Cfg#= 1 Atr=80 MxPwr=500mA
> I:  If#= 0 Alt= 0 #EPs= 1 Cls=0e(video) Sub=01 Prot=00 Driver=uvcvideo
> E:  Ad=83(I) Atr=03(Int.) MxPS=  16 Ivl=4ms
> I:  If#= 1 Alt= 0 #EPs= 1 Cls=0e(video) Sub=02 Prot=00 Driver=uvcvideo
> E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> 
> T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=5000 MxCh= 6
> D:  Ver= 3.00 Cls=09(hub  ) Sub=00 Prot=03 MxPS= 9 #Cfgs=  1
> P:  Vendor=1d6b ProdID=0003 Rev=06.08
> S:  Manufacturer=Linux 6.8.0-rc5+ xhci-hcd
> S:  Product=xHCI Host Controller
> S:  SerialNumber=0000:00:14.0
> C:  #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=0mA
> I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
> E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl=256ms
> 
> T:  Bus=03 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=480  MxCh= 2
> D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=1d6b ProdID=0002 Rev=06.08
> S:  Manufacturer=Linux 6.8.0-rc5+ xhci-hcd
> S:  Product=xHCI Host Controller
> S:  SerialNumber=0000:39:00.0
> C:  #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=0mA
> I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
> E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl=256ms
> 
> T:  Bus=03 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=480  MxCh= 5
> D:  Ver= 2.10 Cls=09(hub  ) Sub=00 Prot=02 MxPS=64 #Cfgs=  1
> P:  Vendor=2109 ProdID=2817 Rev=05.e3
> S:  Manufacturer=VIA Labs, Inc.
> S:  Product=USB2.0 Hub
> S:  SerialNumber=000000000
> C:  #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=0mA
> I:  If#= 0 Alt= 1 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=02 Driver=hub
> E:  Ad=81(I) Atr=03(Int.) MxPS=   1 Ivl=256ms
> 
> T:  Bus=03 Lev=02 Prnt=02 Port=00 Cnt=01 Dev#=  3 Spd=480  MxCh= 4
> D:  Ver= 2.10 Cls=09(hub  ) Sub=00 Prot=02 MxPS=64 #Cfgs=  1
> P:  Vendor=2109 ProdID=2817 Rev=07.b4
> S:  Manufacturer=VIA Labs, Inc.
> S:  Product=USB2.0 Hub
> S:  SerialNumber=000000000
> C:  #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=0mA
> I:  If#= 0 Alt= 1 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=02 Driver=hub
> E:  Ad=81(I) Atr=03(Int.) MxPS=   1 Ivl=256ms
> 
> T:  Bus=03 Lev=02 Prnt=03 Port=04 Cnt=01 Dev#=  5 Spd=480  MxCh= 0
> D:  Ver= 2.01 Cls=11(blbrd) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
> P:  Vendor=2109 ProdID=8817 Rev=00.01
> S:  Manufacturer=VIA Labs, Inc.
> S:  Product=USB Billboard Device
> S:  SerialNumber=0000000000000001
> C:  #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=100mA
> I:  If#= 0 Alt= 0 #EPs= 0 Cls=11(blbrd) Sub=00 Prot=00 Driver=(none)
> 
> T:  Bus=04 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=10000 MxCh= 2
> D:  Ver= 3.10 Cls=09(hub  ) Sub=00 Prot=03 MxPS= 9 #Cfgs=  1
> P:  Vendor=1d6b ProdID=0003 Rev=06.08
> S:  Manufacturer=Linux 6.8.0-rc5+ xhci-hcd
> S:  Product=xHCI Host Controller
> S:  SerialNumber=0000:39:00.0
> C:  #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=0mA
> I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
> E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl=256ms
> 
> T:  Bus=04 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=5000 MxCh= 4
> D:  Ver= 3.20 Cls=09(hub  ) Sub=00 Prot=03 MxPS= 9 #Cfgs=  1
> P:  Vendor=2109 ProdID=0817 Rev=05.e3
> S:  Manufacturer=VIA Labs, Inc.
> S:  Product=USB3.0 Hub
> S:  SerialNumber=000000000
> C:  #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=0mA
> I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
> E:  Ad=81(I) Atr=13(Int.) MxPS=   2 Ivl=16ms
> 
> T:  Bus=04 Lev=02 Prnt=02 Port=00 Cnt=01 Dev#=  3 Spd=5000 MxCh= 4
> D:  Ver= 3.20 Cls=09(hub  ) Sub=00 Prot=03 MxPS= 9 #Cfgs=  1
> P:  Vendor=2109 ProdID=0817 Rev=07.b4
> S:  Manufacturer=VIA Labs, Inc.
> S:  Product=USB3.0 Hub
> S:  SerialNumber=000000000
> C:  #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=0mA
> I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
> E:  Ad=81(I) Atr=13(Int.) MxPS=   2 Ivl=16ms
> 
> T:  Bus=04 Lev=03 Prnt=03 Port=02 Cnt=01 Dev#=  5 Spd=5000 MxCh= 0
> D:  Ver= 3.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 9 #Cfgs=  2
> P:  Vendor=0bda ProdID=8153 Rev=30.00
> S:  Manufacturer=Realtek
> S:  Product=USB 10/100/1000 LAN
> S:  SerialNumber=000001
> C:  #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=288mA
> I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=00 Driver=r8152
> E:  Ad=02(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> E:  Ad=81(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> E:  Ad=83(I) Atr=03(Int.) MxPS=   2 Ivl=16ms
> 
> T:  Bus=04 Lev=02 Prnt=05 Port=03 Cnt=01 Dev#=  4 Spd=5000 MxCh= 0
> D:  Ver= 3.20 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 9 #Cfgs=  1
> P:  Vendor=058f ProdID=8468 Rev=01.00
> S:  Manufacturer=Generic
> S:  Product=Mass Storage Device
> S:  SerialNumber=058F84688461
> C:  #Ifs= 1 Cfg#= 1 Atr=80 MxPwr=800mA
> I:  If#= 0 Alt= 0 #EPs= 2 Cls=08(stor.) Sub=06 Prot=50 Driver=usb-storage
> E:  Ad=01(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> ```

-- 
heikki

