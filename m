Return-Path: <linux-kernel+bounces-168120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB4A8BB3F5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAD991C2341E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 19:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76ADC158866;
	Fri,  3 May 2024 19:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wgt+I4oA"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5761063CF
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 19:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714764520; cv=none; b=rfrYkHg6Llqp7iU2Bp3vNLOIxvlU3Z+WI3ZoXIcC+CnQmeGZMv2u1Ag9BmqvbJmInZMHojC57U7N5r2Ec7PkqJsX1m1pWtnjTQdir0Jr8wE1mPz0o27FUVpVCyETvVN2Xr0CIm/cExr/cHtEAJe1z08Ec7RisaqMQdoPGqAGPts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714764520; c=relaxed/simple;
	bh=NtD/N9t4INPDtfSQnn+3iVWzc/81QHKoZhzuQv2WgVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hHLNq78zto8Rqk20apMDaN3aH6vU/2DkKx1Bj6/SdD31u9ufmu13yMTq8DWHfc4Rim46+tqxFTNoKgIqS5Bpyydb/7ey8dsfhpABLVV9bdR4hUziOKJWufqhdINnvuROp4OobCTEr/8u6oCOarTJ1SZ9o7iu0qJPTfppvxM1GnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wgt+I4oA; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7deda237891so55839f.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 12:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1714764518; x=1715369318; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mQQK668cb7m+WFTADFVdjdUFjoIDdrtZ7z2hWcOrUGo=;
        b=Wgt+I4oAqj98eWxvhPRILsGs3bHCNXVBgQR1g2y7kQgfsrgoN7/9hBWmfb4sBgdojx
         CkVjaga3rhkgm9LDb3u0BK4qWgNpY5PyRGs7my7+Ja95i2Wi1x0Ok0+fsK8sERK8NFT6
         4efDZwRgBda4t84Cdg3SwdAhuFLBtSWYrypiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714764518; x=1715369318;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mQQK668cb7m+WFTADFVdjdUFjoIDdrtZ7z2hWcOrUGo=;
        b=Tb+QruWB05DuhkBVoLW8hqehGXrrAWUYaD383T+DoHpgt/NIPWfDnRmbtEQI8fO0QT
         juZjFd4mBYDS4TcIHgnEQ8wle9ZemdU5TWNfhXCLt59BjU68ojA4REkpFAX4WRSTSUpZ
         +wFoXu7vZeVHFa2luh6aKvQ8Xf1ixQPAprk8glOh2wa9A/piczAbIWdMaL/gt6HRPkIY
         +bjJXXuj4vmS+7r9Jmji+G+Ekpe7/BWJiyIL5O/0lN5mG15I780NhsCdooBPVeTZEBFG
         xrizZ4HT/lmIIk19fcHjB/is59HlM5Excd9Clv1+fImv+99uQnZea/xeu2DIPSrsCfA1
         sbWw==
X-Forwarded-Encrypted: i=1; AJvYcCXZqSbyg/c4jvpeKlaIRyakcEA+53Eqh0PaDGfVXpJxOEI42/HcurihC/WrDFFizM4t19FNJw/iVPgPUup+tfxWh2y88TH48N4ICAvx
X-Gm-Message-State: AOJu0Yz0v2guHRGDqQ/u8EhfhDUOF27KjDidHfNVG8St9UfI+/CjGekz
	Rmx6D87PUv0YwTVfgpynsheYV7Av5fGsFj/IEUMlm7DGxuiQhd1x0O6CHsIBagA=
X-Google-Smtp-Source: AGHT+IHUNJ0TY1TW1Mg6HSF6/aaw8U7AHNICQZtR+RuZAgfJ7O/a5nOimtkvdAUcSDpyyFTRNcuVsw==
X-Received: by 2002:a05:6602:17ca:b0:7de:d808:4b29 with SMTP id z10-20020a05660217ca00b007ded8084b29mr3906372iox.0.1714764518457;
        Fri, 03 May 2024 12:28:38 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id o21-20020a05660213d500b007dee16c48d0sm755883iov.11.2024.05.03.12.28.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 12:28:38 -0700 (PDT)
Message-ID: <c046fe18-8b69-4689-9d28-6926dcbba4b5@linuxfoundation.org>
Date: Fri, 3 May 2024 13:28:37 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/binderfs: use the Makefile's rules, not Make's
 implicit rules
To: Christian Brauner <brauner@kernel.org>, John Hubbard <jhubbard@nvidia.com>
Cc: Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kees Cook <keescook@chromium.org>, Valentin Obst <kernel@valentinobst.de>,
 linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 llvm@lists.linux.dev, Shuah Khan <skhan@linuxfoundation.org>
References: <20240503015820.76394-1-jhubbard@nvidia.com>
 <20240503-glossar-notfall-bd7c234c2da7@brauner>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240503-glossar-notfall-bd7c234c2da7@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/3/24 03:10, Christian Brauner wrote:
> On Thu, May 02, 2024 at 06:58:20PM -0700, John Hubbard wrote:
>> First of all, in order to build with clang at all, one must first apply
>> Valentin Obst's build fix for LLVM [1]. Once that is done, then when
>> building with clang, via:
>>
>>      make LLVM=1 -C tools/testing/selftests
>>
>> ...the following error occurs:
>>
>>     clang: error: cannot specify -o when generating multiple output files
>>
>> This is because clang, unlike gcc, won't accept invocations of this
>> form:
>>
>>      clang file1.c header2.h
>>
>> While trying to fix this, I noticed that:
>>
>> a) selftests/lib.mk already avoids the problem, and
>>
>> b) The binderfs Makefile indavertently bypasses the selftests/lib.mk
>> build system, and quitely uses Make's implicit build rules for .c files
>> instead.
>>
>> The Makefile attempts to set up both a dependency and a source file,
>> neither of which was needed, because lib.mk is able to automatically
>> handle both. This line:
>>
>>      binderfs_test: binderfs_test.c
>>
>> ...causes Make's implicit rules to run, which builds binderfs_test
>> without ever looking at lib.mk.
>>
>> Fix this by simply deleting the "binderfs_test:" Makefile target and
>> letting lib.mk handle it instead.
>>
>> [1] https://lore.kernel.org/all/20240329-selftests-libmk-llvm-rfc-v1-1-2f9ed7d1c49f@valentinobst.de/
>>
>> Fixes: 6e29225af902 ("binderfs: port tests to test harness infrastructure")
>> Cc: Christian Brauner <brauner@kernel.org>
>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
>> ---
> 
> Reviewed-by: Christian Brauner <brauner@kernel.org>
> 

Thank you. Applied to linunx-kselftest next for Linux 6.10-rc1

thanks,
-- Shuah

