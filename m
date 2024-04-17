Return-Path: <linux-kernel+bounces-147937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1928A7B9C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 06:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E17E41C218AC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 04:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD944084D;
	Wed, 17 Apr 2024 04:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NkYMqRX4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8201623D2;
	Wed, 17 Apr 2024 04:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713329795; cv=none; b=TJPWAJ93ZKWRABuhlIZu5crPA5Oz74A8taVM9V7T9xB+Kad4lwaxdYleiIYk4x33m/OZ/c4uVs3H4/9LJknCd77jiZNHUr1SSGbUG6VK+1QrOoCecIffvjcWX52dllMR6SKOrzlb+2oVD2Y1vodNazlwY3qS4E+Eqfvum1nWKlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713329795; c=relaxed/simple;
	bh=BuZ8P8XoiIAM75OqFsQnPajzoPmLzP8HTuZmoXwmL78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fq1CJ5pvaY9o42YSGyWJ6f09wFAuhhxXBxNF6Vq2pvW/z3vgJxy4PzFoQQLkE83/QO0bCUdMAReNTXjYkcARvM24qv2FhwO9OtlnpWSTr0+lNmhYu8YQKUe46LtbLBPsgQ5/nhf+vV5qhtkjjZ4DExkDuMVHH/yaj79CvG795sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NkYMqRX4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB4E5C072AA;
	Wed, 17 Apr 2024 04:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713329794;
	bh=BuZ8P8XoiIAM75OqFsQnPajzoPmLzP8HTuZmoXwmL78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NkYMqRX4lxFl4iWw0gcq2nChoo1XR/daM/2LKLMu4C1jUMDgQo8tyhr2G7YUjhKdS
	 pLuanq23TlmLnRE6dzcC/2cCNh14Yqo7L88QkiEX1F9hv8l1pwStoZ+rouh/CzhNtI
	 NNON0hzCsUKBJj9TI0Dk6NIKjn7PwvJU47ZEomLcLk+T5rJZqeK2QlZPGOo1IsNYoF
	 oXqKT6dxgjhtUGLq8ChmriPA53H09h3zXaNuQx30NVQu1Tn3D3o2yWH5IR6AmQyLhE
	 r6sb0+maeAgcgaWLW4w1wRMOEQsutwcvfjlnAa2eit0pUXHGrrLXdl9l4jy0eKigSK
	 EzeMlT+16fzwA==
Date: Wed, 17 Apr 2024 07:55:23 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Vincent Donnefort <vdonnefort@google.com>, mhiramat@kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com, kernel-team@android.com,
	rdunlap@infradead.org, linux-mm@kvack.org
Subject: Re: [PATCH v20 0/5] Introducing trace buffer mapping by user-space
Message-ID: <Zh9WO1p7fzGHvKv5@kernel.org>
References: <20240406173649.3210836-1-vdonnefort@google.com>
 <20240410135612.5dc362e3@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410135612.5dc362e3@gandalf.local.home>

(added linux-mm)

