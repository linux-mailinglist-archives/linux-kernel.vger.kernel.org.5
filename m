Return-Path: <linux-kernel+bounces-147163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63ED28A7058
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6D2C1F22E06
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6F8133421;
	Tue, 16 Apr 2024 15:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Pd157vcF"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53992132810
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 15:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713282793; cv=fail; b=g0yxOrTpN5Ornsfs7esOBk6c8OrsPXCW1Vx7T4+v63nTJ8+DvdH6re9yub+CrS3qgGu8AeFY/vjj5/b0oFLi2iL40eZtw2/emaymEgIjgDJFjzMkfQukm/i9ZCSgU0/CSZyfuZv2mVTCZE4vwum/xvnygJnSeJ/i24roTp1miyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713282793; c=relaxed/simple;
	bh=1QQi5ia16iMiFzSX/rB5BAlIYgzgiLFgkRLabzsuQSw=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=iptr+RVaoWgar5n2tRDe3ioBNycWwi/qjPWW+qpynLdLbU+DPgVnFhw3+OhnoCSqBLjzZYoxlTEbHOHWk5uInymmaiDs7qoD9niuHyEIamRHp5z06D7yw0/9043khbldzTt1JeB01rzXu332aOCG39zrZaQMFrJWgtjcgo0jzE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Pd157vcF; arc=fail smtp.client-ip=40.107.93.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dAEc06VpCpzHQ58Uwm5knojCkbgTWxX4KSWvI2V7pZCeAfuKAmHZIhCokdxcBddRkYoe+OsuAylP4U5gxnh+htXHkr6afBLNWwNzExwdNla7xeUWNzDWbxXSsVED9IzUKvfsuSIrR56GM2JuZjpF8F5a9mjZq8f823pDxzFXKZ6DFA0cla7JK6T6xmcpJOL8gFWyG9gH6GTM4qTtLdQeLxkwXnMAmoam5845BI3BOc+hMm/l+AHBmr649M7t/AvEozZk633Rzm1BTnKblk4LurCuofRhIlQIE+v0gGDcZk4g+Ty5H50D8+Qsudr48Qy+7dyrJWSbGR5BedGuCjDAsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UAW3glFbi/4fuFqXmyvpAwzObKsmS2JOxYv+DhWfe9Y=;
 b=lq/nXjFk9hu+I3ozzgPn0dT7XIGzWJswPMDd6QJEayYGBDNHBywrLU8Gde+X01vMZ5eDFKNZyNBO4VTjkoiqY5vBsWdbI0TuMTrsfQNG119cC2IUpOyP3seCqFltO3vWX2dmaalokPCewkWxMFisVyvnFejypYKhI2jAhGXk6bF5Zfc/Si+Bc3y+t3QuDtotGalAlQHLNHu6Cbw163dYRNiQtz+z7JJivIo6b/KjPg4copOKrpNAOlnSncs+KUxQ+DNlyNjfIQtyYNQIHWap2v/4SNZrRdr7S6XZ2MhG1VLfhTnUVPQz4pRiMycwZN1MH3/INAAot8gwWWxUQvqhkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UAW3glFbi/4fuFqXmyvpAwzObKsmS2JOxYv+DhWfe9Y=;
 b=Pd157vcFUiTUdl7LGF467ZnpVfmOXT9+y+vKbRd+DiHEXyXGaR81YSS8G2UcsD0qE+a2OjmdUnzKiyX9zVaP8imVKBGl2KzyavDIlUhcWtSQ0JPqyrXNRlv8Js875MDEY+AHOvkO4hxSfsbkJWmpwaJ4ZaUzezMBkDd+/0CSMJI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by DM4PR12MB8557.namprd12.prod.outlook.com (2603:10b6:8:18b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 15:53:08 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52%6]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 15:53:08 +0000
Message-ID: <3732b0d2-0471-48ce-89b8-43f425040846@amd.com>
Date: Tue, 16 Apr 2024 10:53:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-coco@lists.linux.dev, svsm-devel@coconut-svsm.dev
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Michael Roth <michael.roth@amd.com>,
 Ashish Kalra <ashish.kalra@amd.com>
References: <cover.1711405593.git.thomas.lendacky@amd.com>
 <1ca853e149fe37be748c028a9b0d00237eb73938.1711405593.git.thomas.lendacky@amd.com>
 <661e0e9418862_4d5612941c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v3 11/14] x86/sev: Extend the config-fs attestation
 support for an SVSM
In-Reply-To: <661e0e9418862_4d5612941c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0012.namprd08.prod.outlook.com
 (2603:10b6:805:66::25) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|DM4PR12MB8557:EE_
X-MS-Office365-Filtering-Correlation-Id: df7c8bdb-99d9-49f4-4b44-08dc5e2d4fb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	clyngwm3bpwrnVDY1xtvNtXJiCBnH/6nhwJyktgmKx+SKnGF17fBzUb1jR9tdwZc8leQCUcszUoC0qPYwCk267AwzpMMCx33tJ8iBSDIKDLWUfoJkMOFTgh5wBLb4aN6Rknl4ldRBalnpDS6V/TypISX6+ZMae318mSzhhIzXRFDHR9KaOpoDePTgwizpZ6qkXuiR/++vJhnlw3m4f/MVi/kXROvH79xRuGLTHYSbBvLd5rPwelyuCZyfJKQ2uU0b4ax89aRtcmhJRsa2WDXnepBGKpDRqBIvHOUs3KhZnwFYuCbsi/AriWL+AX0vKXEtM/AO3MmFi8+bVaq+RXX9IBCa8GppSf5iJ9U9aK8ZM018FlS/PW+4c7D/J3VvLH46d5Tsm1CVaCYFoeI6Sf3SpmT3Mya11DReRnkPFXDxiIuHiT18+gVLJQ69BtdDsap87eneWPR6Eq4jUQasm7k0hGaYkf5iomI4ui7xNnGHuyC2h9bGFsMiqnKvgYWAHaX19IDEOkX65KH7iq3KAWYLpuen6NZUgvL8X7Dq9TcbqG8wYHs0lhHot0Yp6fkWIYcyC5x4bKw3YRUwIfhMTc3BLBxRYSFzqEutoCjEcUL6T/3SItdDcYSg8jIMaHV+sev
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c1ZsTEdvM1BSRUUxRENTK0ZPbzhkaEFPbVRpcVdLSnovYjJJV2pIR3dDeFZC?=
 =?utf-8?B?VG5nekRPNEJ4N3ZNeTRRdFVJUjVNSjExNmZTd3F4Z3NQYWZucGJjd2wweU1j?=
 =?utf-8?B?TW9NbWZ2Ly9zYWlQKy83NG56V0Q5U3paem9RNm83MTRIdk5mblBIWFhwWjZU?=
 =?utf-8?B?bFQ2WW5pY0FVN0NvRjB3NlVpSnpKdm5HM05DeVNRQ045MVN6NDFnTkplbkpa?=
 =?utf-8?B?dCtjN2FpdnY2azNmUmRuV1BFT3F0ZTJ1OVpIRi9xMEl3ZW40L1NxVElaeGdE?=
 =?utf-8?B?cmx2eS9xc3lhTmRVR1FheklQNHRwMXk1dHliTUg1ZU9XeVRRTjg0RTdVcXB6?=
 =?utf-8?B?aXpueFRwbUNhbnRBSHBqRXdqckg1MU0zVU8yTnorQWY3dm44dVdxcnR1RzY0?=
 =?utf-8?B?YTVWV0IreGJBcGZIZ05peVNtMy9KYlhtWS9KUHlPSVFtK1V1d3lXTHdiODRT?=
 =?utf-8?B?Rzg5dUJEQkdpdFliQm1wVWs5cWM4bTZSa1VBUXNHQUFiWUJjZ3IrWjJmcG1W?=
 =?utf-8?B?aXZJeDdybTFEMk9pTWk5cUx1ZHg5c1NVSXlBOGJZekEzNzdFa0ZKTXhCa3Zp?=
 =?utf-8?B?VkxDUUtNWDFNRHhYZ1NtZm9NT0hDQzc0eHlNMDl1cXJXZFkwVnFZbkpYTTZn?=
 =?utf-8?B?SHdISmpCNzFUcEFXeHJoU1lHaitlQnEySjA5THBZNkZDQmlGUytSdjNOWXJ5?=
 =?utf-8?B?dllKUTIzZ0dJWFphcm5ub1R5b0kyNXhRdjdidE0xMnIwYTZ1YUw3N3BmbEl0?=
 =?utf-8?B?bi9lTTFYNnNTbDBtMkJWelllQ3pkZ2swcjVtdEVtcmZEOVdxSGVjcDJ3TXlU?=
 =?utf-8?B?WHdQaXlRc1dORS81c1NwY3I2Y3B6UlNnODcyenJjWGhhdE14Q3UxcDBJYkpr?=
 =?utf-8?B?cWlUdldPU1NKRUJLc0ZBN3lIYjl2MVhhK1VGTk9OKzBJWndFaVVyenBnNkRw?=
 =?utf-8?B?N1Z6SU9DbEdxMDZkMFh3M0dxQ1pkeTJNQTAyWXNwaUUyeCtDS3lUZUZoSzBS?=
 =?utf-8?B?SkZDNWh1eHFEelpGdkdqcFEybmJDYmFKbG14b043WEUxd1lzQ1pCbC9xeUJ5?=
 =?utf-8?B?anlRRElmTDVnRG1JeUdDMktVeVFYdWJ3WllqTTJZWG8yUkdGbCtsY0I3cE03?=
 =?utf-8?B?aHpsT08yWmF0UU84U2ZLYmNNR3IrVjBpTm14NVB3UUErMFh0TS9OSFN3YTRN?=
 =?utf-8?B?cWRCSDNMZ05HRGwwaE0vekMzMWVPZmxUYnBQRlhuSk9TQjJka0cwN1dZU3Rs?=
 =?utf-8?B?VFptbEEreHVzaUViRnpkY2Q1eFZFL2lGTTZERCt2cnF0eWVJWWQ2NTBjWkZq?=
 =?utf-8?B?eWdEWFU1VDBMTG5QTTUwamx4ZEhYRWN4L3pIRTZxOVVUSjZvSUpydTZXMk5U?=
 =?utf-8?B?cngrUjhyVTIrRnpMU0pnbUI5akYwQndKaFlXdzVMYW1DL1lVcTNDcWVYUGNI?=
 =?utf-8?B?a2hCbEJWaVM0d2lxejlmT0lRUUNZWXJUaUVTNmZ4aDcwT1JXT3NWUFYvSHow?=
 =?utf-8?B?Um13eDlZRXIvMU1yQWEvY2J2bER5T0RxWHZlZHVmNWs4MGFnWEYvWDVuM012?=
 =?utf-8?B?eUhRc2xqK0tIYmtWZVN1VHE4R3FsbnB1Z3pvL3orV3ZlUjV3S0hXbVJlUW83?=
 =?utf-8?B?TWlSTjlEaFlkY2ZoYUs1Z2thMktIWHJnM0JkYVpjYjR2OXNKNWtpbjJRc2I1?=
 =?utf-8?B?NFFKOHZ1UkJRWjFVUVg0SHdLV0c2VlFDS2FwNFJrZmM2UjRpMExSbmx2NllM?=
 =?utf-8?B?UUpLYXFydWJ3cHpxaU5FV0VvY3VZdEd6ZEFnZ3hQKzB1RGRRSFRqZnhNTUdH?=
 =?utf-8?B?VVg4WUMxdnlRc0phL3BPQ09yUExUYnRBU1FoTWhDTkdRNUdBSTJqMFh2TlVz?=
 =?utf-8?B?WVZIVXlkajROWXVzc1RQeEFzcStoZWZnZlRhbHdLNWhuN0QvcUw5RFRCcWlh?=
 =?utf-8?B?TzcyQnp2Y1RQR2dpNUJFUG1xV0Y4M2hLMmUyTGdkWHlVTzEvVGVXcXZSam1N?=
 =?utf-8?B?QUFwV0RESTFiSmRYZXdlemhiczMzeEErQjJrSy9GUmNNN1hPbk9LS2lKSFRQ?=
 =?utf-8?B?MU92azZUN3ZOdVZDWDRmdlNoSGVMVCtFSEpLZHZrQTdRTDZPWXRCRjZuUU0w?=
 =?utf-8?Q?m/kZMpq7TVnP6wLlPOB1SZ7ed?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df7c8bdb-99d9-49f4-4b44-08dc5e2d4fb6
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 15:53:08.5246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wnxVFyJIf6qlcip9PqNqOL7XXrLu+oSDDRI6GclglrGZfWJ9LjWMVoJ0Yb0d6xNGBwtj5mIWhMXWZJYzYIcZbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8557

On 4/16/24 00:37, Dan Williams wrote:
> Tom Lendacky wrote:
>> When an SVSM is present, the guest can also request attestation reports
>> from the SVSM. These SVSM attestation reports can be used to attest the
>> SVSM and any services running within the SVSM.
>>
>> Extend the config-fs attestation support to allow for an SVSM attestation
>> report. This involves creating four (4) new config-fs attributes:
>>
>>    - 'service-provider' (input)
>>      This attribute is used to determine whether the attestation request
>>      should be sent to the specified service provider or to the SEV
>>      firmware. The SVSM service provider is represented by the value
>>      'svsm'.
>>
>>    - 'service_guid' (input)
>>      Used for requesting the attestation of a single service within the
>>      service provider. A null GUID implies that the SVSM_ATTEST_SERVICES
>>      call should be used to request the attestation report. A non-null
>>      GUID implies that the SVSM_ATTEST_SINGLE_SERVICE call should be used.
>>
>>    - 'service_manifest_version' (input)
>>      Used with the SVSM_ATTEST_SINGLE_SERVICE call, the service version
>>      represents a specific service manifest version be used for the
>>      attestation report.
>>
>>    - 'manifestblob' (output)
>>      Used to return the service manifest associated with the attestation
>>      report.
>>
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>> ---
>>   Documentation/ABI/testing/configfs-tsm  |  69 +++++++++++
>>   arch/x86/include/asm/sev.h              |  31 ++++-
>>   arch/x86/kernel/sev.c                   |  50 ++++++++
>>   drivers/virt/coco/sev-guest/sev-guest.c | 151 ++++++++++++++++++++++++
>>   drivers/virt/coco/tsm.c                 |  93 ++++++++++++++-
>>   include/linux/tsm.h                     |  11 ++
>>   6 files changed, 402 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/ABI/testing/configfs-tsm b/Documentation/ABI/testing/configfs-tsm
>> index dd24202b5ba5..72a7acdb5258 100644
>> --- a/Documentation/ABI/testing/configfs-tsm
>> +++ b/Documentation/ABI/testing/configfs-tsm
>> @@ -31,6 +31,21 @@ Description:
>>   		Standardization v2.03 Section 4.1.8.1 MSG_REPORT_REQ.
>>   		https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/56421.pdf
>>   
>> +What:		/sys/kernel/config/tsm/report/$name/manifestblob
>> +Date:		January, 2024
>> +KernelVersion:	v6.10
>> +Contact:	linux-coco@lists.linux.dev
>> +Description:
>> +		(RO) Optional supplemental data that a TSM may emit, visibility
>> +		of this attribute depends on TSM, and may be empty if no
>> +		manifest data is available.
>> +
>> +		When @provider is "sev_guest" and the @service_provider is
>> +		"svsm" this file contains the service manifest used for the SVSM
>> +		attestation report from the Secure VM Service Module for SEV-SNP
>> +		Guests v1.00 Section 7.
>> +		https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf
> 
> Should this be "See 'service_provider' for the format of this blob"? To
> date external "format specification" links are only referenced once in
> this file, and this one is now duplicated.

Yes, I can do that for this and the other ones you identified below.

> 
> 
>> +
>>   What:		/sys/kernel/config/tsm/report/$name/provider
>>   Date:		September, 2023
>>   KernelVersion:	v6.7
>> @@ -80,3 +95,57 @@ Contact:	linux-coco@lists.linux.dev
>>   Description:
>>   		(RO) Indicates the minimum permissible value that can be written
>>   		to @privlevel.
>> +
>> +What:		/sys/kernel/config/tsm/report/$name/service_provider
>> +Date:		January, 2024
>> +KernelVersion:	v6.10
>> +Contact:	linux-coco@lists.linux.dev
>> +Description:
>> +		(WO) Attribute is visible if a TSM implementation provider
>> +		supports the concept of attestation reports from a service
>> +		provider for TVMs, like SEV-SNP running under an SVSM.
>> +		Specifying the service provider via this attribute will create
>> +		an attestation report as specified by the service provider.
>> +		Currently supported service-providers are:
>> +			svsm
>> +
>> +		For the SVSM service provider, see the Secure VM Service Module
>> +		for SEV-SNP Guests v1.00 Section 7.
>> +		https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf
> 
> Given "SVSM" is a cross vendor concept should this explicitly
> callout: "For provider.service_provider == sev_guest.svsm" as
> preparation for other implementations defining their "svsm" manifest
> format?

I'm not sure. Do we need to get that specific? If SVSM is cross vendor, 
will it be using / adding to the existing SVSM specification? If not, 
then each vendor is likely to have its own name for the SVSM concept 
that would be unique enough...

> 

>> +
>> +What:		/sys/kernel/config/tsm/report/$name/service_manifest_version
>> +Date:		January, 2024
>> +KernelVersion:	v6.10
>> +Contact:	linux-coco@lists.linux.dev
>> +Description:
>> +		(WO) Attribute is visible if a TSM implementation provider
>> +		supports the concept of attestation reports from a service
>> +		provider for TVMs, like SEV-SNP running under an SVSM.
>> +		Indicates the service manifest version requested for the
>> +		attestation report. If this field is not set by the user,
>> +		the default manifest version of the service (the service's
>> +		initial/first manifest version) is returned. The initial
>> +		manifest version is always available.
> 
> ...and that number is zero? Is there any expectation that the kernel

Yes, that number is zero.

> sanity checks this version, or how does the user figure out they need to
> roll this request back?

Right now there aren't any non-zero versions, so there is nothing for 
the user to figure out. However, the service will determine when it 
creates a new version and then the user will need to understand what the 
reason for that is and decide. I'm not sure I can give you a specific 
answer at this stage, but we need to allow for a change in the manifest 
without affecting existing users.

And since the spec has been approved already, I can't really go back and 
add a requirement that manifest format always be additive.

> 
>> +
>> +		For the SVSM service provider, see the Secure VM Service Module
>> +		for SEV-SNP Guests v1.00 Section 7.
>> +		https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf
> 

>> +static ssize_t tsm_report_service_provider_store(struct config_item *cfg,
>> +						 const char *buf, size_t len)
>> +{
>> +	struct tsm_report *report = to_tsm_report(cfg);
>> +	size_t sp_len;
>> +	char *sp;
>> +	int rc;
>> +
>> +	guard(rwsem_write)(&tsm_rwsem);
>> +	rc = try_advance_write_generation(report);
>> +	if (rc)
>> +		return rc;
>> +
>> +	sp_len = (buf[len - 1] != '\n') ? len : len - 1;
> 
> This feels like it wants a sysfs_strdup().

If there start to be more string oriented operations in the file, then 
it might be worth it. For now I don't really see a reason.

> 
>> +
>> +	sp = kstrndup(buf, sp_len, GFP_KERNEL);
>> +	if (!sp)
>> +		return -ENOMEM;
>> +	kfree(report->desc.service_provider);
>> +
>> +	report->desc.service_provider = sp;
>> +
>> +	return len;
>> +}
>> +CONFIGFS_ATTR_WO(tsm_report_, service_provider);
>> +

>>   #define TSM_DEFAULT_ATTRS() \
>>   	&tsm_report_attr_generation, \
>>   	&tsm_report_attr_provider
>> @@ -265,6 +348,9 @@ static struct configfs_attribute *tsm_report_extra_attrs[] = {
>>   	TSM_DEFAULT_ATTRS(),
>>   	&tsm_report_attr_privlevel,
>>   	&tsm_report_attr_privlevel_floor,
>> +	&tsm_report_attr_service_provider,
>> +	&tsm_report_attr_service_guid,
>> +	&tsm_report_attr_service_manifest_version,
> 
> Shouldn't this patch come after the configfs dynamic visibility so there
> is no point in the history where vestigial attributes show up?

Sure, I can do that.

Thanks,
Tom


