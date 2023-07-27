Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115B5764756
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 08:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbjG0Gzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 02:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbjG0Gzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 02:55:46 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE58B2691;
        Wed, 26 Jul 2023 23:55:38 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7E0E6FF80B;
        Thu, 27 Jul 2023 06:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1690440937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iaoRwisGb1LeT0J1HXstF48SClPZihmj6ym+68S17do=;
        b=l90Y1H6pOsIPnIDn+VQC0szMd6PblujD6glk86LG+HmW512c/Emybl+IVnV92APVgKr/GX
        rnWNyGLy0sZpRHL9Wt0Jn88kPIbnxBlcTIm43AZLJqsBmDx4bru8jftthPu17xfVT4jC2r
        KCfyy3lv42X1/dlbHvv53dCMgsm8qSwgIdTqldeSG2L/yIo4tQakTszXHBD9/WjGdv3Yyx
        iCzh3ad1rgBWeuMXqKJAbF/nKY6iQHKXrwpUxNcj0PG/SacEGT6cjuMzctaN21HdtmtVly
        r7aOUcNpcdD14fsnPpO15NNTvBpdXcuIHYD2FGi8l45zvUgC3j8qJXQTI6/PKw==
Date:   Thu, 27 Jul 2023 08:55:30 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     "Winkler, Tomas" <tomas.winkler@intel.com>
Cc:     "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Lubart, Vitaly" <vitaly.lubart@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
Subject: Re: [PATCH 1/2] mtd: use refcount to prevent corruption
Message-ID: <20230727085530.486dd356@xps-13>
In-Reply-To: <MN2PR11MB40937D15FE4076D5F73570B5E501A@MN2PR11MB4093.namprd11.prod.outlook.com>
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
        <20230727081914.03e44b96@xps-13>
        <MN2PR11MB40937D15FE4076D5F73570B5E501A@MN2PR11MB4093.namprd11.prod.outlook.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomas,

tomas.winkler@intel.com wrote on Thu, 27 Jul 2023 06:32:39 +0000:

