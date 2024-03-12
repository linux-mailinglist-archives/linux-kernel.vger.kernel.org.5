Return-Path: <linux-kernel+bounces-100086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 428F887919E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AECE01F2158C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C8778663;
	Tue, 12 Mar 2024 10:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0JSEFXcn"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6AC78293;
	Tue, 12 Mar 2024 10:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710237745; cv=fail; b=oZfJP1VosHdihfabmqmArrJ49Qwbn0wW5sWC+i1oqqT5YgAlWbMdFwpWdrSs9m17qaPOwklAmsZ00p1i6u4hzBMB7lsck0mzHyAVp7/7rSrgkK92x4K/dgv2ELbT5Z7geFdMshOmG9BDYhA6l/tjBHn43jA9wF9hhfaXMxMKwwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710237745; c=relaxed/simple;
	bh=0ZWqHd6IVdAtVMB6tceW6P3Q7TXSnGQa9op2V3rrdLU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jKfAyLkrWSM7Tgks9bnWf8IrlVYCJwt5iXPuHBlRdSi+4E2U9QrHBaAL41JvZC8HVBvtW8AZEmfObqDK9CENv/jL+LfR56QggWhw0AewQx6wPnH6L9iIWmN7A4pZXHRu/8Az+XLYYZz9sp1r8c7PM4CEJ53MLuGJ6IGtr878XYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0JSEFXcn; arc=fail smtp.client-ip=40.107.223.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=POIcw3njBL5ReNg6AzVUOVpozonnQ7KHh5ab1jxkj3+m8Per+InVbQIP+dYu6liEjIkFRZu5UPNU2RvAhZlJgWzmm3saCYdlSusE1hhyy6P0ENKOPOMabXPGaRg/JTmSkNeKu62QBmbVKj+aEUDm76rtrr68DgjvI64bwKx6xPiKEQv39XnqoE6dJGpEh3Px4tj6Uy1ixSRfY9EZDHeo2pnxUkCw1S5InTyVhq4DWybcrZ3shYdgQTfrdBu55psGAiSmIEcIa0pBw/BGYKWv8x1qm+6kCM7qTSs19xrHp58IKwJ0n+yEyqDsf/FDhBCMnx7VWnfxYuUQnAJU9bFdmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8x1Z7cGxnKefvvEM94QlaAJr8sgv73GwPJ0wt9srWCY=;
 b=fKsn89j37OP8doFoure//dIlFn8tB/k/dmsp2qo9tVN31fg0rqXt5djYb3a5wRgAEN4NQ9dfNmN/QdAbVIWlAR79tHPgaRlcM2M2JVi+SHNWdbYPfJVJWdf2aKsX30Ek0LFbcd6NlMq/u0oDgW0spZ6YD2HiYPLvPsCnHyNdpqWBVYdq2RAvCZQjS0pwGQ4IPo114C56LyQOa6Cspg3j19g9TCy6dmXarlYz2SbgIFdIpo9bro3RkRvyEu3bcEk7a0gh+ghtklroqrauuEax5o0hVt99yZuIVg3DSFrblmZXmKMM7D8g2dUX4oW9FW/Ha4qlsor83OH76+XqcI5QUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8x1Z7cGxnKefvvEM94QlaAJr8sgv73GwPJ0wt9srWCY=;
 b=0JSEFXcnrCrnUSBBADIDz/kAD3xQPHsEwIBgZscemlJwQjT2f8AIr5qYUzxPM5B6Dx36T7EEXYrqX/6vJ4nHuWraJ+LjSCKQrGqMW31ECh7K1mMkotOJOooKKWFK23C18KuyGt1i/ljkBi2Lukap/26qQwbqXswduod8ZD58C/U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by IA1PR12MB7542.namprd12.prod.outlook.com (2603:10b6:208:42e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 10:02:21 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::9dcb:30:4f52:82f5]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::9dcb:30:4f52:82f5%5]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 10:02:21 +0000
Message-ID: <82d5ada0-7963-4b1a-bae7-f2fce2befb57@amd.com>
Date: Tue, 12 Mar 2024 15:32:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] perf vendor events amd: Add Zen 5 uncore events
Content-Language: en-US
To: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 adrian.hunter@intel.com, eranian@google.com, ravi.bangoria@amd.com,
 ananth.narayan@amd.com
