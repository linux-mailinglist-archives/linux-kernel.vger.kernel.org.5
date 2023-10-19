Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF457CF014
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 08:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbjJSG3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 02:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjJSG3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 02:29:24 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5218CFE
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 23:29:21 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 686D21BF209;
        Thu, 19 Oct 2023 06:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697696959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hBt1h1Kqzm6IuFVzkjAP6Bod2gcSjnAEsTh8WsDQW+Y=;
        b=j0GI8bvBwAaZ2zM1B3cTzCy0Jv55rxzHDlyv1qSHtgTmX2kZuUlsbZEHTpDnnwaEacjmdB
        iRrKQPJFAnWLWKjvKf1fiHoUWiQjPIDAzestnqWR+1Z8SibH8ZvI0CZ37v+qmmi8qWD3ya
        fmXNoSTxkblCQqbvGnEGddW0JsZgyVw1uCCsBx5ff/frvQOHlfAhUH6exUMuVU61GQy22b
        v9SH0dh++idyoJqEXZJnE9h6iPIoBclGL7XIYmzTR4r/U9D/8CwClSRidS4IpRzWyGSmkt
        ahSg9w6PsVQCjTj9NYUznGNiyO9hLHRzyV0Vo2TOnW3g3pJHuBJqDA7etV+tkw==
Date:   Thu, 19 Oct 2023 08:29:16 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
        imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 Resent 3/6] i3c: master: svc: fix ibi may not return
 mandatory data byte
Message-ID: <20231019082916.25a536fd@xps-13>
In-Reply-To: <20231018155926.3305476-4-Frank.Li@nxp.com>
References: <20231018155926.3305476-1-Frank.Li@nxp.com>
        <20231018155926.3305476-4-Frank.Li@nxp.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SORTED_RECIPS,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

Frank.Li@nxp.com wrote on Wed, 18 Oct 2023 11:59:23 -0400:

> MSTATUS[RXPEND] is only updated after the data transfer cycle started. Th=
is
> creates an issue when the I3C clock is slow, and the CPU is running fast
> enough that MSTATUS[RXPEND] may not be updated when the code reach checki=
ng
> point. As a result, mandatory data are being missed.

reaches

can be missed

> Add a wait for MSTATUS[COMPLETE] to ensure that all mandatory data is
> already in FIFO.
>=20
> Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>=20
> Notes:
>     Change from v1 to v2
>     - update commit message
>       it also works without mandatory bytes

This could be mentioned in the commit log?

>=20
>  drivers/i3c/master/svc-i3c-master.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc=
-i3c-master.c
> index abebef666b2bb..dd06b7c9333f1 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -332,6 +332,7 @@ static int svc_i3c_master_handle_ibi(struct svc_i3c_m=
aster *master,
>  	struct i3c_ibi_slot *slot;
>  	unsigned int count;
>  	u32 mdatactrl;
> +	int ret, val;
>  	u8 *buf;
> =20
>  	slot =3D i3c_generic_ibi_get_free_slot(data->ibi_pool);
> @@ -341,6 +342,13 @@ static int svc_i3c_master_handle_ibi(struct svc_i3c_=
master *master,
>  	slot->len =3D 0;
>  	buf =3D slot->data;
> =20
> +	ret =3D readl_relaxed_poll_timeout(master->regs + SVC_I3C_MSTATUS, val,
> +						SVC_I3C_MSTATUS_COMPLETE(val), 0, 1000);
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
