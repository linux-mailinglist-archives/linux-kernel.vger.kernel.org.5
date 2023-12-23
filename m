Return-Path: <linux-kernel+bounces-10252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED1F81D1C8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 04:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C13481C227F7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA6B4C6C;
	Sat, 23 Dec 2023 03:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uYV75HBs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567BA6108;
	Sat, 23 Dec 2023 03:07:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3AF0C433CA;
	Sat, 23 Dec 2023 03:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703300861;
	bh=kZedLaa16kwTEyFxJs+q6Gr9GjNmSh1HuJCb7sl/NTs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uYV75HBsOfO/d3tsP14QnJ41zHZbL+lOfttKwgKmrJWBio3nQhlj8wVDZbOELE9HM
	 E/QyQeltlfwQ/kr6LlXXmxfali8U0hb/2y2GcAjC8yMAszF3qaG+WQlJSYSbU3QZ+Z
	 bhLRxrRHObuW+JwcMWg+oMyQwrHFvUuspCae3K/bJSVutEtG7YkvYM8yGQ33cileUa
	 WKuJr6lePPCY3fzkzO0TbmNDhjTeij7792LrUkXMJR+GOWze1RvNaFMNrGVFaIsvTE
	 hmzIdLLU0/kfIzWel1RWts//Xgc1fr6ZCt4Goc/fplAjCek3G24Hs8cyPTJ2Yd9L5V
	 Tr4UcZaXipefA==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a236d77dceeso285142866b.2;
        Fri, 22 Dec 2023 19:07:41 -0800 (PST)
X-Gm-Message-State: AOJu0YyyHdEx8OyA93jNc6VtXAV/PJFMg4g5v3Hr8Wq1hQpn3WxVQv4I
	qky/w5S2xfOFPxY6YdBVlXQJpc78mP6LRdM5Uic=
X-Google-Smtp-Source: AGHT+IFtb17ydeBiPuJbAjCzuvD7pJhi1ywoe1Fs8tNlKXIs9PlRdzxw9WzQS3h3TxK0p8IQwe0Lhud5AkJP0oaCeMY=
X-Received: by 2002:a17:906:714d:b0:a26:92be:4592 with SMTP id
 z13-20020a170906714d00b00a2692be4592mr801420ejj.162.1703300860215; Fri, 22
 Dec 2023 19:07:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222115703.2404036-1-guoren@kernel.org> <20231222115703.2404036-2-guoren@kernel.org>
 <ZYZMsgL9Bcz1J_Bd@LeoBras>
In-Reply-To: <ZYZMsgL9Bcz1J_Bd@LeoBras>
From: Guo Ren <guoren@kernel.org>
Date: Sat, 23 Dec 2023 11:07:29 +0800
X-Gmail-Original-Message-ID: <CAJF2gTR7VvHhm4QUpEkk8P=b__HqbXZ7ggW9DvkD1fUpoKPTew@mail.gmail.com>
Message-ID: <CAJF2gTR7VvHhm4QUpEkk8P=b__HqbXZ7ggW9DvkD1fUpoKPTew@mail.gmail.com>
Subject: Re: [PATCH V3 1/4] riscv: mm: Fixup compat mode boot failure
To: Leonardo Bras <leobras@redhat.com>, charlie@rivosinc.com
Cc: linux-kernel@vger.kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	alexghiti@rivosinc.com, xiao.w.wang@intel.com, david@redhat.com, 
	panqinglin2020@iscas.ac.cn, rick.p.edgecombe@intel.com, willy@infradead.org, 
	bjorn@rivosinc.com, conor.dooley@microchip.com, cleger@rivosinc.com, 
	linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 23, 2023 at 10:58=E2=80=AFAM Leonardo Bras <leobras@redhat.com>=
 wrote:
>
> On Fri, Dec 22, 2023 at 06:57:00AM -0500, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > In COMPAT mode, the STACK_TOP is DEFAULT_MAP_WINDOW (0x80000000), but
> > the TASK_SIZE is 0x7fff000. When the user stack is upon 0x7fff000, it
> > will cause a user segment fault. Sometimes, it would cause boot
> > failure when the whole rootfs is rv32.
> >
> > Freeing unused kernel image (initmem) memory: 2236K
> > Run /sbin/init as init process
> > Starting init: /sbin/init exists but couldn't execute it (error -14)
> > Run /etc/init as init process
> > ...
> >
> > Increase the TASK_SIZE to cover STACK_TOP.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: add2cc6b6515 ("RISC-V: mm: Restrict address space for sv39,sv48,=
sv57")
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > ---
> >  arch/riscv/include/asm/pgtable.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/=
pgtable.h
> > index ab00235b018f..74ffb2178f54 100644
> > --- a/arch/riscv/include/asm/pgtable.h
> > +++ b/arch/riscv/include/asm/pgtable.h
> > @@ -881,7 +881,7 @@ static inline pte_t pte_swp_clear_exclusive(pte_t p=
te)
> >  #define TASK_SIZE_MIN        (PGDIR_SIZE_L3 * PTRS_PER_PGD / 2)
> >
> >  #ifdef CONFIG_COMPAT
> > -#define TASK_SIZE_32 (_AC(0x80000000, UL) - PAGE_SIZE)
> > +#define TASK_SIZE_32 (_AC(0x80000000, UL))
> >  #define TASK_SIZE    (test_thread_flag(TIF_32BIT) ? \
> >                        TASK_SIZE_32 : TASK_SIZE_64)
> >  #else
> > --
> > 2.40.1
> >
>
> I am not really involved in the issue this is solving, so I have no
> technical opinion on the solution.
>
> IIUC there should always be (TASK_SIZE >=3D STACK_TOP), so by itself this
> is fixing an issue.
>
> I have reviewed the code and it does exactly as stated into the commit
> message, so FWIW:
> Reviewed-by: Leonardo Bras <leobras@redhat.com>
Thx,

I found this problem because it can't boot my rv32 buildroot-rootfs in
v6.6. But it's okay in v6.5. So I used git bisect and found commit:
add2cc6b6515 ("RISC-V: mm: Restrict address space for
sv39,sv48,sv57"), which caused that.

Ping Charlie, I hope it can be fixed in the v6.6 long-term version.

>



--
Best Regards
 Guo Ren

