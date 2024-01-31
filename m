Return-Path: <linux-kernel+bounces-47219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C49E1844A9F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39EBC1F28AF1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0C039FC6;
	Wed, 31 Jan 2024 21:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5PU1kEEh"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2078.outbound.protection.outlook.com [40.107.101.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C5139AC8;
	Wed, 31 Jan 2024 21:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706738378; cv=fail; b=Pc32W0VRCTFDNjLQ9ifN9hHmhbOLihEvk8m4hCQVG+aw77vTGzi4SkCOS7e5ZYZhaFEyHaqJr2Y+IbXjtHUBzOf7PjJYIlYpZCl2i1jldy6wglY5CPgu3pwikunCNWEYfw5TNXVHScArOnXQMEw5OtyjvTdzwsHJp0qQgpAglnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706738378; c=relaxed/simple;
	bh=IgNYeYW6GkXa5yWjutjP8e5U7xhsfxcI79+Ka6RSW7U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YpxYYj6Xv4IyLH26UfQ0pQuSnW3G+qYyZuiy9CXc2fjJBZqH1z5UP7YstV0eJEQxYSqVQP/gtE/HZrZHeMAVOKEvUbhMWAqVjuLQXnHozuNIIqKAjt8Irr8Lk294UJqrLoUTMqdrQLiSXAaMRKJtZv3S5+EI5Vg1taRrtLF1dzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5PU1kEEh; arc=fail smtp.client-ip=40.107.101.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SZgFT44nm9coRUHrL4erLdsqpzTR0Lq3LbhH42+5nwxTRM7kBruNLnFWUwKl8CADQf7zaJmfRhPhQKHSdb1gMCqaHgIfipgXDpQ7NWwXBN20yPAp4WDZ/oJ+kWCYeZ0AlMuc23hffUZITu9JqqOMQ52dwervadBqMx7sZXR6aFPrcDo7takDsmQTiorSRtcDBL67lz90Eo7xPbhlWbzuR9C+cGPiIGlRxgXtdPK7Ga2DVjuNkEZSyDat4U6oXAd2G5vTSM68Xu/rG+sZe4ZFXzlpsLWPaBn7N3229yY6wgo6zQh5WGo683Z2Ph1CeTuiV+8v1EdN9Lo4hFNSwP0uQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vMe8ZGgcTa0Ah0hQ4+nscMeIj9AMzlaKCoV54p0D2Rk=;
 b=Zp0ppfnc6n5I6FaW8L55yHrHB1tO404Jks4Bkq3yd5FgFNw4Bk4tylQ4dAwevl2J0TajGo8qcSFk22WKJE4CF5WxZ4fbyi/ngUUiX/NgRzMju06CJA2bXjNovLDlABNsCXD/wh6fV1Igk4oWTE1ckIg3XiJqKo3SQMhB+roo0L3zxkoGVDTcLXiM4qByxHU3M402hRDWFXsshEtWnHRJSdx5qlwOVP1W6glbR53LzGjnRmeoaB69Ki5m/PnOMiNlpt2r3s1QfGvynFsXqHeB4ArRkP/hqPkiMGhEmzsEqCTcUBsbMpzAC01b7lTqb2RVN4q28xEvE2qv+Rv9J7+ULw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMe8ZGgcTa0Ah0hQ4+nscMeIj9AMzlaKCoV54p0D2Rk=;
 b=5PU1kEEhu0mkhu00TTD6ffCwW1oSRXYu6TXRMUSoJbRRXK/X+Yn0kaa9KPYgxHo/rvB2oebBICYmhlZJ9/rGAOGPXtNmS2K5B56ax3pD7RQA/QBCVWz4KEJnIGNkRVkHdokZca9U5FiQ0o530UgbDTSblGNyoqVdYMTwqPPspZg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB4252.namprd12.prod.outlook.com (2603:10b6:5:211::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 21:59:34 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64%4]) with mapi id 15.20.7249.024; Wed, 31 Jan 2024
 21:59:34 +0000
Message-ID: <49825045-bce1-4772-b7c4-2e116e19cbaf@amd.com>
Date: Wed, 31 Jan 2024 15:59:32 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] cpufreq:amd-pstate: add quirk for the pstate CPPC
 capabilities missing
Content-Language: en-US
To: Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
 viresh.kumar@linaro.org, Ray.Huang@amd.com, gautham.shenoy@amd.com,
 Borislav.Petkov@amd.com
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1706690577.git.perry.yuan@amd.com>
 <ab45b5a29507460a63d772a0e4b24b83c9b61aa6.1706690577.git.perry.yuan@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <ab45b5a29507460a63d772a0e4b24b83c9b61aa6.1706690577.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR03CA0061.namprd03.prod.outlook.com
 (2603:10b6:5:100::38) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM6PR12MB4252:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a8c1602-bb40-446b-04b5-08dc22a7e8f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PIABbSk9XSSAdPRfvbl3zJ7I5uVg+CJFf7xr/wzBmqJbJmxr2yKGGNeS5BmArqfDsVghKwbEVHPjtCLLRwz2rwE20WTW2DaeUFGT9LNaXo26DwUX4qasnB3rKVCddVyzC1t8xQXfOwxJh5pLmZjKAKYXACQaH4O+Sxx69Gb3uZFTMUEF0F7smhTTeNC1MmZmcIOr282x75SS823iZJPCePRneECfqHBsChRtrPyL9KvNTLt1y90t01WA6ahtBoxT/sbX+gAqsP1lcYwt2yC+bilX7HIhG3RRltCfaV+2vbeArxVmMyi1XXA8dKmk75X5u10C3nbpJ/nq7PCSQDXGuZSFFngazfmQrR23kq9Q+sC5uZQvu690kGySU4mU+sgRmXdM/PufO7y738+yWA4R32aL/dCa/m/bWro/qYmT1zlS8tEK6lTvEfGGPXZT5SgLLLJHz7/xlhMEKSzUrXR2PnvDA2RzdlK80jZ02wPiPNdCdDSKCHcp6uwMvZJ9b8rb/Z5jM5za0M8pK4fxNHariuvVa3nvZ2qr+nIEycTj91UAJqt8Ycj1ebDZJAp7wxg3gs2YQqBYxIDGArdFJGrNvTmzIv0+jsopbsDZI5xGbcD2MRb+5+BhNM9Mt51ViZa67vJA+vyPWVNPTsU6rPlSHQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(376002)(39860400002)(396003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(31686004)(44832011)(6486002)(6512007)(2906002)(5660300002)(53546011)(2616005)(8676002)(8936002)(26005)(6636002)(66946007)(66556008)(316002)(66476007)(6506007)(4326008)(38100700002)(31696002)(86362001)(478600001)(41300700001)(83380400001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bCtONDFOenU3UHlOV3J3aHdRbEVnUXJwdWlsWjk4aVRNci8yNjhTS1FlUjd3?=
 =?utf-8?B?c1M5RHpiWFFaVEFlSlVxWWRFaU5ZOU5VTXU4UHoza1NVTWlaZXBUM21FSFpB?=
 =?utf-8?B?Y1BrV3NoNnQ1c1R6eXZkY0x3YjEyaFlPSTRMZzJQdFNNN0pDMEdSMStncjlM?=
 =?utf-8?B?QkJXbURsUWVyRlVzQkpkSXd3NDFiOG5CVVAwSEZ6bUdWK0Z4WkFRS1c2SFJK?=
 =?utf-8?B?RjR2M0FtOW1Pb0xkMm5uODZ1TzRBc0RpS2tyOENaNGh6dGdqT011ODJvK1VJ?=
 =?utf-8?B?V1BnNFpIcVNBRTdTcm40OTNRaXZwb3BpZTJVUUFEUXM3NlhMamxrMk8xdHU3?=
 =?utf-8?B?ajVmdFZ5VERwdE9ybk43RWYrQ3ZzRlBpUklKbzRqWFFyL1AvQnRNZDY0dkk0?=
 =?utf-8?B?akpTUmRCbFdqK3NmUjZNM1VaRGJ6Ym9SaVMrQlMwdnBUdmhjQXB6SXBMQzNZ?=
 =?utf-8?B?SjArVTk0ZkpyOVYwdUJ2RnZZenpXbFgxdlFhUnVYa3JLNkNSNEJPeDUrMXFE?=
 =?utf-8?B?bEZDY3F2NHBTY2NkV0lUVWtkbVNzNFpSOGpNSnQrelF2cldmSWg0QmpJeUho?=
 =?utf-8?B?UTVOTkZYcmYrVnB4TDl6YnlEbWZGTkNGcEFEZXB4QVVHbGZiWTlHeVJqMXMr?=
 =?utf-8?B?ZFhwUWNrQ1pUbFpEQ0ZNZHFsSDJ1S0pMZmF2U2RqK3JYeG5hUmxwdXpkRUJC?=
 =?utf-8?B?djRRWi9BR2ltd2R4dlBuR0FKUUZFVS96ZlptZ0FURnBSRi82TFE4R0VmOWNy?=
 =?utf-8?B?d3g4ajdTMHNRb09qKy9GeTh5WnFFQzk2dno3OXM0bll1RVNvQUk1OW1WUVJL?=
 =?utf-8?B?dG9MeTBjaEFTZFZkMHkyc3RVNVcvdTdBQ1gzQ3VWK29CU1MxUzhpSjgvRHV4?=
 =?utf-8?B?TnJTaXBpQTVrZkFtYkRxV2hvQ1U4TDlVMG5UWGF6WHVCYVEybWxHcGhZWEta?=
 =?utf-8?B?eG9DNzZkRUhvZUlQTCtidG9uVHo0RVdZd25hLy94YzA1SmZTUjROZnBHQ1pU?=
 =?utf-8?B?K1ZHWHZJM1VGTlNVUmgyV0FwVDNRcnhRejF1WDVGY3RqUUtUM1BPQXhCQkRB?=
 =?utf-8?B?aXd3cUJLZDdvYmhiR2Vsb2VTZVNjMjJ6UEFES0ZhbkRZa2NpbXNzYzFaQi9w?=
 =?utf-8?B?MzhiYmdtUHlYNnp4UEx1YzhRWU1FZVJSSDVueUFaZ1R5YlRaQVQ1TGhicklo?=
 =?utf-8?B?NnIzR1loWSs5bnI2NjcvdGpoc3lvV2k1bW1NcjBZTWFlbmExV3BzOVpzNkhJ?=
 =?utf-8?B?WTQ3RmFTY1Z5RDhnRUxjMGE2NlF4aGR5ckFoMktvOTNBRlVROVUzT25uK1Vq?=
 =?utf-8?B?bEVHS3Z1QTlOMFg0NndycEFqNUpMak91dS9DdllFMTV6ZU9NbjhNYzl1ajdK?=
 =?utf-8?B?TzVnSm80S2czQWcwOVc4WkV0U3hWT0IzWElEUGh2ZDJSTERvNk5GRnliZ3hY?=
 =?utf-8?B?TnZ5RXFBV09zcjJEZ2RsYVNsM3lRY0c3Y2hvMml5VXFSWGZ5alVVdUVlZGtS?=
 =?utf-8?B?WEZ3UUxxZC9QV0c4Z1hsdjMzenJ6NFE1d3hMN1RCVUJsUE80N3lRaHhGN3pX?=
 =?utf-8?B?eFJYTUpQbVZLYnZtMTFWdmcxSGtEVDBkYjBwQzJhRXVwM3RvMzByTHlWZzVm?=
 =?utf-8?B?RlhYMlRySTJJTkc1R2QycjA5V1RBVmNHalJRRTZEQmxYTTFIbnlPL1ZGemsr?=
 =?utf-8?B?Y0dkUjlsTy9wc3NIalZDUTZYbnhlNE9iRVVnblprQlNCY3QwY0QvM2FtS1hF?=
 =?utf-8?B?WkUrYzRXTk1UTzJFaU5jcVBUTm5uQ29LcndGd1ROYVFGYURuTkNnYzQ0VWJz?=
 =?utf-8?B?bGxDU3Y3ZGZxWHdsdHZhYmk5T1UxME1ndHNzZFFqWWRJeTE2ODY0UXl0aEFp?=
 =?utf-8?B?MHRBRG9sYmwwODZaalFLeHBUWmFNNkZOV3JMMUZwV3cvWUdCcGtCa2h0enUv?=
 =?utf-8?B?ZWVLZjdYdGFrbUQzckFrL2VxQitxNkRxR1RMUDRKaXZFMksxYU9DcUdTZVQ4?=
 =?utf-8?B?d1FmYXkwb0RDZVZSTDNNdlcxaHNROW1ZRjNac1dRN05oUS9ESFNBY0ZWZ3px?=
 =?utf-8?B?NlBPQ0NXNm1hN3ZVSmVUT1JUWE94U1BBL2RiaDdGNG92NGQxL1hrYnFyL0ZR?=
 =?utf-8?Q?rZGMDwIXcm3sAKs2yPMDLZdMH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a8c1602-bb40-446b-04b5-08dc22a7e8f1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 21:59:34.4117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aKZmVrxf2lC0DXQwkQ8J1ofabXdvsQZDHz0x1CUUK7Bt0paOyZSA6/6pBasw8tSg5Gwq3nowe7t1WDfn8O1vjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4252

On 1/31/2024 02:50, Perry Yuan wrote:
> Add quirk table to get CPPC capabilities issue fixed by providing
> correct perf or frequency values while driver loading.
> 
> If CPPC capabilities are not defined in the ACPI tables or wrongly
> defined by platform firmware, it needs to use quick to get those

s/quick/quirk/

> issues fixed with correct workaround values to make pstate driver

to allow the pstate driver

> can be loaded even though there are CPPC capabilities errors.
> 
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 51 +++++++++++++++++++++++++++++++-----
>   include/linux/amd-pstate.h   |  6 +++++
>   2 files changed, 51 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index eea2e192d748..cbc415af0f08 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -64,6 +64,7 @@ static struct cpufreq_driver amd_pstate_driver;
>   static struct cpufreq_driver amd_pstate_epp_driver;
>   static int cppc_state = AMD_PSTATE_UNDEFINED;
>   static bool cppc_enabled;
> +static struct quirk_entry *quirks;
>   
>   /**
>    * struct global_params - Global parameters, mostly tunable via sysfs.
> @@ -121,6 +122,32 @@ static unsigned int epp_values[] = {
>   
>   typedef int (*cppc_mode_transition_fn)(int);
>   
> +static struct quirk_entry quirk_amd_7k62 = {
> +	.nominal_freq = 2600,
> +	.lowest_freq = 550,
> +};
> +
> +static int __init dmi_matched(const struct dmi_system_id *dmi)
> +{
> +	quirks = dmi->driver_data; > +

Under the presumption that the quirk list will grow as more buggy older 
machines are identified, maybe it's worth having a dyndbg or info 
statement here to indicate that it's using quirked values for dmi->ident.

> +	return 1;
> +}
> +
> +static const struct dmi_system_id amd_pstate_quirks_table[] __initconst = {
> +	{
> +		.callback = dmi_matched,
> +		.ident = "AMD EPYC 7K62",
> +		.matches = {
> +			DMI_MATCH(DMI_PRODUCT_VERSION, "C1"),
> +			DMI_MATCH(DMI_PRODUCT_SERIAL, "FX19911000028"),

This is way too specific isn't it?  It would only load on that single 
system I would expect.  But I think you want to have an entry that 
matches the DMI_PRODUCT_NAME or DMI_FAMILY_NAME instead most likely.

> +		},
> +		.driver_data = &quirk_amd_7k62,
> +	},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(dmi, amd_pstate_quirks_table);
> +
>   static inline int get_mode_idx_from_str(const char *str, size_t size)
>   {
>   	int i;
> @@ -581,13 +608,19 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>   static int amd_get_min_freq(struct amd_cpudata *cpudata)
>   {
>   	struct cppc_perf_caps cppc_perf;
> +	u32 lowest_freq;
>   
>   	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
>   	if (ret)
>   		return ret;
>   
> +	if (quirks && quirks->lowest_freq)
> +		lowest_freq = quirks->lowest_freq;
> +	else
> +		lowest_freq = cppc_perf.lowest_freq;
> +
>   	/* Switch to khz */
> -	return cppc_perf.lowest_freq * 1000;
> +	return lowest_freq * 1000;
>   }
>   
>   static int amd_get_max_freq(struct amd_cpudata *cpudata)
> @@ -619,13 +652,14 @@ static int amd_get_max_freq(struct amd_cpudata *cpudata)
>   
>   static int amd_get_nominal_freq(struct amd_cpudata *cpudata)
>   {
> -	struct cppc_perf_caps cppc_perf;
> +	u32 nominal_freq;
>   
> -	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
> -	if (ret)
> -		return ret;

I think this hunk should be earlier in your series.  Conceptually it 
seems to match what patch 3 does to me.

> +	if (quirks && quirks->nominal_freq)
> +		nominal_freq = quirks->nominal_freq;
> +	else
> +		nominal_freq = READ_ONCE(cpudata->nominal_freq);
>   
> -	return cppc_perf.nominal_freq;
> +	return nominal_freq;
>   }
>   
>   static int amd_get_lowest_nonlinear_freq(struct amd_cpudata *cpudata)
> @@ -1623,6 +1657,11 @@ static int __init amd_pstate_init(void)
>   	if (cpufreq_get_current_driver())
>   		return -EEXIST;
>   
> +	quirks = NULL;
> +
> +	/* check if this machine need CPPC quirks */
> +	dmi_check_system(amd_pstate_quirks_table);
> +
>   	switch (cppc_state) {
>   	case AMD_PSTATE_UNDEFINED:
>   		/* Disable on the following configs by default:
> diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> index 446394f84606..ea80f961607d 100644
> --- a/include/linux/amd-pstate.h
> +++ b/include/linux/amd-pstate.h
> @@ -110,4 +110,10 @@ static const char * const amd_pstate_mode_string[] = {
>   	[AMD_PSTATE_GUIDED]      = "guided",
>   	NULL,
>   };
> +
> +struct quirk_entry {
> +	u32 nominal_freq;
> +	u32 lowest_freq;
> +};
> +
>   #endif /* _LINUX_AMD_PSTATE_H */


