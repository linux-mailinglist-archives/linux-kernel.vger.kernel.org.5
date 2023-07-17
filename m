Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80EAC756064
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 12:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjGQK2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 06:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjGQK2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 06:28:18 -0400
Received: from mail.a-eberle.de (mail.a-eberle.de [213.95.140.213])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F23E51
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 03:28:15 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.a-eberle.de (Postfix) with ESMTP id A21EB38059E
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 12:28:03 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aeberle-mx.softwerk.noris.de
Received: from mail.a-eberle.de ([127.0.0.1])
        by localhost (ebl-mx-02.a-eberle.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id slDjh12f5ixw for <linux-kernel@vger.kernel.org>;
        Mon, 17 Jul 2023 12:28:02 +0200 (CEST)
Received: from gateway.a-eberle.de (unknown [178.15.155.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "sg310.eberle.local", Issuer "A. Eberle GmbH & Co. KG WebAdmin CA" (not verified))
        (Authenticated sender: postmaster@a-eberle.de)
        by mail.a-eberle.de (Postfix) with ESMTPSA
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 12:28:02 +0200 (CEST)
Received: from svr-exch2019.eberle.local ([192.168.1.17]:35981 helo=webmail.a-eberle.de)
        by gateway.a-eberle.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <Stephan.Wurm@a-eberle.de>)
        id 1qLLSS-0003D8-1B;
        Mon, 17 Jul 2023 12:28:00 +0200
Received: from PC-LX-Wurm (10.10.30.11) by Svr-Exch2019.eberle.local
 (192.168.1.17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 17 Jul
 2023 12:28:00 +0200
Date:   Mon, 17 Jul 2023 12:27:58 +0200
From:   Stephan Wurm <stephan.wurm@a-eberle.de>
To:     Richard Weinberger <richard@nod.at>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Johannes Eigner <johannes.eigner@a-eberle.de>
Subject: Re: ubiblock: null pointer dereference using scatterlist in
 work_queue
Message-ID: <ZLUXruUkYMrPK+GQ@PC-LX-Wurm>
References: <ZLT2qEYjaWgSpRD6@PC-LX-Wurm>
 <736980270.3262.1689586950735.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <736980270.3262.1689586950735.JavaMail.zimbra@nod.at>
X-Originating-IP: [10.10.30.11]
X-ClientProxiedBy: Svr-Exch2019.eberle.local (192.168.1.17) To
 Svr-Exch2019.eberle.local (192.168.1.17)
X-EsetResult: clean, is OK
X-EsetId: 37303A298E357D5B67756B
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Richard,

Am 23-07-17 11:42 schrieb Richard Weinberger:
> Stephan,
>
> ----- Ursprüngliche Mail -----
> > Von: "Stephan Wurm" <stephan.wurm@a-eberle.de>
> >  [   26.127460] 8<--- cut here ---
> >  [   26.130689] Unable to handle kernel NULL pointer dereference at virtual
> >  address 00000000
> >  [   26.138886] [00000000] *pgd=00000000
> >  [   26.142523] Internal error: Oops: 5 [#1] ARM
> >  [   26.146804] Modules linked in:
> >  [   26.149868] CPU: 0 PID: 18 Comm: kworker/0:3 Not tainted 6.1.38 #1
> >  [   26.156060] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> >  [   26.162592] Workqueue: ubiblock0_2 ubiblock_do_work
> >  [   26.167498] PC is at ubi_io_read+0x78/0x2fc
> >  [   26.171693] LR is at ubi_eba_read_leb+0xe8/0x4a4
> >  [   26.176320] pc : [<c075f508>]    lr : [<c075cd0c>]    psr: 60070013
> >  [   26.182591] sp : f0961dc8  ip : 00000000  fp : 00002000
> >  [   26.187819] r10: c81c6000  r9 : 00000000  r8 : c81c7000
> >  [   26.193046] r7 : 00000200  r6 : 000008e0  r5 : 00002000  r4 : 00000000
> >  [   26.199578] r3 : 00000000  r2 : 00000000  r1 : 00000000  r0 : c81c6000
> >  [   26.206108] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> >  [   26.213250] Control: 10c53c7d  Table: 1824c059  DAC: 00000051
> >  [   26.218998] Register r0 information: slab kmalloc-8k start c81c6000 pointer
> >  offset 0 size 8192
> >  [   26.227638] Register r1 information: NULL pointer
> >  [   26.232352] Register r2 information: NULL pointer
> >  [   26.237062] Register r3 information: NULL pointer
> >  [   26.241772] Register r4 information: NULL pointer
> >  [   26.246481] Register r5 information: non-paged memory
> >  [   26.251537] Register r6 information: non-paged memory
> >  [   26.256594] Register r7 information: non-paged memory
> >  [   26.261651] Register r8 information: slab kmalloc-8k start c81c6000 pointer
> >  offset 4096 size 8192
> >  [   26.270545] Register r9 information: NULL pointer
> >  [   26.275254] Register r10 information: slab kmalloc-8k start c81c6000 pointer
> >  offset 0 size 8192
> >  [   26.283977] Register r11 information: non-paged memory
> >  [   26.289120] Register r12 information: NULL pointer
> >  [   26.293916] Process kworker/0:3 (pid: 18, stack limit = 0x1a047662)
> >  [   26.300194] Stack: (0xf0961dc8 to 0xf0962000)
> >  [   26.304559] 1dc0:                   c1d50ec0 c075cc64 00000001 00000000
> >  00000000 c1d50ec0
> >  [   26.312744] 1de0: 00000001 24c676fe c075cc64 00000000 000008e0 c81c6000
> >  c80c4000 00000000
> >  [   26.320928] 1e00: c1d50ec0 00000002 c81c7000 c075cd0c 00000200 c01d3930
> >  60070013 00000000
> >  [   26.329111] 1e20: 60070013 c1b43208 000008e0 24c676fe 00000000 c830f5cc
> >  c830f5cc 00000200
> >  [   26.337294] 1e40: 00000000 00000001 00000200 c80c4000 00000000 c075d124
> >  00000000 00000200
> >  [   26.345477] 1e60: 00000000 c13e0ec0 c81c6000 c1d50ec0 00000000 00000000
> >  00000000 c80c4000
> >  [   26.353661] 1e80: c830f5cc c1e52c00 00000200 c81c6000 00000002 c075b748
> >  00000000 00000200
> >  [   26.361844] 1ea0: 00000000 c1312e58 ef7d3c00 0003e000 00000000 00000200
> >  ef7d3c00 c1e52c00
> >  [   26.370027] 1ec0: c830f5a8 c830f5cc 00000000 c076b228 00000200 00000000
> >  c830f500 c1d50ec0
> >  [   26.378211] 1ee0: c830f5d4 24c676fe c0c0e608 c830f5a8 c1ed3800 c1312e58
> >  ef7d3c00 c1d50ec0
> >  [   26.386394] 1f00: 00000000 c14e59c0 ef7d3c05 c013c06c 00000001 00000000
> >  c013bff4 00000000
> >  [   26.394577] 1f20: c1312e68 24c676fe c1b5f698 c19642b8 00000000 c101b390
> >  00000000 24c676fe
> >  [   26.402760] 1f40: c1d50ec0 c1ed3800 c1312e58 c1ed3818 c1312e94 c13dfc30
> >  c1d50ec0 00000008
> >  [   26.410944] 1f60: c1312e58 c013c3f0 00000000 c1f16880 c1d50ec0 c013c3b0
> >  c1ed3800 c1ed3880
> >  [   26.419126] 1f80: f095de9c 00000000 00000000 c0143654 c1f16880 c0143588
> >  00000000 00000000
> >  [   26.427309] 1fa0: 00000000 00000000 00000000 c0100128 00000000 00000000
> >  00000000 00000000
> >  [   26.435491] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000
> >  00000000 00000000
> >  [   26.443673] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> >  00000000 00000000
> >  [   26.451855]  ubi_io_read from ubi_eba_read_leb+0xe8/0x4a4
> >  [   26.457277]  ubi_eba_read_leb from ubi_eba_read_leb_sg+0x5c/0x154
> >  [   26.463390]  ubi_eba_read_leb_sg from ubi_leb_read_sg+0x70/0xb0
> >  [   26.469325]  ubi_leb_read_sg from ubiblock_do_work+0x104/0x238
> >  [   26.475180]  ubiblock_do_work from process_one_work+0x238/0x57c
> >  [   26.481130]  process_one_work from worker_thread+0x40/0x4f8
> >  [   26.486724]  worker_thread from kthread+0xcc/0xf0
> >  [   26.491449]  kthread from ret_from_fork+0x14/0x2c
> >  [   26.496168] Exception stack(0xf0961fb0 to 0xf0961ff8)
> >  [   26.501225] 1fa0:                                     00000000 00000000
> >  00000000 00000000
> >  [   26.509410] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000
> >  00000000 00000000
> >  [   26.517592] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> >  [   26.524215] Code: 1a000041 e59d2010 e1a09fc5 e1a0b005 (e5d23000)
> >  [   26.530367] ---[ end trace 0000000000000000 ]---
> >
> > This kernel Oops happens both on patched or vanilla kernels, of which we tried
> > several releases in 5.15.y and 6.1.y branches. We also tried with several of
> > our devices.
> > Upgrading to the latest mainline kernel did not work out-of-the-box, hence we
> > did not follow that track (yet).
> >
> > We tried with full debugging output for the whole ubi driver and used several
> > additional printks. That way we were able to see, that the first scatterlist
> > entry already pointed to virtual address zero when the first read request
> > caused by cryptsetup was added to ubiblock's work_queue.
> >
> >  sg_virt(pdu->usgl.sg[0]) => page_address(sg) => 0x0000000
> >
> > We also tried to use hw_breakpoints to gather more information on (maybe)
> > another module interfering, but did not succeed (yet).
> >
> > But we were not able to narrow down the root cause until now.
> >
> >
> > As an additional twist, the system is able to boot when we mount the ubiblock
> > root filesystem without calling cryptsetup, hence skipping the dm-verity hash
> > verification. And we can verify the root filesystem with cryptsetup once the
> > system boot is finished.
> >
> > It is also possible to boot the same system image, including dm-verity, when
> > using a sdcard instead of the nand flash. Loading the FIT from sdcard but
> > calling cryptsetup on the ubiblock device again leads to the described oops.
> >
> >
> > Is there something we have overlooked?
> > Do you have further ideas to get behind this issue?
>
> So reading from ubiblock works as long you don't access it via dm-verity?
> How about other stacked devices such as dmcrypt?

We did not check other stacked devices, but we'll give this a try.

> Did you print the LEB number, read length and offset in ubiblock_read()?
> Maybe there is a bug related to setting up the correct device geometry
> and the read request is off.
Here is some excerpt from another try with KASAN enabled and full debug output:

  [  209.245803] UBI DBG wl (pid 1): found 4092 PEBs
  [  209.250945] UBI DBG eba (pid 1): initialize EBA sub-system
  [  209.257413] UBI DBG eba (pid 1): EBA sub-system is initialized
  [  209.352714] UBI DBG gen (pid 1): ubi0 major is 242
  [  209.361776] UBI DBG gen (pid 1): add volume 0
  [  209.368616] UBI DBG gen (pid 1): add volume 1
  [  209.375056] UBI DBG gen (pid 1): add volume 2
  [  209.381827] UBI DBG gen (pid 1): add volume 3
  [  209.388304] UBI DBG gen (pid 1): add volume 4
  [  209.398847] ubi0: attached mtd0 (name "nand", size 1024 MiB)
  [  209.404592] ubi0: PEB size: 262144 bytes (256 KiB), LEB size: 253952 bytes
  [  209.411626] ubi0: min./max. I/O unit sizes: 4096/4096, sub-page size 4096
  [  209.418668] ubi0: VID header offset: 4096 (aligned 4096), data offset: 8192
  [  209.425703] ubi0: good PEBs: 4092, bad PEBs: 4, corrupted PEBs: 0
  [  209.431931] ubi0: user volume: 5, internal volumes: 1, max. volumes count: 128
  [  209.439287] ubi0: max/mean erase counter: 56/30, WL threshold: 4096, image sequence number: 588826929
  [  209.448683] ubi0: available PEBs: 177, total reserved PEBs: 3915, PEBs reserved for bad PEB handling: 76
  [  209.458803] ubi0: background thread "ubi_bgt0d" started, PID 165
  [  209.465455] UBI DBG gen (pid 1): open device 0, volume root0, mode 1
  [  209.472714] UBI DBG gen (pid 1): open device 0, volume 2, mode 1
  [  209.480921] UBI DBG eba (pid 1): read 253952 bytes from offset 0 of LEB 2:0, PEB 3375
  [  209.499763] UBI DBG io (pid 1): read VID header from PEB 3375
  [  209.505581] UBI DBG io (pid 1): read 64 bytes from PEB 3375:4096
  [  209.512950] UBI DBG io (pid 1): read 253952 bytes from PEB 3375:8192
  [  209.540198] UBI DBG eba (pid 1): read 253952 bytes from offset 0 of LEB 2:1, PEB 3376
  [  209.548281] UBI DBG io (pid 1): read VID header from PEB 3376
  [  209.554096] UBI DBG io (pid 1): read 64 bytes from PEB 3376:4096
  [  209.560827] UBI DBG io (pid 1): read 253952 bytes from PEB 3376:8192
  [  209.587543] UBI DBG eba (pid 1): read 253952 bytes from offset 0 of LEB 2:2, PEB 3377

...

  [  291.514980] UBI DBG gen (pid 280): read 1024 bytes from offset 2048 of volume 2
  [  291.523198] UBI DBG eba (pid 280): read 1024 bytes from offset 2048 of LEB 2:0, PEB 3375
  [  291.541721] UBI DBG io (pid 280): read 1024 bytes from PEB 3375:10240
  [  291.549183] UBI DBG gen (pid 280): read 1024 bytes from offset 2097152 of volume 2
  [  291.557402] UBI DBG eba (pid 280): read 1024 bytes from offset 65536 of LEB 2:8, PEB 3383
  [  291.565881] UBI DBG io (pid 280): read 1024 bytes from PEB 3383:73728
  [  291.632851] UBI DBG gen (pid 280): release device 0, volume 2, mode 1
  [  291.639609] UBI DBG gen (pid 280): close device 0, volume 2, mode 1
  realpath: /dev/disk/by-partuuid//dev/ubiblock0_2: No such file or directory
  [  293.065904] UBI DBG gen (pid 302): open device 0, volume 2, mode 1
  [  293.075832] UBI DBG gen (pid 18): read 512 bytes from LEB 2:0:0
  [  293.082685] UBI DBG eba (pid 18): read 512 bytes from offset 0 of LEB 2:0, PEB 3375
  [  293.208348] UBI DBG io (pid 18): read 512 bytes from PEB 3375:8192
  [  293.336418] ==================================================================
  [  293.343675] BUG: KASAN: null-ptr-deref in ubi_io_read+0x1d4/0x46c
  [  293.349822] Read of size 1 at addr 00000000 by task kworker/0:3/18
  [  293.356037]
  [  293.357551] CPU: 0 PID: 18 Comm: kworker/0:3 Not tainted 6.1.36 #1
  [  293.363774] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
  [  293.370331] Workqueue: ubiblock0_2 ubiblock_do_work
  [  293.375269]  unwind_backtrace from show_stack+0x10/0x14
  [  293.380557]  show_stack from dump_stack_lvl+0x34/0x48
  [  293.385668]  dump_stack_lvl from kasan_report+0xb8/0xe8
  [  293.390956]  kasan_report from ubi_io_read+0x1d4/0x46c
  [  293.396146]  ubi_io_read from ubi_eba_read_leb+0x3c4/0x5cc
  [  293.401686]  ubi_eba_read_leb from ubi_eba_read_leb_sg+0x84/0x1f8
  [  293.407831]  ubi_eba_read_leb_sg from ubi_leb_read_sg+0xb4/0x110
  [  293.413891]  ubi_leb_read_sg from ubiblock_do_work+0x180/0x390
  [  293.419779]  ubiblock_do_work from process_one_work+0x46c/0x98c
  [  293.425763]  process_one_work from worker_thread+0x7c/0x7a8
  [  293.431400]  worker_thread from kthread+0x158/0x180
  [  293.436340]  kthread from ret_from_fork+0x14/0x2c
  [  293.441094] Exception stack(0xf09a3fb0 to 0xf09a3ff8)
  [  293.446184] 3fa0:                                     00000000 00000000 00000000 00000000
  [  293.454402] 3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
  [  293.462616] 3fe0: 00000000 00000000 00000000 00000000 00000013 00000000
  [  293.469263] ==================================================================
  [  293.476593] Disabling lock debugging due to kernel taint
  [  293.481975] 8<--- cut here ---
  [  293.485057] Unable to handle kernel NULL pointer dereference at virtual address 00000000
  [  293.493209] [00000000] *pgd=00000000
  [  293.496837] Internal error: Oops: 5 [#1] ARM
  [  293.501141] Modules linked in:
  [  293.504232] CPU: 0 PID: 18 Comm: kworker/0:3 Tainted: G    B              6.1.36 #1
  [  293.511927] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
  [  293.518481] Workqueue: ubiblock0_2 ubiblock_do_work
  [  293.523415] PC is at ubi_io_read+0x1d4/0x46c
  [  293.527729] LR is at kasan_report+0xc4/0xe8
  [  293.531948] pc : [<c11441d8>]    lr : [<c030d198>]    psr: 60070013
  [  293.538244] sp : f09a3b20  ip : 00000000  fp : 00000000
  [  293.543496] r10: c3581338  r9 : 00000200  r8 : 00002000
  [  293.548748] r7 : c3580f40  r6 : 00000d2f  r5 : c3588000  r4 : c26631a0
  [  293.555305] r3 : 00000000  r2 : c3580f40  r1 : c1fd3240  r0 : 00000001
  [  293.561861] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
  [  293.569032] Control: 10c53c7d  Table: 150dc059  DAC: 00000051
  [  293.574801] Register r0 information: non-paged memory
  [  293.579894] Register r1 information: non-slab/vmalloc memory
  [  293.585594] Register r2 information: slab task_struct start c3580f40 pointer offset 0
  [  293.593507] Register r3 information: NULL pointer
  [  293.598249] Register r4 information: non-slab/vmalloc memory
  [  293.603947] Register r5 information: slab kmalloc-8k start c3588000 pointer offset 0 size 8192
  [  293.612650] Register r6 information: non-paged memory
  [  293.617739] Register r7 information: slab task_struct start c3580f40 pointer offset 0
  [  293.625644] Register r8 information: non-paged memory
  [  293.630733] Register r9 information: non-paged memory
  [  293.635821] Register r10 information: slab task_struct start c3580f40 pointer offset 1016
  [  293.644075] Register r11 information: NULL pointer
  [  293.648905] Register r12 information: NULL pointer
  [  293.653732] Process kworker/0:3 (pid: 18, stack limit = 0xb1726ef2)
  [  293.660033] Stack: (0xf09a3b20 to 0xf09a4000)
  [  293.664434] 3b20: 00002000 00000200 c0a66714 f09a3b80 c3581590 f09a3bc0 c3589144 08e5cad6
  [  293.672653] 3b40: 41b58ab3 1e13476c c0a6feac 73395f12 f09a3fac c3580f40 c0100bd8 c3580f44
  [  293.680872] 3b60: 41b58ab3 c18a485c c1144004 c022c030 f09a3bf0 c115214c 60070013 ffffffff
  [  293.689089] 3b80: c147fc20 f09a3b70 c115214c 60070013 ffffffff c0100bd8 03d21031 03d21031
  [  293.697306] 3ba0: 00000001 000055b9 c168a0e0 60070013 00000000 00000000 f09a3ca0 c3580f40
  [  293.705523] 3bc0: 00000002 00000d2f c2447ed4 73395f12 c1152384 bd134788 c60c4800 c3588000
  [  293.713738] 3be0: 00000000 f09a3ca0 c3580f40 00000002 00000d2f c0a668d8 00000200 00000000
  [  293.721954] 3c00: 00000000 00000200 00000000 00000000 c3581338 00000006 00000007 c60c4af4
  [  293.730172] 3c20: c61700cc c0189714 c3580f40 c1b394b8 c3581590 00000000 16a24451 1866687e
  [  293.738389] 3c40: 41b58ab3 c18a4774 c0a66514 00000000 00000200 c3580f40 c1161810 c3580f44
  [  293.746606] 3c60: 00000d2f c1fc6940 c262e2a0 c022c030 00000001 60070013 c262e988 c262e980
  [  293.754823] 3c80: c262e988 60070013 60070013 c262e988 c262e980 c11617fc 00000000 73395f12
  [  293.763040] 3ca0: c262e980 c61700cc 00000200 00000000 00000200 c61700d0 00000001 00000000
  [  293.771256] 3cc0: 00000000 c0a66b64 00000000 00000200 00000000 c067f654 00000200 c3588000
  [  293.779472] 3ce0: c60c4800 00000000 c3580f40 c3581338 00000000 c60c4800 00000000 00000000
  [  293.787688] 3d00: 00000200 00000000 c61700cc c3588000 00000002 c1142ce4 00000000 00000200
  [  293.795904] 3d20: 00000000 efff6ea0 00000000 c3580f40 00000000 0003e000 00000200 c5becc00
  [  293.804120] 3d40: c61700a8 c61700cc 00000000 00000000 00000000 c0a764fc 00000200 00000000
  [  293.812337] 3d60: 41b58ab3 c182c6ac c018da1c 73395f12 600d0193 c6170000 c3580f40 bd1347b4
  [  293.820554] 3d80: 41b58ab3 c182c6d0 c018ddf8 c01843e8 00000001 0000aabf c35815a0 c01896c4
  [  293.828771] 3da0: 41b58ab3 c18a4dec c0a7637c c01896c4 c3580f40 c1b394b8 c3581590 00000000
  [  293.836989] 3dc0: c61700d4 ffffffff c1b2ace8 c01898c0 c5bedcc0 c5bedcb8 c3529a48 c3580f40
  [  293.845206] 3de0: c11617a4 c018e104 c1c2a0a0 c1fc6940 c1b2ace8 c022c030 00000001 73395f12
  [  293.853422] 3e00: c3529a00 c61700a8 c3529a00 c1b2acac e9761800 c1fc5f80 00000000 c3580f44
  [  293.861640] 3e20: c3529a0c c01537a8 00000001 00000000 c0153708 c0153e04 00000000 c3580f40
  [  293.869857] 3e40: e9761804 00000000 f09a3ea0 bd1347d0 c3529a14 c3529a10 e9761805 c3529a08
  [  293.878073] 3e60: c3529a04 c3529a24 c018ddf8 00000000 00000006 f09a3ee0 c3581590 00000000
  [  293.886291] 3e80: 41b58ab3 c18286f0 c015333c c01898c0 c0100bd8 c3580f44 c1c2a0a0 c3580f40
  [  293.894508] 3ea0: c2663320 c244b4f4 00000000 c1488f20 00000000 c022c030 00000000 c01896c4
  [  293.902725] 3ec0: c3580f40 c1b394b8 c3581590 00000000 ffffffff c018e104 c1b2acac c01898c0
  [  293.910942] 3ee0: ffffffff ffffffff 00000001 73395f12 c11617a4 c1b2acac c0153e04 c3580f40
  [  293.919160] 3f00: 00000008 c0153cc8 c3529a00 73395f12 c5b4ed74 c61700ac c3529a18 fffffd4a
  [  293.927378] 3f20: 00000008 c0153cc8 c3529a00 c1b2acac c61700a8 c0153d44 c1b2ace8 c1b2ace0
  [  293.935596] 3f40: c1b2ace4 c3529a34 c3580f40 c3529a24 c3529a20 c3529b00 c3529a1c c358114c
  [  293.943813] 3f60: 00000000 c3580f40 c3580f44 c1b09aac c3529b00 c0153cc8 c3529a00 00000000
  [  293.952028] 3f80: f099bd10 c015e298 00000000 c352b480 c015e140 00000000 00000000 00000000
  [  293.960242] 3fa0: 00000000 00000000 00000000 c0100128 00000000 00000000 00000000 00000000
  [  293.968457] 3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
  [  293.976670] 3fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
  [  293.984878]  ubi_io_read from ubi_eba_read_leb+0x3c4/0x5cc
  [  293.990424]  ubi_eba_read_leb from ubi_eba_read_leb_sg+0x84/0x1f8
  [  293.996572]  ubi_eba_read_leb_sg from ubi_leb_read_sg+0xb4/0x110
  [  294.002631]  ubi_leb_read_sg from ubiblock_do_work+0x180/0x390
  [  294.008519]  ubiblock_do_work from process_one_work+0x46c/0x98c
  [  294.014506]  process_one_work from worker_thread+0x7c/0x7a8
  [  294.020144]  worker_thread from kthread+0x158/0x180
  [  294.025083]  kthread from ret_from_fork+0x14/0x2c
  [  294.029836] Exception stack(0xf09a3fb0 to 0xf09a3ff8)
  [  294.034922] 3fa0:                                     00000000 00000000 00000000 00000000
  [  294.043136] 3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
  [  294.051348] 3fe0: 00000000 00000000 00000000 00000000 00000013 00000000
  [  294.057999] Code: 1a00008b eaffffee e1a0000b ebc724e1 (e5db3000)
  [  294.064308] ---[ end trace 0000000000000000 ]---


Thanks
--
Stephan Wurm <stephan.wurm@a-eberle.de>
