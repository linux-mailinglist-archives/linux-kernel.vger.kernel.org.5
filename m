Return-Path: <linux-kernel+bounces-25817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBB382D644
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDFB0B21228
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BCE2BAE7;
	Mon, 15 Jan 2024 09:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ip6EgncI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4322BAE0
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 09:45:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AD4DC433C7;
	Mon, 15 Jan 2024 09:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705311911;
	bh=9TfclVxenwhLNqqbdWKDJ6r7w6xibtjyrmpBf389HBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ip6EgncIonnMjh4DWPhEZNCM9CBa6b26cayPDOiKD1GdFdIxUVfTWSYtYD30rv8E6
	 1T6lBUoykAvfmpXP6wRDCEcSxYlMKPWjAzLnlkh2qjfJf2wFLYBO/wizlJVnI2XUNy
	 zBScSjHfZytimxRZBeNA6QxHqx0fW2dggJYZVzCD5mIVXU1zBhE/JCryjI/o02vhMt
	 h0m3JQGLg0L0xQCGQPhE6MA4jCN/duW0N7FCBSmkX/FJa6k929yQnX7P4EgAH0dSWu
	 JRkP4pSZmJwoegcc6yGFoh7QVDMAd4tGjzzlZo01tBo97mZSGA2Lh90cNrDKP3BJZm
	 N1L+pnBnRU2+A==
Date: Mon, 15 Jan 2024 17:32:20 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH v2] riscv: select ARCH_HAS_FAST_MULTIPLIER
Message-ID: <ZaT7pNjWS3faGjv9@xhacker>
References: <20231202135202.4071-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231202135202.4071-1-jszhang@kernel.org>

On Sat, Dec 02, 2023 at 09:52:02PM +0800, Jisheng Zhang wrote:
> Currently, riscv linux requires at least IMA, so all platforms have a
> multiplier. And I assume the 'mul' efficiency is comparable or better
> than a sequence of five or so register-dependent arithmetic
> instructions. Select ARCH_HAS_FAST_MULTIPLIER to get slightly nicer
> codegen. Refer to commit f9b4192923fa ("[PATCH] bitops: hweight()
> speedup") for more details.
> 
> In a simple benchmark test calling hweight64() in a loop, it got:
> about 14% performance improvement on JH7110, tested on Milkv Mars.
> 
> about 23% performance improvement on TH1520 and SG2042, tested on
> Sipeed LPI4A and SG2042 platform.
> 
> a slight performance drop on CV1800B, tested on milkv duo. Among all
> riscv platforms in my hands, this is the only one which sees a slight
> performance drop. It means the 'mul' isn't quick enough. However, the
> situation exists on x86 too, for example, P4 doesn't have fast
> integer multiplies as said in the above commit, x86 also selects
> ARCH_HAS_FAST_MULTIPLIER. So let's select ARCH_HAS_FAST_MULTIPLIER
> which can benefit almost riscv platforms.
> 
> Samuel also provided some performance numbers:
> On Unmatched: 20% speedup for __sw_hweight32 and 30% speedup for
> __sw_hweight64.
> On D1: 8% speedup for __sw_hweight32 and 8% slowdown for
> __sw_hweight64.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
> Tested-by: Samuel Holland <samuel.holland@sifive.com>

Hi @Palmer,

I saw this simple patch is missed in your for-next tree, could you
please pick it up?

Thanks in advance

> ---
> 
> since v1:
>  - fix typo in commit msg
>  - add some performance numbers provided by Samuel
>  - collect Reviewed-by and Tested-by tag
> 
>  arch/riscv/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 95a2a06acc6a..e4834fa76417 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -23,6 +23,7 @@ config RISCV
>  	select ARCH_HAS_DEBUG_VIRTUAL if MMU
>  	select ARCH_HAS_DEBUG_VM_PGTABLE
>  	select ARCH_HAS_DEBUG_WX
> +	select ARCH_HAS_FAST_MULTIPLIER
>  	select ARCH_HAS_FORTIFY_SOURCE
>  	select ARCH_HAS_GCOV_PROFILE_ALL
>  	select ARCH_HAS_GIGANTIC_PAGE
> -- 
> 2.42.0
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

