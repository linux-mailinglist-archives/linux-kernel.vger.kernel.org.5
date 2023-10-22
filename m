Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83627D2627
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 23:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbjJVVyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 17:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjJVVyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 17:54:38 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F05E6;
        Sun, 22 Oct 2023 14:54:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WHqazfUlDGUOTAE8WdzS/81U5tKconB6RuBayFszIndMFPKLJbRO+vsoDIz3WpBQph6iG4q88npUma/FpAk+BrSasR5dGEeuXH5SrGXEMavMVr/wLbTMp0BKc8IwsmSgtim8Zq7MawpxB05GmjfHSDNihZZ/8tAWo5AxBTOvx+sqLsQveLPfZIx6rBuw0PCNsqwl7eDFXHiMNatYgku8xxJ2FY63V3PEeKI5L5aAXf2G4uXSIasP/WN9b7zC0u+DfuOeJuth6yrhjnwX/LaRrecVHuTU56o3ArGonCTKYsA2s4/zZi+CcK/FV4wG5T2vL3YNLvSWHMKonfZIbPMfdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v7SOznQR780CNyj5TC65TJyZvFCUhK2e6H3MIWak1ow=;
 b=EfDV1jwtALmSo0Ti5IlvjCISwYK203NYA4viud9GjDtXP5ZG1Mlk63jyglj5qyyP+nrd72chVGBWpW73teULQGaC29A7N6yBTYFod/pzluZM3Oe82zKFz/Nz+UGMcXqxbliRvshWXmQz51V3DeMNkdnnGx82+zrvweEnmOMCaX4hWvy0wpTcXJKcXa8DZ7elYExYNyhx/o7+auOYIimxnQ79sFm+mIWyL3APEZKyGsBQ1Skiv80nR7IVShiwWuk46Iq9e4KxPWm86kZfQ2OA4zdYZvUDPYaGWA2TbHufciLX73ykNqMNxwmbxMKTuKzYzqNUSM+ykUWh56dNA0edpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v7SOznQR780CNyj5TC65TJyZvFCUhK2e6H3MIWak1ow=;
 b=d0xdVaLROc1EiO+gmdEogkEs31VmEj9U1oYWpPDv+1PMpT8lVVRwp6h2j5gno/BQ5VwH3nOeezRA0TJRoExZw6atZrYQA5VrX9OrWjSLw3FPbR3GTdQ+ALIF5y9Z9xW1buaCmeUvQ4TaHjZBCR9PUeUuFADh/xxfTpJ+ursGm10=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by LV3PR08MB9316.namprd08.prod.outlook.com
 (2603:10b6:408:214::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Sun, 22 Oct
 2023 21:54:28 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::e73c:270b:75f7:5302]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::e73c:270b:75f7:5302%4]) with mapi id 15.20.6907.032; Sun, 22 Oct 2023
 21:54:27 +0000
Date:   Sun, 22 Oct 2023 16:54:18 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Kamel Bouhara <kamel.bouhara@bootlin.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Marco Felsch <m.felsch@pengutronix.de>,
        mark.satterthwaite@touchnetix.com, bartp@baasheep.co.uk,
        hannah.rossiter@touchnetix.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        bsp-development.geo@leica-geosystems.com
Subject: Re: [PATCH v3 3/3] Input: Add TouchNetix axiom i2c touchscreen driver
Message-ID: <ZTWaClwL8xIGdS8t@nixie71>
References: <20231012074034.1090436-1-kamel.bouhara@bootlin.com>
 <20231012074034.1090436-4-kamel.bouhara@bootlin.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012074034.1090436-4-kamel.bouhara@bootlin.com>
X-ClientProxiedBy: SN7PR04CA0046.namprd04.prod.outlook.com
 (2603:10b6:806:120::21) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|LV3PR08MB9316:EE_
X-MS-Office365-Filtering-Correlation-Id: 42647ab3-b4b7-4bfc-82ac-08dbd349759a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 56aIk4wwegIfkUa5EdCPrnX0Xt2L/9mOB9/mgjePkadRU45pcKmnvfj7a9G6xL8xv5Q/hMkLHYZgnXhLvnpAp+nSfvHYVoaDbOUyKVcby/0Rf8FMMRBoTWRaejGI98y59XykgdqacxNGJXY6d6Xvw2uZ7K4oLRCMbuB6zfAWJSoLr1OPZleIgdyvu7Ax4ImYwl3SZ76tISn1H0nJRPP6isKQ6afooJHHb+CjsWfr+CQSuDs+VygngxGcV7MRv5yAmvuuDtER8tX0WV70Hxi9zXVKgyWaU5bdoqWNWrFk7JQfXE53HW6l212gz2XHF02DrSUVGE9GkNBj6+J1EqXFniPHASoMwEJzQSCwNrVzIX8yyWcmtS8TRyvpt68X2E597BVVLa7v3/2Ib6t4JEoTKMoczyvtEEN/DnB5zEkc3rTcBwwhdCZJ/VTSXzufzGKxiLhhuhKzNQQr3IncFhBmwSmP61XiSYa97OOqahsXi0nIP4thO+XKp9Hq5Mp8jHBw2M3r6ETYeU4GQXALHvApB7nDhglqWA7NDejFXkBgppeZCe8oeE+SKYngGI6c70XJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(39830400003)(396003)(366004)(376002)(346002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(33716001)(83380400001)(30864003)(7416002)(2906002)(8936002)(8676002)(4326008)(38100700002)(26005)(9686003)(6666004)(316002)(6916009)(5660300002)(6506007)(478600001)(6486002)(6512007)(41300700001)(86362001)(66476007)(66556008)(66946007)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a0j5MnKQ5GMYdDLYwruMXL/u6MEmAVUhWt3XrfXFdoSPa6Yz8wOwPKxhlPP5?=
 =?us-ascii?Q?yYFp5KP9QqXbiI6Brr7sBTbDEFOF2QpkmVUObLxSKHcvZ2OUjgQ8m+DeKV0h?=
 =?us-ascii?Q?62Wjzsb9d9RZBbAldhZSnIIBUrBFEL/IzjiizMBap53Sh+AHlon7b9xvC3V4?=
 =?us-ascii?Q?mq0SpAozWca8URDiEEAbVPI4q7bgxLN8GrXAtiPFhGLDprTDF2Zck65jEVtI?=
 =?us-ascii?Q?KxYf+jz6lW6ClGHoyfKW2aKNBomG8LB5ynB4oUoM2x/4aHwX8akk8MASBbmv?=
 =?us-ascii?Q?HAYNNIppYOfrm9LqFeBOM6Z96YRAXmIx1i5MAi+pGWChy/XTFWAmnyerOf3y?=
 =?us-ascii?Q?zegRpPDBfSG+iPWLrC7b2Ri0urA5iXH2nHbyvRuq99P2gJo3uucH4Wy2cm0T?=
 =?us-ascii?Q?uRsC4QBOXStR58+KQjDd69/Ca89oZwlFoM599cu5Z5A+KCTJq+3IuWCOJ+Gu?=
 =?us-ascii?Q?Oxc7T5eoF49t5jS/oRLWWUGpT84L0J0EJAY/dpPId5B78n9roahLLVymJwbW?=
 =?us-ascii?Q?TyBtTKxNH74A8+qSViHIvHSr6xp6OXtvOC+uBvXZG+rEtAaMoDN73KO6cgmQ?=
 =?us-ascii?Q?m1d6t+0awPxL/3z7XtGOUrRG26I55V7IkhmuYK6hD7CfmuKXntafNBiUP8wA?=
 =?us-ascii?Q?CeX1QzaaYRVm95dKCwfSI31TGSmfVKZ8qlJym15lPyQwxDvgZYq3V+sEV9Yi?=
 =?us-ascii?Q?pUYPLDfzgaGaMpoDMuAgYyD/4IOgG+0N/mIsPM/2y1g8Nqx5mp4R1LnPMJZ4?=
 =?us-ascii?Q?xreg9sSn4iWhSxSGZiPHVbIBu0QKcD9giuDEzWkVlfapGtwmpgZAEA3fYj4n?=
 =?us-ascii?Q?AAlCHVILv2UL8uaGeZitlfVvkcga6SA4zpMumz2Z1HmP60lR+LAWl8+QdHO+?=
 =?us-ascii?Q?eyglmJZAf35SlGKcinotw/TsVl7eW+ky35406oqu5CLOS99oCv2AXHsPfq4W?=
 =?us-ascii?Q?q2CyLXjt4ckal7fWRcAgAkVCgWx8dGopCmNcmKzOHjRFPl3oz4KdLWJRnxyO?=
 =?us-ascii?Q?07eKlUUZdhYdQOWPWatpH9HFBvNFs4kHisYI4e1P0bXXA+5xRHhUkrv15muv?=
 =?us-ascii?Q?HYtJl/tki5yc7AoEgIyD9EMJzMsRZSun5zpYPtezHfrmtEcGP9I50KGJITvT?=
 =?us-ascii?Q?iY7+MAEH3NMgSXpMTGIf9+uzJ8AlpNsZzui3VZSzKsrkV43B7Iw4VhoSWjhF?=
 =?us-ascii?Q?MQnund1Z1KdvTJ+G8Dv+9MEs272Gh0VnqgzBcwtrQXa66Ta9yEBCiQ1dAEIS?=
 =?us-ascii?Q?MH3vZ7gOT8uBUvkPqfkXvqD0SdGGysjj0HjdAnpUCc0rizAHbUsszJ2oW4Zv?=
 =?us-ascii?Q?RCsB5QMD3IJur+yH6T3rQ9CmKUNdpXYk+636+lbkNJerpeEO+2NiPAi188Oa?=
 =?us-ascii?Q?w8iSk2XY0Q24bfO9GJ/sncYtoHnevzPC5e381fcko7/sLVX2ZEtsDXgT+udc?=
 =?us-ascii?Q?ABIC8kDowh813peM+N++rugRHJ8MUnoiGTg2934R2DJyzN4sdBLr24/GGZPO?=
 =?us-ascii?Q?vcaejGN7ha/tpPe8ePI4ia8I7j3QH+zPyYc2A4htWhCQcgXYbtd2yOONCFEl?=
 =?us-ascii?Q?bTrxxPI5LynNKnAr2lGemPpgsvK86hZ2EUJ+VPPM?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42647ab3-b4b7-4bfc-82ac-08dbd349759a
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2023 21:54:26.6469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kUVldG7Y3pEr6ON6UmJBvCJ1ICtKgA0K1ftv26rqGfLrreS1C/kNyf4MWQ8HtSyOcLmrfz1pVW7EAU0wj36ZdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR08MB9316
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kamel,

On Thu, Oct 12, 2023 at 09:40:34AM +0200, Kamel Bouhara wrote:
> Add a new driver for the TouchNetix's axiom family of
> touchscreen controllers. This driver only supports i2c
> and can be later adapted for SPI and USB support.
> 
> Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> ---
>  MAINTAINERS                                   |   1 +
>  drivers/input/touchscreen/Kconfig             |  13 +
>  drivers/input/touchscreen/Makefile            |   1 +
>  .../input/touchscreen/touchnetix_axiom_i2c.c  | 740 ++++++++++++++++++
>  4 files changed, 755 insertions(+)
>  create mode 100644 drivers/input/touchscreen/touchnetix_axiom_i2c.c

Please do not include 'i2c' in the filename. If the driver is expanded in
the future to support SPI, it would make sense to have touchnetix_axiom.c,
touchnetix_axiom_i2c.c and touchnetix_axiom_spi.c. To prevent this driver
from having to be renamed in that case, just call it touchnetix_axiom.c.

> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 12ae8bc6b8cf..2d1e0b025e89 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21415,6 +21415,7 @@ M:	Kamel Bouhara <kamel.bouhara@bootlin.com>
>  L:	linux-input@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/input/touchscreen/touchnetix,axiom-ax54a.yaml
> +F:	drivers/input/touchscreen/touchnetix_axiom_i2c.c
>  
>  THUNDERBOLT DMA TRAFFIC TEST DRIVER
>  M:	Isaac Hazan <isaac.hazan@intel.com>
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index e3e2324547b9..58665ccbe077 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -803,6 +803,19 @@ config TOUCHSCREEN_MIGOR
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called migor_ts.
>  
> +config TOUCHSCREEN_TOUCHNETIX_AXIOM_I2C
> +	tristate "TouchNetix AXIOM based touchscreen controllers"
> +	depends on I2C
> +	depends on GPIOLIB || COMPILE_TEST

All gpiod_*() functions used in this driver have a dummy function for the
CONFIG_GPIOLIB=n case, so this dependency is unnecessary.

> +	help
> +	  Say Y here if you have a axiom touchscreen connected to
> +	  your system.
> +
> +	  If unsure, say N.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called axiom_i2c.
> +
>  config TOUCHSCREEN_TOUCHRIGHT
>  	tristate "Touchright serial touchscreen"
>  	select SERIO
> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
> index 62bd24f3ac8e..23b6fb8864b0 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -88,6 +88,7 @@ obj-$(CONFIG_TOUCHSCREEN_SUR40)		+= sur40.o
>  obj-$(CONFIG_TOUCHSCREEN_SURFACE3_SPI)	+= surface3_spi.o
>  obj-$(CONFIG_TOUCHSCREEN_TI_AM335X_TSC)	+= ti_am335x_tsc.o
>  obj-$(CONFIG_TOUCHSCREEN_TOUCHIT213)	+= touchit213.o
> +obj-$(CONFIG_TOUCHSCREEN_TOUCHNETIX_AXIOM_I2C)	+= touchnetix_axiom_i2c.o
>  obj-$(CONFIG_TOUCHSCREEN_TOUCHRIGHT)	+= touchright.o
>  obj-$(CONFIG_TOUCHSCREEN_TOUCHWIN)	+= touchwin.o
>  obj-$(CONFIG_TOUCHSCREEN_TS4800)	+= ts4800-ts.o
> diff --git a/drivers/input/touchscreen/touchnetix_axiom_i2c.c b/drivers/input/touchscreen/touchnetix_axiom_i2c.c
> new file mode 100644
> index 000000000000..fb6239a87341
> --- /dev/null
> +++ b/drivers/input/touchscreen/touchnetix_axiom_i2c.c
> @@ -0,0 +1,740 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * TouchNetix aXiom Touchscreen Driver
> + *
> + * Copyright (C) 2020-2023 TouchNetix Ltd.
> + *
> + * Author(s): Bart Prescott <bartp@baasheep.co.uk>
> + *            Pedro Torruella <pedro.torruella@touchnetix.com>
> + *            Mark Satterthwaite <mark.satterthwaite@touchnetix.com>
> + *            Hannah Rossiter <hannah.rossiter@touchnetix.com>
> + *            Kamel Bouhara <kamel.bouhara@bootlin.com>
> + *
> + */
> +
> +#include <linux/crc16.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/i2c.h>
> +#include <linux/input.h>
> +#include <linux/input/mt.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>

Please #include mod_devicetable.h as well.

> +#include <linux/of.h>
> +#include <linux/pm.h>

In addition to Marco's comment about unused includes, pm.h does not appear
to be used either.

> +#include <linux/slab.h>
> +#include <linux/string.h>
> +
> +/*
> + * Runtime TCP mode: device is executing normal code and is
> + * accessible via the Touch Controller Mode
> + */
> +#define BOOT_TCP			0
> +/*
> + * Bootloader BLP mode: device is executing bootloader and is
> + * accessible via the Boot Loader Protocol.
> + */
> +#define BOOT_BLP			1
> +#define AXIOM_PROX_LEVEL		-128
> +/*
> + * Register group u31 has 2 pages for usage table entries.
> + * (2 * AXIOM_COMMS_PAGE_SIZE) / AXIOM_U31_BYTES_PER_USAGE = 85
> + */
> +#define AXIOM_U31_MAX_USAGES		85
> +#define AXIOM_U31_BYTES_PER_USAGE	6
> +#define AXIOM_U31_PAGE0_LENGTH		0x0C
> +#define AXIOM_U31_BOOTMODE_MASK		BIT(7)
> +#define AXIOM_U31_FW_INFO_VARIANT_MASK	GENMASK(6, 0)
> +#define AXIOM_U31_FW_INFO_STATUS_MASK	BIT(7)
> +
> +#define AXIOM_U41_MAX_TARGETS		10
> +
> +#define AXIOM_U46_AUX_CHANNELS		4
> +#define AXIOM_U46_AUX_MASK		GENMASK(11, 0)
> +
> +#define AXIOM_COMMS_MAX_USAGE_PAGES	3
> +#define AXIOM_COMMS_PAGE_SIZE		256
> +#define AXIOM_COMMS_OVERFLOW_MASK	BIT(7)
> +#define AXIOM_COMMS_REPORT_LEN_MASK	GENMASK(7, 0)
> +
> +#define AXIOM_REBASELINE_CMD		0x03
> +
> +#define AXIOM_REPORT_USAGE_ID		0x34
> +#define AXIOM_DEVINFO_USAGE_ID		0x31
> +#define AXIOM_USAGE_2HB_REPORT_ID	0x01
> +#define AXIOM_REBASELINE_USAGE_ID	0x02
> +#define AXIOM_USAGE_2AUX_REPORT_ID	0x46
> +#define AXIOM_USAGE_2DCTS_REPORT_ID	0x41
> +
> +#define AXIOM_PAGE_MASK			GENMASK(15, 8)
> +#define AXIOM_PAGE_OFFSET_MASK		GENMASK(7, 0)
> +
> +struct axiom_devinfo {
> +	char bootloader_fw_major;

Please use standard kernel type definitions, specifically u8 in place of char.

> +	char bootloader_fw_minor;
> +	char bootmode;
> +	u16 device_id;
> +	char fw_major;
> +	char fw_minor;
> +	char fw_info_extra;
> +	char tcp_revision;
> +	u16 jedec_id;
> +	char num_usages;
> +	char silicon_revision;
> +};
> +
> +/*
> + * Describes parameters of a specific usage, essenstially a single element of
> + * the "Usage Table"
> + */
> +struct usage_entry {
> +	char id;
> +	char is_report;
> +	char start_page;
> +	char num_pages;
> +};
> +
> +/*
> + * Holds state of a touch or target when detected prior a touch (eg.
> + * hover or proximity events).
> + */

Nit: this comment is misleading. The enum itself does not hold state; it
represents state. A variable defined using this enum holds the state.

> +enum axiom_target_state {
> +	TARGET_STATE_NOT_PRESENT = 0,
> +	TARGET_STATE_PROX = 1,
> +	TARGET_STATE_HOVER = 2,
> +	TARGET_STATE_TOUCHING = 3,
> +	TARGET_STATE_MIN = TARGET_STATE_NOT_PRESENT,
> +	TARGET_STATE_MAX = TARGET_STATE_TOUCHING,
> +};

Please namespace these, i.e. AXIOM_TARGET_STATE_*.

> +
> +struct u41_target {
> +	enum axiom_target_state state;
> +	u16 x;
> +	u16 y;
> +	s8 z;
> +	bool insert;
> +	bool touch;
> +};

Please namespace this struct definition as you have done below.

> +
> +struct axiom_target_report {
> +	u8 index;
> +	u8 present;
> +	u16 x;
> +	u16 y;
> +	s8 z;
> +};
> +
> +struct axiom_cmd_header {
> +	u16 target_address;
> +	u16 length:15;
> +	u16 read:1;
> +} __packed;
> +
> +struct axiom_data {
> +	struct axiom_devinfo devinfo;
> +	struct device *dev;
> +	struct gpio_desc *reset_gpio;
> +	struct gpio_desc *irq_gpio;
> +	struct i2c_client *client;
> +	struct input_dev *input_dev;
> +	u32 max_report_len;
> +	u32 report_overflow_counter;
> +	u32 report_counter;
> +	char rx_buf[AXIOM_COMMS_MAX_USAGE_PAGES * AXIOM_COMMS_PAGE_SIZE];
> +	struct u41_target targets[AXIOM_U41_MAX_TARGETS];
> +	struct usage_entry usage_table[AXIOM_U31_MAX_USAGES];
> +	bool usage_table_populated;
> +};
> +
> +/*
> + * aXiom devices are typically configured to report
> + * touches at a rate of 100Hz (10ms). For systems
> + * that require polling for reports, 100ms seems like
> + * an acceptable polling rate.
> + * When reports are polled, it will be expected to
> + * occasionally observe the overflow bit being set
> + * in the reports. This indicates that reports are not
> + * being read fast enough.
> + */
> +#define POLL_INTERVAL_DEFAULT_MS 100

I'd rather we take this information from device tree; it seems 'poll-interval'
is a common property used by other drivers.

> +
> +/* Translate usage/page/offset triplet into physical address. */
> +static u16
> +usage_to_target_address(struct axiom_data *ts, char usage, char page,
> +			char offset)

The line break after the function type is a bit confusing; please use this
more common style and namespace all functions:

static u16 axiom_usage_to_target_address(...,
					 ...);

Note any line breaks are aligned to the opening parenthesis.

> +{
> +	struct axiom_devinfo *device_info;
> +	struct usage_entry *usage_table;
> +	u32 i;
> +
> +	device_info = &ts->devinfo;
> +	usage_table = ts->usage_table;
> +
> +	/* At the moment the convention is that u31 is always at physical address 0x0 */
> +	if (!ts->usage_table_populated) {
> +		if (usage == AXIOM_DEVINFO_USAGE_ID)
> +			return ((page << 8) + offset);
> +		else
> +			return 0xffff;
> +	}
> +
> +	for (i = 0; i < device_info->num_usages; i++) {
> +		if (usage_table[i].id != usage)
> +			continue;
> +
> +		if (page >= usage_table[i].num_pages) {
> +			dev_err(ts->dev, "Invalid usage table! usage: %u, page: %u, offset: %u\n",
> +				usage, page, offset);
> +			return 0xffff;
> +		}
> +	}
> +
> +	return ((usage_table[i].start_page + page) << 8) + offset;
> +}
> +
> +static int
> +axiom_i2c_read(struct i2c_client *client, u8 usage, u8 page, u8 *buf, u16 len)
> +{
> +	struct axiom_data *ts = i2c_get_clientdata(client);
> +	struct axiom_cmd_header cmd_header;
> +	struct i2c_msg msg[2];
> +	int ret;
> +
> +	cmd_header.target_address = cpu_to_le16(usage_to_target_address(ts, usage, page, 0));
> +	cmd_header.length = cpu_to_le16(len);
> +	cmd_header.read = 1;
> +
> +	msg[0].addr = client->addr;
> +	msg[0].flags = 0;
> +	msg[0].len = sizeof(cmd_header);
> +	msg[0].buf = (u8 *)&cmd_header;
> +
> +	msg[1].addr = client->addr;
> +	msg[1].flags = I2C_M_RD;
> +	msg[1].len = len;
> +	msg[1].buf = (char *)buf;

Again, please use u8 in place of char, as was done for the first element.

> +
> +	ret = i2c_transfer(client->adapter, msg, 2);

Please use ARRAY_SIZE(msg) above as you do below.

> +	if (ret != ARRAY_SIZE(msg)) {
> +		dev_err(&client->dev,
> +			"Failed reading usage %#x page %#x, error=%d\n",
> +			usage, page, ret);
> +		return -EIO;
> +	}

This check papers over negative error codes that may have been returned by
i2c_transfer(). For ret < 0 you should return ret, and only return -EIO for
0 <= ret < ARRAY_SIZE(msg).

More importantly, however, if this device supports multiple transports and
you expect SPI support can be added in the future, you really should use
regmap throughout in order to avoid ripping up this driver later.

> +
> +	return 0;
> +}
> +
> +static int
> +axiom_i2c_write(struct i2c_client *client, u8 usage, u8 page, u8 *buf, u16 len)
> +{
> +	struct axiom_data *ts = i2c_get_clientdata(client);
> +	struct axiom_cmd_header cmd_header;
> +	struct i2c_msg msg[2];
> +	int ret;
> +
> +	cmd_header.target_address = cpu_to_le16(usage_to_target_address(ts, usage, page, 0));
> +	cmd_header.length = cpu_to_le16(len);
> +	cmd_header.read = 0;
> +
> +	msg[0].addr = client->addr;
> +	msg[0].flags = 0;
> +	msg[0].len = sizeof(cmd_header);
> +	msg[0].buf = (u8 *)&cmd_header;
> +
> +	msg[1].addr = client->addr;
> +	msg[1].flags = 0;
> +	msg[1].len = len;
> +	msg[1].buf = (char *)buf;
> +
> +	ret = i2c_transfer(client->adapter, msg, 2);
> +	if (ret < 0) {
> +		dev_err(&client->dev,
> +			"Failed to write usage %#x page %#x, error=%d\n", usage,
> +			page, ret);
> +		return ret;
> +	}

The error handling between your read and write wrappers is inconsistent;
please see my comment above.

Is there any reason i2c_master_send() cannot work here? I'm guessing the
controller needs a repeated start in between the two messages?

For these kind of special requirements, it's helpful to add some comments
as to why the HW calls for additional housekeeping.

> +
> +	return 0;
> +}
> +
> +/*
> + * Decodes and populates the local Usage Table.
> + * Given a buffer of data read from page 1 onwards of u31 from an aXiom
> + * device.
> + */

What is a usage table? These comments aren't helpful unless some of the
underlying concepts are defined as well.

> +static u32 axiom_populate_usage_table(struct axiom_data *ts, char *rx_data)
> +{
> +	u32 usage_id = 0;

There is no need to initialize this iterator.

> +	u32 max_report_len = 0;
> +	struct axiom_devinfo *device_info;
> +	struct usage_entry *usage_table;
> +
> +	device_info = &ts->devinfo;
> +	usage_table = ts->usage_table;
> +
> +	for (usage_id = 0; usage_id < device_info->num_usages; usage_id++) {
> +		u16 offset = (usage_id * AXIOM_U31_BYTES_PER_USAGE);
> +		char id = rx_data[offset + 0];
> +		char start_page = rx_data[offset + 1];
> +		char num_pages = rx_data[offset + 2];

Please consider whether you can use a packed struct for this decoding.

> +		u32 max_offset = ((rx_data[offset + 3] & AXIOM_PAGE_OFFSET_MASK) + 1) * 2;
> +
> +		if (!num_pages)
> +			usage_table[usage_id].is_report = true;
> +
> +		/* Store the entry into the usage table */
> +		usage_table[usage_id].id = id;
> +		usage_table[usage_id].start_page = start_page;
> +		usage_table[usage_id].num_pages = num_pages;
> +
> +		dev_dbg(ts->dev, "Usage %2u Info: %*ph\n", usage_id,
> +			AXIOM_U31_BYTES_PER_USAGE,
> +			&rx_data[offset]);

Nit: this line break seems unnecessary.

> +
> +		/* Identify the max report length the module will receive */
> +		if (usage_table[usage_id].is_report && max_offset > max_report_len)
> +			max_report_len = max_offset;
> +	}
> +	ts->usage_table_populated = true;
> +
> +	return max_report_len;
> +}
> +
> +/* Retrieve, store and print the axiom device information */

This comment does not seem particularly helpful.

> +static int axiom_discover(struct axiom_data *ts)
> +{
> +	struct axiom_devinfo *devinfo = &ts->devinfo;
> +	struct device *dev = ts->dev;
> +	char *rx_data = ts->rx_buf;
> +	int ret;

In input, variables that represent a negative error code (fail) or zero (pass)
tend to be called 'error'.

> +
> +	/*
> +	 * Fetch the first page of usage u31 to get the
> +	 * device information and the number of usages
> +	 */
> +	ret = axiom_i2c_read(ts->client, AXIOM_DEVINFO_USAGE_ID, 0, rx_data,
> +			     AXIOM_U31_PAGE0_LENGTH);
> +	if (ret)
> +		return ret;
> +
> +	devinfo->bootmode = (rx_data[0] & AXIOM_U31_BOOTMODE_MASK);
> +	devinfo->device_id = ((rx_data[1] & AXIOM_PAGE_OFFSET_MASK) << 8) | rx_data[0];
> +	devinfo->fw_minor = rx_data[2];
> +	devinfo->fw_major = rx_data[3];
> +	devinfo->fw_info_extra = rx_data[4];
> +	devinfo->bootloader_fw_minor = rx_data[6];
> +	devinfo->bootloader_fw_major = rx_data[7];
> +	devinfo->jedec_id = (rx_data[8]) | (rx_data[9] << 8);
> +	devinfo->num_usages = rx_data[10];
> +	devinfo->silicon_revision = rx_data[11];

Opinions may vary here, but mine is that it is a waste of memory and time
to read and parse all of this data, only to print it at debug level. Unless
these variables are used elsewhere or reported to user space via sysfs, I
would drop all of this. It seems like cruft leftover from a vendor driver.

If you feel strongly about keeping these variables, then axiom_devinfo should
be defined as a packed struct to prevent having to disect rx_data[] byte by
byte. You should just read into &devinfo directly.

> +
> +	dev_dbg(dev, "  Boot Mode: %s\n", ts->devinfo.bootmode ? "BLP" : "TCP");
> +	dev_dbg(dev, "  Device ID      : %04x\n", ts->devinfo.device_id);
> +	dev_dbg(dev, "  Firmware Rev   : %02x.%02x\n", ts->devinfo.fw_major,
> +		ts->devinfo.fw_minor);
> +	dev_dbg(dev, "  Bootloader Rev : %02x.%02x\n",
> +		ts->devinfo.bootloader_fw_major,
> +		ts->devinfo.bootloader_fw_minor);
> +	dev_dbg(dev, "  FW Extra Info  : %04x\n", ts->devinfo.fw_info_extra);
> +	dev_dbg(dev, "  Silicon        : %02x\n", ts->devinfo.jedec_id);
> +	dev_dbg(dev, "  Num Usages     : %04x\n", ts->devinfo.num_usages);
> +
> +	/* Read the second page of usage u31 to get the usage table */
> +	ret = axiom_i2c_read(ts->client, AXIOM_DEVINFO_USAGE_ID, 1, rx_data,
> +			     (AXIOM_U31_BYTES_PER_USAGE * ts->devinfo.num_usages));
> +	if (ret)
> +		return ret;
> +
> +	ts->max_report_len = axiom_populate_usage_table(ts, rx_data);
> +	dev_dbg(dev, "Max Report Length: %u\n", ts->max_report_len);
> +
> +	return 0;
> +}
> +
> +/*
> + * Support function to axiom_process_u41_report.
> + * Generates input-subsystem events for every target.
> + * After calling this function the caller shall issue
> + * a Sync to the input sub-system.
> + */
> +static bool
> +axiom_process_u41_report_target(struct axiom_data *ts,
> +				struct axiom_target_report *target)
> +{
> +	struct input_dev *input_dev = ts->input_dev;
> +	enum axiom_target_state current_state;
> +	struct u41_target *target_prev_state;
> +	struct device *dev = ts->dev;
> +	bool update = false;
> +	int slot;
> +
> +	/* Verify the target index */
> +	if (target->index >= AXIOM_U41_MAX_TARGETS) {
> +		dev_dbg(dev, "Invalid target index! %u\n", target->index);
> +		return false;
> +	}
> +
> +	target_prev_state = &ts->targets[target->index];
> +
> +	current_state = TARGET_STATE_NOT_PRESENT;
> +
> +	if (target->present) {
> +		if (target->z >= 0)
> +			current_state = TARGET_STATE_TOUCHING;
> +		else if (target->z > AXIOM_PROX_LEVEL && target->z < 0)
> +			current_state = TARGET_STATE_HOVER;
> +		else if (target->z AXIOM_PROX_LEVEL)
> +			current_state = TARGET_STATE_PROX;
> +	}
> +
> +	if (target_prev_state->state == current_state &&
> +	    target_prev_state->x == target->x &&
> +	    target_prev_state->y == target->y &&
> +	    target_prev_state->z == target->z) {
> +		return false;
> +	}
> +
> +	slot = target->index;
> +
> +	dev_dbg(dev, "U41 Target T%u, slot:%u present:%u, x:%u, y:%u, z:%d\n",
> +		target->index, slot, target->present,
> +		target->x, target->y, target->z);
> +
> +	switch (current_state) {
> +	case TARGET_STATE_NOT_PRESENT:
> +	case TARGET_STATE_PROX:
> +		if (target_prev_state->insert)
> +			break;
> +		update = true;
> +		target_prev_state->insert = false;
> +		input_mt_slot(input_dev, slot);
> +
> +		if (!slot)
> +			input_report_key(input_dev, BTN_LEFT, 0);
> +
> +		input_mt_report_slot_inactive(input_dev);
> +		/*
> +		 * make sure the previous coordinates are
> +		 * all off screen when the finger comes back
> +		 */
> +		target->x = 65535;
> +		target->y = 65535;
> +		target->z = AXIOM_PROX_LEVEL;
> +		break;
> +	case TARGET_STATE_HOVER:
> +	case TARGET_STATE_TOUCHING:
> +		target_prev_state->insert = true;
> +		update = true;
> +		input_mt_slot(input_dev, slot);
> +		input_report_abs(input_dev, ABS_MT_TRACKING_ID, slot);
> +		input_report_abs(input_dev, ABS_MT_POSITION_X, target->x);
> +		input_report_abs(input_dev, ABS_X, target->x);
> +		input_report_abs(input_dev, ABS_MT_POSITION_Y, target->y);
> +		input_report_abs(input_dev, ABS_Y, target->y);
> +
> +		if (current_state == TARGET_STATE_TOUCHING) {
> +			input_report_abs(input_dev, ABS_MT_DISTANCE, 0);
> +			input_report_abs(input_dev, ABS_DISTANCE, 0);
> +			input_report_abs(input_dev, ABS_MT_PRESSURE, target->z);
> +			input_report_abs(input_dev, ABS_PRESSURE, target->z);
> +		} else {
> +			input_report_abs(input_dev, ABS_MT_DISTANCE, -target->z);
> +			input_report_abs(input_dev, ABS_DISTANCE, -target->z);
> +			input_report_abs(input_dev, ABS_MT_PRESSURE, 0);
> +			input_report_abs(input_dev, ABS_PRESSURE, 0);
> +		}
> +
> +		if (!slot)
> +			input_report_key(input_dev, BTN_LEFT, (current_state ==
> +					 TARGET_STATE_TOUCHING));
> +		break;
> +	}
> +
> +	target_prev_state->state = current_state;
> +	target_prev_state->x = target->x;
> +	target_prev_state->y = target->y;
> +	target_prev_state->z = target->z;
> +
> +	if (update)
> +		input_mt_sync_frame(input_dev);
> +
> +	return update;
> +}
> +
> +/*
> + * Take a raw buffer with u41 report data and decode it.
> + * Also generate input events if needed.
> + * rx_buf: ptr to a byte array [0]: Usage number [1]: Status LSB [2]: Status MSB
> + */
> +static void axiom_process_u41_report(struct axiom_data *ts, char *rx_buf)
> +{
> +	struct input_dev *input_dev = ts->input_dev;
> +	struct axiom_target_report target;
> +	bool update_done = false;
> +	u16 target_status;
> +	u32 i;
> +
> +	target_status = ((rx_buf[1]) | (rx_buf[2] << 8));
> +
> +	for (i = 0; i < AXIOM_U41_MAX_TARGETS; i++) {
> +		char target_step = rx_buf[(i * 4)];
> +
> +		target.index = i;
> +		target.present = ((target_status & (1 << i)) != 0) ? 1 : 0;
> +		target.x = ((target_step + 3) | ((target_step + 4) << 8));
> +		target.y = ((target_step + 5) | ((target_step + 6) << 8));
> +		target.z = (s8)(rx_buf[i + 43]);
> +		update_done |= axiom_process_u41_report_target(ts, &target);
> +	}
> +
> +	if (update_done)
> +		input_sync(input_dev);
> +}
> +
> +static void axiom_process_u46_report(struct axiom_data *ts, char *rx_buf)
> +{
> +	struct input_dev *input_dev = ts->input_dev;
> +	u32 event_value;
> +	u16 aux_value;
> +	u32 i = 0;
> +
> +	for (i = 0; i < AXIOM_U46_AUX_CHANNELS; i++) {
> +		char target_step = rx_buf[(i * 2)];
> +
> +		aux_value = (((target_step + 2) << 8) | (target_step + 1)) & AXIOM_U46_AUX_MASK;
> +		event_value = (i << 16) | (aux_value);
> +		input_event(input_dev, EV_MSC, MSC_RAW, event_value);
> +	}
> +
> +	input_mt_sync(input_dev);
> +	input_sync(input_dev);
> +}

Please forgive me in case I am simply slow to understand, but I really do
not think we can accept this kind of encapsulation. We have multiple calls
to input_mt_sync() and input_sync() spread across different functions, one
of which uses a 'done' flag to make a decision. It's also unclear what 'u41'
and 'u46' represent. The current implementation is too confusing to review
effectively IMO.

What we ultimately want to see here is one homogenous event handler where
MT slots are processed, followed by one call to input_mt_sync(), itself
followed by one call to input_sync() after any additional events (e.g. keys)
are processed. It's certainly OK to break out some processing into helper
functions, but we ultimately want to see one entry point into the input core.

Please consider whether there is a more maintainable way to organize this
processing; it seems more complex than other touchscreen drivers.

> +
> +/*
> + * Validates the crc and demultiplexes the axiom reports to the appropriate
> + * report handler
> + */
> +static void axiom_handle_events(struct axiom_data *ts)
> +{
> +	char *report_data = ts->rx_buf;
> +	struct device *dev = ts->dev;
> +	char usage = report_data[1];
> +	u16 crc_report;
> +	u16 crc_calc;
> +	char len;
> +
> +	axiom_i2c_read(ts->client, AXIOM_REPORT_USAGE_ID, 0, report_data, ts->max_report_len);

If this read fails due to a HW problem, the rest of this function will act
upon garbage data.

> +
> +	if ((report_data[0] & AXIOM_COMMS_OVERFLOW_MASK) != 0)
> +		ts->report_overflow_counter++;
> +
> +	len = (report_data[0] & AXIOM_COMMS_REPORT_LEN_MASK) * 2;
> +	if (!len) {
> +		dev_err(dev, "Zero length report discarded.\n");
> +		return;

Please make the return type of helper functions like axiom_handle_events() of
type int, and consider -ENODATA for this particular condition.

Even though callers to axiom_handle_events() are void at this time, you should
start out with the driver being flexible in case it grows over time.

> +	}
> +
> +	dev_dbg(dev, "Payload Data %*ph\n", len, report_data);
> +
> +	/* Validate the report CRC */
> +	crc_report = (report_data[len - 1] << 8) | (report_data[len - 2]);
> +	/* Length is in 16 bit words and remove the size of the CRC16 itself */
> +	crc_calc = crc16(0, report_data, (len - 2));
> +
> +	if (crc_calc != crc_report) {
> +		dev_err(dev,
> +			"CRC mismatch! Expected: %#x, Calculated CRC: %#x.\n",
> +			crc_report, crc_calc);
> +		return;

Return -EINVAL after promoting the return type to int.

> +	}
> +
> +	switch (usage) {
> +	case AXIOM_USAGE_2DCTS_REPORT_ID:
> +		axiom_process_u41_report(ts, &report_data[1]);
> +		break;
> +
> +	case AXIOM_USAGE_2AUX_REPORT_ID:
> +		/* This is an aux report (force) */
> +		axiom_process_u46_report(ts, &report_data[1]);
> +		break;
> +
> +	case AXIOM_USAGE_2HB_REPORT_ID:
> +		/* This is a heartbeat report */
> +		break;

Since 'usage' is read from the HW, we need a default branch for handling
unexpected values.

> +	}
> +
> +	ts->report_counter++;

This counter appears to be unused.

> +}
> +
> +static void axiom_i2c_poll(struct input_dev *input_dev)
> +{
> +	struct axiom_data *ts = input_get_drvdata(input_dev);
> +
> +	axiom_handle_events(ts);
> +}
> +
> +static irqreturn_t axiom_irq(int irq, void *dev_id)
> +{
> +	struct axiom_data *ts = dev_id;
> +
> +	axiom_handle_events(ts);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void axiom_reset(struct gpio_desc *reset_gpio)
> +{
> +	gpiod_set_value_cansleep(reset_gpio, 1);
> +	usleep_range(1000, 2000);
> +	gpiod_set_value_cansleep(reset_gpio, 0);
> +	msleep(100);
> +}
> +
> +/* Rebaseline the touchscreen, effectively zero-ing it */

What does it mean to rebaseline the touchscreen? I'm guessing it means
to null out or normalize pressure? Please consider a less colloquialized
function name.

Out of curiousity, what happens if the user's hand happens to be on the
touch surface at the time you call axiom_rebaseline()? Does the device
recover on its own?

> +static int axiom_rebaseline(struct axiom_data *ts)
> +{
> +	char buffer[8] = {};

Are you expecting each element to be initialized to zero?

> +
> +	buffer[0] = AXIOM_REBASELINE_CMD;
> +
> +	return axiom_i2c_write(ts->client, AXIOM_REPORT_USAGE_ID, 0, buffer, sizeof(buffer));
> +}
> +
> +static int axiom_i2c_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct input_dev *input_dev;
> +	struct axiom_data *ts;
> +	int ret;
> +	int target;
> +
> +	ts = devm_kzalloc(dev, sizeof(*ts), GFP_KERNEL);
> +	if (!ts)
> +		return -ENOMEM;
> +
> +	ts->client = client;
> +	i2c_set_clientdata(client, ts);
> +	ts->dev = dev;
> +
> +	ts->irq_gpio = devm_gpiod_get_optional(dev, "irq", GPIOD_IN);
> +	if (IS_ERR(ts->irq_gpio))
> +		return dev_err_probe(dev, PTR_ERR(ts->irq_gpio), "failed to get irq GPIO");
> +
> +	ts->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(ts->reset_gpio))
> +		return dev_err_probe(dev, PTR_ERR(ts->reset_gpio), "failed to get reset GPIO\n");
> +
> +	axiom_reset(ts->reset_gpio);

We shouldn't call axiom_reset() if reset_gpio is NULL. Even though the
calls to gpiod_set_value_cansleep() will bail safely, there is no reason
to make the CPU sleep for 100 ms if the device was not actually reset.

> +
> +	if (ts->irq_gpio) {
> +		ret = devm_request_threaded_irq(dev, client->irq, NULL,
> +						axiom_irq, 0, dev_name(dev), ts);

Did you mean to set IRQF_ONESHOT?

> +		if (ret < 0)
> +			return dev_err_probe(dev, ret, "Failed to request threaded IRQ\n");
> +	}

This is a kernel panic waiting to happen, as the interrupt handler (which can
post input events) is declared before the input device has been allocated.

Normally you want to set up interrupts last, after all resources have been
initialized and the HW has been configured.

> +
> +	ret = axiom_discover(ts);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed touchscreen discover\n");
> +
> +	ret = axiom_rebaseline(ts);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed touchscreen re-baselining\n");
> +
> +	input_dev = devm_input_allocate_device(ts->dev);
> +	if (!input_dev)
> +		return -ENOMEM;
> +
> +	input_dev->name = "TouchNetix aXiom Touchscreen";
> +	input_dev->phys = "input/axiom_ts";
> +
> +	/* Single Touch */
> +	input_set_abs_params(input_dev, ABS_X, 0, 65535, 0, 0);
> +	input_set_abs_params(input_dev, ABS_Y, 0, 65535, 0, 0);

You don't need to explicitly declare support for single-contact axes; 
input_mt_init_slots() does this for us.

> +
> +	/* Multi Touch */
> +	/* Min, Max, Fuzz (expected noise in px, try 4?) and Flat */
> +	input_set_abs_params(input_dev, ABS_MT_POSITION_X, 0, 65535, 0, 0);
> +	/* Min, Max, Fuzz (expected noise in px, try 4?) and Flat */
> +	input_set_abs_params(input_dev, ABS_MT_POSITION_Y, 0, 65535, 0, 0);
> +	input_set_abs_params(input_dev, ABS_MT_TOOL_TYPE, 0, MT_TOOL_MAX, 0, 0);
> +	input_set_abs_params(input_dev, ABS_MT_DISTANCE, 0, 127, 0, 0);
> +	input_set_abs_params(input_dev, ABS_MT_PRESSURE, 0, 127, 0, 0);
> +
> +	/* Registers the axiom device as a touchscreen instead of as a mouse pointer */
> +	input_mt_init_slots(input_dev, AXIOM_U41_MAX_TARGETS, INPUT_MT_DIRECT);

Please check the return value of input_mt_init_slots().

> +
> +	input_set_capability(input_dev, EV_KEY, BTN_LEFT);

Why to hard-code the key to BTN_LEFT as opposed to making it configurable via
device tree?

> +
> +	/* Enables the raw data for up to 4 force channels to be sent to the input subsystem */
> +	set_bit(EV_REL, input_dev->evbit);
> +	set_bit(EV_MSC, input_dev->evbit);
> +	/* Declare that we support "RAW" Miscellaneous events */
> +	set_bit(MSC_RAW, input_dev->mscbit);

The driver is not posting any REL events. Can you clarify what is represented
by MSC events?

> +
> +	if (!ts->irq_gpio) {
> +		ret = input_setup_polling(input_dev, axiom_i2c_poll);
> +		if (ret)
> +			return	dev_err_probe(ts->dev, ret, "Unable to set up polling mode\n");

Nit: extraneous space.

> +		input_set_poll_interval(input_dev, POLL_INTERVAL_DEFAULT_MS);
> +	}
> +
> +	ts->input_dev = input_dev;
> +	input_set_drvdata(ts->input_dev, ts);
> +
> +	/* Ensure that all reports are initialised to not be present. */
> +	for (target = 0; target < AXIOM_U41_MAX_TARGETS; target++)
> +		ts->targets[target].state = TARGET_STATE_NOT_PRESENT;
> +
> +	ret = input_register_device(input_dev);
> +

Nit: unnecessary NL.

> +	if (ret)
> +		return dev_err_probe(ts->dev, ret,
> +					"Could not register with Input Sub-system.\n");

Nit: alignment.

> +
> +	return 0;
> +}
> +
> +static void axiom_i2c_remove(struct i2c_client *client)
> +{
> +	struct axiom_data *ts = i2c_get_clientdata(client);
> +
> +	input_unregister_device(ts->input_dev);
> +}

This remove callback is unnecessary. So long as input_dev was allocated using
a device-managed function, it will be unregistered automatically.

> +
> +static const struct i2c_device_id axiom_i2c_id_table[] = {
> +	{ "axiom-ax54a" },
> +	{},

Nit: no need for a trailing comma after the sentinel, as no line would ever be
added beneath it.

> +};
> +

Nit: unnecessary NL.

> +MODULE_DEVICE_TABLE(i2c, axiom_i2c_id_table);
> +
> +static const struct of_device_id axiom_i2c_of_match[] = {
> +	{ .compatible = "touchnetix,axiom-ax54a", },
> +	{}
> +};
> +

And here.

> +MODULE_DEVICE_TABLE(of, axiom_i2c_of_match);
> +
> +static struct i2c_driver axiom_i2c_driver = {
> +	.driver = {
> +		   .name = "axiom",
> +		   .of_match_table = axiom_i2c_of_match,
> +	},
> +	.id_table = axiom_i2c_id_table,
> +	.probe = axiom_i2c_probe,
> +	.remove = axiom_i2c_remove,
> +};
> +
> +module_i2c_driver(axiom_i2c_driver);

And here.

> +
> +MODULE_AUTHOR("Bart Prescott <bartp@baasheep.co.uk>");
> +MODULE_AUTHOR("Pedro Torruella <pedro.torruella@touchnetix.com>");
> +MODULE_AUTHOR("Mark Satterthwaite <mark.satterthwaite@touchnetix.com>");
> +MODULE_AUTHOR("Hannah Rossiter <hannah.rossiter@touchnetix.com>");
> +MODULE_AUTHOR("Kamel Bouhara <kamel.bouhara@bootlin.com>");
> +MODULE_DESCRIPTION("TouchNetix aXiom touchscreen I2C bus driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.25.1
> 

Kind regards,
Jeff LaBundy
