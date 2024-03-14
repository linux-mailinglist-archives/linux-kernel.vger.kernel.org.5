Return-Path: <linux-kernel+bounces-103070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DA487BAA1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BAF81F21C10
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C076CDDB;
	Thu, 14 Mar 2024 09:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ut6TezRv"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2063.outbound.protection.outlook.com [40.107.96.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98665692FC;
	Thu, 14 Mar 2024 09:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710409414; cv=fail; b=GcE/z0FswEkunbKzAVglO6OVvI+7VfM5wF1wMxWSUizzYLk9mhhGIuN7iXdpbcG7GNYQb7mNmTpIeEw303yGmF8Nt0xGeZ+blwv2r4WpO7AMeAqp+nCRJD9aWysocXmPBSDvCSj4cmlwO814LO4k6GRRw8DjSlq8ltIJHLVrvpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710409414; c=relaxed/simple;
	bh=ITqRfhVvtYC5Ki+rbIEmpAVJRz3HK3x2eg8wrCjvHiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EKBTTI7HOBNDKD7qpga1h6fMvYvYeZRZcWW6k7pEnat1eCdoJzjR8G+5upwxQU53eaiiGlJ1TyrTc0OwtGwrEl7iQYROZgkWNDdDUsurxoqEywlYZwM0vjTc7LV+RK/GVTuH5W6WIAN6oaeivJx1LpsJOJpmU1+HkVgiJFIkKuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ut6TezRv; arc=fail smtp.client-ip=40.107.96.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pl6sVu2XATW6LuewFI/bzNqdRkpOe/6VZqX2y9kVu/Cj2bRTOngdiDJ9OBN0PYiwQg+pOjZ2xJJ4PMt32YJMVLoqH+pUwCzUExhSxodIFWC2eXpZ8e0Lab2dBEUURcR/7U5l4MDUDFbUb+eS2bUPESXrof2BSdE5Z5H1rhDWXvlIN8MtOuJTAkpQmGNdg+R8oS1LkCJa6kXyKEmxByUGfXfCrcdZnJuF0PL6dd2VZt/+rWgK7QBRgRzai0qlJc0Ep0ceDQLcU2pJTo5WIhZf9XnwjWU1y+oWfbse4UR+DBO2w3UaNwCMQLdpHitqg210i58joG2UTy5gHqtkE3BlMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kL6mC/W6qAvWgY0xmsWUtqX3pKLEtSp/VEWTA7gYZao=;
 b=UdVfbJqQlinc3NhiKMWbpK5BseqV3W7b/uK7AhvPId0wan8zCTqCsZ3Zyq1yfZvsCThUSwYsSYjVcAstb5MsBY+skzOYW86RIZqo+KpiIrO7DQRuSddg18BbXJ6U7EU7Sl5WQ8WSsAuD2lfgkGxaxTFRyD2wPU1jPOwZGKAhILrpoXtzMjoveos8qastBhMmiORgq4pFeg+vuZ21obtZQVrqSjpE+8iuxWYwWJ4L7IGskF4+72MUTuMmW2l3wiLIpvv7aYmQKqFyWiRcs+y1SbGeuSIHHIKvmB8ELKYoxDD+VKgMzIera61j9yfPzFDoTla58B0/oOTJHRszMgf9dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kL6mC/W6qAvWgY0xmsWUtqX3pKLEtSp/VEWTA7gYZao=;
 b=Ut6TezRvDhvbi5gQQbX1lPp52HMfHX0n4Rle4iXIC6z6LsiBUfCdFpUov+yEQ+h0XQYTe24ybnE0aQfd2A3QtM/TfDICRWdTDI11SBQvruByGkub+vMWpya08wWjBQWd6sWnTiEK5zjOJb0iRL0ME4cmu1U0UMBX2qjBHFpUu6c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 PH7PR12MB7162.namprd12.prod.outlook.com (2603:10b6:510:201::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Thu, 14 Mar
 2024 09:43:30 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::d725:ec0f:5755:769b]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::d725:ec0f:5755:769b%3]) with mapi id 15.20.7362.035; Thu, 14 Mar 2024
 09:43:30 +0000
