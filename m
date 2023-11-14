Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3007EAC3A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 09:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbjKNI4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 03:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbjKNI4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 03:56:48 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951171A5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 00:56:43 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 16B3F1BF20E;
        Tue, 14 Nov 2023 08:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699952202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9zGZ4sq00jQphO6lz9A63nJTBqIRDe3wj/ZCR/VS6Es=;
        b=EYa+tHQNKe3Jw7paRiABoFWPI8doBiWqgY3OHa/XjRP4Ksgb0RPJ+0Q2pBoywZKETNJK4Q
        gTVv/o7RVbgMdLArGcm+7gs+A5Q1Hc7eOiGtwrIep2+7GYFww4LU2uz+Y9n6+X38hiuSh4
        grHAjP4JefRl5tabIBOUvLTX3X5VYmMud4rsrATyZAjFS2QZNiCmgJ83raZqSZxfdUTWE8
        XaIEAgtQsb4YqOOQ+cql0FLTyaBb4NjamNhZ27EgxJn6sI+0zVDzIKzKbAjCE23AoKKwR0
        k7jItHOLgzxa9MdRN3qINJ8VPIm39fVgTvDh90iecqr4IgHNJh8ZrlsEpd62Wg==
Date:   Tue, 14 Nov 2023 09:56:41 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Joshua Yeong <joshua.yeong@starfivetech.com>
Cc:     <alexandre.belloni@bootlin.com>, <linux-i3c@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] i3c: Add fallback method for GETMXDS CCC
Message-ID: <20231114095641.1068437e@xps-13>
In-Reply-To: <d0e473f3-7b05-2d18-9874-eb9fe26f8478@starfivetech.com>
References: <20231114033430.9623-1-joshua.yeong@starfivetech.com>
        <20231114033430.9623-2-joshua.yeong@starfivetech.com>
        <20231114091956.0b8dd6c5@xps-13>
        <d0e473f3-7b05-2d18-9874-eb9fe26f8478@starfivetech.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joshua,

joshua.yeong@starfivetech.com wrote on Tue, 14 Nov 2023 16:42:44 +0800:

> Hi Miquel,
>=20
> On 14-Nov-23 4:19 PM, Miquel Raynal wrote:
> > Hi Joshua,
> >
> > joshua.yeong@starfivetech.com wrote on Tue, 14 Nov 2023 11:34:30 +0800:
> > =20
> >> Some I3C hardware will report error when incorrect length is received =
from =20
> > 					an
> > =20
> >> device. GETMXDS CCC are availble in 2 formats; without turnaround time=
 =20
>  (format
> > 			  available		:
> > =20
> >> 1) and with turnaround time (format 2). There is no mechanics to deter=
 =20
> mine which
> >> format is supported by device. In case sending GETMXDS CCC format 2 re=
 =20
> sulted
> > 				So in case?
> > =20
> >> failure, try sending GETMXDS CCC format 1 instead. =20
> > in a
> > =20
> >> Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>
> >> ---
> >>   drivers/i3c/master.c | 12 ++++++++++--
> >>   1 file changed, 10 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> >> index 0cdc94e4cb77..2fc04d97f07e 100644
> >> --- a/drivers/i3c/master.c
> >> +++ b/drivers/i3c/master.c
> >> @@ -1099,8 +1099,16 @@ static int i3c_master_getmxds_locked(struct i3c=
 =20
> _master_controller *master,
> >>   >>   	i3c_ccc_cmd_init(&cmd, true, I3C_CCC_GETMXDS, &dest, 1); =20
> >>   	ret =3D i3c_master_send_ccc_cmd_locked(master, &cmd);
> >> -	if (ret)
> >> -		goto out;
> >> +	if (ret) {
> >> +		/* =20
> > 		 ^
> > Wrong alignment of the starts below
> > 		v =20
> >> +		* Retry when the device does not support max read turnaround
> >> +		* while expecting shorter length from this CCC command =20
> > period?
> > =20
> >> +		*/
> >> +		dest->payload.len -=3D 3;
> >> +		ret =3D i3c_master_send_ccc_cmd_locked(master, &cmd);
> >> +		if (ret)
> >> +			goto out;
> >> +	} =20
> > I believe this is a per-device configuration and we should save this in
> > order to only fail once, no? =20
>=20
> This behavior depends on the hardware designed whether it will return an =
error
> in case of shorter length from i3c devices in dest->payload.len. I made i=
t so it
> will retry by expecting a shorter length instead, in case it still fails =
then
> it means GETMXDS CCC really failed.

Yes, I got the logic.

> We do not have to initialize the same hardware twice and do GETMXDS CCC m
> ore
> than once as far as I know?

I don't remember. If you say so, then it's fine like this.

> >>   >>   	if (dest.payload.len !=3D 2 && dest.payload.len !=3D 5) { =20
> >>   		ret =3D -EIO; =20

Thanks,
Miqu=C3=A8l
