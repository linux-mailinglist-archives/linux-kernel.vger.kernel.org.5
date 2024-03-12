Return-Path: <linux-kernel+bounces-100624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F876879AEA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DECA8B2246E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA221386D8;
	Tue, 12 Mar 2024 18:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="WkIHAllg"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AED1386C5
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 18:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710266557; cv=none; b=U8AjgjWdDnepPnQsM+loCEvrHe8O460auXnVxJx9xFiNPyKqaQzwKORaBrEbjrKnLm8mU8bHqiafzN61t8VP1pN/d+jd3WG8bO3yagnMwfGCmOt1yVGvgSKXgQOn7CUCbAroluy/SqyVik7hpTpup2Ze+ztfozhXAO59CxPMCY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710266557; c=relaxed/simple;
	bh=VtJmkV1W328QdDaNC3nKeo92oo5V81RByr7bcMx5Ocg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cO1cFLRZk3EmdnXp3gnVs93R3nZed87cgNSivO7/bq7xc3Z/I2PzwpLJV5awKYUZg48snKN4m1LmA8gniMuqTHgZELa5Kj8U7vmeNrGWIl6gcCSs/g1SIq8jUB1xfaZWPMEvjDEh1fen3EyCbF50hdv+UQpjiQJOZS/v7sC9glE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=WkIHAllg; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-783045e88a6so362696485a.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 11:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1710266555; x=1710871355; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5fp2CwN+FAZAIX1xWy/mV9+4b7wUyvhy5cC3rL2qsNo=;
        b=WkIHAllgeyTl3SZQKq+b5rEY4HhLuu6+kEU9AabQKp/hXfUVB+P8rp7w3ONwWpfYFM
         DyLYwleDrzFCS3D9YmIx/3fjffPw6nfps1OCbRxIHG07X/j+sMgpY6Ag9duLVW1pM1Rb
         /DpMraKAzNIFY5id+etWtdVGIeqxc0eQSKUFOHI8uilAMZhdT+CvQEdCUzjVPlEI7aIj
         QwKzDrGRNkYn0xuh3MvZCk3kpB9xPEMokDxRs4TSWlF+i68xYirkibAOW62naFETjmJF
         7L6lvReuRjHndbWA/kNUubln+ddN3k6mxJABrxiglP8A+WQs0eX5B1savv3/gghJwMg2
         zxUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710266555; x=1710871355;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5fp2CwN+FAZAIX1xWy/mV9+4b7wUyvhy5cC3rL2qsNo=;
        b=P8kbAMS1svnvA0u2FJc9O3M8rmPrbOUPnpFurIEk5048HoQNUyV6W6atTQdFhvvYQl
         LxTVdHFDb7nMpHKqg8e1fex82tKd5xWQL1FhK+ZyzfwBFVeaDirA4MYNwp1f6BQWgxAD
         4pdRFjUZca3Q3PRSDkTUb6aAv7DZKTA8bMumgwdfIKMgqQK4Nv3zfKVaDb4tXaNfBgBz
         sJfPqLLqa3iU6dm3VQXPkoIpU0T5D2t3cImLAe8+VXMmPPAqz1agJmrWUqHUsQvI/IjR
         qmz4v4XL0mUZ2OG6MR5Vgd8NOhTn2gOdNo7tfOusRcQQVwsWsjU3ZOmO6iwsA7970kcp
         RDaQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6qkh1hdP27Hj5Wal6FDymCNa5ZY32MbqVqzejUB5Bhx4tUadQENURQ/ZVlRyIJvVnDl+wP/dYlnXBW3w1+KQkfN0beTrJuyycGH2Z
X-Gm-Message-State: AOJu0YwDade/yHt4OHtzZhyHdSIFNVVjmmwxKquc/KrpHMzZh8/0MNhy
	bXvWrpXmPdVVVSoSsdGNXZe4qmVhmgcsuuX7ftw+9HFjxfGAE5EwpUcZPgjkFLU=
X-Google-Smtp-Source: AGHT+IEgMzCegrv+xwWM1qrjks9Z0YDckuC3RtKQ20VBbAOuincV/IEMpSW+G5Yg0GQW5jwdFy4Phw==
X-Received: by 2002:a37:c44b:0:b0:788:2631:187b with SMTP id h11-20020a37c44b000000b007882631187bmr11541737qkm.32.1710266555259;
        Tue, 12 Mar 2024 11:02:35 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.8.176])
        by smtp.gmail.com with ESMTPSA id u19-20020a05620a455300b00788618c8c3fsm3477741qkp.34.2024.03.12.11.02.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 11:02:34 -0700 (PDT)
Message-ID: <575a9e4e-d66a-4691-809a-6990adfe1238@sifive.com>
Date: Tue, 12 Mar 2024 13:02:33 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 1/4] riscv: Remove unnecessary irqflags processor.h
 include
Content-Language: en-US
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Jonathan Corbet <corbet@lwn.net>, Conor Dooley <conor.dooley@microchip.com>,
 =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 Atish Patra <atishp@atishpatra.org>, Randy Dunlap <rdunlap@infradead.org>,
 Alexandre Ghiti <alex@ghiti.fr>
References: <20240212-fencei-v11-0-e1327f25fe10@rivosinc.com>
 <20240212-fencei-v11-1-e1327f25fe10@rivosinc.com>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20240212-fencei-v11-1-e1327f25fe10@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-02-12 5:36 PM, Charlie Jenkins wrote:
> This include is not used. Remove it to avoid a circular dependency in
> the next patch in the series.
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  arch/riscv/include/asm/irqflags.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/riscv/include/asm/irqflags.h b/arch/riscv/include/asm/irqflags.h
> index 08d4d6a5b7e9..6fd8cbfcfcc7 100644
> --- a/arch/riscv/include/asm/irqflags.h
> +++ b/arch/riscv/include/asm/irqflags.h
> @@ -7,7 +7,6 @@
>  #ifndef _ASM_RISCV_IRQFLAGS_H
>  #define _ASM_RISCV_IRQFLAGS_H
>  
> -#include <asm/processor.h>
>  #include <asm/csr.h>
>  
>  /* read interrupt enabled status */
> 

Reviewed-by: Samuel Holland <samuel.holland@sifive.com>


