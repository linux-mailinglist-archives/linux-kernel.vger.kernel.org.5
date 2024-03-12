Return-Path: <linux-kernel+bounces-100468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B748797E4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79C781F22E05
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F4C7CF01;
	Tue, 12 Mar 2024 15:45:57 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF617C6D6;
	Tue, 12 Mar 2024 15:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710258357; cv=none; b=dhBxhzmkD/wNaPrmMeH+6OYk4ttkwL5/2ScFBjS5Rj1e8SSeggxqYK2fciXmF8MnZZ8ZdEMeXDWrQmYVcXnLd9hT40Lf1hb6AJUYEF8MF3CXQ+nB6Sk5AG1FAbpfgBIzHH/fSxJdPQoA+UXiHAuglVfavH3kDFWcvruA+wdA7pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710258357; c=relaxed/simple;
	bh=YZABLRxVxCxF9aGGHVyLi1AfKTplDrrmVAnLthpELy4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UdiXV5Ooacn6Uk7ZALo5NRkiRZ+QaN24y4GgS27oL5XPs5EWMJXJDORd+8YNxFumXI5f7YepNa7kmTH++v7kTV6xNoCrwE8nIYwmluuqkzgx2ofkmlKIfsaDfPJBfoitykVXxMtfTx2o25yQVlmcuYUyZHK9qrG0GKxaSdPbMCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 060BEC433F1;
	Tue, 12 Mar 2024 15:45:55 +0000 (UTC)
Date: Tue, 12 Mar 2024 11:48:01 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 2/2] ring-buffer: Reuse rb_watermark_hit() for the
 poll logic
Message-ID: <20240312114801.4b12c1fa@gandalf.local.home>
In-Reply-To: <20240313003842.207e83107633bef0c4a798b4@kernel.org>
References: <20240312131919.314231457@goodmis.org>
	<20240312131952.802267543@goodmis.org>
	<20240313003842.207e83107633bef0c4a798b4@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Mar 2024 00:38:42 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Tue, 12 Mar 2024 09:19:21 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > 
> > The check for knowing if the poll should wait or not is basically the
> > exact same logic as rb_watermark_hit(). The only difference is that
> > rb_watermark_hit() also handles the !full case. But for the full case, the
> > logic is the same. Just call that instead of duplicating the code in
> > ring_buffer_poll_wait().
> >   
> 
> This changes a bit (e.g. adding pagebusy check) but basically that should
> be there. And new version appears to be consistent between ring_buffer_wait()
> and ring_buffer_poll_wait(). So looks good to me.

The pagebusy check is an optimization. As if it is true, it means the
writer is still on the reader_page and there's no sub-buffers available. It
just prevents having to do the calculation of the buffer-percentage filled
(what's done by the full_hit() logic).

> 
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>

Thanks!

-- Steve

