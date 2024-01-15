Return-Path: <linux-kernel+bounces-26251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F7C82DD85
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 17:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0391A1F227F4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB2717BAE;
	Mon, 15 Jan 2024 16:24:02 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D69717BA4;
	Mon, 15 Jan 2024 16:24:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E5FC433C7;
	Mon, 15 Jan 2024 16:24:00 +0000 (UTC)
Date: Mon, 15 Jan 2024 11:23:59 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 kernel-team@android.com
Subject: Re: [PATCH v11 2/5] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <20240115112359.65dcecbf@rorschach.local.home>
In-Reply-To: <20240115110938.613380ca@rorschach.local.home>
References: <20240111161712.1480333-1-vdonnefort@google.com>
	<20240111161712.1480333-3-vdonnefort@google.com>
	<20240115134303.1a673e37b8e7d35a33d8df52@kernel.org>
	<ZaVRO76JxaHjPwCi@google.com>
	<20240115110938.613380ca@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jan 2024 11:09:38 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> No. The ring buffer logic should not care if the user of it is swapping
> the entire ring buffer or not. It only cares if parts of the ring
> buffer is being swapped or not. That's not the level of scope it should
> care about. If we do not want a swap to happen in update_max_tr()
> that's not ring_buffer.c's problem. The code to prevent that from
> happening should be 100% in trace.c.

What needs to be done, and feel free to add this as a separate patch,
is to have checks where snapshot is used.

  (All errors return -EBUSY)

Before allowing mapping, check to see if:

 1) the current tracer has "use_max_tr" set.
 2) any event has a "snapshot" trigger set
 3) Any function has a "snapshot" command set

Fail if any of the above is true.

Also in reverse, if the buffer is mapped, then fail:

 1) a tracer being set that has "use_max_tr" set.
 2) a "snapshot" command being set on a function
 3) a "snapshot" trigger being set on an event.

For the last two, we may be able to get away with just a below as well.
Adding the tr->flags bit. We could also add a tr->snapshot count to
keep track of everything that is using a snapshot, and if that count is
non-zero, mapping fails.

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 2a7c6fd934e9..f534f74ae80f 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1175,6 +1175,12 @@ static void tracing_snapshot_instance_cond(struct trace_array *tr,
 		return;
 	}
 
+	if (tr->flags & TRACE_ARRAY_FL_MAPPED) {
+		trace_array_puts(tr, "*** BUFFER IS MEMORY MAPPED ***\n");
+		trace_array_puts(tr, "*** Can not use snapshot (sorry) ***\n");
+		return;
+	}
+
 	local_irq_save(flags);
 	update_max_tr(tr, current, smp_processor_id(), cond_data);
 	local_irq_restore(flags);


-- Steve

