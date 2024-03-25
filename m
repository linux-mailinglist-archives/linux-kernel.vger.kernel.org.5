Return-Path: <linux-kernel+bounces-117201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AF188A899
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04C821C63238
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15482145348;
	Mon, 25 Mar 2024 14:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2qqDwIJf"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D26144D31
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 14:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711375521; cv=fail; b=jMyb3mNFu74J8EXcjwhioSimXfXVKuAlHlJ09+iD1amCh/TEzqGR1WQwOcsrLlNJpr+mJruZ49FNDSuq7M/W9sP/05fCQ0CVckrSAyqd6gPhHD3sHYLo9bF8ram0PdLXIboQWLIsHJ0c6ckyGxZ7dkyO1uqBT3VX6m82zqLo1mM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711375521; c=relaxed/simple;
	bh=KJYX8yEt11DM7v4DwnGS/3/EC/woKF0MGOCL5PpvGkw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cfb49sGALsfPw0OQ2onoRpq8gCvr/d4GI+FVoccqVH8x9ZN3RkutNM7fOTLeCEDZPv9u7YVhUP+4BnW1X/JkSjUAqGGkW7lBlZn8jwDzrHaU4SuOSVlVBqYLdVZPe9cPKKCncB/f6tqKOc29Binl0Mo7RgchHxvG8+61VRyRMBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2qqDwIJf; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aWpNwW38g6T5kTHqPYsytzXLR/vRYaGLMzCC8xx0NZI9Zv6h4aAPAyt1fy1N4hpy3nRbkpG5+4I9E6hg9V3faL9tG7gmTTbiR0ClPt/21U1aceHIg6gqhKy4hYrR2FKxramFn6/FgV8Uorv7e+cQ+ZA4qVwbrPYc9aRP0h3snN1wmtaJ753G/T0DHRs2HctZCZzL7RKK4QM7/rb1Yp3s4jbv1ue1PBlFqMFi4nxi8Uye7rw+NLVNQAGQ1PHsn2pXOvTDGNXWJDVLgL3cLxgWuiRKV/TVYk+XbcpVF8+zOUwdpLw8PG/d04iCfFeoxzD3uhoIgsocpAE/jTSGCckrlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0syZBYLvccCFkPwmgMB3RlHVqaJUDxt6Vj1aM7bric=;
 b=Om0/GagbLScouIz5DG6wdZZz0K55MyL4SvUpp186k6MRxzC83eRLDDlOA2mzx+aPQsENL/qFcYZDgIMXLqq5VR4nkYx7FwemiAXCNStKE706ruTY6KtHiJJavdgqUmY3XuNNfmY5WmxcACC409yuE4pkIBJczYUNi7aTmiedpNi8KTJiBk9wRSeIklwB8Y8ADBoR/e2GvJwq5wLxNTyI3TJ6V2Pkg0P59PLGd2uJajAsc+uiu3+se+dTJoCvtcJACjgKxugyjSoF2EQbBMrljxasRt6yFUKoKbRH/v/yRlLPqbTIfS0yizyRFv+36KqoGPiVCbeELdp3NNIf5R9geQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0syZBYLvccCFkPwmgMB3RlHVqaJUDxt6Vj1aM7bric=;
 b=2qqDwIJfPqNC+Ch69xVvrWvCdNTFtd0WMDGW6KQJ1szMa/z4I6CQp+6NiHSlu8XcCYWS+SlYjupxMzuBMVoKvcnL2EYZIsLV8vI6gEgksLQG3o2HdvmVJnxopepoEm8dHiY9GRxEzaAdPmpTOdPtOrlrRMT4xSpWBhbSOfAQ5Eo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by SJ2PR12MB9086.namprd12.prod.outlook.com (2603:10b6:a03:55f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 14:05:13 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1032:4da5:7572:508]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1032:4da5:7572:508%6]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 14:05:13 +0000
Message-ID: <112a1681-70d4-4826-b0b4-a0ff84750f9a@amd.com>
Date: Mon, 25 Mar 2024 09:05:10 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/14] x86/sev: Hide SVSM attestation entries if not
 running under an SVSM
To: "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Dan Williams <dan.j.williams@intel.com>, Michael Roth
 <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
 Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>
References: <cover.1709922929.git.thomas.lendacky@amd.com>
 <fabdf811d27a2539d1d016f75d95910b9bca24c4.1709922929.git.thomas.lendacky@amd.com>
 <fff67373-9c46-4023-8af9-70e62b9ab97c@intel.com>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 vFkWitqCJg==
In-Reply-To: <fff67373-9c46-4023-8af9-70e62b9ab97c@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0136.namprd13.prod.outlook.com
 (2603:10b6:806:27::21) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|SJ2PR12MB9086:EE_
