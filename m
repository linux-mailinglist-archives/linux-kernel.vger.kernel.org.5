Return-Path: <linux-kernel+bounces-123301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE305890647
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4FD52A3A89
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57291369BC;
	Thu, 28 Mar 2024 16:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ipepdLq6"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A785041A84
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 16:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711644508; cv=none; b=QgAKNhyIHARQxoYSw/cYSl02bl+ybueiXGTYf3SVp1fJv7laTZBS+TFldHQBgrphK0aCppWJoAf4Bx5TLaN/oK6LI6FlMR1JUXYlbdJaPvFjd54GlRiUJqyUGdVVvG2KV4LK2Wfsg07mMSzfuxDEuFZRb2Ghe0ttTVW3rQhuvtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711644508; c=relaxed/simple;
	bh=eIs4O4s4xJQE5+HpKhCWd4AZ6Ys4Zcuc4A/6FsaEj30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+eDiKN5pWEJjRgAJBHG+wcszYmm2LS3dgZMAkNypx1nQGoVf5e3ENDruU5dbiYiCbBngzyBGrZNsnIf1IFgkknrxXjxwjv8hk1uH6tUkXdOesL7PGeXhgJ6ni0HLp7/rF7jOjTjTD9bVcxs7YV/idQupCvBIyktZ97HZtTEWUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ipepdLq6; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5E1BC40E024C;
	Thu, 28 Mar 2024 16:48:24 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id YiQoA9Pr1ltk; Thu, 28 Mar 2024 16:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1711644499; bh=ZvLxj9Ez3rRsztf8ZFy8bTWKEto+yVyhTFTt+eJhk+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ipepdLq6zzVo1CcWwYq7hN5L1KtQSSJ9szDHKlpn7WIvjk7yxKf0jqkhujmpngQTR
	 W6N68hfJeDWxvyoPxzn5xoDjud5Hn3KYhs6lECSfpFsngYMZSFgMAirD3iqx+bEHd7
	 iA2v391J5B7fOckmzOCyBclFxE+wG84n/bsznV45rqmn5uKWLJ86kYHrKN3WROH7ah
	 w7tatg2RxpDq5xqAGTTeFyl61PxHYfkDR51GYUhjP6wnOrTiaefcaALP3VOsmBLHzt
	 DqIzKf4a3ccGyfWanjEToEfyTREFjs7zWWYnGdT0/hXsllpZgwUScZSEiWFJyfSvZy
	 VhJaIquBusaxdocMMMFv6cEv8yLB1gLpUQgK4KtI4I2aVL2jREK6McWZ8mVJ89O00D
	 3XffKzY6T12vXyuQuXlwDM6TI2FR115S5pF3QbEje5SVVW7w1eI9LrMcWX5m6sURTG
	 xpzcj+zqVV0mL10m77uhIHYNW+SUh8XZ1dh5DpzaxATnBwU1kT5TbDY14Uww5yBUo3
	 14sh3RttV68yBnCaBM+YaS0TYvq0iDiKYmpom73tpLHayagm7rwGu7EVWfNLs2nr0s
	 dSo0uo7kWgnnGsK878dDPSjxaAKHEyBysWJQG1aXRWeaVb1RAe9bcpy3ZBNSM5B3b2
	 4KI1Wi+CkJh8P2aWaziC/GjE=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CBB0140E00B2;
	Thu, 28 Mar 2024 16:48:16 +0000 (UTC)
Date: Thu, 28 Mar 2024 17:48:11 +0100
From: Borislav Petkov <bp@alien8.de>
To: Tony Luck <tony.luck@intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/74] x86/cpu/vfm: Add/initialize x86_vfm field to
 struct cpuinfo_x86
Message-ID: <20240328164811.GDZgWfSzAWZXO7dUky@fat_crate.local>
References: <20240328163746.243023-1-tony.luck@intel.com>
 <20240328163746.243023-2-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240328163746.243023-2-tony.luck@intel.com>

On Thu, Mar 28, 2024 at 09:37:44AM -0700, Tony Luck wrote:
> Refactor struct cpuinfo_x86 so that the vendor, family, and model
> fields are overlayed in a union with a 32-bit field that combines
> all three (together with a one byte reserved field in the upper
> byte).
> 
> This will make it easy, cheap, and reliable to check all three
> values at once.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  arch/x86/include/asm/processor.h | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index 811548f131f4..87115e5d884f 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -108,9 +108,15 @@ struct cpuinfo_topology {
>  };
>  
>  struct cpuinfo_x86 {
> -	__u8			x86;		/* CPU family */
> -	__u8			x86_vendor;	/* CPU vendor */
> -	__u8			x86_model;
> +	union {
> +		struct {
> +			__u8	x86_vendor;	/* CPU vendor */
> +			__u8	x86;		/* CPU family */
> +			__u8	x86_model;
> +			__u8	x86_reserved;
> +		};
> +		__u32		x86_vfm;	/* combined vendor, family, model */
> +	};
>  	__u8			x86_stepping;

Why are you leaving out stepping?

And since we want to simplify all this, why aren't we replacing all
f/m/s checks by using the whole CPUID(1).EAX u32 instead?

Then the macros need to build that CPUID leaf simply.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

