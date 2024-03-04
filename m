Return-Path: <linux-kernel+bounces-90030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C67B86F913
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 04:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 501001C20A37
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 03:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC7D611B;
	Mon,  4 Mar 2024 03:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NETORG5796793.onmicrosoft.com header.i=@NETORG5796793.onmicrosoft.com header.b="oENTeYtL"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2111.outbound.protection.outlook.com [40.107.92.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC5C443D;
	Mon,  4 Mar 2024 03:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709523830; cv=fail; b=kHmwVaRkdZjXOYGPIblGjnnozuyvR8KDvTMXNdiBar7ylwDssu1m/C356pTl1mo2OXWGfCULsBm3xQR9NypRdsKcwDR/4WVcLq8t1c6TNvGOx1K24OrZi84CD+gbBcMWfx+bT/dQxHU8GGEOqTtHWjJrFXtRWDIXfex57PPW2gY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709523830; c=relaxed/simple;
	bh=+POXB9WYea5bXmXCZQUANGLiHs1SmZmIt4OrRwNGtfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ns3Ym7ePK8JE5OQFXgzL11Cng9dZicjwMuPcLyKsgwvtnQ92ExluqJu9nIOV3EmwJ8wlkQAEbDy/zQMuEsb82ErjEZEVSQowb+M6WjeZWDKiQV/EqQql5NgjYF7xHHXbkSW4d35XOeLtno/F4qfk0OQRX329S9c0CMK+rTZk6Zc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=labundy.com; spf=pass smtp.mailfrom=labundy.com; dkim=pass (1024-bit key) header.d=NETORG5796793.onmicrosoft.com header.i=@NETORG5796793.onmicrosoft.com header.b=oENTeYtL; arc=fail smtp.client-ip=40.107.92.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=labundy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=labundy.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=As767cN/ngxT13cRLI81AGju7tUHtKWKchNSMqfkXFBedCh+dUDbc9JOTQa5u15IyZU45YKP+1XPIeKvZXEC7XU98triATdofRGt1WpdoAGM2OMsa4I67ezkZNN2gOnmZnMum2QP73uEHjeZuxinMwXRbEeI5ZsSMsP3fMMe1UucNGSSqDFMlg+Mm0bPjPW53j7s6IivrvvNjoAvJn95EjxIILA0xVHABC7bMN1XHNq2DRuR57EI14IYvshthsyToF9z0idcM7R97+77fGiBf7GPrSEmmL0FwWqMy9NiFj7ZSxSoZWyUMc67Md0hQPiQm9/MVSRnY7sICPTLmXSqyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2fMnC6q3mbUTFvOjyaJHMZp7Ozz5Ousp+8u/kvlMt08=;
 b=mpRQs5aljfxlU9rfC/KXAYqw31pcBjOiWhyo3FXgjO27c6aN4bbaGvoEUo2wh9d+8GrQ8oBLFdUpysj4fSbc2Cuuys8QvxMAYYGQVqoXJHMQZ8iGUeKduVDbf7inuy1akEayx2rQ58WnhDQY/BHCXZ9y/re7m3ogvTb3PUm18NT32jK/g3tzDZKWAE7w0CliLYxT2cJUEK/xNgJUiynNwBoZKfs81lbfBSnEMtJ3rwS2Pn5e2xnHM4OiRPQtqGp9kkx6WvWF1hwzVBRsYjsuM2pXaX2YLAuIW5L+dTPmVGEkNxVHs+Z1mTIbOjg5CDkv6vPFlfbo2k4DrjwL3yApvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2fMnC6q3mbUTFvOjyaJHMZp7Ozz5Ousp+8u/kvlMt08=;
 b=oENTeYtLB+WW/owpo+qP3fXH8uoqpxHT98Ooh3zA29NAKVLLrANAM4Saxb1mb/OiqD7KMNedGcGlfdu+2miYwNOfryPO97ERyFy2prkda92nZoBvXTFYhECDk86sxgipBaCdCkr6umQzrC0mz+q5tZnwCFqGQdmQgonnw1/XD08=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by PH0PR08MB8186.namprd08.prod.outlook.com
 (2603:10b6:510:172::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 03:43:47 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::bea5:3186:8a9f:52a]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::bea5:3186:8a9f:52a%7]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 03:43:46 +0000
