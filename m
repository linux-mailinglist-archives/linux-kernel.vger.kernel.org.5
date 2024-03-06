Return-Path: <linux-kernel+bounces-93254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2772B872D15
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 03:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D26411F28778
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 02:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD13ADDA8;
	Wed,  6 Mar 2024 02:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="gr9MzxY6"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697CBD52E
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 02:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709693714; cv=none; b=TJPGeGTv/mIDGHayQ2BLfunL6VbPkOvex3rcAm8OFJKZJtfuBQABEY6GHKSqma4Zesp2dBHFZLNsk5uVsDKQHaqTTyoLK3iTRtpsekRGPStgLt4xrAcWHomZhKEOEPsoK6jdksUy4idMRWk3IKfFvjDq/6klVPwGxAPOWMSa8AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709693714; c=relaxed/simple;
	bh=GsRdJoaN6E/LLUOYDglle0uztnU6Sis59Fl7J6wutgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YdAl6yBAQhLrHeDydNVmMjJzoIWDJrOaU9vP7xkuaufTGpXYwwOhYZRuSsTOKaWc0OtB9tRPNWp5v5bZRAwbrbKRoDwCNhDE4eVRQRBU+Xw5babRD6lYUFneZ07hYz+iaGJN0UOzTXQVAu22WrLLFx9HAWHu+wP48D3CQEL995s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=gr9MzxY6; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2210865d962so2089539fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 18:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1709693711; x=1710298511; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xRMkuI014AzS1zR02MZc4IRf3TGjXINu42gGkCfeGs0=;
        b=gr9MzxY6didSDee6a3fcTJvshdgeUWuGOajnzve4ciqcfD25SrXInp+dlXNELYE01Q
         UmA2qeoHQ1EN/Qr6s1ZHa8D96bRKjIBndr+w3LksBg9BNKTaiiHMlXfd79jJNNKc/iu6
         +Zf2xH0ZnDnkqEmy1dPrhwnE9CSVRK+yW79DI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709693711; x=1710298511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xRMkuI014AzS1zR02MZc4IRf3TGjXINu42gGkCfeGs0=;
        b=B0wCKMLkBZ0ZTcZbOHNPOmwISoQy2U7Ckmv50EfnZYpw7cgA7KDVBEUmj56Mee1puz
         NgPqAWv+/hvgcwoMHELf+S+BANEQ8QCvdcFm21w+acz/wG+iFEzkhAp3qW2LrH2zU5Yb
         DyLZbzE1D7FO8ATAc5SqnDfgZoqcLo3woPvXFZ9e+4aXaOL+zNn72meAQYZqilSbBYLm
         eZXEYIEdDMNNTWOWsgmw6+cibts5I2A6rAP9JnX/Ti31KcyIvLxcIkewNgMbPpC82XDG
         +lOKcLIJ+PgU8+BOEZaprteAX0QPBA1JWoQKNqcHF/VZmqIHCHQqgnHKuLnHnzl98we2
         pZwA==
X-Forwarded-Encrypted: i=1; AJvYcCWyfgu0e2xDAdXP7HE1ZyJBMJjjQMllXByUhLCP+yiDf36LDYHcz1qEgs6aInGElc+gRVbpSiMCJBslyZ5seBcFEO73bYK518nJ66eB
X-Gm-Message-State: AOJu0YxUAzxTIIFwXGn4WAsienh14uYemIJGx0sb0IVdfasSX2BacxVO
	56zcJH3C/5ue3VhzccBCMH+tQQT0CrUp/M0NctaybzXBPdkrv5Me/2Nv/umSvbBwkgepOO5jMyT
	GNg==
X-Google-Smtp-Source: AGHT+IGVQj4drpeLlqZu0UGH7MJF2dKwPJG+QIfz4rVWUgG8ZqQMiN4a2/ohEToFBsdf7vzvg14fqw==
X-Received: by 2002:a05:6870:63a7:b0:21f:17b4:3842 with SMTP id t39-20020a05687063a700b0021f17b43842mr3820887oap.45.1709693711394;
        Tue, 05 Mar 2024 18:55:11 -0800 (PST)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id qh10-20020a056870bf0a00b002208ea2347asm3245084oab.11.2024.03.05.18.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 18:55:11 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Tue, 5 Mar 2024 20:55:09 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.7 000/161] 6.7.9-rc3 review
Message-ID: <ZefbDbzbLpiIR-0J@fedora64.linuxtx.org>
References: <20240305112824.448003471@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305112824.448003471@linuxfoundation.org>

On Tue, Mar 05, 2024 at 11:28:47AM +0000, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.7.9 release.
> There are 161 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Mar 2024 11:27:43 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.9-rc3.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc3 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

