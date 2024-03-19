Return-Path: <linux-kernel+bounces-108164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D4C8806F3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 22:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83AED1F2298A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 21:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376D05A11C;
	Tue, 19 Mar 2024 21:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="idKWMn/e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D5657880
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 21:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710885439; cv=none; b=Ca/uLwUOzyGTtpg56AbFXV8R2SE1JqpMQ7GyeTOhhSJ1nqadMlzAqY1G3U9iQXARR7Up37wSir2nJi5cM08sapx+JunnI07aEwimXRUIfuJsrkEL56LRXOjEjpiRyznCSo1nd4Hu0y84x5AbLarYBzJHKBS6Km9b5V4800gNUnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710885439; c=relaxed/simple;
	bh=A8FNOyGnsGiesx6nzHXmBTBc6TfNILcr784GdYp8ZZ0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GTvdp8kF76mO+IPWQT4Tu9x00vpeLKBnf9jU1jAN9lUGoBDUSsr3zmludx+x5Pob0A2g6iBsT2xQz+2K7zX2PRQ+HWttSGDXfY19RH+XlyZg9SIlvm6gzjmPy2qLzslZuJ3/UkoHPV3tBQ5ZsLnZQVktnjKV63gkC4PSatOmjnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=idKWMn/e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97EC9C433F1;
	Tue, 19 Mar 2024 21:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1710885439;
	bh=A8FNOyGnsGiesx6nzHXmBTBc6TfNILcr784GdYp8ZZ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=idKWMn/eP1B7F1JXGEqwQszSFmL6pNAXt9Zn6QmME3QN1UoRYmGcUzzrHKYQ0us7R
	 mVIaug2Pc0KwIKXRHHZftj1Oe6H8pxLywU5gN5Bbj5B0ZI/0zuBrlnik1MBoPcZW2P
	 6Kl7fnyqhqKD+/fB/MrOC/dRPy1Nfq3IGckVUXVY=
Date: Tue, 19 Mar 2024 14:57:18 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: wenyang.linux@foxmail.com
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>,
 Oleg Nesterov <oleg@redhat.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Mel Gorman
 <mgorman@techsingularity.net>, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] exit: move trace_sched_process_exit earlier in
 do_exit()
Message-Id: <20240319145718.2bfb0d526ff441c8b37eab09@linux-foundation.org>
In-Reply-To: <tencent_277EBFCF545587D4FD41EF932AE972CC6708@qq.com>
References: <tencent_277EBFCF545587D4FD41EF932AE972CC6708@qq.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 10 Mar 2024 13:25:29 +0800 wenyang.linux@foxmail.com wrote:

> From: Wen Yang <wenyang.linux@foxmail.com>
> 
> Currently coredump_task_exit() takes some time to wait for the generation
> of the dump file. But if the user-space wants to receive a notification
> as soon as possible it maybe inconvenient.

If userspace is awaiting this notification to say "it's now OK to read
the dump file" then it could break things?

> Move trace_sched_process_exit() earlier in do_exit().
> This way a user-space monitor could detect the exits and
> potentially make some preparations in advance.
> 
> Oleg initially proposed this suggestion, and Steven further provided some
> detailed suggestions, and Mathieu carefully checked the historical code
> and said:
> : I've checked with Matthew Khouzam (maintainer of Trace Compass)
> : which care about this tracepoint, and we have not identified any
> : significant impact of moving it on its model of the scheduler, other
> : than slightly changing its timing.
> : I've also checked quickly in lttng-analyses and have not found
> : any code that care about its specific placement.
> : So I would say go ahead and move it earlier in do_exit(), it's
> : fine by me.

I'm not seeing a clear need for this change.  "maybe inconveniant" is
quite thin.  Please fully describe what motivated you to work on this?


