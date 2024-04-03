Return-Path: <linux-kernel+bounces-130606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60036897A66
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 23:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15ABC282C4D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A74D156656;
	Wed,  3 Apr 2024 21:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iA5u8nYr"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2128.outbound.protection.outlook.com [40.107.220.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9331015099C;
	Wed,  3 Apr 2024 21:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712178521; cv=fail; b=cTcAUuHQptDvAWf+kL4yaEKJoWdKnwed/eN8ULfuCjWCWIYGMbVIH4MLGgQ6c9pfvnR9nDci+rIwZt4c/cMnYzQZECswGSCjam135jplOlfCG7IXEmUL6t5zquqPrrsQLZGo/kIvp6IF2FSmaEZJTqGxYp7PEZWa1uP5G8XFkSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712178521; c=relaxed/simple;
	bh=9jkQj25ZaKWAG9t+y+P7sYKw3d6E2pLWMZgdEvTDNYU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OTv9Tuf9CPZ//8vtJB8FgL+U2hBAKroYVYPcrcSPyXW4P/iAEkk/mK/qWA8Med3ihoAsMp6YvvMCridC3A5/JBOEtN4nMuyv6/OlkT7u2SOdu8V5UzMA5EWpDMRkH0+7HCaHXFStD6oKqmO3mKSeNEr5+j9KFEmK4TIYo4yqkv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iA5u8nYr; arc=fail smtp.client-ip=40.107.220.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nhyc5d4mI7zjpqAx8AbzjCVjWQfd5wGUCAy8pR76zjWXoa0LbQ5PZxg5mvceSJkRJ6rVI3MHBQ7bSt3SeCgRi8ubIkHiUIWApjJLHlAgDTnUpVObJSMOU52Dm+x1qqvmGYkVMn/bvCksoHdOrvbGU/9KT1jutxkw577y5rQHu4b4rL+PVx8KXo2ie3i+DHrqJR1cJFpYxX1bVgsRvb+3ImLdWKweEICiosCNooA6Y1F5gJG9eVT8xh+dVb+OOoBn0KJ3x86uCPyc8lsjXseO9UQKfF2Q/tP+QBkP+6i5pLwSp+Ayo5WqsM/rrSy9KqAtieVqXK2gtQSSGlt+nhj4dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nth3Tjqvw5pSoS8uOLh5VqRL918vDO2LX3dR/4caJbk=;
 b=Wyo3a0afMmIffOSou1RGQdJ8eD0VS6ibez3ZeWBt2r+TsFCy7e2kGzqxzFEJrVajL/LSweIlggZEImUMy1Y/Q88NkS2z4FbgY0n0rNGHcjkNsnXsbrxuvvYBwX2unztQFBFrC89UDfyGsdxCIZMDWaZNlQU2N4H2oNa5ZmWqC8SI22rcQheAVQ/MLO0vjJp1ZFOxm+HXytH/34azun21vHKRIQD22LSM/yzc9TDmQ85Ib5XO+YMzp693pa8yx1F7+dIaZFfVpo3b2ImR/1sW1FzL7c8guttiSySUlgZBJeJeOFam05MegWPyHZt1Vf63WtW21l3T+p7eTmVzWr5A2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nth3Tjqvw5pSoS8uOLh5VqRL918vDO2LX3dR/4caJbk=;
 b=iA5u8nYrIq1IFcscKEntuRKSz9xpvLVZ1i62L+G7H05NdOaMqpVfwmEOv2mIFNMa3oP2D5qSzGGeQ3M8khs84Jfvz7pYJ8zWFE3gqIygvrlWMNG1d2g/xmBBKTxtn1KlVCJzASib6B9N5FkzVbbt00tY1oAVwy4G1gfJmH1GHMI=
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by PH7PR12MB5653.namprd12.prod.outlook.com (2603:10b6:510:132::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 21:08:37 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::3cc5:f552:44ae:1f26]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::3cc5:f552:44ae:1f26%7]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 21:08:37 +0000
Message-ID: <ff810b13-b534-4e4f-a2e2-3cdf2b563494@amd.com>
Date: Wed, 3 Apr 2024 16:08:35 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/sev: Apply RMP table fixups for kexec.
Content-Language: en-US
To: Michael Roth <michael.roth@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 linux-tip-commits@vger.kernel.org, bp@alien8.de, x86@kernel.org,
 linux-kernel@vger.kernel.org
