Return-Path: <linux-kernel+bounces-124434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0913389178C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 361861C21B93
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 11:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5398348787;
	Fri, 29 Mar 2024 11:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.b="XnbDqh3V"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7B9535D7
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 11:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711711385; cv=none; b=DpbqXtZQEqcRtUuC1dM/nCni9XSNm/E/5p6It+4ICKw1IP+D6MG7NZlCflVnvbasEbbRB5XzTCW4UC2KpOS0ZK0C4X3ipJTQkaM0OaFsfbJScIdCt6qfB4XnZRF6MmvQmMdl9XFAknTrhTctq6qT0prZKS0FofDhqXjARsot78w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711711385; c=relaxed/simple;
	bh=aqlYB1I0g2ulsBU+roXEG9RI42hMoIqIgd28XdSCYgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yc2Naqmnz1+m0R2Rd7zvPu2lzZnUCNCNigO1GiJ0a0Z7JyKSHhPaK4huvbuEaTymTLAdkLZ87CGAixp/HHJkmVHZv9NVDOcWdyvl+RUwGrduP12UHSMQO3q5q9di3vUsLGsTZ8W5Y4yT79oh/UAW/UBDOALeikVttcpowQGWb/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vrull.eu; spf=pass smtp.mailfrom=vrull.eu; dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.b=XnbDqh3V; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vrull.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vrull.eu
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5cfd95130c6so1157693a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 04:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google; t=1711711383; x=1712316183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VG9FSoxp06pKdGlIyq1RnBYkty3H778XglBDZVVqkfI=;
        b=XnbDqh3VYHj0CspCPDYaVd3W7OTzICrKhCyPeO4CimUcbZ4ewOST5F8ZTwVZo+VMzU
         7/6x7UeQmbzoRFLGdMVjx0xfoVSA+YiarTJ6jknS0DuSJTg4FCocxu3Q28YomyHNAtVN
         uUh1mpKCUoAPX/k/m3LsYNuUB8dgp8y5dZLM03k04rnGyCHtajADXHVnVUvsbCTV9kjo
         VBoQS7MTqY4JHZbWCLKsZOZ6rkuVMX6vdbd6elkql1k7vR/itd+40qaxsF61AFwF50SB
         lGkcEn02IKzO/L9B69sRupc7OoItviAjmtXqLYVIwZZqWpWpJXxJHjkR8I0kDC/tIyru
         G6rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711711383; x=1712316183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VG9FSoxp06pKdGlIyq1RnBYkty3H778XglBDZVVqkfI=;
        b=NzZA00tbEfEShmUDL3yaNRlyro6Mg4wSzjikwOkpKEZ9/UIQH/3aZjQJYwazBKVXd2
         rRQie2kc6Lhz4GKlo3VQxSslUqAVFL1aFmUpfAwiWKvkoF6PYjI7+fDLB+2PYjevuoJj
         jwnb1nAzGkRbGHY0uA3zaR3GuoMc/0v9PQDWBYC66H95aYuR0tTf6X/4AJw27v22b9oe
         h3omhsEuukuzqhJ0s+l5TsMPT/kJp1yynL1Ux8AVrXokGbU4kQy6mMyU2UY1Atxyf9lt
         EA6XHUQhQ6S9yYAF1OMDxls+s4ftCTJmtLdbY1JVCUhxHff9Z/asS1rsI6BJ6z/6gCI4
         Yl1g==
X-Forwarded-Encrypted: i=1; AJvYcCUTpTamyoqYWI/qYpRZ/wVtS1vb80gFZip6cxbG4Y/BHyIM07N44KIPhDr6ekj4YnwcqdJkgiCWsoslVZkZ5jmrFQckUoeG3cdOQQ5V
X-Gm-Message-State: AOJu0YzKIj/el9iQMKLdRjuSkH5L6u3rfg5BafqaKjOSL/dPQ9XRvS4O
	k3rxi8Jj/cRJM0wmvgf5dPvFGaZM5OeujFO0rHY+SV508B/Y2xCHSY8Rqy9OcU9e26V2mjfv6po
	ViBjZZB5z4Bp4s1BDuvug5RNHnN8YVKTJUab5Vw==
