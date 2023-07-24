Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A9675F574
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 13:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjGXLv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 07:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjGXLv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 07:51:26 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A81E54;
        Mon, 24 Jul 2023 04:51:24 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 13E6A2000B;
        Mon, 24 Jul 2023 11:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1690199482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=swBC1u58UcJrYvXzFzmEWYLfz7PfdG+uUqjDujcLpw8=;
        b=jwUbBSovrWXMt0eCf+HkdZX7N0TFiGd0HubR783jyVrAgPnQbPXrbhEdpWE8Xxk4eo09Kg
        QsnOipFtXqnjPamqsXHMrCzF0aotO/SGslxxUn4+VxO37tLz2INw2m0X2DFoJbeuOJrqDa
        tc8QcPRrSGSPbd7bQ/8VuTz3TB2Sya1mAtyvsGCCwpHqTJ+LELrhjfSX+w6GmhhYVYbZnO
        LENWRsxmvoCqSUpvIS9sS458ZNCtMkTec+iK2kREIIxkrur/qe4Kh2ri7jNWGjGUWA+Lp3
        Cp2lOrxtXcLKwW2yVNOCFFv6R4A5fNa0HtvC6mSEA+sIcdmmaHPYwbosp/gb1w==
Date:   Mon, 24 Jul 2023 13:51:18 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     "Usyskin, Alexander" <alexander.usyskin@intel.com>
Cc:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        "Lubart, Vitaly" <vitaly.lubart@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>
Subject: Re: [PATCH 1/2] mtd: use refcount to prevent corruption
Message-ID: <20230724135118.54e39faf@xps-13>
In-Reply-To: <CY5PR11MB6366C254F767B6C432C98A0CED02A@CY5PR11MB6366.namprd11.prod.outlook.com>
References: <20230620131905.648089-1-alexander.usyskin@intel.com>
        <20230620131905.648089-2-alexander.usyskin@intel.com>
        <TYWPR01MB87756794A30EB389AB017EB1C234A@TYWPR01MB8775.jpnprd01.prod.outlook.com>
        <20230715174112.3909e43f@xps-13>
        <CY5PR11MB63666C8DA33C93E1DC3BCB21ED3AA@CY5PR11MB6366.namprd11.prod.outlook.com>
        <20230716153926.5e975231@xps-13>
        <CY5PR11MB6366C254F767B6C432C98A0CED02A@CY5PR11MB6366.namprd11.prod.outlook.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

alexander.usyskin@intel.com wrote on Mon, 24 Jul 2023 11:43:59 +0000:

> > > > > With this patch applied, when I load up the module, I get the sam=
e 3
> > > > > devices:
> > > > > /dev/mtd0
> > > > > /dev/mtd0ro
> > > > > /dev/mtdblock0
> > > > >
> > > > > Upon removal, the below 2 devices still hang around:
> > > > > /dev/mtd0
> > > > > /dev/mtd0ro =20
> > > > =20
> > > Our use-case do not produce mtdblock, maybe there are some imbalances=
 =20
> > of get/put? =20
> > > I have somewhere version with pr_debug after every kref_get/put. That=
 may =20
> > help to catch where =20
> > > it missed, I hope. =20
> >=20
> > I believe mtdblock is the good citizen here. Just disable
> > CONFIG_MTD_BLOCK from your configuration and you will likely observe
> > the same issue, just a bit narrowed, perhaps. Indeed, if you manage to
> > follow all the get/put calls it can help to find an imbalance.
> >=20
> > Thanks,
> > Miqu=C3=A8l =20
>=20
> Miquel, do you have CONFIG_MTD_PARTITIONED_MASTER set in your config?

Not sure I get your question. You can enable or disable it, it should
work in both cases (yet, the handling is of course a bit different as
the top level device will be retained/not retained).

Thanks,
Miqu=C3=A8l
