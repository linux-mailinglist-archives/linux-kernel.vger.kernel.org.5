Return-Path: <linux-kernel+bounces-131704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAB6898AE8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D24341F2D96C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1B212C81F;
	Thu,  4 Apr 2024 15:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="F8AvJJ/9"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2099.outbound.protection.outlook.com [40.107.212.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A3112BEA4;
	Thu,  4 Apr 2024 15:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712243801; cv=fail; b=C/mkMgH32fuGPOhDvkd8D7Gwmvnozl0AEl30bKO9KhOxTwz+zEKJwXs/pHCDkYYODkE08lJBZ7SbhAQId/k37m92/KZjHXGunzUkTSF4dn0ZfUprbj00XprcoewF60nq5E9qcfBTnycq2eIGSAlJEYaGgiPp2+vnbEqlqDOPChM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712243801; c=relaxed/simple;
	bh=cLxEbB5BMlttGMGLa7QzD8txASMZh6YbHFNW+E2TUFE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EXRe8zBqEetG7Jw3Uc1ibGx7xvRLHSJGkSGHiC71rL+0ZojRZLlhoDjpfVeojpqLvHINmunYdEgfRrkZPiPwTPdO0c9f+LYqABA18A99luudV1Lmp0vn6bu9lveQo8NreRj37O8t2oFtaGB9MLFelskjyyfeupx2wP6dMioyl/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=F8AvJJ/9; arc=fail smtp.client-ip=40.107.212.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+mnCEVdrG/r/KF4zjcNNBgmip0A29M3odf/8FC6rUcYb7UgAIek6mjoNbtZE6CdeEmh656kv1u8adJ/Al7hnlF8Lve/BdYW3lTL7jCRMgqHt8y4xtpyywqRBc1p5nzRJ5NiTOq3IkyL26HFSnOq0It3Do+0WmqE6F4tZYolL6AZ0USycK3qIeAP7f/pdEmuPfxqg7K96D+zRHCCbFgKNMafA34Y4o8lB4deP1lJHnoUWfA4ujae1UA51IkOygLjHmhCpZXsBTTdPY8rE/4sjcwtGcUTi2IJkwKR1Op1qcpDuldphO9a2zpLnzSzUnHldi9kTwItAziDyCQ5c1zfOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=74LXlqa9e2LdQvd88I/YuasJMNAhzKGtQv6qad/It/c=;
 b=du8r7bpsbrNvKLZkPoV62vmysCIk3KPqeyvra1G4yfEiMrscDDBV55RFg3gepV2Bhpuut1xo3jk+HZMRhBXfhCVZx2nEMvGYUkA1ESG2VVT8kORP1XhVnrWnSrVBN8aKI1T1gQQmRtHLOnp9lujOSzquVukzdwIbYxKeATK0W/xA1PG4SWgzi1fSABr+EwWVFH4M0xPfnTqj1qdCHHyPLU7z/fSGOQ5q8u1aCdGbI/zzJ3tqi7Kr1aWKzBpfXs4rSnTf2gCWwVT2Z5khG8yYPx1PK8onuRahgYk8Zr0urv6FYDoYli8Em6MUX5cDS8FswwtT3cv9qi3K6rBD/O9sYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=74LXlqa9e2LdQvd88I/YuasJMNAhzKGtQv6qad/It/c=;
 b=F8AvJJ/9TK+sOkpYK186/IAl5wkT72V764qfsJYK7kxqauCmZyMeLjFjat6Qd5NpG0vNxjoEGc4vg2GpNVUI6K5KJxPHjV7zDbez5Kb7SgTxUVWJny+mx3xf+GWFO+89D5GK41DTgzmJ0b8nji5FtfC7yY3ByxGmGdPcBBcqR30=
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by IA1PR12MB6410.namprd12.prod.outlook.com (2603:10b6:208:38a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 15:16:35 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::57f3:51f5:d039:ed24]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::57f3:51f5:d039:ed24%5]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 15:16:35 +0000
Message-ID: <a7e7f220-99f2-465f-bc36-aadccb891190@amd.com>
Date: Thu, 4 Apr 2024 10:16:30 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [RFC PATCH v3 07/17] x86/resctrl: Add support to enable/disable
 ABMC feature
To: Peter Newman <peternewman@google.com>
Cc: corbet@lwn.net, fenghua.yu@intel.com, reinette.chatre@intel.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 paulmck@kernel.org, rdunlap@infradead.org, tj@kernel.org,
 peterz@infradead.org, yanjiewtw@gmail.com, kim.phillips@amd.com,
 lukas.bulwahn@gmail.com, seanjc@google.com, jmattson@google.com,
 leitao@debian.org, jpoimboe@kernel.org, rick.p.edgecombe@intel.com,
 kirill.shutemov@linux.intel.com, jithu.joseph@intel.com,
 kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, maciej.wieczor-retman@intel.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, eranian@google.com,
 james.morse@arm.com
References: <cover.1711674410.git.babu.moger@amd.com>
 <0db75c94886da62b8da498ef159d8fe27b0b3811.1711674410.git.babu.moger@amd.com>
 <CALPaoCgRtYLnzpkL6uVjb+LvBbxD8ANRuzACP1UQ=rkzk8TCqg@mail.gmail.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <CALPaoCgRtYLnzpkL6uVjb+LvBbxD8ANRuzACP1UQ=rkzk8TCqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0061.namprd13.prod.outlook.com
 (2603:10b6:806:23::6) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|IA1PR12MB6410:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DAWOvZIrAwJhXLuKGOZB1Vfdpu9asE1aPiY1n4ot/lWWEOwRJLdiS1pm9K36myCFgEeWAsE5nH5XCee0lfQdxMqjFfA/IfnUdnjEL8ay3SzkkABi07hbWYagYuWR9o8zjpZ26J5HXzhlFc39qQTZbf60ssvZf1i9r1/tUS1VEcMXwLC2PsnAXStQWRQhHETtdg8TY3W433CVdzWhk50Ddw8mtSi/m7DNWfkc+Prpc0/1mw+WXhWLCvg7btJPc+u1CYiKXubt6euuYygn0Fg71m/w/4x3kVYNGm8oAugKoOV477YKdqmX64cNro9/MZqrgjK27j2GvzQdQKrBfPWiClZtNfcU4Zhgs0lOIdlI4BEr84zs3lUCZmJ0iH+vr7wVvtxUgRsyqyS5SK0sOhR/fqHkBABoc/bYxdS72ZOj3+cirGIEOg8k76fkt7jHGWVZUO6D4vvNMZc9A9hnOJUgd9nVHjWlfxHkXqn4YE48Qo697wSlUgaw/Cqr5mfytDSki+0k8MgCbMt/dJeufj26vBuP2labV4L40450Jme0yHquEe0FfAnMHuoJwRzVuTIusXgUymdAS23wuhwu8PmarzDLgZeHIWM4FrKUDdoE04U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWgwR2pjbVh4Y3ZKQnByWW1YdXJESkRYMVcwWFc4M1duTHFhdGRSZFIrTVhx?=
 =?utf-8?B?V00xbnJBSTdYZlA3SUZ6bUpXeCtqLzNXT2svM210UFFUUktVcnB2MiszdWsr?=
 =?utf-8?B?bjdsUStvbW9NSVdrVE92aHM2Yk9nUFY4MTZoR0x6ek9XNEhJbUMyL05UNDNk?=
 =?utf-8?B?YWJSWk51NDlKT0hOeXZHZjg1aVM3SUxHbmpIMHo4V1V2SFR2MjR0MUw1czRo?=
 =?utf-8?B?WHY1OW9tS0JRb1BnMzlhcDBsS3J3ems3SGZZM1cwOWltcEo4ODExOW9TNUU4?=
 =?utf-8?B?VEg3dml1QnpreUNsY1VSWm03M3oxakI2TUw5eWMvcXBZNzBvdzJkeHU5bURU?=
 =?utf-8?B?L0VRRzVaaWRCNEVaemwyUFJuNkNCT21kR1piVVoycnAyMTdSZ29HYVZXK0tv?=
 =?utf-8?B?b0VJcUI3U2tVb3UrSXBIMlNXaFZzWURmVkRtOWJHdDdIdzJDRW9WZ3ltay9V?=
 =?utf-8?B?eW40dDRQZUFhWFVEc3JmOTMvb0RzSlM4NTRtWWtWSDk0cHhGRDE3UGo4ZGE3?=
 =?utf-8?B?U2dUVVVZR2UycW1GZmVQZlEwbWlPdlM0aEoxRG1NOVY4ajdob2VuUk9YMUpY?=
 =?utf-8?B?YldwRVNUL3MwTXdyTmI5cExIMFExNWJIZ01qdjF2L0F3L3lCdnAzRHRrbUw1?=
 =?utf-8?B?Zy9NamhTNU1EMkIvd3VEcFFRY2VxWVlncytQMEs2WlBWb3crb29KZmRRTGZ0?=
 =?utf-8?B?VXVqbmVDVlY2bjZvandSQW9QOWVhVXpZeHNIbGlPZmE0SU9ueFRFR21YV2Vo?=
 =?utf-8?B?QUo4ZFlCNkVlc2NLamRHOXVPeWVsWjRmQ3paU1EwSXovZHBxd24ramp6YVp5?=
 =?utf-8?B?aFpJTXA1M2N2THJibzcvbE1uajhIajZhQ0ViZWduUjk0T0JKdU5LT0FUOU44?=
 =?utf-8?B?S0l0QkpiZGpqWW9wN1JaK2EvRFZiWUNqMk5nZHVTWkNyMUhlSWFwclI5STRP?=
 =?utf-8?B?aWpycktHVURhdDJ0S1RrR1QwVTZuaTExd0lKdWI1Y3VXWUowRURSUituUWlD?=
 =?utf-8?B?ZlQvZ0Q2dk5EMXdFNHhxWFpJNnhsajBURFhjb2NvMEJOMndIdlpjZmQrMkln?=
 =?utf-8?B?ZDR1TzZFcndTajFjYlRlandHOC9nazIzSDh0SVA1UE9MSHJWMDdjTjY4elU4?=
 =?utf-8?B?SVBwVTZLTkl3ME1ZSXk5MFlMTnlpVFgvZnUyV0NpbHZyZk9ucVIzeXV3aE5y?=
 =?utf-8?B?M0ZQWkdHVUYyeVF3bjV1SlFOMEVieUc4eVpGd0xML0N5eVFRVUNvNm5VSGpo?=
 =?utf-8?B?V1lIRnR3cWxwMGlJNHhIZUcyaTcveDhjVWgzTndJdSsrZTFwc29rZUkwV2Rk?=
 =?utf-8?B?V0FFWHBkSFRNdGtpUFBhYlFrM1VSV1NQc3RocXZxRnE0NStJbktpU3ZQaHFI?=
 =?utf-8?B?Vmdxd2tYQ3o0czI5L1VYWWZPbkVOb1dmYmMwQW5MUjVuZG5aZ25WRFBqMS9Y?=
 =?utf-8?B?ZGlxV1M4TGhvZjVQMUhrU0F1cVg3QXRRK2FvZThCTGF0ZTBMM095UXVxS2Nz?=
 =?utf-8?B?WWVUWldFTndNK25QWDdvajZKTkg4QUEzOW1qQU9ueVREZXN2QnBtODhKazZi?=
 =?utf-8?B?SEZIVDF3VEtPVVVRTFJodmhHTVYwMkg1cy93MFhwY1JwM3lvb1ljT09PaWVj?=
 =?utf-8?B?UVVBcWpwc2pUWnB5eVhpbnZYdUwzaENRUzgyN3RsY29DQU9aTFpmR0tLQUFR?=
 =?utf-8?B?Y1RuZXBBcmpnNVl1eDhCa2lvbWZPdXhZUThvaC9xUTVmMHhzL25VOXZzM2xL?=
 =?utf-8?B?OUxmRVpBNTkvYXYvZmdEdW42NHladExUVHR6Y0NJSU1DYUJBTENONzhrK2Fx?=
 =?utf-8?B?UDNrNGlDWjQ3ekRaa3V4TE5lUVJkeWY0d0tLVUwzK295Z09vSFlVdFRBTU8w?=
 =?utf-8?B?RkR5R3BjREc3V2RSMm1rV1pxam5ramZvdjJZOWdjdHNkRldwUEdERkZFY1FO?=
 =?utf-8?B?T2Y1ekMrcFlYZVY4cWJFNHdpaThEbGdmYmZONlMzTUR2RUZXbWt1SlgwMzd6?=
 =?utf-8?B?OFlTSmxkMW9nZXRIc1k1aUcyMFphYmJqVWhrdXhiMXNJZnZONHZCbkt0U0tN?=
 =?utf-8?B?dUlOOFZkYUozL0FYUDAvc1RzRGVvTnF6OFU4MXJaOEliazNacURudWdkYng4?=
 =?utf-8?Q?x+i4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53ba551f-c1a6-4bb1-0c62-08dc54ba378d
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 15:16:35.3830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vUxONP6UDJD4qZB0g+JjRq/tx1O96SkEtvEtC86PrxIhZCRWqRGPO1e0EbTFj6mh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6410

