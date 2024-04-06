Return-Path: <linux-kernel+bounces-133971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9630889AB9D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 17:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0231DB20ED9
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 15:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A72539FE0;
	Sat,  6 Apr 2024 15:20:09 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE3939AC9
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 15:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712416808; cv=none; b=M5lmK/CYl9PYqJWFLoDSPMTJghqO+tW1IzaajgZLUY0WXUpfkGhsPeIqcCpLpM+5DxSLOSK4P8oEGfqGz14KB4DjIpZMNnMohvK9nfMuBsTDYW7scuJsd4qvxrkcUaK4MpScuKxUK3OjIEKFBcPkYkf7lF62QQdBCmbn7xYYriE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712416808; c=relaxed/simple;
	bh=tqrrsY+XBCfNksypxF6NPqPNC5TOyvUjVNhIUQs601A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gWMWHlTzzASgGSjgqGDsfeCPxvBUW/K5M741DI6YnnTaIrwapSrlyVmprV1O3WYZCg4jq7y7jHQx33Xrmi9/DGK0Pn3N9xc0qZNjnxFHpEh+PamZUBuSg9BrK7UJrjRTN/JbMbKs+jxio7eFNhOhPVe0n+73JfP2VlNYnZC1uss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7cc7a6a043bso325667839f.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2024 08:20:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712416805; x=1713021605;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gWAEF7r12LGMJPfZEz32k9N+C5Ui/u2RqkiUIUspNMg=;
        b=WuRVcKjhMnRsOikMw+QqgfEpaK0k9FgFmxIr/H2FlieWGq00/c9y9S3s7j7CBiRGaU
         LNM+HR1ZhMKaDoncYDhuDfHRx2JDU8o01ZzxmV/XagTLkHoLmCpg9VKtAfyGvKdY8iC9
         XtBI2SyaBV8v/ATqUTYrPOwrMFYh1KweRDuHNDZu9N/NQZq8kwzXB0WVy4X2gu8Km7jA
         coN1NO4MJVm/9P9g7MobIXh0YpdUKSEcoCGN2ax5bYgW45yXE3F2SrrhELE4F4ZaoDUi
         syQ+clhoejfCMT0wAiISgCPQ99bVkf+ha7anhouQwmUMvAdXG5lrrSyOHfw3bpcc0DYD
         j7Eg==
X-Forwarded-Encrypted: i=1; AJvYcCV8imyJhIu9HobRHevKTKl1Bd/uufnBxFoof8i7r2M1hLJOg000pYSXNNjFGRrLtb9mNDZdfA2pXdWgNEG9Rhs8gfOci94kK4ZO9LDz
X-Gm-Message-State: AOJu0YyPcbhDPtAq5IMnycA1vfist0BJeRbYaJSueRtHnk9FL30GZtkA
	NdU1DOJOQ+3iYYDuY5uFisPh4uKg8m4RHtdqyr+ZpJmmWhAeGF5zBXCvISCINpLQWOV4zT8XxQg
	nNJbhZGtfqCyl3+sWpIBS6oWfxe2b7hZUAAk2I/MeIANN9x5wnmtegr4=
X-Google-Smtp-Source: AGHT+IEH2ZIBaMJil0LEaVxkxjUle/W6nh6shQBOjKJgQK9cn/kdN+OSVrZce/gRA5MzX007eBqcdf0X/HDqvq0HbAyQExH7IC5h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:6d0b:b0:47e:db91:dd2a with SMTP id
 he11-20020a0566386d0b00b0047edb91dd2amr245392jab.3.1712416805097; Sat, 06 Apr
 2024 08:20:05 -0700 (PDT)
Date: Sat, 06 Apr 2024 08:20:05 -0700
In-Reply-To: <20240405063751.835-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000060268306156f1ba9@google.com>
Subject: Re: [syzbot] [net?] WARNING in cleanup_net (3)
From: syzbot <syzbot+9ada62e1dc03fdc41982@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

  74.666060][ T5073] team0: Port device team_slave_1 added
