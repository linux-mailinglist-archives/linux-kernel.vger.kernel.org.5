Return-Path: <linux-kernel+bounces-87292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE2A86D249
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 418761C2379F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4DE7A14E;
	Thu, 29 Feb 2024 18:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4cK6EvIc"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C58D7827A;
	Thu, 29 Feb 2024 18:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709231333; cv=fail; b=iFM+f+UOUaeEMmvDqqgfPdSDJFCrqeIr8WyteLhmrvyhhNL9lv/z18T8PVTaQ46ABpT6hDSMpeMRIy0aXZbTne7Wu9O7W9XdAvtNwfL33ajnyPJbxT8kJvBDNUsp2LE3B+DdjrNYJNc4FXgIyYB3T2IVmRk/vwGlpVZci/7S5Fg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709231333; c=relaxed/simple;
	bh=+vV9+tpmO7/jGJIu6VI4kk3mA6FkeYvS+XG2vnzBp78=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r1zMfMKZfmHUYESSp7sYns5XcN4uE15AMgEYOWMFll1MwqQUExdSgez2p/xNFOOKJzw0/i4RCPWr15EUVTx5giywqwdnt2dc7XMJARZSKWs5P0WT5EfZ/30PQLI7qBvE9MnzaeCXTZjXahrSDW3yrobIiAbthOy5qzB6bqEzLdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4cK6EvIc; arc=fail smtp.client-ip=40.107.244.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mSnHT3vj2CTomEm4VnX5s+lUp/TaVM+sypsVjceBv2VsS+E8mRBeSf4MkNWc1l/n0AP1NFPXYIfwUXsPt2MUW1yq0muA2NbRsEJUSeZRDAHCOuQO7SmB1RProemmPuTHNFBV/8YonFyFVnjwFbe2e/wMRz9TIHApQlRtOjI4KwZHC65szVPZs/0pE2aPlBx2GBWZhlpksGsvaFXrAUAKt9DDe2zya4Vr3IEXNsLFdzN5U1vWHnyBWEXredx2RAkBqpgkxQWnX0rs0AILBwr8qDsn56lLsNVX3rgNV6UKeJfYp5zqRkQ3zNF/V8eH8+IiP+FNG/FAP5+xpWWAubjHtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QA+eMpNskDgAStNxacdGcpJmr3L7XcZ0IX1twKb91C4=;
 b=Vch1YE+ka3k9fBmmrQxSN1rVfzqMpOXlyF8K2DuSpX+islhYzAocWKCE0uWMMdkqR2ZyZA96ttIjUK92pZuUoIggJ+P4Va52OngCACGClop0dyh6lYnYTpWtPijmNr86HlFQCq2lXX3gvBPZ0Db8OkX29SnNWNcQ9kidrzuQYiAAE1Jqsn5SRAfPzYqw8TMG51l1G4yEFQufj8AscnpWhLGatnmEoEgq2J3HCOyTJ5oyxJfTcwzr06Ed1PNtMY7VbmfgyRPR6rFSFBTWiOV73MUT3V1P+GreYJzeUQU3drzFcyVknZv5aOpyxIvettaQopYXq/mwEtrNdm3ybh3xXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QA+eMpNskDgAStNxacdGcpJmr3L7XcZ0IX1twKb91C4=;
 b=4cK6EvIcTGfNmkZFk0Pxb9odvQYPW3PkQPj1IcZMUdmNzK9gZqOrwAk64K+SgBs5ITjqC2E5eBoXlZzK6Pr1kn+HRvHD5iu+lo/BO1sy2N3UwC47kw9ekGrV1q0w3Ir3phZMQRmszpJdfpdRt1juIPMyzsYyQonkz5zNL6a0lKU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14)
 by MW6PR12MB8916.namprd12.prod.outlook.com (2603:10b6:303:24b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 18:28:47 +0000
Received: from CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::aaa1:af99:e0e5:7f14]) by CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::aaa1:af99:e0e5:7f14%4]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 18:28:47 +0000
Message-ID: <f17da20f-4379-4dc6-b988-cb3a07f4aa6f@amd.com>
Date: Thu, 29 Feb 2024 12:28:45 -0600
User-Agent: Mozilla Thunderbird
Subject: [PATCH] x86/mce: Dynamically size space for machine check records
To: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
Cc: "Mehta, Sohil" <sohil.mehta@intel.com>, "x86@kernel.org"
 <x86@kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
 Avadhut Naik <avadhut.naik@amd.com>
References: <SJ1PR11MB60830AF35FA89C7869B8C11EFC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240212191401.GLZcpt-XHFqPg3cDw-@fat_crate.local>
 <SJ1PR11MB6083C60D7584B02E9CAF19D5FC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <ZcqPhVO_DtD2x5N7@agluck-desk3>
 <20240212220833.GQZcqW4WxKH34i-oBR@fat_crate.local>
 <20240212221913.GRZcqZYRd6EPTTnN97@fat_crate.local>
 <20240212224220.GSZcqezMhPojxvIcvO@fat_crate.local>
 <Zd--PJp-NbXGrb39@agluck-desk3>
 <8ee24cad-e9b8-4321-aad4-9a9ba4f8b7b6@amd.com>
 <20240229083951.GAZeBC1yS3MPonWwKv@fat_crate.local>
 <ZeDDLLQWPyyZve_s@agluck-desk3>
