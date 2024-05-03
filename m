Return-Path: <linux-kernel+bounces-167938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CEF8BB15D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 19:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DB651C2180D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06568157A54;
	Fri,  3 May 2024 17:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="FdPRuqnj"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB401586F7;
	Fri,  3 May 2024 17:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714755636; cv=none; b=NgSdD2Opig1djCoV5J71DYzEWZmY2TJRVT7gogSCGZJcRXt0Fr6QS1CgrIDIIzKnMnRBzjG7P24c6quKjeQchXQUmYATrTcII/Ev2id2QnhOaum40rn3Hge9O9hgGhlr3XmOKF89HSu4d1aV+lo0OhPLBhcrLrq5dVaJ2qSX+Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714755636; c=relaxed/simple;
	bh=q3e8MBRgHEJbP4RKyKpwIoCE7rfMSfjCfdYLxPwS8U4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+mSK2PQ4O2UVGHR28d1jI7oanUhkWvkNQ94S2K9b4gesYmsYPrJ8Wr+mBex7Ryi6enmD+5xiL5HjzJY1t9Qy+NWuoaBZqdN0vk/lo3g/k3aBUwkf2NpLttpYDd4o/lINoQvHWNkDBVy8yi10qCXCepUoXcOdHHJApdgcY3Wrs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=FdPRuqnj; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JclG7D7+mKd9NVSxwbT/HEwCcDGC+RBtnv7LTTuYLz4=; b=FdPRuqnj9j9JU6ObgJP916TkzR
	fxx+bLQkmo527u0p3EAcESLSMnxYbXhvYu/hFHj4JgJwdvK5YZthLIGDQMzdMcX2+zEsB+q+KTNf/
	xlagHHDmU9q9SPNVqPParU2Citu4nq7LPqfEEkr5bc6PBBmNEQCReRQcI7pmzyOJJePeN9wUv3oqP
	0jlCEpkIoD/OP+BRdUXNQ6XRQCh//VHoRDKSuxLSNEL0LBzNGnDEuglBA/dYbHRW2FvsQPaOHH5mU
	2uYV4U+uzvTWMuV2ZnXQ/pZ9trX+8VFdC5Aa7R6fdCAK/Xsdvwqf4fjEAW6kbKipn/iXSIbEgefxo
	76I3cJwQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s2wGq-00Ar9A-2h;
	Fri, 03 May 2024 17:00:28 +0000
Date: Fri, 3 May 2024 18:00:28 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-alpha@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>, Marc Zyngier <maz@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/14] alpha: remove DECpc AXP150 (Jensen) support
Message-ID: <20240503170028.GW2118490@ZenIV>
References: <20240503081125.67990-1-arnd@kernel.org>
 <20240503081125.67990-11-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503081125.67990-11-arnd@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, May 03, 2024 at 10:11:21AM +0200, Arnd Bergmann wrote:
> diff --git a/arch/alpha/kernel/traps.c b/arch/alpha/kernel/traps.c
> index 7fc72aeb7398..a9a8e9ab0f52 100644
> --- a/arch/alpha/kernel/traps.c
> +++ b/arch/alpha/kernel/traps.c
> @@ -30,39 +30,6 @@
>  
>  #include "proto.h"
>  
> -/* Work-around for some SRMs which mishandle opDEC faults.  */
> -
> -static int opDEC_fix;
> -
> -static void
> -opDEC_check(void)
> -{
> -	__asm__ __volatile__ (
> -	/* Load the address of... */
> -	"	br	$16, 1f\n"
> -	/* A stub instruction fault handler.  Just add 4 to the
> -	   pc and continue.  */
> -	"	ldq	$16, 8($sp)\n"
> -	"	addq	$16, 4, $16\n"
> -	"	stq	$16, 8($sp)\n"
> -	"	call_pal %[rti]\n"
> -	/* Install the instruction fault handler.  */
> -	"1:	lda	$17, 3\n"
> -	"	call_pal %[wrent]\n"
> -	/* With that in place, the fault from the round-to-minf fp
> -	   insn will arrive either at the "lda 4" insn (bad) or one
> -	   past that (good).  This places the correct fixup in %0.  */
> -	"	lda %[fix], 0\n"
> -	"	cvttq/svm $f31,$f31\n"
> -	"	lda %[fix], 4"
> -	: [fix] "=r" (opDEC_fix)
> -	: [rti] "n" (PAL_rti), [wrent] "n" (PAL_wrent)
> -	: "$0", "$1", "$16", "$17", "$22", "$23", "$24", "$25");
> -
> -	if (opDEC_fix)
> -		printk("opDEC fixup enabled.\n");
> -}
> -

That should be moved into commit that removes the caller...

