Return-Path: <linux-kernel+bounces-84293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A30C286A4A8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0706A285408
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFBE15AF;
	Wed, 28 Feb 2024 00:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="unLw8Bi4"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2080.outbound.protection.outlook.com [40.92.107.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D1F23CB;
	Wed, 28 Feb 2024 00:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.107.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709081914; cv=fail; b=oRBXV6SeVj+TMmzIU/DbD7VMyMzcqDusE9L8aL9LO3S67nVPAWWO0nqgaGFaPtnpM6HzIAUKbaoJXArjDNsiKIw6Iw7GRzQIzOoemIpz47RdhSW0waCExHmZanWYHCk9eGt20dlH9sEfls7cTqSWqA1MNQJI2ywcmEF5VuqWlXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709081914; c=relaxed/simple;
	bh=uGdEdEY69s0W9RlnZIKz0P/gQ+I8TXjjmtEBnbvyDRQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ampR8fxtWjbJnnFGblFtewOvaZD7w/PD4rBFNtbQ7LDiyFaiQtkWpwzh5zToewTaDLPf8A7O33gB4Sxwl4IMG3EIogltQP7t3YkPDVYc8RG3ueCKrDglZQdl6Vt9tkoA/EaRzSqS+Xk3H9aBAsJJ5xL+9gF3XD7XyGWkCmgI8Jc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=unLw8Bi4; arc=fail smtp.client-ip=40.92.107.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VrvtlQGPKdIQPqypfuUKLDJEqFmHBr59gEU44KNPZL3MGsIvtNMugkcIk/RTqOJ5R7aiD2bEW8jbiW6cQt0N1/EMfmGAnZ9/rYlYDusJo82ZqBWJbzR3v88zDJiZnAtvqju/dQ63IDX3PmtRKCo54pRRzDOMOGsSzlesApXppW/wcikE2Wp9g4QXFIXtqbfrW3uoxG+QWzLzYYPfTV/BhyfjyLV0oP7nD78GOhK1YTV6Fd8dWwpTSV/vjF7aLE4JZ6Qh0+GY9NmrSL8L2SjRQ8Aw/Jgm0hGDqMZL7uAH5nxucdip+fKJIh1oeVaB/W7yN69A16AWt68XaWFYdYW/yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UgvQP/pt91j6Pi+4m/Juod8yAbz2fcKZkmnddFhjfm0=;
 b=P4QsuIcS7fGLGRmEv96LOYsF2aQzliNyrVahK6E3qmNKE9Zz1gOrYB1HOwgkR/Zr16hM8ZwRJKYY1xrUnAhkssyyQ0xTHYy/0eeM3Y9gueqTycf1i41gYZ5w5pZT4cafotwqA7hIdKFHOsTQmWdELUddWtSjmriR1N8EiPzki9beYteb386VS+IUH1BjPvSWj0xB/mfHoxwjrR0FzN+y8WuevyxtWY/a3snnjVXAG3YFsNBhaKrMf6zn+b1S0rANQXaI4Qa9dzD06XN/DBZ45gndKUcRMUd607gEn4NAiRjZ/AAXLIuhiDGLQK3m3UJafP6KSssQ79GJVR1eftHHIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UgvQP/pt91j6Pi+4m/Juod8yAbz2fcKZkmnddFhjfm0=;
 b=unLw8Bi49yzUQw/Qz6Byt249fJgplLAvuNSu6PW6cO1o9mWLNMNAGbj7nYT5Mob/hSI8k5UKpo1CZdxETcE4yUZLIJrfd8yzi02vncZZIEWNJUKdySjQNtZxp0O9Xa1VfMJ3nSrc8brHIt045JlhHytOGEA9fKzknUkj6mOJriaRo4jeCPm6CCeJa0khWmvRPUhdgIgSzpa1P/5TYufE1E7le7dgHeRBBlZ5Ld+CUFyN/0uKHABzCFa2ED2EWuSD3oXUu3Lvs6nwKJ6hpJpBeVKlmy8lqKRNzPzwdLxjJEkCVlAuRnsiyS+j0bqBB8RN1yP5DEYnvmp5N2zFlSWEWg==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by TYSPR06MB6338.apcprd06.prod.outlook.com (2603:1096:400:433::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Wed, 28 Feb
 2024 00:58:25 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad%4]) with mapi id 15.20.7316.035; Wed, 28 Feb 2024
 00:58:25 +0000
