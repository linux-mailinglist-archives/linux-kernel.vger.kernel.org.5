Return-Path: <linux-kernel+bounces-123050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DB6890179
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C8D6B21742
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8C881737;
	Thu, 28 Mar 2024 14:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.b="QiQfx8k0"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DA080022
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 14:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711635516; cv=none; b=Nu+g75tPcWet3krr3u4o7QCovt7fYrsssnbo7EpCMdl3sQQpmaxmpaNZ2+hZG0bjeUPanygjAcQPvD2Aks64lb9rg+WPt+5SR0/0g/uPi7IRXpOOQf8l0zFOvwann5ya9gEUnVohFkSNQLpnJOzr8amQ3OEgcwWNSFn/CXXu8y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711635516; c=relaxed/simple;
	bh=yST0+UU54S1IG+7v5Sz5Xp7N8pZZpEEbghrdyK61X+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CVYFHSu3+8O5j0lZxfSMpHengvQYISBdYeEHia0SyIgqD4LKtUf+Ox1bTyOzxXUTP4AXi9NYOwBXsy8k6F5DWYxUhrOSqLG8vPdQ13ybiEH1kHqjEU0QdVDEM/ZlMlCw4e30XfVfs/JTAnlMQY2ChZkxGa2FS1QkosrgtJFyC4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vrull.eu; spf=pass smtp.mailfrom=vrull.eu; dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.b=QiQfx8k0; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vrull.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vrull.eu
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e6c0098328so840733b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 07:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google; t=1711635514; x=1712240314; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zqbRQqW0auM8yPwFJcSxCTI/1OyWyhS5S2oHIbdG6Uc=;
        b=QiQfx8k01tRT9oISZH7VIaZcYYLNX88EVnHbvPrHSuG1+qjpfP3QHClB6AMLuH5quk
         WzGdMWUoveKw8/+iLaMPH6SUS6BsH8/0Q73nVElJOVHTrkZ+7w8NQNJTTk6BMQRZ+ucT
         DV2wkt4rDnN1nJ3jcyW/tkTJudFPqs14L1E0ssIZ+/M4SK784yPfy71iVF8EvK6OeThx
         3gtF2yFb8yUVd2B3racS3sBAJtsSqY91Xo9HBGDYKgVIaQ+I0XT9GJgwBEw041CKRoYS
         fo6yaJDdG6OTerQofED8RRXa3MO/UrFh3P38ERs/Tb6DB1XLLOYN7ERi62ZJlJdVDneH
         FNRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711635514; x=1712240314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zqbRQqW0auM8yPwFJcSxCTI/1OyWyhS5S2oHIbdG6Uc=;
        b=GAB786wYI9fvfiCGzxTTVyfQBQeDwJFbtB8C9fJ/9r+n9M9gYU6en/avNttPcl3ivo
         /7j32YIq5enhDK+yo5eLHSvm39ZwsqtxSUMMKWVJiEyM56Qait9ostXARhgDVe3El2Xw
         2dq28mIEFZ+3t05ueXs5stCxrsGvE1+EwxfwSU/Pe8CTpg7yl6lsiG0Q3jPQ9iNi6x+U
         jtdZiWqQL120o3LPGn7skLAt6ePwblqmkGun1gZQXolHScTLwzxc0r1chMkPCz9S3cCN
         SccW6fINXBomwU9yxqA0XfFJ+Sk/YLkRHZ1cGpiaxvEOXQHWTvMttA1PfHTV12c12lCR
         VjdA==
X-Forwarded-Encrypted: i=1; AJvYcCUxmhp0syagKUsz9OvNTwet5SdLEqDRqILhNCD8ADhlmFVFAaIF22UqJ72o24fkwvvA+V0OUUHa4/9E6VpoBh4hOWl11S+UjTuMKWnD
X-Gm-Message-State: AOJu0YzC8c+OR49AULBVO8c8fiRWLa7N0zF7QuMdKihCoCa+N6/Uj3LO
	yVI5wz3Ifakj7ouaSx4tPGvNydvVPCqaDawkydSLcV2BNnd+L2WvT4UYA1cGKreZT7lYhixnGFG
	LyUr3YvJmV5Ec0LxmdjS2yUi/FR5TBsgimswqwQ==
X-Google-Smtp-Source: AGHT+IECNRXB/xpyWGPViS4bOavtZoe3t64KsRpvmvbiSa3NftMcTTx/WyhY4Yiz0ZvGzMPEWuXdtCgC6OPQJUcVzRQ=
X-Received: by 2002:a05:6a21:3409:b0:1a5:6b2f:7b91 with SMTP id
 yn9-20020a056a21340900b001a56b2f7b91mr2170822pzb.21.1711635514320; Thu, 28
 Mar 2024 07:18:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327103130.3651950-1-christoph.muellner@vrull.eu>
 <20240327103130.3651950-3-christoph.muellner@vrull.eu> <20240327-imperfect-washbowl-d95e57cef0ef@spud>
 <20240327-77a6b64153a68452d0438999@orel>
In-Reply-To: <20240327-77a6b64153a68452d0438999@orel>
From: =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>
Date: Thu, 28 Mar 2024 15:18:22 +0100
Message-ID: <CAEg0e7jyGZV3+04HNYzgfHMGYT9wV_c0A=ekpCRi3L-5yjxK=w@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv: T-Head: Test availability bit before enabling
 MAEE errata
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Philipp Tomsich <philipp.tomsich@vrull.eu>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Daniel Henrique Barboza <dbarboza@ventanamicro.com>, Heiko Stuebner <heiko@sntech.de>, 
	Cooper Qu <cooper.qu@linux.alibaba.com>, Zhiwei Liu <zhiwei_liu@linux.alibaba.com>, 
	Huang Tao <eric.huang@linux.alibaba.com>, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 1:41=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Wed, Mar 27, 2024 at 11:03:06AM +0000, Conor Dooley wrote:
> > On Wed, Mar 27, 2024 at 11:31:30AM +0100, Christoph M=C3=BCllner wrote:
> > > T-Head's MAEE mechanism (non-compatible equivalent of RVI's Svpbmt)
> > > is currently assumed for all T-Head harts. However, QEMU recently
> > > decided to drop acceptance of guests that write reserved bits in PTEs=
.
> > > As MAEE uses reserved bits in PTEs and Linux applies the MAEE errata
> > > for all T-Head harts, this broke the Linux startup on QEMU emulations
> > > of the C906 emulation.
> > >
> > > This patch attempts to address this issue by testing the MAEE bit
> > > in TH_MXSTATUS CSR. As the TH_MXSTATUS CSR is only accessible in M-mo=
de
> > > this patch depends on M-mode firmware that handles this for us
> > > transparently.
> > >
> >
> > > As this patch breaks Linux bootup on all C9xx machines with MAEE,
> > > which don't have M-mode firmware that handles the access to the
> > > TH_MXSTATUS CSR, this patch is marked as RFC.
>
> Can we wrap the csr access in a _ASM_EXTABLE()? If firmware handles it,
> then we return true/false based on the value. If firmware doesn't handle
> it, and we get an illegal instruction exception, then we assume the bit
> is set, which is the current behavior.
>
> >
> > I think this is gonna be unacceptable in its current state given that i=
t
> > causes problems for every other version of the firmware. Breaking real
> > systems for the sake of emulation isn't something we can reasonably do.
> >
> > To make this sort of change acceptable, you're gonna have to add some w=
ay
> > to differentiate between systems that do and do not support reading thi=
s
> > CSR. I think we either a) need to check the version of the SBI
> > implementation to see if it hits the threshold for supporting this
> > feature, or b) add a specific SBI call for this so that we can
> > differentiate between firmware not supporting the function and the
>
> The FWFT SBI extension is being developed as a mechanism for S-mode to as=
k
> M-mode things like this, but I think that extension should be used for
> features that have potential to be changed by S-mode (even if not
> everything will be changeable on all platforms), whereas anything that's
> read-only would be better with...
>
> > quote-unquote "hardware" not supporting it. I don't really like option =
a)
> > as it could grow to several different options (each for a different SBI
> > implementation) and support for reading the CSR would need to be
> > unconditional. I have a feeling that I am missing something though,
> > that'd make it doable without introducing a new call.
> >
> > Thanks,
> > Conor.
> >
> > If only we'd made enabling this be controlled by a specific DT property=
,
> > then disabling it in QEMU would be as simple as not setting that
> > property :(
>
> ...this, where "DT property" is "ISA extension name". I wonder if we
> shouldn't start considering the invention of xlinux_vendor_xyz type
> extension names which firmware could add to the ISA string / array,
> in order to communicate read-only information like this?
>
> Thanks,
> drew

Hi Conor and Drew,

Thank you for your hints.
I fully agree with all your statements and concerns.

Switching from th.mxstatus to th.sxstatus should address all mentioned conc=
erns:
* no dependency on OpenSBI changes
* no break of functionality
* no need for graceful handling of CSR read failures
* no need to differentiate between HW and emulation (assuming QEMU
accepts the emulation of th.sxstatus)

Also note that DT handling would be difficult, because we need to probe bef=
ore
setting up the page table.

Thanks!


>
> >
> > >
> > > Signed-off-by: Christoph M=C3=BCllner <christoph.muellner@vrull.eu>
> > > ---
> > >  arch/riscv/errata/thead/errata.c | 14 ++++++++++----
> > >  1 file changed, 10 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/the=
ad/errata.c
> > > index 8c8a8a4b0421..dd7bf6c62a35 100644
> > > --- a/arch/riscv/errata/thead/errata.c
> > > +++ b/arch/riscv/errata/thead/errata.c
> > > @@ -19,6 +19,9 @@
> > >  #include <asm/patch.h>
> > >  #include <asm/vendorid_list.h>
> > >
> > > +#define CSR_TH_MXSTATUS            0x7c0
> > > +#define MXSTATUS_MAEE              _AC(0x200000, UL)
> > > +
> > >  static bool errata_probe_maee(unsigned int stage,
> > >                           unsigned long arch_id, unsigned long impid)
> > >  {
> > > @@ -28,11 +31,14 @@ static bool errata_probe_maee(unsigned int stage,
> > >     if (arch_id !=3D 0 || impid !=3D 0)
> > >             return false;
> > >
> > > -   if (stage =3D=3D RISCV_ALTERNATIVES_EARLY_BOOT ||
> > > -       stage =3D=3D RISCV_ALTERNATIVES_MODULE)
> > > -           return true;
> > > +   if (stage !=3D RISCV_ALTERNATIVES_EARLY_BOOT &&
> > > +       stage !=3D RISCV_ALTERNATIVES_MODULE)
> > > +           return false;
> > >
> > > -   return false;
> > > +   if (!(csr_read(CSR_TH_MXSTATUS) & MXSTATUS_MAEE))
> > > +           return false;
> > > +
> > > +   return true;
> > >  }
> > >
> > >  /*
> > > --
> > > 2.44.0
> > >
>
>

