Return-Path: <linux-kernel+bounces-128399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A38895A58
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 423861C227E2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B68914AD10;
	Tue,  2 Apr 2024 17:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="v26a0BS6"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2114.outbound.protection.outlook.com [40.107.243.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C23132C38;
	Tue,  2 Apr 2024 17:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712077573; cv=fail; b=nzlj6IhCfCrcMqsIBPadxtI7LMSDJMq9IXaYsFJvSWVDjM/oP4QN4jMnGRLrw8vrOgTzgeaf4m4srf8HtocDo1E0a9hJrBxUVXv/4xIEkQOupK6HcxlCWXtm8BQy8Qw2v2MUO8yqgbqc3o3X0/Jhsq80ddallwI8GL/4js0zHiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712077573; c=relaxed/simple;
	bh=DSlaXkJY9jgGP/nwf4+BvNefelwRmyV5DeaqBtBpVOw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fJlGAPCnl+d6hAHxk2g+tUx4jIdllqaSG4Pee9tulIoDDf7JLARJpDEhaTRpvGq6eqz/i/VG2rJnGY92SuMeSLKHuKM1bo5iEM0PfEpkAEOc1XdBbA7Qn0+Aprdx9V7WkeaFjKOpVcIOanONG6mxnxfr2VNHW5+Qy8W+vTuik3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=v26a0BS6; arc=fail smtp.client-ip=40.107.243.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ca86Ei5zTRdx9/82np5dFPLC4CcNQgqv1Gpl69VAHoxQZlXhhTgVhDFJpO+TbBmyJz+WF1+We6Uz5m1s3PeV98cM5kKk45tcBTdOze99HovEuXX28kbWqoKAeCuMDq5pZGADomU+RfkbbVv4Vu/REZg8ZZWD0Znmcay3knsFjmXMoD9xjIg5LffXRXDxVnGzXlTvwGZGDmiLyUOi4IdE+PGwDjmx/to80yiPGT+2ze9KR/YkW1tlHCoXufSSfLPmhObtAtcB9KmWRHsMCMhX63DgzyuaIrf40/dopqOEs+gzQt5NFNhLsvVLu9Glk7mh8fNA/Ilv7Wid2klwZo8wow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rxOH4lVbYgnOMJYZYN3UAAW+hLwv294EEMkdHy3xoOM=;
 b=D2EzoGPsJjg2/HR36frKxqoBl1gdl00GHWdvZfs+s47S7JCS0cMpIERMSDLNterD7ySBhSprfL1ZT8afJojom0yqyZo6gce4ZDww+EhFDLv1I4XnkWMovcgGCfUdRp7+X0vPxI3wb0ocV6AO+lup6NZ4Pnxu2XvEjzbQhWKkzOAefp31PPLpp3RhUHurcBYx2dBIjhoZzlYBtSrUm9ZlmSiD5zFUlv7VbokHjn80E0mBJHmORMzekPLd8SMJofsRF+DDAJQluI41Y09077H3x33V1jfIZfqgmGVnpEWBFzALOXMTjot8i+3tpkl7Hm3IBDmy7wPJ66PgvkFX7YrLTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rxOH4lVbYgnOMJYZYN3UAAW+hLwv294EEMkdHy3xoOM=;
 b=v26a0BS6oV9LVG1p1IBbVy/V3+8IqDHznM4d4TymU5wNxTvBNF6gVvaTFSpLD7Crc3061vgWMkvFffYZsCY/nDD/IGJJX3WtosN9bt9dJqZtpjJbvPQQQdkxV+FRdZy6gRi4rgvywC9frvqKqEFGCCF+tpSC5REZYP5dVG5wM7A=
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by MW6PR12MB8916.namprd12.prod.outlook.com (2603:10b6:303:24b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 17:06:09 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::3cc5:f552:44ae:1f26]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::3cc5:f552:44ae:1f26%7]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 17:06:09 +0000
Message-ID: <6f0d2ccf-243c-4073-a470-21e2f404595a@amd.com>
Date: Tue, 2 Apr 2024 12:06:07 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/sev: Apply RMP table fixups for kexec.
Content-Language: en-US
To: bp@kernel.org, thomas.lendacky@amd.com
Cc: bp@alien8.de, linux-kernel@vger.kernel.org,
 linux-tip-commits@vger.kernel.org, michael.roth@amd.com, x86@kernel.org
