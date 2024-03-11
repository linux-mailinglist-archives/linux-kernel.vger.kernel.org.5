Return-Path: <linux-kernel+bounces-98512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE673877B2C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 08:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36E651F216A2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 07:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26569101F7;
	Mon, 11 Mar 2024 07:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Mucoe9yf"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2060.outbound.protection.outlook.com [40.92.42.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA95FC1E
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 07:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710141216; cv=fail; b=lkaONkYSehuKn2GKQPCN4S3Mpb50bMn1OQj+Rp+f0Zs87jZaV0R8qbl/kZV0YlvBkuoy/JfvHUaRLU6VwTRaM0YM6w/Wxf4anfNRSLSGAiKVMXjm4+jH013bY37Ee/hzXYqR9pR6clILMTfGZcRaCa2VxXTr2/umBuJrGxFKFKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710141216; c=relaxed/simple;
	bh=oV1mPTjEYjtO6I9RlwSRtBFy9T3tpDNIYVm4+R/sMxg=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FkHXUChW96eT8QBIWSpOv/FRohgBFovOF9Kht1lZNiCZ3bj47EyYbQiptgmuxdH7gSKS4fN/yWaW0X7ulAVb3rMh3d8hc2yOuc5NNLNKSHTBLW/e/7oTIPIiJbJxDefvuv39i3bcNQ02Hx8hAnHAFnyxOxQAtgFSYg8uTqFX9Fo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Mucoe9yf; arc=fail smtp.client-ip=40.92.42.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lP3ipVEMhChn5JJzGE5sh+EvpvjrwrZZ88hXJ1G+kMs5bK2NoZwfOXMgyIaTogkZREnlFYaAjXx5NG97pE10aQvMC1+QlxKPbqsQ1SZQ19/Yek7hH5Wp/t9EFEj9CQovZPf4/ONr5JfUyijfB0v1W1tjNJihi9dxO4t02XLwpPZ1FdR7zJF5sq18vcAn114oWgPH8rDSvTYri87aJyouIEYxyLW+dZrPWQTShQu2H/jCD6p89dEd/2TaaHhMkwHqNzZwz3hCXMEhGvBOdB3I4HIqaBs78ASJJYcSh6VDuA8OlW8Cu77GhLE5vORjl8+X3rrWW1jwGlGuGQMM2eyGwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pSBcMRfjLpZZVeyLLe4cI/cFyNPhipGw7ebR7kJhXL0=;
 b=JvTyx9MG4hyI4sNY0jpSDNC4vTe/P1HwiGpQ1tkv6Nymm1smGYfMLHpO3C29qy9Oqkv2XUbcDZhV5fhht+uwmdC6wmx2iT9cyql1iQJ0x3vYEZWC4FvgqGBXy1dpjAh5euuB8EKCKpjmFc5I1b4QqMkxfl5/zMQgHNgQHkzDdhdTApScUSD7ximITjjIm2Ii44HcvoLAO0Sv0vCPoSWdgbIYuIPJn9ghUHn+sNQqGrudU+xv2yX4VgcAAg+D7Fux3mhm0gov8ZnU5MXL89aSu8DlJQXszpPI1WEvKCjQNrJV0g+bAFoVw1G7TD+bcDKUB16tnfeSEBO0MUA5s8Nwmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pSBcMRfjLpZZVeyLLe4cI/cFyNPhipGw7ebR7kJhXL0=;
 b=Mucoe9yfWIVa6bwFY92pGzJviK9w44S7APWAUbHl5+bsU8ZQCozVPoNBfP5AczFhWYKSTzjGJGSwty94suHWt1SLbOGFg07FesT7ZPwMo/TFfULNVZaZ0Wggw+DYUb803hfe7kkF3oA1dbGZoflafKevT4ENDVwyJdxahWTWYmX5Pv0YTDLwsYjXdWAOIAPAelW1HF7am0gdlVDjS2viYNsuZU2MDBzOAclMUzaMTg4DQ8e7OtbFb6CtyDeP853c17KpfArROzCeXMp++CvSwMRVNP2jqsFQCc6Nqr7N2XnorVAUYIUYZsXu/M1jgEwyb2SyUebUPbiqLWnjnZUy5Q==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SJ2PR20MB6117.namprd20.prod.outlook.com (2603:10b6:a03:4f3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 07:13:31 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::8615:efe2:7c8e:2041]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::8615:efe2:7c8e:2041%3]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 07:13:31 +0000
Date: Mon, 11 Mar 2024 15:13:25 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Qingfang Deng <dqfext@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Atish Patra <atishp@atishpatra.org>, 
	Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] perf: RISC-V: fix IRQ detection on T-Head C908
Message-ID:
 <IA1PR20MB4953ECC3E32E95303872CD14BB242@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <20240311063018.1886757-1-dqfext@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311063018.1886757-1-dqfext@gmail.com>
X-TMN: [mY5jkus9ThfQXVe5NQhDRk/JUFRXcXiMuyDr0xgSMhY=]
X-ClientProxiedBy: PU1PR06CA0021.apcprd06.prod.outlook.com
 (2603:1096:803:2a::33) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <bqysft5r2mjmd72lwz74nz2g6xxwxbyraov77zdlaig2kajwjg@zwufvlnoth4j>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SJ2PR20MB6117:EE_
X-MS-Office365-Filtering-Correlation-Id: 28daab4d-0e01-41bd-0eb6-08dc419ac18c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fT9itW3QoAywG+h7tl0MYPOxyKlWy//RKrJB+63Jza3oAxOmSi6c5GECg/CJ7Y6bp6VV32WKb/NjCTCw8vr4RwU5MpQuLY4E20tf8g5GIE7LT5nHZ3Zg9DuGyPcghtwRhmLu7sLgITu0F1cctVaUlppFXMQd2BGwQUPArY3PP1qfDj1woSgJsoW1Z5mzczYeDb0suWaHYtXywBJXnKtonojJ8tmBOLaRRXZ6UA/ZqBC1+xjPLOKsC/L66Va4W0udXVZ1hGI/+66N2e7mXsulp3Fv0/S7KvrNNRv4sC59i8FLHrgcKv0NOGYrBTbqF4nkitnFQ59dnaHcC04ajTwYkp/W08kf3rWFQbcj+l2tYbe0nNYlPPP9G7vzRI739ReCXgfT7ErR/M4sYY3R+haDxl2IiFqzpIYAUy3OBKV9aJd5trxJD248b9JCN0LK6NpsSSZp6uMAZABboDc3NYa+TOAq4NWPQh/pmN3VtHmiIa3Wu3Rlq4P2ZeLi03GW4G+PiFbHkDnVq+io2kCrEO/dFR1pQECtUpWoibyef23Iyf1PuJKWA2fBDUSb+a+yziskc82fVuy/8VF1m+LVSAUi8AvgKXiWvmW4cLZ4VkIoOyAuiCvo2didtDz1Djqh5aMqfr/2jM7VMW9WOUnQ3+XI9A+iiM2U62ntDKvTgPoa74o=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ieCbkiSHUyIaypTyQpc1qkmaTs3Z2o2A+itRE83GdvETCK5RNwdUUhzGQe3T?=
 =?us-ascii?Q?UE8jAQonj4CEvpnnXdQJJYIM6uu0VpOaGPBekL1ylT8MvT+7Mp67WF7ZHE4o?=
 =?us-ascii?Q?mAMQIP6nHh3o+bf+JFkSoedOTH1SnuUK4xtH0fcAFjx3rHhPoOtxLDxfZepZ?=
 =?us-ascii?Q?IEmaISgeeV70u7ba23PXCSUeNHQUNNauxQL0YlFLqvC7uklK5kLwcq38OAvT?=
 =?us-ascii?Q?8bFM8piWrowkq1reB3gE5WVdyDWXYYK7OlmTahiS0gx9mRE20v9m9lvqJc+u?=
 =?us-ascii?Q?dSG8KuO6rhYr3Bj0kfWLbKmXc0IfTJwE3W8A44V6vH8gXOPriT963tPtoZUB?=
 =?us-ascii?Q?16XxHzZpvuT4RStS2s6cMW/y2eMU9H8UBUUugQ2y7rmSb3srUwEmqWy6qpme?=
 =?us-ascii?Q?+1O08kn2rabXf8oxDLwhUHE3UhsuQaJPls597BP3Y9YMdF+rFuri/ha+PhJb?=
 =?us-ascii?Q?Ugja2zI0xM3f93fpJu9U+1xTrvKTogVptjIDG/lj8DYLV3Vek2ZajvI93G1H?=
 =?us-ascii?Q?HIDGrN2UHk+ea8UOXTH44rdsOMSQDmUr6vcrSMeHimHWiRG18Ejm0e+tirhR?=
 =?us-ascii?Q?otSZXN6vEPBZr5q9XRf2URusCPOWyapFVSgIH4G4IIfvDUoa45F3aUpTzIsE?=
 =?us-ascii?Q?7HG6gO8+pMwZNtTfC1Ij9FhbTcJXLZR5prKF1BMucnu7JE5SGQMyVnmal299?=
 =?us-ascii?Q?vbiVNTKlnJL1REvJywMiljj2WeNnjGmrJApedKdNVZnRo1LNWbjCm0iKPtzg?=
 =?us-ascii?Q?6JpjeU+PhuBRjs+adwvW3z5twLzBRFnjQM1BM0cERkKl6vciAsrYQPAL2GVV?=
 =?us-ascii?Q?EDI/mWn69+S6B7X3lQ+DhvMW3B0Kx7yYZltZZu0orHusyHxPVmcN1i3ATKPX?=
 =?us-ascii?Q?jCNMaYuOabkNRXKXF4bhW7wyZYLl79a5xmgc+48i4o8jpKnusfraqY9s94Gf?=
 =?us-ascii?Q?VgwsEtKoOLflDprhr6KrHOo2Ss8qagHOCb5Hx+9IoGOKM57cSoaXm2Te6A46?=
 =?us-ascii?Q?1XVLgnXuyoBdrG+yPc8Cg/Fx3Tb+a9yM19RbOGN3VG2FRcLTz1fVVIVjGTcs?=
 =?us-ascii?Q?46jNEmiWzRoQGg3/HenHawUWLnvdlTcldmAtmaWKY+YsDHGR2ZF8HAhxCjvr?=
 =?us-ascii?Q?0x7gJGk6WM6uo8cxOZgWU4AXTkyIUaulfcLluBUhPbZXqko/em72bcgyDjkY?=
 =?us-ascii?Q?HTZSV5OiuCZQJMKvq6X4/gRU/X1JcDZRYmeq1gpZQZ+/YuiBh1Ysu7natffX?=
 =?us-ascii?Q?r2aDkpxgZUdzd6R/UGJy?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28daab4d-0e01-41bd-0eb6-08dc419ac18c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 07:13:31.4114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR20MB6117

