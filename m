Return-Path: <linux-kernel+bounces-98019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93735877368
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 19:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42ABC1F2127F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 18:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A18C4AEFE;
	Sat,  9 Mar 2024 18:51:22 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A2416FF30;
	Sat,  9 Mar 2024 18:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710010281; cv=none; b=qUjcw/sT73oxjiy5nPKjF7dxVV0bRp+8wnN2d1rLVv3d4uIc5R8uS11aQ2U+/unnzkjHCpYD9rVssggFmZ4OIvFhKmeDr/sOyBousXAieJulJoPiZXLL9iMSfcWV9NcM7/4Xx8Tqi+dWaw/Z3V5HgMNF8UVIXTXmv82giVwuVpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710010281; c=relaxed/simple;
	bh=RU7c3Ybwu4VytLTCKkoUrNCeajIFFkwaiL3jPhLJEgE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j9XduKBVXdZ4XaEjPaPm4lT61kHUchqSjoN5US2Z53I8zzN2TGnrCn5M6qIIS9ywlU2sm618vPZ9MF1GFEdkhYfqP8NZ/YK5YUl9rPOJqNwM1RX2EV17WDpBwzB7DPPOOEatKQRhKQ+vOx+m0rekhBwP0fKz98rH5kYbTjYre5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3BEBC433F1;
	Sat,  9 Mar 2024 18:51:18 +0000 (UTC)
Date: Sat, 9 Mar 2024 13:51:16 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Joel
 Fernandes <joel@joelfernandes.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Vincent Donnefort <vdonnefort@google.com>,
 Daniel Bristot de Oliveira <bristot@redhat.com>, Ingo Molnar
 <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 suleiman@google.com, Thomas Gleixner <tglx@linutronix.de>, Vineeth Pillai
 <vineeth@bitbyteword.org>, Youssef Esmat <youssefesmat@google.com>, Beau
 Belgrave <beaub@linux.microsoft.com>, Alexander Graf <graf@amazon.com>,
 Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>, "Paul E.
 McKenney" <paulmck@kernel.org>, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 0/8] tracing: Persistent traces across a reboot or crash
Message-ID: <20240309135116.40f65cee@rorschach.local.home>
In-Reply-To: <202403091016.5CDF0E2EE@keescook>
References: <20240306015910.766510873@goodmis.org>
	<202403091016.5CDF0E2EE@keescook>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 9 Mar 2024 10:27:47 -0800
Kees Cook <keescook@chromium.org> wrote:

> On Tue, Mar 05, 2024 at 08:59:10PM -0500, Steven Rostedt wrote:
> > This is a way to map a ring buffer instance across reboots.  
> 
> As mentioned on Fedi, check out the persistent storage subsystem
> (pstore)[1]. It already does what you're starting to construct for RAM
> backends (but also supports reed-solomon ECC), and supports several
> other backends including EFI storage (which is default enabled on at
> least Fedora[2]), block devices, etc. It has an existing mechanism for
> handling reservations (including via device tree), and supports multiple
> "frontends" including the Oops handler, console output, and even ftrace
> which does per-cpu recording and event reconstruction (Joel wrote this
> frontend).

Mathieu was telling me about the pmem infrastructure.

This patch set doesn't care where the memory comes from. You just give
it an address and size, and it will do the rest.

> 
> It should be pretty straight forward to implement a new frontend if the
> ftrace one isn't flexible enough. It's a bit clunky still to add one,
> but search for "ftrace" in fs/pstore/ram.c to see how to plumb a new
> frontend into the RAM backend.
> 
> I continue to want to lift the frontend configuration options up into
> the pstore core, since it would avoid a bunch of redundancy, but this is
> where we are currently. :)

Thanks for the info. We use pstore on ChromeOS, but it is currently
restricted to 1MB which is too small for the tracing buffers. From what
I understand, it's also in a specific location where there's only 1MB
available for contiguous memory.

I'm looking at finding a way to get consistent memory outside that
range. That's what I'll be doing next week ;-)

But this code was just to see if I could get a single contiguous range
of memory mapped to ftrace, and this patch set does exactly that.

> 
> -Kees
> 
> [1] CONFIG_PSTORE et. al. in fs/pstore/ https://docs.kernel.org/admin-guide/ramoops.html
> [2] https://www.freedesktop.org/software/systemd/man/latest/systemd-pstore.service.html
> 

Thanks!

-- Steve

