Return-Path: <linux-kernel+bounces-104066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2467687C880
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 06:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8764282876
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 05:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B48AFC01;
	Fri, 15 Mar 2024 05:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="r2qDQy7U"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2057.outbound.protection.outlook.com [40.92.19.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11275DF51
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 05:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710480246; cv=fail; b=DhSIIwCIjS0xjl9H831xm3dB7IsBIMeeeyJAYzl4SQJv+oV6fX6M0O06yuTTOneMGtIVSeC+Dc72mhbYzruyRnfydZKdsuk/Q3zUDV+cs07+gLwQIvIc7kldsKOqnsCpUXymTzeE7lX81WF/82jA9v++1S27KrJRnBjb+u9flGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710480246; c=relaxed/simple;
	bh=lAyoL5SgJ4zDnReRnucreamdVS9Mipeplm9ctpNw/dY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HD/T05uY0RIXOSp0Np46oGFfm/a5TEGX0dK+8tQljtb15dPd5OpABJ1BRT57tWWbFij/7fkwRoH6dBxnbb9SPILgK+rAbZ5tFX/hJYitgpN+heg5iDQvdNUH81vZccEAEedPUIpxKy3NB78J4FW2P0H5L+Y2yAW547SCIFtK3X4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=r2qDQy7U; arc=fail smtp.client-ip=40.92.19.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EwD6I63RU5XziMKq+h0L2Y2/R7TxgFbH+V3fJDxPwVfOP7Jk/Rei7uLCCLdnWpNH70Z0OfgJSbRDMSOh4DrvTR/TodRvBVmWfnq9vsXqVwAX53ol7cuq61EXkvyOYjXHtXMoZrHn/LXq9aKpfcX8//2YGdqmP60t2gRsXWBrMsovBw/N3gXOC+bpAf4zsBwVu3UumYzqSPmMK725xbkkpWEiKArKjA8sr2o5j9qTYSwncsdpgLc11XWyZ764EMwj3VEnNcy/P05iyyfMoVWAvz5G7/+EQWb9UP3QOxuaLYZHl49dsHYYlXdrJdTPJojCCIo30N4TSQs10uXHo6VCDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HSmghy40RwD+jsVCUi21yn7xFThOULYBU9kYUAVYmfE=;
 b=iqSoxG5qs5870tvUIUv8IinbgWpqWrdSqZInQ3wqsmhKSqKNOCImIIcOi0BFoxYPCgzp1X196gWiS83aAK1KczD863HxhsfJKgyQb0dt52KnfP/8lgDkZ0MT2CYqJFjAvgNOcDwmKI9h6oiX1Xs993cZY/43mapnSovqVbJwQAf7t2NpRZFZ709mxgOaA+Mxbw39rGh2tT6ImV+9clnNWr9vBSDXWYxRCMYyA9aC+GbizvQkNKXBvvSyQQElKMUFeU0P6v9jC7kpiexXsC4LIVjm6ceDTHFE3GAutn+gbksEmYMD2lY4NfuHNaOnT8m5qZmIoFaBLmEiNaYny54I9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HSmghy40RwD+jsVCUi21yn7xFThOULYBU9kYUAVYmfE=;
 b=r2qDQy7UThvu083s6wShahyTM17f8CM5kWJnTtMZak5DKf3SdiZ7IQlcInWdxLhpPjoZmc3keFbKOo0UTXcL7xYsiVZ38pF5gXj0sD1dUVk+QlYcJQWA9E/f6U8ETaa96Sq/33MQn9DK0T1KmfqiKTa0hlii7+dtgS/gIM678lItlSazFMSXdRY8oVJ1TrBOlmGXSHGPwAk/kn32i57AJvJOZRVac2gYs2SZ1u0FqpwMtwedNY54RJ67GK841e6GDVMK6gEnt4RR8X/5jr/uszLKDy1Ii6TSzD0HzDvdqdbXX1w1SyAX8Wq1O12GiLOPki61E1xa/rgXnuyAxpRSfg==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by IA1PR20MB5051.namprd20.prod.outlook.com (2603:10b6:208:3a5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19; Fri, 15 Mar
 2024 05:24:01 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::8615:efe2:7c8e:2041]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::8615:efe2:7c8e:2041%3]) with mapi id 15.20.7386.021; Fri, 15 Mar 2024
 05:24:01 +0000
