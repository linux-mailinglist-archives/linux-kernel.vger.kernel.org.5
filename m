Return-Path: <linux-kernel+bounces-30126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 040138319D9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 14:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D530B25AC6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 13:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F3624B55;
	Thu, 18 Jan 2024 13:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="G2+bhBmM"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330E224B51
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 13:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705582909; cv=none; b=KlXY3yW6gZ0bZh4IWFbziUG+ewwaM13xAxs2k8ir+jhc2NWALBWOWddRxnoOr10aEU8zywd2YrYnrPTdM6sgO2TfSy0fAbrYsZ45GdX2GkPzAof1Sd71XBLl8rP+qotosjHWe/GqGGiF+K+mxb7jT4lfF9yIcHVVFl+6VwIbpXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705582909; c=relaxed/simple;
	bh=2ztFDnpOlXrJ4GQSk3NJNV83MQvwqGMLsD8DeDUnEKU=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=nM57iNULJyh2hW75tl2n5SHMbG9ZnmSxQpM1cvJBJbPyfJu8WfDC/cuCX6HcYLRgTpTxz9mxnDBrla31MusILofRO2raRXrVMHOJaPvF3KKkhVsjS4GbTCsm6MNAlcq6AApUqwCappfroMqEoJwEVZckYykp9T876CB++bF8S4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=G2+bhBmM; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a28b0207c1dso1007697566b.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 05:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1705582904; x=1706187704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CV99ndMBEnv7+i0KgO9Jy4dZrWznQQ7WCTJP40FuP9k=;
        b=G2+bhBmMlAnbD1IQKZw25E1k5+uzlAZXTc8XSk/i8AwptO/qgJp+LLYJCK53QmVNLR
         O/JZHCfeBGVWSwPWXcO6DCu2af94xzW274EWNguOeeVJzkaUNSWvmtSkn5oZmNmDS5pR
         crJDPu+rrK04N3fdwzQie1Iky48esO/HV13a/tDDPWqGnefcXlxSIspLjFd7LfGjttnO
         4lhuWEnJ9IXxAfWEdJB17grTT3T2sb0bBcrp7UmVFJVWRAH+qR5MUgtiPc0vHXsHR2ub
         Fgi1ldfy+s94c5eNxHNCPgSZLjwNhAvINHPXXcYZMfFH5M/JjACDz8ttgMkYyezKBgcm
         4+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705582904; x=1706187704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CV99ndMBEnv7+i0KgO9Jy4dZrWznQQ7WCTJP40FuP9k=;
        b=dAPhz5xX7YC5YpkHgPdxqyEGCjco/ZbbpYWDiVoyCZEoHPrcX5iv6kX242LCjUpYmT
         VjYzO85U6s6d7fRQ35s3f1D2m2I/79qoXZg63XnmOb1BZSXsYBak+k3LK4TqRSWl51aJ
         mS7AC2T2OGoPCW9KqVp1eClBm3h6s0zxrllYMYLMDhn4K3fbnTzNHcHiMlGucA0pmEvP
         qSf2HZCUmNYynRXsXf9W8k+3Md2A+OrMV3uCyccC9eMWg+2ldbI1rLUpoUZYqO8y7IU4
         hqbArzUjkLmnzekhvzFBBrlM8zFFUrFhb58Fmr0CM8t0f146+6E8swBgrkdDYFjmcu/Y
         w7Aw==
X-Gm-Message-State: AOJu0YwzKfp5ax9Ymu3R+kfqbXh/EdaFORL+r82WlF3/SAmwGspW87OQ
	wLpcGPtemJS7k1jIZnSsxVdVNIVGNhz3lakRZK1IWvzHK7l/JPalgPYJaY4pLBuelCGga3mfBeR
	c646elahM/Kl2aF2GoRBgXkZMZNSxUtI3yYTXeQ==
