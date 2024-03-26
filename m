Return-Path: <linux-kernel+bounces-119540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FB488CA2B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87249320E53
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0199F1CAB3;
	Tue, 26 Mar 2024 17:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HE17y/Ts"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977691C69D
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 17:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711472617; cv=none; b=lfdY1scWEPEX4rG8sQ5Lz0/0fA0TgcSB1+Juy7JFw0pLctx2/nymavXkPN61WVHdluD4WtdbW2s2xRgPz4OWk7Wlyy8ZZPHwqyHFrtdqQTycWlNy5pqXd5VptZMl5L48kdv5VvxWMURvOSBxuH8rF64IjLDyjUFmeCuvhadkgLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711472617; c=relaxed/simple;
	bh=EOIwSflAMj+uoDKrD29/XL4C7buZCq5H6gnUJLDPy4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AtLdV1J30bhX+c1Kl1MGjXOc1coqVr3W3+UFmma8t9LevTA6iF1dNcLW9GKL/pgSI73bjmTotIky769DVj0l2c0nYB3hNYgWjalJQjuYF5+xPcd/wNTcal1Pfq7/SSGzsMQewxBf084cs83DHL5J4J4h1IoZRPcjVcUPyln0y8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HE17y/Ts; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so83177339f.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 10:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1711472614; x=1712077414; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FadKByhjEcDx2BLRRuVA0xlYC6rBI0jxy9VlghDSGvo=;
        b=HE17y/TsntXoGa4gyYoH7jYuqECr8lFu98VTfoUMxahh6YCyP3zxsIzlR/igIf4IV7
         uiMc7lGxKDkRKZYXIB0GUeLcPRechsBipwmaY5AgOWfutZPEMuyPAx8XRL+LInb4umrg
         0TQxjaGTF8wz+jdX5ZgRZObXQZ/JS6Pr8pU2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711472614; x=1712077414;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FadKByhjEcDx2BLRRuVA0xlYC6rBI0jxy9VlghDSGvo=;
        b=OKgextYwidC/hOpZP9ieqsZosCsddMs2GwXgTw71av45dKbO91xpuTRGBjySngszvW
         D80DqCKBLgRKV1elJ6JJjhewe4SXbA79S9jlwlBwHaCtkO0Ifgrs6+ebZDxxE4gKs9ex
         f3L0Jct0cGLsnreXh4yZpKpIP8huwkF6YJKKutOyW40R8QrIYZ1qHjIx9ZUARQcneQPQ
         QuvoEeJonEqyahpLhDxZrnf9O1rr0FlXKCr0ssgDQOrv4SGYz4IcGTQhlmcpNoD8GIkN
         mp+VLSVcpnV4pvYMU3pATH2Sz+dgbsD0GoMCiAe7riDaASWtnKJ1ciixaTe3QYj075bO
         JbLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhN4EXFhRa6lioUmZ3rykbi4G088aXuFgqzaS88jH5Fqzrgdy6Kea6iOMeuZqzYjPiD41bwUa/s2zPQGX6DGqvF8LDCmxLSLXKtiTn
X-Gm-Message-State: AOJu0YzVOwZ6d3bR8V57MOiLH5C7qaED16NkD0S02DBBZq8QhXEmxlUY
	1xbJ6i3poLy4K8TuRCgqB5uXxwTdmsmIxEsmoptSAemnNoIOxdLdgm5qVFk1JRE=
X-Google-Smtp-Source: AGHT+IHlnbl8Kp9qRx9T7KqLxILUY5M2NuRzPdWJQoe9ZoSIcJ+aIjNcMyXGzxe/pzHbHLma6Fes6Q==
X-Received: by 2002:a5d:81da:0:b0:7d0:4d78:989b with SMTP id t26-20020a5d81da000000b007d04d78989bmr7534219iol.2.1711472614680;
        Tue, 26 Mar 2024 10:03:34 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id q7-20020a5e9407000000b007cf1d77305dsm2987494ioj.53.2024.03.26.10.03.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 10:03:34 -0700 (PDT)
Message-ID: <651e3b4b-294d-4700-82da-1042ea70a5fd@linuxfoundation.org>
Date: Tue, 26 Mar 2024 11:03:33 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/632] 6.6.23-rc2 review
Content-Language: en-US
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, florian.fainelli@broadcom.com, pavel@denx.de,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240325115951.1766937-1-sashal@kernel.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240325115951.1766937-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/25/24 05:59, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 6.6.23 release.
> There are 632 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar 27 11:59:50 AM UTC 2024.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.6.y&id2=v6.6.22
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

