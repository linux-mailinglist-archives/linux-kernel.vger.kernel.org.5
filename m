Return-Path: <linux-kernel+bounces-149511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D1A8A923A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 07:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 234711C21FA1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 05:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4255427E;
	Thu, 18 Apr 2024 05:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0yrBnoGE"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D2014294
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 05:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713416480; cv=fail; b=ZbJ9IrZsasCU1uCugnmThV4OPtZ2moVL8EBuV73RfezcbnqlpIsEiX0OJ9PKi3rD9Mkdbd2R2t1UnB3MwriH2cLj9JCXzsUMbMIYAt0qQczGPY01Y1POEmTBbe4biEb61bKOaX+cDMR2KzG7YGf9ka5G2vXe/Gfn2PqEzvrkT9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713416480; c=relaxed/simple;
	bh=P1ZgioHy84IEHkzBJLNhOpymLclYeV8pQviqf9yjNqw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rrmSYkRhX9JL3YG5igABVW4XlcIwkH2vZVoc1qz/N4p6u2D9xZiiMh5/DCtbP3WruhCQ7LbFuIhgPnbVs7bB/WPHV4+EgNgVDXr1d3Uiz9C/i/uBf46zsf3U3vP6V4zD6Jq5+nklwA0i3YXFUy8rTFjvZgOAYS4E++g++RGQ+mg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0yrBnoGE; arc=fail smtp.client-ip=40.107.237.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eMSk4/kncPO3zjShVcVuvNIVy6w26OcW6RPtIB2ogkYxsoFZYqKuprTnTp+4ZGZdmPg3510LtGViNKacrjF+y4j/TDH274C0w8NccBJeUWxfdWOPfIvQa9dPFadmU7nQiFQoIwSYT3jskvpQc/GEyw4RhItM58Kj4PtS0uwMbDgZ33RuBE+0sNjpDlvEi3BnmcXY8WRmbpeZT3A3dDhv+04Tlczn/EJjrsfxGvlv7uw3e341hDjgJtzDeczUThHYPSSomTTZdc/X2TrWER5Xu0Q2Z4bqUHhjDBPhawsNW18lUAGfonlpfMKVWHm7bSJVmj3d474ehIHr8WRvBw2ibA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tzh37/RvmsxMZ61hCr6kqp3IgO5s22yul/lm6wZsVQY=;
 b=X+WkbKoMs2A41+qVbRe8ETGPkgVEXuXhMd+Af31dJeUwNNgfJzU1Z4N/Ue25uIrKqdHtIxWABQqxtufr4Kg8ZBZJ4WR6wpJCYlB5kxdsF9T6Fysdes0gq4J7Hpf/gZ087qGyGS3pXS0M4mNuu49xoY2+dCiWn2L6SpDaASQTBFhtelEJCjMI9zxh9crocD7M9HqD0TOUxfiSiRHexmLqL7MNw67nZvknHbiWMnLM38CGpZ5gq3uyHkTjSbzAovJe0aOnBZAuWDDFboTnqiNFXvrRWHHt49VnVos4yVxk8tvqlhjCkF4SzRSA7X2h3MMbUkQAgTLhC0Y16nIlhRq96g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tzh37/RvmsxMZ61hCr6kqp3IgO5s22yul/lm6wZsVQY=;
 b=0yrBnoGE3XBYt77UEBZJQLLSDhCkhAaQEwNuSmoBozJJPhd1qW4spqJwFWIuzlsEZmVm/wdpSNsTyKqEM08aUycvoFSKk27CcJgHlYpDYro0cEm59G60Va8gVa3ozSdhtBAQcc569N27fb6HIZkfMZiOzC0VwleEzE9L3osHZe0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DM4PR12MB7765.namprd12.prod.outlook.com (2603:10b6:8:113::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.39; Thu, 18 Apr 2024 05:01:14 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::af7d:5f4f:2139:ebd1]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::af7d:5f4f:2139:ebd1%4]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 05:01:14 +0000
