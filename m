Return-Path: <linux-kernel+bounces-64676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C5285415A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 03:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B7D4B239FA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 02:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F19A7465;
	Wed, 14 Feb 2024 02:01:07 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEB65398
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 02:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707876066; cv=none; b=gPNCNme/V2ae3e6xSOfMPTbm4TzOhlX76xhyFq4r8hR+5SiQtMfbV7e8uFkP8pnoErsBWl3oxCs5hQaKT3F2Iah+XDdxEmSrGLkiVx8toikCZ1Sncje8z4o3eNRFxvTX14cg1e/bOOQy9bZl82CIuboCNpeAb3ejlw/FILvtDcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707876066; c=relaxed/simple;
	bh=MHxSHOUEmX/pIdCZ0FfJyJfTypQdGNjQb/fqMorC/lQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=asKVCWJIlQOLAdG4J7hVPJvbuAGiM/iGLwo0g7fCd+krPhlKdQ3FJyJXyzrtXJMVFezSBn4w4zzVuJdwyEAHFW25PIY4Ml0e0aW78DhJxe2PZGvSeXR1JJfXWBzG0VHkkyXNYiqSbkxgvsbqh7QDKb78JOrxu5JHrpxQfAduK9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3642f655a27so523705ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 18:01:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707876064; x=1708480864;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kl2WLGhHTY2BeraYV9DitCs4y/XSKtzuoXdG7ShpdDQ=;
        b=lplrV1G8C4N2BgTE7+rw4jp9On61bHtspHtYWxLw4SVcvylDFTDWjybtIcrvLmBoyC
         dkaDjeLZTZWuWj1LRzVDy1Kdhi9rBLio3iTZ666Vny4Dq7YDQCHwKqAF7KtKcPc8ni3m
         GgGpcoR/Wd12NflOSGGJHTQk0A7ex0R8w4VGuAhy47O4homiFuxbOEej3Vc+3iptvjmU
         nS9j6N2SRVqH6lLVVcPQQb4lte/zbsYPIDb7RzZnM1aAFeiEiYzfAzF+GkNUde+Wc8cB
         +EjlCioLMZn6poKZl+cRQ+9x4vaIK3lytwJbkdbAMQiToSdafA6D9grT6Ynxuk1hlZe9
         kpHA==
X-Forwarded-Encrypted: i=1; AJvYcCWv+De6aui+3RU7dh9wNHuXITOVkG7hH3JjY2ajXjlLPGwDx24KaBvHfC0y0lZCHt+JZN6iEnXyszi7B8h43hqlu3c59gLu8AKi0KuC
X-Gm-Message-State: AOJu0Yxv2v/LZ/J0fD5ERxCh5Ixf0lpKiis180cXYHdWhiXHUZ9Xu6PB
	Eo5/IpcGQHlF334Y0noal2ig8ZMD1Eqzrt0CeOzpMEftYjSgiOj5KeLEf0e8JoRjx5NGm98VsBd
	yswdzCGJqkK3HjveuZ6iH2Pg5igWRsqv2kUtDFO1+JlLtCGsHvRVvYEk=
X-Google-Smtp-Source: AGHT+IGdXyFjvrlwxfUhH6Ariiw+AILXga3pDA8U9gHypoR3zZsJ+oh5csP80VVUj6Q5vqmWjzCTtqkFhBNN62/XB9zz3DkwC9tY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a8f:b0:364:2283:d1d9 with SMTP id
 k15-20020a056e021a8f00b003642283d1d9mr93014ilv.5.1707876063800; Tue, 13 Feb
 2024 18:01:03 -0800 (PST)
Date: Tue, 13 Feb 2024 18:01:03 -0800
In-Reply-To: <20240214013238.304-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001a769e06114de293@google.com>
Subject: Re: [syzbot] [dri?] KASAN: slab-use-after-free Read in
 drm_atomic_helper_wait_for_vblanks (2)
