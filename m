Return-Path: <linux-kernel+bounces-148630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E60858A8550
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 159821C2216F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B911420D3;
	Wed, 17 Apr 2024 13:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="zX72HgII"
Received: from GBR01-LO4-obe.outbound.protection.outlook.com (mail-lo4gbr01on2123.outbound.protection.outlook.com [40.107.122.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47FA14039D;
	Wed, 17 Apr 2024 13:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.122.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713361873; cv=fail; b=djOCrisfcFOOSEtxDzSUjBZfXdHDxhoM06X3rYjDejYLC4rFU8Hb96UUj+mO4pC/t9JfOuLmRWcrKiqQ0T9rvRj+1a9qkuOJIVmcftUF1gqIv7704PaijcjDbk4px9PxkbZ18RTni68X7EOBlayHYgWlMkOs21ij/a2/IIxiT7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713361873; c=relaxed/simple;
	bh=xXZVLhCa1aN7ZFz9UT/m7sf/mMvjgPemE8oGLn2EFPg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PGHrDmjV9Vxebny3V1QbYzsEf4Vn5TTWGHUHSPwH6dTnhGWLVrYHapQKyrVi8Ieoap2YW0CEjA+Mn+dEZwOhclClbDn4OizM+ehrIn4tjTHr4iCHXT3Ay5WPEIROSqZJp5p+QuKT1D7O9GIh7lpqpvvrwixJ3egpqzo2eV7Gr1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=zX72HgII; arc=fail smtp.client-ip=40.107.122.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jo1+hbz0eQo8kRHuCLZt50+WfJbKG5KSXaTL7G9/URwyLlpiQ3GsmikRjtWsvTIt4K+A8ftCzv3hMm5A9b3/L4wkl9FDq/0cF7iG8PWletze1B7FPMnLyuORjhmWWgWymlJ0+R+Z/vzQzxXqH7k+pfTA1kIJgKlsu3n+6E3u+LlRQMrpwLsarVDi2HXkQM8IEF5qGVrmMtdlvk8soHLCXTn/M0IbEnyExG9AVRlhGwzHxLcWgiBx8IdCnNVLSNhVO4eIw/I/3LDEdtwmFR4qC/iVhzKih3Ht/fSMCivnx1hvaloZYezTJDjjGfQQOFv8ibgnLSj/vNe1gSWMg79S1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iCb4q8hAfKMBvApPBsM3d6DTmyEZhwpUf4OjjhNUBPU=;
 b=AYpOLkDvAgfQLJdISxaMkfnBARhVzmTN6eWYybP9K59gOXUn7cpUroMEviyso0/hI2iUn5CQqb6U5jgI6osCr+9dYG8RCtTz+Kii+6xhm7fYk3Ibfz/sXgHM09kFWZGczG2kQOTR403KNunvmNmErmQ/5kCm+qC84tzBvMZkBp04x3SfC6kMAhqMlbvQ7U862963CKokpJAealLsmqSYyVF8RTRv2gAqwLCFT5Qb3q0ZKQl7ntX6RoNdvO/BAp5fb1ORv+LKqnBhcrrCrDtFG+vlSi02KJYusr/ZPsUGc6wl2TsrOe6OhekRWZuFz9D1PawJsLT0uDhYzOf91A8MYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iCb4q8hAfKMBvApPBsM3d6DTmyEZhwpUf4OjjhNUBPU=;
 b=zX72HgIITunenTTptToj8vDMF2MbMniIkcPLoQppOCBJFNAj1t75wdkgcix9XJ3rV4E1Ov4pN9flexxaHMDmya7qQzBTpzMoM5eS8Ag3tuzllDgA7k7sBnd4MQ30CUN80RocOa1nBRiqzsxCVzS9/z0dw4rliUz2P1S+oF5d1GA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB3507.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:f3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 13:51:00 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%4]) with mapi id 15.20.7472.037; Wed, 17 Apr 2024
 13:51:00 +0000
Date: Wed, 17 Apr 2024 14:50:58 +0100
From: Gary Guo <gary@garyguo.net>
To: <dev@raxyte.com>
Cc: <ojeda@kernel.org>, <alex.gaynor@gmail.com>, <wedsonaf@gmail.com>,
 <boqun.feng@gmail.com>, <bjorn3_gh@protonmail.com>,
 <benno.lossin@proton.me>, <a.hindborg@samsung.com>, <aliceryhl@google.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: update `dbg!()` to format column number
