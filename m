Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA6F7D1277
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 17:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377676AbjJTPUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 11:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377620AbjJTPUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 11:20:11 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F9E1A3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 08:20:09 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8A0F0E0009;
        Fri, 20 Oct 2023 15:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697815207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oaHjuPcslWN24KOkrEWK0l5r712keu9E2N1sB5NoPOs=;
        b=Fe+FfZGaDRfcO7OxSpnI7HBHq7pQthX5q1wmELp/2TZ6CBB/BSEsazaWzWmcdM+MsLXzbb
        tpnZ6nvC76Bz/OIBqfIaIfRJd8qI1EE+dx2Kk5mY9KZ9qpBoWbNQzSoTuXIFPfjp3DiUJp
        r1VMfnXib18izsQDF4BpRubDCSQYlDe9WiUdZ2r0/gbpHt8g8SbGtdy8o4RuNvtsMgpTq5
        373/zLtnSo+Caz8d3a+Yx058Mf59Lj7KVWms57EglSS1+nBkvqL5nE7cnEL4kWFhMOHOav
        wVsfU1yaDInUxUJYJ2vR3lZVX5ZlAGBHzCPihp906pKce+SidNAM/DLo3ysA1g==
Date:   Fri, 20 Oct 2023 17:20:06 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Frank Li <Frank.li@nxp.com>
Cc:     alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
        imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 Resent 6/6] i3c: master: svc: fix random hot join
 failure since timeout error
Message-ID: <20231020172006.5de0998b@xps-13>
In-Reply-To: <ZTKTGG7J55Sj19Nd@lizhi-Precision-Tower-5810>
References: <20231018155926.3305476-1-Frank.Li@nxp.com>
        <20231018155926.3305476-7-Frank.Li@nxp.com>
        <20231019084452.11fd0645@xps-13>
        <ZTFNvrsSoHOS3P2g@lizhi-Precision-Tower-5810>
        <20231020160645.67e678ee@xps-13>
        <ZTKMTwU6cVAfGCKG@lizhi-Precision-Tower-5810>
        <20231020163525.66485920@xps-13>
        <ZTKTGG7J55Sj19Nd@lizhi-Precision-Tower-5810>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

Frank.li@nxp.com wrote on Fri, 20 Oct 2023 10:47:52 -0400:

> On Fri, Oct 20, 2023 at 04:35:25PM +0200, Miquel Raynal wrote:
> > Hi Frank,
> >=20
> > Frank.li@nxp.com wrote on Fri, 20 Oct 2023 10:18:55 -0400:
> >  =20
> > > On Fri, Oct 20, 2023 at 04:06:45PM +0200, Miquel Raynal wrote: =20
> > > > Hi Frank,
> > > >=20
> > > > Frank.li@nxp.com wrote on Thu, 19 Oct 2023 11:39:42 -0400:
> > > >    =20
> > > > > On Thu, Oct 19, 2023 at 08:44:52AM +0200, Miquel Raynal wrote:   =
=20
> > > > > > Hi Frank,
> > > > > >=20
> > > > > > Frank.Li@nxp.com wrote on Wed, 18 Oct 2023 11:59:26 -0400:
> > > > > >      =20
> > > > > > > master side report:
> > > > > > >   silvaco-i3c-master 44330000.i3c-master: Error condition: MS=
TATUS 0x020090c7, MERRWARN 0x00100000
> > > > > > >=20
> > > > > > > BIT 20: TIMEOUT error
> > > > > > >   The module has stalled too long in a frame. This happens wh=
en:
> > > > > > >   - The TX FIFO or RX FIFO is not handled and the bus is stuc=
k in the
> > > > > > > middle of a message,
> > > > > > >   - No STOP was issued and between messages,
> > > > > > >   - IBI manual is used and no decision was made.     =20
> > > > > >=20
> > > > > > I am still not convinced this should be ignored in all cases.
> > > > > >=20
> > > > > > Case 1 is a problem because the hardware failed somehow.     =20
> > > > >=20
> > > > > But so far, no action to handle this case in current code.   =20
> > > >=20
> > > > Yes, but if you detect an issue and ignore it, it's not better than
> > > > reporting it without handling it. Instead of totally ignoring this I
> > > > would at least write a debug message (identical to what's below) be=
fore
> > > > returning false, even though I am not convinced unconditionally
> > > > returning false here is wise. If you fail a hardware sequence becau=
se
> > > > you added a printk, it's a problem. Maybe you consider this line as
> > > > noise, but I believe it's still an error condition. Maybe, however,
> > > > this bit gets set after the whole sequence, and this is just a "bus
> > > > is idle" condition. If that's the case, then you need some
> > > > additional heuristics to properly ignore the bit?
> > > >    =20
> > >=20
> > >                 dev_err(master->dev,                                 =
     =20
> > >                         "Error condition: MSTATUS 0x%08x, MERRWARN 0x=
%08x\n",
> > >                         mstatus, merrwarn);
> > > +
> > > +		/* ignore timeout error */
> > > +		if (merrwarn & SVC_I3C_MERRWARN_TIMEOUT)
> > > +			return false;
> > > +
> > >=20
> > > Is it okay move SVC_I3C_MERRWARN_TIMEOUT after dev_err? =20
> >=20
> > I think you mentioned earlier that the problem was not the printk but
> > the return value. So perhaps there is a way to know if the timeout
> > happened after a transaction and was legitimate or not? =20
>=20
> Error message just annoise user, don't impact function. But return false
> let IBI thread running to avoid dead lock.=20
>=20
> >=20
> > In any case we should probably lower the log level for this error. =20
>=20
> Only SVC_I3C_MERRWARN_TIMEOUT is warning
>=20
> Maybe below logic is better
>=20
> 	if (merrwarn & SVC_I3C_MERRWARN_TIMEOUT) {
> 		dev_dbg(master->dev,=20
>                         "Error condition: MSTATUS 0x%08x, MERRWARN 0x%08x=
\n",
> 			mstatus, merrwarn);
> 		return false;
> 	}=20
> =09
> 	dev_err(master->dev,                                    =20
>                 "Error condition: MSTATUS 0x%08x, MERRWARN 0x%08x\n",
>                  mstatus, merrwarn);=20
> 	....
>=20

Yes, this looks better but I wonder if we should add an additional
condition to just return false in this case; something saying "this
timeout is legitimate and has no impact".

Thanks,
Miqu=C3=A8l
