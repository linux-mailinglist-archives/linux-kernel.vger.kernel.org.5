Return-Path: <linux-kernel+bounces-122081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6C188F19E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C238B2247D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D10D153808;
	Wed, 27 Mar 2024 22:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="f41Ssa/D"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EDA1DDD1
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 22:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711577309; cv=none; b=lz8iSr+X5WtwdbuIggpBl+KuRhMY9tHtjBDMYkeKEpcRnjcenpNSqtmH34kTYI8UNawlCePVL+XDbanqPNNo3QvrRe3/6sBn5YpBM4uPmhSVeKMOj28nHqL6uHm3lm2dnPgtlc0isgUUyVs3LaG0lqM2coSqra254796XPUxYiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711577309; c=relaxed/simple;
	bh=C0maMlcryh1cpCiza99ODbzXle0CXNALQm+Q6ihVJDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DcIlUWjH+iZ9hJwBzvAILpYe0VMH0rI5GSED6d3BKpqlRJsi7QJNe9zhLSV+xSFaOimnKvcVlkhL58W+TEQN2//+d/m3AjdEpl9ZmmHk2XOUWjfFeHrUT+i3BBQPFA7p5mFPzaO5gTP8fEPGAzViAKufjfUVZEOyVVneS6Dtpw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=f41Ssa/D; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7d0486e3250so12610039f.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 15:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711577306; x=1712182106; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bmkqc/3aYewIsupa3aI44uZjMZk6uVE6sk1O51xM5oE=;
        b=f41Ssa/Dms3SohsgT1+3vuI3jo7NXv0o9rYx28W+IHc0bd3rxEyQeq/s0mPAdChhph
         P+CxBDA03hmM/ldSNCG2MK66GHBeysFGaYl/EANzSmz/8EZbMva3jydlslYC31sdP/rX
         hJPTYeWy1omTUuyXEGldTielo/0B2YNb99vRsH4EGK46A62cmyrAFlxlPd7+V0/8mvyr
         V7dkRDLXblOGDeNzxn9LrZLltCZLU4s1Y8ndnGUDNrTor6A2WZWZWX+rmtuOPHLEztTt
         CrHZqSTphNGtCgaNTiKnpXm5cD949Lhz8bEj0VZMzlhXpRUY23YKjXklawyhw4hDT7uZ
         IaAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711577306; x=1712182106;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bmkqc/3aYewIsupa3aI44uZjMZk6uVE6sk1O51xM5oE=;
        b=dneDaEPHdOZKEgrbGB+FfBXCmppA27c3KahP6RpM/pElLOXjJwzcjw8qMW89sFZ15O
         kJMsNLBp3t1m7jVUK34Pj/W2zZxgg2qSIfi9WTSZ0b6b6MTjc/u1SXLus3xJFQK4wgA5
         X1MXQaryVZFTr2xzsV68nK1RCUgXOMUp4dxYEaKcc0B+lHpx9ugBni1xgw8yW6s61T3r
         41AnvJ/g07LBFLySYMhdgIP9Hz/QOuX+0lukSJVV405gjd5L8NyixQHIWm4JIZZW7GW4
         DnpAYzG6I1TJGr13qBof2y6Gt7d4YF5R8enBR6LNCNwlMOzX67jaw1Wcnp00IBuc2NvO
         Rlyg==
X-Forwarded-Encrypted: i=1; AJvYcCVPUrV7BzFGO6ymCtKcJLDfAe5ZVJ0yxjyxD3263aO0fRGm4PN2itbwtMySih8SFHy9VcHTV4TR2KDw2pADL8LkO2B7jbeIw9rmMbM4
X-Gm-Message-State: AOJu0YxIdIAwigKVGvBzGGBu2zV26Zrxr0afCphlai37mBFtzbOKFn6J
	DgUUaGe8uW4B2XeubXNkzlVv9yFvsZNdj2ipW2tIDEsI8VinZsW3wKEZt3qSSsg=
X-Google-Smtp-Source: AGHT+IGUYm3Y8wBDca1kE2cHOU4Wfjx7H338gBLx60QGaDb6jbN+3GFHHCGUs0OMGF33wA7wIsUyRw==
X-Received: by 2002:a6b:f919:0:b0:7cb:ffd8:1546 with SMTP id j25-20020a6bf919000000b007cbffd81546mr1424618iog.19.1711577305709;
        Wed, 27 Mar 2024 15:08:25 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.6.190])
        by smtp.gmail.com with ESMTPSA id f12-20020a056638118c00b0047bea529fddsm2373jas.104.2024.03.27.15.08.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 15:08:25 -0700 (PDT)
Message-ID: <4d9633cd-15c4-4cc1-ac67-2592e9fc7880@sifive.com>
Date: Wed, 27 Mar 2024 17:08:23 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/14] drm/amd/display: Use ARCH_HAS_KERNEL_FPU_SUPPORT
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, loongarch@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>
References: <20240327200157.1097089-1-samuel.holland@sifive.com>
 <20240327200157.1097089-13-samuel.holland@sifive.com>
 <20240327142516.e4b1f9ba6e2ec7bc300e4d58@linux-foundation.org>
Content-Language: en-US
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20240327142516.e4b1f9ba6e2ec7bc300e4d58@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-03-27 4:25 PM, Andrew Morton wrote:
> On Wed, 27 Mar 2024 13:00:43 -0700 Samuel Holland <samuel.holland@sifive.com> wrote:
> 
>> Now that all previously-supported architectures select
>> ARCH_HAS_KERNEL_FPU_SUPPORT, this code can depend on that symbol instead
>> of the existing list of architectures. It can also take advantage of the
>> common kernel-mode FPU API and method of adjusting CFLAGS.
>>
>> ...
>>
>> @@ -87,16 +78,9 @@ void dc_fpu_begin(const char *function_name, const int line)
>>  	WARN_ON_ONCE(!in_task());
>>  	preempt_disable();
>>  	depth = __this_cpu_inc_return(fpu_recursion_depth);
>> -
>>  	if (depth == 1) {
>> -#if defined(CONFIG_X86) || defined(CONFIG_LOONGARCH)
>> +		BUG_ON(!kernel_fpu_available());
>>  		kernel_fpu_begin();
> 
> For some reason kernel_fpu_available() was undefined in my x86_64
> allmodconfig build.  I just removed the statement.

This is because the include guard in asm/fpu.h conflicts with the existing one
in asm/fpu/types.h (which doesn't match its filename), so the definition of
kernel_fpu_available() is not seen. I can fix up the include guard in
asm/fpu/types.h in the next version:

diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index ace9aa3b78a3..75a3910d867a 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -2,8 +2,8 @@
 /*
  * FPU data structures:
  */
-#ifndef _ASM_X86_FPU_H
-#define _ASM_X86_FPU_H
+#ifndef _ASM_X86_FPU_TYPES_H
+#define _ASM_X86_FPU_TYPES_H

 #include <asm/page_types.h>

@@ -596,4 +596,4 @@ struct fpu_state_config {
 /* FPU state configuration information */
 extern struct fpu_state_config fpu_kernel_cfg, fpu_user_cfg;

-#endif /* _ASM_X86_FPU_H */
+#endif /* _ASM_X86_FPU_TY{ES_H */


Regards,
Samuel


