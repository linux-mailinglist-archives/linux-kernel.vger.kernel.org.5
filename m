Return-Path: <linux-kernel+bounces-62087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6410D851B45
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96C261C217B6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4AB3EA6C;
	Mon, 12 Feb 2024 17:23:43 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A583E477;
	Mon, 12 Feb 2024 17:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707758622; cv=none; b=K+muL8TL/8Ngn1GFGDoZ4HaLlh+1NvBASKNH5zzBAEIW83h6QFdWBp2rbNgou/PfM3iHnGwKTVcPa4EaDgzK+qKhLK/j9IgwMBpErH/5KrHNtCw1dzlFCma1kZLyREc2NM9lEjUrzJkiKLW11JBuLhPDVQAGnYAezjr4utyUNi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707758622; c=relaxed/simple;
	bh=Xy89FyQ5S4TsTqUr35IOZ1Q0qHWjJDfL8WOhAJbBJIA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gYxOmA4VuQci9I1IRQ8iDW9uAJT9ARXB5CbV7ipyACZORMD54rc9BGN0Gb7R8Aw8/GN9+4lsMDXRxP5mExoQV8lLuNwazZyty+N2BXv+Ynj7LcWderE4ygjlIbvXrm8mGzL3rJLrjx5FfLrFwum96pxwGaApzkRIQ8++LsRQHX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98276C433B2;
	Mon, 12 Feb 2024 17:23:41 +0000 (UTC)
Date: Mon, 12 Feb 2024 12:24:23 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Vincent Donnefort
 <vdonnefort@google.com>, Sven Schnelle <svens@linux.ibm.com>, Mete Durlu
 <meted@linux.ibm.com>
Subject: Re: [PATCH v2] tracing: Fix wasted memory in saved_cmdlines logic
Message-ID: <20240212122423.52dc9ed0@gandalf.local.home>
In-Reply-To: <20240213004038.7fd10d2bd9f356c72100adcd@kernel.org>
References: <20240209063622.1f7b6d5f@rorschach.local.home>
	<20240213004038.7fd10d2bd9f356c72100adcd@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Feb 2024 00:40:38 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > Now, instead of saving only 128 comms by default, by using this wasted
> > space at the end of the structure it can save over 8000 comms and even
> > saves space by removing the need for allocating the other array.  
> 
> This looks good to me. So this will allocate the saved_cmdlines in page-size
> array instead of the power of two.

Once the size is greater than page-size, it still is a power of two ;-)

But I think you meant that it will be a reminder of extra data, and not a
power of two. Looking at the code, it didn't need to be a power of two as
the saved names were just in a ring buffer anyway. The recording of a PID
must be a power of two, as that is masked.

Basically we have three arrays. One for the PIDS that hold the index into the
COMM array. The COMM array really has no limitation. The PID array is
PID_MAX_DEFAULT. But PIDs can be more than PID_MAX_DEFAULT as that's just
the "default" setting. User space can increase it. I need to add a comment
to how this works, as there are three arrays:

 unsigned map_pid_to_cmdline[PID_MAX_DEFAULT + 1];

 /* The next two are allocated based on cmdline_num size */
 unsigned map_cmdline_to_pid[cmdline_num];
 char saved_cmdlines[cmdline_num][TASK_COMM_LEN];

map_pid_to_cmdline[task->pid & (PID_MAX_DEFAULT - 1)] = index into the other two arrays;

 [ Although I'm not sure I need that "+1" in the array. This code is ancient
   and I need to re-examine it. ]

To get back to the PID, you need the map_cmdline_to_pid[idx] which contains
the full PID. Really, that array is only needed if pid max is greater than
PID_MAX_DEFAULT (which I find is the case for most distros now).

To assign a new comm, we basically do:

	idx = map_pid_to_cmdline[pid & (PID_MAX_DEFAULT - 1)];
	if (idx == -1) {
		idx = // get next location in COMM ring buffer
		map_pid_to_cmdline[pid & (PID_MAX_DEFAULT - 1)] = idx;
	}
	map_cmdline_to_pid[idx] = pid;
	strcpy(saved_cmdlines[idx], task->comm);

And Mathieu pinged me about the non-commented use of that NO_CMDLINE_MAP
which is just -1. I have it as INT_MAX, but really maybe it should be -1U,
and add a comment around the memset().

> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks, but Linus already pulled this. But I have some patches to clean
this up a bit more.

-- Steve

