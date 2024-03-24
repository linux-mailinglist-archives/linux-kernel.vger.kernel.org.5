Return-Path: <linux-kernel+bounces-115856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 271118898B7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7738CB449FF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63A42655C2;
	Mon, 25 Mar 2024 03:02:16 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F41146001
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 23:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322065; cv=none; b=XRx9aXYki3FfV9MHjQ3Jd6QzK8fLnnE1RsoOA995uF/S3B1kVh3oCLUjcdk0j/G6ia3vVlvpJKTqnwi3AlB70kdzVjOFjYbUZqJfmwBH/6KyomONK8kzIKnbO+u0P5v40rn9ejP6gwM7EHqrLlqQl3cyuuzM9o8vmiJVfNY5GBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322065; c=relaxed/simple;
	bh=FCsm2VKwJJxpc9r6U50b1/9X/XTT9PodFUWa0VKg1bo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fGNUCZMB6ERFwu74y1E0zl6M5lXI5QXQakE3qAWLdV03hwD6A7DVTFZK0kMG3JjCIBIRFsgCs4ixsAUX2tvxbMX19Nc8d+lMwr/rYvqu/d65fS9w7YsJzz3AqEyk6MTyEUn1wdthIRQxNY+SM6m7pWpBD8KfGzMp9QmjrZyuKHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c7f57fa5eeso323995639f.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 16:14:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711322062; x=1711926862;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+t/uLQ0VurYuY1cN1zZJdvO/LHb080kraLc9vqzMHk4=;
        b=AvUneuVKvEW5E1t0k6ZNAger4XLiAA/SzYEFUOYMTylWQ0xDClX7gFqbVjFyppzyHq
         O4SdNWHayU3IHFf2AcliKYd3UvRoBtKegVbxeYUCEz8LUom4sjqkCEw1zZP6ZUyqge2m
         ykjfMeIJTRT6vqam1zrmxvWjj4aOAmEhxJh2kOCQr+7OjDDSM+Qjurd289JEuvEvrTVA
         6s1FQF+V4NBKvsc2r5+O/bNucpDGy4oc9F8mAuNZTcLbDquToOYLqsDSQPyAfwgCPivF
         i/BlJwz17+W2lD1FQ3jHU2nq4/EIQembe+LhbXDUMzm9srFVGoJ07c/KtrSVT1C/N7yk
         BUZg==
X-Forwarded-Encrypted: i=1; AJvYcCXYYihASoooydoZ0DN4kGIOzfRVD6OcdZjNG9A+grssUMBXkHkBJEYcbjYYvDy6rJz5UMtUQFMLJDsLSNg5hSUinB1jSpXacrnEmK1U
X-Gm-Message-State: AOJu0YyCnCVMsB5I2E2hLnx0WEc55OfL0NBUi7zgSmBW3f3+SthE5NDI
	2hD2ES6mNGbYyQL19Rfw1JOJvm7sTWGUMrj1VIfyDEay321/IZ3lW0LRFCqTAByQUAj/M4U2dL1
	H1/XbsHXFq6kYyk8fs0o33k7XjeAs9EkHz4FwjTNAsF+MVajwfNQf36Q=
X-Google-Smtp-Source: AGHT+IHS0Q3oKTIXfluQ++b7ZjUVDueWkF0+ySWkBxV7It4EUFZG/E8xMb2WLucZrhhMXsTZpMSY/iPP8BAWEaWLBRoiuSVZ69H9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:154e:b0:7d0:36bb:6499 with SMTP id
 h14-20020a056602154e00b007d036bb6499mr257423iow.2.1711322062765; Sun, 24 Mar
 2024 16:14:22 -0700 (PDT)
