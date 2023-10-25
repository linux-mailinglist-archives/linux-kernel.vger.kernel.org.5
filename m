Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CED77D6036
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 05:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbjJYDDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 23:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbjJYDDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 23:03:20 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2082.outbound.protection.outlook.com [40.107.102.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70F610E0;
        Tue, 24 Oct 2023 20:03:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E5ZgRdCC/BSz51hfundq9I2IzVakhxxG5KO0xbdvYQZumLxjljCwe2Y20ppC/ov8nzjwW2crSlUiAOCDg9t74NMkym2OIRD7Qj5Bxr1N6nvQme5NwdEX82O7bWbiaJvdS8FN7CBW7qdqUQRNG9UV1UzNWvsmMY56EFf+MqMHaLmY0K8QTAdY+7W+oyzrAIwj0bI5ishVYshmRCu33oz9Le+PWbG1+++TfMMODWX9uP4DLbY3ou07MZUBXUJVpppN1v1THXzMy+d+uozuwTg8WAHqiRh5Cw3hscRKPqUrlj2fGwp2uyvax4oHfUquWmneGqER+iNxE7iRxDSxjp7RlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lifsBpGpGVWxGG2/Et38xwhn25wtt/0HTYeLunlwriI=;
 b=Ggjo+Is4HEq3S2DlvygRdzqWOSdNHaYKe1TaruHUes5g98FY3NR1/+Y3Xav1TNSW0ynJfpA53/yUwjuJ6mCRMDr3JWw0zgen+oa1iUVrBJ9Nx29vaootvrqRTGTyU4OmpAiuTr5rpIaSOnReoWzW7OipiDatW7BywvCO76mv/K6MbZ38k8dY1bU/7HhiqG/wELT4yeRr8k3eXsDg4xUCJvG99TgXn14uAjMRZtothFdaCtNk02tHa0L2IvV4Jog2TUSngWkNKkXaJDuglskFMHwbBwMMZXSN2haymJHCiYFgSRNQnjZ8YK7gOWYRS5EHOFLFKQWLHoC689r4GsHAAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lifsBpGpGVWxGG2/Et38xwhn25wtt/0HTYeLunlwriI=;
 b=jsHOhJhmtmtuPGPNN78Z53YaLbDysYwBcwSyU1wCgjfL9lyilyXJe3viwB/eiMpJApVCckEeDX0k+zUJ1sXJHO+4lVNcKSDKKpCQngnR4IqXKFLeYZqKFKISeUAuiNW/88Y3nSP/3Yyi/DdCavL/Je2CGjK8dnqsRm3kab2CYgw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by BL3PR08MB7378.namprd08.prod.outlook.com
 (2603:10b6:208:355::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 03:03:13 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::e73c:270b:75f7:5302]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::e73c:270b:75f7:5302%4]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 03:03:13 +0000
Date:   Tue, 24 Oct 2023 22:03:10 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     James Ogletree <james.ogletree@opensource.cirrus.com>
Cc:     James Ogletree <james.ogletree@cirrus.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Fred Treven <fred.treven@cirrus.com>,
        Ben Bright <ben.bright@cirrus.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] Input: cs40l50 - Add support for the CS40L50
 haptic driver
Message-ID: <ZTiFbmutojF0LRZU@nixie71>
References: <20231018175726.3879955-1-james.ogletree@opensource.cirrus.com>
 <20231018175726.3879955-5-james.ogletree@opensource.cirrus.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018175726.3879955-5-james.ogletree@opensource.cirrus.com>
