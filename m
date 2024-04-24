Return-Path: <linux-kernel+bounces-156320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF59A8B0120
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70E312851D4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 05:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8CC156675;
	Wed, 24 Apr 2024 05:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+odHiyU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B5413CFAD
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 05:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713937089; cv=none; b=tBkRH5oxx9pjuEuykkZGx1gQiXfz/LXja0BFsijyU9+jj33mDB2eakE5ZkQKsntMfemNkQrH0Nkov1YVdzk81/Eq8Eg/eLNLmB0gUNqKqnSyjSbh/8Lrd9W+IbAiEiCQaG3nMcu27XTDrYJFSAF9bYkMAQjRwT6wvYGnPaYrW/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713937089; c=relaxed/simple;
	bh=IlbcZ8F41Wfapy7sUdM5dRgxbyIGgYyViKkqCfKnQ8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SwajPj2XovPBg3Jrquz1SzvMAUwfNZDxrWwwNnwdLL+FzbTMl2k5UaTELwRwmdDdIFYPJRBd6tiqpH0Zmw6L/tylpdLg2I9zazQenk4F268U2phsZMLTctJT1JZpoKzd4FuoX967rQy/gvPzwK4XGnXeN3vnymZgGUq8/3uz4i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+odHiyU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E87AC113CE;
	Wed, 24 Apr 2024 05:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713937088;
	bh=IlbcZ8F41Wfapy7sUdM5dRgxbyIGgYyViKkqCfKnQ8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a+odHiyUXaEWCWQH/Qqpcyqm3gvbgcKeCmHl6RsMaZU5thY13uJfaJPTsyN4RDEGX
	 bxm7B+YSchqAlG2C9dgG4cURcQLDH5u/xqi1CeSgzatv6D1PkS3JAR8t9u8E+Iu6KQ
	 tc7OdcT1L0FjbNr7kFUT+avPod5wfluTbYtErESPkQfW1hIBzu98e3qZqC2KeYKgyF
	 0KKvgpDLbhSrcIFfmjjq2b6LSLhwv+zUQcn0oNqnTIcvunQzZhDKLQYDHO4nQT1SEM
	 BBkuTCTD5vJFAfdgaIHyO/dJ0K+fx1G07wjtIMrIH9n9LY72SDPrISkYTxAQzPTMrh
	 njhHGAKrJJ4SQ==
Date: Tue, 23 Apr 2024 22:38:06 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Will Deacon <will@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 1/2] cpu: Re-enable CPU mitigations by default for
 !X86 architectures
Message-ID: <20240424053806.5u5klchl3pvqu2zw@treble>
References: <20240420000556.2645001-1-seanjc@google.com>
 <20240420000556.2645001-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240420000556.2645001-2-seanjc@google.com>

On Fri, Apr 19, 2024 at 05:05:54PM -0700, Sean Christopherson wrote:
> Rename x86's to CPU_MITIGATIONS, define it in generic code, and force it
> on for all architectures exception x86.  A recent commit to turn
> mitigations off by default if SPECULATION_MITIGATIONS=n kinda sorta missed
> that "cpu_mitigations" is completely generic, whereas
> SPECULATION_MITIGATIONS is x86 specific.
> 
> Rename x86's SPECULATIVE_MITIGATIONS instead of keeping both and have it
> select CPU_MITIGATIONS, as having two configs for the same thing is
> unnecessary and confusing.  This will also allow x86 to use the knob to
> manage mitigations that aren't strictly related to speculative execution.
> 
> Use another Kconfig to communicate to common code that CPU_MITIGATIONS is
> already defined instead of having x86's menu depend on the common
> CPU_MITIGATIONS.  This allows keeping a single point of contact for all of
> x86's mitigations, and it's not clear that other architectures *want* to
> allow disabling mitigations at compile-time.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Closes: https://lkml.kernel.org/r/20240413115324.53303a68%40canb.auug.org.au
> Fixes: f337a6a21e2f ("x86/cpu: Actually turn off mitigations by default for SPECULATION_MITIGATIONS=n")
> Cc: Josh Poimboeuf <jpoimboe@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>

-- 
Josh

