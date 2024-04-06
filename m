Return-Path: <linux-kernel+bounces-134048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BD089AC82
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 19:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F213B22B96
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 17:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575E44DA11;
	Sat,  6 Apr 2024 17:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hdqPCg6g"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80544CB37
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 17:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712425040; cv=none; b=dCwGA6RMSfjOtZZsEs4MzwfINk/QUwD4y4X3bIQLv0cF2bs8N8DEaWV5OE2riB3eOoplOl8b7KW0sCNbmbb+gBj8d0CXR+u/lNHMHJUchcoFNuRlLQ/3XaPqBCJ0nWpBUkb0y+FP6a9VvuomOz/RflOSu1YYlYh8Ew0Fn92dVgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712425040; c=relaxed/simple;
	bh=ZXKJqGIpOeNVjmTs2kjmqOaHkG1DnLLt0+tv6mFfRmc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a1oDJUyS8HwbwvtfOfTlVmPgkjFdd8YKUjI5O2MIdaZ/VIHsV7pB/cbh3lwIbWa0UMsZDQOTzzEILXKCntEMAJkpB6+vDzl2xgMwHDdM2oY2szV+AfAkPFOndkH3HnKk2Eb/TzKSXoHpNrDLYB/qz6ty3UdkHaZ3RF7d9p3XhsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hdqPCg6g; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4162ba19021so13017985e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2024 10:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712425037; x=1713029837; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ty21zwhpIK06gSNfvHnlQi0EabGuqqhLB368ZO8Z3zI=;
        b=hdqPCg6gevaNSIQmD2CeJAUDGTfne+gESGpgLQG5JXs+5NvDx2IWbCXlRYPaz6ctRq
         wnFBPNKFwp7CLrLAZawczAtGE9Hue6Qg1WyssBG3AxluvMJp7N9y2rNexrZB3EUF1zKY
         NwiZ0idxQkKVKr29gUWaLKcHluGsrD7Q+SzVsz+xPIt43SmUV0mAJBiZ+6zrA0RdINxk
         NS2VDzWNgm+UJHJOTUhs3PTVrDHkgFzL0HRSvOcQbHarVAtq91EyIc8cz4m1hbodzHEY
         eAWjmqBl5N28+D8w87KOot9jXGe/6iviXqdlFD86h55ItGwe4zU8wsfT3F56jJcmfr8+
         Jktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712425037; x=1713029837;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ty21zwhpIK06gSNfvHnlQi0EabGuqqhLB368ZO8Z3zI=;
        b=RY4DyS7kuqY+t6Jxc+NvuNDKOf9J+bWTYb9iVUwi7v53mpr+Tnev13i3Lh/+7MsHvh
         rb8UlzzBJXeNcnXFpnjWzLVpzbyQkcv+mzh58RAanNbmc+N+bwtZuTD9p08c2CaheTnk
         E8xyTZnUHzYrPSmxJcBnZlebCaW6OfR8saEpNSo5mJjYSN4HlSA/JNTsw2KWJVC85JqY
         rTu6yn82WS4yqta9YDywHQBn4eWchHM+Ec9lItYkqYtyKTmOdECwJ39TGVAqQJ3c8Lqd
         iZ1w6r7ZmDe9dhN879c7tBghVBr0KLZa1wVzRb+lhMLiFvdgDZandChPAPlR8fKD7Xui
         tAFg==
X-Forwarded-Encrypted: i=1; AJvYcCWmlGZBF5HhvvpWauLvH8yM41ndHKbPKrAoIiAC7l+6O3sFzjutqyZ2hzEmKXYXM1jwZ6AVu4xseduKp2ceQpcKaoGAgste5/LfkyKW
X-Gm-Message-State: AOJu0YxBkAgF4oN6z2+aIP8BWb2Ynlbu8y/6TOs/ULrqUW18ML+3Fnn7
	XjP5QOmWyVX1Zyh5YVc8GjfLFYaMgap6icyYa8mO72J0XMVdlFNSG68MSJKFQ9qQFhtAqJaJoY6
	BME8LTJ4dvMVQSxzutQ==
X-Google-Smtp-Source: AGHT+IFReF1ERsWWIPgz1JSJrIwd0rDbnVD1YVq93tsvm6NKhHiCRiCXvYIWyx3ScIJGSHQhE/4nxxXtdOFV8TRO
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:600c:4f81:b0:416:43b8:c04a with
 SMTP id n1-20020a05600c4f8100b0041643b8c04amr2546wmq.1.1712425037413; Sat, 06
 Apr 2024 10:37:17 -0700 (PDT)
Date: Sat,  6 Apr 2024 18:36:48 +0100
In-Reply-To: <20240406173649.3210836-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240406173649.3210836-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240406173649.3210836-5-vdonnefort@google.com>
Subject: [PATCH v20 4/5] Documentation: tracing: Add ring-buffer mapping
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	rdunlap@infradead.org, Vincent Donnefort <vdonnefort@google.com>
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
index 000000000000..8e296bcc0d7f
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
+description. It is referred to as the meta-page. One of the most important
+fields of the meta-page is the reader. It contains the sub-buffer ID which can
+be safely read by the mapper (see ring-buffer-design.rst).
+
+The meta-page is followed by all the sub-buffers, ordered by ascending ID. It is
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
2.44.0.478.gd926399ef9-goog


