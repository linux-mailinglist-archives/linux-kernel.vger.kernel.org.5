Return-Path: <linux-kernel+bounces-22329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDED829C3C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C35A289AF1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9812E4CDF4;
	Wed, 10 Jan 2024 14:13:29 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170454CDE1
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 14:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.crashing.org
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 40AEA6vC017173;
	Wed, 10 Jan 2024 08:10:07 -0600
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 40AEA6Zg017172;
	Wed, 10 Jan 2024 08:10:06 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Wed, 10 Jan 2024 08:10:05 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: richard clark <richard.xnu.clark@gmail.com>
Cc: Xi Ruoyao <xry111@xry111.site>, Mark Rutland <mark.rutland@arm.com>,
        gcc-help@gcc.gnu.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: undefined reference to `__aarch64_cas4_sync' error on arm64 native build
Message-ID: <20240110141005.GL19790@gate.crashing.org>
References: <ZZb2f0U4qTWDjCGj@FVFF77S0Q05N.cambridge.arm.com> <CAJNi4rOpzmQAW1Fjst-Em=SQ7q8QsQh0PWhVxUizrOW9JukOgQ@mail.gmail.com> <ZZvS8rigFJR8L56c@FVFF77S0Q05N> <fb6c8253fd90e66c036a85954c3299bc2c047473.camel@xry111.site> <CAJNi4rPj0Wc7ByqrS-GVLUUEnOFPZi8A5nLLCEEJErqAe16EZw@mail.gmail.com> <9aef98eed96ed32962ce90499291cb30ad5e3e14.camel@xry111.site> <20240109074843.GI19790@gate.crashing.org> <4ee8067e72028b070d92e10fa33ddde3a498cb48.camel@xry111.site> <20240109082647.GJ19790@gate.crashing.org> <CAJNi4rM_w5JKjug1PtV+tHyk11DUhRJ-K1pSDE6P1x8KSU2wrg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJNi4rM_w5JKjug1PtV+tHyk11DUhRJ-K1pSDE6P1x8KSU2wrg@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i

On Wed, Jan 10, 2024 at 01:59:53PM +0800, richard clark wrote:
> A ported driver in linux kernel calls '__sync_val_compare_and_swap',

That is a builtin function.  It does not necessarily expand to an actual
function call.  aarch64 will typically expand it to inline code.

> the cross-compiler 'aarch64-linux-gnu-gcc' doesn't complain
> '__aarch64_cas1_sync' undefined reference, but the native compiler
> will complain. As Mark mentioned, I double check that both cross and
> native compiler should have  ''-moutline-atomics' option enabled, do
> you know the reason for that?

Ah, so you are requesting external functions.

I am no aarch64 expert, but apparently there were some problems in
GCC 11, maybe that is what you saw?  Or with some distros, anyway.

It also matters if you have ARMv8.1-A enabled, the LSE instructions.

Open a GCC bug report if you have more details?  Thanks,


Segher

