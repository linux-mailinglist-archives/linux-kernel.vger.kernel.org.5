Return-Path: <linux-kernel+bounces-101024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FEB87A0D3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 02:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 647931C2145E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 01:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D51110A35;
	Wed, 13 Mar 2024 01:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="tgx/4Eq4"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2010.outbound.protection.outlook.com [40.92.20.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C3310A13
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 01:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.20.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710293495; cv=fail; b=qyYJ15yAie0guywJpyg0GUDYeKSaVxNVqm2I0rRKlj/WeCWdNS0wyfppOJJcbH3/ae1Vn8ghFgqJ39gHdcLvhW5Xa23JLTpj05kbV7nZYP68JCfi7Hn9kmJn0Yo5YoVycESQ4DPzgnHf/UjXx9VBk0WpNAsuBfPrT8yXaU4XZOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710293495; c=relaxed/simple;
	bh=71H6FvQJl8HC2aa+Ss89PsMqVM3bSkcIx+rGFi0fPOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DVFEcyt5Oez0k+0NvHnFclUzt87FFdGNwNf0Do0BRd1KgH9RFV0xjKyRqECcPsupsu2EBblh8gV67XWLPUBhNG+jSH2n3/YVwh+5R2Po/A/5fwmMhSGdXt0AM+YXvYfqsRTjF1I8t7PRn7QMMKQzaPKc61AhvDwOsUdxal15ofc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=tgx/4Eq4; arc=fail smtp.client-ip=40.92.20.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YNnjWp+o2xhUbZjGF0/nXQleXUPOOEnJzZ8Heolcnk8O+63ULVr9K/VNy/Tv3/ubCUoyIAShUd+PRsQx8EJDCfxL4z/pQ4ytJAeL7QhTnqt/S7Q/5iZFWdEfG8lEsjf75lkjZVAobnh9KDnjxV5Mm1ztJr/bcW02VkU1MjMQCLV/wcB+LOGL5v+Mv87GPW6/dapxYPeDguzP3EPV2jvWJL1uoKp/w5jBoYCuw+GRhyYtlz2ysZJAWXPT3blK082mCgU+PNMAxFKnO6LxnOBTERw1WBBDdZBh7I9PpM75hFWRbPEvKiAgomvt5iU5eP1gsyAnCPuAWD1NFNKPJyfUaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I0zow8KuzXqLlvnEcM+VIftmu6uL2nyrOYS1y2MeQrg=;
 b=JeFt0xkjJ9CUEtwN96IuXsEG/fYW+cVh93Vkiymgychb8gjOYg1KBeqMgpBhx7YNzHFNG5SQfV+vhkVOGQDVbefHXpcQXoQbNLo2QkPApMlXAuIZbMlqDdo4PCSE9JHpP42F754d+k4P0tQ2uj80I6e155wOskOOS2tcH1W4CZPMfKmJHlKwBVmW+0GevydjNAXakadRpo8jTL0trA9OZ7O2c+/fToGV14ZARHjmHANHycxbAgGRuMKVjLQ2icqcZ0Q6Bj1qzICZmFEuP8hBiH6evRodZ8hA9CovJoiXvRuejid64krgRJDF2Spmz4Z3MKvBRLxFehqopwvxqJ2IJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0zow8KuzXqLlvnEcM+VIftmu6uL2nyrOYS1y2MeQrg=;
 b=tgx/4Eq4za1V7M7aSIwvgCOi7VfR4Inbe/a5AFoOBEFizePyv3B5oN2N9kInd+ctJCrRuT1PNVqcWCZVRTt6gqeaBbm6BVL/eofNxztTb2n5G6DDD6W87qLDYJbBYmSiHpSKNfdKO0EGzWuFXbX67JOBpZXGW8f2m58vaCMf9gABLYKyTqY7nCrq4GysZ4ZjHhCrIURGEOoc9Nz+bGZcSCRDNPeNrrUvSuZy+0eTMxpJdOrTAUPSGAVJYsWTLs/6oslGtPkdR+AGpnLMq1EuQAaWnT87XhDGK9C8ljO3peSNz2om/2iF0cNU8d+jTWSlvxROLmpfJLhTWtI2j+Ro9w==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SJ2PR20MB7106.namprd20.prod.outlook.com (2603:10b6:a03:568::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Wed, 13 Mar
 2024 01:31:30 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::8615:efe2:7c8e:2041]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::8615:efe2:7c8e:2041%3]) with mapi id 15.20.7386.017; Wed, 13 Mar 2024
 01:31:30 +0000
