Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034F47D1296
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 17:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377724AbjJTPZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 11:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377721AbjJTPZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 11:25:22 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FC9D6A
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 08:25:16 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7408CFF80F;
        Fri, 20 Oct 2023 15:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697815514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vwbCNNZfs9RqfccAPlfkHKG0MKObWZhmJcj/5vJiL7Q=;
        b=TTHfJ/qwdJ0lc3+wOs0FQq0fHTPf0Gd2F+wMsOfyOY1nN1M+Uax9U1j5PgHftEzIY/0jn4
        tQXKWHoWNMHBSgfTmG+qkWWO9TVCpul5N7GliVRWDPl/bOEeqDaD0+H9yUQHQkTdgcytEk
        HHHF6XyPs4s47mRNvDIL1BL74XHh+peqRmD6zdb9UXQWrPNtsycISvsrx1zUE4RkBQi2zK
        F7iITjJ5O18dzpn+q4Cjazfd8W9Cg4+RgXR+9e+xlRB69dzI3CReMpm1f8w2J7ZGwqouAF
        HWlOhzkZvKocViyLGsPLRwf298Xcut7AN+4ctCjk1cDBT/nmkLkhowPryWJyZA==
Date:   Fri, 20 Oct 2023 17:25:13 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Frank Li <Frank.li@nxp.com>
Cc:     alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
        imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 Resent 6/6] i3c: master: svc: fix random hot join
 failure since timeout error
Message-ID: <20231020172513.43a99144@xps-13>
In-Reply-To: <ZTKZ/a5T6DLJz/ZQ@lizhi-Precision-Tower-5810>
References: <20231018155926.3305476-1-Frank.Li@nxp.com>
        <20231018155926.3305476-7-Frank.Li@nxp.com>
        <20231019084452.11fd0645@xps-13>
        <ZTFNvrsSoHOS3P2g@lizhi-Precision-Tower-5810>
        <20231020160645.67e678ee@xps-13>
        <ZTKMTwU6cVAfGCKG@lizhi-Precision-Tower-5810>
        <20231020163525.66485920@xps-13>
        <ZTKTGG7J55Sj19Nd@lizhi-Precision-Tower-5810>
        <ZTKZ/a5T6DLJz/ZQ@lizhi-Precision-Tower-5810>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

Frank.li@nxp.com wrote on Fri, 20 Oct 2023 11:17:17 -0400:

> On Fri, Oct 20, 2023 at 10:47:52AM -0400, Frank Li wrote:
> > On Fri, Oct 20, 2023 at 04:35:25PM +0200, Miquel Raynal wrote: =20
> > > Hi Frank,
> > >=20
> > > Frank.li@nxp.com wrote on Fri, 20 Oct 2023 10:18:55 -0400:
> > >  =20
> > > > On Fri, Oct 20, 2023 at 04:06:45PM +0200, Miquel Raynal wrote: =20
> > > > > Hi Frank,
> > > > >=20
> > > > > Frank.li@nxp.com wrote on Thu, 19 Oct 2023 11:39:42 -0400:
> > > > >    =20
> > > > > > On Thu, Oct 19, 2023 at 08:44:52AM +0200, Miquel Raynal wrote: =
  =20
> > > > > > > Hi Frank,
> > > > > > >=20
> > > > > > > Frank.Li@nxp.com wrote on Wed, 18 Oct 2023 11:59:26 -0400:
> > > > > > >      =20
> > > > > > > > master side report:
> > > > > > > >   silvaco-i3c-master 44330000.i3c-master: Error condition: =
MSTATUS 0x020090c7, MERRWARN 0x00100000
> > > > > > > >=20
> > > > > > > > BIT 20: TIMEOUT error
> > > > > > > >   The module has stalled too long in a frame. This happens =
when:
> > > > > > > >   - The TX FIFO or RX FIFO is not handled and the bus is st=
uck in the
> > > > > > > > middle of a message,
> > > > > > > >   - No STOP was issued and between messages,
> > > > > > > >   - IBI manual is used and no decision was made.     =20
> > > > > > >=20
> > > > > > > I am still not convinced this should be ignored in all cases.
> > > > > > >=20
> > > > > > > Case 1 is a problem because the hardware failed somehow.     =
=20
> > > > > >=20
> > > > > > But so far, no action to handle this case in current code.   =20
> > > > >=20
> > > > > Yes, but if you detect an issue and ignore it, it's not better th=
an
> > > > > reporting it without handling it. Instead of totally ignoring thi=
s I
> > > > > would at least write a debug message (identical to what's below) =
before
> > > > > returning false, even though I am not convinced unconditionally
> > > > > returning false here is wise. If you fail a hardware sequence bec=
ause
> > > > > you added a printk, it's a problem. Maybe you consider this line =
as
> > > > > noise, but I believe it's still an error condition. Maybe, howeve=
r,
> > > > > this bit gets set after the whole sequence, and this is just a "b=
us
> > > > > is idle" condition. If that's the case, then you need some
> > > > > additional heuristics to properly ignore the bit?
> > > > >    =20
> > > >=20
> > > >                 dev_err(master->dev,                               =
       =20
> > > >                         "Error condition: MSTATUS 0x%08x, MERRWARN =
0x%08x\n",
> > > >                         mstatus, merrwarn);
> > > > +
> > > > +		/* ignore timeout error */
> > > > +		if (merrwarn & SVC_I3C_MERRWARN_TIMEOUT)
> > > > +			return false;
> > > > +
> > > >=20
> > > > Is it okay move SVC_I3C_MERRWARN_TIMEOUT after dev_err? =20
> > >=20
> > > I think you mentioned earlier that the problem was not the printk but
> > > the return value. So perhaps there is a way to know if the timeout
> > > happened after a transaction and was legitimate or not? =20
> >=20
> > Error message just annoise user, don't impact function. But return false
> > let IBI thread running to avoid dead lock.  =20
>=20
> I forget mention one thing. Any error message here will make SDA low for
> longer.  Before emit stop, SDA is low.
>=20
> I have not checked I3C spec yet about how long SDA will be allowed. it wi=
ll
> worser if message go through uart port. The bus will be locked longer.
>=20
> It's better to print error message after emit_stop to reduce SDA low time.

That's fine I guess.

Thanks,
Miqu=C3=A8l
