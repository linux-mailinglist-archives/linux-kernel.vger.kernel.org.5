Return-Path: <linux-kernel+bounces-163102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6948B65BB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 00:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 194141C20F04
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 22:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9CE194C6C;
	Mon, 29 Apr 2024 22:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="aoT/7pu8"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BD51836CF
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 22:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714429762; cv=none; b=Oq368x5JAuHBErDI+AavhZ5O8a30C8P1vIEDqS0GfkATYQQjQDP3pYO2pigt6bS9i41b/ecu8IfEsTubvEDP03mPdYNktrSHpVSaXYxl+sZTKZxT/bzat2RrKCmmfFr4Ogo9z1v5d7SM7W/JA5KI5Q6uK5BbXsREykjC6DgE7Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714429762; c=relaxed/simple;
	bh=olLVpZ2j+SHjB61yuKGGezEBjEWAAYUccB1p5zTNaWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PycKSipfthPFkQs8xq9lf95/XwK9RLes6YDqJoRv1irQrZagU/csRdVhWmPZN5dfGKsVp7wrPlXTgyJIV8rVeB6qLsHk9EH17BKUIjgDHeY6AfUSAs4R5gT4mQb7Fr45zJtwdu0XJerAEiNXGYrRZE42h52nG4UVBMK1uC5TarQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=aoT/7pu8; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9A97340E0187;
	Mon, 29 Apr 2024 22:29:18 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Mm7HMpVwYmuH; Mon, 29 Apr 2024 22:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714429754; bh=FrmKXZ5qkHR0RU1Yn++vRS2xOfSDZ4jFNGlxYmVJZYQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aoT/7pu8n1GkbE9DmTCcHiaI6zeH059lSWL8OgfwRqELCh0Rm85Ne77OtHNQefjeT
	 qb+lNe5ftXWI0XtZ8pfaeGHEEr42SqezwrE8b1f+oupfyavc+8ssM4a7uuXZwQWyNh
	 3hWVbERYwv57dGt8+54rzninzk6GkPykhjKCV693hAp9sZaG+Oy+UHioI8TNCH5uI3
	 TFNwvmhfShCWexofmm9wfF1KZe9ntSb82nJS3jfXfMP91S9N8+oaCc43rQ3gIloYii
	 TQ/LeORaKYCltd+wRump2NJ5M3Fb6MqPIIWnraWgK4qTvn74ZKFTWVKUDCwmVSaFgw
	 NLVm9qhU/HQs1f+6YmPfnFM4ypy9dhVF33mGgIwjXJYMEy2RHP2d2mfa+wmfoN3eI0
	 C1jJpzHyQx+XX34GyOb5iopAGOQLFMnMW2GIerL/cPql5aEdMKLTRtF4WHNOd7fcVe
	 r78QJ/yyfEeYghN+KxH9pZedx8/LncjtddrYFolo9oAj+hR4QEXU69XtpRt+IQbpa4
	 l1jvfqyynD8FynnNfrdCnxbmgb4s2SbjDIi08a4ohrr409QK/QSamXCT7AJvBSv7nC
	 LlCALO89U9lkHeyxAb86bamIBBuZ0PW85kjqNuGSZZar5XhP6liPlmpzuZk8oFs2K7
	 V85cYYOte70TPmeu3j7czF18=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A71B740E016B;
	Mon, 29 Apr 2024 22:29:08 +0000 (UTC)
Date: Tue, 30 Apr 2024 00:29:02 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Borislav Petkov <bp@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] clocksource: Make the int help prompt unit readable in
 ncurses
Message-ID: <20240429222902.GLZjAfLjanzLuH3iOl@fat_crate.local>
References: <20240428102143.26764-1-bp@kernel.org>
 <ecde0c52-3a91-4762-b0c3-6455d3cedecd@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ecde0c52-3a91-4762-b0c3-6455d3cedecd@paulmck-laptop>

On Mon, Apr 29, 2024 at 09:04:30AM -0700, Paul E. McKenney wrote:
> So all the world is not yet a UTF-8?  ;-)

.. and it's not like I'm not trying. I have a fairly new debian
testing, xterm v390 and libncurses5 v6.3 but nope, no joy.

I betcha it is some stupid conversion thing.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

