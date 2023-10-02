Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B447B54AD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 16:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237559AbjJBNuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 09:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237567AbjJBNuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 09:50:06 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2A11B1;
        Mon,  2 Oct 2023 06:49:49 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5AA4324000D;
        Mon,  2 Oct 2023 13:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696254587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4paVPeEF9ZLJzDxaKPdD/mR7tqf5kQ9/5kHc/DvHhlA=;
        b=UIU5d6aGGKL6D6KCkhLdPeAbU+VlRdNenyDOL4h5JCr7mdCK0cF81jnxFzn2VZAApdGu9V
        /TdCXnRvnYb0PQlvWdeLsivGVY7GG7UCQLl2ZcmHfnhYv3V6wB/nGglgx1pQ6blCu7HQzY
        HiI2Qbpr4JbVZHT8+ya6BWHZ5jeDlSECvN0w7u1m27DbmzULPWoRe+6+CnLGYeziNZyr8E
        LbJ5g/1+Clz/d/6ZE9GXNXScrYSSO1XtHVEPdamxnDHp5J/k87l8FIBvfFhYX4epsZOmvM
        6fGlpXEDsqBIWuL81FXIPBCaVJT2iRZGz/5xRKfdFx5x1Sw78gBfrkkAcqrDAw==
Date:   Mon, 2 Oct 2023 15:49:43 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Martin =?UTF-8?B?SHVuZGViw7hsbA==?= <martin@geanix.com>
Cc:     Rouven Czerwinski <r.czerwinski@pengutronix.de>,
        =?UTF-8?B?TcOlbnMg?= =?UTF-8?B?UnVsbGfDpXJk?= <mans@mansr.com>,
        Alexander Shiyan <eagle.alexander923@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        JaimeLiao <jaimeliao.tw@gmail.com>, kernel@pengutronix.de,
        stable@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Sean =?UTF-8?B?Tnlla2rDpnI=?= <sean@geanix.com>,
        Domenico Punzo <dpunzo@micron.com>,
        Bean Huo <beanhuo@micron.com>
Subject: Re: [PATCH v2] mtd: rawnand: Ensure the nand chip supports cached
 reads
Message-ID: <20231002154943.361e31b0@xps-13>
In-Reply-To: <b8de26e243afa3e5920455a4d8e5a3451a06d074.camel@geanix.com>
References: <20230922141717.35977-1-r.czerwinski@pengutronix.de>
        <e911f5d9c7def8c80904a17ad3924ecba6625998.camel@geanix.com>
        <20230926132725.5d570e1b@xps-13>
        <20230927170516.2604e8f2@xps-13>
        <b8de26e243afa3e5920455a4d8e5a3451a06d074.camel@geanix.com>
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

Hi Martin,

martin@geanix.com wrote on Thu, 28 Sep 2023 09:19:56 +0200:

> Hi Miquel,
>=20
> On Wed, 2023-09-27 at 17:05 +0200, Miquel Raynal wrote:
> > Hi Martin,
> >=20
> > miquel.raynal@bootlin.com=C2=A0wrote on Tue, 26 Sep 2023 13:27:25 +0200:
> >  =20
> > > Hi Martin,
> > >=20
> > > + Bean and Domenico, there is a question for you below.
> > >=20
> > > martin@geanix.com=C2=A0wrote on Mon, 25 Sep 2023 13:01:06 +0200:
> > >  =20
> > > > Hi Rouven,
> > > >=20
> > > > On Fri, 2023-09-22 at 16:17 +0200, Rouven Czerwinski wrote:=C2=A0  =
=20
> > > > > Both the JEDEC and ONFI specification say that read cache
> > > > > sequential
> > > > > support is an optional command. This means that we not only
> > > > > need to
> > > > > check whether the individual controller supports the command,
> > > > > we also
> > > > > need to check the parameter pages for both ONFI and JEDEC NAND
> > > > > flashes
> > > > > before enabling sequential cache reads.
> > > > >=20
> > > > > This fixes support for NAND flashes which don't support
> > > > > enabling
> > > > > cache
> > > > > reads, i.e. Samsung K9F4G08U0F or Toshiba TC58NVG0S3HTA00.
> > > > >=20
> > > > > Sequential cache reads are now only available for ONFI and
> > > > > JEDEC
> > > > > devices, if individual vendors implement this, it needs to be
> > > > > enabled
> > > > > per vendor.
> > > > >=20
> > > > > Tested on i.MX6Q with a Samsung NAND flash chip that doesn't
> > > > > support
> > > > > sequential reads.
> > > > >=20
> > > > > Fixes: 003fe4b9545b ("mtd: rawnand: Support for sequential
> > > > > cache
> > > > > reads")
> > > > > Cc: stable@vger.kernel.org
> > > > > Signed-off-by: Rouven Czerwinski
> > > > > <r.czerwinski@pengutronix.de>=C2=A0=C2=A0=C2=A0  =20
> > > >=20
> > > > Thanks for this. It works as expected for my Toshiba chip,
> > > > obviously
> > > > because it doesn't use ONFI or JEDEC.
> > > >=20
> > > > Unfortunately, my Micron chip does use ONFI, and it sets the
> > > > cached-
> > > > read-supported bit. It then fails when reading afterwords: =20
> >=20
> > I might have over reacted regarding my findings in Micron's
> > datasheet,
> > I need to know if you use the on-die ECC engine or if you use the one
> > on the controller. In the former case the failure is expected. In the
> > latter case, it's not. =20
>=20
> I use the default, which seems to be the controller engine?

Yeah, you're using the gpmi NAND controller right? If that's the case,
it seems that only ECC correction is supported.

Thanks,
Miqu=C3=A8l
