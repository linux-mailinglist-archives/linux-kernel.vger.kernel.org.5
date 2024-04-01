Return-Path: <linux-kernel+bounces-126918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D4E894471
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 466191C21226
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840A64D9E9;
	Mon,  1 Apr 2024 17:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="ah6Q5Gpl"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2101.outbound.protection.outlook.com [40.107.223.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7784AEE4;
	Mon,  1 Apr 2024 17:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711993529; cv=fail; b=f8Yk/Pwp9zcsCYROhBa2f32yEyPkLWIIU/cZy9zIbhPswKAhmV9DliCdfNPXKnBQ0GhbdT8tIy37/ZtK68cPaLAM9pMpN6rQJDaqGuIIwNMTwoLWYVULbmICAcXQ70PL0puacyzr+uM1XtC6N1gqSJ5rw0zFZ8aJkZcgt1EU2OI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711993529; c=relaxed/simple;
	bh=1sPz1hgsN/8WE4ziNYREr2taxnwQrmv7MkiSBN4AUYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QvbUeKYnijDPBLbPjH56m8gB+UkXwTXvWwWzSgr8i3XK51qxNMs6ow+8DEsW2sH64Erx9N6UJdURo3PSIYbH7bDWnCYD0URRwh9ld2odF2d0UsWUsZMjCjEqCXlBvQi9ZJbzqw1H89P5qBRd8duKAdnaGs6EicdwvXtjewwRNao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=ah6Q5Gpl; arc=fail smtp.client-ip=40.107.223.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IfRFLF6szmGSKFZbXZSNrscVFnWIFQm3hNmOdQDTKoF+a/r0Oo3fbDNV0ilPNvVevBTTlTKGR1NTGbp27yOMYtW8UnT5rTIwckx/J5rtEJreOYFLTCC6IzWWF7f7w3LSxY7boCB7d0x8Y/PMzN3sckKqjJ/OvqnPtesgaXVMQORNMr2PFkDFODgfOtikNbr1HvcuYFg0IKaAB6V9rLhjFztC0ibvuA322EKoJzueEXECyk4/L/jsZdSU3n8MuNpF+nZlYL7cDhIa7lxJuBFBkX5ggDluxnHgA1mKJF0UoCajwzYsGz0+XLPaNYEGmkq612LwUPLT6aiAyTRI7TBVoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u9P+mKPPvWzWcP5lU7NAlyr2zYrEyuuexYePcACY4Iw=;
 b=SFHI0WqhpaHcAz7bTQeJpEnHs5vONjZm1thEN+JAYLB08UtDjZlLrmrN68AZs4FmmMTTovpGnY6HS8dv151flb/ENA0EcJB/d1RpGWnjNFQVmCpIWHW8pJm7ihaFUSEGwFhbBURZNaukvgBMlJnjet5YsOdIuJbl2VDsvBUS1XZkAlQsBxXouW4maoiE2KfIJJfUWfDfhUjEtfKVvBHb6G7f6KltGpFxUCrsJXgfqBNkI9fPkgRoy6OrY1e2hQnOxrwQWnGmF7xdN4QvrNzrNn9nIu3Pufbzfwp8SK/D0B4odccRSPa/waB4EqoCnxgTI3Y0+itzrIc1Fq2+giBs3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9P+mKPPvWzWcP5lU7NAlyr2zYrEyuuexYePcACY4Iw=;
 b=ah6Q5GpldHzz4kKTflrVuSrJuN9tLLSAnor17h67ScCuO4CNQFJdf8UECnWOn5zqAlU1t0oZSapeLR99hBEB3/OPI8ErXaIUWfMxiG3YcOxqQ1TyHcAnlNvHbSW7cwqL/T8O74A5wD4giGthG2Xeh59e1BKRMcuoyZ136f4NFnk=
Received: from MW4PR01MB6498.prod.exchangelabs.com (2603:10b6:303:79::19) by
 SJ2PR01MB8403.prod.exchangelabs.com (2603:10b6:a03:547::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Mon, 1 Apr 2024 17:45:22 +0000
Received: from MW4PR01MB6498.prod.exchangelabs.com
 ([fe80::4fc3:132:87ac:c13b]) by MW4PR01MB6498.prod.exchangelabs.com
 ([fe80::4fc3:132:87ac:c13b%5]) with mapi id 15.20.7409.042; Mon, 1 Apr 2024
 17:45:22 +0000
Date: Mon, 1 Apr 2024 10:45:18 -0700
From: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Jarred White <jarredwhite@linux.microsoft.com>, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH v1 1/1] ACPI: CPPC: Fix access width used for PCC
 registers
Message-ID: <m2m7qytrlhdvht7ro6hee2msi2bd5j733yagdakyjfxi2su46i@nj77lj3ulqp7>
References: <20240329220054.1205596-1-vanshikonda@os.amperecomputing.com>
 <eecf5b00-0b61-46a8-82d9-a3c113f2d956@linux.microsoft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <eecf5b00-0b61-46a8-82d9-a3c113f2d956@linux.microsoft.com>
X-ClientProxiedBy: CH0PR03CA0099.namprd03.prod.outlook.com
 (2603:10b6:610:cd::14) To MW4PR01MB6498.prod.exchangelabs.com
 (2603:10b6:303:79::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6498:EE_|SJ2PR01MB8403:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nMinlbpdJjWVA1mRTC0nAnFszbjWyj2aZAxO1+CzaQZ5q+Nq3rm4u9UFF2ThJpJ0Bc9wkPxuySMX/q5gfmpRWEmbvG31Ty3aMbX0RHyXumaF7cL7cPOWWAIixjH30+dUYIJ/TOlYdEdNMHftPqUgfFp+lcq1n7SS8d2ATvfvXjf23ySeVhAiEDnr3ePy+580UwKeqfHS36cEqCX0aGgdqSmyx+S/JV8R2/Laxf7qhSYE10ZFLZvbJY6nZTiwJsB0CtxKumwo9DOMC5Skf0gmFf6nPmbFqZBdrnIDOGLfF4fpW+VAvBDifLdj+MOM1/bUSIb0Fwbl1aqC5xfhwT+alVc2SmIia50vb2PXlYChOtYGgexYCMdoveD5vz5jWbDKK0v5zcXmTiai7ias+BaQMpwF66le+Mjkj9MnBVscQT//+6hCm3epqKGM463y8EZXUciJEZgAM432lstvpPOKLCbFBptGe3HvAJkYxc6PMTEQTJ1oABQpc3/xCxd5icMmvTPvtFwl25aoXVGGkYE0UgyqzLsRXxptYjFcP/SNVlI42rVL/ibDSK3U6ad6v0I7c1rlBZezlnmVOXfS3s0hT82UQExwS0K7Tgh44BbdKntWw/EAQDaY1qWzwFraIPe7aOLfnPLdRqzYsLHqkp0pRqs6v5gBHtKZ9naDn8srVsE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6498.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8EPFjXF02EVHOdy+zsYvg2qPz2OsAuUBMNDDb3QmQiwA/q4/LWfKHIVTBI34?=
 =?us-ascii?Q?tZvN6e6JD0Tvha4S6WCxL29a0dK8nbBLswE61xpCGiIyPyAN+Km/ujFwDC5K?=
 =?us-ascii?Q?Eryx7d4akvlb/YSq+l/B/xyYggqfVmT4HMwjXaCsPzd4n4uPfRVVnO1S8k+g?=
 =?us-ascii?Q?fHL0vL1NDCjVkEKFCNXn0EMAtBJqxtbT+1uTudDk9YwbIy2dfeR4gfUi9nAW?=
 =?us-ascii?Q?TFxDKtIDXqqlpFHeyltetFcm6lvuBmDFAjQXuIzd3Q/bKR/oWBGnr/UiZZsS?=
 =?us-ascii?Q?eccy5vnjbtf+tCn77PL74gPpRwSkeJ5aWeBKHlfyTL7T9wDC9kAyyxcPshL+?=
 =?us-ascii?Q?hO0fIHuwmDk06UG/dlmv13YrU7njDWJk0noW0YiBTac2FeWB7sBvOqllDbjM?=
 =?us-ascii?Q?bHEUYx/VSkZq4Q1MAnwTmz0gR/hQ+17xD35h1aWpBXqc4Ox5zE3odcm1iAeG?=
 =?us-ascii?Q?RF/s0qTxgBR7OAhIIb0wv2SoXMIOS70pMIZ+AuDDqqgk5apK70NkXMZV5UE7?=
 =?us-ascii?Q?GeX2tLn7tJaOZGBcAODMSi0JAXwPP4qEEHpSb/1oKwuwItP6u/1kmwDJC7K/?=
 =?us-ascii?Q?/mQfFTqa/zLFMa8TYPPT9cNomWx8zI05VuOKyYIxVqBUtEidCBiu5jPUaMqH?=
 =?us-ascii?Q?/mCXCcRAXVXUo5JNZBJGNtHkrICRQEJxxg9DK05MZjimxrm7SVr4G5M7YWlr?=
 =?us-ascii?Q?AxYkOGNrqvH46PuLd40QWRvQ2gLM7mug3L1Tz9e96t0O6s2yI9hVFwcZwDiw?=
 =?us-ascii?Q?j6ipLQrYDsxGpU2w2KqqxdnEQzjZ6wilYWTw8gfmboNocn6anh17mDjOpvYF?=
 =?us-ascii?Q?e+TkKNQu8JE1g2n//1C8ZniJsJ7lzZxnxmyxYARbmxRQd3ypcT2YGJ/p5Tzk?=
 =?us-ascii?Q?NKFfZl37tEBk9T+vqr33OVs1d7u1mtLo29EtRoQFV6BA1nbJVBuCd9a0e+xX?=
 =?us-ascii?Q?FGFpZIWFJeTjdModIQ7iw8WkPCqfK7dt4zL29Rro4SZAFo7u1a0bMy9CoZDQ?=
 =?us-ascii?Q?Ebw6HxLesPONKPumrERz6/B6ZPnLfaFfTUbbBzD0CG9NtykoqgUO+r9yBCCG?=
 =?us-ascii?Q?vsuM9P3J6sYZTKCY7uFENQRPD145RllJ3PNVVxMFncks8bZA5ktzoBqdWsD2?=
 =?us-ascii?Q?el/8s99P+1d8U+3vG4N2dnL4j/89zs9PC5sSbC5HY7AOis1dVadU3ly82eLe?=
 =?us-ascii?Q?M+tjy80NAzbNhG4PUUCgj16omymlpBAWuSelGamAyimQ1U6CQT2bm/ei+VVF?=
 =?us-ascii?Q?a9zX+SxNGEZF3PB6zqsnkCLEovNVBexE+UcgsDNv8SkyEDlqhunqq9t8cEpj?=
 =?us-ascii?Q?9DSoE7p9HxHj3NOzUxGOwLHWfIGKSJZjVnS51v25tNloxwrI512zY1cBIgRd?=
 =?us-ascii?Q?+9iL3wuSt+/hcMOtyiCcpnq3cqh20FXa46wfcH02GExKw2zq/1ka5poD0Rop?=
 =?us-ascii?Q?19jPkazxBN/PyiMK8YebXPgGtbfeoRkxQg5ez6HCwNIfl3MLT9oDWVag/Cqc?=
 =?us-ascii?Q?tLOCQd1qhXUWYi/vTDzasL7rt910yY/uuQgiRYFXrgaLJfElDznrHAtOkFeE?=
 =?us-ascii?Q?pvRMsFyzz3D3GQnR9JPuw4BR8gfw0mPGN9r121yaUvKs0ztpsadA7qI1Fouu?=
 =?us-ascii?Q?v4WreMgxed2NQqh3KLq9Xyg=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32f507a4-6ba3-4e08-c2d5-08dc52738148
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6498.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 17:45:22.5178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JkLpPV8Q6I1zSTZ+ETzHaB9Hnj0tsmNHfP5IeH7eW+8KVMNT0+xXSdFJaIiOAZo3w+oycwV5RgwEzWYsiy7Hoyo/hilMwCJWnwNe6XrxEyzpYnr8wlb3OQMM8HSG3sXu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8403

On Mon, Apr 01, 2024 at 09:48:28AM -0700, Easwar Hariharan wrote:
>Hi Vanshi,
>
>Thanks for testing and catching this. One comment below, but Jarred is OOF for a couple days so
>we'll get back again after testing on our platform.
>
>On 3/29/2024 3:00 PM, Vanshidhar Konda wrote:
>> Commit 2f4a4d63a193 ("ACPI: CPPC: Use access_width over bit_width for
>> system memory accesses") modified cpc_read/cpc_write to use access_width to
>> read CPC registers. For PCC registers the access width field in the ACPI
>> register macro specifies the PCC subspace id. For non-zero PCC subspace id
>> the access width is incorrectly treated as access width. This causes errors
>> when reading from PCC registers in the CPPC driver.
>>
>> For PCC registers base the size of read/write on the bit width field.
>> The debug message in cpc_read/cpc_write is updated to print relevant
>> information for the address space type used to read the register.
>>
>> Fixes: 2f4a4d63a193 ("ACPI: CPPC: Use access_width over bit_width for system memory accesses")
>> Signed-off-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
>> ---
>>
>> When testing v6.9-rc1 kernel on AmpereOne system dmesg showed that
>> cpufreq policy had failed to initialize on some cores during boot because
>> cpufreq->get() always returned 0. On this system CPPC registers are in PCC
>> subspace index 2 that are 32 bits wide. With this patch the CPPC driver
>> interpreted the access width field as 16 bits, causing the register read
>> to roll over too quickly to provide valid values during frequency
>> computation.
>>
>>  drivers/acpi/cppc_acpi.c | 45 +++++++++++++++++++++++++++++-----------
>>  1 file changed, 33 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index 4bfbe55553f4..23d16a1ee878 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -1002,14 +1002,14 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
>>  	}
>>
>>  	*val = 0;
>> +	size = GET_BIT_WIDTH(reg);
>>
>>  	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
>> -		u32 width = GET_BIT_WIDTH(reg);
>>  		u32 val_u32;
>>  		acpi_status status;
>>
>>  		status = acpi_os_read_port((acpi_io_address)reg->address,
>> -					   &val_u32, width);
>> +					   &val_u32, size);
>>  		if (ACPI_FAILURE(status)) {
>>  			pr_debug("Error: Failed to read SystemIO port %llx\n",
>>  				 reg->address);
>> @@ -1018,8 +1018,15 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
>>
>>  		*val = val_u32;
>>  		return 0;
>> -	} else if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM && pcc_ss_id >= 0)
>> +	} else if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM && pcc_ss_id >= 0) {
>> +		/*
>> +		 * For registers in PCC space, the register size is determined
>> +		 * by the bit width field; the access size is used to indicate
>> +		 * the PCC subspace id.
>> +		 */
>> +		size = reg->bit_width;
>>  		vaddr = GET_PCC_VADDR(reg->address, pcc_ss_id);
>> +	}
>>  	else if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
>>  		vaddr = reg_res->sys_mem_vaddr;
>>  	else if (reg->space_id == ACPI_ADR_SPACE_FIXED_HARDWARE)
>> @@ -1028,8 +1035,6 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
>>  		return acpi_os_read_memory((acpi_physical_address)reg->address,
>>  				val, reg->bit_width);
>>
>> -	size = GET_BIT_WIDTH(reg);
>> -
>>  	switch (size) {
>>  	case 8:
>>  		*val = readb_relaxed(vaddr);
>> @@ -1044,8 +1049,13 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
>>  		*val = readq_relaxed(vaddr);
>>  		break;
>>  	default:
>> -		pr_debug("Error: Cannot read %u bit width from PCC for ss: %d\n",
>> +		if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
>> +			pr_debug("Error: Cannot read %u width from for system memory: 0x%llx\n",
>> +				reg->bit_width, reg->address);
>> +		} else if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM) {
>> +			pr_debug("Error: Cannot read %u bit width to PCC for ss: %d\n",
>>  			 reg->bit_width, pcc_ss_id);
>> +		}
>>  		return -EFAULT;
>>  	}
>>
>> @@ -1063,12 +1073,13 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
>>  	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
>>  	struct cpc_reg *reg = &reg_res->cpc_entry.reg;
>>
>> +	size = GET_BIT_WIDTH(reg);
>> +
>>  	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
>> -		u32 width = GET_BIT_WIDTH(reg);
>>  		acpi_status status;
>>
>>  		status = acpi_os_write_port((acpi_io_address)reg->address,
>> -					    (u32)val, width);
>> +					    (u32)val, size);
>>  		if (ACPI_FAILURE(status)) {
>>  			pr_debug("Error: Failed to write SystemIO port %llx\n",
>>  				 reg->address);
>> @@ -1076,8 +1087,15 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
>>  		}
>>
>>  		return 0;
>> -	} else if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM && pcc_ss_id >= 0)
>> +	} else if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM && pcc_ss_id >= 0) {
>> +		/*
>> +		 * For registers in PCC space, the register size is determined
>> +		 * by the bit width field; the access size is used to indicate
>> +		 * the PCC subspace id.
>> +		 */
>> +		size = reg->bit_width;
>>  		vaddr = GET_PCC_VADDR(reg->address, pcc_ss_id);
>> +	}
>>  	else if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
>>  		vaddr = reg_res->sys_mem_vaddr;
>>  	else if (reg->space_id == ACPI_ADR_SPACE_FIXED_HARDWARE)
>> @@ -1086,8 +1104,6 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
>>  		return acpi_os_write_memory((acpi_physical_address)reg->address,
>>  				val, reg->bit_width);
>>
>> -	size = GET_BIT_WIDTH(reg);
>> -
>>  	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
>>  		val = MASK_VAL(reg, val);
>>
>> @@ -1105,8 +1121,13 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
>>  		writeq_relaxed(val, vaddr);
>>  		break;
>>  	default:
>> -		pr_debug("Error: Cannot write %u bit width to PCC for ss: %d\n",
>> +		if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
>> +			pr_debug("Error: Cannot write %u width from for system memory: 0x%llx\n",
>> +				reg->bit_width, reg->address);
>                                ^^^^^^^^^^^^^^
>Shouldn't this be size = GET_BIT_WIDTH(reg) instead of reg->bit_width? I think this is falling back to the
>previous behavior where it assumes access_width was not provided by the platform firmware.
>

That makes sense. I'll replace this in both read/write for the
SPACE_SYSTEM_MEMORY in the next version. I can send the next version
after you've a chance to test this.

Thanks,
Vanshi

>> +		} else if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM) {
>> +			pr_debug("Error: Cannot write %u bit width to PCC for ss: %d\n",
>>  			 reg->bit_width, pcc_ss_id);
>> +		}
>>  		ret_val = -EFAULT;
>>  		break;
>>  	}
>
>
>Thanks,
>Easwar

