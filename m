Return-Path: <linux-kernel+bounces-61857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF50851779
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89FBCB242CF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79683C46C;
	Mon, 12 Feb 2024 15:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="cT3sgJxJ"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8EE3C46E
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 15:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707750085; cv=none; b=EYDoVsh75nPYZlgTFSq2E8Kf1AHPnfPh2VGPeclGVh2LD9054GPT25LVVF4+4qfz7YamFnFevknrfKMweCdgb79yDdiqVTOoHFHkVdr6UuEL3ZFcVHoUqfPCjiGLn5SDGGzCJISEm6fFbsdSzH8EAIW2gAvUuy97vgiaZaa2Oww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707750085; c=relaxed/simple;
	bh=5ET/+ywHrfQ2igMiio3kOR+E5f7alalaj3ZSVBSVj3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qwXKGdjTsmPFNMiMiLDQvZiSl7NMxRKt3P5IobZSML0Yi5rXEq/OfSWJ9SwA3R7+rE+eJsG5j+QrUcgmysXjE67V+p6uloDcwDcTZyA36ahztQpyqEZ4EK8TkQfbZi4BCAfEopRHoID9N3VAr8YIoYFXB0yYDHRl4yQkcyzYGVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=cT3sgJxJ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8837440E0256;
	Mon, 12 Feb 2024 15:01:19 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 2MssPnb7UQOE; Mon, 12 Feb 2024 15:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707750076; bh=niftb5ulUuRKgvqltBydGR3ZDoIKCm7EqemWD0my8+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cT3sgJxJEUQL3sUMBYE2zL6pDBagFdBpHHyPhrXcB2azluuIoE2FOP7ISTZi4UHqo
	 9GsBD5Fk0JKoq+htXXpfjOvYU+SZtk+/0APaRzC5KnFBL/PzSRw3bMepPHm56HwBXR
	 0T82qzNiteh7lsxLqUhBoumBTdXS4CjfPUlab872RiKTaZoA7EEk6YtHWvG3hR1+R4
	 yfYFwH0suSs4WKlB9mX3ZlosbXNT6iGk4ztgeOZ74fF992M6C/WSl0W5Mgl+vbIjN+
	 ApFVHmxnbVjmCyInCBFoSGng4Wf3lLdY0UP58SmPgVR78X9j8fTAwUUt39qoHO2hoG
	 4lYXoHxg9MEYZkk+VB2GHegPCnissXNJJVYKV4qmsqLRqkACOijixKrYOnfgMXWdCg
	 oZe+xPtP3+z8rqNsDDLpvCJkH0klIDdo0Wn48BV8Sxq8CHcZAHdwn27l9t2WSXnxV5
	 qGRY6ZiPES0aulRO0tl5vZ0QvW296+pjJsn67A2eLA649y2uUIu9+CsmPSKar03CzU
	 w//ZmAJ5LAfAoDGmRdJSiQs07LVts1aYYiwfEaacKZ03jjOCmlokwtp4af8j+I6mja
	 Hth/AHjuNCl4x4iMbQW64mos+24Bu69Q3iJtqp+qBynw3zlSuIb+kNQHGh8vswGlI9
	 sQM7Z6Xxsa8//hXcb/VGZBOY=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 56F4840E01A9;
	Mon, 12 Feb 2024 15:00:58 +0000 (UTC)
Date: Mon, 12 Feb 2024 16:00:53 +0100
From: Borislav Petkov <bp@alien8.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Arjan van de Ven <arjan@linux.intel.com>,
	Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
	Dimitri Sivanich <dimitri.sivanich@hpe.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Zhang Rui <rui.zhang@intel.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Feng Tang <feng.tang@intel.com>,
	Andy Shevchenko <andy@infradead.org>,
	Michael Kelley <mhklinux@outlook.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [patch v5 06/19] x86/cpu: Provide a sane leaf 0xb/0x1f parser
Message-ID: <20240212150053.GEZcoypaBQPB1IcZGY@fat_crate.local>
References: <20240117115752.863482697@linutronix.de>
 <20240117115908.674834306@linutronix.de>
 <20240130193102.GEZblOdor_bzoVhT0f@fat_crate.local>
 <87il2tlqba.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87il2tlqba.ffs@tglx>

On Mon, Feb 12, 2024 at 03:17:45PM +0100, Thomas Gleixner wrote:
> Especially x2apic_shift is horrible and the comments of EBX are visually
> impaired while with the C++ comments x2apic_shift looks natural and the
> EBX comments are just open to the right and therefore simpler.

I'd say, put comments *above* the member versus on the side. We don't
like side comments, if you remember. :-)

And, for example, the commenting in arch/x86/include/asm/fpu/types.h is
not half as bad and works real nice for struct definitions, I'd say.

But if you want to make that into a rule to have C++, side comments for
struct members I guess I'll get accustomed to it eventually.

> If it's caught in early testing, this should be fixed, no?

Hope dies last. :)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

