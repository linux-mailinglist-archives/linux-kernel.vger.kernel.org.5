Return-Path: <linux-kernel+bounces-145867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 938FA8A5C1A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 22:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1657A1F22AE3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 20:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DD915666F;
	Mon, 15 Apr 2024 20:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Bn+yEgDh"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A483156675
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 20:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713212006; cv=fail; b=WoPtVfvjQ9ee/fEdq/R0HR44S5UmnA/VuyyI+KAV1wS5DvU6iFDjAk4WEf9F4fqxt5dXvvNpQ42poNAonFv2Onm62wlb48YH6+1Ivyptvl4MMqQWDTQBjUF1yaLmKzp6dXgDaTn7xMSykceTzNJRa2SxZCdW/8ZcWjtVnXSZ+KA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713212006; c=relaxed/simple;
	bh=TZnPvEe2v8zT938AhuCpo6g2xsJ0/49rzJwb1YrYUjw=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=BqWoTE2EOKpsfyB4/XjX5LeG60CwlTQB24Miy0JkBMn5or2zzJSZnC9bRRfd4+c3jEOSrzbZyiAyMU2Awo8w7f8ZqTEUqCgtWcJCtQEV03DqdRj9H+0xuWQMHRGkmyLdVKWYJgo5Amzb/jEfe08UDwPmrR5pvPZUwBtFR+3DBxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Bn+yEgDh; arc=fail smtp.client-ip=40.107.223.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d+dZ/axVGqk9w1Sc6bvhPnep0vFLZy00drHWZtnPj1lBILoR5oyOV+5CFhKvjT5ANCpZN/NkryPllDv/tdEQW1tx2Ww2cZMCNrDfo5Ch/GHtoiUSfsKwILt+DpWzxrQCn+Cahxb6DcRcNyP3Tde7evf1NT17829P/ISJYpgtr6Hma5HiiDG2gOgzBr8j8bpZ+1R38ZlehO9Lz2IzH8uE+Wnl2+tbF1RvUWYKnBFYxN+KF+Ys3LRJlFMk2N7V2/XLtshx1R9lmwapVVxoKaw5uj4Y6KKfUOD0L7SCewz8HyaX/5kzHLRuP4GGIVkDutq7cos4sDHbfM0EpTLzzJWC/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Ip9zoYwq2tHposTIs3lNXTJyAww9VNhk8Y8ABOEht4=;
 b=X0q0mHQpVgx4hc8abcoRAmukGTk6Q+3E4Lj2wUgRTWmjLMVgPcNm4CfdCIIvA46B9Paz5EOqB2JGumMzuYvDhn/0hstgFCE/Cqp9ZJKOt4W/xGzwqcl7Rz9YgQDrJYQgmZP8htBNt2Ym2temRhy3gcBkUgq2rmjs89khUOcTvehSPyW5np1o/nI5fxIC/2TJXk2HTSFGSHNdiUW38mxUHzODNW+3Jxiq2AbZu4w0vhPIMGVd1mIm1V3i+iEBDe9axJPI7sfnaf46ZuyGfg6c9UF32dSiSr7CIIQF8P3z5zuaW+Chi9L5vPPOHrnlbcPncT8M+A4OzT1zJEjb+hs5ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Ip9zoYwq2tHposTIs3lNXTJyAww9VNhk8Y8ABOEht4=;
 b=Bn+yEgDhyo3eS1gDQZ6Om8rKViM5eL9TmpNTElcrbRlmJ23khyvRtfSxVbaJYG8ReJoFcaWySuD8xS28uJi+bATysX25bserbz34xWgk71AreW/sZujFjDrobzACUjUVULst+8IbKxSGAd+pMxwOUCqD4WIwFgClBP9ObQseDoo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by CYXPR12MB9442.namprd12.prod.outlook.com (2603:10b6:930:e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.56; Mon, 15 Apr
 2024 20:13:18 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52%6]) with mapi id 15.20.7452.046; Mon, 15 Apr 2024
 20:13:18 +0000
Message-ID: <490a6a10-47d0-0689-432a-cbf22de11ad6@amd.com>
Date: Mon, 15 Apr 2024 15:13:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org, linux-coco@lists.linux.dev,
 svsm-devel@coconut-svsm.dev
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Dan Williams <dan.j.williams@intel.com>, Michael Roth
 <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
 Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>