Hi Peter,

On 4/3/24 19:30, Peter Newman wrote:
> Hi Babu,
> 
> On Thu, Mar 28, 2024 at 6:07 PM Babu Moger <babu.moger@amd.com> wrote:
>>  struct rdt_fs_context {
>>         struct kernfs_fs_context        kfc;
>>         bool                            enable_cdpl2;
>> @@ -433,6 +436,7 @@ struct rdt_parse_data {
>>   * @mbm_cfg_mask:      Bandwidth sources that can be tracked when Bandwidth
>>   *                     Monitoring Event Configuration (BMEC) is supported.
>>   * @cdp_enabled:       CDP state of this resource
>> + * @abmc_enabled:      ABMC feature is enabled
>>   *
>>   * Members of this structure are either private to the architecture
>>   * e.g. mbm_width, or accessed via helpers that provide abstraction. e.g.
>> @@ -448,6 +452,7 @@ struct rdt_hw_resource {
>>         unsigned int            mbm_width;
>>         unsigned int            mbm_cfg_mask;
>>         bool                    cdp_enabled;
>> +       bool                    abmc_enabled;
>>  };
>>
>>  static inline struct rdt_hw_resource *resctrl_to_arch_res(struct rdt_resource *r)
>> @@ -491,6 +496,13 @@ static inline bool resctrl_arch_get_cdp_enabled(enum resctrl_res_level l)
>>
>>  int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable);
>>
>> +static inline bool resctrl_arch_get_abmc_enabled(enum resctrl_res_level l)
>> +{
>> +       return rdt_resources_all[l].abmc_enabled;
>> +}
> 
> This inline definition will not work in either this file or
> fs/resctrl/internal.h, following James's change[1] moving the code.

Yea. I see..
> 
> resctrl_arch-definitions are either declared in linux/resctrl.h or
> defined inline in a file like asm/resctrl.h.

ok.
> 
> 
>> +
>> +int resctrl_arch_set_abmc_enabled(enum resctrl_res_level l, bool enable);
>> +
>>  /*
>>   * To return the common struct rdt_resource, which is contained in struct
>>   * rdt_hw_resource, walk the resctrl member of struct rdt_hw_resource.
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 05f551bc316e..f49073c86884 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -850,9 +850,15 @@ static int rdtgroup_mbm_assign_show(struct kernfs_open_file *of,
>>                                     struct seq_file *s, void *v)
>>  {
>>         struct rdt_resource *r = of->kn->parent->priv;
>> +       struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>>
>> -       if (r->mbm_assign_capable)
>> +       if (r->mbm_assign_capable && hw_res->abmc_enabled) {
>> +               seq_puts(s, "[abmc]\n");
>> +               seq_puts(s, "legacy_mbm\n");
>> +       } else if (r->mbm_assign_capable) {
>>                 seq_puts(s, "abmc\n");
>> +               seq_puts(s, "[legacy_mbm]\n");
>> +       }
> 
> This looks like it would move to fs/resctrl/rdtgroup.c where it's not
> possible to dereference an rdt_hw_resource struct.
> 
> It might be helpful to try building your changes on top of James's
> change[1] to get an idea of how this would fit in post-refactoring.
> I'll stop pointing out inconsistencies with his portability scheme
> now.

Considering the complexity of James changes, I was hoping my series will
go first. It would be difficult for me to make changes based on transient
patch series. I would think it would be best to base the patches based on
tip/master.

> 
>>
>>         return 0;
>>  }
>> @@ -2433,6 +2439,74 @@ int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable)
>>         return 0;
>>  }
>>
>> +static void resctrl_abmc_msrwrite(void *arg)
>> +{
>> +       bool *enable = arg;
>> +       u64 msrval;
>> +
>> +       rdmsrl(MSR_IA32_L3_QOS_EXT_CFG, msrval);
>> +
>> +       if (*enable)
>> +               msrval |= ABMC_ENABLE;
>> +       else
>> +               msrval &= ~ABMC_ENABLE;
>> +
>> +       wrmsrl(MSR_IA32_L3_QOS_EXT_CFG, msrval);
>> +}
>> +
>> +static int resctrl_abmc_setup(enum resctrl_res_level l, bool enable)
>> +{
>> +       struct rdt_resource *r = &rdt_resources_all[l].r_resctrl;
>> +       struct rdt_domain *d;
>> +
>> +       /* Update QOS_CFG MSR on all the CPUs in cpu_mask */
>> +       list_for_each_entry(d, &r->domains, list) {
>> +               on_each_cpu_mask(&d->cpu_mask, resctrl_abmc_msrwrite, &enable, 1);
>> +               resctrl_arch_reset_rmid_all(r, d);
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int resctrl_abmc_enable(enum resctrl_res_level l)
>> +{
>> +       struct rdt_hw_resource *hw_res = &rdt_resources_all[l];
>> +       int ret = 0;
>> +
>> +       if (!hw_res->abmc_enabled) {
>> +               ret = resctrl_abmc_setup(l, true);
>> +               if (!ret)
>> +                       hw_res->abmc_enabled = true;
> 
> Presumably this would be called holding the rdtgroup_mutex? Perhaps a
> lockdep assertion somewhere would be appropriate?

Yes. Sure. Will add it next revision.

> 
> Thanks!
> -Peter
> 
> [1] https://lore.kernel.org/lkml/20240321165106.31602-32-james.morse@arm.com/

-- 
Thanks
Babu Moger

