Return-Path: <linux-kernel+bounces-101137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0870887A2F2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 07:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81EC61F22548
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 06:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45B313AD9;
	Wed, 13 Mar 2024 06:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KBFR4MYo"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AB713ADD
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 06:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710311064; cv=fail; b=O1KaXFFH4F8KxVA2Hxysq+sMll5soCcAdF/U6gc0RvVSAu+VryKn6MVLVE2ir/kLhvOGbbv/FYIzdq0oqfilrSTIc6wdlqdXiPM3GXycwa6DYrOS6Rrh6E8lOX+pLyQ9yYBQThHYOOGe5xujFuSKzQY1MUZRILuvwFDHLtjwqGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710311064; c=relaxed/simple;
	bh=r/93WfPCRUg5rzDLMmCIk1OeiLtzHhFQ/RIlh4F+TIY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y0QQ7e/ZiZ/co3A9NEqDMYAzIM8C4bfQ63FM25cNC3Ko7syUFFmmdAB28zzRnXw50MHQEahR2MzbFg9iJjXljo0Yu6sUxUfNWErztqzkNZ+MYO8iAEroBzuG5EDQ8GChG7/zBJU2Ws/Az9VANo/uRjFVhb5IS6vIVT5fsd4jKI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KBFR4MYo; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RXmVrMEawbeGrLjCT4HMBkIuCpEYDLNb/57y6w8rLf5aybvOlqMogJHyIR/pqVY9PYxIdYl3r0ifQqmiesWQ0UWqemn0iZJ1u6uqF0uB5ufWX8iHG+xoqfrjl8nlDR+sySXoniahIdeR3HjlPgVlZJ4s7UNMcmgWzcj1qyiwM+2AcPExqMX6wG2VaaDrLAL7s+C6G0ZELgGk0y7s4j0fqJu8dxQDvBuAI1bmnKy+RVGEi9jtqo4VCaZrAZjd64ycovrfXS+Y+hyK/rqkC4ZlSKZFg1epKkRavPQb4Sjg3/BeEFY9mSU6PlM3CWT5eoAY3xHWUbxd2K2o0Lg48BUqwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X14RsE3NchdqY1y6YLEUJH/7MU8Gv3ibsglORttdw80=;
 b=RQuaLa9Py0WZKn3hu/UHekgP2CXxlH9OtfW9BySskJ9TC/gF4V3Tmhz3AmjT5czNDj0mKO2k8DyUNfOcanT7A3+MK+fkJ6N+DESFbGSx5F16mjy2kgjycQvQfpizLWW0pIrW9dyfYvmcX5TI6wlzZuX+vNCFgwpzuuyoJNwwgX89gg4JI5ilwluwWGsIvmhJnUgPOW4Q+vx7GAdJnTj5bWOf3gY6pwp+Rq2fxH1knxWWtXkenUTG5GKC4JU+3VBMyALJkjILKi3DDvpz/jPO/3CW2N7Q16NAQyKFNzJOred4s6BsTmHrdGKUkaVcB+8ESngtCF9u8boZqrAqf9qbDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X14RsE3NchdqY1y6YLEUJH/7MU8Gv3ibsglORttdw80=;
 b=KBFR4MYoLQhfJaQbvdvJ8iCLteEhf9QU6s6ZvUGp97vsbltOpntRJg+vOzs1nCGNjL74f1uhqO5fdlUJ+Ry8wooEp4qt2magjiCDiP/wNKE5fymQY8P/0kxKfx64eEsi88AiYQaQnCMFFWCGopeHlLCQpNk4wn5NYJbVQFKljwg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by SN7PR12MB7909.namprd12.prod.outlook.com (2603:10b6:806:340::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Wed, 13 Mar
 2024 06:24:19 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::3150:d50f:7411:e6bb]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::3150:d50f:7411:e6bb%5]) with mapi id 15.20.7386.017; Wed, 13 Mar 2024
 06:24:19 +0000
Message-ID: <ba64f7ad-e73c-95c3-95fb-8c1c55be9be2@amd.com>
Date: Wed, 13 Mar 2024 11:54:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 0/2] sched/eevdf: Minor fixes for reweight_entity()
Content-Language: en-US
To: Tianchen Ding <dtcccc@linux.alibaba.com>, linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>,
 Abel Wu <wuyun.abel@bytedance.com>
References: <20240306022133.81008-1-dtcccc@linux.alibaba.com>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20240306022133.81008-1-dtcccc@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0058.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::33) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|SN7PR12MB7909:EE_
X-MS-Office365-Filtering-Correlation-Id: 05f94134-7de6-47a9-6ff3-08dc4326373a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Q0a/nYZkNbLpCkY746PJVJRotqg6UPAjhjLZAyQ9lR8yUZ+BOx5Dy/qxwG+peCmrCVYqDgZx8jyfkVv7cAfFRxOq+unmbP0EUlwoddQSW0PNiFGU0NYSbj9ZLdEZsb+VBrVcp85TD9/Gh+UCHx2yGp/bL86IdocZVvVpSNBxvDk8xWYLpvcXtAjvF/32OOslbrCIBhUV9v0eDqhf8TtNbjKBhKTuZ79nAKNSdDVLaktFHRCvcJbtyuk+fj4U0xGOKF8G7KtIIbUjxTqVLDq143qM++0ZUPfGSCRiIrP1pO4UZMCSohMFXTcJrrhMLhp/9UKWn3tWcImOFG5l8U1jxFcBzMrgBnBIuwCKkqJmiRFxfT2epmkGx8U/N177hfA/6itT97jfLF2FsDHxsG10yYCLdNRl85PN7iYIPtjrLQvoVd77n9AHnKzZQZC/ooZXwXQgk8LK91DFP6T1F9/UXzmxaW88hkIHM5TY2K0eOEmJCaYZrFf4Xsf8SC0tlpYBIlwPXknpIMjzfFTEzOGSL2cdM6oHbgELQpVpv+SjmL6608Lf9eiFFWM51GfJyhg/rR8wzsKIkQSjW2FWsIe/PazFuFXx2Fu+uiPYjep1cyYgDaibyfy7oXjcjG3MXjSQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SXBPRUlTbnZxdW9YKzF4b1ZyaDRrUzV4QUowby9jbFVvZVdUREYrRmVoL2Q2?=
 =?utf-8?B?bHg0NUJwRXBLM2lZTUdtUGUrUUJvRnBsY3ExeVJuT1BGWEUwUXppcytxcDhl?=
 =?utf-8?B?aW1MbHpUc0RZd0YvN3lYODljcUFJUStRSWdGeDdubGRCY3g3aWp4akQ0SENl?=
 =?utf-8?B?UkVvMDFrU3RxWmg2RGRwR3BSNEFtYVlLL2RJSFF3cWprcjFhai9RSk9IQ28w?=
 =?utf-8?B?dEY5TlFUNzVKUlZkc2V4VktySk1wQi9reGNBekRKQkdpclVLZC93TThrT0J6?=
 =?utf-8?B?THVPNXd0SFZML3YwbmtYWHYvdzBoamErK2JEaS9mSmlFN01UU1NzbHZFRHF3?=
 =?utf-8?B?ZkZDbU5wOTJBMDllK1V5NmFTbit0VGkrY242b1VXZUhpeGpBeFZZY3VHaW1K?=
 =?utf-8?B?VnZ1Z1ZORFZDdVRvMUIrYVRza0xuQnFNU1dSMURuZndhRlg4QjhNM1BlU1BZ?=
 =?utf-8?B?Qml4K1k2S0gwSTl0dE5sV0VjM0hvTWRaMFVJZ1cxR1B2Y3Znc0xoRStpZ21H?=
 =?utf-8?B?RHdwc2JwSWR0Zm1MWWFyUHBmOSt6SjhVV1RHeFVDc0pvRjlkZHNHTk9mR1NF?=
 =?utf-8?B?aThubENXczBOeUt5RDVGSmJPdEZYMzRuVW9iYjI1SkxYeHdFRFhnU0RNeWNq?=
 =?utf-8?B?SGFCUUdReDFnWVBKUGRONUM0L1NyWUhJS2k0VW9WNUtrRTQ3NTdUekVpdGFp?=
 =?utf-8?B?Y3BmN2ljc2IwZGQwU3d0MkJRUERBakJKNFRBQWJMc0lwbEpJVG1IdFhrVHlz?=
 =?utf-8?B?V3VSUVZiR3V1U0ZwckJzT2FRUGx3cHY3ai9TeVVxc0lBbVYydVZ0MlY4Tnc4?=
 =?utf-8?B?Z1pEbC93ZkZVWXFyTUtxUXE3MmNtRUJxZG4vaVhadjExUTRxcjJ4UlpoczVv?=
 =?utf-8?B?OUtQa1JscTdWQW01RmJoTDgrc0FIZXI3a1JjUmVTL0xpWUZVZk9Oa2Q0LzFH?=
 =?utf-8?B?Njdhd0cyQWFkVWEyR2lxektQRURwYkVMQ21LcGpZY2N1NzdCQVFYbUJYa2pN?=
 =?utf-8?B?YzlTdG9uU2NzUUhzaXVKUmxYakE0KzMvZ1JFT1A2c3pJaURoaHJRSXN1RW1Y?=
 =?utf-8?B?UkNZdW9LTXpTd08zN244L3FkU3lnVHpBS1l3c09rSmlkUmhCdUUvWGd3SWdm?=
 =?utf-8?B?ZkI4aEZwUzF4SFZsTnVUQW5kN3JqQkJoUy9SUFRuems3S2ZGNk1QdW0yNnhy?=
 =?utf-8?B?empvNW90dGRjb2d5elFWNGlxR0VERkdBOXo2Ukh5NndWdUkvMnhjeVl3Zk4r?=
 =?utf-8?B?WThUUGVNSWNTWjltSERGSVN4cnFuOGdpdmtBRXdJL2tJYWVOaUJ2Z0pGS2p1?=
 =?utf-8?B?OXpSOEM0TW9Cb0g5Rnk4bWk5dmhXUWZ2QXI1R3gxd3NjcDZOdWhtSWtYdUxi?=
 =?utf-8?B?MWhwM2s2dFFOckhQQk5SbHBENVQrazZIWXRhWjNOd09LdFp5UjdQOHZUL2JZ?=
 =?utf-8?B?RmU1Si9yOTYvVjZiUld5ZXd0V0lPNS96Y3pvd3FwdllDMU1TdEZRbXZPUHlt?=
 =?utf-8?B?V0JvTk5YMUUwN08vbjVsOVBhcXhtWDQ5Tk1jYmRuU2dTTE5RQS81cmdJczVX?=
 =?utf-8?B?RG5qNXJMTkRhSVZIM05uZjVMelc4S1pQTmJxdlNNa0ZxUERvWTRERkYrY2hJ?=
 =?utf-8?B?REVMUGM3c0dkcXJSalFtQXY5RHMrSVBlZXVZUmZJWk1TcjhSYndtMW5YcGs1?=
 =?utf-8?B?Y1pwQWhEY0tkVXBxczkwNzlYanU1Zy9hSmlub3kvbDNoekQrc1h3TUdkYTBG?=
 =?utf-8?B?L21CM3FIWFk3bVFSYTIzTHNpNGhoamdYMTIvOHd5WVBna1pLTXZ2bC9NaUFB?=
 =?utf-8?B?YjJScXpsSElEOXpEV21kRERvalcwS0R2R1VGVEE4emQ5QmxOMWNHUjVnczNO?=
 =?utf-8?B?WTQrRnh2R0lJdjhSdTZRelV0VWxhSm1RSjVHZ3ViTzU5VjVDWmJLZWdtZE4v?=
 =?utf-8?B?bHBrOHpuZlltK1BRQk1KVU5IeFFxNWNsOTZkcDc1SmVSWVZNM0RPakpBRlpV?=
 =?utf-8?B?L0pJa2E0ZDhRTjg4SFhyelFqYmE2Qm92TW40MTZzOUdPSmFPTVdEeHN6a2c0?=
 =?utf-8?B?Yzd5dWZGd1Fwdnh3MXNPWE9STG9WelRxTW9PbXZrOVlYWEM2UWo0OG9lOEdW?=
 =?utf-8?Q?Jj8jet0Jftah84ugScBxI8jGR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05f94134-7de6-47a9-6ff3-08dc4326373a
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 06:24:19.8315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7piTPCbhLviFK7frMS+W8Lw9eMqFhwX8Yz2jyMKIRL2C1V0OUp5SVr32Zwm8Chor0QYDmYigHqMSU12nybvRMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7909

