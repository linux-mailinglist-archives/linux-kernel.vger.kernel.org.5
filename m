Return-Path: <linux-kernel+bounces-32966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E34C83628F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F4192922D6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C023A8F7;
	Mon, 22 Jan 2024 11:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="enR3Y81l"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C073A8EF
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 11:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705924137; cv=fail; b=EN2auD738lgFzBEc+GPvqaL4XlBuEr1Cw7w7almki1jWz6hOE0DwRJANxTd8daRW8sSmILmmaYwEGWqUQgxasghw/zffroypZKPNWyZaFQk6JxY+GUfBj2IyqyCNjHShOO2CwPF08uV5r1wldbSbiTI/05Qushag26Q4CFnO9pk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705924137; c=relaxed/simple;
	bh=ahvMvpmcQxi+0KiN1Ei9qAxifmDJKtNDCNKRT/jW4k4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZJPaHRBhTyG/atbRz/WXeviVW9I+XYIGbQfuBptHcF5evXUqKDmT3adVu3W4Mixbjj6uSOS+/blgxl9k52SHvWasH/Mmuvx4UZ2rs/4gUOV3Krp+QhPu71ihWIjwAQufhBuER4/NZSe8x50HYUG6WK5Vb34K0IWLVVrXiFTa1DE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=enR3Y81l; arc=fail smtp.client-ip=40.107.237.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WRZBZofxFwXdsPqGSPrLnRRn2LRSDumNrIbQxlz3tCHaYetX4cdZBr3uBL/KSIlZnf4glxZN85NZG4V44TXtdBJsO2gxxO187CsUGq7/QiFOeA3F2Zb8tRR9DkTTxCY+WM54d8f82fBHX5JDFTXAOxeJDKIbwwjd3xima5fc9yzEeOkmftHYYsKbTmw3Uqs2TItYoGvPtzYDScJ6SQrCVe9dv6nRqbzZ5527bED9wihH7PXHLausfPHnYfGR2wEWTy3LdTgMzw7aEVt/1Zo36t5yMyh68UWW+RrEgNJu3R9iCgwcHzwj+sNgu9O6hxeusJSSEKb+FFdPhgluCsBWMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k2B5/KyMuje+izcaflkv7h4AMe4khTh6jGf5ASGMQyk=;
 b=jYs0sRT9yuIeuJmHFlzVYfz/eC56zZb/n0X8HES0OI536EQV4YLRWqrDv5dqrUuoFgdJTE3nwd0DJ7q02hkdWcCXoqqCddzeGFfS1DmgBjgS6X66SdcIRNtv0MAQB6HwbZ26AqF9UGzrlTIvB+gTOcGyHvt4mz1ZOb04iE4cR4MH9dRIjd0plXBdTQKlOZwjUWo+oNOldYZPIHA390pnI5+cUQCnBKwmjtiWldq9z5bksyoN0r1+lwpXvUjkoCCLyZci5V7zdk/ib3E4FGkH0l8HTB9eZY9Zm8lmZMKgZma50AfSKTV5+ySCk9/np1m/eenjSd2A2olC6ZZKp8gsYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2B5/KyMuje+izcaflkv7h4AMe4khTh6jGf5ASGMQyk=;
 b=enR3Y81l+/cpRXI0T7OymRzdQsCVYJN6mtptj5R+sgGNhEtRgHmkth4N1pIbxbEDLOl3fGS0xPQ5O7T+QvIgsDbckzgB58y/4VwpE/tkhZ0+L0srk4ObQnayCKSuE1jy+q2zO5vTwlMW1quuMCzdnm5na+ZKVWqdE2E5coSgLCg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by LV2PR12MB5847.namprd12.prod.outlook.com (2603:10b6:408:174::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 11:48:52 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::6755:ec77:7e30:bcc6]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::6755:ec77:7e30:bcc6%3]) with mapi id 15.20.7202.034; Mon, 22 Jan 2024
 11:48:52 +0000
Message-ID: <d8f5ee8b-466e-4069-b06b-41cdc7fa9e40@amd.com>
Date: Mon, 22 Jan 2024 17:18:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 03/13] drivers: soundwire: amd: refactor amd soundwire
 manager device node creation
