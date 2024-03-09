Return-Path: <linux-kernel+bounces-97825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 392A6876FFF
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 10:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ADEC1C20BF9
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 09:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F23374D3;
	Sat,  9 Mar 2024 09:04:51 +0000 (UTC)
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAE22E630;
	Sat,  9 Mar 2024 09:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709975091; cv=none; b=ecyZJwA68hUFhpGqNLQYw6tLbUwTHnNEk046CId3g3tKNFXroPi2FxsbKBPL1epXcqMPKY0iJMCIDv0ohyWhhs3p49IqCmivPXDuYN00pHplZBRAoxInVuHyHmi1fzHZRTsJCYGCEiUG9oOgY6NhEXnSlkY98uL0s9dwaQ2zC64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709975091; c=relaxed/simple;
	bh=QHey0Qmc2AFVW7jRgJdnlcC+Sgu+TkZYKVaCYPyfooM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jF/Q4knGwQDTyaC38HjJu/okGGaCOvhgU/54CzGbiM22ge85urd1PVyX+7nDB6LgPmq/EHS9jGp/EjzKooYxCAG+k+XkiOW5xVnQ5TlrBQ9WLQYhaU02pM9x7bzt5wj+XAHvuOiEmDiK7NmlIQbluUJ+YhoDDB0yV88ccMNXy+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 6FD1292009C; Sat,  9 Mar 2024 10:04:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 6C46D92009B;
	Sat,  9 Mar 2024 09:04:40 +0000 (GMT)
Date: Sat, 9 Mar 2024 09:04:40 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Andreas Larsson <andreas@gaisler.com>
cc: sam@ravnborg.org, sparclinux@vger.kernel.org, 
    Randy Dunlap <rdunlap@infradead.org>, 
    Miquel Raynal <miquel.raynal@bootlin.com>, 
    linux-parport@lists.infradead.org, "David S. Miller" <davem@davemloft.net>, 
    Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/7] sparc32: Do not select GENERIC_ISA_DMA
In-Reply-To: <d7134c1f-7c6a-4715-9ffb-e8ef0143d662@gaisler.com>
Message-ID: <alpine.DEB.2.21.2403090903560.16468@angie.orcam.me.uk>
References: <20240224-sam-fix-sparc32-all-builds-v2-0-1f186603c5c4@ravnborg.org> <20240224-sam-fix-sparc32-all-builds-v2-5-1f186603c5c4@ravnborg.org> <d7134c1f-7c6a-4715-9ffb-e8ef0143d662@gaisler.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 8 Mar 2024, Andreas Larsson wrote:

> > From: Sam Ravnborg <sam@ravnborg.org>
> > 
> > sparc32 do not support generic isa dma, so do not select the symbol.
> > 
> > This fixes the following warnings:
> > dma.c:70:5: error: no previous prototype for 'request_dma' [-Werror=missing-prototypes]
> > dma.c:88:6: error: no previous prototype for 'free_dma' [-Werror=missing-prototypes]
> > 
> > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> > Fixes: 0fcb70851fbf ("Makefile.extrawarn: turn on missing-prototypes globally")
> > Acked-by: Randy Dunlap <rdunlap@infradead.org>
> > Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
> > Cc: Andreas Larsson <andreas@gaisler.com>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Maciej W. Rozycki <macro@orcam.me.uk>
> > ---
> >  arch/sparc/Kconfig | 4 ----
> >  1 file changed, 4 deletions(-)
> 
> Reviewed-by: Andreas Larsson <andreas@gaisler.com>

Reviewed-by: Maciej W. Rozycki <macro@orcam.me.uk>
Tested-by: Maciej W. Rozycki <macro@orcam.me.uk> # build-tested

  Maciej

