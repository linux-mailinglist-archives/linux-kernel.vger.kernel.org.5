Return-Path: <linux-kernel+bounces-145435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D22D88A561E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49F091F22A9D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1BF76F17;
	Mon, 15 Apr 2024 15:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZZMghJYP"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2052.outbound.protection.outlook.com [40.107.96.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A69E74422;
	Mon, 15 Apr 2024 15:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713194206; cv=fail; b=mYLRxQNZarGmBN0dzv7hG7DZfXrT2o6m3j0yx/JR5u+cS/9NkRQFp3etqvvnw5A+UgzFYZGv5mbGshxD1GSXVDdyN4RHb1uF6QYRUU+6A7x+uSk+fPKvxohCtCqzHAuSjbpx5ai96m2/B5VKRnh9D++i1Ff76YAQmYM/ZhYNlvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713194206; c=relaxed/simple;
	bh=cvlnLHh0Qm3jNEMVy9w3tS138knQNuXKmNtrzIntf4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Zfi0e//WU4P13UQSs5HiTQUT7eEL5Hn+OV7LUMnQv/AztG1q71XaGRspisWMRXOT0FaTRrQg4wseHAoYb069TsC3ytKbv37rsj12rODuY2AiTOc9I9dWZzWF8vtduJbK5N5CaUJ/oFPFeVCoHdy5+bc3tjJ4PkTyrVR7phfmXrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZZMghJYP; arc=fail smtp.client-ip=40.107.96.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hG32xJP3+iqFNDu+2JgFw5BOxU9oP3lZaQado19yrsaf1bZzA8OdHE35gHHWsYtlAsSEs5VTGqitj4M5H97upLYJbadCMhbi/Uz1wtM5BXM1GONgdug1bgSUnBDF1ES+CXrO8rr+uxE/WWHnXjU7HZKPv7enNJ+7O4g5mUOzWzQ/QDe3puyD5A3RtCSu5zc5YP0STBko2FFB+DOrSC1KH2L+FakIllWapETIbOjDsnFz5paEcblKWVs+6QXtkstjCPKW9V8suiKaVyvMEy5eMwKNaQ77Pp5YEJxTAd7XjxAyamShGOYgrj2ebnHKFnBdYqqrlTAvgR7XsRl/jiPNXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XRbMfvdnBqTIoaUlXziuJyhhppvbOfzqTJqo2dw+77M=;
 b=aUczgsJPxdok2Eqq9URr7mEt+c38+T26VtLOSwgU6ZY3bFD9lXRvoVwvWWPzZbdRk4Wc3ci968AlG5YVGoEBZ9z4DgDwED7LY07OyZQ6PZC0ncJUuvU+AiSd6F0XUyIwbcKir9dkC4c8g4jRAZLu7OlLYVycq08oZBU9HE8pyDBobTpzCRdZ6055VhA0oqwBjSzoraZWydK7D5yV3mUlCP+ZmoBVEduVDv4GxQXdBX9eMEDv/8tVZUjoyhlS/7Zlz25fnfOkMz/bw1E7VonKLVKyeCDDOZS1cUHYbLq+3St6mlTlP8LMr3/VUvBxkoOjSBikDmumwaJwz94RtieZDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XRbMfvdnBqTIoaUlXziuJyhhppvbOfzqTJqo2dw+77M=;
 b=ZZMghJYPd4y3pkZLN3Gcjh6HltNjKjuQUDqUUhDAr0ELpeuBG9flw66jcSRrc2EAry4jC6rwE+6DDUKTrUWrY0XCVGvfpMhw0rNA9WWn6KEPVAGpKvdv93hnmGhq2ykzUR0sw48Jo84xnvZJ44H/XTwdYHp2NmRHpyTJfzxrEiY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
 by MN2PR12MB4303.namprd12.prod.outlook.com (2603:10b6:208:198::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.49; Mon, 15 Apr
 2024 15:16:42 +0000
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::e7a:5022:4b7d:ade1]) by SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::e7a:5022:4b7d:ade1%7]) with mapi id 15.20.7409.042; Mon, 15 Apr 2024
 15:16:41 +0000
