Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986567FD00B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 08:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjK2HmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 02:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjK2HmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 02:42:03 -0500
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47CA19B9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 23:42:08 -0800 (PST)
Received: by mail-ua1-x931.google.com with SMTP id a1e0cc1a2514c-7c4452973f5so1821084241.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 23:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701243728; x=1701848528; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ivrYW7Ya1iiO27Tw3ErDADeEha0gNdgJYK5CCfHrvKc=;
        b=ERneeHmacxLxQuZtDvPIpNlcjVNt+9n2WuZRRCWqMMKbIJvBdq/LEI06VUHZ1be1X/
         NG9b8onI9uAzPFD7KT9NbCy5UY+rY/+/a8sh1IUoL01cqTzMIDQXmhz1am9ZwK66a81f
         TJOq2ftF1QzSdDjzCXxKFCzgTMXLH+emC53fhejtVm7gDnDZWW0aFDnKN3jDtI8Zv1HP
         umclxm6FDirFDdLP+4mywdi0d5WjX0jVjIgrJOetNKaofHmjsTVgPHW6/VplCbqM7ps/
         sEX3Ewxig2wjk519e8cE3WompX0mf/Ja+gDE12jJftso5IkUPSODKyGjL/xnFUgpwAv1
         d4yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701243728; x=1701848528;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ivrYW7Ya1iiO27Tw3ErDADeEha0gNdgJYK5CCfHrvKc=;
        b=qwBwjXPfguDwjWEre72fntosxIaB/7f7hTM5ACVad/26gP7l7JLCGi6btjEc/7NRek
         79hu3ZG+Rew23s/y0/azLps788Sik59AmjDYS2f/+VxciL2wgdT/cvTwi2WoOB6CwQrD
         m6krGdLHms0/n6KYa54iLVILMa+LRApjB4LilQfWX+hGLFxxjGwPLsJe03Obq5REZ7Az
         dA7eoh/yzC0yjlLDwiJTZJWmuLWBjJoAwLJW/S8xDKQlwmYILoB/Zpk2BakObzZzVyoe
         S/PTQ+7RMeXfseIbXbBvEsCt6s80CfYOMrHZ3Wy4bcz/lYF0LMt2nkIBkzgAzwcOLrZ/
         FAlA==
X-Gm-Message-State: AOJu0Yyzx98nsiJkmqqrMbPmy0ec0gYmfo8kCKcGHTPlyWu9O6+m4pbf
        eit6ybdtMtxJO1g2l/opAYgMkiTaHeRvlRwWPeusOg==
X-Google-Smtp-Source: AGHT+IFjj8s/Zs3pD+qnbRscYzkoK3SifhIorahNoPycHoR/hdCgLVa1++uDfLhdRWwDj+fbtpuHHiwams8E5ma08GU=
X-Received: by 2002:a05:6102:94b:b0:45e:461e:e5a3 with SMTP id
 a11-20020a056102094b00b0045e461ee5a3mr14491828vsi.1.1701243727676; Tue, 28
 Nov 2023 23:42:07 -0800 (PST)
MIME-Version: 1.0
References: <ZWaeVaNEA/0Oavv8@xpf.sh.intel.com> <ZWag32wsESemVfuN@xpf.sh.intel.com>
In-Reply-To: <ZWag32wsESemVfuN@xpf.sh.intel.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 29 Nov 2023 08:41:29 +0100
Message-ID: <CANpmjNNn4QD=SGpH3gmBC5F2cinb+kFh58X-3zT4hSRwo3GPrw@mail.gmail.com>
Subject: Re: [Syzkaller & bisect] There is task hung in perf_tp_event_init in
 v6.7-rc3 mainline kernel
To:     Pengfei Xu <pengfei.xu@intel.com>
Cc:     linux-perf-users@archiver.kernel.org, heng.su@intel.com,
        lkp@intel.com, peterz@infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2023 at 03:30, Pengfei Xu <pengfei.xu@intel.com> wrote:
>
> On 2023-11-29 at 10:13:41 +0800, Pengfei Xu wrote:
> > Hi Marco Elver and perf expert,
> >
> > Greeting!
> >
> > There is task hung in perf_tp_event_init in v6.7-rc3 mainline kernel in vm.
> > All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/231128_081400_perf_tp_event_init
> > Syzkaller reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/231128_081400_perf_tp_event_init/repro.c
> > Syzkaller repro.report: https://github.com/xupengfe/syzkaller_logs/blob/main/231128_081400_perf_tp_event_init/repro.report
> > Syzkaller syscall reproduced step: https://github.com/xupengfe/syzkaller_logs/blob/main/231128_081400_perf_tp_event_init/repro.prog

