Return-Path: <linux-kernel+bounces-94311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3566873CED
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83A702888BB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E272513D309;
	Wed,  6 Mar 2024 17:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CJaZwh+T"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2056.outbound.protection.outlook.com [40.107.95.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADAD13B7BD;
	Wed,  6 Mar 2024 17:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709744717; cv=fail; b=LSsstpi7ZHPQ5j1Az8+JUbfnTjKiJY/izTqsU7dilxe7ciaUnPfCHUMPIri/UdF29PySYQX51ARIJtS3qyX8fWLzOl4fefC3h2crCWtD3WetmzcT/1AxgNJi5AzUQ4qtUL/XGj18DjExplDcTC6tyAztxtNc/HCFL54KMdhhtow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709744717; c=relaxed/simple;
	bh=C3zEHxLR4r2Jdy/j+NgM5MpRA0U84p6vdFtWI0hXcfQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HD9Fg5xig2Se6lIf8sDiZfKH3fbwR8X3U2vMY5HycTCkpZIGc0TzJr6I1togWHYHkk8wP2V6TIO4zkaeDLmzkdxoTjd0IUnNugpaAhf+2BGApjCL7PSVyAUwPflxRHJSUQ6zqheeN/KgHWGM5kqDU4AQ92kU3j7HEGs92VGsWuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CJaZwh+T; arc=fail smtp.client-ip=40.107.95.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mycZGFLdZ7w+V/IU1xFmNn5tFf19fXlaNOnL1YzNfVFim7oAj95pz8apnlPuy6Gyq0aPbWT0Ex47nfUbNu1qJ22ppGZpExCDfwElVrNE++SWse958cjSCs7NLEJlGX4C6nPuBL3aJ47eObBF+4xt82JOrcBl7Iyk66398NaaVB27olNl9cwBidf7QSWf5Pr02SoDqjSjhnXiQ6Ag3E10PIleQCox3xnYSU3RGDsI/NzOD9HtIo+UQBgFntaq/3nGncx99oXKZUwyEemQhIJuSacgS64SAbb2wuJceTRtnowT+8McG3xyhdFVh7IXjAd6esFpErCB94cu08VqT0TmUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=axMiFA5FRIW0XZkRbc6HDKWVdMZwCikQLMIB6BbM8L0=;
 b=A1y3f70reGfMbh9DSA2/XHON3gw7x6ossmtNFpV0agoGfgigcQVl9+DyUvXdFfn5ZlPkOlFShkq9DEgAd9zNUjrCZVNJlSV3x6DoB9Q4i0kpczf/HfuxyVYEJDzCzMvfyE15iCyfBD57TyDcwHxjowuV9Z6iZhlDu2MdcmZFW4YGk+Q5WNWv7M86k+UmrmD/7jOx4nPIcELt2i1wGvW3zBeKh2r0kdH/2ix3sR2TcOJ7niCe11hioTm6gNrms6v4aO24WdMDxqZGLrkePGrMkHKS25oEA/Vs7MB9XPlEYXIqkL9zvjwl07ZXZPm/SXjaQjduWOh9FAL0agv36OHbLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axMiFA5FRIW0XZkRbc6HDKWVdMZwCikQLMIB6BbM8L0=;
 b=CJaZwh+TTikeR16U5Uf3IKBSs5FN6Eaw60q+thh6jF/xyV9FJT5z+yDLqKKvW76eBaxEes6a7k8RrCnRsAcRTROlyBApAGj88AgQrKPtMKCBYT7B9RGQYxWTHHkKVYQpdvv3aqm87ANH0URpyVrwrx59pC/hp+eo4OfQCbjmm4Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 DM6PR12MB4282.namprd12.prod.outlook.com (2603:10b6:5:223::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7339.41; Wed, 6 Mar 2024 17:05:14 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::e4b7:89f7:ca60:1b12]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::e4b7:89f7:ca60:1b12%5]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 17:05:14 +0000
Message-ID: <ed1fdbab-bc63-4aaa-b516-0c03e6755824@amd.com>
Date: Wed, 6 Mar 2024 09:05:11 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net V3] net: pds_core: Fix possible double free in error
 handling path
Content-Language: en-US
To: Yongzhi Liu <hyperlyzcs@gmail.com>, pabeni@redhat.com,
 brett.creeley@amd.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jitxie@tencent.com,
 huntazhang@tencent.com
References: <9c4da99a83bceb4680aac9588151cc8190ff07e0.camel@redhat.com>
 <20240306105714.20597-1-hyperlyzcs@gmail.com>
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20240306105714.20597-1-hyperlyzcs@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0019.namprd07.prod.outlook.com
 (2603:10b6:a03:505::21) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|DM6PR12MB4282:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ed285b0-e169-483a-8527-08dc3dff9707
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OgYDnEBQD04xmeKzNrSIl5cxk2ZzrielFvYpo4Gq333Mqxu2234goqH1Vjd4IG0UAWHKNrbqyNNe7qNIc5W2ZBIrWX2j4OsBn1MJbOFBLO15XEQA11h6fah1/H2RZC+Z3Zdq9uZIRV93TqYCmeQCqT+BKfiKSr13/jwiWewSfDj6iOaei23EGcWHOK0uRRH5cuwFc85l+s20YuG1A0gDQfjuITvEkQ/6pGleYjqWWcoPZZ1Am27mIZN3uXwua1spVyAqydtW8llRTnhXs9YY42vYkSfFEPpnezH+N1SAJDXHLY02kLU+kn83ctAwt7pJRhjAvhGddsScAHUswzjca0BLHNGZYrpWJn7uPydmckE4coD/yXXuW5ILzESlF/3wXuQjAuSIbAh0jlxgknnBLX8kQoWJM4GEA9dMjP/uwnaKT8xbjD/GOUiIxsnU43z22eefmP2iygdjKzxYPR6VBJR8tazSmBqqHDWedGTbInrVqq25RKiOa1EOwDjjEh9vEtBgm4Tt8iOJOwph2YJwfNfANB+2Mwa70NFvWZYuV47288/GXVNk3UBgQeJJJR3TMd8V7LDl6mRbBDdI39PwGT4ajM5C7TqotNd/Tk9YjHSYiJjT4qd3UlDWkQy81UbZq22qyxnNB8H9storG5sygIaaGurieUpb+UXQhygcuFw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUU4NW1ya2JxK1RJU3VFUVhINGY0Zk9OZ01EY3hwRW0xWUI5UEZPMFNGS1kv?=
 =?utf-8?B?dm0yVXBMQmg2UXZLMkpEdDBKSG5lQ0VlUGxpbm1OdXJUeTRPaHRkVEZIcXo5?=
 =?utf-8?B?RWFESkxFbmFkVTArZmRlYS9HdVk3V2lwcTFRV2hCSHVqVVo2WjZhQ3YvOFQ3?=
 =?utf-8?B?Qkx2akMyd2NPRWZOYlFDUUtBMUFFbG5iL1crV05iODd2eC9FbWVDcDhXQ05s?=
 =?utf-8?B?OTgvTk9WU1lpU2c0ZDR3R1d1VUduT01BeVY0SFo4Wm95UWs2MDhUMUVMNGRr?=
 =?utf-8?B?WDMzeVBSWTdZZWtmY0J0WlJyNGZxQnVtb2NGZ3BIaDhabzVvdDhjRmNoRkdL?=
 =?utf-8?B?MERseXdXZFVqblpObXEzbVZqSTBjT3ZZTTUvZ2Z3eWVWR0NydjRnbjMzYUR4?=
 =?utf-8?B?aVViZGhyeCtvNno3RXJ3YlhzT28wSHlMaWp4R1ZzeDdVYnpYZ29NNldGaFlh?=
 =?utf-8?B?c2tHWXJFZkhNR3ovNWQ2MTA4anBOWElObWxlRjFwUFJOMUM4b2hZZTM5dFNO?=
 =?utf-8?B?SnJIeFdsNStvUFo0amo2R044ZDdwWS9YNHRnZlVlSjdXY3loWmFINkNxVlBT?=
 =?utf-8?B?cjhuNXN2cjIwWi9hSWZ5KzlMRlMvTGUrSnVNeEFFd2lOMnFxTktxZmZLZStp?=
 =?utf-8?B?RVo4dUJMdzJTcytGV0lYbGtid01NRlBYbm94QkREalBzbkVYSlE4bmwzMUlO?=
 =?utf-8?B?OUUxdDdER3J4Y29kZlhaRUdSM0dvbldDQjdDL0hyYnhmeEpoRk5Ob2hPVjhu?=
 =?utf-8?B?UkFTRWY5MEpsMXJ2WDNUTmJ4S0lQL0Jtek90dVVxUFh4L2NMNzlmbjZZTTgy?=
 =?utf-8?B?ZUU3VWNSdXZVU3RWaENJeDc4OXFmTnFCd0ZMeFd4emRoaFJOZEdGWmdPR1kr?=
 =?utf-8?B?a2F0OUR6TTM4UWFTbXA4TlZBMWNUcEtDaWE3ZitsZHRRWXRjR3BtRGJjRzh1?=
 =?utf-8?B?Sm9TWTVrbGV5SWRMOWhycTlpS1VqNk5HbHREQzBJeFNhMzVEYUhsam9VcVFY?=
 =?utf-8?B?ZG5kQmEwRUZoZFh5ZGhqZ3Z5dElUR1lWUzl2cVpwV2doanNIa2RZa3k5Y1RH?=
 =?utf-8?B?MXVhaVVRMnk2Sk93Q3k1blJUSG9TMmxTMkhLWURsSGRFckUzbXNDcE9xTG5n?=
 =?utf-8?B?dERmeEdZUjRCTVhjcSt0b3FxRnlldVoxZ2E2SGlZTGd5d2lsWHp0RnBIQzZ1?=
 =?utf-8?B?ZTVvaTAvUEFid3BWdFg4WlVjYWhKcjhYcmt0c1J6TFloTk5USmpoNnR1d3Ju?=
 =?utf-8?B?TWRJa2xEQWJRb0VPNXJ2OWg2T2pTZHdjTG82TGlndWZ3UFV5SE9NOEhzMFFQ?=
 =?utf-8?B?eW41Mk9ZeGN2eFNyWUxwZFUrTEpJWHlkVjVicGdxaGc4bXV0MFpqS0U2dzh3?=
 =?utf-8?B?dUlXb2hLWlRtajI1U01Db1ZuMDlGUUViYmpSNFZEVDVNOUxjWnI2M1BYc1FG?=
 =?utf-8?B?WTJjYVovbWs1R1k5YnNYMmhLd0xSeElqdTNydU1VNnoyWjc2N1g0UCtQc3Bi?=
 =?utf-8?B?M2VwcS9VUzVnTUs0a3hTTlVrTVpBNXI2TGp1NU9YaEc1U3IzWmZ0R05ZS0tZ?=
 =?utf-8?B?aTJMMEZONi9sbFd2TkdVNVZDMU9SeFJIK0RZVVk1MlUrTkc3eTFhK01uYXlJ?=
 =?utf-8?B?Tm5iS2hKTVh3VGdEekdFeEkyZk1yL1p6S2tDYWM1VHBnMElEaXJwVE5BTmFi?=
 =?utf-8?B?RUd3SENwdldXNjhUYTl1cGN2RlFoMHhPMDBoaWRaQS9pMEpJZGhyZVlDRnU5?=
 =?utf-8?B?anpmc2FqK2JLZzQ3TGFnZ0FHOGZra2ZPZlFWcEJ6MHFLWFpwcXc2T0tUQ25h?=
 =?utf-8?B?aTVscG0yRFBSMkZuVE5iZzVGUzhUYTBsUURUVGNHS0ZJdGFWMjBsNDlnRXBz?=
 =?utf-8?B?ekFRN1d4c24vb3FVU29xVlJFL1hvYnhsK1daeHNmbU4wazZWUFhkK1ZkdlB5?=
 =?utf-8?B?ZFMwRFE2RWxVc0lMdmVTRkYvTnN2NHJFS1F4SWRQK0hiWEsyL0g3bjRIYTRU?=
 =?utf-8?B?U0g2STJTK2VSb3FIVGp0bllqODdBdG1ZOTlnUkc2dGRvNDE3dy92TnNqNmRh?=
 =?utf-8?B?bWR1ZHhOc1VlWG9rMWRsVUNHSWt2QlJybGlzeUJncVg1akVkbTB6bmc0ZWNs?=
 =?utf-8?Q?1M+fbDdbNvD3b1SXmCc9a2TIE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ed285b0-e169-483a-8527-08dc3dff9707
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 17:05:14.1148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6hLaooO7M5YmXopTvevTgUvoEeRsJYcbnJS/ESLUW+94TJvJKBtABsVscJqCkHMd9AyrQEWIa4ii9rwVL/YTmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4282

