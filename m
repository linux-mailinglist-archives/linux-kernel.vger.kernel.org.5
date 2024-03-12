Return-Path: <linux-kernel+bounces-100028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29823879104
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52443B23415
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B6C78264;
	Tue, 12 Mar 2024 09:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Sq2Zv7Pf"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7AF6FCA
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 09:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710236034; cv=none; b=mwyog98W3g/K66ENkdcbV3fLWFUbKvZSxVchnESZmDUUmZG+TV4mTFAHl9nD15X0BuB5CoNgEA9OzsEEIo1Obp6KkSgM2lWS/7xpB7PirzVjXUpq99zKTOjyQX6Kh2/75b9IYSHYEwUG0QS9PpFQKOa18z8qkidjTVvBufD4muc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710236034; c=relaxed/simple;
	bh=kTOOY5Y2QZk/52lNtKfopBnNDn56FzBEJiXrrSzVHOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pXN6wb5ISVaJgIEQ1CDKQercwZomaTlhVyDVxUapEeTv2asT3hxLpZT3EeN08lxFtOrYYCX1kvXl/J1z5bbl/737f9KJ653mGsiPnDjyd15pXMeeNSJETMJR0dbt5xugaT0CcQNj4T/553fYHavKwCaesbFTsAdvCLkpHyWtzR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Sq2Zv7Pf; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a4499ef8b5aso378537366b.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 02:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1710236031; x=1710840831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=edYt7eTkFwnywkr5Q7EpnbvnaXY/0YnNw5lx2MxT+ts=;
        b=Sq2Zv7PfjLzoCqy6bXvTo4oPLEDDRDSu+IqgmIkwm396XJqWHCfbK2YIKQqvT6IOyN
         +2xJAeUbbNI0zn8z5G2/24aKm+qauj6AenIENXbTrZP78WIs6LsbBEFHNcVOBOkliIWf
         5WoTThIHgSQzcOrYbn6DilY1fY8k5/8lfpHVrGQger2eWh2qg8W2TzuX+qofUocptxSr
         VpFbLtGhOrS9n5XmgMYWUIenG3d2RJnaBWlg+RbPhVXT4NCD/CNFDy9fQG36lKUfKJN4
         jBbJ9ScB880ABdMrp39NGTKAu28Shut0y+MmtPWnUqcLzj1ZF/hFh8OH51vTaQxYb8pX
         vULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710236031; x=1710840831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=edYt7eTkFwnywkr5Q7EpnbvnaXY/0YnNw5lx2MxT+ts=;
        b=FnrU/7MIIMhCWiubRKoBtwe3awd3MSD9F29YK86T/fto4DNEpIgA6pBfhgqlN6gAsT
         /X10nmvdQBXpmAXOag2JKyhqhvPc0EABlbNpoDDPNh+pzD1czkEMdC7/jzZ2ds2S5w6Z
         L0lqVOeZ2GFb2AEnhcBfCvAliJ8DGp37An4jC+PM3F11tnmBTWnwocISIYbuN+6f/1qc
         Ic/Jb+8PPXYaWca/2CeOdz0NXk0yIbRDfiOQR2Vji4B8CxDTFGMoEZA0cKOe91XJZl7s
         NmxA5GuwGjIC0REy0Emh9AODyE7MlHvnqkW9ixpvaJOfe2gOfnIf8JCYirM3dYYAwU8L
         YMyg==
X-Forwarded-Encrypted: i=1; AJvYcCWzEjh4QjvffG5sFTFlNFffatR0etlU8vX5HNdw4jN30sRcYRrbsM/2QZSgMzcFVdioh/sUu9nfnSucdUFh3QrWkLf5uPN1K54YdQDD
X-Gm-Message-State: AOJu0YyzJP37d2Rb7TjP13BQyEIHwnfTTehe9DHTlvppeDekHlSb+Hlv
	X6IvehplBll1Ej2SXBFUfsXjbnJuA6/DJyMQF649rkd53S9pjagtGczy1k4NcuofhbFLoErDJuJ
	OLFmmRtRmGr/f6AOno+CcKQBwvuhkShNcQ2Gayw==
X-Google-Smtp-Source: AGHT+IFRqUszW/kj1uE8+lb4vev7mNik2H4TNy+JGy1x8BOgenTSqcR/hD9G759Kvffua+PwHyLpkzyjPqYGmAOrSWY=
X-Received: by 2002:a17:906:a845:b0:a45:fb01:cef with SMTP id
 dx5-20020a170906a84500b00a45fb010cefmr5716597ejb.50.1710236030556; Tue, 12
 Mar 2024 02:33:50 -0700 (PDT)
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
 <20240118082346.GB31078@hsinchu15> <CAHVXubiQ5N+ngdy=Fk3j-hS_KkOEg272b++-hB4-oGeSSZKtNQ@mail.gmail.com>
 <CAHh=Yk-WCMbNWg7UCbXtZZzPmOHnh1-pv4fqykwnpJGtwTcc=A@mail.gmail.com>
 <CAHVXubhE=RmFQ5gGo7J+H-mOEZKZQbCCH6F43UYMOy=Kgw+nug@mail.gmail.com>
 <CAHh=Yk-C--ZGgfckGYceTOoj20V9H6DHQHMZ2z2kisuFbAhaBA@mail.gmail.com> <CAHh=Yk8cWiX8q7YT3OuqNBP=kgNdZm3cWZCm01+CfVVQcnPy=Q@mail.gmail.com>
In-Reply-To: <CAHh=Yk8cWiX8q7YT3OuqNBP=kgNdZm3cWZCm01+CfVVQcnPy=Q@mail.gmail.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Tue, 12 Mar 2024 10:33:39 +0100
Message-ID: <CAHVXubjMfagEqBkfgvjcQM8ifcJrLUMgkBZ6HOLB318Hb25O_Q@mail.gmail.com>
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

On Tue, Mar 12, 2024 at 7:48=E2=80=AFAM Nylon Chen <nylon.chen@sifive.com> =
wrote:
>
> Nylon Chen <nylon.chen@sifive.com> =E6=96=BC 2024=E5=B9=B43=E6=9C=8812=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=882:40=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > Alexandre Ghiti <alexghiti@rivosinc.com> =E6=96=BC 2024=E5=B9=B42=E6=9C=
=885=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=885:32=E5=AF=AB=E9=81=93=
=EF=BC=9A
> > >
> > > Hi Nylon,
> > >
> > > On Fri, Jan 19, 2024 at 10:27=E2=80=AFAM Nylon Chen <nylon.chen@sifiv=
e.com> wrote:
> > > >
> > > > Alexandre Ghiti <alexghiti@rivosinc.com> =E6=96=BC 2024=E5=B9=B41=
=E6=9C=8818=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=889:01=E5=AF=AB=E9=
=81=93=EF=BC=9A
> > > > >
> > > > > Hi Nylon,
> > > > Hi Alexandre, thanks for your feedback,
> > > > >
> > > > > On Thu, Jan 18, 2024 at 9:23=E2=80=AFAM Nylon Chen <nylon.chen@si=
five.com> wrote:
> > > > > >
> > > > > > > On 3/23/23 15:55, Anup Patel wrote:
> > > > > > > > On Thu, Mar 23, 2023 at 6:24=E2=80=AFPM Alexandre Ghiti <al=
exghiti@rivosinc.com> wrote:
> > > > > > > >> Hi Anup,
> > > > > > > >>
> > > > > > > >> On Thu, Mar 23, 2023 at 1:18=E2=80=AFPM Anup Patel <apatel=
@ventanamicro.com> wrote:
> > > > > > > >>> Hi Alex,
> > > > > > > >>>
> > > > > > > >>> On Thu, Mar 16, 2023 at 6:48=E2=80=AFPM Alexandre Ghiti <=
alexghiti@rivosinc.com> wrote:
> > > > > > > >>>> This patchset intends to improve tlb utilization by usin=
g hugepages for
> > > > > > > >>>> the linear mapping.
> > > > > > > >>>>
> > > > > > > >>>> As reported by Anup in v6, when STRICT_KERNEL_RWX is ena=
bled, we must
> > > > > > > >>>> take care of isolating the kernel text and rodata so tha=
t they are not
> > > > > > > >>>> mapped with a PUD mapping which would then assign wrong =
permissions to
> > > > > > > >>>> the whole region: it is achieved by introducing a new me=
mblock API.
> > > > > > > >>>>
> > > > > > > >>>> Another patch makes use of this new API in arm64 which u=
sed some sort of
> > > > > > > >>>> hack to solve this issue: it was built/boot tested succe=
ssfully.
> > > > > > > >>>>
> > > > > > > >>>> base-commit-tag: v6.3-rc1
> > > > > > > >>>>
> > > > > > > >>>> v8:
> > > > > > > >>>> - Fix rv32, as reported by Anup
> > > > > > > >>>> - Do not modify memblock_isolate_range and fixes comment=
, as suggested by Mike
> > > > > > > >>>> - Use the new memblock API for crash kernel too in arm64=
, as suggested by Andrew
> > > > > > > >>>> - Fix arm64 double mapping (which to me did not work in =
v7), but ends up not
> > > > > > > >>>>    being pretty at all, will wait for comments from arm6=
4 reviewers, but
> > > > > > > >>>>    this patch can easily be dropped if they do not want =
it.
> > > > > > > >>>>
> > > > > > > >>>> v7:
> > > > > > > >>>> - Fix Anup bug report by introducing memblock_isolate_me=
mory which
> > > > > > > >>>>    allows us to split the memblock mappings and then avo=
id to map the
> > > > > > > >>>>    the PUD which contains the kernel as read only
> > > > > > > >>>> - Add a patch to arm64 to use this newly introduced API
> > > > > > > >>>>
> > > > > > > >>>> v6:
> > > > > > > >>>> - quiet LLVM warning by casting phys_ram_base into an un=
signed long
> > > > > > > >>>>
> > > > > > > >>>> v5:
> > > > > > > >>>> - Fix nommu builds by getting rid of riscv_pfn_base in p=
atch 1, thanks
> > > > > > > >>>>    Conor
> > > > > > > >>>> - Add RB from Andrew
> > > > > > > >>>>
> > > > > > > >>>> v4:
> > > > > > > >>>> - Rebase on top of v6.2-rc3, as noted by Conor
> > > > > > > >>>> - Add Acked-by Rob
> > > > > > > >>>>
> > > > > > > >>>> v3:
> > > > > > > >>>> - Change the comment about initrd_start VA conversion so=
 that it fits
