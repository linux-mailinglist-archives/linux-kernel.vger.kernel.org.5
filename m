Return-Path: <linux-kernel+bounces-30949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC3D8326A1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DA121C231C4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 09:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D82C28E10;
	Fri, 19 Jan 2024 09:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="dLSkOKMb"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A82F28E04
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 09:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705656434; cv=none; b=W8tb7nIpZD4xW+emXhARSjuexcF0qTDk8v42picMgNk0lGcrlCQULqWURMbMp+JcUPN1r2Tn4IUWqAJ3QKr8n/A8ujXyg4oxt0l+elCanqrAns6ouFHDOgCNrfyYkkEXQdLctBL4GNx2nNvWk67W3D0AHr4T1GCUckBmd6LReJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705656434; c=relaxed/simple;
	bh=Zyl+3TykfwIq/us1dz5F3GDNHUhcesXp1Emt+brcBpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nsROmQFQIy7uUqA0lsKi624CFXBUGZf6BgK8taVt7Wy6KB/POzDILaahB1Xl9Plllx7AY0/T1Lu9fZYThoukuMIFxybJzrEaHKU5J59zOdt3Xt74nR9fK2z7Mxn1iRGwTXztPUUkEwOFRIbTbCQIvrkV/b/XXgLOzGR4z+YoRgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=dLSkOKMb; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc261316b0dso514553276.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 01:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1705656431; x=1706261231; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PX3oyvjTSeaEmMA7BmGcrPiugjRL8juVncN6NIp0Uhw=;
        b=dLSkOKMbe6lsyXqUTxif3AT6U2BBDreuoyQ6jSJTregI+n6FSsEXESvPRU6TwVNYif
         +K6tEd2IpuE5y9I3EyFv8DRRSh42ssNj3uaFBVYQFW73BEESgaFDCodGLT3//KNBKTId
         x8bdCdZEgQWD1vz7d1oIAMUTdP+RNH8/J3lyaYBVNiWor59Ia4ZxOCXEntecoCizeg1C
         b6fT7g/7ViWQH3RFrecjPLTngvL5xfoHUfuG7509FgiRETFRqvoHe4qlolGR2eA3jPBW
         FbwyqwysmnJU/RYFM04QdcX958wG3kDKbWNOZUerfyUzQTa2BdhO7V2c3jn6iEynayft
         qydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705656431; x=1706261231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PX3oyvjTSeaEmMA7BmGcrPiugjRL8juVncN6NIp0Uhw=;
        b=XFmw5rE3AdhzgLAuaIU+gbF9mP5te5dPLO0r847+DgOoPlDGh5PIVZ7/TTZGQMEknt
         r7pV002lf7MAYXCYTwKF45EJR2XhBzAd5ZcSQBiuQAl47YvLShnLQJdLDj3Z1HqW7/KC
         4T66VuA9IMOM6WWhbKH4vX1S4WOoyesfLV5basT12EvnD7ujnBfi+e8W+VDldIeGuTcT
         vJymBk6Ydj4GMtBoaUUKKG7lTDk1XxuQ6WCNji+WiEP4o/1Rj0Y7rM0tbI1Mq2CkfO6w
         hjs9LiOPr7Bl9N2hGKHXwB132ur5sVi5d20ujxQepZBGbbpgrrhlBJilZ3uv1zebVXxj
         r/IA==
X-Gm-Message-State: AOJu0YwZeZVyRCIyKy70kwo/pfKVIrcYbqs1aVFa8TYjCaMkZcr90dKx
	cD7Ta6/NwhjZZgD4eIxed7eUzM20ZWMWhpcaaVAIdAmtE8FoLh1kznCAvszCFSJCOrEIdJcKyAQ
	kmBQP3g98s5NNj3sMxRsCxE2Zs5AGMFmdBSR6qA==
X-Google-Smtp-Source: AGHT+IFnB4ZjPfFgAynVnG8PcS3bLndBbDG8SKTtMgiDYr+D8XJYREVe4SCkVUjmR+ve+2tw/4wEl6cj595gux0wucE=
X-Received: by 2002:a25:1003:0:b0:dc2:65e7:b616 with SMTP id
 3-20020a251003000000b00dc265e7b616mr463094ybq.74.1705656431151; Fri, 19 Jan
 2024 01:27:11 -0800 (PST)
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
In-Reply-To: <CAHVXubiQ5N+ngdy=Fk3j-hS_KkOEg272b++-hB4-oGeSSZKtNQ@mail.gmail.com>
From: Nylon Chen <nylon.chen@sifive.com>
Date: Fri, 19 Jan 2024 17:26:59 +0800
Message-ID: <CAHh=Yk-WCMbNWg7UCbXtZZzPmOHnh1-pv4fqykwnpJGtwTcc=A@mail.gmail.com>
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

