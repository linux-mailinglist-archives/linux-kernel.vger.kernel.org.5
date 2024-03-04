Return-Path: <linux-kernel+bounces-90028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CF086F90F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 04:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FF0B1F2134F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 03:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C515D6127;
	Mon,  4 Mar 2024 03:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NETORG5796793.onmicrosoft.com header.i=@NETORG5796793.onmicrosoft.com header.b="JBWIzy/D"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2127.outbound.protection.outlook.com [40.107.102.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A6E4A3C;
	Mon,  4 Mar 2024 03:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709523750; cv=fail; b=FMMKqu7tO4zHJkS4mkXQxMysJQ11kQ11jFnfty9G5OKfAyt9JbieT9YpuedjGZQQ7xWc0uKifHtH+TEPAiMqPawxBetNyJUXOttECVmZZoAbrUaM8ITRAyMTOd+QodOTb0wS/rvE6AyShhd9Yl9tcQlXfbFRI9G0/MoM0VCRF9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709523750; c=relaxed/simple;
	bh=qX4FsUqCEIlvttVmK/YcWADf5sPuBst//S5n8vu4IrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AX5FQZ/IO4k9ilGaPCXH1RJ14TsjWfvwd94UWPd8DucD2CT60hnEfFKMbyIBU1qUgmiB66LCupn/m2GzgxOLYMO5ESCmAHAq24Cj03QsNOJccrlaKzHHuLLcLALQWcaZWTW/ABElP16pR2dwBr95ZEbKs7ev+gStkCuTSPGsC8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=labundy.com; spf=pass smtp.mailfrom=labundy.com; dkim=pass (1024-bit key) header.d=NETORG5796793.onmicrosoft.com header.i=@NETORG5796793.onmicrosoft.com header.b=JBWIzy/D; arc=fail smtp.client-ip=40.107.102.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=labundy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=labundy.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hEbVYUwMBgVTjSetOis/d7lic548vY1FToTQJXC5VZGj7jQfpldk5YyzZkHSqmoBchTeSZAS8RnNywCl+T+4X6v+GKmrMoYJT0K5Hz1vdPhuZ2Q0zP3hcD7chNF9D9+67Td0/5lNL4HXhrWAGI9StEXi0ypDDJ+pNccMJdrp6PJwnshazavGdXKVVEiU/JLtv1D8emmVaIMg4il8m05a8uAK7nSiyQAOYKbq+yAg1n4e43bfsa9bQgCraTavx5GatclIFbWwnQDg2JB+xMekcC/oBaPQ2+lwGTBSekl78Nd1wMt5nckTY99/zyzIySOfSkcLnVTH1raGQGuq4NpyEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uCluiekG3ZyRzr7j2lSBa2W8iU5vZZvvqn8fMIBTRj8=;
 b=igjhLOEx0Zj0hDTDVsMNI/T9s8qw6CyJsBwJ5fmPDXs5MqUE2g/D7HcSNi2nMkIzYIjuvLMJUCJhbC6PkQMhlabMJg406a1dtOM94cZd9zH70duxKNHZKcsHt18psD3k+mnnPnE6v860ANuEsXtjviUgSjSXsySZndQaY4cVOul5nkj33jUzRlite1u86ft3jhGrekkAnarZlpDdowdqApxoJcsBrfNCar8pPvFmU9y+HT+LF0Qerp9UwO9rQZPNhbv9kIk2GBC//R8gnS0ODRnKNDOsPYvaHnC7OVS99Vjzo8MbzpW5ZkduPXGH//ODSvotVQL75R+Cor2g0NopnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uCluiekG3ZyRzr7j2lSBa2W8iU5vZZvvqn8fMIBTRj8=;
 b=JBWIzy/DSdlyh6Se9fwGVsXfKP/aZ81yP20HghkOuhLG2PCI/WsjgaMz7Bl1CvX32qVa1QpJ0hA3Jk5Sc++G0jPLVlyL9HUVeUslPNINuuhXyyR/wdOd+lBIC7pL6T3o2KmNisQYi/oOGTH3YdxdjcktGvIP0eMFCUsSEVc/qDo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by PH0PR08MB8186.namprd08.prod.outlook.com
 (2603:10b6:510:172::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 03:42:23 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::bea5:3186:8a9f:52a]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::bea5:3186:8a9f:52a%7]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 03:42:23 +0000
Date: Sun, 3 Mar 2024 21:42:20 -0600
From: Jeff LaBundy <jeff@labundy.com>
To: Javier Carrasco <javier.carrasco@wolfvision.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Henrik Rydberg <rydberg@bitmath.org>,
	Bastian Hecht <hechtb@gmail.com>,
	Michael Riesch <michael.riesch@wolfvision.net>,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v7 2/4] Input: touch-overlay - Add touchscreen overlay
 handling
Message-ID: <ZeVDHP7PiVbAoE5b@nixie71>
References: <20240119-feature-ts_virtobj_patch-v7-0-eda70985808f@wolfvision.net>
 <20240119-feature-ts_virtobj_patch-v7-2-eda70985808f@wolfvision.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119-feature-ts_virtobj_patch-v7-2-eda70985808f@wolfvision.net>
X-ClientProxiedBy: SN4PR0501CA0099.namprd05.prod.outlook.com
 (2603:10b6:803:42::16) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|PH0PR08MB8186:EE_
X-MS-Office365-Filtering-Correlation-Id: 07db0344-8161-43e5-3a41-08dc3bfd19ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bFgYuayOob8bbZraGXod1OUa9MPUldGLHbUHbFq5hZaq2+m+qIdsjQwTS3ExPrMVgcSm7dyx9srSeB4Kgwma12rKXzxNVYEdGPbtLvS1zBC2XuVlS2hvB6Ls+6jdFrEDm+6CmdhCvp9lcSxZD1+crzt/wBo9HvPrR2hh5IT8UgLFaGZzgCcM+ayhftMC+4QYnr/ZEsE2uXQ7qdQNQrYxM88dAM/wLrTRF+vidtrEMph/fmTAcHPWnhrbl+gFA/BpCHzngCiX3ZgbPQbJWygm9O1BIn5dCQiGLFWaVoKSmJJJ/Ld4nmOX3bok8PS80/A7Fv1/ZzaBk4+5V9IQYMmX3ks4A/N4MroQyAnOJMu3dUL6Dxt7p+O+MOP8fFOL2HPcd7zC4qHntINR8CuHKHyBj26qN/YW5RQ4LqGehDlMi4An9CldlbBpWiaObq1kYFN0XQ3OvNcXoKjkd5uGTgy3Jy2jX2Bqa6WTqspwwBzueE62B4nDkanWLkEdYY2PNjpBTZXLbGUagstFLEe2Qu8/7lNqii5aVEzSwbxRDEGKFOKz4x1M6rzxEhxWQ2JlPd4CTI30xxUCB3u8DhlWzRMeQ2A09LpG4hVFIaliupOEgHEnGU0BwTGQlklLphKfw3ZcXpns6SZXhnVUADoW1AvHe79Mbz2Zr8JBv1rytc8vVc4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XN7bpPOlXwg4R3VVDc3qkbh+5uzCx6EjKKsX1XmQkYZO3ua4oDIJTjk+/d9K?=
 =?us-ascii?Q?RBUQR9wBp6sdtyNLUvJofiOpxY1B6kM150DEO45uBaNojk1bN9ZyXtAmY9mL?=
 =?us-ascii?Q?+kaeNO6l2Txy6DvRuBiA+8eCqcMIqEn8d684BS1o03V0RN9K7+oMPSuLpRr5?=
 =?us-ascii?Q?uWy/qRJxH1PG5jCOATfUQvIv57So6ZPb0EslZQmDlN3bHu+g94D0zq8rGVAo?=
 =?us-ascii?Q?Z6lADxpi9cehEGcuXzLAc9Y6pPMfwbcanC88uk2nEnLTVviNBsQ5993x5a7w?=
 =?us-ascii?Q?AwX7O756A3nmuOCavh0Pazp/W0K1a+mgctDEFYXM4gOF6zhD5DxRQwIpe9ea?=
 =?us-ascii?Q?xoL5RkXfpsjRZMzfy7FS98oMbfTxMgwFY/u+jI2mtKx9F3sEum7xQqPy4VGj?=
 =?us-ascii?Q?tvo6QlaWo0iVeb+Iyc+yVGL1c/+yc4XoXbzsVTh5eOpzhXCegUT8WswKz7uq?=
 =?us-ascii?Q?mvR9zhjvHtK22kNWaQInhjh/LVdAC1ItFs3+OUhF6gVSipQA/c545CITmMOm?=
 =?us-ascii?Q?4UGvaZASqFGYmY66gmNzBOiGhOkeKoae8Lj9nA/FgKq5k4ib0hNb1olChUqn?=
 =?us-ascii?Q?R0IRzrQ56CbOEaUoJRUs9frJue4ScXZXtlxjdaHtmVAQ4EhESJHEZLe172Qj?=
 =?us-ascii?Q?JnTta7XOxJVVOcKf7IZXtd+cb/t7+9N/J0XOEqAMFavX8rDq+ODOF9S/3olw?=
 =?us-ascii?Q?mDicDd4gnX+jEM2M3gIBUsSsgfPV4jBdoc32S63Yp+SU7vQabbADDwDi41AH?=
 =?us-ascii?Q?LEdbtg5r6Zxotdm6P88bhxRqkITzaZ5QhMevpZ3tKC5VEpIKQ3KSw2Xxtsd8?=
 =?us-ascii?Q?/BEywf35AgpT8M9U6ZV+jYRn4BrmzGxkN+2gwoSnVJxfQa3rRwWMwobFV3Jw?=
 =?us-ascii?Q?FjRFHEt44Hn92MqoQBi1bUaLuybkfOhVecYKQi8/lT20m6QatoILw/+misb/?=
 =?us-ascii?Q?ZXPS1uRj/Zv6suGF+UphQlgoMVSPaFZ/VKnoqU4T5Dkdc2pFvqMd7a3u04pw?=
 =?us-ascii?Q?vWfQqIEzAM+rCVROYbIyBYvUXlvWlbNjNpK5OVOGWoHS5bIqAwqJUdlrB4hc?=
 =?us-ascii?Q?xN/KZH6QCyV7r5c/AIKrHPtAfKJJJ2DBJvajabgsJKWRJ2fDijCZcTdthIRj?=
 =?us-ascii?Q?Zyw7dL+/8yicnXOvPn6TDVIZtCgbkTaoOrbcXKzVBuSjLhxpZryZJmx3ZGLP?=
 =?us-ascii?Q?udUGXk9GV2FK7qubOeklhvlMxC3iV5jNvK+GOBCYla/63zo2oNWYymseeJD/?=
 =?us-ascii?Q?1QsdS9kBWKzSzHEVjoS903InEOm6tZtx+Tvc7S++j2d5Fl12Cpoi6dsSu1Ti?=
 =?us-ascii?Q?iKQoGf60hQFTf66XDj42GjBpiR9SW0RADjPeSbQ+uGjgMu8EgO0ermALmhVN?=
 =?us-ascii?Q?jRCplvZHgKb28/O8iWIeuZAHMr/K1iU1RNfA0VrZ+5zTMW8hG9rIY58FPGu2?=
 =?us-ascii?Q?CRAVmyucwKkftXedmtIi3As9pEnomR/yiX/KoBNp9p8U1SiVXXinyKjaPwA5?=
 =?us-ascii?Q?4QCOFKJTddd6RXe73UZDjR124vJg1M9xTEqF81/AzCmw4H03MjFmfragDIQ8?=
 =?us-ascii?Q?vTylEG7DLK4lYzEoNm0oHk7NFrxjjqxRXsMeJhIU?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07db0344-8161-43e5-3a41-08dc3bfd19ff
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 03:42:23.0475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ysvVTu1q1wulpZerb7GwlvhkRUuCaYDIi/2H+AYgkWByhHheSr9bJF6FF7pbAAHtCTK9jD0S8lB18/Tf6oi5hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR08MB8186