> > > > > > > >>>>    ARM64 and RISCV64 (and others in the future if needed=
), as suggested
> > > > > > > >>>>    by Rob
> > > > > > > >>>>
> > > > > > > >>>> v2:
> > > > > > > >>>> - Add a comment on why RISCV64 does not need to set init=
rd_start/end that
> > > > > > > >>>>    early in the boot process, as asked by Rob
> > > > > > > >>>>
> > > > > > > >>>> Alexandre Ghiti (4):
> > > > > > > >>>>    riscv: Get rid of riscv_pfn_base variable
> > > > > > > >>>>    mm: Introduce memblock_isolate_memory
> > > > > > > >>>>    arm64: Make use of memblock_isolate_memory for the li=
near mapping
> > > > > > > >>>>    riscv: Use PUD/P4D/PGD pages for the linear mapping
> > > > > > > >>> Kernel boot fine on RV64 but there is a failure which is =
still not
> > > > > > > >>> addressed. You can see this failure as following message =
in
> > > > > > > >>> kernel boot log:
> > > > > > > >>>      0.000000] Failed to add a System RAM resource at 802=
00000
> > > > > > > >> Hmmm I don't get that in any of my test configs, would you=
 mind
> > > > > > > >> sharing yours and your qemu command line?
> > > > > > > > Try alexghiti_test branch at
> > > > > > > > https://github.com/avpatel/linux.git
> > > > > > > >
> > > > > > > > I am building the kernel using defconfig and my rootfs is
> > > > > > > > based on busybox.
> > > > > > > >
> > > > > > > > My QEMU command is:
> > > > > > > > qemu-system-riscv64 -M virt -m 512M -nographic -bios
> > > > > > > > opensbi/build/platform/generic/firmware/fw_dynamic.bin -ker=
nel
> > > > > > > > ./build-riscv64/arch/riscv/boot/Image -append "root=3D/dev/=
ram rw
> > > > > > > > console=3DttyS0 earlycon" -initrd ./rootfs_riscv64.img -smp=
 4
