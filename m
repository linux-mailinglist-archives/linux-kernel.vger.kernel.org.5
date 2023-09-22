Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E212D7AB28E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 15:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbjIVNLZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 22 Sep 2023 09:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233556AbjIVNLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 09:11:23 -0400
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC8F196
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 06:11:16 -0700 (PDT)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1d6f163699bso2924633fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 06:11:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695388275; x=1695993075;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TBULrDk3uyLMBr71S1IeLARFhFB80uNxME/fnARvjsg=;
        b=vW+vRIUQCzpwqJU3gr8UzdcxFWVs80RDy7qKB22dIKEZX+ZStgaNIc2GYb0dqCsh3D
         wWnTr6lTJwXFUB5yBrMlL+Or7wX3iBBnJVXeLjSCp4fxoyjjcLB1NCpnyElXcGt9fCc7
         HoC/RdVAh9tmiZSorzCxpAOz2kvgW5fbkHyU/ZzJFs5tfRCeVkybjZR96pDohjP35/XZ
         TU5qu/E0m2Fjz4nMuFvZgAWdcLEXAUoG4hV5g1TFNiX6T1Kd0FiVc86vBgguTvs2jPY/
         aDOKZ9guYgToD+TiTREz8epL3Xl3ggU1OVloI6IqGWon/Uj1MYVCdCzCSUOMwrfJ94LL
         nGzw==
X-Gm-Message-State: AOJu0YwbHopgNqsWNknhQIwIGjyoVW5zqE/LpUO/TZ9tEsXQyZhcpSia
        axDJdffbx/HsJ50CnxweL67nbjOjMvjrDs9NYYdoJnXAYieC
X-Google-Smtp-Source: AGHT+IFcDRvG7/sX1VGzqcn9rpMcHNYoXUWjdsISfB52wYbA+HgzN+3RMF+zBGMXHe/Gquq3khJtds+6PcjEBoek4L8O4858lpc+
MIME-Version: 1.0
X-Received: by 2002:a05:6870:1a98:b0:1d6:3d1d:c6af with SMTP id
 ef24-20020a0568701a9800b001d63d1dc6afmr3398270oab.6.1695388275461; Fri, 22
 Sep 2023 06:11:15 -0700 (PDT)
Date:   Fri, 22 Sep 2023 06:11:15 -0700
In-Reply-To: <20230922124125.240-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ea74310605f257d9@google.com>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in super_lock
From:   syzbot <syzbot+062317ea1d0a6d5e29e7@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

