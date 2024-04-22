Return-Path: <linux-kernel+bounces-154052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A7A8AD69E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B61E1C2112E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6B53D57A;
	Mon, 22 Apr 2024 21:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="C2h6pUry"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307912C695
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 21:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713821436; cv=fail; b=XkREDa1DsGfL/BxFQkJrwAdE+1gdLyNIIoAVA/+/IYDLNCPJ/RmbaR0Z1hNzFUOclIjqBT3MHYl/IqsfiTGspWURtL4khuqdw5uk3Vz07vvHtpGwXLNE4RniCkekd1O67PFuIlZ0ZnbLM3Z3jvubboDqGDsluocagzsOSHbsAkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713821436; c=relaxed/simple;
	bh=7UDdqPw15BEk2N364+ObbRo1p5o1cokyCFv9cjXGDPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FcYd7XMg7Sg4STa5ajCgSnIZqDPCtxwJg1SJHfThs+0jEb7kTW8fMAgjX0ZQiXF/2ibnxzNrquZvwhxiQCNI64CAX0DoaQ+z2d+RtqKCJc5XpYXIBvjq1SKiu6bp5og31MKDN10NpRrmYDCf8n+5s9OJX2uDL6tFEv7a5XRQGeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=C2h6pUry; arc=fail smtp.client-ip=40.107.244.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=drdMBRZpoSVw9yMBIRSKjTcqgCUDXeNkVKt1700Hq3rfPL48hFw0LchNAynyAo2NX/sXZe3Go8dCpXufsxhbYcAashlqE+mN6MVVBwt0gmxS5ebMYUu3NwA08TF0BbViY7IjU/Nms05FMxCoZTsqmwDGghE2FM+XNvzh68BQobXuDNW0TfM6f4qxg5EezwXDCeQtt0zLCaFtL8PHq+NsRKpN1gQhDsB52wL5DBgfdJk2wdrnlSq4aOm2KRUH8VaZzJeUCrZLUzeTeXu3IJOZ62i2SQLJsXlr/JnOLofMnEQ6Afzd1+4iaRrej2Vg+7BZ5DiQoqXngd7PPJ+UlbAyfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MG4zB0BO/+ivIUpJpA1iNMN1p8I1mw0nd+MyolbGJG4=;
 b=HAMRExevnpJLOagghLkB4/WQt6YraQTbdspy6EqtZt/+MP8N/C92gsrsI7THzKxl07shU68Rhur1bTy0Y95Nnc8dkP2sEAyqqoDwwhGgNKWNa2GfKOzGVBgy4DbHw5wnkxRq25QPQZ+p4lSt4z/3lHtZ0R/N1YYu3gFhg4XSpHYDsW9Anbffwf8XEaq4oG8O6C0oN7ypAhIMX5NXtLt07W0qO+n31Zu7ngmG4NBGA5bmTYhxdKn9HRCCGB0NxLaSgxocNpko6aaGl67IckeDT/2qlGy4O55Ci3Rmsn+sOG8N1EnEiRy0nJNXshIkSS59fouJi/GajCqPa5fWEds6CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MG4zB0BO/+ivIUpJpA1iNMN1p8I1mw0nd+MyolbGJG4=;
 b=C2h6pUry5JXq2mgF/c9EF190S/8kt7KYQWIMQSQfNkUMus4/AanogGiQHxmPApRpnW0btThO/RLr7KTOKx/zCxx0c1pTMG02crxZ9M3Z1SvRu/2IesTF8o6AqWAK6teb/rFfvUUJzu0DiUfkBQL+1LZOfOkr0u8F6ev1rmaY+14=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by IA1PR12MB6066.namprd12.prod.outlook.com (2603:10b6:208:3ee::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 21:30:31 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::7ecf:eda6:7dc7:119]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::7ecf:eda6:7dc7:119%7]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 21:30:31 +0000
Date: Mon, 22 Apr 2024 23:30:24 +0200
From: Robert Richter <rrichter@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-kernel@vger.kernel.org, jgross@suse.com, tglx@linutronix.de,
	x86@kernel.org, Kim Phillips <kim.phillips@amd.com>,
	Robert Richter <rric@kernel.org>
