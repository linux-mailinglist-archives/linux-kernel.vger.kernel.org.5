Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928907D931A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 11:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbjJ0JJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 05:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjJ0JJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 05:09:01 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95161C0;
        Fri, 27 Oct 2023 02:08:57 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3af609c4dfeso1123350b6e.1;
        Fri, 27 Oct 2023 02:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698397737; x=1699002537; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=k9JHRlaWcqX4XDWVpb3VRduRa6Nwoy/dm+aEodvSM3U=;
        b=c9nQphYOSTRHjR2Qmp4bUq5v+LMMFsQc8NhlHSIDJ5gJqUkimEWC+lpkZKkXS9HmR6
         Kh2khCLGGw14DcF7LGLIcRhj0IfJPnvY2AZp7JHQvSBJd8W38PXZBsAdHjFQTH2YyRKQ
         1QNIsaTHbW1kI7i/NP83LhjQAqYgftM8ztOOOtB1T9kBKXPde/9eFhVMWZAr0WhgcLq5
         y0peKe6dqdlsxDG6U8fX0rACiePFeR343JsPwKFI3M2jKUnroo7L/isuMz4oSrcBQRm0
         FXe57YzGs6IiSVluIaagyYz+jpbOnZHvMigQXsE4G95PAZL9y72nvSaovsz5kK8Xi9Y5
         4EqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698397737; x=1699002537;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k9JHRlaWcqX4XDWVpb3VRduRa6Nwoy/dm+aEodvSM3U=;
        b=YrmFnEgV09WZyMy9nu0Y+vGR9ulZ+RXNCirSVcVvv974DDKFlxgqckz7ksU6bO9n5t
         /YIjKszGqadO7gjfKtc7/iXa0MhdAk8e4vHl6Jkj9+l1UA4xSDD8t8a/E7d/oc1p7KcS
         DXeZpVzJASvl2pWzCGHyvE+3u9Q4KhMh/fCAKaHNsG4oAPP1IkcJzpYgmEkj2HPgn6NR
         PZbZrEGF6CnN6rseca5njbFZE8JiCyCzsgbh+eKiOw57koTLuNx7ZTTHNmS5bnAkmPYt
         KXFlsWWVyjxDWD5skyykYdAbiP3AZNRWG79hHTtRz/Ckfv18g4RikK/gSIYySLDUFhqB
         chQw==
X-Gm-Message-State: AOJu0YxXJLsAYT6nVkQiS9fBb6+mJrucd/mSOU15bxrUxxkULd7LF1Fk
        AoPNNjoizQhq4hRXQ82v/VrIZ7tODJY6z3yMag==
X-Google-Smtp-Source: AGHT+IHrS16CvH3F2HD12au66y9KbFKWN8Qmfc+OO1LKjNiSbcoXK+Ik6fcKKVYHShuq5AXYdGekADYVHuz38FcGL54=
X-Received: by 2002:aca:1c03:0:b0:3a7:1e86:e83f with SMTP id
 c3-20020aca1c03000000b003a71e86e83fmr1992888oic.51.1698397736722; Fri, 27 Oct
 2023 02:08:56 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Fri, 27 Oct 2023 11:08:45 +0200
Message-ID: <CACkBjsY22BOUCns43Rza5gXCBtEKbdRqXxOTviZQOjjDySYGHQ@mail.gmail.com>
Subject: bpf: incorrect passing infinate loop causing rcu detected stall
 during bpf_prog_run()
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following C repro contains a bpf program that can cause rcu
stall/soft lockup during running in bpf_prog_run(). Seems the verifier
incorrectly passed the program with an infinite loop.

C repro: https://pastebin.com/raw/ymzAxjeU
Verifier's log: https://pastebin.com/raw/thZDTFJc

rcu stall:

