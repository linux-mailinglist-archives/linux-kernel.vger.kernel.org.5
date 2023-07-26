Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E580763FF4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 21:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbjGZTuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 15:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjGZTud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 15:50:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03A1189
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 12:50:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EC1561CAD
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 19:50:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11816C433C8;
        Wed, 26 Jul 2023 19:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690401031;
        bh=zr5C8hw1G8VfpkgYS85lvp1ZGYKGFPzSwOK9ag+mRIw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cVAjtFGOICEYS7AEzzhNosp/4gezbjP39MyDGCv4Hps1ZMmS9t1jZw2Ni73wFM42N
         tKEl2FtYN9ZEoJcCmR5zfxkS7cgiSYbCBdwOjN3sshMzVI/KO5AHjRODl5pnyWLJKV
         rQNWRXdr7gFBdwMhhTyXb9he0IM6nPpF1kvofQDNxo8//BD+MQN7Ld8mFvFmuS6AKx
         uWjYEVx4MI5OGxaoZt17pv/Hh9osK2vu3QgQpepEIe3NFxowzrbrvhjjylpcU/vYOr
         1syskLGxkqLGWwChqiOvTIBCq6aiuzBgFcQoDs6msSjlmz/oGFRSrhmoAjOaUpbogF
         peWfhj6OyPXrg==
Date:   Wed, 26 Jul 2023 12:50:29 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 3/3] mm: Batch-zap large anonymous folio PTE mappings
Message-ID: <20230726195029.GA123524@dev-arch.thelio-3990X>
References: <20230720112955.643283-1-ryan.roberts@arm.com>
 <20230720112955.643283-4-ryan.roberts@arm.com>
 <20230726161942.GA1123863@dev-arch.thelio-3990X>
 <44a91c46-08ba-9693-6c9c-a0a59921e9f1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44a91c46-08ba-9693-6c9c-a0a59921e9f1@arm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 08:38:25PM +0100, Ryan Roberts wrote:
> On 26/07/2023 17:19, Nathan Chancellor wrote:
> > Hi Ryan,
> > 
> > On Thu, Jul 20, 2023 at 12:29:55PM +0100, Ryan Roberts wrote:
> 
> ...
> 
> >>
> > 
> > After this change in -next as commit 904d9713b3b0 ("mm: batch-zap large
> > anonymous folio PTE mappings"), I see the following splats several times
> > when booting Debian's s390x configuration (which I have mirrored at [1])
> > in QEMU (bisect log below):
> > 
> > $ qemu-system-s390x \
> >     -display none \
> >     -nodefaults \
> >     -M s390-ccw-virtio \
> >     -kernel arch/s390/boot/bzImage \
> >     -initrd rootfs.cpio \
> >     -m 512m \
> >     -serial mon:stdio
> 
> I'm compiling the kernel for next-20230726 using the s390 cross compiler from kernel.org and the config you linked. Then booting with qemu-system-s390x (tried both distro's 4.2.1 and locally built 8.0.3) and the initrd you provided (tried passing it compressed and uncompressed), but I'm always getting a kernel panic due to not finding a rootfs:
> 
> $ qemu-system-s390x \
> 	-display none \
> 	-nodefaults \
> 	-M s390-ccw-virtio \
> 	-kernel arch/s390/boot/bzImage
> 	-initrd ../s390-rootfs.cpio.zst \
> 	-m 512m \
> 	-serial mon:stdio
> KASLR disabled: CPU has no PRNG
> KASLR disabled: CPU has no PRNG
> Linux version 6.5.0-rc3-next-20230726 (ryarob01@e125769) (s390-linux-gcc (GCC) 13.1.0, GNU ld (GNU Binutils) 2.40) #1 SMP Wed Jul 26 19:56:26 BST 2023
> setup: Linux is running under KVM in 64-bit mode
> setup: The maximum memory size is 512MB
> setup: Relocating AMODE31 section of size 0x00003000
> cpu: 1 configured CPUs, 0 standby CPUs
> Write protected kernel read-only data: 4036k
> Zone ranges:
>   DMA      [mem 0x0000000000000000-0x000000007fffffff]
>   Normal   empty
> Movable zone start for each node
> Early memory node ranges
>   node   0: [mem 0x0000000000000000-0x000000001fffffff]
> Initmem setup node 0 [mem 0x0000000000000000-0x000000001fffffff]
> percpu: Embedded 14 pages/cpu s26368 r0 d30976 u57344
> Kernel command line: 
> random: crng init done
> Dentry cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
> Inode-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
> Built 1 zonelists, mobility grouping on.  Total pages: 129024
> mem auto-init: stack:all(zero), heap alloc:off, heap free:off
> Memory: 507720K/524288K available (3464K kernel code, 788K rwdata, 572K rodata, 796K init, 400K bss, 16568K reserved, 0K cma-reserved)
> SLUB: HWalign=256, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
> rcu: Hierarchical RCU implementation.
> rcu:    RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=1.
> rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
> rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=1
> NR_IRQS: 3, nr_irqs: 3, preallocated irqs: 3
> rcu: srcu_init: Setting srcu_struct sizes based on contention.
> clocksource: tod: mask: 0xffffffffffffffff max_cycles: 0x3b0a9be803b0a9, max_idle_ns: 1805497147909793 ns
> Console: colour dummy device 80x25
> printk: console [ttysclp0] enabled
> pid_max: default: 32768 minimum: 301
> Mount-cache hash table entries: 1024 (order: 1, 8192 bytes, linear)
> Mountpoint-cache hash table entries: 1024 (order: 1, 8192 bytes, linear)
> rcu: Hierarchical SRCU implementation.
> rcu:    Max phase no-delay instances is 1000.
> smp: Bringing up secondary CPUs ...
> smp: Brought up 1 node, 1 CPU
> clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
> futex hash table entries: 256 (order: 4, 65536 bytes, linear)
> kvm-s390: SIE is not available
> hypfs: The hardware system does not support hypfs
> workingset: timestamp_bits=62 max_order=17 bucket_order=0
> io scheduler mq-deadline registered
> io scheduler kyber registered
> cio: Channel measurement facility initialized using format extended (mode autodetected)
> Discipline DIAG cannot be used without z/VM
> vmur: The z/VM virtual unit record device driver cannot be loaded without z/VM
> sclp_sd: Store Data request failed (eq=2, di=3, response=0x40f0, flags=0x00, status=0, rc=-5)
> List of all partitions:
> No filesystem could mount root, tried: 
> 
> Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(1,0)
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.5.0-rc3-next-20230726 #1
> Hardware name: QEMU 8561 QEMU (KVM/Linux)
> Call Trace:
>  [<0000000000432b22>] dump_stack_lvl+0x62/0x80 
>  [<0000000000158898>] panic+0x2f8/0x310 
>  [<00000000005b7a56>] mount_root_generic+0x276/0x3b8 
>  [<00000000005b7e46>] prepare_namespace+0x56/0x220 
>  [<00000000004593e8>] kernel_init+0x28/0x1c8 
>  [<000000000010217e>] __ret_from_fork+0x36/0x50 
>  [<000000000046143a>] ret_from_fork+0xa/0x30
> 
> 
> Any idea what I'm doing wrong here? Do I need to specify something on the kernel command line? (I've tried root=/dev/ram0, but get the same result).

Hmmm, interesting. The rootfs does need to be used decompressed (I think
the kernel does support zstd compressed initrds but we only compress
them to save space, not for running). Does the sha256sum sum match the
one I just tested?

$ curl -LSsO https://github.com/ClangBuiltLinux/boot-utils/releases/download/20230707-182910/s390-rootfs.cpio.zst
$ zstd -d s390-rootfs.cpio.zst
$ sha256sum s390-rootfs.cpio
948fb3c2ad65e26aee8eb0a069f5c9e1ab2c59e4b4f62b63ead271e12a8479b4  s390-rootfs.cpio
$ qemu-system-s390x -display none -nodefaults -M s390-ccw-virtio -kernel arch/s390/boot/bzImage -initrd s390-rootfs.cpio -m 512m -serial mon:stdio
...
[    7.890385] Trying to unpack rootfs image as initramfs...
...

I suppose it could be something with Kconfig too, here is the actual one
that olddefconfig produces for me:

https://gist.github.com/nathanchance/3e4c1721ac204bbb969e2f288e1695c9

Cheers,
Nathan