References: <cover.1710133771.git.sandipan.das@amd.com>
 <e100c902fd9e1e4f58e3a9c175d572962a9cdd50.1710133771.git.sandipan.das@amd.com>
 <CAP-5=fU=gO49ASVVLUbT5bFPoOE3qi3+xJqvRD3tA=upVUT_aQ@mail.gmail.com>
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <CAP-5=fU=gO49ASVVLUbT5bFPoOE3qi3+xJqvRD3tA=upVUT_aQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0051.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::13) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|IA1PR12MB7542:EE_
X-MS-Office365-Filtering-Correlation-Id: e8d54fc9-fc8e-41ac-189f-08dc427b822a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cgbsJ9emw/E1i04RnzArkttTFCygLXL/M2zuNkUEq7sJerTYDVZgpL/18zlWZuwvgRuC5xO67KehBd9uOPlNFe0LURvcZB7RHq+uBlLKjSQOtSDnQhQQ6wDxltgjL7UpLPNGPyq2mmfuOyAewo+7fS6QZ26VJq6gRyrDpyUm5ADzqsMFA3zN0G+Ah3GgxOtUeDm+OcYdWeXEEhVLNt15QjkqCB2q0OU5V8OBSTR7UJ02BhTVKhBNphWTo6vWPKeAJYy+GRSKPDJ7QuECVESoyrOOQ/zVXLcA3wT5Co5uT2s6Ob4ZYhCfgx4WDb0r9DVfX37nuIzffyucgsFMhQW0ReMLIk2v2Xi5nXg5k77kA0HlcKUQpbJwr9nPhUmDB6iE57jcE9t6KPE5PsffkfzbNIweQ6M7WtQvZwyUqAUhZtk/dXCDu+6w0jJoFAiUZCH4ir4p4q4g8kcWZkmmdJz46cbkinmK2C3MxjDbCSHDUdHAcZ7yljLEpov4tKqL321yBs3xpWOWfVtYl3t9OEPy/HoaajDt0C/qwhVkptFDKapD1XT8Fq2GN1c/hLPsBOHFSTEd4o99C0Xlgo5FwSUIDNBScZ+8PvrjWHeQkHRGQVw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aG8wSkpVbWRGNlZ2cFNzY2VkajZUcGdZY282MHhqNUE1eSt3MGVobXVTVVJR?=
 =?utf-8?B?RDY4eEVGZWM2OE03aUpLenJlREFDbHhXalNMWHg1TkRNQlNFc1JtQjZUTHhZ?=
 =?utf-8?B?L1RpY3R0UndTN1BHd29id28rTHVyYzdqM0lQMWdZL2JyVFB4SzJ3MnVTeXNO?=
 =?utf-8?B?OXVjYkNPcDB1YmNRc0JBWHVqYWtuWDA4YlFUTC9sRExYSm80WFFTSEltdUZm?=
 =?utf-8?B?ZGlENDZIMExyYk9jNFJqekMzcHg1NmlxVXFLcmd2WFRaNCtuZ0dyWjF0MG9X?=
 =?utf-8?B?NWlDbjRPandpMmIwMkNjTFNIVlVlUFJuQ0Q5VjcrNkRVcU5ZdzMzWnlMV2l4?=
 =?utf-8?B?WmdxMlh6TXNOM2JITFZMYytqSUNIUFk0bkpqam1Vd1lnK2NVV3gwSlVjVWpr?=
 =?utf-8?B?WnZIcnUzSTZ3Y0hUSXJsanRBc29iK2JiQ05xd3drL09wK0tRNEplUU9QRXdM?=
 =?utf-8?B?R01xV0dIakllczR6dnlTazcydkppTG1JSUlIM3VhUEV5SE11azAxRnhKaXp4?=
 =?utf-8?B?ajBSdEpjUFNIamd5ZGtHRWpWMlpFV1VKaHNOUGdOb3BiODdXTHMwcmdLNHUy?=
 =?utf-8?B?ZEZzbVQzbis5QlJYdFYxY1R0Rk4wTXJnWi9oZ281eHQ5WkVnNTFIWEttUENl?=
 =?utf-8?B?aXJVRHlEcCttSzBaWjNCODdUR2tDV21ZS0c4d3daeVBLQWVtNzExUXRtc0Vo?=
 =?utf-8?B?VTAzdmkvVHlkTDNlMERLMnYxZ1B6bktCcnBiV0h4ckw3bWJBZ2xTYnE3RHFw?=
 =?utf-8?B?MTl1RFlBYUs1emhlQzRCZFBEdUFkOW5DK3B1UEZNKy9adExQUE9FZkVPMUE0?=
 =?utf-8?B?bTRJVEdHOEc4MTU4NlFvL2NVZGFHWmJIV1BsS2s1OEFodDd2YkpVTjl0MnQz?=
 =?utf-8?B?TU5qMndwQjZwWDI0dnlhY0pxMXB0ZmVwNzlxQ08rZExXV0N1QjR1dzlreElS?=
 =?utf-8?B?WWdqZnlqNnI3M3BCM05LTHFEUlMvdysrR0pHRkN2VTRDUzB4NlFZNFNxMmxj?=
 =?utf-8?B?SitrTWVDUFZ2SnNoK2RGWHlrc0oya3B5RlZhZFdTb3RVRDlwMEN6Q1hrRXli?=
 =?utf-8?B?aVgwSG03YnlZcXg4TVNSUm5CYXlwWnAzZllQZXhxVTA5MERCQ25Bck02UUNh?=
 =?utf-8?B?QTJidE1JdWJGZjExMktUZ2NJckdlc2ZYZTc2eHk1MzhHQ3E4NTk1a0pMNXUw?=
 =?utf-8?B?WmFrbkRObGdIUmdNRU13dis5SUV2MFNUUjVVbS9ucFhQaHhPcU1OQmVwR002?=
 =?utf-8?B?REVQcU8wTXorc2d6Y21YTytKVklwR2RheG15eVV5UmVHVGI4eVFmY3VNc0RX?=
 =?utf-8?B?eUhhR2RMM0JSZFRFdWpqRmJ4Z3plQTkvRnNLTGRKYjhaNzBxRlJTS1M1UkVk?=
 =?utf-8?B?VG1aMFNrS2VmMW5heWpRVlhRR0o1U0lTd2dOcFNTS0pwYXdvUlNGdm5ySUVN?=
 =?utf-8?B?WUpvNVJRZVlQQm9MY0oyNjhZN3czc1c2WmVCVkg5bll6UG10cmVnZjRuZXNj?=
 =?utf-8?B?QkhDWit2R3gyRmRKQjNiR2grOXhscjJ4QTFvb2wxSFBNYktramhQVExoMjAz?=
 =?utf-8?B?ajNOdUJKVFpZU1Y0eG1pMGxLRmVtUzI2RCt5dnVQb3AwMUZMTThzNnQvQlJN?=
 =?utf-8?B?eWo4a2R4Rk15dG0ya0d4N2ppL2sxSzBZODJ5QmxqRXhWZnBuODYvM1U4TFc1?=
 =?utf-8?B?dTRBWllNekUydmpTcUltN0R1ZzdMMm50aXhja3pBMVNoMTl3b09JWEZKNmhJ?=
 =?utf-8?B?UWNBN3RPWjNIUHdMQkFnWHlOL1JxNXhhLzRxNkw2WTRQMWJXRUZEOWFtSGFT?=
 =?utf-8?B?TFhHcVlVYmdrYk5mS0s4dEZsMFFNQUhrVmZha1VaeWJVUDYySzc3NEpTeCtt?=
 =?utf-8?B?OVp4bkdzVnhHOXhRTC9BMDVXK1BSRzNUZ0FCYVorK3AyRkpyS3RobEpyK2hB?=
 =?utf-8?B?QllOY2x4TUttNVpvR29ydFdQSEhCMEFaaVJCMEFKcnp3SWpFblYvMHQxVzJO?=
 =?utf-8?B?VkliMy9qUml6Z0lmcThGeHFTcFZkY0lvd3Y3R2J5ZTZYc1VJbGZHc3RtVFpS?=
 =?utf-8?B?KzdjcXAyQi85a2FFTmFSd2NxN0lmaGZ5bi9wbUJmYUoxR0J0cmg4TUU0Y212?=
 =?utf-8?Q?NTOiFO3ChYUrAGIMt/ES9LCcY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8d54fc9-fc8e-41ac-189f-08dc427b822a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 10:02:21.5209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UQH5j2docTGRtLuNX62Mpt6NRC1ruS227YQq92m+9XCpKyp5WL/kQn+t7zebJwFAf45xBNkNHJ6WFpHKSj/MPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7542



On 3/11/2024 11:13 PM, Ian Rogers wrote:
> On Sun, Mar 10, 2024 at 10:24 PM Sandipan Das <sandipan.das@amd.com> wrote:
>>
>> Add uncore events taken from Section 1.5 "L3 Cache Performance Monitor
>> Counters" and Section 2 "UMC Performance Monitors" of the Performance
>> Monitor Counters for AMD Family 1Ah Model 00h-0Fh Processors document
>> available at the link below. This constitutes events which capture L3
>> cache and UMC command activity.
> 
> Why do the L3 uncore PMU events go in the same topic as the core/cpu
> events, but the memory controller events not? Could they both go in
> separate files to make better use of the topic?
> 

Sure. I'll move the L3 events to a separate file.

> 
>> Link: https://bugzilla.kernel.org/attachment.cgi?id=305974
>> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
>> ---
>>  .../pmu-events/arch/x86/amdzen5/cache.json    | 175 ++++++++++++++++++
>>  .../arch/x86/amdzen5/memory-controller.json   | 101 ++++++++++
> 
> [ ... snip ... ]


