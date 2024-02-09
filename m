Return-Path: <linux-kernel+bounces-59210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC5284F344
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 11:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2622281948
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80A66997D;
	Fri,  9 Feb 2024 10:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sum5qYrR"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B8169970
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 10:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707474133; cv=none; b=W3vEy6VuBHDDtgpONeYnzLA1DO7S1X8jcDssUQ9fD2db/gVuBjocvNkrMrXfJJepcMynZl1Yi1jHuSj3bDTetrW/z4dNdMyJzc9OdbgSuWMpoB+LV3wOObnxXTbwlZYsm36lPJPMeaVBPtMarjy7KuYJ67GZr/lgdLbBXTn7XXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707474133; c=relaxed/simple;
	bh=qxJhumotfzjeTVZ55n5PKmjmcyo982hoJ1QPQeDy8UU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uBLpKG+2fhrrXrmpZ2svQypjWlK5rRf/x35DVnXj7XRj4k8ZM6KWsogYVRYf3+5/PPw9q4utQnkZzS+iXbKlYlzsTp0W5fkzluazPrfBf7D5ZYuCMfaLG8NZOP9ji+HBHFs2Eo2iu9emtbH+gUpR0hiQQz4tBKXrH4dewcfE3zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sum5qYrR; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5ee22efe5eeso16775967b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 02:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707474131; x=1708078931; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ykp0H7Zv6C2KOkWrdkAm5rJrFsTMhgnYXj5UC2NL3Ic=;
        b=Sum5qYrRAqPYgj1icsn/qLF6v20zis6BMndLYug1E7ILHS2DHmX5olriOH8eiGJ/eg
         LLn0WSnaV8Nrda61XrqKRju3WAzl69FFOqndXldys32Vlw8jnMxcABQ3ywXjz4xUIpTA
         pczRiUCwZrDRpt/IUXrR7NcWwvruw618WjFjkzLYD4UnDiTzx1AP0X+vdupbfEdmm9t1
         pTYV+EPAx+FEtHXZSFkDsOO8Z53BxbLrzEaA7WygNhlkLymmgqXtaiobEqDBVG2e1PJr
         eFhan8zrysmgFfOgiHwV/aA3Lq087tWSxY1f82exQ9GlIcqWLia/CLPNOUQWa2i7BEMC
         iqTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707474131; x=1708078931;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ykp0H7Zv6C2KOkWrdkAm5rJrFsTMhgnYXj5UC2NL3Ic=;
        b=C8NvfMWE+fRkmCHylCw1jO10vNsZ//nlvq6f4seSz4Bb3ZH06rwMiJen0Y5s0nPkDO
         ETE+5kLThr412uOK0VVElvWbSDlqO0iJgtIh+dIy+Xo3WfFyCvw6d55x4448VaBl2uyK
         3Eg/nnaIESBNRCXH8csfgb/Gl71StnRLME6Qud6pej9C3IcE1+85zKyir1D1Zwt62rzc
         6Hb+/H8itOTfdXTnQjOUi0B3UB3bW1y11yZpuqcBFe7zMwhSH3x1Q9tsSpktEreRM0EV
         3TT9Mjtd/JkQMhihRJ5v7/kJEZkgsreBJCj7ztOhIM5dK+wAJZijEyUGf1bmtSXl3POr
         pUgQ==
X-Gm-Message-State: AOJu0YwREJ9HyMJJ6D8WTeYFeQrpah8NU9PTZRVkWr1oI4Ad2Da8ymZh
	/6dnVHbl+AEcBmB3i93G7aTp5FD/wunCv9YgJdCSLXiD4GRM45ABFbCeZDcFww0ALMMMC4hN9O/
	FB2OMbRkxGrSOJ6CPGQ==
X-Google-Smtp-Source: AGHT+IHenUou1H2Fm7+c/27dCYqsj3x3wxGdPS2prYEzdDzDon3dWjp5qzuJb8jAol+N7nDfjplcTBz/YwqYgMSm
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:690c:368e:b0:604:b83:9cad with SMTP
 id fu14-20020a05690c368e00b006040b839cadmr177147ywb.5.1707474131271; Fri, 09
 Feb 2024 02:22:11 -0800 (PST)
Date: Fri,  9 Feb 2024 10:21:56 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240209102202.649049-1-vdonnefort@google.com>
Subject: [PATCH v15 0/6] Introducing trace buffer mapping by user-space
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
 Documentation/trace/ring-buffer-map.rst       | 104 ++++++
 include/linux/ring_buffer.h                   |   7 +
 include/uapi/linux/trace_mmap.h               |  48 +++
 kernel/trace/ring_buffer.c                    | 349 +++++++++++++++++-
 kernel/trace/trace.c                          | 221 +++++++++--
 kernel/trace/trace.h                          |   9 +-
 kernel/trace/trace_events_trigger.c           |  58 ++-
 tools/testing/selftests/ring-buffer/Makefile  |   8 +
 tools/testing/selftests/ring-buffer/config    |   2 +
 .../testing/selftests/ring-buffer/map_test.c  | 273 ++++++++++++++
 11 files changed, 1034 insertions(+), 46 deletions(-)
 create mode 100644 Documentation/trace/ring-buffer-map.rst
 create mode 100644 include/uapi/linux/trace_mmap.h
 create mode 100644 tools/testing/selftests/ring-buffer/Makefile
 create mode 100644 tools/testing/selftests/ring-buffer/config
 create mode 100644 tools/testing/selftests/ring-buffer/map_test.c


base-commit: ca185770db914869ff9fe773bac5e0e5e4165b83
-- 
2.43.0.687.g38aa6559b0-goog


