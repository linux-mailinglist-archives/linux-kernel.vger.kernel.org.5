Return-Path: <linux-kernel+bounces-51852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4729849005
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 20:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75434283DE1
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 19:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A807824A0E;
	Sun,  4 Feb 2024 19:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="P/8ZRWQM"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368FE286A6
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 19:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707073946; cv=none; b=QF+v71xn6A4ZCZ317zUUPL45ylFqEyXVFjG9vtPZeAelpGNmJ9mx25rlUZVgffmmydDyupfhFdgQib1ehjX1oEaCrzNKrCyFLMEjkrnb4B7iQ3MytB/oy4H4aF3bPkK8i3hCHqIPRmbIRpL521se8xbAylTh3D5+uJt4pqc6ybA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707073946; c=relaxed/simple;
	bh=dngDwt7GkUFW+WOmryEM+0Fgzxw9VBep+5sR6Yc+KaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ctx8nRkpteaEKgychUcV+nUj5pa1QsOk9ZJhSJpURixMafQjYaU/6N7S3J98srM0fsRV08VS2DTcUEN7U9tJ+KbN9Aiy/jWtpAn9m1Vy94fcKXn8TRg2h2YYo0+d0PeykcxEDSN7dyvRB3eVIE0/ggitKGyBg08evJoupGx8Zho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=P/8ZRWQM; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-219452bdf81so927680fac.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 11:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1707073942; x=1707678742; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V44kuTI4FeYeOE4w4kZfQ70l9tJbUKoHppYD0bU5HxY=;
        b=P/8ZRWQMOGMn1kflKmy5+OThGksNkddefC+x42NRklbCPa3vNDXTficGCswtV3Vgo9
         Qg4oE4bZ1UnoI6PCRO0sEBF1CgZJOodbEJE4dgjcTI86qk8sQVZ7TyPSP9Z6dkOg69uw
         dw4xcIAiAsKUKs2UiYATCbo44T4X5/hm4ArsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707073942; x=1707678742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V44kuTI4FeYeOE4w4kZfQ70l9tJbUKoHppYD0bU5HxY=;
        b=WGvRG9Fv/yVpdJbA4SLfyLfoEY8JMGSa3XAwlMiCcvNC1RPpc181svYdEgpcNU0b+R
         xhu1/UYrillzN+FN/NuB3dEmmm2FxB77fmDFj5vWdq3yCaD+jyL35h0EMuafJsWz0N2Q
         ImtD2Lpfh/aTCAlcRfcZSCBXA+QBLAQVvfMgXSGcsnwmBg6q0KxohBV+fQ8TOu2fREUk
         AL43jEFeF9pC7jv1OYxHp7OKd7m+FCxduxIk2fl6S/FEqitSyZvkTlQ21vT7KhhEEh/w
         A0nY2B3e/iQKuO6wnmw7+x5Zk+2azZjHunFLU37z2QjOYfgUu7tVm0+9pdrXEIkbLPW+
         vsQA==
X-Gm-Message-State: AOJu0Ywq0BrOpbvGo2eP78QFIaQ9AAPO3SGQ56zNBt4VdVTAnH+JqDWS
	+dTAWIToX/1VFyvgI3fbsM9pzVKuI3v/zDJMPL2asaGX022hLUCc8hJcT4Bmog==
X-Google-Smtp-Source: AGHT+IFoEciXkOIxqYaFmAtiSWx0h8TIbtqnJK5kEkuGL+7L0S4ewX6yPv3lNosmjQGo1MMjvUuHqQ==
X-Received: by 2002:a05:6870:1701:b0:214:fd96:486c with SMTP id h1-20020a056870170100b00214fd96486cmr6032758oae.9.1707073942104;
        Sun, 04 Feb 2024 11:12:22 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWO8RmiC+RtGkwYhNatmlbTWBlloUcajZi95XxaWBOXJMihd79u++kzwXZH3kRwlc4YKUENOKRbHogGbhU9S8evxw1ddy/F7j6uxUAhOLbU5QcGyrXxJ0qX7JXUn5YUsiW/ROwbZt0NiIyQDwBW2f1fzuoLHHE4bEKUYVYfA5n5zfmdSYOm4RaRt6pzRt+4mAmv/w5rsloSXRjE+VTaZQxCHjPZ0F4A1aafMAT37YLLrVgWAW/psOGtN6lfkuNhPurGtT4Zo17Rd7XeRFN/wym4g9ywcyLpPc90+sdf5iFc8UhgMs+oNryzGPeqXcw89o+kqo1MOrg3lvAUdxWu6A2veO9M+q6F11d22KHFyvTr+HKiD4LoDFlUh3k5aie0UpdvNDJ6jD9DJWGdoOed5IBqT22JCK+yoqcJmhc7LqpF5m6X0ZV+C/M4VrVrMDu7mFCnrMSjjc31pXLYoRRCNHeqbRE88Hn/2kgUgEK3CcZmcU21bVssX9PmjQNYSqW1CXgyC3pBRJMwepSesYgpz7uMhaPlz31FWBYDPkZWtQY=
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id py11-20020a056871e40b00b0021982d72c22sm174396oac.43.2024.02.04.11.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 11:12:21 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Sun, 4 Feb 2024 13:12:20 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.7 000/355] 6.7.4-rc2 review
Message-ID: <Zb_hlG236deI3R4O@fedora64.linuxtx.org>
References: <20240203174813.681845076@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240203174813.681845076@linuxfoundation.org>

On Sat, Feb 03, 2024 at 09:53:10AM -0800, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.7.4 release.
> There are 355 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 05 Feb 2024 17:47:20 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.4-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc2 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

