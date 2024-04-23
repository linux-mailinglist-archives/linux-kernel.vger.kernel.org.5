Return-Path: <linux-kernel+bounces-155513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 606858AF369
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 913811C219C3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623EF13CA96;
	Tue, 23 Apr 2024 16:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="TXxdSqMZ"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F4B13C9DB
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 16:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713888216; cv=none; b=UdfACMGCXVdg2/YCX+TwI38h2jTTIt+tN80w5Po+MEdET7pzM7OsqKGs8+d5S4vZdnIY4YeYaULcAYcYwSOXdoWITa3sjbSQT1bIEHAb3UG/J2jHCdFLHqXID3GD2c9XUvccJl0amDzNqgtBUCXsydH/yi3sRnUr79Rf/ICpAzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713888216; c=relaxed/simple;
	bh=ZsuinK5RhPrAcf4onYz+ohAWbVi3KXroAewewFUGu9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TlWk5u6a8t3A7m2c//vnSz8JC+RE9j91jW5uKhUFegO7N1kCbGqB9KDS1hf9o8oDeDEjzOp5Ki7lwGnTcVm9Gw6R79jJYvYJP9skP7DgzNSi/qkvIzYoH40f4BqmPmTlnN/YI6BwA9V6L+7gZGu1rN36yq0J3zkdO9YsRrscdOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=TXxdSqMZ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 86CB540E0192;
	Tue, 23 Apr 2024 16:03:29 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id SL5JtAOWtOYR; Tue, 23 Apr 2024 16:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1713888205; bh=IiD+6XFkDSEK2/f7fOiQcCjp0YlleOKij4PQKeQ0D5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TXxdSqMZsY+FRKwNdjz4vBICMsm9Enxv0XLC8q9Vup4Qk5tqDG705c2FJ0CMbJj72
	 igAyWgN4VL9Gxat3hdmABoIFuqaIXwpx2SbRKp258zyIo7xCrs23rKXYAYNgHomacS
	 Bja2CSfG70JvAre9Ih2CatH4OMJ7QtZeZQYxere7tyjWB+pJmaHDTkf6kEzhKHJCIO
	 BJFAgQJTgacsbJVFoCBhrBKdWb9UUReauR+Y+iDzP7rmKWIup6yWb4etUVkXbJhlCN
	 NcmAwWwJwIUNKOC5Sc5BRYyIZcNtTjlqOMjHYaGU4BlJ+MCVMF8BrMr2Dz9OOgKoI9
	 GVRkRtFFg1brO/ZEriSEsG0arG3Y9sjO8UBNXyt6lAGna3y1m3WonYhhhf+naxNDbd
	 egDk73cNtbhEPL6+bsS16kkdE35xAk/d+zKp7h61TitpU9SA6wzZQF+KzS9jYVWJ+H
	 UQTtWDXtZ5gUrvakcZl7NeY6f6UXPPSY7eEnfBiF8oDrBHbWgekiHvAJODMnWrNx8x
	 o8mEE/Fbobqs2VYNGVtWiSDJC4ZO6XkXdLSANmYt/n6nVGuSR5SoHB/LmET9301nKb
	 GOv+/sPBfBOEzVxbKb90U7GCNcrCLmH9DBvuA0DhEth7ppx0BhxvR76TZiasaITCTX
	 tZTDSfBAtksHFfubS2p9o2Iw=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6555840E00B2;
	Tue, 23 Apr 2024 16:03:04 +0000 (UTC)
Date: Tue, 23 Apr 2024 18:02:58 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, Tao Liu <ltao@redhat.com>
Subject: Re: [PATCHv10 04/18] cpu/hotplug, x86/acpi: Disable CPU offlining
 for ACPI MADT wakeup
Message-ID: <20240423160258.GBZifbsuoTIbWDapej@fat_crate.local>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
 <20240409113010.465412-5-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240409113010.465412-5-kirill.shutemov@linux.intel.com>

On Tue, Apr 09, 2024 at 02:29:56PM +0300, Kirill A. Shutemov wrote:
> ACPI MADT doesn't allow to offline CPU after it got woke up.

In all your text: s/woke/woken/g

> 
> Currently CPU hotplug is prevented based on the confidential computing
> attribute which is set for Intel TDX. But TDX is not the only possible
> user of the wake up method.
> 
> Disable CPU offlining on ACPI MADT wakeup enumeration.

Something's missing in that "justification". It should explain why
CC_ATTR_HOTPLUG_DISABLED is not needed anymore.

And looking at patch 3, I'm still unclear as to why this change is done.
Is it that the "ACPI MADT mailbox wakeup method" is going to be used by
TDX guests now too so that you don't need CC_ATTR_HOTPLUG_DISABLED
anymore?

It seems that if acpi_parse_mp_wake() finds an ok wakeup entry, then
offlining is disabled...

Or is it something else?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

