Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0867D856E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 17:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345343AbjJZPBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 11:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345305AbjJZPBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 11:01:09 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB3D187;
        Thu, 26 Oct 2023 08:01:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLScpXPdx7KoYJ3Kl+Nh44EmS5zOETNWTz/AUWPxmzav25mttW/Hnq64c3OUXXZk1WFv+ensmP/uAHHAyIJ7Adtg8PeDfzMLm9lP86+k0t7bF/ec1kciANeSiF9jJCqO2/ZT6K3Myce5D+58lWyxLlTBkgqYtNzIZm0FxhspkrbLDP4bPJYnq8mB8hhpGS/LDeo45YyaWzdH8JRgqOV1SuRqlL3+ZEZdZcAeEMPZF3AUPW3g4Y7UcuaRh68GX5O/ueH2EhWryhU/fbmTapnTNBm2fFp5Pc/qYe1hzOgRi5sKbefcI7nAa1U/n5k9rt+CSu5lah+E0dkvCNWBGnYT8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gOTs7KKpqy4bUrMgXfu80u0eFe0eOcMcnrPTaYztF/c=;
 b=Lu/OLtx28S0OpkNu3vJ1dJPjYEw2tB29llkFGS/c1drZKSRnYqXP9PhHgtTm372E8LV2xNDwE7M3s4FkNTQewE8w38qIckLMvGZG6i3q+z9PFQ4RNggIzKSLMJzKTjMLKv86+YOPxCxO0bTpXX1Sl4s3MM6TCG8l7rHiKfiNYOYaH2guugP5btP0KQ/NjVDkG9oru6/fOlC6GpX0GWyKZ9ejaSoCjUEjZo1b7pVSYuzwE9+mDamspeF0QMRdzV+z01BXDibWWn+Dht1a1iaJa4X9YKFqKQkax8eHU3CJ0cu95LZ6eg0ZPOmc6NH8rI9G5KcOez9KawAoNxfA88M33g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gOTs7KKpqy4bUrMgXfu80u0eFe0eOcMcnrPTaYztF/c=;
 b=EnLe8UAP7rvnlennYUNQh2QKpcjcYuHholA8gxGvg7jqzdkuR7kpBp2Ilm+tkJNXoKvmfPZfDWsuMFk88TohBFJAMQDIANb2HjT83fV0bCX9NWjVVaITpcI0mgBW8J3imdLCceBk3zkmT4RK+xNzswBvKsGZi/SpuzaQWh8mlPA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by DM8PR08MB7381.namprd08.prod.outlook.com
 (2603:10b6:8:12::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Thu, 26 Oct
 2023 15:01:01 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::e73c:270b:75f7:5302]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::e73c:270b:75f7:5302%4]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 15:01:00 +0000
Date:   Thu, 26 Oct 2023 10:00:54 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Javier Carrasco <javier.carrasco@wolfvision.net>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Bastian Hecht <hechtb@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 1/4] Input: touch-overlay - Add touchscreen overlay
 object handling
Message-ID: <ZTp/JiriX4b3oIsP@nixie71>
References: <20230510-feature-ts_virtobj_patch-v5-0-ff6b5c4db693@wolfvision.net>
 <20230510-feature-ts_virtobj_patch-v5-1-ff6b5c4db693@wolfvision.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510-feature-ts_virtobj_patch-v5-1-ff6b5c4db693@wolfvision.net>
