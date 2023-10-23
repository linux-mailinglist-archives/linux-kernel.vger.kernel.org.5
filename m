Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7E37D2BD2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 09:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbjJWHtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 03:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233600AbjJWHtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 03:49:02 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48D2D65
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 00:48:59 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 90EE51C000A;
        Mon, 23 Oct 2023 07:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698047338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dsbOxXvaUACNqn3KCLe6HiongEO3afF5MvHJnuxBJM8=;
        b=F2Q+Rw1+gg6fZaPNgceUhfb+c+gt9le1AcvsihKsFbbO/k0YC41wRzxb//miKRe8z3KfJs
        SB7XBpyI+Ka3gpY3xXASYDgZb58ieEm/1kKqd/T8mEbCGg39QtUMM/1H9kNwvcM+Y9Q5Az
        xumiB2QLhNa1AyS7yBEOSy8rhA706RpJf0iz/y9Wo4yRZ2dsEmiqN8zMKT51hwvvcYXdHP
        VohJhNX0SVTBoKGEkaD5p1J2CkK7T5gMtneE4C0Pcmmk6v16NfkURwrx/YCQPvVFjb941D
        M3cNeqcASks9w11fUqXaEVFLJMVxacud7EwpR3ppZcrZvqxrzd3Azpdz2NOR7A==
Date:   Mon, 23 Oct 2023 09:48:53 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Frank Li <Frank.li@nxp.com>
Cc:     alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
        imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 Resent 6/6] i3c: master: svc: fix random hot join
 failure since timeout errory
Message-ID: <20231023094853.2510967f@xps-13>
In-Reply-To: <ZTLb4f4WieyLnb6m@lizhi-Precision-Tower-5810>
References: <20231018155926.3305476-7-Frank.Li@nxp.com>
        <20231019084452.11fd0645@xps-13>
        <ZTFNvrsSoHOS3P2g@lizhi-Precision-Tower-5810>
        <20231020160645.67e678ee@xps-13>
        <ZTKMTwU6cVAfGCKG@lizhi-Precision-Tower-5810>
        <20231020163525.66485920@xps-13>
        <ZTKTGG7J55Sj19Nd@lizhi-Precision-Tower-5810>
        <20231020172006.5de0998b@xps-13>
        <ZTKhJOAAz4CaupEf@lizhi-Precision-Tower-5810>
        <20231020190337.13ef5638@xps-13>
        <ZTLb4f4WieyLnb6m@lizhi-Precision-Tower-5810>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SORTED_RECIPS,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

Frank.li@nxp.com wrote on Fri, 20 Oct 2023 15:58:25 -0400:

> On Fri, Oct 20, 2023 at 07:03:37PM +0200, Miquel Raynal wrote:
> > Hi Frank,
> >=20
> > Frank.li@nxp.com wrote on Fri, 20 Oct 2023 11:47:48 -0400:
> >  =20
> > > On Fri, Oct 20, 2023 at 05:20:06PM +0200, Miquel Raynal wrote: =20
> > > > Hi Frank,
> > > >=20
> > > > Frank.li@nxp.com wrote on Fri, 20 Oct 2023 10:47:52 -0400:
> > > >    =20
> > > > > On Fri, Oct 20, 2023 at 04:35:25PM +0200, Miquel Raynal wrote:   =
=20
> > > > > > Hi Frank,
> > > > > >=20
> > > > > > Frank.li@nxp.com wrote on Fri, 20 Oct 2023 10:18:55 -0400:
> > > > > >      =20
> > > > > > > On Fri, Oct 20, 2023 at 04:06:45PM +0200, Miquel Raynal wrote=
:     =20
> > > > > > > > Hi Frank,
> > > > > > > >=20
> > > > > > > > Frank.li@nxp.com wrote on Thu, 19 Oct 2023 11:39:42 -0400:
> > > > > > > >        =20
> > > > > > > > > On Thu, Oct 19, 2023 at 08:44:52AM +0200, Miquel Raynal w=
rote:       =20
> > > > > > > > > > Hi Frank,
> > > > > > > > > >=20
> > > > > > > > > > Frank.Li@nxp.com wrote on Wed, 18 Oct 2023 11:59:26 -04=
00:
> > > > > > > > > >          =20
> > > > > > > > > > > master side report:
> > > > > > > > > > >   silvaco-i3c-master 44330000.i3c-master: Error condi=
tion: MSTATUS 0x020090c7, MERRWARN 0x00100000
> > > > > > > > > > >=20
> > > > > > > > > > > BIT 20: TIMEOUT error
> > > > > > > > > > >   The module has stalled too long in a frame. This ha=
ppens when:
> > > > > > > > > > >   - The TX FIFO or RX FIFO is not handled and the bus=
 is stuck in the
