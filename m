Return-Path: <linux-kernel+bounces-73017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2691D85BC27
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ACD81F235B4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E6A692E6;
	Tue, 20 Feb 2024 12:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hlhacrfX"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638646995F;
	Tue, 20 Feb 2024 12:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708432194; cv=fail; b=C3m+BaO16UKdKUUDCFTrYztiVr7Y7A3RotSddsCaWHQJPF0iTNaz62eYv0yvI39/NNu+W0r0lmB43Vn9pd4pzJgLXPqtpIhfbPVl3Ky32rhyzvq76WWCLSH1xOfQC6H5pqhENjmPm9ADhAvtTtvgo2KRMUvmNOyEr9rsy4tU8JI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708432194; c=relaxed/simple;
	bh=t25LJRiI0MNkgzLn43W39avI2vybaggRFPTkoJlx1rk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=Aom+LXxJtWvZQ51uhwNtQcgTJfEDw/W9vFv4JNe0GerMnevRgkD3UixO6U43/YBB0PeMDQilZ+rKMIwBVRWD99+Y5YNQLm5ZrGWVHvEEj5bUbWbLswFtpL/h8uxs2wkdci0ss5OTvAKBR9i+dt57wmXcimuKSuZ7Z8ZFxPPbH54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hlhacrfX; arc=fail smtp.client-ip=40.107.223.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TdgeXTiY/Bu/Mf497O8W6gCHsmtI0Fgr6pVJ6Qzne43bJHalhy5uI5ex+bCgSvFwiM5qx5jSUojUnRV3U5iwRlpRxKxK5ng6sLov281mIz2XphrXfK31tgXIvThD/vZZZmfthch7QrUv9qG3WtXDShu83hOTMF6quHcVFxzQQDFghgnsLjnQDuz8vxfTNznRJlRNPtEjr7bquJA5B/WtSt9WJUxdQoj2/D0a0qX4esi0wp328UgtT4Q/XmSYn3G2BgQji87hZpOSTvfW9zrJZZDCJN1wCCovNU3WsaKl90PBHX4LChZ5ZTNihw3T185mUwgJMzOLsANHoP5EkElItg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d3lYQYrXfCj4FUam0swyfRirqUKp3duMYhogkOHPvxQ=;
 b=mx3hJbnQq6REGgSHa/hXjky1bvCUix7pSiwIjjRcyZhXZ3zfEAqjqZqDCyeBMdSTpBtwyzkhu9E09bDwDkVKxkyChnBD52h7TblenjeFPMy+Amy+SD7iTEQp37OIYscoLtvejJpui4zSwXMG7QwNWibenF0caGwYewZDP7mcn+UgtNcMyefr7/rXCCwS1tafk/NhMOkNgRkHo1VDr5Rip340A6uCHPVJiSMURwqZAAg4Ao8jP0f5Kgm5uyH1hJhbIN2FU7/HkEQwy/P9AsqgIPyrGuKT6ZpwOYSZ1kjEdSCf6IZyNULTuZIYcFtwf4R0lHPxwi949buO2pP82XBIZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d3lYQYrXfCj4FUam0swyfRirqUKp3duMYhogkOHPvxQ=;
 b=hlhacrfXdQ9c0Xi5ZAdaJR0EvfAJPtx9bvJF1b5w/iu+ibZWOHHptwQ6AbfW3aoyz+kCXFOYI6uuQ4tb+fOu0+d84Yuy2mhBv/1t4W/NsUsWlU0Y+Wy1OW6HMTTenx1yDd3jTN9DqTq5S6ImH+VSIbzrJxmPfZe/kE4oC/ZlTOA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB7325.namprd12.prod.outlook.com (2603:10b6:510:217::19)
 by DM6PR12MB4217.namprd12.prod.outlook.com (2603:10b6:5:219::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Tue, 20 Feb
 2024 12:29:48 +0000
Received: from PH8PR12MB7325.namprd12.prod.outlook.com
 ([fe80::a2e6:c3b5:4e05:825c]) by PH8PR12MB7325.namprd12.prod.outlook.com
 ([fe80::a2e6:c3b5:4e05:825c%4]) with mapi id 15.20.7316.018; Tue, 20 Feb 2024
 12:29:48 +0000
Subject: Re: [PATCH 0/2] FRU Memory Poison Manager
To: Borislav Petkov <bp@alien8.de>, Yazen Ghannam <yazen.ghannam@amd.com>
Cc: tony.luck@intel.com, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, avadhut.naik@amd.com, john.allen@amd.com,
 muralidhara.mk@amd.com, naveenkrishna.chatradhi@amd.com,
 sathyapriya.k@amd.com
References: <20240214033516.1344948-1-yazen.ghannam@amd.com>
 <20240214075242.GAZcxxSiMsDoacvC1M@fat_crate.local>
From: "M K, Muralidhara" <muralimk@amd.com>
Message-ID: <953d9c1a-b504-cde5-5de1-2ce9b838204a@amd.com>
Date: Tue, 20 Feb 2024 17:59:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <20240214075242.GAZcxxSiMsDoacvC1M@fat_crate.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXP287CA0005.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::19) To PH8PR12MB7325.namprd12.prod.outlook.com
 (2603:10b6:510:217::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7325:EE_|DM6PR12MB4217:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bf582b9-a2a4-4119-0dc8-08dc320fa0ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jYM7PbRSCOL3KKhNoT0xD/73lXI0GGlOgWTm8Qa5/lEe3h3ciM5xDBRuGOIiGaR5pJQ2OBn2twsPJjMK7o2fvwkevLFME51IYbSY6xoBcjlSYCpqFQjxeQMTR5vFJqcM1aojF8ptan+YtNno93WmAuC2zgG5iRw6L76Jc2KvJ74gsv/pKjGTmkTb0quWAi0znZ3b+u8lBROVi1ZQAJm104+3QM5zOYGsoccD72leChlFGudJyjMS+gofLa3MdRghWvYG7HhvPUni/Xes4IZWi4XfSl15HPjN0BOojWPqHVtAHOA9ocIydxNlFpuxO4+JYdZtj9dJMj31h2fu88WERfNdODTB2CBtGglBdQMC4Iz4Y3QgBy1ZLT5E5efydtBkdrlRg14PysQ+6nbx1NZusHQ7TiLGcypvqwLjweqEBMqgT6apZnqXQuQMrIqRyt0vXawkdKTuN/TKpZ90oE0sleNrpyUh5I5TnAfVtBqMjGGEi4mNWJfwNoCOxMkW5Nu12VskFamM/vNpkJvC0TzSh8wYqS2yAV0/G55aVeiuDs4KtXX8BKgjxUKfGx+z4WYL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7325.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzZDNkpWdEtjemVzdnRGNmh5N0kzay9YMlJtRmRTck8wbFVsWTdOVkRNSVFU?=
 =?utf-8?B?RjJKRVhmazI2eXpncmZCYjd1cE9GT1QwbDJqc0RXOXdVZXBId2JiUDZ2ejAz?=
 =?utf-8?B?Uml0QURoTWhSR3YzZ2NlM3Y3Z3FFY204ZWhEUVdOb2VFQW9TSldEVlhzZHJR?=
 =?utf-8?B?WUczOTJESTF2L0Y3bTdEaDFXUE95TStXRlhIdVdia2hEQXZ0NzRwb2tvejAy?=
 =?utf-8?B?d3NrME1YekMrSTFsQytOK3grdURKV21lVWZYQU9hc09OVnA0ZjZmSG1NNmQv?=
 =?utf-8?B?WFNZeUZIQk9zL3ExbnZPM2kxeTZSdDFCb005ZGU0S3EzSFFJdnoveFJESGRh?=
 =?utf-8?B?ZWxTTEN0ekpZM3lNZkwzV3VQeklRVVpzY0k0Y0pNeG9HZFdSdUh4cUlWM05Z?=
 =?utf-8?B?T1BrdEFmb3E0LzVyakVzVko0Z0dmMHcyMXNaUTlXQ3lhNTRBOER5UWxNR1Ru?=
 =?utf-8?B?ZWJ5d29mYUQxbmV2NEVKcnJyZE5vdm51c3czNS9ncHp6Uk9vcVZxZE1meDl6?=
 =?utf-8?B?aU05WlRQVFlxYnhmQUtxcXlZK2FpRG11MDF5eGxFR2R5VVNGd0JGR2NONUMv?=
 =?utf-8?B?VFQ5dlR5OUVVMFkyelExOVdWbWV2c3JvVFI3QVlMTFZSbFVqVmMxRXg0b1hj?=
 =?utf-8?B?OHZhWDg2eExtc1N4TjF5aGRUWFU5U2g3a1FubTB1YVNrOEhaWEllbWdsa0xZ?=
 =?utf-8?B?S1lRV09UcVd3ZGlvRzJ4NVNyM2NvUTg4OUpiSDhhTkpCRncwNWFJSnhMQnNK?=
 =?utf-8?B?L081bHZBQU1CV0tkdlkwUFZueXlsQ0hoMHFidHFpaGFQQkltYXE1RGs4QWRF?=
 =?utf-8?B?S2lQbVUzVWROWjVMU0xCUVNmZXh6dGwzMys2RzZXdUxFUzMyd0ZYZTNveGox?=
 =?utf-8?B?a2Jsd0VFQjIrM3lMVUt6ZDBsTFFWTE5MdWhTMVNFb0U4cGNxMm12YmNVNnox?=
 =?utf-8?B?cFBVRHFHQm5hK3hIN3JVUlFPVXFDUlU1ekw5UEJwWG14WTBSckxjVmxPWFlo?=
 =?utf-8?B?NXp5ZzIzL0RyMUdPbXF0LzlkMGhZTkNqNnhIR2x1YTdhOG81Ly80S3VjRjZq?=
 =?utf-8?B?K3VCYnAvMnY5d3ZHK3JabEsvNGp4VWhIV1hJS0FhUStwaFRPRmZJbDg4L1Q3?=
 =?utf-8?B?aml6YXlVdUdzVTh6UXYzS3d3L3NwclZVcVhSdC9SVlZKM3BRM21VTGR5T012?=
 =?utf-8?B?M3FOdlAxRFFCRngyWTdZcnV5WmRwZEQzN3ZNWnU4TnpYaWRicnUvR0JrQzZJ?=
 =?utf-8?B?UWZja2tHODY5Y2tZU01DNmMxNnM1NEFRcUVTOXlqUUZIemswTjMzVlFvUWw2?=
 =?utf-8?B?MnpsT2ZKRGZrVHBqcjZndWRBcEN5OE1ualIzR05tVHJUNVgvOHBCSHB2aW13?=
 =?utf-8?B?UUhqeEYxcHhhSkYxUHd0YmFSWDlOOXJSazRweU9NVWR5Z2t5eE9HV1R3RUtV?=
 =?utf-8?B?dHlJcm5mMGdQYkVWRW4waTBrQVJseUxDbWZYSWM4TGNKMzZ2Z08ySkh0TnRG?=
 =?utf-8?B?azdTL1g0UjFldzhQMWFKbnFpNHdRYjRTaitSNHB3SEZyYm5wZHRMZ2dvY0g3?=
 =?utf-8?B?aDluMDAwL1U0S0FlWWQxSmMxL25PWEluVXRlZnI4SzM2L0FGQk9VQjhOSDdu?=
 =?utf-8?B?bGEwU2dFZjRTMUJwSWQ2S3E4NmlvRmNOc0lVQTFYdm9pZk9qdFF6V3RoK2FI?=
 =?utf-8?B?dUh1UVZyaTdyL2RrSVFBaW43bUlSZm0yNk5oWXpDa014S3R0L3FSWUZYV1kv?=
 =?utf-8?B?NUJPQ1F1YndTZWgxUXVjWTNQVUZNT0dyTlJ0MDVNODRWbnhLNGdFZ01FL1hw?=
 =?utf-8?B?SFIzeDg4cUFOTHU1VGdCNTJYS01sQWorWEZtc00wUmhZd01jelh4bmdMbUhk?=
 =?utf-8?B?cTg1bzBXYjFremlaQUwybmg5cnhUR2Q2eDBPRWxnSnhPak90b2UzQTVUaVRh?=
 =?utf-8?B?bGc5cVNPTG9INklzakNxUi9SczFnaDV0ZkJKTStxeHlmOWZzV3ltSjhGU2tC?=
 =?utf-8?B?cUIwZ2luL1pYTWNjVTRJS2FFeC9oUUVLU2oyZnFqcVBFUUI2djRHUHdZbVM3?=
 =?utf-8?B?QkVMcXhQcGFZelVqV3lxNTU3WXRhSlNKUnRobjg4MDlxcHdxc3NLbWZDZHMz?=
 =?utf-8?Q?/Bp7gYcK4Z7h9+GULWTXsGDeM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bf582b9-a2a4-4119-0dc8-08dc320fa0ac
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7325.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 12:29:48.5069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bfGBJ6pkMKmQbArC9OfJsvv1ZEtfXV/8/J9CIPC6WuywqcbtJ4Yhg0OGQly12W+IgLpa+yq2HdWRuocZYaz4zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4217

Hi Boris,

On 2/14/2024 1:22 PM, Borislav Petkov wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Tue, Feb 13, 2024 at 09:35:14PM -0600, Yazen Ghannam wrote:
>> I included questions in code comments where I think more attention is
>> needed.
> 
> Lemme look.
> 
>> Also, I kept Naveen as a maintainer in case he's still interested.
> 
> I don't mind that as long as he responds to bug reports from users and
> addresses them in timely manner.
> 
>> I did some basic testing on a 2P server system without ERST support.
>> Mostly I tried to check out the memory layout of the structures. And I
>> did some memory error injections to check out the record updating flow.
>> I did some fixups after testing, so I apologize if I missed anything.
> 
> Right, I'd like for Murali and/or Naveen to test the final version but
> lemme go through them first.
> 
Please include, we have worked previous versions of this patch set.
Co-developed-by: naveenkrishna.chatradhi@amd.com
Signed-off-by: naveenkrishna.chatradhi@amd.com
Co-developed-by: muralidhara.mk@amd.com
Signed-off-by: muralidhara.mk@amd.com
Co-developed-by: sathyapriya.k@amd.com
Signed-off-by: sathyapriya.k@amd.com


> Thx.
> 
> --
> Regards/Gruss,
>      Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
> 

