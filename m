Return-Path: <linux-kernel+bounces-99358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC1D878743
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 467C81C2107B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3D653E3C;
	Mon, 11 Mar 2024 18:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="nt4+uhAb"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2134.outbound.protection.outlook.com [40.107.243.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF711EB5C;
	Mon, 11 Mar 2024 18:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710181657; cv=fail; b=jDrT18xT78i1WWFGHdwe4j+aJTRIq/Jj6zAN3dsaGXks7vxIm0BiUPABtT98Y/noF+GGpGpym7BXl0Jqya9uI/vEll684LPAVFecPoeeswhmof3uLEdCel/KgbDiycYn9u5P5aOuA123mSMJjm43VMaN0K21UFoRa6iNZfpJBDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710181657; c=relaxed/simple;
	bh=Ot6pVFSH5TS/bnJcBT14hcjswRnvk7N7khEiqdMNjWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U3Ubi/JHrwwFeMZ3Xaj7rZVdcyFw96U0L4JqDMgI8OSI9HQ0goN/IUPOGhfHiTIWoOn53a12BtJ9Hpl5BpWN2JZasDfjJn5VDQhfOoyH/BEMzD00Dw17UDcWmlyKRE8oKrhXH9/CAjEoQ105+fZdZsrG34iaOF2A1Yuu6wCE/mI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=nt4+uhAb; arc=fail smtp.client-ip=40.107.243.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bXEbGMU5ulcnM+VH07MyVseol+wLSyviAmJicv+FntnCj6WfoyyGtvj4wPb6RYvuIijbiDFFC4Ze1UfvmTnluF4uFk969zTuDRVg7IvIYv8dMt8fZch+ndDl059SQNcVE1L6R+0MheEgGOvahgzoE66SMrbqEUnfg+t2P4cxzciC53gmO3KiqlJof3BW+IlCHL5uZjqD+MuaMWg2PxIGUgztSlmVpT/gvUn/zHV/x9dFrdcMK5QJqrPug+/hHJyxWc/OqLvA6rHa1NMhS73Ea4t6NvUopQRJLuBJTOiTz574xRbn44EYLNpadQ4Fh9z9w8bwvMsa4McZfue1gt3dbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dRnjKnY2q5rQXL7eh+CZne7CByUhHPVSfBKLKlJLxEE=;
 b=BjzZelFt0cj7z+nARgUbm+ky/a1kQKwZTROpHJUogkb+BUnxP/gSBI9FAzQFZGk5f4J50rTerobrOpZDWfVZOwN1r3reLvNPEFXUm7rZnTlNhL40lPwx2T2ic1hsP0bVVbDk6MPx3YBpiGmkKjBL6+19GrBxCR8Hum4D1TZWMYG0cuhMfgSg28ymvqtB0AxRzlWTY08GSDHMG6JmAAyhZoTiTQFeSiMzfuom9Bf+hJeJTIhlSKMC8TtHe+w8MUnic0d3qyf60gPXasQCHrRvfPjq2IjsAL83QN07nz6xy8ev1vqEuLR6WHF7rIDCpyAM00Irif92D7GKkUJq8RR3Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dRnjKnY2q5rQXL7eh+CZne7CByUhHPVSfBKLKlJLxEE=;
 b=nt4+uhAbX4t34axyGlnM5yyyUTTmKFM7QSGbkgsbVNjNZMCoN7Abi7NI4VLwlP3RJKhH4ublx63kmF7vREz0p9YJk/7vbQE4/HFzwXRu+tpcDOJ0gAGSbq0R2Q/o72QtQFiO5vvdBqXN1tNY5MCSdJ99ubEFdOMEhnwCk3PJ/Gg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6498.prod.exchangelabs.com (2603:10b6:303:79::19) by
 BN0PR01MB7183.prod.exchangelabs.com (2603:10b6:408:15a::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.35; Mon, 11 Mar 2024 18:27:32 +0000
Received: from MW4PR01MB6498.prod.exchangelabs.com
 ([fe80::4fc3:132:87ac:c13b]) by MW4PR01MB6498.prod.exchangelabs.com
 ([fe80::4fc3:132:87ac:c13b%5]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 18:27:32 +0000
Date: Mon, 11 Mar 2024 11:27:27 -0700
From: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: Beata Michalska <beata.michalska@arm.com>, 
	Ionela Voinescu <ionela.voinescu@arm.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, rafael@kernel.org, sumitg@nvidia.com, zengheng4@huawei.com, 
	yang@os.amperecomputing.com, will@kernel.org, sudeep.holla@arm.com, liuyonglong@huawei.com, 
	zhanjie9@hisilicon.com, linux-acpi@vger.kernel.org
Subject: Re: Re: [PATCH v1 2/3] arm64: idle: Cache AMU counters before
 entering idle
Message-ID: <ghmdr7gksgdedikslax2wdxfzzifu3drviuhifbshhvgksmxjr@7giez2rzppil>
References: <20240229162520.970986-1-vanshikonda@os.amperecomputing.com>
 <20240229162520.970986-3-vanshikonda@os.amperecomputing.com>
 <3ed907bf-9526-3a46-41b9-8a0c747122f1@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3ed907bf-9526-3a46-41b9-8a0c747122f1@huawei.com>
X-ClientProxiedBy: CH2PR15CA0008.namprd15.prod.outlook.com
 (2603:10b6:610:51::18) To MW4PR01MB6498.prod.exchangelabs.com
 (2603:10b6:303:79::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6498:EE_|BN0PR01MB7183:EE_
X-MS-Office365-Filtering-Correlation-Id: a7bab395-c94f-446f-f49a-08dc41f8eaa9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	quTbU0yTOzc8JxZsbjYJcmUX2epyH4EyiUVcu96+yfsSHTYZG1NrzpVo1ibxsicJANBBYnd4Dxc0BI9BznpkMcoLXdXMdnWl/0o3IqubmvxudxhP3Vx/j29H+/GWAdmxvhUOCGRULEltAMrSUR/LE6pgoHKKzrDtdNEO3CHu+qwVWligmmsQjFgqq5Gvf4yPdkmOAHbBrc6YMIrp+qIFYzURBefsGar4kuoJwljqrwt15Ah7VtBtt+SHdfPQ68KL9pHf19HeYR7AFkJ2BlyrjiPhp8atF5Y1nbEPr7quAj7T46We2Im7JyVwjsWEaKXE7BYa05ZtvT1G31/LHbVAzSeKeOUAf35cL6DA47JaTGdi0u51Fro/GF1LIYsozDqrs+PFUhXXY+hoGFGfaeBeX5M1TEpYWb6BQ/wvuK80aTc+GZr+lcVMpt3tFl3v3zadd/ygrlKHXm6YlA93JovpCvJpM62tpFSt6ogTErdzlNuf2Ee2zeVzV7ynp9v/VPoJXu7T/Ii5paG0MSd0Z83xSdDEZ2j3p+aIQnudO0NBmKoCaLH78c8JpHu98X06muTFrS6vE/k+1G+EjBdTbnb1PeKJX76ssUqzyj6wNxKnJK8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6498.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2FzVnM5S0lIejE0cTJpTFl2M2FQMFFvbFI2WkN0OURUV1E0UkdBMGNEWHZu?=
 =?utf-8?B?U1BncUlxd1I4NkUwaDRPSXJnQUxWYk9vUm5hZ2I1TEJIUVl2TWFmM0xjWEk2?=
 =?utf-8?B?ck92SHlYNEMvc3NDVnVndFJEdjd4Z3RoWldkVWVyK0NJM1FDSnUyL3J1WFQ4?=
 =?utf-8?B?MFRKbElmNUErbzFvQjRvZURVSWJTdHhqVHIvRk9odWd6OGRjZUdnbEptYm8r?=
 =?utf-8?B?eDcvTjQxajBQQzk2K1FZaHVBdnJFWW45Ym1ma3o1ckFnR3JwcHJIcUZKU1JO?=
 =?utf-8?B?OTBNTmp5ckw3YWtCUm83alZsQjRJcktvcUYvYXpFc0hONmowUGFzYWZCbFRz?=
 =?utf-8?B?dGJLcmZSdEdZemo2RkgxbUp1UE0vUEc3blBoZWpUNkpLZmo4ZUdGaHFCNGlu?=
 =?utf-8?B?R0tXUlhmTFB3L3g0MzVaV0h0cFlOcW9RVlFNSjdQNU81YWp3bVA4ZFpvNXo4?=
 =?utf-8?B?N3c1OVdWMWpYeVFyMkpoMTZRV1FPR2xlN0hDZ040TCthTUkzTGpYbUVHekZL?=
 =?utf-8?B?VU9UNkxLUnNCRkdoWHRkS1p0OU45eEFpL3grUDBIVnN4a2ZtdytneVpsM0l6?=
 =?utf-8?B?Y1VGRnlUY2x1dTAxd2VVUXB5dHd5V1JMaHdjNU9qdzlhbUxNS29zNHFpOXR2?=
 =?utf-8?B?VmF1TjNZTW5hekxvYjIvbVp4dWdLMGk4b3NMQzQ4cXl2blpiWDF3a1MyU09y?=
 =?utf-8?B?Nll2TG9MRFNIM0F3VXNDOVp2M0R0M2dxUWYvdHBla0s3WE5hQWRPOXlwUHpn?=
 =?utf-8?B?Q0RsYURuN1NQQlVweXhJc3lFZEo0ayt1aEs4aWFtb3puN2M5TUh4TFlQU2Zz?=
 =?utf-8?B?UW9ibytUbFgzV1lWZ0NmaFFIRm9PYWg1U2xnSzJHWU1ZUGxQR09GQlR0cGxK?=
 =?utf-8?B?Q3BUeFJPK3ROSXlPQ1Z0VkhVUUM1UTlpZERzekUyU1lwQmJHVGpLSko0T3Br?=
 =?utf-8?B?Z1JYZitvZGRNR0V6NzhhQ0QrNkZ3aE05SGZRcU14RktDbG5oL3ovN05taEgy?=
 =?utf-8?B?S1U2QXVPV1pqa1FGWHFvNXlKK0Y2WEhjN2MxUFFwNlhWWEF6cVJZRHQzanc2?=
 =?utf-8?B?cWJzTHMxcUlCWkdVZnlwMVhmYy9vQ3dyOGZ1TS95OGhRbGV4U0Nsa2FCQm5Y?=
 =?utf-8?B?SmxnUUFmUWtvMllOKzc4TXg5WG1Ebk9XcHFGZnNJTnBmVWJuMTdUK0h6MzVI?=
 =?utf-8?B?V0s0S2U2UlptTVZEMTQ5eEV3TytCZFIrVmRuVjhkNkJ3azJXZERHSWdQOGlj?=
 =?utf-8?B?YzFBVkVoYUhrcWszY0N6OHZPcDd4OE94Q0RKUmhIUU5IU3F2OHJEMFdtalRa?=
 =?utf-8?B?QkVyK3d0VzdJY0xiSFQvK0lBQlk4STVWcys1b0cwSXo1NUhvL000ZjV3Q1Z1?=
 =?utf-8?B?OFV5cU9QVlFCLy9IRlZ4S1BnOUJjbXU0bC8wNCtKVUpMOUZuNFB4Tzh3Z3BI?=
 =?utf-8?B?SG4vc3dsZjdtUnlHWEMrWVU0N3hFQy9IQlR2bTA3NnB2SVdvT1ZiR3RPd2tB?=
 =?utf-8?B?UXNzV3JZanlGN0g1TUMrK2h1RTBSSEdZbFV2cVczY3NxWlU2QlBPNGZFNkJI?=
 =?utf-8?B?YzgxbE1BbHl0OGtrZjcweHVyeEgvRDM2cjFXSENQbEp6YkJMdXNhRnQ5SWxC?=
 =?utf-8?B?RDFQSHg2YXdEcHJHdE5MRzVSVUU1d01PTjRLMTFiTXVWUnAwekVrUDlXVEY3?=
 =?utf-8?B?ME83enlXdW9GSjVjYlY0NEs3N016ZjFNcWJ6dVY0QjluRGNkSzl0NWVZZEtx?=
 =?utf-8?B?eGFaZXYwSStaaExnSUlkYUd4eHp6STA4QTVXbXRFY1c1eUd4V05zSnJ3NFg5?=
 =?utf-8?B?Qkxxa0pzdDY3cVhoQ1pqTHhaZUwrUFpzdWF0VVpBL3N4WlFUVFVBS1FrT0Jp?=
 =?utf-8?B?b0FPRzFHZnpnQWk3cG04dXlRMC80ZlhVUHJtdmdOMUZ2WmUyNEtJRTM1UFV5?=
 =?utf-8?B?QkI3blB1Rm5XcUJHNDF4d3RBTDFnUTNUSXBjOE1VZVRFUFBtU1p6c2MvalNt?=
 =?utf-8?B?Y2NDNVJucU1hWFN3L1F3R0krRzByVmJpNzBTaEdCVjh3L2hvRFllZlh6MlZV?=
 =?utf-8?B?c2t5OFp3NWVKQitrV3pVTllmb3RIVUZ6aGFCVU4xbE9sdThvakx6OWIzdEdO?=
 =?utf-8?B?QzR3aWswUk1JbWFZd1NNWEoybFJTSk5BM2NXWkF4Vm00eTVweU91UFV6cHVO?=
 =?utf-8?Q?pseGxUnod68me7v1UyyelYI=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7bab395-c94f-446f-f49a-08dc41f8eaa9
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6498.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 18:27:32.6058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: glaj+rLrlNVxIA8VrpqSEqS0JUgG6QhFaTgD7RU9IOUTPlfUi4HqEXZVenC0uyQcovwE1Kek9deiqbqdb+gjRQsHBJ+9RD/3KOeuyeTL1S2w0lxEVOKSIfk0SONckW+O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR01MB7183

On Thu, Mar 07, 2024 at 11:17:26AM +0800, lihuisong (C) wrote:
>
>在 2024/3/1 0:25, Vanshidhar Konda 写道:
>>AMU counters do not increment while a CPU is in idle. Saving the value
>>of the core and constant counters prior to invoking WFI allows FIE to
>>compute the frequency of a CPU that is idle.
>>
>>Signed-off-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
>>---
>>  arch/arm64/kernel/idle.c     | 10 ++++++++++
>>  arch/arm64/kernel/topology.c | 14 ++++++++------
>>  2 files changed, 18 insertions(+), 6 deletions(-)
>>
>>diff --git a/arch/arm64/kernel/idle.c b/arch/arm64/kernel/idle.c
>>index 05cfb347ec26..5ed2e57188a8 100644
>>--- a/arch/arm64/kernel/idle.c
>>+++ b/arch/arm64/kernel/idle.c
>>@@ -26,6 +26,16 @@ void __cpuidle cpu_do_idle(void)
>>  	arm_cpuidle_save_irq_context(&context);
>>+#ifdef CONFIG_ARM64_AMU_EXTN
>>+	/* Update the AMU counters before entering WFI. The cached AMU counter
>>+	 * value is used to determine CPU frequency while the CPU is idle
>>+	 * without needing to wake up the CPU.
>>+	 */
>>+
>>+	if (cpu_has_amu_feat(smp_processor_id()))
>>+		update_freq_counters_refs();
>>+#endif
>The below point I has mentioned in [1].
>This is just for the WFI state.
>What about other deeper idle states, like retention and power down?
>The path to enter idle state is different for them. We should do this 
>for all idle states.
>

Yes. That makes sense. I'll account for them in the next version of the
patch. I'll work on the next version of the patch based on the updated
patch from @Beata.

Thanks,
Vanshi

>>+
>>  	dsb(sy);
>>  	wfi();
>>diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
>>index db8d14525cf4..8905eb0c681f 100644
>>--- a/arch/arm64/kernel/topology.c
>>+++ b/arch/arm64/kernel/topology.c
>>@@ -240,13 +240,15 @@ unsigned int arch_freq_get_on_cpu(int cpu)
>>  	} while (read_seqcount_retry(&cpu_sample->seq, seq));
>>  	/*
>>-	 * Bail on invalid count and when the last update was too long ago,
>>-	 * which covers idle and NOHZ full CPUs.
>>+	 * Bail on invalid count and when the last update was too long ago.
>>+	 * This covers idle, NOHZ full and isolated CPUs.
>>+	 *
>>+	 * Idle CPUs don't need to be measured because AMU counters stop
>>+	 * incrementing during WFI/WFE.
>>  	 */
>>-	if (!delta_const_cnt || ((jiffies - last) > MAX_SAMPLE_AGE)) {
>>-		if (!(housekeeping_cpu(cpu, HK_TYPE_TICK) && idle_cpu(cpu)))
>>-			goto fallback;
>>-	}
>>+	if (!delta_const_cnt ||
>>+	    ((jiffies - last) > MAX_SAMPLE_AGE && !idle_cpu(cpu)))
>>+		goto fallback;
>>  	/*
>>  	 * CPU frequency = reference perf (in Hz) * (/\ delivered) / (/\ reference)
>[1] https://lore.kernel.org/linux-arm-kernel/20231212072617.14756-1-lihuisong@huawei.com/
>