> > > > > > > > > > > middle of a message,
> > > > > > > > > > >   - No STOP was issued and between messages,
> > > > > > > > > > >   - IBI manual is used and no decision was made.     =
    =20
> > > > > > > > > >=20
> > > > > > > > > > I am still not convinced this should be ignored in all =
cases.
> > > > > > > > > >=20
> > > > > > > > > > Case 1 is a problem because the hardware failed somehow=
.         =20
> > > > > > > > >=20
> > > > > > > > > But so far, no action to handle this case in current code=
.       =20
> > > > > > > >=20
> > > > > > > > Yes, but if you detect an issue and ignore it, it's not bet=
ter than
> > > > > > > > reporting it without handling it. Instead of totally ignori=
ng this I
> > > > > > > > would at least write a debug message (identical to what's b=
elow) before
> > > > > > > > returning false, even though I am not convinced uncondition=
ally
> > > > > > > > returning false here is wise. If you fail a hardware sequen=
ce because
> > > > > > > > you added a printk, it's a problem. Maybe you consider this=
 line as
> > > > > > > > noise, but I believe it's still an error condition. Maybe, =
however,
> > > > > > > > this bit gets set after the whole sequence, and this is jus=
t a "bus
> > > > > > > > is idle" condition. If that's the case, then you need some
> > > > > > > > additional heuristics to properly ignore the bit?
> > > > > > > >        =20
> > > > > > >=20
> > > > > > >                 dev_err(master->dev,                         =
             =20
> > > > > > >                         "Error condition: MSTATUS 0x%08x, MER=
RWARN 0x%08x\n",
> > > > > > >                         mstatus, merrwarn);
> > > > > > > +
> > > > > > > +		/* ignore timeout error */
> > > > > > > +		if (merrwarn & SVC_I3C_MERRWARN_TIMEOUT)
> > > > > > > +			return false;
> > > > > > > +
> > > > > > >=20
> > > > > > > Is it okay move SVC_I3C_MERRWARN_TIMEOUT after dev_err?     =
=20
> > > > > >=20
> > > > > > I think you mentioned earlier that the problem was not the prin=
tk but
> > > > > > the return value. So perhaps there is a way to know if the time=
out
> > > > > > happened after a transaction and was legitimate or not?     =20
> > > > >=20
> > > > > Error message just annoise user, don't impact function. But retur=
n false
> > > > > let IBI thread running to avoid dead lock.=20
> > > > >    =20
> > > > > >=20
> > > > > > In any case we should probably lower the log level for this err=
or.     =20
> > > > >=20
> > > > > Only SVC_I3C_MERRWARN_TIMEOUT is warning
> > > > >=20
> > > > > Maybe below logic is better
> > > > >=20
> > > > > 	if (merrwarn & SVC_I3C_MERRWARN_TIMEOUT) {
> > > > > 		dev_dbg(master->dev,=20
> > > > >                         "Error condition: MSTATUS 0x%08x, MERRWAR=
N 0x%08x\n",
> > > > > 			mstatus, merrwarn);
> > > > > 		return false;
> > > > > 	}=20
> > > > > =09
> > > > > 	dev_err(master->dev,                                    =20
> > > > >                 "Error condition: MSTATUS 0x%08x, MERRWARN 0x%08x=
\n",
> > > > >                  mstatus, merrwarn);=20
> > > > > 	....
> > > > >    =20
> > > >=20
> > > > Yes, this looks better but I wonder if we should add an additional
> > > > condition to just return false in this case;    =20
> > >=20
> > > What's additional condition we can check? =20
> >=20
> > Well, you're the one bothered with an error case which is not a real
> > error. You're saying "this error is never a problem" and I am saying
> > that I believe it is not a problem is your particular case, but in
> > general there might be situations where it *is* a problem. So you need
> > to find proper conditions to check against in order to determine
> > whether this is just an info with no consequence or an error. =20
>=20
> I checked R** code of this TIMEOUT, which is quite simple, set to 1 if SDA
> is low over 100us if I understand correctly. I also checked, if I add del=
ay
> before emit stop, TIMEOUT will be set. (Read can auto emit stop accoring =
to
> RDTERM, so just saw TIMEOUT at write transaction).
>=20
> TIMEOUT just means condition "I3C bus's SDA low over 100us" happened since
> written 1 to TIMEOUT.
>=20
> I think "I3C bus's SDA over 100us" means nothing for linux drivers.
>=20
> I think there are NO sitation where it *is* a problem. If it was problem,
> there are NO solution to resolve it at linux driver side. And I think it
> already happen many times silencely.=20

Ok then, I'll opt for your last proposal of printing the error message
at the debug loglevel and return false.

Thanks,
Miqu=C3=A8l
