Return-Path: <linux-kernel+bounces-118748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CF688BEDE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C3811C3CEF7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB98E535AC;
	Tue, 26 Mar 2024 10:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oN05yOTI"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3198254BF0
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 10:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711447718; cv=none; b=PpaaySQQqWpxYx9ewXcL5FcQ+pv1ZWmw44Un/krd5rMnNs8ymXbjRncPOEe5Wk+ZHEX4s1QUC5wO6FCDGRcdiG8n8p5UGRBiT0GiV3ylMsjPGdXkg7DWfE3GhDRVdhWUertM0/TcnquZFKH0ZNFOK12wBgHbzij2zMni78uH6Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711447718; c=relaxed/simple;
	bh=YhZi47uHgagethz/FL/89AbKlyMLuDA2yhemmdX0Vh8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VWQspLJ3+E99up4QN9vN2v9sDr22vzPoQzKZKDgsMdCqH65YF04b9OibnQWuCUZAWbkOKQjo+iS0c2S3Nb5MYo8g38PNyAnbF4iY6D9NPd4iSFbSon1vdCmHDdxWJgzpdR+kDgUSrSeDxhXjx5OiAh+YNCd2EA6KcaFKdMks23Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oN05yOTI; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcbfe1a42a4so10098433276.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 03:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711447716; x=1712052516; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CaC0I3xs2cykMLEBqrJ0O6H6eh7LunXx8Vj6sAn28jg=;
        b=oN05yOTIaQl1onO2Mozhb/cdjDQ502h7LGLrGk/pBhmJ/M6TBoRPULA2aTePRbDHjp
         DVip0qv6S2zf7tX0Jh1WUiQFdsIPqbDoshj8CyunhUJbznJdPS5QB5YSIankXADjgriU
         BRSu4dd/Zay3PJfHeV57BF7bi90gBP7WOyS9eLT0HNHswK3w4CLPhPaCq2L7UeCroMsc
         8/zieDhXmHys93LvWOqyPm2GHfY3VlhyXFrKiZ/zzCQyoaYdTKSejZP5Ia5y6ZbYU1vh
         meVkUdlG1FwWYmZbj8R0isf5Py2ATNDcBdYrkY8m5WxtVQ8jiUlwoVkALHRvR5lKZ+IQ
         f9GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711447716; x=1712052516;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CaC0I3xs2cykMLEBqrJ0O6H6eh7LunXx8Vj6sAn28jg=;
        b=QJ6Imjr/EaL+wdqWvk+JjaEuIAnpKNVPS2a+njDJLRBY1bWdC38u8RgO72egdYexz7
         eo6ZkY3rqzVWKUPtOg6z9lUK36+239loRakQIueZ/KJT1kDXt/7G0pVNWWiEQAKvHDVp
         nbCEfHoFVn/HxKiS0686d3BRdNkwz8YTcMq3ZKzk7EgHrk36t5SOqg/M3d0vQAyxv/hL
         KQDXOE2SEwkTVYITx2kFdgDEOqnBRAFaTxn+/aBMyTcL+lAHC2OAKF3C78tKwnSxDUOD
         WrFCxSiBnYHnvNgGgXNdreaBrJbpZMmNxkwq4+fquYWCF+kOwuGwpSZ4i92v9vn7x3x9
         C7fg==
X-Forwarded-Encrypted: i=1; AJvYcCWBKnHqjN9Ee5Y5eM5yIOh8wrjIO8y1Wb/7V4ybUFuf1KJUjpfn1aSNQLlu6IRvh3FTFFIZX1EpOkxj17Eir/RMvXl983+ZIsJ/Wk8A
X-Gm-Message-State: AOJu0Yx9CcqrL4RcOukFk01LqCQ05K6nV99hzF+zwmfjvCWFUmxYJEvq
	1ccXgg3ripZ19oZmgQKj0k1dF2QJdYPM6iR8hyK91dJUPcz8COLKyhvy/cPFAVEjiA4kTbIDBfg
	ZrQVRda4d9mbX5ETbvQ==
