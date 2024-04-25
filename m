Return-Path: <linux-kernel+bounces-158725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7458B2439
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 747FE1C214FC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F376C14A4CC;
	Thu, 25 Apr 2024 14:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fj+HPOWK"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99CD149DF3
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 14:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714056004; cv=none; b=BFb1hmBSkDvJw+eVkOLFuDPgdVbWRd38Lb90ZAkkg+UcgtkfC9Tr1cAOActOE+DxaMmV9jPaB/gxAnpIZBKCS1uKROzg1F+OGx5GFnULYlfb2nISKxfym+cAjvCsJPVm6Fom+r/fsTJ7ykWtykfysvMD1B6L9j29Ypt4Yxm2byk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714056004; c=relaxed/simple;
	bh=853JfsxxsNGaCmDa2M09/nEyIH6dzRoYxT4vzUq1plE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mzL+yG4EbvQNex+floJnsvXO81ZtbOP8T4v4YKAdQ9l/3a6yjKVD0qlTfiDLFY3I2TGwkS+zjOGm/mxld8ARnIkVmR/FZpSsXwM/duluoKbAjZJNo8lpGEsYq1C1ipeqbbZiuXInicn63PLP4uaFa9iwwS6LZJr6wzs0hikDrX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fj+HPOWK; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e7af7eb4ccso545055ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 07:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1714056002; x=1714660802; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zbFwAjhGWh5upncK28mICUHBRGJEanf6iq+mFqabC1E=;
        b=fj+HPOWKxZzdyHQJ99EcjRld9suuQkr66Gc0CZ3wb+nreKPjjAsP6+4RjZrM3p7Dof
         OK+zWHs6aS8CJV6SSDGZumDRSWijHm7LBaKtnMtHIRSauAI8oBxBm2ZoB7crZx8vuHI4
         T9bx9ZQJT/JgPqR0DWU1rcQ7BRoBVIQvW/Zy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714056002; x=1714660802;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zbFwAjhGWh5upncK28mICUHBRGJEanf6iq+mFqabC1E=;
        b=YJP60fcRn+2cVSPhp2bdb5o6DkR163H+OF1X53/ZmN2CIBJaOBfCLBaBnGLjHZbIP5
         zpENbS93+AyDTzZ1earL0nWs/kQWM01Zbtg0Sub4J7ler0jAtsDUmRJa0MREOJkOX+H0
         jovZeBENza7D4J6N/prPEh0oR+VhoSo5SK/G1CEIfhNlMrbkU+GBkNMBM3yRmLg6QYUT
         vEQJ6AHljxz74Hewlx+IJd9mTOYVKaxoHA3YT2KgNhZxcoJpMBeL2Wm0ki9K1lpbPd8W
         z9xeKu9eGcoA8yxgooBxgD58hOnQJT84EblVy+e6Hyv2c3FeoF1srfhzM3Iz+HccWk0q
         wfuw==
X-Forwarded-Encrypted: i=1; AJvYcCX6qyAK4fEfkQNc2qKqbTM6hKy9hizUgZl+2gWMo43/suh1a9rFGU2PGSPSVTlyWtOC95LDlA9cXXxd/Q7+FACy2SzWT+U7rDhITm6O
X-Gm-Message-State: AOJu0YzHUm4kVEOndNGnNQusTf+8wyCezDI8Y90UTaLZBOmhkS34sc/I
	kJgvtmdgB58Kd4rlvNvhqUaz9SIDjxHVfQemNbKOGJjvxt/MznJXkhJXWMff87s=
X-Google-Smtp-Source: AGHT+IHTcniE7luu0Yhn8p35CQUR1IIBNxaulwYiXiLCmF67vC9Fwvg0LSCum8iFKMf1M25HxyNkWg==
X-Received: by 2002:a17:903:4c1:b0:1de:ddc6:27a6 with SMTP id jm1-20020a17090304c100b001deddc627a6mr6271553plb.2.1714056001670;
        Thu, 25 Apr 2024 07:40:01 -0700 (PDT)
