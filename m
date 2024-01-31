Return-Path: <linux-kernel+bounces-46256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A251B843D22
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AE3C1F25DEB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE3669D39;
	Wed, 31 Jan 2024 10:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCg89Jdy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52F669D0F
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 10:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706698117; cv=none; b=BFbezIHkoKLQjY1QzVIauPVPsId5+WaZ3lpsxpyO1+bYcZJsnMwQPFaBgr6Uxzlm4aNyPo7bhd8wyVoTUeETNWIVnE15xdCCeKT/KQixXLSkSQKrbNoYBmzx2TvokVUEgbseM68SIv3WzCl1wow0MYnwfADQX3KEJlxVZr6oFlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706698117; c=relaxed/simple;
	bh=DmcoQD+JhwDa6J+rOPgojIbd64tOEs3iM/Ycj3i8yGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vw31/pRZGt0C9kp9Tm5bxeJ+VoEjeupte5tD2G0VvX5+//gfhGre9xcHR6Y33ebl/VPfSnpTz995E5L+6ojhgMCjg0JVgIvSoEaBw56g1k/F+FBlfz68XyYPojfSvwMbnlh3kXanHIkhjAQ9JtDKkJiZ93/5ObSJQ2x07NWQkmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jCg89Jdy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB85C433C7;
	Wed, 31 Jan 2024 10:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706698117;
	bh=DmcoQD+JhwDa6J+rOPgojIbd64tOEs3iM/Ycj3i8yGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jCg89JdyqabOdKkLzEMI2ZwR1C9iV0xxEwhPEu6Dwuwthy+bUtH/ZrIavIgzV3anu
	 uxYcuCYGdTqys4me5ccdv1BI9a+Ktoenj2jM2EOB4kaNhCBEG2wR8SO/k7R1fl+3jv
	 pFmfX1TYNe7NcNalp3uVOJ3lQBn5LD1eQ9AXbedo3Ji5qyLp97vEwXCYpOPctOfKgK
	 VdyqVhBbu5sprsdDeRGpqKg+a4HV1TdOOAj/Um/5KKYZlyEjmH6pZEUbCu4Vu3PNyG
	 FcqNww9UE80poTIptRxzA6VdFMFqdxkh96FxiG5Gk5iWlO8Z4YW50KWSLAg67r6qmC
	 hiLJ950wWG3rQ==
Date: Wed, 31 Jan 2024 12:48:05 +0200
From: Mike Rapoport <rppt@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Pengfei Xu <pengfei.xu@intel.com>, rdunlap@infradead.org,
	akpm@linux-foundation.org, heng.su@intel.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, lkp@intel.com
Subject: Re: [Syzkaller & bisect] There is BUG: unable to handle kernel
 paging request in fuse_copy_one in intel-6.8-rc2
Message-ID: <ZbolZRw9yFk9jLB6@kernel.org>
References: <ZbmqEy+8iOREMPmU@xpf.sh.intel.com>
 <ff3058bc-e683-4aa6-833e-6dd6aa92d2bf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff3058bc-e683-4aa6-833e-6dd6aa92d2bf@redhat.com>

On Wed, Jan 31, 2024 at 10:15:11AM +0100, David Hildenbrand wrote:
> On 31.01.24 03:01, Pengfei Xu wrote:
> > Hi Mike,
> > 
> > Greeting!
> > 
> > There is "unable to handle kernel paging request in fuse_copy_one" BUG in
> > intel-6.8-rc2:
> > 
> > All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/240130_184751_fuse_copy_one
> > Syzkaller reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/240130_184751_fuse_copy_one/repro.c
> > Syzkaller repro syscall steps: https://github.com/xupengfe/syzkaller_logs/blob/main/240130_184751_fuse_copy_one/repro.prog
> > Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/240130_184751_fuse_copy_one/bisect_info.log
> > Issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/240130_184751_fuse_copy_one/41bccc98fb7931d63d03f326a746ac4d429c1dd3_dmesg.log
> > bzImage: https://github.com/xupengfe/syzkaller_logs/raw/main/240130_184751_fuse_copy_one/bzImage_v6.8-rc2.tar.gz
> > Kconfig(make olddefconfig): https://github.com/xupengfe/syzkaller_logs/blob/main/240130_184751_fuse_copy_one/kconfig_origin
> > 
> > Bisected and found first bad commit is:
> > b758fe6df50da mm/secretmem: make it on by default
> 
> Sounds like we manage to access a page that has its direct map removed --
> either because it's actual secretmem memory, or because we fail to restore
> the direct map.

Judging by the repro code and the registers, it's an access to secretmem.

The call
syscall(__NR_write, /*fd=*/r[0], /*arg=*/0x20000040ul, /*len=*/0x50ul);

will eventually get to

memcpy(0xffff88800e2afa80, 0xffff8880119a5040, 0x0000000000000010)

and I think that 0x20000040 in repro address space maps to
0xffff8880119a5040 in the direct map.

So it looks like secretmem actually works :)

From memfd_secret(2):

The memory region is removed from the kernel page tables and only the page
tables of the processes holding the file descriptor map the corresponding
physical memory. (Thus, the pages in the region can't be accessed by the
kernel itself, so that, for example, pointers to the region can't be passed
to system calls.)
 
> > Reverted above commit on top of v6.8-rc2, above issue was gone.
> > 
> > Syzkaller rpro.report: https://github.com/xupengfe/syzkaller_logs/blob/main/240130_184751_fuse_copy_one/repro.report
> > BUG: unable to handle page fault for address: ffff8880119a5040
> > #PF: supervisor read access in kernel mode
> > #PF: error_code(0x0000) - not-present page
> > PGD 9c01067 P4D 9c01067 PUD 9c02067 PMD 11d62063 PTE 800fffffee65a060
> > Oops: 0000 [#1] PREEMPT SMP KASAN NOPTI
> > CPU: 1 PID: 751 Comm: syz-executor148 Not tainted 6.8.0-rc1-2024-01-22-intel-next-e32989111619+ #1
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> > RIP: 0010:memcpy+0xc/0x20 arch/x86/lib/memcpy_64.S:38
> > Code: f7 e7 49 01 d5 eb ba 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 48 89 f8 48 89 d1 <f3> a4 c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90
> > RSP: 0018:ffff88800e2af878 EFLAGS: 00010293
> > RAX: ffff88800e2afa80 RBX: 0000000000000010 RCX: 0000000000000010
> > RDX: 0000000000000010 RSI: ffff8880119a5040 RDI: ffff88800e2afa80
> > RBP: ffff88800e2af8c0 R08: ffff888013b14a00 R09: 0000000000000001
> > R10: fffffbfff0ef68c4 R11: ffffffff877b4627 R12: ffff88800e2af8f8
> > R13: ffff88800e2af938 R14: ffff88800e2afc38 R15: 0000000000000010
> > FS:  000000000100c480(0000) GS:ffff88806cd00000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: ffff8880119a5040 CR3: 000000000f6ca000 CR4: 0000000000750ef0
> > PKRU: 55555554
> > Call Trace:
> >   <TASK>
> >   fuse_copy_one+0x11e/0x1a0 fs/fuse/dev.c:1007
> >   fuse_dev_do_write+0x186/0x26b0 fs/fuse/dev.c:1863
> >   fuse_dev_write+0x15f/0x200 fs/fuse/dev.c:1960
> >   call_write_iter include/linux/fs.h:2085 [inline]
> >   new_sync_write fs/read_write.c:497 [inline]
> >   vfs_write fs/read_write.c:590 [inline]
> >   vfs_write+0xa5a/0x1120 fs/read_write.c:570
> >   ksys_write+0x13a/0x270 fs/read_write.c:643
> >   __do_sys_write fs/read_write.c:655 [inline]
> >   __se_sys_write fs/read_write.c:652 [inline]
> >   __x64_sys_write+0x7c/0xc0 fs/read_write.c:652
> >   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >   do_syscall_64+0x74/0x150 arch/x86/entry/common.c:83
> >   entry_SYSCALL_64_after_hwframe+0x6e/0x76
> > RIP: 0033:0x4504ed
> > Code: db 48 89 d8 5b 5d 41 5c 41 5d 41 5e c3 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007fff15c70d68 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> > RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000004504ed
> > RDX: 0000000000000050 RSI: 0000000020000040 RDI: 0000000000000003
> > RBP: 00000000ffffffff R08: 00000000ffffffff R09: 0000000000000000
> > R10: 00007fff15c70d70 R11: 0000000000000246 R12: 0000000000412190
> > R13: 0000000000000000 R14: 00000000004004e8 R15: 0000000000000000
> >   </TASK>
> > Modules linked in:
> > CR2: ffff8880119a5040
> > ---[ end trace 0000000000000000 ]---
> > 
> > 
> > Hope it's helpful.
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
> >    // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
> >    // You could change the bzImage_xxx as you want
> >    // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
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
> > 
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

-- 
Sincerely yours,
Mike.

