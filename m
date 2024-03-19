Return-Path: <linux-kernel+bounces-107894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BD488032E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7905B1C20365
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBBE18C05;
	Tue, 19 Mar 2024 17:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ew+6m3iu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF461171A1
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 17:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710868391; cv=none; b=SWpZlmNel/qu2GrfD/M/D6PwiWlPzKkqBx7qNuXx0LX6OkKytawhe3jZQu2MavQsMM1L72b9nliEcfEVeYECPdXXd3Qp2jX2vL5NME6BWFLDx3buHlGD5MiyMadRys2tzB7u74DAPa6skTxy09DwpOTC/djAlDBNBsfOiB6xMKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710868391; c=relaxed/simple;
	bh=EVj78/Jo/kRaq0OBRJ/xCMSSL6W39G5JpVGpNm+PYJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SNApnvg5nBvmbn75tbPGKcDe1n7+NZOnyu9BcX69KKb2Cll+rBXy46hBSCnNriVoSSnIHE0ydFp/FOoHU6gSF9OGRYfxS2QNymGDXFEd6WCDv3780MfSX7oS4kJ5oB3rb73Yrs07suzysx2xP6X6ARZezhH4/DDPa51dJP2kuTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ew+6m3iu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F67C433A6
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 17:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710868389;
	bh=EVj78/Jo/kRaq0OBRJ/xCMSSL6W39G5JpVGpNm+PYJ8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ew+6m3iuG87/zUcwdt+dMfS2GMu90UGrGtk1HBdz6k8dTZ3FubZeRv7yUXLaNvdtt
	 owSQwTI2sqxUb6r93Z8KAGjD2rcjuYZptoF38Jl5huUJZrNq/TYi1xVXQRWiuUXgxL
	 PyY/QMYGP/7pVAZVCbTeFL5y5n5tTYe9dQq+/NifE8IPUbeux0893t6ho+FuvZbODJ
	 rS4i3KXGDkiE+t9dsv5lSVnnwSnZRoekRNzUTP4NWnp2pV4NX/ee/e4zbPD8YOHBxi
	 1Js8wqDpD1oThaTUxLeWKpjJfbizz0yufOSx4wcuLvQJOGnnaLwb8Ugfcei5wLfXVY
	 2UaVTb3s8U7Vw==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d2505352e6so65876691fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 10:13:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWXMjs0onEkY1sBV+7xfnmZ20LsPFHHVAtYzFjL1KSzpZwjZKrcMkLcOG26FjHDI8jtI85XoVYGhjJc8m+cSj2kB2pM2oK0anzTf+Xi
X-Gm-Message-State: AOJu0Yxf/7MDje0G9SD3FxluU08DCWlUQqEnohrtV+PKSvNpCtjyohL4
	ggMjYHBTkbEcSxpNh8Lx4O2cNZp/E1t/JQd+i6CYJpUcuruPYs44okA/uOdu1/7wxxooGapMBMw
	TZXN2JjmZygt7kjhuMt4anw6EA3A=
X-Google-Smtp-Source: AGHT+IFAAYXvIMA/RnFidaWaLj7AHquGskjKmG3Onc8xY9CYa+F8xu2ScwcZfmx9htt0ysaa3JDNiEJsOBD4Vwu9l+c=
X-Received: by 2002:a2e:9c07:0:b0:2d3:ada4:1228 with SMTP id
 s7-20020a2e9c07000000b002d3ada41228mr11144563lji.18.1710868387808; Tue, 19
 Mar 2024 10:13:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240316023932.700685-1-liuyuntao12@huawei.com>
In-Reply-To: <20240316023932.700685-1-liuyuntao12@huawei.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 19 Mar 2024 18:12:56 +0100
X-Gmail-Original-Message-ID: <CAMj1kXH5bpbagOO+WFwxp4=U=Kbu9RVbPrEemt80S7My1jTEdw@mail.gmail.com>
Message-ID: <CAMj1kXH5bpbagOO+WFwxp4=U=Kbu9RVbPrEemt80S7My1jTEdw@mail.gmail.com>
Subject: Re: [PATCH-next v4] arm32: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
To: Yuntao Liu <liuyuntao12@huawei.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	arnd@arndb.de, geert@linux-m68k.org, linux@armlinux.org.uk, afd@ti.com, 
	akpm@linux-foundation.org, kirill.shutemov@linux.intel.com, 
	geert+renesas@glider.be, corbet@lwn.net, rppt@kernel.org, robh@kernel.org, 
	tglx@linutronix.de, linus.walleij@linaro.org, maskray@google.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 16 Mar 2024 at 03:44, Yuntao Liu <liuyuntao12@huawei.com> wrote:
>
> The current arm32 architecture does not yet support the
> HAVE_LD_DEAD_CODE_DATA_ELIMINATION feature. arm32 is widely used in
> embedded scenarios, and enabling this feature would be beneficial for
> reducing the size of the kernel image.
>
> In order to make this work, we keep the necessary tables by annotating
> them with KEEP, also it requires further changes to linker script to KEEP
> some tables and wildcard compiler generated sections into the right place.
> When using ld.lld for linking, KEEP is not recognized within the OVERLAY
> command, and Ard proposed a concise method to solve this problem.
>
> It boots normally with defconfig, vexpress_defconfig and tinyconfig.
>
> The size comparison of zImage is as follows:
> defconfig       vexpress_defconfig      tinyconfig
> 5137712         5138024                 424192          no dce
> 5032560         4997824                 298384          dce
> 2.0%            2.7%                    29.7%           shrink
>
> When using smaller config file, there is a significant reduction in the
> size of the zImage.
>
> We also tested this patch on a commercially available single-board
> computer, and the comparison is as follows:
> a15eb_config
> 2161384         no dce
> 2092240         dce
> 3.2%            shrink
>
> The zImage size has been reduced by approximately 3.2%, which is 70KB on
> 2.1M.
>
> Signed-off-by: Yuntao Liu <liuyuntao12@huawei.com>
> Tested-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

