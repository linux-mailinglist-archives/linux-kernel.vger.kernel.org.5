Return-Path: <linux-kernel+bounces-136060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F0E89CF9A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 207751C2233F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 01:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60235684;
	Tue,  9 Apr 2024 01:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="jtFaQFux"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2122.outbound.protection.outlook.com [40.107.244.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1301723A6
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 01:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712624876; cv=fail; b=IdHkPUhxl+IFzjOsk1eF38pIVEL6gNZx45vmTs0DyEWXzlurpjqUz70aSuHI4nL6NLTQNh3A5Bhbzi8A63q9T28R379n4VUVYMB2j4cYsdDEc3ckLDQFsqirSlSipMnherYxi+sVfd39HCsm+kqSjQwTBvrkRSCHBz0qD24g4ik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712624876; c=relaxed/simple;
	bh=4ZfZC77Bypg1BIA+O1ecEzEHFbQEipkmlzG+gDCOwdc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=oRzXLb1IpafdtEmiLC7nZ2xvth8jshcEopKFLbv/wLEzlP0UKqlSSUknJH/S74i5PxTOhXDY/yiCT7mFVTzrVameMdTFzqfedzMEwuawnTPtFWe2yuEn7DIFjFmvigTsTgJx9N0VuS7UilqJ9VfCnG/tzHIy4jjrGMHjlnlx9Gw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=jtFaQFux; arc=fail smtp.client-ip=40.107.244.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YIHScsij64bTvz57VTlEWbi4TZuvka9QXoNTNp8yywAy2ibVXHo/2naRJEINLO41toB6+jqYihAxzrIsWkLPtEySXkuUYBUu++VftiQQej80ZN5wu6vL2SRZJpXc+1kFd9UyAwjRIqKpuW8fxM7mkvRze4JbXtp/eevjMmoOtTpKqcY8E8p558b0FH27Fhf5vqTaKtNOGgjq3Bnd/GCvGtzJ4kC3Gokzr1r2kJgPFS+HQcjx8mO0hWgJtnKNpoesS1p6PQmhUFeg8wiSpVoga+YVkBQ2oV204VXbsYuQCngsdq9qsmXxtdIKKwIH7r1BgZCkPwpwGdtzvZE1QO92aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9RgdZEIX9OYQcLLh/b9F7moNh8nL1qwMsQACgykhDcQ=;
 b=bKa2trcfsGLNfI26U/os6DmEoiolYvpiSEu+oM7wjEvZfH1fHkEnjj3HzqEDbnhWPQF63Ja0t/VpS6/c/Io/aqIc8HR28omt1A9IlErbtgDOZVuP+36SbJhl4Ziz5+MIzWm3RIJAPWKYUkzLsJX/7haO3IxlZtvCrnbHonFK4+nfuSZyLTd/+cdj8DjjEXoj2lplTpKt1ENcvByT3aY2NaHjApKotcHzy1M5my4S5x7xXLH78B7FZnihjP2nnhOvfC+n9uCRQGfR7adk/1+t+vmh/bY6NfXvPeehsaQpuhlhwP99o3KvxXqVMIkaj4WAenacwgJWIhLj0+PvTd2UDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9RgdZEIX9OYQcLLh/b9F7moNh8nL1qwMsQACgykhDcQ=;
 b=jtFaQFux9ZX1ZoI7fbNdhr8bSx2Xvnq3nGPBSDJzWE/fRXrKX2s4PixBczIJLXQ3gNfqhCQcCINaYEfOsx4jS1YsFmEFhOYG7b9CXBDnumEbzIjCi5vpDCDjqv6DJlC6Ectgo86jRsEXDIahEAVwfwr5JuAPGBuDk9NWB05kmDY=
Received: from BL0PR01MB4226.prod.exchangelabs.com (2603:10b6:208:49::30) by
 BL3PR01MB7097.prod.exchangelabs.com (2603:10b6:208:34c::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.55; Tue, 9 Apr 2024 01:07:51 +0000
Received: from BL0PR01MB4226.prod.exchangelabs.com
 ([fe80::12be:916:b914:8b26]) by BL0PR01MB4226.prod.exchangelabs.com
 ([fe80::12be:916:b914:8b26%7]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 01:07:51 +0000
Date: Mon, 8 Apr 2024 18:05:11 -0700 (PDT)
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Robin Murphy <robin.murphy@arm.com>
cc: Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
    Besar Wicaksono <bwicaksono@nvidia.com>, 
    Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>, 
    Mark Rutland <mark.rutland@arm.com>, Raag Jadav <raag.jadav@intel.com>, 
    linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: arm_cspmu: Don't touch interrupt registers if no
 interrupt was assigned
In-Reply-To: <c2e3e77c-ba50-4228-9eb8-c8fbcc84edfb@arm.com>
Message-ID: <8fdfceb2-90b3-a1a9-fa88-a45ece30c0bb@os.amperecomputing.com>
References: <20240307193104.58302-1-ilkka@os.amperecomputing.com> <042bbb32-481e-40d8-a46a-472b724ec33f@arm.com> <89d7ff41-ce2a-fd95-ebfc-4df914efd4c8@os.amperecomputing.com> <c2e3e77c-ba50-4228-9eb8-c8fbcc84edfb@arm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: CH0PR04CA0058.namprd04.prod.outlook.com
 (2603:10b6:610:77::33) To BL0PR01MB4226.prod.exchangelabs.com
 (2603:10b6:208:49::30)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR01MB4226:EE_|BL3PR01MB7097:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+gvBsJ55ZEM3u361NZBfVjYmr5s4La07yITD4OMMNby/OvoqChXBEbrgZLFeXgeN8RyBw4hJTq2n+UOtaPl5v0h4w4QK2YF41W0zfRwRbGC4TnH/3Yp4EDfaiW0DNnArYw7k7icNSl41aOem6KMNuRQhfsc9SguLQOv/IQ4bINwcdPN/dk5xIPDTZI+kk5rdKiQGq7+HB4nERFxjv4+N5yiWDqFyA3KTXmJmv2lo0+7zBxcYNpH3NVZ+kEx6+h11F7dZ244+wVH9j5u8e3HVLmVUmMC9NghDeCPWmi4VY5IAx+6TsN5RwBOCqzh2b3S2M3o1KcICiH6sh7K1z2L6iJzanlVkqyn36wBI+h2PS35+bzBIxBZM5fx3blW3I0TfB21qFHJ4iE8/VKarcdXTo2/D1IlFuMxSE4txi8nv7wPKpMZxmOopQqgdWI9oAzD7w4TRS9M1opp2M99gcWQnrbwaIg5rsqQccRzT3vojusnmsK5PIO3xMWLP199pTXwltOO0evHt0IMJZII4wBuYrSLA3iU/f2eS8YOIjn9WhgQNamrE2Tl8VfqPM9JfN4XhGWLOyHrF+xQQ3mEFh+Ool7wDEwX3xkO3o8HkMLhf/xl3zuZ8yGRTMpkt/RZh7o2K/QfES3ZqttlLGbE2rx4rvXyEPExUFR+MuRc7zPMYuUdovo/9MdrjPUmdZJLyLsyg4p7IgeTT/bMbJo6/cAByT/uoyzuzI8oh/dgTtFy2/S4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR01MB4226.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M6Sa5ivnL7Iv123yk2mm5nhz2xtiLxZtTzdC1B9JdCNdGquC9+cQIst2ZRhN?=
 =?us-ascii?Q?YyPWLTkjgdgPUbaMvr7pQVi8LVdBuEM2tSI5hyQfQfrmOlmetbHqpd3hAYdp?=
 =?us-ascii?Q?MSdUfhNN+RIWO8mrI5PztMFGiWmenvaj6C+3+vRkKlgJrxMAc1qoHkm0NPIY?=
 =?us-ascii?Q?34l0Evkentrns05EKojabmHiStqLzWKkaCW10fcClajtDPDzxtV8bE5XWDsW?=
 =?us-ascii?Q?VNtj2moLbq4r4UOTGH5XJOjEboF6sbY0HRvmLuXKfJMIp5g2lhwciW3gf6Q4?=
 =?us-ascii?Q?XuT3gJ7k0U6c+cDJCjc9uMbRElnPDz94qCm5/QYmET/HejjrxkXjXYUNpIb0?=
 =?us-ascii?Q?9/QKjJ2YZjUxaCW7Xa8+Z/M/E3Ydn/jx6vo8H7LOzU9DRCJ49/hHh/iXd5Qs?=
 =?us-ascii?Q?DWIgpBkgKeJTf20BhGEWvXsfWV46GnkiRfk2ciMTzwAeCu2EquH//UB5fxcf?=
 =?us-ascii?Q?BnpMffYItBi/e3U2ZoBeLpjoTkOUIsFJHIJ4un6qu0Z5tQe1SzJPnrcvd0LI?=
 =?us-ascii?Q?QwNQAYOAqTB1rlg1GjxQ9F90LmIXzYjTkwfH37muauOeTqBure2f1Sq91xJq?=
 =?us-ascii?Q?5iCmrHU1yb5VvQ15A5Np6hi8vJThBpCEGS0Ru+7HnQ3aiABQDp2N6cbA6xxH?=
 =?us-ascii?Q?ZM39LI05PSojE+D/32DJfJDxO18V4DeH+3BMBgGMtNKT8yhsLDvkO8oM0FQO?=
 =?us-ascii?Q?kKpx4u6pFZ+UhQkBYqF661Et6O4KFmt1IoX3EgYbRYnPnEq4xPwMBzEB+BtM?=
 =?us-ascii?Q?ndVJB9RJtvQEZkuIbOnpoaxmWwDHDCB7W2dYSWXnjrwrVfyYEGd5wHfpHxyI?=
 =?us-ascii?Q?9oGsge7PsgLBHTANuK5/bFjtDzg+/33K2QvtF+0tDYtP+LB/k11baRPYy4Gf?=
 =?us-ascii?Q?InGfhm4lzGX/oyoM4NrES9ox1Qc1dglHBb1LN/aHAPO5OpIC1llXWFC0UaJt?=
 =?us-ascii?Q?a6HSs0HuWAojp7s2cpH+OLuhDtwJ4CI/cRkPvnMpvhnp3MPMT7aZ+MIjk6Mk?=
 =?us-ascii?Q?Xj7KoqrtsfvHgimYw+svrhIfVw/hlLL6P5NhheMOzq7O57Ev9eYNaolN1tBu?=
 =?us-ascii?Q?hxJwlwBOqPik6dLlndlvN+3rI1sfXGytBLemwxsVEnKXbao9hO2nr+xsTjit?=
 =?us-ascii?Q?2axCOC+28pwL4HaisREcYmGLv0OmLAYahC4TrRDsEkSgzi18unSAcZPCC1kG?=
 =?us-ascii?Q?TG8w/Qt8GBoKJzjoqB1NMVu9RBaNjD6HVkmNPperti+GJ4K44UMEtb9/sgng?=
 =?us-ascii?Q?65CwDRchQzEvXMkl1JtHAMe9BeDFQccOpG3S0ct/81y+ok0kAYSpmjvx5B/1?=
 =?us-ascii?Q?RVNv5IRpaow1F4ZQtgjliO606I6AJUkhJVD22nq+og3FkVR5vmLSFPvCNzSq?=
 =?us-ascii?Q?X+fKcmG6IR94k0gDevcm1K4vnJzFQM0Ejh9UWBHDG5FqzOhrI6Xw8vbaSJ7I?=
 =?us-ascii?Q?43PH3x2NX9jkuM5iEGN9/H8UtpUCz0+kTunqHuBaeCAoFX55guPXg7g+LnQg?=
 =?us-ascii?Q?xH+102m5MunYM/8fUHGUq4ccrHjemeKYboKXlrtWoPQAT3AdK+MtfD0aEXtf?=
 =?us-ascii?Q?vk6KjJxFdZmcRDiBa+8eARzzCIlmGu56yzjxbHMhCmqKgK/8CQEzvf3qeu50?=
 =?us-ascii?Q?YYwtHuor2v0NmT7HcVpWBTo=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19bee514-562c-4e41-ab4f-08dc58317a88
X-MS-Exchange-CrossTenant-AuthSource: BL0PR01MB4226.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 01:07:51.3313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qmo4co6KoHH9ztIy+f0VixdnvJkUKFR7l506a3SHlIDPP5Fsvk5C6X+e1BIaFk5fA2mMUMhUEgH7Pl5AvIhEiwcMgSypZMFAQQLVCiWDFnv1BiBLksUuM1XpXGFBGGNN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR01MB7097


On Mon, 8 Apr 2024, Robin Murphy wrote:
> On 2024-04-05 11:33 pm, Ilkka Koskinen wrote:
>> 
>> On Fri, 5 Apr 2024, Robin Murphy wrote:
>>> On 2024-03-07 7:31 pm, Ilkka Koskinen wrote:
>>>> The driver enabled and disabled interrupts even if no interrupt was
>>>> assigned to the device.
>>> 
>>> Why's that a concern - if the interrupt isn't routed anywhere, surely it 
>>> makes no difference what happens at the source end?
>> 
>> The issue is that we have two PMUs attached to the same interrupt line.
>> Unfortunately, I just don't seem to find time to add support for shared 
>> interrupts to the cspmu driver. Meanwhile, I assigned the interrupt to one 
>> of the PMUs while the other one has zero in the APMT table.
>
> I suspected something like that ;)
>
>> Without the patch, I can trigger "ghost interrupt" in the latter PMU.
>
> An occasional spurious interrupt should be no big deal. If it ends up as a 
> screaming spurious interrupt because we never handle the overflow condition 
> on the "other" PMU, then what matters most is that we never handle the 
> overflow, thus the "other" PMU is still useless since you can't assume the 
> user is going to read it frequently enough to avoid losing information and 
> getting nonsense counts back. So this hack really isn't a viable solution for 
> anything.

IIRC, what happens is that kernel will disable the interrupt eventually 
due to unhandled spurious interrupts making the "working" PMU also 
useless.

Cheers, Ilkka

>
> Thanks,
> Robin.
>