Content-Language: en-US
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <ZeDDLLQWPyyZve_s@agluck-desk3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR02CA0017.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::23) To CH3PR12MB8403.namprd12.prod.outlook.com
 (2603:10b6:610:133::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8403:EE_|MW6PR12MB8916:EE_
X-MS-Office365-Filtering-Correlation-Id: b991dc4d-48c8-4d9f-47a8-08dc39544496
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	925q1AprDhmnJnkLxtA51iKESBOBM5bQKg5E1fE0q+j5V4pRwOM6v7xyHRLwsyro+FPOlG7pbGhYqBHpK2ux9Sizy/xl4Tl3nujtJkXRyc5nZq5pmos8vB325cD+1N4VnOXCZHz0vZJmRaO1IBydeIHNb+FU44pOtZQBnkGma36PexoNCGfcLCfB0Za/7W9Ym2QIOJfxHkLEhh7Jr3aGT4RA9/Pk85Fv0Q+ywPf10e3d2LR4IIr06S6tUAL5L3D6nPbhPu/RObMyXhtuIbmMFrSPqBozSDEKwVRUfPTgNL+3EsDEddj97zSOXfKxb0BzXsjeLR855xgRlI48u2fCVCsGG4AQ7pFQrk32DdB3gs0PdmA4bwdUo1lYMIbqj4UJUl/6BuWDCC5uU9sIs/1HFCnXyBo+wOReRZe31zdPEfAGYYzW452F+uTW0oeE1teki2Wuq8548UYuwAij3v7AN2OtZm/smbarik5d7xCVtDeBSDvR6VE+xuN6dj9C44hpsairDjQrMj83Q7pO3ZS6k2uQR/JSi0M4VkzjgIqTBi8LuBYQUId/Ly4CNkV5ljGmqIHSjn8PJpDAwtEjvWzA2QRPLTffXsWaN36NvDyZjRMcZ19AsytlUBqj5gf8VAzVHico2pSkaXBW8fwNwRcA8Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8403.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFJKaXdubFdIdzJUOXlnTlR1bi9TN1pHY2tRTTFQcTROcXNucmlsQlFHUXF2?=
 =?utf-8?B?aFZFdUIrQVJINHZhL1BGdEZmdHgrb0RtdjF3d1dqemZiWThsbG1mcUpIcitI?=
 =?utf-8?B?dUQ5RkszM1NTV1U3aFRKeHNpNmRaWTMrbUQvNktHUmRwdW0wZldQeGdBS1VK?=
 =?utf-8?B?a0d3KzJvRkJPOXdzK1FMc2V0WE1LT0dHOS9PemZCb0NGOUNHN2dEcGRXZHd4?=
 =?utf-8?B?M29DendVWDI1NHp2dk5STkQxYjBxcHA4UnhFVDF1MXNvMGVaUWU0ZkVFdmJY?=
 =?utf-8?B?cG9wZURhOFZXNEZvdkQzWXNHd1FKcDkyVExUZjA2NGJJaVFHQ1ExaVV0aW5E?=
 =?utf-8?B?ejZJa1RFQWc4RVdQL04vNVpHVnA5QWFIZi9jem1PcDJ0QWQ2aUZpZStkWjNt?=
 =?utf-8?B?YWoxTklOQWNmdUNaQTdBdXphQkxQY0hHYnRJY2Q3cjA3dmNRMVlJeU53SCt4?=
 =?utf-8?B?MlRCc25oa2Zwc0VXTXFEenBPekczVE9oQTNnNDJSUm8weUpvVXk0SjlsQkFV?=
 =?utf-8?B?RUxJRTg0ZWJIdEQ3bFJtTUFTdlhOcnM2VjgwSnpZS1BhVHNObzZNWDdGUjBs?=
 =?utf-8?B?WjFwaC9kZ2tDQlZhdGNnUFp6NWsvMFhPbXk0akpaVThXMG9PZ3Juck1vVXB6?=
 =?utf-8?B?YlFNYVVOTEc5Nzc1cVF6ekpMaVQzOHgrOUFSMkR4WXBLK1c0UU1OT0t1SDBS?=
 =?utf-8?B?UzdpbFY4R1lqNW5kUmpPczFzcnVwUHd4dTIxOTdkaXVZWStsSVhGcm1BbEZ1?=
 =?utf-8?B?TkJRb29NdFovTmR2QkltUjJOcXkwdmhMUjJrM2loZ01UdmlsQmx1cEhXcDNa?=
 =?utf-8?B?ejlmTnpnTlJ1aWRzMjNGWnhMUWd3Z1FBbE5MTWl2S3V1KzRrdzgzUkp0OHlQ?=
 =?utf-8?B?aHJ2WmVpd3BFMGhtc1YwZzJURHZHS0NWejh6UE9yZmFQbmNKamF1ODNZeUJu?=
 =?utf-8?B?RnYvMk9UUzNXbTRleG9CQjJEeS9oYW1NMzExcWNPSGRGU2FnbCtpaGJOMW0w?=
 =?utf-8?B?ZmJZQjh4RVdEbXJZOWFhVGFsajFncFpNcW0xUDZSOWpMR1JxY29DbEg1YkZ3?=
 =?utf-8?B?a2V0ZHdTdExDUlVYSk5QUjcrRjJacWlBN1FUU1FSWThtVkoxMVhEa0xXSjQ3?=
 =?utf-8?B?UGVWcXROR1l6WW1qeFM1ZnM0MmxRN3dQTkNkUFV6aVp6WlRSUEZONVBZdDdF?=
 =?utf-8?B?QWJFUzR5SmVrK21Dd2lMUWhEcDFOc1d6TTY5aElWSmIvWmQrbW9QQXRqMVJL?=
 =?utf-8?B?cWxJc0pnWnQ2QUxuellFZTQ4cGVRN09ueG04UWFkUnk5QVBSVS9lMlExWkNS?=
 =?utf-8?B?cTU4czZKZ2lWV21aUHdDRUdxaU9KamJLWEhHR0VyYkNYdmRZcDl5ZVRPQmdW?=
 =?utf-8?B?TzY0K3M5OHI0cjBIbmE2RytWTHJEWFFhS1htUlc5MklmclRySkYwWEVCTEJm?=
 =?utf-8?B?ZHFJa0tXQ3pkY1JhY0w3bUpPTUNTejEyb2RWczZXYjVlL0oyWXhDYjZQckQw?=
 =?utf-8?B?bEtOaC8xV21VNEJld2t1UWlRdTgwRjVTUDFDQXBuTkhaQ0YzeGh6SlZ6WEMw?=
 =?utf-8?B?WFpyeGoxRlFMdm16R3ZBaHkrWnNnb2JTL1pxTml2bGlFUlNvcUtkaTR4KzF2?=
 =?utf-8?B?REpjMnAxTEhXN0E2c1htTnROdFAzREx2Y1kwWldTT0hML05NRWVUdUYxb1RP?=
 =?utf-8?B?SFhmQmptK2RIdXdXTTkxcS92dXI2aFpXSFJoaFliK2YxSE9aMmV6eHAyV1hE?=
 =?utf-8?B?SGNCU2s2UklJK0Y3RTRTMElCMzVJK2RWNnkyL3N1ZDlsbUt0ai82dSszakpv?=
 =?utf-8?B?RmlOY2xCRUd0RzBkbGEyUUQ5NnJFcVBUSHVHL3hyaDU0Yk9mSUNQRE8rdHlL?=
 =?utf-8?B?WXdEMHQ0NUtpbGR2SHpUMGVyelB0ZXlwdXorWFUvRGpiVkw2MEtpQUhXNEkz?=
 =?utf-8?B?TjdMYzg1ekI3RlRneDhjaDJCYUI0Y05ycUVHSm5nUjdTNTllbXRhTXpieG55?=
 =?utf-8?B?NFBvUGkrbE4vbW43ZWRrQ1FhUktXY1ByTFBzMWMvR3hmRHUzRC9ldGI4eDJ6?=
 =?utf-8?B?MkVOVUt5SVB4MUNTTHp4eGlFa28ydWxCUWlVeWpacmJFdmp5VWcxcGRkOXVW?=
 =?utf-8?Q?95CyTahCK36Vgrfr10dzUUqsE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b991dc4d-48c8-4d9f-47a8-08dc39544496
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8403.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 18:28:47.2722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AklhPD6s9f2fIWMYz30z2z7zXWrAmlR4uaAJ4tc8cZjSSKg4ETf9OnugazbNctnCJ8ba71JByAaT5bp4wdqqwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8916



On 2/29/2024 11:47, Tony Luck wrote:
> On Thu, Feb 29, 2024 at 09:39:51AM +0100, Borislav Petkov wrote:
>> On Thu, Feb 29, 2024 at 12:42:38AM -0600, Naik, Avadhut wrote:
>>> Somewhat confused here. Weren't we also exploring ways to avoid
>>> duplicate records from being added to the genpool? Has something
>>> changed in that regard?
>>
>> You can always send patches proposing how *you* think this duplicate
>> elimination should look like and we can talk. :)
>>
>> I don't think anyone would mind it if done properly but first you'd need
>> a real-life use case. As in, do we log sooo many duplicates such that
>> we'd want to dedup?
> 
> There are definitly cases where dedup will not help. If a row fails in a
> DIMM there will be a flood of correctable errors with different addresses
> (depending on number of channels in the interleave schema for a system
> this may be dozens or hundreds of distinct addresses).
> 
> Same for other failures in structures like column and rank.
> 

Wouldn't having dedup actually increase the time we spend #MC context?
Comparing the new MCE record against each existing record in the
genpool.

AFAIK, MCEs cannot be nested. Correct me if I am wrong here.

In a flood situation, like the one described above, that is exactly
what may happen: An MCE coming in while the dedup mechanism is
underway (in #MC context).

-- 
Thanks,
Avadhut Naik

