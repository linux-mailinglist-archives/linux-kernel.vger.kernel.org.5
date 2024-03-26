Return-Path: <linux-kernel+bounces-119468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8AA88C95E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB5382E8807
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0651CD2D;
	Tue, 26 Mar 2024 16:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GQCpPJWM"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA071CD21
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 16:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711470698; cv=none; b=UNaClpbe79BrZGKJurcKZVObZozW9obyeIpRS/uwl9GF0yOcid45OsfDrI2Lq6+wTZOgT1NDVtX7ycBqXcthknKo4BYXb174QslzzlCAwlgsxJgBw6xFK5gKwU0vpbGKExs9lHou2cd/7aRDBKMAEaItvUgpPhQwbooM1XQjomg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711470698; c=relaxed/simple;
	bh=L8F1Vday+FWTauVFASCsmeZfL566744ShzHCrvEoawo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uCR114Y6ZN4pGNF3wc0PIreyLnWV45cGJCQO91kCa3pzdl5alwPaS50Y+b9CwtJPhIlIjuYE/w1rHKLTYx13LA/AMePJoendcTmUBy70gghBqEbxYEpmYufW7T3CXJgKwRmQA7P1I1yVFJ0rBz0RUcoPg1wUqa+rZCzrGcu5d34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GQCpPJWM; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so82618339f.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 09:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1711470696; x=1712075496; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yfNkAoiSfqoBMHCXTVNDVvy9Q+IeLxX3GnUaU3hi0d4=;
        b=GQCpPJWMQXyquPBuat2ee2x/QdutadD05F6NNONbsn16MB6fqsh/zeWjc5Y7Wrt+FV
         eoAWi96dUTUDltJGy7XlsQpvhjZygAlCd3fligBw1E7jKni5MpD872YO8EnIYpcWBE5Y
         QjDOTI0ggq742mbFClcrS6vemgu+KdFgCr+i4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711470696; x=1712075496;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yfNkAoiSfqoBMHCXTVNDVvy9Q+IeLxX3GnUaU3hi0d4=;
        b=gEbHL769kuO3Bq8QkMnHsI+2CfodDz7wZN4rYycxj5nqZOCOJtDZ+gaMRfHsZ62prI
         KNXtzSeRqux4A9+3sKSVXBW5ykInJshEROsS4u4vFQlfJdSFl10XftjH+yZ37rbFJslW
         XVbAIz5YRPVEU4g7fxunNM8osoLepZcretKCvzeca6XpV/xTLtob8j1GekwWyYHU5tkM
         ce5VuBb4T3JxwY3Y35/SjgNYnWQSsKJg5XwhfxtwwZBvQPTxX5vZKZHMtuhGG56YD5Nm
         GbAnlKqAH7+rOTZAAXw9bYXAIX7gABFi5LeVhkoNmHXzy3llC+2SWvPKe1UjLIg/ikcz
         glQw==
X-Forwarded-Encrypted: i=1; AJvYcCUonPr+3yuXyKddnEJF2SeFZ3m3weuqS6ijjK8OMUxJBm4X+tB9M9kY/yPmq5NcXTklyAxKAxswLEGU60YNQgq4KIr3Y1f/G3qxBxqV
X-Gm-Message-State: AOJu0Yw+zSKU6qZtlCdwJZ/faUCbEY55oZcfCFffMasamqw4BInbMuMG
	Dytl5U/bHz9BaoOhtKqfrtoQmZfgU4yzDIjoCxQvuY33A26+Qk9fdAzkLFQkDhY=
X-Google-Smtp-Source: AGHT+IFIOB1uF4sWL7izkguhAPjySDqnZ6uh5l39VZAdtGVMXGjChQ80uyufCBBSqdun6dbA6+2skQ==
X-Received: by 2002:a05:6602:335a:b0:7d0:32b0:5764 with SMTP id c26-20020a056602335a00b007d032b05764mr10760573ioz.0.1711470695931;
        Tue, 26 Mar 2024 09:31:35 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id dx11-20020a0566381d0b00b0047bf1cc6b42sm2782232jab.138.2024.03.26.09.31.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 09:31:35 -0700 (PDT)
Message-ID: <bede7f50-1355-4a1f-8996-04a5c3eff8ea@linuxfoundation.org>
Date: Tue, 26 Mar 2024 10:31:34 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.8 000/710] 6.8.2-rc2 review
Content-Language: en-US
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, florian.fainelli@broadcom.com, pavel@denx.de,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240325120018.1768449-1-sashal@kernel.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240325120018.1768449-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/25/24 06:00, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 6.8.2 release.
> There are 710 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar 27 12:00:13 PM UTC 2024.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.8.y&id2=v6.8.1
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