Date: Wed, 13 Mar 2024 09:31:26 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Conor Dooley <conor@kernel.org>, Qingfang Deng <dqfext@gmail.com>
Cc: Inochi Amaoto <inochiama@outlook.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Atish Patra <atishp@atishpatra.org>, 
	Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] perf: RISC-V: fix IRQ detection on T-Head C908
Message-ID:
 <IA1PR20MB4953CE8999960BA71B46DE6CBB2A2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <20240311063018.1886757-1-dqfext@gmail.com>
 <IA1PR20MB4953ECC3E32E95303872CD14BB242@IA1PR20MB4953.namprd20.prod.outlook.com>
 <CALW65jZ+q8sDiRKgsRL9n+939HNUCnkKuO=YJjHB5Js=WYQeOg@mail.gmail.com>
 <20240312-evil-resource-66370b68b9b4@spud>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240312-evil-resource-66370b68b9b4@spud>
X-TMN: [yWv0OWS+qTG8uo/F0w6RH25Y1Zy0APfpFJPvRVwAk4U=]
X-ClientProxiedBy: TYCP286CA0220.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::20) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <jpjlpmzdkpox47kvcamih23wxanhmhn3ipipgkjyn6bztddwdu@xqjmi52u54jv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SJ2PR20MB7106:EE_
X-MS-Office365-Filtering-Correlation-Id: ee56a212-f62f-461e-cd5b-08dc42fd4f2a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	v+u23r1FuESHF/tT+udd2XXS2/jsvJjiZmGq3k5h88J1LhLxfkYMjYX54VX65gBGjBkYnjHYPrvjt/l6b4rwwR547QSx1XVv+kRfX5yE8zLP0zKnZxAm2Wrob7I0nRZQeawuIQ90ljIwlYJ3rV3iHEIpgPl4ybFYkAD5jyBTZWJt/UyAY4AD2uoJ1LIHreGsxj+vnH82NH7zntJF98KDLrqou1nsKfkIZ3kjrUdU01RmZIC+fBdJQxnExxRWQEGLS4BW5vLlkCjKZPPpb5+SEAYhEkkyMERqcSrHzYPTmNNZn+C3Itz6YBrQsX6sLMfDKKfSHsCFfNH1P6uG8STAI2U524ndmJv6BmiIVuW1KFPjVMsMcH7aN81Iwwm8yqZd6l6IR/DNGLWAEnd9N50Ywt4Xml3s9yHviZElvqvoP/tkgdiX3iOCZRmxm9vfqqoLPllBPittijSso3D7Gpb9uwQjMjNXqEmdXffNkQgeJxJBbmiNI6LZETDrsKeK1hW71BQZojQIOQl8hDiHi+m0Y16mQQErBVl6VLE+Yi4Ea+lwwqhYkrIGRcyjs2JRM8/M+CN4YR5L067Fz9Zb9BoWvzVZPLp1WAnAET1RClNXq6zTD9/lGXTJM6qV5O3rbBGEAInnJDwHb3TUsJdaXWqJ5I36/7we24SNzV4QGOS7zcecc009VNTgIHqQ/QH2JxVX
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SndhY04rYU5UTC9WY3F4UzlxSFIwZXdXcnptVlZEN05KNHZBOUNURUMyTUYx?=
 =?utf-8?B?Ym5NcG56b0wxNGl1OEVvQlhUaU8zalowaEFnMVNXOW1kNGdTSUdVVWgzb0I1?=
 =?utf-8?B?RlVXN09pWVpiZ1dIT3lTY1RSVmQ1TFBiVmRRdnpoYjZlMHgwTUcxZUtDU3dC?=
 =?utf-8?B?MW9FMzVNekhjYkJZdi9UblY4OE44SmJ2TGhjTTJ5SHVOb3NqcGEzUHpZRHlh?=
 =?utf-8?B?SW1lZlA5NHFXa2dzU3l4R3VHY3pydzRubmI0MzM2WkJiN0l4SCs0eHZiR2lT?=
 =?utf-8?B?WFhHOTJXMVhVcVB4bmhjQ3BwaEJ2OENQSFMzMWs2ci9SdjNjV0Z3dzl6R3FZ?=
 =?utf-8?B?ZmdXM21peXF4Q0VrNEk5UzRiYm1SdmFEb1ZJYUkvdDIyeTh3eUNDMkFpbHY4?=
 =?utf-8?B?VnRyMWdEc2ZlejgxTG4wRVczRVV3dngvRFRvTk1WUUk0QTFTOXBMVytKMVBE?=
 =?utf-8?B?MlNCcG1aaU9xak1NOEhuV2pvVzJSd1ZQTllla0V4UE9ra2hvdktnRjBqRzVv?=
 =?utf-8?B?K2YvZ0J6VHFRUjh5eisveWwxeTJycW9qL1ZSbzVhUUhQcDVQenNVLzB2Z05V?=
 =?utf-8?B?U1hGVmVCZ2EwMEtLVGg4N2JCcXZUVDBDY09xWjF3S3NCNmRtajI2bUd3bjQ2?=
 =?utf-8?B?Yno4dHlyQTFwSFBHTGpTUVF2UHIwQUl6cFdkOWozaXBnakg3WTdJVnNkRWFP?=
 =?utf-8?B?eklLbUt4VmllVzl6MGNmMDZoclMyRC85WTNDTUdvYXltMVVJdXJ4L3VqbExU?=
 =?utf-8?B?ZWRtMW8rdTB0ZmFPaGgraEtzUk5FL1pTcStid1F0UVJOc0dkb1NSZ0FadFVJ?=
 =?utf-8?B?K0sxcjlxOVloL2JkZFZrOG0xOU5kRXVuYmh6RnY3YXAwZ0E0TTZQTmtaL1A2?=
 =?utf-8?B?U29mdHgrZldlYkluWmFPQWtTb3htNkRnK2lkNmpIMFZuL1BnVVkyWCtGblhE?=
 =?utf-8?B?T0habVFBaG9vS1pNcWdBSnNrRDVRWUNOUWljakR6S2J3WFlDZXFuVy9xVmpE?=
 =?utf-8?B?YzFwb2RnUDVaTlNFMzVXT3JBK2Z1bk51eThTZy9TUFBFbThRNk1FZUxxRHRI?=
 =?utf-8?B?WW81b0VpWWZCSG8wallKQk1wKzNkLzB0bU03dnlBbWNlcURQR2s1ZDhWUE85?=
 =?utf-8?B?MEtMbEFSQWl0YmcvakxVV3MrQkVQOGY4ZC92NCs2emFvNWdQM3RQL042ZDkw?=
 =?utf-8?B?c0NKa1lWRU1YSUEwNDNjQmRmdVJlMXhOL3B5cFowa2VkTCtVcTFZZEV2SVlQ?=
 =?utf-8?B?TmVoU3lMSlp2VWdxRHBOSHJFVndGbmJSc0lHT0RpK1VyQlRNalB4eGk2anN6?=
 =?utf-8?B?MmREUjE5MU5ZQW5naVFDR1J0aWRXcDRGOVJRdnlML0FoOTNVeGF5dkhwMDVD?=
 =?utf-8?B?MjRQdXJuZVdjT25QM0ZjTjFSOS9Yb3oyRjltSmNwWE53Nkw1WTNkbzlHRjd0?=
 =?utf-8?B?Zm1rN3FUNUhiQXlQamF5MS92ZGZFWWNNWXMrVllFMWkyVEZudVBzSE14MUFK?=
 =?utf-8?B?K3IxekVuZ2tPYTVJdk1ub2M5TzJCK3pXNW5mbHZHTW50RVEvNmNmSzAycEY2?=
 =?utf-8?B?cVpNRGhxM0ZXSEcvcUZCbjZCZ3J1SWdRYnRWdXFiMEJRT3A5VEdBWUhPeWV3?=
 =?utf-8?B?WlpSRElCT3dFM0x5VGhOMXdYOURFT1ZBUU1reFhTTElZdDJHQmV6TThZVlk2?=
 =?utf-8?Q?Aw80rm1VPdJqCogMB34l?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee56a212-f62f-461e-cd5b-08dc42fd4f2a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 01:31:30.6562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR20MB7106

