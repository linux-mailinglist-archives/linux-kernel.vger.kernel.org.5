Return-Path: <linux-kernel+bounces-158877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE428B261C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51E9D1F24209
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D190814C5BF;
	Thu, 25 Apr 2024 16:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="ULNrofaM"
Received: from GBR01-LO4-obe.outbound.protection.outlook.com (mail-lo4gbr01on2092.outbound.protection.outlook.com [40.107.122.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A6614D28C;
	Thu, 25 Apr 2024 16:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.122.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714061647; cv=fail; b=jr6lQe3VL0zjIvMUbZCMJtTZ8NrQa/fJ1JdVHH7Erl8uZahIUOKojoTbNW4j6+uw0GTWGSKTNMX1tJzHSq4AygnN/dOnn/9vgk6Yqo4BY+EeNhaW9m+180mp6NErT2cvE7uu6zTmXd+YcpRrRJsnG5IW6ioB9Nv7VV0ZwBxqHzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714061647; c=relaxed/simple;
	bh=B3ZvofMv/LYkm9y8o+eScz/5uLtowDeDt/0uuL4bCjY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FkcpCrI2rLUgXqFqEGrhg2cpSII+BwsX1rxIEfvSKxEl1WdRXLnT+lzT4ZX9jDhb6nj3oyU1+HQAScB6SobhGMGFD3ffYLeLJO69kifku1lWIn0MUKHDOiWPyimDAQssC/82SMylXzGhyahMwVJkRuKx5dvujmTfP0EX3ZY9wpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=ULNrofaM; arc=fail smtp.client-ip=40.107.122.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kH8qNqIu5oEyvzykULUNRkEtz6wA/zTw69qgTfjWA5GoAlbt27qsT/mce8wjXbyCFQnO2Yzjv6aFDhK8fxR6mTbxszTf1i85iPsrbZ5SunWAIeJGtgd/1YhjqKtKF485gs8kCbTU/PPbVU85Rut99bKShR5ZMWITyJAEGFbzJ+wHoEMMhs/5jjaSJDuasA+gDCt+tlXg9DzvEE/AM4NxmpoekaPiLVK3wPw95Ys424BkryIEikZjkyUwY/IrdAWR2voozwyEzvNPbEAc/vnX2OVUWZMI9gyuqao6jk9gBkgdF+4X5hxW0J4NpsEpc5Uy01xMSBGmiEwCYWj9OvjWxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ep/WTszA2WkQDXe+kAenwxtFlCAbYxNsfy38azCFbA4=;
 b=fbXwCrC+t2a8Gh2li1Wkxc3ZBJaPt1ijNrX5x9/Ualm+Uga62sjc1Wpl8+7+hezZ2tLXkxE0hLftSRIId/DjDjv11q6PE5Er03Twf6sEhIq4VFJSey9W8QdyRmNzjvkgOjWXW+ypGTep+i9kJyE5FiaUxWPkJX4r3XxSDLEjxAs+f19QZ9lhBnLrL3HxswWl2aOLSRGMzQirkquSZv/aii4uU/Z7BLgp8G8MrtDhG9owQj/igG8R/7u0c32IidGqfBYuLrPiUYolo4ueenKGSg7MKH7UtC/UBZSN74InLSKgv6F/uzpJeTiw4NYTgjYYp7sB4Lzc7E2JlPNZmnQOIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ep/WTszA2WkQDXe+kAenwxtFlCAbYxNsfy38azCFbA4=;
 b=ULNrofaMYjEM3tkTKs3P6LgMt439Lu54xZPF3TQmHZbBFsf5zf76k0Gb1t4WJSf4AcKWkG9II+VlZi2/zZdLUtTg8fyoi1L+WRBqSe3BHDgBvjc+HJADoo/ft5niN0ODWMcSU0Bohadpe7NI6XlYVAj5q2jJlh+iko7QOdG1NEU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB5970.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cf::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 16:14:02 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%4]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 16:14:02 +0000
Date: Thu, 25 Apr 2024 17:13:58 +0100
From: Gary Guo <gary@garyguo.net>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton
 <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, Alex Gaynor
 <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun
 Feng <boqun.feng@gmail.com>, "=?UTF-8?B?QmrDtnJu?= Roy Baron"
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas
 Hindborg <a.hindborg@samsung.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Arve =?UTF-8?B?SGrDuG5uZXbDpWc=?="
 <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen
 <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas
 <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Arnd
 Bergmann <arnd@arndb.de>, Trevor Gross <tmgross@umich.edu>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v6 3/4] rust: uaccess: add typed accessors for userspace
 pointers
