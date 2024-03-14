Return-Path: <linux-kernel+bounces-103019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2176487B9FC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C8ADB2252A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9A86BFCE;
	Thu, 14 Mar 2024 09:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zJomQR+2"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B86C6BB48;
	Thu, 14 Mar 2024 09:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710407092; cv=fail; b=Q3mTEURGsj9BBKH2kd7iHN7hZuNc/0M+niUuKqCM8QqTsyqpRxdVPq8irduOiRJVVSjvpIO7Rx5IOsbY9jK589w0eyCPqFid47pF9E0fLe67khlb09yn4BF4qiCJeNn994V7r/gUffoP8nOhuUzLyAB1eFXOfcKSNmOLp3TXXR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710407092; c=relaxed/simple;
	bh=80X37D/GaOQ5B8KkOmJCDc5Pl9AEYT6vXG9zzAB2mts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JFXU/a/IgrJJ5yW3NJ31eq+TQ+1Qo+F1ZqaLD6yU9gJOpqPmIP0jsr2aGtzSARgIFHK/0NfG+haAeDEQI7fEZBUJItuRNaT/hbZzpTxGzsRvV1R5/rFTKyxoNQhiArFrhYPTGMSxInUqTqfDm02YTY7xyGOb82kQxI20Eq9zWBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zJomQR+2; arc=fail smtp.client-ip=40.107.243.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jb07IMestU7b5XkzB+O9YHo3GSHuVKouPRkdkjfwnkwigtUiBuPOFqxmDzYzluJX0AEhNAIlhPJqp8qFK3je4TDGav+L1XRienMZstCCJIzvX6MM87yu0sC84h87iCMaW8I7vBUIdXPzLUFJMnj4pvrtTd8Ebj8JtzNOLX71Df55Zy5slrQybPOPum+yYznYrwuNmh+q9RqMNvcrZES4gl1wGUIfhkmAaBjmHzI7n3vfLNX4GNWmGugl23nHOPjCoo/kAXNdqjK65m5Ubib98ZxIdWR2cJpwL4HO+zV24AtPlx2YFlljkDP5GG0ul4YzdRyAYH+MMcbBs2/9x7ZY3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ChJTyhEQlgzSheGUJu3mPvX1JZG0KtuDo04BIASpuy0=;
 b=ZMmtnr6dMgGfatuhKzkVS3oMZZrx7AV54pB5wdEqtA8TcKM0BV9ZDTZWmsApRobq6Z+ICyTtnMWpZMw0tqwSzQ7fY0CTUsKyIgfK2AUhcKxrjKTF2ycMKFmkWQKL9b0sYE3cP7aqjvMs5BR/lK6q9k7hoGHQjnAlbptzS9EybA5ujEY0s16xfk1r8gzIhGNfAKoHpAOZlG3Qic4pp07YHSHYZvXmaU1o6TZCrRIyPtUa0o+GZTuMRWYF3DWdjTI9kTmeTf6Hvk+nYvh+ZTOTykYd8cWDJhM5byQFF7/F/OS6rTMLRC7g1aUqiHwpp2xyiZB3oZewS6WQIHhiqfhpYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ChJTyhEQlgzSheGUJu3mPvX1JZG0KtuDo04BIASpuy0=;
 b=zJomQR+2VaaXQuCTv3VnA7ui9e/keRLxaroDGGoaz8flWQoWe54zO4BfJyxFYCSUhs7LfIgdMKQ9fpA13G3MSz/F5IyZLP0R3eEgSLRXNUAiiKL16DdVz8F1tnDCbdHjg1BOV32O42zU7omn9zTJgaFJFXIbyfLCfd+T2/Uf998=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 SA1PR12MB5659.namprd12.prod.outlook.com (2603:10b6:806:236::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.41; Thu, 14 Mar 2024 09:04:45 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::d725:ec0f:5755:769b]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::d725:ec0f:5755:769b%3]) with mapi id 15.20.7362.035; Thu, 14 Mar 2024
 09:04:45 +0000
Date: Thu, 14 Mar 2024 14:34:34 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Perry Yuan <perry.yuan@amd.com>
Cc: rafael.j.wysocki@intel.com, Mario.Limonciello@amd.com,
	viresh.kumar@linaro.org, Ray.Huang@amd.com, Borislav.Petkov@amd.com,
	Alexander.Deucher@amd.com, Xinmei.Huang@amd.com,
	Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/7] cpufreq: amd-pstate: initialize new core
 precision boost state
Message-ID: <ZfK9og1Bnj6BnSvM@BLR-5CG11610CF.amd.com>
References: <cover.1710322310.git.perry.yuan@amd.com>
 <1bd9da56478c07fc2117b7c11f88eb517bd60f0f.1710322310.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bd9da56478c07fc2117b7c11f88eb517bd60f0f.1710322310.git.perry.yuan@amd.com>
X-ClientProxiedBy: PN3PR01CA0142.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::20) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|SA1PR12MB5659:EE_
X-MS-Office365-Filtering-Correlation-Id: 3169ebcb-4fda-45af-ff23-08dc4405caf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vWWSk63y/d/69Tcj982ek8ia8cRH7EwGBZZhp1fevtRrz8vJ6ZotNHpAHH0Dvq56P6RmQSQHfsrF/b5haYidd1cKBxda1HUR9iDu5MpcYWbw1vI2DsqM/JISORvaszFht07XRyuwKPVHjCiabeaosrTxJTxfIeMoWAqcU6VYZ+aZnurwy8etaw5vksioYMmmeubbvLAt3rmD+rOPM83Tg6yv8cZMD2Wx6KgU9ModyS+nTQXfUifWONr6DQfz0c5TQWImBmQZ2BeYRMuBjdVZjp8Mip8uP4ytc99hvGaq0R3mu2mlXTqz0mpvxUj2YdHqBKEcNzukx1JA8vfKOkqvQNna3FyZ6UQ0L1WNAkhkBtfO4kzncLK4sVXK+hAYaunTqgAP1OxSpOy3lVqgjPEGcR7/ReOeDcVB4lR3zWenZPFyDRvKJ1nC42mm/gbciSSbGSF+NLQjtrvT5++xpy3Lc49uyn+0ixn6Fz/Gj2dMkgY45NjT5pdIr6P6BnjSrLm2wqP8grMJSrdZIo8FSsV9ct/UgafziM18LoWbzvFjj4jcTgC1sMpdeaeaGhSOGwrMsJaYCzDaqWDjhtvOfKrqttiZpV63FZoVAHbtCezkPM4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F98HCwVS5q+tO02mHj7xrcPWGNBWM2UX3aavVTMRoaxcVn6j3PY2p5s9Mby9?=
 =?us-ascii?Q?VP4Iwk+i75V37fueda1zmS6m/lsGPvjmnV+4fMRb7daI5NDalMDEzIRR5+Mg?=
 =?us-ascii?Q?5yRp9eMAYsd46IPov2LVXGwjyAnnqmWC2Ounlm1y4wmeCb7+eI82ekHm39Na?=
 =?us-ascii?Q?bfRhYuTIe3BjczeQFL59ICBWcTP6KPDQpDz9ZjMR2hI5mYeCIw4UJ1Rv1Mtf?=
 =?us-ascii?Q?i40I4AnuUs+pkAeaql7ly53zOAyc9GwnWBJmSfMYtMtaIZ/smteh+5jVqtre?=
 =?us-ascii?Q?QLS6WeLuan6lmTzqCjLtjUgEO/N4KC8zq6FjEJRoME32XklEGfQwOGElIvZw?=
 =?us-ascii?Q?HJeP77b3B/PZNzPj0rBufh0S6/hwvC62w80YHFickN5dVE5I8CnF/99QoBMT?=
 =?us-ascii?Q?xoS3PDDXX9qR/tWVBMiscPaNn3dMvYISMcCrFkmLwV+pS9frGCko9tdv3VyT?=
 =?us-ascii?Q?j2V3KGk2Z1D6cp+w+clAORo+dUIftS7O7IgO+wcgD/Pj7SE+gT3UrctvMIID?=
 =?us-ascii?Q?xuaokBHrExUqjGA968aYhYqct5lswnJ7zYFCBiRjvIYgdvHpyoau/2gEUB+n?=
 =?us-ascii?Q?1g+P9oGuKGM7rGSaZfOhPH5SWGucCQQDhJAQm5KRd8DwtTrNtxfrbtU43BLu?=
 =?us-ascii?Q?dHYRSiBQ/OusACsRAE1DbbauJaO4ehXRFd/zx+kWp0olaQMqyQaUWmHuvjaS?=
 =?us-ascii?Q?xLU6203NGLSdqPaooVyh8Yb/AjSs0TrfzND5XiF4d5rX2/jLh2rlT1RoDxxJ?=
 =?us-ascii?Q?HeY8v4uHutJ6qJprjyGKYMZp9GJWz7t23Bp6IzWqHDC4/AKcFl15yX5JYFjw?=
 =?us-ascii?Q?vqu73k4EnW532eJ6oF+c08hBDWltmhiRLEjbaKKck0hfDPsWz6wJGJcweHS+?=
 =?us-ascii?Q?NX48JVZIZvRP/brLGYHDhhWKPmyAE2eY79P8jpsxnBbwJ6N8lx57Vbd/GKP/?=
 =?us-ascii?Q?fMBwN8XopiAPHH5koOJE03yCZ79gbu0SkknddMJ4I+jFeBZjf9En0IP56RB2?=
 =?us-ascii?Q?byvahzf6aYGNdiJg1EUmFzFpd48nYbFXvZPC28/erUITp6MYxqklpWOi+ufV?=
 =?us-ascii?Q?nkL43swwAVAqtrJKCHgAlCIHzAeb0GjLWJCBC1rAaleBUv+PZpl0n+pu0Frk?=
 =?us-ascii?Q?5zA+rHKj58GbJhmjj5iSHR3b1kBI9pqL6j1pnPQAnV852ZgoBAALxFM2EOAK?=
 =?us-ascii?Q?x+hg1JsOvsagxgcjPYatSuWHAINLNDSUjPhDf5WrkgsMlzrVgu5qOe8jB1r5?=
 =?us-ascii?Q?d4z0bH+LzO/8QWTkm/q4+7BGrsM/8vf++05AOV4omq8+DxURIkvgfyDf3fEF?=
 =?us-ascii?Q?ILjI7UNDDVqS6e8nADFKMzNuN6boilYWyAzuLhFHc0BfmO6ABeBCtI0YVFd6?=
 =?us-ascii?Q?pA6kEES6VfFYk4yDTTXDPKSP9CIKywC67zOcyHClxNGwEaKIhbT1aHvmSamQ?=
 =?us-ascii?Q?FvTWfJuDIeMAbEsB8Z+cxjVcEu7cSbzGIHcSHRiixojVmZ1ODsZyzwypegwC?=
 =?us-ascii?Q?R5rk9hqXbWJDVhL6eIPNV8CXdOJUwbA8vA7DEFPRRUb3Y7r6j0aByjtzKoRl?=
 =?us-ascii?Q?dnjHVP1Q9QDozyzqczZWkiFfV10S2biz310pI53x?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3169ebcb-4fda-45af-ff23-08dc4405caf1
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 09:04:45.1708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PxFMpQhTw0Bnw0GDfFkoG+SKCMmut5oTrNg9jRiZ7m/DCEuR26j9Y3ph+pBMb3jvwqb9q7QGfMf20hjVswVSLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5659

On Wed, Mar 13, 2024 at 06:04:38PM +0800, Perry Yuan wrote:
> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> Add gloal global_params to represent current CPU Performance Boost(cpb)
> state for cpu frequency scaling, both active and passive modes all can
> support CPU cores frequency boosting control which is based on the BIOS
> setting, while BIOS turn on the "Core Performance Boost", it will
> allow OS control each core highest perf limitation from OS side.
> 
> If core performance boost is disabled while a core is in a boosted P-state,
> the core transitions to the highest performance non-boosted P-state,
> that is the same as the nominal frequency limit.
> 
> Reported-by: Artem S. Tashkinov" <aros@gmx.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217931
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 50 ++++++++++++------------------------
>  include/linux/amd-pstate.h   | 14 ++++++++++
>  2 files changed, 31 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 2015c9fcc3c9..ef6381b48e76 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -67,6 +67,8 @@ static struct cpufreq_driver amd_pstate_epp_driver;
>  static int cppc_state = AMD_PSTATE_UNDEFINED;
>  static bool cppc_enabled;
>  static bool amd_pstate_prefcore = true;
> +struct amd_pstate_global_params amd_pstate_global_params;
> +EXPORT_SYMBOL_GPL(amd_pstate_global_params);
>  
>  /*
>   * AMD Energy Preference Performance (EPP)
> @@ -676,43 +678,21 @@ static int amd_get_lowest_nonlinear_freq(struct amd_cpudata *cpudata)
>  	return lowest_nonlinear_freq * 1000;
>  }
>  
> -static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
> +static int amd_pstate_boost_init(struct amd_cpudata *cpudata)
>  {
> -	struct amd_cpudata *cpudata = policy->driver_data;
> +	u64 boost_val;
>  	int ret;
>  
> -	if (!cpudata->boost_supported) {
> -		pr_err("Boost mode is not supported by this processor or SBIOS\n");
> -		return -EINVAL;
> -	}
> -
> -	if (state)
> -		policy->cpuinfo.max_freq = cpudata->max_freq;
> -	else
> -		policy->cpuinfo.max_freq = cpudata->nominal_freq;
> -
> -	policy->max = policy->cpuinfo.max_freq;
> -
> -	ret = freq_qos_update_request(&cpudata->req[1],
> -				      policy->cpuinfo.max_freq);
> -	if (ret < 0)
> +	ret = rdmsrl_on_cpu(cpudata->cpu, MSR_K7_HWCR, &boost_val);
> +	if (ret) {
> +		pr_err_once("failed to read initial CPU boost state!\n");
>  		return ret;
> +	}
>  
> -	return 0;
> -}
> -
> -static void amd_pstate_boost_init(struct amd_cpudata *cpudata)
> -{
> -	u32 highest_perf, nominal_perf;
> -
> -	highest_perf = READ_ONCE(cpudata->highest_perf);
> -	nominal_perf = READ_ONCE(cpudata->nominal_perf);
> -
> -	if (highest_perf <= nominal_perf)
> -		return;
> +	amd_pstate_global_params.cpb_supported = !((boost_val >> 25) & 0x1);

Can we move the definition of MSR_K7_HWCR_CPB_DIS from
drivers/cpufreq/acpi-cpufreq.h to msr-index.h and use it here ?
something like the following:

----------- x8---------------------------------------------------------------------
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index f1bd7b91b3c6..e5380cad903c 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -736,6 +736,8 @@
 #define MSR_K7_HWCR_IRPERF_EN          BIT_ULL(MSR_K7_HWCR_IRPERF_EN_BIT)
 #define MSR_K7_FID_VID_CTL             0xc0010041
 #define MSR_K7_FID_VID_STATUS          0xc0010042
+#define MSR_K7_HWCR_CPB_DIS_BIT                25
+#define MSR_K7_HWCR_CPB_DIS            BIT_ULL(MSR_K7_HWCR_CPB_DIS_BIT)
 
 /* K6 MSRs */
 #define MSR_K6_WHCR                    0xc0000082
diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 37f1cdf46d29..7089aca6cc0d 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -31,6 +31,7 @@
 #include <acpi/cppc_acpi.h>
 
 #include <asm/msr.h>
+#include <asm/msr-index.h>
 #include <asm/processor.h>
 #include <asm/cpufeature.h>
 #include <asm/cpu_device_id.h>
@@ -50,8 +51,6 @@ enum {
 #define AMD_MSR_RANGE          (0x7)
 #define HYGON_MSR_RANGE                (0x7)
 
-#define MSR_K7_HWCR_CPB_DIS    (1ULL << 25)
-
 struct acpi_cpufreq_data {
        unsigned int resume;
        unsigned int cpu_feature;



The rest of the patch looks good to me.


--
Thanks and Regards
gautham.


> +	amd_pstate_global_params.cpb_boost = amd_pstate_global_params.cpb_supported;
>  
> -	cpudata->boost_supported = true;
> -	current_pstate_driver->boost_enabled = true;
> +	return ret;
>  }
>  
>  static void amd_perf_ctl_reset(unsigned int cpu)
> @@ -855,6 +835,9 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  	if (ret)
>  		goto free_cpudata1;
>  
> +	/* initialize cpu cores boot state */
> +	amd_pstate_boost_init(cpudata);
> +
>  	min_freq = amd_get_min_freq(cpudata);
>  	max_freq = amd_get_max_freq(cpudata);
>  	nominal_freq = amd_get_nominal_freq(cpudata);
> @@ -906,7 +889,6 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  
>  	policy->driver_data = cpudata;
>  
> -	amd_pstate_boost_init(cpudata);
>  	if (!current_pstate_driver->adjust_perf)
>  		current_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
>  
> @@ -1317,6 +1299,9 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  	if (ret)
>  		goto free_cpudata1;
>  
> +	/* initialize cpu cores boot state */
> +	amd_pstate_boost_init(cpudata);
> +
>  	min_freq = amd_get_min_freq(cpudata);
>  	max_freq = amd_get_max_freq(cpudata);
>  	nominal_freq = amd_get_nominal_freq(cpudata);
> @@ -1367,7 +1352,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  			return ret;
>  		WRITE_ONCE(cpudata->cppc_cap1_cached, value);
>  	}
> -	amd_pstate_boost_init(cpudata);
>  
>  	return 0;
>  
> diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> index d21838835abd..c6e2a97913de 100644
> --- a/include/linux/amd-pstate.h
> +++ b/include/linux/amd-pstate.h
> @@ -124,4 +124,18 @@ static const char * const amd_pstate_mode_string[] = {
>  	[AMD_PSTATE_GUIDED]      = "guided",
>  	NULL,
>  };
> +
> +/**
> + * struct amd_pstate_global_params - Global parameters, mostly tunable via sysfs.
> + * @cpb_boost:		Whether or not to use boost CPU P-states.
> + * @cpb_supported:	Whether or not CPU boost P-states are available
> + *			based on the MSR_K7_HWCR bit[25] state
> + */
> +struct amd_pstate_global_params {
> +	bool cpb_boost;
> +	bool cpb_supported;
> +};
> +
> +extern struct amd_pstate_global_params amd_pstate_global_params;
> +
>  #endif /* _LINUX_AMD_PSTATE_H */
> -- 
> 2.34.1
> 

