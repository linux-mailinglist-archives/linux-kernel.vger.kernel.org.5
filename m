Return-Path: <linux-kernel+bounces-75007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA5685E16A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97D56286F01
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935248063E;
	Wed, 21 Feb 2024 15:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g7NkZZSa"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0B580618
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708529874; cv=none; b=U/mCsI9fnh/F4c7TMojxB+zAw/B4QLMksOENLSvB/+mf0noU+SoFxL5g9m20P8GZLP8eKLfsZLf7rXxSh6nJqrk0/34owJpqpelXvv52Yo5O+LH3JsIgrE274X79c2KjCdGFDOOlAUubiFRv4PxoQ/QkqzNNrSZUJsw0D1Y3QSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708529874; c=relaxed/simple;
	bh=GVmjKweFpkvqNGNICWL3z3UdvYBia4a0Ku2Kgy+MvZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HfcThhTXreCWwF5bJF3x32YiVgDy1EluUouJH58zsONAqrkmtXwaEQvk0aFEIe1tEuHaaF0OVP6bhYv8uzI6B9gyj8kBBIpE4rDOsPCoSSmBJFUrxxye3ADL6LSvtVVUW+8qQUFUPMCbvmU60+INW0iTo07f3vYmiSmnGbPcCmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g7NkZZSa; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7bf3283c18dso107273039f.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1708529871; x=1709134671; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jgzt36BlzBXtqVbdNQbmcPDo4k/aD72MiYTSmtpMR84=;
        b=g7NkZZSaZpZsMNCfBqfjtL4OjXg0C7HaYoffOG/S/IPEmzHta6IMwbVbrsC+2spqDW
         KR9p+EsgDVfhWn5pbypNnYE79s8JNNhS0e25NaZg+0meaZFW2uYiHjia/xBLGaVZ6+y+
         TwsWawBbt/ZZrLzeq2QzwmZG9vRa7H4m5v7Oc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708529871; x=1709134671;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jgzt36BlzBXtqVbdNQbmcPDo4k/aD72MiYTSmtpMR84=;
        b=j2KBwn1AXORwI8miRJk7Jzt/tuoK25Jf1jErJOIliAXAT6hzYTODf8y24EQ07gqQUZ
         rS+4PItCejCt691oPvv+Wms0WGT/87ZutqftzVT040PVhChxcmqvjfefgD0gBnVj33dL
         5EcZC/9QK34WC/mY0OBjZ9mF0O3Vpsz8tnPpwxveYPlqyYsCIR5VFHdL+vAM8qHxzIvt
         /8C8E+t4SQqixqoBKXUH7OQcsgpMIOU8Gw8LqKIeQVbcHbzagd1w6OGC7rgPXIzr1lcg
         o6yJ+9yt7a01EG6QHtlMoOQ0Ww+O9EAWWbmck3GuR94ije9aAeODGKj/QnPgMR/Itbzp
         tREw==
X-Forwarded-Encrypted: i=1; AJvYcCUjgRGTUgzESo1KX8c0pS4inEr1gEJ2yvA8h+os53GpQZ64i3HkEq5lkAjsLknH3eQ02X98vCD8W0wAfrNk6QE7cLdn/nbvLAvpqKyu
X-Gm-Message-State: AOJu0Yz55c10zroXUmqZpKNKgYgv5+3aJecoRjRHs3UW9x5p3JWLnqaZ
	193za/r+Td/rwD1yYotGrxMcnvgoF7PsfhWYo1bgETrVTW1v5yyHSBMOCpQT8B4=
X-Google-Smtp-Source: AGHT+IExr/IvF/UtOz3IX45Dm147dWyye0NzXPRZMjCGqlL1L00lNeoZ+bFHxdOc3K9jwHGjAud59A==
X-Received: by 2002:a05:6602:2cd6:b0:7c4:9e06:b9c8 with SMTP id j22-20020a0566022cd600b007c49e06b9c8mr17837772iow.2.1708529871177;
        Wed, 21 Feb 2024 07:37:51 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e3-20020a02a783000000b004743cd55d69sm767784jaj.163.2024.02.21.07.37.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 07:37:50 -0800 (PST)
Message-ID: <63bdded0-e625-4a80-b85f-01032656108f@linuxfoundation.org>
Date: Wed, 21 Feb 2024 08:37:50 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/331] 6.6.18-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240220205637.572693592@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240220205637.572693592@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/20/24 13:51, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.18 release.
> There are 331 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 22 Feb 2024 20:55:45 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.18-rc1.gz
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