Date: Mon, 15 Apr 2024 23:16:20 +0800
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
Subject: Re: [PATCH v10 8/8] cpufreq: amd-pstate: Add quirk for the pstate
 CPPC capabilities missing
Message-ID: <Zh1ExGtyhGOsduOs@amd.com>
References: <cover.1711335714.git.perry.yuan@amd.com>
 <31afd5ae23f8b1d7c6a2f0efe593a368dee61224.1711335714.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31afd5ae23f8b1d7c6a2f0efe593a368dee61224.1711335714.git.perry.yuan@amd.com>
X-ClientProxiedBy: SG2P153CA0015.APCP153.PROD.OUTLOOK.COM (2603:1096::25) To
 SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8690:EE_|MN2PR12MB4303:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ceda8da-9046-469d-03be-08dc5d5f0dec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EOp8u7hwAdq/Omfaf26FZoZT47GyRjuJSZ2V2GKP73TjB46EQk6I4nL7ciRD3EusokJo0w+/CiGlGq+rIubKYEqrh2u/RL6rZUYksgTw+IYbFK78YA2NAXzLfOC8FZRYBLuh4N0V/S0rIvW/F3MwGvfjmfdNomVSNI/bupVkiWc1LNf9kC/w3rH183KpJvDftUlEEWCNDMGZS5fk1INnr1QP+HIco3W20YabaBxlVP3wW+se9X6tg0H6Es2cZHXDpYkv3DvAfKjsDkD3mR8ypdP0WfAIXlPu5SLW7Bi/shhRvDpQaGRz8UMNw4Y6CwPvmjnULMBrFPz+iN+eUzIi8C26b9tWAe7uehvVTItO5sSLVEnNZNN/67G6xnsICLU2VdbMgPDjSQFnG4MQdNVLOCq4Tyy1gQzx9+jfBHMwVsiRZQ9VTxWinIzMang6NeMPZI/fCNJrBDA3YzFDqM6YxiK81U3KDI+cto8vfDeOcFpteW6SvPQQpchX8R/sIrTOuDs2P3QmvCeRNOeowE4tK1OGtVIqQNieBG+0vtoKtOH9o7CezUcEb8CiIgjT1K9ee/jW79UWrtXBY6LWIE8FEECKj+3mjkMcX7XdHzWJQ8x8UowojycYbsbbK0gnM5aP+K3mHHfHJBSQAiwAndPpuCAd0fIO4cfRVTUCvtJI1IM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8690.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cyg+cc1JgcdKJKztSnmRRwkR6ckjA/8xc230DkgsYzC+RWiXTpa350NdLg7Y?=
 =?us-ascii?Q?kF9J924JkU96s98Kczxku45vbcu6SjS+eNVk58fUFLmII+fKPqWjzZe9UN+j?=
 =?us-ascii?Q?zFiaxrnwG4gElzg4aS2Hp5w9SAshta6rpjReoZcqnNdvy+ZlOf0XLhNniK3c?=
 =?us-ascii?Q?YN84WrhfQZynpu1TaYo57nmknhs6ka9N9Gkywr3S7OFusItp4z53Uvw/YUYo?=
 =?us-ascii?Q?7o5JOtlIsgEFq3HrTxdzfaeeGSkkYeExcZhyCEPzyq7kCCcyju9CICypmiUw?=
 =?us-ascii?Q?lf7ilEeciGi8eGOYJbQpCugc/dMqbP98qaRGgc5oapiXf9tP74lFyD+h1GZh?=
 =?us-ascii?Q?MlYeUKTpUAvpn6K7ZNHekdqSbQRQJeKEzSkyabbjXVvs9ixJj8wzz+l9xCHE?=
 =?us-ascii?Q?fvf3tizlYcLXT4xqDxAIhpeCua3lIreb/CL9/CTLKUvkwBi+0UMNaVDqlhBF?=
 =?us-ascii?Q?/qckKdFUU3BwGgsFkWCwPqODNdhTC3Ow3kbzXCuHjYQrLLG/x1ygDOANGrJR?=
 =?us-ascii?Q?7QFCbBxGlb2ZhFy/wWiy5WXnl0q1/8Ic89pNkYlg7flfBLAOkzLbvD4SaD08?=
 =?us-ascii?Q?nihKzT1pwtEujkvArstf35pD3dybsjPnKGAq03W15JN8NFNMWNuNW69qDVXV?=
 =?us-ascii?Q?C6Y7fqPSTiQqEbt1c/zwDaBuOW3FiAv0c5VeT77geYsNP5NDXKVUxOnaHFK7?=
 =?us-ascii?Q?l7WlTouru/mdIJoBCiU+3sJJ9UJjC9IkJ5Es0pA68UWAY2zvtHHgfJ3Br7S4?=
 =?us-ascii?Q?sRZMHNAos7u1smyD70Zx5/QBHPOPcuJHrZeiLVTKOnNqP+wNkowC6enWneZD?=
 =?us-ascii?Q?T58fuXGLm6dqwFUtfErQxovd9F809tfudb70/T6H3oak4wAKeDHSFR5FKNNx?=
 =?us-ascii?Q?iYluJhTL3xWyYttfCfm4GxOrB56X7jRFC4xkJ5pkY3yhK+zVvNhSOa9ud55j?=
 =?us-ascii?Q?5/q8pxNuNUNbA1rbeC7+Ck4ZHVp3AHBVvEH3DRNgmW/gkHcR+9KS35SrldRU?=
 =?us-ascii?Q?UVyRcsuDNMIPutQUDHu9Iph5rP6ls73ecvwwtWqBkgwAtvfiuf0OkEzS/6xD?=
 =?us-ascii?Q?Be45nL/1Bbv34HqSIQ4yCGzbXFlQ7+YR3XBucTQVBuUgGbaTikIKgd/W3SC7?=
 =?us-ascii?Q?vhZxNk0VTGTvklq4A4ICzvtHVY/7Jy2Njp1lT2a8UhdhMt05yLOql479nZrb?=
 =?us-ascii?Q?L5sKlBqk0Qd1oor+XWyRAu8ctBkG9E/z6uypVoMkDdU4R+OljKVWWpbHo89z?=
 =?us-ascii?Q?oJdW67p7Q98lzL6ZPrS6egvjR8igWjvl+JCLlrOJI/WO8mJmtCsdhE0MQRYk?=
 =?us-ascii?Q?pMOLwoiHzfc0tWh5qdpOox26WNXSEeyR1XXVL2rHs41f7HftP0oxGCZ8j5dn?=
 =?us-ascii?Q?h9b4/ZA+g4G9CI6JyObap4g2ym5jZ6mO1mm4VSnZZlV1VsVWBVQyzA5wzbDl?=
 =?us-ascii?Q?eMXEm3s9KiofV0BGObbED9B7oHHq6nxofKxsuOM+cgIhY+QHr7xau0wUeZJM?=
 =?us-ascii?Q?kwttKtQQ4o9czcUVhl8AQNYhW7lltjSxB1Dzg+YiY2wHoUgJoAX8IV4Cxnse?=
 =?us-ascii?Q?I3gyDAvJ/Dl53ux4lG/pcDQEJFdk7phlrABLgT6M?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ceda8da-9046-469d-03be-08dc5d5f0dec
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8690.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 15:16:41.8303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IxX7KrzN0+9UH3/e/KZqynxBJ4WDL4rdqmGkQoIClgMFI4Lz30jt7ziHIKzLPxH4nXelKqvP0xpOWPaWIJQxOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4303

On Mon, Mar 25, 2024 at 11:03:28AM +0800, Yuan, Perry wrote:
> Add quirks table to get CPPC capabilities issue fixed by providing
> correct perf or frequency values while driver loading.
> 
> If CPPC capabilities are not defined in the ACPI tables or wrongly
> defined by platform firmware, it needs to use quick to get those
> issues fixed with correct workaround values to make pstate driver
> can be loaded even though there are CPPC capabilities errors.
> 
> The workaround will match the broken BIOS which lack of CPPC capabilities
> nominal_freq and lowest_freq definition in the ACPI table.
> 
> $ cat /sys/devices/system/cpu/cpu0/acpi_cppc/lowest_freq
> 0
> $ cat /sys/devices/system/cpu/cpu0/acpi_cppc/nominal_freq
> 0
> 
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Tested-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 53 ++++++++++++++++++++++++++++++++++--
>  include/linux/amd-pstate.h   |  6 ++++
>  2 files changed, 57 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index ec049b62b366..59a2db225d98 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -67,6 +67,7 @@ static struct cpufreq_driver amd_pstate_epp_driver;
>  static int cppc_state = AMD_PSTATE_UNDEFINED;
>  static bool cppc_enabled;
>  static bool amd_pstate_prefcore = true;
> +static struct quirk_entry *quirks;

If we set quirks as global pointer, while the amd-pstate is uninstalling,
should we free the quirks as well?

Thanks,
Ray

>  
>  /*
>   * AMD Energy Preference Performance (EPP)
> @@ -111,6 +112,41 @@ static unsigned int epp_values[] = {
>  
>  typedef int (*cppc_mode_transition_fn)(int);
>  
> +static struct quirk_entry quirk_amd_7k62 = {
> +	.nominal_freq = 2600,
> +	.lowest_freq = 550,
> +};
> +
> +static int __init dmi_matched_7k62_bios_bug(const struct dmi_system_id *dmi)
> +{
> +	/**
> +	 * match the broken bios for family 17h processor support CPPC V2
> +	 * broken BIOS lack of nominal_freq and lowest_freq capabilities
> +	 * definition in ACPI tables
> +	 */
> +	if (boot_cpu_has(X86_FEATURE_ZEN2)) {
> +		quirks = dmi->driver_data;
> +		pr_info("Overriding nominal and lowest frequencies for %s\n", dmi->ident);
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct dmi_system_id amd_pstate_quirks_table[] __initconst = {
> +	{
> +		.callback = dmi_matched_7k62_bios_bug,
> +		.ident = "AMD EPYC 7K62",
> +		.matches = {
> +			DMI_MATCH(DMI_BIOS_VERSION, "5.14"),
> +			DMI_MATCH(DMI_BIOS_RELEASE, "12/12/2019"),
> +		},
> +		.driver_data = &quirk_amd_7k62,
> +	},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(dmi, amd_pstate_quirks_table);
> +
>  static inline int get_mode_idx_from_str(const char *str, size_t size)
>  {
>  	int i;
> @@ -812,8 +848,16 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>  	if (ret)
>  		return ret;
>  
> -	min_freq = cppc_perf.lowest_freq * 1000;
> -	nominal_freq = cppc_perf.nominal_freq * 1000;
> +	if (quirks && quirks->lowest_freq)
> +		min_freq = quirks->lowest_freq * 1000;
> +	else
> +		min_freq = cppc_perf.lowest_freq * 1000;
> +
> +	if (quirks && quirks->nominal_freq)
> +		nominal_freq = quirks->nominal_freq * 1000;
> +	else
> +		nominal_freq = cppc_perf.nominal_freq * 1000;
> +
>  	nominal_perf = READ_ONCE(cpudata->nominal_perf);
>  
>  	highest_perf = READ_ONCE(cpudata->highest_perf);
> @@ -1662,6 +1706,11 @@ static int __init amd_pstate_init(void)
>  	if (cpufreq_get_current_driver())
>  		return -EEXIST;
>  
> +	quirks = NULL;
> +
> +	/* check if this machine need CPPC quirks */
> +	dmi_check_system(amd_pstate_quirks_table);
> +
>  	switch (cppc_state) {
>  	case AMD_PSTATE_UNDEFINED:
>  		/* Disable on the following configs by default:
> diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> index ab7e82533718..6b832153a126 100644
> --- a/include/linux/amd-pstate.h
> +++ b/include/linux/amd-pstate.h
> @@ -128,4 +128,10 @@ static const char * const amd_pstate_mode_string[] = {
>  	[AMD_PSTATE_GUIDED]      = "guided",
>  	NULL,
>  };
> +
> +struct quirk_entry {
> +	u32 nominal_freq;
> +	u32 lowest_freq;
> +};
> +
>  #endif /* _LINUX_AMD_PSTATE_H */
> -- 
> 2.34.1
> 

