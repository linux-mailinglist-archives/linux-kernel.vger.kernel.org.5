Return-Path: <linux-kernel+bounces-35610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB078393FC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9223F1C26387
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D2B612E8;
	Tue, 23 Jan 2024 15:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="XY5lowT8"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2019.outbound.protection.outlook.com [40.92.107.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B155F552;
	Tue, 23 Jan 2024 15:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.107.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706025561; cv=fail; b=PbmAlAzbaqGWzvvlzamS5rqaIXn7EOj/E7ruLjLV9loz6a4lIgg7zdm8dZx4kUhDxIYPudJnlknfzKre3asdwQJtguhjHHWukCT+JyCdnx/0iiN4XwfU3gBVOD4OTRsnVihLHVJQf3fpXMkh9wn7dL910s+2LHhqPa+/TwqTKfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706025561; c=relaxed/simple;
	bh=MXYQObWui1fMZC5TZPTrBCxevlx7zBjirZCKO9+TUwg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=faP8E4PH/Oz3XBr5JhpeZrchmiqDP4H+ydcH0hSXHv0ISr/p81SfDgqvJ6QJYHUygYaKs56SokY9lyHQ0gJ93pnp2KFPcVeP0RDZp1vclRctrSgV0d2QzbacBekZ7e1sMb+069Ipqt2dsAturACS4yivLLW0pS4gUozOH23PI3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=XY5lowT8; arc=fail smtp.client-ip=40.92.107.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=agNgPqcDFiiw/yX5j6G8Z9Rj5X43OCPatgS06yXuKYGebSxLSWcUt7SdZhl0E+oOQ8qIYqWL1Tt2RVVWlclHGgYEw8n0BG6Ju2PynsJRX1RLDGXIXLNP10quSThpTQPSwZkIxEWnCXqepljd842IOh4ndnI0sGd9gTjdLAWQqt0ut356oKcOnaKLALdlIcriNug/KOMSmSXwTEbqxFbWXV/hlgkSGKzTwlCHBeASzpC/FcTBCQLwXX211FGfXXBlgdxBW/40wmAVUGElOQ7BVR5f9mMWCjpsQUG1Ak/rWj+xjcBa4N16TdVcMBYCSY+ySawthrA98azO8+lUUYWoFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1LQR2p0Ri0VFR2HWbWfrx/fjQaSf+EZG2/aQ/SHpexA=;
 b=jtRWQycDGvIkQi2qW4nMjITGMqmYQ5eebDc+tu4FYJAVzt67GiwfLDFyOuOMsZWZVoUwV3xjqLHKrOqT6+jy8F9r2nYEUeRgi0SuDXB71FtC0F7gBdATevZN8WXpF4b7LlIvnF4Xq5gK8qEuvR4mU7Vihl5YivQ+uPKmolOtJAZTYIACRB0AvFPpzpkJGa9tijHDQXA9k4TD6/JvvSnu7G0a2LZRYY/GhBkfG4/u1BIHF7KoGzL0DJ/04L5twG26Ewgo/8JclNH6qugBW9uXcJ4ZoqulrAEyjlE840YkvAE7w9jp4WrdmPYXSgKaqntyuUBfpVdzNsaey8Pgjl9OYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1LQR2p0Ri0VFR2HWbWfrx/fjQaSf+EZG2/aQ/SHpexA=;
 b=XY5lowT8vQjivCkPprFAIOa9JMN+B9Xpig/Qgz5T4oHR58sD4sSlHpTk5NzAlIakRLk/UBKUrc/RNBWJ5yBreKEgqaza9eOTAoqnubX/t/w7ZC6BjJOTRQAu+YdQALVXWiWRj9Viqz72i/YIoF2oWX0kMMA5WvNtbarhrlJIpBrlnTOevNtsJK+lQk4H+sb1vpBEOUowAArD3/C9pGgPlX6P2otqTYgg9exqC/HmMRXej4RQPsATPR8CtvgSjLFAn7i8LCY5uAmMN4bTotMeOZoIhN3hHMNhkZRmZZofparwEQN9PEC3mVkYhIxOm+XEPv9Lj0cbXBFW3LT2e3HB5g==
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9) by TYZPR01MB6330.apcprd01.prod.exchangelabs.com
 (2603:1096:405:ae::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.36; Tue, 23 Jan
 2024 15:59:15 +0000
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::a639:b02c:5189:7140]) by TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::a639:b02c:5189:7140%7]) with mapi id 15.20.7202.031; Tue, 23 Jan 2024
 15:59:15 +0000
Message-ID:
 <TYZPR01MB555648886D03AB911224F6FAC9742@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
