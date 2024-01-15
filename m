Return-Path: <linux-kernel+bounces-26351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8C682DEDC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 19:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD6222834CA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 18:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B90182BB;
	Mon, 15 Jan 2024 18:03:56 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FA7182A0;
	Mon, 15 Jan 2024 18:03:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 422C5C433F1;
	Mon, 15 Jan 2024 18:03:55 +0000 (UTC)
Date: Mon, 15 Jan 2024 13:03:53 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 kernel-team@android.com
Subject: Re: [PATCH v11 2/5] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <20240115130353.78a7a587@rorschach.local.home>
In-Reply-To: <ZaVrZWGgmBNbsNba@google.com>
References: <20240111161712.1480333-1-vdonnefort@google.com>
	<20240111161712.1480333-3-vdonnefort@google.com>
	<20240115134303.1a673e37b8e7d35a33d8df52@kernel.org>
	<ZaVRO76JxaHjPwCi@google.com>
	<20240115110938.613380ca@rorschach.local.home>
	<20240115112359.65dcecbf@rorschach.local.home>
	<ZaVrZWGgmBNbsNba@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jan 2024 17:29:09 +0000
Vincent Donnefort <vdonnefort@google.com> wrote:

> > 
> > What needs to be done, and feel free to add this as a separate patch,
> > is to have checks where snapshot is used.
> > 
> >   (All errors return -EBUSY)
> > 
> > Before allowing mapping, check to see if:
> > 
> >  1) the current tracer has "use_max_tr" set.
> >  2) any event has a "snapshot" trigger set
> >  3) Any function has a "snapshot" command set  
> 
> Could we sum-up this with a single check to allocate_snapshot? If that is
> allocated it's probably because we'll be using it?

Not always. It can be allocated at any time and never used.

I'd like to keep the allocation of the snapshot buffer agnostic to if
the buffer is mapped or not, especially since it can be allocated at
boot up and never used. Several of my boxes have "alloc_snapshot" on
the command line even though I don't always use it. But we could update
the output of reading the "snapshot" file to:

 ~# cat /sys/kernel/tracing/snapshot 
# tracer: nop
#
#
# ** Snapshot disabled due to the buffer being memory mapped **
#
# * Snapshot is freed *
#
# Snapshot commands:
# echo 0 > snapshot : Clears and frees snapshot buffer
# echo 1 > snapshot : Allocates snapshot buffer, if not already allocated.
#                      Takes a snapshot of the main buffer.
# echo 2 > snapshot : Clears snapshot buffer (but does not allocate or free)
#                      (Doesn't have to be '2' works with any number that
#                       is not a '0' or '1')

If it is allocated:

 ~# cat /sys/kernel/tracing/snapshot
# tracer: nop
#
# ** Snapshot disabled due to the buffer being memory mapped **
#
# * Snapshot is allocated *
#
# Snapshot commands:
# echo 0 > snapshot : Clears and frees snapshot buffer
# echo 1 > snapshot : Allocates snapshot buffer, if not already allocated.
#                      Takes a snapshot of the main buffer.
# echo 2 > snapshot : Clears snapshot buffer (but does not allocate or free)
#                      (Doesn't have to be '2' works with any number that
#                       is not a '0' or '1')


> 
> That would simply add the requirement to echo 0 > snapshot before starting the
> memory map?

I rather not depend on that. It just makes it more complex for why
mapping failed. If you get -EBUSY, it will be hard to know why.

> 
> The opposite could be to let tracing_alloc_snapshot_instance() fail whenever a
> mapping is in place?

Yes, that would fail if mapping is in place.

Because the snapshot being allocated can be something people want, as
it allows the snapshot to happen immediately when needed, I don't want
the fact that it is allocated to prevent mapping. As mapping may just
happen for a small period of time while an application is running.

-- Steve

