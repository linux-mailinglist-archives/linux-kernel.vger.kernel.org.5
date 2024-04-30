Return-Path: <linux-kernel+bounces-163836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CADBD8B7302
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED5751C22A1A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8593912DDAD;
	Tue, 30 Apr 2024 11:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nI/VL3CY"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D3F12DDB3
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 11:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714475651; cv=none; b=NzNG4MJXvETNPcb6aj4RvDtaTAYgMD6u2mHvyRB4TkHhKml19SKm5dC6TbfJXeEjhqHNW1AcwItwSigt/8VusUPggS6+x4OoK2z+eBkn7gQnI/BP3MHBgKhTK3E8HI1Cwi/UuuNTF2ziHBa/oXiRkS2NVBOT/idndXivSBC77FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714475651; c=relaxed/simple;
	bh=nHh/TTjK2tW0sUwPgbpncHpLmKF71Gsdpp0iLEYgt+E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DbxWo99pTEHTTH4e8pTZz8Uk7RcOJ/LkX2UCRsP6tH7jiYwzAoZ9/cr7KoT86BRhoDlGElKq431V3NklZ6IJWxxNUQpFHG2kePbBU9FnIJkuenQMKp2cLbItXf1jyMheVV2Qx95EpQ4Ds9syj6pGr/BeC86OFJa0xknHo1Z+a3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nI/VL3CY; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-41c05442f92so13674615e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 04:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714475648; x=1715080448; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5feaOC8gyTsjpelUvOVH7lOOqHGrllvmXVDESYI+Fsc=;
        b=nI/VL3CYQVGuUYdqCSXzmTVQ0h7hokk9gTeENYdcLD8L/SWO+oPIwJC8uidEaRkQoI
         dez0xrr7vJs/c+dBR7yWH0/Jb2xbc2deJyrwLhtaglCYzWqC7F0WA/CT1yEWI6WlVb+7
         2rQdTJcAM5Y0rnX8kaQVq8CYxtXcrKviOjoSd0/oaaTVoBGU+X3nR38tJtX79wRxk9HL
         z6KMQSOgO4yH2KKQWsV7n09W1NavoZd95WlG8N++uQAwFb+3o4IOOIf+4clE82Yl0Lhy
         dNbMe/FE5eCurq0oDB6YxDPLC7TfMJWqcrUbTHzrBFv5h0oroV3PVDUa81KbjIiyDl9X
         hPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714475648; x=1715080448;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5feaOC8gyTsjpelUvOVH7lOOqHGrllvmXVDESYI+Fsc=;
        b=L2CMX0C1PPNGpLbGzEZ7lpa+8rWKS8X8GQGibVnx2mdEs2nWk2qHrO5ShuII+/MFgG
         paw1PaIM/Ranxgv0DQ96rLoHMdeYDQHO33dR/dP6M4wAfAbwTVyw96Zqqdco9hb8vJx8
         BAJnTDxB/51l9SEhzFsURv3hKzfXUVOie94DGjXNTpIFrSYPfH4sHdvSB0rSOkF7dHV2
         p6Wvk2n+K1imcWM7A4trb0l028l682ww07aQTcioAyKr6Edg1kJ5UuH6Rq5kGNzQVI0t
         7PWIfPC7tKUKg8FLE434sTocOh+yLOFxOQbXewVgZOovmyUHAjWPTZ1ZxhWK4+Yi9DKo
         Lgxw==
X-Forwarded-Encrypted: i=1; AJvYcCUG819Fjd1aPrpG1ej+ByLK+qbnLF/pkL3sHMlSLCBHKvedz3RStPjmKAQxGu2wXZUHHDK38zqnh2y8qPopXbA24OCQlWuw7EvqGaAG
X-Gm-Message-State: AOJu0YxwovYqVOnAbB1+JnyjvF3xOFKS5iNcwwI2ytTes0rg44Rurh5D
	8nM0gf7voCsKLN+RsNnpCN1jI/WEQLlVqHVDIymtDtGhpYhC2aS8qPCntEfi1i0tJh6740m+ZHz
	1ZFvvs7RHRJjcHnYw/A==
X-Google-Smtp-Source: AGHT+IHdQZNX98+CW4WPw6oiqnopgWVrn9BdwGx8dosY4zm7CCJzu00jhkxhfR15vrmF9r6Xrpm6mzzc25mlCAiT
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:600c:1d26:b0:418:37e1:3d43 with
 SMTP id l38-20020a05600c1d2600b0041837e13d43mr137262wms.0.1714475648416; Tue,
 30 Apr 2024 04:14:08 -0700 (PDT)
Date: Tue, 30 Apr 2024 12:13:53 +0100
In-Reply-To: <20240430111354.637356-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240430111354.637356-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240430111354.637356-5-vdonnefort@google.com>
Subject: [PATCH v22 4/5] Documentation: tracing: Add ring-buffer mapping
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	rdunlap@infradead.org, rppt@kernel.org, david@redhat.com, 
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
2.44.0.769.g3c40516874-goog


