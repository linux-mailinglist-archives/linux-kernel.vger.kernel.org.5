Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4104A779AD7
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 00:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236665AbjHKWwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 18:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbjHKWwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 18:52:46 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2142132;
        Fri, 11 Aug 2023 15:52:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TycMOu3TMp81q70nevmZ9jsb2qDMmzKuNCoT59OkR5XIGupLZL2lxEgQdB/elFmVlRXj3VNdb53iMa/cSxWawahtl/ZUnJqdwg82fFz9FdAoYSSUaw2iEFZKatUt6Is8ekN6n60cVmagELY1tqminQ/4MZOpFdnKx8deF7QAbBg+Fl1kB/V59GU7T2GGohu6ZGbnGfNPccATKxjr+XOKBN/Uu3xrET6EVKNhN+A9cW3YsaQWMvN11fltmWdSHcffS+e5PURh6OdNcG03JxtTK0zQOagzmVaezaZdGHSy/+yHDk3cJudEe0xQaXImWWqqEm/mwkSW/pTQQdbXMIPnGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i6ppZqFZb7isAK/kDcszG/wgFprpRBkrWYnkgAZ3hsc=;
 b=inmQB2F/csmCHge4HyXCbSiyxF5QbR2eTL2dIlfgJaR9dRYuvjdLfAwIi8N2O+hCLTem9/A5udCtb/EglgChcH3oiLGTjvSiQ3TrOLF3kQqbJXET6Nv1edh5ZYBK4Cpkkc6I84dggwyQ7Sy2KSuLU61YYw0EEEoYs+xicVB1vLiIZ9V9s/oaAKcWsIe/J64rggGPXoBjVeNuG7D61FbyEfYOBhw9qI6SZqMEPhmT/Y7OHdZRKdHuSp/BiSLQwLm8+trFPkQhB+ja8tkgQtfa+WxAx0Yrbk0tyg3qU2QJrOT/FR2YZYZvGGXl4QZhbWNcouW5SnRfugmKsp4ufYn8nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6ppZqFZb7isAK/kDcszG/wgFprpRBkrWYnkgAZ3hsc=;
 b=UtIZMDtgxDhml+XY3pMELQMN5SlxrZeSFhkR+I1lxARcNLy8reNElcSBCjm87TqZoi4vC18ri41OysfTZcXwmD4PY3zHBQrNW0chKWxk101Tqf7p6PffkoCIS18Xji8llww8lVCMzf3igO9KaWJkHzaiat+DLldmXhnKZovhtXI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6203.namprd12.prod.outlook.com (2603:10b6:930:24::17)
 by SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 22:52:42 +0000
Received: from CY5PR12MB6203.namprd12.prod.outlook.com
 ([fe80::48cb:8b61:d51e:3582]) by CY5PR12MB6203.namprd12.prod.outlook.com
 ([fe80::48cb:8b61:d51e:3582%7]) with mapi id 15.20.6678.020; Fri, 11 Aug 2023
 22:52:41 +0000
Message-ID: <a87e811b-b696-6dc8-3b2b-f6b4a9d9b650@amd.com>
Date:   Fri, 11 Aug 2023 17:52:38 -0500
User-Agent: Mozilla Thunderbird
Subject: [PATCH] ACPI: PHAT: Add Platform Health Assessment Table support
Content-Language: en-US
To:     rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org
Cc:     yazen.ghannam@amd.com, linux-kernel@vger.kernel.org,
        Avadhut Naik <avadhut.naik@amd.com>
References: <20230810234856.2580143-1-avadhut.naik@amd.com>
From:   Avadhut Naik <avadnaik@amd.com>
In-Reply-To: <20230810234856.2580143-1-avadhut.naik@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0177.namprd13.prod.outlook.com
 (2603:10b6:806:28::32) To CY5PR12MB6203.namprd12.prod.outlook.com
 (2603:10b6:930:24::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6203:EE_|SN7PR12MB8059:EE_
X-MS-Office365-Filtering-Correlation-Id: 059471b1-3c47-4c7a-34e8-08db9abdab1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ukxhBl8hAXWlHktwbSB41Ksbew8/qgFOrfzOukVy41Un1QNFycVpa2YNXfRGTWQL7DPiD0Gs1ZaAfMq5N4pykV8VnZvrgLhNDXz60psHyJe9SQoi8WlKT3bGoPFeRNFs5I5b44QZEd5csYTPW+otGMxW6cKLZ7ycY4koVfz5xVPrQbjpwb2zxyeGmgA1K6S/PzS1v2LUgwU2XamBdC3I3Zb2uQ9SVNK0gvw3r4azko1G7aVdxDfah3AMZkmhycKx2wpKPE3jVLmgYU627V05D6usn9VyoYFyxQx3iWR+nRZPOuBj7BETiTGhw5qswtm3zU/qcKrbpv2YNApA3D9Gddlsz3wRanvi6Ogwl6NGdXppjaCazQUs+VzFe1G1wrQcIuXTtEzSoX/PoRtqvMQjiNxRGorchlwU8+e9sDF9/cueCS+V0UyaLrhGnxIcmePq/e2GeOthdj867zBsYf4HMB7WQ6ZkFsmYnLrXGzGQGnEJaNHpv/wLugMqp9YDR7fBxEI9MSMKt+dmHMgPfjwuG6Aa5lkh/tZskXKYj6/WyhX0UQkVK0tUQMuJJYgv8ajlyWDhnkB1k0KITJX8Nn5wmm/hhBOZ2fCsVTY3v9dK7PUsdY+W8l4hECpXCq24Zw75XClcc1cSdhHIeTdmCfRrdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6203.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(39860400002)(346002)(366004)(1800799006)(451199021)(186006)(478600001)(83380400001)(2616005)(38100700002)(31696002)(2906002)(30864003)(6512007)(66946007)(4326008)(8936002)(6666004)(6486002)(41300700001)(8676002)(5660300002)(66556008)(31686004)(66476007)(316002)(26005)(36756003)(6506007)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWJMUkJvVzNkbE9QNVJUYkhvU1FwaEFJTDd5MlBpK1lMU0V4OVd4MGtZZUYw?=
 =?utf-8?B?SFZ6bHAzUlZMaVZ1VzVYY0xvS203MUNobHhEUkd4eTJvQWJneTBoanZvM1p6?=
 =?utf-8?B?cURLaDZaZFkvMDdOaE4zaGYxVjAvazZ2WXloVXZyUUtXSTF0M2dWaEJmcnRp?=
 =?utf-8?B?Q0Q3M3hPUERhd1k4QnpPOUNyVFMxTFh2Z2J0UFd3M1cyM3pMMWwwZW9naUZK?=
 =?utf-8?B?MjRjVGFHWVpoVndQcmJ6MXdPeG5hcHg5TVNsUTVpYUlBK0pUYk4yRHZtNVMz?=
 =?utf-8?B?ZUZjYm1YTFJyN2xGd0hUOEFLRXcwcTdMMUd1NHdCOHcyeVpoUzJUYW5LeHZE?=
 =?utf-8?B?T3RiQmY0bVNwaHpRaTJKKzdJRUovZ0IwMDRzWmhRVTFiUDBTN2VPa0Q4eDU3?=
 =?utf-8?B?dEdlRHlJU0J2Yk5seXo3NCtRUWVvUEpVeXdjUE9vay90V3NoYmRyQ2owRFdl?=
 =?utf-8?B?VEIzM1A5Wm5vUzhCZU5BVS9BWENjY0Q4L1I4bzRuTVE0b3NaSm5YR3poZ1RT?=
 =?utf-8?B?TEhSNzFPZU14bG5xb1BOTGYvS29YSnFYRGZFTjN4YlRBR3JNK0dMRTdrL2Jk?=
 =?utf-8?B?ZlJmY2RTV3RKaTFhbXduTzRLSTMxK3YwZlNPWmhndFNnSEFMWFAzUXN6eHBy?=
 =?utf-8?B?Zmg5OGFtNmRmUDdZVVUzOUpzMmVTY0FEbGd5ZkduNUF6cjMzOHlxZXBFazJJ?=
 =?utf-8?B?ODNOL0lKTnpoUkY1VHF3SzJXOGpiejZNdEFGMEYzTUtqWngyZFd2OWR0Z0Rh?=
 =?utf-8?B?eEFtdGpRZUwwcE5ORFFEV2RsYW0wZGFsNFFSQ0FJdXFkMHJHUFNTNmtxa21S?=
 =?utf-8?B?SklpdE9jQmd3TXdNSHJ4U1gwTW94UFJoTGZkQk52UFc3WG5EYkExenpBNXRO?=
 =?utf-8?B?ZlRGNmFMVTBmZ0ZsdFJ4ZDV5ZVJ1OGhoV0FRWGJ2cEtEdFc1VXBPNDhuL3cw?=
 =?utf-8?B?TlFvUFlhYXlqdkVqZmNIR2JTdm9MTkJJZlhTNWMybnhzc3BkZXRUUlNUUi9x?=
 =?utf-8?B?VnNVS2dDRHNvTGV6ODc0WWQ0VkhLMStkQVNjZXNWdUlSckZqT2pFY0MzRzQy?=
 =?utf-8?B?MVkyZ0czNWx0ME1NMDdtNHU2bzFaNGMwVUdHY0N3bUhLM3V0cjF0ZzVkbUZU?=
 =?utf-8?B?UFEybDltMnhjbzEwK293TGdIL0lIUGtiVWNFekV5RjlwVmRiakhTY3NxKzhu?=
 =?utf-8?B?bGg4eVc1ZlhDRHRySXhoUW9zK3BpSGNYSnIyclVYTjVUMVNHWHNtWEc3UW5L?=
 =?utf-8?B?NzZGd0Y3SGRNVlVzbmViVG5OY0tFc1hoOEZpQjk1Y1JqRzBqU1JHQ25VRTl3?=
 =?utf-8?B?bENlUHdiUW5BYktxNGZ1TkNLSzFhT3BpRVJNaFVMTWNSZEYrMzU5Rkt0RGU1?=
 =?utf-8?B?MGs4QTBXcTN3bnR5SkU5OVU2UmRmSVF3cHlHQ1NLaXpqNytQVVBxeS9aY3pr?=
 =?utf-8?B?NDg5TzNyVUY2ZU5xMlRPekgvTDJleXJ2dkJnWHE3NkdlMHFjTGNiL0h3Z3VL?=
 =?utf-8?B?eEZISm5SOFpnSTVNSTJ5TXVmeklxamhtZFg1K0dsOVIvNzRId2hLa002WmdU?=
 =?utf-8?B?QnZmR29qRWUyRVNhM0luVDNUNmhDQy9ZN0s3SGlFWDBRaWJHVTNBWlFxckEw?=
 =?utf-8?B?cFVadUJEd1F0dVJwQTNvLzlYSkJyV3piMGZxODVPMWpBd0Ezb1BuaW1XTzUz?=
 =?utf-8?B?dnJHMEFnclVLN2hWcDlxREZRbml2dmIvN1h3K1o1N29FR3A0SFZ0T0E3T1JI?=
 =?utf-8?B?UUJWd2hKcjhKL1lQUCtscFdJZlNwYzh6UU9Qc3ZiRkd4N2ZPUjZCR1JqeHA5?=
 =?utf-8?B?SkpjNDh5SFNwTGVWb3NqOURkbU5Hd2tIRHgzMUE2anRPRWd5eDdHUmNEYkJI?=
 =?utf-8?B?dWp2c1NBQ1B4dmtHZGR5T0lONDVxUVlhY3ljUGZKZzUxZmJOR3NuNlMybDUw?=
 =?utf-8?B?bVhwbkRBeGxpWDgrb0JCRHc0RzQ2SzFtdmdCWUtGSnZQQzNSUTJVVSs4YjBq?=
 =?utf-8?B?Q0MzM3BqMWxjdHZ5OEVKWWtMTzJBRVIwSzhKeG1kUHFOK1dvcFNnbjloUUhQ?=
 =?utf-8?B?bU1QdVlaNnRPUTdsbGphWXpVTHAvSDMrK0dLNUNJTnlPa1IrVWkzdXVMZXlO?=
 =?utf-8?Q?lYyA5qCUU4LA5mtoVSlu48y13?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 059471b1-3c47-4c7a-34e8-08db9abdab1c
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6203.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 22:52:41.5011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3dTacy+qlo1/q0wc6Z/MhQIRK5enwekOjy879z5WZc0dbVyQwI1U1ScLrtpsBcYePybGe/cFf4LWm3cBAyyFJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8059
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/10/2023 18:48, Avadhut Naik wrote:
> ACPI Platform Health Assessment Table (PHAT) enables a platform to expose
> an extensible set of platform health related telemetry. The telemetry is
> exposed through Firmware Version and Firmware Health Data Records which
> provide version data and health-related information of their associated
> components respectively.
> 
> Additionally, the platform also provides Reset Reason Health Record in
> the PHAT table highlighting the cause of last system reset or boot in case
> of both expected and unexpected events. Vendor-specific data capturing the
> underlying state of the system during reset can also be optionally provided
> through the record.[1]
> 
> Add support to parse the PHAT table during system bootup and have its
> information logged into the dmesg buffer.
> 
> [1] ACPI specification 6.5, section 5.2.31.5
> 
> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |   4 +
>  drivers/acpi/Kconfig                          |   9 +
>  drivers/acpi/Makefile                         |   1 +
>  drivers/acpi/phat.c                           | 270 ++++++++++++++++++
>  include/acpi/actbl2.h                         |  18 ++
>  5 files changed, 302 insertions(+)
>  create mode 100644 drivers/acpi/phat.c
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 722b6eca2e93..33b932302ece 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4490,6 +4490,10 @@
>  			allocator.  This parameter is primarily	for debugging
>  			and performance comparison.
>  
> +	phat_disable=	[ACPI]
	Slight Correction: This should just be "phat_disable".
Will handle this in the next revision along with the feedback
that may be provided for this patch.
> +			Disable PHAT table parsing and logging of Firmware
> +			Version and Health Data records.
> +
>  	pirq=		[SMP,APIC] Manual mp-table setup
>  			See Documentation/arch/x86/i386/IO-APIC.rst.
>  
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 00dd309b6682..06a7dd6e5a40 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -96,6 +96,15 @@ config ACPI_FPDT
>  	  This table provides information on the timing of the system
>  	  boot, S3 suspend and S3 resume firmware code paths.
>  
> +config ACPI_PHAT
> +	bool "ACPI Platform Health Assessment Table (PHAT) support"
> +	depends on X86_64 || ARM64
> +	help
> +	  Enable support for Platform Health Assessment Table (PHAT).
> +	  This table exposes an extensible set of platform health
> +	  related telemetry through Firmware Version and Firmware Health
> +	  Data Records.
> +
>  config ACPI_LPIT
>  	bool
>  	depends on X86_64
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index 3fc5a0d54f6e..93a4ec57ba6d 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -69,6 +69,7 @@ acpi-$(CONFIG_ACPI_WATCHDOG)	+= acpi_watchdog.o
>  acpi-$(CONFIG_ACPI_PRMT)	+= prmt.o
>  acpi-$(CONFIG_ACPI_PCC)		+= acpi_pcc.o
>  acpi-$(CONFIG_ACPI_FFH)		+= acpi_ffh.o
> +acpi-$(CONFIG_ACPI_PHAT)	+= phat.o
>  
>  # Address translation
>  acpi-$(CONFIG_ACPI_ADXL)	+= acpi_adxl.o
> diff --git a/drivers/acpi/phat.c b/drivers/acpi/phat.c
> new file mode 100644
> index 000000000000..6006dd7615fa
> --- /dev/null
> +++ b/drivers/acpi/phat.c
> @@ -0,0 +1,270 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Platform Health Assessment Table (PHAT) support
> + *
> + * Copyright (C) 2023 Advanced Micro Devices, Inc.
> + *
> + * Author: Avadhut Naik <avadhut.naik@amd.com>
> + *
> + * This file implements parsing of the Platform Health Assessment Table
> + * through which a platform can expose an extensible set of platform
> + * health related telemetry. The telemetry is exposed through Firmware
> + * Version Data Records and Firmware Health Data Records. Additionally,
> + * a platform, through system firmware, also exposes Reset Reason Health
> + * Record to inform the operating system of the cause of last system
> + * reset or boot.
> + *
> + * For more information on PHAT, please refer to ACPI specification
> + * version 6.5, section 5.2.31
> + */
> +
> +#include <linux/acpi.h>
> +
> +static int phat_disable __initdata;
> +static const char *prefix = "ACPI PHAT: ";
> +
> +/* Reset Reason Health Record GUID */
> +static const guid_t reset_guid =
> +	GUID_INIT(0x7a014ce2, 0xf263, 0x4b77,
> +		  0xb8, 0x8a, 0xe6, 0x33, 0x6b, 0x78, 0x2c, 0x14);
> +
> +static struct { u8 mask; const char *str; } const reset_sources[] = {
> +	{BIT(0), "Unknown source"},
> +	{BIT(1), "Hardware Source"},
> +	{BIT(2), "Firmware Source"},
> +	{BIT(3), "Software initiated reset"},
> +	{BIT(4), "Supervisor initiated reset"},
> +};
> +
> +static struct { u8 val; const char *str; } const reset_reasons[] = {
> +	{0, "UNKNOWN"},
> +	{1, "COLD BOOT"},
> +	{2, "COLD RESET"},
> +	{3, "WARM RESET"},
> +	{4, "UPDATE"},
> +	{32, "UNEXPECTED RESET"},
> +	{33, "FAULT"},
> +	{34, "TIMEOUT"},
> +	{35, "THERMAL"},
> +	{36, "POWER LOSS"},
> +	{37, "POWER BUTTON"},
> +};
> +
> +/*
> + * Print the last PHAT Version Element associated with a Firmware
> + * Version Data Record.
> + * Firmware Version Data Record consists of an array of PHAT Version
> + * Elements with each entry in the array representing a modification
> + * undertaken on a given platform component.
> + * In the event the array has multiple entries, minimize logs on the
> + * console and print only the last version element since it denotes
> + * the currently running instance of the component.
> + */
> +static int phat_version_data_parse(const char *pfx,
> +				   struct acpi_phat_version_data *version)
> +{
> +	char newpfx[64];
> +	u32 num_elems = version->element_count - 1;
> +	struct acpi_phat_version_element *element;
> +	int offset = sizeof(struct acpi_phat_version_data);
> +
> +	if (!version->element_count) {
> +		pr_info("%sNo PHAT Version Elements found.\n", prefix);
> +		return 0;
> +	}
> +
> +	offset += num_elems * sizeof(struct acpi_phat_version_element);
> +	element = (void *)version + offset;
> +
> +	pr_info("%sPHAT Version Element:\n", pfx);
> +	snprintf(newpfx, sizeof(newpfx), "%s ", pfx);
> +	pr_info("%sComponent ID: %pUl\n", newpfx, element->guid);
> +	pr_info("%sVersion: 0x%llx\n", newpfx, element->version_value);
> +	snprintf(newpfx, sizeof(newpfx), KERN_INFO "%s ", pfx);
> +	print_hex_dump(newpfx, "Producer ID: ", DUMP_PREFIX_NONE, 16, 4,
> +		       &element->producer_id, sizeof(element->producer_id), true);
> +
> +	return 0;
> +}
> +
> +/*
> + * Print the Reset Reason Health Record
> + */
> +static int phat_reset_reason_parse(const char *pfx,
> +				   struct acpi_phat_health_data *record)
> +{
> +	int idx;
> +	void *data;
> +	u32 data_len;
> +	char newpfx[64];
> +	struct acpi_phat_reset_reason *rr;
> +	struct acpi_phat_vendor_reset_data *vdata;
> +
> +	rr = (void *)record + record->device_specific_offset;
> +
> +	for (idx = 0; idx < ARRAY_SIZE(reset_sources); idx++) {
> +		if (!rr->reset_source) {
> +			pr_info("%sUnknown Reset Source.\n", pfx);
> +			break;
> +		}
> +		if (rr->reset_source & reset_sources[idx].mask) {
> +			pr_info("%sReset Source: 0x%x\t%s\n", pfx, reset_sources[idx].mask,
> +				reset_sources[idx].str);
> +			/* According to ACPI v6.5 Table 5.168, Sub-Source is
> +			 * defined only for Software initiated reset.
> +			 */
> +			if (idx == 0x3 && rr->reset_sub_source)
> +				pr_info("%sReset Sub-Source: %s\n", pfx,
> +					rr->reset_sub_source == 0x1 ?
> +					"Operating System" : "Hypervisor");
> +			break;
> +		}
> +	}
> +
> +	for (idx = 0; idx < ARRAY_SIZE(reset_reasons); idx++) {
> +		if (rr->reset_reason == reset_reasons[idx].val) {
> +			pr_info("%sReset Reason: 0x%x\t%s\n", pfx, reset_reasons[idx].val,
> +				reset_reasons[idx].str);
> +			break;
> +		}
> +	}
> +
> +	if (!rr->vendor_count)
> +		return 0;
> +
> +	pr_info("%sReset Reason Vendor Data:\n", pfx);
> +	vdata = (void *)rr + sizeof(*rr);
> +
> +	for (idx = 0; idx < rr->vendor_count; idx++) {
> +		snprintf(newpfx, sizeof(newpfx), "%s ", pfx);
> +		data_len = vdata->length - sizeof(*vdata);
> +		data = (void *)vdata + sizeof(*vdata);
> +		pr_info("%sVendor Data ID: %pUl\n", newpfx, vdata->vendor_id);
> +		pr_info("%sRevision: 0x%x\n", newpfx, vdata->revision);
> +		snprintf(newpfx, sizeof(newpfx), KERN_INFO "%s ", pfx);
> +		print_hex_dump(newpfx, "Data: ", DUMP_PREFIX_NONE, 16, 4,
> +			       data, data_len, false);
> +		vdata = (void *)vdata + vdata->length;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Print the Firmware Health Data Record.
> + */
> +static int phat_health_data_parse(const char *pfx,
> +				  struct acpi_phat_health_data *record)
> +{
> +	void *data;
> +	u32 data_len;
> +	char newpfx[64];
> +
> +	pr_info("%sHealth Records.\n", pfx);
> +	snprintf(newpfx, sizeof(newpfx), "%s ", pfx);
> +	pr_info("%sDevice Signature: %pUl\n", newpfx, record->device_guid);
> +
> +	switch (record->health) {
> +	case ACPI_PHAT_ERRORS_FOUND:
> +		pr_info("%sAmHealthy: Errors found\n", newpfx);
> +		break;
> +	case ACPI_PHAT_NO_ERRORS:
> +		pr_info("%sAmHealthy: No errors found.\n", newpfx);
> +		break;
> +	case ACPI_PHAT_UNKNOWN_ERRORS:
> +		pr_info("%sAmHealthy: Unknown.\n", newpfx);
> +		break;
> +	case ACPI_PHAT_ADVISORY:
> +		pr_info("%sAmHealthy: Advisory – additional device-specific data exposed.\n",
> +			newpfx);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	if (!record->device_specific_offset)
> +		return 0;
> +
> +	/* Reset Reason Health Record has a unique GUID and is created as
> +	 * a Health Record in the PHAT table. Check if this Health Record
> +	 * is a Reset Reason Health Record.
> +	 */
> +	if (guid_equal((guid_t *)record->device_guid, &reset_guid)) {
> +		phat_reset_reason_parse(newpfx, record);
> +		return 0;
> +	}
> +
> +	data = (void *)record + record->device_specific_offset;
> +	data_len = record->header.length - record->device_specific_offset;
> +	snprintf(newpfx, sizeof(newpfx), KERN_INFO "%s ", pfx);
> +	print_hex_dump(newpfx, "Device Data: ", DUMP_PREFIX_NONE, 16, 4,
> +		       data, data_len, false);
> +
> +	return 0;
> +}
> +
> +static int parse_phat_table(const char *pfx, struct acpi_table_phat *phat_tab)
> +{
> +	char newpfx[64];
> +	u32 offset = sizeof(*phat_tab);
> +	struct acpi_phat_header *phat_header;
> +
> +	snprintf(newpfx, sizeof(newpfx), "%s ", pfx);
> +
> +	while (offset < phat_tab->header.length) {
> +		phat_header = (void *)phat_tab + offset;
> +		switch (phat_header->type) {
> +		case ACPI_PHAT_TYPE_FW_VERSION_DATA:
> +			phat_version_data_parse(newpfx, (struct acpi_phat_version_data *)
> +			    phat_header);
> +			break;
> +		case ACPI_PHAT_TYPE_FW_HEALTH_DATA:
> +			phat_health_data_parse(newpfx, (struct acpi_phat_health_data *)
> +			    phat_header);
> +			break;
> +		default:
> +			break;
> +		}
> +		offset += phat_header->length;
> +	}
> +	return 0;
> +}
> +
> +static int __init setup_phat_disable(char *str)
> +{
> +	phat_disable = 1;
> +	return 1;
> +}
> +__setup("phat_disable", setup_phat_disable);
> +
> +static int __init acpi_phat_init(void)
> +{
> +	acpi_status status;
> +	struct acpi_table_phat *phat_tab;
> +
> +	if (acpi_disabled)
> +		return 0;
> +
> +	if (phat_disable) {
> +		pr_err("%sPHAT support has been disabled.\n", prefix);
> +		return 0;
> +	}
> +
> +	status = acpi_get_table(ACPI_SIG_PHAT, 0,
> +				(struct acpi_table_header **)&phat_tab);
> +
> +	if (status == AE_NOT_FOUND) {
> +		pr_info("%sPHAT Table not found.\n", prefix);
> +		return 0;
> +	} else if (ACPI_FAILURE(status)) {
> +		pr_err("%sFailed to get PHAT Table: %s.\n", prefix,
> +		       acpi_format_exception(status));
> +		return -EINVAL;
> +	}
> +
> +	pr_info("%sPlatform Telemetry Records.\n", prefix);
> +	parse_phat_table(prefix, phat_tab);
> +
> +	return 0;
> +}
> +late_initcall(acpi_phat_init);
> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
> index 0029336775a9..c263893cbc7f 100644
> --- a/include/acpi/actbl2.h
> +++ b/include/acpi/actbl2.h
> @@ -2360,6 +2360,24 @@ struct acpi_phat_health_data {
>  #define ACPI_PHAT_UNKNOWN_ERRORS        2
>  #define ACPI_PHAT_ADVISORY              3
>  
> +/* Reset Reason Health Record Structure */
> +
> +struct acpi_phat_reset_reason {
> +	u8 supported_reset_sources;
> +	u8 reset_source;
> +	u8 reset_sub_source;
> +	u8 reset_reason;
> +	u16 vendor_count;
> +};
> +
> +/* Reset Reason Health Record Vendor Data Entry */
> +
> +struct acpi_phat_vendor_reset_data {
> +	u8 vendor_id[16];
> +	u16 length;
> +	u16 revision;
> +};
> +
>  /*******************************************************************************
>   *
>   * PMTT - Platform Memory Topology Table (ACPI 5.0)

-- 
Thanks,
Avadhut Naik
