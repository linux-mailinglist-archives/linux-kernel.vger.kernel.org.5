Return-Path: <linux-kernel+bounces-7354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD62181A671
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 18:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1672B234D0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4E547A6B;
	Wed, 20 Dec 2023 17:35:46 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01F14777F;
	Wed, 20 Dec 2023 17:35:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D875C433C7;
	Wed, 20 Dec 2023 17:35:44 +0000 (UTC)
Date: Wed, 20 Dec 2023 12:36:44 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Bixuan Cui <cuibixuan@vivo.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
 opensource.kernel@vivo.com
Subject: Re: [PATCH -next v4 2/2] mm: vmscan: add new event to trace shrink
 lru
Message-ID: <20231220123644.2a28d162@gandalf.local.home>
In-Reply-To: <20231220012123.2787-3-cuibixuan@vivo.com>
References: <20231220012123.2787-1-cuibixuan@vivo.com>
	<20231220012123.2787-3-cuibixuan@vivo.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Dec 2023 17:21:23 -0800
Bixuan Cui <cuibixuan@vivo.com> wrote:

> diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
> index b99cd28c9815..02868bdc5999 100644
> --- a/include/trace/events/vmscan.h
> +++ b/include/trace/events/vmscan.h
> @@ -395,7 +395,24 @@ TRACE_EVENT(mm_vmscan_write_folio,
>  		show_reclaim_flags(__entry->reclaim_flags))
>  );
>  
> -TRACE_EVENT(mm_vmscan_lru_shrink_inactive,
> +TRACE_EVENT(mm_vmscan_lru_shrink_inactive_start,
> +
> +	TP_PROTO(int nid),
> +
> +	TP_ARGS(nid),
> +
> +	TP_STRUCT__entry(
> +		__field(int, nid)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->nid = nid;
> +	),
> +
> +	TP_printk("nid=%d", __entry->nid)
> +);
> +
> +TRACE_EVENT(mm_vmscan_lru_shrink_inactive_end,
>  
>  	TP_PROTO(int nid,
>  		unsigned long nr_scanned, unsigned long nr_reclaimed,
> @@ -446,7 +463,24 @@ TRACE_EVENT(mm_vmscan_lru_shrink_inactive,
>  		show_reclaim_flags(__entry->reclaim_flags))
>  );
>  
> -TRACE_EVENT(mm_vmscan_lru_shrink_active,
> +TRACE_EVENT(mm_vmscan_lru_shrink_active_start,
> +
> +	TP_PROTO(int nid),
> +
> +	TP_ARGS(nid),
> +
> +	TP_STRUCT__entry(
> +		__field(int, nid)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->nid = nid;
> +	),
> +
> +	TP_printk("nid=%d", __entry->nid)
> +);
> +
> +TRACE_EVENT(mm_vmscan_lru_shrink_active_end,
>  

These two events are identical, please use DECLARE_EVENT_CLASS and
DEFINE_EVENT macros:

DECLARE_EVENT_CLASS(mm_vmscan_lru_shrink_start_template,

	TP_PROTO(int nid),

	TP_ARGS(nid),

	TP_STRUCT__entry(
		__field(int, nid)
	),

	TP_fast_assign(
		__entry->nid = nid;
	),

	TP_printk("nid=%d", __entry->nid)
);

DEFINE_EVENT(mm_vmscan_lru_shrink_start_template, mm_vmscan_lru_shrink_inactive_start,
	TP_PROTO(int nid),
	TP_ARGS(nid)
);

DEFINE_EVENT(mm_vmscan_lru_shrink_start_template, mm_vmscan_lru_shrink_active_end,
	TP_PROTO(int nid),
	TP_ARGS(nid)
);

This saves a bit of memory footprint when doing so.

-- Steve

