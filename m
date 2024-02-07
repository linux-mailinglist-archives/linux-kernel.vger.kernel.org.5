Return-Path: <linux-kernel+bounces-56982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 344C684D235
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 20:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3404E1C22E98
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1BB82D97;
	Wed,  7 Feb 2024 19:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="hxq+xGRc"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E720340BE5
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 19:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707333840; cv=none; b=gCJ+p4j5Wja1MTFfhQp3LA5zeIRahc5QFK7UXQaDG5K9hVhaIFE0rp+fh9MwiltHYbw8nmRdc2CgtqwwGZvLLsWEgGH9KkIt1FMbFr6NkmbtFjnv1/YSRl0s5Sctwjs/fDSowh833YNrFLkqoivysB4TXmbJ51Q4c9P/UJ97Gfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707333840; c=relaxed/simple;
	bh=vVP9+4bMTGUVEI7wClHTNeWpJAl3MhpB/Uhdm13l9a0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=ae9QKazuruieq84FffemsS5iPQVJ2c0aEZqm1KBEd4lNFzM7i5SuYcamlpXrsR1jcf3duJPC27sAPx9B8FSCwivTBlNZutAyEli7R3YZVHm3E9Apqkos8l0dElStronr4GA2/IU2B0BSY8pNL+IzSlfhlpdnWYNXhtVKpTOlddY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=hxq+xGRc; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-42a9f4935a6so1342621cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 11:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1707333838; x=1707938638; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lRrpZ4A7adNY9DTQi8mLdXm1HAB9Tl2AxirgbrNvbSc=;
        b=hxq+xGRcQfrfy3QEYJ1UQzpxvkZODDkEpYTlc9IWSpRQP+Rh1d0vNPSC/UB2wnrAhb
         PDsI9nDNyFIvMtH+qsFlHdmRJSOJM0o9TKE1r+LMCTEvHrT9BIaYBFe6ChQdY82cyibE
         sBKXUjTM3kODDSRwQYX03UHdmLNZ25eOC+0PEZsKk9oH8HpWg9ZdJrJI538/BqhT0Vlx
         JxlBgocOQNyPtGW4CrxB8Mf+d71isi2oILddaJ1OZ/RRmMwLYrm9KczcIGeFm/8pTucf
         LA59QJc+ohix5FNrXodqrR/LQC3S/WM6MruRKC6+VBq6dEL6wJsIO2Ojx9Vz/QcpXLbA
         jkuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707333838; x=1707938638;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lRrpZ4A7adNY9DTQi8mLdXm1HAB9Tl2AxirgbrNvbSc=;
        b=eYyQkXqpJvFDbe88SPQF0TR8EDYx6DOPxpsoXBSa6S6bVjHiYPaHzs5DSgFqXiJCHJ
         zLyAeSLBoGg7CTpKHPbHZjE1LAlsxiqcOgxzzYAO24z2TfZpV+luXPyp1M55uMJCfn5I
         3j8wV3RV4wsJtUiPsPI7Ad7yhvqZsGeDEZpYdh2zC++8zRrTApyFgGqEAgY9FCBGs/q3
         y+NAbaRZiuB4slTqQWXGdLpxcVTXozPFdbg5GI10lFTL5GlCDYaCoXqYFbHGSLVz56ek
         mCK3L/DK9zPaLzw6LTWorj6oq/yh+mPJtjthpcs5+lQLxoBTbx7b8MQtAzi4IgQrv1bN
         fKwA==
X-Forwarded-Encrypted: i=1; AJvYcCVl1Rxw9kXSU0VXRNsHEwsMtwrFRkCDvd/d27/qtX3ilX6cEnfmznFuy/X1T6RRWQTGzPQ6SQZ8hapdOkXFxcT7mznsH9ViIrUMky/k
X-Gm-Message-State: AOJu0Yxvm+mOTnTAbS8TaOdCGK+Gh1blDIzvPHhfC9sBGd6OSrTNp9AT
	MpzmYcsmC5z2X4jU1cQjN6qQBmiSzGF/NeolK8U6ffOxyC5mXFopzwpK+N2N4y8=
X-Google-Smtp-Source: AGHT+IHPhabZVoyg+PaGyiXwFczOGRFN7wWZjq42Zif6CdgbYaC7rgdwdLbbO0UEq9gekiEFJ6F9Gw==
X-Received: by 2002:a05:622a:14cd:b0:42c:14c2:bff3 with SMTP id u13-20020a05622a14cd00b0042c14c2bff3mr763674qtx.3.1707333837841;
        Wed, 07 Feb 2024 11:23:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXvGkEeWfyuyC+/wI+zPl0SzRwLoYhn+vcYjRxOL1PRJI26g+eg/OzjiDYYNASDYrjSHOsnAEWWc9k0dpxy/7d2fLMV6x0RWHiQgaiJmrhSP5Ed4uDYM+DYKKUW/hEiA6NtLqJ4bvLsAgorZ7hVKBOxGu6IMk7vXZ0bpj45sVLiiB+0ohUpI6qRSLS0r9R6iXEUAXvQZhdPB8lKeGQUfoXko8Ydi/7OugvKnDgx
Received: from [100.64.0.1] ([170.85.8.192])
        by smtp.gmail.com with ESMTPSA id o12-20020ac8428c000000b0042c00beee84sm785444qtl.43.2024.02.07.11.23.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 11:23:57 -0800 (PST)
Message-ID: <a21e4253-9ef6-4c44-917c-02742440d192@sifive.com>
Date: Wed, 7 Feb 2024 13:23:55 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -fixes] riscv: Fix arch_tlbbatch_flush() by clearing the
 batch cpumask
Content-Language: en-US
To: Alexandre Ghiti <alexghiti@rivosinc.com>
References: <20240130115508.105386-1-alexghiti@rivosinc.com>
From: Samuel Holland <samuel.holland@sifive.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Jisheng Zhang <jszhang@kernel.org>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240130115508.105386-1-alexghiti@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Alex,

On 2024-01-30 5:55 AM, Alexandre Ghiti wrote:
> We must clear the cpumask once we have flushed the batch, otherwise cpus
> get accumulated and we end sending IPIs to more cpus than needed.
> 
> Fixes: 54d7431af73e ("riscv: Add support for BATCHED_UNMAP_TLB_FLUSH")
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/mm/tlbflush.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> index 99c3e037f127..c8efc3f87a0f 100644
> --- a/arch/riscv/mm/tlbflush.c
> +++ b/arch/riscv/mm/tlbflush.c
> @@ -240,4 +240,5 @@ void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
>  {
>  	__flush_tlb_range(NULL, &batch->cpumask,
>  			  0, FLUSH_TLB_MAX_SIZE, PAGE_SIZE);
> +	cpumask_clear(&batch->cpumask);
>  }

This patch doesn't apply to fixes -- it looks like it was based on "riscv: Call
secondary mmu notifier when flushing the tlb"[1], which has not been merged and
would go in for-next anyway. Otherwise:

Reviewed-by: Samuel Holland <samuel.holland@sifive.com>

[1]: https://lore.kernel.org/all/20240124080325.2324462-1-alexghiti@rivosinc.com/


