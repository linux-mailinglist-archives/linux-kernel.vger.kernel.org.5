Return-Path: <linux-kernel+bounces-139230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A73FB8A0026
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D9C01F24B8D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2113B17F36A;
	Wed, 10 Apr 2024 18:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gZ7NI8Uy"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB57175A4;
	Wed, 10 Apr 2024 18:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712775449; cv=fail; b=rcISu966Crs8kiM28oRRNpFAoIXjseCLAbEA+aj2Z1ljbDMdbVeFFM0cexitASBEuWm4hwvXj/ObVRtpvYe+VvOUKp+s/ALp7cS1OUOhugP6Ei4SkUpooBSdCIWcv7z4W/I+O2GcpsXKN/ti4lckx1vJWRpo3pnB2RzNy3Uyaz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712775449; c=relaxed/simple;
	bh=SSndwC5hDqxJpdBvENnzdv6zQgeEKAwvbSI1ut6/nIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Kt01AcIKWXxE7ZMmGROiYdqonctw96wT3ITkzA9v7VD20x0tLo4CW1Snnl+HVy37OYs1vdB7V513KSheZ7ndwYOzvJKXBK/Qn5BmyOmh7TDOA5kkEZNGPacsSSfZsMxWBUqcLRFY+QL4XUcs5eSvv1qNaVanpNzQZpR9ZT7v284=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gZ7NI8Uy; arc=fail smtp.client-ip=40.107.244.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5V/MXPXkldn4YZPHZIwiV3fi4pzZElEBcREpwmlMhMLTfXZS4750R0V63zjTSE/WDory52aO48BqQe3YCkzxpxrgBWFCIJOuYb7dtQjMOkEl1dTVV/AhfYS7gZEtOOMiif5Nwn4m3zUMXYtxHHQKutb44mHHztcyAhB2RHEZt6KZuEIFGMOwaDD7Zi3QJWzdH5IQB+9hV6yCpOH3LVLO90h+qgPt000gTrcPSgqKUbJT2OtDi3ckjlhyVuyJEdJgFXqNctj0RO0arZiNkZbZQOBOBZmR0vTYzXU2hWziRLe+lALMcAslCTxD0eRpoD1nDfmRWJm+DMHtNXe9Dxk2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=daS+ZqUE/ZDq0OlbyEe1b0k4YlqNWZg87UCOC660bsQ=;
 b=mZPh6Ra8hLuXIALxPgpB40FHeTclPwGKxdUZsMepiS305mnb/vUrsCfq1j4ogxkivKSLsRDVI0Db6pUc/yrBK0T84DTKa/5TBw1fnY/eUKTtwZWq+JEvwel+yVqZFEnTBRtc1KYMbYJLlNtcP6WV5kU0Cr3/JtJnUT1hFewHIQL554/hZnq467NA9Eplomzt4eJtCr3vJKN5iJg57EnUP5jQwSO5CtcDidRXL/vdaw20/u1Ieb3wE7mYIbjRKPo4YBqDPG1bzAoBYQU844QHCz9dqXi+PL5e80iH2rf2xHiSkba0DVN0+RrExLkQEAgEQGlb8l5TIUFu9dB81HGzdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=daS+ZqUE/ZDq0OlbyEe1b0k4YlqNWZg87UCOC660bsQ=;
 b=gZ7NI8UyZb+xnAczHLemxr5e7AHTeznL05Gjs7OGiqgqbwP1sURVxd4f44eMsTiGTH1/wMkqntVv1ht6D+k/aoiRh4dK5+5IdqS0cz5guSsfn+78cYpoUydetEVo6WNq5uZfWz5NvCJM/LrC5LBBcRSuDpDGVWZdAHK+UwC4UtTLkE3+ju0BpM/hexchHKXwS/1oEk9Tjz0VJ/82broYgu8htm2ol1bxRcrVRQtqW2/R497ksdOAn/CK0L3UhfWmt5ecSGvimpwWaJC0dgrjIDVbtHQXmzDlNgMPtC47wlVo4cCEsf26s1KU4qmHLJp04FZoDEFP1DwhzS3hIsjwFw==
Received: from DM6PR18CA0026.namprd18.prod.outlook.com (2603:10b6:5:15b::39)
 by SN7PR12MB6929.namprd12.prod.outlook.com (2603:10b6:806:263::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 18:57:23 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:5:15b:cafe::e0) by DM6PR18CA0026.outlook.office365.com
 (2603:10b6:5:15b::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.21 via Frontend
 Transport; Wed, 10 Apr 2024 18:57:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Wed, 10 Apr 2024 18:57:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 10 Apr
 2024 11:57:06 -0700
Received: from [10.41.21.79] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 10 Apr
 2024 11:57:02 -0700
Message-ID: <3ab3cbc1-234f-e0b6-4521-298018547aad@nvidia.com>
Date: Thu, 11 Apr 2024 00:27:00 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 3/4] arm64: Update AMU-based frequency scale factor on
 entering idle
Content-Language: en-US
To: Beata Michalska <beata.michalska@arm.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <ionela.voinescu@arm.com>,
	<vanshikonda@os.amperecomputing.com>
CC: <sudeep.holla@arm.com>, <will@kernel.org>, <catalin.marinas@arm.com>,
	<vincent.guittot@linaro.org>, <yang@os.amperecomputing.com>,
	<lihuisong@huawei.com>, linux-tegra <linux-tegra@vger.kernel.org>