Content-Language: en-US
To: Vinod Koul <vkoul@kernel.org>
Cc: broonie@kernel.org, alsa-devel@alsa-project.org,
 yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.intel.com,
 Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
 vinod.koul@intel.com, venkataprasad.potturu@amd.com,
 Sanyog Kale <sanyog.r.kale@intel.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20240110094416.853610-1-Vijendar.Mukunda@amd.com>
 <20240110094416.853610-4-Vijendar.Mukunda@amd.com> <Za4f1rwAXAiJU-j5@matsya>
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <Za4f1rwAXAiJU-j5@matsya>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0129.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::8) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|LV2PR12MB5847:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b3cd96d-f420-4aa0-68ab-08dc1b401ab2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IHhFIsoEaJxyxuUUssUuUlKscvVVEdv+q4Cq8l4dLgFAoOj67HAEh4/XTqweeM9Ma2B6WchbRoe+ppIkvixGQwcUdaQHxMvKGa5trpjOQWrMx8N6ZD+ei1Ec4F0nf6awI82fqVvYjVR/yn0KiJmNFgqxtY07oOKnvqEKqhJNH+36yWh+HW7yz9zcghjWoojl4emUqLurbC3TD9uf5QCpFqdU2Bx7eGdpqQSA3dqnBedOyJ7eeF8OTmYPkv7yABDAhYf2wEpyzRPYzXfGgnJKRgDGArq3MTF4oEGXgCuamwe/jUseybJpY+hGq8LGXLBIqRu1EPlbNOMXzTngA1HeiI+wWNNTJQo9f5wOLorRuLFWqQ2wATGVPzuJ8X43oSbAiwIeyoS1vMoWzLZN7kTsQ29kmVvKOhh5PhMfxdIHBTwZHcf/fSTVkbiptlOAQnH5e39Vg1Oqqexujtdz7PaB99Fg9Nb5OM0Vu1Cz5WIEwcqbFj1BrwdX1V43jYBAYxxdajqyY4WbY8QN5pUe7SCIyvx0XPXTPg67n7113GHDhO9z32kMAgRAeFQRV0gAd2ivBoJ6HIdgzy/8DxkVjC7bAWzdtw3k2h2kYoV28HKBRE8WV27n1XQteIJEmxf40ehCRK6U/2yBMLfGZDWjGieX4Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(376002)(366004)(396003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(26005)(6666004)(6506007)(6512007)(53546011)(2616005)(83380400001)(2906002)(5660300002)(30864003)(66476007)(6486002)(66946007)(478600001)(4326008)(8676002)(66556008)(8936002)(54906003)(316002)(6916009)(41300700001)(31696002)(38100700002)(86362001)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWlqU1U1dmtabFFGVmV2TzRZQjlxcGpma1NiYkxxbnQveVNGQ0FXSk9Fbjdm?=
 =?utf-8?B?c21IN21QcFpHLzhEcituU2NTNVdNSHphejlNRnlYRXhCSG5qamphZUJXYUhn?=
 =?utf-8?B?WHNqQ2JOenVSYVB5Q25aSCtQMnBqM2dMelI3NFJTZnZDRklMMjVON1pYNDlk?=
 =?utf-8?B?Y3QyMmVuM2J6eTRyZFF2WmFmQ3d5NDh1M2hqajRUOThnVjEzdk5ZUThQcVNi?=
 =?utf-8?B?OFdVVElhR2dGWHpaS3YxUVIrS095MGJRNXhYaEhOVjVUL0NxT3hjZzB1TTN6?=
 =?utf-8?B?NXA2NjRXUkh4aXA0dk9GVTFEaUN1STA5QnViYWhzQ0JZLzhBU1A1SzR1N0h6?=
 =?utf-8?B?bmFPRW9DbHQvSTZmcVhVZ084VU4vYmpBR05ZUEY5aWFhSU5DWXp6UGttdmVV?=
 =?utf-8?B?cGRXNUYvUkNUT24yS2NoeEROa1V3OW5QbEF4ZTVYQXZWMEgrY1BMVUZxVFFi?=
 =?utf-8?B?SGFLQStuMHZsTHJ5a0xXUHlxT3JJQUozSnExVW5IdVFSK2twNW5kdWRZeE1n?=
 =?utf-8?B?VE5rSEN3TlJHN3FId1gyNFJPc0xnbFQxalovYW9XWk9RcHJzVGZjYno5VHhk?=
 =?utf-8?B?b2RBUGJrVkdkSnRWV2xTYzhhbnRTRW83UDlVT0d6cDAvWFg4YnduTnVXM21w?=
 =?utf-8?B?cFNMRFJ3RVJ6cnZ6RHlvRWg3T1FMZXhJOUtyZ1ZKWks4bU1KTytYWklCL3Ur?=
 =?utf-8?B?MHBsSTk5TDFGTXBqS2dUZnhaZFpZMDV2dFpQajdoWFh6SHQ1T0cwaGJ5bDBQ?=
 =?utf-8?B?WmhDRkhqT1o3WUM0REg1QmVnME1xNEdtWFMwOGNSUFNTbHQvY1BPemNkTlVT?=
 =?utf-8?B?eXB1eGU5eENBMU5EbDdyMmU1bGZ5bkRidzMvS1ovRS9oelNXc3hZblpOc2p5?=
 =?utf-8?B?aCtpOFQ1VHFlRWVTVVhGMjYvaGUxMzhSWXdyWkRWSEhOcTlaZXVsZmRvRWph?=
 =?utf-8?B?dThablRFL1c5VENVekFZYTVheDdQdXZ0MnR2L0N3elMvY1BkWGxCaUNHSFgy?=
 =?utf-8?B?MERGSVNNK3hNd0N4RklDY24rT1V4cjV6Vkd5TVRzWjE4R0pnUTZpa2VOSTRL?=
 =?utf-8?B?aWdacGovbElvcktCUE4walRnVUF5MlNyK1Q3VVQ4aFZEM25iaGdWa1kyYmw3?=
 =?utf-8?B?QVQyQWRvdFNFeVJONUhTQVlsLzlCSEFMT2ZZT0pub3VhcjhMZXVOeklzYStB?=
 =?utf-8?B?YkJod1A3T1lhelBrbk1wOWVzWG1UaldiRlFCVlJFYUtuNEZ6eDhmQVIweGNE?=
 =?utf-8?B?MENpNjlRek5IeWp0SkRLS0RyWjNROVpBYTVDank1NDVUNWM2OHlsN3Q4NHNn?=
 =?utf-8?B?NlJRZGhqQ0s4QnpNV2tsSkpwVEJIYmJIOHlqTjZsNDJHTXJaZlVJdW0yVmVY?=
 =?utf-8?B?eE1vSUpiR2Q3dm9sTk1YcnZYeXVuOGo2T2ltUzF1YzVObDRUUXVxYmtJb0dO?=
 =?utf-8?B?Zm9wMlFhREhnQmpDaHNRamVzK0pRanozems3TlhLRTBTLzNhamlEWDV2OHBo?=
 =?utf-8?B?d2xWSXQ0MGtyMUQ3blVmMUMvQUhwRDBURzRxRFluUy93SlFqcDlSa0hlckx1?=
 =?utf-8?B?a0JCcE5DY3pxbUlQMHVPQkx6REFVZW05dklCbXBFak85aUdxRUxucEMvbXlo?=
 =?utf-8?B?Y1MwWVQ5RlZmNEkvSEFyODdVZ0ZwVnhYMEo3MWt3SUZVWWJUSjl5SXJYSXho?=
 =?utf-8?B?ZFg3NlIraGRSWm1Va0g2MWZqTUE1Z1VGTCs4NHI1WW4waGNDVVlxMVRmMjJX?=
 =?utf-8?B?ZWs2Qjc1RUh2ajltOEZ1bENXN1Z5OEFEWXVlQXFDWHFSNjRZVEQ1V09TN2Nk?=
 =?utf-8?B?SGgzUElQVW95TmlwVXZYa3RzVmd5b2JBU3Z6dUJ1K0VlQmhyVXhFYm8yOXk5?=
 =?utf-8?B?RXJCMVpIWklBYUFDNE9CTmR4T085djJxb0tOS05EWUN3UkQ0R3pNbjIrUC9T?=
 =?utf-8?B?OFMrM2c3YXk0K29yZ0hxM2hveTgzZHRnMnFtaXNqV1dVQVR0R0RNUDZKRFNR?=
 =?utf-8?B?Yk5VTk9ud2hqdy9FNFNkbm9vNlg1dzFXc00yOWNCZStnOWpLM1lubnNydXRC?=
 =?utf-8?B?V2REMEl2S0kxVUZIaUJ4MFRmeE9CYlJDejJraDJVSjNTZFp2d3hIZDU4dVhw?=
 =?utf-8?Q?lleG2IdnPip21zQVaK5432HYn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b3cd96d-f420-4aa0-68ab-08dc1b401ab2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 11:48:52.0569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6/Kx08JB9LplbN13+k/So5AvGbWD3hWONeTOYCMnU8fR+MzmEDTlK4nCzk4fb0WYF9wN3sdjSFWUi1UWmB8JXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5847

On 22/01/24 13:27, Vinod Koul wrote:
> On 10-01-24, 15:14, Vijendar Mukunda wrote:
>
> Same comment on patch title
will fix it.
>
>> Refactor amd SoundWire manager device node creation logic and implement generic
>> functions to have a common functionality for SoundWire manager platform device
>> creation, start and exit sequence for both legacy(NO DSP) and SOF stack for AMD
>> platforms. These functions will be invoked from legacy and SOF stack.
>>
>> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>> ---
>>  drivers/soundwire/Makefile        |   2 +-
>>  drivers/soundwire/amd_init.c      | 147 ++++++++++++++++++++++++++++++
>>  drivers/soundwire/amd_init.h      |  13 +++
>>  drivers/soundwire/amd_manager.c   |  16 +---
>>  include/linux/soundwire/sdw_amd.h |  54 ++++++++++-
>>  5 files changed, 218 insertions(+), 14 deletions(-)
>>  create mode 100644 drivers/soundwire/amd_init.c
>>  create mode 100644 drivers/soundwire/amd_init.h
>>
>> diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
>> index 657f5888a77b..e80a2c2cf3e7 100644
>> --- a/drivers/soundwire/Makefile
>> +++ b/drivers/soundwire/Makefile
>> @@ -20,7 +20,7 @@ soundwire-bus-y += irq.o
>>  endif
>>  
>>  #AMD driver
>> -soundwire-amd-y :=	amd_manager.o
>> +soundwire-amd-y := amd_init.o amd_manager.o
>>  obj-$(CONFIG_SOUNDWIRE_AMD) += soundwire-amd.o
>>  
>>  #Cadence Objs
>> diff --git a/drivers/soundwire/amd_init.c b/drivers/soundwire/amd_init.c
>> new file mode 100644
>> index 000000000000..d732ab0bfd59
>> --- /dev/null
>> +++ b/drivers/soundwire/amd_init.c
>> @@ -0,0 +1,147 @@
>> +// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
>> +/*
>> + * SoundWire AMD Manager Initialize routines
>> + *
>> + * Initializes and creates SDW devices based on ACPI and Hardware values
>> + *
>> + * Copyright 2023 Advanced Micro Devices, Inc.
>  2023-24..?
will update.
>
>> + */
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/export.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +
>> +#include "amd_init.h"
>> +
>> +static int sdw_amd_cleanup(struct sdw_amd_ctx *ctx)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < ctx->count; i++) {
>> +		if (!(ctx->link_mask & BIT(i)))
>> +			continue;
>> +		platform_device_unregister(ctx->pdev[i]);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static struct sdw_amd_ctx *sdw_amd_probe_controller(struct sdw_amd_res *res)
>> +{
>> +	struct sdw_amd_ctx *ctx;
>> +	struct acpi_device *adev;
>> +	struct resource *sdw_res;
>> +	struct acp_sdw_pdata sdw_pdata[2];
>> +	struct platform_device_info pdevinfo[2];
>> +	u32 link_mask;
>> +	int count, index;
>> +
>> +	if (!res)
>> +		return NULL;
>> +
>> +	adev = acpi_fetch_acpi_dev(res->handle);
>> +	if (!adev)
>> +		return NULL;
>> +
>> +	if (!res->count)
>> +		return NULL;
>> +
>> +	count = res->count;
>> +	dev_dbg(&adev->dev, "Creating %d SDW Link devices\n", count);
>> +
>> +	/*
>> +	 * we need to alloc/free memory manually and can't use devm:
>> +	 * this routine may be called from a workqueue, and not from
>> +	 * the parent .probe.
>> +	 * If devm_ was used, the memory might never be freed on errors.
>> +	 */
>> +	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
>> +	if (!ctx)
>> +		return NULL;
>> +
>> +	ctx->count = count;
>> +	ctx->link_mask = res->link_mask;
>> +	sdw_res = kzalloc(sizeof(*sdw_res), GFP_KERNEL);
>> +	if (!sdw_res) {
>> +		kfree(ctx);
>> +		return NULL;
>> +	}
>> +	sdw_res->flags = IORESOURCE_MEM;
>> +	sdw_res->start = res->addr;
>> +	sdw_res->end = res->addr + res->reg_range;
>> +	memset(&pdevinfo, 0, sizeof(pdevinfo));
>> +	link_mask = ctx->link_mask;
>> +	for (index = 0; index < count; index++) {
>> +		if (!(link_mask & BIT(index)))
>> +			continue;
>> +
>> +		sdw_pdata[index].instance = index;
>> +		sdw_pdata[index].acp_sdw_lock = res->acp_lock;
>> +		pdevinfo[index].name = "amd_sdw_manager";
>> +		pdevinfo[index].id = index;
>> +		pdevinfo[index].parent = res->parent;
>> +		pdevinfo[index].num_res = 1;
>> +		pdevinfo[index].res = sdw_res;
>> +		pdevinfo[index].data = &sdw_pdata[index];
>> +		pdevinfo[index].size_data = sizeof(struct acp_sdw_pdata);
>> +		pdevinfo[index].fwnode = acpi_fwnode_handle(adev);
>> +		ctx->pdev[index] = platform_device_register_full(&pdevinfo[index]);
>> +		if (IS_ERR(ctx->pdev[index]))
>> +			goto err;
>> +	}
>> +	kfree(sdw_res);
>> +	return ctx;
>> +err:
>> +	while (index--) {
>> +		if (!(link_mask & BIT(index)))
>> +			continue;
>> +
>> +		platform_device_unregister(ctx->pdev[index]);
>> +	}
>> +
>> +	kfree(sdw_res);
>> +	kfree(ctx);
>> +	return NULL;
>> +}
>> +
>> +static int sdw_amd_startup(struct sdw_amd_ctx *ctx)
>> +{
>> +	struct amd_sdw_manager *amd_manager;
>> +	int i, ret;
>> +
>> +	/* Startup SDW Manager devices */
>> +	for (i = 0; i < ctx->count; i++) {
>> +		if (!(ctx->link_mask & BIT(i)))
>> +			continue;
>> +		amd_manager = dev_get_drvdata(&ctx->pdev[i]->dev);
>> +		ret = amd_sdw_manager_start(amd_manager);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +int sdw_amd_probe(struct sdw_amd_res *res, struct sdw_amd_ctx **sdw_ctx)
>> +{
>> +	*sdw_ctx = sdw_amd_probe_controller(res);
>> +	if (!*sdw_ctx)
>> +		return -ENODEV;
>> +
>> +	return sdw_amd_startup(*sdw_ctx);
>> +}
>> +EXPORT_SYMBOL_NS(sdw_amd_probe, SOUNDWIRE_AMD_INIT);
>> +
>> +void sdw_amd_exit(struct sdw_amd_ctx *ctx)
>> +{
>> +	sdw_amd_cleanup(ctx);
>> +	kfree(ctx->ids);
>> +	kfree(ctx);
>> +}
>> +EXPORT_SYMBOL_NS(sdw_amd_exit, SOUNDWIRE_AMD_INIT);
>> +
>> +MODULE_AUTHOR("Vijendar.Mukunda@amd.com");
>> +MODULE_DESCRIPTION("AMD SoundWire Init Library");
>> +MODULE_LICENSE("Dual BSD/GPL");
>> diff --git a/drivers/soundwire/amd_init.h b/drivers/soundwire/amd_init.h
>> new file mode 100644
>> index 000000000000..f710703ffae9
>> --- /dev/null
>> +++ b/drivers/soundwire/amd_init.h
>> @@ -0,0 +1,13 @@
>> +/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
>> +/*
>> + * Copyright (C) 2023 Advanced Micro Devices, Inc. All rights reserved.
>> + */
>> +
>> +#ifndef __AMD_INIT_H
>> +#define __AMD_INIT_H
>> +
>> +#include <linux/soundwire/sdw_amd.h>
>> +
>> +int amd_sdw_manager_start(struct amd_sdw_manager *amd_manager);
>> +
>> +#endif
>> diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
>> index afa2d83b7e69..0fcf8f8545b1 100644
>> --- a/drivers/soundwire/amd_manager.c
>> +++ b/drivers/soundwire/amd_manager.c
>> @@ -19,6 +19,7 @@
>>  #include <sound/pcm_params.h>
>>  #include <sound/soc.h>
>>  #include "bus.h"
>> +#include "amd_init.h"
>>  #include "amd_manager.h"
>>  
>>  #define DRV_NAME "amd_sdw_manager"
>> @@ -864,10 +865,8 @@ static void amd_sdw_irq_thread(struct work_struct *work)
>>  	writel(0x00, amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_0TO7);
>>  }
>>  
>> -static void amd_sdw_probe_work(struct work_struct *work)
>> +int amd_sdw_manager_start(struct amd_sdw_manager *amd_manager)
>>  {
>> -	struct amd_sdw_manager *amd_manager = container_of(work, struct amd_sdw_manager,
>> -							   probe_work);
>>  	struct sdw_master_prop *prop;
>>  	int ret;
>>  
>> @@ -876,11 +875,11 @@ static void amd_sdw_probe_work(struct work_struct *work)
>>  		amd_enable_sdw_pads(amd_manager);
>>  		ret = amd_init_sdw_manager(amd_manager);
>>  		if (ret)
>> -			return;
>> +			return ret;
>>  		amd_enable_sdw_interrupts(amd_manager);
>>  		ret = amd_enable_sdw_manager(amd_manager);
>>  		if (ret)
>> -			return;
>> +			return ret;
>>  		amd_sdw_set_frameshape(amd_manager);
>>  	}
>>  	/* Enable runtime PM */
>> @@ -889,6 +888,7 @@ static void amd_sdw_probe_work(struct work_struct *work)
>>  	pm_runtime_mark_last_busy(amd_manager->dev);
>>  	pm_runtime_set_active(amd_manager->dev);
>>  	pm_runtime_enable(amd_manager->dev);
>> +	return 0;
>>  }
>>  
>>  static int amd_sdw_manager_probe(struct platform_device *pdev)
>> @@ -964,11 +964,6 @@ static int amd_sdw_manager_probe(struct platform_device *pdev)
>>  	dev_set_drvdata(dev, amd_manager);
>>  	INIT_WORK(&amd_manager->amd_sdw_irq_thread, amd_sdw_irq_thread);
>>  	INIT_WORK(&amd_manager->amd_sdw_work, amd_sdw_update_slave_status_work);
>> -	INIT_WORK(&amd_manager->probe_work, amd_sdw_probe_work);
>> -	/*
>> -	 * Instead of having lengthy probe sequence, use deferred probe.
>> -	 */
>> -	schedule_work(&amd_manager->probe_work);
>>  	return 0;
>>  }
>>  
>> @@ -978,7 +973,6 @@ static void amd_sdw_manager_remove(struct platform_device *pdev)
>>  	int ret;
>>  
>>  	pm_runtime_disable(&pdev->dev);
>> -	cancel_work_sync(&amd_manager->probe_work);
>>  	amd_disable_sdw_interrupts(amd_manager);
>>  	sdw_bus_master_delete(&amd_manager->bus);
>>  	ret = amd_disable_sdw_manager(amd_manager);
>> diff --git a/include/linux/soundwire/sdw_amd.h b/include/linux/soundwire/sdw_amd.h
>> index 56b4117c087a..1e5ff4c46365 100644
>> --- a/include/linux/soundwire/sdw_amd.h
>> +++ b/include/linux/soundwire/sdw_amd.h
>> @@ -26,6 +26,7 @@
>>  #define AMD_SDW_POWER_OFF_MODE		2
>>  #define ACP_SDW0	0
>>  #define ACP_SDW1	1
>> +#define AMD_SDW_MAX_MANAGER_COUNT	2
>>  
>>  struct acp_sdw_pdata {
>>  	u16 instance;
>> @@ -63,7 +64,6 @@ struct sdw_amd_dai_runtime {
>>   * @reg_mask: register mask structure per manager instance
>>   * @amd_sdw_irq_thread: SoundWire manager irq workqueue
>>   * @amd_sdw_work: peripheral status work queue
>> - * @probe_work: SoundWire manager probe workqueue
>>   * @acp_sdw_lock: mutex to protect acp share register access
>>   * @status: peripheral devices status array
>>   * @num_din_ports: number of input ports
>> @@ -87,7 +87,6 @@ struct amd_sdw_manager {
>>  	struct sdw_manager_reg_mask *reg_mask;
>>  	struct work_struct amd_sdw_irq_thread;
>>  	struct work_struct amd_sdw_work;
>> -	struct work_struct probe_work;
>>  	/* mutex to protect acp common register access */
>>  	struct mutex *acp_sdw_lock;
>>  
>> @@ -120,5 +119,56 @@ struct sdw_amd_acpi_info {
>>  	u32 link_mask;
>>  };
>>  
>> +/**
>> + * struct sdw_amd_ctx - context allocated by the controller
>> + * driver probe
> missing a blank line there
Will add it.
>
>> + * @count: link count
>> + * @num_slaves: total number of devices exposed across all enabled links
> should this be not per link?
No, this will be total count of peripheral devices across all the links.
This variable will be used in  snd_soc_acpi_sdw_link_slaves_found()
API.
>
>> + * @link_mask: bit-wise mask listing SoundWire links reported by the
>> + * Controller
>> + * @ids: array of slave_id, representing Slaves exposed across all enabled
>> + * links
> this does not tell us which device to expect in which link..?
sdw_extended_slave_id structure contains information about link id as well.
>
>> + * @pdev: platform device structure
>> + */
>> +struct sdw_amd_ctx {
>> +	int count;
>> +	int num_slaves;
>> +	u32 link_mask;
>> +	struct sdw_extended_slave_id *ids;
>> +	struct platform_device *pdev[AMD_SDW_MAX_MANAGER_COUNT];
>> +};
>> +
>> +/**
>> + * struct sdw_amd_res - Soundwire AMD global resource structure,
>> + * typically populated by the DSP driver/Legacy driver
>> + *
>> + * @addr: acp pci device resource start address
>> + * @reg_range: ACP register range
>> + * @link_mask: bit-wise mask listing links selected by the DSP driver/
>> + * legacy driver
>> + * @count: link count
>> + * @mmio_base: mmio base of SoundWire registers
>> + * @handle: ACPI parent handle
>> + * @parent: parent device
>> + * @dev: device implementing hwparams and free callbacks
>> + * @acp_lock: mutex protecting acp common registers access
>> + */
>> +struct sdw_amd_res {
>> +	u32 addr;
>> +	u32 reg_range;
>> +	u32 link_mask;
>> +	int count;
>> +	void __iomem *mmio_base;
>> +	acpi_handle handle;
>> +	struct device *parent;
>> +	struct device *dev;
>> +	/* use to protect acp common registers access */
>> +	struct mutex *acp_lock;
>> +};
>> +
>> +int sdw_amd_probe(struct sdw_amd_res *res, struct sdw_amd_ctx **ctx);
>> +
>> +void sdw_amd_exit(struct sdw_amd_ctx *ctx);
>> +
>>  int amd_sdw_scan_controller(struct sdw_amd_acpi_info *info);
>>  #endif
>> -- 
>> 2.34.1