Message-ID: <597c3e43-2735-40a0-9505-f6be2d0a3b66@amd.com>
Date: Thu, 18 Apr 2024 10:31:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel 6.7 regression doesn't boot if using AMD eGPU
To: Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Eric Wagner <ewagner12@gmail.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <CAHudX3zLH6CsRmLE-yb+gRjhh-v4bU5_1jW_xCcxOo_oUUZKYg@mail.gmail.com>
 <20240415163056.GP223006@ziepe.ca>
 <CAHudX3zhagFWBv4isZzAtC8dA7EAAtY6Yk7fkJ31hf0D9zrNqw@mail.gmail.com>
 <65d4d7e0-4d90-48d7-8e4a-d16800df148a@arm.com>
 <20240416003903.GR223006@ziepe.ca>
 <47d4bfd6-1d76-4bb8-a33c-c9c99b86656b@arm.com>
 <4ec76a54-cb83-40b1-a156-a6da3453da5c@amd.com>
 <bb417978-06b4-4b2c-bcf6-a39601b079be@arm.com>
Content-Language: en-US
From: Vasant Hegde <vashegde@amd.com>
In-Reply-To: <bb417978-06b4-4b2c-bcf6-a39601b079be@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0020.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::16) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DM4PR12MB7765:EE_
X-MS-Office365-Filtering-Correlation-Id: 95375c8a-0a26-4071-6e22-08dc5f6492a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tB4rKQ0S32NA41By92VwuYl6/j5O88Pdi/s7dh6gJ+L5WDHgu449uPNhydggRAnLoK4lneV0jTbecIVnF/nlXpSulLmvsFz4kIShh6cK5FSDio4QIny8xSyygNf4Q9Wv3kdbdoV+Np8c0cvxSWqn7hseFkBT83sSKPCwwZHP9qRTluNNQ46dBHTYV5MysOQmSuTOYdcK+XH7aAGYald9HZZ7FKaHogABo6OOSGpaLzpADnBBlxMXwAMQuzlxt4Ud1UBCa3bHyUkuqLT1/AOBSsz03icFrSfJVRsSWGglkVU9iEMLmG+rMIU8hukVzuz2zkaUz8LqfmirM408WhyC38/kABt+cC81qMMRdpYxFpWCgIAmmTC0YYVCPA7NuhEdJEZ1d7C+6IW6SEpOtU2K+fScgtJeIIfWlXqFVPcXFEnTucc27gLB177DKQqlSsUSS9RanpRV2CQzJ3QU2L09LpxrNqcZco7Iq5NmIkH0V5NAt+6ZslNu6IO4sbdAoR4N9pz/CGoAwR1i+CVKi3BLUnCYZnbjnMlNWQHXFexXQ6JzFO0y8ah6O5C47osmtLQAMCNDc3/syKMWY5m1VM64Axn+C5LGxZ1qF8mryH8NWAhwm6StXd6LQrF70t8rkHzFALTnib4tWvdhGjeIaSzEetOhsjxPLe0tN029w7/hsS8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjExQllhU2M0bTFNZjdXUUdnWllZNWI0VmVLNmlCQm10VExJcFU3TS85ZXVJ?=
 =?utf-8?B?Vjg0RzVPYnNPOG1xN0VSWkdGcmRlRUhna3VuRjZ4UUlOZ01Idnl6bmc3bTFr?=
 =?utf-8?B?OUFoOVc3ZmpFb2hlbzZWNUhqTHB2L0ZIakY0SXBYckllUE9qblpSa2dlUzBR?=
 =?utf-8?B?OERtWCtwZ0tya1RNbm1HTm11MWRCU21La2l0T29NdHM4bzNzdlMwUmJQUVA2?=
 =?utf-8?B?K3NtQnVxUCtrSmxDeGZYUitNRVdQRWNhTFFqdTFTaTlTZWNCc2ZESmxRY3Vt?=
 =?utf-8?B?YUkvRmdNT2pmYUdyd1J5dnl2MWc1emV3blQwR0Vla0E4N1ZxOTRGWjRFakZl?=
 =?utf-8?B?dGVxODRqN1ZCNUFZMEx5NzRua3gyYzZ5V2xuYnFuVlJHYmJTTHJKR1J2a0VB?=
 =?utf-8?B?Y0RVQ2xYZ0dOV1BOZ0FIYW1RN2M5Sk9YOHZoNVBKcEI4L1owTVloTmRvSDI5?=
 =?utf-8?B?Y3RRS200VjUxb3prOWZ1MEY4Y3lYZWdOdi9vTUpUTEhjWHRFSlZ3ZUdTY01u?=
 =?utf-8?B?YjZPNXFKTENibEdIdmgzK0ZrTzBNR0xtdnJLTFVvQzZ0NXl3ZjNleDhFUUR1?=
 =?utf-8?B?R2t6cnhJS003ais5V2lPMjErdU9GazdjRGMrWnpHelhaWS91bVV3TlYwUWNP?=
 =?utf-8?B?RTdWMDZQaFl4TnBBR2cvdHN0VjVmcCtjTTJBcjhaMlZYYnlsMXcxUnZDUmw2?=
 =?utf-8?B?UkE1K0NvTXNCYWVjU2ZFaGl1TGZVd2ZnZ2ZvWVY0d1E3YnpMNnc1aDUwYUUx?=
 =?utf-8?B?UEhSaVVKeVQ1YzlxUjdwK0tjK284WWdQMnpZaktqN2NIYjdUL1o0NTdsQU92?=
 =?utf-8?B?eFhDWHV0emNYbUFLdmM5bjNmVzR2ay9zeGZrMXYyaEFFSDlkaG1ubXlET2pk?=
 =?utf-8?B?QnJqUVl5cGUyUjh6QjJRcitCNmhMeEoxTnVhdWFQY0tOU3BRUDQ1VlE5YnFl?=
 =?utf-8?B?QnJUeitqajM2cVN1V0hjaXJQSDdUcXpLRjl3RVlEcGNxb2d5WS93eElRVHgr?=
 =?utf-8?B?UmdTYlBTZk8xT04reExDVmhkamEzRVlZVkdtampxV1FLTnJtUFl4Z0lyVW52?=
 =?utf-8?B?aWluNG1LWkRDdEZkZE9MQWFhNVYxdmQvczVWdDQ4V1dncGI3STl3RVorSnd4?=
 =?utf-8?B?aDBkalRVSDRVZElUcDRJaG9iSWZiWEU2Qi8zbkRIajlubi9PbnVXK25DV2lp?=
 =?utf-8?B?S1pyY0tSNEtEL1Vtbi9nclFORVhkSnR4N29DQUhVOFlrY2pPSFlNOEhtTURL?=
 =?utf-8?B?cnJlaHljZlIrNFRvcmFxbEdOSHFHZVZTeENKZXoxelZ2citGbXlEN2l5UHgr?=
 =?utf-8?B?MnBqZXcxVnk4WFREcDN5TDVJakV4dmQwbVUrMzgyRGdheC9idWMyeElyU0VY?=
 =?utf-8?B?N0RkYnNoZURGYUw3NXcybi9RMnlVNUF3MytPdjBycVNQQStOZlZoWUVGMXoz?=
 =?utf-8?B?K0dMUnZtd3hZbmhHUzV0OHZSYmN0dk40SXpodkpvci9MZDlVVm5WeHBiRVFE?=
 =?utf-8?B?VTJJb0hPM2NNeDQrc3FWUmRlMmRzMlAxVEh2QUhQM2VYUG4rWlFxZHpIQ05v?=
 =?utf-8?B?b0tvWm1UR0JCdDB5ekMxbHdxNm1ObUI1cUp4cGV2N01OaFN4cDY2L0dIRkhi?=
 =?utf-8?B?TktsR2N6eXpLQ0xETHQ1UUR4S0JyK0o2MmFpNmgrQ0Rqckt5VUNqRGlJOTZY?=
 =?utf-8?B?dkRlVTQ4cWFqcHlIb3psWk5haHMwTUZpVEFzd1dBa1dFMDFIS3RuejlwdW5i?=
 =?utf-8?B?TzFqS0I0dHJKVFpWdzducHVycnoyUjZyVzBQYVk1TGptVHpvNFdKWHVBaFJo?=
 =?utf-8?B?RGkzK0lwZ2Z6b2VZcHhUQjBablcyR2EyOTRYaVc3RjBWK0JuaXJvMlZTZklh?=
 =?utf-8?B?UXRRS0xqWkNIOUsvVVpMc0tNVkQ5U3g4bEM0ak1qcUJRZW9KRFFpam84cVJI?=
 =?utf-8?B?aTd0enlCUEUzMDAxblltRllaYkpVc3BQZjRXKzMyb2xTUEllM0NxNENQTDV4?=
 =?utf-8?B?NmhTZDNPWmZlMFVIVXRPalNZaDNxZHNyeGxjZFAyWDQ4ci94eW1vME1SazNm?=
 =?utf-8?B?UzU5bERlUTNCdmgvekVHcU5GSWNOMmVIbnIyeWFOejhoT2pHVEhLUWc4MHZ4?=
 =?utf-8?Q?8iMzfL8/tZP3IjS5moInAhEwA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95375c8a-0a26-4071-6e22-08dc5f6492a8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 05:01:14.5275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IEt9CXcILSShwPw0KT81TP3FoZGqqoyXe39FQQsMs+YPZABnoSy8/bIJyHOnaiUrLUpSpoXfM7omf+o0lc7XCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7765

