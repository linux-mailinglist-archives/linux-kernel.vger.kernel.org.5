Return-Path: <linux-kernel+bounces-134148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D794589AE40
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 05:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06B941C20B72
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 03:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EFE1876;
	Sun,  7 Apr 2024 03:20:07 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C3117C9
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 03:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712460006; cv=none; b=MEX+tZxVynlGcvaAJyW9FYtqCzbiYfNJmg27gpxtcRFkKf8RD43n97mpfiE9vnGGRjDaZfdH5m8ybDpZbKIf4pn4Lbd1oduH6kNuex/RuM7WlXuKT+VaLTmJq2Sgdm3DrbqBsfrK4qfqfvu9rIky5dZ/FG76fR7Lh2P8vQrbNW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712460006; c=relaxed/simple;
	bh=cJ9TKNTHcErQUuKtP7AoUNFpQSvMqxqp5kdpOe7NO8I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MccmOFj0yV/uBWUjUNpPW6xM5QWHxALO23rEgP0HDlBQFMUR3ASGTkmDxbftFHS5A+MXiezXhxr7wVsBvyYzySl0o7/lrAi7tfytIYUtt8wjf81ezzxkHhbW/oOeB/UcTPkgkxXUUtLkBsxN6ns/0azxsjtfDd17vghq1+k0UJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36660582091so39096045ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2024 20:20:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712460003; x=1713064803;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vttj04wUxwaLToOI5LrK3wikkaI9hckB2zihVUwBaMc=;
        b=uzV/TLRv5DsLZexrtX9yg8spCksy+UZK7oEdAZuabfYYHnomgHaBNn8EhWCT3cm5Er
         rD6pKoeW0ubFDX23zFJoZZZKknn7vT+PFIATX7lgKxSn48xcVRUtimFbOorVU826Ylg7
         IuvUuvYw2EmaWZuObigvaEHKbTITIOEnOHHzxBr4737j0xLx0fcv/aj17KwVX7v1EBRG
         /dkwSE2PdC7aQPH1Upd7OXNaCxJ1u51KDoE5C/kfcJXVrUAQjyMcj+5muUxGvHuT0kVW
         R+jg5M/c0Duh60xd+8hbBFMxmCuILc3uvJbdoyMR3WCwTvNCdQQF+RwFbyuegYneG8rg
         UXpA==
X-Forwarded-Encrypted: i=1; AJvYcCVO6jDpkq3Pq1/ZyVAkCTf5QtCqQN/KnEg6Oxlcq1yW7zYvdRH8umZTnE/pVe1XC5V7LmLIGrj3XkFaq1SIBi9kUj9dU2PxfK6+SRPd
X-Gm-Message-State: AOJu0Yy8i8UANtGkI2kVMDQHsgZjAPZFA0qOoZ07fGpgZPsfVNFdOApB
	GBRwLIGJ5iqzJzm3gHAV/Ql/tI4AujHbiNU40Luoe0fTgQDcAoQ7K0GLB9BMPHgJHwSKpV9F7ne
	Hj1V93aTy5B+OiE7tCPdYkbbG8hAJaJqZOBYC9o09rMMKj83N+sT6NGY=
X-Google-Smtp-Source: AGHT+IFIdm9XLTEgJZ8lszzFGl6Kf6J2M6ExkoJq0O45Y8Ukt7m5XWex6lidtN+Q6mPVoJJu1KqBfB5Dx1MEvCnlKV8s4MgAbU6t
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2192:b0:36a:1e10:6823 with SMTP id
 j18-20020a056e02219200b0036a1e106823mr93897ila.2.1712460003277; Sat, 06 Apr
 2024 20:20:03 -0700 (PDT)
Date: Sat, 06 Apr 2024 20:20:03 -0700
In-Reply-To: <20240406224857.1297-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000300def0615792af1@google.com>
Subject: Re: [syzbot] [net?] WARNING in cleanup_net (3)
From: syzbot <syzbot+9ada62e1dc03fdc41982@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

