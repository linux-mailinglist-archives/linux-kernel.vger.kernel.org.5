Return-Path: <linux-kernel+bounces-159477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 303508B2F2C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 05:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC57F1F23060
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 03:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CBD78C77;
	Fri, 26 Apr 2024 03:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="djSuYH4h"
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2033.outbound.protection.outlook.com [40.92.102.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD2478B4E;
	Fri, 26 Apr 2024 03:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.102.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714102856; cv=fail; b=dhCGNnKAvf+8z2AkeZKcnbqKUL+ZhcqGeQQdYa8j/7USrJeBN23fIMFhPxStZuymQRLVlc2ha1SGDECbortgdi7qUvbhu3WkdOBTZRdx9lf+MiqJs8NfLZh9z6V/W9VxNxOqrNPkttg4pbOqaeLpruOqtFUr5Ua9jqvKe32WFVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714102856; c=relaxed/simple;
	bh=XxQeFUOVuQYTxls9WrpPmBhE1EtvMAd+DyqXs/7zas4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j2Pno88dYm/dpu/4nfDM9ocIwyGcZg2mTm6TjMtqbiWUjbnesAYmdbXJBRtMzUGZ6hW7oYViOSb/U4cAblgCUaeqMAAqZu1EV1eJgFwE0HNpLuFaEXMqfMFpp5OD/5kUJ1gkn4G0lPwI77p9eOojlCraYaE3lAuwaG+6GgKfPzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=djSuYH4h; arc=fail smtp.client-ip=40.92.102.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zm8EX+osk6sNVufK5BTa0izhKDA1nq4sAGoACc58gmfCTHAb0YKoy5NhwSThQe79rfMPpS7T+AzqPeG1rkYVeOmglpOoCZT3WurkFqWd4DVwCJ9itsGIg78AWuW2o/e6lQ7bjJacsabugfhq5B2KV1OA+6YPVDerslQqJUXgBp3PAK8wiMosXPh/PRjtFj8QVEjkZNGbzyknqwbR3wVwnJnQc++B99dflooDmBxqfUORVsd1zw3kB9oTVvGvVMYTwN00hl8WEh45leAUysGN8jTS4gcDgkHP/YLPX6Crc1mw4rwpZ4l1qiXpIAjQyVWQdaRE0yH8UDGvCYQ/iFIttQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jCBDpNh8NMTS19y1EMp879tzSnvNOXaMFqmDcXI5/5Y=;
 b=AnqLskIoowwSc9bmRFkEStDUGT3w89YLy1bN02GGzhkaB+z6hcX8f9LxzBkwpwmYkxsihn3TNzm7IrjhRU8sM+yGgHUCpKCnfMw82ihFrzczhKVrXoUUZVqMH/Ee4qMrUFTrf+WrU2tWBWbl9wdFtbwHBrXKsNmGhzB9AuGMUk3HDK8tZXf1WeSKlPYq2sB1pBULkaxHAglPbaG0mj5qBkqsofRHY0xVJsOcrG7oaxI/wEnU/BDJQE+1ho1D9AlypIAZU5qBWhEd8Z176nDBf1/c+pW28qulOYLMZQ9+tmd/JsaJ9t4I1PeNOZ64Of8y6GjklbAj6pUfLl03RdKZyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jCBDpNh8NMTS19y1EMp879tzSnvNOXaMFqmDcXI5/5Y=;
 b=djSuYH4htqH6sO1y/15oHY5L8WEUuBV0ChZ785Xtir/qtC2z5/jKzId+9jgaTQCYWu2tzSiBPAvRNsJKXcsVwaw6gxyTgBq+SL0nm9nITRXzA3jjel8e+opknF2FV55MB9NwgYe5F6KS1zUu9HXmgTjg2ipyogERBVuChIzr6YDM1wh+iIpAc5e1Edz9V4E3ITK42ASvQdAhm7QjRxcWUB3y9xk/46z+r8gR/3Z99fUrXYLAIaT6yNyLHEipzL5/sYHJqMopuK9RSRrJlacmU8q3u/DK03ZYsYkH3B4o5f3hEF4Oj3oc49+1UF7Y8jo4M5RR5zkVgVyrt7FPo3feZQ==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by MA0P287MB1575.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:107::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 03:40:46 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::664:2ecc:c36:1f2c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::664:2ecc:c36:1f2c%3]) with mapi id 15.20.7519.021; Fri, 26 Apr 2024
 03:40:46 +0000
Message-ID:
 <MA0P287MB28225D0F3AF2B0E691C66F66FE162@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Fri, 26 Apr 2024 11:40:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 0/5] riscv: sophgo: add clock support for sg2042
To: Chen Wang <unicornxw@gmail.com>, aou@eecs.berkeley.edu,
 chao.wei@sophgo.com, conor@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 mturquette@baylibre.com, palmer@dabbelt.com, paul.walmsley@sifive.com,
 richardcochran@gmail.com, robh+dt@kernel.org, sboyd@kernel.org,
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com, guoren@kernel.org,
 jszhang@kernel.org, inochiama@outlook.com, samuel.holland@sifive.com
References: <cover.1714101547.git.unicorn_wang@outlook.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <cover.1714101547.git.unicorn_wang@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [NA1UBG4LjZZJG/laId1+ujHsZtJaztHW]
X-ClientProxiedBy: SI2PR06CA0018.apcprd06.prod.outlook.com
 (2603:1096:4:186::8) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <077e5916-f53e-415c-a8b3-ee8f88569687@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|MA0P287MB1575:EE_
X-MS-Office365-Filtering-Correlation-Id: e252ada7-e033-4e73-33ef-08dc65a2a7f5
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZA5ASY+p5ZDjsHoXlVbzcQY82mKGPzY68qrqjcwV6tGsw+4S0IcnUlg09ZQdBE2aPuTz5qRTc/XtxQbu57kkgT92a+ONIu+J33w/Y9q3lOR8nYJU/Vc3o9MsTKLmXYO+VL3N0VvDLU+jjOovkf1zpeeaDmUX/dU3d/M2T9LGis+dOBIfBTgpy89t9SsfhsE0HxMK5xrTyX7OWOK2pFs5jjLi6vm+OOeKH7D3TO46g2RG8ffuP0vZcriiI6VGLZbSKr0j1gAP10056G/8YFVz+NXn3OMic2e4jn5Up+p2AmN4KpDKhuzC/a+itJTOSjRRb6nsjZP8L1ia4sU1RJhZ37x5+WSCuQtxGvO2IlSUqBbgnML+wZMCECKTGj5yaZIIRMi4jTIJkqlCm+U8V1K7TDGXJ+bUl97ffFZu3eWe/QLOcRo92oqpG3G/LT2jk0BAT1zsV/mve0IIchZ4TWfKeG5Hxl3rwCKc/7RMOpR/zoWojTTmJtiDhnJBFFNfeaPe03HHPoyrw/M2w8S8vHUf+HtSzwkuOpc2Jka8mCX5OfynkgNq+uYVX2ZwdSXdsKDLa1yFUAGdd4mzXIvxbQITSurbeyfIYs2gmX+ioDpwJoB5Jsyoto28IAj3NNCrIgOM9mgBv5E3cAC8zYzPW85uqJmtoG9ex0MGUbv80ucXYm3FOtSObfgaSj3yqwG5TRDSrbMBmeRYEN4gT1+/kVKZENsv192hoLqaqkm2pgR/8/U=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YllZOG43VTlWeTcvL0o1SXBzUTVESjdwOVlHRXk0UmRwUC94ZS9xWnArQWFw?=
 =?utf-8?B?bXlqdTUyclArY2orazJNdkNoampWUmp3Qzg4SVV3N3ZvMDRiTlBPQ3Vyd2tJ?=
 =?utf-8?B?ZExSbGRVemtLR2d0a0U0U1k4enVWRVdGczRwdk5naHp4S0pTYUlidTVlSWhv?=
 =?utf-8?B?d2RMVWVYSVpSeDVZdnlaei9iVUExaURiQnBhVW96UnU3akdqZXorbHFKSEc2?=
 =?utf-8?B?SDZBZXRweHZOK0VsVzVvVmpoQWtxeHJoWTFoY0M4NnlhdGFrek5qU2c2MXFI?=
 =?utf-8?B?YjVpMlhHcUc3V0tCU1lGSXBwZnJoL2x5UElFamxwUGtRQXZ3K3hpenc5ZVVT?=
 =?utf-8?B?d0FqaHZjRzAzbU5uTzNPTS9xUUYxbGxYRVhBOU1nTTZUdm1zcEpEWUd3VGUz?=
 =?utf-8?B?U2Z5VjhKcmpYdWN0aEVUTU9Pa3QzdnZ1Mk5QaHhCSXlLQjJidFNuRHZDbHdy?=
 =?utf-8?B?ZnFlTHVCWDhzRTFNY2QzUGtpL294MnBWMkhXWGJnRHZoNnJQcnZzdGhaTmx5?=
 =?utf-8?B?UzhyN282eS92eXl5SW9VMy8xbUpkMmhJdXE5c2l3Qnd0N091THhwY3ZyeUtF?=
 =?utf-8?B?bTBDTitoVDhaaUxkNG0xVmhaY1c2dysxeHgzenpoaFRURWgwZHZkWjRIcFNh?=
 =?utf-8?B?U2x2SmZxZ2g4dzlsVVdqVzNDYzZwNmJ5anpkR2ora1JXdXlTc0g5amFkWkVV?=
 =?utf-8?B?YnNVSDJucEx0dzZxTVdYRmhzU3ZiN0FwbmxFaG1KSmlpWVYvNW5WUDBZR2FX?=
 =?utf-8?B?aXBvaDlYVytvdW9xYlRkN0tCT0R5L0RiekFhVGlaUnFGaXVMY1hEcTBsWUtq?=
 =?utf-8?B?bmt2N2tSMTVEOUpqSHVweHdBTUFoaHRPY21vQ2pQanJQUE9Fclh5SmZaYk02?=
 =?utf-8?B?Q29PN2dBNnZBcnAwSWw4M3h1RlNlQnpSSGhOSlFjN2NjVUE4OVJjVVBHN1I4?=
 =?utf-8?B?dTBvTmZPdHRFSW8vdWJGckxGQTFJUkJhZ0E4cDkwZkptL0FIMFFLVDBvb3ZZ?=
 =?utf-8?B?REtDY0lwd0hVQ1QxSEhMY1M3NUxkakRaSWtzcnBHWXRFYUFUMVlCTEpzN3BB?=
 =?utf-8?B?dEdPaFlZTi90WmdiYVdXS0Z4Ym9MOFJxZ1ZEZmFTei9QSDEwK2xNdzg4bnRo?=
 =?utf-8?B?cSs1dnZIMDhIVFg1bVZKaEIyK3RMOHlsVXpaNnhkL1FveWJNK0t1UG1LMi9m?=
 =?utf-8?B?S2pSWktKYkxZSXlmYms0T01KblJVTXdmRjFWMzdYalhNTnUxa3JEOFNBYnIv?=
 =?utf-8?B?Y2FmVTJZWDI3d2Rta0krck9xYUdmVk96aGpnRGoyaHJxejdad3BhbGhSQ0kz?=
 =?utf-8?B?SDR1d0kvTFd0bjA4d0JDc2REV25mZ09xZnVlSHZQRlpjM0NMbllHVXRTQ0lt?=
 =?utf-8?B?TDFDeWRPbll6Sm85NlhPK3Y5ODFNdExRWlVxOUFDaFN5Mk1SRXhFdERmRUhI?=
 =?utf-8?B?c2xGMXFCQ0Fwc2tjRWxhV1IxS05RWml1R2VHUExhdlFOa0dsOUE1YWJGZUdB?=
 =?utf-8?B?aU9sOFNnSHQ3Z0c0L3A4a3JZK1RpSnB5NlpDVVVRUWNNNjB5bG1QOVIvaC9T?=
 =?utf-8?B?Ry85aGZrNWVkdm5xSWdISG5XbmRsK3JhTjVyRHlDcEpzZm53dVFJZERtL0lJ?=
 =?utf-8?B?emF2RHI1dis3NmpGVWF0WDh6ZXhSTnNiNWZ3WWRVcmw0WTkvbGNOU0NhVENz?=
 =?utf-8?Q?uKtYyiRA7Oa+1w//h5zi?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e252ada7-e033-4e73-33ef-08dc65a2a7f5
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 03:40:45.8972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB1575

