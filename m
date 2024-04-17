Return-Path: <linux-kernel+bounces-148675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 626AA8A85F0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DBF3B23FE4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B527F1411FF;
	Wed, 17 Apr 2024 14:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="wKj+W5PF"
Received: from GBR01-LO4-obe.outbound.protection.outlook.com (mail-lo4gbr01on2114.outbound.protection.outlook.com [40.107.122.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0779130E49;
	Wed, 17 Apr 2024 14:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.122.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713364089; cv=fail; b=TDp0XwNFSRn1mA0Ns2xuU3ZpTTkgTdN6RQoqpHYz8+VVaNXfhv2tBn7eplcI+PcpmpF/SEqVBWNVV2W7wUSB98+dRGo4mJ7QWaS3PWFT3hM9RgY3/pznolXzMvMPJUYa46+GgsEnFiru22VWucAPbVUAERnsQ9ONJXd92+mmPTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713364089; c=relaxed/simple;
	bh=CGBGCpwOliPyRurQ80FF+tSYGGbsLS4J11vNJ0AZYZU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YBaKJlGtRK7yuizX1iCrACm27ibpQImdnAPsMBrY7cFHQ3WjWRkboESjnYScsSwXx9AEWLu7T2Iy8VjFE7AavlQLx5ksPBOiagk8ALjguoHzTtn2y5jsGUhtLdl3Ag//hKAx0SEN8LDafP53IiilTa8Bafo+aun5idFz0dM5Owk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=wKj+W5PF; arc=fail smtp.client-ip=40.107.122.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wj7TsoS8a/cR1aj28gIf3ZmVa+I9jsvkO9sQY9YRnJlXvKWswWBuB0rM1WENXQfjk/PHoWA+9EI6RMOMtKcpjbV8h8NLhCKHwSZMuNLzFd+75xxp2v04rvUDodRMV73DKTBAjWHsCvKON5a1k4umVZTUL+fRhjHIF02vJ5qfmEIYSJdvfOLlgkC+U/0DIx4SBj6q6qJ8BZbTbgJoNZvgIUpjbBTQFAn87cFGih3VPTq+3vgi2k6obNbUVU+JB65OB17eaDmJlfkd0TDzMi4rTSsf+dsvrwTXo8QnnK65ixlTaoS4s+vKKVr1n2g4QfczPzEDrUJ5IId6QTfadVyhaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PF75RdJ+QAW1nyMYqxL1I+huyJL4/BHdBraF44WXevk=;
 b=mJ3CeFI1lRUe6CuOvmdJ/Mmu97Eyc0IdMxIj0/yTQeRCIko7e6kPcOLELRNSBHIBW16VgfB1s6o0JggyMkkMDipnrWfCFSRMjZLo+9+KC/LjNPo8VNwGuztJyE8OVcWvBmpVgBWzNXhg8NDMjf+D9UHi2ngcDuMDBbJ9PGUai/Gu4vDq12JfFPAiD1udWBCSKcuwJBmvtHFWlOwXX5D8rHpGuSgPVbcZIy9kr7XqNuWYW0/EqCSLda4E1IcHq9XfDavtZyZI0/EnGj6y/XrBWMQHqGGHalwgFwFHTeDURM3xGcMcFXdCtudJKhALiVoU8Ll+YdDfIHdUPJacw0nYIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PF75RdJ+QAW1nyMYqxL1I+huyJL4/BHdBraF44WXevk=;
 b=wKj+W5PFLlRA+qijFrfOFWxS/2yCHfjIaLgfwhup20A6iqKMImVTF2TPAxxIjBOz60fbJmCltQ4U2hZ73y3oyQaofhua8iuvNNuNNjWWJfj4RD3moN504WqrZ+01VEx+UPnhGAlomC/ECH+ARmLKZ5jJ1Gez7bIvh2OOybQbduE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO0P265MB6244.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:24f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 14:28:05 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%4]) with mapi id 15.20.7472.037; Wed, 17 Apr 2024
 14:28:05 +0000
Date: Wed, 17 Apr 2024 15:28:02 +0100
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
 Bergmann <arnd@arndb.de>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v5 1/4] rust: uaccess: add userspace pointers
Message-ID: <20240417152802.6b7a7384@eugeo>
In-Reply-To: <20240415-alice-mm-v5-1-6f55e4d8ef51@google.com>
References: <20240415-alice-mm-v5-0-6f55e4d8ef51@google.com>
	<20240415-alice-mm-v5-1-6f55e4d8ef51@google.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0027.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::17) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO0P265MB6244:EE_
