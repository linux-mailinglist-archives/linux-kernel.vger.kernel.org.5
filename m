Return-Path: <linux-kernel+bounces-117477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F8E88ABD3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D14129BB65
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4670373163;
	Mon, 25 Mar 2024 16:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="X+JgVXgo"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DF84317B
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 16:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711384445; cv=none; b=Q/B/6dUvwpVceuNCTTzpTgeTolTunAUtggstX2v2NOiLjcVQ6zDyY2LmGWoeHeaWWyyF7JGD3VvSQ53MKsbyp/fTv6GEC3YnEcXOhl07b/W5uNI0SZrTjLrzbRecoU7NT4HoBVnBIeGQZS/0OjaNC+/hl1FrVFADAoJ8NKzkMzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711384445; c=relaxed/simple;
	bh=r5bsz4eWfEjrlCLnfJZSj8qdTSOM4vDr814LrUPHfkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=imotVCnlDnmMWi1wO3R2VjgMFVQHs4LeugaeHmuzhHzc6hyEQtR7TIJPbttlOEXvjNMrjj6ogfzTS1FgwTkMoG/OCpDTr1aheKkEAiLlEMqSuFsUTsigOEFX5G7UOn0v9QJxiB+FFQ4dYmgg8iutZG6yj2BBiIvv8TUNavPsNAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=X+JgVXgo; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C08B540E02A5;
	Mon, 25 Mar 2024 16:34:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id wiJf6WFNVAJy; Mon, 25 Mar 2024 16:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1711384437; bh=HXMuRH0/0L3hy88yC35JI4AqWxDy4+d9cctRzhY/F6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X+JgVXgoZM+fjCWf+TsjCGUjfdlLy/98Zjui34Pao8XB3Mw/uNWb41KhZNGT4PsOJ
	 PM/v0mhvtefmc6RHemcOG99qgnJo1TaebZEmpG73Wm0uGXHRzt60N85JHNsPCF4bsf
	 kwliCdlLmEEOl0lx22SHEl5kLbbfmpalq6zaLYMoChTOsIu+nyrsw4r7YbEtELdhur
	 p356DfAEh6DxSmQbqq1eAHwgITAWXcrcScxNWp06E2PRxPzVccsijzIEDB5XKplg59
	 AMvRQiIDMBiKdCiSCjgofq+ZTeWl5UxFsXPATttRR93uX52EBFi+pWVf+A9aXkj+1h
	 Vs5XlDBMgWSbJzEw82wAgslVIVUywSE8v/yJLJNHlG+oPDauSzwKeo+cJ94KXfavwz
	 TFgaEvzt9U0GVGGSSHqHbk7+gshzQIEiE6p8fJ5AtF8TQhXB3uC2/zACOAiV8eRaUA
	 aIPgcRuVWTa6S2rRovdtxc2nr3/8z8exAdDTcz7VNwpZBduj57qf635jeZexOGK+9y
	 +5GqVBQIcr51R7E07GNA5/uil8z5nM4bRLxEKUXto9bhSxZXiAe6Pw2v11sMJ6bAan
	 Xx01R+9LQqc7paA4KnzJdy1X7wc1D2oqLtoS33oWje/2S+d0NonTBmuNUxQkPQBqoM
	 TZvEEnLvaG5g2PEbha0bWjV8=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1407540E02A2;
	Mon, 25 Mar 2024 16:33:48 +0000 (UTC)
Date: Mon, 25 Mar 2024 17:33:42 +0100
From: Borislav Petkov <bp@alien8.de>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org, ville.syrjala@linux.intel.com,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	lkml <linux-kernel@vger.kernel.org>
Subject: Re: BUG: sleeping function called from invalid context at
 drivers/gpu/drm/i915/gem/i915_gem_pages.c:526
Message-ID: <20240325163342.GEZgGnZpROSN4euuLb@fat_crate.local>
References: <20240227100342.GAZd2zfmYcPS_SndtO@fat_crate.local>
 <87jzmqjir5.fsf@intel.com>
 <20240227105356.GBZd2_RL9hjC_LupZB@fat_crate.local>
 <87h6hujhrz.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87h6hujhrz.fsf@intel.com>

On Tue, Feb 27, 2024 at 12:58:08PM +0200, Jani Nikula wrote:
> Let's see what Ville says, but in the end bisection might be the
> quickest way to find the regression. Though I understand it can be
> tedious for you personally.

That still fires with 6.-9-rc1. Does Ville have any suggestions or
should I bisect?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

