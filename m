Return-Path: <linux-kernel+bounces-99155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BC5878429
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93493282E53
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BCE4597C;
	Mon, 11 Mar 2024 15:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="y0KEz5eD"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E25547F42;
	Mon, 11 Mar 2024 15:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710172117; cv=fail; b=Z01kZh5H8TK/Co5NxN8sKrUCzFkzsYkJoyUV2Bn5Dhw+j/12Z/8iDSYNqlbNV3YjBhPK5e8yWxMDAZ9A20hlIQGUblmOg0pMwRSuhg3IKMgQD57froP1br8M3tmQ1s4Yjza90G/+RmgesXjY/FZOuYxfergBuD+OwF6rtbAgDPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710172117; c=relaxed/simple;
	bh=iN0ooDBlds92WLn4pfWbKyZgLRkfozshO8OUObhVVuc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ew0tu+WarptH4XvPB/0lsKbJ9SbRz+Kf033LUWomcS7seKr8G7RjHbXrhlYYJubYqoeAQZP/sMcVEvbfkAFLZH49/luPuCVKNI6JD5P/3vVANFhn5Uz4DH2LtOK13Fal/kZViaSwZb6bppym1X/jzXTZnebKuZEZesgVeDe3aT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=y0KEz5eD; arc=fail smtp.client-ip=40.107.93.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VcSNfjF+7THWSUGNuy/3B0yDGTTlM3FhvaT7N6niQ1fQgDMd1a9bfwfvAOZksFmgjAFDYcETXbb80oGnQqkYkCQAPNro54DilsUKlCyRXYFs29gJGGmFs8I01jwwe5fozi0DwAa6Wkt5H5CfbPcXn5VtwR5v916dd5vTAXI5+2zOyclgX3os+EzTXqIoRPO84X4JZcfL65ROl6uOTrSiY6xvUjP3dPIeFHNG3HPttSs1GklbrmH4esEntHD4++aZDHVxQIyPXP60C5hCN+OGn6euN/9zpiUQ+eJRTLZcQweaqhK6ikAwDagzc9vrFrnvBPhWTjLdS5i0DS2QzMatfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QzQxLd0inIBw41tDmrDhV2LRjUbq7K1ehflu6uiua1U=;
 b=FG1wjTaLDY6vtAD98vTSvZ9Kun6EO9qqDOa2/ULJ7Uz1dQ6lKgNqHn9G3vx5lRwkLaBLv2VEEHLne1fleIFirrQjucMJY2Adr/z0zxKrSjDXHhDSrodKYLt8C+s3r3TUSe6WxreU+sCRjEQUizAbfppJ2iPnumbyTDsZeDdRZFjVX5Wz10WKkcC0UOziHOWx/gMQJTH+BEyPrrsTb/FWjlr+fGTjVr1mECMv+CuWK03f+jnRMCyArHTMv6cdLAoJ6Kz3CZOXVvjz1ZB6+lU3ibkix30g9FRn/+9HQUXpnbnjF8FMIVAfVUqUuJHQ0CQoy+ve8utR1yK4E543OXRVZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QzQxLd0inIBw41tDmrDhV2LRjUbq7K1ehflu6uiua1U=;
 b=y0KEz5eDme+9tta7X91XzRb0RfSwRF/u9A5OlLvKl9JOEXU8jkpGaAfcVvcK65SrF1q/GWyFiwGKK85GDWo++6oGu39h1PK06ip3R8znm40+yvvSgFJcFSi5EieiXe10w5UyDxMBsr1s1TQU71vnnMviArv/VNyJetn4uhxbLU8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by SJ1PR12MB6025.namprd12.prod.outlook.com (2603:10b6:a03:48c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 15:48:32 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::57a8:313:6bf6:ccb3]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::57a8:313:6bf6:ccb3%3]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 15:48:32 +0000
Message-ID: <f38b7a66-a141-4877-811d-8c14d09ae4ea@amd.com>
Date: Mon, 11 Mar 2024 21:18:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH AUTOSEL 6.7 18/23] ASoC: amd: yc: add new YC platform
 variant (0x63) support
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Jiawei Wang <me@jwang.link>, lgirdwood@gmail.com,
 perex@perex.cz, tiwai@suse.com, Syed.SabaKareem@amd.com,
 linux-sound@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>,
 "Dommati, Sunil-kumar" <Sunil-kumar.Dommati@amd.com>,
 Venkata prasad Potturu <venkataprasad.potturu@amd.com>
