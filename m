Return-Path: <linux-kernel+bounces-81725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5243586796B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 011A928A58F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F09412BEB5;
	Mon, 26 Feb 2024 14:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Vy/Kqib6"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BD660860
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 14:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708958554; cv=fail; b=SMpWFRZvrfrF5TTArp9mpwh8ft2H6/hmiAtIbAySsseYt9sm4OgaVEDjfFi8SM8Vxe11h9tfpxm349ruhJ5vRdFJ21wya8l4eVzv7egEnrqa1pCZst+95Z+4jDawkRi0yYJAmcZxKs5JFp0aAMKBX8vsVhIqvg7DUtsd3bf5JH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708958554; c=relaxed/simple;
	bh=nv0NjFD152pH/mbAACNYgOzDpoxyxvuUYVwv8Y13HTg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EW4v4oKUFhHFxAaesDlXh1x4ED1NYFNtDrqVaYAaLB93zI6T8j/+Y+dc/j+JqX4Sffmn0YbpvVSut8Mr1rw3zUWRY35ECvdKD2Lx1s0CTE6YEqkhywb/TpY2r9cFudJaa7D5tIhTsvBJJEpy4y/JNFZG5ORgR3GIqMC8DV2GihU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Vy/Kqib6; arc=fail smtp.client-ip=40.107.243.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WX4YEFp0w7D9lILWvn1Xlx9iUqGPEEc70saDPMTAjDOcqJJjLO5Cb1rQbK/c4vHryDhkyzPYsXFogzsEjjGY3BTgq6uZbmd0fmDCq3FkVwokFGHM7Msd1GTFpFHCJz7PBYrs4Ha2r4onBz+C28vsnj0ydb5xM+T+sfcyZQxpLTry0QH+RXDeElZel1CPbl8i/+t0jNYE2JXAf5K4DQdBIIwv1Eg5amLvKEzEV/SCrceUzf/zpneSuWBvVl+lNKLfxONf7r0A23X4GgByPJOxJmdA2uevSUgEJTi7lBLlQTRySQu8sJ7c6GBOPZKD1mHNe/veOIsYitjakzg0OsnIHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zo3pNcJRIA5To9RdCrUFr5T5DJLngYIoWn/Nqgki9Co=;
 b=AkImpxBk3pBRbM/kDZ3Yz21QRNMmEY/FlTdrcxXsrXeRbI5+M+HTOZySuTdvssEWi/A+JezucFH/vi9IWN9h7Zhe+1JmNyJ6ArFQ8rG8TU0owUVJQBFhSuodMr1lj+RrcH83QHQcZEIZZNilYRd0DNGIHGHenzoggwnklVMqLrhHI9dK7Vmid0XSpYaUCZdmCG+3oMjTQUctXumeVjncGOtfyXJ6k2yS7R55WtBVQAPJdMEWXZ5UjtsccpyplKmkblCp6F4MTJGk2q7/gCJDvMSLQKRMqwQZT0FOkR+KzlA3TFFzFXuuJaoW5NlseFqL6VN5zReh/GHHYq7ilguvEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zo3pNcJRIA5To9RdCrUFr5T5DJLngYIoWn/Nqgki9Co=;
 b=Vy/Kqib6SJG9DoqgrVXNCLDCEdBlU6CGbYyvdA9L/a4urhninxYpgs1y6QXz5Lzb/Ma8S3VsrEdam0pRox1xVzEcD4xP0qFGt8zOyFogx0XOTuFtGycqIfVLyixUhIHy4Yqm78bgDlXqPV7AEtXjmP1W+cyhHdkb8Vxj6V1hsm4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by CH0PR12MB8552.namprd12.prod.outlook.com (2603:10b6:610:18e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.31; Mon, 26 Feb
 2024 14:42:27 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::db9b:a5f:5d0a:2a42]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::db9b:a5f:5d0a:2a42%4]) with mapi id 15.20.7316.034; Mon, 26 Feb 2024
 14:42:25 +0000
Message-ID: <259f2ca6-a4a4-4a9b-9df5-d319a7198b12@amd.com>
Date: Mon, 26 Feb 2024 08:42:22 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] x86/sev: Extend the config-fs attestation support
 for an SVSM
To: Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Michael Roth <michael.roth@amd.com>,
 Ashish Kalra <ashish.kalra@amd.com>
References: <cover.1706307364.git.thomas.lendacky@amd.com>
 <10637f104d1ed7f21e281a4890f2c549d1e85985.1706307364.git.thomas.lendacky@amd.com>
 <65bc95732df26_65b2629448@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <afabdd17-7f1e-4d8c-a7c2-dbbbb230fccf@amd.com>
 <65cad52616ffa_29b129412@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <1adda7f0-0061-4296-ae6f-dd767676c23b@amd.com>
 <65d9322a53e90_2509b29456@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 vFkWitqCJg==
In-Reply-To: <65d9322a53e90_2509b29456@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:5:335::14) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|CH0PR12MB8552:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d1aed66-bd21-41f8-2ff9-08dc36d925c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PB4Y2CA3axkZE72zC23WYuAHVLCtdFeHXj0e8+n12jwbk0k8h+3WkPwDe9SlAxi1vvudbFOmDsIlUnH9fCq3vxugRN+MMtF0O8wxQ04HMkHL9dHBjsHvkcjqCs5KFK+ONSAK/eODU0DfnYNy5RtmA8sBpIizLRz+HInBxIx1X9oJ3Zm1c/saUag6VmtpsVrd+BEoh9MP+Hec8PBVhJMJcYWB4MGpGDnXuS/GspydMsttLAa1zt+YEf5s658BP2SiLulSN53HRfJa4qNKBJrR8X0SrIFpTSmhoHl5eVt+PfFNjkm3xTUgDOqHcRX0eXEMjH4+Eblw55TfWS/Q1CSuK+gkqhsPpxTctF9L9Cg0B2WpoxU7tHajkao+YM/4QTjJGXWhysvxqvwh5qshORZz69+WB1MnYMz8ukzrMn9knuryK7IozHVGy1rIieLUm5Jp+EOjE7PonYeJTU9lBTsmR8pqrRKuLGlI8mi5Sk3IxCXK6oz7zDhVg0SZHZhUNocYUck/4qwDtBO9IMgGRyhnZsEr3JnyEJKAUObmkIRPyuJOPiCUtrDcgtQYElRSExZE22jGMmt9v+bYunWY4+edUuDUZ6mqjt40rzVWqcJaxIHxPuM/S7yHZk49Rv9lbKto
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFdoOUhXNGJaR2VJeDdEaHVmRndCNExNUGNvNWtZWWVTemo1b2h1bEh5Y29u?=
 =?utf-8?B?TkxsT2NtYllNQWJtSkgrbVMxekRXSG9EOWgrTDhQTHJoRWNaY3JPWFREeDRy?=
 =?utf-8?B?UU9ZT0FlRzB0N3NVblYreDJ5clROL09nQzBBQ2NnTlNONlZXbXhxaHRkZTc4?=
 =?utf-8?B?cDN1YTRwaElzUUNRbjEvN0pibDliRm9lcVRUTlY2WFpWc0xTUFlEK3Q3U2Z1?=
 =?utf-8?B?UTcwR0MxYlYwNXArU0YvVDVOc2xEempSZ2RDV3NBSysxZTd1eFducXRBNFI0?=
 =?utf-8?B?SUtXVC9aaHhoMlp0OXhYbHlTTHBKVkdBQU1QK2Noa3g4RzZrbFZVTlFEbS93?=
 =?utf-8?B?OGVjazBMWWRQQ3JUbGpKcm5EN3NKNllabkhCODFmb1A0MkUvbVpUS09jSkhW?=
 =?utf-8?B?VUEwRTR0TFE2T0lrYUFzRG5CRnNxZXp3QVNNbFpDaG9BeHcxcXMwL1B4ZGVu?=
 =?utf-8?B?bVJUclQwK3dXV216SDMzWWxNOGROdE03b0p1OGsySHVaSGtKK3pidXZobmRn?=
 =?utf-8?B?QzdrVGRVakNYenUvcmhneGF4QnJ0MjRMMVc1Nm1zVi9Qd0xoSWFKd2dpWVIy?=
 =?utf-8?B?eWpPakdZdm14R0s4OU5MQ0RWUEhwWFRGN0x1Yjd5RDI2bHRsRTBuTG44Y2ZD?=
 =?utf-8?B?WEdjWm1QNGQvbWdrQUg1OVoxa3VkMTB2L0pncmFCNXpVUTFFQ2FlVFRCUXFP?=
 =?utf-8?B?MGowVmdHWWxhRlpaYXlHTnJiRkl5eVRZKzQxT3gvZlBjenhDaGN2NURSSDBW?=
 =?utf-8?B?QWJUWGcwNC9tSW51UlpGR2dNVTZHVkJHUGpvK01sRTVhTHo2a1JKU1FlZW9S?=
 =?utf-8?B?a1VoZlZucE9RU0VTNTQ5Mm5XQjJGeGZJMnZuSVNIamR4Uit4TnJJY0NIZEdO?=
 =?utf-8?B?QXNOMDJxdWZkamtLWjlGelVxVXZrSFBaQ1lCWm1Ga3RwTHd6OWJLdWZaVUts?=
 =?utf-8?B?S3BOMnNybXZ4eHJNSitmU0UxaHNOVEttUkRHejZ1ZzlNT0VJUkdvMnVSazc1?=
 =?utf-8?B?Q01LL3c5QWlkR1BqdHZCUVN3YkNWQ2x3UlJOcFBycFZYL0ZDVHo4dkluWVYx?=
 =?utf-8?B?SlBkZEx5TjdwNzRJLzRWSFg3Y3VZcWpoRi9SOXZsNUtNTmJyRmd3UGlnZm5B?=
 =?utf-8?B?MDVrZXNTL3VMbjBYS0RkWTVWam5pTGhQUitOWGlWU3YvaGM4RnloS2hqenFS?=
 =?utf-8?B?UUgzN3BuNTNtUWV5Z3VvMzFjZmN0QTluUzBFeEM5UHlvd2dHemd0RTdSYUdq?=
 =?utf-8?B?dCt2em4zamFleXlreWRNbnpnaGZjTyt3MmtmZVVva05PWHlxRGsxbGRzU2JL?=
 =?utf-8?B?dE02M1h0UlU2eDA5SzFtTWJ1VXhvZ1QzN2dqVDkyTlR5dk1PWnRxTllJNE1v?=
 =?utf-8?B?ckxnUmxFbnJkRjZqZXh0UEVJcjZVcm0rdE5COVBPYXdudnMrenRrSGc1UHdY?=
 =?utf-8?B?ZVpLNG5lM0pMVE81d1BJdVJhNWlNOWd5eHFyZjVkUzdXNVR5L0Q0K2g2SEFy?=
 =?utf-8?B?eVErZkhTcDhEdWdCa2h6d3NTYVROeFRSQ0NSd1RjaXQ2WDRBQ1dHRmtrcms2?=
 =?utf-8?B?V3JOYzdXSUdKQ1pQMHZmWHJMelN3aS9hTnNpT3lER3o3VG9meFNQTzljU256?=
 =?utf-8?B?S3dXMGlLb3ByVWZHamQxdFlZOHJ4R0pqVlQ0aFdBdkNHYVlGMlpEdWc2bEZ0?=
 =?utf-8?B?NS9vaFBJYmlkYkpJZGE0Q3BaQjcxQVZFRzZUZXAyRmRoaGxWREZRZUZ6VVhz?=
 =?utf-8?B?SGpielBRM0RuWkR6dFB6ankwWjkyby91RkF6MUtRUm9TSm5lTWtvYjcxeVVT?=
 =?utf-8?B?dzhhc1hKZXFURmZ5RnFwWlF5SlFOZ1pFWWF0b2RYRWFDdTBEdVZ0YVhjbzAw?=
 =?utf-8?B?STM4NjQ2WHhiK3VKNEZHNWRERCtvcHgvNDd5UXZBYUtCUnRua3RZNnJYUkdX?=
 =?utf-8?B?NVYvaHBsVmFxWmRYTHVaZ21hRTFodTRrSWZLNVRVdEd3T3lmYnNjbkl2MG1O?=
 =?utf-8?B?MEFVUng5RzRieG5UT0NXL1h4VndtR015UTNVYWxBUDdTNm9HSURRTmY4T2Nz?=
 =?utf-8?B?QTdlMkhVQnhCRU9FNGVaR2tkcklTUDkyYmVLck5ZeXhyLzZIeTZTMWxsaEZF?=
 =?utf-8?Q?kn1poYV+vp3A36HQAhOeId/DX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d1aed66-bd21-41f8-2ff9-08dc36d925c6
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 14:42:25.1005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a/duAP2aRtkSODMc4GAkbm9oZzvT5JMYwYd8mDIKscICR39EDdCGwukBibT8EeYFy4UacSaES+xvs9mo38uZew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8552

