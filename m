Return-Path: <linux-kernel+bounces-149263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE26A8A8E2A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 23:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A37C5282BA6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 21:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E6C657C5;
	Wed, 17 Apr 2024 21:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="klSDiZDF"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2126.outbound.protection.outlook.com [40.107.220.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95A5537E5
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 21:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713389948; cv=fail; b=MiNUWJFBHpccMEvxqzVRu8eR8llrCkbrCAAsbtIf9iwlXjIrPgUWX5OxUqIrsmX5kCvkwFwRAcMlBZw5tPYFwBXGxwBZMZYhDOnFvppFXBdoJ/nBwrHCpojlQtPAElCkGytxnSvREAAYWPEs88mN0754alGj/SUt6aBcuiLqozI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713389948; c=relaxed/simple;
	bh=mOaDKmbaMbkkb5K8quc77CoYhRZ/w4d3Y8tYmwFHUeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=auTnvllTVVUC604GT+ab+PmPbZogc8RurDndi7X2jcTBmEj87WZMZhdlEnSV3TDKg44uDDXXfyDVZfViw0Lztk9Q5BpxklO2KGFy/rut5RSBvbtdcQyv6pKBuqbtDesi58NO8GrHVlQ/CGRdqsWonhzA3K2DmDlk4IMSJzWDfNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=klSDiZDF; arc=fail smtp.client-ip=40.107.220.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aAMpNja5zV309IjB4Whei9+oL0+t602ErIiUr4Iznlt/xERqc4k4QWoZzzVFwLBWbTGUkGrvZ4LB2E2nFPnR8pFa7XUr2LZtYv0zjhUcdH1jLb9A7u0wDjqtxC2uX+4mlCeYGZEQeS3JeBBgJL3iw3jqfzO92ngHFZ94DhbBEJ+0siTY2AKDr7Szs11EqFocElpJZNbsedwPYl+61pYGY0sSWN9ZjzVR0UBgqWq1cvmrQl1ceHqDgSSK86jXeZNBnOdZILUCzDJCl6uRlNXsnWndB+pu8bFg8zdw12o2mxazDPd3zZ1rzEhiZPIuZOztpJhb44ke85yC6N9Ge6MhFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7zNFYjRJ0pGSLAlBJBlE1zBf8izpP9IWJrufpTzwkzo=;
 b=dvU/LC9PH7tzCHPBblwCX1DF9ZCV0tTjrA3vxNurd3BXtx8y5FXe+HtG3TXkH39cqrcHnqD47egojEXECUVUtSQfGPu3ZTabcfn+l1gRoM+tceNDABHI298n3fSMBHH8Z8isaeOK28Kk0SUoPwJN4QhFfxzMxTqLeVA8sG4QoLRrjR0WzUY+jbXP/u4ZokbdpCaRhd+G6wSNKv9ES6AQ0HWvSgWOpKcPQ9WPN+AlZRu9PU2aPVkq4p3B55k1jMupX9ouqqJ/8OW18NzLfeE7JHkBTO9ShgBHznS+ts2HatBpPRJZF/hNorhuzS6aqQF8r5qLYez2Dj9tutdew+Ll8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zNFYjRJ0pGSLAlBJBlE1zBf8izpP9IWJrufpTzwkzo=;
 b=klSDiZDFiJE/e2JYVpoqxziYgxE560Bg8IRkVZ1uT/xUgkx7AbZESb/i6PVbybMXH2d/+7M99pM6+9YWVG9dgQBUeGAQJSmsCOoBszY3vvrgohGP7Oe3ySj65L5q3IIsKoxI9686JwYcoWTaPWPrGTwURrIHUmX9/xFl+yNWkDs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6498.prod.exchangelabs.com (2603:10b6:303:79::19) by
 LV3PR01MB8511.prod.exchangelabs.com (2603:10b6:408:1a0::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.39; Wed, 17 Apr 2024 21:39:03 +0000
Received: from MW4PR01MB6498.prod.exchangelabs.com
 ([fe80::4fc3:132:87ac:c13b]) by MW4PR01MB6498.prod.exchangelabs.com
 ([fe80::4fc3:132:87ac:c13b%5]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 21:39:03 +0000
Date: Wed, 17 Apr 2024 14:38:58 -0700
From: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
To: Beata Michalska <beata.michalska@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	ionela.voinescu@arm.com, sudeep.holla@arm.com, will@kernel.org, catalin.marinas@arm.com, 
	vincent.guittot@linaro.org, sumitg@nvidia.com, yang@os.amperecomputing.com, 
	lihuisong@huawei.com, viresh.kumar@linaro.org
Subject: Re: Re: [PATCH v4 4/4] cpufreq: Use arch specific feedback for
 cpuinfo_cur_freq
Message-ID: <s2bel7fzwpkyfyfkhod4xaihuklsaum75ycbcgmcanqaezxdu7@uxvqdqt3yo7l>
References: <20240405133319.859813-1-beata.michalska@arm.com>
 <20240405133319.859813-5-beata.michalska@arm.com>
 <76zutrz47zs6i2cquvjo2qn7myxpq7e3c6alhper7n3wrkhf5h@22l5t5pio2cd>
 <Zh6dSrUnckoa-thV@arm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Zh6dSrUnckoa-thV@arm.com>
X-ClientProxiedBy: CH2PR05CA0030.namprd05.prod.outlook.com (2603:10b6:610::43)
 To MW4PR01MB6498.prod.exchangelabs.com (2603:10b6:303:79::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6498:EE_|LV3PR01MB8511:EE_
X-MS-Office365-Filtering-Correlation-Id: 033e4acc-9bf4-4aac-2106-08dc5f26cc68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Y4iu53QrWDAN0sKOgOW8p3YIBZFKmPFRpNc29xRbffAJliy9Ep+t2BUyVUzZuy9zqLEGck6rNv0VqaGfcw8mhsylRT/JSf6Iq+jXZa6j7jllOqRua/qrha/n2Z+5WVvjqtmwiLW9rttlCSeSvfbIybjLLEycZZnKUroIHfeE7zF3IOhlzy/ORLZ0HBrNllJvQNf1GFPfi5LH1sKIN38ZKDxy0D4GnfdXxEsGxCAlKpiPQsrYvGo9MV8ubG0L7v+pDnM1ainW8ITNfP7anpsaK1nlVxgjl4fIO7FVZw+LmEUSba1i3SWSMRGc7YcTobQV9LRiZELTB9YkVJQecksOBE+6nMVXgK7t6tx7+OqVjuU9pn/gnA83dmJWiTke2yyuMgmr+Q/c0NYnD47maJYHP8fSs9Bm9w9LpWTAsLD/zBd2gUwdisDYd4dosRaT0IDIGCToQdiJhbtHK0To+88Kakh9VtVjNlMxeTiw9VCd28s8MdyDs5aM85/DtFL5GgEJ6p3Z4Ukn7vliAQ/wkNYQbtsE4FU0eLZ5pl9C2Cw8NBecnbZ8/Hzg5JIWf8X16joDdfRLStvjvYTZd6SJ/WufUNMevmAHiqj8qbl5T+JdKwo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6498.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hy+EWj81zSmqnF74Q2a1FUOrULgoL4Hv+JVxUsBKYlwEgzOecYUJTA91qo/h?=
 =?us-ascii?Q?JgxBeyzI6/9FLP4MV9VxVag0mxPfRO1OUUOJBoVxZRS43T+qFq9eRg7loePU?=
 =?us-ascii?Q?m90ZeVvtGut4x7XsjgTMdkKAQ0IO/62xcLCsj5bgC2nQq9ECcCXyP0xuAz9H?=
 =?us-ascii?Q?/IK219UIq4XRpwMMJJoKNYocrpeyqsD/ru8ly3HpKXCPewM5cK7mTNkIuXBj?=
 =?us-ascii?Q?6l4fkpJzIs63d4D/NId0+1KlcdaI7A8iJthWIpMssY2H48F9HDmtzuE+tVbC?=
 =?us-ascii?Q?fDo/P1JSExkr+xGfjlF1JyxaiugtRzNE8WuidCb0I2SaJSamUJsNJC6jzKqH?=
 =?us-ascii?Q?nfUjEFYaNKOmykm3q8ciegSl6IDyEBMNY222BvexvagLlZeks5ACQhi2U+ZJ?=
 =?us-ascii?Q?VnVhFnTun9l45mLJ9btbcAGSCZD7KcPweLl3HXG6NRNJifSdp5OLLanw0mFQ?=
 =?us-ascii?Q?ZlBo9yHg9GKLFH8YADTch8anVL9njkq0o+pG3w/noQLniMTfKAzwLqJjxM9q?=
 =?us-ascii?Q?huWKh+VkodZDa7lsCAwZzpO6GE/OKEGzC6EbF+R+nvef03LQLp3+rJrvRTZq?=
 =?us-ascii?Q?mHziu2kXUjUZmNlUql+MlMF0Udc6nyZwcKAZKrFi6idacCxdlTfTJM0tDUM/?=
 =?us-ascii?Q?hL5bKqQd8nAd8RNw3R+i3Z5vS9rZqsB/rPl/A+yQM5boElwUT3eg+7tdHj23?=
 =?us-ascii?Q?QlN1BrcEn4ED3BWDv9LUqpt7GBSNdkuWiiZMV8IEAm5c2zNySCrXg/yT8FYJ?=
 =?us-ascii?Q?KjkLazuEfyluntCdBMQAiliuHcsxGi3PI7EeI8EwAwv+qkYDEHF/CNvkeryp?=
 =?us-ascii?Q?wIUaHV1pZ7fx5jiarf9CdroYQRqF6NIDC0vDgirk9DNCKRKVZh1UTF6mQaw9?=
 =?us-ascii?Q?xcSp9hofZVzuPo6Iu+Ji0raiF6Rdn3LoW5nPGVUq/8HitZJ3op2MmYtJJRp8?=
 =?us-ascii?Q?12N6qnqSpvsipyKl6iJ1LJfd02mgRvQ2F4kosGs2i+mqasfiwhJii5+SCiMe?=
 =?us-ascii?Q?I+e9t7zMpHWhFal4K4HQljg8nkkwRTL+s1n0wz6L10XDD6T0+Uu7ByowXBQJ?=
 =?us-ascii?Q?1+YZISWlrVQweoHXcttRAxwezYQTaizaYSZTyPUDxLmiL/pFdgj5Oyq0EFaX?=
 =?us-ascii?Q?W3WBxrfLJJWPxm00kk9COAhWB6W9oUCJa82WX6dq7y7slD6ZdjmwN6AoY5Tb?=
 =?us-ascii?Q?Li5BDsrmtdB3xj6BzqSTn1cDL9jz820uXxP5gmNwUi8JX79g1vQwbaa5btWT?=
 =?us-ascii?Q?dIjxOVuwgrhnHhb1ohr4qvfU03PPUOt94FXgIzPOpDk1B6j9uCQGtGiTKSHp?=
 =?us-ascii?Q?l9SsNIKpqLPwX0rSQs1v81OwK5AdXRVBEZDpgD9JTZrkgw6fH2LlXEDZFfo7?=
 =?us-ascii?Q?8Q5k3DaGrE7Y6TgeP5iNdamPKoUWHw0H1YpCSvpmeuToWvYgUOecgzNt+LQ1?=
 =?us-ascii?Q?z39gho4ehR5I3CAf2vgbeGf5fHY2Jy0zLQQzMzbui3pVraxYUUhCDuoZPwa/?=
 =?us-ascii?Q?3ATY1gyT6vexpWSKhE+HvctPPaEyyU5nW9rkX7Lmk8eMYYNsJGY6GwALFYdk?=
 =?us-ascii?Q?IxFZC5RalhI59CN5RF61ClqTDWkaals6Vd3sMyM4FuTbbBbQ4cGaW2lLrmKI?=
 =?us-ascii?Q?x3e30o3O3Y7f4IyBMEZ2a/A=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 033e4acc-9bf4-4aac-2106-08dc5f26cc68
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6498.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 21:39:02.8359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NirglzEwP0qIVu7ANQjfClNxs5LNfgTB6xEoAwTWy0v8bT7TLxIRZlEfsEYgmhsMGRhQ5uUJF3mk5M0VKsK7dgh+D6gh+xxNWLsOiAjvyjtxlifDSYUWLHJPCyUUxsae
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR01MB8511

On Tue, Apr 16, 2024 at 05:46:18PM +0200, Beata Michalska wrote:
>On Mon, Apr 15, 2024 at 09:23:10PM -0700, Vanshidhar Konda wrote:
>> On Fri, Apr 05, 2024 at 02:33:19PM +0100, Beata Michalska wrote:
>> > Some architectures provide a way to determine an average frequency over
>> > a certain period of time based on available performance monitors (AMU on
>> > ARM or APERF/MPERf on x86). With those at hand, enroll arch_freq_get_on_cpu
>> > into cpuinfo_cur_freq policy sysfs attribute handler, which is expected to
>> > represent the current frequency of a given CPU, as obtained by the hardware.
>> > This is the type of feedback that counters do provide.
>> >
>>
>> --- snip ---
>>
>> While testing this patch series on AmpereOne system, I simulated CPU
>> frequency throttling when the system is under power or thermal
>> constraints.
>>
>> In this scenario, based on the user guilde, I expect scaling_cur_freq
>> is the frequency the kernel requests from the hardware; cpuinfo_cur_freq
>> is the actual frequency that the hardware is able to run at during the
>> power or thermal constraints.
>There has been a discussion on scaling_cur_freq vs cpuinfo_cur_freq [1].
>The guidelines you are referring here (assuming you mean [2]) are kinda
>out-of-sync already as scaling_cur_freq has been wired earlier to use arch
>specific feedback. As there was no Arm dedicated implementation of
>arch_freq_get_on_cpu, this went kinda unnoticed.
>The conclusion of the above mentioned discussion (though rather unstated
>explicitly) was to keep the current behaviour of scaling_cur_freq and align
>both across different archs: so with the patches, both attributes will provide
>hw feedback on current frequency, when available.
>Note that if we are to adhere to the docs cpuinfo_cur_freq is the place to use
>the counters really.
>
>That change was also requested through [3]
>
>Adding @Viresh in case there was any shift in the tides ....
>

Thank you for the pointer to the discussion in [1]. It makes sense to
bring arm64 behavior in line with x86. The question about whether
modifying the behavior of scaling_cur_freq was a good idea did not get
any response.

>>
>> The AmpereOne system I'm testing on has the following configuration:
>> - Max frequency is 3000000
>> - Support for AMU registers
>> - ACPI CPPC feedback counters use PCC register space
>> - Fedora 39 with 6.7.5 kernel
>> - Fedora 39 with 6.9.0-rc3 + this patch series
>>
>> With 6.7.5 kernel:
>> Core        scaling_cur_freq        cpuinfo_cur_freq
>> ----        ----------------        ----------------
>> 0             3000000                 2593000
>> 1             3000000                 2613000
>> 2             3000000                 2625000
>> 3             3000000                 2632000
>>
>So if I got it right from the info you have provided the numbers above are
>obtained without applying the patches. In that case, scaling_cur_freq will
>use policy->cur (in your case) showing last frequency set, not necessarily
>the actual freq, whereas cpuinfo_cur_freq uses __cpufreq_get and AMU counters.
>
>
>> With 6.9.0-rc3 + this patch series:
>> Core        scaling_cur_freq        cpuinfo_cur_freq
>> ----        ----------------        ----------------
>> 0             2671875                 2671875
>> 1             2589632                 2589632
>> 2             2648437                 2648437
>> 3             2698242                 2698242
>>
>With the patches applied both scaling_cur_freq and cpuinfo_cur_freq will use AMU
>counters, or fie scale factor obtained based on AMU counters to be more precise:
>both should now show similar/same frequency (as discussed in [1])
>I'd say due to existing implementation for scaling_cur_freq (which we cannot
>change at this point) this is unavoidable.
>
>> In the second case we can't identify that the CPU frequency is
>> being throttled by the hardware. I noticed this behavior with
>> or without this patch.
>>
>I am not entirely sure comparing the two should be a way to go about throttling
>(whether w/ or w/o the changes).
>It would probably be best to refer to thermal sysfs and get a hold of cur_state

Throttling could happen due to non-thermal reasons. Or a system may not
even support thermal zones. So on those systems we wouldn't be able to
identify/debug the behavior of the hardware providing less than maximum
performance. The discussion around scaling_cur_freq should probably be
re-visited in a targeted manner I think.

I'll test v5 of the series on AmpereOne and report back on that thread.

Thanks,
Vanshi

>which should indicate current throttle state:
>
> /sys/class/thermal/thermal_zone[0-*]/cdev[0-*]/cur_state
>
>with values above '0' implying ongoing throttling.
>
>The appropriate thermal_zone can be identified through 'type' attribute.
>
>
>Thank you for giving those patches a spin.
>
>---
>BR
>Beata
>---
>[1] https://lore.kernel.org/all/20230609043922.eyyqutbwlofqaddz@vireshk-i7/
>[2] https://elixir.bootlin.com/linux/latest/source/Documentation/admin-guide/pm/cpufreq.rst#L197
>[3] https://lore.kernel.org/lkml/2cfbc633-1e94-d741-2337-e1b0cf48b81b@nvidia.com/
>---
>
>
>> Thanks,
>> Vanshi

