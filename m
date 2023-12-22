Return-Path: <linux-kernel+bounces-9360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0C881C495
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 06:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93201B234FA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 05:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECADDD2E7;
	Fri, 22 Dec 2023 05:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DXGhLUED"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99BACA6D
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 05:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703221773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OqfvVjgk23Q9pEcYNDkISi7wtoFhc5tsFEz6pJegrco=;
	b=DXGhLUEDgol/6nPGjLPGw9Ls6BE1FGFPUpaYDWVH3iEGv/KVonV4nDybWo5PQJH9T86ctQ
	dLMKDzAgtomioTpC7SdB/BXqsgXvplQAzvWRyuojzjJ7YEq9Kr61cjrgME1Edq2f5kKMyv
	b7dKwLkyqecUQNWkwNxLKi21RB9XMuM=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-eLf-gSf4PsaT30iBgGzEkw-1; Fri, 22 Dec 2023 00:09:30 -0500
X-MC-Unique: eLf-gSf4PsaT30iBgGzEkw-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-5918dd417a3so1575498eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 21:09:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703221770; x=1703826570;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OqfvVjgk23Q9pEcYNDkISi7wtoFhc5tsFEz6pJegrco=;
        b=sNLPtimj+iH4g5Ht5G5FgR6w9SvdA96+5ALZ/aHQbLJSsdmR9gOYvHZ6oP1f0J1Ua+
         XokEIhnAcYPhTnyj7n1xou2kDHZkEgGemCkVYQTdFjeYhv1aXsG5IGzFD4LtaBrJd4oM
         nQz+kOafcfyuwKS8KrZxBVX092WrwT0NW/TcLwNokkxEJj5MfBcMz2l/dsskL88hoqaD
         OnJKr/S9ysATBpE83SLXCmDswFVinuW7mF1fUd5XDH0ffCS1qVONMw/so66YUc/qa7eX
         ON74S+4UTgTrD/kwCoDJtuoEwhtz0qDd7Zpu9IpXcuYXc8eE9vzKEm4XBv69CLUWtL+r
         FPGw==
X-Gm-Message-State: AOJu0YyHRiB4HgBh1Haa9lUI5QQAfEXeUPL9nFtgixTFIYqdYWchcZ6f
	V6u4BNZ/NxRWNSCWaZgQZxMbHnqcS1rVltz3rjwZ0cBDP1mGhk70bpE7qrC99YjAaRqn21MhBZF
	x6zCvzA0eletUMV4hXwZSsIcSRrAGj4zh
X-Received: by 2002:a05:6870:3308:b0:203:6d48:cf9f with SMTP id x8-20020a056870330800b002036d48cf9fmr837930oae.79.1703221769932;
        Thu, 21 Dec 2023 21:09:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFnhzRnwfMxESlKn2GjZrdsC2Tihmw9pKRA1Stv6KvcjY2v+RtC1tb/GabrthD4hDP+hp2Clw==
X-Received: by 2002:a05:6870:3308:b0:203:6d48:cf9f with SMTP id x8-20020a056870330800b002036d48cf9fmr837917oae.79.1703221769679;
        Thu, 21 Dec 2023 21:09:29 -0800 (PST)
Received: from localhost.localdomain ([2804:1b3:a802:7496:88a7:1b1a:a837:bebf])
        by smtp.gmail.com with ESMTPSA id e15-20020aa7824f000000b006d9879ba6besm374346pfn.170.2023.12.21.21.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 21:09:29 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: guoren@kernel.org
Cc: Leonardo Bras <leobras@redhat.com>,
	linux-kernel@vger.kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	alexghiti@rivosinc.com,
	charlie@rivosinc.com,
	xiao.w.wang@intel.com,
	david@redhat.com,
	panqinglin2020@iscas.ac.cn,
	rick.p.edgecombe@intel.com,
	willy@infradead.org,
	bjorn@rivosinc.com,
	conor.dooley@microchip.com,
	cleger@rivosinc.com,
	linux-riscv@lists.infradead.org,
	Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V2 4/4] riscv: mm: Optimize TASK_SIZE definition
Date: Fri, 22 Dec 2023 02:09:05 -0300
Message-ID: <ZYUZ8QUJxCL93Fgv@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221154702.2267684-5-guoren@kernel.org>
References: <20231221154702.2267684-1-guoren@kernel.org> <20231221154702.2267684-5-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Dec 21, 2023 at 10:47:01AM -0500, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> Unify the TASK_SIZE definition with VA_BITS for better readability.
> Add COMPAT mode user address space info in the comment.
> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
>  arch/riscv/include/asm/pgtable.h | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index e415582276ec..d165ddae3b42 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -866,6 +866,7 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
>   * Note that PGDIR_SIZE must evenly divide TASK_SIZE.
>   * Task size is:
>   * -        0x9fc00000	(~2.5GB) for RV32.
> + * -        0x80000000	(   2GB) for RV64 compat mode
>   * -      0x4000000000	( 256GB) for RV64 using SV39 mmu
>   * -    0x800000000000	( 128TB) for RV64 using SV48 mmu
>   * - 0x100000000000000	(  64PB) for RV64 using SV57 mmu
> @@ -877,11 +878,11 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
>   * Similarly for SV57, bits 63–57 must be equal to bit 56.
>   */
>  #ifdef CONFIG_64BIT
> -#define TASK_SIZE_64	(PGDIR_SIZE * PTRS_PER_PGD / 2)
> +#define TASK_SIZE_64	(UL(1) << (VA_BITS - 1))

Checked for l5, l4 and l3, and it seems a correct replacement.

>  
>  #ifdef CONFIG_COMPAT
> -#define TASK_SIZE_32	(_AC(0x80000000, UL))
> -#define TASK_SIZE	(test_thread_flag(TIF_32BIT) ? \
> +#define TASK_SIZE_32	(UL(1) << (VA_BITS_SV32 - 1))

Oh, much better. Thanks for removing the magic number :)

> +#define TASK_SIZE	(is_compat_task() ? \
>  			 TASK_SIZE_32 : TASK_SIZE_64)
>  #else
>  #define TASK_SIZE	TASK_SIZE_64
> -- 
> 2.40.1
> 

That's much more readable IMO now. Thanks!

FWIW:
Reviewed-by: Leonardo Bras <leobras@redhat.com>


