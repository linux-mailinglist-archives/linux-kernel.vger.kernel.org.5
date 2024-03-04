Return-Path: <linux-kernel+bounces-90988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CE6870811
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2E3D281C0A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6906026A;
	Mon,  4 Mar 2024 17:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NETORG5796793.onmicrosoft.com header.i=@NETORG5796793.onmicrosoft.com header.b="dddfvvjE"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2133.outbound.protection.outlook.com [40.107.92.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EFFA20;
	Mon,  4 Mar 2024 17:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709572257; cv=fail; b=ouv/T+yRRulVat3yIHSMnBgqQJcGwF9obDdTv3IzR5mxtVEnKPWYDAIQ59gYo3Z1Aiz0l/DEZBbfTT7qRCWeYT6ZMXePvGPhzuL/G6nXSku+X+9ev6IfQrd2YYj26wP31gVV+3dXwq5nOVkeCo9hY70AIKYEnCR/n7mrwoZ8Stg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709572257; c=relaxed/simple;
	bh=lJERAtN4ismitWE/tEeepbqIzcO1XXoa373C9fzSSsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VW/e7V8+AOBBYYYhFRiNtgXNL73t8wVFuGNhdIX6YHG4GNabYxtaQCoybXj2Kh0TK0z/5wWzsF0Wk1c49I1bOdb8jxvicqXnktlR8jJ5MeBG8wHMUjqkmrfHpogro0zbOKo3wY1mPGG87v4/xl1Dcpz+F3UCxysLkXX1Q6AqstE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=labundy.com; spf=pass smtp.mailfrom=labundy.com; dkim=pass (1024-bit key) header.d=NETORG5796793.onmicrosoft.com header.i=@NETORG5796793.onmicrosoft.com header.b=dddfvvjE; arc=fail smtp.client-ip=40.107.92.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=labundy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=labundy.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZA+3sllJRnOgkFu7v+ZF0LB3sa9CxM7/FbZU48crV5h9INjw1Yp2t0qc+yWVcuytXM/QVm7OslHUVq9X2wnW/laRSBVizKCBw89UZI6G7cdi7pCXFRW7YNVWx6OtKl2gTtI9YoNKac+OBlCQor8/oiiV22Rv2KTcnYFpum6zU+3tNHeq9EU9auHMr/+4uVKnuU2r1FWjBxkJ4Gbs4QcUVYgthYwDAZOavGw0fj9GIvyfsua4B3OJJbkDyzCANyTNH8advAFj6EYmtt6gJc9FNrTl1Uq5ixRyuO6UwhuToktcaFwxn3fIdZACwSbytF0DBH5xfeUi8RnxtiiXEfHDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/qGZzwEVMEG5FwF51InbRWM0aU2uMucDhZH3+fMVuec=;
 b=Ssv6SwS0YWOcF5/5H9/Ss1PXt2dNySJYqpwefALV59ufZH7G9CDCd9jz0MWw/37qyLXnAJylg932nTx05A0MBBN8G+9ob2v2bgPHgGoOIN14sMOSKYi1ltRwgvQsgEj32i48rbuPFHLpNWzeHAYM533ucuQEeg4rwRRKe15pHJTa0Xrc6yCPBfWSEOMrXVisAhXVkyscVcQMmbiBPMiOVRfUWRuko897nwr3DYuUDaebXCnsUOprTosOymYTqbSIjc9hPj1hMGpacdHHDdI+voV5n3jzuvVt88KrF/04S/XpEonA8xd5ZrkXbZ+CRRAHMOeYPPYnrYAwa10v0/jEZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/qGZzwEVMEG5FwF51InbRWM0aU2uMucDhZH3+fMVuec=;
 b=dddfvvjEpcPyUTpgt67Y6m6wSMx7TTYxE5ZC6UCDTDQjkvhBeLGJ8Uq5+S2T8Nkm+5+W8J/k8mzWlwLFEkP7bA2j5tHZTnmrBiwy8urFd5ww/Kr1r6cCphaJ8xNNy6QvPIDM7rhSHyWGibDOCe4DSEa/Uex2ZmddnohocRcvRmg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by SA1PR08MB6992.namprd08.prod.outlook.com
 (2603:10b6:806:189::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Mon, 4 Mar
 2024 17:10:51 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::bea5:3186:8a9f:52a]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::bea5:3186:8a9f:52a%7]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 17:10:51 +0000
Date: Mon, 4 Mar 2024 11:10:43 -0600
From: Jeff LaBundy <jeff@labundy.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Mattijs Korpershoek <mkorpershoek@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	ye xingchen <ye.xingchen@zte.com.cn>,
	LKML <linux-kernel@vger.kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2] Input: iqs269a - Use scope-based resource management
 in iqs269_parse_chan()
Message-ID: <ZeYAk830OUpaup5W@nixie71>
References: <6bf9f962-cf75-459d-89f4-2546063fc154@web.de>
 <ZeT6UUFNq1ujMW17@google.com>
 <b5f9c66e-d9c8-4dc6-8ce5-8d1dc5f0782d@web.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b5f9c66e-d9c8-4dc6-8ce5-8d1dc5f0782d@web.de>
X-ClientProxiedBy: SA9PR13CA0110.namprd13.prod.outlook.com
 (2603:10b6:806:24::25) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|SA1PR08MB6992:EE_
X-MS-Office365-Filtering-Correlation-Id: 3db44b02-aa3e-47a2-038d-08dc3c6e0b3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WNgLMLYmQZusAlQi7VrRtN7meDrUrx5TR/r5LFbqiu5l+RFt3uhRYmAJOsSYvgxn3C9EOOBw5TFONAwP+A2yJzFsQaRpr7ZuB0Ow1wF3RtJdTLh1r33EHQA+f6S4vxQakbqzunsSMoTAMMB2gUEJ5PbKwSULTTTpt3rbNgyKiATIdmmJG6csfULpq4J0kpbxnXOqHwliR6qYscXpzCHoVactyXA0bwBHq0uK2VLNydeFnppvIi8iAtwJpFSPD9sRgqo0q0UCHppgn+o38FECWrHvW41j7MzvGqGLi60Lh3CWOaLMwoN/X9460JxoRH7yGWfLY7BZCZspLfltCSdwN43RzH+BhpBE4vqaGvbftL6SOeW/2+ERd1ryojX8YByUbKu4WLeH4gc+YNCQYRf/Hr+CltQCWfkTDgGum8ypQKhUn7cNKBAJ7RYDCKveYrUCCN81sV8+pGcNrJ48OyixmzEV1HuvzkSsYYNyTYd7BaZjv8wef1Pqmr7YT4O9mooCVf8oXlKQLdHnvFwjHx1gD2dHtc534h3TmFLL2VFhBRJ1Tx+Hlhbe/eV8i2Qh39EQcEMPZRWiVQO76FmbInpb+Wa4c0k0jhZqG6r/h5j8Ocw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2g5VWJWZzZpaWY0SXExVXNnaVZDOXVTdWhHSHhHMDJnZUdWNjVsTkRxUTRY?=
 =?utf-8?B?dlk4eWF1UDIwVmNYZ2FkUFlpc3AzRWhJT0JDYmdlZlNnaDFFem9BTHJHbTRs?=
 =?utf-8?B?OXdRSXlwcncwMnJTY3AvTEV2VzRUYVJoZ1h1N3ZjQUtNYXNNVjVhcy8wSlZT?=
 =?utf-8?B?VFU5MVNxQ3RpRTk2bWw3QzJQaVVhS2tsUmFwSmZrLzA5ZFJLMVF5dzFHdDkw?=
 =?utf-8?B?dEFMMWV3dDYyM2NLVmpGOU0ybzJOWHFsNjRiTnF0elVXMWdWZ3lKQmlMNVZF?=
 =?utf-8?B?MUllQU94a3dZNkpXdEpsdWFDbUdjUC9zanZWZTB5aDA4dGpJbjAySG5oWmlw?=
 =?utf-8?B?UWQvVEt1VHJ5cGkwbjZPVHpXQ1M4S0d4aXZIb3RsUkRoYkdOMC83WVJtYTZ1?=
 =?utf-8?B?dW1iUjlaM1VjM2FXMFZnVnZyc2F6T3ZtekJ3SmQranc5VU8va0NVL2xyanh3?=
 =?utf-8?B?Q2tGcVNIT1h4UzJjbXNhSVdPRUp1aW5KNUFhYmxuaGRyUzMveWRlYVRnR0tu?=
 =?utf-8?B?WnZDQ0xZbVpBWGQ2dDhKZjRCRDBYd01RREY5NUNhaE5vdkpqREN2VGV1OGlP?=
 =?utf-8?B?SFNSUk9vL0s1QXhGM3JVNWRreGoyTUNrWDdPVXNKM01uVFVYSDhyMHRFQjBX?=
 =?utf-8?B?QUhyOUdCMGUxb3RpRWN5U2MwSU1mZzJ1WngxRkZ3dWYzQjZoSmJQVWdOdWlx?=
 =?utf-8?B?bm1nb0h3U0REa242dEljVk0wL2lzTG1KaXVRTEp6SW5udkZNV3J5U3IrK2Iz?=
 =?utf-8?B?Z0toaS9hR1FUU3RYLzJ3bFhwanVFZlN1SDJnLzZHSjVDbldHZlJhRmVjOFlJ?=
 =?utf-8?B?VGwxUG5SQmRhRUFkUTdSemR0VGJnaEFLQVRHWjhFRXpyYXVEQVphQXF2ZmNT?=
 =?utf-8?B?NEovZ3BDbTIramN0OTFCUHhXQzFhMlladW90eXc5MktIVHJtVEZYQTl6WVJK?=
 =?utf-8?B?SDJEcnMzbklvU2lVdnRwM2dUWFdpdUhycHEwNXlXZ3d1c0R6MXQ5SHhDcHZG?=
 =?utf-8?B?bUNSTlArNWZUWTFwbi9ubGpXOVN2Ni9vd2dyYWZLV2hZNy9zQVlkYXVGRnZv?=
 =?utf-8?B?NS9oeUxQblJzbnAvQmJVQXdwT3ZwOEhWdnB3eVZSTTNsanFteGtYS283ZWpq?=
 =?utf-8?B?NlVFNzExYkRRelBkQmtOLzVkclludmllQ3dWazVLU29xU0RhWHIybjBhWjRH?=
 =?utf-8?B?RnZLVVM3M3RGT09wckZhYVBSYit1L0JEMkdWUGFyRVViNnBhUlhyRmxpR2Fv?=
 =?utf-8?B?b0dZTXFXSGUxMndRSE5ldkxTTGh6QjNwM2dlWWZ4NEw2K2JiSjBwNmhCbVJB?=
 =?utf-8?B?KzJNa2lmVm5uWEc0RmxaWjVnTThhQ21WL2tSSHo3akg5WStVa2xXb0JSR1M2?=
 =?utf-8?B?UTNtaURZellWOHBpb0VLZEpxNU9RbVNFVzBoaHU0bzZ2THBtNElFUHcyN3Rj?=
 =?utf-8?B?QStiRWdmdzJDNTJINzNkQTEwUlFVV0VXNTdSaWZaMVlVS1pHU01ZZ2ZRT1gr?=
 =?utf-8?B?QkpFT2J0VUsrWTdGSVpSVGZqQ3hGcWhrMzdqNURFaVRUemZ1VkNNRFdrQmdw?=
 =?utf-8?B?RHJtZUFpVXZ1L3c3ZkxpUGtNbGJES0ppZFBsZnN1UmMwQlZ6WFNOcWV0Z1pR?=
 =?utf-8?B?WnJhNk5PTG9ZeUNmdDJWZzg5citBdEFMd2plNndJMnZyeGt6bU12eWExa3Iz?=
 =?utf-8?B?Y2JqcmRoYTJSSFgrT2tHc1ZSNUppczE5VmZ0MmJRT0Rua09WU1NrQ1pNSndB?=
 =?utf-8?B?U3JPRnk1c1VGZG5OTWg0WTFvWVhIdjQxVzcwc0ZlWWdJZCs5VjByTjA5a2Mr?=
 =?utf-8?B?MFFDOWFGT0dYaTArckJJNDJGUXhRNnBVb25mS3BJK2VHbjgwNGlTTVdRSDdI?=
 =?utf-8?B?d0tyWTlqaGdlazR4WGZCbHkzTFdQSlZnYUlGeUpxeHVTbnpVOUxqRmN3U2No?=
 =?utf-8?B?VHpuMnE1SWVZUWtRUzV5SEdhZHc2TWxjQVRlK2NOKzVvTDVSWElYUmtpalNm?=
 =?utf-8?B?STM3eHFmamo5clZhUHJnbi9BVVI4TzgzS29FMG5wVEgwVkwweUd0Z0JMRlNt?=
 =?utf-8?B?VnVJSHA3WXRodk9tY25IR0ZkNUM4VUVnSVlIUnQxRk5wKzRVU0wxZ1ZZcHMy?=
 =?utf-8?Q?u4IDvHkVfTW61j/4HR0noZ0qw?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db44b02-aa3e-47a2-038d-08dc3c6e0b3a
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 17:10:51.4291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bS0f1YA1RdEsS4ZqiPdfQb6oeQpLCxmDdSBUOP1r/29k74xg2tKmq+B0gEceUmEI4zkxfe+Iym/Jt+7wAKUs4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR08MB6992

