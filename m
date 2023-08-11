Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B5077865C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 06:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbjHKEH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 00:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjHKEH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 00:07:26 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FF89B;
        Thu, 10 Aug 2023 21:07:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dk1YOZxpmC5OUkrqzvW5ayof9/SsV7LiLCdCy+hekrarK50yCPwyXr5bm9q9mGMFwkPIb8o89l6XU0ksj36Ne+QkWf5TN0bV2zkc1dyvm6C0cjrTV2TM7dwgCEJTXLeml7nv5CJ/rHuO7Zx27SZmsAs+D5+rdfg03VUZmfN1ke8Pd5WNDj143V8avxRYqvZTEpNe891ZvbX114GwVxdXbPAr4XcEdrhUyxSPnj7WyD2FZQPsg0E0FmvzP6Wtk98Cty6YycWhaMwAXMfQ/TfHX0lBUz8lenDEwU7T9vmVj07heTUcNYKq3JePZqoAZiXfHFd0cEzO1oitXYb1wYj0DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJnSCW5oxOPXLZ2yRy5XsBph4KOuK5V38qoOsXq9Uso=;
 b=mrTFYLkqyBxHdidN8HsjdLKM0rlnf6y8GVT63XZyAab9BcEMVev2zHSP1QIlXDhPAQPCamyTstMUZTa4EBcoh+2tikM8prh3CRZyqIVlwwnHAjoJpg4hYlfvi/CWe1fl3q4Y28TNeFblOkxq+wwZ1QlArNOv9AYH38mROLgfpLEG7VDqSlDdk8hB+8DHED5jDMV6gFDQnRGDBLHmzlSrNKhiIWc61Lkq0wcBN3jn5KOr2Bt8NI6E/Pj7gAvnW5Baftxj9QdRJUfKLrrKrrqr7fdvWBliz3S38u9hKjxdlBjFp6WdsMMBFeoYN2zRkh2tW6lFN6EUns3FVlrMPWTCJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJnSCW5oxOPXLZ2yRy5XsBph4KOuK5V38qoOsXq9Uso=;
 b=oaMRgrEFyEDul/JSLH6qPqniuRKDIBwbyn0bOJXDnUKhcl660NdBP13c1o/KG4c6ISsn6MVyk4GRwJaR58x8VeCdEk2Tm6DULRqd37HrRdkKhwP52DsiRLUp57WFSt/OypDRzCADjo6OXsqMHrkctQu+cNaDy380+BCdfO563Bc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by LV3PR08MB8960.namprd08.prod.outlook.com
 (2603:10b6:408:219::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 04:07:17 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::88bb:5369:6188:2b05]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::88bb:5369:6188:2b05%6]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 04:07:16 +0000
Date:   Thu, 10 Aug 2023 23:07:08 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     James Ogletree <james.ogletree@cirrus.com>
Cc:     dmitry.torokhov@gmail.com, Fred Treven <fred.treven@cirrus.com>,
        Ben Bright <ben.bright@cirrus.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Joel Stanley <joel@jms.id.au>, Arnd Bergmann <arnd@arndb.de>,
        Jacky Bai <ping.bai@nxp.com>, Jean Delvare <jdelvare@suse.de>,
        Eddie James <eajames@linux.ibm.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        patches@cirrus.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] Input: cs40l50 - Initial support for Cirrus Logic
 CS40L50
Message-ID: <ZNWz7F7qLeNKDlG/@nixie71>
References: <20230809191032.820271-1-james.ogletree@cirrus.com>
 <20230809191032.820271-3-james.ogletree@cirrus.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809191032.820271-3-james.ogletree@cirrus.com>
X-ClientProxiedBy: SN6PR01CA0034.prod.exchangelabs.com (2603:10b6:805:b6::47)
 To SN4PR0801MB3774.namprd08.prod.outlook.com (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|LV3PR08MB8960:EE_
X-MS-Office365-Filtering-Correlation-Id: 829b2c84-d24f-4f04-a4bb-08db9a2072c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AxKXD/vU6Ca+GykpblcES55XLCnX8nJmF3ickB1ahEGM3XZ4BvnlpitcAQ509dC6LzxMYKZ9s4t3eL6ZDIvOz+X4MBwoLWGKDKrmYFp3LT1r0pa9Oak8D4+Ez5//xSoYF9tsscNnJAErmnE2JvCb7TRGzzVrB1JS2EkQ+XUP9jsZ1ai1HFERp7oX6fM42MXqiz4fjQLMQGq/AQEGnrK8ESxfTY1uKxI77sll6TLZ9WGQ10spBIJhL1MJ8l1iLC9Ee3ozZ0/6WBstLlPckPsbkgj/Tfn8W6/OjIWTNnhnhEKnytCnTEOoHIfBp3V1CLQ/zOM01Ca+TQIjqMntMmTl+EpOxUImB+AZw6ZiTaQdYobrmQr343MaLF1ODzWZeeXZACVcLEtmHVACd9TqaG6vmLVQtoeaDdL1xMgNVawX3agWr4ttiwlf+YC0t0C63yUhqGGE28BLf8IT2FvOlnN+NU9zpOrKHvt1m7gi8u1SFcNgMsVNlghJqU8Qx7mURExTkhz2WeSPYuFBRI04snYZEYWYuXzuj3Mrc1kgmfaszGupDVsUQmAMkm2td74JfMa2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(346002)(376002)(39830400003)(366004)(136003)(451199021)(1800799006)(186006)(8676002)(8936002)(26005)(6506007)(41300700001)(2906002)(38100700002)(83380400001)(30864003)(33716001)(86362001)(7416002)(6916009)(66476007)(66946007)(66556008)(4326008)(6512007)(9686003)(54906003)(6486002)(478600001)(5660300002)(6666004)(316002)(559001)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t+7DkSttrCTEtFSvEJ5CqsNUm4zJjnY1od4sKijUA14gECl2jKHy/CFiiz3S?=
 =?us-ascii?Q?H4ZsP3uhp5U25IvqXk1qQpOGrFWImYSPmZpxu9NiazmBOQFN+P4h9pZYrDSk?=
 =?us-ascii?Q?w8mvwveqYi8FxD/RhBxBFchsYCqKmGFq8XiieFe/tF/XOiV5kfmcOZE6wpA9?=
 =?us-ascii?Q?Oro/TOS0zvNeRs7ktlIlwvoTY9ZZlMEQ9tsuJcl2iRrN8pYP3R2PQjGV/DC/?=
 =?us-ascii?Q?+kNIhc3LN9BK/9JeJGYfYyfqUcwRJQTpHv9d3HejRSTSFm6BSikKJyMakZHd?=
 =?us-ascii?Q?Y7isT2TKu43PmgsN0HrTXPZcjf9W4hSHWaQJJrjpaux8N8mhN+Xg895eiKws?=
 =?us-ascii?Q?8nYnDgaOQ2tQn4ekFbvWp9ALs09Tht1dvq46sZjgVq7ZyEQF0KSFizCw4k+c?=
 =?us-ascii?Q?tSG966vIEaJfV0TmCS7wB8+sejn5IpQpBpsbz5D78cQAsiV64NEWNFuZxv/M?=
 =?us-ascii?Q?RN1Z3iCdWTEGY+BjRsN7PBI70fuLkIZeUZ3ZCMah4KaVpCEx64I2+HM8Do3+?=
 =?us-ascii?Q?3DaPS1ouo/JH1rrhjlKIvyiI5r0AqpFougIrWPjeIHiDxtmAHUSj7iiVZoMz?=
 =?us-ascii?Q?ID4UTJg1HCAd/QsaCNzLSVXF2RLklTIuTi5CFCW6ABXGeLCMQ5+tIlkqK3S3?=
 =?us-ascii?Q?upJhQs+VthLt4S1KXtFIYjgU86cIQXshJkdxbgzzY1RqUqxOuC4yEiMT3Gj+?=
 =?us-ascii?Q?B01baeHFkQqguJcn5qqouVXVtwD+BXEho1dQbxT+vNV5zy1ETQUagrFUZ5Kt?=
 =?us-ascii?Q?eecZOV57PYoEdFbfMBNhNyMgt0sHB2rvKQlzKZjCUmMHo7npW9fouq2EYVcS?=
 =?us-ascii?Q?kwqySKgG53kXmDt7V3SHmEgRh5844oykGU8NM7w2eoon8IeZ22WMsCwCxj3g?=
 =?us-ascii?Q?9CFHnof72zHVxkG1CvLr2NqFS216xKoD7n+FWHDqggoEBftJd51KOAYOpRTz?=
 =?us-ascii?Q?Hd60bZAwIweXl1RRHHqaa1RbFPziMmQ1hUTWWgVMBc2jbDkjk7UhK9Dtq6Up?=
 =?us-ascii?Q?vzi1JmjBLTbuvE9UE3bylNzaqKdW6nYv6N0SQpkSAop010QeMQZwBz6NTm4Q?=
 =?us-ascii?Q?cJjFhxdQj5pXhBNillj5zRzq2pmOf120iMvVac48Jav9RTQOOJTyYOJVlEPL?=
 =?us-ascii?Q?I1tL2Cr9hcID/9Cnrm/Wu4dASgv8wCs8QPxn+bjGivS4icceX2k4LAVq+Ibq?=
 =?us-ascii?Q?xzeHriBDStaryki6N2Lp5ADxvg43SY0eaUCyBkkgJVgAyCaqVf+HJUnoypHf?=
 =?us-ascii?Q?q94UlWx2LKa/8//nU3wEDqWa2oAnYQNSRYg3/1dq0tLeZDcZQi3MnumxiWPI?=
 =?us-ascii?Q?cAu4pe1UlAv7GNYRMFlc91wKy3pktFDoVR8Dq+xNUfHoM49JpfKltqQvpv5g?=
 =?us-ascii?Q?ooedX3pZop8Zk/uo5H5qDagT5A1HY2mqSa0+SIIXkw7eJu3R1vvsuKNVCmKr?=
 =?us-ascii?Q?tH/cOVTCLkM/RG0Re0paSfY8hjOjB0C77WKSs2i1pKEaaEbctgQ/gbbj04tE?=
 =?us-ascii?Q?uJHdnFpFulPshepRMS1Y/wbiIqV2qy1Fwbe3J+8kvDQE+XaIkuC84K7nObQc?=
 =?us-ascii?Q?5f9VmKBhhbIN5uvG52TJmhIM/wvtSyiCJGI1Cw9j?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 829b2c84-d24f-4f04-a4bb-08db9a2072c3
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 04:07:16.2649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RhRlVl9uEaZfgnXe0hgHhr+jw5r0hUjnUkrSfWqF/Vl+teCQqLlj0EEjxNiXpHwC5629CCdM6TXhWfzDRm41zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR08MB8960
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

Great work as always; just some minor comments throughout.

On Wed, Aug 09, 2023 at 07:10:28PM +0000, James Ogletree wrote:
> Introduce support for Cirrus Logic Device CS40L50: a
> haptics driver with waveform memory DSP and closed-loop
> algorithms.

From my extremely naive point of view, some of the code that follows
bares resemblance to the recently reviewed L26. My assumption is that
these devices are different enough in nature to warrant completely
different drivers; is that accurate?

One reason for asking is because the L26 driver included a cornucopia
of power-management overhead, yet we see none of that here. Assuming
both L50 and L26 are built around the same Halo DSP, why is there such
a fundamental difference between the two in terms of power management?

To that end, how does this driver handle hibernation? Is hibernation
not supported, or do we simply defer to the DSP? In the case of the
latter, why is L50 given this freedom but not L26?

This is not a suggestion to change anything; it's just to help set the
context and provide more background information. However, I'm curious
whether you've considered consolidating both L26 and L50 into a single
driver, especially given recent discussion around promoting L26 into an
MFD with both input and codec children. Would L50 ever support audio-to
-haptics over I2S?

> 
> Signed-off-by: James Ogletree <james.ogletree@cirrus.com>
> ---
>  MAINTAINERS                      |    2 +
>  drivers/input/misc/Kconfig       |   33 +
>  drivers/input/misc/Makefile      |    3 +
>  drivers/input/misc/cs40l50-i2c.c |   67 ++
>  drivers/input/misc/cs40l50-spi.c |   67 ++
>  drivers/input/misc/cs40l50.c     | 1008 ++++++++++++++++++++++++++++++
>  include/linux/input/cs40l50.h    |  321 ++++++++++
>  7 files changed, 1501 insertions(+)
>  create mode 100644 drivers/input/misc/cs40l50-i2c.c
>  create mode 100644 drivers/input/misc/cs40l50-spi.c
>  create mode 100644 drivers/input/misc/cs40l50.c
>  create mode 100644 include/linux/input/cs40l50.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2869dd2dbbcf..e82d03293383 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2088,6 +2088,8 @@ M:	Ben Bright <ben.bright@cirrus.com>
>  L:	patches@opensource.cirrus.com
>  S:	Supported
>  F:	Documentation/devicetree/bindings/input/cirrus,cs40l50.yaml
> +F:	drivers/input/misc/cs40l*
> +F:	include/linux/input/cs40l*
>  
>  ARM/CLKDEV SUPPORT
>  M:	Russell King <linux@armlinux.org.uk>
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index c47eecc6f83b..c1c1572ec39c 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -140,6 +140,39 @@ config INPUT_BMA150
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called bma150.
>  
> +config INPUT_CS40L50
> +	tristate "Cirrus Logic CS40L50 Haptic Driver support"
> +	select CS_DSP
> +	select REGMAP_IRQ
> +	help
> +	  Say Y here to enable support for CS40L50 boosted haptic
> +	  driver.
> +
> +	  To compile the driver as a module choose M here: the module
> +	  will be called cs40l50.
> +
> +config INPUT_CS40L50_I2C
> +	tristate "Support I2C bus connection"
> +	depends on INPUT_CS40L50 && I2C
> +	select REGMAP_I2C
> +	help
> +	  Say Y here if you have Cirrus Logic's CS40L50 connected
> +	  to an I2C bus.
> +
> +	  To compile the driver as a module choose M here: the
> +	  module will be called cs40l50_i2c.
> +
> +config INPUT_CS40L50_SPI
> +	tristate "Support SPI bus connection"
> +	depends on INPUT_CS40L50 && SPI
> +	select REGMAP_SPI
> +	help
> +	  Say Y here if you have Cirrus Logic's CS40L50 connected
> +	  to a SPI bus.
> +
> +	  To compile the driver as a module choose M here: the
> +	  module will be called cs40l50_spi.
> +
>  config INPUT_E3X0_BUTTON
>  	tristate "NI Ettus Research USRP E3xx Button support."
>  	default n
> diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
> index 04296a4abe8e..77f34a33c364 100644
> --- a/drivers/input/misc/Makefile
> +++ b/drivers/input/misc/Makefile
> @@ -28,6 +28,9 @@ obj-$(CONFIG_INPUT_CMA3000)		+= cma3000_d0x.o
>  obj-$(CONFIG_INPUT_CMA3000_I2C)		+= cma3000_d0x_i2c.o
>  obj-$(CONFIG_INPUT_COBALT_BTNS)		+= cobalt_btns.o
>  obj-$(CONFIG_INPUT_CPCAP_PWRBUTTON)	+= cpcap-pwrbutton.o
> +obj-$(CONFIG_INPUT_CS40L50)		+= cs40l50.o
> +obj-$(CONFIG_INPUT_CS40L50_I2C)		+= cs40l50-i2c.o
> +obj-$(CONFIG_INPUT_CS40L50_SPI)		+= cs40l50-spi.o
>  obj-$(CONFIG_INPUT_DA7280_HAPTICS)	+= da7280.o
>  obj-$(CONFIG_INPUT_DA9052_ONKEY)	+= da9052_onkey.o
>  obj-$(CONFIG_INPUT_DA9055_ONKEY)	+= da9055_onkey.o
> diff --git a/drivers/input/misc/cs40l50-i2c.c b/drivers/input/misc/cs40l50-i2c.c
> new file mode 100644
> index 000000000000..6ebe1b51990b
> --- /dev/null
> +++ b/drivers/input/misc/cs40l50-i2c.c
> @@ -0,0 +1,67 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * CS40L50 Advanced Haptic Driver with Waveform Memory DSP
> + * and Closed-Loop Algorithms

Nit: the capitalization and general sentence structure here is hard to
follow; maybe something like "... with DSP-based waveform memory and
closed-loop algorithms" would make more sense?

> + *
> + * Copyright 2023 Cirrus Logic, Inc.
> + *
> + */
> +#include <linux/i2c.h>
> +#include <linux/input/cs40l50.h>
> +
> +static const struct i2c_device_id cs40l50_id_i2c[] = {
> +	{"cs40l50", 0},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, cs40l50_id_i2c);
> +
> +static const struct of_device_id cs40l50_of_match[] = {
> +	{ .compatible = "cirrus,cs40l50" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, cs40l50_of_match);
> +
> +static int cs40l50_i2c_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct cs40l50_private *cs40l50;
> +
> +	cs40l50 = devm_kzalloc(dev, sizeof(*cs40l50), GFP_KERNEL);
> +	if (!cs40l50)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, cs40l50);
> +
> +	cs40l50->regmap = devm_regmap_init_i2c(client, &cs40l50_regmap);
> +	if (IS_ERR(cs40l50->regmap))
> +		return dev_err_probe(cs40l50->dev, PTR_ERR(cs40l50->regmap),
> +				"Failed to initialize register map\n");

Nit: line breaks tend to be more readable when aligned against the
parenthesis as follows:

	if (...)
		return dev_err_probe(...,
				     ...);

At least, it's much more common.

> +
> +	cs40l50->dev = dev;
> +	cs40l50->irq = client->irq;
> +
> +	return cs40l50_probe(cs40l50);
> +}
> +
> +static void cs40l50_i2c_remove(struct i2c_client *client)
> +{
> +	struct cs40l50_private *cs40l50 = i2c_get_clientdata(client);
> +
> +	cs40l50_remove(cs40l50);
> +}
> +
> +static struct i2c_driver cs40l50_i2c_driver = {
> +	.driver = {
> +		.name = "cs40l50",
> +		.of_match_table = cs40l50_of_match,
> +	},
> +	.id_table = cs40l50_id_i2c,
> +	.probe_new = cs40l50_i2c_probe,

Mainline has moved back to .probe now; .probe_new is becoming depracated.

> +	.remove = cs40l50_i2c_remove,
> +};
> +
> +module_i2c_driver(cs40l50_i2c_driver);
> +
> +MODULE_DESCRIPTION("CS40L50 I2C Driver");
> +MODULE_AUTHOR("James Ogletree, Cirrus Logic Inc. <james.ogletree@cirrus.com>");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/input/misc/cs40l50-spi.c b/drivers/input/misc/cs40l50-spi.c
> new file mode 100644
> index 000000000000..5fcf3ba137f0
> --- /dev/null
> +++ b/drivers/input/misc/cs40l50-spi.c
> @@ -0,0 +1,67 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * CS40L50 Advanced Haptic Driver with Waveform Memory DSP
> + * and Closed-Loop Algorithms
> + *
> + * Copyright 2023 Cirrus Logic, Inc.
> + *
> + */
> +#include <linux/spi/spi.h>
> +#include <linux/input/cs40l50.h>
> +
> +static const struct spi_device_id cs40l50_id_spi[] = {
> +	{"cs40l50", 0},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(spi, cs40l50_id_spi);
> +
> +static const struct of_device_id cs40l50_of_match[] = {
> +	{ .compatible = "cirrus,cs40l50" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, cs40l50_of_match);
> +
> +static int cs40l50_spi_probe(struct spi_device *spi)
> +{
> +	struct cs40l50_private *cs40l50;
> +	struct device *dev = &spi->dev;
> +
> +	cs40l50 = devm_kzalloc(dev, sizeof(*cs40l50), GFP_KERNEL);
> +	if (!cs40l50)
> +		return -ENOMEM;
> +
> +	spi_set_drvdata(spi, cs40l50);
> +
> +	cs40l50->regmap = devm_regmap_init_spi(spi, &cs40l50_regmap);
> +	if (IS_ERR(cs40l50->regmap))
> +		return dev_err_probe(cs40l50->dev, PTR_ERR(cs40l50->regmap),
> +					"Failed to initialize register map\n");
> +
> +	cs40l50->dev = dev;
> +	cs40l50->irq = spi->irq;
> +
> +	return cs40l50_probe(cs40l50);
> +}
> +
> +static void cs40l50_spi_remove(struct spi_device *spi)
> +{
> +	struct cs40l50_private *cs40l50 = spi_get_drvdata(spi);
> +
> +	cs40l50_remove(cs40l50);
> +}
> +
> +static struct spi_driver cs40l50_spi_driver = {
> +	.driver = {
> +		.name = "cs40l50",
> +		.of_match_table = cs40l50_of_match,
> +	},
> +	.id_table = cs40l50_id_spi,
> +	.probe = cs40l50_spi_probe,
> +	.remove = cs40l50_spi_remove,
> +};
> +
> +module_spi_driver(cs40l50_spi_driver);
> +
> +MODULE_DESCRIPTION("CS40L50 SPI Driver");
> +MODULE_AUTHOR("James Ogletree, Cirrus Logic Inc. <james.ogletree@cirrus.com>");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/input/misc/cs40l50.c b/drivers/input/misc/cs40l50.c
> new file mode 100644
> index 000000000000..9bb2881683c0
> --- /dev/null
> +++ b/drivers/input/misc/cs40l50.c
> @@ -0,0 +1,1008 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * CS40L50 Advanced Haptic Driver with Waveform Memory DSP
> + * and Closed-Loop Algorithms
> + *
> + * Copyright 2023 Cirrus Logic, Inc.
> + *
> + */
> +#include <linux/firmware.h>
> +#include <linux/i2c.h>

Why to #include i2c.h here? This driver should be agnostic to the transport.

> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/string.h>
> +#include <linux/bitfield.h>
> +#include <linux/input/cs40l50.h>

Please sort these alphabetically. Are you sure you're using all of them?

> +
> +const struct regmap_config cs40l50_regmap = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +	.reg_format_endian = REGMAP_ENDIAN_BIG,
> +	.val_format_endian = REGMAP_ENDIAN_BIG,
> +};
> +EXPORT_SYMBOL_GPL(cs40l50_regmap);
> +
> +static struct regulator_bulk_data cs40l50_supplies[] = {
> +	{ .supply = "vp" },
> +	{ .supply = "vio" },
> +	{ .supply = "va" },
> +};
> +
> +static int cs40l50_dsp_write(struct cs40l50_private *cs40l50, u32 write_reg, u32 write_val)
> +{
> +	int error = 0, i;

No need to initialize 'error' here.

> +
> +	for (i = 0; i < CS40L50_DSP_TIMEOUT_COUNT; i++) {
> +		error = regmap_write(cs40l50->regmap, write_reg, write_val);
> +		if (!error)
> +			break;

This seems more efficient:

		if (!error)
			return 0;

...then you can avoid the check for i == CS40L50_DSP_TIMEOUT_COUNT below.

> +
> +		usleep_range(CS40L50_DSP_POLL_US, CS40L50_DSP_POLL_US + 100);
> +	}
> +
> +	if (i == CS40L50_DSP_TIMEOUT_COUNT) {
> +		dev_err(cs40l50->dev, "Error writing %#X to %#X: %d", write_val, write_reg, error);
> +		return error;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cs40l50_dsp_read(struct cs40l50_private *cs40l50, u32 read_reg, u32 *read_val)
> +{
> +	int error = 0, i;

...and here.

> +
> +	for (i = 0; i < CS40L50_DSP_TIMEOUT_COUNT; i++) {
> +		error = regmap_read(cs40l50->regmap, read_reg, read_val);
> +		if (!error)
> +			break;

...and here.

> +
> +		usleep_range(CS40L50_DSP_POLL_US, CS40L50_DSP_POLL_US + 100);
> +	}
> +
> +	if (i == CS40L50_DSP_TIMEOUT_COUNT) {
> +		dev_err(cs40l50->dev, "Error reading %#X: %d", read_reg, error);
> +		return error;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cs40l50_pseq_write(struct cs40l50_private *cs40l50, u32 addr, u32 data)
> +{
> +	u8 operation = 0;
> +	struct cs40l50_pseq_op *op_new, *op_end;
> +	int error;

Nit: it is kind of personal preference, but "reverse Christmas tree" tends
to be more common, i.e. move the struct definitions (longest) to the top.

> +
> +	op_new = devm_kzalloc(cs40l50->dev, sizeof(*op_new), GFP_KERNEL);
> +	if (!op_new)
> +		return -ENOMEM;
> +
> +	op_new->words[0] = (addr >> CS40L50_PSEQ_WRITE_FULL_UPPER_ADDR_SHIFT);
> +	op_new->words[1] = ((addr & CS40L50_PSEQ_WRITE_FULL_LOWER_ADDR_MASK) <<
> +			CS40L50_PSEQ_WRITE_FULL_LOWER_ADDR_SHIFT) |
> +			(data >> CS40L50_PSEQ_WRITE_FULL_UPPER_DATA_SHIFT);

Nit: consider aligning the line breaks past the equal sign for readability.

> +	op_new->words[2] = data & CS40L50_PSEQ_WRITE_FULL_LOWER_DATA_MASK;
> +
> +	list_for_each_entry(op_end, &cs40l50->pseq_op_head, list) {
> +		operation = op_end->operation;
> +		if (operation == CS40L50_PSEQ_OP_END)
> +			break;
> +	}
> +
> +	if (operation != CS40L50_PSEQ_OP_END) {
> +		error = -ENOENT;
> +		goto op_new_free;
> +	}
> +
> +	if ((CS40L50_PSEQ_MAX_WORDS - op_end->offset) < ARRAY_SIZE(op_new->words)) {
> +		error = -ENOSPC;
> +		goto op_new_free;
> +	}
> +
> +	op_new->offset = op_end->offset;
> +	op_end->offset += (ARRAY_SIZE(op_new->words) * sizeof(u32));
> +
> +	error = regmap_bulk_write(cs40l50->regmap, CS40L50_DSP1_POWER_ON_SEQ + op_new->offset,
> +			op_new->words, ARRAY_SIZE(op_new->words));

Nit: alignment

> +	if (error)
> +		goto op_new_free;
> +
> +	error = cs40l50_dsp_write(cs40l50, CS40L50_DSP1_POWER_ON_SEQ + op_end->offset,
> +			op_end->words[0]);

...and here.

> +	if (error)
> +		goto op_new_free;
> +
> +	list_add(&op_new->list, &cs40l50->pseq_op_head);
> +
> +	return 0;
> +
> +op_new_free:
> +	devm_kfree(cs40l50->dev, op_new);
> +
> +	return error;
> +}
> +
> +static struct cs40l50_effect *cs40l50_find_effect(struct cs40l50_private *cs40l50, int id)
> +{
> +	struct cs40l50_effect *effect;
> +
> +	if (!list_empty(&cs40l50->effect_head)) {
> +		list_for_each_entry(effect, &cs40l50->effect_head, list) {
> +			if (effect->id == id)
> +				return effect;
> +		}
> +	}

Are you sure the check against list_empty is necessary? Won't list_for_each_entry()
simply be a NOP if the list is empty? (genuine question)

> +
> +	return NULL;
> +}
> +
> +static int cs40l50_owt_upload(struct cs40l50_private *cs40l50, s16 *in_data, u32 in_data_nibbles)
> +{
> +	size_t in_data_bytes = 2 * in_data_nibbles;
> +	struct cs40l50_owt_header header;
> +	u32 wt_offset, wt_size_words;
> +	int error;
> +	u8 *data;
> +
> +	error = cs40l50_dsp_read(cs40l50, CS40L50_DSP1_OWT_NEXT, &wt_offset);
> +	if (error)
> +		return error;
> +
> +	error = cs40l50_dsp_read(cs40l50, CS40L50_DSP1_OWT_SIZE, &wt_size_words);
> +	if (error)
> +		return error;
> +
> +	if ((wt_size_words * sizeof(u32)) < CS40L50_WT_HEADER_PWLE_SIZE + in_data_bytes)
> +		return -ENOSPC;
> +
> +	data = kcalloc(CS40L50_WT_HEADER_PWLE_SIZE + in_data_bytes, sizeof(u8), GFP_KERNEL);
> +	if (IS_ERR_OR_NULL(data))
> +		return -ENOMEM;
> +
> +	header.wvfrm_type = in_data[0] == CS40L50_PCM_ID ? CS40L50_WT_TYPE_PCM :
> +			CS40L50_WT_TYPE_PWLE;

Nit: this is a bit more readable:

	header.wvfrm_type = in_data[0] == CS40L50_PCM_ID ? CS40L50_WT_TYPE_PCM
							 : CS40L50_WT_TYPE_PWLE;

> +	header.offset = CS40L50_WT_HEADER_OFFSET;
> +	header.data_size = in_data_bytes / sizeof(u32);
> +
> +	memcpy(data, &header, sizeof(header));
> +	memcpy(data + (CS40L50_WT_HEADER_OFFSET * sizeof(u32)), in_data, in_data_bytes);
> +
> +	error = regmap_bulk_write(cs40l50->regmap, CS40L50_DSP1_OWT_BASE +
> +			(wt_offset * sizeof(u32)), data,
> +			CS40L50_WT_HEADER_PWLE_SIZE + in_data_bytes);
> +	if (error)
> +		goto err_free;
> +
> +	error = cs40l50_dsp_write(cs40l50, CS40L50_DSP_VIRTUAL1_MBOX_1, CS40L50_MBOX_CMD_OWT_PUSH);
> +err_free:
> +	kfree(data);

We can avoid a goto and label for this simple case as follows:

	error = ...
	if (!error)
		error = ...

	kfree(...);

	return error;

> +
> +	return error;
> +}
> +
> +static int cs40l50_add_effect(struct input_dev *dev, struct ff_effect *effect,
> +		struct ff_effect *old)

Nit: alignment

> +{
> +	struct cs40l50_private *cs40l50 = input_get_drvdata(dev);
> +	bool is_new = false;
> +	struct cs40l50_effect *new_effect;
> +	u32 nwaves, base_index, max_index;
> +	s16 *raw_custom_data;
> +	int error;
> +
> +	if (effect->type != FF_PERIODIC || effect->u.periodic.waveform != FF_CUSTOM) {
> +		dev_err(cs40l50->dev, "Type (%#X) or waveform (%#X) unsupported\n",
> +				effect->type, effect->u.periodic.waveform);
> +		return -EINVAL;
> +	}
> +
> +	raw_custom_data = kcalloc(effect->u.periodic.custom_len, sizeof(s16), GFP_KERNEL);
> +	if (IS_ERR_OR_NULL(raw_custom_data))
> +		return -ENOMEM;
> +
> +	error = copy_from_user(raw_custom_data, effect->u.periodic.custom_data,
> +			sizeof(s16) * effect->u.periodic.custom_len);
> +	if (error)
> +		goto out_free;
> +
> +	mutex_lock(&cs40l50->lock);
> +
> +	new_effect = cs40l50_find_effect(cs40l50, effect->id);
> +	if (!new_effect) {
> +		is_new = true;
> +		new_effect = kzalloc(sizeof(*new_effect), GFP_KERNEL);
> +		if (IS_ERR_OR_NULL(new_effect)) {
> +			error = -ENOMEM;
> +			goto err_mutex;
> +		}
> +	}
> +
> +	if (effect->u.periodic.custom_len > CS40L50_CUSTOM_DATA_SIZE) {
> +		error = cs40l50_dsp_read(cs40l50, CS40L50_NUM_OF_OWT_WAVES,
> +				&new_effect->trigger_index);
> +		if (error)
> +			goto err_free;
> +
> +		new_effect->wvfrm_bank = CS40L50_WVFRM_BANK_OWT;
> +		base_index = CS40L50_OWT_INDEX_START;
> +		max_index = CS40L50_OWT_INDEX_END;
> +	} else {
> +		new_effect->trigger_index = (raw_custom_data[1] & 0xffffu);
> +		new_effect->wvfrm_bank = (raw_custom_data[0] & 0xffffu);
> +
> +		if (new_effect->wvfrm_bank == CS40L50_WVFRM_BANK_ROM) {
> +			base_index = CS40L50_ROM_BANK_INDEX_START;
> +			max_index = CS40L50_ROM_BANK_INDEX_END;
> +		} else if (new_effect->wvfrm_bank == CS40L50_WVFRM_BANK_RAM) {
> +			error = cs40l50_dsp_read(cs40l50, CS40L50_NUM_OF_WAVES, &nwaves);
> +			if (error)
> +				goto err_free;
> +
> +			base_index = CS40L50_RAM_BANK_INDEX_START;
> +			max_index = base_index + nwaves - 1;
> +		} else {
> +			dev_err(cs40l50->dev, "Invalid waveform bank\n");
> +			error = -EINVAL;
> +			goto err_free;
> +		}
> +	}
> +
> +	new_effect->trigger_index += base_index;
> +
> +	if (new_effect->trigger_index > max_index) {
> +		dev_err(cs40l50->dev, "Index %#X out of bounds\n", new_effect->trigger_index);
> +		error = -EINVAL;
> +		goto err_free;
> +	}
> +
> +	if (effect->trigger.button) {
> +		new_effect->mapping = CS40L50_DSP1_GPIO_BASE + sizeof(u32) *
> +				FIELD_GET(CS40L50_BTN_NUM_MASK, effect->trigger.button) * 2 -
> +				FIELD_GET(CS40L50_BTN_EDGE_MASK, effect->trigger.button);
> +
> +		error = cs40l50_dsp_write(cs40l50, new_effect->mapping, effect->trigger.button);
> +		if (error)
> +			goto err_free;
> +	}
> +
> +	if (new_effect->wvfrm_bank == CS40L50_WVFRM_BANK_OWT) {
> +		error = cs40l50_owt_upload(cs40l50, raw_custom_data,
> +				effect->u.periodic.custom_len);
> +		if (error)
> +			goto err_free;
> +	}
> +
> +err_free:
> +	if (is_new)
> +		error ? kfree(new_effect) : list_add(&new_effect->list, &cs40l50->effect_head);

Just wanted to echo Charles' point that this made my head spin a bit. Good
to know it's not just me ;)

> +err_mutex:
> +	mutex_unlock(&cs40l50->lock);
> +out_free:
> +	kfree(raw_custom_data);
> +
> +	return error ? -EFAULT : 0;
> +}
> +
> +
> +static void cs40l50_vibe_start_worker(struct work_struct *work)
> +{
> +	struct cs40l50_private *cs40l50 =
> +			container_of(work, struct cs40l50_private, vibe_start_work);
> +	struct cs40l50_effect *effect;
> +
> +	mutex_lock(&cs40l50->lock);
> +
> +	effect = cs40l50_find_effect(cs40l50, cs40l50->trigger_effect->id);
> +	if (effect)
> +		cs40l50_dsp_write(cs40l50, CS40L50_DSP_VIRTUAL1_MBOX_1, effect->trigger_index);
> +
> +	mutex_unlock(&cs40l50->lock);
> +}
> +
> +static void cs40l50_vibe_stop_worker(struct work_struct *work)
> +{
> +	struct cs40l50_private *cs40l50 =
> +			container_of(work, struct cs40l50_private, vibe_stop_work);
> +
> +	mutex_lock(&cs40l50->lock);
> +
> +	cs40l50_dsp_write(cs40l50, CS40L50_DSP_VIRTUAL1_MBOX_1, CS40L50_MBOX_CMD_STOP_PLAYBACK);
> +
> +	mutex_unlock(&cs40l50->lock);
> +}
> +
> +static int cs40l50_playback_effect(struct input_dev *dev, int effect_id, int val)
> +{
> +	struct cs40l50_private *cs40l50 = input_get_drvdata(dev);
> +
> +	cs40l50->trigger_effect = &dev->ff->effects[effect_id];
> +
> +	if (val > 0)
> +		queue_work(cs40l50->vibe_workqueue, &cs40l50->vibe_start_work);
> +	else
> +		queue_work(cs40l50->vibe_workqueue, &cs40l50->vibe_stop_work);
> +
> +	return 0;
> +}
> +
> +static int cs40l50_erase_effect(struct input_dev *dev, int effect_id)
> +{
> +	int error = 0;
> +	struct cs40l50_private *cs40l50 = input_get_drvdata(dev);
> +	struct cs40l50_effect *effect, *effect_owt;
> +
> +	mutex_lock(&cs40l50->lock);
> +
> +	effect = cs40l50_find_effect(cs40l50, dev->ff->effects[effect_id].id);
> +	if (!effect) {
> +		error = -EINVAL;
> +		goto err_mutex;
> +	}
> +
> +	if (effect->mapping != CS40L50_GPIO_MAPPING_INVALID) {
> +		error = cs40l50_dsp_write(cs40l50, effect->mapping, CS40L50_GPI_DISABLE);
> +		if (error)
> +			goto err_mutex;
> +	}
> +
> +	if (effect->wvfrm_bank == CS40L50_WVFRM_BANK_OWT) {
> +		error = cs40l50_dsp_write(cs40l50, CS40L50_DSP_VIRTUAL1_MBOX_1,
> +				CS40L50_MBOX_CMD_OWT_DELETE | effect->trigger_index);

Nit: alignment here and elsewhere.

> +		if (error)
> +			goto err_mutex;
> +
> +		list_for_each_entry(effect_owt, &cs40l50->effect_head, list) {
> +			if (effect_owt->wvfrm_bank == CS40L50_WVFRM_BANK_OWT &&
> +					effect_owt->trigger_index > effect->trigger_index)
> +				effect_owt->trigger_index--;
> +		}
> +	}
> +
> +	list_del(&effect->list);
> +	kfree(effect);
> +err_mutex:
> +	mutex_unlock(&cs40l50->lock);
> +
> +	return error;
> +}
> +
> +static int cs40l50_mailbox_read_next(struct cs40l50_private *cs40l50, u32 *val)
> +{
> +	u32 wt_ptr, rd_ptr;
> +	int error = 0;

No need to initialize 'error' here.

> +
> +	error = cs40l50_dsp_read(cs40l50, CS40L50_DSP1_MBOX_QUEUE_WT, &wt_ptr);
> +	if (error)
> +		return error;
> +
> +	error = cs40l50_dsp_read(cs40l50, CS40L50_DSP1_MBOX_QUEUE_RD, &rd_ptr);
> +	if (error)
> +		return error;
> +
> +	if (wt_ptr == rd_ptr) {
> +		*val = 0;
> +		return 0;
> +	}
> +
> +	error = cs40l50_dsp_read(cs40l50, rd_ptr, val);
> +	if (error)
> +		return error;
> +
> +	rd_ptr += sizeof(u32);
> +	if (rd_ptr > CS40L50_MBOX_QUEUE_END)
> +		rd_ptr = CS40L50_MBOX_QUEUE_BASE;
> +
> +	return cs40l50_dsp_write(cs40l50, CS40L50_DSP1_MBOX_QUEUE_RD, rd_ptr);
> +}
> +
> +static int cs40l50_handle_f0_est_done(struct cs40l50_private *cs40l50)
> +{
> +	int error;
> +	u32 f_zero;
> +
> +	error = cs40l50_dsp_read(cs40l50, CS40L50_DSP1_F0_ESTIMATION, &f_zero);
> +	if (error)
> +		return error;
> +
> +	return cs40l50_dsp_write(cs40l50, CS40L50_DSP1_F0_STORED, f_zero);
> +}
> +
> +static int cs40l50_handle_redc_est_done(struct cs40l50_private *cs40l50)
> +{
> +	int integer, fractional, error;
> +	u32 redc;
> +
> +	error = cs40l50_dsp_read(cs40l50, CS40L50_DSP1_RE_EST_STATUS, &redc);
> +	if (error)
> +		return error;
> +
> +	error = cs40l50_dsp_write(cs40l50, CS40L50_DSP1_REDC_ESTIMATION, redc);
> +	if (error)
> +		return error;
> +
> +	/* Convert from Q8.15 to (Q7.17 * 29/240) */
> +	integer = (redc >> 15) & 0xFF;
> +	fractional = (redc & 0x7FFF) * 4;
> +
> +	return cs40l50_dsp_write(cs40l50, CS40L50_DSP1_REDC_STORED,
> +		(((integer << 17) | fractional) * 29 / 240) & GENMASK(23, 0));
> +}
> +
> +static int cs40l50_error_release(struct cs40l50_private *cs40l50)
> +{
> +	int error;
> +
> +	error = cs40l50_dsp_write(cs40l50, CS40L50_ERROR_RELEASE, CS40L50_ERROR_RELEASE_MASK);
> +	if (error)
> +		return error;
> +
> +	return cs40l50_dsp_write(cs40l50, CS40L50_ERROR_RELEASE, 0);
> +}
> +
> +static irqreturn_t cs40l50_handle_mbox_buffer(int irq, void *data)
> +{
> +	struct cs40l50_private *cs40l50 = data;
> +	int error = 0;
> +	u32 val;
> +
> +	mutex_lock(&cs40l50->lock);
> +
> +	while (!cs40l50_mailbox_read_next(cs40l50, &val)) {
> +		switch (val) {
> +		case 0:
> +			goto out_irq;
> +		case CS40L50_DSP_MBOX_HAPTIC_TRIGGER_GPIO:
> +			dev_dbg(cs40l50->dev, "Mailbox: TRIGGER_GPIO\n");
> +			break;
> +		case CS40L50_DSP_MBOX_HAPTIC_TRIGGER_MBOX:
> +			dev_dbg(cs40l50->dev, "Mailbox: TRIGGER_MBOX\n");
> +			break;
> +		case CS40L50_DSP_MBOX_HAPTIC_TRIGGER_I2S:
> +			dev_dbg(cs40l50->dev, "Mailbox: TRIGGER_I2S\n");
> +			break;
> +		case CS40L50_DSP_MBOX_HAPTIC_COMPLETE_MBOX:
> +			dev_dbg(cs40l50->dev, "Mailbox: COMPLETE_MBOX\n");
> +			break;
> +		case CS40L50_DSP_MBOX_HAPTIC_COMPLETE_GPIO:
> +			dev_dbg(cs40l50->dev, "Mailbox: COMPLETE_GPIO\n");
> +			break;
> +		case CS40L50_DSP_MBOX_HAPTIC_COMPLETE_I2S:
> +			dev_dbg(cs40l50->dev, "Mailbox: COMPLETE_I2S\n");
> +			break;
> +		case CS40L50_DSP_MBOX_F0_EST_START:
> +			dev_dbg(cs40l50->dev, "Mailbox: F0_EST_START\n");
> +			break;
> +		case CS40L50_DSP_MBOX_F0_EST_DONE:
> +			dev_dbg(cs40l50->dev, "Mailbox: F0_EST_DONE\n");
> +			error = cs40l50_handle_f0_est_done(cs40l50);
> +			if (error)
> +				goto out_irq;
> +			break;
> +		case CS40L50_DSP_MBOX_REDC_EST_START:
> +			dev_dbg(cs40l50->dev, "Mailbox: REDC_EST_START\n");
> +			break;
> +		case CS40L50_DSP_MBOX_REDC_EST_DONE:
> +			dev_dbg(cs40l50->dev, "Mailbox: REDC_EST_DONE\n");
> +			error = cs40l50_handle_redc_est_done(cs40l50);
> +			if (error)
> +				goto out_irq;
> +			break;
> +		case CS40L50_DSP_MBOX_LE_EST_START:
> +			dev_dbg(cs40l50->dev, "Mailbox: LE_EST_START\n");
> +			break;
> +		case CS40L50_DSP_MBOX_LE_EST_DONE:
> +			dev_dbg(cs40l50->dev, "Mailbox: LE_EST_DONE\n");
> +			break;
> +		case CS40L50_DSP_MBOX_AWAKE:
> +			dev_dbg(cs40l50->dev, "Mailbox: AWAKE\n");
> +			break;
> +		case CS40L50_DSP_MBOX_INIT:
> +			dev_dbg(cs40l50->dev, "Mailbox: INIT\n");
> +			break;
> +		case CS40L50_DSP_MBOX_ACK:
> +			dev_dbg(cs40l50->dev, "Mailbox: ACK\n");
> +			break;
> +		case CS40L50_DSP_MBOX_ERR_EVENT_UNMAPPED:
> +			dev_err(cs40l50->dev, "Unmapped event\n");
> +			break;
> +		case CS40L50_DSP_MBOX_ERR_EVENT_MODIFY:
> +			dev_err(cs40l50->dev, "Attempt to modify event index failed\n");
> +			break;
> +		case CS40L50_DSP_MBOX_ERR_NULLPTR:
> +			dev_err(cs40l50->dev, "Null pointer\n");
> +			break;
> +		case CS40L50_DSP_MBOX_ERR_BRAKING:
> +			dev_err(cs40l50->dev, "Braking not in progress\n");
> +			break;
> +		case CS40L50_DSP_MBOX_ERR_INVAL_SRC:
> +			dev_err(cs40l50->dev, "Suspend/resume invalid source\n");
> +			break;
> +		case CS40L50_DSP_MBOX_ERR_ENABLE_RANGE:
> +			dev_err(cs40l50->dev, "GPIO enable out of range\n");
> +			break;
> +		case CS40L50_DSP_MBOX_ERR_GPIO_UNMAPPED:
> +			dev_err(cs40l50->dev, "GPIO not mapped\n");
> +			break;
> +		case CS40L50_DSP_MBOX_ERR_ISR_RANGE:
> +			dev_err(cs40l50->dev, "GPIO ISR out of range\n");
> +			break;
> +		case CS40L50_DSP_MBOX_PERMANENT_SHORT:
> +			dev_crit(cs40l50->dev, "Permanent short detected\n");
> +			break;
> +		case CS40L50_DSP_MBOX_RUNTIME_SHORT:
> +			dev_err(cs40l50->dev, "Runtime short detected\n");
> +			error = cs40l50_error_release(cs40l50);
> +			if (error)
> +				goto out_irq;
> +			break;
> +		default:
> +			dev_err(cs40l50->dev, "Mailbox value %#X not recognized\n", val);
> +			error = -EINVAL;
> +			goto out_irq;
> +		}
> +	}
> +
> +	error = -EIO;
> +
> +out_irq:
> +	mutex_unlock(&cs40l50->lock);
> +
> +	return IRQ_RETVAL(!error);
> +}
> +
> +
> +static irqreturn_t cs40l50_vddb_uv(int irq, void *data)
> +{
> +	struct cs40l50_private *cs40l50 = data;
> +
> +	dev_err(cs40l50->dev, "VDD_B undervoltage error\n");
> +
> +	return IRQ_RETVAL(!cs40l50_error_release(cs40l50));
> +}
> +
> +static irqreturn_t cs40l50_boost_current_limit(int irq, void *data)
> +{
> +	struct cs40l50_private *cs40l50 = data;
> +
> +	dev_err(cs40l50->dev, "Boost current limit engagement\n");
> +
> +	return IRQ_RETVAL(!cs40l50_error_release(cs40l50));
> +}
> +
> +static irqreturn_t cs40l50_boost_short(int irq, void *data)
> +{
> +	struct cs40l50_private *cs40l50 = data;
> +
> +	dev_err(cs40l50->dev, "Boost inductor short error\n");
> +
> +	return IRQ_RETVAL(!cs40l50_error_release(cs40l50));
> +}
> +
> +static irqreturn_t cs40l50_boost_uv(int irq, void *data)
> +{
> +	struct cs40l50_private *cs40l50 = data;
> +
> +	dev_err(cs40l50->dev, "Boost undervoltage error\n");
> +
> +	return IRQ_RETVAL(!cs40l50_error_release(cs40l50));
> +}
> +
> +static irqreturn_t cs40l50_overtemperature(int irq, void *data)
> +{
> +	struct cs40l50_private *cs40l50 = data;
> +
> +	dev_err(cs40l50->dev, "Overtemperature error\n");
> +
> +	return IRQ_RETVAL(!cs40l50_error_release(cs40l50));
> +}
> +
> +static irqreturn_t cs40l50_amp_short(int irq, void *data)
> +{
> +	struct cs40l50_private *cs40l50 = data;
> +
> +	dev_err(cs40l50->dev, "Amp short error\n");
> +
> +	return IRQ_RETVAL(!cs40l50_error_release(cs40l50));
> +}
> +
> +static irqreturn_t cs40l50_global_error(int irq, void *data)
> +{
> +	struct cs40l50_private *cs40l50 = data;
> +
> +	dev_err(cs40l50->dev, "MSM chip error\n");
> +
> +	return IRQ_RETVAL(!cs40l50_error_release(cs40l50));
> +}
> +
> +static const struct cs40l50_irq cs40l50_irqs[] = {
> +	CS40L50_IRQ(CS40L50_AMP_SHORT_IRQ, "Amp short", cs40l50_amp_short),
> +	CS40L50_IRQ(CS40L50_VIRT2_MBOX_IRQ, "Firmware interrupt", cs40l50_handle_mbox_buffer),
> +	CS40L50_IRQ(CS40L50_TEMP_ERR_IRQ, "Overtemperature", cs40l50_overtemperature),
> +	CS40L50_IRQ(CS40L50_BST_UVP_IRQ, "Boost undervoltage", cs40l50_boost_uv),
> +	CS40L50_IRQ(CS40L50_BST_SHORT_IRQ, "Boost short", cs40l50_boost_short),
> +	CS40L50_IRQ(CS40L50_BST_ILIMIT_IRQ, "Boost current limit", cs40l50_boost_current_limit),
> +	CS40L50_IRQ(CS40L50_UVLO_VDDBATT_IRQ, "VDD_B undervoltage", cs40l50_vddb_uv),
> +	CS40L50_IRQ(CS40L50_GLOBAL_ERROR_IRQ, "Global error", cs40l50_global_error),
> +};
> +
> +static const struct regmap_irq cs40l50_reg_irqs[] = {
> +	CS40L50_REG_IRQ(IRQ1_INT_1, AMP_SHORT),
> +	CS40L50_REG_IRQ(IRQ1_INT_2, VIRT2_MBOX),
> +	CS40L50_REG_IRQ(IRQ1_INT_8, TEMP_ERR),
> +	CS40L50_REG_IRQ(IRQ1_INT_9, BST_UVP),
> +	CS40L50_REG_IRQ(IRQ1_INT_9, BST_SHORT),
> +	CS40L50_REG_IRQ(IRQ1_INT_9, BST_ILIMIT),
> +	CS40L50_REG_IRQ(IRQ1_INT_10, UVLO_VDDBATT),
> +	CS40L50_REG_IRQ(IRQ1_INT_18, GLOBAL_ERROR),
> +};
> +
> +static const struct regmap_irq_chip cs40l50_regmap_irq_chip = {
> +	.name = "cs40l50 IRQ1 Controller",
> +	.status_base = CS40L50_IRQ1_INT_1,
> +	.mask_base = CS40L50_IRQ1_MASK_1,
> +	.ack_base = CS40L50_IRQ1_INT_1,
> +	.num_regs = 19,
> +	.irqs = cs40l50_reg_irqs,
> +	.num_irqs = ARRAY_SIZE(cs40l50_reg_irqs),
> +	.runtime_pm = true,
> +};
> +
> +static const struct reg_sequence cs40l50_ext_bst_seq[] = {
> +	{ CS40L50_BLOCK_ENABLES, CS40L50_MON_ENABLE },
> +	{ CS40L50_MON_VALUE_CTRL, CS40L50_VBST_VDD_AMP },
> +	{ CS40L50_TEST_KEY, CS40L50_KEY_SET_1 },
> +	{ CS40L50_TEST_KEY, CS40L50_KEY_SET_2 },
> +	{ CS40L50_TEST_VIS_SPARE, CS40L50_TEMP_SENSOR_3 },
> +	{ CS40L50_MON_ERROR_OVERIDE, CS40L50_TEMP_ERR_THLD },
> +	{ CS40L50_STATUS, CS40L50_TEMP_WARN_THLD },
> +	{ CS40L50_TEST_CONFIG, CS40L50_TEMP_FILT_DEBOUNCE_OFF },
> +	{ CS40L50_TEMP_WARN_CONFIG, CS40L50_TEMP_WARN_ATK_VOL },
> +};
> +
> +static int cs40l50_config_bst(struct cs40l50_private *cs40l50)
> +{
> +	int error, i;
> +
> +	if (device_property_present(cs40l50->dev, "cirrus,external-boost")) {
> +		error = regmap_multi_reg_write(cs40l50->regmap, cs40l50_ext_bst_seq,
> +				ARRAY_SIZE(cs40l50_ext_bst_seq));
> +		if (error)
> +			return error;
> +
> +		for (i = 0; i < ARRAY_SIZE(cs40l50_ext_bst_seq); i++) {
> +			error = cs40l50_pseq_write(cs40l50, cs40l50_ext_bst_seq[i].reg,
> +					cs40l50_ext_bst_seq[i].def);
> +			if (error)
> +				return error;
> +		}
> +
> +		return 0;
> +	}
> +
> +	/* Internal boost config */

This driver is conspicuously void of comments and documentation; why is
this line mysterious enough to warrant one?

> +	return cs40l50_dsp_write(cs40l50, CS40L50_BST_LPMODE_SEL, CS40L50_DCM_LOW_POWER);
> +}
> +
> +static int cs40l50_patch_firmware(struct cs40l50_private *cs40l50)
> +{
> +	const struct firmware *bin = NULL, *wmfw = NULL;
> +	int error = 0;
> +
> +	if (request_firmware(&bin, "cs40l50.bin", cs40l50->dev))
> +		dev_info(cs40l50->dev, "Could not request wavetable file: %d\n", error);
> +
> +	if (request_firmware(&wmfw, "cs40l50.wmfw", cs40l50->dev))
> +		dev_info(cs40l50->dev, "Could not request firmware patch file: %d\n", error);
> +
> +	if (wmfw) {

It is a much more common design pattern to bail if request_firmware() returns
an error, than to proceed and check against the FW pointer remaining NULL.

Is this done because cs_dsp_power_up() must be called, with or without a wmfw
or coefficient file being available?

> +		error = cs40l50_dsp_write(cs40l50, CS40L50_CCM_CORE_CONTROL,
> +				CS40L50_DSP1_CLOCK_DISABLE);
> +		if (error)
> +			goto err_fw;
> +
> +		error = cs40l50_dsp_write(cs40l50, CS40L50_RAM_INIT,
> +				CS40L50_DSP1_RAM_INIT_FLAG);
> +		if (error)
> +			goto err_fw;
> +
> +		error = cs40l50_dsp_write(cs40l50, CS40L50_PWRMGT_CTL,
> +				CS40L50_DSP1_MEM_RDY_HW);
> +		if (error)
> +			goto err_fw;
> +	}
> +
> +	mutex_lock(&cs40l50->lock);
> +
> +	cs_dsp_power_up(&cs40l50->dsp, wmfw, "cs40l50.wmfw", bin, "cs40l50.bin", "cs40l50");
> +
> +	mutex_unlock(&cs40l50->lock);
> +
> +	if (wmfw)
> +		error = cs40l50_dsp_write(cs40l50, CS40L50_CCM_CORE_CONTROL,
> +				CS40L50_DSP1_CLOCK_ENABLE);
> +
> +err_fw:
> +	release_firmware(wmfw);
> +	release_firmware(bin);
> +
> +	return error;
> +}
> +
> +static int cs40l50_pseq_init(struct cs40l50_private *cs40l50)
> +{
> +	struct cs40l50_pseq_op *pseq_op;
> +	int error, i, num_words;
> +	u8 operation;
> +	u32 *words;
> +
> +	INIT_LIST_HEAD(&cs40l50->pseq_op_head);
> +
> +	words = kcalloc(CS40L50_PSEQ_MAX_WORDS, sizeof(u32), GFP_KERNEL);
> +	if (IS_ERR_OR_NULL(words))
> +		return -ENOMEM;

Just curious what is the need to call IS_ERR_OR_NULL() here and throughout
after allocation rather than just !foo ?

> +
> +	error = regmap_bulk_read(cs40l50->regmap, CS40L50_DSP1_POWER_ON_SEQ, words,
> +			CS40L50_PSEQ_MAX_WORDS);
> +	if (error)
> +		goto err_free;
> +
> +	for (i = 0; i < CS40L50_PSEQ_MAX_WORDS; i++)
> +		words[i] = be32_to_cpu(words[i]);
> +
> +	for (i = 0; i < CS40L50_PSEQ_MAX_WORDS; i += num_words) {
> +		operation = (words[i] & CS40L50_PSEQ_OP_MASK) >> CS40L50_PSEQ_OP_SHIFT;
> +
> +		switch (operation) {
> +		case CS40L50_PSEQ_OP_END:
> +			num_words = CS40L50_PSEQ_OP_END_WORDS;
> +			break;
> +		case CS40L50_PSEQ_OP_WRITE_ADDR8:
> +		case CS40L50_PSEQ_OP_WRITE_H16:
> +		case CS40L50_PSEQ_OP_WRITE_L16:
> +			num_words = CS40L50_PSEQ_OP_WRITE_X16_WORDS;
> +			break;
> +		case CS40L50_PSEQ_OP_WRITE_FULL:
> +			num_words = CS40L50_PSEQ_OP_WRITE_FULL_WORDS;
> +			break;
> +		default:
> +			dev_err(cs40l50->dev, "Invalid OP code 0x%02X\n", operation);
> +			error = -EINVAL;
> +			goto err_free;
> +		}
> +
> +		pseq_op = devm_kzalloc(cs40l50->dev, sizeof(*pseq_op), GFP_KERNEL);
> +		if (!pseq_op) {
> +			error = -ENOMEM;
> +			goto err_free;
> +		}
> +
> +		memcpy(pseq_op->words, &words[i], num_words * sizeof(u32));
> +		pseq_op->size = num_words;
> +		pseq_op->offset = i * sizeof(u32);
> +		pseq_op->operation = operation;
> +		list_add(&pseq_op->list, &cs40l50->pseq_op_head);
> +
> +		if (operation == CS40L50_PSEQ_OP_END)
> +			break;
> +	}
> +
> +	if (operation != CS40L50_PSEQ_OP_END) {
> +		dev_err(cs40l50->dev, "PSEQ_END_OF_SCRIPT not found\n");
> +		error = -ENOENT;
> +	}
> +
> +err_free:
> +	kfree(words);
> +
> +	return error;
> +}
> +
> +static int cs40l50_input_init(struct cs40l50_private *cs40l50)
> +{
> +	int error;
> +	u32 val;
> +
> +	error = cs40l50_dsp_read(cs40l50, CS40L50_DEVID, &val);
> +	if (error)
> +		return error;
> +
> +	if (val != CS40L50_DEVID_A) {
> +		dev_err(cs40l50->dev, "Invalid device ID: %#010X\n", val);
> +		return -EINVAL;
> +	}
> +
> +	cs40l50->input->id.product = val & 0xFFFF;
> +
> +	error = cs40l50_dsp_read(cs40l50, CS40L50_REVID, &val);
> +	if (error)
> +		return error;
> +
> +	if (val != CS40L50_REVID_B0) {
> +		dev_err(cs40l50->dev, "Invalid device revision: %#04X\n", val);
> +		return -EINVAL;
> +	}
> +
> +	cs40l50->input->id.version = val;
> +
> +	cs40l50->input = devm_input_allocate_device(cs40l50->dev);
> +	if (IS_ERR_OR_NULL(cs40l50->input))
> +		return cs40l50->input ? PTR_ERR(cs40l50->input) : -ENOMEM;
> +
> +	cs40l50->input->name = "cs40l50_input";
> +	input_set_drvdata(cs40l50->input, cs40l50);
> +	input_set_capability(cs40l50->input, EV_FF, FF_PERIODIC);
> +	input_set_capability(cs40l50->input, EV_FF, FF_CUSTOM);
> +
> +	error = input_ff_create(cs40l50->input, FF_MAX_EFFECTS);
> +	if (error)
> +		return error;
> +
> +	clear_bit(FF_RUMBLE, cs40l50->input->ffbit);

If there is a HW limitation that prevents this capability, it would be
handy to explain as much with a comment.

> +
> +	cs40l50->input->ff->upload = cs40l50_add_effect;
> +	cs40l50->input->ff->playback = cs40l50_playback_effect;
> +	cs40l50->input->ff->erase = cs40l50_erase_effect;
> +
> +	INIT_LIST_HEAD(&cs40l50->effect_head);
> +
> +	return input_register_device(cs40l50->input);
> +}
> +
> +static const struct cs_dsp_client_ops cs40l50_cs_dsp_client_ops;
> +
> +static const struct cs_dsp_region cs40l50_dsp_regions[] = {
> +	{ .type = WMFW_HALO_PM_PACKED,		.base = CS40L50_DSP1_PMEM_0 },
> +	{ .type = WMFW_HALO_XM_PACKED,		.base = CS40L50_DSP1_XMEM_PACKED_0 },
> +	{ .type = WMFW_HALO_YM_PACKED,		.base = CS40L50_DSP1_YMEM_PACKED_0 },
> +	{ .type = WMFW_ADSP2_XM,		.base = CS40L50_DSP1_XMEM_UNPACKED24_0 },
> +	{ .type = WMFW_ADSP2_YM,		.base = CS40L50_DSP1_YMEM_UNPACKED24_0 },
> +};

This is more readable as:

	[...],
	{
		.type = ...,
		.base = ...,
	},
	[...],

> +
> +static int cs40l50_cs_dsp_init(struct cs40l50_private *cs40l50)
> +{
> +	cs40l50->dsp.num = 1;
> +	cs40l50->dsp.type = WMFW_HALO;
> +	cs40l50->dsp.dev = cs40l50->dev;
> +	cs40l50->dsp.regmap = cs40l50->regmap;
> +	cs40l50->dsp.base = CS40L50_DSP1_CORE_BASE;
> +	cs40l50->dsp.base_sysinfo = CS40L50_DSP1_SYS_INFO_ID;
> +	cs40l50->dsp.mem = cs40l50_dsp_regions;
> +	cs40l50->dsp.num_mems = ARRAY_SIZE(cs40l50_dsp_regions);
> +	cs40l50->dsp.lock_regions = 0xFFFFFFFF;
> +	cs40l50->dsp.no_core_startstop = true;
> +	cs40l50->dsp.client_ops = &cs40l50_cs_dsp_client_ops;
> +
> +	return cs_dsp_halo_init(&cs40l50->dsp);
> +}
> +
> +int cs40l50_probe(struct cs40l50_private *cs40l50)
> +{
> +	int error, i, irq;
> +	u32 val;
> +
> +	mutex_init(&cs40l50->lock);
> +
> +	error = devm_regulator_bulk_get(cs40l50->dev, ARRAY_SIZE(cs40l50_supplies),
> +			cs40l50_supplies);
> +	if (error)
> +		return dev_err_probe(cs40l50->dev, error, "Failed to request supplies\n");
> +
> +	error = regulator_bulk_enable(ARRAY_SIZE(cs40l50_supplies), cs40l50_supplies);
> +	if (error)
> +		return dev_err_probe(cs40l50->dev, error, "Failed to enable supplies\n");
> +
> +	cs40l50->reset_gpio = devm_gpiod_get_optional(cs40l50->dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(cs40l50->reset_gpio)) {
> +		error = PTR_ERR(cs40l50->reset_gpio);
> +		goto err;
> +	}

Krzysztof covered this already, but I just want to re-iterate that you are
kind of swallowing your own head by calling cs40l50_remove() in your error
path. This is a confusing and uncommon design pattern.

You cannot have possibly booted the DSP or allocated work here, so why not
just return?

> +
> +	usleep_range(CS40L50_MIN_RESET_PULSE_WIDTH_US, CS40L50_MIN_RESET_PULSE_WIDTH_US + 100);
> +
> +	gpiod_set_value_cansleep(cs40l50->reset_gpio, 0);
> +
> +	usleep_range(CS40L50_CP_READY_DELAY_US, CS40L50_CP_READY_DELAY_US + 1000);
> +
> +	for (i = 0; i < CS40L50_DSP_TIMEOUT_COUNT; i++) {
> +		error = cs40l50_dsp_read(cs40l50, CS40L50_DSP1_HALO_STATE, &val);
> +		if (!error && val < 0xFFFF && val >= CS40L50_HALO_STATE_BOOT_DONE)
> +			break;
> +
> +		usleep_range(CS40L50_DSP_POLL_US, CS40L50_DSP_POLL_US + 100);
> +	}
> +
> +	if (i == CS40L50_DSP_TIMEOUT_COUNT) {
> +		dev_err(cs40l50->dev, "Firmware boot failed: %d, halo state = %#x\n", error, val);
> +		goto err;
> +	}
> +
> +	cs40l50->vibe_workqueue = alloc_ordered_workqueue("cs40l50_workqueue", WQ_HIGHPRI);
> +	if (!cs40l50->vibe_workqueue) {
> +		error = -ENOMEM;
> +		goto err;
> +	}
> +
> +	INIT_WORK(&cs40l50->vibe_start_work, cs40l50_vibe_start_worker);
> +	INIT_WORK(&cs40l50->vibe_stop_work, cs40l50_vibe_stop_worker);
> +
> +	error = cs40l50_cs_dsp_init(cs40l50);
> +	if (error)
> +		goto err;

It seems your error path is complex because you intend to unwind the DSP
in case of an error, in which case any teardown should be explicitly
called from the bottom of probe() rather than calling remove() on your
own.

Opinions may differ here, but mine is that you need not go out of your
way to power down the DSP if glaring errors are encountered during probe.
If you cannot read HALO_STATE, do you really expect to be able to do any
additional work anyway?

Understanding that haptics bears the risk of a motor stuck on, perhaps it
is sufficient to simply throw the device into reset if things go afoul?

> +
> +	error = cs40l50_input_init(cs40l50);
> +	if (error)
> +		goto err;
> +
> +	error = cs40l50_patch_firmware(cs40l50);
> +	if (error)
> +		goto err;

I just want to re-iterate Charles' comment; this _will_not_ work across
all customer platforms because you cannot guarantee the filesystem is
ready here if the driver is built-in.

In the best case you will get -ENOENT right away; in the worst case you
will get a deadlock. If this device does not have nonvolatile memory and
you must load FW from probe, use request_firmware_nowait() instead.

> +
> +	error = cs40l50_pseq_init(cs40l50);
> +	if (error)
> +		goto err;
> +
> +	error = cs40l50_config_bst(cs40l50);
> +	if (error)
> +		goto err;
> +
> +	error = devm_regmap_add_irq_chip(cs40l50->dev, cs40l50->regmap, cs40l50->irq,
> +			IRQF_ONESHOT | IRQF_SHARED | IRQF_TRIGGER_LOW, 0, &cs40l50_regmap_irq_chip,
> +			&cs40l50->irq_data);

We should not be mandating IRQ polarity in the driver. Sometimes the customer
may use a GPIO expander with inverted polarity; we need to let dts govern the
polarity.

> +	if (error) {
> +		dev_err(cs40l50->dev, "Failed to register IRQ chip: %d\n", error);
> +		goto err;
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(cs40l50_irqs); i++) {
> +		irq = regmap_irq_get_virq(cs40l50->irq_data, cs40l50_irqs[i].irq);
> +		if (irq < 0) {
> +			dev_err(cs40l50->dev, "Failed to get %s\n", cs40l50_irqs[i].name);
> +			error = irq;
> +			goto err;
> +		}
> +
> +		error = devm_request_threaded_irq(cs40l50->dev, irq, NULL, cs40l50_irqs[i].handler,
> +				IRQF_ONESHOT | IRQF_SHARED | IRQF_TRIGGER_LOW,
> +						cs40l50_irqs[i].name, cs40l50);
> +		if (error) {
> +			dev_err(cs40l50->dev, "Failed to request IRQ %s: %d\n",
> +					cs40l50_irqs[i].name, error);
> +			goto err;
> +		}
> +	}
> +
> +	return 0;
> +
> +err:
> +	cs40l50_remove(cs40l50);
> +
> +	return error;
> +}
> +EXPORT_SYMBOL_GPL(cs40l50_probe);
> +
> +int cs40l50_remove(struct cs40l50_private *cs40l50)
> +{
> +	disable_irq(cs40l50->irq);
> +
> +	if (cs40l50->dsp.booted)
> +		cs_dsp_power_down(&cs40l50->dsp);
> +	if (&cs40l50->dsp)
> +		cs_dsp_remove(&cs40l50->dsp);
> +
> +	if (cs40l50->vibe_workqueue) {
> +		flush_workqueue(cs40l50->vibe_workqueue);
> +		destroy_workqueue(cs40l50->vibe_workqueue);
> +	}
> +
> +	gpiod_set_value_cansleep(cs40l50->reset_gpio, 1);
> +	regulator_bulk_disable(ARRAY_SIZE(cs40l50_supplies), cs40l50_supplies);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(cs40l50_remove);
> +
> +MODULE_DESCRIPTION("CS40L50 Advanced Haptic Driver");
> +MODULE_AUTHOR("James Ogletree, Cirrus Logic Inc. <james.ogletree@cirrus.com>");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/input/cs40l50.h b/include/linux/input/cs40l50.h
> new file mode 100644
> index 000000000000..f2c8a101fa00
> --- /dev/null
> +++ b/include/linux/input/cs40l50.h
> @@ -0,0 +1,321 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * CS40L50 Advanced Haptic Driver with Waveform Memory DSP
> + * and Closed-Loop Algorithms
> + *
> + * Copyright 2023 Cirrus Logic, Inc.
> + *
> + */
> +#ifndef __CS40L50_H__
> +#define __CS40L50_H__
> +
> +#include <linux/bitops.h>

bitops.h is quite outdated; did you mean bits.h?

> +#include <linux/gpio/consumer.h>
> +#include <linux/input.h>
> +#include <linux/regmap.h>
> +#include <linux/interrupt.h>
> +#include <linux/firmware/cirrus/cs_dsp.h>
> +#include <linux/firmware/cirrus/wmfw.h>
> +
> +/* Boost */
> +#define CS40L50_TEST_KEY			0x40
> +#define CS40L50_BLOCK_ENABLES			0x2018
> +#define CS40L50_ERROR_RELEASE			0x2034
> +#define CS40L50_PWRMGT_CTL			0x2900
> +#define CS40L50_BST_LPMODE_SEL			0x3810
> +#define CS40L50_STATUS				0x4200
> +#define CS40L50_MON_ERROR_OVERIDE		0x4220
> +#define CS40L50_TEST_CONFIG			0x4240
> +#define CS40L50_MON_VALUE_CTRL			0x4404
> +#define CS40L50_TEST_VIS_SPARE			0x5C00
> +#define CS40L50_TEMP_WARN_CONFIG		0x6024
> +#define CS40L50_KEY_SET_1		0x55
> +#define CS40L50_KEY_SET_2		0xAA
> +#define CS40L50_TEMP_SENSOR_3		0x400
> +#define CS40L50_DCM_LOW_POWER		0x1
> +#define CS40L50_MON_ENABLE		0x3201
> +#define CS40L50_VBST_VDD_AMP		0x1000000
> +#define CS40L50_TEMP_ERR_THLD		0x8000007D
> +#define CS40L50_TEMP_WARN_THLD		0x8
> +#define CS40L50_TEMP_FILT_DEBOUNCE_OFF	0x510002B5
> +#define CS40L50_TEMP_WARN_ATK_VOL	0x522303
> +
> +/* Interrupts */
> +#define CS40L50_IRQ1_INT_1			0xE010
> +#define CS40L50_IRQ1_INT_2			0xE014
> +#define CS40L50_IRQ1_INT_3			0xE018
> +#define CS40L50_IRQ1_INT_4			0xE01C
> +#define CS40L50_IRQ1_INT_8			0xE02C
> +#define CS40L50_IRQ1_INT_9			0xE030
> +#define CS40L50_IRQ1_INT_10			0xE034
> +#define CS40L50_IRQ1_INT_18			0xE054
> +#define CS40L50_IRQ1_INT_19			0xE058
> +#define CS40L50_IRQ1_MASK_1			0xE090
> +#define CS40L50_IRQ1_MASK_2			0xE094
> +#define CS40L50_IRQ1_MASK_3			0xE098
> +#define CS40L50_IRQ1_MASK_8			0xE0AC
> +#define CS40L50_IRQ1_MASK_9			0xE0B0
> +#define CS40L50_IRQ1_MASK_10			0xE0B4
> +#define CS40L50_IRQ1_MASK_18			0xE0D4
> +#define CS40L50_IRQ1_MASK_19			0xE0D8
> +#define CS40L50_IRQ1_STS_1			0xE210
> +#define CS40L50_IRQ1_STS_2			0xE214
> +#define CS40L50_IRQ1_STS_3			0xE218
> +#define CS40L50_IRQ1_STS_8			0xE22C
> +#define CS40L50_IRQ1_STS_9			0xE230
> +#define CS40L50_IRQ1_STS_10			0xE234
> +#define CS40L50_IRQ1_STS_18			0xE254
> +#define CS40L50_IRQ1_STS_19			0xE258
> +#define CS40L50_AMP_SHORT_MASK		BIT(31)
> +#define CS40L50_VIRT2_MBOX_MASK		BIT(21)
> +#define CS40L50_TEMP_ERR_MASK		BIT(31)
> +#define CS40L50_BST_UVP_MASK		BIT(6)
> +#define CS40L50_BST_SHORT_MASK		BIT(7)
> +#define CS40L50_BST_ILIMIT_MASK		BIT(8)
> +#define CS40L50_UVLO_VDDBATT_MASK	BIT(16)
> +#define CS40L50_GLOBAL_ERROR_MASK	BIT(15)
> +#define CS40L50_ERROR_RELEASE_MASK	BIT(11)
> +#define CS40L50_BOOT_DONE_MASK		BIT(1)
> +#define CS40L50_IRQ(_irq, _name, _hand)	\
> +	{				\
> +		.irq = _irq,		\
> +		.name = _name,		\
> +		.handler = _hand,	\
> +	}
> +#define CS40L50_REG_IRQ(_reg, _irq)					\
> +	[CS40L50_ ## _irq ## _IRQ] = {					\
> +		.reg_offset = (CS40L50_ ## _reg) - CS40L50_IRQ1_INT_1,	\
> +		.mask = CS40L50_ ## _irq ## _MASK			\
> +	}
> +
> +/* Mailbox Inbound Commands */
> +#define CS40L50_RAM_BANK_INDEX_START		0x1000000
> +#define CS40L50_RAM_BANK_INDEX_END		0x100007F
> +#define CS40L50_OWT_INDEX_START			0x1400000
> +#define CS40L50_OWT_INDEX_END			0x140007F
> +#define CS40L50_ROM_BANK_INDEX_START		0x1800000
> +#define CS40L50_ROM_BANK_INDEX_END		0x180001A
> +#define CS40L50_OTP_BUZZ			0x1800080
> +#define CS40L50_RAM_BUZZ_INDEX_START		0x1800081
> +#define CS40L50_RAM_BUZZ_INDEX_END		0x1800085
> +#define CS40L50_MBOX_CMD_HIBERNATE		0x2000001
> +#define CS40L50_MBOX_CMD_WAKEUP			0x2000002
> +#define CS40L50_MBOX_CMD_PREVENT_HIBERNATE	0x2000003
> +#define CS40L50_MBOX_CMD_ALLOW_HIBERNATION	0x2000004
> +#define CS40L50_MBOX_CMD_SHUTDOWN		0x2000005
> +#define CS40L50_MBOX_CMD_DURATION_REPORT	0x3000001
> +#define CS40L50_MBOX_CMD_START_I2S		0x3000002
> +#define CS40L50_MBOX_CMD_STOP_I2S		0x3000003
> +#define CS40L50_MBOX_CMD_HAPTICS_LOGGER_RESET	0x3000004
> +#define CS40L50_MBOX_CMD_OWT_PUSH		0x3000008
> +#define CS40L50_MBOX_CMD_OWT_RESET		0x3000009
> +#define CS40L50_MBOX_CMD_DVL_REINIT		0x300000A
> +#define CS40L50_MBOX_CMD_STOP_PLAYBACK		0x5000000
> +#define CS40L50_MBOX_CMD_F0_EST			0x7000001
> +#define CS40L50_MBOX_CMD_REDC_EST		0x7000002
> +#define CS40L50_MBOX_CMD_LE_EST			0x7000004
> +#define CS40L50_MBOX_CMD_OWT_DELETE		0xD000000
> +
> +/* Mailbox Outbound Commands */
> +#define CS40L50_MBOX_QUEUE_BASE				0x11004
> +#define CS40L50_MBOX_QUEUE_END				0x1101C
> +#define CS40L50_DSP_VIRTUAL1_MBOX_1			0x11020
> +#define CS40L50_DSP1_MBOX_QUEUE_WT			0x28042C8
> +#define CS40L50_DSP1_MBOX_QUEUE_RD			0x28042CC
> +#define CS40L50_DSP_MBOX_HAPTIC_COMPLETE_MBOX	0x1000000
> +#define CS40L50_DSP_MBOX_HAPTIC_COMPLETE_GPIO	0x1000001
> +#define CS40L50_DSP_MBOX_HAPTIC_COMPLETE_I2S	0x1000002
> +#define CS40L50_DSP_MBOX_HAPTIC_TRIGGER_MBOX	0x1000010
> +#define CS40L50_DSP_MBOX_HAPTIC_TRIGGER_GPIO	0x1000011
> +#define CS40L50_DSP_MBOX_HAPTIC_TRIGGER_I2S	0x1000012
> +#define CS40L50_DSP_MBOX_INIT			0x2000000
> +#define CS40L50_DSP_MBOX_AWAKE			0x2000002
> +#define CS40L50_DSP_MBOX_F0_EST_START		0x7000011
> +#define CS40L50_DSP_MBOX_F0_EST_DONE		0x7000021
> +#define CS40L50_DSP_MBOX_REDC_EST_START		0x7000012
> +#define CS40L50_DSP_MBOX_REDC_EST_DONE		0x7000022
> +#define CS40L50_DSP_MBOX_LE_EST_START		0x7000014
> +#define CS40L50_DSP_MBOX_LE_EST_DONE		0x7000024
> +#define CS40L50_DSP_MBOX_ACK			0xA000000
> +#define CS40L50_DSP_MBOX_PANIC			0xC000000
> +#define CS40L50_DSP_MBOX_WATERMARK		0xD000000
> +#define CS40L50_DSP_MBOX_ERR_EVENT_UNMAPPED	0xC0004B3
> +#define CS40L50_DSP_MBOX_ERR_EVENT_MODIFY	0xC0004B4
> +#define CS40L50_DSP_MBOX_ERR_NULLPTR		0xC0006A5
> +#define CS40L50_DSP_MBOX_ERR_BRAKING		0xC0006A8
> +#define CS40L50_DSP_MBOX_ERR_INVAL_SRC		0xC0006AC
> +#define CS40L50_DSP_MBOX_ERR_ENABLE_RANGE	0xC000836
> +#define CS40L50_DSP_MBOX_ERR_GPIO_UNMAPPED	0xC000837
> +#define CS40L50_DSP_MBOX_ERR_ISR_RANGE		0xC000838
> +#define CS40L50_DSP_MBOX_PERMANENT_SHORT	0xC000C1C
> +#define CS40L50_DSP_MBOX_RUNTIME_SHORT		0xC000C1D
> +
> +/* DSP */
> +#define CS40L50_DSP1_XMEM_PACKED_0		0x2000000
> +#define CS40L50_DSP1_XMEM_UNPACKED32_0		0x2400000
> +#define CS40L50_DSP1_SYS_INFO_ID		0x25E0000
> +#define CS40L50_DSP1_XMEM_UNPACKED24_0		0x2800000
> +#define CS40L50_NUM_OF_WAVES			0x280CB4C
> +#define CS40L50_DSP1_CORE_BASE			0x2B80000
> +#define CS40L50_DSP1_SCRATCH1			0x2B805C0
> +#define CS40L50_DSP1_SCRATCH2			0x2B805C8
> +#define CS40L50_DSP1_SCRATCH3			0x2B805D0
> +#define CS40L50_DSP1_SCRATCH4			0x2B805D8

I didn't look too closely, but some of these #defines are unused.

> +#define CS40L50_CCM_CORE_CONTROL		0x2BC1000
> +#define CS40L50_RAM_INIT			0x28021DC
> +#define CS40L50_DSP1_YMEM_PACKED_0		0x2C00000
> +#define CS40L50_DSP1_YMEM_UNPACKED32_0		0x3000000
> +#define CS40L50_DSP1_YMEM_UNPACKED24_0		0x3400000
> +#define CS40L50_DSP1_PMEM_0			0x3800000
> +#define CS40L50_DSP1_PMEM_5114			0x3804FE8
> +#define CS40L50_DSP1_MEM_RDY_HW		0x2
> +#define CS40L50_DSP1_RAM_INIT_FLAG	0x1
> +#define CS40L50_DSP1_CLOCK_DISABLE	0x80
> +#define CS40L50_DSP1_CLOCK_ENABLE	0x281
> +#define CS40L50_DSP_POLL_US		1000
> +#define CS40L50_DSP_TIMEOUT_COUNT	100
> +#define CS40L50_MBOX_POLL_US		5000
> +
> +/* Calibration */
> +#define CS40L50_DSP1_REDC_ESTIMATION		0x2802F7C
> +#define CS40L50_DSP1_F0_ESTIMATION		0x2802F84
> +#define CS40L50_DSP1_DYNAMIC_F0_ENABLE		0x2802F8C
> +#define CS40L50_DSP1_DYNAMIC_F0_THRESHOLD	0x2802F90
> +#define CS40L50_DSP1_F0_STORED			0x2805C00
> +#define CS40L50_DSP1_REDC_STORED		0x2805C04
> +#define CS40L50_DSP1_RE_EST_STATUS		0x3401B40
> +#define CS40L50_REDC_EST_DELAY_US	30000
> +#define CS40L50_F0_EST_DELAY_US		10000
> +
> +/* OWT */
> +#define CS40L50_DSP1_OWT_SIZE			0x2805C38
> +#define CS40L50_DSP1_OWT_NEXT			0x2805C3C
> +#define CS40L50_NUM_OF_OWT_WAVES		0x2805C40
> +#define CS40L50_DSP1_OWT_BASE			0x2805C34
> +#define CS40L50_MAX_PWLE_SECTIONS	126
> +#define CS40L50_CUSTOM_DATA_SIZE	2
> +#define CS40L50_WT_HEADER_PWLE_SIZE	12
> +#define CS40L50_WT_HEADER_DEFAULT_FLAGS	0x0000
> +#define CS40L50_WT_HEADER_OFFSET	3
> +#define CS40L50_WT_TYPE_PCM		8
> +#define CS40L50_WT_TYPE_PWLE		12
> +#define CS40L50_PCM_ID			0x0000
> +
> +/* GPIO */
> +#define CS40L50_DSP1_GPIO_BASE			0x2804140
> +#define CS40L50_GPIO_MAPPING_INVALID	0
> +#define CS40L50_GPI_DISABLE		0x1FF
> +#define CS40L50_BTN_NUM_MASK		GENMASK(14, 12)
> +#define CS40L50_BTN_EDGE_MASK		BIT(15)
> +
> +/* State */
> +#define CS40L50_DSP1_HALO_STATE				0x28021E0
> +#define CS40L50_HALO_STATE_BOOT_DONE		2
> +#define CS40L50_MIN_RESET_PULSE_WIDTH_US	1100
> +#define CS40L50_CP_READY_DELAY_US		2200
> +
> +/* Device */
> +#define CS40L50_DEVID			0x0
> +#define CS40L50_REVID			0x4
> +#define CS40L50_DEVID_A		0x40A50
> +#define CS40L50_REVID_B0	0xB0
> +
> +/* Write sequencer */
> +#define CS40L50_DSP1_POWER_ON_SEQ				0x280C320
> +#define CS40L50_PSEQ_MAX_WORDS				200
> +#define CS40L50_PSEQ_OP_MASK				GENMASK(23, 16)
> +#define CS40L50_PSEQ_OP_SHIFT				16
> +#define CS40L50_PSEQ_OP_WRITE_ADDR8			0x02
> +#define CS40L50_PSEQ_OP_WRITE_L16			0x04
> +#define CS40L50_PSEQ_OP_WRITE_H16			0x05
> +#define CS40L50_PSEQ_OP_WRITE_FULL			0x00
> +#define CS40L50_PSEQ_OP_WRITE_FULL_WORDS		3
> +#define CS40L50_PSEQ_OP_WRITE_X16_WORDS			2
> +#define CS40L50_PSEQ_OP_END				0xFF
> +#define CS40L50_PSEQ_OP_END_WORDS			1
> +#define CS40L50_PSEQ_WRITE_FULL_LOWER_ADDR_SHIFT	8
> +#define CS40L50_PSEQ_WRITE_FULL_UPPER_ADDR_SHIFT	16
> +#define CS40L50_PSEQ_WRITE_FULL_LOWER_ADDR_MASK		GENMASK(15, 0)
> +#define CS40L50_PSEQ_WRITE_FULL_UPPER_DATA_SHIFT	24
> +#define CS40L50_PSEQ_WRITE_FULL_LOWER_DATA_MASK		GENMASK(23, 0)
> +
> +enum cs40l50_wvfrm_bank {
> +	CS40L50_WVFRM_BANK_RAM,
> +	CS40L50_WVFRM_BANK_ROM,
> +	CS40L50_WVFRM_BANK_OWT,
> +	CS40L50_WVFRM_BANK_BUZ,
> +	CS40L50_WVFRM_BANK_NUM,
> +};
> +
> +enum cs40l50_irq_list {
> +	CS40L50_GLOBAL_ERROR_IRQ,
> +	CS40L50_UVLO_VDDBATT_IRQ,
> +	CS40L50_BST_ILIMIT_IRQ,
> +	CS40L50_BST_SHORT_IRQ,
> +	CS40L50_BST_UVP_IRQ,
> +	CS40L50_TEMP_ERR_IRQ,
> +	CS40L50_VIRT2_MBOX_IRQ,
> +	CS40L50_AMP_SHORT_IRQ,
> +	CS40L50_NUM_IRQ
> +};
> +
> +union cs40l50_buzzgen {
> +	u32 words[3];
> +	struct {
> +		u32 freq;
> +		u32 level;
> +		u32 duration;
> +	} params;
> +};
> +
> +struct cs40l50_owt_header {
> +	u32 wvfrm_type;
> +	u32 offset;
> +	u32 data_size;
> +};
> +
> +struct cs40l50_irq {
> +	int irq;
> +	const char *name;
> +	irqreturn_t (*handler)(int irq, void *data);
> +};
> +
> +struct cs40l50_effect {
> +	int id;
> +	u32 trigger_index;
> +	enum cs40l50_wvfrm_bank wvfrm_bank;
> +	u32 mapping;
> +	struct list_head list;
> +};
> +
> +struct cs40l50_pseq_op {
> +	u16 offset;
> +	u8 operation;
> +	u32 words[3];
> +	u32 size;
> +	struct list_head list;
> +};
> +
> +struct cs40l50_private {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	struct cs_dsp dsp;
> +	struct mutex lock;
> +	struct gpio_desc *reset_gpio;
> +	struct input_dev *input;
> +	struct list_head effect_head;
> +	struct ff_effect *trigger_effect;
> +	struct workqueue_struct *vibe_workqueue;
> +	struct work_struct vibe_start_work;
> +	struct work_struct vibe_stop_work;
> +	struct regmap_irq_chip_data *irq_data;
> +	struct list_head pseq_op_head;
> +	int irq;
> +};
> +
> +int cs40l50_probe(struct cs40l50_private *cs40l50);
> +int cs40l50_remove(struct cs40l50_private *cs40l50);
> +
> +extern const struct regmap_config cs40l50_regmap;
> +
> +#endif /* __CS40L50_H__ */
> -- 
> 2.25.1
> 

Kind regards,
Jeff LaBundy
