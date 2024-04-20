Return-Path: <linux-kernel+bounces-152277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C37C58ABBC5
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 15:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45EA7B20E5F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 13:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C7C2030B;
	Sat, 20 Apr 2024 13:34:11 +0000 (UTC)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426C620326
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 13:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713620051; cv=none; b=kJZTe6YkehKnazRd7eje3mvCK8EWMoMhVL5QWPrHiT7/wAsD4XfduB34ak8x809fvYpWLeQK02tItLnVkYRvL01wTD3v1ESzhItDyvTWY5wVP1N1k9/IO5Xd8LjntjpcOTG6VcN6n2LZSUm7fe0vwmapT+w7Yn3TtVUfnvmEWwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713620051; c=relaxed/simple;
	bh=34aS6cpH3s1r3ufWgrdGf6jYNdujQFecNb+c7EnVrhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jh5jQOt5O8T+no6tJgvQ6qSfNy+6Yz+RDk6dEdExIqJ2XmgtX3pmse4Pt6hWUgWDa5ZcrCVYawoSliaZEHQ4n8zHCbB8TlPGs3pIOAgGVhDbZRRpq+YOHx/OnM5lcqFpVc4ZurvMDjqsfKEQH9d/n3eDoBFRi5AaqV0C/SNvBlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0694E40E02A7;
	Sat, 20 Apr 2024 13:34:07 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 5idNBZHkaehm; Sat, 20 Apr 2024 13:34:03 +0000 (UTC)
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5934B40E00B2;
	Sat, 20 Apr 2024 13:33:49 +0000 (UTC)
Date: Sat, 20 Apr 2024 15:33:44 +0200
From: Borislav Petkov <bp@alien8.de>
To: Sean Christopherson <seanjc@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>, Will Deacon <will@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 0/2] cpu: Fix default mitigation behavior
Message-ID: <20240420133344.GBZiPEOP5c8Ffe47BZ@fat_crate.local>
References: <20240420000556.2645001-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240420000556.2645001-1-seanjc@google.com>

On Fri, Apr 19, 2024 at 05:05:53PM -0700, Sean Christopherson wrote:
> Linus, I Cc'd you on this as patch 1 fixes a goof that causes mitigations
> to be completely disabled on all !x86 architectures, and it'd be nice to
> fix that in rc5.  There was a decent bit of discussion on how exactly to
> juggle the Kconfigs, and so I don't expect anyone to include this in a pull
> request for rc5.
> 
> The discussion didn't fully resolve, i.e. this hasn't gotten a thumbs up
> from the affected parties, but I think/hope my approach here is minimal
> enough for other architectures (just restores previous behavior), and
> shouldn't result in a huge amount of churn if we decide to go in a
> different direction.
> 
> TL;DR: please grab patch 1 directly if you think it's worth squeezing into
> rc5, and isn't completely crazy.

Agreed, we should have some sort of fix for -rc5.

And I don't see anything wrong with it and the aspect that other arches
should get their previous behavior for now makes sense. And we can
always bikeshed this at large until it is settled.

So patch 1:

Acked-by: Borislav Petkov (AMD) <bp@alien8.de>

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

