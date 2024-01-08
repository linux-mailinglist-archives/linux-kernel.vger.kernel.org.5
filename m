Return-Path: <linux-kernel+bounces-19357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE24826BDC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E9E31C221D1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7385614009;
	Mon,  8 Jan 2024 10:51:13 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F0113FF9
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 10:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55EA32F4;
	Mon,  8 Jan 2024 02:51:56 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.89.149])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7BE343F5A1;
	Mon,  8 Jan 2024 02:51:09 -0800 (PST)
Date: Mon, 8 Jan 2024 10:51:03 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: richard clark <richard.xnu.clark@gmail.com>
Cc: gcc-help@gcc.gnu.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: undefined reference to `__aarch64_cas4_sync' error on arm64
 native build
Message-ID: <ZZvS8rigFJR8L56c@FVFF77S0Q05N>
References: <CAJNi4rO+Dw5qYDtyJVbuo0OqAoXpGq_Qq6xjH9cvMCAUnW+77g@mail.gmail.com>
 <CAJNi4rMHtM=39jzkzwqt++kVpSp0=XfDrVdY94WoW6B34oKwDA@mail.gmail.com>
 <ZZb2f0U4qTWDjCGj@FVFF77S0Q05N.cambridge.arm.com>
 <CAJNi4rOpzmQAW1Fjst-Em=SQ7q8QsQh0PWhVxUizrOW9JukOgQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJNi4rOpzmQAW1Fjst-Em=SQ7q8QsQh0PWhVxUizrOW9JukOgQ@mail.gmail.com>

On Mon, Jan 08, 2024 at 09:28:56AM +0800, richard clark wrote:
> On Fri, Jan 5, 2024 at 2:18 AM Mark Rutland <mark.rutland@arm.com> wrote:
> > On Tue, Jan 02, 2024 at 04:53:53PM +0800, richard clark wrote:
> > > But don't know why the native aarch64 toolchain doesn't have those
> > > builtin atomic functions...
> >
> > I suspect this is down to your toolchain enabling -moutline-atomics by default;
> > that expands the builtins into calls to out-of-line functions. I suspect your
> > cross-compile toolchain doesn't enable that by default.
> >
> > As above, since nothing should be using the builtins, we don't implement
> > out-of-line versions nor do we override the option.
> >
> AFAIK, the native build for the kernel will not link to the libc.so
> but the userland application does, the builtin atomic primitives are
> implemented in the glibc:
> target-host $ objdump -t /lib/aarch64-linux-gnu/libc.so.6 | grep __aarch64_cas4
> 0000000000130950 l     F .text 0000000000000034 __aarch64_cas4_relax
> 0000000000130a10 l     F .text 0000000000000034 __aarch64_cas4_rel
> 0000000000130990 l     F .text 0000000000000034 __aarch64_cas4_acq
> seems the '__sync_val_compare_and_swap' used in the application will
> be renamed to _aarch64_cas4_{relax, rel, acq}. so the kernel will
> complain it will
> link to an 'undefined reference'. But interesting, why the
> cross-compile kernel will not generate the 'undefined reference', the
> cross-compile/build kernel will link to the glibc?

This is due to a difference in default options between the two compilers; the
kernel isn't linked against libc in either case.

Your native compiler evidently has -moutline-atomics enabled in its default
options. With that enabled, the builtin atomics generate calls to out-of-line
functions which the kernel itself does not provide, and hence those result in a
link-time error.

Your cross-compiler evidently does not have -moutline-atomics enabled in its
default options. Without that enabled, the builtin atomics generate inline
atomic instructions rather than function calls. Since these don't depend on
external functions there's no link-time error.

If you pass 'mno-outline-atomics' to your native compiler, the problem should
disappear.

Mark.

