Return-Path: <linux-kernel+bounces-35162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CD3838CF5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D1FA1C2331C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE85F5D737;
	Tue, 23 Jan 2024 11:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eDtJL47Z"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8D15DF11
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 11:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706008097; cv=none; b=hfi5jQa/oFS0sUaIjHUwzf0YF8ZIaaFcdfqduMMTP2eFQces+FzTH6pEvkTGZebmACjGrG09n0uotr8M73n5CgTVAxP9/Yhmm97AMjRSkOkXwVURW9JJgYLwPpps46Cl9pg8JuJ+Vns45UYHoQcrIxlSjW1lI3oMuLan0cHYgsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706008097; c=relaxed/simple;
	bh=2ydE7p4I+jn1AqXuKc/xAoa8ZK8YfR3uygNBDatj3o4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OOpKP66XJzVuaFVgE1tkXQ8xjAMooisVNak8ZVh9kIeMusrP/r1MCF5Sk52ntc3rx9z9XtzF67rVdhHcEXXdSO9fZjjretEzBmnrOLhD5BUOFZCT+dCJEdFVTS4bMoFz/c9DhCDGJsikMp9wehWdiy7l1BCkOPGZWU7WxPXf+YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eDtJL47Z; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-337d7158aa7so2337161f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 03:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706008093; x=1706612893; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W7oPXmEt7YsbEzKepN7rYv6YN542PMGBpLDCQVs56QI=;
        b=eDtJL47Z++DAwOfHG1DGRJOoXqG7PzQBIMI8F89Xp6bYqUNkogJ6JuNouzMXS41h+s
         oDoGX0CziDo+iE8w+TaWUs6smSuwSJueJbcLfai6tJUJtLvJbkxcfbS/Jg4vWDZCsSKi
         I13ZrZT3xXnQGRrmuDYySQfhQWX45ayitTMvUDXLQ4zvozTFrretALDq//EmInF3WFR5
         RdGURbixEtoc8AzLz7JvBl52bB2pnR7LD8ELiOcZgynLgWVcGcBr/magEnVxk4XkV658
         17fdV65mZ4LUfc6cnEbo4rINAD5fGtWff1lKKapH9S+mrj0NcUd8okcOZuwXlCT4mGh3
         C8Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706008093; x=1706612893;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W7oPXmEt7YsbEzKepN7rYv6YN542PMGBpLDCQVs56QI=;
        b=nyEdEr+XUHDoFY7b6Xyv/r/Hu7naCj2MkeOx4NsrW5jn+UbX5x51P6UEHVByyxVLq8
         lQl5wOhr7ldWLrPPm9nYs0lfJTpXjMUo7PTA4rZV1DlcLb/dV4PjvoZp9+Jv5jZ8VbOR
         nxKXI+7LuJ/tbSagg+hKAPJZ0IRRZh69vu+Ipxvs4cBeOSPXMh4QpgxhmUC+QTRJOhcg
         zd1q/sMPBtKXfdtgcqbBAH3KKtgA9LnxNBDESZi+1q5cQuOrl6sa4cp0O3d6DENXDfs8
         7dMY+FpK7WwLFvfiyuG3vqNwUs3KEZSgXl7zRpyIBqFySxaAcr7In8Lvc5Q3F3XsNujg
         uXHg==
X-Gm-Message-State: AOJu0YwOx8w1F/gB0COh5hgbGG7+V/npNSGALYWIPbj48AFErU17iFju
	jzhprRrPO/xUW49gz0AflE2wDvkTE6YXHOTisLodffFbpdC3tNRXEzMkskNa0dyl6lrq41lxJ1v
	uvWi5V/D60OwTEuw8hQ==
X-Google-Smtp-Source: AGHT+IHEJGbZrETgw559I9/W3u+W2YGFU+Oe4jSe7q7hW4mNL2TMFi4oaAiUTwtfI2L+rZVdaj4sAlJfb2Z/KvN4
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:6000:71a:b0:339:22b6:b56f with SMTP
 id bs26-20020a056000071a00b0033922b6b56fmr23400wrb.0.1706008092731; Tue, 23
 Jan 2024 03:08:12 -0800 (PST)
Date: Tue, 23 Jan 2024 11:07:56 +0000
In-Reply-To: <20240123110757.3657908-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240123110757.3657908-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240123110757.3657908-6-vdonnefort@google.com>
Subject: [PATCH v12 5/6] Documentation: tracing: Add ring-buffer mapping
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
index 000000000000..7d7513180893
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
+the meta-page is the reader. It contains the subbuf ID which can be safely read
+by the mapper (see ring-buffer-design.rst).
+
+The meta-page is followed by all the subbuf, ordered by ascendant ID. It is
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
+                printf("subbufs_touched:%llu\n", meta->subbufs_touched);
+                printf("subbufs_lost:   %llu\n", meta->subbufs_lost);
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
2.43.0.429.g432eaa2c6b-goog