Hi Markus,

On Mon, Mar 04, 2024 at 10:55:11AM +0100, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 4 Mar 2024 10:30:52 +0100
> 
> Scope-based resource management became supported also for this software
> area by contributions of Jonathan Cameron on 2024-02-17.
> 
> device property: Add cleanup.h based fwnode_handle_put() scope based cleanup.
> https://lore.kernel.org/r/20240217164249.921878-3-jic23@kernel.org
> 
> 
> * Thus use the attribute “__free(fwnode_handle)”.
> 
> * Reduce the scope for the local variable “ev_node” into a for loop.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
> 
> v2:
> An other cleanup technique was applied as requested by Dmitry Torokhov.
> 
> 
>  drivers/input/misc/iqs269a.c | 73 ++++++++++++++++++------------------
>  1 file changed, 37 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/input/misc/iqs269a.c b/drivers/input/misc/iqs269a.c
> index cd14ff9f57cf..9caee936927b 100644
> --- a/drivers/input/misc/iqs269a.c
> +++ b/drivers/input/misc/iqs269a.c
> @@ -557,7 +557,6 @@ static int iqs269_parse_chan(struct iqs269_private *iqs269,
>  			     const struct fwnode_handle *ch_node)
>  {
>  	struct i2c_client *client = iqs269->client;
> -	struct fwnode_handle *ev_node;
>  	struct iqs269_ch_reg *ch_reg;
>  	u16 engine_a, engine_b;
>  	unsigned int reg, val;
> @@ -734,47 +733,49 @@ static int iqs269_parse_chan(struct iqs269_private *iqs269,
>  	}
> 
>  	for (i = 0; i < ARRAY_SIZE(iqs269_events); i++) {
> -		ev_node = fwnode_get_named_child_node(ch_node,
> -						      iqs269_events[i].name);
> -		if (!ev_node)
> -			continue;
> -
> -		if (!fwnode_property_read_u32(ev_node, "azoteq,thresh", &val)) {
> -			if (val > IQS269_CHx_THRESH_MAX) {
> -				dev_err(&client->dev,
> -					"Invalid channel %u threshold: %u\n",
> -					reg, val);
> -				fwnode_handle_put(ev_node);
> -				return -EINVAL;
> +		{
> +			struct fwnode_handle *ev_node __free(fwnode_handle)
> +						      = fwnode_get_named_child_node(ch_node,
> +										    iqs269_events[i].name);
> +
> +			if (!ev_node)
> +				continue;
> +
> +			if (!fwnode_property_read_u32(ev_node, "azoteq,thresh", &val)) {
> +				if (val > IQS269_CHx_THRESH_MAX) {
> +					dev_err(&client->dev,
> +						"Invalid channel %u threshold: %u\n",
> +						reg, val);
> +					return -EINVAL;
> +				}
> +
> +				ch_reg->thresh[iqs269_events[i].th_offs] = val;

I may just be a curmudgeon, but this is another NAK for me. The dummy
curly braces and extra indentation make the code difficult to understand,
and this simply does not seem like a natural way to write a driver. Just
to remove 2-3 calls to fwnode_handle_put()?

>  			}
> 
> -			ch_reg->thresh[iqs269_events[i].th_offs] = val;
> -		}
> -
> -		if (!fwnode_property_read_u32(ev_node, "azoteq,hyst", &val)) {
> -			u8 *hyst = &ch_reg->hyst;
> -
> -			if (val > IQS269_CHx_HYST_MAX) {
> -				dev_err(&client->dev,
> -					"Invalid channel %u hysteresis: %u\n",
> -					reg, val);
> -				fwnode_handle_put(ev_node);
> -				return -EINVAL;
> +			if (!fwnode_property_read_u32(ev_node, "azoteq,hyst", &val)) {
> +				u8 *hyst = &ch_reg->hyst;
> +
> +				if (val > IQS269_CHx_HYST_MAX) {
> +					dev_err(&client->dev,
> +						"Invalid channel %u hysteresis: %u\n",
> +						reg, val);
> +					return -EINVAL;
> +				}
> +
> +				if (i == IQS269_EVENT_DEEP_DN ||
> +				    i == IQS269_EVENT_DEEP_UP) {
> +					*hyst &= ~IQS269_CHx_HYST_DEEP_MASK;
> +					*hyst |= (val << IQS269_CHx_HYST_DEEP_SHIFT);
> +				} else if (i == IQS269_EVENT_TOUCH_DN ||
> +					   i == IQS269_EVENT_TOUCH_UP) {
> +					*hyst &= ~IQS269_CHx_HYST_TOUCH_MASK;
> +					*hyst |= val;
> +				}
>  			}
> 
> -			if (i == IQS269_EVENT_DEEP_DN ||
> -			    i == IQS269_EVENT_DEEP_UP) {
> -				*hyst &= ~IQS269_CHx_HYST_DEEP_MASK;
> -				*hyst |= (val << IQS269_CHx_HYST_DEEP_SHIFT);
> -			} else if (i == IQS269_EVENT_TOUCH_DN ||
> -				   i == IQS269_EVENT_TOUCH_UP) {
> -				*hyst &= ~IQS269_CHx_HYST_TOUCH_MASK;
> -				*hyst |= val;
> -			}
> +			error = fwnode_property_read_u32(ev_node, "linux,code", &val);
>  		}
> 
> -		error = fwnode_property_read_u32(ev_node, "linux,code", &val);
> -		fwnode_handle_put(ev_node);
>  		if (error == -EINVAL) {
>  			continue;
>  		} else if (error) {
> --
> 2.44.0
> 

Kind regards,
Jeff LaBundy

