Return-Path: <linux-kernel+bounces-35057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 077DA838B35
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B53F62890BB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4585A109;
	Tue, 23 Jan 2024 09:58:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1795BAFA;
	Tue, 23 Jan 2024 09:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706003922; cv=none; b=VJGYIuJ3USHACscLymRcNj6juwHjyaV7B/Nk5zyC1bMUbKe3ShfukZpEaouFjqm7URqe8hFdKYPV2RauxWWMy3Pldk1qxMyIQu8gzY7u0mLLKcwwlwKnRqFH8QGjg8E9wkroVwTHM1xUDyxDLZmQTJSHwyWd5Zqf3JlWKnr7rtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706003922; c=relaxed/simple;
	bh=nxl7RImlPHt2woc7MH+W+qg3tN0qm3GwTQesAwY6riA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/hSOVu7bV0xZosvP5mWLL+ia9aCd4gNepTPhjAYKT5L65q/jt6HQVr6zUCF1Du8FEP8R/PTbhcOeaJfCFuyFEq0SS6MfimKtfHusVD1EUSseJ4/yhEUVIhbzKBmrW/beQscVgv6XQDejUXJTbwrwQSNY070+sp3QLMjQjXcNrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7820A1FB;
	Tue, 23 Jan 2024 01:59:25 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.48.47])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E7C533F5A1;
	Tue, 23 Jan 2024 01:58:37 -0800 (PST)
Date: Tue, 23 Jan 2024 09:58:35 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Kees Cook <keescook@chromium.org>
Cc: linux-hardening@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Kalesh Singh <kaleshsingh@google.com>,
	Fuad Tabba <tabba@google.com>, Mark Brown <broonie@kernel.org>,
	"Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
	Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 40/82] arm64: stacktrace: Refactor intentional
 wrap-around test
Message-ID: <Za-NyyOP1IlQbFZg@FVFF77S0Q05N>
References: <20240122235208.work.748-kees@kernel.org>
 <20240123002814.1396804-40-keescook@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123002814.1396804-40-keescook@chromium.org>

On Mon, Jan 22, 2024 at 04:27:15PM -0800, Kees Cook wrote:
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
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Kalesh Singh <kaleshsingh@google.com>
> Cc: Fuad Tabba <tabba@google.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/arm64/include/asm/stacktrace/common.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/stacktrace/common.h b/arch/arm64/include/asm/stacktrace/common.h
> index f63dc654e545..6e0cb84961f8 100644
> --- a/arch/arm64/include/asm/stacktrace/common.h
> +++ b/arch/arm64/include/asm/stacktrace/common.h
> @@ -49,7 +49,7 @@ static inline bool stackinfo_on_stack(const struct stack_info *info,
>  	if (!info->low)
>  		return false;
>  
> -	if (sp < info->low || sp + size < sp || sp + size > info->high)
> +	if (sp < info->low || add_would_overflow(sp, size) || sp + size > info->high)
>  		return false;

This looks fine to me, so FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

>  
>  	return true;
> -- 
> 2.34.1
> 

