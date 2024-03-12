Return-Path: <linux-kernel+bounces-99895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E20AC878EE4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 07:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11E4B1C20C46
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 06:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0A2446A2;
	Tue, 12 Mar 2024 06:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="kKomquaD"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E2443AAF
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 06:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710225635; cv=none; b=MfxHyS5sdgGzS0ojoAa6rcZpydOXsonN1uvjYrlhBGkh0fFr78Xe/7T5/BtTGhlomBtX3Uu6zg1WS/CUEDqEojuyvk1M+AzmkKg8y6uVGfoQ+dtNpkwyf6c+lLD+lV663UoeQmZbW52fDfGaMmFnNocKKESmycw5+Mv3MFl/XJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710225635; c=relaxed/simple;
	bh=acd9eQ9b6SiLzZehjpLdXrYCQLVbH7eq8/mAZe3FsOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j3qk14hP2qJhq8SNzG362Ab/bHFA3PCYJRUEXsh60AetJx0hgczvU8ChElvN6G57AZf322FnYmBTh+qWEayD7dox8DkaovqtWUjICpkLnuZ+tMvCSylaJzKlNqyT0ztbea6G662aCdH6KKkJg1o8FvJTagx+fvlG/sVfs7YGMAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=kKomquaD; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dc74435c428so4992822276.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 23:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1710225632; x=1710830432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mib1xt+v7eiFKuFk82ox3G2c2WM33T8wDeEP+aPgnEY=;
        b=kKomquaDLp6BHb9BSe6oFeseRJho3YydGZD73NwzoAiY6Ttbai264g5kaHMci9vlfo
         sIrpqYsGAwfnswaD3hYYUQV19Hq8ctFg0n7jCZBkg1L45qdtrF0blY7S5k9oqlTTFO8n
         0BdVa02PWFzqCa/zvLGrWMYoZdm+uLBMU4d8EeKqMbHNFgRPiMgh+jowN/jhjzxRVZbX
         ovbsWDJf/3j2dZDJC9VHGzY360rIPVNbr9qkv/R2UOicGBKWl3p8/JeoI9VSomh83+8V
         VoC+ZoGc+jbbYGAX0X12nam56eL7E5zKtgr9FqZAo0VqWeynYcqFShqrgh/fa7Qg59sT
         KZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710225632; x=1710830432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mib1xt+v7eiFKuFk82ox3G2c2WM33T8wDeEP+aPgnEY=;
        b=K5xwytBCKF83gYSSsgOTucPWd16LRskNRpgwiW2gF4+C5I3GgaUVdvrS4LWXF5LmKy
         DIKBCeLK46KQ7ui2znCruGwXeiujDpokZV25ciMMMG5zHXDB/DONybAX7vxoYTyRw1ov
         c8BYRHV9AKvkeYf2IiAPpPVBgr8dkmGMjk9x9viHDEeeLswgWG86CXDWU4V6uIgTRmD2
         rN3MQquQL/IF983uqDL+Qy/E5pVNKBTUYTEiGTDSzZH+NcMlBnqdHDBgU/j7/GZEpL0M
         iF+pU/nCvm5Lpl67qZcLm/vcxRAnXpOtjQxLNzIuZgk0l1Cq4Dwlll4BuXrZTsB4YdYn
         Va7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWWMqCc/WJ+HBinjpPjuAT0oqeha7VbVtiyrP1ylhhBINKFiOfXh8GWEb1tx1zbSrH4iPinUdPtIBuxm8UwqOIfUbokBpPjziRYMYjW
X-Gm-Message-State: AOJu0YxOOPpnHilp12brLafQCy1d96pg3YCI/gG95eWAPeQAtDbunAt7
	pRd44bByOZX2jiaOtm8j5u8a1ZCyKhqc1TbHp+69LfnhzYILZTDGnie95zBDD8Z0JT9d2/pY3pF
	+3a+oLVaQfF6AWLOWzi6uHWhmgKD1nzNt05+vxw==
