Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284417CC5EC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 16:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343985AbjJQO2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 10:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234935AbjJQO2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 10:28:51 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967E7A2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 07:28:49 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 766781C000F;
        Tue, 17 Oct 2023 14:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697552928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H06xgNvMXJ6SsKeqQHp4zd1+AMWk0M/uohUueGKhjos=;
        b=FVx2NcnSpS/Z73Uly6cHt9btSMQoc4RAgx41qBu8AKj2oPSyP6tJ5g1ieSTjwXnshVThzk
        1LRWrrwh0VrKQvUe8rR6wbz6H1JVlFfokY9kn2kGU6r+NTh9ek9B1ovnPJimHa97l9Ett8
        i9MOCy8m6zKndFEBMpizrD2+/IWZ4J8+1vkazQn9TXiJAWp/M68DhiePEjRYS5geN0YafT
        FU7T4rjIwG4qpFCvrmu5SU4xD67syeulWtAJ6mpXsUQH2aNFThcHNzPSXzGj3GhkS/5HwN
        XNguK95pRaH0l9I2fhyJMItol2v4SpQWNHOXGqJZu16pgGFj+oX4rmLH5YWHXw==
Date:   Tue, 17 Oct 2023 16:28:46 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     conor.culhane@silvaco.com, alexandre.belloni@bootlin.com,
        joe@perches.com, linux-i3c@lists.infradead.org,
        linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH 4/6] i3c: master: svc: fix check wrong status register
 in irq handler
Message-ID: <20231017162846.188d7a78@xps-13>
In-Reply-To: <20231016153232.2851095-5-Frank.Li@nxp.com>
References: <20231016153232.2851095-1-Frank.Li@nxp.com>
        <20231016153232.2851095-5-Frank.Li@nxp.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

Frank.Li@nxp.com wrote on Mon, 16 Oct 2023 11:32:30 -0400:

> svc_i3c_master_irq_handler() wrong check register SVC_I3C_MINTMASKED. It

				wrongly checks
> should be SVC_I3C_MSTATUS.

Ah right, good catch.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

>=20
> Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/i3c/master/svc-i3c-master.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc=
-i3c-master.c
> index c252446b2bc5..5ab68d6e439d 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -475,7 +475,7 @@ static void svc_i3c_master_ibi_work(struct work_struc=
t *work)
>  static irqreturn_t svc_i3c_master_irq_handler(int irq, void *dev_id)
>  {
>  	struct svc_i3c_master *master =3D (struct svc_i3c_master *)dev_id;
> -	u32 active =3D readl(master->regs + SVC_I3C_MINTMASKED);
> +	u32 active =3D readl(master->regs + SVC_I3C_MSTATUS);
> =20
>  	if (!SVC_I3C_MSTATUS_SLVSTART(active))
>  		return IRQ_NONE;


Thanks,
Miqu=C3=A8l
