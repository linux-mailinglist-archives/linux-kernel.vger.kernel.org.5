Return-Path: <linux-kernel+bounces-18864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51100826421
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 14:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA5F01F21828
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 13:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48BC134AD;
	Sun,  7 Jan 2024 13:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nmaaoaaf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2847B134A0;
	Sun,  7 Jan 2024 13:03:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14C9AC433C7;
	Sun,  7 Jan 2024 13:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704632621;
	bh=JQUOkY7pGDbzmZACx5v6FcY10tfDTJxeBz0eqhJQOFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nmaaoaafir2w9oojohBMa85RUSZbLgmAllYnvNNYv0+Np2+VC9N/d3ZttJgPVWDAE
	 dFzbnpajB+dddDJlZCexo5udEEO9NPlipCYB4V3r43urL7OhUPIxSJQHsNMjmAfjpI
	 lWN0emjSK+u0hVC4BKO28l7MJm+VjfODV5R0osjPIO7z0FDDlJhMRh79mQlKPAhpP9
	 uoOkk8we9HA+CTZqXVEvMjqxbUkeUkbRYeLrCRnkeoU5yLr5OwSX/mCuVLe5vw+UbN
	 20ge22SMMNKGhNMWFoINKRsTSoSMySj5TwrovqSKgIILqM2pat4eMQk2jovNxps12q
	 cwczWkwcdXkxw==
Date: Sun, 7 Jan 2024 14:03:32 +0100
From: Luc Van Oostenryck <lucvoo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	kernel test robot <lkp@intel.com>, Arnd Bergmann <arnd@arndb.de>, linux-sparse@vger.kernel.org, 
	Chris Morgan <macromorgan@hotmail.com>, oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: include/asm-generic/unaligned.h:119:16: sparse: sparse: cast
 truncates bits from constant value (aa01a0 becomes a0)
Message-ID: <7yxju53lhprhihayiue3dp4xnmzpugygl47tt4w56pyscsf6tx@2w3eytgeav7u>
References: <202401070147.gqwVulOn-lkp@intel.com>
 <ZZnzd3s2L-ZwGOlz@google.com>
 <CAHk-=wjLaBe3Y_H5WArWdQ6d36+UOQ7NSbga1w+esGYJZaVfVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjLaBe3Y_H5WArWdQ6d36+UOQ7NSbga1w+esGYJZaVfVg@mail.gmail.com>

On Sat, Jan 06, 2024 at 09:54:05PM -0800, Linus Torvalds wrote:
> On Sat, 6 Jan 2024 at 16:42, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> >
> > This is not really a kernel/driver bug, just sparse being over-eager
> > with truncation detection. I wonder if we could make sparse skip this
> > check on forced casts like this:
> 
> No, please don't.
> 
> Just face the fact that using integer casts to mask bits off is a bad idea.
> 
> ...
> 
> The *natural* thing to do is to simply make the masking itself be
> explicit - not the cast. IOW, just write it as
> 
>         *p++ = (val >> 16) & 0xff;
>         *p++ = (val >> 8) & 0xff;
>         *p++ = val & 0xff;
> 
> ...
> 
> And while the code is a bit more to read, I think it is actually to
> some degree more obvious to a human too what is going on.


I fully agree.

It's kinda sad is that there is more than 800 occurrences of this
"cast truncates bits from constant value" warning and almost all of
them are of the kind:
	"a 32bit constant must be written in 2 steps via 16bit IO registers"

In these cases, no bits are lost, they're just written in the other write,
and real problems, when present, are drown/lost into these 800 harmless ones.
It's in fact the 4th most common warning in the kernel, the top 10 being:
   2858 incorrect type in assignment (different base types)
   2715 cast to restricted type
    923 incorrect type in argument (different address spaces)
    818 cast truncates bits from constant value
    739 restricted type degrades to integer
    549 context imbalance - unexpected unlock
    500 symbol was not declared. Should it be static?
    407 cast removes address space '__iomem' of expression
    344 incompatible types in comparison expression (different address spaces)
    323 context imbalance - different lock contexts for basic block

-- Luc

