Return-Path: <linux-kernel+bounces-123421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC01189086A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B63F291235
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E88E136E1A;
	Thu, 28 Mar 2024 18:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f7/6KMub"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA5581725
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 18:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711651203; cv=none; b=YNxz3exLzAU24890nGGxs5VQIGEUDRfiAeHANb5mgYLFbTzVXsfcJ/wTnCLo6UQ7xxwDfrgw0rCSyWneG+qH4RpG3QS6ft6lFaf4yQcSlKUav1pdKGpLe+X4PcknoKUg6aIJKwv3etD394ajbtsSnCVraFhFJQyQKMXCGdoH1X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711651203; c=relaxed/simple;
	bh=5ORy6hh6Pj4sj97rnaLda12WtwInrQlYkxhTjSS2hnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ILZEfKfPAdR0BNSAmi++tLnuYSTJDm5OECZUy67Q5Zzv7AuPre+jtIrEoe8nNkFAAypDMqUUIuo4dCi1ePoroQgYuzR6D1IyYz2KvO0I6pctBMfoXRNYChJk1jqEXSbrO9X2HBz6qly+wJ5GP5TYlJhoQsC4dMe3fs+fIMx+qMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f7/6KMub; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-366b8b0717cso1657915ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 11:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1711651201; x=1712256001; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y2g0kgrksduzPpTAzBEbZB+YDBF3iH1wIPE3J9n7lWg=;
        b=f7/6KMubQtVrgCfHgLqx3nCdD2twAmAdO+hj+kA2Um1mhlo8Y7tcsDRLNYyEBj6RkW
         wcZugbwgl/Wmpc5vqrMpv0u3JuECmlBzG+YTAVCee/K2EoVB/n5KRXL6y+rq5J4sLvUz
         ee8cucL9m9vNZ8a2M7rowPlnQ8gfBWgWsE7oY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711651201; x=1712256001;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2g0kgrksduzPpTAzBEbZB+YDBF3iH1wIPE3J9n7lWg=;
        b=cotQwql0eLVzOwPnS4K11sqbU5KYeyK2eKPZFl89ffoIMFhDUJn0aarUXZRFxe5U+d
         9QwBZ7FgShQ2tlZel/B5kGHiiZhNN34Q8OKDx4eFkvGaTq8FYCUjEuPz1r5FACGDsiSs
         HRCOsphkxFw7vJCQ8ZGS6hRSwiPyZrFoojSkE2Cov+0iNEABX24eqQpSVAQXbIvd7wKy
         7gGToMPRnA5cjVqCk0Ag4/t9OZeRSf00xfO+ioBG7ydyB/FFp7SmAMaMn5JIWwufKwx7
         lFvPkz6e7MfCKSxb0Fs1OXsoDvyG48w6EA+DC4d3S/NXcl46MnWNqnH1maFTjGhfWc3d
         lX0A==
X-Forwarded-Encrypted: i=1; AJvYcCUecXCvqWCRRrySixCXYs3t2oyY9So3IEaP/ip/zR+gIi4AapH6cESNagLQIh9HVxSsEaJFnPaZ7rnv7nTh6O5xO/TxB427sctk3Vqj
X-Gm-Message-State: AOJu0Yzhf0lG8JOcjUnig3lSxPykS+8uPXxvT8Wv3hY0uNd7poqaPo5y
	m//d6PSQkjZl7WunKPcDlT+xiimnMtBofDHoN3OI7vRVpq299pRGxofWX4sdZ4yCPq5a9pDJr9n
	d
X-Google-Smtp-Source: AGHT+IGd+gyzScz2N+XqO9Cc1NJsPFjnzA8T8an4jUaf7fymquIzGI6WsTJTBaMFXavIcNu3vQNLGg==
X-Received: by 2002:a05:6602:2bc6:b0:7d0:8985:827 with SMTP id s6-20020a0566022bc600b007d089850827mr52930iov.0.1711651201099;
        Thu, 28 Mar 2024 11:40:01 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e12-20020a6b730c000000b007d057e4a970sm531652ioh.48.2024.03.28.11.40.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 11:40:00 -0700 (PDT)
Message-ID: <b06db8aa-9548-4b92-af7e-61fbd8a654c2@linuxfoundation.org>
Date: Thu, 28 Mar 2024 12:39:59 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] selftests: x86: test_vsyscall: reorder code to
 reduce #ifdef blocks
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>
Cc: kernel@collabora.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240327184637.3915969-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240327184637.3915969-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/27/24 12:46, Muhammad Usama Anjum wrote:
> There are multiple #ifdef blocks inside functions where they return just
> 0 if #ifdef is false. This makes number of tests counting difficult.
> Move those functions inside one #ifdef block and move all of them
> together. This is preparatory patch for next patch to convert this into
> TAP format. So in this patch, we are just moving functions around
> without any changes.
> 
> With and without this patch, the output of this patch is same.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---

Pulled all three patches in this series. In the future, please
add a cover-letter when you send patch series.

thanks,
-- Shuah


