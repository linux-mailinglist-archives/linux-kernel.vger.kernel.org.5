Return-Path: <linux-kernel+bounces-95904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 198E28754C9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E330284655
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D6312FF9C;
	Thu,  7 Mar 2024 17:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="dYjZKRY7"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED6012F5BD
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 17:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709830921; cv=none; b=XR3HOomWpMxtvXS3NHFz/77jmTALQHwmzfVdTyRPlcq4u3PZlHjLp10pC9rnkIGL//muIzzfnskd9Z4xPulQ/Z0yYBAemJWg9kJ+FojH6S5wJsmOjwLuXiCpmKzBYU3ex6WJpEMh81CtVwAaoSCOARKbc2sCP+ltER9+u45ysF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709830921; c=relaxed/simple;
	bh=LcsZDBu7i8TVvjRoGXdUobeGBAVQrIzFxf86yfSzBc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j8SgiVB1IvYpSKS5gOJtxTWBUAr7aloM+/PaKWUNp0In8ZfbEtZ+wMN+BZs5fXDEyzqb7AIKD6ROq8ohnSSZ4nJe5qV+rdPMPlemMjgR3se7f7r6aT9Ffq3uPXFM7CgM3dKzPP/6fObtsvPZp9hnQPIjOE2cbndpJyBNf6K/fJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=dYjZKRY7 reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C884B40E0174;
	Thu,  7 Mar 2024 17:01:56 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id sUH3ZcikQumX; Thu,  7 Mar 2024 17:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1709830911; bh=rpz68PYxMPxwlMiTEm8jQzSPUwIp/GcI3wa+Esza15o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dYjZKRY7RJ+9sZOEw+jKlpVOkuO4sJPL8j2Z6kOW/U8616VjsYv7oaQu4OlvbGJIs
	 LFPV9bGlu3KP7y96BLG8MQuJ1ghL7kokYy99hXzY6RlKAlU3HCfyYKwuLDo8t/8TN+
	 NcRZArbF6sH3a3sLhdL8K1n9KBxFfWb2P1rqn1J8ZR+y27fzwA6BUR0heoVvJlrFhP
	 5pTkBLCtDgRxlEIeGS2CfEdlV4uphn2Widj2P/sVZvtBjJmKAr2l3xgT2n9Fx2ER0o
	 3mMTU2GIQXjlYeAKCAtKyvuetpkwD8e2ZA70QZsp5ojSwE2LkmP1Gnf+DlIDm1n8sT
	 /eijqhYKGQsyfmA1Vs8aBV3pX16vLnBO53wtON2Fg6wd4dY5y81/og1pcCLZQzEXGq
	 DWst80PzQ3SXul/V0hrNUaFT2VPen89H/A2cNciktw+Eq9T54o9GAcvHCYlwVKoJ4P
	 QPKH4+0zlnrD6XirLo2nOazzKd6/ubSOO9UJyDrRMISaQq2hjgYOfo4BmBecTQnBAk
	 AiTXDEyziuTasvWtfXJD7NRi72/Z+bK/Awi+eyD4vgiIvh1/lt3j1WYdp/K7yZQSU9
	 X437tMlDa1jLIvC/IANpDfyP8nF8pA8xyEQgbEZ9xj5T9MCGgs4dKZuX8gVQwXmh0O
	 xjDj6JXmO1C4HbGoBAAAKYWY=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C32E040E0173;
	Thu,  7 Mar 2024 17:01:44 +0000 (UTC)
Date: Thu, 7 Mar 2024 18:01:39 +0100
From: Borislav Petkov <bp@alien8.de>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
	pbonzini@redhat.com, tglx@linutronix.de, x86@kernel.org,
	jgross@suse.com
Subject: Re: [RFC][PATCH 02/34] x86/xen: Remove early "debug" physical
 address lookups
Message-ID: <20240307170139.GBZeny84YTkJA75V9V@fat_crate.local>
References: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
 <20240222183929.E17C1B9C@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240222183929.E17C1B9C@davehans-spike.ostc.intel.com>
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 10:39:29AM -0800, Dave Hansen wrote:
>=20
> From: Dave Hansen <dave.hansen@linux.intel.com>
>=20
> The __pa() facility is subject to debugging checks if CONFIG_DEBUG_VIRT=
UAL=3Dy.
> One of those debugging checks is whether the physical address is valid
> on the platform.  That information is normally available via CPUID.  Bu=
t
> the __pa() code currently looks it up in 'boot_cpu_data' which is not
> fully set up in early Xen PV boot.
>=20
> The Xen PV code currently tries to get this info with
> get_cpu_address_sizes() which also depends on 'boot_cpu_data' to be at
> least somewhat set up.  The result is that the c->x86_phys_bits gets a
> sane value, but not one that has anything to do with the hardware.  In
> other words, the CONFIG_DEBUG_VIRTUAL checks are performed with what
> amounts to garbage inputs.
>=20
> Garbage checks are worse than no check at all.  Move over to the
> "nodebug" variant to axe the checks.
>=20
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Juergen Gross <jgross@suse.com>
> ---
>=20
>  b/arch/x86/xen/enlighten_pv.c |    2 +-
>  b/arch/x86/xen/mmu_pv.c       |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>

At least as far as I can follow the Xen boot flow, yap, this makes
sense.

But let's have J=C3=BCrgen confirm first.

Thx.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