Subject: Re: [PATCH 2/4] perf/x86/ibs: Use CPUID region helper
Message-ID: <ZibW8D9-CTd8G-_v@rric.localdomain>
References: <20240403153508.7328E749@davehans-spike.ostc.intel.com>
 <20240403153511.75CB9DA0@davehans-spike.ostc.intel.com>
 <20240416151242.GGZh6VaiO2gC4ej2BT@fat_crate.local>
 <f142e9c4-4829-4ace-8757-485246ad3572@intel.com>
 <20240416174850.GEZh66AmnDjrLxoXaw@fat_crate.local>
 <ZiEMnWaHkn99_oyW@rric.localdomain>
 <20240422172055.GAZiacdxkQU0XAbybW@fat_crate.local>
 <ZibEFZ6DoxDeBxxp@rric.localdomain>
 <20240422204146.GCZibLiqZhbY1J4qFJ@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422204146.GCZibLiqZhbY1J4qFJ@fat_crate.local>
X-ClientProxiedBy: FR0P281CA0170.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::8) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|IA1PR12MB6066:EE_
X-MS-Office365-Filtering-Correlation-Id: 692366a6-b7d7-4a92-3664-08dc63136fc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2ddQne4SNssoCg/Rx0QGvjHXiZPP9jq32SKCRksFbZU2r/YDpqDiSxVaAdXf?=
 =?us-ascii?Q?LCczIQx1R7FzOOQ5ttWpk5JG4TOLbgJAfbT07fMpzmOGI+YaHUdVjmsS8sAX?=
 =?us-ascii?Q?OfO0x1btDtmO6K0ahZX20o1wSxajOKrEjt6nWZIydqXMuJ90tqyle9+34ut/?=
 =?us-ascii?Q?EeNg4EQc7o+21CDQE/VpnuDt4Ii+I2iEZ30KGwd3QXU6kDr2Y6IsK1JsTttF?=
 =?us-ascii?Q?4c8/sXtz2Au4a9rkxpI6/2vVZIWydEi7skqfyCOdRg7wyPyINshfIxL8xu0C?=
 =?us-ascii?Q?bTNBkpC6GnKqhjvuIduKgiEMoMUX/WY6kQ8p13XvvF0rWahvifHhIljHTFpN?=
 =?us-ascii?Q?tQQpgt4LRsaXETo+qGeml4eC5y0T2PrA84ghpfVqG30+w1v3/bt4rh69RrDO?=
 =?us-ascii?Q?1E1jVsgz9NFusXzsucz5NBF/u+F0+VU6Ni9gNI2OYaL6xqPn7X5nV04peH8U?=
 =?us-ascii?Q?FoSqnOEjBDuj8TJKvvshY8rsHXzqgItXjuAYwkcPTYeBWfMLCJkLNyrKAX+S?=
 =?us-ascii?Q?WlAAZIoHakqxLVwG235qdUGDgWwm1Kn8dxhS6y3vlVMX9sgZzPb3KwjjkjFo?=
 =?us-ascii?Q?fLUysnUnELyobSNDy17tT3R1p2WuNnEAUNMOvxYPlPd/5pdxlxhGsgKrA4hj?=
 =?us-ascii?Q?Ujjad/+BVnWzrDCCMfoPgB39rLqFvq8YRcQb8t58eJK+CQcVFHth7TsOuL2W?=
 =?us-ascii?Q?BEeThXIjzOBCCNjisyulaVgaVnf8L+Jr8znSASFSndGsIrSn3xscjicFjeOY?=
 =?us-ascii?Q?IOj8rFqmn+L1MIVfRRLqd5VepQpqaXaNQt2djew4RqYtzjt9xd3Q6FJi7yXW?=
 =?us-ascii?Q?/9vyRPXxQnHvlqA0sdWSxwcq12oaVGSnBgWhck67aMWl3rcvD+CFuc+pFgTr?=
 =?us-ascii?Q?Hhh9iErnqJJ0Lcc+sJim0DZlQOZuFdpp6nn1cD2GR/ncZGxJTtHoIgv7OmVK?=
 =?us-ascii?Q?A3ZNkjasr873tmji5O2ZTiQz2u8dy9YoUmiPb7xyRWzPnpP3SHeUoCmlK9qr?=
 =?us-ascii?Q?IEtbPRb8qdHoSXKd6YrtIO7IdjRAxf6fESvV1Gd28YXTJueoR6Up0jbuFW5w?=
 =?us-ascii?Q?GWi3x4XE+w4/HPNEgU3QNp0xs0qKeXieQOQAHx5GQ5u81rtzO58u9aQcUSVD?=
 =?us-ascii?Q?GEQPWbL1byyrqlPvZS/W3A6Ledo4vpKX85GM9Zml4aEtJb3t40eV3y2zt7Vu?=
 =?us-ascii?Q?zPrXLocGJ2YWn7UtZ7W75Invv9Wr/UgekljnPAY++EmaQvQp8ggj4NW81Y69?=
 =?us-ascii?Q?OQXBFhKVl35sZxL2QEs23tPsyifFk52c8/ZKEpQ7jA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GpJezcGzJiBEtMbFQxir7lESKEOv8EtdzXwcP1j08306C3XlsFj4p3dD15Nr?=
 =?us-ascii?Q?GMbv9nqpROe2/UG0R0SComcfmUtvJIDfHo761bThpkyuvfXacHohr/dpUsmx?=
 =?us-ascii?Q?8gxw8hy0VqpnoOVAYLjP/s4MDL3UdwaBCQPwU0FnjQOZzq9yT1D+USfGO7W9?=
 =?us-ascii?Q?HAukHETWZmUZwlf60j0SZ94QThHlRzePayxViy2utXVfPyc/lHAZmrvCHZkj?=
 =?us-ascii?Q?g8qoFYtH4vU0OBpT3FZHXBegD50udd6Fvp0rR9JJ6QvO2WtNNB3PB8SwbduS?=
 =?us-ascii?Q?uHdDxwfNhOc7drFu3eK9HgIbrbQbn0FaNyGfgbxupA5RZH20u7zg/aBe4nTK?=
 =?us-ascii?Q?r5S30+gnOSHmeMVLRZrvxin64dWuIca7jcYivikTyukFZ1PJiax89Q7HWpRm?=
 =?us-ascii?Q?oAxaylTbxz0wsqYTPNg533RMbch4ZwdawAHVC1dFGHFIVv1tqvOg3pSoUFVM?=
 =?us-ascii?Q?w/TqNKDFIPh9elFmSXQIg2Fw1XGzwqkMLMFgYeaSM/W2SCZpdOSYebGOXLyp?=
 =?us-ascii?Q?kOqugmikkC5C1nUs6BlfsrNNzyyzfx66AcvDJ1uPXSOWPJ8FHNtq/vOBlEZd?=
 =?us-ascii?Q?092VBfhheuXwQ0A2yaOBQufxkt0PJ7bATPBxBbFdxvgq1Xe+a+oraSWv3Oaq?=
 =?us-ascii?Q?GpBO4xK+Xyu0yv5BzX5KnMHK1yDazh8vc95Tx6Dn8kiND64f8PplEnIyuWy6?=
 =?us-ascii?Q?ndI5L8lMti6VEDpDR0GBMBJrqDYKPSmG4ajCEGhOm9KgGIOPg0PTTTaoaykd?=
 =?us-ascii?Q?SWKJhWUlpvCRB952l/r2B2R8WgZPZ9/wRpHwefvmDborq0ICktzKUA/4M0Cf?=
 =?us-ascii?Q?vPv6T5FSQp6D6Ryf+96UPrb/mhwthmRK0v8CqzhhrpfuDBhbMp6Z6BBLHiuZ?=
 =?us-ascii?Q?oYgaibQ0N9BYVXa0uX0EWJtEcMf9ioPsF8g2/olnXLN4R/DYtQE3BNohv0AC?=
 =?us-ascii?Q?Lu0y+gyzarR1pYAkXbaVz0oXEuSGWShtOAyw65WEmOS5l+THFuZ69XIjHTx8?=
 =?us-ascii?Q?Fn0APMcE+OlTinMjSLN2Sg8jioymnnq1ETVMkWjMC0NsHVoq5VQ91Z1dtwSM?=
 =?us-ascii?Q?NUd32BM+sNkxA6oTrVIeuhhqKjRdX4LZq0EOIJKzwKAptaBlYmIeZa8K+zAg?=
 =?us-ascii?Q?+JYbCGdNjXY5ECHKyGjjtlVIK2dwdaVSyCx+cNF2fc3jA+Jv7CD2npkSllmv?=
 =?us-ascii?Q?1OoWGEV3IEc7n0/CPktafjecOoI5AEjem8X8djrXE9MR5yRKfjMgWnHe56kU?=
 =?us-ascii?Q?WBCwyaEizQYm9MUbwbU8I9P2Z7HRGSUbzPTUWP/RGl/st6nYQfrBx8mKDpVj?=
 =?us-ascii?Q?NyJ/chXkIC19YhoLEn32G/ERts2fRHYPwxI+rLRP+iLbkb3q9LyaUAgopWkG?=
 =?us-ascii?Q?eiWm6qBAsBfcS0c7X85fqrUj2lNSe6hdiut53i7s2tV0cRK0hsToYL8nPGjG?=
 =?us-ascii?Q?3ouL7nmnvxwsxdpZSZ9pK2R32Q2UwbSYwuCE2WZ0dwkWrtMXh25ld9swydIu?=
 =?us-ascii?Q?Qa8h3oHW6biWBbhczDY/6FqpSPBtPMwiBVvIEkHsRt1nO9YOpJihNMdbohgt?=
 =?us-ascii?Q?6PTLxA0CbdjcsV1nkR4/6TgqtzGu2b8KLXASLROO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 692366a6-b7d7-4a92-3664-08dc63136fc1
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 21:30:31.1510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 47+UwBIKW1/ysjLvdc5LX+NjjPlvGctB3hbXGcClJi1XXuGLJ2lBvXa58MYAMRaCc5ExZkR3teyYnQuzRp/D1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6066

On 22.04.24 22:41:46, Borislav Petkov wrote:
> On Mon, Apr 22, 2024 at 10:09:57PM +0200, Robert Richter wrote:
> > Since we check get_cpuid_region_leaf()'s return code here we know if
> > the cpud leaf exists and return IBS_CAPS_DEFAULT if not. That would
> > not change the refB behaviour.
> 
> Yes.
> 
> > Though I think that case is rare or even not existing, I would just
> > keep the implementation like that and as it was for for years.
> 
> Yes.
> 
> > > > This slightly modifies the functionality so that 0 is return if
> > > > !IBS_CAPS_AVAIL (instead of IBS_CAPS_DEFAULT).
> > > 
> > > If !IBS_CAPS_AVAIL, then this is revB. But then you want to return
> > > IBS_CAPS_DEFAULT there.
> > 
> > No, on a rebB get_cpuid_region_leaf() would be false, meaning the
> > cpuid leaf is missing, function returns with IBS_CAPS_DEFAULT then.
> 
> So what functionality modification do you mean then?
> 
> When will IBS_CAPS_AVAIL be not set?

I mean the case where the cpuid leaf exists but IBS_CAPS_AVAIL is
clear. That could be possible with some cpuid override e.g. in virt
envs.

> 
> GH BKDG says about that bit:
> 
> "IBSFFV. IBS feature flags valid. Revision B = 0. Revision C = 1."
> 
> so that has been set ever since on >= revC.
> 
> And on revB we'll return IBS_CAPS_DEFAULT which has IBS_CAPS_AVAIL.

Yes, all this is correct.

> 
> IOW, I don't see how we'll return 0 if !IBS_CAPS_AVAIL because latter
> doesn't happen practically with that flow.

Not on real hardware and if future systems not decide to enable IBS
feature bit and clear IBS_CAPS_AVAIL, which could be a valid case IMO.

Thanks,

-Robert

> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

