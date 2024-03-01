Return-Path: <linux-kernel+bounces-89087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D8886EA52
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB6E91F25358
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342453C492;
	Fri,  1 Mar 2024 20:27:54 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFBA3DB91;
	Fri,  1 Mar 2024 20:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709324873; cv=none; b=dvycv67w950PO3dBbvbxi8bbVpSJiafwGjIx/3QL+u8My3tQ3SQojP7pKJVNB7oZpzU65YAF51wZjppdbeEfbcf6Zmk0HnF2ntrrQ7WiZ+HVqy5uYcXkeRO+dmA+DMLgUCZx76ZevwZ+mB7crySJU6yPWycjgaP7rl/StjpHq1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709324873; c=relaxed/simple;
	bh=8NqchkgmgZ+i8ZSZn6TysYQ/007CbNbJX+J+AJF8q8E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MSUrg1BQdsrcRCgIWinOf1VbCuFl2lAVbSJjktrBExwxo/xzyA1PinXxf7KAJCIbYd0ZoEv22oIF1HKtZcK0KcGtowZ36pqFFJGHXWoQF1ZFn5nZNBPD8QVRU+cBg85Wl7xe30juXrS0s1KQS2ihfj882PW5qz+4cS0jWai2rto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9009CC433F1;
	Fri,  1 Mar 2024 20:27:52 +0000 (UTC)
Date: Fri, 1 Mar 2024 15:30:01 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ankur Arora
 <ankur.a.arora@oracle.com>, Thomas Gleixner <tglx@linutronix.de>,
 kernel-team@meta.com
Subject: Re: [PATCH RFC ftrace] Chose RCU Tasks based on TASKS_RCU rather
 than PREEMPTION
Message-ID: <20240301153001.0d544f9c@gandalf.local.home>
In-Reply-To: <2835d5ea-0396-49f6-88fb-be49cb998cc5@paulmck-laptop>
References: <f6507b10-5bb5-4407-bd4d-c547193a5a28@paulmck-laptop>
	<20240228152236.7a4c9eec@gandalf.local.home>
	<b5acdc28-0441-49ca-9e8d-50d6ac40c395@paulmck-laptop>
	<2835d5ea-0396-49f6-88fb-be49cb998cc5@paulmck-laptop>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 1 Mar 2024 12:25:10 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> > That would work for me.  If there are no objections, I will make this
> > change.  
> 
> But I did check the latency of synchronize_rcu_tasks_rude() (about 100ms)
> and synchronize_rcu() (about 20ms).  This is on a 80-hardware-thread
> x86 system that is being flooded with calls to one or the other of
> these two functions, but is otherwise idle.  So adding that unnecessary
> synchronize_rcu() adds about 20% to that synchronization delay.
> 
> Which might still be OK, but...  In the immortal words of MS-DOS,
> "Are you sure?".  ;-)

It's just safe to keep it. It's definitely not a fast path.

-- Steve

