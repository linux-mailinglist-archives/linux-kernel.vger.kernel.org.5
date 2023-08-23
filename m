Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1BC3784FFF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 07:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbjHWFdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 01:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbjHWFdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 01:33:35 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0FBE54;
        Tue, 22 Aug 2023 22:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1692768812; x=1724304812;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yBYwYVHS5gWIc2cCB6gU+GXiV6MN/VGyE43zIRurjpM=;
  b=OBzo5EksCJlo5S8pi+P8sKLqidBc7qHgwXO0zS/o9MC3KQ6+eOJcyQX4
   jAZDcVaE+qcCO6iSiTBgCluwAswRge/Q1B867O10xZbKDyO5Y5ttY5Mqm
   /zDuTOhvFt+f7kcpv7StU12SzNkMLD2vHk6bf3H4+AFnAw6MNHcb1XoAJ
   NFbC+6jgzdYlqEAzcW2KToXKkUfxaffqQ8MzhZvgaiISAPi8kz0rSFhOe
   paTAX9rTsUCm15cThqP+lqQ0soOYrQYwih/3BeKR+ZLdbbq700r+M0YEY
   eMqItabO6FPn/f8Al37L0Vg8ITT0JRnYD8PD0v5YPhx//rIR0gsgim5zY
   A==;
X-IronPort-AV: E=Sophos;i="6.01,194,1684792800"; 
   d="scan'208";a="32575160"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 23 Aug 2023 07:33:30 +0200
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id A6917280075;
        Wed, 23 Aug 2023 07:33:30 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>,
        Martin Kaiser <martin@kaiser.cx>
Subject: Re: [PATCH 3/3] hwrng: imx-rngc - use polling to wait for end of seeding
Date:   Wed, 23 Aug 2023 07:33:30 +0200
Message-ID: <5662754.31r3eYUQgx@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20230822152553.190858-4-martin@kaiser.cx>
References: <20230822152553.190858-1-martin@kaiser.cx> <20230822152553.190858-4-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 22. August 2023, 17:25:53 CEST schrieb Martin Kaiser:
> Use polling to wait until the imx-rngc is properly seeded.

What is the benefit of burning CPU cycles while waiting for hardware?

> We do this only in the init function when the imx-rngc becomes active.
> Polling is ok at this time, there's nothing else we could do while
> we're waiting.
>=20
> We can now remove the code for the interrupt and the completion.

Please split the change to polling and IRQ removal into two patches.

> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  drivers/char/hw_random/imx-rngc.c | 81 ++++---------------------------
>  1 file changed, 9 insertions(+), 72 deletions(-)
>=20
> diff --git a/drivers/char/hw_random/imx-rngc.c
> b/drivers/char/hw_random/imx-rngc.c index d2df468fd460..7ab9aada72d0 1006=
44
> --- a/drivers/char/hw_random/imx-rngc.c
> +++ b/drivers/char/hw_random/imx-rngc.c
> @@ -63,12 +63,6 @@ struct imx_rngc {
>  	struct clk		*clk;
>  	void __iomem		*base;
>  	struct hwrng		rng;
> -	struct completion	rng_op_done;
> -	/*
> -	 * err_reg is written only by the irq handler and read only
> -	 * when interrupts are masked, we need no spinlock
> -	 */
> -	u32			err_reg;
>  };
>=20
>=20
> @@ -91,15 +85,6 @@ static inline void imx_rngc_irq_mask_clear(struct
> imx_rngc *rngc) writel(cmd, rngc->base + RNGC_COMMAND);
>  }
>=20
> -static inline void imx_rngc_irq_unmask(struct imx_rngc *rngc)
> -{
> -	u32 ctrl;
> -
> -	ctrl =3D readl(rngc->base + RNGC_CONTROL);
> -	ctrl &=3D ~(RNGC_CTRL_MASK_DONE | RNGC_CTRL_MASK_ERROR);
> -	writel(ctrl, rngc->base + RNGC_CONTROL);
> -}
> -
>  static int imx_rngc_self_test(struct imx_rngc *rngc)
>  {
>  	u32 cmd, status;
> @@ -143,56 +128,32 @@ static int imx_rngc_read(struct hwrng *rng, void
> *data, size_t max, bool wait) return retval ? retval : -EIO;
>  }
>=20
> -static irqreturn_t imx_rngc_irq(int irq, void *priv)
> -{
> -	struct imx_rngc *rngc =3D (struct imx_rngc *)priv;
> -	u32 status;
> -
> -	/*
> -	 * clearing the interrupt will also clear the error register
> -	 * read error and status before clearing
> -	 */
> -	status =3D readl(rngc->base + RNGC_STATUS);
> -	rngc->err_reg =3D readl(rngc->base + RNGC_ERROR);
> -
> -	imx_rngc_irq_mask_clear(rngc);
> -
> -	if (status & (RNGC_STATUS_SEED_DONE | RNGC_STATUS_ST_DONE))
> -		complete(&rngc->rng_op_done);
> -
> -	return IRQ_HANDLED;
> -}
> -
>  static int imx_rngc_init(struct hwrng *rng)
>  {
>  	struct imx_rngc *rngc =3D container_of(rng, struct imx_rngc, rng);
> -	u32 cmd, ctrl;
> +	u32 cmd, ctrl, status, err_reg;
>  	int ret;
>=20
>  	/* clear error */
>  	cmd =3D readl(rngc->base + RNGC_COMMAND);
>  	writel(cmd | RNGC_CMD_CLR_ERR, rngc->base + RNGC_COMMAND);
>=20
> -	imx_rngc_irq_unmask(rngc);
> -
>  	/* create seed, repeat while there is some statistical error */
>  	do {
>  		/* seed creation */
>  		cmd =3D readl(rngc->base + RNGC_COMMAND);
>  		writel(cmd | RNGC_CMD_SEED, rngc->base + RNGC_COMMAND);
>=20
> -		ret =3D wait_for_completion_timeout(&rngc->rng_op_done,
> msecs_to_jiffies(RNGC_TIMEOUT)); -		if (!ret) {
> -			ret =3D -ETIMEDOUT;
> -			goto err;
> -		}
> +		ret =3D readl_poll_timeout(rngc->base + RNGC_STATUS, status,
> +					 status &=20
RNGC_STATUS_SEED_DONE, 1000, RNGC_TIMEOUT * 1000);

So you want to poll for up to 3s?

Best regards,
Alexander

> +		if (ret < 0)
> +			return ret;
>=20
> -	} while (rngc->err_reg =3D=3D RNGC_ERROR_STATUS_STAT_ERR);
> +		err_reg =3D readl(rngc->base + RNGC_ERROR);
> +	} while (err_reg =3D=3D RNGC_ERROR_STATUS_STAT_ERR);
>=20
> -	if (rngc->err_reg) {
> -		ret =3D -EIO;
> -		goto err;
> -	}
> +	if (err_reg)
> +		return -EIO;
>=20
>  	/*
>  	 * enable automatic seeding, the rngc creates a new seed=20
automatically
> @@ -202,23 +163,7 @@ static int imx_rngc_init(struct hwrng *rng)
>  	ctrl |=3D RNGC_CTRL_AUTO_SEED;
>  	writel(ctrl, rngc->base + RNGC_CONTROL);
>=20
> -	/*
> -	 * if initialisation was successful, we keep the interrupt
> -	 * unmasked until imx_rngc_cleanup is called
> -	 * we mask the interrupt ourselves if we return an error
> -	 */
>  	return 0;
> -
> -err:
> -	imx_rngc_irq_mask_clear(rngc);
> -	return ret;
> -}
> -
> -static void imx_rngc_cleanup(struct hwrng *rng)
> -{
> -	struct imx_rngc *rngc =3D container_of(rng, struct imx_rngc, rng);
> -
> -	imx_rngc_irq_mask_clear(rngc);
>  }
>=20
>  static int __init imx_rngc_probe(struct platform_device *pdev)
> @@ -254,12 +199,9 @@ static int __init imx_rngc_probe(struct platform_dev=
ice
> *pdev) if (rng_type !=3D RNGC_TYPE_RNGC && rng_type !=3D RNGC_TYPE_RNGB)
>  		return -ENODEV;
>=20
> -	init_completion(&rngc->rng_op_done);
> -
>  	rngc->rng.name =3D pdev->name;
>  	rngc->rng.init =3D imx_rngc_init;
>  	rngc->rng.read =3D imx_rngc_read;
> -	rngc->rng.cleanup =3D imx_rngc_cleanup;
>  	rngc->rng.quality =3D 19;
>=20
>  	rngc->dev =3D &pdev->dev;
> @@ -267,11 +209,6 @@ static int __init imx_rngc_probe(struct platform_dev=
ice
> *pdev)
>=20
>  	imx_rngc_irq_mask_clear(rngc);
>=20
> -	ret =3D devm_request_irq(&pdev->dev,
> -			irq, imx_rngc_irq, 0, pdev->name, (void *)rngc);
> -	if (ret)
> -		return dev_err_probe(&pdev->dev, ret, "Can't get interrupt=20
working.\n");
> -
>  	if (self_test) {
>  		ret =3D imx_rngc_self_test(rngc);
>  		if (ret)


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


