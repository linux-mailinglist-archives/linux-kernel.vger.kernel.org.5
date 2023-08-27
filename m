Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F1D789B81
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 07:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjH0Fav convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 27 Aug 2023 01:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjH0Fab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 01:30:31 -0400
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2617E1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 22:30:26 -0700 (PDT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-26d1ec91c8aso1883306a91.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 22:30:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693114226; x=1693719026;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mwora6AN7FKTbiNR0booaJoPkXpKRVit+ZpQKlFDrwM=;
        b=AGq6FQPlzrO04Oc+4/n3SbTbvRZa+m2iZH+m6IwxX10hehSYEfMEi1Fd1vANgnMlcy
         tY2ZeijXtBj2azqfa73DracWd5A709lki8ucfrZB8NpOH1I1MZmCyolwHn+hLBnmPLtI
         ciqrEwKrq3abpB5z502T2oSmGhpQtxqh0akOg+r3xOdhC2OJOR0Yrq52r1VY1tOsidbu
         uKqG7I8+9+gpLfIY0Dhn5eqJ1c2V5TybFifbGnwqCZFWVIu+ywd1eGqM8h68KKVYF7n8
         k+AChFKKL+WrD4VktTLuKbkleKh6l0AUPsTSim+wyUUbheHXVhkFIxSgJv02FR8O2Kwu
         pumg==
X-Gm-Message-State: AOJu0YzUgWr6U3xn9d94+vlFr3DVSZcu9WGplzltP6stx7JZelxXR2r1
        zci4G4IOxXFAUIFsA6jV5uYU1tRA7xjJVn3oF9v+WRj5f76+
X-Google-Smtp-Source: AGHT+IGCwW6RP1RTutfI3h53Tlp+bmZd5MfF4sthH5Wj07Dnq2tzYDCFsW+49k4doLXmb/yTQhyMmp+g/mv5HO2F7QiCHuwomU4N
MIME-Version: 1.0
X-Received: by 2002:a17:903:1d2:b0:1bd:e2ba:83d9 with SMTP id
 e18-20020a17090301d200b001bde2ba83d9mr8455563plh.7.1693114226307; Sat, 26 Aug
 2023 22:30:26 -0700 (PDT)
Date:   Sat, 26 Aug 2023 22:30:26 -0700
In-Reply-To: <20230827044001.3605-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000005ffe00603e0e0e4@google.com>
Subject: Re: [syzbot] [kernfs?] KASAN: slab-use-after-free Read in kernfs_test_super
From:   syzbot <syzbot+f25c61df1ec3d235d52f@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
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
[   22.143888][    T1] In-situ OAM (IOAM) with IPv6
[   22.150994][    T1] mip6: Mobile IPv6
[   22.161364][    T1] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[   22.179155][    T1] ip6_gre: GRE over IPv6 tunneling driver
[   22.191706][    T1] NET: Registered PF_PACKET protocol family
[   22.199145][    T1] NET: Registered PF_KEY protocol family
[   22.205140][    T1] Bridge firewalling registered
[   22.210671][    T1] NET: Registered PF_X25 protocol family
[   22.216780][    T1] X25: Linux Version 0.2
[   22.296503][    T1] NET: Registered PF_NETROM protocol family
[   22.377913][    T1] NET: Registered PF_ROSE protocol family
[   22.387790][    T1] NET: Registered PF_AX25 protocol family
[   22.393849][    T1] can: controller area network core
[   22.399609][    T1] NET: Registered PF_CAN protocol family
[   22.405627][    T1] can: raw protocol
[   22.409851][    T1] can: broadcast manager protocol
[   22.415185][    T1] can: netlink gateway - max_hops=1
[   22.420907][    T1] can: SAE J1939
[   22.424586][    T1] can: isotp protocol (max_pdu_size 8300)
[   22.431307][    T1] Bluetooth: RFCOMM TTY layer initialized
[   22.437283][    T1] Bluetooth: RFCOMM socket layer initialized
[   22.443663][    T1] Bluetooth: RFCOMM ver 1.11
[   22.449206][    T1] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   22.455555][    T1] Bluetooth: BNEP filters: protocol multicast
[   22.462111][    T1] Bluetooth: BNEP socket layer initialized
[   22.468496][    T1] Bluetooth: CMTP (CAPI Emulation) ver 1.0
[   22.474693][    T1] Bluetooth: CMTP socket layer initialized
[   22.480545][    T1] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[   22.487463][    T1] Bluetooth: HIDP socket layer initialized
[   22.497445][    T1] NET: Registered PF_RXRPC protocol family
[   22.503428][    T1] Key type rxrpc registered
[   22.508789][    T1] Key type rxrpc_s registered
[   22.514308][    T1] NET: Registered PF_KCM protocol family
[   22.520678][    T1] lec:lane_module_init: lec.c: initialized
[   22.526588][    T1] mpoa:atm_mpoa_init: mpc.c: initialized
[   22.532594][    T1] l2tp_core: L2TP core driver, V2.0
[   22.538346][    T1] l2tp_ppp: PPPoL2TP kernel driver, V2.0
[   22.544240][    T1] l2tp_ip: L2TP IP encapsulation support (L2TPv3)
[   22.550976][    T1] l2tp_netlink: L2TP netlink interface
[   22.556596][    T1] l2tp_eth: L2TP ethernet pseudowire support (L2TPv3)
[   22.563621][    T1] l2tp_ip6: L2TP IP encapsulation support for IPv6 (L2TPv3)
[   22.571468][    T1] NET: Registered PF_PHONET protocol family
[   22.578014][    T1] 8021q: 802.1Q VLAN Support v1.8
[   22.598850][    T1] DCCP: Activated CCID 2 (TCP-like)
[   22.604774][    T1] DCCP: Activated CCID 3 (TCP-Friendly Rate Control)
[   22.612016][    T1] DCCP is deprecated and scheduled to be removed in 2025, please contact the netdev mailing list
[   22.623666][    T1] sctp: Hash tables configured (bind 32/56)
[   22.631042][    T1] NET: Registered PF_RDS protocol family
[   22.637590][    T1] Registered RDS/infiniband transport
[   22.643554][    T1] Registered RDS/tcp transport
[   22.648634][    T1] tipc: Activated (version 2.0.0)
[   22.654067][    T1] NET: Registered PF_TIPC protocol family
[   22.660718][    T1] tipc: Started in single node mode
[   22.666750][    T1] NET: Registered PF_SMC protocol family
[   22.672715][    T1] 9pnet: Installing 9P2000 support
[   22.678148][    T1] NET: Registered PF_CAIF protocol family
[   22.691455][    T1] NET: Registered PF_IEEE802154 protocol family
[   22.698427][    T1] Key type dns_resolver registered
[   22.703574][    T1] Key type ceph registered
[   22.708510][    T1] libceph: loaded (mon/osd proto 15/24)
[   22.715393][    T1] batman_adv: B.A.T.M.A.N. advanced 2023.3 (compatibility version 15) loaded
[   22.724699][    T1] openvswitch: Open vSwitch switching datapath
[   22.734037][    T1] NET: Registered PF_VSOCK protocol family
[   22.740995][    T1] mpls_gso: MPLS GSO support
[   22.754002][    T1] start plist test
[   22.761434][    T1] end plist test
[   22.774743][    T1] IPI shorthand broadcast: enabled
[   22.780393][    T1] AVX2 version of gcm_enc/dec engaged.
[   22.786114][    T1] AES CTR mode by8 optimization enabled
[   24.907765][    T1] sched_clock: Marking stable (24860021136, 46836333)->(24908384501, -1527032)
[   24.929653][    T1] registered taskstats version 1
[   24.948815][    T1] Loading compiled-in X.509 certificates
[   24.959723][    T1] Loaded X.509 cert 'Build time autogenerated kernel key: b076a2c54e475ca22371b28873485011e7dd859f'
[   24.975272][    T1] zswap: loaded using pool lzo/zbud
[   25.211781][    T1] debug_vm_pgtable: [debug_vm_pgtable         ]: Validating architecture page table helpers
[   28.158064][    T1] Key type .fscrypt registered
[   28.162837][    T1] Key type fscrypt-provisioning registered
[   28.177370][    T1] kAFS: Red Hat AFS client v0.1 registering.
[   28.201312][    T1] Btrfs loaded, assert=on, ref-verify=on, zoned=yes, fsverity=yes
[   28.209912][    T1] Key type big_key registered
[   28.217693][    T1] Key type encrypted registered
[   28.222659][    T1] AppArmor: AppArmor sha1 policy hashing enabled
[   28.229280][    T1] ima: No TPM chip found, activating TPM-bypass!
[   28.235739][    T1] Loading compiled-in module X.509 certificates
[   28.246592][    T1] Loaded X.509 cert 'Build time autogenerated kernel key: b076a2c54e475ca22371b28873485011e7dd859f'
[   28.257470][    T1] ima: Allocated hash algorithm: sha256
[   28.263308][    T1] ima: No architecture policies found
[   28.269223][    T1] evm: Initialising EVM extended attributes:
[   28.275766][    T1] evm: security.selinux (disabled)
[   28.281188][    T1] evm: security.SMACK64 (disabled)
[   28.286370][    T1] evm: security.SMACK64EXEC (disabled)
[   28.292383][    T1] evm: security.SMACK64TRANSMUTE (disabled)
[   28.298408][    T1] evm: security.SMACK64MMAP (disabled)
[   28.303943][    T1] evm: security.apparmor
[   28.308199][    T1] evm: security.ima
[   28.311986][    T1] evm: security.capability
[   28.316938][    T1] evm: HMAC attrs: 0x1
[   28.323242][    T1] PM:   Magic number: 3:393:366
[   28.331352][    T1] printk: console [netcon0] enabled
[   28.336951][    T1] netconsole: network logging started
[   28.343286][    T1] gtp: GTP module loaded (pdp ctx size 104 bytes)
[   28.351710][    T1] rdma_rxe: loaded
[   28.356689][    T1] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[   28.368757][    T1] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   28.376230][ T2518] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[   28.386651][ T2518] platform regulatory.0: Falling back to sysfs fallback for: regulatory.db
[   28.387079][    T1] clk: Disabling unused clocks
[   28.400702][    T1] ALSA device list:
[   28.404510][    T1]   #0: Dummy 1
[   28.408586][    T1]   #1: Loopback 1
[   28.412475][    T1]   #2: Virtual MIDI Card 1
[   28.419437][    T1] md: Waiting for all devices to be available before autodetect
[   28.427528][    T1] md: If you don't use raid, use raid=noautodetect
[   28.434064][    T1] md: Autodetecting RAID arrays.
[   28.439026][    T1] md: autorun ...
[   28.443095][    T1] md: ... autorun DONE.
[   28.518373][    T1] EXT4-fs (sda1): mounted filesystem 5941fea2-f5fa-4b4e-b5ef-9af118b27b95 ro with ordered data mode. Quota mode: none.
[   28.532156][    T1] VFS: Mounted root (ext4 filesystem) readonly on device 8:1.
[   28.544130][    T1] devtmpfs: mounted
[   28.705830][    T1] Freeing unused kernel image (initmem) memory: 3396K
[   28.712759][    T1] Write protecting the kernel read-only data: 188416k
[   28.722628][    T1] Freeing unused kernel image (rodata/data gap) memory: 700K
[   28.850831][    T1] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[   28.862668][    T1] Failed to set sysctl parameter 'max_rcu_stall_to_panic=1': parameter not found
[   28.872769][    T1] Run /sbin/init as init process
[   28.878031][    T1]   with arguments:
[   28.881875][    T1]     /sbin/init
[   28.885406][    T1]   with environment:
[   28.889432][    T1]     HOME=/
[   28.892622][    T1]     TERM=linux
[   28.896156][    T1]     spec_store_bypass_disable=prctl
[   28.901656][    T1]     BOOT_IMAGE=/boot/bzImage
[   28.923260][    T1] general protection fault, probably for non-canonical address 0xdffffc0000000010: 0000 [#1] PREEMPT SMP KASAN
[   28.935261][    T1] KASAN: null-ptr-deref in range [0x0000000000000080-0x0000000000000087]
[   28.944174][    T1] CPU: 1 PID: 1 Comm: init Not tainted 6.5.0-rc7-next-20230822-syzkaller-dirty #0
[   28.953449][    T1] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
[   28.963636][    T1] RIP: 0010:do_raw_spin_lock+0x6e/0x2b0
[   28.969485][    T1] Code: 81 48 8d 54 05 00 c7 02 f1 f1 f1 f1 c7 42 04 04 f3 f3 f3 65 48 8b 14 25 28 00 00 00 48 89 54 24 60 31 d2 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 e3
[   28.989805][    T1] RSP: 0000:ffffc90000067b28 EFLAGS: 00010203
[   28.996053][    T1] RAX: dffffc0000000000 RBX: 0000000000000080 RCX: 0000000000000000
[   29.004565][    T1] RDX: 0000000000000010 RSI: ffffffff8ae8fc60 RDI: 0000000000000084
[   29.012980][    T1] RBP: 1ffff9200000cf66 R08: 0000000000000000 R09: fffffbfff1d9ba3a
[   29.021053][    T1] R10: ffffffff8ecdd1d7 R11: ffffffff8a3cdc9d R12: 0000000000000001
[   29.030158][    T1] R13: 0000000000000080 R14: 0000000000000080 R15: 0000000000680000
[   29.038224][    T1] FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
[   29.048195][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   29.054876][    T1] CR2: 00007ffcfc6d3c19 CR3: 0000000029462000 CR4: 00000000003506e0
[   29.062944][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   29.070919][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   29.078911][    T1] Call Trace:
[   29.082255][    T1]  <TASK>
[   29.085186][    T1]  ? show_regs+0x8f/0xa0
[   29.089548][    T1]  ? die_addr+0x4f/0xd0
[   29.093887][    T1]  ? exc_general_protection+0x154/0x230
[   29.099564][    T1]  ? asm_exc_general_protection+0x26/0x30
[   29.105314][    T1]  ? syscall_exit_to_user_mode+0x1d/0x60
[   29.110958][    T1]  ? do_raw_spin_lock+0x6e/0x2b0
[   29.116445][    T1]  ? spin_bug+0x1d0/0x1d0
[   29.121142][    T1]  ? lock_release+0x4bf/0x680
[   29.125833][    T1]  ? dput+0x251/0xfd0
[   29.129836][    T1]  list_lru_add+0xce/0x540
[   29.134390][    T1]  ? dput+0x39/0xfd0
[   29.138402][    T1]  dput+0x87f/0xfd0
[   29.142254][    T1]  proc_kill_sb+0x6d/0x100
[   29.146689][    T1]  deactivate_locked_super+0x19c/0x2d0
[   29.152353][    T1]  deactivate_super+0xde/0x100
[   29.157227][    T1]  cleanup_mnt+0x222/0x3d0
[   29.161657][    T1]  mntput_no_expire+0x864/0xbc0
[   29.166632][    T1]  ? do_raw_spin_unlock+0x173/0x230
[   29.171874][    T1]  ? _raw_spin_unlock+0x28/0x40
[   29.176855][    T1]  ? mnt_get_count+0x1e0/0x1e0
[   29.181899][    T1]  ? _raw_spin_unlock+0x28/0x40
[   29.186955][    T1]  mntput+0x6b/0x90
[   29.190962][    T1]  __fput+0x560/0xa70
[   29.195145][    T1]  task_work_run+0x14d/0x240
[   29.199756][    T1]  ? task_work_cancel+0x30/0x30
[   29.204622][    T1]  ? kernel_execve+0x3f9/0x4e0
[   29.209830][    T1]  exit_to_user_mode_prepare+0x210/0x240
[   29.215568][    T1]  syscall_exit_to_user_mode+0x1d/0x60
[   29.221126][    T1]  ? rest_init+0x2b0/0x2b0
[   29.225547][    T1]  ret_from_fork_asm+0x11/0x20
[   29.230361][    T1]  </TASK>
[   29.233475][    T1] Modules linked in:
[   29.237562][    T1] ---[ end trace 0000000000000000 ]---
[   29.243328][    T1] RIP: 0010:do_raw_spin_lock+0x6e/0x2b0
[   29.249089][    T1] Code: 81 48 8d 54 05 00 c7 02 f1 f1 f1 f1 c7 42 04 04 f3 f3 f3 65 48 8b 14 25 28 00 00 00 48 89 54 24 60 31 d2 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 e3
[   29.269244][    T1] RSP: 0000:ffffc90000067b28 EFLAGS: 00010203
[   29.276026][    T1] RAX: dffffc0000000000 RBX: 0000000000000080 RCX: 0000000000000000
[   29.284590][    T1] RDX: 0000000000000010 RSI: ffffffff8ae8fc60 RDI: 0000000000000084
[   29.293010][    T1] RBP: 1ffff9200000cf66 R08: 0000000000000000 R09: fffffbfff1d9ba3a
[   29.301669][    T1] R10: ffffffff8ecdd1d7 R11: ffffffff8a3cdc9d R12: 0000000000000001
[   29.309787][    T1] R13: 0000000000000080 R14: 0000000000000080 R15: 0000000000680000
[   29.318102][    T1] FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
[   29.327776][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   29.334660][    T1] CR2: 00007ffcfc6d3c19 CR3: 0000000029462000 CR4: 00000000003506e0
[   29.342695][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   29.350892][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   29.359108][    T1] Kernel panic - not syncing: Fatal exception
[   29.365720][    T1] Kernel Offset: disabled
[   29.370311][    T1] Rebooting in 86400 seconds..


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
GOGCCFLAGS="-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=0 -fdebug-prefix-map=/tmp/go-build1047880574=/tmp/go-build -gno-record-gcc-switches"

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
https://syzkaller.appspot.com/x/error.txt?x=14283c87a80000


Tested on:

commit:         28c736b0 Add linux-next specific files for 20230822
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=20999f779fa96017
dashboard link: https://syzkaller.appspot.com/bug?extid=f25c61df1ec3d235d52f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17809340680000