Hi Javier,

On Fri, Jan 19, 2024 at 08:43:34AM +0100, Javier Carrasco wrote:
> Some touch devices provide mechanical overlays with different objects
> like buttons or clipped touchscreen surfaces.
> 
> In order to support these objects, add a series of helper functions
> to the input subsystem to transform them into overlay objects via
> device tree nodes.
> 
> These overlay objects consume the raw touch events and report the
> expected input events depending on the object properties.
> 
> Note that the current implementation allows for multiple definitions
> of touchscreen areas (regions that report touch events), but only the
> first one will be used for the touchscreen device that the consumers
> typically provide.
> Should the need for multiple touchscreen areas arise, additional
> touchscreen devices would be required at the consumer side.
> There is no limitation in the number of touch areas defined as buttons.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>

Apologies for the delay, but I think this looks great now. It can always
be extended later in case another touchscreen driver needs additional
functionality or visibility. You've addressed all of my feedback, and so:

Reviewed-by: Jeff LaBundy <jeff@labundy.com>

> ---
>  MAINTAINERS                         |   7 +
>  drivers/input/Makefile              |   2 +-
>  drivers/input/touch-overlay.c       | 250 ++++++++++++++++++++++++++++++++++++
>  include/linux/input/touch-overlay.h |  22 ++++
>  4 files changed, 280 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a7c4cf8201e0..668687bf94df 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21961,6 +21961,13 @@ L:	platform-driver-x86@vger.kernel.org
>  S:	Maintained
>  F:	drivers/platform/x86/toshiba-wmi.c
>  
> +TOUCH OVERLAY
> +M:	Javier Carrasco <javier.carrasco@wolfvision.net>
> +L:	linux-input@vger.kernel.org
> +S:	Maintained
> +F:	drivers/input/touch-overlay.c
> +F:	include/linux/input/touch-overlay.h
> +
>  TPM DEVICE DRIVER
>  M:	Peter Huewe <peterhuewe@gmx.de>
>  M:	Jarkko Sakkinen <jarkko@kernel.org>
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
> index 000000000000..42b6ad753a00
> --- /dev/null
> +++ b/drivers/input/touch-overlay.c
> @@ -0,0 +1,250 @@
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
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/property.h>
> +
> +struct touch_overlay_segment {
> +	struct list_head list;
> +	u32 x_origin;
> +	u32 y_origin;
> +	u32 x_size;
> +	u32 y_size;
> +	u32 key;
> +	bool pressed;
> +	int slot;
> +};
> +
> +static int touch_overlay_get_segment(struct fwnode_handle *segment_node,
> +				     struct touch_overlay_segment *segment,
> +				     struct input_dev *input)
> +{
> +	int error;
> +
> +	error = fwnode_property_read_u32(segment_node, "x-origin",
> +					 &segment->x_origin);
> +	if (error)
> +		return error;
> +
> +	error = fwnode_property_read_u32(segment_node, "y-origin",
> +					 &segment->y_origin);
> +	if (error)
> +		return error;
> +
> +	error = fwnode_property_read_u32(segment_node, "x-size",
> +					 &segment->x_size);
> +	if (error)
> +		return error;
> +
> +	error = fwnode_property_read_u32(segment_node, "y-size",
> +					 &segment->y_size);
> +	if (error)
> +		return error;
> +
> +	error = fwnode_property_read_u32(segment_node, "linux,code",
> +					 &segment->key);
> +	if (!error)
> +		input_set_capability(input, EV_KEY, segment->key);
> +	else if (error != -EINVAL)
> +		return error;
> +
> +	return 0;
> +}
> +
> +/**
> + * touch_overlay_map - map overlay objects from the device tree and set
> + * key capabilities if buttons are defined.
> + * @list: pointer to the list that will hold the segments
> + * @input: pointer to the already allocated input_dev
> + *
> + * Returns 0 on success and error number otherwise.
> + *
> + * If buttons are defined, key capabilities are set accordingly.
> + */
> +int touch_overlay_map(struct list_head *list, struct input_dev *input)
> +{
> +	struct fwnode_handle *overlay, *fw_segment;
> +	struct device *dev = input->dev.parent;
> +	struct touch_overlay_segment *segment;
> +	int error;
> +
> +	overlay = device_get_named_child_node(dev, "touch-overlay");
> +	if (!overlay)
> +		return 0;
> +
> +	fwnode_for_each_child_node(overlay, fw_segment) {
> +		segment = devm_kzalloc(dev, sizeof(*segment), GFP_KERNEL);
> +		if (!segment) {
> +			error = -ENOMEM;
> +			fwnode_handle_put(overlay);
> +			break;
> +		}
> +		error = touch_overlay_get_segment(fw_segment, segment, input);
> +		if (error) {
> +			fwnode_handle_put(overlay);
> +			break;
> +		}
> +		list_add_tail(&segment->list, list);
> +	}
> +
> +	return error;
> +}
> +EXPORT_SYMBOL(touch_overlay_map);
> +
> +/**
> + * touch_overlay_get_touchscreen_abs - get abs size from the touchscreen area.
> + * @list: pointer to the list that holds the segments
> + * @x: horizontal abs
> + * @y: vertical abs
> + */
> +void touch_overlay_get_touchscreen_abs(struct list_head *list, u16 *x, u16 *y)
> +{
> +	struct touch_overlay_segment *segment;
> +	struct list_head *ptr;
> +
> +	list_for_each(ptr, list) {
> +		segment = list_entry(ptr, struct touch_overlay_segment, list);
> +		if (!segment->key) {
> +			*x = segment->x_size - 1;
> +			*y = segment->y_size - 1;
> +			break;
> +		}
> +	}
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
> + * touch_overlay_mapped_touchscreen - check if a touchscreen area is mapped
> + * @list: pointer to the list that holds the segments
> + *
> + * Returns true if a touchscreen area is mapped or false otherwise.
> + */
> +bool touch_overlay_mapped_touchscreen(struct list_head *list)
> +{
> +	struct touch_overlay_segment *segment;
> +	struct list_head *ptr;
> +
> +	list_for_each(ptr, list) {
> +		segment = list_entry(ptr, struct touch_overlay_segment, list);
> +		if (!segment->key)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +EXPORT_SYMBOL(touch_overlay_mapped_touchscreen);
> +
> +static bool touch_overlay_event_on_ts(struct list_head *list, u32 *x, u32 *y)
> +{
> +	struct touch_overlay_segment *segment;
> +	struct list_head *ptr;
> +	bool valid_touch = true;
> +
> +	if (!x || !y)
> +		return false;
> +
> +	list_for_each(ptr, list) {
> +		segment = list_entry(ptr, struct touch_overlay_segment, list);
> +		if (segment->key)
> +			continue;
> +
> +		if (touch_overlay_segment_event(segment, *x, *y)) {
> +			*x -= segment->x_origin;
> +			*y -= segment->y_origin;
> +			return true;
> +		}
> +		/* ignore touch events outside the defined area */
> +		valid_touch = false;
> +	}
> +
> +	return valid_touch;
> +}
> +
> +static bool touch_overlay_button_event(struct input_dev *input,
> +				       struct touch_overlay_segment *segment,
> +				       const u32 *x, const u32 *y, u32 slot)
> +{
> +	bool contact = x && y;
> +
> +	if (!contact && segment->pressed && segment->slot == slot) {
> +		segment->pressed = false;
> +		input_report_key(input, segment->key, false);
> +		input_sync(input);
> +		return true;
> +	} else if (contact && touch_overlay_segment_event(segment, *x, *y)) {
> +		segment->pressed = true;
> +		segment->slot = slot;
> +		input_report_key(input, segment->key, true);
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
> + * touchscreen area, if defined.
> + * @list: pointer to the list that holds the segments
> + * @input: pointer to the input device associated to the event
> + * @x: pointer to the x coordinate (NULL if not available - no contact)
> + * @y: pointer to the y coordinate (NULL if not available - no contact)
> + * @slot: slot associated to the event
> + *
> + * Returns true if the event was processed (reported for valid key events
> + * and dropped for events outside the overlay touchscreen area) or false
> + * if the event must be processed by the caller. In that case this function
> + * shifts the (x,y) coordinates to the overlay touchscreen axis if required.
> + */
> +bool touch_overlay_process_event(struct list_head *list,
> +				 struct input_dev *input,
> +				 u32 *x, u32 *y, u32 slot)
> +{
> +	struct touch_overlay_segment *segment;
> +	struct list_head *ptr;
> +
> +	/*
> +	 * buttons must be prioritized over overlay touchscreens to account for
> +	 * overlappings e.g. a button inside the touchscreen area.
> +	 */
> +	list_for_each(ptr, list) {
> +		segment = list_entry(ptr, struct touch_overlay_segment, list);
> +		if (segment->key &&
> +		    touch_overlay_button_event(input, segment, x, y, slot)) {
> +			return true;
> +		}
> +	}
> +
> +	/*
> +	 * valid touch events on the overlay touchscreen are left for the client
> +	 * to be processed/reported according to its (possibly) unique features.
> +	 */
> +	return !touch_overlay_event_on_ts(list, x, y);
> +}
> +EXPORT_SYMBOL(touch_overlay_process_event);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Helper functions for overlay objects on touch devices");
> diff --git a/include/linux/input/touch-overlay.h b/include/linux/input/touch-overlay.h
> new file mode 100644
> index 000000000000..cef05c46000d
> --- /dev/null
> +++ b/include/linux/input/touch-overlay.h
> @@ -0,0 +1,22 @@
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
> +
> +int touch_overlay_map(struct list_head *list, struct input_dev *input);
> +
> +void touch_overlay_get_touchscreen_abs(struct list_head *list, u16 *x, u16 *y);
> +
> +bool touch_overlay_mapped_touchscreen(struct list_head *list);
> +
> +bool touch_overlay_process_event(struct list_head *list, struct input_dev *input,
> +				 u32 *x, u32 *y, u32 slot);
> +
> +#endif
> 
> -- 
> 2.39.2
> 

Kind regards,
Jeff LaBundy

