Return-Path: <linux-kernel+bounces-79476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E328622BF
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 06:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62EBD284E8B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 05:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC688175B6;
	Sat, 24 Feb 2024 05:30:12 +0000 (UTC)
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9984F1756B;
	Sat, 24 Feb 2024 05:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708752612; cv=none; b=V2AjoEtIQXMYIOh0n4fEmZQSnGnc/h6SF9huSZzwRVhiGyELVgXS74Pccp/TxZceVGPDPqnAOksuQj2IjVZVNcn/+YVHv8PamHBiUYMPnvq2ZhW0U/KYWktKrWSSjgpbSZZjqoGc6Af2W15+n7SXgXl/XG+jdawCh5QIL+5UnmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708752612; c=relaxed/simple;
	bh=N5rSrdJpnGbvCnN6AyHeeW8tZjA/gyKIaqsB0im1iXQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ETbG7FIPO7aBklg8PWdhSSbBnGPAmTJaUdqpkcjUV9Rg4gBbbjl7+gfWxT7tQpNF6nVWhKnPVpfAoQtQ02XkYmLP4DIS9psukPLPNLfsOY4wSEZ5upGNA9FuShtuH/EyJqwielT3OlVs7X3osJjGuXRSzz19OxgdJSl4vBkdtAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 7E2B092009C; Sat, 24 Feb 2024 06:29:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 7232792009B;
	Sat, 24 Feb 2024 05:29:43 +0000 (GMT)
Date: Sat, 24 Feb 2024 05:29:43 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Sam Ravnborg <sam@ravnborg.org>
cc: Miquel Raynal <miquel.raynal@bootlin.com>, sparclinux@vger.kernel.org, 
    linux-parport@lists.infradead.org, "David S. Miller" <davem@davemloft.net>, 
    Andreas Larsson <andreas@gaisler.com>, 
    Randy Dunlap <rdunlap@infradead.org>, Arnd Bergmann <arnd@arndb.de>, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] sparc32: Do not select GENERIC_ISA_DMA
In-Reply-To: <alpine.DEB.2.21.2402240235570.61493@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2402240458100.61493@angie.orcam.me.uk>
References: <20240223-sam-fix-sparc32-all-builds-v1-0-5c60fd5c9250@ravnborg.org> <20240223-sam-fix-sparc32-all-builds-v1-5-5c60fd5c9250@ravnborg.org> <alpine.DEB.2.21.2402240235570.61493@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 24 Feb 2024, Maciej W. Rozycki wrote:

> > sparc32 do not support generic isa dma, so do not select the symbol.
> > Without this fix, the following patch would break the build with a
> > missing prototype.
> 
>  Not according to my observations, kernel/dma.c is always built for 
> GENERIC_ISA_DMA configurations, so:
> 
> kernel/dma.c:70:5: error: no previous prototype for 'request_dma' [-Werror=missing-prototypes]
>    70 | int request_dma(unsigned int dmanr, const char * device_id)
>       |     ^~~~~~~~~~~
> kernel/dma.c:88:6: error: no previous prototype for 'free_dma' [-Werror=missing-prototypes]
>    88 | void free_dma(unsigned int dmanr)
>       |      ^~~~~~~~
> 
> are issued regardless (and FAOD with PARPORT_PC unset).
> 
>  I can't speak for SPARC support for ISA DMA, but it seems to me like the 
> second sentence would best be removed, as would the Fixes: tag (in favour 
> to:
> 
> Fixes: 0fcb70851fbf ("Makefile.extrawarn: turn on missing-prototypes globally")
> 
> I presume), and possibly the messages quoted above included instead.

 Actually I think ZONE_DMA should go too (it's linked to GENERIC_ISA_DMA, 
isn't it? -- cf. commit 5ac6da669e24 ("[PATCH] Set CONFIG_ZONE_DMA for 
arches with GENERIC_ISA_DMA")), and the whole thing use:

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

The GENERIC_ISA_DMA option itself was added to arch/sparc/config.in with 
2.5.31 as:

define_bool CONFIG_GENERIC_ISA_DMA y

despite of:

define_bool CONFIG_ISA n

for a reason not clear to me (BLK_DEV_FD? -- but on SPARC that uses some 
hacks to work in the absence of ISA DMA anyway).

 Am I missing anything here?

  Maciej

