Return-Path: <linux-kernel+bounces-65374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48905854C0D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DB8A1C272C0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B41E5B66B;
	Wed, 14 Feb 2024 15:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="saW+8PLI"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2042.outbound.protection.outlook.com [40.107.212.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CC65B671
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 15:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707922878; cv=fail; b=mOx+dSUDhBuLgtc+UjqW648++8ZGIdSe7eAs9G/Az1zg44zFWdkbrKGE8AU1lN+xs+IMx71OwroQgUuWnPGcFd7shCACWpGV1MXsSyTXHOCHO4CokE5nSUtMeXFhtUuBsijMk5B9pBzEFAGZplBJiTB6ts+L7HOmJ5Wx+ytIsI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707922878; c=relaxed/simple;
	bh=p39fgKxLz+UBeNVPF3uH6ioLiaJ7LUoOMHEXnFDxsfk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FWt7tYFMKxwB9ObaeWk8Ob7UwB2jD+Dfra1+MJb2AQqc4rTZhmRwaAiLoczcdbuDwe1UKQm5Toyco461tvJQihsNuntxG+ciBFARWO2bXIHUGzKM415H5yoQfOWv+5T2gG4iBQsqJTMbZOe9w2/1AYS1WljlfU4sVwjL8PcFAbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=saW+8PLI; arc=fail smtp.client-ip=40.107.212.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TKzJi8ZPqR1/tDqALRdHn1GZuWIYL8MKZ5BvFCPaIq643HYS5ZUNblmdEJgYSEek82HpbiEciy2SJOigXdEd437latdvh/DXkUSz8Geou7tGMlIBi3Z25vlKS9UR3UP7upfC5m3KwSMUrVCD2SXtJSXjLhREdEVAyeVpy2BgQmvwXk4Xu/FCBenToBAGGb/XSTJHPgFbeuG8nrSY7AQZOvZc/tnxEVhL5JezO3uRecW43HlLRpiIPiSDa8BXIoMXX2LL61TNI1BCgvZCiY4iMblvTesHPTWTYX0dLelmcfj/An7f4Mn5ubrESyPhFnPMt4+ZzS5vDqGfKvBq5nil/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AcxMam7BYR4ABbZDO26OO/lOKftKgktCIa/bxgiBJoQ=;
 b=PrFEq+Yd2pkwTLw+P0puH0qOAi8mF/XbIFuatBm57Sll+aslU5BdG66IzBY7cvkZgQmwsLcDGW9EgKEsiOnX0uJfl6Bwu49G1BhDEi+itGUzuWtqBjHEP5eOhkIN4MR/UX7khS5ggWeQMeI87KufJk3szIIIbz5+fL26L5cKgZexFjMODVtKZKHtMOGynh9hf+oA9OZqOL2aNS4Uhhbmlvb7CPFhpJTeWfi4m3uUpvZ89Lz5BBr5kRtDWSIdOvsgeddOmBKEZMVW7A3mDOUXkDDuJy5AhdgzVpLrxq+HrIe3O8s5G7iouuK3aanD9l2cjphNp2euCMxWEbzEAh0NJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AcxMam7BYR4ABbZDO26OO/lOKftKgktCIa/bxgiBJoQ=;
 b=saW+8PLIcpgaycwHqsaZ3kJYmEwZwFe6lJ5koh8iBi410adxv4N/nlzTapIzz8beRJcozXtfDBdyIQQb9MqlRX//US4L16dxEN7YDitnp+/AXOLosc1Gi4OfGQ97ZR9ViQAut37OlGXMOWNmnsqAGZG4HLmRw5qHYbyoe0X+ENU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM4PR12MB5357.namprd12.prod.outlook.com (2603:10b6:5:39b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.28; Wed, 14 Feb
 2024 15:01:12 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::ee3b:5116:72be:be7a]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::ee3b:5116:72be:be7a%4]) with mapi id 15.20.7292.022; Wed, 14 Feb 2024
 15:01:12 +0000
Message-ID: <68983917-3f99-424e-8181-fbfae105dea6@amd.com>
Date: Wed, 14 Feb 2024 09:01:08 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v9 00/24] x86/resctrl: monitored closid+rmid together,
 separate arch/fs locking
Content-Language: en-US
To: James Morse <james.morse@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>
References: <20240213184438.16675-1-james.morse@arm.com>
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <20240213184438.16675-1-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR08CA0046.namprd08.prod.outlook.com
 (2603:10b6:5:1e0::20) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM4PR12MB5357:EE_
