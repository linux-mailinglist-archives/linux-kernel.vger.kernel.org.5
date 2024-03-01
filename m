Return-Path: <linux-kernel+bounces-89000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D9E86E947
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64DB92886FD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DD139FCF;
	Fri,  1 Mar 2024 19:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xUAbIII5"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F41839AF4
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 19:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709320435; cv=fail; b=UWYT0KWPOWawhAeBZjuj7vJGXdA4TMfe/w8Z/cVxg25x5kvPBAqGf0vNXPW3+dHNtkPJZ4c7w0gAOys8QaFLEnFM/mz4Y/jbyAGfqrHFklV2vr//nEP9sGv6F2JrHz1/vIjmzFvHh24f/hsXsV/BCn/NEakI9mZ9W2f4AUCAkLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709320435; c=relaxed/simple;
	bh=YNmhE8w/a/crPHBB/SgBbqb0XrSoNC9d+hsyPBG1ruA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qp9cyC7gCx351wS+QlDyBrsCRwecLXiVoHGWqfL4m3TMZEf+H1OJNeYgBCOiBItb4/xYuXhYCOs6Tr4eqeMWuqRH7PSg5EQCKXvU77h4XHcJMTyaAF3uLx8IeVpSj+kA6sVX9Iw5pfD7P61e+UzARyZDBQ3xJG4RAQgxUMcAJBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xUAbIII5; arc=fail smtp.client-ip=40.107.92.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/0neJy6Pdv/lC6qA6hZBk7mw/PyJ4D4bysoG2noB5pCHBCvUd3y738zE1/s/CSzFBGekttKysxCa2KMz4+7xexLffFFC+2mzOxPyW05bmJ144QgZoc1IaL9Vp3vp8kEANRSS56txqgdFMcKRjA1HgJX/7qhsVNdRuzdB+/v6OvIS+q1SGVdMjMCOAQcNETqhwjTtyMqhcN+FTC8NM5x0Nsng3r6iopcjLXrA6uiPiTPsnxHjCczMrtTzePEHRIl23sqrDjK53TM0Xv0fWWWXX21veDzE9OPIOTb5Ow994qBRr6QNlpg3y5CRzsyg5g6JmrqV36/YYavnF7GQjCthg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6uipDWLoKoYvae0lXivyRvCf2kKwBhSKxAQHNALYKyc=;
 b=UZqZW9huiG07b4fPEgnVOE/a0c67BKHqMpPQ9hD+y+dJ8bAbzqyIOfaJsKE/6qgH6YXN0LhDUOXaHUy3eKQeaRssHENw9wrCCF/ANmnI1DzP69nEC9bk17CCTtP8Jy3TyrUIEmuoGfrjeXI2KQSLcVRR0PyFfJeAizm/91iPLXXrwIRODYDdLXxT9te5b/eAnBg9XM64mSTuglVeP9A4YOOGFROmNiH8iEI4WpHh2a7GUSfWMSJTBvQ35xAWAStK7zV1yGwiKPz9lXGOfzLZuuKS9SiBGRnNzNbr4NG4o99ycMeHmzDCSAmSzrsESDUs14IuhttZRWbw1+MQaCqUaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6uipDWLoKoYvae0lXivyRvCf2kKwBhSKxAQHNALYKyc=;
 b=xUAbIII5ZRhdIHu3P2YWNxcjCs3Jo2mSiKTRS4jH28IUb+cGydaqaIvjElDQQV0idpw5mbyGsi7WNhzqbm36z262hy6AK+Fkrn6WzKgc2SHDjcsiFc/+OFN93KPkFAeHQDCJ0pSG3BLjThdBSOuBXS+2iQbgWWrobGX4t4myBVQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by SA3PR12MB9089.namprd12.prod.outlook.com (2603:10b6:806:39f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Fri, 1 Mar
 2024 19:13:50 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::4c26:40af:e1fd:849e]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::4c26:40af:e1fd:849e%7]) with mapi id 15.20.7316.039; Fri, 1 Mar 2024
 19:13:50 +0000
Message-ID: <8521a07a-b8c0-e653-e5a1-852bc3adbaac@amd.com>
Date: Fri, 1 Mar 2024 13:13:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v7 2/9] x86/startup_64: Defer assignment of 5-level paging
 global variables
To: Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
 Kevin Loughlin <kevinloughlin@google.com>,
 Dionna Glaze <dionnaglaze@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>
References: <20240227151907.387873-11-ardb+git@google.com>
 <20240227151907.387873-13-ardb+git@google.com>
 <20240228205540.GIZd-dzFYIBbtfIAo3@fat_crate.local>
 <CAMj1kXGhZU+FE2gE262Q8_vZEFHicsRtVPzXT-dhhCvBuiMjUA@mail.gmail.com>
 <20240301160921.GBZeH9sZhp73xX40ze@fat_crate.local>
 <CAMj1kXFJwEUExy7+Snh3QHVn-ATj0C+sYje22Qmc+y=cCtAV7g@mail.gmail.com>
 <20240301173323.GDZeIRY_BVBqpudkEo@fat_crate.local>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20240301173323.GDZeIRY_BVBqpudkEo@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0030.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::6) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|SA3PR12MB9089:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cf21590-fdab-41a4-09aa-08dc3a23ba4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	j5zoy7lUbzcYuXdNZ885sKRZI1HVIAyelLSxiw0fuSG+J0+AAPjn3/FsiUlhceBf7zhbPQrjWaws9LsrP3EVHN/uiGdEox3i3sa82mex8H3b93GzpXvEwIxOsSbjql73471jAhe/wzgbIaKQeEq84flXj5YoJS5C68cvnQu+55BmYe29aEXdj96qaEQ0sXKU0ly2yc/GFbQx6ZXy37jRTOhtpxtyLwrNezsTG9Op2KKpDqwhqOOkCNw+0I7T0yIHfAsun9L1VYhbq1oFJJ5NHptbSW407knKxq0jcQWVokipJncEBezQE2PvJ/3FFlVWuhtaSklDSunnf6PZME3fCdqjLdaLsytsTqlt2ZJIn/BAnUIaoOjjAhXr2pIi6wAaQUrA87Dbr3eMp3bZ1Fz0Sj5//eotecY1MyCRG3Db1h4Y2S6YBnA2PJJAEt6ggO5NE1TzvgwSb4/YFhj96qN+xafBPDZkarSqlzxWgIWI8J2jI5LKxAeWnRxvfxKBTt3aqZUEm+LGa9x8swCyaJmPa39K0LXefrGQD4i7U1hO0gBqpiunw+/i9HXRZXe0cILLdey7nZ0y4MULvcsjvWxV/w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?alg3MHV4eTZBeWdSeWt1MHV5N1BWQlVPc2cybTFMaW9Wd1R6QSswQWc3MFUx?=
 =?utf-8?B?b08yemIxN0l2YS8zWVBQd04wZEdZUS9zTzZBdk1PUSs0QThLd3FhMFZmWS9u?=
 =?utf-8?B?b1k0LzFINk9ad1QyK1ZNQ0hFYTJHN25NSUVxd0RHZzY5NHh4NTg2ZG5YNHZG?=
 =?utf-8?B?eWxaWXZlS0h1Ny91Nko5WDNsY1l1YjVuRFducU5hUy9STFNRTXdYaE45SHdW?=
 =?utf-8?B?MnMrY2Q1Qll5K3pQMDlNc3VQSjdPV205WXJMa1FTbm5tc3liRnhJMjhiM0I4?=
 =?utf-8?B?Sk9mWTQxdk1yT28zbWNFVjBtNklxeVFWbzlPS3FMWklQMjFlazFJdXYyNnJ2?=
 =?utf-8?B?YXVoU1hZTGxML01aWVhsczFkUy9VS2FwcW1mOEhtWXRLc29ybzJhcFBMV2pD?=
 =?utf-8?B?SCtkdU40d29wZW1yMHZESStvUTVMUDJIRVZzaFhkRUFKZEJkNFRWSVlzWXpF?=
 =?utf-8?B?dVBaWGJhTkRDVGdtRzFrUzNYSHM3TGJiM3BleExzamZzMU5EdDN2R05kdlJE?=
 =?utf-8?B?Uzl0VWxmVXlSbngrVldIeGpUZDNRSUkwYWU1MWJyUFFWVm1rdHpkLy8xZW1H?=
 =?utf-8?B?d0QxOEMwRGlWZk1rVU02MDEreForZEpleWFCM0VOY1dEM0Z1WGtubFF6N2NU?=
 =?utf-8?B?am0rS1NHNVY5MzZER042UGFJWXkwSXowaWJQNG4xTS9TSGhDd0g4QUE3YlRj?=
 =?utf-8?B?VzFQMEU4MjU3QUNVWFVsQWVuUVVFU1diSGNLTlNLTDN5VjlMUCt3MlpwZnRl?=
 =?utf-8?B?ZkJTWm5FYjN0YU93elZRdVR6cVRJMy9McEpWd1V2Mytmd0VMS3pqTjRwZE1C?=
 =?utf-8?B?a3FvU3J3NmtKL3N3dlhVb0w5QlIrS1R2ZFpEWCsyY25xWEpybC8xdVdJaDg1?=
 =?utf-8?B?eStEZFlPazhTbTQveU83dk5vR3lQQ0JzQjczdFh5UWp2Q2pwLzZtSktuT2Nz?=
 =?utf-8?B?bzhYSmhuTVBLejdrdjR6b09jM0Z1bkNWVllQR2J2b05OSzdIanplMTlmZ2s2?=
 =?utf-8?B?a1pmWG5aVWtObEZiWEZTampHdHFmMHVNY2FBZWNhZDN5Ulpub0lxMFNMeE85?=
 =?utf-8?B?anFwbTRrY2piRm1QNCtncmJKdUlNVVRRQ1FhTElTamY4aTJGNHYyWVZGemlq?=
 =?utf-8?B?eTdtbW9nVXFiZDlxL01NZmx5UXA4alR4Umg4TlRXU29ueVF2Z0lXRUJUM203?=
 =?utf-8?B?THVWZVVnMlhKOU5uYWZldWhuSGd4YUVZWHNRZ3V3clZ0cVZrY0o3bjZXSitK?=
 =?utf-8?B?ODJqWmJrOHhCL2ZiWExvNkV0WkNMNXBwZCtxaHlrRVA4TkVVTkE0UUkwVGhI?=
 =?utf-8?B?WjZKUjhLNlljdExMUlNZNmprTzhmakw3LzVMS2FvL0V4TnZRUHYzYmY0WU9l?=
 =?utf-8?B?WWc4QnZ3bnBQeG1ndk1oZUtPOG5pREFIVmkwR2ZNN2V0bnpRMTRQRnk0cWFW?=
 =?utf-8?B?SzR0QVQxeUo3ak1UaCtwbEdhOE85M1gvUC9kM09zVjZlb3BvblZzTVRYZG5v?=
 =?utf-8?B?clBreGxSNVVxTURUMGZNQXZrOCtPOVJPSVlTblJpbVEydnZ4eUI4SmZlQU5t?=
 =?utf-8?B?TmdkLzNkWGkyR2pOQm1GQlNyZ1VQZEtrcWtZUXRDRWVmdVhERnpqQWVNKzJV?=
 =?utf-8?B?Q1VoeFEyd0ZVL25kN0FOcDNuRzF6WWNuQ1VXdFp4V1RoOUc0TXU0TVAzcUxp?=
 =?utf-8?B?R0FqalBZS1pkVzlGL0dyVlNyYS9Sa0s2TU0yYnp1bjZabVNBYTRPTE9WRnlF?=
 =?utf-8?B?UDNUdXdJR2FLUzdjdWJZcXZmRU5WZ3hzbllORmZBckpUQ1hpM0VTK0dJN05Q?=
 =?utf-8?B?d0ZVYlh6TFRmL092bEdUWmtmR3A1ZnlVdGtFWGhqOEt0Q05EWTBrVWhqKzFI?=
 =?utf-8?B?L011RXg2R2ZFdjhrVVFNTFFuT0lpSU9lQmxBZXpPSU1iVERWSUk3d3VaS3g1?=
 =?utf-8?B?ZVdnMzNlbU5URXdnWEMrcTBJbkNtQUJsbGRFcVA1b0JkcDNKL0VudVJSUmNu?=
 =?utf-8?B?SlRLNXB3QkVGWENTbHo4Z012VnNEUTV6NTh1RGNYRVU0a0drbWs5bytjZVJs?=
 =?utf-8?B?R2xSWktzdzhxSXpMTEFwejhKRjhaVmhTVWhqblV4RndlMG00dFJ3bTl3UEEz?=
 =?utf-8?Q?ceuBWjUdfJNEdljaWabEyq5/g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cf21590-fdab-41a4-09aa-08dc3a23ba4d
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 19:13:50.4638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rQDgsPjw5jKqp4nX1UqT2GhLAxcE/fVm6zjduyxLpM1tNvQr+cZsnqxLV3lG8KqiEvpRja3eedDsQ/WI2hEs8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9089

