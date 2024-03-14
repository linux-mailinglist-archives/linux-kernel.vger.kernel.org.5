Return-Path: <linux-kernel+bounces-103260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02CFF87BD20
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C5E2281F69
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC8C59B6E;
	Thu, 14 Mar 2024 12:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Db4N6OYd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2036266A7
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 12:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710421167; cv=none; b=ktCAYO1bmuetr113cpYHG7LruEyjWB3hXnPk3ikpKjeHPkKRyfIp9RLvktVqzHN19iL9bPmaSpTd4p7QeJS7VGbmsV5atbO73BDyz65KNBYMgug2IRYX3o38+blpgtDSSwQSTsBW3Rm7YapI7jtvoqZRvkfwLin0y2/Rq6qtqiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710421167; c=relaxed/simple;
	bh=cWpIcy1SqaH5FFzZ4VCvrLKwWceILonl7ADuV3qQTzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aWy2UIEb84wwrr0ND72cpwNh6JLvA1dn5uDF2YW3k4sQHmp2vDkDtUswRLaLYaCD+b7hbdvfOklOns8RhdjvC32arZv7Ph8AzwjrS0mD3z9W3gE8iOj2OePNAfraK2OsF8eDK+d7nHGEOwHn7DSFM2uhYMy/FanmT3TMYU0YEdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Db4N6OYd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D2D8C433F1;
	Thu, 14 Mar 2024 12:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710421167;
	bh=cWpIcy1SqaH5FFzZ4VCvrLKwWceILonl7ADuV3qQTzQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Db4N6OYd6HcgE5gvGs25sIHBt5aeYgmOBMkbUxI0R9pqGL+dUPvOyyhQuDc7tTuCy
	 UwW7iPmCT8YkLx8VUYMMauO09soSkb84Pzje9IkhJ8RLvNBKoNtRkaNQa2KRKYnh24
	 z7sQAVSe0rM3cTvxsd0fQcap35dkGpOo+asJOuMmoKTm0MysMm6FTZeC0n9D79ErJe
	 Q+HO6v2DIdWFm48zdAN/l+fmbZuOaWosr5/Jw0wA/Bh9EJU5wasMnz8lA8D/D51Tcc
	 dRyLM6XWKY+md2H5Qgg89GfSqj2fu0HidXhWVw2f9XkTSHwM9c9zPppr+IP6DUa+QW
	 lletP+/Z6BDpw==
Date: Thu, 14 Mar 2024 20:46:02 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: cleger@rivosinc.com, lohr85@gmail.com, Conor Dooley <conor@kernel.org>,
	samuel.holland@sifive.com, Paul Walmsley <paul.walmsley@sifive.com>,
	aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>, ajones@ventanamicro.com,
	dlemoal@kernel.org, Bjorn Topel <bjorn@rivosinc.com>,
	Atish Patra <atishp@rivosinc.com>
Subject: Re: [PATCH] riscv: deprecate CONFIG_MMU=n
Message-ID: <ZfLxip96o5MVjHAF@xhacker>
References: <a49546e8-6749-4458-98da-67fd37b7df18@rivosinc.com>
 <mhng-a3b495e6-aca6-4137-a3c1-8fcacafd8596@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <mhng-a3b495e6-aca6-4137-a3c1-8fcacafd8596@palmer-ri-x1c9a>

On Tue, Feb 27, 2024 at 08:38:50AM -0800, Palmer Dabbelt wrote:
> On Tue, 27 Feb 2024 01:11:41 PST (-0800), cleger@rivosinc.com wrote:
> > 
> > 
> > On 26/02/2024 20:00, Charles Lohr wrote:
> > > WOAH! Please DO NOT deprecate NOMMU. I use the NOMMU build constantly
> > > and NOMMU Linux on RISC-V is the avenue used by many FPGA soft cores
> > > for Linux, as well as some limited systems.
> 
> OK.
> 
> I just build test this stuff, as I don't really have a use for it
> personally.  I figured if nobody's reporting bugs then probably it's broken
> and nobody's noticed because nobody's using it.
> 
> > > I get new copies of the kernel when there are releases and test them
> > > frequently to make sure everything is still working as expected.
> 
> I'd actually expected it to be broken, but I guess we managed to avoid
> screwing things up ;)
> 
> > > For us we just don't care about XIP. I mean if someone did push it

