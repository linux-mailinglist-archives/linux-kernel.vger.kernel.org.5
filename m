Return-Path: <linux-kernel+bounces-141543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 630D28A1F93
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 21:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15F1DB247DB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2521C17C7F;
	Thu, 11 Apr 2024 19:37:32 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A597B15E8C;
	Thu, 11 Apr 2024 19:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712864251; cv=none; b=cz6UTOYMnOSIqPRYCDrayoghOZ/8zQXvjVpIpzVGblXTUvR2uxMgNPFvq0xtPyjvrtMwnvJE7av+ceFm+wAh4/t0ZoXVUc612aK6PrS0MSjCDq8lt59qvUvyB0QKRfFzj+uaFA8MjwH4oTqvWRPolZLqAXMZGBqj1+KTyLrLx7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712864251; c=relaxed/simple;
	bh=MXL82c3Ra7Fc5A+1JlTwaXt8dbnThnQlOzHp9LZiTAA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=itwcf6jAMXR6HlWCv3/oIsxD5QnzbYZwEMbJbWVlyPizIhvGpNqnRBVGfxyvtauo0zdw0XUx6VTK5JZjGPXopk9Ji7bAxMvlr1pSQRCr/nbagGHrafRGibPhuVNbWA6tDphUaaFdPqOgAn5D36J+KOg+117Cfbmo1gk87NLipqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E0DC113CE;
	Thu, 11 Apr 2024 19:37:28 +0000 (UTC)
Date: Thu, 11 Apr 2024 15:40:07 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, Kees Cook <keescook@chromium.org>,
 Joel Fernandes <joel@joelfernandes.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-trace-kernel@vger.kernel.org"
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org"
 <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra
 <peterz@infradead.org>, "linux-hardening@vger.kernel.org"
 <linux-hardening@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>, Ross
 Zwisler <zwisler@google.com>, "wklin@google.com" <wklin@google.com>,
 Vineeth Remanan Pillai <vineeth@bitbyteword.org>, Suleiman Souhlal
 <suleiman@google.com>, Linus Torvalds <torvalds@linuxfoundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Subject: Re: [POC][RFC][PATCH 0/2] pstore/mm/x86: Add wildcard memmap to map
 pstore consistently
Message-ID: <20240411154007.5bdf8d95@gandalf.local.home>
In-Reply-To: <3391c693-cf54-526b-79a8-d565e7140947@igalia.com>
References: <20240409210254.660888920@goodmis.org>
	<20240409172358.34ea19f0@gandalf.local.home>
	<202404091519.B7B2221@keescook>
	<SJ1PR11MB608317E066B6B3390F55FCB1FC072@SJ1PR11MB6083.namprd11.prod.outlook.com>
	<3391c693-cf54-526b-79a8-d565e7140947@igalia.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Apr 2024 16:11:55 -0300
"Guilherme G. Piccoli" <gpiccoli@igalia.com> wrote:

> Thanks Steve! Like Kees, I've been wanting a consistent way of mapping
> some RAM for pstore for a while, without resorting to platform drivers
> like Chromebooks do...

Great!

> 
> The idea seems very interesting and helpful, I'll test it here. My only
> concern / "complain" is that it's currently only implemented for builtin
> ramoops, which is not the default in many distros (like Arch, Ubuntu,
> Debian). I read patch 2 (and discussion), so I think would be good to
> have that builtin helper implemented upfront to allow modular usage of
> ramoops.

What I think I could do is to have a check after memory is allocated to
copy the table mapping (in the heap) if it is filled. The reason I did it
this way was because it was the easiest way to save the label to address
memory before memory is initialized. I use a __initdata array (why waste
memory if it's hardly ever used).

But, after memory is initialized, we can check if the table has content,
and if so allocate a copy and store it there and use that table instead.
That would give modules a way to find the address as well.

-- Steve


