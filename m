Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012BA7FDE49
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 18:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbjK2RY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 12:24:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbjK2RYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 12:24:25 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2047.outbound.protection.outlook.com [40.107.95.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD70FC1;
        Wed, 29 Nov 2023 09:24:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=itDY/ZpWSP7IlTDpraWwoxPeD9nBwkqmF7dWEsZYLU0Eqb3gd7xL0EeDK2arIf7/YXmK0DVwa3gQipdy86HG3KW4YRIX2nxwnffFoPomJmr1KnRaGSGZl7+6an/oJecdCN+mfDZjqHILLUQJpB+bzDyTOclnoeHXfY/gaxMeF8Ql+HYpMQmp/X2VP8A3DZBvXDx+UNvZuybgw6ot8+dZ18MBaTrhaZRsiGXO/PtmGRqeYtPgM5SLjE3qH76ikyCcsZvgWsDSxcsbzEROvEQG9Xax2uKwVDVgg1gLbUfLOgDpc2piNlWrNxNt7fyMCtoq5UQSjQtw6TIZsm832QvGwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jk4DszK85KMfFFQvRSV5iikJY9ImULmfazls2wWobOU=;
 b=HXFG7d9D6/uDWgGitRedrg/P0G1/F3CFklQL7ELWmR8DE8bvALYB/xdE/r5ddsxsASESWz8z2FaNl6zvJiw+pnrcnMuoibT21Vm9gvLgcnv6js78B2tiNQMeLCvf4GYxqhu0x5P/U3ejuf4HGLwHctHe2ucb09IYZfxv3hfUlbkJhXDfLvCL+p6ia6WKxoELmXDXC6JDAc+aep6ZTqyTpjjbp35v0SGlFaYdsEmvHVI25PyVmzBvbt2v+JwEA88B8TveT0RPrs4rXzJqO0B11pbxBjrAcpJONAMHkb8Pf3owJtY1c/9jh9toMsxEOiuP6Y7tDk0QwbfyAaUMTBcKUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jk4DszK85KMfFFQvRSV5iikJY9ImULmfazls2wWobOU=;
 b=XNi4mYDYA2+1V9rZ6a5gWSsjXU7Ou3tYwUhaAbvlSwIKOYlz+lhASDY3LcD6CSQ5gcKwgP/65N9ROo1bd1DXLthUldqy+I8wLHKBz6rAvf6QFUJXITNGPjOc4pG3TsQ9SNaFc2OORpuw6hZj6kJnfhEkuXopzhpNvR/kqta6OFw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB8018.namprd12.prod.outlook.com (2603:10b6:8:149::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Wed, 29 Nov
 2023 17:24:25 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 17:24:25 +0000
Message-ID: <0eb714e7-c30d-456b-aef5-0342dfc947c6@amd.com>
Date:   Wed, 29 Nov 2023 11:24:21 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 2/9] platform/x86/amd: Add support for AMD ACPI based
 Wifi band RFI mitigation feature
Content-Language: en-US
To:     Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org,
        lenb@kernel.org, hdegoede@redhat.com, johannes@sipsolutions.net,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, alexander.deucher@amd.com, Lijo.Lazar@amd.com,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Cc:     majun@amd.com, Evan Quan <quanliangl@hotmail.com>
References: <20231129091348.3972539-1-Jun.Ma2@amd.com>
 <20231129091348.3972539-3-Jun.Ma2@amd.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231129091348.3972539-3-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR12CA0025.namprd12.prod.outlook.com
 (2603:10b6:806:6f::30) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB8018:EE_
X-MS-Office365-Filtering-Correlation-Id: 94eb19f9-ac16-428a-44b3-08dbf1000883
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ypbmH///MzLd/acByfOxz0osYCth2iBqE5rxsfGePAGlbkpVFWUVzMwOoN4UKIHlUQm3aPlt7kHdTrPhMHXVSCWeuR8pGZbwtNotFBU8EjPSRe/lCaUJRL536YeBoLDrADrq7e7LTkyewiW6LAhgYHz1moounpmuz81iL4aMnWYYPLVMkTiUCecWd48H9hTkasF76qCGfr0JAyHaVcjQoTRfiHh+XjYmtN3b1JwiObkvbMgrSFZnTPXjIa+6RF1kLIEFTJcvTP1bw94zCQ+R7SWmQWgaQTdkb7LMR6Sr/ULvxePBAzr9wvs00af9U+YzdwUrT+XkbRjnEEMVrQ/Tflp6C8tesgkrFtiyY0h6EY+AFo2CNT8tK9a0Cmen5h7v9A47maMVVXooXeC1XGHdOQ/lbb1h0DB6X4o0sVdDqzT8Q6d9TTIbBfBfuonBFbHaHcDKNLmNdhigPqPFwSeDXfJYmFqPUlzOrG2bxWi1ri9Z49Obhbx/D1vYWna2yPzETTla8RwER/4LOeWIo1RRVFkIXD0D8FtI/k/5xx3knGFfYZmB8zbl4UczeeRGX2LpjAJWN8qfIb+cFY4Fg8uPrpbxL6c+K0N3GGmQBf0sf+C9GGdJNP52BjtFx9aZ4kTJAiWerKLTjIyjwA26JAxdM9YKewbMUnI9cXHRHGqieAQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(136003)(376002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(6666004)(8676002)(31696002)(478600001)(8936002)(45080400002)(4326008)(6512007)(6506007)(53546011)(316002)(66946007)(66556008)(66476007)(6486002)(30864003)(41300700001)(38100700002)(921008)(36756003)(31686004)(86362001)(2906002)(26005)(44832011)(2616005)(7416002)(83380400001)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0FBNEF0K0ZMazR1cUtYZkZZd0FWQWpYa1VSR08weG03K1dTM1QxcG5xV2Ry?=
 =?utf-8?B?akhvY2pTK3R3a1NUN2tmckZPc1RmSlJlampaZXkxSldIVE0rdmdWVFA2bDBn?=
 =?utf-8?B?WUZ0cTJPRm8wRDRadkp4ZUh6M1FyT1hsT3hjbHJXMjQ0V3hob0dTUzFIbDAy?=
 =?utf-8?B?TEdxdHYrWGRLQVVwOGVDMDdUNkNEQlZmSEd3SFFvd0toNHR6eTdTNzkwcTkr?=
 =?utf-8?B?cm45bXNPcTQvOUZoUFV3b1dEWlRSdmMzYnNBNUpzMVNxNWdncVYvWTRNbGNk?=
 =?utf-8?B?VjZDZHYwZE4xY2NZRzZ6S0E2N2JTTzF4RFlhUm1TRmlKOXhGZzgzN1Zmd3F1?=
 =?utf-8?B?SktYMGViYUVnM2I2bzNtK082RFhteGhoYXU4Q201bitTQmlja2NmNDdsOFpW?=
 =?utf-8?B?cTRaV3B0ekd0dkFQemNmUTNzei93SEJFcGNtN0RSeUt6V1JZVy9od0ZtRk92?=
 =?utf-8?B?OXIyYm9IRWtveHdYMFdOUE0rTHllVHY1K29PTHNTRW5PZEFHamVGRm1nM0NH?=
 =?utf-8?B?NzBwU0tGdmtzeEJBNVdRcUhnQTlaTy9mK2tkWDFaVUJyNTN3cjhjVFF0a1d6?=
 =?utf-8?B?cFQwSEI1TEgwOGhzNE0vMkJQemFHUThTM0UvUG1XelRiOHBIdlgwZ2tjM25i?=
 =?utf-8?B?WjFIMXFSdXF0cWVKTU1PNlZza3NpVUVrcWlpdjI0OFlPVzY3dm5aK3k5ZENm?=
 =?utf-8?B?WVd0bHZQaEgrWFVxTzFNT2ExazFKR250biszbmdNWGp5SGYzeVFRWHZYS1hV?=
 =?utf-8?B?b0JlNUsyTFdoa1I4WkUwR2JlbXZhbFFVblRwS2ZMbmNERXJXa1YyVU5GWFhR?=
 =?utf-8?B?WS9rajFhVU5wdEVHSWZhUDdXNkFiRS91UUtiT2ovWmZ5T2VNUU8xZ3lCK09h?=
 =?utf-8?B?cU81U1RzYlF5Rk52TVhYUlpuQWRuUFlCZ3B2N0JhL3A4eUtsZXRqc3V3NjRk?=
 =?utf-8?B?NHROMDNkWlNGNjdzTElRcXZLS29pZytlRnRsQ2x3ZUhseXNqdjdlMGpwSkVX?=
 =?utf-8?B?M3RIRUNma2h5QWN0aFZ2cHVhbW1sY3BzMWlYVjdMWW15c0QzQUFqcmkzVC9k?=
 =?utf-8?B?azdoSi96MldlbnF0TFhTcVhjci9BYWJGVVpXMFUvMDB3NmpVT1FkR1IvOFZ6?=
 =?utf-8?B?S0pFSXhQSGR2cFJMaTJHYmNxV0l0cHFlUlVXZUlSMGFxaXVYckoyTEJyN1dM?=
 =?utf-8?B?UkZWOVZJbnVRa0VlQ0tBbXNiYzUyTlNMN3ZGNm5Lb2pkUVdYZ3c4THpHNGxj?=
 =?utf-8?B?ZzkvckJEUy9kNmdrTzhWbWdNRkV3ZXRDTndPMW0veCtCU3RKSFBWd2pjZlgx?=
 =?utf-8?B?TTJMWUd6ZUZiWW15ekFSSTlVaDhzYk5YeDZkNWNNUW9ZbkUzYmh5Z2RMSU93?=
 =?utf-8?B?ekRjdDlQV2hRMjduMXhPTk81clVnME5sbGUrb3ZnZ2R5S1VCazQxTDY2alZx?=
 =?utf-8?B?K3FOeUd2c25HM2FiaW1qL3RIeHpqVFNiUXFjUVRONWxtN3JqOVlrZW5sMkFP?=
 =?utf-8?B?ak52WlhRL1lqdk5QQ1VQZUdNWlN3eHlmdXpBWlNibnVQOEo1elRjYWFsQ1Zz?=
 =?utf-8?B?bkVFbnRSU2RwMER1MWNsa3pDeWFENHlRSGdFcHY4Rk9JSWh4TjNqdWNEQnV0?=
 =?utf-8?B?WlQ0bjJJQW1IdnQ0VkhibUJEWmR2eFA0TGM0cjVtYTJJQ0c5WFdUd3hTTlN2?=
 =?utf-8?B?OVJ2YUQvNEQ1VFZzTnd3Rmk2NkRMMlh1Tk82ZEw4Ykc2TnlHdXN0ZDRyampV?=
 =?utf-8?B?VjNGTGViNUk2Mno5S3NUVEQreGExcFA3Ty9TMkJmV3E5eFFYMlpSOWw5NCs4?=
 =?utf-8?B?OUp1Y3dnSVp1eEt4YmpnUlJiUlhsTk96R1oyc0tyYnAzVXNvNmxHdmNRTm5V?=
 =?utf-8?B?OTJvTnowcllkMkhmNEFZM0FmOVIrcXo3emw2K3RVS1FDTW9kQ0d0dm5wcGEx?=
 =?utf-8?B?emFHWlBhY2RNK2Zia0IvejgzTnh4SkZkOTNZMTU2ZnpxaWNpOUxPUU5QMWlt?=
 =?utf-8?B?NWNuY2w2VzlERmtqZGFIVHJBeUV4QWh4MFFqY3lXVUk3WlVXZ2F0TjFuU3FX?=
 =?utf-8?B?OXpsWmtrZjZ6YkhvekhvUjIyUVQvVXFvZUlBMmpJdmhPU1dFOEE4QW05UHYv?=
 =?utf-8?Q?ZcS8wr/EcCnw62bxJd5b4UJ4z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94eb19f9-ac16-428a-44b3-08dbf1000883
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 17:24:24.9382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T8MvhL0Mg/5epGqpe7JRinCgRt04X7EKJnQFyogZ7RV1p53FDnoMZmLK5aDAX3WVROJaJ8J5seS7C7zwS3MiRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8018
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/2023 03:13, Ma Jun wrote:
> Due to electrical and mechanical constraints in certain platform designs
> there may be likely interference of relatively high-powered harmonics of
> the (G-)DDR memory clocks with local radio module frequency bands used
> by Wifi 6/6e/7.
> 
> To mitigate this, AMD has introduced a mechanism that devices can use to
> notify active use of particular frequencies so that other devices can make
> relative internal adjustments as necessary to avoid this resonance.
> 
> Co-developed-by: Evan Quan <quanliangl@hotmail.com>
> Signed-off-by: Evan Quan <quanliangl@hotmail.com>
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>

I have one very minor nit below that if no other feedback is needed for 
the series can be fixed when committing.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> 
> --
> v11:
>   - fix typo(Simon)
> v12:
>   - Fix the code logic (Rafael)
>   - Move amd_wbrf.c to drivers/platform/x86/amd/wbrf.c
>   - Updated Evan's email because he's no longer at AMD.Thanks
> for his work in earlier versions.
> v13:
>   - Fix the format issue (IIpo Jarvinen)
>   - Add comment for some functions
> v14:
>   - Use the apci_check_dsm and acpi_evaluate_dsm (Hans de Goede)
> ---
>   drivers/platform/x86/amd/Kconfig  |  15 ++
>   drivers/platform/x86/amd/Makefile |   1 +
>   drivers/platform/x86/amd/wbrf.c   | 337 ++++++++++++++++++++++++++++++
>   include/linux/acpi_amd_wbrf.h     |  94 +++++++++
>   4 files changed, 447 insertions(+)
>   create mode 100644 drivers/platform/x86/amd/wbrf.c
>   create mode 100644 include/linux/acpi_amd_wbrf.h
> 
> diff --git a/drivers/platform/x86/amd/Kconfig b/drivers/platform/x86/amd/Kconfig
> index 55f3a2fc6aec..ac2b7758a04f 100644
> --- a/drivers/platform/x86/amd/Kconfig
> +++ b/drivers/platform/x86/amd/Kconfig
> @@ -18,3 +18,18 @@ config AMD_HSMP
>   
>   	  If you choose to compile this driver as a module the module will be
>   	  called amd_hsmp.
> +
> +config AMD_WBRF
> +	bool "AMD Wifi RF Band mitigations (WBRF)"
> +	depends on ACPI
> +	default n

I believe the "default n" is unnecessary as it's implied.

> +	help
> +	  WBRF(Wifi Band RFI mitigation) mechanism allows Wifi drivers
> +	  to notify the frequencies they are using so that other hardware
> +	  can be reconfigured to avoid harmonic conflicts.
> +
> +	  AMD provides an ACPI based mechanism to support WBRF on platform with
> +	  appropriate underlying support.
> +
> +	  This mechanism will only be activated on platforms that advertise a
> +	  need for it.
> diff --git a/drivers/platform/x86/amd/Makefile b/drivers/platform/x86/amd/Makefile
> index f04932b7a7d1..dcec0a46f8af 100644
> --- a/drivers/platform/x86/amd/Makefile
> +++ b/drivers/platform/x86/amd/Makefile
> @@ -8,3 +8,4 @@ obj-$(CONFIG_AMD_PMC)		+= pmc/
>   amd_hsmp-y			:= hsmp.o
>   obj-$(CONFIG_AMD_HSMP)		+= amd_hsmp.o
>   obj-$(CONFIG_AMD_PMF)		+= pmf/
> +obj-$(CONFIG_AMD_WBRF)		+= wbrf.o
> diff --git a/drivers/platform/x86/amd/wbrf.c b/drivers/platform/x86/amd/wbrf.c
> new file mode 100644
> index 000000000000..36e90a1159be
> --- /dev/null
> +++ b/drivers/platform/x86/amd/wbrf.c
> @@ -0,0 +1,337 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Wifi Frequency Band Manage Interface
> + * Copyright (C) 2023 Advanced Micro Devices
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/acpi_amd_wbrf.h>
> +
> +#define ACPI_AMD_WBRF_METHOD	"\\WBRF"
> +
> +/*
> + * Functions bit vector for WBRF method
> + *
> + * Bit 0: WBRF supported.
> + * Bit 1: Function 1 (Add / Remove frequency) is supported.
> + * Bit 2: Function 2 (Get frequency list) is supported.
> + */
> +#define WBRF_ENABLED		0x0
> +#define WBRF_RECORD			0x1
> +#define WBRF_RETRIEVE		0x2
> +
> +#define WBRF_REVISION		0x1
> +
> +/*
> + * The data structure used for WBRF_RETRIEVE is not naturally aligned.
> + * And unfortunately the design has been settled down.
> + */
> +struct amd_wbrf_ranges_out {
> +	u32			num_of_ranges;
> +	struct freq_band_range	band_list[MAX_NUM_OF_WBRF_RANGES];
> +} __packed;
> +
> +static const guid_t wifi_acpi_dsm_guid =
> +	GUID_INIT(0x7b7656cf, 0xdc3d, 0x4c1c,
> +		  0x83, 0xe9, 0x66, 0xe7, 0x21, 0xde, 0x30, 0x70);
> +
> +/*
> + * Used to notify consumer (amdgpu driver currently) about
> + * the wifi frequency is change.
> + */
> +static BLOCKING_NOTIFIER_HEAD(wbrf_chain_head);
> +
> +static int wbrf_record(struct acpi_device *adev, uint8_t action, struct wbrf_ranges_in_out *in)
> +{
> +	union acpi_object argv4;
> +	union acpi_object *tmp;
> +	union acpi_object *obj;
> +	u32 num_of_ranges = 0;
> +	u32 num_of_elements;
> +	u32 arg_idx = 0;
> +	int ret;
> +	u32 i;
> +
> +	if (!in)
> +		return -EINVAL;
> +
> +	for (i = 0; i < ARRAY_SIZE(in->band_list); i++) {
> +		if (in->band_list[i].start && in->band_list[i].end)
> +			num_of_ranges++;
> +	}
> +
> +	/*
> +	 * The num_of_ranges value in the "in" object supplied by
> +	 * the caller is required to be equal to the number of
> +	 * entries in the band_list array in there.
> +	 */
> +	if (num_of_ranges != in->num_of_ranges)
> +		return -EINVAL;
> +
> +	/*
> +	 * Every input frequency band comes with two end points(start/end)
> +	 * and each is accounted as an element. Meanwhile the range count
> +	 * and action type are accounted as an element each.
> +	 * So, the total element count = 2 * num_of_ranges + 1 + 1.
> +	 */
> +	num_of_elements = 2 * num_of_ranges + 2;
> +
> +	tmp = kcalloc(num_of_elements, sizeof(*tmp), GFP_KERNEL);
> +	if (!tmp)
> +		return -ENOMEM;
> +
> +	argv4.package.type = ACPI_TYPE_PACKAGE;
> +	argv4.package.count = num_of_elements;
> +	argv4.package.elements = tmp;
> +
> +	/* save the number of ranges*/
> +	tmp[0].integer.type = ACPI_TYPE_INTEGER;
> +	tmp[0].integer.value = num_of_ranges;
> +
> +	/* save the action(WBRF_RECORD_ADD/REMOVE/RETRIEVE) */
> +	tmp[1].integer.type = ACPI_TYPE_INTEGER;
> +	tmp[1].integer.value = action;
> +
> +	arg_idx = 2;
> +	for (i = 0; i < ARRAY_SIZE(in->band_list); i++) {
> +		if (!in->band_list[i].start || !in->band_list[i].end)
> +			continue;
> +
> +		tmp[arg_idx].integer.type = ACPI_TYPE_INTEGER;
> +		tmp[arg_idx++].integer.value = in->band_list[i].start;
> +		tmp[arg_idx].integer.type = ACPI_TYPE_INTEGER;
> +		tmp[arg_idx++].integer.value = in->band_list[i].end;
> +	}
> +
> +	obj = acpi_evaluate_dsm(adev->handle, &wifi_acpi_dsm_guid,
> +				WBRF_REVISION, WBRF_RECORD, &argv4);
> +
> +	if (!obj)
> +		return -EINVAL;
> +
> +	if (obj->type != ACPI_TYPE_INTEGER) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	ret = obj->integer.value;
> +	if (ret)
> +		ret = -EINVAL;
> +
> +out:
> +	ACPI_FREE(obj);
> +	kfree(tmp);
> +
> +	return ret;
> +}
> +
> +/**
> + * acpi_amd_wbrf_add_remove - add or remove the frequency band the device is using
> + *
> + * @dev: device pointer
> + * @action: remove or add the frequency band into bios
> + * @in: input structure containing the frequency band the device is using
> + *
> + * Broadcast to other consumers the frequency band the device starts
> + * to use. Underneath the surface the information is cached into an
> + * internal buffer first. Then a notification is sent to all those
> + * registered consumers. So then they can retrieve that buffer to
> + * know the latest active frequency bands. Consumers that haven't
> + * yet been registered can retrieve the information from the cache
> + * when they register.
> + *
> + * Return:
> + * 0 for success add/remove wifi frequency band.
> + * Returns a negative error code for failure.
> + */
> +int acpi_amd_wbrf_add_remove(struct device *dev, uint8_t action, struct wbrf_ranges_in_out *in)
> +{
> +	struct acpi_device *adev;
> +	int ret;
> +
> +	adev = ACPI_COMPANION(dev);
> +	if (!adev)
> +		return -ENODEV;
> +
> +	ret = wbrf_record(adev, action, in);
> +	if (ret)
> +		return ret;
> +
> +	blocking_notifier_call_chain(&wbrf_chain_head, WBRF_CHANGED, NULL);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(acpi_amd_wbrf_add_remove);
> +
> +static bool acpi_amd_wbrf_supported_system(void)
> +{
> +	acpi_status status;
> +	acpi_handle handle;
> +
> +	status = acpi_get_handle(NULL, ACPI_AMD_WBRF_METHOD, &handle);
> +
> +	return ACPI_SUCCESS(status);
> +}
> +
> +/**
> + * acpi_amd_wbrf_supported_producer - determine if the WBRF can be enabled
> + *                                    for the device as a producer
> + *
> + * @dev: device pointer
> + *
> + * Check if the platform equipped with necessary implementations to
> + * support WBRF for the device as a producer.
> + *
> + * Return:
> + * true if WBRF is supported, otherwise returns false
> + */
> +bool acpi_amd_wbrf_supported_producer(struct device *dev)
> +{
> +	struct acpi_device *adev;
> +
> +	adev = ACPI_COMPANION(dev);
> +	if (!adev)
> +		return false;
> +
> +	if (!acpi_amd_wbrf_supported_system())
> +		return false;
> +
> +
> +	return acpi_check_dsm(adev->handle, &wifi_acpi_dsm_guid,
> +			      WBRF_REVISION, BIT(WBRF_RECORD));
> +}
> +EXPORT_SYMBOL_GPL(acpi_amd_wbrf_supported_producer);
> +
> +/**
> + * acpi_amd_wbrf_supported_consumer - determine if the WBRF can be enabled
> + *                                    for the device as a consumer
> + *
> + * @dev: device pointer
> + *
> + * Determine if the platform equipped with necessary implementations to
> + * support WBRF for the device as a consumer.
> + *
> + * Return:
> + * true if WBRF is supported, otherwise returns false.
> + */
> +bool acpi_amd_wbrf_supported_consumer(struct device *dev)
> +{
> +	struct acpi_device *adev;
> +
> +	adev = ACPI_COMPANION(dev);
> +	if (!adev)
> +		return false;
> +
> +	if (!acpi_amd_wbrf_supported_system())
> +		return false;
> +
> +	return acpi_check_dsm(adev->handle, &wifi_acpi_dsm_guid,
> +			      WBRF_REVISION, BIT(WBRF_RETRIEVE));
> +}
> +EXPORT_SYMBOL_GPL(acpi_amd_wbrf_supported_consumer);
> +
> +/**
> + * amd_wbrf_retrieve_freq_band - retrieve current active frequency
> + *                                     bands
> + *
> + * @dev: device pointer
> + * @out: output structure containing all the active frequency bands
> + *
> + * Retrieve the current active frequency bands which were broadcasted
> + * by other producers. The consumer who calls this API should take
> + * proper actions if any of the frequency band may cause RFI with its
> + * own frequency band used.
> + *
> + * Return:
> + * 0 for getting wifi freq band successfully.
> + * Returns a negative error code for failure.
> + */
> +int amd_wbrf_retrieve_freq_band(struct device *dev, struct wbrf_ranges_in_out *out)
> +{
> +	struct amd_wbrf_ranges_out acpi_out = {0};
> +	struct acpi_device *adev;
> +	union acpi_object *obj;
> +	union acpi_object param;
> +	int ret = 0;
> +
> +	adev = ACPI_COMPANION(dev);
> +	if (!adev)
> +		return -ENODEV;
> +
> +	param.type = ACPI_TYPE_STRING;
> +	param.string.length = 0;
> +	param.string.pointer = NULL;
> +
> +	obj = acpi_evaluate_dsm(adev->handle, &wifi_acpi_dsm_guid,
> +							WBRF_REVISION, WBRF_RETRIEVE, &param);
> +	if (!obj)
> +		return -EINVAL;
> +
> +	/*
> +	 * The return buffer is with variable length and the format below:
> +	 * number_of_entries(1 DWORD):       Number of entries
> +	 * start_freq of 1st entry(1 QWORD): Start frequency of the 1st entry
> +	 * end_freq of 1st entry(1 QWORD):   End frequency of the 1st entry
> +	 * ...
> +	 * ...
> +	 * start_freq of the last entry(1 QWORD)
> +	 * end_freq of the last entry(1 QWORD)
> +	 *
> +	 * Thus the buffer length is determined by the number of entries.
> +	 * - For zero entry scenario, the buffer length will be 4 bytes.
> +	 * - For one entry scenario, the buffer length will be 20 bytes.
> +	 */
> +	if (obj->buffer.length > sizeof(acpi_out) || obj->buffer.length < 4) {
> +		dev_err(dev, "Wrong sized WBRT information");
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +	memcpy(&acpi_out, obj->buffer.pointer, obj->buffer.length);
> +
> +	out->num_of_ranges = acpi_out.num_of_ranges;
> +	memcpy(out->band_list, acpi_out.band_list, sizeof(acpi_out.band_list));
> +
> +out:
> +	ACPI_FREE(obj);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(amd_wbrf_retrieve_freq_band);
> +
> +/**
> + * amd_wbrf_register_notifier - register for notifications of frequency
> + *                                   band update
> + *
> + * @nb: driver notifier block
> + *
> + * The consumer should register itself via this API so that it can get
> + * notified on the frequency band updates from other producers.
> + *
> + * Return:
> + * 0 for registering a consumer driver successfully.
> + * Returns a negative error code for failure.
> + */
> +int amd_wbrf_register_notifier(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_register(&wbrf_chain_head, nb);
> +}
> +EXPORT_SYMBOL_GPL(amd_wbrf_register_notifier);
> +
> +/**
> + * amd_wbrf_unregister_notifier - unregister for notifications of
> + *                                     frequency band update
> + *
> + * @nb: driver notifier block
> + *
> + * The consumer should call this API when it is longer interested with
> + * the frequency band updates from other producers. Usually, this should
> + * be performed during driver cleanup.
> + *
> + * Return:
> + * 0 for unregistering a consumer driver.
> + * Returns a negative error code for failure.
> + */
> +int amd_wbrf_unregister_notifier(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_unregister(&wbrf_chain_head, nb);
> +}
> +EXPORT_SYMBOL_GPL(amd_wbrf_unregister_notifier);
> diff --git a/include/linux/acpi_amd_wbrf.h b/include/linux/acpi_amd_wbrf.h
> new file mode 100644
> index 000000000000..15b54734a080
> --- /dev/null
> +++ b/include/linux/acpi_amd_wbrf.h
> @@ -0,0 +1,94 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Wifi Band Exclusion Interface (AMD ACPI Implementation)
> + * Copyright (C) 2023 Advanced Micro Devices
> + */
> +
> +#ifndef _ACPI_AMD_WBRF_H
> +#define _ACPI_AMD_WBRF_H
> +
> +#include <linux/device.h>
> +#include <linux/notifier.h>
> +
> +/* The maximum number of frequency band ranges */
> +#define MAX_NUM_OF_WBRF_RANGES		11
> +
> +/* Record actions */
> +#define WBRF_RECORD_ADD		0x0
> +#define WBRF_RECORD_REMOVE	0x1
> +
> +/**
> + * struct freq_band_range - Wifi frequency band range definition
> + * @start: start frequency point (in Hz)
> + * @end: end frequency point (in Hz)
> + */
> +struct freq_band_range {
> +	u64		start;
> +	u64		end;
> +};
> +
> +/**
> + * struct wbrf_ranges_in_out - wbrf ranges info
> + * @num_of_ranges: total number of band ranges in this struct
> + * @band_list: array of Wifi band ranges
> + */
> +struct wbrf_ranges_in_out {
> +	u64			num_of_ranges;
> +	struct freq_band_range	band_list[MAX_NUM_OF_WBRF_RANGES];
> +};
> +
> +/**
> + * enum wbrf_notifier_actions - wbrf notifier actions index
> + * @WBRF_CHANGED: there was some frequency band updates. The consumers
> + *               should retrieve the latest active frequency bands.
> + */
> +enum wbrf_notifier_actions {
> +	WBRF_CHANGED,
> +};
> +
> +#if IS_ENABLED(CONFIG_AMD_WBRF)
> +bool acpi_amd_wbrf_supported_producer(struct device *dev);
> +int acpi_amd_wbrf_add_remove(struct device *dev, uint8_t action, struct wbrf_ranges_in_out *in);
> +bool acpi_amd_wbrf_supported_consumer(struct device *dev);
> +int amd_wbrf_retrieve_freq_band(struct device *dev, struct wbrf_ranges_in_out *out);
> +int amd_wbrf_register_notifier(struct notifier_block *nb);
> +int amd_wbrf_unregister_notifier(struct notifier_block *nb);
> +#else
> +static inline
> +bool acpi_amd_wbrf_supported_consumer(struct device *dev)
> +{
> +	return false;
> +}
> +static inline
> +int acpi_amd_wbrf_remove_exclusion(struct device *dev, struct wbrf_ranges_in_out *in)
> +{
> +	return -ENODEV;
> +}
> +static inline
> +int acpi_amd_wbrf_add_exclusion(struct device *dev, struct wbrf_ranges_in_out *in)
> +{
> +	return -ENODEV;
> +}
> +static inline
> +bool acpi_amd_wbrf_supported_producer(struct device *dev)
> +{
> +	return false;
> +}
> +static inline
> +int amd_wbrf_retrieve_freq_band(struct device *dev, struct wbrf_ranges_in_out *out)
> +{
> +	return -ENODEV;
> +}
> +static inline
> +int amd_wbrf_register_notifier(struct notifier_block *nb)
> +{
> +	return -ENODEV;
> +}
> +static inline
> +int amd_wbrf_unregister_notifier(struct notifier_block *nb)
> +{
> +	return -ENODEV;
> +}
> +#endif /* CONFIG_AMD_WBRF */
> +
> +#endif /* _ACPI_AMD_WBRF_H */

