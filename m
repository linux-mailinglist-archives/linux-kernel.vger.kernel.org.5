Return-Path: <linux-kernel+bounces-13200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14222820114
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 19:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A81001F21B8F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 18:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E901912B9E;
	Fri, 29 Dec 2023 18:46:55 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC8E134A3;
	Fri, 29 Dec 2023 18:46:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC7A9C433C8;
	Fri, 29 Dec 2023 18:46:54 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rJHta-00000000Lxl-3pTK;
	Fri, 29 Dec 2023 13:47:46 -0500
Message-ID: <20231229184050.465784896@goodmis.org>
User-Agent: quilt/0.67
Date: Fri, 29 Dec 2023 13:40:50 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Vincent Donnefort <vdonnefort@google.com>
Subject: [RFC][PATCH 0/2] ring-buffer: Allow user space memorry mapping
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


I'm sending this to a wider audience, as I want to hear more
feedback on this before I accept it.

Vincent has been working on allowing the ftrace ring buffer to be
memory mapped into user space. This has been going on since
last year, where we talked at the 2022 Tracing Summit in London.

Vincent's last series can be found here:

   https://lore.kernel.org/linux-trace-kernel/20231221173523.3015715-1-vdonnefort@google.com/

But I'm posting these as these are what I now have in my queue.

I've tested these patches pretty thoroughly and they look good.
I even have a libtracefs API patch ready to implement this.

For testing, you can install:

 git://git.kernel.org/pub/scm/libs/libtrace/libtraceevent.git (version 1.8.1)

 git://git.kernel.org/pub/scm/libs/libtrace/libtracefs.git
  (latest branch of libtracefs)

Then apply:

  https://lore.kernel.org/all/20231228201100.78aae259@rorschach.local.home/

to libtracefs. And then build the samples:

  make samples

Which will create: bin/cpu-map

That you can use with:

  # trace-cmd start -e sched
  # bin/cpu-map 0

Which will output all the events in CPU 0 via the memory mapping if it is
supported by the kernel or else it will print at the start:

  "Was not able to map, falling back to buffered read"

If you want to see the source code for cpu-map, you have to look
at the man page ;-) The "make samples" will extract the example code
from the man pages and build them.

  Documentation/libtracefs-cpu-map.txt

The library API is rather simple, it just has:

 tracefs_cpu_open_mapped()
 tracefs_cpu_is_mapped()
 tracefs_cpu_map()
 tracefs_cpu_unmap()

Which will create a tracefs_cpu handle for reading. If it fails to
map, it just does a normal read.

Anyway, this email is not about the library interface, but more of
the kernel interface. And that is this:

First there's a "meta page" that can mapped via mmap() on the
trace_pipe_raw file (there's one trace_pipe_raw file per CPU):

        page_size = getpagesize();
        meta = mmap(NULL, page_size, PROT_READ, MAP_SHARED, fd, 0);

The meta will have a layout of:

struct trace_buffer_meta {
        unsigned long   entries;
        unsigned long   overrun;
        unsigned long   read;

        unsigned long   subbufs_touched;
        unsigned long   subbufs_lost;
        unsigned long   subbufs_read;

        struct {
                unsigned long   lost_events;    /* Events lost at the time of the reader swap */
                __u32           id;             /* Reader subbuf ID from 0 to nr_subbufs - 1 */
                __u32           read;           /* Number of bytes read on the reader subbuf */
        } reader;

        __u32           subbuf_size;            /* Size of each subbuf including the header */
        __u32           nr_subbufs;             /* Number of subbufs in the ring-buffer */

        __u32           meta_page_size;         /* Size of the meta-page */
        __u32           meta_struct_len;        /* Len of this struct */
};

The meta_page_size can grow if we need to (and then we can extend this
API if we need to). If the meta_page_size is greater than a page, it
should remap it:

        if (meta->meta_page_size > page_size) {
		int new_size = meta->meta_page_size;
                munmap(meta, page_size);
                meta = mmap(NULL, new_size, PROT_READ, MAP_SHARED, fd, 0);		}

Now the sub buffers of the ring buffer are mapped right after
the meta page. The can be added with:


	data_len = meta->subbuf_size * meta->nr_subbufs;
	data = mmap(NULL, data_len, PROT_READ, MAP_SHARED,
                          fd, meta->meta_page_size);

This maps all the ring buffer sub-buffers as well as the reader page.
The way this works is that the reader page is free to read from
user space and writer will only write to the other pages.

To get the reader page:

	subbuf = data + meta->subbuf_size * meta->reader.id;

Then you can load that into the libtraceevent kbuffer API:

	struct tep_handle *tep = tracefs_local_events(NULL);
	kbuf = tep_kbuffer(tep);
	kbuffer_load_subbuffer(kbuf, subbuf);

And use the kbuf descriptor to iterate the events.

When done with the reader page, the application needs to make an
ioctl() call:

	ioctl(fd, TRACE_MMAP_IOCTL_GET_READER);


This will swap the reader page with the head of the other pages,
and the old reader page is now going to be in the writable portion
of the ring buffer where the writer can write to it, but the
page that was swapped out becomes the new reader page. If there is
no data, then user space can check the meta->reader.id to see if
it changed or not. If it did not change, then there's no new data.

If the writer is still on that page, it acts the same as we do in
the kernel. It can still update that page and the begging of the
sub-buffer has the index of where the writer currently is on that
page.

All the mapped pages are read-only.

When the ring buffer is mapped, it cannot be resized or have its
sub-buffers resized. It is basically locked. Any splice system calls
on it will be copied instead of writing.

I think it will be possible to extend this to a way to avoid the
ioctl and have the reader just compare the content before and after,
but I'm not so worried about that right now.

As it is close to the merge window, I do not plan on pushing it into
6.8. But I do want it in 6.9. I believe it's currently ready as is, but I'm
willing to change it if someone comes up with a good argument to do
so.

Thanks!


Vincent Donnefort (2):
      ring-buffer: Introducing ring-buffer mapping functions
      tracing: Allow user-space mapping of the ring-buffer

----
 include/linux/ring_buffer.h     |   7 +
 include/uapi/linux/trace_mmap.h |  31 ++++
 kernel/trace/ring_buffer.c      | 382 +++++++++++++++++++++++++++++++++++++++-
 kernel/trace/trace.c            |  79 ++++++++-
 4 files changed, 495 insertions(+), 4 deletions(-)
 create mode 100644 include/uapi/linux/trace_mmap.h

