Return-Path: <linux-kernel+bounces-77828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06057860ABC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 07:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3C5C284AD4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 06:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB5612B78;
	Fri, 23 Feb 2024 06:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nnKcdf9Y"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95176125B0;
	Fri, 23 Feb 2024 06:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708669313; cv=fail; b=U5Yoveg6RsnDYrdqwXuvmtnNEBB9yHdPH24IJmNquFANuSN5kJTUBuhAykf5NNMMjlAfxFqGXlwYDwU5LMLjCvEtU+XZr2P8sbSe/YvOdIn8GsC17cj03n803nTBVYDDdFndyhIB0WNFFbQiZkBM8G/7XzjWtLuu9/zWMZJdpyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708669313; c=relaxed/simple;
	bh=EXwj+Boti7e4/XUgIM014ypH4EEbcgNuS8lH5v0lzws=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Mx7pXM7HM3/w3GrB1eUB1g+mzwOsrKNvLORzN7YTvHomAGW99vUM5QxGhnBqG5rodbaMQetnpztAqky/ze72Vhg1xQ7JQMPR36yz//ah9Im1MMuDnJouhBzaqCwsBBE+5o+RPZ1sTJyfbQVUKVCtJgl6jW/7XPJpsjjmceyg8hE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nnKcdf9Y; arc=fail smtp.client-ip=40.107.94.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQwt7QMQ4vg2DHUTfszXcF1yEqY4pJafhKccK5VPHCt8UzxS2Y+eQc08NT8pFMOOKtrhH6WJBk7HlgIrMpg82bz+SP1UibSLks+Fvy/c9loPgbSFThXwcXZ9dQShB5tfWlWsMGHM/WHNDiUTPUpwQQjcbb6Yx090z0wjO0wkjG7PkTXIrgo3gwexki8sVbKtsRhFx7OhVJ0DfjTeKdqNc7FlCieAKWUJfE5kdvSMO39vZoSjelzzzfEDV6SJbh8OYwCpHelBmgRUKv0rk30erJOSwnFnSHIw0nziILAIXEXU3NWFHk14wS5bI8S3mpcmutoxhWyZWASNtkuB82S2Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hRZvg+21Icz2II6QO+bWMRVSCPLgQbS2dOXi4VLSg5g=;
 b=l4hMRZZ8FDK7o7eJ/grUYoJWD2Q4sP5xZVuxydX+azg/f8owTrBkAP9NfN1A+taC0Lf5Nwt4dc7DmVnww2LEdwEnq4NLiu1cwRVMLL7xDKwUW2LzTsORSf3gg+39nxK793HXrDRIz9PG6RKjSbqgoUkPb34dgi/NBs6BSe4O8TdWOX/51RHlyd298yg6nvbR9IJcPeErxrYBvGGbJwkw10sqyZFHodp0UzV7pxrF9k41gGSTvLStWqLWYEFliE05b8QltLrAv8Pc8hm4uf6fTSlT2ORAQf567K2+FU/hobmLVJcd9pC4J+FW/UaSnZGHz4+kmQDFYuQQfWUgp8OEeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRZvg+21Icz2II6QO+bWMRVSCPLgQbS2dOXi4VLSg5g=;
 b=nnKcdf9Y5pHJTtSoJZDkQ+TgI7ZhEFsvo916jJDK675FXSptALNOxXOdsqkDMDv8E042Z6AVUbqzp9/NpvO978VvHGwoCr32BoCo5yMkp+YQjbeV45NGU9CORboAXN+UQaWb7ZzdmarWdlu1nAr9As+pHIDL3LPrxJSylSW0bNM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5946.namprd12.prod.outlook.com (2603:10b6:208:399::8)
 by PH7PR12MB6468.namprd12.prod.outlook.com (2603:10b6:510:1f4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.27; Fri, 23 Feb
 2024 06:21:49 +0000
Received: from BL1PR12MB5946.namprd12.prod.outlook.com
 ([fe80::b440:9a95:dbfa:ae67]) by BL1PR12MB5946.namprd12.prod.outlook.com
 ([fe80::b440:9a95:dbfa:ae67%2]) with mapi id 15.20.7316.018; Fri, 23 Feb 2024
 06:21:48 +0000
Message-ID: <78730bb7-4588-4038-9336-eec6e2635a75@amd.com>
Date: Fri, 23 Feb 2024 11:51:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/4] net: macb: Enable queue disable and WOL
Content-Language: en-GB
To: Andrew Lunn <andrew@lunn.ch>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, linux@armlinux.org.uk, vadim.fedorenko@linux.dev,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, git@amd.com
References: <20240222153848.2374782-1-vineeth.karumanchi@amd.com>
 <20240222153848.2374782-4-vineeth.karumanchi@amd.com>
 <024fd8e1-8d1c-4073-99ff-ae8c5d123baa@lunn.ch>
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
In-Reply-To: <024fd8e1-8d1c-4073-99ff-ae8c5d123baa@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0104.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::6) To BL1PR12MB5946.namprd12.prod.outlook.com
 (2603:10b6:208:399::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5946:EE_|PH7PR12MB6468:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ce68279-c6f5-4167-9a14-08dc3437b771
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	y+YE+94QSTXb0f1Uuw+SAvLxuub2wbQaifrLR0tUxWh8hkS0fE6LniAMhho6w6MvL1LP64/Gsk3h3JxZvra+xLeRRe1W1gN2UkBEScVvEJiC3UaxNmWw8N6kggeKidJE9z2NyaFdo20tFLXa0XR/+WxwicZXNx77iSaDN0chAxRtAYVgMVXW5Lqk0o/m8nkKBe/Q5kW2bZCi548W1ji6Vj/g1fwCITwcjsoBvyVYjFmTcJHDDDLwBwAiU4uXC/5mgysw8JFjQRineUHW+rPCN1OdGAaus8tBqxAEiS0fZkNO3QCxjpjay5slNEGyvjgH6UKR4w2UOa0pgGdwxzmKt6Rvrfc6LTNfQHI/LSdHoM18HS+SRZrOiuii/AuqPU34pUmCPjtIAzzIn50FP5RwuZdFhIncKc0ro4YyZ34XTd2TOAzFRe3OG49raCLJLEzRwWlqHUf376fmSyB2yaL7Bc3YIzPNxjOVz2k9udmDJDAzU20WZo76Ae9EsaR8FZUKX1Nr8mr/ikjyMgXtAgCuMAYj9p2vT62NrN3+bdJWjos=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5946.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWNMRkxBaXBuVk0rQ2ZtRlA2ZVZwK0kzakhsSFdWRDdYdnZGaS9Nc0VGSzNn?=
 =?utf-8?B?blZDMitDYkkvNkdndWpLWDNCRDN3ZG5SbFV5K2xRd0RsdExCYTlmaDVLc3Vp?=
 =?utf-8?B?cGg5MHB4c0oxaEVkZFZ4VC8rbHJINzZhV3d1a09MS080NCsxUnZBVjI2aWFs?=
 =?utf-8?B?N3ZzREg0KzBrSm55ZVJoYjdNZUZ0VGU4WWlPRVBFRHNZTVlla2M3OVBHUW5F?=
 =?utf-8?B?aFNwOFpxNkpYMmlSakVaNlhRNVV5VXVjSThmK1lyVzdzR2dWNUxDUENabTJT?=
 =?utf-8?B?RW1OV212R0VCb2Q4N1pkTk5mQmF6R1UvV29hUERVbXNQd1VtUmFRWFBnOFc2?=
 =?utf-8?B?N0FjODIyWlFRMjM2T3N1NTM1VDNlVTc5K1ltRnVjQXZ2ai93WEtCT0pzR2RV?=
 =?utf-8?B?Nzk4RndJQ1gzREJQbHQzUTg4a0NhNTM4c0U4K0pGUnUxeFJCZTQxUUNJTlV0?=
 =?utf-8?B?QUFEUTc5QW0rOEVSTDRqTi9sQ1ArRFFSZDVNd2c1d2FSMzVwVGxGOUY2clgr?=
 =?utf-8?B?YzRsRml2OHA4K003SEEzbU42NXFKVWMzWEJOcHRzbEFGalBPYzJQZVZkMEZC?=
 =?utf-8?B?U3RaY3hNdnpOM1hYd2RLMVdFYnhhQ2owUDN5dG1XVzhRcGh2dzEzQ1U1ODUr?=
 =?utf-8?B?K2xtY2Y4elpkeHNDb1dXUzdvbkMrVVZUclVVTSs0THBhb0JQMVhJNFlYS3Bx?=
 =?utf-8?B?dEg3bTZaMXg1Q3dSdS93V3RrZTlNbkt5MmR1SmdzNVRCY3JnSVZJekJYMnFs?=
 =?utf-8?B?ak1Pb0FhbjNWWGNQVjRSQ3oydnhBM05ONlRzVDZkcGFWanVZUXNoZUQ2MUFm?=
 =?utf-8?B?cDh1Uk1vWURPOU4wUnFSRHlQTzc1OUZVNTcvbnl6L2UyMmpEbjB6dWhDUHlK?=
 =?utf-8?B?OGUvWStmSlJKcldibnp4b3lqc1J4eTUyc2pYbEVPMy9tTmR1bFVmdm9OL3Z0?=
 =?utf-8?B?MXE0aVhnL2UxY25iMHdaSXNUVTJFWDM0bjdFR201WHRiQlpuZ0NtbUtMTThr?=
 =?utf-8?B?NXplR0N4YUhQc3kwUDN6KzlsNG14a0dna2JPMHdJalBEdjVJaGMzY21lTmZM?=
 =?utf-8?B?cHMzZFhaWXNKbHRmTGdDbFZ4YlJLRXBIQlBHcEFVUGVxbHVjRmduWVZZSEJI?=
 =?utf-8?B?aDlzMEtuUVRjbU1zdGo3SGIzaG16WDlNT3JJbmdXaDRnam01OFhpcWJ4VHJ0?=
 =?utf-8?B?aGFHQjdxVDNQVjd2K1N6b3dwdU9kQ1NLTnAxc21FSzUyWTNwWDlRWkU4ZlVa?=
 =?utf-8?B?bnFpT2UvaGxsWXM5aFV6b0FCcnpjV2x5ajJCVXdXZzlGdWpGTitTVDdCc3d2?=
 =?utf-8?B?WWd0Y01QUHBJYmEwdTN6M1FjM1d4NUF5MSt5SWlTR2ptNUJwODdBUmNaYU5t?=
 =?utf-8?B?Ukl2aGh3b2NWNVNQL0pYU3M3MFY0NkZWQm9YNnhQUnlQYzVUL1BKOFN4VG9p?=
 =?utf-8?B?bWhrYlRJY0ZOM1NkYjdCUmxLaEFMQWpXaDZ3Z21UWENFWmR0Zy94QzRmaXVD?=
 =?utf-8?B?SWhqSmNQZ28yTkF0TFFveU50RlJ0TUJHK2JCTHloVmRxeXp2dUZpckNkaTRx?=
 =?utf-8?B?eGxkcXM2SmtoMk81R1dpS2U0KzJuYnZKd0Y0bmFXMVVvWTZUZ1FMVU14VTln?=
 =?utf-8?B?Q2dnVDE3NTdjQ3VNUlhjK1VFa0JoaDZJcEM2UnZXa3hvQW8vU2ovZEZ6UGpj?=
 =?utf-8?B?QVlRNEM4ZzEvMHA3Y0RlMXVJbFNCUGNxTTVmNXBIZFdMU3g2dDZMd1ZBU3FP?=
 =?utf-8?B?enVnMkQ4RVc4T0VROXVMU1FqWWRja3F1YzJhQVB6azZBZTMzcklDZDdsOUZ6?=
 =?utf-8?B?aGdxQkZkNFJSRktvVWlYNzk5SGs1Q2JEQXZncWg3VmV3VUhKWmNIb0hPWGo3?=
 =?utf-8?B?VFRMM2hteDRnTklUdGRqa0c4eHozWXl4U3NlY2xmc1lNSEpHNU5MMkVCVkpK?=
 =?utf-8?B?SDZiWS9LSnRLeDJnMGZUZ1JBbFMrb0RCRkJaWXREQzN5ZklkMEJVSjArVU85?=
 =?utf-8?B?SllvUFBYcTJGOVBGWG5qUFNjaU5iZ1o5dnZaZjJOSCtiNVNmUFFhUVBMdmE5?=
 =?utf-8?B?QXZwVXJMSE9TQmdjdWFwR01mL0tQcm84a08xRWF0bHBBNmEyT0pIRno4Tm9H?=
 =?utf-8?Q?VX/V4HlvGODoO5ZkFTQwWNTxu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ce68279-c6f5-4167-9a14-08dc3437b771
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5946.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 06:21:48.8398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RxXMdCV1/jbVu7plRh2r4pNm5sFsqHBvpV0cX0ZMIYHKHOX8UdPevAR2Goxd8EAd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6468

Hi Andrew,

On 23/02/24 1:04 am, Andrew Lunn wrote:
> On Thu, Feb 22, 2024 at 09:08:47PM +0530, Vineeth Karumanchi wrote:
>> - Enable WOL for ZynqMP devices.
>> - Enable queue disable and WOL for Versal devices.
>>
>> Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
>> ---
>>   drivers/net/ethernet/cadence/macb_main.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
>> index 62d796ef4035..55d8c1f3ee80 100644
>> --- a/drivers/net/ethernet/cadence/macb_main.c
>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>> @@ -4903,7 +4903,7 @@ static const struct macb_config np4_config = {
>>   
>>   static const struct macb_config zynqmp_config = {
>>   	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE |
>> -		MACB_CAPS_JUMBO |
>> +		MACB_CAPS_JUMBO | MACB_CAPS_WOL |
>>   		MACB_CAPS_GEM_HAS_PTP | MACB_CAPS_BD_RD_PREFETCH,
>>   	.dma_burst_length = 16,
>>   	.clk_init = macb_clk_init,
>> @@ -4954,7 +4954,9 @@ static const struct macb_config sama7g5_emac_config = {
>>   
>>   static const struct macb_config versal_config = {
>>   	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_JUMBO |
>> -		MACB_CAPS_GEM_HAS_PTP | MACB_CAPS_BD_RD_PREFETCH | MACB_CAPS_NEED_TSUCLK,
>> +		MACB_CAPS_GEM_HAS_PTP | MACB_CAPS_BD_RD_PREFETCH |
>> +		MACB_CAPS_QUEUE_DISABLE | MACB_CAPS_NEED_TSUCLK |
>> +		MACB_CAPS_WOL,
> 
> So WoL is a proprietary extension only available in AMD versions of
> the MACB?
> 

It is not specific to AMD versions. All Cadence GEM IP versions have the 
capability, but specific vendors might enable or disable it as per their 
requirements.

WOL was previously enabled via the device-tree attribute. Some users 
might not leverage it.

However, we can add MACB_CAPS_WOL to "default_gem_config", but we don't 
know which devices have WOL support.

Please let me know your suggestions.

Vineeth
>      Andrew

