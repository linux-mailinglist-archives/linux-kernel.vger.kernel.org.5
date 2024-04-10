Return-Path: <linux-kernel+bounces-138879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9A989FB98
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD4A41C21920
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0522C16F0D4;
	Wed, 10 Apr 2024 15:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="3DGe+Pxl"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A3A15EFAE
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 15:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712763059; cv=none; b=YjIL9wQr1fhmq1uC8xpHWe6Fe6PhIQWMHt75cemPoWCbDVns3JqsNCmW9W1Wj5FHQAjPGpAnizJff3olAUWvLe/ZBzCOaiWqJZhMBPZhLdEHmOpqpianE4Mp1heiO1OANCVEbAIKBWAEoaDZcNw50uOsEOlXElELGU503u1upro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712763059; c=relaxed/simple;
	bh=u1eWAA/ThURkbCchsyub5PAfU1Ae5xWgAQKecjdCMoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FUQZQxqG/EI9IZ5si7EVOWZFrP9yzSPQuhz98AQmz6ODHUBcqLH2WSbakBeRrhK6Oqv7MUd2OvhMc7cIdXvS7vSBr5dVZqDTXOIFa7hs6WbGCW6MCMIjuAE3J3uoN1SoekbqaozQWRwxSQt/IyexwGJIJj9/7QTwQbaiLqeSgDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=3DGe+Pxl; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-346407b8c9aso678515f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 08:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712763056; x=1713367856; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OWBh7JXEUeIzo5KgJAd3zKBhqX2eLt0rOguALy1M0Kk=;
        b=3DGe+PxlpcfHZknuci25H9JJ8XxKvRKUkr4G8+KGuK+bB4qPFRq2dbCRe2h6O2idIP
         syOjYu0V0SI3s3T34XiQcPedAwPi2qj5sBrrFgX4/PzDoIJCu7TXtO4qgMmyv66LVZvX
         16jPI9ZOLPWaKiW+paMrPmumMz3IKjqowyNVm7RqZ8e7/rOeSqCtDxBFeu734pi9Vko3
         3Cf0J1B1eA4/eTCGza0f2dbKLEEaUCG9rM159fJr2GuyzpFlebzqr5H3ssHACw4s06DO
         QVO0mQY4iSqtoNJfJM/rd//eZ1mSP9gXdlB5+o2EIkRAnn7KfxT73qfsTRjqgQUjey6j
         b1PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712763056; x=1713367856;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OWBh7JXEUeIzo5KgJAd3zKBhqX2eLt0rOguALy1M0Kk=;
        b=pImCaPeur2bMDfSpAZILINuudRql50rDoFyZmamiip3Vz+0oyhAYUDvIzNpxjI9koI
         65bBIvrmXpe1cixVyBtJxFPy8rjo/GHcG3AqmZhw7Mr7sPqd9oXUQWcr+SJouxGDDo/m
         ZsZqLG/ZwIeIvebXypXH6xpZlXfhqYtDs7yWMHXL23Pb+fE79dVMcomy9TUo+BCtpFSC
         vpO0oIGZolYA66D8rrFdv69M0qDwUOat0etZgnP0FJ0Zxln3Fs0rXwG0jwhfaXsKuy6d
         1ToHK39gtHmcw3wzzDc3O5TjAusSGoBB+pe2NG6zx2oz5s+sOBtWvl38+Z4q7NWi0Bgw
         e5tw==
X-Forwarded-Encrypted: i=1; AJvYcCV1QYYl0mucH1LstDBR0c3gokUjdAB8dWucippK4TsfnVpktGRdjunZz6TwVVTd1KyRj2M/u203Cit/q3d99t/BnFhSzuykoa+nyvcb
X-Gm-Message-State: AOJu0YzoYdmK6ZsryHZF5cU4ALmmYVAGu4N+7B3SaGJBisBpkrDzyUQf
	08epPYkfH6qAC55iZJaGS+wC8dYM/NDptrckqe4x7jTvihaX+gDDkfelKGNjk0U=
X-Google-Smtp-Source: AGHT+IGM+tKVXZHv9j2QFP6knh6WFNV2lFvfGgCYRQglQNtraXDOdyw8VxBYrHku61VtDa7HjL9l/w==
X-Received: by 2002:a5d:64e3:0:b0:343:ba58:1297 with SMTP id g3-20020a5d64e3000000b00343ba581297mr2445689wri.3.1712763055716;
        Wed, 10 Apr 2024 08:30:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:999:a3a0:d4a6:5856:3e6c:3dff? ([2a01:e0a:999:a3a0:d4a6:5856:3e6c:3dff])
        by smtp.gmail.com with ESMTPSA id p19-20020a05600c1d9300b00416bf7b68f6sm2604986wms.31.2024.04.10.08.30.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 08:30:55 -0700 (PDT)
Message-ID: <ce7b7413-31ac-4c93-8970-e7cf0d6902cc@rivosinc.com>
Date: Wed, 10 Apr 2024 17:30:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] riscv: nommu: remove PAGE_OFFSET hardcoding
To: Jisheng Zhang <jszhang@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Samuel Holland <samuel.holland@sifive.com>, Conor Dooley <conor@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240410142347.964-1-jszhang@kernel.org>
 <20240410142347.964-2-jszhang@kernel.org>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20240410142347.964-2-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/04/2024 16:23, Jisheng Zhang wrote:
> Currently, PAGE_OFFSET is hardcoded as 0x8000_0000, it works fine since
> there's only one nommu platform in the mainline. However, there are
> many cases where the (S)DRAM base address isn't 0x8000_0000, so remove
> the hardcoding value, and introduce DRAM_BASE which will be set by

Hi Jisheng,

Typo: s/harcoding/hardcoded

> users during configuring. DRAM_BASE is 0x8000_0000 by default.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/Kconfig | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 7895c77545f1..b4af1df86352 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -247,10 +247,16 @@ config MMU
>  	  Select if you want MMU-based virtualised addressing space
>  	  support by paged memory management. If unsure, say 'Y'.
>  
> +if !MMU
> +config DRAM_BASE
> +	hex '(S)DRAM Base Address'
> +	default 0x80000000
> +endif

I'm not sure but it feels odd to have this at top level config menu.
Maybe it would make more sense for this to be located under the
"Platform Type" section ?

Thanks,

Clément

> +
>  config PAGE_OFFSET
>  	hex
>  	default 0xC0000000 if 32BIT && MMU
> -	default 0x80000000 if !MMU
> +	default DRAM_BASE if !MMU
>  	default 0xff60000000000000 if 64BIT
>  
>  config KASAN_SHADOW_OFFSET

