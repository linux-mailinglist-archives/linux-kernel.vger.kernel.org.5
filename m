Return-Path: <linux-kernel+bounces-48930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 391FE84634F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC9A71F21DA3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22A63FE48;
	Thu,  1 Feb 2024 22:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJwm95ir"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B983FE27;
	Thu,  1 Feb 2024 22:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706825817; cv=none; b=q4OS3Gp3AfWBtExEPTQ44sobCLX4w/cTT+Rfu/o2hZp+g3+p6miUM55R8Og7yKIxVa5c4Upg7/3+SKf6RbXW9SmQEKemGKIuG2+A3RzCvaoVsk3/4G/BQRpD5wVRxP1qzLARtvJxcGfeSbqscI6xQOvvplUbFHjvYjIPK8cEs1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706825817; c=relaxed/simple;
	bh=cuWu+ZnwEeDB3jYUYTTRe0UH9c6SmZiHQzhLc1hdnYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xkf+h+klXWk0a9dr0SR6e0iKdrvq4193agVKeVgwE/8wEC27FlkVCI1qkX5ZXUUyUys06aGjnbGUeKJZ6cRC/LbVNnAIacYqVYJNIWwJHWC7EJj5twndC8KmXQy12Ql6YqmsBMaNpwjzNJDgH1iQq544z9DPPqjqDQ0145HAR1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJwm95ir; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE52C433C7;
	Thu,  1 Feb 2024 22:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706825816;
	bh=cuWu+ZnwEeDB3jYUYTTRe0UH9c6SmZiHQzhLc1hdnYM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iJwm95iredNZf01FKKqw1K8Cve6weFz5cAOoDZKVoWe3PpexUzoGPjJafD2pGbkGw
	 eSEIrmo/GHdvyOSQ8oqaYHJagePer7h4jeWCFcLzrdSiR+NZQtF7X69fr3fBc2bo9d
	 kulDLY8Kb43B7O9lIfuaOA8dxbgBM141x3/9YfJtOJ2uDaMN1G13Dk//xj7FQkbrEQ
	 PXKTFsXVU0Tcv4J3fY2V5w4Lglh/CMUI8bgD307AaufIO7S6Stan4GILuEx+9xRapX
	 742IhYAMMkBEGPl9+wv/uNc3ltlBirIMVY5YaxuoWdmIcNDXOjJeSG1SzUHPwX0Smm
	 BVgzx6ULRUBhQ==
Date: Thu, 1 Feb 2024 15:16:54 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, Mike Isely <isely@pobox.com>,
	Tiffany Lin <tiffany.lin@mediatek.com>,
	Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
	Yunfei Dong <yunfei.dong@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 3/3] media: mediatek: vcodedc: Fix
 Wcast-function-type-strict warnings
Message-ID: <20240201221654.GC2240065@dev-arch.thelio-3990X>
References: <20240128-fix-clang-warnings-v1-0-1d946013a421@chromium.org>
 <20240128-fix-clang-warnings-v1-3-1d946013a421@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240128-fix-clang-warnings-v1-3-1d946013a421@chromium.org>

On Sun, Jan 28, 2024 at 02:12:22AM +0000, Ricardo Ribalda wrote:
> Building with LLVM=1 throws the following warning:
> drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c:38:32: warning: cast from 'mtk_vcodec_ipi_handler' (aka 'void (*)(void *, unsigned int, void *)') to 'ipi_handler_t' (aka 'void (*)(const void *, unsigned int, void *)') converts to incompatible function type [-Wcast-function-type-strict]
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

I am not positive because I don't have any hardware to test this driver
but I suspect this patch is just hiding the warning without actually
addressing the issue that it is pointing out. If handler is called
through vpu_ipi_register() indirectly (which it obviously is if it is
being passed down), there will be a CFI failure because the type of
mtk_vcodec_ipi_handler is not the same as ipi_handler_t, as the comment
mentions.

Has this seen testing on real hardware with kCFI?

> ---
>  drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c
> index 9f6e4b59455d..781a0359afdc 100644
> --- a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c
> +++ b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c
> @@ -33,9 +33,11 @@ static int mtk_vcodec_vpu_set_ipi_register(struct mtk_vcodec_fw *fw, int id,
>  	 * The handler we receive takes a void * as its first argument. We
>  	 * cannot change this because it needs to be passed down to the rproc
>  	 * subsystem when SCP is used. VPU takes a const argument, which is
> -	 * more constrained, so the conversion below is safe.
> +	 * more constrained, so the conversion below is safe. We use the void
> +	 * casting, to convince clang with -Wcast-function-type-sctrict that
> +	 * this is safe.
>  	 */
> -	ipi_handler_t handler_const = (ipi_handler_t)handler;
> +	ipi_handler_t handler_const = (ipi_handler_t)((void *)handler);
>  
>  	return vpu_ipi_register(fw->pdev, id, handler_const, name, priv);
>  }
> 
> -- 
> 2.43.0.429.g432eaa2c6b-goog
> 

