Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322F477FF3A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 22:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354979AbjHQUnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 16:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355038AbjHQUnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 16:43:10 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9D63A8E;
        Thu, 17 Aug 2023 13:42:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Do4vDq60N+jI8Gt/p4Sg4TDaiqGIvAmyC4hhFT3zeo8b3hVywbIioChxPrAnplUTGcNOgbV9ORLObl9Q3EMzKD03Qpsz7OmoItQpHP5vqgRtVXpIKerG42X3+DTLuCkrEgw9/fjOdpmAOmXr+Mlp567w3JfbANLmcNzYzk1i2fwzfF2WbmpaYADPoAkYWGBfv7EITx8urcAFzqpaxf474d7jLwvUbT0k7vMFD5Wbp5OmEdh1AtaLjmwDiIZBTrbiSuUKmLqd9yj6owOMb0dmYyaqmrCvAJhqayJN6F2oH1HsUsiN0Hzd45++5nYA5U2RAQURwx8h6lZmBbfalXfI1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7nNCleVjVPKdpXILzJwKsIjb6KIFAGHQg2wUwWhioI4=;
 b=Gn365aoZLoduYX0+ZC8YFewIeIM3C1MKBPlbi+ybk5egjeO0VLxV6N9eGOIJ6fdR9w7/c4NmylkgOsVmb0waspAth11lnRypxypntE7Eu/Cqgh8fLGnMLCQJDAYmALilncqMqODLXhbPrZ5+1xcRtYt0GF1vW5rxOk+2AjTdZMeKUc0zZz0WRUtWaEUG1lcEMhiwTqJLEkLUOuVrcRKperu2HHaywJAzA0K6cfObnG0lHmfeH0LharrqwSk21OVv/jWkzeet/4huRaqvRoBjKDqV3M36TjoT6UjIuSb4hJMPdQG6brdv4R7douxFq0Upa7PSmzfixvLJrA7cBUQ+tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7nNCleVjVPKdpXILzJwKsIjb6KIFAGHQg2wUwWhioI4=;
 b=kIRYsotEOIKaK27ppwg2UcFz/GARGPkNRasrFz/BC0t9H4HfNrAsF6igkLzH+l6njEErQPvKwBZ9m+5qfZyGqdlqMU41jhTLuQG5Dv5jQ75owBe5DCQwITB3x3e2o+l964fERqvFfHD5glNa5+WOtwE93G+qYM0VBCxd2ypAikA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6203.namprd12.prod.outlook.com (2603:10b6:930:24::17)
 by MW4PR12MB5644.namprd12.prod.outlook.com (2603:10b6:303:189::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 20:42:55 +0000
Received: from CY5PR12MB6203.namprd12.prod.outlook.com
 ([fe80::48cb:8b61:d51e:3582]) by CY5PR12MB6203.namprd12.prod.outlook.com
 ([fe80::48cb:8b61:d51e:3582%7]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 20:42:55 +0000
Message-ID: <655c916e-356c-03e3-6c67-aa40886dd5e2@amd.com>
Date:   Thu, 17 Aug 2023 15:42:52 -0500
User-Agent: Mozilla Thunderbird
Subject: [PATCH] ACPI: PHAT: Add Platform Health Assessment Table support
Content-Language: en-US
To:     "Wilczynski, Michal" <michal.wilczynski@intel.com>,
        Avadhut Naik <avadhut.naik@amd.com>, rafael@kernel.org,
        lenb@kernel.org, linux-acpi@vger.kernel.org
Cc:     yazen.ghannam@amd.com, linux-kernel@vger.kernel.org
References: <20230810234856.2580143-1-avadhut.naik@amd.com>
 <a0ab4d07-fb73-418b-b88d-c3ad6aa4cf49@intel.com>
From:   Avadhut Naik <avadnaik@amd.com>
In-Reply-To: <a0ab4d07-fb73-418b-b88d-c3ad6aa4cf49@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0190.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::27) To CY5PR12MB6203.namprd12.prod.outlook.com
 (2603:10b6:930:24::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6203:EE_|MW4PR12MB5644:EE_
X-MS-Office365-Filtering-Correlation-Id: c4b28194-4751-4d34-422e-08db9f62887e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XLhz8vkwlVrX7gBtSBI63Dq4ke4Ux+zSywRsBAZMYsecrgpeyPwBxK2gsRdSct0xA6elsvM4qC9stu9EYRpqGFvetF0exur8+13cburHdtT3nFxhcVLGuynkuYeyYtIAhBcSf7HkZ+vFXE59wAuOfSq/L76jzjkoFkaOoYPtZdQWzMvfssBuZC5AuoqqPS/gU3luMfC7BNGDhff4ny0leiadFyja2xsV9kYwfA9h0KjmD1jas35pYIudSkF6MJS33M9qlnfL4i0VmzGZZN1RW0iSWPOBXxoLkMqTMPrKw0uW3IIHDpOA14Puvnib8MwasjkxHEFu0kQjU1T6Be8eGqWWZm/oYkEUOz1WjlVBYwKLrmhFuugPw8EqziPCWsxRgx0hNRa/ikSFxS2Mo2p0M87EoISe+F/ug9XVfU9TWrK/RbeD+sr09NdrH3P+2UOAHh/EQRMK0v/aneeqp0BCMUBVSoNSNsmP9txCZod/MyWnVDZd7cubhsBtO8KIrCvqA9vSG+XLOVYWPuFl/Z4QXfRfsgIyj/PMdCmAYFjL/HiGWksse0GpIz98I/7Vu4h3tf/x+3YwQv2WRXkKrO9jmNXiOcsFj/BROO+EYc2AM+9Xd6XeG2nMWo0GsKCalVfxqVSthv+KvnKFTG1XnBM2aw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6203.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199024)(186009)(1800799009)(36756003)(31696002)(31686004)(83380400001)(30864003)(8936002)(5660300002)(8676002)(4326008)(2906002)(41300700001)(26005)(6666004)(6506007)(53546011)(2616005)(6512007)(6486002)(478600001)(66476007)(38100700002)(316002)(110136005)(66946007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnlrdFA1OVdXZGw5R3VxRGRUOC9xWmcvUjBDQjdURExIVGRmaFRiblB1NUpu?=
 =?utf-8?B?eTlJc2laUDBNbk42U0ZzSFlrajJ3ZlY2emZ2UWlMdXJyQmFNa3V1UHNCRWtM?=
 =?utf-8?B?ZU5IOFQzdDJxMlFmQThtMDhmQlh2NnZMZ3I2VUdKL2oxanViUFFaUUt2Uldy?=
 =?utf-8?B?NVM0dDdOM0xjTU83aytKT2JmbWN3UnJUQUxhMUxkb3dqblFwU1lCOTlNc0pD?=
 =?utf-8?B?TDNGTHQ3QUFTNmNVQTVudDdZMk5SYmVNdldJbXp6aTFBRG5KM1BPSGIyQkFi?=
 =?utf-8?B?djRxTzZNYzFURVI1Y2xmL2Q3SldNa08xeDYxdk4wWlMwYWhvcHJMZWhQbXJh?=
 =?utf-8?B?R0xuU0JFMzZMeGw2UVBHYnA1eFBXK2NHWnRTWEsyUXQwdmV5dFVZalZpSUdE?=
 =?utf-8?B?K1RYU3dPbHp2Y0gzYmhZNmhtcGE3SWl4L1JPdHQ5YTk0TkptdzhHNWlsSmIx?=
 =?utf-8?B?VWJJVmcwVFR2MEVMSzYwRnhSZ1ZER05aZzRFTDdiOSsybWx0T1BkT2U1Sk5x?=
 =?utf-8?B?U1RWb082d1ZjTitxTWdqeDNWQ296ejVWMm5ienFnZTRCeGpnclpKS2xVZktO?=
 =?utf-8?B?Qmc5UmZ3T0FPa0hJeGhWSG1mWXgrd1k0RUFoK08wNUoxSmJkQnVUa0lGcnZz?=
 =?utf-8?B?SlBRTVl6c3ZtOVlucW5SekNqL1lyR1pKWTBxU3JlRnkwZHE4U2lycEZ6c1VD?=
 =?utf-8?B?WmZWbnlnZ2dBb1BMZGNLeVhtNTlXODFadWlxVUE5ZUVodjhkK2VReXR6OC9R?=
 =?utf-8?B?cFNqK09GMzlwMzR1cGJiRmZaTm0rUUVjZ0l2RjZ4YUsxYmx3NjF6WnJNczJU?=
 =?utf-8?B?Slo0OUJCbDNjZlkyNVZ6WUtVQXJMUCtUV1paS2RPZGp2allzRmZIUjBHdXZ5?=
 =?utf-8?B?NzNyWjRmcUtTU3pKb0pZdkR1UEVBbjNPQk9IekloNUlOYzExOC9nV3hVUWVs?=
 =?utf-8?B?UlFqWnpTcU9RYUlhTXZaVUhrVTVxRlVnSHYwOEwyVFFML1B5SC9QbmtKWUpK?=
 =?utf-8?B?UVJDUEJtbVRMVUJlK1FhdFFpdFpaakRubElsNEJ4bXQyQksrTjI3ZmV3Tnl3?=
 =?utf-8?B?OEZxMUM1dGdaY1dmYWl3OVJ3MythdmNYWWJILzhjanhvRXBoNU5oUWNyNHJD?=
 =?utf-8?B?RmxrTHhpNEVCVGkvTHBqSGdxK2JpN0hWelpYeWh5K2hLWStjTXROT09yM3dI?=
 =?utf-8?B?ZmRCS2Qrc1IrMHN6NHhMR3dpbkFuc2RBdDlmVVpTZGQ2dkhJMHBGVGJzS1VW?=
 =?utf-8?B?aEdGdGovM3owdmdtVE1wdTZoYUljR3RYMmI2eEhDcUN2UWZUQmhDaEM5UGVY?=
 =?utf-8?B?OVZCMEpNNmxaTDZVSjRRK1ZtNTJ0eHFHc0Zhc2wxU2ZwamhxTFoyN1lrODBR?=
 =?utf-8?B?aGtwNUN6OFpnMVp5bXVsRWFKa2pWaDNrTHFmNGxmalJPYXJJUHBoQmJsRkhM?=
 =?utf-8?B?RUVzbFdrTVpuMlpDQ1pxUHFnaDRQVUovMFlOd0FkazVHRkVoejNsZXViSjZX?=
 =?utf-8?B?d0UzdGx0cDZrNGhDSU1ZOXpUYUl1dTBlbmtHQXpxaDNqbjZkeWxHRkFtL0Jx?=
 =?utf-8?B?Mkc5cU9qdzZDZk14cnhxQllWdGZnemJKTDdpMTJUMU1DNlpESXFaM3JhSEZD?=
 =?utf-8?B?U0FHa2tHZG45eGV0UlV3UHNxekZyOVBNS0RCV3dGdlpSMmxvNWtPa3JxSFJK?=
 =?utf-8?B?cmtxMndxZGc4bU0wWW9OeGswcDdCYXBQVW5iTTJyd3VWbGFlSE9pSzhZNURm?=
 =?utf-8?B?U29DRWdoQnlhaHBWT3RscmxLcXRoeEhwYlJOYkdncHZGRlJVcExLNGsrRVg1?=
 =?utf-8?B?L1EvM1Nza3BMMDUwSTREd3g5MnVQbC9OL051MVdFVnhucWt3Z3B2YzFHYURX?=
 =?utf-8?B?akdJVjM4cE5ON0JidmtxVFlDV3M2VlROZTU5cWZqMHkxV2t2cU1TZ3IzZTRU?=
 =?utf-8?B?am5JOW1RWlZsa1IyclpSLzB5Y3psdGpsQUJZZHczSDNlNEg3TDhRZ0xib2lw?=
 =?utf-8?B?UjdTYmNsc3gySDZMOEhaTlJNdlJXZk0zZFU2VlRPaDVXYUtsKzlpdnYyWHNo?=
 =?utf-8?B?bS85RXUwZHJGUkpkTE1ONStJVjZwUWpmMEJIaFl0b1k5aDd0dGg5aUE2Q3p4?=
 =?utf-8?Q?sRDgYJ1voro4KHINo4RYKVTM1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4b28194-4751-4d34-422e-08db9f62887e
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6203.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 20:42:55.1218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EfFMZH19nvWHI1hc62Qn7VREWxlUGkC052hMJdP3P+1YBDa74Gtokkbx3wi84n+0iDuP4HzOx0+CgXaVlSSeUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5644
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/16/2023 06:35, Wilczynski, Michal wrote:
> Hi,
> 
> On 8/11/2023 1:48 AM, Avadhut Naik wrote:
>> ACPI Platform Health Assessment Table (PHAT) enables a platform to expose
>> an extensible set of platform health related telemetry. The telemetry is
>> exposed through Firmware Version and Firmware Health Data Records which
>> provide version data and health-related information of their associated
>> components respectively.
>>
>> Additionally, the platform also provides Reset Reason Health Record in
>> the PHAT table highlighting the cause of last system reset or boot in case
>> of both expected and unexpected events. Vendor-specific data capturing the
>> underlying state of the system during reset can also be optionally provided
>> through the record.[1]
>>
>> Add support to parse the PHAT table during system bootup and have its
>> information logged into the dmesg buffer.
>>
>> [1] ACPI specification 6.5, section 5.2.31.5
>>
>> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
>> ---
>>  .../admin-guide/kernel-parameters.txt         |   4 +
>>  drivers/acpi/Kconfig                          |   9 +
>>  drivers/acpi/Makefile                         |   1 +
>>  drivers/acpi/phat.c                           | 270 ++++++++++++++++++
>>  include/acpi/actbl2.h                         |  18 ++
>>  5 files changed, 302 insertions(+)
>>  create mode 100644 drivers/acpi/phat.c
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 722b6eca2e93..33b932302ece 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -4490,6 +4490,10 @@
>>  			allocator.  This parameter is primarily	for debugging
>>  			and performance comparison.
>>  
>> +	phat_disable=	[ACPI]
>> +			Disable PHAT table parsing and logging of Firmware
>> +			Version and Health Data records.
>> +
>>  	pirq=		[SMP,APIC] Manual mp-table setup
>>  			See Documentation/arch/x86/i386/IO-APIC.rst.
>>  
>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>> index 00dd309b6682..06a7dd6e5a40 100644
>> --- a/drivers/acpi/Kconfig
>> +++ b/drivers/acpi/Kconfig
>> @@ -96,6 +96,15 @@ config ACPI_FPDT
>>  	  This table provides information on the timing of the system
>>  	  boot, S3 suspend and S3 resume firmware code paths.
>>  
>> +config ACPI_PHAT
>> +	bool "ACPI Platform Health Assessment Table (PHAT) support"
>> +	depends on X86_64 || ARM64
>> +	help
>> +	  Enable support for Platform Health Assessment Table (PHAT).
>> +	  This table exposes an extensible set of platform health
>> +	  related telemetry through Firmware Version and Firmware Health
>> +	  Data Records.
>> +
>>  config ACPI_LPIT
>>  	bool
>>  	depends on X86_64
>> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
>> index 3fc5a0d54f6e..93a4ec57ba6d 100644
>> --- a/drivers/acpi/Makefile
>> +++ b/drivers/acpi/Makefile
>> @@ -69,6 +69,7 @@ acpi-$(CONFIG_ACPI_WATCHDOG)	+= acpi_watchdog.o
>>  acpi-$(CONFIG_ACPI_PRMT)	+= prmt.o
>>  acpi-$(CONFIG_ACPI_PCC)		+= acpi_pcc.o
>>  acpi-$(CONFIG_ACPI_FFH)		+= acpi_ffh.o
>> +acpi-$(CONFIG_ACPI_PHAT)	+= phat.o
>>  
>>  # Address translation
>>  acpi-$(CONFIG_ACPI_ADXL)	+= acpi_adxl.o
>> diff --git a/drivers/acpi/phat.c b/drivers/acpi/phat.c
>> new file mode 100644
>> index 000000000000..6006dd7615fa
>> --- /dev/null
>> +++ b/drivers/acpi/phat.c
>> @@ -0,0 +1,270 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Platform Health Assessment Table (PHAT) support
>> + *
>> + * Copyright (C) 2023 Advanced Micro Devices, Inc.
>> + *
>> + * Author: Avadhut Naik <avadhut.naik@amd.com>
>> + *
>> + * This file implements parsing of the Platform Health Assessment Table
>> + * through which a platform can expose an extensible set of platform
>> + * health related telemetry. The telemetry is exposed through Firmware
>> + * Version Data Records and Firmware Health Data Records. Additionally,
>> + * a platform, through system firmware, also exposes Reset Reason Health
>> + * Record to inform the operating system of the cause of last system
>> + * reset or boot.
>> + *
>> + * For more information on PHAT, please refer to ACPI specification
>> + * version 6.5, section 5.2.31
>> + */
>> +
>> +#include <linux/acpi.h>
>> +
>> +static int phat_disable __initdata;
>> +static const char *prefix = "ACPI PHAT: ";
> 
> Wouldn't it be better if you used pr_fmt macro instead ?
> 
	Have explained below.
>> +
>> +/* Reset Reason Health Record GUID */
>> +static const guid_t reset_guid =
>> +	GUID_INIT(0x7a014ce2, 0xf263, 0x4b77,
>> +		  0xb8, 0x8a, 0xe6, 0x33, 0x6b, 0x78, 0x2c, 0x14);
>> +
>> +static struct { u8 mask; const char *str; } const reset_sources[] = {
>> +	{BIT(0), "Unknown source"},
>> +	{BIT(1), "Hardware Source"},
>> +	{BIT(2), "Firmware Source"},
>> +	{BIT(3), "Software initiated reset"},
>> +	{BIT(4), "Supervisor initiated reset"},
>> +};
>> +
>> +static struct { u8 val; const char *str; } const reset_reasons[] = {
>> +	{0, "UNKNOWN"},
>> +	{1, "COLD BOOT"},
>> +	{2, "COLD RESET"},
>> +	{3, "WARM RESET"},
>> +	{4, "UPDATE"},
>> +	{32, "UNEXPECTED RESET"},
>> +	{33, "FAULT"},
>> +	{34, "TIMEOUT"},
>> +	{35, "THERMAL"},
>> +	{36, "POWER LOSS"},
>> +	{37, "POWER BUTTON"},
>> +};
>> +
>> +/*
>> + * Print the last PHAT Version Element associated with a Firmware
>> + * Version Data Record.
>> + * Firmware Version Data Record consists of an array of PHAT Version
>> + * Elements with each entry in the array representing a modification
>> + * undertaken on a given platform component.
>> + * In the event the array has multiple entries, minimize logs on the
>> + * console and print only the last version element since it denotes
>> + * the currently running instance of the component.
>> + */
>> +static int phat_version_data_parse(const char *pfx,
>> +				   struct acpi_phat_version_data *version)
>> +{
>> +	char newpfx[64];
>> +	u32 num_elems = version->element_count - 1;
>> +	struct acpi_phat_version_element *element;
>> +	int offset = sizeof(struct acpi_phat_version_data);
>> +
>> +	if (!version->element_count) {
>> +		pr_info("%sNo PHAT Version Elements found.\n", prefix);
>> +		return 0;
>> +	}
>> +
>> +	offset += num_elems * sizeof(struct acpi_phat_version_element);
>> +	element = (void *)version + offset;
>> +
>> +	pr_info("%sPHAT Version Element:\n", pfx);
>> +	snprintf(newpfx, sizeof(newpfx), "%s ", pfx);
>> +	pr_info("%sComponent ID: %pUl\n", newpfx, element->guid);
>> +	pr_info("%sVersion: 0x%llx\n", newpfx, element->version_value);
>> +	snprintf(newpfx, sizeof(newpfx), KERN_INFO "%s ", pfx);
>> +	print_hex_dump(newpfx, "Producer ID: ", DUMP_PREFIX_NONE, 16, 4,
>> +		       &element->producer_id, sizeof(element->producer_id), true);
> 
> I do have to admit that all this dancing with pfx and newpfx confuses me. Couldn't you
> just use pr_fmt for everything printed using pr_* family of functions ? print_hex_dump()
> is not impacted by pr_fmt, as it just uses printk to do it's printing.
> 
I had considered using pr_fmt initially but since the ACPI spec says that PHAT health records,
especially reset reason health record is intended to complement existing fault reporting
mechanisms like BERT Tables, CPER, decided to have their outputs in identical formats, like has
been implemented in cper_estatus_print().

>> +
>> +	return 0;
>> +}
>> +
>> +/*
>> + * Print the Reset Reason Health Record
>> + */
>> +static int phat_reset_reason_parse(const char *pfx,
>> +				   struct acpi_phat_health_data *record)
>> +{
>> +	int idx;
>> +	void *data;
>> +	u32 data_len;
>> +	char newpfx[64];
>> +	struct acpi_phat_reset_reason *rr;
>> +	struct acpi_phat_vendor_reset_data *vdata;
>> +
>> +	rr = (void *)record + record->device_specific_offset;
>> +
>> +	for (idx = 0; idx < ARRAY_SIZE(reset_sources); idx++) {
>> +		if (!rr->reset_source) {
>> +			pr_info("%sUnknown Reset Source.\n", pfx);
>> +			break;
>> +		}
>> +		if (rr->reset_source & reset_sources[idx].mask) {
>> +			pr_info("%sReset Source: 0x%x\t%s\n", pfx, reset_sources[idx].mask,
>> +				reset_sources[idx].str);
>> +			/* According to ACPI v6.5 Table 5.168, Sub-Source is
>> +			 * defined only for Software initiated reset.
>> +			 */
>> +			if (idx == 0x3 && rr->reset_sub_source)
>> +				pr_info("%sReset Sub-Source: %s\n", pfx,
>> +					rr->reset_sub_source == 0x1 ?
>> +					"Operating System" : "Hypervisor");
>> +			break;
>> +		}
>> +	}
>> +
>> +	for (idx = 0; idx < ARRAY_SIZE(reset_reasons); idx++) {
>> +		if (rr->reset_reason == reset_reasons[idx].val) {
>> +			pr_info("%sReset Reason: 0x%x\t%s\n", pfx, reset_reasons[idx].val,
>> +				reset_reasons[idx].str);
>> +			break;
>> +		}
>> +	}
>> +
>> +	if (!rr->vendor_count)
>> +		return 0;
>> +
>> +	pr_info("%sReset Reason Vendor Data:\n", pfx);
>> +	vdata = (void *)rr + sizeof(*rr);
>> +
>> +	for (idx = 0; idx < rr->vendor_count; idx++) {
>> +		snprintf(newpfx, sizeof(newpfx), "%s ", pfx);
>> +		data_len = vdata->length - sizeof(*vdata);
>> +		data = (void *)vdata + sizeof(*vdata);
>> +		pr_info("%sVendor Data ID: %pUl\n", newpfx, vdata->vendor_id);
>> +		pr_info("%sRevision: 0x%x\n", newpfx, vdata->revision);
>> +		snprintf(newpfx, sizeof(newpfx), KERN_INFO "%s ", pfx);
>> +		print_hex_dump(newpfx, "Data: ", DUMP_PREFIX_NONE, 16, 4,
>> +			       data, data_len, false);
>> +		vdata = (void *)vdata + vdata->length;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +/*
>> + * Print the Firmware Health Data Record.
>> + */
>> +static int phat_health_data_parse(const char *pfx,
>> +				  struct acpi_phat_health_data *record)
>> +{
>> +	void *data;
>> +	u32 data_len;
>> +	char newpfx[64];
>> +
>> +	pr_info("%sHealth Records.\n", pfx);
>> +	snprintf(newpfx, sizeof(newpfx), "%s ", pfx);
>> +	pr_info("%sDevice Signature: %pUl\n", newpfx, record->device_guid);
>> +
>> +	switch (record->health) {
>> +	case ACPI_PHAT_ERRORS_FOUND:
>> +		pr_info("%sAmHealthy: Errors found\n", newpfx);
>> +		break;
>> +	case ACPI_PHAT_NO_ERRORS:
>> +		pr_info("%sAmHealthy: No errors found.\n", newpfx);
>> +		break;
>> +	case ACPI_PHAT_UNKNOWN_ERRORS:
>> +		pr_info("%sAmHealthy: Unknown.\n", newpfx);
>> +		break;
>> +	case ACPI_PHAT_ADVISORY:
>> +		pr_info("%sAmHealthy: Advisory – additional device-specific data exposed.\n",
>> +			newpfx);
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +
>> +	if (!record->device_specific_offset)
>> +		return 0;
>> +
>> +	/* Reset Reason Health Record has a unique GUID and is created as
>> +	 * a Health Record in the PHAT table. Check if this Health Record
>> +	 * is a Reset Reason Health Record.
>> +	 */
>> +	if (guid_equal((guid_t *)record->device_guid, &reset_guid)) {
>> +		phat_reset_reason_parse(newpfx, record);
>> +		return 0;
>> +	}
>> +
>> +	data = (void *)record + record->device_specific_offset;
>> +	data_len = record->header.length - record->device_specific_offset;
>> +	snprintf(newpfx, sizeof(newpfx), KERN_INFO "%s ", pfx);
>> +	print_hex_dump(newpfx, "Device Data: ", DUMP_PREFIX_NONE, 16, 4,
>> +		       data, data_len, false);
>> +
>> +	return 0;
>> +}
>> +
>> +static int parse_phat_table(const char *pfx, struct acpi_table_phat *phat_tab)
>> +{
>> +	char newpfx[64];
>> +	u32 offset = sizeof(*phat_tab);
>> +	struct acpi_phat_header *phat_header;
>> +
>> +	snprintf(newpfx, sizeof(newpfx), "%s ", pfx);
>> +
>> +	while (offset < phat_tab->header.length) {
>> +		phat_header = (void *)phat_tab + offset;
>> +		switch (phat_header->type) {
>> +		case ACPI_PHAT_TYPE_FW_VERSION_DATA:
>> +			phat_version_data_parse(newpfx, (struct acpi_phat_version_data *)
>> +			    phat_header);
>> +			break;
>> +		case ACPI_PHAT_TYPE_FW_HEALTH_DATA:
>> +			phat_health_data_parse(newpfx, (struct acpi_phat_health_data *)
>> +			    phat_header);
>> +			break;
>> +		default:
>> +			break;
>> +		}
>> +		offset += phat_header->length;
>> +	}
>> +	return 0;
>> +}
>> +
>> +static int __init setup_phat_disable(char *str)
>> +{
>> +	phat_disable = 1;
>> +	return 1;
>> +}
>> +__setup("phat_disable", setup_phat_disable);
>> +
>> +static int __init acpi_phat_init(void)
>> +{
>> +	acpi_status status;
>> +	struct acpi_table_phat *phat_tab;
>> +
>> +	if (acpi_disabled)
>> +		return 0;
>> +
>> +	if (phat_disable) {
>> +		pr_err("%sPHAT support has been disabled.\n", prefix);
>> +		return 0;
>> +	}
>> +
>> +	status = acpi_get_table(ACPI_SIG_PHAT, 0,
>> +				(struct acpi_table_header **)&phat_tab);
>> +
>> +	if (status == AE_NOT_FOUND) {
>> +		pr_info("%sPHAT Table not found.\n", prefix);
>> +		return 0;
>> +	} else if (ACPI_FAILURE(status)) {
>> +		pr_err("%sFailed to get PHAT Table: %s.\n", prefix,
>> +		       acpi_format_exception(status));
>> +		return -EINVAL;
>> +	}
>> +
>> +	pr_info("%sPlatform Telemetry Records.\n", prefix);
>> +	parse_phat_table(prefix, phat_tab);
> 
> So for now you're only dumping tables to the dmesg output ?
> Are you planning to create some sysfs interfaces similar to let's
> say EINJ ?
> 
Yes, for now, the output is being posted to dmesg only. If there is a
consensus, we can have the information exported through sysfs too.
The below location may be appropriate in that case:
/sys/firmware/acpi/
We already have FPDT and BGRT being exported from there.

Thanks,
Avadhut Naik
>> +
>> +	return 0;
>> +}
>> +late_initcall(acpi_phat_init);
>> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
>> index 0029336775a9..c263893cbc7f 100644
>> --- a/include/acpi/actbl2.h
>> +++ b/include/acpi/actbl2.h
>> @@ -2360,6 +2360,24 @@ struct acpi_phat_health_data {
>>  #define ACPI_PHAT_UNKNOWN_ERRORS        2
>>  #define ACPI_PHAT_ADVISORY              3
>>  
>> +/* Reset Reason Health Record Structure */
>> +
>> +struct acpi_phat_reset_reason {
>> +	u8 supported_reset_sources;
>> +	u8 reset_source;
>> +	u8 reset_sub_source;
>> +	u8 reset_reason;
>> +	u16 vendor_count;
>> +};
>> +
>> +/* Reset Reason Health Record Vendor Data Entry */
>> +
>> +struct acpi_phat_vendor_reset_data {
>> +	u8 vendor_id[16];
>> +	u16 length;
>> +	u16 revision;
>> +};
>> +
>>  /*******************************************************************************
>>   *
>>   * PMTT - Platform Memory Topology Table (ACPI 5.0)
> 

-- 
