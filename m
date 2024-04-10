Return-Path: <linux-kernel+bounces-138027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B49589EB3E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 880ABB25D26
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0313A1A2;
	Wed, 10 Apr 2024 06:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Gxbtl4QH"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEAB38393;
	Wed, 10 Apr 2024 06:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712731575; cv=none; b=m0LDGGZolXTl1AG8iAPniRIZykHuN3tszcyrluGMNbHZxWhVMcLQj4Et67BcErzffwQDoeygAd9CUE5SuTvL1FUeHcf3g9S2mlSWX/dkaaPsOE9vNw1pEeAnttVLIAP5KOFKnn5J/J95vjFzCpsXjL1z9Tb6xg+/KMRmp6VbSe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712731575; c=relaxed/simple;
	bh=+pF9I2XN4L8EdU3a048qz4LjVed43kflGVzBMFKXccQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sObDRID0Hm51/tqEzqrWYD59ytPOh+yh7gOjbX9r14vH0pB+K96BhijbR/B5k4ghRsUBXX4yS2MBc5dTGtkyzYMQ074MpgTxW/y+MGPCH3RUnA2CyLtyZnwEOvGpXnq2Rv0JWOzwjdd2+cJzWn8Vy0mlK+Zan4tG9cLGK5gze6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=fail (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Gxbtl4QH reason="signature verification failed"; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7A459C0002;
	Wed, 10 Apr 2024 06:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712731569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vbwOnpHSkynCLQk2x+//RI1LAkShfuWIbus+5hFbrUs=;
	b=Gxbtl4QHT23A3pmBCIenu4PuNFbehDrbgjujEOMjr+IZFK6toi9HR9U266+yJ141dhOFsy
	OGcA9y6x4Ydgq5/D6iq0BNjeKpB3nibZ9FuZX7WDTUdfjb27h3cv9dcH7Dw9sSt+VVFeYr
	5jN+GSHwYHlSZ/Xl5XVCyxE67vgico75iYgWUuAKm0daPP7TcsjqBrhB2o4WIHfoGbffkH
	X+cQ9Khvq1rLoZoFZ2Ou8/blS6CBfcVLVbVF2Ff/dEfCDKRs4YHeiJCyJxS+WGOQ2MIiEk
	vVXOSmAsdgbQPOcrtW6zRD+ocS2bmzCivMIIYKuHHcy8aTz+Ea7mgK/9fD9PSw==
Date: Wed, 10 Apr 2024 08:45:53 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Andrew Lunn
 <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell King
 <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Christophe
 Leroy <christophe.leroy@csgroup.eu>, Herve Codina
 <herve.codina@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>, Heiner
 Kallweit <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Jonathan Corbet <corbet@lwn.net>, Marek
 =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>, Piergiorgio Beruto
 <piergiorgio.beruto@gmail.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?B?Tmljb2zDsg==?= Veronese <nicveronese@gmail.com>, Simon Horman
 <horms@kernel.org>, mwojtas@chromium.org
Subject: Re: [PATCH net-next v11 01/13] net: phy: Introduce ethernet link
 topology representation
Message-ID: <20240410084553.2c85fd3d@device-28.home>
In-Reply-To: <20240409201553.GA4124869@dev-arch.thelio-3990X>
References: <20240404093004.2552221-1-maxime.chevallier@bootlin.com>
	<20240404093004.2552221-2-maxime.chevallier@bootlin.com>
	<20240409201553.GA4124869@dev-arch.thelio-3990X>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Nathan,

On Tue, 9 Apr 2024 13:15:53 -0700
Nathan Chancellor <nathan@kernel.org> wrote:

> Hi Maxime,
> 
> On Thu, Apr 04, 2024 at 11:29:51AM +0200, Maxime Chevallier wrote:
[...]
> 
> I bisected a crash that I see on one of my test devices to this change
> in -next as commit 6916e461e793 ("net: phy: Introduce ethernet link
> topology representation"). Here is the stack trace passed through
> scripts/decode_stacktrace.sh:

Thanks for the report, I'm on it :) I'll let you know if I can
figure-out what's wrong and hopefully fix it :)

Thanks !

Maxime

> 
> [    0.000000] Linux version 6.9.0-rc2-debug-00664-g6916e461e793 (nathan@dev-arch.thelio-3990X) (x86_64-linux-gcc (GCC) 13.2.0, GNU ld (GNU Binutils) 2.41) #1 SMP PREEMPT_DYNAMIC Tue Apr  9 12:13:50 MST 2024
> ...
> [    5.616112] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [    5.616148] #PF: supervisor write access in kernel mode
> [    5.616168] #PF: error_code(0x0002) - not-present page
> [    5.616185] PGD 0 P4D 0
> [    5.616199] Oops: 0002 [#1] PREEMPT SMP PTI
> [    5.616216] CPU: 1 PID: 263 Comm: (udev-worker) Not tainted 6.9.0-rc2-debug-00664-g6916e461e793 #1 70fb9ac6019045b1a6f31076c518c9320a4bc47a
> [    5.616255] Hardware name: ASUSTeK COMPUTER INC. Q302LA/Q302LA, BIOS Q302LA.203 05/15/2014
> [    5.616279] RIP: 0010:_raw_spin_lock (arch/x86/include/asm/atomic.h:115 (discriminator 4) include/linux/atomic/atomic-arch-fallback.h:2170 (discriminator 4) include/linux/atomic/atomic-instrumented.h:1302 (discriminator 4) include/asm-generic/qspinlock.h:111 (discriminator 4) include/linux/spinlock.h:187 (discriminator 4) include/linux/spinlock_api_smp.h:134 (discriminator 4) kernel/locking/spinlock.c:154 (discriminator 4)) 
> [ 5.616301] Code: 00 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 65 ff 05 e8 51 30 4c 31 c0 ba 01 00 00 00 <f0> 0f b1 17 75 05 c3 cc cc cc cc 89 c6 e8 97 01 00 00 90 c3 cc cc
> All code
> ========
>    0:	00 66 90             	add    %ah,-0x70(%rsi)
>    3:	90                   	nop
>    4:	90                   	nop
>    5:	90                   	nop
>    6:	90                   	nop
>    7:	90                   	nop
>    8:	90                   	nop
>    9:	90                   	nop
>    a:	90                   	nop
>    b:	90                   	nop
>    c:	90                   	nop
>    d:	90                   	nop
>    e:	90                   	nop
>    f:	90                   	nop
>   10:	90                   	nop
>   11:	90                   	nop
>   12:	90                   	nop
>   13:	f3 0f 1e fa          	endbr64
>   17:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
>   1c:	65 ff 05 e8 51 30 4c 	incl   %gs:0x4c3051e8(%rip)        # 0x4c30520b
>   23:	31 c0                	xor    %eax,%eax
>   25:	ba 01 00 00 00       	mov    $0x1,%edx
>   2a:*	f0 0f b1 17          	lock cmpxchg %edx,(%rdi)		<-- trapping instruction
>   2e:	75 05                	jne    0x35
>   30:	c3                   	ret
>   31:	cc                   	int3
>   32:	cc                   	int3
>   33:	cc                   	int3
>   34:	cc                   	int3
>   35:	89 c6                	mov    %eax,%esi
>   37:	e8 97 01 00 00       	call   0x1d3
>   3c:	90                   	nop
>   3d:	c3                   	ret
>   3e:	cc                   	int3
>   3f:	cc                   	int3
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	f0 0f b1 17          	lock cmpxchg %edx,(%rdi)
>    4:	75 05                	jne    0xb
>    6:	c3                   	ret
>    7:	cc                   	int3
>    8:	cc                   	int3
>    9:	cc                   	int3
>    a:	cc                   	int3
>    b:	89 c6                	mov    %eax,%esi
>    d:	e8 97 01 00 00       	call   0x1a9
>   12:	90                   	nop
>   13:	c3                   	ret
>   14:	cc                   	int3
>   15:	cc                   	int3
> [    5.616355] RSP: 0000:ffffc3aec04bba38 EFLAGS: 00010246
> [    5.617083] RAX: 0000000000000000 RBX: ffffa032d3db1c40 RCX: 0000000000000000
> [    5.617785] RDX: 0000000000000001 RSI: ffffffffc10385e3 RDI: 0000000000000000
> [    5.618502] RBP: ffffa032cdb2f800 R08: 0000000000000020 R09: 0000000000000000
> [    5.619224] R10: ffffc3aec04bba40 R11: 0000000000000001 R12: 0000000000000000
> [    5.619970] R13: 0000000000000000 R14: ffffa032c5ea3000 R15: ffffa032c11f80a8
> [    5.620722] FS:  00007f67d520b540(0000) GS:ffffa033d6e80000(0000) knlGS:0000000000000000
> [    5.621393] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    5.622152] CR2: 0000000000000000 CR3: 0000000103eaa004 CR4: 00000000001706f0
> [    5.622942] Call Trace:
> [    5.623653]  <TASK>
> [    5.624329] ? __die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434) 
> [    5.625025] ? page_fault_oops (arch/x86/mm/fault.c:713 (discriminator 1)) 
> [    5.625791] ? exc_page_fault (arch/x86/include/asm/paravirt.h:693 arch/x86/mm/fault.c:1513 arch/x86/mm/fault.c:1563) 
> [    5.626525] ? asm_exc_page_fault (arch/x86/include/asm/idtentry.h:623) 
> [    5.626535] ? phy_link_topo_add_phy (drivers/net/phy/phy_link_topology.c:46) libphy
> [    5.627954] ? _raw_spin_lock (arch/x86/include/asm/atomic.h:115 (discriminator 4) include/linux/atomic/atomic-arch-fallback.h:2170 (discriminator 4) include/linux/atomic/atomic-instrumented.h:1302 (discriminator 4) include/asm-generic/qspinlock.h:111 (discriminator 4) include/linux/spinlock.h:187 (discriminator 4) include/linux/spinlock_api_smp.h:134 (discriminator 4) kernel/locking/spinlock.c:154 (discriminator 4)) 
> [    5.627963] phy_link_topo_add_phy (include/linux/xarray.h:977 drivers/net/phy/phy_link_topology.c:80) libphy
> [    5.629462] phy_attach_direct (drivers/net/phy/phy_device.c:1516) libphy
> [    5.629504] phylink_connect_phy (drivers/net/phy/phylink.c:1983) phylink
> [    5.631030] ax88772_bind (drivers/net/usb/asix_devices.c:710 drivers/net/usb/asix_devices.c:919) asix
> [    5.631049] usbnet_probe (drivers/net/usb/usbnet.c:1745) usbnet
> [    5.631062] ? __pfx_read_tsc (arch/x86/kernel/tsc.c:1129) 
> [    5.631068] ? ktime_get_mono_fast_ns (kernel/time/timekeeping.c:438 kernel/time/timekeeping.c:452 kernel/time/timekeeping.c:492) 
> [    5.631075] usb_probe_interface (drivers/usb/core/driver.c:400) 
> [    5.631082] really_probe (drivers/base/dd.c:578 drivers/base/dd.c:656) 
> [    5.631087] ? __pfx___driver_attach (drivers/base/dd.c:1155) 
> [    5.631091] __driver_probe_device (drivers/base/dd.c:798) 
> [    5.631094] driver_probe_device (drivers/base/dd.c:828) 
> [    5.631098] __driver_attach (drivers/base/dd.c:1215) 
> [    5.631102] bus_for_each_dev (drivers/base/bus.c:368) 
> [    5.631108] bus_add_driver (drivers/base/bus.c:673) 
> [    5.631112] driver_register (drivers/base/driver.c:246) 
> [    5.631117] usb_register_driver (drivers/usb/core/driver.c:1068) 
> [    5.631120] ? __pfx_asix_driver_init (drivers/net/usb/asix_devices.c:745) asix
> [    5.631134] do_one_initcall (init/main.c:1238) 
> [    5.631141] do_init_module (kernel/module/main.c:2538) 
> [    5.631147] init_module_from_file (kernel/module/main.c:3169) 
> [    5.631153] idempotent_init_module (include/linux/spinlock.h:351 kernel/module/main.c:3131 kernel/module/main.c:3185) 
> [    5.631158] __x64_sys_finit_module (include/linux/file.h:47 kernel/module/main.c:3207 kernel/module/main.c:3189 kernel/module/main.c:3189) 
> [    5.631163] do_syscall_64 (arch/x86/entry/common.c:52 (discriminator 1) arch/x86/entry/common.c:83 (discriminator 1)) 
> [    5.631168] ? do_syscall_64 (arch/x86/include/asm/cpufeature.h:173 arch/x86/entry/common.c:98) 
> [    5.631171] ? do_syscall_64 (arch/x86/include/asm/cpufeature.h:173 arch/x86/entry/common.c:98) 
> [    5.631174] ? exc_page_fault (arch/x86/include/asm/paravirt.h:693 arch/x86/mm/fault.c:1513 arch/x86/mm/fault.c:1563) 
> [    5.631179] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129) 
> [    5.631187] RIP: 0033:0x7f67d4d2488d
> [ 5.631217] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 73 14 0d 00 f7 d8 64 89 01 48
> All code
> ========
>    0:	ff c3                	inc    %ebx
>    2:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
>    9:	00 00 00 
>    c:	90                   	nop
>    d:	f3 0f 1e fa          	endbr64
>   11:	48 89 f8             	mov    %rdi,%rax
>   14:	48 89 f7             	mov    %rsi,%rdi
>   17:	48 89 d6             	mov    %rdx,%rsi
>   1a:	48 89 ca             	mov    %rcx,%rdx
>   1d:	4d 89 c2             	mov    %r8,%r10
>   20:	4d 89 c8             	mov    %r9,%r8
>   23:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
>   28:	0f 05                	syscall
>   2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
>   30:	73 01                	jae    0x33
>   32:	c3                   	ret
>   33:	48 8b 0d 73 14 0d 00 	mov    0xd1473(%rip),%rcx        # 0xd14ad
>   3a:	f7 d8                	neg    %eax
>   3c:	64 89 01             	mov    %eax,%fs:(%rcx)
>   3f:	48                   	rex.W
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
>    6:	73 01                	jae    0x9
>    8:	c3                   	ret
>    9:	48 8b 0d 73 14 0d 00 	mov    0xd1473(%rip),%rcx        # 0xd1483
>   10:	f7 d8                	neg    %eax
>   12:	64 89 01             	mov    %eax,%fs:(%rcx)
>   15:	48                   	rex.W
> [    5.631219] RSP: 002b:00007fff5a3fea18 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> [    5.631223] RAX: ffffffffffffffda RBX: 000055883cfb16b0 RCX: 00007f67d4d2488d
> [    5.631226] RDX: 0000000000000004 RSI: 00007f67d52ea376 RDI: 0000000000000019
> [    5.631229] RBP: 00007f67d52ea376 R08: 0000000000000001 R09: fffffffffffffe88
> [    5.631231] R10: 0000000000000050 R11: 0000000000000246 R12: 0000000000020000
> [    5.631233] R13: 000055883cfaf050 R14: 0000000000000000 R15: 000055883cfb6ea0
> [    5.631238]  </TASK>
> [    5.631239] Modules linked in: sha512_ssse3 uvcvideo btusb(+) sha1_ssse3 ptp aesni_intel btrtl pps_core videobuf2_vmalloc ax88796b snd_hda_codec_hdmi asix(+) videobuf2_memops btintel mac80211 crypto_simd phylink cryptd uvc btbcm videobuf2_v4l2 selftests spi_nor mtd btmtk rapl videodev asus_nb_wmi libarc4 usbnet joydev vfat ak8975 iTCO_wdt asus_wmi mii iwlwifi videobuf2_common hid_multitouch intel_cstate at24 intel_pmc_bxt spi_intel_platform snd_hda_codec_realtek sparse_keymap fat mousedev hid_generic mei_pxp iTCO_vendor_support intel_rapl_msr spi_intel i915 mei_hdcp platform_profile libphy mc bluetooth intel_uncore snd_hda_codec_generic i2c_i801 snd_hda_scodec_component psmouse crc16 cfg80211 pcspkr processor_thermal_device_pci_legacy snd_hda_intel usbhid ecdh_generic i2c_smbus snd_intel_dspcfg intel_soc_dts_iosf processor_thermal_device lpc_ich rfkill i2c_algo_bit drm_buddy inv_mpu6050_i2c snd_hda_codec mei_me i2c_mux processor_thermal_wt_hint ttm snd_hwdep processor_thermal_rf
 im mei processor_thermal_rapl intel_gtt
