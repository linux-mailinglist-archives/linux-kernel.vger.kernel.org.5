Return-Path: <linux-kernel+bounces-60974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A75850BCD
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 23:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD8BB282AC2
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 22:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3471F11182;
	Sun, 11 Feb 2024 22:38:20 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EAF23C5;
	Sun, 11 Feb 2024 22:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707691099; cv=none; b=VSuvgY+kMRZJRSPfBgWHHWhalFWyeZX8MbsaXax4fzL8/TajGGu1EvcNabxAyNWGyxlWJrU0Ott/4braiD29d3Niz6Z02F2ejPtcHCC6VhqmcFDiZc07R5GmBAD7TB2eT3FvhWf99U3Rd9qL+WIv6Upv2qnu5MDA7d3Fz3XfKV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707691099; c=relaxed/simple;
	bh=2jaB1u24d4zX6XbultG3tdTc6pKJNerRrYF3/9nyfLw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OF8QNZXARowK8p1kjlT2x++K0ss15d5K6jfn2yyLPMxi8nlKxASzFsq5/TaKoQtjcNq2Yk2OeTE6uCeEGWCoNFTFrdr6IoCljRkz7V1buuY3xKaS0jshYQzVpExVrvU60wQXGdZ5tc1FbsbKnSHSgJSXDBHJ+518BOxmXF8rFYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 080C6C433C7;
	Sun, 11 Feb 2024 22:38:18 +0000 (UTC)
Date: Sun, 11 Feb 2024 17:38:12 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 kernel-team@android.com
Subject: Re: [PATCH v16 5/6] Documentation: tracing: Add ring-buffer mapping
Message-ID: <20240211173812.70c37edd@rorschach.local.home>
In-Reply-To: <20240209163448.944970-6-vdonnefort@google.com>
References: <20240209163448.944970-1-vdonnefort@google.com>
	<20240209163448.944970-6-vdonnefort@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  9 Feb 2024 16:34:47 +0000
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
> index 000000000000..628254e63830
> --- /dev/null
> +++ b/Documentation/trace/ring-buffer-map.rst
> @@ -0,0 +1,104 @@
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
> +the meta-page is the reader. It contains the sub-buffer ID which can be safely
> +read by the mapper (see ring-buffer-design.rst).
> +
> +The meta-page is followed by all the sub-buffers, ordered by ascendant ID. It is
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

Actually, it doesn't stop splice. splice still works, it's just that it
makes splice copy the data. The above should say:

	"It is also not possible to use snapshot and causes splice to
	copy the ring buffer data instead of using the copyless swap
	from the ring buffer".

Or something like that.

> +
> +Concurrent readers (either another application mapping that ring-buffer or the
> +kernel with trace_pipe) are allowed but not recommended. They will compete for
> +the ring-buffer and the output is unpredictable.

  "and the output is unpredictable just like concurrent readers on
  trace_pipe would be." ;-)

-- Steve

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
> +
> +                fd = open(TRACE_PIPE_RAW, O_RDONLY | O_NONBLOCK);
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
> +                printf("entries:        %llu\n", meta->entries);
> +                printf("overrun:        %llu\n", meta->overrun);
> +                printf("read:           %llu\n", meta->read);
> +                printf("nr_subbufs:     %u\n", meta->nr_subbufs);
> +
> +                data_len = meta->subbuf_size * meta->nr_subbufs;
> +                data = mmap(NULL, data_len, PROT_READ, MAP_SHARED, fd, meta_len);
> +                if (data == MAP_FAILED)
> +                        exit(EXIT_FAILURE);
> +
> +                if (ioctl(fd, TRACE_MMAP_IOCTL_GET_READER) < 0)
> +                        exit(EXIT_FAILURE);
> +
> +                reader_id = meta->reader.id;
> +                reader = data + meta->subbuf_size * reader_id;
> +
> +                printf("Current reader address: %p\n", reader);
> +
> +                munmap(data, data_len);
> +                munmap(meta, meta_len);
> +                close (fd);
> +
> +                return 0;
> +        }