Hello Tianchen,

On 3/6/2024 7:51 AM, Tianchen Ding wrote:
> According to the discussion in [1], fix a calculation bug in
> reweight_entity().
> 
> [1] https://lore.kernel.org/all/59585184-d13d-46e0-8d68-42838e97a702@bytedance.com/
> 
> v2:
> Add fixes tag to the 1st patch.
> 
> v1: https://lore.kernel.org/all/20240304030042.2690-1-dtcccc@linux.alibaba.com/
> 
> Tianchen Ding (2):
>   sched/eevdf: Always update V if se->on_rq when reweighting
>   sched/eevdf: Fix miscalculation in reweight_entity() when se is not
>     curr

Tested the changes on a dual socket 3rd Generation EPYC system and am
happy to inform that I see no regressions. I'll leave the full results
below:

o System Details

- 3rd Generation EPYC System
- 2 x 64C/128T
- NPS1 mode

o Kernels

tip:		tip:sched/core at commit 8cec3dd9e593
		("sched/core: Simplify code by removing
		 duplicate #ifdefs")

reweight-fix:	tip + this series.

o Results

==================================================================
Test          : hackbench
Units         : Normalized time in seconds
Interpretation: Lower is better
Statistic     : AMean
==================================================================
Case:           tip[pct imp](CV)    reweight-fix[pct imp](CV)
 1-groups     1.00 [ -0.00]( 2.08)     1.01 [ -1.06]( 4.18)
 2-groups     1.00 [ -0.00]( 0.89)     1.02 [ -1.58]( 1.18)
 4-groups     1.00 [ -0.00]( 0.81)     1.01 [ -1.05]( 0.81)
 8-groups     1.00 [ -0.00]( 0.78)     1.00 [  0.15]( 0.72)
16-groups     1.00 [ -0.00]( 1.60)     0.99 [  1.20]( 1.55)


==================================================================
Test          : tbench
Units         : Normalized throughput
Interpretation: Higher is better
Statistic     : AMean
==================================================================
Clients:    tip[pct imp](CV)    reweight-fix[pct imp](CV)
    1     1.00 [  0.00]( 0.71)     1.00 [  0.36]( 0.12)
    2     1.00 [  0.00]( 0.25)     0.99 [ -0.52]( 0.26)
    4     1.00 [  0.00]( 0.85)     1.00 [ -0.35]( 0.93)
    8     1.00 [  0.00]( 1.00)     1.00 [ -0.27]( 0.56)
   16     1.00 [  0.00]( 1.25)     1.02 [  1.73]( 0.63)
   32     1.00 [  0.00]( 0.35)     0.99 [ -0.75]( 1.01)
   64     1.00 [  0.00]( 0.71)     0.99 [ -1.00]( 0.51)
  128     1.00 [  0.00]( 0.46)     1.00 [  0.29]( 0.56)
  256     1.00 [  0.00]( 0.24)     1.00 [  0.08]( 1.07)
  512     1.00 [  0.00]( 0.30)     1.01 [  1.16]( 0.28)
 1024     1.00 [  0.00]( 0.40)     1.01 [  0.81]( 0.43)


==================================================================
Test          : stream-10
Units         : Normalized Bandwidth, MB/s
Interpretation: Higher is better
Statistic     : HMean
==================================================================
Test:       tip[pct imp](CV)    reweight-fix[pct imp](CV)
 Copy     1.00 [  0.00]( 9.73)     1.05 [  4.93]( 1.81)
Scale     1.00 [  0.00]( 5.57)     0.97 [ -2.57]( 6.28)
  Add     1.00 [  0.00]( 5.43)     0.98 [ -2.45]( 5.87)
Triad     1.00 [  0.00]( 5.50)     1.02 [  1.85]( 3.19)


==================================================================
Test          : stream-100
Units         : Normalized Bandwidth, MB/s
Interpretation: Higher is better
Statistic     : HMean
==================================================================
Test:           tip[pct imp](CV)    reweight-fix[pct imp](CV)
 Copy     1.00 [  0.00]( 3.26)     1.01 [  0.54]( 2.31)
Scale     1.00 [  0.00]( 1.26)     0.99 [ -0.68]( 3.86)
  Add     1.00 [  0.00]( 1.47)     0.99 [ -1.13]( 4.32)
Triad     1.00 [  0.00]( 1.77)     1.01 [  0.81]( 3.03)


==================================================================
Test          : netperf
Units         : Normalized Througput
Interpretation: Higher is better
Statistic     : AMean
==================================================================
Clients:         tip[pct imp](CV)    reweight-fix[pct imp](CV)
 1-clients     1.00 [  0.00]( 0.22)     1.00 [ -0.35]( 0.46)
 2-clients     1.00 [  0.00]( 0.57)     1.00 [ -0.12]( 0.16)
 4-clients     1.00 [  0.00]( 0.43)     1.00 [ -0.38]( 0.40)
 8-clients     1.00 [  0.00]( 0.27)     1.00 [ -0.33]( 0.59)
16-clients     1.00 [  0.00]( 0.46)     1.00 [ -0.15]( 0.39)
32-clients     1.00 [  0.00]( 0.95)     1.00 [ -0.26]( 0.60)
64-clients     1.00 [  0.00]( 1.79)     1.00 [  0.19]( 1.76)
128-clients    1.00 [  0.00]( 0.89)     1.00 [  0.45]( 0.81)
256-clients    1.00 [  0.00]( 3.88)     1.00 [  0.42]( 5.53)
512-clients    1.00 [  0.00](35.06)     1.03 [  3.05](53.21)


==================================================================
Test          : schbench
Units         : Normalized 99th percentile latency in us
Interpretation: Lower is better
Statistic     : Median
==================================================================
#workers: tip[pct imp](CV)    reweight-fix[pct imp](CV)
  1     1.00 [ -0.00](27.28)     0.81 [ 18.75](29.23)
  2     1.00 [ -0.00]( 3.85)     1.05 [ -5.00]( 4.76)
  4     1.00 [ -0.00](14.00)     0.95 [  5.26](17.91)
  8     1.00 [ -0.00]( 4.68)     0.85 [ 14.58]( 4.12)
 16     1.00 [ -0.00]( 4.08)     0.95 [  4.84]( 2.60)
 32     1.00 [ -0.00]( 6.68)     0.94 [  6.12]( 2.28)
 64     1.00 [ -0.00]( 1.79)     0.99 [  1.02]( 1.08)
128     1.00 [ -0.00]( 6.30)     0.99 [  1.13]( 3.68)
256     1.00 [ -0.00](43.39)     1.11 [-10.71](10.31)
512     1.00 [ -0.00]( 2.26)     1.00 [ -0.47]( 1.57)


==================================================================
Test          : Unixbench
Units         : Normalized scores
Interpretation: Lower is better
Statistic     : Various (Mentioned)
==================================================================
kernel                                tip             reweight-fix
Hmean     unixbench-dhry2reg-1       0.00%              -0.60%
Hmean     unixbench-dhry2reg-512     0.00%              -0.10%
Amean     unixbench-syscall-1        0.00%               1.61%
Amean     unixbench-syscall-512      0.00%               4.94%
Hmean     unixbench-pipe-1           0.00%               1.01%
Hmean     unixbench-pipe-512         0.00%               0.73%
Hmean     unixbench-spawn-1          0.00%              -5.24%
Hmean     unixbench-spawn-512        0.00%               2.83%
Hmean     unixbench-execl-1          0.00%               0.20%
Hmean     unixbench-execl-512        0.00%               0.10%
--

Feel free to include

Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

> 
>  kernel/sched/fair.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
--
Thanks and Regards,
Prateek

