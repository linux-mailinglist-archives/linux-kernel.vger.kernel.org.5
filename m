Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DADAE7D7BE0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 06:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343984AbjJZEtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 00:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbjJZEtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 00:49:15 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB10C93;
        Wed, 25 Oct 2023 21:49:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zj6grUnPqJDzqJTvFhFhjbpUe7MToBlx5pcagKr1CSb4IugdOvzmewjfMHCVUg9te0byQmH50H8RPS9Ziwh6jUhyzd4KuhpIs1yPZU4yC3ofBQMGW9tzWCzZ0DvyXbAkytjHbLIsYUZJI9YS5ZE2/93gqu6dn9SrGLdcQl5+TMnwj3xNebVZxDM53RRD/ndUYyUW1EFtN1Nlxllge4M2pjL/w2TuBYmFNephBQiG4FSaYXQYGpqQwJaXicIiq1cJOcshFkT6wnWmLmkJ0CF4wLdODchf86iXjDgLH8cOLvL3oMg7JhUgezNRoNeWck4uAhiUA9K07RJ+JMQR4ESARg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sOcWma3GaFql1KzF/g86MqsdUANxnFBVJIoeuZZh+e0=;
 b=NfcZiBse61ULAGH3Io/l/Ajl873YhDf3TS85XQyhi2fZNRRe15ft8OPofUhsY28NMtx46zpZWbCnmbW1BO6hiq3SYcW7qf0nU0vo6UiDpu9zFnsNZEPvPdm4+NdosQVU1eXIvoKOJe+5Zw4XRE0iFcyFJrpwCUf9IkO3qam8gRDDrvSFIX/lwWTg9+O9ejeX/2t562li2za7VxqhGYIZ+PtpfEuuh0ptrXz2ZkNlJvUzgBsk7n47g1RIRsxqhUTwEXWgq+T9AfqfSs5XeniyugE8sUUDlw586EhzDDbm4jzwlqPPd4T9S5tMKozTxof2oWIArw99ZCpwFLMb12DCew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sOcWma3GaFql1KzF/g86MqsdUANxnFBVJIoeuZZh+e0=;
 b=TMRhsnLVy2VWs2Qel9V5spQcMECUIcOXYrhYppanfMGl9Kfs/edF2hZ1afgaswL6+7S/uJqiyRe6XQ/t6RbORvmJQI7/sQ2/+8BxR+lYm6AOk/xJ+TtZ5B02gSmHBqASJxh/rCh8pcXFnoz/3odmw2XM3Z0J31xOKkJFgkQ+rrc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by DM8PR08MB7320.namprd08.prod.outlook.com
 (2603:10b6:8:11::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Thu, 26 Oct
 2023 04:49:07 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::e73c:270b:75f7:5302]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::e73c:270b:75f7:5302%4]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 04:49:07 +0000
Date:   Wed, 25 Oct 2023 23:49:01 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>
Subject: Re: [PATCH v3 2/2] Input: add Himax HX852x(ES) touchscreen driver
Message-ID: <ZTnvvaBciYqL+7gh@nixie71>
References: <20231024-hx852x-v3-0-a1890d3a81e9@gerhold.net>
 <20231024-hx852x-v3-2-a1890d3a81e9@gerhold.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024-hx852x-v3-2-a1890d3a81e9@gerhold.net>
