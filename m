Return-Path: <linux-kernel+bounces-119532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 115AC88C9F6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 431A61C65518
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F395513D539;
	Tue, 26 Mar 2024 17:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JS3+Q+MA"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C33E13D531
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 17:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711472453; cv=none; b=jQ/qACPbn0FEzpI5W6jBq5n4UNenEMJ4QEbnQWDnZQuRSwnNvtQK/XeypPybb+L25zpa3DuNIrmvcw6r/ME2HTLioAUjfgoblOsMJJAANafa08lseq1H3eslR5gZXjB2WR2RoGsoS35yTWNAl6TPw+Pxoy0Blkahecayt7NWjU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711472453; c=relaxed/simple;
	bh=t/4Sgc6HjXtKMpupkcNp91MoxK6/CCwIcId/AInDpSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rllp6aP8ErcZaZNCUu0ltjxD5E4Ue8X7wfShsoJ3Lhxp2yRFCQsUTRUN+cb8Kmj4nxti2zfk7SatqcWj+F38WJPLJ07BbFzdyAHszLovwigYy52JQDQH6BAJsTQ5nijNlpvjZ+bNGOvgNWrqXYK14TPKXTnCtF+ifMfySKzOAiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JS3+Q+MA; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3688f1b7848so356905ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 10:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1711472450; x=1712077250; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/TIiGcxhM7vXT+lbILqbIn8E6OfjV7ZMyP5RXQ5dfqI=;
        b=JS3+Q+MAmg5mtjSDDuk0vqIJ9MACrlIk2Jq4ChUkLEe+8kTljv4J2IJ4igkj5IdgO3
         YsNW5rZA5obULnIRkW9eNSFLQlYlSTgNg4uo1V+hIZvSPpTTeckO4Q7uwxtFv7WIFLq/
         DI39Z+a8MNeUX34qJ6kpw0+7mP2M+7UM5Fs30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711472450; x=1712077250;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/TIiGcxhM7vXT+lbILqbIn8E6OfjV7ZMyP5RXQ5dfqI=;
        b=wGaZAdKUnbhory5rEvROz1pCMNUyvHjPdVW1zYpNrAmNBAjojhc8kJE2tEyrLdm7GC
         3gGqi78eYtCAhEyXfsGivMAL9249qp83N7OzMsaicko14GbIABq1GBNYCITsb+laxUEO
         KwcjieToPk7RjEw1GoLXE7Pe938fQ0acSUUc+FJpdQAkKSUNVHeg7ZFPdKnlJycvVT7f
         RkPbcoIZewr3KoEE31wAcS2Q5/Y8+lbUTjYlLoloZ6R+ohF9jt6C0ZUJeWVx8vw/bfLv
         uJDlaJaKsOC8mk+BXqALn1CNAaRMsw9RanlrF8BlmxJ1T6MiX0nx+zhkf/uTBVKMrd4Z
         Ft4g==
X-Forwarded-Encrypted: i=1; AJvYcCWdEbHsLdWV06XnEBnETO/Q2tszW2r4ua2z77BC+kpQF2j1fOzYyfciQLupsl0jxeoUzGMuRhUpWyQn9QJoZ/Sqk82F80mELEcTULNT
X-Gm-Message-State: AOJu0YyeCn8GbjwHb4NebRCiCPg9/rbq0YWzVlczmEshD8DbxXIjWNcv
	Aw03D2jwhhrfG9eXclbn0J8Lo/5FulaR817zOcPqgv8BJVrO/DmvMxoE/gtOZt4=
X-Google-Smtp-Source: AGHT+IHArss9/xO1eae0+X8Z5IsmnbV4GfnfwZjKVACSkEZRNC/kmAb2BuPBSNKwzmtJ/61TitJyOA==
X-Received: by 2002:a05:6602:88:b0:7d0:2e1b:3135 with SMTP id h8-20020a056602008800b007d02e1b3135mr10571753iob.2.1711472449835;
        Tue, 26 Mar 2024 10:00:49 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id dl7-20020a056638278700b004772a0d4b0bsm55667jab.8.2024.03.26.10.00.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 10:00:49 -0700 (PDT)
Message-ID: <94c58018-6cb1-4f56-8b78-8251b64e251e@linuxfoundation.org>
Date: Tue, 26 Mar 2024 11:00:48 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.7 000/707] 6.7.11-rc2 review
Content-Language: en-US
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, florian.fainelli@broadcom.com, pavel@denx.de,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240325120003.1767691-1-sashal@kernel.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240325120003.1767691-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/25/24 06:00, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 6.7.11 release.
> There are 707 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar 27 12:00:02 PM UTC 2024.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.7.y&id2=v6.7.10
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