References: <20240405133319.859813-1-beata.michalska@arm.com>
 <20240405133319.859813-4-beata.michalska@arm.com>
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <20240405133319.859813-4-beata.michalska@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|SN7PR12MB6929:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d46c5f5-7f24-4f69-5e6b-08dc59900e7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yxQ8Tf7ldDtw1hdemE6STb7Xv5NkQGy+LETlB0lzXlPXXl6WX9wbEhzh0gFan41qJKY6xJYlUOgAgFKI1IiskdMkhrB8t0QWqLeQhjUB5t7FNxdLCmNp7eVHhfQTU+x4hvPWqMCTCOyX+LjnUTyLdJEUt6as7XnkyxOF9KCBs5bEwRaN6FwKKAONLkgeD093MnRGXtw8BNyqam26ZemFk3V7JTsVqYx25PCczOsjC4Gyrvqca13EJafOgfnb/xBB1NUAbPxQDfEHL6w49KUht4PHpKAmJvUrPxY4acemMkyIEWgf1Idix1wiqr/1P+FrmY4h0XSiRyynz0UuCuEkzaoopGatkxV3OGTVv22LFuoOWowL0aH7Zho8iT4wCtpvC4G49IzGQYAopOC01Qg3JMdR2cHieuh0S6HoBhhhcdxqdn4asroiheShk57nrK/SPoDmOj3Tjr1WePR+S5/gc/jcAVUIwMAhq7SsxL5NsYFfnDdw/ix3yYJuln8DfTZTbAk7WwCVWKjFHbPlkMMuDlyQOboMGo14uibnfFC5zHAV/w5uJXyKVwuvXA2BGRw2y0Sp9RADVzOu0wZDR2sP0BRUupcL2WviYpFccZLtGbRmRJG/65I/Ynhfjl6WUhmQDxIpzCELiNndazKuliGfZpTxs1emRyMRZzXjSYsCk2szdSj5i4L5Tss0WCRKhCLaDc5F2lkvhmiPzie3TIvEbwbhG4h5nENzqGb9SLnSMGXHWgz8kgmgxP15PPw2Q5/S
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(7416005)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 18:57:23.1334
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d46c5f5-7f24-4f69-5e6b-08dc59900e7b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6929

Hi Beata,

This patch is giving abort due to 'amu_fie_cpus' mask which gets 
allocated later in 'init_amu_fie()'.

  ] smp: Bringing up secondary CPUs ...
  ] Unable to handle kernel read from unreadable memory at virtual
    address 0000000000000000
    .......
  ] Call trace:
  ]  arch_cpu_idle_enter+0x30/0xe0
  ]  do_idle+0xb8/0x2e0
  ]  cpu_startup_entry+0x3c/0x50
  ]  rest_init+0x108/0x128
  ]  start_kernel+0x7a4/0xa50
  ]  __primary_switched+0x80/0x90
  ] Code: d53cd042 b8626800 f943c821 53067c02 (f8627821)
  ] ---[ end trace 0000000000000000 ]---
  ] Kernel panic - not syncing: Oops: Fatal exception

Added cpumask_available() check before access to fix.

  +++ b/arch/arm64/kernel/topology.c
  @@ -211,9 +211,13 @@ void arch_cpu_idle_enter(void)
   {
          unsigned int cpu = smp_processor_id();

  -       if (!cpumask_test_cpu(cpu, amu_fie_cpus))
  +       if (cpumask_available(amu_fie_cpus) &&
  +           !cpumask_test_cpu(cpu, amu_fie_cpus))
                  return;

Thank you,
Sumit Gupta

On 05/04/24 19:03, Beata Michalska wrote:
> External email: Use caution opening links or attachments
> 
> 
> Now that the frequency scale factor has been activated for retrieving
> current frequency on a given CPU, trigger its update upon entering
> idle. This will, to an extent, allow querying last known frequency
> in a non-invasive way. It will also improve the frequency scale factor
> accuracy when a CPU entering idle did not receive a tick for a while.
> As a consequence, for idle cores, the reported frequency will be the
> last one observed before entering the idle state.
> 
> Suggested-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
> Signed-off-by: Beata Michalska <beata.michalska@arm.com>
> ---
>   arch/arm64/kernel/topology.c | 17 +++++++++++++++--
>   1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index b03fe8617721..f204f6489f98 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -207,6 +207,19 @@ static struct scale_freq_data amu_sfd = {
>          .set_freq_scale = amu_scale_freq_tick,
>   };
> 
> +void arch_cpu_idle_enter(void)
> +{
> +       unsigned int cpu = smp_processor_id();
> +
> +       if (!cpumask_test_cpu(cpu, amu_fie_cpus))
> +               return;
> +
> +       /* Kick in AMU update but only if one has not happened already */
> +       if (housekeeping_cpu(cpu, HK_TYPE_TICK) &&
> +           time_is_before_jiffies(per_cpu(cpu_amu_samples.last_update, cpu)))
> +               amu_scale_freq_tick();
> +}
> +
>   #define AMU_SAMPLE_EXP_MS      20
> 
>   unsigned int arch_freq_get_on_cpu(int cpu)
> @@ -232,8 +245,8 @@ unsigned int arch_freq_get_on_cpu(int cpu)
>           * this boils down to identifying an active cpu within the same freq
>           * domain, if any.
>           */
> -       if (!housekeeping_cpu(cpu, HK_TYPE_TICK) ||
> -           time_is_before_jiffies(last_update + msecs_to_jiffies(AMU_SAMPLE_EXP_MS))) {
> +       if (!housekeeping_cpu(cpu, HK_TYPE_TICK) || (!idle_cpu(cpu) &&
> +           time_is_before_jiffies(last_update + msecs_to_jiffies(AMU_SAMPLE_EXP_MS)))) {
>                  struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
>                  int ref_cpu = cpu;
> 
> --
> 2.25.1
> 

