Return-Path: <linux-kernel+bounces-70287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F0685959B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 09:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59944282D42
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 08:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370B3FBE1;
	Sun, 18 Feb 2024 08:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="BQeZKqBt"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2054.outbound.protection.outlook.com [40.92.52.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF50B568A;
	Sun, 18 Feb 2024 08:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.52.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708244488; cv=fail; b=Qz9IRd2jeEKJLSAtl6oIpVW4HAngfBYZ77/69r6dET0aMfgW6uunXbMi5kqS7jYqr4Zv2Y9TuyC73uvOsHknWwp+pNyI5YMXCIvx6qLt8sD5fFD7fe7zcwBKXqU69CM4qz6IwH2GSnSm7pyvoZz+9Cgm8HvTGzNZ2z3agtRKgDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708244488; c=relaxed/simple;
	bh=LvCGYYp7hQVTmc6WoBgY3W3XpwUxai6CQF3T3MUkXOQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a6eeBpZfSS39Io8oRHUx4hV+6e4evL47u4WEpy+PRie+vVMoHrAbOoANOMS4DER8IqhN1s8Z8s1FDJUBJRByNHQkWhKS5P4QPHENix0mOQBYRRddNgqP6vyHZ3lYZB+9Hh9z+eTwkn1bbb+QSNs11eYIgAets7eFNdJig25ioOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=BQeZKqBt; arc=fail smtp.client-ip=40.92.52.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gc2AlIEZdHCFQ2JU4VOa9o5wXz3HgeBaLv81qRQBrB0VmtSouh1yYKUjJvxnxE2DDSZM71AQV/3JjGWZ/4eQsDQJJS1pJS88Eig3HcT35u0HVvrmZYwZq+KggEsKsMAkfP3QU2Gr3/9faFK4BuduL79YMT+mF7qMm0WntymWCaqMQkjrcVDtzphe/OW+PHkCQcCBHYzvgtQVMiJB/kfnnJvLS/k94vZjAnQFLFjaJtqvS1hH+u+A7fzmCG0XyLnrzXg3KscjWwKgdYl9unCmrHimnmzpp9tDk79tv7bkQA0KC3QD+gjBuKb+5JTJpmabk08THyFiYbKb9sP+j1hZ+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQX7GTnjol7CphCdvGTFqsrOM3LqaI2OHgyQhIhlHms=;
 b=IJYGrWl4l85iXeV2S/UwaWi7agE2s/9y5xM6fG8Vv37Fe6VFmP/ctHIB5NKhtkNdch+F+Y8v1UxZyIfVcMxjImEOhZuXhT4pbXWX1+DZVjAmr/jPrneIiRPSyltzygfEe+0FPGRWg/5SAR9o96C6jCpscTPwnaqjYLK8mMToJMZZ1sRhz64k2UT1c9Z38vv/YG2jfjT7yMfu3bk50+xgLvVI4ZWntFKC0loLjyKZN+XhamcgPUGnp4utmxO0ktv2ienUxh1FzkpBfFQJO9HyBR1fBtnenPPKq6i+dLzIQChicv/fYkizhe0eIdaoHhnG0XExrltWCA819GDG+/PUnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQX7GTnjol7CphCdvGTFqsrOM3LqaI2OHgyQhIhlHms=;
 b=BQeZKqBtOqBllVxibhcxt6tIkfZY+T5+M++dtSdL4Xmn/D7PtcC5Dz1gnRUWJz5JApLQKT/1KPevo8xTpuWjb8Dm1DTA1VcYNk/7F0HeR1qCib60mKloCZwwdI6oxecaYZVBsxX7Pi7Mh0FdKyo/LebRVXFJV8N6FnqwmAoXYrtWD6TfAF3SLzSUraUt8KVPSHKWckugBZltWBVWCafnn/JqUnUOi7ApIQsaqNI7xdt+I7qwza9xGUmvaFMdM1Uck5Twf0T+r8O0XRNHL8cHsfrAzM5y3839pUgWTKV25kFHBcQhTpkWjMA86OqHBMvtnApMhgRQMZ4NPQ8Vp0A/BQ==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by SI2PR06MB5113.apcprd06.prod.outlook.com (2603:1096:4:1a8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Sun, 18 Feb
 2024 08:21:18 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::9a6b:d813:8f4b:cba1]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::9a6b:d813:8f4b:cba1%4]) with mapi id 15.20.7292.029; Sun, 18 Feb 2024
 08:21:17 +0000
