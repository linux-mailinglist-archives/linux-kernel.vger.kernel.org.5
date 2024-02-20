Return-Path: <linux-kernel+bounces-73673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0120385C5BB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABC44283BD0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF39E14F9CA;
	Tue, 20 Feb 2024 20:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TQiHoq5d"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6B614A4F2
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 20:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708460609; cv=none; b=NIAeBe+ePdWvGSyZy5TnB3UNYxcXF3mbBJU8N6RhmRHayhbHLZ6ZAt6RzWtrO9cmplz1jgGrGlaH/BRAGi5+mk+Rf80WkxrXJBoOPBNatyIxsZRpLhO1FJvMwUYsf6JrLVh563ststxzzg8C9UDAOx6iNfLer+CqgOEK7d+Xq28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708460609; c=relaxed/simple;
	bh=vgqyuul3SkiL5frR1s4ETodUVGABBxLVvcWnLo7TXos=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=efRTjDBa346mHrtQaaousxpWccTHBnm+8uCZaRfQOk0uxU9f8uVWhPFd2JgYCroQSUDUhh4hphfTqoy7xnoqIkwPG/caSW7q+CUGeAw/3ynEcKhl5FBnam+HwoXHdJfNEc/yJBC/+U+GEnMhLUF0cjK/JR0OONGUXlKMwacw83E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TQiHoq5d; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dced704f17cso1509953276.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 12:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708460606; x=1709065406; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HidXxbIzcx0OHxEMN4uJVlbdWn044WNRaUBnHlFCLwo=;
        b=TQiHoq5ddcVbet04mkRI2uNVzDyh/GVxx8niwi2PHgKmuF9EssWF6Ix03uI5QvGh6c
         aVRT060jmege+7LTjWTYXn+ZHt+C9HnrODlWphxHPRN9eX4PTVXm9POTPlqy9YE/DIyQ
         y4By99q732nEkSMmfFrEL2rCmtifQaPxTrNMEDCJvFPl1/bzDpr1wJ/7ToOVDHESmoaw
         Ln/OXysh/vcRj+An5hzuuNW3hwC/r2xjDKDfM2jxZEN5KnKO0hv9bQnUf06ODwrTPYmh
         otmCfJfAtLae1ZMGcr690QC3FNozdKU4jWPoJjIxXeGF3aGlZjIBt7A/cTHiqaaDZDo9
         oxqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708460606; x=1709065406;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HidXxbIzcx0OHxEMN4uJVlbdWn044WNRaUBnHlFCLwo=;
        b=ATkOAoVZG/lhcVhq8Wc2JRx6EEg3g9jLiREXP8pnMdbMyVhGpP+0VII4LImr+F/V/1
         lCQglr+XSZsDnZdRKx8rRx1+iVsZmEpY+D9WhJWMJkyIRsDg2uWQJgskXCWyKu7+qSON
         T94ISEIfBYug3/sGi4OkJ4PJLkIWOLwmYNJ6PMkeCfBbqLjxIGrpxzbmqpTjCrkdGW2v
         551UAO1ILvlbIHfuqAlnsmHWRwGg+pweLpPuV80U5Drw7LI0vGJ+31gRUgX7usNSl+tR
         bIJ9KTkivi1UvwmNHILfntDz2KuLH0GOVGtdP7nN8IGMt/z5m8/D4li+ab2gKTsi62kN
         2xUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxR/mG+geUdUKp6s9/5698bFcpEciH134Kb0XdBD20pKRqg+2TBrvoqN9UlgsbVCKT0wE1Cv9qktPfcn+YkB+swPg23IM5plxrtlnI
X-Gm-Message-State: AOJu0YyjAdQatIkmQ9YgKjlUZBmoJ2mxxmEhbGFZaiK8hPCO/IFuPVmn
	fuOScdyM2nVAIf1Nm8avFszssDXT9BEftlnROQYOLwj7sAFW481b9+SgNU/x/ZItKXtyi3iaPi8
	FSD8vV2SkhIy918cZ2A==
X-Google-Smtp-Source: AGHT+IGbTdJxhHjC2aVIq5O+3Qg5kVShJ3co5ILVQ03C7eQ0wwr29B2CNTSs2RMKx80ldT0cPY0Q5kFZmio96K06
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:6902:a8e:b0:dc7:6cfa:dc59 with SMTP
 id cd14-20020a0569020a8e00b00dc76cfadc59mr577243ybb.4.1708460606438; Tue, 20
 Feb 2024 12:23:26 -0800 (PST)
Date: Tue, 20 Feb 2024 20:23:09 +0000
In-Reply-To: <20240220202310.2489614-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240220202310.2489614-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240220202310.2489614-6-vdonnefort@google.com>
Subject: [PATCH v18 5/6] Documentation: tracing: Add ring-buffer mapping
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
2.44.0.rc0.258.g7320e95886-goog


