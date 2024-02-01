Return-Path: <linux-kernel+bounces-48534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54435845D50
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B05FB1F26DB0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677C8522F;
	Thu,  1 Feb 2024 16:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="t/T6NL62"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65A8D292;
	Thu,  1 Feb 2024 16:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706805157; cv=fail; b=OQR4KRYvlTyc4tTsHQchB0WNMHfRVZxmZUl8jA6yt2tI8LwjCo0C/MNJeuwlkClggQiLXuND//zcYu0RmH/CIcafd+yiKqtu8jTG+yHw3K4Mn3lZCeQr+zHcwaEtQRumBpsBnN2XpaePvxebW0yxHu5tX+3F32Edjm9fyhUxyVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706805157; c=relaxed/simple;
	bh=SFKcMxLa6hCEukVwQ1akA/vSKDeKzag6YI1oygY2AMQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lNYTtVr93po0JdhCUo/4sxZ7A9lYDrYDQFL9jUP8M//nnNGtQrZ1O+tIFGGcMfFRnrorLbWTupoBwaMNrmeiNj3des6Ng9slHmVenfTZkK8BbbDhnTFBkNW269rM7THrIN5+TUx0K+VWiYeWVWlWdfhYWut+jgNEWKntzz0lBbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=t/T6NL62; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lY6uBC+jTH0FF1Arm9JwIA9/nv4JFTB+i5vh8BvTWD3GcnvEUhs/CwzxXzQtxq4Qy12HBUmIGhCMnxid3luluZS5O3ufjWfx/6rslyBkbkzpc4bBwCHAvx+1V8m8+4BayqJtGovJ+Ot5Pp1WxTLrs3Ym9gRJ9X2zK/Sb3Uhw4MTespwE1hSzCs/oeyjz/QExUiLHW5z2wIxjnewx7qB0Pz5TeD1i4LXcDEJs1Q0y/f0jFwarF7OjKIEQi+/wAf6ToS9+Vi6WAo4Ejxx+NbNA1cSlj4mddJJTt7NmSrjOtX7gR/rYHFkA7rIELmCdMXMs1BQHg6jTx6MRGPnCA33GBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XtOmBt+m10jx4HGUGIj/sJE0nPA97rdbptR6gSuAIy0=;
 b=VJGe50EdAZBjC4KGUx1K0v6aznCBs02Tf7/zvwUORQUhZKfWD2hW7EJGv60zJQKKzvM0NXrszRRX6a2WqOqNrsSB6ksK7FcDCDCHSqF1WGSFYss7fW7/5uZ2C1VGt0L40x+/LT9XRLmnAnrYMhHrnRtH67W9T/uXqYnQvGeyzK6ry5eQbnha44+TYLOX2optuXwcrnlXwpOjgCiQWDofWI4gGwPZgOHcMMOgRNU86t2IR7xgKJxueB7j994/PYVsQlHBpA1+z3hvPjD4gD8CjgHxFWxbpva7lXCx1G6nQD1pb/4zdW3My933aiLbnIkHoQaGOOe5QUVPmB5J21KPdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XtOmBt+m10jx4HGUGIj/sJE0nPA97rdbptR6gSuAIy0=;
 b=t/T6NL62QX+PeaEFIPFgld+WBOyfpVi2AFV9FmJ/+0FZxRntnB8JZGHvdXEULxHkqyXZtfzp6p8xm7RSuD1nfj0suBdor9f2zScLvuT4WbBK0Yrw4EsXqBPWgOeGaNBXZCMtifk1P80e/WReSyy1p9dw21K7eMW2k9V6CMNKl1U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5946.namprd12.prod.outlook.com (2603:10b6:208:399::8)
 by IA0PR12MB8326.namprd12.prod.outlook.com (2603:10b6:208:40d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Thu, 1 Feb
 2024 16:32:32 +0000
Received: from BL1PR12MB5946.namprd12.prod.outlook.com
 ([fe80::1602:61fd:faf5:d6e2]) by BL1PR12MB5946.namprd12.prod.outlook.com
 ([fe80::1602:61fd:faf5:d6e2%5]) with mapi id 15.20.7228.029; Thu, 1 Feb 2024
 16:32:32 +0000
Message-ID: <520f3ba5-3f72-4312-9841-0563aa721255@amd.com>
Date: Thu, 1 Feb 2024 22:02:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] dt-bindings: net: cdns,macb: Add
 wol-arp-packet property
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: krzysztof.kozlowski+dt@linaro.org, nicolas.ferre@microchip.com,
 claudiu.beznea@tuxon.dev, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org, conor+dt@kernel.org,
 linux@armlinux.org.uk, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, git@amd.com
References: <20240130104845.3995341-1-vineeth.karumanchi@amd.com>
 <20240130104845.3995341-3-vineeth.karumanchi@amd.com>
 <824aad4d-6b05-4641-b75d-ceaa08b0a4e8@lunn.ch>
 <09ce2e81-01cc-431f-8acb-076a54e5a7e6@amd.com>
 <9b4a2c23-5a96-45eb-9bdf-cefc99f25fec@lunn.ch>
 <7a063832-e1b5-42df-92cf-66486d4feecb@amd.com>
 <fb8f56b1-c961-478d-ac3a-8136408771d3@lunn.ch>
