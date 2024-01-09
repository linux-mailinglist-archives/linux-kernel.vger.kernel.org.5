Return-Path: <linux-kernel+bounces-20753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8031182849F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB97C1F257C4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 11:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCAA36B02;
	Tue,  9 Jan 2024 11:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="IOD3nAGD"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196B7360AE;
	Tue,  9 Jan 2024 11:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YgH27PJPgVjPvzpAXcrJ8iE0CTLGfA4M+6RNDqk9FxE=; b=IOD3nAGD3kWZCAgxZzkOarLMzA
	DZSscrMGoZz93KzLylaxCO3jWJJ+ydw60B0KlSR5jVi7qZkmHTwsDEM4nwNaoAKAMWNmAsN8n5Wy4
	SN5JAldFXK/iQ+urMekl7mPlBAS4G+cU+G53eRsbUlMiz6QlYY6hanssYZNpQPcHCnnaxGIQfmoHe
	fjwa58gtGR+lhzaLQtzvH4xnFnq3PWBTGIsamqjqracsw6QXEm9w/BOssMuAQcQUw1Nj/X7w3jclE
	JUCbhMnpoebso2SdXMWFfjABkTfrvtPTMSoO9OMSW210fCyj5Bf68aeQ57LhKzm3oGeOb9+gro+MV
	orNMh02Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37474)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rNA4X-00041C-1Y;
	Tue, 09 Jan 2024 11:15:05 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rNA4a-0004E8-51; Tue, 09 Jan 2024 11:15:08 +0000
Date: Tue, 9 Jan 2024 11:15:08 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Dimitri John Ledkov <dimitri.ledkov@canonical.com>,
	Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [BUG] SHA-3 causes kmod 28 to segfault
Message-ID: <ZZ0qvM9uVOh5wQ59@shell.armlinux.org.uk>
References: <ZZwk8nFBTIMISLXp@shell.armlinux.org.uk>
 <CADWks+Y7JOsvzWc50syVwOB9LF2Lxc_YiLzLxCkhEv8sBxrNvw@mail.gmail.com>
 <ZZw/XK12CnSgPtaB@shell.armlinux.org.uk>
 <CADWks+YdQ_1QkbhT5tzVA0c_5z0Yn39-nyfNMH201=Anu7DCJQ@mail.gmail.com>
 <ZZxyrFkTmrGneP0H@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZxyrFkTmrGneP0H@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jan 08, 2024 at 10:09:49PM +0000, Russell King (Oracle) wrote:
> On Mon, Jan 08, 2024 at 06:46:10PM +0000, Dimitri John Ledkov wrote:
> > On Mon, 8 Jan 2024 at 18:30, Russell King (Oracle)
> > <linux@armlinux.org.uk> wrote:
> > >
> > > On Mon, Jan 08, 2024 at 06:14:17PM +0000, Dimitri John Ledkov wrote:
> > > > Hi,
> > > >
> > > > On Mon, 8 Jan 2024 at 16:38, Russell King (Oracle)
> > > > <linux@armlinux.org.uk> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > When building 6.7 under Debian Oldstable with kmod 28, the installation
> > > > > of modules fails during depmod with a SEGV.
> > > > >
> > > >
> > > > What is your kernel configuration, and I hope you make config choices
> > > > compatible with your target host OS.
> > >
> > > "target host OS" - that's a total misnomer. "host" is generally what
> > > you're building under. "target" is generally what you're building _for_.
> > > So I don't fully understand your comment. Maybe you meant "target _and_
> > > host" ?
> > 
> > the kernel configuration you use, should target the operating system
> > you are planning to use the given kernel on.
> 
> Thank you for stating the damn obvious. I've been developing Linux
> kernels for 30 years, I think I know this.
> 
> > using bleeding edge kernel features, with an obsolete userspace often
> > can have compatibility issues.
> 
> You're still not being clear. I wonder whether you understand the
> terms "target" and "host".
> 
> > > > > Running under gdb:
> > > > >
> > > > > Program received signal SIGSEGV, Segmentation fault.
> > > > > __strlen_sse2 () at ../sysdeps/x86_64/multiarch/strlen-vec.S:133
> > > > >
> > > > > I have no further information as I can't remember how to get the debug
> > > > > info for packages under Debian - and even if I could, it's probably a
> > > > > bug in the kmod package that Debian will have absolutely no interest in
> > > > > fixing (based on previous experience reporting bugs to Debian.)
> > > >
> > > > For latest kernel and latest kernel features support in kmod, latest
> > > > kmod is required. I.e. patched with
> > > > https://github.com/kmod-project/kmod/commit/510c8b7f7455c6613dd1706e5e41ec7b09cf6703
> > >
> > > Would be nice if there was some documentation. Also, as kconfig provides
> > > a mechanism to detect e.g. the version of tooling used to build the
> > > kernel, it would've been nice to detect whether depmod was sufficiently
> > > recent to support SHA3 and make the module signing SHA3 options depend
> > > on that.
> > >
> > > Leaving this to a SEGV to indicate that something is wrong isn't user
> > > friendly.
> > >
> > 
> > There is no ability to detect runtime kmod at build time, given the
> > two are usually often not the same.
> 
> Again, you CLEARLY don't understand the problem. I am *NOT* reporting
> a problem on the target. I am reporting a problem on the *build*
> *host*.
> 
> > Can you please provide your config?
> > Can you please explain how you chose it?
> 
> No, because it's totally irrelevant to the problem I'm reporting.
> 
> What I'm reporting to you is that _IF_ you build a kernel with the
> SHA3 modsigning options on a HOST that has kmod 28, then depmod
> SEGVs when _INSTALLING_ the modules to a directory on the _HOST_.
> 
> This has *nothing* to do with the capabilities of the _TARGET_.
> Whether the configuration matches the capabilities of the _TARGET_
> is *totally* irrelevant at _this_ stage. In fact, with the _HOST_
> depmod segfaulting, one can't complete the installation process
> to even _think_ about transferring it to the _TARGET_.

