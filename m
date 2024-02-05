Return-Path: <linux-kernel+bounces-53020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6155849F90
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 145D81C22ECD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C63E4595C;
	Mon,  5 Feb 2024 16:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cl+6aiHP"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D9344C92
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 16:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707150872; cv=none; b=caPiyEs9Q6dNUOSXCDrYv70acr18Toc/lKmkegnOpcBreoTTeY0LPJYj7n2uFi682YxEvzKYq9vtp1DcmfDZr2L2tziUm2GtnmYgi5J0NmgBEa/7PZFW3TMItGzl2byvOUVltM/9CsHWQgZfM9g4pd3KsjT+s+NiNfVI1uv/Nkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707150872; c=relaxed/simple;
	bh=R5o/R3ePscrxpSb0R1Xmqc1DrGhjORR4iN3JNJ+9WVo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CK4ORdoUA7CoAmcADKVGKu2HxXW7wFhiGNzwAIFqxbQos4QG6OAgIEKji0/1WuB4Pll3frGytsmF3zxaIKYWPYNi/tomkYdjKk0IHOsLmnQKKPYUoA0VL6y1Pv6rvk8UDqk2BxuRHkSCN/1mepn8+J9Ook+fivoAkYKvfklWHQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cl+6aiHP; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-33b0c264abbso2436493f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 08:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707150869; x=1707755669; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MlKarA43yH71Vjbty3RM0+B2KNuJ6FxA9d0o2uA0tIg=;
        b=Cl+6aiHPjphQcAPgVl3+pCSTHRn5D/8tO0L56/m1W0O+SpgECYKuWSwOko/ASk9f+4
         5HXMEnTYgWyyZQQdz4e2KuCCBglzkayp5ByIjMAyWmYGJqcv8Nze9LMb/cMJQqPLORhL
         IqIcl/8yJtjE3AeGovMXzugBDIwIQw8VUCdYPnEzvfFo9JIXMUtdJHEo288YYCp9pGNe
         e82q6bP/tZYJ10jLw13rUeZmXTgBvQE3+o76uJZIGK2qOWIRjg420pdqxbnglKqsnL1V
         V7Wj17ANze6+hZqacUvx5byt0zyvXPC1bwpd7a92aa3U9LTx4AJJrgXA5ahiZSrQlS6B
         LKIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707150869; x=1707755669;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MlKarA43yH71Vjbty3RM0+B2KNuJ6FxA9d0o2uA0tIg=;
        b=XJu3YuKb5nxgeVqM/BVnsRj9gzSZVgmCrdF7F/m2bHi4zxxWZvetx11Rf6uZIQI7aj
         E4kt3fzXm9UKcAdHRgyaNeMrcxtDFOOeqiR8SAtdhI9lxcGNwGokZGESlwtFKoFV2IQF
         6o9tiOrTguJjiNe/9Qx83y5ERJ6iWvRLE+Wfi42GIsPRNj3BUGArDsVjUoA1Pdgf36iM
         JkGQs/17N6zUDpKniiy+2Gewt+QMUvBXNA+dcfIy9Vq0ROKpyRRUMGDoMXoTYSfLoJQi
         AumMC1m41vOtz2vGURL/7DjUDALSca8B9h229kw1CBqXGPAslhHjBx6u+D/o/MmK3pvI
         r1lw==
X-Gm-Message-State: AOJu0YxKUQHrA5K474/RBPIlzQPwpBPgj/Od9QgQWGDGyFyN5Yw1dAmT
	b24HxBCuTwH5nO0Kee1hcat/5SsR+G3cXfiTqKwHEP5X9fMwSXBrfnLWCZzQ8QV2TilgXtn/RHr
	vPJ2yWjYaHvM/WT68ow==
X-Google-Smtp-Source: AGHT+IGVz4E7mxhHLcoKbmcU/PTLiZ+tTSfUW7u9RgugbbNcM7cpHQmK24uTX9Q+2nrEc2zBtkDLeEzp8BSHTCCP
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:6000:70f:b0:33b:d17:296f with SMTP
 id bs15-20020a056000070f00b0033b0d17296fmr73wrb.3.1707150868822; Mon, 05 Feb
 2024 08:34:28 -0800 (PST)
Date: Mon,  5 Feb 2024 16:34:09 +0000
In-Reply-To: <20240205163410.2296552-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240205163410.2296552-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240205163410.2296552-6-vdonnefort@google.com>
Subject: [PATCH v14 5/6] Documentation: tracing: Add ring-buffer mapping
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
index 000000000000..628254e63830
--- /dev/null
+++ b/Documentation/trace/ring-buffer-map.rst
@@ -0,0 +1,104 @@
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
+each subbuf). It is also not possible to use snapshot or splice.
+
+Concurrent readers (either another application mapping that ring-buffer or the
+kernel with trace_pipe) are allowed but not recommended. They will compete for
+the ring-buffer and the output is unpredictable.
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
2.43.0.594.gd9cf4e227d-goog


