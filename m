Return-Path: <linux-kernel+bounces-44882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B7F84287A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D14D1C25DB8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202561272D4;
	Tue, 30 Jan 2024 15:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWd14fgN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5A28613E;
	Tue, 30 Jan 2024 15:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706630022; cv=none; b=InpQFRTL73QLChP5H9pJxcvYxHenAkoq5YMOFXK6Li5lvqwQwVfKchX72F83sd7CS2XqDgqaDPeZ/G312x0lIOgfh8ujSv6+Lf3qh5HwAvsbyk8hAgLVNXZl09tlvajAIdMdmxdqb7P4KhuWIztOLcgHvNSHBExehPnORQEZrGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706630022; c=relaxed/simple;
	bh=R+skgP9gYAOnJxpGZoCeIncWf1CrBc8RcUjjZVvJHHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFxg3oxKi5ZAr8pMapvkOd/8+xUwK3JIEkJF0ZCAcNavLnk4N/vFHAmsytRHwfR2qHouubop03NiRU2QZTWPEwDzPb7mW9LaXHSrMEu1Hb12LeL0x3GjubFmoD7PQoZTRkBsnFctwkc/lSzvvosRF1Is7vOnpiMNl87Jin+L+Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WWd14fgN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67585C433C7;
	Tue, 30 Jan 2024 15:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706630021;
	bh=R+skgP9gYAOnJxpGZoCeIncWf1CrBc8RcUjjZVvJHHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WWd14fgNauH0btT8LYpk58n2O3ZUTLfdNxSnN8E6uSrQXqwFcnvYIQ9dZVeQbASf3
	 8hTdYuN9SFrRniqbNzGLBQx80cp7Q8B+S1cp8XK22ouQmZyeE025DPnvBdEAZl7T4B
	 wnMrBWiUz4N1vh5s3B/or/2dSAEfxQkZuKHjvFF4PI2z4VFZzU0Oepa8n7WDQIP8bt
	 hFoVW2VU/4jh49FiUo8i7TUcDU0zYXBmcFa+mLgT0cyZV7BMKmMYKRCwYpFYzKGubB
	 Jb9mX+qFpH2AeJtjUh7JST1PRM369brANH1C0CbldVSUOEz4SDsoY20s0Ty79xnJTD
	 K2cYn4CszVaLA==
Date: Tue, 30 Jan 2024 15:53:36 +0000
From: Lee Jones <lee@kernel.org>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: David Laight <David.Laight@aculab.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Crutcher Dunnavant <crutcher+kernel@datastacks.com>,
	Juergen Quade <quade@hsnr.de>
Subject: Re: [PATCH 1/1] lib/vsprintf: Implement ssprintf() to catch
 truncated strings
Message-ID: <20240130155336.GA8551@google.com>
References: <20240125083921.1312709-1-lee@kernel.org>
 <a37e8071-32ac-4f5d-95e8-ddd2eb21edcd@rasmusvillemoes.dk>
 <20240125103624.GC74950@google.com>
 <54e518b6dd9647c1add38b706eccbb4b@AcuMS.aculab.com>
 <20240129092440.GA1708181@google.com>
 <7054dcbfb7214665afedaea93ce4dbad@AcuMS.aculab.com>
 <20240129095237.GC1708181@google.com>
 <20240130150721.GA692144@google.com>
 <79921f9a-2453-48ec-85db-e63a0958db1e@prevas.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <79921f9a-2453-48ec-85db-e63a0958db1e@prevas.dk>

On Tue, 30 Jan 2024, Rasmus Villemoes wrote:

> On 30/01/2024 16.07, Lee Jones wrote:
> > On Mon, 29 Jan 2024, Lee Jones wrote:
> > 
> >> On Mon, 29 Jan 2024, David Laight wrote:
> >>
> >>> ...
> >>>>> I'm sure that the safest return for 'truncated' is the buffer length.
> >>>>> The a series of statements like:
> >>>>> 	buf += xxx(buf, buf_end - buf, .....);
> >>>>> can all be called with a single overflow check at the end.
> >>>>>
> >>>>> Forget the check, and the length just contains a trailing '\0'
> >>>>> which might cause confusion but isn't going to immediately
> >>>>> break the world.
> >>>>
> >>>> snprintf() does this and has been proven to cause buffer-overflows.
> >>>> There have been multiple articles authored describing why using
> >>>> snprintf() is not generally a good idea for the masses including the 2
> >>>> linked in the commit message:
> >>>
> >>> snprintf() returns the number of bytes that would have been output [1].
> >>> I'm not suggesting that, or not terminating the buffer.
> >>> Just returning the length including the '\0' (unless length was zero).
> >>> This still lets the code check for overflow but isn't going to
> >>> generate a pointer outside the buffer if used to update a pointer.
> >>
> >> I see.  Well I'm not married to my solution.  However, I am convinced
> >> that the 2 solutions currently offered can be improved upon.  If you or
> >> anyone else has a better solution, I'd be more than happy to implement
> >> and switch to it.
> >>
> >> Let me have a think about the solution you suggest and get back to you.
> > 
> > Okay, I've written a bunch of simple test cases and results are
> > positive.  It seems to achieve my aim whilst minimising any potential
> > pitfalls.
> > 
> >  - Success returns Bytes actually written - no functional change
> >  - Overflow returns the size of the buffer - which makes the result
> >    a) testable for overflow
> >    b) non-catastrophic if accidentally used to manipulate later sizes
> 
> You are describing scnprintf(), which almost does exactly that. The last
> thing we need is another interface with almost identical semantics.

It does, which is why when I first centred my efforts on this task the
plan was to simply switch to it.  However, as I described in the commit
message:

  "Whist executing the task, it quickly became apparent that the initial
  thought of simply s/snprintf/scnprintf/ wasn't going to be adequate
  for a number of cases.  Specifically ones where the caller needs to
  know whether the given string ends up being truncated."

A great deal of callers want to know if the string they attempted to
form was successful.  A malformed string would lead to oddities in the
best cases and various device/probing/matching failures in the worst.

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
> 
> So here scnprint() would have returned 1, leaving size at 1. scnprintf()
> has the invariant that, for non-zero size, the return value is strictly
> less than that size, so when passed a size of 1, all subsequent calls
> return 0 (corresponding to the fact that all it could do was to write
> the '\0' terminator).
> 
> This pattern already exists, and is really the reason scnprint exists.
> Yes, scnprintf() cannot distinguish overflow from
> it-just-exactly-fitted. Maybe it would have been better to make it work
> like this, but I don't think there's a real use

There are real use-cases.  They are what brought me here.

> and we do have
> seq_buf() if one really wants an interface that can build a string
> piece-meal while keeping track of whether it ever caused overflow.

seq_buf_*() looks okay, but it's petty heavy requiring what looks like
the buffers to be initialised with an API call before use.  We're
looking for something more light weight.

scnprint() had clear safety centric improvements over snprintf() and
spprintf() adds an additional layer of return value checking on top of
that.

I'm not sure I understand the resistance to something which is needed
and has clear benefits over what presently exists just for the sake of a
few lines of code.  I'd be on board if it were change for the sake of
change, but the added flexibility and ease of use is evident.

-- 
Lee Jones [李琼斯]

