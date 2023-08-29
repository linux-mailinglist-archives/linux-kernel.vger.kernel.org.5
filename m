Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B0E78C118
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 11:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234504AbjH2JQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 05:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234620AbjH2JQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 05:16:24 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B551AD
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 02:16:15 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 508541BF207;
        Tue, 29 Aug 2023 09:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1693300574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9vq4ofEpHyOMcy5b5TahWFabzG08hTAP6j/W1z24Ls4=;
        b=EO9fZGZj4zW35tOltEoCC0KpG+J/t9xY52fGD7MMn72vc92p0culeB24Sgw72b9zWBgMUD
        5VpQCIv7B2+DUz9b0Usyfy2zTQdDbEqrRqDulP6p3yMfFykZ73BfupGRbpbkyN4T8SZ+s6
        USd0LZqzAkTcK3Po6m7jLwAsvEKZ8bA0ou9F9fxY78WLQI9ffiFmkGAKKlMIgCXfn1Q0Eb
        qJMJNCVk6GO/jZhdtxBDbt6s3liyg5P/xI9TMDyeYvOpD2igO+ibBZ3zc12jd0VPt+l8Pp
        BN2ZRWvewcN0gJ/KjqXTl/2xYSsEzIsrqs06RJnUSFAHfAscyD02TITD62DXbw==
Date:   Tue, 29 Aug 2023 11:16:11 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     Conor Culhane <conor.culhane@silvaco.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-i3c@lists.infradead.org (moderated list:SILVACO I3C DUAL-ROLE
        MASTER), linux-kernel@vger.kernel.org (open list),
        imx@lists.linux.dev
Subject: Re: [PATCH 2/2] i3c: master: svc: fix probe failure when no i3c
 device exist
Message-ID: <20230829111611.12f91348@xps-13>
In-Reply-To: <20230828192502.3525418-2-Frank.Li@nxp.com>
References: <20230828192502.3525418-1-Frank.Li@nxp.com>
        <20230828192502.3525418-2-Frank.Li@nxp.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

Frank.Li@nxp.com wrote on Mon, 28 Aug 2023 15:25:02 -0400:

> If there are not i3c device, all ccc command will get NACK. Set

		no					NACKed?

> i3c_ccc_cmd::err as I3C_ERROR_M2.

This sentence should come last and be slightly more explicit.

> Return success when no i3c device found at svc_i3c_master_do_daa_locked().

Please explain why this is important/useful.

> Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver")

Shall we consider a backport into stable kernels?

> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/i3c/master/svc-i3c-master.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc=
-i3c-master.c
> index 770b40e28015e..a5620103acb73 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -789,6 +789,9 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3=
c_master *master,
>  				 */
>  				break;
>  			} else if (SVC_I3C_MSTATUS_NACKED(reg)) {
> +				/* No I3C devices attached */
> +				if (dev_nb =3D=3D 0)
> +					break;

\n ?

>  				/*
>  				 * A slave device nacked the address, this is
>  				 * allowed only once, DAA will be stopped and
> @@ -1263,11 +1266,17 @@ static int svc_i3c_master_send_ccc_cmd(struct i3c=
_master_controller *m,
>  {
>  	struct svc_i3c_master *master =3D to_svc_i3c_master(m);
>  	bool broadcast =3D cmd->id < 0x80;
> +	int ret;
> =20
>  	if (broadcast)
> -		return svc_i3c_master_send_bdcast_ccc_cmd(master, cmd);
> +		ret =3D svc_i3c_master_send_bdcast_ccc_cmd(master, cmd);
>  	else
> -		return svc_i3c_master_send_direct_ccc_cmd(master, cmd);
> +		ret =3D svc_i3c_master_send_direct_ccc_cmd(master, cmd);
> +
> +	if (ret)
> +		cmd->err =3D I3C_ERROR_M2;
> +
> +	return ret;
>  }
> =20
>  static int svc_i3c_master_priv_xfers(struct i3c_dev_desc *dev,


Thanks,
Miqu=C3=A8l
