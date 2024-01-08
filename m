Return-Path: <linux-kernel+bounces-19960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C18827781
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4188F284879
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0402146449;
	Mon,  8 Jan 2024 18:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="1UE7pWXu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0090825755
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 18:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VlUAd8oG1kTAZGT+1dUtSqGacdlM72KwoMUwqlEUI6I=; b=1UE7pWXutFGrTxLmE5ZCVPTO14
	M63GVNMrAPGye81IQWjB8pvSE5kTNKazD+g7m8vXx3iKyHnaeNctY5MyUObp0EBQJxnQB4TeT31rG
	qCVQhh9yAm/bvbgFFsvBWJlXdPQgp0f2B1T4cjncVpo8vof2iOW80B6rbL62VIb3Z5NIvrEBe/MsQ
	JJGknppsWIRU6FyE3KMZwHVOxaE7UMNLmGFMAMklZbBUPnfTvvp9ruRBxlrSWzy66vfDtCpKfbG2k
	Rp6nkLFkzclC0E5YijowGnOEvBOt3xOqzOLdLrS80YqByxro2O02GCumsTCRVomagWyJHTbGDFHB8
	LA6R+/1A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45438)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rMuOf-0003Jh-1A;
	Mon, 08 Jan 2024 18:30:49 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rMuOi-0003S7-22; Mon, 08 Jan 2024 18:30:52 +0000
Date: Mon, 8 Jan 2024 18:30:52 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] SHA-3 causes kmod 28 to segfault
Message-ID: <ZZw/XK12CnSgPtaB@shell.armlinux.org.uk>
References: <ZZwk8nFBTIMISLXp@shell.armlinux.org.uk>
 <CADWks+Y7JOsvzWc50syVwOB9LF2Lxc_YiLzLxCkhEv8sBxrNvw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADWks+Y7JOsvzWc50syVwOB9LF2Lxc_YiLzLxCkhEv8sBxrNvw@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jan 08, 2024 at 06:14:17PM +0000, Dimitri John Ledkov wrote:
> Hi,
> 
> On Mon, 8 Jan 2024 at 16:38, Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
> > Hi,
> >
> > When building 6.7 under Debian Oldstable with kmod 28, the installation
> > of modules fails during depmod with a SEGV.
> >
> 
> What is your kernel configuration, and I hope you make config choices
> compatible with your target host OS.

"target host OS" - that's a total misnomer. "host" is generally what
you're building under. "target" is generally what you're building _for_.
So I don't fully understand your comment. Maybe you meant "target _and_
host" ?

> > Running under gdb:
> >
> > Program received signal SIGSEGV, Segmentation fault.
> > __strlen_sse2 () at ../sysdeps/x86_64/multiarch/strlen-vec.S:133
> >
> > I have no further information as I can't remember how to get the debug
> > info for packages under Debian - and even if I could, it's probably a
> > bug in the kmod package that Debian will have absolutely no interest in
> > fixing (based on previous experience reporting bugs to Debian.)
> 
> For latest kernel and latest kernel features support in kmod, latest
> kmod is required. I.e. patched with
> https://github.com/kmod-project/kmod/commit/510c8b7f7455c6613dd1706e5e41ec7b09cf6703

Would be nice if there was some documentation. Also, as kconfig provides
a mechanism to detect e.g. the version of tooling used to build the
kernel, it would've been nice to detect whether depmod was sufficiently
recent to support SHA3 and make the module signing SHA3 options depend
on that.

Leaving this to a SEGV to indicate that something is wrong isn't user
friendly.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

