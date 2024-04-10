Return-Path: <linux-kernel+bounces-137941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 759EF89E9DA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5592B2123B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 05:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4AF610A03;
	Wed, 10 Apr 2024 05:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="S1PigOQ5"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D761426C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 05:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712727511; cv=none; b=RmqIcyB/0qpeDUjtMnnoslmQZzdC7wk4F+4E9KOHymWtthRj9WnqA0iSpv7q+dYR+/BoaUDDjQttgUBQucryHFeSnqt1pbLAQSzyqPAtgysSgpJ4Adqkoa3qPXc7dEce8bndQjupjJQ35LqDSfabzx8U265WsfzK62KNOnqYdXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712727511; c=relaxed/simple;
	bh=+9+L2kHWMv3KQHma9lsd++8eJt0ygE2Yz+AfV00c058=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RIli4JXNi0x89FR1t+Kj4CsrrR2lVi8yEOl1pT6Q6kXVqBFTnGPjFqJmAN4sAQJ2WZQQB7kt7SC11pNoFhr6djpVO349fs/d/akS3lMlIEwGdEDNuy8bqvKIHRTrExWOA/wRA3lvQHs0DliGZB5YlKOdk0UY9uWSFsGESJCIMd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=S1PigOQ5; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7d5ee54dcecso126282639f.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 22:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1712727509; x=1713332309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zps37+wx+8BpVN9iAnmr96g7jK1/JHf0fCdH0YamnZw=;
        b=S1PigOQ59vn59OXCZPxVyUllZkUQbMSvuhJH3ilMNKzZZmYCKewkRe5lzpX5V03Gpf
         m+Bt2PMjqXWvhi5YLOu4L3WQQ25VUjYMvfV0cR0Ker7R44fhCqC/cnMGv8KeFiKICk2v
         np7mDUqSTdCf4qEZbNLAICka7/5kIhpY9d49Jh9otUM3kDNWDzPZWAi8hJ4qODIZk11F
         f/jlewfmuR05H4ApSysH6EZcFSonqVvDidhFQlPY3+uAaj8OTXbRRqbYuTFtJf8hPXVe
         zDMlMRiiqz67hY8mWnSLLyg/O1GOGwcfliu3AofwHJ2lAW4AUkF+z8hggSOmYZtXoxTE
         2E4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712727509; x=1713332309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zps37+wx+8BpVN9iAnmr96g7jK1/JHf0fCdH0YamnZw=;
        b=R05EoOB1ZaprWVitad04swpGuR2lRMWQMx/nwOSu/NodRE6m1Y9c4588GTONBHl/WX
         4QGZArCPAtdFnJH5bvvZ3ZFUI8Nu2kV3hAw1OFScfVFaS0bX3R1r8z1vQP2ZtGxZtjdA
         5Q1CxSqx0dbTtAsapmI7UZCjMXGDNm3TMSRjYmjqEcvdNMaA4h+wQKQVUKVD9G7at9c8
         IzuVwcOlADgy5/brw3i8Mi9sCZi54BHym7+HCm3Z6IcHHnLzY20NVh3YtpTeT+Ykjm9C
         198YDBMi/CyyNfFxyzEfPUrFAOEodGQA/+gPkeVb5gfJS1PV4eGTvaTMkB39OntGY4PH
         2ONw==
X-Forwarded-Encrypted: i=1; AJvYcCX1YzVSdbf44hV06Xb8XzL91LzKebad+0N4JTScmnE2Nlvup6AJstWsSUXpPoC9bGE2LIg4c+TXB+pPfOEZfPVpVG8D7YoH9BEd8I3Z
X-Gm-Message-State: AOJu0YwUdKF19PPcL5COielFcTF3VuaJWexFLwa6HfV/ScRuuIOZp34M
	ZOFsJDy03g97JY85OC15AAkZTfEA/8pLTJDY3TBror5R+vw5EiDhSPm5yfp6y3l0goXe4WixQ7g
	6NcT6z/PBXYmQLRNljZzkXFFO6rnFxwA6OLo29Q==
