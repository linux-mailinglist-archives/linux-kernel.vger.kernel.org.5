Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7CE07F048B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 07:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjKSGMP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 19 Nov 2023 01:12:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKSGMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 01:12:14 -0500
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC2F99
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 22:12:06 -0800 (PST)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1cc1397321fso42145875ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 22:12:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700374325; x=1700979125;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pIVmDP3jUmnDDMtWdbxPhV8HF35HuCeiZpyl+8s9dpg=;
        b=elxNGm0rxSlKZRV30r7g2bgRt38a4PYn1gfvU6niGPavC2ybNHRzxC319+5Fy3Zscu
         iZ/76EpQH2JnnrdHxi3Qpx6f8+ABm1UsYzuqImhvc8nxWrtO/XiU9MYrP3LzcjZQX6/5
         +CGEOT60OQGLYiGgs/ozctTLI6wbTHZd9Yfl9NFuXkP/FyL7NgSIhs70xnlTs54PzKFu
         c6rWMSKrP+s9sehcbl8fV24A5cUuC8btawpathXYymQINEQ7ReyJJbr+b5a4EtZfXIAw
         VsOi9RiyIHDA+xxxFepvhXPrUybtk0qAV6/OuIzrs6+7fJUT8GVw5JD5WPRzVgvIkDCR
         30MQ==
X-Gm-Message-State: AOJu0YxzPkhWfFA1UAhByq2jzimGBhq+lWvxENvHLbi+WDYMPKXTBerO
        qshqbpxgETZOrSaYvVzqcXM2RwnXUsspZVuUT/oYLeynZ9sf
X-Google-Smtp-Source: AGHT+IEebYZmQ0VYRFZQ+gEVZtcb3DULHA/ULQFnaDNANd/EOmYVNkMjT8SOIc/tFoGP8re5lEj0nnOpkkzsqjuYPRNhasFQtGAF
MIME-Version: 1.0
X-Received: by 2002:a17:902:74c3:b0:1cf:579f:7557 with SMTP id
 f3-20020a17090274c300b001cf579f7557mr509984plt.4.1700374325719; Sat, 18 Nov
 2023 22:12:05 -0800 (PST)
Date:   Sat, 18 Nov 2023 22:12:05 -0800
In-Reply-To: <20231119051509.330056-1-eadavis@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ab7a51060a7b3fd1@google.com>
Subject: Re: [syzbot] [netfilter?] WARNING in __nf_unregister_net_hook (6)
From:   syzbot <syzbot+de4025c006ec68ac56fc@syzkaller.appspotmail.com>
To:     eadavis@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

