Return-Path: <linux-kernel+bounces-73214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA41285BF6D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A0F5B23512
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7B56A03B;
	Tue, 20 Feb 2024 15:07:13 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6478773169
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 15:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708441633; cv=none; b=GOgE78rqxPX5xw+lpFFRUONhhFS+enhgAc/JcnezXFxdtqKxjXHwIDUCfP3DIHBSMcEuihvjdnQEHRbrWf1zElaggJdpo3wl8NzVtODKziX+9UR3Mnc4671RY/GZIFuFIx5Ql3a6Mta5USMtg/iQh1AtQF4FshPXsRz5Hm9Zcu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708441633; c=relaxed/simple;
	bh=1YOAXq4n3TKhseMTUr23nV7sFBO6wOP38L/DOsPMQvY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=imGPoo5HTpjKygc4Gc5gk5Y0jIpZBwB7sJLu7boPDRapv8HpDPRULgsxQm9Z9Bb7auBxA7f87BiOq1hSRmvwF1EtXp3oqxqbjPZjcQhVfdiR8B6br+BueOC1isWsmARk4OAJ1PG5Fi+4ixiOo3V1neeRglt3CZ8URgLHd0oZFXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D190C433C7;
	Tue, 20 Feb 2024 15:07:11 +0000 (UTC)
Date: Tue, 20 Feb 2024 10:08:57 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Oleg Nesterov <oleg@redhat.com>, wenyang.linux@foxmail.com, Masami
 Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@kernel.org>, Mel Gorman
 <mgorman@techsingularity.net>, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coredump debugging: add a tracepoint to report the
 coredumping
Message-ID: <20240220100857.3f450059@gandalf.local.home>
In-Reply-To: <776b842b-b19f-44bf-bc34-ac756fce7466@efficios.com>
References: <tencent_5CD40341EC9384E9B7CC127EA5CF2655B408@qq.com>
	<20240217104924.GB10393@redhat.com>
	<20240219112926.77ac16f8@gandalf.local.home>
	<20240219170038.GA710@redhat.com>
	<20240219122825.31579a1e@gandalf.local.home>
	<776b842b-b19f-44bf-bc34-ac756fce7466@efficios.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Feb 2024 13:01:16 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> No ? Those hook on sched_process_free, which is the actual point where the
> task is freed (AFAIR after it's been a zombie and then waited for by another
> task).

Bah, you're correct. It *used to* be attached to sched_process_exit, and
the function callback still has that name. It was commit afcab63665742
("tracing: Use trace_sched_process_free() instead of exit() for pid
tracing") that changed it.
> 
> AFAIU, "sched_process_exit" is issued close to the point where the task exits
> (it should not go back to userspace after that). "sched_process_free" is done
> when the task is really being removed.
> 
> Between "sched_process_exit" and "sched_process_free", the task can still be
> observed by a trace analysis looking at sched and signal events: it's a zombie at
> that stage.

Right, thanks for reminding me what I did ;-) I guess I'm starting to get to "that age".

-- Steve