X-Google-Smtp-Source: AGHT+IFfgMdOzUfmcVSJNzPCP4yYQYg4OxbTb9D6c3creQA/W5okjZTZdDb+ceXD+GCtHeiuEswcsb0BN7FHG1gyU+w=
X-Received: by 2002:a05:6602:4186:b0:7d5:ea22:5a0 with SMTP id
 bx6-20020a056602418600b007d5ea2205a0mr2389145iob.9.1712727509280; Tue, 09 Apr
 2024 22:38:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1689792825.git.tjeznach@rivosinc.com> <CAHCEehJKYu3-GSX2L6L4_VVvYt1MagRgPJvYTbqekrjPw3ZSkA@mail.gmail.com>
 <CANXhq0qsZS7sB-npPKdnFaWi2+yUc_dROCsVXZDHo07-a34wcw@mail.gmail.com> <CAH2o1u6seMkt5stxkpr4JCdmU3ZXDid5gDL7+9abNg=zPqdFdQ@mail.gmail.com>
In-Reply-To: <CAH2o1u6seMkt5stxkpr4JCdmU3ZXDid5gDL7+9abNg=zPqdFdQ@mail.gmail.com>
From: Zong Li <zong.li@sifive.com>
Date: Wed, 10 Apr 2024 13:38:18 +0800
Message-ID: <CANXhq0q0UakMSBQ=j0K21TpC-Hq8eX4BrFQ0K6XzQ=h1Pr_buA@mail.gmail.com>
Subject: Re: [PATCH 00/13] Linux RISC-V IOMMU Support
To: Tomasz Jeznach <tjeznach@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Anup Patel <apatel@ventanamicro.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Greentime Hu <greentime.hu@sifive.com>, linux@rivosinc.com, 
	"linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>, Sebastien Boeuf <seb@rivosinc.com>, iommu@lists.linux.dev, 
	Nick Kossifidis <mick@ics.forth.gr>, linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 1:37=E2=80=AFAM Tomasz Jeznach <tjeznach@rivosinc.co=
m> wrote:
>
> On Fri, Feb 23, 2024 at 6:04=E2=80=AFAM Zong Li <zong.li@sifive.com> wrot=
e:
> >
> > >
> > > The RISC-V IOMMU specification is now ratified as-per the RISC-V inte=
rnational
> > > process [1]. The latest frozen specifcation can be found at:
> > > https://github.com/riscv-non-isa/riscv-iommu/releases/download/v1.0/r=
iscv-iommu.pdf
> > >
> > > At a high-level, the RISC-V IOMMU specification defines:
> > > 1) Memory-mapped programming interface
> > >    - Mandatory and optional registers layout and description.
> > >    - Software guidelines for device initialization and capabilities d=
iscovery.
> > > 2) In-memory queue interface
> > >    - A command-queue used by software to queue commands to the IOMMU.
> > >    - A fault/event queue used to bring faults and events to software=
=E2=80=99s attention.
> > >    - A page-request queue used to report =E2=80=9CPage Request=E2=80=
=9D messages received from
> > >      PCIe devices.
> > >    - Message-signalled and wire-signaled interrupt mechanism.
> > > 3) In-memory data structures
> > >    - Device-context: used to associate a device with an address space=
 and to hold
> > >      other per-device parameters used by the IOMMU to perform address=
 translations.
