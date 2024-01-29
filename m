Return-Path: <linux-kernel+bounces-42898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13881840847
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE44728783E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5176E67740;
	Mon, 29 Jan 2024 14:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K3LyIwYC"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEA267727
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 14:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706538492; cv=none; b=B2qaxRyPOljhDSsSdK3UyZfs834r21aLGG+2Zcg/pNjYnEFcGo4hAvRhLyiKmFZjgyvXlGinuXEZ29E7b0Q/zTw81XNlJzh5IR4uhCrFXAUyIsAAifEhSkkxr5cTUu+Klp0nQWM2XVYxsMkfMPXJoBbzFtnOY46VqE5VUyD3/ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706538492; c=relaxed/simple;
	bh=08vMVQVJ1OL1ZrKwTC27MiT2Y0Q66IzGXt2K5LTQM9o=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Km4mpIgXPcO/zAgp35vdkwKUu7Bmikz0UvAk2XyDpC0KDqRXGtHeWPvWiRHAiBUB2yu+aNqE7vrO4jdp2y2lTXYt5SKt12KZBi0hf9/oHu1YngdVUteJ4RgUZOG7ikMbf7uY2Ua7UB1RolZNLW65olm4yEkN9dyIQ5BDSOk2gA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K3LyIwYC; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc223d528cfso5246442276.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 06:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706538490; x=1707143290; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m6ix6w6jnc/r7m37oFEuHsrF8vE57HFuEmsPVrjGUaM=;
        b=K3LyIwYCK+G+Lo6hvBHjsL9NoQkKrNa0sqARrSDIjLJYoi1XfrwYBcvOy3VFGOuf3m
         iAefHLZWq7bbKHchUPh4fhgot3cD45M/+w1kxRrVSY0SpNi1tG5Ps4Xu+437n1Fuy2Tr
         B7vD69eoNZ5wNW4Lj/XkkcSDXOOCVUzc86rmImpwiIwse2WP1nYzkjpDa5UNqeEfQ+Cv
         oU7FaughFLMILAZ4UuJV6nbUzsMcXEquOVVYJri49nIt9GZHHMoLODj0QpQqlVwgg6kY
         IV+FzokgR2jr5mal2YU4g6qkFq8SxQISC6IDASozwQ3aREj3h3ZYglOiZg1LOH4CwhT0
         7LEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706538490; x=1707143290;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m6ix6w6jnc/r7m37oFEuHsrF8vE57HFuEmsPVrjGUaM=;
        b=OCXPZ82M4dc4z4wMxXstdq3RMUiXScTyylgOnLX4/9uSRmqsNxW/wuO51m2KB2jHXg
         cVDSv5i8iBOuD5J7V4AzRQieDYBIg8P3aVumLzc6IYzZk5aY3IIC6HJF4TYmAGa3qjyd
         NLbLJRQCDIr1krKlyXlyKSzi4jrgLaJkZu8pMJRJXSLw3Clt2qkI5UokC+5KXIqGa7kw
         9l8dpMLSTMIZR1fXKcZznjHh8XEDULQ+mwHgxwQw1vJN3MD6yXtJe26uv1XcAp/TyvZB
         M3WKRxFCKDmCiZwnwbxyyNjWx+9aOdrIhjqR8tMC677uKIwGVGgZE0QO0ke35ZQ75q4U
         p02A==
X-Gm-Message-State: AOJu0YynBNMbwfuSylsrJAU5c+70aM1LWOg3bvfkndXdPmhIx6Zeaia2
	2J0yKjgb+2sNP/RlT9/+P9P2DAR/t4eCTlWg800Gu+SZSpEjJIgeYagMf/Ca2HRlla+C+49LuYA
	Bz0A3Oz4r9yWdmGQlbw==
X-Google-Smtp-Source: AGHT+IFte0IYVAormlKW9S1uv8ALJPhQWbkSghp060KwuGekaE6Nm2aCF6VUI2ioQZuqMFJyJ+SRN1kWtMrBxlQh
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:6902:e0d:b0:dc6:785:1a10 with SMTP
 id df13-20020a0569020e0d00b00dc607851a10mr2227607ybb.4.1706538489812; Mon, 29
 Jan 2024 06:28:09 -0800 (PST)
Date: Mon, 29 Jan 2024 14:27:56 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240129142802.2145305-1-vdonnefort@google.com>
Subject: [PATCH v13 0/6] Introducing trace buffer mapping by user-space
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

v12 -> v13:
  * Swap subbufs_{touched,lost} for Reserved fields.
  * Add a flag field in the meta-page.
  * Fix CONFIG_TRACER_MAX_TRACE.
  * Rebase on top of trace/urgent. (29142dc92c37d3259a33aef15b03e6ee25b0d188)
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
 Documentation/trace/ring-buffer-map.rst       | 104 ++++++
 include/linux/ring_buffer.h                   |   7 +
 include/uapi/linux/trace_mmap.h               |  45 +++
 kernel/trace/ring_buffer.c                    | 335 +++++++++++++++++-
 kernel/trace/trace.c                          | 210 ++++++++++-
 kernel/trace/trace.h                          |   6 +
 kernel/trace/trace_events_trigger.c           |  58 ++-
 tools/testing/selftests/ring-buffer/Makefile  |   8 +
 tools/testing/selftests/ring-buffer/config    |   1 +
 .../testing/selftests/ring-buffer/map_test.c  | 183 ++++++++++
 11 files changed, 918 insertions(+), 40 deletions(-)
 create mode 100644 Documentation/trace/ring-buffer-map.rst
 create mode 100644 include/uapi/linux/trace_mmap.h
 create mode 100644 tools/testing/selftests/ring-buffer/Makefile
 create mode 100644 tools/testing/selftests/ring-buffer/config
 create mode 100644 tools/testing/selftests/ring-buffer/map_test.c


base-commit: 29142dc92c37d3259a33aef15b03e6ee25b0d188
-- 
2.43.0.429.g432eaa2c6b-goog