On Tue, Mar 12, 2024 at 02:07:31PM +0000, Conor Dooley wrote:
> On Mon, Mar 11, 2024 at 03:56:29PM +0800, Qingfang Deng wrote:
> > Hi Inochi,
> > 
> > On Mon, Mar 11, 2024 at 3:13 PM Inochi Amaoto <inochiama@outlook.com> wrote:
> > >
> > > On Mon, Mar 11, 2024 at 02:30:18PM +0800, Qingfang Deng wrote:
> > > > T-Head C908 has the same IRQ num and CSR as previous C9xx cores, but
> > > > reports non-zero marchid and mimpid. Remove the ID checks.
> > > >
> > >
> > > Hi, Qingfang,
> > >
> > > IIRC, the existed C908 SoC (such as K230) have an early version
> > > of C908 core. But C908 core itself may support Sscofpmf.
> > > So I do not think removing the ID checks is a good idea. Instead,
> > > I suggest adding CPUID of your SoC to this check.
> > 
> > As of Feb 2024, the latest C908 revision does not support Sscofpmf.
> > You may Google "C908R1S0" to see its user manual.
> > But I think you're right. Even though C908 does not have Sscofpmf,
> > T-Head may release new SoCs which do have Sscofpmf, and the check will
> > break. I will submit a new patch with your suggested changes.
> 
> If on an SoC where they have updated vector to 1.0 and implemented both
> Zicbom and Svpbmt instead of their custom stuff they did not implement
> Sscofpmf I think we can expect they won't move away from their custom
> implementation soon.
> I do agree that we should not remove the ID checks entirely, but I also
> do not want to be adding an ID for every SoC that needs this. I think we
> should be getting this information from DT going forward.
> The DT parsing is done prior to the application of boot time
> alternatives, so I think we could apply the "erratum" based on the DT.
> 
> I'm also pretty sure that we can also modify the existing code for the
> archid == impid == 0x0 case to set a pseudo isa extension so that the
> perf driver could do call riscv_isa_eextension_available() and not worry
> about the specfic conditions in which that is true. It'd be something
> like this patch:
> https://lore.kernel.org/linux-riscv/20240110073917.2398826-8-peterlin@andestech.com/
> Just without removing the archid == impid == 0x0 case from the errata
> code. If you're lost after reading that, I can probably throw together
> some untested code for it.
> 
> Thanks,
> Conor.

I agree to use something to replace the existing check, but using a pseudo
isa extension is not a good idea. There are two reasons: 

1. Pseudo isa is misleading. As it is not the real isa, setting this in isa
list may make userspace think errata a feather.
2. Using pseudo isa is more like an abuse of reserved isa bits, which means
kernel may need infinite bits to handle the errata. 

IMHO, it may be better to use a new DT property like "riscv,cpu-errata" or
"<vendor>,cpu-errata". It can achieve almost everything like using pseudo
isa. And the only cost I think is a small amount code to parse this.

Regards,
Inochi.

