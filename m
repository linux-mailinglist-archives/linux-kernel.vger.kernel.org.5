Return-Path: <linux-kernel+bounces-65475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CE4854D8C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D4B91C28A36
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC265F540;
	Wed, 14 Feb 2024 16:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BX9ktO9p"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56875FF0B;
	Wed, 14 Feb 2024 16:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707926505; cv=fail; b=Xj14El1PSIfR+VRmd1Phnt9/oG4Faf7WXz++A9Nf15xd2XW8zb85eD5MyRpWaGj24V8KYucN7J94dgm1wkzkCh5kBl3GhlYySM/QdI6P6JJoFWmQbk6kPLXTlpArJI4FobB3Pp4qcF/DjypV2U3ZXe7bca+luGvvJ6nU/JJ9Ixo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707926505; c=relaxed/simple;
	bh=awWtq7aRMntof96dYm6pDZZTqzOzw9zQWULuPrB7IJ8=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i+OLxAljrgl5efPzE/Cr87krl5sQ9VAmYxpfZL4kPv7g0fJqw1WG3o3D8H/cNybEYmBAXH38aoMSZ3NaExJjH2HK85MrCKdQdfVfbDuF4hSGYkPvXGz43O0WeVpEMWCrM6PmXPW2pkFG085em/MplekGB/uPBGWRSpy8OP6NC1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BX9ktO9p; arc=fail smtp.client-ip=40.107.92.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bHv91ihVOeL23Nwm6mqVPrDVWuYETEgzqp3DC1vur4VAfS7YpkgOS//mTCLMYpIg0/m75Yvcmc0p8E1gzFeV1XfqKQvDFUGtyzgM33inLsv3bTc92qLkIcc6hktRq1RnLKVgIO2T6kfFVYn4GKPlexXmatxmsToU83UL0Qt3327gkwa0Rcg4Yhz6YvidX3Oa3gZ6u2KYaoa+usY71daSvZsVRw8gEU9UHBzQ8tAMnUXW1gyuIRuRy8UdbPdnQYe7xRpWs412xKvWI0uuHEUZv11uUWRZ91EeW7Gv8gR8DXqhIp+C+xfzi/bG6KQvmCPLeYjw5sVvWY7OazgV/aGPRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PhbScO8XN9vbR3A8Rc2kTjJUEqmtcf2ZmxB8CwVkP24=;
 b=feHig0f+KtNybQFyD9uzOT39JG7vGVo0pdHuJtFB6M4Nzd21eKukGSZnVvb4jFj2O8D5jIxo6LJYAcSCwM92V4AtbO2WVqCpJrnGRvfokTqAvrMzvdb8lTWwtUyK7w2ge+p5d6OCZt0hmZaZpBtiPOdPvFLOa0jM8EKJMILqw/VzXqcqAXWGgLagdNTtul5E9YtKLLC3ijuwnfCfQ8Mc5NMNu9legextlhnG5NQozSyCJCnn85TVS8c09+yAU8JLWco+yeZd2ffVayCxeLq6d5eet7yvN26PtgTOfYHG/2Vzabj+qpqCelhyuCo/kQRd80xyJCcgTEUTfYpDRTxfMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PhbScO8XN9vbR3A8Rc2kTjJUEqmtcf2ZmxB8CwVkP24=;
 b=BX9ktO9plxNCAc/CQiLIU2plMKrUgErXXTdnUGv3RPy5G+fxbOSot6BWOIhoAIsbVmQ9HkO/UD4CgxZ2OR8g6rLopn7fpWczG+0pHozuA21fLn7yyMJCCr3I8zzN9g2taktdsFXSMgk3A4/LzxT2BLo6Tdc3lbB/FfSRRj4I7Ps=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by IA1PR12MB6603.namprd12.prod.outlook.com (2603:10b6:208:3a1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Wed, 14 Feb
 2024 16:01:38 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::3a46:cf50:1239:510c]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::3a46:cf50:1239:510c%7]) with mapi id 15.20.7270.016; Wed, 14 Feb 2024
 16:01:38 +0000
Message-ID: <4107582e-03e7-4edf-8c50-6bf693f2d18e@amd.com>
Date: Wed, 14 Feb 2024 11:01:36 -0500
User-Agent: Mozilla Thunderbird
Cc: yazen.ghannam@amd.com, tony.luck@intel.com, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, avadhut.naik@amd.com, john.allen@amd.com,
 muralidhara.mk@amd.com, naveenkrishna.chatradhi@amd.com,
 sathyapriya.k@amd.com
Subject: Re: [PATCH 2/2] RAS: Introduce the FRU Memory Poison Manager
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
References: <20240214033516.1344948-1-yazen.ghannam@amd.com>
 <20240214033516.1344948-3-yazen.ghannam@amd.com>
 <20240214090630.GAZcyClhFloQfHEqrC@fat_crate.local>
 <9a82e9af-24c0-4277-b4d0-a708bba2cc88@amd.com>
 <20240214154909.GCZczg9Zfb_PXu2qV2@fat_crate.local>
From: Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20240214154909.GCZczg9Zfb_PXu2qV2@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LV3P220CA0023.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:234::24) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|IA1PR12MB6603:EE_
X-MS-Office365-Filtering-Correlation-Id: 5764d135-4ab7-4beb-0b64-08dc2d763a4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3sB+hgoKCyg/+DDARe9LYU89X2HXPsS4nXCVl3xGAQLjfXMSvXq1xSfD+2QK5XHmC4/V9baR2NXgAMVn/YRqU5A1xxprgNdh1cmexdRD3HlGtwhkARyEvVv7bWlqX7KfYVirsMmUyUPsFk+dsR4akCTWx3sTdin2/nDD8XUNiw4SFgzq6zKhut/oLdfzlO3XGKzLtiH+IFVWd77vI6Xe0lb6vhEm+8towy9aaTVRjT4vYb+QQcqxUfrebywt3B81L338+AxPKTuNFVKbwSkc7+8UnSyVQbSIPfqxUYcVPutaDjHxdHo22waL3d3NVzX+pGYNH0e6zqcPdZDqjL1Ep8WUizgBzHJNjENQHc8SCvCM1UsBBV2z4JcXjZxg5lZXuwllEIFo5Nknph4QTUDd1zTSlvgZw4kEGJ8QF8Dy5nsoHRR8p7eyVe9gTmZ534XMas2OoMgfiEjVrJv+7UQAlEETsriA/A2C0jvhwMByXJXdVSyaVyGRnHuz/4OOm/EFAkQdrwJQEgaqiSPQCsdfvzymzZRSalvNWH1yniJPcBY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(136003)(366004)(396003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(83380400001)(2616005)(26005)(38100700002)(4326008)(6916009)(8936002)(8676002)(5660300002)(66946007)(66556008)(66476007)(44832011)(966005)(6506007)(6512007)(2906002)(478600001)(6486002)(41300700001)(53546011)(316002)(36756003)(86362001)(31696002)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFRUUVJSU2czdnEwTkJPWFNSaTU0MXVpVDR4T0JvSjI4Y1FjYkk1RCtNdlhk?=
 =?utf-8?B?QzJkMm9qUFdCcmxjaFFtcm5XR0FOUlNnaDN5T3lrdldXNlJlRHpDNEtEbXpj?=
 =?utf-8?B?OXJRTVloZXNhMDdLVTdwOTR5L2I2VmR3Y1VscHBSc0dkbVBJNGRSbGJnd296?=
 =?utf-8?B?NFgzQnRybEE2T1p1emU5cjdMUndPRjQveCtMOU9MRmNBSDh1RURwWGhxRG5k?=
 =?utf-8?B?OXRNRENIa3lsV21sUHpzZlMwVXBRNE1vZlI2UnpYVHBya0ZnSlJ5cTFWV2Rh?=
 =?utf-8?B?eVVmcWQ3RFZsSVM4NXUxL2F0M1BpWmh4TFc4UHdBeVZiYW0wUXZ1NGljK2Zh?=
 =?utf-8?B?OFp2V1kyQzdWSXJJR29QVlNqcmtXZVRETTlaSjBBZjMxOEk5VXFISzdWTGJx?=
 =?utf-8?B?Uld0cWs2M2w3TjhtUUdZSCs4cFYyUVdTUC8yWU1GaTdXWGhLRWV3S2FZS3Fx?=
 =?utf-8?B?eldtRElyUmtDYXp4MmJLQXAyeW1iK0Z1M0g4cXM5bE42Z3hLdmd0cXdpNHFa?=
 =?utf-8?B?MG00eWREcUtmUmk5N2NSbzJCQWEzTnRRYzBLSzB4dk0vQkZSQmsyNUpHVDBF?=
 =?utf-8?B?YTUzNUFqdW1PQ1hhYTdjdXg3ZURJMXZ4Yko0UlBHVzFqcTh2RkpvVzFxblFB?=
 =?utf-8?B?eGpvaEtZdWJLdmRwMmZ6MWpHLytodHBGRHYvandRWVdKZ1k4N2VTb0xtMHFQ?=
 =?utf-8?B?QTlEMFNtVklBbkx2Qk1SN2lZSytoMHdhc1I5dldHSkV4Y2hHZXJEc1dRVit4?=
 =?utf-8?B?NVpsbkYrRGFQNXpESXk0a1BVOHluRVJ1azFvUW1yNHVsd0pqbXk3cTRCTWhH?=
 =?utf-8?B?WFBscU0zNUV5VzRYWmcrbG5mMUpNVnBoMmw5SGlMc2traCtOSmVPSVI5UDN1?=
 =?utf-8?B?ZVBmdEhDQ3hGam53VnRDYlNqakdmUU9FQ3FvUjA2KzlaaU8rWXFVbTB1TEw5?=
 =?utf-8?B?cXcvRWJYWWxsbTNIMEErQTBnNyswd1RhTk56M01pVmhRMFBiNkE2cFEvblVT?=
 =?utf-8?B?bVFIa2grY2tTbUd3K2hSNlR2N1BoVkhSV0ZZU2tRSVVuMVRkd3g2ekkyT2dK?=
 =?utf-8?B?amJ5ODM5aUZXSmhpZE9qZDh1b0E2b2JBNk52ei95R1BBamlGZDQ3b05SdW9E?=
 =?utf-8?B?OXRuSVlpU3p3SmNYTit1bnNtcG1KcTZXK2RTWlZKV29ORkJxU2dYS3hNMHF6?=
 =?utf-8?B?em8xOUlnazJ6YzVJbGtEbFlpcjR0STFxQUZvcjdaZzFJUHJHWXJDQzhzeGps?=
 =?utf-8?B?RitQUVduY3B1dW5jUmprZ1lpSnZJUW9IQlBRV2JrRTFTVlRlSTBGMkxUbzNV?=
 =?utf-8?B?RmNZQkRQTU9uK2RXY2RSWDRrSnpxWTJieUJXMXJkUUpadElsa0tYVDIzMUNX?=
 =?utf-8?B?OThER1J1TG04VC9ydGtERGs5VmtCRXpldkdSdFhqcFBOQ1drTjZpT1c3K1dB?=
 =?utf-8?B?ejZIZFZUSVlZdjF3eE5odkVQWUw0RVNHQUU1YmsvTlhsSnhFSXlseDdoL2xM?=
 =?utf-8?B?aTJSdDNTUytHREJxMndYSkppSmU0bFZrQnN5SzYyU1NnTGM4NXVWclczMzFW?=
 =?utf-8?B?QlFDQ1N3SnBHS2tIY25vdHA5VmNqaFgrY0pNRFVmRUVEeUZIc0ZaODRlbjVD?=
 =?utf-8?B?RVdrN0VuQnhBQ2F0UjBJR0trR3hFeExXYytvZHlwOWNxQVEwQXhZUXM3NEVC?=
 =?utf-8?B?SCtRSWViak9MZnFrQlp1YXNkR00yZ1I4aUxIc1pyak5CTHBnbSs2OTkyWFhq?=
 =?utf-8?B?eUl6M0JBVkdKOG9XR25ybHpqbWRPRXFDeWpCNHVHdkZUSm9VSGVrTGZHU2Vw?=
 =?utf-8?B?NXpHSCtEV250SklKSkZNbnpnNm9oYmNCUURXV2syRUpMUW5zekxKbTVDYWVw?=
 =?utf-8?B?dlQzWlpUTlhMcXMydG9GQ3Rpc0Z5UDU5K0hjL1NNL1MxVWcycUlZMWFGdzZm?=
 =?utf-8?B?cmVLL0lscXBiV2VNZlFFZi80Z1M2YXFtbU5ZSkJaZkx1TnJYZWVQcGNVK0VE?=
 =?utf-8?B?VnZvQkZPRGVkZ09sOTRNQlFWREpSNXRaU25rNnpsNGRncnE1djJFR2NvMkpl?=
 =?utf-8?B?OE9LVFRncWk0VXJkdmFpMDZHeUZHalVFbGY1TEZESmJ4dEErK3NwSm1aQXNk?=
 =?utf-8?Q?FCdvtyYEr4L3jfBcWWUHuEbQJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5764d135-4ab7-4beb-0b64-08dc2d763a4c
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 16:01:38.8023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lDPxEBG5VxHOr8F5X22qkuHJKpQ/RSU5m9PyFrmtpuwjcowl6kay/1tOX442jLlQ7dEafcCdjMy/eX+kLEm3/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6603

On 2/14/2024 10:49 AM, Borislav Petkov wrote:
> On Wed, Feb 14, 2024 at 09:21:45AM -0500, Yazen Ghannam wrote:
>> Do you mean this should be left out of the commit message?
> 
> Yes, the text should talk only about what the patch does. What can and
> will and won't happen in the future doesn't matter.
>

Got it.
  
> IOW, here's what I have now:
> 
> RAS: Introduce a FRU memory poison manager
> 
> Memory errors are an expected occurrence on systems with high memory
> density. Generally, errors within a small number of unique physical
> locations are acceptable, based on manufacturer and/or admin policy.
> During run time, memory with errors may be retired so it is no longer
> used by the system. This is done in mm through page poisoning, and the
> effect will remain until the system is restarted.
> 
> If a memory location is consistently faulty, then the same run time
> error handling may occur in the next reboot cycle, leading to
> terminating jobs due to that already known bad memory. This could be
> prevented if information from the previous boot was not lost.
> 
> Some add-in cards with driver-managed memory have on-board persistent
> storage. Their driver saves memory error information to the persistent
> storage during run time. The information is then be restored after

"then be" -> "then"

> reset, and known bad memory will be retired before the hardware is used.
> A running log of bad memory locations is kept across multiple resets.
> 
> A similar solution is desirable for CPUs. However, this solution should
> leverage industry-standard components as much as possible, rather than
> a bespoke platform driver.
> 
> Two components are needed: a record format and a persistent storage
> interface.
> 
> Implement a new module to manage the record formats on persistent
> storage. Use the requirements for an AMD MI300-based system to start.
> Vendor- and platform-specific details can be abstracted later as needed.
> 
>    [ bp: Massage commit message. ]
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Link: https://lore.kernel.org/r/20240214033516.1344948-3-yazen.ghannam@amd.com
> 

Otherwise, looks good.

Thanks,
Yazen

