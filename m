Return-Path: <linux-kernel+bounces-103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D902813C43
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CA5DB21B3D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890B5282E5;
	Thu, 14 Dec 2023 21:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="vHqwe+0C"
X-Original-To: linux-kernel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10897494;
	Thu, 14 Dec 2023 21:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7FrhxwWPxjd1nrVnDhmOIzmALWzUB7ji13bBSfV+Dm4=; b=vHqwe+0C8DVTzGY92KpnnNrZ61
	9AjwcGxoG3Z+B6DxOIX8VQEGOmuosBI6oPZmY2zpXNULYfiyLkl8djZ+AEFgYzpt49vAy0GAniFJ4
	5v9WbrwDHC97+uhc5/D/1PUPO2LYNKGAKJLMZgDVPQ754lKyl15E4c1FP5wSBXJZudT/yt5i6qp3n
	jv3eydn+WQiJ1sz6nQKrPf0OjctP6s90DUcXuzC6eD9aKqYJNiVlsX/6snjTx5Umg7anTdjOFQBYR
	GBSvFcFbH9466jNlUaKxsFV6HabQYMdWsSOiXmhYhq/qmoMnr8kVAmrjAPgPtA8VackjJOvkA/lzl
	vf07MJPA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rDssC-00CS2n-1P;
	Thu, 14 Dec 2023 21:04:00 +0000
Date: Thu, 14 Dec 2023 21:04:00 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Greg KH <greg@kroah.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>, tanzirh@google.com,
	Kees Cook <keescook@chromium.org>,
	Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, Nick DeSaulniers <nnn@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev
Subject: Re: [PATCH] lib/string: shrink lib/string.i via IWYU
Message-ID: <20231214210400.GR1674809@ZenIV>
References: <20231205-libstringheader-v1-1-7f9c573053a7@gmail.com>
 <20231205213807.GE1674809@ZenIV>
 <CAKwvOd=2VASkaLvjU+7kkbvhu2CimYn5KUGJBDRePyUhtrNK2Q@mail.gmail.com>
 <2023120608-ivy-snowdrop-890d@gregkh>
 <CAKwvOdmFJ=ZGN8ZScS5oQpXnAL0wwtTDCeNNGpBKZXzQ4kRAVA@mail.gmail.com>
 <2023120657-henna-spongy-9ef6@gregkh>
 <20231206005542.GJ1674809@ZenIV>
 <20231206030047.GL1674809@ZenIV>
 <2023120650-faucet-palpable-f1a3@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023120650-faucet-palpable-f1a3@gregkh>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Dec 06, 2023 at 12:09:17PM +0900, Greg KH wrote:
> > slap #include "unaligned.h" into their traps.c and unaligned.c
> > (callers and definitions resp.) and strip those from asm/unaligned.h?
> > At that point we can remove arch/{arc,parisc}/asm/unaligned.h - everything
> > will pick include/asm-generic/unaligned.h.
> > 
> > Then the next cycle we ask Linus to run the following:
> > for i in `git grep -l -w asm/unaligned.h`; do
> > 	sed -i -e "s/asm\/unaligned.h/linux\/unaligned.h/" $i
> > done
> > git mv include/asm-generic/unaligned.h include/linux/unaligned.h
> > sed -i -e "/unaligned.h/d" include/asm-generic/Kbuild
> > right before releasing -rc1 and asm/unaligned.h is gone...
> 
> Please do, it's really annoying and would be great to fix up.

	FWIW, turns out that we have several places in drivers/* that pull
asm-generic/unaligned.h.  IMO that's completely wrong - not just in this
case (it's a matter of trivially adjusting the script), but I think that
as a matter of policy we should *NOT* have includes of asm-generic/*.h
anywhere in drivers/ fs/ io_uring/ kernel/ mm/ net/ sound/

	Current situation (outside of arch, include, scripts and tools,
with asm-generic/unaligned.h cases already taken out):

drivers/android/binderfs.c:32:#include <uapi/asm-generic/errno-base.h>
drivers/clk/microchip/clk-mpfs-ccc.c:7:#include "asm-generic/errno-base.h"
drivers/firmware/arm_scmi/shmem.c:13:#include <asm-generic/bug.h>
drivers/irqchip/irq-ti-sci-inta.c:24:#include <asm-generic/msi.h>
drivers/mtd/nand/raw/ingenic/ingenic_ecc.h:9:#include <uapi/asm-generic/errno-base.h>
drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c:10:#include <asm-generic/posix_types.h>
io_uring/uring_cmd.c:10:#include <uapi/asm-generic/ioctls.h>
lib/trace_readwrite.c:10:#include <asm-generic/io.h>
mm/damon/vaddr.c:10:#include <asm-generic/mman-common.h>
net/sunrpc/xprtrdma/verbs.c:58:#include <asm-generic/barrier.h>
rust/uapi/uapi_helper.h:9:#include <uapi/asm-generic/ioctl.h>

That's it.  asm-generic/errno-base.h cases - just use linux/errno.h and
be done with it.  Anyone who goes "I've got ENOENT and ENOMEM in my driver,
but those two are covered by errno-base.h and I can be clever and use
just that" is wrong.

asm-generic/mman-common.h - and linux/mman.h would not serve why, exactly?
uapi/linux/linux/mman.h, if one really feels like it...

asm-generic/ioctls.h in io_uring - definitely wrong; SIOCINQ is what
it's brought for, but that's in sockios.h.  It expands to FIONREAD, which
*is* in ioctls.h, but...

arch/alpha/include/uapi/asm/ioctls.h:11:#define FIONREAD        _IOR('f', 127, int)
arch/mips/include/uapi/asm/ioctls.h:64:#define FIONREAD 0x467f
arch/parisc/include/uapi/asm/ioctls.h:35:#define FIONREAD       0x541B
arch/powerpc/include/uapi/asm/ioctls.h:11:#define FIONREAD      _IOR('f', 127, int)
arch/sh/include/uapi/asm/ioctls.h:11:#define FIONREAD   _IOR('f', 127, int)
arch/sparc/include/uapi/asm/ioctls.h:101:#define FIONREAD       _IOR('f', 127, int)
arch/xtensa/include/uapi/asm/ioctls.h:23:#define FIONREAD       _IOR('f', 127, int)
include/uapi/asm-generic/ioctls.h:46:#define FIONREAD   0x541B

See the problem?  On mips the value is not 0x541B - it's 0x467F; on
alpha, powerpc and sparc it's 0x4004667F, on sh and xtensa - 0x8004667F
(different expansions of _IOR).

The only thing that has any business including asm-generic/ioctls.h is
arch/*/include/uapi/asm/ioctls.h - if it feels like doing so.  Anywhere
else it ought to be asm/ioctls.h.

asm-generic/msi.h - looks bogus; there's an include of linux/msi.h several lines
above, and that pulls asm/msi.h.  Which makes it either a no-op or a build bug
(the latter - if that driver can be built on x86 with CONFIG_GENERIC_MSI_IRQ
defined;
typedef struct irq_alloc_info msi_alloc_info_t;
in asm/msi.h vs.
typedef struct msi_alloc_info {
        struct msi_desc                 *desc;
        irq_hw_number_t                 hwirq;
        unsigned long                   flags;
        union {
                unsigned long           ul;
                void                    *ptr;
        } scratchpad[NUM_MSI_ALLOC_SCRATCHPAD_REGS];
} msi_alloc_info_t;
in asm-generic/msi.h).

Hell knows about the rest, but they all look very dubious...

