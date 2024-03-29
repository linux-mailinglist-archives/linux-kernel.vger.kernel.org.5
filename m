Return-Path: <linux-kernel+bounces-124076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 365698911DE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 04:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7EA028B3C3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 03:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7086364D4;
	Fri, 29 Mar 2024 03:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Q451qfZA"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2135.outbound.protection.outlook.com [40.107.94.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01789381B8
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 03:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711682228; cv=fail; b=mIdr7Ba27RGmb2uCNjQuN2bPa6Ma5RjYxP4Qt2YRpi+b4DeBtQd0jIt/BHlS98LLvvlDi9qzbIx0yD+rWK9fM6ucAJYHs9JSG9yYT1i4jMaS7NCCN6PwsQRCjLEAHBSZDOU7qZKPPrjN9cYM6hjeWrBV5Lt8Yu3/1S7235P0XXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711682228; c=relaxed/simple;
	bh=96/1WlKX1qf1vCGyZV+mUKTsB7PoboxFZoCsk2DDFDU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GyAx0J6Q/FxB5r5kmUVnOWpPdo9koc9n51M+aFGOjYAeK0VNqrDs7oHtHUDL/PMDWNTn3JUJzrl3f2MulCpF+ih88agK8hq2gKFISA5AuABLgUQgklMBVAMrH5YDn6/X8fbhNE8zthPOoLmP0LOcs3vit+cap9x5xRcwhBbO0FI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Q451qfZA; arc=fail smtp.client-ip=40.107.94.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fWf9Kfo8jbvIG0jWfYqugWNj3myiGJ8Z9yOVrmZ2ocNsqr79e+qA80btp985dR/kZbAzwvtczeHug9m6q2u8KCfOsNAfZZkCVVJ6CQirXtRjUC4H2oyl8+uYzwVj5CtC25tFx0TecsC8evRpGKzVXaNQnVSOzIdpmffYqEdw09Z+Sgmp+L9ZcYw0BekghzJLR2dchnx4njXobn8Z8N12weGLbB/UJ+WXleNhvei114EpbmerJMJfwScsDHR34CcDxddecMJoDHrVonO8IyekyHgw+9b385nYfiwZQ4tzHH8yXlHgFybE3CiRFWxgbHYqoXO2dv5wZLgrdtXYE9stRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d86bzrXfucsdXUZC3R9KyiKNgR3gjYhmWzK+vE3JeMk=;
 b=gT3CxS6pdMP2M4X/Yqx/aku7tryuEcOWfOp9eoJ1oqVMiPV3JxAWGwo+Xn9txNbNJwigu/s+YyIticHezmXU1Xt+fr4uStvJunam2Ep36zcEq4wdX1UQq//EdBk82tDiI4nO618NE1v6ebXaJizEe4ZMMTkDYZ/U3OqonhiNgtrNW7ahacZPsI3uzBzATmgqtsCu6czDaiFvXiimuIjorCtO3xXs9Vy/GUnbL4ndo16Szsq1labuA3QA6ph+ffcNQZRuwv9Tk2OAqoIRIDBrR4Xix0fgXa52B348z2cw+kJKDa89TdaAqh2kZlG2RVV/r0PcQXKXw1m6vJbAtUcC6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d86bzrXfucsdXUZC3R9KyiKNgR3gjYhmWzK+vE3JeMk=;
 b=Q451qfZACNSILSUgC/Zz9iZTKftchsUdx3i7yvoFa0vUvqza/gxZNYprp3nLpRGR0jocaJFAbSkb38GaOjRhreqcsqn8q4JjRCreH8nMbkqBJdZxeXmBCxIj6+1fvfwICUCBD+W54XqMVzdOUI8OBHWXqZY+CKCio/5UZuqLyck=
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by PH7PR12MB5655.namprd12.prod.outlook.com (2603:10b6:510:138::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Fri, 29 Mar
 2024 03:17:04 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::494b:99e2:884a:dca1]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::494b:99e2:884a:dca1%3]) with mapi id 15.20.7409.031; Fri, 29 Mar 2024
 03:17:04 +0000
Message-ID: <ba351ec5-21c6-3ac3-f3a3-6690c9d0682b@amd.com>
Date: Fri, 29 Mar 2024 08:46:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RFC PATCH 0/1] sched/eevdf: Curb wakeup preemption further
Content-Language: en-US
To: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org, Tobias Huschle <huschle@linux.ibm.com>,
 Luis Machado <luis.machado@arm.com>, Chen Yu <yu.c.chen@intel.com>,
 Abel Wu <wuyun.abel@bytedance.com>, Tianchen Ding
 <dtcccc@linux.alibaba.com>, Youssef Esmat <youssefesmat@chromium.org>,
 Xuewen Yan <xuewen.yan94@gmail.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>, Ingo Molnar
 <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 20240325060226.1540-1-kprateek.nayak@amd.com
References: <20240325060226.1540-1-kprateek.nayak@amd.com>
 <8bce19b2-37d9-4722-ba83-0088a4c9fc6a@linux.ibm.com>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <8bce19b2-37d9-4722-ba83-0088a4c9fc6a@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0095.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::10) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|PH7PR12MB5655:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SKRWZFzJBTEaNYPFUSk++FHxEhiwv+mSc2TNFWfRYuyNsZFOuwisFFXQH0AoSJvTlYTlF5eO9MZ1PY/qHzKGzNbGkTq0FTc/NIy4DcZtwZFiDiRfZp81hQN8z1Yp9be6GvWv4/6L+zjJcNbs9Emum9E+lssdRi7GFQb8FphG5ZTnv0f7hklTOVNC0wXzEG20ntj1B4R3ZIV1i0w2RoURDXYdaxBmkBXgzOENDk2O6m2290Pl8jsYIuYvpQeI25Wzr8vCvAMYuSlqnvZDIO2qohD3AYXBPU1w++DsEXgI044PEfcLMD1fkPNnQ3uRxZ3a7XhxsCW1ab7cSrXEMKl4N36rlBZ6hOUtNsZtbn+ksusYm35voDGn1WOUoZPsli9wkqfaBso63Qqfx5OFC16kNpxctZ2TLcKFHmV9/ur8zViibC3zIHnLoh1H37Sic+xJjOjPq05wd6WGcY5sgjZ8FfD3EFbNrUS4VwM1i8p8keqRQ/PxFDTfVfxiOssLHkyYFuuui3H+Y2Biu1F+1Z9BOaGv0n8Za+I+/GUnl4CaFmgL2p7KMjZFpbvp9la5pDWFVuiNJHyVNMukO+INh8j4d+K1l9BL1u5Dl4MYlqaOh8oY5+zKst5HaqujaI+oliy8CgMyD4ryPwHSg/0RAxszS9aGElZyCkFZWaZnMVi/zh0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0k5eU9kLytwTmNsME8xWnZqWW11OGhkZjV2V2pvWnhyTkI5aDZLUlZGaHU5?=
 =?utf-8?B?NW9KZVdDdXNmdENhdk1WbDJsY3Q3MmxtaVE5bmUvREFkMTRHc3ZETUhGOHdR?=
 =?utf-8?B?VzJBazVuMWRWeGJsTVpZZlliOUQ2UGs3M1g4bE8yUjRRWG9IcXBwTlAyVmhT?=
 =?utf-8?B?bDYzYkpGb1UxZ0xjL0VTUGlVM1RRN0pGR05BVWx3Q25DcFZ1VXd1bVcxS0x0?=
 =?utf-8?B?OVR1UVFodVJRbjd2ZEEwZTZCRXZ3cTk2STBQS1FtcjFsMytGbmJXemdUMjky?=
 =?utf-8?B?UkxBdHFXcjdPT2dhZUM5ZGJxNWpJWk8vUHNQdTh1QXFtT0l2bFBEc3lBMW9F?=
 =?utf-8?B?QmJSNU9MYTlYajdFa2lKY1Y5TTYzbXNMbm5CSmdueGt2RlBWQmgwdjNaZzk1?=
 =?utf-8?B?eGlmUnVYUXBIY0FHalVBdXM5OFVidW1PWUJIMllyTThtZzgwd2NZQlZhU1JV?=
 =?utf-8?B?ZE9VdkZQTlE2bko0WXgrZHRmOHpIVWxHWG0rL0Jhbkt6aStaK3kvbytDRkZT?=
 =?utf-8?B?K01GaGwzWERLSHlIYzhpbjJGRFBMVDJ1emZpRXR2cE1FdFhaS0VzNExvOHRR?=
 =?utf-8?B?dW1YN2xrSXQ1ckhwMlI3R1VJVFZadkZCVUt3SGU5RzNrRkhvSHp6WHRRMk0v?=
 =?utf-8?B?RXN3OVpQYTNkR3RJUUVxeUN2a0I2UElIaWRJdmdrd29ST0FMMnZvK2xvcXhw?=
 =?utf-8?B?RVo0SHdUMlgzTUtaUWpvR243bCtteHhOME5rQXN4WVREaFdZWmxDWGtmR2Rz?=
 =?utf-8?B?NDJVc0pXY3FmY1VqWUVJYXhRSmVnR1l2ekFNZlNsU1M0NWUzSEtGTEJBOWNx?=
 =?utf-8?B?UXNlWE1vbklkMVF6WHlpenBkdGtZRjU4Z1h5OFppVFBJK04wUWlZejU3UVNY?=
 =?utf-8?B?NTNFaEI3SzM5K3l4ZmtCSURFbHhDSXFlZkNWUFBsdkRZVG5Wekg1aTN5eE9h?=
 =?utf-8?B?RXlHRzNsNjNuN2Q0ekRnbnNjVWRpMzNaSzNtYjEzTElNMVRLaGIzLzVxZEZI?=
 =?utf-8?B?OENUbzBsN0w4NjAvYStYZ3JHck1HZ3FlUkVGMnJ5MVcrOXQ3VlFRUno5eGpm?=
 =?utf-8?B?ZTJXUUIvVU1rdjdYbTl0djJFVUU1OXlxeUFRZHZQL0wzc3phT0hrUWIvemJ3?=
 =?utf-8?B?bUQyeThoZkhYS3JuMjNvZHNxZVEwc1BuZmozbmV1Zlp3TzZKMDAwYUsyNUFJ?=
 =?utf-8?B?VGZUK3lid1QxYkFSUm5NOFhxKy9FeWFTNm9kb3FJNDQ4TlNiY0hsdW1HN0ZB?=
 =?utf-8?B?QmpwS0RsWENoMGxSY1pFOG1sSkF3ZWhkK2NJUzkvay9YbjdPVXgySTVJcVlG?=
 =?utf-8?B?MDc0Qmorenl3eVJkVjVKaE55aVVWd0hYTmtETmdWeG9sLzJndGhTVE5jT0FP?=
 =?utf-8?B?NlFvNlQwRkUzNE1GSlpCbXBnZ05mOHNJLzEwQ1BwV2lPRHpyT1FNajk2WWEz?=
 =?utf-8?B?c25pWkJwVTRISzlJb3hmVnRINHI2U1RVTnhibFlsTEYyQWZHTllad0g4N3Q5?=
 =?utf-8?B?TzZvQnpNZGI2eEFORG91TDdYd0RzOE1EM1BEeVQ0clB3SFQzZmg1dnU3YTVX?=
 =?utf-8?B?c1J6U25oTFFxUjZUZmJnK0VzWjBmRDhzMGNWcUVEM2ZlMWt5SXZaam5jV1Vh?=
 =?utf-8?B?NWpDM3VhMVZwSVI1UTJOaXNlTitYNmltSHo3WXJuL2F3bmlFR2YxeW9MWndy?=
 =?utf-8?B?eDd1NHB4OHFXT0dYOXlOOG41NEhSM3YrVjlMRENkb0kwbFNxSVRFQnp5Uzds?=
 =?utf-8?B?OE0vTU1zWFFhekFYcHdtU28rMWtsZzFSMFRub3BJWDgxTENWSkIvazBqL3RB?=
 =?utf-8?B?K0JxalJhWmJqcWZuMmM5WGZyclBNeDRjQlhYSmlUc2VDQUM0dU9ZaGlpWXRK?=
 =?utf-8?B?MXVzVTlqS1R4cHRlNlVhdlVOTXpnUEZVUi9EaGtkTjFGb3UyU3dSWkNaMGE2?=
 =?utf-8?B?TG5SalVCUXgyV3haNmpBWWd4ZnBlajNCVXlPWnBXbHV1cG5ic0kzOUtCekY0?=
 =?utf-8?B?a0R2RXZSeXFqRnBnbmVPdmo1UUJPTmFTblFWaFNNS0pXZmUyMVh0bC93VjFr?=
 =?utf-8?B?UDNZT2dveURmOXhoMFFMSjNDZjdUVnhYd2pnTmp5S3hyRUhJbGhiak9uV2JW?=
 =?utf-8?Q?qy9uExQbMWNq35lPMCjch84AM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e5e58e3-23a2-4415-8541-08dc4f9eb522
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 03:17:04.5196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 75CqQhbV9oE6EA2bYPhl3/V4oVNTv7GRABFCel+KefQoDgx/2EIAPFIWtIYdXAaaX1SAjMKz8DMgfJaBlHQAXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5655

On 3/28/2024 3:56 PM, Madadi Vineeth Reddy wrote:
> Hi Prateek,
> 
> On 25/03/24 11:32, K Prateek Nayak wrote:
>> Wakeup preemption problem
>> =========================
>>
>> With the curr entity's eligibility check, a wakeup preemption is very
>> likely when an entity with positive lag joins the runqueue pushing the
>> avg_vruntime of the runqueue backwards, making the vruntime of the
>> current entity ineligible. This leads to aggressive wakeup preemption
>> which was previously guarded by wakeup_granularity_ns in legacy CFS.
> 
> Is base_slice_ns not guarding it in EEVDF?

"base_slice_ns" guards it in some sense since lag clamping is based on
the entity's slice but the problem is the eligibility criteria which is
purely based on rq's avg_vruntime and entity's vruntime. Previously
"wakeup_granularity_ns" would have added a buffer before preempting the
current task soon into its run but this is no longer the case with EEVDF
especially if new entities join the runqueue with positive lag pulling
the avg_vruntime backwards.

Please do correct me if I've missed something.

> 
>> Below figure depicts one such aggressive preemption scenario with EEVDF:
> 
> Thanks and Regards
> Madadi Vineeth Reddy

--
Thanks and Regards,
Prateek

