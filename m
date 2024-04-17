Return-Path: <linux-kernel+bounces-148255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A57B8A7FEE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A2A21F212FC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524A4131BD6;
	Wed, 17 Apr 2024 09:38:35 +0000 (UTC)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5D371745
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 09:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713346714; cv=none; b=AGdqzC+ZpdRdm7KwnQ5BGHU+Bvnk3CiCoYnJjGhDNkIIn8OQgbJNkpIEp/WldI4cH+9kwmtenXN89YSQBDD/TW74PfySMb8UJM92zphyB9uik+R03dVi9dIQWPOIcaJXHB1suYk8/0qGUMQ8IjyZaIKLYoIiCzjzrbyvSXj87q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713346714; c=relaxed/simple;
	bh=PZeNXJyqC9rw3ap+NVpOoxdF8g9el56b8CtLSKiiQ4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j8FCJ95VgctnnBfNLAGzYbRsVUSjWVN+vI9yle6BzPNY4qjHGNw7EksjCKeV3KAu5UiUpH/JExrX/07DSx+R/nbpI6wL/qPx2QqV05KTY1yUoRdsijteHQSaLsMv4Jy0JbgL+I/GU9chh07ueEzkjpN9O4oiFN/zNOaZ9yx60CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id ACEE940E024C;
	Wed, 17 Apr 2024 09:38:30 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 2IPzCUJhnw5j; Wed, 17 Apr 2024 09:38:27 +0000 (UTC)
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B0EE940E0028;
	Wed, 17 Apr 2024 09:38:18 +0000 (UTC)
Date: Wed, 17 Apr 2024 11:38:13 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Xin Li (Intel)" <xin@zytor.com>
Cc: linux-kernel@vger.kernel.org, luto@kernel.org, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com
Subject: Re: [PATCH v3 1/1] x86/fred: Fix INT80 emulation for FRED
Message-ID: <20240417093813.GBZh-YhSQCXgy3OxFI@fat_crate.local>
References: <20240417063001.3773507-1-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240417063001.3773507-1-xin@zytor.com>

On Tue, Apr 16, 2024 at 11:30:01PM -0700, Xin Li (Intel) wrote:
> 3) The FRED kernel entry handler does *NOT* dispatch INT instructions,
>    which is of event type EVENT_TYPE_SWINT, so compared with
>    do_int80_emulation(), there is no need to do any user mode check.

What does that mean?

An event handler doesn't dispatch INT insns?

/me is confused.

> +#ifdef CONFIG_X86_FRED
> +/*
> + * A FRED-specific INT80 handler fred_int80_emulation() is required:
> + *
> + * 1) As INT instructions and hardware interrupts are separate event
> + *    types, FRED does not preclude the use of vector 0x80 for external
> + *    interrupts. As a result the FRED setup code does *NOT* reserve
> + *    vector 0x80 and calling int80_is_external() is not merely
> + *    suboptimal but actively incorrect: it could cause a system call
> + *    to be incorrectly ignored.
> + *
> + * 2) fred_int80_emulation(), only called for handling vector 0x80 of
> + *    event type EVENT_TYPE_SWINT, will NEVER be called to handle any
> + *    external interrupt (event type EVENT_TYPE_EXTINT).
> + *
> + * 3) The FRED kernel entry handler does *NOT* dispatch INT instructions,
> + *    which is of event type EVENT_TYPE_SWINT, so compared with
> + *    do_int80_emulation(), there is no need to do any user mode check.
> + *
> + * 4) int80_emulation() does a CLEAR_BRANCH_HISTORY, which is likely
> + *    overkill for new x86 CPU implementations that support FRED.
> + *
> + * 5) int $0x80 is the FAST path for 32-bit system calls under FRED.
> + *
> + * A dedicated FRED INT80 handler duplicates quite a bit of the code in
> + * do_int80_emulation(), but it avoids sprinkling more tests and seems
> + * more readable. Just remember that we can always unify common stuff
> + * later if it turns out that it won't diverge anymore, i.e., after the
> + * FRED code settles.
> + */

And this is talking about duplication above and that text is duplicated
from the commit message. :)

I'll zap it when applying.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

