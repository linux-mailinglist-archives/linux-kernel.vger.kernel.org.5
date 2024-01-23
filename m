Return-Path: <linux-kernel+bounces-34614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B2C838349
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00FE31F24723
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E9460EDE;
	Tue, 23 Jan 2024 01:54:11 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8737960DD6;
	Tue, 23 Jan 2024 01:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705974851; cv=none; b=PTkpeJbL2mW4y3WekBbVMwnHWq1YEeChCcWSwHsaeYhSPcWjkCUbg6pWPYWRvXJty3OT1NiOwze2kGLbg3Cg8Hzwlzb6M3fCeuoC0CejbSpChOWtAwjrwCH7y/oDy7KEpiyxfg+hclPjSdGJr0DgnZlDOAFD5OOGFUw/MNPYlYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705974851; c=relaxed/simple;
	bh=nt6Hl62u5AXRkmcTQcS/xesbw7puA81xqOiLHvBdtHM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EYbb8ChhcjUUAN63QHu1K2qwn4tvly+U4WyxylcTEQQ6HgCJsz2j80dWH+KxOlmlYTI5/ADJ31YsCy0MG9UiNbZbOHDht0CHeY1vf12nD+AYwgg6rHO7wHQ4JT72cFhGouJwSWM9nI83KVmkBS7rGBL43Qh9tCtf+TBda8PUXIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3510C433C7;
	Tue, 23 Jan 2024 01:54:09 +0000 (UTC)
Date: Mon, 22 Jan 2024 20:55:39 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: George Guo <dongtai.guo@linux.dev>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Dennis Zhou <dennis@kernel.org>, Tejun
 Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, Andrew Morton
 <akpm@linux-foundation.org>, George Guo <guodongtai@kylinos.cn>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH] percpu: improve percpu_alloc_percpu_fail event trace
Message-ID: <20240122205539.705f5701@gandalf.local.home>
In-Reply-To: <20240123094443.00007b20@linux.dev>
References: <20240122073629.2594271-1-dongtai.guo@linux.dev>
	<20240122105700.05e5ee46@gandalf.local.home>
	<20240123094443.00007b20@linux.dev>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jan 2024 09:44:43 +0800
George Guo <dongtai.guo@linux.dev> wrote:

> There are two reasons of percpu_alloc failed without warnings: 
> 
> 1. do_warn is false
> 2. do_warn is true and warn_limit is reached the limit.

Yes I know the reasons.

> 
> Showing do_warn and warn_limit makes things simple, maybe dont need
> kprobe again.

It's up to the maintainers of that code to decide if it's worth it or not,
but honestly, my opinion it is not.

The trace event in question is to trace that percpu_alloc failed and why.
It's not there to determine why it did not produce a printk message.

-- Steve