X-Google-Smtp-Source: AGHT+IGXHWuAbZf6vP7bFyGlIWm/V3xNm9G1zzWXciRpuQQcls3Pd1mtfB3eXcJXawXwCc8Me/YMNC+4PA9rLOOa3OQ=
X-Received: by 2002:a17:906:3b10:b0:a2c:b0a6:8b6 with SMTP id
 g16-20020a1709063b1000b00a2cb0a608b6mr488211ejf.1.1705582904215; Thu, 18 Jan
 2024 05:01:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230316131711.1284451-1-alexghiti@rivosinc.com>
 <CAK9=C2XJtSG2d_nsyDv7kU1v7Jj0chdevqrMc0MpJswukcEABA@mail.gmail.com>
 <CAHVXubhhxpzHDM-n91V_rceY5t_VqLvrwZj3RP_tNL2=F9mqjQ@mail.gmail.com>
 <CAK9=C2WVOpSqtt8r1U4hnzSZ=cc1PocpukgQjNyahP2XuPhozw@mail.gmail.com>
 <d0087922-4721-ccf1-80bf-9f74099d0948@ghiti.fr> <CAPqJEFr6MgUyARfbWAo7EeQKLVd4xRJz_LOYN68UC-kPD1Hr5A@mail.gmail.com>
 <20240118082346.GB31078@hsinchu15>
In-Reply-To: <20240118082346.GB31078@hsinchu15>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Thu, 18 Jan 2024 14:01:33 +0100
Message-ID: <CAHVXubiQ5N+ngdy=Fk3j-hS_KkOEg272b++-hB4-oGeSSZKtNQ@mail.gmail.com>
Subject: Re: Fwd: [PATCH v8 0/4] riscv: Use PUD/P4D/PGD pages for the linear mapping
To: Nylon Chen <nylon.chen@sifive.com>
Cc: alex@ghiti.fr, apatel@ventanamicro.com, catalin.marinas@arm.com, 
	will@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, robh+dt@kernel.org, frowand.list@gmail.com, 
	rppt@kernel.org, akpm@linux-foundation.org, anup@brainfault.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-mm@kvack.org, zong.li@sifive.com, nylon7717@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Nylon,

On Thu, Jan 18, 2024 at 9:23=E2=80=AFAM Nylon Chen <nylon.chen@sifive.com> =
wrote:
>
> > On 3/23/23 15:55, Anup Patel wrote:
> > > On Thu, Mar 23, 2023 at 6:24=E2=80=AFPM Alexandre Ghiti <alexghiti@ri=
vosinc.com> wrote:
> > >> Hi Anup,
> > >>
> > >> On Thu, Mar 23, 2023 at 1:18=E2=80=AFPM Anup Patel <apatel@ventanami=
cro.com> wrote:
> > >>> Hi Alex,
> > >>>
> > >>> On Thu, Mar 16, 2023 at 6:48=E2=80=AFPM Alexandre Ghiti <alexghiti@=
rivosinc.com> wrote:
> > >>>> This patchset intends to improve tlb utilization by using hugepage=
s for
> > >>>> the linear mapping.
> > >>>>
> > >>>> As reported by Anup in v6, when STRICT_KERNEL_RWX is enabled, we m=
ust
> > >>>> take care of isolating the kernel text and rodata so that they are=
 not
