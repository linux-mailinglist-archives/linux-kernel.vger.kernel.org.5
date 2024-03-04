Return-Path: <linux-kernel+bounces-90488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA1F870000
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F0491C2335D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1D839FCD;
	Mon,  4 Mar 2024 11:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="aYeNFyF0"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8891D37718
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 11:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709550705; cv=none; b=nsH+hRebWvU6Ct0vexXT2PX/3AS1DptPDysAfI8eoaJZucGeiSqh/Km0lE7NzM4nlOsRDA5etYGXZBVSK3o7di5AwF2cmgg4f+UoXqfsEMa91PiVcr3QXgrgC2OkD3eB04EislKlS/llg/6vIEGTLEqOuyE0mSQc9H2+sXiUzRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709550705; c=relaxed/simple;
	bh=TVGauwyeBR4AdfQsHXvgRjKRsr6eVvmQ6GDdnL5kg3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wmhejz/Oz9fiM6Zo1jJ96D3VTOEi760QPWfu785rKj2kfvmeY2f3NqTv16klh4gK5t6tztppwz2GxfjbRGUixWTM8BhBNM5hwP19q4yCAfPZwqMiAdHFbp5UGvOnTSSy51i6gFeCoCbdrh6uPE/0OIK1O7/vd6wzQfPIys7Y1tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=aYeNFyF0; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 21F1240E01A2;
	Mon,  4 Mar 2024 11:11:40 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 8Tc4xTkS6DEL; Mon,  4 Mar 2024 11:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1709550698; bh=BZDhxNl8JTWBcRIoa6Vr2/iEajD+gZXg9rtceU6Dukk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aYeNFyF06TiGLHX8iz5HBkRDLQZNOzTLQ7+dK2Matf9/avlXsaoCW9WigEJP0cK/x
	 kNGF8mRornpET98+oFZKuaf2InU/HMTpIu0bk9afLNDGYZW57yvmiWu5Jd+0ZKJEzU
	 1q5q1lTc8NzGIFTDrqoNzT4AXmvE9fdOBADankEhgTUN1UlCCYCPqXwh0ObLs+7OAu
	 MSG4T1GaUOuQYhZ0DIODwDl8ms9Q0AIxZA6e8jcUJJirtgSTdMsSgsLpEkPHpub5Zh
	 SPh111R2VaNm4r42FALWTRQfTxgLzqdDsbLQKsyBg2FAYT6qr5mAqPoCpat8/WDek7
	 evj8vENsv/ASD/n4t+8q/5arpVPGvxINSr+ZL3ufJCB4bRQ2gZqW/9gTjlfoBRoix/
	 46tDMcL0ccbSzpAlMfCVhQU63YKdndGtuw8nRmyFavBx9TO3J1iBAMiNhEfVzG5gY2
	 JfskYEamk5oZjkgP1VHlznQKB79eAIwhx0D1L39gjD6DuVrYEUcNfoFtc5eeV33hiU
	 hm4McEyaM9RM0cCwTYsKZYnettZWG1vhgWQdx1TjTJkf4n9HL8BjFaKg/vU24Y9idQ
	 EXdCwYnOGx19cA8wnb3TpjklyjUhADWK/1I+v3CaLYLvKhoGdpOlEqeKvaCMT0yieJ
	 LXcKZoS5Z7pgM3orVyoFxvsM=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0B86040E0185;
	Mon,  4 Mar 2024 11:11:34 +0000 (UTC)
Date: Mon, 4 Mar 2024 12:11:27 +0100
From: Borislav Petkov <bp@alien8.de>
To: Baoquan He <bhe@redhat.com>
Cc: X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	dyoung@redhat.com
Subject: Re: [RFC PATCH 1/2] Revert "x86/kexec/64: Prevent kexec from 5-level
 paging to a 4-level only kernel"
Message-ID: <20240304111127.GAZeWsX3gBabiwrrVV@fat_crate.local>
References: <20240301185618.19663-1-bp@alien8.de>
 <20240301185618.19663-2-bp@alien8.de>
 <ZeWnrhzU86pz7y5Z@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZeWnrhzU86pz7y5Z@MiWiFi-R3L-srv>

On Mon, Mar 04, 2024 at 06:51:26PM +0800, Baoquan He wrote:
> It's not true. Customer may want to try to load a different kernel if

"may want" is one of those hypothetical things which we don't do. If we
have to support everything a customer *may* want, then the kernel will
be a madness.

Also, you do realize that the kernel doesn't care about "customers",
right?

And the question is, how *sensible* is such a use case?

In my experience, not at all. You simply take the same kernel or a very
similar one and kexec it.

> they have taken many testings and trust that kdump kernel, or for
> debugging.

Yes, and those kernels will have 5level too. Practically, distros must
enable 5level support in their kernels in order to support modern hw.

> The similar for kexec reboot into 2nd kernel. We don't enforce
> kexec/kdump to work on the same kernel as the 1st kernel. With the
> fail and message, user can take measure to avoid that. it's better the
> failure is encountered when failing to jump to kexec/kdump kernel.

I can't parse that example.

Btw, kexec tools don't use those XLF_5LEVEL* flags bits either. Which
basically means we don't really need them.

> I remmeber we have use case where customer used kdump kernel different
> than the 1st kernel. While I don't remember why.

See above.

And that customer can still use the old distro kernels which have those
flags.

The point here is, going forward, 5level becomes ubiquitous and will be
even more tightly integrated in the kernel so that it'll become just
another default feature which is either there or not.

So the distinction is going away and the flags can go too.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

