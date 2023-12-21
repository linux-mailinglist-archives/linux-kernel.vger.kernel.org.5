Return-Path: <linux-kernel+bounces-8883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 617DC81BDB8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9356D1C24448
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7C2627E2;
	Thu, 21 Dec 2023 17:57:12 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DE864A83;
	Thu, 21 Dec 2023 17:57:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA2CDC433C7;
	Thu, 21 Dec 2023 17:57:09 +0000 (UTC)
Date: Thu, 21 Dec 2023 12:58:13 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v9 1/2] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <20231221125813.673293a2@gandalf.local.home>
In-Reply-To: <20231221173523.3015715-2-vdonnefort@google.com>
References: <20231221173523.3015715-1-vdonnefort@google.com>
	<20231221173523.3015715-2-vdonnefort@google.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Dec 2023 17:35:22 +0000
Vincent Donnefort <vdonnefort@google.com> wrote:

> @@ -5999,6 +6078,307 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
>  }
>  EXPORT_SYMBOL_GPL(ring_buffer_subbuf_order_set);
>  

The kernel developers have agreed to allow loop variables to be declared in
loops. This will simplify these macros:



> +#define subbuf_page(off, start) \
> +	virt_to_page((void *)(start + (off << PAGE_SHIFT)))
> +
> +#define foreach_subbuf_page(off, sub_order, start, page)	\
> +	for (off = 0, page = subbuf_page(0, start);		\
> +	     off < (1 << sub_order);				\
> +	     off++, page = subbuf_page(off, start))

#define foreach_subbuf_page(sub_order, start, page)		\
	for (int __off = 0, page = subbuf_page(0, (start));	\
	     __off < (1 << (sub_order));			\
	     __off++, page = subbuf_page(__off, (start)))

And parameters as r-values should always be wrapped in parenthesis.

> +
> +static inline void subbuf_map_prepare(unsigned long subbuf_start, int order)
> +{
> +	struct page *page;
> +	int subbuf_off;

Then you can remove the "subbuf_off".

> +
> +	/*
> +	 * When allocating order > 0 pages, only the first struct page has a
> +	 * refcount > 1. Increasing the refcount here ensures none of the struct
> +	 * page composing the sub-buffer is freeed when the mapping is closed.

Nice catch by the way ;-)

-- Steve

> +	 */
> +	foreach_subbuf_page(subbuf_off, order, subbuf_start, page)
> +		page_ref_inc(page);
> +}
> +
> +static inline void subbuf_unmap(unsigned long subbuf_start, int order)
> +{
> +	struct page *page;
> +	int subbuf_off;
> +
> +	foreach_subbuf_page(subbuf_off, order, subbuf_start, page) {
> +		page_ref_dec(page);
> +		page->mapping = NULL;
> +	}
> +}
> +

