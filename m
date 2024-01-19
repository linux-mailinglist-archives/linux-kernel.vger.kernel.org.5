Return-Path: <linux-kernel+bounces-31341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B273F832CCE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D67371C216F4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 16:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0981954BF3;
	Fri, 19 Jan 2024 16:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="fquh7nS8"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2120.outbound.protection.outlook.com [40.107.241.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC8754F83;
	Fri, 19 Jan 2024 16:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705680435; cv=fail; b=gOYWJcLEDhZ8g5LQb5ekpHpU3vdHACsUOd0yyF6/W2uMvVKksCJLg8Ri2pOwh+N0vVj66dEi/fFTnoUAuKYpj4c1Iutn/TuZH5YEYjStH4saZdGnEB8ARFLX2ZlE14myU7a606jQqa+49b8qLLdhLqzV4MpSbFLlhWwaqO2PEUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705680435; c=relaxed/simple;
	bh=LEbPOsP96D53cRPgeaVZhu+fogKbKKsYHUn6lTRARY8=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q4NM6gxQFP2hi+e4e4ei6H1nVMw7SNn3SauGI7OFh6siTNp7InUThKyaSaOk46Z4mDHSw0pnGOZAOby5xygeYRiQ2lvBoZcsoif/gI2rZEKh8UV7H42XC14W49ZLR9Wi8zS2+rwlF3MnnRtiGjZGwE+S12uzNPNAbdT1e6XG7KY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=fquh7nS8; arc=fail smtp.client-ip=40.107.241.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=agdN22zP1f4sAg64BOhzUTqfumTn6wSdZXnkYlFLfWqxRr3d8IBSKKJsKLtS25YsWbk2dwnwhDO65QJSf5Jyt3KAvz2oyXvgduOkqoS3AziitT94jdVrwp7nL92cJvNwFmLOUgSpBIrDNOGwFwVf/MmyE7egqe184nlIgWgWJdMXZFF8M0nq6TOpfW0ori6QmYWL6R27bF8/ORVQaLUavk/BJjs4h3FphgwGOFAVG5iFO1QTFePkG8uC4+8/yYiywWbAh0PjKlIcTGRBKUl49V8vhbr+t+NWvoEusHQwIR7dqx5HkxS5MZCDENK1Pou2n4l5QeUJD2xFGlBbOuTsPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8WfTOx9HkqesQ/XOy/1jv0TprTm6mMFBII26xw0CQCY=;
 b=DgCNPRyB4H6o9njKJu03+ndvciqmuv3id1tUj1brC/nD50uF71Uitaxu7HvmrEaHwFIf1+jOZbUDL96h00G7oWcJTmEQoP1G7tSztGAQuXm2pp+y1rxfPdlcCg4w9s2wE/phlkiia15QBiF8rooTwwT+b26/5jnTwWgB01ZIXbPqLPeS8u3Ta8ygfqTqOZMBczRur6zYzFTfj+5UYwlQyMhmhQEG37abFpSwmxFRQH1CDc1iqbKCz1F+jrSKlTbEYrb48L1d79upRmbHSIqfOTaBGR2fetMEvm/Dh1bWchdW90pzAPPHXV8Z/B+f5fYgzZZKQsMsaJZqb/R/Jwq5Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WfTOx9HkqesQ/XOy/1jv0TprTm6mMFBII26xw0CQCY=;
 b=fquh7nS8AbbnfB6qxZvap9bZaW6R2BcU6X4EBqKqvBlaSNCSf+2VQ9mC/ehp01wY0p2930IPuYrkhDVHExUavZHk3A56lLTE+JIILDKQqlDemhZ5meSqLbgQK4ouO8GIHGOZiJWTey51SM4Y1jdB/1tO+dqkLkCN9UG+XK+VKtaJzGSCeWOCfFBe8WcxcMHaH00tdKHtEVOb233esHbkIMQYlJ7z9mwQ0K+VUY9fsFlKYW6nsxu3f5Rr2nCbep2yoIfvpXzva2BNfRtwdL1HNdU7Ul78K/K2A4Y5B68QqEP9TK6+8du0vX5d3+AscJ5ehjhYZkkmAXvQ8FoJve8rBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by DBBPR07MB7500.eurprd07.prod.outlook.com (2603:10a6:10:1f0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 16:07:10 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::22a6:5b92:a2d3:860f]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::22a6:5b92:a2d3:860f%3]) with mapi id 15.20.7202.024; Fri, 19 Jan 2024
 16:07:10 +0000
Message-ID: <6d016325-f6af-43e8-ad57-343485439b55@nokia.com>
Date: Fri, 19 Jan 2024 17:07:08 +0100
User-Agent: Mozilla Thunderbird
From: Stefan Wiehler <stefan.wiehler@nokia.com>
Subject: Re: [PATCH 6.1 000/100] 6.1.74-rc1 review
To: Florian Fainelli <f.fainelli@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com
References: <20240118104310.892180084@linuxfoundation.org>
 <96dc2b0b-ad51-42f9-a305-744d9d97272e@gmail.com>
