Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8337549DA
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 17:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjGOPl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 11:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjGOPlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 11:41:25 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9282D7B;
        Sat, 15 Jul 2023 08:41:22 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0794BC0004;
        Sat, 15 Jul 2023 15:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689435679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dx1hsltG+GS7GVxSpUxmJ8g4K6vQcrTXG0/HvBc/tbU=;
        b=A0YL2XjHakazCSZxBEAgvvFz+zO/q6MvW/VWQbL4uXtrm77eLe7cnit7/T8i/AuGOl7OmT
        YN++8QaxP9uM3tgqSVdbFUnWRWqxsOJV5bWYasJpx+Cy1LYzoD8PftOmoRYFj21IyBCAI5
        JO0t/bxRZzXCQOfu1e9sM0qCXBwrcUQdH+RihsTsFt3DIFR2JQ1cDTr+Qcmrnb0SR6Ybme
        fcXexHoisB0ENB+2rnbwpWzBjYQu7I5XizRbcqeC7dmqQaXYcWpZPzLjYOI2u7yUXhT3xr
        SXoQdjTlkuldFhbZ0dpwyQkGtKicY/Lv7sYc5w9KkLSHvhRY8j1jFssNmZ8VQQ==
Date:   Sat, 15 Jul 2023 17:41:12 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>
Subject: Re: [PATCH 1/2] mtd: use refcount to prevent corruption
Message-ID: <20230715174112.3909e43f@xps-13>
In-Reply-To: <TYWPR01MB87756794A30EB389AB017EB1C234A@TYWPR01MB8775.jpnprd01.prod.outlook.com>
References: <20230620131905.648089-1-alexander.usyskin@intel.com>
        <20230620131905.648089-2-alexander.usyskin@intel.com>
        <TYWPR01MB87756794A30EB389AB017EB1C234A@TYWPR01MB8775.jpnprd01.prod.outlook.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabrizio,

fabrizio.castro.jz@renesas.com wrote on Fri, 14 Jul 2023 16:10:45 +0000:

> Dear All,
>=20
> I am sorry for reopening this topic, but as it turns out (after bisecting
> linux-next/master) this patch is interfering with a use case I am working
> on.
>=20
> I am using a Renesas RZ/V2M EVK v2.0 platform, I have an SPI NOR memory
> ("micron,mt25ql256a") wired up to a connector on the platform, the SPI
> master is using driver (built as module):
> drivers/spi/spi-rzv2m-csi.c
>=20
> Although the board device tree in mainline does not reflect the connection
> of CSI4 (which is the SPI master) from the SoC to the "micron,mt25ql256a"
> (SPI slave device), my local device tree comes with the necessary definit=
ions.
>=20
> Without this patch, when I load up the module, I get the below 3 devices:
> /dev/mtd0
> /dev/mtd0ro
> /dev/mtdblock0
>=20
> They get cleaned up correctly upon module removal.
> I can reload the same module, and everything works just fine.
>=20
> With this patch applied, when I load up the module, I get the same 3
> devices:
> /dev/mtd0
> /dev/mtd0ro
> /dev/mtdblock0
>=20
> Upon removal, the below 2 devices still hang around:
> /dev/mtd0
> /dev/mtd0ro

Looks like the refcounting change is still not even in some cases, can
you investigate and come up with a proper patch? You can either improve
the existing patch or revert it and try your own approach if deemed
better.

Thanks,
Miqu=C3=A8l

