Return-Path: <linux-kernel+bounces-136041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9A289CF49
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 02:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 876E4283C20
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 00:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD6510FA;
	Tue,  9 Apr 2024 00:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="b9S1zA1O"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E6119A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 00:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712622117; cv=none; b=Cr1ceNxYTxA1Tt2FicvzT9xAU+d+pB0axMLhWg9/rlhGW/DIyiuf75rYWrRGoYZniZx7ZSmgl3nRgM0rajLRnJCYIIQmaf9dSbV4gipAXdBcL6Stx4RMF5/jq5JPqcGWjdHQpu8nQ3tPmr4tPmnTCC3rWm1PQr03hCScBgVR1s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712622117; c=relaxed/simple;
	bh=y8+B3fBdv0+pwLEVFa2oRmsHTM6gfVbpXdHodVkQD0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z/h7ZVwWbYJocww6b+YhvUrNPYJuPwJCtYOGrUn8h9/2yItpYz0O9OkYhKTVVUE+v6oUJIoUEgZbDaO+si6ZsZS+IxfV5YAvmZBUlIh8mArVU8VMWIK9nWRlbTrczQad1DWdSSs1HZErdyeIZro/NrKXVMs4QZMEXRS+FhiMqsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=b9S1zA1O; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7c8d2e0e9cfso134678339f.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 17:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712622115; x=1713226915; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k4RWqXaWFwmiNP6pNOx5Yfz/MuJboItuSjd5cmtvGoo=;
        b=b9S1zA1ORGl8Msoxwg4m30cecQmnuSW8Ox7zcg9lza3xdjwGaNcR7na/2ZFXx5zUBs
         PYeL+K634UiZrCdSRh+zdomf5G8IOSPiFrVVpFfXqRGA6VfaoNK+L3zZSHxcoKZNbzyS
         llt21ZOMCReN4+yQCMC3jGp5IG2htaPFNOo5ApNy2S0gY29elaYGIgQaWs4S2IpTqIlf
         lu6W2wK5IPWhztOq6dBydOpT+3QJBge+aC3dBGJpi3TRetlTrw4SyQW0/1l2q5DFd0Ex
         eI/Ywf/LsRdrpMReLYGfSCrL5Gyn/4TTNHaOkdmUzXn5M38/LbnRb/TRlOU80VdkbEke
         UPwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712622115; x=1713226915;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k4RWqXaWFwmiNP6pNOx5Yfz/MuJboItuSjd5cmtvGoo=;
        b=jaVqRS9OdR5y7qX/TqRUfO7e8L9/zLVnYcvmhPWkVZB9ZSGocTRmG8Dyq0VdaZgr6d
         RUwUMF/LZbUY0EVkhkESUPEvjKFtLkUfMTy/ZwinpcAKphvAEEUbrDhEWV1tUMKJVSyl
         As5ORC4errdvp6Z4udyRYP3JUXF0p5s68fbUrvDGz3YG9XNX3a9mhuXr9fB/4l8VIUBz
         h08VwtyrpbvLzCVaRoAXZGcguiDDNzfnuFK4HUh3BFAwZ39k+6SGUWLgVMoYBvIWBwN/
         paPORoAvhFeoNZlcOc/q7fqvz6s/FKGZq3qf/N70lT6HPGt3IWboM0pOhpn2uHr5YmSF
         2yuQ==
X-Gm-Message-State: AOJu0YwMYw82y8Ys1veOaIRPh2wF0Czrw0ECth6M5M9K3bH2fGlgL/BJ
	OoDxtDs2+h7Fb4vZSzebOH3j8Blk9xbrd4y3xwzQTd1nHrH1NgxH2QGQwmX+JjA=
X-Google-Smtp-Source: AGHT+IGDn7RB5cU8iSXf8xntybKszf4HI5OoCRwBUHdVivfSY4dzeQk6+44VVtnK3iUR/Ypb1pjzqA==
X-Received: by 2002:a05:6e02:20cb:b0:36a:203e:6433 with SMTP id 11-20020a056e0220cb00b0036a203e6433mr6545247ilq.9.1712622115407;
        Mon, 08 Apr 2024 17:21:55 -0700 (PDT)
Received: from ?IPV6:2601:647:4180:9630::e8c1? ([2601:647:4180:9630::e8c1])
        by smtp.gmail.com with ESMTPSA id e1-20020a630f01000000b005f072084432sm7093745pgl.38.2024.04.08.17.21.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 17:21:55 -0700 (PDT)
Message-ID: <c33b4da9-5759-4a1a-844d-c6dbad028d12@rivosinc.com>
Date: Mon, 8 Apr 2024 17:21:53 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/22] drivers/perf: riscv: Implement SBI PMU snapshot
 function
Content-Language: en-US
To: Andrew Jones <ajones@ventanamicro.com>
Cc: linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
 Anup Patel <anup@brainfault.org>, Conor Dooley <conor.dooley@microchip.com>,
 Ajay Kaher <akaher@vmware.com>, Alexandre Ghiti <alexghiti@rivosinc.com>,
 Alexey Makhalov <amakhalov@vmware.com>, Juergen Gross <jgross@suse.com>,
 kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
 Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Shuah Khan <shuah@kernel.org>,
 virtualization@lists.linux.dev,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Will Deacon <will@kernel.org>, x86@kernel.org
References: <20240403080452.1007601-1-atishp@rivosinc.com>
 <20240403080452.1007601-7-atishp@rivosinc.com>
 <20240404-bbfb02e3aec944f9e11745ae@orel>
From: Atish Patra <atishp@rivosinc.com>
In-Reply-To: <20240404-bbfb02e3aec944f9e11745ae@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/4/24 05:01, Andrew Jones wrote:
> On Wed, Apr 03, 2024 at 01:04:35AM -0700, Atish Patra wrote:
> ...
>> +static int pmu_sbi_snapshot_disable(void)
>> +{
>> +	struct sbiret ret;
>> +
>> +	ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_SNAPSHOT_SET_SHMEM, -1,
>> +			-1, 0, 0, 0, 0);
> 
> The "Rename the SBI_STA_SHMEM_DISABLE" patch should come before this
> patch so SBI_SHMEM_DISABLE can be used instead of the -1's here.
> 

Sure. Done.

> Thanks,
> drew