Here's a patch that checks the version of depmod on the _build_
_host_, preventing the use of the SHA3 module signing if it isn't
recent enough, which causes

	make modules_install INSTALL_MOD_PATH=/foo/bar/bzz

run on the _build_ _host_ to fail with a segfault.

diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
index 0ea1b2970a23..d2ba454026a9 100644
--- a/kernel/module/Kconfig
+++ b/kernel/module/Kconfig
@@ -223,6 +223,11 @@ config MODULE_SIG_ALL
 	  Sign all modules during make modules_install. Without this option,
 	  modules must be signed manually, using the scripts/sign-file tool.
 
+config DEPMOD_VERSION
+	int
+	default	$(depmod-version)
+	default 0
+
 comment "Do not forget to sign required modules with scripts/sign-file"
 	depends on MODULE_SIG_FORCE && !MODULE_SIG_ALL
 
@@ -250,14 +255,17 @@ config MODULE_SIG_SHA512
 
 config MODULE_SIG_SHA3_256
 	bool "Sign modules with SHA3-256"
+	depends on DEPMOD_VERSION > 28
 	select CRYPTO_SHA3
 
 config MODULE_SIG_SHA3_384
 	bool "Sign modules with SHA3-384"
+	depends on DEPMOD_VERSION > 28
 	select CRYPTO_SHA3
 
 config MODULE_SIG_SHA3_512
 	bool "Sign modules with SHA3-512"
+	depends on DEPMOD_VERSION > 28
 	select CRYPTO_SHA3
 
 endchoice
diff --git a/scripts/Kconfig.include b/scripts/Kconfig.include
index 5a84b6443875..052f581c86da 100644
--- a/scripts/Kconfig.include
+++ b/scripts/Kconfig.include
@@ -63,3 +63,6 @@ ld-version := $(shell,set -- $(ld-info) && echo $2)
 cc-option-bit = $(if-success,$(CC) -Werror $(1) -E -x c /dev/null -o /dev/null,$(1))
 m32-flag := $(cc-option-bit,-m32)
 m64-flag := $(cc-option-bit,-m64)
+
+# depmod version
+depmod-version := $(shell,$(srctree)/scripts/depmod-version.sh)
diff --git a/scripts/depmod-version.sh b/scripts/depmod-version.sh
new file mode 100755
index 000000000000..32a8a6f6b737
--- /dev/null
+++ b/scripts/depmod-version.sh
@@ -0,0 +1,11 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+: ${DEPMOD:=depmod}
+
+# legacy behavior: "depmod" in /sbin, no /sbin in PATH
+PATH="$PATH:/sbin"
+
+LC_ALL=C "$DEPMOD" --version | sed -n '1s/kmod version //p'

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

