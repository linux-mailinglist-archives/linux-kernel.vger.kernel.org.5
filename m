Return-Path: <linux-kernel+bounces-145882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E53D8A5C4E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 22:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D79A8284E82
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 20:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3819155758;
	Mon, 15 Apr 2024 20:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gtBkfAw0"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2056.outbound.protection.outlook.com [40.107.101.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F97A1E492
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 20:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713213657; cv=fail; b=IyVo3xIA8gFDigQHkBymoIcPHVEL9Vyi5BfBHzSXZcDfazCMZ4+nBTIKi7kp1ylm9YV72rRMiadUaNTaKkTqRAhR+1ekwk1w0Y34OlFcYHKpjLV75NhS7VXcn1KnC3Xtr9b18Qy+8GXJ+4OfIe7OjRAxvQfrQZSEFswFF0t+BVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713213657; c=relaxed/simple;
	bh=dniJoIft2lOSN5666HbhcBpYbPMwmjLvD6K7I3Th7e4=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f4YJ5e5Ly4WK7U6Uoktm5ZMYKXLyUfoihyc++kIc995bGA0UntKDOI6oQXb2GFJnkRgpXCnV/zbEDDColG3Fj9RsL6S0GFfa5CdEsaHHwn8Z/BJOcGE8ThoyMfGMqK09aqV/FDcyVP9gFPsLmowctPKRlqK00YN5YlHzWrT3kEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gtBkfAw0; arc=fail smtp.client-ip=40.107.101.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UTc08dz957F1esAQYb3Qjuh9tqBvy8xVlY9NTh/E9OSXLdIiTcF5iIhSOnRx0HxLjpc9/PmtXa+7s6jve9KaGF3WEfbKoTsmyxhz0+lGAP+/sT36S0Yi4pjWjmi6HK3CJU4zlDuUNmp4h4KpCJmDsaWwPjShxhX+e+nRU36AXJmaRPXUM4E2AYH5vTDjOzfl79/12QnuW+8MvyBrkRqVnLKsP0EyNqTABvmBeaBY3JVaKNRPdvcdiVb+MzqFGrkmnruYe7bg4KcfGNNyTSDmRwFZIKw1jk74aZ6roKc/CzzxdyDCAE/w777dBZQ1iFmCwc4HAV0HTDdafhKUucYgcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DkDlPKqJoZBcee4bDqpPZ9j0LcMISwz5vT/6CSirg+Y=;
 b=RPfv9JZ31D9EkiXdH8xUawNOFNdMLyGtUsyEJ8AtKgxqa6sC+pRtWz3/e2V7EgIIUMcfqdrbMm4kuHiASGdC5I893NJRP6GTDX5jyD7QZAqAwjjIMMJEnkzKW2D4I7Y6b7eNo9Hdy40zNYVM5klQi77Ju/4A9HaBoF6eoGlrEjtO76SFIFHXFag1+e349USyKrjNjW46dIgmCEuyL3HbHcE7UL/vQkkJQv5aFMyG1oFAUh8rcOvDwG9ZcbAGLwnm2g9Th2GWEOs5ikX9CEGOjCBPbT94trT9Nfvl1ApS40zqSlpcxuY7WKn2rerevmYmIcf6B8+/8F6P6hQQnaKqAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkDlPKqJoZBcee4bDqpPZ9j0LcMISwz5vT/6CSirg+Y=;
 b=gtBkfAw0tKjevaiIrwB+V450870aa3i3bEG9iMBKITLFHPrvOZRfTuQndMMpMv+2cDBcMWq8o6svsLwieZTCX0UJ8HDD9zoe+YXH8pESOI7KPQcM7XU8JaQs34kOozb5QbuYINxYkyjht5ljqy5KPEgdcm0LqR6uxMmHLYM5C20=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CH3PR12MB9028.namprd12.prod.outlook.com (2603:10b6:610:123::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 20:40:49 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::57f3:51f5:d039:ed24]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::57f3:51f5:d039:ed24%5]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 20:40:49 +0000
