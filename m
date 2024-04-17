Return-Path: <linux-kernel+bounces-148172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 748C38A7EA5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDF571F2228A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2AC128372;
	Wed, 17 Apr 2024 08:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="S1P/1I75"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EA92744B
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 08:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713343743; cv=fail; b=dje/+z2EJgVD98wobuT7fNLEPldZcUNH0ZzQYCYgSAZCyxiDg2fLmijeQoMUbl1UjuT/S40abGPMHtu8/AGNNZkZhCpqqMbeR7Fk8W3LOdYdPCJVL/Y6lspB1dpxicBR95wBCrxq4a9d63qE2YkrPGcwrZ2shaZI9U4ws+6yDew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713343743; c=relaxed/simple;
	bh=vWURJ4Op2c0DaxitUAQJ1m02w4Na03PYa9l8peyl6cQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hiT8V7s0pcTurdgm5X4VatQaGU/9f+pl3zqmyLb2zLW5JweLMU8b1H6dnplwG/zUkXjNtNxx+29ld9ub56tNjlIaKdrIrqqt/uqDtTq1hU/c5+1Qd4lt7y/oEicz7hEUZX16rSnVoiIA2Z/ePIlXq3fzyyu1qgR3Lm6rSjCL/8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=S1P/1I75; arc=fail smtp.client-ip=40.107.244.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lB1r5hbouUslEOj26Hgfdq4h442eEjED4HWxNeeSgsipp7uWtJg0ARhyXRs8qe+FPQJs/LbrWFAyxc3wYEQ5ovnvhNUQWn4bgs39eJrwdEcjg8k3AY3E6xikZP/NGPBXkaWCD29hNGdpbCGsDvjwNsm9knlz0wOxCmCsNEY7TKtuzax28qme5C7em/+T7gQCqMeOJMvqTjPoZTb0NbRhLxGnFh3h0kaWlDYjdjvuACvLGEbcPSOzAUWgF36ehDcTx0Rct0R38rSPHo6ZtUTJc/kwd5xzRqnJUKrY7kLsjYucpeMWvZxyi6MpMX3Zsb+6gateyQ2Zn8CYbfu4/FLXcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cgGtYAuUKYk+7RKFj8VAL6p8YH1ugxOttZ8HEWZkDEA=;
 b=egU16XZmAWqRySEZc+Z/jfnha6CBOlJnyx0RZ+/1r+QkKl35iRLSnys3f2nM5OLIE7nVezdNBhi52pGRAVbuHkMWcC0h4PE3BGg4XeAa9Ldnrlpi4qlIKn6CZOTWfis4AdOSOWNbBiFWHicnamwfCN7cJvmpYFJhVwI+ZGw2KEc6SUGcwqnyGMmmR/+riKFPZr67Mj+etk95vL7aK0JU5TVfCP8cbLLCCZ0yZWWzlNu69OCl6MuWCzay+xl68NpMSSRynbUp6pVJr4VuzbRUoV9akj0QgeHx1GYdBKyGIB1ndBpY/3oCmMIEv5UZcCcthFv4ncNDa2N6zeM/MNwgtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgGtYAuUKYk+7RKFj8VAL6p8YH1ugxOttZ8HEWZkDEA=;
 b=S1P/1I75/ngX9pEjrOZp9BOIQ49mVRguUmy5qH4gjf5pGXm0WVkr8Z1RCTVJQCI+BaMnzd4VjoqFyyhFK+QrubJgoQm6FK36AHRlBd6mtlh+fzUyY3jtuegHM19KhBDJtiVZHzkeDfDSOpgZtseFQ325fWW/36kt0ODjFhysv7Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by SA1PR12MB7152.namprd12.prod.outlook.com (2603:10b6:806:2b2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 08:48:58 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::494b:99e2:884a:dca1]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::494b:99e2:884a:dca1%3]) with mapi id 15.20.7472.037; Wed, 17 Apr 2024
 08:48:57 +0000
Message-ID: <7592f555-21f8-284a-dbc7-0a6ab4d42c0d@amd.com>
Date: Wed, 17 Apr 2024 14:18:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v4 0/8] sched: Implement shared runqueue in fair.c
Content-Language: en-US
To: David Vernet <void@manifault.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
 vschneid@redhat.com, youssefesmat@google.com, joelaf@google.com,
 roman.gushchin@linux.dev, yu.c.chen@intel.com, gautham.shenoy@amd.com,
 aboorvad@linux.vnet.ibm.com, wuyun.abel@bytedance.com, tj@kernel.org,
 kernel-team@meta.com, linux-kernel@vger.kernel.org
References: <20231212003141.216236-1-void@manifault.com>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20231212003141.216236-1-void@manifault.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0052.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::21) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|SA1PR12MB7152:EE_
X-MS-Office365-Filtering-Correlation-Id: 65e7997d-e31c-4405-993f-08dc5ebb37e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gXblzDW4Q0Rb6/ffbrE4uJfQ8PkvRvYhbw5J1VhJmYP5FMRlhvYAX1CXrC0xNHUgUJ3Nz0mATIppnOixPAzk4WLcM+xlhRHkRbI9K0tm3N3xxPLCUWcGVsdb26jZAzWa/sDrC8OxqcCvh13WuChReucSg0q3HuJaAW2KgHW4aziNZO6tFnI+jRRFo71qSE6XdfhfO4+msKvgcHJeGWypD21e1aOPtHJgoiBYxG0NzTQyDgrK474OtShNmjDQksX3rb3Tda3xjob7mIQgT6jqB9VCdDAoSyOKPHUUVOUSFt91/EhH3AAX8KZDH4FhnSAC+VGFIhH4yFJ93LcIKCNmxmCO0VAZplN0zMiOYgWR5LmGKLXlJtCcqRUDC1UgBMQpQWtikxx0/KBgYCmQeUdtq4VIsupTYEyhoJ7N8ik+2M4Y2vshExBeG4kRcM8OLf/zMdJcDL+Xvg1paIoiubeXaD5qgF/hq10uTaRktIpI38LHcQUCHIy3YgLcfJrgwhSDQ9cf4T0WRX9iAGQ8OjrhI71nIpasd7pSHYrRRz7td5pDSSzhk8jn8OqaMNqzswWkBjGxdW5kcgwgeDv9VgJqlY4pt1Qb1UJgc/1oyg63UW6kBo++SGCG2xeYzaZgR8dUnN6G90ApfWF4uoQeoNmyiIdN81jxQg9PAPC/DS8geVE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGhUK0NybDA2L0RQT0IwQkVHS2JIOVN3TXlYdHkrVEN4Y3BvMG1tUndWKzRz?=
 =?utf-8?B?NHEvYXM3dWFUUlRhdU5wcUVBbitrbDFFTkF3Qjd0MUhrMzNFYjNWdlgyNFhZ?=
 =?utf-8?B?bFlIVVpQQStjNXNuV2hpdWd0WU56cCtsb2Q0K1JYbURKcDNYSEtpamlzd2Zi?=
 =?utf-8?B?MkJWTjJqNFRwOWY3M2ZoNjcyQmFiUGY0dXhQSkZLZi9BWFFZamFydktGUVVW?=
 =?utf-8?B?d2ZsWjFXUHk0UXhuYVV3WWJ6VHFIMU9DVzZmUUs5TTIwOUhFODBKOGczRk95?=
 =?utf-8?B?Vk1hZiticy9ObUphWlpMWDZhbzFPL0VuMno3OW82Nis1RWxOeFY5aG9sODFH?=
 =?utf-8?B?SnhmY3h6WDhMdEkyS2kyL0VxbFBPTXVyaGhUM3hMSWZybjNPR1krWnRUM2k1?=
 =?utf-8?B?SGc3NmlkSzBuT2kxbkpad3pCR09CSU5rWm96Y3JrVUswMzdnUi9HUHhCdHBS?=
 =?utf-8?B?NG8rK01mWlVmREZSMGJxWUJNcHVVK0FpNDMxUXdrSk9NTTJSKzBYcmlpcWVP?=
 =?utf-8?B?TStYcUhLYlRMOTdkOVRNVFJQV3dMUE5oSzBLU2poOVlhYUNtakkvWnJHUWE3?=
 =?utf-8?B?TEkvSnBGWHF1Y0JXRFRTcnJNK3RJUEtWeG1HT1hJSW5YalorWCtzOVFJbitZ?=
 =?utf-8?B?TS9MbDNxUFVjSW56S0xvVGkxUGVJUVlyREd5VTFJNHFoN0pwajVLTkxObzBq?=
 =?utf-8?B?YTQ4NUoyK3d6RlJ2TExGK3pwdUppOHArT1diK1Bjc09BaXdyT1pPaGllaVlF?=
 =?utf-8?B?YTY2citHYm16RmlSTlRXc05uYUNTV2poOW02dEdHeXdVc1k2VmJqLy9jVEsy?=
 =?utf-8?B?TVZIQ2cvNnFhT0RqTDlZV2Q4Rmlma215c3NFNkdXeWFQWUFvN2t6bnNUWVF5?=
 =?utf-8?B?ODByaUVXR2ZybUJCR3g1L2p3eTliV0FMNER4MGJLQ1ZPcDRaTEpqSjhxTlZq?=
 =?utf-8?B?VWFHbExkaW9vaVo1TlpUZ0plT2NNMHFMZUg1c3ZXVDVvS0k5ZnFHSDIrSC9T?=
 =?utf-8?B?WlkxNUsva1JTVS9XWWlBOG02MXc5TjRQaW0wWjh1VjEzNTg1ekd3eEo1ZURG?=
 =?utf-8?B?TTl1OFJjQ0ZRSkUyWnd0RGtWblo5OVViN1lIM2ZjaEorVVcwZUJ0d3FtYnQx?=
 =?utf-8?B?YzZGTU5FUzBzR0x5NGdIb3lsRU8vSGUwOTNEM25KdFR3WFhHMDVPZUJLVHhW?=
 =?utf-8?B?Q21IUm5Ld1NUZjQ2MUU2MzgzQmJuSmMzZjA1a2VwT2FxTFRLQ2o5WGNpY1Fq?=
 =?utf-8?B?eHJzYlZGUGtpNk1ia2hNci9pVThFK1l5Yk5jWHh5SE1DT0hieTE0eW9MTWpv?=
 =?utf-8?B?dVNOdVRydTZFUXlDcUNUZ3JTWkY4VXdBcUZ0OXhKVGtYdGlGQjdZRmpNbEg3?=
 =?utf-8?B?bmkzalBWc0w0M2VzSTNqcWlUbU85M3lXRTBWRXpSczRNeXpnOUZBaGxyR3BR?=
 =?utf-8?B?REZpL2tFSFk3Y2MvSUN5ekl0dm5EOWpVbmR1dWlqQ2pza0dkdWNWRjhGOG4w?=
 =?utf-8?B?SUF2dzJPL1ZnOG1mcGZ3eDlObXo1NENsUzFOeGtlSzZZSytBdnBZcWNyOU5a?=
 =?utf-8?B?clNhQ0p5NStBVnRCL1J0TlVlMS9yOEJxSGt2QUVWV3oyelVXQXU5a21nY3Vo?=
 =?utf-8?B?RGN4ZVdmYXRNOGtrVC92VUY5bzJ4UWVtM2lrNy9oeTZNVnRTU3pDNFU1Y0k3?=
 =?utf-8?B?aFJnd2J3OGtGRjRMV3RqMndJMmp3OXU5N1U2Mll3N0VLT1BxT1J2bTlBV1VY?=
 =?utf-8?B?NCtmRmRtdFd4VTVyMmNpd2FBRnRjVGFMY2RVL1p6Q3BUcVpJMTNZMFA4K3l3?=
 =?utf-8?B?aFJTM003YXYvNklORCtLVEQxYmVnU3dWRmJWU0hCanptYlhzTGdlbjI5cGMr?=
 =?utf-8?B?Z0hkdUZrdlQ4Y24wclpuVE9xTE1GOHFpTG1DTjVwWXdpOU9PRXV2VXBjVDk3?=
 =?utf-8?B?a3gxbEcvRnVzL0tLZHNmRmkrMjcwRUtoaStvR0JmWXFvMGdqVEJKRW9tb054?=
 =?utf-8?B?SDhLWjc5RTk5TDNlSzU0NzZGYWVGaFNrNkFDOVRWVkRkemNlNmtha3hMR2lw?=
 =?utf-8?B?ODFIL2JHTEhEblpaeVdCZ0RSOGh0a093V2t4Q3V5RVZVdVJJNUx0WFpiamd2?=
 =?utf-8?Q?x0zDRlyvw6dmAGkAGyRHBFBdP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65e7997d-e31c-4405-993f-08dc5ebb37e8
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 08:48:57.2818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VwHqIelHM+6vdjvDHe6bnDs/TtaSHMu6wgB9F22K7BLMgf7gX0zIQlxXIfr71pikFfg3ytNtyQinc1PZF/PKQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7152

