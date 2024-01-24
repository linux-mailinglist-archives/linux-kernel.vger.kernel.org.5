Return-Path: <linux-kernel+bounces-37732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EEE83B48B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 428311F221E9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB991135A62;
	Wed, 24 Jan 2024 22:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="H8+wkjwE"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2054.outbound.protection.outlook.com [40.107.6.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E848B135A5F;
	Wed, 24 Jan 2024 22:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706134355; cv=fail; b=E0mEitxxt6T8LhQGRClN5dwmYJAkNRoCChLGyf8XD+l4K2C244wqQfXaVdZEG3R7JREzt+9QapRqgQ0/nqVCF6teArygELGqqTIjj61fQjdQaqGpADyigA5a23dWzFQ1tB86V++44kEOOujMUrGfxi4pln4W0FW45h1RxVM0exg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706134355; c=relaxed/simple;
	bh=GV1H2JpYUdoZsUb5ydBdQQSMqJZLj/obj8hmgQLtl34=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H0wJVPlJ+HZWouOqqt/jMAjzKZHYUCSdufwIKrLW78fSz+6BMIFwJBwDLGGTYEZnBvGDUPuqkKII8EoQ+g1XT8VcDgsvEipKmE+G5LCMRbK4Lr890MeLsbAeEVXTv+bo6L6G535EJQLMrXNrwKG0dRaS2lJ/sO3Jwk5XkCnUbMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=H8+wkjwE; arc=fail smtp.client-ip=40.107.6.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZ+K7CG4PD2/oXuxIvyrEKh2DASstHkkITQf+4ahvubTaeYMImc5XX2LAQnA6PsGi+qUQymbK3dw9jgS3Yuk4dqHHWV1N6lzL+ZJuGkYWCEB6KZ+PjS+AGCPJF87ds0yGZQo4iCNhQOC60gF8LOfJvfyas8xhZpjEtyuEVWoJ1BJ1xzFsOsZFpnMrDTu1KF6DI9+SlpeAOlXTzhF7CBllGpdECM1I3q0A/cimjqVvJP0wXOThR9zBs/MTigs1lGnQmcLmpI7QkEcfXVp/16/x2U9ISM8HtPnPkmeMxGBg96+wLpSYMKIpYVF1nFVA84BqBqHo1003GBgBjSoxf+EIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=owcLmo9P/RFPgG+FhZh1LlCRdsmC0/hNzG8FyczSXSY=;
 b=f+Gmdm6Mq2wRWpvB6eF4fH22YD+Mm3shdTJkMtwkKrMR3eGQbbYPNr3yqcDkZ7BlQgzUJE9b5Z6hBSMQe249siFp8vv7lJe5n5/LMRmdl0DUOKQ/d9CdFVlyVMPNGiPLk3r8BIWBMyoPhrpd6sYhaX0WwzWuEpu74aZ2tjcW0mgONYgfVaZ2nRov7bYyEbrcRffn9rnZEhVPw358ja/iPQmuzBCDmc0rTgrkWQ+gxmBdpQiA+rNsBI3LSMCn3KUkpOW4GjugG299xzVpAW3rNRcqUXC84mggLCqjlS8Zvomv3f/CuSnUjnbImJIxrBMJ2JB8TqTQKmF9dXruTOYWTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owcLmo9P/RFPgG+FhZh1LlCRdsmC0/hNzG8FyczSXSY=;
 b=H8+wkjwEYC7qfwTzRz2/+lKNFrhEDk90HXfIA7vSF0Lo7SqKws55i6ngCT/R5tLtkmpad8G3CwXHOi1CW6jB6tngAeaqcfU5dvt+bdsbdf4D1atRX/1sXoBBbUEwSKbWjltpV2mt/NJvDhlUPglcZGiIJgo6mFcNnwJnIAtH5gY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com (2603:10a6:10:2e1::21)
 by DU2PR04MB8631.eurprd04.prod.outlook.com (2603:10a6:10:2de::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Wed, 24 Jan
 2024 22:12:31 +0000
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::f2fa:645a:969:6743]) by DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::f2fa:645a:969:6743%5]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 22:12:31 +0000
Message-ID: <a917a6f4-eb54-4ce9-b893-38b3d3178138@nxp.com>
Date: Thu, 25 Jan 2024 00:12:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] remoteproc: imx_rproc: Use devm_rproc_alloc() helper
Content-Language: en-US
To: Andrew Davis <afd@ti.com>, Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-remoteproc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20240123184632.725054-1-afd@ti.com>
 <20240123184632.725054-2-afd@ti.com>
