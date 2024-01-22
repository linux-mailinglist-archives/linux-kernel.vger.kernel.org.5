Return-Path: <linux-kernel+bounces-34263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E65758376A7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 23:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E515289431
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C1D14A9C;
	Mon, 22 Jan 2024 22:55:34 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A236312E69;
	Mon, 22 Jan 2024 22:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705964133; cv=none; b=D0LeIjjEg8u5h3fygbq9Wq+dZh6LL1lyeV+z1PJlaAh4p+EGA/RX95bCom5Qwsb+XjOaVUu+LQkErinZ/JQi/7ZTyJkYo+1AMzzw/v6Gw34POgvKyuvh74pfsnwl4vKo+N8TYHXMcTAGsJteW8ekuorNUw1Y5Nd7lxHMIxQ2GgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705964133; c=relaxed/simple;
	bh=73P2VSJYjI/fLQ8ac8A9F5BDPZV8lueMjh4EPCOWcRo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FOaLuhumV2YK6Aui2KO1ClDGoKz2z0ZlgiaUk/UxDUFhU36l4GIgjJW6hsgWECUYXNNHXkVkq/L82yxjJzDZW88sJG2Epv1OHlSqKAjBNzhNHook+XwMn3gtGyMrHfXI+g1ZScSgDzVN+faFQbbmRnDnpyXSbio7Semcs9Z+6U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF89CC433C7;
	Mon, 22 Jan 2024 22:55:32 +0000 (UTC)
Date: Mon, 22 Jan 2024 17:57:01 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: add trace_seq_reset function
Message-ID: <20240122175701.3e525404@gandalf.local.home>
In-Reply-To: <ny2sl7ke3mktdimdcfikmwel57fuoudezq6k6yamwqqitt6jqz@vpxgz473xrva>
References: <20240122182225.69061-2-ricardo@marliere.net>
	<20240122171024.4a434c73@gandalf.local.home>
	<ny2sl7ke3mktdimdcfikmwel57fuoudezq6k6yamwqqitt6jqz@vpxgz473xrva>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jan 2024 19:45:41 -0300
"Ricardo B. Marliere" <ricardo@marliere.net> wrote:

> > Perhaps we need a:
> > 
> > 	if (WARN_ON_ONCE(!s->seq.size))
> > 		seq_buf_init(&s->seq, s->buffer, TRACE_SEQ_BUFFER_SIZE);
> > 	else
> > 		seq_buf_clear(&s->seq);
> > 
> > 
> > in the trace_seq_reset() to catch any place that doesn't have it
> > initialized yet.  
> 
> But that would be temporary, right? Kind of a "trace_seq_init_or_reset".
> If that's the case it would be best to simply work out all the places
> instead. Would the current tests [1] cover everything or should
> something else be made to make sure no place was missing from the patch?

No it would be permanent. And no, it is *not* a "trace_seq_init_or_reset".
That WARN_ON_ONCE() means this should never happen, but if it does, the
if () statement keeps it from crashing.

If we later make it dynamic, where there is no s->buffer, that would then
change to:

	if (WARN_ON_ONCE(!s->seq.size))
		seq_buf_init(&s->seq, NULL, 0);
	else
		seq_buf_clear(&s->seq);

Where the trace_seq is basically disabled from that point on.

I would try to fix everything, but this will find those places you missed. ;-)

The kernel is like this, because it's not like any other application. If an
application crashes, you may get annoyed, and just restart it. If the
kernel crashes, you can easily lose data and you have to reboot your
machine. Thus, we treat things that could cause harm much more carefully.

We do not want to crash the kernel just because we missed a location that
did not initialize trace_seq. That's why this would be a permanent change.

-- Steve

