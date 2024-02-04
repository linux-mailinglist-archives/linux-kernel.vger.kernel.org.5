Return-Path: <linux-kernel+bounces-51331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6D88489E0
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 01:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 138821F23302
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 00:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6621CEBE;
	Sun,  4 Feb 2024 00:33:54 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C5F629;
	Sun,  4 Feb 2024 00:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707006834; cv=none; b=h9WG+tw5l6cLXfN0RWHjs9PvOyitkq13YexmKBSFeRG8CD5YDKcluYTdLF/WCEJZNpx9EC0uyGduu2w2zq1SjYAoUoWHYvHgWhiA8e+kIkRKvztLTGZEzV8QTmW4+rpXQ2T6ZzBv2cXDNkRNW/DBQxyjTYW1PQNj6j8HvYBlOYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707006834; c=relaxed/simple;
	bh=NbRpMSxyKBKo0ONrZ8VpCh0Z4bIHDeO8UkFg9Z1W+lc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G61dLPo3P+Y7675YIHDNT6bQU+4GXqP0Ag2ha9zRhs/1fzs7hdMqHGyUJuL2kyIfzTG8Iro73zUFDf9uKktSEjN70GFw7HQiweOz1fIKtXnJ39Pn8JIn4nyDpEDjK0vnvwz4uxRJQ5VSQ4/XvmWsWBQZyXxjejtB5lm97newwYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB74C433C7;
	Sun,  4 Feb 2024 00:33:52 +0000 (UTC)
Date: Sat, 3 Feb 2024 19:33:51 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 kernel-team@android.com
Subject: Re: [PATCH v13 2/6] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <20240203193351.76bbdda9@rorschach.local.home>
In-Reply-To: <20240129142802.2145305-3-vdonnefort@google.com>
References: <20240129142802.2145305-1-vdonnefort@google.com>
	<20240129142802.2145305-3-vdonnefort@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jan 2024 14:27:58 +0000
Vincent Donnefort <vdonnefort@google.com> wrote:

> --- /dev/null
> +++ b/include/uapi/linux/trace_mmap.h
> @@ -0,0 +1,43 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _TRACE_MMAP_H_
> +#define _TRACE_MMAP_H_
> +
> +#include <linux/types.h>
> +
> +/**
> + * struct trace_buffer_meta - Ring-buffer Meta-page description
> + * @meta_page_size:	Size of this meta-page.
> + * @meta_struct_len:	Size of this structure.
> + * @subbuf_size:	Size of each subbuf, including the header.

That is "the header"?

> + * @nr_subbufs:		Number of subbfs in the ring-buffer.
> + * @reader.lost_events:	Number of events lost at the time of the reader swap.
> + * @reader.id:		subbuf ID of the current reader. From 0 to @nr_subbufs - 1
> + * @reader.read:	Number of bytes read on the reader subbuf.

Note, flags needs a comment.

> + * @entries:		Number of entries in the ring-buffer.
> + * @overrun:		Number of entries lost in the ring-buffer.
> + * @read:		Number of entries that have been read.

So does the two Reserved words, otherwise I'm going to start getting
error reports about sparse warnings that check kerneldoc comments
against their content. Every field needs to be represented in the
kerneldoc comment.

-- Steve


> + */
> +struct trace_buffer_meta {
> +	__u32		meta_page_size;
> +	__u32		meta_struct_len;
> +
> +	__u32		subbuf_size;
> +	__u32		nr_subbufs;
> +
> +	struct {
> +		__u64	lost_events;
> +		__u32	id;
> +		__u32	read;
> +	} reader;
> +
> +	__u64	flags;
> +
> +	__u64	entries;
> +	__u64	overrun;
> +	__u64	read;
> +
> +	__u64	Reserved1;
> +	__u64	Reserved2;
> +};
> +
> +#endif /* _TRACE_MMAP_H_ */

