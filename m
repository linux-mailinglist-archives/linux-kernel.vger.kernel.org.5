Return-Path: <linux-kernel+bounces-31698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE1583329D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 04:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C7E11C21528
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 03:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E49111D;
	Sat, 20 Jan 2024 03:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="doufZz9q"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A2F10E8
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 03:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705721507; cv=none; b=rg6qliiEbzdkoNOWm53cnNGUHvJN0yhC88V9WyQUAiuMdTJJVqwJsxrY/wlkohmNHVkynCIPwCtTlEx9SXj3uePVMgbgi9diMbgd0yKBhzabiWDDPvmkcRFGdjWyIo3GUTMvnievqMuvuC2LGhf8R0EB/2Hoy9Sjj9BO334Jt/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705721507; c=relaxed/simple;
	bh=LiSPUDxF3TmHtS3WNwEBf85tybfySArv3gZhh983HDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fqv5DI4/WaKoG984UhUvU1cM4GA/ntA7ZJLUsRZkN30bFB1OYUfuRYIOTlzvMyXkbnMGzWdnulTAjEOV0vdc9uUJ7vUk61HhwAI5NvAxGzGUfkEoAxfgOmL9YKKDZ3dfuwThh+PFgDG5m41pDUvU1s3HOJIhf3B8UJ1YOOR6jvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=doufZz9q; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-20757468411so917144fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 19:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1705721505; x=1706326305; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FsJxldHn891bCc+jF0VMK7q05TkM2hxbbbR/mc8mU5o=;
        b=doufZz9qKHii2JpNzq8AgG4ZBiSoi7LoiiDa/BGY6wkAJ8evVnppWIoFIJWqd+wVJe
         9eTISOXw+2QTFQq/wuFzd3zg0iWjmQ7DZjyGKRjvGUx0DwjJ3kbEqN3yzS3owmzH/Jya
         WVb8yTP0CWfhKjoAqYPrqWeus1mydVMvxpch4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705721505; x=1706326305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FsJxldHn891bCc+jF0VMK7q05TkM2hxbbbR/mc8mU5o=;
        b=E4UihvCZF2tNI2ke5IpqzX/RBqJb/5tY/gUHNdoTvjGxJPM1Gmga6NhZzCZ1qTdSKz
         wMAN+EeRy3kRhFHVmNiW8E8M113ac7UJQfA5M7Pf9E5RzcsgG4j6r83b+t+7z77LasDU
         6/NDxW0itC37SHGER//GhmTk0VP3UnYUZ1xS1hciqHJ7YVSuUwE73POWAenraEvztpBg
         ed0dfERqgLx6nZ9jXJTKUcFGHFq0Q/1G64QzPry8S1g13yFL/g9jRe+X7EVJazKjPJ8P
         pI1kzEFQOFbIjsMTxwVlcShrqq5DLQ0W7lpU4UYRaMDbgeJf0tm+A4eaYzG3cYT4tUU8
         qQKQ==
X-Gm-Message-State: AOJu0YzSQNYRzJY9he/aJycNV01JIvSmWeBxDZ3Ac0IcaCWaNjiYWqwn
	MqOZaLfpV32AOCyprg/79r1S4hd2lYvC5ppwzsCyR0BhTgKgEYT8VdidpSI5RQ==
X-Google-Smtp-Source: AGHT+IE6d+GxuDRAZdnj1d+lu43v9dxXJW5a8mbWwf445bisVKaPKSX6ily5JD1X/KvpuaG9fqlpuw==
X-Received: by 2002:a05:6870:b6a2:b0:210:d74f:d3dd with SMTP id cy34-20020a056870b6a200b00210d74fd3ddmr836265oab.103.1705721505289;
        Fri, 19 Jan 2024 19:31:45 -0800 (PST)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id hb17-20020a056870781100b0020655a8f247sm1135783oab.15.2024.01.19.19.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 19:31:44 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Fri, 19 Jan 2024 21:31:43 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.7 00/28] 6.7.1-rc1 review
Message-ID: <Zas-n5xh6QaNXLpC@fedora64.linuxtx.org>
References: <20240118104301.249503558@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118104301.249503558@linuxfoundation.org>

On Thu, Jan 18, 2024 at 11:48:50AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.7.1 release.
> There are 28 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 20 Jan 2024 10:42:49 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

