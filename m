Return-Path: <linux-kernel+bounces-156002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A11FE8AFC8C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 01:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD8561C220D5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 23:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565F33E479;
	Tue, 23 Apr 2024 23:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PHvQXsVP"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3E8381DA
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 23:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713914862; cv=none; b=ARu3zCJwCuzlEa7e1o8T6ESFTef1yB2++jnYo1ns6HThf+DqrwGL4KZPLTFk9UnkXLuyBr9n7JUapc37OBccWwuc7+9enpNKwsFThOFpQV/vh3D33fXFjXXaAM6p5e+I16QEzOyGMlqd8B5PlJpOVjb2UPcGvCizGxHDaqjz+/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713914862; c=relaxed/simple;
	bh=dEMBA5GZi5Sot6zwck3R23iFomdPROp+vd8L481uIME=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=oxxg98Sse3o/gBUoIuYBxe7wO+NED+UeiPA9ubimMsrJ73i2WawAXBTFN1aSOjrXde2OZimBNq0XjR2Uw0WcnSyeXVN0xHCEzNB959qsAu4DVu/d/uESaD07a5gvN5YuOwVoLM/cLWIm/yxOwZnliaeBnBLWHIM9/8x7O0A9BKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PHvQXsVP; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de45d0b7ffaso11816699276.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 16:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713914860; x=1714519660; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iHPrRAdicf2kC6RLMUrl3hcP6CV9QCzcGC597dQMEhk=;
        b=PHvQXsVPEtj6CNaZ0RN9tb2SFpL/mCoCi9F1+UL/CLnvOiRTmfdjihSZyhS7OFs/U2
         qN7845PkdpOhJ6SRGYdER0tP/hVRZJZ+nfouYEseS1mkZIq4y6mwIS9wMwJj4SXuGQxS
         O9KfeLbDcenp0duX7cuBm5uS8GwNxeI0KkbBWKXneG9XjvsboVPnZZe2uGePBlLpw/7j
         zw8sUdTzb5GpEUfmP8ZYxlbnUsCuUSZhCcBxqur9oy6w7Ib6LXmtBKa/ncox0VuCmLJ0
         1ELXjGs3bI5k9Y8NP8YGTcTlIxKlx/5LZo+1bQrkqeE3XHHTfR9uSKeViDTlWYYL4VGd
         VNLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713914860; x=1714519660;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iHPrRAdicf2kC6RLMUrl3hcP6CV9QCzcGC597dQMEhk=;
        b=C80V1N+wn7QdQDr2qnbKhCaXRUnvyRi00ZN9tWI1RqZ8gCb39bvkAYxnNeaVYCKjhB
         c0NPsqSvTlqMhWNoklG8tXLzwHuUopH1c2SYefe2bpnDwHhpl6BIDaIehrt0NL2NivG7
         /RPweqOLnnK65EFm6bP4v6e7YrflS57xPI67uqOUbQmxSWj9aVluZlSwWm6ziuwPhxLJ
         kwvCDakyu5v6pGEepWkf9o8V/Mv49fcTalKKH6z+VakKbGd+yGnkTaGEztFyEZro5IXQ
         XWcIJQJn8W2S7WCBm90A4LnEJR+XEQivXea1UZyhdhcQRCYDbePtCb1g2CoXIH4ZxJsg
         wSrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWo+z7ebk5cl8r/rztSpJaK2fNGM/Wijx4yebhenOyv8U81jgfStzFHp+ynv55Tw/m5zthnqYRAwTsPEE4B6/QDOttFqD1NVYpGP/g/
X-Gm-Message-State: AOJu0YyU4WRFmLiFGT6iKpbDXf5ascyWs664Zd9Pau7ZJ8cXgnmmId57
	dzlkHVHp65d72vlGAcxCVEgYJrc9Ft53AU9T2rStsRV8L/N1GrWZFae924EXA6GNXBRbV0e2Pqf
	oWG+GvxXdE1ds9KuJaw==
X-Google-Smtp-Source: AGHT+IExPSdsUSP2pev3IojmuItmUkc/WafwNWfwwEfyBprHlSLgltkPdqZort4y2T3S+xBi6X7p170gx6YPzUGe
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:6902:124b:b0:dc6:44d4:bee0 with
 SMTP id t11-20020a056902124b00b00dc644d4bee0mr124378ybu.7.1713914860009; Tue,
 23 Apr 2024 16:27:40 -0700 (PDT)
Date: Wed, 24 Apr 2024 00:27:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240423232728.1492340-1-vdonnefort@google.com>
Subject: [PATCH v21 0/5] Introducing trace buffer mapping by user-space
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	rdunlap@infradead.org, rppt@kernel.org, david@redhat.com, 
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

v20 -> v21:
  * Collect Ack
  * Add .gitignore
  * Few nits
  * Remove meta-page padding (zero-page not supported by vm_insert_pages)
  * Remove single-usage macros
  * Move vma flags handling into ring-buffer.c

v19 -> v20:
  * Fix typos in documentation.
  * Remove useless mmap open and fault callbacks.
  * add mm.h include for vm_insert_pages

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
  ring-buffer: Allocate sub-buffers with __GFP_COMP
  ring-buffer: Introducing ring-buffer mapping functions
  tracing: Allow user-space mapping of the ring-buffer
  Documentation: tracing: Add ring-buffer mapping
  ring-buffer/selftest: Add ring-buffer mapping test

 Documentation/trace/index.rst                 |   1 +
 Documentation/trace/ring-buffer-map.rst       | 106 +++++
 include/linux/ring_buffer.h                   |   6 +
 include/uapi/linux/trace_mmap.h               |  48 ++
 kernel/trace/ring_buffer.c                    | 412 +++++++++++++++++-
 kernel/trace/trace.c                          | 104 ++++-
 kernel/trace/trace.h                          |   1 +
 .../testing/selftests/ring-buffer/.gitignore  |   1 +
 tools/testing/selftests/ring-buffer/Makefile  |   8 +
 tools/testing/selftests/ring-buffer/config    |   2 +
 .../testing/selftests/ring-buffer/map_test.c  | 288 ++++++++++++
 11 files changed, 966 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/trace/ring-buffer-map.rst
 create mode 100644 include/uapi/linux/trace_mmap.h
 create mode 100644 tools/testing/selftests/ring-buffer/.gitignore
 create mode 100644 tools/testing/selftests/ring-buffer/Makefile
 create mode 100644 tools/testing/selftests/ring-buffer/config
 create mode 100644 tools/testing/selftests/ring-buffer/map_test.c


base-commit: 7604256cecef34a82333d9f78262d3180f4eb525
-- 
2.44.0.769.g3c40516874-goog