> > >    - Process-contexts: used to associate a different virtual address =
space based on
> > >      device provided process identification number.
> > >    - MSI page table configuration used to direct an MSI to a guest in=
terrupt file
> > >      in an IMSIC. The MSI page table formats are defined by the Advan=
ced Interrupt
> > >      Architecture specification [2].
> > >
> > > This series introduces complete single-level translation support, inc=
luding shared
> > > virtual address (SVA), ATS/PRI interfaces in the kernel driver. Patch=
es adding MSI
> > > identity remapping and G-Stage translation (GPA to SPA) are added onl=
y to excercise
> > > hardware interfaces, to be complemented with AIA/KVM bindings in foll=
ow-up series.
> > >
> > > This series is a logical regrouping of series of incremental patches =
based on
> > > RISC-V International IOMMU Task Group discussions and specification d=
evelopment
> > > process. Original series can be found at the maintainer's repository =
branch [3].
> > >
> > > These patches can also be found in the riscv_iommu_v1 branch at:
> > > https://github.com/tjeznach/linux/tree/riscv_iommu_v1
> > >
> > > To test this series, use QEMU/OpenSBI with RISC-V IOMMU implementatio=
n available in
> > > the riscv_iommu_v1 branch at:
> > > https://github.com/tjeznach/qemu/tree/riscv_iommu_v1
> > >
> > > References:
> > > [1] - https://wiki.riscv.org/display/HOME/Specification+Status
> > > [2] - https://github.com/riscv/riscv-aia/releases/download/1.0/riscv-=
interrupts-1.0.pdf
> > > [3] - https://github.com/tjeznach/qemu/tree/tjeznach/riscv-iommu-2023=
0719
> > >
> > >
> > > Anup Patel (1):
> > >   dt-bindings: Add RISC-V IOMMU bindings
> > >
> > > Tomasz Jeznach (10):
> > >   RISC-V: drivers/iommu: Add RISC-V IOMMU - Ziommu support.
> > >   RISC-V: arch/riscv/config: enable RISC-V IOMMU support
> > >   MAINTAINERS: Add myself for RISC-V IOMMU driver
> > >   RISC-V: drivers/iommu/riscv: Add sysfs interface
> > >   RISC-V: drivers/iommu/riscv: Add command, fault, page-req queues
> > >   RISC-V: drivers/iommu/riscv: Add device context support
> > >   RISC-V: drivers/iommu/riscv: Add page table support
> > >   RISC-V: drivers/iommu/riscv: Add SVA with PASID/ATS/PRI support.
> > >   RISC-V: drivers/iommu/riscv: Add MSI identity remapping
> > >   RISC-V: drivers/iommu/riscv: Add G-Stage translation support
> > >
> > >  .../bindings/iommu/riscv,iommu.yaml           |  146 ++
> > >  MAINTAINERS                                   |    7 +
> > >  arch/riscv/configs/defconfig                  |    1 +
> > >  drivers/iommu/Kconfig                         |    1 +
> > >  drivers/iommu/Makefile                        |    2 +-
> > >  drivers/iommu/io-pgtable.c                    |    3 +
> > >  drivers/iommu/riscv/Kconfig                   |   22 +
> > >  drivers/iommu/riscv/Makefile                  |    1 +
> > >  drivers/iommu/riscv/io_pgtable.c              |  266 ++
> > >  drivers/iommu/riscv/iommu-bits.h              |  704 ++++++
> > >  drivers/iommu/riscv/iommu-pci.c               |  206 ++
> > >  drivers/iommu/riscv/iommu-platform.c          |  160 ++
> > >  drivers/iommu/riscv/iommu-sysfs.c             |  183 ++
> > >  drivers/iommu/riscv/iommu.c                   | 2130 +++++++++++++++=
++
> > >  drivers/iommu/riscv/iommu.h                   |  165 ++
> > >  include/linux/io-pgtable.h                    |    2 +
> > >  16 files changed, 3998 insertions(+), 1 deletion(-)
> > >  create mode 100644 Documentation/devicetree/bindings/iommu/riscv,iom=
mu.yaml
> > >  create mode 100644 drivers/iommu/riscv/Kconfig
> > >  create mode 100644 drivers/iommu/riscv/Makefile
> > >  create mode 100644 drivers/iommu/riscv/io_pgtable.c
> > >  create mode 100644 drivers/iommu/riscv/iommu-bits.h
> > >  create mode 100644 drivers/iommu/riscv/iommu-pci.c
> > >  create mode 100644 drivers/iommu/riscv/iommu-platform.c
> > >  create mode 100644 drivers/iommu/riscv/iommu-sysfs.c
> > >  create mode 100644 drivers/iommu/riscv/iommu.c
> > >  create mode 100644 drivers/iommu/riscv/iommu.h
> > >
> > > --
> > > 2.34.1
> > >
> > >
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> >
> > Hi Tomasz,
> > Could I know if you have a plan for the next version and if you have
> > any estimates for when the v2 patch will be ready? We have some
> > patches based on top of your old implementation, and it would be great
> > if we can rebase them onto your next version. Thanks.
>
> Hi Zong,
>
> Thank you for your interest. Next version of the iommu/riscv is almost re=
ady to
> be sent in next few days.

Hi Tomasz,
Thanks you for the update, I would help to review the v2 series as well.

> There is a number of bug fixes and design changes based on the testing an=
d
> great feedback after v1 was published.
> Upcoming patch set will be smaller, with core functionality only, hopeful=
ly to
> make the review easier. Functionality related to the MSI remapping, share=
d
> virtual addressing, nested translations will be moved to separate patch s=
ets.
>
> Complete, up to date revision is always available at
> https://github.com/tjeznach/linux/
>
> regards,
> - Tomasz