Message-ID: <c61711b5-e2b8-42dc-9ca2-a9b9454770f9@amd.com>
Date: Mon, 15 Apr 2024 15:40:46 -0500
User-Agent: Mozilla Thunderbird
From: "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v1 05/31] x86/resctrl: Remove rdtgroup from
 update_cpu_closid_rmid()
Reply-To: babu.moger@amd.com
To: James Morse <james.morse@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-6-james.morse@arm.com>
Content-Language: en-US
In-Reply-To: <20240321165106.31602-6-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR04CA0010.namprd04.prod.outlook.com
 (2603:10b6:5:334::15) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CH3PR12MB9028:EE_
X-MS-Office365-Filtering-Correlation-Id: bd101103-40de-42a3-09a9-08dc5d8c55db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dp9zIDE7OV9SFfOeThoIW5DfSHg2BVPQZHRi+y/WYRZsaXS9tiPcgrQQWS8Mm7Iq9s87FlMfJimPKiQLAL2nZAc+EppQZMS8vWpDYQYWNHKFI91hy0X2fY87aHqQ733ZUrjaTu4OlXQyV6Pz1Kl1GF8KZOitVRMhtFmlfxp1MpZa+zj8/LlbBdYTvu6Aamc2EeSCHiHjvzQtFA69jj9kILECos+QFkG3aF3UhvGrupJ4x8gqVooAh24KXxIEe8Zq5YSpzUXypNkUlKqPiQbTEvX+xxMmeco9JBUD/Qbr9f6xqE26Xp0uUPN8z27w9XL+TZosu7JXkmQFLmRd8DY8ke/9hV56b254j+gL9WuEOe7W/v6FC3815s/nnnQgh7GNQO8cZ/5k1HKImK+Fn14LMfCcKwpQglgoFhhiD90X0JCW1JKOoPCS052WAkmKpv7x0p/akczKb+Q7eN1yWcWmZj7s4F7AGGIIz3MBjdw+LMkoglIxk/w/FbUlQguYmvOn9iFM3pNSEclvdLs5NRurZAQ3yBufyphwKvDFi7bx86XIrT7kt7Bs5ttCepgaMjvXDua0FPE9XeuaijwbvjJQa2Arrj08k4oy2dex0RpCCvdEQ+9Gt+WMnvssZXkZ69smE/UQjFFsB/sBc5TKHDKxI/uNxNB7Wqancq9baEqpD1Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGlST2lIZVVvbDE2ZGhGSXdYUUZCYmMwSk1EbnhzbGNxaUZVc0hqK1Nlcmc4?=
 =?utf-8?B?WHdia0RHbThlZ2x4dDFvbjc2OEY3RWRKTE5tWVJiOStUZWNYbi9TNyswRm9J?=
 =?utf-8?B?VlNlSkovWkFGb0ZNWHZpRGl4QW9BRUE5eUpkZXVqV1hvN0tOcU1LM2VDTnlx?=
 =?utf-8?B?bDFmc3Z0bTFMZnpSRkJhR09lTzdKaTZOaDZ6T05TdVFlQ0pkbmdCUGIyb0RQ?=
 =?utf-8?B?c2ZYYTBTRlF2SDJubXB3bGhpSlh5MHlvUVdjZkxsaWZPR3NCNDdxS21yMWFR?=
 =?utf-8?B?M0ZGcWVtL3hHbkJuT0RWQ3NMSDB2Z1YrN09rMk1CZkx4dmk3Y1I1cGZHM1VF?=
 =?utf-8?B?bDV1ZXc5T2NkUzNFZ3RsQ0pCL2pWeW9HRVh3Z2dQRllHOG5idkxxWUhqOE1I?=
 =?utf-8?B?NU82dmsrRElwOXFEN3dlRXRQL1k3dkh1cDlsSko4aTdmZnNlWFBPY2k2MFp3?=
 =?utf-8?B?NnpBeG1wMWJNUjdzRll0SHNKSGo3UXdpVlc4SDNNMVlZY3BLaUNQOTN0R2RP?=
 =?utf-8?B?SThTZCtlTDl5TGZad3B1QTNNRjE4RHJ3UC9sL05NTGlWdnQ1MjZPZW90cEVZ?=
 =?utf-8?B?VXBvSy8wOXVvbEFuem5hTUxubmZ0RkZ4UXh3dkhBMisrL0s1eUc3TlV4NE5U?=
 =?utf-8?B?ZjVXNGM3U2k1NGl3d2lyZ2FuaUtQOUYvSnpIK2Uzb0hUZ0RyK1VwVU54VjZO?=
 =?utf-8?B?MERMMzlybmhKT0FFVU1BaU04YlN4NmE5dGNoM0tSeWdvVUdKT0RmMmU3dDBN?=
 =?utf-8?B?dHFVNUtZM0o5N0c1WUYybUxRMy83Ry92a2tTSUdicjk4TkJUV0pyQnBmWWF4?=
 =?utf-8?B?U014M1N0bW9ZMmdSTC9PYVB5OGY5YndkS1NaSmRBSStCSEFLamV5bXpoWWp1?=
 =?utf-8?B?Q0U1RzY0YjEydEhTem9NSHFSdkNoVDZHajJDOVgwUHpZYWZybGh5MkRrQTBi?=
 =?utf-8?B?WDBJM21Cc1ZQQkR6Sy9zZ3dpYlpvLzQ1WTBnWW5OOGV4OVhUWTBHc1Bwa2pq?=
 =?utf-8?B?Y1pwVjYyMHUraGpkQ2RFS3I3c3kreGxVMFBkWVgxSEdhalJMaU9manRGY1hM?=
 =?utf-8?B?Mk1NZ1lVYjJzUkVpLzgzYlNoVXRVeERrMFkyeHlFbkUxeENhUkZrd3ptZ0VC?=
 =?utf-8?B?WU1LYmxaWWg1ZHd0NDh4RVJ4Nlk1NGY4WTY2VnpOVmtkSi9VOUFVeXJxYVlq?=
 =?utf-8?B?SHExL0FVaFAyTlVOL0Vpb014cXdWLzdoMjZFeUZweVArWjNpc0JvY1VHQUhB?=
 =?utf-8?B?QkgvYlg3VFpKOE5ia2VvRlE0Q2V2akJsNEZ1OFo2QXQ0Zk5XaHhGRzYvandN?=
 =?utf-8?B?RE5hTjh5U1hUZUcxVG1DVTB0a2dvQVliYlZVdTJKR1ZacllPTVptN2EvYkY3?=
 =?utf-8?B?L1F0bDh1L3IvMU9qNUVGTURTa3dORE9rQnpaSUdMRlhjSmxMK3ZEUkFwRkZv?=
 =?utf-8?B?aG5sOFpKM2hNTXl4VDZMYTR5VnFDVk5CNHlHLzk1MlJzQ2xPRUI1ZmtIeVl0?=
 =?utf-8?B?OVlNUGE1NDkrMjkzVkd5SkR2N0tKY3ZjYlJ6N0JZQ2xKQXpZRlRRUmFMR1Zy?=
 =?utf-8?B?UUxvaUlJeHkxWVh1cUxNOG1nOG53MXJMNGxBMU1iYkJ6TE9sODdISGRQMW12?=
 =?utf-8?B?SU1qTTNLeFFmNUpjbktTZ1V4N1Z1b0Q5Tm0yUlBDNDliRzg2OGo5WWh6SlRI?=
 =?utf-8?B?YnNYL0Rkc1VONUZjVjlLemJzRlZ0Tk1XWHdhUHJ1bDFySDNzOUJUblFIRjFP?=
 =?utf-8?B?TnFMWFN6L2hiNlVBT2Z2cWxEMldHaVJvcVdQTlRPRFBEUkdHWWVraktlWmIv?=
 =?utf-8?B?eUNjOEx5YzlhOFY1Q2IyTXpGMWhna2MwME9aekprdXdJQ1JLU0V3dHNsNWdw?=
 =?utf-8?B?N1ZSQ2tUZnZRTEo3aWQzVTV0NCtqS2d5RVUybytvcHNVcnpXQ0x4eU9kQWhM?=
 =?utf-8?B?UXQ4dVlLY3I2eXpSVmllRndRUnhjL0htUHJyN0VNN1pTVEFab2tjRlpZN1VO?=
 =?utf-8?B?VmtKWW40US9LdUVXczNmQUVrb2M1YlFjcWVtbkhyd2FlR21zN0kwbit3K243?=
 =?utf-8?B?ODBBZ0hGclkyUDVaOWRSNWh6VG91enBYRko0VUFHMS9lYlNUSE1VWlNOT3Bh?=
 =?utf-8?Q?moFQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd101103-40de-42a3-09a9-08dc5d8c55db
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 20:40:49.8199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n+jES0L1M7/j1/xMcOQYb/dk6+kJR5pYKLLuyyjkIJEbsGfZWeow76/HR9tzqoIj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9028