From: Iuliana Prodan <iuliana.prodan@nxp.com>
In-Reply-To: <20240123184632.725054-2-afd@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P191CA0015.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::12) To DU2PR04MB8774.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8774:EE_|DU2PR04MB8631:EE_
X-MS-Office365-Filtering-Correlation-Id: f00f6ee7-8a00-43a0-5d3a-08dc1d298ee4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	f+LIFrL1EW/QHUy0SeiX+x/l3N5uYRKx2aPiwIECisnTH/QYtPfY8wtvHHuXVWzg9RedLB9Rn748w8yc/rDzf9wW44Z2q0JE0+TZmVjDl6XgKGKeTW9jb31hHwOqjDx0tPObpLIMst3GUyfcxMLEg/HCX4ntS2UDKHGTBT9dFwIjqyP5d5TIhoRcYkajsXSUyOQ8SJdyk+lPPc1f1xKqOcFhNPpK8DAUWwm0WX4v41q92FDVfDtkS4nN1/9kCRQQswD/dyXh4iSunEz6hbMRypuL2gNdugEri7mdMhHC15vSwP4WuOK4gPkeOOs4N6lQmgycDWNh3CJdoYhFBthYhsV9E6nrLcPzPH3MnDsNwvUky+6lYR73Jk7LvZ/ScZY68CMdz2B1ptRkRPgLZRuEGaBEgHfC1cw+BsUZVUKiJ96B+pyTBHx3pGdNmF/thk5o6czZJpHUD9U0j0rCdDu6kqQwdLU/CTrC6HHMqMY0K1TuTX9HxJfHDCOuQrH5F7EyBsLp7ULdBNja6B/GohE2O3HzLUe57Zh323wJrhrqAECsWWp+wejvKcENnyzKBxT6pClICTRRr/bRKC1/Jom7/+dbYBhXmrF1CvMR8f24PwesUL37EzbWWEUx4LpczxoCEFzgJLTmSVmam0dHFj3f+RhpJMEFMmMdOyFuDU7jW80=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8774.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(366004)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(8676002)(8936002)(4326008)(44832011)(2906002)(7416002)(5660300002)(31696002)(86362001)(110136005)(66556008)(66946007)(66476007)(316002)(36756003)(6486002)(38100700002)(6506007)(53546011)(6512007)(478600001)(83380400001)(26005)(2616005)(41300700001)(921011)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGZ2ZE56RGFaVERzV0ZuN1k0V1hwbVZoTHRVejg0YUVvdnpENVZlem9Hd2Qv?=
 =?utf-8?B?SGlTbmxhajZ4SWRDaHVBZ0lqSkV6VlFPSDMwNDFLZGdIWE9aY2RsbktuS1dB?=
 =?utf-8?B?djZEb1poRndES1Fwb05rcGV6c2RySnp3M2lxdEVmMkF6RlBVdDVXcFZhclYz?=
 =?utf-8?B?MEc4dEkvWTVIcDRseG5mcjR6bE1uRHE4eU4zdHl5aFczNkpuKytEZktwM0cx?=
 =?utf-8?B?eWNEWm85TWI3Kzl1U1NZUU45TkhWWUhmaW9ySHVyWWNnT3ZRTlRON3NnQ2Jz?=
 =?utf-8?B?a3kxS0hJcWtxQS9rVk81dUlVa2ZETVFYeFgySklKYzhaZ3E3b29yeXo3YW1a?=
 =?utf-8?B?dFNDMnd6WW9mUHdSbWFOcGpQTUdRK2hGQ3FUaFpiSlJMdHZjR3RVaENXR1Bx?=
 =?utf-8?B?UEg2SUhDdHpRR0tscW03Q2hFaGdFOTBVNlVmWXpzQ2xoZnBQYnBDT25iWlNl?=
 =?utf-8?B?azd6UHk4aXhzRG0rZktKMWp4ZVFhOXdSeVE5YSswTHRyVkxaMU1za0l1VnF5?=
 =?utf-8?B?RXdEcFBlNk0yT05zYSs3MnVBbzBDMGx0OU13KytmVlgva3VrZldua3hsQWV0?=
 =?utf-8?B?N1o1bWpYZUFlQXNodnlJNUJkOVpDUmpXVUhUUUdYbnBpQmdDY3VjQklaM3k4?=
 =?utf-8?B?bjR1V0c2d1ExV0hlMUZkY2VYNGliV2J2WG5ONUc2U3pOUTFISG05NjdmVHRR?=
 =?utf-8?B?R3B2VmxSK0cyK3Q0ZjlYSXJ3K2s5RVdPU1h4UFozZ2FJU1lSa2tqZzdLOVYx?=
 =?utf-8?B?aXlyM0ExL3NuUnpkRFREM3pXMjVzb0dITW04Tk1GUDk4Wm1Hcmo2b0pQa0lt?=
 =?utf-8?B?MlJTa2RsM0JiRlBoMTZMZzFJYVRWYTVnczVkWlVXem1Ba0VHZDlNcDlrVGg1?=
 =?utf-8?B?WGZmRmJSWTZBVW9JS292dW1sZXk2Q0t0K0ZRQ0JCWmQwL2NaMUgwc05FeTdH?=
 =?utf-8?B?NzNBS1hVTVR2K083MldQZjJXa1ZlUmt5YmJmN21ETU1Ja0I0UDNQZERhZlFK?=
 =?utf-8?B?Z2s3azVhSmcvejhvM3hWbzNVMlJycENqZ1lmL0JnVkxqVldYQ1l2NkFoOEpL?=
 =?utf-8?B?bTVzMUFhM2dULzlwczZHR2hDWEx5K05UU0d5cFI0SDdwWXdUdHRUVFFCYlRv?=
 =?utf-8?B?VGhTRWpQKzNhcUJoV3UyTUd1RHA3M0VlVDhrb3J4ZnZMdEJ5Y2dyMUUyT3NT?=
 =?utf-8?B?cXFCZHlxUStrc3gyWm9jSEtGa3ZVckMyU0RCa2djUUhydTdVcFc1MXltQXpw?=
 =?utf-8?B?ZCtkWGJCNmtrMXU3ckZFTnJjUzY1b1FvTXRnTUJ5N2dWYVNWN3dVSGtETUp2?=
 =?utf-8?B?L21SeEhSMTdoL21HSlI4Y1cySGdCSEMzQVFLMC9JbDhiOXJLcC9aWFMwdkND?=
 =?utf-8?B?TU1qeDJmcFdkSXZaUWo5dEhvQ1pwTUhvTUtmYU1xMjdSNWpMZEJRTXRtMkpW?=
 =?utf-8?B?SHgramp4MXBiQkk5WFVIcUFFR1NXdmVLcmYwYTZmM1pxNkdGVHZIVzZPSXU3?=
 =?utf-8?B?QkRNdkNLeUZnekhaRDBXYmtWcGk1eGdudkx5dG1KREVNMk5YY0MvWkZOL2RK?=
 =?utf-8?B?cDgzbno0a0FOd0ZDZzRCN3ltb1V0ZlFRa1gyQnh2TFBObFNUWk1xQmxvM3U3?=
 =?utf-8?B?U2dPS052YjlxN3lTM2t6QnNzTnpZVVZtaWNhNE9XMnVrUXg2UktEVU9FQjd1?=
 =?utf-8?B?TTVhb1Z2TmlLbmFNcXZTZ3E1NzZ0ejlBZXVxc1hOMUtIZ2tVV0d5ZXNpVjdX?=
 =?utf-8?B?TU1UcTdqOU1ZRWYwTEswMUZMc0NUb2U1VGlZMmQ4aklXQTlKcnk1R0UrSmdz?=
 =?utf-8?B?S0hQbXhNUE85QmRrWFNKMlFhVktZMlVtWTM4R0NCa2c0cmhMdis1Q1BnWWNE?=
 =?utf-8?B?NHBCUTJadFFaOE1uUXNaRmF0NlNINHJsOW9jRmNPSHZPVWRBSnpuTjdham0w?=
 =?utf-8?B?aUdaeTgzdytZRnRyWjFBaWFUTW9MTzdTYTkrUUp3WW9XTEZ6enhCOStHb0Qw?=
 =?utf-8?B?L3VWdFFmSS9SNGQ1MjB0NUZaUE81Q2xPa2FFdFdDaWxJT2dZNlZ3d2FiVURP?=
 =?utf-8?B?dzVFV0xhdDB4U3kraW03aDQwdDMvTjlBdUhjUEhxaVR5VjI4dFNpZmg5bXEx?=
 =?utf-8?B?c3RoR3NSYlVNUDRzcjg1TWNySEtNSElua3ZtRkdmeUdoOEVpSTZaZmtzSzRK?=
 =?utf-8?B?aGc9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f00f6ee7-8a00-43a0-5d3a-08dc1d298ee4
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8774.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 22:12:31.0433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4iLmYmAbVeYtk2uFk2u/i3t6uXNjAwJk7WAyvbJ5WispPRKnB78TqUGZ8wKGaOHSi9kpYuTvup7RXVqOu0BewQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8631