On 3/6/2024 2:57 AM, Yongzhi Liu wrote:
> When auxiliary_device_add() returns error and then calls
> auxiliary_device_uninit(), Callback function pdsc_auxbus_dev_release
> calls kfree(padev) to free memory. We shouldn't call kfree(padev)
> again in the error handling path.
> 
> Fix this by cleaning up the redundant kfree() and putting
> the error handling back to where the errors happened.
> 
> Fixes: 4569cce43bc6 ("pds_core: add auxiliary_bus devices")
> Signed-off-by: Yongzhi Liu <hyperlyzcs@gmail.com>


Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>

> ---
>   drivers/net/ethernet/amd/pds_core/auxbus.c | 12 ++++--------
>   1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/amd/pds_core/auxbus.c b/drivers/net/ethernet/amd/pds_core/auxbus.c
> index 11c23a7f3172..fd1a5149c003 100644
> --- a/drivers/net/ethernet/amd/pds_core/auxbus.c
> +++ b/drivers/net/ethernet/amd/pds_core/auxbus.c
> @@ -160,23 +160,19 @@ static struct pds_auxiliary_dev *pdsc_auxbus_dev_register(struct pdsc *cf,
>          if (err < 0) {
>                  dev_warn(cf->dev, "auxiliary_device_init of %s failed: %pe\n",
>                           name, ERR_PTR(err));
> -               goto err_out;
> +               kfree(padev);
> +               return ERR_PTR(err);
>          }
> 
>          err = auxiliary_device_add(aux_dev);
>          if (err) {
>                  dev_warn(cf->dev, "auxiliary_device_add of %s failed: %pe\n",
>                           name, ERR_PTR(err));
> -               goto err_out_uninit;
> +               auxiliary_device_uninit(aux_dev);
> +               return ERR_PTR(err);
>          }
> 
>          return padev;
> -
> -err_out_uninit:
> -       auxiliary_device_uninit(aux_dev);
> -err_out:
> -       kfree(padev);
> -       return ERR_PTR(err);
>   }
> 
>   int pdsc_auxbus_dev_del(struct pdsc *cf, struct pdsc *pf)
> --
> 2.36.1
> 

