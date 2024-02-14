Return-Path: <linux-kernel+bounces-65736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9238550F7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 457D129085E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E660F1272CA;
	Wed, 14 Feb 2024 17:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HvsyQZzb"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E15127B4D;
	Wed, 14 Feb 2024 17:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933442; cv=fail; b=qoi1ZAjEOjcwINNwY7TcCxerTb2AI9VTOzk+pg4iJimChpuEP/rH4kxPslcsj0/2nzszjakCIRsMkuFMG1YnnMZGgyumFMD2tNONTPy6lgce37Gaj/BNRpEMWb1HvMaRog85wkKIhOqYrje0gXonlQuxQEzaKVeZ0zNSDNzqjZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933442; c=relaxed/simple;
	bh=pLTE/IWGclIuTx2K8lX9szFqxyMEn8bLd2SULfNTHkQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IP7hhrO3i8iST2skfPIv/Zcx58vXjwGL0efkkCJ+vY1hZ8lw4urzQhxLXQGlX1m8oD1UP6zgRSMY2te1uIUuwtamGmgbuf5HG+oLseRnvWDjet3eN/n+5SmxEktmOAb7I0Wu7DcNTJzFan0f4dRqydxPMSh4/hu8Yg6ebFD5cjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HvsyQZzb; arc=fail smtp.client-ip=40.107.220.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YIqo9rh+S9+1ZjaUoMrcAB9Ys8DvFaMmDlktr34pjAxLuIVjUkJsdIrfW0vz+WN51e6rAWFxQ+69g7zL6dU0WLKK+t67cto7pu2WO0UBu0u1g54hweRP6opVo/RBrelYY87/iNtjjoHH4/1K2SPCE3MYLfckVIoE8C6cxmgtU4GUO4GMZaQPalRbDFmamL4kpTGQXdiE+/1gvT/xK3cgYrpVyXyyfqSKhxRHNu2jV5Yw3qp9AIhEWjJNqrYEzHrebAjbOCo3pBDGrcdNkNeSbSKBRoBrbI/INSDtLKxGVQ1MNDp9T00B8kE7RZ2LPeUOn4i7HAvWMkgg8TZz7f+Opg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n1mFlJ8UW2jqn/cvQgUqxO/GrT5xGKSCGvLaAUy/0og=;
 b=DUa0RhogQAATPAXruGBAzl2YifcNH9+5AYjNUM138cJkazbi3CJGZRMOva0Cd7BORVO8SjWD6qKpu6T+dmKVA1YU9xhauAEkkLeJDIvHRjRcYKooQe+pwF2SAOiTAIewUtE4mH9Kh1jE/CMoTvs5S9lbAxQGc1YHlRoSLuwjsCkNAwuOlCpsyRKJnrJiiWnAwKb/lksyGjuYHRosJyrmdEo6ISaK14reCS8A+EqHbmIHv9wSk0/7az5R8LX7Hn6noF3PHvQL0/XiiZtVdMYvwPt8QgZEtZRckt8pYmcjY/cJn4GXJQLKKho7pU6mkAwdN2sTX4C2kgLl93azauIHWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n1mFlJ8UW2jqn/cvQgUqxO/GrT5xGKSCGvLaAUy/0og=;
 b=HvsyQZzbbqy4pzcQx1ltMWqWSXOQ6B8n+6Rsyx4a3fMJTqEHkb9ywvp87i94aCoC1UJbHraFT5QgHOZDvQVQANdr1aefoXhu7a26foddYqDwZfpC0Aae1snSEez9Cwl/5Hbe93xyS/ScM2RoWI8IbDmhur6sM24rB5CfYpOUX7Yyb3Th0WXbJQbV5rPHie228lTRN6sveO5qUYhBLF3eSFxYYFHpctLWSpjgKhWT3VJKL9KqpLGCydZJUtiCOnPonBGjcIwEn+ZhOWaF/veOSGC8CQet/yBxvqNYOiTV8ku0Lr0MAD8fKa19tvbMDckrJ4EaFtBAIy0tTzZbJcJVYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 BL1PR12MB5111.namprd12.prod.outlook.com (2603:10b6:208:31b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Wed, 14 Feb
 2024 17:57:16 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::f462:16b8:4857:38b7]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::f462:16b8:4857:38b7%5]) with mapi id 15.20.7316.012; Wed, 14 Feb 2024
 17:57:16 +0000
Message-ID: <93228dcd-b80c-439e-9965-1e20d3ee31a8@nvidia.com>
Date: Wed, 14 Feb 2024 17:57:08 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Fix frequency selection for non invariant
 case
Content-Language: en-US
To: Vincent Guittot <vincent.guittot@linaro.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, wkarny@gmail.com,
 qyousef@layalina.io, tglx@linutronix.de, rafael@kernel.org,
 viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 Thierry Reding <treding@nvidia.com>, Sasha Levin <sashal@nvidia.com>,
 Laxman Dewangan <ldewangan@nvidia.com>,
 Shardar Mohammed <smohammed@nvidia.com>
References: <20240114183600.135316-1-vincent.guittot@linaro.org>
 <6ec54a8f-a602-4f33-96ce-0204f07046e1@nvidia.com>
 <CAHk-=wgjiVanO4ZS1hy2sfAFTN_pYtQqVQb_g+dbrP34M6xTDw@mail.gmail.com>
 <CAKfTPtA8W+SijB9D3GtNbC7o_XHUV-umcL6chJQbMDxWeX7exg@mail.gmail.com>
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <CAKfTPtA8W+SijB9D3GtNbC7o_XHUV-umcL6chJQbMDxWeX7exg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0008.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::20) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|BL1PR12MB5111:EE_
X-MS-Office365-Filtering-Correlation-Id: 622dfb6a-78fe-4672-17a7-08dc2d866161
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	p0x7Igq2GyIrn53BkMHqKSceV05YQ3pHLDVOZeGP9I+aZGr4XyOmh2WhaDkq+HxbOG0EtH54mtfNsKXUswJ5INQJp6k2z0QLGkIWSvgIvFvPl2AWTVZEG34WTkgr2OXWf/RQLHsGQqt/VIX/qIL61XXqjKZQfYosz3lFIW+q2QXPmdptkJbzUwWpXvQzPo6tYhjksVpi56aSZ8ppxffLBjgEkEwDNyzE5A4gTjZB5P1CUMYhc9l2q42HyD1tPyY/TGjcxvVRuN9W8sVHl6GkWh7n3ZKbI3Cuve24DQDQoZEQC5HsJ/muE9qu/L79BzHyIkDooDaDESB9ux+ilYS/mgoUUNgtMYy0aMhubQm+JyUprz0I1FHcGovkZUH3svw6Se/vegbSmHw8HbYh3xtLIABcygfuZyFdBlJGLY2tJkppQFn5Rvj46fpSyYA5HWNMeH1tsssFNM6A45cEW3/tEda/88vAr8hd7kFt5TdEyptX9vjaLXKw0qVp/uVfa+57HC4jQuF1PelxE2XQ6cKTesHVmX02IGpoRlK/9138XbFupXWroB9mdZHnhw+coAA8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(346002)(396003)(136003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(2906002)(5660300002)(7416002)(6506007)(55236004)(107886003)(53546011)(36756003)(6512007)(6666004)(966005)(478600001)(6486002)(38100700002)(83380400001)(26005)(4326008)(8676002)(86362001)(8936002)(2616005)(31696002)(54906003)(110136005)(316002)(66476007)(66946007)(31686004)(41300700001)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGc4b0FSWmpPR3Y1elZIemtjR3Y2TE42R216OGxycVlwUEx4djZncDJtMGRk?=
 =?utf-8?B?eDByeHhoNTh0TWtZZkovOHBEWXU4cENYWTVYWmIxNHFGWkZaSEpnQ2Y5aGUx?=
 =?utf-8?B?Q0pYRTNnQVR5ZHJFWVk1U2JRUmFIQ0tkcFVlQ1lzdERPVHhHeStRSktmU2ZT?=
 =?utf-8?B?NGx4cXowMjFWYXlZeGRnV0lNU1ZVTDdHMEkzdDJYV1dTbkRXSGIwa1RqV1Iv?=
 =?utf-8?B?Zkp1MnV1Z1FMQnJQRG82UkwyMHF4dFhOMXIzQ1BWcWpnT3AvZVRLVEV0a2dh?=
 =?utf-8?B?dWtkT2R0UTIrYVdGSkwycGRJdzhTZjd2T1o4NXRMYXg2cFpPZDNzbW1XYUcx?=
 =?utf-8?B?clB4VktKSzQvNGRnTnlDbHhuOWdCZXorNHE0Qm5URU5pNHY0UkcxQ0kzWVVv?=
 =?utf-8?B?U20xRzRKNFFZajdlK2dMMUp6V3VDVk5VeWxDK29kNzRFNEphR042aUhvVUxl?=
 =?utf-8?B?LzA5YTRzUWhZOGpERVRvdDRmSEpURUhNc3Z3SHY0ZHJJbXBZSmFiZ05RSG0w?=
 =?utf-8?B?a2p0R3lVTGdSYlk0b0l5M1U2d3l0TlZMOXgxNnJ2eVc0TVQzTi9tTVAvZmpv?=
 =?utf-8?B?M3phZVdDOXhHYlpFZnRmazBhZ3V0SUNjdDNyZzNmNHpTN29FSk9yZTlBbmdh?=
 =?utf-8?B?SWlheWMvMkVNaExYVERsNG00d3Q2TjRQL2E3SUFVRmFhcDMxYzhJMlZiTGQ0?=
 =?utf-8?B?UVVHaGQrUEpZdkF4Ynl2NUUzdlI4NERLUUVLZk80VE80QTRyZDhYeEZhK0pS?=
 =?utf-8?B?Q2VPYTNFbjZFQVZ2M2l5bW84K0V2cGJ2NkFXcVpWWWkzTFlzdUo5WW4yZ2Vw?=
 =?utf-8?B?UDIxWGgxRkdXbXlvaWE5OW0yUUx2am53UzMwSDhqSGJEaTZVZVdoOXgxTDNp?=
 =?utf-8?B?SXpoQlArR1h4RkxYZWdzQzNYbFpMMDE0N1lTcUlpUjNTM2RDNDFjVVc5VUxP?=
 =?utf-8?B?NWptZXR3dm9pNkxhSlFDSDFvODAxc1lkUDJTVS81V2FzYU5NNHp2clJONXVG?=
 =?utf-8?B?VEdraUhGclJpU1cvaHcvZmZ3UmVnVStNSSs3QkhRLzdlYUdrTXZMNTZnTXRo?=
 =?utf-8?B?N0dqd1o0ZzVaR2hGQW43NGZTM01FUU9xZGYvM1h3WGZEbGorakZNSXE3bjNV?=
 =?utf-8?B?QTBLNlhwMzFXOXAwUTVwWmZURWc0MEFkWW81QVJocVlqM0lLTjVPUlFWdzFk?=
 =?utf-8?B?bms3Y3B5LzB0V09ZdEk2eWlndnM5UFViOHJzWUlwMW5RQlVMcytMQW9BOUwv?=
 =?utf-8?B?ZURGa2ovS0tac0tEcHlLZVNzWDkyekdMYzJIbkh4QjAvd21DRWg1TG5POWZo?=
 =?utf-8?B?THF3SlV4S29WWjhoYzM0SlpTYXVrUnYrRFdZV1dDRWRBblF1T0hMSjVBWXV6?=
 =?utf-8?B?ZTYxQ09ubU1NZjBhM2ZMVkN1dlF0YUcvUGlFVVkxa3RsY0pzT2R3Yld0NUMz?=
 =?utf-8?B?SzV2VE96alNVSVVuOGQ3QmRQczVaUXBBRUlBYktLSHU1NTNOS2RuV2FsK1Q0?=
 =?utf-8?B?Yjd1aElUL0ljZFhUSmdLN0wybk8rcEhqM0Nkd3FkRVRTZDdURFhjd3N4RFh6?=
 =?utf-8?B?TEsxNFB4Zms3ZEI2d3N1WkR6MHJ0cWQrWWJad2tud1YydFVEbDlkdmJvTHBT?=
 =?utf-8?B?ZUY5S1RDOWpIcHZYMXpHN2YwK0hUT280dUZxdnQzWnFuMEJkSmEwY0dqcTlp?=
 =?utf-8?B?STVGZGFrV2ZDSzc2TTVUNmJ2VE50bnlzdFNQM1kya1dxN0FoT0Jhc2FPbUI4?=
 =?utf-8?B?c0FPdU9nQ0FSU3FaZTgxd1cvN3d0TDB2Nnp4MFpXMFFBa3ZKYTlQcUZha3ZL?=
 =?utf-8?B?eGNVM01GOWx3dGZqYllSR0VFTDlnVnZURjRvdUdrREh6UnpLUFp5Zi9rMFZk?=
 =?utf-8?B?VjNiWUZHbjcwL1N3S2prT2xQZ3d6YUdiTTI0VTZINUhMcTc4WFEzbkVKeHBj?=
 =?utf-8?B?SjRTTENxWVlzaktYYXNHV2loeGJac09DWVlrazAva2pzb21uaTVUYXZJbDVW?=
 =?utf-8?B?TThaZnB3YmhuSkpybWxDYW1vckJjTnBMQkJiL1FUZE1FTlZBamJLZUU3UUdx?=
 =?utf-8?B?TnBFTzR6ZUtBRGVid3RIeDNXMGNUOEV3WjM0c1U3dVJDNmVLOGQrd3EyU1Zn?=
 =?utf-8?B?QUF1dWttZk9VOHRRRmRtYTBSVE5maG05NUVVYklsKzVSbVplclFITjhDVTZI?=
 =?utf-8?B?K1E9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 622dfb6a-78fe-4672-17a7-08dc2d866161
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 17:57:16.4959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EuFRN8bH1yv4M2h3LwY1nKZtRSRN3sxv1Psnko1rrZEWCXdGU8YrjJCvo9XovF1TfmSm9r83uDMr6wwIaPfdJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5111


On 14/02/2024 17:22, Vincent Guittot wrote:
> On Wed, 14 Feb 2024 at 18:20, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> On Wed, 14 Feb 2024 at 09:12, Jon Hunter <jonathanh@nvidia.com> wrote:
>>>
>>> We have also observed a performance degradation on our Tegra platforms
>>> with v6.8-rc1. Unfortunately, the above change does not fix the problem
>>> for us and we are still seeing a performance issue with v6.8-rc4. For
>>> example, running Dhrystone on Tegra234 I am seeing the following ...
>>>
>>> Linux v6.7:
>>> [ 2216.301949] CPU0: Dhrystones per Second: 31976326 (18199 DMIPS)
>>> [ 2220.993877] CPU1: Dhrystones per Second: 49568123 (28211 DMIPS)
>>> [ 2225.685280] CPU2: Dhrystones per Second: 49568123 (28211 DMIPS)
>>> [ 2230.364423] CPU3: Dhrystones per Second: 49632220 (28248 DMIPS)
>>>
>>> Linux v6.8-rc4:
>>> [   44.661686] CPU0: Dhrystones per Second: 16068483 (9145 DMIPS)
>>> [   51.895107] CPU1: Dhrystones per Second: 16077457 (9150 DMIPS)
>>> [   59.105410] CPU2: Dhrystones per Second: 16095436 (9160 DMIPS)
>>> [   66.333297] CPU3: Dhrystones per Second: 16064000 (9142 DMIPS)
>>>
>>> If I revert this change and the following ...
>>>
>>>    b3edde44e5d4 ("cpufreq/schedutil: Use a fixed reference frequency")
>>>    f12560779f9d ("sched/cpufreq: Rework iowait boost")
>>>    9c0b4bb7f630 ("sched/cpufreq: Rework schedutil governor
>>>
>>> ... then the perf is similar to where it was ...
>>
>> Ok, guys, this whole scheduler / cpufreq rewrite seems to have been
>> completely buggered.
>>
>> Please tell me why we shouldn't just revert things as per above?
>>
>> Sure, the problem _I_ experienced is fixed, but apparently there are
>> others just lurking, and they are even bigger degradations than the
>> one I saw.
>>
>> We're now at rc4, we're not releasing a 6.8 with the above kinds of
>> numbers. So either there's another obvious one-liner fix, or we need
>> to revert this whole thing.
> 
> This should fix it:
> https://lore.kernel.org/lkml/20240117190545.596057-1-vincent.guittot@linaro.org/


Yes I can confirm that this does fix it ...

[   29.440836] CPU0: Dhrystones per Second: 48340366 (27513 DMIPS)
[   34.221323] CPU1: Dhrystones per Second: 48585127 (27652 DMIPS)
[   38.988036] CPU2: Dhrystones per Second: 48667266 (27699 DMIPS)
[   43.769430] CPU3: Dhrystones per Second: 48544161 (27629 DMIPS)

>> Yes, dhrystones is a truly crappy benchmark, but partly _because_ it's
>> such a horribly bad benchmark it's also a very simple case. It's pure
>> CPU load with absolutely nothing interesting going on. Regressing on
>> that by a factor of three is a sign of complete failure.


We have a few other more extensive tests that have been failing due to 
the perf issue. We will run those with the above and if we see any more 
issues I will let everyone know.

Thanks
Jon

-- 
nvpublic

