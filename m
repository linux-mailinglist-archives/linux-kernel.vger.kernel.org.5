Return-Path: <linux-kernel+bounces-167627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 088358BAC24
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A64A1C22079
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64973152E0D;
	Fri,  3 May 2024 12:16:26 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FBA152E05
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 12:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714738586; cv=none; b=O87PDIJU8v2b37kAWbZre4zxKkX46TWqnvY8epfYNTeRxbGdYwCK8vcDOUKb40/fbAqQZw9zHe8fm0FwLVjFF8k81+tHhDaC9UYOJERCLpR+5n/y4JvqU68NQzcyhDZjZkDbnTPQuH2zMonAzpYHaCEUhg26sula91xsR8Rs+wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714738586; c=relaxed/simple;
	bh=57TzwAwwvpMQNNFqifULioJP6l9hVSPfqlNks+zZBE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AUhuTCfI2WGG+4c7Q+cwxfrlb9zS4qdFhWaVQjbqADIpk1b6801xft2QKT37JqJH+Ws0tuuNq/6WviTBteHPKy8CpoRzAyYo+V+vSU3u78GMGL5vkaf1oc0JvNI10KFPsVXk/44LRPgoxRF4XfefAzUVL5qIgA+U+lemIu/83oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id E3FA66000C;
	Fri,  3 May 2024 12:16:18 +0000 (UTC)
Message-ID: <7ebc5b28-7115-494f-a607-e46c71214cce@ghiti.fr>
Date: Fri, 3 May 2024 14:16:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: uaccess: Allow the last potential unrolled copy
Content-Language: en-US
To: Xiao Wang <xiao.w.wang@intel.com>, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc: jerry.shih@sifive.com, nick.knight@sifive.com, ajones@ventanamicro.com,
 bjorn@rivosinc.com, andy.chiu@sifive.com, viro@zeniv.linux.org.uk,
 cleger@rivosinc.com, alexghiti@rivosinc.com, haicheng.li@intel.com,
 akira.tsukamoto@gmail.com, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240313103334.4036554-1-xiao.w.wang@intel.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240313103334.4036554-1-xiao.w.wang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Xiao,

On 13/03/2024 11:33, Xiao Wang wrote:
> When the dst buffer pointer points to the last accessible aligned addr, we
> could still run another iteration of unrolled copy.
>
> Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
> ---
>   arch/riscv/lib/uaccess.S | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/lib/uaccess.S b/arch/riscv/lib/uaccess.S
> index 2e665f8f8fcc..1399d797d81b 100644
> --- a/arch/riscv/lib/uaccess.S
> +++ b/arch/riscv/lib/uaccess.S
> @@ -103,7 +103,7 @@ SYM_FUNC_START(fallback_scalar_usercopy)
>   	fixup REG_S   t4,  7*SZREG(a0), 10f
>   	addi	a0, a0, 8*SZREG
>   	addi	a1, a1, 8*SZREG
> -	bltu	a0, t0, 2b
> +	bleu	a0, t0, 2b
>   
>   	addi	t0, t0, 8*SZREG /* revert to original value */
>   	j	.Lbyte_copy_tail


I agree it is still safe to continue for another word_copy here.

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


