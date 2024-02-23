Return-Path: <linux-kernel+bounces-79114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A5B861DBF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57F291C215BE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A00146E8C;
	Fri, 23 Feb 2024 20:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Y7BS1rdM"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE061448E5
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 20:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708720878; cv=fail; b=noJw6K7Q5KKyGg4LwFSiXKT3qV+gdMSu3DJa5tP+GPLYCAZmMc/2TBLsavF2YJwv+snILjsA59FHdZgEuOJkXX7lKWW1Q2JlZpc+rbm7z5RBl/sOFIGpaNB4LxI7jM2kgRT7gIJup16zfOkfTIYHp94aeB3UCTeshjB4/33sxmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708720878; c=relaxed/simple;
	bh=/RKyquWLks5WsBEYfOD82AIVlpTBn76FnRuGfsxcai4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IDpkrswJLRheftoGYNPQ4JahtsGAneQsIrYvv3JsDzLJ/xokzG0tIsKW5wVk4P7yVtA0u/oMolGIdZiO0x7XqROOuW12d6H1kB5cg+U8aROtNOEYe4bxImcCI1GWDKRGBUpJwm2I2lwnulKajd4QoHXHxOWzZ5X0PyPs+ShWpK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Y7BS1rdM; arc=fail smtp.client-ip=40.107.223.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OMaojZvB9B0Sm/VPaK1SsuuPVEsPzwiuReExNiotV70Mfff7U3NqmaJGcoeAUFJq1wgYrMJ790nmglnmGAHJUq8MZFSssIZhBg0assjBVOLdxnvW+HHu9+3GEqRykgmgNr9p+g4JQ6bF3KlGfYjlKGc3j4MknbUUwAl4zE3vNaPCjCta7lA4MnCnjFXEcrIdlCPASaV80TD3w/ut4o5QniLWsAvVmLvOf9As3EN0S1b7Yy4HHk7VEc1g0P3mC1z/fT2EUzylY7Ug869w9UjGxO5niLUyp/mton2e65OoYGx4vPyM6EzS262wOoPdHfA0pDBn/14yPgGfFDDuM8M/eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4t6IP3oaNj4jG3NdL6LupLADPW5Id8CjOjXkm0n3jvY=;
 b=d/JEes0ZqBpbKhsO1GFD+ARCQEYhrwNnI8DEfOp7SUkagS1gKGLpjHUi0hpCUmsuz/2U0eEiYUG228daignGsuMHukqJb9rB6beO/KHk40d65UXMqd9KHVE6hjOtxT9/rQ3/39sv66a5tA/stgU2eUfv7byG0Y26Rv4y8+0oK5tT7NS2UoVHCLleJd3ieaUXKApytMx1v0+Ypq5xwcNH2H5Dd2km1lkC8AZ4Oss+e8Sv6IgvAZ6n+xqyZp6pVgKldw/phM55tsFEUVGy/rM3rBIjJ1fF98luL5AjFpIMzGt1hLFFqpqxFhnNqaLbZLP0tlDaOfPVjnU0Lpzw/4YJnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4t6IP3oaNj4jG3NdL6LupLADPW5Id8CjOjXkm0n3jvY=;
 b=Y7BS1rdMyXqyoMxYfh1ekQwqozFxDqLv8HdgIl3cnWYPVI2mGsQr+WGGiug54cultxWS8Ypy4WlQyTwQ+TeyBWgWBW+6mWuHAUlCr7WTbWjlhFyd35qSoU8utOzvXvMD6UsLK+O3bkBpgRE/JgyiOUP3K8njhLelNeQKaTQbQBc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by MN2PR12MB4190.namprd12.prod.outlook.com (2603:10b6:208:1dd::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 20:41:13 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::db9b:a5f:5d0a:2a42]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::db9b:a5f:5d0a:2a42%4]) with mapi id 15.20.7316.018; Fri, 23 Feb 2024
 20:41:13 +0000
Message-ID: <1adda7f0-0061-4296-ae6f-dd767676c23b@amd.com>
Date: Fri, 23 Feb 2024 14:41:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 10/11] x86/sev: Extend the config-fs attestation support
 for an SVSM
Content-Language: en-US
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
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <65cad52616ffa_29b129412@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR05CA0104.namprd05.prod.outlook.com
 (2603:10b6:8:56::16) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|MN2PR12MB4190:EE_
X-MS-Office365-Filtering-Correlation-Id: f5602ff5-9365-4cfb-a404-08dc34afc64f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4UGTe34ri7+7R0UU51EGjZXp5i2tYsxd2XzKnfZsYeJEjTtC3eEeds3l604JnW0LIsjhpkbLZNomqt7e22kDpwoB7gfuZ90WEOc1O3nKmMImKCj0CwilvyiRALVTlQ/7KwiJvG6ISYHlzHDedlumjw/c/AXH/i8vxgEN2pj8xFBd/9Eg6IRsNORgw2uRhzEsUL8A+WBWLeIuLYLzAduBSSCBkihGN7QZ690RgqmN1Kugc7Ti+FaZXvi03X0q+ct6hhRS9YyrNfUnSya5iRkYMoZ3b6YFBMtvG5IETt+gF9U5U+PJLPKRM6mTqHidMxRiGT3HBPp1AGj/adcwJ6wpfedU3k+hdsjQ1tp83WZIjquknFMAEymC70+/88SEe/k0M1mDerjOOY1Ixa+XUKKUGVXrUOp9rtAcNChqgB+YPzGJQiG5RPb/YvZEzilVukgmwNkdT/cZIZYl4IXSIT+hfu5QR4dnALFRZpJ0wIDCOz/S9+CI3JSGhqQIbtK0gA5r13QOrQ7i2koLQd7vmHH4DQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QXlVd3V2ZVplbWwrTDBaeFdnWEhkOER2clo4SCtIMGJ5OExkQ0oyT2NGRnhX?=
 =?utf-8?B?UEV5aVZDcFpYRHd3c2o0b2RvWWxoSTVLQWh6bm1XSFBtL1dXbU5rb1ZpMjVl?=
 =?utf-8?B?czM3cVN6MWlXTDRVMkNrTUY3V2t1Z1pYUzhTeS9uMHVXWnVhNkJGSVBScEE5?=
 =?utf-8?B?Y1g0OVlUMEsyNEpXR3lJK25WdFIycmR5UG1MaGNQcFB6djNjWUo4c1pLR01B?=
 =?utf-8?B?TVJaOTZJemVLMEdPU0tmTEV1U1JlOUNUMklSSDVtODVCOTgySWZsOXhYZjlv?=
 =?utf-8?B?L3FGWGt6RzVqcTBqVURybXp6WXFZd3p2c1JoVHFodWNIMk9xWDBLZG0vMHZ0?=
 =?utf-8?B?VUdpZzAreS9ScmlYWXRrTmR4SVRVYUV4UkI5b0N1VUJnUTgzWWJQRVR4bnFi?=
 =?utf-8?B?OEd6SWM4S0VWT1poaHpmSkV4STNaa1hHVWFrZnc0aytTM0xuY1c2Q2lvSlhQ?=
 =?utf-8?B?bk9mWHd5ZUNXTHJrcEhjRUJUQ1pLQnc4UUxZOUxLVVNweWNxMmNNMk9XZHBa?=
 =?utf-8?B?a2dObGdxSTFFT2NVMlYrRDhRQ08xMVNTN1dJVjFCOEhnRmdXMDN0WWJlSnFU?=
 =?utf-8?B?T0kzdFFBaUZIUTVhRERkNWp1U25jUDJCRHIwK0UxK3VYTW5hMnNkT0lMdU1D?=
 =?utf-8?B?MU1wQXVsTGR5VVhYQWFyYlBld1EySkNrSlRUSU1QQW5hVHpKS2ZLT2YzV2N5?=
 =?utf-8?B?T2ZjUlJ1YjF6dHFEWXF1ZGF0YVdCVHliczg5Z0hTaklPd1R2RWxpdFdaczll?=
 =?utf-8?B?UXlHek5ZOE9qeWVmVFczN1pDYU0zZDRGYWYvZFBhaEp6TkxlODBGYS82S0F5?=
 =?utf-8?B?Q3ZWczRaTmVtQ2ZpOTVGSEE2VjdQVVU2dzQ5OWxHaXVkSHM5OVp4TjlFeG5m?=
 =?utf-8?B?T2QxMDlwaFZFVU1weHBEcUFCL1RUSWRybkdjSVRkcGZCM0tXVXZaQXAvMSsv?=
 =?utf-8?B?b2ZhM1prZDhXbTVLQi9ocThEb2dGSms1alVHVzZ3bGVlYklRM0lFRTkyM0xP?=
 =?utf-8?B?anB0eHd1dVRaOGR6akR0VjFkUGY5OUhDS2I2ZWNSQVJ6OHFCcHlWQjloRFRh?=
 =?utf-8?B?eWJoV1pRdFBOdDFRWWxmeGJzS0lGd2w0VUt1NTNXMDhHTHNvUHM2QUNHVkFp?=
 =?utf-8?B?UGg3azhidXoyQ1V4Mmw5T3U4ZXdXV1c3ak5JblNJdUMvZ3V1cjJKYW1Udits?=
 =?utf-8?B?Q2luNDRNS3M3Ui95Qm9JTml5WExaYlNhZmh1YVJSTmNETWNZSDVCVk4yc3I2?=
 =?utf-8?B?ZXYrcDlQeTc1cC9Va1NEaStIY01BOFVlK3htdC9haU9ZWHBmUE9QYlA0ZmJN?=
 =?utf-8?B?bTJRd3ZHZzRwallwblRIMUJrWW9Zck96S2tvY2QrQUU1OTNYTGJRS1BzTGhQ?=
 =?utf-8?B?UUJ6VitnSnMwcFVwWE5EWERYMjMrNXFxYnBkTnVPeVlYcDBnWThESXg2UjNz?=
 =?utf-8?B?T2g4aC9QNG9hSlZ4cmxNVXJtUWVGN1QyZlYxc084ZFQxQlBkdGlOVCtadWVR?=
 =?utf-8?B?bkoxUWRaZFQ3R0N2NkFWYnlRTzM2YzgyNGkyOURNNDJCNTVyaTdsN25IS1Qy?=
 =?utf-8?B?dmgyMkpKUGZOQmx5c29qVC83eDJ4amp4dGVMVVg0ckhwVHROWXJWTVZFUFRE?=
 =?utf-8?B?TmRqKyswbVR5S3NReWlHeVFERXZQR3JrMkdpdVpmWHlOMGJCN21rbGY5ZFdB?=
 =?utf-8?B?NmtNd3NOU2VaOU1kK1hmVUFHZWZoU054VHdGQTV2V0U1SjhxM0lWQm5Uanpm?=
 =?utf-8?B?VjAyTnpXalAyeWtDQXpzNGNLYko3SlRpWlVCQWovM2VkK01iZGpmS0NVNFZS?=
 =?utf-8?B?cnRoUWwyd1I2ZnlqZW0yUGVEOEtDcEp2cFZ2Z0E2OWhPdFV2MUNVeW94T2tz?=
 =?utf-8?B?U2NXTXQrZmNVR0s0aTRoRkFobllFTXFERHhxWGtUdE9nUFZubTNpN09KcjBK?=
 =?utf-8?B?V3NWSnRaMmV3K1dnL1JxWjlpeHpUUTdlL3JhcTVqZDlyVEhrR0pXTWhORkMx?=
 =?utf-8?B?UDQxbXFCMUVVK2dWMW9yOTEvSUJvTE9rMWhwMzBRMXNZQ0hUVGZDZUtNUmVY?=
 =?utf-8?B?U3B6OTl5SmdCb1M5cWd1WUYyb0pUb0RqNlEwVnpvc0M4N2J2Vk80dUdRQlV0?=
 =?utf-8?Q?fYt/eV16gBegzCa0M04S0SKh1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5602ff5-9365-4cfb-a404-08dc34afc64f
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 20:41:13.1779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BW1CeG9pHkoA21IG6UI4swh3xNXr6ryWcWQHOAAcorFOlvOy639CleNcE9RB15e5hFC5BH2AazCYWJPmI0nbTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4190

On 2/12/24 20:34, Dan Williams wrote:
> Tom Lendacky wrote:
>> On 2/2/24 01:10, Dan Williams wrote:
>>> Tom Lendacky wrote:
>>>> When an SVSM is present, the guest can also request attestation reports
>>>> from the SVSM. These SVSM attestation reports can be used to attest the
>>>> SVSM and any services running within the SVSM.
>>>>
>>>> Extend the config-fs attestation support to allow for an SVSM attestation
>>>> report. This involves creating four (4) new config-fs attributes:
>>>>
>>>>     - 'svsm' (input)
>>>>       This attribute is used to determine whether the attestation request
>>>>       should be sent to the SVSM or to the SEV firmware.
>>>>
>>>>     - 'service_guid' (input)
>>>>       Used for requesting the attestation of a single service within the
>>>>       SVSM. A null GUID implies that the SVSM_ATTEST_SERVICES call should
>>>>       be used to request the attestation report. A non-null GUID implies
>>>>       that the SVSM_ATTEST_SINGLE_SERVICE call should be used.
>>>>
>>>>     - 'service_version' (input)
>>>>       Used with the SVSM_ATTEST_SINGLE_SERVICE call, the service version
>>>>       represents a specific service manifest version be used for the
>>>>       attestation report.
>>>>
>>>>     - 'manifestblob' (output)
>>>>       Used to return the service manifest associated with the attestation
>>>>       report.
>>>>
>>>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>>>> ---
>>>>    Documentation/ABI/testing/configfs-tsm  |  55 ++++++++++
>>>>    arch/x86/include/asm/sev.h              |  31 +++++-
>>>>    arch/x86/kernel/sev.c                   |  50 +++++++++
>>>>    drivers/virt/coco/sev-guest/sev-guest.c | 137 ++++++++++++++++++++++++
>>>>    drivers/virt/coco/tsm.c                 |  95 +++++++++++++++-
>>>>    include/linux/tsm.h                     |  11 ++
>>>>    6 files changed, 376 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/Documentation/ABI/testing/configfs-tsm b/Documentation/ABI/testing/configfs-tsm
>>>> index dd24202b5ba5..c5423987d323 100644
>>>> --- a/Documentation/ABI/testing/configfs-tsm
>>>> +++ b/Documentation/ABI/testing/configfs-tsm
>>>> @@ -31,6 +31,21 @@ Description:
>>>>    		Standardization v2.03 Section 4.1.8.1 MSG_REPORT_REQ.
>>>>    		https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/56421.pdf
>>>>    
>>>> +What:		/sys/kernel/config/tsm/report/$name/manifestblob
>>>> +Date:		January, 2024
>>>> +KernelVersion:	v6.9
>>>> +Contact:	linux-coco@lists.linux.dev
>>>> +Description:
>>>> +		(RO) Optional supplemental data that a TSM may emit, visibility
>>>> +		of this attribute depends on TSM, and may be empty if no
>>>> +		manifest data is available.
>>>> +
>>>> +		When @provider is "sev_guest" and the "svsm" attribute is set
>>>> +		this file contains the service manifest used for the SVSM
>>>> +		attestation report from Secure VM Service Module for SEV-SNP
>>>> +		Guests v1.00 Section 7.
>>>> +		https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf
>>>
>>> I wish configfs had better dynamic visibility so that this could be
>>> hidden when not active... oh well.
>>
>> So do I. I played with the idea of having two different structs and
>> registering one or the other based on whether an SVSM was present. Thoughts?
> 
> That's the status quo for the differences between TDX vs SEV
> (tsm_report_default_type vs tsm_report_extra_type). I think a
> "tsm_report_service_type " can be a new superset of
> tsm_report_extra_type. That that just starts to get messy if
> implementations start to pick and choose on a finer granularity what
> they support. For example, what if TDX supports these new service
> attributes, but not privlevel.
> 
> It seems straightforward to add an is_visible() callback to
> 'struct configfs_item_operations'. Then a common superset of all the
> attributes could be specified, but with an is_visible() implementation
> that consults with data registered with tsm_register() rather than the
> @type argument directly.

I've been playing with this a bit.

For the configfs support I was thinking of doing a per attribute 
is_visible() callback field since the TSM support is currently all in one 
group. The callback field would be checked in fs/configfs/dir.c 
populate_attrs(). A simple bool return value should suffice, I'm not sure 
we need to get into umode changes. If the field is NULL, then the 
attribute is displayed. If non-NULL, it depends on the callback return value.

In order to keep tsm.c as vendor neutral as possible, a way to 
provide/override a default callback would be needed. The new SVSM related 
fields would have a callback assigned that always returns false by 
default, so that these attributes wouldn't be visible. A new tsm.c 
interface that takes the attribute name and a callback function can be 
used to override the requested attribute. For example, the SEV guest 
driver could register a callback for these attributes that returns true 
when running under an SVSM or false otherwise. Or it could leave the 
default in place and register a callback when running under an SVSM that 
always returns true.

Thoughts?

Thanks,
Tom

> 
> [..]
>>>> +What:		/sys/kernel/config/tsm/report/$name/svsm
>>>> +Date:		January, 2024
>>>> +KernelVersion:	v6.9
>>>> +Contact:	linux-coco@lists.linux.dev
>>>> +Description:
>>>> +		(WO) Attribute is visible if a TSM implementation provider
>>>> +		supports the concept of attestation reports for TVMs running
>>>> +		under an SVSM, like SEV-SNP. Specifying any non-zero value
>>>
>>> Just use kstrtobool just to have a bit more form to it, and who knows
>>> maybe keeping some non-zero numbers reserved turns out useful someday.
>>>
>>> ...or see below, maybe this shouldn't be an "svsm" flag.
>>>
>>>> +		implies that the attestation report should come from the SVSM.
>>>> +		Secure VM Service Module for SEV-SNP Guests v1.00 Section 7.
>>>> +		https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf
>>>
>>> So this affects the output format of outblob? I think @outblob should
>>> probably document the fact that it depends on @provider, @privlevel, and
>>> now @svsm. Probably all of the format links should live under @outblob
>>> not @provider.
>>
>> It doesn't change the output format, it is still a standard SNP
>> attestation report. What changes is that a SHA-512 hash of the nonce and
>> the manifest are taken and passed as report data as opposed to just the
>> nonce value.
> 
> If it is the same format, and the input is user controlled then I am
> confused what the new ABI is selecting? Could it not be inferred by
> privlevel?
> 
> [..]
>>>> +
>>>> +What:		/sys/kernel/config/tsm/report/$name/service_version
>>>> +Date:		January, 2024
>>>> +KernelVersion:	v6.9
>>>> +Contact:	linux-coco@lists.linux.dev
>>>> +Description:
>>>> +		(WO) Attribute is visible if a TSM implementation provider
>>>> +		supports the concept of attestation reports for TVMs running
>>>> +		under an SVSM, like SEV-SNP. Indicates the service manifest
>>>> +		version requested for the attestation report.
>>>> +		Secure VM Service Module for SEV-SNP Guests v1.00 Section 7.
>>>> +		https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf
>>>
>>> Perhaps document that version 1 is assumed and is always compatible?
>>
>> Can do.
>>
>>>
>>> What prompts new versions and how does that discovered by guest software?
>>
>> New versions will depend on the service that is running. Changes or
>> updates to that service would document the new versions manifest output.
>> There isn't currently a discoverable way other than calling with the
>> requested version and seeing if an error is returned.
>>
>> A possible extension to the SVSM attestation protocol could create a
>> version query call.
> 
> Can the version be made to not matter, or be inferred by the presence of
> a new enumerated service capability? For example, make the same compat
> guarantees that ACPI methods do between versions where extensions are
> optional and software can always use v1 without breaking? Otherwise, I
> am not grokking what software should do with this version.
> 
> Separately, is this a version for the service protocol or a version of
> the manifest format? The description makes it sound like the latter, but
> the "service_version" name makes it sound like the former.

