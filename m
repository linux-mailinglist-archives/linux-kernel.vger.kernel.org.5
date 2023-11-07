Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4452E7E3B5E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 12:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233861AbjKGL6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 06:58:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234437AbjKGLoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 06:44:37 -0500
Received: from esa2.ltts.com (unknown [14.140.155.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A54D78
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 03:44:05 -0800 (PST)
IronPort-SDR: OQIwT4EQ7DOYMWkGm2TztlNSGthsf+QSvMDX1yRhnOFiAbdgb1+hJo28MNAW59sH+1SPotu2t2
 1c55adMmw6Zw==
Received: from unknown (HELO BLTSP01651.lnties.com) ([10.20.120.98])
  by esa2.ltts.com with ESMTP; 07 Nov 2023 17:14:02 +0530
From:   Gairuboina Sirisha <sirisha.gairuboina@Ltts.com>
To:     gregkh@linuxfoundation.org
Cc:     arnd@arndb.de, lee@kernel.org, linux-kernel@vger.kernel.org,
        sirisha.gairuboina@ltts.com
Subject: Re: [PATCH v1 2/3] drivers: mfd: Add support for TPS65224 i2c driver
Date:   Tue,  7 Nov 2023 17:12:33 +0530
Message-Id: <20231107114233.1051471-1-sirisha.gairuboina@Ltts.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2023102713-jigsaw-straw-34f2@gregkh>
References: <2023102713-jigsaw-straw-34f2@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gairuboina Sirisha <sirisha.gairuboina@ltts.com>

> On Thu, Oct 26, 2023 at 07:02:25PM +0530, Gairuboina Sirisha wrote:
> > From: Gairuboina Sirisha <sirisha.gairuboina@ltts.com>
> >
> > Added MFD driver that enables I2C communication with and without CRC
> >
> > Signed-off-by: Gairuboina Sirisha <sirisha.gairuboina@ltts.com>
> > ---
> >  drivers/mfd/Kconfig        |  14 +++
> >  drivers/mfd/Makefile       |   1 +
> >  drivers/mfd/tps65224-i2c.c | 245 +++++++++++++++++++++++++++++++++++++
> >  3 files changed, 260 insertions(+)
> >  create mode 100644 drivers/mfd/tps65224-i2c.c
> >
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index 2e4906484eed..943d85d49fc5 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -1767,12 +1767,26 @@ config MFD_TPS6594_SPI
> >
> >  	  This driver can also be built as a module.  If so, the module
> >  	  will be called tps6594-spi.
> > +
>
> That line should have been added in the first patch.
>
>
> >  config MFD_TPS65224
> >          tristate
> >          select MFD_CORE
> >          select REGMAP
> >          select REGMAP_IRQ
> >
> > +config MFD_TPS65224_I2C
> > +        tristate "TI TPS65224 Power Management chip with I2C"
> > +        select MFD_TPS65224
> > +        select REGMAP_I2C
> > +        select CRC8
> > +        depends on I2C
> > +        help
> > +          If you say yes here you get support for the TPS65224 series of
> > +          PM chips with I2C interface.
> > +
> > +          This driver can also be built as a module.  If so, the module
> > +          will be called tps65224-i2c.
> > +
> >  config TWL4030_CORE
> >  	bool "TI TWL4030/TWL5030/TWL6030/TPS659x0 Support"
> >  	depends on I2C=y
> > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > index ff4e158fa4db..4963fecd3e93 100644
> > --- a/drivers/mfd/Makefile
> > +++ b/drivers/mfd/Makefile
> > @@ -103,6 +103,7 @@ obj-$(CONFIG_MFD_TPS6594)	+= tps6594-core.o
> >  obj-$(CONFIG_MFD_TPS6594_I2C)	+= tps6594-i2c.o
> >  obj-$(CONFIG_MFD_TPS6594_SPI)	+= tps6594-spi.o
> >  obj-$(CONFIG_MFD_TPS65224)      += tps65224-core.o
> > +obj-$(CONFIG_MFD_TPS65224)      += tps65224-i2c.o
> >  obj-$(CONFIG_MENELAUS)		+= menelaus.o
> >
> >  obj-$(CONFIG_TWL4030_CORE)	+= twl-core.o twl4030-irq.o twl6030-irq.o
> > diff --git a/drivers/mfd/tps65224-i2c.c b/drivers/mfd/tps65224-i2c.c
> > new file mode 100644
> > index 000000000000..c6300138ce4c
> > --- /dev/null
> > +++ b/drivers/mfd/tps65224-i2c.c
> > @@ -0,0 +1,245 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * I2C access driver for TI TPS65224 PMIC
> > + *
> > + * Copyright (C) 2015 Texas Instruments Incorporated - https://www.ti.com/
>
> Again, check your copyright lines please.

Will correct style and copyright issues in the next patch version V2.

Thanks & Regards,
Sirisha G.