X-Google-Smtp-Source: AGHT+IEZdgnHcsiUx6ukMKlm+aGQgbvDdTs4sCVIirJYDruCC4qjw3N7xkUnCSbgr0bp+M5X+9drU+PJwcI8TdnrT/4=
X-Received: by 2002:a05:6a21:9998:b0:1a5:6c6d:b1e0 with SMTP id
 ve24-20020a056a21999800b001a56c6db1e0mr1910892pzb.8.1711711382827; Fri, 29
 Mar 2024 04:23:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327103130.3651950-1-christoph.muellner@vrull.eu>
 <20240327103130.3651950-3-christoph.muellner@vrull.eu> <20240327-imperfect-washbowl-d95e57cef0ef@spud>
 <20240327-77a6b64153a68452d0438999@orel> <CAEg0e7jyGZV3+04HNYzgfHMGYT9wV_c0A=ekpCRi3L-5yjxK=w@mail.gmail.com>
 <7354b054-9eda-45a6-9503-ff30a1c9c276@ghiti.fr>
In-Reply-To: <7354b054-9eda-45a6-9503-ff30a1c9c276@ghiti.fr>
From: =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>
Date: Fri, 29 Mar 2024 12:22:51 +0100
Message-ID: <CAEg0e7iAUWgT9BfaBQiKg6RUCL7RvCq43+ShpbGU7bxWuTYtag@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv: T-Head: Test availability bit before enabling
 MAEE errata
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Andrew Jones <ajones@ventanamicro.com>, Conor Dooley <conor@kernel.org>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Daniel Henrique Barboza <dbarboza@ventanamicro.com>, Heiko Stuebner <heiko@sntech.de>, 
	Cooper Qu <cooper.qu@linux.alibaba.com>, Zhiwei Liu <zhiwei_liu@linux.alibaba.com>, 
	Huang Tao <eric.huang@linux.alibaba.com>, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 4:43=E2=80=AFPM Alexandre Ghiti <alex@ghiti.fr> wro=
te:
>
> Hi Christoph,
>
> On 28/03/2024 15:18, Christoph M=C3=BCllner wrote:
> > On Wed, Mar 27, 2024 at 1:41=E2=80=AFPM Andrew Jones <ajones@ventanamic=
ro.com> wrote:
> >> On Wed, Mar 27, 2024 at 11:03:06AM +0000, Conor Dooley wrote:
> >>> On Wed, Mar 27, 2024 at 11:31:30AM +0100, Christoph M=C3=BCllner wrot=
e:
> >>>> T-Head's MAEE mechanism (non-compatible equivalent of RVI's Svpbmt)
> >>>> is currently assumed for all T-Head harts. However, QEMU recently
> >>>> decided to drop acceptance of guests that write reserved bits in PTE=
s.
> >>>> As MAEE uses reserved bits in PTEs and Linux applies the MAEE errata
> >>>> for all T-Head harts, this broke the Linux startup on QEMU emulation=
s
> >>>> of the C906 emulation.
> >>>>
> >>>> This patch attempts to address this issue by testing the MAEE bit
> >>>> in TH_MXSTATUS CSR. As the TH_MXSTATUS CSR is only accessible in M-m=
ode
> >>>> this patch depends on M-mode firmware that handles this for us
> >>>> transparently.
> >>>>
> >>>> As this patch breaks Linux bootup on all C9xx machines with MAEE,
> >>>> which don't have M-mode firmware that handles the access to the
> >>>> TH_MXSTATUS CSR, this patch is marked as RFC.
> >> Can we wrap the csr access in a _ASM_EXTABLE()? If firmware handles it=
,
> >> then we return true/false based on the value. If firmware doesn't hand=
le
> >> it, and we get an illegal instruction exception, then we assume the bi=
t
> >> is set, which is the current behavior.
> >>
> >>> I think this is gonna be unacceptable in its current state given that=
 it
> >>> causes problems for every other version of the firmware. Breaking rea=
l
> >>> systems for the sake of emulation isn't something we can reasonably d=
o.
> >>>
> >>> To make this sort of change acceptable, you're gonna have to add some=
 way
> >>> to differentiate between systems that do and do not support reading t=
his
> >>> CSR. I think we either a) need to check the version of the SBI
> >>> implementation to see if it hits the threshold for supporting this
> >>> feature, or b) add a specific SBI call for this so that we can
> >>> differentiate between firmware not supporting the function and the
> >> The FWFT SBI extension is being developed as a mechanism for S-mode to=
 ask
