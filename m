Return-Path: <linux-kernel+bounces-64832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C662F854360
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 08:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D90EB24038
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 07:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604E911709;
	Wed, 14 Feb 2024 07:26:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D871119E
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 07:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707895564; cv=none; b=aC5rglXAdv3KioNPUQSaN/BhoFKpaydON4IWBfqVLIer0eyk5KMytNXlMWQKJ35ZexIW7P8DZxZrhSE/4CyDwBfHqcHT43+elraVgY3rrBagrBeYjjC9DsT6kDlCyCwfk4Rmt+aBGP9sbyesyRUc2T+1SVqlghu31mei96brgNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707895564; c=relaxed/simple;
	bh=MwPSE74gBD8Mc896f2tRupp8rbOXbraimyUDVTsBke0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=d/cxtoz15/1o6sCbuv1VHcFPnDvqqz/4YnmhRJ9OEILfXqu3nvqDBv+fDxmdQ03NPhukFQZGYvol7pyYRlPSzUn+wcQPUyMbYwt01rv+oM6KT2dvP5vxbEYIlI+ZttCGXvbYvyACW3uPMmzo3hN5GCj82/QyO7LkbRL+EY2LY7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-363ec32bca3so45058355ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 23:26:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707895561; x=1708500361;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UsxpZ/5orNJMHH00dKYbP0zLnobST6Tlmc19MplZ71U=;
        b=J/gb67ue2NA/EXEb3ZDRVQkHi+K2ySTZyX3mfpq7NYdo3JHXhgTTjwrZVXCKAvgruA
         U8IprB+qWBGaCDO3S6wLqxdLdGowrL3lyDhacWgNhR9Po+JGuAbchngIEWRETuzPFJvx
         fgjP+EM2owwd7SHdDfkNS+RJB2tOo6seoz2LhTPwYOmKhm8XfZpfqyLm8iOlu1ah7qoz
         yTe5N+Zxo8tV2LZlZaTftZ49yQVt9sGdULaLBXPP/vNFP9BYfD73zIqsBfWUxtS5FudF
         jWiYxR8yuei9wYBRpJqHQlRqJ/diOVlEPsDhtyZqp1cFTf4d0RMXbbpJay7ezfCF7GBF
         bVyA==
X-Forwarded-Encrypted: i=1; AJvYcCXyZuVhGrjyZrUZww58ZLRjzEQtjtGb6nZ7Ty+iEpVdmlDxNNyvTMvmBERFSR4dZujQU4VbVjHeiQ93Uq/8GFaP4vB7JEM2KKCqFUS0
X-Gm-Message-State: AOJu0Yz7fXQFmtn31vpGnycvM9g2VirdkRLLagbdYhIIMXNOgyJMUioy
	PTxn93w6tfru/9qWnNANTbV8S1P1Rxz3NGTBHEk+kK5fGJaFMA0F4ZfrihqqyjmvDOSUqR4oliC
	94yH+bUbrh7f2VadJowbzXIxsLiez2SGnIqaR+CWF4eSTcExK+zzGmKM=
X-Google-Smtp-Source: AGHT+IFFROCJCeXmjr0phdXKcWrcCAKaPONt5hEAeo30ZFWED8OfLTacoP9XSjEadB1LOj0FBl99JsEVLE+Z3Cu7wOIMXjlJtgND
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d9a:b0:363:e134:a158 with SMTP id
 h26-20020a056e021d9a00b00363e134a158mr136181ila.5.1707895561711; Tue, 13 Feb
 2024 23:26:01 -0800 (PST)
Date: Tue, 13 Feb 2024 23:26:01 -0800
In-Reply-To: <20240214070145.360-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000044f7a30611526c56@google.com>
Subject: Re: [syzbot] [dri?] KASAN: slab-use-after-free Read in
 drm_atomic_helper_wait_for_vblanks (2)
From: syzbot <syzbot+0f999d26a4fd79c3a23b@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

stered
[    7.227065][    T1] io scheduler kyber registered
[    7.230249][    T1] io scheduler bfq registered
[    7.274282][    T1] ACPI: \_SB_.GSIE: Enabled at IRQ 20
[    7.283915][    T1] pcieport 0000:00:04.0: PME: Signaling with IRQ 25
[    7.291488][    T1] pcieport 0000:00:04.0: AER: enabled with IRQ 26
[    7.301097][    T1] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN=
:00/input/input0
[    7.307815][    T1] ACPI: button: Power Button [PWRF]
[    7.590815][    T1] ioatdma: Intel(R) QuickData Technology Driver 5.00
[    7.624170][    T1] ACPI: \_SB_.GSIF: Enabled at IRQ 21
[    7.661185][    T1] ACPI: \_SB_.GSIH: Enabled at IRQ 23
[    8.035591][    T1] N_HDLC line discipline registered with maxframe=3D40=
96
[    8.039643][    T1] Serial: 8250/16550 driver, 4 ports, IRQ sharing enab=
led
[    8.046882][    T1] 00:04: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D =
115200) is a 16550A
[    8.094343][    T1] Non-volatile memory driver v1.3
[    8.103986][    T1] Linux agpgart interface v0.103
[    8.113180][    T1] ACPI: bus type drm_connector registered
[    8.121142][    T1] [drm] Initialized vgem 1.0.0 20120112 for vgem on mi=
nor 0
[    8.134946][    T1] [drm] Initialized vkms 1.0.0 20180514 for vkms on mi=
nor 1
[    8.237474][    T1] Console: switching to colour frame buffer device 128=
x48
[    8.257199][    T1] platform vkms: [drm] fb0: vkmsdrmfb frame buffer dev=
ice
[    8.263052][    T1] usbcore: registered new interface driver udl
[    8.269025][    T1] [drm] pci: virtio-vga detected at 0000:00:01.0
[    8.274892][    T1] virtio-pci 0000:00:01.0: vgaarb: deactivate vga cons=
ole
[    8.283302][    T1] [drm] features: -virgl +edid -resource_blob -host_vi=
sible
[    8.283317][    T1] [drm] features: -context_init
[    8.301233][    T1] [drm] number of scanouts: 1
[    8.304828][    T1] [drm] number of cap sets: 0
[    8.316672][    T1] [drm] Initialized virtio_gpu 0.1.0 0 for 0000:00:01.=
0 on minor 2
[    8.382391][    T1] fbcon: virtio_gpudrmfb (fb1) is primary device
[    8.382410][    T1] fbcon: Remapping primary device, fb1, to tty 1-63
[    8.400286][    T1] ------------[ cut here ]------------
[    8.400336][    T1] WARNING: CPU: 0 PID: 1 at drivers/gpu/drm/drm_modese=
t_lock.c:276 drm_modeset_drop_locks+0x17a/0x210
[    8.400389][    T1] Modules linked in:
[    8.400398][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.8.0-rc4-=
syzkaller-g7e90b5c295ec-dirty #0
[    8.400408][    T1] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), =
BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    8.400414][    T1] RIP: 0010:drm_modeset_drop_locks+0x17a/0x210
[    8.400428][    T1] Code: 00 75 39 49 8b 44 24 70 49 39 c5 0f 85 31 ff f=
f ff 48 83 c4 10 5b 5d 41 5c 41 5d 41 5e 41 5f e9 cc 75 83 fc e8 c7 75 83 f=
c 90 <0f> 0b 90 e9 c4 fe ff ff 48 89 df e8 66 9f dc fc eb 9e 4c 89 ef e8
[    8.400437][    T1] RSP: 0000:ffffc90000047168 EFLAGS: 00010293
[    8.400447][    T1] RAX: 0000000000000000 RBX: ffffc90000047240 RCX: fff=
fffff85023ebc
[    8.400454][    T1] RDX: ffff8880166d8000 RSI: ffffffff8507d859 RDI: fff=
fc900000472a0
[    8.400460][    T1] RBP: 0000000000000001 R08: 0000000000000005 R09: 000=
0000000000000
[    8.400466][    T1] R10: 0000000000000004 R11: 0000000000000009 R12: fff=
fc90000047240
[    8.400473][    T1] R13: dffffc0000000000 R14: 0000000000000001 R15: fff=
fffffffffffdd
[    8.400483][    T1] FS:  0000000000000000(0000) GS:ffff88806b200000(0000=
) knlGS:0000000000000000
[    8.400508][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    8.400518][    T1] CR2: ffff88817ffff000 CR3: 000000000d57a000 CR4: 000=
0000000350ef0
[    8.400525][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[    8.400531][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[    8.400537][    T1] Call Trace:
[    8.400542][    T1]  <TASK>
[    8.400547][    T1]  ? show_regs+0x8f/0xa0
[    8.400561][    T1]  ? __warn+0xe6/0x390
[    8.400575][    T1]  ? drm_modeset_drop_locks+0x17a/0x210
[    8.400587][    T1]  ? report_bug+0x3c0/0x580
[    8.400599][    T1]  ? handle_bug+0x3d/0x70
[    8.400609][    T1]  ? exc_invalid_op+0x17/0x50
[    8.400619][    T1]  ? asm_exc_invalid_op+0x1a/0x20
[    8.400662][    T1]  ? drm_dev_put.part.0+0x5c/0x140
[    8.400676][    T1]  ? drm_modeset_drop_locks+0x179/0x210
[    8.400688][    T1]  ? drm_modeset_drop_locks+0x17a/0x210
[    8.400700][    T1]  ? drm_modeset_drop_locks+0x179/0x210
[    8.400712][    T1]  drm_client_modeset_commit_atomic+0x2c2/0x800
[    8.400726][    T1]  ? trace_contention_end+0xda/0x110
[    8.400739][    T1]  ? __pfx_drm_client_modeset_commit_atomic+0x10/0x10
[    8.400753][    T1]  ? __mutex_lock+0x1a6/0x9d0
[    8.400766][    T1]  ? __mutex_lock+0x1a6/0x9d0
[    8.400780][    T1]  ? __pfx___mutex_unlock_slowpath+0x10/0x10
[    8.400798][    T1]  drm_client_modeset_commit_locked+0x14d/0x580
[    8.400812][    T1]  drm_fb_helper_pan_display+0x2a5/0x990
[    8.400824][    T1]  fb_pan_display+0x477/0x7d0
[    8.400837][    T1]  ? __pfx_drm_fb_helper_pan_display+0x10/0x10
[    8.400848][    T1]  bit_update_start+0x49/0x1f0
[    8.400860][    T1]  fbcon_switch+0xbbf/0x12f0
[    8.400871][    T1]  ? __pfx_fbcon_switch+0x10/0x10
[    8.400882][    T1]  ? __pfx_bit_cursor+0x10/0x10
[    8.400892][    T1]  ? fbcon_cursor+0x3e0/0x540
[    8.400903][    T1]  ? is_console_locked+0x9/0x20
[    8.400913][    T1]  ? con_is_visible+0x65/0x150
[    8.400926][    T1]  redraw_screen+0x2bf/0x760
[    8.400935][    T1]  ? __pfx_redraw_screen+0x10/0x10
[    8.400944][    T1]  ? fb_get_color_depth+0x120/0x250
[    8.400956][    T1]  fbcon_prepare_logo+0x9f8/0xc80
[    8.400968][    T1]  set_con2fb_map+0xcf4/0x1060
[    8.400979][    T1]  fbcon_fb_registered+0x21d/0x670
[    8.400990][    T1]  ? fb_var_to_videomode+0x4c9/0x690
[    8.401003][    T1]  register_framebuffer+0x4b2/0x860
[    8.401015][    T1]  ? __pfx_register_framebuffer+0x10/0x10
[    8.401028][    T1]  ? drm_fbdev_generic_helper_fb_probe+0x4e2/0x6d0
[    8.401038][    T1]  __drm_fb_helper_initial_config_and_unlock+0xd82/0x1=
650
[    8.401051][    T1]  ? __pfx___drm_fb_helper_initial_config_and_unlock+0=
x10/0x10
[    8.401064][    T1]  drm_fb_helper_initial_config+0x44/0x60
[    8.401075][    T1]  drm_fbdev_generic_client_hotplug+0x1a6/0x280
[    8.401085][    T1]  ? __pfx_drm_fbdev_generic_client_hotplug+0x10/0x10
[    8.401095][    T1]  drm_client_register+0x195/0x280
[    8.401107][    T1]  drm_fbdev_generic_setup+0x184/0x340
[    8.401118][    T1]  virtio_gpu_probe+0x29d/0x4e0
[    8.401131][    T1]  virtio_dev_probe+0x5ff/0x9b0
[    8.401142][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[    8.401151][    T1]  really_probe+0x23a/0xcb0
[    8.401165][    T1]  __driver_probe_device+0x1de/0x4b0
[    8.401174][    T1]  ? _raw_spin_unlock_irqrestore+0x52/0x80
[    8.401187][    T1]  driver_probe_device+0x4c/0x1b0
[    8.401196][    T1]  __driver_attach+0x283/0x580
[    8.401204][    T1]  ? __pfx___driver_attach+0x10/0x10
[    8.401213][    T1]  bus_for_each_dev+0x13c/0x1d0
[    8.401225][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    8.401237][    T1]  bus_add_driver+0x2ed/0x640
[    8.401250][    T1]  ? __pfx_virtio_gpu_driver_init+0x10/0x10
[    8.401263][    T1]  driver_register+0x15c/0x4b0
[    8.401273][    T1]  do_one_initcall+0x11c/0x670
[    8.401286][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    8.401299][    T1]  ? trace_kmalloc+0x2e/0xb0
[    8.401313][    T1]  ? __kmalloc+0x218/0x440
[    8.401323][    T1]  kernel_init_freeable+0x68d/0xc10
[    8.401338][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.401349][    T1]  kernel_init+0x1c/0x2a0
[    8.401359][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.401370][    T1]  ret_from_fork+0x45/0x80
[    8.401383][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.401393][    T1]  ret_from_fork_asm+0x1b/0x30
[    8.401407][    T1]  </TASK>
[    8.401412][    T1] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...
[    8.401417][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.8.0-rc4-=
syzkaller-g7e90b5c295ec-dirty #0
[    8.401426][    T1] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), =
BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    8.401430][    T1] Call Trace:
[    8.401433][    T1]  <TASK>
[    8.401436][    T1]  dump_stack_lvl+0xd9/0x1b0
[    8.401447][    T1]  panic+0x6ee/0x7a0
[    8.401458][    T1]  ? __pfx_panic+0x10/0x10
[    8.401469][    T1]  ? show_trace_log_lvl+0x363/0x500
[    8.401482][    T1]  ? check_panic_on_warn+0x1f/0xb0
[    8.401493][    T1]  ? drm_modeset_drop_locks+0x17a/0x210
[    8.401504][    T1]  check_panic_on_warn+0xab/0xb0
[    8.401516][    T1]  __warn+0xf2/0x390
[    8.401527][    T1]  ? drm_modeset_drop_locks+0x17a/0x210
[    8.401538][    T1]  report_bug+0x3c0/0x580
[    8.401547][    T1]  handle_bug+0x3d/0x70
[    8.401556][    T1]  exc_invalid_op+0x17/0x50
[    8.401565][    T1]  asm_exc_invalid_op+0x1a/0x20
[    8.401576][    T1] RIP: 0010:drm_modeset_drop_locks+0x17a/0x210
[    8.401587][    T1] Code: 00 75 39 49 8b 44 24 70 49 39 c5 0f 85 31 ff f=
f ff 48 83 c4 10 5b 5d 41 5c 41 5d 41 5e 41 5f e9 cc 75 83 fc e8 c7 75 83 f=
c 90 <0f> 0b 90 e9 c4 fe ff ff 48 89 df e8 66 9f dc fc eb 9e 4c 89 ef e8
[    8.401595][    T1] RSP: 0000:ffffc90000047168 EFLAGS: 00010293
[    8.401602][    T1] RAX: 0000000000000000 RBX: ffffc90000047240 RCX: fff=
fffff85023ebc
[    8.401607][    T1] RDX: ffff8880166d8000 RSI: ffffffff8507d859 RDI: fff=
fc900000472a0
[    8.401612][    T1] RBP: 0000000000000001 R08: 0000000000000005 R09: 000=
0000000000000
[    8.401617][    T1] R10: 0000000000000004 R11: 0000000000000009 R12: fff=
fc90000047240
[    8.401622][    T1] R13: dffffc0000000000 R14: 0000000000000001 R15: fff=
fffffffffffdd
[    8.401628][    T1]  ? drm_dev_put.part.0+0x5c/0x140
[    8.401640][    T1]  ? drm_modeset_drop_locks+0x179/0x210
[    8.401651][    T1]  ? drm_modeset_drop_locks+0x179/0x210
[    8.401662][    T1]  drm_client_modeset_commit_atomic+0x2c2/0x800
[    8.401674][    T1]  ? trace_contention_end+0xda/0x110
[    8.401685][    T1]  ? __pfx_drm_client_modeset_commit_atomic+0x10/0x10
[    8.401697][    T1]  ? __mutex_lock+0x1a6/0x9d0
[    8.401709][    T1]  ? __mutex_lock+0x1a6/0x9d0
[    8.401721][    T1]  ? __pfx___mutex_unlock_slowpath+0x10/0x10
[    8.401734][    T1]  drm_client_modeset_commit_locked+0x14d/0x580
[    8.401746][    T1]  drm_fb_helper_pan_display+0x2a5/0x990
[    8.401756][    T1]  fb_pan_display+0x477/0x7d0
[    8.401766][    T1]  ? __pfx_drm_fb_helper_pan_display+0x10/0x10
[    8.401776][    T1]  bit_update_start+0x49/0x1f0
[    8.401786][    T1]  fbcon_switch+0xbbf/0x12f0
[    8.401799][    T1]  ? __pfx_fbcon_switch+0x10/0x10
[    8.401808][    T1]  ? __pfx_bit_cursor+0x10/0x10
[    8.401818][    T1]  ? fbcon_cursor+0x3e0/0x540
[    8.401827][    T1]  ? is_console_locked+0x9/0x20
[    8.401836][    T1]  ? con_is_visible+0x65/0x150
[    8.401847][    T1]  redraw_screen+0x2bf/0x760
[    8.401854][    T1]  ? __pfx_redraw_screen+0x10/0x10
[    8.401862][    T1]  ? fb_get_color_depth+0x120/0x250
[    8.401873][    T1]  fbcon_prepare_logo+0x9f8/0xc80
[    8.401883][    T1]  set_con2fb_map+0xcf4/0x1060
[    8.401893][    T1]  fbcon_fb_registered+0x21d/0x670
[    8.401902][    T1]  ? fb_var_to_videomode+0x4c9/0x690
[    8.401914][    T1]  register_framebuffer+0x4b2/0x860
[    8.401925][    T1]  ? __pfx_register_framebuffer+0x10/0x10
[    8.401936][    T1]  ? drm_fbdev_generic_helper_fb_probe+0x4e2/0x6d0
[    8.401945][    T1]  __drm_fb_helper_initial_config_and_unlock+0xd82/0x1=
650
[    8.401956][    T1]  ? __pfx___drm_fb_helper_initial_config_and_unlock+0=
x10/0x10
[    8.401968][    T1]  drm_fb_helper_initial_config+0x44/0x60
[    8.401977][    T1]  drm_fbdev_generic_client_hotplug+0x1a6/0x280
[    8.401986][    T1]  ? __pfx_drm_fbdev_generic_client_hotplug+0x10/0x10
[    8.401994][    T1]  drm_client_register+0x195/0x280
[    8.402005][    T1]  drm_fbdev_generic_setup+0x184/0x340
[    8.402014][    T1]  virtio_gpu_probe+0x29d/0x4e0
[    8.402025][    T1]  virtio_dev_probe+0x5ff/0x9b0
[    8.402033][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[    8.402041][    T1]  really_probe+0x23a/0xcb0
[    8.402053][    T1]  __driver_probe_device+0x1de/0x4b0
[    8.402061][    T1]  ? _raw_spin_unlock_irqrestore+0x52/0x80
[    8.402072][    T1]  driver_probe_device+0x4c/0x1b0
[    8.402080][    T1]  __driver_attach+0x283/0x580
[    8.402088][    T1]  ? __pfx___driver_attach+0x10/0x10
[    8.402095][    T1]  bus_for_each_dev+0x13c/0x1d0
[    8.402106][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    8.402116][    T1]  bus_add_driver+0x2ed/0x640
[    8.402128][    T1]  ? __pfx_virtio_gpu_driver_init+0x10/0x10
[    8.402138][    T1]  driver_register+0x15c/0x4b0
[    8.402147][    T1]  do_one_initcall+0x11c/0x670
[    8.402158][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    8.402169][    T1]  ? trace_kmalloc+0x2e/0xb0
[    8.402181][    T1]  ? __kmalloc+0x218/0x440
[    8.402190][    T1]  kernel_init_freeable+0x68d/0xc10
[    8.402203][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.402212][    T1]  kernel_init+0x1c/0x2a0
[    8.402221][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.402230][    T1]  ret_from_fork+0x45/0x80
[    8.402241][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.402251][    T1]  ret_from_fork_asm+0x1b/0x30
[    8.402263][    T1]  </TASK>
[    8.403059][    T1] Kernel Offset: disabled


syzkaller build log:
go env (err=3D<nil>)
GO111MODULE=3D"auto"
GOARCH=3D"amd64"
GOBIN=3D""
GOCACHE=3D"/syzkaller/.cache/go-build"
GOENV=3D"/syzkaller/.config/go/env"
GOEXE=3D""
GOEXPERIMENT=3D""
GOFLAGS=3D""
GOHOSTARCH=3D"amd64"
GOHOSTOS=3D"linux"
GOINSECURE=3D""
GOMODCACHE=3D"/syzkaller/jobs/linux/gopath/pkg/mod"
GONOPROXY=3D""
GONOSUMDB=3D""
GOOS=3D"linux"
GOPATH=3D"/syzkaller/jobs/linux/gopath"
GOPRIVATE=3D""
GOPROXY=3D"https://proxy.golang.org,direct"
GOROOT=3D"/usr/local/go"
GOSUMDB=3D"sum.golang.org"
GOTMPDIR=3D""
GOTOOLDIR=3D"/usr/local/go/pkg/tool/linux_amd64"
GOVCS=3D""
GOVERSION=3D"go1.20.1"
GCCGO=3D"gccgo"
GOAMD64=3D"v1"
AR=3D"ar"
CC=3D"gcc"
CXX=3D"g++"
CGO_ENABLED=3D"1"
GOMOD=3D"/syzkaller/jobs/linux/gopath/src/github.com/google/syzkaller/go.mo=
d"
GOWORK=3D""
CGO_CFLAGS=3D"-O2 -g"
CGO_CPPFLAGS=3D""
CGO_CXXFLAGS=3D"-O2 -g"
CGO_FFLAGS=3D"-O2 -g"
CGO_LDFLAGS=3D"-O2 -g"
PKG_CONFIG=3D"pkg-config"
GOGCCFLAGS=3D"-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=3D0=
 -fdebug-prefix-map=3D/tmp/go-build253358196=3D/tmp/go-build -gno-record-gc=
c-switches"

git status (err=3D<nil>)
HEAD detached at e66542d78
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:32: run command via tools/syz-env for best compatibility, see:
Makefile:33: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
go list -f '{{.Stale}}' ./sys/syz-sysgen | grep -q false || go install ./sy=
s/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
bin/syz-sysgen
touch .descriptions
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3De66542d78f1cf0c783877440cd239a11fb73fb15 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240213-111349'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer=
 github.com/google/syzkaller/syz-fuzzer
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3De66542d78f1cf0c783877440cd239a11fb73fb15 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240213-111349'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3De66542d78f1cf0c783877440cd239a11fb73fb15 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240213-111349'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress=
 github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -fpermissive -w -DGOOS_linux=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"e66542d78f1cf0c783877440cd239a11fb=
73fb15\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D1395d592180000


Tested on:

commit:         7e90b5c2 Merge tag 'trace-tools-v6.8-rc4' of git://git..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git master
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Ddf82262440d95bc=
4
dashboard link: https://syzkaller.appspot.com/bug?extid=3D0f999d26a4fd79c3a=
23b
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Deb=
ian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D1247ec621800=
00


