Return-Path: <linux-kernel+bounces-72762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D0C85B86B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C305F1F2A3EE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6010F60BBC;
	Tue, 20 Feb 2024 09:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WAloAY5v"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7E35FEF9;
	Tue, 20 Feb 2024 09:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708423160; cv=fail; b=lKb0trp6dCqXNcreeEYnlvw49q/MykefbwXJNv9ca+FxI1hSVnK507rf0tEP9x5pLZsl/8nD6ufNtqtUaZqm3Xcl2oN4sIXR9Y+F80kjvXyGxJ9bzhVjyvd/mmwhCgm8w14Yt7ftXmNDWB7fRahGiXb3iTj0Pkn5xzYU51Scj6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708423160; c=relaxed/simple;
	bh=+kwHWi0T12EpVDhFCfUklSCoVwWtdrFaVXQ6hANoHjs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ccmdu+j+YxK+Bzc8HRFkT7lGaM5bJmSo9z/7DWviDpQB7qsV0CGqyAtYdTe6uh4FZsMqmlsR4OaKbUBJZjK6o7o6OWHDhYuhfO+sCRiV0w2rfqCQvnKyx5zwK8IBvfuj2zCyjqN/9vqsqQltxKmQq36BqjVbCj7NYWX6JOoqHkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WAloAY5v; arc=fail smtp.client-ip=40.107.237.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3b3frqVISFRS8RkkArUFTQO4QVCjZ8xUW5h5I3k9n7friL5dILbhltKUS59cHMQu7u/ADtsve7ND/hvXgl75Ef/WHCjIkKgpPBj577ED1pfw8cqUqugU8wMBJUCV9JoYW+RQE+apIVVKlp4Ay5QE4bbNFmgCXQh9g2FxiTFdM3aRv/8eoV5xQTa0LE1NC9T/6UFO/EaUW5okdZ4obtCK5ZXNO8ykXZ45cGvnZpEyvolG/tg1bFsDOw6l7TzAvcHP2AkPfOTsE7LMoOpvY9MnrFvD74ngCIEz8FCopZne9qPssVYTL87iiFUpdKU76dI6Uj4t1/gszDF9PyNoNTDSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9Rj8Gm3+fclqbVsLnOn68yonSG/BCz4FimiycKSWAU=;
 b=hW9cH9srDdOlt96wai+NN4z69fFA7MYPzMT6Nzv0nPL1YexEhe2pbvZPJKSi9rW6CpDBbD/rEl6WZ4ecUiCYodZNxa+OydRDcmJxuEEgTQkokMR818aq3k/WBCpdAKB7QZprJtaxw6qkEHE5yq/Qi0kx/YEShifwbAvV6RE4vbFezhA6aO3Vi1wJBzS42u3pJgeN1XyVOGnRQ0mmIEkIbTlHLfDOWlFceE4C5/NxWGNP85MSnqx7/iplDJMIlIGBSK2DzMIvPWOWv8Vz2ksY2h6gR9jWQ8uBhJhZsf5MyCpuFaPW2OpY14jQv6OZL6lYRyDMKNl9QBnoUBv3+snw0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9Rj8Gm3+fclqbVsLnOn68yonSG/BCz4FimiycKSWAU=;
 b=WAloAY5v09E1LN4dTr3mxo78lcxA4/sj0V81wHEr+V+zHKuPKyIhN8LeY7OQwd3QAupzakDi1PllufdQhAQa57cKnBf7GGrJyUQ4PMWGyjGHLhfsi8uPd+3zNOGpUbeXBcjDKCkK2b5wZFIOpqgANRRclZdNLTTiaJsRxRKQv2Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by DM6PR12MB4058.namprd12.prod.outlook.com (2603:10b6:5:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.20; Tue, 20 Feb
 2024 09:59:14 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::84b1:5355:e3da:dc97]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::84b1:5355:e3da:dc97%4]) with mapi id 15.20.7316.018; Tue, 20 Feb 2024
 09:59:14 +0000
