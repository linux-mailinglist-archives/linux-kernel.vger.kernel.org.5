Return-Path: <linux-kernel+bounces-25293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B113E82CCD0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 14:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B783284A3F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 13:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A656321113;
	Sat, 13 Jan 2024 13:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePDXl8Hn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D818717554;
	Sat, 13 Jan 2024 13:36:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA540C43390;
	Sat, 13 Jan 2024 13:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705152982;
	bh=KwWlHa+r+/FAyunmRdmhSZNBRluZIk0FSNu0g26o/fk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ePDXl8HnuvFr27V6A837IHl55K1RpcxXO9+HOuhMEFD+lKVWGxL4QEd6kh201XJhp
	 3tvbWJb2oh/6XS68ZxTZFO7ANa9QnQt5ALwk/iQYTwK/OiYKVRznM7s9LsKRrv7f6+
	 Kjp3hk+nMv9R+izm+1ZRUm+54eWQFw0OYG/0aKY8FoLuMx9h+wVYF4A71aFcqNBj2U
	 ZRLmv2zlZan5t1NzGdGSyqKn3xEdzkPIsJ7NhTAaBW9o+qW9w5zIh8Gygn+Pu107Op
	 fz3VBMNyzeZ2dsfRi651qlyte7Wx+rHPxsXpZf7C1bCRDTr1FdYzfyGpw3RAOegalJ
	 bTaLbNRtxG1Lg==
Date: Sat, 13 Jan 2024 22:36:18 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: rostedt@goodmis.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 kernel-team@android.com
Subject: Re: [PATCH v11 4/5] Documentation: tracing: Add ring-buffer mapping
Message-Id: <20240113223618.2532e413d6bff8bb140ef5f1@kernel.org>
In-Reply-To: <20240111161712.1480333-5-vdonnefort@google.com>
References: <20240111161712.1480333-1-vdonnefort@google.com>
	<20240111161712.1480333-5-vdonnefort@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 11 Jan 2024 16:17:11 +0000
Vincent Donnefort <vdonnefort@google.com> wrote:

> It is now possible to mmap() a ring-buffer to stream its content. Add
> some documentation and a code example.
> 
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> 
> diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
> index 5092d6c13af5..0b300901fd75 100644
> --- a/Documentation/trace/index.rst
> +++ b/Documentation/trace/index.rst
> @@ -29,6 +29,7 @@ Linux Tracing Technologies
>     timerlat-tracer
>     intel_th
>     ring-buffer-design
> +   ring-buffer-map
>     stm
>     sys-t
>     coresight/index
> diff --git a/Documentation/trace/ring-buffer-map.rst b/Documentation/trace/ring-buffer-map.rst
> new file mode 100644
> index 000000000000..2ba7b5339178
> --- /dev/null
> +++ b/Documentation/trace/ring-buffer-map.rst
> @@ -0,0 +1,105 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +==================================
> +Tracefs ring-buffer memory mapping
> +==================================
> +
> +:Author: Vincent Donnefort <vdonnefort@google.com>
> +
> +Overview
> +========
> +Tracefs ring-buffer memory map provides an efficient method to stream data
> +as no memory copy is necessary. The application mapping the ring-buffer becomes
> +then a consumer for that ring-buffer, in a similar fashion to trace_pipe.
> +
> +Memory mapping setup
> +====================
> +The mapping works with a mmap() of the trace_pipe_raw interface.
> +
> +The first system page of the mapping contains ring-buffer statistics and
> +description. It is referred as the meta-page. One of the most important field of
> +the meta-page is the reader. It contains the subbuf ID which can be safely read
> +by the mapper (see ring-buffer-design.rst).
> +
> +The meta-page is followed by all the subbuf, ordered by ascendant ID. It is
> +therefore effortless to know where the reader starts in the mapping:
> +
> +.. code-block:: c
> +
> +        reader_id = meta->reader->id;
> +        reader_offset = meta->meta_page_size + reader_id * meta->subbuf_size;
> +
> +When the application is done with the current reader, it can get a new one using
> +the trace_pipe_raw ioctl() TRACE_MMAP_IOCTL_GET_READER. This ioctl also updates
> +the meta-page fields.
> +
> +Limitations
> +===========
> +When a mapping is in place on a Tracefs ring-buffer, it is not possible to
> +either resize it (either by increasing the entire size of the ring-buffer or
> +each subbuf). It is also not possible to use snapshot or splice.
> +
> +Concurrent readers (either another application mapping that ring-buffer or the
> +kernel with trace_pipe) are allowed but not recommended. They will compete for
> +the ring-buffer and the output is unpredictable.
> +
> +Example
> +=======
> +
> +.. code-block:: c
> +
> +        #include <fcntl.h>
> +        #include <stdio.h>
> +        #include <stdlib.h>
> +        #include <unistd.h>
> +
> +        #include <linux/trace_mmap.h>
> +
> +        #include <sys/mman.h>
> +        #include <sys/ioctl.h>
> +
> +        #define TRACE_PIPE_RAW "/sys/kernel/tracing/per_cpu/cpu0/trace_pipe_raw"
> +
> +        int main(void)
> +        {
> +                int page_size = getpagesize(), fd, reader_id;
> +                unsigned long meta_len, data_len;
> +                struct trace_buffer_meta *meta;
> +                void *map, *reader, *data;

nit: this example code has a compile warning.

rbmap.c: In function ‘main’:
rbmap.c:18:21: warning: variable ‘reader’ set but not used [-Wunused-but-set-variable]
   18 |         void *map, *reader, *data;
      |                     ^~~~~~


> +
> +                fd = open(TRACE_PIPE_RAW, O_RDONLY);
> +                if (fd < 0)
> +                        exit(EXIT_FAILURE);
> +
> +                map = mmap(NULL, page_size, PROT_READ, MAP_SHARED, fd, 0);
> +                if (map == MAP_FAILED)
> +                        exit(EXIT_FAILURE);
> +
> +                meta = (struct trace_buffer_meta *)map;
> +                meta_len = meta->meta_page_size;
> +
> +                printf("entries:        %lu\n", meta->entries);
> +                printf("overrun:        %lu\n", meta->overrun);
> +                printf("read:           %lu\n", meta->read);
> +                printf("subbufs_touched:%lu\n", meta->subbufs_touched);
> +                printf("subbufs_lost:   %lu\n", meta->subbufs_lost);
> +                printf("subbufs_read:   %lu\n", meta->subbufs_read);
> +                printf("nr_subbufs:     %u\n", meta->nr_subbufs);
> +
> +                data_len = meta->subbuf_size * meta->nr_subbufs;
> +                data = mmap(NULL, data_len, PROT_READ, MAP_SHARED, fd, data_len);
> +                if (data == MAP_FAILED)
> +                        exit(EXIT_FAILURE);
> +
> +                if (ioctl(fd, TRACE_MMAP_IOCTL_GET_READER) < 0)
> +                        exit(EXIT_FAILURE);
> +
> +                reader_id = meta->reader.id;
> +                reader = data + meta->subbuf_size * reader_id;

So here, maybe you need;

			printf("Current read sub-buffer address: %p\n", reader);

Thank you,

> +
> +                munmap(data, data_len);
> +                munmap(meta, meta_len);
> +                close (fd);
> +
> +                return 0;
> +        }
> -- 
> 2.43.0.275.g3460e3d667-goog
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