On 3/1/24 11:33, Borislav Petkov wrote:
> On Fri, Mar 01, 2024 at 06:09:53PM +0100, Ard Biesheuvel wrote:
>> On Fri, 1 Mar 2024 at 17:09, Borislav Petkov <bp@alien8.de> wrote:
>>>
>>> On Fri, Mar 01, 2024 at 11:01:33AM +0100, Ard Biesheuvel wrote:
>>>> The scenario that I have not managed to test is entering from EFI with
>>>> 5 levels of paging enabled, and switching back to 4 levels (which
>>>> should work regardless of CONFIG_X86_5LEVEL). However, no firmware in
>>>> existence actually supports that today, and I am pretty sure that this
>>>> code has never been tested under those conditions to begin with. (OVMF
>>>> patches are under review atm to allow 5-level paging to be enabled in
>>>> the firmware)
>>>
>>> Aha.
>>>
>>
>> I've built a debug OVMF image using the latest version of the series,
>> and put it at [0]
>>
>> Run like this
>>
>> qemu-system-x86_64 -M q35 \
>>    -cpu qemu64,+la57 -smp 4 \
>>    -bios OVMF-5level.fd \
>>    -kernel arch/x86/boot/bzImage \
>>    -append console=ttyS0\ earlyprintk=ttyS0 \
>>    -vga none -nographic -m 1g \
>>    -initrd <initrd.img>
>>
>> and you will get loads of DEBUG output from the firmware first, and
>> then boot into Linux. (initrd can be omitted)
>>
>> Right before entering, it will print
>>
>> CpuDxe: 5-Level Paging = 1
>>
>> which confirms that the firmware is running with 5 levels of paging.
>>
>> I've confirmed that this boots happily with this series applied,
>> including when using 'no5lvl' on the command line, or when disabling
>> CONFIG_X86_5LEVEL [confirmed by inspecting
>> /sys/kernel/debug/page_tables/kernel].
>>
>>
>> [0] http://files.workofard.com/OVMF-5level.fd.gz
> 
> Nice, that might come in handy for other testing too.

Be aware that additional work will need to be done in OVMF to support 
5-level paging for SEV VMs.

Initial SEV implementation happened when there wasn't a page table library 
and so SEV support had to roll it's own page table modifications. A page 
table library has since been created and 5-level support was added, but 
the SEV code hasn't been converted over to use the new library, yet.

Thanks,
Tom

> 
> Thx.
> 

