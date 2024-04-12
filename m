Return-Path: <linux-kernel+bounces-142746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D83C18A2FB2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DA18284981
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD64784A3B;
	Fri, 12 Apr 2024 13:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TLTenvHh"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2041.outbound.protection.outlook.com [40.107.100.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146C083CCE;
	Fri, 12 Apr 2024 13:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712929239; cv=fail; b=jv1c9v2CB88cY9LuKbpczHeakoUpd5YfQICUGPBLgv14Mb8gNgQ2RJ9T+aAY1gQxTyzI4+y/YlqaqfhGnWqL4LCeWF5FdZwkuX3JyuVAOG/BXovSRCVAixriaETNJlHdud8vonipiolnv8hMKyEM46FuyM4rFc7IhgcDfsnNNf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712929239; c=relaxed/simple;
	bh=C9XCiuk2LNCSJjUqPMQSSH7e/BSd4iZcx3h60H5Z8O8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZnnHwMaMj5GB/YqljwbicWbswaWPQjQKZ6gLBr17zU+ibSAE5q0o119yWHiBN3T/S5xXGz0XRQRWQVrvfDkmr4RrqN94JGRSz96iuw3HbIAqXa1TKSS2v08gCe5dQDCgE3zTWiTnoqw0dFnFzkOQwgVUcPPE2qLTnEgRjEvkpII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TLTenvHh; arc=fail smtp.client-ip=40.107.100.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c8/fI2pUQQQoT16cKmzBoicsNgiGmRGyebOfIWmi90zyACTkMVB+QqF+Abtlr8y8NUHU2Uzbetihvd6bBYkmQahMN2Ys96HdwTx4VwWgw1+W9a7lNbnKJ977Ixi9Phx7UU8v4RreIRrEWk3SbxnYSDi/U3xWeGTfSLHkJHMLKgN5Ii/l7PgIXIc3L/oZnExRPYPwq37Swup1zJ9MWEv64hmfpHqZJ5qvvbN9UXixN7or4waKmiiDVNhVbWkWVP7KxwpEkmnZUHvMQixvAJFI1fAI9gc6NKnL4JhPTSAyS38gFwhR4neGvAAnuYL4evwC7V/ilDIYA0IfB6v7ROfyjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ls1doFGbb3Vc0Rh8ztifh3WI1qp/RtF4Cykp6ZKslzI=;
 b=jS8i7ZLSNkPRkUELwoAaAHatMI6QBVK4KjJ+ySIaCeVjsPdW/b8NsT3OteEnD2kdffEDi9PEtUVmim9XTxAMvQifiqoEGWgvJbzcyIWDL0juuX66U9G3FY5S6WutagGlX797Xs8kIZ5WUP98WUaVvfmKRn0OffEl+W18OP5hSJUtZudWYe1HbGjAm7yt4JvWH60p/qPCypycEPHircV2ybMycBuzNtigO/jP8WHR7GflPu1uVqUETGsYhfoPtRYGs8POuK7qmqnReBAeB3SSNtvP1eojZNG8IoKvLwSLoxfHneSmRSpqffhUtIoqhhBOFSxnNJb3SBYgiYnyv9Md8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ls1doFGbb3Vc0Rh8ztifh3WI1qp/RtF4Cykp6ZKslzI=;
 b=TLTenvHhXGb4aRdzyzhtxYnd9mXbzUeMLPK4LNqV7k7Y211O0KBYskpQVNXtZx6zpGB1LjkJI5P0iDWiS7Es3iHLsopOM35JavX4yrkw/R1zdLyJlTYkOjBwaGPnnQhMqrieJPI4jMZzQzMHldOmWBQNRZZXKoSnP2KKNjsajxE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5398.namprd12.prod.outlook.com (2603:10b6:8:3f::5) by
 CH3PR12MB7762.namprd12.prod.outlook.com (2603:10b6:610:151::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 13:40:30 +0000
Received: from DM8PR12MB5398.namprd12.prod.outlook.com
 ([fe80::23:4a6b:82d1:a8d]) by DM8PR12MB5398.namprd12.prod.outlook.com
 ([fe80::23:4a6b:82d1:a8d%4]) with mapi id 15.20.7409.053; Fri, 12 Apr 2024
 13:40:30 +0000
Message-ID: <d2e798c0-96b2-47af-bd14-a3c8a8bdc4db@amd.com>
Date: Fri, 12 Apr 2024 14:40:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] flow_offload: fix flow_offload_has_one_action()
 kdoc
To: Jakub Kicinski <kuba@kernel.org>
Cc: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>
References: <20240410114718.15145-1-ast@fiberby.net>
 <9abe0c09-efa5-4ff4-b423-469a2dd34ef8@amd.com>
 <20240411193538.46f42987@kernel.org>
Content-Language: en-US
From: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
In-Reply-To: <20240411193538.46f42987@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0557.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::13) To DM8PR12MB5398.namprd12.prod.outlook.com
 (2603:10b6:8:3f::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5398:EE_|CH3PR12MB7762:EE_
X-MS-Office365-Filtering-Correlation-Id: 7817e8ca-fee3-404d-348b-08dc5af61e65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pMnoBO2F2AlARYsfmyUVZzeD6n7sjIXBrP9WU0/imoLLrFBQbeOvrcPWPQx31FPQ5nwobSWRbor2i5di5tNURhE61t8ZNYORc8ushvlk8GQ+J++KeJiR6oM76awAx+rBpFcFLtdfSWSk1+y7Ou6ywNaYNX6OyqErWf16jLgLy4KMU3C6QXmhfNz4JFxeltLTHCfIFlWgZQKPy6G0ARl7n8ssmpGjNiJQ7UKwDq/QCuHtzOQkLk1AxC+mNcdh5V2ie5pax12sfmOMeDA6Zn2arNDi31WKKvaDcg8Zpp1geW0/6jZFixirK2Sq9YZWnZfFBziDPNiDX8l0TkAHO9wCurMkdv3xdQZXE0Aa+l1p8iLe7kimCE+XqTvFIXNZn3dyyfKjJCxbOj+WVgbcXh7RFFrSKkG4DbEr4xlbNfz1plT8VheNTgtte1h9psmpgoPVzJMEI5go/pGYeVVJ9598c0AVPNeWJ+wu0LbigmFxUl1H16JuDrvVvMZRUdt50LsjWYCthxVxfSUqHgzjdUdX0zuIFHLTzcXgZ/xSJEyaVLij2m4Th0rfbeg67ITg9mQvPhsfgvE9uJTvOL3nUGe6ARAScVwENO9MVakrXBtfOY5aWIFg9Ny0D3yKnelPpfYbPM+/r6vP34aMCZHV1wQsD1nxLteh2LB6YPNrziu+EME=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5398.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QXNmWHNOTXZ6N2xzQk52cnZ3dmFMeXJ4QkhKRUp2LzFaRTh3eFo1ektzRURQ?=
 =?utf-8?B?M3JXdEg5dlRvZVErc0hqa2dabGxMQXk5TzhLUk82SnE1T3lFVHhMdVdyeG1W?=
 =?utf-8?B?Q05IeVhob2pOdUkwckIwT2lmUEE1Vkl2d3NoSzQ2MVAwYlJLYkd2YkRzWXBL?=
 =?utf-8?B?eDFoMm5nN1FhdmF0QVczT2Fza3pGdkd2MmRRZTdpYnYvbmlVNE1wVVJhYi9D?=
 =?utf-8?B?NDVlSFpMWWFUa2dqcTBVeVcrSjJEcmcybWp4TzNtR0dQWTc4RTYrVWI1MVJK?=
 =?utf-8?B?b1d4RmdVL3VJZUpKRHZQWHBXVHFORnBlaUxzLzlMWmh1Y1lQbHVDYkRReDlr?=
 =?utf-8?B?QjFRQ21sa0MrcC9uV24xK0lORURCV29RUHdpV3BscDE5Y0J0bTBLTXNqa2Ri?=
 =?utf-8?B?c2tCdTFPL052SWtjaU9qUFdBTytFb1kzSFA0VklESDVlTGtoMGRzTTc2dk9r?=
 =?utf-8?B?eUMwYmoyM0JyZ0gwVHpiTk9vZGJ4NDFGRkdHOCs3eGkxNFlDMzRuSnYwempW?=
 =?utf-8?B?THdKckRaRUp3TEpyeTdSUUpkL1YxM1dXaVNmUHRQTmRza1RDdkQwa3RNUnpn?=
 =?utf-8?B?OFY2Y1d3dkN4Vkg4cTdKckVSeGVIYjZRM3VDd0tYaUJ1ZkIrdWRKTXBGajAy?=
 =?utf-8?B?aE5SMS9PZGR1Zzkvb3ZVKzNSTFVPb1h1RFlubW5FN1FLekZyNXlqcUdaVTlY?=
 =?utf-8?B?bnRuTHUrdVJadXFIaGtyeVQ5eE9FYVdaSDJuazRoR21HODJRcGZVc0xtUXRC?=
 =?utf-8?B?T2s5MFNVZ2lsTG1NcXFlTEZ2RlRzMDhycFM2ZW9UT01tSWw3Tk9Jazk2TUx6?=
 =?utf-8?B?VG94ckhNc2oyNnljbDljaGx0cDlhR2dUalFaVVVmbWRISjRRY0VSWG9ZUjIv?=
 =?utf-8?B?STVTQytybmgzMjFGWm9qZGVjSEJoUjFwYWovLzJmaFNVNGx2TWZoTHZ0bGVr?=
 =?utf-8?B?VWg4RmtmL0lUTzBBbWpBRVdOWE5hK1VCdXAvOWhVMnVDTTZqQjR0MmdLZnpo?=
 =?utf-8?B?b1ZvRGdHeXU1b3I4bmsrNkExZVFyazRuR1ZsWCtJckh3V1NRbmJYZjdGUWZr?=
 =?utf-8?B?M0Vyc0pKYnB6SEtqZGYySTZONk5VNjNxTjN0SW5yT2FXRVBUa2pNOVdHV05Y?=
 =?utf-8?B?K2FZR2V5akFLS2VjWDBmUHlxME5SWDg4T3hiYTUwbURHcC90emh3TDkvQWZ4?=
 =?utf-8?B?V056QmF2Vit2bVRQeFIwZ2tTaStYOWJCakZ0K0NBZld3QkdpN0RHam5lald5?=
 =?utf-8?B?L2wxd1IzeWRxcmxKZ2hYL2JUWjdoOWNVeDkrazlMRllXV1Y0T29MMmdPR1BG?=
 =?utf-8?B?UnRJZEZLeU1aSEQ4cklsRXdFZENzOGpUQjl2TExEUjJhaHhBdUxBTEtMK1hM?=
 =?utf-8?B?TVh0dkEvNms1M29ZSXcwZU9hR3ovZXNvWlFzMHlQc1B3YUt5V0JJRHNtL1FN?=
 =?utf-8?B?WFBUcnBRSW1CNW91UWxPMStKNjM1T0habGkrdDBGcldDTzFWenlvSGJYN2p2?=
 =?utf-8?B?YkZSbjJ6MmM5dUx0anREZFF4ZWs5dWFUcE1scTJEUk1OSGs4dTFMT0p0cVMw?=
 =?utf-8?B?M1NZZ0tKV2cyajlaa1FLU3dtbVVvazQzSXJVU3lLNTFJbXhBVGtyZ0tVeGRw?=
 =?utf-8?B?ZnFyaStSaHZLRlZmZVZxOXNDNjN6N3F5RUVJNW9kdWRXWUpoc3l6MWREWW1h?=
 =?utf-8?B?VmRsRDgrZ3VHcEZMOTVab0lNZ0FiL3VMOHc1dDU3eVZJMm1CdCtJWnRFMFdy?=
 =?utf-8?B?YlJYNloxc2E0YzI1YjdEZVUvN2JlUW9SbGlQQUxPeE5KaVBxVEk3Rllzendh?=
 =?utf-8?B?OFcvQ01oZzlnd052SFI0RGIxMkVYYmFGVVJ1eVRCV2pFMUttZ0VUbkUydHh3?=
 =?utf-8?B?UWt2eVhjS0hRWDZ1T2NrWkZ1ZnpzeDJJNlhLZUR3cTQ2c2FLL04vWHhSSEZj?=
 =?utf-8?B?Ukk2UUxrZUJOZFZmYmVoSm4wSGtGaVBnQm0wOVdQUzA0Q2w1U01OVFJlemhY?=
 =?utf-8?B?TFR6WWovdVdNWjhORU9ibWxvOFh1aTFnVTEyZW82QUllVmFIV1hNZndVbVNx?=
 =?utf-8?B?OTArT1U4eGt2RDJNQWMrOFhxTHBrV3VzWnA3d3ZKN2FvcU1XM1ZnTzNybWtq?=
 =?utf-8?Q?LDxyzigbeC6vo55B9/pt87D2r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7817e8ca-fee3-404d-348b-08dc5af61e65
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5398.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 13:40:30.5714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xT58MesM1TTq9CjGP5GwqgR+ZXJz7YB4ZeYCtLEjRSuI4xvPw5FNmFY80UZXRLm6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7762



On 12/04/2024 03:35, Jakub Kicinski wrote:
> On Thu, 11 Apr 2024 12:32:44 +0100 Pieter Jansen van Vuuren wrote:
>> [Removed my old email address from CC]
>>
>> This LGTM, thank you.
>>
>> Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
> 
> Thanks Pieter! :)
> 
> Consider adding a .mailmap entry to remap the email addr.
> We already have Simon, Quentin and myself there, from @netronome :)
> 

Thank you Kuba, will do.

