Return-Path: <linux-kernel+bounces-63459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07259852FD0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BC041C22401
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB1C381B8;
	Tue, 13 Feb 2024 11:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YTG+pM9u"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4743A376F7
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 11:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707825050; cv=none; b=vCzkQqs//8E7PAcaOcP588vzmwYzWreScAL6GfPNnm01ssQ0gMpz1WTp1gwzSl+xq0vHRjlfEVHrJdgak0EAm2HXnaAhPoMxx7si7PaZcVPDaSnK/O5EzSW/XOI4wtgZN3vD6ecay7ltLlXxP3vB4Ois3UMdkxMxoJxLACs1VmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707825050; c=relaxed/simple;
	bh=q7rVo2DSodMeezMaxn9Lr3Kuuut8KZT6AFuG5/W3D28=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MKhxLVhqo5jyOhwrrTKq2gBJcWSEnncxF80dl7M0HwecClQZJYylJbVJeivTf6bDp57o76//Ju5TmqSjevCK8Xri1sbOrrwa7MiIdCf1BrxV00AxR9l+D9S8wH9kBMQpf44ytPe4002wVBnDyXWVIZQHkzWZ47WbbpyuEIN0BYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YTG+pM9u; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6077fa2fa9bso13196477b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 03:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707825048; x=1708429848; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VhwEbjlgus4cAtTtYuL3Yvg9paaVaIh1ewBwp/V7zco=;
        b=YTG+pM9ugXfZWJarz0h/Hwn2Nv42z8Zsp2tmjd+qH+BSa4PD1ucj/JoXnE9MITKDBx
         OMJ4P5Uo84/QtTMyiGiEKqKlZoqOTcbiriA8zH9atWY9BVyU8Tg9oXohNyKgpdiwyYcX
         V9HeMF//F0fyDNTSA9l/EB6xd39ZnJS7pydN7DaK4t1al47y4/UccHtZm3iA+HZUO53x
         CLzIO3aO3aBg46jyQ3a19z1G5jhwRMQtrs7bEwfCS50gHL9HyaH07eRxYf7Vw7C3rr0S
         JMptwy+m72g9mRSM/trXlZsyS6rIqaxslVK4iOa8d0yB6y1YINZVWYF2QdhtueLcVGNJ
         +IgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707825048; x=1708429848;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VhwEbjlgus4cAtTtYuL3Yvg9paaVaIh1ewBwp/V7zco=;
        b=O+KwqyO1tgr6zrcz3NXZW2cFl7NyE4hK/uU2ts1wYR3216VXrsukgkxdL/jmhU5jkg
         nUo6RWYgHemaueOsUrsqgDFzkOGWZmK8Pu4BfyoT2JVTeoo1GI37y2VxGA9cPhre1u3K
         8uEiEaaYBz1t/CX6dD1XgnoL3TZtmR0NCX+iyE3B5t4Qhuss4NBQrpgEDKxmSdafWKRv
         tGyrfWoWAeqqRt8OQIwVU+dyhHrkfkPJgth/E6aXh6Zy6ngqmQJvEBuQGI72fgi+wSMO
         0YKW3jhl6PWG4cpBh4z1dsTNP9ldtMSha+6hjzrzsOwxhGfRuX7HxoyWifRuOaSg9z/S
         6FAg==
X-Forwarded-Encrypted: i=1; AJvYcCW8ZJ4LF8uxRIUIxTxRob9mtzS2xoo01EOPEKs8TpiWcLMdWP9izcmVRl8pBfhxZQe305XeMcZ0BL55+SCiPon1dXNyiXdbvDj6Dohc
X-Gm-Message-State: AOJu0YywSP0QD9wlpWJghJUBwACz01bjR0YAZ/LzMnDJV3opCE3WF9G1
	s8VTtESLnR6+QWiq48AtlGByZzdJVHYBhMSbb2wRLCoQEJEGMRyZkP3Ceth3RUmG5cg0D5FZbZo
	pKQMCo6qv6myN6lFXJw==
X-Google-Smtp-Source: AGHT+IGQTH3uqdY7zkd0WzoLptet8DsRJBX2YKfahbExGkEkGenftm6HDxcB7Qj79KpI7l4aYIfY/dg943LJKe21
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:690c:b8b:b0:604:4c5:7dc8 with SMTP
 id ck11-20020a05690c0b8b00b0060404c57dc8mr2160949ywb.8.1707825048353; Tue, 13
 Feb 2024 03:50:48 -0800 (PST)
Date: Tue, 13 Feb 2024 11:49:39 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240213114945.3528801-1-vdonnefort@google.com>
Subject: [PATCH v17 0/6] Introducing trace buffer mapping by user-space
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

Vincent Donnefort (6):
  ring-buffer: Zero ring-buffer sub-buffers
  ring-buffer: Introducing ring-buffer mapping functions
  tracing: Add snapshot refcount
  tracing: Allow user-space mapping of the ring-buffer
  Documentation: tracing: Add ring-buffer mapping
  ring-buffer/selftest: Add ring-buffer mapping test

 Documentation/trace/index.rst                 |   1 +
 Documentation/trace/ring-buffer-map.rst       | 106 +++++
 include/linux/ring_buffer.h                   |   7 +
 include/uapi/linux/trace_mmap.h               |  48 +++
 kernel/trace/ring_buffer.c                    | 385 +++++++++++++++++-
 kernel/trace/trace.c                          | 234 ++++++++++-
 kernel/trace/trace.h                          |   9 +-
 kernel/trace/trace_events_trigger.c           |  58 ++-
 tools/testing/selftests/ring-buffer/Makefile  |   8 +
 tools/testing/selftests/ring-buffer/config    |   2 +
 .../testing/selftests/ring-buffer/map_test.c  | 273 +++++++++++++
 11 files changed, 1085 insertions(+), 46 deletions(-)
 create mode 100644 Documentation/trace/ring-buffer-map.rst
 create mode 100644 include/uapi/linux/trace_mmap.h
 create mode 100644 tools/testing/selftests/ring-buffer/Makefile
 create mode 100644 tools/testing/selftests/ring-buffer/config
 create mode 100644 tools/testing/selftests/ring-buffer/map_test.c


base-commit: ca185770db914869ff9fe773bac5e0e5e4165b83
-- 
2.43.0.687.g38aa6559b0-goog


