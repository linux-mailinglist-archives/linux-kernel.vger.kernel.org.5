Return-Path: <linux-kernel+bounces-80541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D04F866948
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 05:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD021282A67
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191D91B270;
	Mon, 26 Feb 2024 04:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="KMZ2d/Wu"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F081B5AD;
	Mon, 26 Feb 2024 04:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708920799; cv=none; b=U2KiD2QlLDHF77RGVB1/fbA9RN9CQ7i833BlkmPUpUaKx6xmyy3C7USgLzjOSPMvmbGQCNwMvFDyNNQ7bLD5n1anpyib8muxsEJq3wxmdPk7zF1lOeNFn8SVh7I3pOUu2tl4WLurxf0Hx4WYuue0oB1G2m+MQrdT3wW2dtCEK7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708920799; c=relaxed/simple;
	bh=/q24CJLITfPyErU1UK/fAAmBnBCJ3GQy7PcDHM76kEw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KqEbuhSBYU+xGIusMxybpmy2aL4uGSRU9hwaar1VF+mfN3zUEQ+QOEAdnfpAb8a3RgtwWA1Agbil8Bq33Dljrvh23CokLkLDKfYrHc3jdASD7FUjNhBwsBMUmXFtecRdo7+8tzu2J/M1rwxIErhvD4B9V4UhBToP010t+z8yEKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=KMZ2d/Wu; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (ppp118-210-168-240.adl-adc-lon-bras34.tpg.internode.on.net [118.210.168.240])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 151DB2014E;
	Mon, 26 Feb 2024 12:13:14 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1708920795;
	bh=/q24CJLITfPyErU1UK/fAAmBnBCJ3GQy7PcDHM76kEw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KMZ2d/WueqRPEt0x3pmeKLAQzK5soiMd5fgmGcOBAm1UYlsonQs/Uu/6NzlqB/WK/
	 dwrA/YA8nsmxhwjMXYtC49fyF8wH09ORmR3cQJYWLThxNX4qC8jnvaA3oSZ3eGy1E4
	 w2Nmx0FX/nhtpiQQs7GZeWUc5n9S5mA6skQxrAOmC8ZhcU25SnagEi9Qlp4YPMS8AE
	 ekgbjuUYU2UXyC0pgRXXfWv6Ie+0VDrplCN9nvY/uMHt7NsH/ScqBfkNtM+wLEXQmh
	 0TX/8e6jpqq4rogsCTZK16wgSCMOVRPo45toJq2I10pWK8OduJZ/XJ/bkvFYq2xyuj
	 heu6tTyQyTYcA==
Message-ID: <00b5f735bd9c151812445d40348d70f4b4bd474d.camel@codeconstruct.com.au>
Subject: Re: [PATCH v1 04/14] serial: 8250_aspeed_vuart: Switch to use
 uart_read_port_properties()
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman
	 <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-rpi-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linux-tegra@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,  Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Al
 Cooper <alcooperx@gmail.com>,  Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Paul Cercueil <paul@crapouillou.net>, 
 Vladimir Zapolskiy <vz@mleia.com>, Thierry Reding
 <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,  Masami Hiramatsu
 <mhiramat@kernel.org>, Andi Shyti <andi.shyti@linux.intel.com>
Date: Mon, 26 Feb 2024 14:43:13 +1030
In-Reply-To: <20240221183442.4124354-5-andriy.shevchenko@linux.intel.com>
References: <20240221183442.4124354-1-andriy.shevchenko@linux.intel.com>
	 <20240221183442.4124354-5-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-02-21 at 20:31 +0200, Andy Shevchenko wrote:
> Since we have now a common helper to read port properties
> use it instead of sparse home grown solution.
>=20
> Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