On 1/23/2024 8:46 PM, Andrew Davis wrote:
> Use the device lifecycle managed allocation function. This helps prevent
> mistakes like freeing out of order in cleanup functions and forgetting to
> free on error paths.
>
> Signed-off-by: Andrew Davis <afd@ti.com>

Reviewed-by: Iuliana Prodan <iuliana.prodan@nxp.com>

Thanks,
Iulia

> ---
>   drivers/remoteproc/imx_rproc.c | 16 +++++-----------
>   1 file changed, 5 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index 8bb293b9f327c..55ecce3ab5f75 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -1104,16 +1104,14 @@ static int imx_rproc_probe(struct platform_device *pdev)
>   	int ret;
>   
>   	/* set some other name then imx */
> -	rproc = rproc_alloc(dev, "imx-rproc", &imx_rproc_ops,
> -			    NULL, sizeof(*priv));
> +	rproc = devm_rproc_alloc(dev, "imx-rproc", &imx_rproc_ops,
> +				 NULL, sizeof(*priv));
>   	if (!rproc)
>   		return -ENOMEM;
>   
>   	dcfg = of_device_get_match_data(dev);
> -	if (!dcfg) {
> -		ret = -EINVAL;
> -		goto err_put_rproc;
> -	}
> +	if (!dcfg)
> +		return -EINVAL;
>   
>   	priv = rproc->priv;
>   	priv->rproc = rproc;
> @@ -1124,8 +1122,7 @@ static int imx_rproc_probe(struct platform_device *pdev)
>   	priv->workqueue = create_workqueue(dev_name(dev));
>   	if (!priv->workqueue) {
>   		dev_err(dev, "cannot create workqueue\n");
> -		ret = -ENOMEM;
> -		goto err_put_rproc;
> +		return -ENOMEM;
>   	}
>   
>   	ret = imx_rproc_xtr_mbox_init(rproc);
> @@ -1167,8 +1164,6 @@ static int imx_rproc_probe(struct platform_device *pdev)
>   	imx_rproc_free_mbox(rproc);
>   err_put_wkq:
>   	destroy_workqueue(priv->workqueue);
> -err_put_rproc:
> -	rproc_free(rproc);
>   
>   	return ret;
>   }
> @@ -1183,7 +1178,6 @@ static void imx_rproc_remove(struct platform_device *pdev)
>   	imx_rproc_put_scu(rproc);
>   	imx_rproc_free_mbox(rproc);
>   	destroy_workqueue(priv->workqueue);
> -	rproc_free(rproc);
>   }
>   
>   static const struct of_device_id imx_rproc_of_match[] = {

