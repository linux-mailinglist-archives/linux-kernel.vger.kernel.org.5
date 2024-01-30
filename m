Return-Path: <linux-kernel+bounces-44976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 700438429DA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C63A28F343
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD5A1292C3;
	Tue, 30 Jan 2024 16:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="iQTw/6Pr"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78B51272C7
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 16:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706633137; cv=none; b=grI7BpqQ3BMib/ywNOZxihIxZ6GQgj8Fd4nz2xBnhBwtgekC+FfG9HuXeUj99IfZRtEV+WMt6wMc41u/1T8txPaYP8Ysf1kL4cUmSWrsc7FF+DZcOI0iBHT6po3L0sMZOv4+ZAB2xhT41ZO4/12z4GId7HyzcosOwgHKWS/wsiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706633137; c=relaxed/simple;
	bh=AIyoCnIcR0xulr+69tWmalebwTVyrh6N8UZ0ZUx2cy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ll7IYwZmcJJDGTJn0K/HsgghrLjD1lWu4nVC7eUEiagEytRdaAaigJxa0q0SUT/jgYFocYPxM9i6OBjq7xdVqesHclyjFL382XJNM+HcnnC7dO9VtD/v6pyrQG2sAqAaKeSsICv95F776LdO/cUjvoOfA7dPOL0HyufUU1cqd8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=iQTw/6Pr; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6e125818649so1564627a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 08:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1706633134; x=1707237934; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=udsWbEyAIPNx44HC24sXqwuDIvjPMZEaViGLb+xNZaU=;
        b=iQTw/6PrVwyEXhASOlxEbtEpapxoM7uWuDz5d5ewufDJIP0fbBVvK9QG8vmrV7Eova
         20rkCzP8St5sWPuCgd+FeXMKaES2iI/R40rDTBVJZ/RYYPgNOm15gnIPPZyFgIRs/n3U
         Nxzck0H30jlaI1f5i7VFfvQ/TOXBCPVpMhxG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706633134; x=1707237934;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=udsWbEyAIPNx44HC24sXqwuDIvjPMZEaViGLb+xNZaU=;
        b=RXvagOXYefZRQ+1Hrj5+gjd75kJgUfw+by0xamzVUbqXH2HVPS4m0b7AjdGN7Kv+27
         9YRuSC4mSUAa1LQVMg6JqT7dLs3gzwPvyTzJ1EE3w5uOl/xK0UT5c1zO3Qgj8m5qbC1y
         mgd3BR4EEGGrpFjIeS8fj2oLh2OZKb4x+JMYAAM662Htb87gY4AjPleixdrz7D/MrGDA
         h3mYjyqVLzVppcH+5hI2A/0yv4+hTVWTIZaoo4x8Xrhr/jmhruWKB0VCCCk+XUWm0LKO
         D/hwWTbjbK2x6FYxaoKtK3tBVvxrBgJ7pq/6+I50Sa1jdNzEH0F6Yn/Xx6E/Qxi+Utqx
         be1g==
X-Gm-Message-State: AOJu0YzZEFTzW61KqdOrXNSSpdPLg0nI4RGXVttNF4NrR99z1X5UZ6mm
	6VWl0GrnPkGByzLhVQ9YLaVBdVYp48Ly8+/IOEtWPJEo8Uf54RL8mu1/HHjhhw==
X-Google-Smtp-Source: AGHT+IHrg/QN5+BAsP/HIdzVNNMa1PVCKsgnvfGLMoQK3wzAbLjbr/b4izwEksq3Mi5Ce4hSJxR5fw==
X-Received: by 2002:a9d:730c:0:b0:6e1:152f:ec89 with SMTP id e12-20020a9d730c000000b006e1152fec89mr8085288otk.24.1706633133912;
        Tue, 30 Jan 2024 08:45:33 -0800 (PST)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id z23-20020a9d62d7000000b006e11970fb7esm1487992otk.67.2024.01.30.08.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 08:45:33 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Tue, 30 Jan 2024 10:45:32 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.7 000/346] 6.7.3-rc1 review
Message-ID: <ZbknrDOTkTeoMc2n@fedora64.linuxtx.org>
References: <20240129170016.356158639@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129170016.356158639@linuxfoundation.org>

On Mon, Jan 29, 2024 at 09:00:31AM -0800, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.7.3 release.
> There are 346 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 31 Jan 2024 16:59:28 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.3-rc1.gz
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

