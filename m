Return-Path: <linux-kernel+bounces-91463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B978711DC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E610283A2C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2EE5382;
	Tue,  5 Mar 2024 00:41:56 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F687F
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 00:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709599316; cv=none; b=gNv71uf8ALI46JFBmwxjpAzNFAAOioREvyi+w0iuB/nA560k7pKWkzNTtEc3yMS3DMeXD+9lC4WJrm0mrjJyc4t6oS3UPha0CsK4vZzzIgnR/bKsMk4GQoOy1//FNX+SgO0zDDScUNxGfA7YBp2nkM669GwXTyGX+9Fw5M+4vk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709599316; c=relaxed/simple;
	bh=Dc18/apb56vqF2V4XntLx89qjNsL7O94p6W8krjQ2+I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V4luMyP8Lt70xugngLqGk0NEFqSCAOntFpc2SRXLAu1wvisDVwr9mChTX4NnatKkwZ+ZydLSBRL/XdaZSPpSsjqIwR3ZjjUMvJZfT3SOAcziFADTWUjZ7xlRjjmcJ7ClQ8dxBDucN3wYYfvGCMUYQulYuU7MDLelSXJMfEX5vc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE5DFC433C7;
	Tue,  5 Mar 2024 00:41:54 +0000 (UTC)
Date: Mon, 4 Mar 2024 19:43:43 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Sachin Sant <sachinp@linux.ibm.com>
Subject: Re: [GIT PULL] tracing: Prevent trace_marker being bigger than
 unsigned short
Message-ID: <20240304194343.57a6a541@gandalf.local.home>
In-Reply-To: <CAHk-=wgR7NrXTk8rJbWEv0PBN5z8kbyWaWqKO_UDnK1DXoSbqg@mail.gmail.com>
References: <20240302111244.3a1674be@gandalf.local.home>
	<20240302145958.05aabdd2@rorschach.local.home>
	<CAHk-=wgjhdRj1V847NTF4veMN_tCbrySiEHXO8RO3n05cNeXeA@mail.gmail.com>
	<20240302154713.71e29402@rorschach.local.home>
	<CAHk-=wioeo5vyEWUZcGBKMsf3jnjrnnHc3uJiV=JjSKPdvZOEw@mail.gmail.com>
	<20240303075937.36fc6043@rorschach.local.home>
	<CAHk-=wiLdWetJgKHB72VeDALZsjpggEyyuiZ2KmoY_g+3horwQ@mail.gmail.com>
	<20240303140705.0f655e36@rorschach.local.home>
	<CAHk-=wiTGmAXfHiRB8ku4diLxRpN=Hac_q86=j65oiP3J5uXKg@mail.gmail.com>
	<20240303160024.458d4f91@rorschach.local.home>
	<20240304164205.3245608a@gandalf.local.home>
	<CAHk-=wgwy-p_zodT0JvkVkkd5MWy9NffC3jiDiczMMHPj1eQ9w@mail.gmail.com>
	<20240304171034.08d037aa@gandalf.local.home>
	<CAHk-=wi53cJEKim7UvUXtdhQG1BR7oU5TABPXaOq5SmBKLSKYg@mail.gmail.com>
	<20240304184725.55449e70@gandalf.local.home>
	<20240304185241.7ce42097@gandalf.local.home>
	<CAHk-=wgR7NrXTk8rJbWEv0PBN5z8kbyWaWqKO_UDnK1DXoSbqg@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Mar 2024 16:17:15 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, 4 Mar 2024 at 15:50, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > But this still isn't fixing anything. It's just adding a limit.  
> 
> Limiting things to a common maximum size is a good thing. The kernel
> limits much  more important things for very good reasons.
> 
> The kernel really shouldn't have big strings. EVER.  And it literally
> shows in our kernel infrastructure. It showed in that vsnprintf
> precision thing. It shows in our implementation choices, where we tend
> to have simplistic implementations because doing things a byte at a
> time is simple and cheap when the strings are limited in size (and we
> don't want fancy and can't use vector state anyway).
> 
> If something as core as a pathname can be limited to 4kB, then
> something as unimportant as a trace string had better be limited too.
> Because we simply DO NOT WANT to have to deal with longer strings in
> the kernel.
> 

So I made three patches that do basically what you want. And as a bonus,
it's not really an arbitrary limit but based on trace_seq size.

The first patch will be removing the precision check, as that's not needed.

The second patch is to remove the dependency between trace_seq and
PAGE_SIZE, as its size really can just be 8K for all architectures. Which
has the side effect of limiting the size of trace_marker, as its size is
limited by the trace_seq size.

Finally, because the trace_seq defines the max output that a trace_event
can write (for all its fields), the extra data of a print event could
possibly overflow that, which will cause the event not to print, and just
an "OVERFLOW" output would show in the trace buffer. So I used the
TRACE_SEQ_SIZE / 2 as the max size that trace_marker can read, which
happens to be 4K.

-- Steve