X-Google-Smtp-Source: AGHT+IG90jp9Nyx4nAalMJQ2OyZZ0e3cGAFVnKkkq0xMYRu7yB1ts4BS7zrlQ68rwMvFCNu60T6VSha+80s8RAgu
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:6902:220a:b0:dc6:5396:c0d4 with
 SMTP id dm10-20020a056902220a00b00dc65396c0d4mr2947712ybb.1.1711447716285;
 Tue, 26 Mar 2024 03:08:36 -0700 (PDT)
Date: Tue, 26 Mar 2024 10:08:25 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240326100830.1326610-1-vdonnefort@google.com>
Subject: [PATCH v19 RESEND 0/5] Introducing trace buffer mapping by user-space
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

The tracing ring-buffers can be stored on disk or sent to network
without any copy via splice. However the later doesn't allow real time
processing of the traces. A solution is to give userspace direct access
to the ring-buffer pages via a mapping. An application can now become a
consumer of the ring-buffer, in a similar fashion to what trace_pipe
offers.

Support for this new feature can already be found in libtracefs from
version 1.8, when built with EXTRA_CFLAGS=-DFORCE_MMAP_ENABLE.

Vincent

v18 -> v19:
  * Use VM_PFNMAP and vm_insert_pages
  * Allocate ring-buffer subbufs with __GFP_COMP
  * Pad the meta-page with the zero-page to align on the subbuf_order
  * Extend the ring-buffer test with mmap() dedicated suite

v17 -> v18:
  * Fix lockdep_assert_held
  * Fix spin_lock_init typo
  * Fix CONFIG_TRACER_MAX_TRACE typo

v16 -> v17:
  * Documentation and comments improvements.
  * Create get/put_snapshot_map() for clearer code.
  * Replace kzalloc with kcalloc.
  * Fix -ENOMEM handling in rb_alloc_meta_page().
  * Move flush(cpu_buffer->reader_page) behind the reader lock.
  * Move all inc/dec of cpu_buffer->mapped behind reader lock and buffer
    mutex. (removes READ_ONCE/WRITE_ONCE accesses).

v15 -> v16:
  * Add comment for the dcache flush.
  * Remove now unnecessary WRITE_ONCE for the meta-page.

v14 -> v15:
  * Add meta-page and reader-page flush. Intends to fix the mapping
    for VIVT and aliasing-VIPT data caches.
  * -EPERM on VM_EXEC.
  * Fix build warning !CONFIG_TRACER_MAX_TRACE.

v13 -> v14:
  * All cpu_buffer->mapped readers use READ_ONCE (except for swap_cpu)
  * on unmap, sync meta-page teardown with the reader_lock instead of
    the synchronize_rcu.
  * Add a dedicated spinlock for trace_array ->snapshot and ->mapped.
    (intends to fix a lockdep issue)
  * Add kerneldoc for flags and Reserved fields.
  * Add kselftest for snapshot/map mutual exclusion.

v12 -> v13:
  * Swap subbufs_{touched,lost} for Reserved fields.
  * Add a flag field in the meta-page.
  * Fix CONFIG_TRACER_MAX_TRACE.
  * Rebase on top of trace/urgent.
  * Add a comment for try_unregister_trigger()

v11 -> v12:
  * Fix code sample mmap bug.
  * Add logging in sample code.
  * Reset tracer in selftest.
  * Add a refcount for the snapshot users.
  * Prevent mapping when there are snapshot users and vice versa.
  * Refine the meta-page.
  * Fix types in the meta-page.
  * Collect Reviewed-by.

v10 -> v11:
  * Add Documentation and code sample.
  * Add a selftest.
  * Move all the update to the meta-page into a single
    rb_update_meta_page().
  * rb_update_meta_page() is now called from
    ring_buffer_map_get_reader() to fix NOBLOCK callers.
  * kerneldoc for struct trace_meta_page.
  * Add a patch to zero all the ring-buffer allocations.

