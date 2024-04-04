Return-Path: <linux-kernel+bounces-131896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEA5898D54
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 059431F2B4D1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F4F12DDBF;
	Thu,  4 Apr 2024 17:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ld+nTY7U"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2399E12B163
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 17:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712252239; cv=none; b=rpBGIiny855SRlTbVbqmlfkVY6tUmluH6wNpuilr81TH1Qq2nK2LclP2uWd2bb1TkIv7JzwDRfGjuC2DOdxdEF+nUWRengbhBZBYh1V1YhCi88wsN8yox5HH321ZN4OuDjpwE/PxoOEhWB05A5wti5Y3wdGKZHP37taNU34nHEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712252239; c=relaxed/simple;
	bh=qNxmB9dvz4cGF0PgT9uMqcRVLK8IoGpeK+milK+2GFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z8L6G0129Q2eOESzpZMEHq0SPk6a/PbNWXawlxqGuh2AZ4zhf7XAm7O+UVpknnqJsr8iFYx5KcmIdeWggRpRD8zHrxx5lfTCaQVYs4O0Yb90R3U/2g3KqNlmAuE1GciQLsT7h9M5AaOJFKDBaJXdFsm5LtnskSSQd8M10CUYoF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ld+nTY7U; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5ce6b5e3c4eso853138a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 10:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712252236; x=1712857036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q0YGAbo5VsMRKNvr6HUFHGXg4ydusoh6NcFGvWhqL/0=;
        b=ld+nTY7Uy8WOxSKWEYxjEzYATU5hGhfsFkHQTf5zrsljodbqECYA17vqJ5UUloCRFV
         tNi4meOHym16khgdCWPwK1antXXzJ6xnOjxWY6amDjTYXPrn712IMI53PS5PtFoS+muZ
         f2HugKYV+JDLC86vjS5teCs34mayoiLiVsNs3Xi17OsPhPBbmDsNRcydr786SULzlvo0
         8ffwkHYTTeY0GG2LU5M8aoXr3ymxtc0EswgYNM+EA1mFj8VYUno1vuQQigwHdr7xnUI9
         qfz+IPSv1AVlJsyREeYMzlW/wmu4ceKQ4s4Xj1LHnHrlBrEoB0bI6rpY/v/mEboPXEmf
         1GVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712252236; x=1712857036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q0YGAbo5VsMRKNvr6HUFHGXg4ydusoh6NcFGvWhqL/0=;
        b=UYe5OyttTaOTtgLMLKkID8goxP8XHjtU6/Th8/W+pwr/KEHMUZFGi4MTZTf6VLiCqU
         FkIT1niUikPYM2LnelMj2Ik98vQBaYpzCUlUm/Y6sg0BBXZoISI5sQ2mT8T8ihYN6+/e
         8GtYDR14RU/DK4LqwfpbRCQ+SK2/43VrqX7H3yl/V8qrK46SPOrlL+q/vOlGcb4BrT6z
         Yxqdd74BqaNssjcsraHesRiXoj7vmf6YDEHMXxh6t1mKu0IPcZDHpkrrZfkSIZAh4e10
         h0KN9oRFqAn6Xh5TXf+IcqU3FLG/vXhNjMB/+NilzaUG6dypNjp5FINXtr/ANZ8dRoMq
         4Rnw==
X-Forwarded-Encrypted: i=1; AJvYcCWASMx/iCcCVWSD3jvtxQPX9GQBkvtlkUUAxcpzkzh++cV0C0aj8ozi3wGsrGZlWdvicSI6dU1tX1gEoQMqS9fDu3f1mok3ZblhmJ2W
X-Gm-Message-State: AOJu0Yxc2rtZt0v2FDKMSrER/yW6kdqglWaVBlx6L71+0J31Q5Hea9+X
	5TkmWG4+23DnfsWOVtmL7WsmKtC6VRZe/8cjMgWBboiAm/HZ65I77fq32gA4C2TLgreNPBgEY16
	rZjNT56nHs3vcbx+CcEs612vmKHv05htHMgt7DA==