[   74.696681][ T5073] batman_adv: batadv0: Adding interface: batadv_slave_=
0
[   74.703624][ T5073] batman_adv: batadv0: The MTU of interface batadv_sla=
ve_0 is too small (1500) to handle the transport of batman-adv packets. Pac=
kets going over this interface will be fragmented on layer2 which could imp=
act the performance. Setting the MTU to 1560 would solve the problem.
[   74.729664][ T5073] batman_adv: batadv0: Not using interface batadv_slav=
e_0 (retrying later): interface not active
[   74.742982][ T5073] batman_adv: batadv0: Adding interface: batadv_slave_=
1
[   74.750067][ T5073] batman_adv: batadv0: The MTU of interface batadv_sla=
ve_1 is too small (1500) to handle the transport of batman-adv packets. Pac=
kets going over this interface will be fragmented on layer2 which could imp=
act the performance. Setting the MTU to 1560 would solve the problem.
[   74.776113][ T5073] batman_adv: batadv0: Not using interface batadv_slav=
e_1 (retrying later): interface not active
[   74.826626][ T5073] hsr_slave_0: entered promiscuous mode
[   74.833774][ T5073] hsr_slave_1: entered promiscuous mode
[   74.986810][ T5073] netdevsim netdevsim0 netdevsim0: renamed from eth0
[   74.998682][ T5073] netdevsim netdevsim0 netdevsim1: renamed from eth1
[   75.010024][ T5073] netdevsim netdevsim0 netdevsim2: renamed from eth2
[   75.020591][ T5073] netdevsim netdevsim0 netdevsim3: renamed from eth3
executing program
[   75.057449][ T5073] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   75.064909][ T5073] bridge0: port 2(bridge_slave_1) entered forwarding s=
tate
[   75.072881][ T5073] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[   75.080104][ T5073] bridge0: port 1(bridge_slave_0) entered forwarding s=
tate
[   75.156591][ T5073] 8021q: adding VLAN 0 to HW filter on device bond0
[   75.178956][    T8] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[   75.188008][    T8] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[   75.206302][ T5073] 8021q: adding VLAN 0 to HW filter on device team0
[   75.220345][   T49] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[   75.227507][   T49] bridge0: port 1(bridge_slave_0) entered forwarding s=
tate
[   75.246459][    T7] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   75.253719][    T7] bridge0: port 2(bridge_slave_1) entered forwarding s=
tate
[   75.441809][ T5073] 8021q: adding VLAN 0 to HW filter on device batadv0
[   75.493643][ T5073] veth0_vlan: entered promiscuous mode
[   75.511542][ T5073] veth1_vlan: entered promiscuous mode
[   75.548734][ T5073] veth0_macvtap: entered promiscuous mode
[   75.558643][ T5073] veth1_macvtap: entered promiscuous mode
[   75.580898][ T5073] batman_adv: batadv0: Interface activated: batadv_sla=
ve_0
[   75.597516][ T5073] batman_adv: batadv0: Interface activated: batadv_sla=
ve_1
[   75.612147][ T5073] netdevsim netdevsim0 netdevsim0: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   75.622705][ T5073] netdevsim netdevsim0 netdevsim1: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   75.633004][ T5073] netdevsim netdevsim0 netdevsim2: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   75.642196][ T5073] netdevsim netdevsim0 netdevsim3: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   75.720798][ T1089] wlan0: Created IBSS using preconfigured BSSID 50:50:=
50:50:50:50
[   75.729210][ T1089] wlan0: Creating new IBSS network, BSSID 50:50:50:50:=
50:50
[   75.761384][ T1028] wlan1: Created IBSS using preconfigured BSSID 50:50:=
50:50:50:50
[   75.770152][ T1028] wlan1: Creating new IBSS network, BSSID 50:50:50:50:=
50:50
2024/04/06 15:18:47 building call list...
[   75.905861][ T5073] ref_tracker: net refcnt@ffff8880222c0148 has 1/1 use=
rs at
[   75.905861][ T5073]      sk_alloc+0x1af/0x350
[   75.905861][ T5073]      tun_chr_open+0x7a/0x510
[   75.905861][ T5073]      misc_open+0x315/0x390
[   75.905861][ T5073]      chrdev_open+0x5b2/0x630
[   75.905861][ T5073]      do_dentry_open+0x909/0x15a0
[   75.905861][ T5073]      path_openat+0x2860/0x3240
[   75.905861][ T5073]      do_filp_open+0x235/0x490
[   75.905861][ T5073]      do_sys_openat2+0x13e/0x1d0
[   75.905861][ T5073]      __x64_sys_openat+0x247/0x2a0
[   75.905861][ T5073]      do_syscall_64+0xfd/0x240
[   75.905861][ T5073]      entry_SYSCALL_64_after_hwframe+0x6d/0x75
[   75.905861][ T5073]=20
[   75.979496][ T5073] ------------[ cut here ]------------
[   75.985963][ T5073] WARNING: CPU: 0 PID: 5073 at lib/ref_tracker.c:179 r=
ef_tracker_dir_exit+0x411/0x550
[   75.995634][ T5073] Modules linked in:
[   75.999559][ T5073] CPU: 0 PID: 5073 Comm: syz-executor.0 Not tainted 6.=
8.0-syzkaller-08951-gfe46a7dd189e-dirty #0
[   76.010206][ T5073] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 03/27/2024
[   76.020324][ T5073] RIP: 0010:ref_tracker_dir_exit+0x411/0x550
[   76.026442][ T5073] Code: 48 8b 1c 24 48 89 df 48 8b 74 24 20 e8 48 e8 9=
f 06 eb 1a e8 31 d3 b5 fc 48 8b 1c 24 48 89 df 48 8b 74 24 20 e8 30 e8 9f 0=
6 90 <0f> 0b 90 48 83 c3 44 48 89 df be 04 00 00 00 e8 9b 24 19 fd 48 89
[   76.046525][ T5073] RSP: 0018:ffffc900044a79a0 EFLAGS: 00010246
[   76.052621][ T5073] RAX: 07ca3c5e6899b200 RBX: ffff8880222c0148 RCX: 000=
0000000000001
[   76.061276][ T5073] RDX: dffffc0000000000 RSI: ffffffff8baac1e0 RDI: 000=
0000000000001
[   76.069472][ T5073] RBP: ffffc900044a7a70 R08: ffffffff8f873a6f R09: 1ff=
ffffff1f0e74d
[   76.077665][ T5073] R10: dffffc0000000000 R11: fffffbfff1f0e74e R12: 1ff=
ff110049d72f8
[   76.085764][ T5073] R13: dead000000000100 R14: ffff8880222c0198 R15: dff=
ffc0000000000
[   76.093785][ T5073] FS:  0000000000000000(0000) GS:ffff8880b9400000(0000=
) knlGS:0000000000000000
[   76.102832][ T5073] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   76.109499][ T5073] CR2: 00007ffe64587f58 CR3: 000000002af48000 CR4: 000=
0000000350ef0
[   76.117552][ T5073] Call Trace:
[   76.120893][ T5073]  <TASK>
[   76.123846][ T5073]  ? __warn+0x163/0x4b0
[   76.128285][ T5073]  ? ref_tracker_dir_exit+0x411/0x550
[   76.133708][ T5073]  ? report_bug+0x2b3/0x500
[   76.138632][ T5073]  ? ref_tracker_dir_exit+0x411/0x550
[   76.144061][ T5073]  ? handle_bug+0x3e/0x70
[   76.148725][ T5073]  ? exc_invalid_op+0x1a/0x50
[   76.153433][ T5073]  ? asm_exc_invalid_op+0x1a/0x20
[   76.158555][ T5073]  ? ref_tracker_dir_exit+0x411/0x550
[   76.163983][ T5073]  ? __pfx_ref_tracker_dir_exit+0x10/0x10
[   76.169829][ T5073]  ? free_nsproxy+0x28f/0x3b0
[   76.174590][ T5073]  ? srso_return_thunk+0x5/0x5f
[   76.179476][ T5073]  ? kfree+0x14a/0x380
[   76.183575][ T5073]  __put_net+0x19/0x60
[   76.187755][ T5073]  free_nsproxy+0x30a/0x3b0
[   76.192315][ T5073]  do_exit+0xa16/0x27e0
[   76.196611][ T5073]  ? srso_return_thunk+0x5/0x5f
[   76.201489][ T5073]  ? __pfx_do_exit+0x10/0x10
[   76.206461][ T5073]  ? __pfx_do_raw_spin_lock+0x10/0x10
[   76.211883][ T5073]  ? srso_return_thunk+0x5/0x5f
[   76.216829][ T5073]  ? lockdep_hardirqs_on_prepare+0x43d/0x780
[   76.222856][ T5073]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[   76.229291][ T5073]  ? _raw_spin_lock_irq+0xdf/0x120
[   76.234528][ T5073]  do_group_exit+0x207/0x2c0
[   76.239390][ T5073]  ? _raw_spin_unlock_irq+0x23/0x50
[   76.244928][ T5073]  ? srso_return_thunk+0x5/0x5f
[   76.249814][ T5073]  ? lockdep_hardirqs_on+0x99/0x150
[   76.255099][ T5073]  get_signal+0x176e/0x1850
[   76.259655][ T5073]  ? __pfx__raw_spin_unlock_irqrestore+0x10/0x10
[   76.266119][ T5073]  ? __pfx_get_signal+0x10/0x10
[   76.271013][ T5073]  ? debug_check_no_obj_freed+0x561/0x580
[   76.277008][ T5073]  arch_do_signal_or_restart+0x96/0x860
[   76.282599][ T5073]  ? __pfx_arch_do_signal_or_restart+0x10/0x10
[   76.289844][ T5073]  ? lockdep_hardirqs_on_prepare+0x43d/0x780
[   76.294843][ T4465] Bluetooth: hci0: command tx timeout
[   76.295900][ T5073]  ? syscall_exit_to_user_mode+0xa3/0x360
[   76.307083][ T5073]  syscall_exit_to_user_mode+0xc9/0x360
[   76.312673][ T5073]  do_syscall_64+0x10a/0x240
[   76.317377][ T5073]  entry_SYSCALL_64_after_hwframe+0x6d/0x75
[   76.323305][ T5073] RIP: 0033:0x7faaf287cd5a
[   76.327851][ T5073] Code: Unable to access opcode bytes at 0x7faaf287cd3=
0.
[   76.334934][ T5073] RSP: 002b:00007ffe645897e0 EFLAGS: 00000293 ORIG_RAX=
: 0000000000000003
[   76.343712][ T5073] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 000=
07faaf287cd5a
[   76.351985][ T5073] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000003
[   76.360059][ T5073] RBP: 00007ffe6458985c R08: 0000000000000000 R09: 000=
07ffe64589547
[   76.368276][ T5073] R10: 0000000000000000 R11: 0000000000000293 R12: 000=
0000000000032
[   76.376330][ T5073] R13: 000000000001282f R14: 000000000001281f R15: 000=
0000000000003
[   76.384447][ T5073]  </TASK>
[   76.387492][ T5073] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...
[   76.394807][ T5073] CPU: 0 PID: 5073 Comm: syz-executor.0 Not tainted 6.=
8.0-syzkaller-08951-gfe46a7dd189e-dirty #0
[   76.405345][ T5073] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 03/27/2024
[   76.415414][ T5073] Call Trace:
[   76.418704][ T5073]  <TASK>
[   76.421647][ T5073]  dump_stack_lvl+0x241/0x360
[   76.426366][ T5073]  ? __pfx_dump_stack_lvl+0x10/0x10
[   76.431623][ T5073]  ? __pfx__printk+0x10/0x10
[   76.436256][ T5073]  ? srso_return_thunk+0x5/0x5f
[   76.441133][ T5073]  ? vscnprintf+0x5d/0x90
[   76.445501][ T5073]  panic+0x349/0x860
[   76.449437][ T5073]  ? srso_return_thunk+0x5/0x5f
[   76.454321][ T5073]  ? __warn+0x172/0x4b0
[   76.458513][ T5073]  ? __pfx_panic+0x10/0x10
[   76.463004][ T5073]  __warn+0x31e/0x4b0
[   76.467040][ T5073]  ? ref_tracker_dir_exit+0x411/0x550
[   76.472466][ T5073]  report_bug+0x2b3/0x500
[   76.476832][ T5073]  ? ref_tracker_dir_exit+0x411/0x550
[   76.482254][ T5073]  handle_bug+0x3e/0x70
[   76.486444][ T5073]  exc_invalid_op+0x1a/0x50
[   76.491411][ T5073]  asm_exc_invalid_op+0x1a/0x20
[   76.496283][ T5073] RIP: 0010:ref_tracker_dir_exit+0x411/0x550
[   76.502653][ T5073] Code: 48 8b 1c 24 48 89 df 48 8b 74 24 20 e8 48 e8 9=
f 06 eb 1a e8 31 d3 b5 fc 48 8b 1c 24 48 89 df 48 8b 74 24 20 e8 30 e8 9f 0=
6 90 <0f> 0b 90 48 83 c3 44 48 89 df be 04 00 00 00 e8 9b 24 19 fd 48 89
[   76.522277][ T5073] RSP: 0018:ffffc900044a79a0 EFLAGS: 00010246
[   76.528381][ T5073] RAX: 07ca3c5e6899b200 RBX: ffff8880222c0148 RCX: 000=
0000000000001
[   76.536367][ T5073] RDX: dffffc0000000000 RSI: ffffffff8baac1e0 RDI: 000=
0000000000001
[   76.544448][ T5073] RBP: ffffc900044a7a70 R08: ffffffff8f873a6f R09: 1ff=
ffffff1f0e74d
[   76.552431][ T5073] R10: dffffc0000000000 R11: fffffbfff1f0e74e R12: 1ff=
ff110049d72f8
[   76.560413][ T5073] R13: dead000000000100 R14: ffff8880222c0198 R15: dff=
ffc0000000000
[   76.568441][ T5073]  ? __pfx_ref_tracker_dir_exit+0x10/0x10
[   76.574191][ T5073]  ? free_nsproxy+0x28f/0x3b0
[   76.578889][ T5073]  ? srso_return_thunk+0x5/0x5f
[   76.583751][ T5073]  ? kfree+0x14a/0x380
[   76.588098][ T5073]  __put_net+0x19/0x60
[   76.592182][ T5073]  free_nsproxy+0x30a/0x3b0
[   76.596712][ T5073]  do_exit+0xa16/0x27e0
[   76.600909][ T5073]  ? srso_return_thunk+0x5/0x5f
[   76.605863][ T5073]  ? __pfx_do_exit+0x10/0x10
[   76.610470][ T5073]  ? __pfx_do_raw_spin_lock+0x10/0x10
[   76.615867][ T5073]  ? srso_return_thunk+0x5/0x5f
[   76.620727][ T5073]  ? lockdep_hardirqs_on_prepare+0x43d/0x780
[   76.626722][ T5073]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[   76.633061][ T5073]  ? _raw_spin_lock_irq+0xdf/0x120
[   76.638194][ T5073]  do_group_exit+0x207/0x2c0
[   76.642805][ T5073]  ? _raw_spin_unlock_irq+0x23/0x50
[   76.648021][ T5073]  ? srso_return_thunk+0x5/0x5f
[   76.652912][ T5073]  ? lockdep_hardirqs_on+0x99/0x150
[   76.658135][ T5073]  get_signal+0x176e/0x1850
[   76.662661][ T5073]  ? __pfx__raw_spin_unlock_irqrestore+0x10/0x10
[   76.669017][ T5073]  ? __pfx_get_signal+0x10/0x10
[   76.673885][ T5073]  ? debug_check_no_obj_freed+0x561/0x580
[   76.679630][ T5073]  arch_do_signal_or_restart+0x96/0x860
[   76.685205][ T5073]  ? __pfx_arch_do_signal_or_restart+0x10/0x10
[   76.691376][ T5073]  ? lockdep_hardirqs_on_prepare+0x43d/0x780
[   76.697377][ T5073]  ? syscall_exit_to_user_mode+0xa3/0x360
[   76.703118][ T5073]  syscall_exit_to_user_mode+0xc9/0x360
[   76.708688][ T5073]  do_syscall_64+0x10a/0x240
[   76.713304][ T5073]  entry_SYSCALL_64_after_hwframe+0x6d/0x75
[   76.719212][ T5073] RIP: 0033:0x7faaf287cd5a
[   76.723630][ T5073] Code: Unable to access opcode bytes at 0x7faaf287cd3=
0.
[   76.730651][ T5073] RSP: 002b:00007ffe645897e0 EFLAGS: 00000293 ORIG_RAX=
: 0000000000000003
[   76.739077][ T5073] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 000=
07faaf287cd5a
[   76.747051][ T5073] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000003
[   76.755026][ T5073] RBP: 00007ffe6458985c R08: 0000000000000000 R09: 000=
07ffe64589547
[   76.763004][ T5073] R10: 0000000000000000 R11: 0000000000000293 R12: 000=
0000000000032
[   76.770980][ T5073] R13: 000000000001282f R14: 000000000001281f R15: 000=
0000000000003
[   76.778969][ T5073]  </TASK>
[   76.782215][ T5073] Kernel Offset: disabled
[   76.786567][ T5073] Rebooting in 86400 seconds..