Message-ID:
 <SEZPR06MB695945299705B6E8BF0E326296522@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Sun, 18 Feb 2024 16:21:13 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] mmc: dw_mmc: add support for hi3798mv200
Content-Language: en-US
To: kernel test robot <lkp@intel.com>,
 Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung
 <jh80.chung@samsung.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Igor Opaniuk <igor.opaniuk@linaro.org>,
 tianshuliang <tianshuliang@hisilicon.com>, David Yang <mmyangfl@gmail.com>,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240216-b4-mmc-hi3798mv200-v1-1-7d46db845ae6@outlook.com>
 <202402181540.H4Ose96P-lkp@intel.com>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <202402181540.H4Ose96P-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:
 [rd+/2oLvLELvw/34LI0iRjT41XkaphkIiTSqYyAOZI4dLGx5pFG3NN0R+a7C0jNhH6ZpYue3wNg=]
X-ClientProxiedBy: TYCP286CA0072.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::20) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <fed14e44-6b36-424e-86b7-b85e61ab1cb8@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|SI2PR06MB5113:EE_
X-MS-Office365-Filtering-Correlation-Id: 69453715-b438-4816-03f3-08dc305a945c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zgkTp04Di8CfwwkE3lZANwKSYZqNbGB2lARIQSsyTrMIXhJJB/tKfsPGTy/zz5WG7xSfm/1DyrLffMeYY58uxeDfJAGUXiy76Ksk0ZFHeB1758L6vtaHC7ONRu17h20W1gDDLj7xjYi8/M6nlIymeoIxsdc6+pBGG4GohVB1fxyAbIpiprog9MnxlNhHCYb2TohB5nIsUrMqYZX0T9jfp1l2ghdxjUNcy3gdDynEemrzkyAF/+DHjpyeC5V9seLTHB0DA2ThxLFR31X9186LC2EtNFANGlWEFhnOqJAwpZbUIyffOEt/XD2Ml8NIgQ/Mc/InnGwiyyYOoMQkyYsQqkP9ieVPz46T3181LpIbUr6i9EmscOWMvg0ugWededMdJr0GSvNvnrucRN5APsa2wO/7kbiOLHnXFGLzvl9HQJW3HdHCre0G4AinHU1XtF05JerakBgUf04a5qaPEs5CV13IaezM84DYYpNhu2PLuXn525tA7rK55cV2okPiH4O13wjG+rWIYgRXCXaGjS7Anb+pdB094QaLCoaUBRcO/E0wJCdDig+4DMayMHKNNP6TxrzpYnEMiQb6rxrnIBP1Ai8ApRChiefHNMjw5UvLX+Gtg/Pfa4PH7V3bKNdvwh2IeiAavAcG7hjvWx0MfiA/Xw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dlJYK1Jwdis4dnFrQzRXVlp1bjl6dHlqZkJnem5lSTBXU01ad3hQOU5aaW9r?=
 =?utf-8?B?eThHSWxHL05aUTErSExIWTEySDMrMUtJNVpZWVJLUHhNaVBIZXUzS0FkTnhn?=
 =?utf-8?B?NVJTMFZ4ZFAwcUhSTzJHdVJvQVRyenNpaGx2Qi8wZVgvd3NCRklNK2FDN0FU?=
 =?utf-8?B?MkJkNThRczREem9ZYTNFbTFCM0tYSFpEVGNrcTB5Wk5OWk9FMU9ZaFZrTmx2?=
 =?utf-8?B?N0pQQllsUEgrM1hpL2h3S3JJOUgwOTlxTUlnRUNKQlY4ZE83TWdpS1BVQVJm?=
 =?utf-8?B?QUVRVXVOeXhSM1IrSEtaZmxibUdua210UExqSlZOVC95SFNxeElodUJBVnk2?=
 =?utf-8?B?aVNwM2xkODFsZE1wOUhBRm5nT1ZneEdtWm5kVzZGc0V6V3IyUFY3dlFFZXhj?=
 =?utf-8?B?VTY5L0RKL2hSNHJvQU5JUEx1ZEdkckhOMDBOeDVVTHNpUlY2U1pNNUM3Y2lZ?=
 =?utf-8?B?akkrWnF3dndxVU5yNTRDMTgzZ0ZWWDdTRVNDaFYrTUEvZkVCbWpPT3RHVHRX?=
 =?utf-8?B?MHZ1UEtsVlNRZjYvUE1UaHZxdlBNdmR3ZEVjckFPK3V3Rm5wQmI1Zm9kdWtI?=
 =?utf-8?B?eXNYYkppNEdmL0xrVjRnUkF1bFJjbzFmdlJEd0FoZzNnbU1oYW1peUZyL2cv?=
 =?utf-8?B?eTI3YXR0MmJOU0JHOEpLWU8yd0JibzFEZGlqZWF5RXZ0cTZnSU41S1BqcENT?=
 =?utf-8?B?RjlPV1BLdGxvWU8zSWR3L3hnRmVvVG9vMURlU2JaTVc0NktwdzdUZVVZNllH?=
 =?utf-8?B?NXVsUVczcUhERzZoT0RldzhYT0hocUE0aE1vUjZmY1F3MmxpTGtJYUZsVWpZ?=
 =?utf-8?B?ZFlUQVlLN25iQ1FsLzlBMmZWOUhxRWpvZWpHT0lBdEV5T2EvSWdaOFhzWnVu?=
 =?utf-8?B?M2MxVkVJczZGNW1aTzlpeWtOQkJuVmJpWWdUbHYzbkE1SDBCOUtQWmovWlRz?=
 =?utf-8?B?MjNVRjZwOEE4UXZEWlNnNnkrWTRZZ212MXZrVUg0RHoyS2h5VkxsN0RJR2Mw?=
 =?utf-8?B?VGtXSm91M2MvcjhCOTZ6eFpFTURVNHRJd0tWVjhuRzBWRFg2eENiT2tPdWFV?=
 =?utf-8?B?NHF2VVdLYmZkTGdRbnJmS0tNWi9TcTFPaEpDVDJaVkxRckNZdXhXSUt0MEN4?=
 =?utf-8?B?b21Xcm5od09hc3A0RHhMaVFqQkhFbGZBOEdaUjF5VUhBUVVFTzl4Skxpb21x?=
 =?utf-8?B?eExUSjdrU054MCt1eGcrNDZxMlFnZU9SZ3ZBekIwNUp0OXZoZDArWlRLejYy?=
 =?utf-8?B?YXJLS1R4UmFjZ0dQeldkdjEyZjQzOVlsazZsR3FLMFQxNDRLTndwSFVub1JN?=
 =?utf-8?B?ZlFRYkZTand5a0lKb01UOWxwT0ZWcDNLTGQyR3o0SE5tSTF0eVV0ZGMrWXVK?=
 =?utf-8?B?UHNxR09PY1lKcXlhT3BHYVZBdk9jY0IzSWlMZWs0dk4xVStnV2oxN0lhd3kv?=
 =?utf-8?B?czY2dzl6QmlaUCtva01YNmlWeFNGZkc2RmtMTXQzSy8vbXQybmJyTTBSZitp?=
 =?utf-8?B?N0wyMERHZllpNkdGampmb1hRV2phek1QR3FDUndFUzIxM3RrOTYwaGZNT3lK?=
 =?utf-8?B?Tk5NTVludVJzQUdMOW53VmtLU2puYkEzcUtJR0dNYUVYZmdZZ1Nhc2VoUnZR?=
 =?utf-8?B?amZsc1AvYkhWV3FTSWNCQTdJOXhCZ0szQnVJb2dwNnIyQ25wMThvUktEVnJB?=
 =?utf-8?B?cU5wbjJOUHFTWXN1OEZWQ1MxcEZIUjluUWNOc0EzZWF1SE43RC9ST3VCOWRl?=
 =?utf-8?Q?cNOgjUuPkV5IExzVDbtJBUhHgtH+a4idmksqWx8?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69453715-b438-4816-03f3-08dc305a945c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2024 08:21:17.5484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5113

On 2/18/2024 4:03 PM, kernel test robot wrote:
> Hi Yang,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on 8d3dea210042f54b952b481838c1e7dfc4ec751d]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Yang-Xiwen-via-B4-Relay/mmc-dw_mmc-add-support-for-hi3798mv200/20240216-014744
> base:   8d3dea210042f54b952b481838c1e7dfc4ec751d
> patch link:    https://lore.kernel.org/r/20240216-b4-mmc-hi3798mv200-v1-1-7d46db845ae6%40outlook.com
> patch subject: [PATCH 1/3] mmc: dw_mmc: add support for hi3798mv200
> config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20240218/202402181540.H4Ose96P-lkp@intel.com/config)
> compiler: hppa-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240218/202402181540.H4Ose96P-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202402181540.H4Ose96P-lkp@intel.com/
>
> All errors (new ones prefixed by >>):
>
>     drivers/mmc/host/dw_mmc-hi3798mv200.c: In function 'dw_mci_hi3798mv200_init':
>>> drivers/mmc/host/dw_mmc-hi3798mv200.c:178:36: error: passing argument 1 of 'mmc_of_parse_clk_phase' from incompatible pointer type [-Werror=incompatible-pointer-types]
>       178 |         mmc_of_parse_clk_phase(host->dev, &priv->phase_map);
>           |                                ~~~~^~~~~
>           |                                    |
>           |                                    struct device *
>     In file included from drivers/mmc/host/dw_mmc-hi3798mv200.c:11:
>     include/linux/mmc/host.h:542:46: note: expected 'struct mmc_host *' but argument is of type 'struct device *'
>       542 | void mmc_of_parse_clk_phase(struct mmc_host *host,
>           |                             ~~~~~~~~~~~~~~~~~^~~~
>     cc1: some warnings being treated as errors
>
>
> vim +/mmc_of_parse_clk_phase +178 drivers/mmc/host/dw_mmc-hi3798mv200.c
>
>     168	
>     169	static int dw_mci_hi3798mv200_init(struct dw_mci *host)
>     170	{
>     171		struct dw_mci_hi3798mv200_priv *priv;
>     172		struct device_node *np = host->dev->of_node;
>     173	
>     174		priv = devm_kzalloc(host->dev, sizeof(*priv), GFP_KERNEL);
>     175		if (!priv)
>     176			return -ENOMEM;
>     177	
>   > 178		mmc_of_parse_clk_phase(host->dev, &priv->phase_map);

Please note that this patch is depending on another patch[1].

[1]: 
https://lore.kernel.org/linux-mmc/ae876e697ba16ba2925ec217c6b4e3d8ffea4ab3.camel@codeconstruct.com.au/T/#t


Ulf, what do think about picking that patch in this patch set? So that 
the dependencies can be resolved.

>     179	
>     180		priv->sample_clk = devm_clk_get_enabled(host->dev, "ciu-sample");
>     181		if (IS_ERR(priv->sample_clk)) {
>     182			dev_err(host->dev, "failed to get enabled ciu-sample clock\n");
>     183			return PTR_ERR(priv->sample_clk);
>     184		}
>     185	
>     186		priv->drive_clk = devm_clk_get_enabled(host->dev, "ciu-drive");
>     187		if (IS_ERR(priv->drive_clk)) {
>     188			dev_err(host->dev, "failed to get enabled ciu-drive clock\n");
>     189			return PTR_ERR(priv->drive_clk);
>     190		}
>     191	
>     192		priv->sap_dll_reg = syscon_regmap_lookup_by_phandle(np, "hisilicon,sap-dll-reg");
>     193		if (IS_ERR(priv->sap_dll_reg)) {
>     194			dev_err(host->dev, "failed to get sap-dll-reg\n");
>     195			return PTR_ERR(priv->sap_dll_reg);
>     196		}
>     197	
>     198		host->priv = priv;
>     199		return 0;
>     200	}
>     201	
>

-- 
Regards,
Yang Xiwen


