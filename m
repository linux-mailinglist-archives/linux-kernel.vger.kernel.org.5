Return-Path: <linux-kernel+bounces-167626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C498BAC1E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 712A31C2200E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDD9152E11;
	Fri,  3 May 2024 12:14:44 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B312E620
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 12:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714738484; cv=none; b=r7n+xuXy/JuZ3KwgO8l8XzRuAaPHMdEcaRjgkGAuLwp8KBluJn4lN8nTydrbJCDMyHhky5v+x3L9ZYwRHDzBS9gCOc7xagHig5FSZlYyvWiQHhfHPj680UW3ql9r/saNSQW0dM85fAlmUi8QP+0+HDmkD25eYInkXchLJy03zNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714738484; c=relaxed/simple;
	bh=6ngDTEgKxo+5a3rSwfnFVQeuP2TjbUKFSm/lkEa/4y8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=roQZ8OweqiSqHkBbOF7ycvCnPKklp3ph444B1UvfIo1nz4et1EekhZsXq1yiKvOIHR/rzOzhNPixrlESdEekz9UTz4g4T+xUrRjvswvAyGaROUq775siWgytn0+OcdtQnMF9EHW96JBhmBtEvUIbyPbHX+vTeOKB83YHgeZT+C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7CEA420012;
	Fri,  3 May 2024 12:14:35 +0000 (UTC)
Message-ID: <20798b97-fa19-46fa-abce-54f7931c9210@ghiti.fr>
Date: Fri, 3 May 2024 14:14:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: uaccess: Relax the threshold for fast path
Content-Language: en-US
To: Xiao Wang <xiao.w.wang@intel.com>, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc: jerry.shih@sifive.com, nick.knight@sifive.com, ajones@ventanamicro.com,
 bjorn@rivosinc.com, andy.chiu@sifive.com, viro@zeniv.linux.org.uk,
 cleger@rivosinc.com, alexghiti@rivosinc.com, haicheng.li@intel.com,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240313091929.4029960-1-xiao.w.wang@intel.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240313091929.4029960-1-xiao.w.wang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Xiao,

On 13/03/2024 10:19, Xiao Wang wrote:
> The bytes copy for unaligned head would cover at most SZREG-1 bytes, so
> it's better to set the threshold as >= (SZREG-1 + word_copy stride size)
> which equals to 9*SZREG-1.
>
> Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
> ---
>   arch/riscv/lib/uaccess.S | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/lib/uaccess.S b/arch/riscv/lib/uaccess.S
> index bc22c078aba8..2e665f8f8fcc 100644
> --- a/arch/riscv/lib/uaccess.S
> +++ b/arch/riscv/lib/uaccess.S
> @@ -44,7 +44,7 @@ SYM_FUNC_START(fallback_scalar_usercopy)
>   	 * Use byte copy only if too small.
>   	 * SZREG holds 4 for RV32 and 8 for RV64
>   	 */
> -	li	a3, 9*SZREG /* size must be larger than size in word_copy */
> +	li	a3, 9*SZREG-1 /* size must >= (word_copy stride + SZREG-1) */
>   	bltu	a2, a3, .Lbyte_copy_tail
>   
>   	/*


This looks good to me:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


