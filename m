Return-Path: <linux-kernel+bounces-75653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F9D85ECE2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5454F1F23B48
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382D9128824;
	Wed, 21 Feb 2024 23:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfD9tBUA"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8A2EC5;
	Wed, 21 Feb 2024 23:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708557970; cv=none; b=q6cTMRo9TaRJhM+1v2VyXRYV5ApSouSeJ5E7zMr0dWslK+n+nekCSBdFxnrDzMccM2ZGOUIATc50H3S+3Rspkgg7BEwO+tGB4518IQA7SMDtTwNSVtHNgXvFIM6ukafVGwexDMOh+Qr7dgPzBksHSfHHJQpuSGLaiMt8bSA6U/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708557970; c=relaxed/simple;
	bh=cLrGhOhaE4oHc94BO6GQrRS9UTk5Y8xjOuCUBV7JkNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fkjjrN49KVkSGHUvMCcYCjyb916kouy9DikppL54nkK0PlWxbZxHmGXwNE5DBxMWGvCYH1fdvni3nHVhBfngwpc3CQydoQmHriFre1aenskvDDMfn+F3CcodPLDBfTySXowtpyEP/h8lMgeUJ/I/aZj+/yhR8BMM65WL5PtIP+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RfD9tBUA; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7875c347a57so252207385a.2;
        Wed, 21 Feb 2024 15:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708557968; x=1709162768; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7sv3xme2pkmdyf10k62kb6/EdiEZUt8KbocWy1V5v68=;
        b=RfD9tBUA+VFVPVqNkXoTcGLQCSndnIU+3I89O0wbl+ThMM8c1BDhFudNc+J+jo8m/3
         WWaooczQkLvymrZktDTcDpqEUoUS9qfcWoFnQdHmGhChhcMOq8I7O2n8sLU2rALzewlm
         mMygta3I5klP3+cU0fLQiw0OdFagtO7NHIsSXeThSuHGzHg+JIYXitCwFH8h+4Sm4u7m
         WIbOaAhDNeFk0KARTF+aze3uR1ldbsigH6yHpebHPm2HG2UfSa33/zzZpsbnzRTyDdUr
         3Kz9B/Cvtzrt8ZPGA7o5Gn23+atqlw1XW3HfvSFt1LlA9LcSSk51IF9oijHOKLbzyiWE
         7kTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708557968; x=1709162768;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7sv3xme2pkmdyf10k62kb6/EdiEZUt8KbocWy1V5v68=;
        b=dGecGLh/+ivgYOg4dT/E2HvZqY3QgHWI2Tb5MtOG82TZOsuA5/LYssaz8/ST93Cm37
         MQ+seXJlA2s7JW5aQyO9pYNailvmNbGqPi5hHm7di5wKL77Y77vvERHxLe5EmUzXkjNQ
         5xBUU2a60x9BygHlg22afDYPYCU9CkINiUKv4N3zwgRuYDqYncxw/eTbsYkMJsS0oz9S
         ++t3adbh1NOlQhMdchiaDbbTCUdWss1XkybvcxSkNeU4hZ+aUOf5pqtGBaZRyEkhpO5v
         fy7YJQFE0fOI+2J+62i50iN7ZskbbkgAiMNa2u85GhmbEUn0skK7GQHtup/6O73dWQaa
         V8Pw==
X-Forwarded-Encrypted: i=1; AJvYcCVfV+Aj3hr1Hr+iqurUKz6nnhJIa93Do7ZvlNxSKxCrTOJem3qdEqx2fJtcWE62VVacyOM/Z5tjf3aKGpVguUtoJ6E+W6I4RHi6grBe8KAEwZFIQKjt45UZuXMFujAoZkbj1BpT
X-Gm-Message-State: AOJu0YyO05gcwehT2Ud5fH/Wpgnithx4Cn2PdJHjqVc0No9/7gP4QYF3
	0HLGQpmlO5Bc6WUM7suDMmNWRLqWmibneMvXJ2M3YITcnotKZoEO
X-Google-Smtp-Source: AGHT+IEmMlGNptSf6TjZwpfySh/HXHnOQ1Bw1JZH2A03Xa9iiOh52VJprA6DzJ/KQOMfPewo6tp2ng==
X-Received: by 2002:a0c:f551:0:b0:68f:4d2d:3f30 with SMTP id p17-20020a0cf551000000b0068f4d2d3f30mr11987645qvm.51.1708557967946;
        Wed, 21 Feb 2024 15:26:07 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id nh6-20020a056214390600b0068ce9f8df8csm837591qvb.115.2024.02.21.15.26.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 15:26:07 -0800 (PST)
Message-ID: <6ecc87b3-0a44-452d-81bb-4c18911a1c34@gmail.com>
Date: Wed, 21 Feb 2024 15:26:03 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 000/267] 5.4.269-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com
References: <20240221125940.058369148@linuxfoundation.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240221125940.058369148@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/21/24 05:05, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.269 release.
> There are 267 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 23 Feb 2024 12:59:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.269-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


