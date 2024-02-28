Return-Path: <linux-kernel+bounces-85204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B387186B23C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 546151F260FF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F4915B114;
	Wed, 28 Feb 2024 14:45:01 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D44112E1DD;
	Wed, 28 Feb 2024 14:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709131501; cv=none; b=BUla82nyXzbb9sUBjfDnqYk8rnRLh87bBGommDEtIsoBeBtYqoyW1doHwd4eVFt8u4v40Zc7OGktsUnQgPhR1moHRUsU7USE5RQ+f6I3WF70Dx8jEDgq9Xo+X4FujF6Tv3i9x6ojaQ4CTm5okpDqZye23xOSkJpMyxuCggVF5ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709131501; c=relaxed/simple;
	bh=6mLpCvN3tUZqYmSTfdBCQXOuAi1GkNzVxWE3hU2gaoU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AUCX58J//+1FyJOnYVOSizF5cW6rQ0x4L1M0Cf7INLEaGtBCoG4hf0LNePuUDnasaf7wBtB/1e0FaZg2F6rQy7h3An2z6cKBhbReH+McFzj0QlGzlrzW4aoAqWZOMlLNVw+7GM7dFD9ZcyUHFjZibRwL0C5+NvhlB0K4dZtkthA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8FEC433C7;
	Wed, 28 Feb 2024 14:44:59 +0000 (UTC)
Date: Wed, 28 Feb 2024 09:47:03 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Richard Chang <richardycc@google.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 akpm@linux-foundation.org, liumartin@google.com, surenb@google.com,
 minchan@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] mm: add alloc_contig_migrate_range allocation
 statistics
Message-ID: <20240228094703.0aeb5ae5@gandalf.local.home>
In-Reply-To: <20240228051127.2859472-1-richardycc@google.com>
References: <20240226120728.3f495fa7@gandalf.local.home>
	<20240228051127.2859472-1-richardycc@google.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Feb 2024 05:11:17 +0000
Richard Chang <richardycc@google.com> wrote:

> alloc_contig_migrate_range has every information to be able to
> understand big contiguous allocation latency. For example, how many
> pages are migrated, how many times they were needed to unmap from
> page tables.
> 
> This patch adds the trace event to collect the allocation statistics.
> In the field, it was quite useful to understand CMA allocation
> latency.
> 
> Signed-off-by: Richard Chang <richardycc@google.com>
> ---
> * from v1 - https://lore.kernel.org/linux-mm/20240226100045.2083962-1-richardycc@google.com/
>   * Move the trace event int field to the end of the longs - rostedt
>   * Do the calculation only when tracing is enabled - rostedt
> 
>  include/trace/events/kmem.h | 38 +++++++++++++++++++++++++++++++++++++
>  mm/internal.h               |  3 ++-
>  mm/page_alloc.c             | 32 ++++++++++++++++++++++++++-----
>  mm/page_isolation.c         |  2 +-
>  4 files changed, 68 insertions(+), 7 deletions(-)
> 
> diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
> index 58688768ef0f..6e62cc64cd92 100644
> --- a/include/trace/events/kmem.h
> +++ b/include/trace/events/kmem.h
> @@ -304,6 +304,44 @@ TRACE_EVENT(mm_page_alloc_extfrag,
>  		__entry->change_ownership)
>  );
>  
> +TRACE_EVENT(mm_alloc_contig_migrate_range_info,
> +
> +	TP_PROTO(unsigned long start,
> +		 unsigned long end,
> +		 unsigned long nr_migrated,
> +		 unsigned long nr_reclaimed,
> +		 unsigned long nr_mapped,
> +		 int migratetype),

Well, you didn't need to change the order of the parameters.

Anyway, from a tracing point of view:

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org.

-- Steve

> +
> +	TP_ARGS(start, end, nr_migrated, nr_reclaimed, nr_mapped, migratetype),
> +
> +	TP_STRUCT__entry(
> +		__field(unsigned long, start)
> +		__field(unsigned long, end)
> +		__field(unsigned long, nr_migrated)
> +		__field(unsigned long, nr_reclaimed)
> +		__field(unsigned long, nr_mapped)
> +		__field(int, migratetype)
> +	),
> +

