Return-Path: <linux-kernel+bounces-149371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B965F8A9032
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 02:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EABB71C218E0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 00:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635165660;
	Thu, 18 Apr 2024 00:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="DYLgMPLH"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D50E10FA;
	Thu, 18 Apr 2024 00:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713401677; cv=none; b=GYpOGkibDxn79A0QtkuiLBp3fEtX661OB2FXgIJ7i2Ste0wA1zq98u84ycUkn3OwbSc/KthkIo29yKNU/GQjSGKSHc5whm3RUiuLScJQNV11gzyOtlo+OEfbH2jls/FZyIuilDuJKtwwcnUgYvCBYaj8SZTfB90T5aL5Roik8BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713401677; c=relaxed/simple;
	bh=wAfm/febHBO7WS9l7V3gS7eMe755bKnF0FqkdZH3vP4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KBEH401BF7zWeG/l/wtOY0ya9avyu5X3ofduSx9R2w8Q5Ad3ORCOJOtYNR4MPNfgflN0hSelfYPv7FLPSq8JQL0wZcihX8xf+W252FABf8ylZrbWxI2ww032eCzj3nIUBV7cff5eXrli3AiqigfkjXEG/m+yjZHoXaDY6I+4IfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=DYLgMPLH; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1713401672;
	bh=aDG3p51AHQpbTq3NLy30yBtk1qMbUt6rlsMzU/0vs+c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=DYLgMPLH7SaX85J65aHjr0TWwpsRnrweVRL98MhbWZ4q21Lei0zwZPOWNu7TrLJMN
	 s4NbXruH9JqHTfkJzzzFgRcK1lKN+PZhkpIRJajRKan9W6hjirqxzCe3nLZMSV+YHH
	 Kka/I2aV70qA10VAlOQYT8JmsOrJX9ICFnXiJ9a1CrzJKKbwaZBVc2b73zPr8kDAXK
	 ZX3m6zOxVzMXijOKC//fdze2SFVKFuMe8tYzb/0MnypqftsXd82i2X/7U9b4YBq6ji
	 crBIT26y2on2KH1wNgXIXH0rC28O9n8G6ztMcIj2p/Vzy8RsnknXWX0+iLogW+YQet
	 r91oA7HDUjB4A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VKfS66FgYz4wjF;
	Thu, 18 Apr 2024 10:54:30 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sean Christopherson <seanjc@google.com>, Jonathan Corbet
 <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Stephen
 Rothwell <sfr@canb.auug.org.au>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH 1/2] cpu: Re-enable CPU mitigations by default for !X86
 architectures
In-Reply-To: <20240417001507.2264512-2-seanjc@google.com>
References: <20240417001507.2264512-1-seanjc@google.com>
 <20240417001507.2264512-2-seanjc@google.com>
Date: Thu, 18 Apr 2024 10:54:28 +1000
Message-ID: <87jzkvbid7.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sean Christopherson <seanjc@google.com> writes:
> Add a generic Kconfig, CPU_MITIGATIONS, to control whether or not CPU
> mitigations are enabled by default, and force it on for all architectures
> except x86.  A recent commit to turn mitigations off by default if
> SPECULATION_MITIGATIONS=n kinda sorta missed that "cpu_mitigations" is
> completely generic, where as SPECULATION_MITIGATIONS is x86 specific.
>
> Alternatively, SPECULATION_MITIGATIONS could simply be defined in common
> code, but that creates weirdness for x86 because SPECULATION_MITIGATIONS
> ends up being defined twice, and the default behavior would likely depend
> on the arbitrary include order (if the two definitions diverged).
>
> Ideally, CPU_MITIGATIONS would be unconditionally on by default for all
> architectures, and manually turned off, but there is no way to unselect a
> Kconfig.
>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Closes: https://lkml.kernel.org/r/20240413115324.53303a68%40canb.auug.org.au
> Fixes: f337a6a21e2f ("x86/cpu: Actually turn off mitigations by default for SPECULATION_MITIGATIONS=n")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---

Thanks for fixing it up.

Tested-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