X-MS-Office365-Filtering-Correlation-Id: a893e17d-f1c0-47bd-748b-08dc2d6dc8c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OwGvPrgmYX3w1tkGOBq5PJtgy+9ICN5bYxbu1ygfXbeo3Uxu0X39lzp1zunoR/32xhnQYu9R7DuKX4mg28ApATj71YSYqReAalNoTLzivpnhnwd40moqOJhq8V4fQkdyr/SWewZ6EIZx4ZQjwvsRXkkY/2BwK9D6wdJNipv3dXndu5kvV20CdZKEXT2Hr0HQxySfMoefdofpal3y1NXVWUNSIq6/+lryIWpMUL+Y9Yr3fkRxg7LbfEbfxmMelqXy2pYhSO8lK1XWqRPx153Hdzg3eDxWqkzZyyKfbbE7z2IVMhj/vV2EJJbydxnOomJ1NzQasoaNAySkyt0iwm3Yw/7Mjna2IbxrWJ9rhpSMWEU9L16lhnsWba7eGQpfKWrRV+1UGKIcJrPwQRiX2BsI4F7ssofiEORuQ9vIWdtNpNHTJQuKJiKAiyyD5swY1DbpmPPx//eY1KzEptRB8grzvbTW9+olUibtlvX3Crn/GHsCZbRg7Kph47105CbgALjvfumBN9QI6OtRIXRt9e+wpDPmTq7vL/k28RZdfpDI6pPPOEu7dwC4fDoFJjfaheaA1dZ9Xi7sRGqbGW/lof/+QQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(366004)(376002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(31696002)(86362001)(31686004)(66556008)(8676002)(8936002)(5660300002)(66946007)(66476007)(66899024)(7416002)(4326008)(6512007)(6506007)(478600001)(6486002)(966005)(2906002)(3450700001)(83380400001)(26005)(2616005)(41300700001)(38100700002)(36756003)(316002)(6666004)(53546011)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R3FLR0JIR2g5eGd3QjR4NW1yS1ZpQ0RFYzh2UFFabWt2UERYc1NGVk41bGFz?=
 =?utf-8?B?ckxkNEx2WUxyV05QeEg4L0ZIQldQOVRya0htY1VjZlV5ZWNtOUxOVXIwT0R2?=
 =?utf-8?B?SmZzMkhlQjErT0dqKzJUUUtQQlZHVnduMTk5aUVMOGQvTXFTRS9hWW1aQVFl?=
 =?utf-8?B?b3VIS1dGU3JHUEY4SXNTck1OZnBXSmxac2lDOTVhQ0lMV0M2RXYyRlZlVDNo?=
 =?utf-8?B?THVXekZYS2s0ZmVvczNoRHdyeGlMU0cyZzBzaENzNUE5YndNQVVBMHF3eWxp?=
 =?utf-8?B?UmgzN0kzRGQ2N2pOQkhsb3g4TmUzRllFS2d1MEFIQ09uTU11ZGt5QlFFdXRZ?=
 =?utf-8?B?bjhVK2gweWRsaFNPVzMxalFHSXdYL1NpeHZidkVyVlZnalZRMDEzaVpJUnpB?=
 =?utf-8?B?NTVKNWo3U1MrK2NRZTdMNXJTYlJRY3V5TGJWa1JOOUx1SlJKU0dvSW52bHNu?=
 =?utf-8?B?M1MrZTFEYTlUajRXREtvWURNaU1OZEt3K0ZMWjlsR0YyZnFRbVNRSVpUdlFt?=
 =?utf-8?B?Y2RMN1psVTF3QmMwaVk1U01LYmd3SHdqRzhnMkVaRWNnOEpJL0FPbnZvbE42?=
 =?utf-8?B?aVErNFdYUlJwK3ZoZllsMEZMaHVhUldBQXB5S2hTbnZYUjFwOWxEcmZVSTMr?=
 =?utf-8?B?TFFOSHFqbEVQMCtaL0UwQzJjN0RlSHl5RFhPSHdTVHo4YnZIOU5sNHpTdm5R?=
 =?utf-8?B?SGF5V21FN0xZZkN3WnlHdTZCSFhLOUZSUCtROVNnblJMdzlpQkhPSHNkQVYy?=
 =?utf-8?B?MkUrcmIydEVUSGVJWVZTbnh4MUxLMFZ1VmZSeEZGSGxYSjcwWm1RbVNJbUYw?=
 =?utf-8?B?Qzl0VEt4L3ptY1Fuc0ViZFVZMzMwRW9aMEgxUzZHWDFJVlRoa1FZMEY5RnhY?=
 =?utf-8?B?S1dtZ0Y0NHIxSXR2cTVONU1FemZLYWN1bzVISXFkMEZ2azFzemxCRzVhNHM1?=
 =?utf-8?B?WUlpUmFDdEJQaGxacXNkQXdKSzV0YW1lNER0OFJoZWVaR25HZGhwR01IY1lT?=
 =?utf-8?B?OGRyb2RwbnNYbWc2Ym1yTW5aNVNqaGtBcmRnUnNUaFZyQ0lXNW9JTWNsSHBF?=
 =?utf-8?B?QzlXOHhXVmFEd1B5eXN0cjRicm10OFdlWkZNK3RCeE5ISDB0bjk3d083MU1I?=
 =?utf-8?B?bVQrL1RhUjhhdDJpUTlsMms5N25ObkpweTBDejY5OGExRFRJeVVVdEdNSVh0?=
 =?utf-8?B?OGNoUFBORDFBcXdmeXdldDIwN01LZjI1V2pqcjhxSEROemZ2OEpTbEFlU0JX?=
 =?utf-8?B?OTVYUmU2TFl5ODE3QldBWmF5RmxubWR6dmhrSWdPbU51U2xmNmEwVmdHbnJQ?=
 =?utf-8?B?TFo0akk5OHArL2NkckkrcGtrTWlhaG82U0lYWE4rNnZHcXYxM3dLZ1FpNCsr?=
 =?utf-8?B?b1ZPdkl0ak5TUHlHblI3UWdEa3dBMDAyTTQxYWErN3VwRkZFdnAzeWVMdmpO?=
 =?utf-8?B?YTdIeXFZQ09PMitjd09OSnRlRlNqR1JGQUV4RjVJZWhmYy82UllYbThwV3Bq?=
 =?utf-8?B?R1E5cnVtNVJzem9OOGdlb1QvbHU1OGc4UTNvTVJuQjgyQlVGMDlPWW9YRDY2?=
 =?utf-8?B?Zm41SFdFQzFXU24wQjdpWWtvcXlLTXNwUmE5aGlEaXF4N3pKY1pjaFVHNFZG?=
 =?utf-8?B?RHozdzJ2TSsrbGlPTHQzS3VPQk0vOWJlNW5aWTFkTnZxT2RVNlhzWWQzUHpt?=
 =?utf-8?B?NGNpdWk0Vkc5TThMVVIzRkNZbGRXdU1MNi9Ra0g5dHVoSjBqZ2JwN0k2bWpP?=
 =?utf-8?B?T2NsSWtkUEdvajFaMDMxWFBZYmZZeCtJODhzSkREWTB5ODcvUlRBb0pkZzVK?=
 =?utf-8?B?TWkxclBMMnZyRElwbGtHVGlsWDJDeGRhRzc2TTZ3K3hmcUY5OUgvYlFuTU1I?=
 =?utf-8?B?OFNwa0NhaW1oSEZXNzk5TDFSczJZc3ZlZU00d0h4NmlZN2JmS0xRQXpjYlgw?=
 =?utf-8?B?SHpnNVZUblU5cXZMcDk2Q0ZmV0s1TlFDRjdFVHk3OVNKVVEva0hTOGhpODdT?=
 =?utf-8?B?NnZDbExkcDNralF3TElCbTdIcTZKZzNzRVQ5Skp2RStLQlJKd3N6ZmE4T2lF?=
 =?utf-8?B?QkdpNXBYMVNaN2JCZGtCVGpFM1I1V0NUZmd3dzlpYjZ5Nm1hdGhXcjNnTSt5?=
 =?utf-8?Q?C5Ak=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a893e17d-f1c0-47bd-748b-08dc2d6dc8c9
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 15:01:12.4651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A+bt0XzCnPTKx2N0rHaBxCxPBh06tJWMN30iNwT2sVfYHXYWLvTdDpjzQQwf5Fkk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5357