rcu: INFO: rcu_preempt self-detected stall on CPU
rcu: 7-....: (10500 ticks this GP) idle=c144/1/0x4000000000000000
softirq=6017/6017 fqs=4579
rcu:          hardirqs   softirqs   csw/system
rcu: number:        0        212            0
rcu: cputime:        0          0        52479   ==> 52480(ms)
rcu: (t=10501 jiffies g=8277 q=132 ncpus=8)
CPU: 7 PID: 8633 Comm: bpf-test Not tainted
6.6.0-rc5-01400-g7c2f6c9fb91f-dirty #25
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
RIP: 0010:___bpf_prog_run+0x4cbf/0x9720 kernel/bpf/core.c:2099
Code: 80 3c 38 00 0f 85 c0 44 00 00 41 0f b6 44 24 01 4c 8b 2b c0 e8
04 0f b6 c0 48 8d 5c c5 00 48 89 d8 48 c1 e8 03 42 80 3c 38 00 <0f> 85
8d 44 00 00 4c 3b 2b 0f 86 16 0f 00 00 49 8d 7c 24 02 48 89
RSP: 0018:ffffc90006eb7a58 EFLAGS: 00000246
RAX: 1ffff92000dd6f70 RBX: ffffc90006eb7b80 RCX: 0000000000000000
RDX: 0000000000000001 RSI: 00000000000014ff RDI: ffffc900052160d1
RBP: ffffc90006eb7b48 R08: ffffc90005216144 R09: fffffbfff228f9d0
R10: ffffffff9147ce87 R11: 0000000000088001 R12: ffffc900052160d0
R13: 000000000000001f R14: 0000000000000000 R15: dffffc0000000000
FS:  00007fcc4dc606c0(0000) GS:ffff88832db80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fcc4dcb6000 CR3: 0000000157724000 CR4: 00000000000006e0
Call Trace:
 <IRQ>
 </IRQ>
 <TASK>
 __bpf_prog_run32+0x8d/0xd0 kernel/bpf/core.c:2264
 bpf_dispatcher_nop_func include/linux/bpf.h:1192 [inline]
 __bpf_prog_run include/linux/filter.h:651 [inline]
 bpf_prog_run include/linux/filter.h:658 [inline]
 __bpf_prog_test_run_raw_tp+0xc5/0x2c0 net/bpf/test_run.c:712
 bpf_prog_test_run_raw_tp+0x304/0x560 net/bpf/test_run.c:752
 bpf_prog_put kernel/bpf/syscall.c:2165 [inline]
 bpf_prog_test_run kernel/bpf/syscall.c:4042 [inline]
 __sys_bpf+0xf98/0x4380 kernel/bpf/syscall.c:5401
 __do_sys_bpf kernel/bpf/syscall.c:5487 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5485 [inline]
 __x64_sys_bpf+0x73/0xb0 kernel/bpf/syscall.c:5485
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x564499114a87
Code: 81 f9 01 02 00 00 72 03 49 8b 12 48 89 54 24 28 89 44 24 1c 48
8d 74 24 10 b8 41 01 00 00 bf 0a 00 00 00 ba 50 00 00 00 0f 05 <48> 3d
01 f0 ff ff 0f 83 8a 00 00 00 8b 7c 24 3c 49 8b 88 18 08 00
RSP: 002b:00007fcc4dc594d0 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007fcc4dc59860 RCX: 0000564499114a87
RDX: 0000000000000050 RSI: 00007fcc4dc594e0 RDI: 000000000000000a
RBP: 00007fcc48002d00 R08: 00005644993d4e10 R09: 00005644993d5428
R10: 00005644993d5018 R11: 0000000000000246 R12: 00007fcc4dc5e458
R13: 00007fcc4dc5bb40 R14: 00007fcc4fd1cbb0 R15: 00007fcc4dc5bc28
 </TASK>
