Return-Path: <linux-kernel+bounces-137402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E26189E188
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8FD3284B00
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F27B156673;
	Tue,  9 Apr 2024 17:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E+vy51t5"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF340156249
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 17:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712683690; cv=none; b=JAJ1Y9YRhQZ8ZXkegWpffNCmiYXYUBE8GN00DAOvJtLXnXdOHV+wzwp7Cj1WCoi2mYlJZ+UDfddO1MHhjz34YfJySsezwrmgdfi21L3wAzgOLww7rsyE6cJBV1YvQIRvRpZ6zEqZhN2dtjYJu5knK7fMuOsFMBlM8soP/PTIYqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712683690; c=relaxed/simple;
	bh=TPhpU6GJEU734JPKrGvqBheDD6F81x0OYRJ4s8MuK+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VkpyPD8req2FYK2ZSpm71nUitm5tg2CPxu9Lq5aM3eUlz7pwqRKSKuIXVT0+Oh0nC1fx64qhbvT+wR82ZorhD0gcWc25kIHg+GDqyeOIXQKd2ZZWEzsUd9mPJD3H4jEsKz9pSI+T2OJiiffDFTstJlbytGDrOImdkZpqbokqZkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E+vy51t5; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7cc5e664d52so95236139f.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 10:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1712683688; x=1713288488; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bzDpECgxcv/gVK2Eh47txfcjeUm+DcSXrEiDNVslfT0=;
        b=E+vy51t5hbFKtlPfWz63OAwISfam8JoJQJPF3AsULQlTZX/HvoniDiNyRzbxSMrbZ4
         mk0VY5pVQ9SrzbabNxxJkimfIKhLT06ENVXFV0HjjURiYtwsvqJdGLxrKYQsqSYYXRWB
         TAbhQeAzpAwOREQqlwbspbUY82B4xrV390hiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712683688; x=1713288488;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bzDpECgxcv/gVK2Eh47txfcjeUm+DcSXrEiDNVslfT0=;
        b=ATm9fftxv9kKNHnDOQKxWHP1NqiIWh1m93PxvuvXHdKdWiT9GPT0qblw51emqowFjl
         c6Ub1agbmNUc5qGK4qhtFba/ScHjZmfKPDM0fMTshhEGkx/RDaV9n4/iB/j3pAay7VPC
         ebcnQm8ImhjWk4u/Byc848nCiWa48HjjKRq0dzxTmjuFnJi/DXo0F/CfBfs0DPmusWJ0
         ckP0QDvEqmRYOshwTGmd5EuaE8jHpGIdH5dpYflClzDzmT1InKh909NP7ZNF98rrbpmd
         Cir8+7GFe/B0qNugD0A2XyCk02qy3VXuwElubgpdQAF0VBJsM14F0U1plko5GgUCSY8l
         fW0g==
X-Forwarded-Encrypted: i=1; AJvYcCVRRNJaHXXyfap3rmUjtV66k9idp+maq2CxjFAojS8yUGHeO2lpZojbOlj4KxeWtsCoz9G6wxGOmwIdHWlssqtGWLlVqly5ytXnCt4e
X-Gm-Message-State: AOJu0Yxm+tP7psvG1JhCi+f01hVxmWIqWIGu/ZZU3mt68ZhYAqPM//az
	u9Y3nrA4xOBConyuQXb1kqcHFzSuw37hQdkhiHqLtV92uYgT8ijOwjh0EzzRiaY=
X-Google-Smtp-Source: AGHT+IFk5z8PoAK3T9resPRUq+Mhgn4hfhcghzxIpzPidDvzpWozapI9Iaz2Vi75WE2H0KeSIVTCNQ==
X-Received: by 2002:a05:6602:3b98:b0:7d5:de5b:1ac2 with SMTP id dm24-20020a0566023b9800b007d5de5b1ac2mr468468iob.2.1712683688027;
        Tue, 09 Apr 2024 10:28:08 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id cn23-20020a0566383a1700b00482b4a8f07esm35302jab.61.2024.04.09.10.28.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 10:28:07 -0700 (PDT)
Message-ID: <5a04e40c-daba-4a1d-b5db-f70d2e51c403@linuxfoundation.org>
Date: Tue, 9 Apr 2024 11:28:06 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 RESEND 0/7] Handle faults in KUnit tests
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 Brendan Higgins <brendanhiggins@google.com>, David Gow
 <davidgow@google.com>, Rae Moar <rmoar@google.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "Eric W . Biederman" <ebiederm@xmission.com>, "H . Peter Anvin"
 <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
 James Morris <jamorris@linux.microsoft.com>,
 Kees Cook <keescook@chromium.org>, Luis Chamberlain <mcgrof@kernel.org>,
 "Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
 Marco Pagani <marpagan@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>, Stephen Boyd <sboyd@kernel.org>,
 Thara Gopinath <tgopinath@microsoft.com>,
 Thomas Gleixner <tglx@linutronix.de>, Vitaly Kuznetsov
 <vkuznets@redhat.com>, Zahra Tarkhani <ztarkhani@microsoft.com>,
 kunit-dev@googlegroups.com, kvm@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-um@lists.infradead.org,
 x86@kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240408074625.65017-1-mic@digikod.net>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240408074625.65017-1-mic@digikod.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/8/24 01:46, Mickaël Salaün wrote:
> Hi,
> 
> This patch series teaches KUnit to handle kthread faults as errors, and
> it brings a few related fixes and improvements.
> 
> Shuah, everything should be OK now, could you please merge this series?
> 
> All these tests pass (on top of v6.8):
> ./tools/testing/kunit/kunit.py run --alltests
> ./tools/testing/kunit/kunit.py run --alltests --arch x86_64
> ./tools/testing/kunit/kunit.py run --alltests --arch arm64 \
>    --cross_compile=aarch64-linux-gnu-
> 
> I also built and ran KUnit tests as a kernel module.
> 
> A new test case check NULL pointer dereference, which wasn't possible
> before.
> 
> This is useful to test current kernel self-protection mechanisms or
> future ones such as Heki: https://github.com/heki-linux
> 
> Previous versions:
> v3: https://lore.kernel.org/r/20240319104857.70783-1-mic@digikod.net
> v2: https://lore.kernel.org/r/20240301194037.532117-1-mic@digikod.net
> v1: https://lore.kernel.org/r/20240229170409.365386-1-mic@digikod.net
> 
> Regards,
> 
> Mickaël Salaün (7):
>    kunit: Handle thread creation error
>    kunit: Fix kthread reference
>    kunit: Fix timeout message
>    kunit: Handle test faults
>    kunit: Fix KUNIT_SUCCESS() calls in iov_iter tests
>    kunit: Print last test location on fault
>    kunit: Add tests for fault
> 

Thank you for the resend. Applied to linux-kselftest kunit branch
for Linux 6.10-rc1.

thanks,
-- Shuah


