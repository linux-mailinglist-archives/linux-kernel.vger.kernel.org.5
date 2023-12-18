Return-Path: <linux-kernel+bounces-4502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48295817E44
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 00:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50B841C2150A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 23:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD6F760BB;
	Mon, 18 Dec 2023 23:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EuSZW83S"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD7A37865
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 23:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7b7117ca63eso43185939f.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 15:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1702943730; x=1703548530; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tAAwxG448biTn8MtDNLxgJZ4OzA1M5+6aRFoz6CAg/0=;
        b=EuSZW83SEdmKbQgpEv94hLleQ5OLV7eI5BboeDxbs1t6eLDGke641mjR9lLkt4s2+E
         L3A5ekRPP8Zu6YH7yYNajOPcp2Q1/5mNnjoqV9MaUvhwsCg8Fdow3U2HWGZvog0vmwQC
         WNKYHT6HByN+Gl+fo9WCMt55Wfe/qpqboXB20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702943730; x=1703548530;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tAAwxG448biTn8MtDNLxgJZ4OzA1M5+6aRFoz6CAg/0=;
        b=UVs0l36xLavOKtQ/IZhNSWut7/nRReq1edMSpi1mkPnGcL5I8iq5fDkJY/4GHIaUbJ
         zwB5WtrNjCWqw9ubg1HoRd++9Mdjf0+1iVGuFK08BhxlvDvJk97E5o5MFPY24k/A22k7
         fdjOoxpVHJ82wTNmHoTxg5eWPrEv/lg7kP2MXsaZ29ThjGb+MaBpqPFXXtQDpW2gBrxW
         lzaMCEWpdXCjBWS4Z9cek8fF2W1ZYCtSDiuolTvSDdvNMXZz1Nsd92z7KnFdziTc34nL
         3qcaIbdpoAEZDNJlrm91YB2DcI8Nqdj06HDm+xIXSeuGama72Tk/TINqnMx9UJcx4Eo5
         r8GQ==
X-Gm-Message-State: AOJu0YyWwe7BSY6Sx2BJ6ba9ZqWUb/EhxBEVTs0Ewsm5mOS1Qs/fZ1pX
	07vUtoLtSwZdJq7m/vTs6XA/QQ==
X-Google-Smtp-Source: AGHT+IF5zl2TkZasMx+z0wTDiacZ/lZvxYR6zMJCtjlSizQqf2MRKaABbf+I/RYFqBPfX+p7KjZGzg==
X-Received: by 2002:a5d:9f05:0:b0:7b7:d4c3:65c0 with SMTP id q5-20020a5d9f05000000b007b7d4c365c0mr3538714iot.2.1702943729908;
        Mon, 18 Dec 2023 15:55:29 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ck27-20020a0566383f1b00b00463fe3a0860sm1039606jab.142.2023.12.18.15.55.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 15:55:29 -0800 (PST)
Message-ID: <2f2f76ee-c333-46c0-ab0a-8930848a3276@linuxfoundation.org>
Date: Mon, 18 Dec 2023 16:55:28 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/166] 6.6.8-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20231218135104.927894164@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231218135104.927894164@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/18/23 06:49, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.8 release.
> There are 166 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 20 Dec 2023 13:50:31 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.8-rc1.gz
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

