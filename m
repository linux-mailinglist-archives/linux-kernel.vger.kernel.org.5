Return-Path: <linux-kernel+bounces-63464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFCA852FD9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61FB31C229E5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334934D121;
	Tue, 13 Feb 2024 11:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tcMlBMqH"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E1041C77
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 11:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707825063; cv=none; b=EoWVYFrcWGHQkN0/7KkM9ATNstyQxm389ETu2OhPgrU5EqACw6pdtfcnwVwjD4GiHcs7sNbXo/smN52uwF1BkwDX44L3oM/V0j3Zq1VxoNmxr9JuXTihN/6B7wZjjpl+ZAyI9XXA+kyqeueq6GI2c2HlDR5xuwjQycLkwExdLzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707825063; c=relaxed/simple;
	bh=5mO5XahKTZY/Pk1qlWQX3Pd3/FJTnrcbSWVUWZlckIg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sgFC2c3wKeXBb2M0TyAGxXE9qsfYrgyNodBBY2KscTu+7gczQOZDfCsBEGeGg7s/v0NIAVXzbfK66JNN8NqRDExK01o3Yk1lH11FgfrT0axxQef6dPtqFnaeSEQF/PxGUQWepBZtcjvI8kQ8cFmNT8perY14lXMFmy4Ra1Q2BUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tcMlBMqH; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-410040e1fcdso24786515e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 03:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707825060; x=1708429860; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=33GrMjCaq0Ut3h1R/r8N5iPZtwZEhgImBME//MhSBpo=;
        b=tcMlBMqH6BkY+CL3O+hJ7t7j05Vb4ih7Lm6+mczyInRkeq17hyXBOtgn0AfpK2vV53
         LImUawvHQsnrbzDo6GXNjnKgFZGxCapcTvaZVAGSdMQYsNfVV8zgKKJixaG14FgWlL5l
         lnwzhkk73ppLtHxnaHtTM06n6EE+OH0Mva/LMqAPVShEzCnRs3Eqve5Nfo2FKCnkIqxC
         D3IhUMuyBqleXSvuBvKQhaYQWk4lymdzkL6bcI7xcGA/E4pa44Md1k4ng/ZUWzZ4y+PJ
         ZPotrMIcuaz/j7qm6+hHwWeRi7h6eatteFgzyGI6BFBNyYr3zU7foGSww2vwhjp0s3iD
         QbbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707825060; x=1708429860;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=33GrMjCaq0Ut3h1R/r8N5iPZtwZEhgImBME//MhSBpo=;
        b=IT3xpc+ETGUfHn8E72TYgv7khCaaDPNRDMNga9myi13t6Mdww6QGX3qXFAJ4yovjWn
         SNl1+v1HMQ6UnOCcYU0fABEHy2jKMIXeE7pjgCky7oPfVUzgOwzmnrNbuhDHTN4mcLb5
         WkW/i7XfSfs7H4yIppWZGcd91mtdqSIzcQec5liQSO4sfImMfokBfune/acTI/9sq3+U
         gepBYZRxAEO8tpHnle2df0YhH6mZx4mNF3NH97uzYnt0tGM5UBdpHrjHqogHE47hfwxP
         uQNMUDi610W6aVsOeY66UE5XScoSlQ20Id+aeYwODMG9aqsAWZrAJcTjxe3USLSmag3P
         Do1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWyD3IK2LOcfjyq+Qm3MMeTo9qQzfmJFQpqt7CiGiUwQItXQxmBgvQNlREDAxPXYbRa1clqA/w0x3FJTMePBM2DljOBtZ0cTpcwxjFD
X-Gm-Message-State: AOJu0Yx+DUy08Aid02aX0TeOCUIc/eyAhrVYigUpVu50TPJzsGjYJvle
	+5Lm/vt6K/yrHUjCnPkHbo0hb/8thJt0xqA8Of+O7HX0fOjHt2WsBajH55s8YF7EAegmdMrLX4+
	m2ZZIpmJcNr6am3I8Fw==
X-Google-Smtp-Source: AGHT+IG5eLurdGI4TEDbfPKWy4vJWwWKJ4pPg82y/VHScgGiB4s13k/v+MxrGuhNQ0okxrjvE19V0SrY1iCvPpwP
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:600c:3d99:b0:411:ccc9:7bf1 with
 SMTP id bi25-20020a05600c3d9900b00411ccc97bf1mr2323wmb.1.1707825060011; Tue,
 13 Feb 2024 03:51:00 -0800 (PST)
Date: Tue, 13 Feb 2024 11:49:44 +0000
In-Reply-To: <20240213114945.3528801-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240213114945.3528801-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240213114945.3528801-6-vdonnefort@google.com>
Subject: [PATCH v17 5/6] Documentation: tracing: Add ring-buffer mapping
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

It is now possible to mmap() a ring-buffer to stream its content. Add
some documentation and a code example.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
index 5092d6c13af5..0b300901fd75 100644
--- a/Documentation/trace/index.rst
+++ b/Documentation/trace/index.rst
@@ -29,6 +29,7 @@ Linux Tracing Technologies
    timerlat-tracer
    intel_th
    ring-buffer-design
+   ring-buffer-map
    stm
    sys-t
    coresight/index
diff --git a/Documentation/trace/ring-buffer-map.rst b/Documentation/trace/ring-buffer-map.rst
new file mode 100644
index 000000000000..0426ab4bcf3d
--- /dev/null
+++ b/Documentation/trace/ring-buffer-map.rst
@@ -0,0 +1,106 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==================================
+Tracefs ring-buffer memory mapping
+==================================
+
+:Author: Vincent Donnefort <vdonnefort@google.com>
+
+Overview
+========
+Tracefs ring-buffer memory map provides an efficient method to stream data
+as no memory copy is necessary. The application mapping the ring-buffer becomes
+then a consumer for that ring-buffer, in a similar fashion to trace_pipe.
+
+Memory mapping setup
+====================
+The mapping works with a mmap() of the trace_pipe_raw interface.
+
+The first system page of the mapping contains ring-buffer statistics and
+description. It is referred as the meta-page. One of the most important field of
+the meta-page is the reader. It contains the sub-buffer ID which can be safely
+read by the mapper (see ring-buffer-design.rst).
+
+The meta-page is followed by all the sub-buffers, ordered by ascendant ID. It is
+therefore effortless to know where the reader starts in the mapping:
+
+.. code-block:: c
+
+        reader_id = meta->reader->id;
+        reader_offset = meta->meta_page_size + reader_id * meta->subbuf_size;
+
+When the application is done with the current reader, it can get a new one using
+the trace_pipe_raw ioctl() TRACE_MMAP_IOCTL_GET_READER. This ioctl also updates
+the meta-page fields.
+
+Limitations
+===========
+When a mapping is in place on a Tracefs ring-buffer, it is not possible to
+either resize it (either by increasing the entire size of the ring-buffer or
+each subbuf). It is also not possible to use snapshot and causes splice to copy
+the ring buffer data instead of using the copyless swap from the ring buffer.
+
+Concurrent readers (either another application mapping that ring-buffer or the
+kernel with trace_pipe) are allowed but not recommended. They will compete for
+the ring-buffer and the output is unpredictable, just like concurrent readers on
+trace_pipe would be.
+
+Example
+=======
+
+.. code-block:: c
+
+        #include <fcntl.h>
+        #include <stdio.h>
+        #include <stdlib.h>
+        #include <unistd.h>
+
+        #include <linux/trace_mmap.h>
+
+        #include <sys/mman.h>
+        #include <sys/ioctl.h>
+
+        #define TRACE_PIPE_RAW "/sys/kernel/tracing/per_cpu/cpu0/trace_pipe_raw"
+
+        int main(void)
+        {
+                int page_size = getpagesize(), fd, reader_id;
+                unsigned long meta_len, data_len;
+                struct trace_buffer_meta *meta;
+                void *map, *reader, *data;
+
+                fd = open(TRACE_PIPE_RAW, O_RDONLY | O_NONBLOCK);
+                if (fd < 0)
+                        exit(EXIT_FAILURE);
+
+                map = mmap(NULL, page_size, PROT_READ, MAP_SHARED, fd, 0);
+                if (map == MAP_FAILED)
+                        exit(EXIT_FAILURE);
+
+                meta = (struct trace_buffer_meta *)map;
+                meta_len = meta->meta_page_size;
+
+                printf("entries:        %llu\n", meta->entries);
+                printf("overrun:        %llu\n", meta->overrun);
+                printf("read:           %llu\n", meta->read);
+                printf("nr_subbufs:     %u\n", meta->nr_subbufs);
+
+                data_len = meta->subbuf_size * meta->nr_subbufs;
+                data = mmap(NULL, data_len, PROT_READ, MAP_SHARED, fd, meta_len);
+                if (data == MAP_FAILED)
+                        exit(EXIT_FAILURE);
+
+                if (ioctl(fd, TRACE_MMAP_IOCTL_GET_READER) < 0)
+                        exit(EXIT_FAILURE);
+
+                reader_id = meta->reader.id;
+                reader = data + meta->subbuf_size * reader_id;
+
+                printf("Current reader address: %p\n", reader);
+
+                munmap(data, data_len);
+                munmap(meta, meta_len);
+                close (fd);
+
+                return 0;
+        }
-- 
2.43.0.687.g38aa6559b0-goog


