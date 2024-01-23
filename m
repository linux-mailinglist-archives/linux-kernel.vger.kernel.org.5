Return-Path: <linux-kernel+bounces-35772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A722F83964B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 002FDB23D7E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717507FBD4;
	Tue, 23 Jan 2024 17:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWZMaWb+"
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C0C63518;
	Tue, 23 Jan 2024 17:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706030641; cv=none; b=CiAubmYjWBmsU3f/rZZhcAjRXcADOJRRSJOQ/FcfofIesu6VvZ6cqpTg2FcAw20c/jvyM4mTQe9ETZdTJHJoXBS7Lkpv7nQMJ+lL/TAHegKC7FZmpjdrUgneB0XcksXBY/E+SgeFeTSMgxJF0E1ywaR06SW/S48ABb7H1V4/Vqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706030641; c=relaxed/simple;
	bh=fHqmME8pyoHz1Xun5FH0Vw9OMWeDmrLlhjA4Z0zDZg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qq/sMQbVI/gQO/hUVGRKUWsSBHw+XyS+bL5guHVEb29f31xrKM1PlOPjCQGVdsoMgw9Dm81R+jDXxUBwpzzK6V4Q21a9wlxYEFNkeihtBm9wLROZv72vbWomuBvDf//dNPkZvaDxa7oHTJWUya0vTvkV/KZmWRCojhA70EXQ95c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kWZMaWb+; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-466f6d4b6d3so1027456137.3;
        Tue, 23 Jan 2024 09:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706030639; x=1706635439; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZbIPnP/gS4sttW/JGLj9iVmCxJVrwt8tNGlCVJAIhT0=;
        b=kWZMaWb+8TvkcEhPU1rRmXukbpxxa8mIC722NYnoYVCnzz6AK05W2rWf4Q7DxpLISb
         zaNFT5Uk3GKDjS9vqqqS34GVvBf3xbIguKSw2vVQGrUeR0SVgUqBkId7vEWRCaM+diqU
         6351u9Oq4EJGpE4O0mg1M9ymvFgv0XC+PsLILQc3xbboQVx6P08L++GWVxbFWg6L+lPd
         3jqoY5u8/myBEsVR91JHXk01ITWjp8pyK68/tAFYhO6qMvu1hmsz+bkYx2uMyBgrfEDa
         ZS10uielKXbOjyigWRTzl3S/o50egYjAltKBOzTj61U1yq20pVWIQr3nJjmSXMKAjTwW
         hMxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706030639; x=1706635439;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZbIPnP/gS4sttW/JGLj9iVmCxJVrwt8tNGlCVJAIhT0=;
        b=MH66oQPK+lgYkAQAQ00DgmDM9WiGxUl+VMnCfYeaaUXYYhbb5K591Clsj4MzuU5XWX
         d8YokLZ/S75XDph0eERHItFlk2/TxbsEJtXXXZhWdKXRWhYjOxClXzblc1rymEAES/lH
         nEC0O6/w1Qmwg+FkXA70Ir9iWdxDH0Q4aq7cYcuuPyMULUR0MQFNVCgGNGk3DqthQY7t
         yMuio2SKPRVaoq1P8Uh6SGgXgY+JvzY+Z+ZgGdT2EJPkH1pl3WCLg6nn7F1u9ygBwr42
         SG7zsUec/2HEZR50+TdqeRXis8QmxlG+Wf192SgLDYtD/OZwI3uH+QdocO26uYn6orbg
         7/BA==
X-Gm-Message-State: AOJu0YzscxU+gsagfLt0xKLQmiYxQuu/SV//iBqazQ/dIeMLVbef5hkI
	nabHkiCLwperqILDynXJj0gS+93RhpVidQ2b8708SC55vPZm32ngOdbpIcIt1RQIBwhdNz5jjX2
	hvG9a5PMqxXb1F4mMogoxarbynLM=
X-Google-Smtp-Source: AGHT+IEeLz+BW2MuCuMlIoPqQjchFblBCvq7lVB8bmVYcM5i1YKpyzaYdOZ1MMTmmm/aejM9ABdiQUN/z250uDRChao=
X-Received: by 2002:a05:6102:3753:b0:469:bcbe:b10b with SMTP id
 u19-20020a056102375300b00469bcbeb10bmr2305735vst.6.1706030637819; Tue, 23 Jan
 2024 09:23:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122235751.480367507@linuxfoundation.org>
In-Reply-To: <20240122235751.480367507@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Tue, 23 Jan 2024 09:23:46 -0800
Message-ID: <CAOMdWSJZ+2jONW3pBdwVbC4QTDPEtX9Ce7A-_FCzr2zXj70Nag@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/417] 6.1.75-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.1.75 release.
> There are 417 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 24 Jan 2024 23:56:49 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.75-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>


Compiled and booted on my x86_64 and ARM64 test systems. No errors or
regressions.

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks.

