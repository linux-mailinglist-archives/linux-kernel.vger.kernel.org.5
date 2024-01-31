Return-Path: <linux-kernel+bounces-47063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFC68448C3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48FC1287BD5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E143FE42;
	Wed, 31 Jan 2024 20:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="bC7gUmsB"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB3B3FE24
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 20:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706732642; cv=none; b=Xzu3x/RWvbW3+MKM/GRJAt+2reatvbav7UQvRdCJeGyu3c6EctNZCqHoxarlE0XnhMm3qWrMiKlhmkYol6Dcy89r8CwTvqBx9LcxC0Sc7l3uSyvyvUASX2Yqp8a3C2EXNtznXhYJo7JCVcKLhK/0aBWJZlTMBeHACdSksqzL5fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706732642; c=relaxed/simple;
	bh=c8BgyeaOxRJoVpmpdlvaVs8pxX9gKWMdLr4cmkJxJVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ENd2jk3iiwnyjSGiv6t7PZUEjVRPbEs+l+5LPuyzVsKaVtVTvT29dY6d2YMVayJo6rzbph2UlIEB9KgLsn3DltOVR3no5bxhN5UMaU4LhfDjkOc8P3rMb/mEKVMBBSoDO+L4D99nHl0kuC6zRl1PC+4WM1/2ch3sve1uFCl3JMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=bC7gUmsB; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0354A40E00C5;
	Wed, 31 Jan 2024 20:23:57 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id OjcC5NNgSzNe; Wed, 31 Jan 2024 20:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706732634; bh=7fi3dyXMMd6/0aeF3EFLTQzMzTDCXg1mf7AUEGHYLUE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bC7gUmsBOplYUTS3insO6U3/vcK1ccGuZATodDgxyMyA6ZU4zmV4UqmrDyuRTUm7k
	 kWhG/F7i+f54+y8ZHQhqwEGK7SG6oxftSS9UYztvq8bpOQ4xH1NlCdPDTzojzSIJ7M
	 jyfbHf8Xza0UfKqwfj2ptoNy/ooIrlvrnl+EgvQvCyozspj1IqvB1DnaX2T+H7KhAe
	 2464GX5F8g9nyEOnPqKAMqAwNNQIhKjQdAPc8N9NaY++vE8reJlZutAuQHINimzgBv
	 fLChyZE4giHr8szkhwTpY+PbrDUaEioL++DDgZPFXX4OL/vbvAkVBSM5ARUZ8aV+MS
	 fJ61a45RitAtYWzi8rePeam7QuO/qjB4R73VLrEmEbL1b528uWdO06WsG8r5NWSsHi
	 cLBwlC1RrtICYwrwSsHaXtPPqDrcajE1IStK/bzL7amXUAzNgOlCHJFb2sw4eGOA6k
	 x1Vebmlb3V0FyXtu/yWxQEizB5yxO5BwKhjte8xgk+tELgFntkuPwn6fwy489Rmpgy
	 B6/n3iHfa7pSq7AYfaZQaZlB0xNmf5tGR+om1kFVfcPGXD+2Yd4/RzmRsPkWl9NXBO
	 YAWidFn+youjqKmhuUm1YZQ2YdbuxOtplpmEhnn+b6dT/9czpt/F3OQo/cbw0M+6K4
	 0l8hQRsaQZPls2EtUkQNkQ1c=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CF3EC40E01A2;
	Wed, 31 Jan 2024 20:23:45 +0000 (UTC)
Date: Wed, 31 Jan 2024 21:23:40 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Isaku Yamahata <isaku.yamahata@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH, RESEND] x86/pat: Simplifying the PAT programming protocol
Message-ID: <20240131202340.GLZbqsTJkeFQycXT0B@fat_crate.local>
References: <20240124130650.496056-1-kirill.shutemov@linux.intel.com>
 <20240131175738.GIZbqKEhlDKhaKfh_w@fat_crate.local>
 <67hqgqargmt6nln5mds672g263lka7glyzbvcdgt4owdg7xc2e@v6wvuizw5ond>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <67hqgqargmt6nln5mds672g263lka7glyzbvcdgt4owdg7xc2e@v6wvuizw5ond>

On Wed, Jan 31, 2024 at 08:52:46PM +0200, Kirill A. Shutemov wrote:
> The second step is relevant for set_memory code that already does the
> flushing on changing memory type.

So the "relaxation" is the removal of that CR0.CD requirement?

> Our HW folks confirmed that the new optimized sequence works on all past
> processors that support PAT.

Your folks confirmed that for all released hw and for x86 hardware from
other vendors?

> Testing wouldn't hurt, but it cannot possibly prove that the new flow is
> safe by testing.

This basically says that I should not take this patch at all as there's
no way of even testing it?!

I hope I'm misunderstanding you.

> PAT MST was always virtualized, but we was not able to program it as we
> followed MTRR protocol that sets CR0.CD. And I covered it in the commit
> message:
> 
>     Specifically, a TDX guest is not allowed to set CR0.CD. It triggers
>     a #VE exception.

Ok, I'll extend that part once the rest has been sorted out.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

