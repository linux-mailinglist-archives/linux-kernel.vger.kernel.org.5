Return-Path: <linux-kernel+bounces-161909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A44668B5329
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FF9B2826FB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F811773A;
	Mon, 29 Apr 2024 08:30:49 +0000 (UTC)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956911118C;
	Mon, 29 Apr 2024 08:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714379449; cv=none; b=chrVNM/Df/UVNHFw3OFsxzR7DkF8Zl2LPlIaXqAAIVw7B3r7GgKI/tTyIPTpTu8vsbXWnsAQEViEtDWNAr9fwMSa+Z0Js4OJvR4FcFPoL1Du1T9J9MFyP62xfE9Qw+AgHbpRxWq7sRygdIXxAaJiKt6uEut9FYVdvxppxMiKKZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714379449; c=relaxed/simple;
	bh=rFRah/ABA7Mukh2/SAB2mQmjk0vnRyJchYkgDLHNTMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eWn1YncPgatv3KggH0HztysRbOcLS+573w2/31sXJZlJXjzbNMnzGpWHPK7IfXkiHW8CSY/J46v0YTR+t82B+03GQozkVY6te+K3j/Z9zH3nXN6+bc3tC3wJ8Pu5f77nCnmkDlcQtBX+OFINsRyz5Tt81JzDNcTAHk157Qpv3PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1s1MPK-0000Fy-00; Mon, 29 Apr 2024 10:30:42 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
	id 24F9BC0135; Mon, 29 Apr 2024 10:30:31 +0200 (CEST)
Date: Mon, 29 Apr 2024 10:30:31 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Siarhei Volkau <lis8215@gmail.com>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
	Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] MIPS: Take in account load hazards for HI/LO restoring
Message-ID: <Zi9apwTq6mC47qv3@alpha.franken.de>
References: <20231012162027.3411684-1-lis8215@gmail.com>
 <Zi9X8cqTpWUR1Z6l@alpha.franken.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zi9X8cqTpWUR1Z6l@alpha.franken.de>

On Mon, Apr 29, 2024 at 10:18:57AM +0200, Thomas Bogendoerfer wrote:
> On Thu, Oct 12, 2023 at 07:20:27PM +0300, Siarhei Volkau wrote:
> > MIPS CPUs usually have 1 to 4 cycles load hazards, thus doing load
> > and right after move to HI/LO will usually stall the pipeline for
> > significant amount of time. Let's take it into account and separate
> > loads and mthi/lo in instruction sequence.
> > 
> > The patch uses t6 and t7 registers as temporaries in addition to t8.
> > 
> > The patch tries to deal with SmartMIPS, but I know little about and
> > haven't tested it.
> > 
> > Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
> > ---
> >  arch/mips/include/asm/stackframe.h | 22 ++++++++++++----------
> >  1 file changed, 12 insertions(+), 10 deletions(-)
> > 
> > diff --git a/arch/mips/include/asm/stackframe.h b/arch/mips/include/asm/stackframe.h
> > index a8705aef47e1..3821d91b00fd 100644
> > --- a/arch/mips/include/asm/stackframe.h
> > +++ b/arch/mips/include/asm/stackframe.h
> > @@ -308,17 +308,11 @@
> >  		jal	octeon_mult_restore
> >  #endif
> >  #ifdef CONFIG_CPU_HAS_SMARTMIPS
> > -		LONG_L	$24, PT_ACX(sp)
> > -		mtlhx	$24
> > -		LONG_L	$24, PT_HI(sp)
> > -		mtlhx	$24
> > -		LONG_L	$24, PT_LO(sp)
> > -		mtlhx	$24
> > -#elif !defined(CONFIG_CPU_MIPSR6)
> > +		LONG_L	$14, PT_ACX(sp)
> > +#endif
> > +#if defined(CONFIG_CPU_HAS_SMARTMIPS) || !defined(CONFIG_CPU_MIPSR6)
> 
> isn't that just #ifndef CONFIG_CPU_MIPSR6 ? 

and if yes, I prefer to have the same structure as for the move to
registers later like

#ifdef CONFIG_CPU_HAS_SMARTMIPS
. do the SMARTMIPS things
elif !defined(CONFIG_CPU_MIPSR6)
. do normal hi/lo
#endif

that way it's more clear whats happening depending on selected
options.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

