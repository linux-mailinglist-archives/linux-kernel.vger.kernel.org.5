Return-Path: <linux-kernel+bounces-158673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6929D8B23B0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D67B1C20D08
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBC514A09B;
	Thu, 25 Apr 2024 14:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="NWImHBuQ"
Received: from GBR01-LO4-obe.outbound.protection.outlook.com (mail-lo4gbr01on2094.outbound.protection.outlook.com [40.107.122.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453D61494BB;
	Thu, 25 Apr 2024 14:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.122.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714054539; cv=fail; b=n3qWgMSi9YXw6zeVsftyRkFS3nrAcO5G2aGWAIY6jJp0CnheGbvmu9aFgFFhdz7QiX/Sw08G6lnNTbv6HDJmu+n+Tup2vyKYrET7e2AFY+nGSfNgQ0vaUl1QkQLuS418JQp4qXZTw71sAv99lSl4W6Z9/u7BxYTJuVw4Owd61rM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714054539; c=relaxed/simple;
	bh=Cu0nFxyTMNGkngcpZcLD5uAryF2daqLDA1gcv3Zice8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tu1WQtAzB8NwbrCTL8g/BkfiFNLH563cRT9suffSQ7TVjQFuEcIwKy0TTanABvlWLNel/Ip61XGhCsOoCowIclEHrPSzCAkvpePbnL/u4lT4qfGWJ1vdwuI0hnjoJ8s5WnugxoMoVtBHUfpp92wJserGh7P1FJ6lpv3yOvAJg50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=NWImHBuQ; arc=fail smtp.client-ip=40.107.122.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KlgUKRxVjZLYA9dvQ4rCMu9AJX8Mb/v4Ypyy0IcvueAhAJz+xButxTFuriCzJrKXQEMCjsMcTh+agXkw8SzfVzMHKF4CxqZT2dJjqhimcB+FWRH8HrZ/qHwr+PIW/Tu9wArxGHi+3IelDu6taPLC9XXKHWsKyAaVpv/YsOeWnhc1LnRzJ99SwtrveRvOzFTLxf6gqzHht86eXwFwIXStMg1acxlrrOHRuTtoBeiKdUSV4ED3iIxJT2f594Jlnyu5MZiC6xAORSgMLl/r5BWivMlFX2tRtRf0hblv38GbLtS4F6zi3lG5aVPUvF3SvLGZ6NJnKfKLL0mpH2pCSIhtSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aLDzXAsV8USwj6s+fuYV322QtDqxkGY6AlxzPxK6lF8=;
 b=e5RHmG5poBz/CsUnMCC3sxq1iLL/e+S5+dL4l0XoU2Lx59aR00VpUpZZgrgyQQPn3k+XF1DZX+xyzsu1keq1kKKMsjr2x5w4zoyNml/QXjSn45TScafp9zFYYmuauB0k9raur4HumV/PnthF1hRjacJSPIk6XrxnahUPIgO0QU+p6umLnchF5YcQba5qNzVFxJlphSjU4THiHs+73YR7oxXB4K2AE7fa9Hsikq5dCUCJJV5uy8CBF3yNAy/fGzadxPkeQnratQAYNoeQC1/dYh1U4WIQeeSVlRD7QXZh3MGHDlgtdZqHPapkSWcCwHfIhTnGweEzukc8Cao9Tvr3sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLDzXAsV8USwj6s+fuYV322QtDqxkGY6AlxzPxK6lF8=;
 b=NWImHBuQ9vy7gtEaLWbA2cniICjPdKOAGk0jUfORDONRP4CaL1M265bzIuHol6qxxQaEabWJCq5jZt7385cu8d20zxpthGRpxdU5nT8g42BPq33TQvQyncUpTU23i8QzZO+c4zplf0ZBrT8AO3bW8iNpNbHuAmgqM/PB5fnbAaA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO9P265MB7585.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3a3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 14:15:34 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%4]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 14:15:34 +0000
Date: Thu, 25 Apr 2024 15:15:31 +0100
From: Gary Guo <gary@garyguo.net>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Wedson Almeida Filho
 <wedsonaf@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, Nathan
 Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>,
 Nicolas Schier <nicolas@fjasle.eu>, Boqun Feng <boqun.feng@gmail.com>,
 =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin
 <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, Alice
 Ryhl <aliceryhl@google.com>, linux-kbuild@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 patches@lists.linux.dev, stable@vger.kernel.org, Daniel Almeida
 <daniel.almeida@collabora.com>, Julian Stecklina
 <julian.stecklina@cyberus-technology.de>
Subject: Re: [PATCH] kbuild: rust: force `alloc` extern to allow "empty"
 Rust files
Message-ID: <20240425151531.44df19f3@eugeo>
In-Reply-To: <20240422090644.525520-1-ojeda@kernel.org>
References: <20240422090644.525520-1-ojeda@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0159.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::9) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO9P265MB7585:EE_
X-MS-Office365-Filtering-Correlation-Id: 056671b6-4ae9-4b32-b88a-08dc65322c10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?imrpqDqbgxqz0DZ8LObg7a+gucafEi9JcaW81aqnn9v1lbCTOAy1NVJ9I9Qc?=
 =?us-ascii?Q?JzMWTLvCLw3qzfSzzDpc2LEB8PlcTxtEWnNh6cwuh3FmS+/zBhCHOdAxgtMM?=
 =?us-ascii?Q?TTgeCjbNKgDwZjKPHTe3QPjkBtXDyQoUY+HtA2B4PdVm8YAa6LseJbSEFZvy?=
 =?us-ascii?Q?YPjKYAtVe45lAFLNmrRpvUPNrb1L7/rCOQT+r4VwSuv0+NcoeP/+UW4nOjeD?=
 =?us-ascii?Q?/fx/Tb7RucilMkhdUHOiCvklkscrxPTmDZKT57WqYGB4rtZ4gP6uXjszlXih?=
 =?us-ascii?Q?91JTMQjZvuqphw52S2wE+PUOeM2tdJcsC8VCrM6WHa46fhiQpTc9YZ3AegAM?=
 =?us-ascii?Q?H0hjtj2mH64F51YNmV9/MelVGxCKQ28Fh7G9Eaw5AUUC6bNDCv41j27favMt?=
 =?us-ascii?Q?nO2/4wVQM/8zKFryDEwSJLul3p8vwVcqToi7xZyHE5a3dil8udjSsn/Fevt5?=
 =?us-ascii?Q?n01gom3WF9FU3ofe/9wZMZeNwEcwOKrLO6WEkz2Chgn7ecGqb2iX2bbcbsg8?=
 =?us-ascii?Q?wXm/fd0DYKl1b6sOZWUKOE2olzmAX7zr51pcFgmg8miRhbRQiHco8wKRcvFV?=
 =?us-ascii?Q?K+RiBRJU8ccn65yEPw/OiXmRav8bxomCYTQtYjTyTl3PB/jDcJ7A4Kzh2bkg?=
 =?us-ascii?Q?HhmhaTSh8zzklq9WE0ozDsYhHU8c9NFK8xEd5H5g+Yuw3IPPab85XUt7AFx0?=
 =?us-ascii?Q?7h3hX2RHSYfGQ7R7xMNQWdfPsFTwrp7KrViRS9cuWSKPITjfHpIWVm/sQEy8?=
 =?us-ascii?Q?R2WPJ+QymQBC7nNcHTO9AbZOoDlBILoYRU9MCMM6252RZjwslN9zbV3E84Gn?=
 =?us-ascii?Q?3cor+voTZRk1OFmM+rFp/FHzsuSFDd5jQyC7bjitSi0SE1hfVy2zJitTVENn?=
 =?us-ascii?Q?q0J3MbIAjVLfc0YOtOsG3QssfZJMP7j4ScEiNmIt3OiOWG3QizJDdkaZMXUp?=
 =?us-ascii?Q?zTQtYYup6PwvjbVKYhs1MNoGa7p1KkIqWICOqhGo8mNQn9NHJ7833mIHstNd?=
 =?us-ascii?Q?GV+Ay2ZPN7TJ6JPSMNOyykza9PNTeUV5JRFkG14wjwDYHX48ZEyvymnPWRo3?=
 =?us-ascii?Q?0JxBtwVxDFYv2VHmhDlNU2rF+KPrYq1f/SKS+cNVHCChHLpyG+25kJ3ZRRsE?=
 =?us-ascii?Q?K80WbRr0bXhOHLeJvqPTuskydj7rY0dj+CLzr6m0MyxBEYr4SVUfLBPdoMN6?=
 =?us-ascii?Q?0PBx2fCzw9OBc/fAxUHZ7GBn7m3tYSoicWrC9JfzCgWlTNx6GVDqIrmlYUI?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vu0KFpJylnFkDyAw6xOoeXsimlAE7+XF5xWhBzN3j2ICX4jLD0r29Wiaaicp?=
 =?us-ascii?Q?+lXFx3ZNEctbuwS3ycelu7A9HR4+nHF7pyWpRb/yPdlocnIqRpn/iR/givCU?=
 =?us-ascii?Q?9ZcDSYvo2HY9iQQUA0kd6z8UiQhSohSQVcUXKjXfI2k8NIgCeTfCrR9GqBc5?=
 =?us-ascii?Q?w9hNrxjtD6E0BdCjTp+5WSj6u84AQvTK/5oCrTZvxaRs6fsUPxyxzaxSQFQy?=
 =?us-ascii?Q?n2cqp6mGKDYtvzTeNg9lFuK27foUL7zKT3+FIguINhs2NPocAXfk7lXZQo8B?=
 =?us-ascii?Q?z1bho1TuGy60fF+YBNsDRPXu9bp0XowSGf8atW2gUl4mUcxVfcJOPEBswC8C?=
 =?us-ascii?Q?CCdtYs4cehTcDLQeMzOb7JuKvBLXGum4c6XVGg8x+f8YPNPqwFr/G/RiNdB1?=
 =?us-ascii?Q?YmDgJy9IgiSzf//4+QsXUMKKJ+YnQT+OMlTdtvoAxmOnIl7y6WjYRA4FtspP?=
 =?us-ascii?Q?D0QeKOl+8JBozMrHW64t62Swxe4okj3eU3AkQE8UqRTXPNOxeV6TL1qW2ZoW?=
 =?us-ascii?Q?tHry8ve/ctwcdWFytEL/UoAQ4NqLPdVDpXfx+6i1ZTuB2o4f5w/gApJyvFdV?=
 =?us-ascii?Q?AvBCroBfZuDjUXFbQDPf98sSxNgXYnh+6PAG1SG4kVTQEYBYqrHgoBxTca5p?=
 =?us-ascii?Q?CRZ/+xrVB+sjd64eGzF+5rs8hVZGWXail3gKsiRDLRDCUDEQCjyAc0PQThL0?=
 =?us-ascii?Q?eP6U4dl4Xk9dISkXH1PX2sbfR9XPRO+RahlufkwQ0jQ4rq+CY1EqIjZikLlk?=
 =?us-ascii?Q?S3qqcg4YqDvo9mY/BLsgyR6EMMk1NQi8re5lcDpY22oe7SYxo/MBjj3dp3rv?=
 =?us-ascii?Q?fKQUrCheFDfYhkA3jJrQQFKLAXIzewgvVeYeqVVPVUh//5A6If360QP/VnX1?=
 =?us-ascii?Q?NSFS+GdTo4/Y1jOOAiUK+4NgNcfN0jHOOj9wM972kPoLNo4jYtz81RxUuZeE?=
 =?us-ascii?Q?G3VH6kUojmHGD2mZ45MthCcKR0HOI9ItPF8DoxENmmUgnOf+I3L2pQgRyhB/?=
 =?us-ascii?Q?cAR3Ht8pgbqr48fjbmHW99GfT6aNs0pOlWt8IAwFLgtyX1uioHKv88FvBS9Q?=
 =?us-ascii?Q?HSB25ikobjfdvoiftWJVPMnmT32DXDcrh8vnbFlWAPIlrRoaFLas5YMRjzDu?=
 =?us-ascii?Q?Pv3LlFVz5LKS6ZmJS7NO0gEFG/NvsUY1zY4+P+kA1rXKo3mQF+LK6Lx+ogb8?=
 =?us-ascii?Q?tFEoYL8qODaGmjoRefTgcRpyMRLM1zhqUPm7tC2D1HJiMMyHZZ2n1tc8pInD?=
 =?us-ascii?Q?oaY802etECIii+SE/Kz9TSzYTDC1cDlwA4J6hXI6jZV7Ei9s7oV45fBaffJr?=
 =?us-ascii?Q?43GuhobCWOrLMrwM9fDhbI+X5emNi/u7tPAOUPPqYe6wW8odDH/QTGjgaLBG?=
 =?us-ascii?Q?YtNwiVR3Hnbkf7SO+nUd4sNawPReYQwwVS2e9aXc7lPiGSlxzcVG+75cvZUh?=
 =?us-ascii?Q?TvWVXYV7q6/i7XaeVG+PFQBp620A84aJFiY68+Z+j3RJ1SLDY2+X6NqS/emT?=
 =?us-ascii?Q?0Lmao5zVbS05VD4fZkc9XOeJh3gAZOoB3OS7igV1lDmWzCCQE84XY1rRvC/f?=
 =?us-ascii?Q?ORwM8Ixo+915MhMsQM22fjsAnpSxCQsttqSfZBjr?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 056671b6-4ae9-4b32-b88a-08dc65322c10
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 14:15:34.3847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TybCqmWHl8QgxAT2YhNMdgF8J0izvHBN7aBls2W+ZIEGvhcebpwHHZ7dX/owMAqRvCGlRLUmFEikULt+0HWzDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO9P265MB7585