References: <2ab14f6f-2690-056b-cf9e-38a12dafd728@amd.com>
 <20240402163412.19325-1-bp@kernel.org>
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <20240402163412.19325-1-bp@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0086.namprd13.prod.outlook.com
 (2603:10b6:806:23::31) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|MW6PR12MB8916:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2sMRnUy2to4f8CPKXQSVdSgy/S9dd3d7OW0a++RQvLjV9uwMnW+1ywbJUzTKdLCg5SdtlCNOZ/RIVfWmk9+Wd6OeOziBarzkwu9hyqIgYWpPiDxQ4X9JsXJnAcn1m6e598yS4F7mg3qb8M8I/PgeQXBmLllgbeMqvGFSdLmuMbnGePe5GqN4TgqrVQ+aKhalsaYUbLn+22q/bK6/n3AAzPH5PbI/gKeSgfq5o4SvzGPg2SMcsVOTe3+o9WGy/04g+Ty5lTH919isNYOGyOZoKngj0m1RXdKdeqcXekpaYbp6DqMtWiDKHnevJWE8Uy4S3x/IPKCLRWBmE3VitJgLF6xXZV33I2I8/wQbwvunlBbKElxH0+WZN110llfCNtzBw5ooCOV8SDZmacuLY45U9cxyhNBlCCUCHKTWHBi3KJ+WOmIeH23h4YxKLuvShtFv3M8J3FMKQlpO04vURBzjOglkUMgVy+Ad6+PrYe9eLTOycgJBszbfCTHO1XTto+adFYgnfCj+6wUiYsr4NhY7auvTSVGO3/B8I0Fq9zniRKDdHZlJmg4SCxHelxvusneWo9cs0YCoC3ksv9yCZCGpe8n/UC+bAXujgckzUmxjuV/Vf9aKhQpdDy8ywkdTLSddYjeQcMiSogtHln1G4cgdoJzQJc50RrxqI7ssPMwh58k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUtlM0hoL3MxYk5ZRkdEY3pZdnJmK3dvZVkya0U1UmVBdzNON0pVN3RnTWRP?=
 =?utf-8?B?MlZTczJTcU5DUUkvZ0R3OGJCd1YxVGEwaFJia3YwV082Sm5FQ080MjlzSVZV?=
 =?utf-8?B?dVBCTzAwZXRaNncvQ2JVeUZCSlFQbGNkVnJJb0Nna2Y0dHdNRmZkQTVXNU55?=
 =?utf-8?B?anBsVCtRV2NMWHlNSEVwcU1wSUg3MisvRDFYMnJCZzRYc2dqQmdpQlQxYkhW?=
 =?utf-8?B?RXBCdFJEUk91a1d6aWZBa2YzZHN1ZHRLRE56eEZsZy9aejl6SnBGcHpzbS8w?=
 =?utf-8?B?MXBTWEVwRTl1V0hld1ZRMkluaHRmRHIybnVQOXdkc1ZMZ3c4TGFLSCtRT0Y1?=
 =?utf-8?B?Y3VnSXo0VmptT2k5ekQzYnlEWGtqV0hZYjRydXJpWEpzYzJROVAvR3FsTTRm?=
 =?utf-8?B?N29zbWExUUJHU2xDWFhFbkh2a1ZBWjUydFhYc2dya1NUTG10R0dTcW1FOFM5?=
 =?utf-8?B?RXpxeTU3WXYyMXZwdUFYbkE4blo3ZXk2QWI1ZjFNVVVzNEZ0N3ZVRkladmZR?=
 =?utf-8?B?VnhqRWhBVjZnK25vcENGMjlFaTZJNXZLUENQbnBScjJkd2JiYjdpUEZubzRC?=
 =?utf-8?B?RSs4TE56WWhKcmlpQXd6dElJcVVwTnpBenVqdFlVKzErYVp0NW9GT3dwck9Q?=
 =?utf-8?B?cjJnRGNtYWJ2K1prVG9sd0oraU9RUklpVGVDUWdjOTlIb1FhMmxvR1huMHN1?=
 =?utf-8?B?aGxvVVNsUndTVnNkY1B6aVhLd3pSRG5jYnZlSUhOSDY0aHNyeHFkcFVGT3A4?=
 =?utf-8?B?UWgwakVwNUlSUkRldUhuN0RDeVRYWUpXamlsMmk5Tnl0azB2ZkdNV0JPWU1P?=
 =?utf-8?B?QmxhMXVlU016RDJUTEgxYXN1S0xmWElXR1VxSDNud0JadmlBQ1U2WlVPYTdG?=
 =?utf-8?B?V2QrWmNiSmorMVFCZ2d3Y3ZMRnFvaFBJT0Y4NXlmTlVKaW0zM3RYMDhsRDkr?=
 =?utf-8?B?eUprMi9zdjhtdkNBTFN1MDVkcHIrQjNLT01lM3Ryc3RIVUprZmhLOTJUWWVY?=
 =?utf-8?B?SzVQd1lPMlNqYTJIZWp6Nkk1T3VlVEVzY0xxaHlLOWJIODBXdDNkd2g2cXVW?=
 =?utf-8?B?K29FZEFRRDU4Y2Ruck1WSW16ZkhwUU5TTXRKS2VzYmpsc09mUE5KS09lVTNQ?=
 =?utf-8?B?TTJUSVJDaldsaGhQbTU5Z0I3VU94cVRZdUZXNE1jeitLeEE5TXFSdFJIQVlT?=
 =?utf-8?B?b0liVEYydjZyaDFRTXJ4WndjTlR6K1N2dUxESmNaVFp0WWpQVGg1VENzNFVj?=
 =?utf-8?B?VEdOUlozRTcwMDFLM3dvQjZ1ZXdub1dJekVQUStDRUMvRzJZQnU2Ukx5SUg4?=
 =?utf-8?B?OWU2a3I2QUE5c3VBOWkvVFVQWDNLQkNrMnI2SlJKcThaTHVsak5Sb0o4Vjh3?=
 =?utf-8?B?eDRxZURGanhpUkduZ3k0UzdXSk9GeFZITzZOaC9ab1ZsK0ZkL0JodXdmWTJR?=
 =?utf-8?B?UHhzTERYSDViN1BqbW9uMm1LN2FKc0xWOGxjb3hkc0JUZHluSkZDSFdTTHFr?=
 =?utf-8?B?QjBRT3NjTFo3cEV1cEU5RHl1bDVianVOellFdGJEZ2orVmVPR0ZraGRRelg2?=
 =?utf-8?B?eUc0aDZOMHpiQzQwRjNXSnI5eExnOU50Y29DTDlOQlRlc3JyN1R4cENvQjBB?=
 =?utf-8?B?TWFzV1J2cjZwVWdPMExUR3JleDFpbUZRVkxvS3EvdW5JcE9hcVg3UTZRVHBG?=
 =?utf-8?B?b0xiQnBNdkVwTXhHRE1PRVNJT0dieXRPcVRFZ0VVSXZHMXBOZ1pVTGQxYVdu?=
 =?utf-8?B?Y0lIRG9oNjh1VTk2ZnkwUTlQcEtIUXRGMjUwc2NCV0hsZ2pjclY3bVJJSDFH?=
 =?utf-8?B?bHE5emFabVFKM3ROcGJPUWo5c1g1TDdkSFRqeHdjZW1pZ1YzdkVkSERNK0Nr?=
 =?utf-8?B?b3BNaTlMUkRnRjk5RDFYdzUzVE5kY1h6eHVzWEZjdjQ0VjlEQ29xZWJKSzcz?=
 =?utf-8?B?RDRWZWI2SHhYYlp5WGJ6TmFIU3RyaFVEZStiY1ZWMWlNZkQvd1FaN21YdlpW?=
 =?utf-8?B?KzZTSGw5L3VseElURG5UdnhwUE1LbE9VRE1ac3ZZLzhubXM5US9POS94U1Fo?=
 =?utf-8?B?RWM3SjFzRUt6UjQxZ0JXUndCSWdJSHpRdkUzRlFweXNwc01EMDJTOXBTZjls?=
 =?utf-8?Q?A/hRybWCnqwcRvkxzwQOhzN0v?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d6bc42c-fb02-4ab1-8d58-08dc5337310b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 17:06:09.2633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4K4BuMTI7tn8mYQVHmW5wT5GJhnUZQMrAdBLGc4hmSX5d5W0xaQuXeVAq3Ul/HJIoaigvVuIi6vfaLVUNj++fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8916

