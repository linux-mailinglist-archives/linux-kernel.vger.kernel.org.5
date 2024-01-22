Return-Path: <linux-kernel+bounces-34095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6FD837359
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E58C228D843
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DEFC3FE57;
	Mon, 22 Jan 2024 19:57:53 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB6B38DF1
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 19:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705953472; cv=none; b=GEjCCF6TynYGxW+Z/dTUMMwTpP2+7nOMi/8MVrg05q6CmoTaDl9ZW6se7DuX+OOyNWdvRgNyKF4+apmUNR5+wPIe+xcGXs20RE/NKhoHn+eUz22/e9tSkL+TOK0akfM4OgJ+3jtYWb9VQAyo5/W/Jw5HivNlaEYFez9TYXuo2nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705953472; c=relaxed/simple;
	bh=yAPKDGQ0abWDeOmysxwknKnzQPzEDD1iGHrk0yXei8w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W7n1vtgwTPUxoqPhukS1xeRhPmLGvojpa8Ju9IpZdp5T3sw4GkdSe6r2JRhGWlvqnVh9ImG5uvddTV0Hub+YwELWeCJXKQW1+AW85vDkFEnjnSrzDCO9BtvEVdlUM4lxwgbc48TV/NtF5uS95eM2/RNLSbGGQuXjut6h720q9xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD866C433F1;
	Mon, 22 Jan 2024 19:57:50 +0000 (UTC)
Date: Mon, 22 Jan 2024 14:59:19 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Kees Cook
 <keescook@chromium.org>, Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Andrew Morton <akpm@linux-foundation.org>,
 Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Ajay Kaher <ajay.kaher@broadcom.com>
Subject: Re: [for-linus][PATCH 1/3] eventfs: Have the inodes all for files
 and directories all be the same
Message-ID: <20240122145919.3eb8f9b9@gandalf.local.home>
In-Reply-To: <c8982677-64bf-4078-be1a-e5e18c35ecb4@efficios.com>
References: <20240117143548.595884070@goodmis.org>
	<20240117143810.531966508@goodmis.org>
	<CAMuHMdXKiorg-jiuKoZpfZyDJ3Ynrfb8=X+c7x0Eewxn-YRdCA@mail.gmail.com>
	<20240122100630.6a400dd3@gandalf.local.home>
	<ccc4234d-8a47-4c0f-808a-95e61c9c9171@efficios.com>
	<20240122125004.7bbf0b70@gandalf.local.home>
	<c8982677-64bf-4078-be1a-e5e18c35ecb4@efficios.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jan 2024 13:35:43 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> > When an inode is no longer referenced, it is freed. When it is referenced
> > again, I want it to be recreated with the same inode number it had
> > previously. How would having a bitmask help with that? I need a way to map
> > an ei structure with a unique number without adding another 4 bytes to the
> > structure itself.  
> 
> As discussed in a separate exchange with Linus, why do you care so much about
> not adding a 4 bytes field to the structure ?

I'm trying to keep the memory overhead of tracing down as much as possible.
4 bytes for 2000 events (and growing) just adds to the memory footprint of
tracing.

And an eventfs_inode is the link between control of an event per instance.
Thus, it may only be 8k for those 2000 events, but that's another 8k for
each instance you use. You make 10 instances, that is now 80k.

This is used in embedded systems as well, so every byte counts.

But as Linus pointed out, the issue is moot, as the structure ends with a
single 32bit int. And on 64 bit machines, there's likely a 4 byte hole that
we can use there.

-- Steve

