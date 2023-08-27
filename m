Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDB2789D18
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 13:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjH0LEz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 27 Aug 2023 07:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjH0LEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 07:04:31 -0400
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D8F109
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 04:04:28 -0700 (PDT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-26d68b5995dso1804826a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 04:04:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693134268; x=1693739068;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZqEkylhSkhO/CbNiyMMkQIiKwzgzv0eF6jKsXlEVQFY=;
        b=W3MAv6El9bzt+807a5cUI10aSV0+r8PyXVdgLGdb48PX6lG+4uBdznwjvNt6WTceJS
         iQJ4wJKRUoY8xPmqBX/mLAeUGFfhI2AzL9/EC3BhvK9ijvoVdcP+Mpk0wv2mHDplDZBP
         l58sbD2+Q0hHZg9x+FtNA1u9QiFoJOKv1s8GaNYNq6ffqWwYT+WKmBz4JesXFJTudB2d
         059d3XbXMHfjzK4sXZyEKhWmPg8RdWyMVMxz8YADLvh3UZdwEc2Dx8UieKWBIZUQjBi/
         FkQ4cr3Yc6ytmMqGuQL5DTF/vxdWnBpJm6h4op69+//G3LifugwU7XmzDoHdgYWQAaBq
         o97Q==
X-Gm-Message-State: AOJu0YxbsX/sR9J3yUNCv/1+WAURVBg8Ft6PCvbiPH9QpajjmUNpdKMc
        cMczOceHk9MTHAQLSEI0bSUFqvHOwCFU3Z9mE3ReXhstmYy0
X-Google-Smtp-Source: AGHT+IEqwsaR9okbZa1Go2a8z5SqbXWp2Ap4DutC/24/YiS1aOvl83cbO9nqtS91cHVJfpRsD6pPeCJjaJ/20pdzbLGMfQewW//W
MIME-Version: 1.0
X-Received: by 2002:a17:902:d4d2:b0:1c0:a417:b0d4 with SMTP id
 o18-20020a170902d4d200b001c0a417b0d4mr3965768plg.8.1693134267971; Sun, 27 Aug
 2023 04:04:27 -0700 (PDT)
Date:   Sun, 27 Aug 2023 04:04:27 -0700
In-Reply-To: <20230827100849.3681-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000997dff0603e58a02@google.com>
Subject: Re: [syzbot] [kernfs?] KASAN: slab-use-after-free Read in kernfs_test_super
From:   syzbot <syzbot+f25c61df1ec3d235d52f@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

    T1] RPL Segment Routing with IPv6
[   22.153462][    T1] In-situ OAM (IOAM) with IPv6
[   22.158633][    T1] mip6: Mobile IPv6
[   22.167745][    T1] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[   22.185212][    T1] ip6_gre: GRE over IPv6 tunneling driver
[   22.197237][    T1] NET: Registered PF_PACKET protocol family
[   22.203406][    T1] NET: Registered PF_KEY protocol family
[   22.209481][    T1] Bridge firewalling registered
[   22.214972][    T1] NET: Registered PF_X25 protocol family
[   22.220716][    T1] X25: Linux Version 0.2
[   22.301783][    T1] NET: Registered PF_NETROM protocol family
[   22.389320][    T1] NET: Registered PF_ROSE protocol family
[   22.395297][    T1] NET: Registered PF_AX25 protocol family
[   22.401145][    T1] can: controller area network core
[   22.407441][    T1] NET: Registered PF_CAN protocol family
[   22.413109][    T1] can: raw protocol
[   22.417186][    T1] can: broadcast manager protocol
[   22.422248][    T1] can: netlink gateway - max_hops=1
[   22.427654][    T1] can: SAE J1939
[   22.431196][    T1] can: isotp protocol (max_pdu_size 8300)
[   22.437369][    T1] Bluetooth: RFCOMM TTY layer initialized
[   22.443097][    T1] Bluetooth: RFCOMM socket layer initialized
[   22.449713][    T1] Bluetooth: RFCOMM ver 1.11
[   22.454468][    T1] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   22.460598][    T1] Bluetooth: BNEP filters: protocol multicast
[   22.467157][    T1] Bluetooth: BNEP socket layer initialized
[   22.472946][    T1] Bluetooth: CMTP (CAPI Emulation) ver 1.0
[   22.478826][    T1] Bluetooth: CMTP socket layer initialized
[   22.484665][    T1] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[   22.491508][    T1] Bluetooth: HIDP socket layer initialized
[   22.502104][    T1] NET: Registered PF_RXRPC protocol family
[   22.508020][    T1] Key type rxrpc registered
[   22.512934][    T1] Key type rxrpc_s registered
[   22.519379][    T1] NET: Registered PF_KCM protocol family
[   22.526198][    T1] lec:lane_module_init: lec.c: initialized
[   22.532235][    T1] mpoa:atm_mpoa_init: mpc.c: initialized
[   22.538764][    T1] l2tp_core: L2TP core driver, V2.0
[   22.544063][    T1] l2tp_ppp: PPPoL2TP kernel driver, V2.0
[   22.549753][    T1] l2tp_ip: L2TP IP encapsulation support (L2TPv3)
[   22.556606][    T1] l2tp_netlink: L2TP netlink interface
[   22.562260][    T1] l2tp_eth: L2TP ethernet pseudowire support (L2TPv3)
[   22.569431][    T1] l2tp_ip6: L2TP IP encapsulation support for IPv6 (L2TPv3)
[   22.577749][    T1] NET: Registered PF_PHONET protocol family
[   22.584800][    T1] 8021q: 802.1Q VLAN Support v1.8
[   22.608369][    T1] DCCP: Activated CCID 2 (TCP-like)
[   22.614078][    T1] DCCP: Activated CCID 3 (TCP-Friendly Rate Control)
[   22.621209][    T1] DCCP is deprecated and scheduled to be removed in 2025, please contact the netdev mailing list
[   22.632363][    T1] sctp: Hash tables configured (bind 32/56)
[   22.641253][    T1] NET: Registered PF_RDS protocol family
[   22.647757][    T1] Registered RDS/infiniband transport
[   22.653720][    T1] Registered RDS/tcp transport
[   22.658688][    T1] tipc: Activated (version 2.0.0)
[   22.664367][    T1] NET: Registered PF_TIPC protocol family
[   22.670831][    T1] tipc: Started in single node mode
[   22.676860][    T1] NET: Registered PF_SMC protocol family
[   22.682686][    T1] 9pnet: Installing 9P2000 support
[   22.688768][    T1] NET: Registered PF_CAIF protocol family
[   22.702700][    T1] NET: Registered PF_IEEE802154 protocol family
[   22.710080][    T1] Key type dns_resolver registered
[   22.715485][    T1] Key type ceph registered
[   22.720499][    T1] libceph: loaded (mon/osd proto 15/24)
[   22.728520][    T1] batman_adv: B.A.T.M.A.N. advanced 2023.3 (compatibility version 15) loaded
[   22.737761][    T1] openvswitch: Open vSwitch switching datapath
[   22.747749][    T1] NET: Registered PF_VSOCK protocol family
[   22.753909][    T1] mpls_gso: MPLS GSO support
[   22.767156][    T1] start plist test
[   22.776649][    T1] end plist test
[   22.789647][    T1] IPI shorthand broadcast: enabled
[   22.795205][    T1] AVX2 version of gcm_enc/dec engaged.
[   22.800844][    T1] AES CTR mode by8 optimization enabled
[   24.946860][    T1] sched_clock: Marking stable (24900021811, 44080130)->(24947471898, -3369957)
[   24.963256][    T1] registered taskstats version 1
[   24.991977][    T1] Loading compiled-in X.509 certificates
[   25.002988][    T1] Loaded X.509 cert 'Build time autogenerated kernel key: 6ff01a4b96c932563103f4d4fff2d5d5224413d4'
[   25.018103][    T1] zswap: loaded using pool lzo/zbud
[   25.254541][    T1] debug_vm_pgtable: [debug_vm_pgtable         ]: Validating architecture page table helpers
[   28.206068][    T1] Key type .fscrypt registered
[   28.210844][    T1] Key type fscrypt-provisioning registered
[   28.225620][    T1] kAFS: Red Hat AFS client v0.1 registering.
[   28.251109][    T1] Btrfs loaded, assert=on, ref-verify=on, zoned=yes, fsverity=yes
[   28.259400][    T1] Key type big_key registered
[   28.266816][    T1] Key type encrypted registered
[   28.271690][    T1] AppArmor: AppArmor sha1 policy hashing enabled
[   28.278086][    T1] ima: No TPM chip found, activating TPM-bypass!
[   28.284455][    T1] Loading compiled-in module X.509 certificates
[   28.295355][    T1] Loaded X.509 cert 'Build time autogenerated kernel key: 6ff01a4b96c932563103f4d4fff2d5d5224413d4'
[   28.306295][    T1] ima: Allocated hash algorithm: sha256
[   28.311992][    T1] ima: No architecture policies found
[   28.317903][    T1] evm: Initialising EVM extended attributes:
[   28.323988][    T1] evm: security.selinux (disabled)
[   28.329111][    T1] evm: security.SMACK64 (disabled)
[   28.334298][    T1] evm: security.SMACK64EXEC (disabled)
[   28.340638][    T1] evm: security.SMACK64TRANSMUTE (disabled)
[   28.346557][    T1] evm: security.SMACK64MMAP (disabled)
[   28.352203][    T1] evm: security.apparmor
[   28.356464][    T1] evm: security.ima
[   28.360293][    T1] evm: security.capability
[   28.364715][    T1] evm: HMAC attrs: 0x1
[   28.371158][    T1] PM:   Magic number: 3:991:932
[   28.379710][    T1] printk: console [netcon0] enabled
[   28.384982][    T1] netconsole: network logging started
[   28.390833][    T1] gtp: GTP module loaded (pdp ctx size 104 bytes)
[   28.398542][    T1] rdma_rxe: loaded
[   28.403224][    T1] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[   28.415177][    T1] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   28.423103][   T54] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[   28.432796][   T54] platform regulatory.0: Falling back to sysfs fallback for: regulatory.db
[   28.442788][    T1] clk: Disabling unused clocks
[   28.448246][    T1] ALSA device list:
[   28.452320][    T1]   #0: Dummy 1
[   28.456220][    T1]   #1: Loopback 1
[   28.459931][    T1]   #2: Virtual MIDI Card 1
[   28.466828][    T1] md: Waiting for all devices to be available before autodetect
[   28.474753][    T1] md: If you don't use raid, use raid=noautodetect
[   28.481592][    T1] md: Autodetecting RAID arrays.
[   28.486591][    T1] md: autorun ...
[   28.490209][    T1] md: ... autorun DONE.
[   28.550861][    T1] EXT4-fs (sda1): mounted filesystem 5941fea2-f5fa-4b4e-b5ef-9af118b27b95 ro with ordered data mode. Quota mode: none.
[   28.563733][    T1] VFS: Mounted root (ext4 filesystem) readonly on device 8:1.
[   28.584466][    T1] devtmpfs: mounted
[   28.752930][    T1] Freeing unused kernel image (initmem) memory: 3396K
[   28.759784][    T1] Write protecting the kernel read-only data: 188416k
[   28.769443][    T1] Freeing unused kernel image (rodata/data gap) memory: 700K
[   28.896155][    T1] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[   28.908769][    T1] Failed to set sysctl parameter 'max_rcu_stall_to_panic=1': parameter not found
[   28.918782][    T1] Run /sbin/init as init process
[   28.923727][    T1]   with arguments:
[   28.927591][    T1]     /sbin/init
[   28.931132][    T1]   with environment:
[   28.935216][    T1]     HOME=/
[   28.938421][    T1]     TERM=linux
[   28.941948][    T1]     spec_store_bypass_disable=prctl
[   28.947789][    T1]     BOOT_IMAGE=/boot/bzImage
[   29.033669][    T1] general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
[   29.045504][    T1] KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
[   29.053923][    T1] CPU: 1 PID: 1 Comm: init Not tainted 6.5.0-rc7-next-20230822-syzkaller-dirty #0
[   29.063122][    T1] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
[   29.073176][    T1] RIP: 0010:do_raw_spin_lock+0x6e/0x2b0
[   29.078757][    T1] Code: 81 48 8d 54 05 00 c7 02 f1 f1 f1 f1 c7 42 04 04 f3 f3 f3 65 48 8b 14 25 28 00 00 00 48 89 54 24 60 31 d2 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 e3
[   29.098364][    T1] RSP: 0000:ffffc90000067b28 EFLAGS: 00010247
[   29.104512][    T1] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
[   29.112477][    T1] RDX: 0000000000000000 RSI: ffffffff8ae8fc60 RDI: 0000000000000004
[   29.120616][    T1] RBP: 1ffff9200000cf66 R08: 0000000000000000 R09: fffffbfff1d9ba3a
[   29.128598][    T1] R10: ffffffff8ecdd1d7 R11: ffffffff8a3cdc9d R12: 0000000000000000
[   29.136743][    T1] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000680000
[   29.144714][    T1] FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
[   29.153649][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   29.160258][    T1] CR2: 00007ffc17ddb229 CR3: 0000000026fb0000 CR4: 00000000003506e0
[   29.168335][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   29.176321][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   29.184297][    T1] Call Trace:
[   29.187574][    T1]  <TASK>
[   29.190504][    T1]  ? show_regs+0x8f/0xa0
[   29.194762][    T1]  ? die_addr+0x4f/0xd0
[   29.198926][    T1]  ? exc_general_protection+0x154/0x230
[   29.204761][    T1]  ? asm_exc_general_protection+0x26/0x30
[   29.210679][    T1]  ? syscall_exit_to_user_mode+0x1d/0x60
[   29.216327][    T1]  ? do_raw_spin_lock+0x6e/0x2b0
[   29.221382][    T1]  ? spin_bug+0x1d0/0x1d0
[   29.225722][    T1]  ? lock_release+0x4bf/0x680
[   29.230413][    T1]  ? dput+0x251/0xfd0
[   29.234447][    T1]  list_lru_add+0xce/0x540
[   29.238877][    T1]  ? dput+0x39/0xfd0
[   29.243068][    T1]  dput+0x87f/0xfd0
[   29.246888][    T1]  proc_kill_sb+0x6d/0x100
[   29.251320][    T1]  deactivate_locked_super+0x19c/0x2d0
[   29.256793][    T1]  deactivate_super+0xde/0x100
[   29.261580][    T1]  cleanup_mnt+0x222/0x3d0
[   29.266442][    T1]  mntput_no_expire+0x864/0xbc0
[   29.271303][    T1]  ? do_raw_spin_unlock+0x173/0x230
[   29.276528][    T1]  ? _raw_spin_unlock+0x28/0x40
[   29.281394][    T1]  ? mnt_get_count+0x1e0/0x1e0
[   29.286165][    T1]  ? _raw_spin_unlock+0x28/0x40
[   29.291024][    T1]  mntput+0x6b/0x90
[   29.294874][    T1]  __fput+0x560/0xa70
[   29.298875][    T1]  task_work_run+0x14d/0x240
[   29.303486][    T1]  ? task_work_cancel+0x30/0x30
[   29.308359][    T1]  ? kernel_execve+0x3f9/0x4e0
[   29.313223][    T1]  exit_to_user_mode_prepare+0x210/0x240
[   29.318874][    T1]  syscall_exit_to_user_mode+0x1d/0x60
[   29.324339][    T1]  ? rest_init+0x2b0/0x2b0
[   29.328762][    T1]  ret_from_fork_asm+0x11/0x20
[   29.333545][    T1]  </TASK>
[   29.336557][    T1] Modules linked in:
[   29.340653][    T1] ---[ end trace 0000000000000000 ]---
[   29.346320][    T1] RIP: 0010:do_raw_spin_lock+0x6e/0x2b0
[   29.351867][    T1] Code: 81 48 8d 54 05 00 c7 02 f1 f1 f1 f1 c7 42 04 04 f3 f3 f3 65 48 8b 14 25 28 00 00 00 48 89 54 24 60 31 d2 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 e3
[   29.371529][    T1] RSP: 0000:ffffc90000067b28 EFLAGS: 00010247
[   29.380525][    T1] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
[   29.388593][    T1] RDX: 0000000000000000 RSI: ffffffff8ae8fc60 RDI: 0000000000000004
[   29.396657][    T1] RBP: 1ffff9200000cf66 R08: 0000000000000000 R09: fffffbfff1d9ba3a
[   29.405013][    T1] R10: ffffffff8ecdd1d7 R11: ffffffff8a3cdc9d R12: 0000000000000000
[   29.413142][    T1] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000680000
[   29.421293][    T1] FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
[   29.430837][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   29.437428][    T1] CR2: 00007ffc17ddb229 CR3: 0000000026fb0000 CR4: 00000000003506e0
[   29.445508][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   29.453478][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   29.461546][    T1] Kernel panic - not syncing: Fatal exception
[   29.467789][    T1] Kernel Offset: disabled
[   29.472099][    T1] Rebooting in 86400 seconds..


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
GOGCCFLAGS="-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=0 -fdebug-prefix-map=/tmp/go-build503812671=/tmp/go-build -gno-record-gcc-switches"

git status (err=<nil>)
HEAD detached at b81ca3f66
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
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=b81ca3f66f8d2d8b397c3c1dc5f14e77c2936b1e -X 'github.com/google/syzkaller/prog.gitRevisionDate=20230822-122036'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer github.com/google/syzkaller/syz-fuzzer
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=b81ca3f66f8d2d8b397c3c1dc5f14e77c2936b1e -X 'github.com/google/syzkaller/prog.gitRevisionDate=20230822-122036'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=b81ca3f66f8d2d8b397c3c1dc5f14e77c2936b1e -X 'github.com/google/syzkaller/prog.gitRevisionDate=20230822-122036'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wframe-larger-than=16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-format-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -static-pie -fpermissive -w -DGOOS_linux=1 -DGOARCH_amd64=1 \
	-DHOSTGOOS_linux=1 -DGIT_REVISION=\"b81ca3f66f8d2d8b397c3c1dc5f14e77c2936b1e\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=11f109eba80000


Tested on:

commit:         28c736b0 Add linux-next specific files for 20230822
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=20999f779fa96017
dashboard link: https://syzkaller.appspot.com/bug?extid=f25c61df1ec3d235d52f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=159e79b0680000

