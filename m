Return-Path: <linux-kernel+bounces-83836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F26869F0C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F76E28E7C3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7A3149011;
	Tue, 27 Feb 2024 18:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBtKHZ/B"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A325B148FF4;
	Tue, 27 Feb 2024 18:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709058413; cv=none; b=O1ZbebTFir86D9VIgqsw/JO2pfwrVtkMQTI9xUverUYqHw9/zesrcDrKGHr//z7blO5bFf9y7dYVdjzsHjksY/UTeH5dtxSHjE5W4D91WVmLy6yPTkcr3ixLpe6wkpBbx66bkZnm1A5sIXBK2djiae/sP41VKdRtREW5FFuB2XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709058413; c=relaxed/simple;
	bh=8XWj6PM1lzfc8uwHWAFHpI9lOjKvzxk1lGQOsb+8dyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B5CvtqDjhaAG0hbooYwLC/sJCm6Ua4vce9rYblFgTLTd2zWqz8O5oK3ukFmEC5z6YeBZPRhqw1SJ4FYxz0JZcf8KMmQWcIAUdE/pBYzMFxdq1jcQ6n1UhuDxc+cez9uWRl/C8DKQAg5dthB5gsQeJ/msoRGqvSQ5cHiKX7/DhnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hBtKHZ/B; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5d4d15ec7c5so3748697a12.1;
        Tue, 27 Feb 2024 10:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709058411; x=1709663211; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Z76EBq7m1t1xBOj0ctPbx9Wsemqc1cbGv8gFCHa6F4=;
        b=hBtKHZ/B1TNIImyGJYFs0VHvOAPtSUPPLjgUMYHoBmZtMpSCiEs1OOW4salAwL+1hj
         hv8/yo/zrAabGZsiIpyeN1fKjoeBmRoDuA9e3Va7n12/yMZ2609hmmESlJSu2t0/7Iqz
         eQz2hxQ24kpXGnbNto2B1zOYuEdK/DLKLNErM53pPrtZa5PsK8YT9EntApL82O/VcF8Q
         9lVKDe0jfxYdGgJhtwszUSMa+lt3VsE4OmO4e6M5od6JGKfBoK/V3RwgFFFdTZkf30T4
         Jr/r2k7lQbs47GIe4LvWsDVbJNcwe4QlXONt5xNkKhL0PuXTWfE069NtMnDEEW20Li0b
         dWaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709058411; x=1709663211;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Z76EBq7m1t1xBOj0ctPbx9Wsemqc1cbGv8gFCHa6F4=;
        b=bMUyZqNpZlVHCC03SOZR8MO2FXWvb+eW3Ox7/Y8vBkJlhXMwRuZWCIDA74LFAIy7R0
         +2N765vCR1DxcUFQhKURKYPJkjwIEWE2P7XpaZ4LtuO8fN6kj8VCHGJn45ue3/VuVdAP
         g/6gc3NtHDvNXZ7TA/2r5fty6YrkeFU97Mix8KNLysp9WqjM+CtlInRVMVabDQOx9E2F
         QUkv6FB7FRMA5Zt4xtUCJ9oBqOjAhuoZJednCTI8XTHAEPPb3XTV1p6QIUwCKiXxHhie
         wPGslEbp36Dlc3BAWC8/vz1/DxbTuhwZSm0P81q24bShHi6Va8yjg6JSpcXMbZ0X8gxf
         SlHg==
X-Forwarded-Encrypted: i=1; AJvYcCVksPG3mrk2Xz3qbUYP+6aSt4cz4HgRJzi4l6KDWxatpZsWJGSUBjWYUZd4mbtK7edU8f0YFG0/ODzFyi+VDSxVaqrf8wJXk6KEd9gltn604al49CJ8BwN2ATs1x1cYHKP6aVRJ
X-Gm-Message-State: AOJu0Yz52xtpUxcN0l+R5JSkGFrrc/vszlUSEKT5ki+7zcW6DraLHgv9
	kj2Wm5/WlotE7SnDNXpoRtQIPNVy434cPNhN+gKA5J+T2codwd6F
X-Google-Smtp-Source: AGHT+IFdU7nmUgVPR3ujHtXkL/DO8Zjq5jDL4faVgix98nSdwlnODv1Ahp1XImqWmFlIZKq64EYHsA==
X-Received: by 2002:a17:902:f690:b0:1db:f03b:6f5b with SMTP id l16-20020a170902f69000b001dbf03b6f5bmr14903685plg.56.1709058410715;
        Tue, 27 Feb 2024 10:26:50 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id lc13-20020a170902fa8d00b001d911dd145esm1807639plb.219.2024.02.27.10.26.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 10:26:49 -0800 (PST)
Message-ID: <ae07fe47-15cd-42d3-9992-cd5c5a3d57c6@gmail.com>
Date: Tue, 27 Feb 2024 10:26:45 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 00/84] 5.4.270-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com
References: <20240227131552.864701583@linuxfoundation.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240227131552.864701583@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/27/24 05:26, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.270 release.
> There are 84 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 29 Feb 2024 13:15:36 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.270-rc1.gz
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


