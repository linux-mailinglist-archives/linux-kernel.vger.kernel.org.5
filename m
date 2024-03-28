Return-Path: <linux-kernel+bounces-123305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93463890651
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A8B72A54A2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6315B5D6;
	Thu, 28 Mar 2024 16:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZKEa43GU"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5487940856;
	Thu, 28 Mar 2024 16:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711644592; cv=fail; b=bf/a6QFnDIQddWe8KW1eQWxBLCave4i/LTwTIghDCG/27ORdA2hDAtrgxn16ovxrN7O3s5LE82lgwwymNlLBg9m1KX4zmTh4Rrk8wT56JAnKcixdGGgdBbjXappx8si2gBhrI/rDsooC67WfN1ZaxfvojQvZP96RHFJiEv8vd1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711644592; c=relaxed/simple;
	bh=vfr8oPqicmvLFiY9/ueM5hD98OphbYDg6wgJEaK7K4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S7Ufn40qnR1hwD25LzPAuTfQbm4hu1Ay1PvYSq0iV1xYfUmvhphNQJwKqf1ugOSuzcaVdKKrdMHq0GaAnXBClXDxSeOgRqJ0wBTG+bkCvcsJfRWAkvzdHvsfv1kSVVikHW2X9fo8tVuiK2mf6ujhIboWZXRnLfL2q9XtAzcvPGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZKEa43GU; arc=fail smtp.client-ip=40.107.244.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILjjrSQddzZ4WTrm2w1BCs43Z1VT24rdEzhUvknd+LXn+elOj0Z1ewLVsQMRWhBcLXXRlvM5sLxpEA0ogOxMuISuPp6270nuFztiUnl037yIWyAbqvo9e/8TFTviWXr4ifgExwD3iT65kTewZh0KuGbfs4zKqZUDwcPEHa38bm6QiTjxwyLfKTPYGSQ8i0CLPV6OTnNqudFVTs6QgLPIxsUH4aygZ5mvmFrcD7nnhBFpVwIoO8l9G2Oma4v4ql1spNa7J3FnivomvLVFhrxx0CY2F8B3Y7qJFv5WwZfi4eTU0oeTCbrlNJk/HMMhfRHBQDE4HiLgeTzWnSsSLkXDpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u9S7DxOd1oZDn9BeIdLbAtE0v8HyuwcDpWjS4zgPwYU=;
 b=ZdiW3gAd+HgqVHoaIhIdg8/m0TGgvGyAdPY2JIT9d6zMMikm9YnOqsQwTZtsfpLWr/TMm82IOZYtdFyALN1VmMEuXfAUktX0s6yH7jWDqEqeUnRcp+xz+oXqib+FaFvtyb/Aaql5qKRRbUQFlEvQQPdJZrogpf1ZMzENcQeRisN6eM6sH+IOJEeinF8VwtNObxJfbFEUwGn8+LgA8p1DLY88W3Ooq3j26CYKJGfzomw7LNtyGXvBMcvuJsvJy6z48zQ14wU9KTxukVfoNpfIwZ7NPEo38SEyremZIw7+LkTZI/x5BClzuwrPTSH+iwHHyk0xIte4GBCHAKhc/c+FOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9S7DxOd1oZDn9BeIdLbAtE0v8HyuwcDpWjS4zgPwYU=;
 b=ZKEa43GUe2cUMX05lmXQ8nSRg1+bG/XolmwJ3vvL73DFf8J04BKdNJTVw8aJ5Sr5VQiaUKF5zutSRWSOyIy4C9i8Pi/5QPYbu9EKqrLJKNPPiKOuqar+8woQxOwiAjZ5/YJsqo3IXOz5yG/ATnRfM9/MGEiWfO8JPDUZcM4Sn4g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by SA3PR12MB8811.namprd12.prod.outlook.com (2603:10b6:806:312::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Thu, 28 Mar
 2024 16:49:47 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::9d:17f1:8b3b:1958]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::9d:17f1:8b3b:1958%4]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 16:49:47 +0000
Date: Thu, 28 Mar 2024 17:49:40 +0100
From: Robert Richter <rrichter@amd.com>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-acpi@vger.kernel.org,
	ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v2 3/3] ACPI/NUMA: Remove architecture dependent
 remainings
Message-ID: <ZgWfpFseS3HTO30V@rric.localdomain>
References: <20240319120026.2246389-4-rrichter@amd.com>
 <202403220943.96dde419-oliver.sang@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202403220943.96dde419-oliver.sang@intel.com>
X-ClientProxiedBy: FR0P281CA0259.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::18) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|SA3PR12MB8811:EE_
X-MS-Office365-Filtering-Correlation-Id: 877f4937-3ef4-4f10-4a2f-08dc4f4713a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Z+PS79SH32vbze6nyDVOJklFWrg4pGfxuRGh4dN1zGf2PwEjKCxoQDiFzHQwmOpXqLuga2dx8ZXLs6qcs39F/1BFF/iekw2ppZL3Mvm3dVSQ8JGQwAJP7ECGxOil34ezUJTCXb7EvK6lSZKsnogfDFap63Pv9RKc9GzrLx4jrGCXMunVZKwigSaSf1s8R2cxtXJ0gfPG3TCIqEp9NW5Vcyg5jmff1qevlQMaqnE/WJQm0oX1/A6P0+O+/mBHYQ9TpK1boZGi49WnrCgXdD6Amq7p6tSXIhu1n/ifNHyJRrAdC4f2JEAdUNDNzQtMgJkZNtDkm1+Tx2eXNv12yAgYLkrpQMSko/VljXXpZyhbOVwdBqdlY1X6lsCTCQpTH9x6Me7Ode86YJrKaYDttzTQ5IV2bjeQaM77TkxuSm3bFz4KWrt46uhwPHrlfI4V/hXm0nxGhlQ4es7eZbU41Cm5wUvPpDVtOTs26aN/wWcLs8ggycwhqbcsMF4xJ6tPGvS7CWtNsibQgdhK/8VO5CTFzXYYGD7RR0vr0pyzPsYRfJ6YF+dfti7pn/kKC103pb46AG015kWY6eBRvuBe1LbC8Z8DTAfrJ2aQYp8HxxG6zuLrixTQ4e219aWTuCAQBh5Z
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/5+in2hoEhPF0jnO75gmtdoWNaD1NgYAWmFyCCLf49wJxZCr24gdXUF+tHo3?=
 =?us-ascii?Q?0efP4BeZuaUKDs555IBeNENqZtoIB0c9ZemVwjZlXk6OM69xhei5Y4Wm7CYy?=
 =?us-ascii?Q?25yU1FKEXcjcyvPlaLW1gr6ryn+LEhDJCku7XJ6+6h4i3MOh5uRjL1nQ7u24?=
 =?us-ascii?Q?6qUNtS6K3qtE1HK44RhCwSW5mOujZFCk1f+5aeX7OFVHXXChuJm2G5kgbspK?=
 =?us-ascii?Q?+pLeOMTY6Oh0+7CEpm787O/VzyWLnombMFjgtTdOA8HOd4Qpi22/Yg/Gbq0T?=
 =?us-ascii?Q?+RGGrWXFvso/MDF3/buYTpeqhcvQgqXiN02YT7eLNKCUIpT3orlM1zUt9ggH?=
 =?us-ascii?Q?MEpPT4BZVJk31qApYcvwag/O5g4aNJC/AVlO/4zST/RI48UQLSRHtP0WbAE4?=
 =?us-ascii?Q?ivxyKmxnGptGoe0TE071zcrN45ryGp1qd5dQelTIc1d2V24DPR3t5lQ88IBH?=
 =?us-ascii?Q?Ej4sVevrMiTPSe282lkcFt50GrOpOh3oIytzIfToNG4ac1qrg7w8WyMaDi41?=
 =?us-ascii?Q?n8iaqPVMvF7Cucsel1bas72htap6DNW6QNm03WLvV8j7SRtEXqfAaYVfwxxe?=
 =?us-ascii?Q?bGKoRt2Fw39HXWnoTgkD3m9HbFzEOdwzl7VoKhO1DPMYElaBBRer/vttcyLB?=
 =?us-ascii?Q?KqJzuN2I2938IkIjdEd4Z6uiNnYe99CNsDBS0CFEtjMW3yO3v8fwAH0Gc0FY?=
 =?us-ascii?Q?ctDU4zRdmW+DIk7V6RV5NUF5u/Qc6QtFqZuNdWZKBaKUyFb7p4sfntTsWPTI?=
 =?us-ascii?Q?sVPqsm4a5qQwfgVZYRNoVxX3oHgmj/XVPhmXO5NUqpUC5WXpEMRcG9yG1G2S?=
 =?us-ascii?Q?4IN39DeAkFRLbmDq2qs7JnpB/Onv54VOBdTXZRrOgHSFmehNZqqK7eEmpGAQ?=
 =?us-ascii?Q?EALkF8iC4/F6fYi+WGM59PQFysASwiEFuSuKTjvEy7WY9odc6fsMxL0qRaqc?=
 =?us-ascii?Q?u6dckxtoP1wSt3mRpCeU8+hEWE/oelBTWGXXvVCwIK59w3Kmvj2s0+2HmDvC?=
 =?us-ascii?Q?CH5Q1gdRuaOa5G4syZ5fHhM7BJkH8nDBowqnu2THu1M5Hebger08QPRBpQ2h?=
 =?us-ascii?Q?egnjt/noGIhP/rZHFPDDQrKEN1ck6pkbsDiikE/1J4C4W3k4c09mfs/kAx+a?=
 =?us-ascii?Q?mQqBsDZEPOEMNJZaxrhPYpcddvAUz/dT3eBU1Fs+tpTij+CMty8iVraFQLqv?=
 =?us-ascii?Q?pUAT0dXcyDt/2v3G+Ok8pmA3yM3v5fZL2a32QdgMyPcTiDgtXxbsPfXQUjY2?=
 =?us-ascii?Q?zpAHLsxCd7DygeXxW1NkNyMAXfyhPT3KnBFBccecNvkcqshlRTqbvzyL56B3?=
 =?us-ascii?Q?tnIUILc2r+4cHXjU6nw8A+lT7IUKyGfQign23tXW7rpapNzhEwLviMnkFIgg?=
 =?us-ascii?Q?yy4GwKfnli4gL2oWqud9PHnpRGo89A9CNBF0TWMBDxg0DftmVxhtepDPpdoy?=
 =?us-ascii?Q?/FjWmQz6ENoOMbmQIWWCHJ2DLvjv1nKbVITuza/Ohv3JRn9GO+M/pmjBMmQF?=
 =?us-ascii?Q?nhIYAfvXVgwD9m1KJZJ1PmeRyDKyXvBahpILHnVrjYianG7zcwHXaDwhbMXU?=
 =?us-ascii?Q?3hFgQCqWpXcobt4t/dusDHdJKQBRwP6WUoyjtNLu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 877f4937-3ef4-4f10-4a2f-08dc4f4713a0
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 16:49:47.2055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v66RJiaJtx3nW1OjFKtBYTwhvlEJ7+5t484wXsqb7R+ufjQqr53AlocnYeQ++k1vFb5/S2xP4/xlFANNPL8uDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8811

On 22.03.24 10:12:04, kernel test robot wrote:
> kernel test robot noticed a -43.6% regression of vm-scalability.throughput on:
> 
> 
> commit: 09f84589a8ed1162c0274a1b5b3dadb98ee3155e ("[PATCH v2 3/3] ACPI/NUMA: Remove architecture dependent remainings")
> url: https://github.com/intel-lab-lkp/linux/commits/Robert-Richter/x86-numa-Fix-SRAT-lookup-of-CFMWS-ranges-with-numa_fill_memblks/20240319-200345
> base: https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git linux-next
> patch link: https://lore.kernel.org/all/20240319120026.2246389-4-rrichter@amd.com/
> patch subject: [PATCH v2 3/3] ACPI/NUMA: Remove architecture dependent remainings

I have root cause the regression. After refactoring of the function an
error in acpi_numa_memory_affinity_init() is no longer ignored
(e.g. if a mem range is disabled) which finally causes
acpi_numa_init() to fail too.

Will be fixed in v3.

Thanks to the kernel test robot team.

-Robert

