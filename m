Return-Path: <linux-kernel+bounces-126499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B012A8938B1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 09:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FDEB1F21315
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 07:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486EBBA41;
	Mon,  1 Apr 2024 07:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emcpKvnI"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FE7B66C;
	Mon,  1 Apr 2024 07:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711957333; cv=none; b=BbiiMXR0oyfPv6B3yBkWh0C0jApXyhPmcGIKK2dsskEdcg7Z2u652lqDTL8zZ2CIKT51A8TOEohVJH0qtbIgtR5G2ZJKmuW7iCVdfl8FpwTvfFFJFXyk9IRzZn3cgRgMqYduzFpiRBwpDtiEUZ6yVO9+2bB5I+1PuZEIjAPqFxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711957333; c=relaxed/simple;
	bh=P//M+IKlwXWXeRYmsYCshnL9dhQNOzT6a0koi/j5vcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ecrvVQF39ciLkJCsHGekpx+92gM9B9L3Wf94IZaCkdYa7mukF+Z+xBsMyqgRNo1AFJSUO61aCJiwwyxWszpp2QyUob5xqXhlB+wVAWz63G3qmXC88l8teWf4Hn0JN/jfkG8B5sGn09VoVcWzkV94yTDBeNuzIQXsRLXwWxq49hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=emcpKvnI; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d6a1af9c07so43213871fa.3;
        Mon, 01 Apr 2024 00:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711957330; x=1712562130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5SSJljyfKnuJeOjPki7PuFiCXRujcBFkC7jlbcW3GDA=;
        b=emcpKvnI6Y7rJNWcJLpOrABturJVlgJmyox/CcPyvRs3j5GlyRRknQ+pbUzhPdFR73
         YdsBTNKisk3xAYz5PG1AW2/Vcl+aveyaACXGH4GVPd5n1WbtoFbN1DACZRWfhpbx32mV
         UtvBSIFXIo8MHvNtkHK7W6DNtoxRFVzEM4ueQu2eZTTOBIozKmOd7aO6CA/RgA+UN2IW
         Vt5k1/rXD4Hw44WS+32katjM8ngZAD2zIkTwxKGJgXDO/VaBKmo+OaPMMe3HeFD/2ABS
         m5bV6XvIjcncqPjEiM1lDenabZ+yZEA1SkIJU9Hcqt6wdjH/HkcCNGKKAR0unARgGDg9
         6gCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711957330; x=1712562130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5SSJljyfKnuJeOjPki7PuFiCXRujcBFkC7jlbcW3GDA=;
        b=cGt9TbLEUT7tWmxWMdSsX/63gaVkvpsB0HFFtnPAx8KSZ34fDBZfgTBu2mI9PS0n8n
         YUYe1hjHyyJM+2KD6kP9x/jLBAfbEVIZ5Nnubc+0pORO6iul62V7WatoRJRPBfsfUECC
         2K+4WYaAGkiwp2F2GqCs7Oh3VmKt3DifBhc+OlaziEyKpiOrT4I4fQjXOWd/3zWIeGmA
         0pjHaSlQhdDxADdhrjurj3Hy+a3GFKcqtRDzfHr+gE/nLojLSM23y0joS9nhe+gl/oVr
         obT4qe50PJ87DXMpNiasOnSlmVxyG2Hoc6v4wxLqzIhd4Y3VBSvDBZSpGSpxPePROZy/
         udqA==
X-Forwarded-Encrypted: i=1; AJvYcCUT4maVjvXWoW3JkD6H1xRGwr1/lOz/LqPWZUHFob5mTcSguFLRNcPbX5GovSIVZMX9rNghmpUade4qQjg3eJpWDc28lOzpEbim4d2a8DbEZLxb+D5sHE95OEI4kLtaiJBJdkT+AExJ0g==
X-Gm-Message-State: AOJu0YwPwZaXQhUcwVONRCnzDiS855M6BgHS9jml/ZKTOst3+CFtU7Vf
	LbhDLn84d/S3wZNtefRSeyoKqMWZoDnKdPiF4ylM3DIO5UiMZ7iOQxQ/0lu9K2gD9aXgoLYB3dU
	MnLmzaySokiv1LIMXewgcJiMA4no=
X-Google-Smtp-Source: AGHT+IHCeA3ZB/fyrTz8pMLnWGInr5YcrgiR+a/NUwxJXCLgasVcZNlOpzcH0Q5xA1D7XlYsXG2Jk7k5azBlx/fUck4=
X-Received: by 2002:a2e:a455:0:b0:2d6:f5db:4d6e with SMTP id
 v21-20020a2ea455000000b002d6f5db4d6emr4780215ljn.40.1711957329905; Mon, 01
 Apr 2024 00:42:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1709780590.git.haibo1.xu@intel.com> <7ca110c59cbb2fb358304a9ba4f9c7cbeb191345.1709780590.git.haibo1.xu@intel.com>
 <Zgpc/qW/as+gbb+I@sunil-laptop>
In-Reply-To: <Zgpc/qW/as+gbb+I@sunil-laptop>
From: Haibo Xu <xiaobo55x@gmail.com>
Date: Mon, 1 Apr 2024 15:41:58 +0800
Message-ID: <CAJve8o=s-hN28hXPB30oJB0cAoDAEPUbTYNh3V0Nzd-2DoT4vQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] ACPI: RISCV: Add NUMA support based on SRAT and SLIT
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: Haibo Xu <haibo1.xu@intel.com>, ajones@ventanamicro.com, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Guo Ren <guoren@kernel.org>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Greentime Hu <greentime.hu@sifive.com>, Jisheng Zhang <jszhang@kernel.org>, 
	Baoquan He <bhe@redhat.com>, Sami Tolvanen <samitolvanen@google.com>, Zong Li <zong.li@sifive.com>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Chen Jiahao <chenjiahao16@huawei.com>, 
	Arnd Bergmann <arnd@arndb.de>, James Morse <james.morse@arm.com>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Evan Green <evan@rivosinc.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Marc Zyngier <maz@kernel.org>, 
	Anup Patel <apatel@ventanamicro.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Tony Luck <tony.luck@intel.com>, Yuntao Wang <ytcoode@gmail.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	Dan Williams <dan.j.williams@intel.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 3:06=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.com>=
 wrote:
>
> On Thu, Mar 07, 2024 at 04:47:54PM +0800, Haibo Xu wrote:
> > Add acpi_numa.c file to enable parse NUMA information from
> > ACPI SRAT and SLIT tables. SRAT table provide CPUs(Hart) and
> > memory nodes to proximity domain mapping, while SLIT table
> > provide the distance metrics between proximity domains.
> >
> > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> > ---
> >  arch/riscv/include/asm/acpi.h |  15 +++-
> >  arch/riscv/kernel/Makefile    |   1 +
> >  arch/riscv/kernel/acpi.c      |   5 --
> >  arch/riscv/kernel/acpi_numa.c | 131 ++++++++++++++++++++++++++++++++++
> >  arch/riscv/kernel/setup.c     |   4 +-
> >  arch/riscv/kernel/smpboot.c   |   2 -
> >  include/linux/acpi.h          |   6 ++
> >  7 files changed, 154 insertions(+), 10 deletions(-)

> >  #ifndef PHYS_CPUID_INVALID
> >  typedef u32 phys_cpuid_t;
> >  #define PHYS_CPUID_INVALID (phys_cpuid_t)(-1)
> > --
> This is a large patch spanning across multiple files. Can we split this
> into multiple smaller patches? Changes look fine to me though.
>

Thanks for the review!
I will try to break them in v3.

> Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>