Date: Tue, 23 Jan 2024 23:58:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] phy: Introduce Qualcomm ethernet uniphy driver
To: Andrew Lunn <andrew@lunn.ch>
Cc: mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 richardcochran@gmail.com, p.zabel@pengutronix.de, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-mediatek@lists.infradead.org
References: <TYZPR01MB55563BD6A2B78402E4BB44D4C9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <TYZPR01MB55568ACB534944D7DEB00C7AC9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
From: Ziyang Huang <hzyitc@outlook.com>
In-Reply-To: <TYZPR01MB55568ACB534944D7DEB00C7AC9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [8lCv3zEj6h8yEKESM/B8CxmzyO8q/KbC]
X-ClientProxiedBy: TYCP286CA0343.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::11) To TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9)
X-Microsoft-Original-Message-ID:
 <4f3f8059-d280-46d2-a400-5bda4c654fd8@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR01MB5556:EE_|TYZPR01MB6330:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bcceb14-649c-41b3-f96f-08dc1c2c3fbe
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tA9BmN88n/EUMJkbzif7uNu3qa7ON99vcr1LUJLoRNRf6D7DtqIzXpKB3CmWuRms1Ng4OzaR0w18Wc+ajw46VxWxZCWuz4oIM2CDxuUj/8hrO4JHXvpSH6LYlrAyuvvCMdqrAtL+zWL/1Kmv2EJBOj4ub3zhV1gWqLXEAe+pauoUr59XRkiYeOgQP1KJF+0sKYWp1/K8dfsDk/FjazMUQCvrLApZLh5197HprawPljrt9CIOCTWGwMvJ7WepVfgtgq8oQHGW2/YGPSnsvUJTOMQ/WhtwKWpBBio2twLAExbkeRXtBeAfOsCgo1GVOc3Sig9AHEFE0G53yxfIrehcloW7D9URDq8MnYJIX6rhyFHbF7jtuKKw/uAmFgkzTUhnCifXwTWQLwQXm61E4adwS3KgpAUWohU4euvAixXIYZM08MerB9bJxb21iHfpCKonTaAa/qAGPAQg7eKjPmjyeo8HSNpnsU1yNyelFmEw9sesZ9bL6S4KrfhQhFtuwK7HXkLsiSmEUyWlZ8aXpIsSUDMs6cy/u5qlXpeahYZ/tjVoPaeEqlNOFf5/4IvJgoEc
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3MvalNxd01uZzZpUU9pSk9DSjloOWc5bUFPbVozbUJ5MTZOM2JjQVVNZEFB?=
 =?utf-8?B?b2szMCtOWFFaVTMrZzI5bnY5NG5TZkNNdFpGYjBCa1NMS1dKeFNjaHRPeHdH?=
 =?utf-8?B?UnJSSTVtM241MVNhbWRLaktCdWF3cGZLRjRXSS9FRi9QMUVGSW5jTFM3R3R5?=
 =?utf-8?B?ZStDS2ZpQmhSc3V1VWRkbGVQaitjSVN3by9PNnVacXBvblpGcVptdGdWc2FE?=
 =?utf-8?B?SWF2QXhIR3BhVHVzZ24yd0xtQjUvTzkvWThyQUY4ZjAvL2ZNNVRKSVBrdENZ?=
 =?utf-8?B?NEJKNDF3NzVKRXRpMU55dFZDWlVBUzR3UzgwOUlRMGtyNERHay9hblBFU256?=
 =?utf-8?B?UG5YcTBsbWVqcVFMUG9oLzJSMm1zZ0h1Y25iSGFicWVhU2xnRmh6UzF6ZEpj?=
 =?utf-8?B?QW9acWpvWW9yRkwzaTdQVHlWSHJ6Y0xySUd5MlVpbyt0dng2RUEzeFc1YlNw?=
 =?utf-8?B?VWI3Qkg1QWJSV3ZNWk5sbDMrYmMxenM5YzZ4TVZHMTZhY3daSlNlc0pralJV?=
 =?utf-8?B?cGZROUxJV1ZKdytudXB0WXNodG0rRHJyb3dXWFBDeUs5MlFaUWVDUmY3N1l5?=
 =?utf-8?B?SlF1ZmZuVG9ZcmhrTUI5YWppRGpPTkc4R2s1akFJaFZzNlBmUU5DZ0NLL3Bq?=
 =?utf-8?B?cThsOTBsTXpoY3VEbjAwMmgrcklJTGh5dlIxZWN5YStOWFhmNzNISTJiOHN4?=
 =?utf-8?B?eW5JZUxVcnQvb1lxV2V5RVlPUi9IWmkvQjFrV0w2SWFKd1VucWthNFlIQjFw?=
 =?utf-8?B?cHhDVm8xTTh6WUVyQTFwSXNiSm5vMzR3b0NMVlMrRmFoVGxQUzhrVjA4cEVY?=
 =?utf-8?B?emlKZExCbm1ScXJKNzNuRW5GVDdJU2hUVWd2NHVSQU5pajVmdDZ0OEphTm5F?=
 =?utf-8?B?RCtCSVhOSGlxUXNLbGw1UUU4RFNoaEZiVVhYL2Rqb0FtelJpeklzSlcyV21l?=
 =?utf-8?B?WkZ1S2hmVzJvMTBFRlo1S3pCc3BjQUR3UmJVWUY2czdvZzVFVEJrc2lkYnZ4?=
 =?utf-8?B?MEpORUlaVEpLS3U3eWhKdmxiNlozcm9LNS9PdFlpb3dUVnpCVUowb3I3THI1?=
 =?utf-8?B?MVk3eVRDVmhjdHNQZ3ZCRm9IUG5pQUZUU2tvS1lwOVZsbnEwckhuOUtka0p2?=
 =?utf-8?B?dlphVWpKOW54aTh0bXgvdjV6cXhPOVVaZWVtb2hSNDJTNk82R0FYcmJCSGVz?=
 =?utf-8?B?ajVRRTVUSGdSWG9MRjFJak1CVmdlaUdwWGJtaURYandvc3J3TXB6QjBvS1dP?=
 =?utf-8?B?VDZqYzAydHRBbWpuQ0pIdmM5ZDhJL1J6RHNpVk1BRS9BMDJWeXJvdFoxZ1dD?=
 =?utf-8?B?VWlYMEN3Ynd5bDVoakNXNkdCOUxIZmdhaVVaR3BnRE1ob0I1Zy9kSjBFVW5C?=
 =?utf-8?B?cEMxclNrZVIvWk5nL2hSb3drT0ZkQmtOdmhQM1QyWW9ESEx2OEpnbUUrR0Q0?=
 =?utf-8?B?cHYxYktMY0R6WTVMYkJyQ29yMVYvUXpNdWlzSFdTbEM5ZmF4YUxhNFAyTXEv?=
 =?utf-8?B?eDBNVjhyNFR4d2t3OHZ1THcyV0dDSDRrUG5jczZveEtQemFSVlJrR1RSUm96?=
 =?utf-8?B?VXNaRWxqdnV6cEUzbFRBekx2ampveU90VlRSMkp4alRpc1V0RC9GZWYwcVhO?=
 =?utf-8?B?aXIxem1KSGJQa2FmcDMvY1dVMnBScnc9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bcceb14-649c-41b3-f96f-08dc1c2c3fbe