Hi,  Rob Herring & Guo Ren,

For this version, I updated bindings. Due to the change is minor(just 
add one clock-names property), so I reserve your "Reviewed-by:". Any 
question please feel free let me know.

Thanks,

Chen

On 2024/4/26 11:32, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
>
> This series adds clock controller support for sophgo sg2042.
>
> Thanks,
> Chen
>
> ---
>
> Changes in v15:
>
>    The patch series is based on v6.9-rc5.
>
>    Improved the dirvier code as per 3rd review comments from Stephen Boyd.
>    - Converted all parents described by strings to use clk_parent_data or
>      clk_hw directly.
>    - Just use struct clk_init_data::parent_hws when only have a clk_hw.
>    - Removed extra cleanup when use devm.
>    - Some misc code improvements.
>
> Changes in v14:
>
>    The patch series is based on v6.9-rc1. You can simply review or test the
>    patches at the link [15].
>
>    Improved the dirvier code as per 2nd review comments from Stephen Boyd.
>    - Inline the header file into source file.
>    - Use devm_xxx functions for pll/div/gate registeration.
>    - Use clk_parent_data for mux clocks initialization.
>    - Use u32 for registers readl/writel.
>    - Use devm_platform_ioremap_resource instead of devm_of_iomap.
>    - Cleanup some dead code and add definitions for some magic numbers.
>    - Add include files missed.
>    - Use kernel-doc to improve comments for some structure and functions.
>    - Other misc code cleanup work as per input from reviewers.
>
> Changes in v13:
>
>    The patch series is based on v6.9-rc1. You can simply review or test the
>    patches at the link [14].
>
>    Just added a minor fix for clk driver which was missed in v12.
>
> Changes in v12:
>
>    The patch series is based on v6.9-rc1. You can simply review or test the
>    patches at the link [13].
>
>    Improved the dirvier code as per review comments from Stephen Boyd.
>    - Remove default y for CLK_SOPHGO_SG2042.
>    - Optimize sg2042_pll_get_postdiv_1_2, move postdiv1_2 to the function.
>      scope and add more explaniation.
>    - Optimize sg2042_get_pll_ctl_setting.
>    - Switch to platform driver.
>    - Use clk_hw for initialization of struct clks.
>    - Don't use ignore_unused when using critical.
>    - Other code cleanup as per input form the reviewers.
>
> Changes in v11:
>
>    The patch series is based on v6.8-rc5. You can simply review or test the
>    patches at the link [12].
>
>    Quick fixed some dt_binding_check errors reported by Rob.
>
> Changes in v10:
>
>    The patch series is based on v6.8-rc4. You can simply review or test the
>    patches at the link [11].
>
>    Add input clocks for rpgate & clkgen.
>
> Changes in v9:
>    The patch series is based on v6.8-rc2. You can simply review or test the
>    patches at the link [10].
>
>    From this version, drop the system-controller node due to there is no actual
>    device corresponding to it in IC design. SYS_CTRL is just a registers segment
>    defined on TRM for misc functions. Now three clock-controllers are defined for
>    SG2042, the control registers of the three clock-controllers are scattered in
>    different memory address spaces:
>    - the first one is for pll clocks;
>    - the second one is for gate clocks for RP subsystem;
>    - the third one is for div/mux, and gate clocks working for other subsystem
>      than RP subsystem.
>
> Changes in v8:
>    The patch series is based on v6.7. You can simply review or test the
>    patches at the link [9].
>    
>    In this version, the main change is to split one clock provider into two.
>    Strictly follow the hardware instructions, in the memoymap, the control
>    registers of some clocks are defined in the SYS_CTRL segment, and the
>    control registers of other clocks are defined in the CLOCK segment.
>    Therefore, the new design defines two clock controllers, one as a child
>    node of the system control and the other as an independent clock controller
>    node.
>
>    This modification involves a major modification to the binding files, so
>    the reviewed-by tags has been deleted.
>
> Changes in v7:
>    The patch series is based on v6.7. You can simply review or test the
>    patches at the link [8].
>    - fixed initval issue.
>    - fixed pll clk crash issue.
>    - fixed warning reported by <lkp@intel.com>
>    - code optimization as per review comments.
>    - code cleanup and style improvements as per review comments and checkpatch
>      with "--strict"
>
> Changes in v6:
>    The patch series is based on v6.7-rc1. You can simply review or test the
>    patches at the link [7].
>    - fixed some warnings/errors reported by kernel test robot <lkp@intel.com>.
>
> Changes in v5:
>    The patch series is based on v6.7-rc1. You can simply review or test the
>    patches at the link [6].
>    - dt-bindings: improved yaml, such as:
>      - add vendor prefix for system-ctrl property for clock generator.
>      - Add explanation for system-ctrl property.
>    - move sophgo,sg2042-clkgen.yaml to directly under clock folder.
>    - fixed bugs for driver Makefile/Kconfig
>    - continue cleaning-up debug print for driver code.
>
> Changes in v4:
>    The patch series is based on v6.7-rc1. You can simply review or test the
>    patches at the link [5].
>    - dt-bindings: fixed a dt_binding_check error.
>
> Changes in v3:
>    The patch series is based on v6.7-rc1. You can simply review or test the
>    patches at the link [3].
>    - DTS: don't use syscon but define sg2042 specific system control node. More
>      background info can read [4].
>    - Updating minor issues in dt-bindings as per input from reviews.
>
> Changes in v2:
>    The patch series is based on v6.7-rc1. You can simply review or test the
>    patches at the link [2].
>    - Squashed the patch adding clock definitions with the patch adding the
>      binding for the clock controller.
>    - Updating dt-binding for syscon, remove oneOf for property compatible;
>      define clock controller as child of syscon.
>    - DTS changes: merge sg2042-clock.dtsi into sg2042.dtsi; move clock-frequency
>      property of osc to board devicethree due to the oscillator is outside the
>      SoC.
>    - Fixed some bugs in driver code during testing, including removing warnings
>      for rv32_defconfig.
>    - Updated MAINTAINERS info.
>
> Changes in v1:
>    The patch series is based on v6.7-rc1. You can simply review or test the
>    patches at the link [1].
>
> Link: https://lore.kernel.org/linux-riscv/cover.1699879741.git.unicorn_wang@outlook.com/ [1]
> Link: https://lore.kernel.org/linux-riscv/cover.1701044106.git.unicorn_wang@outlook.com/ [2]
> Link: https://lore.kernel.org/linux-riscv/cover.1701691923.git.unicorn_wang@outlook.com/ [3]
> Link: https://lore.kernel.org/linux-riscv/MA0P287MB03329AE180378E1A2E034374FE82A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM/ [4]
> Link: https://lore.kernel.org/linux-riscv/cover.1701734442.git.unicorn_wang@outlook.com/ [5]
> Link: https://lore.kernel.org/linux-riscv/cover.1701938395.git.unicorn_wang@outlook.com/ [6]
> Link: https://lore.kernel.org/linux-riscv/cover.1701997033.git.unicorn_wang@outlook.com/ [7]
> Link: https://lore.kernel.org/linux-riscv/cover.1704694903.git.unicorn_wang@outlook.com/ [8]
> Link: https://lore.kernel.org/linux-riscv/cover.1705388518.git.unicorn_wang@outlook.com/ [9]
> Link: https://lore.kernel.org/linux-riscv/cover.1706854074.git.unicorn_wang@outlook.com/ [10]
> Link: https://lore.kernel.org/linux-riscv/cover.1708223519.git.unicorn_wang@outlook.com/ [11]
> Link: https://lore.kernel.org/linux-riscv/cover.1708397315.git.unicorn_wang@outlook.com/ [12]
> Link: https://lore.kernel.org/linux-riscv/cover.1711527932.git.unicorn_wang@outlook.com/ [13]
> Link: https://lore.kernel.org/linux-riscv/cover.1711692169.git.unicorn_wang@outlook.com/ [14]
> Link: https://lore.kernel.org/linux-riscv/cover.1713164546.git.unicorn_wang@outlook.com/ [15]
>
> ---
>
> Chen Wang (5):
>    dt-bindings: clock: sophgo: add pll clocks for SG2042
>    dt-bindings: clock: sophgo: add RP gate clocks for SG2042
>    dt-bindings: clock: sophgo: add clkgen for SG2042
>    clk: sophgo: Add SG2042 clock driver
>    riscv: dts: add clock generator for Sophgo SG2042 SoC
>
>   .../bindings/clock/sophgo,sg2042-clkgen.yaml  |   61 +
>   .../bindings/clock/sophgo,sg2042-pll.yaml     |   53 +
>   .../bindings/clock/sophgo,sg2042-rpgate.yaml  |   49 +
>   .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  |   12 +
>   arch/riscv/boot/dts/sophgo/sg2042.dtsi        |   55 +-
>   drivers/clk/Kconfig                           |    1 +
>   drivers/clk/Makefile                          |    1 +
>   drivers/clk/sophgo/Kconfig                    |    8 +
>   drivers/clk/sophgo/Makefile                   |    2 +
>   drivers/clk/sophgo/clk-sophgo-sg2042.c        | 1870 +++++++++++++++++
>   .../dt-bindings/clock/sophgo,sg2042-clkgen.h  |  111 +
>   include/dt-bindings/clock/sophgo,sg2042-pll.h |   14 +
>   .../dt-bindings/clock/sophgo,sg2042-rpgate.h  |   58 +
>   13 files changed, 2294 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/devicetree/bindings/clock/sophgo,sg2042-clkgen.yaml
>   create mode 100644 Documentation/devicetree/bindings/clock/sophgo,sg2042-pll.yaml
>   create mode 100644 Documentation/devicetree/bindings/clock/sophgo,sg2042-rpgate.yaml
>   create mode 100644 drivers/clk/sophgo/Kconfig
>   create mode 100644 drivers/clk/sophgo/Makefile
>   create mode 100644 drivers/clk/sophgo/clk-sophgo-sg2042.c
>   create mode 100644 include/dt-bindings/clock/sophgo,sg2042-clkgen.h
>   create mode 100644 include/dt-bindings/clock/sophgo,sg2042-pll.h
>   create mode 100644 include/dt-bindings/clock/sophgo,sg2042-rpgate.h
>
>
> base-commit: ed30a4a51bb196781c8058073ea720133a65596f