are+0x38/0x40
[   77.597915][ T5085]      do_syscall_64+0xfd/0x240
[   77.597915][ T5085]      entry_SYSCALL_64_after_hwframe+0x6d/0x75
[   77.597915][ T5085]=20
[   77.673058][ T5085] ref_tracker: net notrefcnt@ffff8880226f01d8 skipped =
reports about 9/30 users.
[   77.701239][   T61] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   77.709356][   T61] BUG: KASAN: slab-use-after-free in net_generic+0x137=
/0x240
[   77.716805][   T61] Read of size 8 at addr ffff88802a43e828 by task kwor=
ker/u8:4/61
[   77.724631][   T61]=20
[   77.726967][   T61] CPU: 0 PID: 61 Comm: kworker/u8:4 Not tainted 6.8.0-=
syzkaller-08951-gfe46a7dd189e-dirty #0
[   77.737146][   T61] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 03/27/2024
[   77.747221][   T61] Workqueue: ipv6_addrconf addrconf_dad_work
[   77.753246][   T61] Call Trace:
[   77.756539][   T61]  <TASK>
[   77.759487][   T61]  dump_stack_lvl+0x241/0x360
[   77.764202][   T61]  ? __pfx_dump_stack_lvl+0x10/0x10
[   77.769440][   T61]  ? __pfx__printk+0x10/0x10
[   77.774072][   T61]  ? _printk+0xd5/0x120
[   77.778297][   T61]  ? __virt_addr_valid+0x183/0x520
[   77.783446][   T61]  ? srso_return_thunk+0x5/0x5f
[   77.788325][   T61]  print_report+0x169/0x550
[   77.792863][   T61]  ? __virt_addr_valid+0x183/0x520
[   77.798012][   T61]  ? srso_return_thunk+0x5/0x5f
[   77.802893][   T61]  ? __virt_addr_valid+0x44e/0x520
[   77.808045][   T61]  ? srso_return_thunk+0x5/0x5f
[   77.812923][   T61]  ? __phys_addr+0xba/0x170
[   77.817639][   T61]  ? net_generic+0x137/0x240
[   77.822251][   T61]  kasan_report+0x143/0x180
[   77.826801][   T61]  ? net_generic+0x137/0x240
[   77.831422][   T61]  ? net_generic+0x1f/0x240
[   77.835957][   T61]  net_generic+0x137/0x240
[   77.840395][   T61]  call_fib_notifiers+0x23/0x60
[   77.845304][   T61]  fib6_add+0x1bd5/0x4430
[   77.849707][   T61]  ? __pfx__raw_spin_unlock_irqrestore+0x10/0x10
[   77.856103][   T61]  ? __pfx_lock_acquire+0x10/0x10
[   77.861152][   T61]  ? __pfx_fib6_add+0x10/0x10
[   77.865864][   T61]  ? srso_return_thunk+0x5/0x5f
[   77.870742][   T61]  ? do_raw_spin_lock+0x14f/0x370
[   77.875798][   T61]  ? __pfx___local_bh_disable_ip+0x10/0x10
[   77.881630][   T61]  ? __pfx_do_raw_spin_lock+0x10/0x10
[   77.887037][   T61]  ? srso_return_thunk+0x5/0x5f
[   77.891919][   T61]  ? ip6_ins_rt+0xf0/0x170
[   77.896369][   T61]  ip6_ins_rt+0x106/0x170
[   77.900730][   T61]  ? __pfx_ip6_ins_rt+0x10/0x10
[   77.905616][   T61]  ? srso_return_thunk+0x5/0x5f
[   77.910489][   T61]  ? nlmsg_notify+0x15a/0x1c0
[   77.915196][   T61]  __ipv6_ifa_notify+0x5ca/0x11f0
[   77.920243][   T61]  ? __pfx___ipv6_ifa_notify+0x10/0x10
[   77.925724][   T61]  ? srso_return_thunk+0x5/0x5f
[   77.930599][   T61]  ? mark_lock+0x9a/0x350
[   77.934959][   T61]  ? srso_return_thunk+0x5/0x5f
[   77.939842][   T61]  ? lockdep_hardirqs_on_prepare+0x43d/0x780
[   77.945852][   T61]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[   77.952210][   T61]  ? __cancel_work+0x26a/0x390
[   77.957001][   T61]  ? srso_return_thunk+0x5/0x5f
[   77.961878][   T61]  ? lockdep_hardirqs_on+0x99/0x150
[   77.967113][   T61]  ? srso_return_thunk+0x5/0x5f
[   77.971989][   T61]  ? __cancel_work+0x2ef/0x390
[   77.976790][   T61]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[   77.983154][   T61]  addrconf_dad_completed+0x181/0xcd0
[   77.988570][   T61]  ? __pfx_addrconf_dad_completed+0x10/0x10
[   77.994527][   T61]  ? addrconf_dad_work+0x58a/0x16f0
[   77.999783][   T61]  addrconf_dad_work+0xdc2/0x16f0
[   78.004876][   T61]  ? srso_return_thunk+0x5/0x5f
[   78.009767][   T61]  ? __pfx_addrconf_dad_work+0x10/0x10
[   78.015276][   T61]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[   78.021642][   T61]  ? process_scheduled_works+0x91b/0x1770
[   78.027395][   T61]  process_scheduled_works+0xa02/0x1770
[   78.032992][   T61]  ? __pfx_process_scheduled_works+0x10/0x10
[   78.039006][   T61]  ? assign_work+0x364/0x3d0
[   78.043622][   T61]  worker_thread+0x86d/0xd70
[   78.048241][   T61]  ? _raw_spin_unlock_irqrestore+0xdd/0x140
[   78.054174][   T61]  ? __kthread_parkme+0x169/0x1d0
[   78.059229][   T61]  ? __pfx_worker_thread+0x10/0x10
[   78.064420][   T61]  kthread+0x2f2/0x390
[   78.068528][   T61]  ? __pfx_worker_thread+0x10/0x10
[   78.073668][   T61]  ? __pfx_kthread+0x10/0x10
[   78.078288][   T61]  ret_from_fork+0x4d/0x80
[   78.082745][   T61]  ? __pfx_kthread+0x10/0x10
[   78.087372][   T61]  ret_from_fork_asm+0x1a/0x30
[   78.092213][   T61]  </TASK>
[   78.095242][   T61]=20
[   78.097572][   T61] Allocated by task 5073:
[   78.101905][   T61]  kasan_save_track+0x3f/0x80
[   78.106607][   T61]  __kasan_kmalloc+0x98/0xb0
[   78.111229][   T61]  __kmalloc+0x233/0x4a0
[   78.115490][   T61]  copy_net_ns+0x10e/0x7b0
[   78.119929][   T61]  create_new_namespaces+0x425/0x7b0
[   78.125249][   T61]  unshare_nsproxy_namespaces+0x124/0x180
[   78.130996][   T61]  ksys_unshare+0x619/0xc10
[   78.135525][   T61]  __x64_sys_unshare+0x38/0x40
[   78.140320][   T61]  do_syscall_64+0xfd/0x240
[   78.144846][   T61]  entry_SYSCALL_64_after_hwframe+0x6d/0x75
[   78.150767][   T61]=20
[   78.153098][   T61] Freed by task 5085:
[   78.157087][   T61]  kasan_save_track+0x3f/0x80
[   78.161793][   T61]  kasan_save_free_info+0x40/0x50
[   78.166858][   T61]  poison_slab_object+0xa6/0xe0
[   78.171748][   T61]  __kasan_slab_free+0x37/0x60
[   78.176539][   T61]  kfree+0x14a/0x380
[   78.180452][   T61]  net_drop_ns+0x6e/0xc0
[   78.184724][   T61]  iterate_cleanup_work+0x1d2/0x260
[   78.189945][   T61]  process_scheduled_works+0xa02/0x1770
[   78.195511][   T61]  worker_thread+0x86d/0xd70
[   78.200123][   T61]  kthread+0x2f2/0x390
[   78.204225][   T61]  ret_from_fork+0x4d/0x80
[   78.208678][   T61]  ret_from_fork_asm+0x1a/0x30
[   78.213470][   T61]=20
[   78.215805][   T61] The buggy address belongs to the object at ffff88802=
a43e800
[   78.215805][   T61]  which belongs to the cache kmalloc-1k of size 1024
[   78.229884][   T61] The buggy address is located 40 bytes inside of
[   78.229884][   T61]  freed 1024-byte region [ffff88802a43e800, ffff88802=
a43ec00)
[   78.243716][   T61]=20
[   78.246057][   T61] The buggy address belongs to the physical page:
executing program
[   78.252475][   T61] page:ffffea0000a90e00 refcount:1 mapcount:0 mapping:=
0000000000000000 index:0x0 pfn:0x2a438
[   78.262645][   T61] head:ffffea0000a90e00 order:3 entire_mapcount:0 nr_p=
ages_mapped:0 pincount:0
[   78.271623][   T61] anon flags: 0xfff00000000840(slab|head|node=3D0|zone=
=3D1|lastcpupid=3D0x7ff)
[   78.280054][   T61] page_type: 0xffffffff()
[   78.284404][   T61] raw: 00fff00000000840 ffff888014c41dc0 0000000000000=
000 dead000000000001
[   78.293008][   T61] raw: 0000000000000000 0000000000100010 00000001fffff=
fff 0000000000000000
[   78.301607][   T61] page dumped because: kasan: bad access detected
[   78.308035][   T61] page_owner tracks the page as allocated
[   78.313762][   T61] page last allocated via order 3, migratetype Unmovab=
le, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COM=
P|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 17639541498, free_ts 0
[   78.333517][   T61]  post_alloc_hook+0x1ea/0x210
[   78.338325][   T61]  get_page_from_freelist+0x33ea/0x3580
[   78.343899][   T61]  __alloc_pages+0x256/0x680
[   78.348509][   T61]  alloc_slab_page+0x5f/0x160
[   78.353214][   T61]  new_slab+0x84/0x2f0
[   78.357310][   T61]  ___slab_alloc+0xc73/0x1260
[   78.362015][   T61]  __kmalloc+0x2e5/0x4a0
[   78.366275][   T61]  ops_init+0x203/0x610
[   78.370463][   T61]  register_pernet_operations+0x2cb/0x660
[   78.376214][   T61]  register_pernet_subsys+0x28/0x40
[   78.381450][   T61]  ip6table_nat_init+0x39/0x80
[   78.386249][   T61]  do_one_initcall+0x23a/0x830
[   78.391039][   T61]  do_initcall_level+0x157/0x210
[   78.395998][   T61]  do_initcalls+0x3f/0x80
[   78.400347][   T61]  kernel_init_freeable+0x435/0x5d0
[   78.405573][   T61]  kernel_init+0x1d/0x2a0
[   78.409923][   T61] page_owner free stack trace missing
[   78.415297][   T61]=20
[   78.417632][   T61] Memory state around the buggy address:
[   78.423274][   T61]  ffff88802a43e700: fc fc fc fc fc fc fc fc fc fc fc =
fc fc fc fc fc
[   78.431349][   T61]  ffff88802a43e780: fc fc fc fc fc fc fc fc fc fc fc =
fc fc fc fc fc
[   78.439423][   T61] >ffff88802a43e800: fa fb fb fb fb fb fb fb fb fb fb =
fb fb fb fb fb
[   78.447489][   T61]                                   ^
[   78.452872][   T61]  ffff88802a43e880: fb fb fb fb fb fb fb fb fb fb fb =
fb fb fb fb fb
[   78.460943][   T61]  ffff88802a43e900: fb fb fb fb fb fb fb fb fb fb fb =
fb fb fb fb fb
[   78.469270][   T61] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   78.477394][   T61] Kernel panic - not syncing: KASAN: panic_on_warn set=
 ...