On Mon, 22 Apr 2024 11:06:44 +0200
Miguel Ojeda <ojeda@kernel.org> wrote:

> If one attempts to build an essentially empty file somewhere in the
> kernel tree, it leads to a build error because the compiler does not
> recognize the `new_uninit` unstable feature:
> 
>     error[E0635]: unknown feature `new_uninit`
>      --> <crate attribute>:1:9  
>       |
>     1 | feature(new_uninit)
>       |         ^^^^^^^^^^
> 
> The reason is that we pass `-Zcrate-attr='feature(new_uninit)'` (together
> with `-Zallow-features=new_uninit`) to let non-`rust/` code use that
> unstable feature.
> 
> However, the compiler only recognizes the feature if the `alloc` crate
> is resolved (the feature is an `alloc` one). `--extern alloc`, which we
> pass, is not enough to resolve the crate.
> 
> Introducing a reference like `use alloc;` or `extern crate alloc;`
> solves the issue, thus this is not seen in normal files. For instance,
> `use`ing the `kernel` prelude introduces such a reference, since `alloc`
> is used inside.
> 
> While normal use of the build system is not impacted by this, it can still
> be fairly confusing for kernel developers [1], thus use the unstable
> `force` option of `--extern` [2] (added in Rust 1.71 [3]) to force the
> compiler to resolve `alloc`.
> 
> This new unstable feature is only needed meanwhile we use the other
> unstable feature, since then we will not need `-Zcrate-attr`.
> 
> Cc: stable@vger.kernel.org # v6.6+
> Reported-by: Daniel Almeida <daniel.almeida@collabora.com>
> Reported-by: Julian Stecklina <julian.stecklina@cyberus-technology.de>
> Closes: https://rust-for-linux.zulipchat.com/#narrow/stream/288089-General/topic/x/near/424096982 [1]
> Fixes: 2f7ab1267dc9 ("Kbuild: add Rust support")
> Link: https://github.com/rust-lang/rust/issues/111302 [2]
> Link: https://github.com/rust-lang/rust/pull/109421 [3]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---

Reviewed-by: Gary Guo <gary@garyguo.net>

>  scripts/Makefile.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index baf86c0880b6..533a7799fdfe 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -273,7 +273,7 @@ rust_common_cmd = \
>  	-Zallow-features=$(rust_allowed_features) \
>  	-Zcrate-attr=no_std \
>  	-Zcrate-attr='feature($(rust_allowed_features))' \
> -	--extern alloc --extern kernel \
> +	-Zunstable-options --extern force:alloc --extern kernel \
>  	--crate-type rlib -L $(objtree)/rust/ \
>  	--crate-name $(basename $(notdir $@)) \
>  	--sysroot=/dev/null \
> 
> base-commit: 4cece764965020c22cff7665b18a012006359095