I don't care XIP either, and IMHO the XIP's maintenance effort is much
bigger than NOMMU(just check the various XIP_FIXUP* or CONFIG_XIP_KERNEL
macros around lowlevel pgtable.h, page.h). If we can remove XIP, the
code readability will be much better.

Or sending out a similar XIP deprecation patch to see whether there's
any complain ? ;)

> > > through to fruition, I'd also test and use it, but I urge you please
> > > do not deprecate this.  While it's sometimes needed a bit of a

+1 for urge the upstream please do not deprecate NOMMU.

Besides the soft(FPGA) core mentioned by Charles, here is another real
usage case: As is known, Sophgo CV1800B platforms such as Milk Duo
contains two C906 core, one(a.k.a big core) with MMU another(a.k.a small
core)w/o MMU. The vendor sdk runs freertos on the small core, but it
doesn't prevent users to run other OS such as threadx, zephyr or nommu
linux on the small core. In fact, I sucessfully brought up nommu linux
on the small core. I didn't just send out the patches in time during this
dev window duo to my personal career reason(I spent the time on hunting
for a new job)

I plan to send out NOMMU related patches once 6.9-rc1 is out.

> > > creative build to get everything working, I've never needed to patch
> > > anything in the kernel beyond patching in a custom console for serial
> > > output.
> > > 
> > 
> > Hey Charles,
> > 
> > No worries, we actually did not expected NOMMU to have *so many* users.
> > I guess deprecating stuff is a good way to have immediate feedback ;).
> > Having FDPIC psABI to be merged upstream could also probably be a
> > positive point toward a better NOMMU support.
> 
> Ya, that's probably the right way to do it.  Touching anything in the psABI
> is pretty miserable, though, so I don't really want to force people to do
> it...
> 
> > > I am happy to discuss the possibility of me and or one of the other
> > > RISC-V soft (FPGA) core people stepping up to try to be more active,
> > > but so far we've just been very well serviced by the current NOMMU
> > > Linux setup.
> > 
> > It could probably be nice to have some feedback/Tested-by: from NOMMU
> > users for new releases then.
> 
> Having more upstream interaction from users is always appreciated, that's
> the best way to prove people are using the code.  If you guys have the time
> it'd be great to get this into some sort of CI, ideally running on some real
> platform.

As above, I'd also like to step up on the NOMMU stuff, at least test
nommu on milkv duo's small core. And can be seen from my git commit
histotry, I was active, and I belive I will still be active on riscv linux
kernel development.

> 
> > Thanks,
> > 
> > Clément
> > 
> > > 
> > > Charles
> > > 
> > > 
> > > On Mon, Feb 26, 2024 at 8:03 AM Conor Dooley <conor@kernel.org> wrote:
> > > > 
> > > > On Mon, Feb 26, 2024 at 04:25:24PM +0100, Clément Léger wrote:
> > > > > I guess I could also mark XIP as deprecated.
> > > > 
> > > > I'm not so sure, people recently added XIP support to QEMU (and sent
> > > > kernel fixes in December). XIP is also not nearly as much of a problem
> > > > to support, there's far less that it does differently, the main barrier
> > > > was the inability to test it which is no longer the case.
> > > > That said, XIP is gonna kill itself off I feel as it does not support
> > > > runtime patching and therefore is extremely limited on extensions, given
> > > > we use alternatives for all of that (although I suppose if someone has a
> > > > usecase they could make nasty macros worse and implement a compiletime
> > > > switch in the alternatives too).
> > > > 
> > > > Cheers,
> > > > Conor.
> > > > 
> > > > _______________________________________________
> > > > linux-riscv mailing list
> > > > linux-riscv@lists.infradead.org
> > > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