[   78.485047][   T61] CPU: 0 PID: 61 Comm: kworker/u8:4 Not tainted 6.8.0-=
syzkaller-08951-gfe46a7dd189e-dirty #0
[   78.495225][   T61] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 03/27/2024
[   78.505310][   T61] Workqueue: ipv6_addrconf addrconf_dad_work
[   78.511434][   T61] Call Trace:
[   78.514731][   T61]  <TASK>
[   78.517685][   T61]  dump_stack_lvl+0x241/0x360
[   78.522408][   T61]  ? __pfx_dump_stack_lvl+0x10/0x10
[   78.527653][   T61]  ? __pfx__printk+0x10/0x10
[   78.532296][   T61]  ? srso_return_thunk+0x5/0x5f
[   78.537188][   T61]  ? vscnprintf+0x5d/0x90
[   78.541544][   T61]  panic+0x349/0x860
[   78.545472][   T61]  ? check_panic_on_warn+0x21/0xb0
[   78.550616][   T61]  ? __pfx_panic+0x10/0x10
[   78.555063][   T61]  ? mark_lock+0x9a/0x350
[   78.559419][   T61]  ? _raw_spin_unlock_irqrestore+0xd8/0x140
[   78.565358][   T61]  ? srso_return_thunk+0x5/0x5f
[   78.570235][   T61]  ? _raw_spin_unlock_irqrestore+0xdd/0x140
[   78.576165][   T61]  ? __pfx__raw_spin_unlock_irqrestore+0x10/0x10
[   78.582538][   T61]  ? print_report+0x502/0x550
[   78.587259][   T61]  check_panic_on_warn+0x86/0xb0
[   78.592247][   T61]  ? net_generic+0x137/0x240
[   78.596863][   T61]  end_report+0x6e/0x140
[   78.601143][   T61]  kasan_report+0x154/0x180
[   78.605683][   T61]  ? net_generic+0x137/0x240
[   78.610299][   T61]  ? net_generic+0x1f/0x240
[   78.614828][   T61]  net_generic+0x137/0x240
[   78.619269][   T61]  call_fib_notifiers+0x23/0x60
[   78.624143][   T61]  fib6_add+0x1bd5/0x4430
[   78.628522][   T61]  ? __pfx__raw_spin_unlock_irqrestore+0x10/0x10
[   78.634889][   T61]  ? __pfx_lock_acquire+0x10/0x10
[   78.639942][   T61]  ? __pfx_fib6_add+0x10/0x10
[   78.644649][   T61]  ? srso_return_thunk+0x5/0x5f
[   78.649561][   T61]  ? do_raw_spin_lock+0x14f/0x370
[   78.654627][   T61]  ? __pfx___local_bh_disable_ip+0x10/0x10
[   78.660470][   T61]  ? __pfx_do_raw_spin_lock+0x10/0x10
[   78.665884][   T61]  ? srso_return_thunk+0x5/0x5f
[   78.670772][   T61]  ? ip6_ins_rt+0xf0/0x170
[   78.675223][   T61]  ip6_ins_rt+0x106/0x170
[   78.679588][   T61]  ? __pfx_ip6_ins_rt+0x10/0x10
[   78.684474][   T61]  ? srso_return_thunk+0x5/0x5f
[   78.689354][   T61]  ? nlmsg_notify+0x15a/0x1c0
[   78.694064][   T61]  __ipv6_ifa_notify+0x5ca/0x11f0
[   78.699112][   T61]  ? __pfx___ipv6_ifa_notify+0x10/0x10
[   78.704684][   T61]  ? srso_return_thunk+0x5/0x5f
[   78.709561][   T61]  ? mark_lock+0x9a/0x350
[   78.713916][   T61]  ? srso_return_thunk+0x5/0x5f
[   78.718789][   T61]  ? lockdep_hardirqs_on_prepare+0x43d/0x780
[   78.724967][   T61]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[   78.731325][   T61]  ? __cancel_work+0x26a/0x390
[   78.736127][   T61]  ? srso_return_thunk+0x5/0x5f
[   78.741007][   T61]  ? lockdep_hardirqs_on+0x99/0x150
[   78.746238][   T61]  ? srso_return_thunk+0x5/0x5f
[   78.751121][   T61]  ? __cancel_work+0x2ef/0x390
[   78.755923][   T61]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[   78.762290][   T61]  addrconf_dad_completed+0x181/0xcd0
[   78.767717][   T61]  ? __pfx_addrconf_dad_completed+0x10/0x10
[   78.773655][   T61]  ? addrconf_dad_work+0x58a/0x16f0
[   78.778900][   T61]  addrconf_dad_work+0xdc2/0x16f0
[   78.783967][   T61]  ? srso_return_thunk+0x5/0x5f
[   78.788852][   T61]  ? __pfx_addrconf_dad_work+0x10/0x10
[   78.794358][   T61]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[   78.800727][   T61]  ? process_scheduled_works+0x91b/0x1770
[   78.806474][   T61]  process_scheduled_works+0xa02/0x1770
[   78.812067][   T61]  ? __pfx_process_scheduled_works+0x10/0x10
[   78.818082][   T61]  ? assign_work+0x364/0x3d0
[   78.822754][   T61]  worker_thread+0x86d/0xd70
[   78.827425][   T61]  ? _raw_spin_unlock_irqrestore+0xdd/0x140
[   78.833368][   T61]  ? __kthread_parkme+0x169/0x1d0
[   78.838514][   T61]  ? __pfx_worker_thread+0x10/0x10
[   78.843673][   T61]  kthread+0x2f2/0x390
[   78.847789][   T61]  ? __pfx_worker_thread+0x10/0x10
[   78.852931][   T61]  ? __pfx_kthread+0x10/0x10
[   78.857554][   T61]  ret_from_fork+0x4d/0x80
[   78.862007][   T61]  ? __pfx_kthread+0x10/0x10
[   78.866628][   T61]  ret_from_fork_asm+0x1a/0x30
[   78.871440][   T61]  </TASK>
[   78.874677][   T61] Kernel Offset: disabled
[   78.878995][   T61] Rebooting in 86400 seconds..


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
GOMODCACHE=3D'/syzkaller/jobs-2/linux/gopath/pkg/mod'
GONOPROXY=3D''
GONOSUMDB=3D''
GOOS=3D'linux'
GOPATH=3D'/syzkaller/jobs-2/linux/gopath'
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
GOMOD=3D'/syzkaller/jobs-2/linux/gopath/src/github.com/google/syzkaller/go.=
mod'
GOWORK=3D''
CGO_CFLAGS=3D'-O2 -g'
CGO_CPPFLAGS=3D''
CGO_CXXFLAGS=3D'-O2 -g'
CGO_FFLAGS=3D'-O2 -g'
CGO_LDFLAGS=3D'-O2 -g'
PKG_CONFIG=3D'pkg-config'
GOGCCFLAGS=3D'-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=3D0=
 -ffile-prefix-map=3D/tmp/go-build1837125112=3D/tmp/go-build -gno-record-gc=
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
https://syzkaller.appspot.com/x/error.txt?x=3D16af0699180000


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
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D148bd8f31800=
00


