Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDF67D11A8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 16:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377556AbjJTOfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 10:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377490AbjJTOfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 10:35:32 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC55819E
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 07:35:28 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 75506E0008;
        Fri, 20 Oct 2023 14:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697812527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bKkJpgqFVYr08H00yl52RojNphyV8fLQ0U+IXz9+aeo=;
        b=p2ZL970JgoCOJF7mnsR4N02TXPx9TBQJRoQfRBuotvKqEViYeUtrVMJnj+g7n5wJiAHGK4
        TLvFxQwY5KYdbp8PPwH8zq3yIQCI04SIj6KG24+yxe3Ib8APEE8ccj6uttcgYpIoMY2+JR
        uVRWZSSJcnV572FCtno9otKJML9XZKi39khQgRHdR2UA2hhwVFnmW3bVmc/44hU4QiM2nJ
        tGvCOXvYG6QSqSSzrZLghD1ggK5W+iS8LTGXZ0f4wEiUYmcqZlNwmc0jkr+KPVt/d3VqUi
        mevULvSkePp9b376vNKGlV0Otqo5UlUso5wCsTlnDJkjwnRGdlz/PE43xFyrMw==
Date:   Fri, 20 Oct 2023 16:35:25 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Frank Li <Frank.li@nxp.com>
Cc:     alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
        imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 Resent 6/6] i3c: master: svc: fix random hot join
 failure since timeout error
Message-ID: <20231020163525.66485920@xps-13>
In-Reply-To: <ZTKMTwU6cVAfGCKG@lizhi-Precision-Tower-5810>
References: <20231018155926.3305476-1-Frank.Li@nxp.com>
        <20231018155926.3305476-7-Frank.Li@nxp.com>
        <20231019084452.11fd0645@xps-13>
        <ZTFNvrsSoHOS3P2g@lizhi-Precision-Tower-5810>
        <20231020160645.67e678ee@xps-13>
        <ZTKMTwU6cVAfGCKG@lizhi-Precision-Tower-5810>
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

Frank.li@nxp.com wrote on Fri, 20 Oct 2023 10:18:55 -0400:

> On Fri, Oct 20, 2023 at 04:06:45PM +0200, Miquel Raynal wrote:
> > Hi Frank,
> >=20
> > Frank.li@nxp.com wrote on Thu, 19 Oct 2023 11:39:42 -0400:
> >  =20
> > > On Thu, Oct 19, 2023 at 08:44:52AM +0200, Miquel Raynal wrote: =20
> > > > Hi Frank,
> > > >=20
> > > > Frank.Li@nxp.com wrote on Wed, 18 Oct 2023 11:59:26 -0400:
> > > >    =20
> > > > > master side report:
> > > > >   silvaco-i3c-master 44330000.i3c-master: Error condition: MSTATU=
S 0x020090c7, MERRWARN 0x00100000
> > > > >=20
> > > > > BIT 20: TIMEOUT error
> > > > >   The module has stalled too long in a frame. This happens when:
> > > > >   - The TX FIFO or RX FIFO is not handled and the bus is stuck in=
 the
> > > > > middle of a message,
> > > > >   - No STOP was issued and between messages,
> > > > >   - IBI manual is used and no decision was made.   =20
> > > >=20
> > > > I am still not convinced this should be ignored in all cases.
> > > >=20
> > > > Case 1 is a problem because the hardware failed somehow.   =20
> > >=20
> > > But so far, no action to handle this case in current code. =20
> >=20
> > Yes, but if you detect an issue and ignore it, it's not better than
> > reporting it without handling it. Instead of totally ignoring this I
> > would at least write a debug message (identical to what's below) before
> > returning false, even though I am not convinced unconditionally
> > returning false here is wise. If you fail a hardware sequence because
> > you added a printk, it's a problem. Maybe you consider this line as
> > noise, but I believe it's still an error condition. Maybe, however,
> > this bit gets set after the whole sequence, and this is just a "bus
> > is idle" condition. If that's the case, then you need some
> > additional heuristics to properly ignore the bit?
> >  =20
>=20
>                 dev_err(master->dev,                                     =
 =20
>                         "Error condition: MSTATUS 0x%08x, MERRWARN 0x%08x=
\n",
>                         mstatus, merrwarn);
> +
> +		/* ignore timeout error */
> +		if (merrwarn & SVC_I3C_MERRWARN_TIMEOUT)
> +			return false;
> +
>=20
> Is it okay move SVC_I3C_MERRWARN_TIMEOUT after dev_err?

I think you mentioned earlier that the problem was not the printk but
the return value. So perhaps there is a way to know if the timeout
happened after a transaction and was legitimate or not?

In any case we should probably lower the log level for this error.

Thanks,
Miqu=C3=A8l
