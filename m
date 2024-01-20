Return-Path: <linux-kernel+bounces-31697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE7483329C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 04:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB6F828365B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 03:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10A210E1;
	Sat, 20 Jan 2024 03:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="hQM80p5x"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39E910EC
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 03:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705721477; cv=none; b=gHWEmcUSSi3cUEQygy2lmlOtiz0QQfKzPyjZENSSom8DNGryRuhpjsfviQ/0D9+guJMPLkesvy84Aplphot79G7MvYwFQZDVo8RhuvER9rwY5XL1RUeXm5a6dtB0wNNHmjLsEHVdhzUVOXVkZhrek5QDIH7pNnG3+jA+yYByyLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705721477; c=relaxed/simple;
	bh=LtRSHTJnqurCuuUoeVR3XxOKcKwGNZNUO/DX3pgJzP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DTaczgb2H5t6Y7eXD5qWGBDOCjqSfUXMYz9c4pZodf4dDxFwlZvG7OsRnPm4MH/2xn4z6gzi66L5ig5TgcbSOEJ1qy+6seCC6tPkGw+85YYypb/pBjkoYlGPcw0WOfRlaEParXsQGeZX/wT5IwQ8yjyKvtYjRIDAu0cv94K2RkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=hQM80p5x; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6dddf12f280so943174a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 19:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1705721473; x=1706326273; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=38qcoDIXRI39KIvBIjufdG8qjQjAnBCQ3jqDc4GOq3Q=;
        b=hQM80p5x/nwKAWdm8c+YdigHmlqMWPa31M7HcU2DRWJmQzST9oEmdRR7e95xAYVG76
         cLEeD5IeVE1LKh5o+Dv1ZChe9Su0TbfchTb8+MYtqDgJvzyCFFF9T42YP+CCl5gArryR
         tS5UIEkclHNiq0Ii6KuihzFVjWI8wTVZk5n30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705721473; x=1706326273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=38qcoDIXRI39KIvBIjufdG8qjQjAnBCQ3jqDc4GOq3Q=;
        b=uyko6FWXItzhXCP2ybb1Kr+AIPrZRtisX4CdtltckcjGxgm2DTvJobU+ozhF51WcDs
         4bQQEoU53ruR7ck1JLVJFBxBWjRqkIyv2dIKyiXlXJ4ulLYoHM29pHg+C/PxoI6juYnk
         f7Fd5tAGWNRAH6Xe1ZenyneAshI6b4wF0eSSvMltcGx6FKUnvl0KKdLNxvsoQJkxHMol
         RaqRd09jIZ+TxmJXDwM4J+JUP7zeFQrpjHReEeViJtx2LImrRNEHfi1R8auXCU3N4SKH
         jMSk/Eov9COog5gbp7EsQ/1Df7h1JNQa6OS/+Hxro7fjCiZYdTmV07jP3W/snGi500hM
         FvTQ==
X-Gm-Message-State: AOJu0YyfVdhLl09IuRutjl1usTjeAmkcOQKliyKEVPRu1BODKSSuvL19
	IdUMR6K+4FgMWG9Z0wxG5x2Nam909ejOnxZbO+FthgfcmVm8ly5QuFqsY5KhTw==
X-Google-Smtp-Source: AGHT+IG6smxCiUbNX5DL7lZWey0NojCCazFGjf6HU6iom+P+QCLURj6wlesO8HmUg81JtstOZn80Hw==
X-Received: by 2002:a9d:5a18:0:b0:6db:fb07:91c4 with SMTP id v24-20020a9d5a18000000b006dbfb0791c4mr834524oth.73.1705721473679;
        Fri, 19 Jan 2024 19:31:13 -0800 (PST)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id g3-20020a9d6483000000b006d7eaaa65a4sm784411otl.71.2024.01.19.19.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 19:31:12 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Fri, 19 Jan 2024 21:31:11 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 000/150] 6.6.13-rc1 review
Message-ID: <Zas-f6dPWzwsb6Mb@fedora64.linuxtx.org>
References: <20240118104320.029537060@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118104320.029537060@linuxfoundation.org>

On Thu, Jan 18, 2024 at 11:47:02AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.13 release.
> There are 150 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 20 Jan 2024 10:42:49 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.13-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