References: <20240311151217.317068-1-sashal@kernel.org>
 <20240311151217.317068-18-sashal@kernel.org>
 <023092e1-689c-4b00-b93f-4092c3724fb6@amd.com>
 <9c4517bb-2e8c-4d60-a6cc-8ce4b2c3ed2e@sirena.org.uk>
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <9c4517bb-2e8c-4d60-a6cc-8ce4b2c3ed2e@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXP287CA0001.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::13) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|SJ1PR12MB6025:EE_
X-MS-Office365-Filtering-Correlation-Id: d5569dca-1008-4b35-84d9-08dc41e2b43d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uo4Mj9VVV+STrD0UH5+qblAys7DXKrlTyHOr0DJrIW02cmzbP7njB44XtsLhpIrE2lK0DoS457WnWtXFZxnY+VswQkeww/+d055rxl+StLQUbBLLDROAwAvRjFuip/RUggOkFKRcTvAXanQmBLbMUqpB7ULEQqbDZxGzk7tOtle1OZi6LGI0acit+7s+yqLuDg5CULcYUOIcjCt6GmIQIIKdboeKjprYqQWfbJr//nkvOVqzfjpuhkvHQeRrSdAayTL1fp2Gs25lHmM0wlNroXWIUS0amJLIJGsM24fOTd+/VwAIhmcebq5V5daaiWMhGTbA/j3lPWascZTsiIC45DciiE2TAY+8Peae+cNh3M/SPIVRoL5hPJdTqlVLsgBK+FdhXSRS3/Ej5cljjGRxdYpNKHoAVdJ4iHxiY1plZvXO+LoC8Vrirg0ao4eV50hSrRmZJjoxvE2H8w23fV4vmwmZckkqr3UNBIpYnuWml83DW/8MCLTvNGIyRAUUJFufYBkjhzwBvOeJtN3JP6ts47bDnKzNUE3aigq3kemlqHOYVVU+HrwCar2dVkq9REp/2lCHKDtc0QAHKxSkA2teuS1ZMFa2z6HuSsBLgug3dtlW/705LoKx13+AsUJfjDGcRRyHLKKisGUEq9cBDVz4jqScubT9qkCc1ydvRsPSUuE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RnA4MHNPU2Rhb2hOMXAxQU8yZ2xrbHFLQ1VqR1BRcGNEcW5CRkRuTGQ5cTVB?=
 =?utf-8?B?REFmWHFlMDRuOVRYZXdFRDM2Wk9UWVpEajE4SlYyRjFmZ3hORVZLRXhrN1FI?=
 =?utf-8?B?YW4rRlJRUkY5N1lEL1hGYmFkYmNlbUdtcTZHMWVkbFhWeGxoazhSSlkrNll5?=
 =?utf-8?B?cmdteDY4djl2MVJNaytLYlN4QlA2RVgyeUprYjhDZEtDcUhRcUxEL3YrcjBL?=
 =?utf-8?B?QXQ3SGYzNXBKQnc3aEV6QUJwSlp6TXRPbW9OWW1GYTVxQ3JBN280ODQydU96?=
 =?utf-8?B?ZjIyRjJxMnZKT0NoQlczMnNaNGg5RHlBOGFFVFh5Y3ZNajlKMVNYSlg0blF6?=
 =?utf-8?B?STFEQVdDVzRDN2QrTkZ4V053aHg2QVFsb2tGdGlMMEo2SjBoK3ozeStELy93?=
 =?utf-8?B?YU1YZWNjd0hLOFNpZUdjZkF6TWxoWWpMeUl4aVYybmJZdExMWDkyeXB1TE83?=
 =?utf-8?B?T2x5dFNEN3RWM09GbUFNdjBBNk9DdGtqazh1SVl1amRGeklqMFdXWGlSVzdq?=
 =?utf-8?B?L1diS1NuSy8yclNoRGtxeG5vdER0TWVCMkI3RzJTbWVBeUpRejRXTmdvdEo1?=
 =?utf-8?B?MWhoaTRNTDVVS2dIT2Era05iSmdHWHZSWWtzOFQ4aXBKcnZqVXdwTjYyeGxK?=
 =?utf-8?B?d2tXbkRKRzIyVWNlbTVIbi8wTm5Ud0tVUFN4aVF0L0hjMmpSMDc2OHhHbmZE?=
 =?utf-8?B?OUdkNjZ3WVZQWWV5d2hWWVBOcUY1ejZ1cWdNVEZ1enJ5c1UrVFdGRHRvek1w?=
 =?utf-8?B?UXVFRmFsTFgwMjg2NVhSeEFTZUcwYXd6R1NnaFNUMDNwc2RxMmNlSm4rditp?=
 =?utf-8?B?dFZXVjdqT0RSTCtaQVVQOCt1YVE0d2Flb1dlVXVCMUZnTHFrZlZCRThCVFhm?=
 =?utf-8?B?RktNcllTSGx0R2lVOGZiV3BkakhSZkxvRmkxbVovU2FaNFEybzhDdHNBaGox?=
 =?utf-8?B?TEd1RmFUaCtORHBJeThiVUkralhzaDVxbnczTUttVTZRaE16bU1jQ2dFN05J?=
 =?utf-8?B?YjdOUXg5QjBPbGJ6R29QMmljZ1ZuME55WGhiRllySWIvSUE4NXRRREFzalBh?=
 =?utf-8?B?dVkzNG1RU2gxMlhkT2FNMDNNaGJVNjhmamFoWmJ1d1NhYk95NS9UbWRqTDQz?=
 =?utf-8?B?Mm91VWE1a1pLUWRxREFtR0U1TWQzN1VCYVNKRzJZY3BraWkwODZmUU5Xbjd4?=
 =?utf-8?B?UXZsd3ppS3VBL3A2M1lsNmFwQnZ1eGQ3QkN6Wnh5dnpPYUpiQ2RuRHFmZzUz?=
 =?utf-8?B?QnVYWENDb1pxZ0xHZ1N3R1dnTUYvUi8vaEg0SXZlQVdGS1lSM0U3SWwrU2h0?=
 =?utf-8?B?SWVrak1kUmd2TjkrVHF4QWpyTnhvZXNodTRXK0FzSy9xaFZNdFVkeFNjcGdw?=
 =?utf-8?B?MUs1WTdITHh2MFlsOFBzTks2OG9XRjBxdXJ0STFHanZ2Y3p5Yjh0cWs1WmQx?=
 =?utf-8?B?WUE3ZjZtTSt3ZHBBL21ydkFtRjdpUk1VNUN4UjNOaGUwNXpEcHJkT3NWY3Jv?=
 =?utf-8?B?d3k1TFExOWg4b0liY2RoNUxVOG9TZXVxUUdYVjVtWmFSRStlV1pxcWxVYXh5?=
 =?utf-8?B?ZDRRSnhaL2tORFVIRUhyRHM1d3EzUGxVU1AvYWxueEJaMVNYMXNYcCs4bDhL?=
 =?utf-8?B?RWZXUW1lU0grTlJ0Rk9ITUg2S3MxWkVsekJldUZaZitpdm5mNHJCWmxXZTVS?=
 =?utf-8?B?ZVh3YlZ0ZC9mdWlpTEtlQmp3d1J1alRoUWNxUjRsalJ1UHJrN2RrbnNVdDRO?=
 =?utf-8?B?NmYwemJLRm1kQWVZZGd4K010dUtqbUVKejJQMjJmYjVGd1ZDUWhueXRoNkdB?=
 =?utf-8?B?cXR0OXpOWGZUbER3dEd2TWIxQjBuZFZvVmpsb21rT0doTzdwTXFReVBKUHh5?=
 =?utf-8?B?NlZQSEpvTCt4bG02OXU1NEFDY01xdUZ6MzJicUhQd2V1enhIRVVGakJQS29P?=
 =?utf-8?B?WUQvUEJMYWh1K0I1QmJaTVdjdnlmRUZ4U1ZnOWpWbjQ4NGxoN3dCS0dHQmZO?=
 =?utf-8?B?d3ZoQ2o4N2EvWk1OVzI2S3J4ZkU5TGZSVzdVMm92N1Ayd3c1NUdpKzh4Ky9S?=
 =?utf-8?B?QkJ6MitNSCtDQmpvN2Q4U3doenR3ZEswdFN5alFhSkhiSUV3Y3ZWcU56aFpC?=
 =?utf-8?Q?X/brlDSEJeI/a77i3nCHsTwSE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5569dca-1008-4b35-84d9-08dc41e2b43d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 15:48:32.5689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xG+fOKCBIOsPHgzmYZreKi4xjtxbQkYLZdR5wGGmDLYLYFrFt5MdCddmJ2sQcSbddocAybsfJrFSggBBbqaCFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6025

On 11/03/24 21:13, Mark Brown wrote:
> On Mon, Mar 11, 2024 at 09:09:26PM +0530, Mukunda,Vijendar wrote:
>> On 11/03/24 20:41, Sasha Levin wrote:
>>> The Lenovo 21J2 (ThinkBook 16 G5+ APO) has this new variant,
>>> as detected with lspci:
>>> 64:00.5 Multimedia controller: Advanced Micro Devices, Inc. [AMD]
>>>         ACP/ACP3X/ACP6x Audio Coprocessor (rev 63)
>> This patch has to be reverted.
>> Pci revision id 0x63 corresponds to Pink Sardine (PS) platform.
>> Its not yellow corp platform.
>> Already PS platform ACP driver with PDM controller support available in mainline
>> kernel.

> Is this already corrected upstream?  If there's a patch upstream that
> needs reverting please send a patch to do that.
We will send a patch to revert these changes.


