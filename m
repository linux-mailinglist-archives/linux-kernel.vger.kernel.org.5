Return-Path: <linux-kernel+bounces-159098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECA68B296E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFED41C21CA8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933F4152E0F;
	Thu, 25 Apr 2024 20:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="OBIYah/f"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E32621101
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 20:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714075716; cv=none; b=gzMgoerWy22uUx5S6k5VCAVlfoySb00dnZRo9LrpRrapmVpoZDQEsHMIyJnfev5vIVRtcCSzoV+9pwno5HsOLjOOk/NrLUheuKuf0YM2a+3MJtrSWkFDR8yLPI1gRqWnAfIsU5hg14eE8mTT6AgAqap40n7gX0vZaHnDPoGSdJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714075716; c=relaxed/simple;
	bh=0sCH/svKrcHQRBgwMdS8kOTd5s/vWg8I+tWzNaJ25Ug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k7XlpGzY4P8AONH9rt9kGHDWRLgbjWcN38DgDZ7dd8itO3idB/+jCnPJ0OgQfeRv8lnL5XXQnZgc+LTXIPaY9ok3oqGZ/2Gn/TZ3mrH8VEcRLfEwl2IZY923R0tsQiGrZrOMRiWhe3e3Of13EL9UWk7GJ5OYI1qzJJmuw9isVvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=OBIYah/f; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-36c30a81507so3469295ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 13:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1714075714; x=1714680514; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bmZS627iyI6cXvDn9mYzVXZNUslQZgCxIUmm314nlkE=;
        b=OBIYah/fAXnDM0IQoUnhSlYG4d5cE6gqdD11GfgYgClWhkQhwjTKE/uti+AP/X2dpO
         /qJIy1pOrCNrGunCM772+iK81VUQQikGvA71eq76Nlj+OMDHe/twkBzH7tDxoMWmyavA
         u5yz2JWdPsgc7T2O7HoMColqjEIRYncM9dFmyMfiR/lBlhKdVKx7puLRGryRj3iU1Eiv
         CV3KZooE/a+H+RJ1q1fVMic3o9rfNEFdFnvQz/XoG62Z1Jh3w094k64VQW9zlBBwusPU
         q8WvM/cxguqbsDRR6F0uQ7uDnKTceo8zaC4rXk5YyCJOCPidQ5nn63qusB/Po+VTP8mQ
         baaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714075714; x=1714680514;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bmZS627iyI6cXvDn9mYzVXZNUslQZgCxIUmm314nlkE=;
        b=cmfdGsDRDCYvVbjFRPkTJ75MMeW5nmMtWPc8FXjTA6sideoEUm2eea3g/luuhN0O2y
         Mt3DbvuBlDnWxSMUJuGj9NS75Tlsgz4Mnkc8U0l9wgqrYD3WgWxetoeOmBaMJiLsMPXY
         Si+m79D51lklaVDdh26Yr05F/iI7JmlzpO/rn7NzEafPSNC5ZeB8qb3p6rPqVZK7RU8H
         OvRx25bx689/dvcJHbABztjCQrIPTMQc8QEhvHOeW+xCAGcWAZ6jOshi6RNomWxXhsdh
         AKsAijWp48O2OuhJQNlOq0vwY8ktMvIFKu1JKo/LSyuwyCSvAbMCHNkIXbhz0LFfiXBH
         rXsA==
X-Forwarded-Encrypted: i=1; AJvYcCWk6EJzZqaGSS3Ar4osIzju4pdjIF528NotwZIuHk+3pgaJbuBl2ard9lib7hBfLEbXaId0iflMUvbdHEpQF4U2vBMckXxGlwozbREP
X-Gm-Message-State: AOJu0YwLf4JcjiXuyCFznqiaHXFn7KNS5e/iJCBrXehREGY7sTCHwIsn
	LDfkbk+jc//GSdkajzpTcIlKbx2UviEmVvUILOTHx3HJYNoaScwMZbPCI/kLfjY=
X-Google-Smtp-Source: AGHT+IF7UibZ9Tq2CyV/lcHoINwh7wba3leqbYShtMwVRmIS9aOy6+dNx8r1b604+CtMfbV/ku5vLA==
X-Received: by 2002:a05:6e02:144b:b0:36b:24c5:eee5 with SMTP id p11-20020a056e02144b00b0036b24c5eee5mr885883ilo.27.1714075714321;
        Thu, 25 Apr 2024 13:08:34 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.6.197])
        by smtp.gmail.com with ESMTPSA id p6-20020a92d286000000b003687fe513f2sm3634471ilp.2.2024.04.25.13.08.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 13:08:33 -0700 (PDT)
Message-ID: <d2742ee1-7e3c-4c0d-8172-d3543fe78e5e@sifive.com>
Date: Thu, 25 Apr 2024 15:08:31 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-riscv/for-next 1/2] drivers/perf: riscv: Remove the warning
 from stop function
To: Atish Patra <atishp@rivosinc.com>, linux-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
 Andrew Jones <ajones@ventanamicro.com>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atishp@atishpatra.org>,
 Conor Dooley <conor.dooley@microchip.com>, linux-riscv@lists.infradead.org,
 kvm-riscv@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Will Deacon <will@kernel.org>
References: <20240425232933.4111680-1-atishp@rivosinc.com>
 <20240425232933.4111680-2-atishp@rivosinc.com>
Content-Language: en-US
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20240425232933.4111680-2-atishp@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-04-25 6:29 PM, Atish Patra wrote:
> The warning message was initially added just to indicate that counter
> stop function is being called while the event is already stopped.
> 
> However, we update the state to stopped case now in an overflow handler
> after stopping the counter. If there is another child overflow handler
> is registered (e.g kvm) it may call stop again which will trigger the
> warning.
> 
> Fixes : commit 22f5dac41004d ("drivers/perf: riscv: Implement SBI PMU snapshot function")

This may be intentional, since you wanted these to be squashed, but this isn't
the right format for a Fixes: tag (no space before ":" and no "commit"). Otherwise,

Reviewed-by: Samuel Holland <samuel.holland@sifive.com>

> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  drivers/perf/riscv_pmu.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
> index 36d348753d05..78c490e0505a 100644
> --- a/drivers/perf/riscv_pmu.c
> +++ b/drivers/perf/riscv_pmu.c
> @@ -191,8 +191,6 @@ void riscv_pmu_stop(struct perf_event *event, int flags)
>  	struct hw_perf_event *hwc = &event->hw;
>  	struct riscv_pmu *rvpmu = to_riscv_pmu(event->pmu);
>  
> -	WARN_ON_ONCE(hwc->state & PERF_HES_STOPPED);
> -
>  	if (!(hwc->state & PERF_HES_STOPPED)) {
>  		if (rvpmu->ctr_stop) {
>  			rvpmu->ctr_stop(event, 0);


