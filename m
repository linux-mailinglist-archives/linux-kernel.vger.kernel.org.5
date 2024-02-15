Return-Path: <linux-kernel+bounces-67237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E88A4856871
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FC9B29192B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40083134CCD;
	Thu, 15 Feb 2024 15:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="UM4kEtm1"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DDB134CD3
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 15:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708011962; cv=none; b=E4tUd1lWx99Sonq7OhuiMT0c6d9+iBg4ZUsmkl5N4e68ldjkeEmEahbgfGdwuiynntXektt1Pj20vB/1GyzBv7+nqAwBYq8+pV+Y8pXhmLHbBumhhEhYG/5V8rD6pyo50J4sTzLPMVJ+Xq2mzSHBxl/+C30w0gQ0ER9mEPksowA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708011962; c=relaxed/simple;
	bh=OyYvR0nJ9m4/M/6O/Io2rVD4FvPDQMXmtlWBsQVhziI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p/S4AqXbb47AY8j3rG7TpK+e/DOQqpBbpY7PV5BPIXi23Y9An/Dxpde7aB0W3N3MxncHuVRxM1DaBWTh+qSU2HTSktdWkpM8XqAkDQC1s10Tzt3KvucGEhvZhVqhLWIrEZ4NYKcb1fkdQw4uRPCduh3lIWqkz5VmsYHbjuWy7Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=UM4kEtm1; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3c134813841so396670b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 07:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1708011958; x=1708616758; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VHgBe25+eERSHksZlJnlC2Hz2Jbap8NDk0LVkzb97yk=;
        b=UM4kEtm18h/GdOPefrxJUwwc/e2A1FrwnaPJ8+c4ixvqQlPjKe+T8qlZbfTYbHDqWH
         UGQc4kZWaUTDIgdrLYX5A1Yjuc1TmlzP5fXxnN7wRjsfU+kSwlJnUTY1z17wd5MCPTmo
         dhkqkGefMF0PaXJDyzZq75fW0JKw6kwPTAJOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708011958; x=1708616758;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VHgBe25+eERSHksZlJnlC2Hz2Jbap8NDk0LVkzb97yk=;
        b=B6FMXY0OgjtN+5DMH+8vYqLSfpjNvXe2Z2XdCy14pT5p0xBahjMOJsscht75litJN3
         5Z/qCWFDVREKfVg5r6LW9A1Kj9J/rFiPKuaRwbJfL5alWLHgxvwxn/V0Cw+vTpubvlRL
         jmVX2siVC6KkQVei7uEd7wxkmhPP66uw8LBKQMeDW0HxaIpRbE6cQYJZgeBB2POPbqD8
         fbGQU+Bmh0EMph0dQQuhawBkWJwwZ2g6qgUK4zCsVGBqPHtKOl7WY8vtvfkjnO1y3rIT
         qqlUGD04DGfoZGzIWcw2uP10pViSb4NyVnlPRDSrQsjpyFJ871LSXQoDRI+5jOlfr9fG
         DxLg==
X-Forwarded-Encrypted: i=1; AJvYcCVFY9mwxaj79Ie5XWFhJBuoo7LpjOeGjz984HO4sBSX214+1MANmtMNpxBJSzcEEyzrC+S0XD+M5gvDuV40Jxml9uzyHLffiDL703I2
X-Gm-Message-State: AOJu0YyfHXfTc9CM0DtCyOgaqd27+stc7CDccnZ627iw1w6Z+4QX/CPi
	jg6g/rKvannwr4nfXbdTT6qpzISCvPUbs+GdjFTW8XZud/p2u1u357DkWkn2bA==
X-Google-Smtp-Source: AGHT+IEn/CD+jUYHryIveWJjl5955TfMP6i4py7xzlOW5kREQ2c3KhoyBlQ5B2a7aIT2H4QVAoUOKA==
X-Received: by 2002:a05:6808:187:b0:3c0:33cc:3a36 with SMTP id w7-20020a056808018700b003c033cc3a36mr2386664oic.6.1708011958410;
        Thu, 15 Feb 2024 07:45:58 -0800 (PST)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id bx39-20020a0568081b2700b003c072ae9b4asm219086oib.27.2024.02.15.07.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 07:45:58 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Thu, 15 Feb 2024 09:45:56 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.7 000/127] 6.7.5-rc2 review
Message-ID: <Zc4xtIwDdjm_Odrr@fedora64.linuxtx.org>
References: <20240214142244.209814342@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214142244.209814342@linuxfoundation.org>

On Wed, Feb 14, 2024 at 03:29:59PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.7.5 release.
> There are 127 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 16 Feb 2024 14:22:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.5-rc2.gz
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