Date: Fri, 15 Mar 2024 13:23:58 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Conor Dooley <conor@kernel.org>, Inochi Amaoto <inochiama@outlook.com>
Cc: Qingfang Deng <dqfext@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Atish Patra <atishp@atishpatra.org>, 
	Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] perf: RISC-V: fix IRQ detection on T-Head C908
Message-ID:
 <IA1PR20MB4953E86537D28A85CDBBCCD3BB282@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <20240311063018.1886757-1-dqfext@gmail.com>
 <IA1PR20MB4953ECC3E32E95303872CD14BB242@IA1PR20MB4953.namprd20.prod.outlook.com>
 <CALW65jZ+q8sDiRKgsRL9n+939HNUCnkKuO=YJjHB5Js=WYQeOg@mail.gmail.com>
 <20240312-evil-resource-66370b68b9b4@spud>
 <IA1PR20MB4953CE8999960BA71B46DE6CBB2A2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20240314-pep-announcer-2d7f10ff8b65@spud>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240314-pep-announcer-2d7f10ff8b65@spud>
X-TMN: [oANGyXNYNYS7fOWJuVtylvEeYErvB+MiX7nycat9orU=]
X-ClientProxiedBy: TYWPR01CA0012.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::17) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <qlqld4qdji4k7aunxbpbv2mc5p4agugrzv2ry5ptefobowzetx@iocokpomijz4>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|IA1PR20MB5051:EE_
X-MS-Office365-Filtering-Correlation-Id: 957d24a9-ce3c-4c95-2cd0-08dc44b01f16
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MLmNGuIFd+7BRSuh6xOKvt/M8O76gJmN1iUUIRMqVcq4KMZJxm5nn5+G4dW6zD14uQBQGtJgRHNndU4RCybjEorm78BDZ8wZxEwLg4WuqGWHtth47uuE3rkgF+YHGOgu8KEIPHVSCZw+xU3SOpJy73Y5vnjybLsAyTl6v3X03JvZcoqS3lYprZDaBWeWmyyH6XTN0kQ0QeiE/JLtklq+g01SkJGzcCiiHl88lV6Kpkl5MpXBxkTE/5svX2DGRdS7S3ay7UZjep1WFldHqsShnUtP6uul4sXLk7kRsLbfbDy2Vx6IcepRCCqxC/mkij1jqOzTt3l/JxdRbOWXIJEwWZK8mQEv6IRoRGeSGEvIaOc3RYug8WN0nSlXta52U0gRhC1yxOkjI7rnaaanT5Kh2w0Xe976k15x46UdnkpoJ8C31ayFyZwR+CIgOdZSAUtMXjTcwxmu2lmq7z0bfqxOEog8Xnz4jn6W5y3DXdvNKs4dLHLs81XTlMDULP/OzGSwUq+9Va0nlbqgfm82qJIp8n+Nm47RYy+89uQofutxNZo+JhJz7rB+T9tsNSTr9ZcvMCdCv7pMcrwXid1p8HqSrezcvQbPfR8a4XS5LIod0aNI+i06j5mwpnxiFK/GPgTpuvVN+12qs4kVn9OjqhEVGDy7pnxDdyFAzEUXa73//7+mMBrOIV22U4RkAwuQwLmj
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UzJtWm9jZ1I1MEhuREZZakdSbU1idUJXSFJjcjR4aEd2aktubjgzdW50UDln?=
 =?utf-8?B?Z0ZTOW5vTEtFNFJHdzgySnBEdUtOeFlFeW5oaEd1VUI1WnJ6ZUFrMVcvMDls?=
 =?utf-8?B?OHlCMnNTTDZkbGRBbzNHOHEvSEV0MDBMR2MyMlFGa3VrcDNCVlA5blVWRnBL?=
 =?utf-8?B?VUk3WnlXVW9DM2htaWlRdENsNytwM2cxZktrMm9IaTBwZjdqbytoTUdjK3JG?=
 =?utf-8?B?bEZFYWNQL0VvSElmOURITkJmd2FPck9rZWwwL0JzY0N1cloyYzJlUTU4YnpB?=
 =?utf-8?B?R09qRzYvcVBMOE51TmwzREdueWllMktxMmNkeHE5aXRCSllNV25FeGVpTkRT?=
 =?utf-8?B?OXp4M1hueWNkY3k4TUp5b25lZGduYUpQQUEvZElnU0R4V2lCdmJmUThkUnpq?=
 =?utf-8?B?L05rQ0lUTWIza05ERzhvSlhtcWludEFPY0xjTFhzQUZjZS8wcnhEY0Jsci8r?=
 =?utf-8?B?OWF1RENtZmc5cm15eFE0M1FBclR4R1ZZTXlBSXhpWkllMmhDZmN0eGVZaEha?=
 =?utf-8?B?NmFQVk9zZEN3dWlTcHJYSlh4amx4T0hMWnkrVzZtYUt4UzBXeHJtcWFPZGZo?=
 =?utf-8?B?amlyUldmVEFJdHJvVXJTRzlqb1NjZVNXK3FVQmtGbitucW1xdFpsWlRDenM2?=
 =?utf-8?B?Sk5vZnJaSkNyOWIvd2VONUpjN1RrdHhNZ1V1cy9yR2RqTEFYUFJwVUpvUStl?=
 =?utf-8?B?bjdUZjY5eXNQYUhWUmpUWDBQbm5LSmI0Z00wRU0xZUN3NWw1ZnJWMk04NHF6?=
 =?utf-8?B?Q1ZqclJsbnlEM1J0MHp4bmo5Zm5XdmNjSU53OXhkMkpCWWFhSk9EL20rNFNr?=
 =?utf-8?B?Z1RrWFp5S3VFMDgwdzNHSTd4dlN5U3lSVTJkSjVEYjNXaVJ0Mkx6ZzZqNjJr?=
 =?utf-8?B?ZDVYMi9QZ29zVHd5TVloTWpLVE91V3c2RmJ4ZmhTeWFBRGpxSnRIU3dqWWJL?=
 =?utf-8?B?RGZXR3d1WHdzSUV4RlpwV1RPSlEyajFab01PMkhVMU16eWczbi9KWEZrN21y?=
 =?utf-8?B?TG5iMC9vbER4V2Yya3FEUTBpNmNvVldUZ2o2ejVQTjBpWUsxSGk5MjJERGZ0?=
 =?utf-8?B?LzFsdTd6bytqbG90NVFQM3BSMnNScU5XZjUzUnpENWg2Z1dZQjl6WmtiWC9D?=
 =?utf-8?B?OTdkZk1qMklyajFmYXI5WVhnV29oTjc3UDdLNTZ1MHRaM2lRU29Oa1NPbXJV?=
 =?utf-8?B?VXhWNjhJeE9ieXhaMkh0bWRpSUhjZjNNTFJxNmd2M09lNFdqTHUyZFZUTTFm?=
 =?utf-8?B?NFNVS29GeUJPWWRhREpCazB3N0FtZ21vWDlFMTMzNS9NVDZqVXczbEkvM0Zl?=
 =?utf-8?B?WkpwdTIvNUNDcGV2ejh1aFdjbUQ2Tk9tSVdacitxYjlvUmRpbHpwOGxmZTEy?=
 =?utf-8?B?cm1JVjUzMitQelNFWTV0Z05CUWdjdHNXMlhSNUx4NS85TVJkRnR4b3RSd3lO?=
 =?utf-8?B?N2gyTzdIdjBRSlZkTGJLZXFqZmFuOG8wYUdldDlORURvdElTV1lJSDR0a1FP?=
 =?utf-8?B?cFZVQzdjLzBTWi9GV0tjQTBIcGJwcVRKSEpWbjBIRkpXdUFXaCsrZ1BJdFZi?=
 =?utf-8?B?bUF4K2hBNE16NFNzZjZXOG1zUWU4Q3BGMEtieUFpclh4bjRmMjBSSlZ3WDFi?=
 =?utf-8?B?bUhYNmJIdUhONEVMSHplVyttRnlsWVI2UEN4OWkvOTMwaXUxQzhodkN4ejlL?=
 =?utf-8?Q?//xqOeXenPbaB1eqtesT?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 957d24a9-ce3c-4c95-2cd0-08dc44b01f16
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 05:24:00.8138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR20MB5051

On Thu, Mar 14, 2024 at 08:41:15PM +0000, Conor Dooley wrote:
> On Wed, Mar 13, 2024 at 09:31:26AM +0800, Inochi Amaoto wrote:
> > On Tue, Mar 12, 2024 at 02:07:31PM +0000, Conor Dooley wrote:
> > > On Mon, Mar 11, 2024 at 03:56:29PM +0800, Qingfang Deng wrote:
> > > > Hi Inochi,
> > > > 
> > > > On Mon, Mar 11, 2024 at 3:13 PM Inochi Amaoto <inochiama@outlook.com> wrote:
> > > > >
> > > > > On Mon, Mar 11, 2024 at 02:30:18PM +0800, Qingfang Deng wrote:
> > > > > > T-Head C908 has the same IRQ num and CSR as previous C9xx cores, but
> > > > > > reports non-zero marchid and mimpid. Remove the ID checks.
> > > > > >
> > > > >
> > > > > Hi, Qingfang,
> > > > >
> > > > > IIRC, the existed C908 SoC (such as K230) have an early version
> > > > > of C908 core. But C908 core itself may support Sscofpmf.
> > > > > So I do not think removing the ID checks is a good idea. Instead,
> > > > > I suggest adding CPUID of your SoC to this check.
> > > > 
> > > > As of Feb 2024, the latest C908 revision does not support Sscofpmf.
> > > > You may Google "C908R1S0" to see its user manual.
> > > > But I think you're right. Even though C908 does not have Sscofpmf,
> > > > T-Head may release new SoCs which do have Sscofpmf, and the check will
> > > > break. I will submit a new patch with your suggested changes.
> > > 
> > > If on an SoC where they have updated vector to 1.0 and implemented both
> > > Zicbom and Svpbmt instead of their custom stuff they did not implement
> > > Sscofpmf I think we can expect they won't move away from their custom
> > > implementation soon.
> > > I do agree that we should not remove the ID checks entirely, but I also
> > > do not want to be adding an ID for every SoC that needs this. I think we
> > > should be getting this information from DT going forward.
> > > The DT parsing is done prior to the application of boot time
> > > alternatives, so I think we could apply the "erratum" based on the DT.
> > > 
> > > I'm also pretty sure that we can also modify the existing code for the
> > > archid == impid == 0x0 case to set a pseudo isa extension so that the
> > > perf driver could do call riscv_isa_eextension_available() and not worry
> > > about the specfic conditions in which that is true. It'd be something
> > > like this patch:
> > > https://lore.kernel.org/linux-riscv/20240110073917.2398826-8-peterlin@andestech.com/
> > > Just without removing the archid == impid == 0x0 case from the errata
> > > code. If you're lost after reading that, I can probably throw together
> > > some untested code for it.
> > 
> > I agree to use something to replace the existing check, but using a pseudo
> > isa extension is not a good idea. There are two reasons: 
> > 
> > 1. Pseudo isa is misleading. As it is not the real isa, setting this in isa
> > list may make userspace think errata a feather.
> 
> If we wanted to suppress sharing this information to userspace we could,
> but I don't even see what the harm is in userspace knowing.
> I also disagree with this even really being an erratum in the first place
> as they implemented something before a spec was created. It's not an
> implementation of Sscofpmf with a bug. I don't think that calling it a
> "real" vendor extension is problematic either, just I am the one calling
> it that, not T-Head themselves.
> 

I agree with that not implement standard extension is not a bug. 
And it is necessary to let userspace know if the core have behavior 
that is different from the standard. In fact, I think it may need 
a different name to describe this difference, "errata" is kind of 
unsuitable.

> > 2. Using pseudo isa is more like an abuse of reserved isa bits, which means
> > kernel may need infinite bits to handle the errata.
> 
> What makes it an abuse of a "reserved" bit? There's no rule on
> disallowing something vendor-specific there. Given the amount of standard
> ISA extensions that are being created compared to CPU errata, I don't
> think that I'm particularly worried about vendor specific stuff being
> the reason for infinite bits being needed either.

As the cpus evolve, it may have so many different bug. This is why I say
it may need infinite bits. In fact, it is just a extreme case.

> 
> If there do come to be issues with the number of extensions we care
> about, we could split things per vendor I suppose.
> 

Instead of reusing, it may be better to store them separately. But if
we store them separately, why not to use a different DT property to 
describe them? This is what I want to say.

> > IMHO, it may be better to use a new DT property like "riscv,cpu-errata" or
> > "<vendor>,cpu-errata". It can achieve almost everything like using pseudo
> > isa. And the only cost I think is a small amount code to parse this.
> 
> I suppose we could do that, but accounting for vendor specifics was one
> of the goals for the property I only just added and that I am suggesting
> to use here.



