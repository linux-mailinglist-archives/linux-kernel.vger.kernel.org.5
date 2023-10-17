Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566567CC59C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 16:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235003AbjJQOKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 10:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233670AbjJQOKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 10:10:14 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7B592
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 07:10:12 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 609A92000D;
        Tue, 17 Oct 2023 14:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697551811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QBPY2hSGglGk838ElQLUx0rBOrbcTUvJ3BnBggnTEkw=;
        b=fDQFLQNA85IdB5g2Zco+Yf30Tl6DcXhIHK0Ln7bAayNZrtSLBJV064yJNrapFIEhSGmQLe
        3+hnGYb+V/E2rcuJZsX/WgKZKdhWYTgOLaNz9b85T//g3L01Cz2AH4oX7RAo/A29Zp7PSR
        U14IJetJv2/nF5ZPH9VMtyQ3qqtdv/1HW9U5Hg7AtIUStRS7w9GlTzJCEQhGCnDPIrJGKZ
        4l4qFnE8LC8S8kUSFGJrjo8D56is9p8p1wHqzGIWj/zH2DHFZri1cJuXZnhiiPljjVfO3U
        N02TCxK8KtPh/YAW37WvS3L2oUtodGJNh1jN+QqxjVJ8EcjXmlX1WopwYfg+lQ==
Date:   Tue, 17 Oct 2023 16:10:07 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
        joe@perches.com, linux-i3c@lists.infradead.org,
        linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH 4/5] i3c: master: svc return actual transfer data len
Message-ID: <20231017161007.146a5199@xps-13>
In-Reply-To: <20231016154632.2851957-5-Frank.Li@nxp.com>
References: <20231016154632.2851957-1-Frank.Li@nxp.com>
        <20231016154632.2851957-5-Frank.Li@nxp.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

Frank.Li@nxp.com wrote on Mon, 16 Oct 2023 11:46:31 -0400:

> I3C allow devices early terminate data transfer. So set "actual" to
> indicate how much data get by i3c_priv_xfer.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/i3c/master/svc-i3c-master.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc=
-i3c-master.c
> index 3570b709cf60..444825aafa6f 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -138,6 +138,7 @@ struct svc_i3c_cmd {
>  	const void *out;
>  	unsigned int len;
>  	unsigned int actual_len;
> +	struct i3c_priv_xfer *xfer;
>  	bool continued;
>  };
> =20
> @@ -1045,6 +1046,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_maste=
r *master,
> =20
>  	if (readl(master->regs + SVC_I3C_MERRWARN) & SVC_I3C_MERRWARN_NACK) {
>  		ret =3D -ENXIO;
> +		*actual_len =3D 0;
>  		goto emit_stop;
>  	}
> =20
> @@ -1062,6 +1064,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_maste=
r *master,
>  	 */
>  	if (SVC_I3C_MSTATUS_IBIWON(reg)) {
>  		ret =3D -ENXIO;
> +		*actual_len =3D 0;
>  		goto emit_stop;
>  	}
> =20
> @@ -1157,6 +1160,9 @@ static void svc_i3c_master_start_xfer_locked(struct=
 svc_i3c_master *master)
>  					  cmd->addr, cmd->in, cmd->out,
>  					  cmd->len, &cmd->actual_len,
>  					  cmd->continued);
> +		if (cmd->xfer)
> +			cmd->xfer->actual =3D cmd->actual_len;

Just to be sure, wouldn't it be more natural to always fill cmd->xfer
rather than checking it here?

> +
>  		if (ret)
>  			break;
>  	}
> @@ -1344,6 +1350,7 @@ static int svc_i3c_master_priv_xfers(struct i3c_dev=
_desc *dev,
>  	for (i =3D 0; i < nxfers; i++) {
>  		struct svc_i3c_cmd *cmd =3D &xfer->cmds[i];
> =20
> +		cmd->xfer =3D xfers + i;

Please follow the same pattern as below: =3D &xfers[i]

>  		cmd->addr =3D master->addrs[data->index];
>  		cmd->rnw =3D xfers[i].rnw;
>  		cmd->in =3D xfers[i].rnw ? xfers[i].data.in : NULL;


Thanks,
Miqu=C3=A8l
