Return-Path: <linux-kernel+bounces-91994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE8287197B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEE221C2161B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02F6535DB;
	Tue,  5 Mar 2024 09:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rm2ZB0CL"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27FE52F99;
	Tue,  5 Mar 2024 09:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709630523; cv=none; b=LBWerfHsWiwPIYncXWP2CcHGKZMvnWBiMk5xaYC5U2eImxIdEcdkxMS5XE+LGIW/dYvomyTM78MoPcKfdN77XEz/c721F4vMO5YDCJuyhsQKmsS57tTmoqn4emRch23ZYcx2YG8nCIoktRysh7W6rYCizZUdAIlsPlZriS3VX90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709630523; c=relaxed/simple;
	bh=ZeNuJPQ+nG9eWeW+uI94bP8CSXc+K94oGgi2JBIGUsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=claquZGPWBF/4QmxW+d+vpd5y8qhl7tDECLz0zpGj9McFkcTxHF2UHXK71C5vjAxLQV14yqVLx6Zbtka4t3huYnTRLgtzOi3okhG40QBSSnUvn7xaH6Sa1O6nQQXXeY0ApdWLFL+/Mwm+H+KDhtmjq8ZNl/PkymhP4HQq8h/g3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rm2ZB0CL; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6e125818649so2875154a34.1;
        Tue, 05 Mar 2024 01:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709630521; x=1710235321; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IqYZUusP9B2YtwcxRV+KZs/6sQl0lkghKCYzEJXgvtc=;
        b=Rm2ZB0CL0qHz80OjheT85rse7Rri3gbfbEDWa2VzCySK9eziSVBWQXp6NsqNNDBYPx
         Bon1CnD6ufkPIcOFa/tgnMllOOR5IXEKjwQmqJYcBqDs6UhwnYFGcZrsEMRWdoorGexB
         TLra/r9GV4NQBSg6sNrgfe9VWaoCum1YdfHVi/8psqcHpQmpQiaRyyPs9/jRQUps03PE
         dxJ2mma+uss3sZKFmX+RqyG4dpmaSTIE41AEg/9DJuE8c4OeO5kCUkpnA+gfv+ZmSYFd
         ze6QUrIpCzn/WnVcaUk+sLqT4BGn9dF3+rmW56VkiY71G5uLP8vUiCuapAFgAEyYdLDl
         st6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709630521; x=1710235321;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IqYZUusP9B2YtwcxRV+KZs/6sQl0lkghKCYzEJXgvtc=;
        b=loO/dNfLeeaWd0+NLQ71zEbu29dATDdpZDmqLmaOticFUm25wKOEekF3YeFytL8k5D
         /i8UrAonBXEFnyzPV7fUMigJlKWh+fYLlmiFc1dZMBLcwWaRxADNsscuxOVxJ+y6f4Br
         tTDahxEkBGO8ecrhUyTV8QrlVidQ5kde3r1nh3QQmm0bdYehGIrmXQeMfy5XkZvk+6tB
         KHugbMQ3XjJrkwUtZ3+RP498EVJDwyxA3CQ52gZwd7LDHr7JgVYo1a6H0zs07OhmyF13
         tjYhnJMcBUJahMyGK5BVZEJ7/izxxSbnXz+MFgmJ+1KHNitZses/rJ3c+akFvtKyRjP3
         rC6g==
X-Forwarded-Encrypted: i=1; AJvYcCV/fVP8ykaaPUglR7mjSneiwEjTthcofTd7tchIIBR6ZXt7GD8PJqn8f8jAoeRRqUvWU+I7r3bgFc+NxvghgV+bZohgRzKxtBe4pNldswnE6JyejWYWVnGGbV7mtudkoCC0HTme
X-Gm-Message-State: AOJu0YzIuJqtOwMW76lOvovLcYHXr3rQ1AUmh7n1F9P+S0eGKSJ7A766
	CDov2cDfFw8njqEIxVEgoFsi3PPV4G4Iy/DX1b9ebz+4tuHaF0bV/3ErjnXHoicoOI/gpFHwOIf
	Fw4QiEsuJlGsRgb8CSr64xvUt9Kg=
X-Google-Smtp-Source: AGHT+IFb5h9idRuSrhk/ddWjyydEiB5p8kHuagvuZ+oVcTP7d8TjvVq+EvFccBn7ki8Ef8WK1CbEx2ys9KLaoX76gsM=
X-Received: by 2002:a05:6870:4f08:b0:221:14e3:7f6e with SMTP id
 xi8-20020a0568704f0800b0022114e37f6emr1365197oab.46.1709630520805; Tue, 05
 Mar 2024 01:22:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305074649.580820283@linuxfoundation.org> <20240305-arson-panhandle-afa453ccb0aa@wendy>
 <CADo9pHg4teVS7Lt1j+gOt4G9U=dZF9G92AUK=Km6PTdURkc0pg@mail.gmail.com> <20240305-series-flogging-e359bae88efd@wendy>
In-Reply-To: <20240305-series-flogging-e359bae88efd@wendy>
From: Luna Jernberg <droidbittin@gmail.com>
Date: Tue, 5 Mar 2024 10:21:46 +0100
Message-ID: <CADo9pHh6fnOz7d6+WCwkKz6_T4Ahru=0YDuc6q+KNnKYqQ2gBg@mail.gmail.com>
Subject: Re: [PATCH 6.7 000/163] 6.7.9-rc2 review
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, 
	conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"

Den tis 5 mars 2024 kl 10:20 skrev Conor Dooley <conor.dooley@microchip.com>:
>
> On Tue, Mar 05, 2024 at 10:07:37AM +0100, Luna Jernberg wrote:
> > Den tis 5 mars 2024 kl 09:32 skrev Conor Dooley <conor.dooley@microchip.com>:
> > >
> > > On Tue, Mar 05, 2024 at 07:58:57AM +0000, Greg Kroah-Hartman wrote:
> > > > This is the start of the stable review cycle for the 6.7.9 release.
> > > > There are 163 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > >
> > > > Responses should be made by Thu, 07 Mar 2024 07:46:26 +0000.
> > > > Anything received after that time might be too late.
> > >
> > > > Samuel Holland <samuel.holland@sifive.com>
> > > >     riscv: Save/restore envcfg CSR during CPU suspend
> > > >
> > > > Samuel Holland <samuel.holland@sifive.com>
> > > >     riscv: Add a custom ISA extension for the [ms]envcfg CSR
> > >
> > > I left a comment in response to the off-list email about this patch,
> > > I don't think it's gonna work as the number this custom extension has
> > > been given exceeds the max in 6.7/
> > >
> > > Cheers,
> > > Conor.
> > >
> > > >
> > > > Samuel Holland <samuel.holland@sifive.com>
> > > >     riscv: Fix enabling cbo.zero when running in M-mode
> >
> > Works fine on my Arch Linux desktop with model name    : AMD Ryzen 5
> > 5600 6-Core Processor
> > after the Arch Linux manual intervention for new mkinitcpio settings
> > and version in Arch
> >
> > Tested by: Luna Jernberg <droidbittin@gmail.com>
>
> This problem is riscv only, your x86 machine should not be affected
> by it.
>
> Thanks,
> Conor.

Ah alright then i know, did feel like compiling the latest test kernel
anyways, but thanks for the heads up