X-MS-Office365-Filtering-Correlation-Id: 74330b1d-f758-4215-e0de-08dc4cd49735
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TRIFdNdnE4SSW+q/JEiVFaaeR3/Wb1I/DnWnouPwuu9FAwLflOdZr9qDMLt8d0GXM8lN72RIRHbHZvIrstEZTKqXMaN7AoyNdQEVWzTszZI3Ys9+UnokBTONm3GwjYpcgvwcSk+GYsqY1AKruSpKF6J8XS9jLKzqSb/9n+jRMej4M+zylYD4ox9D8w+WQosJFi5mZmrEYWo6tZzG4qLeBnbvGUm+N/sBBU+oHPAL8iZNAq50TMs+DPBvmrB6l3Ua+mdEJVC51hZunMguTYPzsieUNydoN30EvTJRi2hIbNKArF4cMbbKmg9SWzF1CSGk5hgwfkhK+1ElUhOgTgU2pTEVpk3CXZ1dqbrZElnTSrdq5kPVGTgoaxdwuEjlycISGcxP02wWDhWKAd3uRtc2EmU6vz9k/g8HmkfgjFxPdTWvmiDlcAIJdt95Da4PBIfN4H1W27UKsILXJeViKTdvjCMOO+D5a7uZ3jaiYDu9HVIviKc8reit8TQAZq6b+E79ahR5e+LxdWCH97Y1sMH1gzAYUnVT9AEb1KmSnIVVpzrjWFTJ2tqvtC4BgyaqOpf+2H7HySZ+9ZYmXLO9kTpv9eOHGuyH/QdK233kWR4DZKLl/YtxDSEJmI+Qxv4UswA652GM1CDHYS+nnZK0QEaMd4Z0pKEgYjXuwndP14IAmPA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFJWVTFrcTB1MEdtVXZCYjJrdThUcjJXWTNQcWtIWTBFNDd4RXJyVnRYeU1w?=
 =?utf-8?B?TVFBZHRIc3RDdEp1bmM1SVRBQm9OMG12NysxNk01SlZQR240MWpyczlYRVdT?=
 =?utf-8?B?SkJxaW82RnFidHJ6d1FoS1I1Q1UrQjk1cXN6SkNsaU5JRTR3T0dyS3Y0dUMv?=
 =?utf-8?B?UnczZDU3VGR0OEk4UHBGRXdWcU9OemxBekV3a1VneFhreDdqS3JCSkp0UlN0?=
 =?utf-8?B?MU5XQkE5SUJCSFBQaXVJSVB1N0hTcUN2QXV0MXpyeHhSMFJIa29sSWpucHlK?=
 =?utf-8?B?Q25KQ1lzaktXaGtZdHNWdXRmQkdzUW5tbGVuZVdrZnBMZ3N5VTlOVW1ROGo3?=
 =?utf-8?B?bVBSSmJsRlRpaVI1Qk03ZzhMMHNwdkpyR01GMzJsN0J5a2hBUTA4Tm1Fd1hz?=
 =?utf-8?B?aGF0N25DeTQvQ2ZLTFZpMkhpQmVxMnRkTTRYWmV6aHdRbTQweTdnU0JEelpB?=
 =?utf-8?B?TTZIWUFyTDJ0cm5udlNIWEJYMDBFc2h0cHRCUURyMkc4WDNDMUZyTGRBVXJZ?=
 =?utf-8?B?eXc0N2VTZFFWVmc2SVZXanI0TG1VL2R0ZjM0N0FhYkd4NHVrSVdKWktjZzRE?=
 =?utf-8?B?enhDcTVSVjVWaUVNUGdORU5FakVNZEdER21VVlRJU1pIZWlNMktaeGVBa1Bk?=
 =?utf-8?B?Y2VWOXZlRXFITSs4TDc5bW13T2xWNUt1M3RoUmhMbWFaNTBjemoxVTV6eE1N?=
 =?utf-8?B?bzBKM010akpadEVod0VUSXp1ZTZXdkNZd28vL1NoTno2bitvOHUrTm9PRTQz?=
 =?utf-8?B?WlIvT3dxR3NpRzdLSEYxVUpRZGRyUmx5eVJxTDlUQ1NMZUdvUGcra3YrYXJL?=
 =?utf-8?B?cXlNZVVZc0EvM0FTT1lNNUJKS0xnb2d6MDg2c29QeFhWNU5zeUtNZWI3YkQx?=
 =?utf-8?B?RGg5a3hyMlZvOWlPWERwRk1XdExJQ2ppTmxTMk9SOHZQTk9iZDJOSERYcnM5?=
 =?utf-8?B?Sk9OU1hteHAvRzNydG56NGQxZzRxcU9ycTNIckNyNXVwV05KSTFyYnNQQm1J?=
 =?utf-8?B?cjlWdDNMbW9PVlczSlJVSHhmY1l3aXpVbG9pb3J6S1JVU25ocDM0bWtYT2Q5?=
 =?utf-8?B?NFhLZFpRWUkvWkdWemRGcUpFczdNSVgrMVBqWFg5WlloYytCSjhDclVmOEhQ?=
 =?utf-8?B?QmQyZmZkaFdZbGhTb3FvYWhQSFZNV2kxZ0cxeXJlWE1sNlF3dWdvT25vZDlD?=
 =?utf-8?B?bytQZVlqOGNScEpDS096QWdtMkVoSmYvb2s4c3lGa2puY2ZIeEVLQXcyN0NX?=
 =?utf-8?B?eVlGR0Y0MnRWMUtnbzlrWjdvWXJzU1dwS0Njb2VqOTNWSU1UL1lzYys5QjRp?=
 =?utf-8?B?WDdPbnNobTlBc0NvVGxOUG9hR3hESXV5RGRMb2JKVXFzY0VGbGF6L05wWmhS?=
 =?utf-8?B?eU5teXhMRnN4Rlp1cEN2Mi9BenJNMzlDMlNtRjRic0VlT3RxaDNpS3F6djhk?=
 =?utf-8?B?MHFyQ3h4NUczTWxjV1lOelJwZ2NTMGhzemRUQWxIWm41K1owcFRRMndrZ21m?=
 =?utf-8?B?bm5XaVo4Y1FBSk50aFB0a2dRV0FOYWwycHd1K0tHYlh0WnhHMkNpeHNrbmFM?=
 =?utf-8?B?MmUzSjdMaStGUVBtbEQzeUVmZDJtV1VPbzhHUGhreGZKb0NlL3ZRM29nTWtV?=
 =?utf-8?B?YWdDTjgvT1RQNllOOWxHdkxDSUR1dnJYUXpVY1JubnJnckFvaXNNaXlEM0pn?=
 =?utf-8?B?NTI3NytBVzdBdjJNZERiT00zYzI5SEF5YmZjbnl3cC9kbUpJeklqd0NqbS9v?=
 =?utf-8?B?YURtR2hON1EzdWQ0UVhWWlVaMGlNQ3NEUnBXblRMd2dxcHQ1T0JhVktkZUVj?=
 =?utf-8?B?UUVhd01iUytFNjJVc3Z2bThXbnpwWUx0bUwxQ1lSOG96Umg3OHZBVnpVQVFU?=
 =?utf-8?B?STBZaytGbnBYZnEzYy9hNU9OSGVHdEJwOW1QZXJuOXJOMnF6d29hckJqNm9o?=
 =?utf-8?B?SDA1ZHNqdnlPek1nN2RDZUZuQkZjUkZUT1JKQ1NoazdONS8rOG55RWhIamVp?=
 =?utf-8?B?aGRiTFNlL0ozUEwzWFNydkJRU3BHNkRtL3ZRQzVYbzh2QklWOCtvdmlLTkZt?=
 =?utf-8?B?ZnRyVFNVTGo0WndGUWlvcEdVcys4T1pwdC8zdmdNZjVjb2FnbnpaL05XNGNx?=
 =?utf-8?Q?ulPwRpxiZb4NM4aRbHOSjX8RA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74330b1d-f758-4215-e0de-08dc4cd49735
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 14:05:13.5198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jWW8CTZZAos7WHkEEPdi5RChS6OodQSGgYBP7uINeXsbM1YL2tg3Qrhv075tKTdFnsyX8vyY33hg1KgSDbVaOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9086