Date: Sun, 3 Mar 2024 21:43:43 -0600
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
Subject: Re: [PATCH v7 4/4] Input: st1232 - add touch overlays handling
Message-ID: <ZeVDb9COXkeOX3s6@nixie71>
References: <20240119-feature-ts_virtobj_patch-v7-0-eda70985808f@wolfvision.net>
 <20240119-feature-ts_virtobj_patch-v7-4-eda70985808f@wolfvision.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119-feature-ts_virtobj_patch-v7-4-eda70985808f@wolfvision.net>
X-ClientProxiedBy: SA0PR11CA0009.namprd11.prod.outlook.com
 (2603:10b6:806:d3::14) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|PH0PR08MB8186:EE_
X-MS-Office365-Filtering-Correlation-Id: ca521f05-4078-4366-54c2-08dc3bfd4be8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RcPziTrcH+A8vdg4EP5tPnnuxAAcln/snE9rlN65hlE0oXufym1njYVxcusRocbFsJMHQntqWtOTMKuzvyrEaOAbCZrpok6XAsm4rvetsoSqGzS/ypRW2151zIDXawAN6mu/CzV35weANs83ohxwRhHvG6HyAgerdbgN5QgNlQmhs8TVvCjyrDOOLwvgyI6/Y6l5XwJdI2n9RJZA+Ehm96M3x9XOh1szfSSIYLoozVDU7PdJ/BhNfPX2Qysugux/68o7nPuWer2K1VBEABrJWWXIPmDKDybuU9+34xueTP/ZeSX/KSlp4F3z0NwXC4qGTp2vxlzycJTzu/u4D2oUWYWRaMQFvNrPw4S4fIPq0IDsTHR3H7pd6iO5uxWe+bWxXfci8x21rtctOUneg7pHrhMd1c2HPfTZhpodERdpLHhg+tJ73b06C6prvnGZD7+gzzCCJhsRWC0j++b3kDR5GMUZTpu9zc9JD1p6kqouZxvOU3jISo66i7Cljg/iKSWnxMu4bA30K9PUM22/3IU/XLO8gOSEmRo39ouhAIzzJKdISrhcDdYA9E/ipCCZ6B/G+lMmD040jfbCBbMSZp1pCqbZnJIlSdu+g3wa6AbiqvTSpjRSJO7cRWXMaHjZUcsC8v+LIhVaH613V9WT8EZG2sZl1ulGAFO01qfCRSohljQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x79Ira+lCAZr05WK7m7ergNbT70W9oFMPT0vg6nqbJsrspXzCYL/Lj6WlQ50?=
 =?us-ascii?Q?5l+a0WvuTKqyTmy042XVmGwN7aziaN+gkA135LEbT/JZyeE4AGg09PY64Q/G?=
 =?us-ascii?Q?V7cBQFAWWg51hySeiEB6ExyVOGZ4GrVtrVJ4vQAVdhMvB/yA6P5ls1xvY+YV?=
 =?us-ascii?Q?tHUh5KOS0KwVLWIOhq0AUAtP1RomZapBwuEhf50f4TkYoto7Tf7isWwhuNK7?=
 =?us-ascii?Q?94toL34ZT19b4CJtbDZjZCEJhxRrhsKmYDsmxWcbBLK/QA82yI7YGNHA1FtO?=
 =?us-ascii?Q?Y5xGlCQE+9razNUaT6nMgtIWPsXdGjWVhBhtCYpQLLK7878iJ2YjdGb0Y8mw?=
 =?us-ascii?Q?xUzchn6Xiy5rVrzOuX2TJqTmvnkecWctugLKHMU3tPC1bBYYFU3aUmeo0o4b?=
 =?us-ascii?Q?bl/28lLbO2aFwdlSJKUeVlSG94rMLgyF+G/IHqWHjE+LTOGjVyeb/J8FV+Dg?=
 =?us-ascii?Q?9G4mALReycZHwZD+Iq/NBu0ZXmeg7RZf4pjWXjXB/7xQHXtO6w1epZk8gyTg?=
 =?us-ascii?Q?rs/+IKThByeTPmszRNzG/v024WT1u8sWu/Psx3tFD8eYmOW1Eg7nT6+Z5Izd?=
 =?us-ascii?Q?toxW3f1/Xo0wTOlp3fxsqlz5C0vw8fOiame+56iaQzuvRnguKtm6Z9yMvLrL?=
 =?us-ascii?Q?NUl8xMj1Qd2xzF4FhNtgCZabI5nBWLeGBQVmtUXX6Zeup7BvZxr24Myf4PLZ?=
 =?us-ascii?Q?PcgrZJuulXc8H0dDJQLBUlfE/ha84E4N6ySrMQD8j3EoHkqcCVRLmjANlr3m?=
 =?us-ascii?Q?Zr9ylbUIOV7tj4XPzJhjSpkEIFelVVXmmFNFOmPJ68KE6rzTeskxz0fvrO4g?=
 =?us-ascii?Q?x1IbUr497bbW8Zwvttdh1HtTbRCkk8JFLTafiE3TfWuYbFuIOes6EAHFfhiE?=
 =?us-ascii?Q?/2vlD24r8oYFW4BDJ4O+zhj+Gebrr0/YYspEEkKx1KrUUeSfmA/ankYlMKJT?=
 =?us-ascii?Q?QOAOH00YvCbFBz7G/Ltx6HG/N0IIBvPtdtcWUsSgLI8b5+OLWaoznAs8ogmh?=
 =?us-ascii?Q?ZHdfjvt3BYWEu6EeDxjI/vZy79HIeePJRudlv9IU4sAnX6RJzJiQ9bW9UVd4?=
 =?us-ascii?Q?4WICamC+CMuL0NNk8UmKH3ukgZ9PWJXb9Aji4i5dfwQ8XtUeomqHL+mWN6fG?=
 =?us-ascii?Q?VsTckS8q/ZEdpIqFpgJSlBuD6H9l+jy3FOfN7vb/eo0Y1+6H0UpdrYhHvxQo?=
 =?us-ascii?Q?ruPjDo12GHyCqo/bOrbFMBkZl9JlupsfWu+QApZJyBKFKjLIw7pSjHQEUTv8?=
 =?us-ascii?Q?RPf/LwtnucmGT6dNVnXI3koNCrYDAb+YCWRMPlTXlHqVcXv+zgczanGI4PGI?=
 =?us-ascii?Q?Hsq4lxIiPIcmL86/DDnJ9OHlS//FEGNRiIim2Vsfbv9oUbsMoov2noQLbHuU?=
 =?us-ascii?Q?56Iv4XORpDUGBC/Rt8RKvo2+KXBQ7ig4Mmh7Zac5KMJH69IHGEESn6c6wFfd?=
 =?us-ascii?Q?pTsu/ocApNWtfwGFQQRT5kUWvlzkcUfrCU9vd7+zx8AiZ7JzSPdDNWfJwAMC?=
 =?us-ascii?Q?ZciUUl5akx5sfJybRS8kIcWeUOTkxx7WjN8e1Of4mn17TrDfs2RoIotgweu7?=
 =?us-ascii?Q?jEaWyQDJZeKCmNmQ+ACtNI/mZcLFW3t/hFruVYfd?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca521f05-4078-4366-54c2-08dc3bfd4be8
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 03:43:46.6744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ivh0r4osg7WDMS4EovoMwR9cFHFrnePKRVhz0hSaaAgyZFPS0EA4aB0YXEYQcyj+tzAt+KuLLYx/7zh6CXTa6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR08MB8186