X-MS-Office365-Filtering-Correlation-Id: 186b6d43-0464-4a33-7434-08dc5eea9829
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7meGKXMMnJdz33eLMJYcqpzUQJ6ZJBO7DAax8BAv8pOMWOikj9NxiMLTP57WsYM0MX2an98ZmrxJvlrPHiGZ30Uw3aBpR1dgEixCeef2bNC6eSB6HpjDEO8OqhivRG+hh1BktkSa/8l/y+ojN/DoZ5T6WUkiUh2bCskdFozBfMVAiD7Ql0Zhkn+EiUCjb+yyCT4kVGY8yguGv1eSD14utuXbXdaCpSb7KJlEqXt04fO/1oIM6CZLH9EZpzNkdLxNW7lGtBP6heYwdyyfRnHWxDrhWAWDMnV1A3ZVHC/5uxGqWnCxhz7Y5ReZGHXSykWf+Gh9LM88SjDQWabRYMrJXTzIROCXbGdUgo12+vSI4eVw6mO70w5YLX6/cWM3dLlVDLxUoeIrD3xci6gXVu4xGLre0WwOZWVxt2w5vv+CbDYl6+Nazz15wMBqGMBhXqjrkiK9/HmW82mZitBdFOHSM2US/WfvH2GpiadQBAg6C9zz4DWe44L/+S+V7BfEiv7SFjdAD+815XECSCAoX8cImNSWvDZwY8lH/9GQt5+CmoiIt5zmGY40QicjDHo2YBalHNZR5y0Jl2B+MYt80kYIGhy6Ze5VXDrnfNYgDM5KH0M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2cpmFHx78YYL78BKC7gf3KbBoEF895mCXVOt30eG7j8zvxgIAY8kZzp/CfVP?=
 =?us-ascii?Q?eE/v/38PQoAS1MBydVhZ7B551QtpLnTteYqQ8bIUJ39ebj5rR338fgGFiKu2?=
 =?us-ascii?Q?h689MVWolWyEiaptnJz+5czdEfooaCL175DJ5QLrtqtKCyXLzLBqpaF2Y/AB?=
 =?us-ascii?Q?1iVipjmwzwFAgtYxg0N5vN8Xw1OHdo7rV5wdU+VqrXJwxIj/TcgGL7jytZf3?=
 =?us-ascii?Q?VAKUGeBHt1wI7BkpAEdXKEBT3ACRru9B3x4xxDIaDSAmUWTO+GCSC9TOKIAv?=
 =?us-ascii?Q?Ai7fYy3w+QUDbIBZXlEnQpAO4chgeZ33WLbi4aPkiz0Ra4Za0iOhnO9yBifh?=
 =?us-ascii?Q?+tzzBKOn84wWa799Ium7XT6by7K1YMd+VmoSL/ZxjJGTttNrGCnJiLQaMsJL?=
 =?us-ascii?Q?/IaSoLlWM4pd4FsQPSGsyQ8hkIPnvQuvdLdFUS3m/OJ6czX/D9faJZLrKcKT?=
 =?us-ascii?Q?o+QBLaToHfFaDcXbbXGGVFwm/ZJj78VDjDsNYU26Kb/g7j13Pka3843uUjr1?=
 =?us-ascii?Q?pdHAccxqf26GL3Gjye9L30HAqDHM5OnkWaV59AXY5lANys6b8iC8BV7k2yZo?=
 =?us-ascii?Q?VPh68wBx3l261JVLTgmOx00qQI0Z1ODBaLFL5aGiihT+3xvBNdaos/jkufOJ?=
 =?us-ascii?Q?FAKk6E9k8uukZyS1sE9EzFtpJupmZSIhH5K2lxKNqvhCWm81LynCB8GIJhC7?=
 =?us-ascii?Q?OZvXd/pnU9PtVWP6JMaeGNuNweAbXdkyAtsvsrNj06vorGoXSJ9jIYwxR9Fv?=
 =?us-ascii?Q?vgO/X5ZsXjl0fYcdoH+sS99K7Xmo1hh7Ap6XFMbD6cCeyrMfXuLor2IJVnal?=
 =?us-ascii?Q?F6Wr1JUWvq1nDEXj3XuLzwiEmnfATXw2QEeztliw7HwNjXQ6uTIbjWiXas/k?=
 =?us-ascii?Q?jczYv/6JKt4dxxa9Szz2eGXvxtK5iqyvE/mvRaL3bookh6VixIvVIwd2npyH?=
 =?us-ascii?Q?2+gcdvQrbXIcSU0dlR//J2q7qodEIjJb8XH/fthjP5+m9x7vLSFI6Pez9QnZ?=
 =?us-ascii?Q?KOQpkf6g1x8czs0Kqfo78A+23mOUo+4JQmyR/CwZ3YpMEYLpwc4hD9ruuYFZ?=
 =?us-ascii?Q?FfXf2ycAUK7W6hlXDnFPc0AMa15WaBBl7DVam1+lDwf6GL62bPKwjFavzz0M?=
 =?us-ascii?Q?00NFP5FKIJJn5V0Ue3uoQFKLxw3gtiEwKrZvqreRQ2m+VdZjU8hp3/m63Se8?=
 =?us-ascii?Q?RVOsZ6tOWkoHNPutR2+ZIZ9gv6gvNw1V/Wr2iamt9tY0R3I11+NUguxgOQb4?=
 =?us-ascii?Q?eSxfJTYsdmitVBi3K9jVvH201YD3ION/t2vRdmxtJmb4UtAS0NTwIRyoe199?=
 =?us-ascii?Q?0xd5v8+v2Pr/E7mj91gcOQuOT1YuK5fRSJS02SMymGRwSX3PIvASB8SoVBG9?=
 =?us-ascii?Q?ZyrUnQSL8eQyNXbaRUNT2LnoIXBrrolq2eoguNEuZjFARnLH1k0b2cDEfH8/?=
 =?us-ascii?Q?VfA3FnjfsTx2gA/e/4lBVk0appFVHnIDgIDq9Ncc9lwu+yRrl0MRefSeRoYs?=
 =?us-ascii?Q?1F3vZDT77Gf4j7NXginVwcL7FJTgMyx2dM39lAaIthsv0qLnUi9QtertdYB4?=
 =?us-ascii?Q?7LvpbmnHq7zHr/wGQArExjNc3UtlSrVJ0hsNTXwm?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 186b6d43-0464-4a33-7434-08dc5eea9829
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 14:28:04.9565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K9FqaBId04hA0Cit0UsWXUVy3f5Kbbr3oJJkWVRBTQ8VzU3b0l1YkWCV1+PERfGxMl5boWaHqvIuSxoZCLxfWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB6244

On Mon, 15 Apr 2024 07:13:53 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> From: Wedson Almeida Filho <wedsonaf@gmail.com>
> 
> A pointer to an area in userspace memory, which can be either read-only
> or read-write.
> 
> All methods on this struct are safe: attempting to read or write on bad
> addresses (either out of the bound of the slice or unmapped addresses)
> will return `EFAULT`. Concurrent access, *including data races to/from
> userspace memory*, is permitted, because fundamentally another userspace
> thread/process could always be modifying memory at the same time (in the
> same way that userspace Rust's `std::io` permits data races with the
> contents of files on disk). In the presence of a race, the exact byte
> values read/written are unspecified but the operation is well-defined.
> Kernelspace code should validate its copy of data after completing a
> read, and not expect that multiple reads of the same address will return
> the same value.
> 
> These APIs are designed to make it difficult to accidentally write
> TOCTOU bugs. Every time you read from a memory location, the pointer is
> advanced by the length so that you cannot use that reader to read the
> same memory location twice. Preventing double-fetches avoids TOCTOU
> bugs. This is accomplished by taking `self` by value to prevent
> obtaining multiple readers on a given `UserSlicePtr`, and the readers
> only permitting forward reads. If double-fetching a memory location is
> necessary for some reason, then that is done by creating multiple
> readers to the same memory location.
> 
> Constructing a `UserSlicePtr` performs no checks on the provided
> address and length, it can safely be constructed inside a kernel thread
> with no current userspace process. Reads and writes wrap the kernel APIs
> `copy_from_user` and `copy_to_user`, which check the memory map of the
> current process and enforce that the address range is within the user
> range (no additional calls to `access_ok` are needed).
> 
> This code is based on something that was originally written by Wedson on
> the old rust branch. It was modified by Alice by removing the
> `IoBufferReader` and `IoBufferWriter` traits, and various other changes.
> 
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Co-developed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/helpers.c         |  14 +++
>  rust/kernel/lib.rs     |   1 +
>  rust/kernel/uaccess.rs | 304 +++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 319 insertions(+)
> 
> diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs

> +/// [`std::io`]: https://doc.rust-lang.org/std/io/index.html
> +/// [`clone_reader`]: UserSliceReader::clone_reader
> +pub struct UserSlice {
> +    ptr: *mut c_void,
> +    length: usize,
> +}

How useful is the `c_void` in the struct and new signature? They tend
to not be very useful in Rust. Given that provenance doesn't matter
for userspace pointers, could this be `usize` simply?

I think `*mut u8` or `*mut ()` makes more sense than `*mut c_void` for
Rust code even if we don't want to use `usize`.

---

Some thinking aloud and brainstorming bits about the API.

I wonder if it make sense to have `User<[u8]>` instead of `UserSlice`?
The `User` type can be defined like this:

```rust
struct User<T: ?Sized> {
   ptr: *mut T,
}
```

and this allows arbitrary T as long as it's POD. So we could have
`User<[u8]>`, `User<u32>`, `User<PodStruct>`. I imagine the
`User<[u8]>` would be the general usage and the latter ones can be
especially helpful if you are trying to implement ioctl and need to
copy fixed size data structs from userspace.

Best,
Gary