> > > > > > >
> > > > > > >
> > > > > > > So splitting memblock.memory is the culprit, it "confuses" th=
e resources
> > > > > > > addition and I can only find hacky ways to fix that...
> > > > > > Hi Alexandre,
> > > > > >
> > > > > > We encountered the same error as Anup. After adding your patch
> > > > > > (3335068f87217ea59d08f462187dc856652eea15), we will not encount=
er the
> > > > > > error again.
> > > > > >
> > > > > > What I have observed so far is
> > > > > >
> > > > > > - before your patch
> > > > > > When merging consecutive memblocks, if the memblock types are d=
ifferent,
> > > > > > they will be merged into reserved
> > > > > > - after your patch
> > > > > > When consecutive memblocks are merged, if the memblock types ar=
e
> > > > > > different, they will be merged into memory.
> > > > > >
> > > > > > Such a result will cause the memory location of OpenSBI to be c=
hanged
> > > > > > from reserved to memory. Will this have any side effects?
> > > > >
> > > > > I guess it will end up in the memory pool and pages from openSBI
> > > > > region will be allocated, so we should see very quickly bad stuff
> > > > > happening (either PMP violation or M-mode ecall never
> > > > > returning/trapping/etc).
> > > > >
> > > > > But I don't observe the same thing, I always see the openSBI regi=
on
> > > > > being reserved:
> > > > >
> > > > > reserved[0x0] [0x0000000080000000-0x000000008007ffff],
> > > > > 0x0000000000080000 bytes flags: 0x0
> > > > >
> > > > > Can you elaborate a bit more about "When consecutive memblocks ar=
e
> > > > > merged, if the memblock types are different, they will be merged =
into
> > > > > memory"? Where/when does this merge happen? Can you give me a con=
fig
> > > > > file and a kernel revision so that I can take a look?
> > > > Ok, If you want to reproduce the same results you just need to modi=
fy OpenSBI
> > > >
> > > > [ lib/sbi/sbi_domain.c ]
> > > > +#define TEST_SIZE 0x200000
> > > >
> > > > -                                 (scratch->fw_size - scratch->fw_r=
w_offset),
> > > > +                                 (TEST_SIZE - scratch->fw_rw_offse=
t),
> > > >
> > > > In addition, you can insert checks in the kernel merged function
> > > > [ mm/memblock.c ]
> > > > static void __init_memblock memblock_merge_regions(struct memblock_=
type *type)
> > > >         while (i < type->cnt - 1) {
> > > >          ...
> > > >                 /* move forward from next + 1, index of which is i =
+ 2 */
> > > >                 memmove(next, next + 1, (type->cnt - (i + 2)) * siz=
eof(*next));
> > > >                 type->cnt--;
> > > >         }
> > > > +       pr_info("Merged memblock_type: cnt =3D %lu, max =3D %lu,
> > > > total_size =3D 0x%llx\n",type->cnt, type->max, type->total_size);
> > > > +       for (i =3D 0; i < type->cnt; i++) {
> > > > +               const char *region_type =3D
> > > > memblock_is_memory(type->regions[i].base) ? "memory" : "reserve";
> > > > +               pr_info("Region %d: base =3D 0x%llx, size =3D 0x%ll=
x, type
> > > > =3D %s\n", i, type->regions[i].base, type->regions[i].size,
> > > > region_type);
> > > > +       }
> > > >  }
> > > > This is kernel boot log
> > > > - before your patch
> > > > ...
> > > > [    0.000000] OF: fdt: Reserving memory: base =3D 0x80000000, size=
 =3D 0x200000
> > > > [    0.000000] Merged memblock_type: cnt =3D 4, max =3D 128, total_=
size =3D 0x1628501
> > > > [    0.000000] Region 0: base =3D 0x80000000, size =3D 0x1600000, t=
ype =3D reserve
> > > > ...
> > > >
> > > > - after your patch
> > > > ...
> > > > [    0.000000] OF: fdt: Reserving memory: base =3D 0x80000000, size=
 =3D 0x200000
