Return-Path: <linux-kernel+bounces-56005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6BA84C4DB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 07:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36AF9B286A6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 06:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6901CF87;
	Wed,  7 Feb 2024 06:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qzUPNkOW"
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCCD1CD19
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 06:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707286315; cv=none; b=mkjAZhQzJI6ph9sf1SehRL8m+HM8Jz4lB0t7wInlFVbnKF8/wBOitstWY3OqGvW4CFISkrz7FiLgHJq5vP9tYloLih4tzUO/mRiOT1StMj3inmqbGNkCzXbM0p2LTtj/lf2JRZNe6XZoMoBmzD+ttJl1r3tl+PSwwqICKv4zwlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707286315; c=relaxed/simple;
	bh=MXcOIfQoNRO5ZjYXIjrOev1qoj5neivD/X754LViIHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AV0wE5py7LUMPphUCrbAmXUcbI0HPicIl9rFSi3JryaLfT6TIxzxSdvuKkruuU+2FWbT7Ea2rVSlf3CBD/EyHy7kfX8RUAaRoHBGrDkPgY1OFKh2BbEkWSs3JOgJ/nP+DCdL4XEulFh26EcH6IyME4G6cBjFQEY7GRJxHI41OAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qzUPNkOW; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-46d2d20c923so46487137.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 22:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707286312; x=1707891112; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MXcOIfQoNRO5ZjYXIjrOev1qoj5neivD/X754LViIHw=;
        b=qzUPNkOWmgGL1OZbA8XJQr8kBaHDPd1ezjOLQD2WHCPwCDPLuj+UdAKAS937JTNmZR
         l5ottFFaprHTxxoXoOa2HPzhpV4tx7Zf1cbz5MypYnugDLpnjPLTOtzvf8Ol9vCqxjgM
         YrgCCJEiK3ijp3q6UL00jlqvOWEsFx3DiW1QtyMSmRiO8s0ImX6gxGL/jTqxvusl6N5M
         BSd2SQUZ4xUbZf/vN8iwIAXbam/KWzaYM3iIcISgCwgnQKcl8xvOMAoeRhkBoHONMUoq
         Qmgbwos+iJTcGqAVcv1695NAQYpCFVa/85zvrYxyEFXG6HIdYbZS//LtGw5iP3Yvd/1w
         pfMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707286312; x=1707891112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MXcOIfQoNRO5ZjYXIjrOev1qoj5neivD/X754LViIHw=;
        b=Xq7/RcFhlKD7oRNgQ+mKpqNp8JSoyHsrTLih7KRikN7umIfqtjfH8x63gG/rVmRJTR
         ha8pCOativkXuwD3tzmt3twqw0wCsvp5aGcYFp4eT+wev5oORiSh1rTUh98fHVYqzkzK
         vv75xh84t8AuUI/DZKJSjHSgRQsJhBiF3LJYt8FrBtXpcVW2/yxTeIksuY7d4sO4WtuA
         v6Fmc6CoKl3FY9kyBg56zNt6TN1bC2dY4CZcvI+lrjaShM+b6CVQNF887ocA1v7R6vqO
         GLERZPOwch3Ma/0kg5Y/jXu7XKSBG/pSVA0KAxNlTQk1T998G34V5WiWS+0E5c1NhRjg
         JA6Q==
X-Gm-Message-State: AOJu0Yz+l6TSZ6SSeICm0n6At2Y5Ldn/ehLj63PmptEWhlt2OOh3AFwE
	XrKTl90anH3i0jBGFh/oWMXg/OIXUAIqiiztW6faxUdkQa0Q9tvMNhXhf5IAZdsbHU6nmAdzlL6
	Kdz5CpI4ASeVeakqMkfdojKkkhfH1VCch3evwtA==
