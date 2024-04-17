Return-Path: <linux-kernel+bounces-148641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E59758A8570
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 707D2282726
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07171411CB;
	Wed, 17 Apr 2024 14:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="GP5bnuov"
Received: from CWXP265CU007.outbound.protection.outlook.com (mail-ukwestazon11020003.outbound.protection.outlook.com [52.101.195.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D9C12DDB2;
	Wed, 17 Apr 2024 14:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713362411; cv=fail; b=gB1IEcAw/LcMVZqUdotzWzBWadPRksU0UENDSdC+glWGdOf2DpuBLvrKfaBV6ueehJ8hvlBwP86sRWaVhCr6yK2prhGxLiw4stKCgSe56eZMkSpm6+mSYKj7v4WxGmobdaAIyovVNHSd+PScb6+XCPvbQ6IajMaAXV7l9Su3bWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713362411; c=relaxed/simple;
	bh=c+2cPfiKdmqItc1U++Gkv8oFKkJSnPw3JRGesN/U7FY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C3sVYSAvVo2O1/7qTxUwES5a2IwbFkSPjKTVio2iMhoonwClMgw5b5M3kDrN8L28yXuVK2oXGfV6hutucgXXljOHAcEN7u8FoiAnKthS28m3MFMC2QiMnqJJyRmgw33zIOSiGz4C//2hBaBfyU8l+T55QR4cVed4B6pZScU+CUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=GP5bnuov; arc=fail smtp.client-ip=52.101.195.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dlZQLxyV7++hIWEJ674CugnbI2aDfMyQ5dJb1fbGI7l3JueUmUxNkAJHm92N8lLKSbcQ9jOvx7rFGmb1mXe/Kzt/0dE563nKiB9brkCoi7O9keU2JSLvFTwGWoNJGO/Te18vGAFph9rpqec4n8K2LZk4rI+/FOCyAnn+c4ZNVCTd1xm2wPcCZAKzIQUxbXzBWej0HQRIHbSFyHaia/94jryIjrbtAnTA4lMcOcWCk1z6EAtSnk7PoueVmSmlnuGgcHPXnTz0MLb5a+WbBCJdoBle3Mic6/LaHZhS74K/MKO1Xp2sX0n65RwnRYrpRt/+e4kT9ruluwPO0tERZesiUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wAua78zv2/Iq0lRc62CxLWhcx14Ku5QTZt3ma5IJ1DY=;
 b=heggTbfrTeHzeDKg3fcJLnKkF/yJ7CgRHHCSQ7W5afljFmws/C5oC+oDrGONHmvJBgSFAad6JJxfLs6Glc2i/nEflp68ICkTvE1lDSTNH0YLRVJjPkPHYtbTniMGGHgr/rEf4KvRz0EpyMxoN8YgIpp9rBRUNJqiWEbZI6GPgD7LRRHizbVypcI41/hD6ItO87ycYmV6zQ4Mh9zSyDmpbfnFxquS0cDLEW2uskrqnOD3uTUCQRUkSK38GX6JdzNPqN3npF58/OQaysAGhIpWAxgfGpMpz4PhZBNl2BPITsyOC9k/2NihpFu06dtuR9q5gMVkvkh3opXQJlkdbHSG6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wAua78zv2/Iq0lRc62CxLWhcx14Ku5QTZt3ma5IJ1DY=;
 b=GP5bnuov9M9USAGCChpalIlGNTCLm9sDAU6ZB9VviEdYjdjhB2q/EfjaQ0Rdhja3A4kKuqbHWUaEtnPxgGCGc2x8hDtUKISKb/paVj+RkogbZp6oCihQOZHQodJntE6k0zY/Ds4m7Hl+bJe+a7mSpfVFrIO84o2krTV8oVkQky4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB5426.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Wed, 17 Apr
 2024 14:00:04 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%4]) with mapi id 15.20.7472.037; Wed, 17 Apr 2024
 14:00:04 +0000
Date: Wed, 17 Apr 2024 15:00:01 +0100
From: Gary Guo <gary@garyguo.net>
To: Conor Dooley <conor@kernel.org>
Cc: linux-riscv@lists.infradead.org, Conor Dooley
 <conor.dooley@microchip.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
 <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun
 Feng <boqun.feng@gmail.com>, =?UTF-8?B?QmrDtnJu?= Roy Baron
 <bjorn3_gh@protonmail.com>, Jonathan Corbet <corbet@lwn.net>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Nathan
 Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>,
 rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v3 1/1] RISC-V: enable building 64-bit kernels with rust
 support