Date: Sun, 24 Mar 2024 16:14:22 -0700
In-Reply-To: <000000000000ef958c060cc9cc3d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a5d0a30614703740@google.com>
Subject: Re: [syzbot] [net?] WARNING in call_rcu (3)
From: syzbot <syzbot+d17177af4afd8c6f804c@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, jhs@mojatatu.com, 
	jiri@resnulli.us, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	vinicius.gomes@intel.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    707081b61156 Merge branch 'for-next/core', remote-tracking..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=141d023a180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=caeac3f3565b057a
dashboard link: https://syzkaller.appspot.com/bug?extid=d17177af4afd8c6f804c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=107d3aa5180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10611291180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6cad68bf7532/disk-707081b6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1a27e5400778/vmlinux-707081b6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/67dfc53755d0/Image-707081b6.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d17177af4afd8c6f804c@syzkaller.appspotmail.com

------------[ cut here ]------------
ODEBUG: activate active (active state 1) object: 000000007c840c9e object type: rcu_head hint: 0x0
WARNING: CPU: 0 PID: 0 at lib/debugobjects.c:517 debug_print_object lib/debugobjects.c:514 [inline]
WARNING: CPU: 0 PID: 0 at lib/debugobjects.c:517 debug_object_activate+0x360/0x4ac lib/debugobjects.c:732
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.8.0-rc7-syzkaller-g707081b61156 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : debug_print_object lib/debugobjects.c:514 [inline]
pc : debug_object_activate+0x360/0x4ac lib/debugobjects.c:732
lr : debug_print_object lib/debugobjects.c:514 [inline]
lr : debug_object_activate+0x360/0x4ac lib/debugobjects.c:732
sp : ffff800080007ad0
x29: ffff800080007ad0 x28: ffff800093738000 x27: dfff800000000000
x26: ffff80008aef0200 x25: 0000000000000001 x24: ffff0000d010cd00
x23: 0000000000000003 x22: ffff80008b41a2e0 x21: 0000000000000000
x20: ffff80008aef0200 x19: ffff0000d010cd00 x18: ffff800080006fa0
x17: 3963303438633730 x16: ffff80008ad6b09c x15: 0000000000000001
x14: 1fffe00036800002 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000010004 x10: 0000000000ff0100 x9 : 42aaeb85fb1b0600
x8 : 42aaeb85fb1b0600 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff8000800073b8 x4 : ffff80008ed822c0 x3 : ffff8000805ba130
x2 : 0000000000000001 x1 : 0000000100010002 x0 : 0000000000000000
Call trace:
 debug_print_object lib/debugobjects.c:514 [inline]
 debug_object_activate+0x360/0x4ac lib/debugobjects.c:732
 debug_rcu_head_queue kernel/rcu/rcu.h:227 [inline]
 __call_rcu_common kernel/rcu/tree.c:2700 [inline]
 call_rcu+0x48/0xaf4 kernel/rcu/tree.c:2829
 switch_schedules net/sched/sch_taprio.c:210 [inline]
 advance_sched+0x7e0/0xac0 net/sched/sch_taprio.c:984
 __run_hrtimer kernel/time/hrtimer.c:1689 [inline]
 __hrtimer_run_queues+0x484/0xca0 kernel/time/hrtimer.c:1753
 hrtimer_interrupt+0x2c0/0xb64 kernel/time/hrtimer.c:1815
 timer_handler drivers/clocksource/arm_arch_timer.c:674 [inline]
 arch_timer_handler_virt+0x74/0x88 drivers/clocksource/arm_arch_timer.c:685
 handle_percpu_devid_irq+0x2a4/0x804 kernel/irq/chip.c:942
 generic_handle_irq_desc include/linux/irqdesc.h:161 [inline]
 handle_irq_desc kernel/irq/irqdesc.c:672 [inline]
 generic_handle_domain_irq+0x7c/0xc4 kernel/irq/irqdesc.c:728
 __gic_handle_irq drivers/irqchip/irq-gic-v3.c:782 [inline]
 __gic_handle_irq_from_irqson drivers/irqchip/irq-gic-v3.c:833 [inline]
 gic_handle_irq+0x6c/0x190 drivers/irqchip/irq-gic-v3.c:877
 call_on_irq_stack+0x24/0x4c arch/arm64/kernel/entry.S:889
 do_interrupt_handler+0xd4/0x138 arch/arm64/kernel/entry-common.c:310
 __el1_irq arch/arm64/kernel/entry-common.c:536 [inline]
 el1_interrupt+0x34/0x68 arch/arm64/kernel/entry-common.c:551
 el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:556
 el1h_64_irq+0x64/0x68 arch/arm64/kernel/entry.S:594
 __daif_local_irq_enable arch/arm64/include/asm/irqflags.h:27 [inline]
 arch_local_irq_enable+0x8/0xc arch/arm64/include/asm/irqflags.h:49
 cpuidle_idle_call kernel/sched/idle.c:170 [inline]
 do_idle+0x1f0/0x4e8 kernel/sched/idle.c:312
 cpu_startup_entry+0x5c/0x74 kernel/sched/idle.c:410
 rest_init+0x2dc/0x2f4 init/main.c:730
 start_kernel+0x0/0x4ec init/main.c:827
 start_kernel+0x3ec/0x4ec init/main.c:1072
 __primary_switched+0x84/0x8c arch/arm64/kernel/head.S:243
