Return-Path: <linux-kernel+bounces-10213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5F681D14B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B435A284BA1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 02:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AEDD138F;
	Sat, 23 Dec 2023 02:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQh3OKkE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0261368
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 02:52:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 621EFC433D9
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 02:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703299969;
	bh=rGnjRsJeeEvv71gmE5cTVsYlTCyd72dN5f4IXTVEfoM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LQh3OKkE3rSV4uLpymgW+d9EI1/XuHbmbyO5rf2XHRh3VnMJVKXJAuYM/ivMIYzNc
	 JL5l5ff2zFR+Lf4CapDVYEOTxKLdqIQ+IHBXps0d+MqCX+J6ui6MOOF46emXCNsyu5
	 yz+dxshxQH/QZA8i+crBkslhoAq2sO4qC4jnMQizE/cbpCSbb8FE2sDRcSX7q7fwE9
	 1mrOcIisJGojcOZGwXp20SxrYS4aIVRaWGARLU936nzIjuVEpQ+gj+1/Hf/v93o2nJ
	 /xEQ5L0uazoDBerVoAx42w+A4J1uZcM2odFsVNvjXSvvk55d2yAv206pWwOzRANLlx
	 3LlM2zHW5RqsQ==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55485e45ef9so187105a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 18:52:49 -0800 (PST)
X-Gm-Message-State: AOJu0YxbJbZdN0UCtQ0M8cYTdHq1XfImx5B4+Qjd+wjyan72N4ugohjI
	5du7fSq19bpJFwyysZEYlIRG0iZmkGFIYGRUpZc=
X-Google-Smtp-Source: AGHT+IEA3F1ZH6akb6TqgOv4EwDv+FR0JNU+GRUyUtR0om3BzEz50XDimZiwdW0XxmY19KszQQcTqA43lyTSe7B6tjc=
X-Received: by 2002:a17:906:25d:b0:a26:98ff:6464 with SMTP id
 29-20020a170906025d00b00a2698ff6464mr1182977ejl.17.1703299967812; Fri, 22 Dec
 2023 18:52:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221154702.2267684-1-guoren@kernel.org> <20231221154702.2267684-5-guoren@kernel.org>
 <ZYUZ8QUJxCL93Fgv@LeoBras> <CAJF2gTTX7AjexoRUw=ZS34HEWno7H3zvnXA+Q7TYsztNU=k2cg@mail.gmail.com>
 <e3f1521a9f04463587d07d0c99534d5a@AcuMS.aculab.com>
In-Reply-To: <e3f1521a9f04463587d07d0c99534d5a@AcuMS.aculab.com>
From: Guo Ren <guoren@kernel.org>
Date: Sat, 23 Dec 2023 10:52:36 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRD827Fbs_2FxBP=Z8yudfAAqG6dA+a9eq74RMOz2WDnw@mail.gmail.com>
Message-ID: <CAJF2gTRD827Fbs_2FxBP=Z8yudfAAqG6dA+a9eq74RMOz2WDnw@mail.gmail.com>
Subject: Re: [PATCH V2 4/4] riscv: mm: Optimize TASK_SIZE definition
To: David Laight <David.Laight@aculab.com>
Cc: Leonardo Bras <leobras@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>, 
	"alexghiti@rivosinc.com" <alexghiti@rivosinc.com>, "charlie@rivosinc.com" <charlie@rivosinc.com>, 
	"xiao.w.wang@intel.com" <xiao.w.wang@intel.com>, "david@redhat.com" <david@redhat.com>, 
	"panqinglin2020@iscas.ac.cn" <panqinglin2020@iscas.ac.cn>, 
	"rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>, "willy@infradead.org" <willy@infradead.org>, 
	"bjorn@rivosinc.com" <bjorn@rivosinc.com>, 
	"conor.dooley@microchip.com" <conor.dooley@microchip.com>, "cleger@rivosinc.com" <cleger@rivosinc.com>, 
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 7:52=E2=80=AFPM David Laight <David.Laight@aculab.c=
om> wrote:
>
> From: Guo Ren
> > Sent: 22 December 2023 11:25
> ...
> > > > +#define TASK_SIZE    (is_compat_task() ? \
> > > >                        TASK_SIZE_32 : TASK_SIZE_64)
> > I would remove is_compat_task() in the next version because your patch
> > contains that.
>
> Does TASK_SIZE get used in access_ok() ?
> If so the repeated expansion of that 'mess' will slow things down.
>
> OTOH access_ok(ptr, len) can just check (ptr | (ptr + len)) < 0)
> and rely on the page faults for everything else.
Or do you want to discuss the bad side effect of is_compat_task()?

Yes, test_thread_flag(TIF_32BIT) would slow down access_ok(). But if
we use TASK_SIZE_MAX, VA_BITS still needs pgtable_l5_enabled,
pgtable_l4_enabled detectation for riscv.

It's not only for compat mode, but also Sv39, Sv48, Sv57. All treat
TASK_SIZE_MAX as 0x8000000000000000, right? Then:
access_ok(ptr, len) can just check (ptr | (ptr + len)) < 0)

It's another feature and does not relate to compat mode.

>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1=
 1PT, UK
> Registration No: 1397386 (Wales)



--=20
Best Regards
 Guo Ren

