Return-Path: <linux-kernel+bounces-128056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D22908955BA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3465AB2D45E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3B384FAF;
	Tue,  2 Apr 2024 13:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="LbRVt0x1"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E29C74262
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 13:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712064798; cv=none; b=bRCERIZs4Ol2T3PH1QGTjI3krRVedwXRSAzHsdgMdwHG1t21veJYQQ6hhw1KBvodV3YHU4hqNS4xevpaPqEGx66hfKKRr1jL005j7OT/ODq6wrkWxXGSc/M0x/QAZ0243etOID+DdHrlAuiRr6sY9nNGkOq4wiFsRrCoSQZGrVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712064798; c=relaxed/simple;
	bh=gRjg45/IctrQIu/6W6PlRyxAxtvj4BHh8gNS04jmN80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JALnUtjjdrMzrvALh0RUPPmbZOfAVR9wnxl6oIr2KJyM8QoKtbkCiVFIyZ7fw2dyOJs9ZiusHHrUGBwP6xV/sW3vS78Hnb0IOpFIF1htG+hFdHM7gIDL4Hf1zpN20EKeySJHfKBQwWlTEmpFPKBl2p9CdtqvOwqxWgOKfRIltTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=LbRVt0x1; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-229d01e81f1so3110370fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 06:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1712064794; x=1712669594; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jAhsn8hkNoKhwwl/nXRKoYjZr1I0J1JHEwu/MNqQsKs=;
        b=LbRVt0x1C9hi5iANBRK9MN/bfM288DlPlCzjRPd0TV7RIq22797nX3eiLkdR58oN34
         MzHyMp0Hy3gZapUhsC6rZoyURuTenNZNxD8R7/XEpHezcO4W2y1ngbuNw80YTaBL1bQb
         H6LPPKspzLCtVom17oqQ+GVKB94xL2sJgqUME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712064794; x=1712669594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jAhsn8hkNoKhwwl/nXRKoYjZr1I0J1JHEwu/MNqQsKs=;
        b=Hq65CQI0ZLPvOd9HuJ99IujXjpNy84Q49RGPjk3/rzjxl1tlGMvuFpcBb0pRAihd0b
         fQcpNvomhkqZFUJYKs+O1DjF6+OjrYBX4MFpoOEFyMuBHQxdbnN5y4YRM/74+B9i+uH1
         bHQh/z9HQdVyB7uGav4tWvT+w96st5voqwuxYmPsWLZj/D9SMdY+brWyRtP6Oa69nI2a
         IunHp2H7kwgbOPzj2zAgsrIFVxdB/wiKmX31k6w6g55bxwkUyk33napDrI4Qzag8f1cM
         wgwfheV+Zb8W3WvldI9I/TeevZpYYQ7AOXic/yArKVX2jYb1ayKBSIpxBY6jlT2BEaLD
         MUww==
X-Forwarded-Encrypted: i=1; AJvYcCWLdGP7lYlt37v4jkR9DiYFQfz/W44ncfAai39qy+oMY13/Lfc6o7OinOlUaR9GLXiDt+vU8Y+BhmYDccgVtabP9+mC/KQ4+lFSVblk
X-Gm-Message-State: AOJu0YzZUBNloXkY4YJ9Eb/KFL0uyImWOFZuAGiXq/mRvHNEk7YmSX6H
	sQveCVIs468q/vNG8M/sxJ9kUzxwu6r2aaw6pYgL9iqsEe7XWHRuEwoprR6RhRfJkJuI+Kr+Egj
	3Ug==
X-Google-Smtp-Source: AGHT+IEmdktlG/bLWeHAf98nPjODsS9Xnop/ympsC418g2OXevOGyMcq9kJz/Ps+yK4aVORa+/luiA==
X-Received: by 2002:a05:6871:7411:b0:22a:a11f:5513 with SMTP id nw17-20020a056871741100b0022aa11f5513mr14486738oac.48.1712064794554;
        Tue, 02 Apr 2024 06:33:14 -0700 (PDT)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id qb9-20020a056871e78900b0022e89cf40edsm28077oac.57.2024.04.02.06.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 06:33:14 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Tue, 2 Apr 2024 08:33:12 -0500
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.8 000/399] 6.8.3-rc1 review
Message-ID: <ZgwJGDNx7vQ0_CrB@fedora64.linuxtx.org>
References: <20240401152549.131030308@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401152549.131030308@linuxfoundation.org>

On Mon, Apr 01, 2024 at 05:39:26PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.8.3 release.
> There are 399 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 03 Apr 2024 15:24:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.3-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

