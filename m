Return-Path: <linux-kernel+bounces-165386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0654E8B8C1C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A3941F23467
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346FE53379;
	Wed,  1 May 2024 14:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="tNLRmt2T"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2129.outbound.protection.outlook.com [40.107.223.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990041F176
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 14:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714574794; cv=fail; b=kIczIs0XxqeynP3PA9ZrQSqX1+JPHCla9YpcvP+zwFijp73eWv6EC4qD6J0FmYEyKA38KYfmxpKRoLIS3h0KnzN21XdUWb6K195bclfnVPL/ZixBsXn++Z4D3MqyZkAyMToe7HXNPKky4oevBSQxHOuWyRjt+fOy7HavdMz3wtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714574794; c=relaxed/simple;
	bh=o+ynxLORm4SqVF7JwoqOlZZotp6HUM2+xyMzImHdTYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GiqkjJTIugC15DI2R6B4jba/umF7bp0Fm4dY21XzFkkmO7hWEmu5yzWuS0Tvr7jbu/o2Wnm8TLCwRwb1btf0+IZBYNveR5CfDxdigPTu0R2rCCN3tfFt1IwmMHi2CuDZ0jOQpz64B3a5XZcBMF5UgqgM+3oeI+T+lCp6qeS68xQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=tNLRmt2T; arc=fail smtp.client-ip=40.107.223.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZJ7HC823efGRCsqVwL5tfuHFRD7CPx0eoiHTeyCYOtiPgx9EyN3FO97aI2G7h6GrFo1dcMAnZ1q49qqbewjFxOBVMZU+sWWdxjUBX+OdPGabEwqyO8V1h2eaV5b3NFiAntyZaW+bB7B/bN1/d2VmNy4vSCr0kygOt5J9Qt05EbRiTp4iTsWRXoi7taf2/OEH5Ysm0kY9RqDWLovKYWhXEruaPtrHyCBR1lx3Sjwdo53hB2OAmNK6yUAQwuXBvDOoeIxMC0GpiF4dhB2oVEu0csqmLogWcdAWZrsc9yGYQiTJd/GCPOuI8ryOOkxBcj+tLuZ3KAIofzWNJYxPZ+n3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nzcCZ4OLvsOGWrncmpLAGk9NY0U7Ulsmxine/m/v3Bc=;
 b=m9fuajjgwdyU0qe3vG5vQEEiYBTJSW46Sk9nXI9U2A80CXp9T3Vz1JG4Ya4r9zA0odmjaqDZSKiITJ7zkTDV49sE9MQmsDhqWUxiseB2MbscGuGKVxnsakis7D209Npgx+eBGgYyTyGd/ffkpnXIUz+IFVyMKD5NAI/DjSlv/P7DaFTiJWjhQVYDWm1eKiFygK0i0A0J+k9d9LkTNEfyqCG6R5WNpdr/DkKm6Pm9HXwz+o6da1eFcu+vZbV2tbP/HXzOzKl3DB0q0okSfy52HFVk4KYU+HdCoYBpfjvgUvSk9ysRdcJ4R0U3WO/30A2MldDTrKZxkKj/O4RRLs78uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzcCZ4OLvsOGWrncmpLAGk9NY0U7Ulsmxine/m/v3Bc=;
 b=tNLRmt2T4/D2O7aSuSpDYxCtKXdnZman8HB3sayWK+HaWnef0RHwV11EBYykUYqshlazjKI/ILM4Yuat+faM0VsQS2TKDp39tU/vmAG4u24LYboUd13GVhnHDvE/3U/o5BvHQqDoFgExjcD7Wr/luDRb8+1GhoExGTnjx4n0H4s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ0PR01MB6509.prod.exchangelabs.com (2603:10b6:a03:294::17) by
 SA1PR01MB7390.prod.exchangelabs.com (2603:10b6:806:1f9::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.36; Wed, 1 May 2024 14:46:29 +0000
Received: from SJ0PR01MB6509.prod.exchangelabs.com
 ([fe80::b0b8:2e9:4460:ad30]) by SJ0PR01MB6509.prod.exchangelabs.com
 ([fe80::b0b8:2e9:4460:ad30%7]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 14:46:29 +0000
Date: Wed, 1 May 2024 07:46:26 -0700
From: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
To: Viresh Kumar <viresh.kumar@linaro.org>, 
	Beata Michalska <beata.michalska@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	ionela.voinescu@arm.com, sudeep.holla@arm.com, will@kernel.org, catalin.marinas@arm.com, 
	vincent.guittot@linaro.org, sumitg@nvidia.com, yang@os.amperecomputing.com, 
	lihuisong@huawei.com
Subject: Re: Re: [PATCH v4 4/4] cpufreq: Use arch specific feedback for
 cpuinfo_cur_freq
Message-ID: <sjm6ktvjql5ce5icfqaxlwvql2jchpya6pgtr6jkjiodztpcno@p5kse5mwqwbl>
References: <20240405133319.859813-1-beata.michalska@arm.com>
 <20240405133319.859813-5-beata.michalska@arm.com>
 <76zutrz47zs6i2cquvjo2qn7myxpq7e3c6alhper7n3wrkhf5h@22l5t5pio2cd>
 <Zh6dSrUnckoa-thV@arm.com>
 <s2bel7fzwpkyfyfkhod4xaihuklsaum75ycbcgmcanqaezxdu7@uxvqdqt3yo7l>
 <ZiuF0zgqkMlmkEZz@arm.com>
 <20240429092515.2ehk4ifcul6mbaxh@vireshk-i7>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240429092515.2ehk4ifcul6mbaxh@vireshk-i7>
X-ClientProxiedBy: CH0PR03CA0213.namprd03.prod.outlook.com
 (2603:10b6:610:e7::8) To SJ0PR01MB6509.prod.exchangelabs.com
 (2603:10b6:a03:294::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR01MB6509:EE_|SA1PR01MB7390:EE_
X-MS-Office365-Filtering-Correlation-Id: d9a59f9b-803f-484a-a303-08dc69ed7bfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|7416005|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GOxEq2FROVmnl969uoDHRu3JcP8ghF0Z+aAx+/VALbrem0ScIK80x5Q/Zzsc?=
 =?us-ascii?Q?4JpIzpyRrWDQXqKCcOfz7y2IY2hbyyPQq4x0sTVD6STuEx2ZXs3VHGiA2rqt?=
 =?us-ascii?Q?B5yaHFb4/pRZ2xhW6zrItSJPlsdby6CDUKE5HOJ/j7j+oqE/1g0Umim22Hw1?=
 =?us-ascii?Q?ywwawXjOo5eHeTISDNPXTS6o0VXJyVJDN7UX2H3xcor6wqr1P0eHgJjymKrJ?=
 =?us-ascii?Q?hsv3ybpNs/MmQE5WvsoSeJXg9dJjqDmS9wY9FsI35fHIJYeiH2ciMtuo6zMz?=
 =?us-ascii?Q?F88ouXy/HHiampALnkJUlB+HBytIV8rB+Z7VPPeVq+AlGBN1OtFao61Yt8CA?=
 =?us-ascii?Q?fz+/qNAVnusp3JTiXJpc2wmp/aniIfExvCx/UfnzgU/8oscqau4hEbiEZyDU?=
 =?us-ascii?Q?W0qVyyUvl8iGDkW4bkvJjj77Pn8EyL/0e1uNEeQI4M41E09aJy6+moR++tB2?=
 =?us-ascii?Q?MhBDgXG45zHHkxAJp0HUUvBHyO8rxCO6zko/Z1/119lRdb1FH46N55FkasT3?=
 =?us-ascii?Q?vT2zf4uxJKtAbAll0OX1fM1CkZAAat7g9PcuvrvmzbwU0eh/11w0c++0Zhby?=
 =?us-ascii?Q?tyiqP84x/RyGKpryg6SUmhpaS2UrjVrBhuaXmE9OGmHgvnbGmutzqSG3OIlJ?=
 =?us-ascii?Q?fSA76MumlS8g1kXsp1p+ZKywOvf6F0Kg9t3l3aRvNIOvzsQNgdgixdu2rtNm?=
 =?us-ascii?Q?4Nyoy2ijNUm6PEOJXEWU5Ym/Zcha2N1Ttt3idYw8Blc/z7YQcISe+b8eTpEL?=
 =?us-ascii?Q?KtZQOUQS4bjVPli580Q7BfKsBwGcWPV+tMUAyJ9e4fW5RcfIng7ccn0LBhhz?=
 =?us-ascii?Q?xeJIw+kot4fi6TqAm9FbkkhB4cqOEywSeRfWLbcTseicOS+EYnf4Kr23Ia1N?=
 =?us-ascii?Q?YFsOxGjovGE9raxscY5JY3M9ZyDNcdn9wdBQwGB4PDMUs+zljRKyRpVEHlaA?=
 =?us-ascii?Q?MuOOP8YtOdPo3rbdPQ6YoFic0rd4crJRzTxAdWfhbjhW0lznax+MIlOsb5oB?=
 =?us-ascii?Q?VZCeou36lKbd4c6p83oS7GgpOFk9EXgn+Q/Q7ZFRqf+h03nuaPJdbPt7GwXq?=
 =?us-ascii?Q?TdzsEefnGn9LTHLhKFr0xYmPaD6+SUz6+bmFR+uVk/Wi85fBp9dY22zUediB?=
 =?us-ascii?Q?fXq1RcnXq5RHPPi2LbHcFpoQjw9ov93sktRcP2aFI54i4wwGHPcfXn4K7FRd?=
 =?us-ascii?Q?SEWeFwNJgcwx2Ni4iXLwzK00UyVd4ZP4U2Pfpxi7qQ9SGkwPyFDHhbZAHayt?=
 =?us-ascii?Q?2n+5tLdfF/PEwJTwTNXPplOFAfwWpTv4Maqq8Xfr4w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR01MB6509.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hxVZZqaMuOARFeeQW4XaiXfpDIuNPd4G6JS9WNJNIonvq8jDxU351n0dH5h/?=
 =?us-ascii?Q?em+WwEbijgTkRDA0yqaJm7w/KfwOpsOkwE0yb7zwZOld3kkirwXZ30PcK9cW?=
 =?us-ascii?Q?qMJpn1jZ34oZxdgYgncVZ8svuOJp4/zArSkbWHhWrs46+nXhYCHklnInmJdE?=
 =?us-ascii?Q?eBO/Es/d5zG1W6tQCCskR/3x5A6V0Sp0pIrYJK2DpqY+aCBnuYx9PC49vBP4?=
 =?us-ascii?Q?Gq+VQhdr5Me+BVWNk391oCSddH8D6y9uP9F6nosDvYu3bGxLCKivtP6Rjtsp?=
 =?us-ascii?Q?zBwi0iTvM3YWc378gQ0NbWXDfp0lt3nNkRqbAZ46JtvjwRvfFstph9WWaQph?=
 =?us-ascii?Q?mMhLFqxG575YKhB2ZVzkCmblTGST2JG1Z4BAfOQUibb7BtupVkeqaUhG6r4x?=
 =?us-ascii?Q?EnWErceM1gliRoimrs/3U0IJa6WOcw8idp7LPWh3LKFDCjHr6FzFZNXJ+ENH?=
 =?us-ascii?Q?la0DodrY0F0tJHjf4nQKpfqbhFE1hWZZZt+n093iq+Eaabu9l5FFoGWlWjFH?=
 =?us-ascii?Q?rPI3URLU3eesNnFm66z8RazRlu4JSj0SQ15KTYVBHrk+3c+5ACBmKn3+AaPE?=
 =?us-ascii?Q?8AugND7KMjsOYBGkKXh8fZwt/UALXfYR2gVA8QTVrniuj053/jMaOzUUkgQZ?=
 =?us-ascii?Q?NyRJ1Q+qta5m4xw4g2LGQ9pBPmIgwFA+7LnMVLMWb/Ir2U9xZMG7BUuW/reD?=
 =?us-ascii?Q?BTNPz+fJHingFYAGDvW/TAWFxH9oSEPsc2sNhm/IBm7uPyLGStC3Rqeay53B?=
 =?us-ascii?Q?UUtDTdtkCbpZ08cW4Rw3aTieEka+wwJ6Q9wmgy4mKq6x9/j0h8J8UkzsRY6F?=
 =?us-ascii?Q?quIFz4EraBk/iyFm4nM+gCa2T8cbYRwbUP6YjY9r4dR436pXK081XWQ0OvDg?=
 =?us-ascii?Q?WvWgx9x0JNf3JD3+oYkcr23+8VFbZGh55lIts9POKXC/YpCFPfdTEIB+Abil?=
 =?us-ascii?Q?6GdwmUpfinq8SBnOEsJmxfCUUoGxBv3oWGCST1cZDqkl0J+rxbPCPHZICOs4?=
 =?us-ascii?Q?VGMavS8ycLRBmZlm5UVKfQPdSIH2l+o6kvOMupIzk5vfEDKnDr5rF7Vx3gLP?=
 =?us-ascii?Q?5XpEeVlQqRejR2TSgzWLaAQNVCk3izquyL/hA4fzmBYkEPRHiFRl9pZ5oJ9J?=
 =?us-ascii?Q?FsZ7kl8rjfpjQgAj4VrYdjSb3Tq4AloWXVXAsRvLJ6P3Qkly8xnbkET6I43Y?=
 =?us-ascii?Q?mdWTsP4x4dK1mFQCeEmthSHSw0ppBtGddHkBYF3glrA85speLRckhuiGjOE7?=
 =?us-ascii?Q?xra1Tu9oM8abF/iHeisN6RgvW7S7gT4XJFl4H/uPUIDgP7xkgVprnmIaKTKl?=
 =?us-ascii?Q?lFFZIC2vRHXBxtHzwQsJBUH1X/EjG3YZNIhf2cnSKIaN3AZs1ksUkOTBrrIV?=
 =?us-ascii?Q?3Cq8QILgJ6pLpdPJcp+pQ54tnyoX2560CAH0I7J5Qv2futuCX4Qnyrrxyrnq?=
 =?us-ascii?Q?lhEwthtp/5npjNqKAjQvbKwPUpbUQcjkEeMiU/JfoaS4An8enAqm8Yvvpspa?=
 =?us-ascii?Q?IvjwajltLv70KVbPeTmF+UPkRQG5Cwyt75KxyrWxmUECtHarzj68iUi9BsWD?=
 =?us-ascii?Q?gFwhcUvHaZN5ghmZ/i6Am2AKWKGmKzZoOjOFuyhcgTuyzkEVMebcTKp4/fDG?=
 =?us-ascii?Q?QMqxt4CxdatEMGnAH3qFRVLjkcu9gl/jK0/Ke4jb8dNo?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9a59f9b-803f-484a-a303-08dc69ed7bfb
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR01MB6509.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 14:46:29.0472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qU9dkFCGQA+Uv1FkEr+tU2UFE/JPsncfBRnQRFZqNNnif+vADRqwEIFamhZi6DmaJAwUInkRLlHZdT7/LSwHdAOofYetXg1nfiYoP5xDex3QB/v59E9qv4oBqVA+kC1P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB7390

On Mon, Apr 29, 2024 at 02:55:15PM +0530, Viresh Kumar wrote:
>On 26-04-24, 12:45, Beata Michalska wrote:
>> It seems that we might need to revisit the discussion we've had around
>> scaling_cur_freq and cpuinfo_cur_freq and the use of arch_freq_get_on_cpu.
>> As Vanshi has raised, having both utilizing arch specific feedback for
>> getting current frequency is bit problematic and might be confusing at best.
>> As arch_freq_get_on_cpu is already used by show_scaling_cur_freq there are not
>> many options we are left with, if we want to kee all archs aligned:
>> we can either try to rework show_scaling_cur_freq and it's use of
>> arch_freq_get_on_cpu, and move it to cpuinfo_cur_freq, which would align with
>> relevant docs, though that will not work for x86, or we keep it only there and
>> skip updating cpuinfo_cur_freq, going against the guidelines. Other options,
>> purely theoretical, would involve making arch_freq_get_on_cpu aware of type of
>> the info requested (hw vs sw) or adding yet another arch-specific implementation,
>> and those are not really appealing alternatives to say at least.
>> What's your opinion on this one ?
>
>Hi Beata / Vanshidhar,
>
>Lets forget for once what X86 and ARM may have done and think about it
>once again. I also had a chat with Vincent today about this.
>
>The documentation says it clearly, cpuinfo_cur_freq is the one
>received from hardware and scaling_cur_freq is the one requested from
>software.
>
>Now, I know that X86 has made both of them quite similar and I
>suggested to make them all aligned (and never received a reply on my
>previous message).
>
>There are few reasons why it may be worth keeping the definition (and
>behavior) of the sysfs files as is, at least for ARM:
>- First is that the documentation says so.
>- There is no point providing the same information via both the
>  interfaces, there are two interfaces here for a reason.
>- There maybe tools around which depend on the documented behavior.
>- From userspace, currently there is only one way to know the exact
>  frequency that the cpufreq governors have requested from a platform,
>  i.e. the value from scaling_cur_freq. If we make it similar to
>  cpuinfo_cur_freq, then userspace will never know about the requested
>  frequency and the eventual one and if they are same or different.
>
>Lets keep the behavior as is and update only cpuinfo_cur_freq with
>arch_freq_get_on_cpu().
>
>Makes sense ?

I had the same concerns. It probably makes sense explicity note this in
the next version of the patch series; in the future readers may be
confused by x86 and ARM behave differntly on scaling_cur_freq.

Thanks,
Vanshi

>
>-- 
>viresh

