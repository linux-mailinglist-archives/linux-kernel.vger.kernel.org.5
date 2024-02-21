Return-Path: <linux-kernel+bounces-75319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EA585E677
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FCD61F27656
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3288563E;
	Wed, 21 Feb 2024 18:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="bZ9zJLPK"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1760969313
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 18:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708540753; cv=none; b=jBz/WKn8GbJAlu60vXWgGjhg1X4Kz9TIGnVvtTth+ltgiEysMCNYpFpikTc3jBJSau3HdDG/YUq5KYVx+2aAAmh8Z+GgbR0Siv0PrCXO3m3y1nJVmkpo10rtlhRpNs+QUVlIC8EoxfetovkAtjw/nwotI5FICbPSsgaMxxcmYxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708540753; c=relaxed/simple;
	bh=wORu2VHuAnw935+Cv0QQr5ove+ncqd8zeKB3hAAfA0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CmpB7lVX85wQ5AnLds+zKuwpeKb5xeofhVTEb7YDg6bi5y6OSQrL2xqFy9vuIKi982u4Ef5vg9+6/p/DXlRFbO0VjzB1M2OONPDZFeg4MRRp1BLIT1kKALJaTv6lSAJwt5pglY3z039f4q15zsVxLopadLheye8bcb8+TDTYXvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=bZ9zJLPK; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6e2e096e2ccso344805a34.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 10:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1708540751; x=1709145551; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=epfXkFMvEj+O6RQTqhcuu/VpNn7r6C+NR5UDG63CzB0=;
        b=bZ9zJLPK/zaAwU86KSYjgaEsZviABB7myyofQoNoWbJr12nf3YzvOjv69oxpTXIhST
         OZfXRmCuc03a+v5al5f5aZt4oYJggwA87XBAiduvbmeEUul9E7z42MeEfew8IddtWcA/
         uEvapzfJQgCbl3nMNILLyTpCMNdWHSQr7jZ78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708540751; x=1709145551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=epfXkFMvEj+O6RQTqhcuu/VpNn7r6C+NR5UDG63CzB0=;
        b=mGJbWr/AutRBIxELJi9/k9+JxperZptvHzFpZxB+0cExDsPDxXYt/VrrXgGkFrKZYV
         hCHHYgVew6vsg/PXNqJDtZNLJFNfRhYhmvi2zouoSBZnnuVIYVdBIveNslWUauthROqF
         4c1hy73/o2t3i84ynMz8XKfMI8fy2ysA3/inbz/x5MiUfyWzjIz4xPN6ohRRm2CdRNNz
         0gtqAqiWuMRKf150pMnICs+tlhRhw7JVhR1QUcPDXKClDmgbxLhQHBtS/yQzK7VuTnVI
         m4KtqJEd86kZIjzD0q+fCQdtDNCvNbTTFIs2/DFSh/eGMZJoZ5Gf9qKWxgB739ihrRtA
         3Gag==
X-Forwarded-Encrypted: i=1; AJvYcCWynN3YmkpZRbm/xIQdw0STmiI4eDT4K2TiyUqoYsoERvEGyQYM5WT3Aw4qFqc/caaBT2lsr/dgZg2jv7tyJ7x1tbyUR/iOefnKri9U
X-Gm-Message-State: AOJu0YwYWjXHVgc389FNEkTjxoBIkbeiMkQjQOeuVSbFCdL4VhQwgVMG
	TL6EjTHbdF99Vimxkp3ys4ode32zFE0d4knvrPfJiTDhslWT4NusG3i39kpYRQ==
X-Google-Smtp-Source: AGHT+IE6vQu9Ee36mA2Xebhws5M+r7A1PWQ4d3zqpqI9AXKlri0chGThzivmD6usVGdGBqrmBaAwIw==
X-Received: by 2002:a05:6830:454:b0:6e2:e526:b0d9 with SMTP id d20-20020a056830045400b006e2e526b0d9mr17898788otc.16.1708540751121;
        Wed, 21 Feb 2024 10:39:11 -0800 (PST)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id a23-20020a9d4717000000b006e43c2c4381sm1673596otf.74.2024.02.21.10.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 10:39:10 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Wed, 21 Feb 2024 12:39:09 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.7 000/313] 6.7.6-rc2 review
Message-ID: <ZdZDTZQDspSCagGj@fedora64.linuxtx.org>
References: <20240221125951.434262489@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221125951.434262489@linuxfoundation.org>

On Wed, Feb 21, 2024 at 02:01:12PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.7.6 release.
> There are 313 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 23 Feb 2024 12:59:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.6-rc2.gz
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