On 2/23/24 18:02, Dan Williams wrote:
> Tom Lendacky wrote:
>> On 2/12/24 20:34, Dan Williams wrote:
>>> Tom Lendacky wrote:
>>>> On 2/2/24 01:10, Dan Williams wrote:
>>>>> Tom Lendacky wrote:
>>>>>> When an SVSM is present, the guest can also request attestation reports
>>>>>> from the SVSM. These SVSM attestation reports can be used to attest the
>>>>>> SVSM and any services running within the SVSM.
>>>>>>
>>>>>> Extend the config-fs attestation support to allow for an SVSM attestation
>>>>>> report. This involves creating four (4) new config-fs attributes:
>>>>>>
>>>>>>      - 'svsm' (input)
>>>>>>        This attribute is used to determine whether the attestation request
>>>>>>        should be sent to the SVSM or to the SEV firmware.
>>>>>>
>>>>>>      - 'service_guid' (input)
>>>>>>        Used for requesting the attestation of a single service within the
>>>>>>        SVSM. A null GUID implies that the SVSM_ATTEST_SERVICES call should
>>>>>>        be used to request the attestation report. A non-null GUID implies
>>>>>>        that the SVSM_ATTEST_SINGLE_SERVICE call should be used.
>>>>>>
>>>>>>      - 'service_version' (input)
>>>>>>        Used with the SVSM_ATTEST_SINGLE_SERVICE call, the service version
>>>>>>        represents a specific service manifest version be used for the
>>>>>>        attestation report.
>>>>>>
>>>>>>      - 'manifestblob' (output)
>>>>>>        Used to return the service manifest associated with the attestation
>>>>>>        report.
>>>>>>
>>>>>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>>>>>> ---
>>>>>>     Documentation/ABI/testing/configfs-tsm  |  55 ++++++++++
>>>>>>     arch/x86/include/asm/sev.h              |  31 +++++-
>>>>>>     arch/x86/kernel/sev.c                   |  50 +++++++++
>>>>>>     drivers/virt/coco/sev-guest/sev-guest.c | 137 ++++++++++++++++++++++++
>>>>>>     drivers/virt/coco/tsm.c                 |  95 +++++++++++++++-
>>>>>>     include/linux/tsm.h                     |  11 ++
>>>>>>     6 files changed, 376 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/Documentation/ABI/testing/configfs-tsm b/Documentation/ABI/testing/configfs-tsm
>>>>>> index dd24202b5ba5..c5423987d323 100644
>>>>>> --- a/Documentation/ABI/testing/configfs-tsm
>>>>>> +++ b/Documentation/ABI/testing/configfs-tsm
>>>>>> @@ -31,6 +31,21 @@ Description:
>>>>>>     		Standardization v2.03 Section 4.1.8.1 MSG_REPORT_REQ.
>>>>>>     		https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/56421.pdf
>>>>>>     
>>>>>> +What:		/sys/kernel/config/tsm/report/$name/manifestblob
>>>>>> +Date:		January, 2024
>>>>>> +KernelVersion:	v6.9
>>>>>> +Contact:	linux-coco@lists.linux.dev
>>>>>> +Description:
>>>>>> +		(RO) Optional supplemental data that a TSM may emit, visibility
>>>>>> +		of this attribute depends on TSM, and may be empty if no
>>>>>> +		manifest data is available.
>>>>>> +
>>>>>> +		When @provider is "sev_guest" and the "svsm" attribute is set
>>>>>> +		this file contains the service manifest used for the SVSM
>>>>>> +		attestation report from Secure VM Service Module for SEV-SNP
>>>>>> +		Guests v1.00 Section 7.
>>>>>> +		https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf
>>>>>
>>>>> I wish configfs had better dynamic visibility so that this could be
>>>>> hidden when not active... oh well.
>>>>
>>>> So do I. I played with the idea of having two different structs and
>>>> registering one or the other based on whether an SVSM was present. Thoughts?
>>>
>>> That's the status quo for the differences between TDX vs SEV
>>> (tsm_report_default_type vs tsm_report_extra_type). I think a
>>> "tsm_report_service_type " can be a new superset of
>>> tsm_report_extra_type. That that just starts to get messy if
>>> implementations start to pick and choose on a finer granularity what
>>> they support. For example, what if TDX supports these new service
>>> attributes, but not privlevel.
>>>
>>> It seems straightforward to add an is_visible() callback to
>>> 'struct configfs_item_operations'. Then a common superset of all the
>>> attributes could be specified, but with an is_visible() implementation
>>> that consults with data registered with tsm_register() rather than the
>>> @type argument directly.
>>
>> I've been playing with this a bit.
>>
>> For the configfs support I was thinking of doing a per attribute
>> is_visible() callback field since the TSM support is currently all in one
>> group. The callback field would be checked in fs/configfs/dir.c
>> populate_attrs(). A simple bool return value should suffice, I'm not sure
>> we need to get into umode changes. If the field is NULL, then the
>> attribute is displayed. If non-NULL, it depends on the callback return value.
>>
>> In order to keep tsm.c as vendor neutral as possible, a way to
>> provide/override a default callback would be needed. The new SVSM related
>> fields would have a callback assigned that always returns false by
>> default, so that these attributes wouldn't be visible. A new tsm.c
>> interface that takes the attribute name and a callback function can be
>> used to override the requested attribute. For example, the SEV guest
>> driver could register a callback for these attributes that returns true
>> when running under an SVSM or false otherwise. Or it could leave the
>> default in place and register a callback when running under an SVSM that
>> always returns true.
>>
>> Thoughts?
> 
> Sounds like a patch I want to see, yes. So the idea is the low-level
> driver registers the is_visible() callback to the core and that gets to
> filter attributes?
> 
> Hmm, as long as it ends up looking similar to sysfs is_visible()
> prototype.
> 
> It could even just be a bitmask of attributes that gets passed in by the
> provider, something like:
> 
> static struct configfs_attribute *tsm_report_attrs[] = {
>          [TSM_REPORT_ATTR_GENERATION] = &tsm_report_attr_generation,
>          [TSM_REPORT_ATTR_PROVIDER] = &tsm_report_attr_provider
>          [TSM_REPORT_ATTR_PRIVLEVEL] = &tsm_report_attr_privlevel,
>          [TSM_REPORT_ATTR_FLOOR] = &tsm_report_attr_privlevel_floor,
>          NULL,
> };
> 
> bool tsm_report_is_visible(struct config_item *cfg, struct configfs_attribute *attr, int n)
> {
> 	return test_bit(n, &provider.attr_mask);
> }
> 
> ..and in is_bin_visible() for the binary attributes?

I was thinking something along the lines of the following for the configfs
support:

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 18677cd4e62f..c224060c1b6b 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -589,12 +589,20 @@ static int populate_attrs(struct config_item *item)
  		return -EINVAL;
  	if (t->ct_attrs) {
  		for (i = 0; (attr = t->ct_attrs[i]) != NULL; i++) {
+			if (attr->ca_is_visible && !attr->ca_is_visible(attr))
+				continue;
+
  			if ((error = configfs_create_file(item, attr)))
  				break;
  		}
  	}
-	if (t->ct_bin_attrs) {
+	if (t->ct_bin_attrs && !error) {
  		for (i = 0; (bin_attr = t->ct_bin_attrs[i]) != NULL; i++) {
+			attr = &bin_attr->cb_attr;
+
+			if (attr->ca_is_visible && !attr->ca_is_visible(attr))
+				continue;
+
  			error = configfs_create_bin_file(item, bin_attr);
  			if (error)
  				break;
diff --git a/include/linux/configfs.h b/include/linux/configfs.h
index 2606711adb18..93d346e2afc1 100644
--- a/include/linux/configfs.h
+++ b/include/linux/configfs.h
@@ -112,39 +112,63 @@ static inline void configfs_add_default_group(struct config_group *new_group,
  	list_add_tail(&new_group->group_entry, &group->default_groups);
  }
  
+typedef bool (*configfs_is_visible_t)(const struct configfs_attribute *attr);
+
  struct configfs_attribute {
  	const char		*ca_name;
  	struct module 		*ca_owner;
  	umode_t			ca_mode;
+	configfs_is_visible_t	ca_is_visible;
  	ssize_t (*show)(struct config_item *, char *);
  	ssize_t (*store)(struct config_item *, const char *, size_t);
  };
  
-#define CONFIGFS_ATTR(_pfx, _name)			\
+#define __CONFIGFS_ATTR(_pfx, _name, _vis)		\
  static struct configfs_attribute _pfx##attr_##_name = {	\
  	.ca_name	= __stringify(_name),		\
  	.ca_mode	= S_IRUGO | S_IWUSR,		\
  	.ca_owner	= THIS_MODULE,			\
+	.ca_is_visible	= _vis,				\
  	.show		= _pfx##_name##_show,		\
  	.store		= _pfx##_name##_store,		\
  }
  
-#define CONFIGFS_ATTR_RO(_pfx, _name)			\
+#define __CONFIGFS_ATTR_RO(_pfx, _name, _vis)		\
  static struct configfs_attribute _pfx##attr_##_name = {	\
  	.ca_name	= __stringify(_name),		\
  	.ca_mode	= S_IRUGO,			\
  	.ca_owner	= THIS_MODULE,			\
+	.ca_is_visible	= _vis,				\
  	.show		= _pfx##_name##_show,		\
  }
  
-#define CONFIGFS_ATTR_WO(_pfx, _name)			\
+#define __CONFIGFS_ATTR_WO(_pfx, _name, _vis)		\
  static struct configfs_attribute _pfx##attr_##_name = {	\
  	.ca_name	= __stringify(_name),		\
  	.ca_mode	= S_IWUSR,			\
  	.ca_owner	= THIS_MODULE,			\
+	.ca_is_visible	= _vis,				\
  	.store		= _pfx##_name##_store,		\
  }
  
+#define CONFIGFS_ATTR(_pfx, _name)			\
+	__CONFIGFS_ATTR(_pfx, _name, NULL)
+
+#define CONFIGFS_ATTR_RO(_pfx, _name)			\
+	__CONFIGFS_ATTR_RO(_pfx, _name, NULL)
+
+#define CONFIGFS_ATTR_WO(_pfx, _name)			\
+	__CONFIGFS_ATTR_WO(_pfx, _name, NULL)
+
+#define CONFIGFS_ATTR_VISIBLE(_pfx, _name, _vis)	\
+	__CONFIGFS_ATTR(_pfx, _name, _vis)
+
+#define CONFIGFS_ATTR_VISIBLE_RO(_pfx, _name, _vis)	\
+	__CONFIGFS_ATTR_RO(_pfx, _name, _vis)
+
+#define CONFIGFS_ATTR_VISIBLE_WO(_pfx, _name, _vis)	\
+	__CONFIGFS_ATTR_WO(_pfx, _name, _vis)
+
  struct file;
  struct vm_area_struct;
  
@@ -156,43 +180,64 @@ struct configfs_bin_attribute {
  	ssize_t (*write)(struct config_item *, const void *, size_t);
  };
  
-#define CONFIGFS_BIN_ATTR(_pfx, _name, _priv, _maxsz)		\
-static struct configfs_bin_attribute _pfx##attr_##_name = {	\
-	.cb_attr = {						\
-		.ca_name	= __stringify(_name),		\
-		.ca_mode	= S_IRUGO | S_IWUSR,		\
-		.ca_owner	= THIS_MODULE,			\
-	},							\
-	.cb_private	= _priv,				\
-	.cb_max_size	= _maxsz,				\
-	.read		= _pfx##_name##_read,			\
-	.write		= _pfx##_name##_write,			\
+#define __CONFIGFS_BIN_ATTR(_pfx, _name, _priv, _maxsz, _vis)		\
+static struct configfs_bin_attribute _pfx##attr_##_name = {		\
+	.cb_attr = {							\
+		.ca_name	= __stringify(_name),			\
+		.ca_mode	= S_IRUGO | S_IWUSR,			\
+		.ca_owner	= THIS_MODULE,				\
+		.ca_is_visible	= _vis,					\
+	},								\
+	.cb_private	= _priv,					\
+	.cb_max_size	= _maxsz,					\
+	.read		= _pfx##_name##_read,				\
+	.write		= _pfx##_name##_write,				\
  }
  
-#define CONFIGFS_BIN_ATTR_RO(_pfx, _name, _priv, _maxsz)	\
-static struct configfs_bin_attribute _pfx##attr_##_name = {	\
-	.cb_attr = {						\
-		.ca_name	= __stringify(_name),		\
-		.ca_mode	= S_IRUGO,			\
-		.ca_owner	= THIS_MODULE,			\
-	},							\
-	.cb_private	= _priv,				\
-	.cb_max_size	= _maxsz,				\
-	.read		= _pfx##_name##_read,			\
+#define __CONFIGFS_BIN_ATTR_RO(_pfx, _name, _priv, _maxsz, _vis)	\
+static struct configfs_bin_attribute _pfx##attr_##_name = {		\
+	.cb_attr = {							\
+		.ca_name	= __stringify(_name),			\
+		.ca_mode	= S_IRUGO,				\
+		.ca_owner	= THIS_MODULE,				\
+		.ca_is_visible	= _vis,					\
+	},								\
+	.cb_private	= _priv,					\
+	.cb_max_size	= _maxsz,					\
+	.read		= _pfx##_name##_read,				\
  }
  
-#define CONFIGFS_BIN_ATTR_WO(_pfx, _name, _priv, _maxsz)	\
-static struct configfs_bin_attribute _pfx##attr_##_name = {	\
-	.cb_attr = {						\
-		.ca_name	= __stringify(_name),		\
-		.ca_mode	= S_IWUSR,			\
-		.ca_owner	= THIS_MODULE,			\
-	},							\
-	.cb_private	= _priv,				\
-	.cb_max_size	= _maxsz,				\
-	.write		= _pfx##_name##_write,			\
+#define __CONFIGFS_BIN_ATTR_WO(_pfx, _name, _priv, _maxsz, _vis)	\
+static struct configfs_bin_attribute _pfx##attr_##_name = {		\
+	.cb_attr = {							\
+		.ca_name	= __stringify(_name),			\
+		.ca_mode	= S_IWUSR,				\
+		.ca_owner	= THIS_MODULE,				\
+		.ca_is_visible	= _vis,					\
+	},								\
+	.cb_private	= _priv,					\
+	.cb_max_size	= _maxsz,					\
+	.write		= _pfx##_name##_write,				\
  }
  
+#define CONFIGFS_BIN_ATTR(_pfx, _name, _priv, _maxsz)			\
+	__CONFIGFS_BIN_ATTR(_pfx, _name, _priv, _maxsz, NULL)
+
+#define CONFIGFS_BIN_ATTR_RO(_pfx, _name, _priv, _maxsz)		\
+	__CONFIGFS_BIN_ATTR_RO(_pfx, _name, _priv, _maxsz, NULL)
+
+#define CONFIGFS_BIN_ATTR_WO(_pfx, _name, _priv, _maxsz)		\
+	__CONFIGFS_BIN_ATTR_WO(_pfx, _name, _priv, _maxsz, NULL)
+
+#define CONFIGFS_BIN_ATTR_VISIBLE(_pfx, _name, _priv, _maxs, _vis)	\
+	__CONFIGFS_BIN_ATTR(_pfx, _name, _priv, _maxsz, _vis)
+
+#define CONFIGFS_BIN_ATTR_VISIBLE_RO(_pfx, _name, _priv, _maxsz, _vis)	\
+	__CONFIGFS_BIN_ATTR_RO(_pfx, _name, _priv, _maxsz, _vis)
+
+#define CONFIGFS_BIN_ATTR_VISIBLE_WO(_pfx, _name, _priv, _maxsz, _vis)	\
+	__CONFIGFS_BIN_ATTR_WO(_pfx, _name, _priv, _maxsz, _vis)
+
  /*
   * If allow_link() exists, the item can symlink(2) out to other
   * items.  If the item is a group, it may support mkdir(2).


And then the following for implementing it for tsm, which allows for as
simple or complicated an is_visible() function as required:

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 4ac62c896670..f29310a4a357 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -1022,6 +1022,11 @@ static int sev_report_new(struct tsm_report *report, void *data)
  	return 0;
  }
  
+static bool svsm_make_visible(const struct configfs_attribute *attr)
+{
+	return true;
+}
+
  static struct tsm_ops sev_tsm_ops = {
  	.name = KBUILD_MODNAME,
  	.report_new = sev_report_new,
@@ -1116,6 +1121,14 @@ static int __init sev_guest_probe(struct platform_device *pdev)
  	if (ret)
  		goto e_free_cert_data;
  
+	if (snp_get_vmpl()) {
+		/* Make the SVSM-related attributes visible */
+		tsm_set_visibility("svsm", svsm_make_visible);
+		tsm_set_visibility("service_guid", svsm_make_visible);
+		tsm_set_visibility("service_manifest_version", svsm_make_visible);
+		tsm_set_visibility("manifestblob", svsm_make_visible);
+	}
+
  	ret = devm_add_action_or_reset(&pdev->dev, unregister_sev_tsm, NULL);
  	if (ret)
  		goto e_free_cert_data;
diff --git a/drivers/virt/coco/tsm.c b/drivers/virt/coco/tsm.c
index 51e02001bb4d..ebb3c642f548 100644
--- a/drivers/virt/coco/tsm.c
+++ b/drivers/virt/coco/tsm.c
@@ -64,6 +64,11 @@ static struct tsm_report_state *to_state(struct tsm_report *report)
  	return container_of(report, struct tsm_report_state, report);
  }
  
+static bool not_visible(const struct configfs_attribute *attr)
+{
+	return false;
+}
+
  static int try_advance_write_generation(struct tsm_report *report)
  {
  	struct tsm_report_state *state = to_state(report);
@@ -139,7 +144,7 @@ static ssize_t tsm_report_svsm_store(struct config_item *cfg,
  
  	return len;
  }
-CONFIGFS_ATTR_WO(tsm_report_, svsm);
+CONFIGFS_ATTR_VISIBLE_WO(tsm_report_, svsm, not_visible);
  
  static ssize_t tsm_report_service_guid_store(struct config_item *cfg,
  					     const char *buf, size_t len)
@@ -168,7 +173,7 @@ static ssize_t tsm_report_service_guid_store(struct config_item *cfg,
  
  	return len;
  }
-CONFIGFS_ATTR_WO(tsm_report_, service_guid);
+CONFIGFS_ATTR_VISIBLE_WO(tsm_report_, service_guid, not_visible);
  
  static ssize_t tsm_report_service_manifest_version_store(struct config_item *cfg,
  							 const char *buf, size_t len)
@@ -189,7 +194,7 @@ static ssize_t tsm_report_service_manifest_version_store(struct config_item *cfg
  
  	return len;
  }
-CONFIGFS_ATTR_WO(tsm_report_, service_manifest_version);
+CONFIGFS_ATTR_VISIBLE_WO(tsm_report_, service_manifest_version, not_visible);
  
  static ssize_t tsm_report_inblob_write(struct config_item *cfg,
  				       const void *buf, size_t count)
@@ -336,7 +341,7 @@ static ssize_t tsm_report_manifestblob_read(struct config_item *cfg, void *buf,
  
  	return tsm_report_read(report, buf, count, TSM_MANIFEST);
  }
-CONFIGFS_BIN_ATTR_RO(tsm_report_, manifestblob, NULL, TSM_OUTBLOB_MAX);
+CONFIGFS_BIN_ATTR_VISIBLE_RO(tsm_report_, manifestblob, NULL, TSM_OUTBLOB_MAX, not_visible);
  
  #define TSM_DEFAULT_ATTRS() \
  	&tsm_report_attr_generation, \
@@ -444,6 +449,43 @@ static struct configfs_subsystem tsm_configfs = {
  	.su_mutex = __MUTEX_INITIALIZER(tsm_configfs.su_mutex),
  };
  
+int tsm_set_visibility(const char *name, configfs_is_visible_t func)
+{
+	struct configfs_bin_attribute *bin_attr;
+	struct configfs_attribute *attr;
+	const struct config_item_type *t;
+	unsigned int i;
+
+	guard(rwsem_write)(&tsm_rwsem);
+
+	t = provider.type;
+
+	if (t->ct_attrs) {
+		for (i = 0; (attr = t->ct_attrs[i]) != NULL; i++) {
+			if (strcmp(attr->ca_name, name))
+				continue;
+
+			attr->ca_is_visible = func;
+			return 0;
+		}
+	}
+
+	if (t->ct_bin_attrs) {
+		for (i = 0; (bin_attr = t->ct_bin_attrs[i]) != NULL; i++) {
+			attr = &bin_attr->cb_attr;
+
+			if (strcmp(attr->ca_name, name))
+				continue;
+
+			attr->ca_is_visible = func;
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(tsm_set_visibility);
+
  int tsm_register(const struct tsm_ops *ops, void *priv,
  		 const struct config_item_type *type)
  {
diff --git a/include/linux/tsm.h b/include/linux/tsm.h
index c4aed3059500..01b075a4debc 100644
--- a/include/linux/tsm.h
+++ b/include/linux/tsm.h
@@ -5,6 +5,7 @@
  #include <linux/sizes.h>
  #include <linux/types.h>
  #include <linux/uuid.h>
+#include <linux/configfs.h>
  
  #define TSM_INBLOB_MAX 64
  #define TSM_OUTBLOB_MAX SZ_32K
@@ -77,4 +78,7 @@ extern const struct config_item_type tsm_report_extra_type;
  int tsm_register(const struct tsm_ops *ops, void *priv,
  		 const struct config_item_type *type);
  int tsm_unregister(const struct tsm_ops *ops);
+
+int tsm_set_visibility(const char *name, configfs_is_visible_t func);
+
  #endif /* __TSM_H */

Thanks,
Tom

>   
> 

