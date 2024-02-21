Return-Path: <linux-kernel+bounces-74722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2090385D83B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A04111F22D44
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E0E69946;
	Wed, 21 Feb 2024 12:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="OP952Y0K"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2020.outbound.protection.outlook.com [40.92.107.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B068F3EA7A;
	Wed, 21 Feb 2024 12:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.107.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708519726; cv=fail; b=Rxt43KH9ThfUEJZp0MW4PQI5jGh8zrZh2o2tK2ucxRCt0qdBZXwJW9EuafSR7Y8vGN65drP1mYP+5C9VQ4/ZOhsEMKYJep21b/PrhxkMD30E9NOWRqXYX1a69iOufAOigednkBmv4VSWZVz78K4TLJ11KFym8+bDSozXuc8EHXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708519726; c=relaxed/simple;
	bh=AoK46/r6Z7XpY4RRiIR3w1ALFi1kKs8ofDQT9gnYjAA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N+lx6izT0JASt41+5DV5ucjE6efGkVS9JF1BPMgANeReolkPaD6I3fnXthHK6681bs4RZW35+pMB+zu1Ht94mbHZZzNrXlHZWv/stgAtlm4EukUx1yMJ6wlRc+rmVKwp95VdJbORP5mz4R9saewG3wJ2XHIgMLnRmRSfLGXan/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=OP952Y0K; arc=fail smtp.client-ip=40.92.107.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HU6TW+LAmd9UZ9f9U9MAztiKDeWVn3ClYbcyibEDXUzH4eszkTdbj27T3N1BseCIx60gFxe2vmOUFQ6nbDAuPC9N37v+W+4yxRTzwzqnytyTX7Ivuq5sdEoxPLskts5RYoWYbwDOfPtkLPimZKKKwGqKOm3lzTJsofGBfjRYUvgnRCGyoYLvkQ4HXAjEMyXXrUG02eauSB08EW6UoMuh9GDhvh66hyL2SPy9J43XwRlUYZg7oK7mWboWDj7T4aI9TBzfl94KNSwiS4GMq8ga2ZQXhyPPclHexPyd2GFEj/F60cT38VtanjqiNBaquMbDe/y3ODTzebqwe6KlYSlrLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBpQjQJ7mbmLeoVKRu3vitTuzjyyAuqnmfOXzu7vkYQ=;
 b=fupmacuqnlKQsANY6FtmLdVNjbGab7jKiiW+9SZABUsohGvIxhgrMc14oSuhZxZunmCMXGrJT1gYY4j75vL3wB85AlfDWHn0ew7D8zYDKiw/jTHPfAC/629OdEAkGXm7jhxU9c269tHpdAfmKvpIVaOg2ezKnufPaB052caWi8ibrKqJH7LsCwcXYo5PLmKvDYQRCVTdUbe6RTMbolr7kj5hvhDYsXumbvLsKcsdRdBEccZumEN6rZHT2MgaMqb35SfN9aWjpAAAQTN+SJcW98s/trRsaWcMfgfcXQe+rPkKeMWr7jp0LU9dDcXS0Dna/b/zkxReDUxlWfrnI74g2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBpQjQJ7mbmLeoVKRu3vitTuzjyyAuqnmfOXzu7vkYQ=;
 b=OP952Y0KdtK7omOwLW0fIy4vJ3ZLqpO8KxMhlCLpFW90pMxfXCqux9g1fMB8BsJzQp61zCd9AsSLSPUAY+fzjN1K0GgqkD2V1hrKF+K2c9QIPCDEhzaG+QfCji82+fLK5pAH6qPNgngHjf3mQ72lEzMsrm6gG5Lk/6XRKwC6D4+NBZoghJdfxg8lfWeVrCGd9nQ/zuM7i7xwdVMxa71YT59MezTTupOZ6jlXlRN7LDbw6FjyENWtQH6ewbtV8JiGuOHhCL8H1AvzlPQjz7kBOW6NWDJCDGPUhlv+7hTUVL9/o1VVEvB67sceZRKY6kNWSxV9Ubdkf3aANRDbsEUMLw==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by KL1PR06MB7317.apcprd06.prod.outlook.com (2603:1096:820:145::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.34; Wed, 21 Feb
 2024 12:48:39 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad%4]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 12:48:39 +0000
Message-ID:
 <SEZPR06MB695941B73156497A7E73CE8596572@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Wed, 21 Feb 2024 20:48:25 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: host: replace 1st argument to struct device * for
 mmc_of_parse_clk_phase()
Content-Language: en-US
To: Ulf Hansson <ulf.hansson@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Adrian Hunter <adrian.hunter@intel.com>, Joel Stanley <joel@jms.id.au>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
References: <20240215-mmc_phase-v1-1-f27644ee13e4@outlook.com>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <20240215-mmc_phase-v1-1-f27644ee13e4@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [R8K6OdDz7NE1mlww1KdSEuL60F5ECXVLELv/8TOcc7YXvKLHYv9i7D5ffRLJLBMJ]
X-ClientProxiedBy: TY2PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:404:a6::19) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <e3aee910-974e-4fb9-8fc3-152b85130c6b@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|KL1PR06MB7317:EE_
X-MS-Office365-Filtering-Correlation-Id: 44957021-cbe1-4f94-32eb-08dc32db6d12
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0dx19bR8VpTslOiJ+zoneSWR/chrWb2Xg4EmdTqg8K8agDG5YxmEoIyYHst9PniAeIZev6mxUaxsJpmeCVrObSaT90ivA1wmx9dWfaeCgBHI9kyjiyD3gNiaujbM8Ol4Uq+wToNCooIdf0KSxysMU8VcSeJlG30eMHKSQZqo9aK1xOYxkf6UP3Gut8cH1TvmT4sA0EpIJqx6nk67pKxflc4E2G0W7gkSAjMiRZatnUr7IH2GrPzpU2kgAkM4LzFD2eaTQnvaNyQebKLesFr5XSAzg32HDbZtQuZ/2QALbu0FY9+7Uk2ldp+ALS4yBzWZfF/EZRWhR1fI0h8AkXyOdMTlvRu1o8KIQrDFqJWHGKlNqDsltS5U2HSEnU7EnjXVPbMxCLIm30TZJX68SuPOwHLTpZRqjIeKgNRY6VeAYFnuqP7X3x/wLn6sq5GXqquo8OR56VjPB/b0UISK4CAYmrn3UHHe3FTDTU9IP67bHFWpn4xVi3BNgg7R1VpO8C+EP+XuFnh7Nq4Di760dtTcylOJbM805wbpSHyDrnZCkQsXHf5htr7d+NZUoru9l75UtiA9Upi9RFgcEcPPn6izQ1Uq4/gvyLg8F/osEQ8Msho=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?clV0WWI3RUJFbnlPTVQySG81R1UzbFM3OVhqOGg5d2dXVVN3QTUwSVFaR2hD?=
 =?utf-8?B?c29sZXkzQ2RNeEpjNnFUMXBNYVkrQzFvbmV6ZWRlbmZzdkNzV2F0UHZJUUY1?=
 =?utf-8?B?dFZ6M0tzQzVxNzVpbWhOcytUcU9tR016ZTZJS05xaW9NTkhtcU9KUFdsY1p1?=
 =?utf-8?B?a2NlWFEyZGl1aEEvdXlYMW51YnNUeGZ4NlQwT3FXZ2ZDY2lsYk1wR1RoMVBa?=
 =?utf-8?B?K2tXVEJ3MHdpc21VOWJ6OEhBR3FpVzhvWTJPRC9LSEF1LzJnQmJIUlVUOHpE?=
 =?utf-8?B?bEhGcUsraXptZXh6eHZXRmpubWdFK2trSjU0OEZla3psQnlLeTdnSUpGUldN?=
 =?utf-8?B?elJSaitQWnQ1NkR4d3BXSFNweTVPNHJrUWFuTEJNSWQ2dm0vajFOYjJqQ2NX?=
 =?utf-8?B?eGYzY3dtSlZiOHhhc3JIYnpYSlNOMnlnanpyc0ppS29jdHo1NVdsNllUR3pq?=
 =?utf-8?B?SjNIWUlQeE1WbjlUanZ1SEhMczVvbFJLdDBhb1ZKcVJ2cWJmQ2JKRjdLQlRw?=
 =?utf-8?B?b2YrOFkrOWtBaWsvOE12SUFqL0ZGaTMvUy9PbjZ6NmJCd3hlYlhHTHVUL2RQ?=
 =?utf-8?B?OG9HY1dOL1hkN0RLVVQ5QUVjdW5aQjd4SVJHdDRxNWIwdVYvYVFKNVFNeGRq?=
 =?utf-8?B?bERRZi9wS0s4N3VBc2k5T21tdzIxeVRBM29VWDA3b0VNdTlBdzE5QSswU3Fr?=
 =?utf-8?B?L0tYNXY3TFpKcGFUSVZSY0htT1RXVnF2c1U4Zi92SVcvTlFqaE0xTHFCZkJU?=
 =?utf-8?B?a1Z1emxneThLUEVmL3pZWk8zQVJrQjd4bWRVUTBpdlFMV3dTQUQyNlZTT1cy?=
 =?utf-8?B?RW01TGVYL3NDV1JCM0ZBUkhvRkFrS2YxVVFEa1EyZzVyVXQyc1pBVys4VXJ0?=
 =?utf-8?B?YnQ5dGJRWkQzRTZDR2hGcnRFQ3BGTUVIbFNMQytNMjZIaWNSbUl0ZGpiWXFJ?=
 =?utf-8?B?NFZxM3JMQTVOZTJvbHp4My95eWlxM1N1VFZCc2I4dE9tcUp0MFVyTnZ3YWdV?=
 =?utf-8?B?dUhRYVRWUXRpOXowcW4wbVJEY1Z6U2gzTnR0T3RmSTBWUTQ4c09NMUdTU21P?=
 =?utf-8?B?Z0NGM0J2WVNUL0RhS3JoeFFrT2llcWgxSENGaFlCN243RlhZZjFkYXpTOGd0?=
 =?utf-8?B?T0o5dUJvaWFKVmcya0xpUWNjUjJLRlF3NUpLcE9BRzhML1dhNjhpd0lJWm9M?=
 =?utf-8?B?WjNDVm8yWHo1YTBLK0JOaDN3SmYxYWhXdzR2OFo4b2NnUU92emJmT0UraTZZ?=
 =?utf-8?B?MmZYMmdYQTZDellNeklqYllGeEtEZFRSUUlvUlg2WWxNMVdRR1Jpd2RHbita?=
 =?utf-8?B?eEJ4RjBUVE1Bd0w4d3l3ZmdOTUF4ZEtWcmR0b0kySUZadi82M0NiSUFTOWxw?=
 =?utf-8?B?dnNQcG9XTzhNTGNqSnkyY2FyWStYSVN3eFhFMTYydlRmUERFSXRlM3JnMGlW?=
 =?utf-8?B?RGZIT0FqRVBuK25sNHZ5TFMwWFp6S0NTQTAzMWtqSGtCMHhSL3JsTzZDMWdE?=
 =?utf-8?B?WTVYRVBzb2tkMmw1SnZEMnlkWFBybmJMSFNSaWx3eVJiSU5qR0IvdlBvd2p4?=
 =?utf-8?B?dTQvWitUUTBTUWQ3ejFXLzNkaGxyc1dLSFlGNWsxMUxOL243VGNiQXRqbkd1?=
 =?utf-8?B?MU4wK2w2aEc5a0MxeG5jbVA3Y0MxS1pRRzJmcWxjVG9qV3RFVERFVDhWSjVS?=
 =?utf-8?B?czJjTm9wYktaQ2hwNzFuRE9BdWR1QS9lTzRuM0tBbmQrMDRHbUIzZS84ZFZv?=
 =?utf-8?Q?XAa2EHIdDMy+96rbUjqIk7KkKxTfpk9GYS+kjgf?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44957021-cbe1-4f94-32eb-08dc32db6d12
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 12:48:39.0243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB7317

