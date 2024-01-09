Return-Path: <linux-kernel+bounces-20876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9296D8286C5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E27DEB21BA5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E19381AB;
	Tue,  9 Jan 2024 13:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHAI8SDJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AABE38DD2;
	Tue,  9 Jan 2024 13:04:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2201DC433F1;
	Tue,  9 Jan 2024 13:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704805490;
	bh=j8OwOeSlBjiqEk2Nw87AuVBZrWAQiK3wI8z6JPGw9oA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bHAI8SDJfJLxz8/aNq12L19/RJF5nIE9HNKcB+hjNjfTisnG4OtRiAH6PYld0WsE8
	 gsI0xiyARTGyM0wCOeD37tYB6zMnmQ5JT1SSesIO4ijgKz5k2g4ht/l0s/gdIvkueQ
	 hE2xvDQ1rFABvvzDlRiTfJo369Pt1h3Ao3r7qRgq5a9omzjEe6td6inLIs95sIda/o
	 4XHDHspAaXeyeFWNxV0b30o2wF8nk/FX4xohuIYhoEtYp+726tGTsfLDT8VBuFCLbm
	 YvnRWOHm3Mf8vKAasAdbZCMrzhDFLppNA6jOzdfXo4dAyFiyasjWAD5P6DVe/ukRcS
	 htV79TECyXXeA==
Date: Tue, 9 Jan 2024 22:04:45 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: rostedt@goodmis.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, kernel-team@android.com
Subject: Re: [PATCH v10 0/2] Introducing trace buffer mapping by user-space
Message-Id: <20240109220445.5683e4af0cea6b034945b2bb@kernel.org>
In-Reply-To: <20240105094729.2363579-1-vdonnefort@google.com>
References: <20240105094729.2363579-1-vdonnefort@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Vincent,

On Fri,  5 Jan 2024 09:47:27 +0000
Vincent Donnefort <vdonnefort@google.com> wrote:

> The tracing ring-buffers can be stored on disk or sent to network
> without any copy via splice. However the later doesn't allow real time
> processing of the traces. A solution is to give userspace direct access
> to the ring-buffer pages via a mapping. An application can now become a
> consumer of the ring-buffer, in a similar fashion to what trace_pipe
> offers.

I think this is very nice feature. But this series seems just a feature,
no document and no example code. Can you add 2 patches to add those?
I know libtracefs already provide a support code, but I think it is
better to have a test code under tools/testing/selftests/ring_buffer.

I also wonder what happen if other operation (e.g. taking snapshot) happens
while mmaping the ring buffer.

Thank you,

> 
> Support for this new feature in libtracefs can be found here:
> 
>   https://lore.kernel.org/all/20231228201100.78aae259@rorschach.local.home
> 
> Vincent
> 
> v9 -> v10:
>   * Refactor rb_update_meta_page()
>   * In-loop declaration for foreach_subbuf_page()
>   * Check for cpu_buffer->mapped overflow
> 
> v8 -> v9:
>   * Fix the unlock path in ring_buffer_map()
>   * Fix cpu_buffer cast with rb_work_rq->is_cpu_buffer
>   * Rebase on linux-trace/for-next (3cb3091138ca0921c4569bcf7ffa062519639b6a)
> 
> v7 -> v8:
>   * Drop the subbufs renaming into bpages
>   * Use subbuf as a name when relevant
> 
> v6 -> v7:
>   * Rebase onto lore.kernel.org/lkml/20231215175502.106587604@goodmis.org/
>   * Support for subbufs
>   * Rename subbufs into bpages
> 
> v5 -> v6:
>   * Rebase on next-20230802.
>   * (unsigned long) -> (void *) cast for virt_to_page().
>   * Add a wait for the GET_READER_PAGE ioctl.
>   * Move writer fields update (overrun/pages_lost/entries/pages_touched)
>     in the irq_work.
>   * Rearrange id in struct buffer_page.
>   * Rearrange the meta-page.
>   * ring_buffer_meta_page -> trace_buffer_meta_page.
>   * Add meta_struct_len into the meta-page.
> 
> v4 -> v5:
>   * Trivial rebase onto 6.5-rc3 (previously 6.4-rc3)
> 
> v3 -> v4:
>   * Add to the meta-page:
>        - pages_lost / pages_read (allow to compute how full is the
> 	 ring-buffer)
>        - read (allow to compute how many entries can be read)
>        - A reader_page struct.
>   * Rename ring_buffer_meta_header -> ring_buffer_meta
>   * Rename ring_buffer_get_reader_page -> ring_buffer_map_get_reader_page
>   * Properly consume events on ring_buffer_map_get_reader_page() with
>     rb_advance_reader().
> 
> v2 -> v3:
>   * Remove data page list (for non-consuming read)
>     ** Implies removing order > 0 meta-page
>   * Add a new meta page field ->read
>   * Rename ring_buffer_meta_page_header into ring_buffer_meta_header
> 
> v1 -> v2:
>   * Hide data_pages from the userspace struct
>   * Fix META_PAGE_MAX_PAGES
>   * Support for order > 0 meta-page
>   * Add missing page->mapping.
> 
> ---
> 
> Vincent Donnefort (2):
>   ring-buffer: Introducing ring-buffer mapping functions
>   tracing: Allow user-space mapping of the ring-buffer
> 
>  include/linux/ring_buffer.h     |   7 +
>  include/uapi/linux/trace_mmap.h |  31 +++
>  kernel/trace/ring_buffer.c      | 384 +++++++++++++++++++++++++++++++-
>  kernel/trace/trace.c            |  79 ++++++-
>  4 files changed, 497 insertions(+), 4 deletions(-)
>  create mode 100644 include/uapi/linux/trace_mmap.h
> 
> 
> base-commit: 3cb3091138ca0921c4569bcf7ffa062519639b6a
> -- 
> 2.43.0.472.g3155946c3a-goog
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