X-ClientProxiedBy: DM6PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:5:40::21) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|DM8PR08MB7320:EE_
X-MS-Office365-Filtering-Correlation-Id: b0ad9ffd-364d-4fc8-852a-08dbd5dee300
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sFL3D2BnocuMSZ9PZvtPu7ugK8ursLL4P6zfbBGeVNTHaf1dgO2Toe9UvWeEhcne9HCc+QofkqkkU79ClzUv+OmCYwqqyIyWMxN2cWwLvYcYpDXgKU2kTaVucguIfaHkoDJl8n/mzV8X0C2QYJf6H2uj/OEj+E4bB0tzf7nd9S2kTOa3FI/Vxq7qBwLHypsnDEKN2wdNV/+t3ar+F+xEpxG8Aalj7f7HMRB65VuSHta18HlsV4ri8CUv2iVZ+cOHuBATSfJHQ0yFBC91kPmRKmUN9IobMDxRhnbClPGV2vEDSwwoHUCiG2KoWEoU+ie1KzszsHCO+xHCJDsVOWUIFRP7gdgvwomuAq4rlh+Cln8JD7x2FTY4XBO1+OVT0pD26V+VeNQi4f/bDnOn5vX7CfmVyw0v5kKo53g2jDgfGxYYd4l7seArhA8ypLV+e8e2F1V+tP8RXzQF/PG+CWRyjisRr02VEWj6Xz5bGtsS6If+YfPVoluGGaLbUbpnC1i/Ver/NdRhLgLQrlMEwct7j55hpDa1dKfxB8+aEyck11zDFTpSs0iao69HNpQPPUr+iLWNyjcVX0nBMMiiItmtOsi7gijdt2lL/FA3i5NfepA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(39830400003)(396003)(366004)(376002)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(41300700001)(7416002)(4326008)(8676002)(8936002)(5660300002)(86362001)(30864003)(2906002)(33716001)(83380400001)(38100700002)(6666004)(9686003)(6512007)(6506007)(6486002)(478600001)(26005)(54906003)(66556008)(66476007)(6916009)(316002)(66946007)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Kwq2aEWirzckjDim9QsKMs0lakUeeMC0tRMmF7vpxyy4wG3jCquda1u6siQ6?=
 =?us-ascii?Q?5gM6Kldq8vi6aQfMxK+H3VufVJK4YMXiR+O2w4XnkiIyUJevKk731ImBfeLv?=
 =?us-ascii?Q?HOK6RbREOq4AJIe1N+ck/g0WoP0vkv/f6CSsWaLXMa/J46aBd0CkuUlfKaBm?=
 =?us-ascii?Q?ytOzIPN3RsrUrvrijzSWmEw1suEQZ4HU0mKiZQytAKKQTCDIY+OIyQAbAY2U?=
 =?us-ascii?Q?/A8u4Zn3mtQIGzKOW23ONCrLLE8hKlRIcfTJ5Ste5MZQ5rBAncGbU4ASHqnM?=
 =?us-ascii?Q?X8O2mZxuiudQgBdFfmpul8Yrff+loK/RebsrEzDgaFlmxVXPV5k0Y3gb8yLC?=
 =?us-ascii?Q?sRqZthzKYS/rY+UzEnaoDRhZd47jGBqej90jl13iwY2P6ycaENWW0lmLNVNL?=
 =?us-ascii?Q?ocgBBONaWNMXSWkMYh4X5wwqUsr7gaNwF3hzOSyESfGOaOUPmEIJHJmJUirK?=
 =?us-ascii?Q?pRBu88HaYRS6ZLyD4bD2qSGAK7OU3L1rJy/B4mzwRbhJSO5uJtdJ0+y/qg0Q?=
 =?us-ascii?Q?4lJ8iXOSZLY/U59FKX0wDxertcI+GCJUJNWT1wZk2SqqSMXDNn/Xq/UGPqQv?=
 =?us-ascii?Q?vz8wzBvPFsXDMSG28Fm3tNsoOdvm7RL+u1kOyKhYmYO92Bo6AkJ1m93I7/bN?=
 =?us-ascii?Q?PXNlu07RTI0NWZiIPVpqEaY/ZZvnO28O3joe83p6J8qSnBx8r2QNEcqJzOia?=
 =?us-ascii?Q?KQ/fvBDuK1XBvx0Wf8tJR0z9IMZ9ieSVMLsrdgwnSPV2ZLNdByBnf6LyfwSs?=
 =?us-ascii?Q?Yov3FztwpgvuyDV0jB5t9QnOMDktrywKSLC2iklyaR7rUV7ONzTf9Zvi6XgH?=
 =?us-ascii?Q?4oBE/Hr+vNTWsqhwMxpKZ3yW0f8xBBNeglmYYvarGKlgKcJt9CukL0q4g5uA?=
 =?us-ascii?Q?7IlzuUpdXcuSJAB98FF3WBA0VC9OZqYJxCAqD2SoZsQk7LcFWPAwKAx97Ery?=
 =?us-ascii?Q?rUBV+ib/C87fImqaaxBPASqqtL8K7FsveXtSAIxpuSZ3Jn91xDtJO+cYwbrh?=
 =?us-ascii?Q?LZ7ypXMSqhAx33J0Rbnt5DFFXVKUl9+A1E9xgUYHn3AUA9B4OmvMja8+Iqyo?=
 =?us-ascii?Q?5BRjlfarhNz9LKjhb5se+YtEAIaE7pjEVC9E3vB259otfsg3jdzTv8vKNlVE?=
 =?us-ascii?Q?l70dCMuc/CQ/TQI7QTgid3HX5yS8hn87s450YoAImYQw0QIc5v/Ra+4iLK84?=
 =?us-ascii?Q?ytHxddW0TY7Ml3lCuKCZcUaBaEA3pZQ6pv2L/7xRYhkQG4GV7roZGfllUnWn?=
 =?us-ascii?Q?s7Sotwz5t2BrJY/LpPdZr3zj6M4ueplj2HSV2Xn8wsrwKLDEoM3XwXriOm2z?=
 =?us-ascii?Q?KSh6R2J7cp9qS9i7vgz5AE4JW7oBcp9EpDa3bTZEjbnqpiOyfW05fcJBPlbu?=
 =?us-ascii?Q?e96CWD7Kym9Irv3bND76d/cTUI1vw/U9nS22bj+l3GR7mgmqhPj76V5cXKDI?=
 =?us-ascii?Q?y1m0iGgyZun5+k6EnfWUUWeCSJSTe0s+XGtn/seozEGAQqBCkYxZTfcd/dkb?=
 =?us-ascii?Q?fB8rMQZWvhtYLUJC1YnxeEHKkCDIVViumNRH599HwyGx7Lqj8Mtj6kM7cQHw?=
 =?us-ascii?Q?NHT+jHxc7DnvJGenVW8g3vWZNK6kVfqAyhvwqCix?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0ad9ffd-364d-4fc8-852a-08dbd5dee300
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 04:49:07.2903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eBjEKRmhIS49HeZe8e/uA5JVITC1jj6zFSsGWokUaOiTD5NHgOlQqmSa9RKt4jIcmFLg42E9GKhZHzcZBA37Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR08MB7320
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephan,