On 3/23/24 12:24, Kuppuswamy, Sathyanarayanan wrote:
> 
> On 3/8/24 10:35 AM, Tom Lendacky wrote:
>> Config-fs provides support to hide individual attribute entries. Using
>> this support, base the display of the SVSM related entries on the presence
>> of an SVSM.
>>
>> Cc: Joel Becker <jlbec@evilplan.org>
>> Cc: Christoph Hellwig <hch@lst.de>
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>> ---
>>   arch/x86/coco/core.c        |  4 ++++
>>   drivers/virt/coco/tsm.c     | 13 +++++++++----
>>   include/linux/cc_platform.h |  8 ++++++++
>>   3 files changed, 21 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
>> index d07be9d05cd0..efa0f648f754 100644
>> --- a/arch/x86/coco/core.c
>> +++ b/arch/x86/coco/core.c
>> @@ -12,6 +12,7 @@
>>   
>>   #include <asm/coco.h>
>>   #include <asm/processor.h>
>> +#include <asm/sev.h>
>>   
>>   enum cc_vendor cc_vendor __ro_after_init = CC_VENDOR_NONE;
>>   u64 cc_mask __ro_after_init;
>> @@ -78,6 +79,9 @@ static bool noinstr amd_cc_platform_has(enum cc_attr attr)
>>   	case CC_ATTR_GUEST_STATE_ENCRYPT:
>>   		return sev_status & MSR_AMD64_SEV_ES_ENABLED;
>>   
>> +	case CC_ATTR_GUEST_SVSM_PRESENT:
>> +		return snp_get_vmpl();
>> +
>>   	/*
>>   	 * With SEV, the rep string I/O instructions need to be unrolled
>>   	 * but SEV-ES supports them through the #VC handler.
>> diff --git a/drivers/virt/coco/tsm.c b/drivers/virt/coco/tsm.c
>> index 07b4c95ce704..2efa6e578477 100644
>> --- a/drivers/virt/coco/tsm.c
>> +++ b/drivers/virt/coco/tsm.c
>> @@ -64,6 +64,11 @@ static struct tsm_report_state *to_state(struct tsm_report *report)
>>   	return container_of(report, struct tsm_report_state, report);
>>   }
>>   
>> +static umode_t svsm_visibility(const struct config_item *item, const struct configfs_attribute *attr)
>> +{
>> +	return cc_platform_has(CC_ATTR_GUEST_SVSM_PRESENT) ? attr->ca_mode : 0;
>> +}
>> +
> 
> Instead of directly checking for CC flags here, I am wondering if it would make
> sense to add a callback to vendor drivers and let the callback decide whether
> the attribute is valid or not? We can't add a CC flag for every ConfigFS attribute,
> right? For example, privlevel is not used by TDX. If there is a callback, then
> TDX driver can make this attribute invalid for it.

I think that's something that can be looked at after this series.

Thanks,
Tom

> 
>>   static int try_advance_write_generation(struct tsm_report *report)
>>   {
>>   	struct tsm_report_state *state = to_state(report);
>> @@ -139,7 +144,7 @@ static ssize_t tsm_report_svsm_store(struct config_item *cfg,
>>   
>>   	return len;
>>   }
>> -CONFIGFS_ATTR_WO(tsm_report_, svsm);
>> +CONFIGFS_ATTR_VISIBLE_WO(tsm_report_, svsm, svsm_visibility);
>>   
>>   static ssize_t tsm_report_service_guid_store(struct config_item *cfg,
>>   					     const char *buf, size_t len)
>> @@ -168,7 +173,7 @@ static ssize_t tsm_report_service_guid_store(struct config_item *cfg,
>>   
>>   	return len;
>>   }
>> -CONFIGFS_ATTR_WO(tsm_report_, service_guid);
>> +CONFIGFS_ATTR_VISIBLE_WO(tsm_report_, service_guid, svsm_visibility);
>>   
>>   static ssize_t tsm_report_service_manifest_version_store(struct config_item *cfg,
>>   							 const char *buf, size_t len)
>> @@ -189,7 +194,7 @@ static ssize_t tsm_report_service_manifest_version_store(struct config_item *cfg
>>   
>>   	return len;
>>   }
>> -CONFIGFS_ATTR_WO(tsm_report_, service_manifest_version);
>> +CONFIGFS_ATTR_VISIBLE_WO(tsm_report_, service_manifest_version, svsm_visibility);
>>   
>>   static ssize_t tsm_report_inblob_write(struct config_item *cfg,
>>   				       const void *buf, size_t count)
>> @@ -336,7 +341,7 @@ static ssize_t tsm_report_manifestblob_read(struct config_item *cfg, void *buf,
>>   
>>   	return tsm_report_read(report, buf, count, TSM_MANIFEST);
>>   }
>> -CONFIGFS_BIN_ATTR_RO(tsm_report_, manifestblob, NULL, TSM_OUTBLOB_MAX);
>> +CONFIGFS_BIN_ATTR_VISIBLE_RO(tsm_report_, manifestblob, NULL, TSM_OUTBLOB_MAX, svsm_visibility);
>>   
>>   #define TSM_DEFAULT_ATTRS() \
>>   	&tsm_report_attr_generation, \
>> diff --git a/include/linux/cc_platform.h b/include/linux/cc_platform.h
>> index cb0d6cd1c12f..f1b4266c1484 100644
>> --- a/include/linux/cc_platform.h
>> +++ b/include/linux/cc_platform.h
>> @@ -90,6 +90,14 @@ enum cc_attr {
>>   	 * Examples include TDX Guest.
>>   	 */
>>   	CC_ATTR_HOTPLUG_DISABLED,
>> +
>> +	/**
>> +	 * @CC_ATTR_GUEST_SVSM_PRESENT: Guest is running under an SVSM
>> +	 *
>> +	 * The platform/OS is running as a guest/virtual machine and is
>> +	 * running under a Secure VM Service Module (SVSM).
>> +	 */
>> +	CC_ATTR_GUEST_SVSM_PRESENT,
>>   };
>>   
>>   #ifdef CONFIG_ARCH_HAS_CC_PLATFORM
> 