Content-Language: en-US
Organization: Nokia
In-Reply-To: <96dc2b0b-ad51-42f9-a305-744d9d97272e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0127.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::13) To PAWPR07MB9688.eurprd07.prod.outlook.com
 (2603:10a6:102:383::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9688:EE_|DBBPR07MB7500:EE_
X-MS-Office365-Filtering-Correlation-Id: ad3fd333-95b4-4fae-e82a-08dc1908b11e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GjcJZl1W/PWI1Oa18T8udQO6TbABnDr0tp0227nhQon0U7/F0T3TftsU8ceN+1U9dYRu5ZxI8e5cc0EikZagoG7fF+eGKZyIRNpvbLQPXca0h9HTfbox1nrDzNZYCx7bi4shV+wQXgD4QhWaLw9MWtZAmb1ydPgzEGz/hJjh3ovxWYX/5ZiIRuAjt1r31wq4ljgF4cgxXEc6LoN2/IyOAhNFpt1kXWj+xmgH9skQ2x6dEPO6wMhTIsLCqJpDDNtFQ//2HUDW7D0RK3XlV4ZmMkSbQPMow9Q3J2wdaKOmk5d+fut1QByb0FldDPTCEpHC6pM5jPhn1srp5IJmwFjua5j5sDsrcK8smWnfLyftUyemVQs6m2sN2Qi8ce3hQKYaW7HKGGD/tS+TmC24v8i8A+G4Ikz6vpZeAKMVjUOpWvvqbWt+kywz070GXhZwaO4P0x25UBFoTyHdl4Btq+j7cfJejMiC055C0k+gReXxrePyBbFrIiguX+YnQHsAYTBhWqEPprxdkdoirqffrFb6LAaqrpzw7sCJr3g5YVVcdtmn/KBENSwbkCZGY7h6ckCvwPfpRtpGmzgCRFVvEt5U0evSYNsQEBw0HJ5GdL2u8D0aMERysvfx3qo09ubNqV9ZqHGMH6/IeDB4RVpu+sF8Ew==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(8676002)(8936002)(4326008)(110136005)(66556008)(66946007)(66476007)(31686004)(2906002)(4744005)(2616005)(7416002)(5660300002)(44832011)(6512007)(38100700002)(41300700001)(82960400001)(31696002)(6486002)(36916002)(478600001)(6506007)(86362001)(316002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aEdObHIrTWxxT3lsYXEwWisvaG52SHRYLzBvQkh3OUJSVW1YdlRoSDU0Slg2?=
 =?utf-8?B?T0dGMUg3UWM1SWplYmxJMVlWNUF1YTdhY3l5bWJJaUxiQi8yRzVRKzh2alcr?=
 =?utf-8?B?R2NYS2djMGp4MzM2VjNsdndWc29qbnBFaUErWWlBYzc5aDNaM1ZQekRxWUZI?=
 =?utf-8?B?SXRkWjdsdnRtSmJWVzE5TnRnd1pGODh6eGVUYWxOVEpNT3AwUFhobm1Sdkp6?=
 =?utf-8?B?Wk5NblVkcTZnQjgweERLbktyMGRLQ3N0TXhoLy9GVHFENmdwS1lMb2pGVFBN?=
 =?utf-8?B?V0JjaG8zRVpNWDhWbnhVVHR5TFRaZFIzcFdYYzhUYWhkTjI0a1lYTGJCTHR1?=
 =?utf-8?B?V0xjcVhnY0ZUbU5YYzlwbVNRV0ZoNGtDbmtKK2drTmhLS3lld2tlcmdablNZ?=
 =?utf-8?B?VnlqMk5XeTNVcXJYdk5kK0I1S09WRXVJZyt6dlVrNkdmcmUrVGt3UEtJR2lr?=
 =?utf-8?B?UWpFQXhBT241NWdmdXJxR2tyWk9LY0VIUUN0OFp2QzhDTGpDVjdkNUFla1Bm?=
 =?utf-8?B?a0t5QVE4UVNXSEtPOGg0QTVHOTMrZVBZbDc3UWxMcHdCNkdGQTFkUmE5R0o5?=
 =?utf-8?B?SUdNYk1jS2dScEloUzdYV0J4Qldtd3I2K21LV0tNd1poMExGQXRDVjAvWVNQ?=
 =?utf-8?B?VUtrNWpkSXNrMFhhSkI4cGpuSEVOcjZUN3BhYlNPdHdLd2hPejRyMEMzb2l5?=
 =?utf-8?B?ZE1UNjJBZmVwUFdyTmlGUzY4azhXRjRhMHhwbEp0WmwxQVRmSHY2QmhOdmVk?=
 =?utf-8?B?L2F3N2xOS2kxTUtNRnVvWVUwNGJDM21Ba2hnWHhFUGxQT3c0cllXNk10R2FQ?=
 =?utf-8?B?cmRZYTg0ZDVRWFU2TTMxMEUzUXpwV3B2ZG14STkzaWh3Wmcrcy9XcXhwRkRm?=
 =?utf-8?B?ZWZCeS9BQmVhQkxhdTZuZ21SazBXL3lMSVNwWTRSRnBtd2F5Y3FKQk5wZWpv?=
 =?utf-8?B?REhsY3g5ZG5ycjlEVkRzQUIzM2lzdW9BWDZINkQ5cm00YWhyM1ZQNWd3RHQ2?=
 =?utf-8?B?SVV5dEh0QmVJVFZkNDBzNEM4aEFkWENFWTFIc1VZVnRzL1NUQkY2RkdXRnJa?=
 =?utf-8?B?dzlPRkhkdEVaM2I5NWZVVWJpOXBzbmpPU2tNSHJLQjJ4ZEdlcytkOTk1QkdF?=
 =?utf-8?B?MGZMVDQ1VlU5M2x0N0tMR2VNcUNURFR4dkVESUIxc1c2Z1o2cGtQU1JTTUVt?=
 =?utf-8?B?d3RPb3ljWFVTd3hjelRiQzMwVkZrV2tpQjhaUzlzdlFPUU5Uekl0eXR5dzd4?=
 =?utf-8?B?ZFFoeThldG8rNzNDSHllYXFyb0d1VnRWQzUxcHlIOG9mNS9wZ2VIRVJUVTRp?=
 =?utf-8?B?U3oxSGpIaWVYaHhROFV0MXVsRS9tZkZJZTN3elJpeTYwSnZGdStJN3daM3Ix?=
 =?utf-8?B?YTNvUEdGUU5GZTN4VTdPbDRQNitSVVhHWm8wcXVVM3JCYWdHMGhkWFdOV3Jj?=
 =?utf-8?B?cGhoL2ZWeXAxeFRsNW0xRjVKR29ieUJsVm5KZ2dUclB6c2EyM3ZGRE8waDk5?=
 =?utf-8?B?TGVRMkxuNDdxVk1NeWZFNXQvTkFwSkRoaERld1lNSk1hT3FLZitaNkZIMjFq?=
 =?utf-8?B?Rzg4Vm9LRGs3VFlIanc4UEg1azl3UlI1aDlybkhqaGM1MDZ1Q0dycVlLWUlw?=
 =?utf-8?B?VkFoUExTRGM3K2xxZkl4RFZVSU1pZ2MzM25xbmtKYmxBQkxRZyt3Z2V1dlJ3?=
 =?utf-8?B?N0tndklSNmpPYXBKUG1peFo0S2xyNTU1aFlDRHRtci9VckR2a1Zwc3lWUHA3?=
 =?utf-8?B?ZExPakNXK2kweVJJU2xLN3ByMW84U2sxdlZvNUtrZmFsTFB6RTBvY0F0aHhs?=
 =?utf-8?B?NFFwUmlYZENHM1FqQU1ueDZyeXBkRlVaUVhzN0NlSjFsYmx0eXNRUjMyNWZo?=
 =?utf-8?B?Y3BDWkFhejBKUjRvcTJ2YStyVGtHRHExeGhFNWppVTYzL0VyWHZXN0lJK3ln?=
 =?utf-8?B?czFPajE3MTZRVE5XeFhyWFMxdlU5RUZGMmtnUzVJYUVWc1RQa1lZeGNwaTNt?=
 =?utf-8?B?ZFhpcFpnRE5WZThwZHVTOENZaEt3VGJQeG5oVTR1R0lMTGtHWSs5TEErQjJX?=
 =?utf-8?B?VE81MU4wNTZGWSsvL1lZMWs5Y2pZYUtqL0J6NTYyaVBzUjVaRm1ISFYxSWxC?=
 =?utf-8?B?dnMraU1mQzI2NGFwVVIxbjlBWVZ3akxkZGRhelRFNjZjVG9SUllYKzlMb3Jz?=
 =?utf-8?B?QmM0UEI0YmV5cHhpREtVMjVsTHFpbVFoM2NCYmthUWRiMHBzU3VVcjRJcVBH?=
 =?utf-8?B?bWIyT3hwM2Jxb0wrdGpwZnJhWUt3PT0=?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad3fd333-95b4-4fae-e82a-08dc1908b11e
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 16:07:10.2826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sNe1/AT3veuZXLo+DOFvyJPWH7i9kfEMdCUS0mhQp341J/b3V8efYJc/dj4lEFueGESDV/K65uC/Km6dxjLJAIRyUSp4cMAmV3tgAJU9SpQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR07MB7500

Hi Florian,

> It looks like rcutree_report_cpu_starting() has been introduced
> 448e9f34d91d1a4799fdb06a93c2c24b34b6fd9d ("rcu: Standardize explicit
> CPU-hotplug calls") which is in v6.7.
> 
> For MIPS, it would like an adequate fix would be to
> 's/rcutree_report_cpu_starting/rcu_cpu_starting/' for the 6.1 and 6.6
> branches.
> 
> Stefan, do you agree?

Yes, I agree, that is also how the patch looks like in our internal 
branch based on 5.15.

Kind regards,

Stefan

