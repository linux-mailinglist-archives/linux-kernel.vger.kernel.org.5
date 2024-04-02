Return-Path: <linux-kernel+bounces-128054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3E3895576
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFF3D1F219D1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223A486120;
	Tue,  2 Apr 2024 13:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="cR2JMTvO"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C188E84FCC
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 13:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712064759; cv=none; b=ptWGh/MxdeOXmM800WwHnnr+Sujfjr3TwZsMpBHbKiheGNoT10q2cSF3uejA7J7SLb+JeZrq+RPMHTAEULk5R2vaj2DsK6zhufhUWDrT0mMh3UQasoGwj9+fFKITlVpvWls6WwPYGl3O36baMu8E2K9fC9Cc63upx+byl10ogoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712064759; c=relaxed/simple;
	bh=bYMjyk4hxADDHJfM0n08rS8SVAMEDwCn1gh7K6kIzjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LEPrX4B8eSmiDXq2hEgDX+xW89XqNy3mrBF/6E1lHpvfASB4Cjg//J0/Xe/yb8DejLibUX0M306ONXKBNTA+qfGH0iHFjlzr/cko9h/lPz3/udLxt3SHnmFeJTFH7Y1QeIiq6E+o/kdmOEFcCJr+A61S8PfWvLu8YKTNqrII37g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=cR2JMTvO; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3bbd6ea06f5so1965936b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 06:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1712064755; x=1712669555; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rFk53LgoUmRncPhQOHRWVLYTVzn8/nw+iy7GK4q/aeM=;
        b=cR2JMTvO/YFTJE1wJJt96HEvh/z08Eed6lbUI1r/+cBFNjP84PY26kwN7AHR1hMRz6
         Tk75OuTaLHCIrKXY4YX1knARCZ9giH5VFpuRW7Kxmaccg+yUwLPfHtqjwWk7hBLv/skw
         EzVLNWUdu5f5S7n1wjBUA4aj03SoPXeHVEVG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712064755; x=1712669555;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rFk53LgoUmRncPhQOHRWVLYTVzn8/nw+iy7GK4q/aeM=;
        b=DUV1mRn0j1+TZVStyiUCY2yZ5625LAcybqmpSh6LppdA6FW+TZ+HxaTeE/XGH1wIAy
         BKnUoi5qbTJ7rmqxGWe8NQZ9HIbm6gsWKwmMRFfzlaUPzb+wr3XJP+Hd1gU2UDmsAUlT
         DvL+mPlANES0GS+raDV4R+w7ZUzNXlfF2kz0+BkC4DDD9Yr559QD6hG59MeVFR7BXJSx
         oBX4d5aewUYrLzDoPMSD1TcdsnhfbIQQoCJoDYkYYfa/LFjbYxx2X54tOwoAQNwweVrY
         cAIIfEabOIVUL7k6Of4H5tmjLdgCoUs3wuNoD5skIef90AhbA/om1J3R2kg9hlDl4JKP
         4pbg==
X-Forwarded-Encrypted: i=1; AJvYcCX4SAA90T25SFmgNsHTr4kOrbE+C88zsMBjtG5IXdxuSSCz9nFhZfJTkhX7EASA+Z/R+hVsRla8xaLPFkc8lbAUSYvGP8cNE0meuJcv
X-Gm-Message-State: AOJu0YykiDrywUD2H4PMHKOY204i8yyhT2SKRjuS8RjC4Gy2Lm7hyI5A
	+lnm7gfrsTW87pzOJNfPeCn2Vvw+O5GCMUwRux1P/2KUf2P3uwf0Q6/UsQ0xOXocbDSmVA9NrZD
	zsQ==
X-Google-Smtp-Source: AGHT+IGwAyzVLBJg6cCeBEnPPvIFGhOsxaFmkiLKmxkHHNwNG6Xh7kFK8xRSsAXbk5e0fkCkA1YUzw==
X-Received: by 2002:a54:4788:0:b0:3c3:d203:2081 with SMTP id o8-20020a544788000000b003c3d2032081mr2609629oic.8.1712064755686;
        Tue, 02 Apr 2024 06:32:35 -0700 (PDT)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id eu8-20020a056808288800b003c4f4873bf7sm224576oib.29.2024.04.02.06.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 06:32:35 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Tue, 2 Apr 2024 08:32:33 -0500
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.7 000/432] 6.7.12-rc1 review
Message-ID: <ZgwI8ZzV7OgNezw6@fedora64.linuxtx.org>
References: <20240401152553.125349965@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401152553.125349965@linuxfoundation.org>

On Mon, Apr 01, 2024 at 05:39:47PM +0200, Greg Kroah-Hartman wrote:
> Note, this will be the LAST 6.7.y kernel release.  After this one it
> will be end-of-life.  Please move to 6.8.y now.
> 
> ------------------------------------------
> 
> This is the start of the stable review cycle for the 6.7.12 release.
> There are 432 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 03 Apr 2024 15:24:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.12-rc1.gz
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

