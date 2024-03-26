Return-Path: <linux-kernel+bounces-119819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D43E88CD54
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAEEE1F3FBD7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F0413D252;
	Tue, 26 Mar 2024 19:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OMbKCBdi"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0926F84FC9
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 19:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711481963; cv=none; b=E/Na3WCzqOcpWg2iYylCiOWqugIdwHeyyJmsTXJNCaOppHAw7ilV2q2QRigSXZ+TJWAQ8T0+/UUIfILrsvsu+QuWrGQz6W6E0PoF1pVNrIlT7AodgXaIVKip3z5lW3Q3KXl9hvM+9J5c38mfKHwIbWrlStBwmrKQ1PU2ZBa1uh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711481963; c=relaxed/simple;
	bh=f8IAuCv4gUREScserGsKJssKOzX2hE9FKGkkBG8wz28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=goaZd/C+FVDxV8jrZKcb8E9SdkNHyzmlTds5XgEJvuYJjmVLA+5r7S4bBgmdGVFWgH6d1zp9VtQiPPvNvXMSXo+gKsB8Cru6de8mXB+0l/r2QVLmPhsMPL1YjYZLOUjJMjy3Xrha7OBGkO+H1iV2RWPoKo5WgY9sls2gJJtAWko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OMbKCBdi; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7cb9dd46babso38869839f.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 12:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1711481961; x=1712086761; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1hUrXnVJiaP3UIt3+1+KPRUPhVeRHkFsXjdILUhEUUw=;
        b=OMbKCBdixfQcUvIcg6bhzO4eYUnCp2dgAxb/SZvtcQCYXzEdNbHqdQndm0Bhtu+Njj
         jnuOIc2a4GZwGHBQoq/3/9alMWQkhcn8066iR2EEbV9YnNi2usF68ygWJLDoKdhnzCzk
         JsebbDMyJgIUYuogWndOcewt9P0VbrM0C6PUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711481961; x=1712086761;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1hUrXnVJiaP3UIt3+1+KPRUPhVeRHkFsXjdILUhEUUw=;
        b=HduQ+R2UNv9EcdFQIAt63PtBJbkpIghzpw217BRturAEPEaUeUVxKAfH5VPhF66ghc
         lCC3S4ROkzL3Zh1KLv8hrYPdAm2cK5Yon44GVw3YX5LfV+Emb9GFe7ulK+4KGB5ZaPyU
         MLzm3WavLl8/ejrBBUbr//8WKhQjirPYS8GoiRjggG/RC8te/mxODOHj0oqLEjFCsr8r
         xbq6fF1f0s/a8Gj+2ylgoscx+TO09fXmlqpmBKnAnXaL1ZW3/RMg2wPlnwVDfwlyX05U
         dFmlKrs+DJjZqkxhl0pcfFU7aPanAYk3pvSqAvzd8NwiClEiUXMUAhWdCl3JR+7hF/aq
         pSLw==
X-Forwarded-Encrypted: i=1; AJvYcCXhPkMadygfyI8SLT65VvUiMrrlPjJWqmpqbz482A4kUMqBiCP/WI9PRZvCqbVjAx/jaaqjISx/5tX4G1SM/D0TpMelF28VfcFdoqLG
X-Gm-Message-State: AOJu0YwfW6gZnFq/n5tBurFFxMLBEwv2O3/KdYrcz+aL+3rel2oq/aJx
	AM9pxkgaHsQ2J9zsB2Jis8ooeztz7eD8Q9GFg29GVnhkmaxrvhAe3t79qhFfG5zK6yARK/Z4t/H
	5
X-Google-Smtp-Source: AGHT+IELE5TEI/KwSAhMRRyWge1264Y2/bq1sHDymje4IB2JI1C7z0RT3ECNTzcBbOsmujdjyvwpYQ==
X-Received: by 2002:a05:6e02:20ee:b0:368:76cf:2c97 with SMTP id q14-20020a056e0220ee00b0036876cf2c97mr13234789ilv.2.1711481960492;
        Tue, 26 Mar 2024 12:39:20 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id b4-20020a92c564000000b003688e773845sm1536623ilj.59.2024.03.26.12.39.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 12:39:20 -0700 (PDT)
Message-ID: <95c18689-6a98-4d5c-9b38-200270696662@linuxfoundation.org>
Date: Tue, 26 Mar 2024 13:39:19 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/seccomp: Try to fit runtime of benchmark
 into timeout
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>, Kees Cook <keescook@chromium.org>,
 Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
 Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240325-b4-kselftest-seccomp-benchmark-timeout-v2-1-77292da87966@kernel.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240325-b4-kselftest-seccomp-benchmark-timeout-v2-1-77292da87966@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/25/24 10:57, Mark Brown wrote:
> The seccomp benchmark runs five scenarios, one calibration run with no
> seccomp filters enabled then four further runs each adding a filter. The
> calibration run times itself for 15s and then each additional run executes
> for the same number of times.
> 
> Currently the seccomp tests, including the benchmark, run with an extended
> 120s timeout but this is not sufficient to robustly run the tests on a lot
> of platforms. Sample timings from some recent runs:
> 
>     Platform          Run 1  Run 2  Run 3  Run 4
>     ---------         -----  -----  -----  -----
>     PowerEdge R200    16.6s  16.6s  31.6s  37.4s
>     BBB (arm)         20.4s  20.4s  54.5s
>     Synquacer (arm64) 20.7s  23.7s  40.3s
> 
> The x86 runs from the PowerEdge are quite marginal and routinely fail, for
> the successful run reported here the timed portions of the run are at
> 117.2s leaving less than 3s of margin which is frequently breached. The
> added overhead of adding filters on the other platforms is such that there
> is no prospect of their runs fitting into the 120s timeout, especially
> on 32 bit arm where there is no BPF JIT.
> 
> While we could lower the time we calibrate for I'm also already seeing the
> currently completing runs reporting issues with the per filter overheads
> not matching expectations:
> 
> Let's instead raise the timeout to 180s which is only a 50% increase on the
> current timeout which is itself not *too* large given that there's only two
> tests in this suite.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
> Changes in v2:
> - Rebase onto v6.9-rc1.
> - Link to v1: https://lore.kernel.org/r/20231219-b4-kselftest-seccomp-benchmark-timeout-v1-1-8515c73015b9@kernel.org

Applied to linux-kselftest fixes for next rc.

thanks,
-- Shuah