From: syzbot <syzbot+0f999d26a4fd79c3a23b@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115200) is a 16550A
[   12.100286][    T1] Non-volatile memory driver v1.3
[   12.113616][    T1] Linux agpgart interface v0.103
[   12.123143][    T1] ACPI: bus type drm_connector registered
[   12.142579][    T1] [drm] Initialized vgem 1.0.0 20120112 for vgem on mi=
nor 0
[   12.162590][    T1] [drm] Initialized vkms 1.0.0 20180514 for vkms on mi=
nor 1
[   12.287128][    T1] Console: switching to colour frame buffer device 128=
x48
[   12.310428][    T1] platform vkms: [drm] fb0: vkmsdrmfb frame buffer dev=
ice
[   12.331206][    C0] vkms_vblank_simulate: vblank timer overrun
[   12.336575][    T1] usbcore: registered new interface driver udl
[   12.342353][    T1] [drm] pci: virtio-vga detected at 0000:00:01.0
[   12.363944][    T1] virtio-pci 0000:00:01.0: vgaarb: deactivate vga cons=
ole
[   12.373522][    T1] [drm] features: -virgl +edid -resource_blob -host_vi=
sible
[   12.373539][    T1] [drm] features: -context_init
[   12.394195][    T1] [drm] number of scanouts: 1
[   12.397944][    T1] [drm] number of cap sets: 0
[   12.411757][    T1] [drm] Initialized virtio_gpu 0.1.0 0 for 0000:00:01.=
0 on minor 2
[   12.494144][    T1] fbcon: virtio_gpudrmfb (fb1) is primary device
[   12.494166][    T1] fbcon: Remapping primary device, fb1, to tty 1-63
[   12.529275][    T1] ------------[ cut here ]------------
[   12.529360][    T1] WARNING: CPU: 0 PID: 1 at kernel/workqueue.c:3403 __=
flush_work+0x879/0xa20
[   12.529392][    T1] Modules linked in:
[   12.529406][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.8.0-rc4-=
syzkaller-g7e90b5c295ec-dirty #0
[   12.529424][    T1] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), =
BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   12.529439][    T1] RIP: 0010:__flush_work+0x879/0xa20
[   12.529458][    T1] Code: c7 60 d1 7a 8d 48 8d 35 00 00 00 00 e8 80 c0 1=
2 00 45 31 ed e9 cc fc ff ff e8 83 5a 33 00 90 0f 0b 90 eb ed e8 78 5a 33 0=
0 90 <0f> 0b 90 eb e2 e8 6d 5a 33 00 e8 68 5a 33 00 e8 63 5a 33 00 48 8b
[   12.529476][    T1] RSP: 0000:ffffc90000046fc0 EFLAGS: 00010293
[   12.529493][    T1] RAX: 0000000000000000 RBX: dffffc0000000000 RCX: fff=
fffff8157ebdd
[   12.529505][    T1] RDX: ffff8880166d8000 RSI: ffffffff8157f3a8 RDI: 000=
0000000000001
[   12.529517][    T1] RBP: ffff88801e1f1048 R08: 0000000000000001 R09: 000=
0000000000000
[   12.529529][    T1] R10: 0000000000000001 R11: 0000000000000000 R12: 000=
0000000000000
[   12.529541][    T1] R13: 0000000000000001 R14: ffff88801e1f1060 R15: 000=
0000000000001
[   12.529559][    T1] FS:  0000000000000000(0000) GS:ffff88806b200000(0000=
) knlGS:0000000000000000
[   12.529599][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   12.529623][    T1] CR2: ffff88817ffff000 CR3: 000000000d57a000 CR4: 000=
0000000350ef0
[   12.529636][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[   12.529647][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[   12.529664][    T1] Call Trace:
[   12.529672][    T1]  <TASK>
[   12.529681][    T1]  ? show_regs+0x8f/0xa0
[   12.529709][    T1]  ? __warn+0xe6/0x390
[   12.529734][    T1]  ? __flush_work+0x879/0xa20
[   12.529751][    T1]  ? report_bug+0x3c0/0x580
[   12.529774][    T1]  ? handle_bug+0x3d/0x70
[   12.529792][    T1]  ? exc_invalid_op+0x17/0x50
[   12.529815][    T1]  ? asm_exc_invalid_op+0x1a/0x20
[   12.529905][    T1]  ? __flush_work+0xad/0xa20
[   12.529919][    T1]  ? __flush_work+0x878/0xa20
[   12.529935][    T1]  ? __flush_work+0x879/0xa20
[   12.529951][    T1]  ? rcu_is_watching+0x12/0xc0
[   12.529999][    T1]  ? __pfx___flush_work+0x10/0x10
[   12.530012][    T1]  ? __pfx_mark_lock+0x10/0x10
[   12.530034][    T1]  ? mark_held_locks+0x9f/0xe0
[   12.530052][    T1]  __cancel_work_timer+0x3f3/0x590
[   12.530068][    T1]  ? __pfx___cancel_work_timer+0x10/0x10
[   12.530083][    T1]  ? modeset_lock+0x10e/0x6c0
[   12.530102][    T1]  ? drm_modeset_lock+0x60/0x90
[   12.530120][    T1]  ? drm_atomic_get_crtc_state+0xd2/0x440
[   12.530144][    T1]  ? drm_atomic_get_plane_state+0x17a/0x590
[   12.530168][    T1]  drm_client_modeset_commit_atomic+0x294/0x820
[   12.530195][    T1]  ? trace_contention_end+0xda/0x110
[   12.530217][    T1]  ? __pfx_drm_client_modeset_commit_atomic+0x10/0x10
[   12.530305][    T1]  ? __mutex_lock+0x1a6/0x9d0
[   12.530329][    T1]  ? __mutex_lock+0x1a6/0x9d0
[   12.530351][    T1]  ? __pfx___mutex_unlock_slowpath+0x10/0x10
[   12.530374][    T1]  drm_client_modeset_commit_locked+0x14d/0x580
[   12.530397][    T1]  drm_fb_helper_pan_display+0x2a5/0x990
[   12.530416][    T1]  fb_pan_display+0x477/0x7d0
[   12.530436][    T1]  ? __pfx_drm_fb_helper_pan_display+0x10/0x10
[   12.530454][    T1]  bit_update_start+0x49/0x1f0
[   12.530472][    T1]  fbcon_switch+0xbbf/0x12f0
[   12.530489][    T1]  ? __pfx_fbcon_switch+0x10/0x10
[   12.530507][    T1]  ? __pfx_bit_cursor+0x10/0x10
[   12.530525][    T1]  ? fbcon_cursor+0x3e0/0x540
[   12.530542][    T1]  ? is_console_locked+0x9/0x20
[   12.530560][    T1]  ? con_is_visible+0x65/0x150
[   12.530581][    T1]  redraw_screen+0x2bf/0x760
[   12.530596][    T1]  ? fbcon_prepare_logo+0x926/0xc80
[   12.530615][    T1]  ? __pfx_redraw_screen+0x10/0x10
[   12.530631][    T1]  set_con2fb_map+0x796/0x1060
[   12.530649][    T1]  fbcon_fb_registered+0x21d/0x670
[   12.530667][    T1]  ? fb_var_to_videomode+0x4c9/0x690
[   12.530691][    T1]  register_framebuffer+0x4b2/0x860
[   12.530714][    T1]  ? __pfx_register_framebuffer+0x10/0x10
[   12.530738][    T1]  ? drm_fbdev_generic_helper_fb_probe+0x4e2/0x6d0
[   12.530756][    T1]  __drm_fb_helper_initial_config_and_unlock+0xd82/0x1=
650
[   12.530779][    T1]  ? __pfx___drm_fb_helper_initial_config_and_unlock+0=
x10/0x10
[   12.530802][    T1]  drm_fb_helper_initial_config+0x44/0x60
[   12.530825][    T1]  drm_fbdev_generic_client_hotplug+0x1a6/0x280
[   12.530843][    T1]  ? __pfx_drm_fbdev_generic_client_hotplug+0x10/0x10
[   12.530860][    T1]  drm_client_register+0x195/0x280
[   12.530884][    T1]  drm_fbdev_generic_setup+0x184/0x340
[   12.530901][    T1]  virtio_gpu_probe+0x29d/0x4e0
[   12.530927][    T1]  virtio_dev_probe+0x5ff/0x9b0
[   12.530943][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[   12.530958][    T1]  really_probe+0x23a/0xcb0
[   12.530981][    T1]  __driver_probe_device+0x1de/0x4b0
[   12.530996][    T1]  ? _raw_spin_unlock_irqrestore+0x52/0x80
[   12.531020][    T1]  driver_probe_device+0x4c/0x1b0
[   12.531037][    T1]  __driver_attach+0x283/0x580
[   12.531053][    T1]  ? __pfx___driver_attach+0x10/0x10
[   12.531068][    T1]  bus_for_each_dev+0x13c/0x1d0
[   12.531087][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[   12.531108][    T1]  bus_add_driver+0x2ed/0x640
[   12.531128][    T1]  ? __pfx_virtio_gpu_driver_init+0x10/0x10
[   12.531149][    T1]  driver_register+0x15c/0x4b0
[   12.531168][    T1]  do_one_initcall+0x11c/0x670
[   12.531191][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[   12.531214][    T1]  ? trace_kmalloc+0x2e/0xb0
[   12.531238][    T1]  ? __kmalloc+0x218/0x440
[   12.531258][    T1]  kernel_init_freeable+0x68d/0xc10
[   12.531286][    T1]  ? __pfx_kernel_init+0x10/0x10
[   12.531306][    T1]  kernel_init+0x1c/0x2a0
[   12.531325][    T1]  ? __pfx_kernel_init+0x10/0x10
[   12.531343][    T1]  ret_from_fork+0x45/0x80
[   12.531366][    T1]  ? __pfx_kernel_init+0x10/0x10
[   12.531390][    T1]  ret_from_fork_asm+0x1b/0x30
[   12.531420][    T1]  </TASK>
[   12.531431][    T1] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...
[   12.531437][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.8.0-rc4-=
syzkaller-g7e90b5c295ec-dirty #0
[   12.531458][    T1] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), =
BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   12.531469][    T1] Call Trace:
[   12.531474][    T1]  <TASK>
[   12.531479][    T1]  dump_stack_lvl+0xd9/0x1b0
[   12.531497][    T1]  panic+0x6ee/0x7a0
[   12.531516][    T1]  ? __pfx_panic+0x10/0x10
[   12.531534][    T1]  ? show_trace_log_lvl+0x363/0x500
[   12.531557][    T1]  ? check_panic_on_warn+0x1f/0xb0
[   12.531578][    T1]  ? __flush_work+0x879/0xa20
[   12.531593][    T1]  check_panic_on_warn+0xab/0xb0
[   12.531616][    T1]  __warn+0xf2/0x390
[   12.533508][    T1]  ? __flush_work+0x879/0xa20
[   12.533508][    T1]  report_bug+0x3c0/0x580
[   12.533508][    T1]  handle_bug+0x3d/0x70
[   12.533508][    T1]  exc_invalid_op+0x17/0x50
[   12.533508][    T1]  asm_exc_invalid_op+0x1a/0x20
[   12.533508][    T1] RIP: 0010:__flush_work+0x879/0xa20
[   12.533508][    T1] Code: c7 60 d1 7a 8d 48 8d 35 00 00 00 00 e8 80 c0 1=
2 00 45 31 ed e9 cc fc ff ff e8 83 5a 33 00 90 0f 0b 90 eb ed e8 78 5a 33 0=
0 90 <0f> 0b 90 eb e2 e8 6d 5a 33 00 e8 68 5a 33 00 e8 63 5a 33 00 48 8b
[   12.533508][    T1] RSP: 0000:ffffc90000046fc0 EFLAGS: 00010293
[   12.533508][    T1] RAX: 0000000000000000 RBX: dffffc0000000000 RCX: fff=
fffff8157ebdd
[   12.533508][    T1] RDX: ffff8880166d8000 RSI: ffffffff8157f3a8 RDI: 000=
0000000000001
[   12.533508][    T1] RBP: ffff88801e1f1048 R08: 0000000000000001 R09: 000=
0000000000000
[   12.533508][    T1] R10: 0000000000000001 R11: 0000000000000000 R12: 000=
0000000000000
[   12.533508][    T1] R13: 0000000000000001 R14: ffff88801e1f1060 R15: 000=
0000000000001
[   12.533508][    T1]  ? __flush_work+0xad/0xa20
[   12.533508][    T1]  ? __flush_work+0x878/0xa20
[   12.533508][    T1]  ? rcu_is_watching+0x12/0xc0
[   12.533508][    T1]  ? __pfx___flush_work+0x10/0x10
[   12.533508][    T1]  ? __pfx_mark_lock+0x10/0x10
[   12.533508][    T1]  ? mark_held_locks+0x9f/0xe0
[   12.533508][    T1]  __cancel_work_timer+0x3f3/0x590
[   12.533508][    T1]  ? __pfx___cancel_work_timer+0x10/0x10
[   12.533508][    T1]  ? modeset_lock+0x10e/0x6c0
[   12.533508][    T1]  ? drm_modeset_lock+0x60/0x90
[   12.533508][    T1]  ? drm_atomic_get_crtc_state+0xd2/0x440
[   12.533508][    T1]  ? drm_atomic_get_plane_state+0x17a/0x590
[   12.533508][    T1]  drm_client_modeset_commit_atomic+0x294/0x820
[   12.533508][    T1]  ? trace_contention_end+0xda/0x110
[   12.533508][    T1]  ? __pfx_drm_client_modeset_commit_atomic+0x10/0x10
[   12.533508][    T1]  ? __mutex_lock+0x1a6/0x9d0
[   12.533508][    T1]  ? __mutex_lock+0x1a6/0x9d0
[   12.533508][    T1]  ? __pfx___mutex_unlock_slowpath+0x10/0x10
[   12.533508][    T1]  drm_client_modeset_commit_locked+0x14d/0x580
[   12.533508][    T1]  drm_fb_helper_pan_display+0x2a5/0x990
[   12.533508][    T1]  fb_pan_display+0x477/0x7d0
[   12.533508][    T1]  ? __pfx_drm_fb_helper_pan_display+0x10/0x10
[   12.533508][    T1]  bit_update_start+0x49/0x1f0
[   12.533508][    T1]  fbcon_switch+0xbbf/0x12f0
[   12.533508][    T1]  ? __pfx_fbcon_switch+0x10/0x10
[   12.533508][    T1]  ? __pfx_bit_cursor+0x10/0x10
[   12.533508][    T1]  ? fbcon_cursor+0x3e0/0x540
[   12.533508][    T1]  ? is_console_locked+0x9/0x20
[   12.533508][    T1]  ? con_is_visible+0x65/0x150
[   12.533508][    T1]  redraw_screen+0x2bf/0x760
[   12.533508][    T1]  ? fbcon_prepare_logo+0x926/0xc80
[   12.533508][    T1]  ? __pfx_redraw_screen+0x10/0x10
[   12.533508][    T1]  set_con2fb_map+0x796/0x1060
[   12.533508][    T1]  fbcon_fb_registered+0x21d/0x670
[   12.533508][    T1]  ? fb_var_to_videomode+0x4c9/0x690
[   12.533508][    T1]  register_framebuffer+0x4b2/0x860
[   12.533508][    T1]  ? __pfx_register_framebuffer+0x10/0x10
[   12.533508][    T1]  ? drm_fbdev_generic_helper_fb_probe+0x4e2/0x6d0
[   12.533508][    T1]  __drm_fb_helper_initial_config_and_unlock+0xd82/0x1=
650
[   12.533508][    T1]  ? __pfx___drm_fb_helper_initial_config_and_unlock+0=
x10/0x10
[   12.533508][    T1]  drm_fb_helper_initial_config+0x44/0x60
[   12.533508][    T1]  drm_fbdev_generic_client_hotplug+0x1a6/0x280
[   12.533508][    T1]  ? __pfx_drm_fbdev_generic_client_hotplug+0x10/0x10
[   12.533508][    T1]  drm_client_register+0x195/0x280
[   12.533508][    T1]  drm_fbdev_generic_setup+0x184/0x340
[   12.533508][    T1]  virtio_gpu_probe+0x29d/0x4e0
[   12.533508][    T1]  virtio_dev_probe+0x5ff/0x9b0
[   12.533508][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[   12.533508][    T1]  really_probe+0x23a/0xcb0
[   12.533508][    T1]  __driver_probe_device+0x1de/0x4b0
[   12.533508][    T1]  ? _raw_spin_unlock_irqrestore+0x52/0x80
[   12.533508][    T1]  driver_probe_device+0x4c/0x1b0
[   12.533508][    T1]  __driver_attach+0x283/0x580
[   12.533508][    T1]  ? __pfx___driver_attach+0x10/0x10
[   12.533508][    T1]  bus_for_each_dev+0x13c/0x1d0
[   12.533508][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[   12.533508][    T1]  bus_add_driver+0x2ed/0x640
[   12.533508][    T1]  ? __pfx_virtio_gpu_driver_init+0x10/0x10
[   12.533508][    T1]  driver_register+0x15c/0x4b0
[   12.533508][    T1]  do_one_initcall+0x11c/0x670
[   12.533508][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[   12.533508][    T1]  ? trace_kmalloc+0x2e/0xb0
[   12.533508][    T1]  ? __kmalloc+0x218/0x440
[   12.533508][    T1]  kernel_init_freeable+0x68d/0xc10
[   12.533508][    T1]  ? __pfx_kernel_init+0x10/0x10
[   12.533508][    T1]  kernel_init+0x1c/0x2a0
[   12.533508][    T1]  ? __pfx_kernel_init+0x10/0x10
[   12.533508][    T1]  ret_from_fork+0x45/0x80
[   12.533508][    T1]  ? __pfx_kernel_init+0x10/0x10
[   12.533508][    T1]  ret_from_fork_asm+0x1b/0x30
[   12.533508][    T1]  </TASK>
[   12.533508][    T1] Kernel Offset: disabled


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
 -fdebug-prefix-map=3D/tmp/go-build3587630670=3D/tmp/go-build -gno-record-g=
cc-switches"

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
https://syzkaller.appspot.com/x/error.txt?x=3D16112678180000


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
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D10c28d141800=
00