> >=20
> > Hi Alexander,
> >=20
> > alexander.usyskin@intel.com wrote on Tue, 25 Jul 2023 12:50:04 +0000:
> >=20
> > > Hi
> > > >
> > > > Hi Miquel,
> > > > >
> > > > > Hi Alexander,
> > > > >
> > > > > alexander.usyskin@intel.com wrote on Mon, 24 Jul 2023 11:43:59
> > +0000:
> > > > >
> > > > > > > > > > With this patch applied, when I load up the module, I
> > > > > > > > > > get the same 3
> > > > > > > > > > devices:
> > > > > > > > > > /dev/mtd0
> > > > > > > > > > /dev/mtd0ro
> > > > > > > > > > /dev/mtdblock0
> > > > > > > > > >
> > > > > > > > > > Upon removal, the below 2 devices still hang around:
> > > > > > > > > > /dev/mtd0
> > > > > > > > > > /dev/mtd0ro
> > > > > > > > >
> > > > > > > > Our use-case do not produce mtdblock, maybe there are some
> > > > > imbalances
> > > > > > > of get/put?
> > > > > > > > I have somewhere version with pr_debug after every
> > > > > > > > kref_get/put. That
> > > > > may
> > > > > > > help to catch where
> > > > > > > > it missed, I hope.
> > > > > > >
> > > > > > > I believe mtdblock is the good citizen here. Just disable
> > > > > > > CONFIG_MTD_BLOCK from your configuration and you will likely
> > > > > > > observe the same issue, just a bit narrowed, perhaps. Indeed,
> > > > > > > if you manage to follow all the get/put calls it can help to =
find an
> > imbalance.
> > > > > > >
> > > > > > > Thanks,
> > > > > > > Miqu=C3=A8l
> > > > > >
> > > > > > Miquel, do you have CONFIG_MTD_PARTITIONED_MASTER set in your
> > > > > config?
> > > > >
> > > > > Not sure I get your question. You can enable or disable it, it
> > > > > should work in both cases (yet, the handling is of course a bit
> > > > > different as the top level device will be retained/not retained).
> > > > >
> > > > > Thanks,
> > > > > Miqu=C3=A8l
> > > >
> > > > I'm trying to understand why I can't reproduce the problem in my
> > scenario.
> > > > I found an important difference in upstreamed patch and internal ve=
rsion:
> > > > The IS_ENABLED(CONFIG_MTD_PARTITIONED_MASTER) check around
> > > > kref_get/put does not exists in the internal tree.
> > > > The code before my patch do not have such check, so I tend to assume
> > > > that this check should be removed.
> > > > If you reproduce happens with CONFIG_MTD_PARTITIONED_MASTER
> > disabled
> > > > that may explain problems that you see.
> > > >
> > > > --
> > > > Thanks,
> > > > Sasha
> > > >
> > >
> > > I've tried to reproduce this with latest Linux 6.5-rc1 and my two pat=
ches.
> > > The manual modprobe mtdblock creates mtdblock0 over my partitions too.
> > > I can't reproduce problem neither with MTD_PARTITIONED_MASTER nor
> > without.
> > >
> > > Let's try to debug on your system, can you enable dynamic debug for
> > > mtd subsystem, reproduce and publish dmesg?
> > >
> > > The prints for kref get/put can be added as below:
> > >
> > > diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c index
> > > 2466ea466466..374835831428 100644
> > > --- a/drivers/mtd/mtdcore.c
> > > +++ b/drivers/mtd/mtdcore.c
> > > @@ -1242,10 +1242,13 @@ int __get_mtd_device(struct mtd_info *mtd)
> > >         }
> > >
> > >         kref_get(&mtd->refcnt);
> > > +       pr_debug("get mtd %s %d\n", mtd->name,
> > > + kref_read(&mtd->refcnt));
> > >
> > >         while (mtd->parent) {
> > > -               if (IS_ENABLED(CONFIG_MTD_PARTITIONED_MASTER) || mtd-
> > >parent !=3D master)
> > > +               if (IS_ENABLED(CONFIG_MTD_PARTITIONED_MASTER) ||
> > > + mtd->parent !=3D master) {
> > >                         kref_get(&mtd->parent->refcnt);
> > > +                       pr_debug("get mtd %s %d\n", mtd->parent->name,
> > kref_read(&mtd->parent->refcnt));
> > > +               }
> > >                 mtd =3D mtd->parent;
> > >         }
> > >
> > > @@ -1335,12 +1338,15 @@ void __put_mtd_device(struct mtd_info
> > *mtd)
> > >         while (mtd !=3D master) {
> > >                 struct mtd_info *parent =3D mtd->parent;
> > >
> > > +               pr_debug("put mtd %s %d\n", mtd->name,
> > > + kref_read(&mtd->refcnt));
> > >                 kref_put(&mtd->refcnt, mtd_device_release);
> > >                 mtd =3D parent;
> > >         }
> > >
> > > -       if (IS_ENABLED(CONFIG_MTD_PARTITIONED_MASTER))
> > > +       if (IS_ENABLED(CONFIG_MTD_PARTITIONED_MASTER)) {
> > > +               pr_debug("put mtd %s %d\n", master->name,
> > > + kref_read(&master->refcnt));
> > >                 kref_put(&master->refcnt, mtd_device_release);
> > > +       }
> > >
> > >         module_put(master->owner);
> > >
> > >
> >=20
> > Could this be helpful?
> >=20
> > https://lore.kernel.org/all/20230725215539.3135304-1-
> > zhangxiaoxu5@huawei.com/
> >=20
> > If you successfully test it, please send your Tested-by.
> In the first glance it doesn't look correct, we have the reproduced using=
 kasan, so hopefully the fix will follow, shortly.=20
> Thanks
> Tomas
>=20

Why is this fix not correct?

Are you currently writing a fix yourself?

Thanks,
Miqu=C3=A8l
