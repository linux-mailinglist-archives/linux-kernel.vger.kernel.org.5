Return-Path: <linux-kernel+bounces-30916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8788A8325DF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 09:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DECC28460E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 08:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41EA223748;
	Fri, 19 Jan 2024 08:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUoTSPkL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7915D20300;
	Fri, 19 Jan 2024 08:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705653746; cv=none; b=TFPaIAp0+NGp65Qjbzd9TmnwWqWabo9xSSSuBrNqYIXzWxSNbwbamtjfs6ZNIt0ZvtvWIPO7QeHhLiFdMZjnSSqZBvt3KoG/HFb0x0sovRGt8zHHzYpWoxKgHUqN9tUuhOOvInhDnVmxxF0LWrpad83cgUYIIXsUiYmS4PsEAQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705653746; c=relaxed/simple;
	bh=g5BoGuy/aNMWgkh7HES0ckmxP53aa40fqWFfKkEi5ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QB1K6SUMUM1l5STdyUXAz59oEKP9hl94rIv8memLXTxKbfzK/wy+/VOAy9gKtB05iCwzWAHF101DN5WsBb6IYxVQlpNv3y9/L22wfRH0qxzxXnHpIp4XwDCnv2jX2g63uNkSC6mCw7KP4Y71166nx/ocBCV0dXdoTz+xqcaQsUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUoTSPkL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D732C433F1;
	Fri, 19 Jan 2024 08:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705653745;
	bh=g5BoGuy/aNMWgkh7HES0ckmxP53aa40fqWFfKkEi5ao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RUoTSPkLvPmGnMVOMJ1HuVQU6XfFhUmlMpbTrKyG6U8fqip+jV7+oHYufClRc2Byz
	 I3fuHmD32xA9G5aC/qgCk0gYD2vI2MQEFi09W0zbpuY8l7bMAjiVnFVTxzbC5teWMK
	 2ts22XzYj3hQvM/l0YmrlVjXLWu1vB29XDBEUj8NHEI4CKzhcPgj4wkLqJgR+twtIi
	 1e1W7S0aNeD7srev8SEKpVES97FlgnMqaSwICysppCZPOJOdR/q6MZgPu4DkdBn1e1
	 eGJEwySey3GhtxwqiPhQicHsJSJpxONbZ8rdyTC8j8SjIWuLoAXc0bc1dmrqTx86DO
	 cHge1k3R0OABQ==
Date: Fri, 19 Jan 2024 10:42:04 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Shijie Huang <shijie@amperemail.onmicrosoft.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	Huang Shijie <shijie@os.amperecomputing.com>,
	gregkh@linuxfoundation.org, patches@amperecomputing.com,
	rafael@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, kuba@kernel.org, vschneid@redhat.com,
	mingo@kernel.org, akpm@linux-foundation.org, vbabka@suse.cz,
	tglx@linutronix.de, jpoimboe@kernel.org, ndesaulniers@google.com,
	mikelley@microsoft.com, mhiramat@kernel.org, arnd@arndb.de,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
	will@kernel.org, mark.rutland@arm.com, mpe@ellerman.id.au,
	linuxppc-dev@lists.ozlabs.org, chenhuacai@kernel.org,
	jiaxun.yang@flygoat.com, linux-mips@vger.kernel.org,
	cl@os.amperecomputing.com
Subject: Re: [PATCH] NUMA: Early use of cpu_to_node() returns 0 instead of
 the correct node id
Message-ID: <Zao13I4Bb0tur0fZ@kernel.org>
References: <20240119033227.14113-1-shijie@os.amperecomputing.com>
 <Zan9sb0vtSvVvQeA@yury-ThinkPad>
 <1cd078fd-c345-4d85-a92f-04c806c20efa@amperemail.onmicrosoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1cd078fd-c345-4d85-a92f-04c806c20efa@amperemail.onmicrosoft.com>

On Fri, Jan 19, 2024 at 02:46:16PM +0800, Shijie Huang wrote:
> 
> 在 2024/1/19 12:42, Yury Norov 写道:
> > This adds another level of indirection, I think. Currently cpu_to_node
> > is a simple inliner. After the patch it would be a real function with
> > all the associate overhead. Can you share a bloat-o-meter output here?
> #./scripts/bloat-o-meter vmlinux vmlinux.new
> add/remove: 6/1 grow/shrink: 61/51 up/down: 1168/-588 (580)
> Function                                     old     new   delta
> numa_update_cpu                              148     244     +96
> 
>  ...................................................................................................................................(to many to skip)
> 
> Total: Before=32990130, After=32990710, chg +0.00%
 
It's not only about text size, the indirect call also hurts performance
 
> > 
> > Regardless, I don't think that the approach is correct. As per your
> > description, some initialization functions erroneously call
> > cpu_to_node() instead of early_cpu_to_node() which exists specifically
> > for that case.
> > 
> > If the above correct, it's clearly a caller problem, and the fix is to
> > simply switch all those callers to use early version.
> 
> It is easy to change to early_cpu_to_node() for sched_init(),
> init_sched_fair_class()
> 
> and workqueue_init_early(). These three places call the cpu_to_node() in the
> __init function.
> 
> 
> But it is a little hard to change the early_trace_init(), since it calls
> cpu_to_node in the deep
> 
> function stack:
> 
>   early_trace_init() --> ring_buffer_alloc() -->rb_allocate_cpu_buffer()
> 
> 
> For early_trace_init(), we need to change more code.
> 
> 
> Anyway, If we think it is not a good idea to change the common code, I am
> oaky too.
 
Is there a fundamental reason to have early_cpu_to_node() at all?
It seems that all the mappings are known by the end of setup_arch() and the
initialization of numa_node can be moved earlier. 
 
> > I would also initialize the numa_node with NUMA_NO_NODE at declaration,
> > so that if someone calls cpu_to_node() before the variable is properly
> > initialized at runtime, he'll get NO_NODE, which is obviously an error.
> 
> Even we set the numa_node with NUMA_NO_NODE, it does not always produce
> error.
> 
> Please see the alloc_pages_node().
> 
> 
> Thanks
> 
> Huang Shijie
> 

-- 
Sincerely yours,
Mike.

