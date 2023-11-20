Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64F97F2039
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 23:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbjKTWZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 17:25:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbjKTWZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 17:25:34 -0500
X-Greylist: delayed 1893 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 20 Nov 2023 14:25:28 PST
Received: from griffin.linux.hr (griffin.linux.hr [193.198.212.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8C8A2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 14:25:28 -0800 (PST)
Received: from vkosturj by griffin.linux.hr with local (Exim 4.89)
        (envelope-from <vkosturj@griffin.linux.hr>)
        id 1r5CDG-0005NR-60; Mon, 20 Nov 2023 22:53:50 +0100
Date:   Mon, 20 Nov 2023 22:53:50 +0100
From:   Vlatko Kosturjak <kost@linux.hr>
To:     linux-kernel@vger.kernel.org
Cc:     syzkaller@googlegroups.com
Subject: BUG: unable to handle kernel paging request in ioread32_rep
Message-ID: <20231120215350.u2fda6kvtjfwbidc@griffin.linux.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Vlatko Kosturjak <vkosturj@griffin.linux.hr>
X-SA-Exim-Connect-IP: <locally generated>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Just found following bug.

BUG: unable to handle kernel paging request in ioread32_rep

GIT: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
commit 98b1cc82c4affc16f5598d4fa14b1858671b2263 (HEAD -> master, tag: v6.7-rc2, origin/master, origin/HEAD)
- commit info
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun Nov 19 15:02:14 2023 -0800

    Linux 6.7-rc2
- end of commit info

Also, reproduced against stable releases (downloaded from https://kernel.org/):
6.6.1 
6.6.0
6.5.5

Reproducer: http://misc.linux.hr/ioread32/repro.c
Config: http://misc.linux.hr/ioread32/config.gz
Image: http://misc.linux.hr/ioread32/bookworm.img.orig
Log: http://misc.linux.hr/ioread32/repro.log
Prog: http://misc.linux.hr/ioread32/repro.prog
Report: http://misc.linux.hr/ioread32/repro.report

#1 kernel output using syzkaller (same trigger):

[  353.078296] BUG: unable to handle page fault for address: ffff888005b81000
[  353.080566] #PF: supervisor write access in kernel mode
[  353.082235] #PF: error_code(0x0003) - permissions violation
[  353.084049] PGD 33001067 P4D 33001067 PUD 33002067 PMD 35f0063 PTE 8000000005b81161
[  353.085371] Oops: 0003 [#1] PREEMPT SMP KASAN NOPTI
[  353.085742] CPU: 1 PID: 49 Comm: kworker/1:2 Not tainted 6.5.5 #1
[  353.086186] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[  353.086780] Workqueue: ata_sff ata_sff_pio_task
[  353.087156] RIP: 0010:ioread32_rep+0x98/0xf0
[  353.087466] Code: cf 5b 5d 41 5c 41 5d 41 5e e9 04 6d 3c ff e8 ff 6c 3c ff 49 81 fc 00 00 01 00 76 1d e8 f1 6c 3c ff 48 89 df 48 89 e9 44 89 e2 <f3> 6d 5b 5d 41 5c 41 5d 41 5e e9 d9 6c 3c ff e8 d4 6c 3c ff 8b 1d
[  353.088719] RSP: 0018:ffff88806d309b70 EFLAGS: 00010046
[  353.089073] RAX: 0000000080010002 RBX: ffff888005b81000 RCX: 0000000000000080
[  353.089548] RDX: 00000000000101f0 RSI: 0000000000000000 RDI: ffff888005b81000
[  353.090033] RBP: 0000000000000080 R08: 0000000000000001 R09: ffffed100da613c4
[  353.090496] R10: 0000000000000003 R11: ffff88806d309ff8 R12: 00000000000101f0
[  353.090965] R13: ffff888003fb0130 R14: 0000000000000000 R15: 00000000000101f0
[  353.091425] FS:  0000000000000000(0000) GS:ffff88806d300000(0000) knlGS:0000000000000000
[  353.091945] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  353.092316] CR2: ffff888005b81000 CR3: 0000000001394004 CR4: 0000000000370ee0
[  353.092777] Call Trace:
[  353.092942]  <IRQ>
[  353.093082]  ? __die+0x1f/0x70
[  353.093299]  ? page_fault_oops+0x2b5/0x840
[  353.093569]  ? __pfx_page_fault_oops+0x10/0x10
[  353.093863]  ? __pfx_is_prefetch.constprop.0+0x10/0x10
[  353.094206]  ? unwind_next_frame+0x2a7/0x2370
[  353.094491]  ? secondary_startup_64_no_verify+0x179/0x17b
[  353.094833]  ? search_module_extables+0x4c/0x110
[  353.095138]  ? ioread32_rep+0x98/0xf0
[  353.095377]  ? fixup_exception+0xfc/0xbc0
[  353.095633]  ? kernelmode_fixup_or_oops+0x1cb/0x240
[  353.095946]  ? __bad_area_nosemaphore+0x29b/0x540
[  353.096245]  ? spurious_kernel_fault+0xda/0x570
[  353.096539]  ? do_kern_addr_fault+0xc4/0xf0
[  353.096808]  ? exc_page_fault+0x10a/0x130
[  353.097073]  ? asm_exc_page_fault+0x26/0x30
[  353.097343]  ? ioread32_rep+0x98/0xf0
[  353.097583]  ata_sff_data_xfer32+0x1bf/0x310
[  353.097861]  ? __pfx_ata_sff_data_xfer32+0x10/0x10
[  353.098166]  ata_pio_xfer+0x15f/0x3d0
[  353.098413]  ata_pio_sector+0x1df/0x740
[  353.098666]  ? load_balance+0x332/0x2000
[  353.098921]  ata_pio_sectors+0x76/0x2f0
[  353.099178]  ata_sff_hsm_move+0x205/0x1fd0
[  353.099446]  ? __queue_work+0x5a9/0xdd0
[  353.099692]  ? __pfx_load_balance+0x10/0x10
[  353.099959]  ? _raw_spin_lock+0x80/0xe0
[  353.100210]  ? ioread8+0x3a/0xb0
[  353.100424]  __ata_sff_port_intr+0x214/0x510
[  353.100703]  ata_bmdma_port_intr+0xa2/0x560
[  353.100974]  ata_bmdma_interrupt+0x24d/0x7b0
[  353.101253]  ? __pfx_ata_bmdma_interrupt+0x10/0x10
[  353.101561]  __handle_irq_event_percpu+0x10d/0x430
[  353.101869]  handle_irq_event+0xaa/0x1d0
[  353.102131]  handle_edge_irq+0x215/0xc60
[  353.102376]  __common_interrupt+0x5b/0x140
[  353.102633]  common_interrupt+0x77/0xa0
[  353.102876]  </IRQ>
[  353.103024]  <TASK>
[  353.103163]  asm_common_interrupt+0x26/0x40
[  353.103425] RIP: 0010:_raw_spin_unlock_irq+0x36/0x60
[  353.103733] Code: 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 0f b6 04 02 48 89 fa 83 e2 07 38 d0 7f 04 84 c0 75 24 c6 07 00 fb 65 ff 0d 12 88 d7 45 <74> 09 48 83 c4 08 c3 cc cc cc cc 0f 1f 44 00 00 48 83 c4 08 c3 cc
[  353.104837] RSP: 0018:ffff88800423fda8 EFLAGS: 00000286
[  353.105162] RAX: 0000000000000000 RBX: 0000000000000040 RCX: ffffffffb909da85
[  353.105591] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff888003eed800
[  353.106020] RBP: ffff888003fb80b8 R08: 0000000000000001 R09: 0000000000005a01
[  353.106451] R10: 0000000000000003 R11: 000000000000019f R12: ffff888003f1f418
[  353.106880] R13: ffff88806d338c40 R14: ffff88806d340000 R15: ffff888003f1f400
[  353.107319]  ? ata_sff_pio_task+0xf5/0x5a0
[  353.107582]  process_one_work+0x872/0x1290
[  353.107842]  worker_thread+0x5a0/0x1170
[  353.108090]  ? __kthread_parkme+0xdc/0x160
[  353.108351]  ? __pfx_worker_thread+0x10/0x10
[  353.108626]  kthread+0x2c7/0x3c0
[  353.108835]  ? __pfx_kthread+0x10/0x10
[  353.109072]  ret_from_fork+0x2c/0x70
[  353.109303]  ? __pfx_kthread+0x10/0x10
[  353.109538]  ret_from_fork_asm+0x1b/0x30
[  353.109789]  </TASK>
[  353.109930] Modules linked in:
[  353.110131] CR2: ffff888005b81000
[  353.110348] ---[ end trace 0000000000000000 ]---
[  353.110633] RIP: 0010:ioread32_rep+0x98/0xf0
[  353.110904] Code: cf 5b 5d 41 5c 41 5d 41 5e e9 04 6d 3c ff e8 ff 6c 3c ff 49 81 fc 00 00 01 00 76 1d e8 f1 6c 3c ff 48 89 df 48 89 e9 44 89 e2 <f3> 6d 5b 5d 41 5c 41 5d 41 5e e9 d9 6c 3c ff e8 d4 6c 3c ff 8b 1d
[  353.112013] RSP: 0018:ffff88806d309b70 EFLAGS: 00010046
[  353.112335] RAX: 0000000080010002 RBX: ffff888005b81000 RCX: 0000000000000080
[  353.112767] RDX: 00000000000101f0 RSI: 0000000000000000 RDI: ffff888005b81000
[  353.113201] RBP: 0000000000000080 R08: 0000000000000001 R09: ffffed100da613c4
[  353.113637] R10: 0000000000000003 R11: ffff88806d309ff8 R12: 00000000000101f0
[  353.114081] R13: ffff888003fb0130 R14: 0000000000000000 R15: 00000000000101f0
[  353.114500] FS:  0000000000000000(0000) GS:ffff88806d300000(0000) knlGS:0000000000000000
[  353.114981] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  353.115325] CR2: ffff888005b81000 CR3: 0000000001394004 CR4: 0000000000370ee0
[  353.115755] Kernel panic - not syncing: Fatal exception in interrupt
[  353.116309] Kernel Offset: 0x36400000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[  353.116943] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---

#2 kernel output on linux master branch (same trigger):

[   31.238379] Adding 124996k swap on ./swap-file.  Priority:0 extents:1 across
2023/11/20 19:51:42 executed programs: 0
[   31.244068] audit: type=1400 audit(1700509902.400:7): avc:  denied  { execme1
[   40.341170] program syz-executor.11 is using a deprecated SCSI ioctl, pleaseO
[   40.367897] program syz-executor.19 is using a deprecated SCSI ioctl, pleaseO
[   40.415859] program syz-executor.13 is using a deprecated SCSI ioctl, pleaseO
[   40.420111] program syz-executor.15 is using a deprecated SCSI ioctl, pleaseO
[   40.472796]  slab kmalloc-256 start ffffa02d83675700 pointer offset 8 size 26
[   40.473387] BUG: kernel NULL pointer dereference, address: 0000000000000000
[   40.473899] #PF: supervisor instruction fetch in kernel mode
[   40.474330] #PF: error_code(0x0010) - not-present page
[   40.474712] PGD 800000010cd3f067 P4D 800000010cd3f067 PUD 1035e9067 PMD 0
[   40.475223] Oops: 0010 [#1] PREEMPT SMP PTI
[   40.475539] CPU: 1 PID: 9080 Comm: syz-executor.15 Not tainted 6.7.0-rc2 #1
[   40.476127] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.154
[   40.476886] RIP: 0010:0x0
[   40.477151] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[   40.477747] RSP: 0000:ffffa31f000d0f30 EFLAGS: 00010292
[   40.478226] RAX: 0000000000000001 RBX: ffffa02fb3d2d080 RCX: ffffa02d83675708
[   40.478863] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffa02d83675708
[   40.479505] RBP: 0000000000000007 R08: 0000000000000000 R09: 205d363937323734
[   40.480144] R10: ffffa02d83675d00 R11: 3338643230617320 R12: 0000000000000006
[   40.480798] R13: ffffa02fb3d2d0f8 R14: 000000000000000a R15: 0000000000000000
[   40.481479] FS:  00005555560f2480(0000) GS:ffffa02fb3d00000(0000) knlGS:00000
[   40.482558] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   40.483326] CR2: ffffffffffffffd6 CR3: 0000000105808000 CR4: 00000000000006f0
[   40.484261] Call Trace:
[   40.484636]  <IRQ>
[   40.484935]  ? show_regs+0x64/0x70
[   40.485451]  ? __die_body+0x1a/0x60
[   40.485819]  ? page_fault_oops+0x1bf/0x540
[   40.486240]  ? vprintk+0x62/0x70
[   40.486764]  ? do_user_addr_fault+0x42f/0xa60
[   40.487517]  ? exc_page_fault+0x7f/0x1c0
[   40.488162]  ? asm_exc_page_fault+0x22/0x30
[   40.488845]  rcu_core+0x27e/0xa00
[   40.489396]  __do_softirq+0xb4/0x2b2
[   40.489971]  irq_exit_rcu+0x61/0x80
[   40.490536]  sysvec_apic_timer_interrupt+0x49/0x80
[   40.491295]  </IRQ>
[   40.491644]  <TASK>
[   40.491993]  asm_sysvec_apic_timer_interrupt+0x16/0x20
[   40.492824] RIP: 0010:__sanitizer_cov_trace_pc+0x31/0x70
[   40.493682] Code: 02 00 65 8b 15 88 e6 27 6f f7 c2 00 01 ff 00 48 8b 0c 24 78
[   40.496541] RSP: 0000:ffffa31f02167da0 EFLAGS: 00000246
[   40.497367] RAX: ffffa02d886d5880 RBX: 0000000000000001 RCX: ffffffff91e9d01d
[   40.498445] RDX: 0000000000000000 RSI: ffffa31f02167e60 RDI: ffffa02d85a2f4c0
[   40.499521] RBP: 00007f5261821fff R08: 0000000000000000 R09: 0000000000000000
[   40.500710] R10: 0000000000000000 R11: 0000000000000000 R12: ffffa02d88798600
[   40.501919] R13: 0000000000000000 R14: ffffa02d8879860c R15: ffffa02d8307b450
[   40.503068]  ? mt_find+0x35d/0x5d0
[   40.503639]  mt_find+0x35d/0x5d0
[   40.504180]  find_vma+0x38/0x60
[   40.504717]  lock_mm_and_find_vma+0x49/0x320
[   40.505405]  do_user_addr_fault+0x174/0xa60
[   40.506076]  exc_page_fault+0x7f/0x1c0
[   40.506677]  asm_exc_page_fault+0x22/0x30
[   40.507327] RIP: 0033:0x7f526178255f
[   40.507911] Code: 48 01 d8 8b 54 24 58 4c 89 de 0f 29 44 24 40 48 89 c7 e8 99
[   40.510773] RSP: 002b:00007fff6dde4cc0 EFLAGS: 00010246
[   40.511594] RAX: 00007f52612f1000 RBX: 0000000000001000 RCX: 00007f52617c1deb
[   40.512752] RDX: 0000000000000003 RSI: 0000000000020000 RDI: 00007f52612f2000
[   40.513857] RBP: 00007f5261311640 R08: 00000000ffffffff R09: 0000000000000000
[   40.514966] R10: ffffffffffffffc0 R11: 0000000000000206 R12: 0000000000000000
[   40.516107] R13: 00007fff6dde4f70 R14: 0000000000021000 R15: 0000000000000000
[   40.517290]  </TASK>
[   40.517653] Modules linked in:
[   40.518152] CR2: 0000000000000000
[   40.518693] ---[ end trace 0000000000000000 ]---
[   40.519430] RIP: 0010:0x0
[   40.519868] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[   40.520915] RSP: 0000:ffffa31f000d0f30 EFLAGS: 00010292
[   40.521737] RAX: 0000000000000001 RBX: ffffa02fb3d2d080 RCX: ffffa02d83675708
[   40.522868] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffa02d83675708
[   40.523976] RBP: 0000000000000007 R08: 0000000000000000 R09: 205d363937323734
[   40.525099] R10: ffffa02d83675d00 R11: 3338643230617320 R12: 0000000000000006
[   40.526220] R13: ffffa02fb3d2d0f8 R14: 000000000000000a R15: 0000000000000000
[   40.527341] FS:  00005555560f2480(0000) GS:ffffa02fb3d00000(0000) knlGS:00000
[   40.528619] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   40.529567] CR2: ffffffffffffffd6 CR3: 0000000105808000 CR4: 00000000000006f0
[   40.530606] Kernel panic - not syncing: Fatal exception in interrupt
[   40.531991] Kernel Offset: 0xfc00000 from 0xffffffff81000000 (relocation ran)
[   40.533602] ---[ end Kernel panic - not syncing: Fatal exception in interrup-

If there's anything else I can help - let me know!

Best regards,
-- 
Vlatko Kosturjak - KoSt
