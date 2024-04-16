Return-Path: <linux-kernel+bounces-147765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 904458A795F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 01:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7C8BB22D8D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FEE13AA44;
	Tue, 16 Apr 2024 23:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="m0e0OL5p"
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2093.outbound.protection.outlook.com [40.92.102.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A25113AA2C;
	Tue, 16 Apr 2024 23:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.102.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713311601; cv=fail; b=TnuxF4fLAPr1belfOZxJrgn7s/IGhoiHe6ng7aS+VxkEcC+27wtTKL4O+wV5BFS3KdCHhU24r1XeALYNffCgOECKmZgKZO8Yv32aRGRucjCS9X4G0Gd43fGj7TqgQSck1sIjyLgDVYY8/PykNj8rVstky2hm2+PJDEj5gzburwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713311601; c=relaxed/simple;
	bh=0xpkmCSvS5GaxhKOCxDU9VlEPJ321VhCa7DzdtauM6M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nGEAuRf6bW1YHH9ZWUmAiW+VISjsA53YqXUwMzBgQgD37UE2kzxX+Tsc+EjebKfg689cDAFHcF5Kn7RowOm2sgE6j8MHIcznmOnobKrdd2y6uack0iPEcul8lWUMs7Oka4IFrnqv2nhK6XMSA80mteMNX90qkPGDB8yReWLbf8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=m0e0OL5p; arc=fail smtp.client-ip=40.92.102.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=II5pv2yMkLqO46du7BiwvqMVmLb846EcZUOQgNuAbXDaH03So9+LW0rBfF/WLewgG0dStYk7CPKd1ArqRj6sByBAVL9ch4cZlXrdAHt8qoXUjkKa6koI/Nae6KGzqWLf/HOfxKl4Zb9/QJFi8PD6GWq2bMSjimXFOhMET8DU2qgKfYz6zPKZ0/bsCGQ9OdiSp+bjLScszkkaO+etx8B1ZNnRnDctjyyC7MK0ofArK3fmwCUaxUVfPxQhPfdwVyZda0Yxk7EoC3O8WYHf15Fpr4OzC7OCuIQ9Kjk+i+Cv/5aLxe2jVR8P2JZBIoEdmOnS8kk4oCVMwkNLKIAjci7k2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MIvRWIOZNYc1YQjMUB/y5I9aaYtyFift4nEnGKBx0Pc=;
 b=lH1QHf2laovJLXdO2dMU04KCJwqVctSp41wmdRtrHZuY4BAcOhstnGHDJOQAorKuMEdE37vEY0TsNZxDXxEGmlTHus5H+6bljSpW4QiING5faclmrXgum0Qr/Oz99XkZ6s36oiP3gEwChcqRWlg6RkMj3vZhMfx7CvkNI+x8bqLLDQEFvlRPwOyFmN3VD0l8I0vzJkJ+pdT9bij8kIUcHsWJTFGZKYrsmq8NfmVMVWVedesNglsK9NdCOzUW2O7KIU3GMY72nEQRIWjREP9b2cCj8CA/dB+8BiTiQQRHUL0a8I5EaIh9ku5eKdabIPy1jow6idMF6aO/haYVtRWoXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MIvRWIOZNYc1YQjMUB/y5I9aaYtyFift4nEnGKBx0Pc=;
 b=m0e0OL5p0JB2yJNPm/2u/T9V2ELNsjwoJqDdyFNqXKPI9sWrVA//SGHmloChXv4MZsq6frFcmPaLQ7Uhx1T4ZR1mnc/o583E+KGNEQ9qS02lCMhcQKt9hmsSoeVqRclWZcquUMlJ3BAc6UOJbrox8bsvCO7GxVQERGRY4QvvrJm95eQwye50Y9KGMedn01TxxmuyL2+yhR2AipyPdMRApP3r4EhKoXQhXu32zek4Iy0smZKTMkYapFWE5bSShkAZNJLlTqSkE0sjpdipwXVjOfYc2wEu3KvoAGMpR9QCAFx15a1QDlXWuL46SwJ8ytFlf/aTIfUW61XkmCtnF0k6Pg==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by MAZP287MB0558.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:112::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.51; Tue, 16 Apr
 2024 23:53:11 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::664:2ecc:c36:1f2c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::664:2ecc:c36:1f2c%3]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 23:53:11 +0000
Message-ID:
 <MA0P287MB2822A5D78558176D9B23240CFE082@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Wed, 17 Apr 2024 07:53:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] mmc: sdhci-of-dwcmshc: Add support for Sophgo SG2042
To: Jisheng Zhang <jszhang@kernel.org>, Chen Wang <unicornxw@gmail.com>
Cc: adrian.hunter@intel.com, aou@eecs.berkeley.edu, conor+dt@kernel.org,
 guoren@kernel.org, inochiama@outlook.com, krzysztof.kozlowski+dt@linaro.org,
 palmer@dabbelt.com, paul.walmsley@sifive.com, robh@kernel.org,
 ulf.hansson@linaro.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-riscv@lists.infradead.org, chao.wei@sophgo.com,
 haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com, tingzhu.wang@sophgo.com
References: <cover.1713258948.git.unicorn_wang@outlook.com>
 <e5aa1338d74504e141ba833b484d588cafb7ab38.1713258948.git.unicorn_wang@outlook.com>
 <Zh6bM2EQnAFYFhiV@xhacker>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <Zh6bM2EQnAFYFhiV@xhacker>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [tHilUJJeHqepzmerUrJyU0QckXI3onGW]
X-ClientProxiedBy: SI2PR01CA0010.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::12) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <df6c2ce8-b956-4f1a-9bb6-8f207921ed78@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|MAZP287MB0558:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c792ea2-e148-4491-1493-08dc5e705dfe
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MaYWgKjdnYxiCFW0cSSDQo4CsQniJgAWPPFNokfaUWGHy3mtlqftBhLicRMX9mENk/Ax1E/grylHw5l0HvVW7QHrETh2Q9qRo28U3bRN7COzhhBqiCF7+n4XdZVfMLjVHXv3ZUBkvmoUVgF9zNXdv8rCKWNbw8zWu0+OAE6L/Vg11YB/hZzTQlcpJB2ywRUsWYmXWCUJhpt0dOA4fp0BVkTix0bTTkTP1WKcc/2H834XDSbN7r1qy4/b6ZxArhk5AYRbqv02zhXwGSE9LT0un2D1G1/tXUL/QEAnm8cpPAQmnFEK+BZKsgcZv2vdrDenK8AR1cS7w/G67VWonIOEeAN97NGkUXG6dSsB/hktsryVbWNxVDIQdUiLn8oH4nKxYb+4QL3XjymI80Yl3p8uiR8tSYE2+Jrb5hhCFVK70quaojH5SdN8XI35LDxx8/sz8JwZDsnzT7zqKR6cv2dCsd0bcPiVTkmXtCCoI74xQHzUPy8sH/qIZN802E2Q5H8dM7+b3pg39TAzWf4d3ErXiTyLudWYEoNIumWW1lUTfG/s59IATA7eFEyxhYSGpdMg
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVR3MmE3dmQ2c29oRnhiOUlIYWs3b0k5TWUxNHVlbGE2TTd2VlQ4OE5MRlJZ?=
 =?utf-8?B?bktBSHQ4RFZBb241Z1BBT1F1aWJhVFNLUElDN09Vems5WnNZTXhaUUpBMko1?=
 =?utf-8?B?S01MZTh0bFJOY2ttMVFGRlR6N2FzeXF1bG0rVDlpQ3FpdU56WXUrcC9hRkF6?=
 =?utf-8?B?eFNoNHVKQmR0WUxCeVBjMzlCeCtpOURxOW5xTW1mVW1xdHBoYWwrK05BOWRs?=
 =?utf-8?B?UW1rU1FMbUxhU21QWlgrRDU1T0pEZ1Z1Y09yVHZMSXBtQVNmcy9lZFRKYzVh?=
 =?utf-8?B?eXJHVTYxVi9xaTBxTjdMQWZCZVdKRzhBL1pSSllMQUZxZDNCeTlxalNyU1RF?=
 =?utf-8?B?amxPR240QTFOVDMwaTRaRVE3OUpGbkFGZ3E1TDZNZzI2NWRhUkxDTW9Ca0RQ?=
 =?utf-8?B?TEx0RlpreVlLZVEyWGFadU9iN2tHUElreHA0VmRjK1dVTE9OaG90RFdzRGNL?=
 =?utf-8?B?S2NVRU5FcTVoSEF1M2lpdnJHUlVBazJONWk3ZDdUMHIyVERMTjU3MnV1bVlZ?=
 =?utf-8?B?a2tNNjVxMHgwQXZ1VVVSeHlnb1ozcjNxaFRTTHhJb21xVWRSZWx1VzZRSW4x?=
 =?utf-8?B?bldRN1FCYkRQazdXRmtLa2h6R0c2bmdtZDlvOTJCOGs1SkpvaWRRV3ZNWFdu?=
 =?utf-8?B?NUg1S2Rwa1ZqVWkrenJhS2tDb0ZKVitqR29BcXJMVUFTY0lwaWVIZmYwQWs5?=
 =?utf-8?B?UVlnL0paTnRrTW1pQkNsTElvTXFzaDZ3VW5FQURkRWI2UEcvWDV0ZkkwTjZU?=
 =?utf-8?B?MERlNHN6dTR2YnlEbEsyV3FiR2tnZnNPU25kSGNSQmdwempOUlhkdW9IY3Bv?=
 =?utf-8?B?TTRXY0lTRVR6RFE0YWtsUk5nZGczWE5IcnFRSzBYRWZVbWZRRWErUDZkQ3kx?=
 =?utf-8?B?MHpaVUZ3dDh3dFJXejR6NHdyWUtyWXlnbmhwR0psejBWQkVJS0E2aTYzQ0ZI?=
 =?utf-8?B?V1dDV0s2ZysvdVVvVGF5QzZacFV2NEdtY29xK0ZveklBYkJBQS9ZazliR1VL?=
 =?utf-8?B?b3lSbENXNlQ5OEdMQlJIM3ZjeWtxTEF2SXJocWdNcHFhTEJJSGJjKzU1ZmJ2?=
 =?utf-8?B?dDdqV1RZZm1VcVcyNmhqUHgwVUFGMk42L1FFM1ZBZ25MMFhlWXJ3VEhCNjU0?=
 =?utf-8?B?bFZGY21yK09oWmovRklpVjFSSnZROHhrenhuVDE3Z2pSOWJ3VGttUzZYQytF?=
 =?utf-8?B?bDV5dVJ0NjJrKzIxaW50RVNDcmRtN2NKSHdieHNVb1ovMVFPVjhsLzV3eFZX?=
 =?utf-8?B?YkxmbzhGK3Z6S2taMEpvUXBUSlFMcytiVXV3aDRVcFU2OTNWZy9vRktueTRw?=
 =?utf-8?B?cVpzS2hTbmV5UFlhZ3I4Q1RYS0dwV1Q5Z29IVGpTWDh1ZTZHNk9KQzJYZisz?=
 =?utf-8?B?bEQ3UWI4YXUzaTlJWjJrcnVKeHE3dHVyY25MdHo2YlltT1ZNY1NLMWM4YVNn?=
 =?utf-8?B?N2ZYblFqYk4wODRzK2wrWURQb2xQbXAvUm9qZVRlZ2dCRHZqZ01OaWUrQWFX?=
 =?utf-8?B?cWJwZXR3N1ZoTnpEUUZ4c0IxMEo4djRHMUZieStVYUc2ck9hMmNSU2hUajhX?=
 =?utf-8?B?RS9oNVlQemFnYUV6WGdkTWxxcVp1emRRd0FVYkNLQ3R6d01PT0dFdVUvTXFP?=
 =?utf-8?B?bGYybEhsTXRQQ3VhZ0t6YnFSWENpcHZwekNWdjBONFY4Y25tYkhKZzhURDQv?=
 =?utf-8?Q?26SG5wgKwnirN1o40/8n?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c792ea2-e148-4491-1493-08dc5e705dfe
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 23:53:10.0954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZP287MB0558


