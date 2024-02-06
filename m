Return-Path: <linux-kernel+bounces-55164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC24084B8B5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 953DF281E99
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8F913248D;
	Tue,  6 Feb 2024 14:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="O8i5XN4L"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8841332A1
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 14:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707231523; cv=none; b=cbBf+EIm+rB4dXE51/4/TG/8hb88H4aJ5UUYuzDdQKakYuc0s7yEybDjxVexnU4HzRr/RQGphy3WQmZ99dQMFWO3/7ZKRR3TIUSbiTWTqrSJbuEqTVdZejU9HwIa98dNHKYn8moy2ZH1S6mNwxwg77pnRn1QABU/KU3h3Pr7aGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707231523; c=relaxed/simple;
	bh=1sakcfwHbduv1QG55yUb/0QyrJ5pcF2H9gOitpIs5TE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJRa+EgMfAKCReM20hNPLl6CQbhJSolLPN+JmZSdXvAWFbZkfDMw/aPLdNacebepHBO4+MNIpzKUJ46ipLy9ekvMoYkRggodt+1CS5zutUGv7PMg9ayl+vpiJjm11K7ddAxEKzR0L8SBiLcyvy3/VC6yONrntliP0vNGNaIEYEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=O8i5XN4L reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5736740E023B;
	Tue,  6 Feb 2024 14:58:38 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6N-2NqL4nxZb; Tue,  6 Feb 2024 14:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707231514; bh=VW8dCTrnXsJ0MqUg+ae0MKX/eGhix3vlYzBavQRsGGQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O8i5XN4LGLVqvv1rSIyKsiVP/kBmrr3nlrFKpWbYjbtK2w9oHJiTem4Xz5VZuhqKa
	 zzDe0mAlTfdnn+21/oV+6SnD1dPTPYebLOs5u8ZdbeKz2abUv/2UyCcXPMqCxzAndK
	 z0cUmLC/ykaB8JtgtTwYg1wnIxqOVoT6L469tcNx8/L/6RbywHlXb9fyCq/muuB1Q9
	 iw1uxs+2KMUw1Q+oJPh7+wSGgGs4WKymsCQhfHNNhjb641IaEf9Yxv2yInhDm40qj2
	 P8fnsjSBYaARNEhehff+ikNH6uZ3SkDfFq9rZeyGf0568TimjUqgw4MWb9PX13eQId
	 PbgMGPdJ7o3wElluK7OakVqjlSPabkdt5jeC/6ZWknpUNYI3mLr7CtmcRzNE18SABh
	 Evh5v3U1bPlGjQQPBHOFAI1tZwEeroeIEITd9xv2yhp5XNGHhWjh0YUnLaWA+Ixiig
	 gOVzUFysY5JAXIUIVadM+xz11bL45yN2HS2NaX/q3d+p2sYdsW3Z5eCdU8nPnsgkfx
	 QCKklXD0B2Y9BdSp4m1bvt8hjjkQm4PjEGQh1oe/8LerXYufzkBldipAAqlzQjuUZe
	 69/LqsA5xclG9cEPcojLBDK5C4bH7ODmBc/AkaL6POGCd3ucGqIb7TkH5ZV4FBeYW2
	 mZ96yoIyY4hKcsnPv7kZw4tI=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 20CB140E00B2;
	Tue,  6 Feb 2024 14:58:28 +0000 (UTC)
Date: Tue, 6 Feb 2024 15:58:23 +0100
From: Borislav Petkov <bp@alien8.de>
To: Hanno =?utf-8?B?QsO2Y2s=?= <hanno@hboeck.de>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: Improve description of
 IA32_EMULATION_DEFAULT_DISABLED
Message-ID: <20240206145823.GGZcJJD8rDtPRNBkhe@fat_crate.local>
References: <20240130104543.28840812.hanno@hboeck.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240130104543.28840812.hanno@hboeck.de>
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 10:45:43AM +0100, Hanno B=C3=B6ck wrote:
> The description of the option disables a default, but does not mention
> how to change that default. To make it easier to find out, mention boot
> parameter ia32_emulation.
>=20
> Signed-off-by: Hanno B=C3=B6ck <hanno@hboeck.de>
> ---
>=20
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 5edec175b..a65ff33e0 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -3006,8 +3006,10 @@ config IA32_EMULATION_DEFAULT_DISABLED
>  	depends on IA32_EMULATION
>  	help
>  	  Make IA32 emulation disabled by default. This prevents loading 32-b=
it
> -	  processes and access to 32-bit syscalls. If unsure, leave it to its
> -	  default value.
> +	  processes and access to 32-bit syscalls. If set, IA32 emulation can=
 be
> +	  re-enabled with the boot parameter ia32_emulation=3Dtrue.

That sentence should say one can enable it *dynamically* with the cmdline
param.

But this text reads weird: if I want to enable it, then I won't set
IA32_EMULATION_DEFAULT_DISABLED in the first place and I won't have that
problem.

So the use case must be something along the lines of, ia32 emu is
default-disabled at build time but for certain cases where one wants it,
one can still enable it per-boot with a cmdline param.

So what's the story here?

Thx.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

