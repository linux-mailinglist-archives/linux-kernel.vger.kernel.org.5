Return-Path: <linux-kernel+bounces-124101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B88BD89123D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 05:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2001E288DDF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 04:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D363A1A1;
	Fri, 29 Mar 2024 04:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="TnjQuQdV"
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2101.outbound.protection.outlook.com [40.92.103.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42E53A28D;
	Fri, 29 Mar 2024 04:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711684876; cv=fail; b=C4Y4bhc54SHugUyG6zRtNap3ukWBDBQYQdE223QI/Ou8tF1NZvEBVUhIpCoKzA83oSXwAI3bZzCeIwG3NcS6Y4pBfYOz1cN38fwSZNAcC9VDnFjJuFFPX/7eIjXVMq2wneUBb9BuLj9vmdinKdcYGTpuA1zKTnG1e+dR96lb/cM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711684876; c=relaxed/simple;
	bh=QsjIh26vEZkIyDTLpc87r7rdo9CVx3se5L+FRnuwbm8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lFy2X8E+5RUWVRyWN9Tz35iWHzczjA1zvZoX6cSNxBaOQ/KiAY1qHpbVifDpjeR5JJPLVrLzhhxZRAW8z8a3I17NroZIeC4N103BCQXZkGMO4eJ5YYrHlTDY+3Ek5cR44qd6w+46kjCUTkZfl+2CM7Qe00CNB7jEgrmsvvgrMw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=TnjQuQdV; arc=fail smtp.client-ip=40.92.103.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ICdsXclJH6hTiqOq6e8PBcurb7st5MQsGQ3lfzf7BSLsyS5pdOWDGjHQyEThLXNqlt/S3YmhRh4llqIQfhR97i9eGgXJAnoAvAlRKdw8Qke8iKpDdb+EhyGT+CStMDUkwE0T+8c9+6w+noZZ0gtyXfDutEatdL6AILdh1Hxusn1xoFN4lsvxRKhIchva3dCZc2kLlWhtQaXJeE8NgyF7aABJd7V2xKO+DBVoEEKUPUo6b0Db6kw+sVzuomc3WIDVZXWBAfAoECHGr3QQM6gIk0IHXj/OWcUbtefeiCsgXQwM/DJnIJVGr0+8iSXdSRkAP+gnNDrvXryLYmxPwSTD2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42j7Bwfb1lBB5mP3VtxgtGINMhZqIPZcB7jczi6cYiA=;
 b=D5sYX8zOGKQV64pydcKRrbDwy16CHaM841W4UB2ajSqCy8JTru9IIaZs7FZrgNbywVg/BJj9xeyv/9fq3MXoI3k3lxAXGAeehuMV/M0uhvIoWQ4yt0OGP+AqQZYWHS+Icjty6HLEABUL+YNd1eIPFqrhmg6HFuQuaFmvcrP5nHvDuMdBX5WumNAy6nJaBMriNrG8yi9yihcCaNmGSKbnCX+ArDh3iN5HLqFFcnSc6RHOCER86GCGLpGWMryZw1v8884cfGUChU5sYo3ERYZjNQoIVTt69KuyRZa/v5XeBpg24ElJic5DX76DlEWuub4xypEKfikk3NUuMr5ZpDh7Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42j7Bwfb1lBB5mP3VtxgtGINMhZqIPZcB7jczi6cYiA=;
 b=TnjQuQdVxrLlNy/upKTyWlbxvmJUT1zyNSBOiKWXbI3Q3h0/fzPrv41IWZShJWRJoaFd0XEQzIDhQbOZ/0Bg8UaJFmorwcozroDh+GmkLV9n+1jmXixU8V/5DMqtAi59hBK7fZhpK8FSiAwLa27lHu3PpVSxVOpmp5rr6DtBx5MCfv/sKp5zyLkpzsv3lLehuk6DYoKW+3QNjptmgh/4j5fnKWtXRzvPa+kfIe1kPCSPTeArGa5H000sFCLysqKyOBDPRW0fg2E10A/xKJIeUiQTeRMD7mnvemFTHOdASAOGMDRmRuDr+lbTN+MWGgSv01cD7Ap3xLC4OAcrWDLN7g==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN3P287MB1607.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:19a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Fri, 29 Mar
 2024 04:01:05 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::664:2ecc:c36:1f2c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::664:2ecc:c36:1f2c%3]) with mapi id 15.20.7409.039; Fri, 29 Mar 2024
 04:01:05 +0000
Message-ID:
 <MA0P287MB282295C1A8775E72D0118F79FE3A2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Fri, 29 Mar 2024 12:00:59 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 0/5] riscv: sophgo: add clock support for sg2042
To: Chen Wang <unicornxw@gmail.com>, aou@eecs.berkeley.edu,
 chao.wei@sophgo.com, conor@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 mturquette@baylibre.com, palmer@dabbelt.com, paul.walmsley@sifive.com,
 richardcochran@gmail.com, robh+dt@kernel.org, sboyd@kernel.org,
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com, guoren@kernel.org,
 jszhang@kernel.org, inochiama@outlook.com, samuel.holland@sifive.com
