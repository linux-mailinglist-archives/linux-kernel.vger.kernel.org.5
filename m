Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F200F77325E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 00:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjHGWEu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 7 Aug 2023 18:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbjHGWDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 18:03:50 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F58A94;
        Mon,  7 Aug 2023 15:03:05 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id BD67B63577D6;
        Tue,  8 Aug 2023 00:02:57 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id tpoLrQd4pfz3; Tue,  8 Aug 2023 00:02:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id B2B1B63577FF;
        Tue,  8 Aug 2023 00:02:56 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qgs94gWCRPLt; Tue,  8 Aug 2023 00:02:56 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 8BD4363577D6;
        Tue,  8 Aug 2023 00:02:56 +0200 (CEST)
Date:   Tue, 8 Aug 2023 00:02:56 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-block <linux-block@vger.kernel.org>, hch <hch@lst.de>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Johannes Eigner <johannes.eigner@a-eberle.de>,
        Stephan Wurm <stephan.wurm@a-eberle.de>
Message-ID: <1293911429.1782934.1691445776353.JavaMail.zimbra@nod.at>
In-Reply-To: <ZLT2qEYjaWgSpRD6@PC-LX-Wurm>
References: <ZLT2qEYjaWgSpRD6@PC-LX-Wurm>
Subject: Re: ubiblock: null pointer dereference using scatterlist in
 work_queue
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: ubiblock: null pointer dereference using scatterlist in work_queue
Thread-Index: 8N4LmBsHcBkyrt18WpJidu8N/tm5rA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Replying with full context for block layer folks]

Stephan reported that ubiblock causes a NULL pointer dereference on his system
as soon a DM is configured above. He reproduced with both dmcrypt and dm-verity.

The NULL pointer dereference happens in ubi_eba_read_leb_sg() because sg_virt()
returns NULL. I'm a bit puzzled why.

We checked that the sg list is not empty and that blk_rq_map_sg() returns a
positive number. So, sg_set_page() should have happened.
From the logs it seems also that the first few reads from the kernel succeed,
I guess the partition scan, but as soon cryptsetup triggers a read from userspace
the crash happens. It happens always, so it does not look like a random memory
corruption.
Enabling CONFIG_DEBUG_SG does also not indicate a bug.

Do you have an idea what could case this problem? Is the usage of sg_virt() in UBI
wrong?
ubiblock exists now for some time and is heavily used with dmcrypt on similar devices.
Also backporting 91cc8fbcc8c7 ("ubi: block: set BLK_MQ_F_BLOCKING") to Stephan's 6.1
kernel didn't change the symptoms.

Thanks,
//richard

----- Ursprüngliche Mail -----
> Von: "Stephan Wurm" <stephan.wurm@a-eberle.de>
> An: "richard" <richard@nod.at>, "Miquel Raynal" <miquel.raynal@bootlin.com>, "Vignesh Raghavendra" <vigneshr@ti.com>,
> "linux-mtd" <linux-mtd@lists.infradead.org>, "linux-kernel" <linux-kernel@vger.kernel.org>
> CC: "Johannes Eigner" <johannes.eigner@a-eberle.de>
> Gesendet: Montag, 17. Juli 2023 10:07:04
> Betreff: ubiblock: null pointer dereference using scatterlist in work_queue