Message-ID:
 <SEZPR06MB6959E0E07423A82DEF133CCB96582@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Wed, 28 Feb 2024 08:58:15 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/5] mmc: dw_mmc: add support for hi3798mv200
Content-Language: en-US
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Igor Opaniuk <igor.opaniuk@linaro.org>,
 tianshuliang <tianshuliang@hisilicon.com>, David Yang <mmyangfl@gmail.com>,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
 openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
References: <20240221-b4-mmc-hi3798mv200-v6-0-bc41bf6a9769@outlook.com>
 <20240221-b4-mmc-hi3798mv200-v6-3-bc41bf6a9769@outlook.com>
 <CAPDyKFosUX7giCYbFJpKRjSDHKEyO6FATna5VnDg7tHEzagWBg@mail.gmail.com>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <CAPDyKFosUX7giCYbFJpKRjSDHKEyO6FATna5VnDg7tHEzagWBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN: [ZgIm6KRo4+x9BsYGTwbEEr1fV2qkA2H9BgZ+Tr6OdVFEbUzyHP8beFN7z6pGLWPU]
X-ClientProxiedBy: KL1PR01CA0015.apcprd01.prod.exchangelabs.com
 (2603:1096:820::27) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <743b8a86-6790-4282-9da0-331d54283ace@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|TYSPR06MB6338:EE_
