Return-Path: <linux-kernel+bounces-130706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9035897BDA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 01:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71E4BB2741F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 23:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C490156985;
	Wed,  3 Apr 2024 23:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ElurWV5D"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D470B156881
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 23:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712185264; cv=none; b=DGzk6tCGL7jDZJfEtxCNkxaHzyNTUSnPW76f7MtwBzyKy7eMH7cNzGxH/EMOc4feko1ldE72cFxWDJaXcNBGXo79xWjZWPX/v86eyj4SvnAI1fj/GrSCtcMY1XouP5eImsmyJlffYSA9rWewWUAMYnaMzqDaHz5UJlAPIRzgHZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712185264; c=relaxed/simple;
	bh=7Y74O7TjY7jpHYofExHM93h8IkZ4W5efuR621D08PM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UPSlbRXfUiaQw/d7QezCUlzhB0thCk7Z3eCDacXu4qMXbE1dXLDb9xOLzUk7F/hADybPlCpp1uNpFJdMR5/XIj8a6OoFyqiMhZ8fcCAreXPkfMfOBCVDgKpbbPx6l9765Tk/RUgVgEUb9xzOhuPjazQpIQFRAin++4yleCEy/3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ElurWV5D; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-369e4a6ae04so15325ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 16:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1712185262; x=1712790062; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lVfdwPhoWoL0b+VXF/L262JhPi7ESknq7Q/FQyN+ugM=;
        b=ElurWV5DmbFjDaVzbHcP5/mlWUuiqQazypzBtBS/LI4XqyXyJk4R2TRgrTabZSn5kq
         bWY6TBM++AZXLwOmHnr41qnk+ccn3f3zPGVXMhCKNUTSD7KO3l5MtrGY1VDfKeiiyUqs
         D75lswMAnntkS6MGP1iUh5AwHsZft5gBi0BnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712185262; x=1712790062;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lVfdwPhoWoL0b+VXF/L262JhPi7ESknq7Q/FQyN+ugM=;
        b=AS/W0q8Y0xHWGN4OluGRYlqt/MrXCCom+EFCrN7YSlOqe4/b42Fq2OaUo8VhfpKPGz
         hgDN05Qcs2WnV1/Rc4qR1r1OMZmAinmc59CVcafi6lxP7snXHM5iXbk3jSTo5r+6o1G5
         Qy90JHX5zXhCT4dSwISqoug9ViGNC2tyfo2eDIfCDEA809NTWttOKIOzzG0aJsRmow4G
         AXIDayBqUHcLSgPOuVhoKmp2bhMJZaOv14XqFqMoI2dBKvS2zKCyHnxGYgExT22kKmWM
         oUf5sgzy0Y+Ikujh0BLY/y+FWo9XKKfirm+TAYXuuaISzv2QleRCTHhVnhgqJ8q5sW/l
         AE2g==
X-Forwarded-Encrypted: i=1; AJvYcCXThFsWj44VGUbXsEckw42EpMihSEUntZqoMKcRydKZD6yDyoN+Nbt1BT2p8uqUQhytokOSkBasEXmoHXcuxvlniuG/CCGrhFwWszxv
X-Gm-Message-State: AOJu0YziaHxi1AhRMVOVBjbaFLjN6V3nwf11It6ayhI36M+iad+Qeh+e
	rDMuk/1qIAVR1E8j2jcEks6O6G3dfvL/awJwj/pRjEeCedELjmnIjONkVjAlMxU=
X-Google-Smtp-Source: AGHT+IH6cRHPVj5NEezsGxb7L0Ozrt8vyJr/LPTdVNmL+k/OgV6BiBlvHPc093dRKgMOhDOhj+Ru8A==
X-Received: by 2002:a05:6e02:541:b0:368:efa4:be12 with SMTP id i1-20020a056e02054100b00368efa4be12mr1139587ils.3.1712185261996;
        Wed, 03 Apr 2024 16:01:01 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id n16-20020a02cc10000000b00476e7f39a44sm4092962jap.110.2024.04.03.16.01.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 16:01:01 -0700 (PDT)
Message-ID: <8cbf96eb-b1de-436e-8312-c228d0882226@linuxfoundation.org>
Date: Wed, 3 Apr 2024 17:01:00 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/11] 6.6.25-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240403175126.839589571@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240403175126.839589571@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/3/24 11:55, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.25 release.
> There are 11 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 05 Apr 2024 17:51:13 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.25-rc1.gz
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