X-ClientProxiedBy: SN7PR18CA0020.namprd18.prod.outlook.com
 (2603:10b6:806:f3::14) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|DM8PR08MB7381:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ec0745b-ee92-45d1-a55e-08dbd6345de8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PdE+CdxgQxnw90+qDpu2wy2f+IxCSY3qTzd31eC4ReEh+OnlxXiDRS1Z19luipfEV/RAcFEs6cDHmYUJX2aA+wMImw+90SGFjmHhfBBh4KcR/K6NeIZ0zJZQDbiAldoMqXXuIC2BF9S0Xv70nUQ13lg/bc1hi2zO/kS6fkGNmqgm/kZILG/NEnWKyeFRi/ojw9abt9D8im4edmrAXXd+JYyudYmqdSa3DJobaqHW/eGTu0w80AF9KSIKwa8VHn2A0Mj9EWa47UomwNTEIrMCx9hGc3iy5Pxe2ljFyJy6Mqh2MEGrDn0qfg+3EYyovZtWWWJPG1s+/WQyVfEnZsx+p0nEn6+OmR9KlhT8h9kD/jOA3hNVoXTbhGjFOrGWpnRFVkOfj/jmAsd5XGhJpp4aE470MdK3u8ZraTysdJ2YPgKhXM7BHBzBhqFCX4BHlEEvrBYt7n3Eg1IO6hWZjk/3kOna8cMg/Ey8tpN6c6EgX0SIExwrlshLuLupwKUwi5Pze5a+h3o1mvSTrN6CXKLYuOFBySw4TxPVp8k/QeIQl5w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(39830400003)(376002)(136003)(396003)(346002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(38100700002)(83380400001)(6506007)(9686003)(6666004)(6512007)(33716001)(66946007)(54906003)(966005)(6486002)(26005)(478600001)(316002)(66476007)(66556008)(6916009)(8676002)(8936002)(4326008)(5660300002)(41300700001)(7416002)(2906002)(30864003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5V5LAFyC/IMbJ9n3ZSTYLd8Y+ugz7pryXBAtCgqj/8O8sc0VvOEE0Tz7NDnp?=
 =?us-ascii?Q?/QRbEq21KnZT01zJibJ0V1QdEcEVWWviA1n3t87cVmxpNVRQNvxp/3cFFLh8?=
 =?us-ascii?Q?wNR5dgegY1SNqEaW0pvFYTu/kFFv4zWGqZZ4sLJrXbzDFcACEoUB41wTla0n?=
 =?us-ascii?Q?puUCDu5vUFVjnUsb1cFlhbGFWIGwoHt9Xrheg2Rh0F8j2fKsKJSR0pStfJGf?=
 =?us-ascii?Q?+KmMX/7ainx05hA3WX7KzWS884s0zdwy+sSeLjqSb7ciDru5A2zFaxdSN91u?=
 =?us-ascii?Q?AfUDocKNsF/a0gkzflhssTtFY3bXQA3vhbHZhdkkAwlIoJAPQY53Ha2mMzfk?=
 =?us-ascii?Q?pDu0zdFKGA3GDJqDB9dyFhbFWw+2u87geZaQ34WvH9hVFclsZj9XEjJ95lDO?=
 =?us-ascii?Q?NySXOM+dYAvF+rSzvFGRstwWI7YyWYwTPItN+k8JlJ/qqpgFahpQak8EJ3y9?=
 =?us-ascii?Q?Wm0+qAjwX5t5ybV1RO7uNbpTRKfGpOejfdZgSoycTDwC6Dyo7MA/mpDV/WiW?=
 =?us-ascii?Q?fuYNAUzZZ7A7EvuWGQ1EuhESxAbqgBR3mUmoGB4uLpF9iQeXZi4ok0LqFDPF?=
 =?us-ascii?Q?f+J61EHTXbELK2/oJG+rQZgp2Xt/awEKOQ4Ko3mfvGdWoK/D3RRPfAfqu3gV?=
 =?us-ascii?Q?N5xO/CD45qwaGmGEGVq01TaliY08Ou/X120yypaAclnDAq86E1sdJcMl92kq?=
 =?us-ascii?Q?R9oJ1LtVQahTsM4BsXMVwgj8pQwWZ+v+WjrvpmUf6b//aTPPAfoa6Maq2BUz?=
 =?us-ascii?Q?8paWxgVmIb2jKBGUapfO+KNPPV9eLxrgz2geXILPmPH4m0rrClSP5qUJQBry?=
 =?us-ascii?Q?QiAR7+u8tXsVDL5jX2743YR+XGmUL9iRY6ckVBDChZMkyfka/s+PptDaMfRp?=
 =?us-ascii?Q?AdPKQeiIDfx/qM6+XHfk2S60TgzbvXAfKqgdTHOkkLHHatp8uTtmhA1V4mBt?=
 =?us-ascii?Q?MPtJguJ8THkurna2iW/MgGbTpsxrnFCYtLDvZfqLLxeMKX8DpdicfMGnTwcb?=
 =?us-ascii?Q?LyuSKdX6e1qjQcdsKfxOPmNufIGZDZWN8jv3OIgM76hu9KxFLIUbUmczEGTE?=
 =?us-ascii?Q?fV3TgX4RGxKd4B9dPwqUpmEYwO3qrWDKhkEN2weaU8mXoQdhRZcG8etKBSxA?=
 =?us-ascii?Q?Zxme3tAXHZqR3M3cMRjNAyeRZK63YLGhYU4kx5RTqVbD9aYn87k2zVDW5Le/?=
 =?us-ascii?Q?48p8e/0uya9u3vUCnajwOGPipLjVcvJP2lOGy7h+kc5PMrQSq7DD6ftaVDOn?=
 =?us-ascii?Q?ktR8megeqXJucl5JQcYnzDBI89vpXKLasniQrI8GxGmVpLyGK5/83G73t7ZX?=
 =?us-ascii?Q?TuyWiLDn9uFX1JczkRSYLNSY1FtaboQjhpqCRCcGiI90+LfhMoM4VC/sNk4V?=
 =?us-ascii?Q?T9pOfF8prDCTArx58GxeFnJcXXQJGqW4NP3sD4vkuhpsC1ekpzNOXhVNo5At?=
 =?us-ascii?Q?8ukSAy/GnwIQTx4kEpELW/R/Z7uDlHHtdShQKONItO0Mv+b5Ap6y8UJyP16R?=
 =?us-ascii?Q?gWuwb2V7MP7iT9DRD0L9v7j299t794iudAxdUyzFs5ULIvoydVGZoFKz1qJs?=
 =?us-ascii?Q?rMYFMpTfdVM3CbpTjHOtMhUJ5uxmBPBODjEYUYxA?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ec0745b-ee92-45d1-a55e-08dbd6345de8
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 15:01:00.7018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1KWYoaZco4aeKJi2Gr5bIt0zerW5FNC2urmzZKxggyYYo9VwBppwttoWPhjpqhadhFTSe+kXYgjMywcQAeONeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR08MB7381
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

Just a few minor comments in addition to my over-arching question in
patch [2/4].

On Tue, Oct 17, 2023 at 01:00:07PM +0200, Javier Carrasco wrote:
> Some touch devices provide mechanical overlays with different objects
> like buttons or clipped touchscreen surfaces.
> 
> In order to support these objects, add a series of helper functions
> to the input subsystem to transform them into overlay objects via
> device tree nodes.
> 
> These overlay objects consume the raw touch events and report the
> expected input events depending on the object properties.

Normally binding patches precede the code that parses the corresponding
properties, so that the documentation is in the tree by the time the
code is applied.

Typically this only matters for compatible strings, since checkpatch
may complain about undocumented compatible strings when applying a
driver whose binding is not yet merged. That's obviously not the case
here, but I would say let's swap patches 1/2 and 3/4 for consistency.

> 
> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
> ---
>  MAINTAINERS                         |   7 +
>  drivers/input/Makefile              |   2 +-
>  drivers/input/touch-overlay.c       | 399 ++++++++++++++++++++++++++++++++++++
>  include/linux/input/touch-overlay.h |  34 +++
>  4 files changed, 441 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7a7bd8bd80e9..00c03824c3ac 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21884,6 +21884,13 @@ W:	https://github.com/srcres258/linux-doc
>  T:	git git://github.com/srcres258/linux-doc.git doc-zh-tw
>  F:	Documentation/translations/zh_TW/
>  
> +TOUCH OVERLAY OBJECTS
> +M:	Javier Carrasco <javier.carrasco@wolfvision.net>
> +L:	linux-input@vger.kernel.org
> +S:	Maintained
> +F:	drivers/input/touch-overlay.c
> +F:	include/linux/input/touch-overlay.h
> +
>  TTY LAYER AND SERIAL DRIVERS
>  M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>  M:	Jiri Slaby <jirislaby@kernel.org>
> diff --git a/drivers/input/Makefile b/drivers/input/Makefile
> index c78753274921..393e9f4d00dc 100644
> --- a/drivers/input/Makefile
> +++ b/drivers/input/Makefile
> @@ -7,7 +7,7 @@
>  
>  obj-$(CONFIG_INPUT)		+= input-core.o
>  input-core-y := input.o input-compat.o input-mt.o input-poller.o ff-core.o
> -input-core-y += touchscreen.o
> +input-core-y += touchscreen.o touch-overlay.o
>  
>  obj-$(CONFIG_INPUT_FF_MEMLESS)	+= ff-memless.o
>  obj-$(CONFIG_INPUT_SPARSEKMAP)	+= sparse-keymap.o
> diff --git a/drivers/input/touch-overlay.c b/drivers/input/touch-overlay.c
> new file mode 100644
> index 000000000000..007dbd994474
> --- /dev/null
> +++ b/drivers/input/touch-overlay.c
> @@ -0,0 +1,399 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + *  Helper functions for overlay objects on touchscreens
> + *
> + *  Copyright (c) 2023 Javier Carrasco <javier.carrasco@wolfvision.net>
> + */
> +
> +#include <linux/input.h>
> +#include <linux/input/mt.h>
> +#include <linux/input/touch-overlay.h>
> +#include <linux/module.h>
> +#include <linux/property.h>
> +
> +enum touch_overlay_valid_objects {
> +	TOUCH_OVERLAY_TS,
> +	TOUCH_OVERLAY_BTN,
> +};
> +
> +static const char *const object_names[] = {
> +	[TOUCH_OVERLAY_TS] = "overlay-touchscreen",
> +	[TOUCH_OVERLAY_BTN] = "overlay-buttons",
> +};
> +
> +struct touch_overlay_segment {
> +	u32 x_origin;
> +	u32 y_origin;
> +	u32 x_size;
> +	u32 y_size;
> +};
> +
> +struct touch_overlay_button {
> +	struct touch_overlay_segment segment;
> +	u32 key;
> +	bool pressed;
> +	int slot;
> +};
> +
> +static int touch_overlay_get_segment_props(struct fwnode_handle *segment_node,
> +					   struct touch_overlay_segment *segment)
> +{
> +	int error;
> +
> +	error = fwnode_property_read_u32(segment_node, "x-origin",
> +					 &segment->x_origin);
> +	if (error < 0)

It is sufficient, and much more common in input, to write this as 'if (error)'
as the only nonzero return values are negative anyway.

> +		return error;
> +
> +	error = fwnode_property_read_u32(segment_node, "y-origin",
> +					 &segment->y_origin);
> +	if (error < 0)
> +		return error;
> +
> +	error = fwnode_property_read_u32(segment_node, "x-size",
> +					 &segment->x_size);
> +	if (error < 0)
> +		return error;
> +
> +	error = fwnode_property_read_u32(segment_node, "y-size",
> +					 &segment->y_size);
> +	if (error < 0)
> +		return error;
> +
> +	return 0;
> +}
> +
> +static int
> +touch_overlay_get_button_properties(struct device *dev,
> +				    struct fwnode_handle *overlay_node,
> +				    struct touch_overlay_button *btn)
> +{
> +	struct fwnode_handle *btn_node;
> +	int error;
> +	int j = 0;
> +
> +	fwnode_for_each_child_node(overlay_node, btn_node) {
> +		error = touch_overlay_get_segment_props(btn_node,
> +							&btn[j].segment);
> +		if (error < 0)
> +			goto button_put;
> +
> +		error = fwnode_property_read_u32(btn_node, "linux,code",
> +						 &btn[j].key);
> +		if (error < 0)
> +			goto button_put;
> +
> +		dev_dbg(dev, "Added button at (%u, %u), size %ux%u, code=%u\n",
> +			btn[j].segment.x_origin, btn[j].segment.y_origin,
> +			btn[j].segment.x_size, btn[j].segment.y_size, btn[j].key);
> +		j++;
> +	}
> +
> +	return 0;
> +
> +button_put:
> +	fwnode_handle_put(btn_node);
> +	return error;
> +}
> +
> +static void touch_overlay_set_button_caps(struct touch_overlay_map *map,
> +					  struct input_dev *dev)
> +{
> +	int i;
> +
> +	for (i = 0; i < map->button_count; i++)
> +		input_set_capability(dev, EV_KEY, map->buttons[i].key);
> +}
> +
> +static int touch_overlay_count_buttons(struct device *dev)
> +{
> +	struct fwnode_handle *overlay;
> +	struct fwnode_handle *button;
> +	int count = 0;
> +
> +	overlay = device_get_named_child_node(dev,
> +					      object_names[TOUCH_OVERLAY_BTN]);
> +	if (!overlay)
> +		return 0;
> +
> +	fwnode_for_each_child_node(overlay, button)
> +		count++;
> +	fwnode_handle_put(overlay);
> +
> +	return count;
> +}
> +
> +static int touch_overlay_map_touchscreen(struct device *dev,
> +					 struct touch_overlay_map *map)
> +{
> +	struct fwnode_handle *ts_node;
> +	int error = 0;
> +
> +	ts_node = device_get_named_child_node(dev,
> +					      object_names[TOUCH_OVERLAY_TS]);
> +	if (!ts_node)
> +		return 0;
> +
> +	map->touchscreen =
> +		devm_kzalloc(dev, sizeof(*map->touchscreen), GFP_KERNEL);

This line break was a bit confusing to read; the choice of line break in
touch_overlay_map_buttons() is much more clear.

> +	if (!map->touchscreen) {
> +		error = -ENOMEM;
> +		goto handle_put;
> +	}
> +	error = touch_overlay_get_segment_props(ts_node, map->touchscreen);
> +	if (error < 0)
> +		goto handle_put;
> +
> +	map->overlay_touchscreen = true;
> +	dev_dbg(dev, "Added overlay touchscreen at (%u, %u), size %u x %u\n",
> +		map->touchscreen->x_origin, map->touchscreen->y_origin,
> +		map->touchscreen->x_size, map->touchscreen->y_size);
> +
> +handle_put:
> +	fwnode_handle_put(ts_node);
> +
> +	return error;
> +}
> +
> +static int touch_overlay_map_buttons(struct device *dev,
> +				     struct touch_overlay_map *map)
> +{
> +	struct fwnode_handle *button;
> +	u32 count;
> +	int error = 0;
> +
> +	count = touch_overlay_count_buttons(dev);
> +	if (!count)
> +		return 0;
> +
> +	map->buttons = devm_kcalloc(dev, count,
> +				    sizeof(*map->buttons), GFP_KERNEL);
> +	if (!map->buttons) {
> +		error = -ENOMEM;
> +		goto map_buttons_ret;
> +	}
> +	button = device_get_named_child_node(dev,
> +					     object_names[TOUCH_OVERLAY_BTN]);
> +	if (unlikely(!button)) {
> +		error = -ENODEV;
> +		goto map_buttons_ret;
> +	}
> +
> +	error = touch_overlay_get_button_properties(dev, button,
> +						    map->buttons);
> +
> +	if (error < 0)
> +		goto map_buttons_put;
> +
> +	map->button_count = count;
> +
> +map_buttons_put:
> +	fwnode_handle_put(button);
> +map_buttons_ret:
> +	return error;
> +}
> +
> +static bool touch_overlay_defined_objects(struct device *dev)
> +{
> +	struct fwnode_handle *obj_node;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(object_names); i++) {
> +		obj_node = device_get_named_child_node(dev, object_names[i]);
> +		if (obj_node) {
> +			fwnode_handle_put(obj_node);
> +			return true;
> +		}
> +		fwnode_handle_put(obj_node);
> +	}
> +
> +	return false;
> +}
> +
> +/**
> + * touch_overlay_map_overlay - map overlay objects from the device tree and set
> + * key capabilities if buttons are defined.
> + * @keypad: pointer to the already allocated input_dev.
> + *
> + * Returns a pointer to the object mapping struct.
> + *
> + * If a keypad input device is provided and overlay buttons are defined,
> + * its button capabilities are set accordingly.
> + */
> +struct touch_overlay_map *touch_overlay_map_overlay(struct input_dev *keypad)
> +{
> +	struct device *dev = keypad->dev.parent;
> +	struct touch_overlay_map *map = NULL;
> +	int error;
> +
> +	if (!touch_overlay_defined_objects(dev))
> +		return NULL;
> +
> +	map = devm_kzalloc(dev, sizeof(*map), GFP_KERNEL);
> +	if (!map) {
> +		error = -ENOMEM;
> +		goto map_error;
> +	}
> +	error = touch_overlay_map_touchscreen(dev, map);
> +	if (error < 0)
> +		goto map_error;
> +
> +	error = touch_overlay_map_buttons(dev, map);
> +	if (error < 0)
> +		goto map_error;
> +
> +	touch_overlay_set_button_caps(map, keypad);
> +
> +	return map;
> +
> +map_error:
> +	return ERR_PTR(error);
> +}
> +EXPORT_SYMBOL(touch_overlay_map_overlay);
> +
> +/**
> + * touch_overlay_get_touchscreen_abs - get abs size from the overlay node
> + * @map: pointer to the struct that holds the object mapping
> + * @x: horizontal abs
> + * @y: vertical abs
> + *
> + */
> +void touch_overlay_get_touchscreen_abs(struct touch_overlay_map *map, u16 *x,
> +				       u16 *y)
> +{
> +	*x = map->touchscreen->x_size - 1;
> +	*y = map->touchscreen->y_size - 1;
> +}
> +EXPORT_SYMBOL(touch_overlay_get_touchscreen_abs);
> +
> +static bool touch_overlay_segment_event(struct touch_overlay_segment *seg,
> +					u32 x, u32 y)
> +{
> +	if (!seg)
> +		return false;
> +
> +	if (x >= seg->x_origin && x < (seg->x_origin + seg->x_size) &&
> +	    y >= seg->y_origin && y < (seg->y_origin + seg->y_size))
> +		return true;
> +
> +	return false;
> +}
> +
> +/**
> + * touch_overlay_mapped_touchscreen - check if an overlay touchscreen is mapped
> + * @map: pointer to the struct that holds the object mapping
> + *
> + * Returns true if an overlay touchscreen is mapped or false otherwise.
> + */
> +bool touch_overlay_mapped_touchscreen(struct touch_overlay_map *map)
> +{
> +	if (!map || !map->overlay_touchscreen)
> +		return false;
> +
> +	return true;
> +}
> +EXPORT_SYMBOL(touch_overlay_mapped_touchscreen);
> +
> +/**
> + * touch_overlay_mapped_buttons - check if overlay buttons are mapped
> + * @map: pointer to the struct that holds the object mapping
> + *
> + * Returns true if overlay buttons mapped or false otherwise.
> + */
> +bool touch_overlay_mapped_buttons(struct touch_overlay_map *map)
> +{
> +	if (!map || !map->button_count)
> +		return false;
> +
> +	return true;
> +}
> +EXPORT_SYMBOL(touch_overlay_mapped_buttons);
> +
> +static bool touch_overlay_mt_on_touchscreen(struct touch_overlay_map *map,
> +					    u32 *x, u32 *y)
> +{
> +	bool contact = x && y;
> +
> +	if (!touch_overlay_mapped_touchscreen(map))
> +		return true;
> +
> +	/* Let the caller handle events with no coordinates (release) */
> +	if (!contact)
> +		return false;
> +
> +	if (touch_overlay_segment_event(map->touchscreen, *x, *y)) {
> +		*x -= map->touchscreen->x_origin;
> +		*y -= map->touchscreen->y_origin;
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +static bool touch_overlay_button_event(struct input_dev *input,
> +				       struct touch_overlay_button *button,
> +				       const u32 *x, const u32 *y, u32 slot)
> +{
> +	bool contact = x && y;
> +
> +	if (!contact && button->pressed && button->slot == slot) {
> +		button->pressed = false;
> +		input_report_key(input, button->key, false);
> +		input_sync(input);
> +		return true;
> +	} else if (contact && touch_overlay_segment_event(&button->segment,
> +							  *x, *y)) {
> +		button->pressed = true;
> +		button->slot = slot;
> +		input_report_key(input, button->key, true);
> +		input_sync(input);
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +/**
> + * touch_overlay_process_event - process input events according to the overlay
> + * mapping. This function acts as a filter to release the calling driver from
> + * the events that are either related to overlay buttons or out of the overlay
> + * touchscreen area if defined.
> + * @map: pointer to the struct that holds the object mapping
> + * @input: pointer to the input device associated to the event
> + * @x: pointer to the x coordinate (NULL if not available - no contact)
> + * @y: pointer to the y coordinate (NULL if not available - no contact)
> + * @slot: slot associated to the event
> + *
> + * Returns true if the event was processed (reported for valid key events
> + * and dropped for events outside the overlay touchscreen area) or false
> + * if the event must be processed by the caller. In that case this function
> + * shifts the (x,y) coordinates to the overlay touchscreen axis if required
> + */
> +bool touch_overlay_process_event(struct touch_overlay_map *map,
> +				 struct input_dev *input,
> +				 u32 *x, u32 *y, u32 slot)
> +{
> +	int i;
> +
> +	if (!map)
> +		return false;
> +
> +	/* buttons must be prioritized over overlay touchscreens to account for
> +	 * overlappings e.g. a button inside the touchscreen area
> +	 */

Please refer to the kernel coding style guide regarding multi-line comments.

> +	if (touch_overlay_mapped_buttons(map)) {
> +		for (i = 0; i < map->button_count; i++) {
> +			if (touch_overlay_button_event(input, &map->buttons[i],
> +						       x, y, slot))
> +				return true;
> +		}
> +	}
> +	/* valid touch events on the overlay touchscreen are left for the client
> +	 * to be processed/reported according to its (possibly) unique features
> +	 */
> +	return !touch_overlay_mt_on_touchscreen(map, x, y);
> +}
> +EXPORT_SYMBOL(touch_overlay_process_event);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Helper functions for overlay objects on touch devices");
> diff --git a/include/linux/input/touch-overlay.h b/include/linux/input/touch-overlay.h
> new file mode 100644
> index 000000000000..3e0db813dc34
> --- /dev/null
> +++ b/include/linux/input/touch-overlay.h
> @@ -0,0 +1,34 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2023 Javier Carrasco <javier.carrasco@wolfvision.net>
> + */
> +
> +#ifndef _TOUCH_OVERLAY
> +#define _TOUCH_OVERLAY
> +
> +#include <linux/types.h>
> +
> +struct input_dev;
> +struct device;
> +
> +struct touch_overlay_map {
> +	struct touch_overlay_segment *touchscreen;
> +	bool overlay_touchscreen;
> +	struct touch_overlay_button *buttons;
> +	u32 button_count;
> +};
> +
> +struct touch_overlay_map *touch_overlay_map_overlay(struct input_dev *keypad);
> +
> +void touch_overlay_get_touchscreen_abs(struct touch_overlay_map *map,
> +				       u16 *x, u16 *y);
> +
> +bool touch_overlay_mapped_touchscreen(struct touch_overlay_map *map);
> +
> +bool touch_overlay_mapped_buttons(struct touch_overlay_map *map);
> +
> +bool touch_overlay_process_event(struct touch_overlay_map *map,
> +				 struct input_dev *input,
> +				 u32 *x, u32 *y, u32 slot);
> +
> +#endif
> 
> -- 
> 2.39.2
> 

Kind regards,
Jeff LaBundy