> > >>>> mapped with a PUD mapping which would then assign wrong permission=
s to
> > >>>> the whole region: it is achieved by introducing a new memblock API=
.
> > >>>>
> > >>>> Another patch makes use of this new API in arm64 which used some s=
ort of
> > >>>> hack to solve this issue: it was built/boot tested successfully.
> > >>>>
> > >>>> base-commit-tag: v6.3-rc1
> > >>>>
> > >>>> v8:
> > >>>> - Fix rv32, as reported by Anup
> > >>>> - Do not modify memblock_isolate_range and fixes comment, as sugge=
sted by Mike
> > >>>> - Use the new memblock API for crash kernel too in arm64, as sugge=
sted by Andrew
> > >>>> - Fix arm64 double mapping (which to me did not work in v7), but e=
nds up not
> > >>>>    being pretty at all, will wait for comments from arm64 reviewer=
s, but
> > >>>>    this patch can easily be dropped if they do not want it.
> > >>>>
> > >>>> v7:
> > >>>> - Fix Anup bug report by introducing memblock_isolate_memory which
> > >>>>    allows us to split the memblock mappings and then avoid to map =
the
> > >>>>    the PUD which contains the kernel as read only
> > >>>> - Add a patch to arm64 to use this newly introduced API
> > >>>>
> > >>>> v6:
> > >>>> - quiet LLVM warning by casting phys_ram_base into an unsigned lon=
g
> > >>>>
> > >>>> v5:
> > >>>> - Fix nommu builds by getting rid of riscv_pfn_base in patch 1, th=
anks
> > >>>>    Conor
> > >>>> - Add RB from Andrew
> > >>>>
> > >>>> v4:
> > >>>> - Rebase on top of v6.2-rc3, as noted by Conor
> > >>>> - Add Acked-by Rob
> > >>>>
> > >>>> v3:
> > >>>> - Change the comment about initrd_start VA conversion so that it f=
its
> > >>>>    ARM64 and RISCV64 (and others in the future if needed), as sugg=
ested
> > >>>>    by Rob
> > >>>>
> > >>>> v2:
> > >>>> - Add a comment on why RISCV64 does not need to set initrd_start/e=
nd that
> > >>>>    early in the boot process, as asked by Rob
> > >>>>
> > >>>> Alexandre Ghiti (4):
> > >>>>    riscv: Get rid of riscv_pfn_base variable
> > >>>>    mm: Introduce memblock_isolate_memory
> > >>>>    arm64: Make use of memblock_isolate_memory for the linear mappi=
ng
> > >>>>    riscv: Use PUD/P4D/PGD pages for the linear mapping
> > >>> Kernel boot fine on RV64 but there is a failure which is still not
> > >>> addressed. You can see this failure as following message in
> > >>> kernel boot log:
> > >>>      0.000000] Failed to add a System RAM resource at 80200000
> > >> Hmmm I don't get that in any of my test configs, would you mind
> > >> sharing yours and your qemu command line?
> > > Try alexghiti_test branch at
> > > https://github.com/avpatel/linux.git
> > >
> > > I am building the kernel using defconfig and my rootfs is
> > > based on busybox.
> > >
> > > My QEMU command is:
> > > qemu-system-riscv64 -M virt -m 512M -nographic -bios
> > > opensbi/build/platform/generic/firmware/fw_dynamic.bin -kernel
> > > ./build-riscv64/arch/riscv/boot/Image -append "root=3D/dev/ram rw
> > > console=3DttyS0 earlycon" -initrd ./rootfs_riscv64.img -smp 4
> >
> >
> > So splitting memblock.memory is the culprit, it "confuses" the resource=
s
> > addition and I can only find hacky ways to fix that...
> Hi Alexandre,
>
> We encountered the same error as Anup. After adding your patch
> (3335068f87217ea59d08f462187dc856652eea15), we will not encounter the
> error again.
>
> What I have observed so far is
>
> - before your patch
> When merging consecutive memblocks, if the memblock types are different,
> they will be merged into reserved
> - after your patch
> When consecutive memblocks are merged, if the memblock types are
> different, they will be merged into memory.
>
> Such a result will cause the memory location of OpenSBI to be changed
> from reserved to memory. Will this have any side effects?

I guess it will end up in the memory pool and pages from openSBI
region will be allocated, so we should see very quickly bad stuff
happening (either PMP violation or M-mode ecall never
returning/trapping/etc).

But I don't observe the same thing, I always see the openSBI region
being reserved:

reserved[0x0] [0x0000000080000000-0x000000008007ffff],
0x0000000000080000 bytes flags: 0x0

Can you elaborate a bit more about "When consecutive memblocks are
merged, if the memblock types are different, they will be merged into
memory"? Where/when does this merge happen? Can you give me a config
file and a kernel revision so that I can take a look?

Thanks,

Alex

> >
> > So given that the arm64 patch with the new API is not pretty and that
> > the simplest solution is to re-merge the memblock regions afterwards
> > (which is done by memblock_clear_nomap), I'll drop the new API and the
> > arm64 patch to use the nomap API like arm64: I'll take advantage of tha=
t
> > to clean setup_vm_final which I have wanted to do for a long time.
> >
> > @Mike Thanks for you reviews!
> >
> > @Anup Thanks for all your bug reports on this patchset, I have to
> > improve my test flow (it is in the work :)).
> >
> >
> > > Regards,
> > > Anup
> > >
> > >> Thanks
> > >>
> > >>> Regards,
> > >>> Anup
> > >>>
> > >>>>   arch/arm64/mm/mmu.c           | 25 +++++++++++------
> > >>>>   arch/riscv/include/asm/page.h | 19 +++++++++++--
> > >>>>   arch/riscv/mm/init.c          | 53 ++++++++++++++++++++++++++++-=
------
> > >>>>   arch/riscv/mm/physaddr.c      | 16 +++++++++++
> > >>>>   drivers/of/fdt.c              | 11 ++++----
> > >>>>   include/linux/memblock.h      |  1 +
> > >>>>   mm/memblock.c                 | 20 +++++++++++++
> > >>>>   7 files changed, 119 insertions(+), 26 deletions(-)
> > >>>>
> > >>>> --
> > >>>> 2.37.2
> > >>>>
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv

