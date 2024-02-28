Return-Path: <linux-kernel+bounces-85548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3C986B783
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18FDD1C262C9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C4E7440A;
	Wed, 28 Feb 2024 18:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="gVAFa/wF"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4D871ECA
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 18:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709145915; cv=none; b=VGsVsHVSnKx8xufDB2P/tILVBYQzt7tdixC0e16p6wKbYKlbymOs6hFCcwJ8gdLfDqG1QFZh8GSPFKhyZFNAmYjzjzFXeyUw8PUOwqWQRhyAXI80Rq+xZdDp8Vt6iHDVRnw32eh/vpYwA+x19KPmCU9FaFRzFcEiI/1p6RQbecs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709145915; c=relaxed/simple;
	bh=JtRdfLpzL/ZV8ADjgH1+r8boDnPhsaWyXxdUuNrJxxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r81eKx9e9s1t4AWCDUUXWCaXeB9EY5lw8dkXKLDDUGb3eJDEoWt76xeVOypyU6deQNphq8c0d2tALJtgJxE6I0W0Xuu17VDd5n+KI3b55Fp7404iMgjtG/NiZ6H0GBWhbB5nxSlltBwUeEVvHb9WHt0VRQ9yiKA/2qIBRRZogWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=gVAFa/wF; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6e48e2270d0so7070a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 10:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1709145911; x=1709750711; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WYSW/dDZJk0AWK1P14MQeXGDy5+2acJ2m/1QBAbC748=;
        b=gVAFa/wFdMxQbDTeclC7fl0CYTq9w4oaagSQkL2qso/BECg6lnrjnbfywz5TLSrWIh
         BOjGyUg1XtTzrA6VvxuwK9xYQKdy3HGaPR6X8EPsMX7AjnutodsymY0t2SdKe+cCd95U
         BSMPTVAmK21LIsnZtdTtSBYPv5/UodDlIyVXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709145911; x=1709750711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WYSW/dDZJk0AWK1P14MQeXGDy5+2acJ2m/1QBAbC748=;
        b=Yh/IFrDsstI5j5HQorPpQdTxY9kf3lwbI/Gt/UPXaVlYHyTVj8OMDqzMHruM+xpcWr
         uZnzGx7mqzEHAS8ZqyumTvEdpdcu+YavJ3Kb7BJIQ8qx9Rd8CoCmLExM5Xn1TJ4eGJ/Y
         vnut9Ovf/PcJBKfJdGyMrdnMYLOgfqQWqRcA3IPBDW8TxXDLwoN6YWXc6h3eTwcfMWLe
         c5Bbw6vxO2+OGA1rpJvoY+Cr3n63/gf3pX9qEPj4kR3N6Q5GY+rtE1W2ZCYyOe/XEXtk
         MvliBVnVsn9fxlUAwwNpODrNb4TgX995iepixN+jUFHe8QRSb8o+eZT2GBnpCXMulBRd
         Dtkw==
X-Forwarded-Encrypted: i=1; AJvYcCU1G3OMt5hH1dcFEe3IZHbBKYEwAuNOPNCiNpKTCGHcvBC887DuDMbnNxllB5l1WCh/qJ8GfnnetNLBs/WKCzfrV4uCbB310pDO4w0i
X-Gm-Message-State: AOJu0YxA9/vrT+sbsDvQUlu7jW+0oGvZm/eFL/5DgNYvYO65WXO/yOK+
	xVHHbhTcDqzGub/0zsJkY+2hRPaJxw/5NXmBFiboVzvLVxgem20ssUbdeZspvw==
X-Google-Smtp-Source: AGHT+IHwJyaRoEm/YQfCjyx+WogJ05QIwcidCk3H5iKaBfOekKEk67mfRLlcJEz6WQoDdGUJrI9xmQ==
X-Received: by 2002:a05:6871:750c:b0:21f:aa57:4637 with SMTP id ny12-20020a056871750c00b0021faa574637mr546894oac.58.1709145911442;
        Wed, 28 Feb 2024 10:45:11 -0800 (PST)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id nf3-20020a056871460300b0022027f66c2csm12942oab.24.2024.02.28.10.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 10:45:11 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Wed, 28 Feb 2024 12:45:09 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.7 000/334] 6.7.7-rc1 review
Message-ID: <Zd9_NbbahAGDqscb@fedora64.linuxtx.org>
References: <20240227131630.636392135@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227131630.636392135@linuxfoundation.org>

On Tue, Feb 27, 2024 at 02:17:38PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.7.7 release.
> There are 334 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 29 Feb 2024 13:15:36 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.7-rc1.gz
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

