Return-Path: <linux-kernel+bounces-38422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7688783BF73
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA3FF1C23D85
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7104958AAE;
	Thu, 25 Jan 2024 10:43:56 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6DD58114
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 10:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706179436; cv=none; b=McwaySR7R5Xf+SS43Rcqi7uMccOmLRG1ID5iahwVj00sB0DjFPJxAgvsEo74NxeuLmw5k1iyNkGbLzzdaLFRIO2cgtBzB/NZLKhgSQwBs3QtS1Zg4am4U/PXFkyJb2Or4Q6fT3Ca9xNfWYJcwPKh2SbodagltkWpwWlYMu2EUpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706179436; c=relaxed/simple;
	bh=Pq2HycWL5UZIeTfQdGCMuXNRVUInCqTunQ8KIofIoyU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XpJYDNXgoPsStjU6r+hPLcumctNkPlQWgDwpy5V6pS7JlArq++sspZhTVm77fQDBx6+wBBnWmD2nxojaXdt+CRRMyqLOzJEhrmiKd02RrlAvy2AU6l3BvSVusIPwPu9AOd1cgJuZ73ekKoCzJS1Q+vWaEmUzJ4dyHdmZur0b4qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rSxD3-0006Mj-Pz; Thu, 25 Jan 2024 11:43:49 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rSxCz-002GMP-RI; Thu, 25 Jan 2024 11:43:45 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rSxCz-0005of-2V;
	Thu, 25 Jan 2024 11:43:45 +0100
Message-ID: <bf30a97b4c39e5c606583783058ea12520c1146b.camel@pengutronix.de>
Subject: Re: [PATCH v2 2/4] reset: sophgo: add SG2042 reset generator driver
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Chen Wang <unicornxw@gmail.com>, aou@eecs.berkeley.edu,
 chao.wei@sophgo.com,  conor@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 palmer@dabbelt.com,  paul.walmsley@sifive.com, robh+dt@kernel.org,
 devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org,  haijiao.liu@sophgo.com,
 xiaoguang.xing@sophgo.com, guoren@kernel.org,  jszhang@kernel.org,
 inochiama@outlook.com
Cc: Chen Wang <unicorn_wang@outlook.com>
Date: Thu, 25 Jan 2024 11:43:45 +0100
In-Reply-To: <34650036ea5f1c500da54c67c3a67b91c4419399.1706161530.git.unicorn_wang@outlook.com>
References: <cover.1706161530.git.unicorn_wang@outlook.com>
	 <34650036ea5f1c500da54c67c3a67b91c4419399.1706161530.git.unicorn_wang@outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Do, 2024-01-25 at 14:11 +0800, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
>=20
> Reuse reset-simple driver for the Sophgo SG2042 reset generator.

Subject prefix should be "reset: simple: "

> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> ---
>  drivers/reset/Kconfig        |  1 +
>  drivers/reset/reset-simple.c |  2 ++
>  drivers/reset/sophgo/Kconfig | 10 ++++++++++
>  3 files changed, 13 insertions(+)
>  create mode 100644 drivers/reset/sophgo/Kconfig
>=20
[...]
> diff --git a/drivers/reset/sophgo/Kconfig b/drivers/reset/sophgo/Kconfig
> new file mode 100644
> index 000000000000..9ad96e49e1dd
> --- /dev/null
> +++ b/drivers/reset/sophgo/Kconfig
> @@ -0,0 +1,10 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +config RESET_SOPHGO_SG2042
> +	bool "Sophgo SG2042 Reset Driver"
> +	depends on ARCH_SOPHGO || COMPILE_TEST
> +	select RESET_SIMPLE
> +	default ARCH_SOPHGO
> +	help
> +	  This enables the reset controller driver for the Sophgo SG2042 SoC.
> +

Drop the Kconfig, just add a default y if ARCH_SOPHGO to RESET_SIMPLE.

regards
Philipp

