Return-Path: <linux-kernel+bounces-9321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2C681C408
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 05:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47D241F2579C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 04:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0157C46A8;
	Fri, 22 Dec 2023 04:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="koe2RXmS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4805E539A;
	Fri, 22 Dec 2023 04:36:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B5CC433CA;
	Fri, 22 Dec 2023 04:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703219809;
	bh=Te5JGcJNKzh3ANzMuyectWBxaT/iysM8QCyZ5K2Hrh8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=koe2RXmSjttdemZ6j/XEEv02swfg+lC61GGR3qaMyqjlpoBXolrO5cJ5DBtXM6iKQ
	 M1AnHE/YwIf906yMEMvo08dTUQuw8KpfU/tdNX50DEpKKPTpB9mik8mW6KqPjtO8fv
	 r4ry90nT7ZFJZQfDrgN6AJEsWgv2l/1ypgTXUeqnbH3OFIT+ZdyclDgjX4Oolp/F3q
	 auzkYrXaxcObgxbDMD4mgP5iCHnkBu2Gp7KYiDELVRanb8oFTKXDZ9oSO6H97OW6fM
	 OcMegl3I/r+pSC3sK2yBxAkj/IQnvqn7Jm3Y2e+TLcEKwZqJG+iYEgtljba5QwE9hH
	 Q6Bb9ZuMfynEA==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50e616ef769so1424220e87.1;
        Thu, 21 Dec 2023 20:36:49 -0800 (PST)
X-Gm-Message-State: AOJu0Yz2DfYgCHsZ7nkRsDwNRCAoMXM00SfGCv5Zhj4Dak5NxPBBoiPm
	x9eo/RqQhM3dvYgO/ZOYSPgC4dXg5WlhtXyVKwc=
X-Google-Smtp-Source: AGHT+IFVjodSUniTHu+2k6kW/vmTN/ZyQn53XbFWPbSVX6/AAmFvo5F//3IlWlUjh0E5BU/gpHrs34RMql9Zol116o8=
X-Received: by 2002:ac2:5df0:0:b0:50e:6a6f:b8a with SMTP id
 z16-20020ac25df0000000b0050e6a6f0b8amr86608lfq.2.1703219808000; Thu, 21 Dec
 2023 20:36:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221154702.2267684-1-guoren@kernel.org> <20231221154702.2267684-3-guoren@kernel.org>
 <ZYUD4C1aXWt2oFJo@LeoBras> <ZYUK2zUHjYBL0zO7@ghost>
In-Reply-To: <ZYUK2zUHjYBL0zO7@ghost>
From: Guo Ren <guoren@kernel.org>
Date: Fri, 22 Dec 2023 12:36:36 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQu6ezt-wdQeHfD81x8enTXxyFgZK70dLecRJ_+FJt04g@mail.gmail.com>
Message-ID: <CAJF2gTQu6ezt-wdQeHfD81x8enTXxyFgZK70dLecRJ_+FJt04g@mail.gmail.com>
Subject: Re: [PATCH V2 2/4] riscv: mm: Fixup compat arch_get_mmap_end
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Leonardo Bras <leobras@redhat.com>, linux-kernel@vger.kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, alexghiti@rivosinc.com, 
	xiao.w.wang@intel.com, david@redhat.com, panqinglin2020@iscas.ac.cn, 
	rick.p.edgecombe@intel.com, willy@infradead.org, bjorn@rivosinc.com, 
	conor.dooley@microchip.com, cleger@rivosinc.com, 
	linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 12:04=E2=80=AFPM Charlie Jenkins <charlie@rivosinc.=