X-Google-Smtp-Source: AGHT+IHbiQrtWLjwG2bwttWyqC5snHDZdcXZiO3RLkmQ0MdJVMi6zl04cbHiQh12269BKPOmXAcs7OMummzUXBHp/Fc=
X-Received: by 2002:a25:ac24:0:b0:dcc:588f:1523 with SMTP id
 w36-20020a25ac24000000b00dcc588f1523mr6918049ybi.49.1710225632392; Mon, 11
 Mar 2024 23:40:32 -0700 (PDT)
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
 <CAHh=Yk-WCMbNWg7UCbXtZZzPmOHnh1-pv4fqykwnpJGtwTcc=A@mail.gmail.com> <CAHVXubhE=RmFQ5gGo7J+H-mOEZKZQbCCH6F43UYMOy=Kgw+nug@mail.gmail.com>
In-Reply-To: <CAHVXubhE=RmFQ5gGo7J+H-mOEZKZQbCCH6F43UYMOy=Kgw+nug@mail.gmail.com>
From: Nylon Chen <nylon.chen@sifive.com>
Date: Tue, 12 Mar 2024 14:40:20 +0800
Message-ID: <CAHh=Yk-C--ZGgfckGYceTOoj20V9H6DHQHMZ2z2kisuFbAhaBA@mail.gmail.com>
Subject: Re: Fwd: [PATCH v8 0/4] riscv: Use PUD/P4D/PGD pages for the linear mapping
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: alex@ghiti.fr, apatel@ventanamicro.com, catalin.marinas@arm.com, 
	will@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, robh+dt@kernel.org, frowand.list@gmail.com, 
	rppt@kernel.org, akpm@linux-foundation.org, anup@brainfault.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-mm@kvack.org, zong.li@sifive.com, nylon7717@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Alexandre Ghiti <alexghiti@rivosinc.com> =E6=96=BC 2024=E5=B9=B42=E6=9C=885=
=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=885:32=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Hi Nylon,
>
> On Fri, Jan 19, 2024 at 10:27=E2=80=AFAM Nylon Chen <nylon.chen@sifive.co=
m> wrote:
> >
> > Alexandre Ghiti <alexghiti@rivosinc.com> =E6=96=BC 2024=E5=B9=B41=E6=9C=
=8818=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=889:01=E5=AF=AB=E9=81=93=
=EF=BC=9A
> > >
> > > Hi Nylon,
> > Hi Alexandre, thanks for your feedback,
> > >
> > > On Thu, Jan 18, 2024 at 9:23=E2=80=AFAM Nylon Chen <nylon.chen@sifive=
com> wrote:
> > > >
> > > > > On 3/23/23 15:55, Anup Patel wrote:
> > > > > > On Thu, Mar 23, 2023 at 6:24=E2=80=AFPM Alexandre Ghiti <alexgh=
iti@rivosinc.com> wrote:
> > > > > >> Hi Anup,
> > > > > >>
> > > > > >> On Thu, Mar 23, 2023 at 1:18=E2=80=AFPM Anup Patel <apatel@ven=
tanamicro.com> wrote:
> > > > > >>> Hi Alex,
> > > > > >>>
> > > > > >>> On Thu, Mar 16, 2023 at 6:48=E2=80=AFPM Alexandre Ghiti <alex=
ghiti@rivosinc.com> wrote:
> > > > > >>>> This patchset intends to improve tlb utilization by using hu=
gepages for
> > > > > >>>> the linear mapping.
> > > > > >>>>
> > > > > >>>> As reported by Anup in v6, when STRICT_KERNEL_RWX is enabled=
, we must
> > > > > >>>> take care of isolating the kernel text and rodata so that th=
ey are not
> > > > > >>>> mapped with a PUD mapping which would then assign wrong perm=
issions to
> > > > > >>>> the whole region: it is achieved by introducing a new memblo=
ck API.
> > > > > >>>>
> > > > > >>>> Another patch makes use of this new API in arm64 which used =
some sort of
> > > > > >>>> hack to solve this issue: it was built/boot tested successfu=
lly.
> > > > > >>>>
> > > > > >>>> base-commit-tag: v6.3-rc1
> > > > > >>>>
> > > > > >>>> v8:
> > > > > >>>> - Fix rv32, as reported by Anup
> > > > > >>>> - Do not modify memblock_isolate_range and fixes comment, as=
 suggested by Mike
