Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072C77DACB0
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 14:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjJ2Nul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 09:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjJ2Nul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 09:50:41 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28ACBF
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 06:50:38 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E3E9A1C0002;
        Sun, 29 Oct 2023 13:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698587437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a8GUOXz37gmy7V60xc0vXGGHZfnk3OdOvT79FlC7134=;
        b=mfONVS8KKgVpPDsG2UxTeARpH67UWrtTtpDs9R51IzEyfokr5ZYmAuLqDkavfv4X8e/5nz
        wOaBH1is4G/xKU0EFcN3IZmotkkPcfA0eSqBotus/a3cuqKBE1JbbXED3coiE4erZIUfQN
        uRP/IQcWCJxAGLAfpM9QZuv+sLSrA5NroZidmVrRGcU7eoRIsfFQJqV/m1lYU4gRAw8duG
        wu5UDvLEmLIZCORJUARuXrj7VV0iQ2Yx5w8HAZs1tLJQAZ7D0DcklrSTPlkqnvCzdnL04M
        ClCKzxNTC6eoXADbGVKEjE5vI9GF+iZtbir6EDd2uUT6Ya3Tzo5tfHowWzRMNw==
Date:   Sun, 29 Oct 2023 14:50:33 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Richard Weinberger <richard@nod.at>
Cc:     ZhaoLong Wang <wangzhaolong1@huawei.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Artem Bityutskiy <Artem.Bityutskiy@nokia.com>,
        dpervushin <dpervushin@embeddedalley.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        chengzhihao1 <chengzhihao1@huawei.com>,
        yi zhang <yi.zhang@huawei.com>,
        yangerkun <yangerkun@huawei.com>
Subject: Re: [PATCH v3] mtd: Fix gluebi NULL pointer dereference caused by
 ftl notifier
Message-ID: <20231029145033.0ad2682a@xps-13>
In-Reply-To: <174426702.13324.1698438610904.JavaMail.zimbra@nod.at>
References: <20231027012033.50280-1-wangzhaolong1@huawei.com>
        <20231027194026.1bc32dfe@xps-13>
        <174426702.13324.1698438610904.JavaMail.zimbra@nod.at>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

richard@nod.at wrote on Fri, 27 Oct 2023 22:30:10 +0200 (CEST):

> ----- Urspr=C3=BCngliche Mail -----
> > Von: "Miquel Raynal" <miquel.raynal@bootlin.com> =20
> >> Detailed reproduction information available at the link[1],
> >>=20
> >> The solution for the gluebi module is to run jffs2 on the UBI
> >> volume without considering working with ftl or mtdblock.[2]. =20
> >=20
> > I am sorry but ftl, gluebi, mtdblock, jffs2 and ubi in the same report
> > seem a little bit fuzzy. Are you sure about this sentence? =20
>=20
> ZhaoLong Wang found an interesting bug while stacking various MTD compone=
nts.
> I suggested to just deny mtdblock on top of gluebi to avoid the whole
> problem class instead of adding more duct tape.

Ack. I'll queue this once the log fixed and your official Ack-by
received for mtd/next after -rc1 is out.

Thanks,
Miqu=C3=A8l

>=20
> Thanks,
> //richard
>=20
> The issue reminds me of one of my favorite Monty Python sketches, https:/=
/www.youtube.com/watch?v=3DLFrdqQZ8FFc
> ;-)

:-)
