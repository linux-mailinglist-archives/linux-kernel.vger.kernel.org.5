Return-Path: <linux-kernel+bounces-74545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D37985D5BC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE2A61C218CD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A871B208C1;
	Wed, 21 Feb 2024 10:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TfsZaFTD"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A722A1EB45
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 10:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708511923; cv=none; b=esaGiWN9XdKA0YinR0Or+4j4JOdTAIid40Br9/sLyH+11DOAf5mYF+IwC4Xpnatoz+n9b114XGnnRp5VQrx/mT0u4aui7hIO/nUIah/M+mOQo8bzx7jaQbUa3vD0el47AdlXwz4qJFD2gOk8XuQ2MTp5w/ET2DdhAVhLpdtbSnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708511923; c=relaxed/simple;
	bh=HBTD9NpgqM7kq4SO3bpEXJ5Bp3ofQRfsZKZeHA7Ambw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PGeuWDwc5ZGdFr8hzZXNXlWGSUELyKeofKKBeNh8o2uTGiCaMcN1v/iouqBFDt/p1Md+j1rHfHGRXjjXZ7mdqWDhaFVNKxMK11Exk3A2E1QWTAEqMlZ1otUcUvEC1nEmf6noudA6/Fwtoj3eYaBljJrtdyFVD3VX8zpK8aBKIhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TfsZaFTD; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-564fe0273e4so459999a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 02:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1708511920; x=1709116720; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cnKoPzhACftS9EnEu9/ynu2qMvlchm1lfMLjCdPuVQo=;
        b=TfsZaFTDBogozp2cAgzkSMybRGAUN9RDlIjzgiP5UO0OpFN7X32ox+OgPxXumY1FbW
         POZQVDD+UIWzWEPZwHKfqKyUH0ROr9svS6vtom1werFfvZuToAwMaBb5uL8mLbNbkbgY
         19tx8dGHEwogBxdNlz3g+HA9guvKCjaChhsk8FDKFzEeO59se+1vu1iFnYUcnMpkZRgd
         S1gFPd27fdasdLl+4BpiavF1Wb2U6m0yJE6pvc6/dmMwERdCecvUNOqePQtLZ0YB9B7y
         F+ItuctFxJjnf2lHONeRmEaFE6WVP0HJK6snwY2ywAXvTMNwAWC0Cqd7wnKcnT/W2r2S
         Gd/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708511920; x=1709116720;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cnKoPzhACftS9EnEu9/ynu2qMvlchm1lfMLjCdPuVQo=;
        b=vg8tLQU+w1481MqqcLhUiWaUra+iXq+39Q/hBnldv+5Qcmngh2p7TI8XM9/EyWu9hn
         rtYUnHqHq4ZFpSAEnyiwSM0fjLpcRLVUJmIfxQJVfs2bVxT/6taJ39IUNIugAyNGbkGS
         OAo5IfmCDIZA8MeMZRx2aaPjk2Mc/1RdE3pmfftNGTBw2hdkyfnrFlwdGAkl3dw4I5ux
         AZB4dJOil3Zqcb4aO4TPbQShGbTqmjNwEjbTFruhTTkWUPXUKB4S9/pSYs1n/1emPgsh
         E0tTa3z24MmIfL16sLc34C+L8bHtZ2sSPgz6xouQ38qK/Y+TVAW3ZfHmTZJgOMQBKJHr
         jppQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiePM/1rXKPv+B6NEAUikbUkF6UGMM3QXTt/2/b8XNt+3yHxHuHsiX9HkNHa/XwPBLj+c0UNMdT5nWcJlJgo9XPXrYOtUlOeer1L+I
X-Gm-Message-State: AOJu0YwG7NAloRzov2akaQXWPEzlwgI8JS9s0kCdU4npSWpEJ5SSfglF
	snL/KN25eofmsc0N3mZiT3beTg07Zt4pXSJdSZs1glktTdlWJ6BitS/PEd+wmjM=
X-Google-Smtp-Source: AGHT+IGWY0olFbTK2LeHVps++mXY14F0mgECCZhY5FffQmgkJeKvOHJIZBdK7Rb6s/6ljo8BEwbLBg==
X-Received: by 2002:a17:907:b9ca:b0:a3f:2247:bb59 with SMTP id xa10-20020a170907b9ca00b00a3f2247bb59mr1776452ejc.61.1708511919896;
        Wed, 21 Feb 2024 02:38:39 -0800 (PST)
