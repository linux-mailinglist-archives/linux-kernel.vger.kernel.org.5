Return-Path: <linux-kernel+bounces-36214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2ACF839D9C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8927D1F26B13
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 00:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BF964E;
	Wed, 24 Jan 2024 00:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="XZQxkn9l"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9837715BE
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 00:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706055597; cv=none; b=GeF29niqT9EQHY9Prko340KYljI54F2ZWGyNIeJbB3jfWipJK/cxhHpCcM2l37UAbnYSnEM6AAAQP0tQrvHtYKslPVfP5HlnEQVq+WZH5ckUG4PItZwUstplPzZoIxywzmtTLfk87ExXrz8nbOU8frgpDsf6ez+jQJ+VeNIb09E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706055597; c=relaxed/simple;
	bh=E9slISdRQCUtnZ+5bEdkyuaRrDBSjvSbLX+hZx5Pos0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XyKnCDZb5ZPJ+z0OmXimbfwuJlUxB8hdQDcANxxjl6zGm6KnQeqwVhHyvSjBvGyTqw6EJmXYaph8GGEnwDZrJ2Po52ysp1I1rzjH9BZtoYDCHjO3PUthd/Sw0NYhx8Ka9cMq2yA+SmZHFNvAMdc9PqSRfJKU/VOaOJdZ4e4o/B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=XZQxkn9l; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6ddee0aa208so3427714a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 16:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1706055594; x=1706660394; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=81ftY3dle6XzhrC0dDVlho2GnMI3JOjMgqcW7ZGZ3j0=;
        b=XZQxkn9l7Js265r0cgt6PJwNBqrtjykXESj3ZJWL9/mpCjtqHlTJdcVvbaxCEo9Q18
         ExwA66C6FBRJNDZeZvTreUSjXaLiMdEW94gbGO8NN98PARVQQl+cXXFV6RCShaHm9RMp
         L3wxZtRObNtD2fKZ/nsTlVyoaxIAGYeNaL1Po=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706055594; x=1706660394;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=81ftY3dle6XzhrC0dDVlho2GnMI3JOjMgqcW7ZGZ3j0=;
        b=AWVG+pD3WFEc9mLLvtMUyGfLskReJfJTJ/0XlJk3nXGJW7AqOGQmMXUAbiFWbjZbsM
         GW4JZHuTaqN1SAiacimxtdaX+DKsuKKON6tQsSs7+PoWyuATUCaSvwKKj6Wudb/VHdA3
         XwkP13o6p2cu/hyJQreycvz9fY33aEGzLUJURny7FkgNKwfnXEzSkEo/KRmBuQInTh8s
         8+ZQnuo6BQJDLfp/bMEE3Khe8mClWX4/RzsKLuP+K07VAIYunISleDqzfrQ891JIq/4E
         VGe8oRMu/ZLtjafb6dTp4adztjjRRs5MluzLMvgTs1nH2+itU0eUYQaxG9f05XyxLIgX
         2a5Q==
X-Gm-Message-State: AOJu0Yya2lcs9K4FTFkQaHjLfrVlDCQcFeh1M3DP4O6CowWRD1o1g+Bi
	x8LGVIxEk0106dXlJGZgSAJzDxczcVgRJ6CkmyuG101zjgZT71D4ssFVlpwF2w==
X-Google-Smtp-Source: AGHT+IFX7709r8xi2M3xifkh7VSirCtDIVSFW5tqOYbva4Pd8RdmW/vezzFb0FXM4YlFg1uNcv4IDg==
X-Received: by 2002:a9d:7f82:0:b0:6dc:3f8b:1c61 with SMTP id t2-20020a9d7f82000000b006dc3f8b1c61mr761243otp.39.1706055594728;
        Tue, 23 Jan 2024 16:19:54 -0800 (PST)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id w10-20020a9d77ca000000b006ddda12a747sm2338743otl.70.2024.01.23.16.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 16:19:53 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Tue, 23 Jan 2024 18:19:52 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 000/583] 6.6.14-rc1 review
Message-ID: <ZbBXqFvGhiLV9yW3@fedora64.linuxtx.org>
References: <20240122235812.238724226@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122235812.238724226@linuxfoundation.org>

On Mon, Jan 22, 2024 at 03:50:51PM -0800, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.14 release.
> There are 583 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 24 Jan 2024 23:56:49 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.14-rc1.gz
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

