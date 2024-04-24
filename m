Return-Path: <linux-kernel+bounces-157568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AFF8B1308
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25F621F256CA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D37C1EB3F;
	Wed, 24 Apr 2024 18:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZuoOT0V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAF91DDF4
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 18:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713985090; cv=none; b=o5dkzvHZAuFRvhAhgsVZgpB5y21dYxAJpI45E2T0TkoJhfiId490TRNzr0tC5bBQaGVQSBFqg4QYcfTUVozRosDKQ0blK+NDa3U52WAkdq7/mheUMZMqh3LwYc5hyKufL1awMEuxdUa4ocAfZE5c7L2sID0hl/orq1JRGg/GE+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713985090; c=relaxed/simple;
	bh=BjFBDKkzHGMEVkv9tfjwZkzhELE3KKcTqpHmRJLC2uU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SBCLuf1gg9FX40nJLpByrpn0yllMxVzO2etBhBIVizxg30TBFNWfn8Bphk/FcyAWFG+j+/m1hY0gkSnitSSWzMf72tnv5X6o2ptdQRbmPlZOrQlONCvuCeqDvyeNWCj04hxiCZSdelYOIwCXziBUNyEuQ4RprsiUJo6c7kisl3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZuoOT0V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 683C6C113CD;
	Wed, 24 Apr 2024 18:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713985089;
	bh=BjFBDKkzHGMEVkv9tfjwZkzhELE3KKcTqpHmRJLC2uU=;
	h=Date:From:To:Cc:Subject:From;
	b=aZuoOT0VLfrU1aHNn0890hmbNvpJXRxwflhQkotP8s9Fp/aGbRziSff44bYyHQhWA
	 l1T/ASrdtgCVzZsgY1EsvORPpJbrSPRwNQ+cYtVW2bNZhuI1zO1L1xvIWpLSf6QI8o
	 92zOOkfdUe6VTcmJpC/T2F9uZEG0p28kKO7UdxguHwmA+mrjA7RMdX1ELShFkOHVoI
	 dfEk22tW3+ihoQTIt2EKtezKCWffqoNouQta4jWgHQqkr3oT3q2BI/JuSIBKQSXntY
	 SQQ8GjqrG44OWX0UURrJqcvDNVRgnJQn5WmlqGYtrv/CG2D3hww3PFNXO4eMvYm2Z8
	 6B2lwJVdveW8w==
Date: Wed, 24 Apr 2024 14:58:06 -0400
From: Paul Gortmaker <paulg@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: Intermittent Qemu boot hang/regression traced back to INT 0x80
 changes
Message-ID: <20240424185806.GB101235@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Richard (via the Yocto auto-builder) reported a sporadic (once per
hundreds) boot hang during the PCI bus boot mapping on v6.6.x
for both x86 and x86_64.

On x86, I isolated it to the INT 0x80 backports added to v6.6.7:

239bff0171a8 x86/tdx: Allow 32-bit emulation by default
22ca647c8f88 x86/entry: Do not allow external 0x80 interrupts
4591766ff655 x86/entry: Convert INT 0x80 emulation to IDTENTRY
34c686e5be2f x86/coco: Disable 32-bit emulation by default on TDX and SEV
f259af26ee04 x86: Introduce ia32_enabled()

The ia32_enabled() is a trivial compile dependency and the Yocto use
case doesn't even compile arch/x86/coco/tdx/tdx.c - leaving just the
middle three commits.  I didn't try and bisect within those, since it
seemed relatively clear to me they were assumed to be taken as a group.

To confirm my diagnosis, I reverted this group of changes on v6.6.7
baseline, and the sporadic PCI-hang went away.

I then went to mainline and tested where it was added:

commit f35e46631b28a63ca3887d7afef1a65a5544da52
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu Dec 7 11:56:34 2023 -0800

    Merge tag 'x86-int80-20231207' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip

Took about 400 runs, but the PCI-hang eventually showed up.

Of course, the BHI changes touch a lot of the same files, and I was
wondering if the issue would remain.  Tested v6.6.27 (has BHI backports)
and it would still happen.  Can no longer easily revert the INT80
changes once they are buried under the BHI changes anymore though.

I then took v6.9-rc5 and let it run overnight (700 boots) and I "caught"
three instances of the PCI-hang.

Finally I took linux-next from today (next-20240424) and confirmed a
PCI-hang within 50 boots.  I can't explain the variability other than it
being a shared machine where I ran the tests.

Not sure what to do next.  Figured step #1 was to report it, at least.
A whole bunch of extra details are in the Yocto case:

https://bugzilla.yoctoproject.org/show_bug.cgi?id=15463

..including the v6.9-rc5 .config and the full qemu arg list.

Paul.
--

Linux version 6.9.0-rc5-next-20240424-yocto-standard (oe-user@oe-host) (i686-poky-linux-gcc (GCC) 13.2.0, GNU ld (GNU Binutils) 2.42.0.20240216) #1 SMP PREEMPT_DYNAMIC
 Wed Apr 24 10:57:01 UTC 2024
BIOS-provided physical RAM map:
BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[...]
acpi PNP0A08:00: _OSC: platform does not support [LTR]
acpi PNP0A08:00: _OSC: OS now controls [PME PCIeCapability]
acpi resource window ([0x100000000-0x8ffffffff] ignored, not CPU addressable)
PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
pci_bus 0000:00: root bus resource [mem 0x10000000-0xafffffff window]
pci_bus 0000:00: root bus resource [mem 0xc0000000-0xfebfffff window]
pci_bus 0000:00: root bus resource [bus 00-ff]
pci 0000:00:00.0: [8086:29c0] type 00 class 0x060000 conventional PCI endpoint
pci 0000:00:01.0: [1234:1111] type 00 class 0x030000 conventional PCI endpoint
pci 0000:00:01.0: BAR 0 [mem 0xfd000000-0xfdffffff pref]
pci 0000:00:01.0: BAR 2 [mem 0xfebd0000-0xfebd0fff]
pci 0000:00:01.0: ROM [mem 0xfebc0000-0xfebcffff pref]
pci 0000:00:01.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
pci 0000:00:02.0: [1af4:1000] type 00 class 0x020000 conventional PCI endpoint
pci 0000:00:02.0: BAR 0 [io  0xc040-0xc05f]
pci 0000:00:02.0: BAR 1 [mem 0xfebd1000-0xfebd1fff]
pci 0000:00:02.0: BAR 4 [mem 0xfe000000-0xfe003fff 64bit pref]
pci 0000:00:02.0: ROM [mem 0xfeb80000-0xfebbffff pref]
pci 0000:00:03.0: [1af4:1005] type 00 class 0x00ff00 conventional PCI endpoint
pci 0000:00:03.0: BAR 0 [io  0xc060-0xc07f]
pci 0000:00:03.0: BAR 1 [mem 0xfebd2000-0xfebd2fff]
pci 0000:00:03.0: BAR 4 [mem 0xfe004000-0xfe007fff 64bit pref]
pci 0000:00:1d.0: [8086:2934] type 00 class 0x0c0300 conventional PCI endpoint
pci 0000:00:1d.0: BAR 4 [io  0xc080-0xc09f]
pci 0000:00:1d.1: [8086:2935] type 00 class 0x0c0300 conventional PCI endpoint
pci 0000:00:1d.1: BAR 4 [io  0xc0a0-0xc0bf]
pci 0000:00:1d.2: [8086:2936] type 00 class 0x0c0300 conventional PCI endpoint
<hang - not always exactly here, but always in this block of PCI printk>