> > > > > >>>> - Use the new memblock API for crash kernel too in arm64, as=
 suggested by Andrew
> > > > > >>>> - Fix arm64 double mapping (which to me did not work in v7),=
 but ends up not
> > > > > >>>>    being pretty at all, will wait for comments from arm64 re=
viewers, but
> > > > > >>>>    this patch can easily be dropped if they do not want it.
> > > > > >>>>
> > > > > >>>> v7:
> > > > > >>>> - Fix Anup bug report by introducing memblock_isolate_memory=
 which
> > > > > >>>>    allows us to split the memblock mappings and then avoid t=
o map the
> > > > > >>>>    the PUD which contains the kernel as read only
> > > > > >>>> - Add a patch to arm64 to use this newly introduced API
> > > > > >>>>
> > > > > >>>> v6:
> > > > > >>>> - quiet LLVM warning by casting phys_ram_base into an unsign=
ed long
> > > > > >>>>
> > > > > >>>> v5:
> > > > > >>>> - Fix nommu builds by getting rid of riscv_pfn_base in patch=
 1, thanks
> > > > > >>>>    Conor
> > > > > >>>> - Add RB from Andrew
> > > > > >>>>
> > > > > >>>> v4:
> > > > > >>>> - Rebase on top of v6.2-rc3, as noted by Conor
> > > > > >>>> - Add Acked-by Rob
> > > > > >>>>
> > > > > >>>> v3:
> > > > > >>>> - Change the comment about initrd_start VA conversion so tha=
t it fits
> > > > > >>>>    ARM64 and RISCV64 (and others in the future if needed), a=
s suggested
> > > > > >>>>    by Rob
> > > > > >>>>
> > > > > >>>> v2:
> > > > > >>>> - Add a comment on why RISCV64 does not need to set initrd_s=
tart/end that
> > > > > >>>>    early in the boot process, as asked by Rob
> > > > > >>>>
> > > > > >>>> Alexandre Ghiti (4):
> > > > > >>>>    riscv: Get rid of riscv_pfn_base variable
> > > > > >>>>    mm: Introduce memblock_isolate_memory
> > > > > >>>>    arm64: Make use of memblock_isolate_memory for the linear=
 mapping
> > > > > >>>>    riscv: Use PUD/P4D/PGD pages for the linear mapping
> > > > > >>> Kernel boot fine on RV64 but there is a failure which is stil=
l not
> > > > > >>> addressed. You can see this failure as following message in
> > > > > >>> kernel boot log:
> > > > > >>>      0.000000] Failed to add a System RAM resource at 8020000=
0
> > > > > >> Hmmm I don't get that in any of my test configs, would you min=
d
> > > > > >> sharing yours and your qemu command line?
> > > > > > Try alexghiti_test branch at
> > > > > > https://github.com/avpatel/linux.git
> > > > > >
> > > > > > I am building the kernel using defconfig and my rootfs is
> > > > > > based on busybox.
> > > > > >
> > > > > > My QEMU command is:
> > > > > > qemu-system-riscv64 -M virt -m 512M -nographic -bios
> > > > > > opensbi/build/platform/generic/firmware/fw_dynamic.bin -kernel
> > > > > > ./build-riscv64/arch/riscv/boot/Image -append "root=3D/dev/ram =
rw
> > > > > > console=3DttyS0 earlycon" -initrd ./rootfs_riscv64.img -smp 4
> > > > >
> > > > >
> > > > > So splitting memblock.memory is the culprit, it "confuses" the re=
sources
> > > > > addition and I can only find hacky ways to fix that...
> > > > Hi Alexandre,
> > > >
> > > > We encountered the same error as Anup. After adding your patch
> > > > (3335068f87217ea59d08f462187dc856652eea15), we will not encounter t=
he
> > > > error again.
> > > >
> > > > What I have observed so far is
> > > >
> > > > - before your patch
> > > > When merging consecutive memblocks, if the memblock types are diffe=
rent,
> > > > they will be merged into reserved
> > > > - after your patch
> > > > When consecutive memblocks are merged, if the memblock types are
> > > > different, they will be merged into memory.
> > > >
> > > > Such a result will cause the memory location of OpenSBI to be chang=
ed
> > > > from reserved to memory. Will this have any side effects?
> > >
> > > I guess it will end up in the memory pool and pages from openSBI
> > > region will be allocated, so we should see very quickly bad stuff
> > > happening (either PMP violation or M-mode ecall never
> > > returning/trapping/etc).
> > >
> > > But I don't observe the same thing, I always see the openSBI region
> > > being reserved:
> > >
> > > reserved[0x0] [0x0000000080000000-0x000000008007ffff],
> > > 0x0000000000080000 bytes flags: 0x0
> > >
> > > Can you elaborate a bit more about "When consecutive memblocks are
> > > merged, if the memblock types are different, they will be merged into
> > > memory"? Where/when does this merge happen? Can you give me a config
> > > file and a kernel revision so that I can take a look?
> > Ok, If you want to reproduce the same results you just need to modify O=
penSBI
> >
> > [ lib/sbi/sbi_domain.c ]
> > +#define TEST_SIZE 0x200000
> >
> > -                                 (scratch->fw_size - scratch->fw_rw_of=
fset),
> > +                                 (TEST_SIZE - scratch->fw_rw_offset),
> >
> > In addition, you can insert checks in the kernel merged function
> > [ mm/memblock.c ]
> > static void __init_memblock memblock_merge_regions(struct memblock_type=
 *type)