> [    5.631322]  inv_mpu6050 video snd_hda_core drm_display_helper intel_rapl_common snd_pcm inv_sensors_timestamp snd_timer processor_thermal_wt_req drm_kms_helper dell_smo8800 acpi_als int3400_thermal pinctrl_lynxpoint industrialio_triggered_buffer processor_thermal_power_floor snd processor_thermal_mbox cec wmi kfifo_buf int340x_thermal_zone acpi_thermal_rel industrialio soundcore soc_button_array asus_wireless mac_hid pkcs8_key_parser crypto_user drm fuse dm_mod loop nfnetlink zram ip_tables x_tables serio_raw atkbd libps2 vivaldi_fmap sha256_ssse3 xhci_pci xhci_pci_renesas i8042 serio btrfs blake2b_generic libcrc32c crc32c_generic crc32c_intel xor raid6_pq
> [    5.631374] CR2: 0000000000000000
> [    5.631377] ---[ end trace 0000000000000000 ]---
> 
> If there is any additional information I can provide or patches I can
> test, I am more than happy to do so.
> 
> Cheers,
> Nathan
> 
> # bad: [11cb68ad52ac78c81e33b806b531f097e68edfa2] Add linux-next specific files for 20240408
> # good: [fec50db7033ea478773b159e0e2efb135270e3b7] Linux 6.9-rc3
> git bisect start '11cb68ad52ac78c81e33b806b531f097e68edfa2' 'fec50db7033ea478773b159e0e2efb135270e3b7'
> # bad: [b5ae7d7ff5458d024c8d8be346e405dd53bfe573] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git
> git bisect bad b5ae7d7ff5458d024c8d8be346e405dd53bfe573
> # good: [54f6c30962ec3738fa235457efe3a304f180e335] Merge branch 'renesas-clk' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git
> git bisect good 54f6c30962ec3738fa235457efe3a304f180e335
> # bad: [267e31750ae89f845cfe7df8f577b19482d9ef9b] Merge branch 'phy-listing-link_topology-tracking'
> git bisect bad 267e31750ae89f845cfe7df8f577b19482d9ef9b
> # good: [992c287d87780abd184c67a303dec3361b7cb408] dt-bindings: net: snps,dwmac: Align 'snps,priority' type definition
> git bisect good 992c287d87780abd184c67a303dec3361b7cb408
> # good: [0ccf50df61f98a9f98d46524be4baa00c88c499d] Merge tag 'ath-next-20240402' of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath
> git bisect good 0ccf50df61f98a9f98d46524be4baa00c88c499d
> # good: [0cd1453b7e55064d06b49eebe34ffb43748ba12e] mlxsw: pci: Remove mlxsw_pci_sdq_count()
> git bisect good 0cd1453b7e55064d06b49eebe34ffb43748ba12e
> # good: [da48a65f3ff4155364fb9e3efe0bfba58291da6b] bnxt_en: Fix PTP firmware timeout parameter
> git bisect good da48a65f3ff4155364fb9e3efe0bfba58291da6b
> # good: [ff8877b04ef282b2bdb16c9dccc2e42216a34f62] netlink: specs: ethtool: define header-flags as an enum
> git bisect good ff8877b04ef282b2bdb16c9dccc2e42216a34f62
> # good: [9f06f87fef689d28588cde8c7ebb00a67da34026] net: skbuff: generalize the skb->decrypted bit
> git bisect good 9f06f87fef689d28588cde8c7ebb00a67da34026
> # bad: [0ec5ed6c130e3906ba4ec82d740444a21504fbbf] net: sfp: pass the phy_device when disconnecting an sfp module's PHY
> git bisect bad 0ec5ed6c130e3906ba4ec82d740444a21504fbbf
> # good: [d133ef1ee2a256ba5a589493cd28dccfede6af11] net: phy: marvell: implement cable test for 88E1111
> git bisect good d133ef1ee2a256ba5a589493cd28dccfede6af11
> # bad: [6916e461e7933d3d003441291c543938f2ccb371] net: phy: Introduce ethernet link topology representation
> git bisect bad 6916e461e7933d3d003441291c543938f2ccb371
> # first bad commit: [6916e461e7933d3d003441291c543938f2ccb371] net: phy: Introduce ethernet link topology representation