X-Google-Smtp-Source: AGHT+IE0DwpVP9FvdgUiEaX9DyIxnkxvkjXoN3ggf7SGLxyoGEAQiYNn0vs3zY4qK/tte6bUofAXx0ODGxiK9gbQHcs=
X-Received: by 2002:a17:90a:34c9:b0:2a2:bc66:1ead with SMTP id
 m9-20020a17090a34c900b002a2bc661eadmr3184921pjf.38.1712252236354; Thu, 04 Apr
 2024 10:37:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1689792825.git.tjeznach@rivosinc.com> <CAHCEehJKYu3-GSX2L6L4_VVvYt1MagRgPJvYTbqekrjPw3ZSkA@mail.gmail.com>
 <CANXhq0qsZS7sB-npPKdnFaWi2+yUc_dROCsVXZDHo07-a34wcw@mail.gmail.com>
In-Reply-To: <CANXhq0qsZS7sB-npPKdnFaWi2+yUc_dROCsVXZDHo07-a34wcw@mail.gmail.com>
From: Tomasz Jeznach <tjeznach@rivosinc.com>
Date: Thu, 4 Apr 2024 10:37:05 -0700
Message-ID: <CAH2o1u6seMkt5stxkpr4JCdmU3ZXDid5gDL7+9abNg=zPqdFdQ@mail.gmail.com>
Subject: Re: [PATCH 00/13] Linux RISC-V IOMMU Support
To: Zong Li <zong.li@sifive.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Anup Patel <apatel@ventanamicro.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Greentime Hu <greentime.hu@sifive.com>, linux@rivosinc.com, 
	"linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>, Sebastien Boeuf <seb@rivosinc.com>, iommu@lists.linux.dev, 
	Nick Kossifidis <mick@ics.forth.gr>, linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 6:04=E2=80=AFAM Zong Li <zong.li@sifive.com> wrote:
>
> >
> > The RISC-V IOMMU specification is now ratified as-per the RISC-V intern=
ational
> > process [1]. The latest frozen specifcation can be found at:
> > https://github.com/riscv-non-isa/riscv-iommu/releases/download/v1.0/ris=
cv-iommu.pdf
> >
> > At a high-level, the RISC-V IOMMU specification defines:
> > 1) Memory-mapped programming interface
> >    - Mandatory and optional registers layout and description.
> >    - Software guidelines for device initialization and capabilities dis=
covery.
> > 2) In-memory queue interface
> >    - A command-queue used by software to queue commands to the IOMMU.
> >    - A fault/event queue used to bring faults and events to software=E2=
=80=99s attention.
> >    - A page-request queue used to report =E2=80=9CPage Request=E2=80=9D=
 messages received from
> >      PCIe devices.
> >    - Message-signalled and wire-signaled interrupt mechanism.
> > 3) In-memory data structures
> >    - Device-context: used to associate a device with an address space a=
nd to hold
> >      other per-device parameters used by the IOMMU to perform address t=
ranslations.
> >    - Process-contexts: used to associate a different virtual address sp=
ace based on
> >      device provided process identification number.
> >    - MSI page table configuration used to direct an MSI to a guest inte=
rrupt file
> >      in an IMSIC. The MSI page table formats are defined by the Advance=
d Interrupt
> >      Architecture specification [2].
> >
> > This series introduces complete single-level translation support, inclu=
ding shared
> > virtual address (SVA), ATS/PRI interfaces in the kernel driver. Patches=
 adding MSI
