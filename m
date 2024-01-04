Return-Path: <linux-kernel+bounces-17082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7B882480E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 19:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05E9A282E66
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444A728DD8;
	Thu,  4 Jan 2024 18:18:50 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FBC28DCC
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 18:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 791CFC15;
	Thu,  4 Jan 2024 10:19:31 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.29.139])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D4AFE3F5A1;
	Thu,  4 Jan 2024 10:18:44 -0800 (PST)
Date: Thu, 4 Jan 2024 18:18:39 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: richard clark <richard.xnu.clark@gmail.com>
Cc: gcc-help@gcc.gnu.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: undefined reference to `__aarch64_cas4_sync' error on arm64
 native build
Message-ID: <ZZb2f0U4qTWDjCGj@FVFF77S0Q05N.cambridge.arm.com>
References: <CAJNi4rO+Dw5qYDtyJVbuo0OqAoXpGq_Qq6xjH9cvMCAUnW+77g@mail.gmail.com>
 <CAJNi4rMHtM=39jzkzwqt++kVpSp0=XfDrVdY94WoW6B34oKwDA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJNi4rMHtM=39jzkzwqt++kVpSp0=XfDrVdY94WoW6B34oKwDA@mail.gmail.com>

On Tue, Jan 02, 2024 at 04:53:53PM +0800, richard clark wrote:
> Ah, the driver is trying to use the native gcc built atomic ops like:
> __sync_val_compare_and_swap, but it seems the native aarch64 doesn't
> provide these builtin atomic primitives while they are in the cross
> compile toolchain.
> The issue can be resolved by replacing the
> **__sync_val_compare_and_swap** with **atomic_cmpxchg**.

Yup, that's the right thing to do; drivers *shouldn't* use the builtins
directly, and *should* use the kernel's native atomic*() API.

> But don't know why the native aarch64 toolchain doesn't have those
> builtin atomic functions...

I suspect this is down to your toolchain enabling -moutline-atomics by default;
that expands the builtins into calls to out-of-line functions. I suspect your
cross-compile toolchain doesn't enable that by default.

As above, since nothing should be using the builtins, we don't implement
out-of-line versions nor do we override the option.

Mark.

> On Tue, Jan 2, 2024 at 11:29 AM richard clark
> <richard.xnu.clark@gmail.com> wrote:
> >
> > Hi,
> >
> > I have a strong power arm64 box, and the linux distro is ubuntu 22.04,
> > the native gcc version is:
> >
> > $ gcc --version
> > gcc (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0
> > Copyright (C) 2021 Free Software Foundation, Inc.
> > This is free software; see the source for copying conditions.  There is NO
> > warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> >
> > It will abort the kernel build with the complaint by 'make Image':
> > ld: Unexpected GOT/PLT entries detected!
> > ld: Unexpected run-time procedure linkages detected!
> > ld: ID map text too big or misaligned
> > ld: drivers/net/nvidia_eth.o: in function `osi_lock_irq_enabled':
> > osi_hal.c:(.text+0x3cc): undefined reference to `__aarch64_cas4_sync'
> > ...
> >
> > But the cross-compile with aarch64-linux-gnu-gcc on the x86 box
> > doesn't show the above error message.
> > Any comments/suggestions? Thanks very much!
> >
> > Richard
> 