> >> M-mode things like this, but I think that extension should be used for
> >> features that have potential to be changed by S-mode (even if not
> >> everything will be changeable on all platforms), whereas anything that=
's
> >> read-only would be better with...
> >>
> >>> quote-unquote "hardware" not supporting it. I don't really like optio=
n a)
> >>> as it could grow to several different options (each for a different S=
BI
> >>> implementation) and support for reading the CSR would need to be
> >>> unconditional. I have a feeling that I am missing something though,
> >>> that'd make it doable without introducing a new call.
> >>>
> >>> Thanks,
> >>> Conor.
> >>>
> >>> If only we'd made enabling this be controlled by a specific DT proper=
ty,
> >>> then disabling it in QEMU would be as simple as not setting that
> >>> property :(
> >> ...this, where "DT property" is "ISA extension name". I wonder if we
> >> shouldn't start considering the invention of xlinux_vendor_xyz type
> >> extension names which firmware could add to the ISA string / array,
> >> in order to communicate read-only information like this?
> >>
> >> Thanks,
> >> drew
> > Hi Conor and Drew,
> >
> > Thank you for your hints.
> > I fully agree with all your statements and concerns.
> >
> > Switching from th.mxstatus to th.sxstatus should address all mentioned =
concerns:
> > * no dependency on OpenSBI changes
> > * no break of functionality
> > * no need for graceful handling of CSR read failures
> > * no need to differentiate between HW and emulation (assuming QEMU
> > accepts the emulation of th.sxstatus)
> >
> > Also note that DT handling would be difficult, because we need to probe=
 before
> > setting up the page table.
>
>
> We already parse the DT before setting the page table to disable KASLR
> and to parse "no4lvl" or "no5lvl" command line parameters. Take a look
> at the kernel/pi directory and setup_vm() in mm/init.c.

Ah, I see. So, this can be done with a function similar to
get_kaslr_seed() in arch/riscv/kernel/pi/fdt_early.c.
And the Makefile will apply the necessary steps to get this working.
The downside is that depending on new information in the DT, it will not be
backward compatible. So, I don't see a way around probing th.sxstatus.MAEE.

Independent of that, there is work to be done for the T-Head extension
discovery in the Linux kernel:
* XThead* extensions are not in the DTS
* XThead* extensions are not parsed during bootup
* XThead* extensions don't trigger optimizations (string ops) or errata (MA=
EE)
* XThead* extensions are not exported via hwprobe
However, I think this is independent of addressing the MAEE issue.
So, I will send out a V2 with the th.sxstatus.MAEE probing only.

Thanks,
Christoph

>
> Thanks,
>
> Alex
>
>
> >
> > Thanks!
> >
> >
> >>>> Signed-off-by: Christoph M=C3=BCllner <christoph.muellner@vrull.eu>
> >>>> ---
> >>>>   arch/riscv/errata/thead/errata.c | 14 ++++++++++----
> >>>>   1 file changed, 10 insertions(+), 4 deletions(-)
> >>>>
> >>>> diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/th=
ead/errata.c
> >>>> index 8c8a8a4b0421..dd7bf6c62a35 100644
> >>>> --- a/arch/riscv/errata/thead/errata.c
> >>>> +++ b/arch/riscv/errata/thead/errata.c
> >>>> @@ -19,6 +19,9 @@
> >>>>   #include <asm/patch.h>
> >>>>   #include <asm/vendorid_list.h>
> >>>>
> >>>> +#define CSR_TH_MXSTATUS            0x7c0
> >>>> +#define MXSTATUS_MAEE              _AC(0x200000, UL)
> >>>> +
> >>>>   static bool errata_probe_maee(unsigned int stage,
> >>>>                            unsigned long arch_id, unsigned long impi=
d)
> >>>>   {
> >>>> @@ -28,11 +31,14 @@ static bool errata_probe_maee(unsigned int stage=
,
> >>>>      if (arch_id !=3D 0 || impid !=3D 0)
> >>>>              return false;
> >>>>
> >>>> -   if (stage =3D=3D RISCV_ALTERNATIVES_EARLY_BOOT ||
> >>>> -       stage =3D=3D RISCV_ALTERNATIVES_MODULE)
> >>>> -           return true;
> >>>> +   if (stage !=3D RISCV_ALTERNATIVES_EARLY_BOOT &&
> >>>> +       stage !=3D RISCV_ALTERNATIVES_MODULE)
> >>>> +           return false;
> >>>>
> >>>> -   return false;
> >>>> +   if (!(csr_read(CSR_TH_MXSTATUS) & MXSTATUS_MAEE))
> >>>> +           return false;
> >>>> +
> >>>> +   return true;
> >>>>   }
> >>>>
> >>>>   /*
> >>>> --
> >>>> 2.44.0
> >>>>
> >>
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv

