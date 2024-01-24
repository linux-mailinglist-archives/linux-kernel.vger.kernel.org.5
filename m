Return-Path: <linux-kernel+bounces-36217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F663839DA3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA759B27E4A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 00:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5108EC5;
	Wed, 24 Jan 2024 00:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="eIRRRyb7"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB556622
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 00:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706055760; cv=none; b=WwPQVouYqD8XVHM4R7otyWL2L4vl1xBVLnwe9isccJwyuJOLJus/msLfPjsoOI+pMCdX/SRo0pE/R6NVnBa5rf8FvH0gqIllPpvKAsz4TYZLG9BAozcKMYdjhNKGUejYKEqJ3gX5dRWre687gEyD0YQKTMdnACn+ZlXpXXaNWkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706055760; c=relaxed/simple;
	bh=DJlfZwy5oG+ddPT+BAfbUa5jvLqlfyghhFKps3SyvX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rkuVNi2zSP16TWPgvOt//tCZypWLPTGj3pH6l71PEXCaYKDEmHiv5YhrFljGH+Y9+UBENNxFsDv9U53xvS69xPn/8akXsx2KXAbsDMDxbCxZdCSJtwth+FM5mLmJkCdQxEJ09ERJGnhVMe1zVDg+wgxiSUxFkxHt7VO4AVOCUfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=eIRRRyb7; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-214917ed35aso564943fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 16:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1706055758; x=1706660558; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AsC4IZkrsCzp48Uq4gQMFalS4lpCTPnckc984N/Nfdk=;
        b=eIRRRyb7IlnJ2+zNC/NwK+jXb3xB1yCc7ObBIXJrIU8XB2WpOqCgv4GjPSfoCKe932
         XYu8J0nrqYPpqha6fLq40LOwsO6Ib0cRaMaQZwIQRH6xo8IK6cG5QFo5yqdW1lmC+rvx
         Gd2CAQDJ8/rkFcpeDc0v1rRcSX7/t4CFEqtew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706055758; x=1706660558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AsC4IZkrsCzp48Uq4gQMFalS4lpCTPnckc984N/Nfdk=;
        b=FHzP7YmM0IzvEVYpdDUwMHahf09phzE0ceiY2AlFw8KFvSiXroTKyY4ZOx0K/AffKc
         MSeXgNYdXM4mk5/ofXtpPzkRVc+3Chubc1VOBnVWgzxATmvDHgrngUliOTfl9FoCypgu
         A4w5LVGOnBl/WI6I+SCKrVWoopo/PbzqbDc+fVhQpIDn6KWNAcpKt4mWkFDWN12sE0FG
         g0Yb/lq71dtvvYq8YhcO+UM41gemEJzFMnNLlQi/y/U/N50Gp4yrNSTdFeQMb+WXf9eW
         e1n1w39oiCn3PoBLpK37JxOGGmucImsm6xUqLXj8fFt6Db6PB1da0h20LJIcxGVc/ywO
         TIew==
X-Gm-Message-State: AOJu0YzH1sGHDjb7GT9R/JgxQhr2fc2YFXKcFxqnwtpu9D0ew+S1bvxt
	6ouCmtfDQ99LlnK6BkBwqQKqQcvZuLAaQ8rveCaoHC1jm0a2R+Lzco9YQfYRCg==
X-Google-Smtp-Source: AGHT+IF5j2CrNJpmt4xbjt5uNDLoyO8MNIxaA3XcNYGjI8dCmk2XJBy094kJqAM2+8lwjkq4d0k3bQ==
X-Received: by 2002:a05:6870:9693:b0:210:8c13:dbff with SMTP id o19-20020a056870969300b002108c13dbffmr2722563oaq.84.1706055757837;
        Tue, 23 Jan 2024 16:22:37 -0800 (PST)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id cp8-20020a056808358800b003bbe0c5195csm2404902oib.26.2024.01.23.16.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 16:22:37 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Tue, 23 Jan 2024 18:22:35 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.7 000/638] 6.7.2-rc2 review
Message-ID: <ZbBYS-i0uR08aEcL@fedora64.linuxtx.org>
References: <20240123174544.648088948@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123174544.648088948@linuxfoundation.org>

On Tue, Jan 23, 2024 at 09:47:30AM -0800, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.7.2 release.
> There are 638 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 25 Jan 2024 17:44:25 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.2-rc2.gz
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