On 2/15/2024 7:03 PM, Yang Xiwen via B4 Relay wrote:
> From: Yang Xiwen <forbidden405@outlook.com>
>
> Parsing dt usaully happens very early, sometimes even bofore struct
> mmc_host is allocated (e.g. dw_mci_probe() and dw_mci_parse_dt() in
> dw_mmc.c). Looking at the source of mmc_of_parse_clk_phase(), it's
> actually not mandatory to have a initialized mmc_host first, instead we
> can pass struct device * to it directly.
>
> Also fix the only current user (sdhci-of-aspeed.c).
>
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
>   drivers/mmc/core/host.c            | 4 +---
>   drivers/mmc/host/sdhci-of-aspeed.c | 2 +-
>   include/linux/mmc/host.h           | 2 +-
>   3 files changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index cf396e8f34e9..8b2844ac5dc5 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -234,10 +234,8 @@ static void mmc_of_parse_timing_phase(struct device *dev, const char *prop,
>   }
>   
>   void
> -mmc_of_parse_clk_phase(struct mmc_host *host, struct mmc_clk_phase_map *map)
> +mmc_of_parse_clk_phase(struct device *dev, struct mmc_clk_phase_map *map)
>   {
> -	struct device *dev = host->parent;
> -
>   	mmc_of_parse_timing_phase(dev, "clk-phase-legacy",
>   				  &map->phase[MMC_TIMING_LEGACY]);
>   	mmc_of_parse_timing_phase(dev, "clk-phase-mmc-hs",
> diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
> index 42d54532cabe..430c1f90037b 100644
> --- a/drivers/mmc/host/sdhci-of-aspeed.c
> +++ b/drivers/mmc/host/sdhci-of-aspeed.c
> @@ -435,7 +435,7 @@ static int aspeed_sdhci_probe(struct platform_device *pdev)
>   		goto err_sdhci_add;
>   
>   	if (dev->phase_desc)
> -		mmc_of_parse_clk_phase(host->mmc, &dev->phase_map);
> +		mmc_of_parse_clk_phase(&pdev->dev, &dev->phase_map);
>   
>   	ret = sdhci_add_host(host);
>   	if (ret)
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 2f445c651742..5894bf912f7b 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -539,7 +539,7 @@ struct mmc_host *devm_mmc_alloc_host(struct device *dev, int extra);
>   int mmc_add_host(struct mmc_host *);
>   void mmc_remove_host(struct mmc_host *);
>   void mmc_free_host(struct mmc_host *);
> -void mmc_of_parse_clk_phase(struct mmc_host *host,
> +void mmc_of_parse_clk_phase(struct device *dev,
>   			    struct mmc_clk_phase_map *map);
>   int mmc_of_parse(struct mmc_host *host);
>   int mmc_of_parse_voltage(struct mmc_host *host, u32 *mask);
>
> ---
> base-commit: 9d64bf433c53cab2f48a3fff7a1f2a696bc5229a
> change-id: 20240215-mmc_phase-26e85511285d
>
> Best regards,


Dear maintainers, this patch has been absorbed by the patchset here:

https://lore.kernel.org/all/20240221-b4-mmc-hi3798mv200-v6-1-bc41bf6a9769@outlook.com/


So do not apply this patch directly anymore.

-- 
Regards,
Yang Xiwen