36819][    T1] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    4.642425][    T1] NET: Registered PF_INET protocol family
[    4.653180][    T1] IP idents hash table entries: 131072 (order: 8, 1048576 bytes, vmalloc)
[    4.673990][    T1] tcp_listen_portaddr_hash hash table entries: 4096 (order: 6, 294912 bytes, vmalloc)
[    4.679141][    T1] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, vmalloc)
[    4.686154][    T1] TCP established hash table entries: 65536 (order: 7, 524288 bytes, vmalloc)
[    4.702134][    T1] TCP bind hash table entries: 65536 (order: 11, 9437184 bytes, vmalloc hugepage)
[    4.715835][    T1] TCP: Hash tables configured (established 65536 bind 65536)
[    4.725918][    T1] MPTCP token hash table entries: 8192 (order: 7, 720896 bytes, vmalloc)
[    4.735121][    T1] UDP hash table entries: 4096 (order: 7, 655360 bytes, vmalloc)
[    4.742928][    T1] UDP-Lite hash table entries: 4096 (order: 7, 655360 bytes, vmalloc)
[    4.748791][    T1] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    4.755767][    T1] RPC: Registered named UNIX socket transport module.
[    4.757922][    T1] RPC: Registered udp transport module.
[    4.759137][    T1] RPC: Registered tcp transport module.
[    4.760533][    T1] RPC: Registered tcp-with-tls transport module.
[    4.762569][    T1] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    4.770304][    T1] NET: Registered PF_XDP protocol family
[    4.771660][    T1] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    4.772804][    T1] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    4.774225][    T1] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    4.775706][    T1] pci_bus 0000:00: resource 7 [mem 0xc0000000-0xfebfefff window]
[    4.779891][    T1] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    4.781720][    T1] PCI: CLS 0 bytes, default 64
[    4.783062][    T1] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    4.785627][    T1] software IO TLB: mapped [mem 0x00000000b5800000-0x00000000b9800000] (64MB)
[    4.787580][    T1] ACPI: bus type thunderbolt registered
[    4.801824][   T59] kworker/u4:3 (59) used greatest stack depth: 28288 bytes left
[    4.803556][   T57] kworker/u4:3 (57) used greatest stack depth: 27936 bytes left
[    4.807247][    T1] RAPL PMU: API unit is 2^-32 Joules, 0 fixed counters, 10737418240 ms ovfl timer
[    4.836525][    T1] kvm_amd: CPU 0 isn't AMD or Hygon
[    4.838378][    T1] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x1fb6feccdd0, max_idle_ns: 440795259471 ns
[    4.840308][    T1] clocksource: Switched to clocksource tsc
[    4.841701][   T60] kworker/u4:4 (60) used greatest stack depth: 27488 bytes left
[    7.942031][    T1] Initialise system trusted keyrings
[    7.950098][    T1] workingset: timestamp_bits=40 max_order=21 bucket_order=0
[    7.953009][    T1] zbud: loaded
[    7.964477][    T1] DLM installed
[    7.971427][    T1] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    7.981282][    T1] NFS: Registering the id_resolver key type
[    7.982457][    T1] Key type id_resolver registered
[    7.983292][    T1] Key type id_legacy registered
[    7.984197][    T1] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    7.985996][    T1] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Registering...
[    7.999168][    T1] Key type cifs.spnego registered
[    8.001028][    T1] Key type cifs.idmap registered
[    8.002981][    T1] ntfs: driver 2.1.32 [Flags: R/W].
[    8.004816][    T1] ntfs3: Max link count 4000
[    8.005624][    T1] ntfs3: Enabled Linux POSIX ACLs support
[    8.006545][    T1] ntfs3: Read-only LZX/Xpress compression included
[    8.008379][    T1] efs: 1.0a - http://aeschi.ch.eu.org/efs/
[    8.009817][    T1] jffs2: version 2.2. (NAND) (SUMMARY)  © 2001-2006 Red Hat, Inc.
[    8.014805][    T1] romfs: ROMFS MTD (C) 2007 Red Hat, Inc.
[    8.016201][    T1] QNX4 filesystem 0.2.3 registered.
[    8.017663][    T1] qnx6: QNX6 filesystem 1.0.0 registered.
[    8.019893][    T1] fuse: init (API version 7.39)
[    8.024969][    T1] orangefs_debugfs_init: called with debug mask: :none: :0:
[    8.028357][    T1] orangefs_init: module version upstream loaded
[    8.030312][    T1] JFS: nTxBlock = 8192, nTxLock = 65536
[    8.063381][    T1] SGI XFS with ACLs, security attributes, realtime, quota, no debug enabled
[    8.072453][    T1] 9p: Installing v9fs 9p2000 file system support
[    8.074784][    T1] NILFS version 2 loaded
[    8.075542][    T1] befs: version: 0.9.3
[    8.077453][    T1] ocfs2: Registered cluster interface o2cb
[    8.079215][    T1] ocfs2: Registered cluster interface user
[    8.081170][    T1] OCFS2 User DLM kernel interface loaded
[    8.103497][    T1] gfs2: GFS2 installed
[    8.118728][    T1] ceph: loaded (mds proto 32)
[    8.122243][    T1] 
[    8.122768][    T1] ============================================
[    8.123835][    T1] WARNING: possible recursive locking detected
[    8.124729][    T1] 6.6.0-rc3-syzkaller-dirty #0 Not tainted
[    8.125560][    T1] --------------------------------------------
[    8.126518][    T1] swapper/0/1 is trying to acquire lock:
[    8.126735][    T1] ffffffff8e69c268 (nf_hook_mutex){+.+.}-{3:3}, at: nf_hook_entries_grow+0x580/0x8b0
[    8.126735][    T1] 
[    8.126735][    T1] but task is already holding lock:
[    8.126735][    T1] ffffffff8e69c268 (nf_hook_mutex){+.+.}-{3:3}, at: __nf_register_net_hook+0xef/0x830
[    8.126735][    T1] 
[    8.126735][    T1] other info that might help us debug this:
[    8.126735][    T1]  Possible unsafe locking scenario:
[    8.126735][    T1] 
[    8.126735][    T1]        CPU0
[    8.126735][    T1]        ----
[    8.126735][    T1]   lock(nf_hook_mutex);
[    8.126735][    T1]   lock(nf_hook_mutex);
[    8.126735][    T1] 
[    8.126735][    T1]  *** DEADLOCK ***
[    8.126735][    T1] 
[    8.126735][    T1]  May be due to missing lock nesting notation
[    8.126735][    T1] 
[    8.126735][    T1] 2 locks held by swapper/0/1:
[    8.126735][    T1]  #0: ffffffff8e5e4190 (pernet_ops_rwsem){+.+.}-{3:3}, at: register_pernet_subsys+0x19/0x40
[    8.126735][    T1]  #1: ffffffff8e69c268 (nf_hook_mutex){+.+.}-{3:3}, at: __nf_register_net_hook+0xef/0x830
[    8.126735][    T1] 
[    8.126735][    T1] stack backtrace:
[    8.126735][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.6.0-rc3-syzkaller-dirty #0
[    8.126735][    T1] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
[    8.126735][    T1] Call Trace:
[    8.126735][    T1]  <TASK>
[    8.126735][    T1]  dump_stack_lvl+0xd9/0x1b0
[    8.126735][    T1]  __lock_acquire+0x2971/0x5de0
[    8.126735][    T1]  ? lockdep_hardirqs_on_prepare+0x410/0x410
[    8.126735][    T1]  lock_acquire+0x1ae/0x510
[    8.126735][    T1]  ? nf_hook_entries_grow+0x580/0x8b0
[    8.126735][    T1]  ? lock_sync+0x190/0x190
[    8.126735][    T1]  ? lock_acquire+0x1ae/0x510
[    8.126735][    T1]  ? preempt_count_sub+0x150/0x150
[    8.126735][    T1]  __mutex_lock+0x181/0x1340
[    8.126735][    T1]  ? nf_hook_entries_grow+0x580/0x8b0
[    8.126735][    T1]  ? nf_hook_entries_grow+0x580/0x8b0
[    8.126735][    T1]  ? preempt_count_sub+0x150/0x150
[    8.126735][    T1]  ? mutex_lock_io_nested+0x11a0/0x11a0
[    8.126735][    T1]  ? trace_contention_end+0xd6/0x100
[    8.126735][    T1]  ? __mutex_lock+0x25b/0x1340
[    8.126735][    T1]  ? __lock_acquire+0x182f/0x5de0
[    8.126735][    T1]  ? mutex_lock_io_nested+0x11a0/0x11a0
[    8.126735][    T1]  ? nf_hook_entries_grow+0x580/0x8b0
[    8.126735][    T1]  nf_hook_entries_grow+0x580/0x8b0
[    8.126735][    T1]  ? lockdep_hardirqs_on_prepare+0x410/0x410
[    8.166836][    T1]  __nf_register_net_hook+0x142/0x830
[    8.166836][    T1]  nf_register_net_hook+0x101/0x150
[    8.166836][    T1]  nf_register_net_hooks+0x5d/0xc0
[    8.166836][    T1]  ? selinux_nf_unregister+0x30/0x30
[    8.166836][    T1]  ops_init+0xb9/0x650
[    8.166836][    T1]  register_pernet_operations+0x34b/0x820
[    8.166836][    T1]  ? cleanup_net+0xb20/0xb20
[    8.166836][    T1]  ? rng_is_initialized+0x40/0x40
[    8.166836][    T1]  ? selinux_init+0x320/0x320
[    8.166836][    T1]  register_pernet_subsys+0x28/0x40
[    8.166836][    T1]  selinux_nf_ip_init+0x35/0x80
[    8.166836][    T1]  do_one_initcall+0x117/0x630
[    8.166836][    T1]  ? trace_event_raw_event_initcall_level+0x200/0x200
[    8.166836][    T1]  kernel_init_freeable+0x5c2/0x900
[    8.166836][    T1]  ? rest_init+0x2b0/0x2b0
[    8.166836][    T1]  kernel_init+0x1c/0x2a0
[    8.166836][    T1]  ? rest_init+0x2b0/0x2b0
[    8.166836][    T1]  ret_from_fork+0x45/0x80
[    8.166836][    T1]  ? rest_init+0x2b0/0x2b0
[    8.166836][    T1]  ret_from_fork_asm+0x11/0x20
[    8.166836][    T1]  </TASK>
[  286.966884][   T28] INFO: task swapper/0:1 blocked for more than 143 seconds.
[  286.969104][   T28]       Not tainted 6.6.0-rc3-syzkaller-dirty #0
[  286.971304][   T28] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  286.973620][   T28] task:swapper/0       state:D stack:23024 pid:1     ppid:0      flags:0x00004000
[  286.976023][   T28] Call Trace:
[  286.976678][   T28]  <TASK>
[  286.977696][   T28]  __schedule+0xee1/0x5a10
[  286.978895][   T28]  ? rcu_is_watching+0x12/0xb0
[  286.980008][   T28]  ? trace_irq_enable.constprop.0+0xd0/0x100
[  286.981277][   T28]  ? irqentry_enter+0x2c/0x50
[  286.982136][   T28]  ? rcu_is_watching+0x12/0xb0
[  286.982834][   T28]  ? io_schedule_timeout+0x150/0x150
[  286.983837][   T28]  ? rcu_is_watching+0x12/0xb0
[  286.984537][   T28]  ? __mutex_lock+0x964/0x1340
[  286.985252][   T28]  ? do_raw_spin_lock+0x12e/0x2b0
[  286.985953][   T28]  ? spin_bug+0x1d0/0x1d0
[  286.986683][   T28]  schedule+0xe7/0x1b0
[  286.987309][   T28]  schedule_preempt_disabled+0x13/0x20
[  286.992893][   T28]  __mutex_lock+0x969/0x1340
[  286.997691][   T28]  ? nf_hook_entries_grow+0x580/0x8b0
[  287.003162][   T28]  ? preempt_count_sub+0x150/0x150
[  287.008617][   T28]  ? mutex_lock_io_nested+0x11a0/0x11a0
[  287.014340][   T28]  ? trace_contention_end+0xd6/0x100
[  287.019881][   T28]  ? __mutex_lock+0x25b/0x1340
[  287.024740][   T28]  ? __lock_acquire+0x182f/0x5de0
[  287.029819][   T28]  ? mutex_lock_io_nested+0x11a0/0x11a0
[  287.035385][   T28]  ? nf_hook_entries_grow+0x580/0x8b0
[  287.041001][   T28]  nf_hook_entries_grow+0x580/0x8b0
[  287.046464][   T28]  ? lockdep_hardirqs_on_prepare+0x410/0x410
[  287.052618][   T28]  __nf_register_net_hook+0x142/0x830
[  287.058143][   T28]  nf_register_net_hook+0x101/0x150
[  287.063352][   T28]  nf_register_net_hooks+0x5d/0xc0
[  287.068504][   T28]  ? selinux_nf_unregister+0x30/0x30
[  287.073863][   T28]  ops_init+0xb9/0x650
[  287.078000][   T28]  register_pernet_operations+0x34b/0x820
[  287.083725][   T28]  ? cleanup_net+0xb20/0xb20
[  287.088364][   T28]  ? rng_is_initialized+0x40/0x40
[  287.093503][   T28]  ? selinux_init+0x320/0x320
[  287.098308][   T28]  register_pernet_subsys+0x28/0x40
[  287.103675][   T28]  selinux_nf_ip_init+0x35/0x80
[  287.108677][   T28]  do_one_initcall+0x117/0x630
[  287.113475][   T28]  ? trace_event_raw_event_initcall_level+0x200/0x200
[  287.120835][   T28]  kernel_init_freeable+0x5c2/0x900
[  287.126412][   T28]  ? rest_init+0x2b0/0x2b0
[  287.130885][   T28]  kernel_init+0x1c/0x2a0
[  287.135437][   T28]  ? rest_init+0x2b0/0x2b0
[  287.139959][   T28]  ret_from_fork+0x45/0x80
[  287.144525][   T28]  ? rest_init+0x2b0/0x2b0
[  287.149056][   T28]  ret_from_fork_asm+0x11/0x20
[  287.153819][   T28]  </TASK>
[  287.157157][   T28] INFO: lockdep is turned off.
[  287.161893][   T28] Kernel panic - not syncing: hung_task: blocked tasks
[  287.167099][   T28] CPU: 0 PID: 28 Comm: khungtaskd Not tainted 6.6.0-rc3-syzkaller-dirty #0
[  287.167099][   T28] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
[  287.167099][   T28] Call Trace:
[  287.167099][   T28]  <TASK>
[  287.167099][   T28]  dump_stack_lvl+0xd9/0x1b0
[  287.167099][   T28]  panic+0x6a6/0x750
[  287.167099][   T28]  ? panic_smp_self_stop+0xa0/0xa0
[  287.167099][   T28]  ? preempt_count_sub+0x150/0x150
[  287.167099][   T28]  ? watchdog+0xd3e/0x1210
[  287.167099][   T28]  watchdog+0xd4f/0x1210
[  287.167099][   T28]  ? proc_dohung_task_timeout_secs+0x90/0x90
[  287.167099][   T28]  ? lockdep_hardirqs_on+0x7d/0x100
[  287.167099][   T28]  ? __kthread_parkme+0x14b/0x220
[  287.167099][   T28]  ? proc_dohung_task_timeout_secs+0x90/0x90
[  287.167099][   T28]  kthread+0x33c/0x440
[  287.167099][   T28]  ? _raw_spin_unlock_irq+0x23/0x50
[  287.167099][   T28]  ? kthread_complete_and_exit+0x40/0x40
[  287.167099][   T28]  ret_from_fork+0x45/0x80
[  287.167099][   T28]  ? kthread_complete_and_exit+0x40/0x40
[  287.167099][   T28]  ret_from_fork_asm+0x11/0x20
[  287.167099][   T28]  </TASK>
[  287.167099][   T28] Kernel Offset: disabled
[  287.167099][   T28] Rebooting in 86400 seconds..


syzkaller build log:
go env (err=<nil>)
GO111MODULE="auto"
GOARCH="amd64"
GOBIN=""
GOCACHE="/syzkaller/.cache/go-build"
GOENV="/syzkaller/.config/go/env"
GOEXE=""
GOEXPERIMENT=""
GOFLAGS=""
GOHOSTARCH="amd64"
GOHOSTOS="linux"
GOINSECURE=""
GOMODCACHE="/syzkaller/jobs-2/linux/gopath/pkg/mod"
GONOPROXY=""
GONOSUMDB=""
GOOS="linux"
GOPATH="/syzkaller/jobs-2/linux/gopath"
GOPRIVATE=""
GOPROXY="https://proxy.golang.org,direct"
GOROOT="/usr/local/go"
GOSUMDB="sum.golang.org"
GOTMPDIR=""
GOTOOLDIR="/usr/local/go/pkg/tool/linux_amd64"
GOVCS=""
GOVERSION="go1.20.1"
GCCGO="gccgo"
GOAMD64="v1"
AR="ar"
CC="gcc"
CXX="g++"
CGO_ENABLED="1"
GOMOD="/syzkaller/jobs-2/linux/gopath/src/github.com/google/syzkaller/go.mod"
GOWORK=""
CGO_CFLAGS="-O2 -g"
CGO_CPPFLAGS=""
CGO_CXXFLAGS="-O2 -g"
CGO_FFLAGS="-O2 -g"
CGO_LDFLAGS="-O2 -g"
PKG_CONFIG="pkg-config"
GOGCCFLAGS="-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=0 -fdebug-prefix-map=/tmp/go-build1107752955=/tmp/go-build -gno-record-gcc-switches"