watchdog: BUG: soft lockup - CPU#7 stuck for 246s! [bpf-test:8633]
Modules linked in:
irq event stamp: 64410
hardirqs last  enabled at (64409): [<ffffffff8960140a>]
asm_sysvec_apic_timer_interrupt+0x1a/0x20
arch/x86/include/asm/idtentry.h:645
hardirqs last disabled at (64410): [<ffffffff89455f6f>]
sysvec_apic_timer_interrupt+0xf/0xc0 arch/x86/kernel/apic/apic.c:1074
softirqs last  enabled at (64378): [<ffffffff8145aa47>] invoke_softirq
kernel/softirq.c:427 [inline]
softirqs last  enabled at (64378): [<ffffffff8145aa47>] __irq_exit_rcu
kernel/softirq.c:632 [inline]
softirqs last  enabled at (64378): [<ffffffff8145aa47>]
irq_exit_rcu+0xb7/0x120 kernel/softirq.c:644
softirqs last disabled at (64373): [<ffffffff8145aa47>] invoke_softirq
kernel/softirq.c:427 [inline]
softirqs last disabled at (64373): [<ffffffff8145aa47>] __irq_exit_rcu
kernel/softirq.c:632 [inline]
softirqs last disabled at (64373): [<ffffffff8145aa47>]
irq_exit_rcu+0xb7/0x120 kernel/softirq.c:644
CPU: 7 PID: 8633 Comm: bpf-test Not tainted
6.6.0-rc5-01400-g7c2f6c9fb91f-dirty #25
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
RIP: 0010:kcov_trace_bpf_prog_regs+0x68/0xc0 kernel/kcov.c:248
Code: 83 f8 04 75 5c 4c 8b a2 e8 15 00 00 8b 92 e4 15 00 00 49 8b 04
24 48 c1 e2 03 48 8d 34 80 48 8d 4c 36 0b 48 c1 e1 03 48 39 ca <72> 35
48 83 c0 01 49 89 04 24 48 c1 e6 04 49 89 7c 0c b0 31 db 49
RSP: 0018:ffffc90006eb7a38 EFLAGS: 00000297
RAX: 0000000000000433 RBX: ffffc90006eb7b48 RCX: 0000000000015048
RDX: 0000000000015000 RSI: 00000000000014ff RDI: 000000000000001c
RBP: ffffc90006eb7b48 R08: ffffc90005216144 R09: fffffbfff228f9d0
R10: ffffffff9147ce87 R11: 0000000000088001 R12: ffffc90006c39000
R13: ffff1102f32b8600 R14: 0000000000000000 R15: dffffc0000000000
FS:  00007fcc4dc606c0(0000) GS:ffff88832db80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fcc4dcb6000 CR3: 0000000157724000 CR4: 00000000000006e0
Call Trace:
 <IRQ>
 </IRQ>
 <TASK>
 ___bpf_prog_run+0x53d9/0x9720 kernel/bpf/core.c:2100
 __bpf_prog_run32+0x8d/0xd0 kernel/bpf/core.c:2264
 bpf_dispatcher_nop_func include/linux/bpf.h:1192 [inline]
 __bpf_prog_run include/linux/filter.h:651 [inline]
 bpf_prog_run include/linux/filter.h:658 [inline]
 __bpf_prog_test_run_raw_tp+0xc5/0x2c0 net/bpf/test_run.c:712
 bpf_prog_test_run_raw_tp+0x304/0x560 net/bpf/test_run.c:752
 bpf_prog_put kernel/bpf/syscall.c:2165 [inline]
 bpf_prog_test_run kernel/bpf/syscall.c:4042 [inline]
 __sys_bpf+0xf98/0x4380 kernel/bpf/syscall.c:5401
 __do_sys_bpf kernel/bpf/syscall.c:5487 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5485 [inline]
 __x64_sys_bpf+0x73/0xb0 kernel/bpf/syscall.c:5485
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x564499114a87
Code: 81 f9 01 02 00 00 72 03 49 8b 12 48 89 54 24 28 89 44 24 1c 48
8d 74 24 10 b8 41 01 00 00 bf 0a 00 00 00 ba 50 00 00 00 0f 05 <48> 3d
01 f0 ff ff 0f 83 8a 00 00 00 8b 7c 24 3c 49 8b 88 18 08 00
RSP: 002b:00007fcc4dc594d0 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007fcc4dc59860 RCX: 0000564499114a87
RDX: 0000000000000050 RSI: 00007fcc4dc594e0 RDI: 000000000000000a
RBP: 00007fcc48002d00 R08: 00005644993d4e10 R09: 00005644993d5428
R10: 00005644993d5018 R11: 0000000000000246 R12: 00007fcc4dc5e458
R13: 00007fcc4dc5bb40 R14: 00007fcc4fd1cbb0 R15: 00007fcc4dc5bc28
 </TASK>
