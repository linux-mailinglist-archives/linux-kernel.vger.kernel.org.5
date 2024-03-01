Return-Path: <linux-kernel+bounces-89007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA1C86E962
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E571FB21BBC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128304411;
	Fri,  1 Mar 2024 19:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="UYt99AWG"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D463AC25
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 19:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709320837; cv=none; b=FwCWxrd+IHEtcBKRBEhStQsJlF5ATuzKe57jVVy0NFgMlD0QY0aEzu0xEZC/elaCXM3Y8dj2TqP8MKFwe8sUDrPx8vhyQpAhj0TI6/6R/CLwLtS4SjYHObGrknHv6N6hwv4zBwITdC9IuZ4HiEDXTCLnNHD8hyvO+3hlD3JKrJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709320837; c=relaxed/simple;
	bh=h1Qs/tBOfJkqrKLgB9yET3H3kzxXa9lz2i23Pqe3JtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCI/Hm4IPXdYuY6ME7c0C8kH1bG8dgm/8CGoAZTb5NssukmR4OI/qVVqplADrTTMKPcl7lJ4BywOFTbvecFS0cSvVITenhqzp+w0/eGosOg/Hbwv4uHAFaxA75Jhim5eWU8Ayk3s7UU5LiteBZPe/pkB/7SsllxXlnnWacLGvYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=UYt99AWG; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BF6AA40E016C;
	Fri,  1 Mar 2024 19:20:31 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Wl7KY1nLVD8U; Fri,  1 Mar 2024 19:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1709320829; bh=BpxL5ZOoD7httDbUEO/fzDwjd08gE4TdV+yKZ0Ti1VI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UYt99AWG2/4BdYGbLJFwpVDGNHyg1pMvAVZNonC5PpbxCZ+P5+AFV3h3ipaeRn3Pv
	 S1mtxC5osJdgW2Pcw08PDzEmuEfPDgVV1uSE+npEGeTEj2B8k0rmZG6nr5lob8DTyu
	 Gznvb831x7lUXm4s6gT/fe2/8tI/AUvXFVvwKqjl1QpuoHjbmo0kXwzuB+GnxfXeYm
	 EYs/6U4fF5wv/OUrTwzIyEaXo0Sd0y3p3GZxuHljOY4mVM2lQXbFGxvWrY7pALENCp
	 kXC1gn2vMaXJf8wevTPIGQD0J1UEWYBbHMc8+lZxnJTPC7i+3foW9jSIkDNJ2Ml6bL
	 H3Kqr6Zq/AzxYhU3DQbqT6Mc2YqOTUkDgZqUrthGIE5WPstTolZ+AESIv5G/S6f38C
	 QXU8+8v1gda1TG0y5orjFsfyGxx9HH7IIO2kXIWWQ33F+Jv7kc5XmHId0PhwmiFfrK
	 ldwfdGbEeUxhsa7lY3TD6rBVjN1rC3MGl4b062m+0FUofrB5duckbje7sthDxQ8zHj
	 FzJnqUE5S1lUJKCmfDUygBNkgsf+qEvMmyIOh3b3Aajnx/H5HlgTwLcTtuN9Ja2lIS
	 Dyq0kCOmQBT6L0r1eeLQWtJ2TzTHVE3kzjpZ/K/99v1ubmyvqJ0LUle7ep4N4AnQfQ
	 CDNJfUU25OE181ujBaCITSiY=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AB20E40E0196;
	Fri,  1 Mar 2024 19:20:18 +0000 (UTC)
Date: Fri, 1 Mar 2024 20:20:17 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Dionna Glaze <dionnaglaze@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>
Subject: Re: [PATCH v7 9/9] x86/startup_64: Drop global variables keeping
 track of LA57 state
Message-ID: <20240301192017.GOZeIqcbI9S69zdBYW@fat_crate.local>
References: <20240227151907.387873-11-ardb+git@google.com>
 <20240227151907.387873-20-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240227151907.387873-20-ardb+git@google.com>

On Tue, Feb 27, 2024 at 04:19:17PM +0100, Ard Biesheuvel wrote:
> +	asm(ALTERNATIVE_TERNARY(
> +		"movq %%cr4, %[reg] \n\t btl %[la57], %k[reg]" CC_SET(c),
> +		%P[feat], "stc", "clc")
> +		: [reg] "=&r" (r), CC_OUT(c) (ret)
> +		: [feat] "i"  (X86_FEATURE_LA57),
> +		  [la57] "i"  (X86_CR4_LA57_BIT)
> +		: "cc");
> +
> +	return ret;

Yeah, I said this is creative but an alternative here looks like an
overkill.

Can we use a RIP_REL_REF(global var) instead pls?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