git status (err=<nil>)
HEAD detached at 0b6a67ac4
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:32: run command via tools/syz-env for best compatibility, see:
Makefile:33: https://github.com/google/syzkaller/blob/master/docs/contributing.md#using-syz-env
go list -f '{{.Stale}}' ./sys/syz-sysgen | grep -q false || go install ./sys/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
bin/syz-sysgen
touch .descriptions
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=0b6a67ac4b0dc26f43030c5edd01c9175f13b784 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20230913-073137'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer github.com/google/syzkaller/syz-fuzzer
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=0b6a67ac4b0dc26f43030c5edd01c9175f13b784 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20230913-073137'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=0b6a67ac4b0dc26f43030c5edd01c9175f13b784 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20230913-073137'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wframe-larger-than=16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-format-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -static-pie -fpermissive -w -DGOOS_linux=1 -DGOARCH_amd64=1 \
	-DHOSTGOOS_linux=1 -DGIT_REVISION=\"0b6a67ac4b0dc26f43030c5edd01c9175f13b784\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=15d5cd10e80000


Tested on:

commit:         6465e260 Linux 6.6-rc3
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d7d7928f78936aa
dashboard link: https://syzkaller.appspot.com/bug?extid=de4025c006ec68ac56fc
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10b3d658e80000