Message-ID: <20240417150001.37e48479@eugeo>
In-Reply-To: <20240409-silencer-book-ce1320f06aab@spud>
References: <20240409-unsaddle-skittle-c93eb77732bb@spud>
	<20240409-silencer-book-ce1320f06aab@spud>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0497.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::16) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB5426:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cb95bfb-9829-49bd-4b84-08dc5ee6aeb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pj0Kg5v5aWQv7Alfqh0o/P5Vq5woenmDeBR+sGjrg/Qe47hZaLKeZorly5fKosIB/XgQFgL6xunm9CGjmMVyonEuJA+02Bf8f7gQ66pXfcOGwyFre9dNGcDf6kVWy5YN7/2cd5VLg91rV7lWTRug1H+t9FrOMy8EtEMCe9OdbPxqjnr9hxaqgeuVgcmZTVvf0zXOsXT9aCskfNZpdx+h/rvKf5p3E2ifqoNa8T3reYJp/oJU9kgeL18MIx4JTnVQ39jbTMeG+3DvqS2p9Xs9ikMFoKt3rU9Fmqj0MMQjVuV3BXNKykgpfBVvL1uQBN6Dw0fa5GK7SxlVOj2Puy/C5wgzgjA2Ac6wQtxrpZRLHFEAYEoyF5qnAN5wgRRHsoI0M4raCVBqbz1jKc0eL4F+36nlCRPs7BSuDOFjBAMubx61M+O5gAyijink8/dl7nzd7mELMtoJeNwfWWCM/ZH9bX4GEta2M2AsYkk+aBsb5QHfOeBFZ8NLuW0qIL6pihysDjMDdgoixbpPIq68Wyxoj918xcqdKhTQh6U5c+28RGrHg39cy+Hp5nwvwwPB19Y++VF3lMfW5SVcCVr2n+aYIgIQgcy3yNpI9l6Eyfjqvr0upnHdckIKb++L5NJ+HkJnlBZ0MS8hlNjWRMQIDd1/QI8pO9dLRFDCWNApq9Sasek=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?79LdlXS6zVAo1FKEkwI4clqlNbPHDQUi7OfAuxXDXA11QVpG/1bN9tdgq7fA?=
 =?us-ascii?Q?44v9iKJvNIUVAOOu9QdhPaJltrH+FI8K5B9WD3oghscqJ6OYz6qNcdMVg9Xn?=
 =?us-ascii?Q?dPfKmNB3MEJLYsov4ofBL1mxHPgP5m5g9R/PMAy8iInfaW5SvO0DMRGJ6NCn?=
 =?us-ascii?Q?LN7LyQe/AsaNfS8mR3qAvQEt2egoJK8RryIb3E3bn1iyEQJ2H6mvwitW7NhT?=
 =?us-ascii?Q?A39/qcGVQHJIUmRdlyyI3ApmTHZbiae12wfJSn1bXat5u+/5P/fRqqwypF7Z?=
 =?us-ascii?Q?SgxuWw20lehwWtHWZmXtvuImvF595DCQQW+a6147Xfy408pMp534OC6/ihGs?=
 =?us-ascii?Q?wGhuawe8q8sg6yXoeW9+t1+k4CafC8bos6+4S25Knm6+QcFO6aV6PyrZPKFB?=
 =?us-ascii?Q?jBuM1t/7ROWCEcXqKAGe6IAliGXHSSC/ES90K3sXJ4Pt00K0kiFUKzO9qSfW?=
 =?us-ascii?Q?wNIHQ7piZXxYkITyma1GLiremdJ2vTJ0kN858+byzK5TWoXDAKYoqlurin+z?=
 =?us-ascii?Q?wqe9eYq9e2OETjgNjfo9qzCSUUaBedKbzniSgvxn0qlIQBcQ+KJXbB+gKhrg?=
 =?us-ascii?Q?CLMN+67UJYegAgyIXPxYUv1wS/yj4svbSvhKl8bf6FbNYm4JYvi08UNB7SFW?=
 =?us-ascii?Q?Xc1o7x7IgsRjEJIzhTz7bmZurSuXMNOKp8DBqvf2Lm9Sq2eIWXioBEEuQiEL?=
 =?us-ascii?Q?5WGyQwc/KblHLc5nqFkahc4/4utwfllRgzvdNtaR8msUd69Y5hKP2tgDZ386?=
 =?us-ascii?Q?D9KfpfmBg6sO16TRFMx9Mz+WaUlRJDN0348OkneCH/YKD7ziM98cKlB+eWEM?=
 =?us-ascii?Q?JaZLc3zB8VDxoDSAPIwQuiMnih/zkzuj2TmzrpkB6Gi7XTfijPT+1WK1J7vc?=
 =?us-ascii?Q?BN7oShiabDDwV2BPKU02FNQWMUmgHOeon/eFO2yy8OCBIFrwVTsA88kLQwuJ?=
 =?us-ascii?Q?SFstiRTW90nr17i5GlUezwJy+TiUoACt+H2Vy+umyiwrASJ+yZerGTIczoE0?=
 =?us-ascii?Q?sC3oEgqjWyE4IST8haJ9ZlbZCLU1gDEpY2UtrgNOtnhG3nlfyfVA8Q8xW4/9?=
 =?us-ascii?Q?oFs4FWZH9zjEwek9NLGLeGBaY1eISWFxIDieaFEFW6ZlXDyXCwtgtxXh5vwm?=
 =?us-ascii?Q?cdoL7HvSluz82X88yxzwPRuwgcDrejjiwEAuUD7IJGLGYk/+Za1HZLP9bI0h?=
 =?us-ascii?Q?Q9AwDmINxE2u+c2Ed9ue/9+e/eG9xkvOutn8xxML8/UoS4fqvCK6ESdD54gn?=
 =?us-ascii?Q?Q4Si4hAv02WmMyUTGprj4131qomg0Kad+ROJSAA3Mk2K2j8xEAMd8HR2VTnT?=
 =?us-ascii?Q?GlF291zojJ7poOi/Y0FxLFWq9gJAhRIjfVU2oFN7LdtLl7KRe9c9JM6Ab0LO?=
 =?us-ascii?Q?LEaLfmSG8HxeZk/km2xzPaJ9UJEEBSJ5tz5UagbaKCbMJon9KsC5msVfrNWt?=
 =?us-ascii?Q?+VeLla8NOeKUSJtMtVEvRDJgffQ7ye5sKk/lc3OTNMZEfA+7AsSJ3UHySpA2?=
 =?us-ascii?Q?w6F03x6MKHl3SVTkfrpdcDTg9sMqSSQ9U7SlSwfTsShwRM8VKahLsNNViiya?=
 =?us-ascii?Q?637RfUvfXf83pAqs36x+Slo6Hk3FMCgZH2X2L0JG?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cb95bfb-9829-49bd-4b84-08dc5ee6aeb3
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 14:00:04.7674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NhYt1pFBHz2tK1NL95wZhgtVC8Z/2q9NWLligH6U/v0FdACGrr4/cb0hSGbdKwBLgcTs1+NEPMhbJ0yrr2ND/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5426