Message-ID: <20240425171358.54dc96e4@eugeo>
In-Reply-To: <20240418-alice-mm-v6-3-cb8f3e5d688f@google.com>
References: <20240418-alice-mm-v6-0-cb8f3e5d688f@google.com>
	<20240418-alice-mm-v6-3-cb8f3e5d688f@google.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0002.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::8) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB5970:EE_
X-MS-Office365-Filtering-Correlation-Id: 3eb642ba-7e25-4c00-4741-08dc6542b905
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8G/L776Wnv6DbtGhAgn6HMnGi2OAE8SjKXvqZIYPEG7qLtx6V2KC1NRZGb2T?=
 =?us-ascii?Q?K6WCOjrkBEzDzGgv1AeIvVPba8MmrKgUokNG+zy5gXXd38ErX8m0yVNrJXvq?=
 =?us-ascii?Q?4Ot58KA+xVNT9OUdgg3W/tpBxV9rGSV/ULvOp4adfEwJ9Y6LTLSHjJlC+DAq?=
 =?us-ascii?Q?WlR9ZElruu+6NAKX8o0eVy6GfGq2HDlPJMvJH+Lp560+pHWY+/IB/j6Wx67j?=
 =?us-ascii?Q?uES07BpWqkah1MH4IX8egZ62yZYG+TOorcvpjVx3LNpL1nZ5OeLNXOKRqxLa?=
 =?us-ascii?Q?Dzlm7DIgyxgZfr0q9VdOicKt4MMvn4QhH9KgTdenXwfTiSR8t3RkzocRvls6?=
 =?us-ascii?Q?2qXSNXvAAIg4NwuGdjLLOv+OQ6hUftOOrtMqI1VzTmUTvuFNQBo+5ylEi/YQ?=
 =?us-ascii?Q?msS15WlmQppFhrKBFTScLTChcHsXjoUzunf9RW5vRN9IXR+uCv2iR/HYAkSQ?=
 =?us-ascii?Q?Whkgv1CVeD9gS6MaoN1xvf0u1/pHBG0MWS6zoTYYXX/FKzJXtAK0GXy4W8KB?=
 =?us-ascii?Q?8V49C/bzNpp0QJzfHRjkQm7LMBL7NkN/V7IC7bximhG6DpnjlqOmlvveQFzH?=
 =?us-ascii?Q?KloxtDWi5IRGu0+8S9duQBKbwn/XBi0GcIWFy74z7WxYzwY+ah54Yz6rM+UN?=
 =?us-ascii?Q?G0UrVx9rxdSZMsSbsummWXqOLBYlLGsdO79aya66CeY6qNjAGqY4GfcVPlPT?=
 =?us-ascii?Q?pCAjvMpV35M4CaGxt3NOv7g9yvOhgOR6GAJXGTKIQaP9h+sY7h3OSgKCEaNp?=
 =?us-ascii?Q?JfhJ4l8DmMPJ171+Lra+6u/blVx5Sb8dg/4AjPsSGyM8KWsQtmIGKffoTVT1?=
 =?us-ascii?Q?FduMNUpcwQcvqygJBJLxNihD2sNLOoAhPVrtuBrd0KJtuuw695jZkswngr5c?=
 =?us-ascii?Q?HkuGAe3lfaBki3ST2t1+ydvfLY9qEXdLVw0dPpcdlPU4YPYzW/IO4yYo/OCV?=
 =?us-ascii?Q?Gx0sDJrVi8kkrGQBfSmdGkOOoYeVGOTbJA0+AW0SF9mvit0YWrk26XEaq27v?=
 =?us-ascii?Q?RASFZp8DQCnHgqBL2ErEaCe28iHmxdhchKzwDDzHqnMQVjsZv1EBFAVIHSJC?=
 =?us-ascii?Q?ke33KUPVOqU6CMiacKQZHX+bgYngBkFvAEhOxMTfZSwR+HTP2s/iqdeCl/sK?=
 =?us-ascii?Q?EgV5h8M2CfVkXoxRKXCubxs4Slvy8+qiK0Fo1g+DjVVil57rXJU8C0nG3ROB?=
 =?us-ascii?Q?KBoKdr1LJTlVnTW0ZvG4g9yCDAIJB6eONC5U5dre7rOB06OYFKuATcYD0T9U?=
 =?us-ascii?Q?OcAxUJuvi5i3iYonFTT0klFM1AbC7e9Z0Ds87jGzxw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OP/iGgRX26+mOxvzl/+tMM+FDkSPSuV+HKQ7zg/4IogwWprAI44tiuDL/TQ/?=
 =?us-ascii?Q?bFGQ3wsPFzO2V/SEGBe5bSX4HjjiUVwbQuEZUrUacm+5QtlXpR7xTnSVFdQJ?=
 =?us-ascii?Q?PG3aMD7JiONduTHYFCzxHM24+yP+hfTWYxlrX4InwDi5Isi/3SmXzDAmRkjz?=
 =?us-ascii?Q?OacLpdP5Ucz4FVasA8a9vXC/fBM38kiQbyUXFYvwAIv+lNbZuaAbiXN+vtxe?=
 =?us-ascii?Q?3cmop3V49wJvteCvVKo0kUlnz6DSdUefArEzd2nGmk8F0pwPUCO02Ma9AsZ4?=
 =?us-ascii?Q?0peOJwRwupBHHAfp662NmFMJOszyemhsaupbur0c/ObVEFsTbtmoq1ElGcvA?=
 =?us-ascii?Q?WeltL+X8/x76f/7BNPYXI61tB5I3jwYSDsVimPmfbmo2AxmNlL1F27Tp3+5q?=
 =?us-ascii?Q?xeaIBIXdhTz/5tiw9EH8Q7GQNY0I9LnLEGXPpEBwMXSUuWCrxVs7wpGXVPN+?=
 =?us-ascii?Q?z4HkUdunSra9NxV2T2igAze27NMqX//efNLJa5O3cx6NIVuWw9zaMysGlBwF?=
 =?us-ascii?Q?xXB9xP298c2R0VaHqhbIrbfw1rgXP/50JDopKWPL3I1w26Wa0LfH2ZciMAHM?=
 =?us-ascii?Q?O36EAq8enMXMCTWWQIvTsYOuUw0ISBBZapN4om9cm0/ZPxfZXL+lUZRNJ7a9?=
 =?us-ascii?Q?wcxFcKtWTdajRPQlSHo5AWIcMp9nTo/+WLPuNlWUjiYQTZ0zGy7Fu3F9xkZM?=
 =?us-ascii?Q?16zoQLEpbdM06hz0UrLs5Zb/MQfDHgR0TR9I0BG/c3wyDxkiQUffhtqXkNJo?=
 =?us-ascii?Q?cDlKvfbI7NYMiijKSwiDKtH6VBjuBe52V+F1UkjL/2PTfBWn9Wfwd7qhwlEs?=
 =?us-ascii?Q?RrB0yTx/UuNvat57W/KZD175r0GnMU69mDHidExB1XKEhOBWC72VFxfcaupn?=
 =?us-ascii?Q?nBx9JCOWlko+hWT0X7cH24eGZI3G31b0W2p3QE2bQ3q3IDsPbM4eqTlt5BCI?=
 =?us-ascii?Q?wgP4JkC9o1aJWNDic3BuEwy9nv6lSRvyb/ZDJ7iFc2iaSC/OT7T5K52NKlgn?=
 =?us-ascii?Q?XIetrz7B07AhSfxct5EmV10JP52zBCo/c/I0gY+7cyB4t1mJVmvAVpdZLvXc?=
 =?us-ascii?Q?7NuYaSq1I54d4/PwN3P9Skgm1hMh7tFn2x1kK+Je9PjxprVBtkHBVEbc/7zl?=
 =?us-ascii?Q?tyNzYkF/y3V5+VRsuAbLLgnAzZ6tlQpbAt57Bp9NQog0BFnw0FYpbbbl6vP4?=
 =?us-ascii?Q?TSUD/uunkPwX4dIHRcrXXZchVNKt7HanYEWON5cCJ43ujVMlNgJbB6Pooqm2?=
 =?us-ascii?Q?NXoSu8ufH9lq2g8aofGyV//xrrfD0Qlg8x761fVz4PQ0kOK1FfqGWD3vyybX?=
 =?us-ascii?Q?3IrsL0SQk4OTQ6BHEQ8AyU7mqlTTY7Jy3RHKcoKFF2LF5HJZq6knilmq2V32?=
 =?us-ascii?Q?wjv5/HSqe6LsjkWzc4Rv4mKm8lTj4b87Jo2in9jad61fvtoMBJ6qGkSsbouF?=
 =?us-ascii?Q?JsA8rFJrFrcsKu1UHPv+va9VryqtfZNRw32uzkmBaATPsZvH79albQ4vwf95?=
 =?us-ascii?Q?qicW6M0LhbwSGnxjzpTdb+VO0ZImONh1K10fpYBBZF6nJ3CEKvqFMAg7ZHla?=
 =?us-ascii?Q?JmnxYZHbvH19Y727+QSRrzIOesU97OUV7F04H+nH?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eb642ba-7e25-4c00-4741-08dc6542b905
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 16:14:02.7654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eQMgL4gAAKImO8lMZuR6fOwwEVPmh8ORlY6NXvY1saT97ma12sXvs8Mro8sx4KUr11UEngJY6Bd6RNVE/mvP0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5970

