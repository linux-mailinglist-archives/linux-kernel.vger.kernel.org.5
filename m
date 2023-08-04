Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978B4770518
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 17:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbjHDPqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 11:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbjHDPqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 11:46:33 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135201734
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 08:46:31 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C4CC160003;
        Fri,  4 Aug 2023 15:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1691163990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DXdt9jg170O0khRMY6w6+QCKt9NkNze+0Sh36YFkoIM=;
        b=PtC9sfpHGnn/OsV9bW60xEuVWu6YkUumxDeDcyoYPmnVfhlaVDUgVKMJUF6WlwMwQ9526g
        rKrcISgjy7MDAsocxx1ihKZGCya7AG7fGKd5POs8/JqgY7sqa2Hm6FCcH/We99VzlzYp1J
        rcYlxYn5L0MhXXH3zPdRh02p5D15HJjyyjeRCHMrL1+d7eab7pbQG6h2PW7t0oskNgEizI
        GvwOqnmEiMJEBVShD/B+RABok6yxilI5F+w9S/Xo3SbzHiIBjA7n34f4sPT+jW8JjAAP0N
        75QcwczKwR5HUAGYsgDBD4F+s9AQEFCXdG34LkOOoQRsHJNxUWJx3zZD+cPmAw==
Date:   Fri, 4 Aug 2023 17:46:25 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     oe-kbuild@lists.linux.dev,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Daniel Golle <daniel@makrotopia.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH v7 5/7] nvmem: core: Rework layouts to become platform
 devices
Message-ID: <20230804174625.4c27fe9a@xps-13>
In-Reply-To: <20230804173903.2b298cd3@xps-13>
References: <20230801182132.1058707-6-miquel.raynal@bootlin.com>
        <b9040273-aca8-432a-83aa-b0d6b1b88529@kadam.mountain>
        <20230804173903.2b298cd3@xps-13>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again Dan,

miquel.raynal@bootlin.com wrote on Fri, 4 Aug 2023 17:39:03 +0200:

> Hi Dan,
>=20
> dan.carpenter@linaro.org wrote on Thu, 3 Aug 2023 13:13:04 +0300:
>=20
> > Hi Miquel,
> >=20
> > kernel test robot noticed the following build warnings:
> >=20
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> >=20
> > url:    https://github.com/intel-lab-lkp/linux/commits/Miquel-Raynal/nv=
mem-core-Create-all-cells-before-adding-the-nvmem-device/20230802-022331
> > base:   char-misc/char-misc-testing
> > patch link:    https://lore.kernel.org/r/20230801182132.1058707-6-mique=
l.raynal%40bootlin.com
> > patch subject: [PATCH v7 5/7] nvmem: core: Rework layouts to become pla=
tform devices
> > config: x86_64-randconfig-m001-20230730 (https://download.01.org/0day-c=
i/archive/20230803/202308030002.DnSFOrMB-lkp@intel.com/config)
> > compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> > reproduce: (https://download.01.org/0day-ci/archive/20230803/2023080300=
02.DnSFOrMB-lkp@intel.com/reproduce)
> >=20
> > If you fix the issue in a separate patch/commit
> > (i.e. not just a new version of the same patch/commit),
>=20
> (Nice addition, a lot of newcomers would always add these tags
> otherwise.)
>=20
> > kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > | Closes: https://lore.kernel.org/r/202308030002.DnSFOrMB-lkp@intel.com/
> >=20
> > New smatch warnings:
> > drivers/nvmem/core.c:1003 nvmem_register() warn: 'layout_np' is an erro=
r pointer or valid
> > drivers/nvmem/core.c:2130 nvmem_try_loading_layout_driver() warn: 'layo=
ut_np' is an error pointer or valid
> >=20
> > Old smatch warnings:
> > drivers/nvmem/core.c:761 nvmem_add_cells_from_fixed_layout() warn: 'lay=
out_np' is an error pointer or valid
> > drivers/nvmem/core.c:802 nvmem_layout_get() warn: 'layout_np' is an err=
or pointer or valid
> >=20
> > vim +/layout_np +1003 drivers/nvmem/core.c
> >=20
> > 266570f496b90d Michael Walle         2023-04-04  1000 =20
> > 00d059fd6702f0 Miquel Raynal         2023-08-01  1001  	/* Populate lay=
outs as devices */
> > 00d059fd6702f0 Miquel Raynal         2023-08-01  1002  	layout_np =3D o=
f_nvmem_layout_get_container(nvmem);
> > 00d059fd6702f0 Miquel Raynal         2023-08-01 @1003  	if (layout_np) {
> >=20
> > So, ugh, of_nvmem_layout_get_container() return NULL on error or error
> > pointer if either CONFIG_NVMEM or CONFIG_OF is turned off.  I feel like
> > that's a mistake.  Normally when a function returns both error pointers
> > and NULL then the NULL means the feature is disabled and the error
> > pointers mean there was an error.  Here it is the opposite.
> >=20
> > I have written a blog about this:
> > https://staticthinking.wordpress.com/2022/08/01/mixing-error-pointers-a=
nd-null/
>=20
> Nice (besides the huge spider which stared at me unexpectedly :-) )
>=20
> > At first I thought that this was to do with CONFIG_COMPILE_TEST but
> > actually that is disabled.  The issue here is that CONFIG_OF is turned
> > off.  So this is a genuine bug, we're compiling a module which will
> > always crash.
> >=20
> > So I guess the fix is easy that this should return NULL if either
> > CONFIG_NVMEM or CONFIG_OF is turned off.  That was a long explanation
> > which is no longer required now that it's not a COMPILE_TEST issue.  :P
>=20
> I wanted to disable CONFIG_OF to make the test, I totally forget, I'll
> handle this case and return NULL when this happens.