On Wed, Apr 10, 2024 at 01:56:12PM -0400, Steven Rostedt wrote:
> 
> Hi Andrew, et.al.
> 
> Linus said it's a hard requirement that this code gets an Acked-by (or
> Reviewed-by) from the memory sub-maintainers before he will accept it.
> He was upset that we faulted in pages one at a time instead of mapping it
> in one go:
> 
>   https://lore.kernel.org/all/CAHk-=wh5wWeib7+kVHpBVtUn7kx7GGadWqb5mW5FYTdewEfL=w@mail.gmail.com/
> 
> Could you take a look at patches 1-3 to make sure they look sane from a
> memory management point of view?
> 
> I really want this applied in the next merge window.
> 
> Thanks!
> 
> -- Steve
> 
> 
> On Sat,  6 Apr 2024 18:36:44 +0100
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> > The tracing ring-buffers can be stored on disk or sent to network
> > without any copy via splice. However the later doesn't allow real time
> > processing of the traces. A solution is to give userspace direct access
> > to the ring-buffer pages via a mapping. An application can now become a
> > consumer of the ring-buffer, in a similar fashion to what trace_pipe
> > offers.
> > 
> > Support for this new feature can already be found in libtracefs from
> > version 1.8, when built with EXTRA_CFLAGS=-DFORCE_MMAP_ENABLE.
> > 
> > Vincent
> > 
> > v19 -> v20:
> >   * Fix typos in documentation.
> >   * Remove useless mmap open and fault callbacks.
> >   * add mm.h include for vm_insert_pages
> > 
> > v18 -> v19:
> >   * Use VM_PFNMAP and vm_insert_pages
> >   * Allocate ring-buffer subbufs with __GFP_COMP
> >   * Pad the meta-page with the zero-page to align on the subbuf_order
> >   * Extend the ring-buffer test with mmap() dedicated suite
> > 
> > v17 -> v18:
> >   * Fix lockdep_assert_held
> >   * Fix spin_lock_init typo
> >   * Fix CONFIG_TRACER_MAX_TRACE typo
> > 
> > v16 -> v17:
> >   * Documentation and comments improvements.
> >   * Create get/put_snapshot_map() for clearer code.
> >   * Replace kzalloc with kcalloc.
> >   * Fix -ENOMEM handling in rb_alloc_meta_page().
> >   * Move flush(cpu_buffer->reader_page) behind the reader lock.
> >   * Move all inc/dec of cpu_buffer->mapped behind reader lock and buffer
> >     mutex. (removes READ_ONCE/WRITE_ONCE accesses).
> > 
> > v15 -> v16:
> >   * Add comment for the dcache flush.
> >   * Remove now unnecessary WRITE_ONCE for the meta-page.
> > 
> > v14 -> v15:
> >   * Add meta-page and reader-page flush. Intends to fix the mapping
> >     for VIVT and aliasing-VIPT data caches.
> >   * -EPERM on VM_EXEC.
> >   * Fix build warning !CONFIG_TRACER_MAX_TRACE.
> > 
> > v13 -> v14:
> >   * All cpu_buffer->mapped readers use READ_ONCE (except for swap_cpu)
> >   * on unmap, sync meta-page teardown with the reader_lock instead of
> >     the synchronize_rcu.
> >   * Add a dedicated spinlock for trace_array ->snapshot and ->mapped.
> >     (intends to fix a lockdep issue)
> >   * Add kerneldoc for flags and Reserved fields.
> >   * Add kselftest for snapshot/map mutual exclusion.
> > 
> > v12 -> v13:
> >   * Swap subbufs_{touched,lost} for Reserved fields.
> >   * Add a flag field in the meta-page.
> >   * Fix CONFIG_TRACER_MAX_TRACE.
> >   * Rebase on top of trace/urgent.
> >   * Add a comment for try_unregister_trigger()
> > 
> > v11 -> v12:
> >   * Fix code sample mmap bug.
> >   * Add logging in sample code.
> >   * Reset tracer in selftest.
> >   * Add a refcount for the snapshot users.
> >   * Prevent mapping when there are snapshot users and vice versa.
> >   * Refine the meta-page.
> >   * Fix types in the meta-page.
> >   * Collect Reviewed-by.
> > 
> > v10 -> v11:
> >   * Add Documentation and code sample.
> >   * Add a selftest.
> >   * Move all the update to the meta-page into a single
> >     rb_update_meta_page().
> >   * rb_update_meta_page() is now called from
> >     ring_buffer_map_get_reader() to fix NOBLOCK callers.
> >   * kerneldoc for struct trace_meta_page.
> >   * Add a patch to zero all the ring-buffer allocations.
> > 
> > v9 -> v10:
> >   * Refactor rb_update_meta_page()
> >   * In-loop declaration for foreach_subbuf_page()
> >   * Check for cpu_buffer->mapped overflow
> > 
> > v8 -> v9:
> >   * Fix the unlock path in ring_buffer_map()
> >   * Fix cpu_buffer cast with rb_work_rq->is_cpu_buffer
> >   * Rebase on linux-trace/for-next (3cb3091138ca0921c4569bcf7ffa062519639b6a)
> > 
> > v7 -> v8:
> >   * Drop the subbufs renaming into bpages
> >   * Use subbuf as a name when relevant
> > 
> > v6 -> v7:
> >   * Rebase onto lore.kernel.org/lkml/20231215175502.106587604@goodmis.org/
> >   * Support for subbufs
> >   * Rename subbufs into bpages
> > 
> > v5 -> v6:
> >   * Rebase on next-20230802.
> >   * (unsigned long) -> (void *) cast for virt_to_page().
> >   * Add a wait for the GET_READER_PAGE ioctl.
> >   * Move writer fields update (overrun/pages_lost/entries/pages_touched)
> >     in the irq_work.
> >   * Rearrange id in struct buffer_page.
> >   * Rearrange the meta-page.
> >   * ring_buffer_meta_page -> trace_buffer_meta_page.
> >   * Add meta_struct_len into the meta-page.
> > 
> > v4 -> v5:
> >   * Trivial rebase onto 6.5-rc3 (previously 6.4-rc3)
> > 
> > v3 -> v4:
> >   * Add to the meta-page:
> >        - pages_lost / pages_read (allow to compute how full is the
> > 	 ring-buffer)
> >        - read (allow to compute how many entries can be read)
> >        - A reader_page struct.
> >   * Rename ring_buffer_meta_header -> ring_buffer_meta
> >   * Rename ring_buffer_get_reader_page -> ring_buffer_map_get_reader_page
> >   * Properly consume events on ring_buffer_map_get_reader_page() with
> >     rb_advance_reader().
> > 
> > v2 -> v3:
> >   * Remove data page list (for non-consuming read)
> >     ** Implies removing order > 0 meta-page
> >   * Add a new meta page field ->read
> >   * Rename ring_buffer_meta_page_header into ring_buffer_meta_header
> > 
> > v1 -> v2:
> >   * Hide data_pages from the userspace struct
> >   * Fix META_PAGE_MAX_PAGES
> >   * Support for order > 0 meta-page
> >   * Add missing page->mapping.
> > 
> > Vincent Donnefort (5):
> >   ring-buffer: allocate sub-buffers with __GFP_COMP
> >   ring-buffer: Introducing ring-buffer mapping functions
> >   tracing: Allow user-space mapping of the ring-buffer
> >   Documentation: tracing: Add ring-buffer mapping
> >   ring-buffer/selftest: Add ring-buffer mapping test
> > 
> >  Documentation/trace/index.rst                 |   1 +
> >  Documentation/trace/ring-buffer-map.rst       | 106 +++++
> >  include/linux/ring_buffer.h                   |   6 +
> >  include/uapi/linux/trace_mmap.h               |  48 +++
> >  kernel/trace/ring_buffer.c                    | 403 +++++++++++++++++-
> >  kernel/trace/trace.c                          | 113 ++++-
> >  kernel/trace/trace.h                          |   1 +
> >  tools/testing/selftests/ring-buffer/Makefile  |   8 +
> >  tools/testing/selftests/ring-buffer/config    |   2 +
> >  .../testing/selftests/ring-buffer/map_test.c  | 302 +++++++++++++
> >  10 files changed, 979 insertions(+), 11 deletions(-)
> >  create mode 100644 Documentation/trace/ring-buffer-map.rst
> >  create mode 100644 include/uapi/linux/trace_mmap.h
> >  create mode 100644 tools/testing/selftests/ring-buffer/Makefile
> >  create mode 100644 tools/testing/selftests/ring-buffer/config
> >  create mode 100644 tools/testing/selftests/ring-buffer/map_test.c
> > 
> > 
> > base-commit: 7604256cecef34a82333d9f78262d3180f4eb525
> 

-- 
Sincerely yours,
Mike.