On Thu, 18 Apr 2024 08:59:19 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> Add safe methods for reading and writing Rust values to and from
> userspace pointers.
> 
> The C methods for copying to/from userspace use a function called
> `check_object_size` to verify that the kernel pointer is not dangling.
> However, this check is skipped when the length is a compile-time
> constant, with the assumption that such cases trivially have a correct
> kernel pointer.
> 
> In this patch, we apply the same optimization to the typed accessors.
> For both methods, the size of the operation is known at compile time to
> be size_of of the type being read or written. Since the C side doesn't
> provide a variant that skips only this check, we create custom helpers
> for this purpose.
> 
> The majority of reads and writes to userspace pointers in the Rust
> Binder driver uses these accessor methods. Benchmarking has found that
> skipping the `check_object_size` check makes a big difference for the
> cases being skipped here. (And that the check doesn't make a difference
> for the cases that use the raw read/write methods.)
> 
> This code is based on something that was originally written by Wedson on
> the old rust branch. It was modified by Alice to skip the
> `check_object_size` check, and to update various comments, including the
> notes about kernel pointers in `WritableToBytes`.
> 
> Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> Reviewed-by: Trevor Gross <tmgross@umich.edu>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/types.rs   | 64 ++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/uaccess.rs | 79 ++++++++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 141 insertions(+), 2 deletions(-)
> 
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index 8fad61268465..9c57c6c75553 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
>
> +/// Types that can be viewed as an immutable slice of initialized bytes.
> +///
> +/// If a struct implements this trait, then it is okay to copy it byte-for-byte to userspace. This
> +/// means that it should not have any padding, as padding bytes are uninitialized. Reading
> +/// uninitialized memory is not just undefined behavior, it may even lead to leaking sensitive
> +/// information on the stack to userspace.
> +///
> +/// The struct should also not hold kernel pointers, as kernel pointer addresses are also considered
> +/// sensitive. However, leaking kernel pointers is not considered undefined behavior by Rust, so
> +/// this is a correctness requirement, but not a safety requirement.
> +///
> +/// # Safety
> +///
> +/// Values of this type may not contain any uninitialized bytes. This type must not have interior
> +/// mutability.
> +pub unsafe trait AsBytes {}
> +
> +// SAFETY: Instances of the following types have no uninitialized portions.
> +unsafe impl AsBytes for u8 {}
> +unsafe impl AsBytes for u16 {}
> +unsafe impl AsBytes for u32 {}
> +unsafe impl AsBytes for u64 {}
> +unsafe impl AsBytes for usize {}
> +unsafe impl AsBytes for i8 {}
> +unsafe impl AsBytes for i16 {}
> +unsafe impl AsBytes for i32 {}
> +unsafe impl AsBytes for i64 {}
> +unsafe impl AsBytes for isize {}
> +unsafe impl AsBytes for bool {}
> +unsafe impl AsBytes for char {}
> +unsafe impl AsBytes for str {}
> +// SAFETY: If individual values in an array have no uninitialized portions, then the array itself
> +// does not have any uninitialized portions either.
> +unsafe impl<T: AsBytes> AsBytes for [T] {}

nit: I would move `str` to here, since `str` is essentially `[u8]` with
UTF-8 guarantee.

> +unsafe impl<T: AsBytes, const N: usize> AsBytes for [T; N] {}