References: <cover.1711527932.git.unicorn_wang@outlook.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <cover.1711527932.git.unicorn_wang@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [S90MetWkmGbGCHtueeGbpPhyzVy8QKvx]
X-ClientProxiedBy: SG2PR02CA0112.apcprd02.prod.outlook.com
 (2603:1096:4:92::28) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <99e7b598-d068-447f-8967-cf8b3f1db162@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN3P287MB1607:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b3e8e3c-a1b8-4f1f-e41b-08dc4fa4d9ed
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uq9SX4csuo7nzTsgEq5ahlP1c7R5iQ2xiIDtHnjPB6iW4FmkkyDRA0o3uf9uKK+4pN4A0dwFo412l7SYpjQEEqmKJwvezLRg3ENRg+g0uzrUyHzI59TAAPNpCR/RW4MyuOdxScsCPqgn4mbrBH+llaRR5+lzUjSmZjCHuwz+r6BQ+oINj1M9ZYywifyUGClGdHOt0k4q9kAAOI8lzxHNyQPeWgoJF/Ne94c/Jqllve9gCc4VRp2fz25QVm6QlMuKAnp6UXeUKVYfbF42Ga52R8XvjaoH2GJHGrFlqnz106e2jwYIcqdJhiVl61+of1PWqDrK7x4fyjW4G7zkAQ5MicLhg2yub0Zwj44FLpk1R8lOcGFF9WwAjUxI9GdGnkGlr0KTGTu3MTQAXypnrGYcT59uDxaZWdc4O1vNj7zvSIzJvxut2OSRwYU2oj459B0ajYOnrdKnQqn15E0HdJ+mQ7zRu4+KX4Kk1DglBvvHWqrWqSTxEa80iNsYhrvB7PT4h53QoUXKd0Uwan7oQg4/rf4XdlIYBGlNtiMoxYIR+VerOVUe3JXG77K/BXPBB62NzTctM5OiKmVhZ1padLQdK5U1zTWnkCrcK1gGaCQvvB3MZQMPik/SMNQzI9Jbr+Owr76UVqq1TxylzVSq3iO6RY9n2WM1UvnjjRKl3boOOQI=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0pGZ2VObFAzVGEzU2ZsZW55UzBTdGZ4UVZkTjY3Uk1ZcjBSSEdCUERyYko0?=
 =?utf-8?B?SldnNHF4OGlOalV5Ny96MWxqOHZncVpOa3p6ckZlR0NqRTRTNUFlcE1GZmcw?=
 =?utf-8?B?aFlkY1RZeDd3cW14V3FEYkVsdG1iOHhGZzYwdUExNGJ3U21DMUxOOG1RdXB0?=
 =?utf-8?B?cklpZWE1a1ZyOWREa2tGb0Q1bzVBN3BwUGd4OFZGTFBwcGczN0xaMlVvOHls?=
 =?utf-8?B?Z3RHUkxQa1R1NWJ2MU1WV29aVjNxc0gyU2VQV0lNY0ZQMGpNYmdlaElFOUlQ?=
 =?utf-8?B?OGtnN2hNOGovcXJBUlJVK2lFWmc5Vm1vSXlMbjlzWWI3SWd3R21iZW0ycFdH?=
 =?utf-8?B?ODdFT1RtS09PVnNyVDVQMnd3RVFla2RkVHc3dk9rK2wySUppblZ5VTVRMytz?=
 =?utf-8?B?dG4wK3REWCtvMVBIUUlKSERwVHVCa0pFLzl0Ty80dkdwRkw3QWdKQkR5M1dO?=
 =?utf-8?B?VEQveTRsTFFVRmtwcHlQdEhsMFZRbis4Umt5THFkb1VUa251Zk0waUFleXdp?=
 =?utf-8?B?U3hhMzIvZEtzdVdUSVJYeE5CRXA1WnloMkhTTDlaKzNmdzBRVmRGVkpQc09q?=
 =?utf-8?B?bHMvRjFGMlR0anFROERZY3BESW1WQ1RpRUV3WHdZSmhmK2t3djNvUFA4bTlH?=
 =?utf-8?B?K2tRVzl1N3NZRkc5N3JFSWxMS2t1S1FadVhQVEc5WnhPaHNmV0FSOUwxZXd6?=
 =?utf-8?B?WXdjUU9vdlZsS1dmVTROZDZvV0lmQ1AzL25BclJLMVdvUG9ZQlVtclRZcmVC?=
 =?utf-8?B?VXI0TUt6QktwNjQyYVhoZFRqQWlZcVlLQ0N6WVVDUit0NS93MzEwU3RsdDV3?=
 =?utf-8?B?Y0JJZ241eWlLWWNYQUNxSGtVVjdENGFiVE5NSUtPL3FWbUVVMUJJWHhxYjVp?=
 =?utf-8?B?KzU0UWxQK3k0TlB3T0QySXdWZy9pRlVodUdvSWtpWGdVTzRmT04zVDJVQjRp?=
 =?utf-8?B?WWFkaUhBQjQ1TjBWTVMwaS9IQmJDcmZHcXNWcDA1clh5UXV4QzcxM3kxSjA4?=
 =?utf-8?B?cVMvWkRCT0RrNjBTblhuaFQ0Qm1URDJqZ2I0TlZ3VldMRi9nVXp5aVk5cklI?=
 =?utf-8?B?U0U0MUhwVXlGRzA4ZS92eHVxR1Fqam1IWWdsRnd6UDhQem5mR285WFhHU3N6?=
 =?utf-8?B?bk92RExjSkllK3BycHlwNVNWOFN4SjdBcGhoRWZXUytvbmZQVFo5ZWhDQmxw?=
 =?utf-8?B?dVhyakZkYUszVGJGSnJpMURSeDJOUjl4UFdWNWlzd0tVeXo0eXBNQXFvY0pn?=
 =?utf-8?B?L1lWUndBdzVyMlNTblpMZUtZUCtHb2lYcmUvWlRqTDdiaisyTTR3ckpVVVBI?=
 =?utf-8?B?eWczU0RpUFI2SStzTTlZK2p2OE03dTMwRmpHZ2g3bHhvemdRZ2gxVnErRnBE?=
 =?utf-8?B?YTBkaU5XYWp1U2UydmJXM2NyQnJTYlBNVmFBU0tYTURybWN1b1pzQU5sT3Ev?=
 =?utf-8?B?QXpjZDNmNFRXVloxOTBjbk9MYzRLazJIRDlva3MwcGc5VXdySnEzRG40Y0g5?=
 =?utf-8?B?NDhmWFI1cEdsK1hMaTNxZ09kYzBpbnpHcGRKdSsyaFJmSWNxKzJ0M1FFZHI1?=
 =?utf-8?B?MXhmWTFqMnBQb3RiUHFDaTkwWFc3c1JEWFJEWTJkWHhKY2duOVRGTUU3NnpU?=
 =?utf-8?B?VERMaEVzdVY4aFVZM1ZIRVdJTFhQR09kUFVBYXk2NUo2eXlZekJYWWN1d0lV?=
 =?utf-8?Q?a2WHcl5UnLLewo3dWD9I?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b3e8e3c-a1b8-4f1f-e41b-08dc4fa4d9ed
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 04:01:04.9823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB1607

I just found there is a defect in driver code, I will send a new version 
later soon. Please ignore this v12.

Thanks,

Chen

On 2024/3/27 16:29, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
>
> This series adds clock controller support for sophgo sg2042.
>
> Thanks,
> Chen
>
> ---
>
> Changes in v12:
>
>    The patch series is based on v6.9-rc1.
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
>   .../bindings/clock/sophgo,sg2042-clkgen.yaml  |   49 +
>   .../bindings/clock/sophgo,sg2042-pll.yaml     |   45 +
>   .../bindings/clock/sophgo,sg2042-rpgate.yaml  |   43 +
>   .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  |   12 +
>   arch/riscv/boot/dts/sophgo/sg2042.dtsi        |   49 +-
>   drivers/clk/Kconfig                           |    1 +
>   drivers/clk/Makefile                          |    1 +
>   drivers/clk/sophgo/Kconfig                    |    7 +
>   drivers/clk/sophgo/Makefile                   |    2 +
>   drivers/clk/sophgo/clk-sophgo-sg2042.c        | 1410 +++++++++++++++++
>   drivers/clk/sophgo/clk-sophgo-sg2042.h        |  216 +++
>   .../dt-bindings/clock/sophgo,sg2042-clkgen.h  |  111 ++
>   include/dt-bindings/clock/sophgo,sg2042-pll.h |   14 +
>   .../dt-bindings/clock/sophgo,sg2042-rpgate.h  |   58 +
>   14 files changed, 2017 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/devicetree/bindings/clock/sophgo,sg2042-clkgen.yaml
>   create mode 100644 Documentation/devicetree/bindings/clock/sophgo,sg2042-pll.yaml
>   create mode 100644 Documentation/devicetree/bindings/clock/sophgo,sg2042-rpgate.yaml
>   create mode 100644 drivers/clk/sophgo/Kconfig
>   create mode 100644 drivers/clk/sophgo/Makefile
>   create mode 100644 drivers/clk/sophgo/clk-sophgo-sg2042.c
>   create mode 100644 drivers/clk/sophgo/clk-sophgo-sg2042.h
>   create mode 100644 include/dt-bindings/clock/sophgo,sg2042-clkgen.h
>   create mode 100644 include/dt-bindings/clock/sophgo,sg2042-pll.h
>   create mode 100644 include/dt-bindings/clock/sophgo,sg2042-rpgate.h
>
>
> base-commit: 4cece764965020c22cff7665b18a012006359095

