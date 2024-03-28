Return-Path: <linux-kernel+bounces-120174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B991288D3BB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 02:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B0C81F34451
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 01:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44CF3DAC0D;
	Wed, 27 Mar 2024 01:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNDC+7s0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06C11CFA9
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 01:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711502884; cv=none; b=kFl9n7MHROpvnkzOzrg++2o7qCOGa6KtYn1/e0PHQ/RhU4cYmuWy3+JrefMlppGEmN1JAdKw6hZO5qRi4+vdpeHzE4d5LRUH2Hc36KhmYomgtQ7EMz19ncbpsQLsb4MBoJysqoeCE649/ygtsdgQwz0dM730u1mfTq0giT5QJgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711502884; c=relaxed/simple;
	bh=tsD1Jo9bLVDB9au4XppIzlJwr4H/IPzxGg62vjK5zl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LjUmYH4uiBNkVrKmRIp+zrDp5ghVDyREo5mHbcyStF7RCbbJbXtS2mo2q63NT4L677rGFEla+gMyoOU9zotK/OjUmM/y3KgZUY5LLpivriNO+JLkiZT/gqCZpSKTeD9yx9DBgi62Z1oE3lgg/dvUGhpC02//8oKzrXwRI84RiC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNDC+7s0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC606C433F1;
	Wed, 27 Mar 2024 01:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711502884;
	bh=tsD1Jo9bLVDB9au4XppIzlJwr4H/IPzxGg62vjK5zl4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hNDC+7s0VfwR+gTfhz2HUgmUnSqlpSpwat9bUdUF8qcUUcJcuP/ClB89Wd+BYhFF5
	 ubSJ1zx2I9f+NWaX97dCfLgvWGhM34r4BSqbDqpDHOWs77VVabA1guPHdU9g4LmVfA
	 bup/pfgu2cxyo5sHfx5oJ3ZqUVAxSt8VDzyLObUb+xMSZ9/2KZ/J1myva/cVHEaPEs
	 zBItPMxmpV1Vem1Xlmjljr9AH/SfP1BYVS+FhkqRAf4HVKJcmvJCmd7qbqCPNRoNjP
	 LudduteyX54EwisQZtSjXvxquEmfpeATshe1j2QG+VW+UMlk3HBCoVkjkaaBNrFLct
	 V4teYOp4Rvugw==
Date: Wed, 27 Mar 2024 09:14:47 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Charles Lohr <lohr85@gmail.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, cleger@rivosinc.com,
	Conor Dooley <conor@kernel.org>, samuel.holland@sifive.com,
	Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>, ajones@ventanamicro.com,
	dlemoal@kernel.org, Bjorn Topel <bjorn@rivosinc.com>,
	Atish Patra <atishp@rivosinc.com>
Subject: Re: [PATCH] riscv: deprecate CONFIG_MMU=n
Message-ID: <ZgNzBwsmeibHMjvc@xhacker>
References: <a49546e8-6749-4458-98da-67fd37b7df18@rivosinc.com>
 <mhng-a3b495e6-aca6-4137-a3c1-8fcacafd8596@palmer-ri-x1c9a>
 <ZfLxip96o5MVjHAF@xhacker>
 <ZfL1buKdDI-p5b9X@xhacker>
 <ZgGteKG_a3KGn5wV@xhacker>
 <CAGu26P_tUpSvXqdSz3pOdPNHbe6MyEYJ2XCHo8pD8jeE5pT+_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGu26P_tUpSvXqdSz3pOdPNHbe6MyEYJ2XCHo8pD8jeE5pT+_Q@mail.gmail.com>

On Tue, Mar 26, 2024 at 01:25:08PM -0700, Charles Lohr wrote:
> Jisheng, are you using musl or uclibc? I've been having difficulty
> getting new versions of each working with the newer kernels with
> system calls not lining up.

Hi Charles,

I tested nommu linux with uclibc, both rv32 and rv64

Thanks

