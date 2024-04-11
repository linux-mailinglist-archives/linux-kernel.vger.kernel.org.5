Return-Path: <linux-kernel+bounces-141602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 005198A2091
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 23:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D18B1F25690
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 21:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1060E29437;
	Thu, 11 Apr 2024 21:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TGreNy0Y"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88F013AE2
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 21:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712869308; cv=none; b=WUsljnMf3vjlhN3Zjw8Fv20PCFlV/XVfsueJQ3/BKCeIsLg9VRlOLvxZ1dcww9Xq3bFqfJ2mimNE24TSQqLKc8UbHpMa/+kN/pHhwoxofd7Nbz2CXXNh1vSXiMKEs8YPi6J6lAjWFTQX2YBJc5hNTgVi49vnjn2jyvTqHTaoYG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712869308; c=relaxed/simple;
	bh=g9Z9OwBbBlUj3EmCyyduc+Z0LyVTi1wB3j1o6dvX7K8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jXyqZXY4imNKL0qZBs5N3wIjwWl2vUR3cBccLE9VTX4tX6vgtJjlYe1LBogABRtsccbUN0z1RAKLP8sNosK2Fn/5MK6eaJGHd6+WAEvJVZMbdXdMyu1fiasPAvjLET7Ac1pB1xVrvh0cBclD0Jak8DKEJVPGxz4oTS/g4OCmUP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TGreNy0Y; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7d0772bb5ffso5314839f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1712869306; x=1713474106; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mz0LAgWqLQ4vIJA31FUrD4xAYvlItStjsWSzrqzF/DI=;
        b=TGreNy0YEyauNqSeD7GlkAQxUm5gG2YbbhaBo/UkE/dAl7IfY3cnQVL2vggBcJMgLC
         EUVM2YwOhvW1PtPNd90BIOF0Q5x5JyhoKERjumgqE3xBinuhNhw6HuKBYWu/S6iMn8f/
         U9t4d3BkJGF247iWhkprUjqBBigCeBJr+EleA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712869306; x=1713474106;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mz0LAgWqLQ4vIJA31FUrD4xAYvlItStjsWSzrqzF/DI=;
        b=fQXa424T/tW7CEBbFBdGUz3m0EVa4CaMJjfAM7PG1VwQGsqyTPP0beV6fgVTfz49aU
         dVVeOuMxJ69lgdIaXYqU9l6wbZp+COGv9ChxnCPkrAOILfV83MPa3aWlecG1RDQmk14l
         WZUNaxvlaC04ICmL9V0vZ+JD9qjemmA9AIqrKebC9D1PRE3QYxMUcXpD0reMlxVVDuhK
         c6MMXqWi3xP4gTkh9CLQEvyi3eeO1/nObYqDnM8zRUKrdtqkfu7luxZgbuI7keuNImLC
         4QrHKJBoLkUbzqH1xO2qnH2uwFv855Rtw/Pvg33WYaAN3RhtTUOkE79gw4F6gxR3/YwE
         +IPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwZ4drR9Q9XJ3ZgQ4HvcISkz6ksKFOiZWMp6kpu73aBuxCYyuFWoJIuHuLi2AWMCy4IYbu4maX6ksYdA9x7k+4pAokipjcyKfw3CEd
X-Gm-Message-State: AOJu0Yy2TOgBePppX9Di17CZNXYt3B0klnwSU1YyvgIo+Tsh37BnMy+N
	QNeA/9WPKJx5qCD8tKhhMHyvlaVtQdkD6wodE1/w28ezAJgxaH0g2tsdSfBXO04=
X-Google-Smtp-Source: AGHT+IGsEGdSzFgXCL4lsDcVpmS1rvpe/RPrF3+da8lVZtwQ1MRvl8rCasczN/FrAV63L5n9RkrXvg==
X-Received: by 2002:a05:6602:4ed7:b0:7d5:ddc8:504d with SMTP id gk23-20020a0566024ed700b007d5ddc8504dmr982307iob.0.1712869306060;
        Thu, 11 Apr 2024 14:01:46 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id u22-20020a05663825d600b00482b91da84bsm605270jat.58.2024.04.11.14.01.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 14:01:45 -0700 (PDT)
Message-ID: <dcb1a59b-55a0-4a33-99a5-3800660b04b1@linuxfoundation.org>
Date: Thu, 11 Apr 2024 15:01:45 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: timers: Fix valid-adjtimex signed left-shift
 undefined behavior
To: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Lee Jones <joneslee@google.com>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240409202222.2830476-1-jstultz@google.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240409202222.2830476-1-jstultz@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/9/24 14:22, John Stultz wrote:
> So, the struct adjtimex freq field takes a signed value who's
> units are in shifted (<<16) parts-per-million.
> 
> Unfortunately for negative adjustments, the straightforward use
> of:
> 	freq = ppm<<16
> will trip undefined behavior warnings with clang:
> 
> valid-adjtimex.c:66:6: warning: shifting a negative signed value is undefined [-Wshift-negative-value]
>          -499<<16,
>          ~~~~^
> valid-adjtimex.c:67:6: warning: shifting a negative signed value is undefined [-Wshift-negative-value]
>          -450<<16,
>          ~~~~^
> ...
> 
> So fix our use of shifting negative values in the valid-adjtimex
> test case to use multiply by (1<<16) to avoid this.
> 
> The patch also aligns the values a bit to make it look nicer.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Lee Jones <joneslee@google.com>
> Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Cc: linux-kselftest@vger.kernel.org
> Reported-by: Lee Jones <joneslee@google.com>
> Reported-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Link: https://lore.kernel.org/lkml/0c6d4f0d-2064-4444-986b-1d1ed782135f@collabora.com/
> Signed-off-by: John Stultz <jstultz@google.com>
> ---

Applied to linux-kselftest next for Linux6.10-rc1.

thanks,
-- Shuah


