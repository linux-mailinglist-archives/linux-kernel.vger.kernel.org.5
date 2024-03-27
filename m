Return-Path: <linux-kernel+bounces-120415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1313088D711
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A20A1C23ED6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 07:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EA028DA5;
	Wed, 27 Mar 2024 07:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DprLV1YL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AA72561B
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 07:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711523841; cv=none; b=C4omFIpquAkU/BWuOH0ShawV7GAa79Cpi+y2sLS9VjtgcxQQG30FU+Y8Y7bcD4kNrt2nQLRy0S5e6KClGP7/aNWIoHM0ksUpwI3u2uFV5kdA6o+nxPFJsMbuXWDjJgTAB/2QJelfKSRW+z4gldYtmkekf9lyZPFrfa1dA4bmpnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711523841; c=relaxed/simple;
	bh=xyQ3ZK+hiMYuRYnTpsz6pSIKbB4/60zOWfr6MnQ/X8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wo+ovUXsuaYtFrniDrp1MwImMM9nDJ/w3oQ53zmGxdF/mGxzNwM8Ut7EXpBDKUq/5sIZrW4b3WBwDxztxvnQuWN0mVws1iX4Zif9LR9bmGzr2IqTSgXB0uz0qADfQeksPVTAsSVe5G63tgtsiG6mo9H1iUrT01uw1tFFjyqFmLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DprLV1YL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DABC6C433F1;
	Wed, 27 Mar 2024 07:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711523841;
	bh=xyQ3ZK+hiMYuRYnTpsz6pSIKbB4/60zOWfr6MnQ/X8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DprLV1YLawP0EOlRt7GxEvJwPKI3F0zNLQGKZDH7o2CYgPJm+l1Hs9/w3pEgga0Oq
	 bcmEtWTLQsQIrHiFEv4Gvuvs2aN/Yc2OrriUFNzDRqlCYx6c4Ns431RPsFiSfTgchL
	 DzXStZ1t86IcWM816wNw9G6K0XeXcqMwn2J1kb5E+3Ah53Ks+AfZ+UL5Ptl4AgAbe/
	 rPsiOpCGcdNNUTzEOBl/AXnObjgiHlxclOatbS3I5Z6cRGu5gj694fIJIyZAX9d2Z9
	 y7fC9OPF/XaIWENxEyLrqu57LbbVcRDhuSOD+aqhhFUjY2Dbg8BfVGz8eH80/RgM9B
	 lGnpP8HcyZy7A==
Date: Wed, 27 Mar 2024 15:04:05 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] riscv: Fix TASK_SIZE on 64-bit NOMMU
Message-ID: <ZgPE5e7FzB5H4MnK@xhacker>
References: <20240227003630.3634533-1-samuel.holland@sifive.com>
 <20240227003630.3634533-2-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240227003630.3634533-2-samuel.holland@sifive.com>

On Mon, Feb 26, 2024 at 04:34:46PM -0800, Samuel Holland wrote:
> On NOMMU, userspace memory can come from anywhere in physical RAM. The
> current definition of TASK_SIZE is wrong if any RAM exists above 4G,
> causing spurious failures in the userspace access routines.
> 
> Fixes: 6bd33e1ece52 ("riscv: add nommu support")
> Fixes: c3f896dcf1e4 ("mm: switch the test_vmalloc module to use __vmalloc_node")
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>

Reviewed-by: Jisheng Zhang <jszhang@kernel.org>

> ---
> 
>  arch/riscv/include/asm/pgtable.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 0c94260b5d0c..a564a39e5676 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -882,7 +882,7 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
>  #define PAGE_SHARED		__pgprot(0)
>  #define PAGE_KERNEL		__pgprot(0)
>  #define swapper_pg_dir		NULL
> -#define TASK_SIZE		0xffffffffUL
> +#define TASK_SIZE		_AC(-1, UL)
>  #define VMALLOC_START		_AC(0, UL)
>  #define VMALLOC_END		TASK_SIZE
>  
> -- 
> 2.43.0
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

