Return-Path: <linux-kernel+bounces-121534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E891488EA1D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C938B2C158
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696BB12FF8F;
	Wed, 27 Mar 2024 15:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwiHh61d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8938F12EBEB;
	Wed, 27 Mar 2024 15:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711553205; cv=none; b=txsfxYAcqz4dAXyeBFlHHudDXHC2nuhrmG7CTJV5M3Q8+5b8iLeUFV+IFKjaG2jdZCrvSMvon5/Kbk0RPXfwTM24qYHt1mohddzqvy7Q1EAcToZz4l7z3WKcdkuYW8xpcBQTPFijY99USe1/IXFAoPwwEGB4S/AtZLjqOrh3d/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711553205; c=relaxed/simple;
	bh=xfNHOSKv48bSU7NuAi7I0qBTiozewQufq628NrTXsiM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=J0gu6nMF7aQ4mxuunhgFlsuJ76i1fvEvRbPPYzEnzR/C5rqxMY4DepCwS/J5uCEa64W+3eAlw0814nsP0bUueBDJlXU2gQlf6QoyEiyr2J13C9hWpzp6HiOBASHlykyS2S/CCWNzgav9hm+TkKKcGfw4rcMm8bm0IyRO0Wy7uCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwiHh61d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2628EC433C7;
	Wed, 27 Mar 2024 15:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711553205;
	bh=xfNHOSKv48bSU7NuAi7I0qBTiozewQufq628NrTXsiM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=iwiHh61devQAR73M1P77U063PFLm2SEQJmoM8HLXDkAM2izfSJxWRsXlGkkSUElwj
	 IPd5eVgWYftZKh1l94QfKnxanq85d3o9b8jxFsrcqN+IbA6Y/+SHpjCstQ7jCstWgr
	 vK5e0XRgfHxlOyiBfn0fAwsqMfy88RkYcmNcuslW4N3F9RA5fLdBQqIuQkWhCTApBG
	 hwKMPM68lhKt+sVnaX8PzaYXb7VViDqhUunzy5u7Y8m1/y+zuQLCWr5paKsw+lUsmP
	 gv+fbtKJjT0i0o+qwGpbmPZyYw7Q3e1yRdza0HsCpJJp2HjwCfmpu24bIPrLmhvOJz
	 7r8RkiDGTotWw==
From: Kalle Valo <kvalo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Breno Leitao <leitao@debian.org>,  Jeff Johnson
 <quic_jjohnson@quicinc.com>,  Jeff Johnson <jjohnson@kernel.org>,
  keescook@chromium.org,  "open list:NETWORKING DRIVERS (WIRELESS)"
 <linux-wireless@vger.kernel.org>,  "open list:QUALCOMM ATHEROS ATH10K
 WIRELESS DRIVER" <ath10k@lists.infradead.org>,  open list
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ath10k: allocate dummy net_device dynamically
References: <20240319104754.2535294-1-leitao@debian.org>
	<9fcdb857-da62-4832-ae11-043fe993e4ad@quicinc.com>
	<20240321072821.59f56757@kernel.org>
	<5039256c-03eb-4cda-8d11-49e4561cf1ef@quicinc.com>
	<20240321151744.246ce2d0@kernel.org> <Zf2ceu2O47lLbKU3@gmail.com>
	<20240322082336.49f110cc@kernel.org>
Date: Wed, 27 Mar 2024 17:26:41 +0200
In-Reply-To: <20240322082336.49f110cc@kernel.org> (Jakub Kicinski's message of
	"Fri, 22 Mar 2024 08:23:36 -0700")
