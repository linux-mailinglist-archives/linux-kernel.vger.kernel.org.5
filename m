Return-Path: <linux-kernel+bounces-69230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 980608585FA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBDDE1C21BDA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E29135A42;
	Fri, 16 Feb 2024 19:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="M5KVS1VT"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2F21EA76
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 19:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708110462; cv=fail; b=MgIhAwWu3M1cw/S1PkHSWCTc57nBIFcbXTP//UUX0Vc2qR1TgEuBbtPvHK6XQ2NuPdqipcUIZYlzpkHpUYFHdUZlHxrTAgNTzzNeVHHzuy8gutbRoHh+x2ADXElq4NtR7/V+bC1U5LB8GU+K8O7rmAsx8/N19YN90JDn7jepgIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708110462; c=relaxed/simple;
	bh=sXZkAmSbcYz5Jq1jq1V77VSVh6Y6tlRHjIQVlChQ0Yg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oxEUUMzZO6yM2ypLBixZdntLwDmQmkyo25BpuTe5adKUA2jhuFL1w4EgBQx0JqUj/XeZ/9lnOr9yPB5qf+/EkhSzYMRFsLbkhK0Rat97oXHWmkQG5wdjVc5nt/Kz3hQLz4j/gz344v5Xu811OrkK236mA7pjSjoUa+7j7oV1Snk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=M5KVS1VT; arc=fail smtp.client-ip=40.107.237.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TfdCW+0q6UyYtleznKy5RIR6ye0Id71MxVKt2rmaPeMIA7wL/BmGkW9bFQmx5PUhUq5JnOZNzoshj5qYrwKS1wP+dNw3REuuX5ZgvfbGxCT3lS784hHFzO914lR/ombyWlxJqLlbSwaISmn2t2XjeAv1KmS+3FYZFWiY6wKBRp+PMzbPgLs8VHQCsIxeOhA7L4w2GAgSrsy/ECNs3OBAOakZwkBbeymiUx90qZzLFWDrVOvYPk2KgNdP5K/8Ets0z7xWibzCpHP5fYJ00UKQZFTXreTFPTnIqrgKkToEurJ2dYP5kARHYiMGUIxwiiDFSo7Dlxqpsvigkxo5piKKvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/TId6ypdOK0oV0z3StF3/LFSRaAYHt1EHXjeek8grR0=;
 b=mH7x8LSBcVbsG5MBVXlN0X16tSdjkyzNiAokCp6nTp0ovr2SVv5Oiks1lECSb0Gpp+jRE+mcqd3Dwx1QcoAgeaTPM6NBlvc80PxQk/DnYZ5C4X53roDAswN+OOZtMrLrf6f3FAZI+c0gvD1Z8KL5FQgS1M4nOVbngqVjaJeoTv8iKc1LNZyyThdH0TW2DRSA4DG1walUfh3CMV8aGvrs+rDzdNXY/bYwxw7/KYQ9E+rqYqyvYxv/Q1Z5BuFvrmAHk6O8sx6Ln1qQgHNVGv3Vnfn8gi/uGfclM1Cn9wsWmAcHY7d1sP5fyU4kDZ+xREJJwn2IJFcRcNpaPS7x6qgtNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/TId6ypdOK0oV0z3StF3/LFSRaAYHt1EHXjeek8grR0=;
 b=M5KVS1VTLtfpsPCXY/rt1DPzwBElZEGEPVPrgRseEdtwaDclODzkL3kqM6z8+kBUbYN5t8uYkA3J/9Z6MilgLjlbr933ZPCzBOGLxhHLiHwgbnFsH9qIaVcBZVVD6HKKOK0FVeV86MMJulPQvRTHEcmNQPXJBa8SiPbrnp1eKjk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by BN9PR12MB5291.namprd12.prod.outlook.com (2603:10b6:408:104::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.14; Fri, 16 Feb
 2024 19:07:38 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::e164:6d6:c04c:ff59]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::e164:6d6:c04c:ff59%6]) with mapi id 15.20.7316.012; Fri, 16 Feb 2024
 19:07:37 +0000
Message-ID: <ed3d8b93-2631-45fb-dd9d-69a97a9338a7@amd.com>
Date: Fri, 16 Feb 2024 13:07:34 -0600
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
X-ClientProxiedBy: SA1P222CA0182.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::20) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|BN9PR12MB5291:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f364b6a-ae02-4187-6921-08dc2f228a42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PXS69rqtuPK6e4X6iESfgnSt9CZvhogiZhbPRjAyWwSocCyHjy/FmwStPcLgLIq+5F+ZjqD4VEcLUqN2ThYiyZUuxEEl6v+ohRWkZh4MlBJPLntsFbKpQXnOYr8HrxSXcU3nnHwWuMiX1TYgiWmWhTdzhyR2Je1/cVsJfeO8dduKGBzoW8f3ji+WDQ4/UNrhkvA2Ies9cnPrVbr6rGXVkIuaBHzZ/xEx+OPagqIekzFCyQ/ADHcPHha4P9kt605VDgZirK7+UNAKElvBQX3fRFima9GBz74mC/awMcLN/gf48Ej/VQ5srUYyCsO99pFKf9X8B0e+7QYUm7a7aa09YiRIZ0icvfT3v06pKd9VwqnvuNWg1spc3l88WjhjhV+o65Mt4DNCdKdMZU77+w7jr8KrmUWHxMEEzAZhcObWG0Oi3zZV534aZ4TKV9B2d/T49YG4eLfXy9UeL5ekVAMisPXlrfqdFAURGKvdbZJ0y4pHmPANd5rVulyvBAv4gB6p0xzHQ/3aY4se/MvtuTnHRXLrvZjKkJ1B+H0V6/R9jBiYPc/QQJrG4FcaqXGCTUwsuziuaCXV7P9A5GuuuhnbeQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(136003)(39860400002)(396003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(36756003)(86362001)(31696002)(31686004)(8676002)(478600001)(53546011)(6666004)(8936002)(54906003)(316002)(66556008)(26005)(66946007)(66476007)(966005)(6486002)(6512007)(6506007)(83380400001)(2906002)(38100700002)(4326008)(5660300002)(41300700001)(2616005)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?clp5clBzZFBMUGhzRnhYYXdKcjkraFhYdW1ucnJrODZ4SFo2MFFSTWFzbUkv?=
 =?utf-8?B?L2lJVjhrZFhNdWNaQlgvdWxMdlAwc0VTWkhicFRXRUJSMFArWURRZHlYcm1t?=
 =?utf-8?B?UVNreTBIU3ZnczhEZXdYcUhxN01UM0Y2U0RucGdrL1IyRjZYcFp5NzJsaXBK?=
 =?utf-8?B?aHhMMmJVRkNGbEFrZEsrUzZPbzdFSHJCZGhCVEl5bEFlUEVsaTVhOUlWRTdF?=
 =?utf-8?B?R0pFT2VldG9ndklldk9iUnNHcXdjOTNjNFZML1R0SWxxZGM0STB0QytXbzNz?=
 =?utf-8?B?Lzh2QUVIMXI4eGoxL2dIZzhCbzJybHVvenc2YnFyRnBIY1U2WFdKdDdxZ1Vh?=
 =?utf-8?B?UTQ1UElXKzB6dlFTY3pFbW9wOCsvcW1rNWxQRmM0RC9CbXpibkhEY1p2RWhG?=
 =?utf-8?B?Y0F5ZzZyb3Fqb1BZejd2enRNM2Q4aTFkWnJNRjU3dFVlWlVQZWVFcStXalJL?=
 =?utf-8?B?VEJzNDJPZnBYU0ZHbFg3S1didDEyZVZUbjdwajAzeXRDUG1MMTdTaXFXdStD?=
 =?utf-8?B?WXJXcW1NaHQ1d0xGd2lRc0UrRDBGNjBVL0k4UDR1SlNSYWpIcXQraStWSlcy?=
 =?utf-8?B?d01NcCtDb3lhWFBuOVh5eXJwQ0NnY1JaMDdpd2diVXB6b0hEOEh5ZFYwQ2pP?=
 =?utf-8?B?bGxnWDlSK2dYeGdVZ3ZkdkFWNW9qbmh5c2dPby8vYmZQeUg3VUZqWi9HcnVB?=
 =?utf-8?B?Y0pvZnJ2VDRVaVo1NVdvVCtPTTRoUGVHcXU1UVlXZ0dXNTJ5bjc0NGJtV1M5?=
 =?utf-8?B?SVZ2dnNEazN1aGJhUDIwTXM3WXk4bklDTjJHQ0MzZER2cWpjMzB1SWxzYUhS?=
 =?utf-8?B?U0l5RERJaGJ3MVFxNmpqakRtRWFHUUROd0c4c2lxdS9KVDRubmJ6bkhNMmdx?=
 =?utf-8?B?SlJoNytlRmtnYjZ4anh4aUpLRlp3alduTE9GNThvNS9hNEtuWHg5amYyZVRs?=
 =?utf-8?B?ek54K2VCelRiWkxnT3l4YW5BWEEzM3JoQmgwMWxFSGZzM3g3R2xORk91elFN?=
 =?utf-8?B?WjdGOGlQcWNNWkRIR0diT3BPVkdIblBiU3RnTjI2RWlSMXhLanViWWlrZ1E0?=
 =?utf-8?B?K2RhZitaenhwdCtqcG0vc2NHUjdvYTFkc2ROWmN2dnBPakd1T1Q4Tkk3RGpJ?=
 =?utf-8?B?cHl5S0tSU0ZuVmx2NzBUZjBmU1VIL0ZMd29uUFpGY256N3pUVmozZjBRTFR5?=
 =?utf-8?B?elo2Uk9YdWw0bytRSUVUekY5NlRnRlNoOGQ3ZlVzS1daOWkxTFpaSXF4QzJC?=
 =?utf-8?B?Q0xCTFo1R003Tko5eXNabFJOQVpHbVFXVWJWaFN5ZDhiYVJKOGtTeE9uUnVi?=
 =?utf-8?B?SzVqRW9TZ2owSUw1RGR0dlFTcEdjWkZ3UDRJeko1cXpXTEJlMFVJODlwS0FS?=
 =?utf-8?B?ZHBmZU5wT2pqTWlPdVB6WU1PMjFESS9aT2ZtNENnQVA5cEJGWlM1bmJDbldy?=
 =?utf-8?B?RVZ5OTVaaE5hVEdJallOd1Zzb3VIOVNJYndzb2gyL3dzYzlaa2drZThFZ2FX?=
 =?utf-8?B?L3d6ZDYraGJ5aE1jNWtJRmJxVzlPTEwzWWZwU2hBUy9ad2s0TVNHMHVPMHgz?=
 =?utf-8?B?Y2xOZXBkdmZ1Y3BLZmhkbnR2RG03Mi8zeHFJYUtOTWlEMUpUL1c0d0FGTnFI?=
 =?utf-8?B?KzlQNjlaQ2JHQ2hxRmNRRTNBV2VVajhkbkVQRzhlWWlVVUhON2F6R3RHN0dR?=
 =?utf-8?B?ZEJqdXFlUzZXZCtEeFFvSWJhZysyMWY5WlUxQ0FqTTY5OFY0TWx1K3RCNVRD?=
 =?utf-8?B?Rm4vZ0RzdEdYWkt4bzJkS24wYVlQcDJuQ2xuazVCS0tRaHYybXQ1bUQ2UkJ5?=
 =?utf-8?B?ckw5TlVTQ0lOUFEwME5tN2hqcUdJYmlNR2s3OEdHaFArWUFaYndoQ1lGNFVy?=
 =?utf-8?B?MlRvTUExajlEeFRDVEQrdWhKN3dhK0VISFdsNUN4ZVpsdEtvcEpFMzZNellt?=
 =?utf-8?B?bTd4aDNjWHVyUFJyVmErU1BWQWJtZ1Noa2ZhSDVOR0ZPNm1ENE5TTTdBa01P?=
 =?utf-8?B?VCtyTTN5WkJhNnhvMWg3UTdqMWFmdGxTSzhDL0I1NkxqMGdvOGFnYXFDNkFU?=
 =?utf-8?B?SVUzQW9MWDJOd3BWeVlUMjBOR1JHUW4xTzVHMGI3cHRESWNSdVA2WWk1ZW8x?=
 =?utf-8?Q?h6QSHYw5TXvQE0S/85L8jEceD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f364b6a-ae02-4187-6921-08dc2f228a42
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 19:07:37.7417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gkX7gQWidIzKds3dTpmslQ5IafXsoSFYs9ArK6T+gErqRm7qOVdKGOYrIr0CCvcwk45u83zSH7oRzxsJZVh3zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5291

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

Let me look into that.

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

The new ABI selects whether to go through the SVSM to get the attestation
report, which will additionally return a manifest that, along with the
nonce, has become part of the report through hashing.

But, yes, I mentioned in a previous reply [1] that we could use privlevel
to determine whether to invoke attestation through an SVSM request or
through the standard method of issuing an extended guest request.

[1] https://lore.kernel.org/lkml/3fca61f2-6fe0-4431-818e-9c7b96c6a391@amd.com/

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

Software can always use v1. The idea is that if a service wanted to
provide additional information or change the information provided in the
service manifest, then it would have to do that via a new version of its
manifest so as not to break existing users. By default, zero would be used
for the service manifest version and have to be updated by the user if
they wanted a different one.

> 
> Separately, is this a version for the service protocol or a version of
> the manifest format? The description makes it sound like the latter, but
> the "service_version" name makes it sound like the former.

Correct, it is for the manifest version. I can rename it to
service_manifest or service_manifest_version. I'd rather not rename it to
manifest_version since it is specific to an individual service.

Thanks,
Tom


