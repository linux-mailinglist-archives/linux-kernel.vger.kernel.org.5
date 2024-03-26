Return-Path: <linux-kernel+bounces-120120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAFD88D29C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 00:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C4501F63A14
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A704A13DDAC;
	Tue, 26 Mar 2024 23:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7egcuOy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE86FF4E2;
	Tue, 26 Mar 2024 23:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711494314; cv=none; b=i/pbrD1SceEdUD3gztumDDi5U1hllhXZ+ch2Rb1Uhhpc1WgGyKDsfBJ3G6bHTzLn/hUmdL5SYEK4AavpmiC+5bVN/+YsSpUYz1fIyzOuK6+iKDxigjIrfCu0lMVx32tkidCOpFsVq2QWh4bFC7DDyYH6j2iTwNCLrd0TWxPUNdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711494314; c=relaxed/simple;
	bh=kPs0n7s9RGFewXWD3jJW3srjuYgF49+C9LMbEpbs33Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u1DB/AMEQYNNM/rbrt8PP/G0Vnjaa6aJ0vmnLJKHr7o5u02hST1f4d4Cx/VjPtPrFIR2gz7rKLdlV67dQN63h6RoS4U80QjQYRQDruCWBycl26ov9BV5Ti9Gp8FSyggYBdXkNl9aKSJ5R9QDbfL7lVXGfKiz2vFsilQdQZNUDpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7egcuOy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4162C433F1;
	Tue, 26 Mar 2024 23:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711494313;
	bh=kPs0n7s9RGFewXWD3jJW3srjuYgF49+C9LMbEpbs33Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R7egcuOyeUTcDqRnRs3hibT1y6j9Vn7nDQ3OnDOSqkJHcVEhTqgIt8dGz5VrnMUAy
	 N0ZYvYMjLHN5HMNfC2pTu/p6bIQmQMhQO2QlzYeu+f65C3YuCbFKZEdOEmJJaEpKZ2
	 cGWdbHszIUiaayLk7xGfX/ao3Af17u8idSHKjjcQX//nM0anlFf+If6LqHVUWZjcVQ
	 xijNKn5VceC4T3rzZobqZSIZTrdK9Xd3gtplatC/AUQ3NpAJqZTPhQXVpElwaVYser
	 jCJMJyBAejVvQU7VD5Imq1YJzjvwEhS6JLhkFAmOSSiZLku1WqHNfKP2+cT8aaBth0
	 OhxyN26gLfp1g==
Date: Tue, 26 Mar 2024 16:05:11 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: llvm@lists.linux.dev, Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] surface3_power: avoid format string truncation
 warning
Message-ID: <20240326230511.GA2796782@dev-arch.thelio-3990X>
References: <20240326223825.4084412-1-arnd@kernel.org>
 <20240326223825.4084412-6-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326223825.4084412-6-arnd@kernel.org>

On Tue, Mar 26, 2024 at 11:38:04PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> clang warns about printing a pair of escaped strings into a buffer that is
> too short:
> 
> drivers/platform/surface/surface3_power.c:248:3: error: 'snprintf' will always be truncated; specified size is 10, but format string expands to at least 12 [-Werror,-Wformat-truncation-non-kprintf]
>   248 |                 snprintf(bix->serial, ARRAY_SIZE(bix->serial), "%3pE%6pE", buf + 7, buf);
>       |                 ^
> 
> Change the format string two print two less bytes so it always fits. The string
> is still truncated, so there is no change in behavior, but the compiler no
> longer warns about it.
> 
> Fixes: 85f7582cd484 ("platform/surface: Move Surface 3 Power OpRegion driver to platform/surface")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Not entirely sure about this one, as I've never used escaped strings, and
> don't know if gcc is correct to warn here, or if the kernel defines it
> differently from the standard.

As far as I understand it, this is a false positive because clang does
not understand the kernel's %p extensions. GCC does not warn for
overflow or truncation when %p is involved but the clang developers
chose to intentionally deviate from GCC in that aspect while sticking it
under a separate diagnostic that we could disable. I sent a patch that
did so some time ago but I guess Masahiro never applied it...

https://lore.kernel.org/20231002-disable-wformat-truncation-overflow-non-kprintf-v1-1-35179205c8d9@kernel.org/

Consider dropping the changes that fix non-kprintf warnings and
including that patch as part of this series.

> ---
>  drivers/platform/surface/surface3_power.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/surface/surface3_power.c b/drivers/platform/surface/surface3_power.c
> index 4c0f92562a79..72f904761fde 100644
> --- a/drivers/platform/surface/surface3_power.c
> +++ b/drivers/platform/surface/surface3_power.c
> @@ -245,7 +245,7 @@ static int mshw0011_bix(struct mshw0011_data *cdata, struct bix *bix)
>  		dev_err(&client->dev, "Error reading serial no: %d\n", ret);
>  		return ret;
>  	} else {
> -		snprintf(bix->serial, ARRAY_SIZE(bix->serial), "%3pE%6pE", buf + 7, buf);
> +		snprintf(bix->serial, ARRAY_SIZE(bix->serial), "%3pE%4pE", buf + 7, buf);
>  	}
>  
>  	/* get cycle count */
> -- 
> 2.39.2
> 

