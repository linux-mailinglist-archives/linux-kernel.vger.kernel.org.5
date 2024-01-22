Return-Path: <linux-kernel+bounces-33858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8161836FA3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7730E2867D2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5DC48CD3;
	Mon, 22 Jan 2024 17:48:38 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB20548CC1
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 17:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705945717; cv=none; b=bnP9vv1h9qm07P7A2flle5VuKjiy+APSYFVhwlZ7lDiKPp87YcVv76aoSRWIMA5WYXC72jmKxsm0gvxJLX1tLHapfzy+Av65yBBlUeBR1XzOkuzu47MMkq7pm7ni7Qlrg4AluNGX0sY7f2vCXTL+2gfari/MDDZ9MUHZvLCW27E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705945717; c=relaxed/simple;
	bh=3F3G5Ww1SUZQsUMoJIkzqcCLWxQapyaD7dFyElSipKM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GtJi/W0hQfmbxUC09e2E+7hLIU4K5ZxY8zaSaY0xYwjZ5dJFiOpwr0kzfAB/OTlmZxzKlFTnagKSBnB0cVJ1Qm/kztjvNngGKcMfZFPv7TXXhUf0QEMl34QZ4tLWNUhYB3RwjHaJWeucIyjsD7HpKDApx/KhyTtZt3PgmYlmbqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E05E7C433F1;
	Mon, 22 Jan 2024 17:48:35 +0000 (UTC)
Date: Mon, 22 Jan 2024 12:50:04 -0500
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
Message-ID: <20240122125004.7bbf0b70@gandalf.local.home>
In-Reply-To: <ccc4234d-8a47-4c0f-808a-95e61c9c9171@efficios.com>
References: <20240117143548.595884070@goodmis.org>
	<20240117143810.531966508@goodmis.org>
	<CAMuHMdXKiorg-jiuKoZpfZyDJ3Ynrfb8=X+c7x0Eewxn-YRdCA@mail.gmail.com>
	<20240122100630.6a400dd3@gandalf.local.home>
	<ccc4234d-8a47-4c0f-808a-95e61c9c9171@efficios.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jan 2024 12:14:36 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> 
> Why use an improvised hashing function (re-purposed from
> scripts/kconfig/symbol.c to a use-case which is exposed through a

That hash is just salt to the real hash function, which is the
siphash_1u32(). I added the name hash so that each file will get a little
different salt to the hash.

The siphash_1u32() is what the rest of the kernel uses for hashing kernel
address space.

> userspace ABI prone to kernel address leaks) rather than simply
> reserving values by setting bits in a bitmap ?
> 
> How many inodes do we realistically expect to have there ?

If I only do directories, it is actually significantly less.

> 
> On my 6.1.0 kernel:
> 
> find /sys/kernel/tracing | wc -l
> 15598
> 
> (mainly due to TRACE_EVENT ABI files)
> 
> Hashing risks:
> 
> - Exposing kernel addresses if the hashing algorithm is broken,

Well this was my biggest concern, but if I truncate at least a nibble, with
the unique salt to the algorithm for each file, how easily does that expose
kernel addresses.

The ei itself, is created from kmalloc() so you would at best get a heap
address. But with the missing nibble (if I mask it with ((1 << 28) - 1),
and much more taken away for 64 bit systems), and the added unique salt, is
it possible for this to expose anything that could be used in an attack?

> - Collisions if users are unlucky (which could trigger those
>    'find' errors).
> 
> Those 15598 inode values fit within a single page (bitmap of
> 1922 bytes).
> 
> So I would recommend simply adding a bitmap per tracefs filesystem
> instance to keep track of inode number allocation.

And how do I recover this bit after the inode is freed, but then referenced
again?

> 
> Creation/removal of files/directories in tracefs should not be
> a fast-path anyway, so who cares about the speed of a find first
> bit within a single page ?
> 

When an inode is no longer referenced, it is freed. When it is referenced
again, I want it to be recreated with the same inode number it had
previously. How would having a bitmask help with that? I need a way to map
an ei structure with a unique number without adding another 4 bytes to the
structure itself.

-- Steve

