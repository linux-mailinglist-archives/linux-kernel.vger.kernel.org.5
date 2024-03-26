Return-Path: <linux-kernel+bounces-118738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9B888BEB5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12E1C2E6300
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B806CDCF;
	Tue, 26 Mar 2024 10:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I9P26f9W"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937B06BFA9
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 10:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711447478; cv=none; b=iBDA01vi4NS6Tgn1GeWlddL4bvnQeY0lNNZrQV+Cj17aq+r/IamtwNPA0X/Xv4F6LAmJMZMqyH3c1CWn62u+DgTIfTj2W/d7lp212eHdyFVpfgMa+MqTK8t73m/XOwOUfe/eDAg2iqXlalmHjEBKbJgN1zEouLoDPBxNtSH6J4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711447478; c=relaxed/simple;
	bh=f5mervW7JwMqtuacV5u33z0c+ZkKALYygYqRjTTFdEY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YbiWdITHw9e36RRGyg2d9yNE17TIlRLudIVR0/msZQJhhamENPOXkbaQez3QyrnVyc/3wHZNuVX9LvZ6gOuWnx0SuYvhAWMG6GJ6uh3FWhZKZT9Vc3Nk9g9maXe8c3OK6JVWPt8snaA7aZnN2HvC869EgRMOHO5L0DzOq85T83c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I9P26f9W; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b2682870so8589795276.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 03:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711447475; x=1712052275; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VyUYUDwDC6lCJYWgpyLnykCyTck5nvq4IGoYsSlman4=;
        b=I9P26f9W42M0Q9qCUHOi+9Ef9/bSl7r6+9Tucr3kmK4y8/1daL9U8nRr8R7cXbJdSF
         UGE6q140BC/F2Mw+cYfJKh7T7m7Ox/eUTaEgB8hqyHv1MXojtfgjVqYcePEKta/rTKzU
         g8uE74lznnzvWH9V/SnLRWt7OPYmWPaihb9YUmElsRCUaXvKgrFUFqCKGMvNr9f6KAPC
         vxYKqG1ccRgD3va2YkUeLTo/oxuRZ5ulHQF0XxAKfL/DnguGeV/+LrSfRF6pkycRneNa
         ti/2K1OMHYGhGvCx5tHhzAFCWWKgfUFDG6QKMjKLp/s2OJRtMP9+0l1csfUhyKajZmcr
         qEew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711447475; x=1712052275;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VyUYUDwDC6lCJYWgpyLnykCyTck5nvq4IGoYsSlman4=;
        b=OP0AfBbhgB1HkRdTJy85Z48cRS1hZ/SU7oxEO4jsREKghm1AOqQT9cI8NDY0u2tZj0
         3WNe39XfJvbOQVpwJL9wsktSwW7Rjp8XeBSjI+WBigXtgQJblxXkhFO+MXxh6/nqtWqa
         poiexF1FtWrKMQpNUUV1AXNMlrXCVv+CI7f4aTjB/2wnCWpwQlHwiE9XS1w+IfM/aCyf
         10YMRRdHlyS3jGYdryyIUEGULbn2T9zQ5wtMK87OSpxSmXt+92F4TxI+qMnydWXnC+sd
         rC3LwitzYF8rC3uOI/z3IEXZ4jTCtHWPwY3OZS7pc0x6OUjatMvlpsbsCd+CmhuFXF23
         vQdw==
X-Forwarded-Encrypted: i=1; AJvYcCX1loEHXPDVvUR690/UQyCi9dtCrnTbxwl43d5iNJ/mbvjdNCa5CFwPaQoE6nYJar8fubtaEEGp2J8wq4R0HnfzASeEBu3/xTG/He5i
X-Gm-Message-State: AOJu0Yw4D6vCCmrufjkMygzbFrG6FS85FR1NDtvGC+yIlRegta/JKb8F
	GanPA/iy49TtPCisQJTeBCtcKOHKBCsKZ2JPpWF0z7w/r7EDygQFBNsbH+ktkwcrDue1DGRS78o
	7E1x+uBwFc/wVhMkIEQ==
X-Google-Smtp-Source: AGHT+IHgLUq0j1df9+PiiUajP5L4I97m2lIkGUW6cHJevFr7Mnz8hYtJ9sxrR9ygJqZl3MwodQNWLN7LOMP6I6jv
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:6902:2503:b0:dc7:5c0d:f177 with
 SMTP id dt3-20020a056902250300b00dc75c0df177mr2934431ybb.6.1711447475702;
 Tue, 26 Mar 2024 03:04:35 -0700 (PDT)
Date: Tue, 26 Mar 2024 10:03:29 +0000
In-Reply-To: <20240326100330.1321861-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240326100330.1321861-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240326100330.1321861-5-vdonnefort@google.com>
Subject: [PATCH v19 4/5] Documentation: tracing: Add ring-buffer mapping
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
2.44.0.396.g6e790dbe36-goog