> 
> Also, is there a better place to ask questions about the more
> user-spacy stuff?  That's really where I've been struggling to
> maintain things, keeping buildroot working when targeting RV32 NOMMU.
> Thankfully a lot of the stickiest problems have all been upstreamed.
> 
> Charles
> 
> On Mon, Mar 25, 2024 at 10:12 AM Jisheng Zhang <jszhang@kernel.org> wrote:
> >
> > On Thu, Mar 14, 2024 at 09:02:43PM +0800, Jisheng Zhang wrote:
> > > On Thu, Mar 14, 2024 at 08:46:21PM +0800, Jisheng Zhang wrote:
> > > > On Tue, Feb 27, 2024 at 08:38:50AM -0800, Palmer Dabbelt wrote:
> > > > > On Tue, 27 Feb 2024 01:11:41 PST (-0800), cleger@rivosinc.com wrote:
> > > > > >
> > > > > >
> > > > > > On 26/02/2024 20:00, Charles Lohr wrote:
> > > > > > > WOAH! Please DO NOT deprecate NOMMU. I use the NOMMU build constantly
> > > > > > > and NOMMU Linux on RISC-V is the avenue used by many FPGA soft cores
> > > > > > > for Linux, as well as some limited systems.
> > > > >
> > > > > OK.
> > > > >
> > > > > I just build test this stuff, as I don't really have a use for it
> > > > > personally.  I figured if nobody's reporting bugs then probably it's broken
> > > > > and nobody's noticed because nobody's using it.
> > > > >
> > > > > > > I get new copies of the kernel when there are releases and test them
> > > > > > > frequently to make sure everything is still working as expected.
> > > > >
> > > > > I'd actually expected it to be broken, but I guess we managed to avoid
> > > > > screwing things up ;)
> > > > >
> > > > > > > For us we just don't care about XIP. I mean if someone did push it
> > > >
> > > > I don't care XIP either, and IMHO the XIP's maintenance effort is much
> > > > bigger than NOMMU(just check the various XIP_FIXUP* or CONFIG_XIP_KERNEL
> > > > macros around lowlevel pgtable.h, page.h). If we can remove XIP, the
> > > > code readability will be much better.
> > > >
> > > > Or sending out a similar XIP deprecation patch to see whether there's
> > > > any complain ? ;)
> > > >
> > > > > > > through to fruition, I'd also test and use it, but I urge you please
> > > > > > > do not deprecate this.  While it's sometimes needed a bit of a
> > > >
> > > > +1 for urge the upstream please do not deprecate NOMMU.
> > > >
> > > > Besides the soft(FPGA) core mentioned by Charles, here is another real
> > >
> > > And I'd like to write more about soft core: riscv is a free and open
> > > ISA, this make it really good for education, for simple riscv
> > > implementation or emulator. Once riscv IMA is implemented(even if MMU,
> > > cache, TLB stuff don't exist), it's not far away from making linux
> > > running on the FPGA or emulator. If the gain is larger than the maintenance
> > > effort, I'd like to urge keeping the NOMMU support.
> > >
> > > Thanks a lot
> > >
> > > > usage case: As is known, Sophgo CV1800B platforms such as Milk Duo
> > > > contains two C906 core, one(a.k.a big core) with MMU another(a.k.a small
> > > > core)w/o MMU. The vendor sdk runs freertos on the small core, but it
> > > > doesn't prevent users to run other OS such as threadx, zephyr or nommu
> > > > linux on the small core. In fact, I sucessfully brought up nommu linux
> > > > on the small core. I didn't just send out the patches in time during this
> > > > dev window duo to my personal career reason(I spent the time on hunting
> > > > for a new job)
> > > >
> > > > I plan to send out NOMMU related patches once 6.9-rc1 is out.
> >
> > As is promised, the NOMMU improvement patches are sent out
> > https://lore.kernel.org/linux-riscv/20240325164021.3229-1-jszhang@kernel.org/T/#t
> >
> > Thanks
> >
> > > >
> > > > > > > creative build to get everything working, I've never needed to patch
> > > > > > > anything in the kernel beyond patching in a custom console for serial
> > > > > > > output.
> > > > > > >
> > > > > >
> > > > > > Hey Charles,
> > > > > >
> > > > > > No worries, we actually did not expected NOMMU to have *so many* users.
> > > > > > I guess deprecating stuff is a good way to have immediate feedback ;).
> > > > > > Having FDPIC psABI to be merged upstream could also probably be a
> > > > > > positive point toward a better NOMMU support.
> > > > >
> > > > > Ya, that's probably the right way to do it.  Touching anything in the psABI
> > > > > is pretty miserable, though, so I don't really want to force people to do
> > > > > it...
> > > > >
> > > > > > > I am happy to discuss the possibility of me and or one of the other
> > > > > > > RISC-V soft (FPGA) core people stepping up to try to be more active,
> > > > > > > but so far we've just been very well serviced by the current NOMMU
> > > > > > > Linux setup.
> > > > > >
> > > > > > It could probably be nice to have some feedback/Tested-by: from NOMMU
> > > > > > users for new releases then.
> > > > >
> > > > > Having more upstream interaction from users is always appreciated, that's
> > > > > the best way to prove people are using the code.  If you guys have the time
> > > > > it'd be great to get this into some sort of CI, ideally running on some real
> > > > > platform.
> > > >
> > > > As above, I'd also like to step up on the NOMMU stuff, at least test
> > > > nommu on milkv duo's small core. And can be seen from my git commit
> > > > histotry, I was active, and I belive I will still be active on riscv linux
> > > > kernel development.
> > > >
> > > > >
> > > > > > Thanks,
> > > > > >
> > > > > > Clément
> > > > > >
> > > > > > >
> > > > > > > Charles
> > > > > > >
> > > > > > >
> > > > > > > On Mon, Feb 26, 2024 at 8:03 AM Conor Dooley <conor@kernel.org> wrote:
> > > > > > > >
> > > > > > > > On Mon, Feb 26, 2024 at 04:25:24PM +0100, Clément Léger wrote:
> > > > > > > > > I guess I could also mark XIP as deprecated.
> > > > > > > >
> > > > > > > > I'm not so sure, people recently added XIP support to QEMU (and sent
> > > > > > > > kernel fixes in December). XIP is also not nearly as much of a problem
> > > > > > > > to support, there's far less that it does differently, the main barrier
> > > > > > > > was the inability to test it which is no longer the case.
> > > > > > > > That said, XIP is gonna kill itself off I feel as it does not support
> > > > > > > > runtime patching and therefore is extremely limited on extensions, given
> > > > > > > > we use alternatives for all of that (although I suppose if someone has a
> > > > > > > > usecase they could make nasty macros worse and implement a compiletime
> > > > > > > > switch in the alternatives too).
> > > > > > > >
> > > > > > > > Cheers,
> > > > > > > > Conor.
> > > > > > > >
> > > > > > > > _______________________________________________
> > > > > > > > linux-riscv mailing list
> > > > > > > > linux-riscv@lists.infradead.org
> > > > > > > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> > > > >
> > > > > _______________________________________________
> > > > > linux-riscv mailing list
> > > > > linux-riscv@lists.infradead.org
> > > > > http://lists.infradead.org/mailman/listinfo/linux-riscv

