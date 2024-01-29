Return-Path: <linux-kernel+bounces-43610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 034AE8416A5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 00:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 710AE1F23EBF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A11524AC;
	Mon, 29 Jan 2024 23:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y6iN2Icg"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF9653E09
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 23:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706570104; cv=none; b=aY/WOmD36GyGicVzBK8uETxCis/OigfDBssLPgugmdZrKDS/iMr8xiCLrU37c0nh94hUb0+sF4mQrMfAqhSGvTowjyrL4MkxlEsOs1/YIkTjMlSE9xI5qSF1f3u/oWImslpGS0WnADX2aPhg0doETkYkr626OdCKt0lFZmQdfvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706570104; c=relaxed/simple;
	bh=ehbO0HFf0uL/p+JVVry66GgwWQcsluKxO5QnGZu2pHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ey6q2si9SCJaA94mmnCwfE15xilzTYwt2A/MJUzsksa+MssgtOeIE1p2o2TjV4aHs+im5Pra0kRzCkOD4vfaa1u6Bq8sAOl+/x9X749hvFOIIcz+msD5XKICxxZV1q3Pz9CPPTQLVd+4ZmTQcMfP0lc177Y5kvIbL5xDLZWvX20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y6iN2Icg; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7bf3283c18dso45590539f.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 15:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1706570102; x=1707174902; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HlEg0VBx55ozwcl3uKk0QdR1gxYWE04fuZIKqnVt1W8=;
        b=Y6iN2Icg7qSarB6L6MO2ZO3xqqEI1vHsK0M26IJAlFeCKwid72h7RKrHpN4DSUTyr/
         zXXpLGjuP4kQU0mFL7+Y/RCEGW42EBDvwe1h/NEgNDydRu4+X+2iAP/Wiiz0PoOE29ed
         2ep6GmmMJBg3UV1I3NMvsK7Q0cGrAoqNr7GZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706570102; x=1707174902;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HlEg0VBx55ozwcl3uKk0QdR1gxYWE04fuZIKqnVt1W8=;
        b=QCJ1Mc+4NzKbblKTW4KZe3GL0MlPFXq1VtVu3r5MQ89jjy4WMto1ZPAa+UntUB0DY5
         X9CmiXeT8xzzvdys+aiooqKfeW2dNBmpIMi3fzjUgqSM5b4gkmva8txOQ272F64evqL1
         oOiwHXNInT/yQJqW62pyLa/0fdI8B3+eUgwFuSXbA2SQi37exLdUdJ+ET7myLval/qB7
         1QKJLsdEbV9SmkJ79yb9xl3yPMJnx/dJW5oPAzLeUd9sjZiZwDyzCzVCHd+HnxqlogCw
         lYmybfA9pEAJjTdnWaEAsigztPkNZudXdlV0jWWEdfzEN3rjm+3To44xERKGp4xSS7ux
         uG3w==
X-Gm-Message-State: AOJu0Yz61kfbjFBUzNjFIfno6koy0gXlT5km9+tz27px1M7iYPulxtro
	eHUmHA6DfFya1VIFtoeAe/z/G2+t2Z/ABEwmumyy+ei/5qsWsZHCvpYDhnQzYfQ=
X-Google-Smtp-Source: AGHT+IHTwdmWs+k8W9kmfFqN0grLMB9mP0tEqiQOdwQiuLcTv+h5u+9+wvYtVGHtchOhzbsPR56BhQ==
X-Received: by 2002:a5e:870b:0:b0:7bf:b18e:fccc with SMTP id y11-20020a5e870b000000b007bfb18efcccmr8110539ioj.1.1706570102071;
        Mon, 29 Jan 2024 15:15:02 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id g19-20020a02c553000000b0046edf6bffedsm1988701jaj.85.2024.01.29.15.15.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 15:15:01 -0800 (PST)
Message-ID: <88a1bc55-710f-4d64-b51b-90787a4090f5@linuxfoundation.org>
Date: Mon, 29 Jan 2024 16:15:00 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/331] 6.6.15-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240129170014.969142961@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240129170014.969142961@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/29/24 10:01, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.15 release.
> There are 331 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 31 Jan 2024 16:59:28 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.15-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah


