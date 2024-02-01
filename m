Return-Path: <linux-kernel+bounces-47937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4C98454D5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF08A28805A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE6E15B971;
	Thu,  1 Feb 2024 10:06:15 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E5015B11F
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 10:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706781975; cv=none; b=a5dT28bn2WdhDyp5qnQP7pG6DDjI4zEKObKzJ4G1p9fH8Db73EU4Z7q6XoFpbqNT0wTeIMyv02EFYY66ia5yc+ZEGGfCliERFA+vnO2iy7iO+JMD4kes53Q0DkX2E3h+fEX2Cu9vyOD9kbPqFqADAS/B+pPpBtY9Xw1goMLquzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706781975; c=relaxed/simple;
	bh=uzUShjiFX/7f0dsrKJDkxwU7eQEa2Tnovp7BWZ43Vwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KV220HDnzt9me498zS3siFh9hzr0KB3veRMg70Odn54H5IsZU+lEL1PcNnlfQ5D6YLpdMNs7BGp2Pm1K6JY63Q9wG9gQ9gGgr3N2ESg+QKDQyu5jXR7jXhPWHzeVbolRnOpJJ+cPBsXCZOXvAnea+a1w8z06whnhJ7v6+q7bav0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rVTxH-0008GF-CA; Thu, 01 Feb 2024 11:05:59 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rVTxG-003pfd-HH; Thu, 01 Feb 2024 11:05:58 +0100
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 1FDF6282BF9;
	Thu,  1 Feb 2024 10:05:58 +0000 (UTC)
Date: Thu, 1 Feb 2024 11:05:57 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: carlos.song@nxp.com
Cc: broonie@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, linux-imx@nxp.com, benjamin@bigler.one, stefanmoring@gmail.com, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v3] spi: imx: fix the burst length at DMA mode and CPU
 mode
Message-ID: <20240201-resupply-doorframe-feb41940155f-mkl@pengutronix.de>
References: <20240201100115.503296-1-carlos.song@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240201100115.503296-1-carlos.song@nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On 01.02.2024 18:01:15, carlos.song@nxp.com wrote:
> From: Carlos Song <carlos.song@nxp.com>
>=20
> For DMA mode, the bus width of the DMA is equal to the size of data
> word, so burst length should be configured as bits per word.
>=20
> For CPU mode, because of the spi transfer len is in byte, so burst
> length should be configured as bits per byte * spi_imx->count.
>=20
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> Reviewed-by: Clark Wang <xiaoning.wang@nxp.com>
> Fixes: e9b220aeacf1 ("spi: spi-imx: correctly configure burst length when=
 using dma")
> Fixes: 5f66db08cbd3 ("spi: imx: Take in account bits per word instead of =
assuming 8-bits")
> ---
> Changes for V3:
> - include <linux/bits.h>=20
> ---
>  drivers/spi/spi-imx.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 546cdce525fc..2a1ae7b00760 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -21,7 +21,7 @@
>  #include <linux/types.h>
>  #include <linux/of.h>
>  #include <linux/property.h>
> -
> +#include <linux/bits.h>

nitpick:
Please keep the includes sorted alphabetically.

>  #include <linux/dma/imx-dma.h>

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