> > > > [    0.000000] Merged memblock_type: cnt =3D 4, max =3D 128, total_=
size =3D 0x180c42e
> > > > [    0.000000] Region 0: base =3D 0x80000000, size =3D 0x1800000, t=
ype =3D memory
> > >
> > Hi Alex, thanks for your feedback.
> > > So the openSBI region is marked as memory, and not reserved because
> > > this region is now described as nomap, and memblock_mark_nomap() does
> > > not move this region into the reserved memblock list, but keep it in
> > > the memory list with the nomap flag
> > > (https://elixir.bootlin.com/linux/latest/source/drivers/of/fdt.c#L479=
).
> > > But as stated in the description of memblock_mark_nomap()
> > > (https://elixir.bootlin.com/linux/latest/source/mm/memblock.c#L969),
> > > the pages associated with the region will be marked as PageReserved
> > > and the region will not be covered in the linear mapping.
> > I traced it via GDB, and indeed, it enters
> > early_init_dt_reserve_memory() and calls memblock_reserve to reserve
> > this block of memory.
> >
> > [before your patch]
> > [    0.000000] OF: fdt: check nomap Reserving memory: base =3D
> > 0x80000000, size =3D 0x200000
> > [    0.000000] ---  Reserved memory: Base address: 80000000, Size:
> > 200000---
> > [    0.000000] Merged memblock_type: cnt =3D 4, max =3D 128, total_size=
 =3D
> > 0x1e28501
> > [    0.000000] Region 0: base =3D 0x80000000, size =3D 0x1e00000, type =
=3D
> > reserve
> > [    0.000000] Region 1: base =3D 0xbfe00000, size =3D 0x6002, type =3D
> > memory
> > ....
> > [    0.000000] OF: fdt: Reserved memory: reserved region for node
> > 'mmode_resv0@80000000': base 0x0000000080000000, size 2 MiB
> > [    0.000000] OF: reserved mem:
> > 0x0000000080000000..0x00000000801fffff (2048 KiB) map non-reusable
> > mmode_resv0@80000000
> >
> > [after your patch]
> > [    0.000000] OF: fdt: check nomap Reserving memory: base =3D
> > 0x80000000, size =3D 0x200000
> > [    0.000000] --- Reserved memory: Base address: 80000000, Size: 20000=
0---
> > [    0.000000] Merged memblock_type: cnt =3D 4, max =3D 128, total_size=
 =3D 0x1e25501
> > [    0.000000] Region 0: base =3D 0x80000000, size =3D 0x1e00000, type =
=3D memory
> > [    0.000000] Region 1: base =3D 0xbfe00000, size =3D 0x6002, type =3D=
 memory
> > ...
> > [    0.000000] OF: fdt: Reserved memory: reserved region for node
> > 'mmode_resv0@80000000': base 0x0000000080000000, size 2 MiB
> > [    0.000000] OF: reserved mem:
> > 0x0000000080000000..0x00000000801fffff (2048 KiB) map non-reusable
> > mmode_resv0@80000000
> >
> > At the moment, it can be confirmed that there is no need to worry
> > about this block of memory being used.
> >
> > But I still have a question I'd like to ask, which is why this
> > location is flagged as 'reserve' instead of 'memory' in the memblock
> Sorry, I asked the wrong question.
>
> Why is this location marked as "memory" instead of "reserve" in the membl=
ock?

No idea, let's see if @Mike Rapoport can answer this :)

> >
> > Thanks,
> > Nylon
> > >
> > > So to me, this is normal and we are safe. Let me know if I made a mis=
take.
> > >
> > > And sorry for the long delay, that slipped my mind!
> > >
> > > Thanks,
> > >
> > > Alex
> > >
> > > > ...
> > > > [    0.000000] Failed to add a system RAM resource at 80200000
> > > > ...
> > > > >
> > > > > Thanks,
> > > > >
> > > > > Alex
> > > > >
> > > > > > >
> > > > > > > So given that the arm64 patch with the new API is not pretty =
and that
> > > > > > > the simplest solution is to re-merge the memblock regions aft=
erwards
> > > > > > > (which is done by memblock_clear_nomap), I'll drop the new AP=
I and the
> > > > > > > arm64 patch to use the nomap API like arm64: I'll take advant=
age of that
> > > > > > > to clean setup_vm_final which I have wanted to do for a long =
time.
> > > > > > >
> > > > > > > @Mike Thanks for you reviews!
> > > > > > >
> > > > > > > @Anup Thanks for all your bug reports on this patchset, I hav=
e to
> > > > > > > improve my test flow (it is in the work :)).
> > > > > > >
> > > > > > >
> > > > > > > > Regards,
> > > > > > > > Anup
> > > > > > > >
> > > > > > > >> Thanks
> > > > > > > >>
> > > > > > > >>> Regards,
> > > > > > > >>> Anup
> > > > > > > >>>
> > > > > > > >>>>   arch/arm64/mm/mmu.c           | 25 +++++++++++------
> > > > > > > >>>>   arch/riscv/include/asm/page.h | 19 +++++++++++--
> > > > > > > >>>>   arch/riscv/mm/init.c          | 53 +++++++++++++++++++=
+++++++++-------
> > > > > > > >>>>   arch/riscv/mm/physaddr.c      | 16 +++++++++++
> > > > > > > >>>>   drivers/of/fdt.c              | 11 ++++----
> > > > > > > >>>>   include/linux/memblock.h      |  1 +
> > > > > > > >>>>   mm/memblock.c                 | 20 +++++++++++++
> > > > > > > >>>>   7 files changed, 119 insertions(+), 26 deletions(-)
> > > > > > > >>>>
> > > > > > > >>>> --
> > > > > > > >>>> 2.37.2
> > > > > > > >>>>
> > > > > > > > _______________________________________________
> > > > > > > > linux-riscv mailing list
> > > > > > > > linux-riscv@lists.infradead.org
> > > > > > > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> > > > > > >
> > > > > > > _______________________________________________
> > > > > > > linux-riscv mailing list
> > > > > > > linux-riscv@lists.infradead.org
> > > > > > > http://lists.infradead.org/mailman/listinfo/linux-riscv

