Return-Path: <linux-kernel+bounces-62488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 020E585218E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CE0A1F229B1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB7B4EB42;
	Mon, 12 Feb 2024 22:39:30 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99734EB3A;
	Mon, 12 Feb 2024 22:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707777569; cv=none; b=Xqg5dFoQwzwgBaOi/8S8WyR7JTWl/fa09ZNPwjwtnSjViAsxn1RugObUMLPLOv1NjdpFR/J7eyROgnv5k4GGqzI+mt+w6Nhsvt6dM9O76CmA9tXE3SAda/XrZw+YnVnnobqxmFmZVOOyGMDRRJQVy5TdC3klsU/PoYX4WT9yBro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707777569; c=relaxed/simple;
	bh=chCgSI9YJkrGnYJm8WBzd/jHa1AAREfUA3WwG3qlx2U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OJJwnWzg59I6ME+x/w8mnU0IW/o0QYSKLoVI4Jk7QNLIeOnISZBXyoKypbOxJQEEJikNiVNyLPlZeM9u+ogcDB2J0xH2zy1AFMGUo/PDw0fbJtzqUSz1rXVaO3cKSAzRwvZn9fndDyitU4pFAFseKe4D9QZH6WQvcz9daowqVZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D304C433C7;
	Mon, 12 Feb 2024 22:39:28 +0000 (UTC)
Date: Mon, 12 Feb 2024 17:40:11 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Vincent Donnefort <vdonnefort@google.com>, Sven Schnelle
 <svens@linux.ibm.com>, Mete Durlu <meted@linux.ibm.com>, stable
 <stable@vger.kernel.org>
Subject: Re: [PATCH] tracing: Fix wasted memory in saved_cmdlines logic
Message-ID: <20240212174011.068211d9@gandalf.local.home>
In-Reply-To: <dfa253e01ba9164abdd47da489c2a3da5da5cc93.camel@linux.intel.com>
References: <20240208105328.7e73f71d@rorschach.local.home>
	<dfa253e01ba9164abdd47da489c2a3da5da5cc93.camel@linux.intel.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Feb 2024 14:08:29 -0800
Tim Chen <tim.c.chen@linux.intel.com> wrote:

> > Now, instead of saving only 128 comms by default, by using this wasted
> > space at the end of the structure it can save over 8000 comms and even
> > saves space by removing the need for allocating the other array.  
> 
> The change looks good to me code wise.  But it seems like we are still
> overallocating as we can now accommodate 8000 comms when 128
> was asked for.

That's because that memory is allocated regardless of if we only asked for
128. Why not use it?

> 
> Wonder if we can reduce the default ask to 127 comm so we don't have to
> go to the next page order?

The internal structure does power of 2 allocations, and is just a little
over 128k in size, causing 256k to be allocated, which leaves just under
128k of wasted memory. And on top of that, the old way even allocated
another array. So instead, since this is already allocated, we just use it.

Now I may add a way to also include the other counter too, so that we can
have both, and will make the default slightly smaller.

We have three arrays:

 map_pid_to_cmdline[] which is the bulk of the allocation.
 map_cmdline_to_pid[] - which is cmdline_num * sizeof(int)
 saved_cmdlines[] - which is cmdline_num * TASK_COMM_LEN(16).

The first one above is a static array, the second is a pointer, and the
third is the end of the structure that uses the rest of wasted space. Now,
instead of allocating the map_cmdline_to_pid[], we could add that at the
end.

The following patch drops the default down to 6000 (which is also more than
enough) but also saves from allocating another array.

-- Steve

diff --git a/kernel/trace/trace_sched_switch.c b/kernel/trace/trace_sched_switch.c
index e4fbcc3bede5..0c60e4bcdd31 100644
--- a/kernel/trace/trace_sched_switch.c
+++ b/kernel/trace/trace_sched_switch.c
@@ -201,7 +201,7 @@ static struct saved_cmdlines_buffer *allocate_cmdlines_buffer(unsigned int val)
 	int order;
 
 	/* Figure out how much is needed to hold the given number of cmdlines */
-	orig_size = sizeof(*s) + val * TASK_COMM_LEN;
+	orig_size = sizeof(*s) + val * (TASK_COMM_LEN + sizeof(int));
 	order = get_order(orig_size);
 	size = 1 << (order + PAGE_SHIFT);
 	page = alloc_pages(GFP_KERNEL, order);
@@ -212,16 +212,10 @@ static struct saved_cmdlines_buffer *allocate_cmdlines_buffer(unsigned int val)
 	memset(s, 0, sizeof(*s));
 
 	/* Round up to actual allocation */
-	val = (size - sizeof(*s)) / TASK_COMM_LEN;
+	val = (size - sizeof(*s)) / (TASK_COMM_LEN + sizeof(int));
 	s->cmdline_num = val;
 
-	s->map_cmdline_to_pid = kmalloc_array(val,
-					      sizeof(*s->map_cmdline_to_pid),
-					      GFP_KERNEL);
-	if (!s->map_cmdline_to_pid) {
-		free_saved_cmdlines_buffer(s);
-		return NULL;
-	}
+	s->map_cmdline_to_pid = (unsigned *)(s->saved_cmdlines + val * TASK_COMM_LEN);
 
 	s->cmdline_idx = 0;
 	memset(&s->map_pid_to_cmdline, NO_CMDLINE_MAP,

