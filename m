Return-Path: <linux-kernel+bounces-79449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CB6862262
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 03:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 823B81F22D04
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 02:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C935E125A7;
	Sat, 24 Feb 2024 02:55:06 +0000 (UTC)
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1064910A3F;
	Sat, 24 Feb 2024 02:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708743306; cv=none; b=SplXA3/5L4uO02sTudRF4NI3xZWkApr+Ddzccwmil2hjFRwbwD5MEsDq67+LAOxisqmlBKZuiJS2B9YSL4qON09sc7o9XMkjABNpzpMFqn/hP+don4wqhJd0rmbGATY7za/315XrRpPmyLnnxFexO0ntxCBwqIr6w+ZhW8C9PBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708743306; c=relaxed/simple;
	bh=o9PwcRVz3DFLQYky+sxag4JuWd3kakiCVBE3JNsT4Jk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cezLXuGVSujLyg0vYDrqRAgw4Im/LNhoxFTosadGN2o1oDsZa9SRwrs/TBRviOqH/cQLCO0SXoZDyoamg3Kz0D/kHd9RmxPA1XpeNErxu6lcsGxivIqOx8fHC3kHzMrRBAQPGBe+gaQd2PJIQGALE3I1JlKQh3YTZ/48olJaoW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 3456592009D; Sat, 24 Feb 2024 03:55:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 24EB192009B;
	Sat, 24 Feb 2024 02:55:01 +0000 (GMT)
Date: Sat, 24 Feb 2024 02:55:01 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Sam Ravnborg <sam@ravnborg.org>
cc: Miquel Raynal <miquel.raynal@bootlin.com>, sparclinux@vger.kernel.org, 
    linux-parport@lists.infradead.org, "David S. Miller" <davem@davemloft.net>, 
    Andreas Larsson <andreas@gaisler.com>, 
    Randy Dunlap <rdunlap@infradead.org>, Arnd Bergmann <arnd@arndb.de>, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] sparc32: Do not select GENERIC_ISA_DMA
In-Reply-To: <20240223-sam-fix-sparc32-all-builds-v1-5-5c60fd5c9250@ravnborg.org>
Message-ID: <alpine.DEB.2.21.2402240235570.61493@angie.orcam.me.uk>
References: <20240223-sam-fix-sparc32-all-builds-v1-0-5c60fd5c9250@ravnborg.org> <20240223-sam-fix-sparc32-all-builds-v1-5-5c60fd5c9250@ravnborg.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 23 Feb 2024, Sam Ravnborg via B4 Relay wrote:

> sparc32 do not support generic isa dma, so do not select the symbol.
> Without this fix, the following patch would break the build with a
> missing prototype.

 Not according to my observations, kernel/dma.c is always built for 
GENERIC_ISA_DMA configurations, so:

kernel/dma.c:70:5: error: no previous prototype for 'request_dma' [-Werror=missing-prototypes]
   70 | int request_dma(unsigned int dmanr, const char * device_id)
      |     ^~~~~~~~~~~
kernel/dma.c:88:6: error: no previous prototype for 'free_dma' [-Werror=missing-prototypes]
   88 | void free_dma(unsigned int dmanr)
      |      ^~~~~~~~

are issued regardless (and FAOD with PARPORT_PC unset).

 I can't speak for SPARC support for ISA DMA, but it seems to me like the 
second sentence would best be removed, as would the Fixes: tag (in favour 
to:

Fixes: 0fcb70851fbf ("Makefile.extrawarn: turn on missing-prototypes globally")

I presume), and possibly the messages quoted above included instead.

  Maciej