Actually of_nvmem_layout_get_container() already returns NULL if
CONFIG_OF is not defined. This helper returns either a valid pointer of
NULL. Where can it return an error pointer?

> However I don't understand why you mention CONFIG_NVMEM, because if it
> is not defined, this file will not compile at all?
>=20
> > 00d059fd6702f0 Miquel Raynal         2023-08-01  1004  		rval =3D of_pl=
atform_populate(nvmem->dev.of_node, NULL, NULL, NULL);
> > 00d059fd6702f0 Miquel Raynal         2023-08-01  1005  		if (rval)
> > 00d059fd6702f0 Miquel Raynal         2023-08-01  1006  			goto err_remo=
ve_cells;
> > 00d059fd6702f0 Miquel Raynal         2023-08-01  1007  		of_node_put(la=
yout_np);
> > 00d059fd6702f0 Miquel Raynal         2023-08-01  1008  	}
> > 00d059fd6702f0 Miquel Raynal         2023-08-01  1009 =20
> > 25c9b5d3aa24a0 Miquel Raynal         2023-08-01  1010  	mutex_lock(&nvm=
em_devices_mutex);
> > 25c9b5d3aa24a0 Miquel Raynal         2023-08-01  1011  	list_add_tail(&=
nvmem->node, &nvmem_devices_list);
> > 25c9b5d3aa24a0 Miquel Raynal         2023-08-01  1012  	mutex_unlock(&n=
vmem_devices_mutex);
> > 25c9b5d3aa24a0 Miquel Raynal         2023-08-01  1013 =20
> > f4853e1c321edb Bartosz Golaszewski   2019-02-15  1014  	blocking_notifi=
er_call_chain(&nvmem_notifier, NVMEM_ADD, nvmem);
> > bee1138bea15a6 Bartosz Golaszewski   2018-09-21  1015 =20
> > eace75cfdcf7d9 Srinivas Kandagatla   2015-07-27  1016  	return nvmem;
> > 3360acdf839170 Johan Hovold          2017-06-09  1017 =20
> > b985f4cba6dbb3 Bartosz Golaszewski   2018-09-21  1018  err_remove_cells:
> > b985f4cba6dbb3 Bartosz Golaszewski   2018-09-21  1019  	nvmem_device_re=
move_all_cells(nvmem);
> > fa72d847d68d78 Bartosz Golaszewski   2018-09-21  1020  	if (config->com=
pat)
> > ae0c2d725512f3 Srinivas Kandagatla   2019-04-16  1021  		nvmem_sysfs_re=
move_compat(nvmem, config);
> > 3360acdf839170 Johan Hovold          2017-06-09  1022  err_put_device:
> > 3360acdf839170 Johan Hovold          2017-06-09  1023  	put_device(&nvm=
em->dev);
> > 3360acdf839170 Johan Hovold          2017-06-09  1024 =20
> > b6c217ab9be689 Andrew Lunn           2016-02-26  1025  	return ERR_PTR(=
rval);
> > eace75cfdcf7d9 Srinivas Kandagatla   2015-07-27  1026  }
> >=20
>=20
>=20
> Thanks,
> Miqu=C3=A8l


Thanks,
Miqu=C3=A8l
