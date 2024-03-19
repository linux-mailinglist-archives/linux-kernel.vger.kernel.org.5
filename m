Return-Path: <linux-kernel+bounces-108133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 189C9880678
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 22:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15E821C22183
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 21:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6133FB99;
	Tue, 19 Mar 2024 21:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+kqAXC+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41923FB80;
	Tue, 19 Mar 2024 21:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710882213; cv=none; b=On1Q/+vDrOAhpGYNjJfOJae38tuiYJd8IJj3i7hQdnzZfE996Re46PuKmDv3VVg4DpNLDs8mt8A7/wlNJRrHeXMb7weXuMYD1dVXz5XCQ66v1QhMT3Ieuqsslk8w9TFbenCFr3KUrz9EgXjW6wxvsUnTg3HYoWJwwKgxg+AiOow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710882213; c=relaxed/simple;
	bh=wSIgZloAAH0SIwWOEXQAQKKWbgkHaxAXTRYwDmxG5qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XThxzGDyIV/uFs9eTuafuOaFDOQH+mDE1Oh4en++PZT3jB4afOMlwbiOBkbpZTZE52DjSGe4l2JUiZNYqwIw7IENxxuMFmLz1nLw4sR5M7pU5iucUNHEUSzfrFuyxe6RCn+vupXIKG8xB79V7CmvZTpPFM2RyTfBI8XyvpL+YPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+kqAXC+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8771FC433C7;
	Tue, 19 Mar 2024 21:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710882212;
	bh=wSIgZloAAH0SIwWOEXQAQKKWbgkHaxAXTRYwDmxG5qo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P+kqAXC+C4p3MFyyDkbVzcbfWGOLcN+XA9p2t8hR8UNKIkKB1iJWaiaLEOi5hQpnl
	 pBxCOswUJvgZUuqof06WAWQzpcIHvHemvJqnsGBYIYDIgjBXFbORh08mGkZdjMebT3
	 hwKEz8EiXakeB8Uafv2bOVxfLtYdepEJ+1Lkr+cYrbj61+IaM1200SfzOhkKfR4lup
	 avFpfzIoGv0q28iu8/ctw9dt0TL0owAXW6eFdpMv9CjLZlOSMyDFKHlN+uSyNka7gb
	 OT6f4uklmv5AWd1JpdrqQh+HM/KUFPZWksK7Tu71sedLTBn3wRyuWu+hRMYEOAEu0u
	 iBiNTf3C3TyHg==
Date: Tue, 19 Mar 2024 14:03:29 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Huang Yiwei <quic_hyiwei@quicinc.com>,
	John Garry <john.g.garry@oracle.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Thorsten Blum <thorsten.blum@toblux.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	linke li <lilinke99@qq.com>, llvm@lists.linux.dev
Subject: Re: [GIT PULL v2] tracing: Updates for v6.9
Message-ID: <20240319210329.GA742040@dev-arch.thelio-3990X>
References: <20240318113053.7f87ce7f@gandalf.local.home>
 <CAHk-=wjxX16kWd=uxG5wzqt=aXoYDf1BgWOKk+qVmAO0zh7sjA@mail.gmail.com>
 <20240319130653.0cfdaf6e@gandalf.local.home>
 <20240319131333.504c93fc@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="XiLEdSMjCWnSCb6R"
Content-Disposition: inline
In-Reply-To: <20240319131333.504c93fc@gandalf.local.home>


--XiLEdSMjCWnSCb6R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 19, 2024 at 01:13:33PM -0400, Steven Rostedt wrote:
> On Tue, 19 Mar 2024 13:06:53 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > This is in the fast path (where the trace event happens), but I can make it
> > always do strcmp(), even though it will slow down what is being recorded,
> > as I plan on removing the parameter in the next merge window anyway.
> 
> I'll change it to this:
> 
> #define __assign_str(dst, src)						\
> 	do {								\
> 		char *__str__ = __get_str(dst);				\
> 		int __len__ = __get_dynamic_array_len(dst) - 1;		\
> 		WARN_ON_ONCE(!src != !__data_offsets.dst##_ptr_);	\
> 		WARN_ON_ONCE(src && strcmp((src), __data_offsets.dst##_ptr_)); \
> 		memcpy(__str__, __data_offsets.dst##_ptr_ ? :		\
> 		       EVENT_NULL_STR, __len__);			\
> 		__str__[__len__] = '\0';				\
> 	} while (0)
> 
> The first WARN_ON() will report the bug if src is not NULL and the pointer
> is even though the strcmp() will likely crash in that case. But that's a
> bug if that happens anyway.

For what it's worth, I applied that change and built ARCH=x86_64
defconfig with LLVM 18.1.1 from [1] but it does not appear to help the
instances of -Wstring-compare; in fact, it adds some additional warnings
that I have not seen before. I have attached the full build log.

[1]: https://mirrors.edge.kernel.org/pub/tools/llvm/

Cheers,
Nathan

--XiLEdSMjCWnSCb6R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="build.log"

In file included from net/sunrpc/sched.c:31:
In file included from include/trace/events/sunrpc.h:2520:
In file included from include/trace/define_trace.h:102:
In file included from include/trace/trace_events.h:419:
include/trace/events/sunrpc.h:1338:3: error: result of comparison against a string literal is unspecified (use an explicit string comparison function instead) [-Werror,-Wstring-compare]
 1338 |                 __assign_str(addr, xprt ?
      |                 ^
 1339 |                         xprt->address_strings[RPC_DISPLAY_ADDR] : EVENT_NULL_STR);
      |                                                                   ~~~~~~~~~~~~~~
include/trace/stages/stage6_event_callback.h:38:21: note: expanded from macro '__assign_str'
   38 |                 WARN_ON_ONCE(!src != !__data_offsets.dst##_ptr_);       \
      |                               ~~~ ^
include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
include/trace/stages/stage6_event_callback.h:135:33: note: expanded from macro 'TP_fast_assign'
  135 | #define TP_fast_assign(args...) args
      |                                 ^~~~
include/trace/trace_events.h:44:16: note: expanded from macro 'TRACE_EVENT'
   44 |                              PARAMS(assign),                   \
      |                                     ^~~~~~
include/linux/tracepoint.h:107:25: note: expanded from macro 'PARAMS'
  107 | #define PARAMS(args...) args
      |                         ^~~~
include/trace/trace_events.h:402:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
  402 |         { assign; }                                                     \
      |           ^~~~~~
In file included from net/sunrpc/sched.c:31:
In file included from include/trace/events/sunrpc.h:2520:
In file included from include/trace/define_trace.h:102:
In file included from include/trace/trace_events.h:419:
include/trace/events/sunrpc.h:1338:3: error: comparison between pointer and integer ('char *' and 'int') [-Werror,-Wpointer-integer-compare]
 1321 |                 __string(port, xprt ? xprt->address_strings[RPC_DISPLAY_PORT] :
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1322 |                                 EVENT_NULL_STR)
      |                                 ~~~~~~~~~~~~~~~
 1323 |         ),
      |         ~~
 1324 | 
 1325 |         TP_fast_assign(
      |         ~~~~~~~~~~~~~~~
 1326 |                 __entry->err = err;
      |                 ~~~~~~~~~~~~~~~~~~~
 1327 |                 __entry->total = total;
      |                 ~~~~~~~~~~~~~~~~~~~~~~~
 1328 |                 __assign_str(addr, xprt ?
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~
 1329 |                         xprt->address_strings[RPC_DISPLAY_ADDR] : EVENT_NULL_STR);
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1330 |                 __assign_str(port, xprt ?
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~
 1331 |                         xprt->address_strings[RPC_DISPLAY_PORT] : EVENT_NULL_STR);
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1332 |         ),
      |         ~~
 1333 | 
 1334 |         TP_printk("peer=[%s]:%s err=%zd total=%zu", __get_str(addr),
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1335 |                         __get_str(port), __entry->err, __entry->total)
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1336 | );
      | ~
include/trace/stages/stage6_event_callback.h:38:21: note: expanded from macro '__assign_str'
   38 |                 WARN_ON_ONCE(!src != !__data_offsets.dst##_ptr_);       \
      |                               ~~~ ^
include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
include/trace/stages/stage6_event_callback.h:135:33: note: expanded from macro 'TP_fast_assign'
  135 | #define TP_fast_assign(args...) args
      |                                 ^~~~
include/trace/trace_events.h:44:16: note: expanded from macro 'TRACE_EVENT'
   40 |         DECLARE_EVENT_CLASS(name,                              \
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   41 |                              PARAMS(proto),                    \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   42 |                              PARAMS(args),                     \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   43 |                              PARAMS(tstruct),                  \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   44 |                              PARAMS(assign),                   \
      |                              ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   45 |                              PARAMS(print));                   \
      |                              ~~~~~~~~~~~~~~
include/linux/tracepoint.h:107:25: note: expanded from macro 'PARAMS'
  107 | #define PARAMS(args...) args
      |                         ^~~~
include/trace/trace_events.h:402:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
  402 |         { assign; }                                                     \
      |           ^~~~~~
In file included from net/sunrpc/sched.c:31:
In file included from include/trace/events/sunrpc.h:2520:
In file included from include/trace/define_trace.h:102:
In file included from include/trace/trace_events.h:419:
include/trace/events/sunrpc.h:1338:27: error: pointer/integer type mismatch in conditional expression ('const char *' and 'int') [-Werror,-Wconditional-type-mismatch]
 1321 |                 __string(port, xprt ? xprt->address_strings[RPC_DISPLAY_PORT] :
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1322 |                                 EVENT_NULL_STR)
      |                                 ~~~~~~~~~~~~~~~
 1323 |         ),
      |         ~~
 1324 | 
 1325 |         TP_fast_assign(
      |         ~~~~~~~~~~~~~~~
 1326 |                 __entry->err = err;
      |                 ~~~~~~~~~~~~~~~~~~~
 1327 |                 __entry->total = total;
      |                 ~~~~~~~~~~~~~~~~~~~~~~~
 1328 |                 __assign_str(addr, xprt ?
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~^
 1329 |                         xprt->address_strings[RPC_DISPLAY_ADDR] : EVENT_NULL_STR);
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1330 |                 __assign_str(port, xprt ?
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~
 1331 |                         xprt->address_strings[RPC_DISPLAY_PORT] : EVENT_NULL_STR);
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1332 |         ),
      |         ~~
 1333 | 
 1334 |         TP_printk("peer=[%s]:%s err=%zd total=%zu", __get_str(addr),
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1335 |                         __get_str(port), __entry->err, __entry->total)
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1336 | );
      | ~
include/trace/stages/stage6_event_callback.h:38:17: note: expanded from macro '__assign_str'
   38 |                 WARN_ON_ONCE(!src != !__data_offsets.dst##_ptr_);       \
      |                               ^~~
include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
include/trace/stages/stage6_event_callback.h:135:33: note: expanded from macro 'TP_fast_assign'
  135 | #define TP_fast_assign(args...) args
      |                                 ^~~~
include/trace/trace_events.h:44:16: note: expanded from macro 'TRACE_EVENT'
   40 |         DECLARE_EVENT_CLASS(name,                              \
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   41 |                              PARAMS(proto),                    \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   42 |                              PARAMS(args),                     \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   43 |                              PARAMS(tstruct),                  \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   44 |                              PARAMS(assign),                   \
      |                              ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   45 |                              PARAMS(print));                   \
      |                              ~~~~~~~~~~~~~~
include/linux/tracepoint.h:107:25: note: expanded from macro 'PARAMS'
  107 | #define PARAMS(args...) args
      |                         ^~~~
include/trace/trace_events.h:402:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
  402 |         { assign; }                                                     \
      |           ^~~~~~
In file included from net/sunrpc/sched.c:31:
In file included from include/trace/events/sunrpc.h:2520:
In file included from include/trace/define_trace.h:102:
In file included from include/trace/trace_events.h:419:
include/trace/events/sunrpc.h:1338:27: error: pointer/integer type mismatch in conditional expression ('const char *' and 'int') [-Werror,-Wconditional-type-mismatch]
 1321 |                 __string(port, xprt ? xprt->address_strings[RPC_DISPLAY_PORT] :
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1322 |                                 EVENT_NULL_STR)
      |                                 ~~~~~~~~~~~~~~~
 1323 |         ),
      |         ~~
 1324 | 
 1325 |         TP_fast_assign(
      |         ~~~~~~~~~~~~~~~
 1326 |                 __entry->err = err;
      |                 ~~~~~~~~~~~~~~~~~~~
 1327 |                 __entry->total = total;
      |                 ~~~~~~~~~~~~~~~~~~~~~~~
 1328 |                 __assign_str(addr, xprt ?
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~^
 1329 |                         xprt->address_strings[RPC_DISPLAY_ADDR] : EVENT_NULL_STR);
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1330 |                 __assign_str(port, xprt ?
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~
 1331 |                         xprt->address_strings[RPC_DISPLAY_PORT] : EVENT_NULL_STR);
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1332 |         ),
      |         ~~
 1333 | 
 1334 |         TP_printk("peer=[%s]:%s err=%zd total=%zu", __get_str(addr),
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1335 |                         __get_str(port), __entry->err, __entry->total)
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1336 | );
      | ~
include/trace/stages/stage6_event_callback.h:39:16: note: expanded from macro '__assign_str'
   39 |                 WARN_ON_ONCE(src && strcmp((src), __data_offsets.dst##_ptr_)); \
      |                              ^~~
include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
include/trace/stages/stage6_event_callback.h:135:33: note: expanded from macro 'TP_fast_assign'
  135 | #define TP_fast_assign(args...) args
      |                                 ^~~~
include/trace/trace_events.h:44:16: note: expanded from macro 'TRACE_EVENT'
   40 |         DECLARE_EVENT_CLASS(name,                              \
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   41 |                              PARAMS(proto),                    \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   42 |                              PARAMS(args),                     \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   43 |                              PARAMS(tstruct),                  \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   44 |                              PARAMS(assign),                   \
      |                              ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   45 |                              PARAMS(print));                   \
      |                              ~~~~~~~~~~~~~~
include/linux/tracepoint.h:107:25: note: expanded from macro 'PARAMS'
  107 | #define PARAMS(args...) args
      |                         ^~~~
include/trace/trace_events.h:402:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
  402 |         { assign; }                                                     \
      |           ^~~~~~
In file included from net/sunrpc/sched.c:31:
In file included from include/trace/events/sunrpc.h:2520:
In file included from include/trace/define_trace.h:102:
In file included from include/trace/trace_events.h:419:
include/trace/events/sunrpc.h:1340:3: error: result of comparison against a string literal is unspecified (use an explicit string comparison function instead) [-Werror,-Wstring-compare]
 1340 |                 __assign_str(port, xprt ?
      |                 ^
 1341 |                         xprt->address_strings[RPC_DISPLAY_PORT] : EVENT_NULL_STR);
      |                                                                   ~~~~~~~~~~~~~~
include/trace/stages/stage6_event_callback.h:38:21: note: expanded from macro '__assign_str'
   38 |                 WARN_ON_ONCE(!src != !__data_offsets.dst##_ptr_);       \
      |                               ~~~ ^
include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
include/trace/stages/stage6_event_callback.h:135:33: note: expanded from macro 'TP_fast_assign'
  135 | #define TP_fast_assign(args...) args
      |                                 ^~~~
include/trace/trace_events.h:44:16: note: expanded from macro 'TRACE_EVENT'
   44 |                              PARAMS(assign),                   \
      |                                     ^~~~~~
include/linux/tracepoint.h:107:25: note: expanded from macro 'PARAMS'
  107 | #define PARAMS(args...) args
      |                         ^~~~
include/trace/trace_events.h:402:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
  402 |         { assign; }                                                     \
      |           ^~~~~~
In file included from net/sunrpc/sched.c:31:
In file included from include/trace/events/sunrpc.h:2520:
In file included from include/trace/define_trace.h:102:
In file included from include/trace/trace_events.h:419:
include/trace/events/sunrpc.h:1340:3: error: comparison between pointer and integer ('char *' and 'int') [-Werror,-Wpointer-integer-compare]
 1321 |                 __string(port, xprt ? xprt->address_strings[RPC_DISPLAY_PORT] :
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1322 |                                 EVENT_NULL_STR)
      |                                 ~~~~~~~~~~~~~~~
 1323 |         ),
      |         ~~
 1324 | 
 1325 |         TP_fast_assign(
      |         ~~~~~~~~~~~~~~~
 1326 |                 __entry->err = err;
      |                 ~~~~~~~~~~~~~~~~~~~
 1327 |                 __entry->total = total;
      |                 ~~~~~~~~~~~~~~~~~~~~~~~
 1328 |                 __assign_str(addr, xprt ?
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~
 1329 |                         xprt->address_strings[RPC_DISPLAY_ADDR] : EVENT_NULL_STR);
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1330 |                 __assign_str(port, xprt ?
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~
 1331 |                         xprt->address_strings[RPC_DISPLAY_PORT] : EVENT_NULL_STR);
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1332 |         ),
      |         ~~
 1333 | 
 1334 |         TP_printk("peer=[%s]:%s err=%zd total=%zu", __get_str(addr),
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1335 |                         __get_str(port), __entry->err, __entry->total)
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1336 | );
      | ~
include/trace/stages/stage6_event_callback.h:38:21: note: expanded from macro '__assign_str'
   38 |                 WARN_ON_ONCE(!src != !__data_offsets.dst##_ptr_);       \
      |                               ~~~ ^
include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
include/trace/stages/stage6_event_callback.h:135:33: note: expanded from macro 'TP_fast_assign'
  135 | #define TP_fast_assign(args...) args
      |                                 ^~~~
include/trace/trace_events.h:44:16: note: expanded from macro 'TRACE_EVENT'
   40 |         DECLARE_EVENT_CLASS(name,                              \
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   41 |                              PARAMS(proto),                    \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   42 |                              PARAMS(args),                     \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   43 |                              PARAMS(tstruct),                  \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   44 |                              PARAMS(assign),                   \
      |                              ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   45 |                              PARAMS(print));                   \
      |                              ~~~~~~~~~~~~~~
include/linux/tracepoint.h:107:25: note: expanded from macro 'PARAMS'
  107 | #define PARAMS(args...) args
      |                         ^~~~
include/trace/trace_events.h:402:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
  402 |         { assign; }                                                     \
      |           ^~~~~~
In file included from net/sunrpc/sched.c:31:
In file included from include/trace/events/sunrpc.h:2520:
In file included from include/trace/define_trace.h:102:
In file included from include/trace/trace_events.h:419:
include/trace/events/sunrpc.h:1340:27: error: pointer/integer type mismatch in conditional expression ('const char *' and 'int') [-Werror,-Wconditional-type-mismatch]
 1321 |                 __string(port, xprt ? xprt->address_strings[RPC_DISPLAY_PORT] :
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1322 |                                 EVENT_NULL_STR)
      |                                 ~~~~~~~~~~~~~~~
 1323 |         ),
      |         ~~
 1324 | 
 1325 |         TP_fast_assign(
      |         ~~~~~~~~~~~~~~~
 1326 |                 __entry->err = err;
      |                 ~~~~~~~~~~~~~~~~~~~
 1327 |                 __entry->total = total;
      |                 ~~~~~~~~~~~~~~~~~~~~~~~
 1328 |                 __assign_str(addr, xprt ?
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~
 1329 |                         xprt->address_strings[RPC_DISPLAY_ADDR] : EVENT_NULL_STR);
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1330 |                 __assign_str(port, xprt ?
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~^
 1331 |                         xprt->address_strings[RPC_DISPLAY_PORT] : EVENT_NULL_STR);
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1332 |         ),
      |         ~~
 1333 | 
 1334 |         TP_printk("peer=[%s]:%s err=%zd total=%zu", __get_str(addr),
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1335 |                         __get_str(port), __entry->err, __entry->total)
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1336 | );
      | ~
include/trace/stages/stage6_event_callback.h:38:17: note: expanded from macro '__assign_str'
   38 |                 WARN_ON_ONCE(!src != !__data_offsets.dst##_ptr_);       \
      |                               ^~~
include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
include/trace/stages/stage6_event_callback.h:135:33: note: expanded from macro 'TP_fast_assign'
  135 | #define TP_fast_assign(args...) args
      |                                 ^~~~
include/trace/trace_events.h:44:16: note: expanded from macro 'TRACE_EVENT'
   40 |         DECLARE_EVENT_CLASS(name,                              \
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   41 |                              PARAMS(proto),                    \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   42 |                              PARAMS(args),                     \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   43 |                              PARAMS(tstruct),                  \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   44 |                              PARAMS(assign),                   \
      |                              ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   45 |                              PARAMS(print));                   \
      |                              ~~~~~~~~~~~~~~
include/linux/tracepoint.h:107:25: note: expanded from macro 'PARAMS'
  107 | #define PARAMS(args...) args
      |                         ^~~~
include/trace/trace_events.h:402:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
  402 |         { assign; }                                                     \
      |           ^~~~~~
In file included from net/sunrpc/sched.c:31:
In file included from include/trace/events/sunrpc.h:2520:
In file included from include/trace/define_trace.h:102:
In file included from include/trace/trace_events.h:419:
include/trace/events/sunrpc.h:1340:27: error: pointer/integer type mismatch in conditional expression ('const char *' and 'int') [-Werror,-Wconditional-type-mismatch]
 1321 |                 __string(port, xprt ? xprt->address_strings[RPC_DISPLAY_PORT] :
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1322 |                                 EVENT_NULL_STR)
      |                                 ~~~~~~~~~~~~~~~
 1323 |         ),
      |         ~~
 1324 | 
 1325 |         TP_fast_assign(
      |         ~~~~~~~~~~~~~~~
 1326 |                 __entry->err = err;
      |                 ~~~~~~~~~~~~~~~~~~~
 1327 |                 __entry->total = total;
      |                 ~~~~~~~~~~~~~~~~~~~~~~~
 1328 |                 __assign_str(addr, xprt ?
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~
 1329 |                         xprt->address_strings[RPC_DISPLAY_ADDR] : EVENT_NULL_STR);
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1330 |                 __assign_str(port, xprt ?
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~^
 1331 |                         xprt->address_strings[RPC_DISPLAY_PORT] : EVENT_NULL_STR);
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1332 |         ),
      |         ~~
 1333 | 
 1334 |         TP_printk("peer=[%s]:%s err=%zd total=%zu", __get_str(addr),
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1335 |                         __get_str(port), __entry->err, __entry->total)
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1336 | );
      | ~
include/trace/stages/stage6_event_callback.h:39:16: note: expanded from macro '__assign_str'
   39 |                 WARN_ON_ONCE(src && strcmp((src), __data_offsets.dst##_ptr_)); \
      |                              ^~~
include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
include/trace/stages/stage6_event_callback.h:135:33: note: expanded from macro 'TP_fast_assign'
  135 | #define TP_fast_assign(args...) args
      |                                 ^~~~
include/trace/trace_events.h:44:16: note: expanded from macro 'TRACE_EVENT'
   40 |         DECLARE_EVENT_CLASS(name,                              \
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   41 |                              PARAMS(proto),                    \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   42 |                              PARAMS(args),                     \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   43 |                              PARAMS(tstruct),                  \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   44 |                              PARAMS(assign),                   \
      |                              ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   45 |                              PARAMS(print));                   \
      |                              ~~~~~~~~~~~~~~
include/linux/tracepoint.h:107:25: note: expanded from macro 'PARAMS'
  107 | #define PARAMS(args...) args
      |                         ^~~~
include/trace/trace_events.h:402:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
  402 |         { assign; }                                                     \
      |           ^~~~~~
In file included from net/sunrpc/sched.c:31:
In file included from include/trace/events/sunrpc.h:2520:
In file included from include/trace/define_trace.h:102:
In file included from include/trace/trace_events.h:419:
include/trace/events/sunrpc.h:1795:3: error: result of comparison against a string literal is unspecified (use an explicit string comparison function instead) [-Werror,-Wstring-compare]
 1795 |                 __assign_str(addr, rqst->rq_xprt ?
      |                 ^
 1796 |                              rqst->rq_xprt->xpt_remotebuf : EVENT_NULL_STR);
      |                                                             ~~~~~~~~~~~~~~
include/trace/stages/stage6_event_callback.h:38:21: note: expanded from macro '__assign_str'
   38 |                 WARN_ON_ONCE(!src != !__data_offsets.dst##_ptr_);       \
      |                               ~~~ ^
include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
include/trace/stages/stage6_event_callback.h:135:33: note: expanded from macro 'TP_fast_assign'
  135 | #define TP_fast_assign(args...) args
      |                                 ^~~~
include/trace/trace_events.h:44:16: note: expanded from macro 'TRACE_EVENT'
   44 |                              PARAMS(assign),                   \
      |                                     ^~~~~~
include/linux/tracepoint.h:107:25: note: expanded from macro 'PARAMS'
  107 | #define PARAMS(args...) args
      |                         ^~~~
include/trace/trace_events.h:402:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
  402 |         { assign; }                                                     \
      |           ^~~~~~
In file included from net/sunrpc/sched.c:31:
In file included from include/trace/events/sunrpc.h:2520:
In file included from include/trace/define_trace.h:102:
In file included from include/trace/trace_events.h:419:
include/trace/events/sunrpc.h:1795:3: error: comparison between pointer and integer ('char *' and 'int') [-Werror,-Wpointer-integer-compare]
 1774 | 
 1775 |         TP_fast_assign(
      |         ~~~~~~~~~~~~~~~
 1776 |                 __entry->xid = be32_to_cpu(rqst->rq_xid);
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1777 |                 __entry->vers = rqst->rq_vers;
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1778 |                 __entry->proc = rqst->rq_proc;
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1779 |                 __assign_str(service, name);
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1780 |                 __assign_str(procedure, svc_proc_name(rqst));
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1781 |                 __assign_str(addr, rqst->rq_xprt ?
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1782 |                              rqst->rq_xprt->xpt_remotebuf : EVENT_NULL_STR);
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1783 |         ),
      |         ~~
 1784 | 
 1785 |         TP_printk("addr=%s xid=0x%08x service=%s vers=%u proc=%s",
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1786 |                         __get_str(addr), __entry->xid,
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1787 |                         __get_str(service), __entry->vers,
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1788 |                         __get_str(procedure)
      |                         ~~~~~~~~~~~~~~~~~~~~
 1789 |         )
      |         ~
include/trace/stages/stage6_event_callback.h:38:21: note: expanded from macro '__assign_str'
   38 |                 WARN_ON_ONCE(!src != !__data_offsets.dst##_ptr_);       \
      |                               ~~~ ^
include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
include/trace/stages/stage6_event_callback.h:135:33: note: expanded from macro 'TP_fast_assign'
  135 | #define TP_fast_assign(args...) args
      |                                 ^~~~
include/trace/trace_events.h:44:16: note: expanded from macro 'TRACE_EVENT'
   40 |         DECLARE_EVENT_CLASS(name,                              \
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   41 |                              PARAMS(proto),                    \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   42 |                              PARAMS(args),                     \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   43 |                              PARAMS(tstruct),                  \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   44 |                              PARAMS(assign),                   \
      |                              ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   45 |                              PARAMS(print));                   \
      |                              ~~~~~~~~~~~~~~
include/linux/tracepoint.h:107:25: note: expanded from macro 'PARAMS'
  107 | #define PARAMS(args...) args
      |                         ^~~~
include/trace/trace_events.h:402:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
  402 |         { assign; }                                                     \
      |           ^~~~~~
In file included from net/sunrpc/sched.c:31:
In file included from include/trace/events/sunrpc.h:2520:
In file included from include/trace/define_trace.h:102:
In file included from include/trace/trace_events.h:419:
include/trace/events/sunrpc.h:1795:36: error: pointer/integer type mismatch in conditional expression ('char *' and 'int') [-Werror,-Wconditional-type-mismatch]
 1774 | 
 1775 |         TP_fast_assign(
      |         ~~~~~~~~~~~~~~~
 1776 |                 __entry->xid = be32_to_cpu(rqst->rq_xid);
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1777 |                 __entry->vers = rqst->rq_vers;
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1778 |                 __entry->proc = rqst->rq_proc;
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1779 |                 __assign_str(service, name);
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1780 |                 __assign_str(procedure, svc_proc_name(rqst));
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1781 |                 __assign_str(addr, rqst->rq_xprt ?
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^
 1782 |                              rqst->rq_xprt->xpt_remotebuf : EVENT_NULL_STR);
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1783 |         ),
      |         ~~
 1784 | 
 1785 |         TP_printk("addr=%s xid=0x%08x service=%s vers=%u proc=%s",
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1786 |                         __get_str(addr), __entry->xid,
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1787 |                         __get_str(service), __entry->vers,
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1788 |                         __get_str(procedure)
      |                         ~~~~~~~~~~~~~~~~~~~~
 1789 |         )
      |         ~
include/trace/stages/stage6_event_callback.h:38:17: note: expanded from macro '__assign_str'
   38 |                 WARN_ON_ONCE(!src != !__data_offsets.dst##_ptr_);       \
      |                               ^~~
include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
include/trace/stages/stage6_event_callback.h:135:33: note: expanded from macro 'TP_fast_assign'
  135 | #define TP_fast_assign(args...) args
      |                                 ^~~~
include/trace/trace_events.h:44:16: note: expanded from macro 'TRACE_EVENT'
   40 |         DECLARE_EVENT_CLASS(name,                              \
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   41 |                              PARAMS(proto),                    \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   42 |                              PARAMS(args),                     \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   43 |                              PARAMS(tstruct),                  \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   44 |                              PARAMS(assign),                   \
      |                              ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   45 |                              PARAMS(print));                   \
      |                              ~~~~~~~~~~~~~~
include/linux/tracepoint.h:107:25: note: expanded from macro 'PARAMS'
  107 | #define PARAMS(args...) args
      |                         ^~~~
include/trace/trace_events.h:402:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
  402 |         { assign; }                                                     \
      |           ^~~~~~
In file included from net/sunrpc/sched.c:31:
In file included from include/trace/events/sunrpc.h:2520:
In file included from include/trace/define_trace.h:102:
In file included from include/trace/trace_events.h:419:
include/trace/events/sunrpc.h:1795:36: error: pointer/integer type mismatch in conditional expression ('char *' and 'int') [-Werror,-Wconditional-type-mismatch]
 1774 | 
 1775 |         TP_fast_assign(
      |         ~~~~~~~~~~~~~~~
 1776 |                 __entry->xid = be32_to_cpu(rqst->rq_xid);
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1777 |                 __entry->vers = rqst->rq_vers;
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1778 |                 __entry->proc = rqst->rq_proc;
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1779 |                 __assign_str(service, name);
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1780 |                 __assign_str(procedure, svc_proc_name(rqst));
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1781 |                 __assign_str(addr, rqst->rq_xprt ?
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^
 1782 |                              rqst->rq_xprt->xpt_remotebuf : EVENT_NULL_STR);
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1783 |         ),
      |         ~~
 1784 | 
 1785 |         TP_printk("addr=%s xid=0x%08x service=%s vers=%u proc=%s",
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1786 |                         __get_str(addr), __entry->xid,
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1787 |                         __get_str(service), __entry->vers,
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1788 |                         __get_str(procedure)
      |                         ~~~~~~~~~~~~~~~~~~~~
 1789 |         )
      |         ~
include/trace/stages/stage6_event_callback.h:39:16: note: expanded from macro '__assign_str'
   39 |                 WARN_ON_ONCE(src && strcmp((src), __data_offsets.dst##_ptr_)); \
      |                              ^~~
include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
include/trace/stages/stage6_event_callback.h:135:33: note: expanded from macro 'TP_fast_assign'
  135 | #define TP_fast_assign(args...) args
      |                                 ^~~~
include/trace/trace_events.h:44:16: note: expanded from macro 'TRACE_EVENT'
   40 |         DECLARE_EVENT_CLASS(name,                              \
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   41 |                              PARAMS(proto),                    \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   42 |                              PARAMS(args),                     \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   43 |                              PARAMS(tstruct),                  \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   44 |                              PARAMS(assign),                   \
      |                              ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   45 |                              PARAMS(print));                   \
      |                              ~~~~~~~~~~~~~~
include/linux/tracepoint.h:107:25: note: expanded from macro 'PARAMS'
  107 | #define PARAMS(args...) args
      |                         ^~~~
include/trace/trace_events.h:402:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
  402 |         { assign; }                                                     \
      |           ^~~~~~
In file included from net/sunrpc/sched.c:31:
In file included from include/trace/events/sunrpc.h:2520:
In file included from include/trace/define_trace.h:103:
In file included from include/trace/perf.h:75:
include/trace/events/sunrpc.h:1338:3: error: result of comparison against a string literal is unspecified (use an explicit string comparison function instead) [-Werror,-Wstring-compare]
 1338 |                 __assign_str(addr, xprt ?
      |                 ^
 1339 |                         xprt->address_strings[RPC_DISPLAY_ADDR] : EVENT_NULL_STR);
      |                                                                   ~~~~~~~~~~~~~~
include/trace/stages/stage6_event_callback.h:38:21: note: expanded from macro '__assign_str'
   38 |                 WARN_ON_ONCE(!src != !__data_offsets.dst##_ptr_);       \
      |                               ~~~ ^
include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
include/trace/stages/stage6_event_callback.h:135:33: note: expanded from macro 'TP_fast_assign'
  135 | #define TP_fast_assign(args...) args
      |                                 ^~~~
include/trace/trace_events.h:44:16: note: expanded from macro 'TRACE_EVENT'
   44 |                              PARAMS(assign),                   \
      |                                     ^~~~~~
include/linux/tracepoint.h:107:25: note: expanded from macro 'PARAMS'
  107 | #define PARAMS(args...) args
      |                         ^~~~
include/trace/perf.h:51:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
   51 |         { assign; }                                                     \
      |           ^~~~~~
In file included from net/sunrpc/sched.c:31:
In file included from include/trace/events/sunrpc.h:2520:
In file included from include/trace/define_trace.h:103:
In file included from include/trace/perf.h:75:
include/trace/events/sunrpc.h:1338:3: error: comparison between pointer and integer ('char *' and 'int') [-Werror,-Wpointer-integer-compare]
 1321 |                 __string(port, xprt ? xprt->address_strings[RPC_DISPLAY_PORT] :
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1322 |                                 EVENT_NULL_STR)
      |                                 ~~~~~~~~~~~~~~~
 1323 |         ),
      |         ~~
 1324 | 
 1325 |         TP_fast_assign(
      |         ~~~~~~~~~~~~~~~
 1326 |                 __entry->err = err;
      |                 ~~~~~~~~~~~~~~~~~~~
 1327 |                 __entry->total = total;
      |                 ~~~~~~~~~~~~~~~~~~~~~~~
 1328 |                 __assign_str(addr, xprt ?
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~
 1329 |                         xprt->address_strings[RPC_DISPLAY_ADDR] : EVENT_NULL_STR);
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1330 |                 __assign_str(port, xprt ?
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~
 1331 |                         xprt->address_strings[RPC_DISPLAY_PORT] : EVENT_NULL_STR);
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1332 |         ),
      |         ~~
 1333 | 
 1334 |         TP_printk("peer=[%s]:%s err=%zd total=%zu", __get_str(addr),
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1335 |                         __get_str(port), __entry->err, __entry->total)
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1336 | );
      | ~
include/trace/stages/stage6_event_callback.h:38:21: note: expanded from macro '__assign_str'
   38 |                 WARN_ON_ONCE(!src != !__data_offsets.dst##_ptr_);       \
      |                               ~~~ ^
include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
include/trace/stages/stage6_event_callback.h:135:33: note: expanded from macro 'TP_fast_assign'
  135 | #define TP_fast_assign(args...) args
      |                                 ^~~~
include/trace/trace_events.h:44:16: note: expanded from macro 'TRACE_EVENT'
   40 |         DECLARE_EVENT_CLASS(name,                              \
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   41 |                              PARAMS(proto),                    \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   42 |                              PARAMS(args),                     \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   43 |                              PARAMS(tstruct),                  \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   44 |                              PARAMS(assign),                   \
      |                              ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   45 |                              PARAMS(print));                   \
      |                              ~~~~~~~~~~~~~~
include/linux/tracepoint.h:107:25: note: expanded from macro 'PARAMS'
  107 | #define PARAMS(args...) args
      |                         ^~~~
include/trace/perf.h:51:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
   51 |         { assign; }                                                     \
      |           ^~~~~~
In file included from net/sunrpc/sched.c:31:
In file included from include/trace/events/sunrpc.h:2520:
In file included from include/trace/define_trace.h:103:
In file included from include/trace/perf.h:75:
include/trace/events/sunrpc.h:1338:27: error: pointer/integer type mismatch in conditional expression ('const char *' and 'int') [-Werror,-Wconditional-type-mismatch]
 1321 |                 __string(port, xprt ? xprt->address_strings[RPC_DISPLAY_PORT] :
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1322 |                                 EVENT_NULL_STR)
      |                                 ~~~~~~~~~~~~~~~
 1323 |         ),
      |         ~~
 1324 | 
 1325 |         TP_fast_assign(
      |         ~~~~~~~~~~~~~~~
 1326 |                 __entry->err = err;
      |                 ~~~~~~~~~~~~~~~~~~~
 1327 |                 __entry->total = total;
      |                 ~~~~~~~~~~~~~~~~~~~~~~~
 1328 |                 __assign_str(addr, xprt ?
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~^
 1329 |                         xprt->address_strings[RPC_DISPLAY_ADDR] : EVENT_NULL_STR);
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1330 |                 __assign_str(port, xprt ?
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~
 1331 |                         xprt->address_strings[RPC_DISPLAY_PORT] : EVENT_NULL_STR);
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1332 |         ),
      |         ~~
 1333 | 
 1334 |         TP_printk("peer=[%s]:%s err=%zd total=%zu", __get_str(addr),
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1335 |                         __get_str(port), __entry->err, __entry->total)
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1336 | );
      | ~
include/trace/stages/stage6_event_callback.h:38:17: note: expanded from macro '__assign_str'
   38 |                 WARN_ON_ONCE(!src != !__data_offsets.dst##_ptr_);       \
      |                               ^~~
include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
include/trace/stages/stage6_event_callback.h:135:33: note: expanded from macro 'TP_fast_assign'
  135 | #define TP_fast_assign(args...) args
      |                                 ^~~~
include/trace/trace_events.h:44:16: note: expanded from macro 'TRACE_EVENT'
   40 |         DECLARE_EVENT_CLASS(name,                              \
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   41 |                              PARAMS(proto),                    \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   42 |                              PARAMS(args),                     \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   43 |                              PARAMS(tstruct),                  \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   44 |                              PARAMS(assign),                   \
      |                              ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   45 |                              PARAMS(print));                   \
      |                              ~~~~~~~~~~~~~~
include/linux/tracepoint.h:107:25: note: expanded from macro 'PARAMS'
  107 | #define PARAMS(args...) args
      |                         ^~~~
include/trace/perf.h:51:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
   51 |         { assign; }                                                     \
      |           ^~~~~~
In file included from net/sunrpc/sched.c:31:
In file included from include/trace/events/sunrpc.h:2520:
In file included from include/trace/define_trace.h:103:
In file included from include/trace/perf.h:75:
include/trace/events/sunrpc.h:1338:27: error: pointer/integer type mismatch in conditional expression ('const char *' and 'int') [-Werror,-Wconditional-type-mismatch]
 1321 |                 __string(port, xprt ? xprt->address_strings[RPC_DISPLAY_PORT] :
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1322 |                                 EVENT_NULL_STR)
      |                                 ~~~~~~~~~~~~~~~
 1323 |         ),
      |         ~~
 1324 | 
 1325 |         TP_fast_assign(
      |         ~~~~~~~~~~~~~~~
 1326 |                 __entry->err = err;
      |                 ~~~~~~~~~~~~~~~~~~~
 1327 |                 __entry->total = total;
      |                 ~~~~~~~~~~~~~~~~~~~~~~~
 1328 |                 __assign_str(addr, xprt ?
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~^
 1329 |                         xprt->address_strings[RPC_DISPLAY_ADDR] : EVENT_NULL_STR);
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1330 |                 __assign_str(port, xprt ?
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~
 1331 |                         xprt->address_strings[RPC_DISPLAY_PORT] : EVENT_NULL_STR);
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1332 |         ),
      |         ~~
 1333 | 
 1334 |         TP_printk("peer=[%s]:%s err=%zd total=%zu", __get_str(addr),
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1335 |                         __get_str(port), __entry->err, __entry->total)
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1336 | );
      | ~
include/trace/stages/stage6_event_callback.h:39:16: note: expanded from macro '__assign_str'
   39 |                 WARN_ON_ONCE(src && strcmp((src), __data_offsets.dst##_ptr_)); \
      |                              ^~~
include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
include/trace/stages/stage6_event_callback.h:135:33: note: expanded from macro 'TP_fast_assign'
  135 | #define TP_fast_assign(args...) args
      |                                 ^~~~
include/trace/trace_events.h:44:16: note: expanded from macro 'TRACE_EVENT'
   40 |         DECLARE_EVENT_CLASS(name,                              \
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   41 |                              PARAMS(proto),                    \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   42 |                              PARAMS(args),                     \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   43 |                              PARAMS(tstruct),                  \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   44 |                              PARAMS(assign),                   \
      |                              ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   45 |                              PARAMS(print));                   \
      |                              ~~~~~~~~~~~~~~
include/linux/tracepoint.h:107:25: note: expanded from macro 'PARAMS'
  107 | #define PARAMS(args...) args
      |                         ^~~~
include/trace/perf.h:51:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
   51 |         { assign; }                                                     \
      |           ^~~~~~
In file included from net/sunrpc/sched.c:31:
In file included from include/trace/events/sunrpc.h:2520:
In file included from include/trace/define_trace.h:103:
In file included from include/trace/perf.h:75:
include/trace/events/sunrpc.h:1340:3: error: result of comparison against a string literal is unspecified (use an explicit string comparison function instead) [-Werror,-Wstring-compare]
 1340 |                 __assign_str(port, xprt ?
      |                 ^
 1341 |                         xprt->address_strings[RPC_DISPLAY_PORT] : EVENT_NULL_STR);
      |                                                                   ~~~~~~~~~~~~~~
include/trace/stages/stage6_event_callback.h:38:21: note: expanded from macro '__assign_str'
   38 |                 WARN_ON_ONCE(!src != !__data_offsets.dst##_ptr_);       \
      |                               ~~~ ^
include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
include/trace/stages/stage6_event_callback.h:135:33: note: expanded from macro 'TP_fast_assign'
  135 | #define TP_fast_assign(args...) args
      |                                 ^~~~
include/trace/trace_events.h:44:16: note: expanded from macro 'TRACE_EVENT'
   44 |                              PARAMS(assign),                   \
      |                                     ^~~~~~
include/linux/tracepoint.h:107:25: note: expanded from macro 'PARAMS'
  107 | #define PARAMS(args...) args
      |                         ^~~~
include/trace/perf.h:51:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
   51 |         { assign; }                                                     \
      |           ^~~~~~
In file included from net/sunrpc/sched.c:31:
In file included from include/trace/events/sunrpc.h:2520:
In file included from include/trace/define_trace.h:103:
In file included from include/trace/perf.h:75:
include/trace/events/sunrpc.h:1340:3: error: comparison between pointer and integer ('char *' and 'int') [-Werror,-Wpointer-integer-compare]
 1321 |                 __string(port, xprt ? xprt->address_strings[RPC_DISPLAY_PORT] :
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1322 |                                 EVENT_NULL_STR)
      |                                 ~~~~~~~~~~~~~~~
 1323 |         ),
      |         ~~
 1324 | 
 1325 |         TP_fast_assign(
      |         ~~~~~~~~~~~~~~~
 1326 |                 __entry->err = err;
      |                 ~~~~~~~~~~~~~~~~~~~
 1327 |                 __entry->total = total;
      |                 ~~~~~~~~~~~~~~~~~~~~~~~
 1328 |                 __assign_str(addr, xprt ?
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~
 1329 |                         xprt->address_strings[RPC_DISPLAY_ADDR] : EVENT_NULL_STR);
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1330 |                 __assign_str(port, xprt ?
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~
 1331 |                         xprt->address_strings[RPC_DISPLAY_PORT] : EVENT_NULL_STR);
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1332 |         ),
      |         ~~
 1333 | 
 1334 |         TP_printk("peer=[%s]:%s err=%zd total=%zu", __get_str(addr),
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1335 |                         __get_str(port), __entry->err, __entry->total)
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1336 | );
      | ~
include/trace/stages/stage6_event_callback.h:38:21: note: expanded from macro '__assign_str'
   38 |                 WARN_ON_ONCE(!src != !__data_offsets.dst##_ptr_);       \
      |                               ~~~ ^
include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
include/trace/stages/stage6_event_callback.h:135:33: note: expanded from macro 'TP_fast_assign'
  135 | #define TP_fast_assign(args...) args
      |                                 ^~~~
include/trace/trace_events.h:44:16: note: expanded from macro 'TRACE_EVENT'
   40 |         DECLARE_EVENT_CLASS(name,                              \
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   41 |                              PARAMS(proto),                    \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   42 |                              PARAMS(args),                     \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   43 |                              PARAMS(tstruct),                  \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   44 |                              PARAMS(assign),                   \
      |                              ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   45 |                              PARAMS(print));                   \
      |                              ~~~~~~~~~~~~~~
include/linux/tracepoint.h:107:25: note: expanded from macro 'PARAMS'
  107 | #define PARAMS(args...) args
      |                         ^~~~
include/trace/perf.h:51:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
   51 |         { assign; }                                                     \
      |           ^~~~~~
In file included from net/sunrpc/sched.c:31:
In file included from include/trace/events/sunrpc.h:2520:
In file included from include/trace/define_trace.h:103:
In file included from include/trace/perf.h:75:
include/trace/events/sunrpc.h:1340:27: error: pointer/integer type mismatch in conditional expression ('const char *' and 'int') [-Werror,-Wconditional-type-mismatch]
 1321 |                 __string(port, xprt ? xprt->address_strings[RPC_DISPLAY_PORT] :
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1322 |                                 EVENT_NULL_STR)
      |                                 ~~~~~~~~~~~~~~~
 1323 |         ),
      |         ~~
 1324 | 
 1325 |         TP_fast_assign(
      |         ~~~~~~~~~~~~~~~
 1326 |                 __entry->err = err;
      |                 ~~~~~~~~~~~~~~~~~~~
 1327 |                 __entry->total = total;
      |                 ~~~~~~~~~~~~~~~~~~~~~~~
 1328 |                 __assign_str(addr, xprt ?
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~
 1329 |                         xprt->address_strings[RPC_DISPLAY_ADDR] : EVENT_NULL_STR);
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1330 |                 __assign_str(port, xprt ?
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~^
 1331 |                         xprt->address_strings[RPC_DISPLAY_PORT] : EVENT_NULL_STR);
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1332 |         ),
      |         ~~
 1333 | 
 1334 |         TP_printk("peer=[%s]:%s err=%zd total=%zu", __get_str(addr),
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1335 |                         __get_str(port), __entry->err, __entry->total)
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1336 | );
      | ~
include/trace/stages/stage6_event_callback.h:38:17: note: expanded from macro '__assign_str'
   38 |                 WARN_ON_ONCE(!src != !__data_offsets.dst##_ptr_);       \
      |                               ^~~
include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
include/trace/stages/stage6_event_callback.h:135:33: note: expanded from macro 'TP_fast_assign'
  135 | #define TP_fast_assign(args...) args
      |                                 ^~~~
include/trace/trace_events.h:44:16: note: expanded from macro 'TRACE_EVENT'
   40 |         DECLARE_EVENT_CLASS(name,                              \
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   41 |                              PARAMS(proto),                    \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   42 |                              PARAMS(args),                     \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   43 |                              PARAMS(tstruct),                  \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   44 |                              PARAMS(assign),                   \
      |                              ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   45 |                              PARAMS(print));                   \
      |                              ~~~~~~~~~~~~~~
include/linux/tracepoint.h:107:25: note: expanded from macro 'PARAMS'
  107 | #define PARAMS(args...) args
      |                         ^~~~
include/trace/perf.h:51:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
   51 |         { assign; }                                                     \
      |           ^~~~~~
fatal error: too many errors emitted, stopping now [-ferror-limit=]
20 errors generated.
make[6]: *** [scripts/Makefile.build:243: net/sunrpc/sched.o] Error 1
make[6]: Target 'net/sunrpc/' not remade because of errors.
make[5]: *** [scripts/Makefile.build:481: net/sunrpc] Error 2
In file included from net/core/net-traces.c:32:
In file included from include/trace/events/napi.h:77:
In file included from include/trace/define_trace.h:102:
In file included from include/trace/trace_events.h:419:
include/trace/events/napi.h:29:3: error: result of comparison against a string literal is unspecified (use an explicit string comparison function instead) [-Werror,-Wstring-compare]
   29 |                 __assign_str(dev_name, napi->dev ? napi->dev->name : NO_DEV);
      |                 ^                                                    ~~~~~~
include/trace/stages/stage6_event_callback.h:38:21: note: expanded from macro '__assign_str'
   38 |                 WARN_ON_ONCE(!src != !__data_offsets.dst##_ptr_);       \
      |                               ~~~ ^
include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
include/trace/stages/stage6_event_callback.h:135:33: note: expanded from macro 'TP_fast_assign'
  135 | #define TP_fast_assign(args...) args
      |                                 ^~~~
include/trace/trace_events.h:44:16: note: expanded from macro 'TRACE_EVENT'
   44 |                              PARAMS(assign),                   \
      |                                     ^~~~~~
include/linux/tracepoint.h:107:25: note: expanded from macro 'PARAMS'
  107 | #define PARAMS(args...) args
      |                         ^~~~
include/trace/trace_events.h:402:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
  402 |         { assign; }                                                     \
      |           ^~~~~~
In file included from net/core/net-traces.c:32:
In file included from include/trace/events/napi.h:77:
In file included from include/trace/define_trace.h:102:
In file included from include/trace/trace_events.h:419:
include/trace/events/napi.h:29:3: error: comparison between pointer and integer ('char *' and 'int') [-Werror,-Wpointer-integer-compare]
   14 |                 __string(       dev_name, napi->dev ? napi->dev->name : NO_DEV)
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   15 |                 __field(        int,                    work)
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   16 |                 __field(        int,                    budget)
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   17 |         ),
      |         ~~
   18 | 
   19 |         TP_fast_assign(
      |         ~~~~~~~~~~~~~~~
   20 |                 __entry->napi = napi;
      |                 ~~~~~~~~~~~~~~~~~~~~~
   21 |                 __assign_str(dev_name, napi->dev ? napi->dev->name : NO_DEV);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   22 |                 __entry->work = work;
      |                 ~~~~~~~~~~~~~~~~~~~~~
   23 |                 __entry->budget = budget;
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~
   24 |         ),
      |         ~~
   25 | 
   26 |         TP_printk("napi poll on napi struct %p for device %s work %d budget %d",
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   27 |                   __entry->napi, __get_str(dev_name),
      |                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   28 |                   __entry->work, __entry->budget)
      |                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   29 | );
      | ~
include/trace/stages/stage6_event_callback.h:38:21: note: expanded from macro '__assign_str'
   38 |                 WARN_ON_ONCE(!src != !__data_offsets.dst##_ptr_);       \
      |                               ~~~ ^
include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
include/trace/stages/stage6_event_callback.h:135:33: note: expanded from macro 'TP_fast_assign'
  135 | #define TP_fast_assign(args...) args
      |                                 ^~~~
include/trace/trace_events.h:44:16: note: expanded from macro 'TRACE_EVENT'
   40 |         DECLARE_EVENT_CLASS(name,                              \
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   41 |                              PARAMS(proto),                    \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   42 |                              PARAMS(args),                     \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   43 |                              PARAMS(tstruct),                  \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   44 |                              PARAMS(assign),                   \
      |                              ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   45 |                              PARAMS(print));                   \
      |                              ~~~~~~~~~~~~~~
include/linux/tracepoint.h:107:25: note: expanded from macro 'PARAMS'
  107 | #define PARAMS(args...) args
      |                         ^~~~
include/trace/trace_events.h:402:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
  402 |         { assign; }                                                     \
      |           ^~~~~~
In file included from net/core/net-traces.c:32:
In file included from include/trace/events/napi.h:77:
In file included from include/trace/define_trace.h:102:
In file included from include/trace/trace_events.h:419:
include/trace/events/napi.h:29:36: error: pointer/integer type mismatch in conditional expression ('char *' and 'int') [-Werror,-Wconditional-type-mismatch]
   14 |                 __string(       dev_name, napi->dev ? napi->dev->name : NO_DEV)
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   15 |                 __field(        int,                    work)
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   16 |                 __field(        int,                    budget)
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   17 |         ),
      |         ~~
   18 | 
   19 |         TP_fast_assign(
      |         ~~~~~~~~~~~~~~~
   20 |                 __entry->napi = napi;
      |                 ~~~~~~~~~~~~~~~~~~~~~
   21 |                 __assign_str(dev_name, napi->dev ? napi->dev->name : NO_DEV);
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   22 |                 __entry->work = work;
      |                 ~~~~~~~~~~~~~~~~~~~~~
   23 |                 __entry->budget = budget;
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~
   24 |         ),
      |         ~~
   25 | 
   26 |         TP_printk("napi poll on napi struct %p for device %s work %d budget %d",
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   27 |                   __entry->napi, __get_str(dev_name),
      |                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   28 |                   __entry->work, __entry->budget)
      |                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   29 | );
      | ~
include/trace/stages/stage6_event_callback.h:38:17: note: expanded from macro '__assign_str'
   38 |                 WARN_ON_ONCE(!src != !__data_offsets.dst##_ptr_);       \
      |                               ^~~
include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
include/trace/stages/stage6_event_callback.h:135:33: note: expanded from macro 'TP_fast_assign'
  135 | #define TP_fast_assign(args...) args
      |                                 ^~~~
include/trace/trace_events.h:44:16: note: expanded from macro 'TRACE_EVENT'
   40 |         DECLARE_EVENT_CLASS(name,                              \
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   41 |                              PARAMS(proto),                    \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   42 |                              PARAMS(args),                     \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   43 |                              PARAMS(tstruct),                  \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   44 |                              PARAMS(assign),                   \
      |                              ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   45 |                              PARAMS(print));                   \
      |                              ~~~~~~~~~~~~~~
include/linux/tracepoint.h:107:25: note: expanded from macro 'PARAMS'
  107 | #define PARAMS(args...) args
      |                         ^~~~
include/trace/trace_events.h:402:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
  402 |         { assign; }                                                     \
      |           ^~~~~~
In file included from net/core/net-traces.c:32:
In file included from include/trace/events/napi.h:77:
In file included from include/trace/define_trace.h:102:
In file included from include/trace/trace_events.h:419:
include/trace/events/napi.h:29:36: error: pointer/integer type mismatch in conditional expression ('char *' and 'int') [-Werror,-Wconditional-type-mismatch]
   14 |                 __string(       dev_name, napi->dev ? napi->dev->name : NO_DEV)
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   15 |                 __field(        int,                    work)
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   16 |                 __field(        int,                    budget)
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   17 |         ),
      |         ~~
   18 | 
   19 |         TP_fast_assign(
      |         ~~~~~~~~~~~~~~~
   20 |                 __entry->napi = napi;
      |                 ~~~~~~~~~~~~~~~~~~~~~
   21 |                 __assign_str(dev_name, napi->dev ? napi->dev->name : NO_DEV);
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   22 |                 __entry->work = work;
      |                 ~~~~~~~~~~~~~~~~~~~~~
   23 |                 __entry->budget = budget;
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~
   24 |         ),
      |         ~~
   25 | 
   26 |         TP_printk("napi poll on napi struct %p for device %s work %d budget %d",
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   27 |                   __entry->napi, __get_str(dev_name),
      |                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   28 |                   __entry->work, __entry->budget)
      |                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   29 | );
      | ~
include/trace/stages/stage6_event_callback.h:39:16: note: expanded from macro '__assign_str'
   39 |                 WARN_ON_ONCE(src && strcmp((src), __data_offsets.dst##_ptr_)); \
      |                              ^~~
include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
include/trace/stages/stage6_event_callback.h:135:33: note: expanded from macro 'TP_fast_assign'
  135 | #define TP_fast_assign(args...) args
      |                                 ^~~~
include/trace/trace_events.h:44:16: note: expanded from macro 'TRACE_EVENT'
   40 |         DECLARE_EVENT_CLASS(name,                              \
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   41 |                              PARAMS(proto),                    \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   42 |                              PARAMS(args),                     \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   43 |                              PARAMS(tstruct),                  \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   44 |                              PARAMS(assign),                   \
      |                              ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   45 |                              PARAMS(print));                   \
      |                              ~~~~~~~~~~~~~~
include/linux/tracepoint.h:107:25: note: expanded from macro 'PARAMS'
  107 | #define PARAMS(args...) args
      |                         ^~~~
include/trace/trace_events.h:402:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
  402 |         { assign; }                                                     \
      |           ^~~~~~
In file included from net/core/net-traces.c:32:
In file included from include/trace/events/napi.h:77:
In file included from include/trace/define_trace.h:103:
In file included from include/trace/perf.h:75:
include/trace/events/napi.h:29:3: error: result of comparison against a string literal is unspecified (use an explicit string comparison function instead) [-Werror,-Wstring-compare]
   29 |                 __assign_str(dev_name, napi->dev ? napi->dev->name : NO_DEV);
      |                 ^                                                    ~~~~~~
include/trace/stages/stage6_event_callback.h:38:21: note: expanded from macro '__assign_str'
   38 |                 WARN_ON_ONCE(!src != !__data_offsets.dst##_ptr_);       \
      |                               ~~~ ^
include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
include/trace/stages/stage6_event_callback.h:135:33: note: expanded from macro 'TP_fast_assign'
  135 | #define TP_fast_assign(args...) args
      |                                 ^~~~
include/trace/trace_events.h:44:16: note: expanded from macro 'TRACE_EVENT'
   44 |                              PARAMS(assign),                   \
      |                                     ^~~~~~
include/linux/tracepoint.h:107:25: note: expanded from macro 'PARAMS'
  107 | #define PARAMS(args...) args
      |                         ^~~~
include/trace/perf.h:51:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
   51 |         { assign; }                                                     \
      |           ^~~~~~
In file included from net/core/net-traces.c:32:
In file included from include/trace/events/napi.h:77:
In file included from include/trace/define_trace.h:103:
In file included from include/trace/perf.h:75:
include/trace/events/napi.h:29:3: error: comparison between pointer and integer ('char *' and 'int') [-Werror,-Wpointer-integer-compare]
   14 |                 __string(       dev_name, napi->dev ? napi->dev->name : NO_DEV)
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   15 |                 __field(        int,                    work)
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   16 |                 __field(        int,                    budget)
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   17 |         ),
      |         ~~
   18 | 
   19 |         TP_fast_assign(
      |         ~~~~~~~~~~~~~~~
   20 |                 __entry->napi = napi;
      |                 ~~~~~~~~~~~~~~~~~~~~~
   21 |                 __assign_str(dev_name, napi->dev ? napi->dev->name : NO_DEV);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   22 |                 __entry->work = work;
      |                 ~~~~~~~~~~~~~~~~~~~~~
   23 |                 __entry->budget = budget;
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~
   24 |         ),
      |         ~~
   25 | 
   26 |         TP_printk("napi poll on napi struct %p for device %s work %d budget %d",
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   27 |                   __entry->napi, __get_str(dev_name),
      |                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   28 |                   __entry->work, __entry->budget)
      |                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   29 | );
      | ~
include/trace/stages/stage6_event_callback.h:38:21: note: expanded from macro '__assign_str'
   38 |                 WARN_ON_ONCE(!src != !__data_offsets.dst##_ptr_);       \
      |                               ~~~ ^
include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
include/trace/stages/stage6_event_callback.h:135:33: note: expanded from macro 'TP_fast_assign'
  135 | #define TP_fast_assign(args...) args
      |                                 ^~~~
include/trace/trace_events.h:44:16: note: expanded from macro 'TRACE_EVENT'
   40 |         DECLARE_EVENT_CLASS(name,                              \
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   41 |                              PARAMS(proto),                    \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   42 |                              PARAMS(args),                     \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   43 |                              PARAMS(tstruct),                  \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   44 |                              PARAMS(assign),                   \
      |                              ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   45 |                              PARAMS(print));                   \
      |                              ~~~~~~~~~~~~~~
include/linux/tracepoint.h:107:25: note: expanded from macro 'PARAMS'
  107 | #define PARAMS(args...) args
      |                         ^~~~
include/trace/perf.h:51:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
   51 |         { assign; }                                                     \
      |           ^~~~~~
In file included from net/core/net-traces.c:32:
In file included from include/trace/events/napi.h:77:
In file included from include/trace/define_trace.h:103:
In file included from include/trace/perf.h:75:
include/trace/events/napi.h:29:36: error: pointer/integer type mismatch in conditional expression ('char *' and 'int') [-Werror,-Wconditional-type-mismatch]
   14 |                 __string(       dev_name, napi->dev ? napi->dev->name : NO_DEV)
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   15 |                 __field(        int,                    work)
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   16 |                 __field(        int,                    budget)
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   17 |         ),
      |         ~~
   18 | 
   19 |         TP_fast_assign(
      |         ~~~~~~~~~~~~~~~
   20 |                 __entry->napi = napi;
      |                 ~~~~~~~~~~~~~~~~~~~~~
   21 |                 __assign_str(dev_name, napi->dev ? napi->dev->name : NO_DEV);
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   22 |                 __entry->work = work;
      |                 ~~~~~~~~~~~~~~~~~~~~~
   23 |                 __entry->budget = budget;
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~
   24 |         ),
      |         ~~
   25 | 
   26 |         TP_printk("napi poll on napi struct %p for device %s work %d budget %d",
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   27 |                   __entry->napi, __get_str(dev_name),
      |                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   28 |                   __entry->work, __entry->budget)
      |                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   29 | );
      | ~
include/trace/stages/stage6_event_callback.h:38:17: note: expanded from macro '__assign_str'
   38 |                 WARN_ON_ONCE(!src != !__data_offsets.dst##_ptr_);       \
      |                               ^~~
include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
include/trace/stages/stage6_event_callback.h:135:33: note: expanded from macro 'TP_fast_assign'
  135 | #define TP_fast_assign(args...) args
      |                                 ^~~~
include/trace/trace_events.h:44:16: note: expanded from macro 'TRACE_EVENT'
   40 |         DECLARE_EVENT_CLASS(name,                              \
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   41 |                              PARAMS(proto),                    \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   42 |                              PARAMS(args),                     \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   43 |                              PARAMS(tstruct),                  \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   44 |                              PARAMS(assign),                   \
      |                              ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   45 |                              PARAMS(print));                   \
      |                              ~~~~~~~~~~~~~~
include/linux/tracepoint.h:107:25: note: expanded from macro 'PARAMS'
  107 | #define PARAMS(args...) args
      |                         ^~~~
include/trace/perf.h:51:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
   51 |         { assign; }                                                     \
      |           ^~~~~~
In file included from net/core/net-traces.c:32:
In file included from include/trace/events/napi.h:77:
In file included from include/trace/define_trace.h:103:
In file included from include/trace/perf.h:75:
include/trace/events/napi.h:29:36: error: pointer/integer type mismatch in conditional expression ('char *' and 'int') [-Werror,-Wconditional-type-mismatch]
   14 |                 __string(       dev_name, napi->dev ? napi->dev->name : NO_DEV)
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   15 |                 __field(        int,                    work)
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   16 |                 __field(        int,                    budget)
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   17 |         ),
      |         ~~
   18 | 
   19 |         TP_fast_assign(
      |         ~~~~~~~~~~~~~~~
   20 |                 __entry->napi = napi;
      |                 ~~~~~~~~~~~~~~~~~~~~~
   21 |                 __assign_str(dev_name, napi->dev ? napi->dev->name : NO_DEV);
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   22 |                 __entry->work = work;
      |                 ~~~~~~~~~~~~~~~~~~~~~
   23 |                 __entry->budget = budget;
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~
   24 |         ),
      |         ~~
   25 | 
   26 |         TP_printk("napi poll on napi struct %p for device %s work %d budget %d",
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   27 |                   __entry->napi, __get_str(dev_name),
      |                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   28 |                   __entry->work, __entry->budget)
      |                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   29 | );
      | ~
include/trace/stages/stage6_event_callback.h:39:16: note: expanded from macro '__assign_str'
   39 |                 WARN_ON_ONCE(src && strcmp((src), __data_offsets.dst##_ptr_)); \
      |                              ^~~
include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
include/trace/stages/stage6_event_callback.h:135:33: note: expanded from macro 'TP_fast_assign'
  135 | #define TP_fast_assign(args...) args
      |                                 ^~~~
include/trace/trace_events.h:44:16: note: expanded from macro 'TRACE_EVENT'
   40 |         DECLARE_EVENT_CLASS(name,                              \
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   41 |                              PARAMS(proto),                    \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   42 |                              PARAMS(args),                     \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   43 |                              PARAMS(tstruct),                  \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   44 |                              PARAMS(assign),                   \
      |                              ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   45 |                              PARAMS(print));                   \
      |                              ~~~~~~~~~~~~~~
include/linux/tracepoint.h:107:25: note: expanded from macro 'PARAMS'
  107 | #define PARAMS(args...) args
      |                         ^~~~
include/trace/perf.h:51:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
   51 |         { assign; }                                                     \
      |           ^~~~~~
8 errors generated.
make[6]: *** [scripts/Makefile.build:243: net/core/net-traces.o] Error 1
make[6]: Target 'net/core/' not remade because of errors.
make[5]: *** [scripts/Makefile.build:481: net/core] Error 2
In file included from net/wireless/trace.c:5:
In file included from net/wireless/trace.h:4014:
In file included from include/trace/define_trace.h:102:
In file included from include/trace/trace_events.h:419:
net/wireless/trace.h:375:3: error: result of comparison against a string literal is unspecified (use an explicit string comparison function instead) [-Werror,-Wstring-compare]
  375 |                 __assign_str(vir_intf_name, name ? name : "<noname>");
      |                 ^                                         ~~~~~~~~~~
include/trace/stages/stage6_event_callback.h:38:21: note: expanded from macro '__assign_str'
   38 |                 WARN_ON_ONCE(!src != !__data_offsets.dst##_ptr_);       \
      |                               ~~~ ^
include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
include/trace/stages/stage6_event_callback.h:135:33: note: expanded from macro 'TP_fast_assign'
  135 | #define TP_fast_assign(args...) args
      |                                 ^~~~
include/trace/trace_events.h:44:16: note: expanded from macro 'TRACE_EVENT'
   44 |                              PARAMS(assign),                   \
      |                                     ^~~~~~
include/linux/tracepoint.h:107:25: note: expanded from macro 'PARAMS'
  107 | #define PARAMS(args...) args
      |                         ^~~~
include/trace/trace_events.h:402:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
  402 |         { assign; }                                                     \
      |           ^~~~~~
In file included from net/wireless/trace.c:5:
In file included from net/wireless/trace.h:4014:
In file included from include/trace/define_trace.h:102:
In file included from include/trace/trace_events.h:419:
net/wireless/trace.h:375:3: error: comparison between pointer and integer ('char *' and 'int') [-Werror,-Wpointer-integer-compare]
  365 | TRACE_EVENT(rdev_add_virtual_intf,
      | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  366 |         TP_PROTO(struct wiphy *wiphy, char *name, enum nl80211_iftype type),
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  367 |         TP_ARGS(wiphy, name, type),
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~
  368 |         TP_STRUCT__entry(
      |         ~~~~~~~~~~~~~~~~~
  369 |                 WIPHY_ENTRY
      |                 ~~~~~~~~~~~
  370 |                 __string(vir_intf_name, name ? name : "<noname>")
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  371 |                 __field(enum nl80211_iftype, type)
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  372 |         ),
      |         ~~
  373 |         TP_fast_assign(
      |         ~~~~~~~~~~~~~~~
  374 |                 WIPHY_ASSIGN;
      |                 ~~~~~~~~~~~~~
  375 |                 __assign_str(vir_intf_name, name ? name : "<noname>");
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  376 |                 __entry->type = type;
      |                 ~~~~~~~~~~~~~~~~~~~~~
  377 |         ),
      |         ~~
  378 |         TP_printk(WIPHY_PR_FMT ", virtual intf name: %s, type: %d",
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  379 |                   WIPHY_PR_ARG, __get_str(vir_intf_name), __entry->type)
      |                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  380 | );
      | ~
include/trace/stages/stage6_event_callback.h:38:21: note: expanded from macro '__assign_str'
   38 |                 WARN_ON_ONCE(!src != !__data_offsets.dst##_ptr_);       \
      |                               ~~~ ^
include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
include/trace/stages/stage6_event_callback.h:135:33: note: expanded from macro 'TP_fast_assign'
  135 | #define TP_fast_assign(args...) args
      |                                 ^~~~
include/trace/trace_events.h:44:16: note: expanded from macro 'TRACE_EVENT'
   40 |         DECLARE_EVENT_CLASS(name,                              \
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   41 |                              PARAMS(proto),                    \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   42 |                              PARAMS(args),                     \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   43 |                              PARAMS(tstruct),                  \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   44 |                              PARAMS(assign),                   \
      |                              ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   45 |                              PARAMS(print));                   \
      |                              ~~~~~~~~~~~~~~
include/linux/tracepoint.h:107:25: note: expanded from macro 'PARAMS'
  107 | #define PARAMS(args...) args
      |                         ^~~~
include/trace/trace_events.h:402:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
  402 |         { assign; }                                                     \
      |           ^~~~~~
In file included from net/wireless/trace.c:5:
In file included from net/wireless/trace.h:4014:
In file included from include/trace/define_trace.h:102:
In file included from include/trace/trace_events.h:419:
net/wireless/trace.h:375:36: error: pointer/integer type mismatch in conditional expression ('char *' and 'int') [-Werror,-Wconditional-type-mismatch]
  365 | TRACE_EVENT(rdev_add_virtual_intf,
      | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  366 |         TP_PROTO(struct wiphy *wiphy, char *name, enum nl80211_iftype type),
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  367 |         TP_ARGS(wiphy, name, type),
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~
  368 |         TP_STRUCT__entry(
      |         ~~~~~~~~~~~~~~~~~
  369 |                 WIPHY_ENTRY
      |                 ~~~~~~~~~~~
  370 |                 __string(vir_intf_name, name ? name : "<noname>")
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  371 |                 __field(enum nl80211_iftype, type)
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  372 |         ),
      |         ~~
  373 |         TP_fast_assign(
      |         ~~~~~~~~~~~~~~~
  374 |                 WIPHY_ASSIGN;
      |                 ~~~~~~~~~~~~~
  375 |                 __assign_str(vir_intf_name, name ? name : "<noname>");
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~
  376 |                 __entry->type = type;
      |                 ~~~~~~~~~~~~~~~~~~~~~
  377 |         ),
      |         ~~
  378 |         TP_printk(WIPHY_PR_FMT ", virtual intf name: %s, type: %d",
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  379 |                   WIPHY_PR_ARG, __get_str(vir_intf_name), __entry->type)
      |                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  380 | );
      | ~
include/trace/stages/stage6_event_callback.h:38:17: note: expanded from macro '__assign_str'
   38 |                 WARN_ON_ONCE(!src != !__data_offsets.dst##_ptr_);       \
      |                               ^~~
include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
include/trace/stages/stage6_event_callback.h:135:33: note: expanded from macro 'TP_fast_assign'
  135 | #define TP_fast_assign(args...) args
      |                                 ^~~~
include/trace/trace_events.h:44:16: note: expanded from macro 'TRACE_EVENT'
   40 |         DECLARE_EVENT_CLASS(name,                              \
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   41 |                              PARAMS(proto),                    \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   42 |                              PARAMS(args),                     \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   43 |                              PARAMS(tstruct),                  \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   44 |                              PARAMS(assign),                   \
      |                              ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   45 |                              PARAMS(print));                   \
      |                              ~~~~~~~~~~~~~~
include/linux/tracepoint.h:107:25: note: expanded from macro 'PARAMS'
  107 | #define PARAMS(args...) args
      |                         ^~~~
include/trace/trace_events.h:402:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
  402 |         { assign; }                                                     \
      |           ^~~~~~
In file included from net/wireless/trace.c:5:
In file included from net/wireless/trace.h:4014:
In file included from include/trace/define_trace.h:102:
In file included from include/trace/trace_events.h:419:
net/wireless/trace.h:375:36: error: pointer/integer type mismatch in conditional expression ('char *' and 'int') [-Werror,-Wconditional-type-mismatch]
  365 | TRACE_EVENT(rdev_add_virtual_intf,
      | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  366 |         TP_PROTO(struct wiphy *wiphy, char *name, enum nl80211_iftype type),
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  367 |         TP_ARGS(wiphy, name, type),
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~
  368 |         TP_STRUCT__entry(
      |         ~~~~~~~~~~~~~~~~~
  369 |                 WIPHY_ENTRY
      |                 ~~~~~~~~~~~
  370 |                 __string(vir_intf_name, name ? name : "<noname>")
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  371 |                 __field(enum nl80211_iftype, type)
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  372 |         ),
      |         ~~
  373 |         TP_fast_assign(
      |         ~~~~~~~~~~~~~~~
  374 |                 WIPHY_ASSIGN;
      |                 ~~~~~~~~~~~~~
  375 |                 __assign_str(vir_intf_name, name ? name : "<noname>");
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~
  376 |                 __entry->type = type;
      |                 ~~~~~~~~~~~~~~~~~~~~~
  377 |         ),
      |         ~~
  378 |         TP_printk(WIPHY_PR_FMT ", virtual intf name: %s, type: %d",
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  379 |                   WIPHY_PR_ARG, __get_str(vir_intf_name), __entry->type)
      |                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  380 | );
      | ~
include/trace/stages/stage6_event_callback.h:39:16: note: expanded from macro '__assign_str'
   39 |                 WARN_ON_ONCE(src && strcmp((src), __data_offsets.dst##_ptr_)); \
      |                              ^~~
include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
include/trace/stages/stage6_event_callback.h:135:33: note: expanded from macro 'TP_fast_assign'
  135 | #define TP_fast_assign(args...) args
      |                                 ^~~~
include/trace/trace_events.h:44:16: note: expanded from macro 'TRACE_EVENT'
   40 |         DECLARE_EVENT_CLASS(name,                              \
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   41 |                              PARAMS(proto),                    \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   42 |                              PARAMS(args),                     \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   43 |                              PARAMS(tstruct),                  \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   44 |                              PARAMS(assign),                   \
      |                              ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   45 |                              PARAMS(print));                   \
      |                              ~~~~~~~~~~~~~~
include/linux/tracepoint.h:107:25: note: expanded from macro 'PARAMS'
  107 | #define PARAMS(args...) args
      |                         ^~~~
include/trace/trace_events.h:402:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
  402 |         { assign; }                                                     \
      |           ^~~~~~
In file included from net/wireless/trace.c:5:
In file included from net/wireless/trace.h:4014:
In file included from include/trace/define_trace.h:103:
In file included from include/trace/perf.h:75:
net/wireless/trace.h:375:3: error: result of comparison against a string literal is unspecified (use an explicit string comparison function instead) [-Werror,-Wstring-compare]
  375 |                 __assign_str(vir_intf_name, name ? name : "<noname>");
      |                 ^                                         ~~~~~~~~~~
include/trace/stages/stage6_event_callback.h:38:21: note: expanded from macro '__assign_str'
   38 |                 WARN_ON_ONCE(!src != !__data_offsets.dst##_ptr_);       \
      |                               ~~~ ^
include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
include/trace/stages/stage6_event_callback.h:135:33: note: expanded from macro 'TP_fast_assign'
  135 | #define TP_fast_assign(args...) args
      |                                 ^~~~
include/trace/trace_events.h:44:16: note: expanded from macro 'TRACE_EVENT'
   44 |                              PARAMS(assign),                   \
      |                                     ^~~~~~
include/linux/tracepoint.h:107:25: note: expanded from macro 'PARAMS'
  107 | #define PARAMS(args...) args
      |                         ^~~~
include/trace/perf.h:51:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
   51 |         { assign; }                                                     \
      |           ^~~~~~
In file included from net/wireless/trace.c:5:
In file included from net/wireless/trace.h:4014:
In file included from include/trace/define_trace.h:103:
In file included from include/trace/perf.h:75:
net/wireless/trace.h:375:3: error: comparison between pointer and integer ('char *' and 'int') [-Werror,-Wpointer-integer-compare]
  365 | TRACE_EVENT(rdev_add_virtual_intf,
      | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  366 |         TP_PROTO(struct wiphy *wiphy, char *name, enum nl80211_iftype type),
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  367 |         TP_ARGS(wiphy, name, type),
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~
  368 |         TP_STRUCT__entry(
      |         ~~~~~~~~~~~~~~~~~
  369 |                 WIPHY_ENTRY
      |                 ~~~~~~~~~~~
  370 |                 __string(vir_intf_name, name ? name : "<noname>")
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  371 |                 __field(enum nl80211_iftype, type)
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  372 |         ),
      |         ~~
  373 |         TP_fast_assign(
      |         ~~~~~~~~~~~~~~~
  374 |                 WIPHY_ASSIGN;
      |                 ~~~~~~~~~~~~~
  375 |                 __assign_str(vir_intf_name, name ? name : "<noname>");
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  376 |                 __entry->type = type;
      |                 ~~~~~~~~~~~~~~~~~~~~~
  377 |         ),
      |         ~~
  378 |         TP_printk(WIPHY_PR_FMT ", virtual intf name: %s, type: %d",
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  379 |                   WIPHY_PR_ARG, __get_str(vir_intf_name), __entry->type)
      |                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  380 | );
      | ~
include/trace/stages/stage6_event_callback.h:38:21: note: expanded from macro '__assign_str'
   38 |                 WARN_ON_ONCE(!src != !__data_offsets.dst##_ptr_);       \
      |                               ~~~ ^
include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
include/trace/stages/stage6_event_callback.h:135:33: note: expanded from macro 'TP_fast_assign'
  135 | #define TP_fast_assign(args...) args
      |                                 ^~~~
include/trace/trace_events.h:44:16: note: expanded from macro 'TRACE_EVENT'
   40 |         DECLARE_EVENT_CLASS(name,                              \
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   41 |                              PARAMS(proto),                    \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   42 |                              PARAMS(args),                     \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   43 |                              PARAMS(tstruct),                  \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   44 |                              PARAMS(assign),                   \
      |                              ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   45 |                              PARAMS(print));                   \
      |                              ~~~~~~~~~~~~~~
include/linux/tracepoint.h:107:25: note: expanded from macro 'PARAMS'
  107 | #define PARAMS(args...) args
      |                         ^~~~
include/trace/perf.h:51:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
   51 |         { assign; }                                                     \
      |           ^~~~~~
In file included from net/wireless/trace.c:5:
In file included from net/wireless/trace.h:4014:
In file included from include/trace/define_trace.h:103:
In file included from include/trace/perf.h:75:
net/wireless/trace.h:375:36: error: pointer/integer type mismatch in conditional expression ('char *' and 'int') [-Werror,-Wconditional-type-mismatch]
  365 | TRACE_EVENT(rdev_add_virtual_intf,
      | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  366 |         TP_PROTO(struct wiphy *wiphy, char *name, enum nl80211_iftype type),
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  367 |         TP_ARGS(wiphy, name, type),
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~
  368 |         TP_STRUCT__entry(
      |         ~~~~~~~~~~~~~~~~~
  369 |                 WIPHY_ENTRY
      |                 ~~~~~~~~~~~
  370 |                 __string(vir_intf_name, name ? name : "<noname>")
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  371 |                 __field(enum nl80211_iftype, type)
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  372 |         ),
      |         ~~
  373 |         TP_fast_assign(
      |         ~~~~~~~~~~~~~~~
  374 |                 WIPHY_ASSIGN;
      |                 ~~~~~~~~~~~~~
  375 |                 __assign_str(vir_intf_name, name ? name : "<noname>");
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~
  376 |                 __entry->type = type;
      |                 ~~~~~~~~~~~~~~~~~~~~~
  377 |         ),
      |         ~~
  378 |         TP_printk(WIPHY_PR_FMT ", virtual intf name: %s, type: %d",
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  379 |                   WIPHY_PR_ARG, __get_str(vir_intf_name), __entry->type)
      |                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  380 | );
      | ~
include/trace/stages/stage6_event_callback.h:38:17: note: expanded from macro '__assign_str'
   38 |                 WARN_ON_ONCE(!src != !__data_offsets.dst##_ptr_);       \
      |                               ^~~
include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
include/trace/stages/stage6_event_callback.h:135:33: note: expanded from macro 'TP_fast_assign'
  135 | #define TP_fast_assign(args...) args
      |                                 ^~~~
include/trace/trace_events.h:44:16: note: expanded from macro 'TRACE_EVENT'
   40 |         DECLARE_EVENT_CLASS(name,                              \
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   41 |                              PARAMS(proto),                    \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   42 |                              PARAMS(args),                     \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   43 |                              PARAMS(tstruct),                  \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   44 |                              PARAMS(assign),                   \
      |                              ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   45 |                              PARAMS(print));                   \
      |                              ~~~~~~~~~~~~~~
include/linux/tracepoint.h:107:25: note: expanded from macro 'PARAMS'
  107 | #define PARAMS(args...) args
      |                         ^~~~
include/trace/perf.h:51:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
   51 |         { assign; }                                                     \
      |           ^~~~~~
In file included from net/wireless/trace.c:5:
In file included from net/wireless/trace.h:4014:
In file included from include/trace/define_trace.h:103:
In file included from include/trace/perf.h:75:
net/wireless/trace.h:375:36: error: pointer/integer type mismatch in conditional expression ('char *' and 'int') [-Werror,-Wconditional-type-mismatch]
  365 | TRACE_EVENT(rdev_add_virtual_intf,
      | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  366 |         TP_PROTO(struct wiphy *wiphy, char *name, enum nl80211_iftype type),
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  367 |         TP_ARGS(wiphy, name, type),
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~
  368 |         TP_STRUCT__entry(
      |         ~~~~~~~~~~~~~~~~~
  369 |                 WIPHY_ENTRY
      |                 ~~~~~~~~~~~
  370 |                 __string(vir_intf_name, name ? name : "<noname>")
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  371 |                 __field(enum nl80211_iftype, type)
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  372 |         ),
      |         ~~
  373 |         TP_fast_assign(
      |         ~~~~~~~~~~~~~~~
  374 |                 WIPHY_ASSIGN;
      |                 ~~~~~~~~~~~~~
  375 |                 __assign_str(vir_intf_name, name ? name : "<noname>");
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~
  376 |                 __entry->type = type;
      |                 ~~~~~~~~~~~~~~~~~~~~~
  377 |         ),
      |         ~~
  378 |         TP_printk(WIPHY_PR_FMT ", virtual intf name: %s, type: %d",
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  379 |                   WIPHY_PR_ARG, __get_str(vir_intf_name), __entry->type)
      |                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  380 | );
      | ~
include/trace/stages/stage6_event_callback.h:39:16: note: expanded from macro '__assign_str'
   39 |                 WARN_ON_ONCE(src && strcmp((src), __data_offsets.dst##_ptr_)); \
      |                              ^~~
include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
include/trace/stages/stage6_event_callback.h:135:33: note: expanded from macro 'TP_fast_assign'
  135 | #define TP_fast_assign(args...) args
      |                                 ^~~~
include/trace/trace_events.h:44:16: note: expanded from macro 'TRACE_EVENT'
   40 |         DECLARE_EVENT_CLASS(name,                              \
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   41 |                              PARAMS(proto),                    \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   42 |                              PARAMS(args),                     \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   43 |                              PARAMS(tstruct),                  \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   44 |                              PARAMS(assign),                   \
      |                              ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   45 |                              PARAMS(print));                   \
      |                              ~~~~~~~~~~~~~~
include/linux/tracepoint.h:107:25: note: expanded from macro 'PARAMS'
  107 | #define PARAMS(args...) args
      |                         ^~~~
include/trace/perf.h:51:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
   51 |         { assign; }                                                     \
      |           ^~~~~~
8 errors generated.
make[6]: *** [scripts/Makefile.build:243: net/wireless/trace.o] Error 1
make[6]: Target 'net/wireless/' not remade because of errors.
make[5]: *** [scripts/Makefile.build:481: net/wireless] Error 2
make[5]: Target 'net/' not remade because of errors.
make[4]: *** [scripts/Makefile.build:481: net] Error 2
In file included from kernel/trace/power-traces.c:15:
In file included from include/trace/events/power.h:557:
In file included from include/trace/define_trace.h:102:
In file included from include/trace/trace_events.h:419:
include/trace/events/power.h:215:3: error: result of comparison against a string literal is unspecified (use an explicit string comparison function instead) [-Werror,-Wstring-compare]
  215 |                 __assign_str(parent,
      |                 ^
  216 |                         dev->parent ? dev_name(dev->parent) : "none");
      |                                                               ~~~~~~
include/trace/stages/stage6_event_callback.h:38:21: note: expanded from macro '__assign_str'
   38 |                 WARN_ON_ONCE(!src != !__data_offsets.dst##_ptr_);       \
      |                               ~~~ ^
include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
include/trace/stages/stage6_event_callback.h:135:33: note: expanded from macro 'TP_fast_assign'
  135 | #define TP_fast_assign(args...) args
      |                                 ^~~~
include/trace/trace_events.h:44:16: note: expanded from macro 'TRACE_EVENT'
   44 |                              PARAMS(assign),                   \
      |                                     ^~~~~~
include/linux/tracepoint.h:107:25: note: expanded from macro 'PARAMS'
  107 | #define PARAMS(args...) args
      |                         ^~~~
include/trace/trace_events.h:402:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
  402 |         { assign; }                                                     \
      |           ^~~~~~
In file included from kernel/trace/power-traces.c:15:
In file included from include/trace/events/power.h:557:
In file included from include/trace/define_trace.h:102:
In file included from include/trace/trace_events.h:419:
include/trace/events/power.h:215:3: error: comparison between pointer and integer ('char *' and 'int') [-Werror,-Wpointer-integer-compare]
  198 |                 __string(pm_ops, pm_ops ? pm_ops : "none ")
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  199 |                 __field(int, event)
      |                 ~~~~~~~~~~~~~~~~~~~
  200 |         ),
      |         ~~
  201 | 
  202 |         TP_fast_assign(
      |         ~~~~~~~~~~~~~~~
  203 |                 __assign_str(device, dev_name(dev));
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  204 |                 __assign_str(driver, dev_driver_string(dev));
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  205 |                 __assign_str(parent,
      |                 ^~~~~~~~~~~~~~~~~~~~
  206 |                         dev->parent ? dev_name(dev->parent) : "none");
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  207 |                 __assign_str(pm_ops, pm_ops ? pm_ops : "none ");
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  208 |                 __entry->event = event;
      |                 ~~~~~~~~~~~~~~~~~~~~~~~
  209 |         ),
      |         ~~
  210 | 
  211 |         TP_printk("%s %s, parent: %s, %s[%s]", __get_str(driver),
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  212 |                 __get_str(device), __get_str(parent), __get_str(pm_ops),
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  213 |                 pm_verb_symbolic(__entry->event))
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/trace/stages/stage6_event_callback.h:38:21: note: expanded from macro '__assign_str'
   38 |                 WARN_ON_ONCE(!src != !__data_offsets.dst##_ptr_);       \
      |                               ~~~ ^
include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
include/trace/stages/stage6_event_callback.h:135:33: note: expanded from macro 'TP_fast_assign'
  135 | #define TP_fast_assign(args...) args
      |                                 ^~~~
include/trace/trace_events.h:44:16: note: expanded from macro 'TRACE_EVENT'
   40 |         DECLARE_EVENT_CLASS(name,                              \
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   41 |                              PARAMS(proto),                    \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   42 |                              PARAMS(args),                     \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   43 |                              PARAMS(tstruct),                  \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   44 |                              PARAMS(assign),                   \
      |                              ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   45 |                              PARAMS(print));                   \
      |                              ~~~~~~~~~~~~~~
include/linux/tracepoint.h:107:25: note: expanded from macro 'PARAMS'
  107 | #define PARAMS(args...) args
      |                         ^~~~
include/trace/trace_events.h:402:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
  402 |         { assign; }                                                     \
      |           ^~~~~~
In file included from kernel/trace/power-traces.c:15:
In file included from include/trace/events/power.h:557:
In file included from include/trace/define_trace.h:102:
In file included from include/trace/trace_events.h:419:
include/trace/events/power.h:216:16: error: pointer/integer type mismatch in conditional expression ('const char *' and 'int') [-Werror,-Wconditional-type-mismatch]
  198 |                 __field(int, event)
      |                 ~~~~~~~~~~~~~~~~~~~
  199 |         ),
      |         ~~
  200 | 
  201 |         TP_fast_assign(
      |         ~~~~~~~~~~~~~~~
  202 |                 __assign_str(device, dev_name(dev));
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  203 |                 __assign_str(driver, dev_driver_string(dev));
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  204 |                 __assign_str(parent,
      |                 ~~~~~~~~~~~~~~~~~~~~
  205 |                         dev->parent ? dev_name(dev->parent) : "none");
      |                         ~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  206 |                 __assign_str(pm_ops, pm_ops ? pm_ops : "none ");
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  207 |                 __entry->event = event;
      |                 ~~~~~~~~~~~~~~~~~~~~~~~
  208 |         ),
      |         ~~
  209 | 
  210 |         TP_printk("%s %s, parent: %s, %s[%s]", __get_str(driver),
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  211 |                 __get_str(device), __get_str(parent), __get_str(pm_ops),
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  212 |                 pm_verb_symbolic(__entry->event))
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  213 | );
      | ~
include/trace/stages/stage6_event_callback.h:38:17: note: expanded from macro '__assign_str'
   38 |                 WARN_ON_ONCE(!src != !__data_offsets.dst##_ptr_);       \
      |                               ^~~
include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
include/trace/stages/stage6_event_callback.h:135:33: note: expanded from macro 'TP_fast_assign'
  135 | #define TP_fast_assign(args...) args
      |                                 ^~~~
include/trace/trace_events.h:44:16: note: expanded from macro 'TRACE_EVENT'
   40 |         DECLARE_EVENT_CLASS(name,                              \
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   41 |                              PARAMS(proto),                    \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   42 |                              PARAMS(args),                     \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   43 |                              PARAMS(tstruct),                  \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   44 |                              PARAMS(assign),                   \
      |                              ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   45 |                              PARAMS(print));                   \
      |                              ~~~~~~~~~~~~~~
include/linux/tracepoint.h:107:25: note: expanded from macro 'PARAMS'
  107 | #define PARAMS(args...) args
      |                         ^~~~
include/trace/trace_events.h:402:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
  402 |         { assign; }                                                     \
      |           ^~~~~~
In file included from kernel/trace/power-traces.c:15:
In file included from include/trace/events/power.h:557:
In file included from include/trace/define_trace.h:102:
In file included from include/trace/trace_events.h:419:
include/trace/events/power.h:216:16: error: pointer/integer type mismatch in conditional expression ('const char *' and 'int') [-Werror,-Wconditional-type-mismatch]
  198 |                 __field(int, event)
      |                 ~~~~~~~~~~~~~~~~~~~
  199 |         ),
      |         ~~
  200 | 
  201 |         TP_fast_assign(
      |         ~~~~~~~~~~~~~~~
  202 |                 __assign_str(device, dev_name(dev));
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  203 |                 __assign_str(driver, dev_driver_string(dev));
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  204 |                 __assign_str(parent,
      |                 ~~~~~~~~~~~~~~~~~~~~
  205 |                         dev->parent ? dev_name(dev->parent) : "none");
      |                         ~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  206 |                 __assign_str(pm_ops, pm_ops ? pm_ops : "none ");
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  207 |                 __entry->event = event;
      |                 ~~~~~~~~~~~~~~~~~~~~~~~
  208 |         ),
      |         ~~
  209 | 
  210 |         TP_printk("%s %s, parent: %s, %s[%s]", __get_str(driver),
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  211 |                 __get_str(device), __get_str(parent), __get_str(pm_ops),
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  212 |                 pm_verb_symbolic(__entry->event))
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  213 | );
      | ~
include/trace/stages/stage6_event_callback.h:39:16: note: expanded from macro '__assign_str'
   39 |                 WARN_ON_ONCE(src && strcmp((src), __data_offsets.dst##_ptr_)); \
      |                              ^~~
include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
include/trace/stages/stage6_event_callback.h:135:33: note: expanded from macro 'TP_fast_assign'
  135 | #define TP_fast_assign(args...) args
      |                                 ^~~~
include/trace/trace_events.h:44:16: note: expanded from macro 'TRACE_EVENT'
   40 |         DECLARE_EVENT_CLASS(name,                              \
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   41 |                              PARAMS(proto),                    \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   42 |                              PARAMS(args),                     \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   43 |                              PARAMS(tstruct),                  \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   44 |                              PARAMS(assign),                   \
      |                              ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   45 |                              PARAMS(print));                   \
      |                              ~~~~~~~~~~~~~~
include/linux/tracepoint.h:107:25: note: expanded from macro 'PARAMS'
  107 | #define PARAMS(args...) args
      |                         ^~~~
include/trace/trace_events.h:402:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
  402 |         { assign; }                                                     \
      |           ^~~~~~
In file included from kernel/trace/power-traces.c:15:
In file included from include/trace/events/power.h:557:
In file included from include/trace/define_trace.h:102:
In file included from include/trace/trace_events.h:419:
include/trace/events/power.h:217:3: error: result of comparison against a string literal is unspecified (use an explicit string comparison function instead) [-Werror,-Wstring-compare]
  217 |                 __assign_str(pm_ops, pm_ops ? pm_ops : "none ");
      |                 ^                                      ~~~~~~~
include/trace/stages/stage6_event_callback.h:38:21: note: expanded from macro '__assign_str'
   38 |                 WARN_ON_ONCE(!src != !__data_offsets.dst##_ptr_);       \
      |                               ~~~ ^
include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
include/trace/stages/stage6_event_callback.h:135:33: note: expanded from macro 'TP_fast_assign'
  135 | #define TP_fast_assign(args...) args
      |                                 ^~~~
include/trace/trace_events.h:44:16: note: expanded from macro 'TRACE_EVENT'
   44 |                              PARAMS(assign),                   \
      |                                     ^~~~~~
include/linux/tracepoint.h:107:25: note: expanded from macro 'PARAMS'
  107 | #define PARAMS(args...) args
      |                         ^~~~
include/trace/trace_events.h:402:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
  402 |         { assign; }                                                     \
      |           ^~~~~~
In file included from kernel/trace/power-traces.c:15:
In file included from include/trace/events/power.h:557:
In file included from include/trace/define_trace.h:102:
In file included from include/trace/trace_events.h:419:
include/trace/events/power.h:217:3: error: comparison between pointer and integer ('char *' and 'int') [-Werror,-Wpointer-integer-compare]
  198 |                 __field(int, event)
      |                 ~~~~~~~~~~~~~~~~~~~
  199 |         ),
      |         ~~
  200 | 
  201 |         TP_fast_assign(
      |         ~~~~~~~~~~~~~~~
  202 |                 __assign_str(device, dev_name(dev));
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  203 |                 __assign_str(driver, dev_driver_string(dev));
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  204 |                 __assign_str(parent,
      |                 ~~~~~~~~~~~~~~~~~~~~
  205 |                         dev->parent ? dev_name(dev->parent) : "none");
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  206 |                 __assign_str(pm_ops, pm_ops ? pm_ops : "none ");
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  207 |                 __entry->event = event;
      |                 ~~~~~~~~~~~~~~~~~~~~~~~
  208 |         ),
      |         ~~
  209 | 
  210 |         TP_printk("%s %s, parent: %s, %s[%s]", __get_str(driver),
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  211 |                 __get_str(device), __get_str(parent), __get_str(pm_ops),
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  212 |                 pm_verb_symbolic(__entry->event))
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  213 | );
      | ~
include/trace/stages/stage6_event_callback.h:38:21: note: expanded from macro '__assign_str'
   38 |                 WARN_ON_ONCE(!src != !__data_offsets.dst##_ptr_);       \
      |                               ~~~ ^
include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
include/trace/stages/stage6_event_callback.h:135:33: note: expanded from macro 'TP_fast_assign'
  135 | #define TP_fast_assign(args...) args
      |                                 ^~~~
include/trace/trace_events.h:44:16: note: expanded from macro 'TRACE_EVENT'
   40 |         DECLARE_EVENT_CLASS(name,                              \
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   41 |                              PARAMS(proto),                    \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   42 |                              PARAMS(args),                     \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   43 |                              PARAMS(tstruct),                  \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   44 |                              PARAMS(assign),                   \
      |                              ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   45 |                              PARAMS(print));                   \
      |                              ~~~~~~~~~~~~~~
include/linux/tracepoint.h:107:25: note: expanded from macro 'PARAMS'
  107 | #define PARAMS(args...) args
      |                         ^~~~
include/trace/trace_events.h:402:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
  402 |         { assign; }                                                     \
      |           ^~~~~~
In file included from kernel/trace/power-traces.c:15:
In file included from include/trace/events/power.h:557:
In file included from include/trace/define_trace.h:102:
In file included from include/trace/trace_events.h:419:
include/trace/events/power.h:217:31: error: pointer/integer type mismatch in conditional expression ('const char *' and 'int') [-Werror,-Wconditional-type-mismatch]
  198 |                 __field(int, event)
      |                 ~~~~~~~~~~~~~~~~~~~
  199 |         ),
      |         ~~
  200 | 
  201 |         TP_fast_assign(
      |         ~~~~~~~~~~~~~~~
  202 |                 __assign_str(device, dev_name(dev));
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  203 |                 __assign_str(driver, dev_driver_string(dev));
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  204 |                 __assign_str(parent,
      |                 ~~~~~~~~~~~~~~~~~~~~
  205 |                         dev->parent ? dev_name(dev->parent) : "none");
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  206 |                 __assign_str(pm_ops, pm_ops ? pm_ops : "none ");
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
  207 |                 __entry->event = event;
      |                 ~~~~~~~~~~~~~~~~~~~~~~~
  208 |         ),
      |         ~~
  209 | 
  210 |         TP_printk("%s %s, parent: %s, %s[%s]", __get_str(driver),
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  211 |                 __get_str(device), __get_str(parent), __get_str(pm_ops),
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  212 |                 pm_verb_symbolic(__entry->event))
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  213 | );
      | ~
include/trace/stages/stage6_event_callback.h:38:17: note: expanded from macro '__assign_str'
   38 |                 WARN_ON_ONCE(!src != !__data_offsets.dst##_ptr_);       \
      |                               ^~~
include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
include/trace/stages/stage6_event_callback.h:135:33: note: expanded from macro 'TP_fast_assign'
  135 | #define TP_fast_assign(args...) args
      |                                 ^~~~
include/trace/trace_events.h:44:16: note: expanded from macro 'TRACE_EVENT'
   40 |         DECLARE_EVENT_CLASS(name,                              \
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   41 |                              PARAMS(proto),                    \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   42 |                              PARAMS(args),                     \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   43 |                              PARAMS(tstruct),                  \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   44 |                              PARAMS(assign),                   \
      |                              ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   45 |                              PARAMS(print));                   \
      |                              ~~~~~~~~~~~~~~
include/linux/tracepoint.h:107:25: note: expanded from macro 'PARAMS'
  107 | #define PARAMS(args...) args
      |                         ^~~~
include/trace/trace_events.h:402:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
  402 |         { assign; }                                                     \
      |           ^~~~~~
In file included from kernel/trace/power-traces.c:15:
In file included from include/trace/events/power.h:557:
In file included from include/trace/define_trace.h:102:
In file included from include/trace/trace_events.h:419:
include/trace/events/power.h:217:31: error: pointer/integer type mismatch in conditional expression ('const char *' and 'int') [-Werror,-Wconditional-type-mismatch]
  198 |                 __field(int, event)
      |                 ~~~~~~~~~~~~~~~~~~~
  199 |         ),
      |         ~~
  200 | 
  201 |         TP_fast_assign(
      |         ~~~~~~~~~~~~~~~
  202 |                 __assign_str(device, dev_name(dev));
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  203 |                 __assign_str(driver, dev_driver_string(dev));
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  204 |                 __assign_str(parent,
      |                 ~~~~~~~~~~~~~~~~~~~~
  205 |                         dev->parent ? dev_name(dev->parent) : "none");
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  206 |                 __assign_str(pm_ops, pm_ops ? pm_ops : "none ");
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
  207 |                 __entry->event = event;
      |                 ~~~~~~~~~~~~~~~~~~~~~~~
  208 |         ),
      |         ~~
  209 | 
  210 |         TP_printk("%s %s, parent: %s, %s[%s]", __get_str(driver),
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  211 |                 __get_str(device), __get_str(parent), __get_str(pm_ops),
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  212 |                 pm_verb_symbolic(__entry->event))
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  213 | );
      | ~
include/trace/stages/stage6_event_callback.h:39:16: note: expanded from macro '__assign_str'
   39 |                 WARN_ON_ONCE(src && strcmp((src), __data_offsets.dst##_ptr_)); \
      |                              ^~~
include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
include/trace/stages/stage6_event_callback.h:135:33: note: expanded from macro 'TP_fast_assign'
  135 | #define TP_fast_assign(args...) args
      |                                 ^~~~
include/trace/trace_events.h:44:16: note: expanded from macro 'TRACE_EVENT'
   40 |         DECLARE_EVENT_CLASS(name,                              \
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   41 |                              PARAMS(proto),                    \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   42 |                              PARAMS(args),                     \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   43 |                              PARAMS(tstruct),                  \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   44 |                              PARAMS(assign),                   \
      |                              ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   45 |                              PARAMS(print));                   \
      |                              ~~~~~~~~~~~~~~
include/linux/tracepoint.h:107:25: note: expanded from macro 'PARAMS'
  107 | #define PARAMS(args...) args
      |                         ^~~~
include/trace/trace_events.h:402:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
  402 |         { assign; }                                                     \
      |           ^~~~~~
In file included from kernel/trace/power-traces.c:15:
In file included from include/trace/events/power.h:557:
In file included from include/trace/define_trace.h:103:
In file included from include/trace/perf.h:75:
include/trace/events/power.h:215:3: error: result of comparison against a string literal is unspecified (use an explicit string comparison function instead) [-Werror,-Wstring-compare]
  215 |                 __assign_str(parent,
      |                 ^
  216 |                         dev->parent ? dev_name(dev->parent) : "none");
      |                                                               ~~~~~~
include/trace/stages/stage6_event_callback.h:38:21: note: expanded from macro '__assign_str'
   38 |                 WARN_ON_ONCE(!src != !__data_offsets.dst##_ptr_);       \
      |                               ~~~ ^
include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
include/trace/stages/stage6_event_callback.h:135:33: note: expanded from macro 'TP_fast_assign'
  135 | #define TP_fast_assign(args...) args
      |                                 ^~~~
include/trace/trace_events.h:44:16: note: expanded from macro 'TRACE_EVENT'
   44 |                              PARAMS(assign),                   \
      |                                     ^~~~~~
include/linux/tracepoint.h:107:25: note: expanded from macro 'PARAMS'
  107 | #define PARAMS(args...) args
      |                         ^~~~
include/trace/perf.h:51:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
   51 |         { assign; }                                                     \
      |           ^~~~~~
In file included from kernel/trace/power-traces.c:15:
In file included from include/trace/events/power.h:557:
In file included from include/trace/define_trace.h:103:
In file included from include/trace/perf.h:75:
include/trace/events/power.h:215:3: error: comparison between pointer and integer ('char *' and 'int') [-Werror,-Wpointer-integer-compare]
  198 |                 __string(pm_ops, pm_ops ? pm_ops : "none ")
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  199 |                 __field(int, event)
      |                 ~~~~~~~~~~~~~~~~~~~
  200 |         ),
      |         ~~
  201 | 
  202 |         TP_fast_assign(
      |         ~~~~~~~~~~~~~~~
  203 |                 __assign_str(device, dev_name(dev));
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  204 |                 __assign_str(driver, dev_driver_string(dev));
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  205 |                 __assign_str(parent,
      |                 ^~~~~~~~~~~~~~~~~~~~
  206 |                         dev->parent ? dev_name(dev->parent) : "none");
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  207 |                 __assign_str(pm_ops, pm_ops ? pm_ops : "none ");
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  208 |                 __entry->event = event;
      |                 ~~~~~~~~~~~~~~~~~~~~~~~
  209 |         ),
      |         ~~
  210 | 
  211 |         TP_printk("%s %s, parent: %s, %s[%s]", __get_str(driver),
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  212 |                 __get_str(device), __get_str(parent), __get_str(pm_ops),
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  213 |                 pm_verb_symbolic(__entry->event))
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/trace/stages/stage6_event_callback.h:38:21: note: expanded from macro '__assign_str'
   38 |                 WARN_ON_ONCE(!src != !__data_offsets.dst##_ptr_);       \
      |                               ~~~ ^
include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
include/trace/stages/stage6_event_callback.h:135:33: note: expanded from macro 'TP_fast_assign'
  135 | #define TP_fast_assign(args...) args
      |                                 ^~~~
include/trace/trace_events.h:44:16: note: expanded from macro 'TRACE_EVENT'
   40 |         DECLARE_EVENT_CLASS(name,                              \
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   41 |                              PARAMS(proto),                    \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   42 |                              PARAMS(args),                     \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   43 |                              PARAMS(tstruct),                  \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   44 |                              PARAMS(assign),                   \
      |                              ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   45 |                              PARAMS(print));                   \
      |                              ~~~~~~~~~~~~~~
include/linux/tracepoint.h:107:25: note: expanded from macro 'PARAMS'
  107 | #define PARAMS(args...) args
      |                         ^~~~
include/trace/perf.h:51:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
   51 |         { assign; }                                                     \
      |           ^~~~~~
In file included from kernel/trace/power-traces.c:15:
In file included from include/trace/events/power.h:557:
In file included from include/trace/define_trace.h:103:
In file included from include/trace/perf.h:75:
include/trace/events/power.h:216:16: error: pointer/integer type mismatch in conditional expression ('const char *' and 'int') [-Werror,-Wconditional-type-mismatch]
  198 |                 __field(int, event)
      |                 ~~~~~~~~~~~~~~~~~~~
  199 |         ),
      |         ~~
  200 | 
  201 |         TP_fast_assign(
      |         ~~~~~~~~~~~~~~~
  202 |                 __assign_str(device, dev_name(dev));
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  203 |                 __assign_str(driver, dev_driver_string(dev));
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  204 |                 __assign_str(parent,
      |                 ~~~~~~~~~~~~~~~~~~~~
  205 |                         dev->parent ? dev_name(dev->parent) : "none");
      |                         ~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  206 |                 __assign_str(pm_ops, pm_ops ? pm_ops : "none ");
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  207 |                 __entry->event = event;
      |                 ~~~~~~~~~~~~~~~~~~~~~~~
  208 |         ),
      |         ~~
  209 | 
  210 |         TP_printk("%s %s, parent: %s, %s[%s]", __get_str(driver),
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  211 |                 __get_str(device), __get_str(parent), __get_str(pm_ops),
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  212 |                 pm_verb_symbolic(__entry->event))
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  213 | );
      | ~
include/trace/stages/stage6_event_callback.h:38:17: note: expanded from macro '__assign_str'
   38 |                 WARN_ON_ONCE(!src != !__data_offsets.dst##_ptr_);       \
      |                               ^~~
include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
include/trace/stages/stage6_event_callback.h:135:33: note: expanded from macro 'TP_fast_assign'
  135 | #define TP_fast_assign(args...) args
      |                                 ^~~~
include/trace/trace_events.h:44:16: note: expanded from macro 'TRACE_EVENT'
   40 |         DECLARE_EVENT_CLASS(name,                              \
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   41 |                              PARAMS(proto),                    \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   42 |                              PARAMS(args),                     \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   43 |                              PARAMS(tstruct),                  \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   44 |                              PARAMS(assign),                   \
      |                              ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   45 |                              PARAMS(print));                   \
      |                              ~~~~~~~~~~~~~~
include/linux/tracepoint.h:107:25: note: expanded from macro 'PARAMS'
  107 | #define PARAMS(args...) args
      |                         ^~~~
include/trace/perf.h:51:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
   51 |         { assign; }                                                     \
      |           ^~~~~~
In file included from kernel/trace/power-traces.c:15:
In file included from include/trace/events/power.h:557:
In file included from include/trace/define_trace.h:103:
In file included from include/trace/perf.h:75:
include/trace/events/power.h:216:16: error: pointer/integer type mismatch in conditional expression ('const char *' and 'int') [-Werror,-Wconditional-type-mismatch]
  198 |                 __field(int, event)
      |                 ~~~~~~~~~~~~~~~~~~~
  199 |         ),
      |         ~~
  200 | 
  201 |         TP_fast_assign(
      |         ~~~~~~~~~~~~~~~
  202 |                 __assign_str(device, dev_name(dev));
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  203 |                 __assign_str(driver, dev_driver_string(dev));
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  204 |                 __assign_str(parent,
      |                 ~~~~~~~~~~~~~~~~~~~~
  205 |                         dev->parent ? dev_name(dev->parent) : "none");
      |                         ~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  206 |                 __assign_str(pm_ops, pm_ops ? pm_ops : "none ");
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  207 |                 __entry->event = event;
      |                 ~~~~~~~~~~~~~~~~~~~~~~~
  208 |         ),
      |         ~~
  209 | 
  210 |         TP_printk("%s %s, parent: %s, %s[%s]", __get_str(driver),
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  211 |                 __get_str(device), __get_str(parent), __get_str(pm_ops),
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  212 |                 pm_verb_symbolic(__entry->event))
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  213 | );
      | ~
include/trace/stages/stage6_event_callback.h:39:16: note: expanded from macro '__assign_str'
   39 |                 WARN_ON_ONCE(src && strcmp((src), __data_offsets.dst##_ptr_)); \
      |                              ^~~
include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
include/trace/stages/stage6_event_callback.h:135:33: note: expanded from macro 'TP_fast_assign'
  135 | #define TP_fast_assign(args...) args
      |                                 ^~~~
include/trace/trace_events.h:44:16: note: expanded from macro 'TRACE_EVENT'
   40 |         DECLARE_EVENT_CLASS(name,                              \
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   41 |                              PARAMS(proto),                    \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   42 |                              PARAMS(args),                     \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   43 |                              PARAMS(tstruct),                  \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   44 |                              PARAMS(assign),                   \
      |                              ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   45 |                              PARAMS(print));                   \
      |                              ~~~~~~~~~~~~~~
include/linux/tracepoint.h:107:25: note: expanded from macro 'PARAMS'
  107 | #define PARAMS(args...) args
      |                         ^~~~
include/trace/perf.h:51:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
   51 |         { assign; }                                                     \
      |           ^~~~~~
In file included from kernel/trace/power-traces.c:15:
In file included from include/trace/events/power.h:557:
In file included from include/trace/define_trace.h:103:
In file included from include/trace/perf.h:75:
include/trace/events/power.h:217:3: error: result of comparison against a string literal is unspecified (use an explicit string comparison function instead) [-Werror,-Wstring-compare]
  217 |                 __assign_str(pm_ops, pm_ops ? pm_ops : "none ");
      |                 ^                                      ~~~~~~~
include/trace/stages/stage6_event_callback.h:38:21: note: expanded from macro '__assign_str'
   38 |                 WARN_ON_ONCE(!src != !__data_offsets.dst##_ptr_);       \
      |                               ~~~ ^
include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
include/trace/stages/stage6_event_callback.h:135:33: note: expanded from macro 'TP_fast_assign'
  135 | #define TP_fast_assign(args...) args
      |                                 ^~~~
include/trace/trace_events.h:44:16: note: expanded from macro 'TRACE_EVENT'
   44 |                              PARAMS(assign),                   \
      |                                     ^~~~~~
include/linux/tracepoint.h:107:25: note: expanded from macro 'PARAMS'
  107 | #define PARAMS(args...) args
      |                         ^~~~
include/trace/perf.h:51:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
   51 |         { assign; }                                                     \
      |           ^~~~~~
In file included from kernel/trace/power-traces.c:15:
In file included from include/trace/events/power.h:557:
In file included from include/trace/define_trace.h:103:
In file included from include/trace/perf.h:75:
include/trace/events/power.h:217:3: error: comparison between pointer and integer ('char *' and 'int') [-Werror,-Wpointer-integer-compare]
  198 |                 __field(int, event)
      |                 ~~~~~~~~~~~~~~~~~~~
  199 |         ),
      |         ~~
  200 | 
  201 |         TP_fast_assign(
      |         ~~~~~~~~~~~~~~~
  202 |                 __assign_str(device, dev_name(dev));
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  203 |                 __assign_str(driver, dev_driver_string(dev));
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  204 |                 __assign_str(parent,
      |                 ~~~~~~~~~~~~~~~~~~~~
  205 |                         dev->parent ? dev_name(dev->parent) : "none");
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  206 |                 __assign_str(pm_ops, pm_ops ? pm_ops : "none ");
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  207 |                 __entry->event = event;
      |                 ~~~~~~~~~~~~~~~~~~~~~~~
  208 |         ),
      |         ~~
  209 | 
  210 |         TP_printk("%s %s, parent: %s, %s[%s]", __get_str(driver),
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  211 |                 __get_str(device), __get_str(parent), __get_str(pm_ops),
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  212 |                 pm_verb_symbolic(__entry->event))
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  213 | );
      | ~
include/trace/stages/stage6_event_callback.h:38:21: note: expanded from macro '__assign_str'
   38 |                 WARN_ON_ONCE(!src != !__data_offsets.dst##_ptr_);       \
      |                               ~~~ ^
include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
include/trace/stages/stage6_event_callback.h:135:33: note: expanded from macro 'TP_fast_assign'
  135 | #define TP_fast_assign(args...) args
      |                                 ^~~~
include/trace/trace_events.h:44:16: note: expanded from macro 'TRACE_EVENT'
   40 |         DECLARE_EVENT_CLASS(name,                              \
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   41 |                              PARAMS(proto),                    \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   42 |                              PARAMS(args),                     \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   43 |                              PARAMS(tstruct),                  \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   44 |                              PARAMS(assign),                   \
      |                              ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   45 |                              PARAMS(print));                   \
      |                              ~~~~~~~~~~~~~~
include/linux/tracepoint.h:107:25: note: expanded from macro 'PARAMS'
  107 | #define PARAMS(args...) args
      |                         ^~~~
include/trace/perf.h:51:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
   51 |         { assign; }                                                     \
      |           ^~~~~~
In file included from kernel/trace/power-traces.c:15:
In file included from include/trace/events/power.h:557:
In file included from include/trace/define_trace.h:103:
In file included from include/trace/perf.h:75:
include/trace/events/power.h:217:31: error: pointer/integer type mismatch in conditional expression ('const char *' and 'int') [-Werror,-Wconditional-type-mismatch]
  198 |                 __field(int, event)
      |                 ~~~~~~~~~~~~~~~~~~~
  199 |         ),
      |         ~~
  200 | 
  201 |         TP_fast_assign(
      |         ~~~~~~~~~~~~~~~
  202 |                 __assign_str(device, dev_name(dev));
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  203 |                 __assign_str(driver, dev_driver_string(dev));
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  204 |                 __assign_str(parent,
      |                 ~~~~~~~~~~~~~~~~~~~~
  205 |                         dev->parent ? dev_name(dev->parent) : "none");
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  206 |                 __assign_str(pm_ops, pm_ops ? pm_ops : "none ");
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
  207 |                 __entry->event = event;
      |                 ~~~~~~~~~~~~~~~~~~~~~~~
  208 |         ),
      |         ~~
  209 | 
  210 |         TP_printk("%s %s, parent: %s, %s[%s]", __get_str(driver),
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  211 |                 __get_str(device), __get_str(parent), __get_str(pm_ops),
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  212 |                 pm_verb_symbolic(__entry->event))
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  213 | );
      | ~
include/trace/stages/stage6_event_callback.h:38:17: note: expanded from macro '__assign_str'
   38 |                 WARN_ON_ONCE(!src != !__data_offsets.dst##_ptr_);       \
      |                               ^~~
include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
include/trace/stages/stage6_event_callback.h:135:33: note: expanded from macro 'TP_fast_assign'
  135 | #define TP_fast_assign(args...) args
      |                                 ^~~~
include/trace/trace_events.h:44:16: note: expanded from macro 'TRACE_EVENT'
   40 |         DECLARE_EVENT_CLASS(name,                              \
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   41 |                              PARAMS(proto),                    \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   42 |                              PARAMS(args),                     \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   43 |                              PARAMS(tstruct),                  \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   44 |                              PARAMS(assign),                   \
      |                              ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   45 |                              PARAMS(print));                   \
      |                              ~~~~~~~~~~~~~~
include/linux/tracepoint.h:107:25: note: expanded from macro 'PARAMS'
  107 | #define PARAMS(args...) args
      |                         ^~~~
include/trace/perf.h:51:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
   51 |         { assign; }                                                     \
      |           ^~~~~~
In file included from kernel/trace/power-traces.c:15:
In file included from include/trace/events/power.h:557:
In file included from include/trace/define_trace.h:103:
In file included from include/trace/perf.h:75:
include/trace/events/power.h:217:31: error: pointer/integer type mismatch in conditional expression ('const char *' and 'int') [-Werror,-Wconditional-type-mismatch]
  198 |                 __field(int, event)
      |                 ~~~~~~~~~~~~~~~~~~~
  199 |         ),
      |         ~~
  200 | 
  201 |         TP_fast_assign(
      |         ~~~~~~~~~~~~~~~
  202 |                 __assign_str(device, dev_name(dev));
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  203 |                 __assign_str(driver, dev_driver_string(dev));
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  204 |                 __assign_str(parent,
      |                 ~~~~~~~~~~~~~~~~~~~~
  205 |                         dev->parent ? dev_name(dev->parent) : "none");
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  206 |                 __assign_str(pm_ops, pm_ops ? pm_ops : "none ");
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
  207 |                 __entry->event = event;
      |                 ~~~~~~~~~~~~~~~~~~~~~~~
  208 |         ),
      |         ~~
  209 | 
  210 |         TP_printk("%s %s, parent: %s, %s[%s]", __get_str(driver),
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  211 |                 __get_str(device), __get_str(parent), __get_str(pm_ops),
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  212 |                 pm_verb_symbolic(__entry->event))
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  213 | );
      | ~
include/trace/stages/stage6_event_callback.h:39:16: note: expanded from macro '__assign_str'
   39 |                 WARN_ON_ONCE(src && strcmp((src), __data_offsets.dst##_ptr_)); \
      |                              ^~~
include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
include/trace/stages/stage6_event_callback.h:135:33: note: expanded from macro 'TP_fast_assign'
  135 | #define TP_fast_assign(args...) args
      |                                 ^~~~
include/trace/trace_events.h:44:16: note: expanded from macro 'TRACE_EVENT'
   40 |         DECLARE_EVENT_CLASS(name,                              \
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   41 |                              PARAMS(proto),                    \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   42 |                              PARAMS(args),                     \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   43 |                              PARAMS(tstruct),                  \
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   44 |                              PARAMS(assign),                   \
      |                              ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   45 |                              PARAMS(print));                   \
      |                              ~~~~~~~~~~~~~~
include/linux/tracepoint.h:107:25: note: expanded from macro 'PARAMS'
  107 | #define PARAMS(args...) args
      |                         ^~~~
include/trace/perf.h:51:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
   51 |         { assign; }                                                     \
      |           ^~~~~~
16 errors generated.
make[6]: *** [scripts/Makefile.build:243: kernel/trace/power-traces.o] Error 1
make[6]: Target 'kernel/trace/' not remade because of errors.
make[5]: *** [scripts/Makefile.build:481: kernel/trace] Error 2
make[5]: Target 'kernel/' not remade because of errors.
make[4]: *** [scripts/Makefile.build:481: kernel] Error 2
In file included from fs/nfs/nfs4trace.c:13:
In file included from fs/nfs/nfs4trace.h:2559:
In file included from include/trace/define_trace.h:102:
In file included from include/trace/trace_events.h:419:
fs/nfs/nfs4trace.h:1332:4: error: result of comparison against a string literal is unspecified (use an explicit string comparison function instead) [-Werror,-Wstring-compare]
 1332 |                         __assign_str(dstaddr, clp ? clp->cl_hostname : "unknown");
      |                         ^                                              ~~~~~~~~~
include/trace/stages/stage6_event_callback.h:38:21: note: expanded from macro '__assign_str'
   38 |                 WARN_ON_ONCE(!src != !__data_offsets.dst##_ptr_);       \
      |                               ~~~ ^
include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
include/trace/stages/stage6_event_callback.h:135:33: note: expanded from macro 'TP_fast_assign'
  135 | #define TP_fast_assign(args...) args
      |                                 ^~~~
include/trace/trace_events.h:402:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
  402 |         { assign; }                                                     \
      |           ^~~~~~
In file included from fs/nfs/nfs4trace.c:13:
In file included from fs/nfs/nfs4trace.h:2559:
In file included from include/trace/define_trace.h:102:
In file included from include/trace/trace_events.h:419:
fs/nfs/nfs4trace.h:1332:4: error: comparison between pointer and integer ('char *' and 'int') [-Werror,-Wpointer-integer-compare]
 1304 |                         if (!IS_ERR_OR_NULL(inode)) {
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1305 |                                 __entry->fileid = NFS_FILEID(inode);
      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1306 |                                 __entry->dev = inode->i_sb->s_dev;
      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1307 |                         } else {
      |                         ~~~~~~~~
 1308 |                                 __entry->fileid = 0;
      |                                 ~~~~~~~~~~~~~~~~~~~~
 1309 |                                 __entry->dev = 0;
      |                                 ~~~~~~~~~~~~~~~~~
 1310 |                         }
      |                         ~
 1311 |                         __assign_str(dstaddr, clp ? clp->cl_hostname : "unknown");
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1312 |                 ),
      |                 ~~
 1313 | 
 1314 |                 TP_printk(
      |                 ~~~~~~~~~~
 1315 |                         "error=%ld (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1316 |                         "dstaddr=%s",
      |                         ~~~~~~~~~~~~~
 1317 |                         -__entry->error,
      |                         ~~~~~~~~~~~~~~~~
 1318 |                         show_nfs4_status(__entry->error),
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1319 |                         MAJOR(__entry->dev), MINOR(__entry->dev),
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/trace/stages/stage6_event_callback.h:38:21: note: expanded from macro '__assign_str'
   38 |                 WARN_ON_ONCE(!src != !__data_offsets.dst##_ptr_);       \
      |                               ~~~ ^
include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
include/trace/stages/stage6_event_callback.h:135:33: note: expanded from macro 'TP_fast_assign'
  135 | #define TP_fast_assign(args...) args
      |                                 ^~~~
include/trace/trace_events.h:402:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
  402 |         { assign; }                                                     \
      |           ^~~~~~
In file included from fs/nfs/nfs4trace.c:13:
In file included from fs/nfs/nfs4trace.h:2559:
In file included from include/trace/define_trace.h:102:
In file included from include/trace/trace_events.h:419:
fs/nfs/nfs4trace.h:1332:30: error: pointer/integer type mismatch in conditional expression ('char *' and 'int') [-Werror,-Wconditional-type-mismatch]
 1304 |                         if (!IS_ERR_OR_NULL(inode)) {
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1305 |                                 __entry->fileid = NFS_FILEID(inode);
      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1306 |                                 __entry->dev = inode->i_sb->s_dev;
      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1307 |                         } else {
      |                         ~~~~~~~~
 1308 |                                 __entry->fileid = 0;
      |                                 ~~~~~~~~~~~~~~~~~~~~
 1309 |                                 __entry->dev = 0;
      |                                 ~~~~~~~~~~~~~~~~~
 1310 |                         }
      |                         ~
 1311 |                         __assign_str(dstaddr, clp ? clp->cl_hostname : "unknown");
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1312 |                 ),
      |                 ~~
 1313 | 
 1314 |                 TP_printk(
      |                 ~~~~~~~~~~
 1315 |                         "error=%ld (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1316 |                         "dstaddr=%s",
      |                         ~~~~~~~~~~~~~
 1317 |                         -__entry->error,
      |                         ~~~~~~~~~~~~~~~~
 1318 |                         show_nfs4_status(__entry->error),
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1319 |                         MAJOR(__entry->dev), MINOR(__entry->dev),
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/trace/stages/stage6_event_callback.h:38:17: note: expanded from macro '__assign_str'
   38 |                 WARN_ON_ONCE(!src != !__data_offsets.dst##_ptr_);       \
      |                               ^~~
include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
include/trace/stages/stage6_event_callback.h:135:33: note: expanded from macro 'TP_fast_assign'
  135 | #define TP_fast_assign(args...) args
      |                                 ^~~~
include/trace/trace_events.h:402:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
  402 |         { assign; }                                                     \
      |           ^~~~~~
In file included from fs/nfs/nfs4trace.c:13:
In file included from fs/nfs/nfs4trace.h:2559:
In file included from include/trace/define_trace.h:102:
In file included from include/trace/trace_events.h:419:
fs/nfs/nfs4trace.h:1332:30: error: pointer/integer type mismatch in conditional expression ('char *' and 'int') [-Werror,-Wconditional-type-mismatch]
 1304 |                         if (!IS_ERR_OR_NULL(inode)) {
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1305 |                                 __entry->fileid = NFS_FILEID(inode);
      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1306 |                                 __entry->dev = inode->i_sb->s_dev;
      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1307 |                         } else {
      |                         ~~~~~~~~
 1308 |                                 __entry->fileid = 0;
      |                                 ~~~~~~~~~~~~~~~~~~~~
 1309 |                                 __entry->dev = 0;
      |                                 ~~~~~~~~~~~~~~~~~
 1310 |                         }
      |                         ~
 1311 |                         __assign_str(dstaddr, clp ? clp->cl_hostname : "unknown");
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1312 |                 ),
      |                 ~~
 1313 | 
 1314 |                 TP_printk(
      |                 ~~~~~~~~~~
 1315 |                         "error=%ld (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1316 |                         "dstaddr=%s",
      |                         ~~~~~~~~~~~~~
 1317 |                         -__entry->error,
      |                         ~~~~~~~~~~~~~~~~
 1318 |                         show_nfs4_status(__entry->error),
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1319 |                         MAJOR(__entry->dev), MINOR(__entry->dev),
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/trace/stages/stage6_event_callback.h:39:16: note: expanded from macro '__assign_str'
   39 |                 WARN_ON_ONCE(src && strcmp((src), __data_offsets.dst##_ptr_)); \
      |                              ^~~
include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
include/trace/stages/stage6_event_callback.h:135:33: note: expanded from macro 'TP_fast_assign'
  135 | #define TP_fast_assign(args...) args
      |                                 ^~~~
include/trace/trace_events.h:402:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
  402 |         { assign; }                                                     \
      |           ^~~~~~
In file included from fs/nfs/nfs4trace.c:13:
In file included from fs/nfs/nfs4trace.h:2559:
In file included from include/trace/define_trace.h:102:
In file included from include/trace/trace_events.h:419:
fs/nfs/nfs4trace.h:1389:4: error: result of comparison against a string literal is unspecified (use an explicit string comparison function instead) [-Werror,-Wstring-compare]
 1389 |                         __assign_str(dstaddr, clp ? clp->cl_hostname : "unknown");
      |                         ^                                              ~~~~~~~~~
include/trace/stages/stage6_event_callback.h:38:21: note: expanded from macro '__assign_str'
   38 |                 WARN_ON_ONCE(!src != !__data_offsets.dst##_ptr_);       \
      |                               ~~~ ^
include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
include/trace/stages/stage6_event_callback.h:135:33: note: expanded from macro 'TP_fast_assign'
  135 | #define TP_fast_assign(args...) args
      |                                 ^~~~
include/trace/trace_events.h:402:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
  402 |         { assign; }                                                     \
      |           ^~~~~~
In file included from fs/nfs/nfs4trace.c:13:
In file included from fs/nfs/nfs4trace.h:2559:
In file included from include/trace/define_trace.h:102:
In file included from include/trace/trace_events.h:419:
fs/nfs/nfs4trace.h:1389:4: error: comparison between pointer and integer ('char *' and 'int') [-Werror,-Wpointer-integer-compare]
 1358 |                         if (!IS_ERR_OR_NULL(inode)) {
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1359 |                                 __entry->fileid = NFS_FILEID(inode);
      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1360 |                                 __entry->dev = inode->i_sb->s_dev;
      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1361 |                         } else {
      |                         ~~~~~~~~
 1362 |                                 __entry->fileid = 0;
      |                                 ~~~~~~~~~~~~~~~~~~~~
 1363 |                                 __entry->dev = 0;
      |                                 ~~~~~~~~~~~~~~~~~
 1364 |                         }
      |                         ~
 1365 |                         __assign_str(dstaddr, clp ? clp->cl_hostname : "unknown");
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1366 |                         __entry->stateid_seq =
      |                         ~~~~~~~~~~~~~~~~~~~~~~
 1367 |                                 be32_to_cpu(stateid->seqid);
      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1368 |                         __entry->stateid_hash =
      |                         ~~~~~~~~~~~~~~~~~~~~~~~
 1369 |                                 nfs_stateid_hash(stateid);
      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~
 1370 |                 ),
      |                 ~~
 1371 | 
 1372 |                 TP_printk(
      |                 ~~~~~~~~~~
 1373 |                         "error=%ld (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/trace/stages/stage6_event_callback.h:38:21: note: expanded from macro '__assign_str'
   38 |                 WARN_ON_ONCE(!src != !__data_offsets.dst##_ptr_);       \
      |                               ~~~ ^
include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
include/trace/stages/stage6_event_callback.h:135:33: note: expanded from macro 'TP_fast_assign'
  135 | #define TP_fast_assign(args...) args
      |                                 ^~~~
include/trace/trace_events.h:402:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
  402 |         { assign; }                                                     \
      |           ^~~~~~
In file included from fs/nfs/nfs4trace.c:13:
In file included from fs/nfs/nfs4trace.h:2559:
In file included from include/trace/define_trace.h:102:
In file included from include/trace/trace_events.h:419:
fs/nfs/nfs4trace.h:1389:30: error: pointer/integer type mismatch in conditional expression ('char *' and 'int') [-Werror,-Wconditional-type-mismatch]
 1358 |                         if (!IS_ERR_OR_NULL(inode)) {
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1359 |                                 __entry->fileid = NFS_FILEID(inode);
      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1360 |                                 __entry->dev = inode->i_sb->s_dev;
      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1361 |                         } else {
      |                         ~~~~~~~~
 1362 |                                 __entry->fileid = 0;
      |                                 ~~~~~~~~~~~~~~~~~~~~
 1363 |                                 __entry->dev = 0;
      |                                 ~~~~~~~~~~~~~~~~~
 1364 |                         }
      |                         ~
 1365 |                         __assign_str(dstaddr, clp ? clp->cl_hostname : "unknown");
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1366 |                         __entry->stateid_seq =
      |                         ~~~~~~~~~~~~~~~~~~~~~~
 1367 |                                 be32_to_cpu(stateid->seqid);
      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1368 |                         __entry->stateid_hash =
      |                         ~~~~~~~~~~~~~~~~~~~~~~~
 1369 |                                 nfs_stateid_hash(stateid);
      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~
 1370 |                 ),
      |                 ~~
 1371 | 
 1372 |                 TP_printk(
      |                 ~~~~~~~~~~
 1373 |                         "error=%ld (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/trace/stages/stage6_event_callback.h:38:17: note: expanded from macro '__assign_str'
   38 |                 WARN_ON_ONCE(!src != !__data_offsets.dst##_ptr_);       \
      |                               ^~~
include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
include/trace/stages/stage6_event_callback.h:135:33: note: expanded from macro 'TP_fast_assign'
  135 | #define TP_fast_assign(args...) args
      |                                 ^~~~
include/trace/trace_events.h:402:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
  402 |         { assign; }                                                     \
      |           ^~~~~~
In file included from fs/nfs/nfs4trace.c:13:
In file included from fs/nfs/nfs4trace.h:2559:
In file included from include/trace/define_trace.h:102:
In file included from include/trace/trace_events.h:419:
fs/nfs/nfs4trace.h:1389:30: error: pointer/integer type mismatch in conditional expression ('char *' and 'int') [-Werror,-Wconditional-type-mismatch]
 1358 |                         if (!IS_ERR_OR_NULL(inode)) {
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1359 |                                 __entry->fileid = NFS_FILEID(inode);
      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1360 |                                 __entry->dev = inode->i_sb->s_dev;
      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1361 |                         } else {
      |                         ~~~~~~~~
 1362 |                                 __entry->fileid = 0;
      |                                 ~~~~~~~~~~~~~~~~~~~~
 1363 |                                 __entry->dev = 0;
      |                                 ~~~~~~~~~~~~~~~~~
 1364 |                         }
      |                         ~
 1365 |                         __assign_str(dstaddr, clp ? clp->cl_hostname : "unknown");
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1366 |                         __entry->stateid_seq =
      |                         ~~~~~~~~~~~~~~~~~~~~~~
 1367 |                                 be32_to_cpu(stateid->seqid);
      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1368 |                         __entry->stateid_hash =
      |                         ~~~~~~~~~~~~~~~~~~~~~~~
 1369 |                                 nfs_stateid_hash(stateid);
      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~
 1370 |                 ),
      |                 ~~
 1371 | 
 1372 |                 TP_printk(
      |                 ~~~~~~~~~~
 1373 |                         "error=%ld (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/trace/stages/stage6_event_callback.h:39:16: note: expanded from macro '__assign_str'
   39 |                 WARN_ON_ONCE(src && strcmp((src), __data_offsets.dst##_ptr_)); \
      |                              ^~~
include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
include/trace/stages/stage6_event_callback.h:135:33: note: expanded from macro 'TP_fast_assign'
  135 | #define TP_fast_assign(args...) args
      |                                 ^~~~
include/trace/trace_events.h:402:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
  402 |         { assign; }                                                     \
      |           ^~~~~~
In file included from fs/nfs/nfs4trace.c:13:
In file included from fs/nfs/nfs4trace.h:2559:
In file included from include/trace/define_trace.h:103:
In file included from include/trace/perf.h:75:
fs/nfs/nfs4trace.h:1332:4: error: result of comparison against a string literal is unspecified (use an explicit string comparison function instead) [-Werror,-Wstring-compare]
 1332 |                         __assign_str(dstaddr, clp ? clp->cl_hostname : "unknown");
      |                         ^                                              ~~~~~~~~~
include/trace/stages/stage6_event_callback.h:38:21: note: expanded from macro '__assign_str'
   38 |                 WARN_ON_ONCE(!src != !__data_offsets.dst##_ptr_);       \
      |                               ~~~ ^
include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
include/trace/stages/stage6_event_callback.h:135:33: note: expanded from macro 'TP_fast_assign'
  135 | #define TP_fast_assign(args...) args
      |                                 ^~~~
include/trace/perf.h:51:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
   51 |         { assign; }                                                     \
      |           ^~~~~~
In file included from fs/nfs/nfs4trace.c:13:
In file included from fs/nfs/nfs4trace.h:2559:
In file included from include/trace/define_trace.h:103:
In file included from include/trace/perf.h:75:
fs/nfs/nfs4trace.h:1332:4: error: comparison between pointer and integer ('char *' and 'int') [-Werror,-Wpointer-integer-compare]
 1304 |                         if (!IS_ERR_OR_NULL(inode)) {
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1305 |                                 __entry->fileid = NFS_FILEID(inode);
      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1306 |                                 __entry->dev = inode->i_sb->s_dev;
      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1307 |                         } else {
      |                         ~~~~~~~~
 1308 |                                 __entry->fileid = 0;
      |                                 ~~~~~~~~~~~~~~~~~~~~
 1309 |                                 __entry->dev = 0;
      |                                 ~~~~~~~~~~~~~~~~~
 1310 |                         }
      |                         ~
 1311 |                         __assign_str(dstaddr, clp ? clp->cl_hostname : "unknown");
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1312 |                 ),
      |                 ~~
 1313 | 
 1314 |                 TP_printk(
      |                 ~~~~~~~~~~
 1315 |                         "error=%ld (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1316 |                         "dstaddr=%s",
      |                         ~~~~~~~~~~~~~
 1317 |                         -__entry->error,
      |                         ~~~~~~~~~~~~~~~~
 1318 |                         show_nfs4_status(__entry->error),
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1319 |                         MAJOR(__entry->dev), MINOR(__entry->dev),
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/trace/stages/stage6_event_callback.h:38:21: note: expanded from macro '__assign_str'
   38 |                 WARN_ON_ONCE(!src != !__data_offsets.dst##_ptr_);       \
      |                               ~~~ ^
include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
include/trace/stages/stage6_event_callback.h:135:33: note: expanded from macro 'TP_fast_assign'
  135 | #define TP_fast_assign(args...) args
      |                                 ^~~~
include/trace/perf.h:51:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
   51 |         { assign; }                                                     \
      |           ^~~~~~
In file included from fs/nfs/nfs4trace.c:13:
In file included from fs/nfs/nfs4trace.h:2559:
In file included from include/trace/define_trace.h:103:
In file included from include/trace/perf.h:75:
fs/nfs/nfs4trace.h:1332:30: error: pointer/integer type mismatch in conditional expression ('char *' and 'int') [-Werror,-Wconditional-type-mismatch]
 1304 |                         if (!IS_ERR_OR_NULL(inode)) {
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1305 |                                 __entry->fileid = NFS_FILEID(inode);
      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1306 |                                 __entry->dev = inode->i_sb->s_dev;
      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1307 |                         } else {
      |                         ~~~~~~~~
 1308 |                                 __entry->fileid = 0;
      |                                 ~~~~~~~~~~~~~~~~~~~~
 1309 |                                 __entry->dev = 0;
      |                                 ~~~~~~~~~~~~~~~~~
 1310 |                         }
      |                         ~
 1311 |                         __assign_str(dstaddr, clp ? clp->cl_hostname : "unknown");
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1312 |                 ),
      |                 ~~
 1313 | 
 1314 |                 TP_printk(
      |                 ~~~~~~~~~~
 1315 |                         "error=%ld (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1316 |                         "dstaddr=%s",
      |                         ~~~~~~~~~~~~~
 1317 |                         -__entry->error,
      |                         ~~~~~~~~~~~~~~~~
 1318 |                         show_nfs4_status(__entry->error),
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1319 |                         MAJOR(__entry->dev), MINOR(__entry->dev),
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/trace/stages/stage6_event_callback.h:38:17: note: expanded from macro '__assign_str'
   38 |                 WARN_ON_ONCE(!src != !__data_offsets.dst##_ptr_);       \
      |                               ^~~
include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
include/trace/stages/stage6_event_callback.h:135:33: note: expanded from macro 'TP_fast_assign'
  135 | #define TP_fast_assign(args...) args
      |                                 ^~~~
include/trace/perf.h:51:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
   51 |         { assign; }                                                     \
      |           ^~~~~~
In file included from fs/nfs/nfs4trace.c:13:
In file included from fs/nfs/nfs4trace.h:2559:
In file included from include/trace/define_trace.h:103:
In file included from include/trace/perf.h:75:
fs/nfs/nfs4trace.h:1332:30: error: pointer/integer type mismatch in conditional expression ('char *' and 'int') [-Werror,-Wconditional-type-mismatch]
 1304 |                         if (!IS_ERR_OR_NULL(inode)) {
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1305 |                                 __entry->fileid = NFS_FILEID(inode);
      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1306 |                                 __entry->dev = inode->i_sb->s_dev;
      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1307 |                         } else {
      |                         ~~~~~~~~
 1308 |                                 __entry->fileid = 0;
      |                                 ~~~~~~~~~~~~~~~~~~~~
 1309 |                                 __entry->dev = 0;
      |                                 ~~~~~~~~~~~~~~~~~
 1310 |                         }
      |                         ~
 1311 |                         __assign_str(dstaddr, clp ? clp->cl_hostname : "unknown");
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1312 |                 ),
      |                 ~~
 1313 | 
 1314 |                 TP_printk(
      |                 ~~~~~~~~~~
 1315 |                         "error=%ld (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1316 |                         "dstaddr=%s",
      |                         ~~~~~~~~~~~~~
 1317 |                         -__entry->error,
      |                         ~~~~~~~~~~~~~~~~
 1318 |                         show_nfs4_status(__entry->error),
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1319 |                         MAJOR(__entry->dev), MINOR(__entry->dev),
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/trace/stages/stage6_event_callback.h:39:16: note: expanded from macro '__assign_str'
   39 |                 WARN_ON_ONCE(src && strcmp((src), __data_offsets.dst##_ptr_)); \
      |                              ^~~
include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
include/trace/stages/stage6_event_callback.h:135:33: note: expanded from macro 'TP_fast_assign'
  135 | #define TP_fast_assign(args...) args
      |                                 ^~~~
include/trace/perf.h:51:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
   51 |         { assign; }                                                     \
      |           ^~~~~~
In file included from fs/nfs/nfs4trace.c:13:
In file included from fs/nfs/nfs4trace.h:2559:
In file included from include/trace/define_trace.h:103:
In file included from include/trace/perf.h:75:
fs/nfs/nfs4trace.h:1389:4: error: result of comparison against a string literal is unspecified (use an explicit string comparison function instead) [-Werror,-Wstring-compare]
 1389 |                         __assign_str(dstaddr, clp ? clp->cl_hostname : "unknown");
      |                         ^                                              ~~~~~~~~~
include/trace/stages/stage6_event_callback.h:38:21: note: expanded from macro '__assign_str'
   38 |                 WARN_ON_ONCE(!src != !__data_offsets.dst##_ptr_);       \
      |                               ~~~ ^
include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
include/trace/stages/stage6_event_callback.h:135:33: note: expanded from macro 'TP_fast_assign'
  135 | #define TP_fast_assign(args...) args
      |                                 ^~~~
include/trace/perf.h:51:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
   51 |         { assign; }                                                     \
      |           ^~~~~~
In file included from fs/nfs/nfs4trace.c:13:
In file included from fs/nfs/nfs4trace.h:2559:
In file included from include/trace/define_trace.h:103:
In file included from include/trace/perf.h:75:
fs/nfs/nfs4trace.h:1389:4: error: comparison between pointer and integer ('char *' and 'int') [-Werror,-Wpointer-integer-compare]
 1358 |                         if (!IS_ERR_OR_NULL(inode)) {
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1359 |                                 __entry->fileid = NFS_FILEID(inode);
      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1360 |                                 __entry->dev = inode->i_sb->s_dev;
      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1361 |                         } else {
      |                         ~~~~~~~~
 1362 |                                 __entry->fileid = 0;
      |                                 ~~~~~~~~~~~~~~~~~~~~
 1363 |                                 __entry->dev = 0;
      |                                 ~~~~~~~~~~~~~~~~~
 1364 |                         }
      |                         ~
 1365 |                         __assign_str(dstaddr, clp ? clp->cl_hostname : "unknown");
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1366 |                         __entry->stateid_seq =
      |                         ~~~~~~~~~~~~~~~~~~~~~~
 1367 |                                 be32_to_cpu(stateid->seqid);
      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1368 |                         __entry->stateid_hash =
      |                         ~~~~~~~~~~~~~~~~~~~~~~~
 1369 |                                 nfs_stateid_hash(stateid);
      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~
 1370 |                 ),
      |                 ~~
 1371 | 
 1372 |                 TP_printk(
      |                 ~~~~~~~~~~
 1373 |                         "error=%ld (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/trace/stages/stage6_event_callback.h:38:21: note: expanded from macro '__assign_str'
   38 |                 WARN_ON_ONCE(!src != !__data_offsets.dst##_ptr_);       \
      |                               ~~~ ^
include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
include/trace/stages/stage6_event_callback.h:135:33: note: expanded from macro 'TP_fast_assign'
  135 | #define TP_fast_assign(args...) args
      |                                 ^~~~
include/trace/perf.h:51:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
   51 |         { assign; }                                                     \
      |           ^~~~~~
In file included from fs/nfs/nfs4trace.c:13:
In file included from fs/nfs/nfs4trace.h:2559:
In file included from include/trace/define_trace.h:103:
In file included from include/trace/perf.h:75:
fs/nfs/nfs4trace.h:1389:30: error: pointer/integer type mismatch in conditional expression ('char *' and 'int') [-Werror,-Wconditional-type-mismatch]
 1358 |                         if (!IS_ERR_OR_NULL(inode)) {
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1359 |                                 __entry->fileid = NFS_FILEID(inode);
      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1360 |                                 __entry->dev = inode->i_sb->s_dev;
      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1361 |                         } else {
      |                         ~~~~~~~~
 1362 |                                 __entry->fileid = 0;
      |                                 ~~~~~~~~~~~~~~~~~~~~
 1363 |                                 __entry->dev = 0;
      |                                 ~~~~~~~~~~~~~~~~~
 1364 |                         }
      |                         ~
 1365 |                         __assign_str(dstaddr, clp ? clp->cl_hostname : "unknown");
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1366 |                         __entry->stateid_seq =
      |                         ~~~~~~~~~~~~~~~~~~~~~~
 1367 |                                 be32_to_cpu(stateid->seqid);
      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1368 |                         __entry->stateid_hash =
      |                         ~~~~~~~~~~~~~~~~~~~~~~~
 1369 |                                 nfs_stateid_hash(stateid);
      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~
 1370 |                 ),
      |                 ~~
 1371 | 
 1372 |                 TP_printk(
      |                 ~~~~~~~~~~
 1373 |                         "error=%ld (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/trace/stages/stage6_event_callback.h:38:17: note: expanded from macro '__assign_str'
   38 |                 WARN_ON_ONCE(!src != !__data_offsets.dst##_ptr_);       \
      |                               ^~~
include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
include/trace/stages/stage6_event_callback.h:135:33: note: expanded from macro 'TP_fast_assign'
  135 | #define TP_fast_assign(args...) args
      |                                 ^~~~
include/trace/perf.h:51:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
   51 |         { assign; }                                                     \
      |           ^~~~~~
In file included from fs/nfs/nfs4trace.c:13:
In file included from fs/nfs/nfs4trace.h:2559:
In file included from include/trace/define_trace.h:103:
In file included from include/trace/perf.h:75:
fs/nfs/nfs4trace.h:1389:30: error: pointer/integer type mismatch in conditional expression ('char *' and 'int') [-Werror,-Wconditional-type-mismatch]
 1358 |                         if (!IS_ERR_OR_NULL(inode)) {
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1359 |                                 __entry->fileid = NFS_FILEID(inode);
      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1360 |                                 __entry->dev = inode->i_sb->s_dev;
      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1361 |                         } else {
      |                         ~~~~~~~~
 1362 |                                 __entry->fileid = 0;
      |                                 ~~~~~~~~~~~~~~~~~~~~
 1363 |                                 __entry->dev = 0;
      |                                 ~~~~~~~~~~~~~~~~~
 1364 |                         }
      |                         ~
 1365 |                         __assign_str(dstaddr, clp ? clp->cl_hostname : "unknown");
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1366 |                         __entry->stateid_seq =
      |                         ~~~~~~~~~~~~~~~~~~~~~~
 1367 |                                 be32_to_cpu(stateid->seqid);
      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1368 |                         __entry->stateid_hash =
      |                         ~~~~~~~~~~~~~~~~~~~~~~~
 1369 |                                 nfs_stateid_hash(stateid);
      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~
 1370 |                 ),
      |                 ~~
 1371 | 
 1372 |                 TP_printk(
      |                 ~~~~~~~~~~
 1373 |                         "error=%ld (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/trace/stages/stage6_event_callback.h:39:16: note: expanded from macro '__assign_str'
   39 |                 WARN_ON_ONCE(src && strcmp((src), __data_offsets.dst##_ptr_)); \
      |                              ^~~
include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
include/trace/stages/stage6_event_callback.h:135:33: note: expanded from macro 'TP_fast_assign'
  135 | #define TP_fast_assign(args...) args
      |                                 ^~~~
include/trace/perf.h:51:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
   51 |         { assign; }                                                     \
      |           ^~~~~~
16 errors generated.

--XiLEdSMjCWnSCb6R--