Sanity tested the series again on AMD system. Everything looks good.

Tested-by: Babu Moger <babu.moger@amd.com>

On 2/13/24 12:44, James Morse wrote:
> Hello!
> 
> It's been back and forth for whether this series should be rebased onto Tony's
> SNC series. This version isn't, its based on tip/x86/cache.
> (I have the rebased-and-tested versions if anyone needs them)
> 
> This version just has minor cleanup from the previous one.
> * An unusued parameter in unused code has gone,
> * I've added a comment about the sizeing of the index array - it only matters on arm64.
> 
> Changes are also noted on each patch.
> 
> ~
> 
> This series does two things, it changes resctrl to call resctrl_arch_rmid_read()
> in a way that works for MPAM, and it separates the locking so that the arch code
> and filesystem code don't have to share a mutex. I tried to split this as two
> series, but these touch similar call sites, so it would create more work.
> 
> (What's MPAM? See the cover letter of the first series. [1])
> 
> On x86 the RMID is an independent number. MPAMs equivalent is PMG, but this
> isn't an independent number - it extends the PARTID (same as CLOSID) space
> with bits that aren't used to select the configuration. The monitors can
> then be told to match specific PMG values, allowing monitor-groups to be
> created.
> 
> But, MPAM expects the monitors to always monitor by PARTID. The
> Cache-storage-utilisation counters can only work this way.
> (In the MPAM spec not setting the MATCH_PARTID bit is made CONSTRAINED
> UNPREDICTABLE - which is Arm's term to mean portable software can't rely on
> this)
> 
> It gets worse, as some SoCs may have very few PMG bits. I've seen the
> datasheet for one that has a single bit of PMG space.
> 
> To be usable, MPAM's counters always need the PARTID and the PMG.
> For resctrl, this means always making the CLOSID available when the RMID
> is used.
> 
> To ensure RMID are always unique, this series combines the CLOSID and RMID
> into an index, and manages RMID based on that. For x86, the index and RMID
> would always be the same.
> 
> 
> Currently the architecture specific code in the cpuhp callbacks takes the
> rdtgroup_mutex. This means the filesystem code would have to export this
> lock, resulting in an ill-defined interface between the two, and the possibility
> of cross-architecture lock-ordering head aches.
> 
> The second part of this series adds a domain_list_lock to protect writes to the
> domain list, and protects the domain list with RCU - or cpus_read_lock().
> 
> Use of RCU is to allow lockless readers of the domain list. To get MPAMs monitors
> working, its very likely they'll need to be plumbed up to perf. An uncore PMU
> driver would need to be a lockless reader of the domain list.
> 
> This series is based on tip/x86/caches's commit fc747eebef73, and can be retrieved from:
> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/monitors_and_locking/v9
> 
> Bugs welcome,
> 
> Thanks,
> 
> James
> 
> [1] https://lore.kernel.org/lkml/20210728170637.25610-1-james.morse@arm.com/
> [v1] https://lore.kernel.org/all/20221021131204.5581-1-james.morse@arm.com/
> [v2] https://lore.kernel.org/lkml/20230113175459.14825-1-james.morse@arm.com/
> [v3] https://lore.kernel.org/r/20230320172620.18254-1-james.morse@arm.com 
> [v4] https://lore.kernel.org/r/20230525180209.19497-1-james.morse@arm.com
> [v5] https://lore.kernel.org/lkml/20230728164254.27562-1-james.morse@arm.com/
> [v6] https://lore.kernel.org/all/20230914172138.11977-1-james.morse@arm.com/
> [v7] https://lore.kernel.org/r/20231025180345.28061-1-james.morse@arm.com/
> [v8] https://lore.kernel.org/lkml/20231215174343.13872-1-james.morse@arm.com/
> 
> James Morse (24):
>   tick/nohz: Move tick_nohz_full_mask declaration outside the #ifdef
>   x86/resctrl: kfree() rmid_ptrs from resctrl_exit()
>   x86/resctrl: Create helper for RMID allocation and mondata dir
>     creation
>   x86/resctrl: Move rmid allocation out of mkdir_rdt_prepare()
>   x86/resctrl: Track the closid with the rmid
>   x86/resctrl: Access per-rmid structures by index
>   x86/resctrl: Allow RMID allocation to be scoped by CLOSID
>   x86/resctrl: Track the number of dirty RMID a CLOSID has
>   x86/resctrl: Use __set_bit()/__clear_bit() instead of open coding
>   x86/resctrl: Allocate the cleanest CLOSID by searching
>     closid_num_dirty_rmid
>   x86/resctrl: Move CLOSID/RMID matching and setting to use helpers
>   x86/resctrl: Add cpumask_any_housekeeping() for limbo/overflow
>   x86/resctrl: Queue mon_event_read() instead of sending an IPI
>   x86/resctrl: Allow resctrl_arch_rmid_read() to sleep
>   x86/resctrl: Allow arch to allocate memory needed in
>     resctrl_arch_rmid_read()
>   x86/resctrl: Make resctrl_mounted checks explicit
>   x86/resctrl: Move alloc/mon static keys into helpers
>   x86/resctrl: Make rdt_enable_key the arch's decision to switch
>   x86/resctrl: Add helpers for system wide mon/alloc capable
>   x86/resctrl: Add CPU online callback for resctrl work
>   x86/resctrl: Allow overflow/limbo handlers to be scheduled on any-but
>     cpu
>   x86/resctrl: Add CPU offline callback for resctrl work
>   x86/resctrl: Move domain helper migration into resctrl_offline_cpu()
>   x86/resctrl: Separate arch and fs resctrl locks
> 
>  arch/x86/include/asm/resctrl.h            |  90 +++++
>  arch/x86/kernel/cpu/resctrl/core.c        | 102 ++---
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  48 ++-
>  arch/x86/kernel/cpu/resctrl/internal.h    |  67 +++-
>  arch/x86/kernel/cpu/resctrl/monitor.c     | 463 +++++++++++++++++-----
>  arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  15 +-
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 359 ++++++++++++-----
>  include/linux/resctrl.h                   |  48 ++-
>  include/linux/tick.h                      |   9 +-
>  9 files changed, 921 insertions(+), 280 deletions(-)
> 

-- 
Thanks
Babu Moger

