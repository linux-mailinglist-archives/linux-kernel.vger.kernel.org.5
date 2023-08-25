Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1081F7880B3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 09:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241520AbjHYHMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 03:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243363AbjHYHMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 03:12:50 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0121B2;
        Fri, 25 Aug 2023 00:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1692947567; x=1724483567;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q2k+Pyt4QngwrczcVgdUO+Ku35iTRGG8ZTnt0DwH5gs=;
  b=HxMg47VzKzgLue4soPqNn7q2kQsOYFGnldo7DIspFPNgKjaErMFaxMwZ
   qLaknvfW4HRfvultPljAsbGT+6TmHCQF7Hj8uiuQ4EGzDqDGRcebNKANi
   sSej+fyFiNpQQYfhnFyGTBMgCnhaYrI4/OeNbcSG2xvS83veIvIIbxCWI
   GMya3j/XA4MDElt619ujrVQ8iitE64JPZgRzfFMIEGV/uM0y3LzkIXuRq
   XgzgitLkJOlF+8mK3Y1CF6Bs212AgDAUmPwKQSeaIjTCgYcPSXuOGQAXw
   9OeZ+1zKO/96xWXJ/6C7n4VEQ20WeMntoOGzPp/0Rj6uhZ+3hZy9HJ5HD
   g==;
X-IronPort-AV: E=Sophos;i="6.02,195,1688421600"; 
   d="scan'208";a="32622174"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 25 Aug 2023 09:12:44 +0200
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id A0755280075;
        Fri, 25 Aug 2023 09:12:44 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: Re: [PATCH v2 3/6] hwrng: imx-rngc - use polling to detect end of self test
Date:   Fri, 25 Aug 2023 09:12:44 +0200
Message-ID: <8370215.EvYhyI6sBW@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20230824192059.1569591-4-martin@kaiser.cx>
References: <20230824192059.1569591-1-martin@kaiser.cx> <20230824192059.1569591-4-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

thanks for splitting the series into single patches.

Am Donnerstag, 24. August 2023, 21:20:56 CEST schrieb Martin Kaiser:
> Use polling to detect the end of the rngc self test. This is much simpler
> than using an interrupt and a completion.

I'm still not convinced that using polling is simpler. By using=20
readl_poll_timeout() you will also get an interrupt, the timer one. Why=20
exactly is using polling much (!) simpler?

> The selftest should take approx. 450us. Keep the overhead to a minimum
> by polling every 500us. (We've already lowered the timeout to 1.5ms.)

I suppose these times only hold true for a specific peripheral clock=20
frequency. Is it guaranteed that this frequency is fixed?
=46or using IRQ it's simpler, there is no guessing: you return once the sel=
f=20
test finished. The timeout is identical anyway.

Best regards,
Alexander

> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
> v2:
> - use shorter timeout and polling interval
>=20
>  drivers/char/hw_random/imx-rngc.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/char/hw_random/imx-rngc.c
> b/drivers/char/hw_random/imx-rngc.c index 8ff3d46674fd..09523936d2af 1006=
44
> --- a/drivers/char/hw_random/imx-rngc.c
> +++ b/drivers/char/hw_random/imx-rngc.c
> @@ -17,6 +17,7 @@
>  #include <linux/hw_random.h>
>  #include <linux/completion.h>
>  #include <linux/io.h>
> +#include <linux/iopoll.h>
>  #include <linux/bitfield.h>
>=20
>  #define RNGC_VER_ID			0x0000
> @@ -101,22 +102,19 @@ static inline void imx_rngc_irq_unmask(struct imx_r=
ngc
> *rngc)
>=20
>  static int imx_rngc_self_test(struct imx_rngc *rngc)
>  {
> -	u32 cmd;
> +	u32 cmd, status;
>  	int ret;
>=20
> -	imx_rngc_irq_unmask(rngc);
> -
>  	/* run self test */
>  	cmd =3D readl(rngc->base + RNGC_COMMAND);
>  	writel(cmd | RNGC_CMD_SELF_TEST, rngc->base + RNGC_COMMAND);
>=20
> -	ret =3D wait_for_completion_timeout(&rngc->rng_op_done,
> -					 =20
usecs_to_jiffies(RNGC_SELFTEST_TIMEOUT));
> -	imx_rngc_irq_mask_clear(rngc);
> -	if (!ret)
> -		return -ETIMEDOUT;
> +	ret =3D readl_poll_timeout(rngc->base + RNGC_STATUS, status,
> +				 status & RNGC_STATUS_ST_DONE, 500,=20
RNGC_SELFTEST_TIMEOUT);
> +	if (ret < 0)
> +		return ret;
>=20
> -	return rngc->err_reg ? -EIO : 0;
> +	return readl(rngc->base + RNGC_ERROR) ? -EIO : 0;
>  }
>=20
>  static int imx_rngc_read(struct hwrng *rng, void *data, size_t max, bool
> wait)


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


