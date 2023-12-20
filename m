Return-Path: <linux-kernel+bounces-7057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D4B81A115
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 253B61F22B74
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4159138F8E;
	Wed, 20 Dec 2023 14:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omMPistz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9025438DF5;
	Wed, 20 Dec 2023 14:26:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF772C433C7;
	Wed, 20 Dec 2023 14:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703082384;
	bh=xpBEBzomf3p2iDt4EErdfgJq0jpQsA2bWX5QENChMOA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=omMPistz948xTI/ZI7GZCM7Fl61sTjERHai2wv3De1kUu4LPMpy6Wnw35iGFw5gbr
	 3ZP3AaScuyuKKmf15/7w1FOpCnX4ntseWWxOL9dDCvGTK++YavZt0LEEo2bjZZrDCl
	 z4PfkJmOqMdfUA7gzDhsncktMhR54UM3YQqm8PuxoR9+i3hhPYJHzXzhBaliFghV9x
	 yhOetlL4yWN4XL9yFG0M9BSvuqDjCk/gZj2x5qgyRLp+Wht9NyeTt7L5Umk2JavCbm
	 TUxokcrwh0Vm4kn2NfdAOuJ0UvkbKwpMcUIk3Hk0AW2yrPpFhlAIIOD6tydjE+xaIt
	 fAAbES7ShHGZw==
Date: Wed, 20 Dec 2023 23:26:19 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
 Vincent Donnefort <vdonnefort@google.com>, Kent Overstreet
 <kent.overstreet@gmail.com>
Subject: Re: [PATCH v5 03/15] ring-buffer: Add interface for configuring
 trace sub buffer size
Message-Id: <20231220232619.67f0b175578d14f9341fb30c@kernel.org>
In-Reply-To: <20231219185628.298324722@goodmis.org>
References: <20231219185414.474197117@goodmis.org>
	<20231219185628.298324722@goodmis.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Dec 2023 13:54:17 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> +/**
> + * ring_buffer_subbuf_order_set - set the size of ring buffer sub page.
> + * @buffer: The ring_buffer to set the new page size.
> + * @order: Order of the system pages in one sub buffer page
> + *
> + * By default, one ring buffer pages equals to one system page. This API can be
> + * used to set new size of the ring buffer page. The size must be order of
> + * system page size, that's why the input parameter @order is the order of
> + * system pages that are allocated for one ring buffer page:
> + *  0 - 1 system page
> + *  1 - 2 system pages
> + *  3 - 4 system pages
> + *  ...

Don't we have the max order of the pages?

> + *
> + * Returns 0 on success or < 0 in case of an error.
> + */
> +int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
> +{
> +	int psize;
> +
> +	if (!buffer || order < 0)
> +		return -EINVAL;
> +
> +	if (buffer->subbuf_order == order)
> +		return 0;
> +
> +	psize = (1 << order) * PAGE_SIZE;
> +	if (psize <= BUF_PAGE_HDR_SIZE)
> +		return -EINVAL;
> +
> +	buffer->subbuf_order = order;
> +	buffer->subbuf_size = psize - BUF_PAGE_HDR_SIZE;
> +
> +	/* Todo: reset the buffer with the new page size */
> +

I just wonder why there is no reallocate the sub buffers here.
Is it OK to change the sub buffer page size and order while
using the ring buffer?

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

