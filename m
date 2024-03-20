Return-Path: <linux-kernel+bounces-108704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7011880EE2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 362D1B2278A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DBC3BB23;
	Wed, 20 Mar 2024 09:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YfjQxxiI"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7373A8C0;
	Wed, 20 Mar 2024 09:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710927851; cv=fail; b=Mz+G+8X5OkxalLppUl0cKHsUF7plO84TTJPj0UIEZY4PoOzELn5oUagV659X7s3koO9zc6AXb4NEmVtCLJkPOFz5ebCyOOzHjhNTe82cEdMmwW69TTAZ6J/iRxe8TLw/D3Yi5+SSEsnY7mwhbUx1llgO96jAsmBRMCVsMwFWtmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710927851; c=relaxed/simple;
	bh=GaQenmY85jGNfun4t+kwPG7FutqRaOcgfZq17gQMwdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FfNeGgNhjkMICXdExzQmPqaXo2xMkXA0guVKLpqcq/AWNo0AoBZP43CHb1BRlTrr1PSdPcb/v4TJZBg1Eb6/hunLVamYC4T2MStSAEHb3kWW6GAM469Vg7D08pEyAzxIj+PG0PdqD+z6e1iJ7+HfpyYXJOX/4HpPcVd2rlx+Mlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YfjQxxiI; arc=fail smtp.client-ip=40.107.220.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z1gz3NpOUySdwlH7C2efDWthZ3h+h7aEzZS0AMhtI5inMsh/iMa4wOeBYkPqo6veRBfjCAWjZaMabuicfqzBdpmb/ZAuzM5edi2xlweIUMUESpgBVpWZy+a33QueW4um3sH9RPjzDlMXfhmqueWlduF2+biTXUg4KbaL6NU7ke+lJPiCnEQANVuzK9I5dSj4NMh35x/oVLbtkuewlVjjx9pT/lpU3sStJp8Ho8w87J4HKwUqGOwvUNy1BKtMZKBqsDXkrWcdstKsBbmPSlXr/aaa4yZBjOuYc8/SYrtkerjHjyY6tI+Qlzd3P9D0drxhojG1/F21zmzVIF2vPFQLhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZiwXt0PHlh67x25kvvpQMBuhN5GNTNn9d8lo2uInapI=;
 b=lrgOHMvmygOexmaCNlWRwdionVs0KKVGZHqNvJv0s8wNafAu4h4OPDHTQak/HnOOIGS1hd/9ufdeu22ao6Z253oY4qcOLa5L0MfvqS1frXDpm1MxgsS/1QE13A4PT8GiXIwTVCs4GdhoMT2Vll+5FgqozpVXjdkASb1XPlHksphPDGGr/dag9w5/o8Qp+89yxRoRnfBuExZPTv0OErNh1zoRu4J14wRQF9LVljcFE3bWGjiZ8QJZzsC+WEgwW2a1pbyrViQwKifRGw4SnAlqQKiZn/RQwJYrvqR/hpgyjBjKWjWEawIhvLLY6lOq8Shwcg9EFNiuusIUe5azQIDDmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZiwXt0PHlh67x25kvvpQMBuhN5GNTNn9d8lo2uInapI=;
 b=YfjQxxiImRJTJa17Xz7wZPhNgtt7qsNjKDuz4UNBt2vgaShZZ62zudjycAt7cwOjSw9FlIyexu0lVwXZXgUe5VdAAJHa159HMAZt5J3SvZXzH4inq5g45fit2oLRZNmWF494c6K2PK2DA/RjZzVbAiPntRmfx2PtCm3yQ4n9lLk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Wed, 20 Mar
 2024 09:44:06 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::d725:ec0f:5755:769b]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::d725:ec0f:5755:769b%3]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 09:44:05 +0000
Date: Wed, 20 Mar 2024 15:13:57 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Perry Yuan <perry.yuan@amd.com>
Cc: rafael.j.wysocki@intel.com, Mario.Limonciello@amd.com,
	viresh.kumar@linaro.org, Ray.Huang@amd.com, Borislav.Petkov@amd.com,
	Alexander.Deucher@amd.com, Xinmei.Huang@amd.com,
	oleksandr@natalenko.name, Xiaojian.Du@amd.com, Li.Meng@amd.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/6] AMD Pstate Driver Core Performance Boost
Message-ID: <Zfqv3ckVU4km+RLr@BLR-5CG11610CF.amd.com>
References: <cover.1710754236.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710754236.git.perry.yuan@amd.com>
X-ClientProxiedBy: BM1P287CA0007.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::36) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|PH7PR12MB5712:EE_
X-MS-Office365-Filtering-Correlation-Id: 73551cc4-ce77-4287-a678-08dc48c24861
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AlGu0tEpTmDK1HQk97yu3/opkGJnLLNHQgOvmYDK4jCEjOV3Y7JBdeRUALsIVmdXJL0mqeDVPUgD9fjZZXTSSzqP9J9ORHG+NuypWNPiRJSTjFO0bJ3pRZxEWXtPyqaghp9SnSeU+3UWPHClSlG2UwAYP92x3oBDbNjHZxGmXI6W1ZeJtCp9H5N8loryTHp0VM8Wnj5yHqbyvBBTmNihuYebKmd1EHV/nMihsE/RcaFhnIYaV6JpkWyKR3RRmTqxNIgBBxrOiafzjaVnOVgBbFC42Q/OdSsbdDG90Tb+GdixMi6+rRHbd+8QfrXl/5OjybsDzwx9q/vM+3UdacPQy1SkTUmXWAW6VTxmki+gHrJ05Df/cuKxCqZSRXTDM8+cLpWvgQxDAf02HJP9a1cE+Vxgz9++x4gYjlcZo/bFXUpmL0qfdXq8BsgzJmWWMhjbTZVmuWB1Ea5kBRJi4tH5h3qfNYps8Td/DofReUJOP9bnwFHi2sbpcmL4a7L+fnWOkIoeULuE0P4DH6stC/9hG1sUzOAQsoYqHvKKSzq36VIgunst/Dd/O+/Jivt32Qu9KNjEJCu3QRhVGhuQ+5cetuQdyz3lbPVzNgKrKxrZh7XNdaHJClbTiZ67cIjpBk6X
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7hOOgbqE/pDQcGUebUkS0r6LQuhUzm9YWWltJV3xM0Lm9v8wz16XacxJLI6E?=
 =?us-ascii?Q?tnZC7QA3WAQtTW4DojwroJ8C5C8kjVcCUV+hUoISmtXEYg1ZzS/xIHFf02p7?=
 =?us-ascii?Q?ds3+RD9DZaqpFYlvqLKPrHreiuoohNUX1/sb4AW7yIEIWRxOcNv2Uz03EOPt?=
 =?us-ascii?Q?8yb/iQRw2lahN6yaC8OAr30Fbo32Ed9FovgiQpI+NaAtEN15V9XjH6xQVYQs?=
 =?us-ascii?Q?vn22kTQAbRanjDWqj0C6J3CibTGKHY/Z8u6D04mVkYh56DOfJeku3jOnKYVC?=
 =?us-ascii?Q?2JcRglnpyrGdW2z0TXYLWRsa+3+PveWjIqT174IwHCZyioGHvRrPGNK3b1zk?=
 =?us-ascii?Q?hIfzF7zS0Wo8RP+u5mhppAvk6Ap/+nMQyy71vIEFn8AX5c5edyGqXdPeq/++?=
 =?us-ascii?Q?MgptjtJKasABFdFfpTB36So/v1B2bMHwxgXMq3PdeagmAKutqhN6xeDCL8+q?=
 =?us-ascii?Q?UfDsiOWQtOVsd5yuOZFzMmJptjA0XyNV9SOUwDlvkNwrDrOhiHNIsyOiC9Zy?=
 =?us-ascii?Q?KrvC+wgbmZe1STY8NPjlzu7eDZ24RTVsD/0DPVIQU+FqBtJH7vDnD6MAtebw?=
 =?us-ascii?Q?pA3k31+lABCzG+cl6/dRSu5zInvlSMluRSMqq3iqbHVP+kGZcdLKmV+Wpuj9?=
 =?us-ascii?Q?NgGYTmB85lM0QJsfinIehrNLFEZzd6GSCDQor3zU5lzI6LAQ9N1fTOo3NeoN?=
 =?us-ascii?Q?xkRvZ6T/X7KXgartc1zAHVgGCaJVR4wbhBR1r/r1jtu9Dq043IMtc9eP0Avj?=
 =?us-ascii?Q?zWwaSIFbf5fM2vQXR76jhx86Q7jRgUr7HMwNTC+Iw2qiQcdAy7E6WLJPvqxl?=
 =?us-ascii?Q?vJ1EeRJU0esYCui7KRpdVkj2IRNgE0pz1a6tsMdjEvE2NpqMKVH5pgv31GTM?=
 =?us-ascii?Q?1rd8BTrk3nhqOALwGb7KtRavWg31g989TYGCmmYO9Ub+/AVvmpHNJQGvhwZi?=
 =?us-ascii?Q?bCEbJdlwxu/z4JAMWHcmyaRO6WRX/KsI8pNrGVQzGKXFUsyh3zc+fSp4/LTx?=
 =?us-ascii?Q?6gyBh7eNB2mo13NmHTbhg3x9ib11ca6aRf1fEJkt/LMvkbkSTlmhhZ70rgdG?=
 =?us-ascii?Q?m5k26sMOsRjHYFyLM4k99pu/PYRg3/yvWMRZC0K0BxaMiOKIooGmm1E/EvEA?=
 =?us-ascii?Q?Dewxmz7r/0DUfDXQNjjtDeihbKsdiXcS1EmU+DnRPtfZuhXiJEyBnsQ43ET9?=
 =?us-ascii?Q?5xDUFBxYHd0lVzfvVHtN5asK9tZG7JWZZlLwuuOjkrnQitYceFtoOK4EO5Ox?=
 =?us-ascii?Q?iWcJXngv07t0a+N066SWG/aDuKWB72UuDDCikWDs/a9uc58kEtW4na5S+XBJ?=
 =?us-ascii?Q?ZBVKtCIH5+YVhDZ8r+uBHELRZKEpS2P3KbN9MiK4/LMQKOB94iGeSJE/uDMR?=
 =?us-ascii?Q?bXZZlC7e57SVfUbdqja25P6WNE/B3vXc2yAD3iwdEvkWgxhttvEI2DrwFWDj?=
 =?us-ascii?Q?4IP1l6VME6VYew77XBC3R5mymrhO/XfEvOE6hQB3vOGqAlNks/VJkA5Fk5+y?=
 =?us-ascii?Q?371mWzqKq+bGzHqpD8MpRCp5ix6apbbvnq6pU1IyhlXR4SEwOXGISrSiFx2j?=
 =?us-ascii?Q?s9l+qii168wXCMvR/xC5jPyBOaPJAbuleiQ8ZwDe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73551cc4-ce77-4287-a678-08dc48c24861
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 09:44:05.8817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u3nJXVgzbaNU4nm3TDJuhiAxdUp4HZx4YyFbPNt+mDk90PrecONy+z6JTY6neXsNc+75JfM/k7sA6z9IIU4/gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5712

Hello Perry,

On Mon, Mar 18, 2024 at 06:11:07PM +0800, Perry Yuan wrote:
> Hi all,
> The patchset series add core performance boost feature for AMD pstate
> driver including passisve ,guide and active mode support.
> 
> User can change core frequency boost control with a new sysfs entry:
> 
> "/sys/devices/system/cpu/amd_pstate/cpb_boost"
> 
> The legancy boost interface has been removed due to the function
> conflict with new cpb_boost which can support all modes.
> 
> 1). enable core boost:

You meant disable core boost here.

> $ sudo bash -c "echo 0 > /sys/devices/system/cpu/amd_pstate/cpb_boost"
> $ lscpu -ae
> CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ      MHZ
>   0    0      0    0 0:0:0:0          yes 4201.0000 400.0000 2983.578
>   1    0      0    1 1:1:1:0          yes 4201.0000 400.0000 2983.578
>   2    0      0    2 2:2:2:0          yes 4201.0000 400.0000 2583.855
>   3    0      0    3 3:3:3:0          yes 4201.0000 400.0000 2983.578
>   4    0      0    4 4:4:4:0          yes 4201.0000 400.0000 2983.578
> 
> 2). disabble core boost:

.. and enable core boost here.

> $ sudo bash -c "echo 1 > /sys/devices/system/cpu/amd_pstate/cpb_boost"
> $ lscpu -ae
>    0    0      0    0 0:0:0:0          yes 5759.0000 400.0000 2983.578
>   1    0      0    1 1:1:1:0          yes 5759.0000 400.0000 2983.578
>   2    0      0    2 2:2:2:0          yes 5759.0000 400.0000 2983.578
>   3    0      0    3 3:3:3:0          yes 5759.0000 400.0000 2983.578
>   4    0      0    4 4:4:4:0          yes 5759.0000 400.0000 2983.578
> 
> 
> The patches have been tested with the AMD 7950X processor and many users
> would like to get core boost control enabled for power saving.
> 
> If you would like to test this patchset, it needs to apply the patchset
> based on below one latest version patchset.
> https://lore.kernel.org/lkml/cover.1710754409.git.perry.yuan@amd.com/

Thanks. Will test this on EPYC platforms. 
>
> Perry.

--
Thanks and Regards
gautham.

> 
> Changes from v4:
>  * drop the legacy boost remove patch, let us keep the legacy interface
>    in case some applications break.
>  * rebase to linux-pm/bleeding-edge branch
>  * rework the patchset base on [PATCH v8 0/8] AMD Pstate Fixes And
>    Enhancements which has some intial work done there.
> 
> Changes from v4:
>  * move MSR_K7_HWCR_CPB_DIS_BIT into msr-index.h
>  * pick RB flag from Gautham R. Shenoy
>  * add Cc Oleksandr Natalenko <oleksandr@natalenko.name>
>  * rebase to latest linux-pm/bleeding-edge branch
>  * rebase the patch set on top of [PATCH v7 0/6] AMD Pstate Fixes And Enhancements
>  * update  [PATCH v7 2/6] to use MSR_K7_HWCR_CPB_DIS_BIT 
> 
> Changes from v3:
>  * rebased to linux-pm/bleeding-edge v6.8
>  * rename global to amd_pstate_global_params(Oleksandr Natalenko)
>  * remove comments for boot_supported in amd_pstate.h
>  * fix the compiler warning for amd-pstate-ut.ko
>  * use for_each_online_cpu in cpb_boost_store which fix the null pointer
>    error during testing
>  * fix the max frequency value to be KHz when cpb boost disabled(Gautham R. Shenoy)
> 
> Changes from v2:
>  * move global struct to amd-pstate.h
>  * fix the amd-pstate-ut with new cpb control interface
> 
> Changes from v1:
>  * drop suspend/resume fix patch 6/7 because of the fix should be in
>    another fix series instead of CPB feature
>  * move the set_boost remove patch to the last(Mario)
>  * Fix commit info with "Closes:" (Mario)
>  * simplified global.cpb_supported initialization(Mario)
>  * Add guide mode support for CPB control
>  * Fixed some Doc typos and add guide mode info to Doc as well.
> 
> v1: https://lore.kernel.org/all/cover.1706255676.git.perry.yuan@amd.com/
> v2: https://lore.kernel.org/lkml/cover.1707047943.git.perry.yuan@amd.com/
> v3: https://lore.kernel.org/lkml/cover.1707297581.git.perry.yuan@amd.com/
> v4: https://lore.kernel.org/lkml/cover.1710322310.git.perry.yuan@amd.com/
> v5: https://lore.kernel.org/lkml/cover.1710473712.git.perry.yuan@amd.com/
> 
> 
> Perry Yuan (6):
>   cpufreq: acpi: move MSR_K7_HWCR_CPB_DIS_BIT into msr-index.h
>   cpufreq: amd-pstate: initialize new core precision boost state
>   cpufreq: amd-pstate: implement cpb_boost sysfs entry for boost control
>   cpufreq: amd-pstate: fix the MSR highest perf will be reset issue
>     while cpb boost off
>   Documentation: cpufreq: amd-pstate: introduce the new cpu boost
>     control method
>   cpufreq: amd-pstate-ut: support new cpb boost control interface
> 
>  Documentation/admin-guide/pm/amd-pstate.rst |  11 ++
>  arch/x86/include/asm/msr-index.h            |   2 +
>  drivers/cpufreq/acpi-cpufreq.c              |   2 -
>  drivers/cpufreq/amd-pstate-ut.c             |   2 +-
>  drivers/cpufreq/amd-pstate.c                | 143 ++++++++++++++++++--
>  include/linux/amd-pstate.h                  |  13 ++
>  6 files changed, 160 insertions(+), 13 deletions(-)
> 
> -- 
> 2.34.1
> 