Message-ID: <20240417145058.7bad0df9@eugeo>
In-Reply-To: <eba70259-9b10-4bf7-ac4f-d7accf6b8891@smtp-relay.sendinblue.com>
References: <eba70259-9b10-4bf7-ac4f-d7accf6b8891@smtp-relay.sendinblue.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0422.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::26) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB3507:EE_
X-MS-Office365-Filtering-Correlation-Id: 63ca5621-39d9-493f-68db-08dc5ee56a46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	h5xNLIgWOhlSZswdRyu401i8CgSr0D17/Qnkd+Nq6lMnnftCyw6xOnaCw2wjZGppQUhXCRIMHr2XZSw1Pr1rgHhniHCaZZfKchF/Xrqcz7IdgXOfSEFahAmggpj2tSCBXXy+mvsEUcm7+UaC1MsdsL+Lrdm+uuACnCJWkMVfoqntoeVfm2CqCn2glGvnK0jw7cFmhIe4QXWKIO/DQA4i4v/IBVaohyuumg4fx5bOVPXG96W9nhATTtlNfJNoPCfpVwa3v2pyo0NvfM9Xp7YljlZn4mPExVHpyO94KJEl29/+2vR/Yh78jYHTHeNIWm572BT6gTIblhVpbhpL/TUmgh/w/uxIi22MVm8LrDCM8sZYFpDBReG6iC95GjmJdqAtgMnYWJeaWAHqacezJIV70gDYXwCvqAijf9kPRuwpS4NKx4LLHhyMaWRJ2Nd3xaFt1HonHY47XVW0GYvO31ZJ47Fv2q9levVQwGegk81pm4T0X2ynmu9BBJWx6fosI67y0hiDd868RPGFRmeMH6QWO/D+xunch99kmqPhjso+vR10pNSdNDHErzblGF0xAq/RE3l7fIWPoP5dG67xAly0TOQZaMhrlYwn2bsB/rPI+u8O/8vlQ7qyEjTWLtMbIyIHnpB3G3A6R1osRv+a54ef8THZPKfcabxzs2KNCtfWDRg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f393RCY4WmdOJk4CkgA35qIRm4rNgRBhEGLpuKOMB58pZxk2Sz9HVH3FHi2n?=
 =?us-ascii?Q?SdVx2gKAiQ7eZNIbILoyoRcB7LfPSK+m3TD2mgyufOfwHqmeoW/nlq+SGgxC?=
 =?us-ascii?Q?bMFvONN/9MxJ2/qsuuZj+eizia3BcXnF43ePjsP3kxrwSafmCbH32Quhmjhu?=
 =?us-ascii?Q?sVvZDV5Aev57M+XQRxQS6Yzn+6mm/+DREvz488rb95d39oXa7bLdXsbmoFbJ?=
 =?us-ascii?Q?7Y+IhIm0nOfuSAJrVQMMEzAMFAU816knZWcQt5fBv+tZAHKAOvTgVubKYckx?=
 =?us-ascii?Q?UKoQMu1LB22agP2pVp6FK554B3ixxzHjd9oEKyxK2xH0magYueeY8+cdhgfi?=
 =?us-ascii?Q?boft+ACEyGVf1vcf6e95zL6CbDwtnbzk+vZVXLTeeqfZcT5y3FWrZG9UaN+k?=
 =?us-ascii?Q?g/WzIyOl2m4dWqUzCpo2ayMJsHtLN01qKBg2ioseZSY5zKf50bcpDIe233O5?=
 =?us-ascii?Q?zS1oK7VpQLyV5fot6+sv75zm/Q6gx/nuXVNmOFKcA2D1/m+LR/6Hi+V1jYSe?=
 =?us-ascii?Q?7uAHpKLF47F8tleNCM8LEjZRo6lD0T5bIj+ywbNP5TvzeEjRWbRPT+N2uwxW?=
 =?us-ascii?Q?A7rdyYRCueZn7WjJrCo+ZVJsML+yJgvC+w9vFaWfhmadMMQoVg2YdbDweoEH?=
 =?us-ascii?Q?cV9be/jrfs23BXfNXWqVKPqexpgp7THDarQ1bLQpNDYC4iZX/Dal/glGsysM?=
 =?us-ascii?Q?drti4+g9KaOTLlQ9Pl1DER+MBcc65v119iN9NV8UF+5SAAVWHp3RgzVPWqej?=
 =?us-ascii?Q?NvTo0qlZ6SZq6im6fSyZnZnscAhddt5mAzrTtFyLHr4ZsLQMDRMyqzYw04Ev?=
 =?us-ascii?Q?yvl3xeoq18Ncdc+2uc2ECbiqJlKotlsLoco2aqowJdmZr63w+RBkOrb82ycI?=
 =?us-ascii?Q?rR6v2s/DxH7ewIAyyFITgH/64aEqmf2K0WPk/0B6dXOzb7di7pFZUlYPgl4K?=
 =?us-ascii?Q?/jdXxBpjYqEuBQzfFxWWkI4a7zbypW8qHj5LKe3+cUt/hnpiLbo9Lhh4bn1E?=
 =?us-ascii?Q?qpkKrOZ/Nj+47pZTHZvRDKW2DMobeipFc0i/n5zOpa6Qt60oCWOYNC8uBDik?=
 =?us-ascii?Q?CFUZykWUqPv7haVQonntpGhCiCFaBX7dc2b+OLG4rHPtWjzmrinw9okvfAiY?=
 =?us-ascii?Q?YutEbJuPoRqKq16yq+nq8aTEDrHz8fwZZpEvxRLaE5s4q6DGHq+AshymwjkP?=
 =?us-ascii?Q?g5m3Y8Jf4xBirY/dee+tRqzsoezcEZBU353jWZKzUuE5Ww4U8qxMQKD086m2?=
 =?us-ascii?Q?K+YcvdjZOdRrhx/X7L88bYfbMp4Rae/pGFC5f165IEhI47LVBLLtVXtV5ihx?=
 =?us-ascii?Q?qD7IE0SP36rxcUYSUFYMtgTXqjfLSx4cO6aap4P1BKwuhVuLz/Wc+XIwLoLq?=
 =?us-ascii?Q?60k2GjLHMAn8YkQ+yxLDP4PtSjeP4mR72BuazFP4INvox0/d4381zh55B8jL?=
 =?us-ascii?Q?jeBdGH92tMxJX8H9RH9th9qNzHgB0K1jjwNLTm4XLuUOpAs6mSZwnWLz2/WA?=
 =?us-ascii?Q?JPKagBYFVMgClMn5lqKc5HFrJbkSwkssbEA2wCs+SVjjM8FzzL2onxG1aI4Z?=
 =?us-ascii?Q?hKS6pwG5pm4NEabL3B6siyUfTxNIuXlxZ6F4Nny5?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ca5621-39d9-493f-68db-08dc5ee56a46
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 13:51:00.4799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jjc+PUNs5J/4gIArR00qxu7MREOC3Zvej5Ba5H7bnBPgoWrUiLWvhmePU9AOSSV2IcWnvTb1vA0BOs6tulEJFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB3507