Received: from [10.100.51.161] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id j10-20020a170906474a00b00a3e50e01612sm3853825ejs.62.2024.02.21.02.38.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 02:38:39 -0800 (PST)
Message-ID: <9b067ec7-34e2-437b-a41b-319aaee4c7e6@suse.com>
Date: Wed, 21 Feb 2024 11:38:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] kbuild: Use -fmin-function-alignment when available
Content-Language: en-US
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: nathan@kernel.org, nicolas@fjasle.eu, mark.rutland@arm.com,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240215151642.8970-1-petr.pavlu@suse.com>
 <CAK7LNAS=knGxd9ZRo37CaKTvjcc28bqNasx+XuqbV3S+XV=HtQ@mail.gmail.com>
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <CAK7LNAS=knGxd9ZRo37CaKTvjcc28bqNasx+XuqbV3S+XV=HtQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/20/24 14:39, Masahiro Yamada wrote:
> On Fri, Feb 16, 2024 at 12:16 AM Petr Pavlu <petr.pavlu@suse.com> wrote:
>>
>> GCC recently added option -fmin-function-alignment, which should appear
>> in GCC 14. Unlike -falign-functions, this option causes all functions to
>> be aligned at the specified value, including the cold ones.
>>
>> Detect availability of -fmin-function-alignment and use it instead of
>> -falign-functions when present. Introduce CC_HAS_SANE_FUNCTION_ALIGNMENT
>> and make the workarounds for the broken function alignment conditional
>> on this setting.
>>
>> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
>> ---
> 
> [snip]
> 
>> index dfb963d2f862..5a6fed4ad3df 100644
>> --- a/kernel/exit.c
>> +++ b/kernel/exit.c
>> @@ -1920,7 +1920,10 @@ EXPORT_SYMBOL(thread_group_exited);
>>   *
>>   * See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=88345#c11
>>   */
>> -__weak __function_aligned void abort(void)
>> +#ifndef CONFIG_CC_HAS_SANE_FUNCTION_ALIGNMENT
>> +__function_aligned
>> +#endif
>> +__weak void abort(void)
>>  {
>>         BUG();
> 
> 
> 
> 
> 
> __function_aligned is conditionally defined in
> include/linux/compiler_types.h, and then it is
> conditionally used in kernel/exit.c
> 
> This is unreadable.
> 
> 
> 
> 
> You may want to move CONFIG_CC_HAS_SANE_FUNCTION_ALIGNMENT
> to include/linux/compiler_types.h, as this is more
> aligned with what you did for __cold.
> 
> 
> 
> if !defined(CONFIG_CC_HAS_SANE_FUNCTION_ALIGNMENT) && \
>                CONFIG_FUNCTION_ALIGNMENT > 0
> #define __function_aligned       __aligned(CONFIG_FUNCTION_ALIGNMENT)
> #else
> #define __function_aligned
> #endif
> 
> 
> 
> 
> 
> However, an even more elegant approach is to unify
> the two #ifdef blocks because __cold and __function_aligned
> are related to each other.
> 
> 
> 
> #if defined(CONFIG_CC_HAS_SANE_FUNCTION_ALIGNMENT) || \
>                  (CONFIG_FUNCTION_ALIGNMENT == 0)
> #define __cold                 __attribute__((__cold__))
> #define __function_aligned
> #else
> #define __cold
> #define __function_aligned     __aligned(CONFIG_FUNCTION_ALIGNMENT)
> #endif

I didn't want to make __function_aligned conditional on
CONFIG_CC_HAS_SANE_FUNCTION_ALIGNMENT because the macro has a fairly
general name. One could decide to mark a variable as __function_aligned
and with the above code, it would no longer produce an expected result
when -fmin-function-alignment is available.

__function_aligned was introduced c27cd083cfb9 ("Compiler attributes:
GCC cold function alignment workarounds") only for aligning the abort()
function and has not been so far used anywhere else.

If the above unification is preferred, I think it would be good to
additionally rename the macro in order to prevent the mentioned misuse,
perhaps to __force_function_alignment.

#if defined(CONFIG_CC_HAS_SANE_FUNCTION_ALIGNMENT) || \
		(CONFIG_FUNCTION_ALIGNMENT == 0)
#define __cold				__attribute__((__cold__))
#define __force_function_alignment
#else
#define __cold
#define __force_function_alignment	__aligned(CONFIG_FUNCTION_ALIGNMENT)
#endif

Would this be ok?

-- 
Thanks,
Petr