> Hello!
> 
> We struggle with a weird problem accessing an ubiblock device for quite some
> time now. As we are running out of ideas, I reach out for your help.
> 
> The device we develop has an i.MX6 Solo SoC equipped with gpmi-nand flash
> (Micron MT29F8G08ABACA, 1GB). The flash is partitioned into five UBI volumes,
> forming an A/B boot setup, consisting of two pairs with each a UBIFS volume
> holding a FIT image and a ubiblock volume containing a SQUASHFS root filesystem
> with dm-verity hashes attached, and the fifth UBIFS volume for common data.
> The bootloader (barebox 2022.06.0) is stored on an additional spi-nor flash.
> 
> In order to mount the root filesystem, the FIT image contains an initramfs,
> calling cryptsetup (tried v2.4.3 and v2.6.1) on the ubiblock device,
> followed by mount of the root filesystem.
> MTD attach and creation of the ubiblock device is triggered by kernel
> arguments:
> 
>  commandline: console=ttymxc1,115200n8   ubi.block=0,root0 root=/dev/ubiblock0_2
>  rootfstype=squashfs ubi.mtd=nand
> 
> This fails to boot with a null pointer dereference when calling cryptsetup:
> 
>  [    5.637207] ubi0: default fastmap pool size: 200
>  [    5.642020] ubi0: default fastmap WL pool size: 100
>  [    5.647000] ubi0: attaching mtd0
>  [    6.450307] ubi0: scanning is finished
>  [    6.472816] ubi0: attached mtd0 (name "nand", size 1024 MiB)
>  [    6.478561] ubi0: PEB size: 262144 bytes (256 KiB), LEB size: 253952 bytes
>  [    6.485508] ubi0: min./max. I/O unit sizes: 4096/4096, sub-page size 4096
>  [    6.492395] ubi0: VID header offset: 4096 (aligned 4096), data offset: 8192
>  [    6.499378] ubi0: good PEBs: 4092, bad PEBs: 4, corrupted PEBs: 0
>  [    6.505518] ubi0: user volume: 5, internal volumes: 1, max. volumes count:
>  128
>  [    6.512810] ubi0: max/mean erase counter: 14/8, WL threshold: 4096, image
>  sequence number: 228025450
>  [    6.521965] ubi0: available PEBs: 177, total reserved PEBs: 3915, PEBs
>  reserved for bad PEB handling: 76
>  [    6.531750] ubi0: background thread "ubi_bgt0d" started, PID 163
>  [   12.919477] block ubiblock0_2: created from ubi0:2(root0)
>  [   12.929687] ALSA device list:
>  [   12.932750]   #0: sgtl5000
>  [   12.940024] Freeing unused kernel image (initmem) memory: 1024K
>  [   12.946926] Run /init as init process
>  Starting version 250.5+
>  [   15.601749] mtdblock: MTD device 'nand' is NAND, please consider using UBI
>  block devices instead.
>  realpath: /dev/disk/by-partuuid//dev/ubiblock0_2: No such file or directory
>  [   26.127460] 8<--- cut here ---
>  [   26.130689] Unable to handle kernel NULL pointer dereference at virtual
>  address 00000000
>  [   26.138886] [00000000] *pgd=00000000
>  [   26.142523] Internal error: Oops: 5 [#1] ARM
>  [   26.146804] Modules linked in:
>  [   26.149868] CPU: 0 PID: 18 Comm: kworker/0:3 Not tainted 6.1.38 #1
>  [   26.156060] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
>  [   26.162592] Workqueue: ubiblock0_2 ubiblock_do_work
>  [   26.167498] PC is at ubi_io_read+0x78/0x2fc
>  [   26.171693] LR is at ubi_eba_read_leb+0xe8/0x4a4
>  [   26.176320] pc : [<c075f508>]    lr : [<c075cd0c>]    psr: 60070013
>  [   26.182591] sp : f0961dc8  ip : 00000000  fp : 00002000
>  [   26.187819] r10: c81c6000  r9 : 00000000  r8 : c81c7000
>  [   26.193046] r7 : 00000200  r6 : 000008e0  r5 : 00002000  r4 : 00000000
>  [   26.199578] r3 : 00000000  r2 : 00000000  r1 : 00000000  r0 : c81c6000
>  [   26.206108] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
>  [   26.213250] Control: 10c53c7d  Table: 1824c059  DAC: 00000051
>  [   26.218998] Register r0 information: slab kmalloc-8k start c81c6000 pointer
>  offset 0 size 8192
>  [   26.227638] Register r1 information: NULL pointer
>  [   26.232352] Register r2 information: NULL pointer
>  [   26.237062] Register r3 information: NULL pointer
>  [   26.241772] Register r4 information: NULL pointer
>  [   26.246481] Register r5 information: non-paged memory
>  [   26.251537] Register r6 information: non-paged memory
>  [   26.256594] Register r7 information: non-paged memory
>  [   26.261651] Register r8 information: slab kmalloc-8k start c81c6000 pointer
>  offset 4096 size 8192
>  [   26.270545] Register r9 information: NULL pointer
>  [   26.275254] Register r10 information: slab kmalloc-8k start c81c6000 pointer
>  offset 0 size 8192
>  [   26.283977] Register r11 information: non-paged memory
>  [   26.289120] Register r12 information: NULL pointer
>  [   26.293916] Process kworker/0:3 (pid: 18, stack limit = 0x1a047662)
>  [   26.300194] Stack: (0xf0961dc8 to 0xf0962000)
>  [   26.304559] 1dc0:                   c1d50ec0 c075cc64 00000001 00000000
>  00000000 c1d50ec0
>  [   26.312744] 1de0: 00000001 24c676fe c075cc64 00000000 000008e0 c81c6000
>  c80c4000 00000000
>  [   26.320928] 1e00: c1d50ec0 00000002 c81c7000 c075cd0c 00000200 c01d3930
>  60070013 00000000
>  [   26.329111] 1e20: 60070013 c1b43208 000008e0 24c676fe 00000000 c830f5cc
>  c830f5cc 00000200
>  [   26.337294] 1e40: 00000000 00000001 00000200 c80c4000 00000000 c075d124
>  00000000 00000200
>  [   26.345477] 1e60: 00000000 c13e0ec0 c81c6000 c1d50ec0 00000000 00000000
>  00000000 c80c4000
>  [   26.353661] 1e80: c830f5cc c1e52c00 00000200 c81c6000 00000002 c075b748
>  00000000 00000200
>  [   26.361844] 1ea0: 00000000 c1312e58 ef7d3c00 0003e000 00000000 00000200
>  ef7d3c00 c1e52c00
>  [   26.370027] 1ec0: c830f5a8 c830f5cc 00000000 c076b228 00000200 00000000
>  c830f500 c1d50ec0
>  [   26.378211] 1ee0: c830f5d4 24c676fe c0c0e608 c830f5a8 c1ed3800 c1312e58
>  ef7d3c00 c1d50ec0
>  [   26.386394] 1f00: 00000000 c14e59c0 ef7d3c05 c013c06c 00000001 00000000
>  c013bff4 00000000
>  [   26.394577] 1f20: c1312e68 24c676fe c1b5f698 c19642b8 00000000 c101b390
>  00000000 24c676fe
>  [   26.402760] 1f40: c1d50ec0 c1ed3800 c1312e58 c1ed3818 c1312e94 c13dfc30
>  c1d50ec0 00000008
>  [   26.410944] 1f60: c1312e58 c013c3f0 00000000 c1f16880 c1d50ec0 c013c3b0
>  c1ed3800 c1ed3880
>  [   26.419126] 1f80: f095de9c 00000000 00000000 c0143654 c1f16880 c0143588
>  00000000 00000000
>  [   26.427309] 1fa0: 00000000 00000000 00000000 c0100128 00000000 00000000
>  00000000 00000000
>  [   26.435491] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000
>  00000000 00000000
>  [   26.443673] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
>  00000000 00000000
>  [   26.451855]  ubi_io_read from ubi_eba_read_leb+0xe8/0x4a4
>  [   26.457277]  ubi_eba_read_leb from ubi_eba_read_leb_sg+0x5c/0x154
>  [   26.463390]  ubi_eba_read_leb_sg from ubi_leb_read_sg+0x70/0xb0
>  [   26.469325]  ubi_leb_read_sg from ubiblock_do_work+0x104/0x238
>  [   26.475180]  ubiblock_do_work from process_one_work+0x238/0x57c
>  [   26.481130]  process_one_work from worker_thread+0x40/0x4f8
>  [   26.486724]  worker_thread from kthread+0xcc/0xf0
>  [   26.491449]  kthread from ret_from_fork+0x14/0x2c
>  [   26.496168] Exception stack(0xf0961fb0 to 0xf0961ff8)
>  [   26.501225] 1fa0:                                     00000000 00000000
>  00000000 00000000
>  [   26.509410] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000
>  00000000 00000000
>  [   26.517592] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
>  [   26.524215] Code: 1a000041 e59d2010 e1a09fc5 e1a0b005 (e5d23000)
>  [   26.530367] ---[ end trace 0000000000000000 ]---
> 
> This kernel Oops happens both on patched or vanilla kernels, of which we tried
> several releases in 5.15.y and 6.1.y branches. We also tried with several of
> our devices.
> Upgrading to the latest mainline kernel did not work out-of-the-box, hence we
> did not follow that track (yet).
> 
> We tried with full debugging output for the whole ubi driver and used several
> additional printks. That way we were able to see, that the first scatterlist
> entry already pointed to virtual address zero when the first read request
> caused by cryptsetup was added to ubiblock's work_queue.
> 
>  sg_virt(pdu->usgl.sg[0]) => page_address(sg) => 0x0000000
> 
> We also tried to use hw_breakpoints to gather more information on (maybe)
> another module interfering, but did not succeed (yet).
> 
> But we were not able to narrow down the root cause until now.
> 
> 
> As an additional twist, the system is able to boot when we mount the ubiblock
> root filesystem without calling cryptsetup, hence skipping the dm-verity hash
> verification. And we can verify the root filesystem with cryptsetup once the
> system boot is finished.
> 
> It is also possible to boot the same system image, including dm-verity, when
> using a sdcard instead of the nand flash. Loading the FIT from sdcard but
> calling cryptsetup on the ubiblock device again leads to the described oops.
> 
> 
> Is there something we have overlooked?
> Do you have further ideas to get behind this issue?
> 
> 
> Thanks!
> --
> Stephan Wurm <stephan.wurm@a-eberle.de>