X-MS-Office365-Filtering-Correlation-Id: 7354d83b-c927-47b6-772e-08dc37f85ddb
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VJyBjNGoV5WdGO8UGOgiTiW5lu+dQtb+q3HHMwBIgIRLqXw61SfK65Fx4Tffzge06HkLaKt5ZX458AXUULLN4bSqxhkVwgk3Bu7L+ifxac5hM17AeeRx9BkdZ0OQf1mVHg+HxIPrXsT+E+G3sxJXhE+RJOoLHZJ6kYs+YR+Q1i0dvfkqf5lFwJOaxX0Wu1fHYwlzax/g6CiY4oeQW/3ss/aC2VBGK7P3RKTSyl9CoUrIUm2UKX+M7lCFNNNu4xO+EKJ5aAhTlLjZTzVZaprRXNcFuqpUfvQS0F3iRJiIyq95VEheFcVyThaCnAt8OrxA4vsadNaogmRe5sYF7hJweqVcn9tcYDBsl8kTtZAHK1rJV0l/fH/fvlVHn1cYy+OPJmLxw7j66YNwdxVUZjik/lEuHC0T7a6nJUVSCq5Oyt+SXT1R683iqdvr78PTPdVNT381sKQDqKvp+ESAIXPU+sgTQtVzM9Nt3p9B2JJ4r1oSEq9QcmJs82y4PvytpUocmaziiWJaXE8Aj/fFmwYdZL+ZCtlBRI7QRMStBAyDZV//qBgUVQCogtPLIp2xQ8RF
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2V6cXBmR3JOUG41SEYvWFZRYzk0dnZIYW0yMnduZHBMc1VtYWpKTDRibndt?=
 =?utf-8?B?TTdkWjYvM0ZMS2U4UFlDOGIzSVlIS2pnMlpGMTc4RjRsZTRrTDE2dVhCYTZV?=
 =?utf-8?B?YlgxVWR0eXZaenoxdWRMdjZXcFc2a3BMcXlEN25jTnUzdEUrM2hVZE1lcFp1?=
 =?utf-8?B?YkgzTEkzREZFTzcyUzFmK1pLdUxkNW0xRlQrQkQ5YnR6ZFpXSXdIVnhIam9s?=
 =?utf-8?B?K1lBdm82eUlzUWJOcmZ5SVJ6cTJ5QTMybUY1U2V0YTNyZTk0KytBejBNNmh2?=
 =?utf-8?B?TzhnSUJxclBwaWdyRGJZeXRGR3M5THdWcEUzaXluWFpvanVkQ1Q0NEVsSUQ4?=
 =?utf-8?B?TjVQVXVmeGE0OWtRZTJBSjExL2FwZHVOZXRHNzh5U0h1bHhJYlUvWXZQNDhs?=
 =?utf-8?B?YmFJaG9VWUV1UlBYQTRxVkhBR3RaeHNOVWUvaGo0RVBFMEo4bmdjN0VMNEhF?=
 =?utf-8?B?MVh1NWxobGM3bFd1dmRSNzRMc0pKV2dIY1pERVBZTm5kYjIvUGdabEdBVFVp?=
 =?utf-8?B?UE9HaE9HWi9pSFpLVFV2ZVpsVkI5cW5NSTFVd2l1d2hYdWlwalp4WjRrLzBS?=
 =?utf-8?B?MTA0bTZOaVlhWURUOGVPNk9ONlJyN0xCUS8vL2xLVlJwWWhCMzN6UXloWUxS?=
 =?utf-8?B?NTJlc2F3WUE5V0Z2NTZ0WW5PQklkQzBGMEZ2RlYwd0hvNm1oem5nZ0NJZkQw?=
 =?utf-8?B?QVQ4b2VmUGsrZytkblJKU0FRbFJYYjRTRW1YaXNGSjVhbzlYaFZ2eXBZOFBj?=
 =?utf-8?B?dWJnZGs3U0lIcGlJQTA1YnFxZFhNRWNnN2x2WTNVcjQ5bW1oeURwekFWMVI0?=
 =?utf-8?B?dTZDT2RZYVM3OWttVjJNVHVTWlJraWtieG1qdlVYbUIvdzJPSEFOVVhBOG8w?=
 =?utf-8?B?aGR3RWpYU0xOdC9UK3ltVklBelVSK2hxRkpidy9scWFyZUpXZ2YycGFVZXNG?=
 =?utf-8?B?SWhXdmdVNllycjhadmx2VmYxZS8wT2szRjBicEZPVTkwcmk2b1Q1VnhUaUJF?=
 =?utf-8?B?bVZQMzZlVFhQQVZ1RElNMmEyeWlQNWR6ZWdtejZTL0Z1RGNKdWl0NUJWTDdw?=
 =?utf-8?B?dmdMVkkwNHZiZHhjU3FZTklDZGhSQmpuRDZ5YUw4ZmVVeGtQZUZLWWxEVnZl?=
 =?utf-8?B?Y0RXeFFiSUhzUHhxMmI5c1daQ2I4YmZMYkZrWTZsaWJ1Z1hEU0hhOUFaZ2FW?=
 =?utf-8?B?RFc3eEdmR1JiR2JwREV2L0hsME9ObUpBMDN4MlZYcjkvWTVsNThMODNDV0p5?=
 =?utf-8?B?eG9DU3RNNEJkeml6ZmJ0MytVdk10L0dySHFYTlArUWtaRGFZTU92WE1MRXN2?=
 =?utf-8?B?UEpVYTRseENadW0yeXlXV3krT3ZFSGpiZWNTUmg3bmxjb3kwd3BTZTRxOWdD?=
 =?utf-8?B?Z0M0emg5a0VkN014Qzh1SFNudGc5UUtCSjVWUWVvYkFSdHBLdm91VHVVT0Jy?=
 =?utf-8?B?cy9HeVpGK09SUFJxWDBhQ0hpT0E4VlRnRGVoOFpZM1NMTVZyaHFWTVBZTzRs?=
 =?utf-8?B?aDlqSG5hRXkrVlQ1R0owODJSaktmZHNkbFdJSXJ0czJ4WjVrZXUzUEl3STJ6?=
 =?utf-8?B?clhvYjRGV01haGVkSUFzWjJCMFRQZko1TnpPU0x3a29DNHJhck54VldjaWRi?=
 =?utf-8?B?UU4xVzZSR1hHWVpTRU0vWFJBVm1ndlVESnRGYW1rZ1FEMnp6TzRWVjZKaTBs?=
 =?utf-8?B?NGFRV0ovRkNEdGJHWEh6Y1FqbG5Ja0ZtKzFiMjRkb2Y3aEcyczBlNUI5aExD?=
 =?utf-8?Q?NIHxyavCux7G7kCqjq3G2vIc7F54+n5VXKQ+slH?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7354d83b-c927-47b6-772e-08dc37f85ddb
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 00:58:25.1806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6338