> >         while (i < type->cnt - 1) {
> >          ...
> >                 /* move forward from next + 1, index of which is i + 2 =
*/
> >                 memmove(next, next + 1, (type->cnt - (i + 2)) * sizeof(=
*next));
> >                 type->cnt--;
> >         }
> > +       pr_info("Merged memblock_type: cnt =3D %lu, max =3D %lu,
> > total_size =3D 0x%llx\n",type->cnt, type->max, type->total_size);
> > +       for (i =3D 0; i < type->cnt; i++) {
> > +               const char *region_type =3D
> > memblock_is_memory(type->regions[i].base) ? "memory" : "reserve";
> > +               pr_info("Region %d: base =3D 0x%llx, size =3D 0x%llx, t=
ype
> > =3D %s\n", i, type->regions[i].base, type->regions[i].size,
> > region_type);
> > +       }
> >  }
> > This is kernel boot log
> > - before your patch
> > ...
> > [    0.000000] OF: fdt: Reserving memory: base =3D 0x80000000, size =3D=
 0x200000
> > [    0.000000] Merged memblock_type: cnt =3D 4, max =3D 128, total_size=
 =3D 0x1628501
> > [    0.000000] Region 0: base =3D 0x80000000, size =3D 0x1600000, type =
=3D reserve
> > ...
> >
> > - after your patch
> > ...
> > [    0.000000] OF: fdt: Reserving memory: base =3D 0x80000000, size =3D=
 0x200000
> > [    0.000000] Merged memblock_type: cnt =3D 4, max =3D 128, total_size=
 =3D 0x180c42e
