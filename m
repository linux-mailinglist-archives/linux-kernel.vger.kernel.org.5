Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0522A78DE3F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 21:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237641AbjH3TAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242492AbjH3IwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 04:52:21 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0818CC9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 01:52:16 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4BEE4C0005;
        Wed, 30 Aug 2023 08:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1693385535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K3IPdpdNAX0heK2EMwiRVGcgLnPwKyCy4SVQ40VHFd8=;
        b=cW3eD0wTfmK9yzIdEgMv3RfiJ9U4DJGSduiSl1991omQCdYwjwgeyX4xnZzpgOwexa5CTW
        S8oUWbXT63DheDhiXrntg+/tGlhmq5WJndCFT6fsTY13oNTEyo+Kx+aD/NsiVGxHHyh8Ni
        RvcaMS+2ZRr7zo4Co2w5mWsS5YwwDz4zseNxKWj9YTgz805tR1RgcGUKUC0hbKJdZ6Ox2w
        10ePVbaw5dN9qzwHy2B+aIcJapyzFsc3gROekZlGx2TINsKW0ex3aCirVXE+mVOxX1PIzq
        HF0KX+ufo9OvdRXS7uatq3Ybwc/zg3p7IMQQKis+DwGGMNF5ONCp+cq0uPJuFw==
Date:   Wed, 30 Aug 2023 10:52:11 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Frank Li <Frank.li@nxp.com>
Cc:     Conor Culhane <conor.culhane@silvaco.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "moderated list:SILVACO I3C DUAL-ROLE MASTER" 
        <linux-i3c@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 2/2] i3c: master: svc: fix probe failure when no i3c
 device exist
Message-ID: <20230830105211.07a2c790@xps-13>
In-Reply-To: <ZO4OMnPNCYecYImQ@lizhi-Precision-Tower-5810>
References: <20230828192502.3525418-1-Frank.Li@nxp.com>
        <20230828192502.3525418-2-Frank.Li@nxp.com>
        <20230829111611.12f91348@xps-13>
        <ZO4OMnPNCYecYImQ@lizhi-Precision-Tower-5810>
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

Frank.li@nxp.com wrote on Tue, 29 Aug 2023 11:26:42 -0400:

> On Tue, Aug 29, 2023 at 11:16:11AM +0200, Miquel Raynal wrote:
> > Hi Frank,
> >=20
> > Frank.Li@nxp.com wrote on Mon, 28 Aug 2023 15:25:02 -0400:
> >  =20
> > > If there are not i3c device, all ccc command will get NACK. Set =20
> >=20
> > 		no					NACKed?
> >  =20
> > > i3c_ccc_cmd::err as I3C_ERROR_M2. =20
> >=20
> > This sentence should come last and be slightly more explicit.
> >  =20
> > > Return success when no i3c device found at svc_i3c_master_do_daa_lock=
ed(). =20
> >=20
> > Please explain why this is important/useful. =20
>=20
> If return failure, driver will probe failure when there are no any i3c
> devices. I3C master supposed support hot join. The probe failure don't
> make sense if no i3c devices found when master driver probe.
>=20
> How about rewrite commit log as

Much better, let me propose something slightly clearer.

> "I3C master supports device hot join, it doesn't make sense master driver
> probe failure when there are no I3C devices.
>
> When there are no I3C devices attached, all CCC commands are NACKed. So
> SVC I3C master fails to probe.

What about:

I3C masters are expected to support hot-join. This means at
initialization time we might not yet discover any device and this
should not be treated as a fatal error.

During the DAA procedure which happens at probe time, if no device has
joined, all CCC will be NACKed (from a bus perspective). This leads to
an early return with an error code which fails the probe of the master.

Let's avoid this by just telling the core through an I3C_ERROR_M2
return command code that no device was discovered, which is a valid
situation. This way the master will no longer bail out and fail to
probe for a wrong reason.

> Set i3c_cc_cmd:err as I3C_ERROR_M2. So I3C master framework
> i3c_master_rstdaa_locked() can return expected ERROR code and continue
> driver probe process.
>=20
> Return success at svc_i3c_master_do_daa_locked() if no i3c devices found.
> So SVC master driver can probe successfully even if no I3C devices are
> attached"
>=20
> >  =20
> > > Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver=
") =20
> >=20
> > Shall we consider a backport into stable kernels? =20
>=20
> Yes, I can add stable tag at next version.

Yes, please.

> >  =20
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >  drivers/i3c/master/svc-i3c-master.c | 13 +++++++++++--
> > >  1 file changed, 11 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master=
/svc-i3c-master.c
> > > index 770b40e28015e..a5620103acb73 100644
> > > --- a/drivers/i3c/master/svc-i3c-master.c
> > > +++ b/drivers/i3c/master/svc-i3c-master.c
> > > @@ -789,6 +789,9 @@ static int svc_i3c_master_do_daa_locked(struct sv=
c_i3c_master *master,
> > >  				 */
> > >  				break;
> > >  			} else if (SVC_I3C_MSTATUS_NACKED(reg)) {
> > > +				/* No I3C devices attached */
> > > +				if (dev_nb =3D=3D 0)
> > > +					break; =20
> >=20
> > \n ?
> >  =20
> > >  				/*
> > >  				 * A slave device nacked the address, this is
> > >  				 * allowed only once, DAA will be stopped and
> > > @@ -1263,11 +1266,17 @@ static int svc_i3c_master_send_ccc_cmd(struct=
 i3c_master_controller *m,
> > >  {
> > >  	struct svc_i3c_master *master =3D to_svc_i3c_master(m);
> > >  	bool broadcast =3D cmd->id < 0x80;
> > > +	int ret;
> > > =20
> > >  	if (broadcast)
> > > -		return svc_i3c_master_send_bdcast_ccc_cmd(master, cmd);
> > > +		ret =3D svc_i3c_master_send_bdcast_ccc_cmd(master, cmd);
> > >  	else
> > > -		return svc_i3c_master_send_direct_ccc_cmd(master, cmd);
> > > +		ret =3D svc_i3c_master_send_direct_ccc_cmd(master, cmd);
> > > +
> > > +	if (ret)
> > > +		cmd->err =3D I3C_ERROR_M2;
> > > +
> > > +	return ret;
> > >  }
> > > =20
> > >  static int svc_i3c_master_priv_xfers(struct i3c_dev_desc *dev, =20
> >=20
> >=20
> > Thanks,
> > Miqu=C3=A8l =20


Thanks,
Miqu=C3=A8l
