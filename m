Return-Path: <linux-kernel+bounces-72190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BBA85B09D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 02:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2DE81C2160B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 01:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C70A38DCC;
	Tue, 20 Feb 2024 01:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1W0cgbT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81769374DD
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 01:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708393550; cv=none; b=shiOjgXHMo21kjYw82jAOhbXpIXrRircPAktYGmvmldFLe0zlCeyc2XTwVzGEnLIhxkUT9umQDY/iG8Pf85VOasX0u+3Z63TUGzvgViSideZTKFOvo7QrRGa6lZbdgkpqIJC7vV0w5v1oei694iXDVeW2aafnN9CwUDCIJHE+/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708393550; c=relaxed/simple;
	bh=xwMhIGtEqqY2ZsJjJOtA/QlKbBot/S9r36wBtxBVccA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9/RGDwCSGGz4vg0H6tGcVxU7puBESqxIZ66iNw6turgZsb+7acdLdJFESGTEbETU5A9Dr7p9e97hjixW6sQjcADsJdzC5vwZa8W4MsjflhgRd2sKQjhWSLe+yiiPJMDHV518qLiG+fwplwjCsYsdMqQldLDlQQ4YZr3l+6cjQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1W0cgbT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EF93C433F1;
	Tue, 20 Feb 2024 01:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708393550;
	bh=xwMhIGtEqqY2ZsJjJOtA/QlKbBot/S9r36wBtxBVccA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O1W0cgbTEGgHawrTybfrqZA2h4w70iM1SEZtnjXNGPMnrpImDFWWacaxZdDvQeVpw
	 Tt2FSsPBWHrVRTCsluKvgjQVX9xG01G4hHeqhr5wvotXpT/xoxR/BtBuhVmGorB1S9
	 6JJoiQIrM7kaocCdYogkW5qw1XjN8hfeGl516L5RGjaymvfCSP/Q2YDx8Nou7dTsje
	 Fr8F1U32HoluRGf7UpFJOz0T7b6R8jAwoFZw/hoY+FHyGoU1cNvFpKQYdZuae0hSm0
	 NNrEhiFU/R3INlK/0x/LxEyv8VApX/phDuvX7ph3ZKzXY7v7L55lOyZZBFNGTFNIPZ
	 iIKEMP27yoHRA==
Date: Tue, 20 Feb 2024 09:32:43 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Yangyu Chen <cyy@cyyself.name>
Cc: linux-riscv@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Guo Ren <guoren@kernel.org>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: mm: fix NOCACHE_THEAD does not set bit[61]
 correctly
Message-ID: <ZdQBO4JetdQGecoi@xhacker>
References: <tencent_594131AD216D8DE97CCC8265DA5D8E45B808@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <tencent_594131AD216D8DE97CCC8265DA5D8E45B808@qq.com>

On Tue, Feb 20, 2024 at 12:32:09AM +0800, Yangyu Chen wrote:
> Previous commit dbfbda3bd6bf("riscv: mm: update T-Head memory type
> definitions") missed a `<` for bit shifting, result in bit[61] does not set
> in _PAGE_NOCACHE_THEAD and leaves bit[0] set instead. This patch get this
> fixed.
> 
> Link: https://lore.kernel.org/linux-riscv/20230912072510.2510-1-jszhang@kernel.org/ [1]
> 
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>

Good catch! We're lucky just because _PAGE_NOCACHE_THEAD isn't used now.

Reviewed-by: Jisheng Zhang <jszhang@kernel.org>

> ---
>  arch/riscv/include/asm/pgtable-64.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
> index b42017d76924..b99bd66107a6 100644
> --- a/arch/riscv/include/asm/pgtable-64.h
> +++ b/arch/riscv/include/asm/pgtable-64.h
> @@ -136,7 +136,7 @@ enum napot_cont_order {
>   * 10010 - IO   Strongly-ordered, Non-cacheable, Non-bufferable, Shareable, Non-trustable
>   */
>  #define _PAGE_PMA_THEAD		((1UL << 62) | (1UL << 61) | (1UL << 60))
> -#define _PAGE_NOCACHE_THEAD	((1UL < 61) | (1UL << 60))
> +#define _PAGE_NOCACHE_THEAD	((1UL << 61) | (1UL << 60))
>  #define _PAGE_IO_THEAD		((1UL << 63) | (1UL << 60))
>  #define _PAGE_MTMASK_THEAD	(_PAGE_PMA_THEAD | _PAGE_IO_THEAD | (1UL << 59))
>  
> -- 
> 2.43.0
> 