Message-ID: <87le637l1q.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> On Fri, 22 Mar 2024 07:58:02 -0700 Breno Leitao wrote:
>> > Looks like init_dummy_netdev wipes the netdev structure clean, so I
>> > don't think we can use it directly as the setup function, Breno :(  
>> 
>> Before my patch,  init_dummy_netdev was being also used. The patch was
>> basically replacing the init_dummy_netdev by alloc_netdev() with will
>> call "setup(dev);" later. 
>> 
>> -               init_dummy_netdev(&irq_grp->napi_ndev);
>> +               irq_grp->napi_ndev = alloc_netdev(0, "dummy", NET_NAME_UNKNOWN,
>> +                                                 init_dummy_netdev);
>> 
>> I am wondering if alloc_netdev() is messing with something instead of
>> init_dummy_netdev().
>
> alloc_netdev() allocates some memory and initializes lists which
> free_netdev() wants to free, basically. But init_dummy_netdev() does:
>
> 	/* Clear everything. Note we don't initialize spinlocks
> 	 * are they aren't supposed to be taken by any of the
> 	 * NAPI code and this dummy netdev is supposed to be
> 	 * only ever used for NAPI polls
> 	 */
> 	memset(dev, 0, sizeof(struct net_device));
>
> so all those pointers and init alloc_netdev() did before calling setup
> will get wiped.

After some tweaking I was able to get an old x86 laptop with ath10k back
alive and I tested this patch using QCA9984/QCA9994 hw1.0 PCI device. As
expected it did crash during rmmod and it seems to crash because
dev->dev_addr is zero:

[  130.849286] dev->dev_addr 00000000 dev->dev_addr_shadow 5acebe41

Breno, I can now easily test new ath10k and ath11k patches, just let me
know. Here's the full back trace:

[  130.849310] BUG: kernel NULL pointer dereference, address: 00000000
[  130.849413] #PF: supervisor read access in kernel mode
[  130.849450] #PF: error_code(0x0000) - not-present page
[  130.849486] *pdpt = 00000000048b9001 *pde = 0000000000000000 
[  130.849529] Oops: 0000 [#1] PREEMPT SMP PTI
[  130.849564] CPU: 1 PID: 882 Comm: rmmod Tainted: G            E      6.9.0-rc1-wt-ath+ #17
[  130.849617] Hardware name: Hewlett-Packard HP ProBook 6540b/1722, BIOS 68CDD Ver. F.04 01/27/2010
[  130.849671] EIP: memcmp+0x4c/0x54
[  130.849706] Code: 39 d9 74 0a 0f b6 03 0f b6 32 29 f0 74 ec 5b 5e 5d c3 8d b4 26 00 00 00 00 90 83 e9 04 83 c3 04 83 c2 04 83 f9 03 76 c2 8b 02 <39> 03 74 ec eb c0 66 90 55 89 e5 e8 a4 ff ff ff 5d c3 66 90 55 89
[  130.849809] EAX: 00000000 EBX: 00000000 ECX: 00000020 EDX: c32c1d84
[  130.854170] ESI: c32c1d84 EDI: 00000000 EBP: c4b87e2c ESP: c4b87e24
[  130.854222] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00010216
[  130.854274] CR0: 80050033 CR2: 00000000 CR3: 03348000 CR4: 000006f0
[  130.854324] Call Trace:
[  130.854354]  ? show_regs+0x74/0x7c
[  130.854393]  ? __die+0x1d/0x58
[  130.854425]  ? page_fault_oops+0x16c/0x340
[  130.854469]  ? kernelmode_fixup_or_oops.constprop.0+0x84/0xd4
[  130.854518]  ? __bad_area_nosemaphore.constprop.0+0x10e/0x1a4
[  130.854567]  ? lock_mm_and_find_vma+0xeb/0x288
[  130.854612]  ? bad_area_nosemaphore+0xf/0x14
[  130.854652]  ? do_user_addr_fault+0x238/0x454
[  130.854693]  ? exc_page_fault+0x58/0x170
[  130.854734]  ? pvclock_clocksource_read_nowd+0x130/0x130
[  130.854781]  ? handle_exception+0x150/0x150
[  130.854824]  ? posix_cpu_timer_del+0x17/0x140
[  130.854867]  ? pvclock_clocksource_read_nowd+0x130/0x130
[  130.854914]  ? memcmp+0x4c/0x54
[  130.854947]  ? pvclock_clocksource_read_nowd+0x130/0x130
[  130.857510]  ? memcmp+0x4c/0x54
[  130.860078]  dev_addr_check+0x27/0xd4
[  130.862635]  dev_addr_flush+0x18/0x78
[  130.865178]  free_netdev+0x76/0x1b0
[  130.867708]  ath10k_core_destroy+0x54/0x84 [ath10k_core]
[  130.870283]  ath10k_pci_remove+0x88/0xcc [ath10k_pci]
[  130.872831]  pci_device_remove+0x38/0x90
[  130.875311]  device_remove+0x37/0x58
[  130.877757]  device_release_driver_internal+0x185/0x1d8
[  130.880182]  driver_detach+0x3c/0x78
[  130.882603]  bus_remove_driver+0x56/0xc0
[  130.885019]  driver_unregister+0x25/0x40
[  130.887378]  pci_unregister_driver+0x21/0x60
[  130.889702]  ath10k_pci_exit+0xd/0x3d0 [ath10k_pci]
[  130.892007]  __ia32_sys_delete_module+0x163/0x254
[  130.894291]  ? preempt_count_add+0x6d/0xbc
[  130.896504]  ? debug_smp_processor_id+0x12/0x14
[  130.898711]  ? fpregs_assert_state_consistent+0x29/0x50
[  130.900883]  __do_fast_syscall_32+0x57/0xd0
[  130.903026]  do_fast_syscall_32+0x29/0x58
[  130.905178]  do_SYSENTER_32+0x15/0x18
[  130.907295]  entry_SYSENTER_32+0xa2/0x102
[  130.909421] EIP: 0xb7ef0569
[  130.911523] Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76
[  130.916271] EAX: ffffffda EBX: 010f618c ECX: 00000800 EDX: 0044b1f9
[  130.918758] ESI: 010f6150 EDI: 00000001 EBP: bf8957f3 ESP: bf8941b8
[  130.921221] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000202
[  130.923696] Modules linked in: ath10k_usb(E) ath10k_sdio(E) ath10k_pci(E-) ath10k_core(E) ath(E) mac80211(E) cfg80211(E) libarc4(E) snd_hda_codec_hdmi snd_ctl_led ledtrig_audio snd_hda_codec_idt snd_hda_codec_generic intel_powerclamp coretemp snd_hda_intel wmi_bmof kvm_intel snd_intel_dspcfg uvcvideo i915 kvm videobuf2_vmalloc snd_hda_codec i2c_algo_bit drm_buddy snd_hwdep videobuf2_memops btusb uvc drm_display_helper intel_cstate snd_hda_core videobuf2_v4l2 btrtl btintel drm_kms_helper snd_pcm joydev videodev btbcm input_leds snd_timer serio_raw intel_ips binfmt_misc ttm videobuf2_common bluetooth snd lpc_ich mei_me video mc ecdh_generic soundcore ecc drm mei tpm_infineon wmi mac_hid sch_fq_codel parport_pc ppdev lp parport autofs4 netconsole firewire_ohci sdhci_pci cqhci firewire_core ahci psmouse sdhci sky2 crc_itu_t libahci [last unloaded: libarc4]
[  130.937173] CR2: 0000000000000000
[  130.939863] ---[ end trace 0000000000000000 ]---
[  130.942404] EIP: memcmp+0x4c/0x54
[  130.944777] Code: 39 d9 74 0a 0f b6 03 0f b6 32 29 f0 74 ec 5b 5e 5d c3 8d b4 26 00 00 00 00 90 83 e9 04 83 c3 04 83 c2 04 83 f9 03 76 c2 8b 02 <39> 03 74 ec eb c0 66 90 55 89 e5 e8 a4 ff ff ff 5d c3 66 90 55 89
[  130.950719] EAX: 00000000 EBX: 00000000 ECX: 00000020 EDX: c32c1d84
[  130.952997] ESI: c32c1d84 EDI: 00000000 EBP: c4b87e2c ESP: c4b87e24
[  130.955166] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00010216
[  130.957339] CR0: 80050033 CR2: 00000000 CR3: 03348000 CR4: 000006f0


-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