syzkaller build log:
go env (err=3D<nil>)
GO111MODULE=3D'auto'
GOARCH=3D'amd64'
GOBIN=3D''
GOCACHE=3D'/syzkaller/.cache/go-build'
GOENV=3D'/syzkaller/.config/go/env'
GOEXE=3D''
GOEXPERIMENT=3D''
GOFLAGS=3D''
GOHOSTARCH=3D'amd64'
GOHOSTOS=3D'linux'
GOINSECURE=3D''
GOMODCACHE=3D'/syzkaller/jobs/linux/gopath/pkg/mod'
GONOPROXY=3D''
GONOSUMDB=3D''
GOOS=3D'linux'
GOPATH=3D'/syzkaller/jobs/linux/gopath'
GOPRIVATE=3D''
GOPROXY=3D'https://proxy.golang.org,direct'
GOROOT=3D'/usr/local/go'
GOSUMDB=3D'sum.golang.org'
GOTMPDIR=3D''
GOTOOLCHAIN=3D'auto'
GOTOOLDIR=3D'/usr/local/go/pkg/tool/linux_amd64'
GOVCS=3D''
GOVERSION=3D'go1.21.4'
GCCGO=3D'gccgo'
GOAMD64=3D'v1'
AR=3D'ar'
CC=3D'gcc'
CXX=3D'g++'
CGO_ENABLED=3D'1'
GOMOD=3D'/syzkaller/jobs/linux/gopath/src/github.com/google/syzkaller/go.mo=
d'
GOWORK=3D''
CGO_CFLAGS=3D'-O2 -g'
CGO_CPPFLAGS=3D''
CGO_CXXFLAGS=3D'-O2 -g'
CGO_FFLAGS=3D'-O2 -g'
CGO_LDFLAGS=3D'-O2 -g'
PKG_CONFIG=3D'pkg-config'
GOGCCFLAGS=3D'-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=3D0=
 -ffile-prefix-map=3D/tmp/go-build4023541434=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at 0ee3535ea
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
go list -f '{{.Stale}}' ./sys/syz-sysgen | grep -q false || go install ./sy=
s/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
bin/syz-sysgen
touch .descriptions
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D0ee3535ea8ff21d50e44372bb1cfd147e299ab5b -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240404-085507'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer=
 github.com/google/syzkaller/syz-fuzzer
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D0ee3535ea8ff21d50e44372bb1cfd147e299ab5b -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240404-085507'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D0ee3535ea8ff21d50e44372bb1cfd147e299ab5b -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240404-085507'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress=
 github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -fpermissive -w -DGOOS_linux=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"0ee3535ea8ff21d50e44372bb1cfd147e2=
99ab5b\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D1440efc5180000


Tested on:

commit:         fe46a7dd Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dfe78468a74fdc3b=
7
dashboard link: https://syzkaller.appspot.com/bug?extid=3D9ada62e1dc03fdc41=
982
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D15954d8d1800=
00


