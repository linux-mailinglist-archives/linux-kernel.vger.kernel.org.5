Return-Path: <linux-kernel+bounces-24831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC6E82C326
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 16:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95D9DB229E1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6F26EB7B;
	Fri, 12 Jan 2024 15:57:52 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF106EB6E;
	Fri, 12 Jan 2024 15:57:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61562C433C7;
	Fri, 12 Jan 2024 15:57:50 +0000 (UTC)
Date: Fri, 12 Jan 2024 10:58:55 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, mhiramat@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 kernel-team@android.com
Subject: Re: [PATCH v11 2/5] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <20240112105855.7f4c290d@gandalf.local.home>
In-Reply-To: <20240112100641.3675edad@gandalf.local.home>
References: <20240111161712.1480333-1-vdonnefort@google.com>
	<20240111161712.1480333-3-vdonnefort@google.com>
	<c3dba53f-66de-43f5-9b82-38aa807da67a@efficios.com>
	<20240111181814.362c42cf@gandalf.local.home>
	<ZaECnv7EJHo6sqcT@google.com>
	<20240112100641.3675edad@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jan 2024 10:06:41 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> I'm thinking both may be good, as the number of dropped events are not
> added if there's no room to put it at the end of the ring buffer. When
> there's no room, it just sets a flag that there was missed events but
> doesn't give how many events were missed.
> 
> If anything, it should be in both locations. In the sub-buffer header, to
> be consistent with the read/splice version, and in the meta page were if
> there's no room to add the count, it can be accessed in the meta page.

I think  the meta data page should look like this:

struct trace_buffer_meta {
	__u32		meta_page_size;
	__u32		meta_struct_len;
 
	__u32		subbuf_size;
	__u32		nr_subbufs;
 
	struct {
		__u64		lost_events;
		__u32		id;
		__u32		read;
	} reader;
 
	__u64	entries;
	__u64	overrun;
	__u64	read;

};

1) meta_page_size

      The size of this meta page. It's the first thing the application
      needs to know how much to mmap.

2) meta_struct_len

      The actual length of the structure. It's the second thing the
      application will look at to know what version it is dealing with.

3) subbuf_size
4) nr_subbufs

      The next two is the next thing the application should do. That is to
      memory map in all the sub-buffers. With 1) and this, it knows how to
      do that.

The first four are needed for setup, and never changes once mapped. The
rest gets updated during the trace.

5) reader
  5a) lost_events
  5b) id
  5c) read

      This is actively needed during tracing. It is what is used to know
      where and how to read the reader sub-buffer.

6) entries
7) overrun
8) read

      These are useful statistics, but probably seldom really looked at.
      They should be at the end.

Also notice that I converted all "unsigned long" to __u64. This is because
it is possible to have a 32 bit userspace running this on top of a 64 bit
kernel. If we were to use "long" it would be inconsistent and buggy.

Now if you need subbufs_touched and subbufs_lost. When that gets opened, it
would update the  meta_struct_len accordingly, and the structure would look
like:

struct trace_buffer_meta {
	__u32		meta_page_size;
	__u32		meta_struct_len;
 
	__u32		subbuf_size;
	__u32		nr_subbufs;
 
	struct {
		__u64		lost_events;
		__u32		id;
		__u32		read;
	} reader;
 
	__u64	entries;
	__u64	overrun;
	__u64	read;

	__u64	subbufs_touched;
	__u64	subbufs_lost;
};


Make sense?

-- Steve