Message-ID: <cc7f775b-188e-42f8-87dc-00fef1042d9b@amd.com>
Date: Tue, 20 Feb 2024 10:59:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] char: xilinx_hwicap: Fix NULL vs IS_ERR() bug
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>, Rob Herring <robh@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 Ivan Orlov <ivan.orlov0322@gmail.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <ef647a9c-b1b7-4338-9bc0-28165ec2a367@moroto.mountain>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <ef647a9c-b1b7-4338-9bc0-28165ec2a367@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0094.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::47) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|DM6PR12MB4058:EE_
X-MS-Office365-Filtering-Correlation-Id: 285967f7-4af2-4afb-4320-08dc31fa982a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dfoQe+DvoDj46pwVzrhLE3Npu/ckDa2WnxAyr240lytlIiara/FgTTelFghGbbsxBPQyWPmvXWlEsap5hZ/cder5eZqLTrQlPTpmxg3F4EYpXHEewl21gKdUYSna3JmLtHdo+ElGurdlk8hMPE2NSHFZPqd8OyLtXIu5pQn2NkNcx/8JJlnPgvXtwfCTvhSN/Y5UpTNd4vbrfqtykE+dNZIpP+UGnIZWgJamBEEQTy6a9ib2mwNWxKAZKoqfvRcIC/rEGR2jIn8QyX7L6S/blsGUh92OLLKlNIcAK3qrliXOfSvpkgUi0D/YuuijbOEICzzegsZVnGH9xx2bnVRmNhSivFBTBpyw4YHp/9mliyMc3V1fxYYQHob9n8CJ/xaV6xyfQJT/fioflbRYeeF5/uVQaNtpp+BY0O6SDOet/1MxnLZFWsbDnCm5CHhnh8IOIOnPWPZjQyKHOgOdylCgY8CwwfIuc8K3PM49mhTyeK87TSyEIGU0UjwQcP1aRE6muwTJkYrp7jzyTEptPMkCi+TQ3k2lsi+Q5+3t6a27t38=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THhNQVpEOWtzUE1sK0pkNUEwVVQ4QUZVY1NZZ0dOUFM4UzBtK0cyZy9LRXJB?=
 =?utf-8?B?WHZLM3k3eExkczJtMlp5Zm1LWitkazl6RW53TGtFLzFUcmFQc295ck8rRnQ5?=
 =?utf-8?B?Y3hma0hTYWhDSW04L2ZrUTBid0M0SWtNTi9VUUdYWTljNVNZRnVycnBheXA4?=
 =?utf-8?B?ZTJPT0NMc2lIZlM2SzRNTmlPWGtVNzdGZW51VUliQ0lmajU4dGdkdW5uU09K?=
 =?utf-8?B?dDhTby9JcktYS1BQaExRWXhJN2drbFNGVXhzcDhvNnFOVE1BM014YmdtVkNQ?=
 =?utf-8?B?VUZNdGlJRjI5Mjl5aldOT0dMSlZlRGdDMW9ZSHpFSUZ1LzhQdUFvV29sQVBU?=
 =?utf-8?B?WHNSVEJ1Zms4bDNYSTl4bHFzcU5XUkU5Z2RMZ2hxaVp0d2NYSHpoZjQ0UnRo?=
 =?utf-8?B?dTJETUt1aSszVjRVdTUveElSZGhPRTd5RXFvb1ljeGQxcGFxdkw2VkNjVER3?=
 =?utf-8?B?NW0zYVNoNUt5aTJSK2FTcWVTK05BMkt6a1FGMmUydnJETXRvT3k4VklWVitt?=
 =?utf-8?B?WVFjNVB0NlRBcUdkUjhVQW9IZkZjVGJKUWRKUi9Db3k3c3Y3RTN5TytKOHZa?=
 =?utf-8?B?ZDhsTWZNcGIwV3puZFB5bTI0UEtqQ3BiUlhoSFhxTjU1QkVmd25xUEJQRC90?=
 =?utf-8?B?UUVFUEkxVlZHcUdhdEJoZEdjSDJoTHpXYnZRK1lTNmNadkRELzJ4OVdCSjZE?=
 =?utf-8?B?Y2xnTlY4OUtHM09IdS83SnhTc3ZrdGx1SnFqQTB4bEFtamZOWXJIWkwwQ0g5?=
 =?utf-8?B?aVMvN1NXRy9yK2FLQ0V3YnBGR3BuVmFlYWpnUXd2WEZvSTV4Ukxqd2l0SWpH?=
 =?utf-8?B?YnNUa25HZWxsOUp4bjRlWlUxZjRpUzRjMXBuWTFSMUFRbHZmb3VrMjN4Vm92?=
 =?utf-8?B?bjhuVE1lOWVpUkFHeUJHNXIvZThNQTNDeUQ2V3Q1aC8xRFBZZDh0Sk1IMnpT?=
 =?utf-8?B?TEJNMXhnVEcwT0FKOWcvb01haisva2pKYWN2cXVndXVaRmlUZWpnUFpZd2sv?=
 =?utf-8?B?QzhUYnZXbnpUYktjK0VxallvUkxldlFTSUVXM3NHejBmN0M2dkFPY3hFQUpE?=
 =?utf-8?B?RWVPU0diTlNsNENENmJLQXZlcDV0dU5nZkFOS0V6L1ZTTGN5eTZVZkRaMWpS?=
 =?utf-8?B?UWpZWjl5bU5VZG9IeVZkL0xwbVJ0Q0F5RGk2Y2lJb2FxaDkwbjlDVkxDczNw?=
 =?utf-8?B?a1ppdmYxVFRPakszOEpqUkRxbjl6MUhrVzcwSnNQOVB3RXhwZjZYZEM2UTh1?=
 =?utf-8?B?TDF6NzdaVjZOUDJET1NDazQ0ZTRETnZnMTZEYWZTZC85TVhHTkdmSmJIaVFv?=
 =?utf-8?B?dUFOSmdYWVVaU3gzcVZiYXNyRUdyUkVpMXp4Y3hwb29PMGxpaUNNSGozQXE3?=
 =?utf-8?B?a2Q5dlg0eGlVTGZjQVllUm5KL3dJWEsybG4xMlB6V2pPbTlNdk9LcHlEcksw?=
 =?utf-8?B?ZjRuQXp6UzZlc1JjNVI4ekFZcml5OFMwc0lmRG80TXh5eUVBSTlrUEpqbXFx?=
 =?utf-8?B?REdOTG5nenBiQkY3OU54bGZxYUswTWhSbFpGNWtmejZhMFVTTFR2SU0vbUV6?=
 =?utf-8?B?am56UEpNSjZPOEg5aThvMVRxNW9yWGpiTzVpNkZQTHM4Yzd4KzN5QzZHV2tt?=
 =?utf-8?B?Sjdsc0E1SFhEQWFLUlRCRzV4bmtneXExQTFQZUkzLzhFZFpBenlqN2NrR0hT?=
 =?utf-8?B?Mkl2MjErUXRXOGFZRnRtMlFJUVljMy9HY3I4UEQxcEVidHRxS3Q0Y0NIT1o0?=
 =?utf-8?B?VitGSFVZaFRPZ3RKWnJPUVpnOSttT1V0R2tuL0N2T0NDbHdSUTBJT05rN1NM?=
 =?utf-8?B?YlBSK2pmRUxmL0FSRU43YWZTYzl2UG1EVk1SR2ltL3pqSUErQmdhbjVmR3hZ?=
 =?utf-8?B?bmFTeXJlU3RRa21TeHp6UXFoTnZTTHNzaldteFBnWURxazlHUnBXU05KdWY4?=
 =?utf-8?B?KzU3VWp5cjRNTlp1akt6aWhub0tLYk9UVUJMaTg4blV5UVphL0Y5UENGOUNX?=
 =?utf-8?B?WmQ5TFByK0gxMlJSbE10SlFNOFR3Nm9udFczR0VLMVpGSkx1NGthMm1KU3Bx?=
 =?utf-8?B?QThWb3hKcTdRZ0wzNHBlSkVRdXFxeVpjcEFVcUJKbFljbjZZMDNiL1NEVnFm?=
 =?utf-8?Q?1zsYCVLnZ7fH1D9JDRfkGND7m?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 285967f7-4af2-4afb-4320-08dc31fa982a
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 09:59:14.6424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hqO6IpPulksMMRxUJoc+rdBRz3i4cV+8LjmFrt/SGDNDzbSxzOBG91clRofsvXtL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4058



On 2/20/24 10:02, Dan Carpenter wrote:
> The devm_platform_ioremap_resource() function returns error pointers.
> It never returns NULL.  Update the check accordingly.
> 
> Fixes: 672371832193 ("char: xilinx_hwicap: Modernize driver probe")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>   drivers/char/xilinx_hwicap/xilinx_hwicap.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/xilinx_hwicap/xilinx_hwicap.c b/drivers/char/xilinx_hwicap/xilinx_hwicap.c
> index 019cf6079cec..6d2eadefd9dc 100644
> --- a/drivers/char/xilinx_hwicap/xilinx_hwicap.c
> +++ b/drivers/char/xilinx_hwicap/xilinx_hwicap.c
> @@ -639,8 +639,8 @@ static int hwicap_setup(struct platform_device *pdev, int id,
>   	dev_set_drvdata(dev, (void *)drvdata);
>   
>   	drvdata->base_address = devm_platform_ioremap_resource(pdev, 0);
> -	if (!drvdata->base_address) {
> -		retval = -ENODEV;
> +	if (IS_ERR(drvdata->base_address)) {
> +		retval = PTR_ERR(drvdata->base_address);
>   		goto failed;
>   	}
>   

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal

