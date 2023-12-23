Return-Path: <linux-kernel+bounces-10210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6450581D147
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E32D81F23C71
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 02:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9E0EC2;
	Sat, 23 Dec 2023 02:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6avuW8u"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE16E391
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 02:38:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D23C43391
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 02:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703299128;
	bh=ssxnbrs5lADEShxHeiKZ8wSBXwAdgfEiXXPglxhgwOc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=c6avuW8uy5XifohaPpgHWSrPD9jmiJML7ekXvrmQvcSLRPkqXYLvZlyc6iLOFX0ct
	 lgh08EXQqV3Fl1IJO6HwjV5zFPSgBSXhNh9PWptfdYtULpSPsP22++OBRLqROktoA0
	 Lb+FeUwWkqHLSXQOjIOhBdu9HzuxZcP0pl3HHTmAR66rIgNjW4FJE69d4QodHiOohI
	 SBIMOgGJgL5N/BqaNEmlUyVdEG03LJiwdJWTS0/nJmVAYeCLqHL73WrrKZh0r4Xtot
	 0Sv3ISfrTrNNs69VvY91QPCmEKiOwqradJCUbXFCp+q+8vge/6n3Y4z/XtDG9nPYA7
	 eLXXTBqBKa0ug==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a1915034144so299636566b.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 18:38:48 -0800 (PST)
X-Gm-Message-State: AOJu0YyBT2ymdrZJvReypHCgs6vebgaa5WBmycwQIQ1WSDAMp/OEtybm
	0UnposCHjFoZe7GRhmnWTa535/UHWG8SDU14bAQ=
X-Google-Smtp-Source: AGHT+IEqOWfNyNc0/2v+zmiTSbh5yAwMykeA5i+bkdNvuDjfrKJEBmZ1aTCmcj3ZE2zi0ct9AEndKv+r+ugoTgCdULE=
X-Received: by 2002:a17:906:e20a:b0:a26:9963:5e58 with SMTP id
 gf10-20020a170906e20a00b00a2699635e58mr1287608ejb.69.1703299126789; Fri, 22
 Dec 2023 18:38:46 -0800 (PST)
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
Date: Sat, 23 Dec 2023 10:38:35 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQb=P2+0OY+KL0aQ4=0wgfHP-R-PfjO_b0_vxvqM+t0mQ@mail.gmail.com>
Message-ID: <CAJF2gTQb=P2+0OY+KL0aQ4=0wgfHP-R-PfjO_b0_vxvqM+t0mQ@mail.gmail.com>
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

Hi David,

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
I mean, I would remove is_compat_task() optimization.
test_thread_flag(TIF_32BIT) -> (is_compat_task() ?
Sorry for the bad wording.

Leonardo's new patch series contains the optimization on
is_compat_task(), so I canceled mine.


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

