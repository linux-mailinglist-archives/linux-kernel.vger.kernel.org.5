Return-Path: <linux-kernel+bounces-9546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDA681C754
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 10:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF907286FDD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 09:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8A5F9C8;
	Fri, 22 Dec 2023 09:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWXbw1xB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA2111704;
	Fri, 22 Dec 2023 09:33:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9734C433CB;
	Fri, 22 Dec 2023 09:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703237612;
	bh=k2rXKI3XPOwdmCyThdzD0BJEHaTvbin4RkfhYTb2Kz8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oWXbw1xBlC41KDNUDLAbtUPkJhx4YGrQrbkTqrCv9GwBzZSFND2pZ4y8Opq/XBRIh
	 6ZD8U9K8my/mYra8d5Rz+XAtkPjw2XjdOHthsDYSJl6Me7gSiTfcorwdud/2BIZGjf
	 wgiEXOVyQCIjdf4h9m1I3RiyyLm2jGfRz+KJamNzNZNYWWfaCjKCJImsyTeeKnTrHQ
	 mt48dWe78QlGYPVy0Jv0h+8szIhYquPW/Fr8bdil3Vrdaby9dYqfiK58jySB8Orwxi
	 kvvpBrb1jqGiC2tHYgNhm22x9w0p4p8F70V+EYQ53Fh5X+wGHRqXE6g2TCn2A/KZd4
	 L6KnxYOfI3P9g==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-552d39ac3ccso5011066a12.0;
        Fri, 22 Dec 2023 01:33:32 -0800 (PST)
X-Gm-Message-State: AOJu0YxRgtfsrjN6nUty5wV6Z3e+h8UpsoltCna4YEpWz3azQdO3SqJ5
	sJF1hyLG6EMKQPPYNL5Kea4M3tO8dEzrnBB8sss=
X-Google-Smtp-Source: AGHT+IFzoz5ao5zFeU83eM84CibLxsmg2zWb6TKQTbQ7Xkkm/CAVivGBsWaWuETebeaVVyCjmMgKNz2LQ3f8eizyt+M=
X-Received: by 2002:a17:906:8404:b0:a23:5ea1:651d with SMTP id
 n4-20020a170906840400b00a235ea1651dmr2151343ejx.24.1703237611416; Fri, 22 Dec
 2023 01:33:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221154702.2267684-1-guoren@kernel.org> <20231221154702.2267684-3-guoren@kernel.org>
 <367b05acb90d4a6e898dd34e4254b697@AcuMS.aculab.com>
In-Reply-To: <367b05acb90d4a6e898dd34e4254b697@AcuMS.aculab.com>
From: Guo Ren <guoren@kernel.org>
Date: Fri, 22 Dec 2023 17:33:18 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRF-e=7kC3bTnQRVLygcagjs5b1+x-8tTb4PkB+XQniKA@mail.gmail.com>
Message-ID: <CAJF2gTRF-e=7kC3bTnQRVLygcagjs5b1+x-8tTb4PkB+XQniKA@mail.gmail.com>
Subject: Re: [PATCH V2 2/4] riscv: mm: Fixup compat arch_get_mmap_end
To: David Laight <David.Laight@aculab.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>, 
	"alexghiti@rivosinc.com" <alexghiti@rivosinc.com>, "charlie@rivosinc.com" <charlie@rivosinc.com>, 
	"xiao.w.wang@intel.com" <xiao.w.wang@intel.com>, "david@redhat.com" <david@redhat.com>, 
	"panqinglin2020@iscas.ac.cn" <panqinglin2020@iscas.ac.cn>, 
	"rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>, "willy@infradead.org" <willy@infradead.org>, 
	"bjorn@rivosinc.com" <bjorn@rivosinc.com>, 
	"conor.dooley@microchip.com" <conor.dooley@microchip.com>, "cleger@rivosinc.com" <cleger@rivosinc.com>, 
	"leobras@redhat.com" <leobras@redhat.com>, 
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, Guo Ren <guoren@linux.alibaba.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 5:00=E2=80=AFPM David Laight <David.Laight@aculab.c=
om> wrote:
>
> From: guoren@kernel.org <guoren@kernel.org>
> > Sent: 21 December 2023 15:47
> >
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > When the task is in COMPAT mode, the arch_get_mmap_end should be 2GB,
> > not TASK_SIZE_64. The TASK_SIZE has contained is_compat_mode()
> > detection, so change the definition of STACK_TOP_MAX to TASK_SIZE
> > directly.
>
> Why 2G ?
>
> IIRC for 32-bit native x86 the limit is 3G, but in compat mode
> it is (just under) 4G.
>
> There is a special mmap option (for programs like wine) to
> limit mmap() to 2G.
The 2G address space seems enough for a small memory scenario, and I
agree the compat mode could support 4G, but it should be another
feature.

We limited our rv32 applications to under 2GB because we want to leave
more address space for the kernel side (Our s64ilp32 kernel needs
vmmap stack, kasan ...).


>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1=
 1PT, UK
> Registration No: 1397386 (Wales)
>


--=20
Best Regards
 Guo Ren