From: "Karumanchi, Vineeth" <vineeth.karumanchi@amd.com>
In-Reply-To: <fb8f56b1-c961-478d-ac3a-8136408771d3@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0023.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::28) To BL1PR12MB5946.namprd12.prod.outlook.com
 (2603:10b6:208:399::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5946:EE_|IA0PR12MB8326:EE_
X-MS-Office365-Filtering-Correlation-Id: 7616618a-066a-4fac-9649-08dc234363d7
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eyQ/Hc/EcC4VaxUk5vkb5ojc8OmxSjUJeZkRvwC+PzG22b4vk40tXELJGmHsS/Vn9+3aXPmAdk3QK8R4adBzL/sbal9YVUVQqyKYo4Ek+c42e4c0CR/bf3EUzDdqoUFWxji4E0pC1+kz0yyuxoputUgDmfz01wCJapcNwSc2IawfrDVwlmdrrhbU8Ev7k4QPdoLmPaIySj3xUHvhmdf1fzJhXL+33EYO6kTPZLLBchNqHLXgirNDFRFe2VeW0oimSEUm+Ypc5UWu1XpOC5pC2lPSMEqWacRvNEILsqDwqxzbUP7bPcCxMG3r/GNRbBhor82FGfRC4syAIs4cj6rdgsEeXIhyA5LS38cdUHZQHq8g6wuOecQExW5ETreBPhuyFfmwWNQrpa3cM+Dd86xsRgq76fueKqVUFQxMzYeGpJ44vodpLuTeRXVLzsygxIfdRne8jQ6+fgqaTHUp8iClOT/ygQR1/05K3vQNoGLCJC+67iA3GxRSfZJnWrC6H6ChMTYtuV+J2hitxbyMd2ELtEk2CrH2hFLfY5VzNnANCV+KXyTs9O49qIh/fUMGOjg29bZkGAJSdMR1W0sTKyHriNdUbifSfNHfnzzKEY1O/GgcvFaUSOJjkM6b5MMUg4ZL58zMcy2G2v4qPtjFW9GI2g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5946.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(39860400002)(366004)(346002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(41300700001)(5660300002)(7416002)(8676002)(4326008)(8936002)(2906002)(31696002)(86362001)(66946007)(36756003)(66556008)(478600001)(316002)(6916009)(66476007)(38100700002)(6506007)(6512007)(6486002)(6666004)(53546011)(2616005)(26005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3pvK2dTQTdJSU9YVTFlcXlscHgzaE5sclR5QVNOTWxhclpSUXZ5UFRlaitw?=
 =?utf-8?B?WnJiaUU5dXRIUlg4OVozVDVnVHg5d2w0MnpKR2JGZGFQRkt4L2tmNXR0T0J5?=
 =?utf-8?B?SmhMT00vb0w1S1IyMHB4NCtDbzN3QTlyUXF4cUladVdGdGhsT1JuSnlDa3RR?=
 =?utf-8?B?RFRZbG1uejVrSkJPUmFXbkxzVEpzVnhvWjhESURjZ1FJcmJuWDl1b1lVZ2hC?=
 =?utf-8?B?TndVRDN5bDBMOWc3dXVHZS9lVExxajhBUnBwNmlQbHNCRVYrWWdyQVBHQlJK?=
 =?utf-8?B?UXNXWlVjNzhuY2wxRnRwdWlSN1ZqbHdiYkNyR2pjNW9TTFNrNDI4eDZhMExh?=
 =?utf-8?B?YXFxWTRPL3ZBTXErcDE1eDhjUEthb0JENHI2VzRpcjlCL0drTTNscVdwU2hh?=
 =?utf-8?B?WTRSOGEySGZMUXRuNXZRYWxYRGdtMVFwbm1ROUZ1Tm9qWGViVk4yVE5EcnJj?=
 =?utf-8?B?cjNxeCtLVnZOYUFtSzJsenpGY08yVzloNFZ3b3Zrc1YvVGdwNDExT1pSUWVx?=
 =?utf-8?B?eDVyVzdoZm9POHlCSGRTejM3R2xxN3l6TXlJc1FPS3ExRzhSZEk5ZExjQXg0?=
 =?utf-8?B?RlJmQ1R6YVpPbGthYjlDaVdLMG1pOHlEeTk0RTBsOUxRNU5WOXpYdVRTMEhV?=
 =?utf-8?B?MXBUVWNyZVZaUWdxQkQwRFkxQmJYMDZPL0VYWEd5RG1TSFNuN3JrS2pOWjR3?=
 =?utf-8?B?N3M2NENJNnVkdDU3UXZVVUJVcnYzS0txdWhpekZUUVFtRXVGWEhvdENMY1BC?=
 =?utf-8?B?VktYV0ZDNkVTTGdOTVB6OG1WWVFGWTJiU1U5Y083d2czc0toOHBWZnNGOC9j?=
 =?utf-8?B?WWtZcXBoOXhBdkFidmkvSG11TlpTc25HajFRNlV1Q0hYVjErZnJQcXEvQ3hi?=
 =?utf-8?B?bW10YU5kN2tGTFNIbWVjNFl3UXlmeDcvVEhZSjIrWHpxR2xpUyttcVJhb1pW?=
 =?utf-8?B?SSt6ZEFpSHRubFp4c3Ztb1NXUzhCYk9sOEY4UWt3Umhpc0JiM3ZDNHVBQytE?=
 =?utf-8?B?bE5jRmhnWVZ4YmNxU2prMWQ1c1ZVeGh3SlpVVnlGWG9FSTBrTmM4aHVvdFdM?=
 =?utf-8?B?VzZQanpNLzVzWkk3M1hwdDNjZW9DSFVubmo5aVpWNWRHdmJJVk1JaE05ZXdm?=
 =?utf-8?B?NmwyVnRYZ3FBN1BNY0loOExGTHJtVUd6Q3JYTlZJU1dxQVFHRExTWVdhZ3Nv?=
 =?utf-8?B?dGovT3drc2F3R3M2bFVLNWhibjZubWhCUzExbkc0cU4vYm1yc3lYMzRMQzlK?=
 =?utf-8?B?SmVhcXZ2dkpRd3Q1R1dLUzJ4eE5hWmovNlJHQjVCUUw1cy8ya21aWWRUSWtL?=
 =?utf-8?B?QTlVREJoamFsbVlXWTV0bG5GVHhRRU54Y2lPa2dpZlFSOXBXenY2WXRqUGpv?=
 =?utf-8?B?R3huQWZRQ2Q0a2MyeHBIMXhlSU8rcURxZFdMTHJYdytNeUpHT1NESDFCVHVP?=
 =?utf-8?B?aVhtWExGbCtudUJFNFRuSzhHQmhKQlFPamZhOXBNbE1VUXowalhESURsc1l5?=
 =?utf-8?B?WlkxWmgxcjNOdnRCNklPclN4NGlEQkRQTWVZaUVIZGw2KzdBdEgwWVVCYW52?=
 =?utf-8?B?TzdwRFhnazQrY2F2YXMvbDZwL2kyOTl0VmxiOTN2eG4wbUlWT0doeFR4L0N2?=
 =?utf-8?B?UkhmQi8rRmcvZGVkQ21aSFNXdHRpNmYySEdmQ0lOVWJQdVdvbGQrWExObTI0?=
 =?utf-8?B?VnIzanBsVElJdXBwSHo4eWJ4cTZHZ3pJZnBiZDV5TVYwdlZJT2U1Y2owSDJ0?=
 =?utf-8?B?WWU5cGduT01SVGsva3V5WlVrMVNSVnRnaWh4OXNuNXUxa3lvSEtyV0tGSTZM?=
 =?utf-8?B?NFc3U3QyRWV6bzZzcXN6QWtya3BsSW4vSCsvbDZ1Nk1GZCs0V3pRWjZJdVk0?=
 =?utf-8?B?Y09oVHlqRmJReWhWcG1Ha0dMb2JObmRLcG1YeGhmcHVxYkZ1eTZFWEQ3UHpt?=
 =?utf-8?B?djhZWnFyVjZ0eFZ4aWhVYlVSOHpzNGtKMkdSbHpVdlBRanpEUTl4VE9HMkRk?=
 =?utf-8?B?UzhQTTIxTjltSHJBcDJ1cG1DMlFYNjZ6OXluTGQwelJQNFBkbTlJNmx5Y0Rz?=
 =?utf-8?B?djRKRE9NajBDOXNvSmlEVjE5NVpqK25KeWh1bXRHSlI4MUZjcnJwUFhrM0Zz?=
 =?utf-8?Q?+0DRoTfo8d/PfblTaXg9soV3p?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7616618a-066a-4fac-9649-08dc234363d7
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5946.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 16:32:32.5887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e9+rNiEb23sDvwqOVw9h8XtnXg88RPB0SH7JNbEwYyiwyCUuszFdb2j1Ju+MP2+F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8326

Hi Andrew,

On 2/1/2024 6:42 PM, Andrew Lunn wrote:
> On Thu, Feb 01, 2024 at 12:11:15PM +0530, Vineeth Karumanchi wrote:
<...>
>> The earlier implementation of WOL (magic-packet) was using DT property.
>> We added one more packet type using DT property to be in-line with the
>> earlier implementation.
> 
> I can understand that. It also suggests we did a bad job reviewing
> that patch, and should of rejected it. But it was added a long time
> ago, and we were less strict back then.
> 
>>
>> However, I echo with you that this feature should be in driver (CAPS).
>> We will re-work the implementation with the below flow:
>>
>> - Add MACB_CAPS_WOL capability to the supported platforms
>> - Advertise supported WOL packet types based on the CAPS in ethtool.
>> - Users can set packet type using ethtool.
> 
> Yes, this sounds good. Maybe add to that, mark magic-packet
> deprecated, and a comment that ethtool should be used instead.

OK. We will implement above functionality and send V2.

Thanks
-- 
🙏 vineeth
> 
> Thanks
> 	Andrew



