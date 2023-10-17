Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9A77CC709
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 17:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344196AbjJQPHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 11:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344158AbjJQPHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 11:07:35 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4E6272E
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 08:06:07 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 37DB8C0004;
        Tue, 17 Oct 2023 15:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697555166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wcKDvBb6jnUJQGfQIZYJmILk9qMhN/wgRJD69FE2Nq8=;
        b=gMNSrwXtyQfHLaxBZdIC7zCUVCGh1Q4jYEI8oNA7aj8wZrGUVUZnJJ2AOnfBq0kvZIDa/l
        iZSE4toLtXxLjDvoLhNhYS1rmWaB6TdwNqpJOURBet+RsqkbUJkMbbia+bpWt3expJJLsP
        U7vHEx01/8914YAG7RIzVmmrvwfX0HnHI0z3wJwmlc/GJ4FWVdZmWzVf7vhwiCbFqrOXEk
        JU4QoVYHpoRxtTz1Me9AJ+fHggBbIBE8IrixH5KWQcC+s8eMvbm8/8X7HlRKxOnEJNKTF5
        SBa2fjyDdx+w+F6Ka4caG+wTX5qObjvF5Bit16RQVavw8M2Iq95RK50EUruRag==
Date:   Tue, 17 Oct 2023 17:06:03 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Frank Li <Frank.li@nxp.com>
Cc:     conor.culhane@silvaco.com, alexandre.belloni@bootlin.com,
        joe@perches.com, linux-i3c@lists.infradead.org,
        linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH 6/6] i3c: master: svc: fix random hot join failure since
 timeout error
Message-ID: <20231017170603.5ef996c2@xps-13>
In-Reply-To: <ZS6d+mANtuhoAcuX@lizhi-Precision-Tower-5810>
References: <20231016153232.2851095-1-Frank.Li@nxp.com>
        <20231016153232.2851095-7-Frank.Li@nxp.com>
        <20231017163335.16770af2@xps-13>
        <ZS6d+mANtuhoAcuX@lizhi-Precision-Tower-5810>
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

Frank.li@nxp.com wrote on Tue, 17 Oct 2023 10:45:14 -0400:

> On Tue, Oct 17, 2023 at 04:33:35PM +0200, Miquel Raynal wrote:
> > Hi Frank,
> >=20
> > Frank.Li@nxp.com wrote on Mon, 16 Oct 2023 11:32:32 -0400:
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
> > >   - IBI manual is used and no decision was made.
> > >   The maximum stall period is 10 KHz or 100 =CE=BCs.
> > >=20
> > > This is a just warning. System irq thread schedule latency is possibl=
e =20
> >=20
> > 							can be bigger =20
> > > bigger than 100us. Just omit this waring. =20
> >=20
> > I'm not sure this is the correct approach. It's a real issue but there
> > is not much we can do about it. Perhaps dev_err is too high, but I
> > would not entirely drop this message. Maybe a comment and turning the
> > message into a dbg printk would be more appropriate? =20
>=20
> The key is not message. It return true, means IBI/HJ thread will not run.

But why should the workers run if it's too late?

Thanks,
Miqu=C3=A8l
