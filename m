Return-Path: <linux-kernel+bounces-9437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA5881C576
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 08:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16D8E1F2587A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 07:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2C79468;
	Fri, 22 Dec 2023 07:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPLIgL3G"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E909447;
	Fri, 22 Dec 2023 07:20:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A687C433CD;
	Fri, 22 Dec 2023 07:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703229628;
	bh=rfHut9afPJi3j1Rb6J5iMJX0Y5HOv4Ct4EctX+/dLzE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hPLIgL3GLHAFw5aCiRJ4SEdZvNmk5uKUtYI5IiYqqTYcl/NLLGaeV0Er/yuSM0Xoo
	 1ZIdzA4ZfhqoI7D9ahzZCm0q5SH/MaQ8Q18sQudxbQddGefTDvmwL8wci9gjNZypmz
	 WIBw0TK3WwoO1i/UsfBTKs+owBJqTQC5DCzHEJ5vIlBPY6Tgrj1M5QLN2B596KGn/q
	 upIuREHZVl7hYwwQnP//fJ2v+FxAp3RgpZKPolezQ6GgdkW0Zu6S38Iom+pt7H7Ca9
	 YLm8LIno2iiJBNv+YkadxXI3T+SkBRXrwQ4DfJ7HUJHNmbXPKXOIE8YpY4eAaKEK/C
	 PqGVcvL5pjg3A==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a236456fee1so186949666b.1;
        Thu, 21 Dec 2023 23:20:28 -0800 (PST)
X-Gm-Message-State: AOJu0YzlTb8Mo2e1u7Y4FVB1vuFklrt+r/8JLZdv1IrX4THHZgQXOz8A
	3+cOP9Kg2A4h6YLkB8sE7gLjtsAcOQtzWFpDYZ4=
X-Google-Smtp-Source: AGHT+IEZhVJ9T9q7IauReV3SU4daD2XaON1Z2Kk7vsgDGkmuRKbZqhA+dQt0ns+3djBXpaWeoW6QKCDuO3rBvrmgF84=
X-Received: by 2002:a17:906:230f:b0:a23:532e:83d9 with SMTP id
 l15-20020a170906230f00b00a23532e83d9mr414715eja.93.1703229626563; Thu, 21 Dec
 2023 23:20:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221154702.2267684-1-guoren@kernel.org> <20231221154702.2267684-3-guoren@kernel.org>
 <ZYUD4C1aXWt2oFJo@LeoBras> <CAJF2gTSiaNWkXS6rc+3OSZfnFqG2d7btzjrd-L1mBgAVu3ym3A@mail.gmail.com>
 <ZYUT22KmGJ1tJSWx@LeoBras> <CAJF2gTRptBZyYbnY-mjn-AuQwVnekQtGY8nAOV7KVWLCY1WBcw@mail.gmail.com>
 <ZYUeU0URQvgw42jt@LeoBras>
In-Reply-To: <ZYUeU0URQvgw42jt@LeoBras>
From: Guo Ren <guoren@kernel.org>
Date: Fri, 22 Dec 2023 15:20:15 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQ33JmhUZtr6nkAY5mXRxOEA88pXy1CHcU0jNMzcQZz_g@mail.gmail.com>
Message-ID: <CAJF2gTQ33JmhUZtr6nkAY5mXRxOEA88pXy1CHcU0jNMzcQZz_g@mail.gmail.com>
Subject: Re: [PATCH V2 2/4] riscv: mm: Fixup compat arch_get_mmap_end
To: Leonardo Bras <leobras@redhat.com>
Cc: linux-kernel@vger.kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	alexghiti@rivosinc.com, charlie@rivosinc.com, xiao.w.wang@intel.com, 
	david@redhat.com, panqinglin2020@iscas.ac.cn, rick.p.edgecombe@intel.com, 
	willy@infradead.org, bjorn@rivosinc.com, conor.dooley@microchip.com, 
	cleger@rivosinc.com, linux-riscv@lists.infradead.org, 
	Guo Ren <guoren@linux.alibaba.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 1:28=E2=80=AFPM Leonardo Bras <leobras@redhat.com> =
