Return-Path: <linux-kernel+bounces-91506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EDE87126B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A8F7B23DE3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D8E1B815;
	Tue,  5 Mar 2024 01:39:32 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6F61B59F;
	Tue,  5 Mar 2024 01:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709602771; cv=none; b=sdIjPARkRmUAyp/YMVddXwTsdHaJKmTWu2uyhQGBZbuejQg773ZgPfxvaE8hmuYRhq12fYmz/mN7lex6uDdUBUqFLoWGP6FZWry9JPRQAhKU/G8mzCGVRhdFKyv/P5WYv2p+mQuiZ14cixoO25uQTRWKhgFGDPps2P2kG7+BC0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709602771; c=relaxed/simple;
	bh=qwpwKk8tlx8nJHIDbw8e1ykeTGkv4/vm5C/QYqIaks0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WlbEm6Yz1VMu8kso1yjC5InADZQ/9mPRpnUOTpU/NFufWr3P4kscfOSL4gulDUCave9Sc3RgmtMmCoXeN1X08QJWsCHrUGcss2E4NPQ5FfQwTdNNOBqcTgdLPLs7CRd8gppKECOfODIUQxwCk6yjrBcngncsV1v4r+oL2sRVuZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4872C433F1;
	Tue,  5 Mar 2024 01:39:30 +0000 (UTC)
Date: Mon, 4 Mar 2024 20:41:19 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>,
 Sachin Sant <sachinp@linux.ibm.com>
Subject: Re: [PATCH] tracing: Have trace_marker writes be just half of
 TRACE_SEQ_SIZE
Message-ID: <20240304204119.7503ab0b@gandalf.local.home>
In-Reply-To: <20240304203516.45b7a551@gandalf.local.home>
References: <20240304192710.4c99677c@gandalf.local.home>
	<469d31a7-f358-4547-bb17-0979b3515924@efficios.com>
	<20240304203516.45b7a551@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Mar 2024 20:35:16 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> > BUILD_BUG_ON(TRACING_MARK_MAX_SIZE + sizeof(meta data stuff...) > TRACE_SEQ_SIZE);  
> 
> That's not the meta size I'm worried about. The sizeof(meta data) is the
> raw event binary data, which is not related to the size of the event output.
> 
>  # cd /sys/kernel/tracing
>  # echo hello > trace_marker
>  # cat trace
> [..]
>            <...>-999     [001] .....  2296.140373: tracing_mark_write: hello
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>    This is the meta data that is added to trace_seq

That said, the meta data is most likely not going to be more than 128 bytes
(it shouldn't be more than 80).

I could do as you suggest and create a separate TRACE_MARKER_SIZE and just
make sure that it's less than TRACE_SEQ_BUFFER_SIZE (as that's the size of
the content) by 128 bytes.

/* Added meta data should not be more than 128 bytes */
BUILD_BUG_ON((TRACE_MARKER_MAX_SIZE + 128) > TRACE_SEQ_BUFFER_SIZE);

-- Steve