On 4/2/2024 11:34 AM, bp@kernel.org wrote:

> From: Borislav Petkov <bp@alien8.de>
>
> On Tue, Apr 02, 2024 at 10:54:50AM -0500, Tom Lendacky wrote:
>> There's no requirement from a hardware/RMP usage perspective that requires a
>> 2MB alignment, so BIOS is not doing anything wrong. The problem occurs
>> because kexec is initially using 2MB mappings that overlap the start and/or
>> end of the RMP which then results in an RMP fault when memory within one of
>> those 2MB mappings, that is not part of the RMP, is referenced.
> Then this explanation is misleading. And that whole bla about alignment
> is nonsense either.
>
>> Additionally, we have BIOSes out there since Milan that don't do this 2MB
>> alignment. And do you really trust that BIOS will do this properly all the
>> time?
> I don't trust the BIOS to do anything properly.
>
> So why isn't the fix for this simply to reserve the space for the RMP
> table to start at 2M page - even if it doesn't - and to cover the last
> chunk *also* with a 2M page and be done with it?

But, it is the BIOS which reserves the space for the RMP table.

And if you mean the reservation in the kernel page tables (directmap) 
then that will not help as kexec uses it's own identity mapped page tables.

>
> Not this silly overriding dance.

This overriding dance is required to fixup all the three kexec tables, 
as there is no interface/API available to do modifications/fixups in all 
the three possible kexec tables.

Thanks, Ashish

> Thx.
>