Hello David,

On 12/12/2023 6:01 AM, David Vernet wrote:
> This is v4 of the shared runqueue patchset. This patch set is based off
> of commit 418146e39891 ("freezer,sched: Clean saved_state when restoring
> it during thaw") on the sched/core branch of tip.git.
> 
> In prior versions of this patch set, I was observing consistent and
> statistically significant wins for several benchmarks when this feature
> was enabled, such as kernel compile and hackbench. After rebasing onto
> the latest sched/core on tip.git, I'm no longer observing these wins,
> and in fact observe some performance loss with SHARED_RUNQ on hackbench.
> I ended up bisecting this to when EEVDF was merged.
> 
> As I mentioned in [0], our plan for now is to take a step back and
> re-evaluate how we want to proceed with this patch set. That said, I did
> want to send this out in the interim in case it could be of interest to
> anyone else who would like to continue to experiment with it.

I was doing a bunch of testing prior to OSPM in case folks wanted to
discuss the results. Leaving the results of SHARED_RUNQ runs from a
recent-ish tip below.

tl;dr

- I haven't dug deeper into the regressions but the most prominent one
  seems to be hackbench with lower number of groups but the picture
  flips with higher number of groups.

Other benchmarks behave more or less similar to the tip. I'll leave the
full results below: 

o System Details

- 3rd Generation EPYC System
- 2 x 64C/128T
- NPS1 mode

o Kernels

tip:			tip:sched/core at commit 8cec3dd9e593
			("sched/core: Simplify code by removing
			 duplicate #ifdefs")

shared_runq:		tip + this series

o Results

==================================================================
Test          : hackbench
Units         : Normalized time in seconds
Interpretation: Lower is better
Statistic     : AMean
==================================================================
Case:           tip[pct imp](CV)    shared_runq[pct imp](CV)
 1-groups     1.00 [ -0.00]( 1.80)     4.49 [-349.19](92.14)
 2-groups     1.00 [ -0.00]( 1.76)     1.02 [ -2.17](19.20)
 4-groups     1.00 [ -0.00]( 1.82)     0.86 [ 13.53]( 1.37)
 8-groups     1.00 [ -0.00]( 1.40)     0.91 [  8.73]( 2.39)
16-groups     1.00 [ -0.00]( 3.38)     0.91 [  9.47]( 2.39)


==================================================================
Test          : tbench
Units         : Normalized throughput
Interpretation: Higher is better
Statistic     : AMean
==================================================================
Clients:           tip[pct imp](CV)    shared_runq[pct imp](CV)
    1     1.00 [  0.00]( 0.44)     1.00 [ -0.39]( 0.53)
    2     1.00 [  0.00]( 0.39)     1.00 [ -0.16]( 0.57)
    4     1.00 [  0.00]( 0.40)     1.00 [ -0.07]( 0.69)
    8     1.00 [  0.00]( 0.16)     0.99 [ -0.67]( 0.45)
   16     1.00 [  0.00]( 3.00)     1.03 [  2.86]( 1.23)
   32     1.00 [  0.00]( 0.84)     1.00 [ -0.32]( 1.46)
   64     1.00 [  0.00]( 1.66)     0.98 [ -1.60]( 0.79)
  128     1.00 [  0.00]( 1.04)     1.01 [  0.57]( 0.59)
  256     1.00 [  0.00]( 0.26)     0.98 [ -1.91]( 2.48)
  512     1.00 [  0.00]( 0.15)     1.00 [  0.22]( 0.16)
 1024     1.00 [  0.00]( 0.20)     1.00 [ -0.37]( 0.02)


==================================================================
Test          : stream-10
Units         : Normalized Bandwidth, MB/s
Interpretation: Higher is better
Statistic     : HMean
==================================================================
Test:           tip[pct imp](CV)    shared_runq[pct imp](CV)
 Copy     1.00 [  0.00]( 6.19)     1.10 [  9.51]( 4.30)
Scale     1.00 [  0.00]( 6.47)     1.03 [  2.90]( 2.82)
  Add     1.00 [  0.00]( 6.50)     1.04 [  3.82]( 3.10)
Triad     1.00 [  0.00]( 5.70)     1.01 [  1.49]( 4.30)


==================================================================
Test          : stream-100
Units         : Normalized Bandwidth, MB/s
Interpretation: Higher is better
Statistic     : HMean
==================================================================
Test:           tip[pct imp](CV)    shared_runq[pct imp](CV)
 Copy     1.00 [  0.00]( 3.22)     1.04 [  3.67]( 2.41)
Scale     1.00 [  0.00]( 6.17)     1.03 [  2.75]( 1.63)
  Add     1.00 [  0.00]( 5.12)     1.02 [  2.42]( 2.10)
Triad     1.00 [  0.00]( 2.29)     1.01 [  1.11]( 1.59)


==================================================================
Test          : netperf
Units         : Normalized Througput
Interpretation: Higher is better
Statistic     : AMean
==================================================================
Clients:           tip[pct imp](CV)    shared_runq[pct imp](CV)
 1-clients     1.00 [  0.00]( 0.17)     0.99 [ -0.65]( 0.40)
 2-clients     1.00 [  0.00]( 0.49)     1.00 [ -0.17]( 0.27)
 4-clients     1.00 [  0.00]( 0.65)     1.00 [  0.09]( 0.69)
 8-clients     1.00 [  0.00]( 0.56)     1.00 [ -0.05]( 0.61)
16-clients     1.00 [  0.00]( 0.78)     1.00 [ -0.23]( 0.58)
32-clients     1.00 [  0.00]( 0.62)     0.98 [ -2.22]( 0.76)
64-clients     1.00 [  0.00]( 1.41)     0.96 [ -3.75]( 1.19)
128-clients    1.00 [  0.00]( 0.83)     0.98 [ -2.29]( 0.97)
256-clients    1.00 [  0.00]( 4.60)     0.96 [ -4.18]( 3.02)
512-clients    1.00 [  0.00](54.18)     0.99 [ -1.36](52.79)


==================================================================
Test          : schbench
Units         : Normalized 99th percentile latency in us
Interpretation: Lower is better
Statistic     : Median
==================================================================
#workers:           tip[pct imp](CV)    shared_runq[pct imp](CV)
  1     1.00 [ -0.00](34.63)     1.40 [-40.00]( 2.38)
  2     1.00 [ -0.00]( 2.70)     1.08 [ -8.11]( 7.53)
  4     1.00 [ -0.00]( 4.70)     0.93 [  6.67]( 7.16)
  8     1.00 [ -0.00]( 5.09)     0.92 [  7.55](10.20)
 16     1.00 [ -0.00]( 5.08)     0.97 [  3.39]( 2.00)
 32     1.00 [ -0.00]( 2.91)     1.03 [ -3.33]( 2.22)
 64     1.00 [ -0.00]( 2.73)     0.99 [  1.04]( 3.43)
128     1.00 [ -0.00]( 7.89)     0.99 [  0.69]( 9.65)
256     1.00 [ -0.00](28.55)     0.92 [  7.94](19.85)
512     1.00 [ -0.00]( 2.11)     1.13 [-12.69]( 6.41)


==================================================================
Test          : DeathStarBench
Units         : Normalized throughput
Interpretation: Higher is better
Statistic     : Mean
==================================================================
Pinning      scaling     tip            shared_runq (pct imp)
 1CCD           1       1.00            1.01 (%diff: 1.45%)
 2CCD           2       1.00            1.01 (%diff: 1.71%)
 4CCD           4       1.00            1.01 (%diff: 1.66%)
 8CCD           8       1.00            1.00 (%diff: 0.63%)

--

> 
> [0]: https://lore.kernel.org/all/20231204193001.GA53255@maniforge/
> 
> v1 (RFC): https://lore.kernel.org/lkml/20230613052004.2836135-1-void@manifault.com/
> v2: https://lore.kernel.org/lkml/20230710200342.358255-1-void@manifault.com/
> v3: https://lore.kernel.org/all/20230809221218.163894-1-void@manifault.com/
> 
> [..snip..]
> 

I'll take a deeper look at the regressions soon. I'll update the thread
if I find anything interesting in the meantime.

--
Thanks and Regards,
Prateek