com> wrote:
>
> On Fri, Dec 22, 2023 at 12:34:56AM -0300, Leonardo Bras wrote:
> > On Thu, Dec 21, 2023 at 10:46:59AM -0500, guoren@kernel.org wrote:
> > > From: Guo Ren <guoren@linux.alibaba.com>
> > >
> > > When the task is in COMPAT mode, the arch_get_mmap_end should be 2GB,
> > > not TASK_SIZE_64. The TASK_SIZE has contained is_compat_mode()
> > > detection, so change the definition of STACK_TOP_MAX to TASK_SIZE
> > > directly.
> >
> > ok
> >
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: add2cc6b6515 ("RISC-V: mm: Restrict address space for sv39,sv4=
8,sv57")
> > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > ---
> > >  arch/riscv/include/asm/processor.h | 6 ++----
> > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/=
asm/processor.h
> > > index f19f861cda54..1f538fc4448d 100644
> > > --- a/arch/riscv/include/asm/processor.h
> > > +++ b/arch/riscv/include/asm/processor.h
> > > @@ -16,15 +16,13 @@
> > >
> > >  #ifdef CONFIG_64BIT
> > >  #define DEFAULT_MAP_WINDOW (UL(1) << (MMAP_VA_BITS - 1))
> > > -#define STACK_TOP_MAX              TASK_SIZE_64
> > > +#define STACK_TOP_MAX              TASK_SIZE
> >
> > It means STACK_TOP_MAX will be in 64BIT:
> > - TASK_SIZE_32 if compat_mode=3Dy
> > - TASK_SIZE_64 if compat_mode=3Dn
> >
> > Makes sense for me.
> >
> > >
> > >  #define arch_get_mmap_end(addr, len, flags)                        \
> > >  ({                                                         \
> > >     unsigned long mmap_end;                                 \
> > >     typeof(addr) _addr =3D (addr);                            \
> > > -   if ((_addr) =3D=3D 0 || (IS_ENABLED(CONFIG_COMPAT) && is_compat_t=
ask())) \
> > > -           mmap_end =3D STACK_TOP_MAX;                       \
> > > -   else if ((_addr) >=3D VA_USER_SV57)                       \
> > > +   if ((_addr) =3D=3D 0 || (_addr) >=3D VA_USER_SV57)            \
> > >             mmap_end =3D STACK_TOP_MAX;                       \
> > >     else if ((((_addr) >=3D VA_USER_SV48)) && (VA_BITS >=3D VA_BITS_S=
V48)) \
> > >             mmap_end =3D VA_USER_SV48;                        \
> >
> >
> > I don't think I got this change, or how it's connected to the commit ms=
g.
> >
> > Before:
> > - addr =3D=3D 0, or addr > 2^57, or compat: mmap_end =3D STACK_TOP_MAX
> > - 2^48 < addr < 2^57: mmap_end =3D 2^48
> > - 0 < addr < 2^48 : mmap_end =3D 2^39
> >
> > Now:
> > - addr =3D=3D 0, or addr > 2^57: mmap_end =3D STACK_TOP_MAX
> > - 2^48 < addr < 2^57: mmap_end =3D 2^48
> > - 0 < addr < 2^48 : mmap_end =3D 2^39
> >
> > IIUC compat mode addr will be < 2^32, so will always have mmap_end =3D =
2^39
> > if addr !=3D 0. Is that desireable?
> > (if not, above change is unneeded)
>
> I agree, this change does not make sense for compat mode. Compat mode
> should never return an address that is greater than 2^32, but this
> change allows that.
#define STACK_TOP_MAX TASK_SIZE
#define TASK_SIZE       (is_compat_task() ? TASK_SIZE_32 : TASK_SIZE_64)

So, this change limits an address in 2^32 for compat mode, and your
patch broke the rule. So that is why we need this patch to fix up.


>
> >
> > Also, unrelated to the change:
> > - 2^48 < addr < 2^57: mmap_end =3D 2^48
> > Is the above correct?
> > It looks like it should be 2^57 instead, and a new if clause for
> > 2^32 < addr < 2^48 should have mmap_end =3D 2^48.
>
> That is not the case. I documented this behavior and reasoning in
> Documentation/arch/riscv/vm-layout.rst in the "Userspace VAs" section.
>
> I can reiterate here though. The hint address to mmap (defined here as
> "addr") is the maximum userspace address that mmap should provide. What
> you are describing is a minimum. The purpose of this change was to allow
> applications that are not compatible with a larger virtual address (such
> as applications like Java that use the upper bits of the VA to store
> data) to have a consistent way of specifying how many bits they would
Yes, I agree with this change and use Zjpm with PLEN=3D48 to optimize
them in the future.

> like to be left free in the VA. This requires to take the next lowest
> address space to guaruntee that all of the most-significant bits left
> clear in hint address do not end up populated in the virtual address
> returned by mmap.
>
> - Charlie
>
> >
> > Do I get it wrong?
> >
> > (I will send an RFC 'fixing' the code the way I am whinking it should l=
ook
> > like)
> >
> > Thanks,
> > Leo
> >
> >
> >
> >
> >
> > > --
> > > 2.40.1
> > >
> >



--=20
Best Regards
 Guo Ren