On Mon, Mar 11, 2024 at 02:30:18PM +0800, Qingfang Deng wrote:
> T-Head C908 has the same IRQ num and CSR as previous C9xx cores, but
> reports non-zero marchid and mimpid. Remove the ID checks.
> 

Hi, Qingfang,

IIRC, the existed C908 SoC (such as K230) have an early version 
of C908 core. But C908 core itself may support Sscofpmf.
So I do not think removing the ID checks is a good idea. Instead, 
I suggest adding CPUID of your SoC to this check.

Regards,
Inochi

> Fixes: 65e9fb081877 ("drivers/perf: riscv_pmu_sbi: add support for PMU variant on T-Head C9xx cores")
> Signed-off-by: Qingfang Deng <dqfext@gmail.com>
> ---
>  arch/riscv/errata/thead/errata.c | 4 ----
>  drivers/perf/riscv_pmu_sbi.c     | 4 +---
>  2 files changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
> index b1c410bbc1ae..49ccad5b21bb 100644
> --- a/arch/riscv/errata/thead/errata.c
> +++ b/arch/riscv/errata/thead/errata.c
> @@ -125,10 +125,6 @@ static bool errata_probe_pmu(unsigned int stage,
>  	if (!IS_ENABLED(CONFIG_ERRATA_THEAD_PMU))
>  		return false;
>  
> -	/* target-c9xx cores report arch_id and impid as 0 */
> -	if (arch_id != 0 || impid != 0)
> -		return false;
> -
>  	if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
>  		return false;
>  
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 452aab49db1e..87b83184383a 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -811,9 +811,7 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu, struct platform_device *pde
>  		riscv_pmu_irq_num = RV_IRQ_PMU;
>  		riscv_pmu_use_irq = true;
>  	} else if (IS_ENABLED(CONFIG_ERRATA_THEAD_PMU) &&
> -		   riscv_cached_mvendorid(0) == THEAD_VENDOR_ID &&
> -		   riscv_cached_marchid(0) == 0 &&
> -		   riscv_cached_mimpid(0) == 0) {
> +		   riscv_cached_mvendorid(0) == THEAD_VENDOR_ID) {
>  		riscv_pmu_irq_num = THEAD_C9XX_RV_IRQ_PMU;
>  		riscv_pmu_use_irq = true;
>  	}
> -- 
> 2.34.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

