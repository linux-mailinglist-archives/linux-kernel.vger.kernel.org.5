Return-Path: <linux-kernel+bounces-99824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58751878DEB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 05:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFB53282829
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 04:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C3331A8F;
	Tue, 12 Mar 2024 04:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="G2IrwEVm"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9612DF84
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 04:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710218989; cv=none; b=RI1/X1BI1tSq9uYpudrglY++AerOS89pyqBHhUzGon5bznLG7M8Q+raeVas4IGhlNfqBMkN/4ofEoB0exnA/toFjnA/AAUjde+qE3FEDoocHlANjsNRBAaRIPKhga8wQr4Z2/ZlX2cWhjAyGgU9/OqPq8xJ10t+UOOyRByp22jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710218989; c=relaxed/simple;
	bh=L/tekQK+y2l7dAGQbuk7JYgMq3giwH0ptqeJSLpzEqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oSAnuq85BQ/01YHg4SJk4tcMBsE1iNXzlLjDLWZXk1977WQ2hm2Fe+UY9i+LPIPYaXZJk9tzzEHYrJX8j1K43hA1FEznp65ftHf8pXHA8adl77epd4RccI2Q+3cscXbRqOsxUgaqOoF+VM5UsUjc3FNXqBiYswKEqV4tRNEg7T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=G2IrwEVm; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-783045e88a6so314750985a.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 21:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1710218987; x=1710823787; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rIABD3xrOV6lbD0atPCna5W6iLuX8k+wmWPwoUXIcbE=;
        b=G2IrwEVm4GVbAlOmzLyZ7bmur8EuGi1ZpyfYzHWJe36ys2+oP68Tz9H8t94AlrYaxy
         g3nde9KS1kcOC3gUGWSEr/3HZqWGSRs8bBRw24QWYmSGKAHleXV6kv9zDU7nKiJ7soBQ
         OfPsBkvQEhdnKZWQVs3JtTu+5UgKlq2D0OWO9pj7XeH3nALMZ7a9C81Z4pCDGvoVBUq7
         CU993GSxb/xQshkG9WNFy+ybIQRERAFpM/9hgvlyqxUZZDXT07IWStJIZQB5FIk2BaTo
         3t06RAWJDirfShEHwOYK+u9cS6u8RPoG+5ihb3w4oAEFWDaABXN81xkY2mIpKEZcSm+8
         PaBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710218987; x=1710823787;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rIABD3xrOV6lbD0atPCna5W6iLuX8k+wmWPwoUXIcbE=;
        b=MiejObRjjhecpbia9aPi0Kc6bRJw1apUBY5ixlT3wtjTXEAwXqg/zl/1BpXUhAzf00
         JA8LLMJwGi+UE/lfP7wIfVFRunaJhlwvYguEWbEJhV0zgjlT4QXjuUvCdwfDfe1y2xBh
         Qh2519q06iwHS6PV0JJJ1fd03AYgMgd1NFs+MqjuBBCTdLM6lcLJgfz49SJQ43T0gz+O
         iDttd1GpbpKpXjkCRp+hF2+G0O1MNjYKf1aJpbqBHpQszGH4oh+EsmZ60RhNMCOlom3a
         qdVNogTIkca5pH08CcC/1jjwpD2GMLEiYMo2XRCK1c6OdhA6eqrajRBt+CBSKUe2/HkG
         w4hA==
X-Forwarded-Encrypted: i=1; AJvYcCX3Y062oxoqTewyqASFaRlqIeZ9525l9PRuB2Ki+PkHGhUHB+0qgaSt32S1lVc6VOkQi3S8uV0no6Q1GCSm2w+oDKH2hHvJy0qLhLOZ
X-Gm-Message-State: AOJu0YyClVAK28OZ5YQotGQXnnr0eRBVN1cJ5fPl8OGnZzKmz7t3op5G
	YV5Z8AaZIlwPDzg3PPk1Dj8G7GBia3MTyXuk9jQcrOz9hoVQ8LmWvxm2GF5KksA=