> > [    0.000000] Region 0: base =3D 0x80000000, size =3D 0x1800000, type =
=3D memory
>
Hi Alex, thanks for your feedback.
> So the openSBI region is marked as memory, and not reserved because
> this region is now described as nomap, and memblock_mark_nomap() does
> not move this region into the reserved memblock list, but keep it in
> the memory list with the nomap flag
> (https://elixir.bootlin.com/linux/latest/source/drivers/of/fdt.c#L479).
> But as stated in the description of memblock_mark_nomap()
> (https://elixir.bootlin.com/linux/latest/source/mm/memblock.c#L969),
> the pages associated with the region will be marked as PageReserved
> and the region will not be covered in the linear mapping.
I traced it via GDB, and indeed, it enters
early_init_dt_reserve_memory() and calls memblock_reserve to reserve
this block of memory.

[before your patch]
[    0.000000] OF: fdt: check nomap Reserving memory: base =3D
0x80000000, size =3D 0x200000
[    0.000000] ---  Reserved memory: Base address: 80000000, Size:
200000---
[    0.000000] Merged memblock_type: cnt =3D 4, max =3D 128, total_size =3D
0x1e28501
[    0.000000] Region 0: base =3D 0x80000000, size =3D 0x1e00000, type =3D
reserve
[    0.000000] Region 1: base =3D 0xbfe00000, size =3D 0x6002, type =3D
memory
...
[    0.000000] OF: fdt: Reserved memory: reserved region for node
'mmode_resv0@80000000': base 0x0000000080000000, size 2 MiB
[    0.000000] OF: reserved mem:
0x0000000080000000..0x00000000801fffff (2048 KiB) map non-reusable
mmode_resv0@80000000

[after your patch]
[    0.000000] OF: fdt: check nomap Reserving memory: base =3D
0x80000000, size =3D 0x200000
[    0.000000] --- Reserved memory: Base address: 80000000, Size: 200000---
[    0.000000] Merged memblock_type: cnt =3D 4, max =3D 128, total_size =3D=
 0x1e25501
[    0.000000] Region 0: base =3D 0x80000000, size =3D 0x1e00000, type =3D =
memory
[    0.000000] Region 1: base =3D 0xbfe00000, size =3D 0x6002, type =3D mem=
ory
..
[    0.000000] OF: fdt: Reserved memory: reserved region for node
'mmode_resv0@80000000': base 0x0000000080000000, size 2 MiB
[    0.000000] OF: reserved mem:
0x0000000080000000..0x00000000801fffff (2048 KiB) map non-reusable
mmode_resv0@80000000

At the moment, it can be confirmed that there is no need to worry
about this block of memory being used.

But I still have a question I'd like to ask, which is why this
location is flagged as 'reserve' instead of 'memory' in the memblock

Thanks,
Nylon
>
> So to me, this is normal and we are safe. Let me know if I made a mistake=
.
>
> And sorry for the long delay, that slipped my mind!
>
> Thanks,
>
> Alex
>
> > ...
> > [    0.000000] Failed to add a system RAM resource at 80200000
> > ...
> > >
> > > Thanks,
> > >
> > > Alex
> > >
> > > > >
> > > > > So given that the arm64 patch with the new API is not pretty and =
that
> > > > > the simplest solution is to re-merge the memblock regions afterwa=
rds
> > > > > (which is done by memblock_clear_nomap), I'll drop the new API an=
d the
> > > > > arm64 patch to use the nomap API like arm64: I'll take advantage =
of that
> > > > > to clean setup_vm_final which I have wanted to do for a long time=
.
> > > > >
> > > > > @Mike Thanks for you reviews!
> > > > >
> > > > > @Anup Thanks for all your bug reports on this patchset, I have to
> > > > > improve my test flow (it is in the work :)).
> > > > >
> > > > >
> > > > > > Regards,
> > > > > > Anup
> > > > > >
> > > > > >> Thanks
> > > > > >>
> > > > > >>> Regards,
> > > > > >>> Anup
> > > > > >>>
> > > > > >>>>   arch/arm64/mm/mmu.c           | 25 +++++++++++------
> > > > > >>>>   arch/riscv/include/asm/page.h | 19 +++++++++++--
> > > > > >>>>   arch/riscv/mm/init.c          | 53 +++++++++++++++++++++++=
+++++-------
> > > > > >>>>   arch/riscv/mm/physaddr.c      | 16 +++++++++++
> > > > > >>>>   drivers/of/fdt.c              | 11 ++++----
> > > > > >>>>   include/linux/memblock.h      |  1 +
> > > > > >>>>   mm/memblock.c                 | 20 +++++++++++++
> > > > > >>>>   7 files changed, 119 insertions(+), 26 deletions(-)
> > > > > >>>>
> > > > > >>>> --
> > > > > >>>> 2.37.2
> > > > > >>>>
> > > > > > _______________________________________________
> > > > > > linux-riscv mailing list
> > > > > > linux-riscv@lists.infradead.org
> > > > > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> > > > >
> > > > > _______________________________________________
> > > > > linux-riscv mailing list
> > > > > linux-riscv@lists.infradead.org
> > > > > http://lists.infradead.org/mailman/listinfo/linux-riscv

