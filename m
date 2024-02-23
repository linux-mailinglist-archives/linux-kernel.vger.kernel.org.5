Return-Path: <linux-kernel+bounces-78442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7336A86138F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27416284441
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E278003B;
	Fri, 23 Feb 2024 14:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="aZKL1Y9U"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674C87F7E8
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 14:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708697067; cv=none; b=C1cs8LOQNDBDvM/ePXT+bAJV5oa4usq+MyJ0XBSHl9ZChiLUFdQLf+Sx24bD1WblYrUOC1A0LhT9oJrUxM/9sAt4ptmVV+67P4anZflnGrMRurMALT4JG9qKEJmlPmGRIEeXwbDVLRozwkHjO8w3886TGew6c3eR2drwvTlYzEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708697067; c=relaxed/simple;
	bh=dBiElgOr95kAXqHLkrS8jy2/CWPZ4qM99KR7X+Crw9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gyt4Gd7vYaag8aGNSSz5o1gmzdB6tCxqjqtRfdm+GonDa4VYQjCCSsB8UaZsJ7qMfEmo7tXkGEeokRKxIvadd8WKjsKiHCJwmwe0xDN+vHwSCzAMUw/Sn2YAN3ceBjltfGJVOFEj3KEQyi46c1/F9c8mvE3oh6+qOPkfYEUL/zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=aZKL1Y9U; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2184133da88so425705fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 06:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1708697064; x=1709301864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8g40GSj1SuM3MvNOVaVxi58BU8kqY9DyWAR2wyASV2c=;
        b=aZKL1Y9Ua/fCV1Xw6iTBctlXF7adk8oYEWSCpRpc9Lv+eafB7ZPruRfOAx/WX3lF/Z
         xkvARgV8i9Pfj8R+/4S2QAPcO+KUAPNWX1bo0MF7UtvPvDVAgeSXpIn22YgO6qWwIu0k
         yC93eoWHX9upPuJDRBugT5fFNaDYwAtV3ycQV3TzwMdZ+hnQvssOWW/1+YlmYzeDK+En
         BIrx7y39cnI28tRh8AVsiVpFmGwhOTDkeVEp8+HsD8RX4eEwNWbH9YQTmc5GBeTBs9yo
         PwwXEdy9qxQd18nlwRmsCofeCvf1tdjmSwMscMUg1FwkifIiGX9Iqp7+wV37i17fFL2m
         3mJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708697064; x=1709301864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8g40GSj1SuM3MvNOVaVxi58BU8kqY9DyWAR2wyASV2c=;
        b=S6D1+Wea3RHvQ0vXxKCiiWf7IzbuNffw9LIot66bEyTv0tIKiizrPBWxnVBfNundzb
         EC3SChTqvW/TQa04bV/UrMeHOykK3xU8qdJEuRM47hdcZ2MLnyQRmR2DyRQInPxwrGba
         Z88wkBSJ6j59NODAlwglT01JEyUp2nibUcqFX3a+sVQeHWkJ86CfthHF5Ju3qslWxW8p
         DcUhqt6TyA/52uh5SBrMFl+Nnvw+5BHG7kJeYa/k/EXznJxQGc8zyOKk0s+f640VdbXO
         2DdXAR1vOBGT+PWNmiZVJk4HLvSjBoEOqcRtgT94aigpzjFmqMpNz2Na4ki25k2ucW8d
         WljQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/pn8LJRPIUf7PspJIx5p7+7GgQxpUhJQ/dRLIimrv6XgNMrmNwaBSt303NDmlerR/aJhHBCK318lhZj2s+Djp/2zJWD6yQK4PchNN
X-Gm-Message-State: AOJu0YzCS8INMYdTRhBvrNDiqt5ws4RMUBqQ8YrPuJROoV3Q/MR+a9Oc
	TQQP281EiH0y21l0HK+xErlvHB9jO63wLarTBhq7tb/PYScUc0Utkji9nBVCFCzXlBL3JM1GiE4
	D3uqtjVyjQB5V4qMCbP+yp1qRO5xtXx2W+c2ZaQ==
X-Google-Smtp-Source: AGHT+IHYBIX6HbsjNo7yyi7/bw4LuehBOxec802PGYW7ieaze/5sJtuWKqHmCdvfviB98HjMRINz+MEtpbXXzNcM6EI=
X-Received: by 2002:a05:6871:28a6:b0:21e:d92b:ef39 with SMTP id
 bq38-20020a05687128a600b0021ed92bef39mr2121534oac.27.1708697064350; Fri, 23
 Feb 2024 06:04:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1689792825.git.tjeznach@rivosinc.com> <CAHCEehJKYu3-GSX2L6L4_VVvYt1MagRgPJvYTbqekrjPw3ZSkA@mail.gmail.com>
In-Reply-To: <CAHCEehJKYu3-GSX2L6L4_VVvYt1MagRgPJvYTbqekrjPw3ZSkA@mail.gmail.com>
From: Zong Li <zong.li@sifive.com>
Date: Fri, 23 Feb 2024 22:04:13 +0800
Message-ID: <CANXhq0qsZS7sB-npPKdnFaWi2+yUc_dROCsVXZDHo07-a34wcw@mail.gmail.com>
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

