Return-Path: <linux-kernel+bounces-150917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F278AA6B0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 03:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E55141C21D3A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 01:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519AB15D1;
	Fri, 19 Apr 2024 01:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="cK2bJZ/J"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2130.outbound.protection.outlook.com [40.107.117.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA00B15BB;
	Fri, 19 Apr 2024 01:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713491476; cv=fail; b=a5nEsgvvGdsjbrs283DxepXci1t732K8GkAeftL0YTFxleh7J0I8CBwkU/nyXpeFnHh0m8HIrbw6uBZY73cDPRxI0enEO1JkUu6J9xMQperhBDtaH5xz2SAuIlkFEBvPM27WZ2eipEEgmioHLudQ0R/+r/5lRvShY+q3kKtpjYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713491476; c=relaxed/simple;
	bh=m15MHS6Zg7qYHdioX2M0EONxIv7nnhWvA+rCG5/DRmQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Oux4AwAQXYS/28hxEbp0VCwibpwNcE50xAXGAJjf0CNts+FQSbHrkjaGAwVXKOmioaLPr2/h63M9EEdQeaE+As+koXpFPQRAuAFjO8+IyX9Fhax8lRZ42IxG2Vc1DUp5ySAU1si9BZPRZY3aN4DB4CWkDEPJyWmG5hkI27sJwPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=cK2bJZ/J; arc=fail smtp.client-ip=40.107.117.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wdx2xLQ0AmtVrsGfAQmaZxNsBruIqzOtzKZbG9BwCVwe78toly+BngQCXY2coNfxtrFDWTIECfFRoGzIQVN5HjcgogrNFN7WpYapBPOwd3GMVyr5cGCfYoGfaFlCiXfe3pQ4qYf9LXZ4JB7+Uwb4BmXnBV8TNEkrw4SMeLndrbEEWR9BwyWk5kc1i4F9ACR3j/5a2n8nXCqvtvsOZOR1JnuN6XLEHWsPUpZXQCnNzYNO0rhYL6lNryRKu8Gns8dDmFb/OjLBkdJ4erDvHRSNHncp/o8ZHELBK/CmYTeMC54370n5J7lRGT/JEVlV8eG3LVbdBe+dLCea2blUiAfBTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xu2xoDhn/x9ppgxVF1xf6ZoiaxGpt6tfqZump017aXo=;
 b=MD8f12t7312zitjF35QHXEeIAxgaT157CTz0NNY/sQixU7dj5vliKuG6Br6mKJPD89qrwla+qip+s8DAVCh5rms/TWt+eNyD7jAegpEE+1j2vRclMnSV4fFUmCFBrnW7MDSg1a5Lrs5GO5xcVtnjAwgZ3C5s0HRsE844RkhyZ0UZlWV9L1MxAYjAijGjDwp7vqsifl0gsGOFx4pimRqHZ66qRW9G1Bq8MHFLdLZky9urPaFQo+hGa9UPKL48e+qtBmOi5d3+M96l9FDYXnEeOTIQ1sLLuTrToCNkfzIR8R8jgAgWmecqP3oWpf0wMVdu4I7Jr73cMYiY6zKTjd0OAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xu2xoDhn/x9ppgxVF1xf6ZoiaxGpt6tfqZump017aXo=;
 b=cK2bJZ/Ju4ui4kfuS8KEP6f9rXJY3PH0xC7jFQ1uQHLF5g4ekjEfP1Uz1XEuJqyjIP2+XpGNX/eUWCUpH/y5Sr/nxbaksAsOpMyQCPWRtTgurafeNsCR9X4rwvt5V+KndNVWB8/r6dBzRBaZLjT765s3qW3YMkmn3Jof1JanBI2KKRZJw1Wk+euFRUAjO/yIXkE+B0pk0PtWzvsD4NLVxcsZvhi6E6s+u9wCbbMTEhLukfGlHXrq+oF5cjDJgp/TiK4ph65bQ3K1BpHcocqvRubaVXyWMBvK1Z9pJhLvPTZfKSDcy+irrXCSgry1GVqZbi6t/wek6vMR55mv5u2coQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7384.apcprd03.prod.outlook.com (2603:1096:990:11::8)
 by TYZPR03MB8727.apcprd03.prod.outlook.com (2603:1096:405:75::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Fri, 19 Apr
 2024 01:51:11 +0000
Received: from JH0PR03MB7384.apcprd03.prod.outlook.com
 ([fe80::8627:9243:4397:43c3]) by JH0PR03MB7384.apcprd03.prod.outlook.com
 ([fe80::8627:9243:4397:43c3%6]) with mapi id 15.20.7472.037; Fri, 19 Apr 2024
 01:51:11 +0000
Message-ID: <af81f1e4-250b-4785-8b44-fc3e9753dba8@amlogic.com>
Date: Fri, 19 Apr 2024 09:51:05 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: reset: Add Amlogic T7 Reset Controller
Content-Language: en-US
To: neil.armstrong@linaro.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
 Zelong Dong <zelong.dong@amlogic.com>
References: <20240329-t7-reset-v1-0-4c6e2e68359e@amlogic.com>
 <20240329-t7-reset-v1-1-4c6e2e68359e@amlogic.com>
 <927ad2cb-3b41-4eda-b930-856be64ae9ba@linaro.org>
 <10650c59-96f2-4234-b5fd-aa8efec90e5b@linaro.org>
 <579a1569-7bba-491f-ba5e-7cfcb34ccc1f@linaro.org>
 <c7e243e3-3f61-4d63-8727-3837838bdfcc@linaro.org>
 <48005005-54ad-473b-826d-23b0b3f3a52c@amlogic.com>
 <64c765e4-698f-49d6-8d17-4b512c3dc8ec@linaro.org>
 <f845db57-64dc-4127-ab8d-9a038fd8d35b@linaro.org>
 <4736ba70-a42a-473f-8724-8e664bbfe4eb@linaro.org>
From: Kelvin Zhang <kelvin.zhang@amlogic.com>
In-Reply-To: <4736ba70-a42a-473f-8724-8e664bbfe4eb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0127.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::9) To JH0PR03MB7384.apcprd03.prod.outlook.com
 (2603:1096:990:11::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7384:EE_|TYZPR03MB8727:EE_
X-MS-Office365-Filtering-Correlation-Id: 96cf6232-5abc-4f76-7ced-08dc6013302b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V2tqMStRSGJGcHBlU3pnYU4ybm0rSEowMGE5V0NPUTJ6UHlwemp5Y2xqb0FI?=
 =?utf-8?B?dTVWOG1UejQ5YS9JZy84SXFGbVlScjVtYm1qazFVZmhTak5Va1o3VTg5UkVu?=
 =?utf-8?B?YmxTeFNoZG1sK1JWeE9KamE0UDgzYXFNeGdYMUpoOGNObnpMS2lnbTBiQUxo?=
 =?utf-8?B?Zm82Ti91MWovZW9aWjFlamJPdURnWXc4VHE0K2xEdFl3VzVBMllVT0IzalpZ?=
 =?utf-8?B?YUNOc0liWEcvZEFSRmkxNDVFSkNLTmNhYkJlT2tEbVZ4R2pOVmhyMUtOTlFs?=
 =?utf-8?B?d3NwbTI3K2pwV2lLTXFoRVlnQU04cy9CTlNIOThmakp0c2svMTJnK09DM29i?=
 =?utf-8?B?WGdCSCttK1Q1NUZTREw5YmoyZlI3L25xaFZBTlZPaW9rYUIxQTZnbSs2UUYr?=
 =?utf-8?B?RkNqM2hsUkcrMjkzMm5oSnBxaEpERktEZGF6Y3VOTHdLWVZFV3hMWHJHazRm?=
 =?utf-8?B?M0V6dkR0alhUbDMvbXh0cjlLOG9KbFE0SjZEemx0ZHJBY0xDaG5JVHJvNUVZ?=
 =?utf-8?B?cGlYaDhmdnFETFNqejNQbjQrd1hheVBDSHNIbmNzbXAySTJrTVQ2SnIrc3lG?=
 =?utf-8?B?OGxBRDJ5U3BlTHNMckxxQzc1YjkvZkMzRmo4d0N4UkVodmtFMk1Sc1VlOTNt?=
 =?utf-8?B?Tjd5SnkxTFRoM2tIckdNKzlNN29sNGZqaGxRTHQ2aGQ4M3FJWlZCQitEeisv?=
 =?utf-8?B?alRMVUJ1M0VPeXJUOHg0eGY3Q2Z0cUQ1bTl3NEFCZXcralRQWkhzQjRvRVNV?=
 =?utf-8?B?YzJRNS9DOExjZHQ0Q2RRYXZsVEp0ZDJ5SWJ6OU5wWU5SbWRqQXFnRjluVjRa?=
 =?utf-8?B?cHlWNmxlTHFucVFRRGdFZFcvSXBZeVhWSXUzVytFYjhOc2NITkFvQTdueTh3?=
 =?utf-8?B?VkgwcHF1Sm5lTC96WGVmaHRoQ2dVd3NHMEk5Y21lSklqekJiZU5GUlFVMUt3?=
 =?utf-8?B?eW05ZkVNYWMrZWYvZHNubkZiT3d4Y3FTTFRkVmYvbC9FUEhUbHBXejg2UXdO?=
 =?utf-8?B?end6T2pDNjNadGpoTnNLcitwT21RTEsyelBsSUZ5UVc2OC9GU2UxbVNZTXlU?=
 =?utf-8?B?VzdsNjZ5d1NGYzdpM29ZUmIzYnpUS2tiZnVDMUsxamtQRm1oQjBPN2pET05T?=
 =?utf-8?B?dmZUbWFRcE5VS3J6cEFpMFZiRDNBWWtIcERWclpOcGhIcVVRb1VWMXNucDI1?=
 =?utf-8?B?U0x1ekR0V0puNEk4Z1h6VFV3UlBPQXpsNys4V0lGS2EvNlRIQnZCdFpKSjFM?=
 =?utf-8?B?WHpTOWluSU5Xa3JiRkZkZkpXdGw2TWlJZm1MSnNOVnVQMFplckhvNVFFNUxH?=
 =?utf-8?B?WE5wbXFIWGl6dTNvSUsxVGREM0xDZGU3SzBBdkZxY2drWGdHeGI2ZmgxVi8w?=
 =?utf-8?B?dCtIcUp6Q3ZHQkN1WTVNOEpBcUozZERXRS81ODZQbi9FTXlSNkNBalN4REdT?=
 =?utf-8?B?V1R6OXA2RGQ5S0JjZThCc0hacjZvNkJoMzREVUpzODRxd2xxZTJUK01TNlM1?=
 =?utf-8?B?MU5PRzZMNXVBN0pBY0RpV05CdTVpZzVBd3NGcFBnQkN2YndNZktlUzZNSVB3?=
 =?utf-8?B?SGROLzltYmxZYWkrUFVaV0dCVC94clVTQVpCcU1qZkI1MkRXZDhHWXVMQ2hX?=
 =?utf-8?B?Z1c2dnFOMGQzeW84dmQ4U0ZNNk5jenRjS1J3L1ZVcU1oT1BVd0FCR25pTGZm?=
 =?utf-8?B?QnE3cm90ZFdkdm1LcFpvVUlRL0hlU3BLYm9LOVpBcTJQdDNIUCtTYXB3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7384.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WStyRU53RElJYiszRlp2TUVEYjJ0YnNiZjk4L0hJYk5BMDRXeDQ5UURGaHg1?=
 =?utf-8?B?NlZyQnc0RndWYk10MHlmZnFTQzFUZ1NaTXI4Ym9vUzBaOHB0N1ZadTVOMHRo?=
 =?utf-8?B?RkRxSUREVjJNTkFGbFRsNHBiYVo3MVk1VFdwYXhNZHNqVG5nWDdZOFNGOW51?=
 =?utf-8?B?elpvbURIS211Rmc0Yi80SVNITTdOdlVsYkVjNlFzd1ZWRVdCVEl5R1F2b3hr?=
 =?utf-8?B?NFBYb08wRXFTZzdzbHVhc1I0d25vNXE2aHRWWWlCemtMOUVPRHM4Q3RuN1NB?=
 =?utf-8?B?SzFBS3NVcFFjaUdQSnJyL2FJbnJ4bVhJb0JmVUlFVlBUakNTRDNVcEhzcDVR?=
 =?utf-8?B?QUNrcWVZeUp6dFlpdjFzVWltYWhuc2w3N2V5c2J1Rms3K3hhVS92M25YNXdO?=
 =?utf-8?B?YmpwTkpRTUpLWnRMZEc2bENSSDV1YnE2SUxmbUF1YlRiZ0o3UDMyU2ZxdU50?=
 =?utf-8?B?T3lEcitoRWZQdzZqZHpJd3dDczVRaCtYaVFYTGVuK3hINDlGUTNOVFcyTWht?=
 =?utf-8?B?SzBkb3B2RklNMTkxRTBJdWJNbmFZc0dVcU8rT3NxRjRFUTN1YlNnQXFFRzBz?=
 =?utf-8?B?RGxMcUZsbU5pczJ0Y3J3R1hzOWoxVGtqbytpTDgrSk91eGNqYmhBVjFtdHo2?=
 =?utf-8?B?NEl6RmUvSk1QODJoVkQxTHUwZDV5MytYYktrYnp0aEFXRTNYM3QwYVFKY3JF?=
 =?utf-8?B?cDYvRS8xWk9oS09TalNPQndJc2dCWWxxWFRFalFSTThpSmd6TnVjQmNobjJ2?=
 =?utf-8?B?YlFnMm1YamdEM1V2RllpQWYrdmpXMVZBV0lDWFVzemxlelBzRUcwTmRpM0lC?=
 =?utf-8?B?T2NTZGtoeStwZ3l5OHkybUVnQTZCejlvZUNGYTN6cmttT0R6amZtdXEyVlNp?=
 =?utf-8?B?TDJRWlBobVZkaTNnOFBOejFkcFAvSzlXeFlkeENsYlJKQWpYR0NUcVJCazlm?=
 =?utf-8?B?TTNLdzg1TGVNMzdtK05pWkwrV3RiOVhVK2luZ3orVjR5dUtSM2N5a04ycVo5?=
 =?utf-8?B?SWk3RGk5L3FhL2I5aHpvMDBCeXh6RXpxZ0U0SStORDM4WmVLek1JK09FOWlK?=
 =?utf-8?B?ejlveDJEL3JDYUVzNlNwcWdFUVRTNmhtREd1cGJ1eWZONWZYak04VkpHam5q?=
 =?utf-8?B?NmRJMU1pQmVGeHBVblFORDI3K0FxSjJLN3NOTGZic0RaQ0pUajBQZHAxUC8y?=
 =?utf-8?B?ZUhHaHZzL0FWSGZ3WkRKTG1NcFp0anBiU1ArL2N5alhrcWdZa2QweU42anc4?=
 =?utf-8?B?bk9DcHdNUkxLUTlEV3psRms2TUZDcWtYZ0ZCUUxJS1BQZWpRK2VrYnNKR1ZM?=
 =?utf-8?B?THBiOWRacjNmZnZlbm11MndtUGhXd0JiTmdJYldxeVJMSGxLOHB5Nml0bUoz?=
 =?utf-8?B?NUJJbG1EVFd6N01pcEJUTlUxWmhBbldEb2hSSjJaajBQM21vOHk2cjZsWEdh?=
 =?utf-8?B?YnFQZGI1RWV4SFFjcjJvSUZ3ZG1XRVY4WkVYRTVDdnJKQWtHemQ2Q0E1RGIz?=
 =?utf-8?B?OXVhbVYzbTdUYVRpbWRNSThId0d0UDlEWEZ6eDM2Q01NOUxyRUgrbW5TUHdY?=
 =?utf-8?B?cG4xd0V3ZGFKc2w5VHY3ejdLUDQvbTI4YmxMc3c0WjNpOG84NTFLL3k4VnJT?=
 =?utf-8?B?dUtKTzMraHpEU1JjM1Nidzk1bVNFY1ZtcXh3aFJiSUplNWo4dUt0SDVlQTlm?=
 =?utf-8?B?ZFZhK2wwSm1XNmpqZWlFWStDa3Qrb2pHNHBESUxpcnhBbUFVaVdtU0QzclVN?=
 =?utf-8?B?aW9FbkZ2ZDNlZmRac3I3M05lZzZZbExRV2pnVnRZRlJsMjQxUGo0Q0prUW5J?=
 =?utf-8?B?enlsMGc3R0xFRTUrbGRpMlYzQnpWRW9JZjRRUTlubGdnbVF4SXF5djhhNU5w?=
 =?utf-8?B?dThGSGxKMzlvek5VMmF5QWw1VStQcFV6SDZMSDBLbXVueE5hNSt0VEllb0Ev?=
 =?utf-8?B?QUtEWXFEVlkybENOdGtvL2NwSG1DQ21kL2dNai9Xb2QyNmVzYTU4WjBwK0x5?=
 =?utf-8?B?ajNqS3BtdG93Z1dOS1JZZFhldDdBZFRqRjExS3FLclFKWHRsM3RMQUNyV2Y2?=
 =?utf-8?B?VEsxN3I2NEJFMi9UYnRKYk5uU2lpdVQ3UHBJdjRlWjVxQlUwNnBMN0x5b0Fn?=
 =?utf-8?B?MFRXaUhKMSs3ZlpOc0R5SnJHSmdnY2tRUVJxYUVjcXV3NCtUMDdXeVZrTXBW?=
 =?utf-8?B?Mnc9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96cf6232-5abc-4f76-7ced-08dc6013302b
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7384.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 01:51:11.0231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PmaiABGIVv5qHzToZszPGjExV7EPfdM3G2/NvtRS66wR7ZQUc8PGW6Vd4QXavrosASfWepNkNKZHo6+MvIOYn4Y98rWlBbva+axQ4FzZGkI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8727



On 2024/4/19 05:03, neil.armstrong@linaro.org wrote:
> [ EXTERNAL EMAIL ]
> 
> On 17/04/2024 21:08, Krzysztof Kozlowski wrote:
>> On 16/04/2024 01:30, neil.armstrong@linaro.org wrote:
>>> On 15/04/2024 12:31, Kelvin Zhang wrote:
>>>>
>>>> On 2024/4/13 02:03, Krzysztof Kozlowski wrote:
>>>>> [ EXTERNAL EMAIL ]
>>>>>
>>>>> On 12/04/2024 19:57, Krzysztof Kozlowski wrote:
>>>>>> On 12/04/2024 15:12, Neil Armstrong wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> On 29/03/2024 20:39, Krzysztof Kozlowski wrote:
>>>>>>>> On 29/03/2024 10:17, Kelvin Zhang via B4 Relay wrote:
>>>>>>>>> From: Zelong Dong <zelong.dong@amlogic.com>
>>>>>>>>>
>>>>>>>>> Add a new compatible and the related header file
>>>>>>>>> for Amlogic T7 Reset Controller.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Zelong Dong <zelong.dong@amlogic.com>
>>>>>>>>> Signed-off-by: Kelvin Zhang <kelvin.zhang@amlogic.com>
>>>>>>>>> ---
>>>>>>>>>     .../bindings/reset/amlogic,meson-reset.yaml        |   1 +
>>>>>>>>>     include/dt-bindings/reset/amlogic,t7-reset.h       | 197 
>>>>>>>>> +++++++++++++++++++++
>>>>>>>>>     2 files changed, 198 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git 
>>>>>>>>> a/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
>>>>>>>>> index f0c6c0df0ce3..fefe343e5afe 100644
>>>>>>>>> --- 
>>>>>>>>> a/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
>>>>>>>>> +++ 
>>>>>>>>> b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
>>>>>>>>> @@ -19,6 +19,7 @@ properties:
>>>>>>>>>           - amlogic,meson-a1-reset # Reset Controller on A1 and 
>>>>>>>>> compatible SoCs
>>>>>>>>>           - amlogic,meson-s4-reset # Reset Controller on S4 and 
>>>>>>>>> compatible SoCs
>>>>>>>>>           - amlogic,c3-reset # Reset Controller on C3 and 
>>>>>>>>> compatible SoCs
>>>>>>>>> +      - amlogic,t7-reset # Reset Controller on T7 and 
>>>>>>>>> compatible SoCs
>>>>>>>>>
>>>>>>>>
>>>>>>>> If there is going to be any resend, please drop the comment. 
>>>>>>>> It's not
>>>>>>>> really helpful and makes it trickier to read.
>>>>>>>>
>>>>>>>>>       reg:
>>>>>>>>>         maxItems: 1
>>>>>>>>> diff --git a/include/dt-bindings/reset/amlogic,t7-reset.h 
>>>>>>>>> b/include/dt-bindings/reset/amlogic,t7-reset.h
>>>>>>>>> new file mode 100644
>>>>>>>>> index 000000000000..ca4a832eeeec
>>>>>>>>> --- /dev/null
>>>>>>>>> +++ b/include/dt-bindings/reset/amlogic,t7-reset.h
>>>>>>>>> @@ -0,0 +1,197 @@
>>>>>>>>> +/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
>>>>>>>>> +/*
>>>>>>>>> + * Copyright (c) 2024 Amlogic, Inc. All rights reserved.
>>>>>>>>> + */
>>>>>>>>> +
>>>>>>>>> +#ifndef _DT_BINDINGS_AMLOGIC_T7_RESET_H
>>>>>>>>> +#define _DT_BINDINGS_AMLOGIC_T7_RESET_H
>>>>>>>>> +
>>>>>>>>> +/* RESET0 */
>>>>>>>>> +/*                                        0-3     */
>>>>>>>>
>>>>>>>> I assume this matches existing drivers which do not use IDs but 
>>>>>>>> map the
>>>>>>>> binding to hardware value? I remember we talked about changing 
>>>>>>>> it, so if
>>>>>>>> something happened about this and it could be changed: please 
>>>>>>>> change.
>>>>>>>
>>>>>>> I'm not aware of such discussion, and I don't really see the 
>>>>>>> issue...
>>>>>>> thoses are IDs, and yes they match the Hardware offsets, and ?
>>>>>>
>>>>>> Bindings are not for hardware offsets/values/addresses. It's just 
>>>>>> not a
>>>>>> binding.
>>>>>>
>>>>>> I quickly looked at your driver patch and it confirms: not a binding.
>>>>>> Binding constant is used by the driver and DTS consumer.
>>>>>>
>>>>>> I am really sure we had this talk in the past, but could be I think
>>>>>> about different platform. Since this is not a binding, I do not think
>>>>>> claiming there is any ABI here is reasonable. Feel free to store them
>>>>>> with other hardware values, like in DTS headers etc. We already 
>>>>>> moved to
>>>>>> DTS headers several such "non-binding" constants.
>>>>>
>>>>> Un-acked.
>>>>>
>>>>> I looked at my archives and we did talk about it and you were CCed:
>>>>>
>>>>> https://lore.kernel.org/linux-devicetree/c088e01c-0714-82be-8347-6140daf56640@linaro.org/
>>>>> simple-reset is an exception.
>>>>>
>>>>> So to recap:
>>>>> That's not a binding. Don't add some real values to binding headers
>>>>> because it is not a binding then.
>>>
>>> So what's exactly a binding then?
>>
>> Binding headers is interface needed (necessary) between implementation
>> (like Linux drivers) and DTS.
>>
>>> random linear numbers that means nothing can be a binding
>>> but registers numbers can't be ? why ? I still don't understand, why 
>>> this suddenly gets problematic ?
>>
>> There is no interface here. Drivers don't use them. It's not "suddenly"
>> problematic, I commented on this year or two years ago and we also
>> started moving such header-abusers out of bindings.
>>
>>>
>>>>>
>>>>> https://lore.kernel.org/linux-devicetree/CAK8P3a1APzs74YTcZ=m43G3zrmwJZKcYSTvV5eDDQX-37UY7Tw@mail.gmail.com/
>>>>> https://lore.kernel.org/linux-devicetree/CAK8P3a0fDJQvGLEtG0fxLkG08Fh9V7LEMPsx4AaS+2Ldo_xWxw@mail.gmail.com/
>>>>> https://lore.kernel.org/linux-devicetree/b60f5fd2-dc48-9375-da1c-ffcfe8292683@linaro.org/
>>>>> https://lore.kernel.org/linux-devicetree/418c5f0c-5279-41f5-3705-345ec9a97ea2@linaro.org/
>>>>> https://lore.kernel.org/all/201401111415.29395.arnd@arndb.de/
>>>>>
>>>> Got it. Will delete amlogic,t7-reset.h and use the hardware numbers
>>>> directly in the DT. >
>>>> Hi Neil,
>>>> As you know, Amlogic reset controller is divided into several 
>>>> groups: reset0, reset1, ..., resetN. I'd like to discuss the 
>>>> rationality of splitting the one device node of reset controller 
>>>> into device nodes according to the groups. Then we can use the bit 
>>>> number within the 'resets' property.
>>>> reset0: reset-controller@2000 {
>>>> ...
>>>> };
>>>>
>>>> reset1: reset-controller@2004 {
>>>> ...
>>>> };
>>>> ...
>>>>
>>>> What do you think?
>>>
>>> No since you'll basically add a node per register, you need to add a 
>>> node for the while reset HW function, another
>>> solution would be to split the phandle arguments in 2, the first 
>>> first would be the reset bank, and the second one
>>> the reset line for the bank.
>>>
>>> But still it's a regression in readability to drop the macros, until 
>>> gpios or pins the reset number doesn't mean anything per se.
>>
>>
>> What stops you from putting the header in the DTS? Just like others are
>> doing?
> 
> Ok so now I understand, Kelvin just keep the header but move it in 
> arch/arm64/boot/dts/amlogic along the DT patch and drop it from the 
> bindings patch.
> 
Will do.
Thanks!

> Thanks,
> Neil
> 
>>
>> Best regards,
>> Krzysztof
>>
> 

