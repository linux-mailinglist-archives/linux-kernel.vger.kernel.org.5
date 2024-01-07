Return-Path: <linux-kernel+bounces-18952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF6B826596
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 19:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0FE02815E5
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 18:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CD9111B0;
	Sun,  7 Jan 2024 18:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tum.de header.i=@tum.de header.b="GeWplGkk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from postout1.mail.lrz.de (postout1.mail.lrz.de [129.187.255.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5583B111BD;
	Sun,  7 Jan 2024 18:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tum.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tum.de
Received: from lxmhs51.srv.lrz.de (localhost [127.0.0.1])
	by postout1.mail.lrz.de (Postfix) with ESMTP id 4T7QXn28G3zyTZ;
	Sun,  7 Jan 2024 19:22:49 +0100 (CET)
Authentication-Results: postout.lrz.de (amavisd-new); dkim=pass (2048-bit key)
	reason="pass (just generated, assumed good)" header.d=tum.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tum.de; h=
	in-reply-to:content-transfer-encoding:content-disposition
	:content-type:content-type:mime-version:references:message-id
	:subject:subject:from:from:date:date:received:received; s=
	tu-postout21; t=1704651768; bh=DY2NeegPvDuYc7q9sD4qdhEYd83m+YBsQ
	XNiUYkZvL0=; b=GeWplGkklJrYhr0n0+tH6jD8ZDfKz4bKpyyKvV8IEMY+2z1yk
	acmU9bNWLSY7w5xcgBuihLEFQVu8TV4GWLjXaQPiFr4Gi91y350SytQ5qRtyQIXR
	Xy8LHmY6c2Q3xg+fBVYP+rBnvYAzC1hZ4kRs8tRwVT95Xv7vreqJhv7x2pNJ5qio
	9O6egFdE91R6W29YZrnDGFLLuBFVOUF/uUWo2eYxTDGa71ekm5Qwt86vp3TZXdWH
	vqtTTzDn+147tBw5nb8QYslOeRFRh7SMLoIQv1uUH4l/vL21DSTPL8NxlDl5UtF2
	6Ou5OLYmiKtnyMgd9VqaLCYv2GRVxcZdXX5aA==
X-Virus-Scanned: by amavisd-new at lrz.de in lxmhs51.srv.lrz.de
X-Spam-Flag: NO
X-Spam-Score: -2.881
X-Spam-Level:
Received: from postout1.mail.lrz.de ([127.0.0.1])
	by lxmhs51.srv.lrz.de (lxmhs51.srv.lrz.de [127.0.0.1]) (amavisd-new, port 20024)
	with LMTP id SnoGITx3fP0N; Sun,  7 Jan 2024 19:22:48 +0100 (CET)
Received: from cerulean.fritz.box (unknown [IPv6:2001:a61:24c8:fe01:dd4e:2513:1e73:cb01])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by postout1.mail.lrz.de (Postfix) with ESMTPSA id 4T7QXl54jLzySv;
	Sun,  7 Jan 2024 19:22:47 +0100 (CET)
Date: Sun, 7 Jan 2024 19:22:40 +0100
From: Paul =?utf-8?Q?Heidekr=C3=BCger?= <paul.heidekrueger@tum.de>
To: Marco Elver <elver@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Peter Collingbourne <pcc@google.com>, andrey.konovalov@linux.dev, 
	Andrew Morton <akpm@linux-foundation.org>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	kasan-dev@googlegroups.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Andrey Konovalov <andreyknvl@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: Re: [PATCH v3 1/3] kasan: switch kunit tests to console
 tracepoints
Message-ID: <h7qw4rhqovyq5trm5kyvabshqmxcpwlrdr55xadhtv5iifxjem@gz4wjtng7b42>
References: <n37j6cbsogluma25crzruaiq7qcslnjeoroyybsy3vw2cokpcm@mh7r3ocp24cb>
 <CA+fCnZebmy-fZdNonrgLofepTPL5hU6P8R37==sygTLBSRoa+w@mail.gmail.com>
 <fv7fn3jivqcgw7mum6zadfcy2fbn73lygtxyy5p3zqpelfiken@5bmhbdufxgez>
 <CA+fCnZfQEueCifc-8d5NVWEUtAiOG1eRW-LFKbOhab_Y7jqU0Q@mail.gmail.com>
 <osqmp2j6gsmgbkle6mwhoaf65mjn4a4w3e5hsfbyob6f44wcg6@7rihb5otzl2z>
 <CANpmjNMw3N09x06Q+0mFCEeTKfUsDdXwXM2hdgAQ+wwbZGpB9w@mail.gmail.com>
 <rbcdbilhh67fvjdgnstu25v4jnfeesthoxstnzzglynbngu5bk@5ozwgzaulbsx>
 <CA+fCnZf5kxWUWCzK8EKgUuq_E2rYv5aw=SqZMDb93+=7vSUp+w@mail.gmail.com>
 <rgndtm3sawyzdh76oofoqp22jyqdb25sd4326k2heevjmxum7f@wfgwvdf4iuyi>
 <CANpmjNN5Q+byA3sWv1uB_R=QYQxKg5YsLKayqv7WNWokkL5H4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANpmjNN5Q+byA3sWv1uB_R=QYQxKg5YsLKayqv7WNWokkL5H4Q@mail.gmail.com>

On 12.12.2023 10:32, Marco Elver wrote:
> On Tue, 12 Dec 2023 at 10:19, Paul Heidekrüger <paul.heidekrueger@tum.de> wrote:
> >
> > On 12.12.2023 00:37, Andrey Konovalov wrote:
> > > On Tue, Dec 12, 2023 at 12:35 AM Paul Heidekrüger
> > > <paul.heidekrueger@tum.de> wrote:
> > > >
> > > > Using CONFIG_FTRACE=y instead of CONFIG_TRACEPOINTS=y produces the same error
> > > > for me.
> > > >
> > > > So
> > > >
> > > >         CONFIG_KUNIT=y
> > > >         CONFIG_KUNIT_ALL_TESTS=n
> > > >         CONFIG_FTRACE=y
> > > >         CONFIG_KASAN=y
> > > >         CONFIG_KASAN_GENERIC=y
> > > >         CONFIG_KASAN_KUNIT_TEST=y
> > > >
> > > > produces
> > > >
> > > >         ➜   ./tools/testing/kunit/kunit.py run --kunitconfig=mm/kasan/.kunitconfig --arch=arm64
> > > >         Configuring KUnit Kernel ...
> > > >         Regenerating .config ...
> > > >         Populating config with:
> > > >         $ make ARCH=arm64 O=.kunit olddefconfig CC=clang
> > > >         ERROR:root:Not all Kconfig options selected in kunitconfig were in the generated .config.
> > > >         This is probably due to unsatisfied dependencies.
> > > >         Missing: CONFIG_KASAN_KUNIT_TEST=y
> > > >
> > > > By that error message, CONFIG_FTRACE appears to be present in the generated
> > > > config, but CONFIG_KASAN_KUNIT_TEST still isn't. Presumably,
> > > > CONFIG_KASAN_KUNIT_TEST is missing because of an unsatisfied dependency, which
> > > > must be CONFIG_TRACEPOINTS, unless I'm missing something ...
> > > >
> > > > If I just generate an arm64 defconfig and select CONFIG_FTRACE=y,
> > > > CONFIG_TRACEPOINTS=y shows up in my .config. So, maybe this is kunit.py-related
> > > > then?
> > > >
> > > > Andrey, you said that the tests have been working for you; are you running them
> > > > with kunit.py?
> > >
> > > No, I just run the kernel built with a config file that I put together
> > > based on defconfig.
> >
> > Ah. I believe I've figured it out.
> >
> > When I add CONFIG_STACK_TRACER=y in addition to CONFIG_FTRACE=y, it works.
> 
> CONFIG_FTRACE should be enough - maybe also check x86 vs. arm64 to debug more.

See below.

> > CONFIG_STACK_TRACER selects CONFIG_FUNCTION_TRACER, CONFIG_FUNCTION_TRACER
> > selects CONFIG_GENERIC_TRACER, CONFIG_GENERIC_TRACER selects CONFIG_TRACING, and
> > CONFIG_TRACING selects CONFIG_TRACEPOINTS.
> >
> > CONFIG_BLK_DEV_IO_TRACE=y also works instead of CONFIG_STACK_TRACER=y, as it
> > directly selects CONFIG_TRACEPOINTS.
> >
> > CONFIG_FTRACE=y on its own does not appear suffice for kunit.py on arm64.
> 
> When you build manually with just CONFIG_FTRACE, is CONFIG_TRACEPOINTS enabled?

When I add CONFIG_FTRACE and enter-key my way through the FTRACE prompts - I 
believe because CONFIG_FTRACE is a menuconfig? - at the beginning of a build, 
CONFIG_TRACEPOINTS does get set on arm64, yes.

On X86, the defconfig already includes CONIFG_TRACEPOINTS.

I also had a closer look at how kunit.py builds its configs.
I believe it does something along the following lines:

	cp <path_to_kunitconfig> .kunit/.config
	make ARCH=arm64 O=.kunit olddefconfig

On arm64, that isn't enough to set CONFIG_TRACEPOINTS; same behaviour when run 
outside of kunit.py.

For CONFIG_TRACEPOINTS, `make ARCH=arm64 menuconfig` shows:

	Symbol: TRACEPOINTS [=n]
	Type  : bool
	Defined at init/Kconfig:1920
	Selected by [n]:
		- TRACING [=n]
		- BLK_DEV_IO_TRACE [=n] && FTRACE [=y] && SYSFS [=y] && BLOCK [=y]

So, CONFIG_TRACING or CONFIG_BLK_DEV_IO_TRACE are the two options that prevent 
CONFIG_TRACEPOINTS from being set on arm64.

For CONFIG_TRACING we have:

	Symbol: TRACING [=n]
	Type  : bool
	Defined at kernel/trace/Kconfig:157
	Selects: RING_BUFFER [=n] && STACKTRACE [=y] && TRACEPOINTS [=n] && NOP_TRACER [=n] && BINARY_PRINTF [=n] && EVENT_TRACING [=n] && TRACE_CLOCK [=y] && TASKS_RCU [=n]
	Selected by [n]:
		- DRM_I915_TRACE_GEM [=n] && HAS_IOMEM [=y] && DRM_I915 [=n] && EXPERT [=n] && DRM_I915_DEBUG_GEM [=n]
		- DRM_I915_TRACE_GTT [=n] && HAS_IOMEM [=y] && DRM_I915 [=n] && EXPERT [=n] && DRM_I915_DEBUG_GEM [=n]
		- PREEMPTIRQ_TRACEPOINTS [=n] && (TRACE_PREEMPT_TOGGLE [=n] || TRACE_IRQFLAGS [=n])
		- GENERIC_TRACER [=n]
		- ENABLE_DEFAULT_TRACERS [=n] && FTRACE [=y] && !GENERIC_TRACER [=n]
		- FPROBE_EVENTS [=n] && FTRACE [=y] && FPROBE [=n] && HAVE_REGS_AND_STACK_ACCESS_API [=y]
		- KPROBE_EVENTS [=n] && FTRACE [=y] && KPROBES [=n] && HAVE_REGS_AND_STACK_ACCESS_API [=y]
		- UPROBE_EVENTS [=n] && FTRACE [=y] && ARCH_SUPPORTS_UPROBES [=y] && MMU [=y] && PERF_EVENTS [=n]
		- SYNTH_EVENTS [=n] && FTRACE [=y]
		- USER_EVENTS [=n] && FTRACE [=y]
		- HIST_TRIGGERS [=n] && FTRACE [=y] && ARCH_HAVE_NMI_SAFE_CMPXCHG [=y]

> > I believe the reason my .kunitconfig as well as the existing
> > mm/kfence/.kunitconfig work on X86 is because CONFIG_TRACEPOINTS=y is present in
> > an X86 defconfig.
> >
> > Does this make sense?
> >
> > Would you welcome a patch addressing this for the existing
> > mm/kfence/.kunitconfig?
> >
> > I would also like to submit a patch for an mm/kasan/.kunitconfig. Do you think
> > that would be helpful too?
> >
> > FWICT, kernel/kcsan/.kunitconfig might also be affected since
> > CONFIG_KCSAN_KUNIT_TEST also depends on CONFIG_TRACEPOITNS, but I would have to
> > test that. That could be a third patch.
> 
> I'd support figuring out the minimal config (CONFIG_FTRACE or
> something else?) that satisfies the TRACEPOINTS dependency. I always
> thought CONFIG_FTRACE ought to be the one config option, but maybe
> something changed.

If we want a minimal config, setting CONFIG_BLK_DEV_IO_TRACE, 
CONFIG_SYNTH_EVENTS or CONFIG_USER_EVENTS seem like viable options, for 
instance. But AFAICT, setting them in the context of KASan doesn't really make 
sense, and I might be missing an obvious choice here too.

What do you think?

> Also maybe one of the tracing maintainers can help untangle what's
> going on here.
> 
> Thanks,
> -- Marco

Many thanks,
Paul


