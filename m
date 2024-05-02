Return-Path: <linux-kernel+bounces-166703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9790C8B9E5B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6782B25253
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A8515E20D;
	Thu,  2 May 2024 16:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="0qShFYzd"
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D391586D5;
	Thu,  2 May 2024 16:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714666699; cv=none; b=ptzukVU7CSl/IzMdfV4Qo8ADAxCbTnC4uyeUKsyiaqwFBXTzZNPlGix0S3+e5frR7ne3SArxWSGSAHnuIc1O/NMonXf/uH0xXsv0An0HMeLBNLCGF7Yk9wfwZzQimsYNrdBL45dP7qrq737yEBM5xcKztASZLeQpd/FAtnl2SrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714666699; c=relaxed/simple;
	bh=PXiRo4w2E0/4qzbSWCaMbbfTifqyV+g9KZhxk0A5rDY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mdkljCIARI6QLcfRRDx/wTt9WhZRsz14PRrVeahNbKRzNGCVYUht7LqTDcWgoD3Hk4+0sFRL12XkM9hNYV/RsszNB/F2M1r2TO6F6TqzJhMgyFLjTvfY3n8yeEu9PUEnvWotmiQjgAPs/kMSE9QqshSvrYJunOgB/2k4lqYxSh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=0qShFYzd; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1714666691; x=1715271491; i=parker@finest.io;
	bh=LKoyu6h7KDiFRhiij4H8trRflZZKdIgkV1s5K2caVw4=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=0qShFYzdeOFnC7PRxHcpNziw9g1XxHTEvbdm6NJM5ZRZaaR2rR9SQyzO8caCq7CV
	 QyLjYvrB/JWwl+QJkTCtWaGT1VbcYamyO2lHpIWdcz57nt6NEmZhsAtJzgcl7MFA1
	 bak5RcA9ivrrwbykj/uMhxNjOpjDceHMw0wN2qfrHZouOwK0FHillWCiVZpROjWON
	 CEtW/lmENGXxAbKK2hBzfczCvnYwcnpengSCDFqIUN+UbYNnzGvTlNNGTvuhmMd3Y
	 c0/dv0xjrg5u446vL02T5vDOIDJgHGkjfWywRSwe2AZqJsvVe41pBGm2973eNa+fy
	 /pfAKs70CFd0jVpWFg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from SWDEV2.connecttech.local ([98.159.241.229]) by
 mrelay.perfora.net (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id
 1N7AIq-1sjKTH2Eii-017S1k; Thu, 02 May 2024 18:18:11 +0200
Date: Thu, 2 May 2024 12:18:09 -0400
From: Parker Newman <parker@finest.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
Cc: Ilpo =?UTF-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Parker
 Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v2 0/4] serial: exar: fix kbuild warnings and code style
Message-ID: <20240502121809.30491a67@SWDEV2.connecttech.local>
In-Reply-To: <cover.1713533298.git.pnewman@connecttech.com>
References: <cover.1713533298.git.pnewman@connecttech.com>
Organization: Connect Tech Inc.
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:McQlekSsgghGBLIcmt0S/h4x/zjxzWYi8l3YZYVrmqTi0lS/ikz
 73RvGTSS59v1dbZQTjNvArFEmt1hl85dLfOVFANO0uJpvjbK6ZfQW0S1axCrEtDjdaVpyvV
 +FKcfhbQoJWc3p/G3vTdv/kmYFIabNEHWsulRFYy470zGj1ame8vGJpw6ctVAU83mMHB+lr
 qlwJG7tvdBkkVN5NtewjQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WpY9wamyheo=;EI1vgfvixcJRoW+SJ+tLi4qspYU
 9wZoI9rxxAskBXqHg7xHEUEjHbIluDv3NAX9SgiJzUpLRt30R+02DB40gdanCo2eiSblt9uDi
 KrY0WWE9GylBA30Gt5+IOUljerf143Uv61QHpQehSwUFW84OO/Y09imLa7nu+kdJNBl00fEJ2
 GCxabS8IPSt9qlu+T6Tp00g4M325aIClz6GQsfMHkV4wNZzjuUIblF5CGKPqtXuVOeZApbRDf
 zGPURMV0oI8dAcSb0Lo8gOS8cV9fPobSmbGIDCkymNQhdO7CgL490zBje/UrxZSNqLCEkbVAW
 ws6j7YhqNdmEpOhksCFpoGUm4N0V59PSy9AMq3k6Y5Rtphapx3obC9+ZPtyjmkz3iJJLTJVzv
 KjCfY7DnrujAVSt2qp2Nd8lrB206bQZuuGe6neIEDE1pX8eu2rVbOJnJmu+gX2yVXjttPGyNe
 7EJnXWwcBehOuFXxX8cmnZkJJxDgkHu5MRLjVmBq2HDrYSsxusKjMBNNJ1xCf17in9IdQSo0S
 wF94KBx1n8FwhDBV2xXjl1atdoTNuH2aB9xCH0M8EEblED0wFiR47S+meBRZ+ZCiG6keTuQgR
 qBjziAxL0zPAvmG2mGQ9HzVOHRc9t/tAKJenpKI/5bs793xkjOKJi+ujlNStzzE/pQREtUHPL
 gf9hWhG3R/rP1efE3v9jGThVjTMLxHJqpD/wIbZbtZBiw6OEViUo13Shy9Q+9A/GqJwzzX5Dw
 GZDhN7qPrc5vsJbQCywc9KLJCBT+CjB33QegqPtDPuYdtb7l6Zwz90=

On Fri, 19 Apr 2024 10:17:00 -0400
Parker Newman <parker@finest.io> wrote:

> From: Parker Newman <pnewman@connecttech.com>
>
> This is a series of small patches fixing kbuilds error and code style
> issues based on feedback during review of main patches.
>
> Original patches thread:
> Link: https://lore.kernel.org/linux-serial/cover.1713382717.git.pnewman@=
connecttech.com/
>

These patches should not be required anymore. Andy Shevchenko has
submitted a more comprehensive clean up patch set that makes this
set unneeded.

Link: https://lore.kernel.org/linux-serial/20240502144626.2716994-1-andriy=
shevchenko@linux.intel.com/

Thanks,
Parker

> Parker Newman (4):
>   serial: exar: add missing kernel doc function parameters
>   serial: exar: use return dev_err_probe instead of returning error code
>   serial: exar: return bool from exar_ee_read_bit()
>   serial: exar: remove ternaries from
>     cti_get_port_type_xr17c15x_xr17v25x()
>
>  drivers/tty/serial/8250/8250_exar.c | 36 ++++++++++++++---------------
>  1 file changed, 18 insertions(+), 18 deletions(-)
>
>
> base-commit: c6795fbffc4547b40933ec368200bd4926a41b44
> --
> 2.43.2
>


