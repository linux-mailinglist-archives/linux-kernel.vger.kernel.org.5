Return-Path: <linux-kernel+bounces-101540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D46287A872
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 878641C20DA2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7434845C16;
	Wed, 13 Mar 2024 13:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TpnFdPPB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA9645BF9;
	Wed, 13 Mar 2024 13:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710336524; cv=none; b=Qoa4wEceRqL/8/9FrPMRECUfV7sWypiiGHNXi6YFHfjehIlVU8FQGllD+gm/EzfXhZ7hCiWRwuc8Rai/Q1kzwwkRfSB0HNHmIgfkZ7UjrFEDw6kFdvgsvj+c8lsjrHULfqKWqveDNm0auen4+RfEXo+WfkGeD+C6GqCAsaJkQno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710336524; c=relaxed/simple;
	bh=nxOroR4b2rIUnv+V/UG5lc0jC6pDP1cKjLwLqOz+xw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AtRooB1ERS00008mCLxjI97D42P7fH2easJr87iIYvPLniry+PDP7gW53TH9mOJiKmIhCrhOrsKHlBDH6qzaxSIqQKznXNNWk61By4YS+diIscde4+4+MnBbWL559DmK34/4/Ivr2vxietg0k83PU/I3s/stq8Rqrtn8pFiqaWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TpnFdPPB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE02C433C7;
	Wed, 13 Mar 2024 13:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710336524;
	bh=nxOroR4b2rIUnv+V/UG5lc0jC6pDP1cKjLwLqOz+xw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TpnFdPPBkSHLmGC5KJOHt1TJpVHGJpEea8ClPaOqKVIyFvtdhjJ0EWPHeRAhiKvY1
	 QZ7VYgdxAnJNIu4y8E184jdMnhX/LRfZYwS70aHgS1ycSXEI7GQ/5t2VfcerG0LqSX
	 CceWrXXGev/8+Swu/K1Zsz2IJlBI5tVE/hdiItrknDSWg8qdKzPZiS/SEen7afHzn1
	 aheZRPExhuNQ9iKhKqwB5DmBckF0Igb+mDQ5ikfOmHIfQEpG0LrZaTYjxsPjG4xYF3
	 dg5TW+qViVGgU1SYlEzn1hbdvtSCvbUYGZB/c6cgSa4PqtPYKJIc7dB6XmvEYD3cDV
	 EQ6u4II/Um+3Q==
Date: Wed, 13 Mar 2024 10:28:41 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>, Marco Elver <elver@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 0/4] perf: Make SIGTRAP and __perf_pending_irq() work
 on RT.
Message-ID: <ZfGqCWzyVzyGQrAQ@x1>
References: <20240312180814.3373778-1-bigeasy@linutronix.de>
 <ZfDMTlTH2SdwlB9M@x1>
 <20240313081303.DClwQrvb@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240313081303.DClwQrvb@linutronix.de>

On Wed, Mar 13, 2024 at 09:13:03AM +0100, Sebastian Andrzej Siewior wrote:
> On 2024-03-12 18:42:38 [-0300], Arnaldo Carvalho de Melo wrote:
> …
> > But:
> > 
> > [acme@nine ~]$ pidof exec_child
> > 24273 24271 24270 24269 24268 24267 24266 24265 24264 24263 24262 24261 24260 24259 
> …
> 
> > [root@nine ~]# cat /proc/24263/stack
> > [<0>] irqentry_exit_to_user_mode+0x1c9/0x1e0
> > [<0>] asm_sysvec_apic_timer_interrupt+0x16/0x20
> > [root@nine ~]#
> …
> > [acme@nine ~]$ ps ax|grep exec_child| wc -l
> > 504
> > [acme@nine ~]$ ps ax|grep exec_child| tail
> >   24264 pts/0    R      0:04 exec_child
> >   24265 pts/0    R      0:04 exec_child
> >   24266 pts/0    R      0:04 exec_child
> >   24267 pts/0    R      0:04 exec_child
> >   24268 pts/0    R      0:04 exec_child
> >   24269 pts/0    R      0:04 exec_child
> >   24270 pts/0    R      0:04 exec_child
> >   24271 pts/0    R      0:04 exec_child
> >   24273 pts/0    R      0:04 exec_child
> >   26704 pts/1    S+     0:00 grep --color=auto exec_child
> > [acme@nine ~]$
> > 
> > All in 'R' state.
> > 
> > [root@nine ~]# killall exec_child
> > exec_child: no process found
> > [root@nine ~]# ps ax | grep exec_child | head -5
> >   22964 pts/0    R      0:06 exec_child
> >   23046 pts/0    R      0:05 exec_child
> >   23128 pts/0    R      0:05 exec_child
> >   23129 pts/0    R      0:05 exec_child
> >   23181 pts/0    R      0:05 exec_child
> > [root@nine ~]# kill 22964 23046 23128 23129 23181
> > [root@nine ~]# ps ax | grep exec_child | head -5
> >   23182 pts/0    R      0:06 exec_child
> >   23196 pts/0    R      0:06 exec_child
> >   23197 pts/0    R      0:06 exec_child
> >   23210 pts/0    R      0:06 exec_child
> >   23213 pts/0    R      0:06 exec_child
> > [root@nine ~]#
 
> You can't kill them?

I can, they remain in R state and I can kill them with 'kill `pidof exec_child`'
 
> > at the end they disappeared, on this last run.

> > But if I do a 'killall remove_on_exec' and stop that loop (control+C/Z)
> > we get all those exec_child running a seemingly eternal loop:
> 
> Is this new or was it there? Is this VM or bare metal?

bare metal.
 
> One part I don't get: did you let it run or did you kill it?

If I let them run they will finish and exit, no exec_child remains.

If I instead try to stop the loop that goes on forking the 100 of them,
then the exec_child remain spinning.

> `exec_child' spins until a signal is received or the parent kills it. So


> it shouldn't remain there for ever. And my guess, that it is in spinning
> in userland and not in kernel.

Checking that now, the stack is the one I posted:

> > [root@nine ~]# cat /proc/24263/stack
> > [<0>] irqentry_exit_to_user_mode+0x1c9/0x1e0
> > [<0>] asm_sysvec_apic_timer_interrupt+0x16/0x20
> > [root@nine ~]#

> I tried it on bare metal and VM and couldn't reproduce this.

All my tests are in bare metal.

- Arnaldo

