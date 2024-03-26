Return-Path: <linux-kernel+bounces-119958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB5F88CF6C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B7281C2E154
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68E812AAF6;
	Tue, 26 Mar 2024 20:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b6G4NyNI"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3015CEDF
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 20:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711486308; cv=none; b=eBP+EtJmnETP/ATVU2dSdZLwnRu+u2GuRzX1B9abirPFXAlPsJ99CC7MEw78vc0ncuej3Znq4joup2Zn+GhgVuQr73tdfMBEQ3qH3gw50hW6FlHXrVuwUIkKiE7YIKBSdj6ORSQ93fegozY0L26Qrb/Tcs2PBMXxhKOpuYGIZWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711486308; c=relaxed/simple;
	bh=hBC772ybdf+Owd0PNC117b7rIoH9nw9Zgk2CSiwxMwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qAS+l9rzLXWRUo3T9W7DiKho5DGMyKEmYWMfXda+sRBscVCsh1E+qAw5g9TtgIJqFKjDg6IogISgSTOPLDLHYPnJQZ2OsWIN3j0JGM2qdcGqSRldLzYRgtWIVJIIv1WA5CSqid5FvJIiV2+wxyTHDrx4Z06pXOJ5JMJ8/fUJlTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b6G4NyNI; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7d0772bb5ffso4258239f.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 13:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1711486306; x=1712091106; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iGATlVHZqsOUXgCYm+M0WxHRZxp5uAZbCgkClimc7Og=;
        b=b6G4NyNI759FFivuZ6Fnv2k+NiOpUs5HsMUseoZrjVeDtv+1U+hYRwX8O4c7jXwQwt
         FSJ3Tz2gE5sLah38IafMVCgPdGyoHnx3Fju7I27PdoN88tsPrBLaeoOMw3e5jl+wsvaL
         Kqz8o0ORfu48i2z58im20vIvxfoFhbVYrGhms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711486306; x=1712091106;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iGATlVHZqsOUXgCYm+M0WxHRZxp5uAZbCgkClimc7Og=;
        b=jarqjO2h6k6HyK9OU4l4XRzUrZAOuz/W0y4RgmkZ/vX0cpsO3lhHrxU4NAVXOZaB18
         rvLUkziEkfFQkT6nx1jnHxZiZxsJ4qv54Vf1aAxFhWR8W21tg2c8KdlR9ZcJIP4ZDWIu
         1RMcx2yTfhYWUv+2fQHiRS9EQELg1MtKKsyUAzZ5H6DG2CIPnngGcqL+ZLOivqWW98Re
         8mAaM8ohZ7KcS0lAvMCu1UwxS9R2ImypsJK5YFlswowzxsIxW6xTRWCo6tnIBQauH5w2
         cZICHfpKScrXqxn2mQD9XquIw+qIOlh9sZzEbwK3sn7AXTXkQOWF4x6xeODhK3A7I5Ek
         RRYQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6gcc8kuDJw0+1iss8NLCCKQuLLDoEFZHnJ9/phz8wvEMm5GrfY6eOQ02q4kaEa19as2Zt2O5Z8q7wZlvLPR2/+aW9NbhZB2tvuLGA
X-Gm-Message-State: AOJu0Yxd0ZO8sOh+8GPF5Gg82EQZCJEDZ2gE4EdAplSUa8mbjjLCN3Xp
	aAaHb/qc26Fz/+lgC5Bh3X4B4mb79oyUiHVPhuLO5sLh09VRy3H7CQVZBM0HfdY=
X-Google-Smtp-Source: AGHT+IHAp11c7EjAcw6b14fWfZVHqaxnCDOx73bI6BHZWtF7bzd4aqfe69GcIDq750caftPwpUeppA==
X-Received: by 2002:a6b:c986:0:b0:7d0:3d2c:5987 with SMTP id z128-20020a6bc986000000b007d03d2c5987mr11140257iof.0.1711486306120;
        Tue, 26 Mar 2024 13:51:46 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id y24-20020a02bb18000000b00474dc6544c2sm2886255jan.97.2024.03.26.13.51.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 13:51:45 -0700 (PDT)
Message-ID: <9b30d5a7-1a23-4f48-b6c3-4908535a998b@linuxfoundation.org>
Date: Tue, 26 Mar 2024 14:51:44 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: x86: skip the tests if prerequisites aren't
 fulfilled
Content-Language: en-US
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 "Chang S. Bae" <chang.seok.bae@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Weihong Zhang <weihong.zhang@intel.com>, angquan yu <angquan21@gmail.com>
Cc: kernel@collabora.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240314114502.466806-1-usama.anjum@collabora.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240314114502.466806-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/14/24 05:44, Muhammad Usama Anjum wrote:
> Skip instead of failing when prerequisite conditions aren't fulfilled,
> such as invalid xstate values etc. This patch would make the tests show
> as skip when run by:
>    make -C tools/testing/selftests/ TARGETS=x86 run_tests
> 
>    ...
>    # timeout set to 45
>    # selftests: x86: amx_64
>    # # xstate cpuid: invalid tile data size/offset: 0/0
>    ok 42 selftests: x86: amx_64 # SKIP
>    # timeout set to 45
>    # selftests: x86: lam_64
>    # # Unsupported LAM feature!
>    ok 43 selftests: x86: lam_64 # SKIP
>    ...
> 
> Cc: Chang S. Bae <chang.seok.bae@intel.com>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes since v1:
> - Use arch_prctl to check if amx is supported

This should be mentioned in the changelog  and also
show that there are bo backwards compatibility issues.

> ---
>   tools/testing/selftests/x86/amx.c | 27 ++++++++++-----------------
>   tools/testing/selftests/x86/lam.c |  2 +-
>   2 files changed, 11 insertions(+), 18 deletions(-)
> 
> diff --git a/tools/testing/selftests/x86/amx.c b/tools/testing/selftests/x86/amx.c
> index d884fd69dd510..95aad6d8849be 100644
> --- a/tools/testing/selftests/x86/amx.c
> +++ b/tools/testing/selftests/x86/amx.c
> @@ -103,21 +103,6 @@ static void clearhandler(int sig)
>   
>   #define CPUID_LEAF1_ECX_XSAVE_MASK	(1 << 26)
>   #define CPUID_LEAF1_ECX_OSXSAVE_MASK	(1 << 27)
> -static inline void check_cpuid_xsave(void)
> -{
> -	uint32_t eax, ebx, ecx, edx;
> -
> -	/*
> -	 * CPUID.1:ECX.XSAVE[bit 26] enumerates general
> -	 * support for the XSAVE feature set, including
> -	 * XGETBV.
> -	 */
> -	__cpuid_count(1, 0, eax, ebx, ecx, edx);
> -	if (!(ecx & CPUID_LEAF1_ECX_XSAVE_MASK))
> -		fatal_error("cpuid: no CPU xsave support");
> -	if (!(ecx & CPUID_LEAF1_ECX_OSXSAVE_MASK))
> -		fatal_error("cpuid: no OS xsave support");
> -}
>   

Why doesn't the changelog mention the code removal?

thanks,
-- Shuah