> Preventing the module from being (re)loaded correctly:
> rzv2m_csi a4020200.spi: error -EBUSY: register controller failed
> rzv2m_csi: probe of a4020200.spi failed with error -16
>=20
> Are you guys aware of this sort of side effect?
>=20
> Thanks,
> Fab
>=20
> > From: Alexander Usyskin <alexander.usyskin@intel.com>
> > Subject: [PATCH 1/2] mtd: use refcount to prevent corruption
> >=20
> > From: Tomas Winkler <tomas.winkler@intel.com>
> >=20
> > When underlying device is removed mtd core will crash
> > in case user space is holding open handle.
> > Need to use proper refcounting so device is release
> > only when has no users.
> >=20
> > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> > ---
> >  drivers/mtd/mtdcore.c   | 72 ++++++++++++++++++++++------------------
> > -
> >  drivers/mtd/mtdcore.h   |  1 +
> >  drivers/mtd/mtdpart.c   | 14 ++++----
> >  include/linux/mtd/mtd.h |  2 +-
> >  4 files changed, 49 insertions(+), 40 deletions(-)
> >=20
> > diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> > index abf4cb58a8ab..84bd1878367d 100644
> > --- a/drivers/mtd/mtdcore.c
> > +++ b/drivers/mtd/mtdcore.c
> > @@ -93,10 +93,33 @@ static void mtd_release(struct device *dev)
> >  	struct mtd_info *mtd =3D dev_get_drvdata(dev);
> >  	dev_t index =3D MTD_DEVT(mtd->index);
> >=20
> > +	if (mtd_is_partition(mtd))
> > +		release_mtd_partition(mtd);
> > +
> >  	/* remove /dev/mtdXro node */
> >  	device_destroy(&mtd_class, index + 1);
> >  }
> >=20
> > +static void mtd_device_release(struct kref *kref)
> > +{
> > +	struct mtd_info *mtd =3D container_of(kref, struct mtd_info,
> > refcnt);
> > +
> > +	debugfs_remove_recursive(mtd->dbg.dfs_dir);
> > +
> > +	/* Try to remove the NVMEM provider */
> > +	nvmem_unregister(mtd->nvmem);
> > +
> > +	device_unregister(&mtd->dev);
> > +
> > +	/* Clear dev so mtd can be safely re-registered later if desired
> > */
> > +	memset(&mtd->dev, 0, sizeof(mtd->dev));
> > +
> > +	idr_remove(&mtd_idr, mtd->index);
> > +	of_node_put(mtd_get_of_node(mtd));
> > +
> > +	module_put(THIS_MODULE);
> > +}
> > +
> >  #define MTD_DEVICE_ATTR_RO(name) \
> >  static DEVICE_ATTR(name, 0444, mtd_##name##_show, NULL)
> >=20
> > @@ -666,7 +689,7 @@ int add_mtd_device(struct mtd_info *mtd)
> >  	}
> >=20
> >  	mtd->index =3D i;
> > -	mtd->usecount =3D 0;
> > +	kref_init(&mtd->refcnt);
> >=20
> >  	/* default value if not set by driver */
> >  	if (mtd->bitflip_threshold =3D=3D 0)
> > @@ -779,7 +802,6 @@ int del_mtd_device(struct mtd_info *mtd)
> >  {
> >  	int ret;
> >  	struct mtd_notifier *not;
> > -	struct device_node *mtd_of_node;
> >=20
> >  	mutex_lock(&mtd_table_mutex);
> >=20
> > @@ -793,28 +815,8 @@ int del_mtd_device(struct mtd_info *mtd)
> >  	list_for_each_entry(not, &mtd_notifiers, list)
> >  		not->remove(mtd);
> >=20
> > -	if (mtd->usecount) {
> > -		printk(KERN_NOTICE "Removing MTD device #%d (%s) with use
> > count %d\n",
> > -		       mtd->index, mtd->name, mtd->usecount);
> > -		ret =3D -EBUSY;
> > -	} else {
> > -		mtd_of_node =3D mtd_get_of_node(mtd);
> > -		debugfs_remove_recursive(mtd->dbg.dfs_dir);
> > -
> > -		/* Try to remove the NVMEM provider */
> > -		nvmem_unregister(mtd->nvmem);
> > -
> > -		device_unregister(&mtd->dev);
> > -
> > -		/* Clear dev so mtd can be safely re-registered later if
> > desired */
> > -		memset(&mtd->dev, 0, sizeof(mtd->dev));
> > -
> > -		idr_remove(&mtd_idr, mtd->index);
> > -		of_node_put(mtd_of_node);
> > -
> > -		module_put(THIS_MODULE);
> > -		ret =3D 0;
> > -	}
> > +	kref_put(&mtd->refcnt, mtd_device_release);
> > +	ret =3D 0;
> >=20
> >  out_error:
> >  	mutex_unlock(&mtd_table_mutex);
> > @@ -1228,19 +1230,21 @@ int __get_mtd_device(struct mtd_info *mtd)
> >  	if (!try_module_get(master->owner))
> >  		return -ENODEV;
> >=20
> > +	kref_get(&mtd->refcnt);
> > +
> >  	if (master->_get_device) {
> >  		err =3D master->_get_device(mtd);
> >=20
> >  		if (err) {
> > +			kref_put(&mtd->refcnt, mtd_device_release);
> >  			module_put(master->owner);
> >  			return err;
> >  		}
> >  	}
> >=20
> > -	master->usecount++;
> > -
> >  	while (mtd->parent) {
> > -		mtd->usecount++;
> > +		if (IS_ENABLED(CONFIG_MTD_PARTITIONED_MASTER) || mtd- =20
> > >parent !=3D master) =20
> > +			kref_get(&mtd->parent->refcnt);
> >  		mtd =3D mtd->parent;
> >  	}
> >=20
> > @@ -1327,18 +1331,20 @@ void __put_mtd_device(struct mtd_info *mtd)
> >  {
> >  	struct mtd_info *master =3D mtd_get_master(mtd);
> >=20
> > -	while (mtd->parent) {
> > -		--mtd->usecount;
> > -		BUG_ON(mtd->usecount < 0);
> > -		mtd =3D mtd->parent;
> > -	}
> > +	while (mtd !=3D master) {
> > +		struct mtd_info *parent =3D mtd->parent;
> >=20
> > -	master->usecount--;
> > +		kref_put(&mtd->refcnt, mtd_device_release);
> > +		mtd =3D parent;
> > +	}
> >=20
> >  	if (master->_put_device)
> >  		master->_put_device(master);
> >=20
> >  	module_put(master->owner);
> > +
> > +	if (IS_ENABLED(CONFIG_MTD_PARTITIONED_MASTER))
> > +		kref_put(&master->refcnt, mtd_device_release);
> >  }
> >  EXPORT_SYMBOL_GPL(__put_mtd_device);
> >=20
> > diff --git a/drivers/mtd/mtdcore.h b/drivers/mtd/mtdcore.h
> > index b5eefeabf310..b014861a06a6 100644
> > --- a/drivers/mtd/mtdcore.h
> > +++ b/drivers/mtd/mtdcore.h
> > @@ -12,6 +12,7 @@ int __must_check add_mtd_device(struct mtd_info
> > *mtd);
> >  int del_mtd_device(struct mtd_info *mtd);
> >  int add_mtd_partitions(struct mtd_info *, const struct mtd_partition
> > *, int);
> >  int del_mtd_partitions(struct mtd_info *);
> > +void release_mtd_partition(struct mtd_info *mtd);
> >=20
> >  struct mtd_partitions;
> >=20
> > diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
> > index a46affbb037d..23483db8f30c 100644
> > --- a/drivers/mtd/mtdpart.c
> > +++ b/drivers/mtd/mtdpart.c
> > @@ -32,6 +32,12 @@ static inline void free_partition(struct mtd_info
> > *mtd)
> >  	kfree(mtd);
> >  }
> >=20
> > +void release_mtd_partition(struct mtd_info *mtd)
> > +{
> > +	WARN_ON(!list_empty(&mtd->part.node));
> > +	free_partition(mtd);
> > +}
> > +
> >  static struct mtd_info *allocate_partition(struct mtd_info *parent,
> >  					   const struct mtd_partition *part,
> >  					   int partno, uint64_t cur_offset)
> > @@ -309,13 +315,11 @@ static int __mtd_del_partition(struct mtd_info
> > *mtd)
> >=20
> >  	sysfs_remove_files(&mtd->dev.kobj, mtd_partition_attrs);
> >=20
> > +	list_del_init(&mtd->part.node);
> >  	err =3D del_mtd_device(mtd);
> >  	if (err)
> >  		return err;
> >=20
> > -	list_del(&mtd->part.node);
> > -	free_partition(mtd);
> > -
> >  	return 0;
> >  }
> >=20
> > @@ -333,6 +337,7 @@ static int __del_mtd_partitions(struct mtd_info
> > *mtd)
> >  			__del_mtd_partitions(child);
> >=20
> >  		pr_info("Deleting %s MTD partition\n", child->name);
> > +		list_del_init(&child->part.node);
> >  		ret =3D del_mtd_device(child);
> >  		if (ret < 0) {
> >  			pr_err("Error when deleting partition \"%s\" (%d)\n",
> > @@ -340,9 +345,6 @@ static int __del_mtd_partitions(struct mtd_info
> > *mtd)
> >  			err =3D ret;
> >  			continue;
> >  		}
> > -
> > -		list_del(&child->part.node);
> > -		free_partition(child);
> >  	}
> >=20
> >  	return err;
> > diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
> > index 7c58c44662b8..914a9f974baa 100644
> > --- a/include/linux/mtd/mtd.h
> > +++ b/include/linux/mtd/mtd.h
> > @@ -379,7 +379,7 @@ struct mtd_info {
> >=20
> >  	struct module *owner;
> >  	struct device dev;
> > -	int usecount;
> > +	struct kref refcnt;
> >  	struct mtd_debug_info dbg;
> >  	struct nvmem_device *nvmem;
> >  	struct nvmem_device *otp_user_nvmem;
> > --
> > 2.34.1 =20
>=20
