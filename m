Return-Path: <linux-kernel+bounces-104392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAE387CD2F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 13:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B77B1F22623
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201481C29B;
	Fri, 15 Mar 2024 12:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ltbFv0wH"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2039.outbound.protection.outlook.com [40.92.23.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4695F1C683
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 12:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710505362; cv=fail; b=YeBIucgxCI/tB7WL16EC2XG/il77X7PR6ZnaOQwxRslPUVV9IuFZy6sKM0UsngRRH/FUam0z8cNP6ZdbWKM9Hp4b2XGtUAzyxVusuvKmJ9B0zhALxShj2ENdl/Jz7a32pbkeE9Jq3CgSdQvb1hD+kQKNmQP5oTl2KpoJZrlUyjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710505362; c=relaxed/simple;
	bh=xGgPRb8I97diytW4wj14AshxpHQgIQlHPUJogE2SOJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D35tEd38eA6TIV2WLDyZxFxePNQrGhmojOvAmntkMXx09wgspwZsammYfKLJSPxVkzh61DoYH1wkB7IO+CDK2PIJf9ezSYlYj8D+UtYD5jVNFQxnejIlgmDfaSUsoCiuCbdvstoOLSeZ0/ykR93q2YZaSWSWucBjTQsGjSUsXfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ltbFv0wH; arc=fail smtp.client-ip=40.92.23.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ADhYI8B40UpOF+qcxHXvLm8IP/xwHhQAs1XPeetWCmfR31aHnNC764+BXVDREM5ZMReMcuLCRLIZXG2q0MSttK5bEKDZ9LsppPPUX6FeR+j7A4o+yh37j0ysIOCwH4Jp4GOWQSNOy0tp/G/jQYmE1KdYWedRDyZ0cLbnUmZq/k01e4ABM1lHzp9z/aapXEtemLDZIi/JNCu47Z6v00rxdW/7sgW3sLRnAq0o7pW/xEv8eODI8Djc1sjCFQ6CZvhqLEx698lBVqCj5/7PW1DGu/G9U9e14eyLwwlc0uLrFrBwhmQii/IUOcne1x5GEa6WmAqBHgipvQrVqqQHHkYffw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KL1/YCrcCiKBzPJNjEotH9TTS26F+NyzVjOia2gaXtA=;
 b=MTm0F1rhQDRHrZsk9UWBd8uqeAzmG0vpRyVJzy8+sjBImj1jsvJcvc3bFuK7ij/EmUjxBzhpqu7Rwd2XmPRTqXOS1PWlRRMbhJFmHk/tCxW8aWEnvNzRUO6hyegYO9ACaDKoJJSGVdhb7LAzk2KS7BSSUE0TvMeMzUT8taRDesEpfaP5VwYdPTMVmd9ZF7mFVjAyKmmohh7mqk1iCi92qGeU6KMF++tI8ooWR/mGjfFfc5rzpv9N1KoHpKN/C3cjwzNDczICspjpSJvhTd54oqGGNW7Oz4lQvsuBlnRVJCV5bFvDSWBViZFAUvhHUe+bRn6VFxlaUoK3CyQuq0maQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KL1/YCrcCiKBzPJNjEotH9TTS26F+NyzVjOia2gaXtA=;
 b=ltbFv0wH6KkzU6AHKBCLzxpDyshVbdhdANzqX2iGB/3DSsc31Qm0vFFx960SLCTvtW4JyqCiVXS1KK16vcHspYgqik1/0KBVOGj22BS20WJTQcgECYcGwGHCiSBk72SKhdOmMtINA+Nper90yIUeACr/ZdKb+vmC1BuYwkWqSlh13rnHDkmRdNIRpirLuZMPaJKrbtiXOQCqvH98r4C2LjSrq7OoAvurTuYP5gP+v6ivH3tZ/CelaQR4+hl54cO/YMY4ubBmaDmABAKMwdrvSnbyuZwF7U516gGklb1yfEU70uEdCtXr5cPawD/jk3i/1/xiZ/U4KphoNC3DrJBfhQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by IA1PR20MB6294.namprd20.prod.outlook.com (2603:10b6:208:3da::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19; Fri, 15 Mar
 2024 12:22:37 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::8615:efe2:7c8e:2041]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::8615:efe2:7c8e:2041%3]) with mapi id 15.20.7386.021; Fri, 15 Mar 2024
 12:22:37 +0000
Date: Fri, 15 Mar 2024 20:22:28 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Andrew Jones <ajones@ventanamicro.com>, 
	Conor Dooley <conor@kernel.org>, Inochi Amaoto <inochiama@outlook.com>
Cc: Qingfang Deng <dqfext@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Atish Patra <atishp@atishpatra.org>, 
	Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] perf: RISC-V: fix IRQ detection on T-Head C908
Message-ID:
 <IA1PR20MB4953CEBE4CB6AC7238849353BB282@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <20240311063018.1886757-1-dqfext@gmail.com>
 <IA1PR20MB4953ECC3E32E95303872CD14BB242@IA1PR20MB4953.namprd20.prod.outlook.com>
 <CALW65jZ+q8sDiRKgsRL9n+939HNUCnkKuO=YJjHB5Js=WYQeOg@mail.gmail.com>
 <20240312-evil-resource-66370b68b9b4@spud>
 <IA1PR20MB4953CE8999960BA71B46DE6CBB2A2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20240315-73aa13079ef83a4559869084@orel>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315-73aa13079ef83a4559869084@orel>
X-TMN: [luJoTI9Wll7A67DupYznreITeqN4Oxum0TyNWhzGPf4=]
X-ClientProxiedBy: PU1PR06CA0014.apcprd06.prod.outlook.com
 (2603:1096:803:2a::26) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <atyytfowirlxbxx5tfpixtxrd6brjik3vmpluydkb56kb6ljfp@fublam4kjiog>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|IA1PR20MB6294:EE_
X-MS-Office365-Filtering-Correlation-Id: fcf6fb8b-9349-4cb4-0c9a-08dc44ea99d9
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UVqGat2G6i+jrjr4uTYUnueA3UyaQwPhiNZ2/+hTtlDBJfqhHPPdstZFVNqiJBG9mbqZIsZ8zGS20PwdqjGMidjKCdx8G/lSf/hL1+hAIo+WkX8K9rmaq3an3h0wd82k8Xw2NNq4jkTdsmf5xbqQryqOMq1kpqV00QuBdudw6hLabcyaX56vGQbknE0Wfoxad1QZehQApK1lojbTvfQ1z5EKFir3mLk322LR+Ajag0I4glPIW30lWPBlcCcqzTipVv+IW6da8RIKKuP7V98iYluuYOGnwb2Rm8x67qh7+XrCbebGOBx25NgdaF7fosTQpKxMul51AlnrV2ew0DQdc182HPZzerlzr/4g83zWrYUFzNQStzRNoToRTL4iSDcCZRikBOILwMTM9wy6LyZODwtK1UztIEM1oaGYKBvk/Mb56Spfd9VoC5u6qjOXJIsKc0gZUARdE96bYhZqzJs4ckTMtmZy8S2CgICKztvJJLp7XGILfN9/ysUajWnpLz+0I1VigF3bKCIUcQAWihK7arY/EyNaWuueUy8CU6O0WUyznB2EV9JG/IhG3b3XLl4VCgS4TutIoB4hI0mmoP37EXImNzoDMbxnhH7522buV04=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HtzU/ysfCNsuK4KaBn7KaXUmfjF2O3pYWDnf8rRYbVRxNsGyOW0adJrBaLpf?=
 =?us-ascii?Q?jAL4aXrRkGy1IJAx14kj+2cdTQ4ME/+3slSPzpVC/M89hGXx59HjAlpMvn8+?=
 =?us-ascii?Q?EAxHtjiMwVYOuPBH8atDZUDjPCI33TYGzgu2nvIeOOobtE9/yay2w+HqJx+f?=
 =?us-ascii?Q?tjW2p2iUwg2vBGu4XkzCGExSr5Y9Ba7qpPi0IEeXNbnz9Y0jzWZDc8/hfb8X?=
 =?us-ascii?Q?S9tEmaLRMpj6UFv6AWP2AKZWVr5RlviHvw3LX9HHPPAz5MfTkELe99xP8i8q?=
 =?us-ascii?Q?4yOyn8iCDOxaxQay7GpwiyI72vlctoIgPUqCGBGxiz4QWjA379VUznRkNDv0?=
 =?us-ascii?Q?rXUXO5G63CNFY2oliTmXcuaM3iu8sXMQRTRJMhB6alNW/9NnTBSfH6Nje+up?=
 =?us-ascii?Q?8t1gwuCwgDICEn6wypDccf2LeTlMUTJHA7saKB9BbYPn63zV7G3GUKHB2B/d?=
 =?us-ascii?Q?eH52R9195JCGtBvoIG2jBl9RBwx6qpYC4VDy/l60qUTKHHBpeRywsfXgIY12?=
 =?us-ascii?Q?3vjLzgPdMdMpQJjgZC9hT5hO3FRkXR9mN7lAtge2nU9rv1gnTiz90KhDKflG?=
 =?us-ascii?Q?Fg38t8WLN5xxB2WD8tH9OxQ+PRZZBsUfBHHho7NKzPdyPJskkXbw2ueL74/R?=
 =?us-ascii?Q?9XjwIAiMHpGWiINPsUXPeeaDRfEpnDKzqqCq6L/59Riug/juNjZVVQgvKWbg?=
 =?us-ascii?Q?8UJguVkC2QmhRCKjSiMJIt6f9EQjY2nej83ExFVRurIxWHYt4jOsC+joa9it?=
 =?us-ascii?Q?PdEXk2mvJ28fiyq4A5dFkNYG/A6aKj16wwTz+Gy4r4iHwS5y86gIA8aDCU3c?=
 =?us-ascii?Q?ekiNpKZ+Qjn+Y+w30t+D+UlvnZ4rTXaIUGp40hLvRcwg0QhAXphbY+3VLcfv?=
 =?us-ascii?Q?oT+UM/3Ly22P8hY0qPW/i6DlUxTckVxFP9t8XPe8ksdilwVfhbAltdabgTTR?=
 =?us-ascii?Q?dPXdUjEhLcxwW8Fu373RI8UlHw1KLeoQgQZpwKXd8UahaJlPcBVXeUHoK5rG?=
 =?us-ascii?Q?koeaO085PcoKcoDFOmqLUN4t5O/4A5qpWP5C3cOsCBbBqMQ5nhFl1sjZCNZg?=
 =?us-ascii?Q?lf/8MzDJPRGiPIpWbHxpZrzt/XZ8Yk2NSzGAb+XHEABWlXWBCjTchWboARO3?=
 =?us-ascii?Q?1vfCmy6Zi8XatT2CMfzAn1o3C/3MBuGpoL+Ep9beJDne/MLbKm9kQSBCy75q?=
 =?us-ascii?Q?DaOubXm4Hs/1Gh/ovGy8KvBAC1lMf0Enmp34jVj/K+qv7gZvg403rXTZLHJT?=
 =?us-ascii?Q?/d20Fv7pDF+tQgxzHiyU?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf6fb8b-9349-4cb4-0c9a-08dc44ea99d9
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 12:22:37.6823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR20MB6294

On Fri, Mar 15, 2024 at 09:11:35AM +0100, Andrew Jones wrote:
> On Wed, Mar 13, 2024 at 09:31:26AM +0800, Inochi Amaoto wrote:
> ...
> > IMHO, it may be better to use a new DT property like "riscv,cpu-errata" or
> > "<vendor>,cpu-errata". It can achieve almost everything like using pseudo
> > isa. And the only cost I think is a small amount code to parse this.
> >
> 
> What's the ACPI equivalent for this new DT property? If there isn't one,
> then the cost is also to introduce something to the ACPI spec and add the
> ACPI parsing code.
> 
> I'd much rather we call specified behaviors "extensions", whether they
> are vendor-specific or RVI standard, and then treat all extensions the
> same way in hardware descriptions and Linux. It'd also be best if errata
> in extension implementations were handled by replacing the extension in
> the hardware description with a new name which is specifically for the
> behavior Linux should expect. (Just because two extensions are almost the
> same doesn't mean we should say we have one and then have some second
> mechanism to say, "well, not really, instead of that, it's this". It's
> cleaner to just remove the extension it doesn't properly implement from
> its hardware description and create a name for the behavior it does have.)
> 
> Errata in behaviors which don't have extension names (are hopefully few)
> and are where mvendorid and friends would need to be checked, but then why
> not create a pseudo extension name, as Conor suggests, so the rest of
> Linux code can manage errata the same way it manages every other behavior?
> 

You are right, the errata have no difference from extension in real: they
both change the behaviors of processor. Meanwhile, the ACPI is the problem,
it is better to reuse existing property. At least for now, using pseudo
extension is OK for me.

> The growth rate of the ISA bitmap is worth thinking about, though, since
> we have several copies of it (at least one "all harts" bitmap, one bitmap
> for each hart, another one for each vcpu, and then there's nested virt...)
> We don't have enough extensions to worry about it now, but we can
> eventually try partitioning, using common maps for common bits, not
> storing bits which can be inferred from other bits, etc.
> 
> Thanks,
> drew

