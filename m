Return-Path: <linux-kernel+bounces-123425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D03890870
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35C431C23279
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296711369AC;
	Thu, 28 Mar 2024 18:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ewl3DB2C"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22B612F38C
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 18:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711651335; cv=none; b=jCuB/UvjCq6gAwuIr3eg6cgb5DAONU1wTc0QKEwZ4bjn2Zy7r7Z+G+vfEoAWycGX99zYlT4F3CZ8p0vFkpeiR14RIJ2pn2vIVmy/628dcOsHsxOytIMNNe5yBP3c1PBicjTyqx19J0hBTpLAew4IJn6YsCj+IC+pBkVvKmvOYzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711651335; c=relaxed/simple;
	bh=8yTekIG0Z2yIlKq0G56+dY2VrHhUCmwbc3p0S+Eyh6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CFeqBhmwOEgckbXw61PFAAAUGcKaP7YaMZV3MAUHov+91FtWA1caBnizKqLQx+2kjzYh4Wu7cyUPsPxnSxkbSqhTDz0ShMx+t6a2uYAWViO1uZL63Wmh6K8XgOv9RPgOT0qmUqZOCtCLwSIV0FndpOTiHpRfZNIYLh8qKC31ZsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ewl3DB2C; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3686ab64840so1831825ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 11:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1711651333; x=1712256133; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eJZy6XzF+M+z3gDLwuRgmmyGNjTRkpELLUKGZKjiEGk=;
        b=ewl3DB2Cf1VJpv+3cQWyndNa0hAxHchQouqxKlVKaOzhV2AZFOjFfs9S1a9/mQJvZe
         I3Hdix+hH1l8wmLe+fBTswiuA0WTfxzExqwUFEMttMWk6ZWwapet0qYDHQ0n7UfGcLB2
         JbjL1H1WWPkVVsTBg4g2uaboSwi2wghT6q3+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711651333; x=1712256133;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eJZy6XzF+M+z3gDLwuRgmmyGNjTRkpELLUKGZKjiEGk=;
        b=VlfnrvAPd0e8trelP+UzzX+F/PAt3lKAuW18vH/P3J8K24dlfpQFB4VnPlUSsVzPMi
         PZZ+HxCfwM5vGwSn+0748YIbu1yAQu5sZCWs1XL5yz3wYLKecMY9r46fktnLyhcYTI57
         +wU7lXBzVGKavcbjNc3bEZQE6+QSpfqZIwDwx+0DbWelj5+uvtwGCpQROzkybLFGJPrX
         0i1oakzc14cr2S6s4EO/A45JmUPCzD5Tn1mmi+BfFQfFOToRk6ROiX1Cv9uLPXO3ajoC
         hTp/6tJPkt02KGWjKe+jehs//N247pHQI+jIA93kCtgQCSNeGP3qlCjJuDtmclN0YGEE
         fhcw==
X-Forwarded-Encrypted: i=1; AJvYcCU28NliSLSdXGnYl5RWNg4U1B23Ai5NFZ5QW/tLtGMM0LfJZ3IIqEoUXNVzFCGe8/2+h0c1aW99V1+FIxD0RNiRhPBqeAkc63nLIF8i
X-Gm-Message-State: AOJu0YyB6wyrd2QkQRWN+Buxx3fP59fCLOyd//jkKC8K5Jh8CvaCnN4K
	BjeMIYeLxsj43cFhWn+ARUa1q+3n1tK02WadtfZ/zooOGXIO+zDjB7VHtxkmc2U=
X-Google-Smtp-Source: AGHT+IEPs+I7KZ45OLibFFl60nDnptka/BC8PT36XkjIpLFwzJ9mY8syrmn9bysPWe1yMUbihkcMaQ==
X-Received: by 2002:a92:d58e:0:b0:368:b289:38b9 with SMTP id a14-20020a92d58e000000b00368b28938b9mr4079695iln.3.1711651333097;
        Thu, 28 Mar 2024 11:42:13 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id l12-20020a92280c000000b00366c4a8990asm568855ilf.27.2024.03.28.11.42.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 11:42:12 -0700 (PDT)
Message-ID: <1d6418a3-67eb-4a39-891a-7d653a26f1fc@linuxfoundation.org>
Date: Thu, 28 Mar 2024 12:42:11 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] selftests: x86: skip the tests if prerequisites aren't
 fulfilled
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, "Chang S. Bae" <chang.seok.bae@intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>, angquan yu <angquan21@gmail.com>,
 Ingo Molnar <mingo@kernel.org>
Cc: kernel@collabora.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240327111720.3509180-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240327111720.3509180-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/27/24 05:17, Muhammad Usama Anjum wrote:
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
> In amx test, Move away from check_cpuid_xsave() and start using
> arch_prctl() to find out if amx support is present or not. In the
> kernels where amx isn't present, arch_prctl returns -EINVAL. Hence it is
> backward compatible.
> 
> Reviewed-by: Chang S. Bae <chang.seok.bae@intel.com>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes since v2:
> - Update the changelog
> 

Thank you - applied to linux-kselftest next for 6.10-rc1

thanks,
-- Shuah