I am not surprised. This repro has 3(!) perf_event_open calls, and
this kernel has lots of instrumentation.

On our syzbot instances we have decided to selectively disable
perf_event_open for this reason, because it's too easy to slow down
the system to a crawl - manifested as lots of hung task warnings.

I can't say that the below commit made this more likely, but it's a
problem well known when allowing the fuzzer to open arbitrary perf
events. I.e. this type of "hung task" is most likely user error.

Thanks,
-- Marco

> > Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/231128_081400_perf_tp_event_init/bisect_info.log
> > Kconfig(Needs make olddefconfig): https://github.com/xupengfe/syzkaller_logs/blob/main/231128_081400_perf_tp_event_init/kconfig_origin
> > v6.7-rc3 dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/231128_081400_perf_tp_event_init/2cc14f52aeb78ce3f29677c2de1f06c0e91471ab_dmesg.log
> > v6.7-rc3 bzImage: https://github.com/xupengfe/syzkaller_logs/raw/main/231128_081400_perf_tp_event_init/bzImage_2cc14f52aeb78ce3f29677c2de1f06c0e91471ab.tar.gz
> > This issue could be reproduced in 3330s.
> >
> > Bisected the suspected commit is:
> > "
> > 97ba62b27867 perf: Add support for SIGTRAP on perf events
> > "
> >
> > [  316.705302] EXT4-fs (sda): error count since last fsck: 8
> > [  316.706021] EXT4-fs (sda): initial error at time 1699515630: ext4_mb_release_inode_pa:5364
> > [  316.706810] EXT4-fs (sda): last error at time 1699515808: mb_free_blocks:1917: block 1286144
> > [ 1537.313213] INFO: task repro:960 blocked for more than 143 seconds.
> > [ 1537.313584]       Not tainted 6.7.0-rc3-2cc14f52aeb7+ #1
> > [ 1537.313871] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > [ 1537.314256] task:repro           state:D stack:0     pid:960   tgid:960   ppid:743    flags:0x00000006
> > [ 1537.314730] Call Trace:
> > [ 1537.314878]  <TASK>
> > [ 1537.315037]  __schedule+0xb68/0x3030
> > [ 1537.315324]  ? __pfx___schedule+0x10/0x10
> > [ 1537.315546]  ? lock_release+0x417/0x7e0
> > [ 1537.315792]  ? __pfx_lock_release+0x10/0x10
> > [ 1537.316061]  ? preempt_count_add+0x9/0x180
> > [ 1537.316334]  schedule+0xf8/0x310
> > [ 1537.316544]  schedule_preempt_disabled+0x1c/0x30
> > [ 1537.316800]  __mutex_lock+0xd8a/0x1a40
> > [ 1537.317111]  ? perf_trace_init+0x5c/0x310
> > [ 1537.317344]  ? arch_ftrace_ops_list_func+0x1ad/0x550
> > [ 1537.317650]  ? __pfx___mutex_lock+0x10/0x10
> > [ 1537.317880]  ? ftrace_call+0x5/0x44
> > [ 1537.318087]  ? arch_ftrace_ops_list_func+0x1ad/0x550
> > [ 1537.318348]  ? perf_try_init_event+0x13d/0x5b0
> > [ 1537.318646]  ? __mutex_lock+0x5/0x1a40
> > [ 1537.318894]  mutex_lock_nested+0x1f/0x30
> > [ 1537.319108]  ? mutex_lock_nested+0x1f/0x30
> > [ 1537.319338]  perf_trace_init+0x5c/0x310
> > [ 1537.319583]  perf_tp_event_init+0xaf/0x130
> > [ 1537.319818]  perf_try_init_event+0x13d/0x5b0
> > [ 1537.320084]  perf_event_alloc.part.0+0xf8f/0x3b10
> > [ 1537.320401]  ? perf_event_alloc.part.0+0xe73/0x3b10
> > [ 1537.320693]  __do_sys_perf_event_open+0x51a/0x2c60
> > [ 1537.320956]  ? lock_release+0x417/0x7e0
> > [ 1537.321259]  ? __pfx___do_sys_perf_event_open+0x10/0x10
> > [ 1537.321646]  ? __audit_syscall_entry+0x39e/0x500
> > [ 1537.321907]  ? __pfx___x64_sys_perf_event_open+0x10/0x10
> > [ 1537.322181]  ? ktime_get_coarse_real_ts64+0xb5/0xf0
> > [ 1537.322479]  __x64_sys_perf_event_open+0xc7/0x150
> > [ 1537.322733]  ? __x64_sys_perf_event_open+0x9/0x150
> > [ 1537.322990]  ? do_syscall_64+0x42/0xf0
> > [ 1537.323204]  do_syscall_64+0x42/0xf0
> > [ 1537.323414]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> > [ 1537.323680] RIP: 0033:0x7efdcb23ee5d
> > [ 1537.323881] RSP: 002b:00007fffa75a2f38 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
> > [ 1537.324264] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007efdcb23ee5d
> > [ 1537.324613] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000580
> > [ 1537.324961] RBP: 00007fffa75a3140 R08: 0000000000000000 R09: 0000000000000003
> > [ 1537.325341] R10: 00000000ffffffff R11: 0000000000000246 R12: 00007fffa75a32d8
> > [ 1537.325689] R13: 000000000040672d R14: 0000000000408e08 R15: 00007efdcb460000
> > [ 1537.326136]  </TASK>
> > [ 1537.326266] INFO: task repro:961 blocked for more than 143 seconds.
> > [ 1537.326576]       Not tainted 6.7.0-rc3-2cc14f52aeb7+ #1
> > [ 1537.326842] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > [ 1537.327217] task:repro           state:D stack:0     pid:961   tgid:961   ppid:742    flags:0x00004006
> > [ 1537.327680] Call Trace:
> > [ 1537.327822]  <TASK>
> > [ 1537.327976]  __schedule+0xb68/0x3030
> > [ 1537.328231]  ? __pfx___schedule+0x10/0x10
> > [ 1537.328446]  ? lock_release+0x417/0x7e0
> > [ 1537.328685]  ? __pfx_lock_release+0x10/0x10
> > [ 1537.328949]  ? preempt_count_add+0x9/0x180
> > [ 1537.329245]  schedule+0xf8/0x310
> > [ 1537.329452]  schedule_preempt_disabled+0x1c/0x30
> > [ 1537.329702]  __mutex_lock+0xd8a/0x1a40
> > [ 1537.329932]  ? perf_trace_init+0x5c/0x310
> > [ 1537.330156]  ? arch_ftrace_ops_list_func+0x1ad/0x550
> > [ 1537.330455]  ? __pfx___mutex_lock+0x10/0x10
> > [ 1537.330684]  ? ftrace_call+0x5/0x44
> > [ 1537.330889]  ? arch_ftrace_ops_list_func+0x1ad/0x550
> > [ 1537.331150]  ? perf_try_init_event+0x13d/0x5b0
> > [ 1537.331450]  ? __mutex_lock+0x5/0x1a40
> > [ 1537.331698]  mutex_lock_nested+0x1f/0x30
> > [ 1537.331912]  ? mutex_lock_nested+0x1f/0x30
> > [ 1537.332138]  perf_trace_init+0x5c/0x310
> > [ 1537.332384]  perf_tp_event_init+0xaf/0x130
> > [ 1537.332617]  perf_try_init_event+0x13d/0x5b0
> > [ 1537.332883]  perf_event_alloc.part.0+0xf8f/0x3b10
> > [ 1537.333231]  ? perf_event_alloc.part.0+0xe73/0x3b10
> > [ 1537.333523]  __do_sys_perf_event_open+0x51a/0x2c60
> > [ 1537.333785]  ? lock_release+0x417/0x7e0
> > [ 1537.334056]  ? __pfx___do_sys_perf_event_open+0x10/0x10
> > [ 1537.334444]  ? __audit_syscall_entry+0x39e/0x500
> > [ 1537.334703]  ? __pfx___x64_sys_perf_event_open+0x10/0x10
> > [ 1537.334979]  ? ktime_get_coarse_real_ts64+0xb5/0xf0
> > [ 1537.335278]  __x64_sys_perf_event_open+0xc7/0x150
> > [ 1537.335533]  ? __x64_sys_perf_event_open+0x9/0x150
> > [ 1537.335791]  ? do_syscall_64+0x42/0xf0
> > [ 1537.336005]  do_syscall_64+0x42/0xf0
> > [ 1537.336213]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> > [ 1537.336477] RIP: 0033:0x7efdcb23ee5d
> > [ 1537.336677] RSP: 002b:00007fffa75a2f38 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
> > [ 1537.337091] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007efdcb23ee5d
> > [ 1537.337439] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000580
> > [ 1537.337788] RBP: 00007fffa75a3140 R08: 0000000000000000 R09: 0000000000000003
> > [ 1537.338136] R10: 00000000ffffffff R11: 0000000000000246 R12: 00007fffa75a32d8
> > [ 1537.338484] R13: 000000000040672d R14: 0000000000408e08 R15: 00007efdcb460000
> > [ 1537.338932]  </TASK>
> > [ 1537.339062] INFO: task repro:962 blocked for more than 143 seconds.
> > [ 1537.339377]       Not tainted 6.7.0-rc3-2cc14f52aeb7+ #1
> > [ 1537.339644] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > [ 1537.340019] task:repro           state:D stack:0     pid:962   tgid:962   ppid:734    flags:0x00000006
> > [ 1537.340481] Call Trace:
> > [ 1537.340622]  <TASK>
> > [ 1537.340777]  __schedule+0xb68/0x3030
> > [ 1537.341063]  ? __pfx___schedule+0x10/0x10
> > [ 1537.341280]  ? lock_release+0x417/0x7e0
> > [ 1537.341519]  ? __pfx_lock_release+0x10/0x10
> > [ 1537.341783]  ? preempt_count_add+0x9/0x180
> > [ 1537.342048]  schedule+0xf8/0x310
> > [ 1537.342256]  schedule_preempt_disabled+0x1c/0x30
> > [ 1537.342507]  __mutex_lock+0xd8a/0x1a40
> > [ 1537.342738]  ? perf_trace_init+0x5c/0x310
> > [ 1537.342962]  ? arch_ftrace_ops_list_func+0x1ad/0x550
> > [ 1537.343264]  ? __pfx___mutex_lock+0x10/0x10
> > [ 1537.343494]  ? ftrace_call+0x5/0x44
> > [ 1537.343699]  ? arch_ftrace_ops_list_func+0x1ad/0x550
> > [ 1537.343961]  ? perf_try_init_event+0x13d/0x5b0
> > [ 1537.344258]  ? __mutex_lock+0x5/0x1a40
> > [ 1537.344507]  mutex_lock_nested+0x1f/0x30
> > [ 1537.344722]  ? mutex_lock_nested+0x1f/0x30
> > [ 1537.344948]  perf_trace_init+0x5c/0x310
> > [ 1537.345236]  perf_tp_event_init+0xaf/0x130
> > [ 1537.345470]  perf_try_init_event+0x13d/0x5b0
> > [ 1537.345736]  perf_event_alloc.part.0+0xf8f/0x3b10
> > [ 1537.346054]  ? perf_event_alloc.part.0+0xe73/0x3b10
> > [ 1537.346346]  __do_sys_perf_event_open+0x51a/0x2c60
> > [ 1537.346609]  ? lock_release+0x417/0x7e0
> > [ 1537.346881]  ? __pfx___do_sys_perf_event_open+0x10/0x10
> > [ 1537.347280]  ? __audit_syscall_entry+0x39e/0x500
> > [ 1537.347543]  ? __pfx___x64_sys_perf_event_open+0x10/0x10
> > [ 1537.347818]  ? ktime_get_coarse_real_ts64+0xb5/0xf0
> > [ 1537.348116]  __x64_sys_perf_event_open+0xc7/0x150
> > [ 1537.348371]  ? __x64_sys_perf_event_open+0x9/0x150
> > [ 1537.348629]  ? do_syscall_64+0x42/0xf0
> > [ 1537.348843]  do_syscall_64+0x42/0xf0
> > [ 1537.349082]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> > [ 1537.349346] RIP: 0033:0x7efdcb23ee5d
> > [ 1537.349546] RSP: 002b:00007fffa75a2f38 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
> > [ 1537.349928] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007efdcb23ee5d
> > [ 1537.350277] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000580
> > [ 1537.350625] RBP: 00007fffa75a3140 R08: 0000000000000000 R09: 0000000000000003
> > [ 1537.350974] R10: 00000000ffffffff R11: 0000000000000246 R12: 00007fffa75a32d8
> > [ 1537.351325] R13: 000000000040672d R14: 0000000000408e08 R15: 00007efdcb460000
> > [ 1537.351773]  </TASK>
> > [ 1537.351903] INFO: task repro:963 blocked for more than 143 seconds.
> > [ 1537.352212]       Not tainted 6.7.0-rc3-2cc14f52aeb7+ #1
> > [ 1537.352478] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > [ 1537.352853] task:repro           state:D stack:0     pid:963   tgid:963   ppid:741    flags:0x00004006
> > [ 1537.353349] Call Trace:
> > [ 1537.353492]  <TASK>
> > [ 1537.353646]  __schedule+0xb68/0x3030
> > [ 1537.353900]  ? __pfx___schedule+0x10/0x10
> > [ 1537.354115]  ? lock_release+0x417/0x7e0
> > [ 1537.354355]  ? __pfx_lock_release+0x10/0x10
> > [ 1537.354618]  ? preempt_count_add+0x9/0x180
> > [ 1537.354884]  schedule+0xf8/0x310
> > [ 1537.355090]  schedule_preempt_disabled+0x1c/0x30
> > [ 1537.355343]  __mutex_lock+0xd8a/0x1a40
> > [ 1537.355574]  ? perf_trace_init+0x5c/0x310
> > [ 1537.355798]  ? arch_ftrace_ops_list_func+0x1ad/0x550
> > [ 1537.356096]  ? __pfx___mutex_lock+0x10/0x10
> > [ 1537.356326]  ? ftrace_call+0x5/0x44
> > [ 1537.356531]  ? arch_ftrace_ops_list_func+0x1ad/0x550
> > [ 1537.356792]  ? perf_try_init_event+0x13d/0x5b0
> > [ 1537.357116]  ? __mutex_lock+0x5/0x1a40
> > [ 1537.357365]  mutex_lock_nested+0x1f/0x30
> > [ 1537.357580]  ? mutex_lock_nested+0x1f/0x30
> > [ 1537.357805]  perf_trace_init+0x5c/0x310
> > [ 1537.358051]  perf_tp_event_init+0xaf/0x130
> > [ 1537.358285]  perf_try_init_event+0x13d/0x5b0
> > [ 1537.358551]  perf_event_alloc.part.0+0xf8f/0x3b10
> > [ 1537.358870]  ? perf_event_alloc.part.0+0xe73/0x3b10
> > [ 1537.359162]  __do_sys_perf_event_open+0x51a/0x2c60
> > [ 1537.359428]  ? lock_release+0x417/0x7e0
> > [ 1537.359700]  ? __pfx___do_sys_perf_event_open+0x10/0x10
> > [ 1537.360089]  ? __audit_syscall_entry+0x39e/0x500
> > [ 1537.360348]  ? __pfx___x64_sys_perf_event_open+0x10/0x10
> > [ 1537.360624]  ? ktime_get_coarse_real_ts64+0xb5/0xf0
> > [ 1537.360921]  __x64_sys_perf_event_open+0xc7/0x150
> > [ 1537.361207]  ? __x64_sys_perf_event_open+0x9/0x150
> > [ 1537.361466]  ? do_syscall_64+0x42/0xf0
> > [ 1537.361680]  do_syscall_64+0x42/0xf0
> > [ 1537.361888]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> > [ 1537.362152] RIP: 0033:0x7efdcb23ee5d
> > [ 1537.362352] RSP: 002b:00007fffa75a2f38 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
> > [ 1537.362734] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007efdcb23ee5d
> > [ 1537.363083] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000580
> > [ 1537.363434] RBP: 00007fffa75a3140 R08: 0000000000000000 R09: 0000000000000003
> > [ 1537.363782] R10: 00000000ffffffff R11: 0000000000000246 R12: 00007fffa75a32d8
> > [ 1537.364130] R13: 000000000040672d R14: 0000000000408e08 R15: 00007efdcb460000
> > [ 1537.364577]  </TASK>
> > [ 1537.364708]
> > [ 1537.364708] Showing all locks held in the system:
> > [ 1537.365016] 1 lock held by khungtaskd/31:
> > [ 1537.365259]  #0: ffffffff86c5b6e0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x71/0x370
> > [ 1537.365780] 1 lock held by repro/958:
> > [ 1537.365976]  #0: ffffffff86d7ff08 (event_mutex){+.+.}-{3:3}, at: perf_trace_destroy+0x2c/0x1d0
> > [ 1537.366470] 5 locks held by repro/959:
> > [ 1537.366670] 2 locks held by repro/960:
> > [ 1537.366868]  #0: ffffffff8926f830 (&pmus_srcu){.+.+}-{0:0}, at: perf_event_alloc.part.0+0xd1d/0x3b10
> > [ 1537.367383]  #1: ffffffff86d7ff08 (event_mutex){+.+.}-{3:3}, at: perf_trace_init+0x5c/0x310
> > [ 1537.367863] 2 locks held by repro/961:
> > [ 1537.368066]  #0: ffffffff8926f830 (&pmus_srcu){.+.+}-{0:0}, at: perf_event_alloc.part.0+0xd1d/0x3b10
> > [ 1537.368578]  #1: ffffffff86d7ff08 (event_mutex){+.+.}-{3:3}, at: perf_trace_init+0x5c/0x310
> > [ 1537.369091] 2 locks held by repro/962:
> > [ 1537.369290]  #0: ffffffff8926f830 (&pmus_srcu){.+.+}-{0:0}, at: perf_event_alloc.part.0+0xd1d/0x3b10
> > [ 1537.369802]  #1: ffffffff86d7ff08 (event_mutex){+.+.}-{3:3}, at: perf_trace_init+0x5c/0x310
> > [ 1537.370283] 2 locks held by repro/963:
> > [ 1537.370481]  #0: ffffffff8926f830 (&pmus_srcu){.+.+}-{0:0}, at: perf_event_alloc.part.0+0xd1d/0x3b10
> > [ 1537.370993]  #1: ffffffff86d7ff08 (event_mutex){+.+.}-{3:3}, at: perf_trace_init+0x5c/0x310
> > [ 1537.371478] 2 locks held by repro/964:
> > [ 1537.371677]  #0: ffffffff8926f830 (&pmus_srcu){.+.+}-{0:0}, at: perf_event_alloc.part.0+0xd1d/0x3b10
> > [ 1537.372188]  #1: ffffffff86d7ff08 (event_mutex){+.+.}-{3:3}, at: perf_trace_init+0x5c/0x310
> > [ 1537.372669] 2 locks held by repro/965:
> > [ 1537.372867]  #0: ffffffff8926f830 (&pmus_srcu){.+.+}-{0:0}, at: perf_event_alloc.part.0+0xd1d/0x3b10
> > [ 1537.373424]  #1: ffffffff86d7ff08 (event_mutex){+.+.}-{3:3}, at: perf_trace_init+0x5c/0x310
> > [ 1537.373904]
> > [ 1537.374003] =============================================
> >
> > ---
> >
> > If you don't need the following environment to reproduce the problem or if you
> > already have one reproduced environment, please ignore the following information.
> >
> > How to reproduce:
> > git clone https://gitlab.com/xupengfe/repro_vm_env.git
> > cd repro_vm_env
> > tar -xvf repro_vm_env.tar.gz
> > cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
> >   // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
> >   // You could change the bzImage_xxx as you want
> >   // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
> > You could use below command to log in, there is no password for root.
> > ssh -p 10023 root@localhost
> >
> > After login vm(virtual machine) successfully, you could transfer reproduced
> > binary to the vm by below way, and reproduce the problem in vm:
> > gcc -pthread -o repro repro.c
> > scp -P 10023 repro root@localhost:/root/
> >
> > Get the bzImage for target kernel:
> > Please use target kconfig and copy it to kernel_src/.config
> > make olddefconfig
> > make -jx bzImage           //x should equal or less than cpu num your pc has
> >
> > Fill the bzImage file into above start3.sh to load the target kernel in vm.
> >
> >
> > Tips:
> > If you already have qemu-system-x86_64, please ignore below info.
> > If you want to install qemu v7.1.0 version:
> > git clone https://github.com/qemu/qemu.git
> > cd qemu
> > git checkout -f v7.1.0
> > mkdir build
> > cd build
> > yum install -y ninja-build.x86_64
> > yum -y install libslirp-devel.x86_64
> > ../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
> > make
> > make install
> >
> > Best Regards,
> > Thanks!
