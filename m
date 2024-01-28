Return-Path: <linux-kernel+bounces-41981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D7A83FA48
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 23:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9B251F226CE
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 22:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413513C493;
	Sun, 28 Jan 2024 22:15:44 +0000 (UTC)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042E23C46B;
	Sun, 28 Jan 2024 22:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706480143; cv=none; b=L1vdBk2IRMrW/ARQeFveLzCwMjYbn8JrhDwfVhcMG80f8vi4C+OFfpJO9+PY+T07YYNz9JuQ86FmDRxhIX1nuhMd0sGxcJK0lJbo4Su/mlW3zoigBOHoANVTeh6N3t/BkwaXcxRtqFouLGYwHIC2JzTnvMsdLo7EvvtYeGT4Vnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706480143; c=relaxed/simple;
	bh=vNYgDf0RboUzfGtK3sr9l72mJp9VU/gn//gCBuw27QM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AFBm4xDMhc7X6dBvYpJoj00q2RCq2zSJUKgJ7R7b1rsztNOIXCgP0uE0c2g9TlA3Dwk6qPgyMlM2X2McLUEvTaE9/m+3NXJA0oaW9qKjeXL09bhrbYB5IR/lCyXA243xXqfjhAbXIS+iS1H38tVimWHaTqa03Wi3jLEMKwvMmF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1rUDR3-0005sj-00; Sun, 28 Jan 2024 23:15:29 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id 8EF83C0489; Sun, 28 Jan 2024 22:54:08 +0100 (CET)
Date: Sun, 28 Jan 2024 22:54:08 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Xi Ruoyao <xry111@xry111.site>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-mips@vger.kernel.org,
	Ralf Baechle <ralf@linux-mips.org>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	YunQiang Su <wzssyqa@gmail.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] mips: Call lose_fpu(0) before initializing fcr31 in
 mips_set_personality_nan
Message-ID: <ZbbNAESbgzwJN5qc@alpha.franken.de>
References: <20240126210557.12442-1-xry111@xry111.site>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126210557.12442-1-xry111@xry111.site>

On Sat, Jan 27, 2024 at 05:05:57AM +0800, Xi Ruoyao wrote:
> If we still own the FPU after initializing fcr31, when we are preempted
> the dirty value in the FPU will be read out and stored into fcr31,
> clobbering our setting.  This can cause an improper floating-point
> environment after execve().  For example:
> 
>     zsh% cat measure.c
>     #include <fenv.h>
>     int main() { return fetestexcept(FE_INEXACT); }
>     zsh% cc measure.c -o measure -lm
>     zsh% echo $((1.0/3)) # raising FE_INEXACT
>     0.33333333333333331
>     zsh% while ./measure; do ; done
>     (stopped in seconds)
> 
> Call lose_fpu(0) before setting fcr31 to prevent this.
> 
> Closes: https://lore.kernel.org/linux-mips/7a6aa1bbdbbe2e63ae96ff163fab0349f58f1b9e.camel@xry111.site/
> Fixes: 9b26616c8d9d ("MIPS: Respect the ISA level in FCSR handling")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> ---
> 
> v1 -> v2: Fix stable list address in Cc line.
> 
>  arch/mips/kernel/elf.c | 6 ++++++
>  1 file changed, 6 insertions(+)

applied to mips-fixes.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

