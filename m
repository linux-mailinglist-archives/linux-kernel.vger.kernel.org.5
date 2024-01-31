Return-Path: <linux-kernel+bounces-47371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC24844CED
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2004A2844F7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A8A140792;
	Wed, 31 Jan 2024 23:23:41 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D03614076C;
	Wed, 31 Jan 2024 23:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706743420; cv=none; b=l5NOPHrGJb5GSUm6V/ssPMxboh4dDBNuBzSzFoxg6x3s4OKYmT9nAfUueeLlZOhKGfq9JO5vSukMwD8cMHmZTVJoetcDCuzejup4phs7ZiSrygUpXa/scbkwfvNejH+UN+np4aCau4/3enAcb2mYrORl1Rt43NqsMt6QvEPXR9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706743420; c=relaxed/simple;
	bh=3xWEQWDeUUBk62LEoweFcda4fCmmQIdemLYVAtcazM0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gl9wQxpm9Aop3a7QI6OTrqbmRfJHGXgoA11qwPiYvF9IXzD/mmhXMUFzjB8EQpgHNOlRiI95E/YPZKt7I8LPPViAUY0HkXwxDQ6FVuvXHDMQue53N0CWEMdwviLzu/Ei+3fcmCYe87qh2cNVgZe8/bfxmT+w0PerHVDxfEKDEv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80634C433F1;
	Wed, 31 Jan 2024 23:23:39 +0000 (UTC)
Date: Wed, 31 Jan 2024 18:23:54 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] eventfs: clean up dentry ops and add revalidate
 function
Message-ID: <20240131182354.6815a2fa@gandalf.local.home>
In-Reply-To: <20240201080715.80fadd15f38396c95bf39a00@kernel.org>
References: <20240130190355.11486-1-torvalds@linux-foundation.org>
	<20240130190355.11486-6-torvalds@linux-foundation.org>
	<20240131130039.241c8978@gandalf.local.home>
	<20240201080715.80fadd15f38396c95bf39a00@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 1 Feb 2024 08:07:15 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > Then tracefs could be nicely converted over to kernfs, and eventfs would be
> > its own entity.  
> 
> If so, maybe we can just make symlinks to the 'id' and 'format' from events
> under tracefs? :)

I don't think that will save anything. The files currently do not allocate
any memory. If we make symlinks, we need to allocate a path, to them. I
think that would be rather difficult to do. Not to mention, that could
cause a lot of breakage. What do you do if the other filesystem isn't
mounted?

I could possibly make a light way handle to pass back to the callbacks.

struct trace_event_light {
	unsigned long			flags
	struct trace_event_call		*event_call;
};

struct trace_event_file {
	struct trace_event_light	call;
	[..]
	// Remove he flags and event_call and have it above
};

if the callback data has:

 callback(..., void **data)
 {
	struct trace_event_light *call = *data;
	struct trace_event_file *file;

	If (strcmp(name, "id") == 0 || strcmp(name, "format") == 0) {
		*data = call->event_call;
		return 1;
	}

	/* Return if this is just a light data entry */
	if (!(data->flags & TRACE_EVENT_FULL))
		return 0;

	file = container_of(data, struct trace_event_file, call);

	// continue processing the full data
}

This way the lonely eventfs could still share a lot of the code.

-- Steve

