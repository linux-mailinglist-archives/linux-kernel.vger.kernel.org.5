Return-Path: <linux-kernel+bounces-64155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7670A853ACD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 082571F26297
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981CD60885;
	Tue, 13 Feb 2024 19:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mTM4F7hQ"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081A660884
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 19:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707852058; cv=none; b=EvvEshm38FE7K5gWMFkoPP3jAHPMVv39zCcmF7ixUH8Z9QcNYUEfnvOEWBbUYN6tu/7VAxf7EMTj+LgMDQzS1lpByAoOrasKtfPXygo1IQH2W4uEpIRlukQxFGnhzf5s/n9rYNGy4cO/g5aoCkt+3tEMSm6F2TuziXIIuMWaqbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707852058; c=relaxed/simple;
	bh=7dXfSRYBwhsTCt6sxxpGuOjndcv/iGeQtLLQrn0l66Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fdho+YuQqryP2NhltpeB47asV8hiyFSIYUrD2hjImbsoSh6C0kBEuYwg+HQvdnEdq4Y7kyRxm5X+CcL4DS9QPhzfs0xf77e02Ii/UX3957yjRkjCL7ml+FMNe9FtN2X5gNF0cdEcu/IXq47jcq+sJjVhCHHc6l0gQM8SLu7+uDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mTM4F7hQ; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A28A960002;
	Tue, 13 Feb 2024 19:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707852053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3mN8xA0cTxrfZTtwyelonCfpSj29sYDVq5G0MAoHaHg=;
	b=mTM4F7hQA4rbQGgy7sC3p/Yv7/5UjDCvUgPm6/bAWUy0+uMa+aibebP9bxlzXdgUYqX9yi
	mil0ph6jS4jOu2kIq/+o6MRGFLxNaCxBaIOdKBeh9wjGhGlWX5sikiGc8krqb3BcrvWN0+
	dX9mtKLCV3hUdRjCKgivbP90sRUVc+idvcfAgawP8+cgpQGLeBstLxLgtk44s57DdsStkh
	GHnZ6TZONle3bG1I7H4plHnLMC5LFAtoq5hWFCHzzVwAJEMqaQl4ym2GgAHe65RML7KmH1
	5o9EYyOs0pXa8bRL3ATNSbCj9HKC69SrlMvFSa344EoXEH3oIamnN8vMvyXnJw==
Date: Tue, 13 Feb 2024 20:20:45 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Eric Curtin <ecurtin@redhat.com>
Cc: srinivas.kandagatla@linaro.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 regressions@lists.linux.dev, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>, Chen-Yu Tsai <wenst@chromium.org>,
 asahi@lists.linux.dev, Sven Peter <sven@svenpeter.dev>
Subject: Re: [PATCH] nvmem: include bit index in cell sysfs file name
Message-ID: <20240213202045.1e823a6c@xps-13>
In-Reply-To: <CAOgh=FwFMaYvTwmqeOQrqHq2XANxghZbTuY3+SgFx_ozpysBOg@mail.gmail.com>
References: <20240209163454.98051-1-srinivas.kandagatla@linaro.org>
	<CAOgh=FwFMaYvTwmqeOQrqHq2XANxghZbTuY3+SgFx_ozpysBOg@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi,

ecurtin@redhat.com wrote on Fri, 9 Feb 2024 16:49:22 +0000:

> On Fri, 9 Feb 2024 at 16:43, <srinivas.kandagatla@linaro.org> wrote:
> >
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > Creating sysfs files for all Cells caused a boot failure for linux-6.8-=
rc1 on
> > Apple M1, which (in downstream dts files) has multiple nvmem cells that=
 use the
> > same byte address. This causes the device probe to fail with
> >
> > [    0.605336] sysfs: cannot create duplicate filename '/devices/platfo=
rm/soc@200000000/2922bc000.efuse/apple_efuses_nvmem0/cells/efuse@a10'
> > [    0.605347] CPU: 7 PID: 1 Comm: swapper/0 Tainted: G S              =
   6.8.0-rc1-arnd-5+ #133
> > [    0.605355] Hardware name: Apple Mac Studio (M1 Ultra, 2022) (DT)
> > [    0.605362] Call trace:
> > [    0.605365]  show_stack+0x18/0x2c
> > [    0.605374]  dump_stack_lvl+0x60/0x80
> > [    0.605383]  dump_stack+0x18/0x24
> > [    0.605388]  sysfs_warn_dup+0x64/0x80
> > [    0.605395]  sysfs_add_bin_file_mode_ns+0xb0/0xd4
> > [    0.605402]  internal_create_group+0x268/0x404
> > [    0.605409]  sysfs_create_groups+0x38/0x94
> > [    0.605415]  devm_device_add_groups+0x50/0x94
> > [    0.605572]  nvmem_populate_sysfs_cells+0x180/0x1b0
> > [    0.605682]  nvmem_register+0x38c/0x470
> > [    0.605789]  devm_nvmem_register+0x1c/0x6c
> > [    0.605895]  apple_efuses_probe+0xe4/0x120
> > [    0.606000]  platform_probe+0xa8/0xd0
> >
> > As far as I can tell, this is a problem for any device with multiple ce=
lls on
> > different bits of the same address. Avoid the issue by changing the fil=
e name
> > to include the first bit number.
> >
> > Fixes: 0331c611949f ("nvmem: core: Expose cells through sysfs")
> > Link: https://github.com/AsahiLinux/linux/blob/bd0a1a7d4/arch/arm64/boo=
t/dts/apple/t600x-dieX.dtsi#L156
> > Cc: regressions@lists.linux.dev
> > Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> > Cc: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> > Cc: Chen-Yu Tsai <wenst@chromium.org>
> > Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: asahi@lists.linux.dev
> > Cc: Sven Peter <sven@svenpeter.dev>
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org> =20
>=20

My R-by must have been lost, here it is again:

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l