References: <cover.1711405593.git.thomas.lendacky@amd.com>
 <67893f352bc54de61160bfe251cba0bdf0431f37.1711405593.git.thomas.lendacky@amd.com>
 <1f6f4477-0f2a-434a-8c89-3b5d51d61581@linux.intel.com>
 <19d69960-e548-a2e6-87d9-c463f2851613@amd.com>
 <e286883d-40ef-d749-26a8-7ec6fbd81eae@amd.com>
 <81d05bd9-ef8f-4a3a-a5df-384a82be49f5@linux.intel.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v3 13/14] x86/sev: Hide SVSM attestation entries if not
 running under an SVSM
In-Reply-To: <81d05bd9-ef8f-4a3a-a5df-384a82be49f5@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR07CA0112.namprd07.prod.outlook.com
 (2603:10b6:5:330::27) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|CYXPR12MB9442:EE_
X-MS-Office365-Filtering-Correlation-Id: a9c0c192-1c46-435b-691f-08dc5d887d38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rmdHGrH1jHFLMD9YkeKzkdjqklT9qIbnmILOPM7q3VHj/30WdRNSHz2nvQ9J1zkqmJYo872Y6NaveFeFe3tvSLjxLaycGskORoJj1Lbpx6Zr2OGAJHHRCWeaUDitJ1iP9oaNX9/JgVEK9TI4+k7pKvFrY6AgVKHclLA4v8pcNRwMTxPwQD6r6WvRmySunylumwq7y1VGrQ6Ks63WdmAvlmnBHWEkC5CDHqXvW18pfsVeF/nz8awOisdKW11ObYoqy7kiuR7Fl3SJ/rIRx9UXNQLLTAq9CwDWLHrILHWD8e3HHCkMkWjP9KBx+O4tyUHpdXjfjPlA+fpWMuVwa2DFSiB/WhMdkO0s+3pV0Eiybx/O5uACM4HSMQGrCf43PaTgAD+/aq2WFFKeY/kner8OnoeAwlAGxcUbx0rQGtnW+LDBNYuQzXE3kLqD3t0pnDYQzaE45Szm3a+xiHxjaZWFJR7TXcHcBKaj7++5gaST18cANiScUKZOFwMN87KbMldeMfLXj8BQgoJs5ce0uhwG6rTTFGICW4NXdCkClzFPIIl93McNuMGnrAvXjqLFmB5cZm8J+n5O4JPGMt4ym2seOyiTWFbD3K2AqGUblqhTv2kNPLI9hAnk6VXkqBL0ZZZQq1T9aDGwH81b9U30Um4ZS8W6kNCB+XtbYfkUYdVj1MQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MkpheEVEdERLRlFSUk01YVhMS2tKY3ZOSTM1SUwyRGZMYlU3bGtNcnEzMmVI?=
 =?utf-8?B?dTV5ZExFUjFHYSswVjlrQ0pYZC9IalB5bG1tTlp5MEJCYXptTml5eVRKdE9Q?=
 =?utf-8?B?am5EeGFQUVJuazNYeW5lemZqT1FBTHBWOFA4dGR2RytRZkdYaFZLRVNpSDQy?=
 =?utf-8?B?RUs2cDFXVSszSzMvK3ozeWtSV0w5YmFLeVFFeGplNDdMRWVuN2JHYjRZQ0Zz?=
 =?utf-8?B?YVV5a2JEdmRaT3M0ZUhJTmxtWVhsSm5BMURjUWNyaXFETnlMWHNVdzRvRmV6?=
 =?utf-8?B?UWFlYllwb1V3bnZPREg2d05sSzVGWjVDTHJyNUQ0bUY5NTN3UjJVazlwd1Nh?=
 =?utf-8?B?Y3FteUF0RjVVY2FGNldSSG85eWVjck55dERrWDdLdm5Tcm12QlMwMGtSOGdI?=
 =?utf-8?B?eU4vVE45M1V5QmdBcVVySkdKQ2tGNnptS0hBVXdnZzl5UDg4VFUyS3FWc3JW?=
 =?utf-8?B?YjZXVEN6L2hVYys0OU5kVjZGZDB4MlVja2JIYTQ5UjZVZjdhR0VPaEF6eWhj?=
 =?utf-8?B?S1B2eDdaaE12ZitWQjZuVmVyenY2VFplYkwrSXE5bHJHeFZpTXJvOWtJT2Q3?=
 =?utf-8?B?bTlKREIvamU3UjdyWDJ5RjdCY2t1TDBVc2hxaStoalBDSFFESFdtckFhSGZP?=
 =?utf-8?B?cGV5cUNKQzR0WjJIV3UzMk5qTVdTZk5EYXJ4c1RpdGZ1cmN5MCtjblh4cENp?=
 =?utf-8?B?ZkptS0dGTzZuTnpNWWcxWlB5Y3F6K2VTM21lVHNJa0kyNnNRaE16Ym5vdHBz?=
 =?utf-8?B?N2hVMk1aNm9nRnRxWEhTNWtJbVVWenVHVU52UHp3V21yRDZEcFhnTVhtdmNL?=
 =?utf-8?B?ZDFiWW9yL3EyQjlVdVR6dHJ6eXk2VEc4a3RZVGFOUzZ3ZGxSRWk0R0t6TVAx?=
 =?utf-8?B?TlNzMWpwZTByZVF3dEdOUEhISUV3bkZwMUpzaFVuZzdVWEgrZUZjc3dsTVVy?=
 =?utf-8?B?L0dBZS81N1FzUnVSVVFKMU9LY1VXcmN6SFhESDhqUGlmamtxeDFHaDdTQnpj?=
 =?utf-8?B?OGRPYXZXV09HS3dDZG1SU1U3TjlxbHBpSmpDN202azhJOWhZRDdvdGJHUEhv?=
 =?utf-8?B?T285Y1QwelQzaENnY3VoNTlZWkhXZ1NRMGpEczVETktiM0xsU2RHTzJtWG54?=
 =?utf-8?B?M00xVlh2dHVXS0xhcUxuQkhaSWlSS0dpcVVOUVpNaXVjZEQrTjJhY05adlpm?=
 =?utf-8?B?RHU2Y1FZdWhkVVBiQUpxTFQyRXNTZ1VZRWJEVXVBeUF3enNVTHFpWnpoZzFM?=
 =?utf-8?B?aG5Fc0s2NWR2aEhTbks2dkgwWWwwcUFqQ1lUbWRYc014ek5DUGY5R2duTGtH?=
 =?utf-8?B?K0VBN0J5Y0ZUMjhTVVBEQmpRakFsZ0h6aEV2NmtGa1p2dy9zV1o4WGFqSTVn?=
 =?utf-8?B?SHF3QzR3WEtNK0l0T2hXVjJGV25FM2FpSVFndTJxaGhZRmtLK0E0M1F1Y3pI?=
 =?utf-8?B?L240alBpMUVRb0xtbVBMWEk2VUR4M1J0VEN0Tm1iY3kvbWR3RkNvN1UrajRx?=
 =?utf-8?B?VHpHblhhWHlkVEkrOUJTcHpianlERXNxZDJuOHllZS9KcG00TmNOa3hZRnBD?=
 =?utf-8?B?SmsyMmdJcTlWNkpOck5zUGVtVmQ5b2JOTDVSeUhBcXRVZ1ErZW5QYVgzTCtB?=
 =?utf-8?B?a0JaOW55MmJ2RmRFWUxJSno0UHJUNDUzdTlOWnRlY2tmalMrRzVCSkgwV2ZZ?=
 =?utf-8?B?RndnL0ZKWTNPVmJ0L1N0SUsyZGNBRllNbFF2aXFvZWx3OGNwN29qd3d6NE9H?=
 =?utf-8?B?N1ByUmkweWlzc2dVeXUxTnRGdXM3MHJmK3ZibWhqWDkwWjVqUHJuRlIrUGt4?=
 =?utf-8?B?YVhNa1RQRjBqemM5QkFXTkRLMldJS0o1QUVxcElKQ0FxbVFIMXlONnhkdGxR?=
 =?utf-8?B?NFJETGZmQnNMeVJsTFZldStnSlVua2NBVE1NRmpWMHBaSmxKZGRlblNseWYz?=
 =?utf-8?B?VEpJZXkrSWxmWkVMN2xuZzJoWnhYMFNMd0dQMysvcEEzRVVjVHFPVnlJQlBy?=
 =?utf-8?B?clBnYnhqTUJVUG1IYlFCa2RtYWdoMTZTWk9TZ0RFZXZCRHg5bEZtOFhhNVlY?=
 =?utf-8?B?ZDh0Y2RBYTlrK1RLeDRhbHJqcHBJZ1NxVjVrN1NBOUhPbmlkbTljbStlZ2hZ?=
 =?utf-8?Q?NZ5GKG6AB1MhHy1tH0dn4ixAt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9c0c192-1c46-435b-691f-08dc5d887d38
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 20:13:17.9304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QCwLXVMOa3uMjDKrR8tHUxrrlLAPs/fyvGCqr3SWEufVYDIVasWOUb1ty2C4Yvo9VWtVM0/+4Xf3WHI/815Aaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9442

On 4/15/24 14:48, Kuppuswamy Sathyanarayanan wrote:
> Hi,
> 
> On 4/15/24 12:16 PM, Tom Lendacky wrote:
>> On 4/12/24 10:52, Tom Lendacky wrote:
>>> On 4/9/24 13:12, Kuppuswamy Sathyanarayanan wrote:
>>>> On 3/25/24 3:26 PM, Tom Lendacky wrote:
>>>>> Config-fs provides support to hide individual attribute entries. Using
>>>>> this support, base the display of the SVSM related entries on the presence
>>>>> of an SVSM.
>>>>>
>>>>> Cc: Joel Becker <jlbec@evilplan.org>
>>>>> Cc: Christoph Hellwig <hch@lst.de>
>>>>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>>>>> ---
>>>>>    arch/x86/coco/core.c        |  4 ++++
>>>>>    drivers/virt/coco/tsm.c     | 14 ++++++++++----
>>>>>    include/linux/cc_platform.h |  8 ++++++++
>>>>>    3 files changed, 22 insertions(+), 4 deletions(-)
>>>>>
>>
>>>>
>>>> Any comment about the following query? I think introducing a CC flag for this use
>>>> case is over kill.
>>>>
>>>> https://lore.kernel.org/lkml/6b90b223-46e0-4e6d-a17c-5caf72e3c949@linux.intel.com/
>>>
>>> If you don't think TDX will be able to make use of the SVSM attribute I can look at adding a callback. But I was waiting to see if anyone else had comments, for or against, before re-doing it all.
>>>
>>
>> What about something like this (applied on top of patch 13):
>>

>> diff --git a/include/linux/tsm.h b/include/linux/tsm.h
>> index 27cc97fe8dcd..5aaf626d178d 100644
>> --- a/include/linux/tsm.h
>> +++ b/include/linux/tsm.h
>> @@ -74,7 +74,20 @@ extern const struct config_item_type tsm_report_default_type;
>>   /* publish @privlevel, @privlevel_floor, and @auxblob attributes */
>>   extern const struct config_item_type tsm_report_extra_type;
>>   
>> +/*
>> + * Used to indicate the attribute group type to the visibility callback to
>> + * avoid the callback having to examine the attribute name.
> 
> Checking the attribute name will give more flexibility, right? Since it is one time
> check, it should not be costly, right?

I thought about checking the name(s), but what if in the future another 
attribute is added, then you have to remember to update multiple places. 
This way you have an enum that represents the related attributes. Is 
there a scenario where you would want to not hide all attributes that 
are related? String comparisons just seem awkward to me.

I suppose the config_item and configfs_attr could also be supplied on 
the callback if that's a requirement.

> 
>> +enum tsm_type {
>> +    TSM_TYPE_SERVICE_PROVIDER,
>> +
>> +    TSM_TYPE_MAX
>> +};
>> +
>> +typedef bool (*tsm_visibility_t)(enum tsm_type type);
>> +
>>   int tsm_register(const struct tsm_ops *ops, void *priv,
>> -         const struct config_item_type *type);
>> +         const struct config_item_type *type,
>> +         tsm_visibility_t visibility);
>>   int tsm_unregister(const struct tsm_ops *ops);
>>   #endif /* __TSM_H */
>>
> 
> Why not add a callback in tsm_ops?

That's an option, too. Either way works for me.

Thanks,
Tom

> 
>>> Thanks,
>>> Tom
>>>