v9 -> v10:
  * Refactor rb_update_meta_page()
  * In-loop declaration for foreach_subbuf_page()
  * Check for cpu_buffer->mapped overflow

v8 -> v9:
  * Fix the unlock path in ring_buffer_map()
  * Fix cpu_buffer cast with rb_work_rq->is_cpu_buffer
  * Rebase on linux-trace/for-next (3cb3091138ca0921c4569bcf7ffa062519639b6a)

v7 -> v8:
  * Drop the subbufs renaming into bpages
  * Use subbuf as a name when relevant

v6 -> v7:
  * Rebase onto lore.kernel.org/lkml/20231215175502.106587604@goodmis.org/
  * Support for subbufs
  * Rename subbufs into bpages

v5 -> v6:
  * Rebase on next-20230802.
  * (unsigned long) -> (void *) cast for virt_to_page().
  * Add a wait for the GET_READER_PAGE ioctl.
  * Move writer fields update (overrun/pages_lost/entries/pages_touched)
    in the irq_work.
  * Rearrange id in struct buffer_page.
  * Rearrange the meta-page.
  * ring_buffer_meta_page -> trace_buffer_meta_page.
  * Add meta_struct_len into the meta-page.

v4 -> v5:
  * Trivial rebase onto 6.5-rc3 (previously 6.4-rc3)

v3 -> v4:
  * Add to the meta-page:
       - pages_lost / pages_read (allow to compute how full is the
	 ring-buffer)
       - read (allow to compute how many entries can be read)
       - A reader_page struct.
  * Rename ring_buffer_meta_header -> ring_buffer_meta
  * Rename ring_buffer_get_reader_page -> ring_buffer_map_get_reader_page
  * Properly consume events on ring_buffer_map_get_reader_page() with
    rb_advance_reader().

v2 -> v3:
  * Remove data page list (for non-consuming read)
    ** Implies removing order > 0 meta-page
  * Add a new meta page field ->read
  * Rename ring_buffer_meta_page_header into ring_buffer_meta_header

v1 -> v2:
  * Hide data_pages from the userspace struct
  * Fix META_PAGE_MAX_PAGES
  * Support for order > 0 meta-page
  * Add missing page->mapping.

Vincent Donnefort (5):
  ring-buffer: allocate sub-buffers with __GFP_COMP
  ring-buffer: Introducing ring-buffer mapping functions
  tracing: Allow user-space mapping of the ring-buffer
  Documentation: tracing: Add ring-buffer mapping
  ring-buffer/selftest: Add ring-buffer mapping test

 Documentation/trace/index.rst                 |   1 +
 Documentation/trace/ring-buffer-map.rst       | 106 +++++
 include/linux/ring_buffer.h                   |   6 +
 include/uapi/linux/trace_mmap.h               |  48 +++
 kernel/trace/ring_buffer.c                    | 402 +++++++++++++++++-
 kernel/trace/trace.c                          | 122 +++++-
 kernel/trace/trace.h                          |   1 +
 tools/testing/selftests/ring-buffer/Makefile  |   8 +
 tools/testing/selftests/ring-buffer/config    |   2 +
 .../testing/selftests/ring-buffer/map_test.c  | 302 +++++++++++++
 10 files changed, 987 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/trace/ring-buffer-map.rst
 create mode 100644 include/uapi/linux/trace_mmap.h
 create mode 100644 tools/testing/selftests/ring-buffer/Makefile
 create mode 100644 tools/testing/selftests/ring-buffer/config
 create mode 100644 tools/testing/selftests/ring-buffer/map_test.c


base-commit: 7604256cecef34a82333d9f78262d3180f4eb525
-- 
2.44.0.396.g6e790dbe36-goog