irq event stamp: 700776
hardirqs last  enabled at (700775): [<ffff80008ad6bc6c>] default_idle_call+0xf4/0x128 kernel/sched/idle.c:103
hardirqs last disabled at (700776): [<ffff80008ad66a78>] __el1_irq arch/arm64/kernel/entry-common.c:533 [inline]
hardirqs last disabled at (700776): [<ffff80008ad66a78>] el1_interrupt+0x24/0x68 arch/arm64/kernel/entry-common.c:551
softirqs last  enabled at (700464): [<ffff80008002189c>] softirq_handle_end kernel/softirq.c:399 [inline]
softirqs last  enabled at (700464): [<ffff80008002189c>] __do_softirq+0xac8/0xce4 kernel/softirq.c:582
softirqs last disabled at (700459): [<ffff80008002ab48>] ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:81
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
ODEBUG: active_state active (active state 1) object: 000000007c840c9e object type: rcu_head hint: 0x0
WARNING: CPU: 0 PID: 0 at lib/debugobjects.c:517 debug_print_object lib/debugobjects.c:514 [inline]
WARNING: CPU: 0 PID: 0 at lib/debugobjects.c:517 debug_object_active_state+0x2a8/0x37c lib/debugobjects.c:954
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W          6.8.0-rc7-syzkaller-g707081b61156 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : debug_print_object lib/debugobjects.c:514 [inline]
pc : debug_object_active_state+0x2a8/0x37c lib/debugobjects.c:954
lr : debug_print_object lib/debugobjects.c:514 [inline]
lr : debug_object_active_state+0x2a8/0x37c lib/debugobjects.c:954
sp : ffff800080007ad0
x29: ffff800080007ad0 x28: 00000000000000c0 x27: dfff800000000000
x26: 1fffe0001a95d34b x25: 0000000000000003 x24: ffff800093738000
x23: 0000000000000001 x22: ffff80008aef0200 x21: ffff0000d010cd00
x20: ffff80008b41a2e0 x19: 0000000000000000 x18: ffff800080006fa0
x17: 3863373030303030 x16: ffff80008ad6b09c x15: 0000000000000001
x14: 1fffe00036800002 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000010004 x10: 0000000000ff0100 x9 : 42aaeb85fb1b0600
x8 : 42aaeb85fb1b0600 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff8000800073b8 x4 : ffff80008ed822c0 x3 : ffff8000805ba130
x2 : 0000000000000001 x1 : 0000000100010002 x0 : 0000000000000000
Call trace:
 debug_print_object lib/debugobjects.c:514 [inline]
 debug_object_active_state+0x2a8/0x37c lib/debugobjects.c:954
 debug_rcu_head_queue kernel/rcu/rcu.h:228 [inline]
 __call_rcu_common kernel/rcu/tree.c:2700 [inline]
 call_rcu+0x60/0xaf4 kernel/rcu/tree.c:2829
 switch_schedules net/sched/sch_taprio.c:210 [inline]
 advance_sched+0x7e0/0xac0 net/sched/sch_taprio.c:984
 __run_hrtimer kernel/time/hrtimer.c:1689 [inline]
 __hrtimer_run_queues+0x484/0xca0 kernel/time/hrtimer.c:1753
 hrtimer_interrupt+0x2c0/0xb64 kernel/time/hrtimer.c:1815
 timer_handler drivers/clocksource/arm_arch_timer.c:674 [inline]
 arch_timer_handler_virt+0x74/0x88 drivers/clocksource/arm_arch_timer.c:685
 handle_percpu_devid_irq+0x2a4/0x804 kernel/irq/chip.c:942
 generic_handle_irq_desc include/linux/irqdesc.h:161 [inline]
 handle_irq_desc kernel/irq/irqdesc.c:672 [inline]
 generic_handle_domain_irq+0x7c/0xc4 kernel/irq/irqdesc.c:728
 __gic_handle_irq drivers/irqchip/irq-gic-v3.c:782 [inline]
 __gic_handle_irq_from_irqson drivers/irqchip/irq-gic-v3.c:833 [inline]
 gic_handle_irq+0x6c/0x190 drivers/irqchip/irq-gic-v3.c:877
 call_on_irq_stack+0x24/0x4c arch/arm64/kernel/entry.S:889
 do_interrupt_handler+0xd4/0x138 arch/arm64/kernel/entry-common.c:310
 __el1_irq arch/arm64/kernel/entry-common.c:536 [inline]
 el1_interrupt+0x34/0x68 arch/arm64/kernel/entry-common.c:551
 el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:556
 el1h_64_irq+0x64/0x68 arch/arm64/kernel/entry.S:594
 __daif_local_irq_enable arch/arm64/include/asm/irqflags.h:27 [inline]
 arch_local_irq_enable+0x8/0xc arch/arm64/include/asm/irqflags.h:49
 cpuidle_idle_call kernel/sched/idle.c:170 [inline]
 do_idle+0x1f0/0x4e8 kernel/sched/idle.c:312
 cpu_startup_entry+0x5c/0x74 kernel/sched/idle.c:410
 rest_init+0x2dc/0x2f4 init/main.c:730
 start_kernel+0x0/0x4ec init/main.c:827
 start_kernel+0x3ec/0x4ec init/main.c:1072
 __primary_switched+0x84/0x8c arch/arm64/kernel/head.S:243
irq event stamp: 700776
hardirqs last  enabled at (700775): [<ffff80008ad6bc6c>] default_idle_call+0xf4/0x128 kernel/sched/idle.c:103
hardirqs last disabled at (700776): [<ffff80008ad66a78>] __el1_irq arch/arm64/kernel/entry-common.c:533 [inline]
hardirqs last disabled at (700776): [<ffff80008ad66a78>] el1_interrupt+0x24/0x68 arch/arm64/kernel/entry-common.c:551
softirqs last  enabled at (700464): [<ffff80008002189c>] softirq_handle_end kernel/softirq.c:399 [inline]
softirqs last  enabled at (700464): [<ffff80008002189c>] __do_softirq+0xac8/0xce4 kernel/softirq.c:582
softirqs last disabled at (700459): [<ffff80008002ab48>] ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:81
---[ end trace 0000000000000000 ]---
rcu: __call_rcu_common(): Double-freed CB 000000007c840c9e->taprio_free_sched_cb+0x0/0x178()!!!   slab kmalloc-512 start ffff0000d010cc00 pointer offset 256 size 512


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

