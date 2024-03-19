Return-Path: <linux-kernel+bounces-107599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A3C87FEF3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C78081F25D4C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED3E80609;
	Tue, 19 Mar 2024 13:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mzde1d0o"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2128.outbound.protection.outlook.com [40.107.237.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D711CD07
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 13:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710855532; cv=fail; b=urEqdNKOlTRlLM4ubrgvSwZR/YyTQmiUz86g3KhMuJhka41SaKgBQ5Rqva7Fi8DPpRlDJoiOvvjBdoowM1JIky1zfvIsYSuwwPQP78twp3Tc+f7b/Vnn2qzIo2pJnQ9nK4lCnq/HcJI4ZN0ReALf+lD32OCxSpaVVOqZsUdBQPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710855532; c=relaxed/simple;
	bh=mpUfP2K7IHHm+5RX74S8ATcf264koPdo4htRnkiWpIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Vb1QK30wM5bSN3SNYH9PnQGCf/sfo4zdplFsTzJZosrQoSGQuW1GwvVmHVZwp/UzSr5OAwOJU9iugDUUYsSESYmrwRo+VKL83nGWGi8Ug4JEsPKjbsKCt1+UjA5Xt9hS1pzW/Sc3L1aaQwnI8PGmU2t/d25189gOKcOrLFL73Ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mzde1d0o; arc=fail smtp.client-ip=40.107.237.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SZ/3/yAWHt/IXUkPDdjJ0w5TSjhWxlbUYvtvvywrXPbFYmq09aE7qX82gywCzQvS4azzjrUWCZJYN7I+EOSduHstOfk/wrQdvil22wIp/QzC783cgpilXt2ykS8fU0pQ8dzj0qXLnksM2oWd6Q3YxT52/VNrREugjYAJ71bB18p621CICdVPpifZ5ooTCyw6CDki+/FM8B9/oVzgSlCkARXVtR7M2rXH+uspOdXsexaqUBve775+4Q6qzui6R4/UZ6J7fFa0Vc0gr//2WoQQPyTHgJXJVKoxL9L7TepFUADaBnyy8EHJfhoP1TWJYoNHdMqTUqoKv3RCkTUFiVu6Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DH+JDqodS13IY22lxMv+aOkK4H1uljpUqO2cCONdaWw=;
 b=djtg2CPb20+pXySI7QcYWPYEFVzG1SqTgWjR0Xt8MpLw0YyhNPRYfNTijJKjFniPU9uIWs4gt7NijzB01/RJwIaxnq4jtT1r6KSPNNfSCM6HJpGoMoeZF6SHIwMB9qfHgwMnByMQKw/X9rPJI4Zlp4J/vLmJuil+os2ESRJgxnK9XVolaorNUftM8Zimf7ql2tJHQLlYk1YPJW9LNQhB29kSXPyuQWOf2YJbL2qZxPpv7Eo6CR5fADv5eHubfKVVbLa74wlhqLG7oiZ8NWXl1neVzD2ekbGbis2UNsdkPGgV/YJbcnxOEm1Hau6XnKEw6FITzyle4iwkxHKxwwc9bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DH+JDqodS13IY22lxMv+aOkK4H1uljpUqO2cCONdaWw=;
 b=mzde1d0o5xezmOjdZtXC/lmeU7EDEgNG4iUNsvGrUifYVZ5HNuPafE1XIvOaIpzYKY1jyWpA5AkDYEH0cPnXG8Y/OyVPmKTcfApPHOqfpVoLynWQnAD0DPTfQew5Gr+yz6UeoNMp+eZuvZj2gBrfy4i1zJHIK3+cq35yDvS9I80DpfqaEv56T/lARMVcCATa2FsvqVpFxJQ1GIb33hH8Q92aKvMmDyzTk8nmLiwRuPhCkTU8sQpyaG/irqSdLhkI6XufL2gUkB1u2emeh2dlKyapla0tXRl7brHnfQ5nm9HyBn3VUklkEovG2/73yw1Vb/pB96ax6ziv4mDaj3cqkA==
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by PH7PR12MB5734.namprd12.prod.outlook.com (2603:10b6:510:1e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Tue, 19 Mar
 2024 13:38:46 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 13:38:46 +0000
Date: Tue, 19 Mar 2024 10:38:44 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Ankit Agrawal <ankita@nvidia.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	"maz@kernel.org" <maz@kernel.org>,
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>,
	"will@kernel.org" <will@kernel.org>,
	Aniket Agashe <aniketa@nvidia.com>, Neo Jia <cjia@nvidia.com>,
	Kirti Wankhede <kwankhede@nvidia.com>,
	"Tarun Gupta (SW-GPU)" <targupta@nvidia.com>,
	Vikram Sethi <vsethi@nvidia.com>, Andy Currid <acurrid@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>, Dan Williams <danw@nvidia.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] KVM: arm64: determine memory type from VMA
Message-ID: <20240319133844.GA159172@nvidia.com>
References: <ZR7hKYU1Wj+VTqpO@arm.com>
 <20231005165458.GM682044@nvidia.com>
 <ZSVe0nb02S4kz5D2@arm.com>
 <20231010150502.GM3952@nvidia.com>
 <ZSWHkvhutlnvVLUZ@arm.com>
 <20231010182328.GS3952@nvidia.com>
 <ZSbfUNLwDkaYL4ts@arm.com>
 <20231011183839.GC3952@nvidia.com>
 <ZSgb0WBSsXHHYJT0@arm.com>
 <SA1PR12MB7199AB860E0C76B80B421C66B0252@SA1PR12MB7199.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SA1PR12MB7199AB860E0C76B80B421C66B0252@SA1PR12MB7199.namprd12.prod.outlook.com>
X-ClientProxiedBy: SA1PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::25) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|PH7PR12MB5734:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nl9L4OvG9rqHxoW9XWltK1sJrB9TcwIfzCZwlok5NYaGv1JKtIdaVFH9FH3JuelnRnPCgRWiikdfGUpS7zOc96SaQjGp4aGtW36gxHkUq8S2AS5ExtkrM72NV/Lqfg8akAGQxsEErpYfCaCcAbnl8G+z6imma5F2mWbUb4w31yJNXAbjW0A4+pD2Cx7Ahczj6xz0aljCtm3io8HzUxyCO8Er11GKGfLQPcKBTI9I7qi6JOjYUjDk7kElJOWoPJQdnHcoAD5zHRHN30naTE8wNxZcSDZQt918udzm8pqEXik/AlaZeH82Qdl+XsLkr6eleQu5w5pLMuNdo41S0/QP8B8iG1BmBZybjobshcwerIBcpftvG/BlM/ZCIisFBuDYi/460t7vNmMoKEaCNQfD+SyeRdf4OnfpYvPcnk+o0LtPU1N1cQXEqnr4d4QI4TwYv9j7BC+QdKI8RMyIlE4stinLn4/EOF8jvlQ+SLDrvHqepT+iUy4ZU57/OA8mi5dSywDDcVInuMj9pdbIp7GWKDeXexOTmVA67T6S/Vg/rONUbYDdulvTIhgQ8XQFhnsM4aMR1njHZziwvrtcEkX6DsA6feWudTP3Ljl5hpYPEnu6Qaq8JK6QSk2jHMp5UvUCGBwbtJn2WOUWP7bVslvX8SBRTgx2BxBw8cjwRQwKaY0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WlNXMnRtRkVwYTI1b3AzT3p6VEJSWHFRdTRqQ3cwTlFlL0FKSi8zTFg5aGM4?=
 =?utf-8?B?aGRlWXEraTduQ2NLT1I4Z1pqRTg4Y1M3clZSNGJQNkNIbzhFeTdTQXd4Nkkz?=
 =?utf-8?B?MEcva1NJbi93V1g3b1hIY3dBVFdkVHpiV0NHU2N5UHJ1YlVFNEF1ZFZHUlhV?=
 =?utf-8?B?M3YrYk1nV3M1OGVlSDdsdW1Kc1AzL1NYREdTdkJIak1PTlo5ejY4MHNtakFi?=
 =?utf-8?B?QUhSbVd0M3ZJR3BGMVBJVG5pa1JDMkVFK1VZeTRZTDdwZ2xlaGdIUG9RT3Zn?=
 =?utf-8?B?RDdIUjVKMkNtL0lZaHZYaHA3ZEJDdTBsV0hIOStwd2pIb0M5bzdxaEZuNkFZ?=
 =?utf-8?B?REFJWDlWWDIyTXZaaWpaRS9LQUx5MVAydEFZTGdYcmpsK2REY0NRTjJmajEy?=
 =?utf-8?B?ckVYVVhISWZQRmhlM0QzUlMyaitLeStUSjZBeTllMmswZDVLOW8xbzY5ZHJD?=
 =?utf-8?B?Y1NHbHFOejFEaUdLSzJyWHU4YlRhUjZsalA4WnAvWTJJL2lsN2dSb0pLc0Er?=
 =?utf-8?B?UllpY3ZlZ0tkUzEycDBsVEZXUGFVb3oxcUx4aGYydHYzdFpuRFBXS1ZjdExS?=
 =?utf-8?B?bFpxSlBtSUhYeEJTdVBIWWNtdFlybS8vRXl2VkZCTVNDRVlvcXRCMzhPVFNH?=
 =?utf-8?B?N0JORW5nQkNzbkN2K3FyQjVxT0M0am1JQ2JVaCtXZHBjSkE0enF1YllSaExp?=
 =?utf-8?B?TjBwOVNsN2gyMmZDdEZjL1FKQWZDd09WbGJTRlA2RlptOFpxaHRpSGZkOFFz?=
 =?utf-8?B?bjB1c1c0elppN1BSd1F6cHJIVzNkemlxOVdYcm1mMndEUG15S1E0QmFhWFc2?=
 =?utf-8?B?djlNNHdlTXBGUjhMbTFtRVIySmt2aENWamVIRGV6bTdQQnVRM2dlUmdSaHBP?=
 =?utf-8?B?VE05NHNzNXc1UDVHcEU0WDdlY2Z6NVRyWGxTSnhHR3VkL2ZpYStTSW54alI3?=
 =?utf-8?B?YUcwWlF2ZWk3UzR1UE9tSlhkL3RGa2xqOFB6SjNlTis2NDhheXU2cnNhWWMy?=
 =?utf-8?B?ZWh5bUNIYVhQajl0SXpjMitWRkRKbUw1aWpsQXVTTFBoUjErRHZmZ1BuLzJP?=
 =?utf-8?B?eDc3UytSUDlycGxmVncwVEhIZHRtK0ZiOTg5VmY2aEdCSFA5Y0UvakVocnpj?=
 =?utf-8?B?aXZtNnhOczJXVjJBcFJlUGJGYmRrU3BRbzk5dDNjd3hzblRwZFlCVE0zUG90?=
 =?utf-8?B?aGdDWHU0RFYxd0VNZUNUdHNnYmcrQm1VNUJZRDM3bjBRdXRodlhxVUdTVFQ2?=
 =?utf-8?B?SCs1Y1hVR05GaFlzZjlLMXNCUnpwVi91UURJQXphRUQ2NVp0SVIrMVVPbjdL?=
 =?utf-8?B?bitwUDdGVDVuU09RQXhqQnE2cG5OcjltYnh4VXJMTTRoMkIzZzl1eGQzTEpk?=
 =?utf-8?B?Tzg4T3hid2dPRmRBVmI0b1BNTlhCWklPTjVqOVJuckxrcmh3b3BiT0xESWtx?=
 =?utf-8?B?MUxjQ0VIR3ltTGxSUTJrajVxNjZTRWNSNW5uVTRwVkcyZnViNENJSnZmbVlS?=
 =?utf-8?B?YWl6eXNXZTlKTE9pWGJTeHFvSENVOGhVQmlBZVJLd0dxbjZER1N0anJ2VnZo?=
 =?utf-8?B?UDhnbFZuS3liSmR6RzgyZjZqTWpGQStjM1lvUThWV0NpWU0yUm5xbVJLZ2Na?=
 =?utf-8?B?Qko2NHlxMXp1NEFFVFhtNGhiaWZoOUhQWllrdC9MeThWalFZV1dsd3pMcFFJ?=
 =?utf-8?B?Sy80aTdQRkd4c2NpTXVSMkdmTlY3SjJUTVZvWisyVE15bGlwVXlzc1p5V25w?=
 =?utf-8?B?SGFma0c1NS90ZVBRNllJV1RYWHhUQm84L2NlTWgwMlkvcVZGZmdRUXd1SDNU?=
 =?utf-8?B?eXdvQzZmRFpOWXF0WHlsOG05Tlo4QjlsQXlucGJEWHlEYWRvTVY5cWpHR3ZB?=
 =?utf-8?B?akZJUEV4cURPRFVyRmxzcU5JNFUwQlVBS0dVMXdMMXV1d1EvNlBpQkw0RUNT?=
 =?utf-8?B?ajhLWjhtaVFQUHUxYWpSbjgyV2NIZm5ZTSt3YWd3ZjRlbm9vcmlrdnRiVkFp?=
 =?utf-8?B?SjFXZ054T0c0R3dTRG8vSitBOWhITEUxOXRWaUZ1ZWxHQWdOeFBxV1g2amQ5?=
 =?utf-8?B?TFU0YVVwb1MxckJVd0Z1RXpVdkdmL0VoQ3IyYTJHME9jRTNJOEJkMUs3UFFy?=
 =?utf-8?Q?wAIfEYScl14fmN/s2NI0PhQWP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cba0a24a-ff33-430d-6724-08dc4819e6be
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 13:38:46.4066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GRznsRzWrcgQyd+MPWEqIRIfkUOc6IG0trIkihqZa3jrcWG3uW9Ivr+ZDpIFkMDf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5734

On Sun, Mar 10, 2024 at 03:49:36AM +0000, Ankit Agrawal wrote:
> Bringing this to the fore.
> 
> >> Where does that leave us for this patch? We check the VM_MTE_ALLOWED
> >> and check for ZONE_MOVABLE struct pages as one of the conditions for
> >> NORMAL?
> >
> > I think we should keep it as simple as possible and, looking at it
> > again, maybe even ignore vm_page_prot. Two questions though:
> >
> > 1. Does VM_IO imply vm_page_prot never having MT_NORMAL or
> >    MT_NORMAL_TAGGED?

Drivers do crazy things, so I would not be surprised if something in
the tree does this (wrong) thing. We can check the pgprot in the vma
as well as the VM_IO to make the decision.

> > 2. Do all I/O ranges (side-effects, non-RAM) mapped into a guest (and
> >   which end up in user_mem_abort()) imply VM_IO?

Yes, this is definately true for VFIO.

Jason