X-ClientProxiedBy: SA0PR11CA0204.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::29) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|BL3PR08MB7378:EE_
X-MS-Office365-Filtering-Correlation-Id: 1defdb87-94f2-4888-17c5-08dbd506ed5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aOp+Lc0BuwwGNlO3Rj4mZe1GrYTC4XvpY9hQWdSve56tmUIQ6yEZYa/XgHnahuJomkL4g7GAdWwcrIx5BrtMsle2xY5eoU988GuxzrZOEkWZsfInFfLwen3eXronbJllqgyBysdZqAfL4E7wytSk0LnWKtH28BvBYYqYVtIEvR+du5dpBXv28W6DQNaGqGuoZ4SowkeJIJiOv1L30bCZ+TalHx8S+BC0zv1K8tk8O1vTYMNZhSGMRuf7lYBU3kTsiTtNMvcPqXFd8DH44i/5pUoOfiVaXijQDnjetR8pWeth75vJyzbVwyBT80+eX6aX4FQttjxXAa9RG2tHWV28mN0rremmMgme46/gvXkT22D8y4Q2h8GvBjqWuhcI43ivb78jxHf/VHLuISAZvjq1O+QHRFbH4xs8vIpa+RBld8SHNeUuSdRNHUgO51xuExLOREt+zkzULCfRmC5WnoIRyhRaJ2GHcWRbZ01YNF6fyp3swk+I7EU4iWjWA6/74iYw7ny6sTjPY/YgOfUdeozycPEbwt56LWH03XfjvGyB7XfnfPnPNGuEcR0+t0M032Dh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39830400003)(396003)(366004)(346002)(376002)(136003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(7416002)(83380400001)(2906002)(8676002)(4326008)(8936002)(6486002)(30864003)(9686003)(41300700001)(5660300002)(86362001)(6512007)(6506007)(6916009)(316002)(26005)(478600001)(38100700002)(66946007)(66476007)(54906003)(66556008)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KE2nJq0C+OAZZuEvd3Q2SBotjVEA/w6aCjWo+bAA9m6jgZa6JBHYcOQ1drk/?=
 =?us-ascii?Q?F5mzQrRRYbSqjmdHRd30JUvwHTQzzG/MO4F8MTw7nlZv3+kmwRcQ0niH38Zt?=
 =?us-ascii?Q?Klu9JxRLT1N5Pp4KeqJgFGcp+RU9eLdptzFYA1sLo7X5YqcBf3rnQ+WfpOTt?=
 =?us-ascii?Q?qLiBtscVHixhFPIZWsLbVUauMhKg3lW3+mpDAU0QGuoNc4e8k1eWs3BImWKq?=
 =?us-ascii?Q?mDkothzCLaQL9zCCnAS9Mk5zR2y9uLPUxAGAlLypK5+5dAZZlajdTXSawahI?=
 =?us-ascii?Q?0nBniQAVegpuVDIHd3CRK+nVS6EclaSexI7WHQk6VOus5Vjg0t3WT6OlsFN/?=
 =?us-ascii?Q?p5iUX4i6kgMO6lklUN75bIC0OeJuhcRUy0ioi7WKq1wV1j2NTzYyemiS7QZG?=
 =?us-ascii?Q?6erkd6n6c5D7ypRll1mlaU0ZAzstWt4O1pVKv6CQvKooL56MRqHD/H4VEl0C?=
 =?us-ascii?Q?wtCqmry78/tp1F7KrK1wHHRRgWCPVcV6oxqIUF11O9JX+1iMZYxHJELfQufo?=
 =?us-ascii?Q?+d+9cmsyWugnKgfu/1LlOkmTX1Ox7ecM58b9HuCN960Rfo8lHGVnXkvpL4/w?=
 =?us-ascii?Q?VG/RuP7pxR9ikVhFt9ZiPqY/9vB0I5ug+9a5eXopv1vq3vGWA4UelHHvJhp5?=
 =?us-ascii?Q?xrQIUZL860UhkWZVySmsgfL7S5bw3GMqWRXaLCwwQOk1L8Q7hgXvXTQVNINX?=
 =?us-ascii?Q?q4yH+N6U0TjR47K7xkmKXnxPi+Fppof5IeaGYb2zpZAibOmLScbQ77JmSrrq?=
 =?us-ascii?Q?MUrMKu5hKgq3H4xGykTx7pcUoTEXem21oYk76O1h7++2CjjYNVMhSO/UVS0c?=
 =?us-ascii?Q?isqnLUhjZ09inb3qO8LxhSWtZhp13aUcPSExRzFhBnFNmG1PBUO5GMUS7T+u?=
 =?us-ascii?Q?bS0YIJsViKuI+lLXPPr4ZgtCSdkbg3b/K7SSDuXj5N1lkbU/LkwBrNgMj1PE?=
 =?us-ascii?Q?otynlPV6ojRwLhjBZUDlkljT6vGnJg2rTJeX5kk4RsmJg8bsvG+gcllVTa0v?=
 =?us-ascii?Q?hMAx5wIuS2Bi5HtAiuL7reF0mB3sn1pdYPrdap5UBQpWaMF/sk+26UueQLxK?=
 =?us-ascii?Q?Nd9TyHB4p1K0+c8BsjliYdj32KueeVV+VNa8i380wUXvz+ldhCasAMPZev5I?=
 =?us-ascii?Q?9yeuc8fB6H+RRko2ag2Y1jARUnU/7ydyp17C7nmh9P1Ikq5/Vh9effIJEKBk?=
 =?us-ascii?Q?PYxlxr1LFix230KkIkaFQnD4tq/2E3on1J7dFX4MZvRlFs2wpONorwvdUZvD?=
 =?us-ascii?Q?ucTtFMENZZ6GRM4nneKzhFFFZ2j3XzpsAPJuJB9+y2F07d9R9vgi1yKIIJ+M?=
 =?us-ascii?Q?m62lzEieMxKBmVBQPPpn+iNWT92BxYx3UJgQe7LdwduRKxcPad7i14XwF31/?=
 =?us-ascii?Q?OC1aTUJlyjqCYO4gX4xT4bNTF2HsfEcd2lSEJxwz7M+x8fscixaZ8mJ8+MXn?=
 =?us-ascii?Q?a2UwCu6O9gVY6AC5ep1LMOGBsFCVRuomMrRhs1q2Pp47FV0IGmRAqHOK6iLu?=
 =?us-ascii?Q?gUXPy7ox9CzYhxk+KUSFpRK8ZSVvyBUqahCaZBOZmxTveTrukBXU3h6q6bYJ?=
 =?us-ascii?Q?uxrmgVID6QgfpgSWR0alYgW6Gu2UJameuyAdh74G?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1defdb87-94f2-4888-17c5-08dbd506ed5f
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 03:03:13.3537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G31o7Dxe7qw2ndXj81YV717FcLVRJRaOVJy8hjgjVnBHiQqbbc7H2UlKufcIq7j/ABWiFJIOUH9HlmqVc/THug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR08MB7378
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Wed, Oct 18, 2023 at 05:57:25PM +0000, James Ogletree wrote:
> From: James Ogletree <james.ogletree@cirrus.com>
> 
> Introduce support for Cirrus Logic Device CS40L50: a
> haptic driver with waveform memory, integrated DSP,
> and closed-loop algorithms.
> 
> The input driver provides the interface for control of
> haptic effects through the device.
> 
> Signed-off-by: James Ogletree <james.ogletree@cirrus.com>
> ---
>  MAINTAINERS                        |   1 +
>  drivers/input/misc/Kconfig         |  10 +
>  drivers/input/misc/Makefile        |   1 +
>  drivers/input/misc/cs40l50-vibra.c | 353 +++++++++++++++++++++++++++++
>  4 files changed, 365 insertions(+)
>  create mode 100644 drivers/input/misc/cs40l50-vibra.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 08e1e9695d49..24a00d8e5c1c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4971,6 +4971,7 @@ L:	patches@opensource.cirrus.com
>  S:	Supported
>  F:	Documentation/devicetree/bindings/input/cirrus,cs40l50.yaml
>  F:	drivers/input/misc/cirrus*
> +F:	drivers/input/misc/cs40l*
>  F:	drivers/mfd/cs40l*
>  F:	include/linux/input/cirrus*
>  F:	include/linux/mfd/cs40l*
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index 9f088900f863..938090648126 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -129,6 +129,16 @@ config INPUT_BMA150
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called bma150.
>  
> +config INPUT_CS40L50_VIBRA
> +	tristate "CS40L50 Haptic Driver support"
> +	depends on MFD_CS40L50_CORE
> +	help
> +	  Say Y here to enable support for Cirrus Logic's CS40L50
> +	  haptic driver.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called cs40l50-vibra.
> +
>  config INPUT_E3X0_BUTTON
>  	tristate "NI Ettus Research USRP E3xx Button support."
>  	default n
> diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
> index 6abefc41037b..6b653ed2124f 100644
> --- a/drivers/input/misc/Makefile
> +++ b/drivers/input/misc/Makefile
> @@ -27,6 +27,7 @@ obj-$(CONFIG_INPUT_CMA3000)		+= cma3000_d0x.o
>  obj-$(CONFIG_INPUT_CMA3000_I2C)		+= cma3000_d0x_i2c.o
>  obj-$(CONFIG_INPUT_COBALT_BTNS)		+= cobalt_btns.o
>  obj-$(CONFIG_INPUT_CPCAP_PWRBUTTON)	+= cpcap-pwrbutton.o
> +obj-$(CONFIG_INPUT_CS40L50_VIBRA)	+= cs40l50-vibra.o cirrus_haptics.o
>  obj-$(CONFIG_INPUT_DA7280_HAPTICS)	+= da7280.o
>  obj-$(CONFIG_INPUT_DA9052_ONKEY)	+= da9052_onkey.o
>  obj-$(CONFIG_INPUT_DA9055_ONKEY)	+= da9055_onkey.o
> diff --git a/drivers/input/misc/cs40l50-vibra.c b/drivers/input/misc/cs40l50-vibra.c
> new file mode 100644
> index 000000000000..3b3e4cb10de0
> --- /dev/null
> +++ b/drivers/input/misc/cs40l50-vibra.c
> @@ -0,0 +1,353 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * CS40L50 Advanced Haptic Driver with waveform memory,
> + * integrated DSP, and closed-loop algorithms
> + *
> + * Copyright 2023 Cirrus Logic, Inc.
> + *
> + */
> +
> +#include <linux/firmware/cirrus/wmfw.h>
> +#include <linux/mfd/cs40l50.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +
> +static int cs40l50_add(struct input_dev *dev,
> +		       struct ff_effect *effect,
> +		       struct ff_effect *old)
> +{
> +	struct cs40l50_private *cs40l50 = input_get_drvdata(dev);
> +	u32 len = effect->u.periodic.custom_len;
> +
> +	if (effect->type != FF_PERIODIC || effect->u.periodic.waveform != FF_CUSTOM) {
> +		dev_err(cs40l50->dev, "Type (%#X) or waveform (%#X) unsupported\n",
> +			effect->type, effect->u.periodic.waveform);
> +		return -EINVAL;
> +	}
> +
> +	memcpy(&cs40l50->haptics.add_effect, effect, sizeof(struct ff_effect));
> +
> +	cs40l50->haptics.add_effect.u.periodic.custom_data = kcalloc(len,
> +								     sizeof(s16),
> +								     GFP_KERNEL);
> +	if (!cs40l50->haptics.add_effect.u.periodic.custom_data)
> +		return -ENOMEM;
> +
> +	if (copy_from_user(cs40l50->haptics.add_effect.u.periodic.custom_data,
> +			   effect->u.periodic.custom_data, sizeof(s16) * len)) {
> +		cs40l50->haptics.add_error = -EFAULT;
> +		goto out_free;
> +	}
> +
> +	queue_work(cs40l50->haptics.vibe_wq, &cs40l50->haptics.add_work);
> +	flush_work(&cs40l50->haptics.add_work);
> +
> +out_free:
> +	kfree(cs40l50->haptics.add_effect.u.periodic.custom_data);
> +	cs40l50->haptics.add_effect.u.periodic.custom_data = NULL;
> +
> +	return cs40l50->haptics.add_error;
> +}
> +
> +static int cs40l50_playback(struct input_dev *dev, int effect_id, int val)
> +{
> +	struct cs40l50_private *cs40l50 = input_get_drvdata(dev);
> +
> +	if (val > 0) {
> +		cs40l50->haptics.start_effect = &dev->ff->effects[effect_id];
> +		queue_work(cs40l50->haptics.vibe_wq,
> +			   &cs40l50->haptics.vibe_start_work);
> +	} else {
> +		queue_work(cs40l50->haptics.vibe_wq,
> +			   &cs40l50->haptics.vibe_stop_work);
> +	}
> +
> +	return 0;
> +}
> +
> +static int cs40l50_erase(struct input_dev *dev, int effect_id)
> +{
> +	struct cs40l50_private *cs40l50 = input_get_drvdata(dev);
> +
> +	cs40l50->haptics.erase_effect = &dev->ff->effects[effect_id];
> +
> +	queue_work(cs40l50->haptics.vibe_wq, &cs40l50->haptics.erase_work);
> +	flush_work(&cs40l50->haptics.erase_work);
> +
> +	return cs40l50->haptics.erase_error;
> +}
> +
> +static const struct reg_sequence cs40l50_int_vamp_seq[] = {
> +	{ CS40L50_BST_LPMODE_SEL,	CS40L50_DCM_LOW_POWER },
> +	{ CS40L50_BLOCK_ENABLES2,	CS40L50_OVERTEMP_WARN },
> +};
> +
> +static const struct reg_sequence cs40l50_irq_mask_seq[] = {
> +	{ CS40L50_IRQ1_MASK_2,	CS40L50_IRQ_MASK_2_OVERRIDE },
> +	{ CS40L50_IRQ1_MASK_20,	CS40L50_IRQ_MASK_20_OVERRIDE },
> +};
> +
> +static int cs40l50_hw_init(struct cs40l50_private *cs40l50)
> +{
> +	int error;
> +
> +	error = regmap_multi_reg_write(cs40l50->regmap,
> +				       cs40l50_int_vamp_seq,
> +				       ARRAY_SIZE(cs40l50_int_vamp_seq));
> +	if (error)
> +		return error;
> +
> +	error = cs_hap_pseq_multi_write(&cs40l50->haptics,
> +					cs40l50_int_vamp_seq,
> +					ARRAY_SIZE(cs40l50_int_vamp_seq),
> +					false, PSEQ_OP_WRITE_FULL);
> +	if (error)
> +		return error;
> +
> +	error = regmap_multi_reg_write(cs40l50->regmap, cs40l50_irq_mask_seq,
> +				       ARRAY_SIZE(cs40l50_irq_mask_seq));
> +	if (error)
> +		return error;
> +
> +	return cs_hap_pseq_multi_write(&cs40l50->haptics, cs40l50_irq_mask_seq,
> +				       ARRAY_SIZE(cs40l50_irq_mask_seq), false,
> +				       PSEQ_OP_WRITE_FULL);
> +}
> +
> +static const struct cs_dsp_client_ops cs40l50_cs_dsp_client_ops;
> +
> +static const struct cs_dsp_region cs40l50_dsp_regions[] = {
> +	{
> +		.type = WMFW_HALO_PM_PACKED,
> +		.base = CS40L50_DSP1_PMEM_0
> +	},
> +	{
> +		.type = WMFW_HALO_XM_PACKED,
> +		.base = CS40L50_DSP1_XMEM_PACKED_0
> +	},
> +	{
> +		.type = WMFW_HALO_YM_PACKED,
> +		.base = CS40L50_DSP1_YMEM_PACKED_0
> +	},
> +	{
> +		.type = WMFW_ADSP2_XM,
> +		.base = CS40L50_DSP1_XMEM_UNPACKED24_0
> +	},
> +	{
> +		.type = WMFW_ADSP2_YM,
> +		.base = CS40L50_DSP1_YMEM_UNPACKED24_0
> +	},
> +};
> +
> +static int cs40l50_cs_dsp_init(struct cs40l50_private *cs40l50)
> +{
> +	cs40l50->dsp.num = 1;
> +	cs40l50->dsp.type = WMFW_HALO;
> +	cs40l50->dsp.dev = cs40l50->dev;
> +	cs40l50->dsp.regmap = cs40l50->regmap;
> +	cs40l50->dsp.base = CS40L50_CORE_BASE;
> +	cs40l50->dsp.base_sysinfo = CS40L50_SYS_INFO_ID;
> +	cs40l50->dsp.mem = cs40l50_dsp_regions;
> +	cs40l50->dsp.num_mems = ARRAY_SIZE(cs40l50_dsp_regions);
> +	cs40l50->dsp.no_core_startstop = true;
> +	cs40l50->dsp.client_ops = &cs40l50_cs_dsp_client_ops;
> +
> +	return cs_dsp_halo_init(&cs40l50->dsp);
> +}
> +
> +static struct cs_hap_bank cs40l50_banks[] = {
> +	{
> +		.bank =		WVFRM_BANK_RAM,
> +		.base_index =	CS40L50_RAM_BANK_INDEX_START,
> +		.max_index =	CS40L50_RAM_BANK_INDEX_START,
> +	},
> +	{
> +		.bank =		WVFRM_BANK_ROM,
> +		.base_index =	CS40L50_ROM_BANK_INDEX_START,
> +		.max_index =	CS40L50_ROM_BANK_INDEX_END,
> +	},
> +	{
> +		.bank =		WVFRM_BANK_OWT,
> +		.base_index =	CS40L50_RTH_INDEX_START,
> +		.max_index =	CS40L50_RTH_INDEX_END,
> +	},
> +};

These structs describe the DSP, and hence the silicon; they are not
specific to the input/FF device. Presumably the DSP could run algorithms
that support only the I2S streaming case as well (e.g. A2H); therefore,
these seem more appropriately placed in the MFD.

> +
> +static int cs40l50_cs_hap_init(struct cs40l50_private *cs40l50)
> +{
> +	cs40l50->haptics.regmap = cs40l50->regmap;
> +	cs40l50->haptics.dev = cs40l50->dev;
> +	cs40l50->haptics.banks = cs40l50_banks;
> +	cs40l50->haptics.dsp.gpio_base_reg = CS40L50_GPIO_BASE;
> +	cs40l50->haptics.dsp.owt_base_reg = CS40L50_OWT_BASE;
> +	cs40l50->haptics.dsp.owt_offset_reg = CS40L50_OWT_NEXT;
> +	cs40l50->haptics.dsp.owt_size_reg = CS40L50_OWT_SIZE;
> +	cs40l50->haptics.dsp.mailbox_reg = CS40L50_DSP_MBOX;
> +	cs40l50->haptics.dsp.pseq_reg = CS40L50_POWER_ON_SEQ;
> +	cs40l50->haptics.dsp.push_owt_cmd = CS40L50_OWT_PUSH;
> +	cs40l50->haptics.dsp.delete_owt_cmd = CS40L50_OWT_DELETE;
> +	cs40l50->haptics.dsp.stop_cmd = CS40L50_STOP_PLAYBACK;
> +	cs40l50->haptics.dsp.pseq_size = CS40L50_PSEQ_SIZE;
> +	cs40l50->haptics.runtime_pm = true;
> +
> +	return cs_hap_init(&cs40l50->haptics);
> +}
> +
> +static void cs40l50_upload_wt(const struct firmware *bin, void *context)
> +{
> +	struct cs40l50_private *cs40l50 = context;
> +	u32 nwaves;
> +
> +	mutex_lock(&cs40l50->lock);
> +
> +	if (cs40l50->wmfw) {
> +		if (regmap_write(cs40l50->regmap, CS40L50_CCM_CORE_CONTROL,
> +				 CS40L50_CLOCK_DISABLE))
> +			goto err_mutex;
> +
> +		if (regmap_write(cs40l50->regmap, CS40L50_RAM_INIT,
> +				 CS40L50_RAM_INIT_FLAG))
> +			goto err_mutex;
> +
> +		if (regmap_write(cs40l50->regmap, CS40L50_PWRMGT_CTL,
> +				 CS40L50_MEM_RDY_HW))
> +			goto err_mutex;
> +	}
> +
> +	cs_dsp_power_up(&cs40l50->dsp, cs40l50->wmfw, "cs40l50.wmfw",
> +			bin, "cs40l50.bin", "cs40l50");
> +
> +	if (cs40l50->wmfw) {
> +		if (regmap_write(cs40l50->regmap, CS40L50_CCM_CORE_CONTROL,
> +				 CS40L50_CLOCK_ENABLE))
> +			goto err_mutex;
> +	}
> +
> +	if (regmap_read(cs40l50->regmap, CS40L50_NUM_OF_WAVES, &nwaves))
> +		goto err_mutex;
> +
> +	cs40l50->haptics.banks[WVFRM_BANK_RAM].max_index += (nwaves - 1);
> +
> +err_mutex:
> +	mutex_unlock(&cs40l50->lock);
> +	release_firmware(bin);
> +	release_firmware(cs40l50->wmfw);
> +}
> +
> +static void cs40l50_upload_patch(const struct firmware *wmfw, void *context)
> +{
> +	struct cs40l50_private *cs40l50 = context;
> +
> +	cs40l50->wmfw = wmfw;
> +
> +	if (request_firmware_nowait(THIS_MODULE, FW_ACTION_UEVENT, CS40L50_WT,
> +				    cs40l50->dev, GFP_KERNEL,
> +				    cs40l50, cs40l50_upload_wt))
> +		release_firmware(cs40l50->wmfw);
> +}
> +
> +static int cs40l50_input_init(struct cs40l50_private *cs40l50)
> +{
> +	int error;
> +
> +	cs40l50->input = devm_input_allocate_device(cs40l50->dev);
> +	if (!cs40l50->input)
> +		return -ENOMEM;
> +
> +	cs40l50->input->id.product = cs40l50->devid & 0xFFFF;
> +	cs40l50->input->id.version = cs40l50->revid;
> +	cs40l50->input->name = "cs40l50_vibra";
> +
> +	input_set_drvdata(cs40l50->input, cs40l50);
> +	input_set_capability(cs40l50->input, EV_FF, FF_PERIODIC);
> +	input_set_capability(cs40l50->input, EV_FF, FF_CUSTOM);
> +
> +	error = input_ff_create(cs40l50->input, FF_MAX_EFFECTS);
> +	if (error)
> +		return error;
> +
> +	cs40l50->input->ff->upload = cs40l50_add;
> +	cs40l50->input->ff->playback = cs40l50_playback;
> +	cs40l50->input->ff->erase = cs40l50_erase;
> +
> +	INIT_LIST_HEAD(&cs40l50->haptics.effect_head);
> +
> +	error = input_register_device(cs40l50->input);
> +	if (error)
> +		goto err_free_dev;
> +
> +	return cs40l50_cs_hap_init(cs40l50);
> +
> +err_free_dev:
> +	input_free_device(cs40l50->input);
> +	return error;
> +}
> +static int cs40l50_vibra_probe(struct platform_device *pdev)
> +{
> +	struct cs40l50_private *cs40l50 = dev_get_drvdata(pdev->dev.parent);
> +	int error;
> +
> +	error = cs40l50_input_init(cs40l50);
> +	if (error)
> +		return error;
> +
> +	error = cs40l50_hw_init(cs40l50);
> +	if (error)
> +		goto err_input;
> +
> +	error = cs40l50_cs_dsp_init(cs40l50);
> +	if (error)
> +		goto err_input;
> +
> +	error = request_firmware_nowait(THIS_MODULE, FW_ACTION_UEVENT,
> +					CS40L50_FW, cs40l50->dev,
> +					GFP_KERNEL, cs40l50,
> +					cs40l50_upload_patch);
> +	if (error)
> +		goto err_dsp;
> +
> +	return 0;
> +
> +err_dsp:
> +	cs_dsp_remove(&cs40l50->dsp);
> +err_input:
> +	input_unregister_device(cs40l50->input);
> +	cs_hap_remove(&cs40l50->haptics);
> +
> +	return error;
> +}
> +
> +static int cs40l50_vibra_remove(struct platform_device *pdev)
> +{
> +	struct cs40l50_private *cs40l50 = dev_get_drvdata(pdev->dev.parent);
> +
> +	input_unregister_device(cs40l50->input);
> +	cs_hap_remove(&cs40l50->haptics);
> +
> +	if (cs40l50->dsp.booted)
> +		cs_dsp_power_down(&cs40l50->dsp);
> +	if (&cs40l50->dsp)
> +		cs_dsp_remove(&cs40l50->dsp);
> +
> +	return 0;
> +}
> +
> +static const struct platform_device_id cs40l50_id_vibra[] = {
> +	{"cs40l50-vibra", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(platform, cs40l50_id_vibra);
> +
> +static struct platform_driver cs40l50_vibra_driver = {
> +	.probe		= cs40l50_vibra_probe,
> +	.remove		= cs40l50_vibra_remove,
> +	.id_table	= cs40l50_id_vibra,
> +	.driver		= {
> +		.name	= "cs40l50-vibra",
> +	},
> +};
> +module_platform_driver(cs40l50_vibra_driver);
> +
> +MODULE_DESCRIPTION("CS40L50 Advanced Haptic Driver");
> +MODULE_AUTHOR("James Ogletree, Cirrus Logic Inc. <james.ogletree@cirrus.com>");
> +MODULE_LICENSE("GPL");
> -- 
> 2.25.1
> 

Kind regards,
Jeff LaBundy
