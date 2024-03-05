Return-Path: <linux-kernel+bounces-92853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEC88726F4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F10F01C24817
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870BE1B7FC;
	Tue,  5 Mar 2024 18:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hqFHVFbb"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5140D1A5BA
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 18:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709664782; cv=none; b=bgaozO2GXTLb5kUkM0cs9ucVg/1Wlw2SaAaqBFCmFsv7zIWxebUK6ss57faRS6u3J/tEgH4YEZUfRvVXTWMw5OUKEBmbHrC49Bm4xf53ZoCbKsd00ZFulTqE8+53tmDZNOtwD/k6OVyWXYBZtiIG5eJogsnoImjwPs91bDcGB9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709664782; c=relaxed/simple;
	bh=M/226HSU/VUf3qLvN65ic9RPPkGkwgft5YY5sbbm7gc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FjWzLPMsaUrwbeoMJRIDJkiH/IVn1z6XeCOh8/de8DxV6NZ6ppET1o+XD8HvqCvWN5l98blIxTZ1RiF10DAXx5Z1Q4v3QvfDMk0oQuinuk6W3us2nqU5pjPbRy0My0ZrAGrflEEVYK7goQC7bkWkKOXRP9SplMsGzDyJMpCDYOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hqFHVFbb; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7c840d5aab4so37846939f.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 10:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1709664780; x=1710269580; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MEpeeM5uDTk2y22FrTqvvuOsQMUYfWSmy4vGTzbuVno=;
        b=hqFHVFbb6LRKiwI5WixhRyE98dhFYLTcGyyctMs6ru6iqluqIZ3JRIJQ9b8JRUIm8q
         YpbFZUd93M4y9ye6TdQXvbgdSRyzmg5ZtkDQbC0Z4Wc/ORW8uAdk99qao8CAEKrh2et2
         dpL0UAuGebAOc/rmLaQBLsO8blCVH4R9WWcIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709664780; x=1710269580;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MEpeeM5uDTk2y22FrTqvvuOsQMUYfWSmy4vGTzbuVno=;
        b=GfPeMOgvKnEYqOz6bmLaCfz8JRPzuU2hdoPs/9M3M3Uj4v7HMQ9Rry7bErMgETNtPn
         z7qrUufng3oP6qnv5SG8Fq+VeBvfqp79Pl7YozVUBHgGHjOhjfqQk86ya8h3LJtRW1Cn
         hyqQrYDSBQCOPSvTjMuqpvJl26X/jdV3v5aSVsSQdXxeujkoyt5ps6N1Lbanr2QeQPzI
         DZtTzcw3ih0dD3nH8hcIGJC/yqxNG0ZJnCEe/nW8f7WmAGU2rj+xkeZsbFWmoBCoHCxy
         KI5ilutWYkJN82Yl9f21XexJLvn7Fj3oKh91LcThe2RufRqcPhyT22L6jXJiBSy6QVEZ
         Fygw==
X-Forwarded-Encrypted: i=1; AJvYcCXc8oKSEf6NjZE5NjzOBZcHVYXutIYEraNyb3pJHm9A+nrI7h+lIdDhpI7Wt88lVl0yPgjoMNMnb2wi+Wp+1HkI/J9zKpT+rgaufMYV
X-Gm-Message-State: AOJu0YwhK5Oo3dCFBXGUCciPl5AFk7GTqGdKNduUHW5Czq7CFsHu0Wek
	zKr2koTjqhjD3FfscxhyAuEvQEXGqXFCOY7aaf9JJoj2bHvivPXsgWdmOq+Ji+k=
X-Google-Smtp-Source: AGHT+IFbzWXOeIi0fJ2CcuZDZeGAyPP24qF/5v6BY/JvvzLzUHWNTrD8gyMXbXDyIPy+7NnluYrAjg==
X-Received: by 2002:a05:6e02:2164:b0:365:4e45:63ee with SMTP id s4-20020a056e02216400b003654e4563eemr1378458ilv.1.1709664780276;
        Tue, 05 Mar 2024 10:53:00 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id b6-20020a029586000000b00473e9bd8308sm3045833jai.124.2024.03.05.10.52.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 10:52:59 -0800 (PST)
Message-ID: <5e9ca92a-ba9c-45d8-abcf-5bbd37a7546c@linuxfoundation.org>
Date: Tue, 5 Mar 2024 11:52:57 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.7 000/162] 6.7.9-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240304211551.833500257@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240304211551.833500257@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/4/24 14:21, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.7.9 release.
> There are 162 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 06 Mar 2024 21:15:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.9-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
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

