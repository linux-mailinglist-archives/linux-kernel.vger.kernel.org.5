Return-Path: <linux-kernel+bounces-82886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF07868B30
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12D14283FD6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE914130AF8;
	Tue, 27 Feb 2024 08:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fy3KULmN"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94C57BAE7
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 08:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709023683; cv=none; b=Zh9cyQVxeOi7cznj97hsEaFypY4EAz24IgfB0RUaFfg+jIoqXeF56XrLWHkZ7zNYCiMPwyeaNez2y/8uQCBt+JbpTSKTaGnVSC7RfjcR4NGiZ3Jd5lRzSTAvar/OInftxge1kGVe3XcUju43mtsW6SfsSPahBqGyRNXZ4ius+oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709023683; c=relaxed/simple;
	bh=n4d5pp3WhXWC2Nf4vgDUvgkjDKjFPRxqiSo6Uufnlhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bn7PMeV5+tWCqPGIl5XB+OlZvfjvev5M5IH89xFrjbLxZ00pfG8xJ/mMzhF95iBrI3ZURKKN5dR8TTm50Nf1QzCBEQJv94w7mLaTb+q5nqDdh8NeIhbKlElF8vGl0l47xSvSYW1k2+zRQPlY7URGVCK5vvQMBxkSh32/gmcDyjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fy3KULmN; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33dd2f0a0c4so1407084f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 00:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1709023679; x=1709628479; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FvE0eIJdvZuMGDBSMqVLvFdfht0EO1sq+8tB1Es7NC4=;
        b=fy3KULmNRfPlCHWH8WwDtu1LQqPt1OrlsL5HwhsteMHO8S/8KQC3N36mg6LrAO9vi2
         Z2NCeF2JwB9KM/x18DRNMSxK1pBnQgt7iY9PxthECafH0bSbh2HsL4zDaOkMaHT9E01T
         IJo/LWGJy37YOoVLG69ua/rCkxhMD3px5CAuzFJ0F9+r6s+3/BwLyO3ZSkhDulqai94A
         uDfVkoAsb3xXZHaeF1qfhMNs9Wld+wdfANxOjWvRInTYMj05xZktmxRysDjJtEpjylCb
         TIZjXLwDRmxDvdAhNB/582CRAqkOQDWfKtfRu0cKBIHWY+TOfAkepzy5NHBMfPNmJL6/
         Jgig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709023679; x=1709628479;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FvE0eIJdvZuMGDBSMqVLvFdfht0EO1sq+8tB1Es7NC4=;
        b=gOx/KaTLNtbN5p52uYN0ZBQ9XYjf7QfRQwi7chCBwNrsn2foWLdt5O/Gd7uXFTY1yu
         U0TP/mtwn6ZQzBC4qlqv3qU0zUipQJFltndTSEmghp5CvGmf2UxMDL3TuZ0NssqdJWfd
         pyQ4FQvIfhraE7/61dc6peNJUfABAS/+Dx5UphT6LWzYvVe4jE5T4ZES6O28plUIBvyg
         sC4/5VlawZTLcP/3VNRdVp05PSADaHKfVadbSpYa5I3lV8Jk2i1bsiVIW0OvH9Sfk2H7
         1TbtVVt0FiOXdgneH1X+m8mJgfYLEzJoMwD3TPbKQvN+awO0193Gfw9NxNfGPPuXwRCP
         MBtw==
X-Forwarded-Encrypted: i=1; AJvYcCVH9Te3IDUO1UVDFtFkt8VdXFhjQJMiNuXPavB6fEsTQi1YyMgp/8xsMY/LecBs9BRBNPdH0Jp0DMVMsp7K3DdZvcDpsVIHyrh1MECU
X-Gm-Message-State: AOJu0YwPPlOdoNLNMEm4HhKF8XuSfZFSoWN7xRuIQtAFY94uOutaXBN+
	W515y7PTcwnaERvxlUwUD7CCBw0dh7c3HIge8/0VgYp6008UzWVIC/0NEIf6yr8=
X-Google-Smtp-Source: AGHT+IH7mPf1To1XIApf0mF3mfo/GfBfaDVyR/ClxfptW5/LVchYfOCRXgXEpxqQ/NK2JAiv6q56jQ==
X-Received: by 2002:a5d:4089:0:b0:33d:88c1:31b8 with SMTP id o9-20020a5d4089000000b0033d88c131b8mr6230754wrp.60.1709023679222;
        Tue, 27 Feb 2024 00:47:59 -0800 (PST)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [85.187.216.229])
        by smtp.gmail.com with ESMTPSA id by15-20020a056000098f00b0033da933b250sm10841300wrb.5.2024.02.27.00.47.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 00:47:58 -0800 (PST)
Message-ID: <92440f47-21b7-4f4f-ad99-a99358cfbedf@suse.com>
Date: Tue, 27 Feb 2024 10:47:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/bugs: Use fixed addressing for VERW operand
Content-Language: en-US
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc: Daniel Sneddon <daniel.sneddon@linux.intel.com>,
 linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
References: <20240226-verw-arg-fix-v1-1-7b37ee6fd57d@linux.intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20240226-verw-arg-fix-v1-1-7b37ee6fd57d@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 27.02.24 г. 1:52 ч., Pawan Gupta wrote:
> Macro used for MDS mitigation executes VERW with relative addressing for
> the operand. This is unnecessary and creates a problem for backports on
> older kernels that don't support relocations in alternatives. Relocation
> support was added by commit 270a69c4485d ("x86/alternative: Support
> relocations in alternatives"). Also asm for fixed addressing is much
> more cleaner than relative RIP addressing.
> 
> Simplify the asm by using fixed addressing for VERW operand.
> 
> Fixes: baf8361e5455 ("x86/bugs: Add asm helpers for executing VERW")
> Reported-by: Nikolay Borisov <nik.borisov@suse.com>
> Closes: https://lore.kernel.org/lkml/20558f89-299b-472e-9a96-171403a83bd6@suse.com/
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> ---
>   arch/x86/include/asm/nospec-branch.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
> index 2aa52cab1e46..ab19c7f1167b 100644
> --- a/arch/x86/include/asm/nospec-branch.h
> +++ b/arch/x86/include/asm/nospec-branch.h
> @@ -323,7 +323,7 @@
>    * Note: Only the memory operand variant of VERW clears the CPU buffers.
>    */
>   .macro CLEAR_CPU_BUFFERS
> -	ALTERNATIVE "", __stringify(verw _ASM_RIP(mds_verw_sel)), X86_FEATURE_CLEAR_CPU_BUF
> +	ALTERNATIVE "", __stringify(verw mds_verw_sel), X86_FEATURE_CLEAR_CPU_BUF

Actually thinking about it more and discussing with Jiri (cc'ed), will 
this work with KASLR enabled?

>   .endm
>   
>   #else /* __ASSEMBLY__ */
> 
> ---
> base-commit: d206a76d7d2726f3b096037f2079ce0bd3ba329b
> change-id: 20240226-verw-arg-fix-796a63088c4d
> 