References: <20240312184757.52699-1-Ashish.Kalra@amd.com>
 <b1822884-cba3-4009-d685-81a36dbb4353@amd.com>
 <b2da0a15-c0f5-49a7-b34c-eb408e9aa293@amd.com>
 <20240402224222.vxaqenqvyi32zleb@amd.com>
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <20240402224222.vxaqenqvyi32zleb@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR08CA0029.namprd08.prod.outlook.com
 (2603:10b6:805:66::42) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|PH7PR12MB5653:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wgZfP5mt5CESf/mQOb2zFCenOHs71kC6T2jJz7VOAp9UPvMto+5O8EXIRT6Q4Q2ylFNrJwnqZ9xLdtNqjq9kN6OaQcl2nrjectVjJ+vCbGAgMDUKi9IM/GRngk03J3SYt7Wxk68Nm2bXZqcCHi5kiMnJdzLcXYyZNMM/KSoBgWZAhC9KWQy6YPHlwsTFiXDg9lGM/JWkAItk730EFGUF+NuQhYGb+mAMVQKygfo6qyfuySCLB4qWrIUqGhQV4QQPqryytGZjvoycQgVQ8m8AZHYgZRaTi1fAHGKvJWj5ITkUKA6X+7zo+9GDUygKgnAQtYWzz/ctX2PsatRN6KoaERtqbuZZ3dbvs/GMiqJlaFTGqLDgE9izETMrZDWEikSXpnHoK0M8TykVk///ARpggD4njVOXCZBrJc4bLGpRNbbfxuUDBt9vhckM3IZ0Ii7fmsBoUPy+xoXX3AHE/QpH3nk92QBRWtPKrjy+UXF2ObG9gM+Qbo1FFmjUZMtUf+jVgmvHXD4zYDohF3PnAJf0JidTrKl1nshoNWLS0/ni5vhMOlPwrsaJNSfQ/P3wQvGm0JlF4CzJawskUP9XLruMWUx/WcKn2U0PV4pqjirszS+/VDfZXWy+oLq5VLLP3j5a2aeRky4gCeYlc7mwr1d2J+bc4iBfk/b3fDK1lWPEP6I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWFBY2dPdUxaL0ZGZ0xFcEg3WWFlMENjdGFPZ05aWnQ3MTBXVWNyMFd3RC8r?=
 =?utf-8?B?a09vZFFLWmc1eGUyS2U0ZnRlcW5TbUtpdUxpaVhrNlk2MGQzSGx6N0M0eHZP?=
 =?utf-8?B?UloxdWd1SFI2NEFrRnFFL0hnZXBqT2pHdms3R2hrRGVDRnZDQ2NjM3VYRkVw?=
 =?utf-8?B?dXFWTzhPZTNZN2l0STNnNVpUUWk2QmxoQi9SY2VoT1c3VjFBWVBwK0h6Y0lw?=
 =?utf-8?B?R2QvNXVtVHpDRVhZTmMvY3piejhiU3FoSEU3MHBXRFRyRG9uYmZEZ21RUFoy?=
 =?utf-8?B?MW9IU2RhbjFScktvMml6M0c2czNjQjBwdmVhKzhEdkpSSDJPK1dtSFZNMmpS?=
 =?utf-8?B?b2FtYXB2M0RHTWwwdVlXZVZQeWQwem1sclA0WG44dEIyOUtycHFacHRyRk8r?=
 =?utf-8?B?OS9KNUV0dy9qclliOThZNFNENm5QbTNUVnhwTzFvakFuckxRRFlQcGlIWGFw?=
 =?utf-8?B?UXU2N2FHZTN2WmVYMEI5K2F0aDM3RUd6OG5iOFY1NjZwS3BLNzNRbEMxQVBW?=
 =?utf-8?B?b1M5R0NnZGh4dGNWL0lJcnpZclFoZ1UxWnZqRXZqTHg1c0t2b0dtQmsvaEFl?=
 =?utf-8?B?blNHRW5VL1RSejNiQzdNbVdpSlpVaW9ZakJYWEg0TGI2Q1ExUnNYUG1UZ0kz?=
 =?utf-8?B?MmI0eFN0UEEwYWxCNzRMbVA0ZmViWlU4MGZnYUZRcmpmcVJ6bFVvNnIxUlo5?=
 =?utf-8?B?REZseVAvODE4YzROazlhQTYrS3oxcWhhS1Q0RUxXZFZiT0QwR25rd0xob2px?=
 =?utf-8?B?cjhibkxWUVI5UHdqTTc0a3R1OUMwQWF1SjFtMS9YemZFTVZZamxhTmlzOUd5?=
 =?utf-8?B?c24xVG9ZdmlGQXZLTHp6SjBiZmFUZlpCRU9uZjdEWjNzc0gvMDV6SVhaa2d0?=
 =?utf-8?B?NEZGVmd6T2V5RDBwR2x1ZTk0QlFJQnF2bTVuSUNpUWUzSWxQU2VxOHdmQ2p1?=
 =?utf-8?B?SFFkaEtwWjgxc0ZTcy9BWVZzWlNWSTI2NHBKemp2c3NMcU5wQzhzYnlJdCtS?=
 =?utf-8?B?NzE4NkF4QXB1QnZDQWJIN0VXQ3Rqc1E3cS83UGhQNkxtSzU1VjdqenZ3NkFL?=
 =?utf-8?B?THhUU25kMnl0bXlWWlRUc1B3Z0ZyWnZYVTRBTWpxenFUUFBrU2pkcVNSZktZ?=
 =?utf-8?B?STdOTUJGaW1JbkdGdk9wbWVnbXJFYlV2aHlMZjk0bm96Sk5yTXJQQm9CQVRT?=
 =?utf-8?B?N1ZDRHlVWVNMNWdYR3FzR2JDRmZldEFYd0JZcWdWVGFsbW5SdjdyTzk4QWxD?=
 =?utf-8?B?Y2hvZ3FocnVjYTdCVklvczIraXBuZVVjSDRNWUx4UjdURG1WL0tmaERLNWpi?=
 =?utf-8?B?STBhVGxUalRXeDc0NzA2U2l4WVVCb0tpZXNqcjZwQXFRUVpDVHR6bHlISlVQ?=
 =?utf-8?B?UDVGYVI5cGxkNmszRjdvNU1wd1FuZWN4N2p4ajBwUmdMSEdlaGFsNjkvcGlx?=
 =?utf-8?B?ZjB6K21rOTZ5VUhiN3BMRXNHNE41ejlPNzRMNnlxay9heS8wYkNicFlsMUZz?=
 =?utf-8?B?VlYraTBha3FqMXVWL0V0ZnZaSHROL2llMmpwNCtoaGhBYjcybWZBSERnMU9w?=
 =?utf-8?B?bVk1MVdyV3dqbFRpL0kvRVhnTm1BU0VmdkNkMU5FaW15MUdpdXZ6SGFpbHFL?=
 =?utf-8?B?UVk2YVMxN2VLNUd1dmFBU2RWMElBSjg5QnU1WlV2ZGl4V1hTckVNNDl2ODMw?=
 =?utf-8?B?MzdmS1ZUNTlLZjd2bHo5YndVWUswU3FGQjBoZENLQUZlaTI5elFyMFRvbnRG?=
 =?utf-8?B?bkZrQUxzSkFuR256K1JyclFOOUE3NHpjbFZ4YmxYSzRueC9mZTBMNXpRRFl2?=
 =?utf-8?B?Y3p6M2RFN0duRkNwd25HaytqaUw1M1kranVYcHJSTERpYTUrejlXZHJxRnJG?=
 =?utf-8?B?T1c3MlEwUDEyTFNsUWFoTlRaTDlzbnhGcmxVUWV0cDlQb1Fqa2g2UXdmeXJ3?=
 =?utf-8?B?Q09TK3Fsbnl0amxwOHU3b3Jqc3ZDMkk2dGk2YmZ2SVJHTUlhTHkvZDVBSzJD?=
 =?utf-8?B?Wll0L1VsWE9UZWlGc2NsZWZ4dWR1SzJrd3BwM3lOMGc1VmI3dU00TjdyZTZq?=
 =?utf-8?B?SFYxT1Z4NGNFMzQxLzV2dmhYQXBFd2hGaDNvUy9POENqV0Uwa2hiS3RWNXhr?=
 =?utf-8?Q?SYdW4bkoDfryX4F/cjT364ATl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a92ca992-dae9-4c83-265e-08dc54223a9b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 21:08:37.0599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qoHdY3q5cPoHZck7KwvAqpwqJTbjcQ2EnkOsDGwqyZXg3Jctp5xK/wiSaBfnFbgDgyU2jwaWtY22Q/K9yofc+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5653