>
> The RISC-V IOMMU specification is now ratified as-per the RISC-V internat=
ional
> process [1]. The latest frozen specifcation can be found at:
> https://github.com/riscv-non-isa/riscv-iommu/releases/download/v1.0/riscv=
-iommu.pdf
>
> At a high-level, the RISC-V IOMMU specification defines:
> 1) Memory-mapped programming interface
>    - Mandatory and optional registers layout and description.
>    - Software guidelines for device initialization and capabilities disco=
very.
> 2) In-memory queue interface
>    - A command-queue used by software to queue commands to the IOMMU.
>    - A fault/event queue used to bring faults and events to software=E2=
=80=99s attention.
>    - A page-request queue used to report =E2=80=9CPage Request=E2=80=9D m=
essages received from
>      PCIe devices.
>    - Message-signalled and wire-signaled interrupt mechanism.
> 3) In-memory data structures
>    - Device-context: used to associate a device with an address space and=
 to hold
>      other per-device parameters used by the IOMMU to perform address tra=
nslations.
>    - Process-contexts: used to associate a different virtual address spac=
e based on
>      device provided process identification number.
>    - MSI page table configuration used to direct an MSI to a guest interr=
upt file
>      in an IMSIC. The MSI page table formats are defined by the Advanced =
Interrupt
>      Architecture specification [2].
>
> This series introduces complete single-level translation support, includi=
ng shared
> virtual address (SVA), ATS/PRI interfaces in the kernel driver. Patches a=
dding MSI
> identity remapping and G-Stage translation (GPA to SPA) are added only to=
 excercise
> hardware interfaces, to be complemented with AIA/KVM bindings in follow-u=
p series.
>
> This series is a logical regrouping of series of incremental patches base=
d on
> RISC-V International IOMMU Task Group discussions and specification devel=
opment
> process. Original series can be found at the maintainer's repository bran=
ch [3].
>
> These patches can also be found in the riscv_iommu_v1 branch at:
> https://github.com/tjeznach/linux/tree/riscv_iommu_v1
>
> To test this series, use QEMU/OpenSBI with RISC-V IOMMU implementation av=
ailable in
> the riscv_iommu_v1 branch at:
> https://github.com/tjeznach/qemu/tree/riscv_iommu_v1
>
> References:
> [1] - https://wiki.riscv.org/display/HOME/Specification+Status
> [2] - https://github.com/riscv/riscv-aia/releases/download/1.0/riscv-inte=
rrupts-1.0.pdf
> [3] - https://github.com/tjeznach/qemu/tree/tjeznach/riscv-iommu-20230719
>
>
> Anup Patel (1):
>   dt-bindings: Add RISC-V IOMMU bindings
>
> Tomasz Jeznach (10):
>   RISC-V: drivers/iommu: Add RISC-V IOMMU - Ziommu support.
>   RISC-V: arch/riscv/config: enable RISC-V IOMMU support
>   MAINTAINERS: Add myself for RISC-V IOMMU driver
>   RISC-V: drivers/iommu/riscv: Add sysfs interface
>   RISC-V: drivers/iommu/riscv: Add command, fault, page-req queues
>   RISC-V: drivers/iommu/riscv: Add device context support
>   RISC-V: drivers/iommu/riscv: Add page table support
>   RISC-V: drivers/iommu/riscv: Add SVA with PASID/ATS/PRI support.
>   RISC-V: drivers/iommu/riscv: Add MSI identity remapping
>   RISC-V: drivers/iommu/riscv: Add G-Stage translation support
>
>  .../bindings/iommu/riscv,iommu.yaml           |  146 ++
>  MAINTAINERS                                   |    7 +
>  arch/riscv/configs/defconfig                  |    1 +
>  drivers/iommu/Kconfig                         |    1 +
>  drivers/iommu/Makefile                        |    2 +-
>  drivers/iommu/io-pgtable.c                    |    3 +
>  drivers/iommu/riscv/Kconfig                   |   22 +
>  drivers/iommu/riscv/Makefile                  |    1 +
>  drivers/iommu/riscv/io_pgtable.c              |  266 ++
>  drivers/iommu/riscv/iommu-bits.h              |  704 ++++++
>  drivers/iommu/riscv/iommu-pci.c               |  206 ++
>  drivers/iommu/riscv/iommu-platform.c          |  160 ++
>  drivers/iommu/riscv/iommu-sysfs.c             |  183 ++
>  drivers/iommu/riscv/iommu.c                   | 2130 +++++++++++++++++
>  drivers/iommu/riscv/iommu.h                   |  165 ++
>  include/linux/io-pgtable.h                    |    2 +
>  16 files changed, 3998 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/iommu/riscv,iommu.y=
aml
>  create mode 100644 drivers/iommu/riscv/Kconfig
>  create mode 100644 drivers/iommu/riscv/Makefile
>  create mode 100644 drivers/iommu/riscv/io_pgtable.c
>  create mode 100644 drivers/iommu/riscv/iommu-bits.h
>  create mode 100644 drivers/iommu/riscv/iommu-pci.c
>  create mode 100644 drivers/iommu/riscv/iommu-platform.c
>  create mode 100644 drivers/iommu/riscv/iommu-sysfs.c
>  create mode 100644 drivers/iommu/riscv/iommu.c
>  create mode 100644 drivers/iommu/riscv/iommu.h
>
> --
> 2.34.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

Hi Tomasz,
Could I know if you have a plan for the next version and if you have
any estimates for when the v2 patch will be ready? We have some
patches based on top of your old implementation, and it would be great
if we can rebase them onto your next version. Thanks.

