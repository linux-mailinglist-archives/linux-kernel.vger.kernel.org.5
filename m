Return-Path: <linux-kernel+bounces-95334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0BA874C6C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38C5A285C31
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6A485634;
	Thu,  7 Mar 2024 10:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="qg/46i44"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E62C1CA84;
	Thu,  7 Mar 2024 10:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709807590; cv=none; b=rIvW+af4mdqT4PdzPHmr8kF3AxdxqjkXD8E8LglS9IDaY1NIFFPMj55M30RAd9kHMUYqad2yfZlw6CwwJZZfynKm29MMwEWDW0uTWY4Pl3+nOaXUbBOyyR9A6SqJ9dD3yefXmER8VkJv7NGFcSHKdf1PIVml1A/e+YGvP72bOH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709807590; c=relaxed/simple;
	bh=ZNlTKhT38L9w2ow/OTtwgahS1XjwIk25nFCjPgs4izU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SGEXoqdLi9Rs5RfNbVfj5IXYSBRnyzJPNnOVZyQVTrxUYk2YBcHcZhQgCap8twDcX1aI7SXEtLgwf9Lu44cccwJY71znTFrr+esF3kQVVrF3AfkN9x+7Pte7FTtpNQxMznNhDzak/MG0413wzVEX3xDGkq6DILdasaqPe5XOsmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=qg/46i44; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1709807585;
	bh=wMkf3YBzzlJjow/0vVDRQvuksnXHfscP5DgovGq9Jug=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=qg/46i44H7pLCx54yhzkQgWVg4qZBTTKQD/Q8Bx1IRr8kgzzhEugpAN1Y2OEGOkGa
	 oQOAWA19qY0L/SK4mQ00DydQh7P4PNpcK3IMibi3IeUjnyKgdicvq1f+/ZxQDmBuS/
	 LoGul/mSORMBJrLlhh3VqPkSPQ3tnsgZ+gH+lYI900OncOg8nfTmLTTggZlnfcpxCa
	 j5tTTxmPyzavMUc3zNNuiVVFdCM8i4cgRVATCxL7hNgvC01y1VnnbmkIgw2ATnYMes
	 W45h2k28FZndeHFogXTQFJYwTYK9CRw3VDuYH39GZmpy0vNy2jFm33252OVfCS5SN2
	 Vg/T4X/gy3Hww==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tr5H31vRTz4wbh;
	Thu,  7 Mar 2024 21:33:02 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Thomas Zimmermann <tzimmermann@suse.de>, jani.nikula@intel.com,
 naresh.kamboju@linaro.org, deller@gmx.de, npiggin@gmail.com,
 christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org,
 naveen.n.rao@linux.ibm.com
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 lkft-triage@lists.linaro.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v3 3/3] arch/powerpc: Remove <linux/fb.h> from backlight
 code
In-Reply-To: <20240306122935.10626-4-tzimmermann@suse.de>
References: <20240306122935.10626-1-tzimmermann@suse.de>
 <20240306122935.10626-4-tzimmermann@suse.de>
Date: Thu, 07 Mar 2024 21:33:00 +1100
Message-ID: <87msranxgj.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:
> Replace <linux/fb.h> with a forward declaration in <asm/backlight.h> to
> resolve an unnecessary dependency. Remove pmac_backlight_curve_lookup()
> and struct fb_info from source and header files. The function and the
> framebuffer struct are unused. No functional changes.
>
> v3:
> 	* Add Fixes tag (Christophe)
> 	* fix typos in commit message (Jani)
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: d565dd3b0824 ("[PATCH] powerpc: More via-pmu backlight fixes")
> Reviewed-by: Jani Nikula <jani.nikula@intel.com>
> ---
>  arch/powerpc/include/asm/backlight.h        |  5 ++--
>  arch/powerpc/platforms/powermac/backlight.c | 26 ---------------------
>  2 files changed, 2 insertions(+), 29 deletions(-)

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

