Return-Path: <linux-kernel+bounces-64603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A7D8540C5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 01:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B387E1F2AA7E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B23D524C;
	Wed, 14 Feb 2024 00:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AygqfzxP"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9697F
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 00:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707869848; cv=none; b=p15CFFwMx2OsBpEj35vSFMOo/SAU9Fsm2v3ngqHKdPQIq6d8eqRKaxKuL6FawbiVBdZuxoucQNqimQ7Z7B3EvgZxAyYU7ZpAhjRBdipAng4WHNjSR3huCaqqWbrMG2vo/6YZ4Sn0hv8Bjq/NHwd9ucFllY570Ibu4ixnit823tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707869848; c=relaxed/simple;
	bh=GtNPwOVeYqEoQND8csoZlzv6nrrvTMepd1LrHxfG9Dc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nj3MoxRXehMIgoyyJIt/7sne81GkUoVSw4PQPKOrJZ+zJpMYMEXkkPyZUNcJkjHYmq+ofxjrO1KJWxfNW+Gmr1CaV8q8tEwJC3X7DZ5PIXsJW4OsynRNhCHF7oS2WfCNLSj4YEc60uenfUJcyDRSZ7yQ0IGawOrvfTZxmfjHUkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AygqfzxP; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7bf3283c18dso48707239f.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 16:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1707869846; x=1708474646; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8R1ZRFNPBDSJKTf9xhbBZxVe1DfFeuBRTvA+gPMKArY=;
        b=AygqfzxPcSpBt9KesQnE6Wuz8+5q0GZR5EcNGqBqN5oL4sLwczwO+s8i4cw4u/S+Bg
         BBGV26psU4x1Yj1nVOVSMlfYWbJSP9k7vok+ek0JkCE32/iMA75mwA9Dq3459qN5/0ln
         CZqKu3IyxAhsA7aWS2+3GjkxrPRo+VLcPguCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707869846; x=1708474646;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8R1ZRFNPBDSJKTf9xhbBZxVe1DfFeuBRTvA+gPMKArY=;
        b=akljb75alUKkeWS0cVUjje/K1LqZqlZ3qwNEYjVP+eUNFX81Ut4zFpxyKNZ+q/wr18
         9P6JiYnmivKY5YdvmDVBIx+cMUriqcuXpMZQXuXt92RJ3d9TXRfUXHsvAVdJZp2WID2S
         H1ReamzJRyTmp2pTa6heTqUaH9JfE+jasDQ1GKnujKBc2iZek/hex3wGptDgbua4Y3wU
         9Cvvd02AqzfAISNqfEmA1iJUY2GyhBfblJB6fbPi1gyCO0gIVtD+d/pTT555VbOn8rKK
         TmMzGkLVInd/n3PL3hrwjRmKbc1uvILRxNOidcGPD0z5QYqmm1OVb8uP1hgpMfbNW54J
         n+ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLOEORGMoNHiPSnvSop5yYOWSz2kHlvKLLPha95wEw3bE6ScB5py6UeBVBeXZRhlncEgRJ6dNY8oG11fqcLreL2RlAFmIlvyRP6v4F
X-Gm-Message-State: AOJu0YxzVbC1ml2UI6PYS5tX6gfVImTltCAOfvjtpnk3DN8/vsfjyfFx
	7bWpl0eBxz+2ALbR6K1wJdfaT9YrDVP3IEG9h4Nn2Ec/cIcZxQrtZA2cGqTq1ZY=
X-Google-Smtp-Source: AGHT+IFGag4hMH+UjZfIrNALOjx0iTOt+qW4FggRBh/NEjikHy6F0nGspfe+Go/nWvUqvVrOBwQjsw==
X-Received: by 2002:a05:6e02:1d87:b0:363:dc84:ef56 with SMTP id h7-20020a056e021d8700b00363dc84ef56mr1461086ila.1.1707869846047;
        Tue, 13 Feb 2024 16:17:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUJQruroDPboQu4W7vqSgcJpaFCwZkx/7K+IODSFDmLCHX3CTRFDleS5GZ+DK9cXEIPmDW3GVdi/2QrMsTZFoVHFT0CGXm99RLcvIXrcUBkxYNE0HgGeywyUvYLxTtVagWmjn0T9FhGUws1tvh+0x0x4YmRzcai0KfCTiWNa8x9/OUbwPeMPgCRWUtgoQ4QkJvWMAL84DzUUqdBO15C3fV9dJ/DrA0J48IKjUNn8v4vP6aoHNhkVXz3jAzSfhv7C3inKy6yNcREy1/rKgW6CYNF6R0rynxpLdb3KPlS3NSvAkNdE7jQ1t6ipIfcwIbMNR3yLlCPLAqVncB0kO1cXFF9OUnQWyEFhuo7/IJn5T17NW1PffTbqmJ59DHlBwaheWmAPMmEUochD3e68A4jmOhUZNOQq9ILcBdT2ImxIsewiBMEac1P6JmEWObXxarlYltdOiLnKqOsRrDfaTs4IEqSa+GhdtqjJkpj4Lt89dDKyrZNOeu9gT/4MwPxoSqiE4PnjPdOxarLJ4keORWfZZskCwbncdbK/vTCWzDf3sARJOLeF+pCu+d4BveMbSWknPW7kzVgDzSywA==
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id db7-20020a056e023d0700b00363bf95e16fsm2788860ilb.15.2024.02.13.16.17.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 16:17:25 -0800 (PST)
Message-ID: <a343de6a-c377-4a81-abbf-6e98652bac29@linuxfoundation.org>
Date: Tue, 13 Feb 2024 17:17:25 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/64] 6.1.78-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240213171844.702064831@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240213171844.702064831@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/13/24 10:20, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.78 release.
> There are 64 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 15 Feb 2024 17:18:29 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.78-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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