Date: Thu, 14 Mar 2024 15:13:21 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Perry Yuan <perry.yuan@amd.com>
Cc: rafael.j.wysocki@intel.com, Mario.Limonciello@amd.com,
	viresh.kumar@linaro.org, Ray.Huang@amd.com, Borislav.Petkov@amd.com,
	Alexander.Deucher@amd.com, Xinmei.Huang@amd.com,
	Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/7] cpufreq: amd-pstate: fix max_perf calculation for
 amd_get_max_freq()
Message-ID: <ZfLGuSzbTS9vSGfY@BLR-5CG11610CF.amd.com>
References: <cover.1710322310.git.perry.yuan@amd.com>
 <1da9848e022c49fef0a8cc390feba95c74be531d.1710322310.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1da9848e022c49fef0a8cc390feba95c74be531d.1710322310.git.perry.yuan@amd.com>
X-ClientProxiedBy: PN3PR01CA0131.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::18) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|PH7PR12MB7162:EE_
X-MS-Office365-Filtering-Correlation-Id: 15ae1c5d-46e9-4176-6c3a-08dc440b34b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AjygEAjrO5WwLBP0B4WZZ4EDxorj2E+BuYAwLAfDmKA7f0NR1KEaOlaVQyRxyBsrbiw8cNZXUYBmeXJ99zd3jZgGTe6W1sWwxrR3qlPf97MzxsHSHQOtw1girxN2+kXhNknuCRLDLpMeI7vgMJwMU/NdCjth1SAsdh+FxjpA0dg+SVDwiWHxIAS9q7pG9co20w4zFgbsPepNH9cS4nDhWklZVgBqpsAd+rDHXwRF/OpGV193nFENGeYq0hAonjdtwl9dk7YOskJfCa4D4eAS2MD9U0KvGM16/NTHKfAwH+2qnlv9p1+j+C0SJ0LUV8GgzTlTZoXEsy1yqqP+SAq7WllrOAId61SSu/B4HG+DoCjsIM0yfmhdqEFU69ytx/AOIJ80dECdNFCga3L4YYm+aIQtKZmIM0eYkXSK5sINPfsz/FaWkh5JTx98Xkaf3491zPD158juKaUWcoh27f/N55Pdl9cQEhsJr4wY7LdeuJpLMdRJGnQEgdujTGK6niOID2S0OQwkEMGsF1Q/SPg9OqXIMRQBVbNNJoQwqhW9YKYXdlr1h/JhAgqtKMwyxqyx1CmbsGENYBzL9BoVMPAWsyXaloJeCL5XBLcmz577vHJcoSyUlNYhDGTNqBPuTyaa80zBfJBeIZrnydOHW/ybrUE5FV9IPGVdNiUM0oPvAg8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/KYHAlGGoK+UophIbpdQXqPEpQcp6U8qNsLF1ChI/Pbw0CdlDJJsHYcnk0GR?=
 =?us-ascii?Q?MbZACmSiBgYr4Vl+GIh4r0B0eUxXxaroH/gbU/jSY15D8y2OP+dAqYvb2ZG2?=
 =?us-ascii?Q?4oRoAi4gNzu37i3E9t+YKbMiGd+2ZqI3l3SAf/d5b+Yd7BM2VTzT1OXWdEyN?=
 =?us-ascii?Q?P3TKfblqm+TGpu3s8rAeAzsf+b8ZpolFuXtfGb6EfJl9mjau6xnlpyBuZ8Hg?=
 =?us-ascii?Q?UM9UvC65DOvWMPlP7PoeBMOHZ1D1rHfcRJxe+pv0HDfbHXAf9AKH8sxG8Ztl?=
 =?us-ascii?Q?vUsN59BKhh4mRS/DKtkV0u7gnM7YdmNySQ18NI1jhri32665IWCtYFRwvm8o?=
 =?us-ascii?Q?Vm4KLFR34ensh5b0qzXYayMO5ygob8JXzkERaQ/BRO1X2S84tmN27sJsli05?=
 =?us-ascii?Q?5yygq29kC6hSdn+gYxLJuZP0uVW9hyhZtd6BEp/cc58MbfAMY434M8BZ4SyE?=
 =?us-ascii?Q?Dd5+e4FC0OO3q7HPD7Gw0kGSyntir4u7bYnoNyZmsvebwEw9+RFvqGAD1Ex1?=
 =?us-ascii?Q?tWT10w+81V177bkppLB1J5lbPAScQb2R3GREeWVsC7t90Yup6jHhi1sZXYuc?=
 =?us-ascii?Q?gpXAj0xisoRxddVab9lLO47DmBHR91r+X0XFu+MgDolv0kJxFJkAzcUfniFQ?=
 =?us-ascii?Q?gT5/1sBVm1f7sFJewQP5NrzjWO8zOAgFFs1n+9QUcoxb3tVUofyc1znMY6ah?=
 =?us-ascii?Q?exIP1tf0IQjkoi85Bol8EI98lSmlQs6pOzWNU+LozKhO95ZK27DE52cCYk//?=
 =?us-ascii?Q?AgfEmDY/9k42haUPyc26RUJOzK4mUJxxOPJN4LVmnoBvJnQV9ReZbfOKZ6P5?=
 =?us-ascii?Q?I8cGzKhq78Wt/89JJgc1ztEZkjXOw0vh5/6yF513PqXyC2n8GgbqMg+atWM7?=
 =?us-ascii?Q?/gYtBgKDI3jdX9wlf/llIXCveOZKQPjUeMJHq/VgXe1wWV80QCemUN37KtM4?=
 =?us-ascii?Q?sMfi2MuNogXChoxb91OsfIfJ7k8df5tzXTcyLShZjATg5HFHX9XY8kzyj8jr?=
 =?us-ascii?Q?Lu8E5+u/PDM/cV0ztlskrAUi91xRIp9VmNK9c/iQ/H2FJ82OnDUPwntR4hSp?=
 =?us-ascii?Q?Q7j+xPIz/Yoqe0k0LsqFzj+OHKenXPDpUxPtWuo18sr1l8dHRTH0Jax1/CQ2?=
 =?us-ascii?Q?9Va9yvknOIcUmG68uvD4WxnlpowSk4DrwINJe4nLUO146tUnpi5RCf2zN6bu?=
 =?us-ascii?Q?ndkYvWyerbJlq1QhUJ59Nt7g/zZBtujZquv8cyII+3o4Vphwy/0VW/pdYMPf?=
 =?us-ascii?Q?1Vxieb0/ci17QkkhXSLdOpg1pshuNtq88hetr15TnM7jLyp5ZB46ZdcFg+8Q?=
 =?us-ascii?Q?vtCOv2fu3L/STQeBpv3JGIptcK93z3l8amYYTXZFFkRlfCV4Vw7BItXNeMKO?=
 =?us-ascii?Q?+5c6zvzVUpyUldfn0KVbDGSSpkO5vZ3nbdPWEjMycLJoGNdO8a3RI8A8WJuO?=
 =?us-ascii?Q?EHVx4zC3/L4v1WH7o2idqjZDIrdIgVEPQCnCaUX5V0ciirYJjdxFXhjbXXuv?=
 =?us-ascii?Q?JNs0hpNmAYH+afWUs01lvpgmd6TkM8eTfiDCcS4dIXGUeuBqL5sI8kQitUy1?=
 =?us-ascii?Q?6/XpQRZUEXceNSdpu3mIxzqpEa/Bu2UGefuAv6ys?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15ae1c5d-46e9-4176-6c3a-08dc440b34b9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 09:43:30.0751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ipiba/PgVDpZ8vC/SYbovogc3Co3qvuE33ZDV7niW2tLpobTwA7QfWBpIHN4W0/+kEt8DC+Nx5dI31JJs4eagA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7162

On Wed, Mar 13, 2024 at 06:04:40PM +0800, Perry Yuan wrote:
> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> When CPU core Precision Boost state changed, the max frequency will also
> need to be updated according to the current boost state, if boost is
> disabled now, the max perf will be limited to nominal perf values.
> otherwise the max frequency will be showed wrongly.
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>

Looks good to me.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

> ---
>  drivers/cpufreq/amd-pstate.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index d54399ebb758..0965fbf660dd 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -632,6 +632,10 @@ static int amd_get_max_freq(struct amd_cpudata *cpudata)
>  	nominal_perf = READ_ONCE(cpudata->nominal_perf);
>  	max_perf = READ_ONCE(cpudata->highest_perf);
>  
> +	/* when boost is off, the highest perf will be limited to nominal_perf */
> +	if (!amd_pstate_global_params.cpb_boost)
> +		max_perf = nominal_perf;
> +
>  	boost_ratio = div_u64(max_perf << SCHED_CAPACITY_SHIFT,
>  			      nominal_perf);
>  
> -- 
> 2.34.1
> 

