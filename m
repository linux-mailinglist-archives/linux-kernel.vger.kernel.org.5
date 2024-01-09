Return-Path: <linux-kernel+bounces-20609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 106E282825A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2A652813C7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C36A250F5;
	Tue,  9 Jan 2024 08:42:51 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A446FD2
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 08:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.crashing.org
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 4097miYa016493;
	Tue, 9 Jan 2024 01:48:44 -0600
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 4097mh2R016492;
	Tue, 9 Jan 2024 01:48:43 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Tue, 9 Jan 2024 01:48:43 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Xi Ruoyao <xry111@xry111.site>
Cc: richard clark <richard.xnu.clark@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>, gcc-help@gcc.gnu.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: undefined reference to `__aarch64_cas4_sync' error on arm64 native build
Message-ID: <20240109074843.GI19790@gate.crashing.org>
References: <CAJNi4rO+Dw5qYDtyJVbuo0OqAoXpGq_Qq6xjH9cvMCAUnW+77g@mail.gmail.com> <CAJNi4rMHtM=39jzkzwqt++kVpSp0=XfDrVdY94WoW6B34oKwDA@mail.gmail.com> <ZZb2f0U4qTWDjCGj@FVFF77S0Q05N.cambridge.arm.com> <CAJNi4rOpzmQAW1Fjst-Em=SQ7q8QsQh0PWhVxUizrOW9JukOgQ@mail.gmail.com> <ZZvS8rigFJR8L56c@FVFF77S0Q05N> <fb6c8253fd90e66c036a85954c3299bc2c047473.camel@xry111.site> <CAJNi4rPj0Wc7ByqrS-GVLUUEnOFPZi8A5nLLCEEJErqAe16EZw@mail.gmail.com> <9aef98eed96ed32962ce90499291cb30ad5e3e14.camel@xry111.site>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9aef98eed96ed32962ce90499291cb30ad5e3e14.camel@xry111.site>
User-Agent: Mutt/1.4.2.3i

On Tue, Jan 09, 2024 at 11:05:57AM +0800, Xi Ruoyao via Gcc-help wrote:
> But the Linux kernel cannot use neither libc.so nor libgcc.a.

I have built Linux using libgcc for many years.  It is as easy as

+LIBGCC := $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name)
+libs-y += $(LIBGCC)

> (I know
> some non-Linux kernel developers are overusing libgcc.a for kernels, but
> IMO this is just wrong and Linux developers also do not do this.  If the
> Linux kernel needs a symbol from libgcc the developers just provide
> their own implementation.)

Yes, and often they have fallen behind.  When they eventually catch up
they usually just copy the GCC code anyway.

Originally the only reasonable argument for not linking against libgcc
was so kernel code would not accidentally use double-length divisions.
There are other simple ways to have all uses of __divti3 and similar
create link errors, so that is not really a good argument.

libgcc is an essential part of the compiler.  For most targets, for most
code, GCC will not generate function calls, there usually are faster (or
smaller) things it can do, but it still is necessary to have libgcc for
more uncommon things.  Using a partial copy of it, behind the times,
and maybe even incompatible, is not a great idea.


Segher