> > identity remapping and G-Stage translation (GPA to SPA) are added only =
to excercise
> > hardware interfaces, to be complemented with AIA/KVM bindings in follow=
-up series.
> >
> > This series is a logical regrouping of series of incremental patches ba=
sed on
> > RISC-V International IOMMU Task Group discussions and specification dev=
elopment
> > process. Original series can be found at the maintainer's repository br=
anch [3].
> >
> > These patches can also be found in the riscv_iommu_v1 branch at:
> > https://github.com/tjeznach/linux/tree/riscv_iommu_v1
> >
> > To test this series, use QEMU/OpenSBI with RISC-V IOMMU implementation =
available in
> > the riscv_iommu_v1 branch at:
> > https://github.com/tjeznach/qemu/tree/riscv_iommu_v1
> >
> > References:
> > [1] - https://wiki.riscv.org/display/HOME/Specification+Status
> > [2] - https://github.com/riscv/riscv-aia/releases/download/1.0/riscv-in=
terrupts-1.0.pdf
> > [3] - https://github.com/tjeznach/qemu/tree/tjeznach/riscv-iommu-202307=
19
> >
> >
> > Anup Patel (1):
> >   dt-bindings: Add RISC-V IOMMU bindings
> >
> > Tomasz Jeznach (10):
> >   RISC-V: drivers/iommu: Add RISC-V IOMMU - Ziommu support.
> >   RISC-V: arch/riscv/config: enable RISC-V IOMMU support
> >   MAINTAINERS: Add myself for RISC-V IOMMU driver
> >   RISC-V: drivers/iommu/riscv: Add sysfs interface
> >   RISC-V: drivers/iommu/riscv: Add command, fault, page-req queues
> >   RISC-V: drivers/iommu/riscv: Add device context support
> >   RISC-V: drivers/iommu/riscv: Add page table support
> >   RISC-V: drivers/iommu/riscv: Add SVA with PASID/ATS/PRI support.
> >   RISC-V: drivers/iommu/riscv: Add MSI identity remapping
> >   RISC-V: drivers/iommu/riscv: Add G-Stage translation support
> >
> >  .../bindings/iommu/riscv,iommu.yaml           |  146 ++
> >  MAINTAINERS                                   |    7 +
> >  arch/riscv/configs/defconfig                  |    1 +
> >  drivers/iommu/Kconfig                         |    1 +
> >  drivers/iommu/Makefile                        |    2 +-
> >  drivers/iommu/io-pgtable.c                    |    3 +
> >  drivers/iommu/riscv/Kconfig                   |   22 +
> >  drivers/iommu/riscv/Makefile                  |    1 +
> >  drivers/iommu/riscv/io_pgtable.c              |  266 ++
> >  drivers/iommu/riscv/iommu-bits.h              |  704 ++++++
> >  drivers/iommu/riscv/iommu-pci.c               |  206 ++
> >  drivers/iommu/riscv/iommu-platform.c          |  160 ++
> >  drivers/iommu/riscv/iommu-sysfs.c             |  183 ++
> >  drivers/iommu/riscv/iommu.c                   | 2130 +++++++++++++++++
> >  drivers/iommu/riscv/iommu.h                   |  165 ++
> >  include/linux/io-pgtable.h                    |    2 +
> >  16 files changed, 3998 insertions(+), 1 deletion(-)
> >  create mode 100644 Documentation/devicetree/bindings/iommu/riscv,iommu=
yaml
> >  create mode 100644 drivers/iommu/riscv/Kconfig
> >  create mode 100644 drivers/iommu/riscv/Makefile
> >  create mode 100644 drivers/iommu/riscv/io_pgtable.c
> >  create mode 100644 drivers/iommu/riscv/iommu-bits.h
> >  create mode 100644 drivers/iommu/riscv/iommu-pci.c
> >  create mode 100644 drivers/iommu/riscv/iommu-platform.c
> >  create mode 100644 drivers/iommu/riscv/iommu-sysfs.c
> >  create mode 100644 drivers/iommu/riscv/iommu.c
> >  create mode 100644 drivers/iommu/riscv/iommu.h
> >
> > --
> > 2.34.1
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
>
> Hi Tomasz,
> Could I know if you have a plan for the next version and if you have
> any estimates for when the v2 patch will be ready? We have some
> patches based on top of your old implementation, and it would be great
> if we can rebase them onto your next version. Thanks.

Hi Zong,

Thank you for your interest. Next version of the iommu/riscv is almost read=
y to
be sent in next few days.
There is a number of bug fixes and design changes based on the testing and
great feedback after v1 was published.
Upcoming patch set will be smaller, with core functionality only, hopefully=
 to
make the review easier. Functionality related to the MSI remapping, shared
virtual addressing, nested translations will be moved to separate patch set=
s.

Complete, up to date revision is always available at
https://github.com/tjeznach/linux/

regards,
- Tomasz

