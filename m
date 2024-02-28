Return-Path: <linux-kernel+bounces-84789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B2086AB8F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 361FB1F2596E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D0F36AEC;
	Wed, 28 Feb 2024 09:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eKTeBzwJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="J682NSW/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eKTeBzwJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="J682NSW/"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8DD339BD
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 09:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709113511; cv=none; b=ch/13I36yqGYLIcjCzDEYRoZ4DmYD46H6+9LQ1y8OqKoPO/jUOjWeXdWCylFx8q+Z+bGrwfCwn1E/F4dSZdeQjgTvCdSfkf9QNuIgtZSnD5MPl4fIyhFG9kwp4HbzFZiEdqxZnMC6oIxHJEoIu/2JsJ4SSdJe8drb5uBArpQ2o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709113511; c=relaxed/simple;
	bh=4pSWZr57aeIya65yF8XVy/6PWknPTxNF7rQM88iYU9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TjnCXfEZ++ss0+YLm9Bb29TGrAh6B5YeAdct3Z0virWdDxvoXOh+Uq6xMskKL2SV7r50ubTIplJRzw++ysir9TRrmJV8jzGUe/qxPXEMyzXFz6ZYM3KTl50tUU7F59BicHIn1aMK0ZcUAxZ8ICe2lRCTh5Mx792pezzsmzw64uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eKTeBzwJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=J682NSW/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eKTeBzwJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=J682NSW/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from localhost (unknown [10.100.12.32])
	by smtp-out1.suse.de (Postfix) with ESMTP id 3DC7F22726;
	Wed, 28 Feb 2024 09:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709113502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iv5zywVFb5GU6MYlAtRz6DCtPVeTYkIgfGK6YC2Lb4c=;
	b=eKTeBzwJUgxEf6DF9WHMYNyXSfV1pw+HGB3JzTo3qvHEhRFO21epwfFymDRfOpqXDjLOHu
	MF2rxJqKBzx3acDcfUr5ShEsKYEtI9OkbKxrXmFPiJmNoYEnuYE4/YorxK2rdWCLoCHiUJ
	bqb4F+s8DXeIvk29kg5NdKeXbVm9HNQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709113502;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iv5zywVFb5GU6MYlAtRz6DCtPVeTYkIgfGK6YC2Lb4c=;
	b=J682NSW/JH0pPZYzOGNqNb8vqdEzQr+x5fRpHW0TVfAi0+/RlDPb0KfSm0Qx1YiCz0J3Qj
	ZeFpZniH6Aasp7Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709113502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iv5zywVFb5GU6MYlAtRz6DCtPVeTYkIgfGK6YC2Lb4c=;
	b=eKTeBzwJUgxEf6DF9WHMYNyXSfV1pw+HGB3JzTo3qvHEhRFO21epwfFymDRfOpqXDjLOHu
	MF2rxJqKBzx3acDcfUr5ShEsKYEtI9OkbKxrXmFPiJmNoYEnuYE4/YorxK2rdWCLoCHiUJ
	bqb4F+s8DXeIvk29kg5NdKeXbVm9HNQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709113502;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iv5zywVFb5GU6MYlAtRz6DCtPVeTYkIgfGK6YC2Lb4c=;
	b=J682NSW/JH0pPZYzOGNqNb8vqdEzQr+x5fRpHW0TVfAi0+/RlDPb0KfSm0Qx1YiCz0J3Qj
	ZeFpZniH6Aasp7Ag==
Date: Wed, 28 Feb 2024 10:45:02 +0100
From: Jiri Bohac <jbohac@suse.cz>
To: x86@kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
	Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
	akpm@linux-foundation.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] x86: don't reserve SETUP_RNG_SEED in e820
Message-ID: <Zd8AnmZHtR4ZGpoq@dwarf.suse.cz>
References: <ZbmOjKnARGiaYBd5@dwarf.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbmOjKnARGiaYBd5@dwarf.suse.cz>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.61
X-Spamd-Result: default: False [-1.61 / 50.00];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-0.69)[-0.693];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_SPAM_SHORT(2.19)[0.729];
	 MID_RHS_MATCH_FROMTLD(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

Adding Andrew Morton - have I been sending this to the wrong people/lists?

On Tue, Feb 20, 2024 at 02:55:27PM +0100, Jiri Bohac wrote:
> SETUP_RNG_SEED in setup_data is supplied by kexec and should
> not be reserved in the e820 map.
> 
> Doing so reserves 16 bytes of RAM when booting with kexec.
> (16 bytes because data->len is zeroed by parse_setup_data so only
> sizeof(setup_data) is reserved.)
> 
> When kexec is used repeatedly, each boot adds two entries in the
> kexec-provided e820 map as the 16-byte range splits a larger
> range of usable memory. Eventually all of the 128 available entries
> get used up. The next split will result in losing usable memory
> as the new entries cannot be added to the e820 map.
> 
> Fixes: 68b8e9713c8e ("x86/setup: Use rng seeds from setup_data")
> Signed-off-by: Jiri Bohac <jbohac@suse.cz>
> ---
>  arch/x86/kernel/e820.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> index 91ade749f184..7be1362a31aa 100644
> --- a/arch/x86/kernel/e820.c
> +++ b/arch/x86/kernel/e820.c
> @@ -1018,10 +1018,12 @@ void __init e820__reserve_setup_data(void)
>  		e820__range_update(pa_data, sizeof(*data)+data->len, E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
>  
>  		/*
> -		 * SETUP_EFI and SETUP_IMA are supplied by kexec and do not need
> -		 * to be reserved.
> +		 * SETUP_EFI, SETUP_IMA and SETUP_RNG_SEED are supplied by
> +		 * kexec and do not need to be reserved.
>  		 */
> -		if (data->type != SETUP_EFI && data->type != SETUP_IMA)
> +		if (data->type != SETUP_EFI &&
> +		    data->type != SETUP_IMA &&
> +		    data->type != SETUP_RNG_SEED)
>  			e820__range_update_kexec(pa_data,
>  						 sizeof(*data) + data->len,
>  						 E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia


