Return-Path: <linux-kernel+bounces-154695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADA68ADFD5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C55D1C226E7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D46381AD;
	Tue, 23 Apr 2024 08:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ZiFYelrY"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA64D320E
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 08:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713861241; cv=none; b=ZjI8p4UxaDdEGSJalZEoIxEvPNXreSee1qsW1s6/khbybrTcoz/mMBA/COhvpjcths5DQ0ltwhw25tJAT05nES1r2E5tySgLPUCkyBfVYs/O3Ne6yIUZM5UpJx2JCOQRvb/Yyrs6jBNc/GLT4EHIzr3GZf0wLNqcLHarVFMbMWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713861241; c=relaxed/simple;
	bh=GbEOcBiBoSjAahAIDalXGsP5xushNOL01/QV0u5nyAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fi4RAZPir4qf1Gmv4TTlvTs8GS6zuHPb11c3ZRf8meZ2FUbmHKV42y5xcr9RmUNjf3rgqBezppQWDh/2NybvDoIEUINCdeNXPh2/QEYvOexsuOPD0pmP8wceY+f4CZk0ghIm1rQOp5fa0CSaixJqnhojsi09nCdxfIzFeN8h2NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ZiFYelrY; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0A62B40E0249;
	Tue, 23 Apr 2024 08:33:51 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id d_koH9OyGXIh; Tue, 23 Apr 2024 08:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1713861226; bh=NFHsFX0uVgJUjkPOc/vFyW6tpvFhp24NlUDlmhptGtI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZiFYelrYnwih1ZDSbpND7ggtn2LzlXFUQxagba/xXahDpv751L2VEFFlY2QdtGA2K
	 aVr7LpPjT09tTtYYQf7cqFwboyrlA97a2gYWr0CCO9dfPgGeRU7DK4KZ1XFkBI+ei9
	 hXruUqOPua6+OVwrR/kMeXIMKTikWBmKB1+kdVVC3/w3pWJewZsmWZXMxGYjhLy9eL
	 bGjoG8PIMZFINGtXu8RP5pR8+wUMDnvf/xllorclJc7YAoQ5q4+8RE9g6yGzCgWRul
	 /dK8YhcutcqcGoeaXqN6eDHNmLBbvM/6CQy/8U8VTQ3gU3DDnozDo8YBh8Ni2yeZCC
	 ofHA46PaXW3kBojoEZZ/lPyg67e/vrnStj7/5EJnhAK6KOQOOrmxR1UZlPyKBBJ3m1
	 L59OrZp7BcL7dB02/Q0t6Nv5OZa0iWcbvFbVZ3PRZdRhBsTYzcZ8QKJ4Cr/+ZIFJxb
	 Aa9F6r/ImgC1SnfeGDDTRRZlGODfqmvN0qY8RN+0UKOEit6wcZoiGjDhR0w/Y3Jz/v
	 hyAdWzja/NURn6ZcJIant85XLLTWKY+72v8tm6um7hgLz+hea2Y84iIAvMQGSehr/V
	 BtEQVR5Qc8WyI02ePZUSmV80ueakICjsA6jBgK+lkh9xsXYRv4Mm7QAQpt4UOzTLPc
	 jq4/PGt0419YNI2JnAMZQpRo=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A68E740E0177;
	Tue, 23 Apr 2024 08:33:37 +0000 (UTC)
Date: Tue, 23 Apr 2024 10:33:32 +0200
From: Borislav Petkov <bp@alien8.de>
To: Robert Richter <rrichter@amd.com>
Cc: Dave Hansen <dave.hansen@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-kernel@vger.kernel.org, jgross@suse.com, tglx@linutronix.de,
	x86@kernel.org, Kim Phillips <kim.phillips@amd.com>,
	Robert Richter <rric@kernel.org>
Subject: Re: [PATCH 2/4] perf/x86/ibs: Use CPUID region helper
Message-ID: <20240423083332.GAZidyXG5HFM0CrG3H@fat_crate.local>
References: <20240416151242.GGZh6VaiO2gC4ej2BT@fat_crate.local>
 <f142e9c4-4829-4ace-8757-485246ad3572@intel.com>
 <20240416174850.GEZh66AmnDjrLxoXaw@fat_crate.local>
 <ZiEMnWaHkn99_oyW@rric.localdomain>
 <20240422172055.GAZiacdxkQU0XAbybW@fat_crate.local>
 <ZibEFZ6DoxDeBxxp@rric.localdomain>
 <20240422204146.GCZibLiqZhbY1J4qFJ@fat_crate.local>
 <ZibW8D9-CTd8G-_v@rric.localdomain>
 <20240422214503.GDZibaX4G2HWQgZuvH@fat_crate.local>
 <ZidnBlWbCaMg-UDi@rric.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZidnBlWbCaMg-UDi@rric.localdomain>

On Tue, Apr 23, 2024 at 09:45:10AM +0200, Robert Richter wrote:
> I prefer 1) as this applies IBS_CAPS_DEFAULT only if the leaf is
> missing which was the original intention of IBS_CAPS_DEFAULT but can
> live with 2) as it is implemented now.

As implemented now and be done with it. We already wasted too much time
with some hypothetical and there's bigger fish to fry so let's leave it
like it is and move on.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

