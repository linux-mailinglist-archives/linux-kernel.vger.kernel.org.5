Return-Path: <linux-kernel+bounces-91959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CC2871909
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BF2CB24ABE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCED850A60;
	Tue,  5 Mar 2024 09:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JsbX5dzF"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CBA4DA1F;
	Tue,  5 Mar 2024 09:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709629672; cv=none; b=QHjSjT8tNBRAp+BuVaRZEVwbF0I8myq/FCo5+PbNiIhr7ob1G0XNt6NeFWCY5e21KPG9GpOBCgYAl0aWZKsQMaJrjehQSPRKNfxPb15tyoMoTc0Hfk6jzYC8rL4K6HRQHEtOYbI+z+BQPigmp4VuScVP26jyNRoF4PG3JQ+B4Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709629672; c=relaxed/simple;
	bh=9sSwvYiVNiVEMFJhGyHIfjkNYJ+8iisCRGyT03Xnpzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=luSpWG/rLebRwjAdJTWdU2it6h/5Jl2SwNDb/ZxAPH1K7Y0jigLwCzs2eRWwHPfHQcYEPEphberhPW2dpc5Uf5umEZ4WBRRr/dnHPFYJNMrX11sx10eHVMYD5LQcCLMrMX0/25pYFIX36yF+6U1sKkkA7KX/IifaK9tGdUuKqY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JsbX5dzF; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5d42e7ab8a9so3823353a12.3;
        Tue, 05 Mar 2024 01:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709629670; x=1710234470; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xECqrC5wW8C4gpURucKnrkHYEZdlXOnIvk1nQsHS7MM=;
        b=JsbX5dzFK2fXu4p+216MG6FRTyysaJ0EuZOf3v54PVyw1pJVPmC63JqJejr67+72yW
         DGXdx0M3wcAMtuTznRRpeYUi+K4l2yYWeY1UuSZ8d7L31L0GRfmsamsT6s3AlYCS68ql
         cSHrqvbMnMtrp3D88msPwk+bOULSqXvfxs/aOg/cSf8KCZYl1eYU/Z0VoG0X9pMXKQLS
         4YVT4VAjuvPt+cR99QcLNShCeFTt0GMIT4h5v9ps9BTztSH7Z9SAMUioK1dTu2SofodE
         Q9Lc6R9ZVntLTgmfGJNLwSK3ExCeaT9hCB5U48F2FYTJlIX9hMfck6RODlOfCiuAnYv5
         VGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709629670; x=1710234470;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xECqrC5wW8C4gpURucKnrkHYEZdlXOnIvk1nQsHS7MM=;
        b=SMgegF9i4uB4y3TxSSUfmAB6GVcihR4nGR253G9xixkvhbi63akwSx2J5nMI+2JNO6
         LHWVRNybJbTtRsMPG5yk54ncLL6IRh3bBUP7WiY47FgH9YmGXmfauF14eI2H1cb1Hl46
         iuB3LH6qMhmEolTRw4gOUpf8Z/hcgQRJbBwDi6kKhOVVBEeEs0A4OBgW9TLrG+qbnE+X
         hNjs9KfBuRB/boDCQZKpPIoUKDolqUJKNBC7vswGfHpbD/IJMUoV0vR7dAN3M7AtCnu2
         Y9PVZXgvwvTM0sB8A2kY9z9JsdY5Wqaj5gwwEL+PEIHtFxxOrHgs3Y6Y4KCntHp+eZVl
         3cOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpSdCl+9kY8Wi0YvP1Osrr0AeVImyXPLZIy1BU9CdTgvhWvD37ifO/Tk1MPAreT1JqPDCLb9GpOdwUqsXCJ3hUDLN0Zbty2WXx60w9LVAx8COpYGZvL1hSFKZRia45eBhHX22t
X-Gm-Message-State: AOJu0Yx2QWPvl/aDAIYQuR3MEJSkJjBTOCnd6O5cO8QLOt7JxPH/gjtI
	svNOHFqYiv6nIPEDN2rxEap4jltiHs+kVBJvuRBFsAONi4RzKVe3QNeWwk8lPknIf0+R9PFCa5y
	B8bkLI0alb3ITH5VPPoBbUJfoaRg=
X-Google-Smtp-Source: AGHT+IHQCsAc5k/dqnxRuofGLrxJI5VV9DX8j35EwjwxKG9bP5pOWIbRfkocDE/Kxr11z/qfnCWoxfbMUcq/eJzkogw=
X-Received: by 2002:a05:6a21:6da4:b0:19e:2d04:d775 with SMTP id
 wl36-20020a056a216da400b0019e2d04d775mr1121314pzb.50.1709629669859; Tue, 05
 Mar 2024 01:07:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305074649.580820283@linuxfoundation.org> <20240305-arson-panhandle-afa453ccb0aa@wendy>
In-Reply-To: <20240305-arson-panhandle-afa453ccb0aa@wendy>
From: Luna Jernberg <droidbittin@gmail.com>
Date: Tue, 5 Mar 2024 10:07:37 +0100
Message-ID: <CADo9pHg4teVS7Lt1j+gOt4G9U=dZF9G92AUK=Km6PTdURkc0pg@mail.gmail.com>
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

Den tis 5 mars 2024 kl 09:32 skrev Conor Dooley <conor.dooley@microchip.com>:
>
> On Tue, Mar 05, 2024 at 07:58:57AM +0000, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.7.9 release.
> > There are 163 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Thu, 07 Mar 2024 07:46:26 +0000.
> > Anything received after that time might be too late.
>
> > Samuel Holland <samuel.holland@sifive.com>
> >     riscv: Save/restore envcfg CSR during CPU suspend
> >
> > Samuel Holland <samuel.holland@sifive.com>
> >     riscv: Add a custom ISA extension for the [ms]envcfg CSR
>
> I left a comment in response to the off-list email about this patch,
> I don't think it's gonna work as the number this custom extension has
> been given exceeds the max in 6.7/
>
> Cheers,
> Conor.
>
> >
> > Samuel Holland <samuel.holland@sifive.com>
> >     riscv: Fix enabling cbo.zero when running in M-mode

Works fine on my Arch Linux desktop with model name    : AMD Ryzen 5
5600 6-Core Processor
after the Arch Linux manual intervention for new mkinitcpio settings
and version in Arch

Tested by: Luna Jernberg <droidbittin@gmail.com>

