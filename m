Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9169D7CC5E8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 16:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343771AbjJQO1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 10:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbjJQO1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 10:27:13 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9226B92
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 07:27:11 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 62D6A1C0009;
        Tue, 17 Oct 2023 14:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697552830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZBf00a1VvFJyyt7kPQ4Hr82k1XZLPzLRAVTVgudZ1EM=;
        b=md/VDBD2broqt7zpeSCaJb2WIYk0Ver/8Pv5eSU+yTO4xt+h3inMX+8AVcu5Oy6c+ut7GL
        HiFT6lf2mizYeZa54+H6AltipxpCThl9/ihcj6e4Ak9a0XIs2aXullPTxSP1HScj95t1zk
        YdD8FanC92DKP3wx5XEfeIvBWMbiOWXzjN07Wbss2aETeSkQw/DbZxsTjbJ0s31MOTmQzT
        x1cOU0oBIcVDBfv6oYURHHNf3RkqHAAUXphYKWS1sDdkM4NAScJScushaq0YtIL9K+YdSg
        Cg5Y14oRFSR/LfXghp1urvVCke9ujniLV7lMYyiwfOLS2RzZkg8l08sltI3T8Q==
Date:   Tue, 17 Oct 2023 16:27:07 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     conor.culhane@silvaco.com, alexandre.belloni@bootlin.com,
        joe@perches.com, linux-i3c@lists.infradead.org,
        linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH 3/6] i3c: master: svc: fix ibi may not return mandatory
 data byte
Message-ID: <20231017162707.187bebcf@xps-13>
In-Reply-To: <20231016153232.2851095-4-Frank.Li@nxp.com>
References: <20231016153232.2851095-1-Frank.Li@nxp.com>
        <20231016153232.2851095-4-Frank.Li@nxp.com>
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

Frank.Li@nxp.com wrote on Mon, 16 Oct 2023 11:32:29 -0400:

> MSTATUS[RXPEND] is only updated after the data transfer cycle started. Th=
is
> creates an issue when the I3C clock is slow, and the CPU is running fast
> enough that MSTATUS[RXPEND] may not be updated when the code reach checki=
ng
> point. As a result, mandatory data are being missed.

					can be missed.

> Add a wait for MSTATUS[COMPLETE] to ensure that all mandatory data already
> in FIFO.

is already in the FIFO

>=20
> Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/i3c/master/svc-i3c-master.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc=
-i3c-master.c
> index 0f57a5f75e39..c252446b2bc5 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -331,6 +331,7 @@ static int svc_i3c_master_handle_ibi(struct svc_i3c_m=
aster *master,
>  	struct i3c_ibi_slot *slot;
>  	unsigned int count;
>  	u32 mdatactrl;
> +	int ret, val;
>  	u8 *buf;
> =20
>  	slot =3D i3c_generic_ibi_get_free_slot(data->ibi_pool);
> @@ -340,6 +341,13 @@ static int svc_i3c_master_handle_ibi(struct svc_i3c_=
master *master,
>  	slot->len =3D 0;
>  	buf =3D slot->data;
> =20
> +	ret =3D readl_relaxed_poll_timeout(master->regs + SVC_I3C_MSTATUS, val,
> +						SVC_I3C_MSTATUS_COMPLETE(val), 0, 1000);

Are you sure !MSTATUS_COMPLETE(val) is never a valid condition?
Especially with non-mandatory bytes?

Also, are you sure of the indentation here?

> +	if (ret) {
> +		dev_err(master->dev, "Timeout when polling for COMPLETE\n");
> +		return ret;
> +	}
> +
>  	while (SVC_I3C_MSTATUS_RXPEND(readl(master->regs + SVC_I3C_MSTATUS))  &&
>  	       slot->len < SVC_I3C_FIFO_SIZE) {
>  		mdatactrl =3D readl(master->regs + SVC_I3C_MDATACTRL);


Thanks,
Miqu=C3=A8l
