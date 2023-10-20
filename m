Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18CBF7D112D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 16:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377507AbjJTOGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 10:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377419AbjJTOGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 10:06:49 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FC318F
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 07:06:47 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D3A3E240003;
        Fri, 20 Oct 2023 14:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697810806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A91K6zlEKLhuycCQFLR+/+lN0OcNnP4kMPmtOe8X+HA=;
        b=QYKGT/MBOY/andJrqj9xHV6SVZApoxcCKcIyQUWiqpy8JQ/Tgx5ZZm76WzdhEOf1BdDhTB
        +qwzP6cgBLunxsSuvBE7kutHjwVOYFFpmFXQ+0rv9lYDtE3wktvUK6ccKYtxmyXeVIeymx
        /jthVKhNBVbaeHLlGIPacKiLw9rwAWVYYiD/37ZD5eqCwTZyNms+uWxh6faYjG3rorrLoi
        vMOka0r1sdBgHAGiKfZC1xfp2YAusBGiwHbN5wEM+un2YY22Z3FSXkSsjRjXuMQZL6tDG/
        rnhaNFCD6J+6008scB1oq/kbmW/D7WHGehBZpDYzt0bzGfb21yqZP3tONDbYbA==
Date:   Fri, 20 Oct 2023 16:06:45 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Frank Li <Frank.li@nxp.com>
Cc:     alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
        imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 Resent 6/6] i3c: master: svc: fix random hot join
 failure since timeout error
Message-ID: <20231020160645.67e678ee@xps-13>
In-Reply-To: <ZTFNvrsSoHOS3P2g@lizhi-Precision-Tower-5810>
References: <20231018155926.3305476-1-Frank.Li@nxp.com>
        <20231018155926.3305476-7-Frank.Li@nxp.com>
        <20231019084452.11fd0645@xps-13>
        <ZTFNvrsSoHOS3P2g@lizhi-Precision-Tower-5810>
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

Frank.li@nxp.com wrote on Thu, 19 Oct 2023 11:39:42 -0400:

> On Thu, Oct 19, 2023 at 08:44:52AM +0200, Miquel Raynal wrote:
> > Hi Frank,
> >=20
> > Frank.Li@nxp.com wrote on Wed, 18 Oct 2023 11:59:26 -0400:
> >  =20
> > > master side report:
> > >   silvaco-i3c-master 44330000.i3c-master: Error condition: MSTATUS 0x=
020090c7, MERRWARN 0x00100000
> > >=20
> > > BIT 20: TIMEOUT error
> > >   The module has stalled too long in a frame. This happens when:
> > >   - The TX FIFO or RX FIFO is not handled and the bus is stuck in the
> > > middle of a message,
> > >   - No STOP was issued and between messages,
> > >   - IBI manual is used and no decision was made. =20
> >=20
> > I am still not convinced this should be ignored in all cases.
> >=20
> > Case 1 is a problem because the hardware failed somehow. =20
>=20
> But so far, no action to handle this case in current code.

Yes, but if you detect an issue and ignore it, it's not better than
reporting it without handling it. Instead of totally ignoring this I
would at least write a debug message (identical to what's below) before
returning false, even though I am not convinced unconditionally
returning false here is wise. If you fail a hardware sequence because
you added a printk, it's a problem. Maybe you consider this line as
noise, but I believe it's still an error condition. Maybe, however,
this bit gets set after the whole sequence, and this is just a "bus
is idle" condition. If that's the case, then you need some
additional heuristics to properly ignore the bit?

> In svc_i3c_master_xfer() have not check this flags. also have not enable
> ERRWARN irq.
>=20
> If we met this case, we can add new functions/argument to handle this.
> Then we can real debug the code and recover bus.
>=20
> Without this patch, simplest add some debug message before issue
> SVC_I3C_MCTRL_REQUEST_AUTO_IBI, TIMEOUT will be set.

Yes, and sometimes it won't be an issue, but sometimes it may. Maybe we
can find more advanced heuristics there.

> And svc_i3c_master_error() was only called by svc_i3c_master_ibi_work().
>
> So I can think only case 3 happen in svc_i3c_master_ibi_work().

Case 3 cannot be handled by Linux (because of the natural latency of
the OS).

>=20
> Frank
>=20
> > Case 2 is fine I guess.
> > Case 3 is not possible in Linux, this will not be supported.
> >  =20
> > >   The maximum stall period is 10 KHz or 100 =CE=BCs. =20
> >=20
> > s/10 KHz//
> >  =20
> > >=20
> > > This is a just warning. System irq thread schedule latency is possible
> > > bigger than 100us. Just omit this waring. =20
> >=20
> > This can be considered as being just a warning as the system IRQ
> > latency can easily be greater than 100us.

This was skipped in your v3.

> > > Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver=
")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---

Thanks,
Miqu=C3=A8l
