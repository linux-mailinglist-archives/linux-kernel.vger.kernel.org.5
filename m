Return-Path: <linux-kernel+bounces-103803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE90887C4B8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 22:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0D00B20D34
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 21:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC124768E4;
	Thu, 14 Mar 2024 21:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ME+Sb6BD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFDA5C61C;
	Thu, 14 Mar 2024 21:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710451362; cv=none; b=dSrzsfBSq/eb2tufmaMpBZGXuv11porFs7rTeJ8ecHr4Q9smbVJsR5mRwKWldaIAmw3nJtKjPEJjvqnUU7TVNZGTZwFoU7PFw1AOW0UTHOkClowKOlSrHVa2OE7Ww+y6wsvoRZDrOl6e8IYHsGabb6l0sdo9DOPmsv2V6owOej0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710451362; c=relaxed/simple;
	bh=PrLMFw2UxGleWAKNhTIQMqgQrAV0L+3Cp22tX7aB0hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u3TxehETkkln9f4jM4+qWDBaxXzojSLvW3/m3SLgXGWI8idwHxYRa1RLUr7mcOBsthPPq0pu1CJwhb2hqaycF9x/sXJvjGQNQEylfIbEpq8RMk8yzjW++mSNiAFsSeqyxKBRw0qBCi7nVT9nLEfpPySNte7UXSUmPvJZddVSEy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ME+Sb6BD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB6FDC433F1;
	Thu, 14 Mar 2024 21:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710451361;
	bh=PrLMFw2UxGleWAKNhTIQMqgQrAV0L+3Cp22tX7aB0hg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ME+Sb6BDJu10rxvJXW6AUg2TcwxVgYix6XDzJ4Roy/sPkqq/8HYVZpyskCfuDulPR
	 nVndx/6RdRL8HnHw9vd+wJ+lz3wkIkQm+vPhFz7i2e7YgNZ49DjLJ7fZn6xyaARXxR
	 eYaKDpPl3qFG0pZ5EKw5wx2PNnqXC8RGiJiJks3QPtkPsAnwZMrj7KLHSUdkWUc/MT
	 jfaQIfnweLl1YZ4AlKZVDjwvuxViSUtyVUmT46MdibKgXYaGgN6PXNmwqEqUOcMBAC
	 vJCLiladNTyBJSRIzk+sr6FlYxFzBn8TDWfevT7Iy4b87hyVl6giycA0LcFOsBTDcw
	 t89L10ZLKPZcg==
Date: Thu, 14 Mar 2024 18:22:38 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Marco Elver <elver@google.com>, Vince Weaver <vincent.weaver@maine.edu>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 0/4] perf: Make SIGTRAP and __perf_pending_irq() work
 on RT.
Message-ID: <ZfNqnjdR-0YEsSnb@x1>
References: <20240312180814.3373778-1-bigeasy@linutronix.de>
 <CANpmjNMYGa46pRQUOfzTa_FRvftOGqg+UDeD_B-tbZgYw-MWww@mail.gmail.com>
 <ZfHE9Ev5T3Lq7o34@x1>
 <ZfHtBB5_-3RByE8p@x1>
 <ZfHw3J5PY6qy4mXn@x1>
 <ZfIIqcmRlrxwUFTn@x1>
 <ZfIJIfqeI9tWnnS5@x1>
 <20240314091033.woaK8h83@linutronix.de>
 <ZfMK_yTzxTQCMGZ1@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZfMK_yTzxTQCMGZ1@x1>

On Thu, Mar 14, 2024 at 11:34:39AM -0300, Arnaldo Carvalho de Melo wrote:
> On Thu, Mar 14, 2024 at 10:10:33AM +0100, Sebastian Andrzej Siewior wrote:
> > On 2024-03-13 17:14:25 [-0300], Arnaldo Carvalho de Melo wrote:
> > > > tldr; No dmesg activity, no kernel splats, most tests passed, nothing
> > > > noticeable when running with/without the patch with Vince's regression
> > > > tests. So:

> > > > Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > > Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>

> > > Too quick, now I'm testing it on top of torvalds/master, no PREEMPT_RT.

> > Just to be clear: You revert your Tested-by because now you test this on
> > torvalds/master but not because you reported a regression which I
> > missed.

> You got it right. No regressions, the code is good, I just need to test
> it a bit further, with torvalds/master, without PREEMPT_RT.

Tests performed, no regressions detected, same behaviour when killing
the remove_on_exec selftests midway:

[acme@nine perf_events]$ perf annotate --stdio2 exec_child | tail
              mov    $0x1,%edi
            → callq  _exit@plt
        b5:   nop           
100.00  b6:   mov    signal_count,%eax
              test   %eax,%eax
            ↑ je     b6     
              nop           
              nop           
              leaveq        
            ← retq          
[acme@nine perf_events]$ pidof exec_child 
28256 28249 28241 28240 28239 28236 28228 28226 28224 28223 28219 28215 28208 28207 28206 28205 28200 28188 28187 28186 28185 28169 28168 28167 28166 28155 28154 28153 28152 28140 28139 28138 28137 28124 28123 28122 28121 28111 28110 28109 28108 28094 28093 28092 28091 28080 28079 28078 28077 28064 28062 28061 28060 28048 28047 28046 28045 28030 28029 28028 28027 28012 28011 28010 28009 27998 27996 27994 27993 27982 27981 27979 27978 27966 27965 27962 27961 27952 27951 27949 27948 27934 27933 27932 27931 27920 27919 27918 27917 27906 27905 27903 27902 27888 27885 27883 27882
[acme@nine perf_events]$

[acme@nine linux]$ uname -a
Linux nine 6.8.0-rc7.sebastian-rt6+ #2 SMP PREEMPT_RT Tue Mar 12 18:01:31 -03 2024 x86_64 x86_64 x86_64 GNU/Linux
[acme@nine linux]$ perf probe -L perf_pending_disable
<perf_pending_disable@/home/acme/git/linux/kernel/events/core.c:0>
      0  static void perf_pending_disable(struct irq_work *entry)
         {
      2         struct perf_event *event = container_of(entry, struct perf_event, pending_disable_irq);
                int rctx;
         
                /*
                 * If we 'fail' here, that's OK, it means recursion is already disabled
                 * and we won't recurse 'further'.
                 */
                rctx = perf_swevent_get_recursion_context();
     10         __perf_pending_disable(event);
     11         if (rctx >= 0)
     12                 perf_swevent_put_recursion_context(rctx);
         }
         
         static void perf_pending_irq(struct irq_work *entry)

[acme@nine linux]$

So I keep my:

Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo

