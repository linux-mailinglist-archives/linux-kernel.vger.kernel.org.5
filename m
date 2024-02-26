Return-Path: <linux-kernel+bounces-80540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6FC866944
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 05:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1948A1C243AE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463211B279;
	Mon, 26 Feb 2024 04:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="mrK4AxRc"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59C717BC5;
	Mon, 26 Feb 2024 04:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708920756; cv=none; b=D1r3MGu+OnPipM47h/ivV0CGN0oY3qAEPAixZAJA9RsowZNLwI/IbSlvWO0Kc9erETtIaYUSwWr6C4NNyeyz6ZulBo93vsBMEEKZSVPLV7LQlp0qdOcCNleP/X3TXdo7rXih+NLlcL0mJhQ3rRN7QVG956bhum5t7wdpqCVMhAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708920756; c=relaxed/simple;
	bh=Pe94gA4uf1vHFYSF+mnEFT0ytZjmWjUodzwCgag62eU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S+i0L0I9hMvsN1bu1CFPxvS5LcrTF2t/7GjByAvxVDAGZJRTgBD5hsVCNzw6x73e13d7uMHjeFvjAFdYcX/Kc1RZChEYlOpaDKhu+y5yGBysRt32D7umRsNC3X0Lvl/9rrNjcdYgNWRe0wGbjL3HrzxLKqTYI+R9QlRc3yKifYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=mrK4AxRc; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (ppp118-210-168-240.adl-adc-lon-bras34.tpg.internode.on.net [118.210.168.240])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 85F5A2014E;
	Mon, 26 Feb 2024 12:12:28 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1708920752;
	bh=XXRWq9LzaWJldDlLUORe5CRUYm2s2hhDXWkS7OTa4Lg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mrK4AxRcBQAiIKCOPTCJmIVgne/8nIuXIhpXuCDvYKC2xvr/0qonrkIXrDVMHnkfV
	 SJpQ4glDbG8r8ZjSpRe+DY6Ey7JhHXhfcfOaTTqNev7gE4fsswYgJPcRwqQuMxQUhh
	 BRsglrzdRY+rIyDxyE3sHLuSt/KMh5558ntUPdudvw3DoZIN56Eblru48iBTPsNITc
	 /m0B0b/q1uA3uO0RcplIh/4kxIWbI6pxJ4/lCg3g7iwcqHbLU8D7m5H3O8ChcCltuz
	 o55K+LzKWT+TD7MkYpfONNShG2JzgYB31QHJBUSVedDncb82YdRV5cKQoSRMIq7zBB
	 //zPm9ZLM1GHg==
Message-ID: <ab237d0e08b6919d29f25d89ec34d149341f4c57.camel@codeconstruct.com.au>
Subject: Re: [PATCH v1 10/14] serial: 8250_of: Switch to use
 uart_read_port_properties()
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner
 <tglx@linutronix.de>, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-rpi-kernel@lists.infradead.org, 
 linux-mips@vger.kernel.org, linux-tegra@vger.kernel.org, Jiri Slaby
 <jirislaby@kernel.org>, Joel Stanley <joel@jms.id.au>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, Scott Branden
 <sbranden@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Al Cooper <alcooperx@gmail.com>, 
 Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, Paul
 Cercueil <paul@crapouillou.net>,  Vladimir Zapolskiy <vz@mleia.com>,
 Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter
 <jonathanh@nvidia.com>, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Andi Shyti
 <andi.shyti@linux.intel.com>
Date: Mon, 26 Feb 2024 14:42:27 +1030
In-Reply-To: <Zdd6lnXwvpPPUhRR@smile.fi.intel.com>
References: <20240221183442.4124354-1-andriy.shevchenko@linux.intel.com>
	 <20240221183442.4124354-11-andriy.shevchenko@linux.intel.com>
	 <0a828f2c50de712940fb9a881702ac1678a35b7c.camel@codeconstruct.com.au>
	 <ZddKzHplwOX7naLv@smile.fi.intel.com> <Zdd5m2xIPlGI0_Qv@smile.fi.intel.com>
	 <Zdd6lnXwvpPPUhRR@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-02-22 at 18:47 +0200, Andy Shevchenko wrote:
> On Thu, Feb 22, 2024 at 06:43:08PM +0200, Andy Shevchenko wrote:
> > On Thu, Feb 22, 2024 at 03:23:24PM +0200, Andy Shevchenko wrote:
> > > On Thu, Feb 22, 2024 at 11:07:05AM +1030, Andrew Jeffery wrote:
> > > > On Wed, 2024-02-21 at 20:31 +0200, Andy Shevchenko wrote:
> > > > > Since we have now a common helper to read port properties
> > > > > use it instead of sparse home grown solution.
> > > >=20
> > > > I did some brief testing of the series for the Aspeed machines unde=
r
> > > > qemu, building them on top of v6.8-rc5:
> > > >=20
> > > > export ARCH=3Darm
> > > > export CROSS_COMPILE=3Darm-linux-gnueabihf-
> > > > make aspeed_g5_defconfig
> > > > make -j$(nproc)
> > > > qemu-system-arm -M rainier-bmc -nographic -no-reboot -kernel arch/a=
rm/boot/zImage -dtb arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dtb -in=
itrd ...
> > > >=20
> > > > I got an oops during boot, which bisected to this change:
> > >=20
> > > Thank you for prompt testing! I will look at it.
> >=20
> > I found the issue, will be fixed in next version.
>=20
> Whoever is going to test this series, the
>=20
> -		port->iotype =3D use_defaults ? UPIO_MEM : port->iotype;
> +		port->iotype =3D UPIO_MEM;
>=20
> should be applied to uart_read_port_properties() implementation.
>=20

Thanks, with that fix applied it works fine for me also.

Andrew