Hi James/Dave,

On 3/21/24 11:50, James Morse wrote:
> update_cpu_closid_rmid() takes a struct rdtgroup as an argument, which
> it uses to update the local CPUs default pqr values. This is a problem
> once the resctrl parts move out to /fs/, as the arch code cannot
> poke around inside struct rdtgroup.
> 
> Rename update_cpu_closid_rmid() as resctrl_arch_sync_cpus_defaults()
> to be used as the target of an IPI, and pass the effective CLOSID
> and RMID in a new struct.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 19 +++++++++++++++----
>  include/linux/resctrl.h                | 11 +++++++++++
>  2 files changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 5d2c1ce5b6b1..18f097fce51e 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -341,13 +341,13 @@ static int rdtgroup_cpus_show(struct kernfs_open_file *of,
>   * from update_closid_rmid() is protected against __switch_to() because
>   * preemption is disabled.
>   */
> -static void update_cpu_closid_rmid(void *info)
> +void resctrl_arch_sync_cpu_defaults(void *info)

How about keeping the name similar to the old name?

resctrl_arch_update_cpu_defaults

>  {
> -	struct rdtgroup *r = info;
> +	struct resctrl_cpu_sync *r = info;
>  
>  	if (r) {
>  		this_cpu_write(pqr_state.default_closid, r->closid);
> -		this_cpu_write(pqr_state.default_rmid, r->mon.rmid);
> +		this_cpu_write(pqr_state.default_rmid, r->rmid);
>  	}
>  
>  	/*
> @@ -362,11 +362,22 @@ static void update_cpu_closid_rmid(void *info)
>   * Update the PGR_ASSOC MSR on all cpus in @cpu_mask,
>   *
>   * Per task closids/rmids must have been set up before calling this function.
> + * @r may be NULL.
>   */
>  static void
>  update_closid_rmid(const struct cpumask *cpu_mask, struct rdtgroup *r)
>  {
> -	on_each_cpu_mask(cpu_mask, update_cpu_closid_rmid, r, 1);
> +	struct resctrl_cpu_sync defaults;
> +	struct resctrl_cpu_sync *defaults_p = NULL;
> +
> +	if (r) {
> +		defaults.closid = r->closid;
> +		defaults.rmid = r->mon.rmid;
> +		defaults_p = &defaults;
> +	}
> +
> +	on_each_cpu_mask(cpu_mask, resctrl_arch_sync_cpu_defaults, defaults_p,
> +			 1);
>  }
>  
>  static int cpus_mon_write(struct rdtgroup *rdtgrp, cpumask_var_t newmask,
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 6e87bc95f5ea..2b79e4159507 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -220,6 +220,17 @@ struct resctrl_schema {
>  	u32				num_closid;
>  };
>  
> +struct resctrl_cpu_sync {

How about changing it to  resctrl_cpu_defaults?

> +	u32 closid;
> +	u32 rmid;
> +};
> +
> +/*
> + * Update and re-load this CPUs defaults. Called via IPI, takes a pointer to
> + * struct resctrl_cpu_sync, or NULL.
> + */
> +void resctrl_arch_sync_cpu_defaults(void *info);
> +
>  /* The number of closid supported by this resource regardless of CDP */
>  u32 resctrl_arch_get_num_closid(struct rdt_resource *r);
>  int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid);

-- 
Thanks
Babu Moger

