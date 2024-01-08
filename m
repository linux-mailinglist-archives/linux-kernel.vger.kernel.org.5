Return-Path: <linux-kernel+bounces-20142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC029827A81
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 23:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAC571C22FAC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 22:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D59156464;
	Mon,  8 Jan 2024 22:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="pkDD63IW"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF0D56455
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 22:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1qHwK95bEOKG6reOtvx1ZSfRgeuypZvj/GZ9ynd1hSY=; b=pkDD63IWWWbxDsYfuLY34sTUqN
	RDH6dtYMM2vysEQmgLjoQ651/FTMkFPRuwKm1S1j9rRM0W+h5+vSo1qd2gbCKAfLb/raGXb6yAGT2
	bLxhVD7pGIyzEqu6tEzR/o/VjtvzMJWvHHKMAbUQYSgKyMkeoWf7nQ/UgqCBonikb+5hxdEpttat4
	Cw0UfOmkjCXTDxO22/kCx23ePTxI4MwsJNZ+po4oVTxY9XiXgi33HMOQqy8SvlDVS+1j21yPnf/po
	rfkqiCGLPY7FLgvjcsKWcAdiZtKRuDFJuFrLy148lnai8LksI79bE19wDIa0MSpaBEGCbJkINb3W+
	upKPd80Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60026)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rMxoY-0003Sp-1E;
	Mon, 08 Jan 2024 22:09:46 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rMxob-0003bs-1A; Mon, 08 Jan 2024 22:09:49 +0000
Date: Mon, 8 Jan 2024 22:09:48 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] SHA-3 causes kmod 28 to segfault
Message-ID: <ZZxyrFkTmrGneP0H@shell.armlinux.org.uk>
References: <ZZwk8nFBTIMISLXp@shell.armlinux.org.uk>
 <CADWks+Y7JOsvzWc50syVwOB9LF2Lxc_YiLzLxCkhEv8sBxrNvw@mail.gmail.com>
 <ZZw/XK12CnSgPtaB@shell.armlinux.org.uk>
 <CADWks+YdQ_1QkbhT5tzVA0c_5z0Yn39-nyfNMH201=Anu7DCJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADWks+YdQ_1QkbhT5tzVA0c_5z0Yn39-nyfNMH201=Anu7DCJQ@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jan 08, 2024 at 06:46:10PM +0000, Dimitri John Ledkov wrote:
> On Mon, 8 Jan 2024 at 18:30, Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
> > On Mon, Jan 08, 2024 at 06:14:17PM +0000, Dimitri John Ledkov wrote:
> > > Hi,
> > >
> > > On Mon, 8 Jan 2024 at 16:38, Russell King (Oracle)
> > > <linux@armlinux.org.uk> wrote:
> > > >
> > > > Hi,
> > > >
> > > > When building 6.7 under Debian Oldstable with kmod 28, the installation
> > > > of modules fails during depmod with a SEGV.
> > > >
> > >
> > > What is your kernel configuration, and I hope you make config choices
> > > compatible with your target host OS.
> >
> > "target host OS" - that's a total misnomer. "host" is generally what
> > you're building under. "target" is generally what you're building _for_.
> > So I don't fully understand your comment. Maybe you meant "target _and_
> > host" ?
> 
> the kernel configuration you use, should target the operating system
> you are planning to use the given kernel on.

Thank you for stating the damn obvious. I've been developing Linux
kernels for 30 years, I think I know this.

> using bleeding edge kernel features, with an obsolete userspace often
> can have compatibility issues.

You're still not being clear. I wonder whether you understand the
terms "target" and "host".

> > > > Running under gdb:
> > > >
> > > > Program received signal SIGSEGV, Segmentation fault.
> > > > __strlen_sse2 () at ../sysdeps/x86_64/multiarch/strlen-vec.S:133
> > > >
> > > > I have no further information as I can't remember how to get the debug
> > > > info for packages under Debian - and even if I could, it's probably a
> > > > bug in the kmod package that Debian will have absolutely no interest in
> > > > fixing (based on previous experience reporting bugs to Debian.)
> > >
> > > For latest kernel and latest kernel features support in kmod, latest
> > > kmod is required. I.e. patched with
> > > https://github.com/kmod-project/kmod/commit/510c8b7f7455c6613dd1706e5e41ec7b09cf6703
> >
> > Would be nice if there was some documentation. Also, as kconfig provides
> > a mechanism to detect e.g. the version of tooling used to build the
> > kernel, it would've been nice to detect whether depmod was sufficiently
> > recent to support SHA3 and make the module signing SHA3 options depend
> > on that.
> >
> > Leaving this to a SEGV to indicate that something is wrong isn't user
> > friendly.
> >
> 
> There is no ability to detect runtime kmod at build time, given the
> two are usually often not the same.

Again, you CLEARLY don't understand the problem. I am *NOT* reporting
a problem on the target. I am reporting a problem on the *build*
*host*.

> Can you please provide your config?
> Can you please explain how you chose it?

No, because it's totally irrelevant to the problem I'm reporting.

What I'm reporting to you is that _IF_ you build a kernel with the
SHA3 modsigning options on a HOST that has kmod 28, then depmod
SEGVs when _INSTALLING_ the modules to a directory on the _HOST_.

This has *nothing* to do with the capabilities of the _TARGET_.
Whether the configuration matches the capabilities of the _TARGET_
is *totally* irrelevant at _this_ stage. In fact, with the _HOST_
depmod segfaulting, one can't complete the installation process
to even _think_ about transferring it to the _TARGET_.

So please, I'm not stupid - but right now I think you are, because
you clearly don't understand the difference between TARGET and HOST.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

