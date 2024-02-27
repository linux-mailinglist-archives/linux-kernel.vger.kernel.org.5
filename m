Return-Path: <linux-kernel+bounces-83010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1BF868CF8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71DB31F26703
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10025137C45;
	Tue, 27 Feb 2024 10:10:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96561369AB
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 10:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709028618; cv=none; b=EAZWOaxILpypKFM5qSUHEbvjdvNT77lQcIgOSA0jJFcL2zE5Onp9S95qWVHRBbaiaZF1kjhBU+6n1c2B7VG+RqXs0EzN+eDaOBgglE45auluBhUF1Jqf3OfbLF20Gt5FRq80po0HbAzeNnmkN6c/b0ARpAxteAgHu3zz7SQSN3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709028618; c=relaxed/simple;
	bh=5DeHCpzgrmkG2dRXy0tfVP5G0gRI3ljJctqxS1/EEvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BKlYHvRCGj+4DEfjCjC4Gt1/zOZCUOFdpvErwcLHZg8cwU5sRjPgIwLj11khTsaSrdf7vmt5qt45a95IHAsni+BmzjjjjwFY8p2UZWMYV97y+NjBtTQ3Rz6nxai+p9/wTUr7SJJHYF0Y0/BrD6s83fURXN8UXQAxnqMVoa4Rzc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7124FDA7;
	Tue, 27 Feb 2024 02:10:53 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.79.110])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 805E83F762;
	Tue, 27 Feb 2024 02:10:13 -0800 (PST)
Date: Tue, 27 Feb 2024 10:10:09 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: takakura@valinux.co.jp
Cc: catalin.marinas@arm.com, will@kernel.org, ardb@kernel.org,
	rmk+kernel@armlinux.org.uk, Jonathan.Cameron@huawei.com,
	gregkh@linuxfoundation.org, james.morse@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/kernel/setup: Update comment on interrupt masking
Message-ID: <Zd21AaRO_JGLFo78@FVFF77S0Q05N>
References: <20240225021812.4834-1-takakura@valinux.co.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240225021812.4834-1-takakura@valinux.co.jp>

On Sun, Feb 25, 2024 at 11:18:12AM +0900, takakura@valinux.co.jp wrote:
> From: Ryo Takakura <takakura@valinux.co.jp>
> 
> DAIF_PROCCTX_NOIRQ contains FIQ bit.
> Update the comment as only asynchronous aborts are unmasked
> and FIQ is still masked.
> 
> Signed-off-by: Ryo Takakura <takakura@valinux.co.jp>
> ---
>  arch/arm64/kernel/setup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 0ea45b6d0177..9b9fdb64c684 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -298,7 +298,7 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
>  	dynamic_scs_init();
>  
>  	/*
> -	 * Unmask asynchronous aborts and fiq after bringing up possible
> +	 * Unmask asynchronous aborts after bringing up possible
>  	 * earlycon. (Report possible System Errors once we can report this
>  	 * occurred).
>  	 */

I think we can further simplify/clarify that as:

	/*
	 * Unmask SError as soon as possible after initializing earlycon so
	 * that we can report any SErrors immediately.
	 */

With that wording:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