On Tue,  9 Apr 2024 18:25:16 +0100
Conor Dooley <conor@kernel.org> wrote:

> From: Miguel Ojeda <ojeda@kernel.org>
> 
> The rust modules work on 64-bit RISC-V, with no twiddling required.
> Select HAVE_RUST and provide the required flags to kbuild so that the
> modules can be used. The Makefile and Kconfig changes are lifted from
> work done by Miguel in the Rust-for-Linux tree, hence his authorship.
> Following the rabbit hole, the Makefile changes originated in a script,
> created based on config files originally added by Gary, hence his
> co-authorship.

Thanks for sending the patch!

> 32-bit is broken in core rust code, so support is limited to 64-bit:
> ld.lld: error: undefined symbol: __udivdi3

I wouldn't call the core rust code broken :)

The missing symbol here should be easily stubbed by changing the
redirect-intrinsics in rust/Makefile and adding a stub in
compiler_builtins.rs. Although we probably instead of panicking, want
to redirect the division to kernel division routine (IIRC the division
is used for formatting integers, which is a legit use of division).

> 
> As 64-bit RISC-V is now supported, add it to the arch support table.
> 
> Co-developed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> Co-developed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  Documentation/rust/arch-support.rst | 1 +
>  arch/riscv/Kconfig                  | 1 +
>  arch/riscv/Makefile                 | 7 +++++++
>  scripts/generate_rust_target.rs     | 6 ++++++
>  4 files changed, 15 insertions(+)