Hi Robin,

On 4/17/2024 4:06 PM, Robin Murphy wrote:
> On 2024-04-16 1:44 pm, Vasant Hegde wrote:
>> Robin,
>>
>> On 4/16/2024 4:55 PM, Robin Murphy wrote:
>>> On 2024-04-16 1:39 am, Jason Gunthorpe wrote:
>>>> On Mon, Apr 15, 2024 at 10:44:34PM +0100, Robin Murphy wrote:
>>>>> On 2024-04-15 7:57 pm, Eric Wagner wrote:
>>>>>> Apologies if I made a mistake in the first bisect, I'm new to kernel
>>>>>> debugging.
>>>>>>
>>>>>> I tested cedc811c76778bdef91d405717acee0de54d8db5 (x86/amd) and
>>>>>> 3613047280ec42a4e1350fdc1a6dd161ff4008cc (core) directly and both were good.
>>>>>> Then I ran git bisect again with e8cca466a84a75f8ff2a7a31173c99ee6d1c59d2
>>>>>> as the bad and 6e6c6d6bc6c96c2477ddfea24a121eb5ee12b7a3 as the good and the
>>>>>> bisect log is attached. It ended up at the same commit as before.
>>>>>>
>>>>>> I've also attached a picture of the boot screen that occurs when it hangs.
>>>>>> 0000:05:00.0 is the PCIe bus address of the RX 580 eGPU that's causing the
>>>>>> problem.
>>
>> .../...
>>
>>>
>>> "Failing" iommu_probe_device is merely how we tell ourselves that we're not
>>> interested in a device, and consequently tell the rest of the kernel it
>>> doesn't have an IOMMU (via device_iommu_mapped() returning false). This is
>>> normal and expected for devices which legitimately have no IOMMU in the first
>>> place; conversely we don't do a great deal for unexpected failures since
>>> those typically represent system-fatal conditions whatever we might try to
>>> do. We've never had much of a notion of expected failures when an IOMMU *is*
>>> present, but even then, denying any trace of the IOMMU and removing ourselves
>>> from the picture is clearly not the ideal way to approach that. We're running
>>> off a bus notifier (or even later), so ultimately our return value is
>>> meaningless; at that point the device already exists and has been added to
>>> its bus, we can't undo that.
>>>
>>> However it looks to be even more fun if failure occurs in *deferred* default
>>> domain creation via bus_iommu_probe(), since then we give up and dismiss the
>>> entire IOMMU. Except the x86 drivers ignore the return from
>>> iommu_device_register(), so further hilarity ensues...
>>>
>>> I think I've now satisfied myself that a simple fix for the core code is
>>> appropriate and will write that up now; one other thing I couldn't quite
>>> figure out is whether the AMD driver somehow prevents PASIDs being used while
>>> the group is attached to a non-identity (and non-nested) domain - that's
>>> probably one for Vasant to confirm.
>>
>> AMD driver supports PASID with below domain type :
>>    - Identity domain
>>    - DMA translation mode (DMA and DMA_FQ) with AMD v2 page table
>> (amd_iommu=pgtbl_v2).
>>
>>
>> Currently amd_iommu_def_domain_type() tries to put PASID capable devices in
>> identity domain mode. This is something to fix. Its in my TODO list. I will
>> try to get into it soon.
>>
>> Hope this clarifies.
> 
> Ooh, I see you now have GIoV to allow that similarly to how SMMUv3 does it -
> that wasn't in the older version of the spec that I've previously been referring
> to :)

Right. This got added later.

> 
> Can you confirm there's no hardware actually been made to the older spec,
> supporting v2 and PASIDs but *not* having GIoV? Otherwise, I think you'll still
> have the problem that if you use the GPA-SPA translation in the DTE to implement
> IOMMU_DOMAIN_DMA for the RID, it makes all the PASID GVA-GPA mappings useless
> for host SVA.

I believe we did made HW with old spec. Fortunately we have sufficient feature
bit to detect those feature support. I will have to carefully tweak the
amd_iommu_def_domain_type().

-Vasant