Hi Javier,

On Fri, Jan 19, 2024 at 08:43:36AM +0100, Javier Carrasco wrote:
> Use touch-overlay to support overlay objects such as buttons and a resized
> frame defined in the device tree.
> 
> If buttons are provided, register an additional device to report key
> events separately. A key event will be generated if the coordinates
> of a touch event are within the area defined by the button properties.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>

Reviewed-by: Jeff LaBundy <jeff@labundy.com>

> ---
>  drivers/input/touchscreen/st1232.c | 48 +++++++++++++++++++++++++++-----------
>  1 file changed, 34 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/st1232.c b/drivers/input/touchscreen/st1232.c
> index 6475084aee1b..4fa31447dbc1 100644
> --- a/drivers/input/touchscreen/st1232.c
> +++ b/drivers/input/touchscreen/st1232.c
> @@ -22,6 +22,7 @@
>  #include <linux/pm_qos.h>
>  #include <linux/slab.h>
>  #include <linux/types.h>
> +#include <linux/input/touch-overlay.h>
>  
>  #define ST1232_TS_NAME	"st1232-ts"
>  #define ST1633_TS_NAME	"st1633-ts"
> @@ -57,6 +58,7 @@ struct st1232_ts_data {
>  	struct dev_pm_qos_request low_latency_req;
>  	struct gpio_desc *reset_gpio;
>  	const struct st_chip_info *chip_info;
> +	struct list_head touch_overlay_list;
>  	int read_buf_len;
>  	u8 *read_buf;
>  };
> @@ -138,14 +140,20 @@ static int st1232_ts_parse_and_report(struct st1232_ts_data *ts)
>  
>  	for (i = 0; i < ts->chip_info->max_fingers; i++) {
>  		u8 *buf = &ts->read_buf[i * 4];
> +		bool contact = buf[0] & BIT(7);
> +		unsigned int x, y;
>  
> -		if (buf[0] & BIT(7)) {
> -			unsigned int x = ((buf[0] & 0x70) << 4) | buf[1];
> -			unsigned int y = ((buf[0] & 0x07) << 8) | buf[2];
> -
> -			touchscreen_set_mt_pos(&pos[n_contacts],
> -					       &ts->prop, x, y);
> +		if (contact) {
> +			x = ((buf[0] & 0x70) << 4) | buf[1];
> +			y = ((buf[0] & 0x07) << 8) | buf[2];
> +		}
> +		if (touch_overlay_process_event(&ts->touch_overlay_list, input,
> +						contact ? &x : NULL,
> +						contact ? &y : NULL, i))
> +			continue;
>  
> +		if (contact) {
> +			touchscreen_set_mt_pos(&pos[n_contacts], &ts->prop, x, y);
>  			/* st1232 includes a z-axis / touch strength */
>  			if (ts->chip_info->have_z)
>  				z[n_contacts] = ts->read_buf[i + 6];
> @@ -292,18 +300,30 @@ static int st1232_ts_probe(struct i2c_client *client)
>  	if (error)
>  		return error;
>  
> -	/* Read resolution from the chip */
> -	error = st1232_ts_read_resolution(ts, &max_x, &max_y);
> -	if (error) {
> -		dev_err(&client->dev,
> -			"Failed to read resolution: %d\n", error);
> -		return error;
> -	}
> -
>  	if (ts->chip_info->have_z)
>  		input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0,
>  				     ts->chip_info->max_area, 0, 0);
>  
> +	/* map overlay objects if defined in the device tree */
> +	INIT_LIST_HEAD(&ts->touch_overlay_list);
> +	error = touch_overlay_map(&ts->touch_overlay_list, input_dev);
> +	if (error)
> +		return error;
> +
> +	if (touch_overlay_mapped_touchscreen(&ts->touch_overlay_list)) {
> +		/* Read resolution from the overlay touchscreen if defined */
> +		touch_overlay_get_touchscreen_abs(&ts->touch_overlay_list,
> +						  &max_x, &max_y);
> +	} else {
> +		/* Read resolution from the chip */
> +		error = st1232_ts_read_resolution(ts, &max_x, &max_y);
> +		if (error) {
> +			dev_err(&client->dev,
> +				"Failed to read resolution: %d\n", error);
> +			return error;
> +		}
> +	}
> +
>  	input_set_abs_params(input_dev, ABS_MT_POSITION_X,
>  			     0, max_x, 0, 0);
>  	input_set_abs_params(input_dev, ABS_MT_POSITION_Y,
> 
> -- 
> 2.39.2
> 

Kind regards,
Jeff LaBundy