On 4/2/2024 5:42 PM, Michael Roth wrote:
> On Tue, Apr 02, 2024 at 05:31:09PM -0500, Kalra, Ashish wrote:
>> On 4/2/2024 5:09 PM, Tom Lendacky wrote:
>>> On 3/12/24 13:47, Ashish Kalra wrote:
>>>> From: Ashish Kalra <ashish.kalra@amd.com>
>>>>
>>>> RMP table start and end physical range may not be aligned to 2MB in
>>>> the e820 tables causing fatal RMP page faults during kexec boot when
>>>> new page allocations are done in the same 2MB page as the RMP table.
>>>> Check if RMP table start and end physical range in e820_table is not
>>>> aligned to 2MB and in that case use e820__range_update() to map this
>>>> range to reserved.
>>>>
>>>> Override e820__memory_setup_default() to check and apply these RMP table
>>>> fixups in e820_table before e820_table is used to setup
>>>> e280_table_firmware and e820_table_kexec.
>>>>
>>>> Fixes: c3b86e61b756 ("x86/cpufeatures: Enable/unmask SEV-SNP CPU
>>>> feature")
>>>> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
>>>> ---
>>>>    arch/x86/virt/svm/sev.c | 52 +++++++++++++++++++++++++++++++++++++++++
>>>>    1 file changed, 52 insertions(+)
>>>>
>>>> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
>>>> index cffe1157a90a..e0d7584df28f 100644
>>>> --- a/arch/x86/virt/svm/sev.c
>>>> +++ b/arch/x86/virt/svm/sev.c
>>>> @@ -65,6 +65,8 @@ static u64 probed_rmp_base, probed_rmp_size;
>>>>    static struct rmpentry *rmptable __ro_after_init;
>>>>    static u64 rmptable_max_pfn __ro_after_init;
>>>>    +static char *__init snp_rmptable_e820_fixup(void);
>>>> +
>>>>    static LIST_HEAD(snp_leaked_pages_list);
>>>>    static DEFINE_SPINLOCK(snp_leaked_pages_list_lock);
>>>>    @@ -160,9 +162,59 @@ bool snp_probe_rmptable_info(void)
>>>>        pr_info("RMP table physical range [0x%016llx - 0x%016llx]\n",
>>>>            probed_rmp_base, probed_rmp_base + probed_rmp_size - 1);
>>>>    +    /*
>>>> +     * Override e820__memory_setup_default() to do any RMP table fixups
>>>> +     * for kexec if required.
>>>> +     */
>>>> +    x86_init.resources.memory_setup = snp_rmptable_e820_fixup;
>>> This produces a build warning:
>>>
>>> WARNING: modpost: vmlinux: section mismatch in reference:
>>> snp_probe_rmptable_info+0x95 (section: .text) -> x86_init (section:
>>> .init.data)
>>> WARNING: modpost: vmlinux: section mismatch in reference:
>>> snp_probe_rmptable_info+0x99 (section: .text) -> snp_rmptable_e820_fixup
>>> (section: .init.text)
>>>
>> Oh, so this requires snp_probe_rmptable_info() to be fixed to use the __init
>> macro.
>>
>> I believe that snp_probe_rmptable_info() should be anyway using the __init
>> macro and this fix for snp_probe_rmptable_info() needs to be sent as a
>> separate patch and regardless of this patch getting merged or not.
> I think you'll hit issues with:
>
>    bsp_determine_snp() ->           //non-__init
>      snp_probe_rmptable_info()      //__init
>
> and bsp_determine_snp() sticks around as a function pointer assigned to
> cpuinfo_x86 so I don't think you can use __init there.
>
> So might need to just drop __init from snp_rmptable_e820_fixup().

Actually, that will not help as snp_probe_rmptable_info() is *also* 
accessing x86_init.resources.memory_setup

Thanks, Ashish

>
>> Thanks, Ashish
>>
>>> Thanks,
>>> Tom
>>>
>>>> +
>>>>        return true;
>>>>    }

