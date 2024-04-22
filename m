Return-Path: <linux-kernel+bounces-153155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 709CE8ACA4C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10B2C1F2331E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3916613D8B9;
	Mon, 22 Apr 2024 10:09:40 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C605450280
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 10:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713780579; cv=none; b=oRN2K4UvtZEjBn8E7dx/zG0iG6094Rtmodq+0XZyQsbArMhPnSoiWNQQQT7hLXlB59fBcLUZqmUAMCLxo5swKUV+l2GHGQ/GBT4YPYIWIGtWuDbtVDko5rEXmv0GoiOxZWDgcGDwMcWmO8aIQv17bPcy0JItjxBNFCgnL+k5Xc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713780579; c=relaxed/simple;
	bh=v8JKjP+EkUO4dWNiSEfGzuAcEHIYI5f01TttKsEYntc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oeTuKXHXeGI/4fi7quCLAbTfOd1FnV3awMvE6JFypBOUx8+NJZ0bTYieKGIwMBphWAVSYmB5Tyxraa4RSCKS0JfNx1d6Ya73ivICcSjlG8vvOl+M+I1VUprZXxnvAlZekih2tOdVeG8/pDBq0QHfreXXiIY4eQCOoL7/OdxlR2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D453BC113CC;
	Mon, 22 Apr 2024 10:09:36 +0000 (UTC)
Date: Mon, 22 Apr 2024 11:09:34 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Shiqi Liu <shiqiliu@hust.edu.cn>
Cc: will@kernel.org, broonie@kernel.org, anshuman.khandual@arm.com,
	maz@kernel.org, suzuki.poulose@arm.com, miguel.luis@oracle.com,
	joey.gouly@arm.com, oliver.upton@linux.dev, jingzhangos@google.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/sysreg: Update PIE permission encodings
Message-ID: <ZiY3Xhcg5hH5ZTB4@arm.com>
References: <20240421063328.29710-1-shiqiliu@hust.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240421063328.29710-1-shiqiliu@hust.edu.cn>

On Sun, Apr 21, 2024 at 02:33:28PM +0800, Shiqi Liu wrote:
> Fix left shift overflow issue when the parameter idx is greater than or
> equal to 8 in the calculation of perm in PIRx_ELx_PERM macro.
> 
> Fix this by modifying the encoding to use a long integer type.
> 
> Signed-off-by: Shiqi Liu <shiqiliu@hust.edu.cn>
> ---
>  arch/arm64/include/asm/sysreg.h       | 24 ++++++++++++------------
>  tools/arch/arm64/include/asm/sysreg.h | 24 ++++++++++++------------
>  2 files changed, 24 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 9e8999592f3a..af3b206fa423 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -1036,18 +1036,18 @@
>   * Permission Indirection Extension (PIE) permission encodings.
>   * Encodings with the _O suffix, have overlays applied (Permission Overlay Extension).
>   */
> -#define PIE_NONE_O	0x0
> -#define PIE_R_O		0x1
> -#define PIE_X_O		0x2
> -#define PIE_RX_O	0x3
> -#define PIE_RW_O	0x5
> -#define PIE_RWnX_O	0x6
> -#define PIE_RWX_O	0x7
> -#define PIE_R		0x8
> -#define PIE_GCS		0x9
> -#define PIE_RX		0xa
> -#define PIE_RW		0xc
> -#define PIE_RWX		0xe
> +#define PIE_NONE_O	UL(0x0)
> +#define PIE_R_O		UL(0x1)
> +#define PIE_X_O		UL(0x2)
> +#define PIE_RX_O	UL(0x3)
> +#define PIE_RW_O	UL(0x5)
> +#define PIE_RWnX_O	UL(0x6)
> +#define PIE_RWX_O	UL(0x7)
> +#define PIE_R		UL(0x8)
> +#define PIE_GCS		UL(0x9)
> +#define PIE_RX		UL(0xa)
> +#define PIE_RW		UL(0xc)
> +#define PIE_RWX		UL(0xe)
>  
>  #define PIRx_ELx_PERM(idx, perm)	((perm) << ((idx) * 4))

Thanks. That's indeed the better way to write these constants, they also
match the POE_* macros further down in this file.

Currently nothing is broken since the PIE_E0 and PIE_E1 macros are only
used in assembly where the UL() doesn't have any effect but we may
change it in the future. I'll leave it with Will to pick up.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

