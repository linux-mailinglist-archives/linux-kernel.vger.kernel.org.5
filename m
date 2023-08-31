Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62A678E6E0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 08:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237324AbjHaG5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 02:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjHaG5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 02:57:38 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695F9AB
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 23:57:34 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 737EB1BF209;
        Thu, 31 Aug 2023 06:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1693465052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zzbhzTtPf3ec6YQsIX0eVjI9QDgXGYAHWymqPTgWjpE=;
        b=ZOHtdvSFKUMR5+t4LWACes1D2gKjWTL32s4Dpd4ORL8RrY0dLbriIIO+hQPQqfRB4pvXfO
        zCeHT4Zz0oIUIqtnE6yXXxShZ/Uubd/KefGP5KupDKpaTcMu0ZUKpU0OyO4zqo5WHJqocG
        FMW4LuJNOHX41Ikl8Q+RvalLuJ/NJRVCd4gZTK426Rt7JWVyprCeYyxva7pfAo/JxPIc/i
        ARLAISIOl460kyq+CEitIk97PfT99d+Fcqe0PfTr0fo9torhSv7EF7DDXWjjFY/PH9lwo7
        bxL9y2WANKMp6EcB4Tg6WMEzYIbnBUbRP7sgdnbd1QEaDOvOvFriu/Xofoz+kw==
Date:   Thu, 31 Aug 2023 08:57:28 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Frank Li <Frank.li@nxp.com>
Cc:     alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
        imx@lists.linux.dev, linux-i3c@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] i3c: master: fixes i3c bus driver probe failure
 if no i3c device attached
Message-ID: <20230831085728.0becee29@xps-13>
In-Reply-To: <ZO9vHAZT7M8hNueW@lizhi-Precision-Tower-5810>
References: <20230830141727.3794152-1-Frank.Li@nxp.com>
        <20230830175355.4bc2b8d2@xps-13>
        <ZO9vHAZT7M8hNueW@lizhi-Precision-Tower-5810>
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

Frank.li@nxp.com wrote on Wed, 30 Aug 2023 12:32:28 -0400:

> On Wed, Aug 30, 2023 at 05:53:55PM +0200, Miquel Raynal wrote:
> > Hi Frank,
> >=20
> > Frank.Li@nxp.com wrote on Wed, 30 Aug 2023 10:17:26 -0400:
> >  =20
> > > In i3c_master_bus_init()
> > > {	...
> > > 	ret =3D i3c_master_rstdaa_locked(master, I3C_BROADCAST_ADDR);
> > > 	if (ret && ret !=3D I3C_ERROR_M2)
> > > 			  ^^^ // it is enum i3c_error_code
> > > 	...
> > > }
> > >=20
> > > In dw-i3c-master.c implementation:
> > > dw_i3c_ccc_set()
> > > {	...
> > > 	ret =3D xfer->ret;
> > > 	if (xfer->cmds[0].error =3D=3D RESPONSE_ERROR_IBA_NACK)
> > > 		ccc->err =3D I3C_ERROR_M2;
> > >=20
> > > 	dw_i3c_master_free_xfer(xfer);
> > >=20
> > > 	return ret;
> > > }
> > >=20
> > > Return enum i3c_error_code when error happen in i3c_master_rstdaa_loc=
ked(). =20
> >=20
> > I am sorry but the commit log needs to be worked on.
> >  =20
> > >=20
> > > Cc: stable@vger.kernel.org
> > > Fixes: 3a379bbcea0a ("i3c: Add core I3C infrastructure")
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >=20
> > > Notes:
> > >     Change from v1 to v2:
> > >     - cc stable
> > >=20
> > >  drivers/i3c/master.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >=20
> > > diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> > > index 08aeb69a78003..00a82f3ab9ac0 100644
> > > --- a/drivers/i3c/master.c
> > > +++ b/drivers/i3c/master.c
> > > @@ -783,6 +783,9 @@ static int i3c_master_rstdaa_locked(struct i3c_ma=
ster_controller *master,
> > >  	ret =3D i3c_master_send_ccc_cmd_locked(master, &cmd);
> > >  	i3c_ccc_cmd_dest_cleanup(&dest);
> > > =20
> > > +	if (ret)
> > > +		ret =3D cmd.err; =20
> >=20
> > Shouldn't this happen in i3c_master_send_ccc_cmd_locked()? =20
>=20
> Sorry, This patch is not necesary at all.
> i3c_master_send_ccc_cmd_locked() already handled it.
> Only need second patch. You can discard this patch.
>=20
> Do you need me send 2nd patch only? Or you can just pick 2nd one?

It is quite unclear what you are finally trying to do. Please send a
proper v3, with a changelog.

>=20
> >  =20
> > > +
> > >  	return ret;
> > >  }
> > >   =20
> >=20
> >=20
> > Thanks,
> > Miqu=C3=A8l =20


Thanks,
Miqu=C3=A8l
