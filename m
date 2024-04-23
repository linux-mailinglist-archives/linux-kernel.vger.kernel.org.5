Return-Path: <linux-kernel+bounces-154885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB718AE270
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CDBF1C217D5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B3F64CE1;
	Tue, 23 Apr 2024 10:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="q/WM6ZLS"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C15219FD;
	Tue, 23 Apr 2024 10:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713868874; cv=fail; b=VhtMeeTLh843jijeD2goHo4OjDK6sj7TsZy3aChCf0CAVjJdWAEJcQ0gexJ6OKqDLcDZvfKt8N4IOqLRmKzAQiOeH6hIdg14EUnILx2+nWnRmbTiAnb5O/Ru54pftUNL/AReY3xnMyKatlKmAyoPLEAnd3dEmM/N4em3qv9sxUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713868874; c=relaxed/simple;
	bh=tnTBPyQ9JYT9/F06p6aqlMBUqLC8WEaqIs49sGuaHcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k+WT6/Bx6HTCLEIu/u1iX3M8pVzd22Kkz8Zdj4sciqeTcHGfyU+0XAEwfJjUAGQaUhg8KLFbbx46AGe7iXLq76koTsWjavEqCCZoNPLnsye3It19YhSxbyLOhOpvRqAnllyB2XmEaZUeJcSJRmexgOi/rqrOPoewDzb+wfNSEJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=q/WM6ZLS; arc=fail smtp.client-ip=40.107.244.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XG++iUmyOZUlneVyjbScBlMdLMsQc7lOkMYvk9gCJefntvKPOVTzJjZoKITryHfWhXmvSJwsXzNdGbmEhuP9B6Tjuh2xInIQoTsVXAtdjPiydAf/nDuvVNV42DsEBXEYxCvTBaGvwKicL0RMRcj3Ip5dtFAtSWfM56FcuBtZc0dNOgjx/mDc43svR9DOPxCOPKQP/Ohi0fIyRDj/nUx6kN3PLv68xUnilJloECAx9ubPjsOqhhF8faFWine1nBltgGwgzmDVca6cK+1CnPYr90a7+zFlGfTJtKkPXc/cOhYwnkKk8Mt82SRVjCMerXGSRNjc1yvD+w2Vzv182NiQlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ijnzOKtGceRQHlp9r/a+2SLDLUJpBSOx4lsRpnmOVQo=;
 b=FfA3K8BaRNPiM2wm9BAIHeGPHxouLKTjBeeEsodgBNXs+LNkLQtKjatYTbwgSj4DMLdXKeVNmUHNLRUHsDplO5f9gdVZuY1sh2YVeE7frpg3CB/Ut/l2pMwSNsxhJxIYSoLnYJZVcqTUGmfRLG9FYoWRCLQ6CzLiOieAt/YEezV0bclk2A6JX4vLdS/+umyI0PpCNKJu682Ch1QQOqpt++HPOqphx0ejumlHSyQkg56/1eNXgb6WtpITwN+P74HxdeBRsI+DcSPeZou8ofEdLG/YR+OPD8MbahfFQ6wzyNQKNMKoo3uk6zB4ZgPvR5xbNA0sdLqX9yUJ83rhDAc1ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijnzOKtGceRQHlp9r/a+2SLDLUJpBSOx4lsRpnmOVQo=;
 b=q/WM6ZLSItqXecmttFjiKmUolK1F0gV76k4dMBIEN1oeL0JmO5WCCwECtSriWAqkBXUp/UcOJid+xtJjQCpwziHkAZT1yio3uy8AB8X171chkEl1KC2TCT6S2NRvAW9qw+rI64s5CxeDxRPeyGwlVybQQ0S35LzJhJmV1rBDRY4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
 by SA1PR12MB8724.namprd12.prod.outlook.com (2603:10b6:806:38b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 10:41:10 +0000
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::966e:5ccf:b22b:d972]) by SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::966e:5ccf:b22b:d972%4]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 10:41:10 +0000
Date: Tue, 23 Apr 2024 18:40:48 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Yuan, Perry" <Perry.Yuan@amd.com>
Cc: "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
	"Limonciello, Mario" <Mario.Limonciello@amd.com>,
	"viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
	"Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
	"Petkov, Borislav" <Borislav.Petkov@amd.com>,
	"Deucher, Alexander" <Alexander.Deucher@amd.com>,
	"Huang, Shimmer" <Shimmer.Huang@amd.com>,
	"oleksandr@natalenko.name" <oleksandr@natalenko.name>,
	"Du, Xiaojian" <Xiaojian.Du@amd.com>,
	"Meng, Li (Jassmine)" <Li.Meng@amd.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 1/6] cpufreq: acpi: move MSR_K7_HWCR_CPB_DIS_BIT into
 msr-index.h
Message-ID: <ZieQMCzz+VUMcWya@amd.com>
References: <cover.1713861200.git.perry.yuan@amd.com>
 <858950a317b7093df72142d227c686290ba9eda5.1713861200.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <858950a317b7093df72142d227c686290ba9eda5.1713861200.git.perry.yuan@amd.com>
X-ClientProxiedBy: SI2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:195::20) To SJ2PR12MB8690.namprd12.prod.outlook.com
 (2603:10b6:a03:540::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8690:EE_|SA1PR12MB8724:EE_
X-MS-Office365-Filtering-Correlation-Id: bf68bd01-1e63-4915-6e84-08dc6381e3d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B53GFZRtBrnWprlozfD1bXNcpUfXN0oIH2h96cDHPKbtKrQdIppVM+hcGI8m?=
 =?us-ascii?Q?JftolvxVWYV3Acb2xmZPbH6Jm1Si9VD5VNy7Zc4vLQm7X4LDuHqvJ4XstpeT?=
 =?us-ascii?Q?Aakfi1n502lnbAqmB9hJ4Jo/xeA9zTLmpo9V3vcPGCA11uMPWRSbTgeHP7VK?=
 =?us-ascii?Q?CnnNQD5x+syAbLIjPRwcpJTrVZjQSSy6m5XYAHpQ3bImea8og+RGu9N5a0Z1?=
 =?us-ascii?Q?V8yELU4xoaMP75Ms5uxot2064tcb1O25Ybk3CAE46uyZr1OrJJWHn0gxAHSk?=
 =?us-ascii?Q?X5BhTCJKlNGB2n3dPBpwlyzOO7ofthN5dq5Xhkgpn+eKvpYRNaO2QfjqGql0?=
 =?us-ascii?Q?7EXwId4McGnsdClTWSrsOyvAkNAj0YC3298akgpUWPwESC2ToTs87ehpy+pQ?=
 =?us-ascii?Q?HFuQJ/AvZ/OEcGieaXz0Ywo9cQaonPpycv4wwJQQaR4J4R7nPLlm3i1OeWy+?=
 =?us-ascii?Q?KFIuE+Poe1+76eBadmswEl+uvHWrbUXDhSiAUYF3GuEseZhdY73sHS7u7XJO?=
 =?us-ascii?Q?rr0WOFsH6QweQCCeJzZ0Zx4+bLtaNbLk1cdhv9XC4sieeQSnK95iR1VxR6j6?=
 =?us-ascii?Q?Cft1oenUWt3l14n35ZQO97maiiD+sJc6bp5w3vxNntcO7Wcrezof5ECNEvLR?=
 =?us-ascii?Q?7iLu6dqXPZnG/lhN6Jf9J8QnnevvyBBWAUrN+u+AdEg3s2CWWGwHwjPpvgQ+?=
 =?us-ascii?Q?KcqOJ+dgY1pKtvz6TWTAIaRNIwBGHgPlPcMRurLezIb17SIIcj+rm8dmW2tD?=
 =?us-ascii?Q?JX94gwyisDO2dC6QI7AhkYXGOYZREqglTfNMtJRzMKYdjRbW/Cov3xS5l7Wv?=
 =?us-ascii?Q?w6e6jmqlirlDax7eLFyy5cyv6GGn5wll/8HwOoVkvylRES1e7Nl2QGTQQR4R?=
 =?us-ascii?Q?5F34gS58ZRk2A/D/4MZT9zWmfsLaFAmc+h9qqE/JSx1T/Fx5pWkVaJCNgUft?=
 =?us-ascii?Q?425lSANzqINE/cRc/Fd3PK/E9Fm8cYD9zcTfFCw/s5aQXlGQPhfAq8ErOQPu?=
 =?us-ascii?Q?RNrWvE5ZeSO2Sl4kS90gK+5MeUqLcqA6Z3ZUgsCOp8PdsU7mIPm+lvhvPtCb?=
 =?us-ascii?Q?1bBz6p711+ObGqDq2yFCYl8K6odC/t4q49vuG3skhusrlQmhwQJ356A2Vlfq?=
 =?us-ascii?Q?XWbxu/g6/0pUVy1pYtbRrTPtUFCQn3+Dn8w3IvxGxqiIHXVzhWxDxI0pEkx5?=
 =?us-ascii?Q?AeQpiG4YdxUwNuPX16gWrCjQL+aQe7G9XSijhtzMqyWOX11wUqc/zU7p64Hx?=
 =?us-ascii?Q?6hzB81V7x3Olp+iTzTk2GprRAOwL7bBCP1FPc79M8w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8690.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hgPX6hVWJhEbWKlLYstbwmkd7lDRCWIcx8IEcCH5a8h2H3BvKpbFc9/pvKr/?=
 =?us-ascii?Q?IXIlnwaYE5jAXsw5k+GuiCidR5zLIm9YYs56BIrxQezuVDnh49SBIsHZ0Rmw?=
 =?us-ascii?Q?Tpg2r9H9o5uMUO/7BduhZh/AcqZQmULCQqOC4lbGTYkfII+gdK5CSggOuJVA?=
 =?us-ascii?Q?2Sy5tPpYFNdavot4jJOp3/7kvPkcc9BMMUR3Ak/wuBn7LEbRfNcWJ2PcOXCS?=
 =?us-ascii?Q?6mSBynZSIqGfnT5SfQv2mDQMqUA3hGdbv8wwak2uMbOWgInPdcJITL878Y9t?=
 =?us-ascii?Q?Cr48JdUwYSpWd9331C5mCwurXDEdojdFEnIm3BAuI5+fiWzFjmVHRZAhAqwW?=
 =?us-ascii?Q?NQq5bmd6ieoo+tINg2KYOJW4/sXSnWOfLAyALQEX3pgdrzCnVwtnOst4fJ99?=
 =?us-ascii?Q?haGomnY4hsGShQ6zXO2rnnkCRg0pyQqHnVsxaAALLeW8NWgjOMz9KoQrirDt?=
 =?us-ascii?Q?j2OzCPfQZmfLgWaI+rrfKyqlaKAnogDrJ+LO1kFSyHivooZf0woSz1z2/k9R?=
 =?us-ascii?Q?nQIiDOUuB4S55M7E51eG7Yqgw8FHDmAQMGpYxyE2TZFF50R18nWUd05IneBr?=
 =?us-ascii?Q?CMIDDb8RxBTkIM1yBHbFgNCtZWBjOZHOe9CCk1Uj2rPdtCzj15TKhCoO6mP3?=
 =?us-ascii?Q?EXhBRHXPWi7ZKHTae99KaztxcQIwLnBp28zkI/+TAtx0V54iJia2vacI5AxR?=
 =?us-ascii?Q?mbfEjvrUwT14goOEWNIYn7FPIGapraiDZpdToUCiFQfbSxawim2rBW/K7B5g?=
 =?us-ascii?Q?e1ZwdJUam1B55parDX6H7nQV9RJFwaoZ0KkV86x2EKyXTAKcq3YM3ZlNrRTI?=
 =?us-ascii?Q?ZZASWIIeECCp3KLp+Pl0rIRHl2k6z6ECBMZ6IMgHiiDHQgKJcFgtE7cBPDUk?=
 =?us-ascii?Q?jdrb5hTKwaNkUR3vWUxgDiU0Q7DgAJdCPgkl8M/6Sa9fmMyx9m9m+QhMjpSy?=
 =?us-ascii?Q?dzr5odyHDW98TOUbUE+jKY39Yadg2yCLUKKzxM6AqDUsY8jgjWo7sD5lqT1F?=
 =?us-ascii?Q?PaLwqP5uz/0X69uGegWKfQpiBai9gDTnoERLm/2PqdOb5liau2sA+lWII3oK?=
 =?us-ascii?Q?dYuHs00DnJzdMP4Rzn4U4QvTfD9EORyGQaAIZ8BDkSS2uF1jjDoZ0RS0hcin?=
 =?us-ascii?Q?9/jBczbFMfNYkl4qUFFwwdrbnXCVFl01DYyo9WGU0eE1paEG5gvMasCjicPl?=
 =?us-ascii?Q?kLMVnMcd4SCOjvU9XabCfH5QIudSa+rmlT2WtEnUiwiC3gO5sC1sOgobnLxM?=
 =?us-ascii?Q?LTyMWFtPyejBmfrZLRH9ZpeiLWtkoyM5cHwoYoon7R8YCLcbaeR6V5P6PnsS?=
 =?us-ascii?Q?LEEU9mwlsYMTuE6ivxVCQkSrrrf8nsV0je43W/99fiHMQlu7aDSYVp+lBnXF?=
 =?us-ascii?Q?C/203qMi7ie4hI6X15eF6oLGBf2p9clwBQzvefmnAO0PO8O5wo6B+apL1XWr?=
 =?us-ascii?Q?avCe+hCOYf+APp+BDg6lQz5b/YeurzXFGmjGFllOj5dE/cFVf5IAkISRGO2v?=
 =?us-ascii?Q?whsdu/1npiwqIhAANKsCbmC3d5D5vGYl46sE2zuwmrt9t/uwi/YnvuwhHAkG?=
 =?us-ascii?Q?EvIiGMJr2J04ShdsLxTYXgvB5igOJ0u6KK+VMdOA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf68bd01-1e63-4915-6e84-08dc6381e3d0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8690.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 10:41:10.5146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L0XOaVyy20kBZXi5aU3L6gYNFIquXIXadfn6MKoZ1OgQk3SLLGGxcFSm97KoZctGezekyLM3yK/BjTGA50+yEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8724

On Tue, Apr 23, 2024 at 04:40:54PM +0800, Yuan, Perry wrote:
> There are some other drivers also need to use the
> MSR_K7_HWCR_CPB_DIS_BIT for CPB control bit, so it makes sense to move
> the definition to a common header file to allow other driver to use it.
> 
> No intentional functional impact.
> 
> Suggested-by: Gautham Ranjal Shenoy <gautham.shenoy@amd.com>
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>

Acked-by: Huang Rui <ray.huang@amd.com>

> ---
>  arch/x86/include/asm/msr-index.h | 2 ++
>  drivers/cpufreq/acpi-cpufreq.c   | 2 --
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index e72c2b872957..8738a7b3917d 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -782,6 +782,8 @@
>  #define MSR_K7_HWCR_IRPERF_EN		BIT_ULL(MSR_K7_HWCR_IRPERF_EN_BIT)
>  #define MSR_K7_FID_VID_CTL		0xc0010041
>  #define MSR_K7_FID_VID_STATUS		0xc0010042
> +#define MSR_K7_HWCR_CPB_DIS_BIT		25
> +#define MSR_K7_HWCR_CPB_DIS		BIT_ULL(MSR_K7_HWCR_CPB_DIS_BIT)
>  
>  /* K6 MSRs */
>  #define MSR_K6_WHCR			0xc0000082
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index 37f1cdf46d29..2fc82831bddd 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -50,8 +50,6 @@ enum {
>  #define AMD_MSR_RANGE		(0x7)
>  #define HYGON_MSR_RANGE		(0x7)
>  
> -#define MSR_K7_HWCR_CPB_DIS	(1ULL << 25)
> -
>  struct acpi_cpufreq_data {
>  	unsigned int resume;
>  	unsigned int cpu_feature;
> -- 
> 2.34.1
> 