On 2024/4/16 23:37, Jisheng Zhang wrote:
> On Tue, Apr 16, 2024 at 05:50:57PM +0800, Chen Wang wrote:
[......]
>>   
>> +#define SG2042_MAX_CLKS 2
> I don't think "bulk" is suitable here for max 2 clks, no?
Without "bulk",  I have to prepare/disable two times for each of clocks 
and handle the exception if first one failed etc. I learn this from 
rockchip, it has 3. Why you think it is  not suitable, please advise me, 
thanks.
>> +struct sg2042_priv {
>> +	struct clk_bulk_data clks[SG2042_MAX_CLKS];
> useless either

Sorry, what's this mean?

[......]

>> +
>> +	/* Set ATDL_CNFG, tuning clk not use for init */
>> +	val = FIELD_PREP(PHY_ATDL_CNFG_INPSEL_MASK, 2);
> magic "2" needs a meaningful macro definition.

Agree, will improve this in next version.

[......]

>>   
>> +static const struct sdhci_pltfm_data sdhci_dwcmshc_sg2042_pdata = {
>> +	.ops = &sdhci_dwcmshc_sg2042_ops,
>> +	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
>> +		  SDHCI_QUIRK_INVERTED_WRITE_PROTECT,
> is "wp-inverted" property better?

Yes, l will use this in next revision, thanks.

[......]

>> +
>> +static int dwcmshc_sg2042_init(struct device *dev,
>> +			       struct sdhci_host *host,
>> +			       struct dwcmshc_priv *dwc_priv)
>> +{
>> +	int err;
>> +	struct sg2042_priv *soc = NULL;
>> +
>> +	soc = devm_kzalloc(dev, sizeof(struct sg2042_priv), GFP_KERNEL);
>> +	if (!soc)
>> +		return -ENOMEM;
>> +
>> +	soc->clks[0].id = "card";
>> +	soc->clks[1].id = "timer";
> Interesting, only "card" and "timer", so which clk is for clk input of the ip?

Copy my comments from bindings patch here for quick reference:

 > SG2042 defines 3 clocks for SD/eMMC controllers.

 >- AXI_EMMC/AXI_SD for aclk/hclk(Bus interface clocks in DWC_mshc)
 >  and bclk(Core Base Clock in DWC_mshc), these 3 clocks share one
 >  source, so reuse existing "core".
 >- 100K_EMMC/100K_SD for cqetmclk(Timer clocks in DWC_mshc), so reuse
 >  existing "timer" which was added for rockchip specified.

 >- EMMC_100M/SD_100M for cclk(Card clocks in DWC_mshc), add new "card".

What you meant "clk input of the ip" is "core", right?

[......]


