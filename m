Return-Path: <linux-kernel+bounces-48824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBEA846216
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C2661F24052
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BFF3CF5D;
	Thu,  1 Feb 2024 20:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="n6IeRegj"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2057.outbound.protection.outlook.com [40.107.102.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987F33D960;
	Thu,  1 Feb 2024 20:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706820329; cv=fail; b=K04cPAdqawjlqjSgdieCZDl5v9zSstcfk+iwMYoITGdMMg4VyeoP7BGCmEO9lXw/q8PkRADdus5YNZZaSUtraQzjKB4ZevMm98YHYAyOmY1LWak9dL9/+NqkKZ/WDJkb94SCoUd42NMcBI7LBI9fwydaBU1qYuiJpuIknabjzl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706820329; c=relaxed/simple;
	bh=pcFnUIpFYj04wm9jVH6WkqW2OY2ZkTm4+amuOtl0TaY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sNSVKTqJhZaxE4E6RS+wfsWu1vbmsKd0pR4M/MUxuv4g67knMmpL2FehxIiOaBhcR1ZVsULbKiuG+yD8Ha+RzM0LZZASNTRoyhgqV8M8OgmEZRmYhJRH/w1JDzD5XcOhQP5lz+VAeszuzN9elnkAszZqOtxw3+ZXAr8KFlsb6cA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=n6IeRegj; arc=fail smtp.client-ip=40.107.102.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aiepqCf0XNpjYrdTeuGn0VG5uc1Vs58kmXoHh/dr1Y+LmXBjNHxDl7Eh4dW2fHr1A+ztjdhgsJlJFIK0lT0Tm3Yy9hhcjllhD2VHuQgr1Dck4pAUdJ6TZG53MqEd7BwTELYU2S4hWZaIfQhsWWX2LLxJrE+dVpXd1v3Ycm7LGOIpOwgHjtZTbDnitWTwhwEsQJYUTeqsGDU7djVDxSyzHDqvHc2pddjurSbr82V9vmagxyzFAFy+6EhPPyct8+MnA6AgWHTgv0tYMhX1D85cwg5in65vVwPF7Zzv0ydz7nVl3c+BYpC4VoKMYfIvuGaJOBPrHiBeD2ioao9XBNEzEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VANTp1oBF1i0be29b3+cnKRLuCUIp+zW0eMuI3Sj+qA=;
 b=GCVgsj+DCrX4cjCBX+GoSHYf/LDHNkuB/CryG46p4wxFArpqRlsJwJKu9WxP7PQjfNIOkUNsIOAErg/onnp89+Z6//R3JhVA3rwHHV2FlLRlmXymN7C17jzSYTgjqXYMrg/WxwPbZTkMOkB8Q4wW620ALtzhlGvp4bCxlBhuBiRV0J+XIx7QLDWRYSAc4kxWTvjpUirVkdIwPC0lcCAOGeEDlK/jQgekE3GCkxDJVPlOEhi6OrCed7aj6UervOSzmmnhvX5qoeTh31/YCOO9qW4SIQUzG85KppVWHNXo/CDOEqZSjVpgiTIuO3aLIoMgNLOqx+Vg7r2QeHpjTyXMOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VANTp1oBF1i0be29b3+cnKRLuCUIp+zW0eMuI3Sj+qA=;
 b=n6IeRegj1CDyf0P7MK3Uasm/6Mh2Bfwjr/r7IlezuibTqitG2PCcq4VdrADpNdmiPvRdI0g+JsJF11I8H2GCfcst5ITmGXiwuWuoxadRIx3IJGbdpYrcpVS0ca+qtYlTShcrqc0ff8TyKJfsvhhTZP41Q/mU+GKmm1FSl6t4f2s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14)
 by SN7PR12MB8027.namprd12.prod.outlook.com (2603:10b6:806:32a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Thu, 1 Feb
 2024 20:45:24 +0000
Received: from CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::ea0e:199a:3686:40d4]) by CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::ea0e:199a:3686:40d4%4]) with mapi id 15.20.7249.024; Thu, 1 Feb 2024
 20:45:24 +0000
Message-ID: <295d4eb0-6145-4a18-8439-fba933997321@amd.com>
Date: Thu, 1 Feb 2024 14:45:22 -0600
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3] ACPI: APEI: Skip initialization of GHES_ASSIST structures
 for Machine Check Architecture
Content-Language: en-US
To: Tony Luck <tony.luck@intel.com>, rafael@kernel.org
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org, james.morse@arm.com,
 bp@alien8.de, linux-kernel@vger.kernel.org, yazen.ghannam@amd.com,
 Avadhut Naik <avadhut.naik@amd.com>
References: <20231204192549.1953029-1-avadhut.naik@amd.com>
 <b519a7e0-77a7-44b4-809b-caf96536fe1c@amd.com>
 <c86815fe-21dc-4dd7-bf10-74e3cc754413@amd.com>
 <ZbA1P_34pUYe6aNX@agluck-desk3>
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <ZbA1P_34pUYe6aNX@agluck-desk3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::26) To CH3PR12MB8403.namprd12.prod.outlook.com
 (2603:10b6:610:133::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8403:EE_|SN7PR12MB8027:EE_
X-MS-Office365-Filtering-Correlation-Id: 30d0a6a0-c9ee-48c7-161b-08dc2366b6de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BtsK0rLLkZgo8yuXT0PTU+lGhxz32n3Qt3n3PpFu+YtVzlzN3PSi1VHNscx+jGd+l6QMwTAqe4DGayAgJFag6WeduCfqsEgG0N1IjrcboCzYn33DDMSTIHv0p41G0BgARHbeeAqrtu4cIXQ4YPM2NmP5i/jH34piaAUoiFHYbh1w83rpvg4LwrOMbmVQ73W57p+LJckZ80XEM0U78mB0OPFqFW5Ii967Ezz2vqsUPGxiPqRig9GLPMjxKrren00ZidUs8Hzz5/bfcUMdVWvCJJnEcn+xXBlUIgoXZ0KEOyoFDsi+7jzyRiZt664IzdPloWa1G5z4Ee76e0XT2CVlrJOgT9/uVGMbAtiHgkK1RrThgz/rXDYv3pWRNPV9A1r1km1YiNRcK2XKB3lsfCcRsNEN8vC5CuUymKd3nnoUVIyXxC+DUnCJchccRzXeu+3hU8ALNOC1qmpZSLAp8sv6Dy5LrqyxD7D+ysHwiiiDHruopFihLXJU8LekK25+b2/K9TXb/bWzkoN9v+Yk02fhOlEcFZzwotJpsG/wDggbDOM0RMK2BwmCeKaFzC2c1fx2lgC34uq9Rw7lyVvNUNCXP8NJpqFYniuKuDE3XUmWQYzluZc+7A0a5cXiXMwQ0PIQb2rrofcmkjSQ+0rDvHYv2A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8403.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(346002)(136003)(376002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(31686004)(83380400001)(31696002)(36756003)(6512007)(26005)(38100700002)(2616005)(478600001)(53546011)(2906002)(6506007)(316002)(66556008)(5660300002)(8676002)(8936002)(4326008)(6486002)(66476007)(66946007)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NEFvakcyaE8xcjZ5VVA4NXpGU0o0Z1I1b25FVGhCak1WbVhvd2ZZMWtNM2hz?=
 =?utf-8?B?b3ZvQXhJWTBId2cwcFcyTEVtK2t1a1AzK0VyQ3dFNFVtQVZkRW8yYTZ6cnJs?=
 =?utf-8?B?b0ZZOXkvU0R6a0ZvVUt1NnVYaEFacGRLVkE4N2NIczlTWHZmekVDMlJrZDVY?=
 =?utf-8?B?Y1I0eVpPbWtFSEhiaGo5WTJnYnFoeXRwRUZVdXd6SnBOaVVGbktBK3pxcG9U?=
 =?utf-8?B?UUhLd2I0UEZsU0FXcitQcmRLZkZwejA0ZVQ0aVlYNE1DdktmRkFSaktvYm5p?=
 =?utf-8?B?T2lqMHJZdkVjQk5vbmJqL0dPckZETE9LNGFwQzRUdStqTklQSWVmZG9kZ0F1?=
 =?utf-8?B?Z2J6akVmcXdyakxEUnA0d1R3dzZYL1JidW9sQzBjaHBDa3FmN1UvTG5NTmhu?=
 =?utf-8?B?TERxUUV1L3JmWkFyMm4wbUZkMzdZRjFtaTNER1hvRndRVi9IdkFUSFNTdHlZ?=
 =?utf-8?B?eWlkWHFOWjVrUG40M0ZXNGdzSHVRcGJubkNnZTB5dDJCSk9QaHNDeUpPYmFZ?=
 =?utf-8?B?a0UxM2VjN1VBMHg3dHp4ai96RUpjVGQ4RmtnSmlJcGdQK2FnK2JYdTQxUmpk?=
 =?utf-8?B?Nmw0YWt4OEdtQTY3dDdqWFhwbFd3VlJOaVVRQTFiRTRPVStLSGJWZWdISXV5?=
 =?utf-8?B?RlRQY3d2YWVUdFloVjM1SnJzV2c0Z25FWENOWVlRMlY3eDFWb1hXblZtLzBY?=
 =?utf-8?B?TGhPb0VYSWRkdnFjaE04YXBmOVNhN1NlT1E0cld6NDBHZ25jcTR2UUtOdlcw?=
 =?utf-8?B?RSt5SW14ZXA1Z0lpTWhSbWdSYkNmK3VnUElabFBHWDZjT0FDYUNtNG1lWjc0?=
 =?utf-8?B?ZnFkK0FlMmJNRW5FSGtDYmVhdVZiakVsZDRpc2VhU2YvaXl4TXpwQ21XVlA2?=
 =?utf-8?B?eWNpZXV4TTdMMzNNQTBaZTNqb2Jicy9oZGxpQlFhZGoyVDBWSmIxSGM1Tjha?=
 =?utf-8?B?M3QwbDRJS3J1VVZDZ3pQNXBRYnNnUzF1UjZUZk5xb3hNNTVvRHhKUnQ2Ukcw?=
 =?utf-8?B?NnFqWTV6K0hHTUVhR3AreXkwM0FNUWwwbG1zNVJsZDRxNDdOWG5ycnd1dEhE?=
 =?utf-8?B?KzFGV281Tlk1RU4wNlJUajFEaVhxeUxjSWs3UzZhTk5lbjU4WWtBeGh0T1la?=
 =?utf-8?B?Z1lGR3Y2emF3U3N6MURRNklRc1BhOWxySG1INHhuYjRrL29yNExxZzBJV1E0?=
 =?utf-8?B?NEhJcFVON1dQUGNEMDdFSEFNLzNpMkRCWU5NWFYrZU9RRnhTZ0RnN0J1eEsr?=
 =?utf-8?B?OHprcGNWYy9HWVV2L3NWdzVCWTB4MzBXUjVKbEN4V3Rrc3hIL0pvK1pHZHJ5?=
 =?utf-8?B?T0tMTXhJNG1TVkVaVnZSUkU0d1FNeCt4NGFkVVlrQ1pTTFdNS3VoUmdxc3Rr?=
 =?utf-8?B?SmFOSi9aUmxZb3lkQnJjT3kxQndMa1VCNjA0dGxRTm5JZ0RDV2VTcmkxcjJu?=
 =?utf-8?B?cm1NQ2F5dnhjdmtNQ243dGJXcFJ3VnQ4SUxYNzlwRExtRERCbHI3UWQyeWdD?=
 =?utf-8?B?dExYZ0VFY25HaWo2MEFlanNoSkNOVXg5YXQrbnpnTHlqT2JyS3FRVkZHM2Jp?=
 =?utf-8?B?eURVelZsV3luam5HMEJheHRBMjBWcDRxdGdHK1U1K005TVppWjNWRUduTUwx?=
 =?utf-8?B?eW91em9MK1RxY2lEMy9pbG5uMml0czZVMEFsS3M5RlVDN25sRW1YclBnUUow?=
 =?utf-8?B?cUFsWW5mZi9qYUlFTzA2bm1BeWkvd1UyWXhNbG1mMmJBYzh3bzdOU1JCYVFV?=
 =?utf-8?B?SG5mcmpSYndoeXU2dGVvM1ZmekIxQ1RlY1FQYm5kSzZXVmhxRjdQeGNXRWor?=
 =?utf-8?B?LzZJRWZlYWJOT05FR29RMGpmMk0zR25lRDh4Yk1vbjY4Z1kyZFM5dFlrVEg0?=
 =?utf-8?B?RUIwbHJYaGNQSFVGYjFyUXlxWDN1NVpsckJvNUkycUN5eE1rNXFlcFFxbUJ3?=
 =?utf-8?B?RmNvTGZtcnhhVUNsUys3ZVFjOHlnd1dDSm1RSEI3eUhLT3B4RzF1QmhXU1V2?=
 =?utf-8?B?cm9wOER3Y3FURU5DTnZxMkhuY2hQejBOZWVtdENLRENGWFZTcUVNRXFYaXpU?=
 =?utf-8?B?NTJFK2tVUzFhNXlXZlJhUHRpaEVaRTJZWmVJMzh6aW1NemVLY0JTOGdPWlpp?=
 =?utf-8?Q?d0bDI02TBeMAiQD8SpMBCKFel?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30d0a6a0-c9ee-48c7-161b-08dc2366b6de
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8403.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 20:45:24.3200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sov+Cb4f1O0ISSn3JxkTRqH8O2t8hWgS2B5TQooR/w3L/m8YI9B2YQZ30DvvBSLP8bCD0BFcZ7spNCS+N30Bzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8027

Thank you, Tony!

Hi Rafael,

Can this patch be merged in? Or would you prefer me resending it
with Tony's "Reviewed-by:" tag?

Thanks,
Avadhut Naik

On 1/23/2024 15:53, Tony Luck wrote:
> On Tue, Jan 23, 2024 at 03:39:49PM -0600, Naik, Avadhut wrote:
>> Hi,
>>
>> Any further comments on this patch?
> 
> No. I like the comments you added to address my earlier
> confusion/concerns.
> 
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> 
> -Tony
> 
>>
>> On 12/18/2023 11:13 AM, Avadhut Naik wrote:
>>> Hi,
>>>
>>> Any further feedback on this patch?
>>>
>>> On 12/4/2023 13:25, Avadhut Naik wrote:
>>>> To support GHES_ASSIST on Machine Check Architecture (MCA) error sources,
>>>> a set of GHES structures is provided by the system firmware for each MCA
>>>> error source. Each of these sets consists of a GHES structure for each MCA
>>>> bank on each logical CPU, with all structures of a set sharing a common
>>>> Related Source ID, equal to the Source ID of one of the MCA error source
>>>> structures.[1] On SOCs with large core counts, this typically equates to
>>>> tens of thousands of GHES_ASSIST structures for MCA under
>>>> "/sys/bus/platform/drivers/GHES".
>>>>
>>>> Support for GHES_ASSIST however, hasn't been implemented in the kernel. As
>>>> such, the information provided through these structures is not consumed by
>>>> Linux. Moreover, these GHES_ASSIST structures for MCA, which are supposed
>>>> to provide supplemental information in context of an error reported by
>>>> hardware, are setup as independent error sources by the kernel during HEST
>>>> initialization.
>>>>
>>>> Additionally, if the Type field of the Notification structure, associated
>>>> with these GHES_ASSIST structures for MCA, is set to Polled, the kernel
>>>> sets up a timer for each individual structure. The duration of the timer
>>>> is derived from the Poll Interval field of the Notification structure. On
>>>> SOCs with high core counts, this will result in tens of thousands of
>>>> timers expiring periodically causing unnecessary preemptions and wastage
>>>> of CPU cycles. The problem will particularly intensify if Poll Interval
>>>> duration is not sufficiently high.
>>>>
>>>> Since GHES_ASSIST support is not present in kernel, skip initialization
>>>> of GHES_ASSIST structures for MCA to eliminate their performance impact.
>>>>
>>>> [1] ACPI specification 6.5, section 18.7
>>>>
>>>> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
>>>> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
>>>> ---
>>>> Changes in v2:
>>>> 1.	Since is_ghes_assist_struct() returns if any of the conditions is hit
>>>> if-else-if chain is redundant. Replace it with just if statements.
>>>> 2.	Fix formatting errors.
>>>> 3.	Add Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
>>>>
>>>> Changes in v3:
>>>> 1. Modify structure (mces) comment, per Tony's recommendation, to better
>>>> reflect the structure's usage.
>>>> ---
>>>>  drivers/acpi/apei/hest.c | 51 ++++++++++++++++++++++++++++++++++++++++
>>>>  1 file changed, 51 insertions(+)
>>>>
>>>> diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
>>>> index 6aef1ee5e1bd..20d757687e3d 100644
>>>> --- a/drivers/acpi/apei/hest.c
>>>> +++ b/drivers/acpi/apei/hest.c
>>>> @@ -37,6 +37,20 @@ EXPORT_SYMBOL_GPL(hest_disable);
>>>>  
>>>>  static struct acpi_table_hest *__read_mostly hest_tab;
>>>>  
>>>> +/*
>>>> + * Since GHES_ASSIST is not supported, skip initialization of GHES_ASSIST
>>>> + * structures for MCA.
>>>> + * During HEST parsing, detected MCA error sources are cached from early
>>>> + * table entries so that the Flags and Source Id fields from these cached
>>>> + * values are then referred to in later table entries to determine if the
>>>> + * encountered GHES_ASSIST structure should be initialized.
>>>> + */
>>>> +static struct {
>>>> +	struct acpi_hest_ia_corrected *cmc;
>>>> +	struct acpi_hest_ia_machine_check *mc;
>>>> +	struct acpi_hest_ia_deferred_check *dmc;
>>>> +} mces;
>>>> +
>>>>  static const int hest_esrc_len_tab[ACPI_HEST_TYPE_RESERVED] = {
>>>>  	[ACPI_HEST_TYPE_IA32_CHECK] = -1,	/* need further calculation */
>>>>  	[ACPI_HEST_TYPE_IA32_CORRECTED_CHECK] = -1,
>>>> @@ -70,22 +84,54 @@ static int hest_esrc_len(struct acpi_hest_header *hest_hdr)
>>>>  		cmc = (struct acpi_hest_ia_corrected *)hest_hdr;
>>>>  		len = sizeof(*cmc) + cmc->num_hardware_banks *
>>>>  			sizeof(struct acpi_hest_ia_error_bank);
>>>> +		mces.cmc = cmc;
>>>>  	} else if (hest_type == ACPI_HEST_TYPE_IA32_CHECK) {
>>>>  		struct acpi_hest_ia_machine_check *mc;
>>>>  		mc = (struct acpi_hest_ia_machine_check *)hest_hdr;
>>>>  		len = sizeof(*mc) + mc->num_hardware_banks *
>>>>  			sizeof(struct acpi_hest_ia_error_bank);
>>>> +		mces.mc = mc;
>>>>  	} else if (hest_type == ACPI_HEST_TYPE_IA32_DEFERRED_CHECK) {
>>>>  		struct acpi_hest_ia_deferred_check *mc;
>>>>  		mc = (struct acpi_hest_ia_deferred_check *)hest_hdr;
>>>>  		len = sizeof(*mc) + mc->num_hardware_banks *
>>>>  			sizeof(struct acpi_hest_ia_error_bank);
>>>> +		mces.dmc = mc;
>>>>  	}
>>>>  	BUG_ON(len == -1);
>>>>  
>>>>  	return len;
>>>>  };
>>>>  
>>>> +/*
>>>> + * GHES and GHESv2 structures share the same format, starting from
>>>> + * Source Id and ending in Error Status Block Length (inclusive).
>>>> + */
>>>> +static bool is_ghes_assist_struct(struct acpi_hest_header *hest_hdr)
>>>> +{
>>>> +	struct acpi_hest_generic *ghes;
>>>> +	u16 related_source_id;
>>>> +
>>>> +	if (hest_hdr->type != ACPI_HEST_TYPE_GENERIC_ERROR &&
>>>> +	    hest_hdr->type != ACPI_HEST_TYPE_GENERIC_ERROR_V2)
>>>> +		return false;
>>>> +
>>>> +	ghes = (struct acpi_hest_generic *)hest_hdr;
>>>> +	related_source_id = ghes->related_source_id;
>>>> +
>>>> +	if (mces.cmc && mces.cmc->flags & ACPI_HEST_GHES_ASSIST &&
>>>> +	    related_source_id == mces.cmc->header.source_id)
>>>> +		return true;
>>>> +	if (mces.mc && mces.mc->flags & ACPI_HEST_GHES_ASSIST &&
>>>> +	    related_source_id == mces.mc->header.source_id)
>>>> +		return true;
>>>> +	if (mces.dmc && mces.dmc->flags & ACPI_HEST_GHES_ASSIST &&
>>>> +	    related_source_id == mces.dmc->header.source_id)
>>>> +		return true;
>>>> +
>>>> +	return false;
>>>> +}
>>>> +
>>>>  typedef int (*apei_hest_func_t)(struct acpi_hest_header *hest_hdr, void *data);
>>>>  
>>>>  static int apei_hest_parse(apei_hest_func_t func, void *data)
>>>> @@ -114,6 +160,11 @@ static int apei_hest_parse(apei_hest_func_t func, void *data)
>>>>  			return -EINVAL;
>>>>  		}
>>>>  
>>>> +		if (is_ghes_assist_struct(hest_hdr)) {
>>>> +			hest_hdr = (void *)hest_hdr + len;
>>>> +			continue;
>>>> +		}
>>>> +
>>>>  		rc = func(hest_hdr, data);
>>>>  		if (rc)
>>>>  			return rc;
>>>>
>>>> base-commit: 629a3b49f3f957e975253c54846090b8d5ed2e9b
>>>
>>
>> -- 
>> Thanks,
>> Avadhut Naik

-- 


