Return-Path: <linux-kernel+bounces-71437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DD985A53B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10CB0282754
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B9536B11;
	Mon, 19 Feb 2024 13:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ZOipif1k"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2073.outbound.protection.outlook.com [40.107.6.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425D9374C3;
	Mon, 19 Feb 2024 13:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708351187; cv=fail; b=dijWPXSj+aPLsZnF3cemV8V/ziBsW5cynLlWz8PvRzKq2C/7JxpZoPrgRF9BVcrJAQszf7vM8vQtc4SGVoyjxjtupQK6vbA34P47ovtvbKioix38NPNyPYsBD+pI0K/VEwRxMBdmMs6LFqqx4egGh2tyFiJ6qBKUc+cEIDOTZQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708351187; c=relaxed/simple;
	bh=T8zxGzM3jJ1NodtXle8/0vgqdoKUhDbfPo1SpBobQtA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Mga3x+/XA3tntGo0xyBStnzU1kr/QrLRZzGF2HZ1/WML8G3ZROFdD/tzhwyTLLtP1N9zbrT9wnhC3+S66Z6ZSSA+HcNhxeCHAVbd9kdTx+VEpWIUf4IZZ1YnrgV52LBg0CsZv77tQ9LkokBlqxoU5x6hP9vrF7kyNAWDQdSIGeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ZOipif1k; arc=fail smtp.client-ip=40.107.6.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAIgc0hmv+er5EpIWmzw2kjo6W+z83wwI75YRonLmq9BwHM9zoyk5ITtm9NVhFXkAGjjj+YsjNpt4Tw0sOd7RidNumESG+Z+QLMHRm4X9GtBcGCOl1qFc26XVLM6vAMSm9UUjdPg8HuK7tYuvpCnZT1cJaA7f9pla+WZxdtauqtCEGrhjJT3U1imivn8IKGBqi+s/d51bvkq0uXl41PsiisA1nRzcKIEZgYG8Fn1Wvp3zXqSEW53KUXR9ZomjxdYIWPE62qG+ZGBG+acXF0ToC4k+c/zNaogzPg9/UGeNN8ITf03JC4U1yO3MwE8uK6UzDE9Z458WFN02iOl74B1aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RYnDCssN4Zi6vP5HepxiIzakeuV9i6mvJWwGLkJVHNQ=;
 b=lPUBjFxH4ktUUH64PmP2bo8Lb+h4Qus86fqwjx2MqmR2SqUWNUtfmEJsKKQJlD+aU2WkxQRB2OKKfKqoQ9aAY/4OYqSbln9kn1i1YkmSt6xLLtiATTRliqcrJP6JEMeIaL2mHg/UppTcGHJ6Bt9bMuepYB2nUTPtsJWZrcZWPoN/uXnbCth/dvYtwgEwGq7JB5IFZ+k+ljf95xL5+xJ6R3iueoj6c5Wf3C0/Bnh61AyEqOAE6CHYJ6Gf1gi4TJKSmm7fCU4nGQctCodyquXgqzsFzNhXJyasbhPeDU0O+2Xwi4QUHftnrFuOEakw4EmxYj5To19VgFsOuMJT97rajg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYnDCssN4Zi6vP5HepxiIzakeuV9i6mvJWwGLkJVHNQ=;
 b=ZOipif1ks+pIdn9zDFa0IvomE3S4njXtNIn1Drwr2WKjaynJvLH0dBPaDKGy2Rifw+yu+Gx7egSNMBgYTAjII3SKRr4h6qEjO15l3zDhR+U2wypSGclnwEVsQEgApgq9n0t1sJbIAzwLlZtCFJ7JYD5fozvDxuxBo91M9p43K3U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9244.eurprd04.prod.outlook.com (2603:10a6:20b:4e3::9)
 by PAXPR04MB8094.eurprd04.prod.outlook.com (2603:10a6:102:1c1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Mon, 19 Feb
 2024 13:59:41 +0000
Received: from AS4PR04MB9244.eurprd04.prod.outlook.com
 ([fe80::9775:2346:d709:7d4c]) by AS4PR04MB9244.eurprd04.prod.outlook.com
 ([fe80::9775:2346:d709:7d4c%5]) with mapi id 15.20.7292.029; Mon, 19 Feb 2024
 13:59:41 +0000
Message-ID: <ed209781-78ed-45f5-8266-eb0376a559a3@oss.nxp.com>
Date: Mon, 19 Feb 2024 15:59:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: imx-jpeg: Support for negotiating bytesperline
 with client
To: Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org,
 hverkuil-cisco@xs4all.nl
Cc: shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 festevam@gmail.com, xiahong.bao@nxp.com, eagle.zhou@nxp.com,
 tao.jiang_2@nxp.com, ming.zhou@nxp.com, ming.qian@oss.nxp.com,
 linux-imx@nxp.com, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240205072556.804809-1-ming.qian@nxp.com>
Content-Language: en-US
From: Mirela Rabulea OSS <mirela.rabulea@oss.nxp.com>
In-Reply-To: <20240205072556.804809-1-ming.qian@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR03CA0049.eurprd03.prod.outlook.com
 (2603:10a6:803:50::20) To AS4PR04MB9244.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e3::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9244:EE_|PAXPR04MB8094:EE_
X-MS-Office365-Filtering-Correlation-Id: 39b9dfaa-2165-4d47-8631-08dc31530407
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bsWWWmF3DsdgHyPmXs+u3muhvsTbIioXih/eADGm2PtQrx+cCF9f1ZSEOgA6NhUDOv3S3WEHuTwGJpowdEhnb3xYLOY+ZWWRIR/j0E5tzNMB0J+8BDXgqsc2Z7/2Ru78wD0JQUeVFKLH0rwlbn6Eqx0Uh/WBsS0CttxvBw3VYDooObT8kmYrRA2D7+nY8zSW9M5TmKPE613ZN1rgUDN6aLuwol/EPV1FnVWtycz+sDZUbfuJFbiOmwI4/vIjFuZL8ZDcQSvinwXeugEsO35UaSs54KvqGG8C1vI5+WKNTdhcgsO/r+VAcL/1b31vc+L0YMScnoGZqk3yU0vwE/gEuPrMTmjGVPK9jdw8Fitsi1uWlYhNLs+LkXopy4/LvBNkPLXJY8w4o8vWSXglHIVIZsCrgF52+nIePTpT43BJhHcYaTqiQYbt1PRIp4/tVPDjNV/1JyxO/66rDDEZNYTs9Jz5f87eJox2I5VlSZWEHguJztXNlqtkUZysfwNXw+wOGrNmdL4r5dAtcmiXIfTfgq+YTzo3t0Rgwownnj2kdzU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9244.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c09PVmhnd3NnbHFBQjk4dkc1R2tJQWtkVStaT3RQK0M2bjVaZ3FGSkdzSytk?=
 =?utf-8?B?cmR3a2FTWUN1c2RtVEd2TVVPMjBNU2E3RHF0ZENzdDVoc2hUNlRZaVI3cGlh?=
 =?utf-8?B?L0JQaVd4bVQ0ekdmZEY0QTd1MmNBU1pKTTRCR1BjbVplRHdWZkExRXU3Z09a?=
 =?utf-8?B?TTJ2citRbXdtbTV0NmdXWHFzT2Nwa0R6OUlWK0NwVnhWaEdaVG5BRmcyRGdT?=
 =?utf-8?B?N0U5eHJ2RUUzd2VTTVA0Z2Y3bENxT2dxOUk2cWpkL3RzWUxYVlJ3aGI1eis2?=
 =?utf-8?B?L1VwazRITXdPK0V1eU4yMENsamJuUlh3L1A3NzlHWWpGcVE3SGVTc0RNVHdj?=
 =?utf-8?B?VDZlRTBkRGhCK1h3Z1l4c0Z5c2dXaWFpY2NLNm5wVlVObDVmZzdaRVpqNk1Z?=
 =?utf-8?B?TmpDWWdiVHhwdFBPelBCVGNkMW1Yb3RyalM3YXFrNDl3UFc0am9aTlRVREF4?=
 =?utf-8?B?SjFiRmlteVIzUjFob0dSQml3WDNnaHlhRncvd1MraFR4bjcwZUEzNmxXTWN3?=
 =?utf-8?B?TXdub2hyYzliYnVTWjZUUHl1dU50V0tFSGVtL3o4YU1aOUhkc0dxeVFyOGdu?=
 =?utf-8?B?ZzJNTnlXQWFESldtQUY0Q3VpOFBGYnduMWNVSmtTSVArOG5SeW8yOXJBQjhn?=
 =?utf-8?B?R05ETzl3K0FuUHN4bzd6THdINUxDZEk3aEl2bUowRVg3SkJLbTI4dzlIUW1H?=
 =?utf-8?B?K1hjWUZLQzNETFRLaUc3MGhnTDR4ejE3aXE4dE9leU5oVWlzckR6VHpqRDRY?=
 =?utf-8?B?SjVRQU9WRWtoZmUxVjcvUUowbkR4TGhUdUtUTnc2Vy8rY0xHdDduNVVtNGZB?=
 =?utf-8?B?UE00N1dINHRoNlpwTDFVRVV6cWhrK3lBVmJvWHkzdWVBZWtueVhsMit0MVBj?=
 =?utf-8?B?cVNRNnNmdElLUmFtckNzUktYTHpjUmQ4cDd4alhoRDBZeGNmd203OEVWK1I3?=
 =?utf-8?B?aGFLK1FXbVVVN1FOL3h3U3BQZjBBNUt3R21Zem9FSnpXK0JjeXB0TE93OThR?=
 =?utf-8?B?ajQ2b2xwYVFlWkVocWFYdVBQV0hSS2NwNVNybGk1M0RlTy9OUkp4UERMVzJG?=
 =?utf-8?B?WmdQWldreXoxZHRaNEdIZ0syN0xGZGtzU3lraytLVmpYNW9sR3ozRmQzOUtZ?=
 =?utf-8?B?RGVLaTNnL1IyNWlnYTk1blI2Z3NZRWEzcDF6OElvWEV0M3V5TSsyaFFrOVIr?=
 =?utf-8?B?b0tiRDBNTnZNUzNnYkJ2R0diQ1BvNUxMK1M3aU1HMHVoUGhyVHJjcFY1cVU2?=
 =?utf-8?B?WERabXRxWlFhRlZQdFpTd25maElVSFAxaUdUUCtXQVY4US9UKzdMTStCcUpT?=
 =?utf-8?B?VTU4Q3MzMDlsQ3hUR1hnU3Q1cStEdCtld003eUlLV0MrRWZWbTVjMkZzQXdH?=
 =?utf-8?B?UGJFd2tsZklpTzFLTUtpTUIrcFYrMi81VkE3UC9RQlNHREUwaFh2elBKck9y?=
 =?utf-8?B?aVBjaUZVQXlpQzBZYTlwY1JiUnZ6cVNNbnpIYVZ6RmZmekFkVWZrenAya3Ny?=
 =?utf-8?B?bEhWM0EwRXN6L296aEdLTDBoUEFETVVDeFVhOFVIWm1NTktqc0M5VnNxblZz?=
 =?utf-8?B?ckkyWVlBSG5ZbDNOM1QxUGQ5S0xqWjJLLzJqZEV6V1BMYlFYNXovRnNLbVpp?=
 =?utf-8?B?a2xsblZhUkIwZWF2bEpicTVwYkJ1UnRtbEpYWDhSeDh6dzNZeDNFOXczYW9Y?=
 =?utf-8?B?QmZkRHBzRWdQWnhtZnYreVZFQ3NaMlQrWEw3eER0RkZvVXpUVEZvbVpjVHpY?=
 =?utf-8?B?U3JuNVE0MUxNWHFIVGpZeWppWXZNUE5YS0lJMzc4RFY1aXBia0Zadjh1djdY?=
 =?utf-8?B?aUlDL3ZOLzByQXYxSE5qaEY0cklYZzFzOTVLaDMvQnJSWk5kNjFWL1V4Vzk0?=
 =?utf-8?B?Z250eXRDZm1HV3NyQUoxZmo1SVpjUnR0RVpTcWtBd2RkOFgwRUlwR1duYmFv?=
 =?utf-8?B?c3ExY2ZDVm02cWVKYnNSbDVQZHhQRlZyQnpLZ2QvRkxUNzdXWDhsRi9xckx0?=
 =?utf-8?B?dW9XdENCR3h0bVYrTlJuTll0eHl2QjB6bjd0aFhTTFBycHZtellqem9oendq?=
 =?utf-8?B?cHRjOG1SZThQWnZINFBKSmlocFVvOWttY2FXWFdWSVlGM0dDNmxqU0k2QTZr?=
 =?utf-8?B?Q0gycEo3SXBVRXoxMHV3dWdwN29oRG5rcnNyd3lEcTdlT3U3NkNiZE5EOVZl?=
 =?utf-8?B?ckE9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39b9dfaa-2165-4d47-8631-08dc31530407
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9244.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 13:59:41.5962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K7KF8vOMCisSFCWRzvHgr63BDSu/2MIVlHwG57hPfb/CtINnUWJpXH1T+VrDQO+nbVin0Tr429Aj73ew4pD/CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8094

Hi Ming,

On 05.02.2024 09:25, Ming Qian wrote:
> This mxc-jpeg driver doesn't allow the client to set the bytesperline,
> but for some android cts case, it need to negotiate the bytesperline
> between decoder and display, and fail the case if driver doesn't support
> negotiating bytesperline
> 
> The jpegdec and jpegenc does support to set bytesperline which is
> multiple of 2, and greater than the value calulated by driver.
> 
> Signed-off-by: Ming Qian <ming.qian@nxp.com>

There is a typo in the commit message: calulated.
Other than that,
Reviewed-by: Mirela Rabulea <mirela.rabulea@nxp.com>

Regards,
Mirela

> ---
>   drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c | 16 ++++++++++++++++
>   drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h |  1 +
>   2 files changed, 17 insertions(+)
> 
> diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> index 64112b63298c..cc97790ed30f 100644
> --- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> +++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> @@ -1373,6 +1373,8 @@ static bool mxc_jpeg_source_change(struct mxc_jpeg_ctx *ctx,
>   		q_data_cap->crop.top = 0;
>   		q_data_cap->crop.width = jpeg_src_buf->w;
>   		q_data_cap->crop.height = jpeg_src_buf->h;
> +		q_data_cap->bytesperline[0] = 0;
> +		q_data_cap->bytesperline[1] = 0;
>   
>   		/*
>   		 * align up the resolution for CAST IP,
> @@ -1752,6 +1754,14 @@ static u32 mxc_jpeg_get_image_format(struct device *dev,
>   
>   static void mxc_jpeg_bytesperline(struct mxc_jpeg_q_data *q, u32 precision)
>   {
> +	u32 bytesperline[2];
> +
> +	bytesperline[0] = q->bytesperline[0];
> +	bytesperline[1] = q->bytesperline[0];	/*imx-jpeg only support the same line pitch*/
> +	v4l_bound_align_image(&bytesperline[0], 0, MXC_JPEG_MAX_LINE, 2,
> +			      &bytesperline[1], 0, MXC_JPEG_MAX_LINE, 2,
> +			      0);
> +
>   	/* Bytes distance between the leftmost pixels in two adjacent lines */
>   	if (q->fmt->fourcc == V4L2_PIX_FMT_JPEG) {
>   		/* bytesperline unused for compressed formats */
> @@ -1775,6 +1785,12 @@ static void mxc_jpeg_bytesperline(struct mxc_jpeg_q_data *q, u32 precision)
>   		q->bytesperline[0] = q->w_adjusted * DIV_ROUND_UP(precision, 8);
>   		q->bytesperline[1] = 0;
>   	}
> +
> +	if (q->fmt->fourcc != V4L2_PIX_FMT_JPEG) {
> +		q->bytesperline[0] = max(q->bytesperline[0], bytesperline[0]);
> +		if (q->fmt->mem_planes > 1)
> +			q->bytesperline[1] = max(q->bytesperline[1], bytesperline[1]);
> +	}
>   }
>   
>   static void mxc_jpeg_sizeimage(struct mxc_jpeg_q_data *q)
> diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
> index dc4afeeff5b6..86e324b21aed 100644
> --- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
> +++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
> @@ -22,6 +22,7 @@
>   #define MXC_JPEG_MIN_HEIGHT		64
>   #define MXC_JPEG_MAX_WIDTH		0x2000
>   #define MXC_JPEG_MAX_HEIGHT		0x2000
> +#define MXC_JPEG_MAX_LINE		0x8000
>   #define MXC_JPEG_MAX_CFG_STREAM		0x1000
>   #define MXC_JPEG_H_ALIGN		3
>   #define MXC_JPEG_W_ALIGN		3

