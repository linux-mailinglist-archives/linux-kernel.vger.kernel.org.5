Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE4F7ADAE7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbjIYPGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbjIYPGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:06:53 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4C710E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:06:46 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6555FFF803;
        Mon, 25 Sep 2023 15:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695654405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rx/EG4jd4jHL2lV5ytyB7NVrkU81Ryi4t8x6wQD0E/E=;
        b=HsdV5A7S5Cgx7iUEk3lGCspxarqh1ho6CpXYqe/XNNmsKYYGuLVxCixkU9gbapjj4FzsMb
        SUE+yJ3BxURbBBgiCRzCdLACu4dQbvSDPNd4nB0hofgVbjzpiZYyMU6TmqRpAbtJFvLU3T
        3f/pGSp6GtmFp/WN2HfSL7p7k2727RHv3pQFXe71L/X+Y3tohV/3qBMNT9LnlXGqPPG6vN
        ZjQYgJNTBURvL+ONmsaAcNsYa8tOT6vQRoE0uStY/dm5J6/d1WSPI1yRQrB0700uTkNUgL
        jrqJkmxuXFA0z0pHXddE3UsglfFXUU4xOEHu4pO+0R02Ts8EuM4fYxvETQB50A==
Date:   Mon, 25 Sep 2023 17:06:42 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Richard Weinberger <richard@nod.at>
Cc:     ZhaoLong Wang <wangzhaolong1@huawei.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        chengzhihao1 <chengzhihao1@huawei.com>,
        yi zhang <yi.zhang@huawei.com>,
        yangerkun <yangerkun@huawei.com>
Subject: Re: [RFC] mtd: Fix error code loss in mtdchar_read() function.
Message-ID: <20230925170642.089e543b@xps-13>
In-Reply-To: <488305749.81257.1695653971403.JavaMail.zimbra@nod.at>
References: <20230923005856.2538223-1-wangzhaolong1@huawei.com>
        <1131184426.81026.1695650583370.JavaMail.zimbra@nod.at>
        <20230925163727.7ecebe9a@xps-13>
        <488305749.81257.1695653971403.JavaMail.zimbra@nod.at>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


richard@nod.at wrote on Mon, 25 Sep 2023 16:59:31 +0200 (CEST):

> ----- Urspr=C3=BCngliche Mail -----
> > Von: "Miquel Raynal" <miquel.raynal@bootlin.com> =20
> >> Given this a second thought. I don't think a NAND driver is allowed to=
 return
> >> less than requests bytes and setting EBADMSG.
> >> UBI's IO path has a comment on that:
> >>=20
> >>                 /*
> >>                  * The driver should never return -EBADMSG if it faile=
d to read
> >>                  * all the requested data. But some buggy drivers migh=
t do
> >>                  * this, so we change it to -EIO.
> >>                  */
> >>                 if (read !=3D len && mtd_is_eccerr(err)) {
> >>                         ubi_assert(0);
> >>                         err =3D -EIO;
> >>                 } =20
> >=20
> > Interesting. Shall we add this check to the mtd_read() path as well?
> >=20
> > Maybe with a WARN_ON()? =20
>=20
> WARN_ON_ONCE(), please. But yes, let's add it.

Zhaolong, can you take care of it?

>=20
> Thanks,
> //richard


Thanks,
Miqu=C3=A8l
