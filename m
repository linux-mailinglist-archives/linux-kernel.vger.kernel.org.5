Return-Path: <linux-kernel+bounces-48136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E53198457DB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A05692903F1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41BB5B697;
	Thu,  1 Feb 2024 12:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSbyEQTE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2221E5B675;
	Thu,  1 Feb 2024 12:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706790611; cv=none; b=cOi3fDsdaBmAjuigsLYWGyAJ+s4yyQRLPce8UKRI2IGLytK+6XQ78BJ+ipYVidoW6Fpiruhq3y81ZZXmvRqTgd4P527GZwuElJpsfmRRWmvn2k2wBwQvzfT9jrNXPNVZSFqletExVX5ysed3fZuOvfdqvFIrhj8Ds/ssC3gRKwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706790611; c=relaxed/simple;
	bh=rmELVqCs4ikLv5jAKdVyJAPps8W0PUgMVeUUwWBQpRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XTo2jrgKkR3zlIehD5+3YsldHDEb59+BrOsk6UHYz9JrWa7IQhzvpOAMbx2Rd1oU2wAj5tzWJ3mF2GDjfGAVgoa0DncypUbTRuOf4V3W5qb5ASIhoUWRwPl7NJPUk+kMxu1npay6iAgQzrV6EchfCbWCZcMADdfVSBWoDJqV0Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSbyEQTE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 307BFC43390;
	Thu,  1 Feb 2024 12:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706790610;
	bh=rmELVqCs4ikLv5jAKdVyJAPps8W0PUgMVeUUwWBQpRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lSbyEQTE218AJfS4lkow46hitJEmhR5LoGoOpATK3DKPCzy5hzHLI+gdkNeZbs+Rs
	 CCFzznShBjxWnlYLytIa3ixKjNyGnjrtytdXMJT83kc7YjVo8fRVu0Mf/s5cOpNdp8
	 wnxVcMYCn6jz5T6Dc+q0j9c0EP6nkQujGTgf7zVRUTlfNWQ48DjIKa0XHkEQ4Yooe6
	 l1F1sjaWr5p4MHoWlSAN+ES1/NMIQudiol59cskF0zdDdr6ZPHhACbNUK929adYcv6
	 oZKZz+OazSSUeU0jNaxQddyOnPe0INtR9310oL8WCZVQdhxsYXxlzgRtvYKNwOHSvV
	 ov8+bMzc5WNmQ==
Date: Thu, 1 Feb 2024 12:30:04 +0000
From: Lee Jones <lee@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Crutcher Dunnavant <crutcher+kernel@datastacks.com>,
	Juergen Quade <quade@hsnr.de>,
	David Laight <David.Laight@aculab.com>
Subject: Re: [PATCH v3 1/1] lib/vsprintf: Implement spprintf() to catch
 truncated strings
Message-ID: <20240201123004.GA938078@google.com>
References: <20240130160953.766676-1-lee@kernel.org>
 <ZbuFSIIGbfhXeP92@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZbuFSIIGbfhXeP92@smile.fi.intel.com>

On Thu, 01 Feb 2024, Andy Shevchenko wrote:

> On Tue, Jan 30, 2024 at 04:09:53PM +0000, Lee Jones wrote:
> > There is an ongoing effort to replace the use of {v}snprintf() variants
> > with safer alternatives - for a more in depth view, see Jon's write-up
> > on LWN [0] and/or Alex's on the Kernel Self Protection Project [1].
> > 
> > Whist executing the task, it quickly became apparent that the initial
> > thought of simply s/snprintf/scnprintf/ wasn't going to be adequate for
> > a number of cases.  Specifically ones where the caller needs to know
> > whether the given string ends up being truncated.  This is where
> > spprintf() comes in, since it takes the best parts of both of the
> > aforementioned variants.  It has the testability of truncation of
> > snprintf() and returns the number of Bytes *actually* written, similar
> > to scnprintf(), making it a very programmer friendly alternative.
> > 
> > Here's some examples to show the differences:
> > 
> >   Success: No truncation - all 9 Bytes successfully written to the buffer
> > 
> >     ret = snprintf (buf, 10, "%s", "123456789");  // ret = 9
> >     ret = scnprintf(buf, 10, "%s", "123456789");  // ret = 9
> >     ret = spprintf (buf, 10, "%s", "123456789");  // ret = 9
> > 
> >   Failure: Truncation - only 9 of 10 Bytes written; '-' is truncated
> > 
> >     ret = snprintf (buf, 10, "%s", "123456789---"); // ret = 12
> > 
> >       Reports: "12 Bytes would have been written if buf was large enough"
> >       Issue: Too easy for programmers to assume ret is Bytes written
> > 
> >     ret = scnprintf(buf, 10, "%s", "123456789---"); // ret = 9
> > 
> >       Reports: "9 Bytes actually written"
> >       Issue: Not testable - returns 9 on success AND failure (see above)
> > 
> >     ret = spprintf (buf, 10, "%s", "123456789---"); // ret = 10
> > 
> >       Reports: "Data provided is too large to fit in the buffer"
> >       Issue: No tangible impact: No way to tell how much data was lost
> > 
> > Since spprintf() only reports the total size of the buffer, it's easy to
> > test if they buffer overflowed since if we include the compulsory '\0',
> > only 9 Bytes additional Bytes can fit, so the return of 10 informs the
> > caller of an overflow.  Also, if the return data is plugged straight
> > into an additional call to spprintf() after the occurrence of an
> > overflow, no out-of-bounds will occur:
> > 
> >     int size = 10;
> >     char buf[size];
> >     char *b = buf;
> > 
> >     ret = spprintf(b, size, "1234");
> >     size -= ret;
> >     b += ret;
> >     // ret = 4  size = 6  buf = "1234\0"
> > 
> >     ret = spprintf(b, size, "5678");
> >     size -= ret;
> >     b += ret;
> >     // ret = 4  size = 2  buf = "12345678\0"
> > 
> >     ret = spprintf(b, size, "9***");
> >     size -= ret;
> >     b += ret;
> >     // ret = 2  size = 0  buf = "123456789\0"
> > 
> > Since size is now 0, further calls result in no changes of state.
> > 
> >     ret = spprintf(b, size, "----");
> >     size -= ret;
> >     b += ret;
> >     // ret = 0  size = 0  buf = "123456789\0"
> 
> > [0] https://lwn.net/Articles/69419/
> > [1] https://github.com/KSPP/linux/issues/105
> 
> Link: ... [0]
> Link: ... [1]

OOI, what does that do?

Does tooling pick-up on them?

These links are for humans.

Is there documentation I can go look at?

> > Signed-off-by: Lee Jones <lee@kernel.org>
> 
> ...
> 
> I'm a bit late in this discussion, but the commit message doesn't spit a single
> word on why seq_buf() approach can't be used in those cases?

When I can carve out a little more free time, investigating seq_buf() is
the next step.

-- 
Lee Jones [李琼斯]

