Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B527ADA2E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 16:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbjIYOhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 10:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjIYOhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 10:37:38 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF4310F
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 07:37:30 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D02DA20009;
        Mon, 25 Sep 2023 14:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695652648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i3+LixSqqx+eUisQwtB8vxyT/PxtNa6xGTET70xDIx0=;
        b=a4wvC5BI70bJmoDokE6yOU9x6oXiJgJ/IMy+RGwgm47EIwefgyRs1qykE8bKicsrZoB+zN
        L2k0QIMltWN2j5t4l42ch7ymG74q7WdjpkKlpayVWqRRAjHlwht9ftoJEyPKEkcIN6qv/w
        RL7vmZK7GBHIH1LLZ8RTOymCt52da28/58kuEz1RkGUKkIpeYURQ+689LLffL4SpV/0VLS
        sbBAVqHADlNgZKjvVyJdbpjcg2UAoQWlddy9yaSL8yzfJbCVax+J3nofjkiCi95OH+sFfC
        x11TSDn+d4FYToZQNlBQiVRLfRaVrvhfwqDWTzyT3uYnzwz97Dq5qkodB4rDlQ==
Date:   Mon, 25 Sep 2023 16:37:27 +0200
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
Message-ID: <20230925163727.7ecebe9a@xps-13>
In-Reply-To: <1131184426.81026.1695650583370.JavaMail.zimbra@nod.at>
References: <20230923005856.2538223-1-wangzhaolong1@huawei.com>
        <1131184426.81026.1695650583370.JavaMail.zimbra@nod.at>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

richard@nod.at wrote on Mon, 25 Sep 2023 16:03:03 +0200 (CEST):

> ----- Urspr=C3=BCngliche Mail -----
> > Von: "ZhaoLong Wang" <wangzhaolong1@huawei.com>
> > An: "Miquel Raynal" <miquel.raynal@bootlin.com>, "richard" <richard@nod=
.at>, "Vignesh Raghavendra" <vigneshr@ti.com>
> > CC: "linux-mtd" <linux-mtd@lists.infradead.org>, "linux-kernel" <linux-=
kernel@vger.kernel.org>, "chengzhihao1"
> > <chengzhihao1@huawei.com>, "ZhaoLong Wang" <wangzhaolong1@huawei.com>, =
"yi zhang" <yi.zhang@huawei.com>, "yangerkun"
> > <yangerkun@huawei.com>
> > Gesendet: Samstag, 23. September 2023 02:58:56
> > Betreff: [RFC] mtd: Fix error code loss in mtdchar_read() function. =20
>=20
> > In the first while loop, if the mtd_read() function returns -EBADMSG
> > and 'retlen' returns 0, the loop break and the function returns value
> > 'total_retlen' is 0, not the error code. =20
>=20
> Given this a second thought. I don't think a NAND driver is allowed to re=
turn
> less than requests bytes and setting EBADMSG.
> UBI's IO path has a comment on that:
>=20
>                 /*
>                  * The driver should never return -EBADMSG if it failed t=
o read
>                  * all the requested data. But some buggy drivers might do
>                  * this, so we change it to -EIO.
>                  */
>                 if (read !=3D len && mtd_is_eccerr(err)) {
>                         ubi_assert(0);
>                         err =3D -EIO;
>                 }

Interesting. Shall we add this check to the mtd_read() path as well?

Maybe with a WARN_ON()?

Thanks,
Miqu=C3=A8l