X-MS-Exchange-CrossTenant-AuthSource: TYZPR01MB5556.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 15:59:15.4681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB6330

在 2024/1/21 20:42, Ziyang Huang 写道:
> +#define rmwl(addr, mask, val) \
> +	writel(((readl(addr) & ~(mask)) | ((val) & (mask))), addr)
> +
> +static int cmn_init(struct platform_device *pdev)
> +{
> +	struct resource *res;
> +	void __iomem *cmn_base;
> +	void __iomem *tcsr_base;
> +	u32 val;
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cmn");
> +	if (!res)
> +		return 0;
> +
> +	cmn_base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR_OR_NULL(cmn_base))
> +		return PTR_ERR(cmn_base);
> +
> +	/* For IPQ50xx, tcsr is necessary to enable cmn block */
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "tcsr");
> +	if (res) {
> +		tcsr_base = devm_ioremap_resource(&pdev->dev, res);
> +		if (IS_ERR_OR_NULL(tcsr_base))
> +			return PTR_ERR(tcsr_base);
> +
> +		rmwl((tcsr_base + TCSR_ETH_CMN), TCSR_ETH_CMN_ENABLE,
> +		     TCSR_ETH_CMN_ENABLE);
> +	}
> +
> +	rmwl((cmn_base + CMN_PLL_REFCLK_SRC),
> +	     CMN_PLL_REFCLK_SRC_FROM_MASK,
> +	     CMN_PLL_REFCLK_SRC_FROM_REG);
> +	rmwl((cmn_base + CMN_PLL_REFCLK),
> +	     (CMN_PLL_REFCLK_EXTERNAL | CMN_PLL_REFCLK_FREQ_MASK
> +	      | CMN_PLL_REFCLK_DIV_MASK),
> +	     (CMN_PLL_REFCLK_FREQ_48M | CMN_PLL_REFCLK_DIV(2)));
> +
> +	rmwl((cmn_base + CMN_PLL_CTRL), CMN_PLL_CTRL_RST_N, 0);
> +	msleep(1);
> +	rmwl((cmn_base + CMN_PLL_CTRL), CMN_PLL_CTRL_RST_N,
> +	     CMN_PLL_CTRL_RST_N);
> +	msleep(1);
> +
> +	return read_poll_timeout(readl, val,
> +				 (val & CMN_PLL_STATUS_LOCKED),
> +				 100, 200000, false,
> +				 (cmn_base + CMN_PLL_STATUS));
> +}
> +

Hi Andrew,

Sorry to bother you. But I can't make a decision here.

The CMN block (Seem like the Abbreviation of "component") controls the 
entire network block. It need to be configured before uniphy, mdio, 
gmac, etc.. In the past, Qualcomm put it in mdio driver. But UNIPHY need 
to been initializated before mdio because some PHYs/switchs use the 
outclk provided by UNIPHY as their main clocks.

So it seem like that it should be described in a separate node. But I 
couldn't find a suitable driver directory for it. Can you please give me 
some suggestions? Thanks.