: Allocated hash algorithm: sha256
[   27.035992][    T1] ima: No architecture policies found
[   27.042240][    T1] evm: Initialising EVM extended attributes:
[   27.048580][    T1] evm: security.selinux
[   27.052744][    T1] evm: security.SMACK64 (disabled)
[   27.058061][    T1] evm: security.SMACK64EXEC (disabled)
[   27.063553][    T1] evm: security.SMACK64TRANSMUTE (disabled)
[   27.069527][    T1] evm: security.SMACK64MMAP (disabled)
[   27.075116][    T1] evm: security.apparmor (disabled)
[   27.080399][    T1] evm: security.ima
[   27.084710][    T1] evm: security.capability
[   27.090479][    T1] evm: HMAC attrs: 0x1
[   27.097685][    T1] PM:   Magic number: 7:13:29
[   27.103531][    T1] tty ttydc: hash matches
[   27.108483][    T1] memory memory69: hash matches
[   27.115959][    T1] printk: console [netcon0] enabled
[   27.121787][    T1] netconsole: network logging started
[   27.128754][    T1] gtp: GTP module loaded (pdp ctx size 104 bytes)
[   27.137889][    T1] rdma_rxe: loaded
[   27.142619][    T1] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[   27.155065][    T1] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   27.165314][    T1] clk: Disabling unused clocks
[   27.165914][  T921] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[   27.170274][    T1] ALSA device list:
[   27.180256][  T921] platform regulatory.0: Falling back to sysfs fallback for: regulatory.db
[   27.184543][    T1]   #0: Dummy 1
[   27.184558][    T1]   #1: Loopback 1
[   27.184570][    T1]   #2: Virtual MIDI Card 1
[   27.212250][    T1] md: Waiting for all devices to be available before autodetect
[   27.220507][    T1] md: If you don't use raid, use raid=noautodetect
[   27.227162][    T1] md: Autodetecting RAID arrays.
[   27.232319][    T1] md: autorun ...
[   27.236020][    T1] md: ... autorun DONE.
[   27.282766][    T1] 
[   27.285112][    T1] =====================================
[   27.290728][    T1] WARNING: bad unlock balance detected!
[   27.296371][    T1] 6.6.0-rc2-syzkaller-00018-g2cf0f7156238-dirty #0 Not tainted
[   27.304445][    T1] -------------------------------------
[   27.310421][    T1] swapper/0/1 is trying to release lock (&type->s_umount_key) at:
[   27.318241][    T1] [<ffffffff81eb7734>] generic_shutdown_super+0x1e4/0x3c0
[   27.325454][    T1] but there are no more locks to release!
[   27.331175][    T1] 
[   27.331175][    T1] other info that might help us debug this:
[   27.339755][    T1] no locks held by swapper/0/1.
[   27.344702][    T1] 
[   27.344702][    T1] stack backtrace:
[   27.351193][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.6.0-rc2-syzkaller-00018-g2cf0f7156238-dirty #0
[   27.361550][    T1] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
[   27.371784][    T1] Call Trace:
[   27.375057][    T1]  <TASK>
[   27.377991][    T1]  dump_stack_lvl+0xd9/0x1b0
[   27.382775][    T1]  lock_release+0x4b5/0x680
[   27.387307][    T1]  ? generic_shutdown_super+0x1e4/0x3c0
[   27.393046][    T1]  ? reacquire_held_locks+0x4b0/0x4b0
[   27.399133][    T1]  ? reacquire_held_locks+0x4b0/0x4b0
[   27.404517][    T1]  ? __wake_up_sync+0x20/0x20
[   27.409379][    T1]  up_write+0x2a/0x510
[   27.413447][    T1]  ? reiserfs_remount+0x1640/0x1640
[   27.418761][    T1]  generic_shutdown_super+0x1e4/0x3c0
[   27.424293][    T1]  ? reiserfs_remount+0x1640/0x1640
[   27.429818][    T1]  kill_block_super+0x3b/0x70
[   27.434502][    T1]  deactivate_locked_super+0xa6/0x180
[   27.439882][    T1]  mount_bdev+0x2a6/0x300
[   27.444306][    T1]  ? sget+0x610/0x610
[   27.448361][    T1]  ? vfs_parse_fs_param+0x3c0/0x3c0
[   27.453617][    T1]  ? cap_capable+0x1d8/0x240
[   27.458237][    T1]  ? reiserfs_kill_sb+0x1e0/0x1e0
[   27.463792][    T1]  legacy_get_tree+0x109/0x220
[   27.468671][    T1]  vfs_get_tree+0x8c/0x370
[   27.473205][    T1]  path_mount+0x1492/0x1ed0
[   27.477749][    T1]  ? kmem_cache_free+0x223/0x380
[   27.482713][    T1]  ? finish_automount+0xa40/0xa40
[   27.487868][    T1]  ? putname+0x101/0x140
[   27.492574][    T1]  init_mount+0xbf/0x110
[   27.497105][    T1]  ? nsfs_init+0xb0/0xb0
[   27.501361][    T1]  do_mount_root+0xdd/0x2c0
[   27.506048][    T1]  mount_root_generic+0x19a/0x460
[   27.511083][    T1]  ? init_rootfs+0x60/0x60
[   27.515515][    T1]  ? getname_kernel+0x21c/0x360
[   27.520369][    T1]  mount_root+0x241/0x480
[   27.524697][    T1]  ? kmem_cache_alloc+0x338/0x400
[   27.529717][    T1]  ? mount_root_generic+0x460/0x460
[   27.535001][    T1]  ? getname_kernel+0x21c/0x360
[   27.539945][    T1]  prepare_namespace+0xe3/0x3f0
[   27.544896][    T1]  ? mount_root+0x480/0x480
[   27.549494][    T1]  ? fput+0x30/0x1a0
[   27.553394][    T1]  kernel_init_freeable+0x703/0x8f0
[   27.558596][    T1]  ? rest_init+0x2b0/0x2b0
[   27.563016][    T1]  kernel_init+0x1c/0x2a0
[   27.567351][    T1]  ? rest_init+0x2b0/0x2b0
[   27.571769][    T1]  ret_from_fork+0x45/0x80
[   27.576365][    T1]  ? rest_init+0x2b0/0x2b0
[   27.580799][    T1]  ret_from_fork_asm+0x11/0x20
[   27.585674][    T1]  </TASK>
[   27.588872][    T1] ------------[ cut here ]------------
[   27.594557][    T1] DEBUG_RWSEMS_WARN_ON((rwsem_owner(sem) != current) && !rwsem_test_oflags(sem, RWSEM_NONSPINNABLE)): count = 0x0, magic = 0xffff88814be20070, owner = 0x0, curr 0xffff888019644040, list empty
[   27.613588][    T1] WARNING: CPU: 0 PID: 1 at kernel/locking/rwsem.c:1369 up_write+0x458/0x510
[   27.622528][    T1] Modules linked in:
[   27.626442][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.6.0-rc2-syzkaller-00018-g2cf0f7156238-dirty #0
[   27.637061][    T1] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
[   27.648689][    T1] RIP: 0010:up_write+0x458/0x510
[   27.653883][    T1] Code: c1 ea 03 80 3c 02 00 75 50 48 8b 13 4d 89 f1 41 55 4d 89 f8 4c 89 e1 48 c7 c6 e0 93 8c 8a 48 c7 c7 00 93 8c 8a e8 e8 e1 e6 ff <0f> 0b 5a e9 aa fc ff ff 48 89 ef e8 28 9f 75 00 e9 17 fd ff ff 48
[   27.674317][    T1] RSP: 0000:ffffc9000027f910 EFLAGS: 00010286
[   27.680635][    T1] RAX: 0000000000000000 RBX: ffff88814be20070 RCX: 0000000000000000
[   27.688711][    T1] RDX: ffff888019644040 RSI: ffffffff814cf096 RDI: 0000000000000001
[   27.696725][    T1] RBP: ffff88814be20078 R08: 0000000000000001 R09: 0000000000000000
[   27.704906][    T1] R10: 0000000000000001 R11: 0000000000000001 R12: ffff88814be20070
[   27.713404][    T1] R13: ffffffff8a8c9240 R14: ffff888019644040 R15: 0000000000000000
[   27.721412][    T1] FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
[   27.730905][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   27.737626][    T1] CR2: ffff88823ffff000 CR3: 000000000c976000 CR4: 00000000003506f0
[   27.746689][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   27.754948][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   27.762933][    T1] Call Trace:
[   27.766295][    T1]  <TASK>
[   27.769274][    T1]  ? show_regs+0x8f/0xa0
[   27.773712][    T1]  ? __warn+0xe6/0x380
[   27.777946][    T1]  ? up_write+0x458/0x510
[   27.782348][    T1]  ? report_bug+0x3bc/0x580
[   27.786873][    T1]  ? handle_bug+0x3c/0x70
[   27.791192][    T1]  ? exc_invalid_op+0x17/0x40
[   27.795896][    T1]  ? asm_exc_invalid_op+0x1a/0x20
[   27.800980][    T1]  ? __warn_printk+0x1a6/0x350
[   27.805772][    T1]  ? up_write+0x458/0x510
[   27.810110][    T1]  ? reiserfs_remount+0x1640/0x1640
[   27.815343][    T1]  generic_shutdown_super+0x1e4/0x3c0
[   27.820737][    T1]  ? reiserfs_remount+0x1640/0x1640
[   27.826056][    T1]  kill_block_super+0x3b/0x70
[   27.830828][    T1]  deactivate_locked_super+0xa6/0x180
[   27.836220][    T1]  mount_bdev+0x2a6/0x300
[   27.840537][    T1]  ? sget+0x610/0x610
[   27.844534][    T1]  ? vfs_parse_fs_param+0x3c0/0x3c0
[   27.849831][    T1]  ? cap_capable+0x1d8/0x240
[   27.854439][    T1]  ? reiserfs_kill_sb+0x1e0/0x1e0
[   27.859490][    T1]  legacy_get_tree+0x109/0x220
[   27.864358][    T1]  vfs_get_tree+0x8c/0x370
[   27.868886][    T1]  path_mount+0x1492/0x1ed0
[   27.873441][    T1]  ? kmem_cache_free+0x223/0x380
[   27.878456][    T1]  ? finish_automount+0xa40/0xa40
[   27.883647][    T1]  ? putname+0x101/0x140
[   27.887917][    T1]  init_mount+0xbf/0x110
[   27.892230][    T1]  ? nsfs_init+0xb0/0xb0
[   27.896498][    T1]  do_mount_root+0xdd/0x2c0
[   27.901004][    T1]  mount_root_generic+0x19a/0x460
[   27.906042][    T1]  ? init_rootfs+0x60/0x60
[   27.910526][    T1]  ? getname_kernel+0x21c/0x360
[   27.915727][    T1]  mount_root+0x241/0x480
[   27.920314][    T1]  ? kmem_cache_alloc+0x338/0x400
[   27.925350][    T1]  ? mount_root_generic+0x460/0x460
[   27.930895][    T1]  ? getname_kernel+0x21c/0x360
[   27.936002][    T1]  prepare_namespace+0xe3/0x3f0
[   27.941118][    T1]  ? mount_root+0x480/0x480
[   27.945751][    T1]  ? fput+0x30/0x1a0
[   27.949754][    T1]  kernel_init_freeable+0x703/0x8f0
[   27.954988][    T1]  ? rest_init+0x2b0/0x2b0
[   27.959460][    T1]  kernel_init+0x1c/0x2a0
[   27.963999][    T1]  ? rest_init+0x2b0/0x2b0
[   27.969519][    T1]  ret_from_fork+0x45/0x80
[   27.974142][    T1]  ? rest_init+0x2b0/0x2b0
[   27.978650][    T1]  ret_from_fork_asm+0x11/0x20
[   27.983604][    T1]  </TASK>
[   27.986619][    T1] Kernel panic - not syncing: kernel: panic_on_warn set ...
[   27.994750][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.6.0-rc2-syzkaller-00018-g2cf0f7156238-dirty #0
[   28.005187][    T1] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
[   28.015864][    T1] Call Trace:
[   28.019651][    T1]  <TASK>
[   28.022839][    T1]  dump_stack_lvl+0xd9/0x1b0
[   28.027529][    T1]  panic+0x6a6/0x750
[   28.032304][    T1]  ? panic_smp_self_stop+0xa0/0xa0
[   28.037525][    T1]  ? up_write+0x458/0x510
[   28.042116][    T1]  check_panic_on_warn+0xab/0xb0
[   28.047062][    T1]  __warn+0xf2/0x380
[   28.050976][    T1]  ? up_write+0x458/0x510
[   28.055569][    T1]  report_bug+0x3bc/0x580
[   28.060442][    T1]  handle_bug+0x3c/0x70
[   28.065044][    T1]  exc_invalid_op+0x17/0x40
[   28.070109][    T1]  asm_exc_invalid_op+0x1a/0x20
[   28.074971][    T1] RIP: 0010:up_write+0x458/0x510
[   28.080204][    T1] Code: c1 ea 03 80 3c 02 00 75 50 48 8b 13 4d 89 f1 41 55 4d 89 f8 4c 89 e1 48 c7 c6 e0 93 8c 8a 48 c7 c7 00 93 8c 8a e8 e8 e1 e6 ff <0f> 0b 5a e9 aa fc ff ff 48 89 ef e8 28 9f 75 00 e9 17 fd ff ff 48
[   28.101200][    T1] RSP: 0000:ffffc9000027f910 EFLAGS: 00010286
[   28.108760][    T1] RAX: 0000000000000000 RBX: ffff88814be20070 RCX: 0000000000000000
[   28.117095][    T1] RDX: ffff888019644040 RSI: ffffffff814cf096 RDI: 0000000000000001
[   28.126618][    T1] RBP: ffff88814be20078 R08: 0000000000000001 R09: 0000000000000000
[   28.135129][    T1] R10: 0000000000000001 R11: 0000000000000001 R12: ffff88814be20070
[   28.143194][    T1] R13: ffffffff8a8c9240 R14: ffff888019644040 R15: 0000000000000000
[   28.151661][    T1]  ? __warn_printk+0x1a6/0x350
[   28.156636][    T1]  ? reiserfs_remount+0x1640/0x1640
[   28.162549][    T1]  generic_shutdown_super+0x1e4/0x3c0
[   28.168079][    T1]  ? reiserfs_remount+0x1640/0x1640
[   28.173469][    T1]  kill_block_super+0x3b/0x70
[   28.178141][    T1]  deactivate_locked_super+0xa6/0x180
[   28.185001][    T1]  mount_bdev+0x2a6/0x300
[   28.189343][    T1]  ? sget+0x610/0x610
[   28.193358][    T1]  ? vfs_parse_fs_param+0x3c0/0x3c0
[   28.198655][    T1]  ? cap_capable+0x1d8/0x240
[   28.203381][    T1]  ? reiserfs_kill_sb+0x1e0/0x1e0
[   28.208422][    T1]  legacy_get_tree+0x109/0x220
[   28.213330][    T1]  vfs_get_tree+0x8c/0x370
[   28.217759][    T1]  path_mount+0x1492/0x1ed0
[   28.222264][    T1]  ? kmem_cache_free+0x223/0x380
[   28.227628][    T1]  ? finish_automount+0xa40/0xa40
[   28.232783][    T1]  ? putname+0x101/0x140
[   28.237039][    T1]  init_mount+0xbf/0x110
[   28.241283][    T1]  ? nsfs_init+0xb0/0xb0
[   28.245522][    T1]  do_mount_root+0xdd/0x2c0
[   28.250046][    T1]  mount_root_generic+0x19a/0x460
[   28.255065][    T1]  ? init_rootfs+0x60/0x60
[   28.259488][    T1]  ? getname_kernel+0x21c/0x360
[   28.264366][    T1]  mount_root+0x241/0x480
[   28.268693][    T1]  ? kmem_cache_alloc+0x338/0x400
[   28.273700][    T1]  ? mount_root_generic+0x460/0x460
[   28.278888][    T1]  ? getname_kernel+0x21c/0x360
[   28.283735][    T1]  prepare_namespace+0xe3/0x3f0
[   28.288575][    T1]  ? mount_root+0x480/0x480
[   28.293225][    T1]  ? fput+0x30/0x1a0
[   28.297134][    T1]  kernel_init_freeable+0x703/0x8f0
[   28.302361][    T1]  ? rest_init+0x2b0/0x2b0
[   28.306831][    T1]  kernel_init+0x1c/0x2a0
[   28.311182][    T1]  ? rest_init+0x2b0/0x2b0
[   28.315698][    T1]  ret_from_fork+0x45/0x80
[   28.320147][    T1]  ? rest_init+0x2b0/0x2b0
[   28.324661][    T1]  ret_from_fork_asm+0x11/0x20
[   28.329423][    T1]  </TASK>
[   28.332714][    T1] Kernel Offset: disabled
[   28.337046][    T1] Rebooting in 86400 seconds..


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
GOGCCFLAGS="-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=0 -fdebug-prefix-map=/tmp/go-build4053167018=/tmp/go-build -gno-record-gcc-switches"

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
https://syzkaller.appspot.com/x/error.txt?x=1688a642680000


Tested on:

commit:         2cf0f715 Merge tag 'nfs-for-6.6-2' of git://git.linux-..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=710dc49bece494df
dashboard link: https://syzkaller.appspot.com/bug?extid=062317ea1d0a6d5e29e7
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1656035a680000