On Tue, Oct 24, 2023 at 08:35:46PM +0200, Stephan Gerhold wrote:
> From: Jonathan Albrieux <jonathan.albrieux@gmail.com>
> 
> Add a simple driver for the Himax HX852x(ES) touch panel controller,
> with support for multi-touch and capacitive touch keys.
> 
> The driver is somewhat based on sample code from Himax. However, that
> code was so extremely confusing that we spent a significant amount of
> time just trying to understand the packet format and register commands.
> In this driver they are described with clean structs and defines rather
> than lots of magic numbers and offset calculations.
> 
> Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
> Co-developed-by: Stephan Gerhold <stephan@gerhold.net>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>

Reviewed-by: Jeff LaBundy <jeff@labundy.com>

Many thanks for the productive discussion.

> ---
>  MAINTAINERS                              |   7 +
>  drivers/input/touchscreen/Kconfig        |  10 +
>  drivers/input/touchscreen/Makefile       |   1 +
>  drivers/input/touchscreen/himax_hx852x.c | 500 +++++++++++++++++++++++++++++++
>  4 files changed, 518 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4cc6bf79fdd8..c0004b25b524 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9264,6 +9264,13 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/input/touchscreen/himax,hx83112b.yaml
>  F:	drivers/input/touchscreen/himax_hx83112b.c
>  
> +HIMAX HX852X TOUCHSCREEN DRIVER
> +M:	Stephan Gerhold <stephan@gerhold.net>
> +L:	linux-input@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/input/touchscreen/himax,hx852es.yaml
> +F:	drivers/input/touchscreen/himax_hx852x.c
> +
>  HIPPI
>  M:	Jes Sorensen <jes@trained-monkey.org>
>  L:	linux-hippi@sunsite.dk
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index e3e2324547b9..8e5667ae5dab 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -427,6 +427,16 @@ config TOUCHSCREEN_HIDEEP
>  	  To compile this driver as a module, choose M here : the
>  	  module will be called hideep_ts.
>  
> +config TOUCHSCREEN_HIMAX_HX852X
> +	tristate "Himax HX852x(ES) touchscreen"
> +	depends on I2C
> +	help
> +	  Say Y here if you have a Himax HX852x(ES) touchscreen.
> +	  If unsure, say N.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called himax_hx852x.
> +
>  config TOUCHSCREEN_HYCON_HY46XX
>  	tristate "Hycon hy46xx touchscreen support"
>  	depends on I2C
> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
> index 62bd24f3ac8e..f42a87faa86c 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -48,6 +48,7 @@ obj-$(CONFIG_TOUCHSCREEN_EXC3000)	+= exc3000.o
>  obj-$(CONFIG_TOUCHSCREEN_FUJITSU)	+= fujitsu_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_GOODIX)	+= goodix_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_HIDEEP)	+= hideep.o
> +obj-$(CONFIG_TOUCHSCREEN_HIMAX_HX852X)	+= himax_hx852x.o
>  obj-$(CONFIG_TOUCHSCREEN_HYNITRON_CSTXXX)	+= hynitron_cstxxx.o
>  obj-$(CONFIG_TOUCHSCREEN_ILI210X)	+= ili210x.o
>  obj-$(CONFIG_TOUCHSCREEN_ILITEK)	+= ilitek_ts_i2c.o
> diff --git a/drivers/input/touchscreen/himax_hx852x.c b/drivers/input/touchscreen/himax_hx852x.c
> new file mode 100644
> index 000000000000..6aa39f02829d
> --- /dev/null
> +++ b/drivers/input/touchscreen/himax_hx852x.c
> @@ -0,0 +1,500 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Himax HX852x(ES) Touchscreen Driver
> + * Copyright (c) 2020-2023 Stephan Gerhold <stephan@gerhold.net>
> + * Copyright (c) 2020 Jonathan Albrieux <jonathan.albrieux@gmail.com>
> + *
> + * Based on the Himax Android Driver Sample Code Ver 0.3 for HMX852xES chipset:
> + * Copyright (c) 2014 Himax Corporation.
> + */
> +
> +#include <asm/unaligned.h>
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/i2c.h>
> +#include <linux/input.h>
> +#include <linux/input/mt.h>
> +#include <linux/input/touchscreen.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/regulator/consumer.h>
> +
> +#define HX852X_COORD_SIZE(fingers)	((fingers) * sizeof(struct hx852x_coord))
> +#define HX852X_WIDTH_SIZE(fingers)	ALIGN(fingers, 4)
> +#define HX852X_BUF_SIZE(fingers)	(HX852X_COORD_SIZE(fingers) + \
> +					 HX852X_WIDTH_SIZE(fingers) + \
> +					 sizeof(struct hx852x_touch_info))
> +
> +#define HX852X_MAX_FINGERS		12
> +#define HX852X_MAX_KEY_COUNT		4
> +#define HX852X_MAX_BUF_SIZE		HX852X_BUF_SIZE(HX852X_MAX_FINGERS)
> +
> +#define HX852X_TS_SLEEP_IN		0x80
> +#define HX852X_TS_SLEEP_OUT		0x81
> +#define HX852X_TS_SENSE_OFF		0x82
> +#define HX852X_TS_SENSE_ON		0x83
> +#define HX852X_READ_ONE_EVENT		0x85
> +#define HX852X_READ_ALL_EVENTS		0x86
> +#define HX852X_READ_LATEST_EVENT	0x87
> +#define HX852X_CLEAR_EVENT_STACK	0x88
> +
> +#define HX852X_REG_SRAM_SWITCH		0x8c
> +#define HX852X_REG_SRAM_ADDR		0x8b
> +#define HX852X_REG_FLASH_RPLACE		0x5a
> +
> +#define HX852X_SRAM_SWITCH_TEST_MODE	0x14
> +#define HX852X_SRAM_ADDR_CONFIG		0x7000
> +
> +struct hx852x {
> +	struct i2c_client *client;
> +	struct input_dev *input_dev;
> +	struct touchscreen_properties props;
> +	struct gpio_desc *reset_gpiod;
> +	struct regulator_bulk_data supplies[2];
> +	unsigned int max_fingers;
> +	unsigned int keycount;
> +	unsigned int keycodes[HX852X_MAX_KEY_COUNT];
> +};
> +
> +struct hx852x_config {
> +	u8 rx_num;
> +	u8 tx_num;
> +	u8 max_pt;
> +	u8 padding1[3];
> +	__be16 x_res;
> +	__be16 y_res;
> +	u8 padding2[2];
> +} __packed __aligned(4);
> +
> +struct hx852x_coord {
> +	__be16 x;
> +	__be16 y;
> +} __packed __aligned(4);
> +
> +struct hx852x_touch_info {
> +	u8 finger_num;
> +	__le16 finger_pressed;
> +	u8 padding;
> +} __packed __aligned(4);
> +
> +static int hx852x_i2c_read(struct hx852x *hx, u8 cmd, void *data, u16 len)
> +{
> +	struct i2c_client *client = hx->client;
> +	int ret;
> +
> +	struct i2c_msg msg[] = {
> +		{
> +			.addr = client->addr,
> +			.flags = 0,
> +			.len = 1,
> +			.buf = &cmd,
> +		},
> +		{
> +			.addr = client->addr,
> +			.flags = I2C_M_RD,
> +			.len = len,
> +			.buf = data,
> +		},
> +	};
> +
> +	ret = i2c_transfer(client->adapter, msg, ARRAY_SIZE(msg));
> +	if (ret != ARRAY_SIZE(msg)) {
> +		dev_err(&client->dev, "failed to read %#x: %d\n", cmd, ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int hx852x_power_on(struct hx852x *hx)
> +{
> +	struct device *dev = &hx->client->dev;
> +	int error;
> +
> +	error = regulator_bulk_enable(ARRAY_SIZE(hx->supplies), hx->supplies);
> +	if (error) {
> +		dev_err(dev, "failed to enable regulators: %d\n", error);
> +		return error;
> +	}
> +
> +	gpiod_set_value_cansleep(hx->reset_gpiod, 1);
> +	msleep(20);
> +	gpiod_set_value_cansleep(hx->reset_gpiod, 0);
> +	msleep(20);
> +
> +	return 0;
> +}
> +
> +static int hx852x_start(struct hx852x *hx)
> +{
> +	struct device *dev = &hx->client->dev;
> +	int error;
> +
> +	error = i2c_smbus_write_byte(hx->client, HX852X_TS_SLEEP_OUT);
> +	if (error) {
> +		dev_err(dev, "failed to send TS_SLEEP_OUT: %d\n", error);
> +		return error;
> +	}
> +	msleep(30);
> +
> +	error = i2c_smbus_write_byte(hx->client, HX852X_TS_SENSE_ON);
> +	if (error) {
> +		dev_err(dev, "failed to send TS_SENSE_ON: %d\n", error);
> +		return error;
> +	}
> +	msleep(20);
> +
> +	return 0;
> +}
> +
> +static int hx852x_stop(struct hx852x *hx)
> +{
> +	struct device *dev = &hx->client->dev;
> +	int error;
> +
> +	error = i2c_smbus_write_byte(hx->client, HX852X_TS_SENSE_OFF);
> +	if (error) {
> +		dev_err(dev, "failed to send TS_SENSE_OFF: %d\n", error);
> +		return error;
> +	}
> +	msleep(20);
> +
> +	error = i2c_smbus_write_byte(hx->client, HX852X_TS_SLEEP_IN);
> +	if (error) {
> +		dev_err(dev, "failed to send TS_SLEEP_IN: %d\n", error);
> +		return error;
> +	}
> +	msleep(30);
> +
> +	return 0;
> +}
> +
> +static int hx852x_power_off(struct hx852x *hx)
> +{
> +	struct device *dev = &hx->client->dev;
> +	int error;
> +
> +	error = regulator_bulk_disable(ARRAY_SIZE(hx->supplies), hx->supplies);
> +	if (error) {
> +		dev_err(dev, "failed to disable regulators: %d\n", error);
> +		return error;
> +	}
> +
> +	return 0;
> +}
> +
> +static int hx852x_read_config(struct hx852x *hx)
> +{
> +	struct device *dev = &hx->client->dev;
> +	struct hx852x_config conf;
> +	int x_res, y_res;
> +	int error;
> +
> +	error = hx852x_power_on(hx);
> +	if (error)
> +		return error;
> +
> +	/* Sensing must be turned on briefly to load the config */
> +	error = hx852x_start(hx);
> +	if (error)
> +		goto err_power_off;
> +
> +	error = hx852x_stop(hx);
> +	if (error)
> +		goto err_power_off;
> +
> +	error = i2c_smbus_write_byte_data(hx->client, HX852X_REG_SRAM_SWITCH,
> +					  HX852X_SRAM_SWITCH_TEST_MODE);
> +	if (error)
> +		goto err_power_off;
> +
> +	error = i2c_smbus_write_word_data(hx->client, HX852X_REG_SRAM_ADDR,
> +					  HX852X_SRAM_ADDR_CONFIG);
> +	if (error)
> +		goto err_test_mode;
> +
> +	error = hx852x_i2c_read(hx, HX852X_REG_FLASH_RPLACE, &conf, sizeof(conf));
> +	if (error)
> +		goto err_test_mode;
> +
> +	x_res = be16_to_cpu(conf.x_res);
> +	y_res = be16_to_cpu(conf.y_res);
> +	hx->max_fingers = (conf.max_pt & 0xf0) >> 4;
> +	dev_dbg(dev, "x res: %u, y res: %u, max fingers: %u\n",
> +		x_res, y_res, hx->max_fingers);
> +
> +	if (hx->max_fingers > HX852X_MAX_FINGERS) {
> +		dev_err(dev, "max supported fingers: %u, found: %u\n",
> +			HX852X_MAX_FINGERS, hx->max_fingers);
> +		error = -EINVAL;
> +		goto err_test_mode;
> +	}
> +
> +	if (x_res && y_res) {
> +		input_set_abs_params(hx->input_dev, ABS_MT_POSITION_X, 0, x_res - 1, 0, 0);
> +		input_set_abs_params(hx->input_dev, ABS_MT_POSITION_Y, 0, y_res - 1, 0, 0);
> +	}
> +
> +err_test_mode:
> +	error = i2c_smbus_write_byte_data(hx->client, HX852X_REG_SRAM_SWITCH, 0) ? : error;
> +err_power_off:
> +	return hx852x_power_off(hx) ? : error;
> +}
> +
> +static int hx852x_handle_events(struct hx852x *hx)
> +{
> +	/*
> +	 * The event packets have variable size, depending on the amount of
> +	 * supported fingers (hx->max_fingers). They are laid out as follows:
> +	 *  - struct hx852x_coord[hx->max_fingers]: Coordinates for each finger
> +	 *  - u8[ALIGN(hx->max_fingers, 4)]: Touch width for each finger
> +	 *      with padding for 32-bit alignment
> +	 *  - struct hx852x_touch_info
> +	 *
> +	 * Load everything into a 32-bit aligned buffer so the coordinates
> +	 * can be assigned directly, without using get_unaligned_*().
> +	 */
> +	u8 buf[HX852X_MAX_BUF_SIZE] __aligned(4);
> +	struct hx852x_coord *coord = (struct hx852x_coord *)buf;
> +	u8 *width = &buf[HX852X_COORD_SIZE(hx->max_fingers)];
> +	struct hx852x_touch_info *info = (struct hx852x_touch_info *)
> +		&width[HX852X_WIDTH_SIZE(hx->max_fingers)];
> +	unsigned long finger_pressed, key_pressed;
> +	unsigned int i, x, y, w;
> +	int error;
> +
> +	error = hx852x_i2c_read(hx, HX852X_READ_ALL_EVENTS, buf,
> +				HX852X_BUF_SIZE(hx->max_fingers));
> +	if (error)
> +		return error;
> +
> +	finger_pressed = get_unaligned_le16(&info->finger_pressed);
> +	key_pressed = finger_pressed >> HX852X_MAX_FINGERS;
> +
> +	/* All bits are set when no touch is detected */
> +	if (info->finger_num == 0xff || !(info->finger_num & 0x0f))
> +		finger_pressed = 0;
> +	if (key_pressed == 0xf)
> +		key_pressed = 0;
> +
> +	for_each_set_bit(i, &finger_pressed, hx->max_fingers) {
> +		x = be16_to_cpu(coord[i].x);
> +		y = be16_to_cpu(coord[i].y);
> +		w = width[i];
> +
> +		input_mt_slot(hx->input_dev, i);
> +		input_mt_report_slot_state(hx->input_dev, MT_TOOL_FINGER, 1);
> +		touchscreen_report_pos(hx->input_dev, &hx->props, x, y, true);
> +		input_report_abs(hx->input_dev, ABS_MT_TOUCH_MAJOR, w);
> +	}
> +	input_mt_sync_frame(hx->input_dev);
> +
> +	for (i = 0; i < hx->keycount; i++)
> +		input_report_key(hx->input_dev, hx->keycodes[i], key_pressed & BIT(i));
> +
> +	input_sync(hx->input_dev);
> +	return 0;
> +}
> +
> +static irqreturn_t hx852x_interrupt(int irq, void *ptr)
> +{
> +	struct hx852x *hx = ptr;
> +	int error;
> +
> +	error = hx852x_handle_events(hx);
> +	if (error) {
> +		dev_err_ratelimited(&hx->client->dev, "failed to handle events: %d\n", error);
> +		return IRQ_NONE;
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int hx852x_input_open(struct input_dev *dev)
> +{
> +	struct hx852x *hx = input_get_drvdata(dev);
> +	int error;
> +
> +	error = hx852x_power_on(hx);
> +	if (error)
> +		return error;
> +
> +	error = hx852x_start(hx);
> +	if (error) {
> +		hx852x_power_off(hx);
> +		return error;
> +	}
> +
> +	enable_irq(hx->client->irq);
> +	return 0;
> +}
> +
> +static void hx852x_input_close(struct input_dev *dev)
> +{
> +	struct hx852x *hx = input_get_drvdata(dev);
> +
> +	hx852x_stop(hx);
> +	disable_irq(hx->client->irq);
> +	hx852x_power_off(hx);
> +}
> +
> +static int hx852x_parse_properties(struct hx852x *hx)
> +{
> +	struct device *dev = &hx->client->dev;
> +	int error, count;
> +
> +	count = device_property_count_u32(dev, "linux,keycodes");
> +	if (count == -EINVAL) {
> +		/* Property does not exist, keycodes are optional */
> +		return 0;
> +	} else if (count < 0) {
> +		dev_err(dev, "Failed to read linux,keycodes: %d\n", count);
> +		return count;
> +	} else if (count > HX852X_MAX_KEY_COUNT) {
> +		dev_err(dev, "max supported keys: %u, found: %u\n",
> +			HX852X_MAX_KEY_COUNT, hx->keycount);
> +		return -EINVAL;
> +	}
> +	hx->keycount = count;
> +
> +	error = device_property_read_u32_array(dev, "linux,keycodes",
> +					       hx->keycodes, hx->keycount);
> +	if (error) {
> +		dev_err(dev, "failed to read linux,keycodes: %d\n", error);
> +		return error;
> +	}
> +
> +	return 0;
> +}
> +
> +static int hx852x_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct hx852x *hx;
> +	int error, i;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C |
> +				     I2C_FUNC_SMBUS_WRITE_BYTE |
> +				     I2C_FUNC_SMBUS_WRITE_BYTE_DATA |
> +				     I2C_FUNC_SMBUS_WRITE_WORD_DATA)) {
> +		dev_err(dev, "not all required i2c functionality supported\n");
> +		return -ENXIO;
> +	}
> +
> +	hx = devm_kzalloc(dev, sizeof(*hx), GFP_KERNEL);
> +	if (!hx)
> +		return -ENOMEM;
> +
> +	hx->client = client;
> +	hx->input_dev = devm_input_allocate_device(dev);
> +	if (!hx->input_dev)
> +		return -ENOMEM;
> +
> +	hx->input_dev->name = "Himax HX852x";
> +	hx->input_dev->id.bustype = BUS_I2C;
> +	hx->input_dev->open = hx852x_input_open;
> +	hx->input_dev->close = hx852x_input_close;
> +
> +	i2c_set_clientdata(client, hx);
> +	input_set_drvdata(hx->input_dev, hx);
> +
> +	hx->supplies[0].supply = "vcca";
> +	hx->supplies[1].supply = "vccd";
> +	error = devm_regulator_bulk_get(dev, ARRAY_SIZE(hx->supplies), hx->supplies);
> +	if (error)
> +		return dev_err_probe(dev, error, "failed to get regulators\n");
> +
> +	hx->reset_gpiod = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(hx->reset_gpiod))
> +		return dev_err_probe(dev, PTR_ERR(hx->reset_gpiod),
> +				     "failed to get reset gpio\n");
> +
> +	error = devm_request_threaded_irq(dev, client->irq, NULL, hx852x_interrupt,
> +					  IRQF_ONESHOT | IRQF_NO_AUTOEN, NULL, hx);
> +	if (error)
> +		return dev_err_probe(dev, error, "failed to request irq %d", client->irq);
> +
> +	error = hx852x_read_config(hx);
> +	if (error)
> +		return error;
> +
> +	input_set_capability(hx->input_dev, EV_ABS, ABS_MT_POSITION_X);
> +	input_set_capability(hx->input_dev, EV_ABS, ABS_MT_POSITION_Y);
> +	input_set_abs_params(hx->input_dev, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
> +
> +	touchscreen_parse_properties(hx->input_dev, true, &hx->props);
> +	error = hx852x_parse_properties(hx);
> +	if (error)
> +		return error;
> +
> +	hx->input_dev->keycode = hx->keycodes;
> +	hx->input_dev->keycodemax = hx->keycount;
> +	hx->input_dev->keycodesize = sizeof(hx->keycodes[0]);
> +	for (i = 0; i < hx->keycount; i++)
> +		input_set_capability(hx->input_dev, EV_KEY, hx->keycodes[i]);
> +
> +	error = input_mt_init_slots(hx->input_dev, hx->max_fingers,
> +				    INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
> +	if (error)
> +		return dev_err_probe(dev, error, "failed to init MT slots\n");
> +
> +	error = input_register_device(hx->input_dev);
> +	if (error)
> +		return dev_err_probe(dev, error, "failed to register input device\n");
> +
> +	return 0;
> +}
> +
> +static int hx852x_suspend(struct device *dev)
> +{
> +	struct hx852x *hx = dev_get_drvdata(dev);
> +	int error = 0;
> +
> +	mutex_lock(&hx->input_dev->mutex);
> +	if (input_device_enabled(hx->input_dev))
> +		error = hx852x_stop(hx);
> +	mutex_unlock(&hx->input_dev->mutex);
> +
> +	return error;
> +}
> +
> +static int hx852x_resume(struct device *dev)
> +{
> +	struct hx852x *hx = dev_get_drvdata(dev);
> +	int error = 0;
> +
> +	mutex_lock(&hx->input_dev->mutex);
> +	if (input_device_enabled(hx->input_dev))
> +		error = hx852x_start(hx);
> +	mutex_unlock(&hx->input_dev->mutex);
> +
> +	return error;
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(hx852x_pm_ops, hx852x_suspend, hx852x_resume);
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id hx852x_of_match[] = {
> +	{ .compatible = "himax,hx852es" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, hx852x_of_match);
> +#endif
> +
> +static struct i2c_driver hx852x_driver = {
> +	.probe = hx852x_probe,
> +	.driver = {
> +		.name = "himax_hx852x",
> +		.pm = pm_sleep_ptr(&hx852x_pm_ops),
> +		.of_match_table = of_match_ptr(hx852x_of_match),
> +	},
> +};
> +module_i2c_driver(hx852x_driver);
> +
> +MODULE_DESCRIPTION("Himax HX852x(ES) Touchscreen Driver");
> +MODULE_AUTHOR("Jonathan Albrieux <jonathan.albrieux@gmail.com>");
> +MODULE_AUTHOR("Stephan Gerhold <stephan@gerhold.net>");
> +MODULE_LICENSE("GPL");
> 
> -- 
> 2.42.0
> 

Kind regards,
Jeff LaBundy
