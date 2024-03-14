Return-Path: <linux-kernel+bounces-103609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7575C87C1E0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BF50283E63
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A5E745F1;
	Thu, 14 Mar 2024 17:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=criteo.com header.i=@criteo.com header.b="akUxFeHJ"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2044.outbound.protection.outlook.com [40.107.249.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A2C7441E;
	Thu, 14 Mar 2024 17:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710436260; cv=fail; b=Yjj/CxDvKQUeQzY2liSLlQBKE2F8iyBP/BavYzycVm/d4lOTxjM8Lk2xgjC7EUzF7p3wNQXPHLFbUt+0ULSJYyc4yy43BqJ7HDtaeXK3vVOINN6AAToRcsLv7wR0SO0fahttA62Y9SQsIbBhqxm+g3DMPqn009x0OC6J+14eFVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710436260; c=relaxed/simple;
	bh=VFxtvec4lKBvbhB0+lLOXGMYZaMT8ACPWJLcfkyUepM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kHNqnrM0ZfLosKaIJWJeNe0vDlmcjotKEX0UOctUrAzTiUynMDRdeBnRGs1kSQYeR2gna9CDPRIfuSODP4zWZZmXDovYGgst9vFFmyxPnjhztl7TDm8ZHiWG/ytOdUqDFd8ziZZgxRtr61VJgGwHQA0e3OHyijqhdYFBi5khq08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=criteo.com; spf=pass smtp.mailfrom=criteo.com; dkim=pass (2048-bit key) header.d=criteo.com header.i=@criteo.com header.b=akUxFeHJ; arc=fail smtp.client-ip=40.107.249.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=criteo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=criteo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eOu4A4NU/IDz3c/PZn8EAxMnx8V91QOoVT3JtSnWuX8PS4+LHx5J/M3zXVZznA1STmrThovqNjVYMpB87stJ3BQs6HBxR/Q71+mMqqMsjD0t70V8IX3/HcXBSB6HkWUbmBFVqJtIcP3HiY8JqfAXfl1D6gS4iDhbj0JkVkqVmhJmeUduVk5fafRoMfT1XpI6t/GypD4D53dIPEEULN5zsDfxbnu4LFRmTo1rgMUo5n38hRcNrUjnSqWAxM+vCQkYFK+CeHkaVHZOM0KVkRBGHC7+MJ707+etLwOc1Fdh47lqO7I5yHiHjxkjRgSGSR+bn97WnAU6Gr6wlgToCPNtnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8GfkSxjQtCspKgywt4dLTD4cE3UbCh5ybjoGOUC88rw=;
 b=VY/Rs+pru7M+7MQLxbZYDGHc7wL5xPhW2c4CAIjIhKoHoo/UVa9AxH9YbrCbZoWL3poOjwgHoxWkCj9eSuLMZiI9pxBq6xhYF89nPi7Wx6WkYk2PHXNZ2dTGS4JWS5AZLtIo+sbw4Q6zQi6cAb+sZShR7aCWwWiaw5F98tKEkvxUkPlDs0iQB3TBmKi2+OT2rk7bj/K1A+NNEiWPb8YlPvWe9Xc52XIBE3qL6EomCYYUX0TgAoNmHX3bRq9AuQqWr3lKavcwyAJfNjLb692RK2X6tAf9iUkbC5qePPF0ndOSbE6mxUfHuVq5UXnk1tyipoEbsKCfVUiPqPzrPSWGxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=criteo.com; dmarc=pass action=none header.from=criteo.com;
 dkim=pass header.d=criteo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=criteo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8GfkSxjQtCspKgywt4dLTD4cE3UbCh5ybjoGOUC88rw=;
 b=akUxFeHJtav2EIeTK7l3cbxnlWQOzLwGwHu1+8r4Vrtl7CfaTlU115EIcpzbN7iwANFZB+Q22bNBoG9TKo2Ngh0TgW4FOBAhWXdw3TedcMsm1Tx8a1ZdBE9Myt9I/6oqTAZ3ZDghLbL8Ni+75nu5EVxvRJd9/x7nwPDSlpw7pCFnee3xRdpIyIrmDSTyxTkWXvDhBArK/EM8YS3/mdpPGaI3ALvX4YNJ68aCEdDuBdsl5SfyqeeSjdZwUI8ekAWdm2gVAYyEZhE7SGQ2yuiLda1NeQZCvW8WGvr2AghigETZ3cMWG95qfg5fZ3Gd4HZMGGAiC6rVoGI3h+IjrtJ2iw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=criteo.com;
Received: from PAXPR04MB8989.eurprd04.prod.outlook.com (2603:10a6:102:20c::11)
 by PA1PR04MB10177.eurprd04.prod.outlook.com (2603:10a6:102:465::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Thu, 14 Mar
 2024 17:10:55 +0000
Received: from PAXPR04MB8989.eurprd04.prod.outlook.com
 ([fe80::c508:de0c:3808:6f2]) by PAXPR04MB8989.eurprd04.prod.outlook.com
 ([fe80::c508:de0c:3808:6f2%4]) with mapi id 15.20.7386.020; Thu, 14 Mar 2024
 17:10:55 +0000
Message-ID: <c0ccaef6-44eb-4851-b336-cdb06647e1d2@criteo.com>
Date: Thu, 14 Mar 2024 18:10:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 iwl-net] i40e: Prevent setting MTU if greater than MFS
Content-Language: en-US
To: Brett Creeley <bcreeley@amd.com>, Erwan Velu <erwanaliasr1@gmail.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240313090719.33627-2-e.velu@criteo.com>
 <4e203331-62f7-44e7-acd9-f684c30662de@amd.com>
From: Erwan Velu <e.velu@criteo.com>
In-Reply-To: <4e203331-62f7-44e7-acd9-f684c30662de@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0490.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:3dc::9) To PAXPR04MB8989.eurprd04.prod.outlook.com
 (2603:10a6:102:20c::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8989:EE_|PA1PR04MB10177:EE_
X-MS-Office365-Filtering-Correlation-Id: 48bd102b-5909-41c5-00a1-08dc4449b586
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IljjuwnepYzHvmHCs/2HLGyiLqeR9UXOhBywPVLUtanMcAYqETGHzgN228QzMW0WDcP1d5M5HeBF5aZVTl8C+eod/jczXgFx1ejDqo2A/ZCMgEkw/uYyLCLFiGKIoyO+Acf+RE+4BAsGW0U7woJTvunM7UKZTyTlg6Nxe4rAP4mLWY7arLFR4aPfoolVIi5S5zZuV4jqL5/PZsMWUhSRSOeoEkr+YhqRsaJ0AD/l+ilv6gQT/LHgjlIeRiMDw9uqPPSIHXHrJ09mDPEFNlzW3XCxG5BJOxW05k7XccSpQyoEmt+exTo33y0lMoIVCiE8JQYkBujhiST/GzkWIwVB8tZfvJfXqAd409tPErO4jjSNd8ZZKTRKtbWXPngOVb/qCEVImiMtW1IWvvMeFjM+PmUmMULjPouWtw1Hf1qtYGvZwJSVIiVqwsDXDlnDRdR5hTYXvB+6A+SyCmJXsqBve115IESea/VTaZU4IqegBCfINVb8f9QVEZ7VGnHJbqfAaB4eGh/+HDf5yoDyGKvnQ6XnFTwu40mu+lb5ox77KEpi8LuLv3X9iXPc+Z97S/Q0il1/6x3nj04JR3FjEoVnIcW1djRlBpXRaWLWalRFSRR5g3/OamzktWlahnIaEzYBWmpzUo8FBpScbyrXHnyn3pXXQgL0PDl7dauaOCSZJD8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8989.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NTN6dzg5cmpVZHF3eWM2VTA2UllyQ01CNStMcHZYaDFkaXhZZFFhSzR1Mlkz?=
 =?utf-8?B?RERMTWlnTHJOYmM2V0phV1RqQVVSQWlrcjVJQklFTCs4eFduTWFIdHhFYWJP?=
 =?utf-8?B?UzVtMHdCNDZZV0VZNFl4bHBjSmdPdENlMUNrdGVRU1pZRWU3TVA3N2RCbU1l?=
 =?utf-8?B?eHdvZ3pZRVlQakduQkhqQTZEUnVjek9FYWZraVZOL2ttczVTMGMzSkJNMERu?=
 =?utf-8?B?eklydnZhYWI4UXBVZS9XWUp6WUhuRDJYTURibytreHVIem5SaE1FNmZWN2sw?=
 =?utf-8?B?cTVUc1hpckttZHV1VnJVRFMwTXFjbEdvQmlWV0tJT3ZsNURvQTJXeU5iRmdU?=
 =?utf-8?B?VGZCVWRnMyt6ZnlSSjFqdG5BUU9TOW5Qa09rQno4OE5xQ3dVNW9ZY1ZHVkta?=
 =?utf-8?B?akVIa1V6U0RMR0pwOURoK1lOZkNOTVZSaFEySTh1Y1Y2VGx0Z0MxU1JnYlQ1?=
 =?utf-8?B?akR3cVYzakMyYUkwV0NQTS81RWdhbU5sczRRTWp2S0p3ZWZ6cTZRczBWU3M2?=
 =?utf-8?B?eGZEazQyUFNlL2V3SGJKd1plQ1Avcjd0OHBtemhxUVplcVhBS2srUWlLZ2di?=
 =?utf-8?B?bUNib1QwL3M2UTl0TjNEdXl3OUtEMmFDQmEzY0I4OE5JTDFCV0RlQWNoSHF0?=
 =?utf-8?B?YStCTkhFR0lLMHdta2NTQThrVTN1czBzdWFjbjd3bm9sL04vMTlwaGdyY0E4?=
 =?utf-8?B?aGJVa3kyR0hXemhXcTdBaFhIQnVXRDdTVi9UazE1SklyaGh4cWhxT3ZRV1hP?=
 =?utf-8?B?czZueVlBWXBjbVY4R1hhTHhiS1hlOUgzc2xrc2tIVkMzQlBPbEZIdTNBNmZZ?=
 =?utf-8?B?NVhyWXJXUmVOaEJkMURlalJwVTBOdzcyQVlHMWdIeSs0ck5hay9yRW5FTjZH?=
 =?utf-8?B?Q0FvUDArVkZXWmlLSW5WODVlWWt0amx1Wjkvek9hRFFvUnNpU1FodmlQU0RG?=
 =?utf-8?B?RVNqaERqYUtGdk10V2ZwWlEyU2xNR2RJM1VYRVpuNkxReGJCWUx0WXZ2cEVE?=
 =?utf-8?B?V013QWtnZHNWeThMbHBzdlB1Tm9SR09udGx4WjF1Z0ZRLzBNY0IrVVhSaXRj?=
 =?utf-8?B?MnJERytrek9OMnV1MWJBSjdkb2NzZWtGK2lETC9OTnJxYVZ2bDB4amNpaHpV?=
 =?utf-8?B?N1dUNjdXWEVnR2hMajEyQi9Ya0tJZG11SjRsWWE2NFo1SHFQK3pTeW95eDAx?=
 =?utf-8?B?SGhua3pySE10TDdabU5jd2tSQUtaNndMZXVXM05VMFNTV0RqaU5wNzkrblhJ?=
 =?utf-8?B?SkxqM2VYbDBhSXEzNUNVWVl3cGhITDNoTE5JT2UxbTJtckpnOStpdU12YlNs?=
 =?utf-8?B?NTFaODR1QnY1U09FeDA1bkp5WTdPbndKZHBlUVVocVR5b3JUVk50V3BXRmlq?=
 =?utf-8?B?SkdJQnIwV08vREdDTzdTNHBLMkFaVWNtVFdZb3hCVVJRcTVaNjRJNjZFaHNa?=
 =?utf-8?B?Y1pXOVpjMGtUY2paRFNaUEJEc3pqSWdxaUEySzd0N2NvckFBWGZIUCtNVUFa?=
 =?utf-8?B?VDdBTUJ6SmRVVGtpTnh5dUJxeWFhM09PcEhwdGhXOG1XYnFWaDBjbHo2cXRW?=
 =?utf-8?B?Z0xSaGx3OWxvYWhiVXdXMjdlODh4QVc4UkVCZTY0MnZxa1RUTStpOW1oT3Bk?=
 =?utf-8?B?b1JRSmlkUTVOQW1oNmx0S0MxWHBMZ1VRbkpVU1h6a2hRWkJNQWNRbGFiN1ln?=
 =?utf-8?B?SmRwcm5wTGh6NWJWMEMzcCtERGV6UW83d3BHSXoxMjN4bUc0Y0VpS0VZam5F?=
 =?utf-8?B?MDFkNjlRd091R1FmeDRsRXFGVUFlZERVYjVpR015aHA5NlhmbE1UTTdmK1k4?=
 =?utf-8?B?bWlOblRzc0g2N2hGaEpMalpFMWpCWjJxbUNHMDB2UWYzeHlXbzdwcERLTHdw?=
 =?utf-8?B?NUxYR21vNlQ5ZStCblNRUGFHeStYZnBFVjc1bTM1L0hZaHRmVm5na2ZmNkR4?=
 =?utf-8?B?dllVRlBWUHhjVE5wdGVHMSszSG5zNUU3ODllaXRJc0lUTjczakF6NjBpK0tm?=
 =?utf-8?B?azNTTTVEVlRyazFPYnAwc1hRb1VkVUk0TXRzcGkxZC9FNC9zYUFBVjBMendz?=
 =?utf-8?B?aW1mN3hEQVIrQkZyU2FhclRVRmpqNXc1NUtLcWVaZ05iSWF5RjYrQjRpclNK?=
 =?utf-8?B?NzlFN0dsSXFKRC9EL2JGeHE5ZzMzYWgzOXpIWmVTODJkekdlYk40UnpQUmVO?=
 =?utf-8?Q?sQeEcSKr3qHrkU4xSbKVt2Fq19uDlTMVYGyBlPwsugPf?=
X-OriginatorOrg: criteo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48bd102b-5909-41c5-00a1-08dc4449b586
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8989.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 17:10:54.9657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2a35d8fd-574d-48e3-927c-8c398e225a01
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OehxWiFxaBNFccW1Ag22wVGbM9C+twf9Ytj7ITxQ5AbPek++9o3kTaaa1PN2He26cr75DYhDpjI6OyfpvevzDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10177

Le 14/03/2024 à 17:10, Brett Creeley a écrit :
[...]
> If this is how the max_mtu is determined, does it make sense to set this
> before registering the netdev, i.e. netdev->max_mtu in 
> i40e_config_netdev()? 


The absolute max is properly set but I think that's only true if we 
ensure the value of the MFS.

So if with another patch to set the MFS to the right value when asking a 
bigger MTU, having this value makes sense this is the absolute max for 
this device.


Erwan,