Received: from [192.168.43.82] ([223.185.79.208])
        by smtp.gmail.com with ESMTPSA id j9-20020a170903024900b001e8d180766dsm11787155plh.278.2024.04.25.07.39.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 07:40:00 -0700 (PDT)
Message-ID: <46c3ea6c-713f-48b1-b4e3-95f5e6813f3c@linuxfoundation.org>
Date: Thu, 25 Apr 2024 08:39:52 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/10] selftests: Make ksft_exit functions return void
 instead of int
To: Nathan Chancellor <nathan@kernel.org>, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Thomas Gleixner <tglx@linutronix.de>, brauner@kernel.org,
 akpm@linux-foundation.org, linux-mm@kvack.org, fenghua.yu@intel.com,
 reinette.chatre@intel.com, anna-maria@linutronix.de, frederic@kernel.org,
 jstultz@google.com, sboyd@kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240424-ksft-exit-int-to-void-v2-0-c35f3b8c9ca0@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240424-ksft-exit-int-to-void-v2-0-c35f3b8c9ca0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/24/24 11:24, Nathan Chancellor wrote:
> Hi all,
> 
> Commit f7d5bcd35d42 ("selftests: kselftest: Mark functions that
> unconditionally call exit() as __noreturn") marked functions that call
> exit() as __noreturn but it did not change the return type of these
> functions from 'void' to 'int' like it should have (since a noreturn
> function by definition cannot return an integer because it does not
> return...) because there are many tests that return the result of the
> ksft_exit function, even though it has never been used due to calling
> exit().
> 
> Prior to adding __noreturn, the compiler would not know that the functions
> that call exit() will not return, so code like
> 
>    void ksft_exit_fail(void)
>    {
>      exit(1);
>    }
> 
>    void ksft_exit_pass(void)
>    {
>      exit(0);
>    }
> 
>    int main(void)
>    {
>      int ret;
> 
>      ret = foo();
>      if (ret)
>        ksft_exit_fail();
>      ksft_exit_pass();
>    }
> 
> would cause the compiler to complain that main() does not return an
> integer, even though when ksft_exit_pass() is called, exit() will cause
> the program to terminate. So ksft_exit_...() returns int to make the
> compiler happy.
> 
>    int ksft_exit_fail(void)
>    {
>      exit(1);
>    }
> 
>    int ksft_exit_pass(void)
>    {
>      exit(0);
>    }
> 
>    int main(void)
>    {
>      int ret;
> 
>      ret = foo();
>      if (ret)
>        return ksft_exit_fail();
>      return ksft_exit_pass();
>    }
> 
> While this results in no warnings, it is weird semantically and it has
> issues as noted in the aforementioned __noreturn change. Now that
> __noreturn has been added to these functions, it is much cleaner to
> change the functions to 'void' and eliminate the return statements, as
> it has been made clear to the compiler that these functions terminate
> the program. Drop the return before all instances of ksft_exit_...() in
> a mostly mechanical way.
> 
> ---
> Changes in v2:
> - Split series into individual patches per subsystem at Shuah's
>    request and CC maintainers for subsystems that have one.
> - Rewrite commit messages for new patches and move previous commit
>    message into cover letter to high level explain all changes.
> - Carry forward Thomas and Muhammad's review on patch split, as there
>    were no functional changes, please holler if this was inappropriate.

Thank you for carrying the reviewed by tags.

> - Link to v1: https://lore.kernel.org/r/20240417-ksft-exit-int-to-void-v1-1-eff48fdbab39@kernel.org
> 
> ---
> Nathan Chancellor (10):
>        selftests/clone3: ksft_exit functions do not return
>        selftests/ipc: ksft_exit functions do not return
>        selftests: membarrier: ksft_exit_pass() does not return
>        selftests/mm: ksft_exit functions do not return
>        selftests: pidfd: ksft_exit functions do not return
>        selftests/resctrl: ksft_exit_skip() does not return
>        selftests: sync: ksft_exit_pass() does not return
>        selftests: timers: ksft_exit functions do not return
>        selftests: x86: ksft_exit_pass() does not return
>        selftests: kselftest: Make ksft_exit functions return void instead of int
> 

Applied to linux-kselftest next for Linux 6.10-rc1.

thanks,
-- Shuah


