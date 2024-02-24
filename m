Return-Path: <linux-kernel+bounces-79452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33AC086226A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 04:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF3412847C1
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 03:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF3B125B6;
	Sat, 24 Feb 2024 03:02:25 +0000 (UTC)
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09827DF56;
	Sat, 24 Feb 2024 03:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708743744; cv=none; b=fcz9Nx5pcZ5o5pm7vqQDJ1m8oGejM7fMkgkGsCjPW9TgauBUgBK1ryB7acWwtCElsf/Ce/hZnn/GPVTJ8wcoJThmHPrVawv1Otd8hns4LHamwla0A+LQepfIOAoBHX23hahejMd7EXb/1seIYQgx5XcwAeiCwR6XBOypfqY+r4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708743744; c=relaxed/simple;
	bh=42qckR7sEklLzyLtRQ2dN5IEexo3aslIAHZ9vNape+s=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=M+agRVYs/hSWmlj6K520Mej0SNLnLuOO1udU4LuSKg2m6I+AbGkQI3TbQEEcESkPr8nBkS6AqdJPRRH2YDyaWtRG9AheGbCTlIyPt1HuSG8uKf/uK5dvDWhR08GF0mhhJcMnzU1Iz2gGWqIHfSMtzbdM0cDBa/CFr0LCvUbsT5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 5618992009C; Sat, 24 Feb 2024 04:02:20 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 4721892009B;
	Sat, 24 Feb 2024 03:02:20 +0000 (GMT)
Date: Sat, 24 Feb 2024 03:02:20 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Sam Ravnborg <sam@ravnborg.org>
cc: Miquel Raynal <miquel.raynal@bootlin.com>, sparclinux@vger.kernel.org, 
    linux-parport@lists.infradead.org, "David S. Miller" <davem@davemloft.net>, 
    Andreas Larsson <andreas@gaisler.com>, 
    Randy Dunlap <rdunlap@infradead.org>, Arnd Bergmann <arnd@arndb.de>, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 6/6] sparc32: Fix parport build with sparc32
In-Reply-To: <20240223-sam-fix-sparc32-all-builds-v1-6-5c60fd5c9250@ravnborg.org>
Message-ID: <alpine.DEB.2.21.2402240252130.61493@angie.orcam.me.uk>
References: <20240223-sam-fix-sparc32-all-builds-v1-0-5c60fd5c9250@ravnborg.org> <20240223-sam-fix-sparc32-all-builds-v1-6-5c60fd5c9250@ravnborg.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 23 Feb 2024, Sam Ravnborg via B4 Relay wrote:

> include/asm/parport.h is sparc64 specific.
> Rename it to parport_64.h and use the generic version for sparc32.
> 
> This fixed all{mod,yes}config build errors like:
> 
> parport_pc.c:(.text):undefined-reference-to-ebus_dma_enable
> parport_pc.c:(.text):undefined-reference-to-ebus_dma_irq_enable
> parport_pc.c:(.text):undefined-reference-to-ebus_dma_register
> 
> The errors occur as the sparc32 build references sparc64 symbols.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Andreas Larsson <andreas@gaisler.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Maciej W. Rozycki <macro@orcam.me.uk>
> Closes: https://lore.kernel.org/r/20230406160548.25721-1-rdunlap@infradead.org/
> Fixes: 66bcd06099bb ("parport_pc: Also enable driver for PCI systems")
> Cc: stable@vger.kernel.org # v5.18+
> ---

 LGTM, it relies on SPARC never to enable ISA.

Reviewed-by: Maciej W. Rozycki <macro@orcam.me.uk>
Tested-by: Maciej W. Rozycki <macro@orcam.me.uk> # build-tested

 The other changes in this patch series address issues that do not appear 
with my ad-hoc SPARC test configuration, so I have no immediate way to 
verify them.

  Maciej

