Return-Path: <linux-kernel+bounces-102629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F1E87B511
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 00:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82B9D1F237F2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FD45D460;
	Wed, 13 Mar 2024 23:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="imUlJR18"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8683E41C6A;
	Wed, 13 Mar 2024 23:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710371145; cv=none; b=NMmnkEY7qnRdRsprUvN1J/U6RmsiNH3RpuS+D2Gg/pg2R+0B/NXM/4tkR49f9ZbuM/vDhXn/V6cfkO2u6lnE01O1vN6Eszh5FVTrjZeCjgWMT9DZ8iFMb7I/I5gx3iYFjWGc5AII1EMtwL160P3hPEeRSccnLMmFqJszUdc5QFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710371145; c=relaxed/simple;
	bh=6MmwAbO89gTnQjplF1HXE51FS+gGIFHesxbJSx3EL9Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=khwUogUP0mC0Mxh/2geAMgxnb7nyX9T7u74UatKfJv3Gnd+aouN+MAr/av6RVSIGGf9LCfzm1sdFUQJMTCf9+Z/P1YwNOVmhZgXEHhpM420rW3yYjWaav2SGEH0NFytes0wEHBPDGrDeXX1uQHB9YZaYFdHGkxrwY14bBMJOheo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=imUlJR18; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1710371140;
	bh=gp+TnZi1grjtsA+tY43oV2ZNvLXf735UomqNNCGEsHY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=imUlJR18pGUI7/j0FzyNCKnwUcxTkbKRk4oT3d98U6C0YIHQ8LLHKCGNS2yisGQ6G
	 giZE7D+niajnn/tK2YkOIeU0xSDevUhVcYf4fKXs9WA9wYo/rFJ/AAjFFUs0P/AK6f
	 cGW4jhSdNJ25F7KApb2F6w5G8Qu9aAzy6tn8uxjqm3nxTUoysHPiq0yjRNLz/s5leo
	 KK3tFHTrrj9iGDE58urYNTfS5FcRK1mCl4cCM34ZuuS0tuQvfb9dDfpk5H14z2pZ3+
	 DOaRpUWDD4Ug1CF1qJ3JaHATAzTJkcCziyq1lnX0/VMWGorhMPtpFakQDJXZC+xMn2
	 CA8mjUFkVOSZw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tw5hd5tS2z4wcT;
	Thu, 14 Mar 2024 10:05:37 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Herve Codina <herve.codina@bootlin.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Herve Codina <herve.codina@bootlin.com>, Yury
 Norov <yury.norov@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Andrew Lunn <andrew@lunn.ch>, Mark Brown
 <broonie@kernel.org>, Ratheesh Kannoth <rkannoth@marvell.com>, Christophe
 Leroy <christophe.leroy@csgroup.eu>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v7 1/5] net: wan: Add support for QMC HDLC
In-Reply-To: <20240307113909.227375-2-herve.codina@bootlin.com>
References: <20240307113909.227375-1-herve.codina@bootlin.com>
 <20240307113909.227375-2-herve.codina@bootlin.com>
Date: Thu, 14 Mar 2024 10:05:37 +1100
Message-ID: <87ttl93f7i.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Herve,

Herve Codina <herve.codina@bootlin.com> writes:
> The QMC HDLC driver provides support for HDLC using the QMC (QUICC
> Multichannel Controller) to transfer the HDLC data.
..
>=20=20
> diff --git a/drivers/net/wan/fsl_qmc_hdlc.c b/drivers/net/wan/fsl_qmc_hdl=
c.c
> new file mode 100644
> index 000000000000..5fd7ed325f5b
> --- /dev/null
> +++ b/drivers/net/wan/fsl_qmc_hdlc.c
> @@ -0,0 +1,419 @@
..
> +static int qmc_hdlc_remove(struct platform_device *pdev)
> +{
> +	struct qmc_hdlc *qmc_hdlc =3D platform_get_drvdata(pdev);
> +
> +	unregister_hdlc_device(qmc_hdlc->netdev);
> +	free_netdev(qmc_hdlc->netdev);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id qmc_hdlc_id_table[] =3D {
> +	{ .compatible =3D "fsl,qmc-hdlc" },
> +	{} /* sentinel */
> +};
> +MODULE_DEVICE_TABLE(of, qmc_hdlc_driver);

This breaks when building as a module (eg. ppc32_allmodconfig):

  In file included from ../include/linux/device/driver.h:21,
                   from ../include/linux/device.h:32,
                   from ../include/linux/dma-mapping.h:8,
                   from ../drivers/net/wan/fsl_qmc_hdlc.c:13:
  ../drivers/net/wan/fsl_qmc_hdlc.c:405:25: error: =E2=80=98qmc_hdlc_driver=
=E2=80=99 undeclared here (not in a function); did you mean =E2=80=98qmc_hd=
lc_probe=E2=80=99?
    405 | MODULE_DEVICE_TABLE(of, qmc_hdlc_driver);
        |                         ^~~~~~~~~~~~~~~


IIUIC it should be pointing to the table, not the driver, so:

diff --git a/drivers/net/wan/fsl_qmc_hdlc.c b/drivers/net/wan/fsl_qmc_hdlc.c
index 5fd7ed325f5b..705c3681fb92 100644
--- a/drivers/net/wan/fsl_qmc_hdlc.c
+++ b/drivers/net/wan/fsl_qmc_hdlc.c
@@ -402,7 +402,7 @@ static const struct of_device_id qmc_hdlc_id_table[] =
=3D {
        { .compatible =3D "fsl,qmc-hdlc" },
        {} /* sentinel */
 };
-MODULE_DEVICE_TABLE(of, qmc_hdlc_driver);
+MODULE_DEVICE_TABLE(of, qmc_hdlc_id_table);

 static struct platform_driver qmc_hdlc_driver =3D {
        .driver =3D {


Which then builds correctly.

cheers

