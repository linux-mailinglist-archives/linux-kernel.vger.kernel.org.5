Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC337646A1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 08:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbjG0GTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 02:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjG0GTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 02:19:49 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4362F1FED;
        Wed, 26 Jul 2023 23:19:26 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 334DE1BF208;
        Thu, 27 Jul 2023 06:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1690438758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qskc8UL7HpZtZS2sXdp6DAYX33Iw0SkA6UUJwMFN1pc=;
        b=MQ0XLEXe41fjTls2Ua+EtFbn5ci6ACukYOsA5oI8CXGsqok8uG8giYHxAruqtu7zDUPPux
        nSQuSUKMgQLcH2Eiy/Uh8gd0/SYBhgXC+61KeB1mQUMz42yetKDk8Hos1WrFB6y/Jkqin9
        T7krT175sF10KnPzoxC9sp2OHE5iPgYvnqFUZPd2kNeS8tr/5EeJbEg7GKAEUXW/PtVfm4
        tHn6XncNABpQORtDSCONGiZMHqvgA7YsARmbNRo+un8syOWAgts7U3wohC38L+SPFSCO/r
        vmjWsCUXPi5CfftItyX2o8PWcZMLB8L36WlK93cuXAQRN0HPqoZyIL8gDV1xeQ==
Date:   Thu, 27 Jul 2023 08:19:14 +0200
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
Message-ID: <20230727081914.03e44b96@xps-13>
In-Reply-To: <CY5PR11MB636670FCA46F7F68F21AF44BED03A@CY5PR11MB6366.namprd11.prod.outlook.com>
References: <20230620131905.648089-1-alexander.usyskin@intel.com>
        <20230620131905.648089-2-alexander.usyskin@intel.com>
        <TYWPR01MB87756794A30EB389AB017EB1C234A@TYWPR01MB8775.jpnprd01.prod.outlook.com>
        <20230715174112.3909e43f@xps-13>
        <CY5PR11MB63666C8DA33C93E1DC3BCB21ED3AA@CY5PR11MB6366.namprd11.prod.outlook.com>
        <20230716153926.5e975231@xps-13>
        <CY5PR11MB6366C254F767B6C432C98A0CED02A@CY5PR11MB6366.namprd11.prod.outlook.com>
        <20230724135118.54e39faf@xps-13>
        <CY5PR11MB6366FB890508D05E1D1C1375ED02A@CY5PR11MB6366.namprd11.prod.outlook.com>
        <CY5PR11MB636670FCA46F7F68F21AF44BED03A@CY5PR11MB6366.namprd11.prod.outlook.com>
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

alexander.usyskin@intel.com wrote on Tue, 25 Jul 2023 12:50:04 +0000:

> Hi
> >=20
> > Hi Miquel, =20
> > >
> > > Hi Alexander,
> > >
> > > alexander.usyskin@intel.com wrote on Mon, 24 Jul 2023 11:43:59 +0000:
> > > =20
> > > > > > > > With this patch applied, when I load up the module, I get t=
he same 3
> > > > > > > > devices:
> > > > > > > > /dev/mtd0
> > > > > > > > /dev/mtd0ro
> > > > > > > > /dev/mtdblock0
> > > > > > > >
> > > > > > > > Upon removal, the below 2 devices still hang around:
> > > > > > > > /dev/mtd0
> > > > > > > > /dev/mtd0ro =20
> > > > > > > =20
> > > > > > Our use-case do not produce mtdblock, maybe there are some =20
> > > imbalances =20
> > > > > of get/put? =20
> > > > > > I have somewhere version with pr_debug after every kref_get/put=
. That =20
> > > may =20
> > > > > help to catch where =20
> > > > > > it missed, I hope. =20
> > > > >
> > > > > I believe mtdblock is the good citizen here. Just disable
> > > > > CONFIG_MTD_BLOCK from your configuration and you will likely obse=
rve
> > > > > the same issue, just a bit narrowed, perhaps. Indeed, if you mana=
ge to
> > > > > follow all the get/put calls it can help to find an imbalance.
> > > > >
> > > > > Thanks,
> > > > > Miqu=C3=A8l =20
> > > >
> > > > Miquel, do you have CONFIG_MTD_PARTITIONED_MASTER set in your =20
> > > config?
> > >
> > > Not sure I get your question. You can enable or disable it, it should
> > > work in both cases (yet, the handling is of course a bit different as
> > > the top level device will be retained/not retained).
> > >
> > > Thanks,
> > > Miqu=C3=A8l =20
> >=20
> > I'm trying to understand why I can't reproduce the problem in my scenar=
io.
> > I found an important difference in upstreamed patch and internal versio=
n:
> > The IS_ENABLED(CONFIG_MTD_PARTITIONED_MASTER) check around
> > kref_get/put does not exists in the internal tree.
> > The code before my patch do not have such check, so I tend to assume th=
at
> > this check should be removed.
> > If you reproduce happens with CONFIG_MTD_PARTITIONED_MASTER
> > disabled that may explain problems that you see.
> >=20
> > --
> > Thanks,
> > Sasha
> >  =20
>=20
> I've tried to reproduce this with latest Linux 6.5-rc1 and my two patches.
> The manual modprobe mtdblock creates mtdblock0 over my partitions too.
> I can't reproduce problem neither with MTD_PARTITIONED_MASTER nor without.
>=20
> Let's try to debug on your system, can you enable dynamic debug for mtd s=
ubsystem,
> reproduce and publish dmesg?
>=20
> The prints for kref get/put can be added as below:
>=20
> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> index 2466ea466466..374835831428 100644
> --- a/drivers/mtd/mtdcore.c
> +++ b/drivers/mtd/mtdcore.c
> @@ -1242,10 +1242,13 @@ int __get_mtd_device(struct mtd_info *mtd)
>         }
>=20
>         kref_get(&mtd->refcnt);
> +       pr_debug("get mtd %s %d\n", mtd->name, kref_read(&mtd->refcnt));
>=20
>         while (mtd->parent) {
> -               if (IS_ENABLED(CONFIG_MTD_PARTITIONED_MASTER) || mtd->par=
ent !=3D master)
> +               if (IS_ENABLED(CONFIG_MTD_PARTITIONED_MASTER) || mtd->par=
ent !=3D master) {
>                         kref_get(&mtd->parent->refcnt);
> +                       pr_debug("get mtd %s %d\n", mtd->parent->name, kr=
ef_read(&mtd->parent->refcnt));
> +               }
>                 mtd =3D mtd->parent;
>         }
>=20
> @@ -1335,12 +1338,15 @@ void __put_mtd_device(struct mtd_info *mtd)
>         while (mtd !=3D master) {
>                 struct mtd_info *parent =3D mtd->parent;
>=20
> +               pr_debug("put mtd %s %d\n", mtd->name, kref_read(&mtd->re=
fcnt));
>                 kref_put(&mtd->refcnt, mtd_device_release);
>                 mtd =3D parent;
>         }
>=20
> -       if (IS_ENABLED(CONFIG_MTD_PARTITIONED_MASTER))
> +       if (IS_ENABLED(CONFIG_MTD_PARTITIONED_MASTER)) {
> +               pr_debug("put mtd %s %d\n", master->name, kref_read(&mast=
er->refcnt));
>                 kref_put(&master->refcnt, mtd_device_release);
> +       }
>=20
>         module_put(master->owner);
>=20
>=20

Could this be helpful?

https://lore.kernel.org/all/20230725215539.3135304-1-zhangxiaoxu5@huawei.co=
m/

If you successfully test it, please send your Tested-by.

Thanks,
Miqu=C3=A8l