On Sun, 14 Apr 2024 18:49:28 +0530
<dev@raxyte.com> wrote:

> In Rust 1.76.0, the `dbg!()` macro was updated to also format the column
> number. The reason cited was usage of a few characters worth of
> horizontal space while allowing direct jumps to the source location. [1]
> 
> Link: https://github.com/rust-lang/rust/pull/114962 [1]
> Link: https://github.com/Rust-for-Linux/linux/issues/1065
> 
> Signed-off-by: Raghav Narang <dev@raxyte.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  Branch rust-next 
> 
>  rust/kernel/std_vendor.rs | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/rust/kernel/std_vendor.rs b/rust/kernel/std_vendor.rs
> index 388d6a514..39679a960 100644
> --- a/rust/kernel/std_vendor.rs
> +++ b/rust/kernel/std_vendor.rs
> @@ -146,15 +146,16 @@ macro_rules! dbg {
>      // `$val` expression could be a block (`{ .. }`), in which case the `pr_info!`
>      // will be malformed.
>      () => {
> -        $crate::pr_info!("[{}:{}]\n", ::core::file!(), ::core::line!())
> +        $crate::pr_info!("[{}:{}:{}]\n", ::core::file!(), ::core::line!(), ::core::column!())
>      };
>      ($val:expr $(,)?) => {
>          // Use of `match` here is intentional because it affects the lifetimes
>          // of temporaries - https://stackoverflow.com/a/48732525/1063961
>          match $val {
>              tmp => {
> -                $crate::pr_info!("[{}:{}] {} = {:#?}\n",
> -                    ::core::file!(), ::core::line!(), ::core::stringify!($val), &tmp);
> +                $crate::pr_info!("[{}:{}:{}] {} = {:#?}\n",
> +                    ::core::file!(), ::core::line!(), ::core::column!(),
> +                    ::core::stringify!($val), &tmp);
>                  tmp
>              }
>          }
> 
> base-commit: 8db31d3f3bd5dbc8cf3a22bba04b4b4add7f984e