Alexandre Ghiti <alexghiti@rivosinc.com> =E6=96=BC 2024=E5=B9=B41=E6=9C=881=
8=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=889:01=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Hi Nylon,
Hi Alexandre, thanks for your feedback,
>
> On Thu, Jan 18, 2024 at 9:23=E2=80=AFAM Nylon Chen <nylon.chen@sifive.com=
> wrote:
> >
> > > On 3/23/23 15:55, Anup Patel wrote:
> > > > On Thu, Mar 23, 2023 at 6:24=E2=80=AFPM Alexandre Ghiti <alexghiti@=
rivosinc.com> wrote:
> > > >> Hi Anup,
> > > >>
> > > >> On Thu, Mar 23, 2023 at 1:18=E2=80=AFPM Anup Patel <apatel@ventana=
micro.com> wrote:
> > > >>> Hi Alex,
> > > >>>
> > > >>> On Thu, Mar 16, 2023 at 6:48=E2=80=AFPM Alexandre Ghiti <alexghit=
i@rivosinc.com> wrote:
> > > >>>> This patchset intends to improve tlb utilization by using hugepa=
ges for
> > > >>>> the linear mapping.
> > > >>>>
> > > >>>> As reported by Anup in v6, when STRICT_KERNEL_RWX is enabled, we=
 must
> > > >>>> take care of isolating the kernel text and rodata so that they a=
re not
> > > >>>> mapped with a PUD mapping which would then assign wrong permissi=
ons to
> > > >>>> the whole region: it is achieved by introducing a new memblock A=
PI.
> > > >>>>
> > > >>>> Another patch makes use of this new API in arm64 which used some=
 sort of
> > > >>>> hack to solve this issue: it was built/boot tested successfully.
> > > >>>>
> > > >>>> base-commit-tag: v6.3-rc1
> > > >>>>
> > > >>>> v8:
> > > >>>> - Fix rv32, as reported by Anup
> > > >>>> - Do not modify memblock_isolate_range and fixes comment, as sug=
gested by Mike
> > > >>>> - Use the new memblock API for crash kernel too in arm64, as sug=
gested by Andrew
> > > >>>> - Fix arm64 double mapping (which to me did not work in v7), but=
 ends up not
> > > >>>>    being pretty at all, will wait for comments from arm64 review=
ers, but
> > > >>>>    this patch can easily be dropped if they do not want it.
> > > >>>>
> > > >>>> v7:
> > > >>>> - Fix Anup bug report by introducing memblock_isolate_memory whi=
ch
> > > >>>>    allows us to split the memblock mappings and then avoid to ma=
p the
> > > >>>>    the PUD which contains the kernel as read only
> > > >>>> - Add a patch to arm64 to use this newly introduced API
> > > >>>>
> > > >>>> v6:
> > > >>>> - quiet LLVM warning by casting phys_ram_base into an unsigned l=
ong
> > > >>>>
> > > >>>> v5:
> > > >>>> - Fix nommu builds by getting rid of riscv_pfn_base in patch 1, =
thanks
> > > >>>>    Conor
> > > >>>> - Add RB from Andrew
> > > >>>>
> > > >>>> v4:
> > > >>>> - Rebase on top of v6.2-rc3, as noted by Conor
> > > >>>> - Add Acked-by Rob
> > > >>>>
> > > >>>> v3:
> > > >>>> - Change the comment about initrd_start VA conversion so that it=
 fits
> > > >>>>    ARM64 and RISCV64 (and others in the future if needed), as su=
ggested
> > > >>>>    by Rob
> > > >>>>
> > > >>>> v2:
> > > >>>> - Add a comment on why RISCV64 does not need to set initrd_start=
/end that
> > > >>>>    early in the boot process, as asked by Rob
> > > >>>>
> > > >>>> Alexandre Ghiti (4):
> > > >>>>    riscv: Get rid of riscv_pfn_base variable
> > > >>>>    mm: Introduce memblock_isolate_memory
> > > >>>>    arm64: Make use of memblock_isolate_memory for the linear map=
ping
> > > >>>>    riscv: Use PUD/P4D/PGD pages for the linear mapping
> > > >>> Kernel boot fine on RV64 but there is a failure which is still no=
t
> > > >>> addressed. You can see this failure as following message in
> > > >>> kernel boot log:
> > > >>>      0.000000] Failed to add a System RAM resource at 80200000
> > > >> Hmmm I don't get that in any of my test configs, would you mind
> > > >> sharing yours and your qemu command line?
> > > > Try alexghiti_test branch at
> > > > https://github.com/avpatel/linux.git
> > > >
> > > > I am building the kernel using defconfig and my rootfs is
> > > > based on busybox.
> > > >
> > > > My QEMU command is:
> > > > qemu-system-riscv64 -M virt -m 512M -nographic -bios
> > > > opensbi/build/platform/generic/firmware/fw_dynamic.bin -kernel
> > > > ./build-riscv64/arch/riscv/boot/Image -append "root=3D/dev/ram rw
> > > > console=3DttyS0 earlycon" -initrd ./rootfs_riscv64.img -smp 4
> > >
> > >
> > > So splitting memblock.memory is the culprit, it "confuses" the resour=
ces
> > > addition and I can only find hacky ways to fix that...
> > Hi Alexandre,
> >
> > We encountered the same error as Anup. After adding your patch
> > (3335068f87217ea59d08f462187dc856652eea15), we will not encounter the
> > error again.
> >
> > What I have observed so far is
> >
> > - before your patch
> > When merging consecutive memblocks, if the memblock types are different=
,
> > they will be merged into reserved
> > - after your patch
> > When consecutive memblocks are merged, if the memblock types are
> > different, they will be merged into memory.
> >
> > Such a result will cause the memory location of OpenSBI to be changed
> > from reserved to memory. Will this have any side effects?
>
> I guess it will end up in the memory pool and pages from openSBI
> region will be allocated, so we should see very quickly bad stuff
> happening (either PMP violation or M-mode ecall never
> returning/trapping/etc).
>
> But I don't observe the same thing, I always see the openSBI region
> being reserved:
>
> reserved[0x0] [0x0000000080000000-0x000000008007ffff],
> 0x0000000000080000 bytes flags: 0x0
>
> Can you elaborate a bit more about "When consecutive memblocks are
> merged, if the memblock types are different, they will be merged into
> memory"? Where/when does this merge happen? Can you give me a config
> file and a kernel revision so that I can take a look?
Ok, If you want to reproduce the same results you just need to modify OpenS=
BI

