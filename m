Return-Path: <linux-kernel+bounces-151616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1FE8AB12F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BE4D1F24462
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C6112F582;
	Fri, 19 Apr 2024 15:01:01 +0000 (UTC)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EE512EBFB;
	Fri, 19 Apr 2024 15:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713538860; cv=none; b=lUfh5H7/816MiwwwWNK6TI3wtUYeN0q8OrAIcBBSHCJYZ4ofMazP4KN57uQKrYXeGA9I/4lAKaDkBIgOv1IdTfcKiWBVK/UYzsOYQTZkmX6/EPAgzTDkZKqYrlQ8fVPnHUXbIb9fbb0SNxj8xgU6jRJN6hSKMudY2WoMLRHkhRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713538860; c=relaxed/simple;
	bh=VcV7xfoTJ9227YQD/z0yt9fkY2IHDLlUoTcjM/rtbmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rWTI6C/qpF12tGIAXulgIkybc4t2Z9u0NEFOWd1lh8kn/VCUKgBr+c2f0FKebzLotHMhnySA7Q3bP5ttWvp2e4ngV5oclRrVMW+V7Mmmh+4/sfL85J+f5mGK5zwOYnGOvT2jktugIWa80Rfxc0K1DJ4D7S7o33yWgRIecpOBCco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0E50E40E0177;
	Fri, 19 Apr 2024 15:00:56 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 1MKbSardtkwA; Fri, 19 Apr 2024 15:00:53 +0000 (UTC)
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BDE1540E00B2;
	Fri, 19 Apr 2024 15:00:39 +0000 (UTC)
Date: Fri, 19 Apr 2024 17:00:33 +0200
From: Borislav Petkov <bp@alien8.de>
To: Sean Christopherson <seanjc@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Peter Zijlstra <peterz@infradead.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/2] cpu: Ignore "mitigations" kernel parameter if
 CPU_MITIGATIONS=n
Message-ID: <20240419150033.GBZiKHEUVzwz1LUDS5@fat_crate.local>
References: <20240417001507.2264512-1-seanjc@google.com>
 <20240417001507.2264512-3-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240417001507.2264512-3-seanjc@google.com>

On Tue, Apr 16, 2024 at 05:15:07PM -0700, Sean Christopherson wrote:
> Explicitly disallow enabling mitigations at runtime for kernels that were
> built with CONFIG_CPU_MITIGATIONS=n, which currently is possible only on
> x86 (via x86's SPECULATION_MITIGATIONS menuconfig).

Hm, so the umbrella term is CPU_MITIGATIONS, the x86-one is
SPECULATION_MITIGATIONS.

I wanna streamline our namespacing and say, the arch agnostic term
should be CPU_MITIGATIONS and the x86 one should be then
X86_CPU_MITIGATIONS, the Arm one would be ARM_CPU_MITIGATIONS and so on.

This way we can stick all kinds of special mitigations code - not only
speculative execution ones - under those config items and have it all
straight from the get-go.

And I think we should do it now, before it all propagates down the tree
and becomes a lot harder to rename.

Thoughts?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