X-Google-Smtp-Source: AGHT+IFA/O4DSQ/zBGau35l/jeDYdumQhEHGFW7M+UkysrJ/TnlWi2Zj0tf1HE71XMAQ4yLj/76Ypg==
X-Received: by 2002:a05:620a:3b81:b0:788:2525:d2f1 with SMTP id ye1-20020a05620a3b8100b007882525d2f1mr9200241qkn.65.1710218987012;
        Mon, 11 Mar 2024 21:49:47 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.8.176])
        by smtp.gmail.com with ESMTPSA id a2-20020a05620a16c200b007887d30dbb7sm188891qkn.60.2024.03.11.21.49.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 21:49:46 -0700 (PDT)
Message-ID: <e3a0ecb1-5fb3-4330-8490-2d113a06b85e@sifive.com>
Date: Mon, 11 Mar 2024 23:49:45 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/4] riscv/barrier: tidying up barrier-related macro
Content-Language: en-US
To: Eric Chan <ericchancf@google.com>, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 conor.dooley@microchip.com, parri.andrea@gmail.com,
 emil.renner.berthing@canonical.com
References: <20240217131206.3667544-1-ericchancf@google.com>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20240217131206.3667544-1-ericchancf@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-02-17 7:12 AM, Eric Chan wrote:
> This series makes barrier-related macro more neat and clear.
> This is a follow-up to [0-3], change to multiple patches,
> for readability, create new message thread.
> 
> v5 -> v6: [PATCH 1/4] let this change to pass review by checkpatch.pl
> instead of overwriting again in [PATCH 4/4]. for [PATCH 4/4] change
> the error message example in commit message to make it more relevant
> 
> v4 -> v5: [PATCH 3/4] __atomic_acquire_fence and __atomic_release_fence
> omit-the-fence-on-uniprocessor optimization, and fix the typo of
> RISCV_RELEASE_BARRIER when spliting the patch in v3.
> 
> v3 -> v4: fix [PATCH 1/4] commit message weird line breaks and let
> [PATCH 3/4] fix the form that can pass the checking of checkpatch.pl.
> 
> v2 -> v3: split the patch into multiple patches for one problem per patch.
> Also review the changelog to make the description more precise.
> 
> v1 -> v2: makes compilation pass with allyesconfig instead of
> defconfig only, also satisfy scripts/checkpatch.pl.
> - (__asm__ __volatile__ (RISCV_FENCE_ASM(p, s) : : : "memory"))
> + ({ __asm__ __volatile__ (RISCV_FENCE_ASM(p, s) : : : "memory"); })
> 
> [0](v1/v2) https://lore.kernel.org/lkml/20240209125048.4078639-1-ericchancf@google.com/
> [1] (v3) https://lore.kernel.org/lkml/20240213142856.2416073-1-ericchancf@google.com/
> [2] (v4) https://lore.kernel.org/lkml/20240213200923.2547570-1-ericchancf@google.com/
> [4] (v5) https://lore.kernel.org/lkml/20240213223810.2595804-1-ericchancf@google.com/
> 
> Eric Chan (4):
>   riscv/barrier: Define __{mb,rmb,wmb}
>   riscv/barrier: Define RISCV_FULL_BARRIER
>   riscv/barrier: Consolidate fence definitions
>   riscv/barrier: Resolve checkpatch.pl error
> 
>  arch/riscv/include/asm/atomic.h  | 17 ++++++++---------
>  arch/riscv/include/asm/barrier.h | 21 ++++++++++-----------
>  arch/riscv/include/asm/cmpxchg.h |  5 ++---
>  arch/riscv/include/asm/fence.h   | 10 ++++++++--
>  arch/riscv/include/asm/io.h      |  8 ++++----
>  arch/riscv/include/asm/mmio.h    |  5 +++--
>  arch/riscv/include/asm/mmiowb.h  |  2 +-
>  7 files changed, 36 insertions(+), 32 deletions(-)

For the series:

Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
Tested-by: Samuel Holland <samuel.holland@sifive.com>


