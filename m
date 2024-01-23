Return-Path: <linux-kernel+bounces-35053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1507B838B1E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2F84288D1B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0584C5A108;
	Tue, 23 Jan 2024 09:56:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420355C8E2;
	Tue, 23 Jan 2024 09:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706003789; cv=none; b=rhT6MbEkQtXAJoThkEqRd415xbs6M+2LgMcQgnJuB66O7VCRvbWa8oH00X5R8Ndvuey9qzjokNuRmV2a/jfZ7bGvWxCeFk8QEwkGv5HOjx1TimA0T7wsIMZ0E0RpaLmGoxFa8EueI9cl5VX67/0zyKfFI3zuqAlrH/G3uhcMCEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706003789; c=relaxed/simple;
	bh=M9SACN960vZSXDXbLdUBVI/WCfjWRLjA6ZN/WSkmheY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBnl2UmJR89IM9MeyFDGJaYXENCWP8EjtkxCA96rHFVDndGH/UAm0lMbUpQp4I7btJml9WYoLBKoFjk3OtYyj1iAKqzEeAdXsnGBd80XOUez0JpSBsKBScdBwjDMRRp0+xuLGZ1q1nxctouHQyEbQdjini66qPWHiQUlclHwIic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 036851FB;
	Tue, 23 Jan 2024 01:57:12 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.48.47])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 472FA3F5A1;
	Tue, 23 Jan 2024 01:56:25 -0800 (PST)
Date: Tue, 23 Jan 2024 09:56:22 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Kees Cook <keescook@chromium.org>
Cc: linux-hardening@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 38/82] arm: 3117/1: Refactor intentional wrap-around test
Message-ID: <Za-NRm5e_-Cfz1Nl@FVFF77S0Q05N>
References: <20240122235208.work.748-kees@kernel.org>
 <20240123002814.1396804-38-keescook@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123002814.1396804-38-keescook@chromium.org>

The commit title is odd here; '3117/1' is the patch tracker name for the last
patch. The title should probably be:

	arm: nwfpe: Refactor intentional wrap-around test

Mark.

On Mon, Jan 22, 2024 at 04:27:13PM -0800, Kees Cook wrote:
> In an effort to separate intentional arithmetic wrap-around from
> unexpected wrap-around, we need to refactor places that depend on this
> kind of math. One of the most common code patterns of this is:
> 
> 	VAR + value < VAR
> 
> Notably, this is considered "undefined behavior" for signed and pointer
> types, which the kernel works around by using the -fno-strict-overflow
> option in the build[1] (which used to just be -fwrapv). Regardless, we
> want to get the kernel source to the position where we can meaningfully
> instrument arithmetic wrap-around conditions and catch them when they
> are unexpected, regardless of whether they are signed[2], unsigned[3],
> or pointer[4] types.
> 
> Refactor open-coded wrap-around addition test to use add_would_overflow().
> This paves the way to enabling the wrap-around sanitizers in the future.
> 
> Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
> Link: https://github.com/KSPP/linux/issues/26 [2]
> Link: https://github.com/KSPP/linux/issues/27 [3]
> Link: https://github.com/KSPP/linux/issues/344 [4]
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/arm/nwfpe/softfloat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/nwfpe/softfloat.c b/arch/arm/nwfpe/softfloat.c
> index ffa6b438786b..0635b1eda1d3 100644
> --- a/arch/arm/nwfpe/softfloat.c
> +++ b/arch/arm/nwfpe/softfloat.c
> @@ -603,7 +603,7 @@ static floatx80
>      roundBits = zSig0 & roundMask;
>      if ( 0x7FFD <= (bits32) ( zExp - 1 ) ) {
>          if (    ( 0x7FFE < zExp )
> -             || ( ( zExp == 0x7FFE ) && ( zSig0 + roundIncrement < zSig0 ) )
> +             || ( ( zExp == 0x7FFE ) && (add_would_overflow(zSig0, roundIncrement)) )
>             ) {
>              goto overflow;
>          }
> -- 
> 2.34.1
> 
> 