wrote:
>
> On Fri, Dec 22, 2023 at 12:50:44PM +0800, Guo Ren wrote:
> > On Fri, Dec 22, 2023 at 12:43=E2=80=AFPM Leonardo Bras <leobras@redhat.=
com> wrote:
> > >
> > > On Fri, Dec 22, 2023 at 12:26:19PM +0800, Guo Ren wrote:
> > > > On Fri, Dec 22, 2023 at 11:35=E2=80=AFAM Leonardo Bras <leobras@red=
hat.com> wrote:
> > > > >
> > > > > On Thu, Dec 21, 2023 at 10:46:59AM -0500, guoren@kernel.org wrote=
:
> > > > > > From: Guo Ren <guoren@linux.alibaba.com>
> > > > > >
> > > > > > When the task is in COMPAT mode, the arch_get_mmap_end should b=
e 2GB,
> > > > > > not TASK_SIZE_64. The TASK_SIZE has contained is_compat_mode()
> > > > > > detection, so change the definition of STACK_TOP_MAX to TASK_SI=
ZE
> > > > > > directly.
> > > > >
> > > > > ok
> > > > >
> > > > > >
> > > > > > Cc: stable@vger.kernel.org
> > > > > > Fixes: add2cc6b6515 ("RISC-V: mm: Restrict address space for sv=
39,sv48,sv57")
> > > > > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > > > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > > > > ---
> > > > > >  arch/riscv/include/asm/processor.h | 6 ++----
> > > > > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > > > > >
> > > > > > diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/in=
clude/asm/processor.h
> > > > > > index f19f861cda54..1f538fc4448d 100644
> > > > > > --- a/arch/riscv/include/asm/processor.h
> > > > > > +++ b/arch/riscv/include/asm/processor.h
> > > > > > @@ -16,15 +16,13 @@
> > > > > >
> > > > > >  #ifdef CONFIG_64BIT
> > > > > >  #define DEFAULT_MAP_WINDOW   (UL(1) << (MMAP_VA_BITS - 1))
> > > > > > -#define STACK_TOP_MAX                TASK_SIZE_64
> > > > > > +#define STACK_TOP_MAX                TASK_SIZE
> > > > >
> > > > > It means STACK_TOP_MAX will be in 64BIT:
> > > > > - TASK_SIZE_32 if compat_mode=3Dy
> > > > > - TASK_SIZE_64 if compat_mode=3Dn
> > > > >
> > > > > Makes sense for me.
> > > > >
> > > > > >
> > > > > >  #define arch_get_mmap_end(addr, len, flags)                  \
> > > > > >  ({                                                           \
> > > > > >       unsigned long mmap_end;                                 \
> > > > > >       typeof(addr) _addr =3D (addr);                           =
 \
> > > > > > -     if ((_addr) =3D=3D 0 || (IS_ENABLED(CONFIG_COMPAT) && is_=
compat_task())) \
> > > > > > -             mmap_end =3D STACK_TOP_MAX;                      =
 \
> > > > > > -     else if ((_addr) >=3D VA_USER_SV57)                      =
 \
> > > > > > +     if ((_addr) =3D=3D 0 || (_addr) >=3D VA_USER_SV57)       =
     \
> > > > > >               mmap_end =3D STACK_TOP_MAX;                      =
 \
> > > > > >       else if ((((_addr) >=3D VA_USER_SV48)) && (VA_BITS >=3D V=
A_BITS_SV48)) \
> > > > > >               mmap_end =3D VA_USER_SV48;                       =
 \
> > > > >
> > > > >
> > > > > I don't think I got this change, or how it's connected to the com=
mit msg.
> > > > The above is just code simplification; if STACK_TOP_MAX is TASK_SIZ=
E, then
> > > >
> > > >      if ((_addr) =3D=3D 0 || (IS_ENABLED(CONFIG_COMPAT) && is_compa=
t_task())) \
> > > >              mmap_end =3D STACK_TOP_MAX;                       \
> > > >     else if ((_addr) >=3D VA_USER_SV57)                       \
> > > >
> > > > is equal to:
> > > >
> > > >      if ((_addr) =3D=3D 0 || (_addr) >=3D VA_USER_SV57)            =
\
> > >
> > > I am failing to understand exactly how are they equal.
> > > I mean, what in your STACK_TOP_MAX change made them equal?
> > #define STACK_TOP_MAX TASK_SIZE
> > #define TASK_SIZE       (is_compat_task() ? TASK_SIZE_32 : TASK_SIZE_64=
)
> >
>
> yes, I am aware. Let's do a simple test with the new code and
> addr =3D 2^27 (random 32-bit addr) and compat mode.
>
> if ((_addr) =3D=3D 0 || (_addr) >=3D VA_USER_SV57)
>         // Evaluates to false: 2^27 !=3D 0, and is < 2^57
> else if ((((_addr) >=3D VA_USER_SV48)) && (VA_BITS >=3D VA_BITS_SV48))
>         // Evaluates to false: 2^27 < 2^48
> else
>         mmap_end =3D VA_USER_SV39;
>
> mmap_end =3D VA_USER_SV39, even in compat_mode.
>
> We need the extra is_compat_task() if we want to return 2^32.
Yes, my stupid, I fell into the wrong logic. Sorry for the noisy part,
which should be removed.

>
> Thanks!
> Leo
>
>
> > >
> > > See below, the behavior changed:
> > > >
> > > > >
> > > > > Before:
> > > > > - addr =3D=3D 0, or addr > 2^57, or compat: mmap_end =3D STACK_TO=
P_MAX
> > > > > - 2^48 < addr < 2^57: mmap_end =3D 2^48
> > > > > - 0 < addr < 2^48 : mmap_end =3D 2^39
> > > > >
> > > > > Now:
> > > > > - addr =3D=3D 0, or addr > 2^57: mmap_end =3D STACK_TOP_MAX
> > > > > - 2^48 < addr < 2^57: mmap_end =3D 2^48
> > > > > - 0 < addr < 2^48 : mmap_end =3D 2^39
> > > > >
> > > > > IIUC compat mode addr will be < 2^32, so will always have mmap_en=
d =3D 2^39
> > > > > if addr !=3D 0. Is that desireable?
> > > > > (if not, above change is unneeded)
> > > > >
> > >
> > > ^
> > >
> > > With your change on STACK_TOP_MAX only (not changing arch_get_mmap_en=
d),
> > > you would have:
> > >
> > > - compat_mode & (0 < addr < 2^32)       -> mmap_end =3D 2^32
> > compat_mode      -> mmap_end =3D 2^32
> >
>
> This is correct!
> Yeah, since you changed STACK_TOP_MAX to be 2^32 in compat mode,
> any addr value < 2^32 with compat value will return 2^32.
> (without the change in arch_get_mmap_end(), that is.)
>
> > > - non-compat, addr =3D=3D 0, or addr > 2^57 -> mmap_end =3D TASK_SIZE=
_64
> > > - non-compat, (2^48 < addr < 2^57)      -> mmap_end =3D 2^48
> > > - non-compat, (0 < addr < 2^48)         -> mmap_end =3D 2^39
> > >
> > > Which seems more likely, based on Charlie comments.
> > >
> > > Thanks,
> > > Leo
> > >
> > > > > Also, unrelated to the change:
> > > > > - 2^48 < addr < 2^57: mmap_end =3D 2^48
> > > > > Is the above correct?
> > > > > It looks like it should be 2^57 instead, and a new if clause for
> > > > > 2^32 < addr < 2^48 should have mmap_end =3D 2^48.
> > > > >
> > > > > Do I get it wrong?
> > > > Maybe I should move this into the optimization part.
> > > >
> > > > >
> > > > > (I will send an RFC 'fixing' the code the way I am whinking it sh=
ould look
> > > > > like)
> > > > >
> > > > > Thanks,
> > > > > Leo
> > > > >
> > > > >
> > > > >
> > > > >
> > > > >
> > > > > > --
> > > > > > 2.40.1
> > > > > >
> > > > >
> > > >
> > > >
> > > > --
> > > > Best Regards
> > > >  Guo Ren
> > > >
> > >
> >
> >
> > --
> > Best Regards
> >  Guo Ren
> >
>


--=20
Best Regards
 Guo Ren