X-Google-Smtp-Source: AGHT+IEOnPi0xHT1TQovo4uWsauFx9V82/RzzdzP1M9V7J3e1++Dvktqp/6DKtdbBO8XPPLtj6qRcdQEMQWfIzDQL3g=
X-Received: by 2002:a05:6102:236f:b0:468:6b0:ef95 with SMTP id
 o15-20020a056102236f00b0046806b0ef95mr1635936vsa.24.1707286312499; Tue, 06
 Feb 2024 22:11:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131174347.510961-1-jens.wiklander@linaro.org>
 <20240131174347.510961-2-jens.wiklander@linaro.org> <CAPDyKFqNhGWKm=+7niNsjXOjEJE3U=o7dRNG=JqpptUSo9G-ug@mail.gmail.com>
 <CAC_iWj+k_Vsz4ot=9pv-Gv7r11=vCunH5TSyOMTK4z-NZ2TeTA@mail.gmail.com>
In-Reply-To: <CAC_iWj+k_Vsz4ot=9pv-Gv7r11=vCunH5TSyOMTK4z-NZ2TeTA@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 7 Feb 2024 11:41:41 +0530
Message-ID: <CAFA6WYNQoRg0PWgr1oCzrkMens7e0=m_zkBSXKvp8JVjmn2OZQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] rpmb: add Replay Protected Memory Block (RPMB) subsystem
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jens Wiklander <jens.wiklander@linaro.org>, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org, op-tee@lists.trustedfirmware.org, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, 
	Jerome Forissier <jerome.forissier@linaro.org>, Bart Van Assche <bvanassche@acm.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomas Winkler <tomas.winkler@intel.com>, 
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Ilias, Ulf,

On Tue, 6 Feb 2024 at 20:41, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Ulf,
>
> On Tue, 6 Feb 2024 at 14:34, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Wed, 31 Jan 2024 at 18:44, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> > >
> > > A number of storage technologies support a specialised hardware
> > > partition designed to be resistant to replay attacks. The underlying
> > > HW protocols differ but the operations are common. The RPMB partition
> > > cannot be accessed via standard block layer, but by a set of specific
> > > RPMB commands: WRITE, READ, GET_WRITE_COUNTER, and PROGRAM_KEY. Such a
> > > partition provides authenticated and replay protected access, hence
> > > suitable as a secure storage.
> > >
> > > The initial aim of this patch is to provide a simple RPMB Driver which
> > > can be accessed by the optee driver to facilitate early RPMB access to
> > > OP-TEE OS (secure OS) during the boot time.
> >
> > How early do we expect OP-TEE to need RPMB access?
>
> It depends on the requested services. I am currently aware of 2
> services that depend on the RPMB
> - FirmwareTPM
> - UEFI variables stored there via optee.
>
> For the FirmwareTPM it depends on when you want to use it. This
> typically happens when the initramfs is loaded or systemd requests
> access to the TPM. I guess this is late enough to not cause problems?

Actually RPMB access is done as early as during fTPM probe, probably
to cache NVRAM from RPMB during fTPM init. Also, there is a kernel
user being IMA which would require fTPM access too. So we really need
to manage dependencies here.

>
> For the latter, we won't need the supplicant until a write is
> requested. This will only happen once the userspace is up and running.
> The UEFI driver that sits behind OP-TEE has an in-memory cache of the
> variables, so all the reads (the kernel invokes get_next_variable
> during boot) are working without it.
>
> Thanks
> /Ilias
> >
> > The way things work for mmc today, is that the eMMC card gets
> > discovered/probed via a workqueue. The work is punted by the mmc host
> > driver (typically a module-platform-driver), when it has probed
> > successfully.

It would be nice if RPMB is available as early as possible but for the
time being we can try to see if probe deferral suffices for all
use-cases.

> >
> > The point is, it looks like we need some kind of probe deferral
> > mechanism too. Whether we want the OP-TEE driver to manage this itself
> > or whether we should let rpmb_dev_find_device() deal with it, I don't
> > know.

I wouldn't like to see the OP-TEE driver probe being deferred due to
this since there are other kernel drivers like OP-TEE RNG (should be
available as early as we can) etc. which don't have any dependency on
RPMB.

How about for the time being we defer fTPM probe until RPMB is available?

-Sumit