[ lib/sbi/sbi_domain.c ]
+#define TEST_SIZE 0x200000

-                                 (scratch->fw_size - scratch->fw_rw_offset=
),
+                                 (TEST_SIZE - scratch->fw_rw_offset),

In addition, you can insert checks in the kernel merged function
[ mm/memblock.c ]
static void __init_memblock memblock_merge_regions(struct memblock_type *ty=
pe)
        while (i < type->cnt - 1) {
         ...
                /* move forward from next + 1, index of which is i + 2 */
                memmove(next, next + 1, (type->cnt - (i + 2)) * sizeof(*nex=
t));
                type->cnt--;
        }
+       pr_info("Merged memblock_type: cnt =3D %lu, max =3D %lu,
total_size =3D 0x%llx\n",type->cnt, type->max, type->total_size);
+       for (i =3D 0; i < type->cnt; i++) {
+               const char *region_type =3D
memblock_is_memory(type->regions[i].base) ? "memory" : "reserve";
+               pr_info("Region %d: base =3D 0x%llx, size =3D 0x%llx, type
=3D %s\n", i, type->regions[i].base, type->regions[i].size,
region_type);
+       }
 }
This is kernel boot log
- before your patch
..
[    0.000000] OF: fdt: Reserving memory: base =3D 0x80000000, size =3D 0x2=
00000
[    0.000000] Merged memblock_type: cnt =3D 4, max =3D 128, total_size =3D=
 0x1628501
[    0.000000] Region 0: base =3D 0x80000000, size =3D 0x1600000, type =3D =
reserve
..

- after your patch
..
[    0.000000] OF: fdt: Reserving memory: base =3D 0x80000000, size =3D 0x2=
00000
[    0.000000] Merged memblock_type: cnt =3D 4, max =3D 128, total_size =3D=
 0x180c42e
[    0.000000] Region 0: base =3D 0x80000000, size =3D 0x1800000, type =3D =
memory
..
[    0.000000] Failed to add a system RAM resource at 80200000
..
>
> Thanks,
>
> Alex
>
> > >
> > > So given that the arm64 patch with the new API is not pretty and that
> > > the simplest solution is to re-merge the memblock regions afterwards
> > > (which is done by memblock_clear_nomap), I'll drop the new API and th=
e
> > > arm64 patch to use the nomap API like arm64: I'll take advantage of t=
hat
> > > to clean setup_vm_final which I have wanted to do for a long time.
> > >
> > > @Mike Thanks for you reviews!
> > >
> > > @Anup Thanks for all your bug reports on this patchset, I have to
> > > improve my test flow (it is in the work :)).
> > >
> > >
> > > > Regards,
> > > > Anup
> > > >
> > > >> Thanks
> > > >>
> > > >>> Regards,
> > > >>> Anup
> > > >>>
> > > >>>>   arch/arm64/mm/mmu.c           | 25 +++++++++++------
> > > >>>>   arch/riscv/include/asm/page.h | 19 +++++++++++--
> > > >>>>   arch/riscv/mm/init.c          | 53 +++++++++++++++++++++++++++=
+-------
> > > >>>>   arch/riscv/mm/physaddr.c      | 16 +++++++++++
> > > >>>>   drivers/of/fdt.c              | 11 ++++----
> > > >>>>   include/linux/memblock.h      |  1 +
> > > >>>>   mm/memblock.c                 | 20 +++++++++++++
> > > >>>>   7 files changed, 119 insertions(+), 26 deletions(-)
> > > >>>>
> > > >>>> --
> > > >>>> 2.37.2
> > > >>>>
> > > > _______________________________________________
> > > > linux-riscv mailing list
> > > > linux-riscv@lists.infradead.org
> > > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> > >
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv

