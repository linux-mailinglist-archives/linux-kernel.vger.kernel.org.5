Return-Path: <linux-kernel+bounces-55506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A74E84BD83
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D00AC1F28487
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACB113FE5;
	Tue,  6 Feb 2024 18:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="R+uHLBJq"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEC513ADC
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 18:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707245619; cv=fail; b=QHU7Tsury+1eysUVeQD2JmcNpLD3cZ1nRtGNDcsBK67KeyPoyn/8Z84ekdPM7OWT3djApk7mS+muZmOH03b3rUjRHpoIXxqhIG6IFSR/wPa2X0LLylVnBTp4xW4LzcqMR1mBN8b4KDFeqZ14D/6HqzmaCXxDcr6YZC8fmxPiI60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707245619; c=relaxed/simple;
	bh=Bu3E2v0L9Y03sqeU1Uym9EWrk3q5138K/IRCae+g928=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X0SvAesg8h5VAHPyx14f2VScPrSW7/hr26T/nEkZJst8I92i98O1FWbepf/DDS11njixU+mvJjaKwLYTSuryMcx7UOl7fJKcgbAlg/F5vAw6+vCGI4ai0i6iGmFnvB7TP+1YuMGazqlacjyjph6/dk+nmfYPFrEzFSZlqjK161o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=R+uHLBJq; arc=fail smtp.client-ip=40.107.93.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N7NMGd6fDkhePi3AGwtifY8PDrXCacMizURB2ILP2ECG8SoDDSKjcMxRnK4rK0R/og4Tq0Ez3BVuJ3JQqa5VgnDZhMWzl4RXtDgkng1y9X4EaHICaDB5KbDM/RSrvwgPJhnpq7gvwTy+EFxHfzLyRUE5/hwFzdKlbvDMGn54lDG2gKX4cjQ9jCiO0kSXCJDv7SekH2TpcdVOMFlOsAbmCpcsYMdOhlwlhmhENBI8nM5q8iBCf51LBLmmOEEmpOcVxaIJioOPbRiwseG3dkuSQWJFYdaMf/x+UIvmANdXueLM8RtQZZXWSjgRCdfSHeT/VQlT5LUZevejVlEAVCbM2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x8hLkHT6f5Jhv3RXtwRUP4TuhqB/MGrOLbqQFVXSdxU=;
 b=f/rLvF58nOIbSMbGcPkMjDkXjkqo9eRmaYDddOdV8gWzN5QZxlr97faor0PEKUa9dd0yrbIJR0MLpegYsDx4yHrK5NZs/5t6IKcHRbC1kYQZF2AJHNxBTFM22Xfmq3lUhMNf3Q8SQCKb3qK1x/vZy9XMDX9CNXutfL+YA3nra24wO0rj5fIlXL66xuP1ixRs3r+g0UFmoDrYvOyuGQl4eVgBQ/X8emUwSZeejcSdcKq6G7VTtrwRtXw0s5z+E+xQepoQYDR7GqA7nBsZdjER4/6bi1h52EGzMzkXNZFV7MqHjjO4vCtBovrnxVNxbc4JSCrPiBfU3Mt86mwxcHDoGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8hLkHT6f5Jhv3RXtwRUP4TuhqB/MGrOLbqQFVXSdxU=;
 b=R+uHLBJqgTrDVsJ/otvbvG5mkv9xoAbPKHOCqj2pXSE7VkDQjlSiIWjy8WpfG09LgBmXZ8jjQOTJOwZ9PU2A47TgAxO0ZuXqY5CxvXyv1wui40ctXfHGcTw33KOV3x1GfoD6CCRyu/H3EjAkqTEuhgTFVqbVJQ8gOVK/niTj6EM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by SJ2PR12MB7989.namprd12.prod.outlook.com (2603:10b6:a03:4c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Tue, 6 Feb
 2024 18:53:35 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::200:c1d0:b9aa:e16c]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::200:c1d0:b9aa:e16c%4]) with mapi id 15.20.7270.016; Tue, 6 Feb 2024
 18:53:35 +0000
Message-ID: <285168ca-3b28-440e-91c7-a0c7707e29b9@amd.com>
Date: Tue, 6 Feb 2024 12:53:32 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] x86/sev: Extend the config-fs attestation support
 for an SVSM
Content-Language: en-US
To: "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Michael Roth <michael.roth@amd.com>,
 Ashish Kalra <ashish.kalra@amd.com>
References: <cover.1706307364.git.thomas.lendacky@amd.com>
 <10637f104d1ed7f21e281a4890f2c549d1e85985.1706307364.git.thomas.lendacky@amd.com>
 <65bc95732df26_65b2629448@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <f9329bb2-9000-4988-a500-17042c0081c9@intel.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 vFkWitqCJg==
In-Reply-To: <f9329bb2-9000-4988-a500-17042c0081c9@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR12CA0028.namprd12.prod.outlook.com
 (2603:10b6:806:6f::33) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|SJ2PR12MB7989:EE_
X-MS-Office365-Filtering-Correlation-Id: 88a9be17-b714-48bd-52da-08dc2744ebeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	S4XPcpElLXkahhjBFFaffX8LMDYv2aAbBDGI8qDdaFnV0XC4vqYjYzmwcH3Rr2P80hbf2TIZnfMn4pv2E4A8FUy5NaGizITshjEeL/O+EjDwxENinEgWIW9OTdgKSgksWQ6ztgPMY9UULa/gs3DPgUfslRV28Myaj0kwymDbLBJV2dJNzJzyLXI+PWoYchpCF2D3x+zw+V+cDGQmxO90//VT4jCFO6XMYtRkqNHFNCEovvwmC6QhVVcCdf1QmNpHe2syFZmn1MKYwuSFw6zGRAhgJQlRMlpa/elk1rk0/PvNmMsAQZXyfNfkuwnek1gH7sLW6bT+w4UijqlCqQ7ql+sPAOSxVxjOCODz/T3uwcZAB7XTcfzy9Hor0OXLa12NHXfuxocoDeLTNzQG7GyCRbmPNzztybx9aznCLlDo2xX/WJZcqtqgO0bxYbFzCtRKsuwy0WMeQHOJ58IRuJ5OwCCvaVi4Qd/1ney/jSikSqUaXXwGdRAyIyUP+mzT2tiJk+lW6QPIGQepN01IpbMgG9nTQoWuGP/R35rctLX+2mzrUtSXoCptAaYugRiehSf5MpXptrYltejHA4VP9MA5ma6E+0h/WJs3jLT75OK+uzKClLzQNSgSeKqdF/1gZ2CjuuQi/fzWcYgnYUeX3uO6fUyll3FvzuK+jFzvZCKAUSUl6aQ2Qn/OvE2G2e92F6Lv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(396003)(346002)(366004)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(41300700001)(110136005)(31696002)(8676002)(8936002)(2906002)(4326008)(7416002)(5660300002)(86362001)(54906003)(53546011)(66946007)(316002)(36756003)(38100700002)(66476007)(478600001)(6506007)(6512007)(6486002)(966005)(66556008)(6666004)(83380400001)(26005)(2616005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NkNrZ2NRVTZLVG9rNHNqVHdSbDFPMFRib0JPcnhGZWl3RHl5LzIwTTRKdnd2?=
 =?utf-8?B?RFduVDFCVzR0SEIrZ1pla040OHc4eVNvSkxCcGxhVDg3T0dhSld5RGgyc2Nw?=
 =?utf-8?B?ck5PckMyZDI5NVNhUW92dDNyTFRVZkNjZ1M1bzM0bXVhSFRIUko0cEJlLy8y?=
 =?utf-8?B?SjE1bVBHeDQ1bXoveThRWUNPcEcrUmwzMW1hTHdDeGNueHlEMXlGOU4rVnVB?=
 =?utf-8?B?VzBPUFNFRVFWVFZmbUFCZGdHVGNUcFA4ejlDaU1CeDU3c2Fic2lOZkJWZWFz?=
 =?utf-8?B?UEZvbDNoRXhFOVVLemgrUDdmV0xwdmJ4d1BRZWJSb1pZRnRIRVNqd2ZNSnRa?=
 =?utf-8?B?U3Z0QndTZkFtR3BMdXhNMUtZSXlST1F1R3UwTElQY21KOGkvNzg4cEpCeTNw?=
 =?utf-8?B?NkJqS0ZOMjdBS3ZFcC94RVRUWmxZS1ZwMWVWVGFwdlVpL2tpZUt0eis1ZGJC?=
 =?utf-8?B?SCtyUEhHVjNua1p0OEU3NWJMaS81c2VCK09kK3VUUXViTDJZazc2YWllQnF5?=
 =?utf-8?B?MHpTZG0zcTJVZENBQlRyMTVQMFBiU1JpQjdFODhDR0hLUzZiM2kzc2xpdEpy?=
 =?utf-8?B?ZW5RVmVnTzIra0tmMmJTZlFESktrS0RLWkJ1WTREV1BncFJjaUl3Wm0vL3Zt?=
 =?utf-8?B?TnhjMkxtVXc5MzlvT2l5YTZyNG5qQURrUGFqSllRWGN2UWdwejVSQ3lCazZO?=
 =?utf-8?B?QnhlZFlLSEwxVFQwK0NVSW5adjlJRTBtQUNyNlFSS2QzcThGd3ZjTE12ZkN3?=
 =?utf-8?B?RzJKU2ZlOG9wdVRubXZyblFWcnZSMWRBRGhLb3ZrMFpBRUhVK0RNL1VHSmRq?=
 =?utf-8?B?OU80VEROdUpJaEhBMjBWQ2x2RkU3Ui80dG9yMStqTFFxb0V4a0tRYUw5R1JK?=
 =?utf-8?B?UXpiYXhqTUFxMWgxM1lmNUdqZWdSV1loK1ZPcVVMQ0xYOVdwd1V0Y2VSejB3?=
 =?utf-8?B?cldISGJHTGIzTFdOZ1UxVzB2RkdENGJpSHY5MVdkdjkwYTlhSFh6Q0JDUWlI?=
 =?utf-8?B?aWtNVlBPY21zVmtTSDR6bUZhVTBLT0VreDhLcm5UM0Y0NE9TcHRGdGhrWGlU?=
 =?utf-8?B?bUZoUEF3ZndqOHNuZFFhK05jazFJZTJHZU1PL3FlY1dOWjQzMDlaOXhNelI0?=
 =?utf-8?B?VUxyRmZuQlduUGpLdlFyM3RZdktXdDY1RVNxWHkwTEltS2VpNm1kMXZOQ2c1?=
 =?utf-8?B?MkFaYVlWc040bytrZzl0UlJicmNBZjNyYjRyZDFQUHRTUjlhZEpuMnFZR3Ro?=
 =?utf-8?B?TGw4eHRYeVcySFhuRXNHd2tYRTJrajBjTGF0dndtcHFwVHRPNE5jWVB6L0VD?=
 =?utf-8?B?MU1RWWZjeTg4akFRRS9JbEdOYzZDTXFwdllTUWxkRU9mUnhVL1ZDeHpKRlg0?=
 =?utf-8?B?bmFWSWFvRFRhcG1JZkQreU4xaXVlQ25UekZtRkJzeTJIdUI4d29XOSswSXpI?=
 =?utf-8?B?OE9FQUpMaDc5SWE0aW8wdHE1WFhISGxMei9HZGZCOTBhaTJQZlhFbURzSU5I?=
 =?utf-8?B?emp5dWdiMTJvVGFLSTN6WTkrRWhyQUF3UktWczhVb2RkbHBuWjBuV0xra3Yx?=
 =?utf-8?B?Y2FWTkQ0clExWHZ3amNzMEN1OTRxb2krQ0ZHd1phLzdNSCtvMXJXbnlIWUlC?=
 =?utf-8?B?U1V3SnpjTU9ZeVowTjU5L3d5T3huMVNsNDV0NkFhNTh1VUhHaWxuem44UFox?=
 =?utf-8?B?a1UycTBUZ2FGYWV1T1dyTVlvSFFnS2JDZ1M2bC82SmdoNElRODg4enNqMFlV?=
 =?utf-8?B?SngzaEdlQjhDeEdJcENyR2ZVTkwrbndEZnhkcmJBWWNoMjJVeEQ1Q0R1WHBh?=
 =?utf-8?B?bDlrdm5pL29Ld0UyS05UTlcwZit6MG0vMGtzK1hPK2tSeG9lSjF4RFI3c0V3?=
 =?utf-8?B?MkZYUHdhdlM3WEl0bWFteG1TWG11L202dzF4R3VtaTU5MWd2RzVUbjJ6Y3Bh?=
 =?utf-8?B?NzJBamQ1WWNTVU0yUmhGbDZ6MHJSZ3JFM2c1b29jUFZyTUM0Y05MTkpkT05F?=
 =?utf-8?B?N0FuYTZhbjNieEpuRmNHUklEQk9JbTFzOVdXQjhWaHhnc3dqZ0JWc2ROck5R?=
 =?utf-8?B?ZXJiWVMvTGVtVTlFK2VoZmJia2JjSDcyaEp0TGhybThNU0tPOUx0ajVqb2VS?=
 =?utf-8?Q?OYFo05c3yGEk4ICbazEjZqH9x?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88a9be17-b714-48bd-52da-08dc2744ebeb
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 18:53:35.1051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J8a2Ns1LtPiUxD5iGHP48AuSopzF/QNfdVVWNKLw98fJFS7HfkM0w9JaKFKGfsJmQ0eA3Hwtc7wYWnS4r98dOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7989

On 2/5/24 17:29, Kuppuswamy, Sathyanarayanan wrote:
> 
> On 2/1/24 11:10 PM, Dan Williams wrote:
>> Tom Lendacky wrote:
>>> When an SVSM is present, the guest can also request attestation reports
>>> from the SVSM. These SVSM attestation reports can be used to attest the
>>> SVSM and any services running within the SVSM.
>>>
>>> Extend the config-fs attestation support to allow for an SVSM attestation
>>> report. This involves creating four (4) new config-fs attributes:
>>>
>>>    - 'svsm' (input)
>>>      This attribute is used to determine whether the attestation request
>>>      should be sent to the SVSM or to the SEV firmware.
>>>
>>>    - 'service_guid' (input)
>>>      Used for requesting the attestation of a single service within the
>>>      SVSM. A null GUID implies that the SVSM_ATTEST_SERVICES call should
>>>      be used to request the attestation report. A non-null GUID implies
>>>      that the SVSM_ATTEST_SINGLE_SERVICE call should be used.
>>>
>>>    - 'service_version' (input)
>>>      Used with the SVSM_ATTEST_SINGLE_SERVICE call, the service version
>>>      represents a specific service manifest version be used for the
>>>      attestation report.
>>>
>>>    - 'manifestblob' (output)
>>>      Used to return the service manifest associated with the attestation
>>>      report.
>>>
>>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>>> ---
>>>   Documentation/ABI/testing/configfs-tsm  |  55 ++++++++++
>>>   arch/x86/include/asm/sev.h              |  31 +++++-
>>>   arch/x86/kernel/sev.c                   |  50 +++++++++
>>>   drivers/virt/coco/sev-guest/sev-guest.c | 137 ++++++++++++++++++++++++
>>>   drivers/virt/coco/tsm.c                 |  95 +++++++++++++++-
>>>   include/linux/tsm.h                     |  11 ++
>>>   6 files changed, 376 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/Documentation/ABI/testing/configfs-tsm b/Documentation/ABI/testing/configfs-tsm
>>> index dd24202b5ba5..c5423987d323 100644
>>> --- a/Documentation/ABI/testing/configfs-tsm
>>> +++ b/Documentation/ABI/testing/configfs-tsm
>>> @@ -31,6 +31,21 @@ Description:
>>>   		Standardization v2.03 Section 4.1.8.1 MSG_REPORT_REQ.
>>>   		https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/56421.pdf
>>>   
>>> +What:		/sys/kernel/config/tsm/report/$name/manifestblob
>>> +Date:		January, 2024
>>> +KernelVersion:	v6.9
>>> +Contact:	linux-coco@lists.linux.dev
>>> +Description:
>>> +		(RO) Optional supplemental data that a TSM may emit, visibility
>>> +		of this attribute depends on TSM, and may be empty if no
>>> +		manifest data is available.
>>> +
>>> +		When @provider is "sev_guest" and the "svsm" attribute is set
>>> +		this file contains the service manifest used for the SVSM
>>> +		attestation report from Secure VM Service Module for SEV-SNP
>>> +		Guests v1.00 Section 7.
>>> +		https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf
>> I wish configfs had better dynamic visibility so that this could be
>> hidden when not active... oh well.
>>
>>> +
>>>   What:		/sys/kernel/config/tsm/report/$name/provider
>>>   Date:		September, 2023
>>>   KernelVersion:	v6.7
>>> @@ -80,3 +95,43 @@ Contact:	linux-coco@lists.linux.dev
>>>   Description:
>>>   		(RO) Indicates the minimum permissible value that can be written
>>>   		to @privlevel.
>>> +
>>> +What:		/sys/kernel/config/tsm/report/$name/svsm
>>> +Date:		January, 2024
>>> +KernelVersion:	v6.9
>>> +Contact:	linux-coco@lists.linux.dev
>>> +Description:
>>> +		(WO) Attribute is visible if a TSM implementation provider
>>> +		supports the concept of attestation reports for TVMs running
>>> +		under an SVSM, like SEV-SNP. Specifying any non-zero value
>> Just use kstrtobool just to have a bit more form to it, and who knows
>> maybe keeping some non-zero numbers reserved turns out useful someday.
>>
>> ...or see below, maybe this shouldn't be an "svsm" flag.
>>
>>> +		implies that the attestation report should come from the SVSM.
>>> +		Secure VM Service Module for SEV-SNP Guests v1.00 Section 7.
>>> +		https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf
>> So this affects the output format of outblob? I think @outblob should
>> probably document the fact that it depends on @provider, @privlevel, and
>> now @svsm. Probably all of the format links should live under @outblob
>> not @provider.
>>
>> I worry that "svsm" is not going to be the last name for a selected
>> family of services that might convey something to outblob. I wonder if
>> this should just be a generic "service" attribute where "svsm" is only
>> supported value to write today. Another service family could be
>> introduced later and reuse the service_guid concept, or kernel gets
>> lucky and a de-facto standard heads off proliferation here.
>>
>>> +
>>> +What:		/sys/kernel/config/tsm/report/$name/service_guid
>>> +Date:		January, 2024
>>> +KernelVersion:	v6.9
>>> +Contact:	linux-coco@lists.linux.dev
>>> +Description:
>>> +		(WO) Attribute is visible if a TSM implementation provider
>>> +		supports the concept of attestation reports for TVMs running
>>> +		under an SVSM, like SEV-SNP. Specifying a empty or null GUID
>>> +		(00000000-0000-0000-0000-000000) requests all active services
>>> +		within the SVSM be part of the attestation report. Specifying
>>> +		a non-null GUID requests an attestation report of just the
>>> +		specified service using the manifest form specified by the
>>> +		service_version attribute.
>>> +		Secure VM Service Module for SEV-SNP Guests v1.00 Section 7.
>>> +		https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf
>> Given the small number of service GUIDs so far perhaps save someone the
>> URL fetch and list it here?
> 
> How will user know about the available GUIDs? Is there a way for user to
> query this list?

In a sense, yes. You can request an all services attestation which will 
return a manifest containing all the active services GUIDs.

> 
>>
>>> +
>>> +What:		/sys/kernel/config/tsm/report/$name/service_version
>>> +Date:		January, 2024
>>> +KernelVersion:	v6.9
>>> +Contact:	linux-coco@lists.linux.dev
>>> +Description:
>>> +		(WO) Attribute is visible if a TSM implementation provider
>>> +		supports the concept of attestation reports for TVMs running
>>> +		under an SVSM, like SEV-SNP. Indicates the service manifest
>>> +		version requested for the attestation report.
>>> +		Secure VM Service Module for SEV-SNP Guests v1.00 Section 7.
>>> +		https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf
>> Perhaps document that version 1 is assumed and is always compatible?
>>
>> What prompts new versions and how does that discovered by guest software?
> 
> Why user care about it? If it is going to affect manifestblob output, I
> recommend adding that info there.

Will do.

Thanks,
Tom

> 
>>

