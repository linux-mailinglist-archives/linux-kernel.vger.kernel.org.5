Return-Path: <linux-kernel+bounces-10256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A1781D1CF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 04:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F6D51C22D66
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3741368;
	Sat, 23 Dec 2023 03:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gppMJeW+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E9DEC7
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 03:15:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46BFBC433C8
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 03:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703301359;
	bh=YgXV2H2E4lib63YZl+21aGNsinOP8zIoh4LQ+TSqQqc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gppMJeW+EYMbS3bNIbyANp/orqGarhbzFzGusbqRCe8ohURH49pAfbOs+hHsvxMdJ
	 BqlfNTKvgPF3GzLuTtGgrVSHsHFGtziNWewn9pBKKinh43SooW2MRxf/z70ukzD2X6
	 c7B9RopPYsWgYkwWBl//aEuwNEn16lnKdciIHlqDoH7EJjjvgjhf48XKpuFlwf65Dx
	 IXYo3b1mHCjHF4H64S6xhDkwx0JNx/wHQv/gQOJuPcc0zRmqUa1hhZJ1lIir5oHsQ/
	 VfnKAHw2t1AF8UhzWU04fAkbuwVLtSQn6+g9NH0tUnnu6yboIKolKuiTTIhoEgHZ6X
	 8cBRfTr6B6vIg==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-54f4f7e88feso2943055a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 19:15:59 -0800 (PST)
X-Gm-Message-State: AOJu0Yz9rkmqRRO0Oky0bbTyIdFH2lVluzPRfAf0BndRtvUUY/3+xqtv
	DgjqQoOqGFgUBZ3p0mtUPFBSjdcxQ5BXRcAL7vQ=
X-Google-Smtp-Source: AGHT+IEAXORQPrk2FyHUNnxz7BvwRV5zSaBsntJOpgsIdpjqLihNl+lKwgPFNStbngrYGGgkg+gRb2bdrN8z9mRyM+Q=
X-Received: by 2002:a50:ee09:0:b0:554:2905:a529 with SMTP id
 g9-20020a50ee09000000b005542905a529mr1202503eds.85.1703301357716; Fri, 22 Dec
 2023 19:15:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230810040349.92279-2-leobras@redhat.com> <ZP2DVap64lJZj9g4@gmail.com>
 <ZYZPA-Ugfowk1VXq@LeoBras>
In-Reply-To: <ZYZPA-Ugfowk1VXq@LeoBras>
From: Guo Ren <guoren@kernel.org>
Date: Sat, 23 Dec 2023 11:15:46 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTKb6_E+hKXB063oZtyWJ9vQxRgq4j-8TbqZtNgd=WJOg@mail.gmail.com>
Message-ID: <CAJF2gTTKb6_E+hKXB063oZtyWJ9vQxRgq4j-8TbqZtNgd=WJOg@mail.gmail.com>
Subject: Re: [RFC PATCH v5 0/5] Rework & improve riscv cmpxchg.h and atomic.h
To: Leonardo Bras <leobras@redhat.com>
Cc: Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Mark Rutland <mark.rutland@arm.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Andrea Parri <parri.andrea@gmail.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Arnd Bergmann <arnd@arndb.de>, 
	Palmer Dabbelt <palmer@rivosinc.com>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 23, 2023 at 11:08=E2=80=AFAM Leonardo Bras <leobras@redhat.com>=
 wrote:
>
> On Sun, Sep 10, 2023 at 04:50:29AM -0400, Guo Ren wrote:
> > On Thu, Aug 10, 2023 at 01:03:42AM -0300, Leonardo Bras wrote:
> > > While studying riscv's cmpxchg.h file, I got really interested in
> > > understanding how RISCV asm implemented the different versions of
> > > {cmp,}xchg.
> > >
> > > When I understood the pattern, it made sense for me to remove the
> > > duplications and create macros to make it easier to understand what e=
xactly
> > > changes between the versions: Instruction sufixes & barriers.
> > >
> > > Also, did the same kind of work on atomic.c.
> > >
> > > After that, I noted both cmpxchg and xchg only accept variables of
> > > size 4 and 8, compared to x86 and arm64 which do 1,2,4,8.
> > >
> > > Now that deduplication is done, it is quite direct to implement them
> > > for variable sizes 1 and 2, so I did it. Then Guo Ren already present=
ed
> > > me some possible users :)
> > >
> > > I did compare the generated asm on a test.c that contained usage for =
every
> > > changed function, and could not detect any change on patches 1 + 2 + =
3
> > > compared with upstream.
> > >
> > > Pathes 4 & 5 were compiled-tested, merged with guoren/qspinlock_v11 a=
nd
> > > booted just fine with qemu -machine virt -append "qspinlock".
> > >
> > > (tree: https://gitlab.com/LeoBras/linux/-/commits/guo_qspinlock_v11)
> > Tested-by: Guo Ren <guoren@kernel.org>
> >
>
> Hello Guo Ren, thanks for testing!
>
> I will resend this series, and I would like to understand how should I pu=
t
> your Tested-by over this patchset:
>
> Is it ok if I add it on each patch of this series?
Yes, my qspinlock_v12 based on your patch series.
https://github.com/guoren83/linux/tree/qspinlock_v12

Some people tell me paravirt-qspinlock can't work with nested
virtualization, but I haven't found a way to set up a test
environment. I'm working on that.



>
> Thanks!
> Leo
>
>
> > Sorry for late reply, because we are stress testing CNA qspinlock on
> > sg2042 128 cores hardware platform. This series has passed our test for
> > several weeks. For more detail, ref:
> > https://lore.kernel.org/linux-riscv/20230910082911.3378782-1-guoren@ker=
nel.org/
> >
> > >
> > > Thanks!
> > > Leo
> > >
> > > Changes since squashed cmpxchg RFCv4:
> > > - Added (__typeof__(*(p))) before returning from {cmp,}xchg, as done
> > >   in current upstream, (possibly) fixing the bug from kernel test rob=
ot
> > > https://lore.kernel.org/all/20230809021311.1390578-2-leobras@redhat.c=
om/
> > >
> > > Changes since squashed cmpxchg RFCv3:
> > > - Fixed bug on cmpxchg macro for var size 1 & 2: now working
> > > - Macros for var size 1 & 2's lr.w and sc.w now are guaranteed to rec=
eive
> > >   input of a 32-bit aligned address
> > > - Renamed internal macros from _mask to _masked for patches 4 & 5
> > > - __rc variable on macros for var size 1 & 2 changed from register to=
 ulong
> > > https://lore.kernel.org/all/20230804084900.1135660-2-leobras@redhat.c=
om/
> > >
> > > Changes since squashed cmpxchg RFCv2:
> > > - Removed rc parameter from the new macro: it can be internal to the =
macro
> > > - 2 new patches: cmpxchg size 1 and 2, xchg size 1 and 2
> > > https://lore.kernel.org/all/20230803051401.710236-2-leobras@redhat.co=
m/
> > >
> > > Changes since squashed cmpxchg RFCv1:
> > > - Unified with atomic.c patchset
> > > - Rebased on top of torvalds/master (thanks Andrea Parri!)
> > > - Removed helper macros that were not being used elsewhere in the ker=
nel.
> > > https://lore.kernel.org/all/20230419062505.257231-1-leobras@redhat.co=
m/
> > > https://lore.kernel.org/all/20230406082018.70367-1-leobras@redhat.com=
/
> > >
> > > Changes since (cmpxchg) RFCv3:
> > > - Squashed the 6 original patches in 2: one for cmpxchg and one for x=
chg
> > > https://lore.kernel.org/all/20230404163741.2762165-1-leobras@redhat.c=
om/
> > >
> > > Changes since (cmpxchg) RFCv2:
> > > - Fixed  macros that depend on having a local variable with a magic n=
ame
> > > - Previous cast to (long) is now only applied on 4-bytes cmpxchg
> > > https://lore.kernel.org/all/20230321074249.2221674-1-leobras@redhat.c=
om/
> > >
> > > Changes since (cmpxchg) RFCv1:
> > > - Fixed patch 4/6 suffix from 'w.aqrl' to '.w.aqrl', to avoid build e=
rror
> > > https://lore.kernel.org/all/20230318080059.1109286-1-leobras@redhat.c=
om/
> > >
> > > Leonardo Bras (5):
> > >   riscv/cmpxchg: Deduplicate xchg() asm functions
> > >   riscv/cmpxchg: Deduplicate cmpxchg() asm and macros
> > >   riscv/atomic.h : Deduplicate arch_atomic.*
> > >   riscv/cmpxchg: Implement cmpxchg for variables of size 1 and 2
> > >   riscv/cmpxchg: Implement xchg for variables of size 1 and 2
> > >
> > >  arch/riscv/include/asm/atomic.h  | 164 ++++++-------
> > >  arch/riscv/include/asm/cmpxchg.h | 404 ++++++++++-------------------=
--
> > >  2 files changed, 200 insertions(+), 368 deletions(-)
> > >
> > >
> > > base-commit: cacc6e22932f373a91d7be55a9b992dc77f4c59b
> > > --
> > > 2.41.0
> > >
> > >
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> > >
> >
>


--
Best Regards
 Guo Ren