On 2/27/2024 11:16 PM, Ulf Hansson wrote:
> On Wed, 21 Feb 2024 at 13:45, Yang Xiwen via B4 Relay
> <devnull+forbidden405.outlook.com@kernel.org> wrote:
>>
>> From: Yang Xiwen <forbidden405@outlook.com>
>>
>> Add support for Hi3798MV200 specific extension.
>>
>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>> ---
>>  drivers/mmc/host/Kconfig              |   9 ++
>>  drivers/mmc/host/Makefile             |   1 +
>>  drivers/mmc/host/dw_mmc-hi3798mv200.c | 239 ++++++++++++++++++++++++++++++++++
>>  3 files changed, 249 insertions(+)
>>
>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
>> index 81f2c4e05287..aebc587f77a7 100644
>> --- a/drivers/mmc/host/Kconfig
>> +++ b/drivers/mmc/host/Kconfig
>> @@ -798,6 +798,15 @@ config MMC_DW_HI3798CV200
>>           Synopsys DesignWare Memory Card Interface driver. Select this option
>>           for platforms based on HiSilicon Hi3798CV200 SoC.
>>
>> +config MMC_DW_HI3798MV200
>> +       tristate "Hi3798MV200 specific extensions for Synopsys DW Memory Card Interface"
>> +       depends on MMC_DW
>> +       select MMC_DW_PLTFM
>> +       help
>> +         This selects support for HiSilicon Hi3798MV200 SoC specific extensions to the
>> +         Synopsys DesignWare Memory Card Interface driver. Select this option
>> +         for platforms based on HiSilicon Hi3798MV200 SoC.
>> +
>>  config MMC_DW_K3
>>         tristate "K3 specific extensions for Synopsys DW Memory Card Interface"
>>         depends on MMC_DW
>> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
>> index d0be4465f3ec..f53f86d200ac 100644
>> --- a/drivers/mmc/host/Makefile
>> +++ b/drivers/mmc/host/Makefile
>> @@ -51,6 +51,7 @@ obj-$(CONFIG_MMC_DW_PLTFM)    += dw_mmc-pltfm.o
>>  obj-$(CONFIG_MMC_DW_BLUEFIELD) += dw_mmc-bluefield.o
>>  obj-$(CONFIG_MMC_DW_EXYNOS)    += dw_mmc-exynos.o
>>  obj-$(CONFIG_MMC_DW_HI3798CV200) += dw_mmc-hi3798cv200.o
>> +obj-$(CONFIG_MMC_DW_HI3798MV200) += dw_mmc-hi3798mv200.o
>>  obj-$(CONFIG_MMC_DW_K3)                += dw_mmc-k3.o
>>  obj-$(CONFIG_MMC_DW_PCI)       += dw_mmc-pci.o
>>  obj-$(CONFIG_MMC_DW_ROCKCHIP)  += dw_mmc-rockchip.o
>> diff --git a/drivers/mmc/host/dw_mmc-hi3798mv200.c b/drivers/mmc/host/dw_mmc-hi3798mv200.c
>> new file mode 100644
>> index 000000000000..73aaa21040ea
>> --- /dev/null
>> +++ b/drivers/mmc/host/dw_mmc-hi3798mv200.c
>> @@ -0,0 +1,239 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Modified from dw_mmc-hi3798cv200.c
>> + *
>> + * Copyright (c) 2024 Yang Xiwen <forbidden405@outlook.com>
>> + * Copyright (c) 2018 HiSilicon Technologies Co., Ltd.
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/mmc/host.h>
>> +#include <linux/module.h>
>> +#include <linux/of_address.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +
>> +#include "dw_mmc.h"
>> +#include "dw_mmc-pltfm.h"
>> +
>> +#define SDMMC_TUNING_CTRL      0x118
>> +#define SDMMC_TUNING_FIND_EDGE BIT(5)
>> +
>> +#define ALL_INT_CLR            0x1ffff
>> +
>> +/* DLL ctrl reg */
>> +#define SAP_DLL_CTRL_DLLMODE   BIT(16)
>> +
>> +struct dw_mci_hi3798mv200_priv {
>> +       struct clk *sample_clk;
>> +       struct clk *drive_clk;
>> +       struct regmap *crg_reg;
>> +       u32 sap_dll_offset;
>> +       struct mmc_clk_phase_map phase_map;
>> +};
>> +
>> +static void dw_mci_hi3798mv200_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>> +{
>> +       struct dw_mci_hi3798mv200_priv *priv = host->priv;
>> +       struct mmc_clk_phase phase = priv->phase_map.phase[ios->timing];
>> +       u32 val;
>> +
>> +       val = mci_readl(host, ENABLE_SHIFT);
>> +       if (ios->timing == MMC_TIMING_MMC_DDR52
>> +           || ios->timing == MMC_TIMING_UHS_DDR50)
>> +               val |= SDMMC_ENABLE_PHASE;
>> +       else
>> +               val &= ~SDMMC_ENABLE_PHASE;
>> +       mci_writel(host, ENABLE_SHIFT, val);
>> +
>> +       val = mci_readl(host, DDR_REG);
>> +       if (ios->timing == MMC_TIMING_MMC_HS400)
>> +               val |= SDMMC_DDR_HS400;
>> +       else
>> +               val &= ~SDMMC_DDR_HS400;
>> +       mci_writel(host, DDR_REG, val);
>> +
>> +       if (clk_set_rate(host->ciu_clk, ios->clock))
>> +               dev_warn(host->dev, "Failed to set rate to %u\n", ios->clock);
>> +       else
>> +               // CLK_MUX_ROUND_NEAREST is enabled for this clock
>> +               // The actual clock rate is not what we setted, but a rounded value
>> +               // so we should get the rate once again
> 
> Please use proper comments sections (/* .... */) and not "//".
> 
>> +               host->bus_hz = clk_get_rate(host->ciu_clk);
>> +
>> +       if (phase.valid) {
>> +               clk_set_phase(priv->drive_clk, phase.out_deg);
>> +               clk_set_phase(priv->sample_clk, phase.in_deg);
>> +       } else {
>> +               dev_warn(host->dev,
>> +                        "The phase entry for timing mode %d is missing in device tree.\n",
>> +                        ios->timing);
>> +       }
>> +}
>> +
>> +static inline int dw_mci_hi3798mv200_enable_tuning(struct dw_mci_slot *slot)
>> +{
>> +       struct dw_mci_hi3798mv200_priv *priv = slot->host->priv;
>> +
>> +       return regmap_clear_bits(priv->crg_reg, priv->sap_dll_offset, SAP_DLL_CTRL_DLLMODE);
>> +}
>> +
>> +static inline int dw_mci_hi3798mv200_disable_tuning(struct dw_mci_slot *slot)
>> +{
>> +       struct dw_mci_hi3798mv200_priv *priv = slot->host->priv;
>> +
>> +       return regmap_set_bits(priv->crg_reg, priv->sap_dll_offset, SAP_DLL_CTRL_DLLMODE);
>> +}
>> +
>> +static int dw_mci_hi3798mv200_execute_tuning_mix_mode(struct dw_mci_slot *slot,
>> +                                            u32 opcode)
>> +{
>> +       static const int degrees[] = { 0, 45, 90, 135, 180, 225, 270, 315 };
>> +       struct dw_mci *host = slot->host;
>> +       struct dw_mci_hi3798mv200_priv *priv = host->priv;
>> +       int raise_point = -1, fall_point = -1;
>> +       int err, prev_err = -1;
>> +       int found = 0;
>> +       int regval;
>> +       int i;
>> +       int ret;
>> +
>> +       // enable tuning
> 
> Looks like a redundant comment, please drop it.
> 
>> +       ret = dw_mci_hi3798mv200_enable_tuning(slot);
>> +       if (ret < 0)
>> +               return ret;
> 
> A newline here would improve the readability I think.
> 
>> +       for (i = 0; i < ARRAY_SIZE(degrees); i++) {
>> +               clk_set_phase(priv->sample_clk, degrees[i]);
>> +               mci_writel(host, RINTSTS, ALL_INT_CLR);
>> +
>> +               err = mmc_send_tuning(slot->mmc, opcode, NULL);
>> +               if (!err) {
>> +                       regval = mci_readl(host, TUNING_CTRL);
>> +                       if (regval & SDMMC_TUNING_FIND_EDGE)
>> +                               err = 1;
>> +                       else
>> +                               found = 1;
>> +               };
>> +
>> +               if (i > 0) {
>> +                       if (err && !prev_err)
>> +                               fall_point = i - 1;
>> +                       if (!err && prev_err)
>> +                               raise_point = i;
>> +               }
>> +
>> +               if (raise_point != -1 && fall_point != -1)
>> +                       goto tuning_out;
>> +
>> +               prev_err = err;
>> +               err = 0;
>> +       }
>> +
>> +tuning_out:
>> +       ret = dw_mci_hi3798mv200_disable_tuning(slot);
>> +       if (ret < 0)
>> +               return ret;
>> +       if (found) {
>> +               if (raise_point == -1)
>> +                       raise_point = 0;
>> +               if (fall_point == -1)
>> +                       fall_point = ARRAY_SIZE(degrees) - 1;
>> +               if (fall_point < raise_point) {
>> +                       if ((raise_point + fall_point) >
>> +                           (ARRAY_SIZE(degrees) - 1))
>> +                               i = fall_point / 2;
>> +                       else
>> +                               i = (raise_point + ARRAY_SIZE(degrees) - 1) / 2;
>> +               } else {
>> +                       i = (raise_point + fall_point) / 2;
>> +               }
>> +
>> +               // use the same phase table for both HS200 and HS400
> 
> Don't use "//" for comments.
> 
>> +               priv->phase_map.phase[MMC_TIMING_MMC_HS200].in_deg = degrees[i];
>> +               priv->phase_map.phase[MMC_TIMING_MMC_HS400].in_deg = degrees[i];
>> +
>> +               clk_set_phase(priv->sample_clk, degrees[i]);
>> +               dev_dbg(host->dev, "Tuning clk_sample[%d, %d], set[%d]\n",
>> +                       raise_point, fall_point, degrees[i]);
>> +               err = 0;
>> +       } else {
>> +               dev_err(host->dev, "No valid clk_sample shift! use default\n");
>> +               err = -EINVAL;
>> +       }
>> +
>> +       mci_writel(host, RINTSTS, ALL_INT_CLR);
>> +       return err;
> 
> The entire code in dw_mci_hi3798mv200_execute_tuning_mix_mode() looks
> rather messy to me. A lot of variables are being used, set and reset
> from everywhere.
> 
> Would you mind having a closer look and try to improve it a bit, so it
> becomes easier to follow what is going on?

That might because the code here is modified from dw-mmc_hi3798cv200.c.
And That file is already a mess. I'll try to improve it soon.

> 
>> +}
>> +
>> +static int dw_mci_hi3798mv200_init(struct dw_mci *host)
>> +{
>> +       struct dw_mci_hi3798mv200_priv *priv;
>> +       struct device_node *np = host->dev->of_node;
>> +       int ret;
>> +
>> +       priv = devm_kzalloc(host->dev, sizeof(*priv), GFP_KERNEL);
>> +       if (!priv)
>> +               return -ENOMEM;
>> +
>> +       mmc_of_parse_clk_phase(host->dev, &priv->phase_map);
>> +
>> +       priv->sample_clk = devm_clk_get_enabled(host->dev, "ciu-sample");
>> +       if (IS_ERR(priv->sample_clk))
>> +               return dev_err_probe(host->dev, PTR_ERR(priv->sample_clk),
>> +                                    "failed to get enabled ciu-sample clock\n");
>> +
>> +       priv->drive_clk = devm_clk_get_enabled(host->dev, "ciu-drive");
>> +       if (IS_ERR(priv->drive_clk))
>> +               return dev_err_probe(host->dev, PTR_ERR(priv->drive_clk),
>> +                                    "failed to get enabled ciu-drive clock\n");
>> +
>> +       priv->crg_reg = syscon_regmap_lookup_by_phandle(np, "hisilicon,sap-dll-reg");
>> +       if (IS_ERR(priv->crg_reg))
>> +               return dev_err_probe(host->dev, PTR_ERR(priv->crg_reg),
>> +                                    "failed to get CRG reg\n");
>> +
>> +       ret = of_property_read_u32_index(np, "hisilicon,sap-dll-reg", 1, &priv->sap_dll_offset);
>> +       if (ret)
>> +               return dev_err_probe(host->dev, ret, "failed to get sample DLL register offset\n");
>> +
>> +       host->priv = priv;
>> +       return 0;
>> +}
>> +
>> +static const struct dw_mci_drv_data hi3798mv200_data = {
>> +       .common_caps = MMC_CAP_CMD23,
>> +       .init = dw_mci_hi3798mv200_init,
>> +       .set_ios = dw_mci_hi3798mv200_set_ios,
>> +       .execute_tuning = dw_mci_hi3798mv200_execute_tuning_mix_mode,
>> +};
>> +
>> +static const struct of_device_id dw_mci_hi3798mv200_match[] = {
>> +       { .compatible = "hisilicon,hi3798mv200-dw-mshc" },
>> +       {},
>> +};
>> +
>> +static int dw_mci_hi3798mv200_probe(struct platform_device *pdev)
>> +{
>> +       return dw_mci_pltfm_register(pdev, &hi3798mv200_data);
>> +}
>> +
>> +static void dw_mci_hi3798mv200_remove(struct platform_device *pdev)
>> +{
>> +       dw_mci_pltfm_remove(pdev);
>> +}
>> +
>> +MODULE_DEVICE_TABLE(of, dw_mci_hi3798mv200_match);
>> +static struct platform_driver dw_mci_hi3798mv200_driver = {
>> +       .probe = dw_mci_hi3798mv200_probe,
>> +       .remove_new = dw_mci_hi3798mv200_remove,
>> +       .driver = {
>> +               .name = "dwmmc_hi3798mv200",
>> +               .probe_type = PROBE_PREFER_ASYNCHRONOUS,
>> +               .of_match_table = dw_mci_hi3798mv200_match,
>> +       },
>> +};
>> +module_platform_driver(dw_mci_hi3798mv200_driver);
>> +
>> +MODULE_DESCRIPTION("HiSilicon Hi3798MV200 Specific DW-MSHC Driver Extension");
>> +MODULE_LICENSE("GPL");
>>
> 
> Kind regards
> Uffe

-- 
Best regards,
Yang Xiwen


