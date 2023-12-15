Return-Path: <linux-kernel+bounces-1651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E252C815190
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DD162863DB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 21:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6779B47F57;
	Fri, 15 Dec 2023 21:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="RSHEuCkD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838FE4777D;
	Fri, 15 Dec 2023 21:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3sddRRvwk/fTKF7doym0HPnBmsg/UatU52NDddZvLeM=; b=RSHEuCkD54S7yVRnkkdRcJRhGB
	CCGEmrAERKHDC9A23+dPZdarY6qX1xEXD04Fd6FYVZ2haVIn4+aWT4QIFjld3w02jGzgMq+UXLQDG
	uB1rFook2rv0QRa21NRESCSJtqiU4skicVFf4JN/Z3SHmGp63xgpextFd2ddlJIoxsIcje2EDRlKi
	qLZL3dYhDnG1LkYaTy/ZPivcDvPAKMfuhgGQnW+nUZfmyimzpIEnv3dmIciv5FIvxBB7bkqL0KQgA
	RkNS86h1OL0o04t8ROx7kJP6ownxFmdArQXSB+7HnT/NsLrGq5KSFJ3v475DsRLOdCBama76TWRf1
	junaDkpw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rEFLU-00D57W-27;
	Fri, 15 Dec 2023 21:03:44 +0000
Date: Fri, 15 Dec 2023 21:03:44 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Greg KH <greg@kroah.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>, tanzirh@google.com,
	Kees Cook <keescook@chromium.org>,
	Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, Nick DeSaulniers <nnn@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev
Subject: Re: [PATCH] lib/string: shrink lib/string.i via IWYU
Message-ID: <20231215210344.GA3096493@ZenIV>
References: <20231205-libstringheader-v1-1-7f9c573053a7@gmail.com>
 <20231205213807.GE1674809@ZenIV>
 <CAKwvOd=2VASkaLvjU+7kkbvhu2CimYn5KUGJBDRePyUhtrNK2Q@mail.gmail.com>
 <2023120608-ivy-snowdrop-890d@gregkh>
 <CAKwvOdmFJ=ZGN8ZScS5oQpXnAL0wwtTDCeNNGpBKZXzQ4kRAVA@mail.gmail.com>
 <2023120657-henna-spongy-9ef6@gregkh>
 <20231206005542.GJ1674809@ZenIV>
 <20231206030047.GL1674809@ZenIV>
 <2023120650-faucet-palpable-f1a3@gregkh>
 <20231214210400.GR1674809@ZenIV>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214210400.GR1674809@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Dec 14, 2023 at 09:04:00PM +0000, Al Viro wrote:

> drivers/firmware/arm_scmi/shmem.c:13:#include <asm-generic/bug.h>

Should just use linux/bug.h and be done with that.

> drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c:10:#include <asm-generic/posix_types.h>

Completely pointless; not to mention that none of the types defined
there are used anywhere in that file, the previous line pulls their
private header, which explicitly pulls linux/types.h.

> lib/trace_readwrite.c:10:#include <asm-generic/io.h>

Yeccchhh...  This is just plain wrong.

What happens here is that hooks are added to writeb() et.al., to
allow ftrace to play with those.  By default these are empty
inlines; with CONFIG_TRACE_MMIO_ACCESS they are real function
calls, the functions living in lib/trace_readwrite.c

asm-generic/io.h is pulled by all asm/io.h instances, so that's
where the externs went.  That would've made sense, except that
asm-generic/io.h is used as a backstop for architectures that
had not bothered to define e.g. readl() of their own.  And *that*
is where the calls of those hooks had gone.  IOW, if architecture
has readl()/writeb()/whatnot of its own, it won't get those hooks
at all.

It smells like a conversion in progress, stalled after the first
(and only) architecture where that thing is selectable.  In effect,
it's arm64-specific.

> net/sunrpc/xprtrdma/verbs.c:58:#include <asm-generic/barrier.h>

Bogus, same as the include of asm/bitops.h immediately before that
line (the latter would've blown up if we hadn't already pulled
linux/bitops.h - which needs asm/barrier.h and pulls it, TYVM).

> rust/uapi/uapi_helper.h:9:#include <uapi/asm-generic/ioctl.h>

To the rust crowd, that...  It's wrong for e.g. powerpc -
uapi/asm/ioctl.h in there does pull asm-generic/ioctl.h, but
only after
#define _IOC_SIZEBITS   13
#define _IOC_DIRBITS    3

#define _IOC_NONE       1U
#define _IOC_READ       2U
#define _IOC_WRITE      4U

which means that trying to use asm-generic/ioctl.h directly
will yield the wrong numbers out of _IOC() et.al.


So...
in arch headers (..../asm/.../*.h and similar):
	OK, that's what asm-generic is for
in asm-generic headers themselves (..../asm-generic/.../*.h):
	OK
in linker scripts (*/*.lds{,.S}):
	asm-generic/vmlinux.lds.h is fine in those (and nowhere else)
in */*audit*.c:
	asm-generic/audit_*.h is OK there (ugly, but...)
in drivers,fs,init,io_uring,ipc,kernel,mm,net,sound,virt and probably rust:
	100% bollocks, not a single valid use
in lib/trace_readwrite.c:
	asm-generic/io.h is an exception; complicated story.

That leaves several instances in arch/, tools/ and include/linux, plus
some oddities in makefiles, scripts, etc.  And include/linux ones are
also not obviously correct - e.g. linux/bug.h pulls asm/bug.h, then
(under ifdef CONFIG_BUG) asm-generic/bug.h.  AFAICS on all architectures
we have asm/bug.h pulling asm-generic/bug.h (the ones that don't have
asm/bug.h of their own get it generated with just such an include in
it).  So do we need that include in linux/bug.h these days?

