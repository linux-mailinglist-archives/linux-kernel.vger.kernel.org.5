Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C107856DA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 13:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234267AbjHWLkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 07:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233297AbjHWLkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 07:40:04 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B639CE5D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 04:40:01 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1401420007;
        Wed, 23 Aug 2023 11:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1692790799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ho7TkRgdIeEdFaf/yC/PngT3UYUxETx2tgKarf9Ap/A=;
        b=mZ7cQ//oS2s2+GitJPAtXWFQ1Z+kaNmLfRFqA9qXI8L6QBDM/HhbXwUTTZBEjSRKjsGUab
        tEL6y6QkQ1b048xUjLI6LfXO5j0FFEj3cifwPTSYYoZTeSb/4o/afesTLqMNiD0826XCXM
        zGu32uZb/cokApji4hVe5bYIAqc0B8jUAfbjn34n5jMLHk/fyvSpXV/zObfNgKNiLQDEYW
        PVLLjlnWAjrfTZrykaXJnqBkBLd2EndL96jEgbTIHD0tlvR8nBmz/vB1aHW2RNvIL1ypvJ
        0q7qBncH7HI/cXvm2M8/I5/ImfwrDjcO5PHB4qOmAzg5LJaktjwDHbhz84CwwQ==
Date:   Wed, 23 Aug 2023 13:39:56 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Martin Kurbanov <mmkurbanov@sberdevices.ru>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <kernel@sberdevices.ru>
Subject: Re: [PATCH v2 2/2] mtd: spinand: micron: fixing the offset for OOB
Message-ID: <20230823133956.0a505a20@xps-13>
In-Reply-To: <f873d775-cda9-302d-a651-0113c7c7dc84@sberdevices.ru>
References: <20230822122534.872646-1-mmkurbanov@sberdevices.ru>
        <20230822122534.872646-3-mmkurbanov@sberdevices.ru>
        <20230822153556.630e65b9@xps-13>
        <01925ff8-1d19-a729-429a-89866fad319f@sberdevices.ru>
        <20230823104143.760cc5bc@xps-13>
        <f873d775-cda9-302d-a651-0113c7c7dc84@sberdevices.ru>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

mmkurbanov@sberdevices.ru wrote on Wed, 23 Aug 2023 14:33:57 +0300:

> Hi Miquel,
>=20
> On 23.08.2023 11:41, Miquel Raynal wrote:
> > Hi Martin,
> >
> > I don't think the four bytes have any "bad block specific" meaning. In
> > practice, the datasheet states:
> >=20
> > 	Value programmed for bad block at the first byte of spare
> > 	area: 00h
> >=20
> > So only the first byte is used to mark the block bad, the rest is
> > probably marked "reserved" for simplicity. I believe we should keep the
> > current layout because it would otherwise break users for no real
> > reason. =20
>=20
> I agree with you that this can break the work of users who use OOB.
> However, I believe it would be more appropriate to use an offset of 4,
> as the micron chip can use all 4 bytes for additional data about the
> bad block. So, there is a non-zero probability of losing OOB data in
> the reserved area (2 bytes) when the hardware chip attempts to mark
> the block as bad.

Is this really a process the chip can do? Aren't bad blocks factory
marked only?

Then it's mtd's duty to manage them.

Thanks,
Miqu=C3=A8l
