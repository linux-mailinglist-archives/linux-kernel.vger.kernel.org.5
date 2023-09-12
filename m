Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A45B79CEFA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 12:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbjILK5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 06:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjILK5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 06:57:11 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD2B9F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 03:57:07 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 72726E0006;
        Tue, 12 Sep 2023 10:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1694516226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J61rx//PPkUlb2Sgp0SYcJ40b+/rbdWLC/XlBtvN7xM=;
        b=ceinYO6zdv69WaKDudQCC+YKCOL1pbZ+SEvMhXRIMP+brevSJd5G0Oym2crb4KNKmslDO4
        prNgoqb6XpruzCwM08cgaJsj5SfC+pqmFIikAQj/95ey6J77w+A5WbPMYrETwTCDneAfM3
        gIbjk3A75SGab0xAcvetrPvV6wyBZ3VxRKsHLH4dQ2pLoMHNquEAcp7hEr/Rd3ORav98Pl
        5RePwvnK03ODoZTgg3jnN1X2ACe0U/ms+pgQyr9uWS1NvZFt8E7IEcQ40OHQ0oCLFarUv3
        20MgV3vpdS3bZ5K5nXysgSW9JTtnhEHiSva+lLVCqBD9nWHgv3N39TjgEQFwqA==
Date:   Tue, 12 Sep 2023 12:57:04 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Joshua Yeong <joshua.yeong@starfivetech.com>
Cc:     <pgaj@cadence.com>, <alexandre.belloni@bootlin.com>,
        <linux-i3c@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] i3c: master: cdns: Fix reading status register
Message-ID: <20230912125704.5fb1a102@xps-13>
In-Reply-To: <20230911081623.21963-2-joshua.yeong@starfivetech.com>
References: <20230911081623.21963-1-joshua.yeong@starfivetech.com>
        <20230911081623.21963-2-joshua.yeong@starfivetech.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joshua,

joshua.yeong@starfivetech.com wrote on Mon, 11 Sep 2023 16:16:24 +0800:

> IBIR_DEPTH and CMDR_DEPTH should read from status0 instead of status1

				  be

Missing '.' at the end.

Missing Fixes: tag as well as Cc: stable.

>=20
> Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>
> ---
>  drivers/i3c/master/i3c-master-cdns.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/i3c/master/i3c-master-cdns.c b/drivers/i3c/master/i3=
c-master-cdns.c
> index 49551db71bc9..8f1fda3c7ac5 100644
> --- a/drivers/i3c/master/i3c-master-cdns.c
> +++ b/drivers/i3c/master/i3c-master-cdns.c
> @@ -191,7 +191,7 @@
>  #define SLV_STATUS1_HJ_DIS		BIT(18)
>  #define SLV_STATUS1_MR_DIS		BIT(17)
>  #define SLV_STATUS1_PROT_ERR		BIT(16)
> -#define SLV_STATUS1_DA(x)		(((s) & GENMASK(15, 9)) >> 9)
> +#define SLV_STATUS1_DA(s)		(((s) & GENMASK(15, 9)) >> 9)
>  #define SLV_STATUS1_HAS_DA		BIT(8)
>  #define SLV_STATUS1_DDR_RX_FULL		BIT(7)
>  #define SLV_STATUS1_DDR_TX_FULL		BIT(6)
> @@ -1623,13 +1623,13 @@ static int cdns_i3c_master_probe(struct platform_=
device *pdev)
>  	/* Device ID0 is reserved to describe this master. */
>  	master->maxdevs =3D CONF_STATUS0_DEVS_NUM(val);
>  	master->free_rr_slots =3D GENMASK(master->maxdevs, 1);
> +	master->caps.ibirfifodepth =3D CONF_STATUS0_IBIR_DEPTH(val);
> +	master->caps.cmdrfifodepth =3D CONF_STATUS0_CMDR_DEPTH(val);
> =20
>  	val =3D readl(master->regs + CONF_STATUS1);
>  	master->caps.cmdfifodepth =3D CONF_STATUS1_CMD_DEPTH(val);
>  	master->caps.rxfifodepth =3D CONF_STATUS1_RX_DEPTH(val);
>  	master->caps.txfifodepth =3D CONF_STATUS1_TX_DEPTH(val);
> -	master->caps.ibirfifodepth =3D CONF_STATUS0_IBIR_DEPTH(val);
> -	master->caps.cmdrfifodepth =3D CONF_STATUS0_CMDR_DEPTH(val);
> =20
>  	spin_lock_init(&master->ibi.lock);
>  	master->ibi.num_slots =3D CONF_STATUS1_IBI_HW_RES(val);


Thanks,
Miqu=C3=A8l
